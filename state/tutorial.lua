
local tutorial = {

}

local tutorialMusic = love.audio.newSource("assets/sounds/musicTutorial.mp3", "stream")

local tutorialBackground = love.graphics.newImage("assets/textures/tutorial_background.jpg")
local tutorialText = love.graphics.newImage("assets/textures/tutorial_text.png")

function tutorial:enter()
  love.audio.play(tutorialMusic);
end

function tutorial:leave()
  love.audio.stop(tutorialMusic);
end


function tutorial:update(dt)

end


function tutorial:draw()
  love.graphics.draw(tutorialBackground, 0, 0);
  love.graphics.draw(tutorialText, SCREEN_WIDTH/2-tutorialText:getWidth()/2, 0);
  
end

function tutorial:joystickpressed(joystick, button)
  if joystick:isGamepadDown("start") then
--    Gamestate.switch(Game, require('assets.maps.b'), Menu.selections[Menu.selection].playerCount)
    Gamestate.switch(Game, require('assets.maps.tutorial_map'), Menu.selections[Menu.selection].playerCount)
  end
end


return tutorial
