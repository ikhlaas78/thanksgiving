
// Project: thanksgiving 
// Created: 2020-10-02
// Author: Michael Tang
/*

*/
// show all errors
SetErrorMode(2)

// set window properties
SetWindowTitle( "thanksgiving" )
SetWindowSize( 1024, 768, 0 )
SetWindowAllowResize( 1 ) // allow the user to resize the window

// set display properties
SetVirtualResolution( 1024, 768 ) // doesn't have to match the window
SetOrientationAllowed( 1, 1, 1, 1 ) // allow both portrait and landscape on mobile devices
SetSyncRate( 30, 0 ) // 30fps instead of 60 to save battery
SetScissor( 0,0,0,0 ) // use the maximum available screen space, no black borders
UseNewDefaultFonts( 1 ) // since version 2.0.22 we can use nicer default fonts

// Images
LoadImage(1, "turkey.png")
LoadImage(2, "farmer.png")

// Create Turkey
CreateSprite(1, 1)
SetSpriteScale(1, 0.25, 0.25)
SetSpriteFlip(1, 0, 0)
turkeyX = 0
turkeyY = 0 
turkeyDirX = 1
turkeyDirY = 1
turkeySPD = 5

// Create Farmer
CreateSprite(2,2)
SetSpriteScale(2, 0.5, 0.5)
farmerX = GetVirtualWidth()/2 - GetSpriteWidth(2)/2
farmerY = GetVirtualHeight()/2 - GetSpriteHeight(2)/2
farmerSPD = 5
SetSpritePosition(2, farmerX, farmerY)
farmerStartX = farmerX
farmerStartY = farmerY
do
   // move turkey
   turkeyX = turkeyX + turkeyDirX * turkeySPD
   turkeyY = turkeyY + turkeyDirY * turkeySPD
   // set boundries for turkey
	if turkeyX > GetVirtualWidth() - GetSpriteWidth(1)
		turkeyDirX = -1
		SetSpriteFlip(1,0,0)
	endif
	if turkeyX < 0
		turkeyDirX = 1
		SetSpriteFlip(1,1,0)
	endif
	if turkeyY > GetVirtualHeight() - GetSpriteHeight(1)
		turkeyDirY = -1
	endif
	if turkeyY < 0
		turkeyDirY = 1
	endif
	
	// Move farmer with 'WASD'
	if GetRawKeyState(68) = 1 //'d' key
		farmerX = farmerX + farmerSPD
		SetSpriteFlip(2,0,0)
	else
		if GetRawKeyState(65) = 1 //'a' key
			farmerX = farmerX - farmerSPD
			SetSpriteFlip(2,1,0)
		endif
	endif
	if GetRawKeyState(83) = 1 // 's' key (default)
		farmerY = farmerY + farmerSPD
	else
		if GetRawKeyState(87) = 1 // 'w' key
			farmerY = farmerY - farmerSPD
		endif
	endif
	
   // Set boundries for farmer
   if farmerX > GetVirtualWidth() - GetSpriteWidth(2)
	   farmerX = GetVirtualWidth() - GetSpriteWidth(2)
   endif
   if farmerX < 0
	   farmerX = 0
   endif
   if farmerY > GetVirtualHeight() - GetSpriteHeight(2)
	   farmerY = GetVirtualHeight() - GetSpriteHeight(2)
   endif
   if farmerY < 0
	   farmerY = 0
   endif
   
   //Turkey Farmer Collision
   if GetSpriteCollision(1, 2)
	   
   SetSpritePosition(1, turkeyX, turkeyY)
   SetSpritePosition(2, farmerX, farmerY)
    Sync()
loop