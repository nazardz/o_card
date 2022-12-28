
	local Wiki = {
		Unbidden = {
			{ -- Start Data
				{str = "Start Data", fsize = 2, clr = 3, halign = 0},
				{str = "Stats", clr = 3, halign = 0},
				{str = "HP: 1 Soul Heart"},
				{str = "Speed: 1.00"},
				{str = "Tears: 2.73"},
				{str = "Damage: 4.72"},
				{str = "Range: 6.50"},
				{str = "Shotspeed: 1.00"},
				{str = "Luck: -1"},
			},
			{ -- Traits
				{str = "Traits", fsize = 2, clr = 3, halign = 0},
				{str = "Unbidden can't pick items. Instead turn them into Item Wisps."},
				{str = "Item Wisps will turn into actual items at the start of next stage."},
				{str = "Heart containers will be turned into soul hearts."},
				{str = "When Unbidden dies, time is rewound and 1 broken heart is added."},
				{str = "If you try to pick devil deal item while you don't have required health, gain 1 broken heart and half soul heart."},
			},
			{ -- Birthright
				{str = "Birthright", fsize = 2, clr = 3, halign = 0},
				{str = "Turn all broken hearts into soul hearts."},
				{str = "Get all items from Item Wisps, without removing wisps."},
			},
			{ -- Trivia
				{str = "Trivia", fsize = 2, clr = 3, halign = 0},
				{str = "The tears came suddenly and unbidden."},
			},
		},
		
		Oblivious = {
			{ -- Start Data
				{str = "Start Data", fsize = 2, clr = 3, halign = 0},
				{str = "Items:"},
				{str = "Threshold"},
				{str = "Stats:"},
				{str = "HP: ???"},
				{str = "Speed: 1.00"},
				{str = "Tears: 2.73"},
				{str = "Damage: 3.50"},
				{str = "Range: 6.50"},
				{str = "Shotspeed: 1.00"},
				{str = "Luck: -3"},
				{str = "Can Fly"},
			},
			{ -- Traits
				{str = "Traits", fsize = 2, clr = 3, halign = 0},
				{str = "Unbidden can't pick items. Instead turn them into Item Wisps."},
				{str = "To obtain actual items, use Threshold."},
				{str = "When Unbidden dies, time is rewound and Threshold is discharged."},
				{str = "Unbidden can't shoot, but deals AoE damage to all enemies within the aura."},
				{str = "This aura's stats based on Unbidden's stats: range, shotspeed, damage, firedelay and tear effects."},
				{str = "All curses is always active, except Curse of the Labyrinth, but it's still can be applied by game."},
			},
			{ -- Threshold
				{str = "Threshold", fsize = 2, clr = 3, halign = 0},
				{str = "Threshold is Unbidden's pocket active item."},
				{str = "It turns Item Wisp into actual item."},
			},
			{ -- Birthright
				{str = "Birthright", fsize = 2, clr = 3, halign = 0},
				{str = "Remove and prevent all curses."},
				{str = "No longer discharges Threshold after death."},
			},
			{ -- Trivia
				{str = "Trivia", fsize = 2, clr = 3, halign = 0},
				{str = "The state of being unconscious or lacking awareness of what is happening around you."},
			},
		},
		
		FloppyDisk = {
			{ -- Effect
				{str = "Effect", fsize = 2, clr = 3, halign = 0},
				{str = "Save all your current items"},
				{str = "If you already have saved items, replace your current items by saved ones."},
				{str = "Gives Missing No for each missing saved item."},
			},
			{ -- Notes
				{str = "Notes", fsize = 2, clr = 3, halign = 0},
				{str = "Missing No. will be given only if you saved 'MOD' items and then disabled said 'MOD'"},
				{str = "OR"},
				{str = "It can give different items than saved ones if items order was shifted (by other mods)"},
			},
		},
		RedMirror = {
			{ -- Effect
				{str = "Effect", fsize = 2, clr = 3, halign = 0},
				{str = "Turn nearest trinket into cracked key"},
			},
		},
		RedLotus = {
			{ -- Effect
				{str = "Effect", fsize = 2, clr = 3, halign = 0},
				{str = "Trigger at the start of stage"},
				{str = "Remove 1 broken heart and give +1 flat damage up"},
			},
			{ -- Notes
				{str = "Notes", fsize = 2, clr = 3, halign = 0},
				{str = "Give +X flat damage up for each Red Lotus item"},
			},
		}
		
	}


	Encyclopedia.AddCharacter({
		ModName = "Eclipsed",
		Name = "Unbidden",
		WikiDesc = Wiki.Unbidden,
		ID = EclipsedMod.Characters.Unbidden,
		
	})
	Encyclopedia.AddCharacterTainted({
		ModName = "Eclipsed",
		Name = "Unbidden",
		Description = "The Oblivious",
		WikiDesc = Wiki.Oblivious,
		ID = EclipsedMod.Characters.Oblivious,
		
	})

	
	Encyclopedia.AddItem({
		ModName = "Eclipsed",
		Class = "Eclipsed",
		ID = EclipsedMod.Items.FloppyDisk,
		WikiDesc = Wiki.FloppyDisk,
		Pools = {
			Encyclopedia.ItemPools.POOL_ULTRA_SECRET,
		},
	})
	Encyclopedia.AddItem({
		ModName = "Eclipsed",
		Class = "Eclipsed",
		ID = EclipsedMod.Items.RedMirror,
		WikiDesc = Wiki.RedMirror,
		Pools = {
			Encyclopedia.ItemPools.POOL_TREASURE,
			Encyclopedia.ItemPools.POOL_GREED_SHOP,
			Encyclopedia.ItemPools.POOL_ULTRA_SECRET,
		},
	})
	Encyclopedia.AddItem({
		ModName = "Eclipsed",
		Class = "Eclipsed",
		ID = EclipsedMod.Items.RedLotus,
		WikiDesc = Wiki.RedLotus,
		Pools = {
			Encyclopedia.ItemPools.POOL_SECRET,
			Encyclopedia.ItemPools.POOL_ULTRA_SECRET,
		},
	})
