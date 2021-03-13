gameover = {}

function gameover:init()

  self.menu   = love.graphics.newImage( "texture/menu.png" )
  self.button = love.graphics.newImage( "texture/startbutton.png" )
  self.highscore = love.audio.newSource("music/highscore.wav", "static")

end

function gameover:enter(from,score)
  
  if score > tonumber(highscore) then
    love.filesystem.remove( "/highscore" )
    love.filesystem.write( "/highscore", tostring(score) )
    self.highscore:play()
    highscore = tostring(score)
  end
  
  self.from = from
  self.score = score
  self.alpha = {}
  self.alpha.val = 0
  Timer.tween(1, self.alpha, {val=1}, 'linear')
end

function gameover:draw()



  self.from:draw()
  
  
  cam:attach()
  
  love.graphics.setColor( 0, 0, 0, self.alpha.val )
  love.graphics.rectangle( "fill", 0, 0, 480, 854 )
  love.graphics.setColor( 1, 1, 1, 1 )
  
  love.graphics.draw(self.menu,SCREEN_WIDTH/2 - (self.menu:getWidth()/2),SCREEN_HEIGHT/2 - (self.menu:getHeight()/2))
  love.graphics.setFont(font2)
  love.graphics.print("Score : "..self.score,SCREEN_WIDTH/2- 160 ,SCREEN_HEIGHT/2 - 125)
  love.graphics.print("Best  : "..highscore,SCREEN_WIDTH/2- 160 ,SCREEN_HEIGHT/2 - 70)
  
  love.graphics.draw(self.button,SCREEN_WIDTH/2 - (self.button:getWidth()/2),SCREEN_HEIGHT/2 )
  
  
  cam:detach()
  
end


function gameover:update(dt)

  Timer.update(dt)

end


function gameover:mousepressed(Sx, Sy, button)

  local x, y =  cam:worldCoords(Sx, Sy)

  if button 
  and (x >= SCREEN_WIDTH/2 - (self.button:getWidth()/2)) 
  and (x <= SCREEN_WIDTH/2 - (self.button:getWidth()/2) + self.button:getWidth() ) 
  and (y >= SCREEN_HEIGHT/2) 
  and (y <= SCREEN_HEIGHT/2 + self.button:getHeight() ) 
  then
    Gamestate.switch(jeu)
  end

end
function gameover:keypressed(key)

end