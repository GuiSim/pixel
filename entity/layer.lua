local Layer = {}
Layer.__index = Layer

function Layer.create(def, game)
  local layer = {
    game = game,
    entities = {}
  }
  
  setmetatable(layer, Layer)
  
  for k, entity in pairs(def.entities) do
    if EntityTypes[entity.type] ~= nil then
      layer.entities[k] = EntityTypes[entity.type].create(entity, game);
      layer.entities[k].type = entity.type
    end
  end
  
  return layer
end

function Layer:update(dt)
  for k, entity in pairs(self.entities) do
    entity:update(dt)
  end
end

function Layer:draw()
  for k, entity in pairs(self.entities) do
    entity:draw()
  end
end

return Layer
