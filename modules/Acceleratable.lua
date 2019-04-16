Acceleratable = Class{
    accelerate = function(self, deltaTime)
        self.x = (self.x + self.dx * deltaTime)
        self.y = (self.y + self.dy * deltaTime)

        if self.x >= (VIRTUAL_WIDTH - self.width) then
            self.x = (VIRTUAL_WIDTH - self.width)
        end

        if self.x <= 0 then
            self.x = 0
        end

        if self.y >= (VIRTUAL_HEIGHT - self.height) then
            self.y = (VIRTUAL_HEIGHT - self.height)
        end

        if self.y <= 0 then
            self.y = 0
        end
    end,

    stopAccelerating = function(self)
        self.dx = 0.0
        self.dy = 0.0
    end
}
