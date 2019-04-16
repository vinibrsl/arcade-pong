Ball = Class{}

Ball:include(Positionable)
Ball:include(Acceleratable)
Ball:include(Collidable)
Ball:include(Renderable)

function Ball:init(args)
    args = args or {}

    self.width = args.width or 5.0
    self.height = args.height or 5.0

    self:reset()
end

function Ball:reset()
    self.dx = math.random(-300, 300)
    self.dy = math.random(-300, 300)
    self:center()
end

function Ball:update(deltaTime)
    if self:checkFloorCollision() then
        self.dy = -self.dy
    end

    if self:checkWallCollision() then
        self:reset()
    end

    self:accelerate(deltaTime)
end
