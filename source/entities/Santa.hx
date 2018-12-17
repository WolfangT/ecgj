package entities;

import ias.EnemigoBasico;

class Santa extends Entity {
	override public function new(name:String, x:Float = 0, y:Float = 0) {
		super(name, x, y);
		loadGraphic(AssetPaths.santa__png, true, 16, 16);
		width = 16;
		height = 16;
		offset.x = 0;
		offset.y = 0;
		// Crear I.A.
		ia = new EnemigoBasico(this);
		// Animaciones
		animation.add("creacion", [7, 0], 30, false);
		animation.add("destruccion", [0, 7, 6], 30, false);
		animation.add("espera", [0, 1, 2, 1], 10, true);
		animation.add("caminar", [0, 1, 2, 3, 4, 5], 30, true);
		animation.add("correr", [0, 2], 60, true);
		animation.add("carga", [0, 1, 6, 7], 40, false);
		animation.add("cargando", [5], 20, true);
		animation.add("salto", [3], 20, false);
		animation.add("aterrisaje", [3, 2, 1, 0, 5, 4], 60, false);
		animation.add("ataque", [0, 6, 7, 1, 0], 60, false);
		animation.add("defensa", [3, 4, 4, 4, 5], 60, false);
	}
}
