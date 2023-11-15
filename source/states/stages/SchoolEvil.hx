package states.stages;

import flixel.FlxSubState;
import objects.Note;
import flixel.addons.effects.FlxTrail;
import states.stages.objects.*;
import substates.GameOverSubstate;
import cutscenes.DialogueBox;

#if MODS_ALLOWED
import sys.FileSystem;
#else
import openfl.utils.Assets as OpenFlAssets;
#end

class SchoolEvil extends BaseStage
{
	var tweenShit:Array<FlxTween> = [];
	var leftBar:FlxSprite;
	var rightBar:FlxSprite;
	override function create()
	{
		var _song = PlayState.SONG;
		if(_song.gameOverSound == null || _song.gameOverSound.trim().length < 1) GameOverSubstate.deathSoundName = 'fnf_loss_sfx-pixel';
		if(_song.gameOverLoop == null || _song.gameOverLoop.trim().length < 1) GameOverSubstate.loopSoundName = 'gameOver-pixel';
		if(_song.gameOverEnd == null || _song.gameOverEnd.trim().length < 1) GameOverSubstate.endSoundName = 'gameOverEnd-pixel';
		if(_song.gameOverChar == null || _song.gameOverChar.trim().length < 1) GameOverSubstate.characterName = 'bf-pixel-dead';
		
		var posX = 400;
		var posY = 200;

		var bg:BGSprite;
		if(!ClientPrefs.data.lowQuality)
			bg = new BGSprite('weeb/animatedEvilSchool', posX, posY, 0.8, 0.9, ['background 2'], [true]);
		else
			bg = new BGSprite('weeb/animatedEvilSchool_low', posX, posY, 0.8, 0.9);

		bg.scale.set(PlayState.daPixelZoom, PlayState.daPixelZoom);
		bg.antialiasing = false;
		add(bg);
		setDefaultGF('gf-pixel');

		FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
		FlxG.sound.music.fadeIn(1, 0, 0.8);
		if(isStoryMode && !seenCutscene)
		{
			initDoof();
			setStartCallback(schoolIntro);
		}

		leftBar = new FlxSprite(-200).makeGraphic(200, FlxG.height, FlxColor.BLACK);
		leftBar.cameras = [PlayState.instance.camHUD];
		add(leftBar);

		rightBar = new FlxSprite(FlxG.width).makeGraphic(200, FlxG.height, FlxColor.BLACK);
		rightBar.cameras = [PlayState.instance.camHUD];
		add(rightBar);
	}
	override function createPost()
	{
		var trail:FlxTrail = new FlxTrail(dad, null, 4, 24, 0.3, 0.069);
		addBehindDad(trail);
	}

	override function countdownTick(count:Countdown, num:Int)
		{
			switch(count)
			{
				default:
				case ONE:
					tweenShit.push(FlxTween.tween(leftBar, {x: 0}, (Conductor.crochet / 1000) * 4, {ease: FlxEase.expoOut, onComplete: function(t:FlxTween) tweenShit.remove(t)}));
					tweenShit.push(FlxTween.tween(rightBar, {x: FlxG.width - rightBar.width}, (Conductor.crochet / 1000) * 4, {ease: FlxEase.expoOut, onComplete: function(t:FlxTween) tweenShit.remove(t)}));
					for (p in PlayState.instance.playerStrums) tweenShit.push(FlxTween.tween(p, {x: p.x - 90}, Conductor.crochet / 1000 * 4, {ease: FlxEase.expoOut, onComplete: function(t:FlxTween) tweenShit.remove(t)}));
					for (p in PlayState.instance.opponentStrums) tweenShit.push(FlxTween.tween(p, {x: p.x + 107}, Conductor.crochet / 1000 * 4, {ease: FlxEase.expoOut, onComplete: function(t:FlxTween) tweenShit.remove(t)}));
			}
		}
	
		override function openSubState(SubState:FlxSubState)
		{
			for (tweens in tweenShit) {
				tweens.active = false;
			}
	
			super.openSubState(SubState);
		}
	
		override function closeSubState()
		{
			for (tweens in tweenShit) {
				tweens.active = true;
			}
	
			super.closeSubState();
		}

	// Ghouls event
	var bgGhouls:BGSprite;
	override function eventCalled(eventName:String, value1:String, value2:String, flValue1:Null<Float>, flValue2:Null<Float>, strumTime:Float)
	{
		switch(eventName)
		{
			case "Trigger BG Ghouls":
				if(!ClientPrefs.data.lowQuality)
				{
					bgGhouls.dance(true);
					bgGhouls.visible = true;
				}
		}
	}
	override function eventPushed(event:objects.Note.EventNote)
	{
		// used for preloading assets used on events
		switch(event.event)
		{
			case "Trigger BG Ghouls":
				if(!ClientPrefs.data.lowQuality)
				{
					bgGhouls = new BGSprite('weeb/bgGhouls', -100, 190, 0.9, 0.9, ['BG freaks glitch instance'], [false]);
					bgGhouls.setGraphicSize(Std.int(bgGhouls.width * PlayState.daPixelZoom));
					bgGhouls.updateHitbox();
					bgGhouls.visible = false;
					bgGhouls.antialiasing = false;
					bgGhouls.animation.finishCallback = function(name:String)
					{
						if(name == 'BG freaks glitch instance')
							bgGhouls.visible = false;
					}
					addBehindGF(bgGhouls);
				}
		}
	}

	var doof:DialogueBox = null;
	function initDoof()
	{
		var file:String = Paths.txt(songName + '/' + songName + 'Dialogue'); //Checks for vanilla/Senpai dialogue
		#if MODS_ALLOWED
		if (!FileSystem.exists(file))
		#else
		if (!OpenFlAssets.exists(file))
		#end
		{
			startCountdown();
			return;
		}

		doof = new DialogueBox(false, CoolUtil.coolTextFile(file));
		doof.cameras = [camHUD];
		doof.scrollFactor.set();
		doof.finishThing = startCountdown;
		doof.nextDialogueThing = PlayState.instance.startNextDialogue;
		doof.skipDialogueThing = PlayState.instance.skipDialogue;
	}
	
	function schoolIntro():Void
	{
		inCutscene = true;
		var red:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, 0xFFff1b31);
		red.scrollFactor.set();
		add(red);

		var senpaiEvil:FlxSprite = new FlxSprite();
		senpaiEvil.frames = Paths.getSparrowAtlas('weeb/senpaiCrazy');
		senpaiEvil.animation.addByPrefix('idle', 'Senpai Pre Explosion', 24, false);
		senpaiEvil.setGraphicSize(Std.int(senpaiEvil.width * 6));
		senpaiEvil.scrollFactor.set();
		senpaiEvil.updateHitbox();
		senpaiEvil.screenCenter();
		senpaiEvil.x += 300;
		camHUD.visible = false;

		new FlxTimer().start(2.1, function(tmr:FlxTimer)
		{
			if (doof != null)
			{
				add(senpaiEvil);
				senpaiEvil.alpha = 0;
				new FlxTimer().start(0.3, function(swagTimer:FlxTimer)
				{
					senpaiEvil.alpha += 0.15;
					if (senpaiEvil.alpha < 1)
					{
						swagTimer.reset();
					}
					else
					{
						senpaiEvil.animation.play('idle');
						FlxG.sound.play(Paths.sound('Senpai_Dies'), 1, false, null, true, function()
						{
							remove(senpaiEvil);
							senpaiEvil.destroy();
							remove(red);
							red.destroy();
							FlxG.camera.fade(FlxColor.WHITE, 0.01, true, function()
							{
								add(doof);
								camHUD.visible = true;
							}, true);
						});
						new FlxTimer().start(3.2, function(deadTime:FlxTimer)
						{
							FlxG.camera.fade(FlxColor.WHITE, 1.6, false);
						});
					}
				});
			}
		});
	}
}