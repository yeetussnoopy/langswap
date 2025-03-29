local World, super = Class("World", true)

function World:startCutscene(group, id, ...)

    Kristal.Console:log("exmems")

    if self.cutscene and not self.cutscene.ended then
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
    if Kristal.Console.is_open then
        Kristal.Console:close()
    end
    Kristal.callEvent("loadTranslations", group, "world")

    self.cutscene = WorldCutscene(self, group, id, ...)
    return self.cutscene
end

return World