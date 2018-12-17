package collectibles;

import flixel.math.FlxRandom;
import flixel.math.FlxPoint;
import flixel.FlxSprite;
import flixel.system.FlxSound;

/**
 * Objetos Colecionables
 *
**/
class Collectible extends FlxSprite {
	public var speed:Float = 200;
	public var name:String;
	public var collectedSounds:Array<FlxSound>;

	override public function new(n:String, x:Float, y:Float) {
		super(x, y);
		name = n;
		maxVelocity = new FlxPoint(speed, speed);
	}

	public function flyArround():Void {
		var random:FlxRandom = new FlxRandom();
		var mA:Float = random.float(0, 360);
		var mov:FlxPoint = new FlxPoint(speed * 2, 0);
		mov.rotate(new FlxPoint(), mA);
		acceleration.addPoint(mov);
	}

	public function collected():Void {
		var random:FlxRandom = new FlxRandom();
		var index:Int = random.int(0, collectedSounds.length);
		collectedSounds[index].play();
		kill();
	}
}
