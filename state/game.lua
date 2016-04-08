local orderZ = function(a,b)
  return a.z < b.z
end

local game = {
}

function game:enter(current, def)
  self.world = love.physics.newWorld(0, 0, false)
  self.camera = Camera()
  self.entities = {}
  self.balls = {}
  self.players = {}
  for k, entity in pairs(def.entities) do
    if EntityTypes[entity.type] ~= nil then
      self.entities[k] = EntityTypes[entity.type].create(entity, self);
    end
  end
end


function game:update(dt)
  self.world:update(dt)

  for k, entity in pairs(self.entities) do
    entity:update(dt)
  end
  
  --[[
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
  ]]--
end

function game:draw()
  love.graphics.clear(0,0,0,0)
  love.graphics.setColor(255,255,255,255)
  love.graphics.push()
    self.camera:attach()
    if love.keyboard.isDown('q') then
      debugWorld(self.world, 0, 0, 2000, 2000)
    else
      for k, entity in pairs(self.entities) do
        entity:draw()
      end
    end
    self.camera:detach()
  love.graphics.pop()
end

return game
