local orderZ = function(a,b)
  return a.z < b.z
end

local music = love.audio.newSource("assets/sounds/musicArena1.mp3", "stream")
music:setLooping(true)
music:setVolume( 0.7 )
local game = {
}

function game:init()
  local width, height = love.graphics.getWidth(), love.graphics.getHeight();
  self.canvas = love.graphics.newCanvas(width, height, "normal", 4)
  self.preCanvas = love.graphics.newCanvas(width, height, "normal", 4)
end

function game:enter(current, def, numberOfPlayer)
  self.world = love.physics.newWorld(0, 0, false)
  self.camera = Camera()
  self.entities = {}
  self.balls = {}
  self.debris = {}
  self.players = {}
  self.pullables = {}
  self.teamScores = {}
  self.numberOfTeam = 0
  self.currentMap = def
  self.nextMap = def.nextMap
  self.waitForAnimation = false

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
  for k, joystick in pairs(love.joystick.getJoysticks()) do
    joystick:setVibration(0,0)
  end
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

function game:joystickpressed(joystick, button)
  if self.nextMap and joystick:isGamepadDown("start") then
    Gamestate.switch(Game, require(self.nextMap), Menu.selections[Menu.selection].playerCount)
  end
end


function game:update(dt)
  self.world:update(dt)

  if love.keyboard.isDown("1") then
    Gamestate.switch(Game, require('assets.maps.tutorial_map'), Menu.selections[Menu.selection].playerCount)
  end
  
  if love.keyboard.isDown("2") then
    Gamestate.switch(Game, require('assets.maps.b'), Menu.selections[Menu.selection].playerCount)
  end
  
  if self.nextMap and love.keyboard.isDown("space") then
    Gamestate.switch(Game, require(self.nextMap), Menu.selections[Menu.selection].playerCount)
  end
  
  
  if love.keyboard.isDown("escape") or (love.joystick.getJoysticks()[1] and love.joystick.getJoysticks()[1]:isGamepadDown("guide")) then
    Gamestate.switch(Menu)
  end

  for k, entity in pairs(self.entities) do
    entity:update(dt)
  end

  if not self.waitForAnimation then
    local teamAlive = 0;
    local nbTeamAlive = 0;
    for k, player in pairs(self.players) do
      if player.hitpoints > 0 then
        if teamAlive ~=  player.team then
          nbTeamAlive = nbTeamAlive + 1;
          teamAlive = player.team
        end
      end
    end
    if nbTeamAlive == 1 then
      self.waitForAnimation = true
      self.teamScores[nbTeamAlive] = self.teamScores[nbTeamAlive] + 1
    end
  else
    local stillAnimated = false;
    for k, player in pairs(self.players) do
      if player.deathTimer > 0 then
        stillAnimated = true
      end
    end
    if not stillAnimated then
      self.waitForAnimation = false
      -- Reset scene
      for k, player in pairs(self.players) do
        player:reset()
      end
      for k, ball in pairs(self.balls) do
        ball:reset()
      end
      for k, debris in pairs(self.debris) do
        debris:reset()
      end
    end
  end
end

function game:draw()
  local canvas = love.graphics.getCanvas();
  love.graphics.reset()
  love.graphics.setCanvas(self.canvas)

  love.graphics.clear(0,0,0,0)
  love.graphics.setColor(255,255,255,255)
  if love.keyboard.isDown('q') then
    debugWorld(self.world, 0, 0, 2000, 2000)
    love.graphics.reset()
    love.graphics.setCanvas(canvas)
    love.graphics.draw(self.canvas)
    
    return;
  else
    for k, entity in pairs(self.entities) do
      entity:draw()
    end
  end
  
  love.graphics.reset()
  love.graphics.setCanvas(canvas)
  love.graphics.draw(self.canvas)
end



return game
