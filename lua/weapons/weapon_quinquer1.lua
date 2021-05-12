
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */

SWEP.PrintName 		      = "Quinque Ranged 1"
SWEP.Category             = "Tokyo Ghoul RP"
SWEP.Author 		      = "Remigius" 
SWEP.Instructions 	      = "" 
SWEP.Contact 		      = "Remigius" 

SWEP.Slot = 2
SWEP.SlotPos = 15

SWEP.AdminSpawnable       = true 
SWEP.Spawnable 		      = true

SWEP.ViewModel = ""
SWEP.WorldModel = ""
SWEP.ViewModelFOV = 54
SWEP.UseHands = true

SWEP.Primary.Ammo = "QRAmmo"
SWEP.Primary.ClipSize = 200
SWEP.Primary.DefaultClip = 200
SWEP.Primary.Automatic = true
SWEP.Primary.Delay = QKQRPRMCD
SWEP.Primary.AmmoRegen = 0

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Delay = QKQRSCRCD
SWEP.Secondary.Ammo = "none"

local del = 0

local firesound = {"physics/metal/chain_impact_soft1.wav", "physics/metal/chain_impact_hard1.wav"}

function SWEP:Initialize()

	self:SetHoldType( "ar2" )

end

/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
		
function SWEP:Deploy()
end

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
	local ply = self:GetOwner()
	
	if self.Weapon:Clip1() <= 0 then return end
	self.Weapon:SetClip1( self.Weapon:Clip1() - 1 )
	
	ply:EmitSound(firesound[ math.random( #firesound ) ])
	
	if SERVER then
		local QRAttack = ents.Create("qrma")
		local ePos = ply:GetBonePosition( ply:LookupBone( "ValveBiped.Bip01_L_Hand" ) )
		local eAng = self.Owner:EyeAngles()
		QRAttack:SetPos(ePos - eAng:Right()*math.random(-2.5,2.5) - eAng:Up()*math.random(-2.5, 2.5))
		QRAttack:SetOwner(self.Owner)
		QRAttack:SetAngles(eAng - Angle( 90, 0, 0 ))
		QRAttack:SetNWInt("Damage", self.Owner:GetNWInt("QRGDamage", 1.25) )
		QRAttack:Spawn()
		QRAttack:SetVelocity(-QRAttack:GetUp()*Lerp(100/100, 200, 3200))
		QRAttack:SetGravity(Lerp(100/100, 1.1, 0.0655))
	end
end
  
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */

function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)
	self:SetNextPrimaryFire(CurTime() + self.Secondary.Delay)
	local ply = self:GetOwner()
	
	if self.Weapon:Clip1() <= 10 then return end
	self.Weapon:SetClip1( self.Weapon:Clip1() - 10 )
	
	ply:EmitSound(firesound[ math.random( #firesound ) ])
	
	if SERVER then
		local QRAttack = ents.Create("qrsa")
		local bone = ply:LookupBone( "ValveBiped.Bip01_L_Hand" )
		local ePos = ply:GetBonePosition( bone )
		local eAng = self.Owner:EyeAngles()
		QRAttack:SetPos(ePos - eAng:Right()*math.random(-2.5,2.5) - eAng:Up()*math.random(-2.5, 2.5))
		QRAttack:SetOwner(self.Owner)
		QRAttack:SetAngles(eAng - Angle( 90, 0, 0 ))
		QRAttack:SetNWInt("Damage", self.Owner:GetNWInt("QRGDamage", 1.25) )
		QRAttack:Spawn()
		QRAttack:SetVelocity(-QRAttack:GetUp()*Lerp(100/100, 200, 3200))
		QRAttack:SetGravity(Lerp(100/100, 1.1, 0.0655))
	end
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */


function SWEP:Think()
	if self.Weapon:Clip1() <= 0 then
		if del < CurTime() then
			timer.Simple( 10, function() self.Weapon:SetClip1( math.min( 200, self.Weapon:Clip1() + 1 ) ) end)
			del = CurTime() + 10.25
		end
	elseif self.Weapon:Clip1() < 200 then
		if del < CurTime() then
			del = CurTime() + 0.25
			self.Weapon:SetClip1( math.min( 200, self.Weapon:Clip1() + 1 ) )
		end
	end
end

function SWEP:CustomAmmoDisplay()
	self.AmmoDisplay = self.AmmoDisplay or {}

	self.AmmoDisplay.Draw = true

	if self.Primary.ClipSize > 0 then
		self.AmmoDisplay.PrimaryClip = self:Clip1()
	end

	return self.AmmoDisplay
end

/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
