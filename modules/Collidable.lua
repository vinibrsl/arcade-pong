Collidable = {
    checkCollision = function(self, other)
        return (self.x >= other.x) and
            (self.x <= (other.x + other.width)) and
            (self.y >= other.y) and
            (self.y <= (other.y + other.height))
    end,

    checkWallCollision = function(self)
        return ((self.x + self.width) >= VIRTUAL_WIDTH) or
            ((self.x - self.width) <= 0)

    end,

    checkFloorCollision = function(self)
        return ((self.y + self.height) >= VIRTUAL_HEIGHT) or
        ((self.y - self.height) <= 0)
    end
}
