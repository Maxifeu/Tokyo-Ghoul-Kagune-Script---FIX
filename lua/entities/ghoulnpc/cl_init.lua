/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
include('shared.lua')

local function Draw3DText( pos, ang, scale, text, flipView )
	if ( flipView ) then
		ang:RotateAroundAxis( Vector( 0, 0, 1 ), 180 )
	end

	cam.Start3D2D( pos, ang, scale )
		draw.DrawText( text, "Default", 0, 0, Color( 255, 0, 0), TEXT_ALIGN_CENTER )
	cam.End3D2D()
end

function ENT:Draw()
	self:DrawModel()

	local text = "GHOULIFICATION"

	local mins, maxs = self:GetModelBounds()
	local pos = self:GetPos() + Vector( 0, 0, maxs.z + 5 )

	local ang = Angle( 0, SysTime() * 100 % 360, 90 )

	Draw3DText( pos, ang, 0.2, text, false )
	Draw3DText( pos, ang, 0.2, text, true )
end

function NPCGhoulificationMenu()


	local MainFrame = vgui.Create('DFrame')
	MainFrame:SetSize(400, 250)
	MainFrame:Center()
	MainFrame:ShowCloseButton(false)
	MainFrame:SetTitle('Scientifique')
	MainFrame:SetSizable(true)
	MainFrame:SetDeleteOnClose(false)
	MainFrame:MakePopup()
	MainFrame.Paint = function(pan, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(50, 50, 50))
        draw.RoundedBox(0, 0, 0, w, 40, Color(50, 50, 50))
        surface.SetDrawColor(25, 25, 25)
        surface.DrawOutlinedRect(0, 0, w, h, 5)
	end
	
	local Dialogue1 = vgui.Create( "DLabel", MainFrame )
		Dialogue1:SetPos( 50, 25 )
		Dialogue1:SetSize( 300, 100 )
		Dialogue1:SetText( "Bonjour, je cherche des personnes qui seraient volontaires\npour utiliser un produit pharmaceutique qui est encore en test.\n\nSeriez-vous volontaire?" )
		Dialogue1:SetColor( Color( 250, 250, 250 ) )
		Dialogue1:SetContentAlignment( 5 )
		
	local OuiButton = vgui.Create( "DButton", MainFrame )
		OuiButton:SetPos( 40, 150 )
		OuiButton:SetSize( 150, 50 )
		OuiButton:SetText( "Oui, je suis Volontaire !" )
		OuiButton.DoClick = function()
			NPCGhoulificationMenuVerif()
			MainFrame:Close()
		end
		
	local NonButton = vgui.Create( "DButton", MainFrame )
		NonButton:SetPos( 210, 150 )
		NonButton:SetSize( 150, 50 )
		NonButton:SetText( "Non, dégage maintenant !" )
		NonButton.DoClick = function()
			chat.AddText(Color(255,255,128), "Scientifique:",Color(255,255,255), " Parle mieux tocard." )
			MainFrame:Close()
		end

	local CloseFrame = vgui.Create("DImageButton", MainFrame)
		CloseFrame:SetPos(365, 12)
		CloseFrame:SetSize(25, 25)
		CloseFrame:SetImage("nano/npc/croix.png")
		CloseFrame.DoClick = function()
			MainFrame:Close()
		end
	
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 * Edited by LUCASWWW#1560
 */
function NPCGhoulificationMenuVerif()


	local MainFrame = vgui.Create('DFrame')
	MainFrame:SetSize(400, 250)
	MainFrame:Center()
	MainFrame:SetTitle('Scientifique')
	MainFrame:ShowCloseButton(false)
	MainFrame:SetSizable(true)
	MainFrame:SetDeleteOnClose(false)
	MainFrame:MakePopup()
	MainFrame.Paint = function(pan, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(50, 50, 50))
        draw.RoundedBox(0, 0, 0, w, 40, Color(50, 50, 50))
        surface.SetDrawColor(25, 25, 25)
        surface.DrawOutlinedRect(0, 0, w, h, 5)
	end
	
	local Dialogue1 = vgui.Create( "DLabel", MainFrame )
		Dialogue1:SetPos( 50, 25 )
		Dialogue1:SetSize( 300, 100 )
		Dialogue1:SetText( "Êtes-vous sûr de votre choix ? Pas de retour en arrière." )
		Dialogue1:SetColor( Color( 250, 250, 250 ) )
		Dialogue1:SetContentAlignment( 5 )
		
	local OuiButton = vgui.Create( "DButton", MainFrame )
		OuiButton:SetPos( 40, 150 )
		OuiButton:SetSize( 150, 50 )
		OuiButton:SetText( "Oui, je suis sûr !" )
		OuiButton.DoClick = function()
			NPCGhoulificationMenuTraitement()
			RunConsoleCommand("CkqljKVXgWIIVFdJvQbTmbNWndlbKu")
			MainFrame:Close()
		end
		
	local NonButton = vgui.Create( "DButton", MainFrame )
		NonButton:SetPos( 210, 150 )
		NonButton:SetSize( 150, 50 )
		NonButton:SetText( "Finalement, je vais un peu réfléchir !" )
		NonButton.DoClick = function()
			chat.AddText(Color(255,255,128), "Scientifique:",Color(255,255,255), " D'accord, revenez me voir quand vous serez sûr de votre choix." )
			MainFrame:Close()
		end

	local CloseFrame = vgui.Create("DImageButton", MainFrame)
		CloseFrame:SetPos(365, 12)
		CloseFrame:SetSize(25, 25)
		CloseFrame:SetImage("nano/npc/croix.png")
		CloseFrame.DoClick = function()
			MainFrame:Close()
		end
	
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function NPCGhoulificationMenuTraitement()


	local MainFrame = vgui.Create('DFrame')
	MainFrame:SetSize(400, 250)
	MainFrame:Center()
	MainFrame:SetTitle('Scientifique')
	MainFrame:ShowCloseButton(false)
	MainFrame:SetSizable(true)
	MainFrame:SetDeleteOnClose(false)
	MainFrame:MakePopup()
	MainFrame.Paint = function(pan, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(50, 50, 50))
        draw.RoundedBox(0, 0, 0, w, 40, Color(50, 50, 50))
        surface.SetDrawColor(25, 25, 25)
        surface.DrawOutlinedRect(0, 0, w, h, 5)
	end
	
	local Dialogue1 = vgui.Create( "DLabel", MainFrame )
		Dialogue1:SetPos( 50, 25 )
		Dialogue1:SetSize( 300, 100 )
		Dialogue1:SetText( "L'injection que je viens de vous faire va peu à peut prendre\neffet, amusez-vous bien avec votre nouveau corps !" )
		Dialogue1:SetColor( Color( 250, 250, 250 ) )
		Dialogue1:SetContentAlignment( 5 )
		
	local OuiButton = vgui.Create( "DButton", MainFrame )
		OuiButton:SetPos( 40, 150 )
		OuiButton:SetSize( 310, 50 )
		OuiButton:SetText( "Fermer le dialogue" )
		OuiButton.DoClick = function()
			MainFrame:Close()
		end

	local CloseFrame = vgui.Create("DImageButton", MainFrame)
		CloseFrame:SetPos(365, 12)
		CloseFrame:SetSize(25, 25)
		CloseFrame:SetImage("nano/npc/croix.png")
		CloseFrame.DoClick = function()
			MainFrame:Close()
		end
	
		
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function NPCGhoulificationMenuRappel()


	local MainFrame = vgui.Create('DFrame')
	MainFrame:SetSize(400, 250)
	MainFrame:Center()
	MainFrame:SetTitle('Scientifique')
	MainFrame:SetSizable(true)
	MainFrame:ShowCloseButton(false)
	MainFrame:SetDeleteOnClose(false)
	MainFrame:MakePopup()
	MainFrame.Paint = function(pan, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(50, 50, 50))
        draw.RoundedBox(0, 0, 0, w, 40, Color(50, 50, 50))
        surface.SetDrawColor(25, 25, 25)
        surface.DrawOutlinedRect(0, 0, w, h, 5)
	end
	
	local Dialogue1 = vgui.Create( "DLabel", MainFrame )
		Dialogue1:SetPos( 50, 25 )
		Dialogue1:SetSize( 300, 100 )
		Dialogue1:SetText( "Alors, comment se passe le traitement ?" )
		Dialogue1:SetColor( Color( 250, 250, 250 ) )
		Dialogue1:SetContentAlignment( 5 )
		
	local OuiButton = vgui.Create( "DButton", MainFrame )
		OuiButton:SetPos( 40, 150 )
		OuiButton:SetSize( 310, 50 )
		OuiButton:SetText( "Bien" )
		OuiButton.DoClick = function()
			MainFrame:Close()
		end

	local CloseFrame = vgui.Create("DImageButton", MainFrame)
		CloseFrame:SetPos(365, 12)
		CloseFrame:SetSize(25, 25)
		CloseFrame:SetImage("nano/npc/croix.png")
		CloseFrame.DoClick = function()
			MainFrame:Close()
		end
		
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function NPCGhoulificationRefuseMenu()

	local MainFrame = vgui.Create('DFrame')
	MainFrame:SetSize(400, 250)
	MainFrame:Center()
	MainFrame:SetTitle('Scientifique')
	MainFrame:SetSizable(true)
	MainFrame:SetDeleteOnClose(false)
	MainFrame:MakePopup()
	MainFrame:ShowCloseButton(false)
	MainFrame.Paint = function(pan, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(50, 50, 50))
        draw.RoundedBox(0, 0, 0, w, 40, Color(50, 50, 50))
        surface.SetDrawColor(25, 25, 25)
        surface.DrawOutlinedRect(0, 0, w, h, 5)
	end
	
	local Dialogue1 = vgui.Create( "DLabel", MainFrame )
		Dialogue1:SetPos( 50, 25 )
		Dialogue1:SetSize( 300, 100 )
		Dialogue1:SetText( "Je n'ai rien pour toi, va-t'en !" )
		Dialogue1:SetColor( Color( 250, 250, 250 ) )
		Dialogue1:SetContentAlignment( 5 )
		
	local OuiButton = vgui.Create( "DButton", MainFrame )
		OuiButton:SetPos( 40, 150 )
		OuiButton:SetSize( 310, 50 )
		OuiButton:SetText( "Fermer le dialogue" )
		OuiButton.DoClick = function()
			MainFrame:Close()
		end

	local CloseFrame = vgui.Create("DImageButton", MainFrame)
		CloseFrame:SetPos(365, 12)
		CloseFrame:SetSize(25, 25)
		CloseFrame:SetImage("nano/npc/croix.png")
		CloseFrame.DoClick = function()
			MainFrame:Close()
		end
	
end

net.Receive( "GhoulificationEnCour", function()

		NPCGhoulificationMenuRappel()

end )
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
net.Receive( "GhoulificationNPCUsed", function()

		NPCGhoulificationMenu()

end )
 
 net.Receive( "GhoulificationNPCRefuse", function()

		NPCGhoulificationRefuseMenu()

end )
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */