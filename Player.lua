Player = Class{}

function Player:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.score = 0
    self.speed = 200
end

function Player:move(direction, delta_time)
    if direction == 'up' then
        self.y = math.max(BOUNDS_MIN_Y, self.y + -self.speed * delta_time)
    elseif direction == 'down' then
        self.y = math.min(BOUNDS_MAX_Y, self.y + self.speed * delta_time)
    end
end

function Player:incrementScore()
    self.score = self.score + 1
end

function Player:draw()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
