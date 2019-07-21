# Global time keeper
scoreboard players add #ghosts_time ghosts_variables 1

# Initialize ghosts
tag @a[scores={ghosts_dead=1..}] add ghosts_setup
scoreboard players reset @a[tag=ghosts_setup] ghosts_dead
scoreboard players operation @a[tag=ghosts_setup] ghosts_deathTime = #ghosts_time ghosts_variables
tag @a[tag=ghosts_setup] add ghosts_wait
tag @a[tag=ghosts_wait] remove ghosts_setup

# Set ghosts to spectator mode
gamemode spectator @a[tag=ghosts_wait]

# Calculate remaining time
execute as @a[tag=ghosts_wait] run scoreboard players operation @s ghosts_remaining = @s ghosts_deathTime
execute as @a[tag=ghosts_wait] run scoreboard players operation @s ghosts_remaining += #ghosts_timeout ghosts_variables
execute as @a[tag=ghosts_wait] run scoreboard players operation @s ghosts_remaining -= #ghosts_time ghosts_variables

# Calculate remaining time units
execute as @a[tag=ghosts_wait] run scoreboard players operation @s ghosts_days = @s ghosts_remaining
execute as @a[tag=ghosts_wait] run scoreboard players operation @s ghosts_days /= #ghosts_dayTicks ghosts_variables
execute as @a[tag=ghosts_wait] run scoreboard players operation @s ghosts_hours = @s ghosts_remaining
execute as @a[tag=ghosts_wait] run scoreboard players operation @s ghosts_hours %= #ghosts_dayTicks ghosts_variables
execute as @a[tag=ghosts_wait] run scoreboard players operation @s ghosts_hours /= #ghosts_hourTicks ghosts_variables
execute as @a[tag=ghosts_wait] run scoreboard players operation @s ghosts_minutes = @s ghosts_remaining
execute as @a[tag=ghosts_wait] run scoreboard players operation @s ghosts_minutes %= #ghosts_dayTicks ghosts_variables
execute as @a[tag=ghosts_wait] run scoreboard players operation @s ghosts_minutes %= #ghosts_hourTicks ghosts_variables
execute as @a[tag=ghosts_wait] run scoreboard players operation @s ghosts_minutes /= #ghosts_minuteTicks ghosts_variables
execute as @a[tag=ghosts_wait] run scoreboard players operation @s ghosts_seconds = @s ghosts_remaining
execute as @a[tag=ghosts_wait] run scoreboard players operation @s ghosts_seconds %= #ghosts_dayTicks ghosts_variables
execute as @a[tag=ghosts_wait] run scoreboard players operation @s ghosts_seconds %= #ghosts_hourTicks ghosts_variables
execute as @a[tag=ghosts_wait] run scoreboard players operation @s ghosts_seconds %= #ghosts_minuteTicks ghosts_variables
execute as @a[tag=ghosts_wait] run scoreboard players operation @s ghosts_seconds /= #ghosts_secondTicks ghosts_variables

# Display time units left
execute as @a[tag=ghosts_wait,scores={ghosts_days=1..}] run title @s actionbar [{"score":{"objective":"ghosts_days","name":"@s"}},{"text":" da. "},{"score":{"objective":"ghosts_hours","name":"@s"}},{"text":" hr. until respawn."}]
execute as @a[tag=ghosts_wait,scores={ghosts_days=0,ghosts_hours=1..}] run title @s actionbar [{"score":{"objective":"ghosts_hours","name":"@s"}},{"text":" hr. "},{"score":{"objective":"ghosts_minutes","name":"@s"}},{"text":" min. until respawn."}]
execute as @a[tag=ghosts_wait,scores={ghosts_days=0,ghosts_hours=0,ghosts_minutes=1..}] run title @s actionbar [{"score":{"objective":"ghosts_minutes","name":"@s"}},{"text":" min. "},{"score":{"objective":"ghosts_seconds","name":"@s"}},{"text":" sec. until respawn."}]
execute as @a[tag=ghosts_wait,scores={ghosts_days=0,ghosts_hours=0,ghosts_minutes=0}] run title @s actionbar [{"score":{"objective":"ghosts_seconds","name":"@s"}},{"text":" sec. until respawn."}]

# Once remaining is zero
tag @a[tag=ghosts_wait,scores={ghosts_remaining=..0}] add ghosts_revive
tag @a[tag=ghosts_revive] remove ghosts_wait

# Revival process
execute as @a[tag=ghosts_revive] run teleport @s @e[type=minecraft:armor_stand,tag=ghosts_spawnmarker,limit=1]
gamemode survival @a[tag=ghosts_revive]
execute as @a[tag=ghosts_revive] run tellraw @a [{"selector":"@s"},{"text":" respawned"}]
tag @a[tag=ghosts_revive] remove ghosts_revive

# Set respawn point
execute as @a[tag=ghosts_spawnpoint] run kill @e[type=minecraft:armor_stand,tag=ghosts_spawnmarker]
execute as @a[tag=ghosts_spawnpoint] at @a[tag=ghosts_spawnpoint] anchored feet run summon minecraft:armor_stand ~ ~ ~ {"Marker":1,"Invisible":true,"Tags":["ghosts_spawnmarker"]}
tag @a[tag=ghosts_spawnpoint] remove ghosts_spawnpoint
