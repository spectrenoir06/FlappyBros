Camera =require "class.Camera"
cam = Camera()

jeu = {}

function jeu:init()

end

function jeu:enter()
    partit = new_Game()
end


function jeu:draw()

  cam:attach()
  partit:draw()
  cam:detach()
  
end

function jeu:update(dt)
  partit:update(dt)
end

function jeu:mousepressed(Sx, Sy, button)
    if partit.wait and button then
      partit:start()
    elseif button then
      partit:up()
    end
end

function jeu:keypressed(key)
  if key=="escape" then
    love.event.push("quit")
  end
end