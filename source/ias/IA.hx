package ias;

import entities.Entity;

/**
 * Clase base para la IAs que simplemente guarda una referencia al
 * objeto que controla
**/
class IA {
	public var entidad:Entity;

	public function new(e:Entity):Void {
		entidad = e;
	}

	public function update(elapsed:Float):Void {}
}
