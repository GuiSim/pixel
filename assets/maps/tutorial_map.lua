local BAR_WIDTH = 16; -- The width of the _BARS_
local BAR_LENGTH_VERTICAL = 780;
local BAR_LENGTH_HORIZONTAL = 1700;

local MAP_WIDTH = 1920;
local MAP_HEIGHT = 1080;

local TEXT_WIDTH = 700;

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
  entities = {
    {
      type = 'Arena',
      texture = love.graphics.newImage("assets/textures/tutorial.jpg"),
      polygons = {
        {
          name = "left_bar",
          points = toPolygon(0,0,125, MAP_HEIGHT)
        },
        {
          name = "top_bar",
          points = toPolygon(0,0, MAP_WIDTH, 70)
        },
        {
          name = "bottom_bar",
          points = toPolygon(0,1000, MAP_WIDTH, 70)
        },
        {
          name = "right_bar",
          points = toPolygon(1800, 0, 125, MAP_HEIGHT)
        },
        {
          name = "middle_block",
          points = toPolygon(530, 0, 880, MAP_HEIGHT)
        },
        {
          name = "left_separator",
          points = toPolygon(125, 600, 400, 90)
        },
        {
          name = "right_separator",
          points = toPolygon(1400, 370, 400, 90)
        }
      }
    },
    {
      type = 'Ball',
      no = 2,
      x = 300,
      y = 400,
      texture = love.graphics.newImage("assets/textures/fireball.png")
    },
    {
      type = 'Ball',
      no = 3,
      x = 1550,
      y = 700,
      texture = love.graphics.newImage("assets/textures/fireball.png")
    },
    {
      type = 'Wave',
    },
    {
      type = 'Player',
      no = 1,
      x = 250,
      y = 900,
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
      x = 1750,
      y = 200,
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
      x = 500,
      y = 900,
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
      x = 1500,
      y = 200,
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
