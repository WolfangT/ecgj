package;

import Math;
import haxe.io.Path;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.addons.tile.FlxTilemapExt;
import flixel.addons.editors.tiled.TiledImageLayer;
import flixel.addons.editors.tiled.TiledImageTile;
import flixel.addons.editors.tiled.TiledLayer.TiledLayerType;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.addons.editors.tiled.TiledTileSet;
import flixel.math.FlxPoint;
import flixel.graphics.frames.FlxTileFrames;
import entidades.Entidad;
import entidades.Santa;
import entidades.ImpRojo;

/**
 * @author Samuel Batista
 */
class TiledLevel extends TiledMap {
	// For each "Tile Layer" in the map, you must define a "tileset" property which contains the name of a tile sheet image
	// used to draw tiles in that layer (without file extension). The image file must be located in the directory specified bellow.
	private inline static var c_PATH_LEVEL_TILESHEETS = "assets/images/";

	// Grupo que contiene todos los objetos
	public var masterGroup:FlxGroup;
	// Array of tilemaps used for collision
	public var frontLayer:FlxGroup;
	public var foregroundTiles:FlxGroup;
	public var backgroundLayer:FlxGroup;

	private var collidableTileLayers:Array<FlxTilemap>;

	// Groups for objects layers
	public var objectsLayer:FlxGroup;
	public var mobileObjects:FlxGroup;
	public var staticObjects:FlxGroup;
	public var entityLayer:FlxGroup;
	// Sprites of images layers
	public var imagesLayer:FlxGroup;
	// constantes fisicas
	public var gravity:Int = 600;
	public var friction:Float = 0.5;
	public var song:String = null;

	public function new(tiledLevel:Dynamic) {
		super(tiledLevel);
		masterGroup = new FlxGroup();
		imagesLayer = new FlxGroup();
		foregroundTiles = new FlxGroup();
		objectsLayer = new FlxGroup();
		entityLayer = new FlxGroup();
		mobileObjects = new FlxGroup();
		staticObjects = new FlxGroup();
		frontLayer = new FlxGroup();
		backgroundLayer = new FlxGroup();
		collidableTileLayers = new Array<FlxTilemap>();
		// set bounds
		FlxG.camera.setScrollBoundsRect(0, 0, fullWidth, fullHeight, true);
		FlxG.worldBounds.set(1, 1, fullWidth, fullHeight);
		// cargar propiedades del archivo
		if (properties.contains('gravity'))
			gravity = Std.parseInt(properties.get('gravity'));
		if (properties.contains('friction'))
			friction = Std.parseFloat(properties.get('friction'));
		if (properties.contains('song'))
			song = properties.get('song');
		// crar todos los elementos del mapa
		for (layer in layers) {
			if (layer.type == TiledLayerType.IMAGE)
				loadImages(layer);
			else if (layer.type == TiledLayerType.TILE)
				loadTileMaps(layer);
			else if (layer.type == TiledLayerType.OBJECT)
				loadObjects(layer);
		}
		// Agregarlos en el orden correcto
		masterGroup.add(backgroundLayer);
		masterGroup.add(imagesLayer);
		masterGroup.add(objectsLayer);
		masterGroup.add(foregroundTiles);
		masterGroup.add(frontLayer);
	}

	private function loadImages(layer) {
		// load static images
		if (layer.type != TiledLayerType.IMAGE)
			return;
		var image:TiledImageLayer = cast layer;
		var sprite = new FlxSprite(image.x, image.y, c_PATH_LEVEL_TILESHEETS + image.imagePath);
		imagesLayer.add(sprite);
	}

