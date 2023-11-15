--idk just copypaste it to your modchart code to do the simple mod thing.
---@diagnostic disable: lowercase-global

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
    initMods();

    --your mods goes here
    
end