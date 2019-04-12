push = require './vendor/push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.graphics.setFont(
        love.graphics.newFont('assets/retro.ttf', 8)
    )

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    player_1 = {
        score = 0,
        y = 30
    }

    player_2 = {
        score = 0,
        y = VIRTUAL_HEIGHT - 50
    }
end

function love.update(delta_time)
    if love.keyboard.isDown('w') then
        player_1.y = player_1.y + -PADDLE_SPEED * delta_time
    elseif love.keyboard.isDown('s') then
        player_1.y = player_1.y + PADDLE_SPEED * delta_time
    end

    if love.keyboard.isDown('up') then
        player_2.y = player_2.y + -PADDLE_SPEED * delta_time
    elseif love.keyboard.isDown('down') then
        player_2.y = player_2.y + PADDLE_SPEED * delta_time
    end
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.draw()
    push:apply('start')

    love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH, 'center')

    drawScores()
    drawPaddles()

    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

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

function drawPaddles()
    love.graphics.rectangle('fill', 10, player_1.y, 5, 20)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, player_2.y, 5, 20)
end
