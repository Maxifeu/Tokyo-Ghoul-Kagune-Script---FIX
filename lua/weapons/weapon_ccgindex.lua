
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
SWEP.PrintName 		      = "Portable Index Finder" 
SWEP.Author 		      = "Remigius" 
SWEP.Instructions 	      = "" 
SWEP.Contact 		      = "Remigius" 
SWEP.AdminSpawnable       = true 
SWEP.Spawnable 		      = true 
SWEP.ViewModelFlip        = false
SWEP.ViewModelFOV 	      = 75
SWEP.ViewModel			  = ""
SWEP.WorldModel			  = ""
SWEP.AutoSwitchTo 	      = false 
SWEP.AutoSwitchFrom       = true 
SWEP.DrawAmmo             = false 
SWEP.Base                 = "weapon_base" 
SWEP.Slot 			      = 2
SWEP.SlotPos              = 1 
SWEP.HoldType             = "normal"
SWEP.DrawCrosshair        = true 
SWEP.Weight               = 0 

SWEP.SetWeaponHoldType    = ( normal )

SWEP.Category             = "Tokyo Ghoul RP"

SWEP.FiresUnderwater      = true 
SWEP.Primary.Automatic    = true
SWEP.Primary.Ammo         = ""
SWEP.Secondary.Automatic  = true
SWEP.Secondary.Ammo       = ""

/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */

function SWEP:Initialize()

	self.primaryattack = {entity = NULL, delay = 0, cooldown = 0}
	self.secondaryattack = {entity = NULL, delay = 0, cooldown = 0}
	
end

function SWEP:ShouldDropOnDie()
	return false
end

function SWEP:OnDrop()
	self:Remove()
end

/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */

function SWEP:PrimaryAttack()
end	
  
function SWEP:SecondaryAttack()
end

function SWEP:Reload()
	local ply = self:GetOwner()
	local trace = ply:GetEyeTraceNoCursor()
	if ply:GetPos():Distance( trace.HitPos ) <= 75 then
		if trace.Entity:GetClass() == "prop_ragdoll" and trace.Entity:GetNWInt("CorpsRC", 0 ) > GHOULLIMITRC then
			if (SERVER) then
				local Kakuhou = ents.Create("kakuhoua")
				Kakuhou:SetPos( trace.HitPos + Vector( 0, 0, 25 ) )
				Kakuhou:SetOwner( ply )
				Kakuhou:SetAngles( Angle( 0, 0, 0) )
				Kakuhou:Spawn()
				Kakuhou:SetNWInt("KakuhouRCells", trace.Entity:GetNWInt("CorpsRC", 0 ) )
				Kakuhou:SetNWInt("KakuhouKagune", trace.Entity:GetNWInt("CorpsKagune", 0 ) )
				for k, v in pairs( player.GetAll() ) do
					if v:UniqueID() == trace.Entity:GetNWInt("CorpsOriginalOwner")  then
						sql.Query("UPDATE TKGRCKagune SET RC = '"..math.max( GHOULLIMITRC, v:GetNWInt("RCells", GHOULLIMITRC)*0.95).."' WHERE SteamID64 = '".. v:SteamID64().."'")
						v:SetNWInt("RCells",  math.max( GHOULLIMITRC, v:GetNWInt("RCells", GHOULLIMITRC)*0.95 ) )
					end
				end
				trace.Entity:Remove()
				ply:PrintMessage( HUD_PRINTTALK, "Le Kakuhou de cette personne a bien était extrait !" )
			end
		end
	end
end

/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */

function SWEP:Think()
	local ply = self:GetOwner()
	local trace = ply:GetEyeTraceNoCursor()
	if ply:GetPos():Distance( trace.HitPos ) <= 75 and trace.Entity:IsValid() then
		if trace.Entity:IsPlayer() or trace.Entity:IsNPC() then
			if ply:KeyDown( IN_ATTACK ) and self.primaryattack.cooldown < CurTime() then
				self.secondaryattack.entity = NULL
				self.secondaryattack.delay = 0
				self.secondaryattack.cooldown = 0
				if self.primaryattack.entity != trace.Entity then
					self.primaryattack.entity = trace.Entity
					self.primaryattack.delay = CurTime() + 2
				elseif self.primaryattack.delay < CurTime() and self.primaryattack.entity == trace.Entity and self.primaryattack.cooldown < CurTime() then
					if (SERVER) then
						ply:PrintMessage( HUD_PRINTTALK , "Après analyze, voici les taux de cette personnes:" )
						ply:PrintMessage( HUD_PRINTTALK , "RC: ".. trace.Entity:GetNWInt("RCells", 200) )
						ply:PrintMessage( HUD_PRINTTALK , "GRC:".. trace.Entity:GetNWInt("ARCGaz", 0 ) )
					end
					self.primaryattack.cooldown = CurTime() + 5
					self.primaryattack.delay = 0
					self.primaryattack.entity = NULL
				end
			elseif ply:KeyDown( IN_ATTACK2 ) and self.secondaryattack.cooldown < CurTime() then
				self.primaryattack.entity = NULL
				self.primaryattack.delay = 0
				self.primaryattack.cooldown = 0
				if self.secondaryattack.entity != trace.Entity then
					self.secondaryattack.entity = trace.Entity
					self.secondaryattack.delay = CurTime() + 2
				elseif self.secondaryattack.delay < CurTime() and self.secondaryattack.entity == trace.Entity and self.secondaryattack.cooldown < CurTime() then
					if trace.Entity:IsPlayer() then
						if (sql.Query("SELECT * FROM CCGData WHERE SteamID64 = '"..trace.Entity:SteamID64().."'") ) then
							if (SERVER) then
								ply:ConCommand( "ccgindex "..ply:SteamID64() )
							end
						else
							if (SERVER) then
								ply:PrintMessage( HUD_PRINTTALK, "Cette personne n'est pas dans les registres du CCG !" )
							end
						end
					else
						if (SERVER) then
							ply:PrintMessage( HUD_PRINTTALK, "Cette personne n'est pas dans les registres du CCG !" )
						end
					end
					self.secondaryattack.cooldown = CurTime() + 5
					self.secondaryattack.delay = 0
					self.secondaryattack.entity = NULL
				end
			end
		end
	end
	if ply:KeyReleased( IN_ATTACK ) or ply:GetPos():Distance( trace.HitPos ) > 75 or trace.Entity != self.primaryattack.entity then
		if self.primaryattack.entity != NULL then
			self.primaryattack.entity = NULL
			self.primaryattack.delay = 0
			self.primaryattack.cooldown = 0
		end
	end
	if ply:KeyReleased( IN_ATTACK2 ) or ply:GetPos():Distance( trace.HitPos ) > 75 or trace.Entity != self.secondaryattack.entity then
		if self.secondaryattack.entity != NULL then
			self.secondaryattack.entity = NULL
			self.secondaryattack.delay = 0
			self.secondaryattack.cooldown = 0
		end
	end
end

/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */

function SWEP:DrawHUD()

	local ScrW = ScrW()
	local ScrH = ScrH()
	
	local gap = 5
	
	local WPos = ScrW/2 - ScrW/6
	local HPos = ScrH/2 - ScrH/20
	if self:GetOwner():KeyDown( IN_ATTACK ) and self.primaryattack.delay >= CurTime() then
		local W2Long = ScrW/3 - (gap*2)
		local H2Long = ScrH/10 - (gap*2)
		local percents = ( 2 - ( self.primaryattack.delay - CurTime() ) )/2
		
		draw.RoundedBox( 4, WPos, HPos, ScrW/3, ScrH/10, Color( 50, 50, 50, 100 ) )
		draw.RoundedBox( 4, WPos + gap, HPos + gap, W2Long*percents, H2Long, Color( 0, 200, 0, 255 ) )
	end
	
	if self:GetOwner():KeyDown( IN_ATTACK2 ) and self.secondaryattack.delay >= CurTime() then
		local W3Long = ScrW/3 - (gap*2)
		local H3Long = ScrH/10 - (gap*2)
		local percents2 = ( 2 - ( self.secondaryattack.delay - CurTime() ) )/2
		
		draw.RoundedBox( 4, WPos, HPos, ScrW/3, ScrH/10, Color( 50, 50, 50, 100 ) )
		draw.RoundedBox( 4, WPos + gap, HPos + gap, W3Long*percents2, H3Long, Color( 0, 200, 0, 255 ) )
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

net.Receive( "CCGIndexFinderReturn", function( len, ply )
local tab = net.ReadTable()
	if tab.Mode != "CCGIndexFinderReturnGhoulInformation" then return end
	SaveGhoul( ply, tab.ID, tab.Alias, tab.Name, tab.Age, tab.Gender, tab.BloodType, tab.Kagune, tab.RC, tab.Status, tab.Affiliation, tab.Ward )
end )
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */

