local Arena = {}
Arena.__index = Arena


local radius = 16;
local polygons = {};

function Arena.create(def, game)
  local arena = {
  }
  setmetatable(arena, Arena)
  
  polygons = def.polygons
  
  for k, polygon in pairs(polygons) do
    local polygonBody = love.physics.newBody(game.world, 0, 0, "static")
--    local fixture = love.physics.newFixture(sideBody, love.physics.newRectangleShape(side.width, side.height))
      local fixture = love.physics.newFixture(polygonBody, love.physics.newPolygonShape(polygon.points))
  end
  
  return arena
end

function Arena:draw()
  local i = 0;
  for k, polygon in pairs(polygons) do
    i = i + 1;
    love.graphics.setColor(i*20+100, i*20+100, i*20+100)
    love.graphics.polygon("fill", polygon.points)
  end
end

function Arena:update(dt)
  
end


return Arena;