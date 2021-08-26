#include <sdkhooks>
#define DEBUG 0

public Plugin myinfo = {
    name        = "[NMRiH] Null Grab Crash Fix",
    author      = "Dysphie",
    description = "Fix server crash related to zombie grabs",
    version     = "0.2.1",
    url         = ""
};


int m_hGrabEnt = -1;
int m_pGrabbedBy = -1;

public void OnPluginStart()
{
	if (FindConVar("sv_workshop_autoupdate"))
		SetFailState("This plugin is only needed in NMRiH 1.11.4");

	GameData gd = new GameData("nullgrab-crashfix.games");
	m_hGrabEnt = gd.GetOffset("CNMRiH_BaseZombie::m_hGrabEnt");
	if (m_hGrabEnt == -1)
		SetFailState("Failed to get offset to CNMRiH_BaseZombie::m_hGrabEnt");

	m_pGrabbedBy = gd.GetOffset("CNMRiH_Player::m_pGrabbedBy");
	if (m_pGrabbedBy == -1)
		SetFailState("Failed to get offset to CNMRiH_Player::m_pGrabbedBy");

	delete gd;
}

// Clear grabber when a zombie dies
public void OnEntityDestroyed(int entity)
{
	if (IsValidEdict(entity) && HasEntProp(entity, Prop_Send, "_headSplit"))
	{
		// CNMRiH_BaseZombie::m_hGrabEnt
		int grabEnt = GetEntDataEnt2(entity, m_hGrabEnt);

#if DEBUG
		PrintToServer("Zombie deleted, m_hGrabEnt = %d", grabEnt);
#endif

		if (0 < grabEnt <= MaxClients && IsClientInGame(grabEnt))
		{

#if DEBUG
			PrintToServer("%N's m_pGrabbedBy = %d", grabEnt, GetEntDataEnt2(grabEnt, m_pGrabbedBy));
#endif
			
			SetEntProp(grabEnt, Prop_Send, "m_bGrabbed", 0);
			SetEntDataEnt2(grabEnt, m_pGrabbedBy, -1);	// Clear CNMRiH_Player::m_pGrabbedBy

			// Restore movement
			int curFlags = GetEntProp(grabEnt, Prop_Send, "m_fFlags");
			SetEntProp(grabEnt, Prop_Send, "m_fFlags", curFlags & ~128);
		}
	}
}
