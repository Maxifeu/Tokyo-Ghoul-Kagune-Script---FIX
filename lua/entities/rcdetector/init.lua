/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
 AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')
 
function ENT:Initialize()
	self:SetModel( "models/props_wasteland/interior_fence002e.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	
    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then phys:Wake() end
end

local dooralarm = 0
local doorRC = 0
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function ENT:Think()
	for k, v in pairs(ents.FindInSphere( self:GetPos(), 5 )) do
		if v:IsPlayer() and v:Health() > 0 then
			if v:GetNWInt("RCells", 200 ) >= GHOULLIMITRC then
				dooralarm = 3 + CurTime()
				doorRC = 1
			end
		end
		if dooralarm > CurTime() and doorRC == 1 then
			self:EmitSound( "NPC_FloorTurret.Alarm" )
		elseif dooralarm < CurTime() then
			self:StopSound( "NPC_FloorTurret.Alarm" )
		end
	end
end

/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */