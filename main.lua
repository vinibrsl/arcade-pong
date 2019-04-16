push = require 'vendor/push'
Class = require 'vendor/class'

require 'modules/Acceleratable'
require 'modules/Positionable'
require 'modules/Renderable'
require 'modules/Collidable'
require 'classes/Paddle'
require 'classes/Ball'

WINDOW_WIDTH  = 600
WINDOW_HEIGHT = 300

VIRTUAL_WIDTH  = 500
VIRTUAL_HEIGHT = 300

PADDLE_MARGIN = 40

local paddle_1 = Paddle({
    x = PADDLE_MARGIN,
    keybindingUp = "w",
    keybindingDown = "s"
})
paddle_1:centerY()

local paddle_2 = Paddle({
    x = (VIRTUAL_WIDTH - PADDLE_MARGIN),
    keybindingUp = "up",
    keybindingDown = "down"
})
paddle_2:centerY()

local ball = Ball()

function love.load()
    math.randomseed((os.time()))

    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Pong')
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })
end

function love.keypressed(key)
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(deltaTime)
    paddle_1:update(deltaTime)
    paddle_2:update(deltaTime)

    if ball:checkCollision(paddle_1) or ball:checkCollision(paddle_2) then
        ball.dx = -ball.dx
    end

    ball:update(deltaTime)
end

function love.draw()
    push:start()

    love.graphics.rectangle("fill", (VIRTUAL_WIDTH / 2), 0, 1, VIRTUAL_HEIGHT)

    paddle_1:render()
    paddle_2:render()
    ball:render()

    push:finish()
end
