Buff Count v1.0
Author: Plask

version 1.2
--------------------------------------
 - Fixed so locking/unlocking frame is saved properly betwen sessions. Frame will now remember if it was locked or not when logging.

version 1.1
--------------------------------------
 - Added class detect which determines preset buffcap (But not spec, fury/prot warriors use inbuilt /bc fury and /bc prot for that)
 - Now counts downwards from buffcap instead of upwards
 - Counter will go red when 4 buffslots is left.
 - Added /bc hide (/bc now shows syntax instead)
 - Added /bc prot, /bc fury. Used to set buffcap value to correct number for warriors.
 - Lock/unlock button removed and replaced by command /bc lock.
 - Frame will now save position properly betwen sessions.
 - Frame lock will be saved 

Note: Death Wish isn't tracked by Buff Count, but is actually a buff.


version 1.0 (First Implementation)
--------------------------------------
 - Movable + Lockable Window.
 - Keeps track of how many buffs you have and shows it in the window.
 - Color codes the buffnumber depending on amount of buffs. (Will turn red after 25+ buffs)
 - /bc to hide or show window.
 - Saves your settings betwen sessions.