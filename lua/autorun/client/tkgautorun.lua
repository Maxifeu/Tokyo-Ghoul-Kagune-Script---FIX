/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 * Enhanced UI by NANO
 */
 local font = "Open Sans" || "Titillium Web"
 surface.CreateFont("font_new_1", {font = font, size = 16})
net.Receive("CCGIndexStart", function()
	
	local ScrW = ScrW()
	local ScrH = ScrH()
	
	local tab = net.ReadTable()
	
	local ID, Alias, Name, Age, Gender, BloodType = tab["SteamID64"], tab["Alias"], tab["Name"], tab["Age"], tab["Gender"], tab["Bloodtype"]
	local Kagune, RC, Hazard, HazardPoint = tab["Kagune"], tab["RC"], tab["Hazard"], tab["HazardPoint"]
	local Status, Affiliation, Ward = tab["Status"], tab["Affiliation"], tab["Ward"]
	
	local DataBrowserFrame = vgui.Create( "DFrame")
	DataBrowserFrame:SetSize(ScrW/2,ScrH/1.4)
	DataBrowserFrame:Center()
	DataBrowserFrame:SetTitle( "" )
	DataBrowserFrame:MakePopup()
	DataBrowserFrame:ShowCloseButton( false )
	DataBrowserFrame:SetDraggable( false )
	DataBrowserFrame:SetText( "" )
	DataBrowserFrame.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, Color(50, 50, 50))
        draw.RoundedBox(0, 0, 0, w, 40, Color(50, 50, 50))
        surface.SetDrawColor(25, 25, 25)
        surface.DrawOutlinedRect(0, 0, w, h, 5)
	end
	
	local DataBrowserIdenInfoLabel = vgui.Create( "DLabel", DataBrowserFrame )
	DataBrowserIdenInfoLabel:SetSize( ScrW/2.3, ScrH/4 )
	DataBrowserIdenInfoLabel:SetPos( ScrW*0.020, ScrH/35 + ScrH/150 )
	DataBrowserIdenInfoLabel:SetText( "" )
	DataBrowserIdenInfoLabel.Paint = function(pan, w, h)
		draw.RoundedBox(0, 0, 0, w, h, (pan:IsDown() and Color( 0, 68, 145, 155) ) or ( pan:IsHovered() and Color( 0, 74, 182, 155) ) or Color( 0, 132, 255, 82))
        draw.RoundedBox(0, 1, 1, w-2, h-2, (pan:IsDown() and Color( 0, 68, 145, 155) ) or ( pan:IsHovered() and Color( 0, 74, 182, 155) ) or Color( 0, 132, 255, 82))
	end
	
local DataBrowserIdenInfoLabelName = vgui.Create( "DLabel", DataBrowserFrame )
	DataBrowserIdenInfoLabelName:SetSize( ScrW/2.3, ScrH/40 )
	DataBrowserIdenInfoLabelName:SetPos( ScrW*0.020, ScrH/35 + ScrH/150 )
	DataBrowserIdenInfoLabelName:SetColor( Color( 0, 0, 0, 255 ) )
	DataBrowserIdenInfoLabelName:SetText( "" )
	DataBrowserIdenInfoLabelName.Paint = function(pan, w, h)
		draw.SimpleText( "Identification", "font_new_1", w / 2, h /2, Color( 255, 255, 255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) -- Buy a spin text
	end
	
	local DataBrowserIdenInfoID = vgui.Create( "DLabel", DataBrowserFrame )
		DataBrowserIdenInfoID:SetPos( ScrW*0.025, ScrH/16.9127516778523489887 + ScrH/150)
		DataBrowserIdenInfoID:SetSize( ScrW/5, ScrH/30)
		DataBrowserIdenInfoID:SetColor( Color( 0, 0, 0, 255 ) )
		DataBrowserIdenInfoID:SetText( "" )
		DataBrowserIdenInfoID:SetContentAlignment( 4 )
		DataBrowserIdenInfoID.Paint = function(pan, w, h)
			draw.SimpleText( "ID", "font_new_1", w / 2, h /2, Color( 255, 255, 255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) -- Buy a spin text
		end
		
	local DataBrowserIdenInfoIDEntry = vgui.Create( "DTextEntry", DataBrowserFrame )
		DataBrowserIdenInfoIDEntry:SetSize( ScrW/3, ScrH/30 )
		DataBrowserIdenInfoIDEntry:SetPos( ScrW/10, ScrH/16.9127516778523489887 + ScrH/150 ) 
		DataBrowserIdenInfoIDEntry:SetText( ID )
		DataBrowserIdenInfoIDEntry:SetEditable ( false )

		
	local DataBrowserIdenInfoAlias = vgui.Create( "DLabel", DataBrowserFrame )
		DataBrowserIdenInfoAlias:SetPos( ScrW*0.025, ScrH/10.723404255319148932500297 + ScrH/150)
		DataBrowserIdenInfoAlias:SetSize( ScrW/5, ScrH/30)
		DataBrowserIdenInfoAlias:SetColor( Color( 0, 0, 0, 255 ) )
		DataBrowserIdenInfoAlias:SetText( "" )
		DataBrowserIdenInfoAlias:SetContentAlignment( 4 )
		DataBrowserIdenInfoAlias.Paint = function(pan, w, h)
			draw.SimpleText( "Alias", "font_new_1", w / 2, h /2, Color( 255, 255, 255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) -- Buy a spin text
		end
		
	local DataBrowserIdenInfoAliasEntry = vgui.Create( "DTextEntry", DataBrowserFrame )
		DataBrowserIdenInfoAliasEntry:SetSize( ScrW/3, ScrH/30 )
		DataBrowserIdenInfoAliasEntry:SetPos( ScrW/10, ScrH/10.723404255319148932500297  + ScrH/150)
		DataBrowserIdenInfoAliasEntry:SetText( Alias )

		
	local DataBrowserIdenInfoName = vgui.Create( "DLabel", DataBrowserFrame )
		DataBrowserIdenInfoName:SetPos( ScrW*0.025, ScrH/7.850467289719626165279150064778 + ScrH/150)
		DataBrowserIdenInfoName:SetSize( ScrW/5, ScrH/30)
		DataBrowserIdenInfoName:SetColor( Color( 0, 0, 0, 255 ) )
		DataBrowserIdenInfoName:SetText( "" )
		DataBrowserIdenInfoName:SetContentAlignment( 4 )
		DataBrowserIdenInfoName.Paint = function(pan, w, h)
			draw.SimpleText( "Nom", "font_new_1", w / 2, h /2, Color( 255, 255, 255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) -- Buy a spin text
		end
		
	local DataBrowserIdenInfoNameEntry = vgui.Create( "DTextEntry", DataBrowserFrame )
		DataBrowserIdenInfoNameEntry:SetSize( ScrW/3, ScrH/30 )
		DataBrowserIdenInfoNameEntry:SetPos( ScrW/10, ScrH/7.850467289719626165279150064778 + ScrH/150 )
		DataBrowserIdenInfoNameEntry:SetText( Name )

		
	local DataBrowserIdenInfoAge = vgui.Create( "DLabel", DataBrowserFrame )
		DataBrowserIdenInfoAge:SetPos( ScrW*0.025, ScrH/6.191646191646191643751117735843801635 + ScrH/150)
		DataBrowserIdenInfoAge:SetSize( ScrW/5, ScrH/30)
		DataBrowserIdenInfoAge:SetColor( Color( 0, 0, 0, 255 ) )
		DataBrowserIdenInfoAge:SetText( "" )
		DataBrowserIdenInfoAge:SetContentAlignment( 4 )
		DataBrowserIdenInfoAge.Paint = function(pan, w, h)
			draw.SimpleText( "Age", "font_new_1", w / 2, h /2, Color( 255, 255, 255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) -- Buy a spin text
		end
		
	local DataBrowserIdenInfoAgeEntry = vgui.Create( "DTextEntry", DataBrowserFrame )
		DataBrowserIdenInfoAgeEntry:SetSize( ScrW/3, ScrH/30 )
		DataBrowserIdenInfoAgeEntry:SetPos( ScrW/10, ScrH/6.191646191646191643751117735843801635  + ScrH/150)
		DataBrowserIdenInfoAgeEntry:SetText( Age )
		DataBrowserIdenInfoAgeEntry:SetNumeric( true )

		
	local DataBrowserIdenInfoGender = vgui.Create( "DLabel", DataBrowserFrame )
		DataBrowserIdenInfoGender:SetPos( ScrW*0.025, ScrH/5.111561866125760647009158243090034919 + ScrH/150)
		DataBrowserIdenInfoGender:SetSize( ScrW/5, ScrH/30)
		DataBrowserIdenInfoGender:SetColor( Color( 0, 0, 0, 255 ) )
		DataBrowserIdenInfoGender:SetText( "" )
		DataBrowserIdenInfoGender:SetContentAlignment( 4 )
		DataBrowserIdenInfoGender.Paint = function(pan, w, h)
			draw.SimpleText( "Sexe", "font_new_1", w / 2, h /2, Color( 255, 255, 255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) -- Buy a spin text
		end
		
	local DataBrowserIdenInfoGenderEntry = vgui.Create( "DComboBox", DataBrowserFrame )
		DataBrowserIdenInfoGenderEntry:SetSize( ScrW/3, ScrH/30 )
		DataBrowserIdenInfoGenderEntry:SetPos( ScrW/10, ScrH/5.111561866125760647009158243090034919  + ScrH/150)
		DataBrowserIdenInfoGenderEntry:SetValue( Gender )
		DataBrowserIdenInfoGenderEntry:AddChoice( "Homme" )
		DataBrowserIdenInfoGenderEntry:AddChoice( "Femme" )
		DataBrowserIdenInfoGenderEntry:AddChoice( "Aséxué" )

		
	local DataBrowserIdenInfoBloodType = vgui.Create( "DLabel", DataBrowserFrame )
		DataBrowserIdenInfoBloodType:SetPos( ScrW*0.025, ScrH/4.352331606217616578503610542340554697 + ScrH/150)
		DataBrowserIdenInfoBloodType:SetSize( ScrW/5, ScrH/30)
		DataBrowserIdenInfoBloodType:SetColor( Color( 0, 0, 0, 255 ) )
		DataBrowserIdenInfoBloodType:SetText( "" )
		DataBrowserIdenInfoBloodType:SetContentAlignment( 4 )
		DataBrowserIdenInfoBloodType.Paint = function(pan, w, h)
			draw.SimpleText( "Groupe Sanguin", "font_new_1", w / 2, h /2, Color( 255, 255, 255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) -- Buy a spin text
		end
		
	local DataBrowserIdenInfoBloodTypeEntry = vgui.Create( "DComboBox", DataBrowserFrame )
		DataBrowserIdenInfoBloodTypeEntry:SetSize( ScrW/3, ScrH/30 )
		DataBrowserIdenInfoBloodTypeEntry:SetPos( ScrW/10, ScrH/4.352331606217616578503610542340554697  + ScrH/150)
		DataBrowserIdenInfoBloodTypeEntry:SetValue( BloodType )
		DataBrowserIdenInfoBloodTypeEntry:AddChoice( "A" )
		DataBrowserIdenInfoBloodTypeEntry:AddChoice( "B" )
		DataBrowserIdenInfoBloodTypeEntry:AddChoice( "AB" )
		DataBrowserIdenInfoBloodTypeEntry:AddChoice( "O" )


		
	local DataBrowserPotenInfoLabel = vgui.Create( "DLabel", DataBrowserFrame )
		DataBrowserPotenInfoLabel:SetSize( ScrW/2.3, ScrH/7 )
		DataBrowserPotenInfoLabel:SetPos( ScrW*0.020, ScrH/3.5443037740347980419 + ScrH/80)
		DataBrowserPotenInfoLabel:SetText( "" )
		DataBrowserPotenInfoLabel.Paint = function(pan, w, h)
			draw.RoundedBox(0, 0, 0, w, h, (pan:IsDown() and Color( 0, 68, 145, 155) ) or ( pan:IsHovered() and Color( 0, 74, 182, 155) ) or Color( 0, 132, 255, 82))
			draw.RoundedBox(0, 1, 1, w-2, h-2, (pan:IsDown() and Color( 0, 68, 145, 155) ) or ( pan:IsHovered() and Color( 0, 74, 182, 155) ) or Color( 0, 132, 255, 82))
		end

	local DataBrowserPotenInfoLabelName = vgui.Create( "DLabel", DataBrowserFrame )
		DataBrowserPotenInfoLabelName:SetSize( ScrW/2.3, ScrH/40 )
		DataBrowserPotenInfoLabelName:SetPos( ScrW*0.020, ScrH/3.5443037740347980419 + ScrH/80 )
		DataBrowserPotenInfoLabelName:SetColor( Color( 0, 0, 0, 255 ) )
		DataBrowserPotenInfoLabelName:SetText( "     Potentiel combatif" )
		DataBrowserPotenInfoLabelName.Paint = function(pan, w, h)
			draw.RoundedBox(0, 0, 0, w, h, (pan:IsDown() and Color( 0, 68, 145, 155) ) or ( pan:IsHovered() and Color( 0, 74, 182, 155) ) or Color( 0, 132, 255, 82))
			draw.RoundedBox(0, 1, 1, w-2, h-2, (pan:IsDown() and Color( 0, 68, 145, 155) ) or ( pan:IsHovered() and Color( 0, 74, 182, 155) ) or Color( 0, 132, 255, 82))
		end

	local DataBrowserIdenInfoHazard = vgui.Create( "DLabel", DataBrowserFrame )
		DataBrowserIdenInfoHazard:SetPos( ScrW*0.025, ScrH/3.1979695240695539908348429 + ScrH/80)
		DataBrowserIdenInfoHazard:SetSize( ScrW/5, ScrH/30)
		DataBrowserIdenInfoHazard:SetColor( Color( 0, 0, 0, 255 ) )
		DataBrowserIdenInfoHazard:SetText( "" )
		DataBrowserIdenInfoHazard:SetContentAlignment( 4 )
		DataBrowserIdenInfoHazard.Paint = function(pan, w, h)
			draw.SimpleText( "Dangerosité", "font_new_1", w / 2, h /2, Color( 255, 255, 255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) -- Buy a spin text
		end
		
	local DataBrowserIdenInfoHazardEntry = vgui.Create( "DTextEntry", DataBrowserFrame )
		DataBrowserIdenInfoHazardEntry:SetSize( ScrW/3, ScrH/30 )
		DataBrowserIdenInfoHazardEntry:SetPos( ScrW/10, ScrH/3.1979695240695539908348429  + ScrH/80)
		DataBrowserIdenInfoHazardEntry:SetEditable ( false )
		DataBrowserIdenInfoHazardEntry:SetText( Hazard )

	local DataBrowserIdenInfoKagune = vgui.Create( "DLabel", DataBrowserFrame )
		DataBrowserIdenInfoKagune:SetPos( ScrW*0.025, ScrH/2.8832951790000538388828353646232 + ScrH/80)
		DataBrowserIdenInfoKagune:SetSize( ScrW/5, ScrH/30)
		DataBrowserIdenInfoKagune:SetColor( Color( 0, 0, 0, 255 ) )
		DataBrowserIdenInfoKagune:SetText( "" )
		DataBrowserIdenInfoKagune:SetContentAlignment( 4 )
		DataBrowserIdenInfoKagune.Paint = function(pan, w, h)
			draw.SimpleText( "Kagune", "font_new_1", w / 2, h /2, Color( 255, 255, 255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) -- Buy a spin text
		end
		
	local DataBrowserIdenInfoKaguneEntry = vgui.Create( "DTextEntry", DataBrowserFrame )
		DataBrowserIdenInfoKaguneEntry:SetSize( ScrW/3, ScrH/30 )
		DataBrowserIdenInfoKaguneEntry:SetPos( ScrW/10, ScrH/2.8832951790000538388828353646232  + ScrH/80)
		DataBrowserIdenInfoKaguneEntry:SetText( Kagune )
		
	local DataBrowserIdenInfoRC = vgui.Create( "DLabel", DataBrowserFrame )
		DataBrowserIdenInfoRC:SetPos( ScrW*0.025, ScrH/2.6249999871460993060132894206253 + ScrH/80)
		DataBrowserIdenInfoRC:SetSize( ScrW/5, ScrH/30)
		DataBrowserIdenInfoRC:SetColor( Color( 0, 0, 0, 255 ) )
		DataBrowserIdenInfoRC:SetText( "" )
		DataBrowserIdenInfoRC:SetContentAlignment( 4 )
		DataBrowserIdenInfoRC.Paint = function(pan, w, h)
			draw.SimpleText( "RC", "font_new_1", w / 2, h /2, Color( 255, 255, 255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) -- Buy a spin text
		end
		
	local DataBrowserIdenInfoRCEntry = vgui.Create( "DTextEntry", DataBrowserFrame )
		DataBrowserIdenInfoRCEntry:SetSize( ScrW/3, ScrH/30 )
		DataBrowserIdenInfoRCEntry:SetPos( ScrW/10, ScrH/2.6249999871460993060132894206253 + ScrH/80 )
		DataBrowserIdenInfoRCEntry:SetText( RC )



	local DataBrowserIdenInfoLabel = vgui.Create( "DLabel", DataBrowserFrame )
		DataBrowserIdenInfoLabel:SetSize( ScrW/2.3, ScrH/7 )
		DataBrowserIdenInfoLabel:SetPos( ScrW*0.020, ScrH/2.3333333231771648784979915 + ScrH/50)
		DataBrowserIdenInfoLabel:SetText( "" )
		DataBrowserIdenInfoLabel.Paint = function(pan, w, h)
			draw.RoundedBox(0, 0, 0, w, h, (pan:IsDown() and Color( 0, 68, 145, 155) ) or ( pan:IsHovered() and Color( 0, 74, 182, 155) ) or Color( 0, 132, 255, 82))
			draw.RoundedBox(0, 1, 1, w-2, h-2, (pan:IsDown() and Color( 0, 68, 145, 155) ) or ( pan:IsHovered() and Color( 0, 74, 182, 155) ) or Color( 0, 132, 255, 82))
		end
		
	local DataBrowserAffiInfoLabelName = vgui.Create( "DLabel", DataBrowserFrame )
		DataBrowserAffiInfoLabelName:SetSize( ScrW/2.3, ScrH/40 )
		DataBrowserAffiInfoLabelName:SetPos( ScrW*0.020, ScrH/2.3333333231771648784979915 + ScrH/50 )
		DataBrowserAffiInfoLabelName:SetColor( Color( 0, 0, 0, 255 ) )
		DataBrowserAffiInfoLabelName:SetText( "" )
		DataBrowserAffiInfoLabelName.Paint = function(pan, w, h)
			draw.SimpleText( "Affiliation", "font_new_1", w / 2, h /2, Color( 255, 255, 255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) -- Buy a spin text
		end

		
	local DataBrowserAffiInfoWard = vgui.Create( "DLabel", DataBrowserFrame )
		DataBrowserAffiInfoWard:SetPos( ScrW*0.025, ScrH/2.1780466635793588243426436065505 + ScrH/50)
		DataBrowserAffiInfoWard:SetSize( ScrW/5, ScrH/30)
		DataBrowserAffiInfoWard:SetColor( Color( 0, 0, 0, 255 ) )
		DataBrowserAffiInfoWard:SetText( "Ward" )
		DataBrowserAffiInfoWard:SetContentAlignment( 4 )
		DataBrowserAffiInfoWard.Paint = function(pan, w, h)
			draw.SimpleText( "Ward", "font_new_1", w / 2, h /2, Color( 255, 255, 255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) -- Buy a spin text
		end
		
	local DataBrowserAffiInfoWardEntry = vgui.Create( "DTextEntry", DataBrowserFrame )
		DataBrowserAffiInfoWardEntry:SetSize( ScrW/3, ScrH/30 )
		DataBrowserAffiInfoWardEntry:SetPos( ScrW/10, ScrH/2.1780466635793588243426436065505 + ScrH/50 )
		DataBrowserAffiInfoWardEntry:SetText( Ward )
		DataBrowserAffiInfoWardEntry:SetNumeric( true )

		
	local DataBrowserAffiInfoAffi = vgui.Create( "DLabel", DataBrowserFrame )
		DataBrowserAffiInfoAffi:SetPos( ScrW*0.025, ScrH/2.0273531701284846677462170008395 + ScrH/50)
		DataBrowserAffiInfoAffi:SetSize( ScrW/5, ScrH/30)
		DataBrowserAffiInfoAffi:SetColor( Color( 0, 0, 0, 255 ) )
		DataBrowserAffiInfoAffi:SetText( "" )
		DataBrowserAffiInfoAffi:SetContentAlignment( 4 )
		DataBrowserAffiInfoAffi.Paint = function(pan, w, h)
			draw.SimpleText( "Affiliation", "font_new_1", w / 2, h /2, Color( 255, 255, 255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) -- Buy a spin text
		end
		
	local DataBrowserAffiInfoAffiEntry = vgui.Create( "DTextEntry", DataBrowserFrame )
		DataBrowserAffiInfoAffiEntry:SetSize( ScrW/3, ScrH/30 )
		DataBrowserAffiInfoAffiEntry:SetPos( ScrW/10, ScrH/2.0273531701284846677462170008395 + ScrH/50 )
		DataBrowserAffiInfoAffiEntry:SetText( Affiliation )

		
	local DataBrowserAffiInfoStatus = vgui.Create( "DLabel", DataBrowserFrame )
		DataBrowserAffiInfoStatus:SetPos( ScrW*0.025, ScrH/1.8961625215097175891720148983066 + ScrH/50)
		DataBrowserAffiInfoStatus:SetSize( ScrW/5, ScrH/30)
		DataBrowserAffiInfoStatus:SetColor( Color( 0, 0, 0, 255 ) )
		DataBrowserAffiInfoStatus:SetText( "" )
		DataBrowserAffiInfoStatus:SetContentAlignment( 4 )
		DataBrowserAffiInfoStatus.Paint = function(pan, w, h)
			draw.SimpleText( "Status", "font_new_1", w / 2, h /2, Color( 255, 255, 255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) -- Buy a spin text
		end
		
	local DataBrowserAffiInfoStatusEntry = vgui.Create( "DTextEntry", DataBrowserFrame )
		DataBrowserAffiInfoStatusEntry:SetSize( ScrW/3, ScrH/30 )
		DataBrowserAffiInfoStatusEntry:SetPos( ScrW/10, ScrH/1.8961625215097175891720148983066 + ScrH/50 )
		DataBrowserAffiInfoStatusEntry:SetText( Status )
		
	local DataBrowserCloseButton = vgui.Create( "DButton", DataBrowserFrame )
		DataBrowserCloseButton:SetSize( ScrW/5.12, ScrH/12.5 )
		DataBrowserCloseButton:SetPos( ScrW/51.2, ScrH/1.6646848937604422450972378486175032467 )
		DataBrowserCloseButton:SetText( "" )
		DataBrowserCloseButton:SetColor( Color( 255, 255, 255, 255 ) )
		DataBrowserCloseButton.Paint = function(pan, w, h)
			draw.SimpleText( "Fermer", "font_new_1", w / 2, h /2, Color( 255, 255, 255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) -- Name of the button for start a spin
			draw.RoundedBox(0, 0, 0, w, h, (pan:IsDown() and Color( 0, 68, 145, 155) ) or ( pan:IsHovered() and Color( 0, 74, 182, 155) ) or Color( 0, 132, 255, 82))
			draw.RoundedBox(0, 1, 1, w-2, h-2, (pan:IsDown() and Color( 0, 68, 145, 155) ) or ( pan:IsHovered() and Color( 0, 74, 182, 155) ) or Color( 0, 132, 255, 82))
		end
		DataBrowserCloseButton.DoClick = function()
			DataBrowserFrame:Close()
		end

	local DataBrowserSaveButton = vgui.Create( "DButton", DataBrowserFrame )
		DataBrowserSaveButton:SetSize( ScrW/5.12, ScrH/12.5 )
		DataBrowserSaveButton:SetPos( ScrW/3.8540084830078022727, ScrH/1.6646848937604422450972378486175032467 )
		DataBrowserSaveButton:SetText( "" )
		DataBrowserSaveButton:SetColor( Color( 255, 255, 255, 255 ) )
		DataBrowserSaveButton.Paint = function(pan, w, h)
			draw.SimpleText( "Sauvegarder", "font_new_1", w / 2, h /2, Color( 255, 255, 255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) -- Name of the button for start a spin
			draw.RoundedBox(0, 0, 0, w, h, (pan:IsDown() and Color( 81, 255, 0) ) or ( pan:IsHovered() and Color( 81, 255, 0) ) or Color( 81, 255, 0))
			draw.RoundedBox(0, 1, 1, w-2, h-2, (pan:IsDown() and Color( 81, 255, 0) ) or ( pan:IsHovered() and Color( 81, 255, 0) ) or Color( 81, 255, 0))
		end
		DataBrowserSaveButton.DoClick = function()
			local SaveTab = {Mode = "Sauvegarder",
									ID = DataBrowserIdenInfoIDEntry:GetValue(),
									Alias = DataBrowserIdenInfoAliasEntry:GetValue(), 
									Name = DataBrowserIdenInfoNameEntry:GetValue(), 
									Age = DataBrowserIdenInfoAgeEntry:GetValue(), 
									Gender = DataBrowserIdenInfoGenderEntry:GetValue(), 
									BloodType = DataBrowserIdenInfoBloodTypeEntry:GetValue(), 
									Kagune = DataBrowserIdenInfoKaguneEntry:GetValue(), 
									RC = DataBrowserIdenInfoRCEntry:GetValue(), 
									Status = DataBrowserAffiInfoStatusEntry:GetValue(), 
									Affiliation = DataBrowserAffiInfoAffiEntry:GetValue(), 
									Ward = DataBrowserAffiInfoWardEntry:GetValue()}
			
			net.Start( "CCGIndexReturn" )
			net.WriteTable( SaveTab )
			net.SendToServer()
			DataBrowserFrame:Close()
		end
end )


/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */


net.Receive( "CivilData", function()
	local Frame = vgui.Create('DFrame')
	Frame:SetSize((ScrW()/4), ScrH()-(ScrH()/20))
	Frame:Center()
	Frame:SetTitle( "Identitée" )
	Frame:SetSizable(false)
	Frame:MakePopup()
	Frame:ShowCloseButton( false )
	Frame:SetDraggable( false )
	Frame.Paint = function(pan, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(50, 50, 50))
        draw.RoundedBox(0, 0, 0, w, 40, Color(50, 50, 50))
        surface.SetDrawColor(25, 25, 25)
        surface.DrawOutlinedRect(0, 0, w, h, 5)
	end
	
	local Text = vgui.Create( "DLabel", Frame )
		Text:SetPos( 0, ScrH()/20*0.5)
		Text:SetSize( ScrW()/5, ScrH()/15 )
		Text:CenterHorizontal()
		Text:SetText( "" )
		Text:SetContentAlignment( 5 )
		Text.Paint = function(pan, w, h)
			draw.SimpleText( "Vos informations nous sont essentielles !", "font_new_1", w / 2, h /2, Color( 255, 255, 255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) -- Name of the button for start a spin
			draw.RoundedBox(0, 0, 0, w, h, (pan:IsDown() and Color( 0, 68, 145, 155) ) or ( pan:IsHovered() and Color( 0, 74, 182, 155) ) or Color( 0, 132, 255, 82))
			draw.RoundedBox(0, 1, 1, w-2, h-2, (pan:IsDown() and Color( 0, 68, 145, 155) ) or ( pan:IsHovered() and Color( 0, 74, 182, 155) ) or Color( 0, 132, 255, 82))
		end
	
	local NameText = vgui.Create( "DLabel", Frame )
		NameText:SetPos( 0, ScrH()/20*1.5)
		NameText:SetSize( ScrW()/5, ScrH()/15 )
		NameText:CenterHorizontal()
		NameText:SetText( "" )
		NameText:SetContentAlignment( 5 )
		NameText.Paint = function(pan, w, h)
			draw.SimpleText( "Nom", "font_new_1", w / 2, h /2, Color( 255, 255, 255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) -- Name of the button for start a spin

		end
	
	local nameEntry = vgui.Create( "DTextEntry", Frame )
		nameEntry:SetPos( 0, ScrH()/20*2.5)
		nameEntry:SetSize( ScrW()/5, ScrH()/20 )
		nameEntry:CenterHorizontal()
		nameEntry:SetText( LocalPlayer():GetName() )
		
	
	local  AdresseText = vgui.Create( "DLabel", Frame )
		AdresseText:SetPos( 0, ScrH()/20*3.5)
		AdresseText:SetSize( ScrW()/5, ScrH()/15 )
		AdresseText:CenterHorizontal()
		AdresseText:SetText( "" )
		AdresseText:SetContentAlignment( 5 )
		AdresseText.Paint = function(pan, w, h)
			draw.SimpleText( "Adresse", "font_new_1", w / 2, h /2, Color( 255, 255, 255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) -- Name of the button for start a spin
		end
	
	local AdresseEntry = vgui.Create( "DTextEntry", Frame )
		AdresseEntry:SetPos( 0, ScrH()/20*4.5 )
		AdresseEntry:SetSize( ScrW()/5, ScrH()/20 )
		AdresseEntry:CenterHorizontal()
		AdresseEntry:SetText( "Sans domicile fixe" )
	
	local  JobText = vgui.Create( "DLabel", Frame )
		JobText:SetPos( 0, ScrH()/20*5.5)
		JobText:SetSize( ScrW()/5, ScrH()/15 )
		JobText:CenterHorizontal()
		JobText:SetText( "" )
		JobText:SetContentAlignment( 5 )
		JobText.Paint = function(pan, w, h)
			draw.SimpleText( "Métier", "font_new_1", w / 2, h /2, Color( 255, 255, 255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) -- Name of the button for start a spin
		end
	
	local JobEntry = vgui.Create( "DTextEntry", Frame )
		JobEntry:SetPos( 0, ScrH()/20*6.5 )
		JobEntry:SetSize( ScrW()/5, ScrH()/20 )
		JobEntry:CenterHorizontal()
		JobEntry:SetText( "Chomeur" )
	
	local  BloodTypeText = vgui.Create( "DLabel", Frame )
		BloodTypeText:SetPos( 0, ScrH()/20*7.5)
		BloodTypeText:SetSize( ScrW()/5, ScrH()/15 )
		BloodTypeText:CenterHorizontal()
		BloodTypeText:SetText( "" )
		BloodTypeText:SetContentAlignment( 5 )
		BloodTypeText.Paint = function(pan, w, h)
			draw.SimpleText( "Groupe Sanguin", "font_new_1", w / 2, h /2, Color( 255, 255, 255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) -- Name of the button for start a spin
		end
	
	local BloodTypeEntry = vgui.Create( "DComboBox", Frame )
		BloodTypeEntry:SetPos( 0, ScrH()/20*8.5 )
		BloodTypeEntry:SetSize( ScrW()/5, ScrH()/20 )
		BloodTypeEntry:CenterHorizontal()
		BloodTypeEntry:SetValue( "A" )
		BloodTypeEntry:AddChoice( "A" )
		BloodTypeEntry:AddChoice( "B" )
		BloodTypeEntry:AddChoice( "AB" )
		BloodTypeEntry:AddChoice( "O" )
	
	local  AgeText = vgui.Create( "DLabel", Frame )
		AgeText:SetPos( 0, ScrH()/20*9.5)
		AgeText:SetSize( ScrW()/5, ScrH()/15 )
		AgeText:CenterHorizontal()
		AgeText:SetText( "" )
		AgeText:SetContentAlignment( 5 )
		AgeText.Paint = function(pan, w, h)
			draw.SimpleText( "Age", "font_new_1", w / 2, h /2, Color( 255, 255, 255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) -- Name of the button for start a spin
		end
	
	local AgeEntry = vgui.Create( "DNumSlider", Frame )
		AgeEntry:SetPos( 0, ScrH()/20*10.5 )
		AgeEntry:SetSize( ScrW()/2.5, ScrH()/15 )
		AgeEntry:CenterHorizontal(0.20)
		AgeEntry:SetMin( 15 )
		AgeEntry:SetMax( 80 )
		AgeEntry:SetValue( 18 )
		AgeEntry:SetDecimals( 0 )
		AgeEntry.Slider.Paint = function(self, w, h)
			surface.SetDrawColor(25, 25, 25)
        	surface.DrawOutlinedRect(0, 0, w, h, 5)
		end
	
	local  StatusText = vgui.Create( "DLabel", Frame )
		StatusText:SetPos( 0, ScrH()/20*11.5)
		StatusText:SetSize( ScrW()/5, ScrH()/15 )
		StatusText:CenterHorizontal()
		StatusText:SetText( "" )
		StatusText:SetContentAlignment( 5 )
		StatusText.Paint = function(pan, w, h)
			draw.SimpleText( "Status", "font_new_1", w / 2, h /2, Color( 255, 255, 255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) -- Name of the button for start a spin
		end
	
	local StatusEntry = vgui.Create( "DTextEntry", Frame )
		StatusEntry:SetPos( 0, ScrH()/20*12.5 )
		StatusEntry:SetSize( ScrW()/5, ScrH()/20 )
		StatusEntry:CenterHorizontal()
		StatusEntry:SetText( "Vivant - En bonne santé" )
	
	local  GenderText = vgui.Create( "DLabel", Frame )
		GenderText:SetPos( 0, ScrH()/20*13.5)
		GenderText:SetSize( ScrW()/5, ScrH()/15 )
		GenderText:CenterHorizontal()
		GenderText:SetText( "" )
		GenderText:SetContentAlignment( 5 )
		GenderText.Paint = function(pan, w, h)
			draw.SimpleText( "Sexe", "font_new_1", w / 2, h /2, Color( 255, 255, 255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) -- Name of the button for start a spin
		end
	
	local GenderEntry = vgui.Create( "DComboBox", Frame )
		GenderEntry:SetPos( 0, ScrH()/20*14.5 )
		GenderEntry:SetSize( ScrW()/5, ScrH()/20 )
		GenderEntry:CenterHorizontal()
		GenderEntry:SetValue( "Homme" )
		GenderEntry:AddChoice( "Homme" )
		GenderEntry:AddChoice( "Femme" )
		GenderEntry:AddChoice( "Aséxué" )
	
	
	local FinishButton = vgui.Create( "DButton", Frame )
		FinishButton:SetPos( 0, ScrH()/20*16.5 )
		FinishButton:SetSize( ScrW()/5, ScrH()/20 )
		FinishButton:CenterHorizontal()
		FinishButton:SetText( "" )
		FinishButton.Paint = function(pan, w, h)
			draw.SimpleText( "Sauvegarder", "font_new_1", w / 2, h /2, Color( 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) -- Name of the button for start a spin
			draw.RoundedBox(0, 0, 0, w, h, (pan:IsDown() and Color( 81, 255, 0, 110) ) or ( pan:IsHovered() and Color( 81, 255, 0, 110) ) or Color( 81, 255, 0, 110))
			draw.RoundedBox(0, 1, 1, w-2, h-2, (pan:IsDown() and Color( 81, 255, 0, 110) ) or ( pan:IsHovered() and Color( 81, 255, 0, 110) ) or Color( 81, 255, 0, 110))
		end
		FinishButton.DoClick = function()
			net.Start( "CivilDataReturn" )
			local tab = {SteamID64 = LocalPlayer():SteamID64(),
						Name = nameEntry:GetValue(),
						Adresse = AdresseEntry:GetValue(),
						Job = JobEntry:GetValue(),
						BloodType = BloodTypeEntry:GetValue(),
						Age = AgeEntry:GetValue(),
						Status = StatusEntry:GetValue(),
						Gender = GenderEntry:GetValue()}
			net.WriteTable( tab )
			net.SendToServer()
			Frame:Close()
			
		end
end )

net.Receive( "TKGMenu", function()
	local ScrW = ScrW()
	local ScrH = ScrH()
	local Data = net.ReadTable()
	local DataCCG = Data.DataCCG
	local DataGhoul = Data.DataGhoul
	local CCGComputerLine = 0
	local GhoulLine = 0
	local GhoulNum = 1
	local GhoulMaxNum = 1
	local GhoulRCEditButtonTimer = 1
	local GhoulKaguneEditButtonTimer = 1
	local CCGComputerNum = 0
	local CCGComputerNumMin = 1
	local CCGComputerNumMax = 1
	local CCGComputerSearchButtonTimer = 1
	local CCGComputerCreateButtonTimer = 1
	local CCGComputerEditButtonTimer = 1
	local CCGComputerRemoveButtonTimer = 1
	local RCSearchButtonTimer = 1
	local CCGComputerCreateUsername = {}
	local GhoulEntry = 0
	local RCEntry = 0
	
	local CCGComputerSteamID64 = 1
	
	local TKGMenu = vgui.Create( "DFrame" )
	TKGMenu:SetTitle( "" )
	TKGMenu:MakePopup()
	TKGMenu:ShowCloseButton(false)
	TKGMenu:SetSizable(false)
	TKGMenu:SetSize( 640, 500 )
	TKGMenu:GetBackgroundBlur()
	TKGMenu:Center()
	TKGMenu.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(25, 25, 25))
        draw.RoundedBox(0, 0, 0, w, 40, Color(25, 25, 25))
        surface.SetDrawColor(124, 0, 0)
        surface.DrawOutlinedRect(0, 0, w, h, 5)
	end

	local Menu = vgui.Create( "DPropertySheet", TKGMenu )
	Menu:Dock( FILL )
	Menu:SizeToContentWidth( false )
	Menu.Paint = function(me, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(25, 25, 25))
		draw.SimpleText( "CCG Computer", "font_new_1", w / 2, h /2, Color( 255, 255, 255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
	
	local CCGComputerFrame = vgui.Create( "DPanel", TKGMenu )
	Menu:AddSheet( "CCG Computer", CCGComputerFrame, "icon16/computer.png", false, false  )
	CCGComputerFrame.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(25, 25, 25))
        draw.RoundedBox(0, 0, 0, w, 40, Color(25, 25, 25))
	end
	
	
	local CCGComputer = vgui.Create( "DListView", CCGComputerFrame )
	CCGComputer:SetSize( 614, 327 )
	CCGComputer:SetPos( 0, 25)
	CCGComputer:SetMultiSelect(false)
	CCGComputer:AddColumn("Num"):SetFixedWidth( 0 )
	CCGComputer:AddColumn("SteamID64"):SetFixedWidth( 160 )
	CCGComputer:AddColumn("Username"):SetFixedWidth( 160 )
	CCGComputer:AddColumn("Password"):SetFixedWidth( 160 )
	CCGComputer:AddColumn("Rang"):SetFixedWidth( 160 )
	CCGComputer.Paint = function(pan, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255))
        draw.RoundedBox(0, 0, 0, w, 40, Color(255, 255, 255))
        surface.SetDrawColor(255, 255, 255)
        surface.DrawOutlinedRect(0, 0, w, h, 5)
	end
	if (DataCCG) and #DataCCG > 0 then
		for i=1, #DataCCG do
			if GhoulEntry < 25 then
				CCGComputer:AddLine( i, DataCCG[i]["SteamID64"], DataCCG[i]["Username"], DataCCG[i]["Password"], DataCCG[i]["Rang"] )
				CCGComputerNumMax = i
				GhoulEntry = GhoulEntry + 1
			end
		end
	end
	
	local CCGComputerSearchEntry = vgui.Create( "DTextEntry", CCGComputerFrame )
	CCGComputerSearchEntry:SetSize( 160, 20)
	CCGComputerSearchEntry:SetPos( 40, 2.5 )
	
	local CCGcomputerSearchType = vgui.Create( "DComboBox", CCGComputerFrame )
	CCGcomputerSearchType:SetSize( 140,20)
	CCGcomputerSearchType:SetPos( 240, 2.5 )
	CCGcomputerSearchType:SetValue( "SteamID64" )
	CCGcomputerSearchType:AddChoice( "SteamID64" )
	CCGcomputerSearchType:AddChoice( "Username" )
	CCGcomputerSearchType:AddChoice( "Password" )
	CCGcomputerSearchType:AddChoice("Rang")
	
	local CCGComputerSearchButton = vgui.Create( "DButton", CCGComputerFrame )
	CCGComputerSearchButton:SetSize( 140, 20 )
	CCGComputerSearchButton:SetPos( 420, 2.5 )
	CCGComputerSearchButton:SetText( "" )
	CCGComputerSearchButton.Paint = function(pan, w, h)
        draw.SimpleText( "Rechercher", "font_new_1", w / 2, h /2, Color( 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) -- Name of the button for start a spin
        draw.RoundedBox(0, 0, 0, w, h, (pan:IsDown() and Color( 0, 68, 145, 155) ) or ( pan:IsHovered() and Color( 0, 74, 182, 155) ) or Color( 0, 132, 255, 82))
        draw.RoundedBox(0, 1, 1, w-2, h-2, (pan:IsDown() and Color( 0, 68, 145, 155) ) or ( pan:IsHovered() and Color( 0, 74, 182, 155) ) or Color( 0, 132, 255, 82))
    end 
	CCGComputerSearchButton.DoClick = function()
		if CCGComputerSearchButtonTimer < CurTime() then
			CCGComputerSearchButtonTimer = CurTime() + 0.25
			CCGComputer:Clear()
			GhoulEntry = 0
			if ( DataCCG ) and #DataCCG > 0 then
				for i=1, #DataCCG do
					if string.match(string.lower( DataCCG[i][CCGcomputerSearchType:GetValue()] ), string.lower( CCGComputerSearchEntry:GetValue() ) ) or DataCCG[i][CCGcomputerSearchType:GetValue()] == "" then
						if GhoulEntry < 25 then
							CCGComputer:AddLine( i, DataCCG[i]["SteamID64"], DataCCG[i]["Username"], DataCCG[i]["Password"], DataCCG[i]["Rang"] )
							CCGComputerNumMax = i
							GhoulEntry = GhoulEntry + 1
						end
					end
				end
			end
		end
	end
	
	local CCGComputerActionSheet = vgui.Create( "DPropertySheet", CCGComputerFrame )
	CCGComputerActionSheet:SetSize( 606, 72.5 )
	CCGComputerActionSheet:SetPos( 4, 355 )

	local CCGComputerCreateFrame = vgui.Create( "DPanel", CCGComputerFrame )
	CCGComputerActionSheet:AddSheet( "Créer", CCGComputerCreateFrame, "icon16/user_add.png", false, false  )
	CCGComputerCreateFrame.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, 40, Color(25, 25, 25))
	end
	CCGComputerActionSheet.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, 40, Color(25, 25, 25))
	end
	
	local CCGComputerCreateUsernameEntry = vgui.Create( "DComboBox", CCGComputerCreateFrame )
	CCGComputerCreateUsernameEntry:SetSize(150,20)
	CCGComputerCreateUsernameEntry:SetPos( 10, 7.5 )
	CCGComputerCreateUsernameEntry:SetValue( "" )
	for i=1, #player.GetAll() do
		CCGComputerCreateUsernameEntry:AddChoice( tostring( player.GetAll()[i] ) )
		CCGComputerCreateUsername[i] = player.GetAll()[i]
	end
	
	local CCGComputerCreatePasswordEntry = vgui.Create( "DTextEntry", CCGComputerCreateFrame )
	CCGComputerCreatePasswordEntry:SetSize(150,20)
	CCGComputerCreatePasswordEntry:SetPos( 200, 7.5 )
	CCGComputerCreatePasswordEntry:SetValue( math.random(1000,9999) )
	
	local CCGComputerCreateRangEntry = vgui.Create( "DTextEntry", CCGComputerCreateFrame )
	CCGComputerCreateRangEntry:SetSize(50,20)
	CCGComputerCreateRangEntry:SetPos( 375, 7.5 )
	CCGComputerCreateRangEntry:SetValue( "0" )
	CCGComputerCreateRangEntry:SetNumeric( true )
	
	local CCGComputerCreateButton = vgui.Create( "DButton", CCGComputerCreateFrame )
		CCGComputerCreateButton:SetSize( 100, 20)
		CCGComputerCreateButton:SetPos( 465, 7.5 )
		CCGComputerCreateButton:SetText( "" )
		CCGComputerCreateButton.Paint = function(pan, w, h)
			draw.RoundedBox(0, 0, 0, w, h, (pan:IsDown() and Color( 29, 145, 0, 155) ) or ( pan:IsHovered() and Color( 29, 145, 0, 155) ) or Color( 29, 145, 0, 155))
			draw.RoundedBox(0, 1, 1, w-2, h-2, (pan:IsDown() and Color( 29, 145, 0, 155) ) or ( pan:IsHovered() and Color( 29, 145, 0, 155) ) or Color( 29, 145, 0, 155))
			draw.SimpleText( "Sauvegarder", "font_new_1", w / 2, h /2, Color( 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end 
		CCGComputerCreateButton.DoClick = function()
			if CCGComputerCreateButtonTimer < CurTime() then
				CCGComputerCreateButtonTimer = CurTime() + 0.25

				if not CCGComputerCreateUsername[CCGComputerCreateUsernameEntry:GetSelectedID()] then
					LocalPlayer():ChatPrint("Utilisateur Invalide")
					return
				end
				local tab = {Mode = "Create", SteamID64 = CCGComputerCreateUsername[CCGComputerCreateUsernameEntry:GetSelectedID()]:SteamID64(), Username = CCGComputerCreateUsername[CCGComputerCreateUsernameEntry:GetSelectedID()]:Nick(), Password = CCGComputerCreatePasswordEntry:GetValue(), Rang = CCGComputerCreateRangEntry:GetValue()}
				CCGComputerCreateUsernameEntry:SetValue( "" )
				CCGComputerCreatePasswordEntry:SetValue( math.random(1000,9999) )
				CCGComputerCreateRangEntry:SetValue( "0" )
				net.Start("TKGMenuReturn")
				net.WriteTable( tab )
				net.SendToServer()
				
				CCGComputerNumMax = CCGComputerNumMax + 1
				CCGComputer:AddLine( CCGComputerNumMax, tab.SteamID64, tab.Username, tab.Password, tab.Rang )
			end
		end
	
	
	local CCGComputerEditFrame = vgui.Create( "DPanel", CCGComputerFrame )
	CCGComputerActionSheet:AddSheet( "Modifier", CCGComputerEditFrame, "icon16/user_edit.png", false, false  )
	CCGComputerEditFrame.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, 40, Color(25, 25, 25))
	end
	
	local CCGComputerEditUsernameEntry = vgui.Create( "DTextEntry", CCGComputerEditFrame )
	CCGComputerEditUsernameEntry:SetSize(150,20)
	CCGComputerEditUsernameEntry:SetPos( 10, 7.5 )
	CCGComputerEditUsernameEntry:SetValue( "" )
	
	local CCGComputerEditPasswordEntry = vgui.Create( "DTextEntry", CCGComputerEditFrame )
	CCGComputerEditPasswordEntry:SetSize(150,20)
	CCGComputerEditPasswordEntry:SetPos( 200, 7.5 )
	CCGComputerEditPasswordEntry:SetValue( "" )
	
	local CCGComputerEditRangEntry = vgui.Create( "DTextEntry", CCGComputerEditFrame )
	CCGComputerEditRangEntry:SetSize(50,20)
	CCGComputerEditRangEntry:SetPos( 375, 7.5 )
	CCGComputerEditRangEntry:SetValue( "" )
	CCGComputerEditRangEntry:SetNumeric( true )
	
	local CCGComputerEditButton = vgui.Create( "DButton", CCGComputerEditFrame )
		CCGComputerEditButton:SetSize( 100, 20)
		CCGComputerEditButton:SetPos( 465, 7.5 )
		CCGComputerEditButton:SetText( "" )
		CCGComputerEditButton.Paint = function(pan, w, h)
			draw.RoundedBox(0, 0, 0, w, h, (pan:IsDown() and Color( 29, 145, 0, 155) ) or ( pan:IsHovered() and Color( 29, 145, 0, 155) ) or Color( 29, 145, 0, 155))
			draw.RoundedBox(0, 1, 1, w-2, h-2, (pan:IsDown() and Color( 29, 145, 0, 155) ) or ( pan:IsHovered() and Color( 29, 145, 0, 155) ) or Color( 29, 145, 0, 155))
			draw.SimpleText( "Modifier", "font_new_1", w / 2, h /2, Color( 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) -- Name of the button for start a spin
		end 
		CCGComputerEditButton.DoClick = function()
			if CCGComputerEditButtonTimer < CurTime() and CCGComputerLine ~= 0 then
				CCGComputerEditButtonTimer = CurTime() + 0.25
				local tab = {Mode = "Edit", SteamID64 = CCGComputerLine:GetValue( 2 ), Username = CCGComputerEditUsernameEntry:GetValue(), Password = CCGComputerEditPasswordEntry:GetValue(), Rang = CCGComputerEditRangEntry:GetValue()}
	
				net.Start("TKGMenuReturn")
				net.WriteTable( tab )
				net.SendToServer()
				
				CCGComputerEditUsernameEntry:SetValue( "" )
				CCGComputerEditPasswordEntry:SetValue( "" )
				CCGComputerEditRangEntry:SetValue( "" )
				
				CCGComputer:RemoveLine( CCGComputerNum )
				CCGComputer:AddLine( CCGComputerNumMax, tab.SteamID64, tab.Username, tab.Password, tab.Rang )
				CCGComputerLine = 0
				
				
			end
		end
	
	CCGComputer.OnClickLine = function(parent, line, isselected)
		CCGComputerLine = line
		CCGComputerNum = line:GetValue( 1 )
		CCGComputerEditUsernameEntry:SetValue( CCGComputerLine:GetValue( 3 ) )
		CCGComputerEditPasswordEntry:SetValue( CCGComputerLine:GetValue( 4 ) )
		CCGComputerEditRangEntry:SetValue( CCGComputerLine:GetValue( 5 ) )
	end
	
	local CCGComputerDeleteFrame = vgui.Create( "DPanel", CCGComputerFrame )
	CCGComputerActionSheet:AddSheet( "Supprimer", CCGComputerDeleteFrame, "icon16/user_delete.png", false, false  )
	
	local CCGComputerDeleteButton = vgui.Create( "DButton", CCGComputerDeleteFrame )
	CCGComputerDeleteButton:Dock( FILL )
	CCGComputerDeleteButton:SetText( "")
	CCGComputerDeleteButton.Paint = function(pan, w, h)
		draw.RoundedBox(0, 0, 0, w, h, (pan:IsDown() and Color( 206, 0, 0, 183) ) or ( pan:IsHovered() and Color( 206, 0, 0, 183) ) or Color( 206, 0, 0, 183))
		draw.RoundedBox(0, 1, 1, w-2, h-2, (pan:IsDown() and Color( 206, 0, 0, 183) ) or ( pan:IsHovered() and Color( 206, 0, 0, 183) ) or Color( 206, 0, 0, 183))
		draw.SimpleText( "Supprimer", "font_new_1", w / 2, h /2, Color( 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) -- Name of the button for start a spin
	end 
	CCGComputerDeleteButton.DoClick = function()
		if CCGComputerRemoveButtonTimer < CurTime() then
			CCGComputerRemoveButtonTimer = CurTime() + 0.25
			if CCGComputerNum ~= 0 then
				local tab = {Mode = "Delete", SteamID64 = CCGComputerLine:GetValue( 2 ), Username = CCGComputerLine:GetValue( 3 ), Password = CCGComputerLine:GetValue( 4 ), Rang = CCGComputerLine:GetValue( 5 )}
				CCGComputer:RemoveLine( CCGComputerNum )
				CCGComputerNum = 0
				CCGComputerNumMax = CCGComputerNumMax-1
				net.Start("TKGMenuReturn")
				net.WriteTable( tab )
				net.SendToServer()
			end
		end
	end
	
	for k,v in pairs(CCGComputerActionSheet.Items) do
		if not IsValid(v.Tab) then continue end
		
		function v.Tab:Paint(w, h)
			if CCGComputerActionSheet:GetActiveTab() == v.Tab then
				
				surface.SetDrawColor(124, 0, 0)
				surface.DrawRect(0, 0, w, h)    
			else
	
				surface.SetDrawColor(65, 65, 65)
				surface.DrawRect(0, 0, w, h)    
			end
		end
	end

	local RCFrame = vgui.Create( "DPanel", TKGMenu )
	Menu:AddSheet( "RC & Kagune", RCFrame, "icon16/user.png", false, false )
	RCFrame.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(25, 25, 25))
        draw.RoundedBox(0, 0, 0, w, 40, Color(25, 25, 25))
	end
	
	local RCEditEntry = vgui.Create( "DTextEntry", RCFrame )
		RCEditEntry:SetSize(150, 20 )
		RCEditEntry:SetPos( 113, 360 )
	
	local KaguneEditEntry = vgui.Create( "DTextEntry", RCFrame )
		KaguneEditEntry:SetSize(150, 20 )
		KaguneEditEntry:SetPos( 376, 360 )
	
	local RCEditButton = vgui.Create( "DButton", RCFrame )
		RCEditButton:SetSize( 150, 20)
		RCEditButton:SetPos( 113, 400)
		RCEditButton:SetText("")
		RCEditButton.Paint = function(pan, w, h)
			draw.RoundedBox(0, 0, 0, w, h, (pan:IsDown() and Color( 145, 0, 0, 155) ) or ( pan:IsHovered() and Color( 145, 0, 0, 155) ) or Color( 145, 0, 0, 155))
			draw.RoundedBox(0, 1, 1, w-2, h-2, (pan:IsDown() and Color( 145, 0, 0, 155) ) or ( pan:IsHovered() and Color( 145, 0, 0, 155) ) or Color( 145, 0, 0, 155))
			draw.SimpleText( "Sauvegarder les RC", "font_new_1", w / 2, h /2, Color( 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) -- Name of the button for start a spin
		end 
		RCEditButton.DoClick = function()
			if GhoulRCEditButtonTimer < CurTime() and GhoulLine ~= 0 then
				GhoulRCEditButtonTimer = CurTime() + 0.25
				local tab = {Mode = "RCEdit", SteamID64 = GhoulLine:GetValue( 3 ), RC = tonumber( RCEditEntry:GetValue() ) }
				
				net.Start("TKGMenuReturn")
				net.WriteTable( tab )
				net.SendToServer()
				
				RCEditEntry:SetValue( "" )
				KaguneEditEntry:SetValue( "" )
				
				CCGComputer:RemoveLine( GhoulNum )
				CCGComputer:AddLine( GhoulMaxNum, tab.SteamID64, tab.RC, KaguneEditEntry:GetValue() )
				GhoulLine = 0
				
			end
		end

		local TKGMenuClose = vgui.Create("DImageButton", TKGMenu)
		TKGMenuClose:SetPos(605, 10)
		TKGMenuClose:SetSize(25, 25)
		TKGMenuClose:SetImage("nano/npc/croix.png")
		TKGMenuClose.DoClick = function()
			TKGMenu:Close()
		end

		
	local KaguneEditButton = vgui.Create( "DButton", RCFrame )
		KaguneEditButton:SetSize( 150, 20)
		KaguneEditButton:SetPos(376, 400 )
		KaguneEditButton:SetText("")
		KaguneEditButton.Paint = function(pan, w, h)
			draw.RoundedBox(0, 0, 0, w, h, (pan:IsDown() and Color( 145, 0, 0, 155) ) or ( pan:IsHovered() and Color( 145, 0, 0, 155) ) or Color( 145, 0, 0, 155))
			draw.RoundedBox(0, 1, 1, w-2, h-2, (pan:IsDown() and Color( 145, 0, 0, 155) ) or ( pan:IsHovered() and Color( 145, 0, 0, 155) ) or Color( 145, 0, 0, 155))
			draw.SimpleText( "Sauvegarder le Kagune", "font_new_1", w / 2, h /2, Color( 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) -- Name of the button for start a spin
		end 
		KaguneEditButton.DoClick = function()
			if GhoulKaguneEditButtonTimer < CurTime() and GhoulLine ~= 0 then
				GhoulKaguneEditButtonTimer = CurTime() + 0.25
				local tab = {Mode = "KaguneEdit", SteamID64 = GhoulLine:GetValue( 3 ), Kagune = tonumber( KaguneEditEntry:GetValue() ) }
				
				net.Start("TKGMenuReturn")
				net.WriteTable( tab )
				net.SendToServer()
				
				RCEditEntry:SetValue( "" )
				KaguneEditEntry:SetValue( "" )
				
				CCGComputer:RemoveLine( GhoulNum )
				CCGComputer:AddLine( GhoulMaxNum, tab.SteamID64, RCEditEntry:GetValue(), tab.Kagune )
				GhoulLine = 0
				
			end
		end

		for k,v in pairs(Menu.Items) do
			if not IsValid(v.Tab) then continue end
			
			function v.Tab:Paint(w, h)
				if Menu:GetActiveTab() == v.Tab then
					
					surface.SetDrawColor(124, 0, 0)
					surface.DrawRect(0, 0, w, h)    
				else
		
					surface.SetDrawColor(65, 65, 65)
					surface.DrawRect(0, 0, w, h)    
				end
			end
		end

	local RC = vgui.Create( "DListView", RCFrame )
	RC:SetSize( 614, 327 )
	RC:SetPos( 0, 25)
	RC:SetMultiSelect(false)
	RC:AddColumn("Num"):SetFixedWidth( 0 )
	RC:AddColumn("Name"):SetFixedWidth( 160 )
	RC:AddColumn("SteamID64"):SetFixedWidth( 160 )
	RC:AddColumn("RC"):SetFixedWidth( 160 )
	RC:AddColumn("Kagune"):SetFixedWidth( 160 )
	for i=1, #DataGhoul do
		if RCEntry < 25 then
			RC:AddLine( i, DataGhoul[i]["Name"], DataGhoul[i]["SteamID64"], DataGhoul[i]["RC"], DataGhoul[i]["Kagune"] )
			GhoulMaxNum = i
			RCEntry = RCEntry + 1
		end
	end
	RC.OnClickLine = function(parent, line, isselected)
		GhoulNum = line:GetValue( 1 )
		GhoulLine = line
		RCEditEntry:SetValue( line:GetValue( 4 ) )
		KaguneEditEntry:SetValue( line:GetValue( 5 ) )
	end
	
	local RCSearchEntry = vgui.Create( "DTextEntry", RCFrame )
	RCSearchEntry:SetSize(160,20)
	RCSearchEntry:SetPos( 40, 2.5 )
	
	local RCSearchType = vgui.Create( "DComboBox", RCFrame )
	RCSearchType:SetSize(140,20)
	RCSearchType:SetPos( 240, 2.5 )
	RCSearchType:SetValue( "Name" )
	RCSearchType:AddChoice( "Name" )
	RCSearchType:AddChoice( "SteamID64" )
	RCSearchType:AddChoice( "RC" )
	RCSearchType:AddChoice("Kagune")
	
	
	local RCSearchButton = vgui.Create( "DButton", RCFrame )
	RCSearchButton:SetSize( 140, 20 )
	RCSearchButton:SetPos( 420, 2.5)
	RCSearchButton:SetText( "" )
	RCSearchButton.Paint = function(pan, w, h)
        draw.RoundedBox(0, 0, 0, w, h, (pan:IsDown() and Color( 145, 0, 0, 155) ) or ( pan:IsHovered() and Color( 145, 0, 0, 155) ) or Color( 145, 0, 0, 155))
        draw.RoundedBox(0, 1, 1, w-2, h-2, (pan:IsDown() and Color( 145, 0, 0, 155) ) or ( pan:IsHovered() and Color( 145, 0, 0, 155) ) or Color( 145, 0, 0, 155))
		draw.SimpleText( "Rechercher", "font_new_1", w / 2, h /2, Color( 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) -- Name of the button for start a spin
    end 
	RCSearchButton.DoClick = function()
		if RCSearchButtonTimer < CurTime() then
			RCSearchButtonTimer = CurTime() + 0.25
			RC:Clear()
			RCEntry = 0
			if ( DataGhoul ) and #DataGhoul > 0 then
				for i=1, #DataGhoul do
					if string.match( string.lower( DataGhoul[i][RCSearchType:GetValue()] ), string.lower( RCSearchEntry:GetValue() ) ) or DataGhoul[i][RCSearchType:GetValue()] == "" then
						if RCEntry < 25 then
							RC:AddLine( i, DataGhoul[i]["SteamID64"], DataGhoul[i]["Name"], DataGhoul[i]["RC"], DataGhoul[i]["Kagune"] )
							RCNumMax = i
							RCEntry = RCEntry + 1
						end
					end
				end
			end
		end
	end
end)

/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 * C-001
 */

 hook.Add( "HUDPaint", "CorpsEatingHUD", function()
	if LocalPlayer():KeyDown( IN_USE ) and LocalPlayer():GetNWInt("CorpsDelay", 0 ) >= CurTime() then
		local ScrW = ScrW()
		local ScrH = ScrH()
		
		local WPos = ScrW/2 - ScrW/6
		local HPos = ScrH/2 - ScrH/20
		
		local W2Long = ScrW/3 - 10
		local H2Long = ScrH/10 - 10
		
		local percents = ( 2 - ( LocalPlayer():GetNWInt("CorpsDelay", 0 ) - CurTime() ) )/2

		draw.RoundedBox( 4, WPos, HPos, ScrW/3, ScrH/10, Color( 50, 50, 50, 100 ) )
		draw.RoundedBox( 4, WPos + 5, HPos + 5, W2Long*percents, H2Long, Color( 138, 28, 0) )

	end
end )

local HumanFoodMaterial = Material( "tkg/vgui/humanfoodicon" )
local GhoulFoodMaterial = Material( "tkg/vgui/ghoulfoodicon" )
hook.Add( "HUDPaint", "FoodHUD", function() 
	local ScrW = ScrW()
	local ScrH = ScrH()
	local size = ScrH/12
	local posX = ScrW - ScrH/11
	local posY = ScrH - ScrH/11
	local Food = LocalPlayer():GetNWInt("TKGFood")
	local MaxFood = LocalPlayer():GetNWInt("TKGMaxFood")
	local percents = Food/MaxFood
	local RedPercents = 255 * (1-percents)
	local GreenPercents = 255 * percents
	draw.RoundedBox( 0, posX, posY, size, size, Color(54,54,54,125) )
	if LocalPlayer():GetNWInt("RCells", 200 ) >= GHOULLIMITRC then
		surface.SetDrawColor( RedPercents, GreenPercents, 0, 255 )
		surface.SetMaterial( GhoulFoodMaterial	)
		surface.DrawTexturedRect( posX, posY, size, size )
	else
		surface.SetDrawColor( RedPercents, GreenPercents, 0, 255 )
		surface.SetMaterial( HumanFoodMaterial	)
		surface.DrawTexturedRect( posX, posY, size, size )
	end
end )
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */