local Tiled = {}
Tiled.__index = Tiled

function Tiled.load(filename, entityTypes, ...)
  local tiled = require(filename)
  setmetatable(tiled, Tiled)

  tiled.path = string.match(filename, '(.*/)(.*)$')
  tiled.tiles = {}
  tiled.entityTypes = entityTypes
  tiled.entityParams = ...
  tiled.x = 0
  tiled.y = 0

  for k, tileset in pairs(tiled.tilesets) do
    tiled:loadTileset(tileset)
  end
  for k, layer in pairs(tiled.layers) do
    tiled:loadLayer(layer)
  end

  return tiled
end

function Tiled:loadTileset(tileset)
  local start = tileset.firstgid
  local image = love.graphics.newImage(self.path .. tileset.image)
  local nbCol = math.floor(tileset.imagewidth / tileset.tilewidth);
  for i = tileset.firstgid, tileset.firstgid + tileset.tilecount - 1 do
    local x, y = (i - 1) % nbCol, math.floor((i - 1) / nbCol)
    self.tiles[i] = {quad = love.graphics.newQuad(x * tileset.tilewidth, y * tileset.tileheight, tileset.tilewidth, tileset.tileheight, tileset.imagewidth, tileset.imageheight), image = image}
  end
end

function Tiled:loadLayer(layer)
  if layer.type == "tilelayer" then
    layer.canvas = love.graphics.newCanvas(layer.width * self.tilewidth, layer.height * self.tileheight, 'normal', 8)
    --layer.canvas:setFilter('nearest','nearest')
    love.graphics.setCanvas(layer.canvas)
    love.graphics.clear(0, 0, 0, 0)
    love.graphics.setColor(255, 255, 255, layer.opacity * 255)
    for x = 0, layer.width - 1 do
      for y = 0, layer.width - 1 do
        local tile = self.tiles[layer.data[1 + x + y * layer.width]]
        if tile ~= nil then
          love.graphics.draw(tile.image, tile.quad, x * self.tilewidth, y * self.tileheight)
        end
      end
    end
    love.graphics.reset()
    layer.draw = function()
      love.graphics.draw(layer.canvas, layer.offsetx, layer.offsety)
    end
  elseif layer.type == "objectgroup" then
    layer.update = function(layer, dt)
        for _, entity in pairs(layer.entities) do
            entity:update(dt)
        end
    end

    layer.draw = function(layer)
      for _, entity in pairs(layer.entities) do
          entity:draw()
      end
    end

    layer.entities = {}
    for i, entity in pairs(layer.objects) do
      if self.entityTypes[entity.type] ~= nil then
        table.insert(layer.entities, self.entityTypes[entity.type].create(entity, self.entityParams))
      end
    end
  end
end

function Tiled:update(dt)
  for k, layer in pairs(self.layers) do
    if layer.update ~= nil then
      layer:update(dt)
    end
  end
end

function Tiled:draw()
  love.graphics.push()
  love.graphics.translate(-self.x, -self.y)
  for k, layer in pairs(self.layers) do
    if layer.draw ~= nil then
      layer:draw()
    end
  end
  love.graphics.pop()
end

return Tiled
