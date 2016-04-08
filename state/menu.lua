local menu = {}

function menu:draw()
    love.graphics.print("Press Start!", love.graphics.getWidth()/2, 100, 0, 2, 2)
end

function menu:joystickpressed(joystick, button)
    if button == 9 then -- Start button
        Gamestate.switch(require('state.game'), require('assets.maps.a'))
    end
end

return menu
