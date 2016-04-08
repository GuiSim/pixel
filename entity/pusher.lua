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
  
  for k, ball in pairs(self.game.balls) do
    local ballX, ballY = ball.body:getPosition();
    local diffX, diffY =  vector.sub(self.x, self.y, ballX, ballY);
    local len = vector.len(diffX, diffY);
    
    if len < PUSHER_RANGE then
      local energie = 1 - len / PUSHER_RANGE;
      ball.body:applyForce(vector.mul(-1 * energie * PUSHER_FORCE / len, diffX, diffY))
    end
  end
end

function Pusher:draw()
  love.graphics.setColor(0, 255, 255, 100);
  love.graphics.circle('fill', self.x, self.y, PUSHER_RANGE)
  love.graphics.setColor(255, 255, 255, 255);
end

return Pusher
