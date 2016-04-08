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
    if self.player.hitpoints < 30 then
      love.graphics.setColor(255,200,200);
    else
      love.graphics.setColor(255,255,255);
    end
    

    
    love.graphics.print("Player " .. playerNo ..": " .. self.player.hitpoints, (playerNo -1) * 200, 500)
    love.graphics.print(self.player.power, (playerNo -1) * 200, 530)
    love.graphics.setColor(255,255,255)
end

function HitPoints:update(dt)
  
end


return HitPoints;