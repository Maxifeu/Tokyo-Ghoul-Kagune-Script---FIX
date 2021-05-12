
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
SWEP.PrintName 		      = "Kagune Koukaku"
SWEP.Category             = "Tokyo Ghoul RP"
SWEP.Author 		      = "Remigius" 
SWEP.Instructions 	      = "" 
SWEP.Contact 		      = "Remigius" 

SWEP.Slot = 2
SWEP.SlotPos = 25

SWEP.AdminSpawnable       = true 
SWEP.Spawnable 		      = true

SWEP.ViewModel = Model( "models/weapons/c_arms.mdl" )
SWEP.WorldModel = "models/player/kagune_koukakou/koukakou.mdl"
SWEP.ViewModelFOV = 54
SWEP.UseHands = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Delay        = KOUKAKUPRMCD
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Delay = 0.2
SWEP.Secondary.Ammo = "none"

SWEP.DrawAmmo = false

SWEP.HitDistance = 55

local dmgr = 1

local anim = {"fists_left",
			  "fists_left",
			  "fists_left",
			  "fists_right",
			  "fists_right",
			  "fists_right",}
	
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
		  
function SWEP:Initialize()

	self:SetHoldType( "fist" )

end

function SWEP:ShouldDropOnDie()
	return false
end

function SWEP:Deploy()

	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "fists_draw" ) )

	return true

end

/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */

function SWEP:OnDrop()
	self:Remove()
end

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
		
		local dmg = math.random(KOUKAKUPRMATK1* ( ply:GetNWInt("RCells", GHOULLIMITRC) / GHOULLIMITRC ),KOUKAKUPRMATK2 * ( ply:GetNWInt("RCells", GHOULLIMITRC) / GHOULLIMITRC ) )
		
		if ( SERVER && IsValid( tr.Entity ) && ( tr.Entity:IsNPC() || tr.Entity:IsPlayer() || tr.Entity:Health() > 0 ) ) then
		local dmginfo = DamageInfo()
		local attacker = self.Owner
		if ( !IsValid( attacker ) ) then attacker = self end
		dmginfo:SetAttacker( attacker )
		dmginfo:SetInflictor( self )
		dmginfo:SetDamage( dmg * dmgr )
		dmginfo:SetDamageForce( self.Owner:GetRight() * 4912 + self.Owner:GetForward() * 9998 )
		tr.Entity:TakeDamageInfo( dmginfo )
	end

	if ( SERVER && IsValid( tr.Entity ) ) then
		local phys = tr.Entity:GetPhysicsObject()
		if ( IsValid( phys ) ) then
			phys:ApplyForceOffset( self.Owner:GetAimVector() * ( dmg * dmgr )* phys:GetMass(), tr.HitPos )
		end
	end
end	
  
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */

function SWEP:SecondaryAttack()
	if self:GetOwner():GetNWInt("ARCGaz", 0 ) > KOUKAKUARCGazSCRATK or self:GetOwner():GetNWInt("TKGFood") < KAGUNEMINFOOD then
		return
	end
	self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)
	self:GetOwner():SetNWInt("KoukakuShield", CurTime() + 0.25 )
end


function SWEP:Reload()
end

/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */

function SWEP:Think()
	local ply = self:GetOwner()
	if ply:GetNWInt("ARCGaz", 0 ) == 3 then
		dmgr = ArcGaz3Dmg
	elseif ply:GetNWInt("ARCGaz") == 2 then
		dmgr = ArcGaz2Dmg
	elseif ply:GetNWInt("ARCGaz", 0 ) == 1 then
		dmgr = ArcGaz1Dmg
	else
		dmgr = 1
	end
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
