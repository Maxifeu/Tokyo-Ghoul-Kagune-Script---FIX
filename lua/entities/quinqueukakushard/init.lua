/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

ENT.Size = 0.25
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
function ENT:Initialize()

	local shardmodel = {"models/props_wasteland/rockcliff01c.mdl",
						"models/props_wasteland/rockcliff01e.mdl",
						"models/props_wasteland/rockcliff01g.mdl",}
	
	self:SetModel(shardmodel[ math.random( #shardmodel ) ])
	self:SetMoveType( MOVETYPE_FLYGRAVITY )
	self:SetModelScale( 0.05, 0 )
	self:SetColor( Color( 100, 0, 50, 255 ) )
	self:SetSolid( SOLID_BBOX )
	self:DrawShadow( false )
	self.NotStuck = true
	
	self:SetCollisionBounds(Vector(-self.Size, -self.Size, -self.Size), Vector(self.Size, self.Size, self.Size))
	
	self:SetCollisionGroup( COLLISION_GROUP_INTERACTIVE )
	self:SetNetworkedString("Owner", "World")
	self.RemoveShard = CurTime() + 0.6
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */


function ENT:Think()
	if self.RemoveShard < CurTime() then self:Remove() end
	if self.NotStuck then self:SetAngles(self:GetVelocity():Angle()) end
	self:NextThink(CurTime()) return true
end
/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */

function ENT:Touch( ent )

//if not ent:IsTrigger() then

local speed = self:GetVelocity():Length( )

local ply = self.Owner

local dmg = UKAKUSHARDDMG * self:GetOwner():GetNWInt("QuinxCells", 1.25)

if ent:IsNPC() or ent:IsPlayer() or ent:IsWorld() or ent:IsVehicle() or ent:IsValid() then

if speed < 150 then

//end

if speed >= 150 then
self.NotStuck = false
self:SetMoveType( MOVETYPE_NONE )
self:PhysicsInit( SOLID_NONE )
self:SetParent(ent)
ent:TakeDamage(dmg , self:GetOwner(), self)
self.RemoveShard = CurTime() + 1.2
end
return false end
if ent:IsWorld() then
self.NotStuck = false
self:SetMoveType( MOVETYPE_NONE )
self:PhysicsInit( SOLID_NONE )
self:SetPos(self:GetPos() + self:GetForward()*0)
self.RemoveShard = CurTime() + 1.2
else
if ent:IsValid() then
self.NotStuck = false
self:SetMoveType( MOVETYPE_NONE )
self:PhysicsInit( SOLID_NONE )
self:SetParent(ent)
ent:TakeDamage(dmg , self:GetOwner(), self)
local physforce = speed * dmg
local phy = ent:GetPhysicsObject()
if (IsValid(phy)) then if (IsValid(phy)) then phy:ApplyForceCenter(self:GetForward()*(physforce)) end end
self.RemoveShard = CurTime() + 1.2
self:SetPos(self:GetPos() + self:GetForward()*2)
end
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
phys:Wake()  
phys:EnableGravity(false) 
self:SetMoveType( MOVETYPE_NONE )
self:PhysicsInit( SOLID_NONE )
end
end

/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */





















