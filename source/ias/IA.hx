package ias;

import entidades.Entidad;

/**
 * Clase base para la IAs que simplemente guarda una referencia al
 * objeto que controla
**/
class IA {
	public var entidad:Entidad;

	public function new(e:Entidad):Void {
		entidad = e;
	}

	public function update(elapsed:Float):Void {}
}
