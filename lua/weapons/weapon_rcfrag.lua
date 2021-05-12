
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */


SWEP.PrintName 		      = "Grenade GRC" 
SWEP.Category = "Tokyo Ghoul RP"
SWEP.Author            = "Remigius"
SWEP.Contact        = ""
SWEP.Purpose        = ""

SWEP.ViewModelFOV    = 75
SWEP.ViewModelFlip    = false

SWEP.Spawnable            = true
SWEP.AdminSpawnable        = true

SWEP.ViewModel			  = "models/weapons/v_grenade.mdl"
SWEP.WorldModel   = "models/weapons/w_grenade.mdl"

SWEP.Slot            = 4
SWEP.SlotPos         = 4

SWEP.Primary.ClipSize        = -1
SWEP.Primary.DefaultClip    = 2
SWEP.Primary.Automatic       = false    
SWEP.Primary.Ammo             = "RCFrag"
 
SWEP.Secondary.ClipSize        = -1
SWEP.Secondary.DefaultClip    = -1
SWEP.Secondary.Automatic       = false
SWEP.Secondary.Ammo         = "none"

function SWEP:Initialize()

	self:SetHoldType( "grenade" )

end

/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */

function SWEP:Deploy()
	self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
end

function SWEP:PrimaryAttack()
	self:SetNextSecondaryFire( CurTime() + 1.4 )
	self:SetNextPrimaryFire( CurTime() + 1.4  )

	if self.Weapon:Ammo1() > 0 then
	self.Weapon:TakePrimaryAmmo( 1 )
	
	self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	
	self.Owner:EmitSound( "WeaponFrag.Throw", 40, 100 )
	
		if SERVER then
			local ply = self:GetOwner()
			local rcgrenade = ents.Create("rcfrag")
			rcgrenade:Spawn()
			rcgrenade:SetPos(ply:GetShootPos() + Vector(0,0,-9.2))
			rcgrenade:SetAngles(ply:EyeAngles())
			rcgrenade:SetPhysicsAttacker(self.Owner)
			rcgrenade:SetOwner(self.Owner)
			rcgrenade:Spawn()
				
			rcgrenade:SetNWInt("FragRemove", CurTime() + 13 )
			rcgrenade:SetNWInt("FragExplo", CurTime() + 3 )
			rcgrenade:SetNWInt("FragExploStop", CurTime() + 6 )
			
			local Phys = rcgrenade:GetPhysicsObject()
			local Force = ply:GetAimVector() * 900 + Vector(0, 0, math.random(10,20))
			Phys:ApplyForceCenter(Force)
		end
	end
end	
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */

  
function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire( CurTime() + 1.4 )
	self:SetNextPrimaryFire( CurTime() + 1.4  )

	if self.Weapon:Ammo1() > 0 then 
	self.Weapon:TakePrimaryAmmo( 1 )
	
	self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	
	self.Owner:EmitSound( "WeaponFrag.Throw", 40, 100 )
	
		if SERVER then
			local ply = self:GetOwner()
			local rcgrenade = ents.Create("rcfrag")
			rcgrenade:Spawn()
			rcgrenade:SetPos(ply:GetShootPos() + Vector(0,0,-9.2))
			rcgrenade:SetAngles(ply:EyeAngles())
			rcgrenade:SetPhysicsAttacker(self.Owner)
			rcgrenade:SetOwner(self.Owner)
			rcgrenade:Spawn()
				
			rcgrenade:SetNWInt("FragRemove", CurTime() + 13 )
			rcgrenade:SetNWInt("FragExplo", CurTime() + 3 )
			rcgrenade:SetNWInt("FragExploStop", CurTime() + 6 )
			
			local Phys = rcgrenade:GetPhysicsObject()
			local Force = ply:GetAimVector() * 300 + Vector(0, 0, math.random(10,20))
			Phys:ApplyForceCenter(Force)
		end
	end
end

/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */

function SWEP:CustomAmmoDisplay()
	self.AmmoDisplay = self.AmmoDisplay or {}

	self.AmmoDisplay.Draw = false

	return self.AmmoDisplay
end

/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
