local Block = {}
Block.__index = Block

function Block.create(def, game)
  local block = { x = def.x, y = def.y, width = def.width, height = def.height, game = game }
  setmetatable(block, Block)

  game.world:add(block, block.x, block.y, block.width, block.height)

  return block
end

function Block:update(dt)

end

function Block:draw()

end

return Block
