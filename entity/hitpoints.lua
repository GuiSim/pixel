local HitPoints = {}
HitPoints.__index = HitPoints


function HitPoints.create(def, game)
  local hitpoints = {
    player = def.player
  }
  setmetatable(hitpoints, HitPoints)
  
  
  return hitpoints
end

function HitPoints:draw()
  local playerNo = self.player.no;
    love.graphics.print("Player " .. playerNo ..": " .. self.player.hitpoints, (playerNo -1) * 100, 700)
end

function HitPoints:update(dt)
  
end


return HitPoints;