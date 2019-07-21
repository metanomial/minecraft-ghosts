# Scoreboard Objectives
scoreboard objectives add ghosts_variables dummy
scoreboard objectives add ghosts_dead deathCount
scoreboard objectives add ghosts_deathTime dummy
scoreboard objectives add ghosts_remaining dummy
scoreboard objectives add ghosts_days dummy
scoreboard objectives add ghosts_hours dummy
scoreboard objectives add ghosts_minutes dummy
scoreboard objectives add ghosts_seconds dummy

# Variables
scoreboard players set #ghosts_time ghosts_variables 0
scoreboard players set #ghosts_timeout ghosts_variables 0
scoreboard players set #ghosts_dayTicks ghosts_variables 1728000
scoreboard players set #ghosts_hourTicks ghosts_variables 72000
scoreboard players set #ghosts_minuteTicks ghosts_variables 1200
scoreboard players set #ghosts_secondTicks ghosts_variables 20
