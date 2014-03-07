Perso = {}
Perso.__index = Perso

require "class.Sprite"

function new_Perso()
  
  local a = {}
  setmetatable(a, Perso)
  a.sprite  = new_Sprite("texture/mario_tanuki.png",48,56)
  a.sprite:addAnimation({0,1,2})
  a.sprite:addAnimation({4,5})
  a.sprite:setAnim(2)
  
  a.posX    = 10
  a.posY    = 642-a.sprite.LY
  a.speedY  = 0
  a.G       = (48*4) * 9.75 / 2-- 48 pxl = 24cm -- *4 = 1m
  a.upForce = -(48*4)* 1.4
  a.isDead  = false
  
  return a
  
end

function Perso:update(dt)
  self.sprite:update(dt)
  self.speedY = self.speedY + self.G * dt       -- gravity effect

  --print(self.speedY)
  self.posY = self.posY + self.speedY * dt        -- application of speedY
  self.posY = math.min( 642 - self.sprite.LY, self.posY)
end

function Perso:draw()
  
  if self.wait then
    
  elseif not self.isDead then 
    self.sprite:draw(self.posX,self.posY)                              -- display perso on screen
  else
    self.sprite:drawframe(self.posX,self.posY,3)
  end
end

function Perso:up()                                    -- if touche 
 
  if not self.isDead and self.posY>=0 then                       -- if perso go down
      self.speedY = self.upForce                   
  end

end

function Perso:kill()

  self.isDead = true

end

function Perso:start()

  self.wait = false
  self.posY = self.posY - 1
  self.speedY = -750
  self.sprite:setAnim(1)

end