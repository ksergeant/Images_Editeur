io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art

--love.graphics.setDefaultFilter("nearest")

function love.load()
  
  love.graphics.setBackgroundColor(0.6,0.6,1)

  FunctionButton = require("button")
  FunctionEvent = require("event")
  
  myButtonZoomPlus = FunctionButton:Create("ZoomPlus", 10, 0, 0.64, 0.64, "ZoomPlus1.png", FunctionEvent.zoomPlus)
  myButtonZoomMoins = FunctionButton:Create("ZoomMoins", 60, 0, 0.64, 0.64, "ZoomMoins1.png", FunctionEvent.zoomMoins)
  myButtonDeplacement = FunctionButton:Create("Deplacement", 105, 0, 0.64, 0.64, "Deplacement.png", FunctionEvent.Deplacement)

  text = ""
  imgOrigine = love.graphics.newImage("croix.png")
  selecteur = {}
  selecteur.x = 1120
  selecteur.y = 50
  selecteur.id = 1
  selecteur.action = 1
  selecteur.motif = "------->"
  selecteur.minPosY = 50
  selecteur.maxPosY = 750
  selecteur.imageView = {}
  selecteur.imageView.x = 20
  selecteur.imageView.y = 20
  selecteur.imageView.r = 0
  selecteur.imageView.sx = 1
  selecteur.imageView.sy = 1
  selecteur.imageView.ox = 0
  selecteur.imageView.oy = 0
  selecteur.imageView.file = {}
  selecteur.imageView.width = 0
  selecteur.imageView.height = 0

  dir = "ImagesACheck"

end

function love.update(dt)

  love.timer.sleep(0.05)
  
  files = love.filesystem.getDirectoryItems(dir)
  listeImage = {}
  listeImage.file = {}
  for k, file in ipairs(files) do

    if (file ==".DS_Store")then
      -- détection d'un fichier mac incompatible avec la création d'une image
    else
   
    table.insert(listeImage.file, file)
    end

  end

  nombreFichier = #listeImage.file

  if listeImage.file ~=nil then

    selecteur.imageView.file = love.graphics.newImage(dir.."/"..tostring(listeImage.file[selecteur.action]))

    selecteur.imageView.width = selecteur.imageView.file:getWidth()*selecteur.imageView.sx
    selecteur.imageView.height = selecteur.imageView.file:getHeight()*selecteur.imageView.sy

    selecteur.imageView.ox = selecteur.imageView.width / 2
    selecteur.imageView.oy = selecteur.imageView.height / 2

    selecteur.imageView.x = 1105 / 2
    selecteur.imageView.y = 800 / 2
    
  end

  local x, y = love.mouse.getPosition()

  myButtonZoomPlus:Update()
  myButtonZoomMoins:Update()
  myButtonDeplacement:Update()

end

