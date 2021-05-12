
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
SWEP.PrintName 		      = "Quinx Bikaku"
SWEP.Category             = "Tokyo Ghoul RP"
SWEP.Author 		      = "Remigius" 
SWEP.Instructions 	      = "" 
SWEP.Contact 		      = "Remigius" 

SWEP.Slot = 2
SWEP.SlotPos = 30

SWEP.AdminSpawnable       = true 
SWEP.Spawnable 		      = true

SWEP.ViewModel = Model( "models/weapons/c_arms.mdl" )
SWEP.WorldModel = "models/player/bikaku/bikaku.mdl"
SWEP.ViewModelFOV = 54
SWEP.UseHands = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Delay        = BIKAKUPRMCD
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Delay = BIKAKUSCRCD
SWEP.Secondary.Ammo = "none"

SWEP.DrawAmmo = false

SWEP.HitDistance = 60

local Anim1 = 0

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

function SWEP:ShouldDropOnDie()
	return false
end

function SWEP:Deploy()

	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "fists_draw" ) )

	return true

end

function SWEP:OnDrop()
	self:Remove()
end

function SWEP:Think()
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
		
		local dmg = math.random(BIKAKUPRMATK1 * ply:GetNWInt("QuinxCells", 1.25),BIKAKUPRMATK2 * ply:GetNWInt("QuinxCells", 1.25) )
		
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
			phys:ApplyForceOffset( self.Owner:GetAimVector() * ( dmg ) * phys:GetMass(), tr.HitPos )
		end
	end
end	
  
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */

function SWEP:SecondaryAttack()
	local ply = self:GetOwner()

	self:EmitSound( "physics/nearmiss/whoosh_large1.wav" )

	Anim1 = CurTime() + 3
self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)
local tr = util.TraceLine( {
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 205,
			filter = self.Owner,
			mask = MASK_SHOT_HULL
		} )
		if ( !IsValid( tr.Entity ) ) then
			tr = util.TraceHull( {
				start = self.Owner:GetShootPos(),
				endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 205,
				filter = self.Owner,
				mins = Vector( -10, -10, -8 ),
				maxs = Vector( 10, 10, 8 ),
				mask = MASK_SHOT_HULL
			} )
		end
		
		if ( tr.Hit && !( game.SinglePlayer() && CLIENT ) ) then
			self:EmitSound( "vehicles/airboat/pontoon_impact_hard1.wav" )
		end
		
		local dmg = math.random(BIKAKUSCRATK1 * ply:GetNWInt("QuinxCells", 1.25),BIKAKUSCRATK2 * ply:GetNWInt("QuinxCells", 1.25) )
		
	if ( SERVER && IsValid( tr.Entity ) && ( tr.Entity:IsNPC() || tr.Entity:IsPlayer() || tr.Entity:Health() > 0 ) ) then
		local dmginfo = DamageInfo()
		local attacker = self.Owner
		if ( !IsValid( attacker ) ) then attacker = self end
		dmginfo:SetAttacker( attacker )
		dmginfo:SetInflictor( self )
		dmginfo:SetDamage( dmg )
		dmginfo:SetDamageForce( self.Owner:GetRight() * 4912 + self.Owner:GetForward() * 9998 )
		tr.Entity:SetVelocity( self.Owner:GetAimVector() * 750 + Vector( 0, 0, 100 ) )
		tr.Entity:TakeDamageInfo( dmginfo )
	end

	if ( SERVER && IsValid( tr.Entity ) ) then
		local phys = tr.Entity:GetPhysicsObject()
		if ( IsValid( phys ) ) then
			phys:ApplyForceOffset( self.Owner:GetAimVector() *( dmg * 750)* phys:GetMass() , tr.HitPos )
		end
	end
end

function SWEP:Reload()
end

/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */

function SWEP:Holster()
local ply = self.Owner
	if IsValid(ply) then
		
	if SERVER then

		local bone = self:LookupBone("Bikaku_bone1")
		if bone then 
			self:ManipulateBoneAngles( bone, Angle(0,0,0) )
		end	
		local bone = self:LookupBone("Bikaku_bone2")
		if bone then 
			self:ManipulateBoneAngles( bone, Angle(0,0,0) )
		end
	end
	end
	
	return true
	
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
