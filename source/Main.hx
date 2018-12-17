package;

import flixel.FlxGame;
import openfl.display.Sprite;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.util.FlxSave;

class Main extends Sprite {
	public function new() {
		super();

		addChild(new FlxGame(640, 480, MenuState));
		var _save:FlxSave = new FlxSave();
		_save.bind("flixel-tutorial");
		if (_save.data.volume != null) {
			FlxG.sound.volume = _save.data.volume;
		}
		_save.close();
	}
}
