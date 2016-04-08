local BAR_WIDTH = 10; -- The width of the _BARS_
local BAR_LENGTH = 400;

return {
  entities = {
    {
      type = 'Player',
      no = 1,
      x = 32,
      y = 32
    },
    {
      type = 'Player',
      no = 2,
      x = BAR_LENGTH * 2 - 32,
      y = 32
    },
    {
      type = 'Arena',
      polygons = {
        {
          name = "top_bar",
          points = {0, 0,
                    BAR_LENGTH * 2, 0,
                    BAR_LENGTH * 2 , BAR_WIDTH,
                    0, BAR_WIDTH}
        },
        {
          name = "bottom_bar",
          points = {0, BAR_LENGTH - BAR_WIDTH, 
                    BAR_LENGTH * 2, BAR_LENGTH - BAR_WIDTH, 
                    BAR_LENGTH * 2, BAR_LENGTH, 
                    0, BAR_LENGTH}
        },
        {
          name = "left_bar",
          points = {
            0, 0,
            BAR_WIDTH, 0,
            BAR_WIDTH, BAR_LENGTH,
            0, BAR_LENGTH
          }
        },
        {
          name = "right_bar",
          points = {
            BAR_LENGTH * 2 - BAR_WIDTH, 0,
            BAR_LENGTH * 2, 0,
            BAR_LENGTH * 2, BAR_LENGTH,
            BAR_LENGTH * 2 - BAR_WIDTH, BAR_LENGTH
          }
        }
      }
    },
    {
      type = 'PlayerBlock',
      points = {
        BAR_LENGTH - BAR_WIDTH/2, 0, 
        BAR_LENGTH + BAR_WIDTH/2, 0,
        BAR_LENGTH + BAR_WIDTH/2, BAR_LENGTH,
        BAR_LENGTH - BAR_WIDTH/2, BAR_LENGTH
      }
    },
    {
      type = 'Ball',
      no = 2,
      x = 64,
      y = 32
    }
  }
}
