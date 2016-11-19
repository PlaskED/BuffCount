local BC_PlayerName = nil;
local BC_default = {};
local BuffCap = nil;

function BuffCount_OnLoad()
	this:RegisterEvent("PLAYER_AURAS_CHANGED");
	this:RegisterEvent("VARIABLES_LOADED");

	SLASH_BC1 = '/bc';
	local function handler(msg, editbox)
		if msg == 'hide' then
			BuffCount_Command();
		elseif msg == 'lock' then
			BuffCount_ChangeLock();
		elseif msg == 'fury' then
			BuffCount_Fury();
		elseif msg == 'prot' then
			BuffCount_Prot();
		else
			DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc hide |cffffffff- toggle frame visible", 0.35, 1, 0.35);
			DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc lock |cffffffff- toggle frame lock", 0.35, 1, 0.35);
			DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc fury |cffffffff- use fury warrior buffcap", 0.35, 1, 0.35);
			DEFAULT_CHAT_FRAME:AddMessage("BuffCount Syntax: |cffffff00/bc prot |cffffffff- use prot warrior buffcap", 0.35, 1, 0.35);
		end
	end
	SlashCmdList["BC"] = handler; -- Also a valid assignment strategy

end


function BuffCount_Init()
    BC_PlayerName = UnitName("player").." of "..GetCVar("realmName");
	BC_PlayerClass, BC_EnglishClass = UnitClass("player");
	BuffCountText:SetTextColor(0.0,1.0,0.0,1.0)
	BuffCountWindow:SetAlpha(0.8)
	BuffCountWindow:Show();
	
	DEFAULT_CHAT_FRAME:AddMessage('Buff Counter v1.2, by Plask. Use /bc for syntax help. Class detected: ' .. BC_PlayerClass .. ' ', 0.35, 1, 0.35);
	
    if (BUFFCOUNT_CONFIG == nil) then
		BUFFCOUNT_CONFIG = {};
    end
	
	if (BUFFCOUNT_CONFIG[BC_PlayerName] == nil) then
		BUFFCOUNT_CONFIG[BC_PlayerName] = BC_default;
    end
	
	if (BUFFCOUNT_CONFIG[BC_PlayerName].FRAMELOCK == nil) then
		BUFFCOUNT_CONFIG[BC_PlayerName].FRAMELOCK = false;
        BuffCountWindow:EnableMouse(true);
	elseif (BUFFCOUNT_CONFIG[BC_PlayerName].FRAMELOCK == false) then
        BuffCountWindow:EnableMouse(true);
	elseif (BUFFCOUNT_CONFIG[BC_PlayerName].FRAMELOCK == true) then
        BuffCountWindow:EnableMouse(false);
	end
	
	if (BUFFCOUNT_CONFIG[BC_PlayerName].CLASS == nil) then
		BUFFCOUNT_CONFIG[BC_PlayerName].CLASS = BC_PlayerClass;
	elseif (BUFFCOUNT_CONFIG[BC_PlayerName].CLASS == 'Warrior') then
		BuffCap = 29;
	elseif (BUFFCOUNT_CONFIG[BC_PlayerName].CLASS == 'Rogue') then
		BuffCap = 29;
	else
		BuffCap = 30;
	end

end


function BuffCount_Command()
	if BuffCountWindow:IsShown() then
		BuffCountWindow:Hide();
		DEFAULT_CHAT_FRAME:AddMessage("BuffCount: Window is now hidden.", 0.35, 1, 0.35);
	else
		BuffCountWindow:Show();
		DEFAULT_CHAT_FRAME:AddMessage("BuffCount: Window is now shown.", 0.35, 1, 0.35);
	end
end

function BuffCount_ChangeLock()
	if (BUFFCOUNT_CONFIG[BC_PlayerName].FRAMELOCK == true) then
		BUFFCOUNT_CONFIG[BC_PlayerName].FRAMELOCK = false;
        BuffCountWindow:EnableMouse(true);
		DEFAULT_CHAT_FRAME:AddMessage("BuffCount: Window is now unlocked.", 0.35, 1, 0.35);
		
	else
		BUFFCOUNT_CONFIG[BC_PlayerName].FRAMELOCK = true;
		BuffCountWindow:EnableMouse(false);
		DEFAULT_CHAT_FRAME:AddMessage("BuffCount: Window is now locked.", 0.35, 1, 0.35);
	end
	
end

function BuffCount_Fury()
	if (BUFFCOUNT_CONFIG[BC_PlayerName].CLASS == 'Warrior') then
		BuffCap = 28;
		DEFAULT_CHAT_FRAME:AddMessage("BuffCount: Fury enabled, buffcap is now 28.", 0.35, 1, 0.35);
	else
		DEFAULT_CHAT_FRAME:AddMessage("BuffCount: Only warriors can use /bb fury.", 0.35, 1, 0.35);
	end
end

function BuffCount_Prot()
	if (BUFFCOUNT_CONFIG[BC_PlayerName].CLASS == 'Warrior') then
		BuffCap = 28;
		DEFAULT_CHAT_FRAME:AddMessage("BuffCount: Prot enabled, buffcap is now 29.", 0.35, 1, 0.35);
	else
		DEFAULT_CHAT_FRAME:AddMessage("BuffCount: Only warriors can use /bb prot.", 0.35, 1, 0.35);
	end
end

function BuffCount_OnEvent()
	if (event == "PLAYER_AURAS_CHANGED") then
		Count_Buffs();
	elseif (event == "VARIABLES_LOADED") then
		BuffCount_Init();
	end
end


function Count_Buffs()
	local i = 0;
	local slots = 0;
	while not (GetPlayerBuff(i, "HELPFUL") == -1) do
		i = i + 1;
	end
	slots = BuffCap - i;
	BuffCountText:SetText(slots);
	if (slots > 5) then
		BuffCountText:SetTextColor(1.0,1.0,0.2,1.0)
	else
		BuffCountText:SetTextColor(1.0,0.2,0.2,1.0)
	end
end