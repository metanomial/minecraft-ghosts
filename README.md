# Minecraft Ghosts — Version 1.1
A multiplayer datapack to add a respawn timeout, and put waiting players into spectator mode

* Data Pack Format 1
* Designed for Minecraft 1.14 Multiplayer

# Installation
1. Place the entire pack into `<world_dir>/datapacks`. If Github is being used by command line, simply clone this repository into that path.
2. As operator, execute the following commands:
```
/reload
/function ghosts:init
/scoreboard players set #ghosts_timeout ghosts_variables <ticks>
```
Where `<ticks>` is the number of [Game Ticks](https://minecraft.gamepedia.com/Tick#Game_tick) before respawn. Use the following table to calculate units of time:

| Unit of Time | Conversion           |
| ------------ | -------------------- |
| Day          | N days = N × 1728000 |
| Hour         | N hours = N × 72000  |
| Minute       | N minutes = N × 1200 |
| Second       | N seconds = N × 20   |

3. In-game, have a player stand at the ghost respawn point. Tag them with `ghosts_spawnpoint`. This spawnpoint should be set in a forced-loaded chunk. If placed outside of the [Spawn Chunks](https://minecraft.gamepedia.com/Spawn_chunk), the chunk can be manually force-loaded with the operator command `/forceload ~ ~` executed at the location of the ghost spawnpoint.

# Features
* On death, a player is assigned a scoreboard tag that will force the player into spectator mode, making them "ghosts"
* After an arbitrarily wait time, the player is untagged and respawns.
* The timeout counter is handled by a fake scoreboard entity, allowing the counter to continue ticking while players are offline. The timer will stop during server restarts or downtime. 
* "Ghosts" are shown a conveniently formatted countdown display at the bottom of their screen.

# Operator Manipulation
* A ghost may be respawned immediately by tagging them with `ghosts_revive`
* The wait time can always be adjusted by re-running `/scoreboard players set #ghosts_timeout ghosts_variables <ticks>`
* The countdown timer is handled globally. The countdown timer for *all* players can be manually adjusted with the command `/scoreboard players add|remove #ghosts_time variables <ticks>`, where 1 tick is equal to 1/20th of a second.

# Uninstallation
1. As operator, execute `/function ghosts:eject`
2. Delete the pack in `<world_dir>/datapacks`
3. As operator, execute `/reload`
