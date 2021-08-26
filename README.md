# [NMRiH] Null Grab Crash Fix
Fixes `server.dll + 0x2ff6a1` crashes on Windows. Don't try to run this on Linux.

You'll see this crash happen when a zombie grabs a player and gets killed unnaturally (via "Kill" input or similar)
An example of this is nmo_lighthouse_v2 when a player gets grabbed as they're barricading the town doors.

This will also let the player walk again after the fact.
