local BC_PlayerName = nil;
local BC_DEFAULT = {
   ["FRAMELOCK"] = false,
   ["VISIBLE"] = true,
   ["BG_ALPHA"] = 0.25,
   ["BG_COLOR"]= {["r"]=1, ["g"]=1, ["b"]=1},
   ["BG_SIZE"] = {["x"]=55, ["y"]=40},
   ["FONT_ALPHA"] = 1.0,
   ["FONT_COLOR"] = {["r"]=1, ["g"]=1, ["b"]=1},
   ["FONT_SIZE"] = 30,
   ["FONT_FAMILY"] = "FONTS\\ARIALN.TTF",
};
local BC_FONT = {
   ["arial"] = "Fonts\\ARIALN.TTF",
   ["friz"] = "Fonts\\FRIZQT__.TTF",
   ["morpheus"] = "Fonts\\MORPHEUS.TTF",
   ["skurri"] = "Fonts\\SKURRI.TTF",
}
local BuffCap = 32;
local HiddenBuffs = 0;
local ValidDebuff = { ["DeathWish"] = true, };

function BuffCount_OnLoad()
	BuffCountWindow:RegisterUnitEvent("UNIT_AURA","player");
	BuffCountWindow:RegisterEvent("ADDON_LOADED");
	SLASH_BC1 = '/bc';
	local function handler(msg, editbox)
	local cmd, arg, arg1, arg2, arg3 = strsplit(" ",msg)
	if cmd == 'hide' then
		BuffCount_Visibility();
    elseif cmd == 'lock' then
		BuffCount_ChangeLock();
    elseif cmd == 'reset' then
		BUFFCOUNT_CONFIG[BC_PlayerName] = BC_DEFAULT;
		BuffCount_UpdateConfiguration();
    elseif cmd == 'bg' then
		if arg == 'alpha' then
			if arg1 ~= "" then
			   BUFFCOUNT_CONFIG[BC_PlayerName].BG_ALPHA = arg1;
			   BuffCountWindow:SetAlpha(arg1);
			else
			   DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc bg alpha x |cffffffff- Set alpha of window to 'x'. 'x' should be in range 0-1", 0.35, 1, 0.35);
			end;
		elseif arg == 'color' then
			if arg1 ~= "" and arg2 ~= "" and arg3 ~= "" then
			   BUFFCOUNT_CONFIG[BC_PlayerName].BG_COLOR = {["r"]=arg1, ["g"]=arg2, ["b"]=arg3};
			   BuffCountWindow:SetBackdropColor(arg1, arg2, arg3);
			else
			   DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc bg color r g b |cffffffff- Set color of window to rgb. 'r', 'g' and 'b' should be in range 0-1", 0.35, 1, 0.35);
			end;
		elseif arg == 'size' then
			if arg1 ~= "" and arg2 ~= "" then
			   arg1, arg2 = tonumber(arg1), tonumber(arg2);
			   BUFFCOUNT_CONFIG[BC_PlayerName].BG_SIZE = {["x"]=arg1, ["y"]=arg2};
			   BuffCountWindow:SetSize(tonumber(arg1), tonumber(arg2));
			else
				 DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc bg size x y |cffffffff- Set size of window to width 'x' and height 'y'. 'x' and 'y' should be positive integers", 0.35, 1, 0.35);
			end;
		end;
	elseif cmd == 'font' then
		if arg == 'alpha' then
			if arg1 ~= "" then
			   BUFFCOUNT_CONFIG[BC_PlayerName].FONT_ALPHA = arg1;
			   BuffCountText:SetAlpha(arg1);
			else
			   DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc font alpha x |cffffffff- Set alpha of font to 'x'. 'x' should be in range 0-1", 0.35, 1, 0.35);
			end;
		elseif arg == 'color' then
			if arg1 ~= "" and arg2 ~= "" and arg3 ~= "" then
			   BUFFCOUNT_CONFIG[BC_PlayerName].FONT_COLOR = {["r"]=arg1, ["g"]=arg2, ["b"]=arg3};
			   BuffCountText:SetTextColor(arg1, arg2, arg3);
			else
			   DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc font color r g b |cffffffff- Set color of font to rgb. 'r', 'g' and 'b' should be in range 0-1", 0.35, 1, 0.35);
			end;
		elseif arg == 'size' then
			if arg1 ~= "" then
			   arg1 = tonumber(arg1);
			   BUFFCOUNT_CONFIG[BC_PlayerName].FONT_SIZE = arg1;
			   BuffCountText:SetTextHeight(arg1);
			else
			   DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc font size x |cffffffff- Set size of font to 'x'. 'x' should be a positive integer", 0.35, 1, 0.35);
			end;
		elseif arg == 'family' then
			arg1 = string.lower(arg1);
			if arg1 ~= "" and BC_FONT.arg1 then
			   BUFFCOUNT_CONFIG[BC_PlayerName].FONT_FAMILY = arg1;
			   BuffCountText:SetFont(BC_FONT.arg1, BUFFCOUNT_CONFIG.FONT_SIZE);
			else
			   DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc font family (arial|friz|morpheus|skurri) |cffffffff- Sets the family used", 0.35, 1, 0.35);
			end;
		end;
		DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc font alpha x |cffffffff- Set alpha of window to 'x'. 'x' should be in range 0-1", 0.35, 1, 0.35);
		DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc font color r g b |cffffffff- Set color of window to rgb. 'r', 'g' and 'b' should be in range 0-1", 0.35, 1, 0.35);
		DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc font size x |cffffffff- Set size of window to 'x'. 'x' should be a positive integer", 0.35, 1, 0.35);
		else
		 DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc hide |cffffffff- toggle frame visible", 0.35, 1, 0.35);
		 DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc lock |cffffffff- toggle frame lock", 0.35, 1, 0.35);
		 DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc bg (alpha|color|size) [args] |cffffffff- Configure window", 0.35, 1, 0.35);
		 DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc font (alpha|color|size|family) [args] |cffffffff- Configure font", 0.35, 1, 0.35);
		 DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc reset |cffffffff- Reset to default settings", 0.35, 1, 0.35);
		end;
   end;
   
   SlashCmdList["BC"] = handler;
