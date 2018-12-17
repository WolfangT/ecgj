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
		// load sounds
		Reg.giftSounds = [
			FlxG.sound.load(AssetPaths.gift1__wav), FlxG.sound.load(AssetPaths.gift2__wav), FlxG.sound.load(AssetPaths.gift3__wav),
			FlxG.sound.load(AssetPaths.gift4__wav), FlxG.sound.load(AssetPaths.gift5__wav), FlxG.sound.load(AssetPaths.gift6__wav),
			FlxG.sound.load(AssetPaths.gift7__wav), FlxG.sound.load(AssetPaths.gift8__wav), FlxG.sound.load(AssetPaths.gift9__wav),
			FlxG.sound.load(AssetPaths.gift10__wav), FlxG.sound.load(AssetPaths.gift11__wav), FlxG.sound.load(AssetPaths.gift12__wav),
			FlxG.sound.load(AssetPaths.gift13__wav), FlxG.sound.load(AssetPaths.gift14__wav), FlxG.sound.load(AssetPaths.gift15__wav),
		];
	}
}
