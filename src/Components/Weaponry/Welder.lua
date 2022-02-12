local weld = {}
weld.__index = weld 


function weld.new(p0 : BasePart , p1 : BasePart,weldType:string,weldName :string) : table 
    local self = setmetatable({
        p0,
        p1,      
        weldType,
    },weld)
    return self
end

function weld:newWeld()
    self.p1.CFrame = self.p0.CFrame
    local weld : any = Instance.new(self.weldType)
    weld.Part0 = self.p0
    weld.Part1 = self.p1
    weld.Name = self.Name or weld.ClassName
    weld.Parent=  weld.Part0
end
return weld