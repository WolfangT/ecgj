package ias;

import flixel.math.FlxPoint;
import flixel.math.FlxVector;
import flixel.math.FlxAngle;
import Math;

class EnemigoBasico extends IA {
	var _dir:FlxVector = new FlxVector(0, 0);
	var _dy:Float;
	var _dx:Float;
	var _mA:Float;
	var _mD:Float;

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		// Obtener angulo
		_dx = Reg.player.x - entidad.x;
		_dy = entidad.y - Reg.player.y;
		_dir.set(_dx, _dy);
		_mA = _dir.degrees;
		_mD = _dir.length;
		// modificar valores de la entidad
		if (entidad.cargandoSalto && entidad.cargaSalto == 0.5)
			entidad.saltar();
		else if (_mD < 250) {
			if (_mA <= 45 || _mA >= 135)
				entidad.moverse(_mA);
			else if (_mA > 45 || _mA < 135)
				entidad.cargarSalto();
		}
	}
}
