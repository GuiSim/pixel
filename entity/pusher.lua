local Pusher = {}
Pusher.__index = Pusher

function Pusher.create(def, game)
  local pusher = {
    game = game,
    x = def.x,
    y = def.y
  }
  setmetatable(pusher, Pusher)
  table.insert(game.pushers, pusher)
  return pusher
end

function Pusher:update(dt)
  
  for k, pullable in pairs(self.game.pullables) do
    local pullableX, pullableY = pullable.body:getPosition();
    local diffX, diffY =  vector.sub(self.x, self.y, pullableX, pullableY);
    local len = vector.len(diffX, diffY);
    
    if len < PUSHER_RANGE then
      local energie = 1 - len / PUSHER_RANGE;
      pullable.body:applyForce(vector.mul(-1 * energie * PUSHER_FORCE / len, diffX, diffY))
    end
  end
end

function Pusher:draw()
end

return Pusher
