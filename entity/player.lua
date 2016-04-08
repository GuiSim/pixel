local Player = {}
Player.__index = Player

local radius = 16;
Player.category = 1;
Player.mask = -1;

function Player.create(def, game)
  local joysticks = love.joystick.getJoysticks()
  local player = {
    game = game,
    joystick = joysticks[tonumber(def.no)],
  }
  setmetatable(player, Player)
  
  player.body = love.physics.newBody(game.world, def.x, def.y, "dynamic")
  player.body:setLinearDamping(2)
  
  local fixture = love.physics.newFixture(player.body, love.physics.newCircleShape(radius), 1)
  fixture:setFilterData( Player.category, Player.mask, 0 )
  
  table.insert(game.players, player)

  return player
end


function Player:control()
  if self.joystick == nil then
    return 0, 0
  end
  return self.joystick:getGamepadAxis('leftx'), self.joystick:getGamepadAxis('lefty')
end

function Player:update(dt)
  local jx, jy = self:control()
  self.body:applyForce(vector.mul(300, jx, jy));
end

function Player:draw()
  love.graphics.circle('fill', self.body:getX(), self.body:getY(), radius)
end

return Player
