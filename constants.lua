SCREEN_WIDTH = 1920;

VIRATION = 0.11 -- HMMMMMMMM 0 to 1
DEATH_VIRATION = 0.3 -- HMMMMMMMM 0 to 1

PULL_LENGTH = 450; -- How far player can pull
PULL_LENGTH2 = PULL_LENGTH * PULL_LENGTH; -- Square of how far player can pull
PULL_FORCE = 800; -- Force at which the player pulls the ball
PULL_DAMPENING = 0.8; -- Shitty degradation over length.

PUSH_COST = 0;
PUSH_COOLDOWN = 8;
PUSH_LENGTH = 1000; -- How far player can push
PUSH_LENGTH2 = PUSH_LENGTH * PUSH_LENGTH; -- Square of how far player can push
PUSH_FORCE = 2000; -- Force at which the player pulls the ball
PUSH_ANIMATION = 0.3 -- in sec;

PLAYER_FORCE = 10000; -- Force put on the player to move the joystick
PLAYER_DAMPENING = 5; -- Dampening on player movement
PLAYER_DENSITY = 1.1; -- Player density (higher means more mass)
PLAYER_HITPOINTS = 50;

DEBRIS_DENSITY = 0.5;
DEBRIS_HITPOINTS = 25;
DEBRIS_MIN_LUMINOSITY = 100;

CONTROLL_RANGE = 150;

BALL_DENSITY =0.9;
BALL_DAMAGE = 12;
BALL_RADIUS = 16;
BALL_DAMAGE_SPEED_SCALING = 1000;
BALL_MAX_DAMAGE = 50;
BALL_MAX_VELOCITY = 9999999;
BALL_REBOUND = 0.8; -- 0..1, is 100% energy kept on bounce, 0 is none.

PLAYER_RADIUS = 60; -- Size of the player's circle

PLAYER_ENERGIE_GIVEN = 50; -- pull give energie to other
PLAYER_ENERGIE_MAX = 50; -- pull give energie to other
PLAYER_STARTING_ENERGIE = 50
PLAYER_INVULNERABILITY_DURATION = 1.5; -- Duration of invulnerability following a player's hit (s)

PULLER_FORCE = 750
PULLER_RANGE = 200

PUSHER_FORCE = 750
PUSHER_RANGE = 200

BUMP_FORCE = 300
BUMP_RADIUS = 100
BUMP_PUSH_MIN = 32
BUMP_PUSH_LENGTH = 150
BUMP_PUSH_ANIMATION = 0.2

DEATH_TIMER = 1.3 -- in s

GAME_TRANSITION = 0.6