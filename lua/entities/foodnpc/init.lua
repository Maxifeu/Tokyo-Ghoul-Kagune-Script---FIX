/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

util.AddNetworkString( "OpenFoodShop" )
util.AddNetworkString( "FoodShopReturn" )
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function ENT:Initialize( )
	
	self:SetModel( "models/humans/group02/male_02.mdl" )
	self:SetHullType( HULL_HUMAN )
	self:SetHullSizeNormal( )
	self:SetNPCState( NPC_STATE_SCRIPT )
	self:SetSolid(  SOLID_BBOX )
	self:CapabilitiesAdd( CAP_ANIMATEDFACE || CAP_TURN_HEAD )
	self:SetUseType( SIMPLE_USE )
	self:DropToFloor()
	
	self:SetMaxYawSpeed( 90 )
	
end

function ENT:OnTakeDamage()
	return false
end 
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function ENT:AcceptInput( Name, Activator, Caller )	
	if self.UseDelay < CurTime() then
		self.UseDelay = CurTime() + 5
		if Name == "Use" and Caller:IsPlayer() then
			
			net.Start("OpenFoodShop")
			net.Send( Caller )
			
		end
	end
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
net.Receive("FoodShopReturn", function(len, ply)
	local tab = net.ReadTable()
	local str = tab.id
	if ply:IsValid() then
		if str == "AperitifItem" or str == "BoissonItem" or str == "CakeItem" or str == "FruitItem" then
			if (ply:getDarkRPVar("money")) and (ply:getDarkRPVar("money")) > tab.price then
				ply:addMoney( -tab.price )
				local Food = ents.Create("tkg_food")
				local ePos = ply:GetPos()
				Food:SetPos(ePos + ply:GetForward()*20 + ply:GetUp()*25 )
				Food:SetAngles( Angle( 0, 0, 0) )
				Food:Spawn()
				Food:SetModel( tab.mdl )
				Food:SetNWInt("TKGFood", tab.food )
				Food:PhysicsInit( SOLID_VPHYSICS )
				Food:SetMoveType( MOVETYPE_VPHYSICS )
				Food:SetSolid( SOLID_VPHYSICS )
				
				local phys = Food:GetPhysicsObject()
				if phys:IsValid() then
					phys:Wake()
				end
			end
		end
	end
end)
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */