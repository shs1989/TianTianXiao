GIconNormalType = 1
GIconCryType = 2
GIconMatchType = 3
GIconSelectType = 4

function loadGameIcon()
  CCSpriteFrameCache:sharedSpriteFrameCache():addSpriteFramesWithFile("imgs/GameIcon.plist")
end

function getGameIconSprite(type,index)
  local cache = CCSpriteFrameCache:sharedSpriteFrameCache()
  local iconFrame = cache:spriteFrameByName("icon"..type..index..".png")
  
  if iconFrame == nil then
    print("icon"..type..index..".png")
    print("iconFrame nil")
    return
  end
  local iconSprite = CCSprite:createWithSpriteFrame(iconFrame)
  return iconSprite
end


function createBlinkIconSprite()
  local animFrames = CCArray:create()

  for i=1, GGameIconCount do
    local iconFrame = CCSpriteFrameCache:sharedSpriteFrameCache():spriteFrameByName("icon4"..i..".png")
    animFrames:addObject(iconFrame)
  end

  local iconSprite = getGameIconSprite(4, 1)

    local animation = CCAnimation:createWithSpriteFrames(animFrames, 0.1)
  local animate = CCAnimate:create(animation);

    iconSprite:runAction(CCRepeatForever:create(animate))

  return iconSprite
end