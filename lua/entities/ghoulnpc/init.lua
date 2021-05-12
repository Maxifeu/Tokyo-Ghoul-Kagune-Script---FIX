/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

util.AddNetworkString( "GhoulificationEnCour" )
util.AddNetworkString( "GhoulificationNPCUsed" )
util.AddNetworkString( "GhoulificationNPCRefuse" )
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function ENT:Initialize( )
	
	self:SetModel( "models/humans/group02/male_04.mdl" )
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

	if Name == "Use" and Caller:IsPlayer() then
		
		if Caller:GetNWInt("GhoulificationEnCour", 0 ) > 0 then
			net.Start( "GhoulificationEnCour" ) net.Send( Caller )
		elseif Caller:GetNWInt("RCells", 250 ) < 1000 then
			net.Start( "GhoulificationNPCUsed" ) net.Send( Caller )
		else
			net.Start( "GhoulificationNPCRefuse" ) net.Send( Caller )
		end
		
	end
	
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */