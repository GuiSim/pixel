local PlayerBlock = {}
PlayerBlock.__index = PlayerBlock

PlayerBlock.category = -1;


function PlayerBlock.create(def, game)
  local playerBlock = {
    game = game,
    points = def.points
  }
  setmetatable(playerBlock, PlayerBlock)
  
  playerBlock.body = love.physics.newBody(game.world, 0, 0, "static")

  local fixture = love.physics.newFixture(playerBlock.body, love.physics.newPolygonShape(def.points), 1)
  fixture:setFilterData( PlayerBlock.category, EntityTypes.Player.category, 0 )
  
  return playerBlock
end

function PlayerBlock:update(dt)
end

function PlayerBlock:draw()
  love.graphics.setColor(100, 100, 100)
  love.graphics.polygon('fill', self.points)
end

return PlayerBlock
