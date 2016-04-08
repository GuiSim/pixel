local StaticImage = {}
StaticImage.__index = StaticImage


function StaticImage.create(def, game)
  local staticImage = {
    texture = def.texture,
    x = def.x,
    y = def.y
  }
  setmetatable(staticImage, StaticImage)
  
  
  return staticImage
end

function StaticImage:draw()
  love.graphics.draw(self.texture, self.x, self.y)
end

function StaticImage:update(dt)
  
end


return StaticImage;