local menu = {}

function menu:draw()
    love.graphics.print("Press Enter to continue", 10, 10)
end

function menu:keyreleased(key, code)
    if key == 'return' then
        Gamestate.switch(require('state.game'), require('assets.maps.a'))
    end
end

return menu
