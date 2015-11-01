// Compiled shader for all platforms, uncompressed size: 52.6KB

Shader "Proland/Atmo/Sky" {
SubShader { 
 Tags { "QUEUE"="Geometry+1" }


 // Stats for Vertex shader:
 //       d3d11 : 10 math
 //        d3d9 : 14 math
 // Stats for Fragment shader:
 //       d3d11 : 163 math, 1 texture
 //        d3d9 : 243 math, 11 texture
 Pass {
  Tags { "QUEUE"="Geometry+1" }
  ZTest False
  ZWrite Off
  Cull Front
  Blend One One
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
uniform float _Exposure;
uniform float Rg;
uniform float Rt;
uniform vec3 betaR;
uniform float mieG;
uniform float RES_R;
uniform float RES_MU;
uniform float RES_MU_S;
uniform float RES_NU;
uniform float _Sun_Intensity;
uniform sampler2D _Sky_Transmittance;
uniform sampler2D _Sky_Inscatter;
uniform float _Alpha_Global;
uniform vec3 _Globals_WorldCameraPos;
uniform vec3 _Globals_Origin;
uniform float _Globals_ApparentDistance;
uniform sampler2D _Sun_Glare;
uniform vec3 _Sun_WorldSunDir;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
void main ()
{
  vec3 sunColor_1;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD1);
  vec3 tmpvar_3;
  if ((xlv_TEXCOORD2.z > 0.0)) {
    tmpvar_3 = texture2D (_Sun_Glare, (vec2(0.5, 0.5) + (xlv_TEXCOORD2.xy * 4.0))).xyz;
  } else {
    tmpvar_3 = vec3(0.0, 0.0, 0.0);
  };
  sunColor_1 = (pow (max (vec3(0.0, 0.0, 0.0), tmpvar_3), vec3(2.2, 2.2, 2.2)) * _Sun_Intensity);
  vec3 camera_4;
  camera_4 = (_Globals_WorldCameraPos - (_Globals_Origin * _Globals_ApparentDistance));
  vec3 extinction_5;
  float mu_6;
  float rMu_7;
  float r_8;
  vec3 result_9;
  result_9 = vec3(0.0, 0.0, 0.0);
  float tmpvar_10;
  tmpvar_10 = sqrt(dot (camera_4, camera_4));
  r_8 = tmpvar_10;
  float tmpvar_11;
  tmpvar_11 = dot (camera_4, tmpvar_2);
  rMu_7 = tmpvar_11;
  mu_6 = (tmpvar_11 / tmpvar_10);
  float f_12;
  f_12 = (((tmpvar_11 * tmpvar_11) - (tmpvar_10 * tmpvar_10)) + (Rt * Rt));
  float tmpvar_13;
  if ((f_12 >= 0.0)) {
    tmpvar_13 = sqrt(f_12);
  } else {
    tmpvar_13 = 1e+30;
  };
  float tmpvar_14;
  tmpvar_14 = max ((-(tmpvar_11) - tmpvar_13), 0.0);
  if ((tmpvar_14 > 0.0)) {
    camera_4 = (camera_4 + (tmpvar_14 * tmpvar_2));
    float tmpvar_15;
    tmpvar_15 = (tmpvar_11 + tmpvar_14);
    rMu_7 = tmpvar_15;
    mu_6 = (tmpvar_15 / Rt);
    r_8 = Rt;
  };
  float tmpvar_16;
  tmpvar_16 = dot (tmpvar_2, _Sun_WorldSunDir);
  float tmpvar_17;
  tmpvar_17 = (dot (camera_4, _Sun_WorldSunDir) / r_8);
  vec4 tmpvar_18;
  float uMu_19;
  float uR_20;
  float tmpvar_21;
  tmpvar_21 = sqrt(((Rt * Rt) - (Rg * Rg)));
  float tmpvar_22;
  tmpvar_22 = sqrt(((r_8 * r_8) - (Rg * Rg)));
  float tmpvar_23;
  tmpvar_23 = (r_8 * (rMu_7 / r_8));
  float tmpvar_24;
  tmpvar_24 = (((tmpvar_23 * tmpvar_23) - (r_8 * r_8)) + (Rg * Rg));
  vec4 tmpvar_25;
  if (((tmpvar_23 < 0.0) && (tmpvar_24 > 0.0))) {
    vec4 tmpvar_26;
    tmpvar_26.xyz = vec3(1.0, 0.0, 0.0);
    tmpvar_26.w = (0.5 - (0.5 / RES_MU));
    tmpvar_25 = tmpvar_26;
  } else {
    vec4 tmpvar_27;
    tmpvar_27.x = -1.0;
    tmpvar_27.y = (tmpvar_21 * tmpvar_21);
    tmpvar_27.z = tmpvar_21;
    tmpvar_27.w = (0.5 + (0.5 / RES_MU));
    tmpvar_25 = tmpvar_27;
  };
  uR_20 = ((0.5 / RES_R) + ((tmpvar_22 / tmpvar_21) * (1.0 - (1.0/(RES_R)))));
  uMu_19 = (tmpvar_25.w + ((((tmpvar_23 * tmpvar_25.x) + sqrt((tmpvar_24 + tmpvar_25.y))) / (tmpvar_22 + tmpvar_25.z)) * (0.5 - (1.0/(RES_MU)))));
  float y_over_x_28;
  y_over_x_28 = (max (tmpvar_17, -0.1975) * 5.34962);
  float x_29;
  x_29 = (y_over_x_28 * inversesqrt(((y_over_x_28 * y_over_x_28) + 1.0)));
  float tmpvar_30;
  tmpvar_30 = ((0.5 / RES_MU_S) + (((((sign(x_29) * (1.5708 - (sqrt((1.0 - abs(x_29))) * (1.5708 + (abs(x_29) * (-0.214602 + (abs(x_29) * (0.0865667 + (abs(x_29) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
  float tmpvar_31;
  tmpvar_31 = (((tmpvar_16 + 1.0) / 2.0) * (RES_NU - 1.0));
  float tmpvar_32;
  tmpvar_32 = floor(tmpvar_31);
  float tmpvar_33;
  tmpvar_33 = (tmpvar_31 - tmpvar_32);
  float tmpvar_34;
  tmpvar_34 = (floor(((uR_20 * RES_R) - 1.0)) / RES_R);
  float tmpvar_35;
  tmpvar_35 = (floor((uR_20 * RES_R)) / RES_R);
  float tmpvar_36;
  tmpvar_36 = fract((uR_20 * RES_R));
  vec4 tmpvar_37;
  tmpvar_37.zw = vec2(0.0, 0.0);
  tmpvar_37.x = ((tmpvar_32 + tmpvar_30) / RES_NU);
  tmpvar_37.y = ((uMu_19 / RES_R) + tmpvar_34);
  vec4 tmpvar_38;
  tmpvar_38.zw = vec2(0.0, 0.0);
  tmpvar_38.x = (((tmpvar_32 + tmpvar_30) + 1.0) / RES_NU);
  tmpvar_38.y = ((uMu_19 / RES_R) + tmpvar_34);
  vec4 tmpvar_39;
  tmpvar_39.zw = vec2(0.0, 0.0);
  tmpvar_39.x = ((tmpvar_32 + tmpvar_30) / RES_NU);
  tmpvar_39.y = ((uMu_19 / RES_R) + tmpvar_35);
  vec4 tmpvar_40;
  tmpvar_40.zw = vec2(0.0, 0.0);
  tmpvar_40.x = (((tmpvar_32 + tmpvar_30) + 1.0) / RES_NU);
  tmpvar_40.y = ((uMu_19 / RES_R) + tmpvar_35);
  tmpvar_18 = ((((texture2DLod (_Sky_Inscatter, tmpvar_37.xy, 0.0) * (1.0 - tmpvar_33)) + (texture2DLod (_Sky_Inscatter, tmpvar_38.xy, 0.0) * tmpvar_33)) * (1.0 - tmpvar_36)) + (((texture2DLod (_Sky_Inscatter, tmpvar_39.xy, 0.0) * (1.0 - tmpvar_33)) + (texture2DLod (_Sky_Inscatter, tmpvar_40.xy, 0.0) * tmpvar_33)) * tmpvar_36));
  float y_over_x_41;
  y_over_x_41 = (((mu_6 + 0.15) / 1.15) * 14.1014);
  float x_42;
  x_42 = (y_over_x_41 * inversesqrt(((y_over_x_41 * y_over_x_41) + 1.0)));
  vec2 tmpvar_43;
  tmpvar_43.x = ((sign(x_42) * (1.5708 - (sqrt((1.0 - abs(x_42))) * (1.5708 + (abs(x_42) * (-0.214602 + (abs(x_42) * (0.0865667 + (abs(x_42) * -0.0310296))))))))) / 1.5);
  tmpvar_43.y = sqrt(((r_8 - Rg) / (Rt - Rg)));
  extinction_5 = texture2DLod (_Sky_Transmittance, tmpvar_43, 0.0).xyz;
  if ((r_8 <= Rt)) {
    result_9 = ((tmpvar_18.xyz * (0.0596831 * (1.0 + (tmpvar_16 * tmpvar_16)))) + ((((tmpvar_18.xyz * tmpvar_18.w) / max (tmpvar_18.x, 0.0001)) * (betaR.x / betaR)) * ((((0.119366 * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_16)), -1.5)) * (1.0 + (tmpvar_16 * tmpvar_16))) / (2.0 + (mieG * mieG)))));
  } else {
    result_9 = vec3(0.0, 0.0, 0.0);
    extinction_5 = vec3(1.0, 1.0, 1.0);
  };
  vec3 L_44;
  vec3 tmpvar_45;
  tmpvar_45 = (((sunColor_1 * extinction_5) + (result_9 * _Sun_Intensity)) * _Exposure);
  L_44 = tmpvar_45;
  float tmpvar_46;
  if ((tmpvar_45.x < 1.413)) {
    tmpvar_46 = pow ((tmpvar_45.x * 0.38317), 0.454545);
  } else {
    tmpvar_46 = (1.0 - exp(-(tmpvar_45.x)));
  };
  L_44.x = tmpvar_46;
  float tmpvar_47;
  if ((tmpvar_45.y < 1.413)) {
    tmpvar_47 = pow ((tmpvar_45.y * 0.38317), 0.454545);
  } else {
    tmpvar_47 = (1.0 - exp(-(tmpvar_45.y)));
  };
  L_44.y = tmpvar_47;
  float tmpvar_48;
  if ((tmpvar_45.z < 1.413)) {
    tmpvar_48 = pow ((tmpvar_45.z * 0.38317), 0.454545);
  } else {
    tmpvar_48 = (1.0 - exp(-(tmpvar_45.z)));
  };
  L_44.z = tmpvar_48;
  vec4 tmpvar_49;
  tmpvar_49.w = 1.0;
  tmpvar_49.xyz = (_Alpha_Global * L_44);
  gl_FragData[0] = tmpvar_49;
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
uniform highp float _Exposure;
uniform highp float Rg;
uniform highp float Rt;
uniform highp vec3 betaR;
uniform highp float mieG;
uniform highp float RES_R;
uniform highp float RES_MU;
uniform highp float RES_MU_S;
uniform highp float RES_NU;
uniform highp float _Sun_Intensity;
uniform sampler2D _Sky_Transmittance;
uniform sampler2D _Sky_Inscatter;
uniform highp float _Alpha_Global;
uniform highp vec3 _Globals_WorldCameraPos;
uniform highp vec3 _Globals_Origin;
uniform highp float _Globals_ApparentDistance;
uniform sampler2D _Sun_Glare;
uniform highp vec3 _Sun_WorldSunDir;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 sunColor_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD1);
  highp vec3 data_3;
  lowp vec3 tmpvar_4;
  if ((xlv_TEXCOORD2.z > 0.0)) {
    highp vec2 P_5;
    P_5 = (vec2(0.5, 0.5) + (xlv_TEXCOORD2.xy * 4.0));
    tmpvar_4 = texture2D (_Sun_Glare, P_5).xyz;
  } else {
    tmpvar_4 = vec3(0.0, 0.0, 0.0);
  };
  data_3 = tmpvar_4;
  sunColor_1 = (pow (max (vec3(0.0, 0.0, 0.0), data_3), vec3(2.2, 2.2, 2.2)) * _Sun_Intensity);
  highp vec3 camera_6;
  camera_6 = (_Globals_WorldCameraPos - (_Globals_Origin * _Globals_ApparentDistance));
  highp vec3 extinction_7;
  highp float mu_8;
  highp float rMu_9;
  highp float r_10;
  highp vec3 result_11;
  result_11 = vec3(0.0, 0.0, 0.0);
  highp float tmpvar_12;
  tmpvar_12 = sqrt(dot (camera_6, camera_6));
  r_10 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (camera_6, tmpvar_2);
  rMu_9 = tmpvar_13;
  mu_8 = (tmpvar_13 / tmpvar_12);
  highp float f_14;
  f_14 = (((tmpvar_13 * tmpvar_13) - (tmpvar_12 * tmpvar_12)) + (Rt * Rt));
  highp float tmpvar_15;
  if ((f_14 >= 0.0)) {
    tmpvar_15 = sqrt(f_14);
  } else {
    tmpvar_15 = 1e+30;
  };
  highp float tmpvar_16;
  tmpvar_16 = max ((-(tmpvar_13) - tmpvar_15), 0.0);
  if ((tmpvar_16 > 0.0)) {
    camera_6 = (camera_6 + (tmpvar_16 * tmpvar_2));
    highp float tmpvar_17;
    tmpvar_17 = (tmpvar_13 + tmpvar_16);
    rMu_9 = tmpvar_17;
    mu_8 = (tmpvar_17 / Rt);
    r_10 = Rt;
  };
  highp float tmpvar_18;
  tmpvar_18 = dot (tmpvar_2, _Sun_WorldSunDir);
  highp float tmpvar_19;
  tmpvar_19 = (dot (camera_6, _Sun_WorldSunDir) / r_10);
  highp vec4 tmpvar_20;
  highp float uMu_21;
  highp float uR_22;
  highp float tmpvar_23;
  tmpvar_23 = sqrt(((Rt * Rt) - (Rg * Rg)));
  highp float tmpvar_24;
  tmpvar_24 = sqrt(((r_10 * r_10) - (Rg * Rg)));
  highp float tmpvar_25;
  tmpvar_25 = (r_10 * (rMu_9 / r_10));
  highp float tmpvar_26;
  tmpvar_26 = (((tmpvar_25 * tmpvar_25) - (r_10 * r_10)) + (Rg * Rg));
  highp vec4 tmpvar_27;
  if (((tmpvar_25 < 0.0) && (tmpvar_26 > 0.0))) {
    highp vec4 tmpvar_28;
    tmpvar_28.xyz = vec3(1.0, 0.0, 0.0);
    tmpvar_28.w = (0.5 - (0.5 / RES_MU));
    tmpvar_27 = tmpvar_28;
  } else {
    highp vec4 tmpvar_29;
    tmpvar_29.x = -1.0;
    tmpvar_29.y = (tmpvar_23 * tmpvar_23);
    tmpvar_29.z = tmpvar_23;
    tmpvar_29.w = (0.5 + (0.5 / RES_MU));
    tmpvar_27 = tmpvar_29;
  };
  uR_22 = ((0.5 / RES_R) + ((tmpvar_24 / tmpvar_23) * (1.0 - (1.0/(RES_R)))));
  uMu_21 = (tmpvar_27.w + ((((tmpvar_25 * tmpvar_27.x) + sqrt((tmpvar_26 + tmpvar_27.y))) / (tmpvar_24 + tmpvar_27.z)) * (0.5 - (1.0/(RES_MU)))));
  highp float y_over_x_30;
  y_over_x_30 = (max (tmpvar_19, -0.1975) * 5.34962);
  highp float x_31;
  x_31 = (y_over_x_30 * inversesqrt(((y_over_x_30 * y_over_x_30) + 1.0)));
  highp float tmpvar_32;
  tmpvar_32 = ((0.5 / RES_MU_S) + (((((sign(x_31) * (1.5708 - (sqrt((1.0 - abs(x_31))) * (1.5708 + (abs(x_31) * (-0.214602 + (abs(x_31) * (0.0865667 + (abs(x_31) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
  highp float tmpvar_33;
  tmpvar_33 = (((tmpvar_18 + 1.0) / 2.0) * (RES_NU - 1.0));
  highp float tmpvar_34;
  tmpvar_34 = floor(tmpvar_33);
  highp float tmpvar_35;
  tmpvar_35 = (tmpvar_33 - tmpvar_34);
  highp float tmpvar_36;
  tmpvar_36 = (floor(((uR_22 * RES_R) - 1.0)) / RES_R);
  highp float tmpvar_37;
  tmpvar_37 = (floor((uR_22 * RES_R)) / RES_R);
  highp float tmpvar_38;
  tmpvar_38 = fract((uR_22 * RES_R));
  highp vec4 tmpvar_39;
  tmpvar_39.zw = vec2(0.0, 0.0);
  tmpvar_39.x = ((tmpvar_34 + tmpvar_32) / RES_NU);
  tmpvar_39.y = ((uMu_21 / RES_R) + tmpvar_36);
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2DLodEXT (_Sky_Inscatter, tmpvar_39.xy, 0.0);
  highp vec4 tmpvar_41;
  tmpvar_41.zw = vec2(0.0, 0.0);
  tmpvar_41.x = (((tmpvar_34 + tmpvar_32) + 1.0) / RES_NU);
  tmpvar_41.y = ((uMu_21 / RES_R) + tmpvar_36);
  lowp vec4 tmpvar_42;
  tmpvar_42 = texture2DLodEXT (_Sky_Inscatter, tmpvar_41.xy, 0.0);
  highp vec4 tmpvar_43;
  tmpvar_43.zw = vec2(0.0, 0.0);
  tmpvar_43.x = ((tmpvar_34 + tmpvar_32) / RES_NU);
  tmpvar_43.y = ((uMu_21 / RES_R) + tmpvar_37);
  lowp vec4 tmpvar_44;
  tmpvar_44 = texture2DLodEXT (_Sky_Inscatter, tmpvar_43.xy, 0.0);
  highp vec4 tmpvar_45;
  tmpvar_45.zw = vec2(0.0, 0.0);
  tmpvar_45.x = (((tmpvar_34 + tmpvar_32) + 1.0) / RES_NU);
  tmpvar_45.y = ((uMu_21 / RES_R) + tmpvar_37);
  lowp vec4 tmpvar_46;
  tmpvar_46 = texture2DLodEXT (_Sky_Inscatter, tmpvar_45.xy, 0.0);
  tmpvar_20 = ((((tmpvar_40 * (1.0 - tmpvar_35)) + (tmpvar_42 * tmpvar_35)) * (1.0 - tmpvar_38)) + (((tmpvar_44 * (1.0 - tmpvar_35)) + (tmpvar_46 * tmpvar_35)) * tmpvar_38));
  highp vec3 tmpvar_47;
  highp float y_over_x_48;
  y_over_x_48 = (((mu_8 + 0.15) / 1.15) * 14.1014);
  highp float x_49;
  x_49 = (y_over_x_48 * inversesqrt(((y_over_x_48 * y_over_x_48) + 1.0)));
  highp vec2 tmpvar_50;
  tmpvar_50.x = ((sign(x_49) * (1.5708 - (sqrt((1.0 - abs(x_49))) * (1.5708 + (abs(x_49) * (-0.214602 + (abs(x_49) * (0.0865667 + (abs(x_49) * -0.0310296))))))))) / 1.5);
  tmpvar_50.y = sqrt(((r_10 - Rg) / (Rt - Rg)));
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2DLodEXT (_Sky_Transmittance, tmpvar_50, 0.0);
  tmpvar_47 = tmpvar_51.xyz;
  extinction_7 = tmpvar_47;
  if ((r_10 <= Rt)) {
    result_11 = ((tmpvar_20.xyz * (0.0596831 * (1.0 + (tmpvar_18 * tmpvar_18)))) + ((((tmpvar_20.xyz * tmpvar_20.w) / max (tmpvar_20.x, 0.0001)) * (betaR.x / betaR)) * ((((0.119366 * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_18)), -1.5)) * (1.0 + (tmpvar_18 * tmpvar_18))) / (2.0 + (mieG * mieG)))));
  } else {
    result_11 = vec3(0.0, 0.0, 0.0);
    extinction_7 = vec3(1.0, 1.0, 1.0);
  };
  highp vec3 L_52;
  highp vec3 tmpvar_53;
  tmpvar_53 = (((sunColor_1 * extinction_7) + (result_11 * _Sun_Intensity)) * _Exposure);
  L_52 = tmpvar_53;
  highp float tmpvar_54;
  if ((tmpvar_53.x < 1.413)) {
    tmpvar_54 = pow ((tmpvar_53.x * 0.38317), 0.454545);
  } else {
    tmpvar_54 = (1.0 - exp(-(tmpvar_53.x)));
  };
  L_52.x = tmpvar_54;
  highp float tmpvar_55;
  if ((tmpvar_53.y < 1.413)) {
    tmpvar_55 = pow ((tmpvar_53.y * 0.38317), 0.454545);
  } else {
    tmpvar_55 = (1.0 - exp(-(tmpvar_53.y)));
  };
  L_52.y = tmpvar_55;
  highp float tmpvar_56;
  if ((tmpvar_53.z < 1.413)) {
    tmpvar_56 = pow ((tmpvar_53.z * 0.38317), 0.454545);
  } else {
    tmpvar_56 = (1.0 - exp(-(tmpvar_53.z)));
  };
  L_52.z = tmpvar_56;
  highp vec4 tmpvar_57;
  tmpvar_57.w = 1.0;
  tmpvar_57.xyz = (_Alpha_Global * L_52);
  gl_FragData[0] = tmpvar_57;
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
uniform highp float _Exposure;
uniform highp float Rg;
uniform highp float Rt;
uniform highp vec3 betaR;
uniform highp float mieG;
uniform highp float RES_R;
uniform highp float RES_MU;
uniform highp float RES_MU_S;
uniform highp float RES_NU;
uniform highp float _Sun_Intensity;
uniform sampler2D _Sky_Transmittance;
uniform sampler2D _Sky_Inscatter;
uniform highp float _Alpha_Global;
uniform highp vec3 _Globals_WorldCameraPos;
uniform highp vec3 _Globals_Origin;
uniform highp float _Globals_ApparentDistance;
uniform sampler2D _Sun_Glare;
uniform highp vec3 _Sun_WorldSunDir;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 sunColor_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD1);
  highp vec3 data_3;
  lowp vec3 tmpvar_4;
  if ((xlv_TEXCOORD2.z > 0.0)) {
    highp vec2 P_5;
    P_5 = (vec2(0.5, 0.5) + (xlv_TEXCOORD2.xy * 4.0));
    tmpvar_4 = texture2D (_Sun_Glare, P_5).xyz;
  } else {
    tmpvar_4 = vec3(0.0, 0.0, 0.0);
  };
  data_3 = tmpvar_4;
  sunColor_1 = (pow (max (vec3(0.0, 0.0, 0.0), data_3), vec3(2.2, 2.2, 2.2)) * _Sun_Intensity);
  highp vec3 camera_6;
  camera_6 = (_Globals_WorldCameraPos - (_Globals_Origin * _Globals_ApparentDistance));
  highp vec3 extinction_7;
  highp float mu_8;
  highp float rMu_9;
  highp float r_10;
  highp vec3 result_11;
  result_11 = vec3(0.0, 0.0, 0.0);
  highp float tmpvar_12;
  tmpvar_12 = sqrt(dot (camera_6, camera_6));
  r_10 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (camera_6, tmpvar_2);
  rMu_9 = tmpvar_13;
  mu_8 = (tmpvar_13 / tmpvar_12);
  highp float f_14;
  f_14 = (((tmpvar_13 * tmpvar_13) - (tmpvar_12 * tmpvar_12)) + (Rt * Rt));
  highp float tmpvar_15;
  if ((f_14 >= 0.0)) {
    tmpvar_15 = sqrt(f_14);
  } else {
    tmpvar_15 = 1e+30;
  };
  highp float tmpvar_16;
  tmpvar_16 = max ((-(tmpvar_13) - tmpvar_15), 0.0);
  if ((tmpvar_16 > 0.0)) {
    camera_6 = (camera_6 + (tmpvar_16 * tmpvar_2));
    highp float tmpvar_17;
    tmpvar_17 = (tmpvar_13 + tmpvar_16);
    rMu_9 = tmpvar_17;
    mu_8 = (tmpvar_17 / Rt);
    r_10 = Rt;
  };
  highp float tmpvar_18;
  tmpvar_18 = dot (tmpvar_2, _Sun_WorldSunDir);
  highp float tmpvar_19;
  tmpvar_19 = (dot (camera_6, _Sun_WorldSunDir) / r_10);
  highp vec4 tmpvar_20;
  highp float uMu_21;
  highp float uR_22;
  highp float tmpvar_23;
  tmpvar_23 = sqrt(((Rt * Rt) - (Rg * Rg)));
  highp float tmpvar_24;
  tmpvar_24 = sqrt(((r_10 * r_10) - (Rg * Rg)));
  highp float tmpvar_25;
  tmpvar_25 = (r_10 * (rMu_9 / r_10));
  highp float tmpvar_26;
  tmpvar_26 = (((tmpvar_25 * tmpvar_25) - (r_10 * r_10)) + (Rg * Rg));
  highp vec4 tmpvar_27;
  if (((tmpvar_25 < 0.0) && (tmpvar_26 > 0.0))) {
    highp vec4 tmpvar_28;
    tmpvar_28.xyz = vec3(1.0, 0.0, 0.0);
    tmpvar_28.w = (0.5 - (0.5 / RES_MU));
    tmpvar_27 = tmpvar_28;
  } else {
    highp vec4 tmpvar_29;
    tmpvar_29.x = -1.0;
    tmpvar_29.y = (tmpvar_23 * tmpvar_23);
    tmpvar_29.z = tmpvar_23;
    tmpvar_29.w = (0.5 + (0.5 / RES_MU));
    tmpvar_27 = tmpvar_29;
  };
  uR_22 = ((0.5 / RES_R) + ((tmpvar_24 / tmpvar_23) * (1.0 - (1.0/(RES_R)))));
  uMu_21 = (tmpvar_27.w + ((((tmpvar_25 * tmpvar_27.x) + sqrt((tmpvar_26 + tmpvar_27.y))) / (tmpvar_24 + tmpvar_27.z)) * (0.5 - (1.0/(RES_MU)))));
  highp float y_over_x_30;
  y_over_x_30 = (max (tmpvar_19, -0.1975) * 5.34962);
  highp float x_31;
  x_31 = (y_over_x_30 * inversesqrt(((y_over_x_30 * y_over_x_30) + 1.0)));
  highp float tmpvar_32;
  tmpvar_32 = ((0.5 / RES_MU_S) + (((((sign(x_31) * (1.5708 - (sqrt((1.0 - abs(x_31))) * (1.5708 + (abs(x_31) * (-0.214602 + (abs(x_31) * (0.0865667 + (abs(x_31) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
  highp float tmpvar_33;
  tmpvar_33 = (((tmpvar_18 + 1.0) / 2.0) * (RES_NU - 1.0));
  highp float tmpvar_34;
  tmpvar_34 = floor(tmpvar_33);
  highp float tmpvar_35;
  tmpvar_35 = (tmpvar_33 - tmpvar_34);
  highp float tmpvar_36;
  tmpvar_36 = (floor(((uR_22 * RES_R) - 1.0)) / RES_R);
  highp float tmpvar_37;
  tmpvar_37 = (floor((uR_22 * RES_R)) / RES_R);
  highp float tmpvar_38;
  tmpvar_38 = fract((uR_22 * RES_R));
  highp vec4 tmpvar_39;
  tmpvar_39.zw = vec2(0.0, 0.0);
  tmpvar_39.x = ((tmpvar_34 + tmpvar_32) / RES_NU);
  tmpvar_39.y = ((uMu_21 / RES_R) + tmpvar_36);
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2DLodEXT (_Sky_Inscatter, tmpvar_39.xy, 0.0);
  highp vec4 tmpvar_41;
  tmpvar_41.zw = vec2(0.0, 0.0);
  tmpvar_41.x = (((tmpvar_34 + tmpvar_32) + 1.0) / RES_NU);
  tmpvar_41.y = ((uMu_21 / RES_R) + tmpvar_36);
  lowp vec4 tmpvar_42;
  tmpvar_42 = texture2DLodEXT (_Sky_Inscatter, tmpvar_41.xy, 0.0);
  highp vec4 tmpvar_43;
  tmpvar_43.zw = vec2(0.0, 0.0);
  tmpvar_43.x = ((tmpvar_34 + tmpvar_32) / RES_NU);
  tmpvar_43.y = ((uMu_21 / RES_R) + tmpvar_37);
  lowp vec4 tmpvar_44;
  tmpvar_44 = texture2DLodEXT (_Sky_Inscatter, tmpvar_43.xy, 0.0);
  highp vec4 tmpvar_45;
  tmpvar_45.zw = vec2(0.0, 0.0);
  tmpvar_45.x = (((tmpvar_34 + tmpvar_32) + 1.0) / RES_NU);
  tmpvar_45.y = ((uMu_21 / RES_R) + tmpvar_37);
  lowp vec4 tmpvar_46;
  tmpvar_46 = texture2DLodEXT (_Sky_Inscatter, tmpvar_45.xy, 0.0);
  tmpvar_20 = ((((tmpvar_40 * (1.0 - tmpvar_35)) + (tmpvar_42 * tmpvar_35)) * (1.0 - tmpvar_38)) + (((tmpvar_44 * (1.0 - tmpvar_35)) + (tmpvar_46 * tmpvar_35)) * tmpvar_38));
  highp vec3 tmpvar_47;
  highp float y_over_x_48;
  y_over_x_48 = (((mu_8 + 0.15) / 1.15) * 14.1014);
  highp float x_49;
  x_49 = (y_over_x_48 * inversesqrt(((y_over_x_48 * y_over_x_48) + 1.0)));
  highp vec2 tmpvar_50;
  tmpvar_50.x = ((sign(x_49) * (1.5708 - (sqrt((1.0 - abs(x_49))) * (1.5708 + (abs(x_49) * (-0.214602 + (abs(x_49) * (0.0865667 + (abs(x_49) * -0.0310296))))))))) / 1.5);
  tmpvar_50.y = sqrt(((r_10 - Rg) / (Rt - Rg)));
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2DLodEXT (_Sky_Transmittance, tmpvar_50, 0.0);
  tmpvar_47 = tmpvar_51.xyz;
  extinction_7 = tmpvar_47;
  if ((r_10 <= Rt)) {
    result_11 = ((tmpvar_20.xyz * (0.0596831 * (1.0 + (tmpvar_18 * tmpvar_18)))) + ((((tmpvar_20.xyz * tmpvar_20.w) / max (tmpvar_20.x, 0.0001)) * (betaR.x / betaR)) * ((((0.119366 * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_18)), -1.5)) * (1.0 + (tmpvar_18 * tmpvar_18))) / (2.0 + (mieG * mieG)))));
  } else {
    result_11 = vec3(0.0, 0.0, 0.0);
    extinction_7 = vec3(1.0, 1.0, 1.0);
  };
  highp vec3 L_52;
  highp vec3 tmpvar_53;
  tmpvar_53 = (((sunColor_1 * extinction_7) + (result_11 * _Sun_Intensity)) * _Exposure);
  L_52 = tmpvar_53;
  highp float tmpvar_54;
  if ((tmpvar_53.x < 1.413)) {
    tmpvar_54 = pow ((tmpvar_53.x * 0.38317), 0.454545);
  } else {
    tmpvar_54 = (1.0 - exp(-(tmpvar_53.x)));
  };
  L_52.x = tmpvar_54;
  highp float tmpvar_55;
  if ((tmpvar_53.y < 1.413)) {
    tmpvar_55 = pow ((tmpvar_53.y * 0.38317), 0.454545);
  } else {
    tmpvar_55 = (1.0 - exp(-(tmpvar_53.y)));
  };
  L_52.y = tmpvar_55;
  highp float tmpvar_56;
  if ((tmpvar_53.z < 1.413)) {
    tmpvar_56 = pow ((tmpvar_53.z * 0.38317), 0.454545);
  } else {
    tmpvar_56 = (1.0 - exp(-(tmpvar_53.z)));
  };
  L_52.z = tmpvar_56;
  highp vec4 tmpvar_57;
  tmpvar_57.w = 1.0;
  tmpvar_57.xyz = (_Alpha_Global * L_52);
  gl_FragData[0] = tmpvar_57;
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
uniform highp float _Exposure;
uniform highp float Rg;
uniform highp float Rt;
uniform highp vec3 betaR;
uniform highp float mieG;
uniform highp float RES_R;
uniform highp float RES_MU;
uniform highp float RES_MU_S;
uniform highp float RES_NU;
uniform highp float _Sun_Intensity;
uniform sampler2D _Sky_Transmittance;
uniform sampler2D _Sky_Inscatter;
uniform highp float _Alpha_Global;
uniform highp vec3 _Globals_WorldCameraPos;
uniform highp vec3 _Globals_Origin;
uniform highp float _Globals_ApparentDistance;
uniform sampler2D _Sun_Glare;
uniform highp vec3 _Sun_WorldSunDir;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 sunColor_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD1);
  highp vec3 data_3;
  lowp vec3 tmpvar_4;
  if ((xlv_TEXCOORD2.z > 0.0)) {
    highp vec2 P_5;
    P_5 = (vec2(0.5, 0.5) + (xlv_TEXCOORD2.xy * 4.0));
    tmpvar_4 = texture (_Sun_Glare, P_5).xyz;
  } else {
    tmpvar_4 = vec3(0.0, 0.0, 0.0);
  };
  data_3 = tmpvar_4;
  sunColor_1 = (pow (max (vec3(0.0, 0.0, 0.0), data_3), vec3(2.2, 2.2, 2.2)) * _Sun_Intensity);
  highp vec3 camera_6;
  camera_6 = (_Globals_WorldCameraPos - (_Globals_Origin * _Globals_ApparentDistance));
  highp vec3 extinction_7;
  highp float mu_8;
  highp float rMu_9;
  highp float r_10;
  highp vec3 result_11;
  result_11 = vec3(0.0, 0.0, 0.0);
  highp float tmpvar_12;
  tmpvar_12 = sqrt(dot (camera_6, camera_6));
  r_10 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (camera_6, tmpvar_2);
  rMu_9 = tmpvar_13;
  mu_8 = (tmpvar_13 / tmpvar_12);
  highp float f_14;
  f_14 = (((tmpvar_13 * tmpvar_13) - (tmpvar_12 * tmpvar_12)) + (Rt * Rt));
  highp float tmpvar_15;
  if ((f_14 >= 0.0)) {
    tmpvar_15 = sqrt(f_14);
  } else {
    tmpvar_15 = 1e+30;
  };
  highp float tmpvar_16;
  tmpvar_16 = max ((-(tmpvar_13) - tmpvar_15), 0.0);
  if ((tmpvar_16 > 0.0)) {
    camera_6 = (camera_6 + (tmpvar_16 * tmpvar_2));
    highp float tmpvar_17;
    tmpvar_17 = (tmpvar_13 + tmpvar_16);
    rMu_9 = tmpvar_17;
    mu_8 = (tmpvar_17 / Rt);
    r_10 = Rt;
  };
  highp float tmpvar_18;
  tmpvar_18 = dot (tmpvar_2, _Sun_WorldSunDir);
  highp float tmpvar_19;
  tmpvar_19 = (dot (camera_6, _Sun_WorldSunDir) / r_10);
  highp vec4 tmpvar_20;
  highp float uMu_21;
  highp float uR_22;
  highp float tmpvar_23;
  tmpvar_23 = sqrt(((Rt * Rt) - (Rg * Rg)));
  highp float tmpvar_24;
  tmpvar_24 = sqrt(((r_10 * r_10) - (Rg * Rg)));
  highp float tmpvar_25;
  tmpvar_25 = (r_10 * (rMu_9 / r_10));
  highp float tmpvar_26;
  tmpvar_26 = (((tmpvar_25 * tmpvar_25) - (r_10 * r_10)) + (Rg * Rg));
  highp vec4 tmpvar_27;
  if (((tmpvar_25 < 0.0) && (tmpvar_26 > 0.0))) {
    highp vec4 tmpvar_28;
    tmpvar_28.xyz = vec3(1.0, 0.0, 0.0);
    tmpvar_28.w = (0.5 - (0.5 / RES_MU));
    tmpvar_27 = tmpvar_28;
  } else {
    highp vec4 tmpvar_29;
    tmpvar_29.x = -1.0;
    tmpvar_29.y = (tmpvar_23 * tmpvar_23);
    tmpvar_29.z = tmpvar_23;
    tmpvar_29.w = (0.5 + (0.5 / RES_MU));
    tmpvar_27 = tmpvar_29;
  };
  uR_22 = ((0.5 / RES_R) + ((tmpvar_24 / tmpvar_23) * (1.0 - (1.0/(RES_R)))));
  uMu_21 = (tmpvar_27.w + ((((tmpvar_25 * tmpvar_27.x) + sqrt((tmpvar_26 + tmpvar_27.y))) / (tmpvar_24 + tmpvar_27.z)) * (0.5 - (1.0/(RES_MU)))));
  highp float y_over_x_30;
  y_over_x_30 = (max (tmpvar_19, -0.1975) * 5.34962);
  highp float x_31;
  x_31 = (y_over_x_30 * inversesqrt(((y_over_x_30 * y_over_x_30) + 1.0)));
  highp float tmpvar_32;
  tmpvar_32 = ((0.5 / RES_MU_S) + (((((sign(x_31) * (1.5708 - (sqrt((1.0 - abs(x_31))) * (1.5708 + (abs(x_31) * (-0.214602 + (abs(x_31) * (0.0865667 + (abs(x_31) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
  highp float tmpvar_33;
  tmpvar_33 = (((tmpvar_18 + 1.0) / 2.0) * (RES_NU - 1.0));
  highp float tmpvar_34;
  tmpvar_34 = floor(tmpvar_33);
  highp float tmpvar_35;
  tmpvar_35 = (tmpvar_33 - tmpvar_34);
  highp float tmpvar_36;
  tmpvar_36 = (floor(((uR_22 * RES_R) - 1.0)) / RES_R);
  highp float tmpvar_37;
  tmpvar_37 = (floor((uR_22 * RES_R)) / RES_R);
  highp float tmpvar_38;
  tmpvar_38 = fract((uR_22 * RES_R));
  highp vec4 tmpvar_39;
  tmpvar_39.zw = vec2(0.0, 0.0);
  tmpvar_39.x = ((tmpvar_34 + tmpvar_32) / RES_NU);
  tmpvar_39.y = ((uMu_21 / RES_R) + tmpvar_36);
  lowp vec4 tmpvar_40;
  tmpvar_40 = textureLod (_Sky_Inscatter, tmpvar_39.xy, 0.0);
  highp vec4 tmpvar_41;
  tmpvar_41.zw = vec2(0.0, 0.0);
  tmpvar_41.x = (((tmpvar_34 + tmpvar_32) + 1.0) / RES_NU);
  tmpvar_41.y = ((uMu_21 / RES_R) + tmpvar_36);
  lowp vec4 tmpvar_42;
  tmpvar_42 = textureLod (_Sky_Inscatter, tmpvar_41.xy, 0.0);
  highp vec4 tmpvar_43;
  tmpvar_43.zw = vec2(0.0, 0.0);
  tmpvar_43.x = ((tmpvar_34 + tmpvar_32) / RES_NU);
  tmpvar_43.y = ((uMu_21 / RES_R) + tmpvar_37);
  lowp vec4 tmpvar_44;
  tmpvar_44 = textureLod (_Sky_Inscatter, tmpvar_43.xy, 0.0);
  highp vec4 tmpvar_45;
  tmpvar_45.zw = vec2(0.0, 0.0);
  tmpvar_45.x = (((tmpvar_34 + tmpvar_32) + 1.0) / RES_NU);
  tmpvar_45.y = ((uMu_21 / RES_R) + tmpvar_37);
  lowp vec4 tmpvar_46;
  tmpvar_46 = textureLod (_Sky_Inscatter, tmpvar_45.xy, 0.0);
  tmpvar_20 = ((((tmpvar_40 * (1.0 - tmpvar_35)) + (tmpvar_42 * tmpvar_35)) * (1.0 - tmpvar_38)) + (((tmpvar_44 * (1.0 - tmpvar_35)) + (tmpvar_46 * tmpvar_35)) * tmpvar_38));
  highp vec3 tmpvar_47;
  highp float y_over_x_48;
  y_over_x_48 = (((mu_8 + 0.15) / 1.15) * 14.1014);
  highp float x_49;
  x_49 = (y_over_x_48 * inversesqrt(((y_over_x_48 * y_over_x_48) + 1.0)));
  highp vec2 tmpvar_50;
  tmpvar_50.x = ((sign(x_49) * (1.5708 - (sqrt((1.0 - abs(x_49))) * (1.5708 + (abs(x_49) * (-0.214602 + (abs(x_49) * (0.0865667 + (abs(x_49) * -0.0310296))))))))) / 1.5);
  tmpvar_50.y = sqrt(((r_10 - Rg) / (Rt - Rg)));
  lowp vec4 tmpvar_51;
  tmpvar_51 = textureLod (_Sky_Transmittance, tmpvar_50, 0.0);
  tmpvar_47 = tmpvar_51.xyz;
  extinction_7 = tmpvar_47;
  if ((r_10 <= Rt)) {
    result_11 = ((tmpvar_20.xyz * (0.0596831 * (1.0 + (tmpvar_18 * tmpvar_18)))) + ((((tmpvar_20.xyz * tmpvar_20.w) / max (tmpvar_20.x, 0.0001)) * (betaR.x / betaR)) * ((((0.119366 * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_18)), -1.5)) * (1.0 + (tmpvar_18 * tmpvar_18))) / (2.0 + (mieG * mieG)))));
  } else {
    result_11 = vec3(0.0, 0.0, 0.0);
    extinction_7 = vec3(1.0, 1.0, 1.0);
  };
  highp vec3 L_52;
  highp vec3 tmpvar_53;
  tmpvar_53 = (((sunColor_1 * extinction_7) + (result_11 * _Sun_Intensity)) * _Exposure);
  L_52 = tmpvar_53;
  highp float tmpvar_54;
  if ((tmpvar_53.x < 1.413)) {
    tmpvar_54 = pow ((tmpvar_53.x * 0.38317), 0.454545);
  } else {
    tmpvar_54 = (1.0 - exp(-(tmpvar_53.x)));
  };
  L_52.x = tmpvar_54;
  highp float tmpvar_55;
  if ((tmpvar_53.y < 1.413)) {
    tmpvar_55 = pow ((tmpvar_53.y * 0.38317), 0.454545);
  } else {
    tmpvar_55 = (1.0 - exp(-(tmpvar_53.y)));
  };
  L_52.y = tmpvar_55;
  highp float tmpvar_56;
  if ((tmpvar_53.z < 1.413)) {
    tmpvar_56 = pow ((tmpvar_53.z * 0.38317), 0.454545);
  } else {
    tmpvar_56 = (1.0 - exp(-(tmpvar_53.z)));
  };
  L_52.z = tmpvar_56;
  highp vec4 tmpvar_57;
  tmpvar_57.w = 1.0;
  tmpvar_57.xyz = (_Alpha_Global * L_52);
  _glesFragData[0] = tmpvar_57;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 243 math, 11 textures
Float 0 [_Exposure]
Float 1 [Rg]
Float 2 [Rt]
Vector 3 [betaR]
Float 4 [mieG]
Float 5 [RES_R]
Float 6 [RES_MU]
Float 7 [RES_MU_S]
Float 8 [RES_NU]
Float 9 [_Sun_Intensity]
Float 10 [_Alpha_Global]
Vector 11 [_Globals_WorldCameraPos]
Vector 12 [_Globals_Origin]
Float 13 [_Globals_ApparentDistance]
Vector 14 [_Sun_WorldSunDir]
SetTexture 0 [_Sun_Glare] 2D 0
SetTexture 1 [_Sky_Inscatter] 2D 1
SetTexture 2 [_Sky_Transmittance] 2D 2
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c15, 0.00000000, 4.00000000, 0.50000000, 2.20000005
def c16, 1000000015047466200000000000000.00000000, 1.00000000, 0.00000000, 0.15000001
def c17, 12.26193905, -1.00000000, -0.01348047, 0.05747731
def c18, -0.12123910, 0.19563590, -0.33299461, 0.99999559
def c19, 1.57079601, 0.66666669, -0.19750001, 5.34960032
def c20, 0.90909088, 0.74000001, 0.05968311, 2.00000000
def c21, -1.50000000, 0.00010000, 0.11936623, -1.41299999
def c22, 2.71828198, 0.38317001, 0.45454544, 0
dcl_texcoord1 v0.xyz
dcl_texcoord2 v1.xyz
rcp r3.z, c6.x
mov r0.xyz, c12
mul r0.xyz, c13.x, -r0
add r1.xyz, r0, c11
dp3 r0.y, r1, r1
rsq r4.x, r0.y
rcp r0.w, r4.x
dp3 r0.x, v0, v0
rsq r0.x, r0.x
mul r0.xyz, r0.x, v0
dp3 r3.w, r1, r0
mul r1.w, r0, r0
mad r1.w, r3, r3, -r1
mad r1.w, c2.x, c2.x, r1
rsq r2.x, r1.w
rcp r2.x, r2.x
cmp r1.w, r1, r2.x, c16.x
add r1.w, -r3, -r1
max r4.y, r1.w, c15.x
mad r2.xyz, r4.y, r0, r1
cmp r1.xyz, -r4.y, r1, r2
cmp r4.z, -r4.y, r0.w, c2.x
dp3 r5.w, r0, c14
dp3 r0.w, r1, c14
rcp r1.w, r4.z
mul r0.w, r0, r1
max r0.w, r0, c19.z
mul r0.w, r0, c19
abs r1.x, r0.w
max r1.y, r1.x, c16
rcp r1.z, r1.y
min r1.y, r1.x, c16
mul r1.y, r1, r1.z
mul r1.z, r1.y, r1.y
mad r1.w, r1.z, c17.z, c17
mad r1.w, r1, r1.z, c18.x
mad r1.w, r1, r1.z, c18.y
mad r1.w, r1, r1.z, c18.z
mad r1.z, r1.w, r1, c18.w
mul r1.y, r1.z, r1
add r1.z, -r1.y, c19.x
add r1.x, r1, c17.y
cmp r1.x, -r1, r1.y, r1.z
cmp r0.w, r0, r1.x, -r1.x
mov r1.x, c8
mul r1.z, c1.x, c1.x
mad r2.w, r3.z, c15.z, c15.z
add r0.y, c17, r1.x
add r0.x, r5.w, c16.y
mul r0.y, r0.x, r0
mad r0.x, r0.w, c20, c20.y
mul r0.w, r0.y, c15.z
frc r6.y, r0.w
rcp r0.y, c7.x
add r0.z, -r0.y, c16.y
mad r0.x, r0, r0.z, r0.y
mad r0.z, c2.x, c2.x, -r1
add r0.w, r0, -r6.y
mad r1.w, r0.x, c15.z, r0
rsq r3.y, r0.z
rcp r0.w, r3.y
add r0.x, r1.w, c16.y
rcp r3.x, c8.x
mul r1.x, r3, r0
add r0.x, r4.y, r3.w
cmp r4.w, -r4.y, r3, r0.x
mul r0.y, r4.z, r4.z
mad r0.y, r4.w, r4.w, -r0
mad r1.y, c1.x, c1.x, r0
mul r3.x, r1.w, r3
cmp r0.y, -r1, c16.z, c16
cmp r0.x, r4.w, c16.z, c16.y
mul_pp r5.x, r0, r0.y
mul r2.y, r0.w, r0.w
mov r2.z, r0.w
mov r2.x, c17.y
mad r0.w, -r3.z, c15.z, c15.z
mov r0.xyz, c16.yzzw
cmp r0, -r5.x, r2, r0
add r0.y, r0, r1
mad r1.y, r4.z, r4.z, -r1.z
rsq r1.z, r0.y
rsq r0.y, r1.y
rcp r1.y, c5.x
rcp r0.y, r0.y
mul r2.x, r3.y, r0.y
add r2.y, -r1, c16
mul r2.x, r2, r2.y
add r0.y, r0.z, r0
rcp r1.z, r1.z
mad r2.x, r1.y, c15.z, r2
mad r1.z, r4.w, r0.x, r1
mul r0.x, r2, c5
add r0.z, r0.x, c17.y
rcp r0.y, r0.y
frc r6.x, r0
frc r2.x, r0.z
mul r0.y, r1.z, r0
add r1.z, r0, -r2.x
add r0.z, -r3, c15
mul r1.z, r1, r1.y
mad r2.x, r0.y, r0.z, r0.w
mad r5.y, r2.x, r1, r1.z
add r1.z, r0.x, -r6.x
mul r2.y, r1, r1.z
mad r1.y, r2.x, r1, r2
mov r1.z, c15.x
texldl r2, r1.xyzz, s1
mov r3.y, r1
mov r5.x, r1
mov r3.z, c15.x
texldl r1, r3.xyzz, s1
mov r5.z, c15.x
texldl r0, r5.xyzz, s1
add r3.y, -r6, c16
mul r2, r6.y, r2
mad r1, r3.y, r1, r2
mul r2, r6.y, r0
mul r1, r6.x, r1
mov r0.x, r3
mov r0.z, c15.x
mov r0.y, r5
texldl r0, r0.xyzz, s1
mad r0, r0, r3.y, r2
add r2.x, -r6, c16.y
mad r0, r0, r2.x, r1
mul r1.xyz, r0, r0.w
max r1.w, r0.x, c21.y
rcp r2.x, r1.w
mul r2.xyz, r1, r2.x
rcp r0.w, c2.x
mul r1.w, r4, r0
mul r0.w, r4.x, r3
cmp r0.w, -r4.y, r0, r1
add r0.w, r0, c16
mul r0.w, r0, c17.x
abs r2.w, r0
rcp r1.x, c3.x
rcp r1.z, c3.z
rcp r1.y, c3.y
mul r1.xyz, r1, c3.x
mul r2.xyz, r2, r1
mul r1.y, r5.w, c4.x
mul r1.z, r1.y, c20.w
max r1.y, r2.w, c16
mad r1.z, c4.x, c4.x, -r1
min r1.x, r2.w, c16.y
rcp r1.y, r1.y
mul r3.x, r1, r1.y
add r3.y, r1.z, c16
pow r1, r3.y, c21.x
mul r1.w, r3.x, r3.x
mad r3.y, r5.w, r5.w, c16
mov r1.z, r1.x
mul r1.y, -c4.x, c4.x
add r1.x, r1.y, c16.y
mul r1.x, r1, r1.z
add r1.y, -r1, c20.w
rcp r1.y, r1.y
mul r1.x, r3.y, r1
mul r1.x, r1, r1.y
mul r1.xyz, r1.x, r2
mad r2.x, r1.w, c17.z, c17.w
mad r2.x, r2, r1.w, c18
mul r1.xyz, r1, c21.z
mul r0.xyz, r3.y, r0
mad r0.xyz, r0, c20.z, r1
mad r2.x, r2, r1.w, c18.y
mad r1.y, r2.x, r1.w, c18.z
mad r1.y, r1, r1.w, c18.w
mul r1.y, r1, r3.x
add r1.x, -r4.z, c2
cmp r1.x, r1, c16.y, c16.z
abs_pp r1.w, r1.x
cmp r0.xyz, -r1.w, c15.x, r0
add r1.x, r2.w, c17.y
add r1.z, -r1.y, c19.x
cmp r2.x, -r1, r1.y, r1.z
mul r1.xyz, r0, c9.x
cmp r0.y, r0.w, r2.x, -r2.x
mov r0.x, c2
add r0.x, -c1, r0
add r0.z, r4, -c1.x
rcp r0.w, r0.x
mul r2.x, r0.y, c19.y
mul r0.w, r0.z, r0
rsq r0.w, r0.w
mad r0.xy, v1, c15.y, c15.z
texld r0.xyz, r0, s0
cmp r0.xyz, -v1.z, c15.x, r0
max r4.xyz, r0, c15.x
pow r3, r4.y, c15.w
rcp r2.y, r0.w
pow r0, r4.x, c15.w
mov r4.x, r0
pow r0, r4.z, c15.w
mov r2.z, c15.x
texldl r2.xyz, r2.xyzz, s2
cmp r2.xyz, -r1.w, c16.y, r2
mov r4.z, r0
mov r4.y, r3
mul r0.xyz, r4, c9.x
mad r0.xyz, r0, r2, r1
mul r2.xyz, r0, c0.x
pow r0, c22.x, -r2.z
mul r3.x, r2.z, c22.y
pow r1, r3.x, c22.z
mov r0.y, r1.x
pow r1, c22.x, -r2.x
add r2.w, r2.z, c21
add r0.x, -r0, c16.y
cmp r2.z, r2.w, r0.x, r0.y
mul r3.x, r2, c22.y
pow r0, r3.x, c22.z
mov r0.y, r1.x
mov r0.z, r0.x
pow r1, c22.x, -r2.y
add r2.w, r2.x, c21
add r0.x, -r0.y, c16.y
cmp r2.x, r2.w, r0, r0.z
mul r3.x, r2.y, c22.y
pow r0, r3.x, c22.z
mov r0.z, r0.x
mov r0.y, r1.x
add r2.w, r2.y, c21
add r0.x, -r0.y, c16.y
cmp r2.y, r2.w, r0.x, r0.z
mul oC0.xyz, r2, c10.x
mov oC0.w, c16.y
"
}
SubProgram "d3d11 " {
// Stats: 163 math, 1 textures
SetTexture 0 [_Sun_Glare] 2D 2
SetTexture 1 [_Sky_Inscatter] 2D 1
SetTexture 2 [_Sky_Transmittance] 2D 0
ConstBuffer "$Globals" 384
Float 16 [_Exposure]
Float 24 [Rg]
Float 28 [Rt]
Vector 48 [betaR] 3
Float 92 [mieG]
Float 112 [RES_R]
Float 116 [RES_MU]
Float 120 [RES_MU_S]
Float 124 [RES_NU]
Float 128 [_Sun_Intensity]
Float 132 [_Alpha_Global]
Vector 272 [_Globals_WorldCameraPos] 3
Vector 288 [_Globals_Origin] 3
Float 300 [_Globals_ApparentDistance]
Vector 304 [_Sun_WorldSunDir] 3
BindCB  "$Globals" 0
"ps_4_0
eefiecedmghjfponalmlaggpgjjkdlfilbchjkicabaaaaaaeebiaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcfebhaaaaeaaaaaaanfafaaaafjaaaaaeegiocaaa
aaaaaaaabeaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacahaaaaaadgaaaaaihcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaa
aaaaaaaaaaaaaaaadgaaaaafbcaabaaaabaaaaaaabeaaaaaaaaaialpdgaaaaag
bcaabaaaacaaaaaadkiacaaaaaaaaaaaabaaaaaadcaaaaanhcaabaaaadaaaaaa
egiccaiaebaaaaaaaaaaaaaabcaaaaaapgipcaaaaaaaaaaabcaaaaaaegiccaaa
aaaaaaaabbaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaa
adaaaaaabaaaaaahicaabaaaadaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaa
eeaaaaaficaabaaaadaaaaaadkaabaaaadaaaaaadiaaaaahhcaabaaaaeaaaaaa
pgapbaaaadaaaaaaegbcbaaaacaaaaaabaaaaaahccaabaaaafaaaaaaegacbaaa
adaaaaaaegacbaaaaeaaaaaadcaaaaakicaabaaaadaaaaaabkaabaaaafaaaaaa
bkaabaaaafaaaaaadkaabaiaebaaaaaaacaaaaaaelaaaaafbcaabaaaafaaaaaa
dkaabaaaacaaaaaadcaaaaalicaabaaaacaaaaaadkiacaaaaaaaaaaaabaaaaaa
dkiacaaaaaaaaaaaabaaaaaadkaabaaaadaaaaaabnaaaaahicaabaaaadaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaaaaaelaaaaaficaabaaaacaaaaaadkaabaaa
acaaaaaadhaaaaakicaabaaaacaaaaaadkaabaaaadaaaaaadkaabaiaebaaaaaa
acaaaaaaabeaaaaamkpcejpbaaaaaaaiicaabaaaacaaaaaadkaabaaaacaaaaaa
bkaabaiaebaaaaaaafaaaaaadeaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaa
abeaaaaaaaaaaaaaaaaaaaahccaabaaaacaaaaaadkaabaaaacaaaaaabkaabaaa
afaaaaaaaoaaaaaiecaabaaaacaaaaaabkaabaaaacaaaaaadkiacaaaaaaaaaaa
abaaaaaadbaaaaahicaabaaaadaaaaaaabeaaaaaaaaaaaaadkaabaaaacaaaaaa
dcaaaaajhcaabaaaagaaaaaapgapbaaaacaaaaaaegacbaaaaeaaaaaaegacbaaa
adaaaaaabaaaaaaiicaabaaaacaaaaaaegacbaaaaeaaaaaaegiccaaaaaaaaaaa
bdaaaaaadhaaaaajhcaabaaaadaaaaaapgapbaaaadaaaaaaegacbaaaagaaaaaa
egacbaaaadaaaaaabaaaaaaibcaabaaaadaaaaaaegacbaaaadaaaaaaegiccaaa
aaaaaaaabdaaaaaaaoaaaaahecaabaaaafaaaaaabkaabaaaafaaaaaaakaabaaa
afaaaaaadhaaaaajhcaabaaaacaaaaaapgapbaaaadaaaaaaegacbaaaacaaaaaa
egacbaaaafaaaaaadiaaaaahccaabaaaadaaaaaaakaabaaaacaaaaaaakaabaaa
acaaaaaadcaaaaakccaabaaaadaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaa
bkaabaiaebaaaaaaadaaaaaadcaaaaalccaabaaaadaaaaaackiacaaaaaaaaaaa
abaaaaaackiacaaaaaaaaaaaabaaaaaabkaabaaaadaaaaaadbaaaaahecaabaaa
adaaaaaaabeaaaaaaaaaaaaabkaabaaaadaaaaaadbaaaaahicaabaaaadaaaaaa
bkaabaaaacaaaaaaabeaaaaaaaaaaaaaabaaaaahecaabaaaadaaaaaackaabaaa
adaaaaaadkaabaaaadaaaaaadiaaaaajicaabaaaadaaaaaackiacaaaaaaaaaaa
abaaaaaackiacaaaaaaaaaaaabaaaaaadcaaaaambcaabaaaaeaaaaaadkiacaaa
aaaaaaaaabaaaaaadkiacaaaaaaaaaaaabaaaaaadkaabaiaebaaaaaaadaaaaaa
dcaaaaakicaabaaaadaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaadkaabaia
ebaaaaaaadaaaaaaelaaaaaficaabaaaadaaaaaadkaabaaaadaaaaaaelaaaaaf
ecaabaaaabaaaaaaakaabaaaaeaaaaaadiaaaaahccaabaaaabaaaaaackaabaaa
abaaaaaackaabaaaabaaaaaaaoaaaaalhcaabaaaaeaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaabgigcaaaaaaaaaaaahaaaaaaaaaaaaaiicaabaaa
aaaaaaaaakaabaiaebaaaaaaaeaaaaaaabeaaaaaaaaaaadpaaaaaaahicaabaaa
abaaaaaaakaabaaaaeaaaaaaabeaaaaaaaaaaadpdhaaaaajpcaabaaaaaaaaaaa
kgakbaaaadaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaaoaaaaahbcaabaaa
abaaaaaadkaabaaaadaaaaaackaabaaaabaaaaaaaaaaaaahgcaabaaaaaaaaaaa
fgagbaaaaaaaaaaafgahbaaaadaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaaacaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaaaoaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaa
aaaaaaaaaoaaaaalocaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpagijcaaaaaaaaaaaahaaaaaaaaaaaaalocaabaaaabaaaaaafgaobaia
ebaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaaadpaaaaiadpdcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaabaaaaaadkaabaaaaaaaaaaa
dcaaaaajccaabaaaaaaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaa
aeaaaaaadcaaaaakecaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaa
ahaaaaaaabeaaaaaaaaaialpdiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaaaaaaaaaahaaaaaaebaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
aoaaaaaifcaabaaaaaaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaaahaaaaaa
aaaaaaahecaabaaaafaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaaaoaaaaah
ecaabaaaaaaaaaaaakaabaaaadaaaaaaakaabaaaacaaaaaadeaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaahbdneklodiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaabodakleadeaaaaaiicaabaaaaaaaaaaackaabaia
ibaaaaaaaaaaaaaaabeaaaaaaaaaiadpaoaaaaakicaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaaaaaaaaaddaaaaaibcaabaaa
abaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajccaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajccaabaaaabaaaaaa
akaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaochgdidodcaaaaajccaabaaa
abaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaebnkjlodcaaaaaj
bcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaadiphhpdp
diaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaaj
ccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdp
dbaaaaaiecaabaaaabaaaaaaabeaaaaaaaaaiadpckaabaiaibaaaaaaaaaaaaaa
ddaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdbaaaaai
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaabaaaaah
ccaabaaaabaaaaaackaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaajicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaadhaaaaak
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaacolkgidp
abeaaaaakehadndpdiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaaadpdcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaa
ckaabaaaaeaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadp
aaaaaaaibcaabaaaabaaaaaadkiacaaaaaaaaaaaahaaaaaaabeaaaaaaaaaialp
diaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaaebaaaaaf
ccaabaaaabaaaaaabkaabaaaabaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaabkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaaaaaaaahbcaabaaaabaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaiadpaoaaaaaiccaabaaaafaaaaaackaabaaa
aaaaaaaadkiacaaaaaaaaaaaahaaaaaaaoaaaaaibcaabaaaafaaaaaaakaabaaa
abaaaaaadkiacaaaaaaaaaaaahaaaaaaeiaaaaalpcaabaaaabaaaaaaigaabaaa
afaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaaeiaaaaal
pcaabaaaadaaaaaajgafbaaaafaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
abeaaaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaapgapbaaaaaaaaaaaegaobaaa
abaaaaaaaaaaaaaiecaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdcaaaaajpcaabaaaabaaaaaaegaobaaaadaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaaebaaaaafccaabaaaacaaaaaabkaabaaaaaaaaaaabkaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaaoaaaaaiccaabaaaacaaaaaabkaabaaa
acaaaaaaakiacaaaaaaaaaaaahaaaaaaaaaaaaahicaabaaaafaaaaaaakaabaaa
aaaaaaaabkaabaaaacaaaaaaeiaaaaalpcaabaaaadaaaaaamgaabaaaafaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaaeiaaaaalpcaabaaa
aeaaaaaangafbaaaafaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaa
aaaaaaaadiaaaaahpcaabaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaadaaaaaa
dcaaaaajpcaabaaaadaaaaaaegaobaaaaeaaaaaakgakbaaaaaaaaaaaegaobaaa
adaaaaaadiaaaaahpcaabaaaadaaaaaafgafbaaaaaaaaaaaegaobaaaadaaaaaa
aaaaaaaibcaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
dcaaaaajpcaabaaaaaaaaaaaegaobaaaabaaaaaaagaabaaaaaaaaaaaegaobaaa
adaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
deaaaaahicaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaabhlhnbdiaoaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaaoaaaaajhcaabaaa
adaaaaaaagiacaaaaaaaaaaaadaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaaapaaaaaiicaabaaa
aaaaaaaapgapbaaaacaaaaaapgipcaaaaaaaaaaaafaaaaaadcaaaaajicaabaaa
abaaaaaadkaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaao
kcaabaaaacaaaaaapgipcaaaaaaaaaaaafaaaaaapgipcaaaaaaaaaaaafaaaaaa
aceaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaeaaaaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaabkaabaaaacaaaaaacpaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaamalpbjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaamccaabaaa
acaaaaaadkiacaiaebaaaaaaaaaaaaaaafaaaaaadkiacaaaaaaaaaaaafaaaaaa
abeaaaaaaaaaiadpdiaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaa
eihgpedndiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaacaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaadiaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaeihghednaoaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaacaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaabnaaaaaiicaabaaaaaaaaaaa
dkiacaaaaaaaaaaaabaaaaaaakaabaaaacaaaaaaabaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaagiacaaaaaaaaaaaaiaaaaaadcaaaaapdcaabaaaabaaaaaaegbabaaa
adaaaaaaaceaaaaaaaaaiaeaaaaaiaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaacaaaaaadbaaaaahicaabaaaabaaaaaaabeaaaaa
aaaaaaaackbabaaaadaaaaaaabaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaabaaaaaadeaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaafhcaabaaaabaaaaaaegacbaaa
abaaaaaadiaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaamnmmamea
mnmmameamnmmameaaaaaaaaabjaaaaafhcaabaaaabaaaaaaegacbaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaagiacaaaaaaaaaaaaiaaaaaa
aaaaaaahicaabaaaabaaaaaackaabaaaacaaaaaaabeaaaaajkjjbjdoaaaaaaaj
bcaabaaaacaaaaaaakaabaaaacaaaaaackiacaiaebaaaaaaaaaaaaaaabaaaaaa
diaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaajfdbeeebdeaaaaai
ccaabaaaacaaaaaadkaabaiaibaaaaaaabaaaaaaabeaaaaaaaaaiadpaoaaaaak
ccaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaa
acaaaaaaddaaaaaiecaabaaaacaaaaaadkaabaiaibaaaaaaabaaaaaaabeaaaaa
aaaaiadpdiaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaackaabaaaacaaaaaa
diaaaaahecaabaaaacaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaaj
icaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkoln
dcaaaaajicaabaaaacaaaaaackaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaa
ochgdidodcaaaaajicaabaaaacaaaaaackaabaaaacaaaaaadkaabaaaacaaaaaa
abeaaaaaaebnkjlodcaaaaajecaabaaaacaaaaaackaabaaaacaaaaaadkaabaaa
acaaaaaaabeaaaaadiphhpdpdiaaaaahicaabaaaacaaaaaackaabaaaacaaaaaa
bkaabaaaacaaaaaadcaaaaajicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaaamaabeaaaaanlapmjdpdbaaaaaibcaabaaaadaaaaaaabeaaaaaaaaaiadp
dkaabaiaibaaaaaaabaaaaaaddaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaiadpdbaaaaaiicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaia
ebaaaaaaabaaaaaaabaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaakaabaaa
adaaaaaadcaaaaajccaabaaaacaaaaaabkaabaaaacaaaaaackaabaaaacaaaaaa
dkaabaaaacaaaaaadhaaaaakicaabaaaabaaaaaadkaabaaaabaaaaaabkaabaia
ebaaaaaaacaaaaaabkaabaaaacaaaaaadiaaaaahbcaabaaaadaaaaaadkaabaaa
abaaaaaaabeaaaaaklkkckdpaaaaaaakicaabaaaabaaaaaackiacaiaebaaaaaa
aaaaaaaaabaaaaaadkiacaaaaaaaaaaaabaaaaaaaoaaaaahicaabaaaabaaaaaa
akaabaaaacaaaaaadkaabaaaabaaaaaaelaaaaafccaabaaaadaaaaaadkaabaaa
abaaaaaaeiaaaaalpcaabaaaacaaaaaaegaabaaaadaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaaabeaaaaaaaaaaaaadhaaaaamhcaabaaaacaaaaaapgapbaaa
aaaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaegacbaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaa
abaaaaaadiaaaaakpcaabaaaabaaaaaaagafbaaaaaaaaaaaaceaaaaanmcomedo
dlkklilpnmcomedodlkklilpcpaaaaaffcaabaaaabaaaaaaagacbaaaabaaaaaa
bjaaaaafkcaabaaaabaaaaaafganbaaaabaaaaaaaaaaaaalkcaabaaaabaaaaaa
fganbaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaiadp
diaaaaakfcaabaaaabaaaaaaagacbaaaabaaaaaaaceaaaaacplkoidoaaaaaaaa
cplkoidoaaaaaaaabjaaaaaffcaabaaaabaaaaaaagacbaaaabaaaaaadbaaaaak
lcaabaaaaaaaaaaaegaibaaaaaaaaaaaaceaaaaacpnnledpcpnnledpaaaaaaaa
cpnnledpdiaaaaakdcaabaaaacaaaaaakgakbaaaaaaaaaaaaceaaaaanmcomedo
dlkklilpaaaaaaaaaaaaaaaadhaaaaajdcaabaaaaaaaaaaaegaabaaaaaaaaaaa
igaabaaaabaaaaaangafbaaaabaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaa
acaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaaacaaaaaaaaaaaaaiccaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaacplkoidobjaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadhaaaaajecaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaabkaabaaaabaaaaaadiaaaaaihccabaaaaaaaaaaaegacbaaaaaaaaaaa
fgifcaaaaaaaaaaaaiaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadp
doaaaaab"
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