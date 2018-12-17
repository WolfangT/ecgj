package;

class Nivel extends PlayState {
	override public function create():Void {
		tmx_file = AssetPaths.nivel1__tmx;
		super.create();
	}
}
