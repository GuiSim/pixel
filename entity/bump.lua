local Bump = {}
Bump.__index = Bump

function Bump.create(def, game)
  local bump = {
    game = game,
    x = def.x,
    y = def.y,
    timer = 0
  }
  setmetatable(bump, Bump)
  table.insert(game.bumps, bump)
  
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
    self.timer = BUMP_PUSH_ANIMATION
  end
end

function Bump:update(dt)
  if self.timer > 0 then
    self.timer = self.timer - dt;
  end
end

function Bump:draw()
  local alpha = self.timer / BUMP_PUSH_ANIMATION;
  if(alpha <= 0) then
    alpha = 0
  end
  alpha = alpha * 0.75 + 0.25
  
  love.graphics.setColor(255,255,255, alpha * 255)
  love.graphics.circle('fill', self.x, self.y, BUMP_RADIUS)
end

return Bump
