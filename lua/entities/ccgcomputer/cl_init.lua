/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
include('shared.lua')

function CCGComputerLoadingScreen( LoadingDelay )
	local ScrW = ScrW()
	local ScrH = ScrH()

	local Frame = vgui.Create('DFrame')
	Frame:SetSize(ScrW-(ScrW/20), ScrH-(ScrH/20))
	Frame:Center()
	Frame:SetTitle( "Loading Screen" )
	Frame:SetSizable(false)
	Frame:MakePopup()
	Frame:ShowCloseButton( false )
	Frame:SetDraggable( false )
	Frame.Paint = function()
		draw.RoundedBox( 8, 0, 0, Frame:GetWide(), Frame:GetTall(), Color( 44, 44, 44, 250 ) )
	end
	
	local LoadingText = vgui.Create( "DLabel", Frame )
		LoadingText:SetPos( ScrW/2-(ScrW/7.5), ScrH/2.5)
		LoadingText:SetSize( ScrW/5, ScrH/15 )
		LoadingText:SetText( "Chargement en cours . . .\n\n\n Veuillez patienter" )
		LoadingText:SetColor( Color( 250, 250, 250 ) )
		LoadingText:SetContentAlignment( 5 )
	
	timer.Simple( LoadingDelay-CurTime(), function() Frame:Close() end )
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function CCGComputerLoginScreen( PersoInfo )
	local ScrW = ScrW()
	local ScrH = ScrH()
	
	local Frame = vgui.Create('DFrame')
	Frame:SetSize(ScrW-(ScrW/20), ScrH-(ScrH/20))
	Frame:Center()
	Frame:SetTitle( "Écran de Connexion" )
	Frame:SetSizable(false)
	Frame:MakePopup()
	Frame:ShowCloseButton( false )
	Frame:SetDraggable( false )
	Frame.Paint = function()
		draw.RoundedBox( 8, 0, 0, Frame:GetWide(), Frame:GetTall(), Color( 44, 44, 44, 250) )
	end
	
	local UsernameBar = vgui.Create( "DLabel", Frame )
	UsernameBar:SetPos( ScrW/2-(ScrW/7.5), ScrH/2.8 )
	UsernameBar:SetSize(ScrW/5, ScrH/20)
	UsernameBar:SetText( "" )
	UsernameBar.Paint = function( self, w, h )
		draw.RoundedBox( 8, 0, 0, w, h, Color( 0, 81, 187, 175) )
	end
	
	local Username = vgui.Create( "DImage", Frame )
		Username:SetPos( ScrW/2-(ScrW/7.5) + ( (ScrH/20-ScrH/25) / 2 ), ScrH/2.8 + ( (ScrH/20-ScrH/25) / 2 ) )
		Username:SetSize(ScrH/25, ScrH/25)
		Username:SetImage( "tkg/computer/apps/username.png" )
	
	local UsernameEntry = vgui.Create( "DTextEntry", Frame )
		UsernameEntry:SetSize( ScrW/6, ScrH/25 )
		UsernameEntry:SetPos( ScrW/2-(ScrW/7.5) + (ScrW/5 - ( ScrW/6 + (ScrH/20-ScrH/25) / 2 )), ScrH/2.8 + ( (ScrH/20-ScrH/25) / 2 ) )
		UsernameEntry:SetText( PersoInfo.Username )
	
	local PasswordBar = vgui.Create( "DLabel", Frame )
		PasswordBar:SetPos( ScrW/2-(ScrW/7.5), ScrH/2.8 + (ScrH/17.5) )
		PasswordBar:SetSize(ScrW/5, ScrH/20)
		PasswordBar:SetText( "" )
		PasswordBar.Paint = function( self, w, h )
			draw.RoundedBox( 8, 0, 0, w, h, Color( 0, 81, 187, 175 ) )
		end
	
	local Password = vgui.Create( "DImage", Frame )
		Password:SetPos( ScrW/2-(ScrW/7.5) + ( (ScrH/20-ScrH/25) / 2 ), ScrH/2.8 + (ScrH/17.5) + ( (ScrH/20-ScrH/25) / 2 ) )
		Password:SetSize(ScrH/25, ScrH/25)
		Password:SetImage( "tkg/computer/apps/password.png" )
	
	local PasswordEntry = vgui.Create( "DTextEntry", Frame )
		PasswordEntry:SetPos( ScrW/2-(ScrW/7.5) + (ScrW/5 - ( ScrW/6 + (ScrH/20-ScrH/25) / 2 )), ScrH/2.8 + (ScrH/17.5) + ( (ScrH/20-ScrH/25) / 2 ) )
		PasswordEntry:SetSize( ScrW/6, ScrH/25)
		PasswordEntry:SetText( PersoInfo.Password )
	
	local LoginButton = vgui.Create( "DButton", Frame )
		LoginButton:SetPos( ScrW/2-(ScrW/7.5), ScrH/2.8 + ((ScrH/17.5)*2) )
		LoginButton:SetSize( ScrW/5, ScrH/20 )
		LoginButton:SetText( "Se connecter" )
		LoginButton.Paint = function( self, w, h )
			draw.RoundedBox( 8, 0, 0, w, h, Color( 255, 255, 255, 255 ) )
		end
		LoginButton.DoClick = function()
			local LoadingDelay = CurTime()+2
			local PersoInformation = {Verification = "LoginInfo",
								Username = UsernameEntry:GetValue(),
								Password = PasswordEntry:GetValue(),
								Delay = LoadingDelay}
			CCGComputerLoadingScreen(LoadingDelay)
			net.Start( "CCGComputerServerNetWork" )
			net.WriteTable( PersoInformation )
			net.SendToServer()
			Frame:Close()
		end
	
	local CloseButton = vgui.Create( "DButton", Frame )
		CloseButton:SetSize( ScrW/40, ScrH/40 )
		CloseButton:SetPos( Frame:GetWide() - ( CloseButton:GetWide() + 10 ) , Frame:GetTall() - ( CloseButton:GetTall() + 10 ) )
		CloseButton:SetText( "Partir" )
		CloseButton:SetColor( Color( 255, 255, 255, 255 ) )
		CloseButton.Paint = function()
			draw.RoundedBox( 8, 0, 0, CloseButton:GetWide(), CloseButton:GetTall(), Color( 240, 40, 40, 255 ) )
		end
		CloseButton.DoClick = function()
			Frame:Close()	
		end
	
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */

net.Receive( "CCGComputerStart", function()
	local tab = net.ReadTable()
	CCGComputerLoginScreen( tab )
end )




function CCGComputerOffice( SessionInfo )

local SettingTimer = 0
local PasswordChangeTimer = 0
local DataBrowserTimer = 0
local DataBrowserAButtonTimer = 0
local DataBrowserBButtonTimer = 0
local DataBrowserCButtonTimer = 0
local DataBrowserDButtonTimer = 0
local DataBrowserEButtonTimer = 0
local DataBrowserFButtonTimer = 0
local AdminUPTimer = 0
local GhoulData = SessionInfo.GhoulList
local ScrW = ScrW()
local ScrH = ScrH()

local Frame = vgui.Create('DFrame')
	Frame:SetSize(ScrW-(ScrW/20), ScrH-(ScrH/20))
	Frame:Center()
	Frame:SetTitle( "Office Screen" )
	Frame:SetSizable(false)
	Frame:MakePopup()
	Frame:ShowCloseButton( false )
	Frame:SetDraggable( false )
	Frame.Paint = function()
		draw.RoundedBox( 8, 0, 0, Frame:GetWide(), Frame:GetTall(), Color( 80, 80, 80, 250 ) )
	end
	
