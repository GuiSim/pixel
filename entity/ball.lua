local Ball = {}
Ball.__index = Ball

local BALL_RADIUS = 8;
Ball.category = 2;
Ball.mask = -1;

function Ball.create(def, game)
  local joysticks = love.joystick.getJoysticks()
  local ball = {
    game = game,
  }
  setmetatable(ball, Ball)
  
  ball.body = love.physics.newBody(game.world, def.x, def.y, "dynamic")
  ball.body:setAngularDamping( 2 )
  
  local fixture = love.physics.newFixture(ball.body, love.physics.newCircleShape(BALL_RADIUS), 1)
  fixture:setRestitution(1)
  fixture:setFilterData( Ball.category, Ball.mask, 0 )
  table.insert(game.balls, ball)

  return ball
end


function Ball:control()
end

function Ball:update(dt)
end

function Ball:draw()
  love.graphics.circle('fill', self.body:getX(), self.body:getY(), BALL_RADIUS)
end

return Ball
