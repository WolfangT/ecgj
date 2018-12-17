package ias;

import flixel.FlxG;

/**
 * Clase que representa al jugador como una inteligencia artificial
 * cullas acciones vienen de las entradas del jugador
**/
class Jugador extends IA {
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		// Obtener direcciones
		var _up:Bool = FlxG.keys.anyPressed([UP]);
		var _down:Bool = FlxG.keys.anyPressed([DOWN]);
		var _left:Bool = FlxG.keys.anyPressed([LEFT]);
		var _right:Bool = FlxG.keys.anyPressed([RIGHT]);
		var _space:Bool = FlxG.keys.anyPressed([SPACE]);
		// Procesar direcciones opuestas
		if (_up && _down)
			_up = _down = false;
		if (_left && _right)
			_left = _right = false;
		// movimiento en x
		if (_left || _right) {
			var mA:Float = 0;
			if (_left)
				mA = 180;
			else if (_right)
				mA = 0;
			entidad.moverse(mA);
		}
		// saltando
		if (FlxG.keys.anyJustPressed([SPACE]))
			entidad.cargarSalto();
		if (FlxG.keys.anyJustReleased([SPACE])) {
			entidad.saltar();
		}
	}
}
