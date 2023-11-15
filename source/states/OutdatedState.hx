package states;

class OutdatedState extends MusicBeatState
{
	public static var leftState:Bool = false;

	var warnTxt:FlxText;
	var warnText:FlxText;
	override function create()
	{
		super.create();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		warnText = new FlxText(0, 0, FlxG.width,
			"Hey you! yeah you, looks like you're running an   \n
			outdated version of Psych Engine Additional Ver (" + MainMenuState.additionalVersion.getVer().trim() + "),\n
			Please update to " + TitleState.updateVersion + "!\n
			Press ESCAPE to proceed anyway.\n
			\n",32);
		warnText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		warnText.screenCenter(Y);
		add(warnText);

		warnTxt = new FlxText(-5,0,FlxG.width - 200, FlxG.random.getObject(["Thank you for using the Engine!", "Where you looki\ng at?",
		"What are you looking for?\nGo to Github and Download the New Version!!", "https://www.youtube.com/watch?v=GtL1huin9EE",
		"https://store.steampowered.com/app/420530/OneShot/", "https://www.youtube.com/watch?v=RvVdFXOFcjw", "What the fuck did you just fucking say about me, you little bitch? I'll have you know I graduated top of my class in the Navy Seals, and I've been involved in numerous secret raids on Al-Quaeda, and I have over 300 confirmed kills. I am trained in gorilla warfare and I'm the top sniper in the entire US armed forces. You are nothing to me but just another target. I will wipe you the fuck out with precision the likes of which has never been seen before on this Earth, mark my fucking words. You think you can get away with saying that shit to me  over the Internet? Think again, fucker. As we speak I am contacting my secret network of spies across the USA and your IP is being traced right now so you better prepare for the storm, maggot. The storm that wipes out the pathetic little thing you call your life. You're fucking dead, kid. I can be anywhere, anytime, and I can kill you in over seven hundred ways, and that's just with my bare hands. Not only am I extensively trained in unarmed combat, but I have access to the entire arsenal of the United States Marine Corps and I will use it to its full extent to wipe your miserable ass off the face of the continent, you little shit. If only you could have known what unholy retribution your little \"clever\" comment was about to bring down upon you, maybe you would have held your fucking tongue. But you couldn't, you didn't, and now you're paying the price, you goddamn idiot. I will shit fury all over you and you will drown in it. You're fucking dead, kiddo"]),32);
		warnTxt.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		warnTxt.screenCenter(X);
		warnTxt.y = warnText.y;
		warnTxt.y += 32 * 8;
		warnTxt.y += 90;
		add(warnTxt);

		FlxG.mouse.visible = true;
	}

	override function update(elapsed:Float)
	{
		if(!leftState) {
			if (controls.ACCEPT) {
				leftState = true;
				CoolUtil.browserLoad("https://github.com/Mago0643/FNF-PsychEngine-Addional-Content/releases");
			}
			else if(controls.BACK) {
				leftState = true;
			}

			if (warnTxt.text.contains("https://")) {
				warnTxt.color = FlxG.mouse.overlaps(warnTxt) ? FlxColor.BLUE : FlxColor.WHITE;
				if (FlxG.mouse.overlaps(warnTxt) && FlxG.mouse.justPressed)
				{
					CoolUtil.browserLoad(warnTxt.text);
					switch (warnTxt.text) {
						case "https://www.youtube.com/watch?v=GtL1huin9EE":
							warnTxt.text = "XD GET RICKROLLED!!";
						case "https://store.steampowered.com/app/420530/OneShot/":
							warnTxt.text = "Play Oneshot It's Good Game";
						case "https://www.youtube.com/watch?v=RvVdFXOFcjw":
							warnTxt.text = "Tick-tock Heavy like a Brinks truck Looking like I'm tip-top Shining like a wristwatch Time will grab your wrist Lock it down 'til the thing pop Can you stick around for a minute 'til the ring stop? Please, God Tick-tock Heavy like a Brinks truck Looking like I'm tip-top Shining like a wristwatch Time will grab your wrist Lock it down 'til the thing pop Can you stick around for a minute 'til the ring stop? Please, God";
					}
					leftState = true;
					warnTxt.color = FlxColor.LIME;
				}
			}

			if(leftState)
			{
				FlxG.mouse.visible = false;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				FlxTween.tween(warnText, {alpha: 0}, 1, {
					onComplete: function (twn:FlxTween) {
						MusicBeatState.switchState(new MainMenuState());
					}
				});
				FlxTween.tween(warnTxt, {alpha: 0}, 1);
			}
		}
		super.update(elapsed);
	}
}
