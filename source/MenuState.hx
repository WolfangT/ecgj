package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import flixel.util.FlxDestroyUtil;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState {
	private var _btnPlay:FlxButton;
	private var _name:FlxText;

	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void {
		// Logging
		FlxG.log.redirectTraces = true;
		FlxG.debugger.visible = true;
		FlxG.debugger.drawDebug = true;
		// Custom
		_name = new FlxText(FlxG.width * 0.25, FlxG.height * 0.25, FlxG.width * 0.5, "The great Nort Pole holiday bulglary of 82!", 25);
		_btnPlay = new FlxButton(0, 0, "Play", clickPlay);
		_btnPlay.screenCenter();
		add(_name);
		add(_btnPlay);
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
}
