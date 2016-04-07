local Player = {}
Player.__index = Player


function Player.create(def, game)
  local joysticks = love.joystick.getJoysticks()
  local player = { x = def.x, y = def.y, vx = 0, vy = 0, game = game, joystick = joysticks[tonumber(def.properties.no)], jumping = -1, onFloor = false}

  setmetatable(player, Player)
  game.world:add(player, player.x, player.y, 16, 18)
  player.animation = animations.stand:clone()
  player.state = 'stand'

  table.insert(game.players, player)

  return player
end

function Player.collisionFilter()

end

function Player:control()
  if self.joystick == nil then
    return 0, 0, false
  end
  return self.joystick:getGamepadAxis('leftx'), self.joystick:getGamepadAxis('lefty'), self.joystick:isGamepadDown('a')
end

function Player:update(dt)
  local jx, jy, jump = self:control()

  -- move
  if math.abs(jx) > 0.2 then
    self.vx = self.vx + jx * runSpeed * dt
  end

  if self.vx > 0 then
    self.vx = self.vx - runSpeed / 2 * dt
  elseif self.vx < 0 then
    self.vx = self.vx + runSpeed / 2 * dt
  end

  -- jump
  if jump then
    if self.onFloor then
      self.onFloor = false
      self.vy = jumpSpeed
    end
  elseif self.vy < jumpSpeed / 2 then
    self.vy = jumpSpeed / 2
  end

  -- gravity
  self.vy = self.vy + gravity * dt

  if math.abs(self.vx) > runSpeed then
    self.vx = self.vx / math.abs(self.vx) * runSpeed
  end

  self.vx, self.vy = vector.trim(maxSpeed, self.vx, self.vy)

  local actualX, actualY, cols, colLen = self.game.world:move(self, self.x + self.vx * dt, self.y + self.vy * dt, self.filter)

  self.vx, self.vy = (actualX - self.x) / dt, (actualY - self.y) / dt

  self.x, self.y = actualX, actualY

  for k, col in pairs(cols) do
    print(col)
    if col.normal.y == -1 then
      self.onFloor = true
    end
  end
end

function Player:draw()
  self.animation:draw(image, self.x, self.y, 0, -1, 1, 16)
end

return Player
