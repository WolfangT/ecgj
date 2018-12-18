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
	private var _textCredits1:FlxText;
	private var _textCredits2:FlxText;
	private var _textCredits3:FlxText;

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
		_btnPlay = new FlxButton(FlxG.width * 0.5, FlxG.height * 0.9, "Return", clickPlay);
		_name = new FlxText(FlxG.width * 0.4, FlxG.height * 0.10, 0, "Credits", 50); // "The great Nort Pole holiday bulglary of 82!"
		_textCredits1 = new FlxText(FlxG.width * 0.10, FlxG.height * 0.35, 0, "Developed by Wolfang Torres and Eduardo Rivero", 20);
		_textCredits2 = new FlxText(FlxG.width * 0.10, FlxG.height * 0.45, 0, "Original art by https://opengameart.org/content/a-puzzling-present-image-bank",
			12);
		_textCredits3 = new FlxText(FlxG.width * 0.10, FlxG.height * 0.50, 0, "Sounds Efects created with http://sfbgames.com/chiptone/", 15);
		add(_bg);
		add(_name);
		add(_textCredits1);
		add(_textCredits2);
		add(_textCredits3);
		add(_btnPlay);
		// Estadar
		super.create();
	}

	private function clickPlay():Void {
		FlxG.switchState(new MenuState());
	}
}
