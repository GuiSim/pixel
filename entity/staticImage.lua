local StaticImage = {}
StaticImage.__index = StaticImage


function StaticImage.create(def, game)
  local staticImage = {
    texture = def.texture,
    x = def.x,
    y = def.y,
    pulseCycle = def.pulseCycle,
    pulseDt = 0,
    pulseDirection = 1
  }
  setmetatable(staticImage, StaticImage)
  
  
  return staticImage
end

function StaticImage:draw()
  if self.pulseCycle then
      love.graphics.setColor(255,255,255, math.min(1, self.pulseDt / self.pulseCycle)*255)
  end

  love.graphics.draw(self.texture, self.x, self.y)
  love.graphics.setColor(255,255,255,255);
end

function StaticImage:update(dt)
  if self.pulseCycle then
    self.pulseDt = self.pulseDt + dt * self.pulseDirection
    if self.pulseDt > self.pulseCycle or self.pulseDt < 0 then
      self.pulseDirection = - self.pulseDirection
    end
  end
  
  
end


return StaticImage;