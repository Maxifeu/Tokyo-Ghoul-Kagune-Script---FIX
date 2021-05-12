/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

util.AddNetworkString( "OpenCCGNPC" )
util.AddNetworkString( "CCGNPCReturn" )

function ENT:Initialize( )
	
	self:SetModel( "models/humans/group01/male_04.mdl" )
	self:SetHullType( HULL_HUMAN )
	self:SetHullSizeNormal( )
	self:SetNPCState( NPC_STATE_SCRIPT )
	self:SetSolid(  SOLID_BBOX )
	self:CapabilitiesAdd( CAP_ANIMATEDFACE || CAP_TURN_HEAD )
	self:SetUseType( SIMPLE_USE )
	self:DropToFloor()
	
	self:SetMaxYawSpeed( 90 )
	
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function ENT:OnTakeDamage()
	return false
end 

function ENT:AcceptInput( Name, Activator, Caller )	
	if self.UseDelay < CurTime() then
		self.UseDelay = CurTime() + 5
		if Name == "Use" and Caller:IsPlayer() then
			local QuinqueData
			if sql.Query("SELECT * FROM TKGQuinque WHERE SteamID64 = '".. Caller:SteamID64() .."'") then
				QuinqueData = sql.Query("SELECT * FROM TKGQuinque WHERE SteamID64 = '".. Caller:SteamID64() .."'")
				QuinqueData.Result = table.Count(QuinqueData)
			else
				QuinqueData.Result = 0
			end
			net.Start("OpenCCGNPC")
			net.WriteTable( QuinqueData )
			net.Send( Caller )
			
		end
	end
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
net.Receive("CCGNPCReturn", function(len, ply)
	local tab = net.ReadTable()
	if tab.Type == "Quinque" then
		local QuinqueData = sql.QueryRow("SELECT * FROM TKGQuinque WHERE SteamID64 = '"..ply:SteamID64().."' AND Num = '"..tab.Num.."'")
		if QuinqueData.Type == "À distance" then
			if ply:HasWeapon("weapon_quinquem1") then
				ply:StripWeapon("weapon_quinquem1")
			end
			ply:Give( "weapon_quinquer1")
			ply:SetNWInt("QRGDamage", QuinqueData.Dmg)
		elseif QuinqueData.Type == "Corp à corp" then
			if ply:HasWeapon("weapon_quinquer1") then
				ply:StripWeapon("weapon_quinquer1")
			end
			ply:Give( "weapon_quinquem1")
			ply:SetNWInt("QMDamage", QuinqueData.Dmg)
		elseif QuinqueData.Type == "Armure" then
			ply:SetNWBool("TKGQArmure", true)
			ply:SetNWInt("QADamage", QuinqueData.Dmg)
		end
	end
end)
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */