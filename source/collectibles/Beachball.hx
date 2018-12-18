package collectibles;

import flixel.system.FlxSound;
import flixel.math.FlxRandom;
import flixel.FlxG;

class Beachball extends Collectible {
	override public function new(n:String, x:Float = 0, y:Float = 0) {
		super(n, x, y);
		loadGraphic(AssetPaths.beachball__png, true, 16, 16);
		collectedSounds = [
			FlxG.sound.load(AssetPaths.ball1__wav, 0.75),
			FlxG.sound.load(AssetPaths.ball2__wav, 0.75),
			FlxG.sound.load(AssetPaths.ball3__wav, 0.75),
			FlxG.sound.load(AssetPaths.ball4__wav, 0.75),
			FlxG.sound.load(AssetPaths.ball5__wav, 0.75),
		];
		elasticity = 1;
	}

	override public function collected():FlxSound {
		var random:FlxRandom = new FlxRandom();
		var sound:FlxSound = random.getObject(collectedSounds);
		flyArround();
		return sound;
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		angularVelocity = velocity.toVector().length;
	}
}
