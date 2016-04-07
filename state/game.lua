local orderZ = function(a,b)
  return a.z < b.z
end

local game = {
}

function game:enter(current, map)
  self.world = bump.newWorld();
  self.camera = Camera()
  self.players = {}
  self.tiled = Tiled.load('assets/map', Entity, self)
end


function game:update(dt)
  self.tiled:update(dt)

  local left = self.tiled.width * 16
  local right = 0
  local top = self.tiled.height * 16
  local bottom = 0

  for k, player in pairs(self.players) do
    left = math.min(left, player.x - 120)
    right = math.max(right, player.x + 128)
    top = math.min(top, player.y - 40)
    bottom = math.max(bottom, player.y + 40)
  end

  left = math.max(0, left)
  right = math.min(self.tiled.width * 16, right)
  top = math.max(0, top)
  bottom = math.min(self.tiled.height * 16, bottom)

  self.camera.scale = love.graphics.getWidth() / (right - left), love.graphics.getHeight() / (bottom - top)

  local centerX, centerY = (left + right) / 2, (top + bottom) / 2

  centerY = math.min( centerY * self.camera.scale, self.tiled.height * 16 - love.graphics.getHeight() / self.camera.scale / 2)

  local x, y = math.floor((centerX - self.camera.x) * dt * 4), math.floor((centerY - self.camera.y) * dt * 4)

  self.camera:move(x, y)
end

function game:draw()
  love.graphics.clear(0,0,0,0)
  love.graphics.push()
    self.camera:attach()
    self.tiled:draw()
    self.camera:detach()
  love.graphics.pop()
end

return game
