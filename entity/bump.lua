local Bump = {}
Bump.__index = Bump

function Bump.create(def, game)
  local bump = {
    game = game,
    x = def.x,
    y = def.y
  }
  setmetatable(bump, Bump)
  
  bump.body = love.physics.newBody(game.world, def.x, def.y,"static")
  
  bump.body:setUserData(bump)

  local fixture = love.physics.newFixture(bump.body, love.physics.newCircleShape(BUMP_RADIUS), 1)
  
  return bump
end

function Bump:collisionBegin(other, collision)
  local body = other:getBody();
  if body then
    local x, y = body:getPosition();
    local dirX, dirY =  vector.normalize(vector.sub(self.x, self.y, x, y));
    body:setLinearVelocity(vector.mul(-1 * BUMP_FORCE, dirX, dirY))
  end
end

function Bump:update(dt)
end

function Bump:draw()
  love.graphics.setColor(255, 0,  255, 100);
  love.graphics.circle('fill', self.x, self.y, BUMP_RADIUS)
  love.graphics.setColor(255, 255, 255, 255);
end

return Bump
