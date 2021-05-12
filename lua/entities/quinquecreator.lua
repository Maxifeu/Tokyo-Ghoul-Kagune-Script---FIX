/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Quinque - Creator"
ENT.Category = "Tokyo Ghoul RP"
ENT.Author = "Remigius"
ENT.Spawnable = true
ENT.AdminOnly = false

ENT.UseDelay = 0

if (SERVER) then
	util.AddNetworkString( "QuinqueCreatorStart" )
	util.AddNetworkString( "QuinqueCreatorReturn" )
end

function ENT:SetupDataTables()
	self:NetworkVar( "Int", 0, "RC")
	self:NetworkVar( "Int", 1, "Kagune")
	self:NetworkVar( "Int", 2, "Timer")
	self:NetworkVar( "Bool", 0, "InUse")
	self:NetworkVar( "Bool", 1, "Setting")
	self:NetworkVar( "String", 0, "Name" )
	self:NetworkVar( "String", 1, "Type" )
	
	if (SERVER) then
		self:SetRC( 0 )
		self:SetKagune( 0 )
		self:SetTimer( 0 )
		self:SetInUse( false )
		self:SetSetting( false )
		self:SetName( "" )
		self:SetType( "" )
	end
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function ENT:Think()
	if (SERVER) then
		if ( self:GetInUse() ) and (self:GetSetting()) and self:GetTimer() < CurTime() then
			self:SetInUse( false )
			self:SetSetting( false )
			local Quinque = ents.Create( "quinquecbd")
			local Pos = self:GetPos()
			Pos:Add(self:GetForward()* -16)
			Pos:Add(self:GetUp()*35)
			Pos:Add(self:GetRight() * -20 )
			local Ang = self:GetAngles()
			Quinque:SetPos( Pos )
			Quinque:SetAngles( Ang )
			Quinque:Spawn()
			Quinque:SetNWString("QuinqueName", self:GetName() )
			Quinque:SetNWString("QuinqueType", self:GetType() )
			Quinque:SetNWInt("QuinqueKagune", self:GetKagune() )
			Quinque:SetNWInt("QuinqueRC", self:GetRC() )
			
			self:SetRC( 0 )
			self:SetKagune( 0 )
			self:SetTimer( 0 )
			self:SetName( "" )
			self:SetType( "" )
		end
	end
end

function ENT:Initialize()
	if SERVER then
		self:SetModel("models/props_wasteland/laundry_washer003.mdl")
		self:SetPos( self:GetPos() + Vector( 0, 0, 50 ) )
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
net.Receive( "QuinqueCreatorReturn", function( len, ply )
	local tab = net.ReadTable()
	ply:PrintMessage( HUD_PRINTTALK, "La création de la Quinque a bien était commencé" )
	tab.Entity:SetName( tab.Name )
	tab.Entity:SetType( tab.Type )
	tab.Entity:SetSetting( true )
	tab.Entity:SetTimer( CurTime() + QKQCREATORTIMER )
end)

