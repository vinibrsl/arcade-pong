push = require './vendor/push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

BOUNDS_MIN_Y = 0
BOUNDS_MAX_Y = (VIRTUAL_HEIGHT - 20)
BOUNDS_MIN_X = 0
BOUNDS_MAX_X = (VIRTUAL_WIDTH)

local Ball = {}
function Ball:new()
    o = {
        x = VIRTUAL_WIDTH / 2 - 2,
        y = VIRTUAL_HEIGHT / 2 - 2,
        height = 4,
        width = 4,
        x_velocity = (math.random(2) == 1 and 100 or -100),
        y_velocity = math.random(-50, 50)
    }

    setmetatable(o, self)
    self.__index = self
    return o
end
function Ball:move(delta_time)
    if self:checkFloorCollision() then
        self:collide()
    end

    self.x = self.x + self.x_velocity * delta_time
    self.y = self.y + self.y_velocity * delta_time
end
function Ball:checkFloorCollision()
    return (self.y >= BOUNDS_MAX_Y or self.y <= BOUNDS_MIN_Y)
end
function Ball:collide()
    self.y_velocity = self.y_velocity * (-1)
end
function Ball:reset()
    -- TODO: call Ball:new or something else, as this is duplicate
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 - 2
    self.x_velocity = (math.random(2) == 1 and 100 or -100)
    self.y_velocity = math.random(-50, 50)
end
function Ball:draw()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

local Player = {}
function Player:new()
    o = {
        score = 0,
        x = 0,
        y = 0,
        width = 5,
        height = 20,
        speed = 200
    }

    setmetatable(o, self)
    self.__index = self
    return o
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

function love.load()
    math.randomseed(os.time())

    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.graphics.setFont(
        love.graphics.newFont('assets/retro.ttf', 8)
    )

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    player_1 = Player:new()
    player_1.x = 10
    player_1.y = 30

    player_2 = Player:new()
    player_2.x = (VIRTUAL_WIDTH - 10)
    player_2.y = (VIRTUAL_HEIGHT - 50)

    ball = Ball:new()
end

function love.update(delta_time)
    if love.keyboard.isDown('w') then
        player_1:move('up', delta_time)
    elseif love.keyboard.isDown('s') then
        player_1:move('down', delta_time)
    end

    if love.keyboard.isDown('up') then
        player_2:move('up', delta_time)
    elseif love.keyboard.isDown('down') then
        player_2:move('down', delta_time)
    end

    -- collision check
    -- TODO: area vs coordinate
    if (ball.x == player_1.x) and (ball.y == player_1.y) then
        ball:collide()
    elseif (ball.x == player_2.x) and (ball.y == player_2.y) then
        ball:collide()
    end

    if ball.x >= BOUNDS_MAX_X then
        player_1:incrementScore()
        ball:reset()
    elseif ball.x <= BOUNDS_MIN_X then
        player_2:incrementScore()
        ball:reset()
    end

    ball:move(delta_time)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.draw()
    push:apply('start')

    love.graphics.printf('Pong!', 0, 20, VIRTUAL_WIDTH, 'center')

    drawScores()

    player_1:draw()
    player_2:draw()
    ball:draw()

    push:apply('end')
end

function drawScores()
    love.graphics.print(
        tostring(player_1.score),
        VIRTUAL_WIDTH / 2 - 50,
        VIRTUAL_HEIGHT / 3
    )

    love.graphics.print(
        tostring(player_2.score),
        VIRTUAL_WIDTH / 2 + 30,
        VIRTUAL_HEIGHT / 3
    )
end
