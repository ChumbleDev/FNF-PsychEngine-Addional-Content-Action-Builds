package states;

import backend.Highscore;

class ScoreResultState extends MusicBeatState
{
    public var nextState:MusicBeatState;
    public function new(nextState:MusicBeatState) {
        super();
        this.nextState = nextState;
    }
    var rating:Alphabet;
    var judTxts:FlxTypedGroup<FlxText>;
    var scoreTxt:FlxText;
    var fcTxt:FlxText;
    var songName:FlxText;
    var songHighscore:Int;

    override function create()
    {
		FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.data.pauseMusic)), 0.0);
        FlxG.sound.music.fadeIn(4);

        var bg = new FlxSprite().loadGraphic(Paths.image("menuDesat"));
        bg.color = FlxColor.fromRGB(255, 178, 63);
        add(bg);

        songHighscore = Highscore.getScore(PlayState.SONG.song.toLowerCase(), PlayState.storyDifficulty);

        /* Maybe i will make this scene good if i have judgment arts
        rating = new Alphabet(0,0,"F");
        rating.screenCenter();
        rating.changeX = false;
        rating.changeY = false;
        add(rating);*/

        judTxts = new FlxTypedGroup<FlxText>();
        add(judTxts);

        var ok:Array<Array<Dynamic>> = [['Sick: ${PlayState.judResult[0]}', FlxColor.fromRGBFloat(0,1,1)], ['Good: ${PlayState.judResult[1]}', FlxColor.fromRGBFloat(0,1,0)], ['Bad: ${PlayState.judResult[2]}', FlxColor.fromRGBFloat(1,0.5,0)], ['Shit: ${PlayState.judResult[3]}', FlxColor.fromRGBFloat(0.75,0,0)], ['Misses: ${PlayState.judResult[4]}', FlxColor.fromRGBFloat(1,0,0)]];
        for (i in 0...5) {
            var txt = new FlxText(-100,200,0,ok[i][0]);
            txt.setFormat(Paths.font('vcr.ttf'), 20, FlxColor.WHITE, CENTER, OUTLINE, FlxColor.BLACK);
            txt.y += txt.height * i;
            txt.y += i != 0 ? 10 : 0;
            txt.color = ok[i][1];
            judTxts.add(txt);
        }

        songName = new FlxText(0,-100,0,PlayState.SONG.song.toLowerCase());
        songName.setFormat(Paths.font('vcr.ttf'), 32, FlxColor.WHITE, CENTER, OUTLINE, FlxColor.BLACK);
        add(songName);

        scoreTxt = new FlxText(FlxG.width,110 + songName.height,0,"0");
        scoreTxt.setFormat(Paths.font('vcr.ttf'), 25, FlxColor.WHITE, CENTER, OUTLINE, FlxColor.BLACK);
        add(scoreTxt);

        doTween(songName, {y: 100}, 1, {ease: FlxEase.quadOut, onComplete: function(t:FlxTween)
            {
                doTween(scoreTxt, {x: (FlxG.width - scoreTxt.width) / 2}, 0.5, {ease: FlxEase.quadOut, onComplete: function(f:FlxTween)
                    {
                        for (i in 0...judTxts.length) {
                            doTween(judTxts.members[i], {x: (FlxG.width - judTxts.members[i].width) / 2}, 1, {ease: FlxEase.quadOut, startDelay: 0.1 * i, onComplete: function(h:FlxTween)
                                {
                                    if (i >= judTxts.length-1) canLerp = true;
                                }
                            });
                        }
                    }
                });
            }
        });

        super.create();
    }

    var lerpScore:Float = 0;
    var canLerp:Bool = false;
    var canSkip:Bool = false;
    override function update(elapsed:Float)
    {
        if (canLerp)
        {
            lerpScore++;
            if (lerpScore >= songHighscore) {
                FlxG.camera.flash();
                FlxG.sound.play(Paths.sound("confirmMenu"));
                canSkip = true;
            }
            scoreTxt.text = Std.string(lerpScore);
            scoreTxt.screenCenter(X);
        }

        if (canSkip)
        {
            if (controls.ACCEPT) {
                FlxG.camera.flash();
                FlxG.sound.play(Paths.sound("confirmMenu"));
                new FlxTimer().start(2, function(y:FlxTimer)
                {
                    MusicBeatState.switchState(nextState);
                });
            }
        }

        super.update(elapsed);
    }
}