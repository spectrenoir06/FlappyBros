local Map = {}
Map.__index = Map

function new_Map()

  local a = {}
  setmetatable(a, Map)
  
  a.pos = 0
  a.isDead = false
  a.wait = true

  a.background  = love.graphics.newImage( "texture/background.png" )
  a.ground      = love.graphics.newImage( "texture/ground.png" )
  a.pipe        = love.graphics.newImage( "texture/pipe.png" )
  
  return a
end

function Map:update(dt)

  if self.wait then
    self.pos = self.pos + dt * 192
  elseif not self.isDead then
    self.pos = self.pos + dt * 192
    self:pipesUpdate()
  end
end


function Map:groundPos()
  
  return (- self.pos) % 480 - 480
  
end

function Map:pipesInit()

  self.pipes = {
                  { x = self.pos +700,        y = math.random(-642+100,-160-100) ,pass = false  },
                  { x = self.pos +700+264,    y = math.random(-642+100,-160-100) ,pass = false  },
                  { x = self.pos +700+264*2,  y = math.random(-642+100,-160-100) ,pass = false  }
               } 
end

function Map:pipesUpdate()

  local lastX = self.pipes[#self.pipes].x
  if lastX < self.pos + SCREEN_WIDTH then
     table.insert( self.pipes, {x=lastX + 264, y = math.random(-642+100,-160-100)  , pass = false } )
  end
  
  if self.pipes[1].x + self.pipe:getWidth() < self.pos then
    table.remove(self.pipes,1)   
  end
  
end


function Map:draw()
  
  love.graphics.draw(self.background,0,0)
  
  if not self.wait then  
    local p1=self.pipes[1]
    local p2=self.pipes[2]
    local p3=self.pipes[3]
    love.graphics.draw(self.pipe,math.floor(p1.x-self.pos),p1.y)
    love.graphics.draw(self.pipe,math.floor(p2.x-self.pos),p2.y)
    love.graphics.draw(self.pipe,math.floor(p3.x-self.pos),p3.y)
  end
  
  love.graphics.draw(self.ground,self:groundPos(),642)

end

function Map:PointIsSafe(x,y)
  
  if y < 0 or y > 642 then 
    return false
  elseif 0 then -- x and y  then -- in pipe
    return false
  end
  
  return true

end

function Map:kill()
  
  self.isDead = true
  
end

function Map:start()
  self:pipesInit()
  self.wait = false
end