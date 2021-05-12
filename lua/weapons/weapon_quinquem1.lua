
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
SWEP.PrintName 		      = "Quinque Melee 1"
SWEP.Category             = "Tokyo Ghoul RP"
SWEP.Author 		      = "Remigius" 
SWEP.Instructions 	      = "" 
SWEP.Contact 		      = "Remigius" 

SWEP.Slot = 2
SWEP.SlotPos = 15

SWEP.AdminSpawnable       = true 
SWEP.Spawnable 		      = true

SWEP.ViewModel = Model( "models/quinque_sword/v_quinque/vquinque.mdl")
SWEP.WorldModel = Model( "models/quinque_sword/w_quinque/wquinque.mdl")
SWEP.ViewModelFOV = 54
SWEP.UseHands = false

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Delay        = QKQMPRMCD
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Delay = QKQMSCRCD
SWEP.Secondary.Ammo = "none"

SWEP.DrawAmmo = false

SWEP.HitDistance = 70

local dmgr = 1
local dal = 0

/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */

function SWEP:Initialize()

	self:SetHoldType( "melee2" )

end
		
function SWEP:Deploy()
end

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )

	self.Weapon:SendWeaponAnim( ACT_MELEE_ATTACK2 )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	local ply = self:GetOwner()

	local tr = ply:GetEyeTraceNoCursor()

	ply:EmitSound("NPC_Vortigaunt.Swing")

	if tr.StartPos:Distance( tr.HitPos ) <= 80 then
		if (tr.HitWorld) then
			ply:EmitSound("Weapon_Crowbar.Melee_HitWorld")
		elseif tr.Entity:IsValid() then
			ply:EmitSound("NPC_Stalker.Hit")
			if (SERVER) then
				local DMG = math.random(QKQMPRMATK1, QKQMPRMATK2) * self.Owner:GetNWInt("QMDamage", 1.25)
				tr.Entity:TakeDamage( DMG ,ply, self)
			end
		end
	end
end	
  
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */

function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )
	self:SetNextPrimaryFire( CurTime() + self.Secondary.Delay )

	self.Weapon:SendWeaponAnim( ACT_MELEE_ATTACK2 )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	local ply = self:GetOwner()

	local tr = ply:GetEyeTraceNoCursor()

	ply:EmitSound("NPC_Vortigaunt.Swing")

	if tr.StartPos:Distance( tr.HitPos ) <= 80 then
		if (tr.HitWorld) then
			ply:EmitSound("Weapon_Crowbar.Melee_HitWorld")
		elseif tr.Entity:IsValid() then
			ply:EmitSound("NPC_AntlionGuard.HitHard")
			if (SERVER) then
				local DMG = math.random(QKQMSCRATK1, QKQMSCRATK2) * self.Owner:GetNWInt("QMDamage", 1.25)
				tr.Entity:TakeDamage( DMG ,ply, self)
			end
		end
	end
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
