require "class.Perso"
require "class.Map"
camera = require "class.Camera"

Game = {}
Game.__index = Game

function new_Game()

    local a={}
    setmetatable(a, Game)
    
    a.score = 0
    
    a.perso = new_Perso()
    a.map = new_Map()
    a.wait = true
    
    a.aide = love.graphics.newImage( "texture/aide.png" )
    
    a.music = love.audio.newSource("music/game.mp3", "stream")
    a.deadSound = love.audio.newSource("music/dead.mp3", "stream")
    a.jump = love.audio.newSource("music/jump.wav", "static")
    a.coin = love.audio.newSource("music/coin.wav", "static")
    a.powerup = love.audio.newSource("music/powerup.wav", "static")
    
    a.music:play()
    
    return a
    
end

function Game:update(dt)
  
    if not self.wait then
      if not self.perso.isDead and self:collide() then
        
        
        print("score = "..self.score)
        
        self.perso:kill()
        self.map:kill()
        
        self.music:stop()
        
        self.deadSound:play()
        
        Timer.add(2.5,function() Gamestate.push(gameover,self.score) end) 
        
      elseif not self.map.pipes[1].pass and self.map.pos + self.perso.posX + (self.perso.sprite.LX / 2) > self.map.pipes[1].x + (self.map.pipe:getWidth()/2) then
        
        self.map.pipes[1].pass = true
        self.score = self.score + 1
        if self.score == (highscore +1) then
          self.powerup:play()
        else
          self.coin:play()
        end
        
      end
       Timer.update(dt)
    end
    
      self.perso:update(dt)
      self.map:update(dt)

end

function Game:draw()
  self.map:draw()
  self.perso:draw()
  if self.wait then
    love.graphics.draw(self.aide,0,0)
  end

  love.graphics.setFont(font)
  love.graphics.setColor( 0, 0, 0, 255 )
  love.graphics.print(self.score , 200 , 50)
  love.graphics.setColor( 255, 255, 255, 255 )
end


function Game:persoBetwenPipes()

  local bx  = self.map.pipes[1].x
  local blx = self.map.pipe:getWidth()
  
  local ax  = self.map.pos + self.perso.posX + 10
  local alx = self.perso.sprite.LX - 10

  return (( (ax + alx) >= bx) and ( (bx + blx) >= ax ))

end

function Game:collide()

  if self:persoBetwenPipes() then
  
    local pipeY1 = self.map.pipes[1].y + 642
    local pipeY2 = self.map.pipes[1].y + 642 + 160
    
    --print(self.perso.posY , pipeY1)
    
    if (self.perso.posY < pipeY1) or ((self.perso.posY + self.perso.sprite.LY) > pipeY2) then
      --print("kill pipe")
      return true 
    end
  else
    if ((self.perso.posY + self.perso.sprite.LY) >= 642) then
      print("kill sol")
      return true
    else
      return false   
    end
  end
  
end

function Game:up()
  self.perso:up()
end

function Game:start()
  
  self.jump:play()
  self.perso:start()
  self.map:start()
  self.wait = false
end

