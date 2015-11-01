// Compiled shader for all platforms, uncompressed size: 40.2KB

Shader "Proland/Atmo/SkyMap" {
SubShader { 


 // Stats for Vertex shader:
 //       d3d11 : 6 math
 //        d3d9 : 6 math
 //      opengl : 6 math
 // Stats for Fragment shader:
 //       d3d11 : 123 math
 //        d3d9 : 177 math, 10 texture
 //      opengl : 177 math, 5 texture
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
// Stats: 6 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
"3.0-!!ARBvp1.0
PARAM c[5] = { { 0.5, 0, 2.2 },
		state.matrix.mvp };
TEMP R0;
ADD R0.xy, -vertex.texcoord[0], c[0].x;
MUL result.texcoord[0].xy, R0, c[0].z;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 6 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
def c4, 0.50000000, 2.20000005, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
add r0.xy, -v1, c4.x
mul o1.xy, r0, c4.y
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 6 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0
eefieceddkfemjikaepkellbjdgennpkejgmnhljabaaaaaaeeacaaaaadaaaaaa
cmaaaaaakaaaaaaapiaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefceeabaaaa
eaaaabaafbaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaaaaaaaaaldcaabaaaaaaaaaaaegbabaiaebaaaaaa
acaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadiaaaaakdccabaaa
abaaaaaaegaabaaaaaaaaaaaaceaaaaamnmmameamnmmameaaaaaaaaaaaaaaaaa
doaaaaab"
}
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (((1.0 - _glesMultiTexCoord0.xy) - 0.5) * 2.2);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
uniform highp float Rg;
uniform highp float Rt;
uniform highp vec3 betaR;
uniform highp float mieG;
uniform highp float RES_R;
uniform highp float RES_MU;
uniform highp float RES_MU_S;
uniform highp float RES_NU;
uniform highp float _Sun_Intensity;
uniform sampler2D _Sky_Irradiance;
uniform sampler2D _Sky_Inscatter;
uniform highp vec3 _Sun_WorldSunDir;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec3 result_1;
  highp float l_2;
  highp vec2 u_3;
  u_3 = xlv_TEXCOORD0;
  highp float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD0, xlv_TEXCOORD0);
  l_2 = tmpvar_4;
  result_1 = vec3(0.0, 0.0, 0.0);
  if (((tmpvar_4 <= 1.02) && (tmpvar_4 > 1.0))) {
    u_3 = (xlv_TEXCOORD0 / tmpvar_4);
    l_2 = (1.0/(tmpvar_4));
  };
  highp vec3 tmpvar_5;
  tmpvar_5.xy = (2.0 * u_3);
  tmpvar_5.z = (1.0 - l_2);
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 / (1.0 + l_2));
  highp vec3 tmpvar_7;
  tmpvar_7.xy = vec2(0.0, 0.0);
  tmpvar_7.z = Rg;
  highp vec3 tmpvar_8;
  highp vec3 camera_9;
  camera_9 = tmpvar_7;
  highp float rMu_10;
  highp float r_11;
  highp vec3 result_12;
  result_12 = vec3(0.0, 0.0, 0.0);
  highp float tmpvar_13;
  tmpvar_13 = sqrt(dot (tmpvar_7, tmpvar_7));
  r_11 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (tmpvar_7, tmpvar_6);
  rMu_10 = tmpvar_14;
  highp float f_15;
  f_15 = (((tmpvar_14 * tmpvar_14) - (tmpvar_13 * tmpvar_13)) + (Rt * Rt));
  highp float tmpvar_16;
  if ((f_15 >= 0.0)) {
    tmpvar_16 = sqrt(f_15);
  } else {
    tmpvar_16 = 1e+30;
  };
  highp float tmpvar_17;
  tmpvar_17 = max ((-(tmpvar_14) - tmpvar_16), 0.0);
  if ((tmpvar_17 > 0.0)) {
    camera_9 = (tmpvar_7 + (tmpvar_17 * tmpvar_6));
    rMu_10 = (tmpvar_14 + tmpvar_17);
    r_11 = Rt;
  };
  highp float tmpvar_18;
  tmpvar_18 = dot (tmpvar_6, _Sun_WorldSunDir);
  highp float tmpvar_19;
  tmpvar_19 = (dot (camera_9, _Sun_WorldSunDir) / r_11);
  highp vec4 tmpvar_20;
  highp float uMu_21;
  highp float uR_22;
  highp float tmpvar_23;
  tmpvar_23 = sqrt(((Rt * Rt) - (Rg * Rg)));
  highp float tmpvar_24;
  tmpvar_24 = sqrt(((r_11 * r_11) - (Rg * Rg)));
  highp float tmpvar_25;
  tmpvar_25 = (r_11 * (rMu_10 / r_11));
  highp float tmpvar_26;
  tmpvar_26 = (((tmpvar_25 * tmpvar_25) - (r_11 * r_11)) + (Rg * Rg));
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
  if ((r_11 <= Rt)) {
    result_12 = ((tmpvar_20.xyz * (0.0596831 * (1.0 + (tmpvar_18 * tmpvar_18)))) + ((((tmpvar_20.xyz * tmpvar_20.w) / max (tmpvar_20.x, 0.0001)) * (betaR.x / betaR)) * ((((0.119366 * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_18)), -1.5)) * (1.0 + (tmpvar_18 * tmpvar_18))) / (2.0 + (mieG * mieG)))));
  } else {
    result_12 = vec3(0.0, 0.0, 0.0);
  };
  tmpvar_8 = (result_12 * _Sun_Intensity);
  highp vec3 tmpvar_47;
  highp vec3 tmpvar_48;
  highp vec2 tmpvar_49;
  tmpvar_49.x = ((_Sun_WorldSunDir.z + 0.2) / 1.2);
  tmpvar_49.y = ((Rg - Rg) / (Rt - Rg));
  lowp vec4 tmpvar_50;
  tmpvar_50 = texture2DLodEXT (_Sky_Irradiance, tmpvar_49, 0.0);
  tmpvar_48 = tmpvar_50.xyz;
  tmpvar_47 = (tmpvar_48 * _Sun_Intensity);
  if ((l_2 <= 1.02)) {
    result_1 = tmpvar_8;
  } else {
    result_1 = ((tmpvar_47 / 3.14159) * 0.17);
  };
  highp vec4 tmpvar_51;
  tmpvar_51.w = 1.0;
  tmpvar_51.xyz = result_1;
  gl_FragData[0] = tmpvar_51;
}



#endif"
}
SubProgram "glesdesktop " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (((1.0 - _glesMultiTexCoord0.xy) - 0.5) * 2.2);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
uniform highp float Rg;
uniform highp float Rt;
uniform highp vec3 betaR;
uniform highp float mieG;
uniform highp float RES_R;
uniform highp float RES_MU;
uniform highp float RES_MU_S;
uniform highp float RES_NU;
uniform highp float _Sun_Intensity;
uniform sampler2D _Sky_Irradiance;
uniform sampler2D _Sky_Inscatter;
uniform highp vec3 _Sun_WorldSunDir;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec3 result_1;
  highp float l_2;
  highp vec2 u_3;
  u_3 = xlv_TEXCOORD0;
  highp float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD0, xlv_TEXCOORD0);
  l_2 = tmpvar_4;
  result_1 = vec3(0.0, 0.0, 0.0);
  if (((tmpvar_4 <= 1.02) && (tmpvar_4 > 1.0))) {
    u_3 = (xlv_TEXCOORD0 / tmpvar_4);
    l_2 = (1.0/(tmpvar_4));
  };
  highp vec3 tmpvar_5;
  tmpvar_5.xy = (2.0 * u_3);
  tmpvar_5.z = (1.0 - l_2);
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 / (1.0 + l_2));
  highp vec3 tmpvar_7;
  tmpvar_7.xy = vec2(0.0, 0.0);
  tmpvar_7.z = Rg;
  highp vec3 tmpvar_8;
  highp vec3 camera_9;
  camera_9 = tmpvar_7;
  highp float rMu_10;
  highp float r_11;
  highp vec3 result_12;
  result_12 = vec3(0.0, 0.0, 0.0);
  highp float tmpvar_13;
  tmpvar_13 = sqrt(dot (tmpvar_7, tmpvar_7));
  r_11 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (tmpvar_7, tmpvar_6);
  rMu_10 = tmpvar_14;
  highp float f_15;
  f_15 = (((tmpvar_14 * tmpvar_14) - (tmpvar_13 * tmpvar_13)) + (Rt * Rt));
  highp float tmpvar_16;
  if ((f_15 >= 0.0)) {
    tmpvar_16 = sqrt(f_15);
  } else {
    tmpvar_16 = 1e+30;
  };
  highp float tmpvar_17;
  tmpvar_17 = max ((-(tmpvar_14) - tmpvar_16), 0.0);
  if ((tmpvar_17 > 0.0)) {
    camera_9 = (tmpvar_7 + (tmpvar_17 * tmpvar_6));
    rMu_10 = (tmpvar_14 + tmpvar_17);
    r_11 = Rt;
  };
  highp float tmpvar_18;
  tmpvar_18 = dot (tmpvar_6, _Sun_WorldSunDir);
  highp float tmpvar_19;
  tmpvar_19 = (dot (camera_9, _Sun_WorldSunDir) / r_11);
  highp vec4 tmpvar_20;
  highp float uMu_21;
  highp float uR_22;
  highp float tmpvar_23;
  tmpvar_23 = sqrt(((Rt * Rt) - (Rg * Rg)));
  highp float tmpvar_24;
  tmpvar_24 = sqrt(((r_11 * r_11) - (Rg * Rg)));
  highp float tmpvar_25;
  tmpvar_25 = (r_11 * (rMu_10 / r_11));
  highp float tmpvar_26;
  tmpvar_26 = (((tmpvar_25 * tmpvar_25) - (r_11 * r_11)) + (Rg * Rg));
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
  if ((r_11 <= Rt)) {
    result_12 = ((tmpvar_20.xyz * (0.0596831 * (1.0 + (tmpvar_18 * tmpvar_18)))) + ((((tmpvar_20.xyz * tmpvar_20.w) / max (tmpvar_20.x, 0.0001)) * (betaR.x / betaR)) * ((((0.119366 * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_18)), -1.5)) * (1.0 + (tmpvar_18 * tmpvar_18))) / (2.0 + (mieG * mieG)))));
  } else {
    result_12 = vec3(0.0, 0.0, 0.0);
  };
  tmpvar_8 = (result_12 * _Sun_Intensity);
  highp vec3 tmpvar_47;
  highp vec3 tmpvar_48;
  highp vec2 tmpvar_49;
  tmpvar_49.x = ((_Sun_WorldSunDir.z + 0.2) / 1.2);
  tmpvar_49.y = ((Rg - Rg) / (Rt - Rg));
  lowp vec4 tmpvar_50;
  tmpvar_50 = texture2DLodEXT (_Sky_Irradiance, tmpvar_49, 0.0);
  tmpvar_48 = tmpvar_50.xyz;
  tmpvar_47 = (tmpvar_48 * _Sun_Intensity);
  if ((l_2 <= 1.02)) {
    result_1 = tmpvar_8;
  } else {
    result_1 = ((tmpvar_47 / 3.14159) * 0.17);
  };
  highp vec4 tmpvar_51;
  tmpvar_51.w = 1.0;
  tmpvar_51.xyz = result_1;
  gl_FragData[0] = tmpvar_51;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (((1.0 - _glesMultiTexCoord0.xy) - 0.5) * 2.2);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform highp float Rg;
uniform highp float Rt;
uniform highp vec3 betaR;
uniform highp float mieG;
uniform highp float RES_R;
uniform highp float RES_MU;
uniform highp float RES_MU_S;
uniform highp float RES_NU;
uniform highp float _Sun_Intensity;
uniform sampler2D _Sky_Irradiance;
uniform sampler2D _Sky_Inscatter;
uniform highp vec3 _Sun_WorldSunDir;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec3 result_1;
  highp float l_2;
  highp vec2 u_3;
  u_3 = xlv_TEXCOORD0;
  highp float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD0, xlv_TEXCOORD0);
  l_2 = tmpvar_4;
  result_1 = vec3(0.0, 0.0, 0.0);
  if (((tmpvar_4 <= 1.02) && (tmpvar_4 > 1.0))) {
    u_3 = (xlv_TEXCOORD0 / tmpvar_4);
    l_2 = (1.0/(tmpvar_4));
  };
  highp vec3 tmpvar_5;
  tmpvar_5.xy = (2.0 * u_3);
  tmpvar_5.z = (1.0 - l_2);
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 / (1.0 + l_2));
  highp vec3 tmpvar_7;
  tmpvar_7.xy = vec2(0.0, 0.0);
  tmpvar_7.z = Rg;
  highp vec3 tmpvar_8;
  highp vec3 camera_9;
  camera_9 = tmpvar_7;
  highp float rMu_10;
  highp float r_11;
  highp vec3 result_12;
  result_12 = vec3(0.0, 0.0, 0.0);
  highp float tmpvar_13;
  tmpvar_13 = sqrt(dot (tmpvar_7, tmpvar_7));
  r_11 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (tmpvar_7, tmpvar_6);
  rMu_10 = tmpvar_14;
  highp float f_15;
  f_15 = (((tmpvar_14 * tmpvar_14) - (tmpvar_13 * tmpvar_13)) + (Rt * Rt));
  highp float tmpvar_16;
  if ((f_15 >= 0.0)) {
    tmpvar_16 = sqrt(f_15);
  } else {
    tmpvar_16 = 1e+30;
  };
  highp float tmpvar_17;
  tmpvar_17 = max ((-(tmpvar_14) - tmpvar_16), 0.0);
  if ((tmpvar_17 > 0.0)) {
    camera_9 = (tmpvar_7 + (tmpvar_17 * tmpvar_6));
    rMu_10 = (tmpvar_14 + tmpvar_17);
    r_11 = Rt;
  };
  highp float tmpvar_18;
  tmpvar_18 = dot (tmpvar_6, _Sun_WorldSunDir);
  highp float tmpvar_19;
  tmpvar_19 = (dot (camera_9, _Sun_WorldSunDir) / r_11);
  highp vec4 tmpvar_20;
  highp float uMu_21;
  highp float uR_22;
  highp float tmpvar_23;
  tmpvar_23 = sqrt(((Rt * Rt) - (Rg * Rg)));
  highp float tmpvar_24;
  tmpvar_24 = sqrt(((r_11 * r_11) - (Rg * Rg)));
  highp float tmpvar_25;
  tmpvar_25 = (r_11 * (rMu_10 / r_11));
  highp float tmpvar_26;
  tmpvar_26 = (((tmpvar_25 * tmpvar_25) - (r_11 * r_11)) + (Rg * Rg));
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
  if ((r_11 <= Rt)) {
    result_12 = ((tmpvar_20.xyz * (0.0596831 * (1.0 + (tmpvar_18 * tmpvar_18)))) + ((((tmpvar_20.xyz * tmpvar_20.w) / max (tmpvar_20.x, 0.0001)) * (betaR.x / betaR)) * ((((0.119366 * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_18)), -1.5)) * (1.0 + (tmpvar_18 * tmpvar_18))) / (2.0 + (mieG * mieG)))));
  } else {
    result_12 = vec3(0.0, 0.0, 0.0);
  };
  tmpvar_8 = (result_12 * _Sun_Intensity);
  highp vec3 tmpvar_47;
  highp vec3 tmpvar_48;
  highp vec2 tmpvar_49;
  tmpvar_49.x = ((_Sun_WorldSunDir.z + 0.2) / 1.2);
  tmpvar_49.y = ((Rg - Rg) / (Rt - Rg));
  lowp vec4 tmpvar_50;
  tmpvar_50 = textureLod (_Sky_Irradiance, tmpvar_49, 0.0);
  tmpvar_48 = tmpvar_50.xyz;
  tmpvar_47 = (tmpvar_48 * _Sun_Intensity);
  if ((l_2 <= 1.02)) {
    result_1 = tmpvar_8;
  } else {
    result_1 = ((tmpvar_47 / 3.14159) * 0.17);
  };
  highp vec4 tmpvar_51;
  tmpvar_51.w = 1.0;
  tmpvar_51.xyz = result_1;
  _glesFragData[0] = tmpvar_51;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
// Stats: 177 math, 5 textures
Float 0 [Rg]
Float 1 [Rt]
Vector 2 [betaR]
Float 3 [mieG]
Float 4 [RES_R]
Float 5 [RES_MU]
Float 6 [RES_MU_S]
Float 7 [RES_NU]
Float 8 [_Sun_Intensity]
Vector 9 [_Sun_WorldSunDir]
SetTexture 0 [_Sky_Inscatter] 2D 0
SetTexture 1 [_Sky_Irradiance] 2D 1
"3.0-!!ARBfp1.0
PARAM c[17] = { program.local[0..9],
		{ 1.02, 1, 0, 0.2 },
		{ 0.83333331, 0.054112695, 0, 2 },
		{ 1e+030, -0.19750001, 5.3496246, -0.01348047 },
		{ 0.05747731, 0.1212391, 0.1956359, 0.33299461 },
		{ 0.99999559, 1.570796, 0.90909088, 0.74000001 },
		{ 0.5, -1, 0.059683114, -1.5 },
		{ 9.9999997e-005, 0.11936623 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MUL R0.xy, fragment.texcoord[0], fragment.texcoord[0];
ADD R0.x, R0, R0.y;
RCP R0.w, R0.x;
MOV R1.z, c[0].x;
MOV R1.xy, c[10].z;
MUL R2.xy, fragment.texcoord[0], R0.w;
RCP R3.y, c[5].x;
SLT R0.z, c[10].y, R0.x;
SGE R0.y, c[10].x, R0.x;
MUL R0.y, R0, R0.z;
CMP R4.x, -R0.y, R0.w, R0;
ADD R0.x, R4, c[10].y;
RCP R1.w, R0.x;
DP3 R0.x, R1, R1;
RSQ R0.w, R0.x;
CMP R0.xy, -R0.y, R2, fragment.texcoord[0];
RCP R0.w, R0.w;
MOV R3.zw, c[10].xyyw;
MUL R2.x, R0.w, R0.w;
ADD R0.z, -R4.x, c[10].y;
MUL R0.xy, R0, c[11].w;
MUL R0.xyz, R0, R1.w;
DP3 R1.w, R1, R0;
MAD R2.x, R1.w, R1.w, -R2;
MAD R2.x, c[1], c[1], R2;
RSQ R2.y, R2.x;
RCP R2.y, R2.y;
CMP R2.x, R2, c[12], R2.y;
ADD R2.x, -R1.w, -R2;
MAX R2.w, R2.x, c[10].z;
MAD R2.xyz, R2.w, R0, R1;
DP3 R4.z, R0, c[9];
CMP R1.xyz, -R2.w, R2, R1;
CMP R4.y, -R2.w, c[1].x, R0.w;
DP3 R0.w, R1, c[9];
RCP R2.x, R4.y;
MUL R0.w, R0, R2.x;
MAX R0.w, R0, c[12].y;
MUL R0.w, R0, c[12].z;
ABS R1.x, R0.w;
MAX R1.y, R1.x, c[10];
RCP R1.z, R1.y;
MIN R1.y, R1.x, c[10];
MUL R1.y, R1, R1.z;
MUL R1.z, R1.y, R1.y;
MUL R2.x, R1.z, c[12].w;
ADD R2.x, R2, c[13];
MAD R2.x, R2, R1.z, -c[13].y;
MAD R2.x, R2, R1.z, c[13].z;
MAD R2.x, R2, R1.z, -c[13].w;
MAD R1.z, R2.x, R1, c[14].x;
MUL R1.y, R1.z, R1;
ADD R1.z, -R1.y, c[14].y;
ADD R1.x, R1, -c[10].y;
CMP R1.x, -R1, R1.z, R1.y;
CMP R0.w, R0, -R1.x, R1.x;
ADD R1.z, R2.w, R1.w;
CMP R3.x, -R2.w, R1.z, R1.w;
RCP R1.x, c[6].x;
ADD R0.y, -R3.z, c[7].x;
ADD R0.x, R4.z, c[10].y;
MUL R0.x, R0, R0.y;
MUL R2.y, R0.x, c[15].x;
MUL R0.y, R4, R4;
MAD R0.x, R3, R3, -R0.y;
MAD R2.x, c[0], c[0], R0;
FLR R2.z, R2.y;
SLT R0.y, c[10].z, R2.x;
SLT R0.x, R3, c[10].z;
MUL R5.x, R0, R0.y;
MUL R2.w, c[0].x, c[0].x;
MAD R0.x, c[1], c[1], -R2.w;
RSQ R3.z, R0.x;
RCP R0.z, R3.z;
MAD R1.w, -R3.y, c[15].x, c[15].x;
ADD R1.y, -R1.x, c[10];
MAD R0.w, R0, c[14].z, c[14];
MAD R0.w, R0, R1.y, R1.x;
MAD R4.w, R0, c[15].x, R2.z;
ADD R2.z, -R2, R2.y;
MOV R1.xyz, c[10].yzzw;
MAD R0.w, R3.y, c[15].x, c[15].x;
MOV R0.x, c[15].y;
MUL R0.y, R0.z, R0.z;
CMP R0, -R5.x, R1, R0;
ADD R1.x, R0.y, R2;
RSQ R1.x, R1.x;
RCP R1.x, R1.x;
MAD R0.x, R3, R0, R1;
RCP R0.y, c[7].x;
ADD R1.y, R4.w, c[10];
MUL R2.x, R0.y, R1.y;
MAD R1.y, R4, R4, -R2.w;
RCP R2.w, c[4].x;
RSQ R1.y, R1.y;
RCP R1.y, R1.y;
ADD R0.z, R0, R1.y;
RCP R0.z, R0.z;
MUL R0.x, R0, R0.z;
ADD R0.z, -R3.y, c[15].x;
MAD R3.y, R0.x, R0.z, R0.w;
MUL R3.x, R4.w, R0.y;
ADD R1.w, -R2, c[10].y;
MUL R1.z, R3, R1.y;
MUL R1.z, R1, R1.w;
MAD R1.x, R2.w, c[15], R1.z;
MUL R3.z, R1.x, c[4].x;
ADD R1.x, R3.z, -c[10].y;
FLR R1.x, R1;
MUL R1.x, R1, R2.w;
MAD R1.y, R3, R2.w, R1.x;
FLR R4.w, R3.z;
MUL R4.w, R2, R4;
MAD R2.y, R3, R2.w, R4.w;
ADD R4.w, -R2.z, c[10].y;
MOV R0.y, R1;
MOV R1.x, R2;
MOV R0.x, R3;
TEX R1, R1, texture[0], 2D;
TEX R0, R0, texture[0], 2D;
MUL R1, R2.z, R1;
MAD R1, R0, R4.w, R1;
TEX R0, R2, texture[0], 2D;
MOV R3.y, R2;
MUL R2, R2.z, R0;
TEX R0, R3, texture[0], 2D;
MAD R0, R4.w, R0, R2;
FRC R2.x, R3.z;
MUL R0, R2.x, R0;
ADD R2.x, -R2, c[10].y;
MAD R0, R1, R2.x, R0;
MAX R1.x, R0, c[16];
RCP R1.w, R1.x;
MUL R1.xyz, R0, R0.w;
MUL R2.xyz, R1, R1.w;
MUL R0.w, R4.z, c[3].x;
MUL R0.w, R0, c[11];
MAD R1.w, c[3].x, c[3].x, -R0;
ADD R1.w, R1, c[10].y;
MAD R0.w, R4.z, R4.z, c[10].y;
RCP R1.x, c[2].x;
RCP R1.z, c[2].z;
RCP R1.y, c[2].y;
MUL R1.xyz, R1, c[2].x;
MUL R1.xyz, R2, R1;
MUL R2.x, -c[3], c[3];
ADD R2.y, -R2.x, c[11].w;
ADD R2.x, R2, c[10].y;
POW R1.w, R1.w, c[15].w;
MUL R1.w, R2.x, R1;
RCP R2.x, R2.y;
MUL R1.w, R0, R1;
MUL R1.w, R1, R2.x;
MUL R1.xyz, R1.w, R1;
MUL R2.xyz, R0.w, R0;
MUL R1.xyz, R1, c[16].y;
SGE R1.w, c[1].x, R4.y;
ABS R0.x, R1.w;
SGE R0.w, c[10].x, R4.x;
MAD R1.xyz, R2, c[15].z, R1;
CMP R0.x, -R0, c[10].z, c[10].y;
CMP R0.xyz, -R0.x, c[10].z, R1;
MUL R1.xyz, R0, c[8].x;
MOV R0.x, c[0];
ADD R0.y, -R0.x, c[1].x;
RCP R0.z, R0.y;
ADD R0.x, R3.w, c[9].z;
ADD R0.y, c[0].x, -c[0].x;
MUL R0.y, R0, R0.z;
MUL R0.x, R0, c[11];
TEX R0.xyz, R0, texture[1], 2D;
MUL R2.xyz, R0, c[8].x;
ABS R0.w, R0;
CMP R0.x, -R0.w, c[10].z, c[10].y;
MUL R2.xyz, R2, c[11].y;
CMP result.color.xyz, -R0.x, R2, R1;
MOV result.color.w, c[10].y;
END
# 177 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 177 math, 10 textures
Float 0 [Rg]
Float 1 [Rt]
Vector 2 [betaR]
Float 3 [mieG]
Float 4 [RES_R]
Float 5 [RES_MU]
Float 6 [RES_MU_S]
Float 7 [RES_NU]
Float 8 [_Sun_Intensity]
Vector 9 [_Sun_WorldSunDir]
SetTexture 0 [_Sky_Inscatter] 2D 0
SetTexture 1 [_Sky_Irradiance] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c10, 1.01999998, 1.00000000, 0.00000000, 0.20000000
def c11, 0.83333331, 0.05411270, 2.00000000, 1000000015047466200000000000000.00000000
def c12, -0.19750001, 5.34960032, -1.00000000, -0.12123910
def c13, -0.01348047, 0.05747731, 0.19563590, -0.33299461
def c14, 0.99999559, 1.57079601, 0.90909088, 0.74000001
def c15, 0.50000000, 0.05968311, -1.50000000, 0.00010000
def c16, 0.11936623, 0, 0, 0
dcl_texcoord0 v0.xy
mul r0.xy, v0, v0
add r0.x, r0, r0.y
rcp r0.w, r0.x
add r0.z, -r0.x, c10.y
add r0.y, -r0.x, c10.x
mov r1.z, c0.x
mov r1.xy, c10.z
mul r2.xy, v0, r0.w
rcp r4.z, c5.x
mul r3.z, c0.x, c0.x
cmp r0.z, r0, c10, c10.y
cmp r0.y, r0, c10, c10.z
mul_pp r0.y, r0, r0.z
cmp r3.w, -r0.y, r0.x, r0
add r0.x, r3.w, c10.y
rcp r2.z, r0.x
dp3 r0.x, r1, r1
rsq r0.w, r0.x
cmp r0.xy, -r0.y, v0, r2
rcp r1.w, r0.w
mul r2.x, r1.w, r1.w
rcp r3.x, c7.x
add r0.z, -r3.w, c10.y
mul r0.xy, r0, c11.z
mul r0.xyz, r0, r2.z
dp3 r0.w, r1, r0
mad r2.x, r0.w, r0.w, -r2
mad r2.x, c1, c1, r2
rsq r2.y, r2.x
rcp r2.y, r2.y
cmp r2.x, r2, r2.y, c11.w
add r2.x, -r0.w, -r2
max r2.w, r2.x, c10.z
mad r2.xyz, r2.w, r0, r1
cmp r1.xyz, -r2.w, r1, r2
cmp r4.x, -r2.w, r1.w, c1
dp3 r4.y, r0, c9
dp3 r1.x, r1, c9
rcp r1.w, r4.x
mul r1.x, r1, r1.w
max r1.x, r1, c12
mul r1.x, r1, c12.y
abs r1.y, r1.x
max r1.z, r1.y, c10.y
rcp r1.w, r1.z
min r1.z, r1.y, c10.y
mul r1.z, r1, r1.w
mul r1.w, r1.z, r1.z
mad r2.x, r1.w, c13, c13.y
mad r2.x, r2, r1.w, c12.w
mad r2.x, r2, r1.w, c13.z
mad r2.x, r2, r1.w, c13.w
mad r1.w, r2.x, r1, c14.x
mul r1.z, r1.w, r1
add r1.w, -r1.z, c14.y
add r1.y, r1, c12.z
cmp r1.y, -r1, r1.z, r1.w
cmp r1.x, r1, r1.y, -r1.y
mov r1.y, c7.x
add r0.y, c12.z, r1
add r0.x, r4.y, c10.y
mul r0.y, r0.x, r0
mad r0.x, r1, c14.z, c14.w
mul r1.x, r0.y, c15
frc r4.w, r1.x
rcp r0.y, c6.x
add r0.z, -r0.y, c10.y
mad r0.x, r0, r0.z, r0.y
mad r0.z, c1.x, c1.x, -r3
add r1.x, r1, -r4.w
mad r1.w, r0.x, c15.x, r1.x
add r0.x, r1.w, c10.y
mul r1.x, r3, r0
add r0.x, r2.w, r0.w
cmp r1.y, -r2.w, r0.w, r0.x
rsq r1.z, r0.z
rcp r0.w, r1.z
mul r0.y, r4.x, r4.x
mad r0.y, r1, r1, -r0
mad r3.y, c0.x, c0.x, r0
cmp r0.x, r1.y, c10.z, c10.y
cmp r0.y, -r3, c10.z, c10
mul_pp r5.x, r0, r0.y
mul r2.y, r0.w, r0.w
mov r2.z, r0.w
mad r2.w, r4.z, c15.x, c15.x
mul r3.x, r1.w, r3
mov r2.x, c12.z
mad r0.w, -r4.z, c15.x, c15.x
mov r0.xyz, c10.yzzw
cmp r0, -r5.x, r2, r0
mad r2.x, r4, r4, -r3.z
rsq r2.y, r2.x
rcp r2.y, r2.y
rcp r2.x, c4.x
add r0.y, r0, r3
add r0.z, r0, r2.y
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r1.z, r1, r2.y
add r2.z, -r2.x, c10.y
mul r1.z, r1, r2
mad r1.z, r2.x, c15.x, r1
mad r0.y, r1, r0.x, r0
mul r0.x, r1.z, c4
add r1.y, r0.x, c12.z
frc r1.z, r1.y
add r1.y, r1, -r1.z
rcp r0.z, r0.z
mul r0.y, r0, r0.z
add r0.z, -r4, c15.x
mul r1.z, r1.y, r2.x
mad r1.y, r0, r0.z, r0.w
mad r5.y, r1, r2.x, r1.z
frc r4.z, r0.x
add r1.z, r0.x, -r4
mul r2.y, r2.x, r1.z
mad r1.y, r1, r2.x, r2
mov r1.z, c10
texldl r2, r1.xyzz, s0
mov r3.y, r1
mov r5.x, r1
mov r5.z, c10
mov r3.z, c10
texldl r1, r3.xyzz, s0
texldl r0, r5.xyzz, s0
mul r2, r4.w, r2
add r3.y, -r4.w, c10
mad r1, r3.y, r1, r2
mul r2, r4.w, r0
mov r0.x, r3
mov r0.z, c10
mov r0.y, r5
texldl r0, r0.xyzz, s0
mad r0, r0, r3.y, r2
add r2.x, -r4.z, c10.y
mul r1, r4.z, r1
mad r1, r0, r2.x, r1
mul r0.xyz, r1, r1.w
max r1.w, r1.x, c15
rcp r1.w, r1.w
mul r2.xyz, r0, r1.w
mul r0.w, r4.y, c3.x
mul r0.w, r0, c11.z
mad r0.w, c3.x, c3.x, -r0
add r1.w, r0, c10.y
rcp r0.x, c2.x
rcp r0.z, c2.z
rcp r0.y, c2.y
mul r0.xyz, r0, c2.x
mul r2.xyz, r2, r0
pow r0, r1.w, c15.z
mad r0.w, r4.y, r4.y, c10.y
mul r0.y, -c3.x, c3.x
mov r0.z, r0.x
add r0.x, r0.y, c10.y
mul r0.x, r0, r0.z
add r1.w, -r0.y, c11.z
rcp r0.y, r1.w
mul r0.x, r0.w, r0
mul r1.xyz, r0.w, r1
mul r0.x, r0, r0.y
mul r0.xyz, r0.x, r2
mul r0.xyz, r0, c16.x
mad r1.xyz, r1, c15.y, r0
add_pp r0.x, r4, -c1
cmp r0.xyz, -r0.x, r1, c10.z
mul r1.xyz, r0, c8.x
mov r0.x, c9.z
add r0.w, -r3, c10.x
add r0.x, c10.w, r0
mov r0.yz, c10.z
mul r0.x, r0, c11
texldl r0.xyz, r0.xyzz, s1
mul r2.xyz, r0, c8.x
cmp r0.w, r0, c10.y, c10.z
abs_pp r0.x, r0.w
mul r2.xyz, r2, c11.y
cmp oC0.xyz, -r0.x, r2, r1
mov oC0.w, c10.y
"
}
SubProgram "d3d11 " {
// Stats: 123 math
SetTexture 0 [_Sky_Inscatter] 2D 1
SetTexture 1 [_Sky_Irradiance] 2D 0
ConstBuffer "$Globals" 128
Float 20 [Rg]
Float 24 [Rt]
Vector 36 [betaR] 3
Float 76 [mieG]
Float 96 [RES_R]
Float 100 [RES_MU]
Float 104 [RES_MU_S]
Float 108 [RES_NU]
Float 112 [_Sun_Intensity]
Vector 116 [_Sun_WorldSunDir] 3
BindCB  "$Globals" 0
"ps_4_0
eefiecedjnpoehajjhjacmaefflphimjafmkmnhmabaaaaaadebdaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefchebcaaaa
eaaaaaaajnaeaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacagaaaaaadgaaaaafdcaabaaaaaaaaaaaegbabaaa
abaaaaaaapaaaaahecaabaaaaaaaaaaaegbabaaaabaaaaaaegbabaaaabaaaaaa
bnaaaaahicaabaaaaaaaaaaaabeaaaaafmipicdpckaabaaaaaaaaaaadbaaaaah
bcaabaaaabaaaaaaabeaaaaaaaaaiadpckaabaaaaaaaaaaaabaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaa
egbabaaaabaaaaaakgakbaaaaaaaaaaaaoaaaaakecaabaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpckaabaaaaaaaaaaadhaaaaajhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaaaaaaaah
icaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaaphcaabaaa
abaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaialpaaaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaabnaaaaahbcaabaaaaaaaaaaa
abeaaaaafmipicdpckaabaaaaaaaaaaaaoaaaaahocaabaaaaaaaaaaaagajbaaa
abaaaaaapgapbaaaaaaaaaaadiaaaaaiccaabaaaabaaaaaadkaabaaaaaaaaaaa
bkiacaaaaaaaaaaaabaaaaaadgaaaaahbcaabaaaabaaaaaabkiacaiaibaaaaaa
aaaaaaaaabaaaaaadiaaaaahecaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaa
abaaaaaadcaaaaakecaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaa
ckaabaiaebaaaaaaabaaaaaadcaaaaalecaabaaaabaaaaaackiacaaaaaaaaaaa
abaaaaaackiacaaaaaaaaaaaabaaaaaackaabaaaabaaaaaabnaaaaahicaabaaa
abaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaaaaelaaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaadhaaaaakecaabaaaabaaaaaadkaabaaaabaaaaaackaabaia
ebaaaaaaabaaaaaaabeaaaaamkpcejpbdcaaaaalecaabaaaabaaaaaabkiacaia
ebaaaaaaaaaaaaaaabaaaaaadkaabaaaaaaaaaaackaabaaaabaaaaaadeaaaaah
ecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaakccaabaaa
acaaaaaabkiacaaaaaaaaaaaabaaaaaadkaabaaaaaaaaaaackaabaaaabaaaaaa
dbaaaaahicaabaaaabaaaaaaabeaaaaaaaaaaaaackaabaaaabaaaaaadgaaaaag
bcaabaaaacaaaaaackiacaaaaaaaaaaaabaaaaaadhaaaaajdcaabaaaabaaaaaa
pgapbaaaabaaaaaaegaabaaaacaaaaaaegaabaaaabaaaaaadiaaaaahbcaabaaa
acaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaacaaaaaa
bkaabaaaabaaaaaabkaabaaaabaaaaaaakaabaiaebaaaaaaacaaaaaadcaaaaal
bcaabaaaacaaaaaabkiacaaaaaaaaaaaabaaaaaabkiacaaaaaaaaaaaabaaaaaa
akaabaaaacaaaaaadbaaaaahccaabaaaacaaaaaabkaabaaaabaaaaaaabeaaaaa
aaaaaaaadbaaaaahecaabaaaacaaaaaaabeaaaaaaaaaaaaaakaabaaaacaaaaaa
abaaaaahccaabaaaacaaaaaackaabaaaacaaaaaabkaabaaaacaaaaaadgaaaaai
hcaabaaaadaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaf
bcaabaaaaeaaaaaaabeaaaaaaaaaialpdiaaaaajecaabaaaacaaaaaabkiacaaa
aaaaaaaaabaaaaaabkiacaaaaaaaaaaaabaaaaaadcaaaaamicaabaaaacaaaaaa
ckiacaaaaaaaaaaaabaaaaaackiacaaaaaaaaaaaabaaaaaackaabaiaebaaaaaa
acaaaaaadcaaaaakecaabaaaacaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaa
ckaabaiaebaaaaaaacaaaaaaelaaaaafecaabaaaacaaaaaackaabaaaacaaaaaa
elaaaaafecaabaaaaeaaaaaadkaabaaaacaaaaaadiaaaaahccaabaaaaeaaaaaa
ckaabaaaaeaaaaaackaabaaaaeaaaaaaaoaaaaalhcaabaaaafaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaabgigcaaaaaaaaaaaagaaaaaaaaaaaaai
icaabaaaadaaaaaaakaabaiaebaaaaaaafaaaaaaabeaaaaaaaaaaadpaaaaaaah
icaabaaaaeaaaaaaakaabaaaafaaaaaaabeaaaaaaaaaaadpdhaaaaajpcaabaaa
adaaaaaafgafbaaaacaaaaaaegaobaaaadaaaaaaegaobaaaaeaaaaaaaoaaaaah
ccaabaaaacaaaaaackaabaaaacaaaaaackaabaaaaeaaaaaaaaaaaaahfcaabaaa
acaaaaaaagacbaaaacaaaaaafgagbaaaadaaaaaaelaaaaafbcaabaaaacaaaaaa
akaabaaaacaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaa
adaaaaaaakaabaaaacaaaaaaaoaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaa
ckaabaaaacaaaaaaaoaaaaalncaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpagijcaaaaaaaaaaaagaaaaaaaaaaaaalncaabaaaacaaaaaa
agaobaiaebaaaaaaacaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaaadpaaaaiadp
dcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaackaabaaaacaaaaaadkaabaaa
adaaaaaaaoaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaa
agaaaaaadcaaaaajbcaabaaaacaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaa
bkaabaaaafaaaaaadcaaaaakccaabaaaacaaaaaaakaabaaaacaaaaaaakiacaaa
aaaaaaaaagaaaaaaabeaaaaaaaaaialpdiaaaaaibcaabaaaacaaaaaaakaabaaa
acaaaaaaakiacaaaaaaaaaaaagaaaaaaebaaaaafccaabaaaacaaaaaabkaabaaa
acaaaaaaaoaaaaaiccaabaaaacaaaaaabkaabaaaacaaaaaaakiacaaaaaaaaaaa
agaaaaaaaaaaaaahecaabaaaadaaaaaabkaabaaaabaaaaaabkaabaaaacaaaaaa
dgaaaaafbcaabaaaaeaaaaaaabeaaaaaaaaaaaaadgaaaaagecaabaaaaeaaaaaa
bkiacaaaaaaaaaaaabaaaaaadcaaaaajlcaabaaaafaaaaaakgakbaaaabaaaaaa
jganbaaaaaaaaaaaagaibaaaaeaaaaaabaaaaaaiccaabaaaaaaaaaaajgahbaaa
aaaaaaaajgihcaaaaaaaaaaaahaaaaaadhaaaaajhcaabaaaaeaaaaaapgapbaaa
abaaaaaaegadbaaaafaaaaaaagacbaaaaeaaaaaabaaaaaaiecaabaaaaaaaaaaa
egacbaaaaeaaaaaajgihcaaaaaaaaaaaahaaaaaaaoaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaabaaaaaabnaaaaaiicaabaaaaaaaaaaackiacaaa
aaaaaaaaabaaaaaaakaabaaaabaaaaaadeaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaahbdneklodiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaabodakleadbaaaaaibcaabaaaabaaaaaaabeaaaaaaaaaiadpckaabaia
ibaaaaaaaaaaaaaadeaaaaaiecaabaaaabaaaaaackaabaiaibaaaaaaaaaaaaaa
abeaaaaaaaaaiadpaoaaaaakecaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpckaabaaaabaaaaaaddaaaaaiicaabaaaabaaaaaackaabaia
ibaaaaaaaaaaaaaaabeaaaaaaaaaiadpddaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaiadpdbaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaadiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaackaabaaaabaaaaaackaabaaa
abaaaaaadcaaaaajccaabaaaacaaaaaadkaabaaaabaaaaaaabeaaaaafpkokkdm
abeaaaaadgfkkolndcaaaaajccaabaaaacaaaaaadkaabaaaabaaaaaabkaabaaa
acaaaaaaabeaaaaaochgdidodcaaaaajccaabaaaacaaaaaadkaabaaaabaaaaaa
bkaabaaaacaaaaaaabeaaaaaaebnkjlodcaaaaajicaabaaaabaaaaaadkaabaaa
abaaaaaabkaabaaaacaaaaaaabeaaaaadiphhpdpdiaaaaahccaabaaaacaaaaaa
dkaabaaaabaaaaaackaabaaaabaaaaaadcaaaaajccaabaaaacaaaaaabkaabaaa
acaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpabaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaabkaabaaaacaaaaaadcaaaaajbcaabaaaabaaaaaackaabaaa
abaaaaaadkaabaaaabaaaaaaakaabaaaabaaaaaadhaaaaakecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaaakaabaaaabaaaaaadcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaacolkgidpabeaaaaakehadndp
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaackaabaaaafaaaaaa
aaaaaaahbcaabaaaabaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpaaaaaaaiecaabaaa
abaaaaaadkiacaaaaaaaaaaaagaaaaaaabeaaaaaaaaaialpdiaaaaahicaabaaa
abaaaaaackaabaaaabaaaaaaakaabaaaabaaaaaaebaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaabaaaaaackaabaaaabaaaaaa
dkaabaiaebaaaaaaabaaaaaaaaaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaiadpaoaaaaaiccaabaaaadaaaaaackaabaaaaaaaaaaadkiacaaa
aaaaaaaaagaaaaaaaoaaaaaibcaabaaaadaaaaaackaabaaaabaaaaaadkiacaaa
aaaaaaaaagaaaaaaeiaaaaalpcaabaaaaeaaaaaaigaabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaaeiaaaaalpcaabaaaafaaaaaa
jgafbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaa
diaaaaahpcaabaaaaeaaaaaaagaabaaaabaaaaaaegaobaaaaeaaaaaaaaaaaaai
ecaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdcaaaaaj
pcaabaaaaeaaaaaaegaobaaaafaaaaaakgakbaaaaaaaaaaaegaobaaaaeaaaaaa
ebaaaaafecaabaaaabaaaaaaakaabaaaacaaaaaabkaaaaaficaabaaaabaaaaaa
akaabaaaacaaaaaaaoaaaaaiecaabaaaabaaaaaackaabaaaabaaaaaaakiacaaa
aaaaaaaaagaaaaaaaaaaaaahicaabaaaadaaaaaackaabaaaabaaaaaabkaabaaa
abaaaaaaeiaaaaalpcaabaaaacaaaaaamgaabaaaadaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaaabeaaaaaaaaaaaaaeiaaaaalpcaabaaaadaaaaaangafbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaah
pcaabaaaacaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaa
acaaaaaaegaobaaaadaaaaaakgakbaaaaaaaaaaaegaobaaaacaaaaaadiaaaaah
pcaabaaaacaaaaaapgapbaaaabaaaaaaegaobaaaacaaaaaaaaaaaaaiecaabaaa
aaaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdcaaaaajpcaabaaa
abaaaaaaegaobaaaaeaaaaaakgakbaaaaaaaaaaaegaobaaaacaaaaaadiaaaaah
hcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadeaaaaahecaabaaa
aaaaaaaaakaabaaaabaaaaaaabeaaaaabhlhnbdiaoaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaakgakbaaaaaaaaaaaaoaaaaajhcaabaaaadaaaaaafgifcaaa
aaaaaaaaacaaaaaajgihcaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaegacbaaaadaaaaaaapaaaaaiecaabaaaaaaaaaaafgafbaaa
aaaaaaaapgipcaaaaaaaaaaaaeaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaaodcaabaaaadaaaaaa
pgipcaaaaaaaaaaaaeaaaaaapgipcaaaaaaaaaaaaeaaaaaaaceaaaaaaaaaiadp
aaaaaaeaaaaaaaaaaaaaaaaaaaaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaaakaabaaaadaaaaaacpaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaamalpbjaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaamicaabaaaabaaaaaadkiacaia
ebaaaaaaaaaaaaaaaeaaaaaadkiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaiadp
diaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaeihgpedndiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaahecaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaeihghednaoaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaabkaabaaaadaaaaaadiaaaaahhcaabaaaacaaaaaakgakbaaaaaaaaaaa
egacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaabaaaaaafgafbaaa
aaaaaaaaegacbaaaacaaaaaaabaaaaahocaabaaaaaaaaaaapgapbaaaaaaaaaaa
agajbaaaabaaaaaadiaaaaaiocaabaaaaaaaaaaafgaobaaaaaaaaaaaagiacaaa
aaaaaaaaahaaaaaadcaaaaakbcaabaaaabaaaaaadkiacaaaaaaaaaaaahaaaaaa
abeaaaaaffffffdpabeaaaaaklkkckdodgaaaaafccaabaaaabaaaaaaabeaaaaa
aaaaaaaaeiaaaaalpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaagiacaaaaaaaaaaaahaaaaaadiaaaaakhcaabaaaabaaaaaaegacbaaa
abaaaaaaaceaaaaaegkffndnegkffndnegkffndnaaaaaaaadhaaaaajhccabaaa
aaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaf
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