local orderZ = function(a,b)
  return a.z < b.z
end

local music = love.audio.newSource("assets/sounds/fightLoopedMusic.mp3")
music:setLooping(true)
music:setVolume( 0.5 )
local game = {
}

function game:init()
  local width, height = love.graphics.getWidth(), love.graphics.getHeight();
  -- to create canvas
end

function game:enter(current, def, numberOfPlayer)
  self.world = love.physics.newWorld(0, 0, false)
  self.camera = Camera()
  self.entities = {}
  self.balls = {}
  self.players = {}
  self.teamScores = {}
  self.numberOfTeam = 0
  
  for k, entity in pairs(def.entities) do
    if EntityTypes[entity.type] ~= nil then
      if entity.type ~= 'Player' or entity.no <= numberOfPlayer then
        self.entities[k] = EntityTypes[entity.type].create(entity, self);
        self.entities[k].type = entity.type
        self.numberOfTeam = math.max(self.numberOfTeam, entity.team or 0)
      end
    end
  end
  
  for i= 1, self.numberOfTeam do
    self.teamScores[i] = 0
    game.entities["team_score_" .. i] = EntityTypes.Scoreboard.create({team = i}, game);
  end
  
  love.audio.play( music )
  
  self.world:setCallbacks(game.collisionBegin, collisionEnd, preSolve, postSolve)
end

function game.leave()
  love.audio.stop( music )
end

function game.collisionBegin(a, b, collision)
  aUserData = a:getBody():getUserData()
  bUserData = b:getBody():getUserData()
  
  if aUserData ~= nil and aUserData.collisionBegin ~= nil then
    aUserData:collisionBegin(b, collision)
  end
  
  if bUserData ~= nil and bUserData.collisionBegin ~= nil then
    bUserData:collisionBegin(a, collision)
  end
end


function game:update(dt)
  self.world:update(dt)
  
  if love.keyboard.isDown("escape") or love.joystick.getJoysticks()[1]:isGamepadDown("guide") then
    Gamestate.switch(require('state.menu'))
  end

  for k, entity in pairs(self.entities) do
    entity:update(dt)
  end
  
  local teamAlive = 0;
  local nbTeamAlive = 0;
  for k, player in pairs(self.players) do
    if player.hitpoints > 0 then
      nbTeamAlive = nbTeamAlive + 1;
      teamAlive = player.team
    end
  end
  
  if nbTeamAlive == 1 then
    self.teamScores[nbTeamAlive] = self.teamScores[nbTeamAlive] + 1
    local stillAnimated = false;
    for k, player in pairs(self.players) do
      if player.deathTimer > 0 then
        stillAnimated = true
      end
    end
    if not stillAnimated then
      -- Reset scene
      for k, player in pairs(self.players) do
        player:reset()
      end
      for k, ball in pairs(self.balls) do
        ball:reset()
      end
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
