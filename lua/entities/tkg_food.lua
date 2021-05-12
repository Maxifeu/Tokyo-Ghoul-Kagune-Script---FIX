/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName		= "TKG Food"
ENT.Category 		= "Tokyo Ghoul RP"

ENT.Spawnable = false

ENT.UseDelay = 0

function ENT:Draw()
	self:DrawModel()
end

function ENT:OnTakeDamage()
	self:Remove()
end

function ENT:AcceptInput( Name, Activator, Caller )
	if self.UseDelay < CurTime() then
		self.UseDelay = CurTime() + 5
		if Name == "Use" and Caller:IsPlayer() then
			if Caller:GetNWInt("RCells") >= GHOULLIMITRC then
				Caller:TakeDamage( FOODDAMAGEIFGHOUL )
				self:Remove()
			else
				Caller:SetNWInt("TKGFood", math.min( Caller:GetNWInt("TKGMaxFood"), Caller:GetNWInt("TKGFood") + self:GetNWInt("TKGFood", 450)) )
				self:Remove()
			end
			Caller:EmitSound("vo/sandwicheat09.mp3", 75, 100, 0.6)
		end
	end
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */