require "AudioEngine"
require "Script/Config/CommonDefine"
require "Script/Scene/GameScene"
local visibleSize = CCDirector:sharedDirector():getVisibleSize()


local function createEyeSprite()
  local eyeSprite = CCSprite:create("imgs/eye.png")

  local arrayOfActions = CCArray:create()
  local scale1 = CCScaleTo:create(0.1,1,0.2)
  local scale2 = CCScaleTo:create(0.1,1,1)
  local delay = CCDelayTime:create(0.8)

  arrayOfActions:addObject(scale1)
  arrayOfActions:addObject(scale2)
  arrayOfActions:addObject(delay)

  local sequence = CCSequence:create(arrayOfActions)
  local repeatFunc = CCRepeatForever:create(sequence)
  eyeSprite:runAction(repeatFunc)

  return eyeSprite
end

local function createBackLayer()

  local backLayer = CCLayer:create()

  local splashSprite = CCSprite:create("imgs/splash_bg.png")
  splashSprite:setPosition(visibleSize.width/2,visibleSize.height/2)
  backLayer:addChild(splashSprite)

  local testLabel = createPressScreenInfo()
  backLayer:addChild(testLabel)


  local touchBeginPoint = nil
  local function onTouchBegan(x,y)
    CCDirector:sharedDirector():replaceScene(CreateGameScene())
    touchBeginPoint = {x = x,y = y}
    return true
  end
  local function onTouch(event, x, y)
    if event == "began" then
      return onTouchBegan(x,y)
    end
    return true
  end
  backLayer:registerScriptTouchHandler(onTouch)
  backLayer:setTouchEnabled(true)
  return backLayer
end

function createPressScreenInfo()
  local start = CCSprite:create("imgs/images/menu_bg_total_04.png")
  local arrayOfActions = CCArray:create()
  local scale1 = CCScaleTo:create(1.5,1.3)
  local scale2 = CCScaleTo:create(1.5,1)
  arrayOfActions:addObject(scale1)
  arrayOfActions:addObject(scale2)

  --  local testLabel = CCLabelTTF:create("Press Screen", "Arial", 30)
  --  local arrayOfActions = CCArray:create()
  --  local scale1 = CCScaleTo:create(1.5, 1.2)
  --  local scale2 = CCScaleTo:create(1.5, 1)
  --
  --  arrayOfActions:addObject(scale1)
  --  arrayOfActions:addObject(scale2)

  local sequence = CCSequence:create(arrayOfActions)

  local repeatFunc = CCRepeatForever:create(sequence)
  start:runAction(repeatFunc)
  start:setPosition(ccp(visibleSize.width / 2, 150))


  return start
end

local function loading()
  local sprite  = CCSprite:create("imgs/images/loading_02.png")
  --  local animation = CCAnimation:create()
  --  local number,name
  --  for i = 2, 9 do
  --    number = "0"..i
  --    print(number)
  --    name = "imgs/images/loading_"..number..".png"
  --    print(name)
  --  end
  --    animation:addSpriteFrameWithFileName(name)
  ----    animation:setDelayPerUnit(1)
  ----    animation:setLoops(-1)
  --    local action = CCAnimate:create(animation)
  --    sprite:runAction(CCRepeatForever:create(action))
  --
  --
  local number, name
  local animation = CCAnimation:create()
  for i = 2, 9 do
    if i <= 9 then
      number = "0"..i
    else
      number = i
    end
    name = "imgs/images/loading_"..number..".png"
    
    animation:addSpriteFrameWithFileName(name)
  end
   animation:setDelayPerUnit(0.2)
   animation:setLoops(-1)
--  animation:setRestoreOriginalFrame(true)
  local action = CCAnimate:create(animation)
  sprite:runAction(action)
  return sprite

end
function CreateSplashScene()

  local scene = CCScene:create()
  scene:addChild(createBackLayer())

  local bgMusicPath = CCFileUtils:sharedFileUtils():fullPathForFilename("Sound/login.wav")
  AudioEngine.playMusic(bgMusicPath, true)

  local eyeSprite1 = createEyeSprite()
  eyeSprite1:setPosition(CCPoint(GBackGroundMiddlePoint.x - 50, GBackGroundMiddlePoint.y + 180))
  cclog("GBackGroundMiddlePoint  "..GBackGroundMiddlePoint.x.."  "..GBackGroundMiddlePoint.y)

  local eyeSprite2 = createEyeSprite()
  eyeSprite2:setPosition(CCPoint(GBackGroundMiddlePoint.x + 50, GBackGroundMiddlePoint.y + 180))
  local lodings = loading()
  lodings:setPosition(ccp(visibleSize.width/2, visibleSize.height/2))
  scene:addChild(lodings)
  scene:addChild(eyeSprite1)
  scene:addChild(eyeSprite2)

  return scene
end