local WallPaper = vgui.Create( "DImage", Frame )
	WallPaper:SetPos( 5, 5 )
	WallPaper:SetSize(ScrW-(ScrW/20)-10, ScrH-(ScrH/20)-10)
	WallPaper:SetImage( "tkg/computer/wallpaper/wallpaper".. SessionInfo.WallPaper ..".png" )
		
local ToolBar = vgui.Create( "DLabel", Frame )
	ToolBar:SetPos( 5, Frame:GetTall()-( ScrH/22.5)-4.5 )
	ToolBar:SetSize(ScrW-(ScrW/20)-10,ScrH/22.5)
	ToolBar:SetText( "" )
	ToolBar.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 175, 175, 175, 175 ) )
	end

	
	
	
local NumMin, Num, NumMax = 1, 1, 1
local DataBrowserListViewTimer = 0
local ID, Alias, Name, Age, Gender, BloodType = "", "", "", "", "", ""
local Kagune, RC, Hazard, HazardPoint = "", "", "", ""
local Status, Affiliation, Ward = "", "", ""
	
local DataBrowserFrame = vgui.Create( "DFrame")
	DataBrowserFrame:SetVisible( false )
	DataBrowserFrame:SetSize(ScrW-(ScrW/20)-20,ScrH-(ScrH/20)-( ScrH/22.5+20))
	DataBrowserFrame:SetPos( ScrW/40 + 10, ScrH/40 + 10 )
	DataBrowserFrame:SetTitle( "" )
	DataBrowserFrame:MakePopup()
	DataBrowserFrame:ShowCloseButton( false )
	DataBrowserFrame:SetDraggable( false )
	DataBrowserFrame:SetText( "" )
	DataBrowserFrame.Paint = function( self, w, h )
		draw.RoundedBox( 8, 0, 0, w, h, Color( 100, 100, 100, 250 ) )
	end
	
local DataBrowserBar = vgui.Create( "DLabel", DataBrowserFrame )
	DataBrowserBar:SetPos( 0, 0 )
	DataBrowserBar:SetSize(ScrW-(ScrW/20)-20,ScrH/40)
	DataBrowserBar:SetText( "" )
	DataBrowserBar.Paint = function( self, w, h )
		draw.RoundedBox( 8, 0, 0, w, h, Color(240, 240, 240, 225 ) )
	end

local DataBrowser = vgui.Create( "DImage", DataBrowserFrame )
	DataBrowser:SetPos( (ScrH/40 - ScrH/45)/2, (ScrH/40 - ScrH/45)/2 )
	DataBrowser:SetSize(ScrH/45, ScrH/45)
	DataBrowser:SetImage( "tkg/computer/apps/ccgdatabrowser.png" )	

local DataBrowserCloseButton = vgui.Create( "DButton", DataBrowserFrame )
	DataBrowserCloseButton:SetSize( ScrH/45, ScrH/45 )
	DataBrowserCloseButton:SetPos( DataBrowserFrame:GetWide() - ( ScrH/40 + (ScrH/40 - ScrH/45)/2 ), (ScrH/40 - ScrH/45)/2 )
	DataBrowserCloseButton:SetText( "X" )
	DataBrowserCloseButton:SetColor( Color( 255, 255, 255, 255 ) )
	DataBrowserCloseButton.Paint = function(self, w, h)
		draw.RoundedBox( 8, 0, 0, w, h, Color( 240, 40, 40, 255 ) )
	end
	DataBrowserCloseButton.DoClick = function()
		DataBrowserFrame:SetVisible( false )	
		DataBrowserFrame:MoveToBack()
	end 


local DataBrowserIdenInfoLabel = vgui.Create( "DLabel", DataBrowserFrame )
	DataBrowserIdenInfoLabel:SetSize( ScrW/2.14713636, ScrH/4 )
	DataBrowserIdenInfoLabel:SetPos( ScrW*0.46975446, ScrH/35 )
	DataBrowserIdenInfoLabel:SetText( "" )
	DataBrowserIdenInfoLabel.Paint = function( self, w, h )
		draw.RoundedBox( 8, 0, 0, w, h, Color(240, 240, 240, 200 ) )
	end
	
local DataBrowserIdenInfoLabelName = vgui.Create( "DLabel", DataBrowserFrame )
	DataBrowserIdenInfoLabelName:SetSize( ScrW/2.14713636, ScrH/40 )
	DataBrowserIdenInfoLabelName:SetPos( ScrW*0.46975446, ScrH/35 )
	DataBrowserIdenInfoLabelName:SetColor( Color( 0, 0, 0, 255 ) )
	DataBrowserIdenInfoLabelName:SetText( "     Identification" )
	DataBrowserIdenInfoLabelName.Paint = function( self, w, h )
		draw.RoundedBox( 8, 0, 0, w, h, Color(255, 255, 255, 250 ) )
	end

	
local DataBrowserIdenInfoID = vgui.Create( "DLabel", DataBrowserFrame )
	DataBrowserIdenInfoID:SetPos( ScrW/2.0602437523829294, ScrH/16.9127516778523489887)
	DataBrowserIdenInfoID:SetSize( ScrW/6, ScrH/35)
	DataBrowserIdenInfoID:SetColor( Color( 0, 0, 0, 255 ) )
	DataBrowserIdenInfoID:SetText( "ID" )
	DataBrowserIdenInfoID:SetContentAlignment( 4 )
	
local DataBrowserIdenInfoIDEntry = vgui.Create( "DTextEntry", DataBrowserFrame )
	DataBrowserIdenInfoIDEntry:SetSize( ScrW/3, ScrH/35 )
	DataBrowserIdenInfoIDEntry:SetPos( ScrW/1.8356894223500254, ScrH/16.9127516778523489887 )
	DataBrowserIdenInfoIDEntry:SetText( ID )
	DataBrowserIdenInfoIDEntry:SetEditable ( false )

	
local DataBrowserIdenInfoAlias = vgui.Create( "DLabel", DataBrowserFrame )
	DataBrowserIdenInfoAlias:SetPos( ScrW/2.0602437523829294, ScrH/10.723404255319148932500297)
	DataBrowserIdenInfoAlias:SetSize( ScrW/6, ScrH/35)
	DataBrowserIdenInfoAlias:SetColor( Color( 0, 0, 0, 255 ) )
	DataBrowserIdenInfoAlias:SetText( "Alias" )
	DataBrowserIdenInfoAlias:SetContentAlignment( 4 )
	
local DataBrowserIdenInfoAliasEntry = vgui.Create( "DTextEntry", DataBrowserFrame )
	DataBrowserIdenInfoAliasEntry:SetSize( ScrW/3, ScrH/35 )
	DataBrowserIdenInfoAliasEntry:SetPos( ScrW/1.8356894223500254, ScrH/10.723404255319148932500297 )
	DataBrowserIdenInfoAliasEntry:SetText( Alias )

	
local DataBrowserIdenInfoName = vgui.Create( "DLabel", DataBrowserFrame )
	DataBrowserIdenInfoName:SetPos( ScrW/2.0602437523829294, ScrH/7.850467289719626165279150064778)
	DataBrowserIdenInfoName:SetSize( ScrW/6, ScrH/35)
	DataBrowserIdenInfoName:SetColor( Color( 0, 0, 0, 255 ) )
	DataBrowserIdenInfoName:SetText( "Nom" )
	DataBrowserIdenInfoName:SetContentAlignment( 4 )
	
local DataBrowserIdenInfoNameEntry = vgui.Create( "DTextEntry", DataBrowserFrame )
	DataBrowserIdenInfoNameEntry:SetSize( ScrW/3, ScrH/35 )
	DataBrowserIdenInfoNameEntry:SetPos( ScrW/1.8356894223500254, ScrH/7.850467289719626165279150064778 )
	DataBrowserIdenInfoNameEntry:SetText( Name )

	
local DataBrowserIdenInfoAge = vgui.Create( "DLabel", DataBrowserFrame )
	DataBrowserIdenInfoAge:SetPos( ScrW/2.0602437523829294, ScrH/6.191646191646191643751117735843801635)
	DataBrowserIdenInfoAge:SetSize( ScrW/6, ScrH/35)
	DataBrowserIdenInfoAge:SetColor( Color( 0, 0, 0, 255 ) )
	DataBrowserIdenInfoAge:SetText( "Age" )
	DataBrowserIdenInfoAge:SetContentAlignment( 4 )
	
local DataBrowserIdenInfoAgeEntry = vgui.Create( "DTextEntry", DataBrowserFrame )
	DataBrowserIdenInfoAgeEntry:SetSize( ScrW/3, ScrH/35 )
	DataBrowserIdenInfoAgeEntry:SetPos( ScrW/1.8356894223500254, ScrH/6.191646191646191643751117735843801635 )
	DataBrowserIdenInfoAgeEntry:SetText( Age )
	DataBrowserIdenInfoAgeEntry:SetNumeric( true )

	
local DataBrowserIdenInfoGender = vgui.Create( "DLabel", DataBrowserFrame )
	DataBrowserIdenInfoGender:SetPos( ScrW/2.0602437523829294, ScrH/5.111561866125760647009158243090034919)
	DataBrowserIdenInfoGender:SetSize( ScrW/6, ScrH/35)
	DataBrowserIdenInfoGender:SetColor( Color( 0, 0, 0, 255 ) )
	DataBrowserIdenInfoGender:SetText( "Sexe" )
	DataBrowserIdenInfoGender:SetContentAlignment( 4 )
	
local DataBrowserIdenInfoGenderEntry = vgui.Create( "DComboBox", DataBrowserFrame )
	DataBrowserIdenInfoGenderEntry:SetSize( ScrW/3, ScrH/35 )
	DataBrowserIdenInfoGenderEntry:SetPos( ScrW/1.8356894223500254, ScrH/5.111561866125760647009158243090034919 )
	DataBrowserIdenInfoGenderEntry:SetValue( Gender )
	DataBrowserIdenInfoGenderEntry:AddChoice( "Homme" )
	DataBrowserIdenInfoGenderEntry:AddChoice( "Femme" )
	DataBrowserIdenInfoGenderEntry:AddChoice( "Aséxué" )

	
local DataBrowserIdenInfoBloodType = vgui.Create( "DLabel", DataBrowserFrame )
	DataBrowserIdenInfoBloodType:SetPos( ScrW/2.0602437523829294, ScrH/4.352331606217616578503610542340554697)
	DataBrowserIdenInfoBloodType:SetSize( ScrW/6, ScrH/35)
	DataBrowserIdenInfoBloodType:SetColor( Color( 0, 0, 0, 255 ) )
	DataBrowserIdenInfoBloodType:SetText( "Groupe Sanguin" )
	DataBrowserIdenInfoBloodType:SetContentAlignment( 4 )
	
local DataBrowserIdenInfoBloodTypeEntry = vgui.Create( "DComboBox", DataBrowserFrame )
	DataBrowserIdenInfoBloodTypeEntry:SetSize( ScrW/3, ScrH/35 )
	DataBrowserIdenInfoBloodTypeEntry:SetPos( ScrW/1.8356894223500254, ScrH/4.352331606217616578503610542340554697 )
	DataBrowserIdenInfoBloodTypeEntry:SetValue( BloodType )
	DataBrowserIdenInfoBloodTypeEntry:AddChoice( "A" )
	DataBrowserIdenInfoBloodTypeEntry:AddChoice( "B" )
	DataBrowserIdenInfoBloodTypeEntry:AddChoice( "AB" )
	DataBrowserIdenInfoBloodTypeEntry:AddChoice( "O" )


	
local DataBrowserPotenInfoLabel = vgui.Create( "DLabel", DataBrowserFrame )
	DataBrowserPotenInfoLabel:SetSize( ScrW/2.14713636, ScrH/7 )
	DataBrowserPotenInfoLabel:SetPos( ScrW*0.46975446, ScrH/3.5443037740347980419 )
	DataBrowserPotenInfoLabel:SetText( "" )
	DataBrowserPotenInfoLabel.Paint = function( self, w, h )
		draw.RoundedBox( 8, 0, 0, w, h, Color(240, 240, 240, 200 ) )
	end

local DataBrowserPotenInfoLabelName = vgui.Create( "DLabel", DataBrowserFrame )
	DataBrowserPotenInfoLabelName:SetSize( ScrW/2.14713636, ScrH/40 )
	DataBrowserPotenInfoLabelName:SetPos( ScrW*0.46975446, ScrH/3.5443037740347980419 )
	DataBrowserPotenInfoLabelName:SetColor( Color( 0, 0, 0, 255 ) )
	DataBrowserPotenInfoLabelName:SetText( "     Potentiel combatif" )
	DataBrowserPotenInfoLabelName.Paint = function( self, w, h )
		draw.RoundedBox( 8, 0, 0, w, h, Color(255, 255, 255, 250 ) )
	end

local DataBrowserIdenInfoHazard = vgui.Create( "DLabel", DataBrowserFrame )
	DataBrowserIdenInfoHazard:SetPos( ScrW/2.0602437523829294, ScrH/3.1979695240695539908348429)
	DataBrowserIdenInfoHazard:SetSize( ScrW/6, ScrH/35)
	DataBrowserIdenInfoHazard:SetColor( Color( 0, 0, 0, 255 ) )
	DataBrowserIdenInfoHazard:SetText( "Dangerosité" )
	DataBrowserIdenInfoHazard:SetContentAlignment( 4 )
	
local DataBrowserIdenInfoHazardEntry = vgui.Create( "DTextEntry", DataBrowserFrame )
	DataBrowserIdenInfoHazardEntry:SetSize( ScrW/3, ScrH/35 )
	DataBrowserIdenInfoHazardEntry:SetPos( ScrW/1.8356894223500254, ScrH/3.1979695240695539908348429 )
	DataBrowserIdenInfoHazardEntry:SetEditable ( false )
	DataBrowserIdenInfoHazardEntry:SetText( Hazard )

local DataBrowserIdenInfoKagune = vgui.Create( "DLabel", DataBrowserFrame )
	DataBrowserIdenInfoKagune:SetPos( ScrW/2.0602437523829294, ScrH/2.8832951790000538388828353646232)
	DataBrowserIdenInfoKagune:SetSize( ScrW/6, ScrH/35)
	DataBrowserIdenInfoKagune:SetColor( Color( 0, 0, 0, 255 ) )
	DataBrowserIdenInfoKagune:SetText( "Kagune" )
	DataBrowserIdenInfoKagune:SetContentAlignment( 4 )
	
local DataBrowserIdenInfoKaguneEntry = vgui.Create( "DTextEntry", DataBrowserFrame )
	DataBrowserIdenInfoKaguneEntry:SetSize( ScrW/3, ScrH/35 )
	DataBrowserIdenInfoKaguneEntry:SetPos( ScrW/1.8356894223500254, ScrH/2.8832951790000538388828353646232 )
	DataBrowserIdenInfoKaguneEntry:SetText( Kagune )
	
local DataBrowserIdenInfoRC = vgui.Create( "DLabel", DataBrowserFrame )
	DataBrowserIdenInfoRC:SetPos( ScrW/2.0602437523829294, ScrH/2.6249999871460993060132894206253)
	DataBrowserIdenInfoRC:SetSize( ScrW/6, ScrH/35)
	DataBrowserIdenInfoRC:SetColor( Color( 0, 0, 0, 255 ) )
	DataBrowserIdenInfoRC:SetText( "RC" )
	DataBrowserIdenInfoRC:SetContentAlignment( 4 )
	
local DataBrowserIdenInfoRCEntry = vgui.Create( "DTextEntry", DataBrowserFrame )
	DataBrowserIdenInfoRCEntry:SetSize( ScrW/3, ScrH/35 )
	DataBrowserIdenInfoRCEntry:SetPos( ScrW/1.8356894223500254, ScrH/2.6249999871460993060132894206253 )
	DataBrowserIdenInfoRCEntry:SetText( RC )



local DataBrowserIdenInfoLabel = vgui.Create( "DLabel", DataBrowserFrame )
	DataBrowserIdenInfoLabel:SetSize( ScrW/2.14713636, ScrH/7 )
	DataBrowserIdenInfoLabel:SetPos( ScrW*0.46975446, ScrH/2.3333333231771648784979915 )
	DataBrowserIdenInfoLabel:SetText( "" )
	DataBrowserIdenInfoLabel.Paint = function( self, w, h )
		draw.RoundedBox( 8, 0, 0, w, h, Color(240, 240, 240, 200 ) )
	end
	
local DataBrowserAffiInfoLabelName = vgui.Create( "DLabel", DataBrowserFrame )
	DataBrowserAffiInfoLabelName:SetSize( ScrW/2.14713636, ScrH/40 )
	DataBrowserAffiInfoLabelName:SetPos( ScrW*0.46975446, ScrH/2.3333333231771648784979915 )
	DataBrowserAffiInfoLabelName:SetColor( Color( 0, 0, 0, 255 ) )
	DataBrowserAffiInfoLabelName:SetText( "     Affiliation" )
	DataBrowserAffiInfoLabelName.Paint = function( self, w, h )
		draw.RoundedBox( 8, 0, 0, w, h, Color(255, 255, 255, 250 ) )
	end

	
local DataBrowserAffiInfoWard = vgui.Create( "DLabel", DataBrowserFrame )
	DataBrowserAffiInfoWard:SetPos( ScrW/2.0602437523829294, ScrH/2.1780466635793588243426436065505)
	DataBrowserAffiInfoWard:SetSize( ScrW/6, ScrH/35)
	DataBrowserAffiInfoWard:SetColor( Color( 0, 0, 0, 255 ) )
	DataBrowserAffiInfoWard:SetText( "Ward" )
	DataBrowserAffiInfoWard:SetContentAlignment( 4 )
	
local DataBrowserAffiInfoWardEntry = vgui.Create( "DTextEntry", DataBrowserFrame )
	DataBrowserAffiInfoWardEntry:SetSize( ScrW/3, ScrH/35 )
	DataBrowserAffiInfoWardEntry:SetPos( ScrW/1.8356894223500254, ScrH/2.1780466635793588243426436065505 )
	DataBrowserAffiInfoWardEntry:SetText( Ward )
	DataBrowserAffiInfoWardEntry:SetNumeric( true )

	
local DataBrowserAffiInfoAffi = vgui.Create( "DLabel", DataBrowserFrame )
	DataBrowserAffiInfoAffi:SetPos( ScrW/2.0602437523829294, ScrH/2.0273531701284846677462170008395)
	DataBrowserAffiInfoAffi:SetSize( ScrW/6, ScrH/35)
	DataBrowserAffiInfoAffi:SetColor( Color( 0, 0, 0, 255 ) )
	DataBrowserAffiInfoAffi:SetText( "Affiliation" )
	DataBrowserAffiInfoAffi:SetContentAlignment( 4 )
	
local DataBrowserAffiInfoAffiEntry = vgui.Create( "DTextEntry", DataBrowserFrame )
	DataBrowserAffiInfoAffiEntry:SetSize( ScrW/3, ScrH/35 )
	DataBrowserAffiInfoAffiEntry:SetPos( ScrW/1.8356894223500254, ScrH/2.0273531701284846677462170008395 )
	DataBrowserAffiInfoAffiEntry:SetText( Affiliation )

	
local DataBrowserAffiInfoStatus = vgui.Create( "DLabel", DataBrowserFrame )
	DataBrowserAffiInfoStatus:SetPos( ScrW/2.0602437523829294, ScrH/1.8961625215097175891720148983066)
	DataBrowserAffiInfoStatus:SetSize( ScrW/6, ScrH/35)
	DataBrowserAffiInfoStatus:SetColor( Color( 0, 0, 0, 255 ) )
	DataBrowserAffiInfoStatus:SetText( "Status" )
	DataBrowserAffiInfoStatus:SetContentAlignment( 4 )
	
local DataBrowserAffiInfoStatusEntry = vgui.Create( "DTextEntry", DataBrowserFrame )
	DataBrowserAffiInfoStatusEntry:SetSize( ScrW/3, ScrH/35 )
	DataBrowserAffiInfoStatusEntry:SetPos( ScrW/1.8356894223500254, ScrH/1.8961625215097175891720148983066 )
	DataBrowserAffiInfoStatusEntry:SetText( Status )
	
	
local DataBrowserListView = vgui.Create( "DListView", DataBrowserFrame )
	DataBrowserListView:SetSize(ScrW/2.14713636, ScrH/1.17482583)
	DataBrowserListView:SetPos(ScrW/497.77751778, ScrH/35)
	DataBrowserListView:SetMultiSelect(false)
	DataBrowserListView:AddColumn("Num"):SetFixedWidth( 0 )
	DataBrowserListView:AddColumn("ID"):SetFixedWidth( ScrW/13.1 )
	DataBrowserListView:AddColumn("Dangerosité"):SetFixedWidth( ScrW/23.1 )
	DataBrowserListView:AddColumn("Alias"):SetFixedWidth( ScrW/20.1 )
	DataBrowserListView:AddColumn("Nom"):SetFixedWidth( ScrW/20.1 )
	DataBrowserListView:AddColumn("Sexe"):SetFixedWidth( ScrW/32.1 )
	DataBrowserListView:AddColumn("Status"):SetFixedWidth( ScrW/18.1 )
	DataBrowserListView:AddColumn("Affiliation"):SetFixedWidth( ScrW/10.69 )
	DataBrowserListView:AddColumn("Kagune"):SetFixedWidth( ScrW/27.1 )
	DataBrowserListView:AddColumn("Quartier"):SetFixedWidth( ScrW/36.1 )
	if ( GhoulData ) then
		for i=1, #GhoulData do
			DataBrowserListView:AddLine( i, GhoulData[i]["SteamID64"], GhoulData[i]["Hazard"], GhoulData[i]["Alias"], GhoulData[i]["Name"], GhoulData[i]["Gender"], GhoulData[i]["Status"], GhoulData[i]["Affiliation"], GhoulData[i]["Kagune"], GhoulData[i]["Ward"] )
			NumMax = i
		end
	end
	DataBrowserListView.OnClickLine = function(parent, line, isselected)
		if DataBrowserListViewTimer < CurTime() then
			DataBrowserListViewTimer = CurTime() + 0.25
			Num = line:GetValue( 1 )
			ID, Alias, Name, Age, Gender, BloodType = GhoulData[Num]["SteamID64"], GhoulData[Num]["Alias"], GhoulData[Num]["Name"], GhoulData[Num]["Age"], GhoulData[Num]["Gender"], GhoulData[Num]["Bloodtype"]
			Kagune, RC, Hazard, HazardPoint = GhoulData[Num]["Kagune"], GhoulData[Num]["RC"], GhoulData[Num]["Hazard"], GhoulData[Num]["HazardPoint"]
			Status, Affiliation, Ward = GhoulData[Num]["Status"], GhoulData[Num]["Affiliation"], GhoulData[Num]["Ward"]
			
			DataBrowserIdenInfoIDEntry:SetText( ID )
			DataBrowserIdenInfoAliasEntry:SetText( Alias )
			DataBrowserIdenInfoNameEntry:SetText( Name )
			DataBrowserIdenInfoAgeEntry:SetText( Age )
			DataBrowserIdenInfoGenderEntry:SetValue( Gender )
			DataBrowserIdenInfoBloodTypeEntry:SetValue( BloodType )
			
			DataBrowserIdenInfoHazardEntry:SetText( Hazard )
			DataBrowserIdenInfoKaguneEntry:SetText( Kagune )
			DataBrowserIdenInfoRCEntry:SetText( RC )
			
			DataBrowserAffiInfoWardEntry:SetText( Ward )
			DataBrowserAffiInfoAffiEntry:SetText( Affiliation )
			DataBrowserAffiInfoStatusEntry:SetText( Status )
		end
	end

local DataBrowserFinalLabel = vgui.Create( "DLabel", DataBrowserFrame )
	DataBrowserFinalLabel:SetSize( ScrW/2.14713636, ScrH/3.275 )
	DataBrowserFinalLabel:SetPos( ScrW*0.46975446, ScrH/1.73913042914051055474356249826882046633922327 )
	DataBrowserFinalLabel:SetText( "" )
	DataBrowserFinalLabel.Paint = function( self, w, h )
		draw.RoundedBox( 8, 0, 0, w, h, Color(240, 240, 240, 200 ) )
	end
	
local DataBrowserFinalLabelName = vgui.Create( "DLabel", DataBrowserFrame )
	DataBrowserFinalLabelName:SetSize( ScrW/2.14713636, ScrH/40 )
	DataBrowserFinalLabelName:SetPos( ScrW*0.46975446, ScrH/1.73913042914051055474356249826882046633922327 )
	DataBrowserFinalLabelName:SetColor( Color( 0, 0, 0, 255 ) )
	DataBrowserFinalLabelName:SetText( "     Commande" )
	DataBrowserFinalLabelName.Paint = function( self, w, h )
		draw.RoundedBox( 8, 0, 0, w, h, Color(255, 255, 255, 250 ) )
	end
	
local SaveButton = vgui.Create( "DButton", DataBrowserFrame )
	SaveButton:SetSize( ScrW/6.5544989252462448287431, ScrH/7.4175935288169868552 )
	SaveButton:SetPos( ScrW/2.1197066669970986545, ScrH/1.65680472860723273225040190148364381258945303721799 )
	SaveButton:SetText( "Fermer" )
	SaveButton:SetColor( Color( 255, 255, 255, 255 ) )
	SaveButton.Paint = function(self, w, h)
		draw.RoundedBox( 8, 0, 0, w, h, Color( 255, 0, 0, 255 ) )
	end
	SaveButton.DoClick = function()
		if DataBrowserAButtonTimer < CurTime() then
			DataBrowserAButtonTimer = CurTime() + 0.25
			Num = NumMin
			ID, Alias, Name, Age, Gender, BloodType = "", "", "", "", "", ""
			Kagune, RC, Hazard, HazardPoint = "", "", "", ""
			Status, Affiliation, Ward = "", "", ""
			
			DataBrowserIdenInfoIDEntry:SetText( ID )
			DataBrowserIdenInfoAliasEntry:SetText( Alias )
			DataBrowserIdenInfoNameEntry:SetText( Name )
			DataBrowserIdenInfoAgeEntry:SetText( Age )
			DataBrowserIdenInfoGenderEntry:SetValue( Gender )
			DataBrowserIdenInfoBloodTypeEntry:SetValue( BloodType )
			
			DataBrowserIdenInfoHazardEntry:SetText( Hazard )
			DataBrowserIdenInfoKaguneEntry:SetText( Kagune )
			DataBrowserIdenInfoRCEntry:SetText( RC )
			
			DataBrowserAffiInfoWardEntry:SetText( Ward )
			DataBrowserAffiInfoAffiEntry:SetText( Affiliation )
			DataBrowserAffiInfoStatusEntry:SetText( Status )
		end
	end
	
local BButton = vgui.Create( "DButton", DataBrowserFrame )
	BButton:SetSize( ScrW/6.5544989252462448287431, ScrH/7.4175935288169868552 )
	BButton:SetPos( ScrW/2.1197066669970986545, ScrH/1.34778614395662967211275484286360244362979584012558 )
	BButton:SetText( "<" )
	BButton:SetColor( Color( 255, 255, 255, 255 ) )
	BButton.Paint = function(self, w, h)
		draw.RoundedBox( 8, 0, 0, w, h, Color( 25, 25, 25, 255 ) )
	end
	BButton.DoClick = function()
		if Num > NumMin then
			if DataBrowserBButtonTimer < CurTime() then
				DataBrowserBButtonTimer = CurTime() + 0.25
				Num = Num - 1
				ID, Alias, Name, Age, Gender, BloodType = GhoulData[Num]["SteamID64"], GhoulData[Num]["Alias"], GhoulData[Num]["Name"], GhoulData[Num]["Age"], GhoulData[Num]["Gender"], GhoulData[Num]["Bloodtype"]
				Kagune, RC, Hazard, HazardPoint = GhoulData[Num]["Kagune"], GhoulData[Num]["RC"], GhoulData[Num]["Hazard"], tonumber( GhoulData[Num]["HazardPoint"] )
				Status, Affiliation, Ward = GhoulData[Num]["Status"], GhoulData[Num]["Affiliation"], GhoulData[Num]["Ward"]
				
				DataBrowserIdenInfoIDEntry:SetText( ID )
				DataBrowserIdenInfoAliasEntry:SetText( Alias )
				DataBrowserIdenInfoNameEntry:SetText( Name )
				DataBrowserIdenInfoAgeEntry:SetText( Age )
				DataBrowserIdenInfoGenderEntry:SetValue( Gender )
				DataBrowserIdenInfoBloodTypeEntry:SetValue( BloodType )
				
				DataBrowserIdenInfoHazardEntry:SetText( Hazard )
				DataBrowserIdenInfoKaguneEntry:SetText( Kagune )
				DataBrowserIdenInfoRCEntry:SetText( RC )
				
				DataBrowserAffiInfoWardEntry:SetText( Ward )
				DataBrowserAffiInfoAffiEntry:SetText( Affiliation )
				DataBrowserAffiInfoStatusEntry:SetText( Status )
			end
		end
	end 
	
