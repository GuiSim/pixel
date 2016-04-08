Particle = {}

function Particle.playerImpactWithBall()
  local tex = love.graphics.newImage("assets/textures/smoke.png")
  local emitter = love.graphics.newParticleSystem(tex,25)
emitter:setDirection(0)
emitter:setAreaSpread("none",0,0)
emitter:setEmissionRate(300)
emitter:setEmitterLifetime(1)
emitter:setLinearAcceleration(0,0,0,0)
emitter:setParticleLifetime(1,1)
emitter:setRadialAcceleration(200,250)
emitter:setRotation(0,0)
emitter:setTangentialAcceleration(12,27)
emitter:setSpeed(100,250)
emitter:setSpin(0,0)
emitter:setSpinVariation(0)
emitter:setLinearDamping(0,0)
emitter:setSpread(2.7999999523163)
emitter:setRelativeRotation(false)
emitter:setOffset(0,0)
emitter:setSizes(1)
emitter:setSizeVariation(0)
emitter:setColors(255,255,255,255 )
  return emitter;
end

function Particle.ballImpactWithPlayer()
  local tex = love.graphics.newImage("assets/textures/spark.png")
  local emitter = love.graphics.newParticleSystem(tex,50)
emitter:setDirection(0)
emitter:setAreaSpread("none",0,0)
emitter:setEmissionRate(300)
emitter:setEmitterLifetime(1)
emitter:setLinearAcceleration(0,0,0,0)
emitter:setParticleLifetime(1,1)
emitter:setRadialAcceleration(200,250)
emitter:setRotation(0,0)
emitter:setTangentialAcceleration(12,27)
emitter:setSpeed(100,250)
emitter:setSpin(0,0)
emitter:setSpinVariation(0)
emitter:setLinearDamping(0,0)
emitter:setSpread(5.5999999046326)
emitter:setRelativeRotation(false)
emitter:setOffset(0,0)
emitter:setSizes(1)
emitter:setSizeVariation(0)
emitter:setColors(255,255,255,255 )
  return emitter;
end

function Particle.ballMovement()
  local tex = love.graphics.newImage("assets/textures/spark.png")
  local emitter = love.graphics.newParticleSystem(tex,50)
  emitter:setDirection(0)
  emitter:setAreaSpread("uniform",4,8)
  emitter:setEmissionRate(10)
  emitter:setEmitterLifetime(-1)
  emitter:setLinearAcceleration(0,0,0,0)
  emitter:setParticleLifetime(1,1)
  emitter:setRadialAcceleration(0,0)
  emitter:setRotation(0,0)
  emitter:setTangentialAcceleration(0,0)
  emitter:setSpeed(0,0)
  emitter:setSpin(0,0)
  emitter:setSpinVariation(0)
  emitter:setLinearDamping(0,0)
  emitter:setSpread(0)
  emitter:setRelativeRotation(false)
  emitter:setOffset(0,0)
  emitter:setSizes(1)
  emitter:setSizeVariation(0)
  emitter:setColors(255,255,255,255 )
  emitter:setColors(255,255,255,255 )
  return emitter;
end