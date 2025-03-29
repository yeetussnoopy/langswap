local Cutscene, super = Class("Cutscene", false)

function Cutscene:parseFromGetter(getter, cutscene, id, ...)

    self:explode()
    Kristal.Console:log("cutscene")
    self.getter = getter
    if type(cutscene) == "function" then
        self.id = "<function>"
        return cutscene, {id, ...}
    elseif type(cutscene) == "string" then
        local dotsplit = Utils.split(cutscene, ".")
        if #dotsplit > 1 then
            local scene = getter(dotsplit[1], dotsplit[2])

            if scene then
                self.id = cutscene
                return scene, {id, ...}
            else
                error("No cutscene found: "..cutscene)
            end
        else
            local scene, grouped = getter(cutscene, id)
            if scene then
                if grouped then
                    self.id = cutscene.."."..id
                    return scene, {...}
                else
                    self.id = cutscene
                    return scene, {id, ...}
                end
            else
                if type(id) == "string" then
                    error("No cutscene found: "..cutscene.."."..id)
                else
                    error("No cutscene found: "..cutscene)
                end
            end
        end
    else
        error("Attempt to start nil cutscene")
    end
end


return Cutscene