extern Image canvas;
extern number pulling;
extern vec2 position;
extern number length;
extern number startAt;
extern number timer;

vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
{
  vec2 xy = (screen_coords - position) / length;
  float dist2 = ((xy.x * xy.x) + (xy.y * xy.y));
  
  if(dist2 > 1){
    return vec4(0,0,0,0);
  }
  
  float dist = sqrt(dist2);
  
  if(dist * length < startAt){
    return vec4(0,0,0,0);
  }
  
  
  
  vec2 xy2 = (xy) * length + xy * (1 - dist) * length * pulling * sin(timer);
  
  vec2 tc = (position + xy2) / love_ScreenSize.xy;
  
  vec4 texcolor = Texel(canvas, tc);
  
  float a = dist * pulling;
  
  return texcolor;
}
