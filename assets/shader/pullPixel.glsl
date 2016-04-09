
extern number nbPosition;

extern number pullings[6];
extern number pullingsLength[6];
extern number pullingsDirection[6];
extern vec2 pullingsPosition[6];

extern number pushings[8];
extern number pushingsLength[8];
extern vec2 pushingsPosition[8];

extern number length;
extern number startAt;
extern number timer;

vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
{
  float waveIn = mod(-timer, 1);
  float waveOut = mod(timer, 1);
  
  float tcX = 0;
  float tcY = 0;
  int nbTc = 0;

  for(int i = 0; i < 4; i++){
  
    number pulling = pullings[i];
    vec2 position = pullingsPosition[i];
    number pullingLength = pullingsLength[i];
    number direction = pullingsDirection[i];
    
    float wave = direction < 0 ? waveIn : waveOut;
    
    vec2 xy = (screen_coords - position) / pullingLength;
    float dist2 = ((xy.x * xy.x) + (xy.y * xy.y));
    
    if(dist2 > 1){
      continue;
    }
    
    float dist = sqrt(dist2);
    
    float abc = startAt;
  
    // if(dist * pullingLength < startAt){
    //   return Texel(texture, texture_coords);
    // }
    
    if(pulling == 0){
      continue;
    }
    
    float waveDist = abs(dist - wave) / 0.2;
    if(waveDist < 1){
      dist -= (1 - waveDist) * 0.2;
    }
    
    float wavePulling = 0;
    
    vec2 xy2 = (xy) * pullingLength;
    xy2 += xy * (1 - dist) * (1 - dist) * pullingLength * pulling * 0.25;
    
    vec2 localTc = (position + xy2) / love_ScreenSize.xy;
    
    tcX += localTc.x;
    tcY += localTc.y;
    
    nbTc++;
  }
  

  for(int i = 0; i < 4; i++){
  
    number pushing = pushings[i];
    number pushingLength = pushingsLength[i];
    vec2 position = pushingsPosition[i];
    
    vec2 xy = (screen_coords - position) / pushingLength;
    float dist2 = ((xy.x * xy.x) + (xy.y * xy.y));
    
    if(pushing>=1){
      continue;
    }
    
    if(dist2 > 1 ){
      continue;
    }
    
    float dist = sqrt(dist2);

    float waveDist = abs(dist - pushing) / 0.1;//((pushingLength / 1000 ) * 0.099 + 0.001);
    
    if ( waveDist >= 1){
      continue;
    }
    
    vec2 xy2 = (xy) * pushingLength;
    xy2 += xy / dist * (1 - waveDist) * 30;// * (0.5 + (pushingLength / 1000 ) * 0.5) ;
    
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
