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
    hitpoints = PLAYER_HITPOINTS,
    invulnerabilityTime = 0,
    score = 0,
    startingX = def.x,
    startingY = def.y,
    power = 1000,
    keys = { a = false, b = false, x = false, y = false },
    pushCd = 0

  }
  
  setmetatable(player, Player)
  
  player.body = love.physics.newBody(game.world, def.x, def.y, "dynamic")
  player.body:setLinearDamping(PLAYER_DAMPENING)
  
  player.body:setUserData(player)
  
  local fixture = love.physics.newFixture(player.body, love.physics.newCircleShape(PLAYER_RADIUS), PLAYER_DENSITY)  fixture:setFilterData( Player.category, Player.mask, 0 )
  table.insert(game.players, player)

  game.entities["player_health_" .. def.no] = EntityTypes.HitPoints.create({player = player}, game);
  game.entities["player_score_" .. def.no] = EntityTypes.Scoreboard.create({player = player}, game);

  return player
end

function Player:collisionBegin(other, collision)
  if other.type == "Ball" and self.invulnerabilityTime <= 0 then
    local vx, vy = other.body:getLinearVelocity()
    
    local velocity = vector.len(vx, vy)
    
    local damage = BALL_DAMAGE * velocity/BALL_DAMAGE_SPEED_SCALING
    damage = math.min(damage, BALL_MAX_DAMAGE)
    self.hitpoints = self.hitpoints - math.floor(damage)
    self.invulnerabilityTime = PLAYER_INVULNERABILITY_DURATION;
  end
end

function Player:control()
  if self.joystick == nil then -- no connector
    return 0, 0, 0, false
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
  
  local keys = {
    a = self.joystick:isGamepadDown('a'),
    b = self.joystick:isGamepadDown('b'),
    x = self.joystick:isGamepadDown('x'),
    y = self.joystick:isGamepadDown('y')
  }
  
  for k, pressed in pairs(keys) do
    if pressed and self.keys[k] then
      keys[k] = false --not released
    elseif (not pressed) and self.keys[k] then
      self.keys[k] = false
    else
      self.keys[k] = pressed
    end
  end
  
  local pushing = keys['a'] and self.power >= PUSH_COST and self.pushCd == 0 
  
  return x, y, tl, pushing
end

function Player:update(dt)
  local jx, jy, jpull, pushing = self:control()
  local pulling = jpull > 0;

  
  self.invulnerabilityTime = math.max(0, self.invulnerabilityTime - dt);
  self.body:applyForce(vector.mul(PLAYER_FORCE, jx, jy));
  
  local x, y = self.body:getPosition();
  
  if self.pushCd > 0 then
    self.pushCd = math.max(0, self.pushCd - dt);
  end
  
  if pushing then
    self.power = self.power - PUSH_COST
    self.pushCd = PUSH_COOLDOWN;
  end
  
  if pulling or pushing then
    local energieCost = 0;
    for k, ball in pairs(self.game.balls) do
      local ballX, ballY = ball.body:getPosition();
      local diffX, diffY =  vector.sub(x,y, ballX, ballY);
      local len = vector.len(diffX, diffY);
      if pulling and len < PULL_LENGTH then
          local energie = jpull * (1 - len / PULL_LENGTH);
          energieCost = energieCost + energie;
          ball.body:applyForce(vector.mul(energie * PULL_FORCE / len, diffX, diffY))
      end
      if pushing and len < PUSH_LENGTH then
          ball.body:setLinearVelocity(vector.mul((1 - len / PUSH_LENGTH) * PUSH_FORCE / len, diffX, diffY))
      end
    end
    if energieCost > 0 then
      for k, player in pairs(self.game.players) do
        if player ~= self then
          player.power = math.max(player.power + energieCost * dt * PLAYER_ENERGIE_GIVEN, PLAYER_ENERGIE_MAX)
        end
      end
    end
  end
end

function Player:draw()
  local r = 50;
  local g = 50;
  local b = 50;
  local a = 255;
  
  if self.no == 1 then
    r = 255;
  elseif self.no == 2 then 
    b = 255; 
  end
  
  if self.invulnerabilityTime > 0 then
    r = 255;
    g = 255;
    b = 255;
  end
      
  love.graphics.setColor(r,g,b,a);
  love.graphics.circle('fill', self.body:getX(), self.body:getY(), PLAYER_RADIUS)
  love.graphics.setColor(255,255,255)
end

function Player:reset()
  self.body:setPosition(self.startingX, self.startingY)
  self.body:setLinearVelocity(0,0,0)
  self.hitpoints = PLAYER_HITPOINTS
end


return Player
