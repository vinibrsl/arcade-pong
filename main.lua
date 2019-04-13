push = require './vendor/push'
Class = require './vendor/class'
require 'GameObject'
require 'Player'
require 'Ball'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

BOUNDS_MIN_Y = 0
BOUNDS_MAX_Y = (VIRTUAL_HEIGHT - 20)
BOUNDS_MIN_X = 0
BOUNDS_MAX_X = (VIRTUAL_WIDTH)

function love.load()
    math.randomseed(os.time())

    love.window.setTitle('Pong')
    love.graphics.setFont(love.graphics.newFont('assets/retro.ttf', 8))
    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    player_1 = Player(10, 30, 5, 20)
    player_2 = Player((VIRTUAL_WIDTH - 10), (VIRTUAL_HEIGHT - 30), 5, 20)
    ball = Ball((VIRTUAL_WIDTH / 2 - 2), (VIRTUAL_HEIGHT / 2 - 2), 4, 4)
end

function drawHud()
    love.graphics.printf('Pong!', 0, 20, VIRTUAL_WIDTH, 'center')

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

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.update(delta_time)
    if love.keyboard.isDown('w') then
        player_1:update('up', delta_time)
    elseif love.keyboard.isDown('s') then
        player_1:update('down', delta_time)
    end

    if love.keyboard.isDown('up') then
        player_2:update('up', delta_time)
    elseif love.keyboard.isDown('down') then
        player_2:update('down', delta_time)
    end

    local ballCollisionSide = ball:checkOutOfBoundsSide()
    if ballCollisionSide == 'left' then
        player_1:incrementScore()
        ball:reset()
    elseif ballCollisionSide == 'right' then
        player_2:incrementScore()
        ball:reset()
    end

    if ball:checkCollision(player_1) or ball:checkCollision(player_2) then
        ball:collide()
    end

    ball:update(delta_time)
end

function love.draw()
    push:apply('start')

    drawHud()
    player_1:draw()
    player_2:draw()
    ball:draw()

    push:apply('end')
end
