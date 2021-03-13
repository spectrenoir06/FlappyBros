credit = {}
  

function credit:init()
  
    self.avatar = love.graphics.newImage("texture/avatar.png")
  
    self.pos = {}
    self.pos.X , self.pos.Y = 0-self.avatar:getWidth(),0-self.avatar:getHeight()
  
    self.p = love.graphics.newParticleSystem( love.graphics.newImage("/texture/flame.png"), 10000 )
    self.p:setEmissionRate(1000)
    self.p:setSpeed(300, 400)
    self.p:setSizes(0.5, 0.5,0.1,0.5,0.01)
    self.p:setColors(255, 255, 0, 128, 255, 125, 32, 255,192,92,32,255,240,64,32,255)
    self.p:setPosition(self.pos.X+self.avatar:getWidth()/2,self.pos.Y+self.avatar:getHeight()/2)
    self.p:setEmitterLifetime(-1)
    self.p:setParticleLifetime(0.5,2)
    self.p:setDirection(270)
    self.p:setSpread(360)
    self.p:setTangentialAcceleration(0,0)
    self.p:setRadialAcceleration(0,0)
    self.p:stop()
  
end


function credit:enter(from,score)

  
  self.pos.X , self.pos.Y = 0-self.avatar:getWidth(),0-self.avatar:getHeight()
  Timer.tween(5, self.pos, {X=SCREEN_WIDTH/2-self.avatar:getWidth()/2}, 'out-back')
  Timer.tween(5, self.pos, {Y=SCREEN_HEIGHT/2-self.avatar:getHeight()/2}, 'bounce', function() self.p:stop() Timer.add(2,function() self.fini = true end) end)
  self.p:start()
  self.fini = false
  
end


function credit:draw()
  cam:attach()
  self.p:setPosition(self.pos.X+self.avatar:getWidth()/2,self.pos.Y+self.avatar:getHeight()/2)
  love.graphics.draw(self.p, 0, 0)
  love.graphics.draw( self.avatar, self.pos.X , self.pos.Y  )
  love.graphics.setFont(font2)
  love.graphics.setColor( 200/255, 0, 0, 1 )
  love.graphics.print("Spectrenoir",self.pos.X-90,self.pos.Y + 150)
  love.graphics.setFont(font)
  love.graphics.setColor(1,1,1,1)
  
  cam:detach()
end


function credit:update(dt)

  Timer.update(dt)
  self.p:update(dt)
  if self.fini then
    Gamestate.switch(start)
  end
end


function credit:mousepressed(Sx, Sy, button)

end


function credit:keypressed(key)

end