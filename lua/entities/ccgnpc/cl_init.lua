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
		draw.DrawText( text, "Default", 0, 0, Color( 0, 60, 255), TEXT_ALIGN_CENTER )
	cam.End3D2D()
end

function ENT:Draw()
	self:DrawModel()

	local text = "QUINQUES CCG"

	local mins, maxs = self:GetModelBounds()
	local pos = self:GetPos() + Vector( 0, 0, maxs.z + 5 )

	local ang = Angle( 0, SysTime() * 100 % 360, 90 )

	Draw3DText( pos, ang, 0.2, text, false )
	Draw3DText( pos, ang, 0.2, text, true )
end

function Dryze( Data )
    local ScrH = ScrH()
    local ScrW = ScrW()

    local Frame = vgui.Create("DFrame")
    Frame:SetTitle("  Stock de Quinques ")
    Frame:ShowCloseButton(false)
    Frame:SetSize( 800, 500)
    Frame:SetSizable(false)
    Frame:SetDraggable(false)
    Frame:MakePopup()
    Frame:Center()
    Frame.Paint = function(pan, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(50, 50, 50))
        draw.RoundedBox(0, 0, 0, w, 40, Color(50, 50, 50))
        surface.SetDrawColor(25, 25, 25)
        surface.DrawOutlinedRect(0, 0, w, h, 5)
	end
    
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

    if Data.Result > 0 then
        for i=1, Data.Result do
            if tonumber(Data[i]["Num"]) == 1 then P1Name, P1RC, P1Kagune, P1Type, P1Efficacite = Data[i]["Name"], Data[i]["RC"], Data[i]["Kagune"], Data[i]["Type"], Data[i]["Dmg"] end
            if tonumber(Data[i]["Num"]) == 2 then P2Name, P2RC, P2Kagune, P2Type, P2Efficacite = Data[i]["Name"], Data[i]["RC"], Data[i]["Kagune"], Data[i]["Type"], Data[i]["Dmg"] end
            if tonumber(Data[i]["Num"]) == 3 then P3Name, P3RC, P3Kagune, P3Type, P3Efficacite = Data[i]["Name"], Data[i]["RC"], Data[i]["Kagune"], Data[i]["Type"], Data[i]["Dmg"] end
            if tonumber(Data[i]["Num"]) == 4 then P4Name, P4RC, P4Kagune, P4Type, P4Efficacite = Data[i]["Name"], Data[i]["RC"], Data[i]["Kagune"], Data[i]["Type"], Data[i]["Dmg"] end
            if tonumber(Data[i]["Num"]) == 5 then P5Name, P5RC, P5Kagune, P5Type, P5Efficacite = Data[i]["Name"], Data[i]["RC"], Data[i]["Kagune"], Data[i]["Type"], Data[i]["Dmg"] end
            if tonumber(Data[i]["Num"]) == 6 then P6Name, P6RC, P6Kagune, P6Type, P6Efficacite = Data[i]["Name"], Data[i]["RC"], Data[i]["Kagune"], Data[i]["Type"], Data[i]["Dmg"] end
        end
    end

    local QuinquePanel = vgui.Create("DPanel", Frame )
    QuinquePanel:SetText("")
    QuinquePanel:SetSize(780, 110)
    QuinquePanel:SetPos( 10, 25)
    QuinquePanel.Paint = function(pan, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(50, 50, 50))
        draw.RoundedBox(0, 0, 0, w, 40, Color(50, 50, 50))
        surface.SetDrawColor(25, 25, 25)
        surface.DrawOutlinedRect(0, 0, w, h, 5)
	end

    local QuinquePanel = vgui.Create("DPanel", Frame )
    QuinquePanel:SetText("")
    QuinquePanel:SetSize(780, 20)
    QuinquePanel:SetPos( 10, 25)
    QuinquePanel.Paint = function( self, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color( 255, 255, 255, 255) )
    end

    local QuinqueCategoryName = vgui.Create("DLabel", Frame)
    QuinqueCategoryName:SetText("Quinque")
    QuinqueCategoryName:SetSize(780,20)
    QuinqueCategoryName:SetPos(20, 25)
    QuinqueCategoryName:SetTextColor( Color(0, 0, 0, 255 ) )




    local Quinque1 = vgui.Create("DButton", Frame)
    Quinque1:SetSize(125, 80)
    Quinque1:SetPos( 14.285, 50 )
    if P1Type == "Unknown" then
        Quinque1:SetText( "Aucune Quinque")
    else
        Quinque1:SetText("Nom: "..P1Name.."\nRC: "..P1RC.."\nKagune: "..P1Kagune.."\nType: "..P1Type.."\nEfficacité: "..P1Efficacite.."")
    end
    Quinque1.DoClick = function()
        local ReturnTab = {}
        ReturnTab.Type = "Quinque"
        ReturnTab.Num = 1
        net.Start("CCGNpcReturn")
        net.WriteTable(ReturnTab)
        net.SendToServer()
    end

    local Quinque2 = vgui.Create("DButton", Frame)
    Quinque2:SetSize(125, 80)
    Quinque2:SetPos( 143.57, 50 )
    if P2Type == "Unknown" then
        Quinque2:SetText( "Aucune Quinque")
    else
        Quinque2:SetText("Nom: "..P2Name.."\nRC: "..P2RC.."\nKagune: "..P2Kagune.."\nType: "..P2Type.."\nEfficacité: "..P2Efficacite.."")
    end
    Quinque2.DoClick = function()
        local ReturnTab = {}
        ReturnTab.Type = "Quinque"
        ReturnTab.Num = 2
        net.Start("CCGNpcReturn")
        net.WriteTable(ReturnTab)
        net.SendToServer()
    end

    local Quinque3 = vgui.Create("DButton", Frame)
    Quinque3:SetSize(125, 80)
    Quinque3:SetPos( 272.855, 50 )
    if P3Type == "Unknown" then
        Quinque3:SetText( "Aucune Quinque")
    else
        Quinque3:SetText("Nom: "..P3Name.."\nRC: "..P3RC.."\nKagune: "..P3Kagune.."\nType: "..P3Type.."\nEfficacité: "..P3Efficacite.."")
    end
    Quinque3.DoClick = function()
        local ReturnTab = {}
        ReturnTab.Type = "Quinque"
        ReturnTab.Num = 3
        net.Start("CCGNpcReturn")
        net.WriteTable(ReturnTab)
        net.SendToServer()
    end

    local Quinque4 = vgui.Create("DButton", Frame)
    Quinque4:SetSize(125, 80)
    Quinque4:SetPos( 402.14, 50 )
    if P4Type == "Unknown" then
        Quinque4:SetText( "Aucune Quinque")
    else
        Quinque4:SetText("Nom: "..P4Name.."\nRC: "..P4RC.."\nKagune: "..P4Kagune.."\nType: "..P4Type.."\nEfficacité: "..P4Efficacite.."")
    end
    Quinque4.DoClick = function()
        local ReturnTab = {}
        ReturnTab.Type = "Quinque"
        ReturnTab.Num = 4
        net.Start("CCGNpcReturn")
        net.WriteTable(ReturnTab)
        net.SendToServer()
    end

    local Quinque5 = vgui.Create("DButton", Frame)
    Quinque5:SetSize(125, 80)
    Quinque5:SetPos( 531.425, 50 )
    if P5Type == "Unknown" then
        Quinque5:SetText( "Aucune Quinque")
    else
        Quinque5:SetText("Nom: "..P5Name.."\nRC: "..P5RC.."\nKagune: "..P5Kagune.."\nType: "..P5Type.."\nEfficacité: "..P5Efficacite.."")
    end
    Quinque5.DoClick = function()
        local ReturnTab = {}
        ReturnTab.Type = "Quinque"
        ReturnTab.Num = 5
        net.Start("CCGNpcReturn")
        net.WriteTable(ReturnTab)
        net.SendToServer()
    end

    local Quinque6 = vgui.Create("DButton", Frame)
    Quinque6:SetSize(125, 80)
    Quinque6:SetPos( 660.71, 50 )
    if P6Type == "Unknown" then
        Quinque6:SetText( "Aucune Quinque")
    else
        Quinque6:SetText("Nom: "..P6Name.."\nRC: "..P6RC.."\nKagune: "..P6Kagune.."\nType: "..P6Type.."\nEfficacité: "..P6Efficacite.."")
    end
    Quinque6.DoClick = function()
        local ReturnTab = {}
        ReturnTab.Type = "Quinque"
        ReturnTab.Num = 6
        net.Start("CCGNpcReturn")
        net.WriteTable(ReturnTab)
        net.SendToServer()
    end

    local CloseFrame = vgui.Create("DImageButton", Frame)
		CloseFrame:SetPos(765, 12)
		CloseFrame:SetSize(25, 25)
		CloseFrame:SetImage("nano/npc/croix.png")
		CloseFrame.DoClick = function()
			Frame:Close()
		end



    local WeaponPanel = vgui.Create("DPanel", Frame )
    WeaponPanel:SetText("")
    WeaponPanel:SetSize(780, 110)
    WeaponPanel:SetPos( 10, 143.75)
    WeaponPanel.Paint = function(pan, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(50, 50, 50))
        draw.RoundedBox(0, 0, 0, w, 40, Color(50, 50, 50))
        surface.SetDrawColor(25, 25, 25)
        surface.DrawOutlinedRect(0, 0, w, h, 5)
	end

    local WeaponPanel = vgui.Create("DPanel", Frame )
    WeaponPanel:SetText("")
    WeaponPanel:SetSize(780, 20)
    WeaponPanel:SetPos( 10, 143.75)
    WeaponPanel.Paint = function( self, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color( 255, 255, 255, 255) )
    end

    local WeaponCategoryName = vgui.Create("DLabel", Frame)
    WeaponCategoryName:SetText("Armes à feu")
    WeaponCategoryName:SetSize(780,20)
    WeaponCategoryName:SetPos(20, 143.75)
    WeaponCategoryName:SetTextColor( Color(0, 0, 0, 255 ) )





    local AmmoPanel = vgui.Create("DPanel", Frame )
    AmmoPanel:SetText("")
    AmmoPanel:SetSize(780, 110)
    AmmoPanel:SetPos( 10, 262.5)
    AmmoPanel.Paint = function(pan, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(50, 50, 50))
        draw.RoundedBox(0, 0, 0, w, 40, Color(50, 50, 50))
        surface.SetDrawColor(25, 25, 25)
        surface.DrawOutlinedRect(0, 0, w, h, 5)
	end

    local AmmoPanel = vgui.Create("DPanel", Frame )
    AmmoPanel:SetText("")
    AmmoPanel:SetSize(780, 20)
    AmmoPanel:SetPos( 10, 262.5)
    AmmoPanel.Paint = function( self, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color( 255, 255, 255, 255) )
    end

    local AmmoCategoryName = vgui.Create("DLabel", Frame)
    AmmoCategoryName:SetText("Munitions")
    AmmoCategoryName:SetSize(780,20)
    AmmoCategoryName:SetPos(20, 262.5)
    AmmoCategoryName:SetTextColor( Color(0, 0, 0, 255 ) )





     local OtherPanel = vgui.Create("DPanel", Frame )
    OtherPanel:SetText("")
    OtherPanel:SetSize(780, 110)
    OtherPanel:SetPos( 10, 381.25)
    OtherPanel.Paint = function(pan, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(50, 50, 50))
        draw.RoundedBox(0, 0, 0, w, 40, Color(50, 50, 50))
        surface.SetDrawColor(25, 25, 25)
        surface.DrawOutlinedRect(0, 0, w, h, 5)
	end

    local OtherPanel = vgui.Create("DPanel", Frame )
    OtherPanel:SetText("")
    OtherPanel:SetSize(780, 20)
    OtherPanel:SetPos( 10, 381.25)
    OtherPanel.Paint = function( self, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color( 255, 255, 255, 255) )
    end

    local OtherCategoryName = vgui.Create("DLabel", Frame)
    OtherCategoryName:SetText("Autres")
    OtherCategoryName:SetSize(780,20)
    OtherCategoryName:SetPos(20, 381.25)
    OtherCategoryName:SetTextColor( Color(0, 0, 0, 255 ) )
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
net.Receive( "OpenCCGNPC", function()
    local Data = net.ReadTable()
 	Dryze( Data )
end )
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */