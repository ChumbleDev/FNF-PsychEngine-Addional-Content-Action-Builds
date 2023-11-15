package;

import backend.Window;
import openfl.text.TextFormat;
import flixel.graphics.FlxGraphic;

import flixel.FlxGame;
import flixel.FlxState;
import openfl.Assets;
import openfl.Lib;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.display.StageScaleMode;
import lime.app.Application;
import states.TitleState;

#if linux
import lime.graphics.Image;
#end

//crash handler stuff
#if CRASH_HANDLER
import openfl.events.UncaughtErrorEvent;
import haxe.CallStack;
import haxe.io.Path;
import sys.FileSystem;
import sys.io.File;
import sys.io.Process;
#end

class Main extends Sprite
{
	var game = {
		width: 1280, // WINDOW width
		height: 720, // WINDOW height
		initialState: TitleState, // initial game state
		zoom: -1.0, // game state bounds
		framerate: 60, // default framerate
		skipSplash: true, // if the default flixel splash screen should be skipped
		startFullscreen: false // if the game should start at fullscreen mode
	};

	public static var fpsVar:FPS;
	#if ENABLE_SHITS
	public static var april_fools:Bool = false;
	#end

	// Change this if you want to change fps text settings
	/**
	* Changes FPS Font If you edit This.
	*/
	public static var fpsSettings(default,set):{font:String,size:Int,?visible:Bool,?bold:Bool,?italic:Bool,?underline:Bool};
	static function set_fpsSettings(data:{font:String,size:Int,?visible:Bool,?bold:Bool,?italic:Bool,?underline:Bool}) {
		if (fpsVar != null)
		{
			fpsVar.setTextFormat(new TextFormat(data.font, data.size, null, data.bold, data.italic, data.underline));
			fpsVar.visible = data.visible;
		}
		return data;
	}

	// You can pretty much ignore everything from here on - your code should go in your states.

	public static function main():Void
	{
		Lib.current.addChild(new Main());
	}

	public function new()
	{
		super();

		if (stage != null)
		{
			init();
		}
		else
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}

	private function init(?E:Event):Void
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

