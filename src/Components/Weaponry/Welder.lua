local weld = {}
weld.__index = weld 


function weld.new(p0 : BasePart , p1 : BasePart,weldName :string) : table 
    local self = setmetatable( {},weld)
    self.p0 = p0
    self.p1 = p1
    self.weldName = weldName
    return self
end

function weld:newWeld()
    self.p1.CFrame = self.p0.CFrame
    local weld : any = Instance.new("Motor6D")
    weld.Part0 = self.p0
    weld.Part1 = self.p1
    weld.Name = self.Name or weld.ClassName
    weld.Parent=  weld.Part0
    return true
end
return weld