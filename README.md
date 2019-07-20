# Minecraft Ghosts — Version 1.0
A multiplayer datapack to add a respawn timeout, and force dead players into spectator mode

* Data Pack Format 1
* Designed for Minecraft 1.14 Multiplayer

# Installation
1. Place pack in `<world_dir>/datapacks`
2. As operator, execute `/reload`
3. As operator, execute `/function ghosts:init`

# Features
* On death, a player is assigned a scoreboard tag that will force the player into spectator mode, making them "ghosts"
* After a hardcoded countdown (7 days — 12,096,000 ticks) the player is untagged and respawns at worldspawn.
* The countdown timer is handled by a hidden scoreboard entity, allowing the timer to continue ticking while players are offline. The timer will stop during server restarts or downtime. 
* "Ghosts" are shown a conveniently formatted countdown at the bottom of their screen.

# Operator Manipulation
* A ghost may be respawned immediately by tagging them with `reviveGhost`
* The countdown timer is handled globally. The countdown timer for *all* players can be manually adjusted with the command `/scoreboard players add|remove #time time <ticks>`, where 1 tick is equal to 1/20th of a second.

# Uninstallation
1. As operator, execute `/function ghosts:eject`
2. Delete the pack in `<world_dir>/datapacks`
3. As operator, execute `/reload`
