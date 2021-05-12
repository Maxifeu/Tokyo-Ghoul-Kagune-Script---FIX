/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

util.AddNetworkString( "CCGComputerStart" )

util.AddNetworkString( "CCGComputerServerNetWork" )

util.AddNetworkString( "CCGComputerClientNetWork" )

util.AddNetworkString( "CCGComputerServerPasswordNetwork" )

util.AddNetworkString( "CCGComputerDataBrowserResult" )
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function ENT:Initialize()

	self:SetModel( "models/props/cs_office/computer.mdl" )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetModelScale( 1, 0 )
	self:SetSolid( SOLID_BBOX )
	self:DrawShadow( false )

	self:SetCollisionGroup( COLLISION_GROUP_NONE )
end

function ENT:Draw()
	self:DrawModel()
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function ENT:Think()
end

function ENT:AcceptInput( Name, Activator, Caller )
	if self.UseDelay < CurTime() then
		self.UseDelay = CurTime() + 5
		if Name == "Use" and Caller:IsPlayer() then
				net.Start( "CCGComputerStart" )
				net.WriteTable( {Username = Caller:GetNWString("Username", "Username"), Password = Caller:GetNWString("Password", "Password")} )
				net.Send( Caller )
			
		end
	end
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function ENT:PhysicsCollide( data, physobj )
	if data.HitEntity:IsWorld() then
		self:Remove()
	end
end

function UsernamePasswordVERIF( Username, Password, Delay, ply )
	if sql.TableExists( "TKGComputer" ) then 
		if (sql.Query("SELECT Username FROM TKGComputer WHERE Username = '"..Username.."'")) then
			local ComputerData = sql.QueryRow("SELECT * FROM TKGComputer WHERE Username = '"..Username.."'")
			if Username == ComputerData["Username"] and Password == ComputerData["Password"] then
				local DataList
				if tonumber( ComputerData["Rang"] ) >= 4 then
					DataList = sql.Query("SELECT * FROM CCGData")
				elseif tonumber( ComputerData["Rang"] ) == 3 then
					DataList = sql.Query("SELECT * FROM CCGData WHERE HazardPoint < '1000000' AND Hidden = '0'")
				elseif tonumber( ComputerData["Rang"] ) == 2 then
					DataList = sql.Query("SELECT * FROM CCGData WHERE HazardPoint < '100000' AND Hidden = '0'")
				elseif tonumber( ComputerData["Rang"] ) == 1 then
					DataList = sql.Query("SELECT * FROM CCGData WHERE HazardPoint < '10000' AND Hidden = '0'")
				else
					DataList = sql.Query("SELECT * FROM CCGData WHERE HazardPoint < '1000' AND Hidden = '0'")
				end
				local SessionData = {LF = "LoginFinished",
									LoadingDelay = Delay,
									SteamID64 = ComputerData["SteamID64"],
									Rang = ComputerData["Rang"],
									WallPaper = ComputerData["WallPaper"],
									GhoulList = DataList}
				net.Start("CCGComputerClientNetWork")
				net.WriteTable( SessionData )
				net.Send( ply )
			end
		end
	end
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
net.Receive( "CCGComputerServerNetWork", function( len, ply )
local tab = net.ReadTable()
	if tab.Verification == "LoginInfo" then
		UsernamePasswordVERIF( tab.Username, tab.Password, tab.Delay, ply)
	end
end )

