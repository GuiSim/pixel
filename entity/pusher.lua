local Pusher = {}
Pusher.__index = Pusher

function Pusher.create(def, game)
  local pusher = {
    game = game,
    x = def.x,
    y = def.y
  }
  setmetatable(pusher, Pusher)
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
  love.graphics.setColor(0, 255, 255, 100);
  love.graphics.circle('fill', self.x, self.y, PUSHER_RANGE)
  love.graphics.setColor(255, 255, 255, 255);
end

return Pusher
