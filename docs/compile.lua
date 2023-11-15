--this is a disable script for lua extension marking your commands as warning.
--add something if you want to disable

--ignore this its just hide the thing like "Global variable in lowercase inital" thing
---@diagnostic disable: lowercase-global

---Sets The Name of Mod.
---@param name string
---@param modClass string
---@param type string|nil
---@param pf integer|nil
function startMod(name, modClass, type, pf) end

---Sets The Mod.
---@param name string
---@param value number
function setMod(name, value) end

---Sets the Sub Mod.
---@param name string
---@param subValName string
---@param value number
function setSubMod(name, subValName, value) end

---Sets the Lane Target.
---@param name string
---@param value integer
function setModTargetLane(name, value) end

---Sets the Playfield's Mod.
---@param name string
---@param value integer
function setModPlayfield(name, value) end

---Addes The Playfields.
---@param x number|nil
---@param y number|nil
---@param z number|nil
function addPlayfield(x,y,z) end

---Removes the Playfields.
---@param idx integer
function removePlayfield(idx) end

---idk what this do
---@param modifier string
---@param val number
---@param time number
---@param ease string
function tweenModifier(modifier, val, time, ease) end

---maybe this is same as tweenModifier but for subMods.
---@param modifier string
---@param subValue string
---@param val number
---@param time number
---@param ease string
function tweenModifierSubValue(modifier, subValue, val, time, ease) end

---???
---@param name string
---@param ease string
function setModEaseFunc(name, ease) end

---Applys The Modifier to Playfields.
---@param beat number decimals are allowed.
---@param argsAsString string ex) [[1, beat]]
function set(beat, argsAsString) end

---Same as `set()`, but you can tween.
---@param beat number decimals are allowed.
---@param time number how much long should tween (in beats)
---@param easeStr string ease type. ex) `quadOut`
---@param argsAsString string same as `set()`
function ease(beat, time, easeStr, argsAsString) end

---Runs an Haxe code in Lua.
---@param argsAsString string
function runHaxeCode(argsAsString) end

---Spawns a Lua Sprite with no animations using the tag `tag`, it will be using the image `image`.png, and will be spawned on
---
---position `x`, `y` If you want to make a Black screen with no texture, leave `image` field empty and use `luaSpriteMakeGraphic`
---
---If another Lua Sprite that exists is already using the tag `tag`, it will be removed.
---@param tag string
---@param image string
---@param x number
---@param y number
function makeLuaSprite(tag, image, x, y) end

---Spawns a Lua Sprite that supports Animations, it will be using the tag `tag`, be using the image `image`.png, the XML
---
---`image`.xml, and will be spawned on position `x`, `y`
---@param tag string
---@param image string
---@param x number
---@param y number
function makeAnimatedLuaSprite(tag, image, x, y) end

---Adds a Lua Sprite with the specified tag, either in front or behind the characters.
---@param tag string
---@param front boolean|nil
function addLuaSprite(tag, front) end

---Removes a Lua Sprite with specified tag.
---@param tag string The Lua Sprite's tag.
---@param destory boolean Specifies if you don't want to use the sprite anymore. Default value is `true` (Set to `false` if you want to re-add it later)
function removeLuaSprite(tag, destory) end

---Creates a Lua Text Object on Position `x`, `y` and width with `width`
---@param tag string
---@param text string
---@param width integer
---@param x number
---@param y number
function makeLuaText(tag, text, width, x, y) end

---Spawns a Lua Text on the stage.
---@param tag string
function addLuaText(tag) end

---Removes a Lua Text off the stage.
---@param tag string The Lua Sprite's tag.
---@param destory boolean Specifies if you don't want to use the sprite anymore. Default value is `true` (Set to `false` if you want to re-add it later)
function removeLuaText(tag, destory) end

---Sets Text string at the specified tag.
---@param tag string
---@param text string
function setTextString(tag, text) end

---Sets text size at the specified tag.
---@param tag string
---@param size integer
function setTextSize(tag, size) end

---Sets text width at the specified tag.
---@param tag string
---@param width number
function setTextWidth(tag, width) end

---Sets text border at the specified tag.
---@param tag string
---@param size integer
function setTextBorder(tag, size, color) end

---Sets text color at the specified tag.
---@param tag string
---@param color string
function setTextColor(tag, color) end