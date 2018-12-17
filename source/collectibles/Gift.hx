package collectibles;

class Gift extends Collectible {
	override public function new(n:String, x:Float = 0, y:Float = 0) {
		super(n, x, y);
		loadGraphic(AssetPaths.gift__png, true, 16, 16);
		collectedSounds = Reg.giftSounds;
	}
}
