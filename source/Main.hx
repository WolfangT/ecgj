package;

import flixel.FlxGame;
import flixel.FlxG;
import flixel.system.debug.watch.Tracker;
import openfl.display.Sprite;
import entities.ImpRojo;
import entities.Entity;
import ias.Jugador;
import ias.EnemigoBasico;

class Main extends Sprite {
	public function new() {
		super();
		addChild(new FlxGame(0, 0, MenuState));
		// crear jugador
		Reg.player = new ImpRojo('jugador', -500, -500);
		Reg.player.ia = new Jugador(Reg.player);
		// debugging
		FlxG.debugger.addTrackerProfile(new TrackerProfile(EnemigoBasico, ["_dx", "_dy", "_mA", "_mD"], []));
		FlxG.debugger.addTrackerProfile(new TrackerProfile(Entity, [
			"name", "acceleration", "velocity", "x", "y", "touching", "mareado", "cargandoSalto", "cargaSalto", "saltando"
		], []));
	}
}