local CButton = vgui.Create( "DButton", DataBrowserFrame )
	CButton:SetSize( ScrW/6.5544989252462448287431, ScrH/7.4175935288169868552 )
	CButton:SetPos( ScrW/1.5965787720623446023750223646186, ScrH/1.65680472860723273225040190148364381258945303721799 )
	CButton:SetText( "Sauvegarder" )
	CButton:SetColor( Color( 255, 255, 255, 255 ) )
	CButton.Paint = function(self, w, h)
		draw.RoundedBox( 8, 0, 0, w, h, Color( 0, 200, 0, 255 ) )
	end
	CButton.DoClick = function()
       if DataBrowserCButtonTimer < CurTime() then
			DataBrowserCButtonTimer = CurTime() + 1.25
			
			HazardPoint = tonumber( GhoulData[Num]["HazardPoint"] )
			local rank = 0
			
			if HazardPoint > 100000 then rank = 3
			elseif HazardPoint < 100000 then rank = 2
			elseif HazardPoint < 10000 then rank = 1
			elseif HazardPoint < 1000 then rank = 0
			else rank = 0
			end
			
			if tonumber( SessionInfo.Rang ) > rank then
				CButton:SetText( "Sauvegarder\n\nVotre demande a bien était pris en compte" )
				timer.Simple(1.20, function() CButton:SetText( "Sauvegarder" ) end)
				
				local SaveTab = {Mode = "Sauvegarder",
									ID = DataBrowserIdenInfoIDEntry:GetValue(),
									Rang = SessionInfo.Rang,
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
			
				net.Start( "CCGComputerDataBrowserResult" )
				net.WriteTable( SaveTab )
				net.SendToServer()	
				
			else
				CButton:SetText( "Sauvegarder\n\nVous n'avez pas la permission nécessaire" )
				timer.Simple(1.20, function() CButton:SetText( "Sauvegarder" ) end)
			end
		end
	end
	
local DButton = vgui.Create( "DButton", DataBrowserFrame )
	DButton:SetSize( ScrW/6.5544989252462448287431, ScrH/7.4175935288169868552 )
	DButton:SetPos( ScrW/1.5965787720623446023750223646186, ScrH/1.34778614395662967211275484286360244362979584012558 )
	DButton:SetText( "Promouvoir" )
	DButton:SetColor( Color( 255, 255, 255, 255 ) )
	DButton.Paint = function(self, w, h)
		draw.RoundedBox( 8, 0, 0, w, h, Color( 0, 0, 255, 255 ) )
	end
	DButton.DoClick = function()
		if DataBrowserDButtonTimer < CurTime() then
			DataBrowserDButtonTimer = CurTime() + 1.25
			if tonumber( SessionInfo.Rang ) > 0 then
				DButton:SetText( "Promouvoir\n\nVotre demande a bien était pris en compte" )
				timer.Simple(1.20, function() DButton:SetText( "Promouvoir" ) end)
				
				local UpgradeTab = {Mode = "Upgrade",
									ID = DataBrowserIdenInfoIDEntry:GetValue(),
									Rang = SessionInfo.Rang}
				
				net.Start( "CCGComputerDataBrowserResult" )
				net.WriteTable( UpgradeTab )
				net.SendToServer()	
				
			else
				DButton:SetText( "Promouvoir\n\nVous n'avez pas la permission nécessaire" )
				timer.Simple(1.20, function() DButton:SetText( "Promouvoir" ) end)
			end
		end
	end 
	
local EButton = vgui.Create( "DButton", DataBrowserFrame )
	EButton:SetSize( ScrW/6.5544989252462448287431, ScrH/7.4175935288169868552 )
	EButton:SetPos( ScrW/1.2805488153797872507438488857374, ScrH/1.65680472860723273225040190148364381258945303721799 )
	EButton:SetText( "Supprimer" )
	EButton:SetColor( Color( 255, 255, 255, 255 ) )
	EButton.Paint = function(self, w, h)
		draw.RoundedBox( 8, 0, 0, w, h, Color( 109, 7, 26, 255 ) )
	end
	EButton.DoClick = function()
		if DataBrowserEButtonTimer < CurTime() then
			DataBrowserEButtonTimer = CurTime() + 1.25
			if tonumber( SessionInfo.Rang ) < 4 then
				EButton:SetText( "Supprimer\n\nVous n'avez pas la permission nécessaire" )
				timer.Simple(1.20, function() EButton:SetText( "Supprimer" ) end)
			else
				EButton:SetText( "Supprimer\n\nVotre demande a bien était pris en compte" )
				timer.Simple(1.20, function() EButton:SetText( "Supprimer" ) end)
				
				DataBrowserListView:RemoveLine( Num )
				
				local DeleteTab = {Mode = "Supprimer",
									ID = DataBrowserIdenInfoIDEntry:GetValue(),
									Rang = SessionInfo.Rang}
				
				net.Start( "CCGComputerDataBrowserResult" )
				net.WriteTable( DeleteTab )
				net.SendToServer()	
				
				Num = NumMin
				ID, Alias, Name, Age, Gender, BloodType = "", "", "", "", "", ""
				Kagune, RC, Hazard, HazardPoint = "", "", "", ""
				Status, Affiliation, Ward = "", "", ""
				
				DataBrowserIdenInfoIDEntry:SetText( ID )
				DataBrowserIdenInfoAliasEntry:SetText( Alias )
				DataBrowserIdenInfoNameEntry:SetText( Name )
				DataBrowserIdenInfoAgeEntry:SetText( Age )
				DataBrowserIdenInfoGenderEntry:SetValue( Gender )
				DataBrowserIdenInfoBloodTypeEntry:SetValue( BloodType )
				
				DataBrowserIdenInfoHazardEntry:SetText( Hazard )
				DataBrowserIdenInfoKaguneEntry:SetText( Kagune )
				DataBrowserIdenInfoRCEntry:SetText( RC )
				
				DataBrowserAffiInfoWardEntry:SetText( Ward )
				DataBrowserAffiInfoAffiEntry:SetText( Affiliation )
				DataBrowserAffiInfoStatusEntry:SetText( Status )
				
			end
		end
	end
	
local FButton = vgui.Create( "DButton", DataBrowserFrame )
	FButton:SetSize( ScrW/6.5544989252462448287431, ScrH/7.4175935288169868552 )
	FButton:SetPos( ScrW/1.2805488153797872507438488857374, ScrH/1.34778614395662967211275484286360244362979584012558 )
	FButton:SetText( ">" )
	FButton:SetColor( Color( 255, 255, 255, 255 ) )
	FButton.Paint = function(self, w, h)
		draw.RoundedBox( 8, 0, 0, w, h, Color( 25, 25, 25, 255 ) )
	end
	FButton.DoClick = function()
		if Num < NumMax then
			if DataBrowserFButtonTimer < CurTime() then
				DataBrowserFButtonTimer = CurTime() + 0.25
				Num = Num + 1
				ID, Alias, Name, Age, Gender, BloodType = GhoulData[Num]["SteamID64"], GhoulData[Num]["Alias"], GhoulData[Num]["Name"], GhoulData[Num]["Age"], GhoulData[Num]["Gender"], GhoulData[Num]["Bloodtype"]
				Kagune, RC, Hazard, HazardPoint = GhoulData[Num]["Kagune"], GhoulData[Num]["RC"], GhoulData[Num]["Hazard"], GhoulData[Num]["HazardPoint"]
				Status, Affiliation, Ward = GhoulData[Num]["Status"], GhoulData[Num]["Affiliation"], GhoulData[Num]["Ward"]
				
				DataBrowserIdenInfoIDEntry:SetText( ID )
				DataBrowserIdenInfoAliasEntry:SetText( Alias )
				DataBrowserIdenInfoNameEntry:SetText( Name )
				DataBrowserIdenInfoAgeEntry:SetText( Age )
				DataBrowserIdenInfoGenderEntry:SetValue( Gender )
				DataBrowserIdenInfoBloodTypeEntry:SetValue( BloodType )
				
				DataBrowserIdenInfoHazardEntry:SetText( Hazard )
				DataBrowserIdenInfoKaguneEntry:SetText( Kagune )
				DataBrowserIdenInfoRCEntry:SetText( RC )
				
				DataBrowserAffiInfoWardEntry:SetText( Ward )
				DataBrowserAffiInfoAffiEntry:SetText( Affiliation )
				DataBrowserAffiInfoStatusEntry:SetText( Status )
			end
		end
	end 
	
	
	
	
	
local DataBrowserButton = vgui.Create( "DImageButton", Frame )
	DataBrowserButton:SetSize( ScrH/15, ScrH/15 )
	DataBrowserButton:SetPos( ScrH/25 , ScrH/25 )
	DataBrowserButton:SetImage( "tkg/computer/apps/ccgdatabrowser.png" )
	DataBrowserButton.DoClick = function()
		if DataBrowserTimer < CurTime() then
			DataBrowserTimer = CurTime() + 0.10
			if DataBrowserFrame:IsVisible() then
				DataBrowserFrame:SetVisible( false )
				DataBrowserFrame:MoveToBack()
			else
				DataBrowserFrame:SetVisible( true )
				DataBrowserFrame:MoveToFront()
			end
		end
	end
	
local DataBrowserButtonText = vgui.Create( "DLabel", Frame )
	DataBrowserButtonText:SetPos( ScrH/25, ScrH/24 + ScrH/15)
	DataBrowserButtonText:SetSize( ScrH/12.5, ScrH/25 )
	DataBrowserButtonText:SetColor( Color( 255, 255, 255, 255 ) )
	DataBrowserButtonText:SetText( "      CCG\nData Browser" )
	
	
	
	
	
	
local SettingFrame = vgui.Create( "DFrame")
	SettingFrame:SetVisible( false )
	SettingFrame:SetSize(ScrW-(ScrW/20)-20,ScrH-(ScrH/20)-( ScrH/22.5+20))
	SettingFrame:SetPos( ScrW/40 + 10, ScrH/40 + 10 )
	SettingFrame:SetTitle( "" )
	SettingFrame:MakePopup()
	SettingFrame:ShowCloseButton( false )
	SettingFrame:SetDraggable( false )
	SettingFrame:SetText( "" )
	SettingFrame.Paint = function( self, w, h )
		draw.RoundedBox( 8, 0, 0, w, h, Color( 100, 100, 100, 250 ) )
	end
	
local SettingBar = vgui.Create( "DLabel", SettingFrame )
	SettingBar:SetPos( 0, 0 )
	SettingBar:SetSize(ScrW-(ScrW/20)-20,ScrH/40)
	SettingBar:SetText( "" )
	SettingBar.Paint = function( self, w, h )
		draw.RoundedBox( 8, 0, 0, w, h, Color(240, 240, 240, 225 ) )
	end

local Setting = vgui.Create( "DImage", SettingFrame )
	Setting:SetPos( (ScrH/40 - ScrH/45)/2, (ScrH/40 - ScrH/45)/2 )
	Setting:SetSize(ScrH/45, ScrH/45)
	Setting:SetImage( "tkg/computer/apps/settinglogo.png" )	

local SettingCloseButton = vgui.Create( "DButton", SettingFrame )
	SettingCloseButton:SetSize( ScrH/45, ScrH/45 )
	SettingCloseButton:SetPos( SettingFrame:GetWide() - ( ScrH/40 + (ScrH/40 - ScrH/45)/2 ), (ScrH/40 - ScrH/45)/2 )
	SettingCloseButton:SetText( "X" )
	SettingCloseButton:SetColor( Color( 255, 255, 255, 255 ) )
	SettingCloseButton.Paint = function(self, w, h)
		draw.RoundedBox( 8, 0, 0, w, h, Color( 240, 40, 40, 255 ) )
	end
	SettingCloseButton.DoClick = function()
		SettingFrame:SetVisible( false )	
		SettingFrame:MoveToBack()
	end 

local SettingChangeLabel1 = vgui.Create( "DLabel", SettingFrame )
	SettingChangeLabel1:SetPos( (ScrH/40)/2, (ScrH/40) + (ScrH/40)/2 )
	SettingChangeLabel1:SetSize(SettingFrame:GetWide()/2 - (ScrH/40)*0.75,(SettingFrame:GetTall()-(ScrH/40))/2 - (ScrH/40)*0.75 )
	SettingChangeLabel1:SetText( "" )
	SettingChangeLabel1.Paint = function( self, w, h )
		draw.RoundedBox( 8, 0, 0, w, h, Color(200, 200, 200, 200 ) )
	end

local SettingChangeBar1 = vgui.Create( "DLabel", SettingFrame )
	SettingChangeBar1:SetPos( (ScrH/40)/2, (ScrH/40) + (ScrH/40)/2 )
	SettingChangeBar1:SetSize(SettingChangeLabel1:GetWide(),(ScrH/40) )
	SettingChangeBar1:SetColor( Color( 0, 0, 0, 255 ) )
	SettingChangeBar1:SetText( "     Sécurité" )
	SettingChangeBar1.Paint = function( self, w, h )
		draw.RoundedBox( 8, 0, 0, w, h, Color(240, 240, 240, 225 ) )
	end

local SettingChangeUsername = vgui.Create( "DLabel", SettingFrame )
	SettingChangeUsername:SetPos( (ScrH/20) * 1, (ScrH/20) * 1.25 )
	SettingChangeUsername:SetSize( ScrW/3, ScrH/20 * 1.5)
	SettingChangeUsername:SetColor( Color( 0, 0, 0, 255 ) )
	SettingChangeUsername:SetText( "                         Nom d'utilisateur" )
	SettingChangeUsername:SetContentAlignment( 4 )
	SettingChangeUsername.Paint = function( self, w, h )
		draw.RoundedBox( 8, 0, 0, w, h, Color(255, 255, 255, 240 ) )
	end
	
local SettingChangeUsernameEntry = vgui.Create( "DTextEntry", SettingFrame )
	SettingChangeUsernameEntry:SetSize( ScrW/6, ScrH/20 )
	SettingChangeUsernameEntry:SetPos( (ScrH/20) * 6.5, (ScrH/20) * 1.5 )
	SettingChangeUsernameEntry:SetText( LocalPlayer():GetNWString("Username", "Username") )

local SettingChangePassword = vgui.Create( "DLabel", SettingFrame )
	SettingChangePassword:SetSize( ScrW/3, ScrH/20 * 1.5)
	SettingChangePassword:SetPos((ScrH/20) * 1, (ScrH/20) * 3.25 )
	SettingChangePassword:SetColor( Color( 0, 0, 0, 255 ) )
	SettingChangePassword:SetText( "                         Mot de Passe actuel" )
	SettingChangePassword:SetContentAlignment( 4 )
	SettingChangePassword.Paint = function( self, w, h )
		draw.RoundedBox( 8, 0, 0, w, h, Color(255, 255, 255, 240 ) )
	end
	
local SettingChangePasswordEntry = vgui.Create( "DTextEntry", SettingFrame )
	SettingChangePasswordEntry:SetSize( ScrW/6, ScrH/20 )
	SettingChangePasswordEntry:SetPos( (ScrH/20) * 6.5, (ScrH/20) * 3.5 )
	SettingChangePasswordEntry:SetText( LocalPlayer():GetNWString("Password", "Password") )

local SettingChangeNewPassword = vgui.Create( "DLabel", SettingFrame )
	SettingChangeNewPassword:SetSize( ScrW/3, ScrH/20 * 1.5 )
	SettingChangeNewPassword:SetPos((ScrH/20) * 1, (ScrH/20) * 5.25 )
	SettingChangeNewPassword:SetColor( Color( 0, 0, 0, 255 ) )
	SettingChangeNewPassword:SetText( "                         Nouveau mot de passe" )
	SettingChangeNewPassword:SetContentAlignment( 4 )
	SettingChangeNewPassword.Paint = function( self, w, h )
		draw.RoundedBox( 8, 0, 0, w, h, Color(255, 255, 255, 240 ) )
	end
	
local SettingChangeNewPasswordEntry = vgui.Create( "DTextEntry", SettingFrame )
	SettingChangeNewPasswordEntry:SetSize( ScrW/6, ScrH/20 )
	SettingChangeNewPasswordEntry:SetPos( (ScrH/20) * 6.5, (ScrH/20) * 5.5 )
	SettingChangeNewPasswordEntry:SetText( "New Password" )

local SettingChangeNewPasswordAgain = vgui.Create( "DLabel", SettingFrame )
	SettingChangeNewPasswordAgain:SetSize( ScrW/3, ScrH/20 * 1.5 )
	SettingChangeNewPasswordAgain:SetPos((ScrH/20) * 1, (ScrH/20) * 7.25 )
	SettingChangeNewPasswordAgain:SetColor( Color( 0, 0, 0, 255 ) )
	SettingChangeNewPasswordAgain:SetText( "                         Confirmé le mot de passe" )
	SettingChangeNewPasswordAgain:SetContentAlignment( 4 )
	SettingChangeNewPasswordAgain.Paint = function( self, w, h )
		draw.RoundedBox( 8, 0, 0, w, h, Color(255, 255, 255, 240 ) )
	end
	
local SettingChangeNewPasswordAgainEntry = vgui.Create( "DTextEntry", SettingFrame )
	SettingChangeNewPasswordAgainEntry:SetSize( ScrW/6, ScrH/20 )
	SettingChangeNewPasswordAgainEntry:SetPos( (ScrH/20) * 6.5, (ScrH/20) * 7.5 )
	SettingChangeNewPasswordAgainEntry:SetText( "New Password again" )

local SettingChangePasswordButton = vgui.Create( "DButton", SettingFrame )
	SettingChangePasswordButton:SetSize( ScrH/20 * 3, ScrH/20 * 1.5 )
	SettingChangePasswordButton:SetPos( (ScrH/20)*1.5	+ ScrW/3, (ScrH/20) * 7.25 )
	SettingChangePasswordButton:SetText( "Sauvegarder" )
	SettingChangePasswordButton:SetColor( Color( 255, 255, 255, 255 ) )
	SettingChangePasswordButton.Paint = function(self, w, h)
		draw.RoundedBox( 8, 0, 0, w, h, Color( 40, 250, 40, 255 ) )
	end
	SettingChangePasswordButton.DoClick = function()
		if PasswordChangeTimer < CurTime() then
			PasswordChangeTimer = CurTime() + 0.10
			local PasswordChangeTab = {Username = SettingChangeUsernameEntry:GetValue(),
										OldPassword = SettingChangePasswordEntry:GetValue(),
										NewPassword = SettingChangeNewPasswordEntry:GetValue(),
										ConfirmNewPassword = SettingChangeNewPasswordAgainEntry:GetValue()
										}
			net.Start( "CCGComputerServerPasswordNetwork" )
			net.WriteTable( PasswordChangeTab )
			net.SendToServer()							
		end
	end 

	
	
	

local SettingChangeLabel2 = vgui.Create( "DLabel", SettingFrame )
	SettingChangeLabel2:SetPos( SettingFrame:GetWide()/2 - (ScrH/40)*0.75 + (ScrH/40), (ScrH/40) + (ScrH/40)/2 )
	SettingChangeLabel2:SetSize(SettingFrame:GetWide()/2 - (ScrH/40)*0.75,(SettingFrame:GetTall()-(ScrH/40))/2 - (ScrH/40)*0.75 )
	SettingChangeLabel2:SetText( "" )
	SettingChangeLabel2.Paint = function( self, w, h )
		draw.RoundedBox( 8, 0, 0, w, h, Color(200, 200, 200, 200 ) )
	end
	
local SettingChangeLabel3 = vgui.Create( "DLabel", SettingFrame )
	SettingChangeLabel3:SetPos( (ScrH/40)/2, (ScrH/40) + (ScrH/40)/2 + (SettingFrame:GetTall()-(ScrH/40))/2 - (ScrH/40)*0.75  + (ScrH/40)*0.5 )
	SettingChangeLabel3:SetSize(SettingFrame:GetWide() - (ScrH/40),(SettingFrame:GetTall()-(ScrH/40))/2 - (ScrH/40)*0.75 )
	SettingChangeLabel3:SetText( "" )
	SettingChangeLabel3.Paint = function( self, w, h )
		draw.RoundedBox( 8, 0, 0, w, h, Color(200, 200, 200, 200 ) )
	end

	
local SettingButton = vgui.Create( "DImageButton", Frame )
	SettingButton:SetSize( (ScrH/22.5)-10, (ScrH/22.5)-10 )
	SettingButton:SetPos( Frame:GetWide() - ( SettingButton:GetWide() + 10 ) , Frame:GetTall() - ( SettingButton:GetTall() + 10 ) )
	SettingButton:SetImage( "tkg/computer/apps/setting.png" )
	SettingButton.DoClick = function()
		if SettingTimer < CurTime() then
			SettingTimer = CurTime() + 0.10
			if SettingFrame:IsVisible() then
				SettingFrame:SetVisible( false )
				SettingFrame:MoveToBack()
			else
				SettingFrame:SetVisible( true )
				SettingFrame:MoveToFront()
			end
		end
	end
	
	
	
	
	
local CloseButton = vgui.Create( "DButton", Frame )
	CloseButton:SetSize( ScrW/40, ScrH/40 )
	CloseButton:SetPos( Frame:GetWide() - ( CloseButton:GetWide() + SettingButton:GetWide() + 15 ) , Frame:GetTall() - ( CloseButton:GetTall() + 12.25 ) )
	CloseButton:SetText( "Partir" )
	CloseButton:SetColor( Color( 255, 255, 255, 255 ) )
	CloseButton.Paint = function()
		draw.RoundedBox( 8, 0, 0, CloseButton:GetWide(), CloseButton:GetTall(), Color( 240, 40, 40, 255 ) )
	end
	CloseButton.DoClick = function()
		SettingFrame:Close()
		DataBrowserFrame:Close()
		Frame:Close()
	end
end

net.Receive( "CCGComputerClientNetWork", function()
	local tab = net.ReadTable()
	timer.Simple( tab.LoadingDelay - CurTime(), function() CCGComputerOffice( tab ) end )
end )

/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */