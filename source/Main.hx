package;

import flixel.FlxGame;
import flixel.FlxG;
import flixel.system.debug.watch.Tracker;
import openfl.display.Sprite;
import entities.Entity;
import ias.EnemigoBasico;

class Main extends Sprite {
	public function new() {
		super();
		addChild(new FlxGame(0, 0, MenuState));
		// debugging
		FlxG.debugger.addTrackerProfile(new TrackerProfile(EnemigoBasico, ["_dx", "_dy", "_mA", "_mD"], []));
		FlxG.debugger.addTrackerProfile(new TrackerProfile(Entity, [
			"name", "acceleration", "velocity", "x", "y", "touching", "inmune", "mareado", "cargandoSalto", "cargaSalto", "saltando"
		], []));
	}
}
