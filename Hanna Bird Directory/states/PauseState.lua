--[[
    Pause State
    Author: Hanna Ross
    hanna20.edu@gmail.com

    The pause state stops scrolling and ceases to generate pipe pairs.  This state
    also freezes Fifty Bird in whatever location he is in.  In addition, when 'enter'
    or 'return' is pressed, the player sees a countdown and is then taken from 
    PauseState back to PlayState.
]]

PauseState = Class{__includes = BaseState}

PIPE_SPEED = 60
PIPE_WIDTH = 70
PIPE_HEIGHT = 288

BIRD_WIDTH = 38
BIRD_HEIGHT = 24

pause = love.graphics.newImage('pause.png')

function PauseState:enter(params)
    scrolling = false
    self.bird = params.bird
    self.pipePairs = params.pipePairs
    self.score = params.score
    self.timer = params.timer
end

function PauseState:init(params)
    -- retain position of bird
    self.lastY = -PIPE_HEIGHT + math.random(80) + 20
    self.lastX = 0
end

function PauseState:update(dt)
    -- if enter is pressed, resume game
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play', {
            bird = self.bird,
            pipePairs = self.pipePairs,
            score = self.score,
            timer = self.timer
        })
    end
end

previousX = 0
function PauseState:render()
    for k, pair in pairs(self.pipePairs) do
        pair:render()
        previousX = pair.x
    end

    love.graphics.draw(pause, VIRTUAL_WIDTH/2 - 0.4*pause:getWidth()/2, VIRTUAL_HEIGHT/2 - 0.4*pause:getHeight()/2,0,0.4,0.4)

    self.bird:render()
end

function PauseState:exit(params)
    scrolling = true
end