	private function loadTileMaps(layer) {
		// Load Tile Maps
		if (layer.type != TiledLayerType.TILE)
			return;

		// convierte el objeto TiledLayer en TiledTileLayer, que contiene mas datos
		var tileLayer:TiledTileLayer = cast layer;

		// busca el tileset usado por el layer
		var tileSheetName:String = tileLayer.properties.get("tilesheet");
		if (tileSheetName == null)
			throw "'tileset' property not defined for the '" + tileLayer.name + "' layer. Please add the property to the layer.";
		var tileSet:TiledTileSet = tilesets[tileSheetName];
		// if (tileSet == null)
		// 	throw "Tileset '" + tileSheetName + " not found. Did you misspell the 'tilesheet' property in " + tileLayer.name + "' layer?";
		var imagePath = new Path(tileSet.imageSource);
		var processedPath = c_PATH_LEVEL_TILESHEETS + imagePath.file + "." + imagePath.ext;

		// crear el mapa de flixel
		var tilemap:FlxTilemapExt = new FlxTilemapExt(); // var tilemap:FlxTilemap = new FlxTilemap();
		tilemap.loadMapFromArray(tileLayer.tileArray, width, height, processedPath, tileSet.tileWidth, tileSet.tileHeight, OFF, tileSet.firstGID, 1, 1);

		// tile tearing problem fix
		var levelTiles = FlxTileFrames.fromBitmapAddSpacesAndBorders(processedPath, new FlxPoint(tileSet.tileWidth, tileSet
			.tileHeight), new FlxPoint(2, 2), new FlxPoint(2, 2));
		tilemap.frames = levelTiles;

		// set tile properties
		var tempC:Array<Int> = [];
		var tempW:Array<Int> = [];
		var tempNW:Array<Int> = [];
		var tempNE:Array<Int> = [];
		var tempSW:Array<Int> = [];
		var tempSE:Array<Int> = [];
		var tempGt:Array<Int> = [];
		var tempGT:Array<Int> = [];
		var tempSt:Array<Int> = [];
		var tempST:Array<Int> = [];
		for (tile in tileSet.tileProps) {
			var _id:Int = tileSet.toGid(tile.tileID);
			if (tile.contains("cloud"))
				tempC.push(_id);
			if (tile.contains("walljump"))
				tempW.push(_id);
			if (tile.contains("facing"))
				switch (tile.get("facing")) {
					case "nw":
						tempNW.push(_id);
					case "ne":
						tempNE.push(_id);
					case "sw":
						tempSW.push(_id);
					case "se":
						tempSE.push(_id);
				}
			if (tile.contains("slope"))
				switch (tile.get("slope")) {
					case "gt":
						tempGt.push(_id);
					case "gT":
						tempGT.push(_id);
					case "st":
						tempSt.push(_id);
					case "sT":
						tempST.push(_id);
				}
		}
		for (tile in tempC)
			tilemap.setTileProperties(tile, FlxObject.NONE, fallInClouds);
		for (tile in tempW)
			tilemap.setTileProperties(tile, tilemap.getTileCollisions(tile), wallJump);
		tilemap.setSlopes(tempNW, tempNE, tempSW, tempSE);
		tilemap.setGentle(tempGT, tempGt);
		tilemap.setSteep(tempST, tempST);

		// add properties for the layer
		if (layer.properties.contains("parallax")) {
			// agregar parallax
			var parallax:Float = Std.parseFloat(layer.properties.get("parallax"));
			tilemap.scrollFactor.set(parallax, parallax);
		}
		if (tileLayer.properties.contains("collide")) {
			// agregar el mapa el grupo correcto
			collidableTileLayers.push(tilemap);
		}
		switch (tileLayer.properties.get("layer")) {
			case "front":
				frontLayer.add(tilemap);
			case "main":
				foregroundTiles.add(tilemap);
			case "bg":
				backgroundLayer.add(tilemap);
			default:
				backgroundLayer.add(tilemap);
		}
	}

	private function loadObjects(layer) {
		if (layer.type != TiledLayerType.OBJECT)
			return;
		var objectLayer:TiledObjectLayer = cast layer;
		for (object in objectLayer.objects) {
			// collection of images layer
			if (layer.name == "images")
				loadImageObject(object);
			// objects layer
			else if (layer.name == "entities")
				loadEntity(object, objectLayer);
			// objects layer
			else if (layer.name == "objetives")
				loadObjetives(object, objectLayer);
		}
	}

