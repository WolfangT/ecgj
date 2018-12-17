package entidades;

import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import Math;
import ias.IA;

/**
 * Clase basica que define a todas las criaturas del juego
 * esto incluye a los personajes jugables, enemigos y trampas,
 * es uno de 2 componentes, el otro es la IA
**/
class Entidad extends FlxSprite {
	public var name:String;
	public var ia:IA;
	public var activo:Bool = false;
	// mareo
	public var mareado:Float = 0;
	public var ResistenciaMareo:Float = 1; // valor que modifica cuanto puntos de mareo pierde por segundo
	// salto
	public var cargandoSalto:Bool = false;
	public var cargaSalto:Float = 0;
	public var velocidadCargaSalto:Float = 2;
	public var FuerzaSalto:Int = 600;
	public var empesandoCargaSalto:Bool = false;

	override public function new(name:String, x:Float, y:Float, velocidad:Int = 300):Void {
		this.name = name;
		super(x, y);
		maxVelocity.x = velocidad;
		drag.x = velocidad * 5;
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
	}

	public function moverse(angle:Float, amount:Float = 1):Void {
		var p:Float = isTouching(FlxObject.FLOOR) ? 1 : 0.25;
		var fuerza:Float = maxVelocity.x * 4 * p;
		var mov:FlxPoint = new FlxPoint(fuerza, 0);
		mov.rotate(new FlxPoint(), angle);
		acceleration.addPoint(mov);
	}

	public function wallJumpReflect():Void {
		velocity.y = -FuerzaSalto / 2;
		if (isTouching(FlxObject.RIGHT)) {
			velocity.x = -maxVelocity.x;
		} else if (isTouching(FlxObject.LEFT)) {
			velocity.x = maxVelocity.x;
		}
	}

	public function cargarSalto():Void {
		cargandoSalto = true;
	}

	public function saltar():Void {
		var fuerza:Float = cargaSalto * FuerzaSalto;
		var mov:FlxPoint = new FlxPoint(0, fuerza);
		// mov.rotate(new FlxPoint(), 0);
		velocity.subtractPoint(mov);
		cargandoSalto = false;
		empesandoCargaSalto = true;
	}

	public function nacer():Void {
		activo = true;
		animation.play("creacion");
	}

	public function morir():Void {
		activo = false;
		animation.play("destruccion");
	}

	override public function update(elapsed:Float):Void {
		if (activo) {
			// Principal
			if (mareado == 0) {
				// Inteligencia Artificial
				ia.update(elapsed);
				// Salto
				if (isTouching(FlxObject.FLOOR)) {
					if (cargandoSalto) {
						cargaSalto += elapsed * velocidadCargaSalto;
						if (cargaSalto > 1)
							cargaSalto = 1;
					}
				}
			} else {
				// Reducir mareo
				mareado -= elapsed * ResistenciaMareo;
				if (mareado < 0)
					mareado = 0;
			}
			// Quitar carga salto
			if (mareado != 0 || cargandoSalto == false)
				cargaSalto = 0;
		}
		// Animaciones
		animaciones();
		// Estandar
		super.update(elapsed);
		acceleration.set(0, 0);
	}

	public function animaciones():Void {
		// Cambiar direccion
		if (velocity.x > 0)
			facing = FlxObject.LEFT;
		if (velocity.x < 0)
			facing = FlxObject.RIGHT;
		// Movimiento
		if (isTouching(FlxObject.FLOOR)) {
			if (cargandoSalto) {
				if (empesandoCargaSalto) {
					animation.play("carga");
					empesandoCargaSalto = false;
				}
				if (animation.finished) {
					animation.play("cargando");
				}
			} else if (justTouched(FlxObject.FLOOR))
				animation.play("aterrisaje");
			else if (animation.finished ||
				animation.name == "espera" ||
				animation.name == "caminar" ||
				animation.name == "correr") {
				if (Math.abs(velocity.x) == 300)
					animation.play("correr");
				else if (Math.abs(velocity.x) > 10)
					animation.play("caminar");
				else if (Math.abs(velocity.x) < 10)
					animation.play("espera");
			}
		} else {
			if (animation.name != "salto") {
				animation.play("salto");
			}
		}
	}
}
