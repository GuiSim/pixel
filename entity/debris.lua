local Debris = {}
Debris.__index = Debris


function Debris.create(def, game)
  local debris = {
    game = game,
    texture = def.texture,
    density = def.density,
    startingX = math.random(def.minX, def.maxX),
    startingY = math.random(def.minY, def.maxY),
    hitpoints = DEBRIS_HITPOINTS,
    active = true,
    particle = Particle.boxExplosion()
  }
  setmetatable(debris, Debris)
  
  debris.particle:stop() -- Stop it, we'll start it when the box explodes.
  
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
  if self.hitpoints > 0 then
    local rgb = (self.hitpoints / DEBRIS_HITPOINTS * (255-DEBRIS_MIN_LUMINOSITY) + DEBRIS_MIN_LUMINOSITY)
    love.graphics.setColor(rgb, rgb, rgb)
    love.graphics.draw(self.texture, self.body:getX(), self.body:getY(), self.body:getAngle(), 1, 1, self.texture:getWidth()/2, self.texture:getHeight()/2)
    love.graphics.setColor(255,255,255,255);
  end
  love.graphics.draw(self.particle, 0, 0)
end

function Debris:collisionBegin(other, collision)
  local body = other:getBody();
  local entity = body:getUserData();
  if entity ~= nil and entity.type == "Ball" then
    local vx, vy = body:getLinearVelocity()
    local velocity = vector.len(vx, vy)
    local damage = BALL_DAMAGE * velocity/BALL_DAMAGE_SPEED_SCALING
    damage = math.min(damage, BALL_MAX_DAMAGE)
    self.hitpoints = self.hitpoints - math.floor(damage)
  end
  
  if self.hitpoints <= 0 then
    self.active = false
    self.particle:reset()
    self.particle:start()
  end
  
end

function Debris:update(dt)
  self.particle:setPosition(self.body:getX(), self.body:getY())
  self.particle:update(dt)
  if not self.active then 
    self.body:setActive(false)
  end
  
end

function Debris:reset()
  self.body:setActive(true)
  
  local width = self.texture:getWidth()
  local height = self.texture:getHeight()

  local fixture = love.physics.newFixture(self.body, love.physics.newRectangleShape(0, 0, width, height), self.density)
  fixture:setFilterData(EntityTypes.Ball.category, EntityTypes.Ball.mask, 0)
  
  self.body:setPosition(self.startingX, self.startingY)
  self.body:setLinearVelocity(0,0)
  self.body:setAngularVelocity(0,0)
  self.hitpoints = DEBRIS_HITPOINTS
  self.active = true
end


return Debris;