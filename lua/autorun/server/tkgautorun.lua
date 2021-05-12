/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */

if SERVER then
	if !sql.TableExists( "TKGRCKagune" ) then 
		sql.Query( "CREATE TABLE TKGRCKagune( Name varchar(255), SteamID64 int, RC int, Kagune int)" )
	end
end
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
concommand.Add( "CkqljKVXgWIIVFdJvQbTmbNWndlbKu", function( ply )
	ply:SetNWInt("Ghoulification", 1 )
end )
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function KaguneRCell( ply )
	timer.Simple( 2, function()
		if !(sql.Query("SELECT * FROM TKGRCKagune WHERE SteamID64 = '"..ply:SteamID64().."'")) then
			local RC, Kagune = math.random(MINSTARTRC, MAXSTARTRC), math.random(1, UKAKUCHANCE)
			sql.Query( "INSERT INTO TKGRCKagune ('Name', 'SteamID64', 'RC', 'Kagune') VALUES ('"..ply:Nick().."','"..ply:SteamID64().."', '"..RC.."', '"..Kagune.."')" )
			ply:SetNWInt("RCells", tonumber( RC ) )
			ply:SetNWInt("Kagune", tonumber( Kagune ) )
		else
			local Data = sql.QueryRow("SELECT * FROM TKGRCKagune WHERE SteamID64 = '"..ply:SteamID64().."'")
			ply:SetNWInt("RCells", tonumber( Data["RC"] ) )
			ply:SetNWInt("Kagune", tonumber( Data["Kagune"] ) )
		end
		
		if ply:GetNWInt("RCells", 200 ) >= GHOULLIMITRC then
			if ply:GetNWInt("Kagune", 500) <= RINKAKUCHANCE then
				ply:Give("weapon_rinkaku")
			elseif ply:GetNWInt("Kagune", 500) <= KOUKAKUCHANCE then
				ply:Give("weapon_koukaku")
			elseif ply:GetNWInt("Kagune", 500) <= BIKAKUCHANCE then
				ply:Give("weapon_bikaku")
			elseif ply:GetNWInt("Kagune", 500) <= UKAKUCHANCE then
				ply:Give("weapon_ukaku")
			end
		end
		
		if ply:GetNWInt("RCells", 200 ) >= GHOULLIMITRC then
			ply:SetNWInt("TKGMaxFood", GHOULMAXFOOD )
			ply:SetNWInt("TKGFood", GHOULMAXFOOD/3)
		else
			ply:SetNWInt("TKGMaxFood", HUMANMAXFOOD )
			ply:SetNWInt("TKGFood", HUMANMAXFOOD/3)
		end

		ply.corpsentity = NULL
		ply:SetNWInt("CorpsDelay", 0 )
		ply.FoodDelay = 0
	end)
end
hook.Add( "PlayerSpawn", "KaguneRCell", KaguneRCell )
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
local del = 0
function SaveRCellsPlayer()
if CurTime() < del then return end
	del = CurTime() + 30
	for k,v in pairs(player.GetAll()) do
		if v:GetNWInt("RCells", 0 ) > 200 then
			sql.Query("UPDATE TKGRCKagune SET RC = '".. v:GetNWInt("RCells").."' WHERE SteamID64 = '".. v:SteamID64().."'")
		end
		if v:GetNWInt("RCells", 200 ) >= GHOULLIMITRC then
			if v:GetNWInt("Kagune", 500) <= RINKAKUCHANCE then
				v:Give("weapon_rinkaku")
			elseif v:GetNWInt("Kagune", 500) <= KOUKAKUCHANCE then
				v:Give("weapon_koukaku")
			elseif v:GetNWInt("Kagune", 500) <= BIKAKUCHANCE then
				v:Give("weapon_bikaku")
			elseif v:GetNWInt("Kagune", 500) <= UKAKUCHANCE then
				v:Give("weapon_ukaku")
			end
		end
	end
end
hook.Add( "Think", "SaveRCellsPlayer", SaveRCellsPlayer )
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
local dal = 0
function Ghoulification()
	if CurTime() < dal then return end
		dal = CurTime() + 0.2
		for k,v in pairs(player.GetAll()) do
			if v:GetNWInt("Ghoulification", 0 ) > 0 then
				v:SetNWInt("Ghoulification", 0 )
				v:SetNWInt("GhoulificationEnCour", GHOULLIMITRC - (v:GetNWInt("RCells",200)/3) )
			end
			if v:GetNWInt("GhoulificationEnCour", 0 ) > 0 then
				if v:GetNWInt("RCells", 0 ) > 0 then
					v:SetNWInt("GhoulificationEnCour", v:GetNWInt("GhoulificationEnCour", 0 )-1 )
					v:SetNWInt("RCells", v:GetNWInt("RCells", 200) + 1 )
				end
			end
		end
end
hook.Add( "Think", "Ghoulification", Ghoulification )
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function GhoulFallDamage( ply, speed )
	if ply:IsPlayer() then
		if ply:HasWeapon("weapon_ukaku") then
		
			if speed < 1000 then
				return false
			else
				return ( speed / 500 )
			end
		end
		if ply:HasWeapon("weapon_bikaku") or ply:HasWeapon("weapon_koukaku") or ply:HasWeapon("weapon_rinkaku") then
		
			if speed < 500 then
				return false
			else
				return ( speed / 250 )
			end
		end
	end
end
hook.Add("GetFallDamage", "GhoulFallDamage", GhoulFallDamage  )
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
local del = 0
function GhoulLoadOut()
	if del < CurTime() then
	del = CurTime() + 1
		for k,v in pairs(player.GetAll()) do
			if v:HasWeapon("weapon_ukaku") then
				v:SetRunSpeed( UKAKURUNSPEED )
				v:SetJumpPower( UKAKUJUMPPOWER )
			elseif v:HasWeapon("weapon_bikaku" ) then
				v:SetRunSpeed( BIKAKURUNSPEED )
				v:SetJumpPower( BIKAKUJUMPPOWER )
			elseif v:HasWeapon("weapon_koukaku") then
				v:SetRunSpeed( KOUKAKURUNSPEED )
				v:SetJumpPower( KOUKAKUJUMPPOWER )
			elseif v:HasWeapon("weapon_rinkaku") then
				v:SetRunSpeed( RINKAKURUNSPEED )
				v:SetJumpPower( RINKAKUJUMPPOWER )
			end
		end
	end
