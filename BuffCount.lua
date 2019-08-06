local BC_PlayerName = nil;
local BC_DEFAULT = {"FRAMELOCK" = false, "VISIBLE" = true, };
local BuffCap = 32;
local ValidDebuff = { "DEATH_WISH" = true, };

function BuffCount_OnLoad()
   this:RegisterEvent("UNIT_AURA");
   this:RegisterEvent("VARIABLES_LOADED");

   SLASH_BC1 = '/bc';
   local function handler(msg, editbox)
      if msg == 'hide' then
	 BuffCount_Visibility();
      elseif msg == 'lock' then
	 BuffCount_ChangeLock();
      else
	 DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc hide |cffffffff- toggle frame visible", 0.35, 1, 0.35);
	 DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc lock |cffffffff- toggle frame lock", 0.35, 1, 0.35);
      end;
   end;
   SlashCmdList["BC"] = handler;
end


function BuffCount_Init()
   BC_PlayerName = UnitName("player").." of "..GetCVar("realmName");
   BuffCountText:SetTextColor(0.0,1.0,0.0,1.0)
   BuffCountWindow:SetAlpha(0.8)
   
   DEFAULT_CHAT_FRAME:AddMessage('Buff Counter v1.3, by Plask. Use /bc for available commands', 0.35, 1, 0.35);
   
   if (BUFFCOUNT_CONFIG == nil) then
      BUFFCOUNT_CONFIG = {};
   end;
   
   if (BUFFCOUNT_CONFIG[BC_PlayerName] == nil) then
      BUFFCOUNT_CONFIG[BC_PlayerName] = BC_DEFAULT;
   end;

   -- Fallback value
   if (BUFFCOUNT_CONFIG[BC_PlayerName].FRAMELOCK == nil) then
      BUFFCOUNT_CONFIG[BC_PlayerName].FRAMELOCK = false;
   end;
   -- Fallback value
   if (BUFFCOUNT_CONFIG[BC_PlayerName].VISIBLE == nil) then
      BUFFCOUNT_CONFIG[BC_PlayerName].VISIBLE = true;
   end;

   UpdateLock();
   UpdateVisibility();
   -- TODO: Save position in config?
end


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
   UpdateLock();
end

function UpdateVisibility()
   if BUFFCOUNT_CONFIG[BC_PlayerName].VISIBLE then
      BuffCountWindow:Show();
   else
      BuffCountWindow:Hide();
   end;
end;

function UpdateLock()
   BuffCountWindow:EnableMouse(not BUFFCOUNT_CONFIG[BC_PlayerName].FRAMELOCK);
end;

function BuffCount_OnEvent()
   if (event == "UNIT_AURA") then
      local unit = select(1, ...)
      if unit == "player" then 
	 Count_Buffs();
      end;
   elseif (event == "VARIABLES_LOADED") then
      BuffCount_Init();
   end;
end


function Count_Buffs()
   local count = 0;
   local i = 0;

   -- count buffs
   while UnitBuff("player", i) do
      i = i + 1;
   end;
   count = i;

   -- count debuffs that takes buff slot, such as Death Wish
   i = 0;
   local debuff = UnitDebuff("player", i);
   while debuff do
      local debuff_name = select(1, ...)
      if ValidDebuff[debuff_name] then
	 count = count + 1;
      end;
      i = i + 1;
      debuff = UnitDebuff("player", i);
   end;
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
