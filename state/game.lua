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
      self.entities[k].type = entity.type
    end
  end
  
  self.world:setCallbacks(game.collisionBegin, collisionEnd, preSolve, postSolve)
end

function game.collisionBegin(a, b, collision)
  aUserData = a:getBody():getUserData()
  bUserData = b:getBody():getUserData()
  
  if aUserData ~= nil and aUserData.collisionBegin ~= nil then
    aUserData:collisionBegin(bUserData, collision)
  end
  
  if bUserData ~= nil and bUserData.collisionBegin ~= nil then
    bUserData:collisionBegin(a, collision)
  end
end


function game:update(dt)
  self.world:update(dt)

  for k, entity in pairs(self.entities) do
    entity:update(dt)
  end
  
  local playerThatDied = nil
  for k, player in pairs(self.players) do
    if player.hitpoints <= 0 then
      playerThatDied = player;
      -- TODO: Play death animation
    end
  end
  
  if playerThatDied ~= nil then
    for k, player in pairs(self.players) do
      if player ~= playerThatDied then
        player.score = player.score + 1;
      end
    end
    -- Reset scene
    for k, player in pairs(self.players) do
      player:reset()
    end
    for k, ball in pairs(self.balls) do
      ball:reset()
    end
    
  end
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
  love.graphics.reset()
end

return game
