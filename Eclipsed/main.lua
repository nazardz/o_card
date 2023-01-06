local EclipsedMod = RegisterMod("Eclipsed", 1)
local json = require("json")
local debug = false
local game = Game()
local itemPool = game:GetItemPool()
local sfx = SFXManager()
local savetable = {}
local renderText = 'No Text'
local myUseFlags = UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER | UseFlag.USE_MIMIC
local myUseFlags2 = UseFlag.USE_NOANIM | UseFlag.USE_MIMIC

local RECOMMENDED_SHIFT_IDX = 35
local myrng = RNG()

print('[Eclipsed v.1.0] Type `eclipsed` or `eclipsed help` for a list of commands')

local function modDataLoad()
	if EclipsedMod:HasData() then
		local localtable = json.decode(EclipsedMod:LoadData())
		savetable.FloppyDiskItems = localtable.FloppyDiskItems
		--savetable.NadabCompletionMarks = localtable.NadabCompletionMarks
		--savetable.AbihuCompletionMarks = localtable.AbihuCompletionMarks
		--savetable.UnbiddenCompletionMarks = localtable.UnbiddenCompletionMarks
		--savetable.ObliviousCompletionMarks = localtable.ObliviousCompletionMarks
	else
		savetable.FloppyDiskItems = savetable.FloppyDiskItems or {}
		--savetable.NadabCompletionMarks = savetable.NadabCompletionMarks or {0,0,0,0,0,0,0,0,0,0,0,0,0}
		--savetable.AbihuCompletionMarks = savetable.AbihuCompletionMarks or {0,0,0,0,0,0,0,0,0,0,0,0,0}
		--savetable.UnbiddenCompletionMarks = savetable.UnbiddenCompletionMarks or {0,0,0,0,0,0,0,0,0,0,0,0,0}
		--savetable.ObliviousCompletionMarks = savetable.ObliviousCompletionMarks or {0,0,0,0,0,0,0,0,0,0,0,0,0}
	end
end

local function modDataSave()
	EclipsedMod:SaveData(json.encode(savetable))
end

EclipsedMod.Characters = {}
EclipsedMod.Items = {}
EclipsedMod.Trinkets = {}
EclipsedMod.Pickups = {}
EclipsedMod.Challenges = {}
EclipsedMod.Curses = {}
EclipsedMod.Slots = {}

--- PLAYERS --
do
EclipsedMod.Characters.Nadab = Isaac.GetPlayerTypeByName("Nadab", false)
EclipsedMod.Characters.Abihu = Isaac.GetPlayerTypeByName("Abihu", true)
EclipsedMod.Characters.Unbidden = Isaac.GetPlayerTypeByName("Unbidden", false)
EclipsedMod.Characters.Oblivious = Isaac.GetPlayerTypeByName("Unbidden", true)
end
--- COLLECTIBLES --
do
EclipsedMod.Items.FloppyDisk = Isaac.GetItemIdByName("Floppy Disk")
EclipsedMod.Items.FloppyDiskFull = Isaac.GetItemIdByName("Floppy Disk ") --
EclipsedMod.Items.RedMirror = Isaac.GetItemIdByName("Red Mirror")
EclipsedMod.Items.RedLotus = Isaac.GetItemIdByName("Red Lotus")
EclipsedMod.Items.MidasCurse = Isaac.GetItemIdByName("Curse of the Midas")
EclipsedMod.Items.RubberDuck = Isaac.GetItemIdByName("Duckling") -- killing room
EclipsedMod.Items.IvoryOil = Isaac.GetItemIdByName("Ivory Oil") -- iconaclasts
EclipsedMod.Items.BlackKnight = Isaac.GetItemIdByName("Black Knight") --
EclipsedMod.Items.WhiteKnight = Isaac.GetItemIdByName("White Knight") --
EclipsedMod.Items.KeeperMirror = Isaac.GetItemIdByName("Moonlighter") -- moonlighter
EclipsedMod.Items.RedBag = Isaac.GetItemIdByName("Red Bag") -- Red generator!
EclipsedMod.Items.MeltedCandle = Isaac.GetItemIdByName("Melted Candle") --
EclipsedMod.Items.MiniPony = Isaac.GetItemIdByName("Unicorn") --
EclipsedMod.Items.StrangeBox = Isaac.GetItemIdByName("Strange Box") --
EclipsedMod.Items.RedButton = Isaac.GetItemIdByName("Red Button") -- please, don't touch anything
EclipsedMod.Items.LostMirror = Isaac.GetItemIdByName("Lost Mirror") --
EclipsedMod.Items.BleedingGrimoire = Isaac.GetItemIdByName("Bleeding Grimoire") -- they bleed pixels
EclipsedMod.Items.BlackBook = Isaac.GetItemIdByName("Black Book") -- black book
EclipsedMod.Items.RubikDice = Isaac.GetItemIdByName("Rubik's Dice")
EclipsedMod.Items.RubikDiceScrambled0 = Isaac.GetItemIdByName("Rubik's Dice ")
EclipsedMod.Items.RubikDiceScrambled1 = Isaac.GetItemIdByName("Rubik's Dice  ")
EclipsedMod.Items.RubikDiceScrambled2 = Isaac.GetItemIdByName("Rubik's Dice   ")
EclipsedMod.Items.RubikDiceScrambled3 = Isaac.GetItemIdByName("Rubik's Dice    ")
EclipsedMod.Items.RubikDiceScrambled4 = Isaac.GetItemIdByName("Rubik's Dice     ")
EclipsedMod.Items.RubikDiceScrambled5 = Isaac.GetItemIdByName("Rubik's Dice      ")
EclipsedMod.Items.VHSCassette = Isaac.GetItemIdByName("VHS Cassette")
EclipsedMod.Items.Lililith = Isaac.GetItemIdByName("Lililith")
EclipsedMod.Items.CompoBombs = Isaac.GetItemIdByName("Compo Bombs")
EclipsedMod.Items.LongElk = Isaac.GetItemIdByName("Long Elk") -- inscryption
EclipsedMod.Items.Limb = Isaac.GetItemIdByName("Limbus")
EclipsedMod.Items.GravityBombs = Isaac.GetItemIdByName("Black Hole Bombs")
EclipsedMod.Items.MirrorBombs = Isaac.GetItemIdByName("Glass Bombs")
EclipsedMod.Items.AbihuFam = Isaac.GetItemIdByName("Abihu")
EclipsedMod.Items.FrostyBombs = Isaac.GetItemIdByName("Ice Cube Bombs")
EclipsedMod.Items.VoidKarma = Isaac.GetItemIdByName("Karma Level") -- rainworld
EclipsedMod.Items.CharonObol = Isaac.GetItemIdByName("Charon's Obol") -- hades
EclipsedMod.Items.Viridian = Isaac.GetItemIdByName("VVV")
EclipsedMod.Items.BookMemory = Isaac.GetItemIdByName("Book of Memories") -- loop hero
EclipsedMod.Items.NadabBrain = Isaac.GetItemIdByName("Nadab's Brain")
EclipsedMod.Items.Threshold = Isaac.GetItemIdByName("Threshold")
EclipsedMod.Items.MongoCells = Isaac.GetItemIdByName("Mongo Cells") -- copy your familiars
EclipsedMod.Items.NadabBody = Isaac.GetItemIdByName("Nadab's Body")
EclipsedMod.Items.CosmicJam = Isaac.GetItemIdByName("Space Jam") -- "lf it weren't real, could it do this?"
EclipsedMod.Items.DMS = Isaac.GetItemIdByName("Death's Sickle")
EclipsedMod.Items.MewGen = Isaac.GetItemIdByName("Mew-Gen")
EclipsedMod.Items.ElderSign = Isaac.GetItemIdByName("Elder Sign")
EclipsedMod.Items.Eclipse = Isaac.GetItemIdByName("Eclipse") -- "Darkest Basement" grants aura dealing 2 damage. boost player damage if you have curse of darkness
EclipsedMod.Items.WitchPot = Isaac.GetItemIdByName("Witch's Pot")
EclipsedMod.Items.PandoraJar = Isaac.GetItemIdByName("Pandora's Jar")
EclipsedMod.Items.SecretLoveLetter = Isaac.GetItemIdByName("Secret Love Letter")

EclipsedMod.Items.DiceBombs = Isaac.GetItemIdByName("Dice Bombs") -- "Reroll blast +5 bombs"
--EclipsedMod.Items.Pizza = Isaac.GetItemIdByName("Pizza Pepperoni") -- active 12 seconds. Shoot Pizza boomerang

--EclipsedMod.Items.Gagger = Isaac.GetItemIdByName("Little Gagger") -- punching bag subtype ?
end
--- TRINKETS --
do
EclipsedMod.Trinkets.WitchPaper = Isaac.GetTrinketIdByName("Witch Paper") -- yuppie psycho
EclipsedMod.Trinkets.Duotine = Isaac.GetTrinketIdByName("Duotine") -- fran bow
EclipsedMod.Trinkets.QueenSpades = Isaac.GetTrinketIdByName("Torn Spades")
EclipsedMod.Trinkets.RedScissors = Isaac.GetTrinketIdByName("Red Scissors") -- Fuse Cutter 2.0
EclipsedMod.Trinkets.LostFlower = Isaac.GetTrinketIdByName("Lost Flower") -- "Eternal blessing"
EclipsedMod.Trinkets.MilkTeeth = Isaac.GetTrinketIdByName("Milk Teeth")
EclipsedMod.Trinkets.TeaBag = Isaac.GetTrinketIdByName("Tea Bag")
EclipsedMod.Trinkets.BobTongue = Isaac.GetTrinketIdByName("Bob's Tongue")
EclipsedMod.Trinkets.BinderClip = Isaac.GetTrinketIdByName("Binder Clip")
EclipsedMod.Trinkets.MemoryFragment = Isaac.GetTrinketIdByName("Memory Fragment")
EclipsedMod.Trinkets.AbyssCart = Isaac.GetTrinketIdByName("Cartridge?") -- Cartridge?
EclipsedMod.Trinkets.RubikCubelet = Isaac.GetTrinketIdByName("Rubik's Cubelet") -- TMTRAINER reroll when you take damage
EclipsedMod.Trinkets.TeaFungus = Isaac.GetTrinketIdByName("Tea Fungus")
EclipsedMod.Trinkets.DeadEgg = Isaac.GetTrinketIdByName("Dead Egg") -- chance to spawn dead bird effect when bomb explodes (soul of eve birds)
EclipsedMod.Trinkets.Penance = Isaac.GetTrinketIdByName("Penance")
EclipsedMod.Trinkets.Pompom = Isaac.GetTrinketIdByName("Pomegranate") -- turn red hearts into random red wisps when try pick
EclipsedMod.Trinkets.XmasLetter = Isaac.GetTrinketIdByName("Xmas Letter") -- use fortune cookie when entering new room
end
--- PICKUPS --
do
EclipsedMod.Pickups.OblivionCard = Isaac.GetCardIdByName("01_OblivionCard") -- loop hero
EclipsedMod.Pickups.BattlefieldCard = Isaac.GetCardIdByName("X_BattlefieldCard") -- loop hero
EclipsedMod.Pickups.TreasuryCard = Isaac.GetCardIdByName("X_TreasuryCard") -- teleport to out-map treasure
EclipsedMod.Pickups.BookeryCard = Isaac.GetCardIdByName("X_BookeryCard") -- teleport to out-map library
EclipsedMod.Pickups.BloodGroveCard = Isaac.GetCardIdByName("X_BloodGroveCard") -- teleport to out-map cursed room
EclipsedMod.Pickups.StormTempleCard = Isaac.GetCardIdByName("X_StormTempleCard") -- teleport to out-map sacrifice room
EclipsedMod.Pickups.ArsenalCard = Isaac.GetCardIdByName("X_ArsenalCard") -- teleport to out-map chest room
EclipsedMod.Pickups.OutpostCard = Isaac.GetCardIdByName("X_OutpostCard") -- teleport to out-map bedroom
EclipsedMod.Pickups.CryptCard = Isaac.GetCardIdByName("X_CryptCard") -- teleport to out-map dungeon
EclipsedMod.Pickups.MazeMemoryCard = Isaac.GetCardIdByName("X_MazeMemoryCard") -- teleport to death certificate dimension, add unremovable curse of maze, lost, blind in dimension
EclipsedMod.Pickups.ZeroMilestoneCard = Isaac.GetCardIdByName("X_ZeroMilestoneCard") -- genesis, but next stage is void/ if used on ascension - next stage is home/ if used on greedmode - next stage is boss

EclipsedMod.Pickups.Decay = Isaac.GetCardIdByName("X_Decay") --slay the spire
EclipsedMod.Pickups.AscenderBane = Isaac.GetCardIdByName("X_AscenderBane") --[slay the spire
EclipsedMod.Pickups.MultiCast = Isaac.GetCardIdByName("X_MultiCast")
EclipsedMod.Pickups.Wish = Isaac.GetCardIdByName("X_Wish")
EclipsedMod.Pickups.Offering = Isaac.GetCardIdByName("X_Offering")
EclipsedMod.Pickups.InfiniteBlades = Isaac.GetCardIdByName("X_InfiniteBlades")
EclipsedMod.Pickups.Transmutation = Isaac.GetCardIdByName("X_Transmutation")
EclipsedMod.Pickups.RitualDagger = Isaac.GetCardIdByName("X_RitualDagger")
EclipsedMod.Pickups.Fusion = Isaac.GetCardIdByName("X_Fusion")
EclipsedMod.Pickups.DeuxEx = Isaac.GetCardIdByName("X_DeuxExMachina")
EclipsedMod.Pickups.Adrenaline = Isaac.GetCardIdByName("X_Adrenaline")
EclipsedMod.Pickups.Corruption = Isaac.GetCardIdByName("X_Corruption") -- slay the spire]]

EclipsedMod.Pickups.Apocalypse = Isaac.GetCardIdByName("02_ApoopalypseCard") --
EclipsedMod.Pickups.KingChess = Isaac.GetCardIdByName("03_KingChess")
EclipsedMod.Pickups.KingChessW = Isaac.GetCardIdByName("X_KingChessW")
EclipsedMod.Pickups.BannedCard = Isaac.GetCardIdByName("X_BannedCard") -- pot of greed
EclipsedMod.Pickups.Trapezohedron = Isaac.GetCardIdByName("04_Trapezohedron")
EclipsedMod.Pickups.SoulUnbidden = Isaac.GetCardIdByName("X_SoulUnbidden")
EclipsedMod.Pickups.SoulNadabAbihu = Isaac.GetCardIdByName("X_SoulNadabAbihu")
EclipsedMod.Pickups.GhostGem = Isaac.GetCardIdByName("X_GhostGem") -- flinthook

EclipsedMod.Pickups.DeliObjectCell = Isaac.GetCardIdByName("Dell_Object")
EclipsedMod.Pickups.DeliObjectBomb = Isaac.GetCardIdByName("Dell_Bomb")
EclipsedMod.Pickups.DeliObjectKey = Isaac.GetCardIdByName("Dell_Key")
EclipsedMod.Pickups.DeliObjectCard = Isaac.GetCardIdByName("Dell_Card")
EclipsedMod.Pickups.DeliObjectPill = Isaac.GetCardIdByName("Dell_Pill")
EclipsedMod.Pickups.DeliObjectRune = Isaac.GetCardIdByName("Dell_Rune")
EclipsedMod.Pickups.DeliObjectHeart = Isaac.GetCardIdByName("Dell_Heart")
EclipsedMod.Pickups.DeliObjectCoin = Isaac.GetCardIdByName("Dell_Coin")
EclipsedMod.Pickups.DeliObjectBattery = Isaac.GetCardIdByName("Dell_Battery")

EclipsedMod.Pickups.RedPill = Isaac.GetCardIdByName("X_RedPill")
EclipsedMod.Pickups.RedPillHorse = Isaac.GetCardIdByName("X_RedPillHorse")

EclipsedMod.Pickups.Domino34 = Isaac.GetCardIdByName("X_Domino34")
EclipsedMod.Pickups.Domino25 = Isaac.GetCardIdByName("X_Domino25")
EclipsedMod.Pickups.Domino16 = Isaac.GetCardIdByName("X_Domino16") -- spawn 6 pickups of same type
EclipsedMod.Pickups.Domino00 = Isaac.GetCardIdByName("X_Domino00")
--EclipsedMod.Pickups.Domino12 = Isaac.GetCardIdByName("X_Domino12") -- shoot pizza 8 pizza around you
end
--- CHALLENGES --
do
EclipsedMod.Challenges.Potatoes = Isaac.GetChallengeIdByName("When life gives you Potatoes!") -- unlock mongo beggar
EclipsedMod.Challenges.Magician = Isaac.GetChallengeIdByName("Curse of The Magician") -- unlock Mew-Gen
EclipsedMod.Challenges.Lobotomy = Isaac.GetChallengeIdByName("Lobotomy") -- delirious beggar and pickups
--EclipsedMod.Challenges.IsaacIO = Isaac.GetChallengeIdByName("Isaac.io") -- kill - size up, take damage - size down
end
--- CURSES --
do
-- so IDK if it right thing to remove -1 from  1 << (Isaac.GetCurseIdByName("CustomCurse")-1)  but now it's not show icon of giant curse
EclipsedMod.Curses.Void = 1 << (Isaac.GetCurseIdByName("Curse of the Void!")) -- reroll enemies and grid, apply delirium spritesheet, always active on void floors?
EclipsedMod.Curses.Jamming = 1 << (Isaac.GetCurseIdByName("Curse of the Jamming!")) -- respawn enemies in room after clearing
EclipsedMod.Curses.Emperor = 1 << (Isaac.GetCurseIdByName("Curse of the Emperor!")) -- no exit door from boss room
EclipsedMod.Curses.Magician = 1 << (Isaac.GetCurseIdByName("Curse of the Magician!")) -- homing enemy tears (except boss)
EclipsedMod.Curses.Pride = 1 << (Isaac.GetCurseIdByName("Curse of the Pride!")) -- all enemies is champion (except boss) - without health buff
EclipsedMod.Curses.Bell = 1 << (Isaac.GetCurseIdByName("Curse of the Bell!")) -- all troll bombs is golden
EclipsedMod.Curses.Envy = 1 << (Isaac.GetCurseIdByName("Curse of the Envy!")) -- other shop items disappear when you buy one
EclipsedMod.Curses.Carrion = 1 << (Isaac.GetCurseIdByName("Curse of Carrion!")) -- turn normal poops into red
EclipsedMod.Curses.Bishop = 1 << (Isaac.GetCurseIdByName("Curse of the Bishop!")) -- 16% cahance to enemies prevent damage
EclipsedMod.Curses.Montezuma = 1 << (Isaac.GetCurseIdByName("Curse of Montezuma!")) -- slippery ground
EclipsedMod.Curses.Misfortune = 1 << (Isaac.GetCurseIdByName("Curse of Misfortune!")) -- -5 luck
EclipsedMod.Curses.Poverty = 1 << (Isaac.GetCurseIdByName("Curse of Poverty!")) -- greed enemy tears
EclipsedMod.Curses.Fool = 1 << (Isaac.GetCurseIdByName("Curse of the Fool!")) -- 16% chance to respawn enemies in cleared rooms, don't close doors (except boss)
EclipsedMod.Curses.Secrets = 1 << (Isaac.GetCurseIdByName("Curse of Secrets!")) -- hide secret/supersecret room doors
EclipsedMod.Curses.Warden = 1 << (Isaac.GetCurseIdByName("Curse of the Warden!")) -- all locked doors need 2 keys - visual bug with chains not appearing
EclipsedMod.Curses.Desolation = 1 << (Isaac.GetCurseIdByName("Curse of the Desolation!")) -- 16% chance to turn item into Item Wisp when picked up. Add wisped item after clearing room
--EclipsedMod.Curses.Reaper	 -- spawn unvulnerable scythe following you, kills you if you touch it. (can kill enemies?)
--EclipsedMod.Curses.BrokenHeart -- turn all empty heart places into broken hearts OR add -1 broken heart
--EclipsedMod.Curses.Pain	-- special room doors become spiked -- except boss
--EclipsedMod.Curses.Devil	-- spawn Big Horn hand throwing bombs at you when entering room
--EclipsedMod.Curses.Justice	--	idk
--EclipsedMod.Curses.Oblivion	-- chance to enter out of map room with random enemies/boss. spawns purple portal-teleporter after clearing room 

EclipsedMod.CurseText = {} -- idk, dumb idea actually
EclipsedMod.CurseText[EclipsedMod.Curses.Void] = "Curse of the Void!"
EclipsedMod.CurseText[EclipsedMod.Curses.Jamming] = "Curse of the Jamming!"
EclipsedMod.CurseText[EclipsedMod.Curses.Emperor] = "Curse of the Emperor!"
EclipsedMod.CurseText[EclipsedMod.Curses.Magician] = "Curse of the Magician!"
EclipsedMod.CurseText[EclipsedMod.Curses.Pride] = "Curse of the Pride!"
EclipsedMod.CurseText[EclipsedMod.Curses.Bell] = "Curse of the Bell!"
EclipsedMod.CurseText[EclipsedMod.Curses.Envy] = "Curse of the Envy!"
EclipsedMod.CurseText[EclipsedMod.Curses.Carrion] = "Curse of Carrion!"
EclipsedMod.CurseText[EclipsedMod.Curses.Bishop] = "Curse of the Bishop!"
EclipsedMod.CurseText[EclipsedMod.Curses.Montezuma] = "Curse of Montezuma!"
EclipsedMod.CurseText[EclipsedMod.Curses.Misfortune] = "Curse of Misfortune!"
EclipsedMod.CurseText[EclipsedMod.Curses.Poverty] = "Curse of Poverty!"
EclipsedMod.CurseText[EclipsedMod.Curses.Fool] = "Curse of the Fool!"
EclipsedMod.CurseText[EclipsedMod.Curses.Secrets] = "Curse of Secrets!"
EclipsedMod.CurseText[EclipsedMod.Curses.Warden] = "Curse of the Warden!"
EclipsedMod.CurseText[EclipsedMod.Curses.Desolation] = "Curse of the Desolation!"


--EclipsedMod.Curses.Reaper = 1 << (Isaac.GetCurseIdByName("Curse of the Reaper!")-1) -- death's scythe will follow you
end
--- SLOTS --
do
EclipsedMod.Slots.DeliriumBeggar = Isaac.GetEntityVariantByName("Delirious Bum")
EclipsedMod.Slots.MongoBeggar = Isaac.GetEntityVariantByName("Mongo Beggar")

end
--- LOCAL TABLES --
do
EclipsedMod.CurseIcons = Sprite()
EclipsedMod.CurseIcons:Load("gfx/ui/oc_curse_icons.anm2", true) -- render it somewhere ?
EclipsedMod.RedColor = Color(1.5,0,0,1,0,0,0) -- red color I guess
EclipsedMod.PinkColor = Color(2,0,0.7,1,0,0,0) -- pink color
EclipsedMod.TrinketDespawnTimer = 35 -- x>25; x=35 -- it will be removed
EclipsedMod.CurseChance = 0.5 -- chances to mod curses to apply
EclipsedMod.VoidThreshold = 0.15  -- chance to trigger void curse when entering room
EclipsedMod.JammingThreshold = 0.15 -- chance to trigger jamming curse after clearing room
EclipsedMod.PrideThreshold = 0.5 -- chance to become champion
EclipsedMod.BishopThreshold = 0.15 -- chance to trigger damage immunity
EclipsedMod.MisfortuneLuck = -5 -- -5 luck
EclipsedMod.FoolThreshold = 0.15 -- chance to trigger fool when entering room
EclipsedMod.DesolationThreshold = 0.15 -- chance to turn item into ItemWisp

EclipsedMod.NadabData = {}
--EclipsedMod.NadabData.CompletionMarks = {0,0,0,0,0,0,0,0,0,0,0,0,0} --1:Isaac, 2:BlueBaby, 3:Satan, 4:Lamb, 5:BossRush, 6:Hush, 7:MegaSatan, 8:Delirium, 9:Mother, 10:Beast, 11:Greed/Greedier, 12:Heart, 13:AllMarksHard
EclipsedMod.NadabData.CostumeHead = Isaac.GetCostumeIdByPath("gfx/characters/nadab_head.anm2")
EclipsedMod.NadabData.ExplosionCountdown = 30 -- so don't spam
EclipsedMod.NadabData.MrMegaDmgMultiplier = 0.75 -- dmg up when you pick Mr.Mega
EclipsedMod.NadabData.SadBombsFiredelay = -1.0 -- tears up when you pick up Sad bombs
EclipsedMod.NadabData.FastBombsSpeed = 1.0 -- speed up to 1.0 when you pick up fast bomb
EclipsedMod.NadabData.RingCapFrameCount = 10 -- ring cap delay to 2nd (3rd and etc. based on Ring Cap stack) explosion
EclipsedMod.NadabData.StickySpiderRadius = 30 -- spawn blue spiders in given radius from enemies. well, cause player is bomb, blue spiders can't be obtained from enemies by collision (you can, but I don't want to)
EclipsedMod.NadabData.BombBeggarSprites = { -- next animations trigger giving bomb, cause character don't have bombs
['Idle'] = true,
['PayNothing'] = true }
EclipsedMod.NadabData.Stats = {}
EclipsedMod.NadabData.Stats.DAMAGE = 1.2
EclipsedMod.NadabData.Stats.SPEED = -0.35

EclipsedMod.AbihuData = {}
--EclipsedMod.AbihuData.CompletionMarks = {0,0,0,0,0,0,0,0,0,0,0,0,0}
EclipsedMod.AbihuData.CostumeHead = Isaac.GetCostumeIdByPath("gfx/characters/abihu_costume.anm2")
EclipsedMod.AbihuData.DamageDelay = 30
EclipsedMod.AbihuData.HoldBombDelay = 20
EclipsedMod.AbihuData.ChargeBar = Sprite()
EclipsedMod.AbihuData.ChargeBar:Load("gfx/chargebar.anm2", true)
EclipsedMod.AbihuData.Stats = {}
EclipsedMod.AbihuData.Stats.DAMAGE = 1.14286
EclipsedMod.AbihuData.Stats.SPEED = 1.0
EclipsedMod.AbihuData.Unlocked = false

EclipsedMod.UnbiddenData = {}
--EclipsedMod.UnbiddenData.CompletionMarks = {0,0,0,0,0,0,0,0,0,0,0,0,0}
EclipsedMod.UnbiddenData.RadiusWisp = 100
EclipsedMod.UnbiddenData.Stats = {}
EclipsedMod.UnbiddenData.Stats.DAMAGE = 1.35
EclipsedMod.UnbiddenData.Stats.LUCK = -1

EclipsedMod.ObliviousData = {}
EclipsedMod.ObliviousData.DamageDelay = 12
EclipsedMod.ObliviousData.Knockback = 4
EclipsedMod.ObliviousData.TearVariant = TearVariant.MULTIDIMENSIONAL
--EclipsedMod.ObliviousData.CompletionMarks = {0,0,0,0,0,0,0,0,0,0,0,0,0}
EclipsedMod.ObliviousData.ChargeBar = Sprite()
EclipsedMod.ObliviousData.ChargeBar:Load("gfx/chargebar.anm2", true)
EclipsedMod.ObliviousData.Stats = {}
EclipsedMod.ObliviousData.Stats.DAMAGE = 1
EclipsedMod.ObliviousData.Stats.LUCK = -3
EclipsedMod.ObliviousData.Stats.TRAR_FLAG = TearFlags.TEAR_WAIT | TearFlags.TEAR_CONTINUUM
EclipsedMod.ObliviousData.Stats.TEAR_COLOR = Color(0.5,1,2,1,0,0,0)
EclipsedMod.ObliviousData.Stats.LASER_COLOR = Color(1,1,1,1,-0.5,0.7,1)


EclipsedMod.BellCurse = { -- bell curse turns next bombs into golden trollbombs
	[BombVariant.BOMB_TROLL] = true,
	[BombVariant.BOMB_SUPERTROLL] = true,
}

EclipsedMod.NoBombTrace = { -- do not trace this bombs (used for: when you reenters room, prevents adding bomb-effect to existing bombs what was placed before getting any mod bomb item)
	[BombVariant.BOMB_TROLL]= true,
	[BombVariant.BOMB_SUPERTROLL]= true,
	[BombVariant.BOMB_GOLDENTROLL]= true,
	[BombVariant.BOMB_THROWABLE] = true,
	[BombVariant.BOMB_ROCKET] = true,
	[BombVariant.BOMB_ROCKET_GIGA] = true,
}

EclipsedMod.ActiveItemWisps = {
	[EclipsedMod.Items.RedMirror] = CollectibleType.COLLECTIBLE_RED_KEY,
	[EclipsedMod.Items.KeeperMirror] = CollectibleType.COLLECTIBLE_KEEPERS_BOX,
	[EclipsedMod.Items.MiniPony] = CollectibleType.COLLECTIBLE_MY_LITTLE_UNICORN,
	[EclipsedMod.Items.StrangeBox] = CollectibleType.COLLECTIBLE_UNDEFINED,
	[EclipsedMod.Items.LostMirror] = CollectibleType.COLLECTIBLE_GLASS_CANNON,
	[EclipsedMod.Items.BleedingGrimoire] = CollectibleType.COLLECTIBLE_RAZOR_BLADE,
	[EclipsedMod.Items.BlackBook] = CollectibleType.COLLECTIBLE_DEAD_SEA_SCROLLS,
	[EclipsedMod.Items.RubikDice] = CollectibleType.COLLECTIBLE_UNDEFINED,
	[EclipsedMod.Items.RubikDiceScrambled0] = CollectibleType.COLLECTIBLE_UNDEFINED,
	[EclipsedMod.Items.RubikDiceScrambled1] = CollectibleType.COLLECTIBLE_UNDEFINED,
	[EclipsedMod.Items.RubikDiceScrambled2] = CollectibleType.COLLECTIBLE_UNDEFINED,
	[EclipsedMod.Items.RubikDiceScrambled3] = CollectibleType.COLLECTIBLE_UNDEFINED,
	[EclipsedMod.Items.RubikDiceScrambled4] = CollectibleType.COLLECTIBLE_UNDEFINED,
	[EclipsedMod.Items.RubikDiceScrambled5] = CollectibleType.COLLECTIBLE_UNDEFINED,
	[EclipsedMod.Items.VHSCassette] = CollectibleType.COLLECTIBLE_CLICKER,
	[EclipsedMod.Items.LongElk] = CollectibleType.COLLECTIBLE_NECRONOMICON,
	[EclipsedMod.Items.CharonObol] = CollectibleType.COLLECTIBLE_IV_BAG,
	[EclipsedMod.Items.WhiteKnight] = CollectibleType.COLLECTIBLE_PONY,
	[EclipsedMod.Items.BlackKnight] = CollectibleType.COLLECTIBLE_PONY,
	[EclipsedMod.Items.FloppyDisk] = CollectibleType.COLLECTIBLE_EDENS_SOUL,
	[EclipsedMod.Items.FloppyDiskFull] = CollectibleType.COLLECTIBLE_EDENS_SOUL,
	[EclipsedMod.Items.BookMemory] = CollectibleType.COLLECTIBLE_ERASER,
	[EclipsedMod.Items.CosmicJam] = CollectibleType.COLLECTIBLE_LEMEGETON,
	[EclipsedMod.Items.ElderSign] = CollectibleType.COLLECTIBLE_PAUSE,
	[EclipsedMod.Items.WitchPot] = CollectibleType.COLLECTIBLE_MOMS_BOX,
	[EclipsedMod.Items.PandoraJar] = CollectibleType.COLLECTIBLE_GLASS_CANNON,
	[EclipsedMod.Items.SecretLoveLetter] = CollectibleType.COLLECTIBLE_KIDNEY_BEAN,
}
------------SLOTS--------------
EclipsedMod.ReplaceBeggarVariants = {
	[4] = true, --beggar
	[5] = true, --devil beggar
	[7] = true, --key master
	[9] = true, --bomb bum
	[13] = true, -- battery bum
	[18] = true -- rotten beggar
}

EclipsedMod.MongoBeggar= {}
EclipsedMod.MongoBeggar.ReplaceChance = 0.1 --chance to replace beggar
EclipsedMod.MongoBeggar.PityCounter = 6 --do something if beggar haven't done anything 7 times in a row
EclipsedMod.MongoBeggar.PrizeCounter = 6 --guaranteed to give leave after 6 activations
EclipsedMod.MongoBeggar.PrizeChance = 0.05 --prize chance
EclipsedMod.MongoBeggar.ActivateChance = 0.2 --activation chance

EclipsedMod.DeliriumBeggar = {}
EclipsedMod.DeliriumBeggar.ReplaceChance = 0.1
EclipsedMod.DeliriumBeggar.PityCounter = 6
EclipsedMod.DeliriumBeggar.ActivateChance = 0.33 --activation chance - charmed enemy (chance to activate)
EclipsedMod.DeliriumBeggar.PrizeChance = 0.05 --reward chance - charmed boss (chance after activation)
EclipsedMod.DeliriumBeggar.DeliPickupChance = 0.25 --delirium pickup chance (chance after activation)
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

EclipsedMod.PandoraJar = {}
EclipsedMod.PandoraJar.CurseChance = 0.15
EclipsedMod.PandoraJar.ItemWispChance = 0.25

EclipsedMod.Eclipse = {}
EclipsedMod.Eclipse.AuraRange = 125
EclipsedMod.Eclipse.DamageDelay = 22
EclipsedMod.Eclipse.DamageBoost = 0.5
EclipsedMod.Eclipse.Knockback = 4

EclipsedMod.MongoCells = {}
EclipsedMod.MongoCells.HeadlessCreepFrame = 8
EclipsedMod.MongoCells.DryBabyChance = 0.33
EclipsedMod.MongoCells.FartBabyChance = 0.33
EclipsedMod.MongoCells.FartBabyBeans = {CollectibleType.COLLECTIBLE_BEAN, CollectibleType.COLLECTIBLE_BUTTER_BEAN, CollectibleType.COLLECTIBLE_KIDNEY_BEAN}
EclipsedMod.MongoCells.DepressionCreepFrame = 8
EclipsedMod.MongoCells.DepressionLightChance = 0.33
EclipsedMod.MongoCells.BBFDamage = 100

EclipsedMod.MewGen = {}
EclipsedMod.MewGen.ActivationTimer = 150
EclipsedMod.MewGen.RechargeTimer = 90

EclipsedMod.DMS = {}
EclipsedMod.DMS.Chance = 0.25

EclipsedMod.RedLotus = {}
EclipsedMod.RedLotus.DamageUp = 1.0 -- red lotus damage up for removing broken heart

EclipsedMod.Viridian = {} -- sprite:RenderLayer(LayerId, Position, TopLeftClamp, BottomRightClamp)
EclipsedMod.Viridian.FlipOffsetY = 34

EclipsedMod.Limb = {}
EclipsedMod.Limb.InvFrames = 24  -- frames count after death when you are invincible

EclipsedMod.RedButton = {}
EclipsedMod.RedButton.PressCount = 0 -- press counter
EclipsedMod.RedButton.Limit = 66 -- limit
EclipsedMod.RedButton.SpritePath = "gfx/grid/grid_redbutton.png"
EclipsedMod.RedButton.KillButtonChance = 0.98 --99 -- actually 1%
EclipsedMod.RedButton.EventButtonChance = 0.5 --50 -- 50/50% chance of spawning event button (if EventButtonChance = 60, actual chance is 40%)
EclipsedMod.RedButton.VarData = 999 -- data to check right grid entity

EclipsedMod.MidasCurse = {}
EclipsedMod.MidasCurse.FreezeTime = 10000 -- midas freeze timer
EclipsedMod.MidasCurse.MaxGold = 1.0 -- for check ?? (idk what is this for)
EclipsedMod.MidasCurse.MinGold = 0.1 -- for check ??
EclipsedMod.MidasCurse.TurnGoldChance = 1.0 -- with black candle is 0.1
--EclipsedMod.MidasCurse.TearColor = Color(2, 1, 0, 1, 0, 0, 0)

EclipsedMod.RubberDuck = {}
EclipsedMod.RubberDuck.MaxLuck = 20 -- add luck when picked up (stackable)

EclipsedMod.MeltedCandle = {}
EclipsedMod.MeltedCandle.TearChance = 0.8 -- random + player.Luck > tearChance
EclipsedMod.MeltedCandle.TearFlags = TearFlags.TEAR_FREEZE | TearFlags.TEAR_BURN -- tear effects
EclipsedMod.MeltedCandle.TearColor =  Color(2, 2, 2, 1, 0.196, 0.196, 0.196) --spider bite color
EclipsedMod.MeltedCandle.FrameCount = 92

EclipsedMod.VoidKarma = {}
EclipsedMod.VoidKarma.DamageUp = 0.25 -- add given values to player each time entering new level
EclipsedMod.VoidKarma.TearsUp = 0.25
EclipsedMod.VoidKarma.RangeUp = 2.5
EclipsedMod.VoidKarma.ShotSpeedUp = 0.1
EclipsedMod.VoidKarma.SpeedUp = 0.05
EclipsedMod.VoidKarma.LuckUp = 0.5
EclipsedMod.VoidKarma.EvaCache = CacheFlag.CACHE_DAMAGE | CacheFlag.CACHE_FIREDELAY | CacheFlag.CACHE_SHOTSPEED | CacheFlag.CACHE_RANGE | CacheFlag.CACHE_SPEED | CacheFlag.CACHE_LUCK

EclipsedMod.CompoBombs = {}
EclipsedMod.CompoBombs.BasicCountdown = 44 -- no way to get placed bomb countdown. meh. but it will explode anyway after 44 frames
EclipsedMod.CompoBombs.ShortCountdown = 20 -- if player has short fuse trinket
EclipsedMod.CompoBombs.FetusCountdown = 30 -- 30 for fetus
EclipsedMod.CompoBombs.DimensionX = -22 -- move in X dimension (offset)
EclipsedMod.CompoBombs.Baned = { -- don't add this effect on next bombs
[BombVariant.BOMB_DECOY]= true,
[BombVariant.BOMB_TROLL]= true,
[BombVariant.BOMB_SUPERTROLL]= true,
[BombVariant.BOMB_GOLDENTROLL]= true,
[BombVariant.BOMB_THROWABLE] = true,
[BombVariant.BOMB_GIGA] = true,
[BombVariant.BOMB_ROCKET] = true
}

EclipsedMod.MirrorBombs = {}
EclipsedMod.MirrorBombs.BasicCountdown = 44 -- basic explosion countdown (copy compo bombs shortfuse and fetus countdown)
EclipsedMod.MirrorBombs.Ban = { -- don't add this effect on next bombs
[BombVariant.BOMB_TROLL]= true,
[BombVariant.BOMB_SUPERTROLL]= true,
[BombVariant.BOMB_GOLDENTROLL]= true,
[BombVariant.BOMB_THROWABLE] = true,
}

EclipsedMod.FrostyBombs = {} -- sprite:ReplaceSpritesheet ( int LayerId, string PngFilename )
EclipsedMod.FrostyBombs.NancyChance = 0.1 -- chance to add bomb effect if you have nancy bombs
EclipsedMod.FrostyBombs.FetusChance = 0.25 -- chance to add bomb effect to fetus bombs + player.Luck
EclipsedMod.FrostyBombs.Flags = TearFlags.TEAR_SLOW | TearFlags.TEAR_ICE
EclipsedMod.FrostyBombs.IgnoreSprite = { -- don't replace sprite
	[BombVariant.BOMB_BIG]= true,
	[BombVariant.BOMB_DECOY]= true,
}
EclipsedMod.FrostyBombs.Ban = { -- don't affect next bombs (not used)
	[BombVariant.BOMB_TROLL]= true,
	[BombVariant.BOMB_SUPERTROLL]= true,
	[BombVariant.BOMB_GOLDENTROLL]= true,
	[BombVariant.BOMB_THROWABLE] = true,
}

EclipsedMod.GravityBombs = {}
EclipsedMod.GravityBombs.BlackHoleEffect = Isaac.GetEntityVariantByName("BlackHoleBombsEffect") -- black hole effect
EclipsedMod.GravityBombs.GigaBombs = 1
EclipsedMod.GravityBombs.AttractorForce = 50 -- basic force
EclipsedMod.GravityBombs.AttractorRange = 250 -- basic range
EclipsedMod.GravityBombs.AttractorGridRange = 5 -- basic range
EclipsedMod.GravityBombs.MaxRange = 2500 -- max range for attraction
EclipsedMod.GravityBombs.MaxForce = 15 -- max force for attraction
EclipsedMod.GravityBombs.MaxGrid = 200 -- max range for grid destroyer
EclipsedMod.GravityBombs.IterRange = 15 -- increase attraction range
EclipsedMod.GravityBombs.IterForce = 0.5 -- increase attraction force
EclipsedMod.GravityBombs.IterGrid = 2.5 -- increase grid destroy range
EclipsedMod.GravityBombs.NancyChance = 0.1 -- chance to add bomb effect if you have Nancy bombs
EclipsedMod.GravityBombs.FetusChance = 0.25
EclipsedMod.GravityBombs.IgnoreSprite = { -- ignore this bombs sprite
	[BombVariant.BOMB_BIG]= true,
	[BombVariant.BOMB_DECOY]= true,
}
EclipsedMod.GravityBombs.Ban = { -- don't affect this bombs (not used)
	[BombVariant.BOMB_TROLL]= true,
	[BombVariant.BOMB_SUPERTROLL]= true,
	[BombVariant.BOMB_GOLDENTROLL]= true,
	[BombVariant.BOMB_THROWABLE] = true,
}
EclipsedMod.DiceBombs = {}
EclipsedMod.DiceBombs.ChestsTable = {50,51,52,53,54,55,56,57,58,60}
EclipsedMod.DiceBombs.PickupsTable = {10, 20, 30, 40, 50, 69, 70, 90, 300, 350}
EclipsedMod.DiceBombs.AreaRadius = 80
EclipsedMod.DiceBombs.NancyChance = 0.05
EclipsedMod.DiceBombs.FetusChance = 0.25
EclipsedMod.DiceBombs.IgnoreSprite = { -- ignore this bombs sprite
	[BombVariant.BOMB_BIG]= true,
	[BombVariant.BOMB_DECOY]= true,
	--[BombVariant.BOMB_BRIMSTONE] = true,
	
}

EclipsedMod.DiceBombs.Ban = { -- don't affect this bombs (not used)
	[BombVariant.BOMB_TROLL]= true,
	[BombVariant.BOMB_SUPERTROLL]= true,
	[BombVariant.BOMB_GOLDENTROLL]= true,
	[BombVariant.BOMB_THROWABLE] = true,
}
end
--- FAMILIARS --
do
EclipsedMod.NadabBrain = {}
EclipsedMod.NadabBrain.Variant = Isaac.GetEntityVariantByName("NadabBrain")
EclipsedMod.NadabBrain.Speed = 3.75
EclipsedMod.NadabBrain.Respawn = 300
EclipsedMod.NadabBrain.MaxDistance = 150
EclipsedMod.NadabBrain.BurnTime = 42
EclipsedMod.NadabBrain.CollisionDamage = 3.5

EclipsedMod.Lililith = {}
EclipsedMod.Lililith.Variant = Isaac.GetEntityVariantByName("Lililith")
EclipsedMod.Lililith.GenAfterRoom = 7 -- spawn baby after every X room.
EclipsedMod.Lililith.DemonSpawn = { -- familiars that can be spawned by lililith
{CollectibleType.COLLECTIBLE_DEMON_BABY, FamiliarVariant.DEMON_BABY, 0}, -- item. familiar. count
{CollectibleType.COLLECTIBLE_LIL_BRIMSTONE, FamiliarVariant.LIL_BRIMSTONE, 0},
{CollectibleType.COLLECTIBLE_LIL_ABADDON, FamiliarVariant.LIL_ABADDON, 0},
{CollectibleType.COLLECTIBLE_INCUBUS, FamiliarVariant.INCUBUS, 0},
{CollectibleType.COLLECTIBLE_SUCCUBUS, FamiliarVariant.SUCCUBUS, 0},
{CollectibleType.COLLECTIBLE_LEECH, FamiliarVariant.LEECH, 0},
--{CollectibleType.COLLECTIBLE_TWISTED_PAIR, FamiliarVariant.TWISTED_BABY, 0},
}

EclipsedMod.AbihuFam = {}
EclipsedMod.AbihuFam.Variant = Isaac.GetEntityVariantByName("AbihuFam")
EclipsedMod.AbihuFam.Subtype = 2 -- 0 - idle, 1 - walking
EclipsedMod.AbihuFam.CollisionTime = 44 -- collision delay
EclipsedMod.AbihuFam.SpawnRadius = 50 -- spawn radius of fire jets when get damage (with bffs)
EclipsedMod.AbihuFam.BurnTime = 42 -- enemy burn time

EclipsedMod.RedBag = {}
EclipsedMod.RedBag.Variant = Isaac.GetEntityVariantByName("Red Bag")
EclipsedMod.RedBag.GenAfterRoom = 1 -- general (for red poop)
EclipsedMod.RedBag.RedPoopChance = 0.05 -- chance to spawn red poop
EclipsedMod.RedBag.RedPickups = { -- possible items
{PickupVariant.PICKUP_THROWABLEBOMB, 0, 1}, -- varitant, subtype, generation delay (how many room need to be cleared to activate it again after spawning this pickup)
{PickupVariant.PICKUP_HEART, HeartSubType.HEART_FULL, 3},
{PickupVariant.PICKUP_HEART, HeartSubType.HEART_HALF, 2},
{PickupVariant.PICKUP_HEART, HeartSubType.HEART_DOUBLEPACK, 4},
{PickupVariant.PICKUP_HEART, HeartSubType.HEART_SCARED, 3},
{PickupVariant.PICKUP_TAROTCARD, Card.CARD_DICE_SHARD, 6},
{PickupVariant.PICKUP_TAROTCARD, Card.CARD_CRACKED_KEY, 6},
{PickupVariant.PICKUP_TAROTCARD, EclipsedMod.Pickups.RedPill, 2},
{PickupVariant.PICKUP_TAROTCARD, EclipsedMod.Pickups.RedPillHorse, 4},
{PickupVariant.PICKUP_TAROTCARD, EclipsedMod.Pickups.Trapezohedron, 5}
}
end
--- TRINKETS --
do
EclipsedMod.QueenSpades = {}
EclipsedMod.QueenSpades.Chance = 0.33

EclipsedMod.XmasLetter = {}
EclipsedMod.XmasLetter.Chance = 0.5

EclipsedMod.AbyssCart = {}
EclipsedMod.AbyssCart.NoRemoveChance = 0.5 --this value * (trinket multiplier-1)
EclipsedMod.AbyssCart.SacrificeBabies = {
	--[167] = 10, by this way I must get all game items (not good variant)
	{167, 10},  -- HARLEQUIN_BABY
	{8, 1},  -- BROTHER_BOBBY
	{67, 7},  -- SISTER_MAGGY
	{100, 5},  -- LITTLE_STEVEN
	{268, 54},  -- ROTTEN_BABY
	{269, 55},  -- HEADLESS_BABY
	{322, 74},  -- MONGO_BABY
	{188, 8},  -- ABEL
	{491, 112},  -- ACID_BABY
	{607, 208},  -- BOILED_BABY
	{518, 119},  -- BUDDY_IN_A_BOX
	{652, 239},  -- CUBE_BABY
	{113, 2},  -- DEMON_BABY
	{265, 51},  -- DRY_BABY
	{404, 95},  -- FARTING_BABY
	{608, 209},  -- FREEZER_BABY
	{163, 9},  -- GHOST_BABY
	{112, 32},  -- GUARDIAN_ANGEL
	{360, 80},  -- INCUBUS
	{472, 109},  -- KING_BABY
	{679, 230},  -- LIL_ABADDON
	{275, 61},  -- LIL_BRIMSTONE
	{435, 97},  -- LIL_LOKI
	{431, 101},  -- MULTIDIMENSIONAL_BABY
	{174, 11},  -- RAINBOW_BABY
	{95, 6},  -- ROBO_BABY
	{267, 53},  -- ROBO_BABY_2
	{390, 92},  -- SERAPHIM
	{363, 83},  -- SWORN_PROTECTOR
	--{661, 1},  -- QUINTS
	{698, 235},  -- TWISTED_BABY
}

EclipsedMod.Pompom = {}
EclipsedMod.Pompom.Chance = 0.5
EclipsedMod.Pompom.WispsList = {

--[
CollectibleType.COLLECTIBLE_BLOOD_RIGHTS,
CollectibleType.COLLECTIBLE_CONVERTER,
CollectibleType.COLLECTIBLE_MOMS_BRA,
--CollectibleType.COLLECTIBLE_KAMIKAZE,
CollectibleType.COLLECTIBLE_YUM_HEART,
CollectibleType.COLLECTIBLE_D6,
--CollectibleType.COLLECTIBLE_D20,
CollectibleType.COLLECTIBLE_RAZOR_BLADE,
CollectibleType.COLLECTIBLE_RED_CANDLE,
CollectibleType.COLLECTIBLE_THE_JAR,
CollectibleType.COLLECTIBLE_SCISSORS,
CollectibleType.COLLECTIBLE_RED_KEY,
CollectibleType.COLLECTIBLE_MEGA_BLAST,
--CollectibleType.COLLECTIBLE_SULFUR,
CollectibleType.COLLECTIBLE_SHARP_STRAW, -- outer ring
CollectibleType.COLLECTIBLE_MEAT_CLEAVER,
-- CollectibleType.COLLECTIBLE_PLAN_C,
--CollectibleType.COLLECTIBLE_SUMPTORIUM,
65540, -- notched axe (redstone) red laser wisp
--]
-- CollectibleType.COLLECTIBLE_VENGEFUL_SPIRIT, -- unkillable
-- CollectibleType.COLLECTIBLE_POTATO_PEELER, -- unkillable
}

EclipsedMod.LostFlower = {}
EclipsedMod.LostFlower.DespawnTimer = 35 -- timer after which trinket will be removed (effect similar to A+ trinket)
EclipsedMod.LostFlower.ItemGiveEternalHeart ={ -- items which give eternal hearts
[CollectibleType.COLLECTIBLE_FATE]=true,
[CollectibleType.COLLECTIBLE_ACT_OF_CONTRITION]=true,
}

EclipsedMod.RedScissors = {}
EclipsedMod.RedScissors.GigaBombsSplitNum = 5
EclipsedMod.RedScissors.NormalReplaceFrame = 58 -- replace troll bombs on this frame
EclipsedMod.RedScissors.GigaReplaceFrame = 86 -- replace giga bombs on this frame
EclipsedMod.RedScissors.TrollBombs = { -- replace next bombs
[BombVariant.BOMB_TROLL] = true,
[BombVariant.BOMB_SUPERTROLL] = true,
[BombVariant.BOMB_GOLDENTROLL] = true,
[BombVariant.BOMB_SMALL] = true,
[BombVariant.BOMB_BRIMSTONE] = true,
[BombVariant.BOMB_GIGA] = true,
}

EclipsedMod.Duotine = {}
EclipsedMod.Duotine.HorsePillChance = 0.1 -- chance to spawn red horse pill

EclipsedMod.MilkTeeth = {}
EclipsedMod.MilkTeeth.CoinChance = 0.15 -- 0.3 golden/mombox -- 0.5 golden+mombox
EclipsedMod.MilkTeeth.CoinDespawnTimer = 75  -- remove coin on == 0

EclipsedMod.TeaBag = {}
EclipsedMod.TeaBag.Radius = 100 -- 200 -- golden or mom box -- 500 golden and mom box
EclipsedMod.TeaBag.PoisonSmoke = EffectVariant.SMOKE_CLOUD -- remove smoke clouds

EclipsedMod.BinderClip = {}
EclipsedMod.BinderClip.DoublerChance = 0.15

EclipsedMod.DeadEgg = {}
EclipsedMod.DeadEgg.Timeout = 150

EclipsedMod.Penance = {}
EclipsedMod.Penance.Timeout = 10
EclipsedMod.Penance.Chance = 0.16
EclipsedMod.Penance.LaserVariant = 5
EclipsedMod.Penance.Effect = EffectVariant.REDEMPTION
EclipsedMod.Penance.Color = Color(1.25, 0.05, 0.15, 0.5)
end
--- ACTIVE --
do
EclipsedMod.SecretLoveLetter = {}
EclipsedMod.SecretLoveLetter.TearVariant = TearVariant.CHAOS_CARD --Isaac.GetEntityVariantByName("Love Letter Tear")
EclipsedMod.SecretLoveLetter.SpritePath = "gfx/LoveLetterTear.png"
EclipsedMod.SecretLoveLetter.AffectedEnemies = {} -- type, variant
EclipsedMod.SecretLoveLetter.BannedEnemies = {
[260] = true, -- lil ghosts.  for haunt boos, cause he just don't switch to 2nd phase
}

EclipsedMod.WitchPot = {}
-- only when you have pocket trinkets
EclipsedMod.WitchPot.KillThreshold = 0.1 -- 0.0 + 0.1
EclipsedMod.WitchPot.GulpThreshold = 0.5 -- 0.1 + 0.4
EclipsedMod.WitchPot.SpitThreshold = 0.9 -- 0.5 + 0.4
--EclipsedMod.WitchPot.RollThreshold = 1 -- 0.9 + 0.1
-- only when you don't have pocket trinkets (spit out gulped trinket)
EclipsedMod.WitchPot.SpitChance = 0.4 -- 0.0 + 0.4

EclipsedMod.ElderSign = {}
EclipsedMod.ElderSign.Pentagram = EffectVariant.HERETIC_PENTAGRAM --EffectVariant.PENTAGRAM_BLACKPOWDER
EclipsedMod.ElderSign.Timeout = 20
EclipsedMod.ElderSign.AuraRange = 60

EclipsedMod.WhiteKnight = {}
EclipsedMod.WhiteKnight.Costume = NullItemID.ID_REVERSE_CHARIOT_ALT
--EclipsedMod.WhiteKnight.Costume = NullItemID.ID_REVERSE_CHARIOT_ALT --Isaac.GetCostumeIdByPath("gfx/characters/whiteknight.anm2")

EclipsedMod.BlackKnight = {}
EclipsedMod.BlackKnight.Costume = Isaac.GetCostumeIdByPath("gfx/characters/knightmare.anm2")
EclipsedMod.BlackKnight.Target = Isaac.GetEntityVariantByName("kTarget")
EclipsedMod.BlackKnight.DoorRadius = 40 -- distance in which auto-enter door
EclipsedMod.BlackKnight.BlastDamage = 75 -- blast damage when land
EclipsedMod.BlackKnight.BlastRadius = 50 -- areas where blast affects
EclipsedMod.BlackKnight.BlastKnockback = 30 -- knockback
EclipsedMod.BlackKnight.PickupDistance = 30 -- auto-pickup range
EclipsedMod.BlackKnight.InvFrames = 120 -- inv frames after using item
EclipsedMod.BlackKnight.IgnoreAnimations = { -- ignore next animations while jumped/landed
["WalkDown"] = true,
["Hit"] = true,
["PickupWalkDown"] = true,
["Sad"] = true,
["Happy"] = true,
["WalkLeft"] = true,
["WalkRight"] = true,
["WalkUp"] = true,
}
EclipsedMod.BlackKnight.TeleportAnimations = { -- teleport anims
["TeleportUp"] = true,
["TeleportDown"] = true,
}
EclipsedMod.BlackKnight.StonEnemies = { -- crush stone enemies
[EntityType.ENTITY_STONEY] = true,
[EntityType.ENTITY_STONEHEAD] = true,
[EntityType.ENTITY_QUAKE_GRIMACE] = true,
[EntityType.ENTITY_BOMB_GRIMACE] = true,
}
EclipsedMod.BlackKnight.ChestVariant = { -- chests
[PickupVariant.PICKUP_BOMBCHEST] = true,
[PickupVariant.PICKUP_LOCKEDCHEST] = true,
[PickupVariant.PICKUP_MEGACHEST] = true,
[PickupVariant.PICKUP_REDCHEST] = true,
[PickupVariant.PICKUP_CHEST] = true,
[PickupVariant.PICKUP_SPIKEDCHEST] = true,
[PickupVariant.PICKUP_ETERNALCHEST] = true,
[PickupVariant.PICKUP_MIMICCHEST] = true,
[PickupVariant.PICKUP_OLDCHEST] = true,
[PickupVariant.PICKUP_WOODENCHEST] = true,
[PickupVariant.PICKUP_HAUNTEDCHEST] = true,
}

EclipsedMod.LongElk = {}
EclipsedMod.LongElk.InvFrames = 24  -- frames count when you invincible (not used)
EclipsedMod.LongElk.BoneSpurTimer = 18  -- frames count after which bone spur can be spawned
EclipsedMod.LongElk.NumSpur = 5 -- number of bone spurs after which oldest bone spur will be removed/killed: removeTimer = (BoneSpurTimer * NumSpur)
EclipsedMod.LongElk.Costume = Isaac.GetCostumeIdByPath("gfx/characters/longelk.anm2") --longelk
EclipsedMod.LongElk.Damage = 400
EclipsedMod.LongElk.TeleDelay = 40

EclipsedMod.RubikDice = {}
EclipsedMod.RubikDice.GlitchReroll = 0.16 -- chance to become scrambled dice when used
EclipsedMod.RubikDice.ScrambledDices = { -- checklist
[EclipsedMod.Items.RubikDiceScrambled0] = true,
[EclipsedMod.Items.RubikDiceScrambled1] = true,
[EclipsedMod.Items.RubikDiceScrambled2] = true,
[EclipsedMod.Items.RubikDiceScrambled3] = true,
[EclipsedMod.Items.RubikDiceScrambled4] = true,
[EclipsedMod.Items.RubikDiceScrambled5] = true,
}
EclipsedMod.RubikDice.ScrambledDicesList = { -- list
EclipsedMod.Items.RubikDiceScrambled0,
EclipsedMod.Items.RubikDiceScrambled1,
EclipsedMod.Items.RubikDiceScrambled2,
EclipsedMod.Items.RubikDiceScrambled3,
EclipsedMod.Items.RubikDiceScrambled4,
EclipsedMod.Items.RubikDiceScrambled5
}

EclipsedMod.BG = {} -- bleeding grimoire
EclipsedMod.BG.FrameCount = 62 -- frame count to remove bleeding from enemies (bleeding will be removed on 0, it wouldn't apply anew until framecount == -25)
EclipsedMod.BG.Costume = Isaac.GetCostumeIdByPath("gfx/characters/bleedinggrimoire.anm2")

EclipsedMod.BlackBook = {}
EclipsedMod.BlackBook.Duration = 162 -- duration of status effect
EclipsedMod.BlackBook.Forever = 10000
EclipsedMod.BlackBook.EffectFlags = { -- possible effects
	{EntityFlag.FLAG_FREEZE, Color(0.5, 0.5, 0.5, 1, 0, 0, 0), EclipsedMod.BlackBook.Duration}, -- effect, color, duration
	{EntityFlag.FLAG_POISON, Color(0.4, 0.97, 0.5, 1, 0, 0, 0), EclipsedMod.BlackBook.Duration},
	{EntityFlag.FLAG_SLOW, Color(0.15, 0.15, 0.15, 1, 0, 0, 0), EclipsedMod.BlackBook.Duration},
	{EntityFlag.FLAG_CHARM, Color(1, 0, 1, 1, 0.196, 0, 0), EclipsedMod.BlackBook.Duration},
	{EntityFlag.FLAG_CONFUSION, Color(0.5, 0.5, 0.5, 1, 0, 0, 0), EclipsedMod.BlackBook.Duration},
	{EntityFlag.FLAG_MIDAS_FREEZE, Color(2, 1, 0, 1, 0, 0, 0), EclipsedMod.BlackBook.Duration},
	{EntityFlag.FLAG_FEAR, Color(0.6, 0.4, 1.0, 1.0, 0, 0, 0), EclipsedMod.BlackBook.Duration},
	{EntityFlag.FLAG_BURN, Color(1, 1, 1, 1, 0.3, 0, 0), EclipsedMod.BlackBook.Duration},
	{EntityFlag.FLAG_SHRINK, Color(1, 1, 1, 1, 0, 0, 0), EclipsedMod.BlackBook.Duration},
	{EntityFlag.FLAG_BLEED_OUT, Color(1.25, 0.05, 0.15, 1, 0, 0, 0), EclipsedMod.BlackBook.Forever},
	{EntityFlag.FLAG_ICE, Color(1, 1, 3, 1, 0, 0, 0), EclipsedMod.BlackBook.Forever},
	{EntityFlag.FLAG_MAGNETIZED, Color(0.6, 0.4, 1.0, 1.0, 0, 0, 0), EclipsedMod.BlackBook.Forever},
	{EntityFlag.FLAG_BAITED, Color(0.7, 0.14, 0.1, 1, 0.3, 0, 0), EclipsedMod.BlackBook.Forever},
}

EclipsedMod.FloppyDisk = {}
--EclipsedMod.FloppyDisk.Items = {} -- for saved items
--savetable.FloppyDiskItems = savetable.FloppyDiskItems or {}
EclipsedMod.FloppyDisk.MissingNo = true -- add missingNo if not found saved item

EclipsedMod.MiniPony = {}
EclipsedMod.MiniPony.Costume = Isaac.GetCostumeIdByPath("gfx/characters/minipony.anm2")
EclipsedMod.MiniPony.MoveSpeed = 1.5 -- locked speed while holding

EclipsedMod.VHS = {} -- don not delete

EclipsedMod.KeeperMirror = {}
EclipsedMod.KeeperMirror.Target = Isaac.GetEntityVariantByName("mTarget")
EclipsedMod.KeeperMirror.TargetRadius = 10
EclipsedMod.KeeperMirror.TargetTimeout = 80 -- target will be removed when == 0. spawn coin
EclipsedMod.KeeperMirror.RedHeart = 3 -- price of items
EclipsedMod.KeeperMirror.HalfHeart = 2
EclipsedMod.KeeperMirror.Collectible = 15
EclipsedMod.KeeperMirror.NormalPickup = 5
EclipsedMod.KeeperMirror.DoublePickup = 7
EclipsedMod.KeeperMirror.DoubleHeart = 6
EclipsedMod.KeeperMirror.RKey = 99
EclipsedMod.KeeperMirror.MicroBattery = 3
EclipsedMod.KeeperMirror.MegaBattery = 7
EclipsedMod.KeeperMirror.GrabBag = 7
EclipsedMod.KeeperMirror.GiantPill = 7

EclipsedMod.StrangeBox = {}
EclipsedMod.StrangeBox.Variants = { -- pickup variants
PickupVariant.PICKUP_HEART, PickupVariant.PICKUP_COIN, PickupVariant.PICKUP_KEY, PickupVariant.PICKUP_BOMB,
PickupVariant.PICKUP_CHEST, PickupVariant.PICKUP_BOMBCHEST, PickupVariant.PICKUP_SPIKEDCHEST,
PickupVariant.PICKUP_ETERNALCHEST, PickupVariant.PICKUP_MIMICCHEST, PickupVariant.PICKUP_OLDCHEST,
PickupVariant.PICKUP_WOODENCHEST, PickupVariant.PICKUP_MEGACHEST, PickupVariant.PICKUP_HAUNTEDCHEST,
PickupVariant.PICKUP_LOCKEDCHEST, PickupVariant.PICKUP_GRAB_BAG, PickupVariant.PICKUP_REDCHEST,
PickupVariant.PICKUP_PILL, PickupVariant.PICKUP_LIL_BATTERY, PickupVariant.PICKUP_TAROTCARD,
PickupVariant.PICKUP_TRINKET
}

EclipsedMod.CharonObol = {}
EclipsedMod.CharonObol.Timeout = 360

EclipsedMod.Lobotomy = {}
EclipsedMod.Lobotomy.ErasedEntities = {}

EclipsedMod.SecretLoveLetter.AffectedEnemies = {}
end
--- CARDS --
do

EclipsedMod.DeliObject = {}
EclipsedMod.DeliObject.CycleTimer = 150 -- 30 frames ~ 1 second
EclipsedMod.DeliObject.Chance = 0.1
EclipsedMod.DeliObject.CheckGetCard = {
	[EclipsedMod.Pickups.DeliObjectCell] = true,
	[EclipsedMod.Pickups.DeliObjectBomb] = true,
	[EclipsedMod.Pickups.DeliObjectKey] = true,
	[EclipsedMod.Pickups.DeliObjectCard] = true,
	[EclipsedMod.Pickups.DeliObjectPill] = true,
	[EclipsedMod.Pickups.DeliObjectRune] = true,
	[EclipsedMod.Pickups.DeliObjectHeart] = true,
	[EclipsedMod.Pickups.DeliObjectCoin] = true,
	[EclipsedMod.Pickups.DeliObjectBattery] = true,
}
EclipsedMod.DeliObject.Variants = {
	EclipsedMod.Pickups.DeliObjectCell,
	EclipsedMod.Pickups.DeliObjectBomb,
	EclipsedMod.Pickups.DeliObjectKey,
	EclipsedMod.Pickups.DeliObjectCard,
	EclipsedMod.Pickups.DeliObjectPill,
	EclipsedMod.Pickups.DeliObjectRune,
	EclipsedMod.Pickups.DeliObjectHeart,
	EclipsedMod.Pickups.DeliObjectCoin,
	EclipsedMod.Pickups.DeliObjectBattery,
}
EclipsedMod.DeliObject.TrollCBombChance = 0.1
EclipsedMod.DeliObject.BombFlags = {
TearFlags.TEAR_HOMING,
TearFlags.TEAR_POISON,
TearFlags.TEAR_BURN,
TearFlags.TEAR_ATTRACTOR,
TearFlags.TEAR_SAD_BOMB,
TearFlags.TEAR_SCATTER_BOMB,
TearFlags.TEAR_BUTT_BOMB,
TearFlags.TEAR_GLITTER_BOMB,
TearFlags.TEAR_STICKY,
TearFlags.TEAR_CROSS_BOMB,
TearFlags.TEAR_CREEP_TRAIL,
TearFlags.TEAR_BLOOD_BOMB,
TearFlags.TEAR_BRIMSTONE_BOMB,
TearFlags.TEAR_GHOST_BOMB,
TearFlags.TEAR_ICE,
TearFlags.TEAR_REROLL_ENEMY,
TearFlags.TEAR_RIFT,
--TearFlags.TEAR_GIGA_BOMB,
}

EclipsedMod.MultiCast = {}
EclipsedMod.MultiCast.NumWisps = 3 -- multi cast card number of wisps to spawn

EclipsedMod.Corruption = {}
EclipsedMod.Corruption.CostumeHead = Isaac.GetCostumeIdByPath("gfx/characters/corruptionhead.anm2")

EclipsedMod.Offering = {}
EclipsedMod.Offering.DamageNum = 2 -- take num heart damage (2 == full heart)

EclipsedMod.OblivionCard = {}
EclipsedMod.OblivionCard.TearVariant =  TearVariant.CHAOS_CARD --Isaac.GetEntityVariantByName("Oblivion Card Tear")--
EclipsedMod.OblivionCard.SpritePath = "gfx/oblivioncardtear.png"
EclipsedMod.OblivionCard.ErasedEntities = {} -- save erased entities
EclipsedMod.OblivionCard.PoofColor = Color(0.5,1,2,1,0,0,0) -- light blue

EclipsedMod.Apocalypse = {}
EclipsedMod.Apocalypse.Room = nil -- room where it was used (room index)
EclipsedMod.Apocalypse.RNG = nil -- rng of card

EclipsedMod.KingChess = {}
EclipsedMod.KingChess.RadiusStonePoop = 40
EclipsedMod.KingChess.Radius = 48 -- 50 >= x >= 45

EclipsedMod.InfiniteBlades = {}
EclipsedMod.InfiniteBlades.newSpritePath = "gfx/effects/effect_momsknife.png"
EclipsedMod.InfiniteBlades.MaxNumber = 7 -- max number of knife tears
EclipsedMod.InfiniteBlades.VelocityMulti = 15 -- velocity multiplier
EclipsedMod.InfiniteBlades.DamageMulti = 3.0 -- deal multiplied damage (player.Damage * DamageMulti)

EclipsedMod.DeuxEx = {}
EclipsedMod.DeuxEx.LuckUp = 100 -- value of luck to add

EclipsedMod.BannedCard = {}
EclipsedMod.BannedCard.NumCards = 2
EclipsedMod.BannedCard.Chance = 0.01

EclipsedMod.RubikCubelet = {}
EclipsedMod.RubikCubelet.TriggerChance = 0.33

EclipsedMod.GhostGem = {}
EclipsedMod.GhostGem.NumSouls = 4

EclipsedMod.ZeroStoneUsed = false

EclipsedMod.RedPills = {}
--EclipsedMod.RedPills.RedEffect = Isaac.GetPillEffectByName("Side effects?") -- "Ultra-reality"
EclipsedMod.RedPills.DamageUp = 10.8 -- dmg up
EclipsedMod.RedPills.HorseDamageUp = 2 * EclipsedMod.RedPills.DamageUp
EclipsedMod.RedPills.DamageDown = 0.00001 -- init damage down by time (red stew effect)
EclipsedMod.RedPills.DamageDownTick = 0.00001 -- increment of DamageDown
EclipsedMod.RedPills.WavyCap = 1 -- layers of Wavy Cap effect. will be saved until DamageUp > 0
EclipsedMod.RedPills.HorseWavyCap = 2 * EclipsedMod.RedPills.WavyCap
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
	for dimension = 0, 2 do -- -1 current dim. 0 - normal dim. 1 - secondary dim (downpoor, mines). 2 - death certificate dim
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
	local collectible = 1 -- sad onion
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
local function DebugSpawn(var, subtype, position, marg, velocity)
	--- spawn pickup near given position
	velocity = velocity or Vector.Zero
	marg = marg or 0
	position = position or game:GetRoom():GetCenterPos()
	Isaac.Spawn(EntityType.ENTITY_PICKUP, var, subtype, Isaac.GetFreeNearPosition(position, marg), velocity, nil)
end
-- drop any used card if debug is active
function EclipsedMod:onAnyCard(card, player, useFlag)
	if debug and useFlag & myUseFlags == 0 and useFlag & myUseFlags2 == 0 then
		DebugSpawn(PickupVariant.PICKUP_TAROTCARD, card, player.Position)
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onAnyCard)
-- debug call at the start of run
local function InitDebugCall()
	--- for debug, spawn all items and etc.
	Isaac.ExecuteCommand("debug 8")
	Isaac.ExecuteCommand("debug 7")
	Isaac.ExecuteCommand("debug 9")
	Isaac.ExecuteCommand("debug 3")
	-- 100 = PickupVariant.PICKUP_COLLECTIBLE
	DebugSpawn(100, EclipsedMod.Items.FloppyDisk)
	DebugSpawn(100, EclipsedMod.Items.RedMirror)
	DebugSpawn(100, EclipsedMod.Items.BlackKnight)
	DebugSpawn(100, EclipsedMod.Items.WhiteKnight)
	DebugSpawn(100, EclipsedMod.Items.KeeperMirror)
	DebugSpawn(100, EclipsedMod.Items.MiniPony)
	DebugSpawn(100, EclipsedMod.Items.StrangeBox)
	--DebugSpawn(100, EclipsedMod.Items.Pizza)
	DebugSpawn(100, EclipsedMod.Items.LostMirror)
	DebugSpawn(100, EclipsedMod.Items.BleedingGrimoire)
	DebugSpawn(100, EclipsedMod.Items.BlackBook)
	DebugSpawn(100, EclipsedMod.Items.RubikDice)
	DebugSpawn(100, EclipsedMod.Items.VHSCassette)
	DebugSpawn(100, EclipsedMod.Items.LongElk)
	DebugSpawn(100, EclipsedMod.Items.Threshold)
	DebugSpawn(100, EclipsedMod.Items.CharonObol)
	DebugSpawn(100, EclipsedMod.Items.BookMemory)
	DebugSpawn(100, EclipsedMod.Items.CosmicJam)
	DebugSpawn(100, EclipsedMod.Items.MongoCells) -- fcuk u
	DebugSpawn(100, EclipsedMod.Items.MeltedCandle)
	DebugSpawn(100, EclipsedMod.Items.IvoryOil)
	DebugSpawn(100, EclipsedMod.Items.RedLotus)
	DebugSpawn(100, EclipsedMod.Items.MidasCurse)
	DebugSpawn(100, EclipsedMod.Items.RubberDuck)
	DebugSpawn(100, EclipsedMod.Items.RedButton)
	DebugSpawn(100, EclipsedMod.Items.CompoBombs)
	DebugSpawn(100, EclipsedMod.Items.Limb)
	DebugSpawn(100, EclipsedMod.Items.GravityBombs)
	DebugSpawn(100, EclipsedMod.Items.MirrorBombs)
	DebugSpawn(100, EclipsedMod.Items.FrostyBombs)
	DebugSpawn(100, EclipsedMod.Items.VoidKarma)
	DebugSpawn(100, EclipsedMod.Items.Viridian)
	DebugSpawn(100, EclipsedMod.Items.RedBag)
	DebugSpawn(100, EclipsedMod.Items.Lililith)
	DebugSpawn(100, EclipsedMod.Items.AbihuFam)
	DebugSpawn(100, EclipsedMod.Items.NadabBrain)
	DebugSpawn(100, EclipsedMod.Items.NadabBody)
	DebugSpawn(100, EclipsedMod.Items.DMS)
	DebugSpawn(100, EclipsedMod.Items.MewGen)
	DebugSpawn(100, EclipsedMod.Items.ElderSign)
	DebugSpawn(100, EclipsedMod.Items.Eclipse)
	DebugSpawn(100, EclipsedMod.Items.DiceBombs)
	--DebugSpawn(100, EclipsedMod.Items.LilGagger)
	--DebugSpawn(100, EclipsedMod.Items.Zooma)
	DebugSpawn(100, EclipsedMod.Items.WitchPot)
	DebugSpawn(100, EclipsedMod.Items.SecretLoveLetter)
	DebugSpawn(100, EclipsedMod.Items.PandoraJar)
	--DebugSpawn(100, EclipsedMod.Items.Eyekeye)
	--DebugSpawn(100, EclipsedMod.Items.BasementThrone)
	--DebugSpawn(100, EclipsedMod.Items.DeliriumJr)
	--DebugSpawn(100, EclipsedMod.Items.AngelCore)
	--DebugSpawn(100, EclipsedMod.Items.AgonyBox)

	--350 = PickupVariant.PICKUP_TRINKET
	DebugSpawn(350, EclipsedMod.Trinkets.LostFlower)
	DebugSpawn(350, EclipsedMod.Trinkets.WitchPaper)
	DebugSpawn(350, EclipsedMod.Trinkets.Duotine)
	DebugSpawn(350, EclipsedMod.Trinkets.RedScissors)
	DebugSpawn(350, EclipsedMod.Trinkets.TeaBag)
	DebugSpawn(350, EclipsedMod.Trinkets.MilkTeeth)
	DebugSpawn(350, EclipsedMod.Trinkets.BobTongue)
	DebugSpawn(350, EclipsedMod.Trinkets.QueenSpades)
	DebugSpawn(350, EclipsedMod.Trinkets.MemoryFragment)
	DebugSpawn(350, EclipsedMod.Trinkets.AbyssCart)
	DebugSpawn(350, EclipsedMod.Trinkets.TeaFungus)
	DebugSpawn(350, EclipsedMod.Trinkets.BinderClip)
	DebugSpawn(350, EclipsedMod.Trinkets.RubikCubelet)
	DebugSpawn(350, EclipsedMod.Trinkets.DeadEgg)
	DebugSpawn(350, EclipsedMod.Trinkets.Penance)
	DebugSpawn(350, EclipsedMod.Trinkets.Pompom)
	DebugSpawn(350, EclipsedMod.Trinkets.XmasLetter)

	-- 300 = PickupVariant.PICKUP_TAROTCARD
	DebugSpawn(300, EclipsedMod.Pickups.RedPill)
	DebugSpawn(300, EclipsedMod.Pickups.RedHorsePill)
	DebugSpawn(300, EclipsedMod.Pickups.OblivionCard)
	DebugSpawn(300, EclipsedMod.Pickups.Trapezohedron)
	DebugSpawn(300, EclipsedMod.Pickups.KingChess)
	DebugSpawn(300, EclipsedMod.Pickups.KingChessW)
	DebugSpawn(300, EclipsedMod.Pickups.Apocalypse)
	DebugSpawn(300, EclipsedMod.Pickups.SoulUnbidden)
	DebugSpawn(300, EclipsedMod.Pickups.AscenderBane)
	DebugSpawn(300, EclipsedMod.Pickups.SoulNadabAbihu)
	DebugSpawn(300, EclipsedMod.Pickups.Wish)
	DebugSpawn(300, EclipsedMod.Pickups.Offering)
	DebugSpawn(300, EclipsedMod.Pickups.InfiniteBlades)
	DebugSpawn(300, EclipsedMod.Pickups.Transmutation)
	DebugSpawn(300, EclipsedMod.Pickups.RitualDagger)
	DebugSpawn(300, EclipsedMod.Pickups.Fusion)
	DebugSpawn(300, EclipsedMod.Pickups.DeuxEx)
	DebugSpawn(300, EclipsedMod.Pickups.Adrenaline)
	DebugSpawn(300, EclipsedMod.Pickups.GhostGem)
	DebugSpawn(300, EclipsedMod.Pickups.Corruption)
	DebugSpawn(300, EclipsedMod.Pickups.MultiCast)
	DebugSpawn(300, EclipsedMod.Pickups.BattlefieldCard)
	DebugSpawn(300, EclipsedMod.Pickups.TreasuryCard)
	DebugSpawn(300, EclipsedMod.Pickups.BookeryCard)
	DebugSpawn(300, EclipsedMod.Pickups.BloodGroveCard)
	DebugSpawn(300, EclipsedMod.Pickups.StormTempleCard)
	DebugSpawn(300, EclipsedMod.Pickups.ArsenalCard)
	DebugSpawn(300, EclipsedMod.Pickups.OutpostCard)
	DebugSpawn(300, EclipsedMod.Pickups.ZeroMilestoneCard)
	DebugSpawn(300, EclipsedMod.Pickups.Domino16)
	DebugSpawn(300, EclipsedMod.Pickups.Domino25)
	DebugSpawn(300, EclipsedMod.Pickups.Domino34)
	DebugSpawn(300, EclipsedMod.Pickups.Domino00)
	DebugSpawn(300, EclipsedMod.Pickups.Decay)
	DebugSpawn(300, EclipsedMod.Pickups.MazeMemoryCard)
	DebugSpawn(300, EclipsedMod.Pickups.BannedCard)
	DebugSpawn(300, EclipsedMod.Pickups.CryptCard)
	DebugSpawn(300, EclipsedMod.Pickups.DeliObjectCell)
	--DebugSpawn(300, EclipsedMod.Pickups.DeliObjectBomb)
	--DebugSpawn(300, EclipsedMod.Pickups.DeliObjectKey)
	--DebugSpawn(300, EclipsedMod.Pickups.DeliObjectCard)
	--DebugSpawn(300, EclipsedMod.Pickups.DeliObjectPill)
	--DebugSpawn(300, EclipsedMod.Pickups.DeliObjectRune)
	--DebugSpawn(300, EclipsedMod.Pickups.DeliObjectHeart)
	--DebugSpawn(300, EclipsedMod.Pickups.DeliObjectCoin)
	--DebugSpawn(300, EclipsedMod.Pickups.DeliObjectBattery)
	--DebugSpawn(300, EclipsedMod.Pickups.Domino12)
end
-- init some variables
local function InitCall()
	--- init call on new game start
	EclipsedMod.OblivionCard.ErasedEntities = {}
	EclipsedMod.Lobotomy.ErasedEntities = {}
	EclipsedMod.SecretLoveLetter.AffectedEnemies = {}
	EclipsedMod.Lililith.DemonSpawn = { -- familiars that can be spawned by lililith
	{CollectibleType.COLLECTIBLE_DEMON_BABY, FamiliarVariant.DEMON_BABY, 0}, -- item. familiar. count
	{CollectibleType.COLLECTIBLE_LIL_BRIMSTONE, FamiliarVariant.LIL_BRIMSTONE, 0},
	{CollectibleType.COLLECTIBLE_LIL_ABADDON, FamiliarVariant.LIL_ABADDON, 0},
	{CollectibleType.COLLECTIBLE_INCUBUS, FamiliarVariant.INCUBUS, 0},
	{CollectibleType.COLLECTIBLE_SUCCUBUS, FamiliarVariant.SUCCUBUS, 0},
	{CollectibleType.COLLECTIBLE_LEECH, FamiliarVariant.LEECH, 0},
	--{CollectibleType.COLLECTIBLE_TWISTED_PAIR, FamiliarVariant.TWISTED_BABY, 0},
	}
	EclipsedMod.VHS.tableVHS = {
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
	{'12'} -- void
	}

	EclipsedMod.DeliriumBeggar.Enemies = {
		{EntityType.ENTITY_GAPER, 0}
	}
	EclipsedMod.DeliriumBeggar.Enable = {
		[tostring(EntityType.ENTITY_GAPER..0)] = true
	}
end
-- remove add trinket
local function TrinketRemoveAdd(player, newTrinket)
	--- gulp given trinket
	local t0 = player:GetTrinket(0) -- 0 - first slot
	local t1 = player:GetTrinket(1) -- 1 - second slot
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
	local t0 = player:GetTrinket(0) -- 0 - first slot
	local t1 = player:GetTrinket(1)  -- 1 - second slot
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
	local randomVector = RandomVector()*5 --RandomVector() - Returns a random vector with length 1. Multiply this vector by a number for larger random vectors.
	local throwTrinket = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, trinket, player.Position, randomVector, player):ToPickup()
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
	data.RedPillDamageDown = EclipsedMod.RedPills.DamageDown
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
	data.CheckTimer = data.CheckTimer or EclipsedMod.MewGen.ActivationTimer
	if player:GetFireDirection() == Direction.NO_DIRECTION then
		--print(game:GetFrameCount(), game:GetFrameCount() - data.MewGenTimer)
		if game:GetFrameCount() - data.MewGenTimer >= data.CheckTimer then --EclipsedMod.MewGen.ActivationTimer
			data.MewGenTimer = game:GetFrameCount()
			player:UseActiveItem(CollectibleType.COLLECTIBLE_TELEKINESIS, myUseFlags)
			data.CheckTimer = EclipsedMod.MewGen.RechargeTimer
		end
	else
		data.MewGenTimer = game:GetFrameCount()
		data.CheckTimer = EclipsedMod.MewGen.ActivationTimer
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
				--table.insert(EclipsedMod.FloppyDisk.Items, id)
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
	--for _, itemID in pairs(EclipsedMod.FloppyDisk.Items) do
	for _, itemID in pairs(savetable.FloppyDiskItems) do
		if itemID <= allItems then -- (I guess it can give you wrong items by stored id, if you add/remove mods after saving mod data)
			player:AddCollectible(itemID) -- give items from saved table
		else -- if saved item id is higher than current number of all items in the game
			if EclipsedMod.FloppyDisk.MissingNo then
				player:AddCollectible(CollectibleType.COLLECTIBLE_MISSING_NO) -- give you missing no...
			end
		end
	end
	--EclipsedMod.FloppyDisk.Items = {} -- empty saved items
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
					grid:SetVariant(3) -- 3 is golden poop
					grid:Init(rng:RandomInt(Random())+1)
					grid:PostInit()
					grid:Update()
				end
			end
		end
	end
end
local function TurnPickupsGold(pickup) -- midas
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
	if newSubType ~= pickup.SubType  then
		pickup:ToPickup():Morph(pickup.Type, pickup.Variant, newSubType, true)
	elseif isChest then
		pickup:ToPickup():Morph(pickup.Type, isChest, 0, true)
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
	local point = radius*math.cos(math.rad(45)) -- 45 degree angle
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
local function BlastDamage(radius, damage, knockback, player) -- player:GetCollectibleRNG(EclipsedMod.Items.BlackKnight)
	--- crush when land
	local room = game:GetRoom()
	for _, entity in pairs(Isaac.GetRoomEntities()) do
		if entity.Position:Distance(player.Position) <= radius then
			if entity:IsVulnerableEnemy() and entity:IsActiveEnemy() then
				entity:TakeDamage(damage, DamageFlag.DAMAGE_EXPLOSION | DamageFlag.DAMAGE_CRUSH, EntityRef(player), 0)
				entity.Velocity = (entity.Position - player.Position):Resized(knockback)
			elseif entity.Type == EntityType.ENTITY_FIREPLACE and entity.Variant ~= 4 then -- 4 is white fireplace
				entity:Die()
			elseif entity.Type == EntityType.ENTITY_MOVABLE_TNT then
				entity:Die()
			elseif ((entity.Type == EntityType.ENTITY_FAMILIAR and entity.Variant == FamiliarVariant.CUBE_BABY) or (entity.Type == EntityType.ENTITY_BOMB)) then
				entity.Velocity = (entity.Position - player.Position):Resized(knockback)
			elseif (entity.Type == EntityType.ENTITY_SHOPKEEPER and not entity:GetData().EID_Pathfinder) or EclipsedMod.BlackKnight.StonEnemies[entity.Type] then
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
		if pickup.SubType ~= 0 then num = EclipsedMod.KeeperMirror.Collectible end
		if pickup.SubType == CollectibleType.COLLECTIBLE_R_KEY then num = EclipsedMod.KeeperMirror.RKey end
	elseif pickup.Variant == PickupVariant.PICKUP_HEART then
		if pickup.SubType == HeartSubType.HEART_GOLDEN then
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_GOLDEN, pickup.Position, Vector.Zero, player)
			return -1
		end
		num = EclipsedMod.KeeperMirror.NormalPickup
		if pickup.SubType == HeartSubType.HEART_FULL then num = EclipsedMod.KeeperMirror.RedHeart end
		if pickup.SubType == HeartSubType.HEART_HALF then num = EclipsedMod.KeeperMirror.HalfHeart end
		if pickup.SubType == HeartSubType.HEART_DOUBLEPACK then num = EclipsedMod.KeeperMirror.DoubleHeart end
		if pickup.SubType == HeartSubType.HEART_HALF_SOUL then num = EclipsedMod.KeeperMirror.HalfHeart end
	elseif pickup.Variant == PickupVariant.PICKUP_KEY then
		if pickup.SubType == KeySubType.KEY_GOLDEN then
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_GOLDEN, pickup.Position, Vector.Zero, player)
			return -1
		end
		num = EclipsedMod.KeeperMirror.NormalPickup
		if pickup.SubType == KeySubType.KEY_DOUBLEPACK then num = EclipsedMod.KeeperMirror.DoublePickup end
		if pickup.SubType == KeySubType.KEY_CHARGED then num = EclipsedMod.KeeperMirror.NormalPickup end
	elseif pickup.Variant == PickupVariant.PICKUP_BOMB then
		if pickup.SubType ~= BombSubType.BOMB_TROLL or pickup.SubType ~= BombSubType.BOMB_SUPERTROLL or pickup.SubType ~= BombSubType.BOMB_GOLDENTROLL then
			if pickup.SubType == BombSubType.BOMB_GOLDEN then
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_GOLDEN, pickup.Position, Vector.Zero, player)
				return -1
			end
			num = EclipsedMod.KeeperMirror.NormalPickup
			if pickup.SubType == BombSubType.BOMB_DOUBLEPACK or pickup.SubType == BombSubType.BOMB_GIGA then
				num = EclipsedMod.KeeperMirror.DoublePickup
			end
		end
	elseif pickup.Variant == PickupVariant.PICKUP_THROWABLEBOMB or pickup.Variant == PickupVariant.PICKUP_POOP then
		num = EclipsedMod.KeeperMirror.NormalPickup
	elseif pickup.Variant == PickupVariant.PICKUP_GRAB_BAG then
		num = EclipsedMod.KeeperMirror.GrabBag
	elseif pickup.Variant == PickupVariant.PICKUP_PILL then
		if pickup.SubType == PillColor.PILL_GOLD then Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_GOLDEN, pickup.Position, Vector.Zero, player)
			return -1
		end
		num = EclipsedMod.KeeperMirror.NormalPickup
		if pickup.SubType >= PillColor.PILL_GIANT_FLAG then num = EclipsedMod.KeeperMirror.GiantPill end
	elseif pickup.Variant == PickupVariant.PICKUP_LIL_BATTERY then
		if pickup.SubType == BatterySubType.BATTERY_GOLDEN then
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_GOLDEN, pickup.Position, Vector.Zero, player)
			return -1
		end
		num = EclipsedMod.KeeperMirror.NormalPickup
		if pickup.SubType >= BatterySubType.BATTERY_MICRO then num = EclipsedMod.KeeperMirror.MicroBattery end
		if pickup.SubType >= BatterySubType.BATTERY_MEGA then num = EclipsedMod.KeeperMirror.MegaBattery end
	elseif pickup.Variant == PickupVariant.PICKUP_TAROTCARD then
		num = EclipsedMod.KeeperMirror.NormalPickup
	elseif pickup.Variant == PickupVariant.PICKUP_TRINKET then
		if pickup.SubType >= TrinketType.TRINKET_GOLDEN_FLAG then
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_GOLDEN, pickup.Position, Vector.Zero, player)
			return -1
		end
		num = EclipsedMod.KeeperMirror.NormalPickup
	end
	return num
end
---Red Scissors
local function RedBombReplace(bomb)
	--- replace bomb by throwable bomb
	bomb:Remove()
	if bomb.Variant == BombVariant.BOMB_GIGA then
		for _ = 1, EclipsedMod.RedScissors.GigaBombsSplitNum do
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_THROWABLEBOMB, 0, bomb.Position, RandomVector()*5, nil)
		end
	else
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_THROWABLEBOMB, 0, bomb.Position, bomb.Velocity, nil)
	end
	local effect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, bomb.Position, Vector.Zero, nil)
	effect:SetColor(EclipsedMod.RedColor, 50, 1, false, false)
end
---Red Button
local function RemoveRedButton(room)
	--- remove pressure plate spawned by red button
	for gridIndex = 1, room:GetGridSize() do -- get room size
		local grid = room:GetGridEntity(gridIndex)
		if grid then -- check if there is any grid
			if grid.VarData == EclipsedMod.RedButton.VarData then -- check if button is spawned by red button
				room:RemoveGridEntity(gridIndex, 0, false) -- remove it
				grid:Update()
				local effect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, grid.Position, Vector.Zero, nil)
				effect:SetColor(EclipsedMod.RedColor, 50, 1, false, false) -- spawn poof effect
			end
		end
	end
end
local function SpawnButton(player, room)
	--- spawn new pressure plate
	local pos -- new position for button
	local subtype = 4 -- empty button, do nothing
	local spawned = false -- check for button spawn
	local rng = player:GetCollectibleRNG(EclipsedMod.Items.RedButton) -- get rng
	local randNum = rng:RandomFloat()  --RandomInt(100) --+ player.Luck -- get random int to decide what type of button to spawn
	local killChance = randNum + player.Luck/100
	if killChance < 0.02 then killChance = 0.02 end
	if killChance >= EclipsedMod.RedButton.KillButtonChance then
		subtype = 9 -- killer button
	elseif randNum >= EclipsedMod.RedButton.EventButtonChance then
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
		button.VarData = EclipsedMod.RedButton.VarData
		local mySprite = button:GetSprite()  -- replace sprite to red button
		mySprite:ReplaceSpritesheet(0, EclipsedMod.RedButton.SpritePath)
		mySprite:LoadGraphics() -- replace sprite
	end
end
local function NewRoomRedButton(player, room)
	--- check for new room, spawn or remove pressure plate; (remove button when re-enter the `teleported_from_room`)
	EclipsedMod.RedButton.PressCount = 0
	if room:IsFirstVisit() then -- if room visited first time
		SpawnButton(player, room) -- spawn new button
	else --if not room:IsClear() then
		RemoveRedButton(room) -- remove button if there is left any button (ex: if you teleported while room is uncleared)
		SpawnButton(player, room)
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
		player:AnimateCollectible(item, "UseItem")
	end
end
---Lililith
local function LililithReset()
	--- reset lililith
	if #Isaac.FindByType(EntityType.ENTITY_FAMILIAR, EclipsedMod.Lililith.Variant) > 0 then
		for _, fam in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, EclipsedMod.Lililith.Variant)) do
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
--[[
local function SesameOpen(room, level, player)
	--- open all doors in boss room
	if room:GetType() == RoomType.ROOM_BOSS and room:IsClear() then
		local curTime = game:GetFrameCount()
		local minutes = math.floor(curTime/30/60)%60 -- get time by minutes
		--print(minutes)
		-- try open all doors
		for gridIndex = 1, room:GetGridSize() do
			if room:GetGridEntity(gridIndex) then
				if room:GetGridEntity(gridIndex):ToDoor() then
					room:GetGridEntity(gridIndex):ToDoor():Open()
					--room:GetGridEntity(gridIndex):ToDoor():(player, true)
				end
			end
		end
		if level:GetStage() == LevelStage.STAGE3_2 and minutes > 20 then -- 20 minutes
			room:TrySpawnBossRushDoor(true, false)
			player:AnimateTrinket(EclipsedMod.Trinkets.QueenSpades)
			--player:TryRemoveTrinket(EclipsedMod.Trinkets.QueenSpades)
		elseif level:GetStage() == LevelStage.STAGE4_2 and minutes > 30  then -- 30 minutes
			room:TrySpawnBlueWombDoor(true, true, false)
			player:AnimateTrinket(EclipsedMod.Trinkets.QueenSpades)
			--player:TryRemoveTrinket(EclipsedMod.Trinkets.QueenSpades)
		end
	end
end
--]]
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
		roomCenter = Vector(580,420) -- get 2x2 room center
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
	bomb:SetExplosionCountdown(EclipsedMod.CompoBombs.BasicCountdown)
	if player:HasTrinket(TrinketType.TRINKET_SHORT_FUSE) then
		bomb:SetExplosionCountdown(EclipsedMod.CompoBombs.ShortCountdown)
	elseif bomb.Parent:ToBomb().IsFetus then
		bomb:SetExplosionCountdown(EclipsedMod.CompoBombs.FetusCountdown)
	end
	if bomb.Parent:ToBomb().IsFetus and player:HasTrinket(TrinketType.TRINKET_SHORT_FUSE) then
		bomb:SetExplosionCountdown(EclipsedMod.CompoBombs.FetusCountdown/2) -- short fuse shortens countdown to half
	end
end
---Dice Bombs
local function InitDiceyBomb(bomb, bombData)
	bombData.Dicey = true
	bomb:AddTearFlags(TearFlags.TEAR_REROLL_ENEMY)
end
local function DiceyReroll(rng, bombPos, radius)
	local pickups = Isaac.FindInRadius(bombPos, radius, EntityPartition.PICKUP)
	for _, pickup in pairs(pickups) do
		if pickup.Type ~= EntityType.ENTITY_SLOT then
			pickup = pickup:ToPickup()
			--if not pickup:IsShopItem() then
				if pickup.Variant == PickupVariant.PICKUP_COLLECTIBLE then
					if pickup.SubType ~= 0 then
						local pool = itemPool:GetPoolForRoom(game:GetRoom():GetType(), game:GetRoom():GetAwardSeed())
						local newItem = itemPool:GetCollectible(pool, true)
						pickup:Morph(pickup.Type, pickup.Variant, newItem, true)
						Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, pickup.Position, Vector.Zero, nil).Color = EclipsedMod.RedColor
					end
				else
					local reroll = true
					if pickup.Variant == PickupVariant.PICKUP_CHEST or pickup.Variant == PickupVariant.PICKUP_BOMBCHEST or pickup.Variant == PickupVariant.PICKUP_SPIKEDCHEST or pickup.Variant == PickupVariant.PICKUP_ETERNALCHEST or pickup.Variant == PickupVariant.PICKUP_MIMICCHEST or pickup.Variant == PickupVariant.PICKUP_OLDCHEST or pickup.Variant == PickupVariant.PICKUP_WOODENCHEST or pickup.Variant == PickupVariant.PICKUP_HAUNTEDCHEST or pickup.Variant == PickupVariant.PICKUP_REDCHEST then
						if pickup.SubType == 0 then
							reroll = false
						end
					end
					if reroll then
						
						local var = EclipsedMod.DiceBombs.PickupsTable [rng:RandomInt(#EclipsedMod.DiceBombs.PickupsTable )+1]
						if var == PickupVariant.PICKUP_CHEST then --and pickup.SubType == 0 then -- if chest
							var = EclipsedMod.DiceBombs.ChestsTable[rng:RandomInt(#EclipsedMod.DiceBombs.ChestsTable)+1]
						end
						
						pickup:Morph(pickup.Type, var, 0, true)
						Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, pickup.Position, Vector.Zero, nil).Color = EclipsedMod.RedColor
					end
				end
			--end
		end
	end
end
---Frost Bombs
local function InitFrostyBomb(bomb, bombData)
	--- apply effect of ice cube bomb
	bombData.Frosty = true
	--bomb:AddEntityFlags(EntityFlag.FLAG_ICE)  --useless to add
	bomb:AddTearFlags(EclipsedMod.FrostyBombs.Flags)
	bombData.CreepVariant = EffectVariant.PLAYER_CREEP_HOLYWATER_TRAIL
	
	if bomb:HasTearFlags(TearFlags.TEAR_GLITTER_BOMB) then
		bombData.FrostyCreepColor = EclipsedMod.PinkColor
	elseif bomb:HasTearFlags(TearFlags.TEAR_BLOOD_BOMB) then
		bombData.CreepVariant = EffectVariant.PLAYER_CREEP_RED
	elseif bomb:HasTearFlags(TearFlags.TEAR_STICKY) then
		bombData.CreepVariant = EffectVariant.PLAYER_CREEP_WHITE
	elseif bomb:HasTearFlags(TearFlags.TEAR_BUTT_BOMB) then
		bombData.CreepVariant = EffectVariant.CREEP_SLIPPERY_BROWN
	elseif bomb:HasTearFlags(TearFlags.TEAR_POISON) then
		bombData.CreepVariant = EffectVariant.PLAYER_CREEP_GREEN
	end
end
---Gravity Bombs
local function InitGravityBomb(bomb, bombData)
	--- apply effect of black hole bomb
	bombData.Gravity = true

	--bomb:AddTearFlags(TearFlags.TEAR_ATTRACTOR | TearFlags.TEAR_MAGNETIZE)
	bomb:AddEntityFlags(EntityFlag.FLAG_MAGNETIZED) -- else it wouldn't attract tears
	bomb:AddTearFlags(TearFlags.TEAR_RIFT)
	
	--sfx:Play(SoundEffect.SOUND_BLOOD_LASER_LARGE,_,_,_,0.2,0)
	--sfx:Play(545)
	local holeEffect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EclipsedMod.GravityBombs.BlackHoleEffect, 0, bomb.Position, Vector.Zero, nil):ToEffect()
	local holeData = holeEffect:GetData()
	holeEffect.Parent = bomb
	holeEffect.DepthOffset = -100
	holeEffect.Color = Color(0,0,0,1,0,0,0) -- set black color
	holeData.Gravity = true
	holeData.GravityForce = EclipsedMod.GravityBombs.AttractorForce
	holeData.GravityRange = EclipsedMod.GravityBombs.AttractorRange
	holeData.GravityGridRange = EclipsedMod.GravityBombs.AttractorGridRange
end
-- add desired wisp of item if you have book of virtues
function EclipsedMod:onAnyItem(item, _, player, useFlag) --item, rng, player, useFlag, activeSlot, customVarData
	--- activates on any item use. checks if it's mod item and player has book of virtues
	if EclipsedMod.ActiveItemWisps[item] and player:HasCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_VIRTUES) and useFlag & myUseFlags ~= myUseFlags then
		--:AddWisp(Collectible, Position, AdjustOrbitLayer, DontUpdate)
		local wisp = player:AddWisp(EclipsedMod.ActiveItemWisps[item], player.Position, true, false)
		--wisp:GetData().ModWisp = true
		if wisp and Isaac.GetItemConfig():GetCollectible(item).ChargeType == 1 then
			wisp:ToFamiliar():GetData().RemoveAll = item
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_ITEM, EclipsedMod.onAnyItem)

function EclipsedMod:onModWispsUpdate(wisp)
	local wispData = wisp:GetData()
	if wispData.RemoveAll then
		if wisp:HasMortalDamage() then
			local sameWisps = Isaac.FindByType(wisp.Type, wisp.Variant, wisp.SubType)
			if #sameWisps > 0 then
				for _, wisp2 in pairs(sameWisps) do
					if wisp2:GetData().RemoveAll == wispData.RemoveAll then
						wisp2:Kill()
					end
				end
			end
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, EclipsedMod.onModWispsUpdate, FamiliarVariant.WISP)

-- glowing hourglass removes blindfold, so this function resets blindfold
function EclipsedMod:onGlowingHourglassUse(_, _, player) --item, rng, player, useFlag, activeSlot, customVarData
	local data = player:GetData()
	if data.BlindAbihu or data.BlindUnbidden then
		data.ResetBlind = 60 -- reset blindfold after 60 frames
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_ITEM, EclipsedMod.onGlowingHourglassUse, CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS)
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
	local righPosition = Isaac.GetFreeNearPosition(Vector(position.X+80,position.Y), 40) -- cause grid size is 40x40
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
	local bombDamage = 100 -- normal bomb damage
	local bombRadiusMult = 1
	if player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS) then
		bombDamage = 185 -- mr.mega bomb damage
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
	if player:HasTrinket(EclipsedMod.Trinkets.DeadEgg) then
		local numTrinket = player:GetTrinketMultiplier(EclipsedMod.Trinkets.DeadEgg)
		for _ = 1, numTrinket do
			local birdy = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.DEAD_BIRD, 0, pos, Vector.Zero, nil):ToEffect()
			birdy:SetColor(Color(0,0,0,1,0,0,0),timeout,1, false, false) -- set black
			birdy:SetTimeout(timeout)
			birdy.SpriteScale = Vector.One *0.7
			birdy:GetData().DeadEgg = true
		end
	end
end
---Adrenaline Card
local function AdrenalineManager(player, redHearts, num)
	--- turn your hearts into batteries
	local j = 0
	while redHearts > num do
		DebugSpawn(PickupVariant.PICKUP_LIL_BATTERY, BatterySubType.BATTERY_NORMAL, player.Position)
		redHearts = redHearts-2
		j = j+2 -- for each 2 hearts
	end
	player:AddHearts(-j)
end





---Unbidden
local function AddItemFromWisp(player, kill, stop)
	
	stop = stop or false
	local itemWisps = Isaac.FindInRadius(player.Position, EclipsedMod.UnbiddenData.RadiusWisp, EntityPartition.FAMILIAR)
	if #itemWisps > 0 then
		for _, witem in pairs(itemWisps) do
			if witem.Variant == FamiliarVariant.ITEM_WISP then
				player:GetData().WispedQueue = player:GetData().WispedQueue or {}
				table.insert(player:GetData().WispedQueue, {witem, kill})
				if stop then 
					return witem.SubType
				end	
			end
		end	
	end
	return
end

function EclipsedMod:onPEffectUpdate35(player)
	local data = player:GetData()
	if data.WispedQueue then 
		if #data.WispedQueue > 0 and player:IsItemQueueEmpty() and not data.WispedItemDelay then 
			local witem = data.WispedQueue[1][1]
			local kill = data.WispedQueue[1][2]
			sfx:Play(SoundEffect.SOUND_THUMBSUP)
			player:QueueItem(Isaac.GetItemConfig():GetCollectible(witem.SubType), Isaac.GetItemConfig():GetCollectible(witem.SubType).InitCharge)
			player:AnimateCollectible(witem.SubType, "UseItem") -- queueItem works with "UseItem" animation YEY!
			if kill then
				witem:Remove()
				witem:Kill()
			end
			data.WispedItemDelay = 1
			table.remove(data.WispedQueue, 1)
		elseif player:IsItemQueueEmpty() and data.WispedItemDelay then -- so it would be added properly ( basically I just need at least 1 frame delay, to add item modifications)
			data.WispedItemDelay = nil
		elseif #data.WispedQueue == 0 then -- nil if it's empty
			data.WispedQueue = nil
			data.WispedItemDelay = nil
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, EclipsedMod.onPEffectUpdate35)

---Soul of Unbidden
local function SpawnItemWisps(player)
	local items = Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE)
	if #items > 0 then
		--sfx:Play(SoundEffect.SOUND_SOUL_PICKUP)
		for _, item in pairs(items) do
			if item.SubType ~= 0 and not CheckItemTags(item.SubType, ItemConfig.TAG_QUEST) then
				sfx:Play(SoundEffect.SOUND_SOUL_PICKUP)
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
---Blindfold
--- Written by Zamiel, technique created by im_tem
-- @param player EntityPlayer
-- @param enabled boolean
-- @param modifyCostume boolean
local function SetBlindfold(player, enabled) --modifyCostume
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
---Eclipse
local function EclipseAura(player)
	local data = player:GetData()

	-- delay - firerate analog
	--local maxCharge = math.floor(player.MaxFireDelay) + EclipsedMod.Eclipse.DamageDelay
	data.EclipseDamageDelay = data.EclipseDamageDelay or 0
	if data.EclipseDamageDelay < EclipsedMod.Eclipse.DamageDelay then data.EclipseDamageDelay = data.EclipseDamageDelay + 1 end
	--print(maxCharge, data.EclipseDamageDelay)
	-- damage boosts count (work only with Curse of Darkness)
	data.EclipseBoost = data.EclipseBoost or 0
	if data.EclipseBoost > 0 and game:GetLevel():GetCurses() & LevelCurse.CURSE_OF_DARKNESS == 0 then
		data.EclipseBoost = 0
	end

	-- dark aura
	local pos = player.Position
	--pos = Vector(pos.X, pos.Y-28)
	local range = EclipsedMod.Eclipse.AuraRange

	if game:GetLevel():GetCurses() & LevelCurse.CURSE_OF_DARKNESS > 0 then
		if not data.EclipseBoost or data.EclipseBoost ~= GetItemsCount(player, EclipsedMod.Items.Eclipse) then
			data.EclipseBoost = GetItemsCount(player, EclipsedMod.Items.Eclipse)
			player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
			player:EvaluateItems()
		end
	elseif data.EclipseBoost then
		data.EclipseBoost = nil
		player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
		player:EvaluateItems()
	end

	-- do pulse damage to enemies in aura range
	if player:GetFireDirection() ~= -1 and data.EclipseDamageDelay >= EclipsedMod.Eclipse.DamageDelay then
		data.EclipseDamageDelay = 0
		local enemies = Isaac.FindInRadius(pos, range, EntityPartition.ENEMY)
		
		local pulse = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HALO, 8, pos, Vector.Zero, player):ToEffect()
		pulse.SpriteScale = pulse.SpriteScale * range/100
		if #enemies > 0 then
			for _, enemy in pairs(enemies) do
				if enemy:IsVulnerableEnemy() and enemy:IsActiveEnemy() then
					enemy:TakeDamage(player.Damage, 0, EntityRef(player), 1)
					enemy:AddVelocity((enemy.Position - pos):Resized(player.ShotSpeed * EclipsedMod.Eclipse.Knockback))
				end
			end
		end
	end
end
--- penance
local function PenanceShootLaser(angle, timeout, pos, ppl)
	local laser = Isaac.Spawn(EntityType.ENTITY_LASER, EclipsedMod.Penance.LaserVariant, 0, pos, Vector.Zero, ppl):ToLaser()
	laser.Color = EclipsedMod.Penance.Color
	laser:SetTimeout(timeout)
	laser.Angle = angle
end
--- Pandora's Jar
local function PandoraJarManager(currentCurses)
	local curseTable = {}
	for _, curse in pairs(EclipsedMod.Curses) do
		if currentCurses & curse == 0 then
			table.insert(curseTable, curse)
		end
	end
	return curseTable
end
-- get bomb damage radius
local function GetBombRadiusFromDamage(damage)
	if 175.0 <= damage then
		return 105.0
	else
		if damage <= 140.0 then
			return 75.0
		else
			return 90.0
		end
	end
end

EclipsedMod.QueueItemsCheck = {
[EclipsedMod.Items.GravityBombs] = true,
[EclipsedMod.Items.MidasCurse] = true,
[EclipsedMod.Items.RubberDuck] = true,
[CollectibleType.COLLECTIBLE_BIRTHRIGHT] = true,
}


--From Xalum (I guess)--
local function CheckPickupAbuse(player)
	local data = player:GetData()
	local queuedItem = player.QueuedItem
	data.EclipsedHeldItem = queuedItem.Item or data.EclipsedHeldItem
	--if data.EclipsedHeldItem.Item:IsCollectible() and (not queuedItem.Item or (data.EclipsedHeldItem and data.EclipsedHeldItem.ID ~= queuedItem.Item.ID)) then
	
	if not (not queuedItem.Item and data.EclipsedHeldItem and data.EclipsedHeldItem:IsCollectible()) then return end
			
	local itemId = data.EclipsedHeldItem.ID
	local touched = data.EclipsedHeldItem.Touched
	data.EclipsedHeldItem = nil
	if EclipsedMod.QueueItemsCheck[itemId] and not touched then
		local rng = player:GetCollectibleRNG(itemId)
		if itemId == EclipsedMod.Items.GravityBombs then
			player:AddGigaBombs(EclipsedMod.GravityBombs.GigaBombs)
		elseif itemId == EclipsedMod.Items.MidasCurse then
			player:AddGoldenHearts(3)
		elseif itemId == EclipsedMod.Items.RubberDuck then
			data.DuckCurrentLuck = data.DuckCurrentLuck or 0
			data.DuckCurrentLuck = data.DuckCurrentLuck + EclipsedMod.RubberDuck.MaxLuck
			EvaluateDuckLuck(player, data.DuckCurrentLuck)
		elseif itemId == CollectibleType.COLLECTIBLE_BIRTHRIGHT then
			if player:GetPlayerType() == EclipsedMod.Characters.Nadab then
				SpawnOptionItems(ItemPoolType.POOL_BOMB_BUM, rng:RandomInt(Random())+1, player.Position)
			elseif player:GetPlayerType() == EclipsedMod.Characters.Abihu then
				player:SetFullHearts()
			elseif player:GetPlayerType() == EclipsedMod.Characters.Unbidden then
				local broken = player:GetBrokenHearts()
				player:AddBrokenHearts(-broken)
				player:AddSoulHearts(2*broken)
				AddItemFromWisp(player, false)
			end
		end
	end
	
end
--- beggar bombing
local function BeggarWasBombed(beggar, dontKill)
	local level = game:GetLevel()
	local explosions = Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.BOMB_EXPLOSION)
	local mamaMega = Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.MAMA_MEGA_EXPLOSION)
	dontKill = dontKill or false
	if #mamaMega > 0 then
		if not dontKill then
			beggar:Kill()
			beggar:Remove()
		end
		level:SetStateFlag(LevelStateFlag.STATE_BUM_KILLED, true)
		return true
	elseif #explosions > 0 then
		for _, explos in pairs(explosions) do
			local frame = explos:GetSprite():GetFrame()
			if frame < 3 then
				if explos.Position:Distance(beggar.Position) <= 90 * explos.SpriteScale.X then
					if not dontKill then
						beggar:Kill()
						beggar:Remove()
					end
					level:SetStateFlag(LevelStateFlag.STATE_BUM_KILLED, true)
					return true
				end
			end
		end
	end
	return false
end
--- LOCAL FUNCTIONS --

--- MOD CALLBACKS --
-- callback
--- GAME EXIT --
function EclipsedMod:onExit(isContinue)
	if isContinue then
		savetable.OblivionCardErasedEntities = EclipsedMod.OblivionCard.ErasedEntities
		savetable.LobotomyErasedEntities = EclipsedMod.Lobotomy.ErasedEntities
		savetable.MidasCurseTurnGoldChance = EclipsedMod.MidasCurse.TurnGoldChance
		savetable.SecretLoveLetterAffectedEnemies = EclipsedMod.SecretLoveLetter.AffectedEnemies
		savetable.DeliriumBeggarData = {}
		savetable.DeliriumBeggarData.Enemies = EclipsedMod.DeliriumBeggar.Enemies
		savetable.DeliriumBeggarData.Enable = EclipsedMod.DeliriumBeggar.Enable
		savetable.PandoraJarGift = EclipsedMod.PandoraJarGift
		savetable.ModdedBombas = EclipsedMod.ModdedBombas
		
		savetable.DemonSpawn = {} -- EclipsedMod.Lililith.DemonSpawn
		savetable.MidasCurseActive = {}
		savetable.DuckCurrentLuck = {}
		savetable.RedPillDamageUp = {}
		savetable.UsedBG = {}
		savetable.LimbActive = {}
		savetable.StateDamaged = {}
		savetable.RedLotusDamage = {}
		savetable.KarmaStats = {}
		savetable.WaxHeartsCount = {}

		--savetable.MemoryBoolPool = {}

		for playerNum = 0, game:GetNumPlayers()-1 do
			local player = game:GetPlayer(playerNum)
			local data = player:GetData()
			local idx = getPlayerIndex(player)

			if data.LililithDemonSpawn then
				savetable.DemonSpawn[idx] = data.LililithDemonSpawn
			end
			if player:HasCollectible(EclipsedMod.Items.MidasCurse) then
				savetable.MidasCurseActive[idx] = data.GoldenHeartsAmount
			end
			if player:HasCollectible(EclipsedMod.Items.RubberDuck) then
				savetable.DuckCurrentLuck[idx] = data.DuckCurrentLuck
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
			--[
			if data.WaxHeartsCount then
				savetable.WaxHeartsCount[idx] = data.WaxHeartsCount
			end
			--]
		end
	end
	modDataSave()
end
EclipsedMod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, EclipsedMod.onExit)
--- GAME START --
function EclipsedMod:onStart(isSave)

	--- load mod save data; if debug, spawn mod items
	if isSave then
		for playerNum = 0, game:GetNumPlayers()-1 do
			local player = game:GetPlayer(playerNum)
			local data = player:GetData()
			if player:GetPlayerType() == EclipsedMod.Characters.Abihu or player:GetPlayerType() == EclipsedMod.Characters.Oblivious then
				data.BlindAbihu = true
				data.BlindUnbidden = true
				SetBlindfold(player, true)
			end
		end
		if EclipsedMod:HasData() then -- continue game
			local localtable = json.decode(EclipsedMod:LoadData())
			EclipsedMod.OblivionCard.ErasedEntities = localtable.OblivionCardErasedEntities
			EclipsedMod.Lobotomy.ErasedEntities = localtable.LobotomyErasedEntities
			EclipsedMod.MidasCurse.TurnGoldChance = localtable.MidasCurseTurnGoldChance
			EclipsedMod.SecretLoveLetter.AffectedEnemies = localtable.SecretLoveLetterAffectedEnemies
			if localtable.DeliriumBeggarData then
				EclipsedMod.DeliriumBeggar.Enable = localtable.DeliriumBeggarData.Enable
				EclipsedMod.DeliriumBeggar.Enemies = localtable.DeliriumBeggarData.Enemies
			end
		end
	else --if not isSave then -- new game
		InitCall()
		if debug then
			InitDebugCall() -- spawn mod items for test
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, EclipsedMod.onStart)
--- PLAYER INIT --
function EclipsedMod:onPlayerInit(player)
	local data = player:GetData()
	local idx = getPlayerIndex(player)
	local toPlayers = #Isaac.FindByType(EntityType.ENTITY_PLAYER)

	if toPlayers == 0 then
		myrng:SetSeed(game:GetSeeds():GetStartSeed(), RECOMMENDED_SHIFT_IDX)
		modDataLoad()
	end

	if EclipsedMod:HasData() then
		local localtable = json.decode(EclipsedMod:LoadData())

		if player:HasCollectible(EclipsedMod.Items.Lililith) then
			data.LililithDemonSpawn = localtable.DemonSpawn[idx] -- EclipsedMod.Lililith.DemonSpawn
		end

		if player:HasCollectible(EclipsedMod.Items.MidasCurse) then
			data.GoldenHeartsAmount = localtable.MidasCurseActive[idx]
		end
		if player:HasCollectible(EclipsedMod.Items.RubberDuck) then
			EvaluateDuckLuck(player, localtable.DuckCurrentLuck[idx])
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

		if localtable.ModdedBombas then
			EclipsedMod.ModdedBombas = localtable.ModdedBombas
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

		if localtable.PandoraJarGift then
			EclipsedMod.PandoraJarGift = localtable.PandoraJarGift
		end

		if localtable.WaxHeartsCount then
			data.WaxHeartsCount = localtable.WaxHeartsCount[idx]
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, EclipsedMod.onPlayerInit)

--- EVAL_CACHE --
function EclipsedMod:onCache(player, cacheFlag)
	player = player:ToPlayer()
	local data = player:GetData()
	--local level = game:GetLevel()
	if cacheFlag == CacheFlag.CACHE_LUCK then
		if player:HasCollectible(EclipsedMod.Items.RubberDuck) and data.DuckCurrentLuck then
			player.Luck = player.Luck + data.DuckCurrentLuck
		end
		if player:HasCollectible(EclipsedMod.Items.VoidKarma) and data.KarmaStats then
			player.Luck = player.Luck + data.KarmaStats.Luck
		end
		if data.DeuxExLuck then
			player.Luck = player.Luck + data.DeuxExLuck
		end
		if data.MisfortuneLuck then
			player.Luck = player.Luck + EclipsedMod.MisfortuneLuck
		end
	end
	if cacheFlag == CacheFlag.CACHE_DAMAGE then
		if data.RedPillDamageUp then
			player.Damage = player.Damage + data.RedPillDamageUp
		end
		if data.RedLotusDamage then -- save damage even if you removed item
			player.Damage = player.Damage + data.RedLotusDamage
		end
		if player:HasCollectible(EclipsedMod.Items.VoidKarma) and data.KarmaStats then
			player.Damage = player.Damage + data.KarmaStats.Damage
		end
		if data.EclipseBoost and data.EclipseBoost > 0 then
	        player.Damage = player.Damage + player.Damage * (EclipsedMod.Eclipse.DamageBoost * data.EclipseBoost)
	    end
	end
	if cacheFlag == CacheFlag.CACHE_FIREDELAY then
		if player:HasCollectible(EclipsedMod.Items.VoidKarma) and data.KarmaStats then
			player.MaxFireDelay = player.MaxFireDelay + data.KarmaStats.Firedelay
		end
	end
	if cacheFlag == CacheFlag.CACHE_SHOTSPEED then
		if player:HasCollectible(EclipsedMod.Items.VoidKarma) and data.KarmaStats then
			player.ShotSpeed = player.ShotSpeed + data.KarmaStats.Shotspeed
		end
	end
	if cacheFlag == CacheFlag.CACHE_RANGE then
		if player:HasCollectible(EclipsedMod.Items.VoidKarma) and data.KarmaStats then
			player.TearRange = player.TearRange + data.KarmaStats.Range
		end
	end
	if cacheFlag == CacheFlag.CACHE_SPEED then
		if player:HasCollectible(EclipsedMod.Items.MiniPony) then --and player.MoveSpeed < EclipsedMod.MiniPony.MoveSpeed then
			player.MoveSpeed = EclipsedMod.MiniPony.MoveSpeed
		end
		if player:HasCollectible(EclipsedMod.Items.VoidKarma) and data.KarmaStats then
			player.MoveSpeed = player.MoveSpeed + data.KarmaStats.Speed
		end
	end
	if cacheFlag == CacheFlag.CACHE_FAMILIARS then
		-- red bags
		local bags = GetItemsCount(player, EclipsedMod.Items.RedBag)
		if bags > 0 then
			player:CheckFamiliar(EclipsedMod.RedBag.Variant, bags, RNG(), Isaac.GetItemConfig():GetCollectible(EclipsedMod.Items.RedBag))
		end
		-- lililiths
		local lililiths = GetItemsCount(player, EclipsedMod.Items.Lililith)
		if lililiths > 0 then
			player:CheckFamiliar(EclipsedMod.Lililith.Variant, lililiths, RNG(), Isaac.GetItemConfig():GetCollectible(EclipsedMod.Items.Lililith))
		end
		-- abihu familiars
		--if player:HasCollectible(EclipsedMod.Items.AbihuFam) then
			--- if you ask why it's complicated
			--- this shit dances for just to check when you have both abihu with punching bag
			--- cause IDK HOW to add decoy effect to entity. else I would just make new familiar entity
			--- and for some reason punching bag subtype is his state. 0 - idle. 1 - walking. >2 - reacts on near enemies
		local punches = GetItemsCount(player, CollectibleType.COLLECTIBLE_PUNCHING_BAG)
		local profans = GetItemsCount(player, EclipsedMod.Items.AbihuFam)
		if punches>0 then
			if player:HasCollectible(EclipsedMod.Items.AbihuFam) then
				--HasSubtype(player, punches, EclipsedMod.AbihuFam.Variant, CollectibleType.COLLECTIBLE_PUNCHING_BAG)
				local entities2 = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, EclipsedMod.AbihuFam.Variant, _, true, false)
				for _, punch in pairs(entities2) do
					punch:Remove()
				end
				player:CheckFamiliar(EclipsedMod.AbihuFam.Variant, punches, RNG(), Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_PUNCHING_BAG), 0)
				--player:CheckFamiliar(EclipsedMod.AbihuFam.Variant, profans, RNG(), Isaac.GetItemConfig():GetCollectible(EclipsedMod.Items.AbihuFam), EclipsedMod.AbihuFam.Subtype)
			end
		end
		if profans > 0 then
			player:CheckFamiliar(EclipsedMod.AbihuFam.Variant, profans, RNG(), Isaac.GetItemConfig():GetCollectible(EclipsedMod.Items.AbihuFam), EclipsedMod.AbihuFam.Subtype)
		end
		local brains = GetItemsCount(player, EclipsedMod.Items.NadabBrain)
		if brains > 0 then
			player:CheckFamiliar(EclipsedMod.NadabBrain.Variant, brains, RNG(), Isaac.GetItemConfig():GetCollectible(EclipsedMod.Items.NadabBrain))
		end
	end

	if cacheFlag == CacheFlag.CACHE_TEARCOLOR then
		if player:HasCollectible(EclipsedMod.Items.MeltedCandle) then
			player.TearColor = EclipsedMod.MeltedCandle.TearColor
		end
	end

	if cacheFlag == CacheFlag.CACHE_FLYING then
		if player:HasCollectible(EclipsedMod.Items.MiniPony) or player:HasCollectible(EclipsedMod.Items.LongElk) or player:HasCollectible(EclipsedMod.Items.Viridian) or player:HasCollectible(EclipsedMod.Items.MewGen) then
			player.CanFly = true
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, EclipsedMod.onCache)
--- PLAYER TAKE DMG --
function EclipsedMod:onPlayerTakeDamage(entity, _, flags) --entity, amount, flags, source, countdown
	local player = entity:ToPlayer()
	local data = player:GetData()
	--- soul of nadab and abihu
	if data.UsedSoulNadabAbihu then
		if (flags & DamageFlag.DAMAGE_FIRE ~= 0) or (flags & DamageFlag.DAMAGE_EXPLOSION ~= 0) then return false end
	end
	if not player:HasCurseMistEffect() and not player:IsCoopGhost() then
		--- mongo cells
		if player:HasCollectible(EclipsedMod.Items.MongoCells) and flags & DamageFlag.DAMAGE_NO_PENALTIES == 0 then
			local rng = player:GetCollectibleRNG(EclipsedMod.Items.MongoCells)
			if player:HasCollectible(CollectibleType.COLLECTIBLE_DRY_BABY) or tempEffects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_DRY_BABY) then
				if rng:RandomFloat() < EclipsedMod.MongoCells.DryBabyChance then
					player:UseActiveItem(CollectibleType.COLLECTIBLE_NECRONOMICON, myUseFlags)
				end
			end
			if player:HasCollectible(CollectibleType.COLLECTIBLE_FARTING_BABY) or tempEffects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_FARTING_BABY) then
				if rng:RandomFloat() < EclipsedMod.MongoCells.DryBabyChance then
					local bean = EclipsedMod.MongoCells.FartBabyBeans[rng:RandomInt(#EclipsedMod.MongoCells.FartBabyBeans)+1]
					player:UseActiveItem(bean, myUseFlags)
				end
			end
			if player:HasCollectible(CollectibleType.COLLECTIBLE_BBF) or tempEffects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_BBF) then
				game:BombExplosionEffects(player.Position, EclipsedMod.MongoCells.BBFDamage, player:GetBombFlags(), Color.Default, player, 1, true, false, DamageFlag.DAMAGE_EXPLOSION)
			end
			if player:HasCollectible(CollectibleType.COLLECTIBLE_BOBS_BRAIN) or tempEffects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_BOBS_BRAIN) then
				game:BombExplosionEffects(player.Position, EclipsedMod.MongoCells.BBFDamage, player:GetBombFlags(), Color.Default, player, 1, true, false, DamageFlag.DAMAGE_EXPLOSION)
				local cloud = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.SMOKE_CLOUD, 0, player.Position, Vector.Zero, player):ToEffect()
				cloud:SetTimeout(150)
			end
			if player:HasCollectible(CollectibleType.COLLECTIBLE_HOLY_WATER) or tempEffects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_WATER) then
				Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_HOLYWATER, 0, player.Position, Vector.Zero, player):SetColor(Color(1,1,1,0), 5, 1, false, false)
			end
			if player:HasCollectible(CollectibleType.COLLECTIBLE_DEPRESSION) or tempEffects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_DEPRESSION) then
				if rng:RandomFloat() < EclipsedMod.MongoCells.DepressionLightChance then
					Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CRACK_THE_SKY, 0, player.Position, Vector.Zero, player)
				end
			end
			if player:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_RAZOR) or tempEffects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_MOMS_RAZOR) then
				player:AddEntityFlags(EntityFlag.FLAG_BLEED_OUT)
			end
		end
		--- lost flower
		if player:HasTrinket(EclipsedMod.Trinkets.LostFlower) then -- remove lost flower if get hit
			if (flags & DamageFlag.DAMAGE_NO_PENALTIES == 0) and (flags & DamageFlag.DAMAGE_RED_HEARTS == 0) then
				RemoveThrowTrinket(player, EclipsedMod.Trinkets.LostFlower, EclipsedMod.LostFlower.DespawnTimer)
			end
		end
		--- RubikCubelet: TMTRAINER + D6
		if player:HasTrinket(EclipsedMod.Trinkets.RubikCubelet) then
			local numTrinket = player:GetTrinketMultiplier(EclipsedMod.Trinkets.RubikCubelet)
			if player:GetTrinketRNG(EclipsedMod.Trinkets.RubikCubelet):RandomFloat() < EclipsedMod.RubikCubelet.TriggerChance * numTrinket then
				RerollTMTRAINER(player)
				--sfx:Play(SoundEffect.SOUND_DICE_SHARD)
			end
		end


	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, EclipsedMod.onPlayerTakeDamage, EntityType.ENTITY_PLAYER)
--- PLAYER PEFFECT --
function EclipsedMod:onPEffectUpdate(player)
	local level = game:GetLevel()
	local room = game:GetRoom()
	local data = player:GetData()
	local sprite = player:GetSprite()
	local tempEffects = player:GetEffects()

	if level:GetCurses() & EclipsedMod.Curses.Misfortune > 0 and not data.MisfortuneLuck then
		data.MisfortuneLuck = true
		player:AddCacheFlags(CacheFlag.CACHE_LUCK)
		player:EvaluateItems()
	elseif level:GetCurses() & EclipsedMod.Curses.Misfortune == 0 and data.MisfortuneLuck then
		data.MisfortuneLuck = nil
		player:AddCacheFlags(CacheFlag.CACHE_LUCK)
		player:EvaluateItems()
	end

	if level:GetCurses() & EclipsedMod.Curses.Montezuma > 0 and not player.CanFly and game:GetFrameCount()%10 == 0 then
		--player:AddEntityFlags(EntityFlag.FLAG_SLIPPERY_PHYSICS)
		local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_SLIPPERY_BROWN, 0, player.Position, Vector.Zero, nil):ToEffect()
		creep.SpriteScale = creep.SpriteScale * 0.1
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
				local radiusTable = Isaac.FindInRadius(data.KeeperMirror.Position, EclipsedMod.KeeperMirror.TargetRadius, EntityPartition.PICKUP)
				--print("pickups",#radiusTable)
				if #radiusTable > 0 then
					if data.KeeperMirror.Timeout <= EclipsedMod.KeeperMirror.TargetTimeout then
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
			sfx:Play(SoundEffect.SOUND_CASH_REGISTER)
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

	--- secret love letter
	if data.UsedSecretLoveLetter and player:GetFireDirection() ~= Direction.NO_DIRECTION then
		if player:IsHoldingItem() then 
			if player:GetActiveItem(ActiveSlot.SLOT_PRIMARY) == EclipsedMod.Items.SecretLoveLetter then
				if player:GetActiveCharge(ActiveSlot.SLOT_PRIMARY) >= Isaac.GetItemConfig():GetCollectible(EclipsedMod.Items.SecretLoveLetter).MaxCharges then--and player:GetActiveItem(ActiveSlot.SLOT_PRIMARY) == EclipsedMod.Items.SecretLoveLetter and tempEffects:HasCollectibleEffect(EclipsedMod.Items.SecretLoveLetter) then
					local tear = player:FireTear(player.Position, player:GetAimDirection() * 14, false, true, false, nil, 0):ToTear()
					tear.TearFlags = TearFlags.TEAR_CHARM
					tear.Color = Color(1,1,1,1,0,0,0)
					tear:ChangeVariant(EclipsedMod.SecretLoveLetter.TearVariant) --EclipsedMod.SecretLoveLetter.TearVariant)
					local tearData = tear:GetData()
					tearData.SecretLoveLetter = true
					local tearSprite = tear:GetSprite()
					tearSprite:ReplaceSpritesheet(0, EclipsedMod.SecretLoveLetter.SpritePath)
					tearSprite:LoadGraphics() -- replace sprite
					sfx:Play(SoundEffect.SOUND_SHELLGAME)
				end
				player:DischargeActiveItem(ActiveSlot.SLOT_PRIMARY)
			end
			 
			player:AnimateCollectible(EclipsedMod.Items.SecretLoveLetter, "HideItem")
		end
		data.UsedSecretLoveLetter = false
	end

	if not player:HasCurseMistEffect() and not player:IsCoopGhost() then
		CheckPickupAbuse(player)
		--- abyss cartridge
		if player:HasTrinket(EclipsedMod.Trinkets.AbyssCart) then
			if player:GetHearts() < 2 and player:GetSoulHearts() < 2 and game:GetFrameCount()%15 == 0 then
				data.AbyssCartBlink = data.AbyssCartBlink or nil
				if data.AbyssCartBlink then
					local blinkerBabies = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, data.AbyssCartBlink)
					if #blinkerBabies > 0 then
						for _, baby in pairs(blinkerBabies) do
							baby:SetColor(Color(0.3,0.3,1,1), 10, 100, true, false)
						end
					end
				else
					for _, elems in pairs(EclipsedMod.AbyssCart.SacrificeBabies) do
						if player:HasCollectible(elems[1]) then
							data.AbyssCartBlink = elems[2]
							break
						end
					end
				end
			elseif player:GetHearts() >= 2 or player:GetSoulHearts() >= 2 then
				if data.AbyssCartBlink then data.AbyssCartBlink = nil end
			end
		end
		--- mongo cells
		if player:HasCollectible(EclipsedMod.Items.MongoCells) then
			if game:GetFrameCount() %EclipsedMod.MongoCells.HeadlessCreepFrame == 0 then
				if player:HasCollectible(CollectibleType.COLLECTIBLE_HEADLESS_BABY) or tempEffects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_HEADLESS_BABY) then
					Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_RED, 0, player.Position, Vector.Zero, player)
				end
			end
			if game:GetFrameCount() %EclipsedMod.MongoCells.DepressionCreepFrame == 0 then
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
		if player:HasCollectible(EclipsedMod.Items.Lililith) then
			data.LililithDemonSpawn = data.LililithDemonSpawn or EclipsedMod.Lililith.DemonSpawn
		end
		--- Mew-Gen
		if player:HasCollectible(EclipsedMod.Items.MewGen) then
			data.HasMewGen = data.HasMewGen or false
			if not data.HasMewGen then
				--add costume
			end
			--[[
			if not player.CanFly then
				player:AddCacheFlags(CacheFlag.CACHE_FLYING)
				player:EvaluateItems()
			end
			--]]
			MewGenManager(player)
		else
			if data.HasMewGen then
				--remove costume
			end
		end
		-- void karma
		if player:HasCollectible(EclipsedMod.Items.VoidKarma) and level:GetStateFlag(LevelStateFlag.STATE_DAMAGED) and not data.StateDamaged then
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
			if bomb:GetSprite():GetAnimation() == "Explode" then -- not EclipsedMod.MirrorBombs.Ban[bomb.Variant]
				if bomb:GetData().Dicey then
					local radius = GetBombRadiusFromDamage(bomb.ExplosionDamage)
					--if bomb:HasTearFlags(TearFlags.TEAR_GIGA_BOMB) then radius = 120 end
					--print(radius)
					DiceyReroll(player:GetCollectibleRNG(EclipsedMod.Items.DiceBombs), bomb.Position, radius)
				end
				if bomb:GetData().DeadEgg then
					DeadEggEffect(player, bomb.Position, EclipsedMod.DeadEgg.Timeout)
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

		--long elk
		if player:HasCollectible(EclipsedMod.Items.LongElk) then
			--[
			if not data.HasLongElk then
				data.HasLongElk = true
				player:AddNullCostume(EclipsedMod.LongElk.Costume)
				player:AddCacheFlags(CacheFlag.CACHE_FLYING)
				player:EvaluateItems()
			end
			--]

			if data.ElkKiller and not tempEffects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_MARS) then
				data.ElkKiller = false
			end

			if not data.BoneSpurTimer then
				data.BoneSpurTimer = EclipsedMod.LongElk.BoneSpurTimer
			else
				if  data.BoneSpurTimer > 0 then
					data.BoneSpurTimer = data.BoneSpurTimer - 1
				end
			end
			if player:GetMovementDirection() ~= -1 and not room:IsClear() and data.BoneSpurTimer <= 0 then
				Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BONE_SPUR, 0, player.Position, Vector.Zero, player):ToFamiliar():GetData().RemoveTimer = EclipsedMod.LongElk.BoneSpurTimer * EclipsedMod.LongElk.NumSpur
				data.BoneSpurTimer = EclipsedMod.LongElk.BoneSpurTimer
			end
		--
		else
			if data.HasLongElk then
				data.HasLongElk = nil
				player:TryRemoveNullCostume(EclipsedMod.LongElk.Costume)
				player:AddCacheFlags(CacheFlag.CACHE_FLYING)
				player:EvaluateItems()
			end
			--
		end
		--mini-pony
		--[
		if player:HasCollectible(EclipsedMod.Items.MiniPony) then
			if not data.HasMiniPony then
				data.HasMiniPony = true
				--player:AddCacheFlags(CacheFlag.CACHE_SIZE)
				player:AddCacheFlags(CacheFlag.CACHE_FLYING)
				player:AddCacheFlags(CacheFlag.CACHE_SPEED)
				player:AddNullCostume(EclipsedMod.MiniPony.Costume)
				player:EvaluateItems()
			end
			if player.MoveSpeed < EclipsedMod.MiniPony.MoveSpeed then
				player:AddCacheFlags(CacheFlag.CACHE_SPEED)
				player:EvaluateItems()
			end
		else
			if data.HasMiniPony then
				data.HasMiniPony = nil
				player:TryRemoveNullCostume(EclipsedMod.MiniPony.Costume)
				player:AddCacheFlags(CacheFlag.CACHE_FLYING)
				player:AddCacheFlags(CacheFlag.CACHE_SPEED)
				player:EvaluateItems()
			end
		end
		--]
		--- duotine
		if player:HasTrinket(EclipsedMod.Trinkets.Duotine) then
			for slot = 0, 3 do
				local pill = player:GetPill(slot)
				if pill > 0 then
					if pill & PillColor.PILL_GIANT_FLAG == PillColor.PILL_GIANT_FLAG then
						player:SetCard(slot, EclipsedMod.Pickups.RedPillHorse)
					else
						player:SetCard(slot, EclipsedMod.Pickups.RedPill)
					end
				end
			end			
		end
		
		---red pills
		if data.RedPillDamageUp then --and game:GetFrameCount()%2 == 0 then
			data.RedPillDamageUp = data.RedPillDamageUp - data.RedPillDamageDown
			data.RedPillDamageDown = data.RedPillDamageDown + EclipsedMod.RedPills.DamageDownTick
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
		if player:HasCollectible(EclipsedMod.Items.MidasCurse) then

			if not data.GoldenHeartsAmount then data.GoldenHeartsAmount = player:GetGoldenHearts() end

			if player:HasCollectible(CollectibleType.COLLECTIBLE_BLACK_CANDLE) and EclipsedMod.MidasCurse.TurnGoldChance ~= EclipsedMod.MidasCurse.MinGold then -- remove curse
				EclipsedMod.MidasCurse.TurnGoldChance = EclipsedMod.MidasCurse.MinGold
			elseif not player:HasCollectible(CollectibleType.COLLECTIBLE_BLACK_CANDLE) and EclipsedMod.MidasCurse.TurnGoldChance ~= EclipsedMod.MidasCurse.MaxGold then
				EclipsedMod.MidasCurse.TurnGoldChance = EclipsedMod.MidasCurse.MaxGold
			end
			-- golden particles
			if player:GetMovementDirection() ~= -1 then
				game:SpawnParticles(player.Position, EffectVariant.GOLD_PARTICLE, 1, 2, _, 0)
			end
			if player:GetGoldenHearts() < data.GoldenHeartsAmount then
				local rngMidasCurse = player:GetCollectibleRNG(EclipsedMod.Items.MidasCurse)
				data.GoldenHeartsAmount = player:GetGoldenHearts()
				room:TurnGold() -- turn room gold (ultra greed death)
				GoldenGrid(rngMidasCurse) -- golden poops
				for _, entity in pairs(Isaac.GetRoomEntities()) do
					if entity:ToNPC() then
						local enemy = entity:ToNPC()
						enemy:RemoveStatusEffects()
						enemy:AddMidasFreeze(EntityRef(player), EclipsedMod.MidasCurse.FreezeTime)
					end
					if entity.Type == EntityType.ENTITY_PICKUP then
						if rngMidasCurse:RandomFloat() < EclipsedMod.MidasCurse.TurnGoldChance then
							TurnPickupsGold(entity:ToPickup())
						end
					end
				end
			elseif player:GetGoldenHearts() > data.GoldenHeartsAmount then
				data.GoldenHeartsAmount = player:GetGoldenHearts()
			end
		else
			if data.GoldenHeartsAmount and data.GoldenHeartsAmount > 0 then
				data.GoldenHeartsAmount = 0
			end
		end
		---Duckling
		if player:HasCollectible(EclipsedMod.Items.RubberDuck) then
			data.DuckCurrentLuck = data.DuckCurrentLuck or 0
		else
			if data.DuckCurrentLuck and data.DuckCurrentLuck > 0 then
				-- data.DuckCurrentLuck = 0
				EvaluateDuckLuck(player, 0)
			end
		end
		---WitchPaper
		if data.WitchPaper then
			data.WitchPaper = data.WitchPaper - 1
			if data.WitchPaper <= 0 then
				data.WitchPaper = nil
				player:AnimateTrinket(EclipsedMod.Trinkets.WitchPaper)
				player:TryRemoveTrinket(EclipsedMod.Trinkets.WitchPaper)
			end
		end
		--- COPY from Edith mod ------------
		--- BlackKnight
		if player:HasCollectible(EclipsedMod.Items.BlackKnight, true) then
			--[
			if not data.HasBlackKnight then
				data.HasBlackKnight = true
				player:AddNullCostume(EclipsedMod.BlackKnight.Costume)
			end
			--]
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
					data.KnightTarget = Isaac.Spawn(1000, EclipsedMod.BlackKnight.Target, 0, player.Position, Vector.Zero, player):ToEffect()
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
							if (data.KnightTarget.Position - grid.Position):Length() <= EclipsedMod.BlackKnight.DoorRadius then
								if grid.Desc.Type == GridEntityType.GRID_DOOR then
									grid = grid:ToDoor()
									if room:IsClear() then
										grid:TryUnlock(player)
									end
									if grid:IsOpen() then
										if (player.Position - grid.Position):Length() <= EclipsedMod.BlackKnight.DoorRadius then
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
						if entity.Position:Distance(player.Position) > EclipsedMod.BlackKnight.BlastRadius and entity.Position:Distance(player.Position) <= EclipsedMod.BlackKnight.BlastRadius*2.5 then
							entity.Velocity = (entity.Position - player.Position):Resized(EclipsedMod.BlackKnight.BlastKnockback*(2/3))
						end
					elseif entity.Type == EntityType.ENTITY_PICKUP and entity.Position:Distance(player.Position) <= EclipsedMod.BlackKnight.PickupDistance then
						entity = entity:ToPickup()
						if EclipsedMod.BlackKnight.ChestVariant[entity.Variant] and entity.SubType ~= 0 then
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
				BlastDamage(EclipsedMod.BlackKnight.BlastRadius, EclipsedMod.BlackKnight.BlastDamage + player.Damage/2, EclipsedMod.BlackKnight.BlastKnockback, player)
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
				player:TryRemoveNullCostume(EclipsedMod.BlackKnight.Costume)
				data.HasBlackKnight = false
				player:ClearEntityFlags(EntityFlag.FLAG_NO_PHYSICS_KNOCKBACK | EntityFlag.FLAG_NO_KNOCKBACK)
				if data.KnightTarget then
					data.KnightTarget:Remove()
				end
				data.KnightTarget = nil
			end
		end

		--red button
		if player:HasCollectible(EclipsedMod.Items.RedButton) then
			if EclipsedMod.RedButton.Blastocyst then
				EclipsedMod.RedButton.Blastocyst.Visible = true
				EclipsedMod.RedButton.Blastocyst = false
			end
			if not EclipsedMod.PreRoomState then -- if room is not cleared
				for gridIndex = 1, room:GetGridSize() do -- get room size
					local grid = room:GetGridEntity(gridIndex)
					if grid then -- if grid ~= nil then
						if grid.VarData == EclipsedMod.RedButton.VarData then -- check button
							if grid.State ~= 0 then
								EclipsedMod.RedButton.PressCount = EclipsedMod.RedButton.PressCount + 1 -- button was pressed, increment 1
								room:RemoveGridEntity(gridIndex, 0, false) -- remove pressed button
								grid:Update()


								if EclipsedMod.RedButton.PressCount == EclipsedMod.RedButton.Limit - 2 then
									game:GetHUD():ShowFortuneText("Please,",  "don't touch the button!")
								elseif  EclipsedMod.RedButton.PressCount == EclipsedMod.RedButton.Limit - 1 then
									game:GetHUD():ShowFortuneText("Push the button!!!")
								end


								if EclipsedMod.RedButton.PressCount >= EclipsedMod.RedButton.Limit then -- get limit, no more buttons for this room


									EclipsedMod.RedButton.PressCount = 0 -- set press counter to 0
									local effect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.FART, 0, grid.Position, Vector.Zero, nil)
									effect:SetColor(Color(2.5,0,0,1,0,0,0),50,1, false, false) -- poof effect
									EclipsedMod.RedButton.Blastocyst = Isaac.Spawn(EntityType.ENTITY_BLASTOCYST_BIG, 0, 0, room:GetCenterPos(), Vector.Zero, nil) -- spawn blastocyst
									EclipsedMod.RedButton.Blastocyst.Visible = false
									EclipsedMod.RedButton.Blastocyst:ToNPC().State = NpcState.STATE_JUMP
								else
									SpawnButton(player, room) -- spawn new button
									local effect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, grid.Position, Vector.Zero, nil)
									effect:SetColor(EclipsedMod.RedColor,50,1, false, false) -- poof effect
								end
							end
						end
					end
				end
			end
		end

		--- lost flower
		if player:HasTrinket(EclipsedMod.Trinkets.LostFlower) and player:GetEternalHearts() > 0 then -- if you get eternal heart, add another one
			player:AddEternalHearts(1)
		end
		--- rubick's dice
		if EclipsedMod.RubikDice.ScrambledDices[player:GetActiveItem(ActiveSlot.SLOT_PRIMARY)] then -- if player:GetActiveItem(ActiveSlot.SLOT_PRIMARY) == EclipsedMod.Items.RubikDiceScrambled0 then
			local scrambledice = player:GetActiveItem(ActiveSlot.SLOT_PRIMARY)
			if player:GetActiveCharge(ActiveSlot.SLOT_PRIMARY) >= Isaac.GetItemConfig():GetCollectible(scrambledice).MaxCharges then
				--player:RemoveCollectible(scrambledice) -- scrambledice
				player:AddCollectible(EclipsedMod.Items.RubikDice)
				player:SetActiveCharge(3, ActiveSlot.SLOT_PRIMARY)
			elseif player:GetActiveCharge(ActiveSlot.SLOT_PRIMARY) > 0 and Input.IsActionPressed(ButtonAction.ACTION_ITEM, 0) then
				local rng = player:GetCollectibleRNG(scrambledice)
				local Newdice = EclipsedMod.RubikDice.ScrambledDicesList[rng:RandomInt(#EclipsedMod.RubikDice.ScrambledDicesList)+1]
				RerollTMTRAINER(player, scrambledice)
				--player:RemoveCollectible(scrambledice) -- scrambledice
				player:AddCollectible(Newdice) --Newdice
				player:SetActiveCharge(0, ActiveSlot.SLOT_PRIMARY)
			end
		end
		--- tea bag
		if player:HasTrinket(EclipsedMod.Trinkets.TeaBag) then
			--TrinketType.TRINKET_GOLDEN_FLAG
			--pickup.SubType < 32768
			local removeRadius = EclipsedMod.TeaBag.Radius
			local numTrinket = player:GetTrinketMultiplier(EclipsedMod.Trinkets.TeaBag)
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
		if player:HasCollectible(EclipsedMod.Items.WhiteKnight, true) then
			if not data.HasWhiteKnight then
				data.HasWhiteKnight = true
				player:AddNullCostume(EclipsedMod.WhiteKnight.Costume)
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
						if entity.Position:Distance(player.Position) > EclipsedMod.BlackKnight.BlastRadius and entity.Position:Distance(player.Position) <= EclipsedMod.BlackKnight.BlastRadius*2.5 then
							entity.Velocity = (entity.Position - player.Position):Resized(EclipsedMod.BlackKnight.BlastKnockback*(2/3))
						end
					elseif entity.Type == EntityType.ENTITY_PICKUP and entity.Position:Distance(player.Position) <= EclipsedMod.BlackKnight.PickupDistance then
						entity = entity:ToPickup()
						if EclipsedMod.BlackKnight.ChestVariant[entity.Variant] and entity.SubType ~= 0 then
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
				BlastDamage(EclipsedMod.BlackKnight.BlastRadius, EclipsedMod.BlackKnight.BlastDamage + player.Damage/2, EclipsedMod.BlackKnight.BlastKnockback, player)
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
				player:TryRemoveNullCostume(EclipsedMod.WhiteKnight.Costume)
				data.HasWhiteKnight = false
			end
		end
		--- red scissors
		if player:HasTrinket(EclipsedMod.Trinkets.RedScissors) then
			if not EclipsedMod.RedScissorsMod then
				EclipsedMod.RedScissorsMod = true
			end
		else
			if EclipsedMod.RedScissorsMod then
				EclipsedMod.RedScissorsMod = false
			end
		end

		--- viridian
		if player:HasCollectible(EclipsedMod.Items.Viridian) then
			if not data.HasItemViridian then
				data.HasItemViridian = true
				player.SpriteOffset = Vector(player.SpriteOffset.X, player.SpriteOffset.Y - EclipsedMod.Viridian.FlipOffsetY)
				player:GetSprite().FlipX = true

				player.SpriteRotation = 180 -- 180 degree rotation
			end
		else
			if data.HasItemViridian then
				data.HasItemViridian = nil
				player.SpriteOffset = Vector(player.SpriteOffset.X, player.SpriteOffset.Y + EclipsedMod.Viridian.FlipOffsetY)
				player.SpriteRotation = 0
				player:GetSprite().FlipX = false
				--player:GetSprite():Update()
			end
		end
		--- brain queue (better holy water mod)
		local brains = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, EclipsedMod.NadabBrain.Variant)
		if #brains > 0 then
			local nadabBrainAmount = GetItemsCount(player, EclipsedMod.Items.NadabBrain)
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

		--- Eclipsed
		if player:HasCollectible(EclipsedMod.Items.Eclipse) then
			EclipseAura(player)
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, EclipsedMod.onPEffectUpdate)
--- PLAYER COLLISION --
function EclipsedMod:onPlayerCollision(player, collider)
	local data = player:GetData()
	local tempEffects = player:GetEffects()

	--- long elk
	if data.ElkKiller and tempEffects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_MARS) and collider:ToNPC() then --collider:IsVulnerableEnemy() and collider:IsActiveEnemy() then  -- player.Velocity ~= Vector.Zero
		if not collider:IsVulnerableEnemy() then
			game:ShakeScreen(10)
			collider:Kill()
		else
			if collider:GetData().ElkKillerTick then
				--print(game:GetFrameCount() - collider:GetData().ElkKillerTick)
				if game:GetFrameCount() - collider:GetData().ElkKillerTick >= EclipsedMod.LongElk.TeleDelay then

					collider:GetData().ElkKillerTick = nil
				end
			else
				--data.ElkKiller = false
				collider:GetData().ElkKillerTick = game:GetFrameCount()
				collider:TakeDamage(EclipsedMod.LongElk.Damage, DamageFlag.DAMAGE_IGNORE_ARMOR, EntityRef(player), 0)
				sfx:Play(SoundEffect.SOUND_DEATH_CARD)
				--sfx:Play(SoundEffect.SOUND_DEATH_CARD, 1, 2, false, 1, 0) --sfx:Play(ID, Volume, FrameDelay, Loop, Pitch, Pan)
				game:ShakeScreen(10)
				player:SetMinDamageCooldown(EclipsedMod.LongElk.InvFrames)
			end
		end
	end

	--- abihu
	if player:GetPlayerType() == EclipsedMod.Characters.Abihu then
		if collider:ToNPC() then
			collider:AddBurn(EntityRef(player), 100, 2*player.Damage)
		end
	end

end
EclipsedMod:AddCallback(ModCallbacks.MC_PRE_PLAYER_COLLISION, EclipsedMod.onPlayerCollision)
--- POST UPDATE --
function EclipsedMod:onUpdate()
	local level = game:GetLevel()
	local room = game:GetRoom()

	--Apocalypse card
	if EclipsedMod.Apocalypse.Room then
		if level:GetCurrentRoomIndex() == EclipsedMod.Apocalypse.Room then -- meh. bad solution. but anyway. poop created in this room will be red (it will run in loop, until you leave current room. Why? Cause poop doesn't spawn immediately)
			for gridIndex = 1, room:GetGridSize() do -- get room size
				local grid = room:GetGridEntity(gridIndex)
				if grid then
					if grid:ToPoop() then
						if grid:GetVariant() == 0 then
							grid:SetVariant(1)
							grid:Init(EclipsedMod.Apocalypse.RNG:RandomInt(Random())+1)
							grid:PostInit()
							grid:Update()
						end
					end
				end
			end
		end
	end

	if level:GetCurses() & EclipsedMod.Curses.Carrion > 0 then
		for gridIndex = 1, room:GetGridSize() do -- get room size
			local grid = room:GetGridEntity(gridIndex)
			if grid and grid:ToPoop() and grid:GetVariant() == 0 then

				grid:SetVariant(1)
				grid:Init(grid:GetRNG():RandomInt(Random())+1)
				grid:PostInit()
				grid:Update()
			end
		end
	end

	if level:GetCurses() & EclipsedMod.Curses.Envy > 0 then
		local shopItems = Isaac.FindInRadius(room:GetCenterPos(), 5000, EntityPartition.PICKUP)
		if #shopItems > 0 then
			if EclipsedMod.EnvyCurseIndex == nil then
				EclipsedMod.EnvyCurseIndex = myrng:RandomInt(Random())+1
			end
			for _, pickup in pairs(shopItems) do
				if pickup.Type ~= EntityType.ENTITY_SLOT then
					pickup = pickup:ToPickup()
					if pickup:IsShopItem() and pickup.OptionsPickupIndex ~= EclipsedMod.EnvyCurseIndex then
						pickup.OptionsPickupIndex = EclipsedMod.EnvyCurseIndex
					end
				end
			end
		end
	end

	--[[
	if EclipsedMod.FoolCurseActive then
		EclipsedMod.FoolCurseActive = EclipsedMod.FoolCurseActive - 1
		if EclipsedMod.FoolCurseActive <= 0 then
			EclipsedMod.FoolCurseActive = nil
			EclipsedMod.FoolCurseNoRewards = true
			room:SetAmbushDone(false)
			for _, enemy in pairs(Isaac.FindInRadius(room:GetCenterPos(), 5000, EntityPartition.ENEMY)) do
				if enemy:ToNPC() then
					enemy:ToNPC().CanShutDoors = false
				end
			end
		end
	end
	--]]

	--curse void reroll countdown
	if not room:HasCurseMist() then
		if EclipsedMod.VoidCurseReroll then
			EclipsedMod.VoidCurseReroll = EclipsedMod.VoidCurseReroll - 1
			if EclipsedMod.VoidCurseReroll <= 0 then
				for _, enemy in pairs(Isaac.FindInRadius(room:GetCenterPos(), 5000, EntityPartition.ENEMY)) do
					if enemy:IsVulnerableEnemy() and enemy:IsActiveEnemy() then
						game:RerollEnemy(enemy)
						enemy:GetData().VoidCurseNoDevolve = true
					end
				end
				EclipsedMod.VoidCurseReroll = nil
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
			-- tea fungus
			--
			if player:HasTrinket(EclipsedMod.Trinkets.TeaFungus) and not room:HasWater() and not room:IsClear() and room:GetFrameCount() <= 2  then
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
			--

			--- abyss cartridge
			if player:HasTrinket(EclipsedMod.Trinkets.AbyssCart) and player:IsDead() and player:GetExtraLives() == 0 then
				for _, elems in pairs(EclipsedMod.AbyssCart.SacrificeBabies) do
					if player:HasCollectible(elems[1]) then
						player:RemoveCollectible(elems[1])
						player:AddCollectible(CollectibleType.COLLECTIBLE_1UP)
						--tempEffects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_1UP)
						local numTrinket = player:GetTrinketMultiplier(EclipsedMod.Trinkets.AbyssCart)-1
						local rngTrinket = player:GetTrinketRNG(EclipsedMod.Trinkets.AbyssCart)
						if rngTrinket:RandomFloat() > numTrinket * EclipsedMod.AbyssCart.NoRemoveChance then
							RemoveThrowTrinket(player, EclipsedMod.Trinkets.AbyssCart, EclipsedMod.TrinketDespawnTimer)
						end
						break
					end
				end
			end

			-- player dead
			if player:IsDead() then --and not player:WillPlayerRevive() then
				--witch paper
				if player:HasTrinket(EclipsedMod.Trinkets.WitchPaper) then
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
				if player:GetExtraLives() == 0 and player:HasCollectible(EclipsedMod.Items.Limb) and not data.LimbActive then -- and player:GetBrokenHearts() < 12 then -- and not player:WillPlayerRevive()
					player:Revive()
					player:SetMinDamageCooldown(EclipsedMod.Limb.InvFrames)
					data.LimbActive = true
					player:UseCard(Card.CARD_SOUL_LOST, myUseFlags)
					game:Darken(1, 3)
				end
				--
				if player:HasCollectible(EclipsedMod.Items.CharonObol) then
					player:RemoveCollectible(EclipsedMod.Items.CharonObol)
				end
				--
			end
		end

		--FloppyDisk
		--if player:HasCollectible(EclipsedMod.Items.FloppyDisk) and #EclipsedMod.FloppyDisk.Items > 0 then
		if not savetable.FloppyDiskItems then modDataLoad() end
		if player:HasCollectible(EclipsedMod.Items.FloppyDisk) and #savetable.FloppyDiskItems > 0 then
			player:RemoveCollectible(EclipsedMod.Items.FloppyDisk)
			player:AddCollectible(EclipsedMod.Items.FloppyDiskFull)
			--elseif player:HasCollectible(EclipsedMod.Items.FloppyDiskFull) and #EclipsedMod.FloppyDisk.Items == 0 then
		elseif player:HasCollectible(EclipsedMod.Items.FloppyDiskFull) and #savetable.FloppyDiskItems == 0 then
			player:RemoveCollectible(EclipsedMod.Items.FloppyDiskFull)
			player:AddCollectible(EclipsedMod.Items.FloppyDisk)
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_UPDATE, EclipsedMod.onUpdate)

--- NEW LEVEL --
function EclipsedMod:onNewLevel()
	local level = game:GetLevel()
	local room = game:GetRoom()
	EclipsedMod.OblivionCard.ErasedEntities = {}
	--EclipsedMod.Lobotomy.ErasedEntities = {}


	for _, fam in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR)) do
		-- add wisped items
		if fam.Variant == FamiliarVariant.ITEM_WISP and fam:GetData().AddNextFloor then
			local item = fam.SubType

			local ppl = fam:GetData().AddNextFloor:ToPlayer()
			ppl:AnimateCollectible(item, "UseItem")
			ppl:AddCollectible(item)
			sfx:Play(SoundEffect.SOUND_THUMBSUP)
			fam:Remove()
			fam:Kill()
		end
	end

	if EclipsedMod.PandoraJarGift then
		EclipsedMod.PandoraJarGift = nil
	end

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
		if player:GetPlayerType() == EclipsedMod.Characters.Unbidden then
			local killWisp = true
			if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
				killWisp = false
			end
			AddItemFromWisp(player, killWisp)			
		end

		-- tainted unbidden
		if player:GetPlayerType() == EclipsedMod.Characters.Oblivious and not player:HasCollectible(CollectibleType.COLLECTIBLE_BLACK_CANDLE) and not player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
			level:AddCurse(LevelCurse.CURSE_OF_DARKNESS | LevelCurse.CURSE_OF_THE_LOST | LevelCurse.CURSE_OF_THE_UNKNOWN | LevelCurse.CURSE_OF_MAZE | LevelCurse.CURSE_OF_BLIND, false)
		end

		-- memory fragment
		if player:HasTrinket(EclipsedMod.Trinkets.MemoryFragment) and data.MemoryFragment then
			local max = player:GetTrinketMultiplier(EclipsedMod.Trinkets.MemoryFragment) + 2 --(X + 2 = 3) - if X = 1
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
		if player:HasCollectible(EclipsedMod.Items.RedLotus) and player:GetBrokenHearts() > 0 then
			player:AddBrokenHearts(-1)
			--if not data.RedLotusDamage then data.RedLotusDamage = 0 end
			data.RedLotusDamage = data.RedLotusDamage or 0
			local numRedLotus = GetItemsCount(player, EclipsedMod.Items.RedLotus)
			data.RedLotusDamage = data.RedLotusDamage + (EclipsedMod.RedLotus.DamageUp * numRedLotus)
			player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
			player:EvaluateItems()
		end
		if player:HasCollectible(EclipsedMod.Items.VoidKarma) then
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
			multi = multi * GetItemsCount(player, EclipsedMod.Items.VoidKarma)
			data.KarmaStats.Damage = data.KarmaStats.Damage + (EclipsedMod.VoidKarma.DamageUp * multi)
			data.KarmaStats.Firedelay = data.KarmaStats.Firedelay - (EclipsedMod.VoidKarma.TearsUp * multi)
			data.KarmaStats.Shotspeed = data.KarmaStats.Shotspeed + (EclipsedMod.VoidKarma.ShotSpeedUp * multi)
			data.KarmaStats.Range = data.KarmaStats.Range + (EclipsedMod.VoidKarma.RangeUp * multi)
			data.KarmaStats.Speed = data.KarmaStats.Speed + (EclipsedMod.VoidKarma.SpeedUp * multi)
			data.KarmaStats.Luck = data.KarmaStats.Luck + (EclipsedMod.VoidKarma.LuckUp * multi)
			player:AddCacheFlags(EclipsedMod.VoidKarma.EvaCache)
			player:EvaluateItems()
			player:AnimateHappy()
			sfx:Play(SoundEffect.SOUND_1UP) -- play 1up sound
		end
		-- reset modded bombas table

		if EclipsedMod.ModdedBombas then
			EclipsedMod.ModdedBombas = {}
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, EclipsedMod.onNewLevel)

--- NEW ROOM --
function EclipsedMod:onNewRoom()
	local room = game:GetRoom()
 	local level = game:GetLevel()
	if EclipsedMod.NoJamming then EclipsedMod.NoJamming = nil end
	EclipsedMod.PreRoomState = room:IsClear()
	if not room:HasCurseMist() then

		if room:GetType() == RoomType.ROOM_DEVIL then
			local trinkets = Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, EclipsedMod.Trinkets.XmasLetter)
			if #trinkets > 0 then
				for _, trinket in pairs(trinkets) do
					trinket:ToPickup():Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_MYSTERY_GIFT)
				end
				sfx:Play(SoundEffect.SOUND_SATAN_GROW, 1, 2, false, 1.7)
			end
		end
		--curses
		--EclipsedMod.Curses.Warden
		if level:GetCurses() & EclipsedMod.Curses.Warden > 0 then
			for gridIndex = 1, room:GetGridSize() do -- get room size
				local grid = room:GetGridEntity(gridIndex)

				if grid and grid:ToDoor() then -- and grid:GetVariant() == DoorVariant.DOOR_LOCKED then -- and grid.State == 1 then
					local door = grid:ToDoor()
					--print(grid:GetVariant(), grid:GetGridIndex())

					if door:GetVariant() == DoorVariant.DOOR_LOCKED then
						--local doorPos = room:GetDoorSlotPosition(door.Slot)
						door:SetVariant(DoorVariant.DOOR_LOCKED_DOUBLE)
						--door.ExtraVisible = true
						-- so the issue is ExtraSprite not loading. I tried LoadGrapihics and etc. with sprite, but no luck
						-- well We need fuction similar to door:SetLocked(true) or :Bar()
						--door:SetLocked(true)
					end
				end
			end
		end

		-- secrets curse
		if level:GetCurses() & EclipsedMod.Curses.Secrets > 0 then --and (room:GetType() ~= RoomType.ROOM_SECRET or room:GetType() ~= RoomType.ROOM_SUPERSECRET) then
			for gridIndex = 1, room:GetGridSize() do -- get room size
				local grid = room:GetGridEntity(gridIndex)
				if grid and grid:ToDoor() and (grid:ToDoor().TargetRoomType == RoomType.ROOM_SECRET or grid:ToDoor().TargetRoomType == RoomType.ROOM_SUPERSECRET) then
					grid:ToDoor():SetVariant(DoorVariant.DOOR_HIDDEN)
					grid:ToDoor():Close(true)
					grid:PostInit()
				end
			end
		end

		-- fool curse
		if level:GetCurses() & EclipsedMod.Curses.Fool > 0 and room:GetType() == RoomType.ROOM_DEFAULT then
			if not room:IsFirstVisit() and myrng:RandomFloat() < EclipsedMod.FoolThreshold then
				room:RespawnEnemies()
				for gridIndex = 1, room:GetGridSize() do -- get room size
					local grid = room:GetGridEntity(gridIndex)
					if grid and grid:ToDoor()  then
						grid:ToDoor():Open()
					end
				end
				room:SetClear(true)
				EclipsedMod.FoolCurseNoRewards = true
				--EclipsedMod.FoolCurseActive = 2
			end
		end
		--Void curse
		if level:GetCurses() & EclipsedMod.Curses.Void > 0 and not room:IsClear() then
			if myrng:RandomFloat() < EclipsedMod.VoidThreshold then
				EclipsedMod.VoidCurseReroll = 0
				game:ShowHallucination(0, BackdropType.NUM_BACKDROPS)
				game:GetPlayer(0):UseActiveItem(CollectibleType.COLLECTIBLE_D12, myUseFlags)
			end
		end
		--[ curse Emperor
		if level:GetCurses() & EclipsedMod.Curses.Emperor > 0 and not level:IsAscent() and room:GetType() == RoomType.ROOM_BOSS and level:GetStage() ~= LevelStage.STAGE7 then -- level:GetStage() ~= LevelStage.STAGE3_2 and level:GetStage() ~= LevelStage.STAGE7_GREED then
			for slot = 0, DoorSlot.NUM_DOOR_SLOTS do
				if room:GetDoor(slot) and room:GetDoor(slot):ToDoor().TargetRoomType == RoomType.ROOM_DEFAULT then
					room:RemoveDoor(slot)
				end
			end
		end
		--]]
	end
	-- Apocalypse card
	if EclipsedMod.Apocalypse.Room then
		EclipsedMod.Apocalypse.Room = nil
		EclipsedMod.Apocalypse.RNG = nil
	end

	--player
	for playerNum = 0, game:GetNumPlayers()-1 do
		local player = game:GetPlayer(playerNum)
		local data = player:GetData()
		local tempEffects = player:GetEffects()

		if data.UsedSecretLoveLetter then data.UsedSecretLoveLetter = false end

		if not player:HasCurseMistEffect() and not player:IsCoopGhost() then
			if room:IsFirstVisit() and player:HasTrinket(EclipsedMod.Trinkets.XmasLetter) then
				if player:GetTrinketRNG(EclipsedMod.Trinkets.XmasLetter):RandomFloat() <= EclipsedMod.XmasLetter.Chance * player:GetTrinketMultiplier(EclipsedMod.Trinkets.XmasLetter) then
					player:UseActiveItem(CollectibleType.COLLECTIBLE_FORTUNE_COOKIE, myUseFlags)
					if sfx:IsPlaying(SoundEffect.SOUND_FORTUNE_COOKIE) then
						sfx:Stop(SoundEffect.SOUND_FORTUNE_COOKIE)
					end
				end
			end
			--penance
			if not room:IsClear() and player:HasTrinket(EclipsedMod.Trinkets.Penance) then
				local rngTrinket = player:GetTrinketRNG(EclipsedMod.Trinkets.Penance)
				local numTrinket = player:GetTrinketMultiplier(EclipsedMod.Trinkets.Penance)
				for _, entity in pairs(Isaac.GetRoomEntities()) do
					if entity:ToNPC() and entity:IsActiveEnemy() and entity:IsVulnerableEnemy() and not entity:GetData().PenanceRedCross and rngTrinket:RandomFloat() < EclipsedMod.Penance.Chance * numTrinket then
						entity:GetData().PenanceRedCross = player
						local redCross = Isaac.Spawn(EntityType.ENTITY_EFFECT, EclipsedMod.Penance.Effect, 0, entity.Position, Vector.Zero, nil):ToEffect()
						redCross.Color = EclipsedMod.Penance.Color
						redCross:GetData().PenanceRedCrossEffect = true
						redCross.Parent = entity
					end
				end
			end

			--mongo cells
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
				tempEffects:AddNullEffect(NullItemID.ID_LOST_CURSE, true, 1)
			end
			--red button
			if player:HasCollectible(EclipsedMod.Items.RedButton) and not EclipsedMod.PreRoomState then
				NewRoomRedButton(player, room) -- spawn new button
			end
			--red pill
			if data.RedPillDamageUp then
				if not room:IsClear() then
					tempEffects:AddNullEffect(NullItemID.ID_WAVY_CAP_1, false, 1)
				end
				game:ShowHallucination(0, BackdropType.DICE)
				--if sfx:IsPlaying(SoundEffect.SOUND_DEATH_CARD) then
				sfx:Stop(SoundEffect.SOUND_DEATH_CARD)
				--end
			end
			--BlackKnight
			if player:HasCollectible(EclipsedMod.Items.BlackKnight, true) then
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
			if player:HasCollectible(EclipsedMod.Items.RubberDuck) then
				if room:IsFirstVisit() then
					EvaluateDuckLuck(player, data.DuckCurrentLuck + 1)
				elseif data.DuckCurrentLuck > 0 then -- luck down while you have temp.luck
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
			if player:HasCollectible(EclipsedMod.Items.IvoryOil) and room:IsFirstVisit() and not room:IsClear() then
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
			--[[
			for slot = 0, DoorSlot.NUM_DOOR_SLOTS do
				if room:GetDoor(slot) and room:GetDoor(slot):ToDoor().TargetRoomType == RoomType.ROOM_DEFAULT then
					room:RemoveDoor(slot)
				end
			end
			--]]
			for gridIndex = 1, room:GetGridSize() do
				local egrid = room:GetGridEntity(gridIndex)
				if egrid and (egrid:ToRock() or egrid:ToSpikes() or egrid:GetType() == 1) then --  or egrid:ToDoor()
					room:RemoveGridEntity(gridIndex, 0, false)
				elseif egrid and egrid:ToDoor() then
					room:RemoveDoor(egrid:ToDoor().Slot)
				end
			end

			local items = Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE)
			if #items > 0 then
				for _, item in pairs(items) do
					item:Remove()
				end
			end
		end
		-- zero milestone
		if level:GetCurrentRoomIndex() == GridRooms.ROOM_GENESIS_IDX and EclipsedMod.ZeroStoneUsed then
			EclipsedMod.ZeroStoneUsed = false
			if game:IsGreedMode() then
				level:SetStage(LevelStage.STAGE7_GREED, 0)
			else
				level:SetStage(LevelStage.STAGE8, 0)
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
			player:TryRemoveNullCostume(EclipsedMod.Corruption.CostumeHead)
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
				player:TryRemoveNullCostume(EclipsedMod.BG.Costume)
				data.UsedBG = false
			end
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, EclipsedMod.onNewRoom)
--- CLEAN AWARD --
function EclipsedMod:onRoomClear() --rng, spawnPosition
	local room = game:GetRoom()
	local level = game:GetLevel()
	--red button
	RemoveRedButton(room)
	-- jamming curse
	if level:GetCurses() & EclipsedMod.Curses.Jamming > 0 and not room:HasCurseMist() and room:GetType() ~= RoomType.ROOM_BOSS then --room:GetType() ~= RoomType.ROOM_BOSSRUSH
		if myrng:RandomFloat() < EclipsedMod.JammingThreshold and not EclipsedMod.NoJamming then
			game:ShowHallucination(5, 0)
			room:RespawnEnemies()
			EclipsedMod.NoJamming = true
			for _, ppl in pairs(Isaac.FindInRadius(room:GetCenterPos(), 5000, EntityPartition.PLAYER)) do
				ppl:ToPlayer():SetMinDamageCooldown(60)
			end
			return true
		end
	end

	if EclipsedMod.FoolCurseNoRewards then
		EclipsedMod.FoolCurseNoRewards = nil
		if room:GetType() ~= RoomType.ROOM_BOSS then
			return true
		end
	end

	---players
	for playerNum = 0, game:GetNumPlayers()-1 do
		local player = game:GetPlayer(playerNum)
		--local data = player:GetData()
		--queen of spades
		if not player:HasCurseMistEffect() and not player:IsCoopGhost() then
			if player:HasTrinket(EclipsedMod.Trinkets.QueenSpades) then
				local rng = player:GetTrinketRNG(EclipsedMod.Trinkets.QueenSpades)
				local numTrinket = player:GetTrinketMultiplier(EclipsedMod.Trinkets.QueenSpades)
				if rng:RandomFloat() < EclipsedMod.QueenSpades.Chance * numTrinket then
					--print(EntityType.ENTITY_EFFECT, EffectVariant.PORTAL_TELEPORT)
					--Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PORTAL_TELEPORT, 0)
					--for i = 0, 5 do
					local num = 3
					local chance = rng:RandomFloat()
					if chance < 0.05 then num = 0 
					elseif chance < 0.1 then num = 1
					elseif chance < 0.15 then num = 2
					end
					local pos = Isaac.GetFreeNearPosition(room:GetCenterPos(), 50)
					Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, pos, Vector.Zero, nil)
					Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PORTAL_TELEPORT, num, pos, Vector.Zero, nil)
				end
			end
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, EclipsedMod.onRoomClear)
--- CURSE EVAL --
function EclipsedMod:onCurseEval(curseFlags)
	local newCurse = LevelCurse.CURSE_NONE
	--local level = game:GetLevel()

	--curseFlags = EclipsedMod.Curses.Warden

	--[[
	if curseFlags == LevelCurse.CURSE_NONE then
		if myrng:RandomFloat() < EclipsedMod.CurseChance then
			local curseTable = {}
			for _, value in pairs(EclipsedMod.Curses) do
				table.insert(curseTable, value)
			end
			newCurse = curseTable[myrng:RandomInt(#curseTable)+1]
		end
	end
	--]]

	if Isaac.GetChallenge() == EclipsedMod.Challenges.Lobotomy then
		EclipsedMod.VoidThreshold = 1
		curseFlags = curseFlags | EclipsedMod.Curses.Void
	else
		if EclipsedMod.VoidThreshold > 0.15 then
			EclipsedMod.VoidThreshold = 0.15
		end
	end



	local player = game:GetPlayer(0)
	if player:GetPlayerType() == EclipsedMod.Characters.Oblivious and not player:HasCollectible(CollectibleType.COLLECTIBLE_BLACK_CANDLE) and not player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
		newCurse = curseFlags | LevelCurse.CURSE_OF_DARKNESS | LevelCurse.CURSE_OF_THE_LOST | LevelCurse.CURSE_OF_THE_UNKNOWN | LevelCurse.CURSE_OF_MAZE | LevelCurse.CURSE_OF_BLIND
	end

	return curseFlags | newCurse
end

EclipsedMod:AddCallback(ModCallbacks.MC_POST_CURSE_EVAL, EclipsedMod.onCurseEval)
--- NPC DEVOLVE --
function EclipsedMod:onDevolve(entity)
	if entity:GetData().VoidCurseNoDevolve or entity:HasMortalDamage() then -- prevent enemies from rerolling when die
		entity:GetData().VoidCurseNoDevolve = nil
		return true
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_PRE_ENTITY_DEVOLVE, EclipsedMod.onDevolve)
--- NPC UPDATE --
function EclipsedMod:onUpdateNPC(entityNPC)
	entityNPC = entityNPC:ToNPC()
	local eData = entityNPC:GetData()
	
	-- secret love letter
	if entityNPC.FrameCount == 1 and EclipsedMod.SecretLoveLetter.AffectedEnemies and #EclipsedMod.SecretLoveLetter.AffectedEnemies > 0 then
		if entityNPC.Type == EclipsedMod.SecretLoveLetter.AffectedEnemies[1] and entityNPC.Variant == EclipsedMod.SecretLoveLetter.AffectedEnemies[2] then
			sfx:Play(SoundEffect.SOUND_KISS_LIPS1)
			Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, entityNPC.Position, Vector.Zero, nil):SetColor(EclipsedMod.PinkColor,50,1, false, false) --:ToEffect()
			--entityNPC:AddEntityFlags(EntityFlag.FLAG_FRIENDLY | EntityFlag.FLAG_CHARM|  EntityFlag.FLAG_PERSISTENT)
			entityNPC:AddCharmed(EntityRef(EclipsedMod.SecretLoveLetter.AffectedEnemies[3]), -1)
		end
	end
	
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
		if eData.BackStabbed == 0 then
			eData.BackStabbed = nil
			if entityNPC:HasEntityFlags(EntityFlag.FLAG_BLEED_OUT) then
				entityNPC:ClearEntityFlags(EntityFlag.FLAG_BLEED_OUT)
			end
		end
	end
	if eData.Magnetized then
		eData.Magnetized = eData.Magnetized - 1
		if eData.Magnetized == 0 then
			eData.Magnetized = nil
			if entityNPC:HasEntityFlags(EntityFlag.FLAG_MAGNETIZED) then
				entityNPC:ClearEntityFlags(EntityFlag.FLAG_MAGNETIZED)
			end
		end
	end

	if eData.BaitedTomato then
		eData.BaitedTomato = eData.BaitedTomato - 1
		if eData.BaitedTomato == 0 then
			eData.BaitedTomato = nil
			if entityNPC:HasEntityFlags(EntityFlag.FLAG_BAITED) then
				entityNPC:ClearEntityFlags(EntityFlag.FLAG_BAITED)
			end
		end
	end
	-- melted candle waxed
	if eData.Waxed then
		if eData.Waxed == EclipsedMod.MeltedCandle.FrameCount then entityNPC:ClearEntityFlags(EntityFlag.FLAG_BURN) end
		eData.Waxed = eData.Waxed - 1
		if entityNPC:HasMortalDamage() then
			local flame = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.RED_CANDLE_FLAME, 0, entityNPC.Position, Vector.Zero, nil):ToEffect()
			flame.CollisionDamage = 23
			flame:SetTimeout(360)
		end
		if eData.Waxed <= 0 then eData.Waxed = nil end
	end
	-- penance
	if entityNPC:HasMortalDamage() and entityNPC:GetData().PenanceRedCross then
		local ppl = entityNPC:GetData().PenanceRedCross
		local timeout = EclipsedMod.Penance.Timeout
		PenanceShootLaser(0, timeout, entityNPC.Position, ppl)
		PenanceShootLaser(90, timeout, entityNPC.Position, ppl)
		PenanceShootLaser(180, timeout, entityNPC.Position, ppl)
		PenanceShootLaser(270, timeout, entityNPC.Position, ppl)
		entityNPC:GetData().PenanceRedCross = false
	end
	
	
	
end
EclipsedMod:AddCallback(ModCallbacks.MC_PRE_NPC_UPDATE, EclipsedMod.onUpdateNPC)

--- NPC INIT --
function EclipsedMod:onEnemyInit(entity)
	local level = game:GetLevel()
	local room = game:GetRoom()
	entity = entity:ToNPC()
	-- oblivion card
	if #EclipsedMod.OblivionCard.ErasedEntities ~= 0 then
		for _, enemy in ipairs(EclipsedMod.OblivionCard.ErasedEntities) do
			if entity.Type == enemy[1] and entity.Variant == enemy[2] then
				Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, entity.Position, Vector.Zero, nil):SetColor(EclipsedMod.OblivionCard.PoofColor,50,1, false, false) --:ToEffect()
				entity:Remove()
				break
			end
		end
	end
	-- soul unbidden
	if #EclipsedMod.Lobotomy.ErasedEntities ~= 0 then
		for _, enemy in ipairs(EclipsedMod.Lobotomy.ErasedEntities) do
			if entity.Type == enemy[1] and entity.Variant == enemy[2] then
				Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, entity.Position, Vector.Zero, nil):SetColor(EclipsedMod.OblivionCard.PoofColor,50,1, false, false) --:ToEffect()
				entity:Remove()
				break
			end
		end
	end

	-- delirious bum / cell
	if EclipsedMod.DeliriousBumCharm then
		entity:AddEntityFlags(EntityFlag.FLAG_PERSISTENT)
		EclipsedMod.DeliriousBumCharm = nil
    end
	EclipsedMod.DeliriumBeggar.Enable = EclipsedMod.DeliriumBeggar.Enable or {}
	if entity:IsActiveEnemy() and entity:IsVulnerableEnemy() and not entity:IsBoss() and not EclipsedMod.DeliriumBeggar.Enable[tostring(entity.Type..entity.Variant)] then
		EclipsedMod.DeliriumBeggar.Enable[tostring(entity.Type..entity.Variant)] = true
		EclipsedMod.DeliriumBeggar.Enemies = EclipsedMod.DeliriumBeggar.Enemies or {}
		table.insert(EclipsedMod.DeliriumBeggar.Enemies, {entity.Type, entity.Variant})
	end

	if not room:HasCurseMist() then
		-- curse of Pride
		if level:GetCurses() & EclipsedMod.Curses.Pride > 0  then
			if entity:IsActiveEnemy() and entity:IsVulnerableEnemy() and not entity:IsBoss() and not entity:IsChampion() and entity:GetDropRNG():RandomFloat() < EclipsedMod.PrideThreshold then
				--entity:Morph(entity.Type, entity.Variant, entity.SubType, bomb:GetDropRNG():RandomInt(26))
				--print(entity.InitSeed)
				entity:MakeChampion(Random()+1, -1, true)
			end
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_NPC_INIT, EclipsedMod.onEnemyInit)
--- NPC DEATH --
function EclipsedMod:onNPCDeath(enemy)
	--local eData = enemy:GetData()
	if enemy:IsActiveEnemy(true) then
	--if not enemy:IsVulnerableEnemy() then
		for playerNum = 0, game:GetNumPlayers()-1 do
			local player = game:GetPlayer(playerNum)

			if not player:HasCurseMistEffect() and not player:IsCoopGhost() then
				if player:HasCollectible(EclipsedMod.Items.DMS) then
					local rng = player:GetCollectibleRNG(EclipsedMod.Items.DMS)
					if rng:RandomFloat() < EclipsedMod.DMS.Chance then
						local purgesoul = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PURGATORY, 1, enemy.Position, Vector.Zero, player):ToEffect() -- subtype = 0 is rift, 1 is soul
						purgesoul:GetSprite():Play("Charge", true) -- set animation (skip appearing from rift)
						--purgesoul.Color = Color(0.1,0.1,0.1,1)
					end
				end

				if player:HasTrinket(EclipsedMod.Trinkets.MilkTeeth) then
					local rng = player:GetTrinketRNG(EclipsedMod.Trinkets.MilkTeeth)
					local numTrinket = player:GetTrinketMultiplier(EclipsedMod.Trinkets.MilkTeeth)
					--if player:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_BOX) then numTrinket = numTrinket + 1 end
					if rng:RandomFloat() < EclipsedMod.MilkTeeth.CoinChance * numTrinket then
						local randVector = RandomVector()*5
						local coin = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, 1, enemy.Position, randVector, nil)
						coin:GetData().MilkTeethDespawn = EclipsedMod.MilkTeeth.CoinDespawnTimer --= 35
					end
				end
			end
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, EclipsedMod.onNPCDeath)
--- NPC TAKE DMG --
function EclipsedMod:onLaserDamage(entity, _, flags, source, _)
	local level = game:GetLevel()

	if level:GetCurses() & EclipsedMod.Curses.Bishop > 0 and entity:IsVulnerableEnemy() and entity:IsActiveEnemy() and entity:GetDropRNG():RandomFloat() < EclipsedMod.BishopThreshold then
		entity:SetColor(Color(0.3,0.3,1,1), 10, 100, true, false)
		return false
	end

	if flags & DamageFlag.DAMAGE_LASER == DamageFlag.DAMAGE_LASER and entity:IsVulnerableEnemy() and entity:IsActiveEnemy() and source.Entity and source.Entity:ToPlayer() then
		local player = source.Entity:ToPlayer()
		local data = player:GetData()
		if not player:HasCurseMistEffect() and not player:IsCoopGhost() then
			if player:HasCollectible(EclipsedMod.Items.MeltedCandle) and not entity:GetData().Waxed then
				local rng = player:GetCollectibleRNG(EclipsedMod.Items.MeltedCandle)
				if rng:RandomFloat() + player.Luck/100 >= EclipsedMod.MeltedCandle.TearChance then
					entity:AddFreeze(EntityRef(player), EclipsedMod.MeltedCandle.FrameCount)
					if entity:HasEntityFlags(EntityFlag.FLAG_FREEZE) then
						--entity:AddBurn(EntityRef(player), 1, player.Damage) -- the issue is Freeze stops framecount of entity, so it won't call NPC_UPDATE.
						entity:AddEntityFlags(EntityFlag.FLAG_BURN)          -- the burn timer doesn't update, so just add burn until npc have freeze
						entity:GetData().Waxed = EclipsedMod.MeltedCandle.FrameCount
						entity:SetColor(EclipsedMod.MeltedCandle.TearColor, EclipsedMod.MeltedCandle.FrameCount, 100, false, false)
					end
				end
			end
		end
		if data.UsedBG then -- and not entity:GetData().BG then --and player:HasEntityFlags(EntityFlag.FLAG_BLEED_OUT) then
			entity:AddEntityFlags(EntityFlag.FLAG_BLEED_OUT)
			entity:GetData().BG = EclipsedMod.BG.FrameCount
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, EclipsedMod.onLaserDamage)
--- KNIFE COLLISION --
function EclipsedMod:onKnifeCollision(knife, collider) -- low
	if knife.SpawnerEntity then
		if knife.SpawnerEntity:ToPlayer() and collider:IsVulnerableEnemy() then
			local player = knife.SpawnerEntity:ToPlayer()
			local data = player:GetData()
			local entity = collider:ToNPC()
			--local eData = entity:GetData()
			if not player:HasCurseMistEffect() and not player:IsCoopGhost() then
				if player:HasCollectible(EclipsedMod.Items.MeltedCandle) and not entity:GetData().Waxed then
					local rng = player:GetCollectibleRNG(EclipsedMod.Items.MeltedCandle)
					if rng:RandomFloat() + player.Luck/100 >= EclipsedMod.MeltedCandle.TearChance then
						entity:AddFreeze(EntityRef(player), EclipsedMod.MeltedCandle.FrameCount)
						if entity:HasEntityFlags(EntityFlag.FLAG_FREEZE) then
							--entity:AddBurn(EntityRef(player), 1, player.Damage) -- the issue is Freeze stops framecount of entity, so it won't call NPC_UPDATE.
							entity:AddEntityFlags(EntityFlag.FLAG_BURN)          -- the burn timer doesn't update
							entity:GetData().Waxed = EclipsedMod.MeltedCandle.FrameCount
							entity:SetColor(EclipsedMod.MeltedCandle.TearColor, EclipsedMod.MeltedCandle.FrameCount, 100, false, false)
						end
					end
				end
			end
			-- bleeding grimoire
			if data.UsedBG then -- and not entity:GetData().BG then --and player:HasEntityFlags(EntityFlag.FLAG_BLEED_OUT) then
				entity:AddEntityFlags(EntityFlag.FLAG_BLEED_OUT)
				entity:GetData().BG = EclipsedMod.BG.FrameCount
			end
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_PRE_KNIFE_COLLISION, EclipsedMod.onKnifeCollision) --KnifeSubType
--- TEARS UPDATE --
function EclipsedMod:onTearUpdate(tear)
	if not tear.SpawnerEntity then return end
	if not tear.SpawnerEntity:ToPlayer() then return end
	local tearData = tear:GetData()
	local tearSprite = tear:GetSprite()
	local room = game:GetRoom()
	local player = tear.SpawnerEntity:ToPlayer()
	local data = player:GetData()
	if tearData.UnbiddenTear then
		tear.Color = EclipsedMod.ObliviousData.Stats.TEAR_COLOR
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
		--tear.Velocity = tearData.InitVelocity
		tear.CollisionDamage = player.Damage * EclipsedMod.InfiniteBlades.DamageMulti
		--if tear.FrameCount == 1 then
		if tearData.InitAngle then
			tearSprite.Rotation = tearData.InitAngle:GetAngleDegrees() - 45
			tearData.AngleSaved = tearSprite.Rotation
			tearData.InitAngle = nil
		else
			tearSprite.Rotation = tearData.AngleSaved
		end
		if  tearSprite.Rotation <= -180 then
			tearSprite.Rotation = -90
			tearSprite.FlipX = true
		elseif tearSprite.Rotation >= 135 then
			tearSprite.Rotation = -45
			tearSprite.FlipX = true
		elseif tearSprite.Rotation >= 90 then
			tearSprite.Rotation = 0
			tearSprite.FlipX = true
		end
		--end
		if not room:IsPositionInRoom(tear.Position, -100) then
			tear:Remove()
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, EclipsedMod.onTearUpdate)
--- TEARS COLLISION --
function EclipsedMod:onTearCollision(tear, collider) --tear, collider, low
	tear = tear:ToTear()
	--local tearData = tear:GetData()
	if tear.SpawnerEntity and tear.SpawnerEntity:ToPlayer() then
		if collider:IsVulnerableEnemy() then
			local player = tear.SpawnerEntity:ToPlayer()
			local data = player:GetData()
			local entity = collider:ToNPC()
			--local eData = entity:GetData()
			if not player:HasCurseMistEffect() and not player:IsCoopGhost() then
				if player:HasCollectible(EclipsedMod.Items.MeltedCandle) and not entity:GetData().Waxed then
					local rng = player:GetCollectibleRNG(EclipsedMod.Items.MeltedCandle)
					if rng:RandomFloat() + player.Luck/100 >= EclipsedMod.MeltedCandle.TearChance then
						entity:AddFreeze(EntityRef(player), EclipsedMod.MeltedCandle.FrameCount)
						if entity:HasEntityFlags(EntityFlag.FLAG_FREEZE) then
							--entity:AddBurn(EntityRef(player), 1, 2*player.Damage) -- the issue is Freeze stops framecount of entity, so it won't call NPC_UPDATE.
							entity:AddEntityFlags(EntityFlag.FLAG_BURN )
							entity:GetData().Waxed = EclipsedMod.MeltedCandle.FrameCount
							entity:SetColor(EclipsedMod.MeltedCandle.TearColor, EclipsedMod.MeltedCandle.FrameCount, 100, false, false)
						end
					end
				end
			end
			if data.UsedBG then -- and not entity:GetData().BG then --and player:HasEntityFlags(EntityFlag.FLAG_BLEED_OUT) then
				entity:AddEntityFlags(EntityFlag.FLAG_BLEED_OUT)
				entity:GetData().BG = EclipsedMod.BG.FrameCount
			end
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_PRE_TEAR_COLLISION, EclipsedMod.onTearCollision)
--- OBLIVION CARD TEAR COLLISION --
function EclipsedMod:onTearOblivionCardCollision(tear, collider) --tear, collider, low
	tear = tear:ToTear()
	local tearData = tear:GetData()
	-- oblivion card
	if tearData.OblivionTear then
		if collider:ToNPC() then
			local player = tear.SpawnerEntity:ToPlayer()
			--local data = player:GetData()
			local enemy = collider:ToNPC()
			table.insert(EclipsedMod.OblivionCard.ErasedEntities, {enemy.Type, enemy.Variant})
			for _, entity in pairs(Isaac.FindInRadius(player.Position, 5000, EntityPartition.ENEMY)) do -- get monsters in room
				if entity.Type == enemy.Type and entity.Variant == enemy.Variant then
					Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, entity.Position, Vector.Zero, nil):SetColor(EclipsedMod.OblivionCard.PoofColor,50,1, false, false)
					entity:Remove()
				end
			end
			tear:Remove()
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_PRE_TEAR_COLLISION, EclipsedMod.onTearOblivionCardCollision, TearVariant.CHAOS_CARD) -- EclipsedMod.OblivionCard.TearVariant)
--- OBLIVION CARD TEAR INIT --
function EclipsedMod:onOblivionTearInit(tear) -- card, player, useflag
	--print(tear.SubType)
	if tear.SpawnerEntity:ToPlayer() then
		local player = tear.SpawnerEntity:ToPlayer()
		local data = player:GetData()
		-- oblivion card
		if data.UsedOblivionCard then
			--tear:ChangeVariant(EclipsedMod.OblivionCard.TearVariant)
			data.UsedOblivionCard = nil
			local tearData = tear:GetData()
			tearData.OblivionTear = true
			local sprite = tear:GetSprite()
			sprite:ReplaceSpritesheet(0, EclipsedMod.OblivionCard.SpritePath)
			sprite:LoadGraphics() -- replace sprite
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_TEAR_INIT, EclipsedMod.onOblivionTearInit, TearVariant.CHAOS_CARD) --EclipsedMod.OblivionCard.TearVariant)

--- SECRET LOVE LETTER TEAR COLLISION --
function EclipsedMod:onLoveLetterCollision(tear, collider) --tear, collider, low
	tear = tear:ToTear()
	local tearData = tear:GetData()
	if tearData.SecretLoveLetter then
		if collider:ToNPC() and collider:IsActiveEnemy() and collider:IsVulnerableEnemy() and not collider:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) then
			tear:ChangeVariant(TearVariant.BLUE)
			tear:Remove()
			local player = tear.SpawnerEntity:ToPlayer()
			local enemy = collider:ToNPC()
			sfx:Play(SoundEffect.SOUND_KISS_LIPS1)
			if not enemy:IsBoss() and not EclipsedMod.SecretLoveLetter.BannedEnemies[enemy.Type] then
				EclipsedMod.SecretLoveLetter.AffectedEnemies[1] = enemy.Type
				EclipsedMod.SecretLoveLetter.AffectedEnemies[2] = enemy.Variant
				EclipsedMod.SecretLoveLetter.AffectedEnemies[3] = player
				--table.insert(EclipsedMod.SecretLoveLetter.AffectedEnemies, {enemy.Type, enemy.Variant})
				for _, entity in pairs(Isaac.FindInRadius(player.Position, 5000, EntityPartition.ENEMY)) do -- get monsters in room
					if entity.Type == enemy.Type and entity.Variant == enemy.Variant then
						Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, entity.Position, Vector.Zero, nil):SetColor(EclipsedMod.PinkColor,50,1, false, false)
						--entity:AddEntityFlags(EntityFlag.FLAG_FRIENDLY | EntityFlag.FLAG_CHARM | EntityFlag.FLAG_PERSISTENT)
						entity:AddCharmed(EntityRef(player), -1) -- makes the effect permanent and the enemy will follow you even to different rooms.
					end
				end
			else
				enemy:AddCharmed(EntityRef(player), 150)
			end
			return true
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_PRE_TEAR_COLLISION, EclipsedMod.onLoveLetterCollision, EclipsedMod.SecretLoveLetter.TearVariant)

--- PROJECTILES INIT --
function EclipsedMod:onProjectileInit(projectile)
	local level = game:GetLevel()
	local room = game:GetRoom()
	if not room:HasCurseMist() and projectile.SpawnerEntity then
		if Isaac.GetChallenge() == EclipsedMod.Challenges.Magician or level:GetCurses() & EclipsedMod.Curses.Magician > 0 then
			if not projectile.SpawnerEntity:IsBoss() and Isaac.GetChallenge() ~= EclipsedMod.Challenges.Magician then
				projectile:AddProjectileFlags(ProjectileFlags.SMART)
			end
		end
		if level:GetCurses() & EclipsedMod.Curses.Poverty > 0 then
			projectile:AddProjectileFlags(ProjectileFlags.GREED)
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_PROJECTILE_INIT, EclipsedMod.onProjectileInit)
--- INPUT ACTIONS --
function EclipsedMod:onInputAction(entity, inputHook, buttonAction)
	if entity and entity.Type == EntityType.ENTITY_PLAYER and not entity:IsDead() then
		local player = entity:ToPlayer()
		local sprite = player:GetSprite()
		--- COPY from Edith mod ------------
		if not player:HasCurseMistEffect() and not player:IsCoopGhost() then
			if player:HasCollectible(EclipsedMod.Items.BlackKnight, true) then
				--if sprite:GetAnimation() == "BigJumpUp" or sprite:GetAnimation() == "BigJumpDown" then
				if EclipsedMod.BlackKnight.TeleportAnimations[sprite:GetAnimation()] then
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
			if player:HasCollectible(EclipsedMod.Items.WhiteKnight, true) then
				if EclipsedMod.BlackKnight.TeleportAnimations[sprite:GetAnimation()] then
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
EclipsedMod:AddCallback(ModCallbacks.MC_INPUT_ACTION, EclipsedMod.onInputAction)
--- PILL INIT --
function EclipsedMod:onPostPillInit(pickup) -- pickup
	for playerNum = 0, game:GetNumPlayers()-1 do
		local player = game:GetPlayer(playerNum)
		if not player:HasCurseMistEffect() and not player:IsCoopGhost() then
			if player:HasTrinket(EclipsedMod.Trinkets.Duotine) then
				local newSub = EclipsedMod.Pickups.RedPill
				--print(pickup.SubType)
				if pickup.SubType >= PillColor.PILL_GIANT_FLAG then newSub = EclipsedMod.Pickups.RedPillHorse end
				pickup:Morph(5, 300, newSub, true, false, true)
			end
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, EclipsedMod.onPostPillInit, PickupVariant.PICKUP_PILL)
--- PICKUP INIT --
function EclipsedMod:onPostPickupInit(pickup)
	for playerNum = 0, game:GetNumPlayers()-1 do
		local player = game:GetPlayer(playerNum):ToPlayer()
		if not player:HasCurseMistEffect() and not player:IsCoopGhost() then
			-- binder clip
			if player:HasTrinket(EclipsedMod.Trinkets.BinderClip) then
				local rng = player:GetTrinketRNG(EclipsedMod.Trinkets.BinderClip)
				local numTrinket = player:GetTrinketMultiplier(EclipsedMod.Trinkets.BinderClip)
				if EclipsedMod.BinderClip.DoublerChance * numTrinket > rng:RandomFloat() then
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
			-- if player has midas curse, turn all pickups into golden -> check chance
			if player:HasCollectible(EclipsedMod.Items.MidasCurse) then
				if player:GetCollectibleRNG(EclipsedMod.Items.MidasCurse):RandomFloat() < EclipsedMod.MidasCurse.TurnGoldChance then
					TurnPickupsGold(pickup:ToPickup())
					break
				end
			end
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, EclipsedMod.onPostPickupInit)
--- COIN UPDATE --
function EclipsedMod:onCoinUpdate(pickup)
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
EclipsedMod:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, EclipsedMod.onCoinUpdate, PickupVariant.PICKUP_COIN)
--- CARD UPDATE --
function EclipsedMod:DeliriousPickupsUpdate(pickup)
	if EclipsedMod.DeliObject.CheckGetCard[pickup.SubType] then
		local rng = pickup:GetDropRNG()
		local dataDeli = pickup:GetData()
		dataDeli.CycleTimer = dataDeli.CycleTimer or rng:RandomInt(EclipsedMod.DeliObject.CycleTimer) + EclipsedMod.DeliObject.CycleTimer
		dataDeli.CycleTimer = dataDeli.CycleTimer - 1
		if dataDeli.CycleTimer <= 0 then
			local newDeli = EclipsedMod.DeliObject.Variants[rng:RandomInt(#EclipsedMod.DeliObject.Variants)+1]
			pickup:ToPickup():Morph(pickup.Type, pickup.Variant, newDeli, true, false, true)
			dataDeli.CycleTimer = rng:RandomInt(EclipsedMod.DeliObject.CycleTimer) + EclipsedMod.DeliObject.CycleTimer
			--Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, pickup.Position, Vector.Zero, nil).Color = Color(5,5,5,1)
			game:ShowHallucination(5, BackdropType.NUM_BACKDROPS)
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, EclipsedMod.DeliriousPickupsUpdate, PickupVariant.PICKUP_TAROTCARD)
--- COLLECTIBLE UPDATE --
function EclipsedMod:CollectibleUpdate(entity)
	if Isaac.GetChallenge() == EclipsedMod.Challenges.Potatoes then
		local lunch = CollectibleType.COLLECTIBLE_LUNCH
		if entity.SubType ~= lunch and entity.SubType ~= 0 then
			entity:ToPickup():Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, lunch, true)
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, EclipsedMod.CollectibleUpdate, PickupVariant.PICKUP_COLLECTIBLE)
--- COLLECTIBLE COLLISION --
function EclipsedMod:onItemCollision(pickup, collider)
	if collider:ToPlayer() then
		local player = collider:ToPlayer()
		if not player:HasCurseMistEffect() and not player:IsCoopGhost() then
			local room = game:GetRoom()
			local level = game:GetLevel()
			--EclipsedMod.Curses.Desolation
			if level:GetCurses() & EclipsedMod.Curses.Desolation > 0 and pickup:GetDropRNG():RandomFloat() < EclipsedMod.DesolationThreshold and pickup.SubType ~= 0 and GetCurrentDimension() ~= 2 and level:GetCurrentRoomIndex() ~= GridRooms.ROOM_GENESIS_IDX and room:GetType() ~= RoomType.ROOM_CHALLENGE and room:GetType() ~= RoomType.ROOM_BOSSRUSH and not pickup:IsShopItem() and not CheckItemTags(pickup.SubType, ItemConfig.TAG_QUEST) then
				pickup:Remove()
				local wispItem = player:AddItemWisp(pickup.SubType, pickup.Position):ToFamiliar()
				--wispItem:GetData().AddAfterOneRoom = level:GetCurrentRoomIndex()
				wispItem:GetData().AddNextFloor = player

				sfx:Play(SoundEffect.SOUND_SOUL_PICKUP)
				return false
			end

			if CheckItemTags(pickup.SubType, ItemConfig.TAG_FOOD) then
				if player:HasCollectible(EclipsedMod.Items.MidasCurse) and EclipsedMod.MidasCurse.TurnGoldChance == EclipsedMod.MidasCurse.MaxGold then
					pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_GOLDEN)
					local rngMidasCurse = player:GetCollectibleRNG(EclipsedMod.Items.MidasCurse)
					local coinNum = rngMidasCurse:RandomInt(8)+1 -- random number from 1 to 8
					for _ = 1, coinNum do
						local randVector = RandomVector()*coinNum
						Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, 0, pickup.Position, randVector, player)
						--local coin = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, 0, pickup.Position, randVector, player) --anyway turns into golden coin
					end
				end
			end
			--local tempEffects = player:GetEffects()
			if player:HasTrinket(EclipsedMod.Trinkets.LostFlower) and (player:GetPlayerType() == PlayerType.PLAYER_THELOST or player:GetPlayerType() == PlayerType.PLAYER_THELOST_B or player:GetPlayerType() == EclipsedMod.Characters.Oblivious) then
				if EclipsedMod.LostFlower.ItemGiveEternalHeart[pickup.SubType] then
					player:UseCard(Card.CARD_HOLY, myUseFlags) -- give holy card effect
				end
			end
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, EclipsedMod.onItemCollision, PickupVariant.PICKUP_COLLECTIBLE)
--- PICKUP COLLISION --
function EclipsedMod:onItemCollision(pickup, collider, _) --add --PickupVariant.PICKUP_SHOPITEM
	if collider:ToPlayer() and pickup.Variant ~= PickupVariant.PICKUP_COLLECTIBLE and pickup.OptionsPickupIndex ~= 0 then
		local player = collider:ToPlayer()
		if not player:HasCurseMistEffect() and not player:IsCoopGhost() then
			if player:HasTrinket(EclipsedMod.Trinkets.BinderClip) then
				pickup.OptionsPickupIndex = 0
			end
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, EclipsedMod.onItemCollision)
--- HEART COLLISION --
function EclipsedMod:onHeartCollision(pickup, collider)
	if collider:ToPlayer() then
		local player = collider:ToPlayer()
		if not player:HasCurseMistEffect() and not player:IsCoopGhost() then
			if player:HasTrinket(EclipsedMod.Trinkets.LostFlower) then
				local playerType = player:GetPlayerType()
				if playerType == PlayerType.PLAYER_THELOST or playerType == PlayerType.PLAYER_THELOST_B or player:GetPlayerType() == EclipsedMod.Characters.Oblivious then  -- if player is Lost/T.Lost
					if pickup.SubType == HeartSubType.HEART_ETERNAL then
						player:UseCard(Card.CARD_HOLY,  myUseFlags) -- give holy card effect
					end
				end
			end

			if pickup:GetData().Pomped then
				pickup:Remove()
				return true

			elseif player:HasTrinket(EclipsedMod.Trinkets.Pompom) then
				local rng = player:GetTrinketRNG(EclipsedMod.Trinkets.Pompom)
				local numTrinket = player:GetTrinketMultiplier(EclipsedMod.Trinkets.Pompom) -- 1
				if rng:RandomFloat() < EclipsedMod.Pompom.Chance * numTrinket then --and player:GetHearts() == player:GetEffectiveMaxHearts()

					if pickup.SubType == HeartSubType.HEART_HALF then
						numTrinket = numTrinket
					elseif pickup.SubType == HeartSubType.HEART_FULL or pickup.SubType == HeartSubType.HEART_SCARED or pickup.SubType == HeartSubType.HEART_ROTTEN then
						numTrinket = numTrinket + 1
					elseif pickup.SubType == HeartSubType.HEART_DOUBLEPACK then
						numTrinket = numTrinket + 3
					else
						return nil
					end

					for _ = 1, numTrinket do
						local wisp = EclipsedMod.Pompom.WispsList[rng:RandomInt(#EclipsedMod.Pompom.WispsList)+1]
						player:AddWisp(wisp, pickup.Position, true)
					end
					pickup:Remove()
					sfx:Play(SoundEffect.SOUND_SOUL_PICKUP)
					pickup:GetData().Pomped = true
					return true

				end
			end
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, EclipsedMod.onHeartCollision, PickupVariant.PICKUP_HEART)
--- BOMB COLLISION --
function EclipsedMod:onBombPickupCollision(pickup, collider)
	if collider:ToPlayer() then
		local player = collider:ToPlayer()
		if (player:GetPlayerType() == EclipsedMod.Characters.Nadab or player:GetPlayerType() == EclipsedMod.Characters.Abihu) then
			if player:HasGoldenBomb() and pickup.SubType == BombSubType.BOMB_GOLDEN then
				player:AddGoldenHearts(1)
			elseif player:HasFullHearts() and (pickup.SubType == BombSubType.BOMB_NORMAL or pickup.SubType == BombSubType.BOMB_DOUBLEPACK) then
				return false
			end
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, EclipsedMod.onBombPickupCollision, PickupVariant.PICKUP_BOMB)
--- CARD COLLISION --
function EclipsedMod:onDellCollision(pickup, collider) --pickup, collider, low
	if EclipsedMod.DeliObject.CheckGetCard[pickup.SubType] and collider:ToPlayer() then
		local player = collider:ToPlayer()
		--print(player:GetSprite():GetAnimation())

		for slot = 0, 1 do
			if EclipsedMod.DeliObject.CheckGetCard[player:GetCard(slot)] then
				pickup:Remove()
				player:SetCard(slot, pickup.SubType) --EclipsedMod.DeliObject.Variants[rng:RandomInt(#EclipsedMod.DeliObject.Variants)+1])
				sfx:Play(SoundEffect.SOUND_EDEN_GLITCH, 1, 0, false, 1, 0)
				game:ShowHallucination(5, BackdropType.NUM_BACKDROPS)
				--Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, pickup.Position, Vector.Zero, nil).Color = Color(5,5,5,1)
				return true
			end
		end
		--end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, EclipsedMod.onDellCollision, PickupVariant.PICKUP_TAROTCARD)
--- TRINKET UPDATE --
function EclipsedMod:onTrinketUpdate(trinket)
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
			if trinket.SubType == EclipsedMod.Trinkets.AbyssCart then -- abyss cartridge spawn eternal heart
				DebugSpawn(PickupVariant.PICKUP_HEART, HeartSubType.HEART_ETERNAL, trinket.Position)
			end
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, EclipsedMod.onTrinketUpdate, PickupVariant.PICKUP_TRINKET)
--- GET CARD --
function EclipsedMod:onGetCard(rng, card) --, includePlayingCards, includeRunes, onlyRunes)
	if card == EclipsedMod.Pickups.BannedCard then
		if rng:RandomFloat() <= EclipsedMod.BannedCard.Chance then
			game:GetHUD():ShowFortuneText("Banned card!")
		else
			return EclipsedMod.Pickups.DeliObjectCell
		end
	elseif card == EclipsedMod.Pickups.RedPill or card == EclipsedMod.Pickups.RedPillHorse then
		return EclipsedMod.Pickups.DeliObjectCell
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_GET_CARD, EclipsedMod.onGetCard)
--- BOMB UPDATE --
function EclipsedMod:onBombUpdate(bomb)
	local bombSprite = bomb:GetSprite()
	local bombData = bomb:GetData()
	local level = game:GetLevel()
	local room = game:GetRoom()
	local index = bomb:GetDropRNG():GetSeed() -- ptr hash not gonna work cause it's game logic my ass
	
	if not room:HasCurseMist() then
		-- curse of bell
		if level:GetCurses() & EclipsedMod.Curses.Bell > 0 and EclipsedMod.BellCurse[bomb.Variant] and bomb.FrameCount == 1 then
			bomb:Remove()
			Isaac.Spawn(bomb.Type, BombVariant.BOMB_GOLDENTROLL, 0, bomb.Position, bomb.Velocity, bomb.SpawnerEntity)
		end
		--print(bomb.FrameCount, bomb.Size)
		-- bomb init
		if bomb.FrameCount == 1 then -- or (bomb.FrameCount == 1 and (bomb.IsFetus or bombData.Mirror or bomb.Variant == BombVariant.BOMB_BIG or bomb.Variant == BombVariant.BOMB_BUTT or bomb.Size == 8.0)) then
			if bomb.SpawnerEntity and bomb.SpawnerEntity:ToPlayer() then
				local player = bomb.SpawnerEntity:ToPlayer()
				local playerData = player:GetData()

				if not EclipsedMod.ModdedBombas then EclipsedMod.ModdedBombas = {} end
				
				if not bombData.Mirror then
					if EclipsedMod.ModdedBombas[index] then
						local cacheData = EclipsedMod.ModdedBombas[index]
						if cacheData.Gravity then bombData.Gravity = true else bombData.Gravity = false end
						if cacheData.Compo then bombData.Compo = true else bombData.Compo = false end
						if cacheData.Mirror then bombData.Mirror = true else bombData.Mirror = false end
						if cacheData.Frosty then bombData.Frosty = true else bombData.Frosty = false end
						if cacheData.DeadEgg then bombData.DeadEgg = true else bombData.DeadEgg = false end
						if cacheData.Dicey then bombData.Dicey = true else bombData.Dicey = false end
						if cacheData.BobTongue then bombData.BobTongue = true else bombData.BobTongue = false end
					end
				end
				
				--if bombData.Mirror and not bomb.Parent then
				if bombData.Mirror and (not bomb.Parent or bomb.FrameCount == 0) then -- or (bomb.Variant == BombVariant.BOMB_THROWABLE) then -- don't make it elseif cause you need to check it 2 times (you = me from future)
					bomb:Remove() -- remove mirror bombs when entering room where you placed bomb. else it would be duplicated
				end
				
				if playerData.UsedSoulNadabAbihu then
					bomb:AddTearFlags(TearFlags.TEAR_BURN)
				end
				
				if player:HasCollectible(CollectibleType.COLLECTIBLE_NANCY_BOMBS) then
					if bombData.Dicey == nil and bomb:GetDropRNG():RandomFloat() < EclipsedMod.DiceBombs.NancyChance then
						InitDiceyBomb(bomb, bombData)
					end
					if bombData.Gravity == nil and bomb:GetDropRNG():RandomFloat() < EclipsedMod.GravityBombs.NancyChance then
						InitGravityBomb(bomb, bombData)
					end
					if bombData.Frosty == nil and bomb:GetDropRNG():RandomFloat() < EclipsedMod.FrostyBombs.NancyChance then
						InitFrostyBomb(bomb, bombData)
					end
				end
				
				-- bob's tongue
				if player:HasTrinket(EclipsedMod.Trinkets.BobTongue) then
					bombData.BobTongue = true
					local fartRingEffect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.FART_RING, 0, bomb.Position, Vector.Zero, bomb):ToEffect()
					fartRingEffect:GetData().BobTongue = true
					fartRingEffect.Parent = bomb
					local numTrinket = player:GetTrinketMultiplier(EclipsedMod.Trinkets.BobTongue)-1
					fartRingEffect.SpriteScale = fartRingEffect.SpriteScale * (0.8 + numTrinket*0.2)
				end
				
				-- dead egg
				if player:HasTrinket(EclipsedMod.Trinkets.DeadEgg) then
					bombData.DeadEgg = true
				end

				--compo
				if player:HasCollectible(EclipsedMod.Items.CompoBombs) and not EclipsedMod.CompoBombs.Baned[bomb.Variant] and bombData.Compo ~= false then
					bombData.Compo = true
					local redBomb = Isaac.Spawn(EntityType.ENTITY_BOMB, BombVariant.BOMB_THROWABLE, 0, bomb.Position, bomb.Velocity, player):ToBomb()
					redBomb.Parent = bomb
					redBomb:GetData().RedBomb = true
					redBomb.EntityCollisionClass = 0
					redBomb.FlipX = true
					--set explosion countdown
					if bomb.IsFetus and bomb.FrameCount == 0 then
						bomb:SetExplosionCountdown(EclipsedMod.CompoBombs.FetusCountdown)
					else
						SetBombEXCountdown(player, redBomb)
					end
					if bomb.IsFetus then redBomb.IsFetus = true end
				end
				
				-- dicey
				if player:HasCollectible(EclipsedMod.Items.DiceBombs) and not EclipsedMod.DiceBombs.Ban[bomb.Variant] and bombData.Dicey ~= false then
					local initTrue = true
					if bomb.FrameCount == 1 and bomb.IsFetus and bomb:GetDropRNG():RandomFloat() > EclipsedMod.DiceBombs.FetusChance + player.Luck/100 then
						initTrue = false
						--scatter bombs from dr.fetus has chance to not get parent bomb effects. it sucks
					end
					if initTrue then
						InitDiceyBomb(bomb, bombData)
					end
				end
				
				-- gravity
				if player:HasCollectible(EclipsedMod.Items.GravityBombs) and not EclipsedMod.GravityBombs.Ban[bomb.Variant] and bombData.Gravity ~= false then -- it can be nill or true
					local initTrue = true
					if bomb.FrameCount == 1 and bomb.IsFetus and bomb:GetDropRNG():RandomFloat() > EclipsedMod.GravityBombs.FetusChance + player.Luck/100 then
						initTrue = false
					end
					if initTrue then
						InitGravityBomb(bomb, bombData)
					end
				end
				
				-- frosty
				if player:HasCollectible(EclipsedMod.Items.FrostyBombs) and not EclipsedMod.FrostyBombs.Ban[bomb.Variant] and bombData.Frosty ~= false then -- nil or true
					local initTrue = true
					if bomb.FrameCount == 1 and bomb.IsFetus and bomb:GetDropRNG():RandomFloat() > EclipsedMod.FrostyBombs.FetusChance + player.Luck/100 then
						initTrue = false
					end
					if initTrue then
						InitFrostyBomb(bomb, bombData)
					end
				end
				
				-- mirror
				if player:HasCollectible(EclipsedMod.Items.MirrorBombs) and not EclipsedMod.MirrorBombs.Ban[bomb.Variant] and not bombData.Mirror then
					local flipPos = FlipMirrorPos(bomb.Position)
					local mirrorBomb = Isaac.Spawn(bomb.Type, bomb.Variant, bomb.SubType, flipPos, bomb.Velocity, player):ToBomb()
					local mirrorBombData = mirrorBomb:GetData()
					local mirrorBombSprite = mirrorBomb:GetSprite()
					--mirrorBombSprite.FlipX = true
					--mirrorBombSprite.FlipY = true
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
				local diff = EclipsedMod.CompoBombs.DimensionX
				if bomb.Parent:GetData().Mirror then diff = -EclipsedMod.CompoBombs.DimensionX flip = false end -- mirror bombs check
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
		if EclipsedMod.RedScissorsMod and EclipsedMod.RedScissors.TrollBombs[bomb.Variant] then -- if player has red scissors and bombs is trollbombs
			if not bombData.ReplaceFrame then
				bombData.ReplaceFrame = EclipsedMod.RedScissors.NormalReplaceFrame  -- replace bomb at given frame
				if bomb.Variant == BombVariant.BOMB_GIGA then
					if bomb.SpawnerType == EntityType.ENTITY_PLAYER then -- don't replace giga bombs placed by any player
						bombData.ReplaceFrame = nil
					else
						bombData.ReplaceFrame = EclipsedMod.RedScissors.GigaReplaceFrame -- replace bomb at given frame
					end
				end
			else
				if bombSprite:IsPlaying("Pulse") and bombSprite:GetFrame() >= bombData.ReplaceFrame then -- replace on given frame of sprite animation
					RedBombReplace(bomb)
				end
			end
		end
		
		-- bomb tracing (silly )
		if bomb.FrameCount > 0 and not EclipsedMod.NoBombTrace[bomb.Variant] and not bombData.bomby and bomb.SpawnerEntity and bomb.SpawnerEntity:ToPlayer() then -- trace bombs so you wont apply bomb effect on earlier placed bombs (such as placing bomb and leaving room, picking mod bomb item and then reentering room)
			if EclipsedMod.ModdedBombas then
				EclipsedMod.ModdedBombas[index] = {
					['Gravity'] = bombData.Gravity,
					['Compo'] = bombData.Compo,
					['Mirror'] = bombData.Mirror,
					['Frosty'] = bombData.Frosty,
					['DeadEgg'] = bombData.DeadEgg,
					['Dicey'] = bombData.Dicey,
					['BobTongue'] = bombData.BobTongue,
				}
			end
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_BOMB_UPDATE, EclipsedMod.onBombUpdate)


--[[
--- EFFECT UPDATE --penance
function EclipsedMod:onRedCrossEffect(effect)
	WhatSoundIsIt()
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, EclipsedMod.onRedCrossEffect, 160)
--]]

--- EFFECT UPDATE --penance
function EclipsedMod:onRedCrossEffect(effect)
	if effect:GetData().PenanceRedCrossEffect then
		if not effect.Parent then
			effect:Remove()
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, EclipsedMod.onRedCrossEffect, EclipsedMod.Penance.Effect)
--- EFFECT UPDATE --dead egg
function EclipsedMod:onDeadEggEffect(effect)
	local data = effect:GetData()
	if data.DeadEgg and effect.Timeout == 0 then
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, effect.Position, Vector.Zero, nil):SetColor(Color(0,0,0,1,0,0,0),60,1, false, false)
		effect:Remove()
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, EclipsedMod.onDeadEggEffect, EffectVariant.DEAD_BIRD)
--- EFFECT UPDATE --bob's tongue
function EclipsedMod:onFartRingEffect(fart_ring)
	if fart_ring:GetData().BobTongue then
		if not fart_ring.Parent then
			fart_ring:Remove()
		else
			fart_ring:FollowParent(fart_ring.Parent)
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, EclipsedMod.onFartRingEffect, EffectVariant.FART_RING)
--- EFFECT UPDATE --black hole bombs
function EclipsedMod:onGravityHoleUpdate(hole)
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

			if holeData.GravityForce < EclipsedMod.GravityBombs.MaxForce then
				holeData.GravityForce = holeData.GravityForce + EclipsedMod.GravityBombs.IterForce
			end
			if holeData.GravityRange < EclipsedMod.GravityBombs.MaxRange then
				holeData.GravityRange = holeData.GravityRange + EclipsedMod.GravityBombs.IterRange
			end
			if holeData.GravityGridRange < EclipsedMod.GravityBombs.MaxGrid then
				holeData.GravityGridRange = holeData.GravityGridRange + EclipsedMod.GravityBombs.IterGrid
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
EclipsedMod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, EclipsedMod.onGravityHoleUpdate,  EclipsedMod.GravityBombs.BlackHoleEffect) -- idk why it triggers when I use ingame black hole item (when using Fusion card)
--- EFFECT UPDATE --moonlighter
function EclipsedMod:onKeeperMirrorTargetEffect(target)
	--local player = target.Parent:ToPlayer()
	local targetSprite = target:GetSprite()
	target.Velocity = target.Velocity * 0.7
	target.DepthOffset = -100
	if target.GridCollisionClass ~= EntityGridCollisionClass.GRIDCOLL_WALLS then
		target.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_WALLS
	end
	targetSprite:Play("Blink")
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, EclipsedMod.onKeeperMirrorTargetEffect, EclipsedMod.KeeperMirror.Target)
--- EFFECT UPDATE --black/white knight
function EclipsedMod:onBlackKnightTargetEffect(target)
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
	if player:GetActiveItem(ActiveSlot.SLOT_PRIMARY) == EclipsedMod.Items.BlackKnight then
		if player:GetActiveCharge(ActiveSlot.SLOT_PRIMARY) >= Isaac.GetItemConfig():GetCollectible(EclipsedMod.Items.BlackKnight).MaxCharges then
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
EclipsedMod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, EclipsedMod.onBlackKnightTargetEffect ,EclipsedMod.BlackKnight.Target)
--- EFFECT UPDATE --Elder Sign
function EclipsedMod:onElderSignPentagramUpdate(pentagram)
	if pentagram:GetData().ElderSign and pentagram.SpawnerEntity then
		if pentagram.FrameCount == pentagram:GetData().ElderSign then
			local purgesoul = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PURGATORY, 1, pentagram.Position, Vector.Zero, player):ToEffect() -- subtype = 0 is rift, 1 is soul
			purgesoul.Color = Color(0.2,0.5,0.2,1)
		end
		-- get enemies in range
		local enemies = Isaac.FindInRadius(pentagram.Position, EclipsedMod.ElderSign.AuraRange-10, EntityPartition.ENEMY)
		if #enemies > 0 then
			for _, enemy in pairs(enemies) do
				if enemy:IsVulnerableEnemy() and enemy:IsActiveEnemy() then
					enemy:AddFreeze(EntityRef(pentagram.SpawnerEntity), 1)
				end
			end
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, EclipsedMod.onElderSignPentagramUpdate, EclipsedMod.ElderSign.Pentagram)


--- FAMILIAR UPDATE --long elk
function EclipsedMod:onVertebraeUpdate(fam)
	local famData = fam:GetData() -- get fam data
	if famData.RemoveTimer then
		famData.RemoveTimer = famData.RemoveTimer - 1
		if famData.RemoveTimer <= 0 then
			fam:Kill()
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, EclipsedMod.onVertebraeUpdate,  FamiliarVariant.BONE_SPUR)
--- FAMILIAR INIT --nadab brain
function EclipsedMod:onNadabBrainInit(fam)
	fam:AddToFollowers()
end
EclipsedMod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, EclipsedMod.onNadabBrainInit, EclipsedMod.NadabBrain.Variant)
--- FAMILIAR COLLISION --nadab brain
function EclipsedMod:onNadabBrainCollision(fam, collider, _)
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
EclipsedMod:AddCallback(ModCallbacks.MC_PRE_FAMILIAR_COLLISION, EclipsedMod.onNadabBrainCollision, EclipsedMod.NadabBrain.Variant)
--- FAMILIAR UPDATE --nadab brain
function EclipsedMod:OnNadabBrainUpdate(fam)
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
		fam.CollisionDamage = EclipsedMod.NadabBrain.CollisionDamage
		if player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS) then
			fam.CollisionDamage = EclipsedMod.NadabBrain.CollisionDamage * 2
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
		if (famData.Framecount ~= nil and famData.Framecount + EclipsedMod.NadabBrain.Respawn <= game:GetFrameCount()) or famData.IsFloating == nil then
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
			fam.Velocity = GetVelocity(player) * EclipsedMod.NadabBrain.Speed
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
			if not famData.isReady and distance <= EclipsedMod.NadabBrain.MaxDistance and fam:IsFrame(30, 5) then
				famData.isReady = true
			end
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, EclipsedMod.OnNadabBrainUpdate, EclipsedMod.NadabBrain.Variant)
--- FAMILIAR INIT --lililith
function EclipsedMod:onLililithInit(fam)
	fam:GetSprite():Play("FloatDown")
	fam:AddToFollowers()
end
EclipsedMod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, EclipsedMod.onLililithInit, EclipsedMod.Lililith.Variant)
--- FAMILIAR UPDATE --lililith
function EclipsedMod:onLililithUpdate(fam)
	local player = fam.Player -- get player
	local data = player:GetData()
	local tempEffects = player:GetEffects()
	local famData = fam:GetData() -- get fam data
	local famSprite = fam:GetSprite()
	CheckForParent(fam)
	fam:FollowParent()

	if famSprite:IsFinished("Spawn") and famData.GenIndex then
		tempEffects:AddCollectibleEffect(data.LililithDemonSpawn[famData.GenIndex][1], false, 1)
		data.LililithDemonSpawn[famData.GenIndex][3] = data.LililithDemonSpawn[famData.GenIndex][3] + 1
		famSprite:Play("FloatDown")
		famData.GenIndex = nil
	end

	if fam.RoomClearCount >= EclipsedMod.Lililith.GenAfterRoom then
		fam.RoomClearCount = 0
		local rng = player:GetCollectibleRNG(EclipsedMod.Items.Lililith)
		famData.GenIndex = rng:RandomInt(#data.LililithDemonSpawn)+1
		famSprite:Play("Spawn")
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, EclipsedMod.onLililithUpdate, EclipsedMod.Lililith.Variant)
--- FAMILIAR INIT --red bag
function EclipsedMod:onRedBagInit(fam)
	fam:GetSprite():Play("FloatDown")
	fam:GetData().GenAfterRoom = EclipsedMod.RedBag.GenAfterRoom
	fam:AddToFollowers()
end
EclipsedMod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, EclipsedMod.onRedBagInit, EclipsedMod.RedBag.Variant)
--- FAMILIAR UPDATE --red bag
function EclipsedMod:onRedBagUpdate(fam)
	local player = fam.Player -- get player
	local famData = fam:GetData() -- get fam data
	local famSprite = fam:GetSprite()
	CheckForParent(fam)
	fam:FollowParent()
	famData.GenAfterRoom = famData.GenAfterRoom or EclipsedMod.RedBag.GenAfterRoom

	if fam.RoomClearCount >= fam:GetData().GenAfterRoom then
		fam.RoomClearCount = 0
		local rng = player:GetCollectibleRNG(EclipsedMod.Items.RedBag)
		famSprite:Play("Spawn")
		if rng:RandomFloat() < EclipsedMod.RedBag.RedPoopChance then
			famData.GenIndex = 0 -- red poop
		else
			famData.GenIndex = rng:RandomInt(#EclipsedMod.RedBag.RedPickups)+1
		end
	end

	if famSprite:IsFinished("Spawn") and famData.GenIndex then
		famSprite:Play("FloatDown")
		local effect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, fam.Position, Vector.Zero, nil)
		effect:SetColor(EclipsedMod.RedColor, 60, 1, false, false)
		if famData.GenIndex == 0 then
			Isaac.GridSpawn(GridEntityType.GRID_POOP, 1, fam.Position, false)
			famData.GenAfterRoom = EclipsedMod.RedBag.GenAfterRoom
		else
			Isaac.Spawn(EntityType.ENTITY_PICKUP, EclipsedMod.RedBag.RedPickups[famData.GenIndex][1], EclipsedMod.RedBag.RedPickups[famData.GenIndex][2], fam.Position, Vector.Zero, nil)
			famData.GenAfterRoom = EclipsedMod.RedBag.RedPickups[famData.GenIndex][3]
		end
		famData.GenIndex = nil
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, EclipsedMod.onRedBagUpdate, EclipsedMod.RedBag.Variant)
--- FAMILIAR INIT --abihu
function EclipsedMod:onAbihuFamInit(fam)
	if fam.SubType == EclipsedMod.AbihuFam.Subtype then
		fam:GetData().CollisionTime = 0
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, EclipsedMod.onAbihuFamInit, EclipsedMod.AbihuFam.Variant)
--- FAMILIAR UPDATE --abihu
function EclipsedMod:onAbihuFamUpdate(fam)
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
EclipsedMod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, EclipsedMod.onAbihuFamUpdate, EclipsedMod.AbihuFam.Variant)
--- FAMILIAR TAKE DMG --abihu
function EclipsedMod:onFamiliarTakeDamage(entity, _, damageFlag, source, _) --entity, amount, flags, source, countdown
	-- abihu fam take dmg
	if entity.Variant == EclipsedMod.AbihuFam.Variant then
		entity = entity:ToFamiliar()
		local famData = entity:GetData()
		if famData.CollisionTime then
			if famData.CollisionTime == 0 then
				local player = entity.Player
				famData.CollisionTime = EclipsedMod.AbihuFam.CollisionTime
				if damageFlag & DamageFlag.DAMAGE_TNT == 0 and source.Entity then -- idk but tries to add burn to tnt
					source.Entity:AddBurn(EntityRef(player), EclipsedMod.AbihuFam.BurnTime, 2*player.Damage)
				end
				if player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS) then
					CircleSpawn(entity, EclipsedMod.AbihuFam.SpawnRadius, 0, EntityType.ENTITY_EFFECT, EffectVariant.FIRE_JET, 0)
				end
			end
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, EclipsedMod.onFamiliarTakeDamage, EntityType.ENTITY_FAMILIAR)

---USE ITEM---
do
---love letter
function EclipsedMod:onSecretLoveLetter(item, _, player, useFlag) --item, rng, player, useFlag, activeSlot, customVarData
	if useFlag & UseFlag.USE_CARBATTERY == 0 then
		local data = player:GetData()
		player:AnimateCollectible(item, player:IsHoldingItem() and "HideItem" or "LiftItem")
		if data.UsedSecretLoveLetter then
			data.UsedSecretLoveLetter = false
			--sfx:Play(SoundEffect.SOUND_PAPER_OUT)
		else
			data.UsedSecretLoveLetter = true
			--sfx:Play(SoundEffect.SOUND_PAPER_IN)
		end
	end
	return {ShowAnim = false, Remove = false, Discharge = false}
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_ITEM, EclipsedMod.onSecretLoveLetter, EclipsedMod.Items.SecretLoveLetter)
---Pandora's Jar
function EclipsedMod:onPandoraJar(_, rng, player) --item, rng, player, useFlag, activeSlot, customVarData
	local wisp
	if EclipsedMod.PandoraJarGift and EclipsedMod.PandoraJarGift == 1 then
		game:GetHUD():ShowFortuneText("Elpis!")
		player:UseActiveItem(CollectibleType.COLLECTIBLE_MYSTERY_GIFT, myUseFlags)
		wisp = player:AddWisp(CollectibleType.COLLECTIBLE_MYSTERY_GIFT, player.Position, true)
		EclipsedMod.PandoraJarGift = 2
	else
		wisp = player:AddWisp(CollectibleType.COLLECTIBLE_GLASS_CANNON, player.Position, true)
	end
	if wisp then
		sfx:Play(471)
		if not player:HasCollectible(CollectibleType.COLLECTIBLE_BLACK_CANDLE) and not EclipsedMod.PandoraJarGift then
			local randNum = rng:RandomFloat()
			if randNum <= EclipsedMod.PandoraJar.CurseChance then
				local level = game:GetLevel()
				EclipsedMod.PandoraJar.Curses = PandoraJarManager(level:GetCurses())
				if #EclipsedMod.PandoraJar.Curses > 0 then
					local addCurse = EclipsedMod.PandoraJar.Curses[rng:RandomInt(#EclipsedMod.PandoraJar.Curses)+1]
					game:GetHUD():ShowFortuneText(EclipsedMod.CurseText[addCurse])
					level:AddCurse(addCurse, false)
				else
					EclipsedMod.PandoraJarGift = 1
					return {ShowAnim = true, Remove = false, Discharge = false}
				end
			end
		end
	end
	if EclipsedMod.PandoraJarGift and EclipsedMod.PandoraJarGift == 2 then
		return {ShowAnim = true, Remove = false, Discharge = false}
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_ITEM, EclipsedMod.onPandoraJar, EclipsedMod.Items.PandoraJar)
---Witch's Pot
function EclipsedMod:onWitchPot(_, rng, player) --item, rng, player, useFlag, activeSlot, customVarData
	local chance = rng:RandomFloat()
	local pocketTrinket = player:GetTrinket(0)
	local pocketTrinket2 = player:GetTrinket(1)
	local hudText = "Cantrip!"

	if pocketTrinket ~= 0 then
		if chance <= EclipsedMod.WitchPot.KillThreshold then
			RemoveThrowTrinket(player, pocketTrinket, EclipsedMod.TrinketDespawnTimer)
			hudText = "Cantripped!"
			sfx:Play(SoundEffect.SOUND_SLOTSPAWN)
		elseif chance <= EclipsedMod.WitchPot.GulpThreshold then
			player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, myUseFlags)
			hudText = "Gulp!"
			sfx:Play(SoundEffect.SOUND_VAMP_GULP)
		elseif chance <= EclipsedMod.WitchPot.SpitThreshold then
			local hastrinkets = {}
			for gulpedTrinket = 1, TrinketType.NUM_TRINKETS do
				if player:HasTrinket(gulpedTrinket, false) and gulpedTrinket ~= pocketTrinket and gulpedTrinket ~= pocketTrinket2 then
					table.insert(hastrinkets, gulpedTrinket)
				end
			end
			if #hastrinkets > 0 then
				local removeTrinket = hastrinkets[rng:RandomInt(#hastrinkets)+1]
				player:TryRemoveTrinket(removeTrinket)
				DebugSpawn(PickupVariant.PICKUP_TRINKET, removeTrinket, player.Position, 0, RandomVector()*5)
				hudText = "Spit out!"
				sfx:Play(SoundEffect.SOUND_ULTRA_GREED_SPIT)
			end
		else
			local newTrinket = rng:RandomInt(TrinketType.NUM_TRINKETS)+1
			player:TryRemoveTrinket(pocketTrinket)
			player:AddTrinket(newTrinket, true)
			hudText = "Can trip?"
			sfx:Play(SoundEffect.SOUND_BIRD_FLAP)
		end
	else
		if chance <= EclipsedMod.WitchPot.SpitChance then
			local hastrinkets = {}
			for gulpedTrinket = 1, 205 do --TrinketType.NUM_TRINKETS do
				if player:HasTrinket(gulpedTrinket, false) then
					table.insert(hastrinkets, gulpedTrinket)
				end
			end
			if #hastrinkets > 0 then
				local removeTrinket = hastrinkets[rng:RandomInt(#hastrinkets)+1]
				player:TryRemoveTrinket(removeTrinket)
				DebugSpawn(PickupVariant.PICKUP_TRINKET, removeTrinket, player.Position, 0, RandomVector()*5)
				hudText = "Spit out!"
				sfx:Play(SoundEffect.SOUND_ULTRA_GREED_SPIT)
			end
		end
	end

	if hudText == "Cantrip!" then
		player:UseActiveItem(CollectibleType.COLLECTIBLE_MOMS_BOX, myUseFlags)
		sfx:Play(SoundEffect.SOUND_SLOTSPAWN)
	end

	--game:GetHUD():ShowFortuneText(hudText)
	return true
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_ITEM, EclipsedMod.onWitchPot, EclipsedMod.Items.WitchPot)
---book of memories
function EclipsedMod:onBookMemoryItem(_, _, player) --item, rng, player, useFlag, activeSlot, customVarData
	local entities = Isaac.FindInRadius(player.Position, 5000, EntityPartition.ENEMY)
	if #entities > 0 then
		for _, entity in pairs(Isaac.FindInRadius(player.Position, 5000, EntityPartition.ENEMY)) do
			if not entity:IsBoss() and entity.Type ~= EntityType.ENTITY_FIREPLACE then
				table.insert(EclipsedMod.Lobotomy.ErasedEntities, {entity.Type, entity.Variant})
				Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, entity.Position, Vector.Zero, nil):SetColor(EclipsedMod.OblivionCard.PoofColor,50,1, false, false)
				entity:Remove()
			end
		end
		sfx:Play(316)
		player:AddBrokenHearts(1)
		return true
	end
	return {ShowAnim = false, Remove = false, Discharge = false}
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_ITEM, EclipsedMod.onBookMemoryItem, EclipsedMod.Items.BookMemory)
--[[
function EclipsedMod:onBookMemoryItem(item, rng, player, useFlag) --item, rng, player, useFlag, activeSlot, customVarData
	local data = player:GetData()
	if item == EclipsedMod.Items.BookMemory then
		local res = MemoryBookManager(rng, player)
		if res then
			DebugSpawn(350, EclipsedMod.Trinkets.MemoryFragment, player.Position)
			DebugSpawn(300, EclipsedMod.Pickups.OblivionCard, player.Position)
		end
		return {ShowAnim = true, Remove = res, Discharge = true}
	elseif useFlag & myUseFlags == 0 or useFlag & UseFlag.USE_MIMIC == 0 then
		if not data.MemoryBoolPool then data.MemoryBoolPool = {} end
		if not data.MemoryBoolPool.Items then data.MemoryBoolPool.Items = {} end
		data.MemoryBoolPool.Items[item] = true
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_ITEM, EclipsedMod.onBookMemoryItem) --EclipsedMod.Items.BookMemory
function EclipsedMod:onBookMemoryCard(card, player, useFlag) -- card, player, useFlag
	if useFlag & myUseFlags == 0 or useFlag & UseFlag.USE_MIMIC == 0 then
		local data = player:GetData()
		if not data.MemoryBoolPool then data.MemoryBoolPool = {} end
		if not data.MemoryBoolPool.Cards then data.MemoryBoolPool.Cards = {} end
		data.MemoryBoolPool.Cards[card] = true

		if player:HasTrinket(EclipsedMod.Trinkets.MemoryFragment) then
			if not data.MemoryFragment then data.MemoryFragment = {} end
			table.insert(data.MemoryFragment, {300, card})
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onBookMemoryCard)
function EclipsedMod:onBookMemoryPill(pillEffect, player, useFlag) --pillEffect, player, flags
	if useFlag & myUseFlags == 0 or useFlag & UseFlag.USE_MIMIC == 0 then
		local data = player:GetData()
		if not data.MemoryBoolPool then data.MemoryBoolPool = {} end
		if not data.MemoryBoolPool.Pills then data.MemoryBoolPool.Pills = {} end
		data.MemoryBoolPool.Pills[pillEffect] = true
		if player:HasTrinket(EclipsedMod.Trinkets.MemoryFragment) then
			if not data.MemoryFragment then data.MemoryFragment = {} end
			table.insert(data.MemoryFragment, {70, pillEffect})
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_PILL, EclipsedMod.onBookMemoryPill)
--]]
---Floppy Disk Empty
function EclipsedMod:onFloppyDisk(_, _, player) --item, rng, player, useFlag, activeSlot, customVarData
	StorePlayerItems(player) -- save player items in table
	return {ShowAnim = true, Remove = true, Discharge = true} -- remove this item after use
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_ITEM, EclipsedMod.onFloppyDisk, EclipsedMod.Items.FloppyDisk)
---Floppy Disk Full
function EclipsedMod:onFloppyDiskFull(_, _, player) --item, rng, player, useFlag, activeSlot, customVarData
	--- player use floppy disk
	ReplacePlayerItems(player) -- replace player items
	game:ShowHallucination(5, 0)
	if sfx:IsPlaying(SoundEffect.SOUND_DEATH_CARD) then
		sfx:Stop(SoundEffect.SOUND_DEATH_CARD)
	end
	return {ShowAnim = true, Remove = true, Discharge = true} -- remove this item after use
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_ITEM, EclipsedMod.onFloppyDiskFull, EclipsedMod.Items.FloppyDiskFull)
---Red Mirror
function EclipsedMod:onRedMirror(_, _, player) --item, rng, player, useFlag, activeSlot, customVarData
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
		effect:SetColor(EclipsedMod.RedColor, 50, 1, false, false) -- red poof effect
	end
	return true -- show use animation
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_ITEM, EclipsedMod.onRedMirror, EclipsedMod.Items.RedMirror)
---BlackKnight
function EclipsedMod:onBlackKnight(_, _, player) --item, rng, player, useFlag, activeSlot, customVarData
	local discharge = false
	local data = player:GetData()
	local sprite = player:GetSprite()
	if data.KnightTarget and data.KnightTarget:Exists() then
		if EclipsedMod.BlackKnight.IgnoreAnimations[sprite:GetAnimation()] then
			if data.KnightTarget:GetSprite():IsPlaying("Blink") then
				--player:PlayExtraAnimation("BigJumpUp")
				data.Jumped = true
				player:PlayExtraAnimation("TeleportUp")
				player:SetMinDamageCooldown(EclipsedMod.BlackKnight.InvFrames) -- invincibility frames
				discharge = true
			end
		end
	end
	return {ShowAnim = false, Remove = false, Discharge = discharge}
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_ITEM, EclipsedMod.onBlackKnight, EclipsedMod.Items.BlackKnight)
---KeeperMirror
function EclipsedMod:onKeeperMirror(item, _, player) --item, rng, player, useFlag, activeSlot, customVarData
	local data = player:GetData()
	--data.KeeperMirror = true
	data.KeeperMirror = Isaac.Spawn(1000, EclipsedMod.KeeperMirror.Target, 0, player.Position, Vector.Zero, player):ToEffect()
	data.KeeperMirror.Parent = player
	data.KeeperMirror:SetTimeout(EclipsedMod.KeeperMirror.TargetTimeout)
	--player:GetSprite():Play("PickupWalkDown", true)
	player:AnimateCollectible(item)
	return false
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_ITEM, EclipsedMod.onKeeperMirror, EclipsedMod.Items.KeeperMirror)
---pony
function EclipsedMod:onMiniPony(_, _, player) --item, rng, player, useFlag, activeSlot, customVarData
	player:UseActiveItem(CollectibleType.COLLECTIBLE_MY_LITTLE_UNICORN, myUseFlags)
	return false
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_ITEM, EclipsedMod.onMiniPony, EclipsedMod.Items.MiniPony)
---strange box
function EclipsedMod:onStrangeBox(_, rng, _) --item, rng, player, useFlag, activeSlot, customVarData
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
				for _, variant in pairs(EclipsedMod.StrangeBox.Variants) do
					if pickup.Variant == variant then
						local optionType = EntityType.ENTITY_PICKUP
						local optionVariant = 0 --EclipsedMod.StrangeBox.Variants[rng:RandomInt(#EclipsedMod.StrangeBox.Variants)+1]
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
EclipsedMod:AddCallback(ModCallbacks.MC_USE_ITEM, EclipsedMod.onStrangeBox, EclipsedMod.Items.StrangeBox)
---lost mirror
function EclipsedMod:onLostMirror(_, _, player) --item, rng, player, useFlag, activeSlot, customVarData
	--player:ChangePlayerType(10)
	--- player use lost mirror
	local tempEffects = player:GetEffects()
	tempEffects:AddNullEffect(NullItemID.ID_LOST_CURSE, true, 1)
 	--player:UseCard(Card.CARD_HOLY, myUseFlags)
	if player:HasTrinket(EclipsedMod.Trinkets.LostFlower) then
		player:UseCard(Card.CARD_HOLY, myUseFlags)
	end
	return true
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_ITEM, EclipsedMod.onLostMirror, EclipsedMod.Items.LostMirror)
---lost flower + prayer card
function EclipsedMod:onPrayerCard(_, _, player) --item, rng, player, useFlag, activeSlot, customVarData
	--- player use prayer card
	--- lost flower
	--if you lost/t.lost for getting eternal heart give holy card effect
	if player:HasTrinket(EclipsedMod.Trinkets.LostFlower) then -- if player has lost flower trinket
		local playerType = player:GetPlayerType()
		if playerType == PlayerType.PLAYER_THELOST or playerType == PlayerType.PLAYER_THELOST_B or player:GetPlayerType() == EclipsedMod.Characters.Oblivious then
			player:UseCard(Card.CARD_HOLY,  myUseFlags)
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_ITEM, EclipsedMod.onPrayerCard, CollectibleType.COLLECTIBLE_PRAYER_CARD)
---bleeding grimoire
function EclipsedMod:onBleedingGrimoire(_, _, player) --item, rng, player, useFlag, activeSlot, customVarData
	local data = player:GetData()
	player:AddEntityFlags(EntityFlag.FLAG_BLEED_OUT)
	player:AddNullCostume(EclipsedMod.BG.Costume)
	data.UsedBG = true
	return true -- {Discharge = true, Remove = true, ShowAnim = true}
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_ITEM, EclipsedMod.onBleedingGrimoire, EclipsedMod.Items.BleedingGrimoire)
---black book
function EclipsedMod:onBlackBook(_, rng, player) --item, rng, player, useFlag, activeSlot, customVarData
	for _, entity in pairs(Isaac.FindInRadius(player.Position, 5000, EntityPartition.ENEMY)) do
		if entity:IsVulnerableEnemy() and entity:IsActiveEnemy() then
			entity = entity:ToNPC()
			entity:RemoveStatusEffects()
			local index = rng:RandomInt(#EclipsedMod.BlackBook.EffectFlags)+1
			--entity:AddEntityFlags(EclipsedMod.BlackBook.EffectFlags[index][1])
			--entity:SetColor(EclipsedMod.BlackBook.EffectFlags[index][2], EclipsedMod.BlackBook.EffectFlags[index][3], 1, false, false)
			--entity:GetData().BlackBooked = EclipsedMod.BlackBook.EffectFlags[index][3]
			if index == 1 then
				entity:AddFreeze(EntityRef(player), EclipsedMod.BlackBook.EffectFlags[index][3])
			elseif index == 2 then -- poison
				entity:AddPoison(EntityRef(player), EclipsedMod.BlackBook.EffectFlags[index][3], 2*player.Damage)
			elseif index == 3 then -- slow
				entity:AddSlowing(EntityRef(player),  EclipsedMod.BlackBook.EffectFlags[index][3], 0.5, EclipsedMod.BlackBook.EffectFlags[index][2])
			elseif index == 4 then -- charm
				entity:AddCharmed(EntityRef(player), EclipsedMod.BlackBook.EffectFlags[index][3])
			elseif index == 5 then -- confusion
				entity:AddConfusion(EntityRef(player), EclipsedMod.BlackBook.EffectFlags[index][3], false)
			elseif index == 6 then -- midas freeze
				entity:AddMidasFreeze(EntityRef(player), EclipsedMod.BlackBook.EffectFlags[index][3])
			elseif index == 7 then -- fear
				entity:AddFear(EntityRef(player),EclipsedMod.BlackBook.EffectFlags[index][3])
			elseif index == 8 then -- burn
				entity:AddBurn(EntityRef(player), EclipsedMod.BlackBook.EffectFlags[index][3], 2*player.Damage)
			elseif index == 9 then -- shrink
				entity:AddShrink(EntityRef(player), EclipsedMod.BlackBook.EffectFlags[index][3])
			elseif index == 10 then -- bleed
				entity:AddEntityFlags(EclipsedMod.BlackBook.EffectFlags[index][1])
				entity:SetColor(EclipsedMod.BlackBook.EffectFlags[index][2], EclipsedMod.BlackBook.EffectFlags[index][3], 1, false, false)
			elseif index == 11 then -- ice
				entity:AddEntityFlags(EclipsedMod.BlackBook.EffectFlags[index][1])
				entity:SetColor(EclipsedMod.BlackBook.EffectFlags[index][2], EclipsedMod.BlackBook.EffectFlags[index][3], 1, false, false)
			elseif index == 12 then -- magnet
				entity:AddEntityFlags(EclipsedMod.BlackBook.EffectFlags[index][1])
				entity:SetColor(EclipsedMod.BlackBook.EffectFlags[index][2], EclipsedMod.BlackBook.EffectFlags[index][3], 1, false, false)
			elseif index == 13 then -- baited
				entity:AddEntityFlags(EclipsedMod.BlackBook.EffectFlags[index][1])
				entity:SetColor(EclipsedMod.BlackBook.EffectFlags[index][2], EclipsedMod.BlackBook.EffectFlags[index][3], 1, false, false)
			end
		end
	end
	return true
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_ITEM, EclipsedMod.onBlackBook, EclipsedMod.Items.BlackBook)
---scrambled rubik's dice
function EclipsedMod:onRubikDiceScrambled(item, _, player) --item, rng, player, useFlag, activeSlot, customVarData
	for _, Scrambledice in pairs(EclipsedMod.RubikDice.ScrambledDicesList) do
		if item == Scrambledice then
			--- player use rubik's dice
			RerollTMTRAINER(player)
			return true
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_ITEM, EclipsedMod.onRubikDiceScrambled) -- called for all items
---rubik's dice
function EclipsedMod:onRubikDice(item, rng, player, useFlag) --item, rng, player, useFlag, activeSlot, customVarData
	--- player use rubik's dice
	player:UseActiveItem(CollectibleType.COLLECTIBLE_D6, myUseFlags)
	if useFlag & UseFlag.USE_OWNED == UseFlag.USE_OWNED and rng:RandomFloat() < EclipsedMod.RubikDice.GlitchReroll then -- and  (useFlag & UseFlag.USE_MIMIC == 0) then
		player:RemoveCollectible(item)
		local Newdice = EclipsedMod.RubikDice.ScrambledDicesList[rng:RandomInt(#EclipsedMod.RubikDice.ScrambledDicesList)+1]
		player:AddCollectible(Newdice) --Newdice / EclipsedMod.Items.RubikDiceScrambled
	end
	return true
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_ITEM, EclipsedMod.onRubikDice, EclipsedMod.Items.RubikDice)
---vhs cassette
function EclipsedMod:onVHSCassette(_, rng, _) --item, rng, player, useFlag, activeSlot, customVarData
	local level = game:GetLevel()
	local stage = level:GetStage()
	if EclipsedMod.VHS.tableVHS then
		if level:IsAscent() then
			Isaac.ExecuteCommand("stage 13")
		elseif not game:IsGreedMode() and stage < 12 then
			local newStage = rng:RandomInt(12)+1
			if newStage <= stage then newStage = stage+1 end
			local randStageType = 1
			if newStage ~= 9 then randStageType = rng:RandomInt(#EclipsedMod.VHS.tableVHS[newStage])+1 end
			newStage = "stage " .. EclipsedMod.VHS.tableVHS[newStage][randStageType]
			EclipsedMod.VHS.tableVHS = nil
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
EclipsedMod:AddCallback(ModCallbacks.MC_USE_ITEM, EclipsedMod.onVHSCassette, EclipsedMod.Items.VHSCassette)
---long elk
function EclipsedMod:onLongElk(_, _, player) --item, rng, player, useFlag, activeSlot, customVarData
	local data = player:GetData()
	data.ElkKiller = true
	--player:UseActiveItem(CollectibleType.COLLECTIBLE_PONY, myUseFlags)
	local tempEffects = player:GetEffects()
	tempEffects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_MARS, false, 1)
	-- set player color or add some indicator
	return false
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_ITEM, EclipsedMod.onLongElk, EclipsedMod.Items.LongElk)
---WhiteKnight
function EclipsedMod:onWhiteKnight(_, _, player) --item, rng, player, useFlag, activeSlot, customVarData
	local discharge = false
	local data = player:GetData()
	local sprite = player:GetSprite()
	-- if animation is right tp to nearest enemy/door
	if EclipsedMod.BlackKnight.IgnoreAnimations[sprite:GetAnimation()] then
		data.Jumped = true
		player:PlayExtraAnimation("TeleportUp")
		player:SetMinDamageCooldown(EclipsedMod.BlackKnight.InvFrames) -- invincibility frames
		discharge = true
	end
	-- do not show use animation
	return {ShowAnim = false, Remove = false, Discharge = discharge}
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_ITEM, EclipsedMod.onWhiteKnight, EclipsedMod.Items.WhiteKnight)
---charon's obol
function EclipsedMod:onCharonObol(_, _, player) --item, rng, player, useFlag, activeSlot, customVarData
	-- spawn soul if you have coins
	if player:GetNumCoins() > 0 then
		player:AddCoins(-1)
		-- take 1 coin and spawn
		local soul = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HUNGRY_SOUL, 1, player.Position, Vector.Zero, player):ToEffect()
		soul:SetTimeout(EclipsedMod.CharonObol.Timeout)
		return true
	end
	return false
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_ITEM, EclipsedMod.onCharonObol, EclipsedMod.Items.CharonObol)
---Red Pill Placebo
function EclipsedMod:onRedPillPlacebo(_, _, player) --item, rng, player, useFlag, activeSlot, customVarData
	local pill = player:GetCard(0)
	if pill == EclipsedMod.Pickups.RedPill or pill == EclipsedMod.Pickups.RedPillHorse then
		player:UseCard(pill, UseFlag.USE_MIMIC)
	end
	--return {ShowAnim = true, Remove = false, Discharge = true}
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_ITEM, EclipsedMod.onRedPillPlacebo, CollectibleType.COLLECTIBLE_PLACEBO)
---Space Jam
function EclipsedMod:onCosmicJam(_, _, player) --item, rng, player, useFlag, activeSlot, customVarData
	SpawnItemWisps(player)
	return true
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_ITEM, EclipsedMod.onCosmicJam, EclipsedMod.Items.CosmicJam)
---Elder Sign
function EclipsedMod:onUseElderSign(_, _, player)
    local pentagram = Isaac.Spawn(EntityType.ENTITY_EFFECT, EclipsedMod.ElderSign.Pentagram, 0, player.Position, Vector.Zero, player):ToEffect()
	pentagram.SpriteScale = pentagram.SpriteScale * EclipsedMod.ElderSign.AuraRange/100
	pentagram.Color = Color(0,1,0,1)
	pentagram:GetData().ElderSign = EclipsedMod.ElderSign.Timeout
    return true
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_ITEM, EclipsedMod.onUseElderSign, EclipsedMod.Items.ElderSign)
end

---USE CARD/PILL---
do
---Apocalypse card
function EclipsedMod:onApocalypse(card, player) -- card, player, useflag
	-- fill the room with poop and turn them into red poop
	local room = game:GetRoom()
	local level = game:GetLevel()
	EclipsedMod.Apocalypse.Room = level:GetCurrentRoomIndex()
	EclipsedMod.Apocalypse.RNG = player:GetCardRNG(card)
	room:SetCardAgainstHumanity()
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onApocalypse, EclipsedMod.Pickups.Apocalypse)
---oblivion card
function EclipsedMod:onOblivionCard(_, player) -- card, player, useflag
	-- throw chaos card and replace it with oblivion card (MC_POST_TEAR_INIT)
	local data = player:GetData()
	data.UsedOblivionCard = true
	player:UseCard(Card.CARD_CHAOS, myUseFlags)
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onOblivionCard, EclipsedMod.Pickups.OblivionCard)
---King Chess black
function EclipsedMod:onKingChess(_, player) -- card, player, useflag
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
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onKingChess, EclipsedMod.Pickups.KingChess)
---King Chess white
function EclipsedMod:onKingChessW(_, player) -- card, player, useflag
	-- spawn white/stone poops
	SquareSpawn(player, 40, 0, EntityType.ENTITY_POOP, 11, 0)
	--MyGridSpawn(player, 40, GridEntityType.GRID_POOP, 6, true) --rng:RandomInt(7)
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onKingChessW, EclipsedMod.Pickups.KingChessW)
---Trapezohedron
function EclipsedMod:onTrapezohedron() -- card, player, useflag
	-- turn all trinkets in room into cracked keys
	for _, pickups in pairs(Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET)) do -- get all trinkets in room
		pickups:ToPickup():Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, Card.CARD_CRACKED_KEY, false, false, false) -- morph all trinkets into cracked keys
		local effect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, pickups.Position, Vector.Zero, nil)
		effect:SetColor(EclipsedMod.RedColor, 50, 1, false, false) -- red poof effect
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onTrapezohedron, EclipsedMod.Pickups.Trapezohedron)
---red pill
function EclipsedMod:onRedPill(_, player) -- card, player, useflag
	RedPillManager(player, EclipsedMod.RedPills.DamageUp, EclipsedMod.RedPills.WavyCap)
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onRedPill, EclipsedMod.Pickups.RedPill)
---red pill horse
function EclipsedMod:onRedPillHorse(_, player) -- card, player, useflag
	RedPillManager(player, EclipsedMod.RedPills.HorseDamageUp, EclipsedMod.RedPills.HorseWavyCap)
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onRedPillHorse, EclipsedMod.Pickups.RedPillHorse)
---domino 3|4
function EclipsedMod:onDomino34(card, player) -- card, player, useflag
	-- reroll items and pickups on floor
	local rng = player:GetCardRNG(card)
	game:RerollLevelCollectibles()
	game:RerollLevelPickups(rng:GetSeed())
	player:UseCard(Card.CARD_DICE_SHARD, myUseFlags)
	game:ShakeScreen(10)
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onDomino34, EclipsedMod.Pickups.Domino34)
---domino 2|5
function EclipsedMod:onDomino25(_, player) -- card, player, useflag
	-- respawn and reroll enemies
	local room = game:GetRoom()
	local data = player:GetData()
	-- after 3 frames reroll enemies
	data.Domino25Used = 3
	room:RespawnEnemies()
	game:ShakeScreen(10)
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onDomino25, EclipsedMod.Pickups.Domino25)
---domino 0|0
function EclipsedMod:onDomino00(_, player) -- card, player, useflag
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
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onDomino00, EclipsedMod.Pickups.Domino00)
---Soul of Unbidden
function EclipsedMod:onSoulUnbidden(_, player) -- card, player, useflag
	if #Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ITEM_WISP)> 0 then
		AddItemFromWisp(player, false)
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onSoulUnbidden, EclipsedMod.Pickups.SoulUnbidden)
---Soul of NadabAbihu
function EclipsedMod:onSoulNadabAbihu(_, player) -- card, player, useflag
	local data = player:GetData()
	-- add fire tears and explosion immunity
	data.UsedSoulNadabAbihu = true  -- use check in MC_ENTITY_TAKE_DMG for explosion
	local tempEffects = player:GetEffects()
	tempEffects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_FIRE_MIND, false, 1)
	-- hot bombs - just for costume. it doesn't give any actual effect
	tempEffects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_HOT_BOMBS, true, 1)
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onSoulNadabAbihu, EclipsedMod.Pickups.SoulNadabAbihu)
---ascender bane
function EclipsedMod:onAscenderBane(_, player) -- card, player, useflag
	--- remove 1 broken heart
	if player:GetBrokenHearts() > 0 then
		player:AddBrokenHearts(-1)
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onAscenderBane, EclipsedMod.Pickups.AscenderBane)
---multi-cast
function EclipsedMod:onMultiCast(_, player) -- card, player, useflag
	local activeItem = player:GetActiveItem(0)
	-- replace mod item wisps
	if activeItem ~= 0 and EclipsedMod.ActiveItemWisps[activeItem] then
		activeItem = EclipsedMod.ActiveItemWisps[activeItem]
	end
	--if activeItem == 0 then activeItem = 1 end
	for _=1, EclipsedMod.MultiCast.NumWisps do
		player:AddWisp(activeItem, player.Position, true)
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onMultiCast, EclipsedMod.Pickups.MultiCast)
---wish
function EclipsedMod:onWish(_, player, useFlag) -- card, player, useflag
	if useFlag & UseFlag.USE_MIMIC == 0 then
		player:UseActiveItem(CollectibleType.COLLECTIBLE_MYSTERY_GIFT, myUseFlags)
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onWish, EclipsedMod.Pickups.Wish)
---offering
function EclipsedMod:onOffering(_, player) -- card, player, useflag
	player:UseActiveItem(CollectibleType.COLLECTIBLE_SACRIFICIAL_ALTAR, myUseFlags)
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onOffering, EclipsedMod.Pickups.Offering)
---infinite blades card
function EclipsedMod:onInfiniteBlades(card, player) -- card, player, useflag
	local rotationOffset = player:GetLastDirection() -- player:GetMovementInput()
	local newV = player:GetLastDirection()
	local rng = player:GetCardRNG(card)
	for _ = 1, EclipsedMod.InfiniteBlades.MaxNumber do
		local randX = rng:RandomInt(80) * (rng:RandomInt(3)-1)
		local randY = rng:RandomInt(80) * (rng:RandomInt(3)-1)

		local pos = Vector(player.Position.X + randX, player.Position.Y + randY)
		local knife = player:FireTear(pos, newV, false, true, false, nil, EclipsedMod.InfiniteBlades.DamageMulti):ToTear()
		knife:AddTearFlags(TearFlags.TEAR_PIERCING | TearFlags.TEAR_SPECTRAL | TearFlags.TEAR_ACCELERATE)
		knife.Visible = false

		local knifeData = knife:GetData()
		knifeData.KnifeTear = true
		knifeData.InitAngle = rotationOffset

		local knifeSprite = knife:GetSprite()
		knifeSprite:ReplaceSpritesheet(0, EclipsedMod.InfiniteBlades.newSpritePath)
		knifeSprite:LoadGraphics()
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onInfiniteBlades, EclipsedMod.Pickups.InfiniteBlades)
---transmutation card
function EclipsedMod:onTransmutation(_, player) -- card, player, useflag
	--- reroll enemies and pickups
	player:UseCard(Card.CARD_ACE_OF_SPADES, myUseFlags)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_D20, myUseFlags)
	--player:UseCard(Card.CARD_DICE_SHARD, myUseFlags)
	--player:UseActiveItem(CollectibleType.COLLECTIBLE_D100, myUseFlags)
	--player:UseActiveItem(CollectibleType.COLLECTIBLE_CLICKER, myUseFlags)
	--game:ShowHallucination(0, BackdropType.NUM_BACKDROPS)
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onTransmutation, EclipsedMod.Pickups.Transmutation)
---ritual dagger card
function EclipsedMod:onRitualDagger(_, player) -- card, player, useflag
	--- add mom's knife for room
	local tempEffects = player:GetEffects()
	tempEffects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_MOMS_KNIFE, true, 1)
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onRitualDagger, EclipsedMod.Pickups.RitualDagger)
---fusion card
function EclipsedMod:onFusion(_, player) -- card, player, useflag
	--- throw a black hole
	player:UseActiveItem(CollectibleType.COLLECTIBLE_BLACK_HOLE, myUseFlags)
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onFusion, EclipsedMod.Pickups.Fusion)
---deus ex card
function EclipsedMod:onDeuxEx(_, player) -- card, player, useflag
	--- add 100 luck
	--- effects based on room type (refuses to elaborate)
	--local level = game:GetLevel()
	--local room = game:GetRoom()
	--local roomType = room:GetType()
	--local rng = player:GetCardRNG(card)
	local data = player:GetData()
	data.DeuxExLuck = data.DeuxExLuck or 0
	data.DeuxExLuck = data.DeuxExLuck + EclipsedMod.DeuxEx.LuckUp
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
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onDeuxEx, EclipsedMod.Pickups.DeuxEx)
---adrenaline card
function EclipsedMod:onAdrenaline(_, player) -- card, player, useflag
	--- add Adrenaline item effect for current room
	local tempEffects = player:GetEffects()
	tempEffects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_ADRENALINE, true, 1) -- check if it works
	-- get red hearts amount
	local redHearts = player:GetHearts()
	-- loop if player has more than 1 full heart container
	if player:GetBlackHearts() > 0 or player:GetBoneHearts() > 0 or player:GetSoulHearts() > 0 then
		AdrenalineManager(player, redHearts, 0)
	elseif redHearts > 1 then
		AdrenalineManager(player, redHearts, 2) -- 0
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onAdrenaline, EclipsedMod.Pickups.Adrenaline)
---corruption card
function EclipsedMod:onCorruption(_, player) -- card, player, useflag
	--- unlimited use of current active item in room, item will be removed on entering next room
	local data = player:GetData()
	-- set that corruption was used
	data.CorruptionIsActive = true
	player:AddNullCostume(EclipsedMod.Corruption.CostumeHead)
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onCorruption, EclipsedMod.Pickups.Corruption)
---GhostGem
function EclipsedMod:onGhostGem(_, player) -- card, player, useflag
	-- loop in soul numbers
	for _ = 1, EclipsedMod.GhostGem.NumSouls do
		-- spawn purgatory soul
		local purgesoul = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PURGATORY, 1, player.Position, Vector.Zero, player):ToEffect() -- subtype = 0 is rift, 1 is soul
 		-- change it's color
		purgesoul:SetColor(EclipsedMod.OblivionCard.PoofColor, 500, 1, false, true)
 		-- set animation (skip appearing from rift)
		purgesoul:GetSprite():Play("Charge", true)
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onGhostGem, EclipsedMod.Pickups.GhostGem)
---battlefield
function EclipsedMod:onBattlefieldCard(card, player, _) -- card, player, useflag
	local rng = player:GetCardRNG(card)
	Isaac.ExecuteCommand("goto s.challenge." .. rng:RandomInt(8)+16)  --0 .. 15 - normal; 16 .. 24 - boss
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onBattlefieldCard, EclipsedMod.Pickups.BattlefieldCard)
---treasury
function EclipsedMod:onTreasuryCard(card, player, _) -- card, player, useflag
	local rng = player:GetCardRNG(card)
	Isaac.ExecuteCommand("goto s.treasure." .. rng:RandomInt(56))
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onTreasuryCard, EclipsedMod.Pickups.TreasuryCard)
---bookery
function EclipsedMod:onBookeryCard(card, player, _) -- card, player, useflag
	local rng = player:GetCardRNG(card)
	Isaac.ExecuteCommand("goto s.library." .. rng:RandomInt(18))
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onBookeryCard, EclipsedMod.Pickups.BookeryCard)
---blood grove
function EclipsedMod:onBloodGroveCard(card, player) -- card, player, useflag
	local rng = player:GetCardRNG(card)
	local num = rng:RandomInt(10)+31 -- 0 .. 30 / 31 .. 40 for voodoo head
	Isaac.ExecuteCommand("goto s.curse." .. num)
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onBloodGroveCard, EclipsedMod.Pickups.BloodGroveCard)
---storm temple
function EclipsedMod:onStormTempleCard(card, player) -- card, player, useflag

	local rng = player:GetCardRNG(card)
	Isaac.ExecuteCommand("goto s.sacrifice." .. rng:RandomInt(13))
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onStormTempleCard, EclipsedMod.Pickups.StormTempleCard)
---arsenal
function EclipsedMod:onArsenalCard(card, player) -- card, player, useflag

	local rng = player:GetCardRNG(card)
	Isaac.ExecuteCommand("goto s.chest." .. rng:RandomInt(49))
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onArsenalCard, EclipsedMod.Pickups.ArsenalCard)
---outport
function EclipsedMod:onOutpostCard(card, player) -- card, player, useflag

	local rng = player:GetCardRNG(card)
	if rng:RandomFloat() > 0.5 then
		Isaac.ExecuteCommand("goto s.isaacs." .. rng:RandomInt(30))
	else
		Isaac.ExecuteCommand("goto s.barren." .. rng:RandomInt(29))
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onOutpostCard, EclipsedMod.Pickups.OutpostCard)
---ancestral crypt
function EclipsedMod:onCryptCard(card, player) -- card, player, useflag
	local data = player:GetData()
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
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onCryptCard, EclipsedMod.Pickups.CryptCard)
---maze of memory
function EclipsedMod:onMazeMemoryCard(_, player, useFlag) -- card, player, useflag
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
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onMazeMemoryCard, EclipsedMod.Pickups.MazeMemoryCard)
---zero stone
function EclipsedMod:onZeroMilestoneCard(_, player) -- card, player, useflag
	EclipsedMod.ZeroStoneUsed = true
	player:UseActiveItem(CollectibleType.COLLECTIBLE_GENESIS, myUseFlags)
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onZeroMilestoneCard, EclipsedMod.Pickups.ZeroMilestoneCard)
---pot of greed
function EclipsedMod:onBannedCard(card, player) -- card, player, useflag
	for _ = 1, EclipsedMod.BannedCard.NumCards do
		Isaac.Spawn(5, 300, card, player.Position, RandomVector()*3, nil)
	end
	game:GetHUD():ShowFortuneText("POT OF GREED ALLOWS ME","TO DRAW TWO MORE CARDS!")
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onBannedCard, EclipsedMod.Pickups.BannedCard)
---Decay
function EclipsedMod:onDecay(_, player) -- card, player, useflag
	local redHearts = player:GetHearts()
	local data = player:GetData()

	if redHearts > 0 then
		player:AddHearts(-redHearts)
		player:AddRottenHearts(redHearts)
	end
	data.DecayLevel = data.DecayLevel or true
	TrinketRemoveAdd(player, TrinketType.TRINKET_APPLE_OF_SODOM)
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onDecay, EclipsedMod.Pickups.Decay)
---Domino16
function EclipsedMod:onDomino16(card, player) -- card, player, useflag
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
		DebugSpawn(finalVar, 0, Isaac.GetFreeNearPosition(player.Position, 40)) -- 0
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.onDomino16, EclipsedMod.Pickups.Domino16)
end
---Delirious Pickups
function EclipsedMod:useDeliObject(card, player) -- card, player, useFlag
	if EclipsedMod.DeliObject.CheckGetCard[card] then
		local rng = player:GetCardRNG(card)
		if rng:RandomFloat() >= EclipsedMod.DeliObject.Chance then
			player:SetCard(0, EclipsedMod.DeliObject.Variants[rng:RandomInt(#EclipsedMod.DeliObject.Variants)+1])
		end
		--- cell
		if card == EclipsedMod.Pickups.DeliObjectCell then
			if EclipsedMod.DeliriumBeggar.Enemies and #EclipsedMod.DeliriumBeggar.Enemies > 0 then
				local spawnpos = Isaac.GetFreeNearPosition(player.Position, 35)
				EclipsedMod.DeliriumBeggar.Enemies = EclipsedMod.DeliriumBeggar.Enemies or {EntityType.ENTITY_GAPER, 0}
				local savedOnes = EclipsedMod.DeliriumBeggar.Enemies[rng:RandomInt(#EclipsedMod.DeliriumBeggar.Enemies)+1]
				local npc = Isaac.Spawn(savedOnes[1], savedOnes[2], 0, spawnpos, Vector.Zero, player):ToNPC()
				npc:AddCharmed(EntityRef(player), -1)
			end
		--- bomb
		elseif card == EclipsedMod.Pickups.DeliObjectBomb then
			local bombVar = BombVariant.BOMB_NORMAL
			local randNum = rng:RandomInt(4) -- 0 ~ 3
			if rng:RandomFloat() < EclipsedMod.DeliObject.TrollCBombChance then
				if randNum == 1 then
					bombVar = BombVariant.BOMB_SUPERTROLL
				elseif randNum == 2 then
					bombVar = BombVariant.BOMB_GOLDENTROLL
				else
					bombVar = BombVariant.BOMB_TROLL
				end
				Isaac.Spawn(EntityType.ENTITY_BOMB, bombVar, 0, player.Position, Vector.Zero, nil):ToBomb()
			else
				local bombFlags = TearFlags.TEAR_NORMAL
				for _ = 0, randNum do
					bombFlags = bombFlags | EclipsedMod.DeliObject.BombFlags[rng:RandomInt(#EclipsedMod.DeliObject.BombFlags)+1]
				end

				local bomb = Isaac.Spawn(EntityType.ENTITY_BOMB, BombVariant.BOMB_NORMAL, 0, player.Position, Vector.Zero, player):ToBomb()
				bomb:AddTearFlags(bombFlags)
			end
		--- key
		elseif card == EclipsedMod.Pickups.DeliObjectKey then
			local nearestChest = 5000
			local nearestDoor = 5000
			local room = game:GetRoom()
			local door
			local chest
			local pickups = Isaac.FindInRadius(player.Position, 5000, EntityPartition.PICKUP)
			if #pickups > 0 then
				for _, pickup in pairs(pickups) do
					if pickup.Type == EntityType.ENTITY_PICKUP then
						if pickup.Variant == PickupVariant.PICKUP_ETERNALCHEST or pickup.Variant == PickupVariant.PICKUP_MEGACHEST or pickup.Variant == PickupVariant.PICKUP_LOCKEDCHEST then
							--print(pickup.Variant, pickup.SubType)
							if player.Position:Distance(pickup.Position) < nearestChest and pickup.SubType > 0 then
								nearestChest = player.Position:Distance(pickup.Position)
								chest = pickup
							end
						end
					end
				end
			end
			for slot = 0, DoorSlot.NUM_DOOR_SLOTS do
				if room:GetDoor(slot) then
					local grid = room:GetDoor(slot)
					local doorVar = grid:GetVariant()
					if doorVar == DoorVariant.DOOR_LOCKED or doorVar == DoorVariant.DOOR_LOCKED_DOUBLE then
						if player.Position:Distance(grid.Position) < nearestDoor then
							nearestDoor = player.Position:Distance(grid.Position)
							door = grid
						end
					end
				end
			end
			if nearestChest < nearestDoor and chest then
				chest:ToPickup():TryOpenChest()
				sfx:Play(SoundEffect.SOUND_UNLOCK00, 1, 0, false, 1, 0)
			elseif nearestDoor <= nearestChest and door then
				door:TryUnlock(player, true)
				sfx:Play(SoundEffect.SOUND_UNLOCK00, 1, 0, false, 1, 0)
			else

				local level= game:GetLevel()
				for slot = 0, DoorSlot.NUM_DOOR_SLOTS do
					if level:MakeRedRoomDoor(level:GetCurrentRoomIndex(), slot) then break end
				end
			end
		--- card
		elseif card == EclipsedMod.Pickups.DeliObjectCard then
			local randCard = itemPool:GetCard(rng:GetSeed(), true, false, false)
			player:UseCard(randCard, myUseFlags2)
		--- pill
		elseif card == EclipsedMod.Pickups.DeliObjectPill then
			local randPill = rng:RandomInt(PillEffect.NUM_PILL_EFFECTS)
			player:UsePill(randPill, 0, myUseFlags2)
			player:AnimateCard(card)
		--- rune
		elseif card == EclipsedMod.Pickups.DeliObjectRune then
			local randCard = itemPool:GetCard(rng:GetSeed(), false, false, true)
			player:UseCard(randCard, myUseFlags2)
		--- heart
		elseif card == EclipsedMod.Pickups.DeliObjectHeart then
			local randNum = rng:RandomInt(9)
			if randNum == 1 then
				player:AddHearts(2)
				sfx:Play(SoundEffect.SOUND_VAMP_GULP, 1, 0, false, 1, 0)
			elseif randNum == 2 then
				player:AddBlackHearts(2)
				sfx:Play(SoundEffect.SOUND_HOLY, 1, 0, false, 1, 0)
			elseif randNum == 3 then
				player:AddBoneHearts(1)
				sfx:Play(SoundEffect.SOUND_BONE_HEART, 1, 0, false, 1, 0)
			elseif randNum == 4 then
				player:AddBrokenHearts(1)
				sfx:Play(SoundEffect.SOUND_POISON_HURT, 1, 0, false, 1, 0)
			elseif randNum == 5 then
				player:AddEternalHearts(1)
				sfx:Play(SoundEffect.SOUND_SUPERHOLY, 1, 0, false, 1, 0)
			elseif randNum == 6 then
				player:AddMaxHearts(1)
				sfx:Play(SoundEffect.SOUND_1UP, 1, 0, false, 1, 0)
			elseif randNum == 7 then
				player:AddRottenHearts(1)
				sfx:Play(SoundEffect.SOUND_ROTTEN_HEART, 1, 0, false, 1, 0)
			elseif randNum == 8 then
				player:AddSoulHearts(2)
				sfx:Play(SoundEffect.SOUND_HOLY, 1, 0, false, 1, 0)
			else
				player:AddGoldenHearts(1)
				sfx:Play(SoundEffect.SOUND_GOLD_HEART, 1, 0, false, 1, 0)
			end
		--- coin
		elseif card == EclipsedMod.Pickups.DeliObjectCoin then
			local randNum = rng:RandomInt(4)
			if randNum == 1 then
				player:AddCoins (1)
				sfx:Play(SoundEffect.SOUND_PENNYPICKUP, 1, 0, false, 1, 0)
			elseif randNum == 2 then
				player:AddCoins (5)
				sfx:Play(SoundEffect.SOUND_NICKELPICKUP, 1, 0, false, 1, 0)
			elseif randNum == 3 then
				player:AddCoins (10)
				sfx:Play(SoundEffect.SOUND_DIMEPICKUP, 1, 0, false, 1, 0)
			else
				player:AddCoins (1)
				player:DonateLuck (1)
				sfx:Play(SoundEffect.SOUND_LUCKYPICKUP, 1, 0, false, 1, 0)
			end
		--- battery
		elseif card == EclipsedMod.Pickups.DeliObjectBattery then
			local randNum = rng:RandomInt(3) -- 0 is 2 charges, 1 is full charge, 2 - overcharge
			local charge = 2 -- if randNum = 0
			local overCharge = false
			if randNum == 2 or player:HasCollectible(CollectibleType.COLLECTIBLE_BATTERY) then overCharge = true end
			for slot = 0, 3 do
				local activeItem = player:GetActiveItem(slot)
				if activeItem ~= 0 then
					if randNum > 1 then
						charge = Isaac.GetItemConfig():GetCollectible(activeItem).MaxCharges
					end
					if overCharge and player:GetBatteryCharge(slot) < charge then
						player:SetActiveCharge(charge*2, slot)
						Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BATTERY, 0, Vector(player.Position.X, player.Position.Y-70), Vector.Zero, nil)
						sfx:Play(SoundEffect.SOUND_BATTERYCHARGE, 1, 0, false, 1, 0)
						break
					elseif player:GetActiveCharge(slot) < charge then
						player:SetActiveCharge(charge, slot)
						Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BATTERY, 0, Vector(player.Position.X, player.Position.Y-70), Vector.Zero, nil) --i'm too lazy to adjust right position with spritescale (и так сойдет!)
						sfx:Play(SoundEffect.SOUND_BATTERYCHARGE, 1, 0, false, 1, 0)
						break
					end
				end
			end
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.useDeliObject)
--- EID
if EID then -- External Item Description
	EID:addBirthright(EclipsedMod.Characters.Nadab, "Explosion immunity. #Spawns 3 random items from {{BombBeggar}} Bomb Beggar pool. #Only one can be taken.")
	EID:addBirthright(EclipsedMod.Characters.Abihu, "Fire immunity. #{{Heart}} Full health. #{{Chargeable}} Charging Blue Flame is always active.")
	EID:addBirthright(EclipsedMod.Characters.Unbidden, "Turn all {{BrokenHeart}} broken hearts into {{SoulHeart}} soul hearts. #Give all items from Item Wisps, without removing wisps.")
	EID:addBirthright(EclipsedMod.Characters.Oblivious, "Remove and prevent all curses.")

	local disk_desk = "!!! SINGLE USE !!! #Save your items. #If you have saved items: replace your items by saved items. #{{Warning}} Give {{Collectible258}} MissingNo if saved item is missing."
	EID:addCollectible(EclipsedMod.Items.FloppyDisk, disk_desk)
	EID:addCollectible(EclipsedMod.Items.FloppyDiskFull, disk_desk)

	EID:addCollectible(EclipsedMod.Items.RedMirror,
			"Turn nearest {{Trinket}} trinket into {{Card78}} cracked key.")
	EID:addCollectible(EclipsedMod.Items.RedLotus,
			"Remove one {{BrokenHeart}} broken heart and give {{Damage}} flat 1.0 damage up at the start of the floor.")
	EID:addCollectible(EclipsedMod.Items.MidasCurse,
			"Add 3 {{GoldenHeart}} golden hearts. #10% chance to get golden pickups. #When you lose golden heart turn everything into gold. #{{Warning}} Curse effect: # {{Warning}} 100% chance to get golden pickups. # {{Warning}} All food-related items turn into coins if you try to pick them up. #Curse effect can be removed by {{Collectible260}} Black Candle.")
	EID:addCollectible(EclipsedMod.Items.RubberDuck,
			"↑ {{Luck}} +20 temporary luck up when picked up. #↑ {{Luck}} +1 luck up when entering unvisited room. #↓ {{Luck}} -1 luck down when entering visited room. #Temporary luck can't go below player's original luck.")
	EID:addCollectible(EclipsedMod.Items.IvoryOil,
			"Charge active items when entering an uncleared room for the first time.")
	EID:addCollectible(EclipsedMod.Items.BlackKnight,
			"You can't move. #Use to jump to target marker. #Crush and knockback monsters when you land on the ground. #Destroy stone monsters.")
	EID:addCollectible(EclipsedMod.Items.WhiteKnight,
			"Use to jump to nearest enemy. #Crush and knockback monsters when you land on the ground. #Destroy stone monsters.")
	EID:addCollectible(EclipsedMod.Items.KeeperMirror,
			"Sell item or pickup in target mark. #Spawn 1 coin if no pickup was targeted")
	EID:addCollectible(EclipsedMod.Items.RedBag,
			"Chance to drop red pickups after clearing room. #Possible pickups: {{Heart}} red hearts, {{Card49}} dice shards, {{Pill}} red pills, {{Card78}} cracked keys, {{Bomb}} red throwable bombs. #{{Warning}} Can spawn Red Poop.")
	EID:addCollectible(EclipsedMod.Items.MeltedCandle,
			"Tears have a chance to wax enemies for 3 seconds. #Waxed enemy {{Freezing}} freezes and {{Burning}} burns. #When a waxed enemy dies, it leaves fire.")
	EID:addCollectible(EclipsedMod.Items.MiniPony,
			"Grants flight and {{Speed}} 1.5 speed while held. #On use, grants {{Collectible77}} My Little Unicorn effect.")
	EID:addCollectible(EclipsedMod.Items.StrangeBox,
			"Create {{Collectible249}} option choice item for all items, pickups and shop items in the room. #Only one can be taken.")
	EID:addCollectible(EclipsedMod.Items.RedButton,
			"Spawn Red Button when entering room. #Activate random pressure plate effect when pressed. #{{Warning}}After pressing 66 times, no longer appear in current room.")
	EID:addCollectible(EclipsedMod.Items.LostMirror,
			"Turn you into {{Player10}} soul.")
	EID:addCollectible(EclipsedMod.Items.BleedingGrimoire,
			"Start {{BleedingOut}} bleeding. #Your tears apply {{BleedingOut}} bleeding to enemies.")
	EID:addCollectible(EclipsedMod.Items.BlackBook,
			"Apply random status effects on enemies in room. #Possible effects: {{Freezing}}Freeze; {{Poison}}Poison; {{Slow}}Slow; {{Charm}}Charm; {{Confusion}}Confusion; {{Collectible202}}Midas Touch; {{Fear}}Fear; {{Burning}}Burn; {{Collectible398}}Shrink; {{BleedingOut}}Bleed; {{Collectible596}}Frozen; {{Magnetize}}Magnetized; {{Bait}}Bait.")

	local description = "In 'solved' state {{Collectible105}} reroll items. #{{Warning}} Have a 16% chance to turn into {{Collectible".. EclipsedMod.Items.RubikDiceScrambled0 .."}} 'scrambled' Rubik's Dice, increasing it's charge bar. #In 'scrambled' state it can be used without full charge, but will reroll items into {{Collectible721}} glitched items. #After fully recharging, it returns to 'solved' state."
	EID:addCollectible(EclipsedMod.Items.RubikDice, description)
	EID:addCollectible(EclipsedMod.Items.RubikDiceScrambled0, description)
	EID:addCollectible(EclipsedMod.Items.RubikDiceScrambled1, description)
	EID:addCollectible(EclipsedMod.Items.RubikDiceScrambled2, description)
	EID:addCollectible(EclipsedMod.Items.RubikDiceScrambled3, description)
	EID:addCollectible(EclipsedMod.Items.RubikDiceScrambled4, description)
	EID:addCollectible(EclipsedMod.Items.RubikDiceScrambled5, description)

	EID:addCollectible(EclipsedMod.Items.VHSCassette,
			"!!! SINGLE USE !!! #Move to later floor. #Void - is last possible floor. #On ascension you will be send to Home. #{{Warning}} Effect can be triggered only 1 time per game.")
	EID:addCollectible(EclipsedMod.Items.Lililith,
			"Spawn a random familiar every 7 rooms. #Spawned familiars will be removed on next floor. #Possible familiars: {{Collectible113}} demon baby, {{Collectible275}} lil brimstone, {{Collectible679}} lil abaddon, {{Collectible360}} incubus, {{Collectible417}} succubus, {{Collectible270}} leech, {{Collectible698}} twisted pair.")
	EID:addCollectible(EclipsedMod.Items.CompoBombs,
			"+5 bombs when picked up. #Place 2 bombs at once. #Second bomb is red throwable bomb")
	EID:addCollectible(EclipsedMod.Items.MirrorBombs,
			"+5 bombs when picked up. #The placed bomb will be copied to the opposite side of the room.")
	EID:addCollectible(EclipsedMod.Items.GravityBombs,
			"+1 giga bomb when picked up. #Bombs get {{Collectible512}} Black Hole effect.")
	EID:addCollectible(EclipsedMod.Items.AbihuFam,
			"{{Collectible281}}Decoy familiar. #Can {{Burning}} burn enemies on contact.")
	EID:addCollectible(EclipsedMod.Items.NadabBody,
			"{{Throwable}} Can be picked up and thrown. #Blocks enemy tears. #When thrown explodes on contact with enemy. #{{Warning}} The explosion can hurt you!")
	EID:addCollectible(EclipsedMod.Items.Limb,
			"When you die and don't have any extra life, you will be turned into {{Player10}} soul for current level.")
	EID:addCollectible(EclipsedMod.Items.LongElk,
			"Grants flight. #While moving leave {{Collectible683}} bone spurs. #On use do short dash in movement direction, and kill next contacted enemy.")
	EID:addCollectible(EclipsedMod.Items.FrostyBombs,
			"+5 bombs when picked up. #Bombs leave water creep. #Bombs {{Slow}} slow down enemies. #Turn killed enemies into ice statues.")
	EID:addCollectible(EclipsedMod.Items.VoidKarma,
			"↑ All stats up when entering new level. #{{Damage}} +0.25 damage up #{{Tears}} +0.25 tears up #{{Range}} +2.5 range up #{{Shotspeed}} +0.1 shotspeed up #{{Speed}} +0.05 speed up #{{Luck}} +0.5 luck up #Double it's effect if you didn't take damage on previous floor.")
	EID:addCollectible(EclipsedMod.Items.CharonObol,
			"Pay {{Coin}} 1 coin to spawn {{Collectible684}} hungry soul. #Removes itself when you die.")
	EID:addCollectible(EclipsedMod.Items.Viridian,
			"Grants flight. #Flip player's sprite.")
	EID:addCollectible(EclipsedMod.Items.BookMemory,
			"Erase all enemies in room from current run. #Can't erase bosses. #Add {{BrokenHeart}} broken heart when used.")
	--"Use to activate random effect from saved effects pool. #Saved effects pool - set of used active items, cards, runes or pills in current run. #Activated effect will be removed from saved effects pool. #Reuse item, card or pill to return it to saved effects pool. #If there isn't any saved effect, spawn Oblivion Card and turn into Memory Fragment trinket.")
	EID:addCollectible(EclipsedMod.Items.MongoCells,
			"Copy your familiars.")
	EID:addCollectible(EclipsedMod.Items.CosmicJam,
			"Add Item Wisp from all items in room to player.")
	EID:addCollectible(EclipsedMod.Items.DMS,
			"Enemies has 25% chance to spawn {{Collectible634}} purgatory soul after death.")
	EID:addCollectible(EclipsedMod.Items.MewGen,
			"Grants flight. #If don't shoot more than 5 seconds, activates {{Collectible522}} Telekinesis effect.")
	EID:addCollectible(EclipsedMod.Items.ElderSign,
			"Creates Pentagram for 3 seconds at position where you stand. #Pentagram spawn {{Collectible634}} purgatory Soul. #{{Freezing}} Freeze enemies inside pentagram.")
	EID:addCollectible(EclipsedMod.Items.Eclipse,
			"While shooting grants pulsing aura, dealing player's damage. #{{Damage}} x1.5 damage boost when level has {{CurseDarkness}} Curse of Darkness.")
	EID:addCollectible(EclipsedMod.Items.Threshold,
			"Give actual item from Item Wisp.")
	EID:addCollectible(EclipsedMod.Items.WitchPot,
			"Spawn new trinket. #40% chance to smelt current trinket. #40% chance to spit out smelted trinket. #10% Chance to reroll your current trinket. #{{Warning}} 10% Chance to destroy your current trinket.")
	EID:addCollectible(EclipsedMod.Items.PandoraJar,
			"Add Glass Cannon wisp. #{{Warning}} 15% chance to add curse. #If all curses was added, grants {{Collectible515}} Mystery Gift. This effect can be triggered only once per level.")
	EID:addCollectible(EclipsedMod.Items.DiceBombs,
			"+5 bombs when picked up. #The placed bomb will reroll pickups, chests and items within explosion range. #Devolve enemies.")
	
	--EID:addCollectible(EclipsedMod.Items.AgonyBox,
	--		"Prevents next incoming non self-damage and removes one point of charge. #Can be charged by taking damage from spikes in {{SacrificeRoom}} Sacrifice Room. #Entering a new floor fully recharges the box.")

	EID:addTrinket(EclipsedMod.Trinkets.WitchPaper,
			"{{Collectible422}} Turn back time when you die. #Destroys itself after triggering.")
	EID:addTrinket(EclipsedMod.Trinkets.QueenSpades,
			"33% chance to spawn portal to starting room after clearing room. #Leaving room removes portal.")
			--"Opens Alt.path, Boss Rush and Blue Womb doors while you holding this trinket.")
			--"Opens all alternative doors while you holding this trinket. #Removes after triggering.")
	EID:addTrinket(EclipsedMod.Trinkets.RedScissors,
			"Turn troll-bombs into red throwable bombs.") -- inferior scissors, nah
	EID:addTrinket(EclipsedMod.Trinkets.Duotine,
			"Replaces all future {{Pill}} pills by Red pills while you holding this trinket.")
	EID:addTrinket(EclipsedMod.Trinkets.LostFlower,
			"Give you {{Heart}} full heart container when you get {{EternalHeart}} eternal heart. #Destroys itself when you take damage. #{{Player10}}{{Player31}} Lost: activate {{Card51}} Holy Card effect when you get eternal heart. #{{Player10}}{{Player31}} Lost: use Lost Mirror while holding this trinket to activate {{Card51}} Holy Card effect.")
	EID:addTrinket(EclipsedMod.Trinkets.TeaBag,
			"Remove poison clouds near player.")
	EID:addTrinket(EclipsedMod.Trinkets.MilkTeeth,
			"Enemies have a 15% chance to drop vanishing {{Coin}} coins when they die.")
	EID:addTrinket(EclipsedMod.Trinkets.BobTongue,
			"Bombs get toxic aura, similar to {{Collectible446}} Dead Tooth effect.")
	EID:addTrinket(EclipsedMod.Trinkets.BinderClip,
			"10% chance to get double hearts, coins, keys and bombs. #Pickups with {{Collectible670}} option choices no longer disappear.")
	EID:addTrinket(EclipsedMod.Trinkets.MemoryFragment,
			"Spawn last 3 used {{Card}}{{Rune}}{{Pill}} cards, runes, pills at the start of next floor.") -- +1 golden/mombox/stackable
	EID:addTrinket(EclipsedMod.Trinkets.AbyssCart,
			"If you have baby familiar when you die, remove him and revive you. #Sacrificable familiars will blink periodically when you have 1 heart left. #Destroys itself after triggering and drops {{EternalHeart}} eternal heart.")
	EID:addTrinket(EclipsedMod.Trinkets.RubikCubelet,
			"33% chance to reroll items into {{Collectible721}} glitched items when you take damage.")
	EID:addTrinket(EclipsedMod.Trinkets.TeaFungus,
			"Rooms are flooded.")
	EID:addTrinket(EclipsedMod.Trinkets.DeadEgg,
			"Spawn dead bird familiar for 10 seconds when bomb explodes.")
	EID:addTrinket(EclipsedMod.Trinkets.Penance,
			"16% chance to apply Red Cross indicator to enemies upon entering a room. #When marked enemies die, they shoot beams of light in 4 directions.")
	EID:addTrinket(EclipsedMod.Trinkets.Pompom,
			"Picking up {{Heart}} red hearts can convert them into random red wisps.")
	EID:addTrinket(EclipsedMod.Trinkets.XmasLetter,
			"50% chance when entering room for the first time activate {{Collectible557}} Fortune Cookie. #Leaving this trinket in {{DevilRoom}} devil deal turn it into {{Collectible515}} Mystery Gift on next enter.")
	--EID:addTrinket(EclipsedMod.Trinkets.BountyPoster,
	--		"Grants 15 coins at the start of next run, if you end game with this trinket. #It doesn't matter if you lose or win previous run.")

	EID:addCard(EclipsedMod.Pickups.OblivionCard,
			"Throwable eraser card. #Erase enemies for current level.")
	EID:addCard(EclipsedMod.Pickups.Apocalypse,
			"Fills the whole room with red poop.")
	EID:addCard(EclipsedMod.Pickups.KingChess,
			"Poop around you.")
	EID:addCard(EclipsedMod.Pickups.KingChessW,
			"Poop around you.")
	EID:addCard(EclipsedMod.Pickups.Trapezohedron,
			"Turn all {{Trinket}} trinkets into {{Card78}} cracked keys.")
	EID:addCard(EclipsedMod.Pickups.Domino34,
			"Reroll items and pickups on current level.")
	EID:addCard(EclipsedMod.Pickups.Domino25,
			"Respawn and reroll enemies in current room.")
	EID:addCard(EclipsedMod.Pickups.SoulUnbidden,
			"Add items from all item wisps to player.")

	EID:addCard(EclipsedMod.Pickups.SoulNadabAbihu,
			"Fire and Explosion immunity. #{{Collectible257}} Fire Mind and {{Collectible256}} Hot Bombs effect for current room.")
	EID:addCard(EclipsedMod.Pickups.AscenderBane,
			"Remove one {{BrokenHeart}} broken heart.")
	EID:addCard(EclipsedMod.Pickups.MultiCast,
			"Spawn 3 wisps based on your active item. #Spawn regular wisps if you don't have an active item.")
	EID:addCard(EclipsedMod.Pickups.Wish,
			"{{Collectible515}} Mystery Gift effect.")
	EID:addCard(EclipsedMod.Pickups.Offering,
			"{{Collectible536}} Sacrificial Altar effect.")
	EID:addCard(EclipsedMod.Pickups.InfiniteBlades,
			"Shoot 28 knives in firing direction.")

	EID:addCard(EclipsedMod.Pickups.Transmutation,
			"Reroll pickups and enemies into random pickups.")
	EID:addCard(EclipsedMod.Pickups.RitualDagger,
			"{{Collectible114}} Mom's Knife for current room.")
	EID:addCard(EclipsedMod.Pickups.Fusion,
			"{{Collectible512}} Throw a Black Hole.")
	EID:addCard(EclipsedMod.Pickups.DeuxEx,
			"↑ {{Luck}} +100 luck up for current room.")
	EID:addCard(EclipsedMod.Pickups.Adrenaline,
			"Turn all your {{Heart}} red health into {{Battery}} batteries. #{{Collectible493}} Adrenaline effect for current room.")
	EID:addCard(EclipsedMod.Pickups.Corruption,
			"You can use your active item unlimited times in current room. #{{Warning}} Remove your active item on next room. #{{Warning}} Doesn't affect pocket active item.") --{{Active1}}

	EID:addCard(EclipsedMod.Pickups.GhostGem,
			"Spawn 4 {{Collectible634}} purgatory souls.")
	EID:addCard(EclipsedMod.Pickups.BannedCard,
			--"Spawn 2 {{Card}} cards or {{Rune}} runes.")
			"Spawn 2 copy of this card.")

	EID:addCard(EclipsedMod.Pickups.Domino16,
			"Spawn 6 pickups of same type.")
	EID:addCard(EclipsedMod.Pickups.BattlefieldCard,
			"Teleport to out of map {{ChallengeRoom}} Boss Challenge.")
	EID:addCard(EclipsedMod.Pickups.TreasuryCard,
			"Teleport to out of map {{TreasureRoom}} Treasury.")
	EID:addCard(EclipsedMod.Pickups.BookeryCard,
			"Teleport to out of map {{Library}} Library.")
	EID:addCard(EclipsedMod.Pickups.Decay,
			"Turn your {{Heart}} red hearts into {{RottenHeart}} rotten hearts. #{{Trinket140}} Apple of Sodom effect for current room.")
	EID:addCard(EclipsedMod.Pickups.BloodGroveCard,
			"Teleport to out of map {{CursedRoom}} Curse Room.")
	EID:addCard(EclipsedMod.Pickups.StormTempleCard,
			"Teleport to out of map {{SacrificeRoom}} Sacrifice Room.")
	EID:addCard(EclipsedMod.Pickups.ArsenalCard,
			"Teleport to out of map {{ChestRoom}} Chest Room.")
	EID:addCard(EclipsedMod.Pickups.OutpostCard,
			"Teleport to out of map {{IsaacsRoom}} {{BarrenRoom}} Bedroom.")
	EID:addCard(EclipsedMod.Pickups.CryptCard,
			"Teleport to out of map {{LadderRoom}} Crawlspace.")
	EID:addCard(EclipsedMod.Pickups.MazeMemoryCard,
			"Teleport to out of map {{TreasureRoom}} room with 18 items from random pools. #Only one can be taken. #Apply {{CurseBlind}} Curse of Blind for current level.")
	EID:addCard(EclipsedMod.Pickups.ZeroMilestoneCard,
			"{{Collectible622}} Genesis effect. #Next level is Home.")

	EID:addCard(EclipsedMod.Pickups.RedPill,
			"Temporary ↑ {{Damage}} +10.8 Damage up. #Damage up slowly fades away similarly to {{Collectible621}} Red Stew. #Apply 2 layers of {{Collectible582}} Wavy Cap effect.")
	EID:addCard(EclipsedMod.Pickups.RedPillHorse,
			"Temporary ↑ {{Damage}} +21.6 Damage up. #Damage up slowly fades away similarly to {{Collectible621}} Red Stew. #Apply 4 layers of {{Collectible582}} Wavy Cap effect.")

	--EID:addPill(EclipsedMod.RedPills.RedEffect,
	--	"Grants tmporary 10.8 damage. #Apply 2 layers of Wavy Cap effect. #Horse Pill doubles all effects.")
end
-----------------------------------------------------------------------------------------

local function ExplosionEffect(player, bombPos, bombDamage, bombFlags, damageSource)
	local data = player:GetData()
	local bombRadiusMult = 1
	damageSource = damageSource or true
	if player:HasCollectible(EclipsedMod.Items.FrostyBombs) then
		bombFlags = bombFlags | TearFlags.TEAR_SLOW | TearFlags.TEAR_ICE
		if bombFlags & TearFlags.TEAR_SAD_BOMB == TearFlags.TEAR_SAD_BOMB then
			data.SadIceBombTear = data.SadIceBombTear or {}
			local timer = 1
			local pos = bombPos
			table.insert(data.SadIceBombTear, {timer, pos})
		end
	end

	if bombFlags & TearFlags.TEAR_STICKY == TearFlags.TEAR_STICKY then
		for _, entity in pairs(Isaac.FindInRadius(bombPos, EclipsedMod.NadabData.StickySpiderRadius, EntityPartition.ENEMY)) do
			if entity:IsVulnerableEnemy() and entity:IsActiveEnemy() then
				entity:AddEntityFlags(EntityFlag.FLAG_SPAWN_STICKY_SPIDERS)
			end
		end
	end
	
	game:BombExplosionEffects(bombPos, bombDamage, bombFlags, Color.Default, player, bombRadiusMult, true, damageSource, DamageFlag.DAMAGE_EXPLOSION)

	if player:HasCollectible(EclipsedMod.Items.CompoBombs) then
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
		local num = myrng:RandomInt(2)+4 -- (0 ~ 1) + 4 = 4 ~ 5
		for _ = 1, num do
			player:AddMinisaac(bombPos, true)
		end
	end

	if player:HasTrinket(EclipsedMod.Trinkets.BobTongue) then
		local fartRingEffect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.FART_RING, 0, bombPos, Vector.Zero, nil):ToEffect()
		fartRingEffect:SetTimeout(30)
	end

	DeadEggEffect(player, bombPos, EclipsedMod.DeadEgg.Timeout)

	if player:HasCollectible(EclipsedMod.Items.GravityBombs) then
		local holeEffect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EclipsedMod.GravityBombs.BlackHoleEffect, 0, bombPos, Vector.Zero, nil):ToEffect()
		holeEffect:SetTimeout(60)
		local holeData = holeEffect:GetData()
		holeEffect.Parent = player
		holeEffect.DepthOffset = -100
		holeData.Gravity = true
		holeData.GravityForce = EclipsedMod.GravityBombs.AttractorForce
		holeData.GravityRange = EclipsedMod.GravityBombs.AttractorRange
		holeData.GravityGridRange = EclipsedMod.GravityBombs.AttractorGridRange
	end

	--[
	if player:HasCollectible(EclipsedMod.Items.DiceBombs) then
		local radius = GetBombRadiusFromDamage(bombDamage)
		DiceyReroll(player:GetCollectibleRNG(EclipsedMod.Items.DiceBombs), bombPos, radius)
	end
	--]
end


EclipsedMod.NadabBody = {}
EclipsedMod.NadabBody.SpritePath = "gfx/familiar/nadabbody.png"
EclipsedMod.NadabBody.RocketVol = 30
---Nadab's Body
local function BodyExplosion(player, useGiga, bombPos, damageSource)
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
	ExplosionEffect(player, bombPos, bombDamage, bombFlags, damageSource)
end

local function FcukingBomberbody(player, body, damageSource)
	if body then
		if player:HasCollectible(EclipsedMod.Items.MirrorBombs) then
			if body:GetData().bomby then
				BodyExplosion(player, false, FlipMirrorPos(body.Position), damageSource)
			end
		end
		
		if body:GetData().bomby then
			if player:HasTrinket(TrinketType.TRINKET_RING_CAP) then
				body:GetData().RingCapDelay = 0 
			end
			BodyExplosion(player, true, body.Position, damageSource)
		end
	else
		local bodies = Isaac.FindByType(EntityType.ENTITY_BOMB, BombVariant.BOMB_DECOY)
		if player:HasCollectible(EclipsedMod.Items.MirrorBombs) then
			for _, bomb in pairs(bodies) do
				if bomb:GetData().bomby then
					BodyExplosion(player, false, FlipMirrorPos(bomb.Position))
				end
			end
		end
		for _, bomb in pairs(bodies) do
			if bomb:GetData().bomby then
				if player:HasTrinket(TrinketType.TRINKET_RING_CAP) then
					bomb:GetData().RingCapDelay = 0 
				end
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
function EclipsedMod:onNewRoom3()
	---Nadab's Body
	if #Isaac.FindByType(EntityType.ENTITY_BOMB, BombVariant.BOMB_DECOY) > 0 then
		local bodies = Isaac.FindByType(EntityType.ENTITY_BOMB, BombVariant.BOMB_DECOY)
		for _, body in pairs(bodies) do
			--print(body.SpawnerEntity, body:GetData().bomby, body:GetDropRNG():GetSeed())
			if body.SpawnerEntity == nil or body:GetData().bomby then
				body:Remove()
			end
		end
	end

	--player
	for playerNum = 0, game:GetNumPlayers()-1 do
		local player = game:GetPlayer(playerNum)
		local data = player:GetData()
		if player:GetPlayerType() == EclipsedMod.Characters.Abihu then
			data.AbihuIgnites = false
			if data.AbihuCostumeEquipped then
				data.AbihuCostumeEquipped = false
				--player:AddNullCostume(EclipsedMod.AbihuData.CostumeHead)
				player:TryRemoveNullCostume(EclipsedMod.AbihuData.CostumeHead)
			end
		end

		if GetItemsCount(player, EclipsedMod.Items.NadabBody) > 0 then
			for _=1, GetItemsCount(player, EclipsedMod.Items.NadabBody) do
				local pos = Isaac.GetFreeNearPosition(player.Position, 25)
				if data.HoldBomd and data.HoldBomd >= 0 then
					data.HoldBomd = -1
					pos = player.Position
				end
				local bomb = Isaac.Spawn(EntityType.ENTITY_BOMB, BombVariant.BOMB_DECOY, 0, pos, Vector.Zero, nil):ToBomb()
				--bomb:AddTearFlags(player:GetBombFlags())
				bomb:GetData().bomby = true
				bomb:GetSprite():ReplaceSpritesheet(0, EclipsedMod.NadabBody.SpritePath)
				bomb:GetSprite():LoadGraphics()
				bomb.Parent = player
			end
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, EclipsedMod.onNewRoom3)
---Nadab's Body
function EclipsedMod:onBombNadabUpdate(bomb)
	---bomb updates
	local bombData = bomb:GetData()
	local room = game:GetRoom()
	if bombData.bomby and bomb.Parent then
		
		
		
		local player = bomb.Parent:ToPlayer()
		bomb:SetExplosionCountdown(1) -- so it doesn't explode
		
		--[[
		if bomb.FrameCount%60 == 0 then 
			bomb.CollisionDamage = player.Damage
		end
		--]]
		
		--ring cap explosion
		if bombData.RingCapDelay then
			--print(bombData.RingCapDelay)
			bombData.RingCapDelay = bombData.RingCapDelay + 1
			if bombData.RingCapDelay > player:GetTrinketMultiplier(TrinketType.TRINKET_RING_CAP) * EclipsedMod.NadabData.RingCapFrameCount then
				bombData.RingCapDelay = nil
			elseif bombData.RingCapDelay % EclipsedMod.NadabData.RingCapFrameCount == 0 then
				if player:HasCollectible(EclipsedMod.Items.MirrorBombs) then
					BodyExplosion(player, false, FlipMirrorPos(bomb.Position))
				end
				BodyExplosion(player, false, bomb.Position)
			end
		end
		
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
			--elseif (not room:IsPositionInRoom(bomb.Position, 0) or grid:ToPit()) and not bombData.Thrown then -- and not player.CanFly then
			--	bomb:Kill()
			--	return
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
		if player:HasCollectible(CollectibleType.COLLECTIBLE_BOBBY_BOMB) then
			local raddis = 90
			local nearestNPC = GetNearestEnemy(bomb.Position, raddis)
			if nearestNPC:Distance(bomb.Position) > 10 then
				bomb:AddVelocity((nearestNPC - bomb.Position):Resized(1))
			end
		elseif player:HasCollectible(CollectibleType.COLLECTIBLE_STICKY_BOMBS) then 
			--bomb:AddTearFlags(TearFlags.TEAR_STICKY)
			local raddis = 30
			local nearestNPC = GetNearestEnemy(bomb.Position, raddis)
			--print(nearestNPC:Distance(bomb.Position))
			if nearestNPC:Distance(bomb.Position) > 10 then
				bomb.Velocity = (nearestNPC - bomb.Position):Resized(5)
				--bomb.Velocity = Vector.Zero
			end
		end
		-- leave creep
		if player:HasCollectible(EclipsedMod.Items.FrostyBombs) and game:GetFrameCount() %8 == 0 then -- spawn every 8th frame
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
EclipsedMod:AddCallback(ModCallbacks.MC_POST_BOMB_UPDATE, EclipsedMod.onBombNadabUpdate, BombVariant.BOMB_DECOY)
---Nadab's Body
function EclipsedMod:onBombCollision(bomb, collider)
	local bombData = bomb:GetData()
	if bombData.bomby and collider:ToNPC() then
		collider = collider:ToNPC()
		if not collider:HasEntityFlags(EntityFlag.FLAG_CHARM) then
			if bombData.Thrown then
				local damageSource = false
				if (collider:IsActiveEnemy() and collider:IsVulnerableEnemy()) or collider.Type == EntityType.ENTITY_FIREPLACE then
					bomb.Velocity = -bomb.Velocity * 0.5
					FcukingBomberbody(bomb.Parent:ToPlayer(), bomb, damageSource)
					bombData.Thrown = nil
				end
			end
			if bombData.RocketBody then
				if (collider:IsActiveEnemy() and collider:IsVulnerableEnemy()) or collider.Type == EntityType.ENTITY_FIREPLACE then
					--bomb.Velocity = bomb.Parent:ToPlayer():GetShootingInput() *5 --bomb.Velocity
					bomb.Velocity = -bomb.Velocity * 0.5
					FcukingBomberbody(bomb.Parent:ToPlayer(), bomb)
					bombData.RocketBody = false
				end
			end
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_PRE_BOMB_COLLISION, EclipsedMod.onBombCollision, BombVariant.BOMB_DECOY)

-------------------------------------------------------------------------------------------
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
	if player:HasCollectible(EclipsedMod.Items.MirrorBombs) then

		NadabExplosion(player, false, FlipMirrorPos(player.Position))
	end
	if player:HasTrinket(TrinketType.TRINKET_RING_CAP) then
		player:GetData().RingCapDelay = 0-- player:GetTrinketMultiplier(TrinketType.TRINKET_RING_CAP) * EclipsedMod.NadabData.RingCapFrameCount
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
			if beggar.Position:Distance(player.Position) <= 20 and EclipsedMod.NadabData.BombBeggarSprites[bsprite:GetAnimation()] then
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
		if EclipsedMod.NadabData.ExplosionCountdown > 15 then
			EclipsedMod.NadabData.ExplosionCountdown = 15
		end
	else
		if EclipsedMod.NadabData.ExplosionCountdown < 30 then
			EclipsedMod.NadabData.ExplosionCountdown = 30
		end
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
	local rng = myrng
	for _, enemy in pairs(enemies) do
		local knockback = ppl.ShotSpeed * EclipsedMod.ObliviousData.Knockback
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

			if ppl:HasCollectible(EclipsedMod.Items.MeltedCandle) and not enemy:GetData().Waxed then
				rng = ppl:GetCollectibleRNG(EclipsedMod.Items.MeltedCandle)
				if rng:RandomFloat() + ppl.Luck/100 >= EclipsedMod.MeltedCandle.TearChance then --  0.8
					enemy:AddFreeze(EntityRef(ppl), EclipsedMod.MeltedCandle.FrameCount)
					if enemy:HasEntityFlags(EntityFlag.FLAG_FREEZE) then
						--entity:AddBurn(EntityRef(ppl), 1, 2*ppl.Damage) -- the issue is Freeze stops framecount of entity, so it won't call NPC_UPDATE.
						enemy:AddEntityFlags(EntityFlag.FLAG_BURN)          -- the burn timer doesn't update
						enemy:GetData().Waxed = EclipsedMod.MeltedCandle.FrameCount
						enemy:SetColor(EclipsedMod.MeltedCandle.TearColor, EclipsedMod.MeltedCandle.FrameCount, 100, false, false)
					end
				end
			end

			if tearFlags & TearFlags.TEAR_BURN == TearFlags.TEAR_BURN then
				enemy:AddBurn(EntityRef(ppl), 52, 2*ppl.Damage)
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
				enemy:AddPoison(EntityRef(ppl), 52, 2*ppl.Damage) -- Scorpio
			elseif ppl:HasCollectible(CollectibleType.COLLECTIBLE_SCORPIO) then
				enemy:AddPoison(EntityRef(ppl), 52, 2*ppl.Damage)
			elseif ppl:HasCollectible(CollectibleType.COLLECTIBLE_COMMON_COLD) and 0.25 + ppl.Luck/16 > ppl:GetCollectibleRNG(CollectibleType.COLLECTIBLE_COMMON_COLD):RandomFloat() then
				enemy:AddPoison(EntityRef(ppl), 52, 2*ppl.Damage)
			elseif ppl:HasCollectible(CollectibleType.COLLECTIBLE_SERPENTS_KISS) and 0.15 + ppl.Luck/15 > ppl:GetCollectibleRNG(CollectibleType.COLLECTIBLE_SERPENTS_KISS):RandomFloat() then
				enemy:AddPoison(EntityRef(ppl), 52, 2*ppl.Damage)
			elseif ppl:HasTrinket(TrinketType.TRINKET_PINKY_EYE) and 0.1 + ppl.Luck/20 > ppl:GetTrinketRNG(TrinketType.TRINKET_PINKY_EYE):RandomFloat() then
				enemy:AddPoison(EntityRef(ppl), 52, 2*ppl.Damage)
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
					enemy:AddPoison(EntityRef(ppl), 52, 2*ppl.Damage)
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
					enemy:AddBurn(EntityRef(ppl), 52, 2*ppl.Damage)
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
	effect.Color = EclipsedMod.ObliviousData.Stats.LASER_COLOR
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

local function UnbiddenAura(player, auraPos, delayOff, damageMulti, range, blockLasers)
	local room = game:GetRoom()
	local data = player:GetData()
	local rng = myrng
	range = range or player.TearRange*0.5
	damageMulti = damageMulti or 1
	--damage = damage or player.Damage
	
	if data.UnbiddenBrimCircle and not blockLasers then
		local laser = player:FireTechXLaser(auraPos, Vector.Zero, range, player, damageMulti):ToLaser()
		laser.Color = EclipsedMod.ObliviousData.Stats.LASER_COLOR
		laser:SetTimeout(data.UnbiddenBrimCircle)
		--if math.floor(player.MaxFireDelay) + EclipsedMod.ObliviousData.DamageDelay -
		local newRange = (data.ObliviousDamageDelay)/(math.floor(player.MaxFireDelay) + EclipsedMod.ObliviousData.DamageDelay)
		if newRange < 0.25 then newRange = 0.25 end

		--laser.CollisionDamage = player.Damage * damageMulti
		laser:GetData().CollisionDamage = player.Damage * damageMulti

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
	effect.Color =  EclipsedMod.ObliviousData.Stats.LASER_COLOR

	effect.SpriteScale = effect.SpriteScale * range/100 --effect.SpriteScale * (player.TearRange/200)
	if EclipsedMod.ObliviousData.DamageDelay + math.floor(player.MaxFireDelay) > 8 then
		--sfx:Play(321, 1, 2, false, 10)
		sfx:Play(321,1,2,false,3)
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
			--eaura.Color = EclipsedMod.ObliviousData.Stats.LASER_COLOR
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
			--haura.Color = EclipsedMod.ObliviousData.Stats.LASER_COLOR
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
		local damage = player.Damage * damageMulti
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
					--paura.Color = EclipsedMod.ObliviousData.Stats.LASER_COLOR
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
	glowa.Color = EclipsedMod.OblivionCard.PoofColor --Color(0,0,0,1)
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
	laser.Timeout = player:GetData().ObliviousDamageDelay
	--laser:SetColor(EclipsedMod.ObliviousData.Stats.LASER_COLOR, 5000, 100, true, false)
end

local function WeaponAura(player, auraPos, frameCount, maxCharge, range, blockLasers, delayOff)
	delayOff = delayOff or nil
	range = range or player.TearRange*0.33
	frameCount = frameCount or game:GetFrameCount()
	maxCharge = maxCharge or EclipsedMod.ObliviousData.DamageDelay + math.floor(player.MaxFireDelay)
	if maxCharge == 0 then maxCharge = EclipsedMod.ObliviousData.DamageDelay end
	--print(frameCount, maxCharge)
	if frameCount%maxCharge == 0 then
		local tearsNum = GetMultiShotNum(player)
		for _ = 0, tearsNum do -- start from 0. cause you must have at least 1 multiplier
			--UnbiddenAura(player, auraPos) -- idk why knife is attacks 2 times (updates 2 times?)
			UnbiddenAura(player, auraPos, delayOff, nil, range, blockLasers)
		end
	end
end

local function Technology2Aura(player)
	local range = player.TearRange*0.33
	local laser = player:FireTechXLaser(player.Position, Vector.Zero, range, player, 0.13):ToLaser()
	laser:AddEntityFlags(EntityFlag.FLAG_PERSISTENT)
	laser:GetData().UnbiddenTech2Laser = game:GetLevel():GetCurrentRoomIndex()
	laser:GetData().EnavleVisible = 0
	player:GetData().HasTech2Laser = true
	--laser.Color = EclipsedMod.ObliviousData.Stats.LASER_COLOR
	--WhatSoundIsIt()
end

function EclipsedMod:onLaserUpdate(laser) -- low
	local laserData = laser:GetData()
	if laser.SpawnerEntity and laser.SpawnerEntity:ToPlayer() and laser.SpawnerEntity:ToPlayer():GetPlayerType() == EclipsedMod.Characters.Oblivious then
		local player = laser.SpawnerEntity:ToPlayer()
		local data = player:GetData()
		laser.Color = EclipsedMod.ObliviousData.Stats.LASER_COLOR
		--laser.CollisionDamage = laserData.CollisionDamage or laser.CollisionDamage  -- not working
		--print(laser.CollisionDamage, laserData.CollisionDamage)
		
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
				local fetusTear = player:FireTear(laser.Position, RandomVector()*player.ShotSpeed*14, false, false, false, player, 1):ToTear()
				fetusTear:ChangeVariant(TearVariant.FETUS)
				fetusTear:AddTearFlags(TearFlags.TEAR_FETUS)
				fetusTear:GetData().BrimFetus = true
				local tearSprite = fetusTear:GetSprite()
				tearSprite:ReplaceSpritesheet(0, "gfx/characters/costumes_unbidden/fetus_tears.png")
				tearSprite:LoadGraphics()
			end
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_LASER_UPDATE, EclipsedMod.onLaserUpdate )

---KNIFE
function EclipsedMod:onKnifeUpdate(knife, _) -- low
	if knife.SpawnerEntity and knife.SpawnerEntity:ToPlayer() then
		local player = knife.SpawnerEntity:ToPlayer()
		local data = player:GetData()
		if player:GetPlayerType() == EclipsedMod.Characters.Oblivious then
			WeaponAura(player, knife.Position, knife.FrameCount, data.ObliviousDamageDelay, player.TearRange*0.5)
			--local function WeaponAura(player, auraPos, frameCount, maxCharge, range, blockLasers)
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_PRE_KNIFE_COLLISION, EclipsedMod.onKnifeUpdate) --KnifeSubType --MC_POST_KNIFE_UPDATE

---FETUS BOMB
function EclipsedMod:onFetusBombUpdate(bomb) -- low
	if bomb.IsFetus and bomb.SpawnerEntity and bomb.SpawnerEntity:ToPlayer() then
		local player = bomb.SpawnerEntity:ToPlayer()
		if player:GetPlayerType() == EclipsedMod.Characters.Oblivious then
			WeaponAura(player, bomb.Position, bomb.FrameCount, 20) -- +7 bomb explodes on 40 frame
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_BOMB_UPDATE, EclipsedMod.onFetusBombUpdate)

---FETUS TEAR
function EclipsedMod:onTearUpdate(tear)
	if tear.SpawnerEntity and tear.SpawnerEntity:ToPlayer() and tear.SpawnerEntity:ToPlayer():GetPlayerType() == EclipsedMod.Characters.Oblivious then
		local player = tear.SpawnerEntity:ToPlayer()
		tear.Color = EclipsedMod.ObliviousData.Stats.TEAR_COLOR
		tear.SplatColor = EclipsedMod.ObliviousData.Stats.LASER_COLOR
		if tear:HasTearFlags(TearFlags.TEAR_FETUS) then
			if tear:GetData().BrimFetus then
				WeaponAura(player, tear.Position, tear.FrameCount, 22, nil, true, true)
				--WeaponAura(player, auraPos, frameCount, maxCharge, range, blockLasers)
			elseif not player:GetData().UnbiddenBrimCircle then
				WeaponAura(player, tear.Position, tear.FrameCount)
			end
		elseif tear.Variant == TearVariant.SWORD_BEAM or tear.Variant == TearVariant.TECH_SWORD_BEAM then
			WeaponAura(player, tear.Position, tear.FrameCount)
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, EclipsedMod.onTearUpdate)

--[
---Target Mark
function EclipsedMod:onTargetEffectUpdate(effect)
	if effect.FrameCount == 1 and effect.SpawnerEntity and effect.SpawnerEntity:ToPlayer() and effect.SpawnerEntity:ToPlayer():GetPlayerType() == EclipsedMod.Characters.Oblivious then
		effect.Color = EclipsedMod.ObliviousData.Stats.TEAR_COLOR
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, EclipsedMod.onTargetEffectUpdate, EffectVariant.TARGET)
--]

--[[
---Target Occult
function EclipsedMod:onTargetEffectUpdate(effect)
	if effect.SpawnerEntity and effect.SpawnerEntity:ToPlayer() and effect.SpawnerEntity:ToPlayer():GetPlayerType() == EclipsedMod.Characters.Oblivious then
		local player = effect.SpawnerEntity:ToPlayer()
		effect.Color = EclipsedMod.ObliviousData.Stats.TEAR_COLOR
		WeaponAura(player, effect.Position, effect.FrameCount, nil, player.TearRange*0.5) -- true
		--WeaponAura(player, auraPos, frameCount, maxCharge, range, blockLasers)
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, EclipsedMod.onTargetEffectUpdate, EffectVariant.OCCULT_TARGET)
--]]

--[
---Target Occult
function EclipsedMod:onEpicFetusEffectUpdate(effect)
	if effect.SpawnerEntity and effect.SpawnerEntity:ToPlayer() and effect.SpawnerEntity:ToPlayer():GetPlayerType() == EclipsedMod.Characters.Oblivious then
		local player = effect.SpawnerEntity:ToPlayer()
		--effect.Color = EclipsedMod.ObliviousData.Stats.TEAR_COLOR
		WeaponAura(player, effect.Position, effect.FrameCount, nil, player.TearRange*0.5) -- true
		--WeaponAura(player, auraPos, frameCount, maxCharge, range, blockLasers)
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, EclipsedMod.onEpicFetusEffectUpdate, EffectVariant.ROCKET)
--]

function EclipsedMod:onPEffectUpdate3(player)
	local level = game:GetLevel()
	--local room = game:GetRoom()
	local data = player:GetData()
	local tempEffects = player:GetEffects()

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
	if player:HasCollectible(EclipsedMod.Items.NadabBody) then
		if player:GetPlayerType() ~= EclipsedMod.Characters.Abihu then

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

		if player:GetPlayerType() ~= EclipsedMod.Characters.Nadab then
			ExplosionCountdownManager(player)
		end

		local bomboys = 0 -- nadab's body count
		local bombVar = BombVariant.BOMB_DECOY
		if player:GetPlayerType() == EclipsedMod.Characters.Abihu then bombVar = -1 end
		local roombombs = Isaac.FindByType(EntityType.ENTITY_BOMB, bombVar) --, BombVariant.BOMB_DECOY)
		if #roombombs > 0 then
			for _, body in pairs(roombombs) do
				if body:GetData().bomby then
					bomboys = bomboys +1
				end
				-- check if abihu can hold bomb
				--if player:GetPlayerType() == EclipsedMod.Characters.Abihu then
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
		if bomboys < GetItemsCount(player, EclipsedMod.Items.NadabBody) then
			bomboys = GetItemsCount(player, EclipsedMod.Items.NadabBody) - bomboys
			for _=1, bomboys do
				local pos = Isaac.GetFreeNearPosition(player.Position, 25)
				Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, pos, Vector.Zero, nil)
				local bomb = Isaac.Spawn(EntityType.ENTITY_BOMB, BombVariant.BOMB_DECOY, 0, pos, Vector.Zero, nil):ToBomb()
				bomb:GetData().bomby = true
				bomb:GetSprite():ReplaceSpritesheet(0, EclipsedMod.NadabBody.SpritePath)
				bomb:GetSprite():LoadGraphics()
				bomb.Parent = player
			end
		end

		if Input.IsActionPressed(ButtonAction.ACTION_BOMB, 0) and player:GetPlayerType() == EclipsedMod.Characters.Abihu then --Input.IsActionPressed(action, controllerId) IsActionTriggered
			local checkBombsNum = player:GetHearts()
			if checkBombsNum > 0 and data.ExCountdown == 0 then --  and not player:HasCollectible(CollectibleType.COLLECTIBLE_BLOOD_BOMBS) -- and player:GetNumBombs() > 0 then
				if player:HasCollectible(CollectibleType.COLLECTIBLE_ROCKET_IN_A_JAR) then
					if player:GetFireDirection() == -1 then
						data.ExCountdown = EclipsedMod.NadabData.ExplosionCountdown
						if not player:HasCollectible(CollectibleType.COLLECTIBLE_PYROMANIAC) then
							player:TakeDamage(1, DamageFlag.DAMAGE_NO_PENALTIES | DamageFlag.DAMAGE_RED_HEARTS, EntityRef(player), 1)
						end
						FcukingBomberbody(player)
					else
						if not player:HasCollectible(CollectibleType.COLLECTIBLE_PYROMANIAC) then
							player:TakeDamage(1, DamageFlag.DAMAGE_NO_PENALTIES | DamageFlag.DAMAGE_RED_HEARTS, EntityRef(player), 1) -- take dmg first to apply MARS dash
						end
						data.ExCountdown = EclipsedMod.NadabData.ExplosionCountdown
						local bodies2 = Isaac.FindByType(EntityType.ENTITY_BOMB, BombVariant.BOMB_DECOY)
						for _, body in pairs(bodies2) do
							if body:GetData().bomby then
								body:GetData().RocketBody = EclipsedMod.NadabBody.RocketVol
								body.Velocity = player:GetShootingInput() * body:GetData().RocketBody
							end
						end
					end
				else
					data.ExCountdown = EclipsedMod.NadabData.ExplosionCountdown
					if not player:HasCollectible(CollectibleType.COLLECTIBLE_PYROMANIAC) then
						player:TakeDamage(1, DamageFlag.DAMAGE_NO_PENALTIES | DamageFlag.DAMAGE_RED_HEARTS, EntityRef(player), 1)
					end
					FcukingBomberbody(player)
				end
			end
		end
	end

	if player:GetPlayerType() == EclipsedMod.Characters.Nadab then
		AbihuNadabManager(player)
		ExplosionCountdownManager(player)
		--ice cube bombs
		if player:HasCollectible(EclipsedMod.Items.FrostyBombs) and game:GetFrameCount() %8 == 0 then -- spawn every 8th frame
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
			if data.RingCapDelay > player:GetTrinketMultiplier(TrinketType.TRINKET_RING_CAP) * EclipsedMod.NadabData.RingCapFrameCount then
				data.RingCapDelay = nil
			elseif data.RingCapDelay % EclipsedMod.NadabData.RingCapFrameCount == 0 then
				if player:HasCollectible(EclipsedMod.Items.MirrorBombs) then
					NadabExplosion(player, false, FlipMirrorPos(player.Position))
				end
				NadabExplosion(player, false, player.Position)
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
				data.ExCountdown = EclipsedMod.NadabData.ExplosionCountdown
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
						data.ExCountdown = EclipsedMod.NadabData.ExplosionCountdown
						if not player:HasCollectible(CollectibleType.COLLECTIBLE_PYROMANIAC) then
							player:TakeDamage(1, DamageFlag.DAMAGE_NO_PENALTIES | DamageFlag.DAMAGE_RED_HEARTS, EntityRef(player), 1)
						end
						FcukingBomberman(player)
					end
				else
					data.ExCountdown = EclipsedMod.NadabData.ExplosionCountdown
					if not player:HasCollectible(CollectibleType.COLLECTIBLE_PYROMANIAC) then
						player:TakeDamage(1, DamageFlag.DAMAGE_NO_PENALTIES | DamageFlag.DAMAGE_RED_HEARTS, EntityRef(player), 1)
					end
					FcukingBomberman(player)
				end
			end
		end

	end

	if player:GetPlayerType() == EclipsedMod.Characters.Abihu then
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
		local maxCharge =  math.floor(player.MaxFireDelay) + EclipsedMod.AbihuData.DamageDelay

		--data.AbihuCostumeEquipped = true
		--player:AddNullCostume(EclipsedMod.AbihuData.CostumeHead)

		-- if "shooting" / shoot inputs is pressed
		if player:GetFireDirection() == -1 then -- or data.AbihuIgnites
			if data.AbihuDamageDelay == maxCharge then
				local spid = math.floor(player.ShotSpeed * 14)
				sfx:Play(536)
				local flame = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLUE_FLAME, 0, player.Position, player:GetLastDirection()*spid, player):ToEffect()
				flame:SetTimeout(math.floor(player.TearRange*0.1))
				flame.CollisionDamage = player.Damage * 2
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
						data.HoldBomd = EclipsedMod.AbihuData.HoldBombDelay
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
				data.HoldBomd = EclipsedMod.AbihuData.HoldBombDelay
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
			if not data.AbihuCostumeEquipped then
				data.AbihuCostumeEquipped = true
				player:AddNullCostume(EclipsedMod.AbihuData.CostumeHead)
			end
		end

		--glowing
		if data.ResetBlind then
			data.ResetBlind = data.ResetBlind -1
			if data.ResetBlind <= 0 then
				data.BlindAbihu = true
				SetBlindfold(player, true)
				data.ResetBlind = nil
			end
		end
	end

	if player:GetPlayerType() == EclipsedMod.Characters.Unbidden then
		if player:GetMaxHearts() > 0 then
			local maxHearts = player:GetMaxHearts()
			player:AddMaxHearts(-maxHearts)
            --player:AddBlackHearts(maxHearts)
			player:AddSoulHearts(maxHearts)
        end

		if player:GetHearts() > 0 then
			player:AddHearts(-player:GetHearts())
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
			end
        end
	end

	if player:GetPlayerType() == EclipsedMod.Characters.Oblivious then

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

		rockets - remove blind, target mark spawn aura
		axe - remove blind
		urn - remove blind

		marked - target mark spawn aura
		eye of occlult - target mark spawn aura

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

		if player:HasWeaponType(WeaponType.WEAPON_BOMBS) or
			player:HasWeaponType(WeaponType.WEAPON_ROCKETS) or
			player:HasWeaponType(WeaponType.WEAPON_FETUS) or
			player:HasWeaponType(WeaponType.WEAPON_SPIRIT_SWORD) or
			player:HasWeaponType(WeaponType.WEAPON_KNIFE) then

			if data.BlindUnbidden then
				data.BlindUnbidden = false
				SetBlindfold(player, false)
			end
		elseif not data.BlindUnbidden then
			data.BlindUnbidden = true
			SetBlindfold(player, true)
		end

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
			if laserDelay < EclipsedMod.ObliviousData.DamageDelay then laserDelay = EclipsedMod.ObliviousData.DamageDelay end
			data.UnbiddenBrimCircle = laserDelay
			--data.UnbiddenBrimCircleRange = data.ObliviousDamageDelay
		elseif data.UnbiddenBrimCircle then
			data.UnbiddenBrimCircle = false
		end

		if data.BlindUnbidden then

			-- change position if you has ludo
			local auraPos = player.Position

			if player:HasCollectible(CollectibleType.COLLECTIBLE_DEAD_EYE) then
				data.DeadEyeCounter = data.DeadEyeCounter or 0
				data.DeadEyeMissCounter = data.DeadEyeMissCounter or 0
			end
			--if player:HasCollectible(CollectibleType.COLLECTIBLE_MARKED) or
			if player:HasCollectible(CollectibleType.COLLECTIBLE_CHOCOLATE_MILK) or player:HasCollectible(CollectibleType.COLLECTIBLE_TECH_X) or player:HasCollectible(CollectibleType.COLLECTIBLE_CURSED_EYE) then -- semi-charge
				data.UnbiddenSemiCharge = true
			elseif player:HasCollectible(CollectibleType.COLLECTIBLE_MONSTROS_LUNG) or player:HasCollectible(CollectibleType.COLLECTIBLE_BRIMSTONE) then --or player:HasWeaponType(WeaponType.WEAPON_MONSTROS_LUNGS) then
				data.UnbiddenFullCharge = true
				if data.UnbiddenSemiCharge then data.UnbiddenSemiCharge = false end
			else
				if data.UnbiddenFullCharge then data.UnbiddenFullCharge = false end
				if data.UnbiddenSemiCharge then data.UnbiddenSemiCharge = false end
			end


			if player:HasCollectible(CollectibleType.COLLECTIBLE_MARKED) then
				local targets = Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.TARGET)
				if #targets > 0 then
					for _, target in pairs(targets) do
						if target.SpawnerEntity and target.SpawnerEntity:ToPlayer() and target.SpawnerEntity:ToPlayer():GetPlayerType() == EclipsedMod.Characters.Oblivious then
							auraPos = target.Position
							--target.Color = EclipsedMod.ObliviousData.Stats.TEAR_COLOR
							data.UnbiddenMarked = true
						end
					end
				else
					data.UnbiddenMarked = false
				end
			else
				if data.UnbiddenMarked then data.UnbiddenMarked = nil end
			end

			if player:HasCollectible(CollectibleType.COLLECTIBLE_EYE_OF_THE_OCCULT) then
				local targets = Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.OCCULT_TARGET)
				if #targets > 0 then
					for _, target in pairs(targets) do
						if target.SpawnerEntity and target.SpawnerEntity:ToPlayer() and target.SpawnerEntity:ToPlayer():GetPlayerType() == EclipsedMod.Characters.Oblivious then
							auraPos = target.Position
							data.UnbiddenOccult = true
						end
					end
				else
					data.UnbiddenOccult = false
				end
			else
				if data.UnbiddenOccult then data.UnbiddenOccult = nil end
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
						local laser = player:FireTechXLaser(auraPos, Vector.Zero, player.TearRange*0.5, player, 1):ToLaser()--Isaac.Spawn(EntityType.ENTITY_LASER, EclipsedMod.ObliviousData.TearVariant, 0, player.Position, Vector.Zero, player):ToTear()
						--laser:AddTearFlags(player.TearFlags)
						laser:GetData().UnbiddenLaser = level:GetCurrentRoomIndex()
						laser:AddEntityFlags(EntityFlag.FLAG_PERSISTENT)
						laser:SetTimeout(30)
						data.TechLudo = true
					end
				else
					local tears = Isaac.FindByType(EntityType.ENTITY_TEAR, EclipsedMod.ObliviousData.TearVariant)
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
						local tear = Isaac.Spawn(EntityType.ENTITY_TEAR, EclipsedMod.ObliviousData.TearVariant, 0, player.Position, Vector.Zero, player):ToTear()
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
			local maxCharge = math.floor(player.MaxFireDelay) + EclipsedMod.ObliviousData.DamageDelay
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
			if player:GetFireDirection() == -1 or data.UnbiddenMarkedAuto then
				if data.UnbiddenMarkedAuto then data.UnbiddenMarkedAuto = nil end
				if data.ObliviousTechDot5Delay then data.ObliviousTechDot5Delay = 0 end
				if data.HasTech2Laser then data.HasTech2Laser = false end

				if data.UnbiddenSemiCharge and data.ObliviousDamageDelay > 0 then
					--if data.ObliviousDamageDelay > 0.15*maxCharge then
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

						local ChocolateDamageMultiplier = 1
						if player:HasCollectible(CollectibleType.COLLECTIBLE_CHOCOLATE_MILK) then
							
							if player:HasCollectible(CollectibleType.COLLECTIBLE_BRIMSTONE) then
								ChocolateDamageMultiplier = chargeCounter * 0.025
								if ChocolateDamageMultiplier < 0.25 then ChocolateDamageMultiplier = 0.25 end
							else
								ChocolateDamageMultiplier = chargeCounter * 0.04 
								if ChocolateDamageMultiplier < 0.1 then ChocolateDamageMultiplier = 0.1 end
							end
							--print(player.Damage * ChocolateDamageMultiplier, ChocolateDamageMultiplier)
						end

						UnbiddenAura(player, auraPos, false, ChocolateDamageMultiplier)
					--else
					--	data.ObliviousDamageDelay = 0
					--end
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
				elseif data.ludo or player:HasCollectible(CollectibleType.COLLECTIBLE_EYE_OF_THE_OCCULT) then -- auto attack
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
				if player:HasCollectible(CollectibleType.COLLECTIBLE_TECH_5) then
					data.ObliviousTechDot5Delay = data.ObliviousTechDot5Delay or 0
					data.ObliviousTechDot5Delay = data.ObliviousTechDot5Delay + 1
					if data.ObliviousTechDot5Delay >= maxCharge then --data.BlindUnbidden
						TechDot5Shot(player)
						data.ObliviousTechDot5Delay = 0
					end
				end
				-- if player has monstro's lung charge attack
				if data.UnbiddenFullCharge or data.UnbiddenSemiCharge then

					if data.ObliviousDamageDelay < maxCharge then
						data.ObliviousDamageDelay = data.ObliviousDamageDelay + 1
					elseif data.ObliviousDamageDelay == maxCharge then
						if game:GetFrameCount() % 6 == 0 then
							player:SetColor(Color(1,1,1,1, 0.2, 0.2, 0.5), 2, 1, true, false)
						end
						if data.UnbiddenMarked or data.UnbiddenOccult then
							data.UnbiddenMarkedAuto = true
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

				if player:HasCollectible(CollectibleType.COLLECTIBLE_MARKED) then
					data.UnbiddenMarked = true
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
				data.BlindUnbidden = true
				SetBlindfold(player, true)
				data.NoAnimReset = nil
			end
		end

		--glowing
		if data.ResetBlind then
			data.ResetBlind = data.ResetBlind -1
			if data.ResetBlind <= 0 then
				data.BlindUnbidden = true
				SetBlindfold(player, true)
				data.ResetBlind = nil
			end
		end

	--[[
	else
		if data.ObliviousCostumeEquipped then
			player:TryRemoveNullCostume(EclipsedMod.ObliviousData.CostumeHead)
			data.ObliviousCostumeEquipped = false
			if player:HasCollectible(EclipsedMod.Items.Threshold) then player:RemoveCollectible(EclipsedMod.Items.Threshold) end
		end
	--]]
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, EclipsedMod.onPEffectUpdate3)

function EclipsedMod:onUpdate2()
	--- Unbidden time rewind ability. don't trigger if you have more than 11 broken hearts a
	for playerNum = 0, game:GetNumPlayers()-1 do
		local player = game:GetPlayer(playerNum):ToPlayer()
		local data = player:GetData()
		if player:GetPlayerType() == EclipsedMod.Characters.Oblivious and not player:HasCollectible(EclipsedMod.Items.Threshold) and player:CanAddCollectible(EclipsedMod.Items.Threshold) and not player:HasCurseMistEffect() and not player:IsCoopGhost() then
			player:SetPocketActiveItem(EclipsedMod.Items.Threshold, ActiveSlot.SLOT_POCKET, false)
		end

		if player:IsDead() and not player:HasTrinket(EclipsedMod.Trinkets.WitchPaper) and player:GetBrokenHearts() < 11 then
			if player:GetPlayerType() == EclipsedMod.Characters.Unbidden or player:GetPlayerType() == EclipsedMod.Characters.Oblivious then
				player:UseActiveItem(CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS, myUseFlags)
				data.NoAnimReset = 2
			end
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_UPDATE, EclipsedMod.onUpdate2)

function EclipsedMod:onInputAction(entity, _, buttonAction) -- entity, inputHook, buttonAction
	--- Disable bomb placing ability for Nadab & Abihu
	if entity and entity.Type == EntityType.ENTITY_PLAYER and not entity:IsDead() then
		local player = entity:ToPlayer()
		if (player:GetPlayerType() == EclipsedMod.Characters.Nadab or player:GetPlayerType() == EclipsedMod.Characters.Abihu) and buttonAction == ButtonAction.ACTION_BOMB then
			return false
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_INPUT_ACTION, EclipsedMod.onInputAction)

function EclipsedMod:onPlayerInit(player)
	--- mod chars Init
	local data = player:GetData()
	--local idx = getPlayerIndex(player)

	if player:GetPlayerType() == EclipsedMod.Characters.Nadab then -- nadab
		data.NadabCostumeEquipped = true
		player:AddNullCostume(EclipsedMod.NadabData.CostumeHead)
		if not player:HasCollectible(EclipsedMod.Items.AbihuFam) then player:AddCollectible(EclipsedMod.Items.AbihuFam, 0, true) end
	else
		if data.NadabCostumeEquipped then
			player:TryRemoveNullCostume(EclipsedMod.NadabData.CostumeHead)
			data.NadabCostumeEquipped = nil
			if player:HasCollectible(EclipsedMod.Items.AbihuFam) then player:RemoveCollectible(EclipsedMod.Items.AbihuFam) end
		end
	end

	if player:GetPlayerType() == EclipsedMod.Characters.Abihu then -- nadab
		data.BlindAbihu = true
		SetBlindfold(player, true)
		--data.AbihuCostumeEquipped = true
		--player:AddNullCostume(EclipsedMod.AbihuData.CostumeHead)
		if not player:HasCollectible(EclipsedMod.Items.NadabBody) then player:AddCollectible(EclipsedMod.Items.NadabBody) end
	else
		if data.BlindAbihu then
			data.BlindAbihu = nil
			SetBlindfold(player, false)
		end
		if data.AbihuCostumeEquipped then
			player:TryRemoveNullCostume(EclipsedMod.AbihuData.CostumeHead)
			data.AbihuCostumeEquipped = nil
			if player:HasCollectible(EclipsedMod.Items.NadabBody) then player:RemoveCollectible(EclipsedMod.Items.NadabBody) end
		end
	end

	if player:GetPlayerType() == EclipsedMod.Characters.Oblivious then
		data.ObliviousCostumeEquipped = true
		--player:AddNullCostume(EclipsedMod.ObliviousData.CostumeHead)
		data.BlindUnbidden = true
		SetBlindfold(player, true)
	else
		if data.BlindUnbidden then
			data.BlindUnbidden = nil
			SetBlindfold(player, false)
			if player:HasCollectible(EclipsedMod.Items.Threshold) then player:RemoveCollectible(EclipsedMod.Items.Threshold) end
		end
		if data.ObliviousCostumeEquipped then
			--player:TryRemoveNullCostume(EclipsedMod.ObliviousData.CostumeHead)
			data.ObliviousCostumeEquipped = nil
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, EclipsedMod.onPlayerInit)

function EclipsedMod:onCache4(player, cacheFlag)
	--- char stats
	player = player:ToPlayer()
	--local data = player:GetData()
	if player:GetPlayerType() == EclipsedMod.Characters.Nadab then
		if cacheFlag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * EclipsedMod.NadabData.Stats.DAMAGE
			if player:HasCollectible(CollectibleType.COLLECTIBLE_MR_MEGA) then
				player.Damage = player.Damage + player.Damage * EclipsedMod.NadabData.MrMegaDmgMultiplier
			end
		end
		if cacheFlag == CacheFlag.CACHE_FIREDELAY and player:HasCollectible(CollectibleType.COLLECTIBLE_SAD_BOMBS) then
			player.MaxFireDelay = player.MaxFireDelay + EclipsedMod.NadabData.SadBombsFiredelay
		end
		if cacheFlag == CacheFlag.CACHE_SPEED then
			player.MoveSpeed = player.MoveSpeed + EclipsedMod.NadabData.Stats.SPEED
			if player:HasCollectible(CollectibleType.COLLECTIBLE_FAST_BOMBS) and player.MoveSpeed < 1.0 then
				player.MoveSpeed = 1.0
			end
		end
		if cacheFlag == CacheFlag.CACHE_TEARFLAG and player:HasCollectible(CollectibleType.COLLECTIBLE_BOBBY_BOMB) then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_HOMING
		end
	end

	if player:GetPlayerType() == EclipsedMod.Characters.Abihu then
		if cacheFlag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * EclipsedMod.AbihuData.Stats.DAMAGE
		end
		if cacheFlag == CacheFlag.CACHE_SPEED then
			player.MoveSpeed = player.MoveSpeed + EclipsedMod.AbihuData.Stats.SPEED
		end
	end

	if player:GetPlayerType() == EclipsedMod.Characters.Unbidden then
		if cacheFlag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * EclipsedMod.UnbiddenData.Stats.DAMAGE
		end
		if cacheFlag == CacheFlag.CACHE_LUCK then
			player.Luck = player.Luck + EclipsedMod.UnbiddenData.Stats.LUCK
		end
		if cacheFlag == CacheFlag.CACHE_TEARCOLOR then
			player.TearColor = EclipsedMod.ObliviousData.Stats.TEAR_COLOR --Color(0.5,1,2,1,0,0,0)
			player.LaserColor =  EclipsedMod.ObliviousData.Stats.LASER_COLOR
		end
	end

	if player:GetPlayerType() == EclipsedMod.Characters.Oblivious then
		if cacheFlag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * EclipsedMod.ObliviousData.Stats.DAMAGE
		end
		if cacheFlag == CacheFlag.CACHE_LUCK then
			player.Luck = player.Luck + EclipsedMod.ObliviousData.Stats.LUCK
		end
		if cacheFlag == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | EclipsedMod.ObliviousData.Stats.TRAR_FLAG

		end
		if cacheFlag == CacheFlag.CACHE_TEARCOLOR then
			player.TearColor = EclipsedMod.ObliviousData.Stats.TEAR_COLOR --Color(0.5,1,2,1,0,0,0)
			player.LaserColor =  EclipsedMod.ObliviousData.Stats.LASER_COLOR
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, EclipsedMod.onCache4)

function EclipsedMod:OnDetonatorUse(_,_, player) --item, rng, player
	---Nadab
	local data = player:GetData()
	if player:GetPlayerType() == EclipsedMod.Characters.Nadab then
		data.ExCountdown = data.ExCountdown or 0
		if data.ExCountdown == 0 then
			data.ExCountdown = EclipsedMod.NadabData.ExplosionCountdown
			FcukingBomberman(player)
		end
	end
	---Nadab's Body
	if player:HasCollectible(EclipsedMod.Items.NadabBody) then
		data.ExCountdown = data.ExCountdown or 0
		if data.ExCountdown == 0 then
			data.ExCountdown = EclipsedMod.NadabData.ExplosionCountdown
			local bodies = Isaac.FindByType(EntityType.ENTITY_BOMB, BombVariant.BOMB_DECOY)
			for _, body in pairs(bodies) do
				if body:GetData().bomby then
					FcukingBomberbody(player)
				end
			end
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_ITEM, EclipsedMod.OnDetonatorUse, CollectibleType.COLLECTIBLE_REMOTE_DETONATOR)

function EclipsedMod:use2ofClubs(_, player) -- card, player
	--- Nadab & Abihu replace 2ofClubs effect by 2ofHearts
	if player:GetPlayerType() == EclipsedMod.Characters.Nadab or player:GetPlayerType() == EclipsedMod.Characters.Abihu then
		player:AddBombs(-2)
		player:UseCard(Card.CARD_HEARTS_2, myUseFlags)
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_CARD, EclipsedMod.use2ofClubs, Card.CARD_CLUBS_2)

function EclipsedMod:onBombsAreKey(_, player) -- pill, player
	--- Nadab & Abihu BombsAreKeys pill effect shifts hearts and keys
	if player:GetPlayerType() == EclipsedMod.Characters.Nadab or player:GetPlayerType() == EclipsedMod.Characters.Abihu then
		local player_keys = player:GetNumKeys()
		local player_hearts = player:GetHearts()
		player:AddHearts(player_keys-player_hearts)
        player:AddKeys(player_hearts-player_keys)
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_PILL, EclipsedMod.onBombsAreKey, PillEffect.PILLEFFECT_BOMBS_ARE_KEYS)

--- Threshold
function EclipsedMod:onThreshold(_, _, player) --item, rng, player, useFlag, activeSlot, customVarData
	--- unbidden personal item: add item wisp
	--player:UseCard(Card.RUNE_BLACK, myUseFlags)
	local wisp = AddItemFromWisp(player, true, true)  --priority on a top left wisp (seemingly)
	if wisp then
		return false
	end
	return true
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_ITEM, EclipsedMod.onThreshold, EclipsedMod.Items.Threshold)

function EclipsedMod:onItemCollision2(pickup, collider) --add --PickupVariant.PICKUP_SHOPITEM
	--- unbidden item collision
	local level = game:GetLevel()
	local room = game:GetRoom()
	if collider:ToPlayer() and GetCurrentDimension() ~= 2 and level:GetCurrentRoomIndex() ~= GridRooms.ROOM_GENESIS_IDX and room:GetType() ~= RoomType.ROOM_BOSSRUSH then --and room:GetType() ~= RoomType.ROOM_CHALLENGE  then --
		local player = collider:ToPlayer()
		if player:GetPlayerType() == EclipsedMod.Characters.Unbidden or player:GetPlayerType() == EclipsedMod.Characters.Oblivious then
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
					if player:GetPlayerType() == EclipsedMod.Characters.Unbidden and pickup.Price > -5 then
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
				if pickup.SubType == 0 or CheckItemTags(pickup.SubType, ItemConfig.TAG_QUEST) or pickup.SubType == CollectibleType.COLLECTIBLE_BIRTHRIGHT or pickup.SubType == CollectibleType.COLLECTIBLE_DEATH_CERTIFICATE then
					return
				else
					local wisp = player:AddItemWisp(pickup.SubType, pickup.Position):ToFamiliar()
					wisp.HitPoints = 8
					sfx:Play(SoundEffect.SOUND_SOUL_PICKUP)
					pickup:Remove()
					return true
				end
			end
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, EclipsedMod.onItemCollision2, PickupVariant.PICKUP_COLLECTIBLE)

function EclipsedMod:onHeartCollision2(pickup, collider, _)
	--- unbidden collision with hearts, if he has bone hearts
	if collider:ToPlayer() and collider:ToPlayer():GetPlayerType() == EclipsedMod.Characters.Unbidden and (pickup.SubType == 1 or pickup.SubType == 2 or pickup.SubType == 5 or pickup.SubType == 9 or pickup.SubType == 10 or pickup.SubType == 12) then
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
EclipsedMod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, EclipsedMod.onHeartCollision2, PickupVariant.PICKUP_HEART)

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
function EclipsedMod:onPlayerRender(player) --renderOffset
	--- render abihu and unbidden charge bar
	local data = player:GetData()
	--local isAlive = (player:GetHearts() ~= 0 or player:GetSoulHearts() ~= 0)
	if Options.ChargeBars and not player:IsDead() then
		if player:GetPlayerType() == EclipsedMod.Characters.Oblivious and (data.UnbiddenFullCharge or data.UnbiddenSemiCharge) and data.BlindUnbidden and not data.HoldingWeapon then -- and not data.TechLudo
			RenderChargeManager(player, data.ObliviousDamageDelay, EclipsedMod.ObliviousData.ChargeBar, EclipsedMod.ObliviousData.DamageDelay)
		elseif player:GetPlayerType() == EclipsedMod.Characters.Abihu and (player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) or data.AbihuIgnites) then
			RenderChargeManager(player, data.AbihuDamageDelay, EclipsedMod.AbihuData.ChargeBar, EclipsedMod.AbihuData.DamageDelay)
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_PLAYER_RENDER, EclipsedMod.onPlayerRender)

function EclipsedMod:onPlayerTakeDamage(entity, _, flags) --entity, amount, flags, source, countdown
	--- abihu drops nadab when you take damage, so set holding to -1
	local player = entity:ToPlayer()
	if player:GetPlayerType() == EclipsedMod.Characters.Nadab and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) and (flags & DamageFlag.DAMAGE_FIRE == DamageFlag.DAMAGE_FIRE or flags & DamageFlag.DAMAGE_EXPLOSION == DamageFlag.DAMAGE_EXPLOSION or flags & DamageFlag.DAMAGE_TNT == DamageFlag.DAMAGE_TNT) then
		return false
	elseif player:GetPlayerType() == EclipsedMod.Characters.Abihu then
		if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) and (flags & DamageFlag.DAMAGE_FIRE == DamageFlag.DAMAGE_FIRE or flags & DamageFlag.DAMAGE_EXPLOSION == DamageFlag.DAMAGE_EXPLOSION or flags & DamageFlag.DAMAGE_TNT == DamageFlag.DAMAGE_TNT) then
			return false
		end
		local data = entity:GetData()
		data.AbihuIgnites = true
		if not data.AbihuCostumeEquipped then
			data.AbihuCostumeEquipped = true
			player:AddNullCostume(EclipsedMod.AbihuData.CostumeHead)
		end
		data.HoldBomd = -1
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, EclipsedMod.onPlayerTakeDamage, EntityType.ENTITY_PLAYER)

function EclipsedMod:onItemUse(_, _, player) --item, rng, player, useFlag, activeSlot, customVarData
	--- abihu drops nadab when you use item, so set holding to -1
	if player:GetPlayerType() == EclipsedMod.Characters.Abihu then
		local data = player:GetData()
		data.HoldBomd = -1
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_USE_ITEM, EclipsedMod.onItemUse)

--- WIP
function EclipsedMod:onAbihuFlame(flame)
	if flame:GetData().AbihuFlame and flame.Parent then
		local flameData = flame:GetData()
		local player = flame.Parent:ToPlayer()
		local tearFlags = player.TearFlags

		if flame.FrameCount == 1 then
			if tearFlags & TearFlags.TEAR_BURN == TearFlags.TEAR_BURN or player:HasCollectible(CollectibleType.COLLECTIBLE_FIRE_MIND) then
				flame.Color = Color(-1,-1,-1,1,1,1,1)
				flameData.Burn = flameData.Burn or true
			end
			if tearFlags & TearFlags.TEAR_POISON == TearFlags.TEAR_POISON or player:HasCollectible(CollectibleType.COLLECTIBLE_COMMON_COLD) or player:HasCollectible(CollectibleType.COLLECTIBLE_IPECAC) or player:HasCollectible(CollectibleType.COLLECTIBLE_COMMON_COLD) then
				flame.Color = Color(0, 1, 0, 1, 0,1,0)
				flameData.Poison = flameData.Poison or true
			end
			if tearFlags & TearFlags.TEAR_SLOW == TearFlags.TEAR_SLOW or player:HasCollectible(CollectibleType.COLLECTIBLE_SPIDER_BITE) then
				flame.Color = Color(1,1,1,1,0.5,0.5,0.5)
				flameData.Slow = flameData.Slow or Color(2,2,2,1,0.196,0.196,0.196)
			elseif player:HasCollectible(CollectibleType.COLLECTIBLE_BALL_OF_TAR) then
				--flame.Color = Color(-1,-1,-1,1,1,1,1)
				flameData.Slow = flameData.Slow or Color(0.15, 0.15, 0.15, 1, 0, 0, 0)
			end
			if tearFlags & TearFlags.TEAR_MIDAS == TearFlags.TEAR_MIDAS or player:HasCollectible(CollectibleType.COLLECTIBLE_MIDAS_TOUCH) then
				flame.Color = Color(2, 1, 0, 1, 2,1,0)
				flameData.Midas = flameData.Midas or true
			end
			if tearFlags & TearFlags.TEAR_FEAR == TearFlags.TEAR_FEAR or player:HasCollectible(CollectibleType.COLLECTIBLE_ABADDON) or player:HasCollectible(CollectibleType.COLLECTIBLE_DARK_MATTER) or player:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_PERFUME) then
				flame.Color = Color(-10, -10, -10, 1, 1, 1, 1)
				flameData.Fear = flameData.Fear or true
			end
			if tearFlags & TearFlags.TEAR_CHARM == TearFlags.TEAR_CHARM or player:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_EYESHADOW) then
				flame.Color = Color(0.4, 0.15, 0.38, 1, 1, 0.1, 0.3)
				flameData.Charm = flameData.Charm or true
			end
			if tearFlags & TearFlags.TEAR_CONFUSION == TearFlags.TEAR_CONFUSION  or player:HasCollectible(CollectibleType.COLLECTIBLE_IRON_BAR) or player:HasCollectible(CollectibleType.COLLECTIBLE_GLAUCOMA) or player:HasCollectible(CollectibleType.COLLECTIBLE_KNOCKOUT_DROPS) then
				
				flameData.Confusion = flameData.Confusion or true
			end
			if tearFlags & TearFlags.TEAR_FREEZE == TearFlags.TEAR_FREEZE or player:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_CONTACTS) then
				flame.Color = Color(0, 0, 0, 1, 0.5, 0.5, 0.5)
				flameData.Freeze = flameData.Freeze or true
			end
			if tearFlags & TearFlags.TEAR_ICE == TearFlags.TEAR_ICE or player:HasCollectible(CollectibleType.COLLECTIBLE_URANUS) then
				flame.Color = Color(1, 1, 1, 1, 0, 0, 0)
				flameData.Ice = flameData.Ice or true
			end
			if tearFlags & TearFlags.TEAR_BAIT == TearFlags.TEAR_BAIT or player:HasCollectible(CollectibleType.COLLECTIBLE_ROTTEN_TOMATO) then
				flame.Color = Color(0.7, 0.14, 0.1, 1, 1, 0, 0)
				flameData.Baited = flameData.Baited or true
			end
			if tearFlags & TearFlags.TEAR_MAGNETIZE == TearFlags.TEAR_MAGNETIZE or player:HasCollectible(CollectibleType.COLLECTIBLE_LODESTONE) then
				flameData.Magnetize = flameData.Magnetize or true
			end
			if tearFlags & TearFlags.TEAR_RIFT == TearFlags.TEAR_RIFT or player:HasCollectible(CollectibleType.COLLECTIBLE_OCULAR_RIFT) then
				flame.Color = Color(-2, -2, -2, 1, 1, 1, 1)
				flameData.Rift = flameData.Rift or true
			end

			--[[
			if tearFlags & TearFlags.TEAR_BOOMERANG == TearFlags.TEAR_BOOMERANG then
				flameData.Boomerang = flameData.Boomerang or true
			end
			if tearFlags & TearFlags.TEAR_MULLIGAN == TearFlags.TEAR_MULLIGAN then
				flameData.Mulligan = flameData.Mulligan or true
			end
			if tearFlags & TearFlags.TEAR_WAIT == TearFlags.TEAR_WAIT then
				flameData.Wait = flameData.Wait or true
			end
			if tearFlags & TearFlags.TEAR_SPLIT == TearFlags.TEAR_SPLIT then
				flame.Color = Color(0.9, 0.3, 0.08, 1)
				flameData.Split = flameData.Split or true
			end
			if tearFlags & TearFlags.TEAR_QUADSPLIT == TearFlags.TEAR_QUADSPLIT then
				flameData.Quadsplit = flameData.Quadsplit or true
			end
			if tearFlags & TearFlags.TEAR_SPECTRAL == TearFlags.TEAR_SPECTRAL then
				flameData.Spectral = flameData.Spectral or true
			end
			--]]
			if tearFlags & TearFlags.TEAR_HOMING == TearFlags.TEAR_HOMING then
				flame.Color = Color(0.4, 0.15, 0.38, 1, 1, 0.1, 1)
				flameData.Homing = flameData.Homing or true
			end
		end
		if flameData.Homing then
			local nearestNPC = GetNearestEnemy(flame.Position, 120)
			flame:AddVelocity((nearestNPC - flame.Position):Resized(1.3))
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, EclipsedMod.onAbihuFlame, EffectVariant.BLUE_FLAME)

function EclipsedMod:onAbihuFlameDamage(entity, _, _, source, _)
	if entity:IsVulnerableEnemy() and entity:IsActiveEnemy() and source.Entity and source.Entity:ToEffect() then
		local flame = source.Entity:ToEffect()
		if flame.Variant == EffectVariant.BLUE_FLAME and flame:GetData().AbihuFlame then
			local ppl = flame.Parent:ToPlayer()
			local flameData = flame:GetData()
			local duration = 52
			if flameData.Burn then entity:AddBurn(EntityRef(ppl), duration, 2*ppl.Damage) end
			if flameData.Poison then entity:AddPoison(EntityRef(ppl), duration, 2*ppl.Damage) end
			if flameData.Charm then entity:AddCharmed(EntityRef(ppl), duration) end
			if flameData.Freeze then entity:AddFreeze(EntityRef(ppl), duration) end
			if flameData.Slow then entity:AddSlowing(EntityRef(ppl), duration, 0.5, flameData.Slow) end
			if flameData.Midas then entity:AddMidasFreeze(EntityRef(ppl), duration) end
			if flameData.Confusion then entity:AddConfusion(EntityRef(ppl), duration, false) end
			if flameData.Fear then entity:AddFear(EntityRef(ppl), duration) end
			if flameData.Rift then
				flameData.Rift = false
				local rift = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.RIFT, 0, entity.Position, Vector.Zero, ppl):ToEffect()
				rift:SetTimeout(60)
			end
			if flameData.Magnetize then
				entity:AddEntityFlags(EntityFlag.FLAG_MAGNETIZED)
				entity:GetData().Magnetized = duration
			end
			if flameData.Baited then
				entity:AddEntityFlags(EntityFlag.FLAG_BAITED)
				entity:GetData().BaitedTomato = duration
			end
			if entity:HasMortalDamage() then
				if flameData.Ice then entity:AddEntityFlags(EntityFlag.FLAG_ICE) end
			end
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, EclipsedMod.onAbihuFlameDamage)
--- WIP

--[[
function EclipsedMod:onTestEffect(effect)
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, EclipsedMod.onTestEffect, EffectVariant.BLUE_FLAME)
--]]

--[[
function EclipsedMod:onRender()
	if debug then
		Isaac.RenderText(renderText, 50, 30, 1, 1, 1, 255)
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_RENDER, EclipsedMod.onRender)
--]]


--[[
do
EclipsedMod.UnlockText = {}
EclipsedMod.UnlockText.Nadab = {"Unlocked Compo Bombs","Unlocked Gravity Bombs", -- 1:Isaac 2:BlueBaby
                        "Unlocked Glass Bombs","Unlocked Ice Cube Bombs", -- 3:Satan, 4:Lamb
                        "Unlocked Red Button","Unlocked Chess Kings", -- 5:BossRush, 6:Hush
                        "...","Unlocked Mongo Cells", -- 7:MegaSatan, 8:Delirium
                        "Unlocked Bob's Tongue","Unlocked Lil Gagger", -- 9:Mother, 10:Beast
                        "Unlocked Moonlighter","...", -- 11:Greed, 12:Heart
                        "...","Unlocked Charon's Obol"} -- 13:AllMarksHard, 14:Greedier
EclipsedMod.UnlockText.Abihu = {"Unlocked Red Scissors","...", -- 1:Isaac 2:BlueBaby
                        "...","...", -- 3:Satan, 4:Lamb
                        "Unlocked Soul of Nadab and Abihu","...", -- 5:BossRush, 6:Hush
                        "Unlocked Wax Hearts","Unlocked Nadab's Brain", -- 7:MegaSatan, 8:Delirium
                        "Unlocked Melted Candle","Unlocked Ivory Oil", -- 9:Mother, 10:Beast
                        "...","...",-- 11:Greed, 12:Heart
                        "Unlocked Eye Key","Unlocked Slay the Spire cards", -- 13:AllMarksHard, 14:Greedier
						true} -- tainted
EclipsedMod.UnlockText.Unbidden = {"Unlocked Karma Level","Unlocked VHS Cassette",-- 1:Isaac 2:BlueBaby
                        "Unlocked Long Elk","Unlocked Duckling", -- 3:Satan, 4:Lamb
                        "Unlocked Apocalypse Card","Unlocked Chess Knights", -- 5:BossRush, 6:Hush
                        "...","Unlocked Red Lotus", -- 7:MegaSatan, 8:Delirium
                        "Unlocked Red Mirror","Unlocked Limbus", -- 9:Mother, 10:Beast
                        "Unlocked Curse of the Midas","...",-- 11:Greed, 12:Heart
                        "...","Unlocked Lililith"} -- 13:AllMarksHard, 14:Greedier
EclipsedMod.UnlockText.Oblivious = {"Unlocked Witch Paper","...",-- 1:Isaac 2:BlueBaby
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
	else
		if game.Difficulty == Difficulty.DIFFICULTY_HARD or game.Difficulty == Difficulty.DIFFICULTY_GREEDIER then
			if markIndex == 11 then
				if completionTable[markIndex] < 1 then
					game:GetHUD():ShowFortuneText(textTable[14])
				else
					game:GetHUD():ShowFortuneText(textTable[markIndex], textTable[14])
				end
			else
				game:GetHUD():ShowFortuneText(textTable[markIndex])
			end
			completionTable[markIndex] = 2
		else
			game:GetHUD():ShowFortuneText(textTable[markIndex])
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
		game:GetHUD():ShowFortuneText(textTable[13])
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
		game:GetHUD():ShowFortuneText(textTable[13])
	end
end

function EclipsedMod:onPostPickupInit2(pickup)
	--- remove items from item pool (morphing time)
	local room = game:GetRoom()
	--1:Isaac, 2:BlueBaby, 3:Satan, 4:Lamb, 5:BossRush, 6:Hush, 7:MegaSatan, 8:Delirium, 9:Mother, 10:Beast, 11:Greed/Greedier, 12:Heart, 13:AllMarksHard
	--if (EclipsedMod.NadabData.CompletionMarks[13] < 2 or EclipsedMod.AbihuData.CompletionMarks[13] < 2 or EclipsedMod.UnbiddenData.CompletionMarks[13] < 2 or EclipsedMod.ObliviousData.CompletionMarks[13] < 2) then
	if savetable == {} then modDataLoad() end
	if (savetable.NadabCompletionMarks[13] < 2 or savetable.AbihuCompletionMarks[13] < 2 or savetable.UnbiddenCompletionMarks[13] < 2 or savetable.ObliviousCompletionMarks[13] < 2) then
		local newSub = pickup.SubType
		if pickup.Variant == PickupVariant.PICKUP_COLLECTIBLE then
			if (pickup.SubType == EclipsedMod.Items.CompoBombs and savetable.NadabCompletionMarks[1] == 0) or
					(pickup.SubType == EclipsedMod.Items.GravityBombs and savetable.NadabCompletionMarks[2] == 0) or
					(pickup.SubType == EclipsedMod.Items.MirrorBombs and savetable.NadabCompletionMarks[3] == 0) or
					(pickup.SubType == EclipsedMod.Items.FrostyBombs and savetable.NadabCompletionMarks[4] == 0) or
					(pickup.SubType == EclipsedMod.Items.RedButton and savetable.NadabCompletionMarks[5] == 0) or
					(pickup.SubType == EclipsedMod.Items.MongoCells and savetable.NadabCompletionMarks[8] == 0) or
					--(pickup.SubType == EclipsedMod.Items.lilGagger and savetable.NadabCompletionMarks[10] == 0) or
					(pickup.SubType == EclipsedMod.Items.KeeperMirror and savetable.NadabCompletionMarks[11] < 1) or
					(pickup.SubType == EclipsedMod.Items.CharonObol and savetable.NadabCompletionMarks[11] < 2) or

					(pickup.SubType == EclipsedMod.Items.NadabBrain and savetable.AbihuCompletionMarks[8] == 0) or
					(pickup.SubType == EclipsedMod.Items.MeltedCandle and savetable.AbihuCompletionMarks[9] == 0) or
					(pickup.SubType == EclipsedMod.Items.IvoryOil and savetable.AbihuCompletionMarks[10] == 0) or
					--((pickup.SubType == EclipsedMod.Items.EyeKeye or pickup.SubType == EclipsedMod.Items.EyeKeyeSleep) and savetable.AbihuCompletionMarks[13] == 0) or

					(pickup.SubType == EclipsedMod.Items.VoidKarma and savetable.UnbiddenCompletionMarks[1] == 0) or
					(pickup.SubType == EclipsedMod.Items.VHSCassette and savetable.UnbiddenCompletionMarks[2] == 0) or
					(pickup.SubType == EclipsedMod.Items.LongElk and savetable.UnbiddenCompletionMarks[3] == 0) or
					(pickup.SubType == EclipsedMod.Items.RubberDuck and savetable.UnbiddenCompletionMarks[4] == 0) or
					((pickup.SubType == EclipsedMod.Items.BlackKnight or pickup.SubType == EclipsedMod.Items.WhiteKnight) and savetable.UnbiddenCompletionMarks[6] == 0) or
					(pickup.SubType == EclipsedMod.Items.RedLotus and savetable.UnbiddenCompletionMarks[8] == 0) or
					(pickup.SubType == EclipsedMod.Items.RedMirror and savetable.UnbiddenCompletionMarks[9] == 0) or
					(pickup.SubType == EclipsedMod.Items.Limb and savetable.UnbiddenCompletionMarks[10] == 0) or
					(pickup.SubType == EclipsedMod.Items.MidasCurse and savetable.UnbiddenCompletionMarks[11] < 1) or
					(pickup.SubType == EclipsedMod.Items.Lililith and savetable.UnbiddenCompletionMarks[11] < 2) or

					--(pickup.SubType == EclipsedMod.Items.Eclipse and savetable.ObliviousCompletionMarks[8] == 0) or
					(pickup.SubType == EclipsedMod.Items.RedBag and savetable.ObliviousCompletionMarks[10] == 0) or
					((pickup.SubType == EclipsedMod.Items.FloppyDisk or pickup.SubType == EclipsedMod.Items.FloppyDiskFull) and savetable.ObliviousCompletionMarks[13] == 0) then
				local roomType = room:GetType()
				local seed = game:GetSeeds():GetStartSeed()
				local pool = itemPool:GetPoolForRoom(roomType, seed)
				if pool == ItemPoolType.POOL_NULL then
					pool = ItemPoolType.POOL_TREASURE
				end
				newSub = itemPool:GetCollectible(pool, true, pickup.InitSeed)
				--if newSub == pickup.SubType then newSub = 0 end
			elseif pickup.Variant == PickupVariant.PICKUP_TRINKET then
				if ((pickup.SubType == EclipsedMod.Trinkets.BobTongue + TrinketType.TRINKET_GOLDEN_FLAG or pickup.SubType == EclipsedMod.Trinkets.BobTongue) and savetable.NadabCompletionMarks[9] == 0) or
						((pickup.SubType == EclipsedMod.Trinkets.RedScissors + TrinketType.TRINKET_GOLDEN_FLAG or pickup.SubType == EclipsedMod.Trinkets.RedScissors) and
								savetable.AbihuCompletionMarks[1] == 0 and savetable.AbihuCompletionMarks[2] == 0 and savetable.AbihuCompletionMarks[3] == 0 and savetable.AbihuCompletionMarks[4] == 0) or
						((pickup.SubType == EclipsedMod.Trinkets.WitchPaper + TrinketType.TRINKET_GOLDEN_FLAG or pickup.SubType == EclipsedMod.Trinkets.WitchPaper) and
								savetable.ObliviousCompletionMarks[1] == 0 and savetable.ObliviousCompletionMarks[2] == 0 and savetable.ObliviousCompletionMarks[3] == 0 and savetable.ObliviousCompletionMarks[4] == 0) or
						((pickup.SubType == EclipsedMod.Trinkets.Duotine + TrinketType.TRINKET_GOLDEN_FLAG or pickup.SubType == EclipsedMod.Trinkets.Duotine) and savetable.ObliviousCompletionMarks[7] == 0) then
					newSub = itemPool:GetTrinket()
					--if newSub == pickup.SubType then newSub = 0 end
				end
			elseif pickup.Variant == PickupVariant.PICKUP_TAROTCARD then
				if ((pickup.SubType == EclipsedMod.Pickups.KingChess or pickup.SubType == EclipsedMod.Pickups.KingChessW) and savetable.NadabCompletionMarks[6] == 0) or
						(pickup.SubType == EclipsedMod.Pickups.SoulNadabAbihu and savetable.AbihuCompletionMarks[5] == 0 and savetable.AbihuCompletionMarks[6] == 0) or
						((pickup.SubType == EclipsedMod.Pickups.AscenderBane or pickup.SubType == EclipsedMod.Pickups.Adrenaline or pickup.SubType == EclipsedMod.Pickups.Fusion or
								pickup.SubType == EclipsedMod.Pickups.MultiCast or pickup.SubType == EclipsedMod.Pickups.InfiniteBlades or pickup.SubType == EclipsedMod.Pickups.RitualDagger or
								pickup.SubType == EclipsedMod.Pickups.Decay or pickup.SubType == EclipsedMod.Pickups.Corruption or pickup.SubType == EclipsedMod.Pickups.Wish or
								pickup.SubType == EclipsedMod.Pickups.DeuxEx or pickup.SubType == EclipsedMod.Pickups.Transmutation or pickup.SubType == EclipsedMod.Pickups.Offering) and savetable.AbihuCompletionMarks[11] < 2) or
						(pickup.SubType == EclipsedMod.Pickups.Apocalypse and savetable.UnbiddenCompletionMarks[5] == 0) or
						(pickup.SubType == EclipsedMod.Pickups.SoulUnbidden and savetable.ObliviousCompletionMarks[5] == 0 and savetable.ObliviousCompletionMarks[6] == 0) or
						((pickup.SubType == EclipsedMod.Pickups.RedPill or pickup.SubType == EclipsedMod.Pickups.RedPillHorse) and savetable.ObliviousCompletionMarks[7] == 0) or
						(pickup.SubType == EclipsedMod.Pickups.OblivionCard and savetable.ObliviousCompletionMarks[11] == 0) then
					newSub = itemPool:GetCard(pickup.InitSeed, false, true, true) -- Card.CARD_RULES
					--if newSub == pickup.SubType then newSub = 0 end
				end
				--[ wax hearts not implemented
				elseif pickup.Variant == PickupVariant.PICKUP_HEART then -- Wax Hearts
					if (pickup.SubType == EclipsedMod.Pickups.WaxHearts and savetable.AbihuCompletionMarks[7] == 0) then
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
EclipsedMod:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, EclipsedMod.onPostPickupInit2)

function EclipsedMod:onNPCDeath2(npc)
	--- chars completion marks on npc (boss) killing
	if game:GetVictoryLap() == 0 then
		if savetable == {} then modDataLoad() end
		for playerNum = 0, game:GetNumPlayers()-1 do
			local player = game:GetPlayer(playerNum)
			if player:GetPlayerType() == EclipsedMod.Characters.Nadab and savetable.NadabCompletionMarks[13] < 2 then
				CheckCompletionBossKill(savetable.NadabCompletionMarks, npc, EclipsedMod.UnlockText.Nadab)
			end
			if player:GetPlayerType() == EclipsedMod.Characters.Abihu and savetable.AbihuCompletionMarks[13] < 2 then
				CheckCompletionBossKill(savetable.AbihuCompletionMarks, npc, EclipsedMod.UnlockText.Abihu)
			end
			if player:GetPlayerType() == EclipsedMod.Characters.Unbidden and savetable.UnbiddenCompletionMarks[13] < 2 then
				CheckCompletionBossKill(savetable.UnbiddenCompletionMarks, npc, EclipsedMod.UnlockText.Unbidden)
			end
			if player:GetPlayerType() == EclipsedMod.Characters.Oblivious and savetable.ObliviousCompletionMarks[13] < 2 then
				CheckCompletionBossKill(savetable.ObliviousCompletionMarks, npc, EclipsedMod.UnlockText.Oblivious)
			end
		end
		modDataSave()
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, EclipsedMod.onNPCDeath2)

function EclipsedMod:onRoomClear2()
	--- chars completion marks on clearing rooms
	local room = game:GetRoom()
	if game:GetVictoryLap() == 0 and room:GetType() == RoomType.ROOM_BOSS then
		if savetable == {} then modDataLoad() end
		for playerNum = 0, game:GetNumPlayers()-1 do
			local player = game:GetPlayer(playerNum)
			if player:GetPlayerType() == EclipsedMod.Characters.Nadab and savetable.NadabCompletionMarks[13] < 2 then
				CheckCompletionRoomClear(savetable.NadabCompletionMarks, EclipsedMod.UnlockText.Nadab)
			end
			if player:GetPlayerType() == EclipsedMod.Characters.Abihu and savetable.AbihuCompletionMarks[13] < 2 then
				CheckCompletionRoomClear(savetable.AbihuCompletionMarks, EclipsedMod.UnlockText.Abihu)
			end
			if player:GetPlayerType() == EclipsedMod.Characters.Unbidden and savetable.UnbiddenCompletionMarks[13] < 2 then
				CheckCompletionRoomClear(savetable.UnbiddenCompletionMarks, EclipsedMod.UnlockText.Unbidden)
			end
			if player:GetPlayerType() == EclipsedMod.Characters.Oblivious and savetable.ObliviousCompletionMarks[13] < 2 then
				CheckCompletionRoomClear(savetable.ObliviousCompletionMarks, EclipsedMod.UnlockText.Oblivious)
			end
		end
		modDataSave()
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, EclipsedMod.onRoomClear2)
--]]


local function AddModCurse(curse)
	local level = game:GetLevel()
	if level:GetCurses() & curse > 0 then
		level:RemoveCurses(curse)
		print("eclipsed curse Disable")
	else
		level:AddCurse(curse, false)
		game:GetHUD():ShowFortuneText(EclipsedMod.CurseText[curse])
		print("eclipsed curse Enable")
	end
end

---EXECUTE COMMAND---
function EclipsedMod:onExecuteCommand(command, args)
	--- console commands ---
	if command == "eclipsed" then
		if args == "help" or args == "" then
			print('disabled unlocks and curses by default')
			print('eclipsed todo -> list of bugs and things to complete/implement/change')
			print('eclipsed curse [curse number | name] -> enable/disable mod curses')
			print('eclipsed curse -> list of curses')
			--print('eclipsed reset [all, nadab, abihu, unbid, tunbid]')
			--print('eclipsed unlock [all, nadab, abihu, unbid, tunbid]')
		elseif args == "todo" then
			print('pondara jar somehow broken')
			print("Torn Spades - may be bugged")
			print('Lil Gagger sprite')
			print("finish Wax Hearts and UI")
			print("finish curses UI")
			print("Abihu flame attack - not finished")
			print("Mongo Cells add full desc, indicator to familiars which can be copied")
			print("Domino 0|0 rework")
			print("dice bombs - bombcostumes")
			print("Glitched Beggar - logic and sprites")
			print("oblivious lasers + chocko milk damage up don't work")
			print("oblivious epic fetus + marked don't work")
			print("oblivious familiars aura attack - not implemented (fate rewards, incubus, splinker, twisted pair?)")
		elseif args == "debug" then
			if debug then
				debug = false
			else
				debug = true
			end
			print("eclipsed debug is "..(debug and "Enable" or "Disable"))
			print("!!! please Disable debug !!!")
		elseif args == "curse" then
			print('eclipsed curse [curse number or name] -> enable/disable mod curses')
			print("eclipsed curse [1 | void]")
			print("eclipsed curse [2 | jam | jamming]")
			print("eclipsed curse [3 | emperor]")
			print("eclipsed curse [4 | mage | magician]")
			print("eclipsed curse [5 | pride]")
			print("eclipsed curse [6 | bell]")
			print("eclipsed curse [7 | envy]")
			print("eclipsed curse [8 | carrion]")
			print("eclipsed curse [9 | bishop]")
			print("eclipsed curse [10 | montezuma | zuma]")
			print("eclipsed curse [11 | misfortune]")
			print("eclipsed curse [12 | poverty]")
			print("eclipsed curse [13 | fool]")
			print("eclipsed curse [14 | secret | secrets]")
			print("eclipsed curse [15 | warden]")
			print("eclipsed curse [16 | desolation | wisp]")
		elseif args == "curse 1" or args == "curse void" then
			AddModCurse(EclipsedMod.Curses.Void)
			print("Curse of the Void! - 16% chance to reroll enemies and grid upon entering room")
			print("eclipsed curse [1 | void]")
		elseif args == "curse 2" or args == "curse jam" or args == "curse jamming" then
			AddModCurse(EclipsedMod.Curses.Jamming)
			print("Curse of the Jamming! - 16% chance to respawn enemies after clearing room")
			print("eclipsed curse [2 | jam | jamming]")
		elseif args == "curse 3" or args == "curse emperor" then
			AddModCurse(EclipsedMod.Curses.Emperor)
			print("Curse of the Emperor! - remove exit door from boss room (similar to mom boss room)")
			print("eclipsed curse [3 | emperor]")
		elseif args == "curse 4" or args == "curse mage" or args == "curse magician" then
			AddModCurse(EclipsedMod.Curses.Magician)
			print("Curse of the Magician! - homing enemy tears (except boss)")
			print("eclipsed curse [4 | mage | magician]")
		elseif args == "curse 5" or args == "curse pride" then
			AddModCurse(EclipsedMod.Curses.Pride)
			print("Curse of the Pride! - 50% chance to enemies become champion (except boss)")
			print("eclipsed curse [5 | pride]")
		elseif args == "curse 6" or args == "curse bell" then
			AddModCurse(EclipsedMod.Curses.Bell)
			print("Curse of the Bell! - all troll bombs is golden")
			print("eclipsed curse [6 | bell]")
		elseif args == "curse 7" or args == "curse envy" then
			AddModCurse(EclipsedMod.Curses.Envy)
			print("Curse of the Envy! - other shop items disappear when you buy one [shop, black market, member card, devil deal, angel shop]")
			print("eclipsed curse [7 | envy]")
		elseif args == "curse 8" or args == "curse carrion" then
			AddModCurse(EclipsedMod.Curses.Carrion)
			print("Curse of Carrion! - turn normal poops into red")
			print("eclipsed curse [8 | carrion]")
		elseif args == "curse 9" or args == "curse bishop" then
			AddModCurse(EclipsedMod.Curses.Bishop)
			print("Curse of the Bishop! - 16% chance to prevent enemy from taking damage. enemy will flash blue")
			print("eclipsed curse [9 | bishop]")
		elseif args == "curse 10" or args == "curse zuma" or args == "curse montezuma" then
			AddModCurse(EclipsedMod.Curses.Montezuma)
			print("Curse of Montezuma! - slippery floor, works only in battles")
			print("eclipsed curse [10 | montezuma | zuma]")
		elseif args == "curse 11" or args == "curse misfortune" then
			AddModCurse(EclipsedMod.Curses.Misfortune)
			print("Curse of Misfortune! - -5 luck while curse is applyed")
			print("eclipsed curse [11 | misfortune]")
		elseif args == "curse 12" or args == "curse poverty" then
			AddModCurse(EclipsedMod.Curses.Poverty)
			print("Curse of Poverty! - greed enemy tears. drop your coins when enemy tear hit you")
			print("eclipsed curse [12 | poverty]")
		elseif args == "curse 13" or args == "curse fool" then
			AddModCurse(EclipsedMod.Curses.Fool)
			print("Curse of the Fool! - 16% chance to respawn enemies in cleared rooms (except boss room), don't close doors")
			print("eclipsed curse [13 | fool]")
		elseif args == "curse 14" or args == "curse secret" or args == "curse secrets" then
			AddModCurse(EclipsedMod.Curses.Secrets)
			print("Curse of Secrets! - hide secret/supersecret room doors")
			print("eclipsed curse [14 | secret | secrets]")
		elseif args == "curse 15" or args == "curse warden" then
			AddModCurse(EclipsedMod.Curses.Warden)
			print("Curse of the Warden! - all locked doors need 2 keys")
			print("Visual bug with door not applying chains on first door encounter. Door stil require 2 keys")
			print("eclipsed curse [15 | warden]")
		elseif args == "curse 16" or args == "curse wisp" or args == "curse desolation" then
			AddModCurse(EclipsedMod.Curses.Desolation)
			print("Curse of the Desolation! - 16% chance to turn item into Item Wisp when touched. Add wisped item on next floor")
			print("eclipsed curse [16 | desolation | wisp]")
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
EclipsedMod:AddCallback(ModCallbacks.MC_EXECUTE_CMD, EclipsedMod.onExecuteCommand)
---EXECUTE COMMAND---

-- bomb gagger
--EclipsedMod.Items.Gagger = Isaac.GetItemIdByName("Little Gagger")

--[[
EclipsedMod.Gagger = {}
EclipsedMod.Gagger.Variant = Isaac.GetEntityVariantByName("lilGagger") -- spawn giga bomb every 7 room
EclipsedMod.Gagger.GenAfterRoom = 7

--Gagger
function EclipsedMod:onGaggerInit(fam)
	fam:GetSprite():Play("FloatDown")
	fam:AddToFollowers()
end
EclipsedMod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, EclipsedMod.onGaggerInit, EclipsedMod.Gagger.Variant)
--Gagger loop update
function EclipsedMod:onGaggerUpdate(fam)
	local player = fam.Player -- get player
	local famData = fam:GetData() -- get fam data
	local famSprite = fam:GetSprite()
	CheckForParent(fam)
	fam:FollowParent()

	if fam.RoomClearCount >= EclipsedMod.Gagger.GenAfterRoom then
		fam.RoomClearCount = 0
		famSprite:Play("Spawn")
	end

	if famSprite:IsFinished("Spawn") then
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BOMB, BombSubType.BOMB_GIGA, fam.Position, Vector.Zero, fam)
		famSprite:Play("AfterSpawn")
	end

	if famSprite:IsFinished("AfterSpawn") then
		famSprite:Play("FloatDown") --"AfterSpawn"
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, EclipsedMod.onGaggerUpdate, EclipsedMod.Gagger.Variant)

function EclipsedMod:onCache3(player, cacheFlag)
	player = player:ToPlayer()
	-- bombgagger
	if cacheFlag == CacheFlag.CACHE_FAMILIARS then
		local gaggers = GetItemsCount(player, EclipsedMod.Items.Gagger)
		player:CheckFamiliar(EclipsedMod.Gagger.Variant, gaggers, RNG(), Isaac.GetItemConfig():GetCollectible(EclipsedMod.Items.Gagger))
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, EclipsedMod.onCache3)
--]]

--[[
EclipsedMod.Slots.GlitchBeggar = Isaac.GetEntityVariantByName("Glitch Beggar")
EclipsedMod.GlitchBeggar = {}
EclipsedMod.GlitchBeggar.ReplaceChance = 0.01
EclipsedMod.GlitchBeggar.PityCounter = 10
EclipsedMod.GlitchBeggar.ActivateChance = 0.05
EclipsedMod.GlitchBeggar.PickupRotateTimeout = 300

EclipsedMod.GlitchBeggar.RandomPickup = {
	"Idle", --IdleCoin
	"IdleBomb",
	"IdleKey",
	"IdleHeart"
}
EclipsedMod.GlitchBeggar.RandomPickupCheck = {
	["Idle"] = true, --IdleCoin
	["IdleBomb"] = true,
	["IdleKey"] = true,
	["IdleHeart"] = true
}
--]]
--[[
local function GlitchBeggarState(beggarData, sprite, rng)
	sfx:Play(SoundEffect.SOUND_SCAMPER)
	if beggarData.PityCounter >= EclipsedMod.GlitchBeggar.PityCounter or rng:RandomFloat() < EclipsedMod.GlitchBeggar.ActivateChance then
		sprite:Play("PayPrize")
	else
		sprite:Play("PayNothing")
		beggarData.PityCounter = beggarData.PityCounter + 1
	end
end
--]]
--- SLOT / BEGGARS SPAWN--
function EclipsedMod:onEntSpawn(entType, var, _, _, _, _, seed)
	if entType == EntityType.ENTITY_SLOT and var == 4 then --EclipsedMod.ReplaceBeggarVariants[var] then
		--if myrng:RandomFloat() <= EclipsedMod.GlitchBeggar.ReplaceChance then
		--	return {entType, EclipsedMod.Slots.GlitchBeggar, 0, seed}
		--else
		if myrng:RandomFloat() <= EclipsedMod.DeliriumBeggar.ReplaceChance then
			return {entType, EclipsedMod.Slots.DeliriumBeggar, 0, seed}
		elseif myrng:RandomFloat() <= EclipsedMod.MongoBeggar.ReplaceChance then
			return {entType, EclipsedMod.Slots.MongoBeggar, 0, seed}
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_PRE_ENTITY_SPAWN, EclipsedMod.onEntSpawn)

--- SLOT / BEGGARS LOGIC --
function EclipsedMod:peffectUpdateBeggars(player)
	local level = game:GetLevel()
	local mongoBeggars = Isaac.FindByType(EntityType.ENTITY_SLOT, EclipsedMod.Slots.MongoBeggar)
	--local glitchBeggars = Isaac.FindByType(EntityType.ENTITY_SLOT, EclipsedMod.Slots.GlitchBeggar)
	local deliriumBeggars = Isaac.FindByType(EntityType.ENTITY_SLOT, EclipsedMod.Slots.DeliriumBeggar)

	--[[
	if #glitchBeggars > 0 then
		for _, beggar in pairs(glitchBeggars) do
			local sprite = beggar:GetSprite()
			local rng = beggar:GetDropRNG()
			local beggarData = beggar:GetData()

			beggarData.PickupRotateTimeout = beggarData.PickupRotateTimeout or EclipsedMod.GlitchBeggar.PickupRotateTimeout --0
			beggarData.PityCounter = beggarData.PityCounter or 0

			if EclipsedMod.GlitchBeggar.RandomPickupCheck[sprite:GetAnimation()] then
				beggarData.PickupRotateTimeout = beggarData.PickupRotateTimeout + 1
				if beggarData.PickupRotateTimeout >= EclipsedMod.GlitchBeggar.PickupRotateTimeout then
					sprite:Play("ChangePickup")
					beggarData.PickupRotateTimeout = 0
				end
			end

			if sprite:IsFinished("PayNothing") or sprite:IsFinished("ChangePickup") then
				local randNum = rng:RandomInt(#EclipsedMod.GlitchBeggar.RandomPickup)+1
				sprite:Play(EclipsedMod.GlitchBeggar.RandomPickup[randNum])
			end
			if sprite:IsFinished("PayPrize") then sprite:Play("Prize") end

			if sprite:IsFinished("Prize") then
				local pos = Isaac.GetFreeNearPosition(beggar.Position, 35)
				sprite:Play("Teleport")
				player:AddCollectible(CollectibleType.COLLECTIBLE_TMTRAINER)
				DebugSpawn(100, 0, pos)
				player:RemoveCollectible(CollectibleType.COLLECTIBLE_TMTRAINER) -- remove tmtrainer
				level:SetStateFlag(LevelStateFlag.STATE_BUM_LEFT, true)
			end

			if sprite:IsFinished("Teleport") then
				beggar:Remove()
			else
				if beggar.Position:Distance(player.Position) <= 20 then --(beggar.Position - player.Position):Length() <= 20 then
					if sprite:IsPlaying("Idle") then
						if player:GetNumCoins() > 0 then
							player:AddCoins(-1)
							GlitchBeggarState(beggarData, sprite, rng)
						end
					elseif sprite:IsPlaying("IdleBomb") then
						if player:GetNumBombs() > 0 then
							player:AddBombs(-1)
							GlitchBeggarState(beggarData, sprite, rng)
						end
					elseif sprite:IsPlaying("IdleKey") then
						if player:GetNumKeys() > 0 then
							player:AddKeys(-1)
							GlitchBeggarState(beggarData, sprite, rng)
						end
					elseif sprite:IsPlaying("IdleHeart") then
						player:TakeDamage(1, DamageFlag.DAMAGE_NO_PENALTIES | DamageFlag.DAMAGE_IV_BAG, EntityRef(player), 1)
						GlitchBeggarState(beggarData, sprite, rng)
					end
				end
				BeggarWasBombed(beggar)
			end
		end
	end
	--]]
	if #deliriumBeggars > 0 then
		for _, beggar in pairs(deliriumBeggars) do
			local sprite = beggar:GetSprite()
			local rng = beggar:GetDropRNG()
			local randNum = rng:RandomFloat()
			local beggarData = beggar:GetData()
			beggar.SplatColor = Color(2,2,2,1,5,5,5)
			beggarData.PityCounter = beggarData.PityCounter or 0

			if sprite:IsFinished("PayNothing") then sprite:Play("Idle")	end
			if sprite:IsFinished("PayPrize") then sprite:Play("Prize") end

			if sprite:IsFinished("Prize") then
				sfx:Play(SoundEffect.SOUND_SLOTSPAWN)
				local spawnpos = Isaac.GetFreeNearPosition(beggar.Position, 35)
				--print(randNum)
				if randNum <= EclipsedMod.MongoBeggar.PrizeChance then --Spawn item
					sprite:Play("Teleport")
					EclipsedMod.DeliriousBumCharm = player
					player:UseActiveItem(CollectibleType.COLLECTIBLE_DELIRIOUS, myUseFlags)
					level:SetStateFlag(LevelStateFlag.STATE_BUM_LEFT, true)
				else
					sprite:Play("Idle")
					if randNum <= EclipsedMod.DeliriumBeggar.DeliPickupChance then
						--DebugSpawn(300, EclipsedMod.Pickups.BannedCard, spawnpos)
						DebugSpawn(300, EclipsedMod.DeliObject.Variants[rng:RandomInt(#EclipsedMod.DeliObject.Variants)+1], spawnpos)
					else
						EclipsedMod.DeliriumBeggar.Enemies = EclipsedMod.DeliriumBeggar.Enemies or {EntityType.ENTITY_GAPER, 0}
						local savedOnes = EclipsedMod.DeliriumBeggar.Enemies[rng:RandomInt(#EclipsedMod.DeliriumBeggar.Enemies)+1]
						local npc = Isaac.Spawn(savedOnes[1], savedOnes[2], 0, spawnpos, Vector.Zero, player):ToNPC()
						--npc:AddEntityFlags(EntityFlag.FLAG_FRIENDLY | EntityFlag.FLAG_CHARM | EntityFlag.FLAG_PERSISTENT)
						npc:AddCharmed(EntityRef(player), -1)
						--EclipsedMod.DeliriumBeggar.Enable[tostring(npc.Type..npc.Variant)] = true
					end
				end
			end

			if sprite:IsFinished("Teleport") then
				beggar:Remove()
			else
				if beggar.Position:Distance(player.Position) <= 20 then --(beggar.Position - player.Position):Length() <= 20 then -- 20 distance where you definitely touch beggar
					if sprite:IsPlaying("Idle") and player:GetNumCoins() > 0 then
						player:AddCoins(-1)
						sfx:Play(SoundEffect.SOUND_SCAMPER)
						if beggarData.PityCounter >= EclipsedMod.DeliriumBeggar.PityCounter or rng:RandomFloat() < EclipsedMod.DeliriumBeggar.ActivateChance then --randNum == 0 then
							sprite:Play("PayPrize")
							beggarData.PityCounter = 0
						else
							sprite:Play("PayNothing")
							beggarData.PityCounter = beggarData.PityCounter + 1
						end
					end
				end
				if BeggarWasBombed(beggar, true) then
					game:ShowHallucination(5, BackdropType.NUM_BACKDROPS)
					beggar:Remove()
					DebugSpawn(300, EclipsedMod.DeliObject.Variants[rng:RandomInt(#EclipsedMod.DeliObject.Variants)+1], beggar.Position, 0, RandomVector()*5)
				end
			end
		end
	end
	if #mongoBeggars > 0 then
		for _, beggar in pairs(mongoBeggars) do
			local sprite = beggar:GetSprite()
			local rng = beggar:GetDropRNG()
			local randNum = rng:RandomFloat()
			local beggarData = beggar:GetData()

			beggarData.PityCounter = beggarData.PityCounter or 0
			beggarData.PrizeCounter = beggarData.PrizeCounter or 0

			if sprite:IsFinished("PayNothing") then sprite:Play("Idle")	end
			if sprite:IsFinished("PayPrize") then sprite:Play("Prize") end

			if sprite:IsFinished("Prize") then
				sfx:Play(SoundEffect.SOUND_SLOTSPAWN)

				if randNum <= EclipsedMod.MongoBeggar.PrizeChance then --Spawn item
					local spawnpos = Isaac.GetFreeNearPosition(beggar.Position, 35)
					sprite:Play("Teleport")
					DebugSpawn(100, CollectibleType.COLLECTIBLE_MONGO_BABY, spawnpos)
					level:SetStateFlag(LevelStateFlag.STATE_BUM_LEFT, true)

				else -- from all cards

					player:UseActiveItem(CollectibleType.COLLECTIBLE_MONSTER_MANUAL, myUseFlags)
					if sfx:IsPlaying(SoundEffect.SOUND_SATAN_GROW) then sfx:Stop(SoundEffect.SOUND_SATAN_GROW) end -- devil laughs

					sprite:Play("Idle")
					--sfx:Play(SoundEffect.SOUND_SLOTSPAWN)
					beggarData.PrizeCounter = beggarData.PrizeCounter + 1
					if beggarData.PrizeCounter >= EclipsedMod.MongoBeggar.PrizeCounter then
						sprite:Play("Teleport")
						level:SetStateFlag(LevelStateFlag.STATE_BUM_LEFT, true)
					else
						sprite:Play("Idle")
					end
				end
			end

			if sprite:IsFinished("Teleport") then
				beggar:Remove()
			else
				if beggar.Position:Distance(player.Position) <= 20 then --(beggar.Position - player.Position):Length() <= 20 then -- 20 distance where you definitely touch beggar
					if sprite:IsPlaying("Idle") and player:GetNumCoins() > 0 then
						player:AddCoins(-1)
						sfx:Play(SoundEffect.SOUND_SCAMPER)
						if beggarData.PityCounter >= EclipsedMod.MongoBeggar.PityCounter or rng:RandomFloat() < EclipsedMod.MongoBeggar.ActivateChance then --randNum == 0 then
							sprite:Play("PayPrize")
							beggarData.PityCounter = 0
						else
							sprite:Play("PayNothing")
							beggarData.PityCounter = beggarData.PityCounter + 1
						end
					end
				end
				BeggarWasBombed(beggar)
			end
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, EclipsedMod.peffectUpdateBeggars)


--[[
EclipsedMod.WaxHearts = {}
EclipsedMod.WaxHearts.SubType = 5757 -- wax heart subtype from entities2.xml
EclipsedMod.WaxHearts.Range = 90
EclipsedMod.WaxHearts.ReplaceChance = 0.05 -- chance to replace full and soul hearts
EclipsedMod.WaxHearts.HeartsUI = Sprite()
EclipsedMod.WaxHearts.HeartsUI:Load("gfx/ui/oc_ui_hearts.anm2", true)

function EclipsedMod:onPlayerTakeDamage(entity, _, flags) --entity, amount, flags, source, countdown
	--- wax hearts damage logic
	local player = entity:ToPlayer()
	local data = player:GetData()

	if data.WaxHeartsCount then
		if data.WaxHeartsCount > 0 then
			if (flags & DamageFlag.DAMAGE_FIRE ~= 0) or (flags & DamageFlag.DAMAGE_EXPLOSION ~= 0) then
				return false
			else
				data.WaxHeartsCount = data.WaxHeartsCount - 1
				local enemies = Isaac.FindInRadius(player.Position, EclipsedMod.WaxHearts.Range, EntityPartition.ENEMY)
				if #enemies > 0 then
					for _, enemy in pairs(enemies) do
						if enemy:IsVulnerableEnemy() and enemy:IsActiveEnemy() then
							enemy:AddFreeze(EntityRef(player), EclipsedMod.MeltedCandle.FrameCount) --has a chance to not apply (bosses for example), that's why must check it
							if enemy:HasEntityFlags(EntityFlag.FLAG_FREEZE) then
								enemy:AddEntityFlags(EntityFlag.FLAG_BURN)
								enemy:GetData().Waxed = EclipsedMod.MeltedCandle.FrameCount
								enemy:SetColor(EclipsedMod.MeltedCandle.TearColor, EclipsedMod.MeltedCandle.FrameCount, 100, false, false)
							end
						end
					end
				end
			end
		else
			data.WaxHeartsCount = nil
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, EclipsedMod.onPlayerTakeDamage, EntityType.ENTITY_PLAYER)

function EclipsedMod:onPostWaxHeartInit(pickup)
	local rng = pickup:GetDropRNG()
	if pickup.SubType == HeartSubType.HEART_FULL or pickup.SubType == HeartSubType.HEART_SOUL then
		if rng:RandomFloat() <= EclipsedMod.WaxHearts.ReplaceChance then
			pickup:Morph(pickup.Type, pickup.Variant, EclipsedMod.WaxHearts.SubType)
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, EclipsedMod.onPostWaxHeartInit, PickupVariant.PICKUP_HEART)

function EclipsedMod:onWaxHeartCollision(pickup, collider) --pickup, collider, low
	if pickup.SubType == EclipsedMod.WaxHearts.SubType and collider:ToPlayer() then
		local player = collider:ToPlayer()
		local data = player:GetData()
		data.WaxHeartsCount = data.WaxHeartsCount or 0
		if data.WaxHeartsCount < 12 then
			pickup:GetSprite():Play("Collect", true)
			pickup:Die()
			data.WaxHeartsCount = data.WaxHeartsCount + 1
			sfx:Play(SoundEffect.SOUND_SOUL_PICKUP)
		end
	end
end
EclipsedMod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, EclipsedMod.onWaxHeartCollision, PickupVariant.PICKUP_HEART)


function EclipsedMod:onRenderWaxHeart() --pickup, collider, low
	--for playerNum = 0, game:GetNumPlayers()-1 do
	--local player = Isaac.GetPlayer(playerNum)
	local player = Isaac.GetPlayer(0)
	local data = player:GetData()
	local level = game:GetLevel()
	if level:GetCurses() & LevelCurse.CURSE_OF_THE_UNKNOWN == 0 and data.WaxHeartsCount and data.WaxHeartsCount > 0 then
		--local pos = Vector(Isaac.GetScreenWidth(),Isaac.GetScreenHeight()) - Vector(10, 12) - (Options.HUDOffset*Vector(16, 6))
		local pos = Vector.Zero + Vector(68, 23) + (Options.HUDOffset*Vector(16, 6))
		--Vector(68, 23)
		EclipsedMod.WaxHearts.HeartsUI:Play(data.WaxHeartsCount, true)
		EclipsedMod.WaxHearts.HeartsUI:Render(pos)
		EclipsedMod.WaxHearts.HeartsUI:Update()
	end
	--end
end
EclipsedMod:AddCallback(ModCallbacks.MC_POST_RENDER, EclipsedMod.onRenderWaxHeart)
--]]
