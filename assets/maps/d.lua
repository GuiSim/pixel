local BAR_WIDTH = 8; -- The width of the _BARS_
local BAR_LENGTH_VERTICAL = 780;
local BAR_LENGTH_HORIZONTAL = 1700;

local MAP_WIDTH = 1920;
local MAP_HEIGHT = 1080;

local TOP_LEFT_X = 100;
local TOP_LEFT_Y = 170;
local TOP_RIGHT_X = 1800;
local TOP_RIGHT_Y = 170;
local BOTTOM_LEFT_X = 100;
local BOTTOM_LEFT_Y = 930;

function toPolygon(x, y, width, height)
  return { x, y,
           x + width, y,
           x + width, y + height,
           x, y + height}
end

return {
  nextMap = "assets.maps.e",
  music = love.audio.newSource("assets/sounds/music/musicArena3.mp3"),
  entities = {
    {
      type = 'PlayerBlock',
      points = {
        MAP_WIDTH/2 - BAR_WIDTH/2, 0, 
        MAP_WIDTH/2 + BAR_WIDTH/2, 0,
        MAP_WIDTH/2 + BAR_WIDTH/2, MAP_HEIGHT,
        MAP_WIDTH/2 - BAR_WIDTH/2, MAP_HEIGHT
      }
    },
    {
      type = 'Arena',
      texture = love.graphics.newImage("assets/textures/LavaStage_V01.jpg"),
      polygons = {
        {
          name = "rect_top",
          points = {0,0,
                    1920,0,
                    0,94,
                    1920,94}
        },
        {
          name = "rect_bottom",
          points = {0,977,
                    1920,977,
                    0,1080,
                    1920,1080}
        }
      },
      circles = {
        {
          x = -200,
          y = MAP_HEIGHT/2,
          radius = 550
        },
        {
          x= MAP_WIDTH+200,
          y = MAP_HEIGHT/2,
          radius = 550
        }
      }
    },
    {
      type = "Debris",
      minX = 400, maxX = 1600,
      minY = 400, maxY = 800,
      texture = love.graphics.newImage("assets/textures/crate_chain.png")
    },
    {
      type = "Debris",
      minX = 400, maxX = 1600,
      minY = 400, maxY = 800,
      texture = love.graphics.newImage("assets/textures/crate_chain.png")
    },
    {
      type = "Debris",
      minX = 400, maxX = 1600,
      minY = 400, maxY = 800,
      texture = love.graphics.newImage("assets/textures/crate_chain.png")
    },
    {
      type = "Debris",
      minX = 400, maxX = 1600,
      minY = 400, maxY = 800,
      texture = love.graphics.newImage("assets/textures/crate_chain.png")
    },
    {
      type = "Pusher",
      x = MAP_WIDTH/2,
      y = MAP_HEIGHT/2
    },
    {
      type = "Bump",
      x = 202,
      y = 28,
      texture = love.graphics.newImage("assets/textures/LavaStage_RuneTopleft_glow.png"),
      textureNormal = love.graphics.newImage("assets/textures/LavaStage_RuneTopleft_neutre.png"),
      textureAt = {
        x = 170,
        y = 15,
      }
    },
    {
      type = "Bump",
      x = 207,
      y = 904,
      texture = love.graphics.newImage("assets/textures/LavaStage_RuneTopleft_glow.png"),
      textureNormal = love.graphics.newImage("assets/textures/LavaStage_RuneTopleft_neutre.png"),
      textureAt = {
        x = 166,
        y = 800,
      }
    },
    {
      type = "Bump",
      x = 1743,
      y = 50,
      texture = love.graphics.newImage("assets/textures/LavaStage_RuneTopright_glow.png"),
      textureNormal = love.graphics.newImage("assets/textures/LavaStage_RuneTopright_neutre.png"),
      textureAt = {
        x = 1639,
        y = 2,
      }
    },
    {
      type = "Bump",
      x = 1716,
      y = 938,
      texture = love.graphics.newImage("assets/textures/LavaStage_RuneTopright_glow.png"),
      textureNormal = love.graphics.newImage("assets/textures/LavaStage_RuneTopright_neutre.png"),
      textureAt = {
        x = 1645,
        y = 834
      }
    },
    {
      type = 'Ball',
      no = 2,
      x = MAP_WIDTH/2,
      y = MAP_HEIGHT/2 + 50,
      texture = love.graphics.newImage("assets/textures/fireball.png")
    },
    {
      type = 'Ball',
      no = 2,
      x = MAP_WIDTH/2,
      y = MAP_HEIGHT/2 - 50,
      texture = love.graphics.newImage("assets/textures/fireball.png")
    },
    {
      type = 'Wave',
    },
    {
      type = 'Player',
      no = 1,
      x = TOP_LEFT_X + 525;
      y = (TOP_LEFT_Y + BOTTOM_LEFT_Y)/2 - 250,
      texture = love.graphics.newImage("assets/textures/red.png"),
      pullTexture = love.graphics.newImage("assets/textures/red_pull.png"),
      shieldTexture = love.graphics.newImage("assets/textures/shield.png"),
      shieldInvincibleTexture = love.graphics.newImage("assets/textures/shield_invincible.png"),
      pull1Texture = love.graphics.newImage("assets/textures/pull1.png"),
      pull2Texture = love.graphics.newImage("assets/textures/pull2.png"),
      startDirection = 1,
      team = 1
    },
    {
      type = 'Player',
      no = 2,
      x = TOP_LEFT_X + BAR_LENGTH_HORIZONTAL - 525,
      y = (TOP_LEFT_Y + BOTTOM_LEFT_Y)/2 + 250,
      texture = love.graphics.newImage("assets/textures/blue.png"),
      pullTexture = love.graphics.newImage("assets/textures/blue_pull.png"),
      shieldTexture = love.graphics.newImage("assets/textures/shield.png"),
      shieldInvincibleTexture = love.graphics.newImage("assets/textures/shield_invincible.png"),
      pull1Texture = love.graphics.newImage("assets/textures/pull1.png"),
      pull2Texture = love.graphics.newImage("assets/textures/pull2.png"),
      startDirection = -1,
      team = 2
    },
    {
      type = 'Player',
      no = 3,
      x = TOP_LEFT_X + 525;
      y = (TOP_LEFT_Y + BOTTOM_LEFT_Y)/2 + 250,
      texture = love.graphics.newImage("assets/textures/pink.png"),
      pullTexture = love.graphics.newImage("assets/textures/pink_pull.png"),
      shieldTexture = love.graphics.newImage("assets/textures/shield.png"),
      shieldInvincibleTexture = love.graphics.newImage("assets/textures/shield_invincible.png"),
      pull1Texture = love.graphics.newImage("assets/textures/pull1.png"),
      pull2Texture = love.graphics.newImage("assets/textures/pull2.png"),
      startDirection = 1,
      team = 1
    },
    {
      type = 'Player',
      no = 4,
      x = TOP_LEFT_X + BAR_LENGTH_HORIZONTAL - 525,
      y = (TOP_LEFT_Y + BOTTOM_LEFT_Y)/2 - 250,
      texture = love.graphics.newImage("assets/textures/green.png"),
      pullTexture = love.graphics.newImage("assets/textures/green_pull.png"),
      shieldTexture = love.graphics.newImage("assets/textures/shield.png"),
      shieldInvincibleTexture = love.graphics.newImage("assets/textures/shield_invincible.png"),
      pull1Texture = love.graphics.newImage("assets/textures/pull1.png"),
      pull2Texture = love.graphics.newImage("assets/textures/pull2.png"),
      startDirection = -1,
      team = 2
    }
  }
}
