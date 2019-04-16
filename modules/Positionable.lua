Positionable = {
    centerX = function(self)
        self.x = (VIRTUAL_WIDTH / 2)
    end,

    centerY = function(self)
        self.y = (VIRTUAL_HEIGHT / 2)
    end,

    center = function(self)
        self:centerX()
        self:centerY()
    end
}