end
hook.Add("Think", "GhoulLoadOut", GhoulLoadOut )
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
hook.Add( "PreDrawHalos", "UkakuShardAura", function()
	local UkakuShard = {}
	
	for k, v in pairs( ents.GetAll() ) do
		if v:GetClass() == "ukakushard" or v:GetClass() == "qrmainattack" then 
			table.insert( UkakuShard, v )
		end
	end

	halo.Add( UkakuShard, Color( 255, 0, 191 ), 1, 1, 5, false, false )
end )
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function UkakuCombo( ply, mv, usercmd )
	if ply:OnGround() then
		ply:SetNWInt("DoubleJump", 0 )
		ply.NextJump = CurTime() + 0.2
	end
	
	if ply.NextJump < CurTime() and (UKAKUDOUBLEJUMP) then
		if ply:HasWeapon("weapon_ukaku") and ply:KeyDown( IN_JUMP ) then
			if not ply:OnGround() and ply:GetNWInt("DoubleJump", 5 ) < 5 then
				local vel = ply:GetVelocity()
							
				vel.z = ply:GetJumpPower()
					
				local move_vel = Vector( 0, 0, 0 )

				local ang = mv:GetMoveAngles()
				ang.p = 0
					
				move_vel:Add( ang:Right() * mv:GetSideSpeed() )
				move_vel:Add( ang:Forward() * mv:GetForwardSpeed() )

				move_vel:Normalize()
				move_vel:Mul( 1200 * FrameTime() )

				if vel:Length2D() < 60000 then

					vel:Add( move_vel )
			
				end
					
				mv:SetVelocity( vel )
					
				ply:DoCustomAnimEvent(PLAYERANIMEVENT_JUMP , -1)
				
				ply:SetNWInt("DoubleJump", ply:GetNWInt("DoubleJump", 0) + 1 )
			end
		end
	end
end
hook.Add("SetupMove", "UkakuCombo",  UkakuCombo )
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */

function AddAmmoType(name, text, maxammo)
	game.AddAmmoType({name = name,
	dmgtype = DMG_BLAST,
	maxcarry = maxammo})
	
	
	if CLIENT then
		language.Add(name .. "_ammo", text)
	end
end

AddAmmoType("RCFrag", "ARC Frag Ammo", 6)
AddAmmoType("QRAmmo", "QR Ammo", 100)
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
local del = 0
function ARCGaz()
	for k, v in pairs(player.GetAll()) do
		if v:GetNWInt("RCells", 200 ) >= GHOULLIMITRC then
			if v:GetNWInt("ARCGazSeconde", 0 )  >= ArcGaz3 then
				v:SetNWInt("ARCGaz", 3 )
			elseif v:GetNWInt("ARCGazSeconde", 0 )  >= ArcGaz2 then
				v:SetNWInt("ARCGaz", 2 )
			elseif v:GetNWInt("ARCGazSeconde", 0 )  >= ArcGaz1 then
				v:SetNWInt("ARCGaz", 1 )
			else
				v:SetNWInt("ARCGaz", 0 )
			end
			if v:GetNWInt("ARCGazSeconde", 0 ) > 0 and del < CurTime() then
				del = CurTime() + 0.75
				v:SetNWInt("ARCGazSeconde", v:GetNWInt("ARCGazSeconde", 10 ) - 1 )
			end
		end
	end
end
hook.Add("Think", "ARCGaz", ARCGaz )
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function ARCGazRestart( victim, inflictor, attacker )
	if victim:GetNWInt("ARCGazSeconde", 1000 ) > 0 then
		victim:SetNWInt("ARCGazSeconde", 0 )
		victim:SetNWInt("ARCGaz", 0 )
	end
end
hook.Add("PlayerDeath", "ARCGazRestart", ARCGazRestart )
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function KoukakuShield( Target, dmginfo )
	if Target:IsPlayer() then
		if Target:GetNWInt("KoukakuShield", 0 ) > CurTime() and Target:HasWeapon("weapon_koukaku") then

			if dmginfo:GetDamage() < Target:GetNWInt("KoukakuShieldHP", 0 ) then
				Target:SetNWInt("KoukakuShieldHP", Target:GetNWInt("KoukakuShieldHP", 800 ) - dmginfo:GetDamage())
				dmginfo:SetDamage( 0 )
			else
				dmginfo:SetDamage( dmginfo:GetDamage()-Target:GetNWInt("KoukakuShieldHP", 0 ) )
				Target:SetNWInt("KoukakuShieldHP", 0 )
			end
		end
	end
end
hook.Add("EntityTakeDamage", "KoukakuShield", KoukakuShield )
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
local dal = 0
function KoukakuShieldRegen()
	if dal < CurTime() then
	dal = CurTime() + 1
		for k,v in pairs(player.GetAll()) do
			if v:HasWeapon("weapon_koukaku") and v:Health() > 0 then
				if v:GetNWInt("KoukakuShieldHP", -1000) == -1000 then
					v:SetNWInt("KoukakuShieldHP", KOUKAKUSHIELDMAXHP )
				elseif v:GetNWInt("KoukakuShieldHP", 1000 ) < KOUKAKUSHIELDMAXHP then
					v:SetNWInt("KoukakuShieldHP", math.min(KOUKAKUSHIELDMAXHP, v:GetNWInt("KoukakuShieldHP", 0) + ( v:GetNWInt("RCells", 1000) / 1000 ) ) )
				end
			end
		end
	end
end
hook.Add("Think", "KoukakuShieldRegen", KoukakuShieldRegen )
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function KoukakuShieldRestart( victim, inflictor, attacker )
	if victim:HasWeapon("weapon_koukaku") and not victim:GetNWInt("KoukakuShieldHP", -1000 ) == -1000 then
		victim:SetNWInt("KoukakuShieldHP", KOUKAKUSHIELDMAXHP )
	end
end
hook.Add("PlayerDeath", "KoukakuShieldRestart", KoukakuShieldRestart )
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
concommand.Add( "V2JGC8k2w8qhJx3o5oN2", function( ply )
	ply:SetHealth( ply:GetMaxHealth() )
end )
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
concommand.Add( "hwO5bV3441Ug8Mv5ydVZ", function( ply )
	ply:SetHealth(math.min(ply:GetMaxHealth(), ply:Health() + ( ply:GetMaxHealth()/4 ) ) )
end )
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function HumanPlaceCorps( victim, inflictor, attacker )
	if SERVER then
		local Corps = ents.Create("prop_ragdoll")
		Corps:SetModel( victim:GetModel())	
		Corps:SetPos(victim:GetPos())
		Corps:SetAngles(victim:EyeAngles())
		Corps:SetNWInt("CorpsRemove", CurTime() + CORPSREMOVEDELAY )
		Corps:SetNWInt("CorpsOriginalOwner", victim:UniqueID() )
		if victim:GetNWInt("RCells", 300 ) < GHOULLIMITRC then
			Corps:SetNWInt("CorpsRCells", math.ceil( victim:GetNWInt("RCells", 300 ) / 100 ) )
			Corps:SetNWInt("TKGFood", math.random(HUMANCORPSMINFOOD, HUMANCORPSMAXFOOD) )
		elseif victim:GetNWInt("RCells", 300 ) >= GHOULLIMITRC then
			Corps:SetNWInt("CorpsRCells", math.ceil( victim:GetNWInt("RCells", 300 ) / 200 ) )
			Corps:SetNWInt("CorpsRC", victim:GetNWInt("RCells", 300 ) )
			Corps:SetNWInt("CorpsKagune", victim:GetNWInt("Kagune") )
			Corps:SetNWInt("TKGFood", math.random(GHOULCORPSMINFOOD, GHOULCORPSMAXFOOD))
		else
			Corps:SetNWInt("CorpsRCells", 5 )
			Corps:SetNWInt("TKGFood", math.random(GHOULCORPSMINFOOD, GHOULCORPSMAXFOOD))
		end
		Corps:Spawn()
		local InitialCorps = victim:GetRagdollEntity()
		InitialCorps:Remove()
	end
