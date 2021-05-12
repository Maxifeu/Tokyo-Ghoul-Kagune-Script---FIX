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
		draw.DrawText( text, "Default", 0, 0, Color( 255, 136, 0), TEXT_ALIGN_CENTER )
	cam.End3D2D()
end

function ENT:Draw()
	self:DrawModel()

	local text = "BOUTIQUE NOURRITURE"

	local mins, maxs = self:GetModelBounds()
	local pos = self:GetPos() + Vector( 0, 0, maxs.z + 5 )

	local ang = Angle( 0, SysTime() * 100 % 360, 90 )

	Draw3DText( pos, ang, 0.2, text, false )
	Draw3DText( pos, ang, 0.2, text, true )
end

function Ishikawa()
	local ScrW = ScrW()
 	local ScrH = ScrH()

 	local BuyCoolDown = 0

 	local MainFrame = vgui.Create("DFrame")
 	MainFrame:SetTitle("Magasin de Nourriture")
 	MainFrame:SetSize( 1600/3, 900/3)
	MainFrame:SetSizable(false)
	MainFrame:SetDraggable(false)
	MainFrame:MakePopup()
    MainFrame:ShowCloseButton(false)
	MainFrame:Center()
	MainFrame.Paint = function(pan, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(50, 50, 50))
        draw.RoundedBox(0, 0, 0, w, 40, Color(50, 50, 50))
        surface.SetDrawColor(25, 25, 25)
        surface.DrawOutlinedRect(0, 0, w, h, 5)
	end

    local CloseFrame = vgui.Create("DImageButton", MainFrame)
		CloseFrame:SetPos(496, 12)
		CloseFrame:SetSize(25, 25)
		CloseFrame:SetImage("nano/npc/croix.png")
		CloseFrame.DoClick = function()
			MainFrame:Close()
		end

	local MainSheet = vgui.Create( "DPropertySheet", MainFrame )
	MainSheet:Dock( FILL )

	local AperitifSheet = vgui.Create( "DPanel", MainSheet)
	MainSheet:AddSheet("Aperitif", AperitifSheet )

	local AperitifItem = {icon = {}, Text = {}, XLine = {}, YLine = {}, price = {}, food = {}}
 
    AperitifItem.icon[1] = "models/foodnhouseholditems/cookies.mdl"   --- Modifiez ici la nourriture en vente
    AperitifItem.Text[1] = "Cookie"
    AperitifItem.price[1] = 99
    AperitifItem.food[1] = 75
    AperitifItem.XLine[1] = 10
    AperitifItem.YLine[1] = 10

	AperitifItem.icon[2] = "models/foodnhouseholditems/chipsbag1.mdl"
    AperitifItem.Text[2] = "Chips"
    AperitifItem.price[2] = 130
    AperitifItem.food[2] = 100
    AperitifItem.XLine[2] = 10
    AperitifItem.YLine[2] = 80

	AperitifItem.icon[3] = "models/foodnhouseholditems/chipslays.mdl"
    AperitifItem.Text[3] = "Chips"
    AperitifItem.price[3] = 130
    AperitifItem.food[3] = 100
    AperitifItem.XLine[3] = 10
    AperitifItem.YLine[3] = 160

	AperitifItem.icon[4] = "models/foodnhouseholditems/chipsfritostwists.mdl"
    AperitifItem.Text[4] = "Chips Fritos Twists"
    AperitifItem.price[4] = 690
    AperitifItem.food[4] = 334
    AperitifItem.XLine[4] = 80
    AperitifItem.YLine[4] = 10

	AperitifItem.icon[5] = "models/foodnhouseholditems/chipsfritoshoops.mdl"
    AperitifItem.Text[5] = "Chips Frito Shoops"
    AperitifItem.price[5] = 130
    AperitifItem.food[5] = 100
    AperitifItem.XLine[5] = 80
    AperitifItem.YLine[5] = 80

	AperitifItem.icon[6] = "models/foodnhouseholditems/chipsdoritos6.mdl"
    AperitifItem.Text[6] = "Doritos"
    AperitifItem.price[6] = 130
    AperitifItem.food[6] = 100
    AperitifItem.XLine[6] = 80
    AperitifItem.YLine[6] = 160

	AperitifItem.icon[7] = "models/foodnhouseholditems/chipslays4.mdl"
    AperitifItem.Text[7] = "Chips"
    AperitifItem.price[7] = 130
    AperitifItem.food[7] = 100
    AperitifItem.XLine[7] = 160
    AperitifItem.YLine[7] = 10

    AperitifItem.icon[8] = "models/foodnhouseholditems/digestive2.mdl"
    AperitifItem.Text[8] = "Gâteau Digestif"
    AperitifItem.price[8] = 500
    AperitifItem.food[8] = 400
    AperitifItem.XLine[8] = 160
    AperitifItem.YLine[8] = 80

	AperitifItem.icon[9] = "models/foodnhouseholditems/digestive.mdl"
    AperitifItem.Text[9] = "Gâteau Digestif"
    AperitifItem.price[9] = 500
    AperitifItem.food[9] = 400
    AperitifItem.XLine[9] = 160
    AperitifItem.YLine[9] = 160

	AperitifItem.icon[10] = "models/foodnhouseholditems/picklejar.mdl"
    AperitifItem.Text[10] = "Cornichon"
    AperitifItem.price[10] = 120
    AperitifItem.food[10] = 100
    AperitifItem.XLine[10] = 230
    AperitifItem.YLine[10] = 10

	AperitifItem.icon[11] = "models/foodnhouseholditems/chipsbag2.mdl"
    AperitifItem.Text[11] = "Chips"
    AperitifItem.price[11] = 130
    AperitifItem.food[11] = 100
    AperitifItem.XLine[11] = 230
    AperitifItem.YLine[11] = 80

	AperitifItem.icon[12] = "models/foodnhouseholditems/chipsbag3.mdl"
    AperitifItem.Text[12] = "Chips"
    AperitifItem.price[12] = 130
    AperitifItem.food[12] = 100
    AperitifItem.XLine[12] = 230
    AperitifItem.YLine[12] = 160

	AperitifItem.icon[13] = "models/foodnhouseholditems/chipscheezit.mdl"
    AperitifItem.Text[13] = "Chips Cheeze"
    AperitifItem.price[13] = 130
    AperitifItem.food[13] = 100
    AperitifItem.XLine[13] = 300
    AperitifItem.YLine[13] = 10

	AperitifItem.icon[14] = "models/foodnhouseholditems/chipstwisties.mdl"
    AperitifItem.Text[14] = "Chips Twisties"
    AperitifItem.price[14] = 130
    AperitifItem.food[14] = 100
    AperitifItem.XLine[14] = 300
    AperitifItem.YLine[14] = 80

    AperitifItem.icon[15] = "models/foodnhouseholditems/chipstropical.mdl"
    AperitifItem.Text[15] = "Chips Tropical"
    AperitifItem.price[15] = 130
    AperitifItem.food[15] = 100
    AperitifItem.XLine[15] = 300
    AperitifItem.YLine[15] = 160

    AperitifItem.icon[16] = "models/foodnhouseholditems/chipslays8.mdl"
    AperitifItem.Text[16] = "Chips"
    AperitifItem.price[16] = 130
    AperitifItem.food[16] = 100
    AperitifItem.XLine[16] = 370
    AperitifItem.YLine[16] = 10

    AperitifItem.icon[17] = "models/foodnhouseholditems/chipslays6.mdl"
    AperitifItem.Text[17] = "Chips"
    AperitifItem.price[17] = 130
    AperitifItem.food[17] = 100
    AperitifItem.XLine[17] = 370
    AperitifItem.YLine[17] = 80

    AperitifItem.icon[18] = "models/foodnhouseholditems/chipslays5.mdl"
    AperitifItem.Text[18] = "Chips"
   	AperitifItem.price[18] = 130
   	AperitifItem.food[18] = 100
    AperitifItem.XLine[18] = 370
    AperitifItem.YLine[18] = 160

    AperitifItem.icon[19] = "models/foodnhouseholditems/chipslays4.mdl"
    AperitifItem.Text[19] = "Chips"
    AperitifItem.price[19] = 130
    AperitifItem.food[19] = 100
    AperitifItem.XLine[19] = 440
    AperitifItem.YLine[19] = 10

    AperitifItem.icon[20] = "models/foodnhouseholditems/chipsdoritos3.mdl"
    AperitifItem.Text[20] = "Doritos"
    AperitifItem.price[20] = 130
    AperitifItem.food[20] = 100
    AperitifItem.XLine[20] = 440
    AperitifItem.YLine[20] = 80

    AperitifItem.icon[21] = "models/foodnhouseholditems/chipsdoritos2.mdl"
    AperitifItem.Text[21] = "Doritos"
    AperitifItem.price[21] = 130
    AperitifItem.food[21] = 100
    AperitifItem.XLine[21] = 440 
    AperitifItem.YLine[21] = 160


    for i=1, #AperitifItem.icon do
        local AperitifIcon = vgui.Create( "SpawnIcon", AperitifSheet)
        AperitifIcon:SetPos( AperitifItem.XLine[i], AperitifItem.YLine[i] )
        AperitifIcon:SetSize( 60, 60 )
        AperitifIcon:SetModel( AperitifItem.icon[i] ) 
        AperitifIcon:SetToolTip( AperitifItem.Text[i].." - ".. AperitifItem.price[i].." $" )
        AperitifIcon.DoClick = function()
            if BuyCoolDown < CurTime() then
                BuyCoolDown = CurTime() + 0.25
                net.Start("FoodShopReturn")
                local tab = {}
                tab.id = "AperitifItem" 
                tab.mdl = AperitifItem.icon[i]
                tab.price = AperitifItem.price[i]
                tab.food = AperitifItem.food[i]
                net.WriteTable( tab )
                net.SendToServer()
            end
        end
    end

    local FruitSheet = vgui.Create( "DPanel", MainSheet)
    MainSheet:AddSheet("Fruit / Légume", FruitSheet )

    local FruitItem = {icon = {}, Text = {}, XLine = {}, YLine = {}, price = {}, food = {}}

    FruitItem.icon[1] = "models/foodnhouseholditems/chili.mdl"
    FruitItem.Text[1] = "Piment"
    FruitItem.price[1] = 300
    FruitItem.food[1] = 400
    FruitItem.XLine[1] = 10
    FruitItem.YLine[1] = 10

    FruitItem.icon[2] = "models/foodnhouseholditems/coconut.mdl"
    FruitItem.Text[2] = "Noix de coco"
    FruitItem.price[2] = 300
    FruitItem.food[2] = 400
    FruitItem.XLine[2] = 10
    FruitItem.YLine[2] = 80

    FruitItem.icon[3] = "models/foodnhouseholditems/corn.mdl"
    FruitItem.Text[3] = "Blé"
    FruitItem.price[3] = 10
    FruitItem.food[3] = 1
    FruitItem.XLine[3] = 10
    FruitItem.YLine[3] = 160

    FruitItem.icon[4] = "models/foodnhouseholditems/eggplant.mdl"
    FruitItem.Text[4] = "Aubergine"
    FruitItem.price[4] = 300
    FruitItem.food[4] = 100
    FruitItem.XLine[4] = 80
    FruitItem.YLine[4] = 10

    FruitItem.icon[5] = "models/foodnhouseholditems/gourd.mdl"
    FruitItem.Text[5] = "Gourd"
    FruitItem.price[5] = 400
    FruitItem.food[5] = 300
    FruitItem.XLine[5] = 80
    FruitItem.YLine[5] = 80

    FruitItem.icon[6] = "models/foodnhouseholditems/grapes1.mdl"
    FruitItem.Text[6] = "Raisin"
    FruitItem.price[6] = 600
    FruitItem.food[6] = 500
    FruitItem.XLine[6] = 80
    FruitItem.YLine[6] = 160

    FruitItem.icon[7] = "models/foodnhouseholditems/leek.mdl"
    FruitItem.Text[7] = "Poireau"
    FruitItem.price[7] = 400
    FruitItem.food[7] = 300
    FruitItem.XLine[7] = 160
    FruitItem.YLine[7] = 10

    FruitItem.icon[8] = "models/foodnhouseholditems/lettuce.mdl"
    FruitItem.Text[8] = "Salade"
    FruitItem.price[8] = 400
    FruitItem.food[8] = 300
    FruitItem.XLine[8] = 160
    FruitItem.YLine[8] = 80

    FruitItem.icon[9] = "models/foodnhouseholditems/pear.mdl"
    FruitItem.Text[9] = "Nell's premium - Vanille"
    FruitItem.price[9] = 8999
    FruitItem.food[9] = 1800
    FruitItem.XLine[9] = 160
    FruitItem.YLine[9] = 160

    FruitItem.icon[10] = "models/foodnhouseholditems/pepper1.mdl"
    FruitItem.Text[10] = "Poivron"
    FruitItem.price[10] = 450
    FruitItem.food[10] = 325
    FruitItem.XLine[10] = 230
    FruitItem.YLine[10] = 10

    FruitItem.icon[11] = "models/foodnhouseholditems/pineapple.mdl"
    FruitItem.Text[11] = "Ananas"
    FruitItem.price[11] = 498
    FruitItem.food[11] = 386
    FruitItem.XLine[11] = 230
    FruitItem.YLine[11] = 80

    FruitItem.icon[12] = "models/foodnhouseholditems/pumpkin01.mdl"
    FruitItem.Text[12] = "Citrouille"
    FruitItem.price[12] = 400
    FruitItem.food[12] = 300
    FruitItem.XLine[12] = 230
    FruitItem.YLine[12] = 160

    FruitItem.icon[13] = "models/foodnhouseholditems/watermelon_unbreakable.mdl"
    FruitItem.Text[13] = "Pastèque"
    FruitItem.price[13] = 400
    FruitItem.food[13] = 300
    FruitItem.XLine[13] = 300
    FruitItem.YLine[13] = 10

    FruitItem.icon[14] = "models/foodnhouseholditems/tomato.mdl"
    FruitItem.Text[14] = "Tomate"
    FruitItem.price[14] = 500
    FruitItem.food[14] = 400
    FruitItem.XLine[14] = 300
    FruitItem.YLine[14] = 80

    FruitItem.icon[15] = "models/foodnhouseholditems/potato.mdl"
    FruitItem.Text[15] = "Patate"
    FruitItem.price[15] = 600
    FruitItem.food[15] = 500
    FruitItem.XLine[15] = 300
    FruitItem.YLine[15] = 160

    FruitItem.icon[16] = "models/foodnhouseholditems/cabbage1.mdl"
    FruitItem.Text[16] = "Chou"
    FruitItem.price[16] = 600
    FruitItem.food[16] = 500
    FruitItem.XLine[16] = 370
    FruitItem.YLine[16] = 10

    FruitItem.icon[17] = "models/foodnhouseholditems/bananna_bunch.mdl"
    FruitItem.Text[17] = "Banane"
    FruitItem.price[17] = 300
    FruitItem.food[17] = 200
    FruitItem.XLine[17] = 370
    FruitItem.YLine[17] = 80

    FruitItem.icon[18] = "models/foodnhouseholditems/carrot.mdl"
    FruitItem.Text[18] = "Carotte"
    FruitItem.price[18] = 400
    FruitItem.food[18] = 300
    FruitItem.XLine[18] = 370
    FruitItem.YLine[18] = 160

    FruitItem.icon[19] = "models/foodnhouseholditems/grapes3.mdl"
    FruitItem.Text[19] = "Raisin"
    FruitItem.price[19] = 400
    FruitItem.food[19] = 300
    FruitItem.XLine[19] = 440
    FruitItem.YLine[19] = 10

    FruitItem.icon[20] = "models/foodnhouseholditems/pepper3.mdl"
    FruitItem.Text[20] = "Poivron"
    FruitItem.price[20] = 500
    FruitItem.food[20] = 400
    FruitItem.XLine[20] = 440
    FruitItem.YLine[20] = 80

    FruitItem.icon[21] = "models/foodnhouseholditems/cabbage2.mdl"
    FruitItem.Text[21] = "Chou"
    FruitItem.price[21] = 500
    FruitItem.food[21] = 400
    FruitItem.XLine[21] = 440 
    FruitItem.YLine[21] = 160

    for i=1, #FruitItem.icon do
        local FruitIcon = vgui.Create( "SpawnIcon", FruitSheet)
        FruitIcon:SetPos( FruitItem.XLine[i], FruitItem.YLine[i] )
        FruitIcon:SetSize( 60, 60 )
        FruitIcon:SetModel( FruitItem.icon[i] ) 
        FruitIcon:SetToolTip( FruitItem.Text[i].." - ".. FruitItem.price[i].." $" )
        FruitIcon.DoClick = function()
            if BuyCoolDown < CurTime() then
                BuyCoolDown = CurTime() + 0.25
                net.Start("FoodShopReturn")
                local tab = {}
                tab.id = "FruitItem" 
                tab.mdl = FruitItem.icon[i]
                tab.price = FruitItem.price[i]
                tab.food = FruitItem.food[i]
                net.WriteTable( tab )
                net.SendToServer()
            end
        end
    end

    local CakeSheet = vgui.Create( "DPanel", MainSheet)
    MainSheet:AddSheet("Cake", CakeSheet )

    local CakeItem = {icon = {}, Text = {}, XLine = {}, YLine = {}, price = {}, food = {}}

    CakeItem.icon[1] = "models/foodnhouseholditems/cake.mdl"
    CakeItem.Text[1] = "Gâteau d'Anniversaire"
    CakeItem.price[1] = 4800
    CakeItem.food[1] = 1800
    CakeItem.XLine[1] = 10
    CakeItem.YLine[1] = 10

    CakeItem.icon[2] = "models/foodnhouseholditems/cake_b.mdl"
    CakeItem.Text[2] = "Gâteau d'Anniversaire"
    CakeItem.price[2] = 4800
    CakeItem.food[2] = 1800
    CakeItem.XLine[2] = 10
    CakeItem.YLine[2] = 80

    CakeItem.icon[3] = "models/foodnhouseholditems/kinderbox.mdl"
    CakeItem.Text[3] = "Kinder Surprise"
    CakeItem.price[3] = 246
    CakeItem.food[3] = 70
    CakeItem.XLine[3] = 10
    CakeItem.YLine[3] = 160

    CakeItem.icon[4] = "models/foodnhouseholditems/marabou1.mdl"
    CakeItem.Text[4] = "Marabou"
    CakeItem.price[4] = 380
    CakeItem.food[4] = 193
    CakeItem.XLine[4] = 80
    CakeItem.YLine[4] = 10

    CakeItem.icon[5] = "models/foodnhouseholditems/marabou3.mdl"
    CakeItem.Text[5] = "Marabou Oreo"
    CakeItem.price[5] = 380
    CakeItem.food[5] = 193
    CakeItem.XLine[5] = 80
    CakeItem.YLine[5] = 80

    CakeItem.icon[6] = "models/foodnhouseholditems/marabou4.mdl"
    CakeItem.Text[6] = "Marabou Dain"
    CakeItem.price[6] = 380
    CakeItem.food[6] = 193
    CakeItem.XLine[6] = 80
    CakeItem.YLine[6] = 160

    CakeItem.icon[7] = "models/foodnhouseholditems/pancakes.mdl"
    CakeItem.Text[7] = "Pancake"
    CakeItem.price[7] = 320
    CakeItem.food[7] = 169
    CakeItem.XLine[7] = 160
    CakeItem.YLine[7] = 10

    CakeItem.icon[8] = "models/foodnhouseholditems/icecream1.mdl"
    CakeItem.Text[8] = "Nell's premium - Neapolitan"
    CakeItem.price[8] = 1200
    CakeItem.food[8] = 1500
    CakeItem.XLine[8] = 160
    CakeItem.YLine[8] = 80

    CakeItem.icon[9] = "models/foodnhouseholditems/icecream2.mdl"
    CakeItem.Text[9] = "Nell's premium - Vanille"
    CakeItem.price[9] = 1200
    CakeItem.food[9] = 120
    CakeItem.XLine[9] = 160
    CakeItem.YLine[9] = 160

    CakeItem.icon[10] = "models/foodnhouseholditems/icecream3.mdl"
    CakeItem.Text[10] = "Nell's premium - Strawberry"
    CakeItem.price[10] = 1200
    CakeItem.food[10] = 120
    CakeItem.XLine[10] = 230
    CakeItem.YLine[10] = 10

    CakeItem.icon[11] = "models/foodnhouseholditems/icecream4.mdl"
    CakeItem.Text[11] = "Nell's premium - Chocolate"
    CakeItem.price[11] = 1200
    CakeItem.food[11] = 620
    CakeItem.XLine[11] = 230
    CakeItem.YLine[11] = 80

    CakeItem.icon[12] = "models/foodnhouseholditems/icecream5.mdl"
    CakeItem.Text[12] = "Nell's premium - Pistachio"
    CakeItem.price[12] = 1200
    CakeItem.food[12] = 620
    CakeItem.XLine[12] = 230
    CakeItem.YLine[12] = 160

    CakeItem.icon[13] = "models/foodnhouseholditems/sodacan04.mdl"
    CakeItem.Text[13] = "Nell's premium - Licorice"
    CakeItem.price[13] = 1200
    CakeItem.food[13] = 620
    CakeItem.XLine[13] = 300
    CakeItem.YLine[13] = 10

    CakeItem.icon[14] = "models/foodnhouseholditems/pizzabox.mdl"
    CakeItem.Text[14] = "Pizza"
    CakeItem.price[14] = 1600
    CakeItem.food[14] = 900
    CakeItem.XLine[14] = 300
    CakeItem.YLine[14] = 80

    CakeItem.icon[15] = "models/foodnhouseholditems/toblerone.mdl"
    CakeItem.Text[15] = "Toblerone"
    CakeItem.price[15] = 2300
    CakeItem.food[15] = 600
    CakeItem.XLine[15] = 300
    CakeItem.YLine[15] = 160

    CakeItem.icon[16] = "models/foodnhouseholditems/toffifee.mdl"
    CakeItem.Text[16] = "Toffiefee"
    CakeItem.price[16] = 6000
    CakeItem.food[16] = 500
    CakeItem.XLine[16] = 370
    CakeItem.YLine[16] = 10

    CakeItem.icon[17] = "models/foodnhouseholditems/pie.mdl"
    CakeItem.Text[17] = "Tarte"
    CakeItem.price[17] = 4000
    CakeItem.food[17] = 200
    CakeItem.XLine[17] = 370
    CakeItem.YLine[17] = 80

    CakeItem.icon[18] = "models/foodnhouseholditems/mcdburgerboxclosed.mdl"
    CakeItem.Text[18] = "Burger"
    CakeItem.price[18] = 1000
    CakeItem.food[18] = 1500
    CakeItem.XLine[18] = 370
    CakeItem.YLine[18] = 160

    CakeItem.icon[19] = "models/foodnhouseholditems/cheesewheel1a.mdl"
    CakeItem.Text[19] = "Fromage"
    CakeItem.price[19] = 1200
    CakeItem.food[19] = 135
    CakeItem.XLine[19] = 440
    CakeItem.YLine[19] = 10

    CakeItem.icon[20] = "models/foodnhouseholditems/cheesewheel2a.mdl"
    CakeItem.Text[20] = "Fromage"
    CakeItem.price[20] = 2400
    CakeItem.food[20] = 604
    CakeItem.XLine[20] = 440
    CakeItem.YLine[20] = 80

    CakeItem.icon[21] = "models/foodnhouseholditems/honey_jar.mdl"
    CakeItem.Text[21] = "Miel"
    CakeItem.price[21] = 900
    CakeItem.food[21] = 800
    CakeItem.XLine[21] = 440 
    CakeItem.YLine[21] = 160

    for i=1, #CakeItem.icon do
        local CakeIcon = vgui.Create( "SpawnIcon", CakeSheet)
        CakeIcon:SetPos( CakeItem.XLine[i], CakeItem.YLine[i] )
        CakeIcon:SetSize( 60, 60 )
        CakeIcon:SetModel( CakeItem.icon[i] ) 
        CakeIcon:SetToolTip( CakeItem.Text[i].." - ".. CakeItem.price[i].." $" )
        CakeIcon.DoClick = function()
            if BuyCoolDown < CurTime() then
                BuyCoolDown = CurTime() + 0.25
                net.Start("FoodShopReturn")
                local tab = {}
                tab.id = "CakeItem" 
                tab.mdl = CakeItem.icon[i]
                tab.price = CakeItem.price[i]
                tab.food = CakeItem.food[i]
                net.WriteTable( tab )
                net.SendToServer()
            end
        end
    end

    local DrinkSheet = vgui.Create( "DPanel", MainSheet)
    MainSheet:AddSheet("Boisson", DrinkSheet )

    local BoissonItem = {icon = {}, Text = {}, XLine = {}, YLine = {}, price = {}, food = {}}

    BoissonItem.icon[1] = "models/foodnhouseholditems/champagne3.mdl"
    BoissonItem.Text[1] = "Champagne"
    BoissonItem.price[1] = 48000
    BoissonItem.food[1] = 1800
    BoissonItem.XLine[1] = 10
    BoissonItem.YLine[1] = 10

    BoissonItem.icon[2] = "models/foodnhouseholditems/champagne2.mdl"
    BoissonItem.Text[2] = "Champagne"
    BoissonItem.price[2] = 48000
    BoissonItem.food[2] = 1800
    BoissonItem.XLine[2] = 10
    BoissonItem.YLine[2] = 80

    BoissonItem.icon[3] = "models/foodnhouseholditems/champagne.mdl"
    BoissonItem.Text[3] = "Champagne"
    BoissonItem.price[3] = 48000
    BoissonItem.food[3] = 320
    BoissonItem.XLine[3] = 10
    BoissonItem.YLine[3] = 160

    BoissonItem.icon[4] = "models/foodnhouseholditems/beercan01.mdl"
    BoissonItem.Text[4] = "Duff"
    BoissonItem.price[4] = 250
    BoissonItem.food[4] = 309
    BoissonItem.XLine[4] = 80
    BoissonItem.YLine[4] = 10

    BoissonItem.icon[5] = "models/foodnhouseholditems/beercan02.mdl"
    BoissonItem.Text[5] = "PibWasser"
    BoissonItem.price[5] = 250
    BoissonItem.food[5] = 309
    BoissonItem.XLine[5] = 80
    BoissonItem.YLine[5] = 80

    BoissonItem.icon[6] = "models/foodnhouseholditems/beercan03.mdl"
    BoissonItem.Text[6] = "Hop Knot"
    BoissonItem.price[6] = 250
    BoissonItem.food[6] = 300
    BoissonItem.XLine[6] = 80
    BoissonItem.YLine[6] = 160

    BoissonItem.icon[7] = "models/foodnhouseholditems/cola_swift1.mdl"
    BoissonItem.Text[7] = "Coca Cola - 33cl"
    BoissonItem.price[7] = 450
    BoissonItem.food[7] = 320
    BoissonItem.XLine[7] = 160
    BoissonItem.YLine[7] = 10

    BoissonItem.icon[8] = "models/foodnhouseholditems/cola.mdl"
    BoissonItem.Text[8] = "Coca Cola - 50cl"
    BoissonItem.price[8] = 1200
    BoissonItem.food[8] = 600
    BoissonItem.XLine[8] = 160
    BoissonItem.YLine[8] = 80

    BoissonItem.icon[9] = "models/foodnhouseholditems/colabig.mdl"
    BoissonItem.Text[9] = "Coca Cola - 1.5L"
    BoissonItem.price[9] = 8000
    BoissonItem.food[9] = 1000
    BoissonItem.XLine[9] = 160
    BoissonItem.YLine[9] = 160

    BoissonItem.icon[10] = "models/foodnhouseholditems/sodacan01.mdl"
    BoissonItem.Text[10] = "Coca Cola - 15cl"
    BoissonItem.price[10] = 375
    BoissonItem.food[10] = 200
    BoissonItem.XLine[10] = 230
    BoissonItem.YLine[10] = 10

    BoissonItem.icon[11] = "models/foodnhouseholditems/sodacan02.mdl"
    BoissonItem.Text[11] = "Coca Cola Cherry - 15cl"
    BoissonItem.price[11] = 400
    BoissonItem.food[11] = 200
    BoissonItem.XLine[11] = 230
    BoissonItem.YLine[11] = 80

    BoissonItem.icon[12] = "models/foodnhouseholditems/sodacan03.mdl"
    BoissonItem.Text[12] = "Coca Cola Life - 15cl"
    BoissonItem.price[12] = 400
    BoissonItem.food[12] = 200
    BoissonItem.XLine[12] = 230
    BoissonItem.YLine[12] = 160

    BoissonItem.icon[13] = "models/foodnhouseholditems/sodacan04.mdl"
    BoissonItem.Text[13] = "Pepsi - 15cl"
    BoissonItem.price[13] = 375
    BoissonItem.food[13] = 20
    BoissonItem.XLine[13] = 300
    BoissonItem.YLine[13] = 10

    BoissonItem.icon[14] = "models/foodnhouseholditems/sodacan05.mdl"
    BoissonItem.Text[14] = "Sprite - 15cl"
    BoissonItem.price[14] = 400
    BoissonItem.food[14] = 200
    BoissonItem.XLine[14] = 300
    BoissonItem.YLine[14] = 80

    BoissonItem.icon[15] = "models/foodnhouseholditems/sodacan06.mdl"
    BoissonItem.Text[15] = "Mountain Dew - 15cl"
    BoissonItem.price[15] = 400
    BoissonItem.food[15] = 200
    BoissonItem.XLine[15] = 300
    BoissonItem.YLine[15] = 160

    BoissonItem.icon[16] = "models/foodnhouseholditems/milk.mdl"
    BoissonItem.Text[16] = "Lait"
    BoissonItem.price[16] = 600
    BoissonItem.food[16] = 500
    BoissonItem.XLine[16] = 370
    BoissonItem.YLine[16] = 10

    BoissonItem.icon[17] = "models/foodnhouseholditems/sodacanb02.mdl"
    BoissonItem.Text[17] = "Monster - 15cl"
    BoissonItem.price[17] = 400
    BoissonItem.food[17] = 200
    BoissonItem.XLine[17] = 370
    BoissonItem.YLine[17] = 80

    BoissonItem.icon[18] = "models/foodnhouseholditems/sodacanc01.mdl"
    BoissonItem.Text[18] = "RedBull - 15cl"
    BoissonItem.price[18] = 400
    BoissonItem.food[18] = 200
    BoissonItem.XLine[18] = 370
    BoissonItem.YLine[18] = 160

    BoissonItem.icon[19] = "models/foodnhouseholditems/beer_stoltz.mdl"
    BoissonItem.Text[19] = "Stolz"
    BoissonItem.price[19] = 450
    BoissonItem.food[19] = 400
    BoissonItem.XLine[19] = 440
    BoissonItem.YLine[19] = 10

    BoissonItem.icon[20] = "models/foodnhouseholditems/beer_master.mdl"
    BoissonItem.Text[20] = "Beer Master"
    BoissonItem.price[20] = 450
    BoissonItem.food[20] = 400
    BoissonItem.XLine[20] = 440
    BoissonItem.YLine[20] = 80

    BoissonItem.icon[21] = "models/foodnhouseholditems/sprunk1.mdl"
    BoissonItem.Text[21] = "Sprunk"
    BoissonItem.price[21] = 600
    BoissonItem.food[21] = 650
    BoissonItem.XLine[21] = 440 
    BoissonItem.YLine[21] = 160

    for k,v in pairs(MainSheet.Items) do
		if not IsValid(v.Tab) then continue end
		
		function v.Tab:Paint(w, h)
			if MainSheet:GetActiveTab() == v.Tab then
				
				surface.SetDrawColor(124, 0, 0)
				surface.DrawRect(0, 0, w, h)    
			else
	
				surface.SetDrawColor(65, 65, 65)
				surface.DrawRect(0, 0, w, h)    
			end
		end
	end

    for i=1, #BoissonItem.icon do
        local BoissonIcon = vgui.Create( "SpawnIcon", DrinkSheet)
        BoissonIcon:SetPos( BoissonItem.XLine[i], BoissonItem.YLine[i] )
        BoissonIcon:SetSize( 60, 60 )
        BoissonIcon:SetModel( BoissonItem.icon[i] ) 
        BoissonIcon:SetToolTip( BoissonItem.Text[i].." - ".. BoissonItem.price[i].." $" )
        BoissonIcon.DoClick = function()
            if BuyCoolDown < CurTime() then
                BuyCoolDown = CurTime() + 0.25
                net.Start("FoodShopReturn")
                local tab = {}
                tab.id = "BoissonItem" 
                tab.mdl = BoissonItem.icon[i]
                tab.price = BoissonItem.price[i]
                tab.food = BoissonItem.food[i]
                net.WriteTable( tab )
                net.SendToServer()
            end
        end
    end
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
net.Receive( "OpenFoodShop", function()
 	Ishikawa()
end )
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */