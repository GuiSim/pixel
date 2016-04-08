local Ball = {}
Ball.__index = Ball

Ball.category = 2;
Ball.mask = -1;

function Ball.create(def, game)
  local joysticks = love.joystick.getJoysticks()
  local ball = {
    game = game,
    startingX = def.x,
    startingY = def.y,
    particleSystems = {},
    texture = def.texture
  }
  
  setmetatable(ball, Ball)
  
  ball.body = love.physics.newBody(game.world, def.x, def.y, "dynamic")
  ball.body:setAngularDamping(2)
  
  ball.body:setUserData(ball)

  local fixture = love.physics.newFixture(ball.body, love.physics.newCircleShape(BALL_RADIUS), BALL_DENSITY)
  fixture:setRestitution(1)
  fixture:setFilterData( Ball.category, Ball.mask, 0 )
  table.insert(game.balls, ball)

  return ball
end

function Ball:collisionBegin(other, collision)
  if (other:getUserData() ~= nil and other:getUserData().type == "Player") then
    table.insert(self.particleSystems, Particle.ballImpactWithPlayer())
  else
    table.insert(self.particleSystems, Particle.ballImpactWithWall())
  end
end

function Ball:update(dt)
  for k, particleSystem in pairs(self.particleSystems) do
    particleSystem:update(dt)
  end
end

function Ball:draw()
  if self.texture then
    love.graphics.draw(self.texture, self.body:getX(), self.body:getY(), self.body:getAngle(), 1, 1, BALL_RADIUS, BALL_RADIUS)
  else
    love.graphics.setColor(255, 255, 0);
    love.graphics.circle('fill', self.body:getX(), self.body:getY(), BALL_RADIUS)
  end
  love.graphics.setColor(255, 255, 255);
  
  
  for k, particleSystem in pairs(self.particleSystems) do
    local x, y = self.body:getPosition()
    love.graphics.draw(particleSystem, x+BALL_RADIUS/2, y+BALL_RADIUS/2)
  end
end

function Ball:reset()
  self.body:setPosition(self.startingX, self.startingY)
  self.body:setLinearVelocity(0,0,0)
end

return Ball
