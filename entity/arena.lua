local Arena = {}
Arena.__index = Arena


local radius = 16;
local sides = {};

function Arena.create(def, game)
  local arena = {
  }
  setmetatable(arena, Arena)
  
  sides = def.sides
  
  for k, side in pairs(sides) do
    local sideBody = love.physics.newBody(game.world, side.x, side.y, "static")
    local fixture = love.physics.newFixture(sideBody, love.physics.newRectangleShape(side.width, side.height))
  end
  
  return arena
end

function Arena:draw()
  for k, side in pairs(sides) do
      love.graphics.rectangle("fill", side.x, side.y, side.width, side.height)
  end
end

function Arena:update(dt)
  
end


return Arena;