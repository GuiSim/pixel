local BAR_WIDTH = 16; -- The width of the _BARS_
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
  nextMap = "assets.maps.b",
  music = love.audio.newSource("assets/sounds/music/musicArena2.mp3"),
  entities = {
    {
      type = 'Arena',
      texture = love.graphics.newImage("assets/textures/arena_c.jpg"),
      polygons = {
        {
          name = "top_left_triangle",
          points = {0,0,
                    607,31,
                    0, 919}
        },
        {
          name = "upper_right_triangle",
          points = {1290,0,
                    1920,0,
                    1920,900}
        },
        {
          name = "lower_left_triangle",
          points = {0,171,
                    0,1080,
                    637,1080}
        },
        {
          name = "lower_right_triangle",
          points = {1920,176,
                    1920,1080,
                    1266,1080}
        },
        {
          name = "upper_rect",
          points =  {0,0,
                     1920,0,
                     0,35,
                     1920,35}
        },
        {
          name = "botton_rect",
          points = {0,1040,
                    1920,1040,
                    0,1080,
                    1920,1080}
        }
      }
    },
    {
      type = "Debris",
      minX = 400, maxX = 1600,
      minY = 400, maxY = 800,
      texture = love.graphics.newImage("assets/textures/crate.png")
    },
    {
      type = "Debris",
      minX = 400, maxX = 1600,
      minY = 400, maxY = 800,
      texture = love.graphics.newImage("assets/textures/crate.png")
    },
    {
      type = "Debris",
      minX = 400, maxX = 1600,
      minY = 400, maxY = 800,
      texture = love.graphics.newImage("assets/textures/crate.png")
    },
    {
      type = "Debris",
      minX = 400, maxX = 1600,
      minY = 400, maxY = 800,
      texture = love.graphics.newImage("assets/textures/crate.png")
    },
    {
      type = "Puller",
      x = MAP_WIDTH/2,
      y = 256
    },
    {
      type = "Puller",
      x = MAP_WIDTH/2,
      y = 812
    },
    {
      type = 'Ball',
      no = 2,
      x = MAP_WIDTH/2,
      y = MAP_HEIGHT/2,
      texture = love.graphics.newImage("assets/textures/fireball.png")
    },
    {
      type = 'Wave',
    },
    {
      type = 'Player',
      no = 1,
      x = TOP_LEFT_X + 200;
      y = (TOP_LEFT_Y + BOTTOM_LEFT_Y)/2,
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
      x = TOP_LEFT_X + BAR_LENGTH_HORIZONTAL - 200,
      y = (TOP_LEFT_Y + BOTTOM_LEFT_Y)/2,
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
      x = TOP_LEFT_X + 500;
      y = (TOP_LEFT_Y + BOTTOM_LEFT_Y)/2,
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
      x = TOP_LEFT_X + BAR_LENGTH_HORIZONTAL - 500,
      y = (TOP_LEFT_Y + BOTTOM_LEFT_Y)/2,
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
