--the notes targeted Onscreen, not strums.
---@diagnostic disable: lowercase-global

function onCreatePost()
    startMod("crazyAngle", "Modifier");
    startMod("z", "ZModifier");
    startMod("centered", "Modifier")
    startMod("center", "Modifier");
    startMod("reverse", "ReverseModifier");
    startMod("stealth", "NoteStealthModifier");
    startMod("dark", "Modifier");
    startMod("stealthP1", "StealthModifier", "Opponent");

    runHaxeCode([[
        function getMod(mod:String) {
            return game.playfieldRenderer.modifiers.get(mod); 
        }

        var mod = getMod("crazyAngle");
        var cen = getMod("centered");
        var ok = getMod("center");

        mod.noteMath = function (noteData, lane, curPos, pf) {
            noteData.z += mod.currentValue * 1000 + curPos;
            noteData.y -= Math.sin((Math.PI * mod.currentValue * curPos) * 0.0005) * 150;
        }

        cen.strumMath = function(noteData, lane, pf) {
            noteData.y += cen.currentValue*(FlxG.height / 2 - 100);
        }

        cen.noteMath = function(noteData, lane, pf) {
            noteData.y += cen.currentValue*(FlxG.height / 2 - 100);
        }

        ok.strumMath = function(noteData, lane, pf) {
            if (lane < 4) {
                noteData.x += FlxG.width / 4 * ok.currentValue;
            } else {
                noteData.x -= FlxG.width / 4 * ok.currentValue;
            }
        }

        ok.noteMath = function(noteData, lane, pf) {
            if (lane < 4) {
                noteData.x += FlxG.width / 4 * ok.currentValue;
            } else {
                noteData.x -= FlxG.width / 4 * ok.currentValue;
            }
        }

        getMod("dark").strumMath = function (noteData, lane, pf) {
            noteData.alpha = 1 - getMod("dark").currentValue;
        }
    ]])

    startMod("drunk", "DrunkXModifier")
    set (0, "1, crazyAngle, 1, center, -1, centered, 1, dark, 1, reverse, 1, stealthP1")
end