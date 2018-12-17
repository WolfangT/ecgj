package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.text.FlxText;

class MenuState extends FlxState {
	var _btnPlay:FlxButton;
	var _txtTitle:FlxText;
	var _btnOptions:FlxButton;

	override public function create():Void {
		_txtTitle = new FlxText(20, 0, 0, "HaxeFlixel\nTutorial\nGame", 22);
		_txtTitle.alignment = CENTER;
		_txtTitle.screenCenter(X);
		add(_txtTitle);

		_btnOptions = new FlxButton(0, 0, "Options", clickOptions);
		_btnOptions.x = (FlxG.width / 2) + 10;
		_btnOptions.y = FlxG.height - _btnOptions.height - 10;
		add(_btnOptions);
		_btnPlay = new FlxButton(0, 0, "Play", clickPlay);
		_btnPlay.screenCenter();
		add(_btnPlay);
		super.create();
	}

	function clickOptions():Void {
		FlxG.switchState(new OptionsState());
	}

	function clickPlay():Void {
		FlxG.switchState(new PlayState());
	}
}
