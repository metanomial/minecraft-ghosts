# Scoreboard Objectives
scoreboard objectives remove ghosts_variables
scoreboard objectives remove ghosts_dead
scoreboard objectives remove ghosts_deathTime
scoreboard objectives remove ghosts_remaining
scoreboard objectives remove ghosts_days
scoreboard objectives remove ghosts_hours
scoreboard objectives remove ghosts_minutes
scoreboard objectives remove ghosts_seconds

# Remove spawn marker
kill @e[type=minecraft:armor_stand,tag=ghosts_spawnmarker]
