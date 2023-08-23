-- Class to make the powerup that spawns balls

Powerup = Class{}

--[[
    Our powerup will spawn in a random position on the screen every time.
]]

function Powerup:init(x, y, skin)
    -- randomize x
    self.x = math.random(8, VIRTUAL_WIDTH - 8) -- or is it window_width?

    -- randomize y
    self.y = math.random(VIRTUAL_HEIGHT + 48, -96) -- -- or is it window_height?

    self.width = 16
    self.height = 16

    self.dy = 100

    self.skin = skin

    -- used to determine whether the powerup should be rendered
    self.inPlay = true
end

function Powerup:update(dt)
    self.y = self.y + self.dy * dt
end

function Powerup:collides(target)
    -- check to see if the left edge of either the target or the powerup is
    -- farther to the right than the right edge of the other
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    -- check to see if the bottom edge of either the target or the powerup is
    -- higher than the other
    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end

    -- if the above are false, then the powerup and target are overlapping
    return true
end

function Powerup:render()
    if self.inPlay then
        love.graphics.draw(gTextures['main'], gFrames['powerup'][self.skin], self.x, self.y)
    end
end