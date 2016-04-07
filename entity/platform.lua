local Platform = {}
Platform.__index = Platform

function Platform.create(def, game)
  local platform = {}
  setmetatable(platform, Platform)
  return platform
end

function Platform:update(dt)

end

function Platform:draw()
  
end

return Platform
