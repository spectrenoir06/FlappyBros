start = {}

function start:init()

  self.background  = love.graphics.newImage( "texture/startbackground.png" )
  self.sol         = love.graphics.newImage( "texture/sol.png" )
  self.rideau      = love.graphics.newImage( "texture/rideau.png" )
  self.title       = love.graphics.newImage( "texture/title.png" )
  self.startbutton = love.graphics.newImage( "texture/startbutton.png" )
  self.optionbutton= love.graphics.newImage( "texture/optionbutton.png" )
  
  self.rideauPos = {}
  self.rideauPos.Y = 0
  
  self.alpha = {}
  self.alpha.val = 255
  
  self.tilePos = {}
  self.tilePos.Y = 0 - self.title:getHeight()
  
  self.startMusic = love.audio.newSource("music/title.mp3", "stream")
  self.startMusic:play()
  self.startGameSound = love.audio.newSource("music/start.wav", "static")
  
  function animeStart()
    Timer.tween(4, self.rideauPos, {Y=-768}, 'linear',anime1)
  end
  function anime1()
    Timer.tween(2, self.alpha, {val=0}, 'linear')
    Timer.tween(1.5, self.tilePos, {Y=175}, 'bounce')
  end


  animeStart()
  self.animeFinish = false
  Timer.add(6,function() self.animeFinish = true end)
  
end

function start:enter()

  self.noTouch = true
    
end


function start:draw()

  cam:attach()
  
  love.graphics.draw(self.background,0,0)
  love.graphics.draw(self.title,0,self.tilePos.Y)
  
  love.graphics.draw(self.startbutton,64,500)
  love.graphics.draw(self.optionbutton,480-128-64,500)
  
  love.graphics.setColor( 0, 0, 0, self.alpha.val )
  love.graphics.rectangle( "fill", 0, 0, 480, 854 )
  love.graphics.setColor( 255, 255, 255, 255 )
  love.graphics.draw(self.sol,0,768)
  love.graphics.draw(self.rideau,0,self.rideauPos.Y)
  
  --love.graphics.print(love.graphics.getWidth().."/"..love.graphics.getHeight(),20,20)

  cam:detach()
  
end

function start:update(dt)
  Timer.update(dt)
end

function pressButtonStart(self,Sx,Sy)
  return 
      (Sx >= 64) 
  and (Sx <= 64 + self.startbutton:getWidth() ) 
  and (Sy >= 500 )
  and (Sy <= 500 + self.startbutton:getHeight() ) 
end

function pressButtonCredit(self,Sx,Sy)
  return 
      (Sx >= 480-128-64) 
  and (Sx <= 480-128-64 + self.optionbutton:getWidth() ) 
  and (Sy >= 500 )
  and (Sy <= 500 + self.optionbutton:getHeight() ) 
end


function start:mousepressed(Sx, Sy, button)

  local x, y =  cam:worldCoords(Sx, Sy)

  if button and self.animeFinish and self.noTouch and pressButtonStart(self,x,y) then
    self.startMusic:stop()
    self.startGameSound:play()
    self.noTouch = false
    Timer.add(1,function() Gamestate.switch(jeu) end)
  elseif button and self.animeFinish and self.noTouch and pressButtonCredit(self,x,y) then
    Gamestate.switch(credit)
  end
end

function start:keypressed(key)

end