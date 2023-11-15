---@diagnostic disable: lowercase-global

--i was going to make window moving but it lags for some reason???
--maybe i should try to make a function named "easeWindowX" things??
local dw, dh = displayWidth, displayHeight;
local cx, cy = (dw - 1280) / 2, (dh - 720) / 2;
local x,y,w,h = 0,0,0,0;

-- you can find this template in https://github.com/Mago0643/FNF-PsychEngine-Addional-Content/blob/main/docs/modhelper.lua
--set_nitg {beat, percent, mod name, percent, mod name, ..., excludes={"x"}}
function set_nitg(self)
    for i,_ in ipairs(self) do
        if i>1 and i % 2 == 0 then
            local percent = self[i] / 100;
            if self.excludes ~= nil then
                for __,v in ipairs(self.excludes) do
                    if v == self[i+1] then percent = self[i]; end
                end
            end
            set (self[1], percent..", "..self[i+1]);
        end
    end
end

function teleport(beat, len, ease, start_percent, end_percent, mod_name, exclude)
	if exclude == nil then exclude = false; end
	if not exclude then
		set_nitg {beat, start_percent, mod_name}
		ease_nitg {beat, len, ease, end_percent, mod_name}
	else
		set_nitg {beat, start_percent, mod_name, excludes={mod_name}}
		ease_nitg {beat, len, ease, end_percent, mod_name, excludes={mod_name}}
	end
end

--set_nitg {beat, len, ease, percent, mod name, percent, mod name, ..., excludes={"x"}}
function ease_nitg(self)
    for i,_ in ipairs(self) do
        if i>3 and i % 2 == 0 then
            local percent = self[i] / 100;
            if self.excludes ~= nil then
                for __,v in ipairs(self.excludes) do
                    if v == self[i+1] then percent = self[i]; end
                end
            end
            ease (self[1], self[2], self[3], percent..", "..self[i+1]);
        end
    end
