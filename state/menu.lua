local STICK_THRESHOLD = 0.5

local menu = {
  selection = 1,
  selections = {
    {playerCount = 2},
    {playerCount = 4}
  },
  escapeHeldFor = 0
}

local menuChangeSound = love.audio.newSource("assets/sounds/menuChange.mp3", "static")
local menuMusic = love.audio.newSource("assets/sounds/musicStartScreen.mp3", "stream")

local sunParticles = Particle.sunMenu();
local menuBackground = love.graphics.newImage("assets/textures/startscreen_bg.jpg")
local menuTitle = love.graphics.newImage("assets/textures/startscreen_title.png")
local menuTwoPlayers = love.graphics.newImage("assets/textures/startscreen_2player.png")
local menuFourPlayers = love.graphics.newImage("assets/textures/startscreen_4player.png")
local cursor = love.graphics.newImage("assets/textures/startscreen_arrow.png")

function menu:enter()
  love.audio.play(menuMusic);
end

function menu:leave()
  love.audio.stop(menuMusic);
end


function menu:update(dt)
  sunParticles:update(dt);
  -- Hold escape to quit
  if love.keyboard.isDown("escape") or (love.joystick.getJoysticks()[1] and love.joystick.getJoysticks()[1]:isGamepadDown("guide")) then 
    menu.escapeHeldFor = menu.escapeHeldFor + dt
  else 
    menu.escapeHeldFor = 0
  end
  
  if menu.escapeHeldFor > 1 then
    love.event.quit()
  end
  
  if love.keyboard.isDown('p') then
    Gamestate.switch(require('state.tutorial'))
  end
end

function menu.moveSelection(change)
  menu.selection = menu.selection + change;
  love.audio.stop(menuChangeSound);
  love.audio.play(menuChangeSound);
end


function menu:draw()
  love.graphics.draw(menuBackground, 0, 0);
  love.graphics.draw(sunParticles,menuBackground:getWidth()/2, 300)
  love.graphics.draw(menuTitle, 0, 0);
  love.graphics.draw(menuTwoPlayers, 0, 0);
  love.graphics.draw(menuFourPlayers,0 ,0);
  love.graphics.draw(cursor, 650, menu.selection * 200 + 350)
  
  if (menu.escapeHeldFor > 0.1) then
    love.graphics.print("Hold escape or 'Guide' to quit!", 0, 0, 0, 3, 3)
  end
end

function menu:joystickpressed(joystick, button)
  if joystick:isGamepadDown("start") then
    Gamestate.switch(require('state.tutorial'))
  end

  -- Handle navigation with dpad
  if joystick:isGamepadDown("dpdown") then
    menu.moveSelection(1)
  elseif joystick:isGamepadDown("dpup") then
    menu.moveSelection(-1)
  elseif joystick:isGamepadDown("back") then
    menu.moveSelection(1)
  end
  
  if menu.selection > #menu.selections then
    menu.selection = 1
  end
  
  if menu.selection < 1 then
    menu.selection = #menu.selections
  end
end


return menu