net.Receive( "QuinqueCreatorStart", function()
	local ScrW = ScrW()
	local ScrH = ScrH()
	local tab = net.ReadTable()
	
	local Frame = vgui.Create('DFrame')
	Frame:SetSize(200, 350)
	Frame:Center()
	Frame:SetTitle( "Quinque Creator" )
	Frame:SetSizable(false)
	Frame:MakePopup()
	Frame:ShowCloseButton( true )
	Frame:SetDraggable( false )
	Frame.Paint = function()
		draw.RoundedBox( 8, 0, 0, Frame:GetWide(), Frame:GetTall(), Color( 80, 80, 80, 250 ) )
	end
	
	local DNomBox = vgui.Create('DLabel', Frame)
	DNomBox:SetPos( 10, 30 )
	DNomBox:SetSize( 180, 30 )
	DNomBox:SetText( "Nom" )
	DNomBox:SetColor( Color( 250, 250, 250 ) )
	DNomBox:SetContentAlignment( 5 )
	
	local DNomEntry = vgui.Create('DTextEntry', Frame )
	DNomEntry:SetPos( 10, 52 )
	DNomEntry:SetSize( 180, 30 )
	DNomEntry:SetContentAlignment( 5 )
	DNomEntry:SetText( "" )
	
	local DTypeBox = vgui.Create('DLabel', Frame )
	DTypeBox:SetPos( 10, 82 )
	DTypeBox:SetSize( 180, 30 )
	DTypeBox:SetText( "Type" )
	DTypeBox:SetColor( Color( 250, 250, 250 ) )
	DTypeBox:SetContentAlignment( 5 )
	
	local DTypeEntry = vgui.Create( 'DComboBox', Frame )
	DTypeEntry:SetPos( 10, 104 )
	DTypeEntry:SetSize( 180, 30 )
	DTypeEntry:SetContentAlignment( 5 )
	DTypeEntry:SetValue( "Armure" )
	DTypeEntry:AddChoice( "Armure" )
	DTypeEntry:AddChoice( "Corp à corp" )
	DTypeEntry:AddChoice( "À distance" )
	
	local DRCBox = vgui.Create( 'DLabel', Frame )
	DRCBox:SetPos( 10, 134 )
	DRCBox:SetSize( 180, 30 )
	DRCBox:SetText( "RC" )
	DRCBox:SetColor( Color( 250, 250, 250 ) )
	DRCBox:SetContentAlignment( 5 )
	
	local DRCEntry = vgui.Create( 'DTextEntry', Frame )
	DRCEntry:SetPos( 10, 156 )
	DRCEntry:SetSize( 180, 30 )
	DRCEntry:SetText( tostring( tab.RC ) )
	DRCEntry:SetContentAlignment( 5 )
	DRCEntry:SetNumeric( true )
	DRCEntry:SetEditable( false )
	
	local DKaguneBox = vgui.Create( 'DLabel', Frame )
	DKaguneBox:SetPos( 10, 186 )
	DKaguneBox:SetSize( 180, 30 )
	DKaguneBox:SetText( "Kagune" )
	DKaguneBox:SetColor( Color( 250, 250, 250 ) )
	DKaguneBox:SetContentAlignment( 5 )
	
	local DKaguneEntry = vgui.Create( 'DTextEntry', Frame )
	DKaguneEntry:SetPos( 10, 208 )
	DKaguneEntry:SetSize( 180, 30 )
	DKaguneEntry:SetText( tostring( tab.Kagune ) )
	DKaguneEntry:SetContentAlignment( 5 )
	DKaguneEntry:SetNumeric( true )
	DKaguneEntry:SetEditable( false )
	
	local DSaveButton = vgui.Create( 'DButton', Frame )
	DSaveButton:SetPos( 10, 258 )
	DSaveButton:SetSize( 180, 30 )
	DSaveButton:SetText( "Sauvegarder" )
	DSaveButton:SetContentAlignment( 5 )
	DSaveButton.Paint = function( self, w, h )
		draw.RoundedBox( 6, 0, 0, w, h, Color(0, 200, 0, 255 ) )
	end
	DSaveButton.DoClick = function()
		net.Start( "QuinqueCreatorReturn" )
		net.WriteTable( { Name = DNomEntry:GetValue(), Type = DTypeEntry:GetValue(), Entity = tab.Entity } )
		net.SendToServer()
		Frame:Close()
	end
	
	local DCloseButton = vgui.Create( 'DButton', Frame )
	DCloseButton:SetPos( 10, 308 )
	DCloseButton:SetSize( 180, 30 )
	DCloseButton:SetText( "Fermer" )
	DCloseButton:SetContentAlignment( 5 )
	DCloseButton.Paint = function( self, w, h )
		draw.RoundedBox( 6, 0, 0, w, h, Color(200, 0, 0, 255 ) )
	end
	DCloseButton.DoClick = function()
		Frame:Close()
	end
end)
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function ENT:AcceptInput( Name, Activator, Caller )
	if (SERVER) then
		if Name == "Use" and Caller:IsPlayer() then
			if self.UseDelay < CurTime() then
				self.UseDelay = CurTime() + 2
				if self:GetInUse() and !self:GetSetting() then
					if Name == "Use" and Caller:IsPlayer() then
						net.Start( "QuinqueCreatorStart" )
						net.WriteTable( {RC = self:GetRC(), Kagune = self:GetKagune(), Entity = self } )
						net.Send( Caller )
					end
				end
			end
		end
	end
end

function ENT:Touch( ent )
	if ent:GetClass() == "kakuhoub" and (!self:GetInUse()) then
		if (!self:GetSetting()) then
			self:SetInUse( true )
			self:SetRC( ent:GetNWInt("KakuhouRCells", 1250 ) )
			self:SetKagune( ent:GetNWInt("KakuhouKagune", 200 ) )
			ent:Remove()
		end
	end
end

function ENT:Draw()
	self:DrawModel()

	local Pos = self:GetPos()
	local Ang = self:GetAngles()
	
	surface.SetFont("Trebuchet24")
	local TextWidth = surface.GetTextSize("Quinque - Creator")
	
	surface.SetFont("Trebuchet18")
	local TextWidth2 = surface.GetTextSize( "300 seconde" )
	local TextWidth3 = surface.GetTextSize( "Veuillez insérez un Kakuhou" )
	local TextWidth4 = surface.GetTextSize( "Veuillez configurez la machine" )
	local TextWidth5 = surface.GetTextSize( self:GetKagune().."  -  "..self:GetRC() )
	
	Ang:RotateAroundAxis(Ang:Right(), -180)
	Ang:RotateAroundAxis(Ang:Forward(), 210)
	
	Pos:Add(self:GetRight() * -31)
	Pos:Add(self:GetForward() * 21.35 )
	Pos:Add(self:GetUp() * 9.8 )

	cam.Start3D2D(Pos, Ang, 0.11)
		draw.WordBox(2, -TextWidth*0.3, -250, "Quinque - Creator", "Trebuchet24", Color(0, 0, 0, 200), Color(255,255,255,255))
		if (self:GetInUse()) and (self:GetSetting()) then
			draw.WordBox(2, -TextWidth2*0.3, -220, math.ceil( self:GetTimer()-CurTime() ) .. " seconde", "Trebuchet18", Color(0, 0, 0, 200), Color(255,255,255,255))
		else
			if (self:GetInUse()) then
				draw.WordBox(2, -TextWidth5*0.3, -220, self:GetKagune().."  -  "..self:GetRC(), "Trebuchet18", Color(0, 200, 0, 200), Color(255,255,255,255))
			else
				draw.WordBox(2, -TextWidth3*0.3, -220, "Veuillez insérez un Kakuhou", "Trebuchet18", Color(0, 0, 0, 200), Color(255,255,255,255))
			end
			draw.WordBox(2, -TextWidth4*0.3, -195, "Veuillez configurez la machine", "Trebuchet18", Color(0, 0, 0, 200), Color(255,255,255,255))
		end
	cam.End3D2D()
end

/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */











