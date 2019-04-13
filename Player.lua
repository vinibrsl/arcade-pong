Player = Class{__includes = GameObject}

function Player:init(x, y, width, height)
    GameObject.init(self, {
        x = x,
        y = y,
        width = width,
        height = height,
        x_speed = 0.0,
        y_speed = 200.0
    })

    self.score = 0
end

function Player:incrementScore()
    self.score = self.score + 1
end

function Player:update(direction, delta_time)
    if direction == 'up' then
        self.y = math.max(BOUNDS_MIN_Y, self.y + -self.y_speed * delta_time)
    elseif direction == 'down' then
        self.y = math.min(BOUNDS_MAX_Y, self.y + self.y_speed * delta_time)
    end
end

function Player:draw()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
