Ball = Class{}

function Ball:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.x_velocity = (math.random(2) == 1 and 100 or -100)
    self.y_velocity = math.random(-50, 50)
end

function Ball:move(delta_time)
    if self:checkFloorCollision() then
        self:collide()
    end

    self.x = self.x + self.x_velocity * delta_time
    self.y = self.y + self.y_velocity * delta_time
end

function Ball:collide()
    self.y_velocity = self.y_velocity * (-1)
    self.x_velocity = self.x_velocity * (-1)
end

function Ball:checkFloorCollision()
    return (self.y >= BOUNDS_MAX_Y or self.y <= BOUNDS_MIN_Y)
end

function Ball:checkPaddleCollision(paddle)
    if (self.x >= paddle.x) and (self.x <= (paddle.x + paddle.width)) then
        if (self.y >= paddle.y) and (self.y <= (paddle.y + paddle.height)) then
            return true
        end
    end

    return false
end

function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 - 2
    self.x_velocity = (math.random(2) == 1 and 100 or -100)
    self.y_velocity = math.random(-50, 50)
end

function Ball:draw()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
