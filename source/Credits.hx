// https://opengameart.org/content/a-puzzling-present-image-bank
// http://sfbgames.com/chiptone/
package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxDestroyUtil;

/**
 * A FlxState which can be used for the game's menu.
 */
class Credits extends FlxState {
	private var _btnPlay:FlxButton;
	private var _name:FlxText;
	private var _bg:FlxSprite;

	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void {
		// Logging
		FlxG.log.redirectTraces = true;
		FlxG.debugger.visible = true;
		FlxG.debugger.drawDebug = true;
		// Custom
		_bg = new FlxSprite(0, 0, AssetPaths.main__png);
		_name = new FlxText(FlxG.width * 0.15, FlxG.height * 0.33, FlxG.width * 0.7, "Credits", 50); // "The great Nort Pole holiday bulglary of 82!"
		_btnPlay = new FlxButton(FlxG.width * 0.5, FlxG.height * 0.9, "Return", clickPlay);
		add(_bg);
		add(_name);
		add(_btnPlay);
		// Estadar
		super.create();
	}

	private function clickPlay():Void {
		FlxG.switchState(new MenuState());
	}
}
