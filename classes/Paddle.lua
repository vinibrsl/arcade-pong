local PADDLE_SPEED = 200.0

Paddle = Class{}

Paddle:include(Positionable)
Paddle:include(Acceleratable)
Paddle:include(Collidable)
Paddle:include(Renderable)

function Paddle:init(args)
    args = args or {}

    self.x = args.x or 0.0
    self.y = args.y or 0.0

    self.width = args.width or 6.0
    self.height = args.height or 25.0

    self.dx = args.dx or 0.0
    self.dy = args.dy or 0.0

    self.keybindingUp = args.keybindingUp or "up"
    self.keybindingDown = args.keybindingDown or "down"
end

function Paddle:update(deltaTime)
    if love.keyboard.isDown(self.keybindingUp) then
        self.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown(self.keybindingDown) then
        self.dy = PADDLE_SPEED
    end

    self:accelerate(deltaTime)
    self:stopAccelerating()
end
