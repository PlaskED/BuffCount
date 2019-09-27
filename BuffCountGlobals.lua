BC_Globals = {}
local BC = BC_Globals

BC.BuffCap = 32;
BC.ValidDebuff = {
		"DeathWish"
	};
BC.BC_FONT = {
	   arial = "Fonts\\ARIALN.TTF",
	   friz = "Fonts\\FRIZQT__.TTF",
	   morpheus = "Fonts\\MORPHEUS.TTF",
	   skurri = "Fonts\\SKURRI.TTF",
	};
BC.BC_DEFAULT = {
	   FRAMELOCK = false,
	   VISIBLE = true,
	   BG_ALPHA = 0.25,
	   BG_COLOR = {r=1, g=1, b=1},
	   BG_SIZE = {x=55, y=40},
	   FONT_ALPHA = 1.0,
	   FONT_COLOR = {r=1, g=1, b=0.2},
	   FONT_SIZE = 30,
	   FONT_FAMILY = BC.BC_FONT["arial"],
	};