		setupGame();
	}

	private function setupGame():Void
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (game.zoom == -1.0)
		{
			var ratioX:Float = stageWidth / game.width;
			var ratioY:Float = stageHeight / game.height;
			game.zoom = Math.min(ratioX, ratioY);
			game.width = Math.ceil(stageWidth / game.zoom);
			game.height = Math.ceil(stageHeight / game.zoom);
		}
	
		#if LUA_ALLOWED Lua.set_callbacks_function(cpp.Callable.fromStaticFunction(psychlua.CallbackHandler.call)); #end
		Controls.instance = new Controls();
		ClientPrefs.loadDefaultKeys();
		addChild(new FlxGame(game.width, game.height, game.initialState, #if (flixel < "5.0.0") game.zoom, #end game.framerate, game.framerate, game.skipSplash, game.startFullscreen));

		#if !mobile
		fpsVar = new FPS(10, 3, 0xFFFFFF);
		fpsSettings = {font: Paths.font('vcr.ttf'), size: 16, bold: false, italic: false, underline: false};
		addChild(fpsVar);
		Lib.current.stage.align = "tl";
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		if(fpsVar != null) {
			fpsVar.visible = ClientPrefs.data.showFPS;
		}
		#end

		Window.reset();

		#if ENABLE_SHITS
		var leDate = Date.now();
		april_fools = leDate.getDate() == 1 && leDate.getMonth() == 3;
		randomTitle();
		#end
		
		#if linux
		var icon = Image.fromFile("icon.png");
		Lib.current.stage.window.setIcon(icon);
		#end

		#if html5
		FlxG.autoPause = false;
		FlxG.mouse.visible = false;
		#end
		
		#if CRASH_HANDLER
		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onCrash);
		#end

		#if desktop
		DiscordClient.start();
		#end

		// shader coords fix
		FlxG.signals.gameResized.add(function (w, h) {
		     if (FlxG.cameras != null) {
			   for (cam in FlxG.cameras.list) {
				@:privateAccess
				if (cam != null && cam._filters != null)
					resetSpriteCache(cam.flashSprite);
			   }
		     }

		     if (FlxG.game != null)
			 resetSpriteCache(FlxG.game);
		});
	}

	static function resetSpriteCache(sprite:Sprite):Void {
		@:privateAccess {
		        sprite.__cacheBitmap = null;
			sprite.__cacheBitmapData = null;
		}
	}

	#if ENABLE_SHITS
	public static function randomTitle()
	{
		if (april_fools) {
			var randomTitles = [
				"Psych Engine: Friday Night Funkin'", "What if the whole world turned their swag on....",
				// lol
				"What the fuck did you just fucking say about me, you little bitch? I'll have you know 
				I graduated top of my class in the Navy Seals, and I've been involved in numerous secret raids on Al-Quaeda, 
				and I have over 300 confirmed kills. I am trained in gorilla warfare and I'm the top sniper in the entire US armed forces. 
				You are nothing to me but just another target. I will wipe you the fuck out with precision the likes of which has 
				never been seen before on this Earth, mark my fucking words. You think you can get away with saying that shit to me 
				over the Internet? Think again, fucker. As we speak I am contacting my secret network of spies across the USA 
				and your IP is being traced right now so you better prepare for the storm, maggot. The storm that wipes out the pathetic 
				little thing you call your life. You're fucking dead, kid. I can be anywhere, anytime, and I can kill you in over seven hundred 
				ways, and that's just with my bare hands. Not only am I extensively trained in unarmed combat, but I have access to the entire 
				arsenal of the United States Marine Corps and I will use it to its full extent to wipe your miserable ass off the face of the 
				continent, you little shit. If only you could have known what unholy retribution your little \"clever\" comment was about to 
				bring down upon you, maybe you would have held your fucking tongue. But you couldn't, you didn't, and now you're paying the 
				price, you goddamn idiot. I will shit fury all over you and you will drown in it. You're fucking dead, kiddo",
				"Friday Night Fuckin': Psych Engine Additional", Lib.application.window.title, "Null Object Refernce", "Null Function Pointer",
				"Stream TUTORIAL ON HOW TO TWERK BY @djTWERKINGCREWMATE.gif by DJnexpolifortnite2006 on desktop and mobile. Play over 320 million tracks for free on Soundcloud.",
				"Sart Pooper - Golden Apple OST", "Black Mesa", "Bad arse", "Please do not make bambi spamtracks on this engine...",
				"That SOLDIER is bloody SENTRY! *laughs*", "Half life 2", "Oneshot", "one bad scrink", "vivid/stasis", "NotFNF",
				"The Hardst Mod in Friday Night Funkin'!!!!", "GUYS LOOK AT THIS https://twitter.com/Windows/status/1719138365516210225",
				"Attention! There is a cheater on the other team named 'nuh uh'. Please kick them!", "Your current IQ is 198.054.02.10050351",
				"How do i made an effect that making smears by reusing textures from previous frame", "woah this is so long random titles",
				"COCK", "i ran out of names", "are you gay? frfr?????"
			];
			var rnd = FlxG.random.getObject(randomTitles).replace("\t", "");
			Window.title = rnd;
		}
	}
	#end

	// Code was entirely made by sqirra-rng for their fnf engine named "Izzy Engine", big props to them!!!
	// very cool person for real they don't get enough credit for their work
	#if CRASH_HANDLER
	function onCrash(e:UncaughtErrorEvent):Void
	{
		var errMsg:String = "";
		var path:String;
		var callStack:Array<StackItem> = CallStack.exceptionStack(true);
		var dateNow:String = Date.now().toString();

		dateNow = dateNow.replace(" ", "_");
		dateNow = dateNow.replace(":", "'");

		path = "./crash/" + "PsychEngine_" + dateNow + ".txt";

		for (stackItem in callStack)
		{
			switch (stackItem)
			{
				case FilePos(s, file, line, column):
					errMsg += file + " (line " + line + ")\n";
				default:
					Sys.println(stackItem);
			}
		}

		errMsg += "\nUncaught Error: " + e.error + "\nPlease report this error to the GitHub page: https://github.com/ShadowMario/FNF-PsychEngine\n\n> Crash Handler written by: sqirra-rng";

		if (!FileSystem.exists("./crash/"))
			FileSystem.createDirectory("./crash/");

		File.saveContent(path, errMsg + "\n");

		Sys.println(errMsg);
		Sys.println("Crash dump saved in " + Path.normalize(path));

		Application.current.window.alert(errMsg, "Error!");
		DiscordClient.shutdown();
		Sys.exit(1);
	}
	#end
}
