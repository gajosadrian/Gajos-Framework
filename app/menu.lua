local ga = gajosframework

ga.Menu = classExtends(App, function(id)
    self.id = id
    self._logic = ga.MenuLogic.new(id)
    self._view = ga.MenuView.new(id)
<<<<<<< HEAD
	
	function self:addButton(name, desc, visible)
	end
	
	function self:setMenuType(type)
	end
	
	function self:noskip()
	end
=======
        
        --dasda
>>>>>>> 0630f9e4bfbac126c62d8d0011d3a6487437ff7b
end