	private function loadImageObject(object:TiledObject) {
		var tilesImageCollection:TiledTileSet = this.getTileSet("imageCollection");
		var tileImagesSource:TiledImageTile = tilesImageCollection.getImageSourceByGid(object.gid);
		// decorative sprites
		var levelsDir:String = "assets/images/";
		var decoSprite:FlxSprite = new FlxSprite(0, 0, levelsDir + tileImagesSource.source);
		if (decoSprite.width != object.width || decoSprite.height != object.height) {
			decoSprite.antialiasing = true;
			decoSprite.setGraphicSize(object.width, object.height);
		}
		decoSprite.setPosition(object.x, object.y - decoSprite.height);
		decoSprite.origin.set(0, decoSprite.height);
		if (object.angle != 0) {
			decoSprite.angle = object.angle;
			decoSprite.antialiasing = true;
		}
		backgroundLayer.add(decoSprite);
	}

	private function loadEntity(object:TiledObject, g:TiledObjectLayer) {
		var sprite:FlxSprite = new FlxSprite();
		var x:Int = object.x;
		var y:Int = object.y;
		// objects in tiled are aligned bottom-left (top-left in flixel)
		if (object.gid != -1)
			y -= g.map.getGidOwner(object.gid).tileHeight;
		// determinar tipo de objeto
		switch (object.type) {
			case "player":
				Reg.player.name = object.name;
				Reg.player.setPosition(x, y);
				sprite = Reg.player;
			default:
				// resolver dinamicamente la clase del sprite
				// Crear dinamicamente el objeto en la posicion dada
				var clase:Dynamic = Type.resolveClass("entidades." + object.type);
				if (clase == null)
					throw "Could not find class of type " + object.type;
				sprite = Type.createInstance(clase, [object.name, object.x, object.y]);
				if (clase == Santa) {
					var s:Santa = cast sprite;
					FlxG.debugger.track(s.ia);
				}
		}
		// Determinar si el objeto es movil o estatico
		if (object.properties.contains("static")) {
			sprite.immovable = true;
			staticObjects.add(sprite);
		} else
			mobileObjects.add(sprite);
		entityLayer.add(sprite);
		objectsLayer.add(sprite);
		FlxG.debugger.track(sprite);
	}

	private function loadObjetives(object:TiledObject, g:TiledObjectLayer) {}

	public function collideWithLevel(obj:FlxObject, ?notifyCallback:FlxObject->FlxObject->Void, ?processCallback:FlxObject->FlxObject->Bool):Bool {
		for (map in collidableTileLayers) {
			// IMPORTANT: Always collide the map with objects, not the other way around.
			//            This prevents odd collision errors (collision separation code off by 1 px).
			if (FlxG.overlap(map, obj, notifyCallback, processCallback != null ? processCallback : FlxObject.separate)) {
				return true;
			}
		}
		return false;
	}

	public function collideObjects():Void {
		for (object in mobileObjects) {
			var object:FlxObject = cast object;
			collideWithLevel(object);
		}
		FlxG.collide(mobileObjects, mobileObjects);
		FlxG.collide(staticObjects, mobileObjects);
	}

	public function applyGravity():Void {
		for (sprite in mobileObjects) {
			var Sprite:FlxSprite = cast sprite;
			if (Sprite.acceleration.y < gravity)
				Sprite.acceleration.y += gravity;
			else
				Sprite.acceleration.y = gravity;
		}
	}

	public function applyFriction():Void {
		for (sprite in mobileObjects) {
			var Sprite:Entidad = cast sprite;
			if (Sprite.velocity.x != 0) {
				if (Sprite.isTouching(FlxObject.FLOOR))
					Sprite.velocity.x -= Sprite.velocity.x * friction;
				else
					Sprite.velocity.x -= Sprite.velocity.x * friction / 8;
				if (Math.abs(Sprite.velocity.x) < 1)
					Sprite.velocity.x = 0;
			}
		}
	}

	function fallInClouds(Tile:FlxObject, Object:FlxObject):Void {
		if (FlxG.keys.anyPressed([DOWN, S])) {
			Tile.allowCollisions = FlxObject.NONE;
		} else if (Object.y >= Tile.y) {
			Tile.allowCollisions = FlxObject.CEILING;
		}
	}

	function wallJump(Tile:FlxObject, Object:FlxObject):Void {
		Object.velocity.y *= 0.9;
		Object.touching |= FlxObject.FLOOR | FlxObject.CEILING;
	}
}
