# Domain Actions Handled by/in Godot
- Playing Sounds 
- Animating the *Reticles* 
- Retrieving Raycast Hits
- Processing Textures
	- Shaders
	- Rendering

# Pure Domain Use Cases
- **Users'** can *Run* and *Jump*, and move around with mouse motion.
- **Users'** screen shows a *Reticle*
	- Expands and contracts (potentially in random intervals depending on the choice of *Weapon*).
	- Changes Colors depending on the *Player* behind it.
	- Shape determined by type of *Weapon*
- **Users'** can consume a *Signaling API* to host games with the clients being fellow *Players*.
- A **Host User** can start a *Survival* game entailing spawned *BugEnemies* emerging from the ground in random patterns at increased frequency as *SurvivalLevels* increase.
	- *SurvivalLevels* contain *LevelSpawnPatterns* that decrease or increase difficulty parameters in *BugSpawnPatterns* to provide enemies for the *SurvivalLevel*.
	- *BugTypes* are the owners of *BugSpawnPatterns*
	-  When a *SurvivalLevel* is completed (by killing all *BugEnemies* spawned during), the next *SurvivalLevel* is introduced after a short *SurvivalBreakTimeInterval* .
		- *BugEnemies* are killed via *<Ranged|Melee>Attacks* made by *Players*.
	- Along with *BugSpawnPatterns*, *BugTypes* follow certain *MovementPatterns* and *AttackPatterns*.
		- *MovementPatterns* entail different *MovementStyles* and *Reactions* to *Player* *<Ranged|Melee>Attacks*.
			- *Players* share this same ability to perform *<Ranged|Melee>Attacks*.
		- *AttackPatterns* entail a set of *<Ranged|Melee>Attacks* specific to a *BugEnemy's* *BugType*
	- A *BugEnemy's* *BugHealth* and *BugAttackStrength* are dependent on the *BugEnemy's* *BugType*.
	- A **Host User** can pause and unpause the *SurvivalBreakTimeInterval* counting to allow for *Players* to connect. 
		- *Players* can join a *HostPlayer* at any *SurvivalLevel*.