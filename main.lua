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
Entity = {
  Player = require "entity.player",
  Enemy = require "entity.enemy",
  Platform = require "entity.platform",
  Block = require "entity.block"
}

function love.load()
    Gamestate.registerEvents()
    Gamestate.switch(require('state.menu'))
end
