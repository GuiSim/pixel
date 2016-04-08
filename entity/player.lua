local Player = {}
Player.__index = Player

local PLAYER_FORCE = 7500;
local PLAYER_DAMPENING = 10;
local PLAYER_PLAYER_DENSITY = 10;
local PLAYER_HITPOINTS = 100;
local BALL_DAMAGE = 10;

local radius = 16;
Player.category = 1;
Player.mask = -1;

function Player.create(def, game)
  local joysticks = love.joystick.getJoysticks()
  local player = {
    game = game,
    joystick = joysticks[tonumber(def.no)],
    no = def.no,
    hitPoints = PLAYER_HITPOINTS
  }
  
  setmetatable(player, Player)
  
  player.body = love.physics.newBody(game.world, def.x, def.y, "dynamic")
  player.body:setLinearDamping(PLAYER_DAMPENING)
  
  player.body:setUserData(player)
  
  local fixture = love.physics.newFixture(player.body, love.physics.newCircleShape(radius), PLAYER_PLAYER_DENSITY)
  fixture:setFilterData( Player.category, Player.mask, 0 )
  table.insert(game.players, player)

  return player
end

function Player:collisionBegin(other, collision)
  if other.type == "Ball" then
    self.hitPoints = self.hitPoints - BALL_DAMAGE
  end
end

function Player:control()
  if self.joystick == nil then
    return 0, 0
  end
  x = self.joystick:getGamepadAxis('leftx')
  y = self.joystick:getGamepadAxis('lefty')
  
  if vector.len2(x,y) < 0.2 then
    x = 0
    y = 0
  end
  
  return x, y 
end

function Player:update(dt)
  local jx, jy = self:control()
  self.body:applyForce(vector.mul(PLAYER_FORCE, jx, jy));
end

function Player:draw()
  if self.no == 1 then
    love.graphics.setColor(255, 50, 50, self.hitPoints*255/100)    
  elseif self.no == 2 then 
      love.graphics.setColor(50, 50, 255, self.hitPoints*255/100)
  else 
      love.graphics.setColor(255, 255, 255, self.hitPoints*255/100)
  end

  love.graphics.circle('fill', self.body:getX(), self.body:getY(), radius)
  love.graphics.setColor()
end

return Player
