
> :warning: This fix is no longer needed as of NMRiH 1.11.5

# [NMRiH] Null Grab Crash Fix
Fixes a server crash in No More Room in Hell 1.11.4, seen as:

- `server.dll + 0x2ff6a1` on Windows
- `server_srv.so!CNMRiH_WeaponBase::DoShove() + 0x52f` on Linux

You'll see this crash occur when a zombie grabs a player and gets killed unnaturally (via `Kill` input or similar). An example of this would be nmo_lighthouse_v2 when a player gets grabbed as they're barricading the town doors.

The fix will also let the player walk again after the fact.
