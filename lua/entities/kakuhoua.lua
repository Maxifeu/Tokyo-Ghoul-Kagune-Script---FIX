/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Kakuhou - Untreated"
ENT.Category = "Tokyo Ghoul RP"
ENT.Author = "Remigius"
ENT.Spawnable = true
ENT.AdminOnly = false
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function ENT:SetupDataTables()
end

function ENT:Think()
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function ENT:Initialize()
	if SERVER then
		self:SetModel("models/hunter/blocks/cube025x025x025.mdl")
		self:SetModelScale( 0.50 )
		self:SetMaterial( "phoenix_storms/gear" )
		self:SetColor( Color( 109, 109, 109, 255 ) )
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		local phys = self:GetPhysicsObject()
		if (phys:IsValid()) then
			phys:Wake()
		end
	end
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function ENT:Draw()
	self:DrawModel()

	local Pos = self:GetPos()
	local Ang = self:GetAngles()

	surface.SetFont("Trebuchet18")
	local TextWidth = surface.GetTextSize("Kakuhou - Untreated")
	
	Ang:RotateAroundAxis(Ang:Forward(), 90)
	Ang:RotateAroundAxis(Ang:Right(), CurTime() * -90)

	cam.Start3D2D(Pos, Ang, 0.11)
		draw.WordBox(2, -TextWidth*0.5, -60, "Kakuhou - Untreated", "Trebuchet18", Color(0, 0, 0, 200), Color(255,255,255,255))
	cam.End3D2D()
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */