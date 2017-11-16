local ga = gajosframework

ga.Menu = classExtends(App, function(id)
    self.id = id
    self._logic = ga.MenuLogic.new(id)
    self._view = ga.MenuView.new(id)
        
        --dasda
end
