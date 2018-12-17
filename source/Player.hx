package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.FlxObject;

class Player extends FlxSprite {
	public var speed:Float = 200;

	var _up:Bool;
	var _down:Bool;
	var _left:Bool;
	var _right:Bool;
	var _mA:Float;

	public function new(?X:Float = 0, ?Y:Float = 0) {
		super(X, Y);
		loadGraphic(AssetPaths.player__png, true, 16, 16);
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		animation.add("lr", [3, 4, 3, 5], 6, false);
		animation.add("u", [6, 7, 6, 8], 6, false);
		animation.add("d", [0, 1, 0, 2], 6, false);
		drag.x = drag.y = 1600;
		setSize(8, 14);
		offset.set(4, 2);
	}

	function movement():Void {
		_up = _down = _left = _right = false;
		_up = FlxG.keys.anyPressed([W, UP]);
		_down = FlxG.keys.anyPressed([S, DOWN]);
		_left = FlxG.keys.anyPressed([A, LEFT]);
		_right = FlxG.keys.anyPressed([D, RIGHT]);
		if (_up || _down || _left || _right) {
			if (_up) {
				_mA = -90;
				if (_right) {
					_mA += 45;
					facing = FlxObject.UP;
				} else if (_left)
					_mA -= 45;
			} else if (_down) {
				_mA = 90;
				if (_right) {
					_mA -= 45;
					facing = FlxObject.DOWN;
				} else if (_left)
					_mA += 45;
			} else if (_left) {
				_mA = 180;
				facing = FlxObject.LEFT;
			} else if (_right) {
				_mA = 0;
				facing = FlxObject.RIGHT;
			}
			velocity.set(speed * 4, 0);
			velocity.rotate(FlxPoint.weak(0, 0), _mA);
			if ((velocity.x != 0 || velocity.y != 0) && touching == FlxObject.NONE) {
				switch (facing) {
					case FlxObject.LEFT, FlxObject.RIGHT:
						animation.play("lr");
					case FlxObject.UP:
						animation.play("u");
					case FlxObject.DOWN:
						animation.play("d");
				}
			}
		}
	}

	override public function update(elapsed:Float):Void {
		movement();
		super.update(elapsed);
	}
}
