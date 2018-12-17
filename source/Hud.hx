package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

class HUD extends FlxTypedGroup<FlxSprite> {
	private var _sprBack:FlxSprite;
	private var _txtHealth:FlxText;
	private var _sprHealth:FlxSprite;

	public function new() {
		super();
		_sprBack = new FlxSprite().makeGraphic(FlxG.width, 25, FlxColor.BLACK);
		_sprBack.drawRect(0, 19, FlxG.width, 1, FlxColor.WHITE);
		_txtHealth = new FlxText(20, 2, 0, "3", 10);
		_txtHealth.setBorderStyle(SHADOW, FlxColor.GRAY, 1, 1);
		_sprHealth = new FlxSprite(4, _txtHealth.y + (_txtHealth.height / 2) - 4, AssetPaths.gift__png);
		add(_sprBack);
		add(_sprHealth);
		add(_txtHealth);
		forEach(function(spr:FlxSprite) {
			spr.scrollFactor.set(0, 0);
		});
	}

	public function updateHUD(Health:Int = 0):Void {
		_txtHealth.text = Std.string(Health);
	}
}
