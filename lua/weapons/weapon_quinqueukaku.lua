
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */


SWEP.PrintName 		      = "Quinx Ukaku"
SWEP.Category             = "Tokyo Ghoul RP"
SWEP.Author 		      = "Remigius" 
SWEP.Instructions 	      = "" 
SWEP.Contact 		      = "Remigius" 

SWEP.Slot = 2
SWEP.SlotPos = 15

SWEP.AdminSpawnable       = true 
SWEP.Spawnable 		      = true

SWEP.ViewModel = Model( "models/weapons/c_arms.mdl" )
SWEP.WorldModel = "models/player/ukaku.mdl"
SWEP.ViewModelFOV = 54
SWEP.UseHands = true

SWEP.Primary.ClipSize = 25
SWEP.Primary.DefaultClip = 20
SWEP.Primary.Delay        = UKAKUPRMCD
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "QrUkakuAmmo"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Delay = UKAKUSCRCD
SWEP.Secondary.Ammo = "none"

SWEP.DrawAmmo = false

SWEP.HitDistance = 70

local dal = 0
local del = 0

local firesound = {"physics/metal/chain_impact_soft1.wav",
				   "physics/metal/chain_impact_hard1.wav",
				  }
				  
local anim = {"fists_left",
			  "fists_left",
			  "fists_left",
			  "fists_right",
			  "fists_right",
			  "fists_right",}

function SWEP:Initialize()

	self:SetHoldType( "fist" )

end
		
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */

function SWEP:Deploy()

	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "fists_draw" ) )

	return true

end
		
function SWEP:ShouldDropOnDie()
	return false
end

function SWEP:OnDrop()
	self:Remove()
end

/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */

function SWEP:PrimaryAttack()

self.Owner:SetAnimation( PLAYER_ATTACK1 )
	
local vm = self.Owner:GetViewModel()
vm:SendViewModelMatchingSequence( vm:LookupSequence( anim[ math.random( #anim ) ] ) )
	
self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)
local ply = self:GetOwner()

self:EmitSound( "WeaponFrag.Throw" )

local tr = util.TraceLine( {
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.HitDistance,
			filter = self.Owner,
			mask = MASK_SHOT_HULL
		} )
		if ( !IsValid( tr.Entity ) ) then
			tr = util.TraceHull( {
				start = self.Owner:GetShootPos(),
				endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.HitDistance,
				filter = self.Owner,
				mins = Vector( -10, -10, -8 ),
				maxs = Vector( 10, 10, 8 ),
				mask = MASK_SHOT_HULL
			} )
		end
		
		if ( tr.Hit && !( game.SinglePlayer() && CLIENT ) ) then
			self:EmitSound( "Flesh.ImpactHard" )
		end
		
		local dmg = math.random(UKAKUPRMATK1 * ply:GetNWInt("QuinxCells", 1.25),UKAKUPRMATK2 * ply:GetNWInt("QuinxCells", 1.25) )
		
		if ( SERVER && IsValid( tr.Entity ) && ( tr.Entity:IsNPC() || tr.Entity:IsPlayer() || tr.Entity:Health() > 0 ) ) then
		local dmginfo = DamageInfo()
		local attacker = self.Owner
		if ( !IsValid( attacker ) ) then attacker = self end
		dmginfo:SetAttacker( attacker )
		dmginfo:SetInflictor( self )
		dmginfo:SetDamage( dmg )
		dmginfo:SetDamageForce( self.Owner:GetRight() * 4912 + self.Owner:GetForward() * 9998 )
		tr.Entity:TakeDamageInfo( dmginfo )
	end

	if ( SERVER && IsValid( tr.Entity ) ) then
		local phys = tr.Entity:GetPhysicsObject()
		if ( IsValid( phys ) ) then
			phys:ApplyForceOffset( self.Owner:GetAimVector() * dmg * phys:GetMass(), tr.HitPos )
		end
	end
end	
  
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */

function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	local ply = self:GetOwner()
	
	if self.Weapon:Clip1() < 1 then return end
	self.Weapon:SetClip1( self.Weapon:Clip1() - 1 )

	--ply:EmitSound(firesound[ math.random( #firesound ) ])
	if SERVER then
		local Shard = ents.Create("ukakushard")
		local eAng = self.Owner:EyeAngles()
		Shard:SetPos(self.Owner:GetShootPos() - eAng:Right()*math.random(-30,30) - eAng:Up()*math.random(5, 40))
		Shard:SetOwner(self.Owner)
		Shard:SetAngles(eAng - Angle( 90, 0, 0 ))
		Shard:Spawn()
		Shard:SetVelocity(-Shard:GetUp()*Lerp(100/100, 200, 3200))
		Shard:SetGravity(Lerp(100/100, 1.1, 0.0655))
	end
end

function SWEP:Reload()
local ply = self:GetOwner()
	if dal < CurTime() then
		dal = CurTime() + 30
	end
end

/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */

function SWEP:Think()
local ply = self:GetOwner()
	if dal > CurTime()+20 then
		ply:SetRunSpeed( 750 )
	end
	if self.Weapon:Clip1() <= 0 then
		if del < CurTime() then
			timer.Simple( 10, function() self.Weapon:SetClip1( math.min( 25, self.Weapon:Clip1() + 1 ) ) end)
			del = CurTime() + 10.2
		end
	elseif self.Weapon:Clip1() < 25 then
		if del < CurTime() then
			del = CurTime() + 0.5
			self.Weapon:SetClip1( math.min( 25, self.Weapon:Clip1() + 1 ) )
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
