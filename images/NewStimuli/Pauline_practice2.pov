#include "colors.inc"
#include "textures.inc"camera {  location <-2, 3, -20>  look_at <0, 0, 0>
}
sphere
{
<0,0,0> 8
texture {
pigment{ color rgb <1.8, 1, 1> }
normal{
wrinkles 0.7
}
}}sphere
{
<0,2,3>
texture {
pigment{ color rgb <1, 1.3, 1> }
light_source { <10, 10, -10> color White }light_source { <-10, 5, -15> color White }