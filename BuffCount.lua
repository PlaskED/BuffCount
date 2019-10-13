local BC = BC_Globals;
local BC_PlayerName = nil;
local HiddenBuffs = 0;
local ActiveEnchants = 0;

function BuffCount_OnLoad()
	BuffCountWindow:RegisterUnitEvent("UNIT_AURA","player");
	BuffCountWindow:RegisterEvent("ADDON_LOADED");
	BuffCountWindow:RegisterEvent("PLAYER_EQUIPMENT_CHANGED");
	SLASH_BC1 = '/bc';
	
	local function handler(msg, editbox)
		local cmd, arg, arg1, arg2, arg3 = strsplit(" ",msg)
		if cmd == 'hide' then
			BuffCount_Visibility();
		elseif cmd == 'lock' then
			BuffCount_ChangeLock();
		elseif cmd == 'reset' then
			BUFFCOUNT_CONFIG[BC_PlayerName] = BC["BC_DEFAULT"];
			BuffCount_UpdateConfiguration();
		---------Background Start
		elseif cmd == 'bg' then
			if arg == 'alpha' then
				if string.len(arg1)>0 then
				   BUFFCOUNT_CONFIG[BC_PlayerName]["BG_ALPHA"] = arg1;
				   BuffCountWindow:SetAlpha(arg1);
				else
				   DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc bg alpha x |cffffffff- Set alpha of window to 'x'. 'x' should be in range 0-1", 0.35, 1, 0.35);
				end;
			elseif arg == 'color' then
				if string.len(arg1)>0 and string.len(arg2)>0 and string.len(arg3)>0 then
				   BUFFCOUNT_CONFIG[BC_PlayerName]["BG_COLOR"] = {["r"]=arg1, ["g"]=arg2, ["b"]=arg3};
				   BuffCountWindow:SetBackdropColor(arg1, arg2, arg3);
				else
				   DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc bg color r g b |cffffffff- Set color of window to rgb. 'r', 'g' and 'b' should be in range 0-1", 0.35, 1, 0.35);
				end;
			elseif arg == 'size' then
				if string.len(arg1)>0 and string.len(arg2)>0 then
				   arg1, arg2 = tonumber(arg1), tonumber(arg2);
				   BUFFCOUNT_CONFIG[BC_PlayerName]["BG_SIZE"] = {["x"]=arg1, ["y"]=arg2};
				   BuffCountWindow:SetSize(tonumber(arg1), tonumber(arg2));
				else
					 DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc bg size x y |cffffffff- Set size of window to width 'x' and height 'y'. 'x' and 'y' should be positive integers", 0.35, 1, 0.35);
				end;
			end;
		---------Background End
		----------- Font Start
		elseif cmd == 'font' then
			if arg == 'alpha' then
				if string.len(arg1)>0 then
				   BUFFCOUNT_CONFIG[BC_PlayerName]["FONT_ALPHA"] = arg1;
				   BuffCountText:SetAlpha(arg1);
				else
				   DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc font alpha x |cffffffff- Set alpha of font to 'x'. 'x' should be in range 0-1", 0.35, 1, 0.35);
				end;
			elseif arg == 'color' then
				if string.len(arg1)>0 and string.len(arg2)>0 and string.len(arg3)>0 then
				   BUFFCOUNT_CONFIG[BC_PlayerName]["FONT_COLOR"] = {["r"]=arg1, ["g"]=arg2, ["b"]=arg3};
				   BuffCountText:SetTextColor(arg1, arg2, arg3);
				else
				   DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc font color r g b |cffffffff- Set color of font to rgb. 'r', 'g' and 'b' should be in range 0-1", 0.35, 1, 0.35);
				end;
			elseif arg == 'size' then
				if string.len(arg1)>0 then
				   arg1 = tonumber(arg1);
				   BUFFCOUNT_CONFIG[BC_PlayerName]["FONT_SIZE"] = arg1;
				   BuffCountText:SetTextHeight(arg1);
				else
				   DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc font size x |cffffffff- Set size of font to 'x'. 'x' should be a positive integer", 0.35, 1, 0.35);
				end;
			elseif arg == 'family' and arg1 and string.len(arg1)>0 then
				arg1 = string.lower(arg1);
				if BC["BC_FONT"][arg1] then
				   BUFFCOUNT_CONFIG[BC_PlayerName]["FONT_FAMILY"] = BC["BC_FONT"][arg1];
				   BuffCountText:SetFont(BC["BC_FONT"][arg1], BUFFCOUNT_CONFIG[BC_PlayerName]["FONT_SIZE"]);
				else
				   DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc font family (arial|friz|morpheus|skurri) |cffffffff- Sets the family used", 0.35, 1, 0.35);
				end;
			else
				DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc font alpha x |cffffffff- Set alpha of window to 'x'. 'x' should be in range 0-1", 0.35, 1, 0.35);
				DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc font color r g b |cffffffff- Set color of window to rgb. 'r', 'g' and 'b' should be in range 0-1", 0.35, 1, 0.35);
				DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc font size x |cffffffff- Set size of window to 'x'. 'x' should be a positive integer", 0.35, 1, 0.35);
				DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc font family (arial|friz|morpheus|skurri) |cffffffff- Sets the family used", 0.35, 1, 0.35);
			end;
		----------- Font End
		else
		----------- Invalid command
			DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc hide |cffffffff- toggle frame visible", 0.35, 1, 0.35);
			DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc lock |cffffffff- toggle frame lock", 0.35, 1, 0.35);
			DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc bg (alpha|color|size) [args] |cffffffff- Configure window", 0.35, 1, 0.35);
			DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc font (alpha|color|size|family) [args] |cffffffff- Configure font", 0.35, 1, 0.35);
			DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc reset |cffffffff- Reset to default settings", 0.35, 1, 0.35);

	   end;
	end;
   SlashCmdList["BC"] = handler;
end;


function BuffCount_Init()
	local name,_ = UnitName("player");
	local realm = GetRealmName();
    BC_PlayerName = name.." of "..realm;
    local _,class = UnitClass("player");
	
   -- Warrior stances counts as buffs
   if class == "WARRIOR" then
		HiddenBuffs = 1;
   end;
   
   DEFAULT_CHAT_FRAME:AddMessage('Buff Counter v1.3, by Plask. Use /bc for available commands', 0.35, 1, 0.35);
   
   if (BUFFCOUNT_CONFIG == nil) then
      BUFFCOUNT_CONFIG = {};
   end;
   
   if (BUFFCOUNT_CONFIG[BC_PlayerName] == nil) then
      BUFFCOUNT_CONFIG[BC_PlayerName] = BC["BC_DEFAULT"];
   end;

   BuffCount_UpdateConfiguration();
   CountEnchants();
   CountBuffs();
end

function BuffCount_UpdateConfiguration()
   BuffCountText:SetAlpha(BUFFCOUNT_CONFIG[BC_PlayerName]["FONT_ALPHA"]);
   local fontcolor = BUFFCOUNT_CONFIG[BC_PlayerName]["FONT_COLOR"];
   local r, g, b = fontcolor["r"], fontcolor["g"], fontcolor["b"];
   BuffCountText:SetTextColor(r, g, b);
   local x = BUFFCOUNT_CONFIG[BC_PlayerName]["FONT_SIZE"];
   BuffCountText:SetTextHeight(x);
   local font = BUFFCOUNT_CONFIG[BC_PlayerName]["FONT_FAMILY"];
   BuffCountText:SetFont(font, x);
   
   --  BuffCountText:SetSize(x, y);
   BuffCountWindow:SetAlpha(BUFFCOUNT_CONFIG[BC_PlayerName]["BG_ALPHA"]);
   local bgcolor = BUFFCOUNT_CONFIG[BC_PlayerName]["BG_COLOR"];
   r, g, b = bgcolor["r"], bgcolor["b"], bgcolor["g"]; 
   BuffCountWindow:SetBackdropColor(r, g, b);
   local bgsize = BUFFCOUNT_CONFIG[BC_PlayerName]["BG_SIZE"];
   local x, y = bgsize["x"], bgsize["y"];
   BuffCountWindow:SetSize(x, y);
   UpdateVisibility();
	  
   -- TODO: Save position in config?
end;


function BuffCount_Visibility()
   if BuffCountWindow:IsShown() then
      BUFFCOUNT_CONFIG[BC_PlayerName]["VISIBLE"] = false;
      BuffCountWindow:Hide();
      DEFAULT_CHAT_FRAME:AddMessage("BuffCount: Window is now hidden.", 0.35, 1, 0.35);
   else
      BuffCountWindow:Show();
      BUFFCOUNT_CONFIG[BC_PlayerName]["VISIBLE"] = true;
      DEFAULT_CHAT_FRAME:AddMessage("BuffCount: Window is now shown.", 0.35, 1, 0.35);
   end;
end

function BuffCount_ChangeLock()
   if (BUFFCOUNT_CONFIG[BC_PlayerName]["FRAMELOCK"]) then
      BUFFCOUNT_CONFIG[BC_PlayerName]["FRAMELOCK"] = false;
      DEFAULT_CHAT_FRAME:AddMessage("BuffCount: Window is now unlocked.", 0.35, 1, 0.35);
   else
      BUFFCOUNT_CONFIG[BC_PlayerName]["FRAMELOCK"] = true;
      DEFAULT_CHAT_FRAME:AddMessage("BuffCount: Window is now locked.", 0.35, 1, 0.35);
   end;
end

function UpdateVisibility()
   if BUFFCOUNT_CONFIG[BC_PlayerName]["VISIBLE"] then
      BuffCountWindow:Show();
   else
      BuffCountWindow:Hide();
   end;
end;

function BuffCount_MoveWindow(self)
	if not BUFFCOUNT_CONFIG[BC_PlayerName]["FRAMELOCK"] then
		self:StartMoving();
	end;
end;

function BuffCount_OnEvent(event, ...)
   if (event == "UNIT_AURA") then
		CountBuffs();
   elseif (event == "PLAYER_EQUIPMENT_CHANGED") then
		slotId,_ = ...;
		if BC.BC_ENCHANT[slotId] then
			CountEnchants();
		end;
   elseif (event == "ADDON_LOADED") then
		local addonName = ...;
		if (addonName == "BuffCount") then
			BuffCount_Init();
		end;
   end;
end

function CountEnchants()
   local numEnchants = 0;
   print("CountEnchants");
   for _,v in pairs(BC.BC_ENCHANT) do
		local slot = GetInventorySlotInfo(v);
		local link = GetInventoryItemLink("player", slot);
		print("link: "..link);
		if link then
			local itemId, enchantId, gem1, gem2, gem3, gem4 = link:match("item:(%d+):(%d+):(%d+):(%d+):(%d+):(%d+)");
			print(itemId);
			print(enchantId);
			print(gem1);
			if enchantId then
				DEFAULT_CHAT_FRAME:AddMessage("Found enchant on slot: "..i, 1, 0.75, 0.5);
				numEnchants = numEnchants + 1;
			 end;
		end;
	end;
   DEFAULT_CHAT_FRAME:AddMessage("BC enchants: "..numEnchants, 1, 0.75, 0.5);
   ActiveEnchants = numEnchants;
end

function CountBuffs()
   local count = 0;
   local i = 1;

   -- count buffs
   while UnitBuff("player", i) do
      i = i + 1;
   end;
   count = i - 1;

   -- count debuffs that takes buff slot, such as Death Wish
   i = 1;
   local debuff = UnitDebuff("player", i);
   while debuff do
      local debuff_name = select(1, debuff);
      --if BC["ValidDebuff"][debuff_name] then
	  if debuff_name == "DeathWish" then
		count = count + 1;
      end;
      i = i + 1;
      debuff = UnitDebuff("player", i);
   end;
   count = count + HiddenBuffs;
   Update_Window(count);
end;

function Update_Window(count)
   slots = BC["BuffCap"] - count;
   BuffCountText:SetText(slots);
   if (slots > 5) then
	  local fontcolor = BUFFCOUNT_CONFIG[BC_PlayerName]["FONT_COLOR"];
	  local r, g, b = fontcolor["r"], fontcolor["g"], fontcolor["b"];
      BuffCountText:SetTextColor(r, g, b);
   else
      BuffCountText:SetTextColor(1.0,0.2,0.2,1.0);
   end;
end;