end


function BuffCount_Init()
	Count_Buffs();
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
      BUFFCOUNT_CONFIG[BC_PlayerName] = BC_DEFAULT;
   end;

   BuffCount_UpdateConfiguration();
end

function BuffCount_UpdateConfiguration()
   BuffCountText:SetAlpha(BUFFCOUNT_CONFIG[BC_PlayerName].FONT_ALPHA);
   local fontcolor = BUFFCOUNT_CONFIG[BC_PlayerName].FONT_COLOR;
   local r, g, b = fontcolor.r, fontcolor.g, fontcolor.b;
   BuffCountText:SetTextColor(r, g, b);
   local x = BUFFCOUNT_CONFIG[BC_PlayerName].FONT_SIZE;
   BuffCountText:SetTextHeight(x);
   local font = BC_FONT.BUFFCOUNT_CONFIG[BC_PlayerName].FONT_FAMILY;
   BuffCountText:SetFont(font, x);
   
   --  BuffCountText:SetSize(x, y);
   BuffCountWindow:SetAlpha(BUFFCOUNT_CONFIG[BC_PlayerName].BG_ALPHA);
   local bgcolor = BUFFCOUNT_CONFIG[BC_PlayerName].BG_COLOR;
   r, g, b = bgcolor.r, bgcolor.b, bgcolor.g; 
   BuffCountWindow:SetBackdropColor(r, g, b);
   local bgsize = BUFFCOUNT_CONFIG[BC_PlayerName].BG_SIZE;
   local x, y = bgsize.x, bgsize.y;
   BuffCountWindow:SetSize(x, y);
   UpdateVisibility();
	  
   -- TODO: Save position in config?
end;


function BuffCount_Visibility()
   if BuffCountWindow:IsShown() then
      BUFFCOUNT_CONFIG[BC_PlayerName].VISIBLE = false;
      BuffCountWindow:Hide();
      DEFAULT_CHAT_FRAME:AddMessage("BuffCount: Window is now hidden.", 0.35, 1, 0.35);
   else
      BuffCountWindow:Show();
      BUFFCOUNT_CONFIG[BC_PlayerName].VISIBLE = true;
      DEFAULT_CHAT_FRAME:AddMessage("BuffCount: Window is now shown.", 0.35, 1, 0.35);
   end;
end

function BuffCount_ChangeLock()
   if (BUFFCOUNT_CONFIG[BC_PlayerName].FRAMELOCK) then
      BUFFCOUNT_CONFIG[BC_PlayerName].FRAMELOCK = false;
      DEFAULT_CHAT_FRAME:AddMessage("BuffCount: Window is now unlocked.", 0.35, 1, 0.35);
   else
      BUFFCOUNT_CONFIG[BC_PlayerName].FRAMELOCK = true;
      DEFAULT_CHAT_FRAME:AddMessage("BuffCount: Window is now locked.", 0.35, 1, 0.35);
   end;
end

function UpdateVisibility()
   if BUFFCOUNT_CONFIG[BC_PlayerName].VISIBLE then
      BuffCountWindow:Show();
   else
      BuffCountWindow:Hide();
   end;
end;

function BuffCount_MoveWindow(self)
	if not BUFFCOUNT_CONFIG[BC_PlayerName].FRAMELOCK then
		self:StartMoving();
	end;
end;

function BuffCount_OnEvent(event, ...)
   if (event == "UNIT_AURA") then
		Count_Buffs();
   elseif (event == "ADDON_LOADED") then
		local addonName = ...;
		if (addonName == "BuffCount") then
			BuffCount_Init();
		end;
   end;
end


function Count_Buffs()
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
      if ValidDebuff.debuff_name then
		count = count + 1;
      end;
      i = i + 1;
      debuff = UnitDebuff("player", i);
   end;
   count = count + HiddenBuffs;
   Update_Window(count);
end;

function Update_Window(count)
   slots = BuffCap - count;
   BuffCountText:SetText(slots);
   if (slots > 5) then
      BuffCountText:SetTextColor(1.0,1.0,0.2,1.0)
   else
      BuffCountText:SetTextColor(1.0,0.2,0.2,1.0)
   end;
end;