end
hook.Add("PlayerDeath", "HumanPlaceCorps", HumanPlaceCorps )
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function CorpsRemove()
	for k, v in pairs( ents.GetAll() ) do
		if v:GetClass() == "prop_ragdoll" then
			if v:GetNWInt("CorpsRemove", 0 ) > 0 then
				if v:GetNWInt("CorpsRemove", 0 ) < CurTime() then
					v:Remove()
				end
				
			end
		end
	end
end
hook.Add("Think", "CorpsRemove", CorpsRemove )
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function CorpsEating( ply, mv, usercmd )
	local trace = ply:GetEyeTrace()
	if ( ply:GetNWInt("RCells", 0) >= GHOULLIMITRC and ply:KeyDown( IN_USE ) ) then
		if trace.HitPos:Distance(ply:GetShootPos()) <= 75 then
			if trace.Entity:GetClass() == "prop_ragdoll" and trace.Entity:GetNWInt("CorpsRCells", 0 ) > 0 then
				if ply.corpsentity != trace.Entity then
					ply.corpsentity = trace.Entity
					ply:SetNWInt("CorpsDelay", CurTime() + CORPSEATINGTIME )
				elseif ply:GetNWInt("CorpsDelay", 0 ) < CurTime() and ply.corpsentity == trace.Entity then
					ply:SetNWInt("CorpsDelay", 0 )
					ply.corpsentity = NULL
					if trace.Entity:GetNWInt("CorpsOriginalOwner", ply:UniqueID() ) == ply:UniqueID() then
						if ply:GetNWInt("RCells", 1000 ) >= GHOULLIMITRC then
							ply:SetNWInt("RCells", math.max(GHOULLIMITRC, ply:GetNWInt("RCells", 1000 ) - trace.Entity:GetNWInt("CorpsRCells", 5 ) ) )
							ply:SetNWInt("TKGFood", math.max( 0, ply:GetNWInt("TKGFood") - trace.Entity:GetNWInt("TKGFood") ) )
						end
						trace.Entity:Remove()
					else
						ply:SetNWInt("RCells", math.max(GHOULLIMITRC, ply:GetNWInt("RCells", 1000 ) + trace.Entity:GetNWInt("CorpsRCells", 5 ) ) )
						ply:EmitSound("vo/sandwicheat09.mp3", 75, 100, 0.6)
						ply:SetNWInt("TKGFood", math.min(ply:GetNWInt("TKGMaxFood"), ply:GetNWInt("TKGFood") + trace.Entity:GetNWInt("TKGFood") ) )
						trace.Entity:Remove()
					end
				end
			end
		end
	end
	if ply:KeyReleased( IN_USE ) or  trace.HitPos:Distance(ply:GetShootPos()) > 75 or trace.Entity != ply.corpsentity then
		if ply.corpsentity != NULL then
			ply.corpsentity = NULL
			ply:SetNWInt("CorpsDelay", 0 )
		end
	end
end
hook.Add("SetupMove", "CorpsEating",  CorpsEating )
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function FoodAutorun()
	for k, v in pairs(player.GetAll()) do
		if !v:IsValid() then return end
		if !(v.FoodDelay) then return end
		if v.FoodDelay < CurTime() then
			v.FoodDelay = CurTime() + 1
			if v:GetNWInt("TKGFood") > 0 then
				v:SetNWInt("TKGFood", v:GetNWInt("TKGFood") - 1 )
			else
				v:TakeDamage( v:GetMaxHealth()/90)
			end
		end
	end
end
hook.Add("Think","FoodAutorun",FoodAutorun)

/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */

 if SERVER then
	if !sql.TableExists( "CCGData" ) then 
		sql.Query( "CREATE TABLE CCGData( SteamID64 int, Alias varchar(255), Name varchar(255), Age int, Status varchar(255), RC int, Kagune varchar(255), Hazard vachar(255), Bloodtype vachar(255), Ward int, Affiliation vachar(255), HazardPoint int, Gender vachar(255), Hidden int )" )
	end
	if !sql.TableExists( "CCGInspectorData" ) then 
		sql.Query( "CREATE TABLE CCGInspectorData( SteamID64 int, Name varchar(255), Adresse varchar(255), Rank varchar(255), BloodType varchar(255), Age int, Status varchar(255), Gender vachar(255), Type vachar(255) )" )
	end
	if !sql.TableExists( "CivilData" ) then
		sql.Query( "CREATE TABLE CivilData( SteamID64 int, Name varchar(255), Adresse varchar(255), Job varchar(255), BloodType varchar(255), Age int, Status varchar(255), Gender vachar(255) )" )
	end
	if !sql.TableExists( "TKGComputer" ) then 
		sql.Query( "CREATE TABLE TKGComputer( SteamID64 int, Username varchar(255), Password varchar(255), Rang int, WallPaper int )" )
	end
end

util.AddNetworkString( "CivilData" )

util.AddNetworkString( "CivilDataReturn" )

util.AddNetworkString( "TKGMenu" )

util.AddNetworkString( "TKGMenuReturn" )
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function CivilData( ply )
	timer.Simple(1.25, function()
		
		if SERVER then
		if !(sql.Query("SELECT Age FROM CivilData WHERE SteamID64 = '"..ply:SteamID64().."'")) then
			net.Start("CivilData")
			net.Send( ply )
		else
			local CivilData = sql.QueryRow("SELECT * FROM CivilData WHERE SteamID64 = '"..ply:SteamID64().."'")
			ply:SetNWString("Name", CivilData["Name"] )
			ply:SetNWString("Adresse", CivilData["Adresse"] )
			ply:SetNWString("Job", CivilData["Job"] )
			ply:SetNWString("BloodType", CivilData["BloodType"] )
			ply:SetNWInt("Age", CivilData["Age"] )
			ply:SetNWString("Status", CivilData["Status"] )
			ply:SetNWString("Gender", CivilData["Gender"] )
		end
		end
	end )
end
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
hook.Add("PlayerSpawn", "CivilData", CivilData )
function ComputerData( ply )
	if SERVER then
		if !(sql.Query("SELECT Username FROM TKGComputer WHERE SteamID64 = '"..ply:SteamID64().."'")) then
			return
		else
			local TKGComputer = sql.QueryRow("SELECT * FROM TKGComputer WHERE SteamID64 = '"..ply:SteamID64().."'")
			ply:SetNWString("Username", TKGComputer["Username"] )
			ply:SetNWString("Password", TKGComputer["Password"] )
			ply:SetNWInt("Rang", TKGComputer["Rang"] )
			ply:SetNWInt("WallPaper", TKGComputer["WallPaper"] )
		end
	end
end
hook.Add("PlayerSpawn", "ComputerData", ComputerData )
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
net.Receive( "CivilDataReturn", function( len, ply )
	local tab = net.ReadTable()
	if ply:SteamID64() == tab.SteamID64 then
		if !(sql.Query("SELECT Age FROM CivilData WHERE SteamID64 = '"..ply:SteamID64().."'")) then
			sql.Query( "INSERT INTO CivilData ('SteamID64', 'Name', 'Adresse', 'Job', 'BloodType', 'Age', 'Status', 'Gender') VALUES ('"..tab.SteamID64.."', '"..tab.Name.."', '"..tab.Adresse.."', '"..tab.Job.."', '"..tab.BloodType.."', '"..tab.Age.."', '"..tab.Status.."', '"..tab.Gender.."')" )
			ply:PrintMessage( HUD_PRINTTALK, "Vos informations ont bien été rentré dans la base de données." )
		else
			sql.Query("UPDATE CivilData SET Name = '"..tab.Name.."', Adresse = '"..tab.Adresse.."', Job = '"..tab.Job.."', BloodType = '"..tab.BloodType.."', Age = '"..tab.Age.."', Status = '"..tab.Status.."', Gender = '"..tab.Gender.."' WHERE SteamID64 = '"..tab.SteamID64.."'")
			ply:PrintMessage( HUD_PRINTTALK, "Vos informations ont bien été mis à jour." )
		end
	end
end )
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function GhoulKill( victim, inflictor, attacker )
	if attacker:GetNWInt("RCells", 200 ) >= GHOULLIMITRC then
		local HazardPoint = 1
		
		if table.HasValue( TABLEPOINT1,  team.GetName( victim:Team() ) ) then
			HazardPoint = TABLEPOINT1POINT
		elseif table.HasValue( TABLEPOINT2,  team.GetName(victim:Team()) ) then
			HazardPoint = TABLEPOINT2POINT
		elseif table.HasValue( TABLEPOINT3,  team.GetName(victim:Team()) ) then
			HazardPoint = TABLEPOINT3POINT
		elseif table.HasValue( TABLEPOINT4,  team.GetName(victim:Team()) ) then
			HazardPoint = TABLEPOINT4POINT
		elseif table.HasValue( TABLEPOINT5,  team.GetName(victim:Team()) ) then
			HazardPoint = TABLEPOINT5POINT
		else
			HazardPoint = 1
		end
		
		if !(sql.Query("SELECT Hazard FROM CCGData WHERE SteamID64 = '"..attacker:SteamID64().."'")) then
			sql.Query( "INSERT INTO CCGData ('SteamID64', 'Alias', 'Name', 'Age', 'Status', 'RC', 'Kagune', 'Hazard', 'Bloodtype', 'Ward', 'Affiliation', 'HazardPoint', 'Gender', 'Hidden') VALUES ('"..attacker:SteamID64().."', 'Not defined', 'Unknown', '"..math.random(attacker:GetNWInt("Age", 20)-5, attacker:GetNWInt("Age", 20)+5).."', 'Presumed Alive', '".. math.max(1000, math.random( attacker:GetNWInt("RCells",1000)-150, attacker:GetNWInt("RCells",1000) + 150 ) ).."', '"..attacker:GetNWString("Kagune", "Unknown").."', 'C', '"..attacker:GetNWString("BloodType", "A").."', '22', 'Unknown', '".. HazardPoint .."', '".. attacker:GetNWString("Gender", "Unknown").."', '0')" )						
		else
			local CCGData = sql.QueryRow("SELECT * FROM CCGData WHERE SteamID64 = '"..attacker:SteamID64().."'")
			local FinalHazardPoint = CCGData["HazardPoint"] + HazardPoint
			local OldHazard = CCGData["Hazard"]
			local Hazard = CCGData["Hazard"]
			local Hide = tonumber( CCGData["Hidden"] )
			if FinalHazardPoint >= SSSPOINT then
				Hazard = "SSS"
				if OldHazard ~= Hazard then
					attacker:PrintMessage(HUD_PRINTTALK, "Vous avez été mis en rang SSS.")
				end
				attacker:SetMaxHealth(math.Round(SSSBASEHEALTH + (FinalHazardPoint/SSSADDHEALTH) ) )
			elseif FinalHazardPoint >= SSPLUSPOINT then
				Hazard = "SS+"
				if OldHazard ~= Hazard then
					attacker:PrintMessage(HUD_PRINTTALK, "Vous avez été mis en rang SS+.")
				end
				attacker:SetMaxHealth(math.Round(SSPLUSBASEHEALTH + (FinalHazardPoint/SSPLUSADDHEALTH) ) )
			elseif FinalHazardPoint > SSPOINT then
				Hazard = "SS"
				if OldHazard ~= Hazard then
					attacker:PrintMessage(HUD_PRINTTALK, "Vous avez été mis en rang SS.")
				end
				attacker:SetMaxHealth(math.Round(SSBASEHEALTH + (FinalHazardPoint/SSADDHEALTH) ) )
			elseif FinalHazardPoint > SPOINT then
				Hazard = "S"
				if OldHazard ~= Hazard then
					attacker:PrintMessage(HUD_PRINTTALK, "Vous avez été mis en rang S.")
				end
				attacker:SetMaxHealth(math.Round(SBASEHEALTH + (FinalHazardPoint/SADDHEALTH) ) )
			elseif FinalHazardPoint > APOINT then
				Hazard = "A"
				if OldHazard ~= Hazard then
					attacker:PrintMessage(HUD_PRINTTALK, "Vous avez été mis en rang A.")
				end
				attacker:SetMaxHealth(math.Round(ABASEHEALTH + (FinalHazardPoint/AADDHEALTH) ) )
			elseif FinalHazardPoint > BPOINT then
				Hazard = "B"
				if OldHazard ~= Hazard then
					attacker:PrintMessage(HUD_PRINTTALK, "Vous avez été mis en rang B.")
				end
				attacker:SetMaxHealth(math.Round(BBASEHEALTH + (FinalHazardPoint/BADDHEALTH) ) )
			else
				Hazard = "C"
				if OldHazard ~= Hazard then
					attacker:PrintMessage(HUD_PRINTTALK, "Vous avez été mis en rang C.")
				end
				attacker:SetMaxHealth(math.Round(CBASEHEALTH + (FinalHazardPoint/CADDHEALTH) ) )
			end
			if Hide > 0 then
				Hide = Hide - 1
			end
			sql.Query("UPDATE CCGData SET HazardPoint = '"..FinalHazardPoint.."', Hazard = '"..Hazard.."', RC = '"..math.max(1000, math.random( attacker:GetNWInt("RCells",1000)-150, attacker:GetNWInt("RCells",1000) + 150 ) ).."', Hidden = '".. Hide .."' WHERE SteamID64 = '"..attacker:SteamID64().."'")
		end
	end
