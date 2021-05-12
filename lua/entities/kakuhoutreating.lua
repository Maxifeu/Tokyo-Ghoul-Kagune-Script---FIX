/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Kakuhou - Treator"
ENT.Category = "Tokyo Ghoul RP"
ENT.Author = "Remigius"
ENT.Spawnable = true
ENT.AdminOnly = false

function ENT:SetupDataTables()
	self:NetworkVar( "Int", 0, "RC")
	self:NetworkVar( "Int", 1, "Kagune")
	self:NetworkVar( "Int", 2, "Timer")
	self:NetworkVar( "Bool", 0, "InUse")
	
	if (SERVER) then
		self:SetRC( 0 )
		self:SetKagune( 0 )
		self:SetTimer( 0 )
		self:SetInUse( false )
	end
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function ENT:Think()
	if (SERVER) then
		if ( self:GetInUse() ) and self:GetTimer() < CurTime() then
			self:SetInUse( false )
			local TreatedKakuhou = ents.Create( "kakuhoub")
			TreatedKakuhou:SetPos( self:GetPos() + Vector( 0, 0, -16 ) )
			TreatedKakuhou:SetAngles( self:GetAngles() )
			TreatedKakuhou:Spawn()
			TreatedKakuhou:SetNWInt("KakuhouRCells", self:GetRC() )
			TreatedKakuhou:SetNWInt("KakuhouKagune", self:GetKagune() )
			
			self:SetRC( 0 )
			self:SetKagune( 0 )
			self:SetTimer( 0 )
		end
	end
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function ENT:Initialize()
	if SERVER then
		self:SetModel("models/props_lab/reciever_cart.mdl")
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

	surface.SetFont("Trebuchet24")
	local TextWidth = surface.GetTextSize("Kakuhou - Treator")
	surface.SetFont("Trebuchet18")
	local TextWidth2 = surface.GetTextSize( "300 seconde" )
	local TextWidth3 = surface.GetTextSize( "Veuillez insérez un Kakuhou" )
	Ang:RotateAroundAxis(Ang:Forward(), 90)
	Ang:RotateAroundAxis(Ang:Right(), 270)
	Pos:Add(self:GetForward() * 13)

	cam.Start3D2D(Pos, Ang, 0.11)
		draw.WordBox(2, -TextWidth*0.3, -250, "Kakuhou - Treator", "Trebuchet24", Color(0, 0, 0, 200), Color(255,255,255,255))
		if (self:GetInUse()) then
			draw.WordBox(2, -TextWidth2*0.3, -220, math.ceil( self:GetTimer()-CurTime() ) .. " seconde", "Trebuchet18", Color(0, 0, 0, 200), Color(255,255,255,255))
		else
			draw.WordBox(2, -TextWidth3*0.3, -220, "Veuillez insérez un Kakuhou", "Trebuchet18", Color(0, 0, 0, 200), Color(255,255,255,255))
		end
	cam.End3D2D()
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function ENT:Touch( ent )
	if ent:GetClass() == "kakuhoua" and (!self:GetInUse()) then
		self:SetInUse( true )
		self:SetTimer( CurTime() + KAKUHOUTREATORTIMER )
		self:SetRC( ent:GetNWInt("KakuhouRCells", 1250 ) )
		self:SetKagune( ent:GetNWInt("KakuhouKagune", 200 ) )
		ent:Remove()
	end
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */














