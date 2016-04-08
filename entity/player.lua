local Player = {}
Player.__index = Player

Player.category = 1;
Player.mask = -1;

function Player.create(def, game)
  local joysticks = love.joystick.getJoysticks()
  local player = {
    game = game,
    joystick = joysticks[tonumber(def.no)],
    no = def.no,
    hitpoints = PLAYER_HITPOINTS
  }
  
  setmetatable(player, Player)
  
  player.body = love.physics.newBody(game.world, def.x, def.y, "dynamic")
  player.body:setLinearDamping(PLAYER_DAMPENING)
  
  player.body:setUserData(player)
  
  local fixture = love.physics.newFixture(player.body, love.physics.newCircleShape(PLAYER_RADIUS), PLAYER_DENSITY)  fixture:setFilterData( Player.category, Player.mask, 0 )
  table.insert(game.players, player)

  game.entities["player_" .. def.no] = EntityTypes.HitPoints.create({player = player}, game);

  return player
end

function Player:collisionBegin(other, collision)
  if other.type == "Ball" then
    self.hitpoints = self.hitpoints - BALL_DAMAGE
  end
end

function Player:control()
  if self.joystick == nil then
    return 0, 0, 0
  end
  x = self.joystick:getGamepadAxis('leftx')
  y = self.joystick:getGamepadAxis('lefty')
  tl = self.joystick:getGamepadAxis('triggerleft')
  
  if vector.len2(x,y) < 0.2 then
    x = 0
    y = 0
  end
  
  if tl < 0.1 then
    tl = 0
  end
  
  return x, y, tl
end

function Player:update(dt)
  local jx, jy, jpull = self:control()
  self.body:applyForce(vector.mul(PLAYER_FORCE, jx, jy));
  
  local x, y = self.body:getPosition();
  
  if jpull > 0 then
    for k, ball in pairs(self.game.balls) do
      local ballX, ballY = ball.body:getPosition();
      local diffX, diffY =  vector.sub(x,y, ballX, ballY);
      local len2 = vector.len2(diffX, diffY);
      if len2 < PULL_LENGTH2 then
        ball.body:applyForce(vector.mul(jpull * PULL_FORCE * (1 - len2 / PULL_LENGTH2) / math.sqrt(len2), diffX, diffY))
      end
    end
  end
end

function Player:draw()
  if self.no == 1 then
    love.graphics.setColor(255, 50, 50, self.hitpoints*255/100)    
  elseif self.no == 2 then 
      love.graphics.setColor(50, 50, 255, self.hitpoints*255/100)
  else 
      love.graphics.setColor(255, 255, 255, self.hitpoints*255/100)
  end
      
      

  love.graphics.circle('fill', self.body:getX(), self.body:getY(), PLAYER_RADIUS)
  love.graphics.setColor(255,255,255)
end

return Player
