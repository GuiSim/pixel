local Player = {}
Player.__index = Player

local radius = 16;

function Player.create(def, game)
  local joysticks = love.joystick.getJoysticks()
  local player = {
    game = game,
    joystick = joysticks[tonumber(def.properties.no)],
  }
  setmetatable(player, Player)
  
  player.body = love.physics.newBody(game.world, def.x, def.y, "dynamic")
  
  love.physics.newFixture(player.body, love.physics.newCircleShape(radius), 1)
  
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
end

function Player:draw()
  self.animation:circle('fill', self.body.getX(), self.body.getY(), radius)
end

return Player
