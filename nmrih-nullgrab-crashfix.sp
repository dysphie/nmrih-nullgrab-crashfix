#include <sdkhooks>

public Plugin myinfo = {
	name        = "[NMRiH] Null Grab Crash Fix",
	author      = "Dysphie",
	description = "Fix server crash related to zombie grabs",
	version     = "0.1.0",
	url         = ""
};

public void OnPluginStart()
{
	if (FindConVar("sv_workshop_autoupdate"))
		SetFailState("This plugin is only needed in NMRiH 1.11.4");
}

// Clear grabber when a zombie dies
public void OnEntityDestroyed(int entity)
{
	if (HasEntProp(entity, Prop_Send, "_headSplit"))
	{
		// CNMRiH_BaseZombie::m_hGrabEnt
		int grabEnt = GetEntDataEnt2(entity, 0xE8C);
		if (0 < grabEnt <= MaxClients && IsClientInGame(grabEnt))
		{
			SetEntProp(grabEnt, Prop_Send, "m_bGrabbed", 0);
			SetEntDataEnt2(grabEnt, 0x1350, -1);	// Clear CNMRiH_Player::m_pGrabbedBy

			// Restore movement
			int curFlags = GetEntProp(grabEnt, Prop_Send, "m_fFlags");
			SetEntProp(grabEnt, Prop_Send, "m_fFlags", curFlags & ~128);
		}
	}
}