function love.draw()

  
  r,g,b = love.graphics.getColor()
  love.graphics.setColor(0,0,0) -- Couleur Noir
  -- Ligne du milieu
  love.graphics.line(1100, 0, 1100, 800)

  love.graphics.setColor(0.6,0.6,0.6) -- Couleur Grise
  love.graphics.rectangle("fill",0,0,1440,40)

  love.graphics.setColor(r,g,b)

  myButtonZoomPlus:Draw()
  myButtonZoomMoins:Draw()
  myButtonDeplacement:Draw()
 
  love.graphics.setColor(0,0,0) -- Couleur Noir
  love.graphics.print("Liste des images: ", 1225, 12)

  --love.graphics.rectangle("line",1100,  40, 340, posListe+5)
  
  --love.graphics.setColor(1,1,1) -- Couleur Blanche

  love.graphics.setColor(0,0,0) -- Couleur Noir
  love.graphics.rectangle("fill",1101,  40, 340, 245)

  love.graphics.setColor(0.6,1,0) --Couleur Verte Slime
  if listeImage.file ~=nil then
    local posListe = 0

    for i = 1, #listeImage.file do
      love.graphics.print(listeImage.file[i], 1225, 50 + posListe)
      
      posListe = posListe + 30
    end 

    --love.graphics.rectangle("line",1100,  40, 340, posListe+5)
    selecteur.maxPosY = posListe + 20

    love.graphics.setColor(r,g,b)

    r,g,b = love.graphics.getColor()
    love.graphics.setColor(1,0,0) -- Couleur Rouge
    love.graphics.print(selecteur.motif, selecteur.x , selecteur.y)
    love.graphics.setColor(r,g,b)

    -- Affiche L'image selectionné
    love.graphics.draw(selecteur.imageView.file,
    selecteur.imageView.x, selecteur.imageView.y, selecteur.imageView.r,
    selecteur.imageView.sx, selecteur.imageView.sy, selecteur.imageView.ox, selecteur.imageView.oy)

    r,g,b = love.graphics.getColor()

    love.graphics.setColor(0.1,0.4,0.7)
  
    love.graphics.rectangle("fill",1101, 285, 340, 515)

    love.graphics.setColor(0,0,0) -- Couleur Noir
    love.graphics.print("Propriétés de l'image", 1225, 290)
    love.graphics.print("Position X: "..tostring(selecteur.imageView.x), 1105, 320)
    love.graphics.print("Position Y: "..tostring(selecteur.imageView.y), 1105, 350)
    love.graphics.print("Largeur: "..tostring(selecteur.imageView.width),1105, 380)
    love.graphics.print("Hauteur: "..tostring(selecteur.imageView.height),1105, 410)
    love.graphics.print("Rotation: "..tostring(selecteur.imageView.r), 1105, 440)
    love.graphics.print("Scale X: "..tostring(selecteur.imageView.sx), 1105, 470)
    love.graphics.print("Scale Y: "..tostring(selecteur.imageView.sy),1105, 500)
    love.graphics.print("Origine X: "..tostring(selecteur.imageView.ox),1105, 530)
    love.graphics.print("Origine Y: "..tostring(selecteur.imageView.oy),1105, 560)

    love.graphics.setColor(r,g,b)
    
    r,g,b = love.graphics.getColor()
    love.graphics.setColor(1,0,0) -- Couleur Rouge
    love.graphics.circle("fill", selecteur.imageView.x, selecteur.imageView.y, 2)
    love.graphics.setColor(r,g,b)

    r,g,b = love.graphics.getColor()
    love.graphics.setColor(0,0,0) -- Couleur Noir
    
    -- première line horizontale
    love.graphics.line(selecteur.imageView.x - selecteur.imageView.ox, 
      selecteur.imageView.y - selecteur.imageView.oy, 
      selecteur.imageView.x - selecteur.imageView.ox + selecteur.imageView.width,
      selecteur.imageView.y - selecteur.imageView.oy
    )

    -- première line verticale
    love.graphics.line(selecteur.imageView.x - selecteur.imageView.ox, 
      selecteur.imageView.y - selecteur.imageView.oy, 
      selecteur.imageView.x - selecteur.imageView.ox,
      selecteur.imageView.y - selecteur.imageView.oy + selecteur.imageView.height
   )

    love.graphics.line(selecteur.imageView.x - selecteur.imageView.ox + selecteur.imageView.width, 
      selecteur.imageView.y - selecteur.imageView.oy, 
      selecteur.imageView.x - selecteur.imageView.ox + selecteur.imageView.width, 
      selecteur.imageView.y - selecteur.imageView.oy + selecteur.imageView.height
    )

    love.graphics.line(selecteur.imageView.x - selecteur.imageView.ox, 
      selecteur.imageView.y - selecteur.imageView.oy + selecteur.imageView.height, 
      selecteur.imageView.x - selecteur.imageView.ox + selecteur.imageView.width, 
      selecteur.imageView.y - selecteur.imageView.oy + selecteur.imageView.height
    )
  
    love.graphics.setColor(r,g,b)

    -- Croix qui montre l'origine
    love.graphics.draw(imgOrigine, selecteur.imageView.x, selecteur.imageView.y, 0,1,1,8,8)

    r,g,b = love.graphics.getColor()
    love.graphics.setColor(0,0,0) -- Couleur Noir

    -- Première case
    love.graphics.rectangle("line", 1250, 317, 49, 20)
    love.graphics.rectangle("line", 1250, 347, 49, 20)
    love.graphics.rectangle("line", 1250, 377, 49, 20)
    love.graphics.rectangle("line", 1250, 407, 49, 20)
    love.graphics.rectangle("line", 1250, 437, 49, 20)
    love.graphics.rectangle("line", 1250, 467, 49, 20)
    love.graphics.rectangle("line", 1250, 497, 49, 20)
    love.graphics.rectangle("line", 1250, 527, 49, 20)
    love.graphics.rectangle("line", 1250, 557, 49, 20)

    -- écriture dans la première case 
     love.graphics.printf(text, 1250, 320, 50)
     --love.graphics.printf(text, 1250, 350, 50)
     --love.graphics.printf(text, 1250, 380, 50)
     --love.graphics.printf(text, 1250, 410, 50)
     --love.graphics.printf(text, 1250, 440, 50)
     --love.graphics.printf(text, 1250, 470, 50)

    love.graphics.setColor(r,g,b)

  end

  --[[
  love.graphics.print("Selecteur Action:"..tostring(selecteur.action)
  .." "..tostring(selecteur.y)
  .." "..tostring(selecteur.maxPosY) ,0,0)
  ]]--

end

function love.keypressed(key)
  
  if key == "down" then
    if selecteur.action >= nombreFichier then

      selecteur.action = 1 
      selecteur.y = selecteur.minPosY
    else
      selecteur.action = selecteur.action + 1   
      selecteur.y = selecteur.y + 30
    end

  elseif key == "up" then
    if selecteur.action <= 1 then

      selecteur.action = nombreFichier
      selecteur.y = selecteur.maxPosY
    else
      selecteur.action = selecteur.action - 1
      selecteur.y = selecteur.y - 30
    end

  end

end

function love.textinput(t)

  text = text .. t

end