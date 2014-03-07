require "class/Game"
Gamestate = require "class/Gamestate"
Camera =require "class/Camera"
Timer = require "class/Timer"

require "gamestate/jeu"
require "gamestate/start"
require "gamestate/gameover"
require "gamestate/credit"

cam = Camera()

SCREEN_HEIGHT = 800
SCREEN_WIDTH  = 480



  SCREEN_PHONE_HEIGHT = love.graphics.getHeight()
  SCREEN_PHONE_WIDTH  =  love.graphics.getWidth()
  


font = love.graphics.newFont( "font/ka1.ttf", 72 )
font2 = love.graphics.newFont( "font/ka1.ttf", 35 )



highscore = love.filesystem.read( "/highscore", nil )
if not highscore then
  love.filesystem.write( "/highscore", "0" )
  highscore = "0"
end
print("highscore : "..highscore)

function love.load(arg)

  Gamestate.registerEvents()
  cam = camera()
  
  if love.system.getOS()=="Android" then 
    --cam:rotate (-math.pi/2)
    if SCREEN_PHONE_HEIGHT / SCREEN_PHONE_WIDTH == (16/9) then
      cam:lookAt(SCREEN_WIDTH/2, SCREEN_HEIGHT/2+54/2)
    elseif SCREEN_PHONE_HEIGHT / SCREEN_PHONE_HEIGHT == (5/3) then
      cam:lookAt(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)
    end
    cam:zoom ((SCREEN_PHONE_WIDTH/SCREEN_WIDTH))
  end
  
  Gamestate.switch(credit)

end
