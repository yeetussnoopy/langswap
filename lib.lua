local lib = {}


function lib:onRegistered()
    self.language = Kristal.getLibConfig("langswap", "default_language")
    self.translations = {}
    Kristal.Console:log(self.language)


    --Kristal.Console:log(Utils.dump(Utils.getFilesRecursive("mods/example/libraries/langswap/translations", "json")))
end

function lib:init()
    print("Loaded langswap library")
end

function lib:postInit(new_file)
    local function processFun(a, b)
        self:loadTranslations(a, b)
    end

    Utils.hook(Game, "startLegend", function (orig, self, cutscene, options)
        Kristal.callEvent("loadTranslations", cutscene, "legend")

        orig(self, cutscene, options)

    end)



   --[[] Utils.hook(Cutscene, "parseFromGetter", function (orig, self, getter, cutscene, id, ...)
        --processFun(group, "world")

        orig(self, getter, cutscene, id, ...)
        --Kristal.Console:log("group: " .. cutscene)
    end)]]
end

function lib:loadTranslations(cutscene_namer, stage)
    local cutscene_name = cutscene_namer
    if type(cutscene_name) == "function" then
        cutscene_name = "<function>"
    end

    Kristal.Console:log("name: " .. cutscene_name)

    --maybe preloading all the cutscenes...?
    --but im a lazy loading hater :heartbreak:

    --[[ for path, lib in Kristal.iterLibraries() do
            local full_path = "mods/" .. Mod.info.id .. "/libraries/"..path.."/translations/"..cutscene_name..".json"
            if love.filesystem.getInfo(full_path) then
            self.translations = JSON.decode(love.filesystem.read(full_path))
           end
        end]]
    --Kristal.Console:log("cutscene_name" ..cutscene_name)

    local read_already = false
    local function checkPath(path_extension)
        local full_path = "mods/" .. path_extension .. "/translations/" .. stage .. "/" .. cutscene_name .. ".json"
        --Kristal.Console:log("full_path" ..full_path)
        if love.filesystem.getInfo(full_path) and not read_already then
            self.translations = JSON.decode(love.filesystem.read(full_path))
            local read_already = true
        end
    end

    checkPath(Mod.info.folder)
    -- Kristal.Console:log("dump 1: " ..Utils.dump(self.translations))

    checkPath(Mod.info.id .. "/libraries/" .. self.info.folder)

   -- Kristal.Console:log("dump 2: " .. Utils.dump(self.translations))
end

function lib:switchLang(lang)
    self.language = lang
end

function lib:getText(key)
   -- Kristal.Console:log("hiihihiih " .. Utils.dump(self.translations))

    -- Kristal.Console:log("key: " .. self.translations[self.language])
    --Kristal.Console:log("hiihihiih " .. Utils.dump(self.translations[self.language]))


    return self.translations[self.language] and self.translations[self.language][key] or key .. "_error"
end

return lib
