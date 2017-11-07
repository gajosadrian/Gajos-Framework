local ga = gajosframework

ga.User = classExtends(App, function(id)
    self._id = id
    self._logic = ga.UserLogic.new(id)
    self._view = ga.UserView.new(id)
    
    function self:GetName()
      return player(id, "name")
    end
    function self:SetName(name, hide)
      setname(name, hide or 0)
    end
end)