end
function onCreatePost()
    if modchart then
        initMods();
        startMod("confusionoffset", "ConfusionModifier");
		startMod("bounce", "BumpyModifier");
		startMod("tandrunk", "TanDrunkXModifier");
    end

    --your mods goes here
    if modchart then
        set_nitg {0, 50, "drunk", 500, "drunk:speed", 1000, "tantipsy:speed"}
		
		ease_nitg {28, 4, "quadIn", 0, "drunk"}
		set_nitg {96, 200, "beat"}
		ease_nitg {124, 4, "quadIn", 0, "beat"}
		set_nitg {128, 400, "bounce"}
		set_nitg {192, 0, "bounce", 200, "beat"}
		ease_nitg {256, 2, "expoOut", 100, "drunk", 0, "beat"}
		ease_nitg {288, 2, "quadIn", 1000, "y", excludes={"y"}}
		
		for i = 32, 80, 16 do
			teleport(i, 2, "expoOut", 400, 0, "drunk");
			teleport(i, 2, "expoOut", 200, 100, "tinyx");
			
			teleport(i+2, 2, "expoOut", 300, 100, "tiny");
			teleport(i+2, 2, "expoOut", 360, 0, "confusionoffset", true);
			
			teleport(i+3, 2, "expoOut", 400, 0, "drunk");
			teleport(i+3, 2, "expoOut", 200, 100, "tinyx");
			
			teleport(i+5, 2, "expoOut", -400, 0, "drunk");
			teleport(i+5, 2, "expoOut", 200, 100, "tinyx");
			
			teleport(i+6, 2, "expoOut", 300, 100, "tiny");
			teleport(i+6, 2, "expoOut", -360, 0, "confusionoffset", true);
			
			teleport(i+8, 2, "expoOut", 400, 0, "drunk");
			teleport(i+8, 2, "expoOut", 200, 100, "tinyx");
			
			teleport(i+9.5, 2, "expoOut", -400, 0, "drunk");
			teleport(i+9.5, 2, "expoOut", 200, 100, "tinyx");
			
			teleport(i+10, 2, "expoOut", 300, 100, "tiny");
			teleport(i+10, 2, "expoOut", 360, 0, "confusionoffset", true);
			
			teleport(i+11, 2, "expoOut", 400, 0, "drunk");
			teleport(i+11, 2, "expoOut", 200, 100, "tinyx");
			
			teleport(i+13, 2, "expoOut", -400, 0, "drunk");
			teleport(i+13, 2, "expoOut", 200, 100, "tinyx");
			
			teleport(i+14, 2, "expoOut", 400, 0, "drunk");
			teleport(i+14, 2, "expoOut", 200, 100, "tinyx");
			teleport(i+14, 2, "expoOut", 300, 100, "tiny");
			teleport(i+14, 2, "expoOut", 360, 0, "confusionoffset", true);
			ease_nitg {i+14, 2, "quadIn", 1000, "tandrunk"}
			ease_nitg {i+16, 2, "expoOut", 0, "tandrunk"}
		end
		
		for i = 128, 176, 16 do
			teleport(i, 2, "expoOut", 400, 0, "drunk");
			teleport(i, 2, "expoOut", 25, 0, "flip");
			teleport(i, 2, "expoOut", 200, 100, "tinyx");
			
			teleport(i+2, 2, "expoOut", 300, 100, "tiny");
			teleport(i+2, 2, "expoOut", 360, 0, "confusionoffset", true);
			
			teleport(i+3, 2, "expoOut", 400, 0, "drunk");
			--teleport(i+3, 2, "expoOut", 25, 0, "flip");
			teleport(i+3, 2, "expoOut", 200, 100, "tinyx");
			
			teleport(i+5, 2, "expoOut", -400, 0, "drunk");
			teleport(i+5, 2, "expoOut", 25, 0, "flip");
			teleport(i+5, 2, "expoOut", 200, 100, "tinyx");
			
			teleport(i+6, 2, "expoOut", 300, 100, "tiny");
			teleport(i+6, 2, "expoOut", -360, 0, "confusionoffset", true);
			
			teleport(i+8, 2, "expoOut", 400, 0, "drunk");
			--teleport(i+8, 2, "expoOut", 25, 0, "flip");
			teleport(i+8, 2, "expoOut", 200, 100, "tinyx");
			
			teleport(i+9.5, 2, "expoOut", -400, 0, "drunk");
			teleport(i+9.5, 2, "expoOut", 25, 0, "flip");
			teleport(i+9.5, 2, "expoOut", 200, 100, "tinyx");
			
			teleport(i+10, 2, "expoOut", 300, 100, "tiny");
			teleport(i+10, 2, "expoOut", 360, 0, "confusionoffset", true);
			
			teleport(i+11, 2, "expoOut", 400, 0, "drunk");
			teleport(i+11, 2, "expoOut", 25, 0, "flip");
			teleport(i+11, 2, "expoOut", 200, 100, "tinyx");
			
			teleport(i+13, 2, "expoOut", -400, 0, "drunk");
			--teleport(i+13, 2, "expoOut", 25, 0, "flip");
			teleport(i+13, 2, "expoOut", 200, 100, "tinyx");
			
			teleport(i+14, 2, "expoOut", 25, 0, "flip");
			teleport(i+14, 2, "expoOut", 400, 0, "drunk");
			teleport(i+14, 2, "expoOut", 200, 100, "tinyx");
			teleport(i+14, 2, "expoOut", 300, 100, "tiny");
			teleport(i+14, 2, "expoOut", 360, 0, "confusionoffset", true);
			ease_nitg {i+14, 2, "quadIn", 1000, "tandrunk"}
			ease_nitg {i+16, 2, "expoOut", 0, "tandrunk"}
		end
		
		for i = 224, 252, 4 do
			teleport(i, 2, "expoOut", 500, 0, "drunk");
			teleport(i, 2, "expoOut", 50, 0, "flip");
			teleport(i, 2, "expoOut", 500, 100, "tinyx");
			teleport(i, 2, "expoOut", 50, 100, "tinyy");
			
			if i < 240 then
				teleport(i+1.5, 2, "expoOut", -500, 0, "drunk");
				teleport(i+1.5, 2, "expoOut", 50, 0, "flip");
				teleport(i+1.5, 2, "expoOut", 500, 100, "tinyx");
				teleport(i+1.5, 2, "expoOut", 50, 100, "tinyy");
			end
		end
    end
end