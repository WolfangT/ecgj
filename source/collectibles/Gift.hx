package collectibles;

import flixel.FlxG;

class Gift extends Collectible {
	override public function new(n:String, x:Float = 0, y:Float = 0) {
		super(n, x, y);
		loadGraphic(AssetPaths.gift__png, true, 16, 16);
		collectedSounds = [
			FlxG.sound.load(AssetPaths.gift1__wav, 1), FlxG.sound.load(AssetPaths.gift2__wav, 1), FlxG.sound.load(AssetPaths.gift3__wav, 1),
			FlxG.sound.load(AssetPaths.gift4__wav, 1), FlxG.sound.load(AssetPaths.gift5__wav, 1), FlxG.sound.load(AssetPaths.gift6__wav, 1),
			FlxG.sound.load(AssetPaths.gift7__wav, 1), FlxG.sound.load(AssetPaths.gift8__wav, 1), FlxG.sound.load(AssetPaths.gift9__wav, 1),
			FlxG.sound.load(AssetPaths.gift10__wav, 1), FlxG.sound.load(AssetPaths.gift11__wav, 1), FlxG.sound.load(AssetPaths.gift12__wav, 1),
			FlxG.sound.load(AssetPaths.gift13__wav, 1), FlxG.sound.load(AssetPaths.gift14__wav, 1), FlxG.sound.load(AssetPaths.gift15__wav, 1),
		];
	}
}