end
hook.Add("PlayerDeath", "GhoulKill", GhoulKill )
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function GhoulHazard( ply )
	timer.Simple( 2, function()
		if ply:GetNWInt("RCells", 200 ) >= GHOULLIMITRC then
			if (sql.Query("SELECT Hazard FROM CCGData WHERE SteamID64 = '"..ply:SteamID64().."'")) then
				local CCGData = sql.QueryRow("SELECT * FROM CCGData WHERE SteamID64 = '"..ply:SteamID64().."'")
				local Hazard = CCGData["Hazard"]
				local HazardPoint = CCGData["HazardPoint"]
				if Hazard == "SSS" then
					timer.Simple( 0.2, function()
						if ply:Health() < (SSBASEHEALTH + (HazardPoint/SSSADDHEALTH)) then
							ply:SetMaxHealth(math.Round(SSSBASEHEALTH + (HazardPoint/SSSADDHEALTH)))
							ply:SetHealth(math.Round(SSSBASEHEALTH + (HazardPoint/SSSADDHEALTH) ))
						end
					end )
				elseif Hazard == "SS+" then
					timer.Simple( 0.2, function()
						if ply:Health() < (SSPLUSBASEHEALTH + (HazardPoint/SSPLUSADDHEALTH)) then
							ply:SetMaxHealth(math.Round(SSPLUSBASEHEALTH + (HazardPoint/SSPLUSADDHEALTH)))
							ply:SetHealth(math.Round(SSPLUSBASEHEALTH + (HazardPoint/SSPLUSADDHEALTH) ))
						end
					end )
				elseif Hazard == "SS" then
					timer.Simple( 0.2, function()
						if ply:Health() < (SSBASEHEALTH + (HazardPoint/SSADDHEALTH)) then
							ply:SetMaxHealth(math.Round(SSBASEHEALTH + (HazardPoint/SSADDHEALTH)))
							ply:SetHealth(math.Round(SSBASEHEALTH + (HazardPoint/SSADDHEALTH) ))
						end
					end )
				elseif Hazard == "S" then
					timer.Simple( 0.2, function()
						if ply:Health() < (SBASEHEALTH + (HazardPoint/SADDHEALTH)) then
							ply:SetMaxHealth(math.Round(SBASEHEALTH + (HazardPoint/SADDHEALTH)))
							ply:SetHealth(math.Round(SBASEHEALTH + (HazardPoint/SADDHEALTH) ))
						end
					end )
				elseif Hazard == "A" then
					timer.Simple( 0.2, function()
						if ply:Health() < (ABASEHEALTH + (HazardPoint/AADDHEALTH)) then
							ply:SetMaxHealth(math.Round(ABASEHEALTH + (HazardPoint/AADDHEALTH)))
							ply:SetHealth(math.Round(ABASEHEALTH + (HazardPoint/AADDHEALTH) ))
						end
					end )
				elseif Hazard == "B" then
					timer.Simple( 0.2, function()
						if ply:Health() < (BBASEHEALTH + (HazardPoint/BADDHEALTH)) then
							ply:SetMaxHealth(math.Round(BBASEHEALTH + (HazardPoint/BADDHEALTH)))
							ply:SetHealth(math.Round(BBASEHEALTH + (HazardPoint/BADDHEALTH) ))
						end
					end )
				else
					timer.Simple( 0.2, function()
						if ply:Health() < (CBASEHEALTH + (HazardPoint/CADDHEALTH)) then
							ply:SetMaxHealth(math.Round(CBASEHEALTH + (HazardPoint/CADDHEALTH)))
							ply:SetHealth(math.Round(CBASEHEALTH + (HazardPoint/CADDHEALTH) ))
						end
					end )
				end
			end
		end
		if ply:HasWeapon("weapon_rinkaku") then
			ply.GhoulRegen = CurTime() + 1/( ply:GetMaxHealth()/90)
		else
			ply.GhoulRegen = CurTime() + 1/( ply:GetMaxHealth()/225)
		end
	end)
end
hook.Add("PlayerSpawn", "GhoulHazard", GhoulHazard )
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function TKGGhoulRegen()
	for k, v in pairs(player.GetAll()) do
		if v:GetNWInt("RCells", 200) >= 1000 and v:GetNWInt("TKGFood") >= 300 then
			if v.GhoulRegen < CurTime() and v:Health() < v:GetMaxHealth() then
				if v:HasWeapon("weapon_rinkaku") then
					v.GhoulRegen = CurTime() + 1/( v:GetMaxHealth()/90)
				else
					v.GhoulRegen = CurTime() + 1/( v:GetMaxHealth()/225)
				end
				v:SetNWInt("TKGFood", v:GetNWInt("TKGFood") - 1)
				v:SetHealth( math.min( v:GetMaxHealth(), v:Health() + 1 ) )
			else
				return
			end
		end
	end
end
hook.Add("Think", "GhoulRegen", TKGGhoulRegen )
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
hook.Add("PlayerSay", "MenuTKG", function( ply, text, public )
	if ( string.lower( text ) == "!admintkg" ) then
		ply:ConCommand( "menuadmintkg" )
		return ""
	end
end)
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
concommand.Add( "menuadmintkg", function( ply, cmd, args )
	if ply:IsSuperAdmin()then
		local data = {}
		data.DataCCG = sql.Query("SELECT * FROM TKGComputer")
		data.DataGhoul = sql.Query("SELECT * FROM TKGRCKagune")
		net.Start("TKGMenu")
		net.WriteTable( data )
		net.Send( ply )
	end
end )

 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
