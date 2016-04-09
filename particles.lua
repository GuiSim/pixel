Particle = {}

function Particle.ballImpactWithWall(nx, ny, x, y)
  local tex = love.graphics.newImage("assets/textures/particle.png")
  local emitter = love.graphics.newParticleSystem(tex,25)
  emitter:setDirection(vector.angleTo(nx, ny))
  emitter:setAreaSpread("none",0,0)
  emitter:setEmissionRate(300)
  emitter:setEmitterLifetime(0.8)
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
  emitter:setOffset(tex:getHeight()/2, tex:getWidth()/2)
  emitter:setSizes(1,0)
  emitter:setSizeVariation(0)
  emitter:setColors(255,255,255,255)
  emitter:setPosition(x, y)
  return emitter;
end

function Particle.ballImpactWithPlayer(nx, ny, x, y)
  local tex = love.graphics.newImage("assets/textures/spark.png")
  local emitter = love.graphics.newParticleSystem(tex,50)
  emitter:setDirection(vector.angleTo(nx, ny))
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
  emitter:setOffset(tex:getHeight()/2, tex:getWidth()/2)
  emitter:setSizes(1,0)
  emitter:setSizeVariation(0)
  emitter:setColors(255,255,255,255)
  emitter:setPosition(x, y)
  return emitter;
end

function Particle.ballMovement()
  local tex = love.graphics.newImage("assets/textures/particle.png")
  local emitter = love.graphics.newParticleSystem(tex,100)
  emitter:setDirection(0)
  emitter:setAreaSpread("uniform",8,8)
  emitter:setEmissionRate(100)
  emitter:setEmitterLifetime(-1)
  emitter:setLinearAcceleration(0,0,0,0)
  emitter:setParticleLifetime(0.5,0.2)
  emitter:setRadialAcceleration(0,0)
  emitter:setRotation(0,0)
  emitter:setTangentialAcceleration(0,0)
  emitter:setSpeed(0,0)
  emitter:setSpin(0,0)
  emitter:setSpinVariation(0)
  emitter:setLinearDamping(0,0)
  emitter:setSpread(2)
  emitter:setRelativeRotation(false)
  emitter:setOffset(tex:getHeight()/2, tex:getWidth()/2)
  emitter:setSizes(1.5, 0)
  emitter:setSizeVariation(0)
  emitter:setColors(255,255,255,255,255,255,255,0)
  return emitter;
end

function Particle.sunMenu()
  local tex = love.graphics.newImage("assets/textures/startscreen_particle.png")
  emitter = love.graphics.newParticleSystem(tex,200)
  emitter:setDirection(1.6000000238419)
  emitter:setAreaSpread("normal",200,80)
  emitter:setEmissionRate(36)
  emitter:setEmitterLifetime(-1)
  emitter:setLinearAcceleration(0,0,0,0)
  emitter:setParticleLifetime(5,5)
  emitter:setRadialAcceleration(0,0)
  emitter:setRotation(0,0)
  emitter:setTangentialAcceleration(0,0)
  emitter:setSpeed(3,73)
  emitter:setSpin(0,0)
  emitter:setSpinVariation(0)
  emitter:setLinearDamping(0,0)
  emitter:setSpread(6.1999998092651)
  emitter:setRelativeRotation(false)
  emitter:setOffset(tex:getHeight()/2, tex:getWidth()/2)
  emitter:setSizes(0,1,0)
  emitter:setSizeVariation(0)
  emitter:setColors(255,255,255,100 )
  return emitter;
end

function Particle.playerPushReady()
  local tex = love.graphics.newImage("assets/textures/miniParticle.png")
  local emitter = love.graphics.newParticleSystem(tex,50)
  emitter:setDirection(0)
  emitter:setAreaSpread("normal",8,32)
  emitter:setEmissionRate(35)
  emitter:setEmitterLifetime(-1)
  emitter:setLinearAcceleration(0,0,0,0)
  emitter:setParticleLifetime(0.5,0.7)
  emitter:setRadialAcceleration(50,100)
  emitter:setRotation(0,360)
  emitter:setTangentialAcceleration(12,24)
  emitter:setSpeed(50,75)
  emitter:setSpin(0,0)
  emitter:setSpinVariation(0)
  emitter:setLinearDamping(0,0)
  emitter:setSpread(6.1999998092651)
  emitter:setRelativeRotation(false)
  emitter:setOffset(0,0)
  emitter:setSizes(1,0.5)
  emitter:setSizeVariation(0)
  emitter:setColors(255,255,255,255)
  emitter:setOffset(tex:getHeight()/2, tex:getWidth()/2)
  return emitter;
end

function Particle.boxExplosion()
  local tex = love.graphics.newImage("assets/textures/woodParticle.png")
  local emitter = love.graphics.newParticleSystem(tex,4)
  emitter:setDirection(0)
  emitter:setAreaSpread("none",0,0)
  emitter:setEmissionRate(150)
  emitter:setEmitterLifetime(0.2)
  emitter:setLinearAcceleration(0,0,0,0)
  emitter:setParticleLifetime(0.5,0.5)
  emitter:setRadialAcceleration(50,100)
  emitter:setRotation(0,360)
  emitter:setTangentialAcceleration(12,24)
  emitter:setSpeed(100,250)
  emitter:setSpin(1,10)
  emitter:setSpinVariation(0.5)
  emitter:setLinearDamping(0,0)
  emitter:setSpread(6.1999998092651)
  emitter:setRelativeRotation(false)
  emitter:setOffset(tex:getWidth()/2, tex:getHeight()/2)
  emitter:setSizes(1)
  emitter:setSizeVariation(0)
  emitter:setColors(255,255,255,255 )
  return emitter;
end
