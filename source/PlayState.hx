package;

import flixel.FlxG;
import flixel.FlxState;
import entities.Entity;
import flixel.system.FlxAssets;
import flixel.FlxCamera;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState {
	public var level:TiledLevel;
	public var tmx_file:String;
	public var hud:HUD;

	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void {
		super.create();
		// detalles
		// FlxG.mouse.visible = false;
		FlxG.camera.setSize(FlxG.width, FlxG.height);
		// load level
		level = new TiledLevel(tmx_file);
		add(level.masterGroup);
		bgColor = level.backgroundColor;
		if (level.song != null)
			FlxG.sound.playMusic(FlxAssets.getSound("assets/music/" + level.song), 0.5, true);
		// load hud
		hud = new HUD();
		add(hud);
		// iniciar
		Reg.player.gifts = 3;
		Reg.player.balls = 1;
		FlxG.camera.follow(Reg.player, FlxCameraFollowStyle.PLATFORMER, 1);
		for (ent in level.entityLayer) {
			var entity:Entity = cast ent;
			entity.nacer();
		}
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		hud.updateHUD(Reg.player.gifts, Reg.player.balls);
		hud.update(elapsed);
		level.applyGravity();
		level.collideObjects();
		if (Reg.player.y > level.fullHeight || Reg.player.gifts == 0)
			FlxG.resetState();
	}

	/**
	 * Function that is called when this state is destroyed - you might want to
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void {
		super.destroy();
	}
}