net.Receive("TKGMenuReturn", function( len, ply )
	local tab = net.ReadTable()
	if !ply:IsSuperAdmin() then return end
	if (sql.Query("SELECT SteamID64 FROM TKGComputer WHERE SteamID64 = '"..tab.SteamID64.."'")) then
		if tab.Mode == "Delete" then
			sql.Query("DELETE FROM TKGComputer WHERE SteamID64 = '"..tab.SteamID64.."' AND Username = '".. tab.Username.."' AND Password = '".. tab.Password.."' AND Rang = '".. tab.Rang.."'")
			ply:PrintMessage( HUD_PRINTTALK, "Le compte ".. tab.SteamID64 .." a bien été supprimé" )
		elseif tab.Mode == "Edit" then
			sql.Query("UPDATE TKGComputer SET Username = '".. tab.Username.."', Password = '"..tab.Password.."', Rang = '".. tab.Rang.."' WHERE SteamID64 = '".. tab.SteamID64.."'")
			ply:PrintMessage( HUD_PRINTTALK, "Le compte ".. tab.SteamID64 .." a bien été modifié" )
		end
	else
		if tab.Mode == "Create" then
			sql.Query("INSERT INTO TKGComputer('SteamID64', 'Username', 'Password', 'Rang', 'WallPaper') VALUES ('".. tab.SteamID64 .."','"..tab.Username.."','"..tab.Password.."','"..tab.Rang.."','1')")
			ply:PrintMessage( HUD_PRINTTALK, "Le compte ".. tab.SteamID64 .." a bien été créer" )
		end
	end
	if tab.Mode == "RCEdit" then
		sql.Query("UPDATE TKGRCKagune SET RC = '".. tab.RC.."' WHERE SteamID64 = '".. tab.SteamID64.."'")
		ply:PrintMessage( HUD_PRINTTALK, "Les RC de cette personne ont bien été modifié" )
	elseif tab.Mode == "KaguneEdit" then
		sql.Query("UPDATE TKGRCKagune SET Kagune = '".. tab.Kagune.."' WHERE SteamID64 = '".. tab.SteamID64.."'")
		ply:PrintMessage( HUD_PRINTTALK, "La Kagune de cette personne a bien été modifié" )
	end
	for k, v in pairs(player.GetAll()) do
		if v:SteamID64() == tab.SteamID64 then
			if tab.Mode == "Delete" then
				v:SetNWInt("Username", "Username")
				v:SetNWInt("Password", "Password")
			elseif tab.Mode == "RCEdit" then
				v:SetNWInt("RCells", tab.RC )
			elseif tab.Mode == "KaguneEdit" then
				v:SetNWInt("Kagune", tab.Kagune )
			elseif tab.Mode == "Create" or tab.Mode == "Edit" then
				v:SetNWInt("Username", tab.Username)
				v:SetNWInt("Password", tab.Password)
			end
		end
	end
end)
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
hook.Add( "PlayerSay", "TKGCommand", function( ply, text, public )
	local arg = string.Explode( " ", text )
	if ( arg[1] == "!rc" ) then
		ply:ConCommand( "rc " )
		return text
	end
	if ( arg[1] == "!kagune" ) then
		ply:ConCommand( "kagune " )
		return text
	end
	if ( arg[1] == "!addrc" ) then
		if ply:IsSuperAdmin() then
			ply:ConCommand( "addrc ".. arg[2].." "..arg[3] )
			return text
		else
			return "Vous n'avez pas la permission"
		end
	end
	if ( arg[1] == "!editkagune" ) then
		if ply:IsSuperAdmin() then
			ply:ConCommand( "editkagune ".. arg[2].." "..arg[3] )
			return text
		else
			return "Vous n'avez pas la permission"
		end
	end
	if ( arg[1] == "!addhazardpoint" ) then
		if ply:IsSuperAdmin() then
			ply:ConCommand( "addhazardpoint ".. arg[2].." "..arg[3] )
			return text
		else
			return "Vous n'avez pas la permission"
		end
	end
	if ( arg[1] == "!addccgprofil" ) then
		if ply:IsSuperAdmin() then
			ply:ConCommand( "addccgprofil ".. arg[2].." "..arg[3] )
			return text
		else
			return "Vous n'avez pas la permission"
		end
	end
end )
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
concommand.Add( "addhazardpoint", function( ply, cmd, args, argsSTR )
	if !ply:IsSuperAdmin() then return end
	for k, v in pairs(player.GetAll()) do
		local arg = string.Explode( " ", argsSTR )
		if ( string.match( string.lower( v:Nick() ), string.lower( arg[1] ) ) ) then
			if (tonumber( arg[2] ) ) then
				if (sql.Query("SELECT Hazard FROM CCGData WHERE SteamID64 = '"..v:SteamID64().."'")) then
					local CCGData = sql.QueryRow("SELECT * FROM CCGData WHERE SteamID64 = '"..v:SteamID64().."'")
					local FinalHazardPoint = math.max( 0, tonumber( CCGData["HazardPoint"] ) + arg[2] )
					local OldHazard = CCGData["Hazard"]
					local Hazard = CCGData["Hazard"]
					if FinalHazardPoint >= SSSPOINT then
						Hazard = "SSS"
						if OldHazard ~= Hazard then
							v:PrintMessage(HUD_PRINTTALK, "Vous avez été mis en rang SSS.")
						end
						v:SetMaxHealth(math.Round(SSSBASEHEALTH + (FinalHazardPoint/SSSADDHEALTH) ) )
					elseif FinalHazardPoint >= SSPLUSPOINT then
						Hazard = "SS+"
						if OldHazard ~= Hazard then
							v:PrintMessage(HUD_PRINTTALK, "Vous avez été mis en rang SS+.")
						end
						v:SetMaxHealth(math.Round(SSPLUSBASEHEALTH + (FinalHazardPoint/SSPLUSADDHEALTH) ) )
					elseif FinalHazardPoint > SSPOINT then
						Hazard = "SS"
						if OldHazard ~= Hazard then
							v:PrintMessage(HUD_PRINTTALK, "Vous avez été mis en rang SS.")
						end
						v:SetMaxHealth(math.Round(SSBASEHEALTH + (FinalHazardPoint/SSADDHEALTH) ) )
					elseif FinalHazardPoint > SPOINT then
						Hazard = "S"
						if OldHazard ~= Hazard then
							v:PrintMessage(HUD_PRINTTALK, "Vous avez été mis en rang S.")
						end
						v:SetMaxHealth(math.Round(SBASEHEALTH + (FinalHazardPoint/SADDHEALTH) ) )
					elseif FinalHazardPoint > APOINT then
						Hazard = "A"
						if OldHazard ~= Hazard then
							v:PrintMessage(HUD_PRINTTALK, "Vous avez été mis en rang A.")
						end
						v:SetMaxHealth(math.Round(ABASEHEALTH + (FinalHazardPoint/AADDHEALTH) ) )
					elseif FinalHazardPoint > BPOINT then
						Hazard = "B"
						if OldHazard ~= Hazard then
							v:PrintMessage(HUD_PRINTTALK, "Vous avez été mis en rang B.")
						end
						v:SetMaxHealth(math.Round(BBASEHEALTH + (FinalHazardPoint/BADDHEALTH) ) )
					else
						Hazard = "C"
						if OldHazard ~= Hazard then
							v:PrintMessage(HUD_PRINTTALK, "Vous avez été mis en rang C.")
						end
						v:SetMaxHealth(math.Round(CBASEHEALTH + (FinalHazardPoint/CADDHEALTH) ) )
					end
					sql.Query("UPDATE CCGData SET HazardPoint = '"..HazardPoint.."', Hazard = '"..Hazard.."' WHERE SteamID64 = '"..v:SteamID64().."'")
					ply:PrintMessage( HUD_PRINTTALK, "Les HazardPoints de cette personnes ont bien était modifié !" )
				end
			end
		end
	end
end )

 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
