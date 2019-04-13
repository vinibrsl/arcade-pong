GameObject = Class{
    init = function(self, args)
        self.x = args.x or 0
        self.y = args.y or 0

        self.width = args.width or 0
        self.height = args.height or 0

        self.x_speed = args.x_speed or 0.0
        self.y_speed = args.y_speed or 0.0
    end
}

function GameObject:checkCollision(other)
    return (self.x >= other.x) and
        (self.x <= (other.x + other.width)) and
        (self.y >= other.y) and
        (self.y <= (other.y + other.height))
end

function GameObject:draw()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
