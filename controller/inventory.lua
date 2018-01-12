Inventory = classExtends(Controller, function(user, xsize, ysize, style, align, x, y)
    self.user = user
    self.xsize = xsize
    self.ysize = ysize
    self.style = style
    self.align = align
    self.data = InventoryData.new(user, xsize, ysize)
    self.window = user:newWindow(style, align, x, y)
end)
