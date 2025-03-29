local Battle, super = Class("Battle", true)

function Battle:startCutscene(group, id, ...)
    if self.cutscene then
        local cutscene_name = ""
        if type(group) == "string" then
            cutscene_name = group
            if type(id) == "string" then
                cutscene_name = group.."."..id
            end
        elseif type(group) == "function" then
            cutscene_name = "<function>"
        end
        error("Attempt to start a cutscene "..cutscene_name.." while already in cutscene "..self.cutscene.id)
    end
    Kristal.callEvent("loadTranslations", group, "battle")
    self.cutscene = BattleCutscene(group, id, ...)
    return self.cutscene
end

return Battle