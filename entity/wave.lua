
local Wave = {}
Wave.__index = Wave

function Wave.create(def, game)
  local wave = {
    game = game
  }
  setmetatable(wave, Wave)
  return wave
end


function Wave:update(dt)
end

function Wave:draw()
  love.graphics.setCanvas(self.game.preCanvas)
  love.graphics.draw(self.game.canvas)
  
  love.graphics.setCanvas(self.game.canvas)
  
  love.graphics.setShader(pullShader)
  
  love.graphics.setColor(255,255,255,255)
  pullShader:send('timer', love.timer.getTime( ));
  pullShader:send('pushingLength',PUSH_LENGTH);
  pullShader:send('startAt',PLAYER_RADIUS);

  local pullings = {};
  local pullingsPosition = {};
  local pullingsLength = {};
  local pushings = {};
  local pushingsPosition = {}
  
  
  for k, player in pairs(self.game.players) do
    
    if player.pullApplied > 0 then
      table.insert(pullings, player.pullApplied * (player.active and 1 or player.deathTimer));
      local pullx, pully = player:pullPosition()
      table.insert(pullingsPosition, {pullx, pully});
      table.insert(pullingsLength, PULL_LENGTH);
    end
    
    if player.pushCd > 0 then
      table.insert(pushings, (PUSH_COOLDOWN - player.pushCd) / PUSH_ANIMATION * (player.active and 1 or player.deathTimer));
      table.insert(pushingsPosition, {player.body:getX(), player.body:getY()});
    end
    
  end
  for k, puller in pairs(self.game.pullers) do
    table.insert(pullings, 1);
    table.insert(pullingsPosition, {puller.x, puller.y});
    table.insert(pullingsLength, PULLER_RANGE);
  end
  
  local nbPosition = #pullings;
  for i = nbPosition + 1, 6 do
    table.insert(pullings, 0);
    table.insert(pullingsPosition, {0, 0});
    table.insert(pullingsLength, 0);
  end
  
  
  pullShader:send('pullings', unpack(pullings));
  pullShader:send('pullingsPosition', unpack(pullingsPosition));
  pullShader:send('pullingsLength', unpack(pullingsLength));
  
  nbPosition = #pushings;
  for i = nbPosition + 1, 4 do
    table.insert(pushings, 0);
    table.insert(pushingsPosition, {0, 0});
  end
  
  pullShader:send('pushings', unpack(pushings));
  pullShader:send('pushingsPosition', unpack(pushingsPosition));
  
  love.graphics.draw(self.game.preCanvas)
  
  love.graphics.reset()
  love.graphics.setCanvas(self.game.canvas)
end

return Wave