function PasswordChange( Username, OldPassword, NewPassword, ConfirmNewPassword, ply )
	if sql.TableExists( "TKGComputer" ) then
		if (sql.Query("SELECT Username FROM TKGComputer WHERE Username = '"..Username.."'")) then
			local ComputerData = sql.QueryRow("SELECT * FROM TKGComputer WHERE Username = '"..Username.."'")
			if OldPassword == ComputerData["Password"] then
				if NewPassword == ConfirmNewPassword then
					sql.Query("UPDATE TKGComputer SET Password = '"..NewPassword.."' WHERE Username = '"..Username.."'")
					ply:PrintMessage( HUD_PRINTTALK, "Votre mot de passe a bien été mis à jour !" )
					for k, v in pairs( player.GetAll() ) do
						if v:SteamID64() == ComputerData["SteamID64"] then
							v:SetNWString("Password", NewPassword )
						end
					end
				else
					ply:PrintMessage( HUD_PRINTTALK, "Une erreur s'est produite ! (91)" )
				end
			else
				ply:PrintMessage( HUD_PRINTTALK, "Une erreur s'est produite ! (92)" )
			end
		else
			ply:PrintMessage( HUD_PRINTTALK, "Une erreur s'est produite ! (93)" )
		end
	end
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
net.Receive( "CCGComputerServerPasswordNetwork", function( len, ply )
local tab = net.ReadTable()
	PasswordChange( tab.Username, tab.OldPassword, tab.NewPassword, tab.ConfirmNewPassword, ply)
end )

function DeleteGhoul( ply, ID, Rang )
	if (sql.Query("SELECT SteamID64 FROM CCGData WHERE SteamID64 = '".. ID .."'")) then
		local rank = tonumber( Rang ) * 5
		local DataList = sql.QueryRow("SELECT * FROM CCGData WHERE SteamID64 = '"..ID.."'")
		sql.Query("UPDATE CCGData SET Hidden = '"..rank.."' WHERE SteamID64 = '"..ID.."'")
		ply:PrintMessage( HUD_PRINTTALK, "Ce profil a bien était supprimé !" )
	end
end

function UpgradeGhoul( ply, ID, Rang )
	if (sql.Query("SELECT SteamID64 FROM CCGData WHERE SteamID64 = '".. ID .."'")) and ply:GetNWInt("UpgradeGhoul", 0) < CurTime() then
		ply:SetNWInt("UpgradeGhoul", CurTime() + 900 )
		local rank = tonumber( Rang ) * 10
		local DataList = sql.QueryRow("SELECT * FROM CCGData WHERE SteamID64 = '"..ID.."'")
		local HazardPoint = tonumber( DataList["HazardPoint"] )+ rank
		sql.Query("UPDATE CCGData SET HazardPoint = '"..HazardPoint.."' WHERE SteamID64 = '"..ID.."'")
		ply:PrintMessage( HUD_PRINTTALK, "Cette ghoul a bien était signalé dangereuse !" )
	end
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function SaveGhoul(ply, ID, Alias, Name, Age, Gender, BloodType, Kagune, RC, Status, Affiliation, Ward)
	if (sql.Query("SELECT SteamID64 FROM CCGData WHERE SteamID64 = '".. ID .."'")) then
		sql.Query("UPDATE CCGData SET Alias = '"..Alias.."', Name = '"..Name.."', Age = '"..Age.."', Gender = '"..Gender.."', BloodType = '"..BloodType.."', Kagune = '"..Kagune.."', RC = '".. RC .."', Status = '".. Status .."', Affiliation = '".. Affiliation .."', Ward = '".. Ward .."'  WHERE SteamID64 = '"..ID.."'")
		ply:PrintMessage( HUD_PRINTTALK, "Ce profil a bien était mis à jour !" )
	end
end

net.Receive( "CCGComputerDataBrowserResult", function( len, ply )
local tab = net.ReadTable()
	if tab.Mode == "Supprimer" then
		DeleteGhoul( ply, tab.ID, tab.Rang )
	elseif tab.Mode == "Upgrade" then
		UpgradeGhoul( ply, tab.ID, tab.Rang )
	elseif tab.Mode == "Sauvegarder" then
		SaveGhoul( ply, tab.ID, tab.Alias, tab.Name, tab.Age, tab.Gender, tab.BloodType, tab.Kagune, tab.RC, tab.Status, tab.Affiliation, tab.Ward )
	end
end )
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */