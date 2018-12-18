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
class MenuState extends FlxState {
	private var _btnPlay:FlxButton;
	private var _btnCredits:FlxButton;
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
		_name = new FlxText(FlxG.width * 0.15, FlxG.height * 0.33, FlxG.width * 0.7, "Rensi's Adventure", 50); // "The great Nort Pole holiday bulglary of 82!"
		_btnPlay = new FlxButton(0, 0, "Play", clickPlay);
		_btnCredits = new FlxButton(FlxG.width * 0.5, FlxG.height * 0.6, "Credits", clickCredits);
		_btnPlay.screenCenter();
		add(_bg);
		add(_name);
		add(_btnPlay);
		add(_btnCredits);
		// Estadar
		super.create();
	}

	/**
	 * Function that is called when this state is destroyed - you might want to
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void {
		super.destroy();
		_btnPlay = FlxDestroyUtil.destroy(_btnPlay);
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
	}

	private function clickPlay():Void {
		FlxG.switchState(new Nivel());
	}

	private function clickCredits():Void {
		FlxG.switchState(new Credits());
	}
}
