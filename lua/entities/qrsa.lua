/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName		= "QRMA"
ENT.Category 		= "Tokyo Ghoul RP"

ENT.Spawnable = false
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function ENT:Initialize()

	local attackmdl = {"models/props_wasteland/rockcliff01c.mdl", "models/props_wasteland/rockcliff01e.mdl", "models/props_wasteland/rockcliff01g.mdl"}
	
	self:SetModel( attackmdl[ math.random( #attackmdl ) ] )
	self:SetMaterial( "models/player/shared/ice_player", true )
	self:SetMoveType( MOVETYPE_FLYGRAVITY )
	self:SetSolid( SOLID_BBOX )
	self:DrawShadow( false )
	self.NotStuck = true

	self:SetModelScale( 0.10 )
	self:SetColor( Color( 140, 0, 0, 255 ) )

	self:SetCollisionGroup( COLLISION_GROUP_INTERACTIVE )
	self:SetNetworkedString("Owner", "World")
	self.RemoveENT = CurTime() + 2
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function ENT:Draw()
	self:DrawModel()
end

function ENT:Think()
	if ( SERVER ) then
		if self.RemoveENT < CurTime() then self:Remove() end
		if self.NotStuck then self:SetAngles(self:GetVelocity():Angle()) end
	end
	self:NextThink(CurTime()) return true
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function ENT:Touch( ent )

	local speed = self:GetVelocity():Length( )

	local ply = self.Owner
	
	if ent:IsNPC() or ent:IsPlayer() or ent:IsWorld() or ent:IsVehicle() or ent:IsValid() then

		if speed < 150 then

			if speed >= 150 then
				self.NotStuck = false
				self:SetMoveType( MOVETYPE_NONE )
				self:PhysicsInit( SOLID_NONE )
				self:SetParent(ent)
				ent:TakeDamage(math.random(100, 150) , self:GetOwner(), self)
				self.RemoveENT = CurTime() + 1.2
			end
			
		return false end
		
		if ent:IsWorld() then
			self.NotStuck = false
			self:SetMoveType( MOVETYPE_NONE )
			self:PhysicsInit( SOLID_NONE )
			self:SetPos(self:GetPos() + self:GetUp()*0)
			self.RemoveENT = CurTime() + 1.2
		else
			if ent:IsValid() then
				self.NotStuck = false
				self:SetMoveType( MOVETYPE_NONE )
				self:PhysicsInit( SOLID_NONE )
				self:SetParent(ent)
				ent:TakeDamage(math.random(QKQRSCRATK1, QKQRSCRATK2) * self:GetNWInt("Damage",1.25), self:GetOwner(), self)
				local physforce = speed * math.random(QKQRSCRATK1*2, QKQRSCRATK2*1.5)
				local phy = ent:GetPhysicsObject()
				if (IsValid(phy)) then if (IsValid(phy)) then phy:ApplyForceCenter(self:GetUp()*(physforce)) end end
				self.RemoveENT = CurTime() + 1.2
				self:SetPos(self:GetPos() + self:GetUp()*2)
			end
		end
	end
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function ENT:PhysicsCollide( data, physobj )
	if data.HitEntity:IsWorld() then
		phys:Wake()  
		phys:EnableGravity(false) 
		self:SetMoveType( MOVETYPE_NONE )
		self:PhysicsInit( SOLID_NONE )
	end
end



/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */