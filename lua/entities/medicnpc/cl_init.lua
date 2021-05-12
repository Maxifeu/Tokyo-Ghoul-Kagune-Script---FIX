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
		draw.DrawText( text, "Default", 0, 0, Color( 0, 255, 0, 255 ), TEXT_ALIGN_CENTER )
	cam.End3D2D()
end

function ENT:Draw()
	self:DrawModel()

	local text = "MÉDECIN"

	local mins, maxs = self:GetModelBounds()
	local pos = self:GetPos() + Vector( 0, 0, maxs.z + 5 )

	local ang = Angle( 0, SysTime() * 100 % 360, 90 )

	Draw3DText( pos, ang, 0.2, text, false )
	Draw3DText( pos, ang, 0.2, text, true )
end

function NPCMedicMainDialogue()

	local MainFrame = vgui.Create('DFrame')
	MainFrame:SetSize(500, 300)
	MainFrame:Center()
	MainFrame:SetTitle('Médecin')
	MainFrame:SetSizable(true)
	MainFrame:SetDeleteOnClose(false)
	MainFrame:ShowCloseButton(false)
	MainFrame:MakePopup()
	MainFrame.Paint = function(pan, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(50, 50, 50))
        draw.RoundedBox(0, 0, 0, w, 40, Color(50, 50, 50))
        surface.SetDrawColor(25, 25, 25)
        surface.DrawOutlinedRect(0, 0, w, h, 5)
	end
	
	local Dialogue1 = vgui.Create( "DLabel", MainFrame )
		Dialogue1:SetPos( 100, 50 )
		Dialogue1:SetSize( 300, 100 )
		Dialogue1:SetText( "Bonjour, que puis-je faire pour vous?" )
		Dialogue1:SetColor( Color( 250, 250, 250 ) )
		Dialogue1:SetContentAlignment( 5 )
		
	local OuiButton = vgui.Create( "DButton", MainFrame )
		OuiButton:SetPos( 33.3, 200 )
		OuiButton:SetSize( 200, 75 )
		OuiButton:SetText( "J'aimerais des soins." )
		OuiButton.DoClick = function()
			NPCMedicHealDialogue()
			MainFrame:Close()
		end
		
	local NonButton = vgui.Create( "DButton", MainFrame )
		NonButton:SetPos( 266.6, 200 )
		NonButton:SetSize( 200, 75 )
		NonButton:SetText( "Non, c'est bons désolé." )
		NonButton.DoClick = function()
			chat.AddText(Color(255,255,128), "Médecin:",Color(255,255,255), "N'hésite pas a revenir." )
			MainFrame:Close()
		end
	
	local CloseFrame = vgui.Create("DImageButton", MainFrame)
		CloseFrame:SetPos(460, 12)
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
function NPCMedicHealDialogue()


	local SecondFrame = vgui.Create('DFrame')
	SecondFrame:SetSize(500, 300)
	SecondFrame:Center()
	SecondFrame:ShowCloseButton(false)
	SecondFrame:SetTitle('Médecin')
	SecondFrame:SetSizable(true)
	SecondFrame:SetDeleteOnClose(false)
	SecondFrame:MakePopup()
	SecondFrame.Paint = function(pan, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(50, 50, 50))
        draw.RoundedBox(0, 0, 0, w, 40, Color(50, 50, 50))
        surface.SetDrawColor(25, 25, 25)
        surface.DrawOutlinedRect(0, 0, w, h, 5)
	end
	
	local Dialogue1 = vgui.Create( "DLabel", SecondFrame )
		Dialogue1:SetPos( 100, 50 )
		Dialogue1:SetSize( 300, 100 )
		Dialogue1:SetText( "De quel manière voudrez-vous être soigné ?" )
		Dialogue1:SetColor( Color( 250, 250, 250 ) )
		Dialogue1:SetContentAlignment( 5 )
		
	local TotalButton = vgui.Create( "DButton", SecondFrame )
		TotalButton:SetPos( 12.5, 200 )
		TotalButton:SetSize( 150, 75 )
		TotalButton:SetText( "Je voudrais être \nentièrement soigné.\n\n(+100% HP)" )
		TotalButton.DoClick = function()
			RunConsoleCommand("V2JGC8k2w8qhJx3o5oN2")
			SecondFrame:Close()
		end
		
	local QuartButton = vgui.Create( "DButton", SecondFrame )
		QuartButton:SetPos( 175, 200 )
		QuartButton:SetSize( 150, 75 )
		QuartButton:SetText( "Je voudrais être \npartiellement soigné.\n\n(+25% HP)" )
		QuartButton.DoClick = function()
			RunConsoleCommand("hwO5bV3441Ug8Mv5ydVZ")
			SecondFrame:Close()
		end
	
	local CloseButton = vgui.Create( "DButton", SecondFrame )
		CloseButton:SetPos( 337.5, 200 )
		CloseButton:SetSize( 150, 75 )
		CloseButton:SetText( "Je n'ai pas besoin de soin\nenfaite." )
		CloseButton.DoClick = function()
			chat.AddText(Color(255,255,128), "Médecin:",Color(255,255,255), " N'hésite pas a revenir." )
			SecondFrame:Close()
		end

	local CloseFrame = vgui.Create("DImageButton", SecondFrame)
		CloseFrame:SetPos(460, 12)
		CloseFrame:SetSize(25, 25)
		CloseFrame:SetImage("nano/npc/croix.png")
		CloseFrame.DoClick = function()
			SecondFrame:Close()
		end
	
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
net.Receive( "MedicNPCHeal", function()

		NPCMedicMainDialogue()

end )
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */