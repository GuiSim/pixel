local Scoreboard = {}
Scoreboard.__index = Scoreboard


function Scoreboard.create(def, game)
  local scoreboard = {
    game = game,
    team = def.team
  }
  setmetatable(scoreboard, Scoreboard)
  
  return scoreboard
end

function Scoreboard:draw()
  love.graphics.print("Team " .. self.team ..": " .. self.game.teamScores[self.team], (self.team -1) * 200, 550)
end

function Scoreboard:update(dt)
  
end


return Scoreboard;