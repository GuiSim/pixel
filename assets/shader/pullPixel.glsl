
extern number nbPosition;
extern number pullings[4];
extern vec2 positions[4];
extern number length;
extern number startAt;
extern number timer;

vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
{
  float wave = mod(-timer, 1);
  
  float tcX = 0;
  float tcY = 0;
  int nbTc = 0;

  for(int i = 0; i < 4; i++){
  
    vec2 position = positions[i];
    number pulling = pullings[i];
    
    vec2 xy = (screen_coords - position) / length;
    float dist2 = ((xy.x * xy.x) + (xy.y * xy.y));
    
    if(dist2 > 1){
      continue;
    }
    
    float dist = sqrt(dist2);
  
    if(dist * length < startAt){
      return Texel(texture, texture_coords);
    }
    
    if(pulling == 0){
      continue;
    }
    
    float waveDist = abs(dist - wave) / 0.2;
    if(waveDist < 1){
      dist -= (1 - waveDist) * 0.2;
    }
    
    float wavePulling = 0;
    
    vec2 xy2 = (xy) * length;
    xy2 += xy * (1 - dist) * (1 - dist) * length * pulling * 0.25;
    
    vec2 localTc = (position + xy2) / love_ScreenSize.xy;
    
    tcX += localTc.x;
    tcY += localTc.y;
    
    nbTc++;
  }

  if(nbTc == 0){
    return Texel(texture, texture_coords);
  }
  
  vec2 tc = vec2(tcX, tcY) / nbTc;
  
  return Texel(texture, tc);
}
