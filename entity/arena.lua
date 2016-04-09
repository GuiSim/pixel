local Arena = {}
Arena.__index = Arena


local radius = 16;
local polygons = {};
local circles = {};

function Arena.create(def, game)
  local arena = {
    texture = def.texture
  }
  setmetatable(arena, Arena)
  
  polygons = def.polygons
  local circles = {}
  if def.circles then
    circles = def.circles
  end
  
  
  for k, polygon in pairs(polygons) do
    local polygonBody = love.physics.newBody(game.world, 0, 0, "static")
    local fixture = love.physics.newFixture(polygonBody, love.physics.newPolygonShape(polygon.points))
  end

  for k, circle in pairs(circles) do
    local circleBody = love.physics.newBody(game.world, circle.x, circle.y, "static")
    local fixture = love.physics.newFixture(circleBody, love.physics.newCircleShape(circle.radius))
  end

  return arena
end

function Arena:draw()  
  if (self.texture) then
    love.graphics.draw(self.texture,0,0);
  else
    for k, polygon in pairs(polygons) do
      love.graphics.setColor(100, 100, 255)
      love.graphics.polygon("fill", polygon.points)
    end
    if circles then
      for k, circle in pairs(circles) do
        love.graphics.setColor(100, 100, 255)
        love.graphics.circle("fill", circle.x, circle.y, circle.radius, 3600)
      end
    end
    
  end
  
end

function Arena:update(dt)
  
end


return Arena;