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
    pushCd = 0,
    
    pullApplied = 0,
    particleSystems = {}
  }
  
  setmetatable(player, Player)

  if player.joystick then
    player.joystick:setVibration( 1, 1 )
  end
  
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
  if other ~= nil and other.type == "Ball" and self.invulnerabilityTime <= 0 then
    local vx, vy = other.body:getLinearVelocity()
    
    local velocity = vector.len(vx, vy)
    
    local damage = BALL_DAMAGE * velocity/BALL_DAMAGE_SPEED_SCALING
    damage = math.min(damage, BALL_MAX_DAMAGE)
    self.hitpoints = self.hitpoints - math.floor(damage)
    self.invulnerabilityTime = PLAYER_INVULNERABILITY_DURATION;
  
    table.insert(self.particleSystems, Particle.playerImpactWithBall())
  end
end

function Player:control()
  if self.joystick == nil then -- no connector
    return 0, 0, 0, 0, 0, false
  end
  
  local x = self.joystick:getGamepadAxis('leftx')
  local y = self.joystick:getGamepadAxis('lefty')
  local x2 = self.joystick:getGamepadAxis('rightx')
  local y2 = self.joystick:getGamepadAxis('righty')
  local t = math.max(self.joystick:getGamepadAxis('triggerleft'), self.joystick:getGamepadAxis('triggerright'))
  
  if vector.len2(x,y) < 0.2 then
    x = 0
    y = 0
  end
  
  if vector.len2(x2,y2) < 0.2 then
    x2 = 0
    y2 = 0
  end
  
  if t < 0.1 then
    t = 0
  end
  
  return x, y, x2, y2, t
end

function Player:update(dt)
  local keys;
  -- Update key (Just pressed)
  if self.joystick ~= nil then
    keys = {
      a = self.joystick:isGamepadDown('a'),
      b = self.joystick:isGamepadDown('b'),
      x = self.joystick:isGamepadDown('x'),
      y = self.joystick:isGamepadDown('y')
    }
  else 
  keys = {
      a = false,
      b = false,
      x = false,
      y = false
    }
  end

  for k, pressed in pairs(keys) do
    if pressed and self.keys[k] then
      keys[k] = false --not released
    elseif (not pressed) and self.keys[k] then
      self.keys[k] = false
    else
      self.keys[k] = pressed
    end
  end
  
  local pushing = keys['a'] and self:canPush()
  
  local jx, jy, j2x, j2y, jpull = self:control()
  local pulling = jpull > 0;
  self.pullApplied = jpull;
  
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
  
  if self.joystick ~= nil then
    if pulling then
      self.joystick:setVibration( jpull, jpull )
    else
      self.joystick:setVibration( 0, 0 )
    end
    
  end
  
  if pulling or pushing then
    local energieCost = 0;
    for k, ball in pairs(self.game.balls) do
      local ballX, ballY = ball.body:getPosition();
      local pullx, pully = vector.add(x, y, j2x * CONTROLL_RANGE, j2y * CONTROLL_RANGE)
      local diffX, diffY =  vector.sub(pullx,pully, ballX, ballY);
      local len = vector.len(diffX, diffY);
      
      -- Pull skill
      if pulling and len < PULL_LENGTH then
          local energie = jpull * (1 - len / PULL_LENGTH);
          energieCost = energieCost + energie;
          ball.body:applyForce(vector.mul(energie * PULL_FORCE / len, diffX, diffY))
      end
      
      
      -- Push skill
      if pushing and len < PUSH_LENGTH then
        local normalX, normalY = vector.div( len, diffX, diffY)
        local velocity = math.min(BALL_MAX_VELOCITY, (1 - len / PUSH_LENGTH) * PUSH_FORCE)
        ball.body:setLinearVelocity(vector.mul(-1 * velocity, normalX, normalY))
      end
      
    end
    
    
    -- Give energie to other player
    if energieCost > 0 then
      for k, player in pairs(self.game.players) do
        if player ~= self then
          player.power = math.max(player.power + energieCost * dt * PLAYER_ENERGIE_GIVEN, PLAYER_ENERGIE_MAX)
        end
      end
    end
  end
  
  for k, particleSystem in pairs(self.particleSystems) do
    particleSystem:update(dt)
  end
end

function Player:canPush()
  return self.power >= PUSH_COST and self.pushCd == 0 
end

function Player:draw()
  
  local jx, jy, j2x, j2y, jpull = self:control()
  
  local r = 50;
  local g = 50;
  local b = 50;
  local a = 255;
  
  if self.no == 1 then
    r = 255;
  elseif self.no == 2 then 
    b = 255; 
  end
  
  local x, y = self.body:getPosition();
  local pullx, pully = vector.add(x, y, j2x * CONTROLL_RANGE, j2y * CONTROLL_RANGE)
  
  love.graphics.setColor(r, g, b, self.pullApplied * 100)
  love.graphics.circle('fill', pullx, pully, PULL_LENGTH)
  
  
  if self:canPush() then
    love.graphics.setLineWidth(3);
    love.graphics.setColor(r, g, b, 255)
    love.graphics.circle('line', pullx, pully, PUSH_LENGTH)
  end
  
  
  if self.invulnerabilityTime > 0 then
    r = 255;
    g = 255;
    b = 255;
  end
      
  love.graphics.setColor(r,g,b,a);
  love.graphics.circle('fill', x, y, PLAYER_RADIUS)
  love.graphics.setColor(255,255,255)
  
  
  for k, particleSystem in pairs(self.particleSystems) do
    local x, y = self.body:getPosition()
    love.graphics.draw(particleSystem, x+PLAYER_RADIUS/2, y+PLAYER_RADIUS/2)
  end
end

function Player:reset()
  self.body:setPosition(self.startingX, self.startingY)
  self.body:setLinearVelocity(0,0,0)
  self.hitpoints = PLAYER_HITPOINTS
end


return Player
