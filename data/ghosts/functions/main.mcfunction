# Global time
scoreboard players add #time time 1

# Initialize Ghosts
tag @a[scores={dead=1..}] add initGhost
scoreboard players reset @a[tag=initGhost] dead
scoreboard players operation @a[tag=initGhost] deathTime = #time time
spawnpoint @a[tag=initGhost] -69 64 -144
tag @a[tag=initGhost] add ghost
tag @a[tag=ghost] remove initGhost

# Set ghosts to spectator mode
gamemode spectator @a[tag=ghost]

# Calculate elapsed time
scoreboard players operation @a[tag=ghost] elapsed = #time time
execute as @a[tag=ghost] run scoreboard players operation @s elapsed -= @s deathTime

# Calculate remaining time
execute as @a[tag=ghost] run scoreboard players operation @s remaining = @s deathTime
scoreboard players add @a[tag=ghost] remaining 12096000
execute as @a[tag=ghost] run scoreboard players operation @s remaining -= @s elapsed

# Calculate remaining time units
execute as @a[tag=ghost] run scoreboard players operation @s daysLeft = @s remaining
execute as @a[tag=ghost] run scoreboard players operation @s daysLeft /= #daysDivisor constants
execute as @a[tag=ghost] run scoreboard players operation @s hoursLeft = @s remaining
execute as @a[tag=ghost] run scoreboard players operation @s hoursLeft %= #daysDivisor constants
execute as @a[tag=ghost] run scoreboard players operation @s hoursLeft /= #hoursDivisor constants
execute as @a[tag=ghost] run scoreboard players operation @s minutesLeft = @s remaining
execute as @a[tag=ghost] run scoreboard players operation @s minutesLeft %= #daysDivisor constants
execute as @a[tag=ghost] run scoreboard players operation @s minutesLeft %= #hoursDivisor constants
execute as @a[tag=ghost] run scoreboard players operation @s minutesLeft /= #minutesDivisor constants
execute as @a[tag=ghost] run scoreboard players operation @s secondsLeft = @s remaining
execute as @a[tag=ghost] run scoreboard players operation @s secondsLeft %= #daysDivisor constants
execute as @a[tag=ghost] run scoreboard players operation @s secondsLeft %= #hoursDivisor constants
execute as @a[tag=ghost] run scoreboard players operation @s secondsLeft %= #minutesDivisor constants
execute as @a[tag=ghost] run scoreboard players operation @s secondsLeft /= #secondsDivisor constants

# Display time units left
execute as @a[tag=ghost,scores={daysLeft=1..}] run title @s actionbar [{"score":{"objective":"daysLeft","name":"@s"}},{"text":" da. "},{"score":{"objective":"hoursLeft","name":"@s"}},{"text":" hr. until respawn."}]
execute as @a[tag=ghost,scores={daysLeft=0,hoursLeft=1..}] run title @s actionbar [{"score":{"objective":"hoursLeft","name":"@s"}},{"text":" hr. "},{"score":{"objective":"minutesLeft","name":"@s"}},{"text":" min. until respawn."}]
execute as @a[tag=ghost,scores={daysLeft=0,hoursLeft=0,minutesLeft=1..}] run title @s actionbar [{"score":{"objective":"minutesLeft","name":"@s"}},{"text":" min. "},{"score":{"objective":"secondsLeft","name":"@s"}},{"text":" sec. until respawn."}]
execute as @a[tag=ghost,scores={daysLeft=0,hoursLeft=0,minutesLeft=0}] run title @s actionbar [{"score":{"objective":"secondsLeft","name":"@s"}},{"text":" sec. until respawn."}]

# After a week, revive ghosts
# 20 ticks * 3600 seconds * 24 hours * 7 days = 12096000
tag @a[tag=ghost,scores={elapsed=12096000..}] add reviveGhost
tag @a[tag=reviveGhost] remove ghost

# Revival process
execute as @a[tag=reviveGhost] run spreadplayers -68.5 -143.5 5 5 false @s
gamemode survival @a[tag=reviveGhost]
scoreboard players reset @a[tag=reviveGhost] deathTime
scoreboard players reset @a[tag=reviveGhost] elapsed
execute as @a[tag=reviveGhost] run tellraw @a [{"selector":"@s"},{"text":" respawned"}]
tag @a[tag=reviveGhost] remove reviveGhost
