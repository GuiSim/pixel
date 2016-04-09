
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
  pullShader:send('startAt',PLAYER_RADIUS);

  local pullings = {};
  local pullingsPosition = {};
  local pullingsLength = {};
  local pullingsDirection = {};
  local pushings = {};
  local pushingsLength = {};
  local pushingsPosition = {}
  
  
  for k, player in pairs(self.game.players) do
    
    if player.pullApplied > 0 then
      table.insert(pullings, player.pullApplied * (player.active and 1 or player.deathTimer));
      local pullx, pully = player:pullPosition()
      table.insert(pullingsPosition, {pullx, pully});
      table.insert(pullingsLength, PULL_LENGTH);
      table.insert(pullingsDirection, -1);
    end
    
    if player.pushCd > 0 then
      table.insert(pushings, (PUSH_COOLDOWN - player.pushCd) / PUSH_ANIMATION * (player.active and 1 or player.deathTimer));
      table.insert(pushingsPosition, {player.body:getX(), player.body:getY()});
      table.insert(pushingsLength, PUSH_LENGTH);
    end
    
  end
  for k, puller in pairs(self.game.pullers) do
    table.insert(pullings, 1);
    table.insert(pullingsPosition, {puller.x, puller.y});
    table.insert(pullingsLength, PULLER_RANGE);
    table.insert(pullingsDirection, -1);
  end
  
  for k, pusher in pairs(self.game.pushers) do
    table.insert(pullings, 1);
    table.insert(pullingsPosition, {pusher.x, pusher.y});
    table.insert(pullingsLength, PULLER_RANGE);
    table.insert(pullingsDirection, 1);
  end
  
  for k, bump in pairs(self.game.bumps) do
    local time = 1 - (bump.timer / BUMP_PUSH_ANIMATION);
    local startAt = BUMP_PUSH_MIN / BUMP_PUSH_LENGTH;
    
    time = time * ( 1 - startAt ) + startAt;
    
    local bumpx,bumpy = bump:pushPosition()
    
    table.insert(pushings, time);
    table.insert(pushingsPosition, {bumpx, bumpy});
    table.insert(pushingsLength, BUMP_PUSH_LENGTH);
  end
  
  local nbPosition = #pullings;
  for i = nbPosition + 1, 6 do
    table.insert(pullings, 0);
    table.insert(pullingsPosition, {0, 0});
    table.insert(pullingsLength, 0);
    table.insert(pullingsDirection, 0);
  end
  
  pullShader:send('pullings', unpack(pullings));
  pullShader:send('pullingsPosition', unpack(pullingsPosition));
  pullShader:send('pullingsLength', unpack(pullingsLength));
  pullShader:send('pullingsDirection', unpack(pullingsDirection));
  
  nbPosition = #pushings;
  for i = nbPosition + 1, 8 do
    table.insert(pushings, 0);
    table.insert(pushingsPosition, {0, 0});
    table.insert(pushingsLength, 0);
  end
  
  pullShader:send('pushings', unpack(pushings));
  pullShader:send('pushingsPosition', unpack(pushingsPosition));
  pullShader:send('pushingsLength', unpack(pushingsLength));
  
  love.graphics.draw(self.game.preCanvas)
  
  love.graphics.reset()
  love.graphics.setCanvas(self.game.canvas)
end

return Wave