--Note Makes a Big Circle when they are moving.
function onCreatePost()
    startMod("circle", "Modifier");
    startMod("reverse", "ReverseModifier");
    startMod("brake", "BrakeModifier");
    runHaxeCode([[
        function getMod(mod:String) {
            return game.playfieldRenderer.modifiers.get(mod); 
        }

        var circle = getMod("circle");
        
        circle.noteMath = function(noteData, lane, curPos, pf) {
            noteData.y += Math.sin((curPos * circle.currentValue) * 0.008) * (400 * (curPos/FlxG.height));
            noteData.z += Math.cos((curPos * 0.008 * circle.currentValue)) * (400 * (curPos/FlxG.height));
        }
    ]]);

    set (0, "1, circle, 0.5, reverse, 1, brake");
end