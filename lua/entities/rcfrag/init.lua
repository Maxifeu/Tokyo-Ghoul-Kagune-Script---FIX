/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
 AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')
 
function ENT:Initialize()
	self:SetModel( "models/weapons/w_grenade.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	
    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then phys:Wake() end
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
local music = 0
local del = 0
function ENT:Think()
	if self:GetNWInt("FragRemove", 0 ) < CurTime() then
		self:Remove()
	end
	if self:GetNWInt("FragExplo", 0) < CurTime() and self:GetNWInt("FragExploStop", 0 ) > CurTime() then
		local rcfrag = EffectData()
		rcfrag:SetOrigin(self:GetPos())
		util.Effect("rcsmoke",rcfrag)
		if music == 0 then
			music = 1
			self.Entity:EmitSound( "BaseSmokeEffect.Sound", 62, 100 )
		end
	end
	if del < CurTime() then
		del = CurTime() + 1
		for k, v in pairs( ents.FindInSphere( self:GetPos(), 205 ) ) do
			if v:IsPlayer() then
				if v:GetNWInt("RCells", 0) > 1000 and v:Health() > 0 then
					if v:GetNWInt("ARCGazSeconde", 1000 ) == 1000 then
						v:SetNWInt("ARCGazSeconde", 30 )
					else
						if v:GetNWInt("ARCGazSeconde", 0 ) < 500 then
							v:SetNWInt("ARCGazSeconde", math.min( 500, v:GetNWInt("ARCGazSeconde", 0 ) + 30 ) )
						end
					end
				end
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

	if data.Speed > 130  then
		self.Entity:EmitSound("physics/metal/weapon_impact_soft" .. (math.random(1,2)) .. ".wav", 52, 100)
	end

end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */