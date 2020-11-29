local button = {}


function button:Create(pNom, pX, pY, pScalX, pScalY, pImageIdle, pFunction)
  
  local buttonTempo = {}
  buttonTempo.nom = pNom
  buttonTempo.x = pX
  buttonTempo.y = pY
  buttonTempo.Function = pFunction
  buttonTempo.pressed = false
  buttonTempo.focus = false
  buttonTempo.scaleX = pScalX
  buttonTempo.scaleY = pScalY
  buttonTempo.imageIdle = love.graphics.newImage(pImageIdle)
  buttonTempo.width = buttonTempo.imageIdle:getWidth() * buttonTempo.scaleX
  buttonTempo.height = buttonTempo.imageIdle:getHeight() * buttonTempo.scaleY


  function buttonTempo:Draw()
    
    love.graphics.setColor(r,g,b,0.6) -- Applique un voile blanc sur le bouton
    love.graphics.draw(self.imageIdle, self.x, self.y, 0, self.scaleX, self.scaleY)

    local r,g,b = love.graphics.getColor() 

    if (self.focus == true) then 
    
     love.graphics.draw(self.imageIdle, self.x, self.y, 0, self.scaleX, self.scaleY)
    
    end

  end

  function buttonTempo:Update()
    
    local x = love.mouse.getX()
    local y = love.mouse.getY()

    if (x >= self.x) and 
       (x <= self.x + self.width) and 
       (y >= self.y) and 
       (y <= self.y + self.height) then

        self.focus = true
        
    else
        self.focus = false
    end
    
  end

  return buttonTempo
  
end

return button