local Scoreboard = {}
Scoreboard.__index = Scoreboard


function Scoreboard.create(def, game)
  local scoreboard = {
    player = def.player
  }
  setmetatable(scoreboard, Scoreboard)
  
  
  return scoreboard
end

function Scoreboard:draw()
  local playerNo = self.player.no;
  love.graphics.print("Player " .. playerNo ..": " .. self.player.score, (playerNo -1) * 200, 550)
end

function Scoreboard:update(dt)
  
end


return Scoreboard;