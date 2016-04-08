local MAP_1_WIDTH = 10; -- The width of the _BARS_
local MAP_1_LENGTH = 400;

return {
  entities = {
    {
      type = 'Player',
      no = 1,
      x = 32,
      y = 32
    },
    {
      type = 'Arena',
      sides = {
        {
          name = "top_bar",
          x = 0,
          y = 0,
          width = MAP_1_LENGTH * 2,
          height = MAP_1_WIDTH
        },
        {
          name = "bottom_bar",
          x = 0,
          y = MAP_1_LENGTH,
          width = MAP_1_LENGTH * 2,
          height = MAP_1_WIDTH
        },
        {
          name = "left_bar",
          x = 0,
          y = 0,
          width = MAP_1_WIDTH,
          height = MAP_1_LENGTH
        },
        {
          name = "right_bar",
          x = MAP_1_LENGTH * 2,
          y = 0,
          width = MAP_1_WIDTH,
          height = MAP_1_LENGTH + MAP_1_WIDTH -- Gotta compensate for that missing width. Trust me.
        }
      }
    }
  }
}