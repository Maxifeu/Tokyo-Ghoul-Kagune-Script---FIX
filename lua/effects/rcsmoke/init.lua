//Initial effect
function EFFECT:Init( data )
	
	local NumParticles = 25
	
	local emitter = ParticleEmitter( data:GetOrigin() )
	
		for i=0, NumParticles do

			local Pos = ( data:GetOrigin() + Vector( math.Rand(-50,50), math.Rand(-50,50), math.Rand(-32,32) ) + Vector(0,0,50) )
		
			local particle = emitter:Add( "particles/smokey", Pos )
			if (particle) then
				
				particle:SetVelocity( VectorRand() * math.Rand(1920,2142) )
				
				particle:SetLifeTime( 0 )
				particle:SetDieTime( math.Rand(7, 9 ) )
				
				particle:SetColor(215, 215, 225)			

				particle:SetStartAlpha( math.Rand( 50, 150  ) )
				
				local Size = math.Rand(110,130)
				particle:SetStartSize( math.Rand( 64, 128 ) )
				particle:SetEndSize( math.Rand( 64, 128 ) )
				
				particle:SetRoll( math.Rand( -0.2, 0.2 ) )
				
				particle:SetAirResistance( math.Rand(520,620) )
				
				particle:SetGravity( Vector( 0, 0, math.Rand(-32, -64) ) )

				particle:SetCollide( true )
				particle:SetBounce( 0.42 )

				
			end
			
		end
		
	emitter:Finish()
	
end

//Not used
function EFFECT:Think( )
	return false
end

//Not used
function EFFECT:Render()
end