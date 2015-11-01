// Compiled shader for all platforms, uncompressed size: 22.5KB

Shader "Proland/Atmo/SkyExtinction" {
SubShader { 
 Tags { "QUEUE"="Geometry+1" }


 // Stats for Vertex shader:
 //       d3d11 : 10 math
 //        d3d9 : 14 math
 // Stats for Fragment shader:
 //       d3d11 : 48 math, 2 branch
 //        d3d9 : 68 math, 2 texture
 Pass {
  Tags { "QUEUE"="Geometry+1" }
  ZTest False
  ZWrite Off
  Cull Front
  Blend DstColor Zero
Program "vp" {
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX
uniform mat4 _Globals_CameraToWorld;
uniform mat4 _Globals_ScreenToCamera;
uniform mat4 _Sun_WorldToLocal;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = 0.0;
  tmpvar_1.xyz = (_Globals_ScreenToCamera * gl_Vertex).xyz;
  vec3 tmpvar_2;
  tmpvar_2 = (_Globals_CameraToWorld * tmpvar_1).xyz;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Sun_WorldToLocal[0].xyz;
  tmpvar_3[1] = _Sun_WorldToLocal[1].xyz;
  tmpvar_3[2] = _Sun_WorldToLocal[2].xyz;
  vec4 tmpvar_4;
  tmpvar_4.zw = vec2(1.0, 1.0);
  tmpvar_4.xy = gl_Vertex.xy;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = gl_MultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (tmpvar_3 * tmpvar_2);
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform float Rg;
uniform float Rt;
uniform sampler2D _Sky_Transmittance;
uniform float _Extinction_Tint;
uniform float _Extinction_Cutoff;
uniform vec3 _Globals_WorldCameraPos;
uniform vec3 _Globals_Origin;
uniform float _Globals_ApparentDistance;
uniform float extinctionMultiplier;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD1);
  vec3 camera_3;
  camera_3 = (_Globals_WorldCameraPos - (_Globals_Origin * _Globals_ApparentDistance));
  vec3 extinction_4;
  float mu_5;
  float r_6;
  float tmpvar_7;
  tmpvar_7 = sqrt(dot (camera_3, camera_3));
  r_6 = tmpvar_7;
  float tmpvar_8;
  tmpvar_8 = dot (camera_3, tmpvar_2);
  mu_5 = (tmpvar_8 / tmpvar_7);
  float f_9;
  f_9 = (((tmpvar_8 * tmpvar_8) - (tmpvar_7 * tmpvar_7)) + (Rt * Rt));
  float tmpvar_10;
  if ((f_9 >= 0.0)) {
    tmpvar_10 = sqrt(f_9);
  } else {
    tmpvar_10 = 1e+30;
  };
  float tmpvar_11;
  tmpvar_11 = max ((-(tmpvar_8) - tmpvar_10), 0.0);
  if ((tmpvar_11 > 0.0)) {
    camera_3 = (camera_3 + (tmpvar_11 * tmpvar_2));
    mu_5 = ((tmpvar_8 + tmpvar_11) / Rt);
    r_6 = Rt;
  };
  float y_over_x_12;
  y_over_x_12 = (((mu_5 + 0.15) / 1.15) * 14.1014);
  float x_13;
  x_13 = (y_over_x_12 * inversesqrt(((y_over_x_12 * y_over_x_12) + 1.0)));
  vec2 tmpvar_14;
  tmpvar_14.x = ((sign(x_13) * (1.5708 - (sqrt((1.0 - abs(x_13))) * (1.5708 + (abs(x_13) * (-0.214602 + (abs(x_13) * (0.0865667 + (abs(x_13) * -0.0310296))))))))) / 1.5);
  tmpvar_14.y = sqrt(((r_6 - Rg) / (Rt - Rg)));
  extinction_4 = texture2DLod (_Sky_Transmittance, tmpvar_14, 0.0).xyz;
  if ((r_6 > Rt)) {
    extinction_4 = vec3(1.0, 1.0, 1.0);
  };
  float tmpvar_15;
  tmpvar_15 = sqrt(dot (extinction_4, extinction_4));
  if ((tmpvar_15 >= _Extinction_Cutoff)) {
    vec4 tmpvar_16;
    tmpvar_16.w = 1.0;
    tmpvar_16.xyz = extinction_4;
    tmpvar_1 = tmpvar_16;
  } else {
    vec4 tmpvar_17;
    tmpvar_17.w = 1.0;
    tmpvar_17.xyz = (extinctionMultiplier * ((_Extinction_Tint * extinction_4) + ((1.0 - _Extinction_Tint) * sqrt(dot (extinction_4, extinction_4)))));
    tmpvar_1 = tmpvar_17;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 14 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [_Globals_CameraToWorld]
Matrix 4 [_Globals_ScreenToCamera]
Matrix 8 [_Sun_WorldToLocal]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
def c12, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mov r1.w, c12.x
dp4 r1.z, v0, c6
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mov o2.xyz, r0
dp3 o3.z, r0, c10
dp3 o3.y, r0, c9
dp3 o3.x, r0, c8
mov o0.xy, v0
mov o0.zw, c12.y
mov o1.xy, v1
"
}
SubProgram "d3d11 " {
// Stats: 10 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 384
Matrix 144 [_Globals_CameraToWorld]
Matrix 208 [_Globals_ScreenToCamera]
Matrix 320 [_Sun_WorldToLocal]
BindCB  "$Globals" 0
"vs_4_0
eefiecedlcindejcjibafomacbmhonlpccdhadaaabaaaaaaheadaaaaadaaaaaa
cmaaaaaakaaaaaaaciabaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklfdeieefceeacaaaaeaaaabaajbaaaaaafjaaaaaeegiocaaa
aaaaaaaabhaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadgaaaaaf
dccabaaaaaaaaaaaegbabaaaaaaaaaaadgaaaaaimccabaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaiadpaaaaiadpdgaaaaafdccabaaaabaaaaaaegbabaaa
acaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaaaaaaaaa
aoaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaa
apaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaaaaaaaaabaaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaak
lcaabaaaaaaaaaaaegiicaaaaaaaaaaaajaaaaaaagaabaaaaaaaaaaaegaibaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaalaaaaaakgakbaaa
aaaaaaaaegadbaaaaaaaaaaadgaaaaafhccabaaaacaaaaaaegacbaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaabfaaaaaa
dcaaaaaklcaabaaaaaaaaaaaegiicaaaaaaaaaaabeaaaaaaagaabaaaaaaaaaaa
egaibaaaabaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaaaaaaaaabgaaaaaa
kgakbaaaaaaaaaaaegadbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 _Globals_CameraToWorld;
uniform highp mat4 _Globals_ScreenToCamera;
uniform highp mat4 _Sun_WorldToLocal;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 0.0;
  tmpvar_1.xyz = (_Globals_ScreenToCamera * _glesVertex).xyz;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Globals_CameraToWorld * tmpvar_1).xyz;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Sun_WorldToLocal[0].xyz;
  tmpvar_3[1] = _Sun_WorldToLocal[1].xyz;
  tmpvar_3[2] = _Sun_WorldToLocal[2].xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(1.0, 1.0);
  tmpvar_4.xy = _glesVertex.xy;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (tmpvar_3 * tmpvar_2);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
uniform highp float Rg;
uniform highp float Rt;
uniform sampler2D _Sky_Transmittance;
uniform highp float _Extinction_Tint;
uniform highp float _Extinction_Cutoff;
uniform highp vec3 _Globals_WorldCameraPos;
uniform highp vec3 _Globals_Origin;
uniform highp float _Globals_ApparentDistance;
uniform highp float extinctionMultiplier;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD1);
  highp vec3 camera_3;
  camera_3 = (_Globals_WorldCameraPos - (_Globals_Origin * _Globals_ApparentDistance));
  highp vec3 extinction_4;
  highp float mu_5;
  highp float r_6;
  highp float tmpvar_7;
  tmpvar_7 = sqrt(dot (camera_3, camera_3));
  r_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = dot (camera_3, tmpvar_2);
  mu_5 = (tmpvar_8 / tmpvar_7);
  highp float f_9;
  f_9 = (((tmpvar_8 * tmpvar_8) - (tmpvar_7 * tmpvar_7)) + (Rt * Rt));
  highp float tmpvar_10;
  if ((f_9 >= 0.0)) {
    tmpvar_10 = sqrt(f_9);
  } else {
    tmpvar_10 = 1e+30;
  };
  highp float tmpvar_11;
  tmpvar_11 = max ((-(tmpvar_8) - tmpvar_10), 0.0);
  if ((tmpvar_11 > 0.0)) {
    camera_3 = (camera_3 + (tmpvar_11 * tmpvar_2));
    mu_5 = ((tmpvar_8 + tmpvar_11) / Rt);
    r_6 = Rt;
  };
  highp vec3 tmpvar_12;
  highp float y_over_x_13;
  y_over_x_13 = (((mu_5 + 0.15) / 1.15) * 14.1014);
  highp float x_14;
  x_14 = (y_over_x_13 * inversesqrt(((y_over_x_13 * y_over_x_13) + 1.0)));
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((sign(x_14) * (1.5708 - (sqrt((1.0 - abs(x_14))) * (1.5708 + (abs(x_14) * (-0.214602 + (abs(x_14) * (0.0865667 + (abs(x_14) * -0.0310296))))))))) / 1.5);
  tmpvar_15.y = sqrt(((r_6 - Rg) / (Rt - Rg)));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2DLodEXT (_Sky_Transmittance, tmpvar_15, 0.0);
  tmpvar_12 = tmpvar_16.xyz;
  extinction_4 = tmpvar_12;
  if ((r_6 > Rt)) {
    extinction_4 = vec3(1.0, 1.0, 1.0);
  };
  highp float tmpvar_17;
  tmpvar_17 = sqrt(dot (extinction_4, extinction_4));
  if ((tmpvar_17 >= _Extinction_Cutoff)) {
    highp vec4 tmpvar_18;
    tmpvar_18.w = 1.0;
    tmpvar_18.xyz = extinction_4;
    tmpvar_1 = tmpvar_18;
  } else {
    highp vec4 tmpvar_19;
    tmpvar_19.w = 1.0;
    tmpvar_19.xyz = (extinctionMultiplier * ((_Extinction_Tint * extinction_4) + ((1.0 - _Extinction_Tint) * sqrt(dot (extinction_4, extinction_4)))));
    tmpvar_1 = tmpvar_19;
  };
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 _Globals_CameraToWorld;
uniform highp mat4 _Globals_ScreenToCamera;
uniform highp mat4 _Sun_WorldToLocal;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 0.0;
  tmpvar_1.xyz = (_Globals_ScreenToCamera * _glesVertex).xyz;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Globals_CameraToWorld * tmpvar_1).xyz;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Sun_WorldToLocal[0].xyz;
  tmpvar_3[1] = _Sun_WorldToLocal[1].xyz;
  tmpvar_3[2] = _Sun_WorldToLocal[2].xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(1.0, 1.0);
  tmpvar_4.xy = _glesVertex.xy;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (tmpvar_3 * tmpvar_2);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
uniform highp float Rg;
uniform highp float Rt;
uniform sampler2D _Sky_Transmittance;
uniform highp float _Extinction_Tint;
uniform highp float _Extinction_Cutoff;
uniform highp vec3 _Globals_WorldCameraPos;
uniform highp vec3 _Globals_Origin;
uniform highp float _Globals_ApparentDistance;
uniform highp float extinctionMultiplier;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD1);
  highp vec3 camera_3;
  camera_3 = (_Globals_WorldCameraPos - (_Globals_Origin * _Globals_ApparentDistance));
  highp vec3 extinction_4;
  highp float mu_5;
  highp float r_6;
  highp float tmpvar_7;
  tmpvar_7 = sqrt(dot (camera_3, camera_3));
  r_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = dot (camera_3, tmpvar_2);
  mu_5 = (tmpvar_8 / tmpvar_7);
  highp float f_9;
  f_9 = (((tmpvar_8 * tmpvar_8) - (tmpvar_7 * tmpvar_7)) + (Rt * Rt));
  highp float tmpvar_10;
  if ((f_9 >= 0.0)) {
    tmpvar_10 = sqrt(f_9);
  } else {
    tmpvar_10 = 1e+30;
  };
  highp float tmpvar_11;
  tmpvar_11 = max ((-(tmpvar_8) - tmpvar_10), 0.0);
  if ((tmpvar_11 > 0.0)) {
    camera_3 = (camera_3 + (tmpvar_11 * tmpvar_2));
    mu_5 = ((tmpvar_8 + tmpvar_11) / Rt);
    r_6 = Rt;
  };
  highp vec3 tmpvar_12;
  highp float y_over_x_13;
  y_over_x_13 = (((mu_5 + 0.15) / 1.15) * 14.1014);
  highp float x_14;
  x_14 = (y_over_x_13 * inversesqrt(((y_over_x_13 * y_over_x_13) + 1.0)));
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((sign(x_14) * (1.5708 - (sqrt((1.0 - abs(x_14))) * (1.5708 + (abs(x_14) * (-0.214602 + (abs(x_14) * (0.0865667 + (abs(x_14) * -0.0310296))))))))) / 1.5);
  tmpvar_15.y = sqrt(((r_6 - Rg) / (Rt - Rg)));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2DLodEXT (_Sky_Transmittance, tmpvar_15, 0.0);
  tmpvar_12 = tmpvar_16.xyz;
  extinction_4 = tmpvar_12;
  if ((r_6 > Rt)) {
    extinction_4 = vec3(1.0, 1.0, 1.0);
  };
  highp float tmpvar_17;
  tmpvar_17 = sqrt(dot (extinction_4, extinction_4));
  if ((tmpvar_17 >= _Extinction_Cutoff)) {
    highp vec4 tmpvar_18;
    tmpvar_18.w = 1.0;
    tmpvar_18.xyz = extinction_4;
    tmpvar_1 = tmpvar_18;
  } else {
    highp vec4 tmpvar_19;
    tmpvar_19.w = 1.0;
    tmpvar_19.xyz = (extinctionMultiplier * ((_Extinction_Tint * extinction_4) + ((1.0 - _Extinction_Tint) * sqrt(dot (extinction_4, extinction_4)))));
    tmpvar_1 = tmpvar_19;
  };
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 _Globals_CameraToWorld;
uniform highp mat4 _Globals_ScreenToCamera;
uniform highp mat4 _Sun_WorldToLocal;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 0.0;
  tmpvar_1.xyz = (_Globals_ScreenToCamera * _glesVertex).xyz;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Globals_CameraToWorld * tmpvar_1).xyz;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Sun_WorldToLocal[0].xyz;
  tmpvar_3[1] = _Sun_WorldToLocal[1].xyz;
  tmpvar_3[2] = _Sun_WorldToLocal[2].xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(1.0, 1.0);
  tmpvar_4.xy = _glesVertex.xy;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (tmpvar_3 * tmpvar_2);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform highp float Rg;
uniform highp float Rt;
uniform sampler2D _Sky_Transmittance;
uniform highp float _Extinction_Tint;
uniform highp float _Extinction_Cutoff;
uniform highp vec3 _Globals_WorldCameraPos;
uniform highp vec3 _Globals_Origin;
uniform highp float _Globals_ApparentDistance;
uniform highp float extinctionMultiplier;
in highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD1);
  highp vec3 camera_3;
  camera_3 = (_Globals_WorldCameraPos - (_Globals_Origin * _Globals_ApparentDistance));
  highp vec3 extinction_4;
  highp float mu_5;
  highp float r_6;
  highp float tmpvar_7;
  tmpvar_7 = sqrt(dot (camera_3, camera_3));
  r_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = dot (camera_3, tmpvar_2);
  mu_5 = (tmpvar_8 / tmpvar_7);
  highp float f_9;
  f_9 = (((tmpvar_8 * tmpvar_8) - (tmpvar_7 * tmpvar_7)) + (Rt * Rt));
  highp float tmpvar_10;
  if ((f_9 >= 0.0)) {
    tmpvar_10 = sqrt(f_9);
  } else {
    tmpvar_10 = 1e+30;
  };
  highp float tmpvar_11;
  tmpvar_11 = max ((-(tmpvar_8) - tmpvar_10), 0.0);
  if ((tmpvar_11 > 0.0)) {
    camera_3 = (camera_3 + (tmpvar_11 * tmpvar_2));
    mu_5 = ((tmpvar_8 + tmpvar_11) / Rt);
    r_6 = Rt;
  };
  highp vec3 tmpvar_12;
  highp float y_over_x_13;
  y_over_x_13 = (((mu_5 + 0.15) / 1.15) * 14.1014);
  highp float x_14;
  x_14 = (y_over_x_13 * inversesqrt(((y_over_x_13 * y_over_x_13) + 1.0)));
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((sign(x_14) * (1.5708 - (sqrt((1.0 - abs(x_14))) * (1.5708 + (abs(x_14) * (-0.214602 + (abs(x_14) * (0.0865667 + (abs(x_14) * -0.0310296))))))))) / 1.5);
  tmpvar_15.y = sqrt(((r_6 - Rg) / (Rt - Rg)));
  lowp vec4 tmpvar_16;
  tmpvar_16 = textureLod (_Sky_Transmittance, tmpvar_15, 0.0);
  tmpvar_12 = tmpvar_16.xyz;
  extinction_4 = tmpvar_12;
  if ((r_6 > Rt)) {
    extinction_4 = vec3(1.0, 1.0, 1.0);
  };
  highp float tmpvar_17;
  tmpvar_17 = sqrt(dot (extinction_4, extinction_4));
  if ((tmpvar_17 >= _Extinction_Cutoff)) {
    highp vec4 tmpvar_18;
    tmpvar_18.w = 1.0;
    tmpvar_18.xyz = extinction_4;
    tmpvar_1 = tmpvar_18;
  } else {
    highp vec4 tmpvar_19;
    tmpvar_19.w = 1.0;
    tmpvar_19.xyz = (extinctionMultiplier * ((_Extinction_Tint * extinction_4) + ((1.0 - _Extinction_Tint) * sqrt(dot (extinction_4, extinction_4)))));
    tmpvar_1 = tmpvar_19;
  };
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 68 math, 2 textures
Float 0 [Rg]
Float 1 [Rt]
Float 2 [_Extinction_Tint]
Float 3 [_Extinction_Cutoff]
Vector 4 [_Globals_WorldCameraPos]
Vector 5 [_Globals_Origin]
Float 6 [_Globals_ApparentDistance]
Float 7 [extinctionMultiplier]
SetTexture 2 [_Sky_Transmittance] 2D 2
"ps_3_0
dcl_2d s2
def c8, 1000000015047466200000000000000.00000000, 0.00000000, 0.15000001, 12.26193905
def c9, -1.00000000, 1.00000000, -0.01348047, 0.05747731
def c10, -0.12123910, 0.19563590, -0.33299461, 0.99999559
def c11, 1.57079601, 0.66666669, 0.00000000, 1.00000000
dcl_texcoord1 v0.xyz
mov r1.xyz, c5
mul r1.xyz, c6.x, -r1
add r1.xyz, r1, c4
dp3 r2.x, r1, r1
rsq r2.w, r2.x
dp3 r1.w, v0, v0
rsq r2.x, r1.w
mul r2.xyz, r2.x, v0
dp3 r1.x, r1, r2
rcp r1.w, r2.w
mul r3.x, r1.w, r1.w
mad r1.y, r1.x, r1.x, -r3.x
mad r1.y, c1.x, c1.x, r1
rsq r1.z, r1.y
rcp r1.z, r1.z
cmp r1.y, r1, r1.z, c8.x
add r1.y, -r1.x, -r1
max r1.y, r1, c8
add r1.z, r1.y, r1.x
cmp r1.z, -r1.y, r1.x, r1
rcp r2.x, c1.x
mul r1.z, r1, r2.x
mul r1.x, r2.w, r1
cmp r1.x, -r1.y, r1, r1.z
cmp r1.w, -r1.y, r1, c1.x
add r1.y, r1.w, -c0.x
add r1.x, r1, c8.z
mul r1.x, r1, c8.w
abs r1.z, r1.x
max r2.x, r1.z, c9.y
rcp r2.y, r2.x
min r2.x, r1.z, c9.y
mul r2.x, r2, r2.y
mul r2.y, r2.x, r2.x
mad r2.z, r2.y, c9, c9.w
mad r2.z, r2, r2.y, c10.x
mad r2.z, r2, r2.y, c10.y
mad r2.z, r2, r2.y, c10
mad r2.y, r2.z, r2, c10.w
mul r2.x, r2.y, r2
add r2.y, -r2.x, c11.x
add r1.z, r1, c9.x
cmp r2.x, -r1.z, r2, r2.y
cmp r1.x, r1, r2, -r2
mov r1.z, c1.x
add r1.z, -c0.x, r1
rcp r1.z, r1.z
mul r1.y, r1, r1.z
rsq r1.y, r1.y
mov r2.x, c2
add_pp r1.w, r1, -c1.x
add r2.x, c9.y, -r2
mul r1.x, r1, c11.y
mov r1.z, c8.y
rcp r1.y, r1.y
texldl r1.xyz, r1.xyzz, s2
cmp r1.xyz, -r1.w, r1, c9.y
dp3 r1.w, r1, r1
rsq r1.w, r1.w
rcp r2.w, r1.w
mul r1.w, r2, r2.x
mad r2.xyz, r1, c2.x, r1.w
mov r1.w, c9.y
add r2.w, r2, -c3.x
cmp r0, r2.w, r1, r0
mul r1.xyz, r2, c7.x
mov r1.w, c9.y
cmp_pp r2.x, r2.w, c11.z, c11.w
cmp oC0, -r2.x, r0, r1
"
}
SubProgram "d3d11 " {
// Stats: 48 math, 2 branches
SetTexture 0 [_Sky_Transmittance] 2D 0
ConstBuffer "$Globals" 384
Float 24 [Rg]
Float 28 [Rt]
Float 132 [_Extinction_Tint]
Float 136 [_Extinction_Cutoff]
Vector 272 [_Globals_WorldCameraPos] 3
Vector 288 [_Globals_Origin] 3
Float 300 [_Globals_ApparentDistance]
Float 304 [extinctionMultiplier]
BindCB  "$Globals" 0
"ps_4_0
eefiecedldcoamchdknijfnojcgkkfdhhgojkaghabaaaaaafeaiaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcgeahaaaaeaaaaaaanjabaaaafjaaaaaeegiocaaa
aaaaaaaabeaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegbcbaaaacaaaaaadcaaaaanhcaabaaaabaaaaaaegiccaia
ebaaaaaaaaaaaaaabcaaaaaapgipcaaaaaaaaaaabcaaaaaaegiccaaaaaaaaaaa
bbaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
elaaaaafbcaabaaaacaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaaaoaaaaahccaabaaaacaaaaaaakaabaaa
aaaaaaaaakaabaaaacaaaaaadcaaaaakccaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadcaaaaalccaabaaaaaaaaaaa
dkiacaaaaaaaaaaaabaaaaaadkiacaaaaaaaaaaaabaaaaaabkaabaaaaaaaaaaa
bnaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaaelaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadhaaaaakccaabaaaaaaaaaaackaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaamkpcejpbaaaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaadeaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaa
abeaaaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaaaoaaaaaiccaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkiacaaaaaaaaaaaabaaaaaadgaaaaagbcaabaaaaaaaaaaadkiacaaaaaaaaaaa
abaaaaaadhaaaaajdcaabaaaaaaaaaaakgakbaaaaaaaaaaaegaabaaaaaaaaaaa
egaabaaaacaaaaaaaaaaaaajecaabaaaaaaaaaaaakaabaaaaaaaaaaackiacaia
ebaaaaaaaaaaaaaaabaaaaaaaaaaaaakicaabaaaaaaaaaaackiacaiaebaaaaaa
aaaaaaaaabaaaaaadkiacaaaaaaaaaaaabaaaaaaaoaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaaaaaaaaaelaaaaafccaabaaaabaaaaaackaabaaa
aaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaajkjjbjdo
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaajfdbeeebddaaaaai
ecaabaaaaaaaaaaabkaabaiaibaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaai
icaabaaaaaaaaaaabkaabaiaibaaaaaaaaaaaaaaabeaaaaaaaaaiadpaoaaaaak
icaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahicaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
ecaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkoln
dcaaaaajecaabaaaabaaaaaadkaabaaaaaaaaaaackaabaaaabaaaaaaabeaaaaa
ochgdidodcaaaaajecaabaaaabaaaaaadkaabaaaaaaaaaaackaabaaaabaaaaaa
abeaaaaaaebnkjlodcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaa
abaaaaaaabeaaaaadiphhpdpdiaaaaahecaabaaaabaaaaaadkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadbaaaaaiicaabaaaabaaaaaaabeaaaaaaaaaiadpbkaabaia
ibaaaaaaaaaaaaaadcaaaaajecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaa
aaaaaamaabeaaaaanlapmjdpabaaaaahecaabaaaabaaaaaadkaabaaaabaaaaaa
ckaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
aaaaaaaackaabaaaabaaaaaaddaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaiadpdbaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaadhaaaaakccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaa
aaaaaaaaabeaaaaaklkkckdpeiaaaaalpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaabnaaaaaibcaabaaa
aaaaaaaadkiacaaaaaaaaaaaabaaaaaaakaabaaaaaaaaaaadhaaaaamhcaabaaa
aaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaabnaaaaaibcaabaaa
abaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaaaiaaaaaabpaaaeadakaabaaa
abaaaaaadgaaaaafhccabaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaabbfaaaaabaaaaaaajbcaabaaaabaaaaaa
bkiacaiaebaaaaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaa
fgifcaaaaaaaaaaaaiaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaai
hccabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaabdaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "gles " {
"!!GLES"
}
SubProgram "glesdesktop " {
"!!GLES"
}
SubProgram "gles3 " {
"!!GLES3"
}
}
 }
}
}