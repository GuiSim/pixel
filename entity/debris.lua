local Debris = {}
Debris.__index = Debris


function Debris.create(def, game)
  local debris = {
    texture = def.texture,
    density = def.density,
    startingX = math.random(def.minX, def.maxX),
    startingY = math.random(def.minY, def.maxY)
  }
  setmetatable(debris, Debris)
  
  debris.body = love.physics.newBody(game.world, debris.startingX, debris.startingY, "dynamic")
  debris.body:setAngularDamping(3)
  debris.body:setLinearDamping(3)
  debris.body:setUserData(debris)
  
  local width = def.texture:getWidth()
  local height = def.texture:getHeight()

  local fixture = love.physics.newFixture(debris.body, love.physics.newRectangleShape(0, 0, width, height), def.density)
  fixture:setFilterData(EntityTypes.Ball.category, EntityTypes.Ball.mask, 0)
  table.insert(game.debris, debris)
  table.insert(game.pullables, debris)

  return debris
end

function Debris:draw()
  love.graphics.draw(self.texture, self.body:getX(), self.body:getY(), self.body:getAngle(), 1, 1, self.texture:getWidth()/2, self.texture:getHeight()/2)
  love.graphics.setColor(255,255,255,255);
end

function Debris:update(dt)
  
end

function Debris:reset()
  self.body:setPosition(self.startingX, self.startingY)
end


return Debris;