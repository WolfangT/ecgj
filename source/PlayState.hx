package;

import flixel.FlxState;

class PlayState extends FlxState {
	override public function create():Void {
		super.create();
		var text = new flixel.text.FlxText(0, 0, 0, "Hello World test", 64);
		text.screenCenter();
		add(text);
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		var a = 5;
	}
}