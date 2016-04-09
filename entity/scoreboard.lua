local Scoreboard = {}
Scoreboard.__index = Scoreboard

local font = love.graphics.newFont('assets/UnZialish.ttf', 48)

function Scoreboard.create(def, game)
  local scoreboard = {
    game = game,
    team = def.team
  }
  setmetatable(scoreboard, Scoreboard)
  
  return scoreboard
end

function Scoreboard:draw()
  love.graphics.setFont(font);
  
  local r = 50;
  local g = 50;
  local b = 50;
  local a = 255;
  
  local x = 0;
  local y = 0;
  local xText = 0;
  local yText = 0;
  
  
  
  if self.team == 1 then
    r = 150;
  elseif self.team == 2 then 
    b = 150; 
    x = love.graphics.getWidth();
    xText = x - 64;
  elseif self.team == 3 then 
    r = 150; 
    b = 150; 
    y = love.graphics.getHeight();
    yText = y - 64;
  elseif self.team == 4 then 
    g = 150; 
    x = love.graphics.getWidth();
    xText = x - 64;
    y = love.graphics.getHeight() ;
    yText = y - 64;
  end
  
  love.graphics.setColor(r, g, b, a)
  
  love.graphics.circle('fill', x, y, 82)
  
  love.graphics.setColor(255, 255, 255, 255)
  
  love.graphics.printf(self.game.teamScores[self.team], xText, yText, 64,'center')
end

function Scoreboard:update(dt)
  
end


return Scoreboard;