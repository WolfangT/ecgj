package;

import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.system.FlxSound;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

class PlayState extends FlxState {
	var _inCombat:Bool = false;
	var _combatHud:CombatHUD;
	var _hud:HUD;
	var _money:Int = 0;
	var _health:Int = 3;
	var _grpCoins:FlxTypedGroup<Coin>;
	var _player:Player;
	var _map:FlxOgmoLoader;
	var _mWalls:FlxTilemap;
	var _grpEnemies:FlxTypedGroup<Enemy>;
	var _sndCoin:FlxSound;
	var _ending:Bool;
	var _won:Bool;

	function placeEntities(entityName:String, entityData:Xml):Void {
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		if (entityName == "player") {
			_player.x = x;
			_player.y = y;
		} else if (entityName == "coin") {
			_grpCoins.add(new Coin(x + 4, y + 4));
		} else if (entityName == "badguy") {
			_grpEnemies.add(new Enemy(x + 4, y, Std.parseInt(entityData.get("etype"))));
		}
	}

	override public function create():Void {
		_sndCoin = FlxG.sound.load(AssetPaths.coin__wav);
		_map = new FlxOgmoLoader(AssetPaths.room_001__oel);
		_mWalls = _map.loadTilemap(AssetPaths.tiles__png, 16, 16, "walls");
		_mWalls.follow();
		_mWalls.setTileProperties(1, FlxObject.NONE);
		_mWalls.setTileProperties(2, FlxObject.ANY);
		_grpEnemies = new FlxTypedGroup<Enemy>();
		_player = new Player();
		_grpCoins = new FlxTypedGroup<Coin>();
		_map.loadEntities(placeEntities, "entities");
		_hud = new HUD();
		_combatHud = new CombatHUD();

		add(_mWalls);
		add(_grpEnemies);
		add(_grpCoins);
		add(_player);
		add(_hud);
		add(_combatHud);

		FlxG.camera.follow(_player, TOPDOWN, 1);

		super.create();
	}

	function playerTouchCoin(P:Player, C:Coin):Void {
		if (P.alive && P.exists && C.alive && C.exists) {
			C.kill();
			_money++;
			_hud.updateHUD(_health, _money);
			_sndCoin.play();
		}
	}

	function checkEnemyVision(e:Enemy):Void {
		if (_mWalls.ray(e.getMidpoint(), _player.getMidpoint())) {
			e.seesPlayer = true;
			e.playerPos.copyFrom(_player.getMidpoint());
		} else
			e.seesPlayer = false;
	}

	function playerTouchEnemy(P:Player, E:Enemy):Void {
		if (P.alive &&
			P.exists &&
			E.alive &&
			E.exists &&
			!E.isFlickering()) {
			startCombat(E);
		}
	}

	function startCombat(E:Enemy):Void {
		_inCombat = true;
		_player.active = false;
		_grpEnemies.active = false;
		_combatHud.initCombat(_health, E);
	}

	function doneFadeOut():Void {
		FlxG.switchState(new GameOverState(_won, _money));
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		if (_ending) {
			return;
		}
		if (!_inCombat) {
			FlxG.collide(_player, _mWalls);
			FlxG.overlap(_player, _grpCoins, playerTouchCoin);
			FlxG.collide(_grpEnemies, _mWalls);
			_grpEnemies.forEachAlive(checkEnemyVision);
			FlxG.overlap(_player, _grpEnemies, playerTouchEnemy);
		} else {
			if (!_combatHud.visible) {
				_health = _combatHud.playerHealth;
				_hud.updateHUD(_health, _money);
				if (_combatHud.outcome == DEFEAT) {
					_ending = true;
					FlxG.camera.fade(FlxColor.BLACK, .33, false, doneFadeOut);
				} else {
					if (_combatHud.outcome == VICTORY) {
						_combatHud.e.kill();
						if (_combatHud.e.etype == 1) {
							_won = true;
							_ending = true;
							FlxG.camera.fade(FlxColor.BLACK, .33, false, doneFadeOut);
						}
					} else {
						_combatHud.e.flicker();
					}
					_inCombat = false;
					_player.active = true;
					_grpEnemies.active = true;
				}
			}
		}
	}
}
