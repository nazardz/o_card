local mod = RegisterMod("OblivionCard", 1)
local json = require("json")
local debug = false
local game = Game()
local itemPool = game:GetItemPool()
local sfx = SFXManager()
local savetable = {}
local renderText = 'No Text'
local myUseFlags = UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER | UseFlag.USE_MIMIC

local RECOMMENDED_SHIFT_IDX = 35
local modRNG = RNG()

print('[OblivionCard v.0.9] Type `ocard` or `ocard help` for a list of commands')

local function modDataLoad()
	if mod:HasData() then
		local localtable = json.decode(mod:LoadData())
		savetable.FloppyDiskItems = localtable.FloppyDiskItems
		savetable.NadabCompletionMarks = localtable.NadabCompletionMarks
		savetable.AbihuCompletionMarks = localtable.AbihuCompletionMarks
		savetable.UnbiddenCompletionMarks = localtable.UnbiddenCompletionMarks
		savetable.ObliviousCompletionMarks = localtable.ObliviousCompletionMarks
		savetable.HasItemBirthright = localtable.HasItemBirthright
	else
		savetable.FloppyDiskItems = savetable.FloppyDiskItems or {}
		savetable.NadabCompletionMarks = savetable.NadabCompletionMarks or {0,0,0,0,0,0,0,0,0,0,0,0,0}
		savetable.AbihuCompletionMarks = savetable.AbihuCompletionMarks or {0,0,0,0,0,0,0,0,0,0,0,0,0}
		savetable.UnbiddenCompletionMarks = savetable.UnbiddenCompletionMarks or {0,0,0,0,0,0,0,0,0,0,0,0,0}
		savetable.ObliviousCompletionMarks = savetable.ObliviousCompletionMarks or {0,0,0,0,0,0,0,0,0,0,0,0,0}
		savetable.HasItemBirthright = savetable.HasItemBirthright or {}
	end
end

local function modDataSave()
	mod:SaveData(json.encode(savetable))
end

mod.Characters = {}
mod.Items = {}
mod.Trinkets = {}
mod.Pickups = {}
mod.Challenges = {}
mod.Curses = {}
--- PLAYERS --
do
mod.Characters.Nadab = Isaac.GetPlayerTypeByName("Nadab", false)
mod.Characters.Abihu = Isaac.GetPlayerTypeByName("Abihu", true)
mod.Characters.Unbidden = Isaac.GetPlayerTypeByName("Unbidden", false)
mod.Characters.Oblivious = Isaac.GetPlayerTypeByName("Unbidden", true)
end
--- COLLECTIBLES --
do
mod.Items.FloppyDisk = Isaac.GetItemIdByName("Floppy Disk")
mod.Items.FloppyDiskFull = Isaac.GetItemIdByName("Floppy Disk ") --
mod.Items.RedMirror = Isaac.GetItemIdByName("Red Mirror")
mod.Items.RedLotus = Isaac.GetItemIdByName("Red Lotus")
mod.Items.MidasCurse = Isaac.GetItemIdByName("Curse of the Midas")
mod.Items.RubberDuck = Isaac.GetItemIdByName("Duckling") -- killing room
mod.Items.IvoryOil = Isaac.GetItemIdByName("Ivory Oil") -- iconaclasts
mod.Items.BlackKnight = Isaac.GetItemIdByName("Black Knight") --
mod.Items.WhiteKnight = Isaac.GetItemIdByName("White Knight") --
mod.Items.KeeperMirror = Isaac.GetItemIdByName("Moonlighter") -- moonlighter
mod.Items.RedBag = Isaac.GetItemIdByName("Red Bag") -- Red generator!
mod.Items.MeltedCandle = Isaac.GetItemIdByName("Melted Candle") --
mod.Items.MiniPony = Isaac.GetItemIdByName("Unicorn") --
mod.Items.StrangeBox = Isaac.GetItemIdByName("Strange Box") --
mod.Items.RedButton = Isaac.GetItemIdByName("Red Button") -- please, don't touch anything
mod.Items.LostMirror = Isaac.GetItemIdByName("Lost Mirror") --
mod.Items.BleedingGrimoire = Isaac.GetItemIdByName("Bleeding Grimoire") -- they bleed pixels
mod.Items.BlackBook = Isaac.GetItemIdByName("Black Book") -- black book
mod.Items.RubikDice = Isaac.GetItemIdByName("Rubik's Dice")
mod.Items.RubikDiceScrambled0 = Isaac.GetItemIdByName("Scrambled Rubik's Dice")
mod.Items.RubikDiceScrambled1 = Isaac.GetItemIdByName("Scrambled Rubik's Dice ")
mod.Items.RubikDiceScrambled2 = Isaac.GetItemIdByName("Scrambled Rubik's Dice  ")
mod.Items.RubikDiceScrambled3 = Isaac.GetItemIdByName("Scrambled Rubik's Dice   ")
mod.Items.RubikDiceScrambled4 = Isaac.GetItemIdByName("Scrambled Rubik's Dice    ")
mod.Items.RubikDiceScrambled5 = Isaac.GetItemIdByName("Scrambled Rubik's Dice     ")
mod.Items.VHSCassette = Isaac.GetItemIdByName("VHS Cassette")
mod.Items.Lililith = Isaac.GetItemIdByName("Lililith")
mod.Items.CompoBombs = Isaac.GetItemIdByName("Compo Bombs")
mod.Items.LongElk = Isaac.GetItemIdByName("Long Elk") -- inscryption
mod.Items.Limb = Isaac.GetItemIdByName("Limbus")
mod.Items.GravityBombs = Isaac.GetItemIdByName("Black Hole Bombs")
mod.Items.MirrorBombs = Isaac.GetItemIdByName("Glass Bombs")
mod.Items.AbihuFam = Isaac.GetItemIdByName("Abihu")
mod.Items.FrostyBombs = Isaac.GetItemIdByName("Ice Cube Bombs")
mod.Items.VoidKarma = Isaac.GetItemIdByName("Karma Level") -- rainworld
mod.Items.CharonObol = Isaac.GetItemIdByName("Charon's Obol") -- hades
mod.Items.Viridian = Isaac.GetItemIdByName("VVV")
mod.Items.BookMemory = Isaac.GetItemIdByName("Book of Memories") -- loop hero
mod.Items.NadabBrain = Isaac.GetItemIdByName("Nadab's Brain")
mod.Items.Threshold = Isaac.GetItemIdByName("Threshold")
mod.Items.MongoCells = Isaac.GetItemIdByName("Mongo Cells") -- copy your familiars
mod.Items.NadabBody = Isaac.GetItemIdByName("Nadab's Body")
mod.Items.CosmicJam = Isaac.GetItemIdByName("Space Jam") -- "lf it weren't real, could it do this?"
--mod.Items.Lobotomy = Isaac.GetItemIdByName("Lobotomy") -- "Memory Management" erase enemies in room
mod.Items.DMS = Isaac.GetItemIdByName("Death's Sickle")
mod.Items.MewGen = Isaac.GetItemIdByName("Mew-Gen") 
mod.Items.ElderSign = Isaac.GetItemIdByName("Elder Sign")
--mod.Items.DiceBombs = Isaac.GetItemIdByName("Dice Bombs") -- "Reroll blast +5 bombs"
--mod.Items.Pizza = Isaac.GetItemIdByName("Pizza Pepperoni") -- active 12 seconds. Shoot Pizza boomerang, apply rotten tomato effect

--mod.Items.Gagger = Isaac.GetItemIdByName("Little Gagger") -- punching bag subtype ?

--mod.Items.ElderSign = Isaac.GetItemIdByName("Elder Sign") -- "Seal of Protection" active 1 room. Spawn Pentagram for 15 seconds at your position. Pentagram spawn worm friends
end
--- TRINKETS --
do
mod.Trinkets.WitchPaper = Isaac.GetTrinketIdByName("Witch Paper") -- yuppie psycho
mod.Trinkets.Duotine = Isaac.GetTrinketIdByName("Duotine") -- fran bow
mod.Trinkets.QueenSpades = Isaac.GetTrinketIdByName("Queen of Spades")
mod.Trinkets.RedScissors = Isaac.GetTrinketIdByName("Red Scissors") -- Fuse Cutter 2.0
mod.Trinkets.LostFlower = Isaac.GetTrinketIdByName("Lost Flower") -- "Eternal blessing"
mod.Trinkets.MilkTeeth = Isaac.GetTrinketIdByName("Milk Teeth")
mod.Trinkets.TeaBag = Isaac.GetTrinketIdByName("Tea Bag")
mod.Trinkets.BobTongue = Isaac.GetTrinketIdByName("Bob's Tongue")
mod.Trinkets.BinderClip = Isaac.GetTrinketIdByName("Binder Clip")
mod.Trinkets.MemoryFragment = Isaac.GetTrinketIdByName("Memory Fragment")
mod.Trinkets.AbyssCart = Isaac.GetTrinketIdByName("Cartridge") -- Cartridge?
mod.Trinkets.RubikCubelet = Isaac.GetTrinketIdByName("Rubik's Cubelet") -- TMTRAINER reroll when you take damage
mod.Trinkets.TeaFungus = Isaac.GetTrinketIdByName("Tea Fungus")
mod.Trinkets.DeadEgg = Isaac.GetTrinketIdByName("Dead Egg") -- chance to spawn dead bird effect when bomb explodes (soul of eve birds)
end
--- PICKUPS --
do
mod.Pickups.OblivionCard = Isaac.GetCardIdByName("01_OblivionCard") -- loop hero
mod.Pickups.BattlefieldCard = Isaac.GetCardIdByName("X_BattlefieldCard") -- loop hero
mod.Pickups.TreasuryCard = Isaac.GetCardIdByName("X_TreasuryCard") -- teleport to out-map treasure
mod.Pickups.BookeryCard = Isaac.GetCardIdByName("X_BookeryCard") -- teleport to out-map library
mod.Pickups.BloodGroveCard = Isaac.GetCardIdByName("X_BloodGroveCard") -- teleport to out-map cursed room
mod.Pickups.StormTempleCard = Isaac.GetCardIdByName("X_StormTempleCard") -- teleport to out-map sacrifice room
mod.Pickups.ArsenalCard = Isaac.GetCardIdByName("X_ArsenalCard") -- teleport to out-map chest room
mod.Pickups.OutpostCard = Isaac.GetCardIdByName("X_OutpostCard") -- teleport to out-map bedroom
mod.Pickups.CryptCard = Isaac.GetCardIdByName("X_CryptCard") -- teleport to out-map dungeon
mod.Pickups.MazeMemoryCard = Isaac.GetCardIdByName("X_MazeMemoryCard") -- teleport to death certificate dimension, add unremovable curse of maze, lost, blind in dimension
mod.Pickups.ZeroMilestoneCard = Isaac.GetCardIdByName("X_ZeroMilestoneCard") -- genesis, but next stage is void/ if used on ascension - next stage is home/ if used on greedmode - next stage is boss

mod.Pickups.Decay = Isaac.GetCardIdByName("X_Decay") --slay the spire
mod.Pickups.AscenderBane = Isaac.GetCardIdByName("X_AscenderBane") --[slay the spire
mod.Pickups.MultiCast = Isaac.GetCardIdByName("X_MultiCast")
mod.Pickups.Wish = Isaac.GetCardIdByName("X_Wish")
mod.Pickups.Offering = Isaac.GetCardIdByName("X_Offering")
mod.Pickups.InfiniteBlades = Isaac.GetCardIdByName("X_InfiniteBlades")
mod.Pickups.Transmutation = Isaac.GetCardIdByName("X_Transmutation")
mod.Pickups.RitualDagger = Isaac.GetCardIdByName("X_RitualDagger")
mod.Pickups.Fusion = Isaac.GetCardIdByName("X_Fusion")
mod.Pickups.DeuxEx = Isaac.GetCardIdByName("X_DeuxExMachina")
mod.Pickups.Adrenaline = Isaac.GetCardIdByName("X_Adrenaline")
mod.Pickups.Corruption = Isaac.GetCardIdByName("X_Corruption") -- slay the spire]]

mod.Pickups.Apocalypse = Isaac.GetCardIdByName("02_ApoopalypseCard") --
mod.Pickups.KingChess = Isaac.GetCardIdByName("03_KingChess")
mod.Pickups.KingChessW = Isaac.GetCardIdByName("X_KingChessW")
mod.Pickups.BannedCard = Isaac.GetCardIdByName("X_BannedCard") -- pot of greed
mod.Pickups.Trapezohedron = Isaac.GetCardIdByName("04_Trapezohedron")
mod.Pickups.SoulUnbidden = Isaac.GetCardIdByName("X_SoulUnbidden")
mod.Pickups.SoulNadabAbihu = Isaac.GetCardIdByName("X_SoulNadabAbihu")
mod.Pickups.GhostGem = Isaac.GetCardIdByName("X_GhostGem") -- flinthook
mod.Pickups.RedPill = Isaac.GetCardIdByName("X_RedPill")
mod.Pickups.RedPillHorse = Isaac.GetCardIdByName("X_RedPillHorse")

mod.Pickups.Domino34 = Isaac.GetCardIdByName("X_Domino34")
mod.Pickups.Domino25 = Isaac.GetCardIdByName("X_Domino25")
mod.Pickups.Domino16 = Isaac.GetCardIdByName("X_Domino16") -- spawn 6 pickups of same type
mod.Pickups.Domino00 = Isaac.GetCardIdByName("X_Domino00") -- Domino theory. Apply EntityFlag.FLAG_CONTAGIOUS to all enemies
--mod.Pickups.Domino12 = Isaac.GetCardIdByName("X_Domino12") -- shoot pizza 8 pizza around you
end
--- CHALLENGES --
do
mod.Challenges.Potatoes = Isaac.GetChallengeIdByName("When life gives you Potatoes!")
mod.Challenges.Magician = Isaac.GetChallengeIdByName("Curse of The Magician")
end
--- CURSES --
do
mod.Curses.Void = 1 << (Isaac.GetCurseIdByName("Curse of the Void!")-1) -- reroll enemies and grid, apply delirium spritesheet, always active on void floors
mod.Curses.Jamming = 1 << (Isaac.GetCurseIdByName("Curse of the Jamming!")-1) -- respawn enemies in room after clearing
--mod.Curses.Emperor = 1 << (Isaac.GetCurseIdByName("Curse of the Emperor!")-1) -- no exit door from boss room
mod.Curses.Magician = 1 << (Isaac.GetCurseIdByName("Curse of the Magician!")-1) -- homing enemy tears (except boss)
mod.Curses.Strength = 1 << (Isaac.GetCurseIdByName("Curse of Champions!")-1) -- chance to champion enemies (except boss)
mod.Curses.Bell = 1 << (Isaac.GetCurseIdByName("Curse of the Bell!")-1) -- all troll bombs golden
mod.Curses.Envy = 1 << (Isaac.GetCurseIdByName("Curse of the Envy!")-1) -- other shop items disappear when you buy one
--mod.Curses.Reaper = 1 << (Isaac.GetCurseIdByName("Curse of the Reaper!")-1) -- spawn death's scythe after 1 min on floor, it will follow you
end
--[[
mod.MyCurses = { -- curse table use it on CURSE_EVAL callback
mod.Curses.Void,
mod.Curses.Jamming,
--mod.Curses.Emperor,
mod.Curses.Magician,
mod.Curses.Strength,
mod.Curses.Bell,
mod.Curses.Envy,
--mod.Curses.Reaper -- death scythe slowly follows you. deals 1 heart damage. stops at < 25 range
--curse of the reaper
--EffectVariant.ULTRA_DEATH_SCYTHE
}
--]]
--- LOCAL TABLES --
do
mod.CurseIcons = Sprite()
mod.CurseIcons:Load("gfx/ui/oc_curse_icons.anm2", true) -- render it somewhere ?
mod.RedColor = Color(1.5,0,0,1,0,0,0) -- red color I guess
mod.TrinketDespawnTimer = 35 -- x>25; x=35 -- it will be removed
mod.ChaosVoid = true -- Void curse always active on Void floor
mod.CurseChance = 0.5 -- chances to mod curses to apply
mod.VoidThreshold = 0.15  -- chance to trigger void curse when entering room
mod.JammingThreshold = 0.15 -- chance to trigger jamming curse after clearing room
mod.StrengthThreshold = 0.15 -- chance to become champion
--mod.RetroThreshold = 0.05  --

mod.BellCurse = { -- bell curse turns next bombs into golden trollbombs
	[BombVariant.BOMB_TROLL] = true,
	[BombVariant.BOMB_SUPERTROLL] = true,
}

mod.NoBombTrace = { -- do not trace this bombs (used for: when you reenters room, prevents adding bomb-effect to existing bombs what was placed before getting any mod bomb item)
	[BombVariant.BOMB_TROLL]= true,
	[BombVariant.BOMB_SUPERTROLL]= true,
	[BombVariant.BOMB_GOLDENTROLL]= true,
	[BombVariant.BOMB_THROWABLE] = true,
	[BombVariant.BOMB_ROCKET] = true,
	[BombVariant.BOMB_ROCKET_GIGA] = true,
}

mod.ActiveItemWisps = {
	[mod.Items.RedMirror] = CollectibleType.COLLECTIBLE_RED_KEY,
	[mod.Items.KeeperMirror] = CollectibleType.COLLECTIBLE_KEEPERS_BOX,
	[mod.Items.MiniPony] = CollectibleType.COLLECTIBLE_MY_LITTLE_UNICORN,
	[mod.Items.StrangeBox] = CollectibleType.COLLECTIBLE_UNDEFINED,
	[mod.Items.LostMirror] = CollectibleType.COLLECTIBLE_BREATH_OF_LIFE,
	[mod.Items.BleedingGrimoire] = CollectibleType.COLLECTIBLE_RAZOR_BLADE,
	[mod.Items.BlackBook] = CollectibleType.COLLECTIBLE_DEAD_SEA_SCROLLS,
	[mod.Items.RubikDice] = CollectibleType.COLLECTIBLE_D6,
	[mod.Items.RubikDiceScrambled0] = CollectibleType.COLLECTIBLE_D6,
	[mod.Items.RubikDiceScrambled1] = CollectibleType.COLLECTIBLE_D6,
	[mod.Items.RubikDiceScrambled2] = CollectibleType.COLLECTIBLE_D6,
	[mod.Items.RubikDiceScrambled3] = CollectibleType.COLLECTIBLE_D6,
	[mod.Items.RubikDiceScrambled4] = CollectibleType.COLLECTIBLE_D6,
	[mod.Items.RubikDiceScrambled5] = CollectibleType.COLLECTIBLE_D6,
	[mod.Items.VHSCassette] = CollectibleType.COLLECTIBLE_CLICKER,
	[mod.Items.LongElk] = CollectibleType.COLLECTIBLE_NECRONOMICON,
	[mod.Items.CharonObol] = CollectibleType.COLLECTIBLE_WOODEN_NICKEL,
	[mod.Items.WhiteKnight] = CollectibleType.COLLECTIBLE_WHITE_PONY,
	[mod.Items.BlackKnight] = CollectibleType.COLLECTIBLE_PONY,
	[mod.Items.FloppyDisk] = CollectibleType.COLLECTIBLE_D4,
	[mod.Items.FloppyDiskFull] = CollectibleType.COLLECTIBLE_D4,
	[mod.Items.BookMemory] = CollectibleType.COLLECTIBLE_ERASER,
	--[mod.Items.Lobotomy] = CollectibleType.COLLECTIBLE_ERASER,
}

------------PASSIVE------------
--[[
lil gish
rotten baby
juicy sack
boiled baby
lil loki
multidim baby
robo baby			-- tech
robo baby 2			-- tech 2
seraphim
lil abaddon
lil monstro
demon baby
bot fly				-- lost contact
brother bobby
sister maggy
mongo baby			-- ?
cain eye
fate reward
bloodshot eye
buddy box
fruit plum			-- neptune
lil portal
lil spewer
--]]
mod.MongoCells = {}
mod.MongoCells.HeadlessCreepFrame = 8
mod.MongoCells.DryBabyChance = 0.33
mod.MongoCells.FartBabyChance = 0.33
mod.MongoCells.FartBabyBeans = {CollectibleType.COLLECTIBLE_BEAN, CollectibleType.COLLECTIBLE_BUTTER_BEAN, CollectibleType.COLLECTIBLE_KIDNEY_BEAN}
mod.MongoCells.DepressionCreepFrame = 8
mod.MongoCells.DepressionLightChance = 0.33
mod.MongoCells.BBFDamage = 100

mod.MewGen = {}
mod.MewGen.ActivationTimer = 150
mod.MewGen.RechargeTimer = 90

mod.DMS = {}
mod.DMS.Chance = 0.25

mod.RedLotus = {}
mod.RedLotus.DamageUp = 1.0 -- red lotus damage up for removing broken heart

mod.Viridian = {} -- sprite:RenderLayer(LayerId, Position, TopLeftClamp, BottomRightClamp)
mod.Viridian.FlipOffsetY = 34

mod.Limb = {}
mod.Limb.InvFrames = 24  -- frames count after death when you are invincible

mod.RedButton = {}
mod.RedButton.PressCount = 0 -- press counter
mod.RedButton.Limit = 66 -- limit
mod.RedButton.SpritePath = "gfx/grid/grid_redbutton.png"
mod.RedButton.KillButtonChance = 0.98 --99 -- actually 1%
mod.RedButton.EventButtonChance = 0.5 --50 -- 50/50% chance of spawning event button (if EventButtonChance = 60, actual chance is 40%)
mod.RedButton.VarData = 999 -- data to check right grid entity

mod.MidasCurse = {}
mod.MidasCurse.FreezeTime = 10000 -- midas freeze timer
mod.MidasCurse.MaxGold = 1.0 -- for check ?? (idk what is this for)
mod.MidasCurse.MinGold = 0.1 -- for check ??
mod.MidasCurse.TurnGoldChance = 1.0 -- with black candle is 0.1
--mod.MidasCurse.TearColor = Color(2, 1, 0, 1, 0, 0, 0)

mod.RubberDuck = {}
mod.RubberDuck.MaxLuck = 20 -- add luck when picked up (stackable)

mod.MeltedCandle = {}
mod.MeltedCandle.TearChance = 0.8 -- random + player.Luck > tearChance
mod.MeltedCandle.TearFlags = TearFlags.TEAR_FREEZE | TearFlags.TEAR_BURN -- tear effects
mod.MeltedCandle.TearColor =  Color(2, 2, 2, 1, 0.196, 0.196, 0.196) --spider bite color
mod.MeltedCandle.FrameCount = 102

mod.VoidKarma = {}
mod.VoidKarma.DamageUp = 0.25 -- add given values to player each time entering new level
mod.VoidKarma.TearsUp = 0.25
mod.VoidKarma.RangeUp = 2.5
mod.VoidKarma.ShotSpeedUp = 0.1
mod.VoidKarma.SpeedUp = 0.05
mod.VoidKarma.LuckUp = 0.5
mod.VoidKarma.EvaCache = CacheFlag.CACHE_DAMAGE | CacheFlag.CACHE_FIREDELAY | CacheFlag.CACHE_SHOTSPEED | CacheFlag.CACHE_RANGE | CacheFlag.CACHE_SPEED | CacheFlag.CACHE_LUCK

mod.CompoBombs = {}
mod.CompoBombs.BasicCountdown = 44 -- no way to get placed bomb countdown. meh. but it will explode anyway after 44 frames
mod.CompoBombs.ShortCountdown = 20 -- if player has short fuse trinket
mod.CompoBombs.FetusCountdown = 30 -- 30 for fetus
mod.CompoBombs.DimensionX = -22 -- move in X dimension (offset)
mod.CompoBombs.Baned = { -- don't add this effect on next bombs
	[BombVariant.BOMB_DECOY]= true,
	[BombVariant.BOMB_TROLL]= true,
	[BombVariant.BOMB_SUPERTROLL]= true,
	[BombVariant.BOMB_GOLDENTROLL]= true,
	[BombVariant.BOMB_THROWABLE] = true,
	[BombVariant.BOMB_GIGA] = true,
	[BombVariant.BOMB_ROCKET] = true
}

mod.MirrorBombs = {}
mod.MirrorBombs.BasicCountdown = 44 -- basic explosion countdown (copy compo bombs shortfuse and fetus countdown)
mod.MirrorBombs.Ban = { -- don't add this effect on next bombs
[BombVariant.BOMB_TROLL]= true,
[BombVariant.BOMB_SUPERTROLL]= true,
[BombVariant.BOMB_GOLDENTROLL]= true,
}

mod.FrostyBombs = {} -- sprite:ReplaceSpritesheet ( int LayerId, string PngFilename )
do
	mod.FrostyBombs.SpritePath = "gfx/bombs/cube/cube.png" -- normal
	mod.FrostyBombs.SpritePathGold = "gfx/bombs/cube/cubeGold.png" -- override

	mod.FrostyBombs.ScatterSpritePath = "gfx/bombs/cube/cubescatter.png" -- segmented
	mod.FrostyBombs.ScatterSpritePathGold = "gfx/bombs/cube/cubescattergold.png" -- combine/
	mod.FrostyBombs.ScatterSpritePathPoison = "gfx/bombs/cube/cubescatterpoison.png"
	mod.FrostyBombs.ScatterSpritePathBlood = "gfx/bombs/cube/cubescatterblood.png"
	mod.FrostyBombs.ScatterSpritePathButt = "gfx/bombs/cube/cubescatterbutt.png"
	mod.FrostyBombs.ScatterSpritePathWebb = "gfx/bombs/cube/cubescatterwebb.png"
	mod.FrostyBombs.ScatterSpritePathGlitter = "gfx/bombs/cube/cubescatterglitter.png"
	mod.FrostyBombs.ScatterSpritePathGhost = "gfx/bombs/cube/cubescatterghost.png"
	mod.FrostyBombs.ScatterSpritePathBomberBoy = "gfx/bombs/cube/cubescatterbomber.png"

	mod.FrostyBombs.WebSpritePath = "gfx/bombs/cube/cubeweb.png" -- webbed
	mod.FrostyBombs.WebSpritePathGold = "gfx/bombs/cube/cubewebgold.png"
	mod.FrostyBombs.WebSpritePathPoison = "gfx/bombs/cube/cubewebpoison.png"
	mod.FrostyBombs.WebSpritePathBlood = "gfx/bombs/cube/cubewebblood.png"
	mod.FrostyBombs.WebSpritePathGlitter = "gfx/bombs/cube/cubewebglitter.png"
	mod.FrostyBombs.WebSpritePathGhost = "gfx/bombs/cube/cubewebghost.png"
	mod.FrostyBombs.WebSpritePathBomberBoy = "gfx/bombs/cube/cubewebbomber.png"
	mod.FrostyBombs.WebSpritePathButt = "gfx/bombs/cube/cubewebbutt.png"

	mod.FrostyBombs.GhostSpritePath = "gfx/bombs/cube/cubeghost.png"
	mod.FrostyBombs.GhostSpritePathGold = "gfx/bombs/cube/cubeghostgold.png"
	mod.FrostyBombs.GhostSpritePathPoison = "gfx/bombs/cube/cubeghostpoison.png"
	mod.FrostyBombs.GhostSpritePathBlood = "gfx/bombs/cube/cubeghostblood.png"
	mod.FrostyBombs.GhostSpritePathGlitter = "gfx/bombs/cube/cubeghostglitter.png"
	mod.FrostyBombs.GhostSpritePathBomberBoy = "gfx/bombs/cube/cubeghostbomber.png"
	mod.FrostyBombs.GhostSpritePathButt = "gfx/bombs/cube/cubeghostbutt.png"

	mod.FrostyBombs.ButtSpritePath = "gfx/bombs/cube/cubebutt.png" -- butt shape? or brown

	mod.FrostyBombs.GlitterSpritePath = "gfx/bombs/cube/cubeglitter.png"	-- pink

	mod.FrostyBombs.BomberBoySpritePath = "gfx/bombs/cube/cubebomber.png"  -- black/deep blue

	mod.FrostyBombs.PoisonSpritePath = "gfx/bombs/cube/cubepoison.png" -- green ice

	mod.FrostyBombs.BloodSpritePath = "gfx/bombs/cube/cubeblood.png" -- red ice

	mod.FrostyBombs.BrimSpritePath = "gfx/bombs/cube/cubebrimstone.png"  -- brim with ice glow
	mod.FrostyBombs.BrimSpritePathGold = "gfx/bombs/cube/cubebrimstonegold.png"

	mod.FrostyBombs.GigaSpritePath = "gfx/bombs/cube/cubegiga.png" -- giga ice
	mod.FrostyBombs.GigaSpritePathGold = "gfx/bombs/cube/cubegigagold.png"
	mod.FrostyBombs.GigaSpritePathPoison = "gfx/bombs/cube/cubegigapoison.png"
	mod.FrostyBombs.GigaSpritePathBlood = "gfx/bombs/cube/cubegigablood.png"
	mod.FrostyBombs.GigaSpritePathButt = "gfx/bombs/cube/cubegigabutt.png"
	mod.FrostyBombs.GigaSpritePathWebb = "gfx/bombs/cube/cubegigawebb.png"
	mod.FrostyBombs.GigaSpritePathGlitter = "gfx/bombs/cube/cubegigaglitter.png"
	mod.FrostyBombs.GigaSpritePathGhost = "gfx/bombs/cube/cubegigaghost.png"
	mod.FrostyBombs.GigaSpritePathBomberBoy = "gfx/bombs/cube/cubegigabomber.png"
	mod.FrostyBombs.GigaSpritePathBrim = "gfx/bombs/cube/cubegigabrim.png"
	mod.FrostyBombs.GigaSpritePathScatter = "gfx/bombs/cube/cubegigascatter.png"

	mod.FrostyBombs.RocketSpritePath = "gfx/bombs/cube/cuberocket.png" -- rocket ice

	--mod.FrostyBombs.DecoySpritePath = "gfx/bombs/cube/cubedecoy.png" -- frozen decoy
	--mod.FrostyBombs.DecoySpritePathHole  = "gfx/bombs/cube/cubedecoyhole.png"
	--mod.FrostyBombs.BigSpritePath = "gfx/bombs/cube/cubebig.png" -- frozen mr.boom
	--mod.FrostyBombs.BigSpritePathHole = "gfx/bombs/cube/cubebighole.png"

	mod.FrostyBombs.NoSparksPath = "gfx/bombs/NoSparks.png"
end
mod.FrostyBombs.NancyChance = 0.1 -- chance to add bomb effect if you have nancy bombs
mod.FrostyBombs.FetusChance = 0.25 -- chance to add bomb effect to fetus bombs + player.Luck
mod.FrostyBombs.Flags = TearFlags.TEAR_SLOW | TearFlags.TEAR_ICE
mod.FrostyBombs.IgnoreSprite = { -- don't replace sprite
	[BombVariant.BOMB_BIG]= true,
	[BombVariant.BOMB_DECOY]= true,
}
mod.FrostyBombs.Ban = { -- don't affect next bombs (not used)
	[BombVariant.BOMB_TROLL]= true,
	[BombVariant.BOMB_SUPERTROLL]= true,
	[BombVariant.BOMB_GOLDENTROLL]= true,
	[BombVariant.BOMB_THROWABLE] = true,
}

mod.GravityBombs = {}
do
	mod.GravityBombs.SpritePath = "gfx/bombs/hole/hole.png"
	mod.GravityBombs.SpritePathGold = "gfx/bombs/hole/holegold.png"

	mod.GravityBombs.BloodSpritePath = "gfx/bombs/hole/holeblood.png"

	mod.GravityBombs.BomberSpritePath =  "gfx/bombs/hole/holebomber.png"

	mod.GravityBombs.BrimSpritePath = "gfx/bombs/hole/holebrimstone.png"
	mod.GravityBombs.BrimSpritePathGold = "gfx/bombs/hole/holebrimstonegold.png"

	mod.GravityBombs.ButtSpritePath = "gfx/bombs/hole/holebutt.png"
	mod.GravityBombs.ButtSpritePathGold = "gfx/bombs/hole/holebuttgold.png"

	mod.GravityBombs.CubeSpritePath = "gfx/bombs/hole/holecube.png"
	mod.GravityBombs.CubeSpritePathGold = "gfx/bombs/hole/holecubegold.png"
	mod.GravityBombs.CubeSpritePathBlood = "gfx/bombs/hole/holecubeblood.png"
	mod.GravityBombs.CubeSpritePathBomber = "gfx/bombs/hole/holecubebomber.png"
	mod.GravityBombs.CubeSpritePathButt = "gfx/bombs/hole/holecubebutt.png"
	mod.GravityBombs.CubeSpritePathGhost = "gfx/bombs/hole/holecubeghost.png"
	mod.GravityBombs.CubeSpritePathGlitter = "gfx/bombs/hole/holecubeglitter.png"
	mod.GravityBombs.CubeSpritePathScatter = "gfx/bombs/hole/holecubescatter.png"
	mod.GravityBombs.CubeSpritePathPoison = "gfx/bombs/hole/holecubepoison.png"
	mod.GravityBombs.CubeSpritePathWebb = "gfx/bombs/hole/holecubewebb.png"

	mod.GravityBombs.GhostSpritePath = "gfx/bombs/hole/holeghost.png"

	mod.GravityBombs.GlitterSpritePath = "gfx/bombs/hole/holeglitter.png"

	mod.GravityBombs.WebbSpritePath = "gfx/bombs/hole/holewebb.png"

	mod.GravityBombs.PoisonSpritePath = "gfx/bombs/hole/holepoison.png"

	mod.GravityBombs.RocketSpritePath = "gfx/bombs/hole/holerocket.png"
	mod.GravityBombs.RocketSpritePathGold = "gfx/bombs/hole/holerocket_gold.png"
	mod.GravityBombs.RocketSpritePathBlood = "gfx/bombs/hole/holerocketblood.png"
	mod.GravityBombs.RocketSpritePathBomber = "gfx/bombs/hole/holerocketbomber.png"
	mod.GravityBombs.RocketSpritePathButt = "gfx/bombs/hole/holerocketbutt.png"
	mod.GravityBombs.RocketSpritePathCube = "gfx/bombs/hole/holerocketcube.png"
	mod.GravityBombs.RocketSpritePathGhost = "gfx/bombs/hole/holerocketghost.png"
	mod.GravityBombs.RocketSpritePathGlitter = "gfx/bombs/hole/holerocketglitter.png"
	mod.GravityBombs.RocketSpritePathPoison = "gfx/bombs/hole/holerocketpoison.png"
	mod.GravityBombs.RocketSpritePathWebb = "gfx/bombs/hole/holerocketwebb.png"
	mod.GravityBombs.RocketSpritePathScatter = "gfx/bombs/hole/holerocketscatter.png"
	mod.GravityBombs.RocketSpritePathScatterGold = "gfx/bombs/hole/holerocketscattergold.png"
	mod.GravityBombs.RocketSpritePathScatterBlood = "gfx/bombs/hole/holerocketscatterblood.png"
	mod.GravityBombs.RocketSpritePathScatterBomber = "gfx/bombs/hole/holerocketscatterbomber.png"
	mod.GravityBombs.RocketSpritePathScatterButt = "gfx/bombs/hole/holerocketscatterbutt.png"
	mod.GravityBombs.RocketSpritePathScatterCube = "gfx/bombs/hole/holerocketscattercube.png"
	mod.GravityBombs.RocketSpritePathScatterGhost = "gfx/bombs/hole/holerocketscatterghost.png"
	mod.GravityBombs.RocketSpritePathScatterGlitter = "gfx/bombs/hole/holerocketscatterglitter.png"
	mod.GravityBombs.RocketSpritePathScatterPoison = "gfx/bombs/hole/holerocketscatterpoison.png"
	mod.GravityBombs.RocketSpritePathScatterWebb = "gfx/bombs/hole/holerocketscatterwebb.png"

	mod.GravityBombs.ScatterSpritePath = "gfx/bombs/hole/holescatter.png"
	mod.GravityBombs.ScatterSpritePathGold = "gfx/bombs/hole/holescattergold.png"
	mod.GravityBombs.ScatterSpritePathPoison = "gfx/bombs/hole/holescatterpoison.png"
	mod.GravityBombs.ScatterSpritePathBlood = "gfx/bombs/hole/holescatterblood.png"
	mod.GravityBombs.ScatterSpritePathButt = "gfx/bombs/hole/holescatterbutt.png"
	mod.GravityBombs.ScatterSpritePathWebb = "gfx/bombs/hole/holescatterwebb.png"
	mod.GravityBombs.ScatterSpritePathGlitter = "gfx/bombs/hole/holescatterglitter.png"
	mod.GravityBombs.ScatterSpritePathGhost = "gfx/bombs/hole/holescatterghost.png"
	mod.GravityBombs.ScatterSpritePathBomber = "gfx/bombs/hole/holescatterbomber.png"

	--mod.GravityBombs.SadSpritePath -- replace tears
	--mod.GravityBombs.HotSpritePath -- replace fire
	--mod.GravityBombs.DecoySpritePath -- hole decay
	--mod.GravityBombs.BigSpritePath -- hole mr.boom

	mod.GravityBombs.GigaSpritePath = "gfx/bombs/hole/holegiga.png"
	mod.GravityBombs.GigaSpritePathGold = "gfx/bombs/hole/holegigagold.png"
	mod.GravityBombs.GigaSpritePathBlood = "gfx/bombs/hole/holegigablood.png"
	mod.GravityBombs.GigaSpritePathBomber = "gfx/bombs/hole/holegigabomber.png"
	mod.GravityBombs.GigaSpritePathButt = "gfx/bombs/hole/holegigabutt.png"
	mod.GravityBombs.GigaSpritePathCube = "gfx/bombs/hole/holegigacube.png"
	mod.GravityBombs.GigaSpritePathCubeGold = "gfx/bombs/hole/holegigacubegold.png"
	mod.GravityBombs.GigaSpritePathGhost = "gfx/bombs/hole/holegigaghost.png"
	mod.GravityBombs.GigaSpritePathGlitter = "gfx/bombs/hole/holegigaglitter.png"
	mod.GravityBombs.GigaSpritePathPoison = "gfx/bombs/hole/holegigapoison.png"
	mod.GravityBombs.GigaSpritePathWebb = "gfx/bombs/hole/holegigawebb.png"
	mod.GravityBombs.GigaSpritePathBrim = "gfx/bombs/hole/holegigabrim.png"
	mod.GravityBombs.GigaSpritePathBrimBlood = "gfx/bombs/hole/holegigabrimblood.png"
	mod.GravityBombs.GigaSpritePathBrimBomber = "gfx/bombs/hole/holegigabrimbomber.png"
	mod.GravityBombs.GigaSpritePathBrimButt = "gfx/bombs/hole/holegigabrimbutt.png"
	mod.GravityBombs.GigaSpritePathBrimCube = "gfx/bombs/hole/holegigabrimcube.png"
	mod.GravityBombs.GigaSpritePathBrimCubeGold = "gfx/bombs/hole/holegigabrimcubegold.png"
	mod.GravityBombs.GigaSpritePathBrimGhost = "gfx/bombs/hole/holegigabrimghost.png"
	mod.GravityBombs.GigaSpritePathBrimGlitter = "gfx/bombs/hole/holegigabrimglitter.png"
	mod.GravityBombs.GigaSpritePathBrimGold = "gfx/bombs/hole/holegigabrimgold.png"
	mod.GravityBombs.GigaSpritePathBrimPoison = "gfx/bombs/hole/holegigabrimpoison.png"
	mod.GravityBombs.GigaSpritePathBrimWebb = "gfx/bombs/hole/holegigabrimwebb.png"
	mod.GravityBombs.GigaSpritePathScatter = "gfx/bombs/hole/holegigascatter.png"
	mod.GravityBombs.GigaSpritePathScatterBlood = "gfx/bombs/hole/holegigascatterblood.png"
	mod.GravityBombs.GigaSpritePathScatterBomber = "gfx/bombs/hole/holegigascatterbomber.png"
	mod.GravityBombs.GigaSpritePathScatterBrim = "gfx/bombs/hole/holegigascatterbrim.png"
	mod.GravityBombs.GigaSpritePathScatterBrimBlood = "gfx/bombs/hole/holegigascatterbrimblood.png"
	mod.GravityBombs.GigaSpritePathScatterBrimBomber = "gfx/bombs/hole/holegigascatterbrimbomber.png"
	mod.GravityBombs.GigaSpritePathScatterBrimButt = "gfx/bombs/hole/holegigascatterbrimbutt.png"
	mod.GravityBombs.GigaSpritePathScatterBrimCube = "gfx/bombs/hole/holegigascatterbrimcube.png"
	mod.GravityBombs.GigaSpritePathScatterBrimCubeGold = "gfx/bombs/hole/holegigascatterbrimcubegold.png"
	mod.GravityBombs.GigaSpritePathScatterBrimGhost = "gfx/bombs/hole/holegigascatterbrimghost.png"
	mod.GravityBombs.GigaSpritePathScatterBrimGlitter = "gfx/bombs/hole/holegigascatterbrimglitter.png"
	mod.GravityBombs.GigaSpritePathScatterBrimGold = "gfx/bombs/hole/holegigascatterbrimgold.png"
	mod.GravityBombs.GigaSpritePathScatterBrimPoison = "gfx/bombs/hole/holegigascatterbrimpoison.png"
	mod.GravityBombs.GigaSpritePathScatterBrimWebb = "gfx/bombs/hole/holegigascatterbrimwebb.png"
	mod.GravityBombs.GigaSpritePathScatterButt = "gfx/bombs/hole/holegigascatterbutt.png"
	mod.GravityBombs.GigaSpritePathScatterCube = "gfx/bombs/hole/holegigascattercube.png"
	mod.GravityBombs.GigaSpritePathScatterCubeGold = "gfx/bombs/hole/holegigascattercubegold.png"
	mod.GravityBombs.GigaSpritePathScatterGhost = "gfx/bombs/hole/holegigascatterghost.png"
	mod.GravityBombs.GigaSpritePathScatterGlitter = "gfx/bombs/hole/holegigascatterglitter.png"
	mod.GravityBombs.GigaSpritePathScatterGold = "gfx/bombs/hole/holegigascattergold.png"
	mod.GravityBombs.GigaSpritePathScatterPoison = "gfx/bombs/hole/holegigascatterpoison.png"
	mod.GravityBombs.GigaSpritePathScatterWebb = "gfx/bombs/hole/holegigascatterwebb.png"
end
mod.GravityBombs.BlackHoleEffect = Isaac.GetEntityVariantByName("BlackHoleBombsEffect") -- black hole effect
mod.GravityBombs.GigaBombs = 1
mod.GravityBombs.AttractorForce = 50 -- basic force
mod.GravityBombs.AttractorRange = 250 -- basic range
mod.GravityBombs.AttractorGridRange = 5 -- basic range
mod.GravityBombs.MaxRange = 2500 -- max range for attraction
mod.GravityBombs.MaxForce = 15 -- max force for attraction
mod.GravityBombs.MaxGrid = 200 -- max range for grid destroyer
mod.GravityBombs.IterRange = 15 -- increase attraction range
mod.GravityBombs.IterForce = 0.5 -- increase attraction force
mod.GravityBombs.IterGrid = 2.5 -- increase grid destroy range
mod.GravityBombs.NancyChance = 0.1 -- chance to add bomb effect if you have Nancy bombs
mod.GravityBombs.FetusChance = 0.25
mod.GravityBombs.IgnoreSprite = { -- ignore this bombs sprite
	[BombVariant.BOMB_BIG]= true,
	[BombVariant.BOMB_DECOY]= true,
}
mod.GravityBombs.Ban = { -- don't affect this bombs (not used)
	[BombVariant.BOMB_TROLL]= true,
	[BombVariant.BOMB_SUPERTROLL]= true,
	[BombVariant.BOMB_GOLDENTROLL]= true,
	[BombVariant.BOMB_THROWABLE] = true,
}
mod.DiceBombs = {}
mod.DiceBombs.ChestsTable = {50,51,52,53,54,55,56,57,58,60}
mod.DiceBombs.PickupsTable = {10, 20, 30, 40, 41, 50, 69, 70, 90, 300, 350}
mod.DiceBombs.AreaRadius = 150
mod.DiceBombs.NancyChance = 0.1
mod.DiceBombs.FetusChance = 0.25
mod.DiceBombs.IgnoreSprite = { -- ignore this bombs sprite
	[BombVariant.BOMB_BIG]= true,
	[BombVariant.BOMB_DECOY]= true,
}
mod.DiceBombs.Ban = { -- don't affect this bombs (not used)
	[BombVariant.BOMB_TROLL]= true,
	[BombVariant.BOMB_SUPERTROLL]= true,
	[BombVariant.BOMB_GOLDENTROLL]= true,
	[BombVariant.BOMB_THROWABLE] = true,
}
end
--- FAMILIARS --
do
mod.NadabBrain = {}
mod.NadabBrain.Variant = Isaac.GetEntityVariantByName("NadabBrain")
mod.NadabBrain.Speed = 3.75
mod.NadabBrain.Respawn = 300
mod.NadabBrain.MaxDistance = 150
mod.NadabBrain.BurnTime = 42
mod.NadabBrain.CollisionDamage = 3.5

mod.Lililith = {}
mod.Lililith.Variant = Isaac.GetEntityVariantByName("Lililith")
mod.Lililith.GenChance = 0.15 -- overall chance to spawn demon familiar
mod.Lililith.ChanceUp = 0.05 -- increase chance to given num after failure (GenChance += ChanceUp) reset to base after spawning demonling. also reset on new level
mod.Lililith.DemonSpawn = { -- familiars that can be spawned by lililith
{CollectibleType.COLLECTIBLE_DEMON_BABY, FamiliarVariant.DEMON_BABY, 0}, -- item. familiar. count
{CollectibleType.COLLECTIBLE_LIL_BRIMSTONE, FamiliarVariant.LIL_BRIMSTONE, 0},
{CollectibleType.COLLECTIBLE_LIL_ABADDON, FamiliarVariant.LIL_ABADDON, 0},
{CollectibleType.COLLECTIBLE_INCUBUS, FamiliarVariant.INCUBUS, 0},
{CollectibleType.COLLECTIBLE_SUCCUBUS, FamiliarVariant.SUCCUBUS, 0},}

mod.AbihuFam = {}
mod.AbihuFam.Variant = Isaac.GetEntityVariantByName("AbihuFam")
mod.AbihuFam.Subtype = 2 -- 0 - idle, 1 - walking
mod.AbihuFam.CollisionTime = 44 -- collision delay
mod.AbihuFam.SpawnRadius = 50 -- spawn radius of fire jets when get damage (with bffs)
mod.AbihuFam.BurnTime = 42 -- enemy burn time

mod.RedBag = {}
mod.RedBag.Variant = Isaac.GetEntityVariantByName("Red Bag")
mod.RedBag.RedPoopChance = 0.05 -- chance to spawn red poop
mod.RedBag.GenChance = 0.33 -- overall chance to generate something
mod.RedBag.ChanceUp = 0.4 -- increase chance to num if failed to spawn
mod.RedBag.RedPickups = { -- possible items
{PickupVariant.PICKUP_THROWABLEBOMB, 0},
{PickupVariant.PICKUP_HEART, HeartSubType.HEART_FULL},
{PickupVariant.PICKUP_HEART, HeartSubType.HEART_HALF},
{PickupVariant.PICKUP_HEART, HeartSubType.HEART_DOUBLEPACK},
{PickupVariant.PICKUP_HEART, HeartSubType.HEART_SCARED},
{PickupVariant.PICKUP_TAROTCARD, Card.CARD_DICE_SHARD},
{PickupVariant.PICKUP_TAROTCARD, Card.CARD_CRACKED_KEY},
{PickupVariant.PICKUP_TAROTCARD, mod.Pickups.RedPill},
{PickupVariant.PICKUP_TAROTCARD, mod.Pickups.RedPillHorse},
{PickupVariant.PICKUP_TAROTCARD, mod.Pickups.Trapezohedron}
}
end
--- TRINKETS --
do
mod.LostFlower = {}
mod.LostFlower.DespawnTimer = 35 -- timer after which trinket will be removed (effect similar to A+ trinket)
mod.LostFlower.ItemGiveEternalHeart ={ -- items which give eternal hearts
[CollectibleType.COLLECTIBLE_FATE]=true,
[CollectibleType.COLLECTIBLE_ACT_OF_CONTRITION]=true,
}

mod.RedScissors = {}
mod.RedScissors.NormalReplaceFrame = 58 -- replace troll bombs on this frame
mod.RedScissors.GigaReplaceFrame = 86 -- replace giga bombs on this frame
mod.RedScissors.TrollBombs = { -- replace next bombs
[BombVariant.BOMB_TROLL] = true,
[BombVariant.BOMB_SUPERTROLL] = true,
[BombVariant.BOMB_GOLDENTROLL] = true,
[BombVariant.BOMB_SMALL] = true,
[BombVariant.BOMB_BRIMSTONE] = true,
[BombVariant.BOMB_GIGA] = true,
}

mod.Duotine = {}
mod.Duotine.HorsePillChance = 0.1 -- chance to spawn red horse pill

mod.MilkTeeth = {}
mod.MilkTeeth.CoinChance = 0.15 -- 0.3 golden/mombox -- 0.5 golden+mombox
mod.MilkTeeth.CoinDespawnTimer = 75  -- remove coin on == 0

mod.TeaBag = {}
mod.TeaBag.Radius = 100 -- 200 -- golden or mom box -- 500 golden and mom box
mod.TeaBag.PoisonSmoke = EffectVariant.SMOKE_CLOUD -- remove smoke clouds

mod.BinderClip = {}
mod.BinderClip.DoublerChance = 0.1

mod.DeadEgg = {}
mod.DeadEgg.Timeout = 150
end
--- ACTIVE --
do
mod.ElderSign = {}
mod.ElderSign.Pentagram = EffectVariant.HERETIC_PENTAGRAM --EffectVariant.PENTAGRAM_BLACKPOWDER
mod.ElderSign.Timeout = 20
mod.ElderSign.AuraRange = 60

mod.WhiteKnight = {}
mod.WhiteKnight.Costume = NullItemID.ID_REVERSE_CHARIOT_ALT --Isaac.GetCostumeIdByPath("gfx/characters/whiteknight.anm2")

mod.BlackKnight = {}
mod.BlackKnight.Costume = Isaac.GetCostumeIdByPath("gfx/characters/knightmare.anm2")
mod.BlackKnight.Target = Isaac.GetEntityVariantByName("kTarget")
mod.BlackKnight.DoorRadius = 40 -- distance in which auto-enter door
mod.BlackKnight.BlastDamage = 75 -- blast damage when land
mod.BlackKnight.BlastRadius = 50 -- areas where blast affects
mod.BlackKnight.BlastKnockback = 30 -- knockback
mod.BlackKnight.PickupDistance = 30 -- auto-pickup range
mod.BlackKnight.InvFrames = 120 -- inv frames after using item
mod.BlackKnight.IgnoreAnimations = { -- ignore next animations while jumped/landed
["WalkDown"] = true,
["Hit"] = true,
["PickupWalkDown"] = true,
["Sad"] = true,
["Happy"] = true,
["WalkLeft"] = true,
["WalkRight"] = true,
["WalkUp"] = true,
}
mod.BlackKnight.TeleportAnimations = { -- teleport anims
["TeleportUp"] = true,
["TeleportDown"] = true,
}
mod.BlackKnight.StonEnemies = { -- crush stone enemies
[EntityType.ENTITY_STONEY] = true,
[EntityType.ENTITY_STONEHEAD] = true,
[EntityType.ENTITY_QUAKE_GRIMACE] = true,
[EntityType.ENTITY_BOMB_GRIMACE] = true,
}
mod.BlackKnight.ChestVariant = { -- chests
[PickupVariant.PICKUP_BOMBCHEST] = true,
[PickupVariant.PICKUP_LOCKEDCHEST] = true,
[PickupVariant.PICKUP_MEGACHEST] = true,
[PickupVariant.PICKUP_LOCKEDCHEST] = true,
[PickupVariant.PICKUP_REDCHEST] = true,
[PickupVariant.PICKUP_CHEST] = true,
[PickupVariant.PICKUP_SPIKEDCHEST] = true,
[PickupVariant.PICKUP_ETERNALCHEST] = true,
[PickupVariant.PICKUP_MIMICCHEST] = true,
[PickupVariant.PICKUP_OLDCHEST] = true,
[PickupVariant.PICKUP_WOODENCHEST] = true,
[PickupVariant.PICKUP_HAUNTEDCHEST] = true,
}

mod.LongElk = {}
mod.LongElk.InvFrames = 24  -- frames count when you invincible (not used)
mod.LongElk.BoneSpurTimer = 18  -- frames count after which bone spur can be spawned
mod.LongElk.NumSpur = 5 -- number of bone spurs after which oldest bone spur will be removed/killed: removeTimer = (BoneSpurTimer * NumSpur)
mod.LongElk.Costume = Isaac.GetCostumeIdByPath("gfx/characters/longelk.anm2") --longelk
mod.LongElk.Damage = 100

mod.RubikDice = {}
mod.RubikDice.GlitchReroll = 0.16 -- chance to become scrambled dice when used
mod.RubikDice.ScrambledDices = { -- checklist
[mod.Items.RubikDiceScrambled0] = true,
[mod.Items.RubikDiceScrambled1] = true,
[mod.Items.RubikDiceScrambled2] = true,
[mod.Items.RubikDiceScrambled3] = true,
[mod.Items.RubikDiceScrambled4] = true,
[mod.Items.RubikDiceScrambled5] = true,
}
mod.RubikDice.ScrambledDicesList = { -- list
mod.Items.RubikDiceScrambled0,
mod.Items.RubikDiceScrambled1,
mod.Items.RubikDiceScrambled2,
mod.Items.RubikDiceScrambled3,
mod.Items.RubikDiceScrambled4,
mod.Items.RubikDiceScrambled5
}

mod.BG = {} -- bleeding grimoire
mod.BG.FrameCount = 62 -- frame count to remove bleeding from enemies (bleeding will be removed on 0, it wouldn't apply anew until framecount == -25)
mod.BG.Costume = Isaac.GetCostumeIdByPath("gfx/characters/bleedinggrimoire.anm2")

mod.BlackBook = {}
mod.BlackBook.Duration = 162 -- duration of status effect
mod.BlackBook.Forever = 10000
mod.BlackBook.EffectFlags = { -- possible effects
	{EntityFlag.FLAG_FREEZE, Color(0.5, 0.5, 0.5, 1, 0, 0, 0), mod.BlackBook.Duration}, -- effect, color, duration
	{EntityFlag.FLAG_POISON, Color(0.4, 0.97, 0.5, 1, 0, 0, 0), mod.BlackBook.Duration},
	{EntityFlag.FLAG_SLOW, Color(0.15, 0.15, 0.15, 1, 0, 0, 0), mod.BlackBook.Duration},
	{EntityFlag.FLAG_CHARM, Color(1, 0, 1, 1, 0.196, 0, 0), mod.BlackBook.Duration},
	{EntityFlag.FLAG_CONFUSION, Color(0.5, 0.5, 0.5, 1, 0, 0, 0), mod.BlackBook.Duration},
	{EntityFlag.FLAG_MIDAS_FREEZE, Color(2, 1, 0, 1, 0, 0, 0), mod.BlackBook.Duration},
	{EntityFlag.FLAG_FEAR, Color(0.6, 0.4, 1.0, 1.0, 0, 0, 0), mod.BlackBook.Duration},
	{EntityFlag.FLAG_BURN, Color(1, 1, 1, 1, 0.3, 0, 0), mod.BlackBook.Duration},
	{EntityFlag.FLAG_SHRINK, Color(1, 1, 1, 1, 0, 0, 0), mod.BlackBook.Duration},
	{EntityFlag.FLAG_BLEED_OUT, Color(1.25, 0.05, 0.15, 1, 0, 0, 0), mod.BlackBook.Forever},
	{EntityFlag.FLAG_ICE, Color(1, 1, 3, 1, 0, 0, 0), mod.BlackBook.Forever},
	{EntityFlag.FLAG_MAGNETIZED, Color(0.6, 0.4, 1.0, 1.0, 0, 0, 0), mod.BlackBook.Forever},
	{EntityFlag.FLAG_BAITED, Color(0.7, 0.14, 0.1, 1, 0.3, 0, 0), mod.BlackBook.Forever},
}

mod.FloppyDisk = {}
--mod.FloppyDisk.Items = {} -- for saved items
--savetable.FloppyDiskItems = savetable.FloppyDiskItems or {}
mod.FloppyDisk.MissingNo = true -- add missingNo if not found saved item

mod.MiniPony = {}
mod.MiniPony.Costume = Isaac.GetCostumeIdByPath("gfx/characters/minipony.anm2")
mod.MiniPony.MoveSpeed = 1.5 -- locked speed while holding

mod.VHS = {} -- don not delete

mod.KeeperMirror = {}
mod.KeeperMirror.Target = Isaac.GetEntityVariantByName("mTarget")
mod.KeeperMirror.TargetRadius = 10
mod.KeeperMirror.TargetTimeout = 80 -- target will be removed when == 0. spawn coin
mod.KeeperMirror.RedHeart = 3 -- price of items
mod.KeeperMirror.HalfHeart = 2
mod.KeeperMirror.Collectible = 15
mod.KeeperMirror.NormalPickup = 5
mod.KeeperMirror.DoublePickup = 7
mod.KeeperMirror.DoubleHeart = 6
mod.KeeperMirror.RKey = 99
mod.KeeperMirror.MicroBattery = 3
mod.KeeperMirror.MegaBattery = 7
mod.KeeperMirror.GrabBag = 7
mod.KeeperMirror.GiantPill = 7

mod.StrangeBox = {}
mod.StrangeBox.Variants = { -- pickup variants
PickupVariant.PICKUP_HEART, PickupVariant.PICKUP_COIN, PickupVariant.PICKUP_KEY, PickupVariant.PICKUP_BOMB,
PickupVariant.PICKUP_CHEST, PickupVariant.PICKUP_BOMBCHEST, PickupVariant.PICKUP_SPIKEDCHEST,
PickupVariant.PICKUP_ETERNALCHEST, PickupVariant.PICKUP_MIMICCHEST, PickupVariant.PICKUP_OLDCHEST,
PickupVariant.PICKUP_WOODENCHEST, PickupVariant.PICKUP_MEGACHEST, PickupVariant.PICKUP_HAUNTEDCHEST,
PickupVariant.PICKUP_LOCKEDCHEST, PickupVariant.PICKUP_GRAB_BAG, PickupVariant.PICKUP_REDCHEST,
PickupVariant.PICKUP_PILL, PickupVariant.PICKUP_LIL_BATTERY, PickupVariant.PICKUP_TAROTCARD,
PickupVariant.PICKUP_TRINKET
}

mod.CharonObol = {}
mod.CharonObol.Timeout = 360

mod.Lobotomy = {}
mod.Lobotomy.ErasedEntities = {}
end
--- CARDS --
do
mod.MultiCast = {}
mod.MultiCast.NumWisps = 3 -- multi cast card number of wisps to spawn

mod.Corruption = {}
mod.Corruption.CostumeHead = Isaac.GetCostumeIdByPath("gfx/characters/corruptionhead.anm2")

mod.Offering = {}
mod.Offering.DamageNum = 2 -- take num heart damage (2 == full heart)

mod.OblivionCard = {}
mod.OblivionCard.TearVariant = TearVariant.CHAOS_CARD
mod.OblivionCard.SpritePath = "gfx/oblivioncardtear.png"
mod.OblivionCard.ErasedEntities = {} -- save erased entities
mod.OblivionCard.PoofColor = Color(0.5,1,2,1,0,0,0) -- light blue

mod.Apocalypse = {}
mod.Apocalypse.Room = nil -- room where it was used (room index)
mod.Apocalypse.RNG = nil -- rng of card

mod.KingChess = {}
mod.KingChess.RadiusStonePoop = 40
mod.KingChess.Radius = 48 -- 50 >= x >= 45

mod.InfiniteBlades = {}
mod.InfiniteBlades.newSpritePath = "gfx/infiniteBlades.png"
mod.InfiniteBlades.MaxNumber = 28 -- max number of knife tears
mod.InfiniteBlades.VelocityMulti = 15 -- velocity multiplier
mod.InfiniteBlades.DamageMulti = 3.0 -- deal multiplied damage (player.Damage * DamageMulti)

mod.DeuxEx = {}
mod.DeuxEx.LuckUp = 100 -- value of luck to add

mod.BannedCard = {}
mod.BannedCard.NumCards = 2

mod.RubikCubelet = {}
mod.RubikCubelet.TriggerChance = 0.33

mod.GhostGem = {}
mod.GhostGem.NumSouls = 4

mod.ZeroStoneUsed = false

mod.RedPills = {}
--mod.RedPills.RedEffect = Isaac.GetPillEffectByName("Side effects?") -- "Ultra-reality"
mod.RedPills.DamageUp = 10.8 -- dmg up
mod.RedPills.HorseDamageUp = 2 * mod.RedPills.DamageUp
mod.RedPills.DamageDown = 0.00001 -- init damage down by time (red stew effect)
mod.RedPills.DamageDownTick = 0.00001 -- increment of DamageDown
mod.RedPills.WavyCap = 1 -- layers of Wavy Cap effect. will be saved until DamageUp > 0
mod.RedPills.HorseWavyCap = 2 * mod.RedPills.WavyCap
end
--- LOCAL TABLES --

--- LOCAL FUNCTIONS --
-- globals
-- check dimension
local function GetCurrentDimension() -- KingBobson Algorithm: (get room dimension)
	--- get current dimension of room
	local level = game:GetLevel()
	local roomIndex = level:GetCurrentRoomIndex()
	local currentRoomDesc = level:GetCurrentRoomDesc()
	local currentRoomHash = GetPtrHash(currentRoomDesc)
	for dimension = 0, 2 do
		local dimensionRoomDesc = level:GetRoomByIdx(roomIndex, dimension)
		local dimensionRoomHash = GetPtrHash(dimensionRoomDesc)
		if (dimensionRoomHash == currentRoomHash) then
			return dimension
		end
	end
	return nil
end
-- follower familiar check
local function CheckForParent(fam)
	--- check familiar parents and child
    local child = fam.Child
    local parent = fam.Parent
    if parent ~= nil then
        parent.Child = fam
    end
    if child ~= nil then
        child.Parent = fam
    end
end
-- get item number
local function GetItemsCount(player, item)
	--- get number of items
	return player:GetCollectibleNum(item)+player:GetEffects():GetCollectibleEffectNum(item)
end
-- get player index
local function getPlayerIndex(player) -- ded#8894 Algorithm
	--- get player index. used to SAVE/LOAD mod data
	local collectible = 1
	local playerType = player:GetPlayerType()
	if playerType == PlayerType.PLAYER_LAZARUS2_B then
		collectible = 2
	end
	local seed = player:GetCollectibleRNG(collectible):GetSeed()
	return tostring(seed)
end
-- check item tag
local function CheckItemTags(ItemID, Tag)
	--- check item tag
	if ItemID > 0 then
		local itemConfigItem = Isaac.GetItemConfig():GetCollectible(ItemID)
		return itemConfigItem.Tags & Tag == Tag
	end
	return false
end
-- check in range
local function CheckInRange(myNum, min, max)
	--- check if number in given range: max >= myNum >= min
	return myNum >= min and myNum <= max
end
-- sound catcher
local function WhatSoundIsIt()
	--- get sound effect id
	for id=1, SoundEffect.NUM_SOUND_EFFECTS do
		if sfx:IsPlaying(id) then print(id) end
	end
end
-- spawn pickup
local function DebugSpawn(var, subtype, position)
	--- spawn pickup near given position
	if position == nil then
		position = game:GetRoom():GetCenterPos()
	end
	Isaac.Spawn(5, var, subtype, Isaac.GetFreeNearPosition(position, 0), Vector.Zero, nil)
end
-- drop any used card if debug is active
function mod:onAnyCard(card, player, useFlag)
	if debug and useFlag & myUseFlags == 0 then
		DebugSpawn(300, card, player.Position)
	end
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onAnyCard)
-- debug call at the start of run
local function InitDebugCall()
	--- for debug, spawn all items and etc.
	Isaac.ExecuteCommand("debug 8")
	Isaac.ExecuteCommand("debug 7")
	Isaac.ExecuteCommand("debug 9")
	Isaac.ExecuteCommand("debug 3")
	--[[
	DebugSpawn(100, mod.Items.FloppyDisk)
	DebugSpawn(100, mod.Items.RedLotus)
	DebugSpawn(100, mod.Items.MidasCurse)
	DebugSpawn(100, mod.Items.LostMirror)
	DebugSpawn(100, mod.Items.MiniPony)
	DebugSpawn(100, mod.Items.MeltedCandle)
	DebugSpawn(100, mod.Items.KeeperMirror)
	DebugSpawn(100, mod.Items.RedBag)
	DebugSpawn(100, mod.Items.StrangeBox)
	DebugSpawn(100, mod.Items.RedButton)
	DebugSpawn(100, mod.Items.VHSCassette)
	DebugSpawn(100, mod.Items.BlackBook)
	DebugSpawn(100, mod.Items.BleedingGrimoire)
	DebugSpawn(100, mod.Items.RubikDice)
	DebugSpawn(100, mod.Items.RedMirror)
	DebugSpawn(100, mod.Items.RubberDuck)
	DebugSpawn(100, mod.Items.IvoryOil)
	DebugSpawn(100, mod.Items.Lililith)
	DebugSpawn(100, mod.Items.BlackKnight)
	DebugSpawn(100, mod.Items.CompoBombs)
	DebugSpawn(100, mod.Items.MirrorBombs)
	DebugSpawn(100, mod.Items.AbihuFam)
	DebugSpawn(100, mod.Items.VoidKarma)
	DebugSpawn(100, mod.Items.WhiteKnight)
	DebugSpawn(100, mod.Items.Limb)
	DebugSpawn(100, mod.Items.CharonObol)
	DebugSpawn(100, mod.Items.MongoCells) -- fcuk u
	DebugSpawn(100, mod.Items.LongElk)
	DebugSpawn(100, mod.Items.GravityBombs)
	DebugSpawn(100, mod.Items.FrostyBombs)
	DebugSpawn(100, mod.Items.BookMemory)
	DebugSpawn(100, mod.Items.MeltedCandle)
	DebugSpawn(100, mod.Items.Viridian)
	--]]

	--[[
	DebugSpawn(350, mod.Trinkets.WitchPaper)
	DebugSpawn(350, mod.Trinkets.Duotine)
	DebugSpawn(350, mod.Trinkets.RedScissors)
	DebugSpawn(350, mod.Trinkets.LostFlower)
	DebugSpawn(350, mod.Trinkets.MilkTeeth)
	DebugSpawn(350, mod.Trinkets.TeaBag)
	DebugSpawn(350, mod.Trinkets.QueenSpades)
	DebugSpawn(350, mod.Trinkets.BobTongue)
	DebugSpawn(350, mod.Trinkets.MemoryFragment)
	DebugSpawn(350, mod.Trinkets.WitchPaper)
	DebugSpawn(350, mod.Trinkets.TeaFungus)
	DebugSpawn(350, mod.Trinkets.BinderClip)
	DebugSpawn(350, mod.Trinkets.RubikCubelet)
	--]]

	--]]
	--[[
	DebugSpawn(300, mod.Pickups.RedPill)
	DebugSpawn(300, mod.Pickups.RedHorsePill)
	DebugSpawn(300, mod.Pickups.OblivionCard)
	DebugSpawn(300, mod.Pickups.Trapezohedron)
	DebugSpawn(300, mod.Pickups.KingChess)
	DebugSpawn(300, mod.Pickups.KingChessW)
	DebugSpawn(300, mod.Pickups.Apocalypse)
	DebugSpawn(300, mod.Pickups.Domino34)
	DebugSpawn(300, mod.Pickups.Domino25)
	DebugSpawn(300, mod.Pickups.SoulUnbidden)
	DebugSpawn(300, mod.Pickups.AscenderBane)
	DebugSpawn(300, mod.Pickups.SoulNadabAbihu)
	DebugSpawn(300, mod.Pickups.Wish)
	DebugSpawn(300, mod.Pickups.Offering)
	DebugSpawn(300, mod.Pickups.InfiniteBlades)
	DebugSpawn(300, mod.Pickups.Transmutation)
	DebugSpawn(300, mod.Pickups.RitualDagger)
	DebugSpawn(300, mod.Pickups.Fusion)
	DebugSpawn(300, mod.Pickups.DeuxEx)
	DebugSpawn(300, mod.Pickups.Adrenaline)
	DebugSpawn(300, mod.Pickups.GhostGem)
	DebugSpawn(300, mod.Pickups.Corruption)
	DebugSpawn(300, mod.Pickups.MultiCast)
	--]
	DebugSpawn(300, mod.Pickups.BattlefieldCard)
	DebugSpawn(300, mod.Pickups.TreasuryCard)
	DebugSpawn(300, mod.Pickups.BookeryCard)
	DebugSpawn(300, mod.Pickups.BloodGroveCard)
	DebugSpawn(300, mod.Pickups.StormTempleCard)
	DebugSpawn(300, mod.Pickups.ArsenalCard)
	DebugSpawn(300, mod.Pickups.OutpostCard)
	DebugSpawn(300, mod.Pickups.ZeroMilestoneCard)
	DebugSpawn(300, mod.Pickups.Domino16)
	DebugSpawn(300, mod.Pickups.Decay)
	DebugSpawn(300, mod.Pickups.MazeMemoryCard)
	DebugSpawn(300, mod.Pickups.BannedCard)
	DebugSpawn(300, mod.Pickups.CryptCard)
	--]]

	--local level = game:GetLevel()
	--level:AddCurse(mod.Curses.Bell | mod.Curses.Envy | mod.Curses.Jamming | mod.Curses.Void | mod.Curses.Emperor | mod.Curses.Magician | mod.Curses.Strength,  false)
	--level:AddCurse(LevelCurse.CURSE_OF_THE_LOST , false)
	--level:AddCurse(LevelCurse.CURSE_OF_DARKNESS | LevelCurse.CURSE_OF_THE_LOST , false)
	--level:AddCurse(mod.Curses.Void, false)
	--level:AddCurse( mod.Curses.Jamming | mod.Curses.Void, false)
end
-- init some variables
local function InitCall()
	--- init call on new game start
	mod.OblivionCard.ErasedEntities = {}
	mod.Lobotomy.ErasedEntities = {}
	mod.Lililith.DemonSpawn = { -- familiars that can be spawned by lililith
	{CollectibleType.COLLECTIBLE_DEMON_BABY, FamiliarVariant.DEMON_BABY, 0}, -- item. familiar. count
	{CollectibleType.COLLECTIBLE_LIL_BRIMSTONE, FamiliarVariant.LIL_BRIMSTONE, 0},
	{CollectibleType.COLLECTIBLE_LIL_ABADDON, FamiliarVariant.LIL_ABADDON, 0},
	{CollectibleType.COLLECTIBLE_INCUBUS, FamiliarVariant.INCUBUS, 0},
	{CollectibleType.COLLECTIBLE_SUCCUBUS, FamiliarVariant.SUCCUBUS, 0},}
	mod.VHS.tableVHS = {
	{'1','1a','1b','1c','1d'}, -- basement 1 downpoor
	{'2','2a','2b','2c','2d'},
	{'3','3a','3b','3c','3d'},
	{'4','4a','4b','4c','4d'},
	{'5','5a','5b','5c','5d'},
	{'6','6a','6b','6c','6d'},
	{'7','7a','7b','7c','7d'},
	{'8','8a','8b','8c','8d'}, -- womb 2
	{'9'},	-- blue womb
	{'10','10a'}, -- cathedral sheol
	{'11','11a'}, -- chest dark room
	{'12'}} -- void
end
-- remove add trinket
local function TrinketRemoveAdd(player, newTrinket)
	--- gulp given trinket
	local t0 = player:GetTrinket(0)
	local t1 = player:GetTrinket(1)
	if t1 ~= 0 then
		player:TryRemoveTrinket(t1)
	end
	if t0 ~= 0 then
		player:TryRemoveTrinket(t0)
	end
	player:AddTrinket(newTrinket)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, myUseFlags)
	if t1 ~= 0 then
		player:AddTrinket(t1, false)
	end
	if t0 ~= 0 then
		player:AddTrinket(t0, false)
	end
end
-- remove gulp trinket
local function TrinketRemove(player, newTrinket)
	--- remove given gulped trinket
	local t0 = player:GetTrinket(0)
	local t1 = player:GetTrinket(1)
	if t1 ~= 0 then
		player:TryRemoveTrinket(t1)
	end
	if t0 ~= 0 then
		player:TryRemoveTrinket(t0)
	end
	player:TryRemoveTrinket(newTrinket)
	if t1 ~= 0 then
		player:AddTrinket(t1, false)
	end
	if t0 ~= 0 then
		player:AddTrinket(t0, false)
	end
end
-- throw trinket
local function RemoveThrowTrinket(player, trinket, timer)
	--- init throw trinket (A+ trinket imitation)
	local throwTrinket = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, trinket, player.Position, RandomVector()*5, player):ToPickup()
	local dataTrinket = throwTrinket:GetData()
	dataTrinket.DespawnTimer = timer
	player:TryRemoveTrinket(trinket)
end
-- target vector
local function UnitVector(vector) -- EDITH repentance mod
	--- idk what it does.
	return vector/math.sqrt(vector.X*vector.X + vector.Y*vector.Y)
end
---Red Pill
local function RedPillManager(player, newDamage, wavyNum)
	local data = player:GetData()
	game:ShowHallucination(5, BackdropType.DICE)
	if sfx:IsPlaying(SoundEffect.SOUND_DEATH_CARD) then
		sfx:Stop(SoundEffect.SOUND_DEATH_CARD)
	end
	--reset DamageDown
	data.RedPillDamageDown = mod.RedPills.DamageDown
	--wavy cap effect
	for _ = 1, wavyNum do
		player:UseActiveItem(CollectibleType.COLLECTIBLE_WAVY_CAP, myUseFlags)
	end
	if sfx:IsPlaying(SoundEffect.SOUND_VAMP_GULP) then
		sfx:Stop(SoundEffect.SOUND_VAMP_GULP)
	end
	data.RedPillDamageUp = data.RedPillDamageUp or 0
	data.RedPillDamageUp = data.RedPillDamageUp + newDamage
	player:AddCacheFlags(CacheFlag.CACHE_DAMAGE) -- | CacheFlag.CACHE_FIREDELAY)
	player:EvaluateItems()
end
---Mew-Gen
local function MewGenManager(player)
	local data = player:GetData()
	data.MewGenTimer = data.MewGenTimer or game:GetFrameCount()
	data.CheckTimer = data.CheckTimer or mod.MewGen.ActivationTimer
	if player:GetFireDirection() == -1 then
		--print(game:GetFrameCount(), game:GetFrameCount() - data.MewGenTimer)
		if game:GetFrameCount() - data.MewGenTimer >= data.CheckTimer then --mod.MewGen.ActivationTimer
			data.MewGenTimer = game:GetFrameCount()
			player:UseActiveItem(CollectibleType.COLLECTIBLE_TELEKINESIS, myUseFlags)
			data.CheckTimer = mod.MewGen.RechargeTimer
		end
	else
		data.MewGenTimer = game:GetFrameCount()
		data.CheckTimer = mod.MewGen.ActivationTimer
	end
end
---Floppy Disk
local function StorePlayerItems(player)
	--- store player items in savetable; FD is full
	modDataLoad()
	local allItems = Isaac.GetItemConfig():GetCollectibles().Size - 1 -- get all items in the game + mod items
	for id = 1, allItems do
		--ItemConfig.Config.IsValidCollectible(id) do not save modded items
		if player:HasCollectible(id) then -- and not itemConfig:HasTags(ItemConfig.TAG_QUEST) then -- itemConfig:HasTags(itemConfig.Tags & ItemConfig.TAG_QUEST)
			for _ = 1, player:GetCollectibleNum(id, true) do -- store number of items player have
				--table.insert(mod.FloppyDisk.Items, id)
				table.insert(savetable.FloppyDiskItems, id)
			end
		end
	end
	modDataSave()
end
local function ReplacePlayerItems(player) -- remove and replace items
	--- remove current items and replace them by items in savetable; FD is empty
	modDataLoad()
	local allItems = Isaac.GetItemConfig():GetCollectibles().Size - 1 -- get all items in the game + mod items
	for id = 1, allItems do
		if player:HasCollectible(id) and not CheckItemTags(id, ItemConfig.TAG_QUEST) then
			for _ = 1, player:GetCollectibleNum(id, true) do -- remove number of items player have
				player:RemoveCollectible(id)
			end
		end
	end
	--for _, itemID in pairs(mod.FloppyDisk.Items) do
	for _, itemID in pairs(savetable.FloppyDiskItems) do
		if itemID <= allItems then -- (I guess it can give you wrong items by stored id, if you add/remove mods after saving mod data)
			player:AddCollectible(itemID) -- give items from saved table
		else -- if saved item id is higher than current number of all items in the game
			if mod.FloppyDisk.MissingNo then
				player:AddCollectible(CollectibleType.COLLECTIBLE_MISSING_NO) -- give you missing no...
			end
		end
	end
	--mod.FloppyDisk.Items = {} -- empty saved items
	savetable.FloppyDiskItems = {}
	modDataSave()
end
---Midas Curse
local function GoldenGrid(rng)
	--- turn grid into golden (poop n' rocks)
	local room = game:GetRoom()
	for i=1, room:GetGridSize() do
		local grid = room:GetGridEntity(i)
		if grid then
			if grid:ToPoop() then  -- turn all poops
				if grid:GetType() == GridEntityType.GRID_POOP and grid:GetVariant() ~= 3 and grid.State == 0 then
					grid:SetVariant(3)
					grid:Init(rng:RandomInt(Random())+1)
					grid:PostInit()
					grid:Update()
				end
			end
		end
	end
end
local function TurnPickupsGold(pickup, rng) -- midas
	--- morph pickup into their golden versions
	local isChest = false
	local newSubType = pickup.SubType
	if pickup.Variant == PickupVariant.PICKUP_BOMB then
		if pickup.SubType ~= BombSubType.BOMB_GOLDENTROLL and pickup.SubType ~= BombSubType.BOMB_GOLDEN then
			if pickup.SubType == BombSubType.BOMB_TROLL or pickup.SubType == BombSubType.BOMB_SUPERTROLL then
				newSubType = BombSubType.BOMB_GOLDENTROLL
			else
				newSubType = BombSubType.BOMB_GOLDEN
			end
		end
	elseif pickup.Variant == PickupVariant.PICKUP_HEART and pickup.SubType ~= HeartSubType.HEART_GOLDEN then
		newSubType = HeartSubType.HEART_GOLDEN
	elseif pickup.Variant == PickupVariant.PICKUP_COIN and pickup.SubType ~= CoinSubType.COIN_GOLDEN then
		newSubType = CoinSubType.COIN_GOLDEN
	elseif pickup.Variant == PickupVariant.PICKUP_KEY and pickup.SubType ~= KeySubType.KEY_GOLDEN then
		newSubType = KeySubType.KEY_GOLDEN
	elseif pickup.Variant == PickupVariant.PICKUP_CHEST or pickup.Variant == PickupVariant.PICKUP_BOMBCHEST or pickup.Variant == PickupVariant.PICKUP_SPIKEDCHEST or pickup.Variant == PickupVariant.PICKUP_ETERNALCHEST or pickup.Variant == PickupVariant.PICKUP_MIMICCHEST or pickup.Variant == PickupVariant.PICKUP_OLDCHEST or pickup.Variant == PickupVariant.PICKUP_WOODENCHEST or pickup.Variant == PickupVariant.PICKUP_HAUNTEDCHEST or pickup.Variant == PickupVariant.PICKUP_REDCHEST then
		if not pickup.SubType == 1 then
			isChest = PickupVariant.PICKUP_LOCKEDCHEST
		end
	elseif pickup.Variant == PickupVariant.PICKUP_PILL and pickup.SubType ~= PillColor.PILL_GOLD then
		newSubType = PillColor.PILL_GOLD
	elseif pickup.Variant == PickupVariant.PICKUP_LIL_BATTERY and pickup.SubType ~= BatterySubType.BATTERY_GOLDEN then
		newSubType = BatterySubType.BATTERY_GOLDEN
	elseif pickup.Variant == PickupVariant.PICKUP_TRINKET and pickup.SubType < 32768 then -- TrinketType.TRINKET_GOLDEN_FLAG
		newSubType = pickup.SubType + 32768
	end
	if rng:RandomFloat() < mod.MidasCurse.TurnGoldChance then
		if newSubType ~= pickup.SubType  then
			pickup:ToPickup():Morph(pickup.Type, pickup.Variant, newSubType, true)
		elseif isChest then
			pickup:ToPickup():Morph(pickup.Type, isChest, 0, true)
		end
	end
end
---Duckling
local function EvaluateDuckLuck(player, luck)
	--- evaluate cache
	local data = player:GetData()
	data.DuckCurrentLuck = luck
	player:AddCacheFlags(CacheFlag.CACHE_LUCK)
	player:EvaluateItems()
end
---Chess King
local function MyGridSpawn(spawner, radius, entityType, entityVariant, forced)
	--- spawn grid in 3x3
	local room = game:GetRoom()
	local nulPos = room:GetGridPosition(room:GetGridIndex(spawner.Position))
	forced = forced or false
	Isaac.GridSpawn(entityType, entityVariant, Vector(nulPos.X, nulPos.Y+radius), forced) --up
	Isaac.GridSpawn(entityType, entityVariant, Vector(nulPos.X, nulPos.Y-radius), forced) --down
	Isaac.GridSpawn(entityType, entityVariant, Vector(nulPos.X+radius, nulPos.Y), forced) --right
	Isaac.GridSpawn(entityType, entityVariant, Vector(nulPos.X-radius, nulPos.Y), forced) --left
	Isaac.GridSpawn(entityType, entityVariant, Vector(nulPos.X+radius, nulPos.Y+radius), forced) -- up left
	Isaac.GridSpawn(entityType, entityVariant, Vector(nulPos.X+radius, nulPos.Y-radius), forced) -- down left
	Isaac.GridSpawn(entityType, entityVariant, Vector(nulPos.X-radius, nulPos.Y+radius), forced) -- up right
	Isaac.GridSpawn(entityType, entityVariant, Vector(nulPos.X-radius, nulPos.Y-radius), forced) -- down right
end
local function CircleSpawn(spawner, radius, velocity, entityType, entityVariant, entitySubtype)
	--- spawn entity in circle
	local point = radius*math.cos(math.rad(45))
	Isaac.Spawn(entityType, entityVariant, entitySubtype, Vector(spawner.Position.X, spawner.Position.Y+radius), Vector(0, velocity), spawner).Visible = true --up
	Isaac.Spawn(entityType, entityVariant, entitySubtype, Vector(spawner.Position.X, spawner.Position.Y-radius), Vector(0, -velocity), spawner) --down
	Isaac.Spawn(entityType, entityVariant, entitySubtype, Vector(spawner.Position.X+radius, spawner.Position.Y), Vector(velocity, 0), spawner) --right
	Isaac.Spawn(entityType, entityVariant, entitySubtype, Vector(spawner.Position.X-radius, spawner.Position.Y), Vector(-velocity, 0), spawner) --left
	Isaac.Spawn(entityType, entityVariant, entitySubtype, Vector(spawner.Position.X+point, spawner.Position.Y+point), Vector(velocity, velocity), spawner) -- up left
	Isaac.Spawn(entityType, entityVariant, entitySubtype, Vector(spawner.Position.X+point, spawner.Position.Y-point), Vector(velocity, -velocity), spawner) -- down left
	Isaac.Spawn(entityType, entityVariant, entitySubtype, Vector(spawner.Position.X-point, spawner.Position.Y+point), Vector(-velocity, velocity), spawner) -- up right
	Isaac.Spawn(entityType, entityVariant, entitySubtype, Vector(spawner.Position.X-point, spawner.Position.Y-point), Vector(-velocity, -velocity), spawner) -- down right
end
local function SquareSpawn(spawner, radius, velocity, entityType, entityVariant, entitySubtype)
	--- spawn entity in 3x3
	local point = radius
	Isaac.Spawn(entityType, entityVariant, entitySubtype, Vector(spawner.Position.X, spawner.Position.Y+radius), Vector(0, velocity), spawner).Visible = true --up
	Isaac.Spawn(entityType, entityVariant, entitySubtype, Vector(spawner.Position.X, spawner.Position.Y-radius), Vector(0, -velocity), spawner) --down
	Isaac.Spawn(entityType, entityVariant, entitySubtype, Vector(spawner.Position.X+radius, spawner.Position.Y), Vector(velocity, 0), spawner) --right
	Isaac.Spawn(entityType, entityVariant, entitySubtype, Vector(spawner.Position.X-radius, spawner.Position.Y), Vector(-velocity, 0), spawner) --left
	Isaac.Spawn(entityType, entityVariant, entitySubtype, Vector(spawner.Position.X+point, spawner.Position.Y+point), Vector(velocity, velocity), spawner) -- up left
	Isaac.Spawn(entityType, entityVariant, entitySubtype, Vector(spawner.Position.X+point, spawner.Position.Y-point), Vector(velocity, -velocity), spawner) -- down left
	Isaac.Spawn(entityType, entityVariant, entitySubtype, Vector(spawner.Position.X-point, spawner.Position.Y+point), Vector(-velocity, velocity), spawner) -- up right
	Isaac.Spawn(entityType, entityVariant, entitySubtype, Vector(spawner.Position.X-point, spawner.Position.Y-point), Vector(-velocity, -velocity), spawner) -- down right
end
---Black Knight
local function BlastDamage(radius, damage, knockback, player) -- player:GetCollectibleRNG(mod.Items.BlackKnight)
	--- crush when land
	local room = game:GetRoom()
	for _, entity in pairs(Isaac.GetRoomEntities()) do
		if entity.Position:Distance(player.Position) <= radius then
			if entity:IsVulnerableEnemy() and entity:IsActiveEnemy() then
				entity:TakeDamage(damage, DamageFlag.DAMAGE_EXPLOSION | DamageFlag.DAMAGE_CRUSH, EntityRef(player), 0)
				entity.Velocity = (entity.Position - player.Position):Resized(knockback)
			elseif entity.Type == EntityType.ENTITY_FIREPLACE and entity.Variant ~= 4 then
				entity:Die()
			elseif entity.Type == EntityType.ENTITY_MOVABLE_TNT then
				entity:Die()
			elseif ((entity.Type == EntityType.ENTITY_FAMILIAR and entity.Variant == FamiliarVariant.CUBE_BABY) or (entity.Type == EntityType.ENTITY_BOMB)) then
				entity.Velocity = (entity.Position - player.Position):Resized(knockback)
			elseif (entity.Type == EntityType.ENTITY_SHOPKEEPER and not entity:GetData().EID_Pathfinder) or mod.BlackKnight.StonEnemies[entity.Type] then
				entity:Kill()
			end
		end
	end
	for gridIndex = 1, room:GetGridSize() do
		if room:GetGridEntity(gridIndex) then
			local grid = room:GetGridEntity(gridIndex)
			if (player.Position - grid.Position):Length() <= radius then
				if grid.Desc.Type ~= GridEntityType.GRID_DOOR then
					grid:Destroy()
				else
					if grid.Desc.Variant ~= GridEntityType.GRID_DECORATION or grid.Desc.State ~= 1 then
						grid:Destroy()
					end
				end
			end
		end
	end
end
---Moonlighter
local function SellItems(pickup, player)
	--- price of items to sell
	local num = 0
	if pickup:IsShopItem() then return 0 end
	pickup = pickup:ToPickup()
	if pickup.Variant == PickupVariant.PICKUP_COLLECTIBLE then
		if pickup.SubType ~= 0 then num = mod.KeeperMirror.Collectible end
		if pickup.SubType == CollectibleType.COLLECTIBLE_R_KEY then num = mod.KeeperMirror.RKey end
	elseif pickup.Variant == PickupVariant.PICKUP_HEART then
		if pickup.SubType == HeartSubType.HEART_GOLDEN then
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_GOLDEN, pickup.Position, Vector.Zero, player)
			return -1
		end
		num = mod.KeeperMirror.NormalPickup
		if pickup.SubType == HeartSubType.HEART_FULL then num = mod.KeeperMirror.RedHeart end
		if pickup.SubType == HeartSubType.HEART_HALF then num = mod.KeeperMirror.HalfHeart end
		if pickup.SubType == HeartSubType.HEART_DOUBLEPACK then num = mod.KeeperMirror.DoubleHeart end
		if pickup.SubType == HeartSubType.HEART_HALF_SOUL then num = mod.KeeperMirror.HalfHeart end
	elseif pickup.Variant == PickupVariant.PICKUP_KEY then
		if pickup.SubType == KeySubType.KEY_GOLDEN then
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_GOLDEN, pickup.Position, Vector.Zero, player)
			return -1
		end
		num = mod.KeeperMirror.NormalPickup
		if pickup.SubType == KeySubType.KEY_DOUBLEPACK then num = mod.KeeperMirror.DoublePickup end
		if pickup.SubType == KeySubType.KEY_CHARGED then num = mod.KeeperMirror.NormalPickup end
	elseif pickup.Variant == PickupVariant.PICKUP_BOMB then
		if pickup.SubType ~= BombSubType.BOMB_TROLL or pickup.SubType ~= BombSubType.BOMB_SUPERTROLL or pickup.SubType ~= BombSubType.BOMB_GOLDENTROLL then
			if pickup.SubType == BombSubType.BOMB_GOLDEN then
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_GOLDEN, pickup.Position, Vector.Zero, player)
				return -1
			end
			num = mod.KeeperMirror.NormalPickup
			if pickup.SubType == BombSubType.BOMB_DOUBLEPACK or pickup.SubType == BombSubType.BOMB_GIGA then
				num = mod.KeeperMirror.DoublePickup
			end
		end
	elseif pickup.Variant == PickupVariant.PICKUP_THROWABLEBOMB or pickup.Variant == PickupVariant.PICKUP_POOP then
		num = mod.KeeperMirror.NormalPickup
	elseif pickup.Variant == PickupVariant.PICKUP_GRAB_BAG then
		num = mod.KeeperMirror.GrabBag
	elseif pickup.Variant == PickupVariant.PICKUP_PILL then
		if pickup.SubType == PillColor.PILL_GOLD then Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_GOLDEN, pickup.Position, Vector.Zero, player)
			return -1
		end
		num = mod.KeeperMirror.NormalPickup
		if pickup.SubType >= PillColor.PILL_GIANT_FLAG then num = mod.KeeperMirror.GiantPill end
	elseif pickup.Variant == PickupVariant.PICKUP_LIL_BATTERY then
		if pickup.SubType == BatterySubType.BATTERY_GOLDEN then
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_GOLDEN, pickup.Position, Vector.Zero, player)
			return -1
		end
		num = mod.KeeperMirror.NormalPickup
		if pickup.SubType >= BatterySubType.BATTERY_MICRO then num = mod.KeeperMirror.MicroBattery end
		if pickup.SubType >= BatterySubType.BATTERY_MEGA then num = mod.KeeperMirror.MegaBattery end
	elseif pickup.Variant == PickupVariant.PICKUP_TAROTCARD then
		num = mod.KeeperMirror.NormalPickup
	elseif pickup.Variant == PickupVariant.PICKUP_TRINKET then
		if pickup.SubType >= TrinketType.TRINKET_GOLDEN_FLAG then
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_GOLDEN, pickup.Position, Vector.Zero, player)
			return -1
		end
		num = mod.KeeperMirror.NormalPickup
	end
	return num
end
---Red Scissors
local function RedBombReplace(bomb)
	--- replace bomb by throwable bomb
	bomb:Remove()
	Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_THROWABLEBOMB, 0, bomb.Position, bomb.Velocity, nil)
	local effect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, bomb.Position, Vector.Zero, nil)
	effect:SetColor(mod.RedColor, 50, 1, false, false)
end
---Red Button
local function RemoveRedButton(room)
	--- remove pressure plate spawned by red button
	for gridIndex = 1, room:GetGridSize() do -- get room size
		local grid = room:GetGridEntity(gridIndex)
		if grid then -- check if there is any grid
			if grid.VarData == mod.RedButton.VarData then -- check if button is spawned by red button
				room:RemoveGridEntity(gridIndex, 0, false) -- remove it
				room:Update()
				local effect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, grid.Position, Vector.Zero, nil)
				effect:SetColor(Color(1.5,0,0,1,0,0,0), 50, 1, false, false) -- spawn poof effect
			end
		end
	end
end
local function SpawnButton(player, room)
	--- spawn new pressure plate
	local pos -- new position for button
	local subtype = 4 -- empty button, do nothing
	local spawned = false -- check for button spawn
	local rng = player:GetCollectibleRNG(mod.Items.RedButton) -- get rng
	local randNum = rng:RandomFloat()  --RandomInt(100) --+ player.Luck -- get random int to decide what type of button to spawn
	local killChance = randNum + player.Luck/100
	if killChance < 0.02 then killChance = 0.02 end
	if killChance >= mod.RedButton.KillButtonChance then
		subtype = 9 -- killer button
	elseif randNum >= mod.RedButton.EventButtonChance then
		subtype = 1 -- event button (spawn monsters, spawn items and etc.)
	end
	while not spawned do  -- don't spawn button under player -- possible bug: can spawns button under player when entering room
		pos = Isaac.GetFreeNearPosition(Isaac.GetRandomPosition(), 0.0) -- get random position
		spawned = true
		if pos == player.Position or room:GetGridEntityFromPos(pos) ~= nil then -- if button position is not player position
			spawned = false
		end
	end
	local button = Isaac.GridSpawn(GridEntityType.GRID_PRESSURE_PLATE, subtype, pos, false) -- spawn new button
	if button ~= nil then -- sometimes it didn't spawn
		button.VarData = mod.RedButton.VarData
		local mySprite = button:GetSprite()  -- replace sprite to red button
		mySprite:ReplaceSpritesheet(0, mod.RedButton.SpritePath)
		mySprite:LoadGraphics() -- replace sprite
	end
end
local function NewRoomRedButton(player, room)
	--- check for new room, spawn or remove pressure plate; (remove button when re-enter the `teleported_from_room`)
	mod.RedButton.PressCount = 0
	if room:IsFirstVisit() then -- if room visited first time
		SpawnButton(player, room) -- spawn new button
	else
		RemoveRedButton(room) -- remove button if there is left any button (ex: if you teleported while room is uncleared)
	end
end
---Rubik Dice
local function RerollTMTRAINER(player, item)
	--- reroll to glitched item
	player = player:ToPlayer()
	player:AddCollectible(CollectibleType.COLLECTIBLE_TMTRAINER)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_D6, myUseFlags) -- D6 effect
	player:RemoveCollectible(CollectibleType.COLLECTIBLE_TMTRAINER) -- remove tmtrainer
	if item then
		player:AnimateCollectible(item)
	end
end
---Lililith
local function LililithReset()
	--- reset lililith
	if #Isaac.FindByType(EntityType.ENTITY_FAMILIAR, mod.Lililith.Variant) > 0 then
		for _, fam in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, mod.Lililith.Variant)) do
			if fam:GetData().GenPickup then fam:GetData().GenPickup = false end
			fam = fam:ToFamiliar()
			local player = fam.Player:ToPlayer()
			local data = player:GetData()
			local tempEffects = player:GetEffects()
			if data.LililithDemonSpawn then
				for i = 1, #data.LililithDemonSpawn do
					if data.LililithDemonSpawn[i][3] > 0 then
						tempEffects:AddCollectibleEffect(data.LililithDemonSpawn[i][1], false, data.LililithDemonSpawn[i][3])
					end
				end
			end
		end
	end
end
---Queen of Spades
local function SesameOpen(room, level, player)
	--- open all doors in boss room
	if room:GetType() == RoomType.ROOM_BOSS and room:IsClear() then
		local curTime = game:GetFrameCount()
		local minutes = math.floor(curTime/30/60)%60
		--print(minutes)
		-- try open all doors
		for gridIndex = 1, room:GetGridSize() do
			if room:GetGridEntity(gridIndex) then
				if room:GetGridEntity(gridIndex):ToDoor() then
					room:GetGridEntity(gridIndex):ToDoor():Open()
				end
			end
		end
		if level:GetStage() == LevelStage.STAGE3_2 and minutes > 20 then
			room:TrySpawnBossRushDoor(true, false)
			player:AnimateTrinket(mod.Trinkets.QueenSpades)
			--player:TryRemoveTrinket(mod.Trinkets.QueenSpades)
		elseif level:GetStage() == LevelStage.STAGE4_2 and minutes > 30  then
			room:TrySpawnBlueWombDoor(true, true, false)
			player:AnimateTrinket(mod.Trinkets.QueenSpades)
			--player:TryRemoveTrinket(mod.Trinkets.QueenSpades)
		end
	end
end
---White Knight
local function GetNearestEnemy(basePos, distance)
	--- get near enemy's position, else return basePos position
	local finalPosition = basePos
	distance = distance or 5000
	local nearest = distance
	local enemies = Isaac.FindInRadius(basePos, distance, EntityPartition.ENEMY)
	if #enemies > 0 then
		for _, enemy in pairs(enemies) do
			if not enemy:HasEntityFlags(EntityFlag.FLAG_FRIENDLY | EntityFlag.FLAG_CHARM) and enemy:IsVulnerableEnemy() and enemy:IsActiveEnemy() and basePos:Distance(enemy.Position) < nearest then
                nearest = basePos:Distance(enemy.Position)
				finalPosition = enemy.Position
            end
		end
	end
	return finalPosition
end
---Mirror Bombs
local function FlipMirrorPos(pos)
	--- reflected position for given entity
	local room = game:GetRoom()
	local roomCenter = room:GetCenterPos()
	local newX = 0
	local newY = 0
	local offset = 0 -- I know that I can just leave it as "local offset" with nil value
	-- L shaped rooms
	if room:IsLShapedRoom() then
		roomCenter = Vector(580,420)
	end
	-- X
	if pos.X < roomCenter.X then -- dimension X
		offset = roomCenter.X - pos.X
		newX = roomCenter.X + offset
	else
		offset = pos.X - roomCenter.X
		newX = roomCenter.X - offset
	end
	-- Y
	if pos.Y < roomCenter.Y then -- dimension Y
		offset = roomCenter.Y - pos.Y
		newY = roomCenter.Y + offset
	else
		offset = pos.Y - roomCenter.Y
		newY = roomCenter.Y - offset
	end
	return Vector(newX, newY)
end
-- set countdown for new bombs
local function SetBombEXCountdown(player, bomb)
	--- set bomb countdown
	bomb:SetExplosionCountdown(mod.CompoBombs.BasicCountdown)
	if player:HasTrinket(TrinketType.TRINKET_SHORT_FUSE) then
		bomb:SetExplosionCountdown(mod.CompoBombs.ShortCountdown)
	elseif bomb.Parent:ToBomb().IsFetus then
		bomb:SetExplosionCountdown(mod.CompoBombs.FetusCountdown)
	end
	if bomb.Parent:ToBomb().IsFetus and player:HasTrinket(TrinketType.TRINKET_SHORT_FUSE) then
		bomb:SetExplosionCountdown(mod.CompoBombs.FetusCountdown/2)
	end
end
---Dice Bombs
local function InitDiceyBomb(bomb, bombData)
	bombData.Dicey = true
	if not mod.DiceBombs.IgnoreSprite[bomb.Variant] then
		-- add sprites
	end
end
local function DiceyReroll(rng, bombPos, radius)
	local pickups = Isaac.FindInRadius(bombPos, radius, EntityPartition.PICKUP)
	for _, pickup in pairs(pickups) do
		if pickup.Type ~= EntityType.ENTITY_SLOT then
			if pickup.Variant == 100 then
				local pool = itemPool:GetPoolForRoom(game:GetRoom():GetType(), game:GetSeeds():GetStartSeed())
				local newItem = itemPool:GetCollectible(pool, true, pickup.InitSeed)
				pickup:Morph(pickup.Type, pickup.Variant, newItem)
			else
				local var = mod.DiceBombs.PickupsTable [rng:RandomInt(#mod.DiceBombs.PickupsTable )+1]
				if var == 50 then
					var = mod.DiceBombs.ChestsTable[rng:RandomInt(#mod.DiceBombs.ChestsTable)+1]
				end
				pickup:Morph(pickup.Type, var, 0)
			end
		end
	end
end
---Frost Bombs
local function InitFrostyBomb(bomb, bombData)
	--- apply effect of ice cube bomb
	bombData.Frosty = true
	bomb:AddEntityFlags(EntityFlag.FLAG_ICE)  --useless to add
	bomb:AddTearFlags(mod.FrostyBombs.Flags)
	bombData.CreepVariant = EffectVariant.PLAYER_CREEP_HOLYWATER_TRAIL
	if not mod.FrostyBombs.IgnoreSprite[bomb.Variant] then --if bomb.Variant ~= BombVariant.BOMB_BIG and bomb.Variant ~= BombVariant.BOMB_DECOY then
		if bomb:HasTearFlags(TearFlags.TEAR_GOLDEN_BOMB) then -- or player:HasGoldenBomb() then
			bombData.newSpritePath = mod.FrostyBombs.SpritePathGold
			--bombData.FrostyCreepColor = Color(2,1.2,0,1,0,0,0) -- gold/yellow
			if bomb.Variant == BombVariant.BOMB_ROCKET_GIGA or bomb.Variant == BombVariant.BOMB_GIGA then --or bomb.Variant == BombVariant.BOMB_BRIMSTONE then
				bombData.newSpritePath = mod.FrostyBombs.GigaSpritePathGold
			elseif bomb.Variant == BombVariant.BOMB_ROCKET then
				bombData.newSpritePath = mod.FrostyBombs.RocketSpritePathGold
			elseif bomb:HasTearFlags(TearFlags.TEAR_BRIMSTONE_BOMB) then
				bombData.newSpritePath = mod.FrostyBombs.BrimSpritePathGold
			elseif bomb:HasTearFlags(TearFlags.TEAR_SCATTER_BOMB) then
				bombData.newSpritePath = mod.FrostyBombs.ScatterSpritePathGold
			elseif bomb:HasTearFlags(TearFlags.TEAR_GHOST_BOMB) then
				bombData.newSpritePath = mod.FrostyBombs.GhostSpritePathGold
				--bombData.FrostyCreepColor =  Color(1,1,1,0.5,0,0,0) -- alpha
			elseif bomb:HasTearFlags(TearFlags.TEAR_STICKY) then
				bombData.newSpritePath = mod.FrostyBombs.WebSpritePathGold
				bombData.CreepVariant = EffectVariant.PLAYER_CREEP_WHITE
				--bombData.FrostyCreepColor = Color(2,1,0,1,0,0,0) -- gold/yellow
			elseif bomb:HasTearFlags(TearFlags.TEAR_BLOOD_BOMB) then
				bombData.CreepVariant = EffectVariant.PLAYER_CREEP_RED
				--bombData.FrostyCreepColor = Color(2,1,0,1,0,0,0) -- gold/yellow
			elseif bomb:HasTearFlags(TearFlags.TEAR_GLITTER_BOMB) then -- glitter bombs
				bombData.FrostyCreepColor =  Color(2,0,0.7,1,0,0,0) -- pink
			elseif bomb:HasTearFlags(TearFlags.TEAR_BUTT_BOMB) then
				bombData.CreepVariant = EffectVariant.CREEP_SLIPPERY_BROWN
				--bombData.FrostyCreepColor = Color(2,1,0,1,0,0,0) -- gold/yellow
			elseif bomb:HasTearFlags(TearFlags.TEAR_POISON) then
				bombData.CreepVariant = EffectVariant.PLAYER_CREEP_GREEN
				--bombData.FrostyCreepColor = Color(2,1,0,1,0,0,0) -- gold/yellow
			end
		elseif bomb.Variant == BombVariant.BOMB_ROCKET_GIGA or bomb.Variant == BombVariant.BOMB_GIGA then
			bombData.newSpritePath = mod.FrostyBombs.GigaSpritePath
			if bomb:HasTearFlags(TearFlags.TEAR_BRIMSTONE_BOMB) then
				bombData.newSpritePath = mod.FrostyBombs.GigaSpritePathBrim
			elseif bomb:HasTearFlags(TearFlags.TEAR_SCATTER_BOMB) then -- scatter bombs
				bombData.newSpritePath = mod.FrostyBombs.GigaSpritePathScatter
			elseif bomb:HasTearFlags(TearFlags.TEAR_GHOST_BOMB) then -- ghost bomb
				bombData.newSpritePath = mod.FrostyBombs.GigaSpritePathGhost
			elseif bomb:HasTearFlags(TearFlags.TEAR_STICKY) then -- sticky bombs
				bombData.newSpritePath = mod.FrostyBombs.GigaSpritePathWebb
				bombData.CreepVariant = EffectVariant.PLAYER_CREEP_WHITE
			elseif bomb:HasTearFlags(TearFlags.TEAR_BLOOD_BOMB) then -- blood bomb
				bombData.newSpritePath = mod.FrostyBombs.GigaSpritePathBlood
				bombData.CreepVariant = EffectVariant.PLAYER_CREEP_RED
			elseif bomb:HasTearFlags(TearFlags.TEAR_CROSS_BOMB) then -- bombber boy bombs
				bombData.newSpritePath = mod.FrostyBombs.GigaSpritePathBomberBoy
			elseif bomb:HasTearFlags(TearFlags.TEAR_GLITTER_BOMB) then -- glitter bombs
				bombData.newSpritePath = mod.FrostyBombs.GigaSpritePathGlitter
				bombData.FrostyCreepColor =  Color(2,0,0.7,1,0,0,0) -- pink
			elseif bomb:HasTearFlags(TearFlags.TEAR_BUTT_BOMB) then -- butt bombs
				bombData.newSpritePath = mod.FrostyBombs.GigaSpritePathButt
				bombData.CreepVariant = EffectVariant.CREEP_SLIPPERY_BROWN
			elseif bomb:HasTearFlags(TearFlags.TEAR_POISON) then
				bombData.newSpritePath = mod.FrostyBombs.GigaSpritePathPoison
				bombData.CreepVariant = EffectVariant.PLAYER_CREEP_GREEN
			end
		elseif bomb.Variant == BombVariant.BOMB_ROCKET then -- rocket
			bombData.newSpritePath = mod.FrostyBombs.RocketSpritePath
			if bomb:HasTearFlags(TearFlags.TEAR_STICKY) then
				bombData.CreepVariant = EffectVariant.PLAYER_CREEP_WHITE
			elseif bomb:HasTearFlags(TearFlags.TEAR_BLOOD_BOMB) then
				bombData.CreepVariant = EffectVariant.PLAYER_CREEP_RED
			elseif bomb:HasTearFlags(TearFlags.TEAR_GLITTER_BOMB) then -- glitter bombs
				bombData.FrostyCreepColor =  Color(2,0,0.7,1,0,0,0) -- pink
			elseif bomb:HasTearFlags(TearFlags.TEAR_BUTT_BOMB) then
				bombData.CreepVariant = EffectVariant.CREEP_SLIPPERY_BROWN
			elseif bomb:HasTearFlags(TearFlags.TEAR_POISON) then
				bombData.CreepVariant = EffectVariant.PLAYER_CREEP_GREEN
			end
		elseif bomb:HasTearFlags(TearFlags.TEAR_BRIMSTONE_BOMB) then -- brimstone
			bombData.newSpritePath = mod.FrostyBombs.BrimSpritePath
			if bomb:HasTearFlags(TearFlags.TEAR_STICKY) then
				bombData.CreepVariant = EffectVariant.PLAYER_CREEP_WHITE
			elseif bomb:HasTearFlags(TearFlags.TEAR_BLOOD_BOMB) then
				bombData.CreepVariant = EffectVariant.PLAYER_CREEP_RED
			elseif bomb:HasTearFlags(TearFlags.TEAR_GLITTER_BOMB) then -- glitter bombs
				bombData.FrostyCreepColor =  Color(2,0,0.7,1,0,0,0) -- pink
			elseif bomb:HasTearFlags(TearFlags.TEAR_BUTT_BOMB) then
				bombData.CreepVariant = EffectVariant.CREEP_SLIPPERY_BROWN
			elseif bomb:HasTearFlags(TearFlags.TEAR_POISON) then
				bombData.CreepVariant = EffectVariant.PLAYER_CREEP_GREEN
			end
		elseif bomb:HasTearFlags(TearFlags.TEAR_SCATTER_BOMB) then -- scatter bombs
			bombData.newSpritePath = mod.FrostyBombs.ScatterSpritePath
			if bomb:HasTearFlags(TearFlags.TEAR_GHOST_BOMB) then -- ghost bomb
				bombData.newSpritePath = mod.FrostyBombs.ScatterSpritePathGhost
			elseif bomb:HasTearFlags(TearFlags.TEAR_STICKY) then -- sticky bombs
				bombData.newSpritePath = mod.FrostyBombs.ScatterSpritePathWebb
				bombData.CreepVariant = EffectVariant.PLAYER_CREEP_WHITE
			elseif bomb:HasTearFlags(TearFlags.TEAR_BLOOD_BOMB) then -- blood bomb
				bombData.newSpritePath = mod.FrostyBombs.ScatterSpritePathBlood
				bombData.CreepVariant = EffectVariant.PLAYER_CREEP_RED
			elseif bomb:HasTearFlags(TearFlags.TEAR_CROSS_BOMB) then -- bombber boy bombs
				bombData.newSpritePath = mod.FrostyBombs.ScatterSpritePathBomberBoy
			elseif bomb:HasTearFlags(TearFlags.TEAR_GLITTER_BOMB) then -- glitter bombs
				bombData.newSpritePath = mod.FrostyBombs.ScatterSpritePathGlitter
				bombData.FrostyCreepColor =  Color(2,0,0.7,1,0,0,0) -- pink
			elseif bomb:HasTearFlags(TearFlags.TEAR_BUTT_BOMB) then -- butt bombs
				bombData.newSpritePath = mod.FrostyBombs.ScatterSpritePathButt
				bombData.CreepVariant = EffectVariant.CREEP_SLIPPERY_BROWN
			elseif bomb:HasTearFlags(TearFlags.TEAR_POISON) then
				bombData.newSpritePath = mod.FrostyBombs.ScatterSpritePathPoison
				bombData.CreepVariant = EffectVariant.PLAYER_CREEP_GREEN
			end
		elseif  bomb:HasTearFlags(TearFlags.TEAR_GHOST_BOMB) then -- ghost bomb
			bombData.newSpritePath = mod.FrostyBombs.GhostSpritePath
			if bomb:HasTearFlags(TearFlags.TEAR_STICKY) then -- sticky bombs
				bombData.newSpritePath = mod.FrostyBombs.WebSpritePathGhost
				bombData.CreepVariant = EffectVariant.PLAYER_CREEP_WHITE
			elseif bomb:HasTearFlags(TearFlags.TEAR_BLOOD_BOMB) then -- blood bomb
				bombData.newSpritePath = mod.FrostyBombs.GhostSpritePathBlood
				bombData.CreepVariant = EffectVariant.PLAYER_CREEP_RED
			elseif bomb:HasTearFlags(TearFlags.TEAR_CROSS_BOMB) then -- bombber boy bombs
				bombData.newSpritePath = mod.FrostyBombs.GhostSpritePathBomberBoy
			elseif bomb:HasTearFlags(TearFlags.TEAR_GLITTER_BOMB) then -- glitter bombs
				bombData.newSpritePath = mod.FrostyBombs.GhostSpritePathGlitter
				bombData.FrostyCreepColor =  Color(2,0,0.7,1,0,0,0) -- pink
			elseif bomb:HasTearFlags(TearFlags.TEAR_BUTT_BOMB) then -- butt bombs
				bombData.newSpritePath = mod.FrostyBombs.GhostSpritePathButt
				bombData.CreepVariant = EffectVariant.CREEP_SLIPPERY_BROWN
			elseif bomb:HasTearFlags(TearFlags.TEAR_POISON) then
				bombData.newSpritePath = mod.FrostyBombs.GhostSpritePathPoison
				bombData.CreepVariant = EffectVariant.PLAYER_CREEP_GREEN
			end
		elseif bomb:HasTearFlags(TearFlags.TEAR_STICKY) then -- sticky bombs
			bombData.newSpritePath = mod.FrostyBombs.WebSpritePath
			bombData.CreepVariant = EffectVariant.PLAYER_CREEP_WHITE
			if bomb:HasTearFlags(TearFlags.TEAR_BLOOD_BOMB) then -- blood bomb
				bombData.newSpritePath = mod.FrostyBombs.WebSpritePathBlood
				bombData.CreepVariant = EffectVariant.PLAYER_CREEP_RED
			elseif bomb:HasTearFlags(TearFlags.TEAR_CROSS_BOMB) then -- bombber boy bombs
				bombData.newSpritePath = mod.FrostyBombs.WebSpritePathBomberBoy
			elseif bomb:HasTearFlags(TearFlags.TEAR_GLITTER_BOMB) then -- glitter bombs
				bombData.newSpritePath = mod.FrostyBombs.WebSpritePathGlitter
				bombData.FrostyCreepColor =  Color(2,0,0.7,1,0,0,0) -- pink
			elseif bomb:HasTearFlags(TearFlags.TEAR_BUTT_BOMB) then -- butt bombs
				bombData.newSpritePath = mod.FrostyBombs.WebSpritePathButt
				bombData.CreepVariant = EffectVariant.CREEP_SLIPPERY_BROWN
			elseif bomb:HasTearFlags(TearFlags.TEAR_POISON) then
				bombData.newSpritePath = mod.FrostyBombs.WebSpritePathPoison
				bombData.CreepVariant = EffectVariant.PLAYER_CREEP_GREEN
			end
		else
			bombData.newSpritePath = mod.FrostyBombs.SpritePath
			if bomb:HasTearFlags(TearFlags.TEAR_BLOOD_BOMB) then -- blood bomb
				bombData.newSpritePath = mod.FrostyBombs.BloodSpritePath
				bombData.CreepVariant = EffectVariant.PLAYER_CREEP_RED
			elseif bomb:HasTearFlags(TearFlags.TEAR_CROSS_BOMB) then -- bombber boy bombs
				bombData.newSpritePath = mod.FrostyBombs.BomberBoySpritePath
			elseif bomb:HasTearFlags(TearFlags.TEAR_GLITTER_BOMB) then -- glitter bombs
				bombData.newSpritePath = mod.FrostyBombs.GlitterSpritePath
				bombData.FrostyCreepColor =  Color(2,0,0.7,1,0,0,0) -- pink
			elseif bomb:HasTearFlags(TearFlags.TEAR_BUTT_BOMB) then -- butt bombs
				bombData.newSpritePath = mod.FrostyBombs.ButtSpritePath
				bombData.CreepVariant = EffectVariant.CREEP_SLIPPERY_BROWN
			elseif bomb:HasTearFlags(TearFlags.TEAR_POISON) then
				bombData.newSpritePath = mod.FrostyBombs.PoisonSpritePath
				bombData.CreepVariant = EffectVariant.PLAYER_CREEP_GREEN
			end
		end
	end
end
---Gravity Bombs
local function InitGravityBomb(bomb, bombData)
	--- apply effect of black hole bomb
	bombData.Gravity = true

	--bomb:AddTearFlags(TearFlags.TEAR_ATTRACTOR)
	bomb:AddEntityFlags(EntityFlag.FLAG_MAGNETIZED) -- else it wouldn't attract tears
	--[[
	if bomb:HasTearFlags(TearFlags.TEAR_BLOOD_BOMB) then
		bombData.newSpritePath = mod.GravityBombs.
	elseif bomb:HasTearFlags(TearFlags.TEAR_GHOST_BOMB) then
		bombData.newSpritePath = mod.GravityBombs.
	elseif bomb:HasTearFlags(TearFlags.TEAR_GLITTER_BOMB) then
		bombData.newSpritePath = mod.GravityBombs.
	elseif bomb:HasTearFlags(TearFlags.TEAR_STICKY) then
		bombData.newSpritePath = mod.GravityBombs.
	elseif bomb:HasTearFlags(TearFlags.TEAR_BUTT_BOMB) then
		bombData.newSpritePath = mod.GravityBombs.
	elseif bombData.Frosty then
		bombData.newSpritePath = mod.GravityBombs.
	elseif bomb:HasTearFlags(TearFlags.TEAR_CROSS_BOMB) then
		bombData.newSpritePath = mod.GravityBombs.
	elseif bomb:HasTearFlags(TearFlags.TEAR_POISON) then
		bombData.newSpritePath = mod.GravityBombs.
	end
	--]]
	if not mod.GravityBombs.IgnoreSprite[bomb.Variant] then --bomb.Variant ~= BombVariant.BOMB_BIG and bomb.Variant ~= BombVariant.BOMB_DECOY then
		if bomb:HasTearFlags(TearFlags.TEAR_GOLDEN_BOMB) then
			bombData.newSpritePath = mod.GravityBombs.SpritePathGold
			if bomb.Variant == BombVariant.BOMB_ROCKET_GIGA or bomb.Variant == BombVariant.BOMB_GIGA then --or bomb.Variant == BombVariant.BOMB_BRIMSTONE then
				bombData.newSpritePath = mod.GravityBombs.GigaSpritePathGold
				if bombData.Frosty and bomb:HasTearFlags(TearFlags.TEAR_BRIMSTONE_BOMB) and bomb:HasTearFlags(TearFlags.TEAR_SCATTER_BOMB) then
					bombData.newSpritePath = mod.GravityBombs.GigaSpritePathScatterBrimCubeGold
				elseif bomb:HasTearFlags(TearFlags.TEAR_BRIMSTONE_BOMB) and bomb:HasTearFlags(TearFlags.TEAR_SCATTER_BOMB) then
					bombData.newSpritePath = mod.GravityBombs.GigaSpritePathScatterBrimGold
				elseif bombData.Frosty and bomb:HasTearFlags(TearFlags.TEAR_BRIMSTONE_BOMB) then
					bombData.newSpritePath = mod.GravityBombs.GigaSpritePathBrimCubeGold
				elseif bombData.Frosty and bomb:HasTearFlags(TearFlags.TEAR_SCATTER_BOMB) then
					bombData.newSpritePath = mod.GravityBombs.GigaSpritePathScatterCubeGold
				elseif bomb:HasTearFlags(TearFlags.TEAR_BRIMSTONE_BOMB) then
					bombData.newSpritePath = mod.GravityBombs.GigaSpritePathBrimGold
				elseif bomb:HasTearFlags(TearFlags.TEAR_SCATTER_BOMB) then
					bombData.newSpritePath = mod.GravityBombs.GigaSpritePathScatterGold
				elseif bombData.Frosty then
					bombData.newSpritePath = mod.GravityBombs.GigaSpritePathCubeGold
				end
			elseif bomb.Variant == BombVariant.BOMB_ROCKET then
				bombData.newSpritePath = mod.GravityBombs.RocketSpritePathGold
				if bomb:HasTearFlags(TearFlags.TEAR_SCATTER_BOMB) then
					bombData.newSpritePath = mod.GravityBombs.RocketSpritePathScatterGold
				end
			elseif bomb:HasTearFlags(TearFlags.TEAR_BRIMSTONE_BOMB) then
				bombData.newSpritePath = mod.GravityBombs.BrimSpritePathGold

			elseif bombData.Frosty then
				bombData.newSpritePath = mod.GravityBombs.CubeSpritePathGold
			elseif bomb:HasTearFlags(TearFlags.TEAR_BUTT_BOMB) then
				bombData.newSpritePath = mod.GravityBombs.ButtSpritePathGold
			elseif bomb:HasTearFlags(TearFlags.TEAR_SCATTER_BOMB) then
				bombData.newSpritePath = mod.GravityBombs.ScatterSpritePathGold
			end
		elseif bomb.Variant == BombVariant.BOMB_ROCKET_GIGA or bomb.Variant == BombVariant.BOMB_GIGA then
			bombData.newSpritePath = mod.GravityBombs.GigaSpritePath
			if bomb:HasTearFlags(TearFlags.TEAR_BRIMSTONE_BOMB) then
				bombData.newSpritePath = mod.GravityBombs.GigaSpritePathBrim
				if bomb:HasTearFlags(TearFlags.TEAR_SCATTER_BOMB) then
					bombData.newSpritePath = mod.GravityBombs.GigaSpritePathScatterBrim
					if bomb:HasTearFlags(TearFlags.TEAR_BLOOD_BOMB) then
						bombData.newSpritePath = mod.GravityBombs.GigaSpritePathScatterBrimBlood
					elseif bomb:HasTearFlags(TearFlags.TEAR_GHOST_BOMB) then
						bombData.newSpritePath = mod.GravityBombs.GigaSpritePathScatterBrimGhost
					elseif bomb:HasTearFlags(TearFlags.TEAR_GLITTER_BOMB) then
						bombData.newSpritePath = mod.GravityBombs.GigaSpritePathScatterBrimGlitter
					elseif bomb:HasTearFlags(TearFlags.TEAR_STICKY) then
						bombData.newSpritePath = mod.GravityBombs.GigaSpritePathScatterBrimWebb
					elseif bomb:HasTearFlags(TearFlags.TEAR_BUTT_BOMB) then
						bombData.newSpritePath = mod.GravityBombs.GigaSpritePathScatterBrimButt
					elseif bombData.Frosty then
						bombData.newSpritePath = mod.GravityBombs.GigaSpritePathScatterBrimCube
					elseif bomb:HasTearFlags(TearFlags.TEAR_CROSS_BOMB) then
						bombData.newSpritePath = mod.GravityBombs.GigaSpritePathScatterBrimBomber
					elseif bomb:HasTearFlags(TearFlags.TEAR_POISON) then
						bombData.newSpritePath = mod.GravityBombs.GigaSpritePathScatterBrimPoison
					end
				elseif bomb:HasTearFlags(TearFlags.TEAR_BLOOD_BOMB) then
					bombData.newSpritePath = mod.GravityBombs.GigaSpritePathBrimBlood
				elseif bomb:HasTearFlags(TearFlags.TEAR_GHOST_BOMB) then
					bombData.newSpritePath = mod.GravityBombs.GigaSpritePathBrimGhost
				elseif bomb:HasTearFlags(TearFlags.TEAR_GLITTER_BOMB) then
					bombData.newSpritePath = mod.GravityBombs.GigaSpritePathBrimGlitter
				elseif bomb:HasTearFlags(TearFlags.TEAR_STICKY) then
					bombData.newSpritePath = mod.GravityBombs.GigaSpritePathBrimWebb
				elseif bomb:HasTearFlags(TearFlags.TEAR_BUTT_BOMB) then
					bombData.newSpritePath = mod.GravityBombs.GigaSpritePathBrimButt
				elseif bombData.Frosty then
					bombData.newSpritePath = mod.GravityBombs.GigaSpritePathBrimCube
				elseif bomb:HasTearFlags(TearFlags.TEAR_CROSS_BOMB) then
					bombData.newSpritePath = mod.GravityBombs.GigaSpritePathBrimBomber
				elseif bomb:HasTearFlags(TearFlags.TEAR_POISON) then
					bombData.newSpritePath = mod.GravityBombs.GigaSpritePathBrimPoison
				end
			--SCATTERS
			elseif bomb:HasTearFlags(TearFlags.TEAR_SCATTER_BOMB) then
				bombData.newSpritePath = mod.GravityBombs.GigaSpritePathScatter
				if bomb:HasTearFlags(TearFlags.TEAR_BLOOD_BOMB) then
					bombData.newSpritePath = mod.GravityBombs.GigaSpritePathScatterBlood
				elseif bomb:HasTearFlags(TearFlags.TEAR_GHOST_BOMB) then
					bombData.newSpritePath = mod.GravityBombs.GigaSpritePathScatterGhost
				elseif bomb:HasTearFlags(TearFlags.TEAR_GLITTER_BOMB) then
					bombData.newSpritePath = mod.GravityBombs.GigaSpritePathScatterGlitter
				elseif bomb:HasTearFlags(TearFlags.TEAR_STICKY) then
					bombData.newSpritePath = mod.GravityBombs.GigaSpritePathScatterWebb
				elseif bomb:HasTearFlags(TearFlags.TEAR_BUTT_BOMB) then
					bombData.newSpritePath = mod.GravityBombs.GigaSpritePathScatterButt
				elseif bombData.Frosty then
					bombData.newSpritePath = mod.GravityBombs.GigaSpritePathScatterCube
				elseif bomb:HasTearFlags(TearFlags.TEAR_CROSS_BOMB) then
					bombData.newSpritePath = mod.GravityBombs.GigaSpritePathScatterBomber
				elseif bomb:HasTearFlags(TearFlags.TEAR_POISON) then
					bombData.newSpritePath = mod.GravityBombs.GigaSpritePathScatterPoison
				end
			--GIGAS
			elseif bomb:HasTearFlags(TearFlags.TEAR_BLOOD_BOMB) then
				bombData.newSpritePath = mod.GravityBombs.GigaSpritePathBlood
			elseif bomb:HasTearFlags(TearFlags.TEAR_GHOST_BOMB) then
				bombData.newSpritePath = mod.GravityBombs.GigaSpritePathGhost
			elseif bomb:HasTearFlags(TearFlags.TEAR_GLITTER_BOMB) then
				bombData.newSpritePath = mod.GravityBombs.GigaSpritePathGlitter
			elseif bomb:HasTearFlags(TearFlags.TEAR_STICKY) then
				bombData.newSpritePath = mod.GravityBombs.GigaSpritePathWebb
			elseif bomb:HasTearFlags(TearFlags.TEAR_BUTT_BOMB) then
				bombData.newSpritePath = mod.GravityBombs.GigaSpritePathButt
			elseif bombData.Frosty then
				bombData.newSpritePath = mod.GravityBombs.GigaSpritePathCube
			elseif bomb:HasTearFlags(TearFlags.TEAR_CROSS_BOMB) then
				bombData.newSpritePath = mod.GravityBombs.GigaSpritePathBomber
			elseif bomb:HasTearFlags(TearFlags.TEAR_POISON) then
				bombData.newSpritePath = mod.GravityBombs.GigaSpritePathPoison
			end
		elseif bomb.Variant == BombVariant.BOMB_ROCKET then
			bombData.newSpritePath = mod.GravityBombs.RocketSpritePath
			if bomb:HasTearFlags(TearFlags.TEAR_SCATTER_BOMB) then
				bombData.newSpritePath = mod.GravityBombs.RocketSpritePathScatter
				--scaterrs
				if bomb:HasTearFlags(TearFlags.TEAR_BLOOD_BOMB) then
					bombData.newSpritePath = mod.GravityBombs.RocketSpritePathScatterBlood
				elseif bomb:HasTearFlags(TearFlags.TEAR_GHOST_BOMB) then
					bombData.newSpritePath = mod.GravityBombs.RocketSpritePathScatterGhost
				elseif bomb:HasTearFlags(TearFlags.TEAR_GLITTER_BOMB) then
					bombData.newSpritePath = mod.GravityBombs.RocketSpritePathScatterGlitter
				elseif bomb:HasTearFlags(TearFlags.TEAR_STICKY) then
					bombData.newSpritePath = mod.GravityBombs.RocketSpritePathScatterWebb
				elseif bomb:HasTearFlags(TearFlags.TEAR_BUTT_BOMB) then
					bombData.newSpritePath = mod.GravityBombs.RocketSpritePathScatterButt
				elseif bombData.Frosty then
					bombData.newSpritePath = mod.GravityBombs.RocketSpritePathScatterCube
				elseif bomb:HasTearFlags(TearFlags.TEAR_CROSS_BOMB) then
					bombData.newSpritePath = mod.GravityBombs.RocketSpritePathScatterBomber
				elseif bomb:HasTearFlags(TearFlags.TEAR_POISON) then
					bombData.newSpritePath = mod.GravityBombs.RocketSpritePathScatterPoison
				end
			elseif bomb:HasTearFlags(TearFlags.TEAR_BLOOD_BOMB) then
				bombData.newSpritePath = mod.GravityBombs.RocketSpritePathBlood
			elseif bomb:HasTearFlags(TearFlags.TEAR_GHOST_BOMB) then
				bombData.newSpritePath = mod.GravityBombs.RocketSpritePathGhost
			elseif bomb:HasTearFlags(TearFlags.TEAR_GLITTER_BOMB) then
				bombData.newSpritePath = mod.GravityBombs.RocketSpritePathGlitter
			elseif bomb:HasTearFlags(TearFlags.TEAR_STICKY) then
				bombData.newSpritePath = mod.GravityBombs.RocketSpritePathWebb
			elseif bomb:HasTearFlags(TearFlags.TEAR_BUTT_BOMB) then
				bombData.newSpritePath = mod.GravityBombs.RocketSpritePathButt
			elseif bombData.Frosty then
				bombData.newSpritePath = mod.GravityBombs.RocketSpritePathCube
			elseif bomb:HasTearFlags(TearFlags.TEAR_CROSS_BOMB) then
				bombData.newSpritePath = mod.GravityBombs.RocketSpritePathBomber
			elseif bomb:HasTearFlags(TearFlags.TEAR_POISON) then
				bombData.newSpritePath = mod.GravityBombs.RocketSpritePathPoison
			end
		elseif bomb:HasTearFlags(TearFlags.TEAR_BRIMSTONE_BOMB) then
			bombData.newSpritePath = mod.GravityBombs.BrimSpritePath
		elseif bomb:HasTearFlags(TearFlags.TEAR_SCATTER_BOMB) then
			bombData.newSpritePath = mod.GravityBombs.ScatterSpritePath
			--scatters
			if bomb:HasTearFlags(TearFlags.TEAR_BLOOD_BOMB) then
				bombData.newSpritePath = mod.GravityBombs.ScatterSpritePathBlood
			elseif bomb:HasTearFlags(TearFlags.TEAR_GHOST_BOMB) then
				bombData.newSpritePath = mod.GravityBombs.ScatterSpritePathGhost
			elseif bomb:HasTearFlags(TearFlags.TEAR_GLITTER_BOMB) then
				bombData.newSpritePath = mod.GravityBombs.ScatterSpritePathGlitter
			elseif bomb:HasTearFlags(TearFlags.TEAR_STICKY) then
				bombData.newSpritePath = mod.GravityBombs.ScatterSpritePathWebb
			elseif bomb:HasTearFlags(TearFlags.TEAR_BUTT_BOMB) then
				bombData.newSpritePath = mod.GravityBombs.ScatterSpritePathButt
			elseif bombData.Frosty then
				bombData.newSpritePath = mod.GravityBombs.CubeSpritePathScatter
			elseif bomb:HasTearFlags(TearFlags.TEAR_CROSS_BOMB) then
				bombData.newSpritePath = mod.GravityBombs.ScatterSpritePathBomber
			elseif bomb:HasTearFlags(TearFlags.TEAR_POISON) then
				bombData.newSpritePath = mod.GravityBombs.ScatterSpritePathPoison
			end
		elseif bombData.Frosty then
			bombData.newSpritePath = mod.GravityBombs.CubeSpritePath
			--cubes
			if bomb:HasTearFlags(TearFlags.TEAR_BLOOD_BOMB) then
				bombData.newSpritePath = mod.GravityBombs.CubeSpritePathBlood
			elseif bomb:HasTearFlags(TearFlags.TEAR_GHOST_BOMB) then
				bombData.newSpritePath = mod.GravityBombs.CubeSpritePathGhost
			elseif bomb:HasTearFlags(TearFlags.TEAR_GLITTER_BOMB) then
				bombData.newSpritePath = mod.GravityBombs.CubeSpritePathGlitter
			elseif bomb:HasTearFlags(TearFlags.TEAR_STICKY) then
				bombData.newSpritePath = mod.GravityBombs.CubeSpritePathWebb
			elseif bomb:HasTearFlags(TearFlags.TEAR_BUTT_BOMB) then
				bombData.newSpritePath = mod.GravityBombs.CubeSpritePathButt
			elseif bomb:HasTearFlags(TearFlags.TEAR_CROSS_BOMB) then
				bombData.newSpritePath = mod.GravityBombs.CubeSpritePathBomber
			elseif bomb:HasTearFlags(TearFlags.TEAR_POISON) then
				bombData.newSpritePath = mod.GravityBombs.CubeSpritePathPoison
			end
		else
			bombData.newSpritePath = mod.GravityBombs.SpritePath
			if bomb:HasTearFlags(TearFlags.TEAR_BLOOD_BOMB) then
				bombData.newSpritePath = mod.GravityBombs.BloodSpritePath
			elseif bomb:HasTearFlags(TearFlags.TEAR_BUTT_BOMB) then
				bombData.newSpritePath = mod.GravityBombs.ButtSpritePath
			elseif bomb:HasTearFlags(TearFlags.TEAR_CROSS_BOMB) then
				bombData.newSpritePath = mod.GravityBombs.BomberSpritePath
			elseif bomb:HasTearFlags(TearFlags.TEAR_GHOST_BOMB) then
				bombData.newSpritePath = mod.GravityBombs.GhostSpritePath
			elseif bomb:HasTearFlags(TearFlags.TEAR_GLITTER_BOMB) then
				bombData.newSpritePath = mod.GravityBombs.GlitterSpritePath
			elseif bomb:HasTearFlags(TearFlags.TEAR_STICKY) then
				bombData.newSpritePath = mod.GravityBombs.WebbSpritePath
			elseif bomb:HasTearFlags(TearFlags.TEAR_POISON) then
				bombData.newSpritePath = mod.GravityBombs.PoisonSpritePath
			end
		end
	end
	sfx:Play(SoundEffect.SOUND_BLOOD_LASER_LARGE,_,_,_,0.2,0)
	local holeEffect = Isaac.Spawn(EntityType.ENTITY_EFFECT, mod.GravityBombs.BlackHoleEffect, 0, bomb.Position, Vector.Zero, nil):ToEffect()
	holeData = holeEffect:GetData()
	holeEffect.Parent = bomb
	holeEffect.DepthOffset = -100
	holeEffect:SetColor(Color(0,0,0,1,0,0,0), 2000, 1, false, false)
	holeData.Gravity = true
	holeData.GravityForce = mod.GravityBombs.AttractorForce
	holeData.GravityRange = mod.GravityBombs.AttractorRange
	holeData.GravityGridRange = mod.GravityBombs.AttractorGridRange
end
-- add desired wisp of item if you have book of virtues
function mod:onAnyItem(item, _, player, useFlag) --item, rng, player, useFlag, activeSlot, customVarData
	--- activates on any item use. checks if it's mod item and player has book of virtues
	if mod.ActiveItemWisps[item] and player:HasCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_VIRTUES) and useFlag & myUseFlags ~= myUseFlags then
		--:AddWisp(Collectible, Position, AdjustOrbitLayer, DontUpdate)
		player:AddWisp(mod.ActiveItemWisps[item], player.Position, false, false)--:ToFamiliar()
	end
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.onAnyItem)
-- spawn item in position with option index
local function SpawnMyItem(poolType, position, optionIndex)
	--- if in isaac's room
	--- spawn item in position with option index
	optionIndex = optionIndex or 0
	local collectible = itemPool:GetCollectible(poolType)
	local item = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, collectible, position, Vector.Zero, nil):ToPickup()
	item.OptionsPickupIndex = optionIndex
end
-- set spawn 3 items with option index
local function SpawnOptionItems(itemPoolType, optionIndex, position)
	--- spawn 3 items
	position = position or game:GetRoom():GetCenterPos()
	local leftPosition = Isaac.GetFreeNearPosition(Vector(position.X-80,position.Y), 40) -- rework to get room center?
	local centPosition = Isaac.GetFreeNearPosition(position, 40)
	local righPosition = Isaac.GetFreeNearPosition(Vector(position.X+80,position.Y), 40)
	SpawnMyItem(itemPoolType, leftPosition, optionIndex)
	SpawnMyItem(itemPoolType, centPosition, optionIndex)
	SpawnMyItem(itemPoolType, righPosition, optionIndex)
end
---Book of Memories
--[[
local function MemoryBookManager(rng, player)
	--- save effect to book of memories dict
	--- if returns true - removes book and spawn memory fragment and oblivion card
	local data = player:GetData()
	local memTable = {}
	if data.MemoryBoolPool then -- i can't check how many items there. cause using -> table[key] = value
		if data.MemoryBoolPool.Items then
			for item, value in pairs(data.MemoryBoolPool.Items) do
				if value then table.insert(memTable, {100, item}) end
			end
		end
		if data.MemoryBoolPool.Cards then
			for card, value in pairs(data.MemoryBoolPool.Cards) do
				if value then table.insert(memTable, {300, card}) end
			end
		end
		if data.MemoryBoolPool.Pills then
			for pill, value in pairs(data.MemoryBoolPool.Pills) do
				if value then table.insert(memTable, {70, pill}) end
			end
		end

		if #memTable > 0 then
			local subTable = memTable[rng:RandomInt(#memTable)+1]
			local var = subTable[1]
			local sub = subTable[2]
			if var == 100 then
				player:UseActiveItem(sub, myUseFlags)
				data.MemoryBoolPool.Items[sub] = false
			elseif var == 300 then
				player:UseCard(sub, myUseFlags)
				data.MemoryBoolPool.Cards[sub] = false
			elseif var == 70 then
				player:UsePill(sub, 0, myUseFlags)
				data.MemoryBoolPool.Pills[sub] = false
			end
			return false
		end
	end
	return true
end
--]]
---Nadab's Brain
local function BrainExplosion(player, fam)
	local bombDamage = 100
	local bombRadiusMult = 1
	if player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS) then
		bombDamage = 185
		game:ShakeScreen(10)
	end
	local bombFlags = TearFlags.TEAR_BURN | player:GetBombFlags()
	game:BombExplosionEffects(fam.Position, bombDamage, bombFlags, Color.Default, fam, bombRadiusMult, true, false, DamageFlag.DAMAGE_EXPLOSION)
end
local function GetVelocity(player)
	local newVector = player:GetShootingInput()
	local newVelocity = newVector + player:GetTearMovementInheritance(newVector)
	newVelocity:Normalize()
	return newVelocity
end
local function NadabBrainReset(fam)
    local famData = fam:GetData()
    fam.CollisionDamage = 0
    CheckForParent(fam)
    famData.IsFloating = false
    famData.isReady = false
    famData.Collided = false
end
---Dead Egg
local function DeadEggEffect(player, pos, timeout)
	--- spawn dead bird
	if player:HasTrinket(mod.Trinkets.DeadEgg) then
		local birdy = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.DEAD_BIRD, 0, pos, Vector.Zero, nil):ToEffect()
		birdy:SetColor(Color(0,0,0,1,0,0,0),timeout,1, false, false)
		birdy:SetTimeout(timeout)
		birdy.SpriteScale = Vector.One *0.7
		birdy:GetData().DeadEgg = true
	end
end
---Adrenaline Card
local function AdrenalineManager(player, redHearts, num)
	--- turn your hearts into batteries
	local j = 0
	while redHearts > num do
		DebugSpawn(PickupVariant.PICKUP_LIL_BATTERY, BatterySubType.BATTERY_NORMAL, player.Position)
		redHearts = redHearts-2
		j = j+2
	end
	player:AddHearts(-j)
end
---Unbidden
local function AddItemFromWisp(player, add, kill, stop)
	local itemWisps = Isaac.FindInRadius(player.Position, mod.UnbiddenData.RadiusWisp, EntityPartition.FAMILIAR)
	if #itemWisps > 0 then
		for _, witem in pairs(itemWisps) do
			if witem.Variant == FamiliarVariant.ITEM_WISP then
				sfx:Play(SoundEffect.SOUND_THUMBSUP)
				if add then
					player:AddCollectible(witem.SubType)
				end
				if kill then
					witem:Kill()
					witem:Remove()
				end
				if stop then
					return witem.SubType
					--break
				end
			end
		end
	
	end
end
---Soul of Unbidden
local function SpawnItemWisps(player)
	local items = Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE)
	if #items > 0 then
		--sfx:Play(579)
		for _, item in pairs(items) do
			if item.SubType ~= 0 and not CheckItemTags(item.SubType, ItemConfig.TAG_QUEST) then
				sfx:Play(579)
				player:AddItemWisp(item.SubType, item.Position)
			end
		end
	end
end
---Mongo Cells
local function AddFamiliarEffect(player, pointer, babyItem, effectItem)
	local tempEffects = player:GetEffects()
	if not pointer and (player:HasCollectible(babyItem) or tempEffects:HasCollectibleEffect(babyItem)) then
		pointer = true
		tempEffects:AddCollectibleEffect(effectItem, false)
	elseif pointer and not player:HasCollectible(babyItem) and not tempEffects:HasCollectibleEffect(babyItem) then
		pointer = false
		tempEffects:RemoveCollectibleEffect(effectItem)
	end
	return pointer
end
--- LOCAL FUNCTIONS --

--- MOD CALLBACKS --
-- callback
--- GAME EXIT --
function mod:onExit(isContinue)
	if isContinue then
		savetable.OblivionCardErasedEntities = mod.OblivionCard.ErasedEntities
		savetable.LobotomyErasedEntities = mod.Lobotomy.ErasedEntities
		savetable.MidasCurseTurnGoldChance = mod.MidasCurse.TurnGoldChance
		savetable.DemonSpawn = {} -- mod.Lililith.DemonSpawn
		savetable.MidasCurseActive = {}
		savetable.DuckCurrentLuck = {}
		savetable.RedPillDamageUp = {}
		savetable.UsedBG = {}
		savetable.LimbActive = {}
		savetable.HasItemGravityBombs = {}
		savetable.ModdedBombas = {}
		savetable.StateDamaged = {}
		savetable.RedLotusDamage = {}
		savetable.KarmaStats = {}

		--savetable.MemoryBoolPool = {}

		if mod.OutOfMap then
			mod.OutOfMap = nil
			print("[Oblivion Card mod] You was in Out of Map Room. Now you can Exit")
			Isaac.ExecuteCommand('rewind')
			--game:GetPlayer(0):UseActiveItem(CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS, myUseFlags) -- else it crashes when you in out of map rooms
			--game:GetPlayer(0):UseCard(1, myUseFlags)
			--game:GetHUD():ShowFortuneText("You was in Out of Map Room", "Now you can Exit")
		end

		for playerNum = 0, game:GetNumPlayers()-1 do
			local player = game:GetPlayer(playerNum)
			local data = player:GetData()
			local idx = getPlayerIndex(player)
			--if data.HasItemBirthright then savetable.HasItemBirthright[idx] = data.HasItemBirthright end

			if data.LililithDemonSpawn then
				savetable.DemonSpawn[idx] = data.LililithDemonSpawn
			end
			if player:HasCollectible(mod.Items.MidasCurse) then
				savetable.MidasCurseActive[idx] = {data.GoldenHeartsAmount, data.HasItemMidasCurse}
			end
			if player:HasCollectible(mod.Items.RubberDuck) then
				savetable.DuckCurrentLuck[idx] = {data.DuckCurrentLuck, data.HasItemRubberDuck}
			end
			if data.RedPillDamageUp then
				savetable.RedPillDamageUp[idx] = {data.RedPillDamageUp, data.RedPillDamageDown}
				--savetable.RedPillDamageUp[idx][1] = data.RedPillDamageUp
				--savetable.RedPillDamageUp[idx][2] = data.RedPillDamageDown
			end
			if data.UsedBG then
				savetable.UsedBG[idx] = data.UsedBG
			end
			if data.LimbActive then
				savetable.LimbActive[idx] = data.LimbActive
			end
			if data.HasItemGravityBombs then
				savetable.HasItemGravityBombs[idx] = data.HasItemGravityBombs
			end
			if data.ModdedBombas then
				savetable.ModdedBombas[idx] = data.ModdedBombas
			end
			if data.StateDamaged then
				savetable.StateDamaged[idx] = data.StateDamaged
			end
			if data.RedLotusDamage then
				savetable.RedLotusDamage[idx] = data.RedLotusDamage
			end
			if data.KarmaStats then
				savetable.KarmaStats[idx] = data.KarmaStats
			end
			--[[
			if data.MemoryBoolPool then
				savetable.MemoryBoolPool[idx] = data.MemoryBoolPool
			end
			--]]
		end
	end
	modDataSave()
end
mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, mod.onExit)
--- GAME START --
function mod:onStart(isSave)

	--- load mod save data; if debug, spawn mod items
	if isSave and mod:HasData() then -- continue game
		local localtable = json.decode(mod:LoadData())
		mod.OblivionCard.ErasedEntities = localtable.OblivionCardErasedEntities
		mod.Lobotomy.ErasedEntities = localtable.LobotomyErasedEntities
		mod.MidasCurse.TurnGoldChance = localtable.MidasCurseTurnGoldChance

		--[[
		for playerNum = 0, game:GetNumPlayers()-1 do
			local player = game:GetPlayer(playerNum)
			local data = player:GetData()
			local idx = getPlayerIndex(player)
			if player:HasCollectible(mod.Items.Lililith) then
				data.LililithDemonSpawn = localtable.DemonSpawn[idx] -- mod.Lililith.DemonSpawn
			end
		end
		--]]

	elseif not isSave then -- new game
		InitCall()
		if debug then
			InitDebugCall() -- spawn mod items for test
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.onStart)
--- PLAYER INIT --
function mod:onPlayerInit(player)
	local data = player:GetData()
	local idx = getPlayerIndex(player)
	local toPlayers = #Isaac.FindByType(EntityType.ENTITY_PLAYER)

	if toPlayers == 0 then
		modRNG:SetSeed(game:GetSeeds():GetStartSeed(), RECOMMENDED_SHIFT_IDX)
		modDataLoad()
	end

	if mod:HasData() then
		local localtable = json.decode(mod:LoadData())

		if player:HasCollectible(mod.Items.Lililith) then
			data.LililithDemonSpawn = localtable.DemonSpawn[idx] -- mod.Lililith.DemonSpawn
		end

		if player:HasCollectible(mod.Items.MidasCurse) then
			data.HasItemMidasCurse = localtable.MidasCurseActive[idx][2]
			data.GoldenHeartsAmount = localtable.MidasCurseActive[idx][1]
		end
		if player:HasCollectible(mod.Items.RubberDuck) then
			data.HasItemRubberDuck = localtable.DuckCurrentLuck[idx][2]
			EvaluateDuckLuck(player, localtable.DuckCurrentLuck[idx][1])
		end

		if localtable.RedPillDamageUp then
			if localtable.RedPillDamageUp[idx] then
				data.RedPillDamageUp = localtable.RedPillDamageUp[idx][1]
				data.RedPillDamageDown = localtable.RedPillDamageUp[idx][2]
				player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
				player:EvaluateItems()
			end
		end

		if localtable.UsedBG then
			data.UsedBG = localtable.UsedBG[idx]
		end
		if localtable.LimbActive then
			data.LimbActive = localtable.LimbActive[idx]
		end
		if localtable.HasItemGravityBombs then
			data.HasItemGravityBombs = localtable.HasItemGravityBombs[idx]
		end
		if localtable.ModdedBombas then
			data.ModdedBombas = localtable.ModdedBombas[idx]
		end
		if localtable.StateDamaged then
			data.StateDamaged = localtable.StateDamaged[idx]
		end
		if localtable.RedLotusDamage then
			data.RedLotusDamage = localtable.RedLotusDamage[idx]
		end
		if localtable.KarmaStats then
			data.KarmaStats = localtable.KarmaStats[idx]
		end
		--[[
		if localtable.MemoryBoolPool then
			data.MemoryBoolPool = localtable.MemoryBoolPool[idx]
		end
		--]]
		--[[
		if localtable.UsedLobotomyCount then
			data.UsedLobotomyCount = localtable.UsedLobotomyCount[idx]
		end
		--]]
		if localtable.HasItemBirthright then
			if not savetable.HasItemBirthright then savetable.HasItemBirthright = {} end
			savetable.HasItemBirthright[idx] = localtable.HasItemBirthright[idx]
		end
		--if localtable.HasItemBirthright[idx] then data.HasItemBirthright = localtable.HasItemBirthright[idx] end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.onPlayerInit)

--- EVAL_CACHE --
function mod:onCache(player, cacheFlag)
	player = player:ToPlayer()
	local data = player:GetData()
	if cacheFlag == CacheFlag.CACHE_LUCK then
		if player:HasCollectible(mod.Items.RubberDuck) and data.DuckCurrentLuck then
			player.Luck = player.Luck + data.DuckCurrentLuck
		end
		if player:HasCollectible(mod.Items.VoidKarma) and data.KarmaStats then
			player.Luck = player.Luck + data.KarmaStats.Luck
		end
		if data.DeuxExLuck then
			player.Luck = player.Luck + data.DeuxExLuck
		end
	end
	if cacheFlag == CacheFlag.CACHE_DAMAGE then
		if data.RedPillDamageUp then
			player.Damage = player.Damage + data.RedPillDamageUp
		end
		if data.RedLotusDamage then -- save damage even if you removed item
			player.Damage = player.Damage + data.RedLotusDamage
		end
		if player:HasCollectible(mod.Items.VoidKarma) and data.KarmaStats then
			player.Damage = player.Damage + data.KarmaStats.Damage
		end
	end
	if cacheFlag == CacheFlag.CACHE_FIREDELAY then
		if player:HasCollectible(mod.Items.VoidKarma) and data.KarmaStats then
			player.MaxFireDelay = player.MaxFireDelay + data.KarmaStats.Firedelay
		end
	end
	if cacheFlag == CacheFlag.CACHE_SHOTSPEED then
		if player:HasCollectible(mod.Items.VoidKarma) and data.KarmaStats then
			player.ShotSpeed = player.ShotSpeed + data.KarmaStats.Shotspeed
		end
	end
	if cacheFlag == CacheFlag.CACHE_RANGE then
		if player:HasCollectible(mod.Items.VoidKarma) and data.KarmaStats then
			player.TearRange = player.TearRange + data.KarmaStats.Range
		end
	end
	if cacheFlag == CacheFlag.CACHE_SPEED then
		if player:HasCollectible(mod.Items.MiniPony) then --and player.MoveSpeed < mod.MiniPony.MoveSpeed then
			player.MoveSpeed = mod.MiniPony.MoveSpeed
		end
		if player:HasCollectible(mod.Items.VoidKarma) and data.KarmaStats then
			player.MoveSpeed = player.MoveSpeed + data.KarmaStats.Speed
		end
	end
	if cacheFlag == CacheFlag.CACHE_FAMILIARS then
		-- red bags
		local bags = GetItemsCount(player, mod.Items.RedBag)
		if bags > 0 then
			player:CheckFamiliar(mod.RedBag.Variant, bags, RNG(), Isaac.GetItemConfig():GetCollectible(mod.Items.RedBag))
		end
		-- lililiths
		local lililiths = GetItemsCount(player, mod.Items.Lililith)
		if lililiths > 0 then
			player:CheckFamiliar(mod.Lililith.Variant, lililiths, RNG(), Isaac.GetItemConfig():GetCollectible(mod.Items.Lililith))
		end
		-- abihu familiars
		--if player:HasCollectible(mod.Items.AbihuFam) then
			--- if you ask why it's complicated
			--- this shit dances for just to check when you have both abihu with punching bag
			--- cause IDK HOW to add decoy effect to entity. else I would just make new familiar entity
			--- and for some reason punching bag subtype is his state. 0 - idle. 1 - walking. >2 - reacts on near enemies
		local punches = GetItemsCount(player, CollectibleType.COLLECTIBLE_PUNCHING_BAG)
		local profans = GetItemsCount(player, mod.Items.AbihuFam)
		if punches>0 then
			if player:HasCollectible(mod.Items.AbihuFam) then
				--HasSubtype(player, punches, mod.AbihuFam.Variant, CollectibleType.COLLECTIBLE_PUNCHING_BAG)
				local entities2 = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, mod.AbihuFam.Variant, _, true, false)
				for _, punch in pairs(entities2) do
					punch:Remove()
				end
				player:CheckFamiliar(mod.AbihuFam.Variant, punches, RNG(), Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_PUNCHING_BAG), 0)
				--player:CheckFamiliar(mod.AbihuFam.Variant, profans, RNG(), Isaac.GetItemConfig():GetCollectible(mod.Items.AbihuFam), mod.AbihuFam.Subtype)
			end
		end
		if profans > 0 then
			player:CheckFamiliar(mod.AbihuFam.Variant, profans, RNG(), Isaac.GetItemConfig():GetCollectible(mod.Items.AbihuFam), mod.AbihuFam.Subtype)
		end
		local brains = GetItemsCount(player, mod.Items.NadabBrain)
		if brains > 0 then
			player:CheckFamiliar(mod.NadabBrain.Variant, brains, RNG(), Isaac.GetItemConfig():GetCollectible(mod.Items.NadabBrain))
		end
	end

	if cacheFlag == CacheFlag.CACHE_TEARCOLOR then
		if player:HasCollectible(mod.Items.MeltedCandle) then
			player.TearColor = mod.MeltedCandle.TearColor
		end
	end

	if cacheFlag == CacheFlag.CACHE_FLYING then
		if player:HasCollectible(mod.Items.MiniPony) or player:HasCollectible(mod.Items.LongElk) or player:HasCollectible(mod.Items.Viridian) or player:HasCollectible(mod.Items.MewGen) then
			player.CanFly = true
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.onCache)
--- PLAYER TAKE DMG --
function mod:onPlayerTakeDamage(entity, _, flags) --entity, amount, flags, source, countdown
	local player = entity:ToPlayer()
	local data = player:GetData()
	--- soul of nadab and abihu
	if data.UsedSoulNadabAbihu then
		if (flags & DamageFlag.DAMAGE_FIRE ~= 0) or (flags & DamageFlag.DAMAGE_EXPLOSION ~= 0) then return false end
	end
	if not player:HasCurseMistEffect() and not player:IsCoopGhost() then
		--- mongo cells
		if player:HasCollectible(mod.Items.MongoCells) and (flags & DamageFlag.DAMAGE_NO_PENALTIES == 0) and (flags & DamageFlag.DAMAGE_RED_HEARTS == 0) then
			local rng = player:GetCollectibleRNG(mod.Items.MongoCells)
			if player:HasCollectible(CollectibleType.COLLECTIBLE_DRY_BABY) or tempEffects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_DRY_BABY) then
				if rng:RandomFloat() < mod.MongoCells.DryBabyChance then
					player:UseActiveItem(CollectibleType.COLLECTIBLE_NECRONOMICON, myUseFlags)
				end
			end
			if player:HasCollectible(CollectibleType.COLLECTIBLE_FARTING_BABY) or tempEffects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_FARTING_BABY) then
				if rng:RandomFloat() < mod.MongoCells.DryBabyChance then
					local bean = mod.MongoCells.FartBabyBeans[rng:RandomInt(#mod.MongoCells.FartBabyBeans)+1]
					player:UseActiveItem(bean, myUseFlags)
				end
			end
			if player:HasCollectible(CollectibleType.COLLECTIBLE_BBF) or tempEffects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_BBF) then
				game:BombExplosionEffects(player.Position, mod.MongoCells.BBFDamage, player:GetBombFlags(), Color.Default, player, 1, true, false, DamageFlag.DAMAGE_EXPLOSION)
			end
			if player:HasCollectible(CollectibleType.COLLECTIBLE_BOBS_BRAIN) or tempEffects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_BOBS_BRAIN) then
				game:BombExplosionEffects(player.Position, mod.MongoCells.BBFDamage, player:GetBombFlags(), Color.Default, player, 1, true, false, DamageFlag.DAMAGE_EXPLOSION)
				local cloud = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.SMOKE_CLOUD, 0, player.Position, Vector.Zero, player):ToEffect()
				cloud:SetTimeout(150)
			end
			if player:HasCollectible(CollectibleType.COLLECTIBLE_HOLY_WATER) or tempEffects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_WATER) then
				Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_HOLYWATER, 0, player.Position, Vector.Zero, player):SetColor(Color(1,1,1,0), 5, 1, false, false)
			end
			if player:HasCollectible(CollectibleType.COLLECTIBLE_DEPRESSION) or tempEffects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_DEPRESSION) then
				if rng:RandomFloat() < mod.MongoCells.DepressionLightChance then
					Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CRACK_THE_SKY, 0, player.Position, Vector.Zero, player)
				end
			end
			if player:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_RAZOR) or tempEffects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_MOMS_RAZOR) then
				player:AddEntityFlags(EntityFlag.FLAG_BLEED_OUT)
			end
		end
		--- lost flower
		if player:HasTrinket(mod.Trinkets.LostFlower) then -- remove lost flower if get hit
			if (flags & DamageFlag.DAMAGE_NO_PENALTIES == 0) and (flags & DamageFlag.DAMAGE_RED_HEARTS == 0) then
				RemoveThrowTrinket(player, mod.Trinkets.LostFlower, mod.LostFlower.DespawnTimer)
			end
		end
		--- RubikCubelet: TMTRAINER + D6
		if player:HasTrinket(mod.Trinkets.RubikCubelet) then
			if player:GetTrinketRNG(mod.Trinkets.RubikCubelet):RandomFloat() < mod.RubikCubelet.TriggerChance then
				RerollTMTRAINER(player)
				--sfx:Play(SoundEffect.SOUND_DICE_SHARD)
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.onPlayerTakeDamage, EntityType.ENTITY_PLAYER)
--- PLAYER PEFFECT --
function mod:onPEffectUpdate(player)
	local level = game:GetLevel()
	local room = game:GetRoom()
	local data = player:GetData()
	local sprite = player:GetSprite()
	local tempEffects = player:GetEffects()

	-- infinite blades
	if data.InfiniteBlades and player:GetMovementDirection() ~= -1 then -- player:GetShootingInput() ~= -1
		if data.InfiniteBlades <= 0 then
			data.InfiniteBlades = nil
		elseif game:GetFrameCount() %4 == 0 then -- shoot every 4th frame
			data.InfiniteBlades = data.InfiniteBlades - 1
			local rotationOffset = player:GetMovementInput()
			local newV = player:GetMovementInput()  * mod.InfiniteBlades.VelocityMulti

			local knife = player:FireTear(player.Position, newV, false, true, false, nil, mod.InfiniteBlades.DamageMulti):ToTear()
			knife:AddTearFlags(TearFlags.TEAR_PIERCING | TearFlags.TEAR_SPECTRAL)
			knife.Visible = false

			local knifeData = knife:GetData()
			knifeData.KnifeTear = true
			knifeData.InitVelocity = newV
			knifeData.InitAngle = rotationOffset

			local knifeSprite = knife:GetSprite()
			knifeSprite:ReplaceSpritesheet(0, mod.InfiniteBlades.newSpritePath)
			knifeSprite:LoadGraphics()

		end
	end

	--moonlighter mirror
	if data.KeeperMirror then
		local up = Input.IsActionPressed(ButtonAction.ACTION_SHOOTUP, player.ControllerIndex)
		local down = Input.IsActionPressed(ButtonAction.ACTION_SHOOTDOWN, player.ControllerIndex)
		local left = Input.IsActionPressed(ButtonAction.ACTION_SHOOTLEFT, player.ControllerIndex)
		local right = Input.IsActionPressed(ButtonAction.ACTION_SHOOTRIGHT, player.ControllerIndex)
		local isMoving = (down or right or left or up)
		if data.KeeperMirror.Timeout > 0 and data.KeeperMirror:Exists() and not player:IsCoopGhost() then
			local targetData = data.KeeperMirror:GetData()
			if not targetData.MovementVector then targetData.MovementVector = Vector.Zero end
			if not (left or right) then targetData.MovementVector.X = 0 end
			if not (up or down) then targetData.MovementVector.Y = 0 end
			if left and not right then targetData.MovementVector.X = -1
			elseif right then targetData.MovementVector.X = 1 end
			if up and not down then targetData.MovementVector.Y = -1
			elseif down then targetData.MovementVector.Y = 1 end
			if room:IsMirrorWorld() then targetData.MovementVector.X = targetData.MovementVector.X * -1 end
			if not isMoving then
				--targetSprite:Play("Blink")
				local radiusTable = Isaac.FindInRadius(data.KeeperMirror.Position, mod.KeeperMirror.TargetRadius, EntityPartition.PICKUP)
				--print("pickups",#radiusTable)
				if #radiusTable > 0 then
					if data.KeeperMirror.Timeout <= mod.KeeperMirror.TargetTimeout then
						local coins = 0
						for _, pickup in pairs(radiusTable) do
							if pickup:ToPickup() then
								pickup = pickup:ToPickup()
								coins = SellItems(pickup, player)
								if coins ~= 0 then
									if coins > 0 then
										for _ = 1, coins do
											local randVector = RandomVector()*5
											Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_PENNY, pickup.Position, randVector, player)
										end
									end
									pickup:Remove()
									Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, pickup.Position, Vector.Zero, nil):SetColor(Color(0,1.5,1.3,1,0,0,0), 50, 1, false, false)
									data.KeeperMirror:Remove()
									data.KeeperMirror = nil
									break
								end
							end
						end
					end
				end
			else
				data.KeeperMirror.Velocity = data.KeeperMirror.Velocity + UnitVector(targetData.MovementVector):Resized(player.MoveSpeed + 2)
			end
		else
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_PENNY, data.KeeperMirror.Position, Vector.Zero, player)
			Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, data.KeeperMirror.Position, Vector.Zero, nil):SetColor(Color(0,1.5,1.3,1,0,0,0), 50, 1, false, false)
			data.KeeperMirror:Remove()
			data.KeeperMirror = nil
		end
	end

	--domino 25
	if data.Domino25Used then
		data.Domino25Used = data.Domino25Used - 1
		if data.Domino25Used <= 0 then
			for _, enemy in pairs(Isaac.FindInRadius(room:GetCenterPos(), 5000, EntityPartition.ENEMY)) do
				if enemy:IsVulnerableEnemy() and enemy:IsActiveEnemy() then
					game:RerollEnemy(enemy)
				end
			end
			data.Domino25Used = nil
		end
	end
	---maze of memory
	if data.MazeMemoryUsed then
		if data.MazeMemoryUsed[1] then
			if data.MazeMemoryUsed[1] > 0 then
				data.MazeMemoryUsed[1] = data.MazeMemoryUsed[1] - 1
			elseif data.MazeMemoryUsed[1] == 0 then
				data.MazeMemoryUsed[1] = data.MazeMemoryUsed[1] - 1
				mod.OutOfMap = true
				Isaac.ExecuteCommand("goto s.treasure.0")
			elseif data.MazeMemoryUsed[1] < 0 then
				game:ShowHallucination(0, BackdropType.DARK_CLOSET)
				if sfx:IsPlaying(SoundEffect.SOUND_DEATH_CARD) then
					sfx:Stop(SoundEffect.SOUND_DEATH_CARD)
				end
				data.MazeMemoryUsed[1] = nil

				local index = 30
				local counter = 6
				--itemPool:ResetRoomBlacklist()

				while index <= 102 do
					index = index+2
					counter = counter - 1
					if counter >= 0 then
						local pos = room:GetGridPosition(index)
						--local item = 0
						local rng = RNG()
						rng:SetSeed(Random(), 1)
						local pool = rng:RandomInt(ItemPoolType.NUM_ITEMPOOLS)
						local item = itemPool:GetCollectible(pool, false, Random(), 0)
						Isaac.Spawn(5, 100, item, pos, Vector.Zero, nil):ToPickup().OptionsPickupIndex = 88888
					else
						index = index + 16
						counter = 6
					end
				end
			end
		elseif data.MazeMemoryUsed[2] then
			local roomitems = 0
			local rent = room:GetEntities()
			for ient = 0, #rent-1 do
				local ent = rent:Get(ient)
				if ent and ent:ToPickup() and ent:ToPickup().Variant == 100 then
					roomitems = roomitems + 1
				end
			end
			if roomitems < data.MazeMemoryUsed[2] then
				data.Transit = 25
				data.MazeMemoryUsed = nil
			elseif roomitems > data.MazeMemoryUsed[2] then
				data.MazeMemoryUsed[2] = roomitems
			end
		end
	end
	if data.Transit then
		data.Transit = data.Transit - 1
		if data.Transit <= 0 then
			data.Transit = nil
			game:StartRoomTransition(level:GetStartingRoomIndex(), 1, RoomTransitionAnim.DEATH_CERTIFICATE, player, -1)
		end
	end

	if not player:HasCurseMistEffect() and not player:IsCoopGhost() then
		--- mongo cells
		if player:HasCollectible(mod.Items.MongoCells) then
			if game:GetFrameCount() %mod.MongoCells.HeadlessCreepFrame == 0 then
				if player:HasCollectible(CollectibleType.COLLECTIBLE_HEADLESS_BABY) or tempEffects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_HEADLESS_BABY) then
					Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_RED, 0, player.Position, Vector.Zero, player)
				end
			end
			if game:GetFrameCount() %mod.MongoCells.DepressionCreepFrame == 0 then
				if player:HasCollectible(CollectibleType.COLLECTIBLE_DEPRESSION) or tempEffects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_DEPRESSION) then
					creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_HOLYWATER_TRAIL, 0, player.Position, Vector.Zero, player):ToEffect()
					creep.SpriteScale = creep.SpriteScale * 0.1
				end
			end
			data.MongoSteven = AddFamiliarEffect(player, data.MongoSteven, CollectibleType.COLLECTIBLE_LITTLE_STEVEN, CollectibleType.COLLECTIBLE_SPOON_BENDER)
			data.MongoHarlequin = AddFamiliarEffect(player, data.MongoHarlequin, CollectibleType.COLLECTIBLE_HARLEQUIN_BABY, CollectibleType.COLLECTIBLE_THE_WIZ)
			data.MongoFreezer = AddFamiliarEffect(player, data.MongoFreezer, CollectibleType.COLLECTIBLE_FREEZER_BABY, CollectibleType.COLLECTIBLE_URANUS)
			data.MongoGhost = AddFamiliarEffect(player, data.MongoGhost, CollectibleType.COLLECTIBLE_GHOST_BABY, CollectibleType.COLLECTIBLE_OUIJA_BOARD)
			data.MongoAbel = AddFamiliarEffect(player, data.MongoAbel, CollectibleType.COLLECTIBLE_ABEL, CollectibleType.COLLECTIBLE_MY_REFLECTION)
			-- COLLECTIBLE_3_DOLLAR_BILL
			data.MongoRainbow = AddFamiliarEffect(player, data.MongoRainbow, CollectibleType.COLLECTIBLE_RAINBOW_BABY, CollectibleType.COLLECTIBLE_FRUIT_CAKE)
			data.MongoBrimstone = AddFamiliarEffect(player, data.MongoBrimstone, CollectibleType.COLLECTIBLE_LIL_BRIMSTONE, CollectibleType.COLLECTIBLE_BRIMSTONE)
			if GetItemsCount(player, CollectibleType.COLLECTIBLE_BALL_OF_BANDAGES) > 1 then
				data.MongoBallBandage = AddFamiliarEffect(player, data.MongoBallBandage, CollectibleType.COLLECTIBLE_BALL_OF_BANDAGES, CollectibleType.COLLECTIBLE_MOMS_EYESHADOW)
			end
			data.MongoHaunt = AddFamiliarEffect(player, data.MongoHaunt, CollectibleType.COLLECTIBLE_LIL_HAUNT, CollectibleType.COLLECTIBLE_MOMS_PERFUME)
			-- COLLECTIBLE_VENUS
			data.MongoSissy = AddFamiliarEffect(player, data.MongoSissy, CollectibleType.COLLECTIBLE_SISSY_LONGLEGS, CollectibleType.COLLECTIBLE_MOMS_WIG)
		end

		--- lililith
		if player:HasCollectible(mod.Items.Lililith) then
			data.LililithDemonSpawn = data.LililithDemonSpawn or mod.Lililith.DemonSpawn
		end
		--- Mew-Gen
		if player:HasCollectible(mod.Items.MewGen) then
			data.HasMewGen = data.HasMewGen or false
			if not data.HasMewGen then
				--add costume
			end
			if not player.CanFly then
				player:AddCacheFlags(CacheFlag.CACHE_FLYING)
				player:EvaluateItems()
			end
			MewGenManager(player)
		else
			if data.HasMewGen then
				--remove costume
			end
		end
		-- void karma
		if player:HasCollectible(mod.Items.VoidKarma) and level:GetStateFlag(LevelStateFlag.STATE_DAMAGED) and not data.StateDamaged then
			data.StateDamaged = 1 -- used as stat multiplier. without damage == 2
		end
		-- corruption
		if data.CorruptionIsActive and player:GetActiveItem(ActiveSlot.SLOT_PRIMARY) ~= 0 then
			local activeItem = player:GetActiveItem(ActiveSlot.SLOT_PRIMARY)
			if player:GetActiveCharge(ActiveSlot.SLOT_PRIMARY) < Isaac.GetItemConfig():GetCollectible(activeItem).MaxCharges then
				player:FullCharge(ActiveSlot.SLOT_PRIMARY, false)
			end
		end
		-- frosty tears for ice cube bombs / attractor tears for black hole bombs
		for _, bomb in pairs(Isaac.FindByType(4)) do -- bombs == 4
			bomb = bomb:ToBomb()
			if bomb:GetSprite():GetAnimation() == "Explode" then -- not mod.MirrorBombs.Ban[bomb.Variant]
				if bomb:GetData().Dicey then
					DiceyReroll(player:GetCollectibleRNG(mod.Items.DiceBombs), bomb.Position, mod.DiceBombs.AreaRadius)
				end
				if bomb:GetData().DeadEgg then
					DeadEggEffect(player, bomb.Position, mod.DeadEgg.Timeout)
				end
				--spawn particle
				if bomb:GetData().Frosty then
					game:SpawnParticles(bomb.Position, EffectVariant.DIAMOND_PARTICLE, 10, 5, Color(1,1,1,1,0.5,0.5,0.8))-- poofColor --ROCK_PARTICLE
				end
				if  bomb:HasTearFlags(TearFlags.TEAR_SAD_BOMB) then
					for _, tear in pairs(Isaac.FindInRadius(bomb.Position, 22, EntityPartition.TEAR)) do
						if tear.FrameCount == 1 then -- other tears can get this effects if you shoot tears near bomb (idk else how to get)
							tear = tear:ToTear()
							if bomb:GetData().Frosty then
								tear:ChangeVariant(TearVariant.ICE)
								tear:AddTearFlags(TearFlags.TEAR_SLOW | TearFlags.TEAR_ICE)
							end
						end
					end
				end
			end
		end
		-- black hole bombs
		if player:HasCollectible(mod.Items.GravityBombs) then
			if not data.HasItemGravityBombs then
				data.HasItemGravityBombs = 1
				player:AddGigaBombs(mod.GravityBombs.GigaBombs )
			end
			local numGravityBombs =  GetItemsCount(player, mod.Items.GravityBombs)
			if numGravityBombs ~= data.HasItemGravityBombs then
				if numGravityBombs > data.HasItemGravityBombs and GetItemsCount(player, mod.Items.GravityBombs)  ~= 0 then
					player:AddGigaBombs(mod.GravityBombs.GigaBombs)

				end
				data.HasItemGravityBombs =  GetItemsCount(player, mod.Items.GravityBombs)
			end
		else
			if data.HasItemGravityBombs then
				data.HasItemGravityBombs = nil
			end
		end
		--long elk
		if player:HasCollectible(mod.Items.LongElk) then
			if not data.HasLongElk then
				data.HasLongElk = true
				player:AddCacheFlags(CacheFlag.CACHE_FLYING)
				player:AddNullCostume(mod.LongElk.Costume)
				player:EvaluateItems()
			end

			if data.ElkKiller and not tempEffects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_MARS) then
				data.ElkKiller = false
			end

			if not data.BoneSpurTimer then
				data.BoneSpurTimer = mod.LongElk.BoneSpurTimer
			else
				if  data.BoneSpurTimer > 0 then
					data.BoneSpurTimer = data.BoneSpurTimer - 1
				end
			end
			if player:GetMovementDirection() ~= -1 and not room:IsClear() and data.BoneSpurTimer <= 0 then
				Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BONE_SPUR, 0, player.Position, Vector.Zero, player):ToFamiliar():GetData().RemoveTimer = mod.LongElk.BoneSpurTimer * mod.LongElk.NumSpur
				data.BoneSpurTimer = mod.LongElk.BoneSpurTimer
			end
		else
			if data.HasLongElk then
				data.HasLongElk = nil
				player:TryRemoveNullCostume(mod.LongElk.Costume)
				player:AddCacheFlags(CacheFlag.CACHE_FLYING)
				player:EvaluateItems()
			end
		end
		--mini-pony
		if player:HasCollectible(mod.Items.MiniPony) then
			if not data.HasMiniPony then
				data.HasMiniPony = true
				--player:AddCacheFlags(CacheFlag.CACHE_SIZE)
				player:AddCacheFlags(CacheFlag.CACHE_FLYING)
				player:AddCacheFlags(CacheFlag.CACHE_SPEED)
				player:AddNullCostume(mod.MiniPony.Costume)
				player:EvaluateItems()
			end
			if player.MoveSpeed < mod.MiniPony.MoveSpeed then
				player:AddCacheFlags(CacheFlag.CACHE_SPEED)
				player:EvaluateItems()
			end
		else
			if data.HasMiniPony then
				data.HasMiniPony = nil
				player:TryRemoveNullCostume(mod.MiniPony.Costume)
				player:AddCacheFlags(CacheFlag.CACHE_FLYING)
				player:AddCacheFlags(CacheFlag.CACHE_SPEED)
				player:EvaluateItems()
			end
		end

		---red pills
		if data.RedPillDamageUp then --and game:GetFrameCount()%2 == 0 then
			data.RedPillDamageUp = data.RedPillDamageUp - data.RedPillDamageDown
			data.RedPillDamageDown = data.RedPillDamageDown + mod.RedPills.DamageDownTick
			if data.RedPillDamageUp < 0 then
				data.RedPillDamageUp = 0
			end
			player:AddCacheFlags(CacheFlag.CACHE_DAMAGE) -- | CacheFlag.CACHE_FIREDELAY)
			player:EvaluateItems()
			if data.RedPillDamageUp == 0 then
				data.RedPillDamageUp = nil
				data.RedPillDamageDown = nil
			end
		end

		---MidasCurse
		if player:HasCollectible(mod.Items.MidasCurse) then
			if not data.HasItemMidasCurse then
				data.HasItemMidasCurse = 1
				player:AddGoldenHearts(3)
				data.GoldenHeartsAmount = player:GetGoldenHearts()
			end
			local numMidas = GetItemsCount(player, mod.Items.MidasCurse)
			if numMidas ~= data.HasItemMidasCurse then
				if numMidas > data.HasItemMidasCurse and GetItemsCount(player, mod.Items.MidasCurse)  ~= 0 then
					player:AddGoldenHearts(3)
				end
				data.HasItemMidasCurse = GetItemsCount(player, mod.Items.MidasCurse)
			end
			if player:HasCollectible(CollectibleType.COLLECTIBLE_BLACK_CANDLE) and mod.MidasCurse.TurnGoldChance ~= mod.MidasCurse.MinGold then -- remove curse
				mod.MidasCurse.TurnGoldChance = mod.MidasCurse.MinGold
			elseif not player:HasCollectible(CollectibleType.COLLECTIBLE_BLACK_CANDLE) and mod.MidasCurse.TurnGoldChance ~= mod.MidasCurse.MaxGold then
				mod.MidasCurse.TurnGoldChance = mod.MidasCurse.MaxGold
			end
			-- golden particles
			if player:GetMovementDirection() ~= -1 then
				game:SpawnParticles(player.Position, EffectVariant.GOLD_PARTICLE, 1, 2, _, 0)
			end
			if player:GetGoldenHearts() < data.GoldenHeartsAmount then
				local rngMidasCurse = player:GetCollectibleRNG(mod.Items.MidasCurse)
				data.GoldenHeartsAmount = player:GetGoldenHearts()
				room:TurnGold() -- turn room gold (ultra greed death)
				GoldenGrid(rngMidasCurse) -- golden poops
				for _, entity in pairs(Isaac.GetRoomEntities()) do
					if entity:ToNPC() then
						local enemy = entity:ToNPC()
						enemy:RemoveStatusEffects()
						enemy:AddMidasFreeze(EntityRef(player), mod.MidasCurse.FreezeTime)
					end
					if entity.Type == EntityType.ENTITY_PICKUP then
						TurnPickupsGold(entity:ToPickup(), rngMidasCurse)
					end
				end
			elseif player:GetGoldenHearts() > data.GoldenHeartsAmount then
				data.GoldenHeartsAmount = player:GetGoldenHearts()
			end
		else
			if data.HasItemMidasCurse then
				data.HasItemMidasCurse = false
				data.GoldenHeartsAmount = 0
			end
		end
		---Duckling
		if player:HasCollectible(mod.Items.RubberDuck) then
			if not data.HasItemRubberDuck then
				data.HasItemRubberDuck = 1
				--data.DuckCurrentLuck = mod.RubberDuck.MaxLuck
				EvaluateDuckLuck(player, mod.RubberDuck.MaxLuck)
			end

			local numDuck = GetItemsCount(player, mod.Items.RubberDuck)
			if numDuck ~= data.HasItemRubberDuck then
				if numDuck > data.HasItemRubberDuck and GetItemsCount(player, mod.Items.RubberDuck) ~= 0 then
					EvaluateDuckLuck(player, data.DuckCurrentLuck + mod.RubberDuck.MaxLuck)
				end
				data.HasItemRubberDuck = GetItemsCount(player, mod.Items.RubberDuck)
			end

			if not data.DuckCurrentLuck then
				data.DuckCurrentLuck = 0
			end
		else
			if data.HasItemRubberDuck then
				data.HasItemRubberDuck = false
				--data.DuckCurrentLuck = 0
				EvaluateDuckLuck(player, 0)
			end
		end
		---WitchPaper
		if data.WitchPaper then
			data.WitchPaper = data.WitchPaper - 1
			if data.WitchPaper <= 0 then
				data.WitchPaper = nil
				player:AnimateTrinket(mod.Trinkets.WitchPaper)
				player:TryRemoveTrinket(mod.Trinkets.WitchPaper)
			end
		end
		--- COPY from Edith mod ------------
		--- BlackKnight
		if player:HasCollectible(mod.Items.BlackKnight, true) then
			if not data.HasBlackKnight then
				data.HasBlackKnight = true
				player:AddNullCostume(mod.BlackKnight.Costume)
				player:AddCacheFlags(CacheFlag.CACHE_FLYING)
				player:EvaluateItems()
			end
			if data.ControlTarget == nil then data.ControlTarget = true end
			if not player:HasEntityFlags(EntityFlag.FLAG_NO_PHYSICS_KNOCKBACK | EntityFlag.FLAG_NO_KNOCKBACK) then
				player:AddEntityFlags(EntityFlag.FLAG_NO_PHYSICS_KNOCKBACK | EntityFlag.FLAG_NO_KNOCKBACK)
			end
			-- get movement action
			local up = Input.IsActionPressed(ButtonAction.ACTION_UP, player.ControllerIndex)
			local down = Input.IsActionPressed(ButtonAction.ACTION_DOWN, player.ControllerIndex)
			local left = Input.IsActionPressed(ButtonAction.ACTION_LEFT, player.ControllerIndex)
			local right = Input.IsActionPressed(ButtonAction.ACTION_RIGHT, player.ControllerIndex)
			local isMoving = (down or right or left or up)
			if not data.ControlTarget then isMoving = false end
			-- spawn target mark
			if isMoving and not data.KnightTarget and not player:HasCollectible(CollectibleType.COLLECTIBLE_DOGMA) and not player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_MEGA_MUSH) and not player:IsCoopGhost() then
				if data.ControlTarget then
					data.KnightTarget = Isaac.Spawn(1000, mod.BlackKnight.Target, 0, player.Position, Vector.Zero, player):ToEffect()
					data.KnightTarget.Parent = player
					data.KnightTarget.SpawnerEntity = player
				end
			end
			if data.KnightTarget and data.KnightTarget:Exists() then
				if player:HasCollectible(CollectibleType.COLLECTIBLE_DOGMA) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_MEGA_MUSH) or player:IsCoopGhost() then
					data.KnightTarget:Remove()
					data.KnightTarget = nil
				end
				local targetData = data.KnightTarget:GetData()
				local targetSprite = data.KnightTarget:GetSprite()
				if not targetData.MovementVector then targetData.MovementVector = Vector.Zero end
				if not (left or right) then targetData.MovementVector.X = 0 end
				if not (up or down) then targetData.MovementVector.Y = 0 end
				if left and not right then targetData.MovementVector.X = -1
				elseif right then targetData.MovementVector.X = 1 end
				if up and not down then targetData.MovementVector.Y = -1
				elseif down then targetData.MovementVector.Y = 1 end
				if room:IsMirrorWorld() then targetData.MovementVector.X = targetData.MovementVector.X * -1 end
				if isMoving and data.KnightTarget:CollidesWithGrid() and player.ControlsEnabled then
					for gridIndex = 1, room:GetGridSize() do
						if room:GetGridEntity(gridIndex) then
							local grid = room:GetGridEntity(gridIndex)
							if (data.KnightTarget.Position - grid.Position):Length() <= mod.BlackKnight.DoorRadius then
								if grid.Desc.Type == GridEntityType.GRID_DOOR then
									grid = grid:ToDoor()
									if room:IsClear() then
										grid:TryUnlock(player)
									end
									if grid:IsOpen() then
										if (player.Position - grid.Position):Length() <= mod.BlackKnight.DoorRadius then
											player.Position = grid.Position
											player:SetColor(Color(1, 1, 1, 0, 0, 0, 0), 1, 999, false, true)
										else
											player:PlayExtraAnimation("TeleportUp")
											data.NextRoom = grid.Position
											data.Jumped = true
											data.ControlTarget = false
										end
									end
								end
							end
						end
					end
					if room:GetType() == RoomType.ROOM_DUNGEON then
						if ((data.KnightTarget.Position - Vector(110, 135)):Length() or (data.KnightTarget.Position - Vector(595, 272)):Length() or (data.KnightTarget.Position - Vector(595, 385)):Length()) <= 35 then
							player.Position = data.KnightTarget.Position + UnitVector(data.KnightTarget.Velocity):Resized(25)
							player:SetColor(Color(1, 1, 1, 0, 0, 0, 0), 2, 999, false, true)
							--[[
							if (data.KnightTarget.Position - Vector(110, 135)):Length() <= 35 then
								player.Position = data.KnightTarget.Position + UnitVector(data.KnightTarget.Velocity):Resized(25)
								player:SetColor(Color(1, 1, 1, 0, 0, 0, 0), 2, 999, false, true)
							elseif (data.KnightTarget.Position - Vector(595, 272)):Length() <= 35 then
								player.Position = data.KnightTarget.Position + UnitVector(data.KnightTarget.Velocity):Resized(25)
								player:SetColor(Color(1, 1, 1, 0, 0, 0, 0), 2, 999, false, true)
							elseif (data.KnightTarget.Position - Vector(595, 385)):Length() <= 35 then
								player.Position = data.KnightTarget.Position + UnitVector(data.KnightTarget.Velocity):Resized(25)
								player:SetColor(Color(1, 1, 1, 0, 0, 0, 0), 2, 999, false, true)
							--]]
						end
					end
				end
				if isMoving then
					data.KnightTarget.Velocity = data.KnightTarget.Velocity + UnitVector(targetData.MovementVector):Resized(player.MoveSpeed + 2)
					targetSprite:Play("Idle")
				end
			end
			if data.Jumped and sprite:GetAnimation() == "TeleportUp" then
				player.FireDelay = player.MaxFireDelay-1 -- it can pause some charging attacks (better way to remove tears in TearInit callback but meh)
				data.ControlTarget = false
				player.EntityCollisionClass = EntityCollisionClass.ENTCOLL_PLAYERONLY
				player.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_NONE
				if player:IsExtraAnimationFinished() then
					if data.NextRoom then
						player.Position = data.NextRoom
						player:SetColor(Color(1, 1, 1, 0, 0, 0, 0), 1, 999, false, true)
						data.NextRoom = nil
						data.ControlTarget = true
						data.Jumped = nil
					else
						player:PlayExtraAnimation("TeleportDown")
					end
				end
			end
			if data.Jumped and sprite:GetAnimation() == "TeleportDown" then
				if data.KnightTarget then
					player.Position = data.KnightTarget.Position
					data.ControlTarget = false
				end
			end
			if data.Jumped and sprite:IsFinished("TeleportDown") then
				data.Jumped = nil
				data.ControlTarget = true
				player.EntityCollisionClass = EntityCollisionClass.ENTCOLL_ALL
				if player.CanFly then
					player.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_WALLS
				else
					player.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_GROUND
				end
				for _, entity in pairs(Isaac.GetRoomEntities()) do
					--EntityType.ENTITY_HOST
					--EntityType.ENTITY_MOBILE_HOST
					--EntityType.ENTITY_FLOATING_HOST
					if entity:IsVulnerableEnemy() and entity:IsActiveEnemy() then
						if entity.Position:Distance(player.Position) > mod.BlackKnight.BlastRadius and entity.Position:Distance(player.Position) <= mod.BlackKnight.BlastRadius*2.5 then
							entity.Velocity = (entity.Position - player.Position):Resized(mod.BlackKnight.BlastKnockback*(2/3))
						end
					elseif entity.Type == EntityType.ENTITY_PICKUP and entity.Position:Distance(player.Position) <= mod.BlackKnight.PickupDistance then
						entity = entity:ToPickup()
						if mod.BlackKnight.ChestVariant[entity.Variant] and entity.SubType ~= 0 then
							if entity.Variant == PickupVariant.PICKUP_BOMBCHEST then
								entity:TryOpenChest()
							end
							entity.Position = player.Position
							entity.Velocity = Vector.Zero
						else
							entity.Position = player.Position
							entity.Velocity = Vector.Zero
						end
					end
				end
				BlastDamage(mod.BlackKnight.BlastRadius, mod.BlackKnight.BlastDamage + player.Damage/2, mod.BlackKnight.BlastKnockback, player)
				local gridEntity = room:GetGridEntityFromPos(player.Position)
				if gridEntity then
					if gridEntity.Desc.Type == GridEntityType.GRID_PIT and gridEntity.Desc.State ~= 1 then
						if room:HasLava() then
							local splash = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BIG_SPLASH, 0, player.Position, Vector.Zero, player):ToEffect()
							splash.Color = Color(1.2, 0.8, 0.1, 1, 0, 0, 0)
							splash.SpriteScale = Vector(0.75, 0.75)
						elseif room:HasWaterPits() or room:HasWater() then
							local splash = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BIG_SPLASH, 0, player.Position, Vector.Zero, player):ToEffect()
							splash.SpriteScale = Vector(0.75, 0.75)
						end
					end
				elseif room:HasWater() then
					--sfx:Play(SoundEffect.SOUND_WATERSPLASH, 1, 0, false, 1, 0)
					local splash = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BIG_SPLASH, 0, player.Position, Vector.Zero, player):ToEffect()
					splash.SpriteScale = Vector(0.75, 0.75)
				else
					sfx:Play(SoundEffect.SOUND_STONE_IMPACT, 1, 0, false, 1, 0)
					--game:SpawnParticles(player.Position, EffectVariant.TOOTH_PARTICLE, 3, 2, _, 0)
				end
				game:ShakeScreen(10)
				player.Velocity = Vector.Zero
			end
		else
			if data.HasBlackKnight then
				player:TryRemoveNullCostume(mod.BlackKnight.Costume)
				data.HasBlackKnight = false
				player:ClearEntityFlags(EntityFlag.FLAG_NO_PHYSICS_KNOCKBACK | EntityFlag.FLAG_NO_KNOCKBACK)
				data.KnightTarget:Remove()
				data.KnightTarget = nil
			end
		end

		--red button
		if player:HasCollectible(mod.Items.RedButton) then
			if mod.RedButton.Blastocyst then
				mod.RedButton.Blastocyst.Visible = true
				mod.RedButton.Blastocyst = false
			end
			if not mod.PreRoomState then -- if room is not cleared
				for gridIndex = 1, room:GetGridSize() do -- get room size
					local grid = room:GetGridEntity(gridIndex)
					if grid then -- if grid ~= nil then
						if grid.VarData == mod.RedButton.VarData then -- check button
							if grid.State ~= 0 then
								mod.RedButton.PressCount = mod.RedButton.PressCount + 1 -- button was pressed, increment 1
								room:RemoveGridEntity(gridIndex, 0, false) -- remove pressed button
								--grid:Update()
								room:Update()
								if mod.RedButton.PressCount >= mod.RedButton.Limit then -- get limit, no more buttons for this room
									mod.RedButton.PressCount = 0 -- set press counter to 0
									local effect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.FART, 0, grid.Position, Vector.Zero, nil)
									effect:SetColor(Color(2.5,0,0,1,0,0,0),50,1, false, false) -- poof effect
									mod.RedButton.Blastocyst = Isaac.Spawn(EntityType.ENTITY_BLASTOCYST_BIG, 0, 0, room:GetCenterPos(), Vector.Zero, nil) -- spawn blastocyst
									mod.RedButton.Blastocyst.Visible = false
									mod.RedButton.Blastocyst:ToNPC().State = NpcState.STATE_JUMP
								else
									SpawnButton(player, room) -- spawn new button
									local effect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, grid.Position, Vector.Zero, nil)
									effect:SetColor(Color(1.5,0,0,1,0,0,0),50,1, false, false) -- poof effect
								end
							end
						end
					end
				end
			end
		end

		--- lost flower
		if player:HasTrinket(mod.Trinkets.LostFlower) and player:GetEternalHearts() > 0 then -- if you get eternal heart, add another one
			player:AddEternalHearts(1)
		end
		--- rubick's dice
		if mod.RubikDice.ScrambledDices[player:GetActiveItem(ActiveSlot.SLOT_PRIMARY)] then -- if player:GetActiveItem(ActiveSlot.SLOT_PRIMARY) == mod.Items.RubikDiceScrambled0 then
			local scrambledice = player:GetActiveItem(ActiveSlot.SLOT_PRIMARY)
			if player:GetActiveCharge(ActiveSlot.SLOT_PRIMARY) >= Isaac.GetItemConfig():GetCollectible(scrambledice).MaxCharges then
				--player:RemoveCollectible(scrambledice) -- scrambledice
				player:AddCollectible(mod.Items.RubikDice)
				player:SetActiveCharge(3, ActiveSlot.SLOT_PRIMARY)
			elseif player:GetActiveCharge(ActiveSlot.SLOT_PRIMARY) > 0 and Input.IsActionPressed(ButtonAction.ACTION_ITEM, 0) then
				local rng = player:GetCollectibleRNG(scrambledice)
				local Newdice = mod.RubikDice.ScrambledDicesList[rng:RandomInt(#mod.RubikDice.ScrambledDicesList)+1]
				RerollTMTRAINER(player, scrambledice)
				--player:RemoveCollectible(scrambledice) -- scrambledice
				player:AddCollectible(Newdice) --Newdice
				player:SetActiveCharge(0, ActiveSlot.SLOT_PRIMARY)
			end
		end
		--- tea bag
		if player:HasTrinket(mod.Trinkets.TeaBag) then
			--TrinketType.TRINKET_GOLDEN_FLAG
			--pickup.SubType < 32768
			local removeRadius = mod.TeaBag.Radius
			local numTrinket = player:GetTrinketMultiplier(mod.Trinkets.TeaBag)
			--if player:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_BOX) then numTrinket = numTrinket + 1 end
			removeRadius = removeRadius * numTrinket
			for _, effect in pairs(Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.SMOKE_CLOUD)) do
				if effect.Position:Distance(player.Position) < removeRadius then
					if not effect.SpawnerType then
						effect:Remove()
					elseif effect.SpawnerType ~= EntityType.ENTITY_PLAYER then
						effect:Remove()
					end
				end
			end
		end
		--- COPY from Edith mod ------------
		--- white knight
		if player:HasCollectible(mod.Items.WhiteKnight, true) then
			if not data.HasWhiteKnight then
				data.HasWhiteKnight = true
				player:AddNullCostume(mod.WhiteKnight.Costume)
				-- remove cache flag
			end
			if data.Jumped and sprite:GetAnimation() == "TeleportUp" then
				player.FireDelay = player.MaxFireDelay-1 -- it can pause some charging attacks (better way to remove tears in TearInit callback but meh)

				player.EntityCollisionClass = EntityCollisionClass.ENTCOLL_PLAYERONLY
				player.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_NONE

				if player:IsExtraAnimationFinished() then
					player:PlayExtraAnimation("TeleportDown")
				end
			end
			if data.Jumped and sprite:GetAnimation() == "TeleportDown" then
				local nearest = 5000
				local JumpPosition = GetNearestEnemy(player.Position)
				if player.Position:Distance(JumpPosition) == 0 then
					for gridIndex = 1, room:GetGridSize() do
						if room:GetGridEntity(gridIndex) then
							if room:GetGridEntity(gridIndex):ToDoor() then
								if room:GetGridEntity(gridIndex):ToDoor():GetVariant() ~= 7 then
									local newPos = Isaac.GetFreeNearPosition(room:GetGridPosition(gridIndex), 1)
									if player.Position:Distance(newPos) < nearest then
										JumpPosition = newPos
										nearest = player.Position:Distance(newPos)
									end
								end
							end
						end
					end
				end
				player.Position = JumpPosition
			end
			if data.Jumped and sprite:IsFinished("TeleportDown") then
				data.Jumped = nil
				--data.JumpPosition = nil

				player.EntityCollisionClass = EntityCollisionClass.ENTCOLL_ALL
				if player.CanFly then
					player.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_WALLS
				else
					player.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_GROUND
				end
				for _, entity in pairs(Isaac.GetRoomEntities()) do
					--EntityType.ENTITY_HOST
					--EntityType.ENTITY_MOBILE_HOST
					--EntityType.ENTITY_FLOATING_HOST
					if entity:IsVulnerableEnemy() and entity:IsActiveEnemy() then
						if entity.Position:Distance(player.Position) > mod.BlackKnight.BlastRadius and entity.Position:Distance(player.Position) <= mod.BlackKnight.BlastRadius*2.5 then
							entity.Velocity = (entity.Position - player.Position):Resized(mod.BlackKnight.BlastKnockback*(2/3))
						end
					elseif entity.Type == EntityType.ENTITY_PICKUP and entity.Position:Distance(player.Position) <= mod.BlackKnight.PickupDistance then
						entity = entity:ToPickup()
						if mod.BlackKnight.ChestVariant[entity.Variant] and entity.SubType ~= 0 then
							if entity.Variant == PickupVariant.PICKUP_BOMBCHEST then
								entity:TryOpenChest()
							end
							entity.Position = player.Position
							entity.Velocity = Vector.Zero
						else
							entity.Position = player.Position
							entity.Velocity = Vector.Zero
						end
					end
				end
				BlastDamage(mod.BlackKnight.BlastRadius, mod.BlackKnight.BlastDamage + player.Damage/2, mod.BlackKnight.BlastKnockback, player)
				local gridEntity = room:GetGridEntityFromPos(player.Position)
				if gridEntity then
					if gridEntity.Desc.Type == GridEntityType.GRID_PIT and gridEntity.Desc.State ~= 1 then
						if room:HasLava() then
							local splash = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BIG_SPLASH, 0, player.Position, Vector.Zero, player):ToEffect()
							splash.Color = Color(1.2, 0.8, 0.1, 1, 0, 0, 0)
							splash.SpriteScale = Vector(0.75, 0.75)
						elseif room:HasWaterPits() or room:HasWater() then
							local splash = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BIG_SPLASH, 0, player.Position, Vector.Zero, player):ToEffect()
							splash.SpriteScale = Vector(0.75, 0.75)
						end
					end
				elseif room:HasWater() then
					--sfx:Play(SoundEffect.SOUND_WATERSPLASH, 1, 0, false, 1, 0)
					local splash = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BIG_SPLASH, 0, player.Position, Vector.Zero, player):ToEffect()
					splash.SpriteScale = Vector(0.75, 0.75)
				else
					sfx:Play(SoundEffect.SOUND_STONE_IMPACT, 1, 0, false, 1, 0)
					--game:SpawnParticles(player.Position, EffectVariant.TOOTH_PARTICLE, 3, 2, _, 0)
				end
				game:ShakeScreen(10)
				player.Velocity = Vector.Zero
				--player.ControlsEnabled = true
			end
			--]]
		else
			if data.HasWhiteKnight then
				player:TryRemoveNullCostume(mod.WhiteKnight.Costume)
				data.HasWhiteKnight = false
			end
		end
		--- red scissors
		if player:HasTrinket(mod.Trinkets.RedScissors) then
			if not mod.RedScissorsMod then
				mod.RedScissorsMod = true
			end
		else
			if mod.RedScissorsMod then
				mod.RedScissorsMod = false
			end
		end

		---charon's obol block if you used health
		if data.BlockObol then
			data.BlockObol = data.BlockObol - 1
			if data.BlockObol == 0 then
				data.BlockObol = nil
			end
		end

		--- viridian
		if player:HasCollectible(mod.Items.Viridian) then
			if not data.HasItemViridian then
				data.HasItemViridian = true
				player:AddCacheFlags(CacheFlag.CACHE_FLYING)
				player:EvaluateItems()
				player.SpriteOffset = Vector(player.SpriteOffset.X, player.SpriteOffset.Y + mod.Viridian.FlipOffsetY)
				player:GetSprite().FlipX = true
				player:GetSprite().FlipY = true
			end
			--local mySprite = player:GetSprite()
			--mySprite.FlipY = true
			--player:ClearCostumes()
		else
			if data.HasItemViridian then
				data.HasItemViridian = nil
				player:AddCacheFlags(CacheFlag.CACHE_FLYING)
				player:EvaluateItems()
			end
		end
		--- brain queue (better holy water mod)
		local brains = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, mod.NadabBrain.Variant)
		if #brains > 0 then
			local nadabBrainAmount = GetItemsCount(player, mod.Items.NadabBrain)
			local highest --= nil
			for _, fam in pairs(brains) do
				local famData = fam:GetData()
				famData.IsHighest = false
				if fam.Visible then
					if nadabBrainAmount == 1 or highest == nil then
						highest = fam
						famData.IsHighest = true
					else
						if highest.FrameCount < fam.FrameCount then
							highest:GetData().IsHighest = false
							famData.IsHighest = true
							highest = fam
						end
					end
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.onPEffectUpdate)
--- PLAYER COLLISION --
function mod:onPlayerCollision(player, collider)
	local data = player:GetData()
	local tempEffects = player:GetEffects()

	--- long elk
	if data.ElkKiller and tempEffects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_MARS) and collider:ToNPC() then --collider:IsVulnerableEnemy() and collider:IsActiveEnemy() then  -- player.Velocity ~= Vector.Zero
		if not collider:IsVulnerableEnemy() then
			game:ShakeScreen(10)
			collider:Kill()
		else
			if collider:GetData().ElkKillerTick then
				if game:GetFrameCount() - collider:GetData().ElkKillerTick >= 2 then
					collider:GetData().ElkKillerTick = nil
				end
			else
				--data.ElkKiller = false
				collider:GetData().ElkKillerTick = game:GetFrameCount()
				collider:TakeDamage(mod.LongElk.Damage, DamageFlag.DAMAGE_IGNORE_ARMOR, EntityRef(player), 0)
				sfx:Play(SoundEffect.SOUND_DEATH_CARD)
				--sfx:Play(SoundEffect.SOUND_DEATH_CARD, 1, 2, false, 1, 0) --sfx:Play(ID, Volume, FrameDelay, Loop, Pitch, Pan)
				game:ShakeScreen(10)
				player:SetMinDamageCooldown(mod.LongElk.InvFrames)
			end
		end
	end

	--- abihu
	if player:GetPlayerType() == mod.Characters.Abihu then
		if collider:ToNPC() then
			collider:AddBurn(EntityRef(player), 100, player.Damage)
		end
	end

end
mod:AddCallback(ModCallbacks.MC_PRE_PLAYER_COLLISION, mod.onPlayerCollision)
--- POST UPDATE --
function mod:onUpdate()
	local level = game:GetLevel()
	local room = game:GetRoom()

	--Apocalypse card
	if mod.Apocalypse.Room then
		if level:GetCurrentRoomIndex() == mod.Apocalypse.Room then -- meh. bad solution. but anyway. poop created in this room will be red (it will run in loop, until you leave current room. Why? Cause poop doesn't spawn immediately)
			for gridIndex = 1, room:GetGridSize() do -- get room size
				local grid = room:GetGridEntity(gridIndex)
				if grid then
					if grid:ToPoop() then
						if grid:GetVariant() == 0 then
							grid:SetVariant(1)
							grid:Init(mod.Apocalypse.RNG:RandomInt(Random())+1)
							grid:PostInit()
							grid:Update()
						end
					end
				end
			end
		end
	end

	if level:GetCurses() & mod.Curses.Envy > 0 then
		local shopItems = Isaac.FindInRadius(room:GetCenterPos(), 5000, EntityPartition.PICKUP)
		if #shopItems > 0 then
			if mod.EnvyCurseIndex == nil then
				mod.EnvyCurseIndex = modRNG:RandomInt(Random())+1
			end
			for _, pickup in pairs(shopItems) do
				if pickup.Type ~= EntityType.ENTITY_SLOT then
					pickup = pickup:ToPickup()
					if pickup:IsShopItem() and pickup.OptionsPickupIndex ~= mod.EnvyCurseIndex then
						pickup.OptionsPickupIndex = mod.EnvyCurseIndex
					end
				end
			end
		end
	end
	--curse void reroll countdown
	if not room:HasCurseMist() then
		if mod.VoidCurseReroll then
			mod.VoidCurseReroll = mod.VoidCurseReroll - 1
			if mod.VoidCurseReroll <= 0 then
				for _, enemy in pairs(Isaac.FindInRadius(room:GetCenterPos(), 5000, EntityPartition.ENEMY)) do
					if enemy:IsVulnerableEnemy() and enemy:IsActiveEnemy() then
						game:RerollEnemy(enemy)
						enemy:GetData().VoidCurseNoDevolde = true
					end
				end
				mod.VoidCurseReroll = nil
			end
		end
	end

	--player
	for playerNum = 0, game:GetNumPlayers()-1 do
		local player = game:GetPlayer(playerNum):ToPlayer()
		local data = player:GetData()
		--local tempEffects = player:GetEffects()
		--local pType = player:GetPlayerType()
		if not player:HasCurseMistEffect() and not player:IsCoopGhost() then
			if player:HasTrinket(mod.Trinkets.TeaFungus) and not room:HasWater() and not room:IsClear() and room:GetFrameCount() <= 2  then
				if room:GetFrameCount() == 1 then
					local enemies = Isaac.FindInRadius(player.Position, 5000, EntityPartition.ENEMY)
					if #enemies > 0 then -- prevent turning enemies into poop
						for _, enemy in pairs(enemies) do
							if enemy:IsVulnerableEnemy() and enemy:IsActiveEnemy() and not enemy:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) then
								enemy:AddEntityFlags(EntityFlag.FLAG_FRIENDLY)
								enemy:GetData().TeaFungused = true
							end
						end
					end
				elseif room:GetFrameCount() == 2 then
					player:UseActiveItem(CollectibleType.COLLECTIBLE_FLUSH, myUseFlags)
					if sfx:IsPlaying(SoundEffect.SOUND_FLUSH) then
						sfx:Stop(SoundEffect.SOUND_FLUSH)
					end
					--elseif room:GetFrameCount() == 3 then
					local enemies = Isaac.FindInRadius(player.Position, 5000, EntityPartition.ENEMY)
					if #enemies > 0 then
						for _, enemy in pairs(enemies) do
							if enemy:IsVulnerableEnemy() and enemy:IsActiveEnemy() and enemy:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) and enemy:GetData().TeaFungused then
								enemy:ClearEntityFlags(EntityFlag.FLAG_FRIENDLY)
								enemy:GetData().TeaFungused = nil
							end
						end
					end
				end
			end

			-- abyss cartridge
			if player:HasTrinket(mod.Trinkets.AbyssCart) and player:IsDead() and player:GetExtraLives() == 0 then --and not player:WillPlayerRevive() then
				local allItems = Isaac.GetItemConfig():GetCollectibles().Size - 1 -- get all items in the game + mod items
				for id = 1, allItems do
					if player:HasCollectible(id) and CheckItemTags(id, ItemConfig.TAG_BABY) and not CheckItemTags(id, ItemConfig.TAG_QUEST) then
						player:RemoveCollectible(id)
						player:AddCollectible(CollectibleType.COLLECTIBLE_1UP)
						--tempEffects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_1UP)
						RemoveThrowTrinket(player, mod.Trinkets.AbyssCart, mod.TrinketDespawnTimer)
						break
					end
				end
			end

			-- player dead
			if player:IsDead() then --and not player:WillPlayerRevive() then
				--witch paper
				if player:HasTrinket(mod.Trinkets.WitchPaper) then
					data.WitchPaper = 2
					--Isaac.ExecuteCommand("rewind")
					player:UseActiveItem(CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS, myUseFlags)
				end
			end

			-- limb
			if data.LimbActive then --- make it so this effect saved until next floor and if you don't get any health kill you
				game:Darken(1, 1)
			end
			--]]

			if player:IsDead() then
				if player:GetExtraLives() == 0 and player:HasCollectible(mod.Items.Limb) and not data.LimbActive then -- and player:GetBrokenHearts() < 12 then -- and not player:WillPlayerRevive()
					player:Revive()
					player:SetMinDamageCooldown(mod.Limb.InvFrames)
					data.LimbActive = true
					player:UseCard(Card.CARD_SOUL_LOST, myUseFlags)
					game:Darken(1, 3)
				end
				--
				if player:HasCollectible(mod.Items.CharonObol) then
					player:RemoveCollectible(mod.Items.CharonObol)
				end
				--
			end
		end

		--FloppyDisk
		--if player:HasCollectible(mod.Items.FloppyDisk) and #mod.FloppyDisk.Items > 0 then
		if not savetable.FloppyDiskItems then modDataLoad() end
		if player:HasCollectible(mod.Items.FloppyDisk) and #savetable.FloppyDiskItems > 0 then
			player:RemoveCollectible(mod.Items.FloppyDisk)
			player:AddCollectible(mod.Items.FloppyDiskFull)
			--elseif player:HasCollectible(mod.Items.FloppyDiskFull) and #mod.FloppyDisk.Items == 0 then
		elseif player:HasCollectible(mod.Items.FloppyDiskFull) and #savetable.FloppyDiskItems == 0 then
			player:RemoveCollectible(mod.Items.FloppyDiskFull)
			player:AddCollectible(mod.Items.FloppyDisk)
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.onUpdate)

--- NEW LEVEL --
function mod:onNewLevel()
	local level = game:GetLevel()
	local room = game:GetRoom()
	mod.OblivionCard.ErasedEntities = {}
	--mod.Lobotomy.ErasedEntities = {}

	-- reset chances to 0
	for _, fam in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR)) do
		if fam:GetData().GenChanceUp then fam:GetData().GenChanceUp = 0 end
	end
	--]]
	-- player
	for playerNum = 0, game:GetNumPlayers()-1 do
		local player = game:GetPlayer(playerNum)
		local data = player:GetData()
		local tempEffects = player:GetEffects()

		--lililith
		if data.LililithDemonSpawn then
			for i = 1, #data.LililithDemonSpawn do -- remove all item effects
				data.LililithDemonSpawn[i][3] = 0
			end
		end

		-- unbidden
		if player:GetPlayerType() == mod.Characters.Unbidden then
			AddItemFromWisp(player, true, true, false)
		end

		-- tainted unbidden
		if player:GetPlayerType() == mod.Characters.Oblivious and not player:HasCollectible(CollectibleType.COLLECTIBLE_BLACK_CANDLE) and not player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
			level:AddCurse(LevelCurse.CURSE_OF_DARKNESS | LevelCurse.CURSE_OF_THE_LOST | LevelCurse.CURSE_OF_THE_UNKNOWN | LevelCurse.CURSE_OF_MAZE | LevelCurse.CURSE_OF_BLIND, false)
		end

		-- memory fragment
		if player:HasTrinket(mod.Trinkets.MemoryFragment) and data.MemoryFragment then
			local max = player:GetTrinketMultiplier(mod.Trinkets.MemoryFragment) + 2 --(normal is 3)
			local count = 0
			for i = #data.MemoryFragment, 1, -1 do
				if count <= max then
					DebugSpawn(data.MemoryFragment[i][1], data.MemoryFragment[i][2], room:GetRandomPosition(1))
					count = count +1
				end
			end
		end
		if data.MemoryFragment then data.MemoryFragment = {} end

		-- limb
		if data.LimbActive then
			if tempEffects:HasNullEffect(NullItemID.ID_LOST_CURSE) then
				tempEffects:RemoveNullEffect(NullItemID.ID_LOST_CURSE, 2)
			end
			data.LimbActive = false
		end

		--red lotus
		if player:HasCollectible(mod.Items.RedLotus) and player:GetBrokenHearts() > 0 then
			player:AddBrokenHearts(-1)
			--if not data.RedLotusDamage then data.RedLotusDamage = 0 end
			data.RedLotusDamage = data.RedLotusDamage or 0
			local numRedLotus = GetItemsCount(player, mod.Items.RedLotus)
			data.RedLotusDamage = data.RedLotusDamage + (mod.RedLotus.DamageUp * numRedLotus)
			player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
			player:EvaluateItems()
		end
		if player:HasCollectible(mod.Items.VoidKarma) then
			if not data.KarmaStats then
				data.KarmaStats = {
				["Damage"] = 0,
				["Firedelay"] = 0,
				["Shotspeed"] = 0,
				["Range"] = 0,
				["Speed"] = 0,
				["Luck"] = 0,
				}
			end
			local multi = 2
			if data.StateDamaged then
				multi = data.StateDamaged
				data.StateDamaged = nil
			end
			multi = multi * GetItemsCount(player, mod.Items.VoidKarma)
			data.KarmaStats.Damage = data.KarmaStats.Damage + (mod.VoidKarma.DamageUp * multi)
			data.KarmaStats.Firedelay = data.KarmaStats.Firedelay - (mod.VoidKarma.TearsUp * multi)
			data.KarmaStats.Shotspeed = data.KarmaStats.Shotspeed + (mod.VoidKarma.ShotSpeedUp * multi)
			data.KarmaStats.Range = data.KarmaStats.Range + (mod.VoidKarma.RangeUp * multi)
			data.KarmaStats.Speed = data.KarmaStats.Speed + (mod.VoidKarma.SpeedUp * multi)
			data.KarmaStats.Luck = data.KarmaStats.Luck + (mod.VoidKarma.LuckUp * multi)
			player:AddCacheFlags(mod.VoidKarma.EvaCache)
			player:EvaluateItems()
			player:AnimateHappy()
			sfx:Play(SoundEffect.SOUND_1UP) -- play 1up sound
		end
		-- reset modded bombas table
		if data.ModdedBombas then
			data.ModdedBombas = {}
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.onNewLevel)
--- NEW ROOM --
function mod:onNewRoom()
	local room = game:GetRoom()
 	local level = game:GetLevel()
	if mod.NoJamming then mod.NoJamming = nil end
	mod.PreRoomState = room:IsClear()
	--familiars
	--red bag
	if not room:HasCurseMist() then
		for _, fam in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, mod.RedBag.Variant)) do
			if fam:GetData().GenPickup then fam:GetData().GenPickup = false end
		end
		--curses
		--Void curse
		if level:GetCurses() & mod.Curses.Void > 0 and not room:IsClear() then
			if modRNG:RandomFloat() < mod.VoidThreshold then
				mod.VoidCurseReroll = 0
				game:ShowHallucination(0, BackdropType.NUM_BACKDROPS)

				game:GetPlayer(0):UseActiveItem(CollectibleType.COLLECTIBLE_D12, myUseFlags)
			end
		end

		--[[ curse Emperor
		if level:GetCurses() & mod.Curses.Emperor > 0 and room:GetType() == RoomType.ROOM_BOSS then
			--SeedEffect.SEED_NO_BOSS_ROOM_EXITS

			local door = room:GetDoor(level.EnterDoor) --:ToDoor()
			if door then
				room:RemoveDoor(door.Slot)
			end
		end
		--]]
	end


	-- Apocalypse card
	if mod.Apocalypse.Room then
		mod.Apocalypse.Room = nil
		mod.Apocalypse.RNG = nil
	end

	--print(level:GetCurrentRoomIndex())
	if mod.OutOfMap and level:GetCurrentRoomIndex() >= 0 then
		mod.OutOfMap = nil
	end

	--player
	for playerNum = 0, game:GetNumPlayers()-1 do
		local player = game:GetPlayer(playerNum)
		local data = player:GetData()
		local tempEffects = player:GetEffects()

		if not player:HasCurseMistEffect() and not player:IsCoopGhost() then

			if data.MongoSteven then tempEffects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_SPOON_BENDER, false) end
			if data.MongoHarlequin then tempEffects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_THE_WIZ, false) end
			if data.MongoFreezer then tempEffects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_URANUS, false) end
			if data.MongoGhost then tempEffects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_OUIJA_BOARD, false) end
			if data.MongoAbel then tempEffects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_MY_REFLECTION, false) end
			if data.MongoRainbow then tempEffects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_FRUIT_CAKE, false) end
			if data.MongoBrimstone then tempEffects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_BRIMSTONE, false) end
			if data.MongoBallBandage then tempEffects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_MOMS_EYESHADOW, false) end
			if data.MongoHaunt then tempEffects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_MOMS_PERFUME, false) end
			if data.MongoSissy then tempEffects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_MOMS_WIG, false) end

			--lililith
			LililithReset() -- update items
			-- limb
			if data.LimbActive then
				local tempEffects = player:GetEffects()
				tempEffects:AddNullEffect(NullItemID.ID_LOST_CURSE, true, 1)
			end
			--- queen of spades
			if player:HasTrinket(mod.Trinkets.QueenSpades) then
				SesameOpen(room, level, player)
			end
			--red button
			if player:HasCollectible(mod.Items.RedButton) and not mod.PreRoomState then
				NewRoomRedButton(player, room) -- spawn new button
			end
			--red pill
			if data.RedPillDamageUp and not room:IsClear() then
				--[[if room:IsFirstVisit() and not room:IsClear() then
					player:UseActiveItem(CollectibleType.COLLECTIBLE_WAVY_CAP, myUseFlags)
					if sfx:IsPlaying(SoundEffect.SOUND_VAMP_GULP) then
						sfx:Stop(SoundEffect.SOUND_VAMP_GULP)
					end
				end
				--]]
				local tempEffects = player:GetEffects()
				--ID_WAVY_CAP_1
				--ID_WAVY_CAP_2
				--ID_WAVY_CAP_3
				tempEffects:AddNullEffect(NullItemID.ID_WAVY_CAP_1, false, 1)
				game:ShowHallucination(0, BackdropType.DICE)
				if sfx:IsPlaying(SoundEffect.SOUND_DEATH_CARD) then
					sfx:Stop(SoundEffect.SOUND_DEATH_CARD)
				end
			end
			--BlackKnight
			if player:HasCollectible(mod.Items.BlackKnight, true) then
				if data.KnightTarget then
					if data.KnightTarget:Exists() then data.KnightTarget:Remove() end
					data.KnightTarget = nil
				end
				player.EntityCollisionClass = EntityCollisionClass.ENTCOLL_ALL
				if player.CanFly then
					player.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_WALLS
				else
					player.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_GROUND
				end
			end
			--duckling
			if player:HasCollectible(mod.Items.RubberDuck) then
				if room:IsFirstVisit() then
					EvaluateDuckLuck(player, data.DuckCurrentLuck + data.HasItemRubberDuck) -- add number of duck
				elseif not room:IsFirstVisit() and data.DuckCurrentLuck > 0 then -- luck down while you have temp.luck
					EvaluateDuckLuck(player, data.DuckCurrentLuck - 1)
				end
			end
			--ivory
			if data.IvoryOilBatteryEffect then -- or Render it
				if data.IvoryOilBatteryEffect:Exists() then
					data.IvoryOilBatteryEffect.Position = Vector(player.Position.X, player.Position.Y-70)
				else
					data.IvoryOilBatteryEffect = nil
				end
			end
			if player:HasCollectible(mod.Items.IvoryOil) and room:IsFirstVisit() and not room:IsClear() then
				--local chargingActive = true/false
				local chargingEffect = false -- leave it as nil
				for slot = 0, 2 do
					if player:GetActiveItem(slot) ~= 0 then --and chargingActive then
						local charge = 1
						if room:GetRoomShape() > 7 then charge = 2 end
						local activeItem = player:GetActiveItem(slot) -- active item on given slot
						local activeCharge = player:GetActiveCharge(slot) -- item charge
						local batteryCharge = player:GetBatteryCharge(slot) -- extra charge (battery item)
						local activeMaxCharge = Isaac.GetItemConfig():GetCollectible(activeItem).MaxCharges -- max charge of item
						local activeChargeType = Isaac.GetItemConfig():GetCollectible(activeItem).ChargeType -- get charge type (normal, timed, special)
						--print(activeChargeType)
						if activeChargeType == 0 then -- if normal
							if player:NeedsCharge(slot) then
								if activeCharge >= activeMaxCharge and batteryCharge < activeMaxCharge then
									batteryCharge = batteryCharge + charge
									player:SetActiveCharge(batteryCharge+activeCharge, slot)
								else
									activeCharge = activeCharge + charge
									player:SetActiveCharge(activeCharge, slot)
								end
								chargingEffect = slot
								break
							elseif activeCharge >= activeMaxCharge and batteryCharge < activeMaxCharge then
								batteryCharge = batteryCharge + charge
								player:SetActiveCharge(batteryCharge+activeCharge, slot)
								chargingEffect = slot
								break
							end
						elseif activeChargeType == 1 then -- if timed
							if player:NeedsCharge(slot) then
								if activeCharge >= activeMaxCharge and batteryCharge < activeMaxCharge then
									player:SetActiveCharge(2*activeMaxCharge, slot)
								else
									player:SetActiveCharge(activeMaxCharge, slot)
								end
								chargingEffect = slot
								break
							elseif activeCharge >= activeMaxCharge and batteryCharge < activeMaxCharge then
								player:SetActiveCharge(2*activeMaxCharge, slot)
								chargingEffect = slot
								break
							end
						end

					end
				end
				if chargingEffect then
					data.IvoryOilBatteryEffect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BATTERY, 0, Vector(player.Position.X, player.Position.Y-70), Vector.Zero, nil)
					sfx:Play(SoundEffect.SOUND_BATTERYCHARGE, 1, 0, false, 1, 0)
					--game:GetHUD():FlashChargeBar(player, chargingEffect)
				end
			end
		end
		--ancestral crypt
		if data.CryptUsed then
			player.Position = Vector(120, 165)
			data.CryptUsed = nil
		end
		-- maze memory
		if data.MazeMemoryUsed then
			--player.Position = room:GetCenterPos()
			for gridIndex = 1, room:GetGridSize() do
				local egrid = room:GetGridEntity(gridIndex)
				if egrid and (egrid:ToRock() or egrid:ToSpikes() or egrid:GetType() == 1) then --  or egrid:ToDoor()
					room:RemoveGridEntity(gridIndex, 0, false)
				elseif egrid and egrid:ToDoor() then
					room:RemoveDoor(egrid:ToDoor().Slot)
				end
			end
			local rent = room:GetEntities()
			for ient = 0, #rent-1 do
				local ent = rent:Get(ient)
				if ent and ent:ToPickup() then
					ent:Remove()
				end
			end
		end
		-- zero milestone
		if level:GetCurrentRoomIndex() == GridRooms.ROOM_GENESIS_IDX and mod.ZeroStoneUsed then
			mod.ZeroStoneUsed = false
			if level:IsAscent() then
				level:SetStage(LevelStage.STAGE8, 0)
			else
				level:SetStage(LevelStage.STAGE7, 0)
			end
		end
		-- decay
		if data.DecayLevel then
			TrinketRemove(player, TrinketType.TRINKET_APPLE_OF_SODOM)
			data.DecayLevel = nil
		end
		-- Corruption
		if data.CorruptionIsActive then
			data.CorruptionIsActive = nil
			player:TryRemoveNullCostume(mod.Corruption.CostumeHead)
			local activeItem = player:GetActiveItem(ActiveSlot.SLOT_PRIMARY)
			if activeItem ~= 0 then
				player:RemoveCollectible(activeItem)
			end
		end
		-- soul nadab and abihu
		if data.UsedSoulNadabAbihu then
			data.UsedSoulNadabAbihu = nil
		end
		-- deus ex card
		if data.DeuxExLuck then
			data.DeuxExLuck = nil
			player:AddCacheFlags(CacheFlag.CACHE_LUCK) -- remove luck effect
			player:EvaluateItems()
		end
		-- long elk
		if data.ElkKiller then data.ElkKiller = false end
		-- bleeding grimoire
		if data.UsedBG then
			--player.FireDelay = player.MaxFireDelay-1
			if not player:HasEntityFlags(EntityFlag.FLAG_BLEED_OUT) then
				player:TryRemoveNullCostume(mod.BG.Costume)
				data.UsedBG = false
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.onNewRoom)
--- CLEAN AWARD --
function mod:onRoomClear() --rng, spawnPosition
	local room = game:GetRoom()
	local level = game:GetLevel()
	--red button
	RemoveRedButton(room)
	-- jamming curse
	if level:GetCurses() & mod.Curses.Jamming > 0 and not room:HasCurseMist() then
		if modRNG:RandomFloat() < mod.JammingThreshold and not mod.NoJamming then
			game:ShowHallucination(5, 0)
			room:RespawnEnemies()
			mod.NoJamming = true
		end
	end
	---players
	for playerNum = 0, game:GetNumPlayers()-1 do
		local player = game:GetPlayer(playerNum)
		--local data = player:GetData()
		--queen of spades
		if not player:HasCurseMistEffect() and not player:IsCoopGhost() then
			if player:HasTrinket(mod.Trinkets.QueenSpades) then
				SesameOpen(room, level, player)
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, mod.onRoomClear)
--- CURSE EVAL --
function mod:onCurseEval(curseFlags)
	local newCurse = LevelCurse.CURSE_NONE
	local level = game:GetLevel()
	--[
	if curseFlags == LevelCurse.CURSE_NONE then
		if modRNG:RandomFloat() < mod.CurseChance then
			local curseTable = {}
			for _, value in pairs(mod.Curses) do
				--print(key, value)
				table.insert(curseTable, value)
			end
			--newCurse = mod.MyCurses[modRNG:RandomInt(#mod.MyCurses)+1]
			newCurse = curseTable[modRNG:RandomInt(#curseTable)+1]
		end
	end
	--]
	if level:GetStage() == LevelStage.STAGE7 and mod.ChaosVoid then
		curseFlags = curseFlags | mod.Curses.Void
	end

	local player = game:GetPlayer(0)
	if player:GetPlayerType() == mod.Characters.Oblivious and not player:HasCollectible(CollectibleType.COLLECTIBLE_BLACK_CANDLE) and not player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
		curseFlags = curseFlags | LevelCurse.CURSE_OF_DARKNESS | LevelCurse.CURSE_OF_THE_LOST | LevelCurse.CURSE_OF_THE_UNKNOWN | LevelCurse.CURSE_OF_MAZE | LevelCurse.CURSE_OF_BLIND
	end

	return curseFlags | newCurse
end

mod:AddCallback(ModCallbacks.MC_POST_CURSE_EVAL, mod.onCurseEval)
--- NPC DEVOLVE --
function mod:onDevolve(entity)
	if entity:GetData().VoidCurseNoDevolde then
		return true
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_ENTITY_DEVOLVE, mod.onDevolve)
--- NPC UPDATE --
function mod:onUpdateNPC(entityNPC)
	entityNPC = entityNPC:ToNPC()
	local eData = entityNPC:GetData()
	-- bleeding grimoire
	if eData.BG then
		eData.BG = eData.BG - 1
		if eData.BG == 0 and entityNPC:HasEntityFlags(EntityFlag.FLAG_BLEED_OUT) then
			entityNPC:ClearEntityFlags(EntityFlag.FLAG_BLEED_OUT)
		elseif eData.BG <= -25 then
			eData.BG = nil
		end
	end
	-- unbidden backstab aura
	if eData.BackStabbed then
		eData.BackStabbed = eData.BackStabbed - 1
		if eData.BackStabbed == 0 and entityNPC:HasEntityFlags(EntityFlag.FLAG_BLEED_OUT) then
			entityNPC:ClearEntityFlags(EntityFlag.FLAG_BLEED_OUT)
			eData.BackStabbed = nil
		end
	end
	if eData.BaitedTomato then
		eData.BaitedTomato = eData.BaitedTomato - 1
		if eData.BaitedTomato == 0 and entityNPC:HasEntityFlags(EntityFlag.FLAG_BAITED) then
			entityNPC:ClearEntityFlags(EntityFlag.FLAG_BAITED)
			eData.BaitedTomato = nil
		end
	end
	-- melted candle waxed
	if eData.Waxed then
		if eData.Waxed == mod.MeltedCandle.FrameCount then entityNPC:ClearEntityFlags(EntityFlag.FLAG_BURN) end
		eData.Waxed = eData.Waxed - 1
		if entityNPC:HasMortalDamage() then
			local flame = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.RED_CANDLE_FLAME, 0, entityNPC.Position, Vector.Zero, nil):ToEffect()
			flame.CollisionDamage = 23
			flame:SetTimeout(360)
		end
		if eData.Waxed <= 0 then eData.Waxed = nil end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_NPC_UPDATE, mod.onUpdateNPC)
--- NPC INIT --
function mod:onEnemyInit(entity)
	local level = game:GetLevel()
	local room = game:GetRoom()
	entity = entity:ToNPC()
	-- oblivion card
	if #mod.OblivionCard.ErasedEntities ~= 0 then
		for _, enemy in ipairs(mod.OblivionCard.ErasedEntities) do
			if entity.Type == enemy[1] and entity.Variant == enemy[2] then
				Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, entity.Position, Vector.Zero, nil):SetColor(mod.OblivionCard.PoofColor,50,1, false, false) --:ToEffect()
				entity:Remove()
				break
			end
		end
	end
	-- soul unbidden
	if #mod.Lobotomy.ErasedEntities ~= 0 then
		for _, enemy in ipairs(mod.Lobotomy.ErasedEntities) do
			if entity.Type == enemy[1] and entity.Variant == enemy[2] then
				Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, entity.Position, Vector.Zero, nil):SetColor(mod.OblivionCard.PoofColor,50,1, false, false) --:ToEffect()
				entity:Remove()
				break
			end
		end
	end
	if not room:HasCurseMist() then
		-- curse of strength
		if level:GetCurses() & mod.Curses.Strength > 0  then
			if entity:IsActiveEnemy() and entity:IsVulnerableEnemy() and not entity:IsBoss() and not entity:IsChampion() and modRNG:RandomFloat() > mod.StrengthThreshold then
				entity:Morph(entity.Type, entity.Variant, entity.SubType, modRNG:RandomInt(26))
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NPC_INIT, mod.onEnemyInit)
--- NPC DEATH --
function mod:onNPCDeath(enemy)
	--local eData = enemy:GetData()
	if enemy:IsActiveEnemy(true) then
	--if not enemy:IsVulnerableEnemy() then
		for playerNum = 0, game:GetNumPlayers()-1 do
			local player = game:GetPlayer(playerNum)

			if not player:HasCurseMistEffect() and not player:IsCoopGhost() then
				if player:HasCollectible(mod.Items.DMS) then
					local rng = player:GetCollectibleRNG(mod.Items.DMS)
					if rng:RandomFloat() < mod.DMS.Chance then
						local purgesoul = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PURGATORY, 1, enemy.Position, Vector.Zero, player):ToEffect() -- subtype = 0 is rift, 1 is soul
						purgesoul:GetSprite():Play("Charge", true) -- set animation (skip appearing from rift)
						--purgesoul.Color = Color(0.1,0.1,0.1,1)
					end
				end

				if player:HasTrinket(mod.Trinkets.MilkTeeth) then
					local rng = player:GetTrinketRNG(mod.Trinkets.MilkTeeth)
					local coinChance = mod.MilkTeeth.CoinChance
					local numTrinket = player:GetTrinketMultiplier(mod.Trinkets.MilkTeeth)
					--if player:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_BOX) then numTrinket = numTrinket + 1 end
					coinChance = coinChance * numTrinket
					if rng:RandomFloat() < coinChance then
						local randVector = RandomVector()*5
						local coin = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, 1, enemy.Position, randVector, nil)
						coin:GetData().MilkTeethDespawn = mod.MilkTeeth.CoinDespawnTimer --= 35
					end
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, mod.onNPCDeath)
--- NPC TAKE DMG FROM LASER --
function mod:onLaserDamage(entity, _, flags, source, _)
	if flags & DamageFlag.DAMAGE_LASER == DamageFlag.DAMAGE_LASER and entity:IsVulnerableEnemy() and entity:IsActiveEnemy() and source.Entity and source.Entity:ToPlayer() then
		local player = source.Entity:ToPlayer()
		local data = player:GetData()
		if not player:HasCurseMistEffect() and not player:IsCoopGhost() then
			if player:HasCollectible(mod.Items.MeltedCandle) and not entity:GetData().Waxed then
				local rng = player:GetCollectibleRNG(mod.Items.MeltedCandle)
				if rng:RandomFloat() + player.Luck/100 >= mod.MeltedCandle.TearChance then
					entity:AddFreeze(EntityRef(player), mod.MeltedCandle.FrameCount)
					if entity:HasEntityFlags(EntityFlag.FLAG_FREEZE) then
						--entity:AddBurn(EntityRef(player), 1, player.Damage) -- the issue is Freeze stops framecount of entity, so it won't call NPC_UPDATE.
						entity:AddEntityFlags(EntityFlag.FLAG_BURN)          -- the burn timer doesn't update, so just add burn until npc have freeze
						entity:GetData().Waxed = mod.MeltedCandle.FrameCount
						entity:SetColor(mod.MeltedCandle.TearColor, mod.MeltedCandle.FrameCount, 100, false, false)
					end
				end
			end
		end
		if data.UsedBG then -- and not entity:GetData().BG then --and player:HasEntityFlags(EntityFlag.FLAG_BLEED_OUT) then
			entity:AddEntityFlags(EntityFlag.FLAG_BLEED_OUT)
			entity:GetData().BG = mod.BG.FrameCount
		end
	end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.onLaserDamage)
--- KNIFE COLLISION --
function mod:onKnifeCollision(knife, collider) -- low
	if knife.SpawnerEntity then
		if knife.SpawnerEntity:ToPlayer() and collider:IsVulnerableEnemy() then
			local player = knife.SpawnerEntity:ToPlayer()
			local data = player:GetData()
			local entity = collider:ToNPC()
			--local eData = entity:GetData()
			if not player:HasCurseMistEffect() and not player:IsCoopGhost() then
				if player:HasCollectible(mod.Items.MeltedCandle) and not entity:GetData().Waxed then
					local rng = player:GetCollectibleRNG(mod.Items.MeltedCandle)
					if rng:RandomFloat() + player.Luck/100 >= mod.MeltedCandle.TearChance then
						entity:AddFreeze(EntityRef(player), mod.MeltedCandle.FrameCount)
						if entity:HasEntityFlags(EntityFlag.FLAG_FREEZE) then
							--entity:AddBurn(EntityRef(player), 1, player.Damage) -- the issue is Freeze stops framecount of entity, so it won't call NPC_UPDATE.
							entity:AddEntityFlags(EntityFlag.FLAG_BURN)          -- the burn timer doesn't update
							entity:GetData().Waxed = mod.MeltedCandle.FrameCount
							entity:SetColor(mod.MeltedCandle.TearColor, mod.MeltedCandle.FrameCount, 100, false, false)
						end
					end
				end
			end
			-- bleeding grimoire
			if data.UsedBG then -- and not entity:GetData().BG then --and player:HasEntityFlags(EntityFlag.FLAG_BLEED_OUT) then
				entity:AddEntityFlags(EntityFlag.FLAG_BLEED_OUT)
				entity:GetData().BG = mod.BG.FrameCount
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_KNIFE_COLLISION, mod.onKnifeCollision) --KnifeSubType
--- TEARS UPDATE --
function mod:onTearUpdate(tear)
	if not tear.SpawnerEntity then return end
	if not tear.SpawnerEntity:ToPlayer() then return end
	local tearData = tear:GetData()
	local tearSprite = tear:GetSprite()
	local room = game:GetRoom()
	local player = tear.SpawnerEntity:ToPlayer()
	local data = player:GetData()
	if tearData.UnbiddenTear then
		tear.Color = mod.ObliviousData.Stats.TEAR_COLOR
		tear.EntityCollisionClass = 0
		tear.Height = -25
		tear.Velocity = player:GetShootingInput() * player.ShotSpeed * 5
		--[[
		tearData.LastIter = tearData.LastIter or 0
		tearData.NewHeight = tearData.NewHeight or -25
		tearData.iterat = tearData.iterat or 1
		tear.Height = -30.5 + tearData.LastIter * 0.5
		if tearData.LastIter >= player:GetData().ObliviousDamageDelay then
			tearData.iterat = -1
		elseif tearData.LastIter <= 0 then
			tearData.iterat = 1
		end
		tearData.LastIter = tearData.LastIter + tearData.iterat
		--]]
		--[[
		if room:IsPositionInRoom(tear.Position, -100) then
			tear.Velocity = player:GetShootingInput() * player.ShotSpeed * 5
		else
			local bottom = room:GetBottomRightPos()
			local top = room:GetTopLeftPos()
			local newX = tear.Position.X
			local newY = tear.Position.Y
			--[
			if tear:HasTearFlags(TearFlags.TEAR_CONTINUUM) then
				if newX < top.X then
					newX = top.X
				elseif newX > bottom.X then
					newX = bottom.X
				end
				if newY < top.Y then
					newY = top.Y
				elseif newY > bottom.Y then
					newY = bottom.Y
				end
			else
			--]
			if not tear:HasTearFlags(TearFlags.TEAR_CONTINUUM) then
				tear.Velocity = Vector.Zero
				if newX < top.X then
					newX = newX + 10
				elseif newX > bottom.X then
					newX = newX -10
				end
				if newY < top.Y then
					newY = newY +10
				elseif newY > bottom.Y then
					newY = newY -10
				end
			end
			tear.Position = Vector(newX, newY)
		end
		--]]
		--[
		local prisms = Isaac.FindByType(3, 123)
		if #prisms > 0 then
			for _, prism in pairs(prisms) do
				--print(tear.Position:Distance(prism.Position))
				if tear.Position:Distance(prism.Position) < 25 then
					--tear:Kill()
					data.LudoTearEnable = true
				end
			end
		end
		--]

		if player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY) or not player:HasCollectible(CollectibleType.COLLECTIBLE_LUDOVICO_TECHNIQUE) or not data.BlindUnbidden then -- or player:HasCurseMistEffect() or player:IsCoopGhost() then
			tear:Kill()
		end
	elseif tearData.KnifeTear then
		tear.Visible = true
		tear.FallingAcceleration = 0
		tear.FallingSpeed = 0
		tear.Velocity = tearData.InitVelocity
		tear.CollisionDamage = player.Damage * mod.InfiniteBlades.DamageMulti
		tearSprite.Rotation = tearData.InitAngle:GetAngleDegrees()
		if tearData.InitAngle.X == -1 then
			if tearData.InitAngle.Y == 0 then
				tearSprite.FlipY = true
			end
			if tearData.InitAngle.Y == -1 then
				tearData.InitAngle = Vector(1,-1)
				--tearSprite.FlipY = true
				tearSprite.FlipX = true
				tearSprite.Rotation = tearData.InitAngle:GetAngleDegrees()
			end
			if tearData.InitAngle.Y == 1 then
				tearData.InitAngle = Vector(1,1)
				--tearSprite.FlipY = true
				tearSprite.FlipX = true
				tearSprite.Rotation = tearData.InitAngle:GetAngleDegrees()
			end
		end
		if not room:IsPositionInRoom(tear.Position, -100) then
			tear:Remove()
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, mod.onTearUpdate)
--- TEARS COLLISION --
function mod:onTearCollision(tear, collider) --tear, collider, low
	tear = tear:ToTear()
	--local tearData = tear:GetData()
	if tear.SpawnerEntity and tear.SpawnerEntity:ToPlayer() then
		if collider:IsVulnerableEnemy() then
			local player = tear.SpawnerEntity:ToPlayer()
			local data = player:GetData()
			local entity = collider:ToNPC()
			--local eData = entity:GetData()
			if not player:HasCurseMistEffect() and not player:IsCoopGhost() then
				if player:HasCollectible(mod.Items.MeltedCandle) and not entity:GetData().Waxed then
					local rng = player:GetCollectibleRNG(mod.Items.MeltedCandle)
					if rng:RandomFloat() + player.Luck/100 >= mod.MeltedCandle.TearChance then
						entity:AddFreeze(EntityRef(player), mod.MeltedCandle.FrameCount)
						if entity:HasEntityFlags(EntityFlag.FLAG_FREEZE) then
							--entity:AddBurn(EntityRef(player), 1, player.Damage) -- the issue is Freeze stops framecount of entity, so it won't call NPC_UPDATE.
							entity:AddEntityFlags(EntityFlag.FLAG_BURN )
							entity:GetData().Waxed = mod.MeltedCandle.FrameCount
							entity:SetColor(mod.MeltedCandle.TearColor, mod.MeltedCandle.FrameCount, 100, false, false)
						end
					end
				end
			end
			if data.UsedBG then -- and not entity:GetData().BG then --and player:HasEntityFlags(EntityFlag.FLAG_BLEED_OUT) then
				entity:AddEntityFlags(EntityFlag.FLAG_BLEED_OUT)
				entity:GetData().BG = mod.BG.FrameCount
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_TEAR_COLLISION, mod.onTearCollision)
--- OBLIVION CARD TEAR COLLISION --
function mod:onTearOblivionCardCollision(tear, collider) --tear, collider, low
	tear = tear:ToTear()
	local tearData = tear:GetData()
	-- oblivion card
	if tearData.OblivionTear then
		if collider:ToNPC() then
			local player = tear.SpawnerEntity:ToPlayer()
			--local data = player:GetData()
			local enemy = collider:ToNPC()
			table.insert(mod.OblivionCard.ErasedEntities, {enemy.Type, enemy.Variant})
			for _, entity in pairs(Isaac.FindInRadius(player.Position, 5000, EntityPartition.ENEMY)) do -- get monsters in room
				if entity.Type == enemy.Type and entity.Variant == enemy.Variant then
					Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, entity.Position, Vector.Zero, nil):SetColor(mod.OblivionCard.PoofColor,50,1, false, false)
					entity:Remove()
				end
			end
			tear:Remove()
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_TEAR_COLLISION, mod.onTearOblivionCardCollision, mod.OblivionCard.TearVariant)
--- OBLIVION CARD TEAR INIT --
function mod:onOblivionTearInit(tear) -- card, player, useflag
	if tear.SpawnerEntity:ToPlayer() then
		local player = tear.SpawnerEntity:ToPlayer()
		local data = player:GetData()
		-- oblivion card
		if data.UsedOblivionCard then
			data.UsedOblivionCard = nil
			local tearData = tear:GetData()
			tearData.OblivionTear = true
			local sprite = tear:GetSprite()
			sprite:ReplaceSpritesheet(0, mod.OblivionCard.SpritePath)
			sprite:LoadGraphics() -- replace sprite
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_TEAR_INIT, mod.onOblivionTearInit, mod.OblivionCard.TearVariant)
--- PROJECTILES INIT --
function mod:onProjectileInit(projectile)
	local level = game:GetLevel()
	local room = game:GetRoom()
	if not room:HasCurseMist() then
		if Isaac.GetChallenge() == mod.Challenges.Magician or level:GetCurses() & mod.Curses.Magician > 0 then
			if projectile.SpawnerEntity then
				if not projectile.SpawnerEntity:IsBoss() then
					projectile:AddProjectileFlags(ProjectileFlags.SMART)
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PROJECTILE_INIT, mod.onProjectileInit)
--- INPUT ACTIONS --
function mod:onInputAction(entity, inputHook, buttonAction)
	if entity and entity.Type == EntityType.ENTITY_PLAYER and not entity:IsDead() then
		local player = entity:ToPlayer()
		local sprite = player:GetSprite()
		--- COPY from Edith mod ------------
		if not player:HasCurseMistEffect() and not player:IsCoopGhost() then
			if player:HasCollectible(mod.Items.BlackKnight, true) then
				--if sprite:GetAnimation() == "BigJumpUp" or sprite:GetAnimation() == "BigJumpDown" then
				if mod.BlackKnight.TeleportAnimations[sprite:GetAnimation()] then
					if buttonAction == ButtonAction.ACTION_BOMB or buttonAction == ButtonAction.ACTION_PILLCARD or buttonAction == ButtonAction.ACTION_ITEM then
						return false
					end
				end
				-- block movement
				if inputHook == 2 then
					if not player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_MEGA_MUSH) and not player:HasCollectible(CollectibleType.COLLECTIBLE_DOGMA) and not player:IsCoopGhost() then
						if buttonAction == ButtonAction.ACTION_LEFT or buttonAction == ButtonAction.ACTION_RIGHT or buttonAction == ButtonAction.ACTION_UP or buttonAction == ButtonAction.ACTION_DOWN then
							return 0
						end
					end
				end
			end
			if player:HasCollectible(mod.Items.WhiteKnight, true) then
				if mod.BlackKnight.TeleportAnimations[sprite:GetAnimation()] then
					if buttonAction == ButtonAction.ACTION_BOMB or buttonAction == ButtonAction.ACTION_PILLCARD or buttonAction == ButtonAction.ACTION_ITEM then
						return false
					end
					if inputHook == 2 then
						if not player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_MEGA_MUSH) and not player:HasCollectible(CollectibleType.COLLECTIBLE_DOGMA) and not player:IsCoopGhost() then
							if buttonAction == ButtonAction.ACTION_LEFT or buttonAction == ButtonAction.ACTION_RIGHT or buttonAction == ButtonAction.ACTION_UP or buttonAction == ButtonAction.ACTION_DOWN then
								return 0
							end
						end
					end
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_INPUT_ACTION, mod.onInputAction)

--- PILL INIT --
function mod:onPostPillInit(pickup) -- pickup
	for playerNum = 0, game:GetNumPlayers()-1 do
		local player = game:GetPlayer(playerNum)
		if not player:HasCurseMistEffect() and not player:IsCoopGhost() then
			if player:HasTrinket(mod.Trinkets.Duotine) then
				local newSub = mod.Pickups.RedPill
				--print(pickup.SubType)
				if pickup.SubType >= PillColor.PILL_GIANT_FLAG then newSub = mod.Pickups.RedPillHorse end
				pickup:Morph(5, 300, newSub, true, false, true)
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, mod.onPostPillInit, PickupVariant.PICKUP_PILL)
--- PICKUP INIT --
function mod:onPostPickupInit(pickup)
	for playerNum = 0, game:GetNumPlayers()-1 do
		local player = game:GetPlayer(playerNum):ToPlayer()
		if not player:HasCurseMistEffect() and not player:IsCoopGhost() then
			-- binder clip
			if player:HasTrinket(mod.Trinkets.BinderClip) then
				local rng = player:GetTrinketRNG(mod.Trinkets.BinderClip)
				if mod.BinderClip.DoublerChance > rng:RandomFloat() then
					local newSub = pickup.SubType
					if pickup.Variant == PickupVariant.PICKUP_HEART and newSub == HeartSubType.HEART_FULL then
						newSub = HeartSubType.HEART_DOUBLEPACK
					elseif pickup.Variant == PickupVariant.PICKUP_COIN and newSub == CoinSubType.COIN_PENNY then
						newSub = CoinSubType.COIN_DOUBLEPACK
					elseif pickup.Variant == PickupVariant.PICKUP_KEY and newSub == KeySubType.KEY_NORMAL then
						newSub = KeySubType.KEY_DOUBLEPACK
					elseif pickup.Variant == PickupVariant.PICKUP_BOMB and newSub == BombSubType.BOMB_NORMAL then
						newSub = BombSubType.BOMB_DOUBLEPACK
					end
					if newSub ~= pickup.SubType then
						pickup:Morph(pickup.Type, pickup.Variant, newSub, true, false, true)
					end
				end
			end
			--local data = player:GetData()
			-- if player has midas curse, turn all pickups into golden
			if player:HasCollectible(mod.Items.MidasCurse) then
				TurnPickupsGold(pickup:ToPickup(), player:GetCollectibleRNG(mod.Items.MidasCurse))
				break
			end

		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, mod.onPostPickupInit)
--- COIN UPDATE --
function mod:onCoinUpdate(pickup)
	local pickupData = pickup:GetData()
	if pickupData.MilkTeethDespawn then
		pickupData.MilkTeethDespawn = pickupData.MilkTeethDespawn - 1
		if pickupData.MilkTeethDespawn <= 0 then
			pickup:Remove()
			Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, pickup.Position, Vector.Zero, nil)
		elseif pickupData.MilkTeethDespawn <= 50 then
			pickup:SetColor(Color(1,1,1,math.sin(pickupData.MilkTeethDespawn*2),0,0,0),1,1,false,false)
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, mod.onCoinUpdate, PickupVariant.PICKUP_COIN)
--- COLLECTIBLE UPDATE --
function mod:CollectibleUpdate(entity)
	if Isaac.GetChallenge() == mod.Challenges.Potatoes then
		local lunch = CollectibleType.COLLECTIBLE_LUNCH
		if entity.SubType ~= lunch and entity.SubType ~= 0 then
			entity:ToPickup():Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, lunch, true)
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, mod.CollectibleUpdate, PickupVariant.PICKUP_COLLECTIBLE)
--- COLLECTIBLE COLLISION --
function mod:onItemCollision(pickup, collider)
	if collider:ToPlayer() then
		local player = collider:ToPlayer()
		if not player:HasCurseMistEffect() and not player:IsCoopGhost() then
			if CheckItemTags(pickup.SubType, ItemConfig.TAG_FOOD) then
				if player:HasCollectible(mod.Items.MidasCurse) and mod.MidasCurse.TurnGoldChance == mod.MidasCurse.MaxGold then
					pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_GOLDEN)
					local rngMidasCurse = player:GetCollectibleRNG(mod.Items.MidasCurse)
					local coinNum = rngMidasCurse:RandomInt(8)+1
					for _ = 1, coinNum do
						local randVector = RandomVector()*coinNum
						Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, 0, pickup.Position, randVector, player)
						--local coin = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, 0, pickup.Position, randVector, player) --anyway turns into golden coin
					end
				end
			end
		end
		--local tempEffects = player:GetEffects()
		if player:HasTrinket(mod.Trinkets.LostFlower) and (player:GetPlayerType() == PlayerType.PLAYER_THELOST or player:GetPlayerType() == PlayerType.PLAYER_THELOST_B or player:GetPlayerType() == mod.Characters.Oblivious) then
			if mod.LostFlower.ItemGiveEternalHeart[pickup.SubType] then
				player:UseCard(Card.CARD_HOLY, myUseFlags) -- give holy card effect
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.onItemCollision, PickupVariant.PICKUP_COLLECTIBLE)
--- PICKUP COLLISION --
function mod:onItemCollision(pickup, collider, _) --add --PickupVariant.PICKUP_SHOPITEM
	if collider:ToPlayer() and pickup.Variant ~= PickupVariant.PICKUP_COLLECTIBLE and pickup.OptionsPickupIndex ~= 0 then
		local player = collider:ToPlayer()
		if not player:HasCurseMistEffect() and not player:IsCoopGhost() then
			if player:HasTrinket(mod.Trinkets.BinderClip) then
				pickup.OptionsPickupIndex = 0
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.onItemCollision)
--- HEART COLLISION --
function mod:onHeartCollision(pickup, collider)
	if collider:ToPlayer() then
		local player = collider:ToPlayer()
		if not player:HasCurseMistEffect() and not player:IsCoopGhost() then
			if player:HasTrinket(mod.Trinkets.LostFlower) then
				local playerType = player:GetPlayerType()
				if playerType == PlayerType.PLAYER_THELOST or playerType == PlayerType.PLAYER_THELOST_B or player:GetPlayerType() == mod.Characters.Oblivious then  -- if player is Lost/T.Lost
					if pickup.SubType == HeartSubType.HEART_ETERNAL then
						player:UseCard(Card.CARD_HOLY,  myUseFlags) -- give holy card effect
					end
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.onHeartCollision, PickupVariant.PICKUP_HEART)
--- BOMB COLLISION --
function mod:onBombPickupCollision(pickup, collider)
	if collider:ToPlayer() then
		local player = collider:ToPlayer()
		if (player:GetPlayerType() == mod.Characters.Nadab or player:GetPlayerType() == mod.Characters.Abihu) and player:HasGoldenBomb() and pickup.SubType == BombSubType.BOMB_GOLDEN then
			player:AddGoldenHearts(1)
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.onBombPickupCollision, PickupVariant.PICKUP_BOMB)
--- TRINKET UPDATE --
function mod:onTrinketUpdate(trinket)
	local dataTrinket = trinket:GetData()
	-- destroy trinket
	if dataTrinket.DespawnTimer then
		trinket.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
		trinket.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_WALLS
		if dataTrinket.DespawnTimer > 25 then -- just decrease timer
			dataTrinket.DespawnTimer = dataTrinket.DespawnTimer - 1
		elseif dataTrinket.DespawnTimer > 5 then -- start fading
			dataTrinket.DespawnTimer = dataTrinket.DespawnTimer - 1
			trinket:SetColor(Color(1, 1, 1, math.sin(dataTrinket.DespawnTimer*2), 0, 0, 0), 1, 1, false, false)
		else -- remove it
			trinket:Remove()
			Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, trinket.Position, Vector.Zero, nil) -- poof effect
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, mod.onTrinketUpdate, PickupVariant.PICKUP_TRINKET)
--- BOMB UPDATE --
function mod:onBombUpdate(bomb)
	local bombSprite = bomb:GetSprite()
	local bombData = bomb:GetData()
	local level = game:GetLevel()
	local room = game:GetRoom()

	if not room:HasCurseMist() then
		if level:GetCurses() & mod.Curses.Bell > 0 and mod.BellCurse[bomb.Variant] and bomb.FrameCount == 1 then
			bomb:Remove()
			Isaac.Spawn(bomb.Type, BombVariant.BOMB_GOLDENTROLL, 0, bomb.Position, bomb.Velocity, bomb.SpawnerEntity)
		end
		if bomb.FrameCount == 0 or (bomb.FrameCount == 1 and (bomb.IsFetus or bombData.Mirror == true or bomb.Variant == BombVariant.BOMB_BIG or bomb.Size == 8.0)) then -- check size for bombs spawned by scatter bombs
			if bomb.SpawnerEntity and bomb.SpawnerType == EntityType.ENTITY_PLAYER then --and not bombData.Modded then
				local player = bomb.SpawnerEntity:ToPlayer()
				local playerData = player:GetData()
				local roomIndex = level:GetCurrentRoomIndex()

				if not playerData.ModdedBombas then playerData.ModdedBombas = {} end
				if playerData.ModdedBombas[roomIndex] == nil then playerData.ModdedBombas[roomIndex] = {} end

				if not bombData.Mirror then
					for _, pos in pairs(playerData.ModdedBombas[roomIndex]) do
						if bomb.Position:Distance(pos[1]) == 0 then
							if pos[2].Gravity then bombData.Gravity = true else bombData.Gravity = false end
							if pos[2].Compo then bombData.Compo = true else bombData.Compo = false end
							if pos[2].Mirror then bombData.Mirror = true else bombData.Mirror = false end
							if pos[2].Frosty then bombData.Frosty = true else bombData.Frosty = false end
							if pos[2].DeadEgg then bombData.DeadEgg = true else bombData.DeadEgg = false end

						end
					end
				end

				--if bombData.Mirror and not bomb.Parent then
				if bombData.Mirror and (not bomb.Parent or bomb.FrameCount == 0) then -- or (bomb.Variant == BombVariant.BOMB_THROWABLE) then -- don't make it elseif cause you need to check it 2 times
					bomb:Remove() -- remove mirror bombs when entering room where you placed bomb. else it would be duplicated
				end

				if playerData.UsedSoulNadabAbihu then
					bomb:AddTearFlags(TearFlags.TEAR_BURN)
				end

				if player:HasCollectible(CollectibleType.COLLECTIBLE_NANCY_BOMBS) then
					if bombData.Frosty == nil and modRNG:RandomFloat() < mod.FrostyBombs.NancyChance then
						InitGravityBomb(bomb, bombData)
					end
					if bombData.Gravity == nil and modRNG:RandomFloat() < mod.GravityBombs.NancyChance then
						InitFrostyBomb(bomb, bombData)
					end
					--if bombData.Dicey == nil and modRNG:RandomFloat() < mod.DiceBombs.NancyChance then
					--  InitDiceyBomb(bomb, bombData)
					--end
				end

				-- mirror
				if player:HasCollectible(mod.Items.MirrorBombs) and not mod.MirrorBombs.Ban[bomb.Variant] and bombData.Mirror ~= true then
					local flipPos = FlipMirrorPos(bomb.Position)
					local mirrorBomb = Isaac.Spawn(bomb.Type, bomb.Variant, bomb.SubType, flipPos, bomb.Velocity, player):ToBomb()
					local mirrorBombData = mirrorBomb:GetData()
					local mirrorBombSprite = mirrorBomb:GetSprite()
					mirrorBombSprite.FlipX = true
					mirrorBombSprite.FlipY = true
					mirrorBomb:AddTearFlags(bomb.Flags)
					mirrorBomb.Parent = bomb
					-- rotate in right pos
					if mirrorBomb.Variant == BombVariant.BOMB_ROCKET_GIGA or mirrorBomb.Variant == BombVariant.BOMB_ROCKET then
						mirrorBombData.RocketMirror = player:GetShootingInput()  -- -rotVec
						mirrorBombSprite.Rotation = mirrorBombData.RocketMirror:GetAngleDegrees()
					end
					if bomb.IsFetus then mirrorBomb.IsFetus = true end

					--set explosion countdown
					SetBombEXCountdown(player, mirrorBomb)

					mirrorBomb:SetColor(Color(1, 1, 1, 0.5, 0, 0, 0), 100, 1, false, false)
					mirrorBomb.FlipX = true
					mirrorBomb.EntityCollisionClass = 0
					mirrorBomb:AddTearFlags(bomb.Flags)
					mirrorBombData.Mirror = true
				end
				--compo
				if player:HasCollectible(mod.Items.CompoBombs) and not mod.CompoBombs.Baned[bomb.Variant] and bombData.Compo ~= false then
					bombData.Compo = true
					local redBomb = Isaac.Spawn(EntityType.ENTITY_BOMB, BombVariant.BOMB_THROWABLE, 0, bomb.Position, bomb.Velocity, player):ToBomb()
					redBomb.Parent = bomb
					redBomb:GetData().RedBomb = true
					redBomb.EntityCollisionClass = 0
					redBomb.FlipX = true
					--set explosion countdown
					if bomb.IsFetus and bomb.FrameCount == 0 then
						bomb:SetExplosionCountdown(mod.CompoBombs.FetusCountdown)
					else
						SetBombEXCountdown(player, redBomb)
					end
					if bomb.IsFetus then redBomb.IsFetus = true end
				end

				-- frosty
				if player:HasCollectible(mod.Items.FrostyBombs) and not mod.FrostyBombs.Ban[bomb.Variant] and bombData.Frosty ~= false then
					local initTrue = true
					if bomb.FrameCount == 1 and bomb.IsFetus and modRNG:RandomFloat() > mod.FrostyBombs.FetusChance + player.Luck/100 then
						initTrue = false
					end
					if initTrue then
						InitFrostyBomb(bomb, bombData)
					end
				end

				-- gravity
				if player:HasCollectible(mod.Items.GravityBombs) and not mod.GravityBombs.Ban[bomb.Variant] and bombData.Gravity ~= false then
					local initTrue = true
					if bomb.FrameCount == 1 and bomb.IsFetus and modRNG:RandomFloat() > mod.GravityBombs.FetusChance + player.Luck/100 then
						initTrue = false
					end
					if initTrue then
						InitGravityBomb(bomb, bombData)
					end
				end

				-- dicey
				--[[
				if player:HasCollectible(mod.Items.DiceBombs) and not mod.DiceBombs.Ban[bomb.Variant] and bombData.Dicey ~= false then
					local initTrue = true
					if bomb.FrameCount == 1 and bomb.IsFetus and modRNG:RandomFloat() > mod.DiceBombs.FetusChance + player.Luck/100 then
						initTrue = false
					end
					if initTrue then
						InitDiceyBomb(bomb, bombData)
					end
				end
				--]]

				-- bob's tongue
				if player:HasTrinket(mod.Trinkets.BobTongue) then
					bombData.BobTongue = true
					local fartRingEffect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.FART_RING, 0, bomb.Position, Vector.Zero, bomb):ToEffect()
					fartRingEffect:GetData().BobTongue = true
					fartRingEffect.Parent = bomb
					fartRingEffect.SpriteScale = fartRingEffect.SpriteScale * 0.8
					--fartRingEffect.Size = 0.5
				end

				if player:HasTrinket(mod.Trinkets.DeadEgg) then
					bombData.DeadEgg = true
				end
			end
		end
	end
	-- mirror bombs
	if bombData.Mirror then
		bomb:SetColor(Color(1, 1, 1, 0.5, 0, 0, 0), 100, 1, false, false)
		bomb.EntityCollisionClass = 0 -- EntityCollisionClass.ENTCOLL_NONE
		bomb.FlipX = true
		if bombData.RocketMirror then
			bombSprite.Rotation = bombData.RocketMirror:GetAngleDegrees()
		end
		if bomb.Parent then
			local flipPos = FlipMirrorPos(bomb.Parent.Position)
			bomb.Position = flipPos
		else
			bomb:SetExplosionCountdown(0)
			--bomb:Remove()
		end
	end
	--compo bombs
	if bombData.RedBomb then
		if bomb.Parent then
			bomb.EntityCollisionClass = 0 -- EntityCollisionClass.ENTCOLL_NONE
			local flip = true
			local diff = mod.CompoBombs.DimensionX
			if bomb.Parent:GetData().Mirror then diff = -mod.CompoBombs.DimensionX flip = false end -- mirror bombs check
			bomb.FlipX = flip
			bomb.Position = Vector(bomb.Parent.Position.X + diff, bomb.Parent.Position.Y)
		else
			bomb:Remove()
		end
	end
	-- frost bombs
	-- add ice particles after explosion:   EffectVariant.DIAMOND_PARTICLE or EffectVariant.ROCK_PARTICLE
	if bombData.Frosty then
		--local player = bomb.SpawnerEntity:ToPlayer()
		if bomb.FrameCount%8 == 0 then -- spawn every 8th frame
			local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, bombData.CreepVariant, 0, bomb.Position, Vector.Zero, bomb):ToEffect() -- PLAYER_CREEP_RED
			--creep.Size = 0.1
			creep.SpriteScale = creep.SpriteScale * 0.1
			if bombData.FrostyCreepColor then
				creep:SetColor(bombData.FrostyCreepColor, 200, 1, false, false)
			end
		end
	end
	--red scissors
	if mod.RedScissorsMod and mod.RedScissors.TrollBombs[bomb.Variant] then -- if player has red scissors and bombs is trollbombs
		if not bombData.ReplaceFrame then
			bombData.ReplaceFrame = mod.RedScissors.NormalReplaceFrame  -- replace bomb at given frame
			if bomb.Variant == BombVariant.BOMB_GIGA then
				if bomb.SpawnerType == EntityType.ENTITY_PLAYER then -- don't replace giga bombs placed by any player
					bombData.ReplaceFrame = nil
				else
					bombData.ReplaceFrame = mod.RedScissors.GigaReplaceFrame -- replace bomb at given frame
				end
			end
		else
			if bombSprite:IsPlaying("Pulse") and bombSprite:GetFrame() >= bombData.ReplaceFrame then -- replace on given frame of sprite animation
				RedBombReplace(bomb)
			end
		end
	end
	if bombData.newSpritePath then -- for some reason adding tear flags to bombs in lua overrides/removes graphics. cause of this I need to add it on each frame :(
		bombSprite:ReplaceSpritesheet(0, bombData.newSpritePath)
		if not bomb:HasTearFlags(TearFlags.TEAR_BRIMSTONE_BOMB) then -- and not bomb:HasTearFlags(TearFlags.TEAR_GIGA_BOMB) then
			bombSprite:ReplaceSpritesheet(1, mod.FrostyBombs.NoSparksPath)
			--bombSprite:SetLayerFrame(1, -1)
		else
			if bomb:HasTearFlags(TearFlags.TEAR_GIGA_BOMB) then
				bombSprite:ReplaceSpritesheet(1, mod.FrostyBombs.NoSparksPath)
				--bombSprite:SetLayerFrame(1, 100)
			end
		end
		bombSprite:LoadGraphics()
	end
	-- bomb tracing (silly )
	if bomb.FrameCount > 0 and not mod.NoBombTrace[bomb.Variant] and bomb.SpawnerEntity and not bombData.bomby then -- trace bombs so you wont apply bomb effect on earlier placed bombs (such as placing bomb and leaving room, picking mod bomb item and then reentering room)
		if bomb.SpawnerEntity:ToPlayer() then--if bomb.SpawnerType == EntityType.ENTITY_PLAYER then
			local ppl = bomb.SpawnerEntity:ToPlayer()
			if ppl:GetData().ModdedBombas then
				ppl:GetData().ModdedBombas[level:GetCurrentRoomIndex()][bomb.Index] = {bomb.Position, bombData}
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_BOMB_UPDATE, mod.onBombUpdate)

--- EFFECT UPDATE --dead egg
function mod:onDeadEggEffect(effect)
	local data = effect:GetData()
	if data.DeadEgg and effect.Timeout == 0 then
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, effect.Position, Vector.Zero, nil):SetColor(Color(0,0,0,1,0,0,0),60,1, false, false)
		effect:Remove()
	end
end
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, mod.onDeadEggEffect, EffectVariant.DEAD_BIRD)
--- EFFECT UPDATE --bob's tongue
function mod:onFartRingEffect(fart_ring)
	if fart_ring:GetData().BobTongue then
		if not fart_ring.Parent then
			fart_ring:Remove()
		else
			fart_ring:FollowParent(fart_ring.Parent)
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, mod.onFartRingEffect, EffectVariant.FART_RING)
--- EFFECT UPDATE --black hole bombs
function mod:onGravityHoleUpdate(hole)
	local room = game:GetRoom()
	local holeData = hole:GetData()
	local holeSprite = hole:GetSprite()
	if holeData.Gravity and hole.SubType == 0 then
		if hole and hole.Parent then
			--gravity bombs
			if hole.Parent:ToBomb() then
				hole.Position = Vector(hole.Parent.Position.X+2.5, hole.Parent.Position.Y-6)
			else
				if game:GetFrameCount() %8 == 0 then
					for _, enemy in pairs(Isaac.FindInRadius(hole.Position, 15, EntityPartition.ENEMY)) do
						if enemy:IsVulnerableEnemy() and enemy:IsActiveEnemy() then
							enemy:TakeDamage(hole.Parent:ToPlayer().Damage, DamageFlag.DAMAGE_IGNORE_ARMOR, EntityRef(hole), 0)
						end
					end
				end
				if hole.Timeout == 0 then
					hole.Parent = nil
					return nil
				end
			end

			if holeData.GravityForce < mod.GravityBombs.MaxForce then
				holeData.GravityForce = holeData.GravityForce + mod.GravityBombs.IterForce
			end
			if holeData.GravityRange < mod.GravityBombs.MaxRange then
				holeData.GravityRange = holeData.GravityRange + mod.GravityBombs.IterRange
			end
			if holeData.GravityGridRange < mod.GravityBombs.MaxGrid then
				holeData.GravityGridRange = holeData.GravityGridRange + mod.GravityBombs.IterGrid
			end
			game:Darken(1, 1)
			game:UpdateStrangeAttractor(hole.Position, holeData.GravityForce, holeData.GravityRange)
			for gindex=1, room:GetGridSize() do -- destroy grid entities near black hole bombs
				local grid = room:GetGridEntity(gindex)
				if grid then
					if grid:ToRock() or grid:ToPoop() then
						--[
						if hole.Position:Distance(grid.Position) < holeData.GravityGridRange and grid.State < 2 then
							game:SpawnParticles(grid.Position, EffectVariant.DARK_BALL_SMOKE_PARTICLE, 1, 5, _, 5)
						end
						--]]
						if hole.Position:Distance(grid.Position) < holeData.GravityGridRange then
							grid:Destroy()
						end
					end
				end
			end
			if holeSprite:IsFinished("Open") and not holeSprite:IsPlaying("Close") then
				holeSprite:Play("Idle", true)
			end
			if not sfx:IsPlaying(SoundEffect.SOUND_BLOOD_LASER_LARGE) then
				sfx:Play(SoundEffect.SOUND_BLOOD_LASER_LARGE,_,_,_,0.2,0)
			end
		else --else
			if holeSprite:IsFinished("Close") then
				hole:Remove()
				sfx:Stop(SoundEffect.SOUND_BLOOD_LASER_LARGE)
			end
			if not holeSprite:IsPlaying("Close") then
				holeSprite:Play("Close", true)
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, mod.onGravityHoleUpdate,  mod.GravityBombs.BlackHoleEffect) -- idk why it triggers when I use ingame black hole item (when using Fusion card)
--- EFFECT UPDATE --moonlighter
function mod:onKeeperMirrorTargetEffect(target)
	--local player = target.Parent:ToPlayer()
	local targetSprite = target:GetSprite()
	target.Velocity = target.Velocity * 0.7
	target.DepthOffset = -100
	if target.GridCollisionClass ~= EntityGridCollisionClass.GRIDCOLL_WALLS then
		target.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_WALLS
	end
	targetSprite:Play("Blink")
end
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, mod.onKeeperMirrorTargetEffect, mod.KeeperMirror.Target)
--- EFFECT UPDATE --black/white knight
function mod:onBlackKnightTargetEffect(target)
	--- COPY from Edith mod ------------
	local ready = false
	local player = target.Parent:ToPlayer()
	--local data = player:GetData()
	local room = game:GetRoom()
	local tSprite = target:GetSprite()
	target.Velocity = target.Velocity * 0.7
	target.DepthOffset = -100
	if target.GridCollisionClass ~= EntityGridCollisionClass.GRIDCOLL_WALLS then
		target.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_WALLS
	end
	if player:GetActiveItem(ActiveSlot.SLOT_PRIMARY) == mod.Items.BlackKnight then
		if player:GetActiveCharge(ActiveSlot.SLOT_PRIMARY) >= Isaac.GetItemConfig():GetCollectible(mod.Items.BlackKnight).MaxCharges then
			ready = true
		end
	end
	local gridEntity = room:GetGridEntityFromPos(target.Position)
	if gridEntity and not player.CanFly then
		if gridEntity.Desc.Type == GridEntityType.GRID_PIT and gridEntity.Desc.State ~= 1 then
			ready = false
		end
	end
	if ready and not tSprite:IsPlaying("Blink") then
		tSprite:Play("Blink")
	end
end
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, mod.onBlackKnightTargetEffect ,mod.BlackKnight.Target)
--- EFFECT UPDATE --Elder Sign
function mod:onElderSignPentagramUpdate(pentagram)
	if pentagram:GetData().ElderSign and pentagram.SpawnerEntity then
		if pentagram.FrameCount == pentagram:GetData().ElderSign then
			local purgesoul = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PURGATORY, 1, pentagram.Position, Vector.Zero, player):ToEffect() -- subtype = 0 is rift, 1 is soul
			purgesoul.Color = Color(0.2,0.5,0.2,1)
		end
		-- get enemies in range
		local enemies = Isaac.FindInRadius(pentagram.Position, mod.ElderSign.AuraRange-10, EntityPartition.ENEMY)
		if #enemies > 0 then
			for _, enemy in pairs(enemies) do
				if enemy:IsVulnerableEnemy() and enemy:IsActiveEnemy() then
					enemy:AddFreeze(EntityRef(pentagram.SpawnerEntity), 1)
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, mod.onElderSignPentagramUpdate, mod.ElderSign.Pentagram)

--- FAMILIAR UPDATE --long elk
function mod:onVertebraeUpdate(fam)
	local famData = fam:GetData() -- get fam data
	if famData.RemoveTimer then
		famData.RemoveTimer = famData.RemoveTimer - 1
		if famData.RemoveTimer <= 0 then
			fam:Kill()
		end
	end
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, mod.onVertebraeUpdate,  FamiliarVariant.BONE_SPUR)
--- FAMILIAR INIT --nadab brain
function mod:onNadabBrainInit(fam)
	fam:AddToFollowers()
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, mod.onNadabBrainInit, mod.NadabBrain.Variant)
--- FAMILIAR COLLISION --nadab brain
function mod:onNadabBrainCollision(fam, collider, _)
	local famData = fam:GetData()
	if famData.IsFloating then
		if collider:ToNPC() and collider.Type == EntityType.ENTITY_FIREPLACE then
			collider:TakeDamage(fam.CollisionDamage, DamageFlag.DAMAGE_COUNTDOWN, EntityRef(fam), 1)
			--fam:GetSprite():Play('Idle', true) -- "drop"
			fam.CollisionDamage = 0
			fam.Velocity = Vector.Zero
			famData.Collided = true
		end
		if collider:IsActiveEnemy() and collider:IsVulnerableEnemy() then
			fam:GetSprite():Play('Idle', true) -- "drop"
			fam.CollisionDamage = 0
			fam.Velocity = Vector.Zero
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_FAMILIAR_COLLISION, mod.onNadabBrainCollision, mod.NadabBrain.Variant)
--- FAMILIAR UPDATE --nadab brain
function mod:OnNadabBrainUpdate(fam)
	local player = fam.Player -- get player
	local sprite = fam:GetSprite() -- get sprite
	local famData = fam:GetData() -- get datatable

	fam.GridCollisionClass = GridCollisionClass.COLLISION_OBJECT and GridCollisionClass.COLLISION_WALL
	fam.EntityCollisionClass = EntityCollisionClass.ENTCOLL_ENEMIES
	fam.CollisionDamage = 0

	-- flip by x
	if fam.Velocity.x ~= 0 then
		fam.FlipX = fam.Velocity.X < 0
	end

	if not sprite:IsPlaying('Idle') and not sprite:IsPlaying('Appear') and not sprite:IsPlaying('Float') and fam.Visible then
		sprite:Play('Float', true)
	end

	if famData.IsFloating then
		--famData.IsHighest = nil
		fam.CollisionDamage = mod.NadabBrain.CollisionDamage
		if player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS) then
			fam.CollisionDamage = mod.NadabBrain.CollisionDamage * 2
		end

		if sprite:IsPlaying('Idle') then
			famData.IsFloating = false
			fam.Visible = false
			famData.Framecount = game:GetFrameCount()
			BrainExplosion(player, fam)
		end

		-- reset at new room
		if game:GetRoom():GetFrameCount() == 0 then
			NadabBrainReset(fam)
		end

		-- collide with grid/wall??
		if fam:CollidesWithGrid() then
			local room = game:GetRoom()
			room:DamageGrid(room:GetGridIndex(fam.Position), 1)
			fam.Velocity = Vector.Zero
		    fam.CollisionDamage = 0
			famData.Collided = true
			--NadabBrainReset(fam)
		end
		if famData.Collided and fam:IsFrame(30, 5) then
			NadabBrainReset(fam)
        end
	else
		fam:FollowParent()
		-- idle
		if (famData.Framecount ~= nil and famData.Framecount + mod.NadabBrain.Respawn <= game:GetFrameCount()) or famData.IsFloating == nil then
			sprite:Play('Appear', true)
			if famData.IsHighest == nil then
				famData.IsHighest = false
			end
			NadabBrainReset(fam)
			--famData.IsFloating = false
			--famData.isReady = false
			--famData.Collided = false
			--fam.CollisionDamage = 0
			--CheckForParent(fam)

			fam.Visible = true
			fam.Velocity = Vector.Zero
			famData.Framecount = nil
		end

		-- is ready to fire
		if famData.isReady and player:GetFireDirection() ~= Direction.NO_DIRECTION and famData.IsHighest then
			fam.Velocity = GetVelocity(player) * mod.NadabBrain.Speed
			--[
			local child = fam.Child
            local parent = fam.Parent
            if child ~= nil then
                child.Parent = fam.Parent
            end
            if parent ~= nil then
                parent.Child = fam.Child
            end
			--]
			famData.IsFloating = true
		else
			local parent = fam.Parent or player
			local distance = parent.Position:Distance(fam.Position)
			famData.isReady = false
			if not famData.isReady and distance <= mod.NadabBrain.MaxDistance and fam:IsFrame(30, 5) then
				famData.isReady = true
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, mod.OnNadabBrainUpdate, mod.NadabBrain.Variant)
--- FAMILIAR INIT --lililith
function mod:onLililithInit(fam)
	fam:GetSprite():Play("FloatDown")
	fam:GetData().GenPickup = false
	fam:GetData().GenChanceUp = 0
	fam:AddToFollowers()
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, mod.onLililithInit, mod.Lililith.Variant)
--- FAMILIAR UPDATE --lililith
function mod:onLililithUpdate(fam)
	local player = fam.Player -- get player
	local data = player:GetData()
	local tempEffects = player:GetEffects()
	local famData = fam:GetData() -- get fam data
	local room = game:GetRoom()
	local famSprite = fam:GetSprite()
	CheckForParent(fam)
	fam:FollowParent()

	if not mod.PreRoomState and not famData.GenPickup and room:IsClear() then
		local rng = player:GetCollectibleRNG(mod.Items.Lililith)
		famData.GenPickup = true
		--if not famData.GenChanceUp then famData.GenChanceUp = 0 end
		famData.GenChanceUp = famData.GenChanceUp or 0
		if rng:RandomFloat() < mod.Lililith.GenChance + famData.GenChanceUp then
			famData.GenChanceUp = 0
			famData.GenIndex = rng:RandomInt(#data.LililithDemonSpawn)+1
			famSprite:Play("Spawn")
		else
			famData.GenChanceUp = famData.GenChanceUp + mod.Lililith.ChanceUp
		end
	end
	if famSprite:IsFinished("Spawn") and famData.GenPickup then
		if famData.GenIndex then
			--Isaac.Spawn(EntityType.ENTITY_FAMILIAR, data.LililithDemonSpawn[famData.GenIndex][2], 0, fam.Position, Vector.Zero, fam)
			tempEffects:AddCollectibleEffect(data.LililithDemonSpawn[famData.GenIndex][1], false, 1)
			data.LililithDemonSpawn[famData.GenIndex][3] = data.LililithDemonSpawn[famData.GenIndex][3] + 1
			famSprite:Play("FloatDown")
			famData.GenIndex = nil
		end
	end
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, mod.onLililithUpdate, mod.Lililith.Variant)
--- FAMILIAR INIT --red bag
function mod:onRedBagInit(fam)
	fam:GetSprite():Play("FloatDown")
	fam:GetData().GenPickup = false
	fam:GetData().GenChanceUp = 0
	fam:AddToFollowers()
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, mod.onRedBagInit, mod.RedBag.Variant)
--- FAMILIAR UPDATE --red bag
function mod:onRedBagUpdate(fam)
	local player = fam.Player -- get player
	local famData = fam:GetData() -- get fam data
	local room = game:GetRoom()
	local famSprite = fam:GetSprite()
	CheckForParent(fam)
	fam:FollowParent()
	if not mod.PreRoomState and not famData.GenPickup and room:IsClear() then
		local rng = player:GetCollectibleRNG(mod.Items.RedBag)
		famData.GenPickup = true
		--if not famData.GenChanceUp then famData.GenChanceUp = 0 end
		famData.GenChanceUp = famData.GenChanceUp or 0

		if rng:RandomFloat() < mod.RedBag.GenChance + famData.GenChanceUp then
			famData.GenChanceUp = 0
			famData.GenIndex = rng:RandomInt(#mod.RedBag.RedPickups)+1
			famSprite:Play("Spawn")
		elseif rng:RandomFloat() < mod.RedBag.RedPoopChance then
			famData.GenChanceUp = famData.GenChanceUp + mod.RedBag.ChanceUp
			famData.PoopIndex = true
			famSprite:Play("Spawn")
		end
	end
	if famSprite:IsFinished("Spawn") and famData.GenPickup then
		if famData.GenIndex then
			Isaac.Spawn(EntityType.ENTITY_PICKUP, mod.RedBag.RedPickups[famData.GenIndex][1], mod.RedBag.RedPickups[famData.GenIndex][2], fam.Position, Vector.Zero, nil)
			local effect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, fam.Position, Vector.Zero, nil)
			effect:SetColor(mod.RedColor, 50, 1, false, false)
			famSprite:Play("FloatDown")
			famData.GenIndex = nil
		elseif famData.PoopIndex then
			Isaac.GridSpawn(GridEntityType.GRID_POOP, 1, fam.Position, false)
			--effect:SetColor(mod.RedColor, 50, 1, false, false)
			famSprite:Play("FloatDown")
			famData.PoopIndex = nil
		end
	end
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, mod.onRedBagUpdate, mod.RedBag.Variant)
--- FAMILIAR INIT --abihu
function mod:onAbihuFamInit(fam)
	if fam.SubType == mod.AbihuFam.Subtype then
		fam:GetData().CollisionTime = 0
	end
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, mod.onAbihuFamInit, mod.AbihuFam.Variant)
--- FAMILIAR UPDATE --abihu
function mod:onAbihuFamUpdate(fam)
	--local player = fam.Player
	local famData = fam:GetData()
	if fam.SubType > 1 then -- else he will move only if enemies near him
		fam.SubType = 0
	end
	if famData.CollisionTime then
		if famData.CollisionTime > 0 then
			famData.CollisionTime = famData.CollisionTime - 1
		end
	end
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, mod.onAbihuFamUpdate, mod.AbihuFam.Variant)
--- FAMILIAR TAKE DMG --abihu
function mod:onFamiliarTakeDamage(entity, _, damageFlag, source, _) --entity, amount, flags, source, countdown
	-- abihu fam take dmg
	if entity.Variant == mod.AbihuFam.Variant then
		entity = entity:ToFamiliar()
		local famData = entity:GetData()
		if famData.CollisionTime then
			if famData.CollisionTime == 0 then
				local player = entity.Player
				famData.CollisionTime = mod.AbihuFam.CollisionTime
				if damageFlag & DamageFlag.DAMAGE_TNT == 0 and source.Entity then -- idk but tries to add burn to tnt
					source.Entity:AddBurn(EntityRef(player), mod.AbihuFam.BurnTime, player.Damage)
				end
				if player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS) then
					CircleSpawn(entity, mod.AbihuFam.SpawnRadius, 0, EntityType.ENTITY_EFFECT, EffectVariant.FIRE_JET, 0)
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.onFamiliarTakeDamage, EntityType.ENTITY_FAMILIAR)

---USE ITEM---
do
---book of memories
function mod:onBookMemoryItem(_, _, player) --item, rng, player, useFlag, activeSlot, customVarData
	local entities = Isaac.FindInRadius(player.Position, 5000, EntityPartition.ENEMY)
	if #entities > 0 then
		for _, entity in pairs(Isaac.FindInRadius(player.Position, 5000, EntityPartition.ENEMY)) do
			if not entity:IsBoss() and entity.Type ~= EntityType.ENTITY_FIREPLACE then
				table.insert(mod.Lobotomy.ErasedEntities, {entity.Type, entity.Variant})
				Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, entity.Position, Vector.Zero, nil):SetColor(mod.OblivionCard.PoofColor,50,1, false, false)
				entity:Remove()
			end
		end
		sfx:Play(316)
		player:AddBrokenHearts(1)
		return true
	end
	return {ShowAnim = false, Remove = false, Discharge = false}
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.onBookMemoryItem, mod.Items.BookMemory)
--[[
function mod:onBookMemoryItem(item, rng, player, useFlag) --item, rng, player, useFlag, activeSlot, customVarData
	local data = player:GetData()
	if item == mod.Items.BookMemory then
		local res = MemoryBookManager(rng, player)
		if res then
			DebugSpawn(350, mod.Trinkets.MemoryFragment, player.Position)
			DebugSpawn(300, mod.Pickups.OblivionCard, player.Position)
		end
		return {ShowAnim = true, Remove = res, Discharge = true}
	elseif useFlag & myUseFlags == 0 or useFlag & UseFlag.USE_MIMIC == 0 then
		if not data.MemoryBoolPool then data.MemoryBoolPool = {} end
		if not data.MemoryBoolPool.Items then data.MemoryBoolPool.Items = {} end
		data.MemoryBoolPool.Items[item] = true
	end
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.onBookMemoryItem) --mod.Items.BookMemory
function mod:onBookMemoryCard(card, player, useFlag) -- card, player, useFlag
	if useFlag & myUseFlags == 0 or useFlag & UseFlag.USE_MIMIC == 0 then
		local data = player:GetData()
		if not data.MemoryBoolPool then data.MemoryBoolPool = {} end
		if not data.MemoryBoolPool.Cards then data.MemoryBoolPool.Cards = {} end
		data.MemoryBoolPool.Cards[card] = true

		if player:HasTrinket(mod.Trinkets.MemoryFragment) then
			if not data.MemoryFragment then data.MemoryFragment = {} end
			table.insert(data.MemoryFragment, {300, card})
		end
	end
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onBookMemoryCard)
function mod:onBookMemoryPill(pillEffect, player, useFlag) --pillEffect, player, flags
	if useFlag & myUseFlags == 0 or useFlag & UseFlag.USE_MIMIC == 0 then
		local data = player:GetData()
		if not data.MemoryBoolPool then data.MemoryBoolPool = {} end
		if not data.MemoryBoolPool.Pills then data.MemoryBoolPool.Pills = {} end
		data.MemoryBoolPool.Pills[pillEffect] = true
		if player:HasTrinket(mod.Trinkets.MemoryFragment) then
			if not data.MemoryFragment then data.MemoryFragment = {} end
			table.insert(data.MemoryFragment, {70, pillEffect})
		end
	end
end
mod:AddCallback(ModCallbacks.MC_USE_PILL, mod.onBookMemoryPill)
--]]
---Floppy Disk Empty
function mod:onFloppyDisk(_, _, player) --item, rng, player, useFlag, activeSlot, customVarData
	StorePlayerItems(player) -- save player items in table
	return {ShowAnim = true, Remove = true, Discharge = true} -- remove this item after use
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.onFloppyDisk, mod.Items.FloppyDisk)
---Floppy Disk Full
function mod:onFloppyDiskFull(_, _, player) --item, rng, player, useFlag, activeSlot, customVarData
	--- player use floppy disk
	ReplacePlayerItems(player) -- replace player items
	game:ShowHallucination(5, 0)
	if sfx:IsPlaying(SoundEffect.SOUND_DEATH_CARD) then
		sfx:Stop(SoundEffect.SOUND_DEATH_CARD)
	end
	return {ShowAnim = true, Remove = true, Discharge = true} -- remove this item after use
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.onFloppyDiskFull, mod.Items.FloppyDiskFull)
---Red Mirror
function mod:onRedMirror(_, _, player) --item, rng, player, useFlag, activeSlot, customVarData
	local nearest = 5000
	local trinkets = Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET)
	if #trinkets > 0 then
		local pickups = trinkets[1]
		for _, trinket in pairs(trinkets) do
			if player.Position:Distance(trinket.Position) < nearest then
				pickups = trinket
				nearest = player.Position:Distance(trinket.Position)
			end
		end
		pickups:ToPickup():Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, Card.CARD_CRACKED_KEY, false, false, false) -- morph first one into cracked key
		local effect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, pickups.Position, Vector.Zero, nil)
		effect:SetColor(mod.RedColor, 50, 1, false, false) -- red poof effect
	end
	return true -- show use animation
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.onRedMirror, mod.Items.RedMirror)
---BlackKnight
function mod:onBlackKnight(_, _, player) --item, rng, player, useFlag, activeSlot, customVarData
	local discharge = false
	local data = player:GetData()
	local sprite = player:GetSprite()
	if data.KnightTarget and data.KnightTarget:Exists() then
		if mod.BlackKnight.IgnoreAnimations[sprite:GetAnimation()] then
			if data.KnightTarget:GetSprite():IsPlaying("Blink") then
				--player:PlayExtraAnimation("BigJumpUp")
				data.Jumped = true
				player:PlayExtraAnimation("TeleportUp")
				player:SetMinDamageCooldown(mod.BlackKnight.InvFrames) -- invincibility frames
				discharge = true
			end
		end
	end
	return {ShowAnim = false, Remove = false, Discharge = discharge}
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.onBlackKnight, mod.Items.BlackKnight)
---KeeperMirror
function mod:onKeeperMirror(item, _, player) --item, rng, player, useFlag, activeSlot, customVarData
	local data = player:GetData()
	--data.KeeperMirror = true
	data.KeeperMirror = Isaac.Spawn(1000, mod.KeeperMirror.Target, 0, player.Position, Vector.Zero, player):ToEffect()
	data.KeeperMirror.Parent = player
	data.KeeperMirror:SetTimeout(mod.KeeperMirror.TargetTimeout)
	--player:GetSprite():Play("PickupWalkDown", true)
	player:AnimateCollectible(item)
	return false
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.onKeeperMirror, mod.Items.KeeperMirror)
---pony
function mod:onMiniPony(_, _, player) --item, rng, player, useFlag, activeSlot, customVarData
	player:UseActiveItem(CollectibleType.COLLECTIBLE_MY_LITTLE_UNICORN, myUseFlags)
	return false
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.onMiniPony, mod.Items.MiniPony)
---strange box
function mod:onStrangeBox(_, rng, _) --item, rng, player, useFlag, activeSlot, customVarData
	--- player use strange box
	--local allPickups = Isaac.FindByType(EntityType.ENTITY_PICKUP)
	local savedOptions = {}
	for _, pickup in pairs(Isaac.FindByType(EntityType.ENTITY_PICKUP)) do
		pickup = pickup:ToPickup()
		if pickup.OptionsPickupIndex == 0 then -- if pickup don't have option index
			pickup.OptionsPickupIndex = rng:RandomInt(Random())+1 -- get random number
		end
		if savedOptions[pickup.OptionsPickupIndex] == nil then
			savedOptions[pickup.OptionsPickupIndex] = true
			if pickup:IsShopItem() then
				--print(pickup.Variant, pickup.SubType)
				local optionPickup = Isaac.Spawn(EntityType.ENTITY_PICKUP,  PickupVariant.PICKUP_SHOPITEM, 0, Isaac.GetFreeNearPosition(pickup.Position, 0), Vector.Zero, nil)
				optionPickup:ToPickup().OptionsPickupIndex = pickup.OptionsPickupIndex -- spawn another collectible and set option index
			elseif pickup.Variant == PickupVariant.PICKUP_COLLECTIBLE and pickup.SubType ~= 0 then -- if pickup is collectible item
				--local conf = Isaac.GetItemConfig()
				--if conf:GetCollectible(pickup.SubType) then -- if not empty item pedestal
				local optionPickup = Isaac.Spawn(pickup.Type, pickup.Variant, CollectibleType.COLLECTIBLE_NULL, Isaac.GetFreeNearPosition(pickup.Position, 40), Vector.Zero, nil)
				optionPickup:ToPickup().OptionsPickupIndex = pickup.OptionsPickupIndex -- spawn another collectible and set option index
				--end
			else
				for _, variant in pairs(mod.StrangeBox.Variants) do
					if pickup.Variant == variant then
						local optionType = EntityType.ENTITY_PICKUP
						local optionVariant = 0 --mod.StrangeBox.Variants[rng:RandomInt(#mod.StrangeBox.Variants)+1]
						local optionSubtype = 0 -- idk if it would be random
						local optionPickup = Isaac.Spawn(optionType, optionVariant, optionSubtype, Isaac.GetFreeNearPosition(pickup.Position, 0), Vector.Zero, nil)
						optionPickup:ToPickup().OptionsPickupIndex = pickup.OptionsPickupIndex -- spawn another collectible and set option index
						break
					end
				end
			end
		end
	end
	return true --{ShowAnim = true, Remove = false, Discharge = true}
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.onStrangeBox, mod.Items.StrangeBox)
---lost mirror
function mod:onLostMirror(_, _, player) --item, rng, player, useFlag, activeSlot, customVarData
	--player:ChangePlayerType(10)
	--- player use lost mirror
	local tempEffects = player:GetEffects()
	tempEffects:AddNullEffect(NullItemID.ID_LOST_CURSE, true, 1)
 	--player:UseCard(Card.CARD_HOLY, myUseFlags)
	if player:HasTrinket(mod.Trinkets.LostFlower) then
		player:UseCard(Card.CARD_HOLY, myUseFlags)
	end
	return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.onLostMirror, mod.Items.LostMirror)
---lost flower + prayer card
function mod:onPrayerCard(_, _, player) --item, rng, player, useFlag, activeSlot, customVarData
	--- player use prayer card
	--- lost flower
	--if you lost/t.lost for getting eternal heart give holy card effect
	if player:HasTrinket(mod.Trinkets.LostFlower) then -- if player has lost flower trinket
		local playerType = player:GetPlayerType()
		if playerType == PlayerType.PLAYER_THELOST or playerType == PlayerType.PLAYER_THELOST_B or player:GetPlayerType() == mod.Characters.Oblivious then
			player:UseCard(Card.CARD_HOLY,  myUseFlags)
		end
	end
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.onPrayerCard, CollectibleType.COLLECTIBLE_PRAYER_CARD)
---bleeding grimoire
function mod:onBleedingGrimoire(_, _, player) --item, rng, player, useFlag, activeSlot, customVarData
	local data = player:GetData()
	player:AddEntityFlags(EntityFlag.FLAG_BLEED_OUT)
	player:AddNullCostume(mod.BG.Costume)
	data.UsedBG = true
	return true -- {Discharge = true, Remove = true, ShowAnim = true}
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.onBleedingGrimoire, mod.Items.BleedingGrimoire)
---black book
function mod:onBlackBook(_, rng, player) --item, rng, player, useFlag, activeSlot, customVarData
	for _, entity in pairs(Isaac.FindInRadius(player.Position, 5000, EntityPartition.ENEMY)) do
		if entity:IsVulnerableEnemy() and entity:IsActiveEnemy() then
			entity = entity:ToNPC()
			entity:RemoveStatusEffects()
			local index = rng:RandomInt(#mod.BlackBook.EffectFlags)+1
			--entity:AddEntityFlags(mod.BlackBook.EffectFlags[index][1])
			--entity:SetColor(mod.BlackBook.EffectFlags[index][2], mod.BlackBook.EffectFlags[index][3], 1, false, false)
			--entity:GetData().BlackBooked = mod.BlackBook.EffectFlags[index][3]
			if index == 1 then
				entity:AddFreeze(EntityRef(player), mod.BlackBook.EffectFlags[index][3])
			elseif index == 2 then -- poison
				entity:AddPoison(EntityRef(player), mod.BlackBook.EffectFlags[index][3], player.Damage)
			elseif index == 3 then -- slow
				entity:AddSlowing(EntityRef(player),  mod.BlackBook.EffectFlags[index][3], 0.5, mod.BlackBook.EffectFlags[index][2])
			elseif index == 4 then -- charm
				entity:AddCharmed(EntityRef(player), mod.BlackBook.EffectFlags[index][3])
			elseif index == 5 then -- confusion
				entity:AddConfusion(EntityRef(player), mod.BlackBook.EffectFlags[index][3], false)
			elseif index == 6 then -- midas freeze
				entity:AddMidasFreeze(EntityRef(player), mod.BlackBook.EffectFlags[index][3])
			elseif index == 7 then -- fear
				entity:AddFear(EntityRef(player),mod.BlackBook.EffectFlags[index][3])
			elseif index == 8 then -- burn
				entity:AddBurn(EntityRef(player), mod.BlackBook.EffectFlags[index][3], 1) -- player.Damage)
			elseif index == 9 then -- shrink
				entity:AddShrink(EntityRef(player), mod.BlackBook.EffectFlags[index][3])
			elseif index == 10 then -- bleed
				entity:AddEntityFlags(mod.BlackBook.EffectFlags[index][1])
				entity:SetColor(mod.BlackBook.EffectFlags[index][2], mod.BlackBook.EffectFlags[index][3], 1, false, false)
			elseif index == 11 then -- ice
				entity:AddEntityFlags(mod.BlackBook.EffectFlags[index][1])
				entity:SetColor(mod.BlackBook.EffectFlags[index][2], mod.BlackBook.EffectFlags[index][3], 1, false, false)
			elseif index == 12 then -- magnet
				entity:AddEntityFlags(mod.BlackBook.EffectFlags[index][1])
				entity:SetColor(mod.BlackBook.EffectFlags[index][2], mod.BlackBook.EffectFlags[index][3], 1, false, false)
			elseif index == 13 then -- baited
				entity:AddEntityFlags(mod.BlackBook.EffectFlags[index][1])
				entity:SetColor(mod.BlackBook.EffectFlags[index][2], mod.BlackBook.EffectFlags[index][3], 1, false, false)
			end
		end
	end
	return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.onBlackBook, mod.Items.BlackBook)
---scrambled rubik's dice
function mod:onRubikDiceScrambled(item, _, player) --item, rng, player, useFlag, activeSlot, customVarData
	for _, Scrambledice in pairs(mod.RubikDice.ScrambledDicesList) do
		if item == Scrambledice then
			--- player use rubik's dice
			RerollTMTRAINER(player)
			return true
		end
	end
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.onRubikDiceScrambled) -- called for all items
---rubik's dice
function mod:onRubikDice(_, rng, player) --item, rng, player, useFlag, activeSlot, customVarData
	--- player use rubik's dice
	if rng:RandomFloat() < mod.RubikDice.GlitchReroll then -- and (useFlag & UseFlag.USE_OWNED == 0) and (useFlag & UseFlag.USE_MIMIC == 0) then
		--player:RemoveCollectible(mod.Items.RubikDice)
		local Newdice = mod.RubikDice.ScrambledDicesList[rng:RandomInt(#mod.RubikDice.ScrambledDicesList)+1]
		player:AddCollectible(Newdice) --Newdice / mod.Items.RubikDiceScrambled
		RerollTMTRAINER(player, Newdice) -- Newdice / mod.Items.RubikDiceScrambled
	else
		player:UseActiveItem(CollectibleType.COLLECTIBLE_D6, myUseFlags)
		return true
	end
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.onRubikDice, mod.Items.RubikDice)
---vhs cassette
function mod:onVHSCassette(_, rng, _) --item, rng, player, useFlag, activeSlot, customVarData
	local level = game:GetLevel()
	local stage = level:GetStage()
	if mod.VHS.tableVHS then
		if level:IsAscent() then
			Isaac.ExecuteCommand("stage 13")
		elseif not game:IsGreedMode() and stage < 12 then
			local newStage = rng:RandomInt(12)+1
			if newStage <= stage then newStage = stage+1 end
			local randStageType = 1
			if newStage ~= 9 then randStageType = rng:RandomInt(#mod.VHS.tableVHS[newStage])+1 end
			newStage = "stage " .. mod.VHS.tableVHS[newStage][randStageType]
			mod.VHS.tableVHS = nil
			Isaac.ExecuteCommand(newStage)
		end
	end
	game:ShowHallucination(5, 0)
	if sfx:IsPlaying(SoundEffect.SOUND_DEATH_CARD) then
		sfx:Stop(SoundEffect.SOUND_DEATH_CARD)
	end
	sfx:Play(SoundEffect.SOUND_STATIC)
	return  {ShowAnim = true, Remove = true, Discharge = true}
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.onVHSCassette, mod.Items.VHSCassette)
---long elk
function mod:onLongElk(_, _, player) --item, rng, player, useFlag, activeSlot, customVarData
	local data = player:GetData()
	data.ElkKiller = true
	--player:UseActiveItem(CollectibleType.COLLECTIBLE_PONY, myUseFlags)
	local tempEffects = player:GetEffects()
	tempEffects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_MARS, false, 1)
	-- set player color or add some indicator
	return false
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.onLongElk, mod.Items.LongElk)
---WhiteKnight
function mod:onWhiteKnight(_, _, player) --item, rng, player, useFlag, activeSlot, customVarData
	local discharge = false
	local data = player:GetData()
	local sprite = player:GetSprite()
	-- if animation is right tp to nearest enemy/door
	if mod.BlackKnight.IgnoreAnimations[sprite:GetAnimation()] then
		data.Jumped = true
		player:PlayExtraAnimation("TeleportUp")
		player:SetMinDamageCooldown(mod.BlackKnight.InvFrames) -- invincibility frames
		discharge = true
	end
	-- do not show use animation
	return {ShowAnim = false, Remove = false, Discharge = discharge}
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.onWhiteKnight, mod.Items.WhiteKnight)
---charon's obol
function mod:onCharonObol(_, _, player) --item, rng, player, useFlag, activeSlot, customVarData
	-- spawn soul if you have coins
	if player:GetNumCoins() > 0 then
		player:AddCoins(-1)
		-- take 1 coin and spawn
		local soul = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HUNGRY_SOUL, 1, player.Position, Vector.Zero, player):ToEffect()
		soul:SetTimeout(mod.CharonObol.Timeout)
		return true
	end
	return false
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.onCharonObol, mod.Items.CharonObol)
---Red Pill Placebo
function mod:onRedPillPlacebo(_, _, player) --item, rng, player, useFlag, activeSlot, customVarData
	local pill = player:GetCard(0)
	if pill == mod.Pickups.RedPill or pill == mod.Pickups.RedPillHorse then
		player:UseCard(pill, UseFlag.USE_MIMIC)
	end
	--return {ShowAnim = true, Remove = false, Discharge = true}
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.onRedPillPlacebo, CollectibleType.COLLECTIBLE_PLACEBO)
---Space Jam
function mod:onCosmicJam(_, _, player) --item, rng, player, useFlag, activeSlot, customVarData
	local items = Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE)
	local distance = 5000
	local nearestItem
	if #items > 0 then
		for _, item in pairs(items) do
			if item.SubType ~= 0 and not CheckItemTags(item.SubType, ItemConfig.TAG_QUEST) and player.Position:Distance(item.Position) < distance then
				nearestItem = item
				distance = player.Position:Distance(item.Position)
			end
		end
		if nearestItem then
			player:AddItemWisp(nearestItem.SubType, nearestItem.Position)
			sfx:Play(579)
		end
	end
	AddItemFromWisp(player, true, true, true)
	return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.onCosmicJam, mod.Items.CosmicJam)
---Elder Sign
function mod:onUseElderSign(_, _, player)
    local pentagram = Isaac.Spawn(EntityType.ENTITY_EFFECT, mod.ElderSign.Pentagram, 0, player.Position, Vector.Zero, player):ToEffect()
	pentagram.SpriteScale = pentagram.SpriteScale * mod.ElderSign.AuraRange/100
	pentagram.Color = Color(0,1,0,1)
	pentagram:GetData().ElderSign = mod.ElderSign.Timeout
    return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.onUseElderSign, mod.Items.ElderSign)
end

---USE CARD/PILL---
do
---Apocalypse card
function mod:onApocalypse(card, player) -- card, player, useflag
	-- fill the room with poop and turn them into red poop
	local room = game:GetRoom()
	local level = game:GetLevel()
	mod.Apocalypse.Room = level:GetCurrentRoomIndex()
	mod.Apocalypse.RNG = player:GetCardRNG(card)
	room:SetCardAgainstHumanity()
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onApocalypse, mod.Pickups.Apocalypse)
---oblivion card
function mod:onOblivionCard(_, player) -- card, player, useflag
	-- throw chaos card and replace it with oblivion card (MC_POST_TEAR_INIT)
	local data = player:GetData()
	data.UsedOblivionCard = true
	player:UseCard(Card.CARD_CHAOS, myUseFlags)
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onOblivionCard, mod.Pickups.OblivionCard)
---King Chess black
function mod:onKingChess(_, player) -- card, player, useflag
	-- spawn black poops
	--SquareSpawn(player, 40, 0, EntityType.ENTITY_POOP, 15, 0)
	MyGridSpawn(player, 40, GridEntityType.GRID_POOP, 5, true)
	--[[
	0 - normal
	1 - red
	2 - corn
	3 - golden
	4 - colorful
	5 - black
	6 - white
	--]]
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onKingChess, mod.Pickups.KingChess)
---King Chess white
function mod:onKingChessW(_, player) -- card, player, useflag
	-- spawn white/stone poops
	SquareSpawn(player, 40, 0, EntityType.ENTITY_POOP, 11, 0)
	--MyGridSpawn(player, 40, GridEntityType.GRID_POOP, 6, true) --rng:RandomInt(7)
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onKingChessW, mod.Pickups.KingChessW)
---Trapezohedron
function mod:onTrapezohedron() -- card, player, useflag
	-- turn all trinkets in room into cracked keys
	for _, pickups in pairs(Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET)) do -- get all trinkets in room
		pickups:ToPickup():Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, Card.CARD_CRACKED_KEY, false, false, false) -- morph all trinkets into cracked keys
		local effect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, pickups.Position, Vector.Zero, nil)
		effect:SetColor(mod.RedColor, 50, 1, false, false) -- red poof effect
	end
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onTrapezohedron, mod.Pickups.Trapezohedron)
---red pill
function mod:onRedPill(_, player) -- card, player, useflag
	RedPillManager(player, mod.RedPills.DamageUp, mod.RedPills.WavyCap)
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onRedPill, mod.Pickups.RedPill)
---red pill horse
function mod:onRedPillHorse(_, player) -- card, player, useflag
	RedPillManager(player, mod.RedPills.HorseDamageUp, mod.RedPills.HorseWavyCap)
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onRedPillHorse, mod.Pickups.RedPillHorse)
---domino 3|4
function mod:onDomino34(card, player) -- card, player, useflag
	-- reroll items and pickups on floor
	local rng = player:GetCardRNG(card)
	game:RerollLevelCollectibles()
	game:RerollLevelPickups(rng:GetSeed())
	player:UseCard(Card.CARD_DICE_SHARD, myUseFlags)
	game:ShakeScreen(10)
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onDomino34, mod.Pickups.Domino34)
---domino 2|5
function mod:onDomino25(_, player) -- card, player, useflag
	-- respawn and reroll enemies
	local room = game:GetRoom()
	local data = player:GetData()
	-- after 3 frames reroll enemies
	data.Domino25Used = 3
	room:RespawnEnemies()
	game:ShakeScreen(10)
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onDomino25, mod.Pickups.Domino25)
---domino 0|0
function mod:onDomino00(_, player) -- card, player, useflag
	local enemies = Isaac.FindInRadius(player.Position, 5000, EntityPartition.ENEMY)
	if #enemies > 0 then
		for _, entity in pairs(enemies) do
			if entity:IsVulnerableEnemy() and entity:IsActiveEnemy() and not  entity:IsBoss() then
				entity:AddEntityFlags(EntityFlag.FLAG_SHRINK)
			end
		end
	end
	game:ShakeScreen(10)
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onDomino00, mod.Pickups.Domino00)
---Soul of Unbidden
function mod:onSoulUnbidden(_, player) -- card, player, useflag
	
	if #Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ITEM_WISP)> 0 then
		AddItemFromWisp(player, true, false, false)
	else
		--sfx:Play(SoundEffect.SOUND_DEATH_CARD, 1, 2, false, 1, 0) --sfx:Play(ID, Volume, FrameDelay, Loop, Pitch, Pan)
		SpawnItemWisps(player)
	end
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onSoulUnbidden, mod.Pickups.SoulUnbidden)
---Soul of NadabAbihu
function mod:onSoulNadabAbihu(_, player) -- card, player, useflag
	local data = player:GetData()
	-- add fire tears and explosion immunity
	data.UsedSoulNadabAbihu = true  -- use check in MC_ENTITY_TAKE_DMG for explosion
	local tempEffects = player:GetEffects()
	tempEffects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_FIRE_MIND, false, 1)
	-- hot bombs - just for costume. it doesn't give any actual effect
	tempEffects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_HOT_BOMBS, true, 1)
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onSoulNadabAbihu, mod.Pickups.SoulNadabAbihu)
---ascender bane
function mod:onAscenderBane(_, player) -- card, player, useflag
	--- remove 1 broken heart
	if player:GetBrokenHearts() > 0 then
		player:AddBrokenHearts(-1)
	end
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onAscenderBane, mod.Pickups.AscenderBane)
---multi-cast
function mod:onMultiCast(_, player) -- card, player, useflag
	local activeItem = player:GetActiveItem(0)
	-- replace mod item wisps
	if activeItem ~= 0 and mod.ActiveItemWisps[activeItem] then
		activeItem = mod.ActiveItemWisps[activeItem]
	end
	--if activeItem == 0 then activeItem = 1 end
	for _=1, mod.MultiCast.NumWisps do
		player:AddWisp(activeItem, player.Position)
	end
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onMultiCast, mod.Pickups.MultiCast)
---wish
function mod:onWish(_, player) -- card, player, useflag
	player:UseActiveItem(CollectibleType.COLLECTIBLE_MYSTERY_GIFT, myUseFlags)
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onWish, mod.Pickups.Wish)
---offering
function mod:onOffering(_, player) -- card, player, useflag
	player:UseActiveItem(CollectibleType.COLLECTIBLE_SACRIFICIAL_ALTAR, myUseFlags)
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onOffering, mod.Pickups.Offering)
---infinite blades card
function mod:onInfiniteBlades(_, player) -- card, player, useflag
	local data = player:GetData()
	-- add knifes into stock (shoot knives)
	data.InfiniteBlades = data.InfiniteBlades or 0
	data.InfiniteBlades = data.InfiniteBlades + mod.InfiniteBlades.MaxNumber
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onInfiniteBlades, mod.Pickups.InfiniteBlades)
---transmutation card
function mod:onTransmutation(_, player) -- card, player, useflag
	--- reroll enemies and pickups
	player:UseCard(Card.CARD_ACE_OF_SPADES, myUseFlags)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_D20, myUseFlags)
	--player:UseCard(Card.CARD_DICE_SHARD, myUseFlags)
	--player:UseActiveItem(CollectibleType.COLLECTIBLE_D100, myUseFlags)
	--player:UseActiveItem(CollectibleType.COLLECTIBLE_CLICKER, myUseFlags)
	--game:ShowHallucination(0, BackdropType.NUM_BACKDROPS)
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onTransmutation, mod.Pickups.Transmutation)
---ritual dagger card
function mod:onRitualDagger(_, player) -- card, player, useflag
	--- add mom's knife for room
	local tempEffects = player:GetEffects()
	tempEffects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_MOMS_KNIFE, true, 1)
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onRitualDagger, mod.Pickups.RitualDagger)
---fusion card
function mod:onFusion(_, player) -- card, player, useflag
	--- throw a black hole
	player:UseActiveItem(CollectibleType.COLLECTIBLE_BLACK_HOLE, myUseFlags)
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onFusion, mod.Pickups.Fusion)
---deus ex card
function mod:onDeuxEx(_, player) -- card, player, useflag
	--- add 100 luck
	--- effects based on room type (refuses to elaborate)
	--local level = game:GetLevel()
	--local room = game:GetRoom()
	--local roomType = room:GetType()
	--local rng = player:GetCardRNG(card)
	local data = player:GetData()
	data.DeuxExLuck = data.DeuxExLuck or 0
	data.DeuxExLuck = data.DeuxExLuck + mod.DeuxEx.LuckUp
	player:AddCacheFlags(CacheFlag.CACHE_LUCK)
	player:EvaluateItems()
	-- add new effect for each room type
	--[[ --it works, but meh
	if roomType == RoomType.ROOM_SHOP then
		-- use coupon
		player:UseActiveItem(CollectibleType.COLLECTIBLE_COUPON, myUseFlags)
		-- player:UseCard(Card.CARD_CREDIT, myUseFlags)
		-- DebugSpawn(300, Card.CARD_CREDIT, player.Position)
	elseif roomType == RoomType.ROOM_ERROR then
		-- teleport to random room
		--player:UseCard(Card.CARD_FOOL, myUseFlags)
		game:MoveToRandomRoom(false, rng:GetSeed(), player)
	elseif roomType == RoomType.ROOM_TREASURE then
		-- use dice shard
		player:UseCard(Card.CARD_DICE_SHARD, myUseFlags)
	elseif roomType == RoomType.ROOM_BOSS then
		-- use holy card
		player:UseCard(Card.CARD_HOLY, myUseFlags)
	elseif roomType == RoomType.ROOM_MINIBOSS then
		-- use holy card
		player:UseCard(Card.CARD_HOLY, myUseFlags)
	elseif roomType == RoomType.ROOM_SECRET then --
		-- use jera, add X-ray vision
		level:SetCanSeeEverything(true)
		player:UseCard(Card.RUNE_JERA, myUseFlags)
	elseif roomType == RoomType.ROOM_SUPERSECRET then
		-- use jera, add X-ray vision
		level:SetCanSeeEverything(true)
		player:UseCard(Card.RUNE_JERA, myUseFlags)
	elseif roomType == RoomType.ROOM_ARCADE then
		-- use d20
		player:UseActiveItem(CollectibleType.COLLECTIBLE_D20, myUseFlags)
	elseif roomType == RoomType.ROOM_CURSE then
		-- tp to random room
		game:MoveToRandomRoom(false, rng:GetSeed(), player)
	elseif roomType == RoomType.ROOM_CHALLENGE then
		-- full heal + book of belial
		player:UseActiveItem(CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL, myUseFlags)
		player:SetFullHearts()
	elseif roomType == RoomType.ROOM_LIBRARY then
		-- d6 + d20
		player:UseCard(Card.CARD_DICE_SHARD, myUseFlags)
	elseif roomType == RoomType.ROOM_SACRIFICE then
		-- full heal
		player:SetFullHearts()
	elseif roomType == RoomType.ROOM_DEVIL then
		-- use coupon
		player:UseActiveItem(CollectibleType.COLLECTIBLE_COUPON, myUseFlags)
	elseif roomType == RoomType.ROOM_ANGEL then
		-- use coupon + isaac's soul
		player:UseActiveItem(CollectibleType.COLLECTIBLE_COUPON, myUseFlags) -- for angel shop
		player:UseCard(Card.CARD_SOUL_ISAAC, myUseFlags)
	elseif roomType == RoomType.ROOM_DUNGEON then
		-- black rune
		player:UseCard(Card.Card.RUNE_BLACK, myUseFlags)
	elseif roomType == RoomType.ROOM_BOSSRUSH then
		-- isaac's soul + algiz
		player:UseCard(Card.CARD_SOUL_ISAAC, myUseFlags)
		player:UseCard(Card.RUNE_ALGIZ, myUseFlags)
	elseif roomType == RoomType.ROOM_ISAACS or roomType == RoomType.ROOM_BARREN then
		SpawnOptionItems(ItemPoolType.POOL_TREASURE, rng:RandomInt(Random())+1)
	elseif roomType == RoomType.ROOM_CHEST then
		DebugSpawn(PickupVariant.PICKUP_LOCKEDCHEST, 0, player.Position)
		DebugSpawn(PickupVariant.PICKUP_KEY, 0, player.Position)
	elseif roomType == RoomType.ROOM_DICE then -- don't work if you already touched dice, so re-enter the room
		local diceFloor = Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.DICE_FLOOR)
		local diceVariants = {0,1,2,3,4,5}
		if #diceFloor > 0 then
			for _, diceF in pairs(diceFloor) do
				table.remove(diceVariants, diceF.SubType+1)
				diceF:Remove()
			end
		end
		local diceNew = diceVariants[rng:RandomInt(#diceVariants)+1]
		-- is there a way to reset dice room trigger
		-- I guess, it's somehow related to room (not level).
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.DICE_FLOOR, diceNew, room:GetCenterPos(), Vector.Zero, nil)
	elseif roomType == RoomType.ROOM_BLACK_MARKET then
		player:UseCard(Card.CARD_CREDIT, myUseFlags)
	elseif roomType == RoomType.ROOM_GREED_EXIT or roomType == RoomType.ROOM_SECRET_EXIT then
		player:UseActiveItem(CollectibleType.COLLECTIBLE_BOOK_OF_SIN, myUseFlags)
	elseif roomType == RoomType.ROOM_BLUE then
		player:UseActiveItem(CollectibleType.COLLECTIBLE_BOOK_OF_SIN, myUseFlags)
	elseif roomType == RoomType.ROOM_PLANETARIUM then
		player:UseCard(Card.CARD_SOUL_ISAAC, myUseFlags)
	elseif roomType == RoomType.ROOM_ULTRASECRET then
		level:SetCanSeeEverything(true)
		player:UseCard(Card.CARD_SOUL_CAIN, myUseFlags)
	end
	--]]
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onDeuxEx, mod.Pickups.DeuxEx)
---adrenaline card
function mod:onAdrenaline(_, player) -- card, player, useflag
	--- add Adrenaline item effect for current room
	local tempEffects = player:GetEffects()
	tempEffects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_ADRENALINE, true, 1) -- check if it works
	-- get red hearts amount
	local redHearts = player:GetHearts()
	-- loop if player has more than 1 full heart container
	if player:GetBlackHearts() > 0 or player:GetBoneHearts() > 0 or player:GetSoulHearts() > 0 then
		AdrenalineManager(player, redHearts, 0)
	elseif redHearts > 1 then
		AdrenalineManager(player, redHearts, 1) -- 0
	end
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onAdrenaline, mod.Pickups.Adrenaline)
---corruption card
function mod:onCorruption(_, player) -- card, player, useflag
	--- unlimited use of current active item in room, item will be removed on entering next room
	local data = player:GetData()
	-- set that corruption was used
	data.CorruptionIsActive = true
	player:AddNullCostume(mod.Corruption.CostumeHead)
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onCorruption, mod.Pickups.Corruption)
---GhostGem
function mod:onGhostGem(_, player) -- card, player, useflag
	-- loop in soul numbers
	for _ = 1, mod.GhostGem.NumSouls do
		-- spawn purgatory soul
		local purgesoul = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PURGATORY, 1, player.Position, Vector.Zero, player):ToEffect() -- subtype = 0 is rift, 1 is soul
 		-- change it's color
		purgesoul:SetColor(mod.OblivionCard.PoofColor, 500, 1, false, true)
 		-- set animation (skip appearing from rift)
		purgesoul:GetSprite():Play("Charge", true)
	end
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onGhostGem, mod.Pickups.GhostGem)
---battlefield
function mod:onBattlefieldCard(card, player, _) -- card, player, useflag
	mod.OutOfMap = true
	local rng = player:GetCardRNG(card)
	Isaac.ExecuteCommand("goto s.challenge." .. rng:RandomInt(8)+16)  --0 .. 15 - normal; 16 .. 24 - boss
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onBattlefieldCard, mod.Pickups.BattlefieldCard)
---treasury
function mod:onTreasuryCard(card, player, _) -- card, player, useflag
	mod.OutOfMap = true
	local rng = player:GetCardRNG(card)
	Isaac.ExecuteCommand("goto s.treasure." .. rng:RandomInt(56))
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onTreasuryCard, mod.Pickups.TreasuryCard)
---bookery
function mod:onBookeryCard(card, player, _) -- card, player, useflag
	mod.OutOfMap = true
	local rng = player:GetCardRNG(card)
	Isaac.ExecuteCommand("goto s.library." .. rng:RandomInt(18))
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onBookeryCard, mod.Pickups.BookeryCard)
---blood grove
function mod:onBloodGroveCard(card, player) -- card, player, useflag
	mod.OutOfMap = true
	local rng = player:GetCardRNG(card)
	local num = rng:RandomInt(10)+31 -- 0 .. 30 / 31 .. 40 for voodoo head
	Isaac.ExecuteCommand("goto s.curse." .. num)
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onBloodGroveCard, mod.Pickups.BloodGroveCard)
---storm temple
function mod:onStormTempleCard(card, player) -- card, player, useflag
	mod.OutOfMap = true
	local rng = player:GetCardRNG(card)
	Isaac.ExecuteCommand("goto s.sacrifice." .. rng:RandomInt(13))
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onStormTempleCard, mod.Pickups.StormTempleCard)
---arsenal
function mod:onArsenalCard(card, player) -- card, player, useflag
	mod.OutOfMap = true
	local rng = player:GetCardRNG(card)
	Isaac.ExecuteCommand("goto s.chest." .. rng:RandomInt(49))
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onArsenalCard, mod.Pickups.ArsenalCard)
---outport
function mod:onOutpostCard(card, player) -- card, player, useflag
	mod.OutOfMap = true
	local rng = player:GetCardRNG(card)
	if rng:RandomFloat() > 0.5 then
		Isaac.ExecuteCommand("goto s.isaacs." .. rng:RandomInt(30))
	else
		Isaac.ExecuteCommand("goto s.barren." .. rng:RandomInt(29))
	end
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onOutpostCard, mod.Pickups.OutpostCard)
---ancestral crypt
function mod:onCryptCard(card, player) -- card, player, useflag
	local data = player:GetData()
	mod.OutOfMap = true
	local level = game:GetLevel()
	local roomDesc = level:GetCurrentRoomDesc()
	local rng = player:GetCardRNG(card)
	local num = rng:RandomInt(11)+2
	if roomDesc.Variant == 1 then
		num = 1
	elseif num == 13 then
		num = 0
	end
	data.CryptUsed = true -- used to relocate player position, cause clip to error room
	Isaac.ExecuteCommand("goto s.itemdungeon." .. num)
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onCryptCard, mod.Pickups.CryptCard)
---maze of memory
function mod:onMazeMemoryCard(_, player, useFlag) -- card, player, useflag
	if useFlag & UseFlag.USE_MIMIC == 0 then
		local level = game:GetLevel()
		if not player:HasCollectible(CollectibleType.COLLECTIBLE_BLACK_CANDLE) then
			level:AddCurse(LevelCurse.CURSE_OF_BLIND, false)
		end
		local data = player:GetData()
		game:StartRoomTransition(level:GetCurrentRoomIndex(), 1, RoomTransitionAnim.DEATH_CERTIFICATE, player, -1)
		data.MazeMemoryUsed = {20, 18}
	end
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onMazeMemoryCard, mod.Pickups.MazeMemoryCard)
---zero stone
function mod:onZeroMilestoneCard(_, player) -- card, player, useflag
	mod.ZeroStoneUsed = true
	player:UseActiveItem(CollectibleType.COLLECTIBLE_GENESIS, myUseFlags)
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onZeroMilestoneCard, mod.Pickups.ZeroMilestoneCard)
---pot of greed
function mod:onBannedCard(_, player) -- card, player, useflag
	for _ = 1, mod.BannedCard.NumCards do
		--local subtype = itemPool:GetCard(-1, true, true, false)
		Isaac.Spawn(5, 300, 0, player.Position, RandomVector()*3, nil)
	end
	game:GetHUD():ShowFortuneText("POT OF GREED ALLOWS ME","TO DRAW TWO MORE CARDS!")
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onBannedCard, mod.Pickups.BannedCard)
---Decay
function mod:onDecay(_, player) -- card, player, useflag
	local redHearts = player:GetHearts()
	local data = player:GetData()

	if redHearts > 0 then
		player:AddHearts(-redHearts)
		player:AddRottenHearts(redHearts)
	end
	data.DecayLevel = data.DecayLevel or true
	TrinketRemoveAdd(player, TrinketType.TRINKET_APPLE_OF_SODOM)
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onDecay, mod.Pickups.Decay)
---Domino16
function mod:onDomino16(card, player) -- card, player, useflag
	local rng = player:GetCardRNG(card)
	local chestTable = {50,51,52,53,54,55,56,57,58,60}
	local varTable = {10, 20, 30, 40, 41, 50, 69, 70, 90, 100, 150, 300, 350}
	local var = varTable[rng:RandomInt(#varTable)+1]
	local finalVar = var
	for _ = 1, 6 do
		if var == 50 then
			finalVar = chestTable[rng:RandomInt(#chestTable)+1]
		end
		--local item = 0
		--elseif var == 70 then
		--  subtype = itemPool:GetPillEffect(itemPool:GetPill(rng:GetSeed()))
		--elseif var == 100 then
		--	subtype = itemPool:GetCollectible(itemPool:GetLastPool())
		--elseif var == 300 then
		--  subtype = itemPool:GetCard(rng:GetSeed(), true, true, false)
		--elseif var == 350 then
		--  subtype = itemPool:GetTrinket()
		--end
		DebugSpawn(finalVar, -1, player.Position) -- 0
	end
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onDomino16, mod.Pickups.Domino16)
end

--- EID
if EID then -- External Item Description
	local disk_description = "Save your items. (Empty -> Full) #If you have saved items, replace them. (Full -> Empty) #MissingNo if item is missing."
	EID:addCollectible(mod.Items.FloppyDisk, disk_description)
	EID:addCollectible(mod.Items.FloppyDiskFull, disk_description)

	EID:addCollectible(mod.Items.RedMirror,
			"Turn nearest trinket into cracked key.")
	EID:addCollectible(mod.Items.RedLotus,
			"Remove one broken heart and give flat 1.0 damage up at the start of the floor.")
	EID:addCollectible(mod.Items.MidasCurse,
			"Add 3 golden hearts. #10% chance to get golden pickups. #When you lose golden heart turn everything into gold. #Curse effect (Can be removed by Black Candle): # - 100% golden pickups. # - All food-related items turn into coins if you try to pick them up.")
	EID:addCollectible(mod.Items.RubberDuck,
			"+20 temporary luck when picked up. #Temporary luck up for entering unvisited room. #Temporary luck down for entering visited room. #Temporary luck can't go below player's original luck.")
	EID:addCollectible(mod.Items.IvoryOil,
			"Charge active items when entering an uncleared room for the first time.")
	EID:addCollectible(mod.Items.BlackKnight,
			"You can't move. #Use to jump to target marker. #Crush and knockback monsters when you land on the ground. #Destroy stone monsters.")
	EID:addCollectible(mod.Items.WhiteKnight,
			"Use to jump to nearest enemy. #Crush and knockback monsters when you land on the ground. #Destroy stone monsters.")
	EID:addCollectible(mod.Items.KeeperMirror,
			"Sell chosen item or pickup in room.")
	EID:addCollectible(mod.Items.RedBag,
			"Chance to drop red pickups after clearing room. #Possible pickups: red hearts, dice shards, red pills, cracked keys, red throwable bombs.")
	EID:addCollectible(mod.Items.MeltedCandle,
			"Tears have chance to freeze and burn enemies")
	EID:addCollectible(mod.Items.MiniPony,
			"Grants flight and 1.5 speed while held. #On use, grants invincibility for 6 seconds. #Deal 40 contact damage per second while invincible.")
	--"Grants flight, 2.0 speed and size down while held. #On use, grants invincibility for 6 seconds. #Deal 40 contact damage per second while invincible.")
	EID:addCollectible(mod.Items.StrangeBox,
			"Create option choice item for all items, pickups and shop items in the room.")
	EID:addCollectible(mod.Items.RedButton,
			"Spawn Red Button when entering room. #Activate random effect when pressed. #Can be pressed 66 times in one room.")
	EID:addCollectible(mod.Items.LostMirror,
			"Apply white fireplace effect, without Holy Mantle.")
	EID:addCollectible(mod.Items.BleedingGrimoire,
			"Start bleeding. #Your tears add bleeding to enemies.")
	EID:addCollectible(mod.Items.BlackBook,
			"Apply random status effects on enemies in room. #Possible effects: Freeze (Mom's Contact); Poison; Slow; Charm; #Confusion; Midas Touch; Fear; Burn; Shrink; #Bleed; Frozen (Uranus); Magnetized; Bait (Rotten Tomato).")

	local description = "In 'solved' state reroll items (similar to D6). #Have a 16% chance to reroll items into glitched items, after which it's 'scrambles', increasing it's charge bar. #In 'scrambled' state it can be used without full charge, but will reroll items into glitched items. #After fully recharging, it returns to 'solved' state."
	EID:addCollectible(mod.Items.RubikDice, description)
	EID:addCollectible(mod.Items.RubikDiceScrambled0, description)
	EID:addCollectible(mod.Items.RubikDiceScrambled1, description)
	EID:addCollectible(mod.Items.RubikDiceScrambled2, description)
	EID:addCollectible(mod.Items.RubikDiceScrambled3, description)
	EID:addCollectible(mod.Items.RubikDiceScrambled4, description)
	EID:addCollectible(mod.Items.RubikDiceScrambled5, description)


	EID:addCollectible(mod.Items.VHSCassette,
			"Move to another later floor. #Void - is last possible floor. #On ascension you will be send to Home.")
	EID:addCollectible(mod.Items.Lililith,
			"After clearing room, chance to spawn a familiar for current floor. #Possible familiars: demon baby, lil brimstone, lil abaddon, incubus, succubus.")
	EID:addCollectible(mod.Items.CompoBombs,
			"+5 bombs when picked up. #Place conjoined bombs. #Second bomb is regular bomb")
	EID:addCollectible(mod.Items.MirrorBombs,
			"+5 bombs when picked up. #When you place a bomb, copy it to opposite site of the room.")
	EID:addCollectible(mod.Items.GravityBombs,
			"+3 giga bombs when picked up. #Bombs get Black Hole effect.")
	EID:addCollectible(mod.Items.AbihuFam,
			"Decoy familiar. #Burn enemies on contact.")
	EID:addCollectible(mod.Items.NadabBody,
			"Can be picked up and thrown. #When thrown explodes on contact.")
	EID:addCollectible(mod.Items.Limb,
			"When you die and don't have any extra life, you will be turned into Soul. # - White Fireplace effect.")
	EID:addCollectible(mod.Items.LongElk,
			"Grants flight. #While moving leave bone spurs. #On use dash in movement direction, you will kill next contacted enemy.")
	EID:addCollectible(mod.Items.FrostyBombs,
			"+5 bombs when picked up. #Bombs freeze and slow down enemies. #Turn killed enemies into ice statues.")
	EID:addCollectible(mod.Items.VoidKarma,
			"All stats up when entering new level. #Double it's effect if you didn't take damage on previous floor.")
	EID:addCollectible(mod.Items.CharonObol,
			"Use 1 coin to spawn hungry soul. #If you don't have coins - pay with heart. #Remove this item if you die.")
	EID:addCollectible(mod.Items.Viridian,
			"Grants flight. #Flip player's sprite.")
	EID:addCollectible(mod.Items.BookMemory,
			"Erase all enemies in room from current run. #Can't erase bosses. #Add broken heart when used.")
	--"Use to activate random effect from saved effects pool. #Saved effects pool - set of used active items, cards, runes or pills in current run. #Activated effect will be removed from saved effects pool. #Reuse item, card or pill to return it to saved effects pool. #If there isn't any saved effect, spawn Oblivion Card and turn into Memory Fragment trinket.")
	EID:addCollectible(mod.Items.MongoCells,
			"#Copy your familiars.")
	EID:addCollectible(mod.Items.CosmicJam,
			"Add item from 1 wisp. #Add Item Wisp from nearest item to player.")
	--EID:addCollectible(mod.Items.Lobotomy,
	--	"Erase all enemies in room from current run. #Can't erase bosses. #Add broken hearts when used. #After each use increases added broken hearts amount to 1")
	EID:addCollectible(mod.Items.DMS,
			"Enemies has 25% chance to spawn purgatory soul after death.")
	EID:addCollectible(mod.Items.MewGen,
			"Activates telekinesis if don't shoot more than 5 seconds.")
	EID:addCollectible(mod.Items.ElderSign,
			"Creates Pentagram for 3 seconds at position where you stand. #Pentagram spawn Purgatory Soul. #Freeze enemies inside pentagram.")

	EID:addTrinket(mod.Trinkets.WitchPaper,
			"Turn back time when you die. #Removes after triggering.")
	EID:addTrinket(mod.Trinkets.QueenSpades,
			"Opens Boss Rush and Blue Womb doors while you holding this trinket. #Removes after triggering.")
	--"Opens all alternative doors while you holding this trinket. #Removes after triggering.")
	EID:addTrinket(mod.Trinkets.RedScissors,
			"Turn troll-bombs into red throwable bombs.")
	EID:addTrinket(mod.Trinkets.Duotine,
			"Replaces all future pills by Red pills while you holding this trinket.")
	EID:addTrinket(mod.Trinkets.LostFlower,
			"Give you full heart container when you get eternal heart. #Remove this trinket when you get hit. #Lost: activate Holy Card effect when you get eternal heart. #Lost: use Lost Mirror while holding this trinket to activate Holy Card effect.")
	EID:addTrinket(mod.Trinkets.TeaBag,
			"Remove poison clouds near player.")
	EID:addTrinket(mod.Trinkets.MilkTeeth,
			"Enemies have a chance to drop vanishing coins when they die.")
	EID:addTrinket(mod.Trinkets.BobTongue,
			"Bombs get toxic aura.")
	EID:addTrinket(mod.Trinkets.BinderClip,
			"Increase chance to get double hearts, coins, keys and bombs. #Pickups with option choices no longer disappear.")
	EID:addTrinket(mod.Trinkets.MemoryFragment,
			"Spawn last 3 used cards, runes, pills at the start of next floor.") -- +1 golden/mombox/stackable
	EID:addTrinket(mod.Trinkets.AbyssCart,
			"If you have familiar when you die, remove him, drop eternal heart and revive you. #Removes after triggering.")
	EID:addTrinket(mod.Trinkets.RubikCubelet,
			"Chance to reroll items into glitched items when you take damage")
	EID:addTrinket(mod.Trinkets.TeaFungus,
			"Rooms are flooded.")
	EID:addTrinket(mod.Trinkets.DeadEgg,
			"Spawn dead bird for 10 seconds when bomb explodes.")


	EID:addCard(mod.Pickups.OblivionCard,
			"Throwable eraser card. #Erase enemies for current level")
	EID:addCard(mod.Pickups.Apocalypse,
			"Fills the whole room with red poop.")
	EID:addCard(mod.Pickups.KingChess,
			"Poop around you.")
	EID:addCard(mod.Pickups.KingChessW,
			"Poop around you.")
	EID:addCard(mod.Pickups.Trapezohedron,
			"Turn all trinkets into cracked keys.")
	EID:addCard(mod.Pickups.Domino34,
			"Reroll items and pickups on current level.")
	EID:addCard(mod.Pickups.Domino25,
			"Respawn and reroll enemies in current room.")
	EID:addCard(mod.Pickups.SoulUnbidden, -- The End?
			"Add items from all item wisps to player. #Else, add item wisps from items in room.")
	--EID:addCard(mod.Pickups.) --
	--  "Add Items to player from all Item Wisps.")

	EID:addCard(mod.Pickups.SoulNadabAbihu,
			"Fire and Explosion immunity. #Fire Mind and Hot Bombs effect for current room.")
	EID:addCard(mod.Pickups.AscenderBane,
			"Remove one broken heart.")
	EID:addCard(mod.Pickups.MultiCast,
			"Spawn 3 wisps based on your active item. #Spawn regular wisps if you don't have an active item")
	EID:addCard(mod.Pickups.Wish,
			"Activate Mystery Gift.")
	EID:addCard(mod.Pickups.Offering,
			"Activate Sacrificial Altar.")
	EID:addCard(mod.Pickups.InfiniteBlades,
			"Shoot 28 knives in firing direction.")

	EID:addCard(mod.Pickups.Transmutation,
			"Reroll pickups and enemies into random pickups.")
	EID:addCard(mod.Pickups.RitualDagger,
			"Grants Mom's Knife for current room.")
	EID:addCard(mod.Pickups.Fusion,
			"Throw a Black Hole")
	EID:addCard(mod.Pickups.DeuxEx,
			"Random effects based on room type. #Add 100 luck on regular rooms. #Item reroll on Treasure, Library. #Coupon on Shop, Devil deal. #Full heal on Sacrifice. #Teleport from Error, Cursed. #")
	EID:addCard(mod.Pickups.Adrenaline,
			"Turn all your red health into batteries (full heart = battery). #Adrenaline item effect for current room.")
	EID:addCard(mod.Pickups.Corruption,
			"You can use your active item unlimited times in current room. #On next room active item on main slot will be removed. #Pocket items can't be removed.")

	EID:addCard(mod.Pickups.GhostGem,
			"Spawn 4 purgatory souls.")
	EID:addCard(mod.Pickups.BannedCard,
			"Spawn 2 cards or runes.")

	EID:addCard(mod.Pickups.Domino16,
			"Spawn 6 pickups of same type.")
	EID:addCard(mod.Pickups.BattlefieldCard,
			"Teleport to out of map Boss Challenge.")
	EID:addCard(mod.Pickups.TreasuryCard,
			"Teleport to out of map Treasury.")
	EID:addCard(mod.Pickups.BookeryCard,
			"Teleport to out of map Library.")
	EID:addCard(mod.Pickups.Decay,
			"Turn your red hearts into rotten hearts. #Apply Apple of Sodom trinket effect for current room.")
	EID:addCard(mod.Pickups.BloodGroveCard,
			"Teleport to out of map Curse Room.")
	EID:addCard(mod.Pickups.StormTempleCard,
			"Teleport to out of map Sacrifice Room.")
	EID:addCard(mod.Pickups.ArsenalCard,
			"Teleport to out of map Chest Room.")
	EID:addCard(mod.Pickups.OutpostCard,
			"Teleport to out of map Bedroom.")
	EID:addCard(mod.Pickups.CryptCard,
			"Teleport to out of map Dungeon.")
	EID:addCard(mod.Pickups.MazeMemoryCard,
			"Teleport to out of map room with 18 items from random pools. #You can pick up only one. #Apply Curse of Blind for current level.")
	EID:addCard(mod.Pickups.ZeroMilestoneCard,
			"Genesis effect. #Next level is Void.")

	EID:addCard(mod.Pickups.RedPill,
			"Grants tmporary 10.8 damage. #Apply 2 layers of Wavy Cap effect.")
	EID:addCard(mod.Pickups.RedPillHorse,
			"Grants tmporary 21.6 damage. #Apply 4 layers of Wavy Cap effect.")

	--EID:addPill(mod.RedPills.RedEffect,
	--	"Grants tmporary 10.8 damage. #Apply 2 layers of Wavy Cap effect. #Horse Pill doubles all effects.")
end
-----------------------------------------------------------------------------------------

local function ExplosionEffect(player, bombPos, bombDamage, bombFlags)
	local data = player:GetData()
	local bombRadiusMult = 1

	if player:HasCollectible(mod.Items.FrostyBombs) then
		bombFlags = bombFlags | TearFlags.TEAR_SLOW | TearFlags.TEAR_ICE
		if bombFlags & TearFlags.TEAR_SAD_BOMB == TearFlags.TEAR_SAD_BOMB then
			data.SadIceBombTear = data.SadIceBombTear or {}
			local timer = 1
			local pos = bombPos
			table.insert(data.SadIceBombTear, {timer, pos})
		end
	end

	if bombFlags & TearFlags.TEAR_STICKY == TearFlags.TEAR_STICKY then
		for _, entity in pairs(Isaac.FindInRadius(bombPos, 150, EntityPartition.ENEMY)) do
			if entity:IsVulnerableEnemy() and entity:IsActiveEnemy() then
				entity:AddEntityFlags(EntityFlag.FLAG_SPAWN_STICKY_SPIDERS)
			end
		end
	end

	game:BombExplosionEffects(bombPos, bombDamage, bombFlags, Color.Default, player, bombRadiusMult, true, true, DamageFlag.DAMAGE_EXPLOSION)

	if player:HasCollectible(mod.Items.CompoBombs) then
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_THROWABLEBOMB, 0,  Isaac.GetFreeNearPosition(bombPos, 1), Vector.Zero, player):ToPickup()
	end

	if player:HasCollectible(CollectibleType.COLLECTIBLE_BOBS_CURSE) then
		local cloud = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.SMOKE_CLOUD, 0, bombPos, Vector.Zero, player):ToEffect()
		cloud:SetTimeout(150)
	end

	if bombFlags & TearFlags.TEAR_GHOST_BOMB == TearFlags.TEAR_GHOST_BOMB then
		local soul = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HUNGRY_SOUL, 1, bombPos, Vector.Zero, player):ToEffect()
		soul:SetTimeout(360)
	end

	if bombFlags & TearFlags.TEAR_SCATTER_BOMB == TearFlags.TEAR_SCATTER_BOMB then
		for _ = 1, 4 do
			player:AddMinisaac(bombPos, true)
		end
	end

	if player:HasTrinket(mod.Trinkets.BobTongue) then
		local fartRingEffect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.FART_RING, 0, bombPos, Vector.Zero, nil):ToEffect()
		fartRingEffect:SetTimeout(30)
	end

	DeadEggEffect(player, bombPos, mod.DeadEgg.Timeout)

	if player:HasCollectible(mod.Items.GravityBombs) then
		local holeEffect = Isaac.Spawn(EntityType.ENTITY_EFFECT, mod.GravityBombs.BlackHoleEffect, 0, bombPos, Vector.Zero, nil):ToEffect()
		holeEffect:SetTimeout(60)
		local holeData = holeEffect:GetData()
		holeEffect.Parent = player
		holeEffect.DepthOffset = -100
		holeData.Gravity = true
		holeData.GravityForce = mod.GravityBombs.AttractorForce
		holeData.GravityRange = mod.GravityBombs.AttractorRange
		holeData.GravityGridRange = mod.GravityBombs.AttractorGridRange
	end

	--[[
	if player:HasCollectible(mod.Items.DiceBombs) then
		DiceyReroll(player:GetCollectibleRNG(mod.Items.DiceBombs), bombPos, mod.DiceBombs.AreaRadius)
	end
	--]]

	--[[
	if player:HasCollectible(CollectibleType.COLLECTIBLE_STICKY_BOMBS) then
		local explosions = Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.BOMB_EXPLOSION)
		for _, splosion in pairs(explosions) do
			local frame = splosion:GetSprite():GetFrame()
			if frame < 3 then
				local size = splosion.SpriteScale.X
				local nearby = Isaac.FindInRadius(splosion.Position, 75 * size)
				for _, entity in pairs(nearby) do
					if entity:IsVulnerableEnemy() and entity:IsActiveEnemy() then
						entity:AddEntityFlags(EntityFlag.FLAG_SPAWN_STICKY_SPIDERS)
					end
				end
			end
		end
	end
	--]]
	--[[
	if player:HasCollectible(mod.Items.DiceBombs) then
		local rng = player:GetCollectibleRNG(mod.Items.DiceBombs)
		for _, pickup in pairs(Isaac.FindInRadius(bombPos, 150, EntityPartition.PICKUP)) do
			if pickup.Type ~= EntityType.ENTITY_SLOT then
				if pickup.Variant == 100 then
					local pool = itemPool:GetPoolForRoom(game:GetRoom():GetType(), game:GetSeeds():GetStartSeed())
					local newItem = itemPool:GetCollectible(pool, true, pickup.InitSeed)
					pickup:Morph(pickup.Type, 100, newItem)
				else
					local chestTable = {50,51,52,53,54,55,56,57,58,60}
					local varTable = {10, 20, 30, 40, 41, 50, 69, 70, 90, 300, 350}
					local var = varTable[rng:RandomInt(#varTable)+1]
					if var == 50 then
						var = chestTable[rng:RandomInt(#chestTable)+1]
					end
					pickup:Morph(pickup.Type, var, 0)
				end
			end
		end
	end
	--]]
end


mod.NadabBody = {}
mod.NadabBody.SpritePath = "gfx/familiar/nadabbody.png"
mod.NadabBody.RocketVol = 30
---Nadab's Body
local function BodyExplosion(player, useGiga, bombPos)
	local data = player:GetData()
	local bombFlags = player:GetBombFlags()
	local bombDamage = player.Damage * 15
	if player:HasCollectible(CollectibleType.COLLECTIBLE_MR_MEGA) then
		bombDamage = player.Damage * 25
	end
	if data.GigaBombs then
		if data.GigaBombs > 0 then
			if useGiga then
				data.GigaBombs = data.GigaBombs - 1
			end
			bombFlags = bombFlags | TearFlags.TEAR_GIGA_BOMB
			bombDamage = player.Damage * 75
		end
	end
	ExplosionEffect(player, bombPos, bombDamage, bombFlags)
end
local function FcukingBomberbody(player, body)
	if body then
		if player:HasCollectible(mod.Items.MirrorBombs) then
			if body:GetData().bomby then
				BodyExplosion(player, false, FlipMirrorPos(body.Position))
			end
		end
		if body:GetData().bomby then
			BodyExplosion(player, true, body.Position)
		end
	else
		local bodies = Isaac.FindByType(EntityType.ENTITY_BOMB, BombVariant.BOMB_DECOY)
		if player:HasCollectible(mod.Items.MirrorBombs) then
			for _, bomb in pairs(bodies) do
				if bomb:GetData().bomby then
					BodyExplosion(player, false, FlipMirrorPos(bomb.Position))
				end
			end
		end
		for _, bomb in pairs(bodies) do
			if bomb:GetData().bomby then
				BodyExplosion(player, true, bomb.Position)
			end
		end
	end
end
---Nadab's Body
local function NadabBodyDamageGrid(position)
	local room = game:GetRoom()
	local griden = room:GetGridEntityFromPos(position)
	if griden and (griden:ToPoop() or griden:ToTNT()) then
		griden:Hurt(1)
	end
end
--new room
---Nadab's Body
function mod:onNewRoom3()
	---Nadab's Body
	if #Isaac.FindByType(EntityType.ENTITY_BOMB, BombVariant.BOMB_DECOY) > 0 then
		local bodies = Isaac.FindByType(EntityType.ENTITY_BOMB, BombVariant.BOMB_DECOY)
		for _, body in pairs(bodies) do
			if body.SpawnerEntity == nil or body:GetData().bomby then
				body:Remove()
			end
		end
	end

	--player
	for playerNum = 0, game:GetNumPlayers()-1 do
		local player = game:GetPlayer(playerNum)
		local data = player:GetData()
		if player:GetPlayerType() == mod.Characters.Abihu then
			data.AbihuIgnites = false
			if data.AbihuCostumeEquipped then
				data.AbihuCostumeEquipped = false
				--player:AddNullCostume(mod.AbihuData.CostumeHead)
				player:TryRemoveNullCostume(mod.AbihuData.CostumeHead)
			end
		end

		if GetItemsCount(player, mod.Items.NadabBody) > 0 then
			for _=1, GetItemsCount(player, mod.Items.NadabBody) do
				local pos = Isaac.GetFreeNearPosition(player.Position, 25)
				if data.HoldBomd and data.HoldBomd >= 0 then
					data.HoldBomd = -1
					pos = player.Position
				end
				local bomb = Isaac.Spawn(EntityType.ENTITY_BOMB, BombVariant.BOMB_DECOY, 0, pos, Vector.Zero, nil):ToBomb()
				--bomb:AddTearFlags(player:GetBombFlags())
				bomb:GetData().bomby = true
				bomb:GetSprite():ReplaceSpritesheet(0, mod.NadabBody.SpritePath)
				bomb:GetSprite():LoadGraphics()
				bomb.Parent = player
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.onNewRoom3)
---Nadab's Body
function mod:onBombNadabUpdate(bomb)
	---bomb updates
	local bombData = bomb:GetData()
	local room = game:GetRoom()
	if bombData.bomby and bomb.Parent then

		local player = bomb.Parent:ToPlayer()
		bomb:SetExplosionCountdown(1) -- so it doesn't explode

		-- get grid
		local grid = room:GetGridEntityFromPos(bomb.Position)
		if grid then
			-- if it's pressure plate, not grid mode plate and wasn't pressed
			if grid:ToPressurePlate() and grid:GetVariant() < 2 and grid.State == 0 then
				grid.State = 3
				grid:ToPressurePlate():Reward()
				grid:GetSprite():Play("On")
				grid:Update()
			-- else if it's out of room or inside a pit + wasn't thrown and [player can't fly(?)]
			elseif (not room:IsPositionInRoom(bomb.Position, 0) or grid:ToPit()) and not bombData.Thrown then -- and not player.CanFly then
				bomb:Kill()
				return
			end
		end

		-- if it's held by player,
		if bomb:HasEntityFlags(EntityFlag.FLAG_HELD) then
			bombData.Thrown = 60
		else
			-- block tears only while not held
			local enemyTears = Isaac.FindInRadius(bomb.Position, 20, EntityPartition.BULLET)
			if #enemyTears > 0 then
				for _, enemyTear in pairs(enemyTears) do
					enemyTear:Kill()
				end
			end
		end

		-- was thrown
		if bombData.Thrown then
			bombData.Thrown = bombData.Thrown - 1
			if bombData.Thrown <= 0 then
				bombData.Thrown = nil
			end
			bomb.CollisionDamage = player.Damage

			if player:GetData().RocketThrowMulti then
				bomb:AddVelocity(player:GetData().ThrowVelocity*player:GetData().RocketThrowMulti)
				player:GetData().RocketThrowMulti = nil
			end
			if bomb:CollidesWithGrid() and player:GetData().ThrowVelocity then
				local pos = bomb.Position + 40*(player:GetData().ThrowVelocity:Normalized())
				NadabBodyDamageGrid(bomb.Position)
				NadabBodyDamageGrid(pos)
			end
		end

		-- follow enemies
		if player:HasCollectible(CollectibleType.COLLECTIBLE_BOBBY_BOMB) or player:HasCollectible(CollectibleType.COLLECTIBLE_STICKY_BOMBS) then
			local raddis = 30
			if player:HasCollectible(CollectibleType.COLLECTIBLE_BOBBY_BOMB) then raddis = raddis*2 end
			local nearestNPC = GetNearestEnemy(bomb.Position, raddis)
			if nearestNPC:Distance(bomb.Position) > 10 then
				bomb:AddVelocity((nearestNPC - bomb.Position):Resized(1))
			end
		end
		-- leave creep
		if player:HasCollectible(mod.Items.FrostyBombs) and game:GetFrameCount() %8 == 0 then -- spawn every 8th frame
			local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_HOLYWATER_TRAIL, 0, bomb.Position, Vector.Zero, player):ToEffect() -- PLAYER_CREEP_RED
			creep.SpriteScale = creep.SpriteScale * 0.1
		end

		-- bob's bladder
		if player:HasTrinket(TrinketType.TRINKET_BOBS_BLADDER) and game:GetFrameCount() %8 == 0 then -- spawn every 8th frame
			Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_GREEN, 0, bomb.Position, Vector.Zero, player)
		end

		-- do some rocket dash before explosion
		if bombData.RocketBody then
			bombData.RocketBody = bombData.RocketBody - 1
			if bomb:CollidesWithGrid(player) then
				FcukingBomberbody(player, bomb)
				bombData.RocketBody = false

			elseif bombData.RocketBody < 0 then
				FcukingBomberbody(player, bomb)
				bombData.RocketBody = false
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_BOMB_UPDATE, mod.onBombNadabUpdate, BombVariant.BOMB_DECOY)
---Nadab's Body
function mod:onBombCollision(bomb, collider)
	local bombData = bomb:GetData()
	if bombData.bomby then
		if bombData.Thrown and collider:ToNPC() then
			if (collider:IsActiveEnemy() and collider:IsVulnerableEnemy()) or collider.Type == EntityType.ENTITY_FIREPLACE then
				bomb.Velocity = -bomb.Velocity * 0.5
				FcukingBomberbody(bomb.Parent:ToPlayer(), bomb)
				bombData.Thrown = nil
			end
		end
		if bombData.RocketBody and collider:ToNPC() then
			if (collider:IsActiveEnemy() and collider:IsVulnerableEnemy()) or collider.Type == EntityType.ENTITY_FIREPLACE then
				--bomb.Velocity = bomb.Parent:ToPlayer():GetShootingInput() *5 --bomb.Velocity
				bomb.Velocity = -bomb.Velocity * 0.5
				FcukingBomberbody(bomb.Parent:ToPlayer(), bomb)
				bombData.RocketBody = false
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_BOMB_COLLISION, mod.onBombCollision, BombVariant.BOMB_DECOY)

-------------------------------------------------------------------------------------------
mod.NadabData = {}
--mod.NadabData.CompletionMarks = {0,0,0,0,0,0,0,0,0,0,0,0,0} --1:Isaac, 2:BlueBaby, 3:Satan, 4:Lamb, 5:BossRush, 6:Hush, 7:MegaSatan, 8:Delirium, 9:Mother, 10:Beast, 11:Greed/Greedier, 12:Heart, 13:AllMarksHard
mod.NadabData.CostumeHead = Isaac.GetCostumeIdByPath("gfx/characters/nadab_head.anm2")
mod.NadabData.ExplosionCountdown = 30 -- so don't spam
mod.NadabData.MrMegaDmgMultiplier = 0.75
mod.NadabData.SadBombsFiredelay = -1.0
mod.NadabData.FastBombsSpeed = 1.0
mod.NadabData.RingCapFrameCount = 10
mod.NadabData.BombBeggarSprites = {
['Idle'] = true,
['PayNothing'] = true }
mod.NadabData.Stats = {}
mod.NadabData.Stats.DAMAGE = 1.2
mod.NadabData.Stats.SPEED = -0.35

mod.AbihuData = {}
--mod.AbihuData.CompletionMarks = {0,0,0,0,0,0,0,0,0,0,0,0,0}
mod.AbihuData.CostumeHead = Isaac.GetCostumeIdByPath("gfx/characters/abihu_costume.anm2")
mod.AbihuData.DamageDelay = 30
mod.AbihuData.HoldBombDelay = 20
mod.AbihuData.ChargeBar = Sprite()
mod.AbihuData.ChargeBar:Load("gfx/chargebar.anm2", true)
mod.AbihuData.Stats = {}
mod.AbihuData.Stats.DAMAGE = 1.14286
mod.AbihuData.Stats.SPEED = 1.0
mod.AbihuData.Unlocked = false

mod.UnbiddenData = {}
--mod.UnbiddenData.CompletionMarks = {0,0,0,0,0,0,0,0,0,0,0,0,0}
mod.UnbiddenData.RadiusWisp = 100
mod.UnbiddenData.Stats = {}
mod.UnbiddenData.Stats.DAMAGE = 1.35
mod.UnbiddenData.Stats.LUCK = -1

mod.ObliviousData = {}
mod.ObliviousData.DamageDelay = 12
mod.ObliviousData.Knockback = 4
mod.ObliviousData.TearVariant = TearVariant.MULTIDIMENSIONAL
--mod.ObliviousData.CompletionMarks = {0,0,0,0,0,0,0,0,0,0,0,0,0}
mod.ObliviousData.ChargeBar = Sprite()
mod.ObliviousData.ChargeBar:Load("gfx/chargebar.anm2", true)
mod.ObliviousData.Stats = {}
mod.ObliviousData.Stats.DAMAGE = 1
mod.ObliviousData.Stats.LUCK = -3
mod.ObliviousData.Stats.TRAR_FLAG = TearFlags.TEAR_WAIT | TearFlags.TEAR_CONTINUUM
mod.ObliviousData.Stats.TEAR_COLOR = Color(0.5,1,2,1,0,0,0)
mod.ObliviousData.Stats.LASER_COLOR = Color(1,1,1,1,-0.5,0.7,1)

mod.ObliviousData.Unlocked = false

--Nadab
local function NadabExplosion(player, useGiga, bombPos)
	local data = player:GetData()
	local bombFlags = player:GetBombFlags()
	local bombDamage = 100
	if player:HasCollectible(CollectibleType.COLLECTIBLE_MR_MEGA) then
		bombDamage = 185
	end
	if data.GigaBombs then
		if data.GigaBombs > 0 then
			if useGiga then
				data.GigaBombs = data.GigaBombs - 1
			end
			bombFlags = bombFlags | TearFlags.TEAR_GIGA_BOMB
			bombDamage = 300
		end
	end
	ExplosionEffect(player, bombPos, bombDamage, bombFlags)
end

local function NadabEvaluateStats(player,item, cacheFlag, dataCheck)
	if player:HasCollectible(item) then
		if not dataCheck then
			dataCheck = true
			player:AddCacheFlags(cacheFlag)
			player:EvaluateItems()
		end
	else
		if dataCheck then
			dataCheck = false
			player:AddCacheFlags(cacheFlag)
			player:EvaluateItems()
		end
	end
	return dataCheck
end

local function FcukingBomberman(player)
	--NadabExplosion(player, useGiga, useMirror) -- useGiga: removes 1 giga bomb; useMirror: flips position
	if player:HasCollectible(mod.Items.MirrorBombs) then

		NadabExplosion(player, false, FlipMirrorPos(player.Position))
	end
	if player:HasTrinket(TrinketType.TRINKET_RING_CAP) then
		player:GetData().RingCapDelay = 0-- player:GetTrinketMultiplier(TrinketType.TRINKET_RING_CAP) * mod.NadabData.RingCapFrameCount
	end
	NadabExplosion(player, true, player.Position)
end

local function BombHeartConverter(player)
	local data = player:GetData()
	local bombs = player:GetNumBombs()
	if data.BeggarPay then
		if bombs == 0 and player:GetHearts() > 0 then
			player:AddBombs(1)
			player:TakeDamage(1, DamageFlag.DAMAGE_NO_PENALTIES | DamageFlag.DAMAGE_RED_HEARTS, EntityRef(player), 1)
			data.BeggarPay = false
			data.BlockBeggar = game:GetFrameCount()
		end
	else
		if bombs > 0 then
			if player:GetNumGigaBombs() > 0 then
				data.GigaBombs = data.GigaBombs or 0
				data.GigaBombs = data.GigaBombs + player:GetNumGigaBombs()
			end
			player:AddBombs(-bombs)
			player:AddHearts(bombs)
		end
	end
end

local function BombGoldenHearts(player)
	if player:HasGoldenBomb() then
		if not player:HasCollectible(CollectibleType.COLLECTIBLE_MAMA_MEGA) then
			player:RemoveGoldenBomb()
			player:AddGoldenHearts(1)
		end
	else
		if player:GetGoldenHearts() > 0 and player:HasCollectible(CollectibleType.COLLECTIBLE_MAMA_MEGA) then
			player:AddGoldenHearts(-1)
			player:AddGoldenBomb()
		end
	end
end

local function BombBeggarInteraction(player)
	--- Nadab & Abihu bomb beggar interaction
	local data = player:GetData()
	local bombegs = Isaac.FindByType(EntityType.ENTITY_SLOT, 9) -- bombBeggar
	if #bombegs > 0 then
		local enablePay = false
		for _, beggar in pairs(bombegs) do
			local bsprite = beggar:GetSprite()
			--print(bsprite:GetAnimation())
			if beggar.Position:Distance(player.Position) <= 20 and mod.NadabData.BombBeggarSprites[bsprite:GetAnimation()] then
				enablePay = true
				break
			end
		end
		if enablePay then
			data.BeggarPay = true
		else
			data.BeggarPay = false
		end
	end
end

local function AbihuNadabManager(player)
	local data = player:GetData()
	if player:GetHearts() > 0 and not data.BlockBeggar then
		BombBeggarInteraction(player)
	end
	BombGoldenHearts(player)
	BombHeartConverter(player)

end

local function ExplosionCountdownManager(player)
	local data = player:GetData()
	data.ExCountdown = data.ExCountdown or 0
	if data.ExCountdown > 0 then data.ExCountdown = data.ExCountdown - 1 end

	--short fuse OR explosion countdown
	if player:HasTrinket(TrinketType.TRINKET_SHORT_FUSE) then
		if mod.NadabData.ExplosionCountdown > 15 then
			mod.NadabData.ExplosionCountdown = 15
		end
	else
		if mod.NadabData.ExplosionCountdown < 30 then
			mod.NadabData.ExplosionCountdown = 30
		end
	end
end

--Blind
local function SetBlindfold(player, enabled)
	local character = player:GetPlayerType()
	local challenge = Isaac.GetChallenge()
	if enabled then
		game.Challenge = Challenge.CHALLENGE_SOLAR_SYSTEM -- This challenge has a blindfold
		player:ChangePlayerType(character)
		game.Challenge = challenge
		player:TryRemoveNullCostume(NullItemID.ID_BLINDFOLD)
	else
		game.Challenge = Challenge.CHALLENGE_NULL
		player:ChangePlayerType(character)
		game.Challenge = challenge
		player:TryRemoveNullCostume(NullItemID.ID_BLINDFOLD)
	end
end

-- get num aura multiplier
local function GetMultiShotNum(player)
	local Aura2020 = GetItemsCount(player, CollectibleType.COLLECTIBLE_20_20)
	local AuraInnerEye = GetItemsCount(player, CollectibleType.COLLECTIBLE_INNER_EYE)
	local AuraMutantSpider = GetItemsCount(player,  CollectibleType.COLLECTIBLE_MUTANT_SPIDER)
	local AuraWiz = GetItemsCount(player, CollectibleType.COLLECTIBLE_THE_WIZ)
	local tearsNum = Aura2020 + AuraWiz
	if AuraInnerEye > 0 then
		if tearsNum > 0 then AuraInnerEye = AuraInnerEye - 1 end
		tearsNum = tearsNum + AuraInnerEye
	end
	if AuraMutantSpider > 0 then
		if AuraMutantSpider > 1 then AuraMutantSpider = 2*(AuraMutantSpider) end
		tearsNum = tearsNum + AuraMutantSpider + 1
	end
	return tearsNum
end

--Unbidden Aura
local function AuraGridEffect(ppl, auraPos)
	local room = game:GetRoom()
	local iterOffset = ppl.TearRange/80
	if iterOffset%2 ~= 0 then iterOffset = iterOffset +1 end
	iterOffset = math.floor(iterOffset/2)
	local gridTable = {}
	local gridList = {}
	local nulPos = room:GetGridPosition(room:GetGridIndex(auraPos))
	for xx = -40*iterOffset, 40*iterOffset, 40 do
		for yy = -40*iterOffset, 40*iterOffset, 40 do
			gridTable[room:GetGridIndex(Vector(nulPos.X + xx, nulPos.Y + yy))] = true
			table.insert(gridList, Vector(auraPos.X + xx, auraPos.Y + yy))
		end
	end
	for gindex = 0, room:GetGridSize() do
		if ppl:HasCollectible(CollectibleType.COLLECTIBLE_TERRA) then
			if gridTable[gindex] then
				local griden = room:GetGridEntity(gindex)
				if griden and (griden:ToRock() or griden:ToPoop() or griden:ToTNT() or griden:ToDoor()) then
					griden:Destroy(false)
				end
			end
		elseif ppl:HasCollectible(CollectibleType.COLLECTIBLE_SULFURIC_ACID) then
			local rng = ppl:GetCollectibleRNG(CollectibleType.COLLECTIBLE_SULFURIC_ACID)
			if gridTable[gindex] and 0.25 > rng:RandomFloat() then
				local griden = room:GetGridEntity(gindex)
				if griden and (griden:ToRock() or griden:ToPoop() or griden:ToTNT() or (griden:ToDoor() and griden:GetVariant() == DoorVariant.DOOR_HIDDEN)) then
					griden:Destroy(false)
				end
			end
		else
			if gridTable[gindex] then
				local griden = room:GetGridEntity(gindex)
				if griden and (griden:ToPoop() or griden:ToTNT()) then
					griden:Hurt(1)
				end
			end
		end
	end
	return gridList
end

local function AuraEnemies(ppl, auraPos, enemies, damage)
	local data = ppl:GetData()
	local rng = modRNG
	for _, enemy in pairs(enemies) do
		local knockback = ppl.ShotSpeed * mod.ObliviousData.Knockback
		local tearFlags = ppl.TearFlags

		if ppl:HasCollectible(CollectibleType.COLLECTIBLE_EUTHANASIA) then
			rng = ppl:GetCollectibleRNG(CollectibleType.COLLECTIBLE_EUTHANASIA)
			local chance = 0.0333 + ppl.Luck/69.2
			if chance > 0.25 then chance = 0.25 end
			if chance > rng:RandomFloat() then
				local needle = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.NEEDLE, 0, enemy.Position, Vector.Zero, ppl):ToTear() --25
				needle:SetColor(Color(0,0,0,0), 100, 100, false, true)
				needle.Visible = false
				needle.FallingSpeed = 5
				needle.CollisionDamage = ppl.Damage * 3
				if not enemy:IsBoss() and enemy:ToNPC() then
					enemy:Kill()
				end
			end
		end

		if ppl:HasCollectible(CollectibleType.COLLECTIBLE_TERRA) then
			rng = ppl:GetCollectibleRNG(CollectibleType.COLLECTIBLE_TERRA)
			local terradmg = 2 * rng:RandomFloat()
			if terradmg < 0.5 then terradmg = 0.5 end
			if terradmg > 2 then terradmg = 2 end
			damage = damage * terradmg
			if terradmg < 1 then terradmg = 1 end
			knockback = knockback * terradmg
		end

		if ppl:HasCollectible(CollectibleType.COLLECTIBLE_LUMP_OF_COAL) then
			damage =  damage + enemy.Position:Distance(auraPos)/100
		end

		if ppl:HasCollectible(CollectibleType.COLLECTIBLE_PROPTOSIS) then
			damage =  damage - enemy.Position:Distance(auraPos)/100
		end

		if enemy:IsVulnerableEnemy() and enemy:IsActiveEnemy() then
			if ppl:HasCollectible(CollectibleType.COLLECTIBLE_HEAD_OF_THE_KEEPER) then
				rng = ppl:GetCollectibleRNG(CollectibleType.COLLECTIBLE_HEAD_OF_THE_KEEPER)
				if 0.05 > rng:RandomFloat() then
					Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_PENNY, enemy.Position, RandomVector()*3, ppl)
					--local coin = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_PENNY, enemy.Position, RandomVector()*3, ppl):ToPickup() --25
				end
			end

			if ppl:HasCollectible(CollectibleType.COLLECTIBLE_LITTLE_HORN) then
				rng = ppl:GetCollectibleRNG(CollectibleType.COLLECTIBLE_LITTLE_HORN)
				local chance = 0.05 + ppl.Luck/100
				if chance > 0.2 then chance = 0.2 end
				if chance > rng:RandomFloat() then
					local horn = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLUE, 0, enemy.Position, Vector.Zero, ppl):ToTear() --25
					horn:AddTearFlags(TearFlags.TEAR_HORN)
					horn.CollisionDamage = 0
					horn.Visible = false
					horn:SetColor(Color(0,0,0,0), 100, 100, false, true)
					horn.FallingSpeed =  5
				end
			end

			if ppl:HasCollectible(CollectibleType.COLLECTIBLE_JACOBS_LADDER) then
				local electro = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLUE, 0, enemy.Position, Vector.Zero, ppl):ToTear() --25
				electro:AddTearFlags(TearFlags.TEAR_JACOBS)
				electro:SetColor(Color(0,0,0,0), 100, 100, false, true)
				electro.Visible = false
				electro.CollisionDamage = 0
				electro.FallingSpeed =  5
			end

			if ppl:HasCollectible(CollectibleType.COLLECTIBLE_LODESTONE) then
				rng = ppl:GetCollectibleRNG(CollectibleType.COLLECTIBLE_LODESTONE)
				local chance = 0.1667 + ppl.Luck/6
				if chance > rng:RandomFloat() then
					local magnet = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.METALLIC, 0, enemy.Position, Vector.Zero, ppl):ToTear() --25
					magnet:AddTearFlags(TearFlags.TEAR_MAGNETIZE)
					magnet:SetColor(Color(0,0,0,0), 100, 100, false, true)
					magnet.Visible = false
					magnet.CollisionDamage = 0
					magnet.FallingSpeed = 5
				end
			end

			if ppl:HasCollectible(CollectibleType.COLLECTIBLE_OCULAR_RIFT) then
				rng = ppl:GetCollectibleRNG(CollectibleType.COLLECTIBLE_OCULAR_RIFT)
				local chance = 0.05 + ppl.Luck/50
				if chance > 0.25 then chance = 0.25 end
				if chance > rng:RandomFloat() then
					local rift = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLUE, 0, enemy.Position, Vector.Zero, ppl):ToTear() --25
					rift:AddTearFlags(TearFlags.TEAR_RIFT)
					rift:SetColor(Color(0,0,0,0), 100, 100, false, false)
					rift.Visible = false
					rift.CollisionDamage = ppl.Damage
					rift.FallingSpeed = 5
					damage = 0
					break
				end
			end

			if ppl:HasCollectible(mod.Items.MeltedCandle) and not enemy:GetData().Waxed then
				rng = ppl:GetCollectibleRNG(mod.Items.MeltedCandle)
				if rng:RandomFloat() + ppl.Luck/100 >= mod.MeltedCandle.TearChance then --  0.8
					enemy:AddFreeze(EntityRef(ppl), mod.MeltedCandle.FrameCount)
					if enemy:HasEntityFlags(EntityFlag.FLAG_FREEZE) then
						--entity:AddBurn(EntityRef(ppl), 1, ppl.Damage) -- the issue is Freeze stops framecount of entity, so it won't call NPC_UPDATE.
						enemy:AddEntityFlags(EntityFlag.FLAG_BURN)          -- the burn timer doesn't update
						enemy:GetData().Waxed = mod.MeltedCandle.FrameCount
						enemy:SetColor(mod.MeltedCandle.TearColor, mod.MeltedCandle.FrameCount, 100, false, false)
					end
				end
			end

			if tearFlags & TearFlags.TEAR_BURN == TearFlags.TEAR_BURN then
				enemy:AddBurn(EntityRef(ppl), 52, ppl.Damage)
			end
			if ppl:HasCollectible(CollectibleType.COLLECTIBLE_FIRE_MIND) and 0.33 + ppl.Luck/20 > ppl:GetCollectibleRNG(CollectibleType.COLLECTIBLE_FIRE_MIND):RandomFloat() then
				game:BombExplosionEffects(enemy.Position, ppl.Damage, TearFlags.TEAR_BURN, Color.Default, ppl, 1, true, false, DamageFlag.DAMAGE_EXPLOSION)
			end

			if tearFlags & TearFlags.TEAR_CHARM == TearFlags.TEAR_CHARM then -- or ppl:HasCollectible(CollectibleType.COLLECTIBLE_SPIDER_BITE) then
				enemy:AddCharmed(EntityRef(ppl), 52)
			elseif ppl:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_EYESHADOW) and 0.1 + ppl.Luck / 30 > ppl:GetCollectibleRNG(CollectibleType.COLLECTIBLE_MOMS_EYESHADOW):RandomFloat() then
				enemy:AddCharmed(EntityRef(ppl), 52)
			end

			if ppl:HasCollectible(CollectibleType.COLLECTIBLE_GLAUCOMA) and 0.05 > ppl:GetCollectibleRNG(CollectibleType.COLLECTIBLE_GLAUCOMA):RandomFloat() then
				enemy:AddEntityFlags(EntityFlag.FLAG_CONFUSION)
			elseif tearFlags & TearFlags.TEAR_CONFUSION == TearFlags.TEAR_CONFUSION then -- or ppl:HasCollectible(CollectibleType.COLLECTIBLE_SPIDER_BITE) then
				enemy:AddConfusion(EntityRef(ppl), 52, false)
			elseif ppl:HasCollectible(CollectibleType.COLLECTIBLE_KNOCKOUT_DROPS) and 0.1 + ppl.Luck/10 > ppl:GetCollectibleRNG(CollectibleType.COLLECTIBLE_KNOCKOUT_DROPS):RandomFloat() then
				enemy:AddConfusion(EntityRef(ppl), 42, false)
				enemy:AddVelocity((enemy.Position - auraPos):Resized(knockback))
				enemy:AddEntityFlags(EntityFlag.FLAG_KNOCKED_BACK)
				enemy:AddEntityFlags(EntityFlag.FLAG_APPLY_IMPACT_DAMAGE)
			elseif ppl:HasCollectible(CollectibleType.COLLECTIBLE_IRON_BAR) and 0.1 + ppl.Luck / 30 > ppl:GetCollectibleRNG(CollectibleType.COLLECTIBLE_IRON_BAR):RandomFloat() then
				enemy:AddConfusion(EntityRef(ppl), 52, false)
			end

			if tearFlags & TearFlags.TEAR_FEAR == TearFlags.TEAR_FEAR then -- or ppl:HasCollectible(CollectibleType.COLLECTIBLE_SPIDER_BITE) then
				enemy:AddFear(EntityRef(ppl), 52)
			elseif ppl:HasCollectible(CollectibleType.COLLECTIBLE_DARK_MATTER) and 0.1 + ppl.Luck / 25 > ppl:GetCollectibleRNG(CollectibleType.COLLECTIBLE_GLAUCOMA):RandomFloat() then
				enemy:AddFear(EntityRef(ppl), 52)
			elseif ppl:HasCollectible(CollectibleType.COLLECTIBLE_ABADDON) and 0.15 + ppl.Luck/100 > ppl:GetCollectibleRNG(CollectibleType.COLLECTIBLE_ABADDON):RandomFloat() then
				enemy:AddFear(EntityRef(ppl), 52)
			elseif ppl:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_PERFUME) and 0.15 + ppl.Luck/100 > ppl:GetCollectibleRNG(CollectibleType.COLLECTIBLE_MOMS_PERFUME):RandomFloat() then
				enemy:AddFear(EntityRef(ppl), 52)
			end

			if tearFlags & TearFlags.TEAR_FREEZE == TearFlags.TEAR_FREEZE then
				enemy:AddFreeze(EntityRef(ppl), 52)
			elseif ppl:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_CONTACTS) then
				local chance = 0.2 + ppl.Luck/66
				if chance > 0.5 then chance = 0.5 end
				if 0.2 + ppl.Luck/66  > ppl:GetCollectibleRNG(CollectibleType.COLLECTIBLE_MOMS_CONTACTS):RandomFloat() then
					enemy:AddFreeze(EntityRef(ppl), 52)
				end
			end

			if tearFlags & TearFlags.TEAR_MIDAS == TearFlags.TEAR_MIDAS then
				enemy:AddMidasFreeze(EntityRef(ppl), 52)
			elseif ppl:HasCollectible(CollectibleType.COLLECTIBLE_EYE_OF_GREED) and data.EyeGreedCounter == 20 then
				ppl:AddCoins(-1)
				enemy:AddMidasFreeze(EntityRef(ppl), 102)
				if ppl:GetNumCoins() > 0 then
					damage = 1.5*damage + 10
				end
			end

			if tearFlags & TearFlags.TEAR_POISON == TearFlags.TEAR_POISON then -- > 0
				enemy:AddPoison(EntityRef(ppl), 52, ppl.Damage) -- Scorpio
			elseif ppl:HasCollectible(CollectibleType.COLLECTIBLE_SCORPIO) then
				enemy:AddPoison(EntityRef(ppl), 52, ppl.Damage)
			elseif ppl:HasCollectible(CollectibleType.COLLECTIBLE_COMMON_COLD) and 0.25 + ppl.Luck/16 > ppl:GetCollectibleRNG(CollectibleType.COLLECTIBLE_COMMON_COLD):RandomFloat() then
				enemy:AddPoison(EntityRef(ppl), 52, ppl.Damage)
			elseif ppl:HasCollectible(CollectibleType.COLLECTIBLE_SERPENTS_KISS) and 0.15 + ppl.Luck/15 > ppl:GetCollectibleRNG(CollectibleType.COLLECTIBLE_SERPENTS_KISS):RandomFloat() then
				enemy:AddPoison(EntityRef(ppl), 52, ppl.Damage)
			elseif ppl:HasTrinket(TrinketType.TRINKET_PINKY_EYE) and 0.1 + ppl.Luck/20 > ppl:GetTrinketRNG(TrinketType.TRINKET_PINKY_EYE):RandomFloat() then
				enemy:AddPoison(EntityRef(ppl), 52, ppl.Damage)
			end

			if ppl:HasCollectible(CollectibleType.COLLECTIBLE_IPECAC) or (ppl:HasTrinket(TrinketType.TRINKET_TORN_CARD) and data.TornCardCounter == 15)then
				game:BombExplosionEffects(enemy.Position, 40, TearFlags.TEAR_POISON, Color.Default, ppl, 1, true, false, DamageFlag.DAMAGE_EXPLOSION)
			end

			--[[
			if ppl:HasCollectible(CollectibleType.COLLECTIBLE_DR_FETUS) then
				game:BombExplosionEffects(enemy.Position, 30+ppl.Damage*3, ppl.TearFlags, Color.Default, ppl, 1, true, false, DamageFlag.DAMAGE_EXPLOSION)
			end
			--]]

			--if tearFlags & TearFlags.TEAR_SHRINK == TearFlags.TEAR_SHRINK then
			--	enemy:AddShrink(EntityRef(ppl), 102)
			--elseif
			if ppl:HasCollectible(CollectibleType.COLLECTIBLE_GODS_FLESH) and  0.1 > ppl:GetCollectibleRNG(CollectibleType.COLLECTIBLE_GODS_FLESH):RandomFloat() then
				enemy:AddShrink(EntityRef(ppl), 102)
			end

			if tearFlags & TearFlags.TEAR_SLOW == TearFlags.TEAR_SLOW then -- or ppl:HasCollectible(CollectibleType.COLLECTIBLE_SPIDER_BITE) then
				enemy:AddSlowing(EntityRef(ppl), 52, 0.5, Color(2,2,2,1,0.196,0.196,0.196))
			elseif ppl:HasCollectible(CollectibleType.COLLECTIBLE_SPIDER_BITE) and  0.25 + ppl.Luck/20 > ppl:GetCollectibleRNG(CollectibleType.COLLECTIBLE_SPIDER_BITE):RandomFloat() then
				enemy:AddSlowing(EntityRef(ppl), 52, 0.5, Color(2,2,2,1,0.196,0.196,0.196))
			elseif ppl:HasCollectible(CollectibleType.COLLECTIBLE_BALL_OF_TAR) and 0.25 + ppl.Luck/24 > ppl:GetCollectibleRNG(CollectibleType.COLLECTIBLE_BALL_OF_TAR):RandomFloat() then
				enemy:AddSlowing(EntityRef(ppl), 52, 0.5, Color(0.15, 0.15, 0.15, 1, 0, 0, 0))
			elseif ppl:HasTrinket(TrinketType.TRINKET_CHEWED_PEN) and 0.1 + ppl.Luck/20 > ppl:GetTrinketRNG(TrinketType.TRINKET_CHEWED_PEN):RandomFloat() then
				enemy:AddSlowing(EntityRef(ppl), 52, 0.5, Color(0.15, 0.15, 0.15, 1, 0, 0, 0))
			end

			if data.UsedBG then
				enemy:AddEntityFlags(EntityFlag.FLAG_BLEED_OUT)
				enemy:GetData().BackStabbed = 52
			elseif ppl:HasCollectible(CollectibleType.COLLECTIBLE_BACKSTABBER) and 0.25 > ppl:GetCollectibleRNG(CollectibleType.COLLECTIBLE_BACKSTABBER):RandomFloat() then
				enemy:AddEntityFlags(EntityFlag.FLAG_BLEED_OUT)
				enemy:GetData().BackStabbed = 52
			end

			if ppl:HasCollectible(CollectibleType.COLLECTIBLE_URANUS) and not enemy:HasEntityFlags(EntityFlag.FLAG_ICE) then-- and enemy:HasMortalDamage() then
				enemy:AddEntityFlags(EntityFlag.FLAG_ICE)
			end

			if ppl:HasCollectible(CollectibleType.COLLECTIBLE_ROTTEN_TOMATO) and 16.67 + ppl.Luck/0.06  > ppl:GetCollectibleRNG(CollectibleType.COLLECTIBLE_BACKSTABBER):RandomFloat() then
				enemy:AddEntityFlags(EntityFlag.FLAG_BAITED)
				enemy:GetData().BaitedTomato = 102
			end

			if ppl:HasCollectible(CollectibleType.COLLECTIBLE_PLAYDOUGH_COOKIE) then
				rng = ppl:GetCollectibleRNG(CollectibleType.COLLECTIBLE_PLAYDOUGH_COOKIE)
				local index = rng:RandomInt(10) -- 0 is None
				if index == 1 then
					enemy:AddPoison(EntityRef(ppl), 52, ppl.Damage)
				elseif index == 2 then
					enemy:AddFear(EntityRef(ppl), 52)
				elseif index == 3 then
					enemy:AddShrink(EntityRef(ppl), 52)
				elseif index == 4 then
					enemy:AddSlowing(EntityRef(ppl), 52, 0.5, Color(2,2,2,1,0.196,0.196,0.196))
					if not enemy:HasEntityFlags(EntityFlag.FLAG_ICE) then enemy:AddEntityFlags(EntityFlag.FLAG_ICE) end
				elseif index == 5 then
					enemy:AddCharmed(EntityRef(ppl), 52)
				elseif index == 6 then
					enemy:AddBurn(EntityRef(ppl), 52, ppl.Damage)
					if 0.33 + ppl.Luck/20 > rng:RandomFloat() then
						game:BombExplosionEffects(enemy.Position, ppl.Damage, TearFlags.TEAR_BURN, Color.Default, ppl, 1, true, false, DamageFlag.DAMAGE_EXPLOSION)
					end
				elseif index == 7 then
					enemy:AddFreeze(EntityRef(ppl), 52)
				elseif index == 8 then
					enemy:AddEntityFlags(EntityFlag.FLAG_BAITED)
					enemy:GetData().BaitedTomato = 102
				elseif index == 9 then
					enemy:AddConfusion(EntityRef(ppl), 52, false)
				end
			end

			if ppl:HasCollectible(CollectibleType.COLLECTIBLE_MYSTERIOUS_LIQUID) then
				local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_GREEN, 0, enemy.Position, Vector.Zero, ppl):ToEffect() --25
				creep.CollisionDamage = 1
			end

			if ppl:HasCollectible(CollectibleType.COLLECTIBLE_MULLIGAN) then
				rng = ppl:GetCollectibleRNG(CollectibleType.COLLECTIBLE_MULLIGAN)
				if 1/6 > rng:RandomFloat() then
					ppl:AddBlueFlies(1, ppl.Position, enemy)
				end
			end

			if ppl:HasCollectible(CollectibleType.COLLECTIBLE_EXPLOSIVO) then
				rng = ppl:GetCollectibleRNG(CollectibleType.COLLECTIBLE_EXPLOSIVO)
				if 0.25 > rng:RandomFloat() then
					local expo = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.EXPLOSIVO, 0, enemy.Position, Vector.Zero, ppl):ToTear() --25
					expo:AddTearFlags(TearFlags.TEAR_STICKY)
					expo.CollisionDamage = 0
					expo.FallingSpeed = 5
				end
			end

			if ppl:HasCollectible(CollectibleType.COLLECTIBLE_MUCORMYCOSIS) then
				rng = ppl:GetCollectibleRNG(CollectibleType.COLLECTIBLE_MUCORMYCOSIS)
				if 0.25 > rng:RandomFloat() then
					local myco = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.SPORE, 0, enemy.Position, Vector.Zero, ppl):ToTear() --25
					myco:AddTearFlags(TearFlags.TEAR_SPORE)
					myco.CollisionDamage = 0
					myco.FallingSpeed = 5
				end
			end

			if ppl:HasCollectible(CollectibleType.COLLECTIBLE_SINUS_INFECTION) then
				if 0.2 > ppl:GetCollectibleRNG(CollectibleType.COLLECTIBLE_SINUS_INFECTION):RandomFloat() then
					local booger = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BOOGER, 0, enemy.Position, Vector.Zero, ppl):ToTear() --25
					if ppl:HasTrinket(TrinketType.TRINKET_NOSE_GOBLIN) and 0.5 > ppl:GetCollectibleRNG(CollectibleType.COLLECTIBLE_SINUS_INFECTION):RandomFloat() then
						booger:AddTearFlags(TearFlags.TEAR_HOMING)
					end
					booger:AddTearFlags(TearFlags.TEAR_BOOGER)
					booger.CollisionDamage = 0
					booger.FallingSpeed = 5
				end
			elseif ppl:HasTrinket(TrinketType.TRINKET_NOSE_GOBLIN) then
				if 0.1 > ppl:GetTrinketRNG(TrinketType.TRINKET_NOSE_GOBLIN):RandomFloat() then
					local booger = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BOOGER, 0, enemy.Position, Vector.Zero, ppl):ToTear() --25
					booger:AddTearFlags(TearFlags.TEAR_BOOGER | TearFlags.TEAR_HOMING)
					booger.CollisionDamage = 0
					booger.FallingSpeed = 5
				end
			end

			if ppl:HasCollectible(CollectibleType.COLLECTIBLE_PARASITOID) then
				rng = ppl:GetCollectibleRNG(CollectibleType.COLLECTIBLE_PARASITOID)
				local chance = 0.15 + ppl.Luck/14
				if chance > 0.5 then chance = 0.5 end
				if chance > rng:RandomFloat() then
					local egg = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.EGG, 0,  enemy.Position, Vector.Zero, ppl):ToTear() --25
					egg:AddTearFlags(TearFlags.TEAR_EGG)
					egg.CollisionDamage = 0
					egg.FallingSpeed = 5
				end
			end

			enemy:TakeDamage(damage, 0, EntityRef(ppl), 1)
			enemy:AddVelocity((enemy.Position - auraPos):Resized(knockback))
		else
			--print("immune enemy:", enemy.Type, enemy.Variant, enemy.SubType)
			if enemy:ToBomb() then -- trollbomb
				if ppl:HasCollectible(CollectibleType.COLLECTIBLE_KNOCKOUT_DROPS) and 0.1 + ppl.Luck/10 > ppl:GetCollectibleRNG(CollectibleType.COLLECTIBLE_KNOCKOUT_DROPS):RandomFloat() then
					knockback = 2*knockback
				end
				enemy:AddVelocity((enemy.Position - auraPos):Resized(knockback))
			elseif enemy.Type == 292 or enemy.Type == 33 then -- TNT or Fireplace
				enemy:TakeDamage(damage, 0, EntityRef(ppl), 1)
			end
		end -- vulnerable and active
	end -- for
end

local function AuraInit(ppl, effect, scale, damage)
	local range = ppl.TearRange*scale
	effect.SpriteScale = effect.SpriteScale * range/100 --effect.SpriteScale * ((ppl.TearRange - scale*ppl.TearRange)/200)
	effect.Color = mod.ObliviousData.Stats.LASER_COLOR
	local auraPos = effect.Position

	if ppl:HasCollectible(CollectibleType.COLLECTIBLE_LOST_CONTACT) then
		local bullets = Isaac.FindInRadius(auraPos, range, EntityPartition.BULLET)
		if #bullets > 0 then
			for _, bullet in pairs(bullets) do
				if bullet:ToProjectile() then
					bullet:Kill()
				end
			end
		end
	end

	local enemies = Isaac.FindInRadius(auraPos, range, EntityPartition.ENEMY)
	--if #enemies == 0 then
	if #enemies > 0 then
		AuraEnemies(ppl, auraPos, enemies, damage)
	end
end

local function AuraCriketPatterSpawn(player, pos, radius, velocity, entityType, entityVariant, entitySubtype)
	local point = radius*math.cos(math.rad(45))
	local scale = 0.25
	local ul = Isaac.Spawn(entityType, entityVariant, entitySubtype, Vector(pos.X+point, pos.Y+point), Vector(velocity, velocity), player):ToEffect() -- up left
	local dl = Isaac.Spawn(entityType, entityVariant, entitySubtype, Vector(pos.X+point, pos.Y-point), Vector(velocity, -velocity), player):ToEffect() -- down left
	local ur = Isaac.Spawn(entityType, entityVariant, entitySubtype, Vector(pos.X-point, pos.Y+point), Vector(-velocity, velocity), player):ToEffect() -- up right
	local dr = Isaac.Spawn(entityType, entityVariant, entitySubtype, Vector(pos.X-point, pos.Y-point), Vector(-velocity, -velocity), player):ToEffect() -- down right
	AuraInit(player, ul, scale, player.Damage/2)
	AuraInit(player, dl, scale, player.Damage/2)
	AuraInit(player, ur, scale, player.Damage/2)
	AuraInit(player, dr, scale, player.Damage/2)
end

local function AuraLokiHornsPatterSpawn(player, pos, radius, velocity, entityType, entityVariant, entitySubtype)
	local scale = 0.25
	local ul = Isaac.Spawn(entityType, entityVariant, entitySubtype, Vector(pos.X, pos.Y+radius), Vector(0, velocity), player):ToEffect()--up
	local dl = Isaac.Spawn(entityType, entityVariant, entitySubtype, Vector(pos.X, pos.Y-radius), Vector(0, -velocity), player):ToEffect() --down
	local ur = Isaac.Spawn(entityType, entityVariant, entitySubtype, Vector(pos.X+radius, pos.Y), Vector(velocity, 0), player):ToEffect()--right
	local dr = Isaac.Spawn(entityType, entityVariant, entitySubtype, Vector(pos.X-radius, pos.Y), Vector(-velocity, 0), player):ToEffect() --left
	AuraInit(player, ul, scale, player.Damage/2)
	AuraInit(player, dl, scale, player.Damage/2)
	AuraInit(player, ur, scale, player.Damage/2)
	AuraInit(player, dr, scale, player.Damage/2)
end

local function UnbiddenAura(player, auraPos, delayOff, damage , range, blockLasers)

	local room = game:GetRoom()
	local data = player:GetData()
	local rng = modRNG
	range = range or player.TearRange*0.5
	damage = damage or player.Damage

	if data.UnbiddenBrimCircle and not blockLasers then
		local laser = player:FireTechXLaser(auraPos, Vector.Zero, range, player, 1):ToLaser()
		laser.Color = mod.ObliviousData.Stats.LASER_COLOR
		laser:SetTimeout(data.UnbiddenBrimCircle)
		--if math.floor(player.MaxFireDelay) + mod.ObliviousData.DamageDelay -
		local newRange = (data.ObliviousDamageDelay)/(math.floor(player.MaxFireDelay) + mod.ObliviousData.DamageDelay)
		if newRange < 0.25 then newRange = 0.25 end
		laser.Radius = range*newRange
		laser:GetData().UnbiddenBrimLaser = data.UnbiddenBrimCircle-1
		if not delayOff then
			data.ObliviousDamageDelay = 0 --
		end
		return
	end

	if not delayOff then
		data.ObliviousDamageDelay = 0 --
	end

	local effect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HALO, 8, auraPos, Vector.Zero, player):ToEffect()
	effect.Color =  mod.ObliviousData.Stats.LASER_COLOR

	effect.SpriteScale = effect.SpriteScale * range/100 --effect.SpriteScale * (player.TearRange/200)
	if mod.ObliviousData.DamageDelay + math.floor(player.MaxFireDelay) > 8 then
		sfx:Play(321, 1, 2, false, 10)
	end



	if player:HasCollectible(CollectibleType.COLLECTIBLE_LARGE_ZIT) and 0.25 > player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_LARGE_ZIT):RandomFloat() then
		player:DoZitEffect(player:GetLastDirection())
	end

	if player:HasCollectible(CollectibleType.COLLECTIBLE_EYE_OF_GREED) then
		--if not data.EyeGreedCounter then data.EyeGreedCounter = 0 end
		data.EyeGreedCounter = data.EyeGreedCounter or 0
		if data.EyeGreedCounter >= 20 then
			data.EyeGreedCounter = 0
		end
		data.EyeGreedCounter = data.EyeGreedCounter + 1
	end

	local gridList = AuraGridEffect(player, auraPos)

	if player:HasTrinket(TrinketType.TRINKET_TORN_CARD) then
		--if not data.TornCardCounter then data.TornCardCounter = 0 end
		data.TornCardCounter = data.TornCardCounter or 0
		if data.TornCardCounter >= 15 then data.TornCardCounter = 0 end
		data.TornCardCounter = data.TornCardCounter + 1
	end

	if player:HasCollectible(CollectibleType.COLLECTIBLE_HOLY_LIGHT) then
		rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_HOLY_LIGHT)
		local chance = 0.1 + player.Luck/22.5
		if chance > 0.5 then chance = 0.5 end
		if chance > rng:RandomFloat() then
			Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CRACK_THE_SKY, 0, gridList[rng:RandomInt(#gridList)+1], Vector.Zero, player):ToEffect()
		end
	end

	if player:HasCollectible(CollectibleType.COLLECTIBLE_CRICKETS_BODY) then
		AuraCriketPatterSpawn(player, auraPos, range, 0, EntityType.ENTITY_EFFECT, EffectVariant.HALO, 8)

	end

	if player:HasCollectible(CollectibleType.COLLECTIBLE_LOKIS_HORNS) then
		rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_LOKIS_HORNS)
		local chance = 0.25 + player.Luck/20
		if chance > rng:RandomFloat() then
			AuraLokiHornsPatterSpawn(player, auraPos, range, 0, EntityType.ENTITY_EFFECT, EffectVariant.HALO, 8)
		end
	end

	if player:HasCollectible(CollectibleType.COLLECTIBLE_EYE_SORE) then
		rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_EYE_SORE)
		local numSore = rng:RandomInt(4)
		for _ = 1, numSore do
			local eaura = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HALO, 8, room:GetRandomPosition(1), Vector.Zero, player):ToEffect()
			--eaura.Color = mod.ObliviousData.Stats.LASER_COLOR
			AuraInit(player, eaura, 0.5, player.Damage)
		end
	end

	if player:HasCollectible(CollectibleType.COLLECTIBLE_HAEMOLACRIA) then
		rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_HAEMOLACRIA)
		local numAura = rng:RandomInt(6)+6
		for _ = 1, numAura do
			local haemscale = rng:RandomFloat()
			if haemscale < 0.5 then
				haemscale = 0.5
			elseif haemscale > 0.8333 then
				haemscale = 0.8333
			end
			local haura = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HALO, 8, room:GetRandomPosition(1), Vector.Zero, player):ToEffect()
			--haura.Color = mod.ObliviousData.Stats.LASER_COLOR
			AuraInit(player, haura, haemscale, player.Damage * haemscale)
		end
	end




	if player:HasCollectible(CollectibleType.COLLECTIBLE_ANTI_GRAVITY) then
		local tear = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.MULTIDIMENSIONAL, 0, gridList[rng:RandomInt(#gridList)+1], Vector.Zero, player):ToTear()
		tear:AddTearFlags(player.TearFlags)
		tear.CollisionDamage = player.Damage
		tear.FallingSpeed = 5

		if player:HasCollectible(CollectibleType.COLLECTIBLE_COMPOUND_FRACTURE) then
			--tear:AddTearFlags(TearFlags.TEAR_BONE)
			--tear.Variant = TearVariant.BONE
			--tear:ChangeVariant(TearVariant.BONE)
			tear.Velocity =  player:GetLastDirection() * player.ShotSpeed * 10
			tear.FallingSpeed = 0
		end

		if player:HasTrinket(TrinketType.TRINKET_BLACK_TOOTH) then
			rng = player:GetTrinketRNG(TrinketType.TRINKET_BLACK_TOOTH)
			if 0.1 + player.Luck/36 > rng:RandomFloat() then
				tear:AddTearFlags(TearFlags.TEAR_POISON)
				tear:ChangeVariant(TearVariant.BLACK_TOOTH)
				tear.CollisionDamage = player.Damage * 2
			end
		end

		if player:HasCollectible(CollectibleType.COLLECTIBLE_TOUGH_LOVE) then
			rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_TOUGH_LOVE)
			local chance = 0.1 + player.Luck/10
			if chance > rng:RandomFloat() then
				tear:ChangeVariant(TearVariant.TOOTH)
				tear.CollisionDamage = player.Damage * 4
			end
		end

		if player:HasCollectible(CollectibleType.COLLECTIBLE_APPLE) then
			rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_APPLE)
			local chance = 0.0666 + player.Luck/15
			if chance > rng:RandomFloat() then
				tear.Variant = TearVariant.RAZOR
				tear.Velocity =  player:GetLastDirection() * player.ShotSpeed * 10
				tear.CollisionDamage = player.Damage * 4
			end
		end
	end
	--print(auraPos)
	local enemies = Isaac.FindInRadius(auraPos, range, EntityPartition.ENEMY)
	if #enemies == 0 then
		if player:HasCollectible(CollectibleType.COLLECTIBLE_DEAD_EYE) then
			if data.DeadEyeMissCounter < 3 then
				data.DeadEyeMissCounter = data.DeadEyeMissCounter + 1
			end
		end
	elseif #enemies > 0 then

		if player:HasCollectible(CollectibleType.COLLECTIBLE_DEAD_EYE) then
			if data.DeadEyeCounter < 4 then
				data.DeadEyeMissCounter = 0
				data.DeadEyeCounter = data.DeadEyeCounter + 1
			end
			local DeadEyeMissChance = 0
			if data.DeadEyeMissCounter > 0 then
				DeadEyeMissChance = 0.5 -- if > 3
				if data.DeadEyeMissCounter == 1 then
					DeadEyeMissChance = 0.2
				elseif data.DeadEyeMissCounter == 2 then
					DeadEyeMissChance = 0.33
				end
			end
			if DeadEyeMissChance > player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_DEAD_EYE):RandomFloat() then
				data.DeadEyeCounter = 0
			end
			damage = player.Damage + player.Damage*(data.DeadEyeCounter/4)
		end
		for _, enemy in pairs(enemies) do
			if player:HasCollectible(CollectibleType.COLLECTIBLE_PARASITE) then
				if damage/2 > 1 then
					local paura = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HALO, 8, enemy.Position, Vector.Zero, nil):ToEffect()
					--paura.Color = mod.ObliviousData.Stats.LASER_COLOR
					AuraInit(player, paura, 0.25, damage*0.5) -- damage
				end
			end
		end
		AuraEnemies(player, auraPos, enemies, damage)
	end
end

local function GodHeadAura(player)
	local pos = player.Position
	local glowa = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HALO, 2, pos, Vector.Zero, player):ToEffect()
	local range = player.TearRange*0.33--0.16
	glowa.SpriteScale = glowa.SpriteScale * range/100 --glowa.SpriteScale * (player.TearRange - player.TearRange/1.5)/200
	glowa.Color = mod.OblivionCard.PoofColor --Color(0,0,0,1)
	local enemies = Isaac.FindInRadius(pos, range, EntityPartition.ENEMY)
	--[
	if #enemies > 0 then
		for _, enemy in pairs(enemies) do
			if enemy:IsVulnerableEnemy() and enemy:IsActiveEnemy() then -- and game:GetFrameCount()%10 == 0 then
				enemy:TakeDamage(2, 0, EntityRef(player), 1)
				--enemy:AddVelocity((enemy.Position - pos):Resized(16))
			end
		end
	end
	--]
end

local function TechDot5Shot(player)
	local laser = player:FireTechXLaser(player.Position, Vector.Zero, player.TearRange/2, player, 1):ToLaser()
	--local laser = player:FireTechLaser(player.Position, LaserOffset.LASER_TECH5_OFFSET, player:GetShootingInput(), false, false, player, 1)
	laser:ClearTearFlags(laser.TearFlags)
	laser:GetData().UnbiddenTechDot5Laser = true
	--laser:SetColor(mod.ObliviousData.Stats.LASER_COLOR, 5000, 100, true, false)
end

local function WeaponAura(player, auraPos, frameCount, maxCharge, range, blockLasers)
	range = range or player.TearRange*0.33
	frameCount = frameCount or game:GetFrameCount()
	maxCharge = maxCharge or mod.ObliviousData.DamageDelay + math.floor(player.MaxFireDelay)
	if maxCharge == 0 then maxCharge = mod.ObliviousData.DamageDelay end
	--print(frameCount, maxCharge)
	if frameCount%maxCharge == 0 then
		local tearsNum = GetMultiShotNum(player)
		for _ = 0, tearsNum do -- start from 0. cause you must have at least 1 multiplier
			--UnbiddenAura(player, auraPos) -- idk why knife is attacks 2 times (updates 2 times?)
			UnbiddenAura(player, auraPos, nil, nil, range, blockLasers)
		end
	end
end

local function Technology2Aura(player)
	local range = player.TearRange*0.33
	local laser = player:FireTechXLaser(player.Position, Vector.Zero, range, player, 1):ToLaser()
	laser:AddEntityFlags(EntityFlag.FLAG_PERSISTENT)
	laser:GetData().UnbiddenTech2Laser = game:GetLevel():GetCurrentRoomIndex()
	laser:GetData().EnavleVisible = 0
	player:GetData().HasTech2Laser = true
	--laser.Color = mod.ObliviousData.Stats.LASER_COLOR
	--WhatSoundIsIt()
end

function mod:onLaserUpdate(laser) -- low
	local laserData = laser:GetData()
	if laser.SpawnerEntity and laser.SpawnerEntity:ToPlayer() and laser.SpawnerEntity:ToPlayer():GetPlayerType() == mod.Characters.Oblivious then
		local player = laser.SpawnerEntity:ToPlayer()
		local data = player:GetData()
		laser.Color = mod.ObliviousData.Stats.LASER_COLOR
		if laserData.UnbiddenLaser then
			laser:SetTimeout(5)
			laser.Radius = player.TearRange*0.25
			laser.Velocity = player:GetShootingInput() * player.ShotSpeed * 5


			if laserData.UnbiddenLaser ~= game:GetLevel():GetCurrentRoomIndex() then
				laserData.UnbiddenLaser = game:GetLevel():GetCurrentRoomIndex()
				data.ludo = false
			end


			if not data.TechLudo then data.TechLudo = true end
			--data.ObliviousDamageDelay = 0

			if not player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY) or not player:HasCollectible(CollectibleType.COLLECTIBLE_LUDOVICO_TECHNIQUE) or not data.BlindUnbidden then
				laser:Kill()
				data.TechLudo = false
			end


		elseif laserData.UnbiddenTech2Laser then
			if laserData.EnavleVisible > 0 then
				laserData.EnavleVisible = laserData.EnavleVisible -1
			else
				laser.Visible = true
			end

			if laserData.UnbiddenTech2Laser ~= game:GetLevel():GetCurrentRoomIndex() then
				laserData.UnbiddenTech2Laser = game:GetLevel():GetCurrentRoomIndex()
				laser.Visible = false
				laserData.EnavleVisible = 5
			end

			laser.Position = player.Position

			if player:GetFireDirection() ~= -1 then --
				laser:SetTimeout(3)
			end

		--elseif laserData.UnbiddenTechDot5Laser then
		elseif laserData.UnbiddenBrimLaser then
			if laser.Timeout < 4 and player:HasCollectible(CollectibleType.COLLECTIBLE_C_SECTION) and player:HasWeaponType(WeaponType.WEAPON_BRIMSTONE) then
				local fetusTear = player:FireTear(laser.Position, RandomVector()*player.ShotSpeed*14, false, false, false, player, 1 ):ToTear()
				--local fetusTear = Isaac.Spawn(EntityType.ENTITY_TEAR, 50, 2, pos, Vector.Zero, player):ToTear()
				fetusTear:ChangeVariant(50)
				fetusTear:AddTearFlags(TearFlags.TEAR_FETUS)
				fetusTear:GetData().BrimFetus = true
				--fetusTear:GetSprite()
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_LASER_UPDATE, mod.onLaserUpdate )

---KNIFE
function mod:onKnifeUpdate(knife, _) -- low
	if knife.SpawnerEntity and knife.SpawnerEntity:ToPlayer() then
		local player = knife.SpawnerEntity:ToPlayer()
		local data = player:GetData()
		if player:GetPlayerType() == mod.Characters.Oblivious then
			WeaponAura(player, knife.Position, knife.FrameCount, data.ObliviousDamageDelay, player.TearRange*0.5)
			--local function WeaponAura(player, auraPos, frameCount, maxCharge, range, blockLasers)
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_KNIFE_COLLISION, mod.onKnifeUpdate) --KnifeSubType --MC_POST_KNIFE_UPDATE

---FETUS BOMB
function mod:onFetusBombUpdate(bomb) -- low
	if bomb.IsFetus and bomb.SpawnerEntity and bomb.SpawnerEntity:ToPlayer() then
		local player = bomb.SpawnerEntity:ToPlayer()
		if player:GetPlayerType() == mod.Characters.Oblivious then
			WeaponAura(player, bomb.Position, bomb.FrameCount, 20) -- +7 bomb explodes on 40 frame
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_BOMB_UPDATE, mod.onFetusBombUpdate)

---FETUS TEAR
function mod:onTearUpdate(tear)
	if tear.SpawnerEntity and tear.SpawnerEntity:ToPlayer() and tear.SpawnerEntity:ToPlayer():GetPlayerType() == mod.Characters.Oblivious then
		local player = tear.SpawnerEntity:ToPlayer()
		tear.Color = mod.ObliviousData.Stats.TEAR_COLOR
		tear.SplatColor = mod.ObliviousData.Stats.LASER_COLOR
		if tear:HasTearFlags(TearFlags.TEAR_FETUS) then
			if tear:GetData().BrimFetus then
				WeaponAura(player, tear.Position, tear.FrameCount, 22, nil, true)
				--WeaponAura(player, auraPos, frameCount, maxCharge, range, blockLasers)
			elseif not player:GetData().UnbiddenBrimCircle then
				WeaponAura(player, tear.Position, tear.FrameCount)
			end
		elseif tear.Variant == TearVariant.SWORD_BEAM or tear.Variant == TearVariant.TECH_SWORD_BEAM then
			WeaponAura(player, tear.Position, tear.FrameCount)
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, mod.onTearUpdate)

---Target Mark
function mod:onTargetEffectUpdate(effect)
	if effect.SpawnerEntity and effect.SpawnerEntity:ToPlayer() and effect.SpawnerEntity:ToPlayer():GetPlayerType() == mod.Characters.Oblivious then
		local player = effect.SpawnerEntity:ToPlayer()
		effect.Color = mod.ObliviousData.Stats.TEAR_COLOR
		--effect:SetColor(mod.ObliviousData.Stats.TEAR_COLOR, 3, 99, false, true)
		WeaponAura(player, effect.Position, effect.FrameCount, nil, player.TearRange*0.5)
		--WeaponAura(player, auraPos, frameCount, maxCharge, range, blockLasers)
	end
end
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, mod.onTargetEffectUpdate, EffectVariant.TARGET)

---Target Occult
function mod:onTargetEffectUpdate(effect)
	if effect.SpawnerEntity and effect.SpawnerEntity:ToPlayer() and effect.SpawnerEntity:ToPlayer():GetPlayerType() == mod.Characters.Oblivious then
		local player = effect.SpawnerEntity:ToPlayer()
		effect.Color = mod.ObliviousData.Stats.TEAR_COLOR
		WeaponAura(player, effect.Position, effect.FrameCount, nil, player.TearRange*0.5)
		--WeaponAura(player, auraPos, frameCount, maxCharge, range, blockLasers)
	end
end
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, mod.onTargetEffectUpdate, EffectVariant.OCCULT_TARGET)

function mod:onPEffectUpdate3(player)
	local level = game:GetLevel()
	--local room = game:GetRoom()
	local data = player:GetData()
	local tempEffects = player:GetEffects()
	local rng = modRNG
	local idx = getPlayerIndex(player)

	if game:GetFrameCount() == 1 then player:RespawnFamiliars() end

	if data.BlockBeggar then
		if game:GetFrameCount() - data.BlockBeggar > 30 then data.BlockBeggar = nil end
	end

	--[
	if data.SadIceBombTear and #data.SadIceBombTear > 0 then
		local iceTab = {}
		for key, tab in pairs(data.SadIceBombTear) do
			tab[1] = tab[1] - 1
			if tab[1] == 0 then
				table.insert(iceTab, {key, tab[2]})
			end
		end
		if #iceTab> 0 then
			for i = #iceTab, 1, -1 do
				for _, tear in pairs(Isaac.FindInRadius(iceTab[i][2], 22, EntityPartition.TEAR)) do
					if tear.FrameCount == 1 then -- other tears can get this effects if you shoot tears near bomb (idk else how to get)
						tear = tear:ToTear()
						tear:ChangeVariant(TearVariant.ICE)
						tear:AddTearFlags(TearFlags.TEAR_SLOW | TearFlags.TEAR_ICE)
					end
				end
				table.remove(data.SadIceBombTear, iceTab[i][1])
			end
		end
	end
	--]

	---Nadab's Body
	if player:HasCollectible(mod.Items.NadabBody) then
		if player:GetPlayerType() ~= mod.Characters.Abihu then
			
			if data.HoldBomd == 0 and not player:IsHoldingItem() and data.NadabReHold and game:GetFrameCount() - data.NadabReHold > 30 then
				data.HoldBomd = -1
				data.NadabReHold = nil
			end
			
			-- holding bomb
			data.HoldBomd = data.HoldBomd or -1
			if data.HoldBomd == 1 then
				data.HoldBomd = -1
			elseif data.HoldBomd > 0 then
				data.HoldBomd = data.HoldBomd - 1
			end
		end

		if player:GetPlayerType() ~= mod.Characters.Nadab then
			ExplosionCountdownManager(player)
		end

		local bomboys = 0 -- nadab's body count
		local bombVar = BombVariant.BOMB_DECOY
		if player:GetPlayerType() == mod.Characters.Abihu then bombVar = -1 end
		local roombombs = Isaac.FindByType(EntityType.ENTITY_BOMB, bombVar) --, BombVariant.BOMB_DECOY)
		if #roombombs > 0 then
			for _, body in pairs(roombombs) do
				if body:GetData().bomby then
					bomboys = bomboys +1
				end
				-- check if abihu can hold bomb
				--if player:GetPlayerType() == mod.Characters.Abihu then
				if body.Position:Distance(player.Position) <= 30 and data.HoldBomd < 0 then
					if player:TryHoldEntity(body) then
						data.HoldBomd = 0
						data.NadabReHold = game:GetFrameCount()
						if body:GetData().bomby then
							data.AbihuHoldNadab = true
						end
					end
				end
				--end
			end
		end

		-- respawn nadab's body if it was somehow disappeared
		if bomboys < GetItemsCount(player, mod.Items.NadabBody) then
			bomboys = GetItemsCount(player, mod.Items.NadabBody) - bomboys
			for _=1, bomboys do
				local pos = Isaac.GetFreeNearPosition(player.Position, 25)
				Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, pos, Vector.Zero, nil)
				local bomb = Isaac.Spawn(EntityType.ENTITY_BOMB, BombVariant.BOMB_DECOY, 0, pos, Vector.Zero, player):ToBomb()
				bomb:GetData().bomby = true
				bomb:GetSprite():ReplaceSpritesheet(0, mod.NadabBody.SpritePath)
				bomb:GetSprite():LoadGraphics()
				bomb.Parent = player
			end
		end


		if Input.IsActionPressed(ButtonAction.ACTION_BOMB, 0) and player:GetPlayerType() == mod.Characters.Abihu then --Input.IsActionPressed(action, controllerId) IsActionTriggered
			local checkBombsNum = player:GetHearts()
			if checkBombsNum > 0 and data.ExCountdown == 0 then --  and not player:HasCollectible(CollectibleType.COLLECTIBLE_BLOOD_BOMBS) -- and player:GetNumBombs() > 0 then
				if player:HasCollectible(CollectibleType.COLLECTIBLE_ROCKET_IN_A_JAR) then
					if player:GetFireDirection() == -1 then
						data.ExCountdown = mod.NadabData.ExplosionCountdown
						if not player:HasCollectible(CollectibleType.COLLECTIBLE_PYROMANIAC) then
							player:TakeDamage(1, DamageFlag.DAMAGE_NO_PENALTIES | DamageFlag.DAMAGE_RED_HEARTS, EntityRef(player), 1)
						end
						FcukingBomberbody(player)
					else
						if not player:HasCollectible(CollectibleType.COLLECTIBLE_PYROMANIAC) then
							player:TakeDamage(1, DamageFlag.DAMAGE_NO_PENALTIES | DamageFlag.DAMAGE_RED_HEARTS, EntityRef(player), 1) -- take dmg first to apply MARS dash
						end
						data.ExCountdown = mod.NadabData.ExplosionCountdown
						local bodies2 = Isaac.FindByType(EntityType.ENTITY_BOMB, BombVariant.BOMB_DECOY)
						for _, body in pairs(bodies2) do
							if body:GetData().bomby then
								body:GetData().RocketBody = mod.NadabBody.RocketVol
								body.Velocity = player:GetShootingInput() * body:GetData().RocketBody
							end
						end
					end
				else
					data.ExCountdown = mod.NadabData.ExplosionCountdown
					if not player:HasCollectible(CollectibleType.COLLECTIBLE_PYROMANIAC) then
						player:TakeDamage(1, DamageFlag.DAMAGE_NO_PENALTIES | DamageFlag.DAMAGE_RED_HEARTS, EntityRef(player), 1)
					end
					FcukingBomberbody(player)
				end
			end
		end
	end

	if player:GetPlayerType() == mod.Characters.Nadab then
		AbihuNadabManager(player)
		ExplosionCountdownManager(player)
		--ice cube bombs
		if player:HasCollectible(mod.Items.FrostyBombs) and game:GetFrameCount() %8 == 0 then -- spawn every 8th frame
			local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_HOLYWATER_TRAIL, 0, player.Position, Vector.Zero, player):ToEffect() -- PLAYER_CREEP_RED
			creep.SpriteScale = creep.SpriteScale * 0.1
		end

		--bob's bladder
		if player:HasTrinket(TrinketType.TRINKET_BOBS_BLADDER) and game:GetFrameCount() %8 == 0 then -- spawn every 8th frame
			Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_GREEN, 0, player.Position, Vector.Zero, player)
		end

		--ring cap explosion
		if data.RingCapDelay then
			--print(data.RingCapDelay)
			data.RingCapDelay = data.RingCapDelay + 1
			if data.RingCapDelay > player:GetTrinketMultiplier(TrinketType.TRINKET_RING_CAP) * mod.NadabData.RingCapFrameCount then
				data.RingCapDelay = nil
			elseif data.RingCapDelay % mod.NadabData.RingCapFrameCount == 0 then
				if player:HasCollectible(mod.Items.MirrorBombs) then
					NadabExplosion(player, false, FlipMirrorPos(player.Position))
				end
				NadabExplosion(player, false, player.Position)
			end
		end

		--birthright
		if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
			--data.HasItemBirthright = data.HasItemBirthright or 0
			if not savetable.HasItemBirthright then modDataLoad() end
			savetable.HasItemBirthright[idx] = savetable.HasItemBirthright[idx] or 0
			--if GetItemsCount(player, CollectibleType.COLLECTIBLE_BIRTHRIGHT) ~= data.HasItemBirthright then
			if GetItemsCount(player, CollectibleType.COLLECTIBLE_BIRTHRIGHT) ~= savetable.HasItemBirthright[idx] then
				local numBirthright = GetItemsCount(player, CollectibleType.COLLECTIBLE_BIRTHRIGHT)
				--if numBirthright > data.HasItemBirthright then
				if numBirthright > savetable.HasItemBirthright[idx] then
					rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_BIRTHRIGHT)
					SpawnOptionItems(ItemPoolType.POOL_BOMB_BUM, rng:RandomInt(Random())+1, player.Position)
				end
				--data.HasItemBirthright = numBirthright
				savetable.HasItemBirthright[idx] = numBirthright
				modDataSave()
			end
		end

		--some bomb modifications
		data.HasFastBombs = NadabEvaluateStats(player, CollectibleType.COLLECTIBLE_FAST_BOMBS, CacheFlag.CACHE_SPEED, data.HasFastBombs)
		data.HasSadBombs = NadabEvaluateStats(player, CollectibleType.COLLECTIBLE_SAD_BOMBS, CacheFlag.CACHE_FIREDELAY, data.HasSadBombs)
		data.HasMegaBombs = NadabEvaluateStats(player, CollectibleType.COLLECTIBLE_MR_MEGA, CacheFlag.CACHE_DAMAGE, data.HasMegaBombs)
		data.HasSmartBombs = NadabEvaluateStats(player, CollectibleType.COLLECTIBLE_BOBBY_BOMB, CacheFlag.CACHE_TEARFLAG, data.HasSmartBombs)

		-- rocket in a jar
		if data.RocketMars then
			if not tempEffects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_MARS) then
				data.ExCountdown = mod.NadabData.ExplosionCountdown
				FcukingBomberman(player)
				data.RocketMars = false
			end
		end

		-- explosion
		if Input.IsActionPressed(ButtonAction.ACTION_BOMB, 0) then
			if player:GetHearts() > 0 and data.ExCountdown == 0 then
				if player:HasCollectible(CollectibleType.COLLECTIBLE_ROCKET_IN_A_JAR) then
					if player:GetMovementDirection() ~= -1 then
						if not player:HasCollectible(CollectibleType.COLLECTIBLE_PYROMANIAC) then
							player:TakeDamage(1, DamageFlag.DAMAGE_NO_PENALTIES | DamageFlag.DAMAGE_RED_HEARTS, EntityRef(player), 1)
						end
						-- take dmg first to apply MARS dash
						tempEffects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_MARS, false, 1)
						data.RocketMars = true
					else
						data.ExCountdown = mod.NadabData.ExplosionCountdown
						if not player:HasCollectible(CollectibleType.COLLECTIBLE_PYROMANIAC) then
							player:TakeDamage(1, DamageFlag.DAMAGE_NO_PENALTIES | DamageFlag.DAMAGE_RED_HEARTS, EntityRef(player), 1)
						end
						FcukingBomberman(player)
					end
				else
					data.ExCountdown = mod.NadabData.ExplosionCountdown
					if not player:HasCollectible(CollectibleType.COLLECTIBLE_PYROMANIAC) then
						player:TakeDamage(1, DamageFlag.DAMAGE_NO_PENALTIES | DamageFlag.DAMAGE_RED_HEARTS, EntityRef(player), 1)
					end
					FcukingBomberman(player)
				end
			end
		end

	--[[
	else
		if data.NadabCostumeEquipped then
			player:TryRemoveNullCostume(mod.NadabData.CostumeHead)
			data.NadabCostumeEquipped = false
			if player:HasCollectible(mod.Items.AbihuFam) then player:RemoveCollectible(mod.Items.AbihuFam) end
		end
	--]]
	end

	if player:GetPlayerType() == mod.Characters.Abihu then
		-- must be still able to move ludovico, knife ?
		-- charge fire and shoot it (similar to candle)

		--[[
		if player:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_KNIFE) and data.BlindAbihu then
			if data.BlindAbihu then
				data.BlindAbihu = nil
				SetBlindfold(player, false)
			end
			SetBlindfold(player, false)
		end
		--]]
		--data.AbihuIgnites = true


		AbihuNadabManager(player)

		-- holding bomb
		if not data.HoldBomd then data.HoldBomd = -1 end
		if data.HoldBomd == 1 then
			data.HoldBomd = -1
		elseif data.HoldBomd > 0 then
			data.HoldBomd = data.HoldBomd - 1
		end

		-- flamethrower
		data.AbihuDamageDelay = data.AbihuDamageDelay or 0
		local maxCharge =  math.floor(player.MaxFireDelay) + mod.AbihuData.DamageDelay

		--data.AbihuCostumeEquipped = true
		--player:AddNullCostume(mod.AbihuData.CostumeHead)

		-- if "shooting" / shoot inputs is pressed
		if player:GetFireDirection() == -1 then -- or data.AbihuIgnites
			if data.AbihuDamageDelay == maxCharge then
				local spid = math.floor(player.ShotSpeed * 7)
				sfx:Play(536)
				local flame = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLUE_FLAME, 0, player.Position, player:GetLastDirection()*spid, player):ToEffect()
				flame:SetTimeout(math.floor(player.TearRange*0.1))
				flame.CollisionDamage = player.Damage -- * 3
				flame:GetData().AbihuFlame = true
				flame.Parent = player
				data.AbihuDamageDelay = 0
			else
				data.AbihuDamageDelay = 0
			end

			-- drop bomb if you are holding it and didn't have throw delay
			-- OR
			-- remove nadab's body if you hold it long enough, it will respawn near player
			if Input.IsActionPressed(ButtonAction.ACTION_DROP, 0) and data.HoldBomd <= 0 then
				-- holding drop button
				data.HoldActionDrop = data.HoldActionDrop or 0
				data.HoldActionDrop = data.HoldActionDrop + 1 -- holding drop button
				if data.HoldActionDrop > 30 then
					if data.HoldBomd == 0 then
						data.HoldActionDrop = 0
						data.ThrowVelocity = Vector.Zero
						player:ThrowHeldEntity(data.ThrowVelocity)
						data.HoldBomd = mod.AbihuData.HoldBombDelay
						if data.AbihuHoldNadab then data.AbihuHoldNadab = nil end
					else --if data.HoldBomd == - 1 then
						data.HoldActionDrop = 0
						local bodies3 = Isaac.FindByType(EntityType.ENTITY_BOMB, BombVariant.BOMB_DECOY)
						if #bodies3 > 0 then
							for _, body in pairs(bodies3) do
								if body:GetData().bomby then
									body:Kill()
									data.HoldActionDrop = 0
								end
							end
						end
					end
				end
			else
				data.HoldActionDrop = 0
			end
		else
			if data.HoldBomd == 0 then
				if player:HasCollectible(CollectibleType.COLLECTIBLE_ROCKET_IN_A_JAR) then data.RocketThrowMulti = 14 end
				data.ThrowVelocity = player:GetShootingInput()*player.ShotSpeed
				player:ThrowHeldEntity(data.ThrowVelocity)
				data.HoldBomd = mod.AbihuData.HoldBombDelay
				if data.AbihuHoldNadab then data.AbihuHoldNadab = nil end
			elseif player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) or data.AbihuIgnites then
				if data.AbihuDamageDelay < maxCharge then
					data.AbihuDamageDelay = data.AbihuDamageDelay + 1
				elseif data.AbihuDamageDelay == maxCharge then
					if game:GetFrameCount() % 6 == 0 then
						player:SetColor(Color(1,1,1,1, 0.2, 0.2, 0.5), 2, 1, true, false)
					end
				end
			end
		end

		--birthright
		if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
			--data.HasItemBirthright = data.HasItemBirthright or 0
			if not savetable.HasItemBirthright then modDataLoad() end
			savetable.HasItemBirthright[idx] = savetable.HasItemBirthright[idx] or 0
			if not data.AbihuCostumeEquipped then
				data.AbihuCostumeEquipped = true
				player:AddNullCostume(mod.AbihuData.CostumeHead)
			end
			--if GetItemsCount(player, CollectibleType.COLLECTIBLE_BIRTHRIGHT) ~= data.HasItemBirthright then
			if GetItemsCount(player, CollectibleType.COLLECTIBLE_BIRTHRIGHT) ~= savetable.HasItemBirthright[idx] then
				local numBirthright = GetItemsCount(player, CollectibleType.COLLECTIBLE_BIRTHRIGHT)
				--if numBirthright > data.HasItemBirthright then
				if numBirthright > savetable.HasItemBirthright[idx] then
					player:SetFullHearts()
				end
				--data.HasItemBirthright = numBirthright
				savetable.HasItemBirthright[idx] = numBirthright
				modDataSave()
			end
		end

	--[[
	else
		if data.AbihuCostumeEquipped then
			player:TryRemoveNullCostume(mod.AbihuData.CostumeHead)
			data.AbihuCostumeEquipped = false
			if player:HasCollectible(mod.Items.NadabBody) then player:RemoveCollectible(mod.Items.NadabBody) end
		end
	--]]
	end

	if player:GetPlayerType() == mod.Characters.Unbidden then
		if player:GetMaxHearts() > 0 then
			local maxHearts = player:GetMaxHearts()
			player:AddMaxHearts(-maxHearts)
            --player:AddBlackHearts(maxHearts)
			player:AddSoulHearts(maxHearts)
        end

		if player:GetHearts() > 0 then
			player:AddHearts(-player:GetHearts())
		end

		if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
			--data.HasItemBirthright = data.HasItemBirthright or 0
			if not savetable.HasItemBirthright then modDataLoad() end
			savetable.HasItemBirthright[idx] = savetable.HasItemBirthright[idx] or 0
			--if GetItemsCount(player, CollectibleType.COLLECTIBLE_BIRTHRIGHT) ~= data.HasItemBirthright then
			if GetItemsCount(player, CollectibleType.COLLECTIBLE_BIRTHRIGHT) ~= savetable.HasItemBirthright[idx] then
				local numBirthright = GetItemsCount(player, CollectibleType.COLLECTIBLE_BIRTHRIGHT)
				--if numBirthright > data.HasItemBirthright then
				if numBirthright > savetable.HasItemBirthright[idx] then
					local broken = player:GetBrokenHearts()
                    player:AddBrokenHearts(-broken)
                    --player:AddBlackHearts(2*broken)
					player:AddSoulHearts(2*broken)
					AddItemFromWisp(player, true, false, false)
				end
				--data.HasItemBirthright = numBirthright
				savetable.HasItemBirthright[idx] = numBirthright
				modDataSave()
			end
		end

		if data.NoAnimReset then
			if player:IsDead() then
				player:Revive()
				player:AddSoulHearts(1)
			end
			player:AnimateTeleport(false)
            data.NoAnimReset = data.NoAnimReset - 1
			if data.NoAnimReset == 0 then
				data.NoAnimReset = nil
				player:AddBrokenHearts(1)
				--local addWitem = false
				--if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
				--	AddItemFromWisp(player, true, false, true)
				--end
				AddItemFromWisp(player, false, true, false)
			end
        end
	end

	if player:GetPlayerType() == mod.Characters.Oblivious then



		--[[
		if player:GetActiveItem(ActiveSlot.SLOT_POCKET) ~= mod.Items.Threshold then
			player:SetPocketActiveItem(mod.Items.Threshold, ActiveSlot.SLOT_POCKET, false)
		end
		--]]

		if player:GetSoulHearts() == 0 then
			player:AddSoulHearts(2)
		elseif player:GetSoulHearts() > 2 then
			player:AddSoulHearts(-1)
		end

		if not tempEffects:HasNullEffect(NullItemID.ID_LOST_CURSE) then
			tempEffects:AddNullEffect(NullItemID.ID_LOST_CURSE, false, 1)
		end

		--[[
		✓ ludo - controll tear. auto spawn aura
		✓ haemol - multiple random aura in room
		✓ ipecac - explode within aura
		✓ godhead - while you shot create aura around you. on a fixed distance. (no ludo)
		✓ bomb - aura spawn explosions on an enemies position
		✓ lungs - charge, activate aura multiple times with X frame delay. X = 2?
		✓ eye sore - chance to create additional 1-3 small aura within main aura range

		Brimstone - when fully charged cretes brim circle around you for x frames. circle follow you

		Laser - creates laser circle on tear range.
		Laser2 - while you shot create laser circle around you. on a fixed distance.
		tech x - semi-charge. when charged creates laser circle. circle follow you

		knife - remove blind, when shot knife activates aura multiple times with X frame delay. X = 2?
		knife+brim (similar to knife)
		ludo+knife
		ludo+brim
		ludo+knife+brim

		rockets - remove blind --OR aura spawn rockets on an enemies position
		axe - remove blind
		urn - remove blind

		sword -  remove blind, sword creates aura when you shoot(?)
		c section - remove blind, fetus creates aura every x frames
		umbilical whip - remove blind, fetus creates aura around himself when you shoot
		incubus - creates aura around himself

		cursed eye - semi-charge, activate aura multiple times with X frame delay. multiply to charge value (0.25-1/ 0.5-2/ 0.75-3/ 1.0-4)
		chocolate milk - semi-charge, increase aura damage to charge value.

		synergies
		COLLECTIBLE_BRIMSTONE
		COLLECTIBLE_MOMS_KNIFE
		COLLECTIBLE_TECHNOLOGY
		COLLECTIBLE_TECHNOLOGY_2
		COLLECTIBLE_TECH_X
		COLLECTIBLE_TECH.5
		COLLECTIBLE_EPIC_FETUS
		COLLECTIBLE_DR_FETUS
		COLLECTIBLE_UMBILICAL_WHIP
		COLLECTIBLE_SPIRIT_SWORD
		COLLECTIBLE_C_SECTION

		1 	WeaponType.WEAPON_TEARS                 aura
		2 	WeaponType.WEAPON_BRIMSTONE︎            charge brimstone ring
		3 	WeaponType.WEAPON_LASER                 aura + laser ring OR shoot lasers to enemies within aura range
		7 	WeaponType.WEAPON_MONSTROS_LUNGS        charge multiple aura
		8 	WeaponType.WEAPON_LUDOVICO_TECHNIQUE    control tear with auto-aura
		9 	WeaponType.WEAPON_TECH_X︎               semi-charge + laser ring

		4 	WeaponType.WEAPON_KNIFE                 no aura, charge knife, while shot knife creates auto-aura
		5 	WeaponType.WEAPON_BOMBS                 no aura, bombs creates auto-aura
		6 	WeaponType.WEAPON_ROCKETS               no aura, rockets creates aura
		10  WeaponType.WEAPON_BONE                  -
		11 	WeaponType.WEAPON_NOTCHED_AXE           no aura
		12 	WeaponType.WEAPON_URN_OF_SOULS          no aura
		13 	WeaponType.WEAPON_SPIRIT_SWORD          no aura
		14 	WeaponType.WEAPON_FETUS︎                no aura, fetus creates auto-aura

		15 	WeaponType.WEAPON_UMBILICAL_WHIP        familiar creates aura︎ [COLLECTIBLE_INCUBUS] [CAIN_OTHER_EYE] [FATE_REWARD]
		--]]


		--print(player:HasWeaponType(WeaponType.WEAPON_FETUS))
		--[
		--player:HasWeaponType(WeaponType)
		if player:HasWeaponType(WeaponType.WEAPON_BOMBS) or
			player:HasWeaponType(WeaponType.WEAPON_ROCKETS) or
			player:HasWeaponType(WeaponType.WEAPON_FETUS) or
			player:HasWeaponType(WeaponType.WEAPON_SPIRIT_SWORD) or
			player:HasWeaponType(WeaponType.WEAPON_KNIFE) then
			--if player:HasWeaponType(WeaponType.WEAPON_BRIMSTONE︎) then
			--print('b')

			if data.BlindUnbidden then
				data.BlindUnbidden = false
				SetBlindfold(player, false)
			end
		elseif not data.BlindUnbidden then
			data.BlindUnbidden = true
			SetBlindfold(player, true)
		end
		--]


		-- urn of souls and nocthed axe. idk how to remove tech2 laser when you use this items.
		--(i can remove all lasers while you have weapon but it's not a proper solution)
		local weapon = player:GetActiveWeaponEntity()
		if weapon then
			if (weapon:ToKnife() or weapon:ToEffect()) then
				data.ObliviousDamageDelay = 0
				data.HoldingWeapon = true

			end
		else
			data.HoldingWeapon = false
		end
		--print()

		if player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY) or player:HasCollectible(CollectibleType.COLLECTIBLE_BRIMSTONE) or player:HasCollectible(CollectibleType.COLLECTIBLE_TECH_X) then --
			data.ObliviousDamageDelay = data.ObliviousDamageDelay or 0
			local laserDelay = data.ObliviousDamageDelay
			if laserDelay < mod.ObliviousData.DamageDelay then laserDelay = mod.ObliviousData.DamageDelay end
			data.UnbiddenBrimCircle = laserDelay
			--data.UnbiddenBrimCircleRange = data.ObliviousDamageDelay
		elseif data.UnbiddenBrimCircle then
			data.UnbiddenBrimCircle = false
		end



		--[[
			local targets = Isaac.FindByType(1000, EffectVariant.TARGET)
			if #targets > 0 then
				for _, effect in pairs(targets) do
					if effect.SpawnerEntity and effect.SpawnerEntity:ToPlayer() and effect.SpawnerEntity:ToPlayer():GetPlayerType() == mod.Characters.Oblivious then
						effect.Color = mod.ObliviousData.Stats.TEAR_COLOR
						--effect:SetColor(mod.ObliviousData.Stats.TEAR_COLOR, 3, 99, false, true)
						--WeaponAura(player, effect.Position, effect.FrameCount)
						auraPos = effect.Position
					end
				end
			end
		end
		--]]

		--[[
		local epicRokets = Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.ROCKET)
		if #epicRokets > 0 then
			for _, rocket in pairs(epicRokets) do
				if rocket.SpawnerEntity and rocket.SpawnerEntity:ToPlayer() and rocket.SpawnerEntity:ToPlayer():GetPlayerType() == mod.Characters.Oblivious then

					WeaponAura(player, rocket.Position, rocket.FrameCount, 10)
				end
			end
		end
		--]]

		if data.BlindUnbidden then
			-- change position if you has ludo
			local auraPos = player.Position

			if player:HasCollectible(CollectibleType.COLLECTIBLE_DEAD_EYE) then
				data.DeadEyeCounter = data.DeadEyeCounter or 0
				data.DeadEyeMissCounter = data.DeadEyeMissCounter or 0
			end



			if player:HasCollectible(CollectibleType.COLLECTIBLE_MARKED) or player:HasCollectible(CollectibleType.COLLECTIBLE_CHOCOLATE_MILK) or player:HasCollectible(CollectibleType.COLLECTIBLE_TECH_X) or player:HasCollectible(CollectibleType.COLLECTIBLE_CURSED_EYE) then -- semi-charge
				data.UnbiddenSemiCharge = true
			elseif player:HasCollectible(CollectibleType.COLLECTIBLE_MONSTROS_LUNG) or player:HasCollectible(CollectibleType.COLLECTIBLE_BRIMSTONE) then --or player:HasWeaponType(WeaponType.WEAPON_MONSTROS_LUNGS) then
				data.UnbiddenFullCharge = true
				if data.UnbiddenSemiCharge then data.UnbiddenSemiCharge = false end
			else
				if data.UnbiddenFullCharge then data.UnbiddenFullCharge = false end
				if data.UnbiddenSemiCharge then data.UnbiddenSemiCharge = false end
			end

			-- ludovico tear
			if player:HasCollectible(CollectibleType.COLLECTIBLE_LUDOVICO_TECHNIQUE) then
				if Input.IsActionPressed(ButtonAction.ACTION_DROP, 0) then
					data.ludo = false
					data.TechLudo = false
				end

				--print(data.TechLudo)
				if player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY) then
					local lasers = Isaac.FindByType(EntityType.ENTITY_LASER)
					if #lasers > 0 then
						for _, laser in pairs(lasers) do
							if laser:GetData().UnbiddenLaser then
								auraPos = laser.Position
								if not data.ludo and player.Position:Distance(laser.Position) > 60 then
									laser:AddVelocity((player.Position - laser.Position):Resized(player.ShotSpeed*5))
								end
							end
						end
					else
						local laser = player:FireTechXLaser(auraPos, Vector.Zero, player.TearRange*0.5, player, 1):ToLaser()--Isaac.Spawn(EntityType.ENTITY_LASER, mod.ObliviousData.TearVariant, 0, player.Position, Vector.Zero, player):ToTear()
						--laser:AddTearFlags(player.TearFlags)
						laser:GetData().UnbiddenLaser = level:GetCurrentRoomIndex()
						laser:AddEntityFlags(EntityFlag.FLAG_PERSISTENT)
						laser:SetTimeout(30)
						data.TechLudo = true
					end
				else
					local tears = Isaac.FindByType(EntityType.ENTITY_TEAR, mod.ObliviousData.TearVariant)
					if #tears > 0 and not data.LudoTearEnable then
						for _, tear in pairs(tears) do
							if tear:GetData().UnbiddenTear then
								auraPos = tear.Position
								if not data.ludo and player.Position:Distance(tear.Position) > 60 then
									tear:AddVelocity((player.Position - tear.Position):Resized(player.ShotSpeed))
								end
							end
						end
					else
						local tear = Isaac.Spawn(EntityType.ENTITY_TEAR, mod.ObliviousData.TearVariant, 0, player.Position, Vector.Zero, player):ToTear()
						tear:AddTearFlags(player.TearFlags)
						tear.CollisionDamage = 0
						tear:GetData().UnbiddenTear = true
						tear.EntityCollisionClass = 0
						data.LudoTearEnable = false
					end
				end
			end

			--firedelay analog
			data.ObliviousDamageDelay = data.ObliviousDamageDelay or 0
			local maxCharge = math.floor(player.MaxFireDelay) + mod.ObliviousData.DamageDelay
			if not data.UnbiddenFullCharge and not data.UnbiddenSemiCharge then
				if data.ObliviousDamageDelay < maxCharge then data.ObliviousDamageDelay = data.ObliviousDamageDelay + 1 end
			end

			-- create multiply aura with X delayed frame (multishot analog)
			if data.MultipleAura and game:GetFrameCount()%2 == 0 then
				if data.MultipleAura > 0 then
					UnbiddenAura(player, auraPos, true)
					data.MultipleAura = data.MultipleAura - 1
				else
					data.MultipleAura = nil
				end
			end

			-- if not shooting
			if player:GetFireDirection() == -1 then
				if data.HasTech2Laser then data.HasTech2Laser = false end
				if data.UnbiddenSemiCharge and data.ObliviousDamageDelay > 0 then

					--local damageMultiplier = player.Damage
					local tearsNum = GetMultiShotNum(player)
					data.MultipleAura = data.MultipleAura or 0
					local chargeCounter = math.floor((data.ObliviousDamageDelay * 100) /maxCharge)
					if player:HasCollectible(CollectibleType.COLLECTIBLE_CURSED_EYE) then
						tearsNum = tearsNum + math.floor(chargeCounter*0.04) --(1/25) -- add +1 aura activation for each 25 charge counter
					end
					if player:HasCollectible(CollectibleType.COLLECTIBLE_MONSTROS_LUNG) then
						tearsNum = tearsNum + 1+ math.floor(chargeCounter * 0.13) --(min = 1 ; max = 14) -- magic number :) monstro lung creates 14 tears when fully charged so 1 + 13/100
					end
					data.MultipleAura = data.MultipleAura + tearsNum

					local ChocolateDamageMultiplier = player.Damage
					if player:HasCollectible(CollectibleType.COLLECTIBLE_CHOCOLATE_MILK) then
						ChocolateDamageMultiplier = player.Damage*(0.1 + chargeCounter * 0.04)--(min = 0.1 ; max = 4.0)
					end

					UnbiddenAura(player, auraPos, false, ChocolateDamageMultiplier)
				elseif data.UnbiddenFullCharge then
					if data.ObliviousDamageDelay == maxCharge then
						local tearsNum = GetMultiShotNum(player)
						data.MultipleAura = data.MultipleAura or 0
						if player:HasCollectible(CollectibleType.COLLECTIBLE_MONSTROS_LUNG) then
							data.MultipleAura = data.MultipleAura + 14 + tearsNum
						end

						UnbiddenAura(player, auraPos)
					else
						data.ObliviousDamageDelay = 0
					end
				--else -- DO NOT TOUCH... checking it inside UnbiddenAura function (there it stops MultipleAura from charging)
				--  data.ObliviousDamageDelay = 0
				elseif data.ludo or player:HasCollectible(CollectibleType.COLLECTIBLE_EYE_OF_THE_OCCULT) then
					if data.ObliviousDamageDelay >= maxCharge then

						local tearsNum = GetMultiShotNum(player)
						data.MultipleAura = data.MultipleAura or 0
						data.MultipleAura = data.MultipleAura + tearsNum
						UnbiddenAura(player, auraPos)

					end
				end
			--if shooting
			elseif player:GetFireDirection() ~= -1 or data.ludo then
				--print('a')
				if player:HasCollectible(CollectibleType.COLLECTIBLE_TECH_5) and data.ObliviousDamageDelay >= maxCharge then --data.BlindUnbidden
					TechDot5Shot(player)
				end
				-- if player has monstro's lung charge attack
				if data.UnbiddenFullCharge or data.UnbiddenSemiCharge then

					if data.ObliviousDamageDelay < maxCharge then
						data.ObliviousDamageDelay = data.ObliviousDamageDelay + 1
					elseif data.ObliviousDamageDelay == maxCharge then
						if game:GetFrameCount() % 6 == 0 then
							player:SetColor(Color(1,1,1,1, 0.2, 0.2, 0.5), 2, 1, true, false)
						end
					end
				else
					-- normal aura + multiply attacks
					if data.ObliviousDamageDelay >= maxCharge then

						local tearsNum = GetMultiShotNum(player)
						data.MultipleAura = data.MultipleAura or 0
						data.MultipleAura = data.MultipleAura + tearsNum
						UnbiddenAura(player, auraPos)

					end
				end

				--ludovico tech (create controllable tear, which auto-creates aura)
				if player:HasCollectible(CollectibleType.COLLECTIBLE_LUDOVICO_TECHNIQUE) then
					data.ludo = true

				end

				-- GodHead (ceate aura around you while shoot pressed)
				if player:HasCollectible(CollectibleType.COLLECTIBLE_GODHEAD) then
					GodHeadAura(player)
				end

				-- Tech 2 (ceate laser circle around you while shoot pressed)
				if player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY_2) and not data.HasTech2Laser then
					Technology2Aura(player)
				end

			end
		end

		if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) and level:GetCurses() > 0 then
			level:RemoveCurses(level:GetCurses())
		end

		if data.NoAnimReset then
			player:AnimateTeleport(false)
			data.NoAnimReset = data.NoAnimReset - 1
			if data.NoAnimReset == 0 then
				if not player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
					--AddItemFromWisp(player, false, true, false)
					local pocketCharge = player:GetActiveCharge(2)
					--local pocketBatterCharge = player:GetBatteryCharge(2)
					if pocketCharge > 0 then
						player:SetActiveCharge(0, 2)
					end
				end
				data.NoAnimReset = nil
			end
		end


	--[[
	else
		if data.ObliviousCostumeEquipped then
			player:TryRemoveNullCostume(mod.ObliviousData.CostumeHead)
			data.ObliviousCostumeEquipped = false
			if player:HasCollectible(mod.Items.Threshold) then player:RemoveCollectible(mod.Items.Threshold) end
		end
	--]]
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.onPEffectUpdate3)

function mod:onUpdate2()
	--- Unbidden time rewind ability. don't trigger if you have more than 11 broken hearts a
	for playerNum = 0, game:GetNumPlayers()-1 do
		local player = game:GetPlayer(playerNum):ToPlayer()
		local data = player:GetData()
		if player:GetPlayerType() == mod.Characters.Oblivious and not player:HasCollectible(mod.Items.Threshold) and player:CanAddCollectible(mod.Items.Threshold) and not player:HasCurseMistEffect() and not player:IsCoopGhost() then
			player:SetPocketActiveItem(mod.Items.Threshold, ActiveSlot.SLOT_POCKET, false)
		end

		if player:IsDead() and not player:HasTrinket(mod.Trinkets.WitchPaper) and player:GetBrokenHearts() < 11 then
			if player:GetPlayerType() == mod.Characters.Unbidden or player:GetPlayerType() == mod.Characters.Oblivious then
				player:UseActiveItem(CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS, myUseFlags)
				--Isaac.ExecuteCommand("rewind") -- it works but there isn't any effects
				data.NoAnimReset = 2
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.onUpdate2)

function mod:onInputAction(entity, _, buttonAction) -- entity, inputHook, buttonAction
	--- Disable bomb placing ability for Nadab & Abihu
	if entity and entity.Type == EntityType.ENTITY_PLAYER and not entity:IsDead() then
		local player = entity:ToPlayer()
		if (player:GetPlayerType() == mod.Characters.Nadab or player:GetPlayerType() == mod.Characters.Abihu) and buttonAction == ButtonAction.ACTION_BOMB then
			return false
		end
	end
end
mod:AddCallback(ModCallbacks.MC_INPUT_ACTION, mod.onInputAction)

function mod:onPlayerInit(player)
	--- mod chars Init
	local data = player:GetData()
	--local idx = getPlayerIndex(player)

	if player:GetPlayerType() == mod.Characters.Nadab then -- nadab
		data.NadabCostumeEquipped = true
		player:AddNullCostume(mod.NadabData.CostumeHead)
		if not player:HasCollectible(mod.Items.AbihuFam) then player:AddCollectible(mod.Items.AbihuFam, 0, true) end
	else
		if data.NadabCostumeEquipped then
			player:TryRemoveNullCostume(mod.NadabData.CostumeHead)
			data.NadabCostumeEquipped = nil
			if player:HasCollectible(mod.Items.AbihuFam) then player:RemoveCollectible(mod.Items.AbihuFam) end
		end
	end

	if player:GetPlayerType() == mod.Characters.Abihu then -- nadab
		data.BlindAbihu = true
		SetBlindfold(player, true)
		--data.AbihuCostumeEquipped = true
		--player:AddNullCostume(mod.AbihuData.CostumeHead)
		if not player:HasCollectible(mod.Items.NadabBody) then player:AddCollectible(mod.Items.NadabBody) end
	else
		if data.BlindAbihu then
			data.BlindAbihu = nil
			SetBlindfold(player, false)
		end
		if data.AbihuCostumeEquipped then
			player:TryRemoveNullCostume(mod.AbihuData.CostumeHead)
			data.AbihuCostumeEquipped = nil
			if player:HasCollectible(mod.Items.NadabBody) then player:RemoveCollectible(mod.Items.NadabBody) end
		end
	end

	if player:GetPlayerType() == mod.Characters.Oblivious then
		data.ObliviousCostumeEquipped = true
		--player:AddNullCostume(mod.ObliviousData.CostumeHead)
		data.BlindUnbidden = true
		SetBlindfold(player, true)

		--if not player:HasCollectible(mod.Items.Threshold) then
			--player:AddCollectible(mod.Items.Threshold, 6, false)
			--player:SetPocketActiveItem(mod.Items.Threshold, ActiveSlot.SLOT_POCKET, false)
		--end

		--player:AddCostume(Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_GLITTER_BOMBS))
	else
		if data.BlindUnbidden then
			data.BlindUnbidden = nil
			SetBlindfold(player, false)
			if player:HasCollectible(mod.Items.Threshold) then player:RemoveCollectible(mod.Items.Threshold) end
		end
		if data.ObliviousCostumeEquipped then
			--player:TryRemoveNullCostume(mod.ObliviousData.CostumeHead)
			data.ObliviousCostumeEquipped = nil
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.onPlayerInit)

function mod:onCache4(player, cacheFlag)
	--- char stats
	player = player:ToPlayer()
	--local data = player:GetData()
	if player:GetPlayerType() == mod.Characters.Nadab then
		if cacheFlag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * mod.NadabData.Stats.DAMAGE
			if player:HasCollectible(CollectibleType.COLLECTIBLE_MR_MEGA) then
				player.Damage = player.Damage + player.Damage * mod.NadabData.MrMegaDmgMultiplier
			end
		end
		if cacheFlag == CacheFlag.CACHE_FIREDELAY and player:HasCollectible(CollectibleType.COLLECTIBLE_SAD_BOMBS) then
			player.MaxFireDelay = player.MaxFireDelay + mod.NadabData.SadBombsFiredelay
		end
		if cacheFlag == CacheFlag.CACHE_SPEED then
			player.MoveSpeed = player.MoveSpeed + mod.NadabData.Stats.SPEED
			if player:HasCollectible(CollectibleType.COLLECTIBLE_FAST_BOMBS) and player.MoveSpeed < 1.0 then
				player.MoveSpeed = 1.0
			end
		end
		if cacheFlag == CacheFlag.CACHE_TEARFLAG and player:HasCollectible(CollectibleType.COLLECTIBLE_BOBBY_BOMB) then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_HOMING
		end
	end

	if player:GetPlayerType() == mod.Characters.Abihu then
		if cacheFlag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * mod.AbihuData.Stats.DAMAGE
		end
		if cacheFlag == CacheFlag.CACHE_SPEED then
			player.MoveSpeed = player.MoveSpeed + mod.AbihuData.Stats.SPEED
		end
	end

	if player:GetPlayerType() == mod.Characters.Unbidden then
		if cacheFlag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * mod.UnbiddenData.Stats.DAMAGE
		end
		if cacheFlag == CacheFlag.CACHE_LUCK then
			player.Luck = player.Luck + mod.UnbiddenData.Stats.LUCK
		end
		if cacheFlag == CacheFlag.CACHE_TEARCOLOR then
			player.TearColor = mod.ObliviousData.Stats.TEAR_COLOR --Color(0.5,1,2,1,0,0,0)
			player.LaserColor =  mod.ObliviousData.Stats.LASER_COLOR
		end
	end

	if player:GetPlayerType() == mod.Characters.Oblivious then
		if cacheFlag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * mod.ObliviousData.Stats.DAMAGE
		end
		if cacheFlag == CacheFlag.CACHE_LUCK then
			player.Luck = player.Luck + mod.ObliviousData.Stats.LUCK
		end
		if cacheFlag == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | mod.ObliviousData.Stats.TRAR_FLAG

		end
		if cacheFlag == CacheFlag.CACHE_TEARCOLOR then
			player.TearColor = mod.ObliviousData.Stats.TEAR_COLOR --Color(0.5,1,2,1,0,0,0)
			player.LaserColor =  mod.ObliviousData.Stats.LASER_COLOR
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.onCache4)

function mod:OnDetonatorUse(_,_, player) --item, rng, player
	---Nadab
	local data = player:GetData()
	if player:GetPlayerType() == mod.Characters.Nadab then
		data.ExCountdown = data.ExCountdown or 0
		if data.ExCountdown == 0 then
			data.ExCountdown = mod.NadabData.ExplosionCountdown
			FcukingBomberman(player)
		end
	end
	---Nadab's Body
	if player:HasCollectible(mod.Items.NadabBody) then
		data.ExCountdown = data.ExCountdown or 0
		if data.ExCountdown == 0 then
			data.ExCountdown = mod.NadabData.ExplosionCountdown
			local bodies = Isaac.FindByType(EntityType.ENTITY_BOMB, BombVariant.BOMB_DECOY)
			for _, body in pairs(bodies) do
				if body:GetData().bomby then
					FcukingBomberbody(player)
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.OnDetonatorUse, CollectibleType.COLLECTIBLE_REMOTE_DETONATOR)

function mod:use2ofClubs(_, player) -- card, player
	--- Nadab & Abihu replace 2ofClubs effect by 2ofHearts
	if player:GetPlayerType() == mod.Characters.Nadab or player:GetPlayerType() == mod.Characters.Abihu then
		player:AddBombs(-2)
		player:UseCard(Card.CARD_HEARTS_2, myUseFlags)
	end
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.use2ofClubs, Card.CARD_CLUBS_2)

function mod:onBombsAreKey(_, player) -- pill, player
	--- Nadab & Abihu BombsAreKeys pill effect shifts hearts and keys
	if player:GetPlayerType() == mod.Characters.Nadab or player:GetPlayerType() == mod.Characters.Abihu then
		local player_keys = player:GetNumKeys()
		local player_hearts = player:GetHearts()
		player:AddHearts(player_keys-player_hearts)
        player:AddKeys(player_hearts-player_keys)
	end
end
mod:AddCallback(ModCallbacks.MC_USE_PILL, mod.onBombsAreKey, PillEffect.PILLEFFECT_BOMBS_ARE_KEYS)

--- Threshold
function mod:onThreshold(_, _, player) --item, rng, player, useFlag, activeSlot, customVarData
	--- unbidden personal item: add item wisp
	--player:UseCard(Card.RUNE_BLACK, myUseFlags)
	local wisp = AddItemFromWisp(player, true, true, true)  --priority on a top left wisp (seemingly)
	if wisp then
		player:AnimateCollectible(wisp)
		return false
	end
	return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.onThreshold, mod.Items.Threshold)

function mod:onItemCollision2(pickup, collider, _) --add --PickupVariant.PICKUP_SHOPITEM
	--- unbidden item collision
	local level = game:GetLevel()
	local room = game:GetRoom()
	if collider:ToPlayer() and GetCurrentDimension() ~= 2 and level:GetCurrentRoomIndex() ~= GridRooms.ROOM_GENESIS_IDX and room:GetType() ~= RoomType.ROOM_CHALLENGE and room:GetType() ~= RoomType.ROOM_BOSSRUSH then --
		local player = collider:ToPlayer()
		if player:GetPlayerType() == mod.Characters.Unbidden or player:GetPlayerType() == mod.Characters.Oblivious then
			local wispIt = true
			if pickup:IsShopItem() then
				if pickup.Price >= 0 then
					if player:GetNumCoins() >= pickup.Price then
						--wispIt = true
						player:AddCoins(-pickup.Price)
					else
						wispIt = false
					end
				else
					if player:GetPlayerType() == mod.Characters.Unbidden and pickup.Price > -5 then
						if player:GetSoulHearts()/2 > 3 then
							player:AddSoulHearts(-6)
						else
							player:AddSoulHearts(1-player:GetSoulHearts())
							player:AddBrokenHearts(1)
						end
					end
				end
			end

			if wispIt then
				if CheckItemTags(pickup.SubType, ItemConfig.TAG_QUEST) or pickup.SubType == 0 or pickup.SubType == CollectibleType.COLLECTIBLE_BIRTHRIGHT or pickup.SubType == CollectibleType.COLLECTIBLE_DEATH_CERTIFICATE then
					return
				else
					pickup:Remove()
					player:AddItemWisp(pickup.SubType, pickup.Position):ToFamiliar()
					--local wispy = player:AddItemWisp(pickup.SubType, pickup.Position):ToFamiliar()
					--wispy.Color = mod.OblivionCard.PoofColor
					--wispy.SplatColor = mod.OblivionCard.PoofColor
					--pickup.SubType = 0
					sfx:Play(579)
					return true
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.onItemCollision2, PickupVariant.PICKUP_COLLECTIBLE)

function mod:onHeartCollision2(pickup, collider, _)
	--- unbidden collision with hearts, if he has bone hearts
	if collider:ToPlayer() and collider:ToPlayer():GetPlayerType() == mod.Characters.Unbidden and (pickup.SubType == 1 or pickup.SubType == 2 or pickup.SubType == 5 or pickup.SubType == 9 or pickup.SubType == 10 or pickup.SubType == 12) then
		local player = collider:ToPlayer()
		if pickup.SubType == 10 then
			if player:GetBoneHearts() > 0 then
				player:AddSoulHearts(2)
			end
			return nil
		end
		if player:HasTrinket(TrinketType.TRINKET_APPLE_OF_SODOM) then -- and player:GetBoneHearts() == 0 then
			return nil
		end
		return false
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.onHeartCollision2, PickupVariant.PICKUP_HEART)

-- chars charge bar render
local function RenderChargeManager(player, chargeData, chargeSprite, chargeInitDelay)
	local pos = Isaac.WorldToScreen(player.Position)
	--please dear modders use SpriteScale)
	local vecX = pos.X + (player.SpriteScale.X * 12)
	local vecY = pos.Y - (player.SpriteScale.Y * 38)
	pos = Vector(vecX, vecY)

	if chargeSprite:IsFinished("Disappear") and player:GetFireDirection() ~= -1 then
		chargeSprite:SetFrame("Charging", 0)
	end

	if chargeData > 0 then
		local chargeCounter = math.floor((chargeData * 100) / (chargeInitDelay + math.floor(player.MaxFireDelay))) -- %100
		chargeSprite:Render(pos)
		if chargeCounter < 100 then
			chargeSprite:SetFrame("Charging", chargeCounter)
		elseif chargeCounter == 100 then
			if chargeSprite:GetAnimation() == "Charging" then
				chargeSprite:Play("StartCharged")
			elseif chargeSprite:IsFinished("StartCharged") then
				chargeSprite:Play("Charged")
			end
		end
		chargeSprite:Update()
	else
		if chargeSprite:IsPlaying("Disappear") then
			chargeSprite:Render(pos)
			chargeSprite:Update()
		else
			chargeSprite:Render(pos)
			chargeSprite:Play("Disappear")
			chargeSprite:Update()
		end
	end
end

-- render chars charge bars
function mod:onPlayerRender(player) --renderOffset
	--- render abihu and unbidden charge bar
	local data = player:GetData()
	--local isAlive = (player:GetHearts() ~= 0 or player:GetSoulHearts() ~= 0)
	if Options.ChargeBars and not player:IsDead() then
		if player:GetPlayerType() == mod.Characters.Oblivious and (data.UnbiddenFullCharge or data.UnbiddenSemiCharge) and data.BlindUnbidden and not data.HoldingWeapon then -- and not data.TechLudo
			RenderChargeManager(player, data.ObliviousDamageDelay, mod.ObliviousData.ChargeBar, mod.ObliviousData.DamageDelay)
		elseif player:GetPlayerType() == mod.Characters.Abihu and (player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) or data.AbihuIgnites) then
			RenderChargeManager(player, data.AbihuDamageDelay, mod.AbihuData.ChargeBar, mod.AbihuData.DamageDelay)
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_RENDER, mod.onPlayerRender)

function mod:onPlayerTakeDamage(entity, _, flags) --entity, amount, flags, source, countdown
	--- abihu drops nadab when you take damage, so set holding to -1
	local player = entity:ToPlayer()
	if player:GetPlayerType() == mod.Characters.Nadab and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) and (flags & DamageFlag.DAMAGE_EXPLOSION == DamageFlag.DAMAGE_EXPLOSION or flags & DamageFlag.DAMAGE_TNT == DamageFlag.DAMAGE_TNT) then
		return false
	end
	if player:GetPlayerType() == mod.Characters.Abihu then
		if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) and flags & DamageFlag.DAMAGE_FIRE == DamageFlag.DAMAGE_FIRE then
			return false
		end
		local data = entity:GetData()
		data.AbihuIgnites = true
		if not data.AbihuCostumeEquipped then
			data.AbihuCostumeEquipped = true
			player:AddNullCostume(mod.AbihuData.CostumeHead)
		end
		data.HoldBomd = -1
	end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.onPlayerTakeDamage, EntityType.ENTITY_PLAYER)

function mod:onItemUse(_, _, player) --item, rng, player, useFlag, activeSlot, customVarData
	--- abihu drops nadab when you use item, so set holding to -1
	if player:GetPlayerType() == mod.Characters.Abihu then
		local data = player:GetData()
		data.HoldBomd = -1
	end
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.onItemUse)

--- WIP
function mod:onAbihuFlame(flame)
	if flame:GetData().AbihuFlame and flame.Parent then
		local flameData = flame:GetData()
		local player = flame.Parent:ToPlayer()
		local tearFlags = player.TearFlags
		if flame.FrameCount == 1 then
			if tearFlags & TearFlags.TEAR_POISON == TearFlags.TEAR_POISON or player:HasCollectible(CollectibleType.COLLECTIBLE_COMMON_COLD) then
				flame.Color = Color(0, 1, 0, 1)
				flameData.Poison = flameData.Poison or true
			end
			if tearFlags & TearFlags.TEAR_SLOW == TearFlags.TEAR_SLOW then
				flame.Color = Color(2,2,2,1,0.196,0.196,0.196)
				flameData.Slow = flameData.Slow or true
			end
			if tearFlags & TearFlags.TEAR_MIDAS == TearFlags.TEAR_MIDAS then
				flame.Color = Color(2, 1, 0, 1)
				flameData.Midas = flameData.Midas or true
			end
			if tearFlags & TearFlags.TEAR_FEAR == TearFlags.TEAR_FEAR then
				flame.Color = Color(0.2, 0.09, 0.06, 1, 0, 0, 0)
				flameData.Fear = flameData.Fear or true
			end
			if tearFlags & TearFlags.TEAR_CHARM == TearFlags.TEAR_CHARM then
				flame.Color = Color(1, 0, 1, 1, 0.196, 0, 0)
				flameData.charm = flameData.charm or true
			end
			if tearFlags & TearFlags.TEAR_CONFUSION == TearFlags.TEAR_CONFUSION then
				flame.Color = Color(0.5, 0.5, 0.5, 1, 0, 0, 0)
				flameData.confusion = flameData.confusion or true
			end
			if tearFlags & TearFlags.TEAR_FREEZE == TearFlags.TEAR_FREEZE or player:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_CONTACTS) then
				flame.Color = Color(0, 0, 0, 1, 0.5, 0.5, 0.5)
				flameData.Freeze = flameData.Freeze or true
			end

			if tearFlags & TearFlags.TEAR_BOOMERANG == TearFlags.TEAR_BOOMERANG then
				flameData.boomerang = flameData.boomerang or true
			end
			if tearFlags & TearFlags.TEAR_MULLIGAN == TearFlags.TEAR_MULLIGAN then
				flameData.mulligan = flameData.mulligan or true
			end
			if tearFlags & TearFlags.TEAR_WAIT == TearFlags.TEAR_WAIT then
				flameData.wait = flameData.wait or true
			end

			if tearFlags & TearFlags.TEAR_SPLIT == TearFlags.TEAR_SPLIT then
				flame.Color = Color(0.9, 0.3, 0.08, 1)
				flameData.split = flameData.split or true
			end
			if tearFlags & TearFlags.TEAR_QUADSPLIT == TearFlags.TEAR_QUADSPLIT then
				flameData.quadsplit = flameData.quadsplit or true
			end
			if tearFlags & TearFlags.TEAR_HOMING == TearFlags.TEAR_HOMING then
				flame.Color = Color(0.4, 0.15, 0.38, 1, 0.27843, 0, 0.4549)
				flameData.homing = flameData.homing or true
			end
		end

		if flameData.homing then
			local nearestNPC = GetNearestEnemy(flame.Position, 120)
			flame:AddVelocity((nearestNPC - flame.Position):Resized(1))
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, mod.onAbihuFlame, EffectVariant.BLUE_FLAME)

function mod:onAbihuFlameDamage(entity, _, _, source, _)
	if entity:IsVulnerableEnemy() and entity:IsActiveEnemy() and source.Entity and source.Entity:ToEffect() then
		local flame = source.Entity:ToEffect()
		if flame.Variant == EffectVariant.BLUE_FLAME and flame:GetData().AbihuFlame then
			local ppl = flame.Parent:ToPlayer()
			local flameData = flame:GetData()
			if flameData.Poison then entity:AddPoison(EntityRef(ppl), 52, ppl.Damage) end
			if flameData.Freeze then entity:AddFreeze(EntityRef(ppl), 52) end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.onAbihuFlameDamage)
--- WIP

--[[
function mod:onTestEffect(effect)
end
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, mod.onTestEffect, EffectVariant.BLUE_FLAME)
--]]

--[[
function mod:onRender()
	if debug then
		Isaac.RenderText(renderText, 50, 30, 1, 1, 1, 255)
	end
end
mod:AddCallback(ModCallbacks.MC_POST_RENDER, mod.onRender)
--]]

do
-- bomb gagger
--mod.Items.Gagger = Isaac.GetItemIdByName("Little Gagger")

--[[
mod.Gagger = {}
mod.Gagger.Variant = Isaac.GetEntityVariantByName("lilGagger") -- shoot bomb tears, chance to generate giga bomb after clearing room
mod.Gagger.GenChance = 0.10 -- overall chance
mod.Gagger.ChanceUp = 0.1
]]

--[[
--Gagger
function mod:onGaggerInit(fam)
	fam:GetSprite():Play("FloatDown")
	fam:GetData().GenPickup = false
	fam:GetData().GenChanceUp = 0
	fam:AddToFollowers()
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, mod.onGaggerInit, mod.Gagger.Variant)
--Gagger loop update
function mod:onGaggerUpdate(fam)
	local player = fam.Player -- get player
	--local tempEffects = player:GetEffects()
	local famData = fam:GetData() -- get fam data
	local room = game:GetRoom()
	local famSprite = fam:GetSprite()
	CheckForParent(fam)
	fam:FollowParent()
	if not mod.PreRoomState and not famData.GenPickup and room:IsClear() then
		local rng = player:GetCollectibleRNG(mod.Items.Gagger)
		famData.GenPickup = true
		famData.GenChanceUp = famData.GenChanceUp or 0
		if rng:RandomFloat() < mod.Gagger.GenChance + famData.GenChanceUp then
			famData.GenChanceUp = 0
			famData.GenIndex = true
			famSprite:Play("Spawn")
		else
			famData.GenChanceUp = famData.GenChanceUp + mod.Gagger.ChanceUp
		end
	end
	if famSprite:IsFinished("Spawn") and famData.GenPickup then
		if famData.GenIndex then
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BOMB, BombSubType.BOMB_GIGA, fam.Position, Vector.Zero, fam)
			famSprite:Play("AfterSpawn")
			famData.GenIndex = nil
		end
	end
	if famSprite:IsFinished("AfterSpawn") then
		famSprite:Play("FloatDown") --"AfterSpawn"
	end
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, mod.onGaggerUpdate, mod.Gagger.Variant)
--]]

--[[
function mod:onCache3(player, cacheFlag)
	player = player:ToPlayer()
	-- bombgagger
	--[[
	if cacheFlag == CacheFlag.CACHE_FAMILIARS then
		local gaggers = GetItemsCount(player, mod.Items.Gagger)
		player:CheckFamiliar(mod.Gagger.Variant, gaggers, player:GetCollectibleRNG(mod.Items.Gagger), Isaac.GetItemConfig():GetCollectible(mod.Items.Gagger))
	end
	--]
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.onCache3)
]]
end

do
--[[
do
mod.UnlockText = {}
mod.UnlockText.Nadab = {"Unlocked Compo Bombs","Unlocked Gravity Bombs", -- 1:Isaac 2:BlueBaby
                        "Unlocked Glass Bombs","Unlocked Ice Cube Bombs", -- 3:Satan, 4:Lamb
                        "Unlocked Red Button","Unlocked Chess Kings", -- 5:BossRush, 6:Hush
                        "...","Unlocked Mongo Cells", -- 7:MegaSatan, 8:Delirium
                        "Unlocked Bob's Tongue","Unlocked Lil Gagger", -- 9:Mother, 10:Beast
                        "Unlocked Moonlighter","...", -- 11:Greed, 12:Heart
                        "...","Unlocked Charon's Obol"} -- 13:AllMarksHard, 14:Greedier
mod.UnlockText.Abihu = {"Unlocked Red Scissors","...", -- 1:Isaac 2:BlueBaby
                        "...","...", -- 3:Satan, 4:Lamb
                        "Unlocked Soul of Nadab and Abihu","...", -- 5:BossRush, 6:Hush
                        "Unlocked Wax Hearts","Unlocked Nadab's Brain", -- 7:MegaSatan, 8:Delirium
                        "Unlocked Melted Candle","Unlocked Ivory Oil", -- 9:Mother, 10:Beast
                        "...","...",-- 11:Greed, 12:Heart
                        "Unlocked Eye Key","Unlocked Slay the Spire cards", -- 13:AllMarksHard, 14:Greedier
						true} -- tainted
mod.UnlockText.Unbidden = {"Unlocked Karma Level","Unlocked VHS Cassette",-- 1:Isaac 2:BlueBaby
                        "Unlocked Long Elk","Unlocked Duckling", -- 3:Satan, 4:Lamb
                        "Unlocked Apocalypse Card","Unlocked Chess Knights", -- 5:BossRush, 6:Hush
                        "...","Unlocked Red Lotus", -- 7:MegaSatan, 8:Delirium
                        "Unlocked Red Mirror","Unlocked Limbus", -- 9:Mother, 10:Beast
                        "Unlocked Curse of the Midas","...",-- 11:Greed, 12:Heart
                        "...","Unlocked Lililith"} -- 13:AllMarksHard, 14:Greedier
mod.UnlockText.Oblivious = {"Unlocked Witch Paper","...",-- 1:Isaac 2:BlueBaby
                        "...","...", -- 3:Satan, 4:Lamb
                        "Unlocked Soul of Unbidden","...", -- 5:BossRush, 6:Hush
                        "Unlocked Duotine and Red Pills","Unlocked Eclipse", -- 7:MegaSatan, 8:Delirium
                        "Unlocked Trapezohedron","Unlocked Red Bag", -- 9:Mother, 10:Beast
                        "...","...",-- 11:Greed, 12:Heart
                        "Unlocked Floppy Disk","Unlocked Oblivion Card", -- 13:AllMarksHard, 14:Greedier
						true} -- tainted
end

local function HasFullCompletion(marks)
	for i=1, #marks-1 do
		if marks[i] ~= 2 then
			return false
		end
	end
	return true
end

local function CompletionMarkUnlock(completionTable, markIndex, textTable)
	if textTable[15] then
		if game.Difficulty == Difficulty.DIFFICULTY_HARD or game.Difficulty == Difficulty.DIFFICULTY_GREEDIER then
			completionTable[markIndex] = 2
		else
			completionTable[markIndex] = 1
		end
		--if debug then
			if markIndex == 1 or markIndex == 2 or markIndex == 3 or markIndex == 4 then
				if completionTable[1] > 0 and completionTable[2] > 0 and completionTable[3] > 0 and completionTable[4] > 0 then
					game:GetHUD():ShowFortuneText(textTable[1])
				end
			elseif markIndex == 5 or markIndex == 6 then
				if completionTable[5] > 0 and completionTable[6] > 0  then
					game:GetHUD():ShowFortuneText(textTable[5])
				end
			elseif markIndex == 11 and completionTable[markIndex] > 1 then
				game:GetHUD():ShowFortuneText(textTable[14])
			else
				game:GetHUD():ShowFortuneText(textTable[markIndex])
			end
		--end
	else
		if game.Difficulty == Difficulty.DIFFICULTY_HARD or game.Difficulty == Difficulty.DIFFICULTY_GREEDIER then
			--if debug then
				if markIndex == 11 then
					if completionTable[markIndex] < 1 then
						game:GetHUD():ShowFortuneText(textTable[14])
					else
						game:GetHUD():ShowFortuneText(textTable[markIndex], textTable[14])
					end
				else
					game:GetHUD():ShowFortuneText(textTable[markIndex])
				end
			--end
			completionTable[markIndex] = 2
		else
			--if debug then
				game:GetHUD():ShowFortuneText(textTable[markIndex])
			--end
			completionTable[markIndex] = 1
		end
	end
	modDataSave()
end

local function CheckCompletionRoomClear(completionTable, textTable)
	local level = game:GetLevel()
	if game:GetStateFlag(GameStateFlag.STATE_BOSSRUSH_DONE) and completionTable[5] < 2 then --BossRush
		CompletionMarkUnlock(completionTable, 5, textTable)
	elseif game:GetStateFlag(GameStateFlag.STATE_BLUEWOMB_DONE) and completionTable[6] < 2 then --Hush
		CompletionMarkUnlock(completionTable, 6, textTable)
	elseif game:IsGreedMode() and level:GetStage() == LevelStage.STAGE7_GREED and game:GetRoom():GetRoomShape() == RoomShape.ROOMSHAPE_1x2 and completionTable[11] < 2 then --Greed/Greedier
		CompletionMarkUnlock(completionTable, 11, textTable)
	end
	if completionTable[13] < 2 and HasFullCompletion(completionTable) then --AllMarksHard
		completionTable[13] = 2
		--if debug then
			game:GetHUD():ShowFortuneText(textTable[13])
		--end
	end
end

local function CheckCompletionBossKill(completionTable, npc, textTable)
	local level = game:GetLevel()

	if level:GetStage() == LevelStage.STAGE5 then
		if npc.Type == EntityType.ENTITY_ISAAC and completionTable[1] < 2 then --Isaac
			CompletionMarkUnlock(completionTable, 1, textTable)
		end
		if npc.Type == EntityType.ENTITY_SATAN and completionTable[3] < 2 then --Satan
			CompletionMarkUnlock(completionTable, 3, textTable)
		end
	elseif level:GetStage() == LevelStage.STAGE6 then
		if npc.Type == EntityType.ENTITY_ISAAC and completionTable[2] < 2 then --BlueBaby
			CompletionMarkUnlock(completionTable, 2, textTable)
		end
		if npc.Type == EntityType.ENTITY_THE_LAMB and completionTable[4] < 2 then --Lamb
			CompletionMarkUnlock(completionTable, 4, textTable)
		end
		if npc.Type == EntityType.ENTITY_MEGA_SATAN_2 and completionTable[7] < 2 then --MegaSatan
			CompletionMarkUnlock(completionTable, 7, textTable)
		end
	elseif level:GetStage() == LevelStage.STAGE7 and npc.Type == EntityType.ENTITY_DELIRIUM and completionTable[8] < 2 then --Delirium
		CompletionMarkUnlock(completionTable, 8, textTable)
	elseif (level:GetStage() == LevelStage.STAGE4_2 or level:GetStage() == LevelStage.STAGE3_2) and npc.Type == EntityType.ENTITY_MOMS_HEART and completionTable[12] < 2 then --Heart
		CompletionMarkUnlock(completionTable, 12, textTable)
	elseif level:GetStage() == LevelStage.STAGE4_2 and npc.Type == EntityType.ENTITY_MOTHER and npc.Variant == 10 and completionTable[9] < 2 then --Mother
		CompletionMarkUnlock(completionTable, 9, textTable)
	elseif level:GetStage() == LevelStage.STAGE8 and npc.Type == EntityType.ENTITY_BEAST and npc.Variant == 0 and completionTable[10] < 2 then --Beast
		CompletionMarkUnlock(completionTable, 10, textTable)
	end
	if completionTable[13] < 2 and HasFullCompletion(completionTable) then --AllMarksHard
		completionTable[13] = 2
		--if debug then
			game:GetHUD():ShowFortuneText(textTable[13])
		--end
	end
end

function mod:onPostPickupInit2(pickup)
	--- remove items from item pool (morphing time)
	local room = game:GetRoom()
	--1:Isaac, 2:BlueBaby, 3:Satan, 4:Lamb, 5:BossRush, 6:Hush, 7:MegaSatan, 8:Delirium, 9:Mother, 10:Beast, 11:Greed/Greedier, 12:Heart, 13:AllMarksHard
	--if (mod.NadabData.CompletionMarks[13] < 2 or mod.AbihuData.CompletionMarks[13] < 2 or mod.UnbiddenData.CompletionMarks[13] < 2 or mod.ObliviousData.CompletionMarks[13] < 2) then
	if savetable == {} then modDataLoad() end
	if (savetable.NadabCompletionMarks[13] < 2 or savetable.AbihuCompletionMarks[13] < 2 or savetable.UnbiddenCompletionMarks[13] < 2 or savetable.ObliviousCompletionMarks[13] < 2) then
		local newSub = pickup.SubType
		if pickup.Variant == PickupVariant.PICKUP_COLLECTIBLE then
			if (pickup.SubType == mod.Items.CompoBombs and savetable.NadabCompletionMarks[1] == 0) or
					(pickup.SubType == mod.Items.GravityBombs and savetable.NadabCompletionMarks[2] == 0) or
					(pickup.SubType == mod.Items.MirrorBombs and savetable.NadabCompletionMarks[3] == 0) or
					(pickup.SubType == mod.Items.FrostyBombs and savetable.NadabCompletionMarks[4] == 0) or
					(pickup.SubType == mod.Items.RedButton and savetable.NadabCompletionMarks[5] == 0) or
					(pickup.SubType == mod.Items.MongoCells and savetable.NadabCompletionMarks[8] == 0) or
					--(pickup.SubType == mod.Items.lilGagger and savetable.NadabCompletionMarks[10] == 0) or
					(pickup.SubType == mod.Items.KeeperMirror and savetable.NadabCompletionMarks[11] < 1) or
					(pickup.SubType == mod.Items.CharonObol and savetable.NadabCompletionMarks[11] < 2) or

					(pickup.SubType == mod.Items.NadabBrain and savetable.AbihuCompletionMarks[8] == 0) or
					(pickup.SubType == mod.Items.MeltedCandle and savetable.AbihuCompletionMarks[9] == 0) or
					(pickup.SubType == mod.Items.IvoryOil and savetable.AbihuCompletionMarks[10] == 0) or
					--((pickup.SubType == mod.Items.EyeKeye or pickup.SubType == mod.Items.EyeKeyeSleep) and savetable.AbihuCompletionMarks[13] == 0) or

					(pickup.SubType == mod.Items.VoidKarma and savetable.UnbiddenCompletionMarks[1] == 0) or
					(pickup.SubType == mod.Items.VHSCassette and savetable.UnbiddenCompletionMarks[2] == 0) or
					(pickup.SubType == mod.Items.LongElk and savetable.UnbiddenCompletionMarks[3] == 0) or
					(pickup.SubType == mod.Items.RubberDuck and savetable.UnbiddenCompletionMarks[4] == 0) or
					((pickup.SubType == mod.Items.BlackKnight or pickup.SubType == mod.Items.WhiteKnight) and savetable.UnbiddenCompletionMarks[6] == 0) or
					(pickup.SubType == mod.Items.RedLotus and savetable.UnbiddenCompletionMarks[8] == 0) or
					(pickup.SubType == mod.Items.RedMirror and savetable.UnbiddenCompletionMarks[9] == 0) or
					(pickup.SubType == mod.Items.Limb and savetable.UnbiddenCompletionMarks[10] == 0) or
					(pickup.SubType == mod.Items.MidasCurse and savetable.UnbiddenCompletionMarks[11] < 1) or
					(pickup.SubType == mod.Items.Lililith and savetable.UnbiddenCompletionMarks[11] < 2) or

					--(pickup.SubType == mod.Items.Eclipse and savetable.ObliviousCompletionMarks[8] == 0) or
					(pickup.SubType == mod.Items.RedBag and savetable.ObliviousCompletionMarks[10] == 0) or
					((pickup.SubType == mod.Items.FloppyDisk or pickup.SubType == mod.Items.FloppyDiskFull) and savetable.ObliviousCompletionMarks[13] == 0) then
				local roomType = room:GetType()
				local seed = game:GetSeeds():GetStartSeed()
				local pool = itemPool:GetPoolForRoom(roomType, seed)
				if pool == ItemPoolType.POOL_NULL then
					pool = ItemPoolType.POOL_TREASURE
				end
				newSub = itemPool:GetCollectible(pool, true, pickup.InitSeed)
				--if newSub == pickup.SubType then newSub = 0 end
			elseif pickup.Variant == PickupVariant.PICKUP_TRINKET then
				if ((pickup.SubType == mod.Trinkets.BobTongue + TrinketType.TRINKET_GOLDEN_FLAG or pickup.SubType == mod.Trinkets.BobTongue) and savetable.NadabCompletionMarks[9] == 0) or
						((pickup.SubType == mod.Trinkets.RedScissors + TrinketType.TRINKET_GOLDEN_FLAG or pickup.SubType == mod.Trinkets.RedScissors) and
								savetable.AbihuCompletionMarks[1] == 0 and savetable.AbihuCompletionMarks[2] == 0 and savetable.AbihuCompletionMarks[3] == 0 and savetable.AbihuCompletionMarks[4] == 0) or
						((pickup.SubType == mod.Trinkets.WitchPaper + TrinketType.TRINKET_GOLDEN_FLAG or pickup.SubType == mod.Trinkets.WitchPaper) and
								savetable.ObliviousCompletionMarks[1] == 0 and savetable.ObliviousCompletionMarks[2] == 0 and savetable.ObliviousCompletionMarks[3] == 0 and savetable.ObliviousCompletionMarks[4] == 0) or
						((pickup.SubType == mod.Trinkets.Duotine + TrinketType.TRINKET_GOLDEN_FLAG or pickup.SubType == mod.Trinkets.Duotine) and savetable.ObliviousCompletionMarks[7] == 0) then
					newSub = itemPool:GetTrinket()
					--if newSub == pickup.SubType then newSub = 0 end
				end
			elseif pickup.Variant == PickupVariant.PICKUP_TAROTCARD then
				if ((pickup.SubType == mod.Pickups.KingChess or pickup.SubType == mod.Pickups.KingChessW) and savetable.NadabCompletionMarks[6] == 0) or
						(pickup.SubType == mod.Pickups.SoulNadabAbihu and savetable.AbihuCompletionMarks[5] == 0 and savetable.AbihuCompletionMarks[6] == 0) or
						((pickup.SubType == mod.Pickups.AscenderBane or pickup.SubType == mod.Pickups.Adrenaline or pickup.SubType == mod.Pickups.Fusion or
								pickup.SubType == mod.Pickups.MultiCast or pickup.SubType == mod.Pickups.InfiniteBlades or pickup.SubType == mod.Pickups.RitualDagger or
								pickup.SubType == mod.Pickups.Decay or pickup.SubType == mod.Pickups.Corruption or pickup.SubType == mod.Pickups.Wish or
								pickup.SubType == mod.Pickups.DeuxEx or pickup.SubType == mod.Pickups.Transmutation or pickup.SubType == mod.Pickups.Offering) and savetable.AbihuCompletionMarks[11] < 2) or
						(pickup.SubType == mod.Pickups.Apocalypse and savetable.UnbiddenCompletionMarks[5] == 0) or
						(pickup.SubType == mod.Pickups.SoulUnbidden and savetable.ObliviousCompletionMarks[5] == 0 and savetable.ObliviousCompletionMarks[6] == 0) or
						((pickup.SubType == mod.Pickups.RedPill or pickup.SubType == mod.Pickups.RedPillHorse) and savetable.ObliviousCompletionMarks[7] == 0) or
						(pickup.SubType == mod.Pickups.OblivionCard and savetable.ObliviousCompletionMarks[11] == 0) then
					newSub = itemPool:GetCard(pickup.InitSeed, false, true, true) -- Card.CARD_RULES
					--if newSub == pickup.SubType then newSub = 0 end
				end
				--[ wax hearts not implemented
				elseif pickup.Variant == PickupVariant.PICKUP_HEART then -- Wax Hearts
					if (pickup.SubType == mod.Pickups.WaxHearts and savetable.AbihuCompletionMarks[7] == 0) then
						newSub = 0
					end
				--]
			end
		end
		if newSub ~= pickup.SubType then
			pickup:Morph(pickup.Type, pickup.Variant, newSub, true, false, true)
			--else
			--	pickup:Morph(pickup.Type, pickup.Variant, 0, true, false, true)
		end
		modDataSave()
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, mod.onPostPickupInit2)

function mod:onNPCDeath2(npc)
	--- chars completion marks on npc (boss) killing
	if game:GetVictoryLap() == 0 then
		if savetable == {} then modDataLoad() end
		for playerNum = 0, game:GetNumPlayers()-1 do
			local player = game:GetPlayer(playerNum)
			if player:GetPlayerType() == mod.Characters.Nadab and savetable.NadabCompletionMarks[13] < 2 then
				CheckCompletionBossKill(savetable.NadabCompletionMarks, npc, mod.UnlockText.Nadab)
			end
			if player:GetPlayerType() == mod.Characters.Abihu and savetable.AbihuCompletionMarks[13] < 2 then
				CheckCompletionBossKill(savetable.AbihuCompletionMarks, npc, mod.UnlockText.Abihu)
			end
			if player:GetPlayerType() == mod.Characters.Unbidden and savetable.UnbiddenCompletionMarks[13] < 2 then
				CheckCompletionBossKill(savetable.UnbiddenCompletionMarks, npc, mod.UnlockText.Unbidden)
			end
			if player:GetPlayerType() == mod.Characters.Oblivious and savetable.ObliviousCompletionMarks[13] < 2 then
				CheckCompletionBossKill(savetable.ObliviousCompletionMarks, npc, mod.UnlockText.Oblivious)
			end
		end
		modDataSave()
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, mod.onNPCDeath2)

function mod:onRoomClear2()
	--- chars completion marks on clearing rooms
	local room = game:GetRoom()
	if game:GetVictoryLap() == 0 and room:GetType() == RoomType.ROOM_BOSS then
		if savetable == {} then modDataLoad() end
		for playerNum = 0, game:GetNumPlayers()-1 do
			local player = game:GetPlayer(playerNum)
			if player:GetPlayerType() == mod.Characters.Nadab and savetable.NadabCompletionMarks[13] < 2 then
				CheckCompletionRoomClear(savetable.NadabCompletionMarks, mod.UnlockText.Nadab)
			end
			if player:GetPlayerType() == mod.Characters.Abihu and savetable.AbihuCompletionMarks[13] < 2 then
				CheckCompletionRoomClear(savetable.AbihuCompletionMarks, mod.UnlockText.Abihu)
			end
			if player:GetPlayerType() == mod.Characters.Unbidden and savetable.UnbiddenCompletionMarks[13] < 2 then
				CheckCompletionRoomClear(savetable.UnbiddenCompletionMarks, mod.UnlockText.Unbidden)
			end
			if player:GetPlayerType() == mod.Characters.Oblivious and savetable.ObliviousCompletionMarks[13] < 2 then
				CheckCompletionRoomClear(savetable.ObliviousCompletionMarks, mod.UnlockText.Oblivious)
			end
		end
		modDataSave()
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, mod.onRoomClear2)
--]]
end

---EXECUTE COMMAND---
function mod:onExecuteCommand(command, args)
	--- console commands ---
	if command == "ocard" then
		if args == "help" or args == "" then
			print('ocard todo -> list of thing to complete/implement/change')
			--print('ocard reset [all, nadab, abihu, unbid, tunbid]')
			--print('ocard unlock [all, nadab, abihu, unbid, tunbid]')
		elseif args == "todo" then
			print('VVV costume flip, idk how')
			print('Lil Gagger sprite')
			print("finish Wax Hearts")
			print("finish curses UI")
			print("Abihu flame synergy")
			print("Mongo Cells effects full desc")
		elseif args == "debug" then
			if debug then
				debug = true
			else
				debug = false
			end
			print('debug:', debug)
		--[[
		elseif args == "reset" or args == "reset all" then
		    savetable.NadabCompletionMarks = {0,0,0,0,0,0,0,0,0,0,0,0,0}
			savetable.AbihuCompletionMarks = {0,0,0,0,0,0,0,0,0,0,0,0,0}
			savetable.UnbiddenCompletionMarks = {0,0,0,0,0,0,0,0,0,0,0,0,0}
			savetable.ObliviousCompletionMarks = {0,0,0,0,0,0,0,0,0,0,0,0,0}
			print("reset all")
		elseif args == "reset nadab" then
			savetable.NadabCompletionMarks = {0,0,0,0,0,0,0,0,0,0,0,0,0}
		    print("ok")
		elseif args == "reset abihu" then
			savetable.AbihuCompletionMarks = {0,0,0,0,0,0,0,0,0,0,0,0,0}
			print("ok")
		elseif args == "reset unbid" then
			savetable.UnbiddenCompletionMarks = {0,0,0,0,0,0,0,0,0,0,0,0,0}
			print("ok")
		elseif args == "reset tunbid" then
			savetable.ObliviousCompletionMarks = {0,0,0,0,0,0,0,0,0,0,0,0,0}
			print("ok")
		elseif args == "unlock" or args == "unlock all" then
			savetable.NadabCompletionMarks = {2,2,2,2,2,2,2,2,2,2,2,2,2}
			savetable.AbihuCompletionMarks = {2,2,2,2,2,2,2,2,2,2,2,2,2}
			savetable.UnbiddenCompletionMarks = {2,2,2,2,2,2,2,2,2,2,2,2,2}
			savetable.ObliviousCompletionMarks = {2,2,2,2,2,2,2,2,2,2,2,2,2}
		     print("unlocked all")
		elseif args == "unlock nadab" then
			savetable.NadabCompletionMarks = {2,2,2,2,2,2,2,2,2,2,2,2,2}
		    print("ok")
		elseif args == "unlock abihu" then
			savetable.AbihuCompletionMarks = {2,2,2,2,2,2,2,2,2,2,2,2,2}
			print("ok")
		elseif args == "unlock unbid" then
			savetable.UnbiddenCompletionMarks = {2,2,2,2,2,2,2,2,2,2,2,2,2}
			print("ok")
		elseif args == "unlock tunbid" then
			savetable.ObliviousCompletionMarks = {2,2,2,2,2,2,2,2,2,2,2,2,2}
			print("ok")
		--]]
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EXECUTE_CMD, mod.onExecuteCommand)
---EXECUTE COMMAND---

--[[
shaders to flip by screen PositionX
check Rotation?
--]]

--[[
local explosions = Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.BOMB_EXPLOSION)
local mamaMega = Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.MAMA_MEGA_EXPLOSION)

for _, splosion in pairs(explosions) do
	local frame = splosion:GetSprite():GetFrame()
	if frame < 3 then
		local size = splosion.SpriteScale.X
		local nearby = Isaac.FindInRadius(splosion.Position, 75 * size)
		for _, ent in pairs(nearby) do
			if ent.Type == EntityType.ENTITY_SLOT and ent.Variant == WISP_WIZARD then
				beggar:Kill()
				beggar:Remove()
				game:GetLevel():SetStateFlag(LevelStateFlag.STATE_BUM_KILLED, true)
			end
		end
	end
end

if #mamaMega > 0 then
	beggar:Kill()
	beggar:Remove()
	game:GetLevel():SetStateFlag(LevelStateFlag.STATE_BUM_KILLED, true)
end
--]]

--[[
check binder clip

check a.prism with ludo (4176)

check domino 1/6 spawn of pickups -1 (5989)

banned card check use


local room = game:GetRoom()
if not room:HasCurseMist() then

if not player:HasCurseMistEffect() and not player:IsCoopGhost() then
--]]