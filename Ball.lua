Ball = Class{__includes = GameObject}

function Ball:init(x, y, width, height)
    GameObject.init(self, {
        x = x,
        y = y,
        width = width,
        height = height,
        x_speed = (math.random(2) == 1 and 100 or -100),
        y_speed = math.random(-50, 50)
    })
end

function Ball:collide()
    self.y_speed = -self.y_speed
    self.x_speed = -self.x_speed
end

function Ball:checkFloorCollision()
    return (self.y >= BOUNDS_MAX_Y or self.y <= BOUNDS_MIN_Y)
end

function Ball:checkOutOfBoundsSide()
    if (self.x + self.width) >= BOUNDS_MAX_X then
        return 'left'
    elseif (self.x - self.width) <= BOUNDS_MIN_X then
        return 'right'
    end
end

function Ball:update(delta_time)
    if self:checkFloorCollision() then
        self:collide()
    end

    self.x = self.x + self.x_speed * delta_time
    self.y = self.y + self.y_speed * delta_time
end

function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 - 2
    self.x_speed = (math.random(2) == 1 and 100 or -100)
    self.y_speed = math.random(-50, 50)
end
