package entidades;

import ias.EnemigoBasico;

class ImpRojo extends Entidad {
	override public function new(name:String, x:Float = 0, y:Float = 0) {
		super(name, x, y);
		loadGraphic(AssetPaths.Imp_Rojo__png, true, 64, 64);
		width = 13;
		height = 17;
		offset.x = 26;
		offset.y = 20;
		// Crear I.A.
		ia = new EnemigoBasico(this);
		// Animaciones
		animation.add("creacion", [9, 8, 7, 6, 5, 4, 3, 2, 1, 0], 30, false);
		animation.add("destruccion", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 30, false);
		animation.add("espera", [12, 13, 14, 13, 12, 11, 10, 11, 12], 10, true);
		animation.add("caminar", [20, 21, 22, 23, 24, 25, 26, 27], 30, true);
		animation.add("correr", [20, 21, 22, 23, 24, 25, 26, 27], 60, true);
		animation.add("carga", [30, 31, 32, 33, 34, 35], 40, false);
		animation.add("cargando", [32, 33, 34, 35], 20, true);
		animation.add("salto", [36, 37, 38, 39], 20, false);
		animation.add("aterrisaje", [39, 38, 37, 36, 32, 33, 34, 35, 31, 30], 60, false);
		animation.add("ataque", [40, 41, 42, 43, 44, 45], 60, false);
		animation.add("defensa", [50, 51, 52, 53, 54, 53, 52, 51, 50], 60, false);
	}
}
