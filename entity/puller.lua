local Puller = {}
Puller.__index = Puller

function Puller.create(def, game)
  local puller = {
    game = game,
    x = def.x,
    y = def.y
  }
  setmetatable(puller, Puller)
  table.insert(game.pullers, puller)
  return puller
end

function Puller:update(dt)
  
  for k, pullable in pairs(self.game.pullables) do
    local pullableX, pullableY = pullable.body:getPosition();
    local diffX, diffY =  vector.sub(self.x, self.y, pullableX, pullableY);
    local len = vector.len(diffX, diffY);
    
    if len < PULLER_RANGE then
      local energie = 1 - len / PULLER_RANGE;
      pullable.body:applyForce(vector.mul(energie * PULLER_FORCE / len, diffX, diffY))
    end
  end
end

function Puller:draw()
end

return Puller
