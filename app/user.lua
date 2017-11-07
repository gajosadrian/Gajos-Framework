local ga = gajosframework

ga.User = class(function(id)
    self.id = id
    
    function self:GetName()
      return player(id, "name")
    end
    function self:SetName(name, hide)
      setname(name, hide or 0)
    end
end)
