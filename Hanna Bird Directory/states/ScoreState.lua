--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

local gold = love.graphics.newImage('gold.png')
local silver = love.graphics.newImage('silver.png')
local bronze = love.graphics.newImage('bronze.png')
local platinum = love.graphics.newImage('platinum.png')
local rainbow = love.graphics.newImage('rainbow.png')

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    -- if condition for placement of 'play again' text
    if self.score > 9 then
        love.graphics.printf('Press Enter to Play Again!', 0, 250, VIRTUAL_WIDTH, 'center')
    else
        love.graphics.printf('Press Enter to Play Again!', 0, 150, VIRTUAL_WIDTH, 'center')
    end

    love.graphics.setFont(smallFont)

    -- create if conditions to display different medals based on score
    if  self.score > 9 and self.score < 25 then
        love.graphics.draw(bronze, 195, 110)
        love.graphics.printf('Congratulations!', 0, 225, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('You won the bronze medal for scoring over 10 points. Can you reach 25?', 0, 240, VIRTUAL_WIDTH, 'center')
    elseif self.score > 24 and self.score < 50 then
        love.graphics.draw(silver, 195, 110)
        love.graphics.printf('Congratulations!', 0, 225, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('You won the silver medal for scoring over 25 points. Can you reach 50?', 0, 240, VIRTUAL_WIDTH, 'center')
    elseif self.score > 49 and self.score < 100 then
        love.graphics.draw(gold, 195, 110)
        love.graphics.printf('Congratulations!', 0, 225, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('You won the gold medal for scoring over 50 points. Can you reach 100?', 0, 240, VIRTUAL_WIDTH, 'center')
    elseif self.score > 99 and self.score < 150 then
        love.graphics.draw(platinum, 195, 110)
        love.graphics.printf('Congratulations!', 0, 225, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('You won the platinum medal for scoring over 100 points. Can you reach 150?', 0, 240, VIRTUAL_WIDTH, 'center')
    elseif self.score > 150 then
        love.graphics.draw(rainbow, 195, 110)
        love.graphics.printf('Congratulations! You won the flappiest achievement of all...the rainbow medal!', 0, 225,
        VIRTUAL_WIDTH, 'center')
    end
end