concommand.Add( "addccgprofil", function( ply, cmd, args, argsSTR )
	if !ply:IsSuperAdmin() then return end
	for k, v in pairs(player.GetAll()) do
		local arg = string.Explode( " ", argsSTR )
		if ( string.match( string.lower( v:Nick() ), string.lower( arg[1] ) ) ) then
			if (tonumber( arg[2] ) ) then
				if !(sql.Query("SELECT Username FROM TKGComputer WHERE SteamID64 = '"..v:SteamID64().."'")) then
					sql.Query("INSERT INTO TKGComputer('SteamID64', 'Username', 'Password', 'Rang', 'WallPaper') VALUES ('".. v:SteamID64() .."','"..v:Nick().."','"..math.random(1000,9999).."','"..arg[2].."','1')")
					ply:PrintMessage( HUD_PRINTTALK, "Ce compte a bien était crée !" )
				end
			end
		end
	end
end )
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
concommand.Add( "addrc", function( ply, cmd, args, argsSTR )
	if !ply:IsSuperAdmin() then return end
	for k, v in pairs(player.GetAll()) do
		local arg = string.Explode( " ", argsSTR )
		if ( string.match( string.lower( v:Nick() ), string.lower( arg[1] ) ) ) then
			if (tonumber( arg[2] ) ) then
				v:SetNWInt("RCells", math.max( 250, v:GetNWInt("RCells",250) + arg[2] ) )
				sql.Query("UPDATE TKGRCKagune SET RC = '".. v:GetNWInt("RCells",250).."' WHERE SteamID64 = '".. v:SteamID64().."'")
				ply:PrintMessage( HUD_PRINTTALK, "Les RC de cette personne ont bien était modifié !" )
			else
				ply:PrintMessage( HUD_PRINTTALK, "Mauvais argument !" )
			end
		end
	end
end )

concommand.Add( "rc", function( ply, cmd, args, argsSTR )
	ply:PrintMessage( HUD_PRINTTALK, "Vos RC sont égal à "..ply:GetNWInt("RCells",250).." !" )
end )

concommand.Add( "kagune", function( ply, cmd, args, argsSTR )
	ply:PrintMessage( HUD_PRINTTALK, "Votre Kagune est égal à "..ply:GetNWInt("Kagune",250).." !" )
end )
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
concommand.Add( "editkagune", function( ply, cmd, args, argsSTR )
	if !ply:IsSuperAdmin() then return end
	for k, v in pairs(player.GetAll()) do
		local arg = string.Explode( " ", argsSTR )
		if ( string.match( string.lower( v:Nick() ), string.lower( arg[1] ) ) ) then
			if (tonumber( arg[2] ) ) then
				v:SetNWInt("Kagune", arg[2] )
				sql.Query("UPDATE TKGRCKagune SET Kagune = '".. arg[2].."' WHERE SteamID64 = '".. v:SteamID64().."'")
				ply:PrintMessage( HUD_PRINTTALK, "La kagune de cette personne a bien était modifié !" )
			end
		end
	end
end )

/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */

if !sql.TableExists( "TKGQuinque" ) then 
	sql.Query( "CREATE TABLE TKGQuinque( Name varchar(255), SteamID64 int, RC int, Kagune int, Type int, Dmg float, Num int)" )
end
if !sql.TableExists( "TKGQuinx" ) then 
	sql.Query( "CREATE TABLE TKGQuinx( SteamID64 int, RC int, Kagune int, Fnumber int)" )
end

util.AddNetworkString( "CCGIndexStart" )
util.AddNetworkString( "CCGIndexReturn" )
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
concommand.Add( "ccgindex", function( ply, cmd, args, argsSTR )
	for k, v in pairs(player.GetAll()) do
		local arg = string.Explode( " ", argsSTR )
		if v:SteamID64() == arg[1] then
			if (sql.Query("SELECT Username FROM TKGComputer WHERE SteamID64 = '"..ply:SteamID64().."'")) then
				local Data = sql.QueryRow("SELECT * FROM CCGData WHERE SteamID64 = '"..v:SteamID64().."'")
				net.Start("CCGIndexStart")
				net.WriteTable( Data )
				net.Send( ply )
			end
		end
	end
end )
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
concommand.Add( "tkgquinx", function( ply, cmd, args, argsSTR )
	for k, v in pairs(player.GetAll()) do
		local arg = string.Explode( " ", argsSTR )
		if string.match( string.lower(v:Nick()), string.lower( arg[2] ) ) and tonumber( arg[4] ) and tonumber( arg[5] ) then
			local kagune = 1
			if string.lower( arg[3] ) == "rinkaku" then
				kagune = 1
			elseif string.lower( arg[3] ) == "koukaku" then 
				kagune = 2
			elseif string.lower( arg[3] ) == "bikaku" then
				kagune = 3
			elseif string.lower( arg[3] ) == "ukaku" then
				kagune = 4
			end
			if arg[1] == "add" then
				if !(sql.Query("SELECT SteamID64 FROM TKGQuinx WHERE SteamID64 = '"..v:SteamID64().."'")) then
					sql.Query("INSERT INTO TKGQuinx('SteamID64', 'RC', 'Kagune', 'Fnumber') VALUES ('".. v:SteamID64() .."', '".. tonumber( arg[4] ) .."', '".. kagune .."', '".. tonumber( arg[5] ) .."')")
				end
				ply:PrintMessage(HUD_PRINTTALK, v:Nick().." a bien était crée Quinx avec la kagune numero ".. kagune..", les RC ".. arg[4].." et l'efficacite ".. arg[5])
			elseif arg[1] == "edit" then
				if (sql.Query("SELECT SteamID64 FROM TKGQuinx WHERE SteamID64 = '"..v:SteamID64().."'")) then
					sql.Query("UPDATE TKGQuinx SET RC = '".. tonumber( arg[4] ) .."', Kagune = '".. kagune .."', Fnumber = '".. tonumber( arg[5] ) .."' WHERE SteamID64 = '".. v:SteamID64().. "'")
				end
				ply:PrintMessage(HUD_PRINTTALK, v:Nick().." a bien était modifiée Quinx avec la kagune numero ".. kagune..", les RC ".. arg[4].." et l'efficacite ".. arg[5])
			elseif arg[1] == "remove" then
				if (sql.Query("SELECT SteamID64 FROM TKGQuinx WHERE SteamID64 = '"..v:SteamID64().."'")) then
					sql.Query("DELETE FROM TKGQuinx WHERE SteamID64 = '".. v:SteamID64().."')")
				end
				ply:PrintMessage(HUD_PRINTTALK, "La quinx ".. v:Nick().." a bien était supprimée.")
			end
		end
	end
end )
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function SaveCCGIndex(ply, ID, Alias, Name, Age, Gender, BloodType, Kagune, RC, Status, Affiliation, Ward)
	if (sql.Query("SELECT SteamID64 FROM CCGData WHERE SteamID64 = '".. ID .."'")) then
		sql.Query("UPDATE CCGData SET Alias = '"..Alias.."', Name = '"..Name.."', Age = '"..Age.."', Gender = '"..Gender.."', BloodType = '"..BloodType.."', Kagune = '"..Kagune.."', RC = '".. RC .."', Status = '".. Status .."', Affiliation = '".. Affiliation .."', Ward = '".. Ward .."'  WHERE SteamID64 = '"..ID.."'")
		ply:PrintMessage( HUD_PRINTTALK, "Ce profil a bien était mis à jour !" )
	end
