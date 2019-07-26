# Global time keeper
scoreboard players add #ghosts_time ghosts_variables 1

# TEMPORARY
execute as @a[tag=acclimated] run tag add ghosts_registered
execute as @a[tag=ghosts_registered] run tag remove acclimated

# Initialize new players
execute as @a[tag=!ghosts_registered] run spreadplayers 0 0 0 10000 false @s
execute as @a[tag=!ghosts_registered] run tellraw @a[tag=ghosts_registered] [{"text":"Welcome ","color":"yellow"},{"selector":"@s"},{"text":" to the server!"}]
give @a[tag=!ghosts_registered] written_book{pages:["[\"\",{\"text\":\"Welcome to IllagerNet\",\"bold\":true,\"color\":\"gold\"},{\"text\":\"\\n\\u25aa There is a 72 hour respawn timeout\\n\\u25aa Respawn location is randomized\\n\\u25aa Respawn can be expedited with a resurrection rune\\n\\u25aa Good luck and have fun!\",\"color\":\"reset\"}]","[\"\",{\"text\":\"Resurrection Rune\",\"bold\":true},{\"text\":\"\\n\\n\",\"color\":\"reset\"},{\"text\":\"Base Layer\",\"underlined\":true},{\"text\":\"\\n\",\"color\":\"reset\"},{\"text\":\"\\u2b1b\",\"color\":\"aqua\"},{\"text\":\"\\u2b1b\",\"color\":\"dark_red\"},{\"text\":\"\\u2b1b\",\"color\":\"aqua\"},{\"text\":\" \\n\",\"color\":\"reset\"},{\"text\":\"\\u2b1b\",\"color\":\"dark_red\"},{\"text\":\"\\u2b1b\",\"color\":\"gold\"},{\"text\":\"\\u2b1b\",\"color\":\"dark_red\"},{\"text\":\"\\n\",\"color\":\"reset\"},{\"text\":\"\\u2b1b\",\"color\":\"aqua\"},{\"text\":\"\\u2b1b\",\"color\":\"dark_red\"},{\"text\":\"\\u2b1b\",\"color\":\"aqua\"},{\"text\":\"\\n\\n\",\"color\":\"reset\"},{\"text\":\"\\u2b1b\",\"color\":\"gold\"},{\"text\":\" Gold Block\\n\",\"color\":\"reset\"},{\"text\":\"\\u2b1b\",\"color\":\"aqua\"},{\"text\":\" Diamond Block\\n\",\"color\":\"reset\"},{\"text\":\"\\u2b1b\",\"color\":\"dark_red\"},{\"text\":\" Redstone Block\",\"color\":\"reset\"}]","[\"\",{\"text\":\"Resurrection Rune\",\"bold\":true},{\"text\":\"\\n\\n\",\"color\":\"reset\"},{\"text\":\"Top Layer\",\"underlined\":true},{\"text\":\"\\n\",\"color\":\"reset\"},{\"text\":\"\\u25a3\",\"color\":\"red\"},{\"text\":\"\\u25a2\",\"color\":\"reset\"},{\"text\":\"\\u25a3\",\"color\":\"red\"},{\"text\":\"\\n\\u25a2\\u25a2\\u25a2\\n\",\"color\":\"reset\"},{\"text\":\"\\u25a3\",\"color\":\"red\"},{\"text\":\"\\u25a2\",\"color\":\"reset\"},{\"text\":\"\\u25a3\",\"color\":\"red\"},{\"text\":\"\\n\\n\",\"color\":\"reset\"},{\"text\":\"\\u25a3\",\"color\":\"red\"},{\"text\":\" Redstone Torch\\n\\u25a2 Air\",\"color\":\"reset\"}]","[\"\",{\"text\":\"Resurrection Rune\",\"bold\":true},{\"text\":\"\\n\\nOnce the rune has been constructed by a living player, a ghost can fly into the center of the rune.\\n\\nThe ghost will be resurrected immediately, and the rune will be consumed.\",\"color\":\"reset\"}]"],title:"Welcome Guide",author:"",generation:3}
tag @a[tag=!ghosts_registered] add ghosts_registered

# Initialize ghosts
tag @a[scores={ghosts_dead=1..}] add ghosts_setup
scoreboard players reset @a[tag=ghosts_setup] ghosts_dead
scoreboard players operation @a[tag=ghosts_setup] ghosts_deathTime = #ghosts_time ghosts_variables
spawnpoint @a[tag=ghosts_setup] 0 64 0
tag @a[tag=ghosts_setup] add ghosts_wait
tag @a[tag=ghosts_wait] remove ghosts_setup

# Set ghosts to spectator mode
gamemode spectator @a[tag=ghosts_wait]

# Check for resurrection rune
execute as @a[tag=ghosts_wait] run execute at @s if block ~ ~-1 ~ minecraft:gold_block if block ~-1 ~-1 ~ minecraft:redstone_block if block ~1 ~-1 ~ minecraft:redstone_block if block ~ ~-1 ~-1 minecraft:redstone_block if block ~ ~-1 ~1 minecraft:redstone_block if block ~-1 ~-1 ~-1 minecraft:diamond_block if block ~1 ~-1 ~-1 minecraft:diamond_block if block ~-1 ~-1 ~1 minecraft:diamond_block if block ~1 ~-1 ~1 minecraft:diamond_block if block ~-1 ~ ~-1 minecraft:redstone_torch[lit=true] if block ~1 ~ ~-1 minecraft:redstone_torch[lit=true] if block ~-1 ~ ~1 minecraft:redstone_torch[lit=true] if block ~1 ~ ~1 minecraft:redstone_torch[lit=true] run tag @s add ghosts_resurrect
execute as @a[tag=ghosts_resurrect] run fill ~-1 ~-1 ~-1 ~1 ~-1 ~1 minecraft:cobblestone
execute as @a[tag=ghosts_resurrect] run fill ~-1 ~ ~-1 ~1 ~ ~1 minecraft:redstone_torch[lit=false] replace minecraft:redstone_torch[lit=true]
tag @a[tag=ghosts_resurrect] add ghosts_revive
tag @a[tag=ghosts_revive] remove ghosts_resurrect

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
execute as @a[tag=ghosts_revive] run spreadplayer 0 0 0 10000 false @s
gamemode survival @a[tag=ghosts_revive]
execute as @a[tag=ghosts_revive] run tellraw @a [{"selector":"@s"},{"text":" respawned"}]
tag @a[tag=ghosts_revive] remove ghosts_revive
