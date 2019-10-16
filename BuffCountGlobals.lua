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
		[7]="LegsSlot",
		[8]="FeetSlot",
		[16]="MainHandSlot",
		[17]="SecondaryHandSlot",
		[18]="RangedSlot",
		[5]="ChestSlot",
		[9]="WristSlot",
		[10]="HandsSlot",
	};
--	[15]="BackSlot",
BC.BC_VALID_ENCHANT = {
		[1]={2543, 2544, 2545, 1506, 1507, 1508, 1509, 1510, 1503, 1505, 1483, 1504,
			2591, 2585, 2586, 2589, 2583, 2588, 2590, 2584, 2587, 2681},
		[3]={2721, 2715, 2717, 2716, 2488, 2485, 2483, 2484, 2486, 2487},
		[7]={2543, 2544, 2545, 1506, 1507, 1508, 1509, 1510, 1503, 1505, 1483, 1504,
			2591, 2585, 2586, 2589, 2583, 2588, 2590, 2584, 2587, 2681, 2525, 664},
		[8]={464, 2503, 1843},
		[16]={36},
		[17]={36},
		[18]={2525, 664},
		[5]={2503, 1843},
		[9]={2503, 1843},
		[10]={2503, 1843}
	};
--	arcanum of rapidity/focus/protection (2543, 2544, 2545)
--	lesser arcanum 8str/8sta/8agi/8int/8spi/100hp/20FR/150MP/125Armor (1506, 1507, 1508, 1509, 1510, 1503, 1505, 1483, 1504)
--	ZG druid/rogue/hunter/warlock/warrior/mage/priest/paladin/shaman, savage guard (2591, 2585, 2586, 2589, 2583, 2588, 2590, 2584, 2587, 2681)
--	Power/Resilience/Might/Fortitude of the Scourge (2721, 2715, 2717, 2716)
--	Chromatic/Arcane/Flame/Frost/Nature/Shadow mantle of the dawn (2488, 2485, 2483, 2484, 2486, 2487)
--	mithril spurs (464)
--	fiery blaze (36)
--	bizznicks, sniper scope(2525, 664)
--  core armor kit, rugged leather armor kit(2503, 1843)