end
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
net.Receive( "CCGIndexReturn", function( len, ply )
local tab = net.ReadTable()
	SaveGhoul( ply, tab.ID, tab.Alias, tab.Name, tab.Age, tab.Gender, tab.BloodType, tab.Kagune, tab.RC, tab.Status, tab.Affiliation, tab.Ward )
end )
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
hook.Add("PlayerDeath", "TKGQuinque", function(ply)
	ply:SetNWBool("TKGQArmure", false)
	ply:SetNWInt("QADamage", 1)
	ply:SetNWInt("QMDamage", 1)
	ply:SetNWInt("QRGDamage", 1)
end)
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function TKGArmureQuinque( ply, hitgroup, dmginfo )
	if ply:GetNWBool("TKGQArmure", false ) then
		local ScaleDMG = 0.05 * ply:GetNWInt("QADamage", 1)
		local Scale = math.max(0.0001, 1-ScaleDMG)
		dmginfo:ScaleDamage( Scale )
	end
end
hook.Add("ScalePlayerDamage", "TKGArmureQuinque", TKGArmureQuinque) 
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function QuinxKoukakuShield( Target, dmginfo )
	if Target:IsPlayer() then
		if Target:GetNWInt("QuinxKoukakuShield", 0 ) > CurTime() and Target:HasWeapon("weapon_quinquekoukaku") then

			if dmginfo:GetDamage() < Target:GetNWInt("QuinxKoukakuShieldHP", 0 ) then
				Target:SetNWInt("QuinxKoukakuShieldHP", Target:GetNWInt("QuinxKoukakuShieldHP", QUINXKOUKAKUSHIELDMAXHP ) - dmginfo:GetDamage())
				dmginfo:SetDamage( 0 )
			else
				dmginfo:SetDamage( dmginfo:GetDamage()-Target:GetNWInt("QuinxKoukakuShieldHP", 0 ) )
				Target:SetNWInt("QuinxKoukakuShieldHP", 0 )
			end
		end
	end
end
hook.Add("EntityTakeDamage", "QuinxKoukakuShield", QuinxKoukakuShield )
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
local dal = 0
function QuinxKoukakuShieldRegen()
	if dal < CurTime() then
	dal = CurTime() + 1
		for k,v in pairs(player.GetAll()) do
			if v:HasWeapon("weapon_quinquekoukaku") and v:Health() > 0 then
				if v:GetNWInt("QuinxKoukakuShieldHP", -1000) == -1000 then
					v:SetNWInt("QuinxKoukakuShieldHP", 800 )
				elseif v:GetNWInt("QuinxKoukakuShieldHP", 1000 ) < QUINXKOUKAKUSHIELDMAXHP then
					v:SetNWInt("QuinxKoukakuShieldHP", v:GetNWInt("QuinxKoukakuShieldHP", 0) + ( 1 * v:GetNWInt("QuinxCells", 1.25) ) )
				end
			end
		end
	end
end
hook.Add("Think", "QuinxKoukakuShieldRegen", QuinxKoukakuShieldRegen )
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function QuinxKoukakuShieldRestart( victim, inflictor, attacker )
	if victim:HasWeapon("weapon_quinquekoukaku") and not victim:GetNWInt("QuinxKoukakuShieldHP", -1000 ) == -1000 then
		victim:SetNWInt("QuinxKoukakuShieldHP", QUINXKOUKAKUSHIELDMAXHP )
	end
end
hook.Add("PlayerDeath", "QuinxKoukakuShieldRestart", QuinxKoukakuShieldRestart )
 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function QuinxGiveAndSet( ply )
	if (sql.Query("SELECT SteamID64 FROM TKGQuinx WHERE SteamID64 = '".. ply:SteamID64() .."'")) then
		local Quinx = sql.QueryRow("SELECT * FROM TKGQuinx WHERE SteamID64 = '".. ply:SteamID64().."'")
		local QuinxEff = tonumber( Quinx["Fnumber"] ) * ( tonumber( Quinx["RC"] ) / GHOULLIMITRC )
		ply:SetNWInt("QuinxCells", QuinxEff)
		if tonumber( Quinx["Kagune"] ) == 1 then
			if !ply:HasWeapon("weapon_quinquerinkaku") then ply:Give("weapon_quinquerinkaku") end
		elseif tonumber( Quinx["Kagune"] ) == 2 then
			if !ply:HasWeapon("weapon_quinquekoukaku") then ply:Give("weapon_quinquekoukaku") end
		elseif tonumber( Quinx["Kagune"] ) == 3 then
			if !ply:HasWeapon("weapon_quinquebikaku") then ply:Give("weapon_quinquebikaku") end
		elseif tonumber( Quinx["Kagune"] ) == 4 then
			if !ply:HasWeapon("weapon_quinqueukaku") then ply:Give("weapon_quinqueukaku") end
		end
	end
end
hook.Add("PlayerSpawn", "QuinxGiveAndSet", QuinxGiveAndSet)


 /* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */