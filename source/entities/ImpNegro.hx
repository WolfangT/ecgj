package entities;

import entities.Entity;
import ias.*;

class ImpNegro extends Entity {
	override public function new(Name:String, X:Float = 0, Y:Float = 0) {
		super(Name, X, Y);
		loadGraphic(AssetPaths.Imp_Negro__png, true, 32, 32);
		scale.x = scale.y = 2;
		setGraphicSize(64, 64);
		updateHitbox();
		// Crear I.A.
		ia = new EnemigoBasico(this);
		// Animaciones
	}
}
