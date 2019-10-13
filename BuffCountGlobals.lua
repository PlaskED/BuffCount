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

BC.BC_ENCHANT = {
		[1]="HeadSlot",
		[3]="ShoulderSlot",
		[15]="BackSlot",
		[5]="ChestSlot",
		[9]="WristSlot",
		[10]="HandsSlot",
		[7]="LegsSlot",
		[8]="FeetSlot",
		[16]="MainHandSlot",
		[17]="SecondaryHandSlot",
		[18]="RangedSlot"
	};
--1 = head
--3 = shoulder
--5 = chest
--7 = legs
--8 = feet
--9 = wrist
--10 = hands
--15 = back
--16 = main hand
--17 = off hand
--18 = ranged