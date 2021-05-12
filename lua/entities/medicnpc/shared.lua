/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */
ENT.Type = "ai"
ENT.Base = "base_ai"
 
ENT.PrintName		= "Medic NPC"
ENT.Category 		= "Tokyo Ghoul RP"

ENT.Spawnable = true
ENT.AutomaticFrameAdvance = true
 
function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim
end

/* Copyright (C) Remigius - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Remigius <giuseppi.remigius@gmail.com>, 2018
 */