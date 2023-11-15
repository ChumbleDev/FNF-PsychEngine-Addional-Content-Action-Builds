package backend;

import flixel.FlxSubState;

class MusicBeatSubstate extends FlxSubState
{
	public function new()
	{
		super();
	}

	private var curSection:Int = 0;
	private var stepsToDo:Int = 0;

	private var lastBeat:Float = 0;
	private var lastStep:Float = 0;

	private var curStep:Int = 0;
	private var curBeat:Int = 0;

	private var curDecStep:Float = 0;
	private var curDecBeat:Float = 0;
	private var controls(get, never):Controls;

	inline function get_controls():Controls
		return Controls.instance;

	/**
	* Just A `Math.sin` function with correct speed with current bpm.
	*/
	public function sin(?range:Float = 1, ?speed:Float = 1)
		{
			return Math.sin(curDecBeat*Math.PI*speed)*range;
		}
	
		/**
		* Just A `Math.cos` function with correct speed with current bpm.
		*/
		public function cos(?range:Float = 1, ?speed:Float = 1)
		{
			return Math.cos(curDecBeat*Math.PI*speed)*range;
		}
	
		/**
		* Just A `Math.tan` function with correct speed with current bpm.
		*/
		public function tan(?range:Float = 1, ?speed:Float = 1)
		{
			return Math.tan(curDecBeat*Math.PI*speed)*range;
		}

	private var curTweens(default, null):Array<FlxTween> = [];
	/**
	* Same as `FlxTween.tween`, but it addes the tween to the
	* `curTweens`.
	*
	* If you use this function, you can access this tween from `curTweens`.
	*
	* If Tween Ends, Removes This Tween from `curTweens`.
	* @return Tween Object.
	*/
	private function doTween(Object:Dynamic, Vaules:Dynamic, Duration:Float, ?Options:TweenOptions)
	{
		Options.onComplete = function(t:FlxTween)
		{
			// do the tween's oncomplete function if it is not null
			if (Options.onComplete != null) Options.onComplete(t);
			// remove this tween from curTweens.
			curTweens.remove(t);
		};
		var twn = FlxTween.tween(Object, Vaules, Duration, Options);
		curTweens.push(twn);
		return twn;
	}

	override function update(elapsed:Float)
	{
		//everyStep();
		if(!persistentUpdate) MusicBeatState.timePassedOnState += elapsed;
		var oldStep:Int = curStep;

		updateCurStep();
		updateBeat();

		if (oldStep != curStep)
		{
			if(curStep > 0)
				stepHit();

			if(PlayState.SONG != null)
			{
				if (oldStep < curStep)
					updateSection();
				else
					rollbackSection();
			}
		}

		super.update(elapsed);
	}

	private function updateSection():Void
	{
		if(stepsToDo < 1) stepsToDo = Math.round(getBeatsOnSection() * 4);
		while(curStep >= stepsToDo)
		{
			curSection++;
			var beats:Float = getBeatsOnSection();
			stepsToDo += Math.round(beats * 4);
			sectionHit();
		}
	}

	private function rollbackSection():Void
	{
		if(curStep < 0) return;

		var lastSection:Int = curSection;
		curSection = 0;
		stepsToDo = 0;
		for (i in 0...PlayState.SONG.notes.length)
		{
			if (PlayState.SONG.notes[i] != null)
			{
				stepsToDo += Math.round(getBeatsOnSection() * 4);
				if(stepsToDo > curStep) break;
				
				curSection++;
			}
		}

		if(curSection > lastSection) sectionHit();
	}

	private function updateBeat():Void
	{
		curBeat = Math.floor(curStep / 4);
		curDecBeat = curDecStep/4;
	}

	private function updateCurStep():Void
	{
		var lastChange = Conductor.getBPMFromSeconds(Conductor.songPosition);

		var shit = ((Conductor.songPosition - ClientPrefs.data.noteOffset) - lastChange.songTime) / lastChange.stepCrochet;
		curDecStep = lastChange.stepTime + shit;
		curStep = lastChange.stepTime + Math.floor(shit);
	}

	public function stepHit():Void
	{
		if (curStep % 4 == 0)
			beatHit();
	}

	public function beatHit():Void
	{
		//do literally nothing dumbass
	}
	
	public function sectionHit():Void
	{
		//yep, you guessed it, nothing again, dumbass
	}
	
	function getBeatsOnSection()
	{
		var val:Null<Float> = 4;
		if(PlayState.SONG != null && PlayState.SONG.notes[curSection] != null) val = PlayState.SONG.notes[curSection].sectionBeats;
		return val == null ? 4 : val;
	}
}
