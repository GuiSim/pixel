-- LIBS
Gamestate = require "hump.gamestate"
Timer = require "hump.timer"
vector = require "hump.vector-light"
Class = require "hump.class"
Signal = require 'hump.signal'
Camera = require "hump.camera"

anim8 = require "anim8"
bump = require 'bump'

debugWorld = require "debugWorld"

-- entities
EntityTypes = {
  Player = require "entity.player",
  PlayerBlock= require "entity.playerBlock",
  Arena = require "entity.arena"
}

function love.load()
  
      -- Conf
    love.physics.setMeter(50)
    
    Gamestate.registerEvents()
    Gamestate.switch(require('state.menu'))
  

end
