local Player = {}
Player.__index = Player

function Player.create(def, game)
  local joysticks = love.joystick.getJoysticks()
  local player = {
    game = game,
    joystick = joysticks[tonumber(def.properties.no)],
  }
  setmetatable(player, Player)
  
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
  --self.animation:circle(image, self.x, self.y, 0, -1, 1, 16)
end

return Player
