/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Quinque"
ENT.Category = "Tokyo Ghoul RP"
ENT.Author = "Remigius"
ENT.Spawnable = true
ENT.AdminOnly = false

ENT.UseDelay = 0

if (SERVER) then
	util.AddNetworkString( "OpenQuinque" )
	util.AddNetworkString( "ReturnQuinque" )
end

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
		self:SetModel("models/props_c17/BriefCase001a.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		local phys = self:GetPhysicsObject()
		if (phys:IsValid()) then
			phys:Wake()
		end
	end
end

function ENT:Draw()
	self:DrawModel()

	local Pos = self:GetPos()
	local Ang = self:GetAngles()

	surface.SetFont("Trebuchet24")
	local TextWidth = surface.GetTextSize("Quinque")
	
	Ang:RotateAroundAxis(Ang:Forward(), 90)
	Ang:RotateAroundAxis(Ang:Right(), CurTime() * -90)

	cam.Start3D2D(Pos, Ang, 0.11)
		draw.WordBox(2, -TextWidth*0.5, -120, "Quinque", "Trebuchet24", Color(0, 0, 0, 200), Color(255,255,255,255))
	cam.End3D2D()
end
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
				local QuinqueData = {} 
				if sql.Query("SELECT * FROM TKGQuinque WHERE SteamID64 = '".. Caller:SteamID64() .."'") then
					QuinqueData = sql.Query("SELECT * FROM TKGQuinque WHERE SteamID64 = '".. Caller:SteamID64() .."'")
					QuinqueData.Result = table.Count(QuinqueData)
				else
					QuinqueData.Result = 0
				end
				QuinqueData.Ent = self.Entity
				net.Start("OpenQuinque")
				net.WriteTable( QuinqueData )
				net.Send( Caller )
			end
		end
	end
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
if (CLIENT) then
	net.Receive("OpenQuinque", function()
		local tab = net.ReadTable()

		local ScrW = ScrW()
	 	local ScrH = ScrH()

	 	local P1Name, P1RC, P1Kagune, P1Type, P1Efficacite
	 	local P2Name, P2RC, P2Kagune, P2Type, P2Efficacite
	 	local P3Name, P3RC, P3Kagune, P3Type, P3Efficacite
	 	local P4Name, P4RC, P4Kagune, P4Type, P4Efficacite
	 	local P5Name, P5RC, P5Kagune, P5Type, P5Efficacite
	 	local P6Name, P6RC, P6Kagune, P6Type, P6Efficacite

	 	P1Name, P1RC, P1Kagune, P1Type, P1Efficacite = "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown"
		P2Name, P2RC, P2Kagune, P2Type, P2Efficacite = "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown"
		P3Name, P3RC, P3Kagune, P3Type, P3Efficacite = "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown"
		P4Name, P4RC, P4Kagune, P4Type, P4Efficacite = "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown"
		P5Name, P5RC, P5Kagune, P5Type, P5Efficacite = "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown"
		P6Name, P6RC, P6Kagune, P6Type, P6Efficacite = "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown"

	 	if tab.Result > 0 then
	 		for i=1, tab.Result do
	 			if tonumber(tab[i]["Num"]) == 1 then P1Name, P1RC, P1Kagune, P1Type, P1Efficacite = tab[i]["Name"], tab[i]["RC"], tab[i]["Kagune"], tab[i]["Type"], tab[i]["Dmg"] end
	 			if tonumber(tab[i]["Num"]) == 2 then P2Name, P2RC, P2Kagune, P2Type, P2Efficacite = tab[i]["Name"], tab[i]["RC"], tab[i]["Kagune"], tab[i]["Type"], tab[i]["Dmg"] end
	 			if tonumber(tab[i]["Num"]) == 3 then P3Name, P3RC, P3Kagune, P3Type, P3Efficacite = tab[i]["Name"], tab[i]["RC"], tab[i]["Kagune"], tab[i]["Type"], tab[i]["Dmg"] end
	 			if tonumber(tab[i]["Num"]) == 4 then P4Name, P4RC, P4Kagune, P4Type, P4Efficacite = tab[i]["Name"], tab[i]["RC"], tab[i]["Kagune"], tab[i]["Type"], tab[i]["Dmg"] end
	 			if tonumber(tab[i]["Num"]) == 5 then P5Name, P5RC, P5Kagune, P5Type, P5Efficacite = tab[i]["Name"], tab[i]["RC"], tab[i]["Kagune"], tab[i]["Type"], tab[i]["Dmg"] end
	 			if tonumber(tab[i]["Num"]) == 6 then P6Name, P6RC, P6Kagune, P6Type, P6Efficacite = tab[i]["Name"], tab[i]["RC"], tab[i]["Kagune"], tab[i]["Type"], tab[i]["Dmg"] end
	 		end
	 	end
	 	
	 	local MainFrame = vgui.Create("DFrame")
	 	MainFrame:SetTitle("Quinque Saver")
	 	MainFrame:SetSize( 1600/3, 900/3)
		MainFrame:SetSizable(false)
		MainFrame:SetDraggable(false)
		MainFrame:MakePopup()
		MainFrame:Center()
		MainFrame.Paint = function(self, w, h)
			draw.RoundedBox(8, 0, 0, w, h, Color(75, 75, 75, 220) )
		end

		local Panel1 = vgui.Create("DPanel", MainFrame)
		Panel1:SetSize(164, 128)
		Panel1:SetPos(10, 22)
		Panel1:SetText( "")
		Panel1.Paint = function(self, w, h)
			draw.RoundedBox(8, 0, 0, w, h, Color( 50, 50, 50, 230) )
		end

		local Panel1Text = vgui.Create("DLabel", MainFrame)
		Panel1Text:SetSize(164,90)
		Panel1Text:SetPos(14, 26)
		Panel1Text:SetText("Nom: "..P1Name.."\nRC: "..P1RC.."\nKagune: "..P1Kagune.."\nType: "..P1Type.."\nEfficacité: "..P1Efficacite.."")
		Panel1Text:SetColor( Color(255, 255, 255, 255) )

		local Button1 = vgui.Create("DButton", MainFrame)
		Button1:SetSize( 156, 22)
		Button1:SetPos( 14, 124)
		Button1:SetText( "Remplacer" )
		Button1.DoClick = function()
			net.Start( "ReturnQuinque")
			local SendToS = {}
			SendToS.Ent = tab.Ent
			SendToS.Num = 1
			net.WriteTable( SendToS )
			net.SendToServer()
			MainFrame:Close()
		end

		local Panel2 = vgui.Create("DPanel", MainFrame)
		Panel2:SetSize(164, 128)
		Panel2:SetPos(10, 162)
		Panel2:SetText( "")
		Panel2.Paint = function(self, w, h)
			draw.RoundedBox(8, 0, 0, w, h, Color( 50, 50, 50, 230) )
		end

		local Panel2Text = vgui.Create("DLabel", MainFrame)
		Panel2Text:SetSize(164,90)
		Panel2Text:SetPos(14, 166)
		Panel2Text:SetText("Nom: "..P2Name.."\nRC: "..P2RC.."\nKagune: "..P2Kagune.."\nType: "..P2Type.."\nEfficacité: "..P2Efficacite.."")
		Panel2Text:SetColor( Color(255, 255, 255, 255) )

		local Button2 = vgui.Create("DButton", MainFrame)
		Button2:SetSize( 156, 22)
		Button2:SetPos( 14, 264)
		Button2:SetText( "Remplacer" )
		Button2.DoClick = function()
			net.Start( "ReturnQuinque")
			local SendToS = {}
			SendToS.Ent = tab.Ent
			SendToS.Num = 2
			net.WriteTable( SendToS )
			net.SendToServer()
			MainFrame:Close()
		end

		local Panel3 = vgui.Create("DPanel", MainFrame)
		Panel3:SetSize(164, 128)
		Panel3:SetPos(184, 22)
		Panel3:SetText( "")
		Panel3.Paint = function(self, w, h)
			draw.RoundedBox(8, 0, 0, w, h, Color( 50, 50, 50, 230) )
		end

		local Panel3Text = vgui.Create("DLabel", MainFrame)
		Panel3Text:SetSize(164,90)
		Panel3Text:SetPos(188, 26)
		Panel3Text:SetText("Nom: "..P3Name.."\nRC: "..P3RC.."\nKagune: "..P3Kagune.."\nType: "..P3Type.."\nEfficacité: "..P3Efficacite.."")
		Panel3Text:SetColor( Color(255, 255, 255, 255) )

		local Button3 = vgui.Create("DButton", MainFrame)
		Button3:SetSize( 156, 22)
		Button3:SetPos( 188, 124)
		Button3:SetText( "Remplacer" )
		Button3.DoClick = function()
			net.Start( "ReturnQuinque")
			local SendToS = {}
			SendToS.Ent = tab.Ent
			SendToS.Num = 3
			net.WriteTable( SendToS )
			net.SendToServer()
			MainFrame:Close()
		end

		local Panel4 = vgui.Create("DPanel", MainFrame)
		Panel4:SetSize(164, 128)
		Panel4:SetPos(184, 162)
		Panel4:SetText( "")
		Panel4.Paint = function(self, w, h)
			draw.RoundedBox(8, 0, 0, w, h, Color( 50, 50, 50, 230) )
		end

		local Panel4Text = vgui.Create("DLabel", MainFrame)
		Panel4Text:SetSize(164,90)
		Panel4Text:SetPos(188, 166)
		Panel4Text:SetText("Nom: "..P4Name.."\nRC: "..P4RC.."\nKagune: "..P4Kagune.."\nType: "..P4Type.."\nEfficacité: "..P4Efficacite.."")
		Panel4Text:SetColor( Color(255, 255, 255, 255) )

		local Button4 = vgui.Create("DButton", MainFrame)
		Button4:SetSize( 156, 22)
		Button4:SetPos( 188, 264)
		Button4:SetText( "Remplacer" )
		Button4.DoClick = function()
			net.Start( "ReturnQuinque")
			local SendToS = {}
			SendToS.Ent = tab.Ent
			SendToS.Num = 4
			net.WriteTable( SendToS )
			net.SendToServer()
			MainFrame:Close()
		end

		local Panel5 = vgui.Create("DPanel", MainFrame)
		Panel5:SetSize(164, 128)
		Panel5:SetPos(358, 22)
		Panel5:SetText( "")
		Panel5.Paint = function(self, w, h)
			draw.RoundedBox(8, 0, 0, w, h, Color( 50, 50, 50, 230) )
		end

		local Panel5Text = vgui.Create("DLabel", MainFrame)
		Panel5Text:SetSize(164,90)
		Panel5Text:SetPos(362, 26)
		Panel5Text:SetText("Nom: "..P5Name.."\nRC: "..P5RC.."\nKagune: "..P5Kagune.."\nType: "..P5Type.."\nEfficacité: "..P5Efficacite.."")
		Panel5Text:SetColor( Color(255, 255, 255, 255) )

		local Button5 = vgui.Create("DButton", MainFrame)
		Button5:SetSize( 156, 22)
		Button5:SetPos( 362, 124)
		Button5:SetText( "Remplacer" )
		Button5.DoClick = function()
			net.Start( "ReturnQuinque")
			local SendToS = {}
			SendToS.Ent = tab.Ent
			SendToS.Num = 5
			net.WriteTable( SendToS )
			net.SendToServer()
			MainFrame:Close()
		end

		local Panel6 = vgui.Create("DPanel", MainFrame)
		Panel6:SetSize(164, 128)
		Panel6:SetPos(358, 162)
		Panel6:SetText( "")
		Panel6.Paint = function(self, w, h)
			draw.RoundedBox(8, 0, 0, w, h, Color( 50, 50, 50, 230) )
		end

		local Panel6Text = vgui.Create("DLabel", MainFrame)
		Panel6Text:SetSize(164,90)
		Panel6Text:SetPos(362, 166)
		Panel6Text:SetText("Nom: "..P6Name.."\nRC: "..P6RC.."\nKagune: "..P6Kagune.."\nType: "..P6Type.."\nEfficacité: "..P6Efficacite.."")
		Panel6Text:SetColor( Color(255, 255, 255, 255) )

		local Button6 = vgui.Create("DButton", MainFrame)
		Button6:SetSize( 156, 22)
		Button6:SetPos( 362, 264)
		Button6:SetText( "Remplacer" )
		Button6.DoClick = function()
			net.Start( "ReturnQuinque")
			local SendToS = {}
			SendToS.Ent = tab.Ent
			SendToS.Num = 6
			net.WriteTable( SendToS )
			net.SendToServer()
			MainFrame:Close()
		end

	end)
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
if (SERVER) then
	net.Receive("ReturnQuinque", function(len, ply)
		local tab = net.ReadTable()
		local NPC = tab.Ent
		if !sql.TableExists( "TKGQuinque" ) then 
			sql.Query( "CREATE TABLE TKGQuinque( Name varchar(255), SteamID64 int, RC int, Kagune int, Type int, Damage float, Num int)" )
		end
		local Name = NPC:GetNWString("QuinqueName")
		local RC = NPC:GetNWInt("QuinqueRC")
		local Kagune = NPC:GetNWInt("QuinqueKagune")
		local Type = NPC:GetNWString("QuinqueType")
		local Damage = 1
		if Kagune <= RINKAKUCHANCE then
			if Type == "Armure" then
				Damage = RC * RINKAKUQKQADMG
			elseif Type == "Corp à corp" then
				Damage = RC * RINKAKUQKQCACDMG
			elseif Type == "À distance" then
				Damage = RC * RINKAKUQKQDDMG
			end
		elseif Kagune <= KOUKAKUCHANCE then
			if Type == "Armure" then
				Damage = RC * KOUKAKUQKQADMG
			elseif Type == "Corp à corp" then
				Damage = RC * KOUKAKUQKQCACDMG
			elseif Type == "À distance" then
				Damage = RC * KOUKAKUQKQDDMG
			end
		elseif Kagune <= BIKAKUCHANCE then
			if Type == "Armure" then
				Damage = RC * BIKAKUQKQADMG
			elseif Type == "Corp à corp" then
				Damage = RC * BIKAKUQKQCACDMG
			elseif Type == "À distance" then
				Damage = RC * BIKAKUQKQDDMG
			end
		elseif Kagune <= UKAKUCHANCE then
			if Type == "Armure" then
				Damage = RC * UKAKUQKQADMG
			elseif Type == "Corp à corp" then
				Damage = RC * UKAKUQKQCACDMG
			elseif Type == "À distance" then
				Damage = RC * UKAKUQKQDDMG
			end
		end
		if !(sql.Query("SELECT * FROM TKGQuinque WHERE SteamID64 = '".. ply:SteamID64() .."' AND Num = '".. tab.Num.."'") ) then
			sql.Query( "INSERT INTO TKGQuinque ('Name', 'SteamID64', 'RC', 'Kagune', 'Type', 'Dmg', 'Num') VALUES ('".. Name.."', '".. ply:SteamID64() .."', '".. RC.."', '".. Kagune.."', '".. Type.."', '".. Damage .."', '".. tab.Num .."')")
			ply:PrintMessage( HUD_PRINTTALK, "Cette quinque a bien était enregistré !")
		else
			sql.Query("UPDATE TKGQuinque SET Name = '"..Name.."', RC = '"..RC.."', Kagune = '"..Kagune.."', Type = '"..Type.."', Dmg = '"..Damage.."'  WHERE SteamID64 = '"..ply:SteamID64().."' AND Num = '"..tonumber( tab.Num ).."'")
			ply:PrintMessage( HUD_PRINTTALK, "Cette quinque a bien remplacée!")
		end
		NPC:Remove()
	end)
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */