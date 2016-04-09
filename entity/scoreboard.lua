local Scoreboard = {}
Scoreboard.__index = Scoreboard

local font = love.graphics.newFont('assets/UnZialish.ttf',64)

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
  local space = love.graphics.getWidth() / (self.game.numberOfTeam + 1);
  
  local r = 50;
  local g = 50;
  local b = 50;
  local a = 255;
  
  if self.team == 1 then
    r = 255;
  elseif self.team == 2 then 
    b = 255; 
  elseif self.team == 3 then 
    g = 255; 
  elseif self.team == 4 then 
    r = 255; 
    b = 255; 
  end
  
  love.graphics.setColor(r, g, b, a)
  
  love.graphics.printf(self.game.teamScores[self.team], space * (self.team - 0.5), 0, space,'center')
  
  love.graphics.setColor(255, 255, 255, 255)
end

function Scoreboard:update(dt)
  
end


return Scoreboard;