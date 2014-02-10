-- avoid memory leak
collectgarbage("setpause", 100) 
collectgarbage("setstepmul", 5000)
require("Script/Scene/SplashScene")

-- run
CCDirector:sharedDirector():runWithScene(CreateSplashScene())