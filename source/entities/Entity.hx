package entities;

import Math;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;
import flixel.math.FlxRandom;
import ias.IA;
import collectibles.*;

/**
 * Clase basica que define a todas las criaturas del juego
 * esto incluye a los personajes jugables, enemigos y trampas,
 * es uno de 2 componentes, el otro es la IA
**/
class Entity extends FlxSprite {
	public var name:String;
	public var ia:IA;
	public var activo:Bool = false;
	// mareo
	public var inmune:Float = 0;
	public var mareado:Float = 0;
	public var ResistenciaMareo:Float = 1; // valor que modifica cuanto puntos de mareo pierde por segundo
	// salto
	public var cargandoSalto:Bool = false;
	public var cargaSalto:Float = 0;
	public var saltando:Bool = false;
	public var velocidadCargaSalto:Float = 2;
	public var FuerzaSalto:Int = 600;
	public var empesandoCargaSalto:Bool = false;
	// game
	public var gifts:Int;
	public var balls:Int;
	public var collected_till_ball:Int;
	public var needed_for_ball:Int = 5;
	public var hurtSounds:Array<FlxSound>;

	override public function new(name:String, x:Float, y:Float, velocidad:Int = 300) {
		this.name = name;
		super(x, y);
		maxVelocity.x = velocidad;
		drag.x = velocidad * 5;
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		collected_till_ball = 0;
		hurtSounds = [
			FlxG.sound.load(AssetPaths.hurt1__wav, 0.75),
			FlxG.sound.load(AssetPaths.hurt2__wav, 0.75),
			FlxG.sound.load(AssetPaths.hurt3__wav, 0.75),
		];
	}

	public function ataque() {
		if (balls > 0) {
			animation.play("ataque");
			balls -= 1;
			for (i in 1...3) {
				var b:Beachball = new Beachball("ball", x, y);
				var p:PlayState = cast FlxG.state;
				p.level.mobileObjects.add(b);
				p.level.objectsLayer.add(b);
				p.level.proyectileGroup.add(b);
				b.flyArround();
			}
		}
	}

	public function sufrir():Void {
		if (inmune == 0) {
			var random:FlxRandom = new FlxRandom();
			var sound:FlxSound = random.getObject(hurtSounds);
			sound.play();
			gifts -= 1;
			inmune = 3;
		}
	}

	public function moverse(angle:Float, amount:Float = 1):Void {
		var p:Float = isTouching(FlxObject.FLOOR) ? 1 : 0.25;
		var fuerza:Float = maxVelocity.x * 4 * p;
		var mov:FlxPoint = new FlxPoint(fuerza, 0);
		mov.rotate(new FlxPoint(), angle);
		acceleration.addPoint(mov);
	}

	public function cargarSalto():Void {
		cargandoSalto = true;
	}

	public function collectCollectible(collectible:Collectible):Void {
		if (collectible.name == "gift") {
			gifts += 1;
			collected_till_ball += 1;
			if (collected_till_ball >= needed_for_ball) {
				collected_till_ball = 0;
				balls += 1;
			}
		}
	}

	public function saltar():Void {
		if (isTouching(FlxObject.FLOOR) || isTouching(FlxObject.RIGHT) || isTouching(FlxObject.LEFT)) {
			var jA:Float = 0;
			// if (isTouching(FlxObject.FLOOR))
			// 	jA = 0;
			// else
			if (isTouching(FlxObject.RIGHT))
				jA = -45;
			else if (isTouching(FlxObject.LEFT))
				jA = 45;
			var fuerza:Float = cargaSalto * FuerzaSalto;
			var mov:FlxPoint = new FlxPoint(0, fuerza);
			mov.rotate(new FlxPoint(), jA);
			velocity.subtractPoint(mov);
		}
		cargandoSalto = false;
		saltando = true;
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
			if (inmune > 0) {
				inmune -= elapsed;
				if (inmune < 0)
					inmune = 0;
			}
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
				if (justTouched(FlxObject.FLOOR))
					saltando = false;
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
