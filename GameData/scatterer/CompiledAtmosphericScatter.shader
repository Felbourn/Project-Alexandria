// Compiled shader for all platforms, uncompressed size: 181.0KB

Shader "Sky/AtmosphereGhoss" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _SkyDome ("SkyDome", 2D) = "white" {}
 _Scale ("Scale", Vector) = (1,1,1,1)
}
SubShader { 
 Tags { "QUEUE"="Transparent-5" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }


 // Stats for Vertex shader:
 //       d3d11 : 15 math
 //        d3d9 : 20 math, 1 branch
 // Stats for Fragment shader:
 //       d3d11 : 517 math, 1 texture, 8 branch
 //        d3d9 : 735 math, 57 texture, 6 branch
 Pass {
  Tags { "QUEUE"="Transparent-5" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX
uniform vec4 _ProjectionParams;


varying vec4 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD2;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  vec2 tmpvar_6;
  tmpvar_6 = (o_3.xy / tmpvar_2.w);
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec4 _ZBufferParams;
uniform sampler2D _Transmittance;
uniform sampler2D _Inscatter;
uniform float M_PI;
uniform float Rg;
uniform float Rt;
uniform float RES_R;
uniform float RES_MU;
uniform float RES_MU_S;
uniform float RES_NU;
uniform vec3 SUN_DIR;
uniform float SUN_INTENSITY;
uniform vec3 betaR;
uniform float mieG;
uniform mat4 _ViewProjInv;
uniform float _Scale;
uniform float _global_alpha;
uniform float _Exposure;
uniform float _global_depth;
uniform float _global_depth2;
uniform vec3 _inCamPos;
uniform vec3 _Globals_Origin;
uniform sampler2D _CameraDepthTexture;
varying vec2 xlv_TEXCOORD2;
void main ()
{
  vec4 tmpvar_1;
  float visib_2;
  vec3 worldPos_3;
  float tmpvar_4;
  tmpvar_4 = (_global_depth2 * (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD2).x) + _ZBufferParams.y))));
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((xlv_TEXCOORD2.x * 2.0) - 1.0);
  tmpvar_5.y = ((xlv_TEXCOORD2.y * 2.0) - 1.0);
  tmpvar_5.z = ((texture2D (_CameraDepthTexture, xlv_TEXCOORD2).x * 2.0) - 1.0);
  vec4 tmpvar_6;
  tmpvar_6 = (_ViewProjInv * tmpvar_5);
  vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 / tmpvar_6.w).xyz;
  worldPos_3 = tmpvar_7;
  float tmpvar_8;
  tmpvar_8 = sqrt(dot (tmpvar_7, tmpvar_7));
  if ((tmpvar_8 < (Rg + 250.0))) {
    worldPos_3 = ((Rg + 250.0) * normalize(tmpvar_7));
  };
  if ((tmpvar_4 >= 1.0)) {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    vec3 tmpvar_9;
    vec3 camera_10;
    camera_10 = ((_inCamPos - _Globals_Origin) * _Scale);
    vec3 _point_11;
    _point_11 = (worldPos_3 * _Scale);
    vec3 extinction_12;
    float mu_13;
    float rMu_14;
    float r_15;
    float d_16;
    vec3 result_17;
    result_17 = vec3(0.0, 0.0, 0.0);
    extinction_12 = vec3(1.0, 1.0, 1.0);
    vec3 tmpvar_18;
    tmpvar_18 = (_point_11 - camera_10);
    float tmpvar_19;
    tmpvar_19 = sqrt(dot (tmpvar_18, tmpvar_18));
    vec3 tmpvar_20;
    tmpvar_20 = (tmpvar_18 / tmpvar_19);
    d_16 = tmpvar_19;
    float tmpvar_21;
    tmpvar_21 = sqrt(dot (camera_10, camera_10));
    r_15 = tmpvar_21;
    if ((tmpvar_21 < (0.9 * Rg))) {
      camera_10.y = (camera_10.y + Rg);
      _point_11.y = (_point_11.y + Rg);
      r_15 = sqrt(dot (camera_10, camera_10));
    };
    float tmpvar_22;
    tmpvar_22 = dot (camera_10, tmpvar_20);
    rMu_14 = tmpvar_22;
    mu_13 = (tmpvar_22 / r_15);
    vec3 tmpvar_23;
    tmpvar_23 = (_point_11 - (tmpvar_20 * clamp (1.0, 0.0, tmpvar_19)));
    _point_11 = tmpvar_23;
    float tmpvar_24;
    tmpvar_24 = max ((-(tmpvar_22) - sqrt((((tmpvar_22 * tmpvar_22) - (r_15 * r_15)) + (Rt * Rt)))), 0.0);
    if (((tmpvar_24 > 0.0) && (tmpvar_24 < tmpvar_19))) {
      camera_10 = (camera_10 + (tmpvar_24 * tmpvar_20));
      float tmpvar_25;
      tmpvar_25 = (tmpvar_22 + tmpvar_24);
      rMu_14 = tmpvar_25;
      mu_13 = (tmpvar_25 / Rt);
      r_15 = Rt;
      d_16 = (tmpvar_19 - tmpvar_24);
    };
    if ((r_15 <= Rt)) {
      float muS1_26;
      float mu1_27;
      float r1_28;
      vec4 inScatter_29;
      float tmpvar_30;
      tmpvar_30 = dot (tmpvar_20, SUN_DIR);
      float tmpvar_31;
      tmpvar_31 = (dot (camera_10, SUN_DIR) / r_15);
      if ((r_15 < (Rg + 600.0))) {
        float tmpvar_32;
        tmpvar_32 = ((Rg + 600.0) / r_15);
        r_15 = (r_15 * tmpvar_32);
        rMu_14 = (rMu_14 * tmpvar_32);
        _point_11 = (tmpvar_23 * tmpvar_32);
      };
      float tmpvar_33;
      tmpvar_33 = sqrt(dot (_point_11, _point_11));
      r1_28 = tmpvar_33;
      float tmpvar_34;
      tmpvar_34 = (dot (_point_11, tmpvar_20) / tmpvar_33);
      mu1_27 = tmpvar_34;
      muS1_26 = (dot (_point_11, SUN_DIR) / tmpvar_33);
      if ((mu_13 > 0.0)) {
        float y_over_x_35;
        y_over_x_35 = (((mu_13 + 0.15) / 1.15) * 14.1014);
        float x_36;
        x_36 = (y_over_x_35 * inversesqrt(((y_over_x_35 * y_over_x_35) + 1.0)));
        vec4 tmpvar_37;
        tmpvar_37.zw = vec2(0.0, 0.0);
        tmpvar_37.x = ((sign(x_36) * (1.5708 - (sqrt((1.0 - abs(x_36))) * (1.5708 + (abs(x_36) * (-0.214602 + (abs(x_36) * (0.0865667 + (abs(x_36) * -0.0310296))))))))) / 1.5);
        tmpvar_37.y = sqrt(((r_15 - Rg) / (Rt - Rg)));
        float y_over_x_38;
        y_over_x_38 = (((tmpvar_34 + 0.15) / 1.15) * 14.1014);
        float x_39;
        x_39 = (y_over_x_38 * inversesqrt(((y_over_x_38 * y_over_x_38) + 1.0)));
        vec4 tmpvar_40;
        tmpvar_40.zw = vec2(0.0, 0.0);
        tmpvar_40.x = ((sign(x_39) * (1.5708 - (sqrt((1.0 - abs(x_39))) * (1.5708 + (abs(x_39) * (-0.214602 + (abs(x_39) * (0.0865667 + (abs(x_39) * -0.0310296))))))))) / 1.5);
        tmpvar_40.y = sqrt(((tmpvar_33 - Rg) / (Rt - Rg)));
        extinction_12 = min ((texture2DLod (_Transmittance, tmpvar_37.xy, 0.0).xyz / texture2DLod (_Transmittance, tmpvar_40.xy, 0.0).xyz), vec3(1.0, 1.0, 1.0));
      } else {
        float y_over_x_41;
        y_over_x_41 = (((-(tmpvar_34) + 0.15) / 1.15) * 14.1014);
        float x_42;
        x_42 = (y_over_x_41 * inversesqrt(((y_over_x_41 * y_over_x_41) + 1.0)));
        vec4 tmpvar_43;
        tmpvar_43.zw = vec2(0.0, 0.0);
        tmpvar_43.x = ((sign(x_42) * (1.5708 - (sqrt((1.0 - abs(x_42))) * (1.5708 + (abs(x_42) * (-0.214602 + (abs(x_42) * (0.0865667 + (abs(x_42) * -0.0310296))))))))) / 1.5);
        tmpvar_43.y = sqrt(((tmpvar_33 - Rg) / (Rt - Rg)));
        float y_over_x_44;
        y_over_x_44 = (((-(mu_13) + 0.15) / 1.15) * 14.1014);
        float x_45;
        x_45 = (y_over_x_44 * inversesqrt(((y_over_x_44 * y_over_x_44) + 1.0)));
        vec4 tmpvar_46;
        tmpvar_46.zw = vec2(0.0, 0.0);
        tmpvar_46.x = ((sign(x_45) * (1.5708 - (sqrt((1.0 - abs(x_45))) * (1.5708 + (abs(x_45) * (-0.214602 + (abs(x_45) * (0.0865667 + (abs(x_45) * -0.0310296))))))))) / 1.5);
        tmpvar_46.y = sqrt(((r_15 - Rg) / (Rt - Rg)));
        extinction_12 = min ((texture2DLod (_Transmittance, tmpvar_43.xy, 0.0).xyz / texture2DLod (_Transmittance, tmpvar_46.xy, 0.0).xyz), vec3(1.0, 1.0, 1.0));
      };
      float tmpvar_47;
      tmpvar_47 = -(sqrt((1.0 - ((Rg / r_15) * (Rg / r_15)))));
      float tmpvar_48;
      tmpvar_48 = abs((mu_13 - tmpvar_47));
      if ((tmpvar_48 < 0.004)) {
        vec4 inScatterA_49;
        vec4 inScatter0_50;
        float a_51;
        a_51 = (((mu_13 - tmpvar_47) + 0.004) / 0.008);
        float tmpvar_52;
        tmpvar_52 = (tmpvar_47 - 0.004);
        mu_13 = tmpvar_52;
        float tmpvar_53;
        tmpvar_53 = sqrt((((r_15 * r_15) + (d_16 * d_16)) + (((2.0 * r_15) * d_16) * tmpvar_52)));
        r1_28 = tmpvar_53;
        mu1_27 = (((r_15 * tmpvar_52) + d_16) / tmpvar_53);
        float uMu_54;
        float uR_55;
        float tmpvar_56;
        tmpvar_56 = sqrt(((Rt * Rt) - (Rg * Rg)));
        float tmpvar_57;
        tmpvar_57 = sqrt(((r_15 * r_15) - (Rg * Rg)));
        float tmpvar_58;
        tmpvar_58 = (r_15 * tmpvar_52);
        float tmpvar_59;
        tmpvar_59 = (((tmpvar_58 * tmpvar_58) - (r_15 * r_15)) + (Rg * Rg));
        vec4 tmpvar_60;
        if (((tmpvar_58 < 0.0) && (tmpvar_59 > 0.0))) {
          vec4 tmpvar_61;
          tmpvar_61.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_61.w = (0.5 - (0.5 / RES_MU));
          tmpvar_60 = tmpvar_61;
        } else {
          vec4 tmpvar_62;
          tmpvar_62.x = -1.0;
          tmpvar_62.y = (tmpvar_56 * tmpvar_56);
          tmpvar_62.z = tmpvar_56;
          tmpvar_62.w = (0.5 + (0.5 / RES_MU));
          tmpvar_60 = tmpvar_62;
        };
        uR_55 = ((0.5 / RES_R) + ((tmpvar_57 / tmpvar_56) * (1.0 - (1.0/(RES_R)))));
        uMu_54 = (tmpvar_60.w + ((((tmpvar_58 * tmpvar_60.x) + sqrt((tmpvar_59 + tmpvar_60.y))) / (tmpvar_57 + tmpvar_60.z)) * (0.5 - (1.0/(RES_MU)))));
        float y_over_x_63;
        y_over_x_63 = (max (tmpvar_31, -0.1975) * 5.34962);
        float x_64;
        x_64 = (y_over_x_63 * inversesqrt(((y_over_x_63 * y_over_x_63) + 1.0)));
        float tmpvar_65;
        tmpvar_65 = ((0.5 / RES_MU_S) + (((((sign(x_64) * (1.5708 - (sqrt((1.0 - abs(x_64))) * (1.5708 + (abs(x_64) * (-0.214602 + (abs(x_64) * (0.0865667 + (abs(x_64) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        float tmpvar_66;
        tmpvar_66 = (((tmpvar_30 + 1.0) / 2.0) * (RES_NU - 1.0));
        float tmpvar_67;
        tmpvar_67 = floor(tmpvar_66);
        float tmpvar_68;
        tmpvar_68 = (tmpvar_66 - tmpvar_67);
        float tmpvar_69;
        tmpvar_69 = (floor(((uR_55 * RES_R) - 1.0)) / RES_R);
        float tmpvar_70;
        tmpvar_70 = (floor((uR_55 * RES_R)) / RES_R);
        float tmpvar_71;
        tmpvar_71 = fract((uR_55 * RES_R));
        vec4 tmpvar_72;
        tmpvar_72.zw = vec2(0.0, 0.0);
        tmpvar_72.x = ((tmpvar_67 + tmpvar_65) / RES_NU);
        tmpvar_72.y = ((uMu_54 / RES_R) + tmpvar_69);
        vec4 tmpvar_73;
        tmpvar_73.zw = vec2(0.0, 0.0);
        tmpvar_73.x = (((tmpvar_67 + tmpvar_65) + 1.0) / RES_NU);
        tmpvar_73.y = ((uMu_54 / RES_R) + tmpvar_69);
        vec4 tmpvar_74;
        tmpvar_74.zw = vec2(0.0, 0.0);
        tmpvar_74.x = ((tmpvar_67 + tmpvar_65) / RES_NU);
        tmpvar_74.y = ((uMu_54 / RES_R) + tmpvar_70);
        vec4 tmpvar_75;
        tmpvar_75.zw = vec2(0.0, 0.0);
        tmpvar_75.x = (((tmpvar_67 + tmpvar_65) + 1.0) / RES_NU);
        tmpvar_75.y = ((uMu_54 / RES_R) + tmpvar_70);
        inScatter0_50 = ((((texture2DLod (_Inscatter, tmpvar_72.xy, 0.0) * (1.0 - tmpvar_68)) + (texture2DLod (_Inscatter, tmpvar_73.xy, 0.0) * tmpvar_68)) * (1.0 - tmpvar_71)) + (((texture2DLod (_Inscatter, tmpvar_74.xy, 0.0) * (1.0 - tmpvar_68)) + (texture2DLod (_Inscatter, tmpvar_75.xy, 0.0) * tmpvar_68)) * tmpvar_71));
        float uMu_76;
        float uR_77;
        float tmpvar_78;
        tmpvar_78 = sqrt(((Rt * Rt) - (Rg * Rg)));
        float tmpvar_79;
        tmpvar_79 = sqrt(((tmpvar_53 * tmpvar_53) - (Rg * Rg)));
        float tmpvar_80;
        tmpvar_80 = (tmpvar_53 * mu1_27);
        float tmpvar_81;
        tmpvar_81 = (((tmpvar_80 * tmpvar_80) - (tmpvar_53 * tmpvar_53)) + (Rg * Rg));
        vec4 tmpvar_82;
        if (((tmpvar_80 < 0.0) && (tmpvar_81 > 0.0))) {
          vec4 tmpvar_83;
          tmpvar_83.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_83.w = (0.5 - (0.5 / RES_MU));
          tmpvar_82 = tmpvar_83;
        } else {
          vec4 tmpvar_84;
          tmpvar_84.x = -1.0;
          tmpvar_84.y = (tmpvar_78 * tmpvar_78);
          tmpvar_84.z = tmpvar_78;
          tmpvar_84.w = (0.5 + (0.5 / RES_MU));
          tmpvar_82 = tmpvar_84;
        };
        uR_77 = ((0.5 / RES_R) + ((tmpvar_79 / tmpvar_78) * (1.0 - (1.0/(RES_R)))));
        uMu_76 = (tmpvar_82.w + ((((tmpvar_80 * tmpvar_82.x) + sqrt((tmpvar_81 + tmpvar_82.y))) / (tmpvar_79 + tmpvar_82.z)) * (0.5 - (1.0/(RES_MU)))));
        float y_over_x_85;
        y_over_x_85 = (max (muS1_26, -0.1975) * 5.34962);
        float x_86;
        x_86 = (y_over_x_85 * inversesqrt(((y_over_x_85 * y_over_x_85) + 1.0)));
        float tmpvar_87;
        tmpvar_87 = ((0.5 / RES_MU_S) + (((((sign(x_86) * (1.5708 - (sqrt((1.0 - abs(x_86))) * (1.5708 + (abs(x_86) * (-0.214602 + (abs(x_86) * (0.0865667 + (abs(x_86) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        float tmpvar_88;
        tmpvar_88 = (((tmpvar_30 + 1.0) / 2.0) * (RES_NU - 1.0));
        float tmpvar_89;
        tmpvar_89 = floor(tmpvar_88);
        float tmpvar_90;
        tmpvar_90 = (tmpvar_88 - tmpvar_89);
        float tmpvar_91;
        tmpvar_91 = (floor(((uR_77 * RES_R) - 1.0)) / RES_R);
        float tmpvar_92;
        tmpvar_92 = (floor((uR_77 * RES_R)) / RES_R);
        float tmpvar_93;
        tmpvar_93 = fract((uR_77 * RES_R));
        vec4 tmpvar_94;
        tmpvar_94.zw = vec2(0.0, 0.0);
        tmpvar_94.x = ((tmpvar_89 + tmpvar_87) / RES_NU);
        tmpvar_94.y = ((uMu_76 / RES_R) + tmpvar_91);
        vec4 tmpvar_95;
        tmpvar_95.zw = vec2(0.0, 0.0);
        tmpvar_95.x = (((tmpvar_89 + tmpvar_87) + 1.0) / RES_NU);
        tmpvar_95.y = ((uMu_76 / RES_R) + tmpvar_91);
        vec4 tmpvar_96;
        tmpvar_96.zw = vec2(0.0, 0.0);
        tmpvar_96.x = ((tmpvar_89 + tmpvar_87) / RES_NU);
        tmpvar_96.y = ((uMu_76 / RES_R) + tmpvar_92);
        vec4 tmpvar_97;
        tmpvar_97.zw = vec2(0.0, 0.0);
        tmpvar_97.x = (((tmpvar_89 + tmpvar_87) + 1.0) / RES_NU);
        tmpvar_97.y = ((uMu_76 / RES_R) + tmpvar_92);
        inScatterA_49 = max ((inScatter0_50 - (((((texture2DLod (_Inscatter, tmpvar_94.xy, 0.0) * (1.0 - tmpvar_90)) + (texture2DLod (_Inscatter, tmpvar_95.xy, 0.0) * tmpvar_90)) * (1.0 - tmpvar_93)) + (((texture2DLod (_Inscatter, tmpvar_96.xy, 0.0) * (1.0 - tmpvar_90)) + (texture2DLod (_Inscatter, tmpvar_97.xy, 0.0) * tmpvar_90)) * tmpvar_93)) * extinction_12.xyzx)), vec4(0.0, 0.0, 0.0, 0.0));
        float tmpvar_98;
        tmpvar_98 = (tmpvar_47 + 0.004);
        mu_13 = tmpvar_98;
        float tmpvar_99;
        tmpvar_99 = sqrt((((r_15 * r_15) + (d_16 * d_16)) + (((2.0 * r_15) * d_16) * tmpvar_98)));
        r1_28 = tmpvar_99;
        mu1_27 = (((r_15 * tmpvar_98) + d_16) / tmpvar_99);
        float uMu_100;
        float uR_101;
        float tmpvar_102;
        tmpvar_102 = sqrt(((Rt * Rt) - (Rg * Rg)));
        float tmpvar_103;
        tmpvar_103 = sqrt(((r_15 * r_15) - (Rg * Rg)));
        float tmpvar_104;
        tmpvar_104 = (r_15 * tmpvar_98);
        float tmpvar_105;
        tmpvar_105 = (((tmpvar_104 * tmpvar_104) - (r_15 * r_15)) + (Rg * Rg));
        vec4 tmpvar_106;
        if (((tmpvar_104 < 0.0) && (tmpvar_105 > 0.0))) {
          vec4 tmpvar_107;
          tmpvar_107.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_107.w = (0.5 - (0.5 / RES_MU));
          tmpvar_106 = tmpvar_107;
        } else {
          vec4 tmpvar_108;
          tmpvar_108.x = -1.0;
          tmpvar_108.y = (tmpvar_102 * tmpvar_102);
          tmpvar_108.z = tmpvar_102;
          tmpvar_108.w = (0.5 + (0.5 / RES_MU));
          tmpvar_106 = tmpvar_108;
        };
        uR_101 = ((0.5 / RES_R) + ((tmpvar_103 / tmpvar_102) * (1.0 - (1.0/(RES_R)))));
        uMu_100 = (tmpvar_106.w + ((((tmpvar_104 * tmpvar_106.x) + sqrt((tmpvar_105 + tmpvar_106.y))) / (tmpvar_103 + tmpvar_106.z)) * (0.5 - (1.0/(RES_MU)))));
        float y_over_x_109;
        y_over_x_109 = (max (tmpvar_31, -0.1975) * 5.34962);
        float x_110;
        x_110 = (y_over_x_109 * inversesqrt(((y_over_x_109 * y_over_x_109) + 1.0)));
        float tmpvar_111;
        tmpvar_111 = ((0.5 / RES_MU_S) + (((((sign(x_110) * (1.5708 - (sqrt((1.0 - abs(x_110))) * (1.5708 + (abs(x_110) * (-0.214602 + (abs(x_110) * (0.0865667 + (abs(x_110) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        float tmpvar_112;
        tmpvar_112 = (((tmpvar_30 + 1.0) / 2.0) * (RES_NU - 1.0));
        float tmpvar_113;
        tmpvar_113 = floor(tmpvar_112);
        float tmpvar_114;
        tmpvar_114 = (tmpvar_112 - tmpvar_113);
        float tmpvar_115;
        tmpvar_115 = (floor(((uR_101 * RES_R) - 1.0)) / RES_R);
        float tmpvar_116;
        tmpvar_116 = (floor((uR_101 * RES_R)) / RES_R);
        float tmpvar_117;
        tmpvar_117 = fract((uR_101 * RES_R));
        vec4 tmpvar_118;
        tmpvar_118.zw = vec2(0.0, 0.0);
        tmpvar_118.x = ((tmpvar_113 + tmpvar_111) / RES_NU);
        tmpvar_118.y = ((uMu_100 / RES_R) + tmpvar_115);
        vec4 tmpvar_119;
        tmpvar_119.zw = vec2(0.0, 0.0);
        tmpvar_119.x = (((tmpvar_113 + tmpvar_111) + 1.0) / RES_NU);
        tmpvar_119.y = ((uMu_100 / RES_R) + tmpvar_115);
        vec4 tmpvar_120;
        tmpvar_120.zw = vec2(0.0, 0.0);
        tmpvar_120.x = ((tmpvar_113 + tmpvar_111) / RES_NU);
        tmpvar_120.y = ((uMu_100 / RES_R) + tmpvar_116);
        vec4 tmpvar_121;
        tmpvar_121.zw = vec2(0.0, 0.0);
        tmpvar_121.x = (((tmpvar_113 + tmpvar_111) + 1.0) / RES_NU);
        tmpvar_121.y = ((uMu_100 / RES_R) + tmpvar_116);
        inScatter0_50 = ((((texture2DLod (_Inscatter, tmpvar_118.xy, 0.0) * (1.0 - tmpvar_114)) + (texture2DLod (_Inscatter, tmpvar_119.xy, 0.0) * tmpvar_114)) * (1.0 - tmpvar_117)) + (((texture2DLod (_Inscatter, tmpvar_120.xy, 0.0) * (1.0 - tmpvar_114)) + (texture2DLod (_Inscatter, tmpvar_121.xy, 0.0) * tmpvar_114)) * tmpvar_117));
        float uMu_122;
        float uR_123;
        float tmpvar_124;
        tmpvar_124 = sqrt(((Rt * Rt) - (Rg * Rg)));
        float tmpvar_125;
        tmpvar_125 = sqrt(((tmpvar_99 * tmpvar_99) - (Rg * Rg)));
        float tmpvar_126;
        tmpvar_126 = (tmpvar_99 * mu1_27);
        float tmpvar_127;
        tmpvar_127 = (((tmpvar_126 * tmpvar_126) - (tmpvar_99 * tmpvar_99)) + (Rg * Rg));
        vec4 tmpvar_128;
        if (((tmpvar_126 < 0.0) && (tmpvar_127 > 0.0))) {
          vec4 tmpvar_129;
          tmpvar_129.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_129.w = (0.5 - (0.5 / RES_MU));
          tmpvar_128 = tmpvar_129;
        } else {
          vec4 tmpvar_130;
          tmpvar_130.x = -1.0;
          tmpvar_130.y = (tmpvar_124 * tmpvar_124);
          tmpvar_130.z = tmpvar_124;
          tmpvar_130.w = (0.5 + (0.5 / RES_MU));
          tmpvar_128 = tmpvar_130;
        };
        uR_123 = ((0.5 / RES_R) + ((tmpvar_125 / tmpvar_124) * (1.0 - (1.0/(RES_R)))));
        uMu_122 = (tmpvar_128.w + ((((tmpvar_126 * tmpvar_128.x) + sqrt((tmpvar_127 + tmpvar_128.y))) / (tmpvar_125 + tmpvar_128.z)) * (0.5 - (1.0/(RES_MU)))));
        float y_over_x_131;
        y_over_x_131 = (max (muS1_26, -0.1975) * 5.34962);
        float x_132;
        x_132 = (y_over_x_131 * inversesqrt(((y_over_x_131 * y_over_x_131) + 1.0)));
        float tmpvar_133;
        tmpvar_133 = ((0.5 / RES_MU_S) + (((((sign(x_132) * (1.5708 - (sqrt((1.0 - abs(x_132))) * (1.5708 + (abs(x_132) * (-0.214602 + (abs(x_132) * (0.0865667 + (abs(x_132) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        float tmpvar_134;
        tmpvar_134 = (((tmpvar_30 + 1.0) / 2.0) * (RES_NU - 1.0));
        float tmpvar_135;
        tmpvar_135 = floor(tmpvar_134);
        float tmpvar_136;
        tmpvar_136 = (tmpvar_134 - tmpvar_135);
        float tmpvar_137;
        tmpvar_137 = (floor(((uR_123 * RES_R) - 1.0)) / RES_R);
        float tmpvar_138;
        tmpvar_138 = (floor((uR_123 * RES_R)) / RES_R);
        float tmpvar_139;
        tmpvar_139 = fract((uR_123 * RES_R));
        vec4 tmpvar_140;
        tmpvar_140.zw = vec2(0.0, 0.0);
        tmpvar_140.x = ((tmpvar_135 + tmpvar_133) / RES_NU);
        tmpvar_140.y = ((uMu_122 / RES_R) + tmpvar_137);
        vec4 tmpvar_141;
        tmpvar_141.zw = vec2(0.0, 0.0);
        tmpvar_141.x = (((tmpvar_135 + tmpvar_133) + 1.0) / RES_NU);
        tmpvar_141.y = ((uMu_122 / RES_R) + tmpvar_137);
        vec4 tmpvar_142;
        tmpvar_142.zw = vec2(0.0, 0.0);
        tmpvar_142.x = ((tmpvar_135 + tmpvar_133) / RES_NU);
        tmpvar_142.y = ((uMu_122 / RES_R) + tmpvar_138);
        vec4 tmpvar_143;
        tmpvar_143.zw = vec2(0.0, 0.0);
        tmpvar_143.x = (((tmpvar_135 + tmpvar_133) + 1.0) / RES_NU);
        tmpvar_143.y = ((uMu_122 / RES_R) + tmpvar_138);
        inScatter_29 = mix (inScatterA_49, max ((inScatter0_50 - (((((texture2DLod (_Inscatter, tmpvar_140.xy, 0.0) * (1.0 - tmpvar_136)) + (texture2DLod (_Inscatter, tmpvar_141.xy, 0.0) * tmpvar_136)) * (1.0 - tmpvar_139)) + (((texture2DLod (_Inscatter, tmpvar_142.xy, 0.0) * (1.0 - tmpvar_136)) + (texture2DLod (_Inscatter, tmpvar_143.xy, 0.0) * tmpvar_136)) * tmpvar_139)) * extinction_12.xyzx)), vec4(0.0, 0.0, 0.0, 0.0)), vec4(a_51));
      } else {
        vec4 inScatter0_1_144;
        float uMu_145;
        float uR_146;
        float tmpvar_147;
        tmpvar_147 = sqrt(((Rt * Rt) - (Rg * Rg)));
        float tmpvar_148;
        tmpvar_148 = sqrt(((r_15 * r_15) - (Rg * Rg)));
        float tmpvar_149;
        tmpvar_149 = (r_15 * mu_13);
        float tmpvar_150;
        tmpvar_150 = (((tmpvar_149 * tmpvar_149) - (r_15 * r_15)) + (Rg * Rg));
        vec4 tmpvar_151;
        if (((tmpvar_149 < 0.0) && (tmpvar_150 > 0.0))) {
          vec4 tmpvar_152;
          tmpvar_152.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_152.w = (0.5 - (0.5 / RES_MU));
          tmpvar_151 = tmpvar_152;
        } else {
          vec4 tmpvar_153;
          tmpvar_153.x = -1.0;
          tmpvar_153.y = (tmpvar_147 * tmpvar_147);
          tmpvar_153.z = tmpvar_147;
          tmpvar_153.w = (0.5 + (0.5 / RES_MU));
          tmpvar_151 = tmpvar_153;
        };
        uR_146 = ((0.5 / RES_R) + ((tmpvar_148 / tmpvar_147) * (1.0 - (1.0/(RES_R)))));
        uMu_145 = (tmpvar_151.w + ((((tmpvar_149 * tmpvar_151.x) + sqrt((tmpvar_150 + tmpvar_151.y))) / (tmpvar_148 + tmpvar_151.z)) * (0.5 - (1.0/(RES_MU)))));
        float y_over_x_154;
        y_over_x_154 = (max (tmpvar_31, -0.1975) * 5.34962);
        float x_155;
        x_155 = (y_over_x_154 * inversesqrt(((y_over_x_154 * y_over_x_154) + 1.0)));
        float tmpvar_156;
        tmpvar_156 = ((0.5 / RES_MU_S) + (((((sign(x_155) * (1.5708 - (sqrt((1.0 - abs(x_155))) * (1.5708 + (abs(x_155) * (-0.214602 + (abs(x_155) * (0.0865667 + (abs(x_155) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        float tmpvar_157;
        tmpvar_157 = (((tmpvar_30 + 1.0) / 2.0) * (RES_NU - 1.0));
        float tmpvar_158;
        tmpvar_158 = floor(tmpvar_157);
        float tmpvar_159;
        tmpvar_159 = (tmpvar_157 - tmpvar_158);
        float tmpvar_160;
        tmpvar_160 = (floor(((uR_146 * RES_R) - 1.0)) / RES_R);
        float tmpvar_161;
        tmpvar_161 = (floor((uR_146 * RES_R)) / RES_R);
        float tmpvar_162;
        tmpvar_162 = fract((uR_146 * RES_R));
        vec4 tmpvar_163;
        tmpvar_163.zw = vec2(0.0, 0.0);
        tmpvar_163.x = ((tmpvar_158 + tmpvar_156) / RES_NU);
        tmpvar_163.y = ((uMu_145 / RES_R) + tmpvar_160);
        vec4 tmpvar_164;
        tmpvar_164.zw = vec2(0.0, 0.0);
        tmpvar_164.x = (((tmpvar_158 + tmpvar_156) + 1.0) / RES_NU);
        tmpvar_164.y = ((uMu_145 / RES_R) + tmpvar_160);
        vec4 tmpvar_165;
        tmpvar_165.zw = vec2(0.0, 0.0);
        tmpvar_165.x = ((tmpvar_158 + tmpvar_156) / RES_NU);
        tmpvar_165.y = ((uMu_145 / RES_R) + tmpvar_161);
        vec4 tmpvar_166;
        tmpvar_166.zw = vec2(0.0, 0.0);
        tmpvar_166.x = (((tmpvar_158 + tmpvar_156) + 1.0) / RES_NU);
        tmpvar_166.y = ((uMu_145 / RES_R) + tmpvar_161);
        inScatter0_1_144 = ((((texture2DLod (_Inscatter, tmpvar_163.xy, 0.0) * (1.0 - tmpvar_159)) + (texture2DLod (_Inscatter, tmpvar_164.xy, 0.0) * tmpvar_159)) * (1.0 - tmpvar_162)) + (((texture2DLod (_Inscatter, tmpvar_165.xy, 0.0) * (1.0 - tmpvar_159)) + (texture2DLod (_Inscatter, tmpvar_166.xy, 0.0) * tmpvar_159)) * tmpvar_162));
        float uMu_167;
        float uR_168;
        float tmpvar_169;
        tmpvar_169 = sqrt(((Rt * Rt) - (Rg * Rg)));
        float tmpvar_170;
        tmpvar_170 = sqrt(((r1_28 * r1_28) - (Rg * Rg)));
        float tmpvar_171;
        tmpvar_171 = (r1_28 * mu1_27);
        float tmpvar_172;
        tmpvar_172 = (((tmpvar_171 * tmpvar_171) - (r1_28 * r1_28)) + (Rg * Rg));
        vec4 tmpvar_173;
        if (((tmpvar_171 < 0.0) && (tmpvar_172 > 0.0))) {
          vec4 tmpvar_174;
          tmpvar_174.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_174.w = (0.5 - (0.5 / RES_MU));
          tmpvar_173 = tmpvar_174;
        } else {
          vec4 tmpvar_175;
          tmpvar_175.x = -1.0;
          tmpvar_175.y = (tmpvar_169 * tmpvar_169);
          tmpvar_175.z = tmpvar_169;
          tmpvar_175.w = (0.5 + (0.5 / RES_MU));
          tmpvar_173 = tmpvar_175;
        };
        uR_168 = ((0.5 / RES_R) + ((tmpvar_170 / tmpvar_169) * (1.0 - (1.0/(RES_R)))));
        uMu_167 = (tmpvar_173.w + ((((tmpvar_171 * tmpvar_173.x) + sqrt((tmpvar_172 + tmpvar_173.y))) / (tmpvar_170 + tmpvar_173.z)) * (0.5 - (1.0/(RES_MU)))));
        float y_over_x_176;
        y_over_x_176 = (max (muS1_26, -0.1975) * 5.34962);
        float x_177;
        x_177 = (y_over_x_176 * inversesqrt(((y_over_x_176 * y_over_x_176) + 1.0)));
        float tmpvar_178;
        tmpvar_178 = ((0.5 / RES_MU_S) + (((((sign(x_177) * (1.5708 - (sqrt((1.0 - abs(x_177))) * (1.5708 + (abs(x_177) * (-0.214602 + (abs(x_177) * (0.0865667 + (abs(x_177) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        float tmpvar_179;
        tmpvar_179 = (((tmpvar_30 + 1.0) / 2.0) * (RES_NU - 1.0));
        float tmpvar_180;
        tmpvar_180 = floor(tmpvar_179);
        float tmpvar_181;
        tmpvar_181 = (tmpvar_179 - tmpvar_180);
        float tmpvar_182;
        tmpvar_182 = (floor(((uR_168 * RES_R) - 1.0)) / RES_R);
        float tmpvar_183;
        tmpvar_183 = (floor((uR_168 * RES_R)) / RES_R);
        float tmpvar_184;
        tmpvar_184 = fract((uR_168 * RES_R));
        vec4 tmpvar_185;
        tmpvar_185.zw = vec2(0.0, 0.0);
        tmpvar_185.x = ((tmpvar_180 + tmpvar_178) / RES_NU);
        tmpvar_185.y = ((uMu_167 / RES_R) + tmpvar_182);
        vec4 tmpvar_186;
        tmpvar_186.zw = vec2(0.0, 0.0);
        tmpvar_186.x = (((tmpvar_180 + tmpvar_178) + 1.0) / RES_NU);
        tmpvar_186.y = ((uMu_167 / RES_R) + tmpvar_182);
        vec4 tmpvar_187;
        tmpvar_187.zw = vec2(0.0, 0.0);
        tmpvar_187.x = ((tmpvar_180 + tmpvar_178) / RES_NU);
        tmpvar_187.y = ((uMu_167 / RES_R) + tmpvar_183);
        vec4 tmpvar_188;
        tmpvar_188.zw = vec2(0.0, 0.0);
        tmpvar_188.x = (((tmpvar_180 + tmpvar_178) + 1.0) / RES_NU);
        tmpvar_188.y = ((uMu_167 / RES_R) + tmpvar_183);
        inScatter_29 = max ((inScatter0_1_144 - (((((texture2DLod (_Inscatter, tmpvar_185.xy, 0.0) * (1.0 - tmpvar_181)) + (texture2DLod (_Inscatter, tmpvar_186.xy, 0.0) * tmpvar_181)) * (1.0 - tmpvar_184)) + (((texture2DLod (_Inscatter, tmpvar_187.xy, 0.0) * (1.0 - tmpvar_181)) + (texture2DLod (_Inscatter, tmpvar_188.xy, 0.0) * tmpvar_181)) * tmpvar_184)) * extinction_12.xyzx)), vec4(0.0, 0.0, 0.0, 0.0));
      };
      float t_189;
      t_189 = max (min ((tmpvar_31 / 0.02), 1.0), 0.0);
      inScatter_29.w = (inScatter_29.w * (t_189 * (t_189 * (3.0 - (2.0 * t_189)))));
      result_17 = ((inScatter_29.xyz * ((3.0 / (16.0 * M_PI)) * (1.0 + (tmpvar_30 * tmpvar_30)))) + ((((inScatter_29.xyz * inScatter_29.w) / max (inScatter_29.x, 0.0001)) * (betaR.x / betaR)) * (((((1.5 / (4.0 * M_PI)) * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_30)), -1.5)) * (1.0 + (tmpvar_30 * tmpvar_30))) / (2.0 + (mieG * mieG)))));
    };
    tmpvar_9 = (result_17 * SUN_INTENSITY);
    visib_2 = 1.0;
    if ((tmpvar_4 <= _global_depth)) {
      visib_2 = (1.0 - exp((-1.0 * ((4.0 * tmpvar_4) / _global_depth))));
    };
    vec3 L_190;
    vec3 tmpvar_191;
    tmpvar_191 = (tmpvar_9 * _Exposure);
    L_190 = tmpvar_191;
    float tmpvar_192;
    if ((tmpvar_191.x < 1.413)) {
      tmpvar_192 = pow ((tmpvar_191.x * 0.38317), 0.454545);
    } else {
      tmpvar_192 = (1.0 - exp(-(tmpvar_191.x)));
    };
    L_190.x = tmpvar_192;
    float tmpvar_193;
    if ((tmpvar_191.y < 1.413)) {
      tmpvar_193 = pow ((tmpvar_191.y * 0.38317), 0.454545);
    } else {
      tmpvar_193 = (1.0 - exp(-(tmpvar_191.y)));
    };
    L_190.y = tmpvar_193;
    float tmpvar_194;
    if ((tmpvar_191.z < 1.413)) {
      tmpvar_194 = pow ((tmpvar_191.z * 0.38317), 0.454545);
    } else {
      tmpvar_194 = (1.0 - exp(-(tmpvar_191.z)));
    };
    L_190.z = tmpvar_194;
    vec4 tmpvar_195;
    tmpvar_195.xyz = L_190;
    tmpvar_195.w = (_global_alpha * visib_2);
    tmpvar_1 = tmpvar_195;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 20 math, 1 branches
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_TexelSize]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
def c11, 0.50000000, 0.00000000, 1.00000000, 0
dcl_position0 v0
dp4 r1.z, v0, c7
dp4 r0.x, v0, c4
rcp r0.z, r1.z
mov r0.w, r1.z
dp4 r0.y, v0, c5
mul r2.xyz, r0.xyww, c11.x
mov r1.w, c11.y
mov r1.x, r2
mul r1.y, r2, c8.x
mad r1.xy, r2.z, c9.zwzw, r1
mul r2.zw, r1.xyxy, r0.z
mov r2.xy, r2.zwzw
dp4 r0.z, v0, c6
if_lt c10.y, r1.w
add r2.y, -r2, c11.z
endif
mov o0, r0
dp4 r0.x, v0, c2
mov o1.xyw, r1.xyzz
mov o2.xy, r2
mov o3.xy, r2.zwzw
mov o1.z, -r0.x
"
}
SubProgram "d3d11 " {
// Stats: 15 math
Bind "vertex" Vertex
ConstBuffer "$Globals" 432
Vector 320 [_MainTex_TexelSize]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedgjhdohpkljjkfdjihimlkidamcdbgigbabaaaaaabmaeaaaaadaaaaaa
cmaaaaaakaaaaaaaciabaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklfdeieefcomacaaaaeaaaabaallaaaaaafjaaaaaeegiocaaa
aaaaaaaabfaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaad
mccabaaaacaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
ecaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaak
ecaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaakecaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaaaaaaaaaackiacaaaacaaaaaa
ahaaaaaadkbabaaaaaaaaaaackaabaaaaaaaaaaadgaaaaageccabaaaabaaaaaa
ckaabaiaebaaaaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpaaaaaaahdcaabaaaaaaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadgaaaaaflccabaaaabaaaaaaegambaaa
aaaaaaaaaoaaaaahhcaabaaaaaaaaaaaagabbaaaaaaaaaaapgapbaaaaaaaaaaa
aaaaaaaiicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
dbaaaaaibcaabaaaabaaaaaabkiacaaaaaaaaaaabeaaaaaaabeaaaaaaaaaaaaa
dhaaaaajcccabaaaacaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaackaabaaa
aaaaaaaadgaaaaafnccabaaaacaaaaaaagajbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  highp vec2 tmpvar_6;
  tmpvar_6 = (o_3.xy / tmpvar_2.w);
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
uniform highp vec4 _ZBufferParams;
uniform sampler2D _Transmittance;
uniform sampler2D _Inscatter;
uniform highp float M_PI;
uniform highp float Rg;
uniform highp float Rt;
uniform highp float RES_R;
uniform highp float RES_MU;
uniform highp float RES_MU_S;
uniform highp float RES_NU;
uniform highp vec3 SUN_DIR;
uniform highp float SUN_INTENSITY;
uniform highp vec3 betaR;
uniform highp float mieG;
uniform highp mat4 _ViewProjInv;
uniform highp float _Scale;
uniform highp float _global_alpha;
uniform highp float _Exposure;
uniform highp float _global_depth;
uniform highp float _global_depth2;
uniform highp vec3 _inCamPos;
uniform highp vec3 _Globals_Origin;
uniform sampler2D _CameraDepthTexture;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp float visib_2;
  highp vec3 worldPos_3;
  highp float depth_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CameraDepthTexture, xlv_TEXCOORD2);
  highp float z_6;
  z_6 = tmpvar_5.x;
  highp float tmpvar_7;
  tmpvar_7 = (_global_depth2 * (1.0/(((_ZBufferParams.x * z_6) + _ZBufferParams.y))));
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_CameraDepthTexture, xlv_TEXCOORD2).x;
  depth_4 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.x = ((xlv_TEXCOORD2.x * 2.0) - 1.0);
  tmpvar_9.y = ((xlv_TEXCOORD2.y * 2.0) - 1.0);
  tmpvar_9.z = depth_4;
  highp vec4 tmpvar_10;
  tmpvar_10 = (_ViewProjInv * tmpvar_9);
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 / tmpvar_10.w).xyz;
  worldPos_3 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
  if ((tmpvar_12 < (Rg + 250.0))) {
    worldPos_3 = ((Rg + 250.0) * normalize(tmpvar_11));
  };
  if ((tmpvar_7 >= 1.0)) {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    highp vec3 tmpvar_13;
    highp vec3 camera_14;
    camera_14 = ((_inCamPos - _Globals_Origin) * _Scale);
    highp vec3 _point_15;
    _point_15 = (worldPos_3 * _Scale);
    highp vec3 extinction_16;
    highp float mu_17;
    highp float rMu_18;
    highp float r_19;
    highp float d_20;
    highp vec3 result_21;
    result_21 = vec3(0.0, 0.0, 0.0);
    extinction_16 = vec3(1.0, 1.0, 1.0);
    highp vec3 tmpvar_22;
    tmpvar_22 = (_point_15 - camera_14);
    highp float tmpvar_23;
    tmpvar_23 = sqrt(dot (tmpvar_22, tmpvar_22));
    highp vec3 tmpvar_24;
    tmpvar_24 = (tmpvar_22 / tmpvar_23);
    d_20 = tmpvar_23;
    highp float tmpvar_25;
    tmpvar_25 = sqrt(dot (camera_14, camera_14));
    r_19 = tmpvar_25;
    if ((tmpvar_25 < (0.9 * Rg))) {
      camera_14.y = (camera_14.y + Rg);
      _point_15.y = (_point_15.y + Rg);
      r_19 = sqrt(dot (camera_14, camera_14));
    };
    highp float tmpvar_26;
    tmpvar_26 = dot (camera_14, tmpvar_24);
    rMu_18 = tmpvar_26;
    mu_17 = (tmpvar_26 / r_19);
    highp vec3 tmpvar_27;
    tmpvar_27 = (_point_15 - (tmpvar_24 * clamp (1.0, 0.0, tmpvar_23)));
    _point_15 = tmpvar_27;
    highp float tmpvar_28;
    tmpvar_28 = max ((-(tmpvar_26) - sqrt((((tmpvar_26 * tmpvar_26) - (r_19 * r_19)) + (Rt * Rt)))), 0.0);
    if (((tmpvar_28 > 0.0) && (tmpvar_28 < tmpvar_23))) {
      camera_14 = (camera_14 + (tmpvar_28 * tmpvar_24));
      highp float tmpvar_29;
      tmpvar_29 = (tmpvar_26 + tmpvar_28);
      rMu_18 = tmpvar_29;
      mu_17 = (tmpvar_29 / Rt);
      r_19 = Rt;
      d_20 = (tmpvar_23 - tmpvar_28);
    };
    if ((r_19 <= Rt)) {
      highp float muS1_30;
      highp float mu1_31;
      highp float r1_32;
      highp vec4 inScatter_33;
      highp float tmpvar_34;
      tmpvar_34 = dot (tmpvar_24, SUN_DIR);
      highp float tmpvar_35;
      tmpvar_35 = (dot (camera_14, SUN_DIR) / r_19);
      if ((r_19 < (Rg + 600.0))) {
        highp float tmpvar_36;
        tmpvar_36 = ((Rg + 600.0) / r_19);
        r_19 = (r_19 * tmpvar_36);
        rMu_18 = (rMu_18 * tmpvar_36);
        _point_15 = (tmpvar_27 * tmpvar_36);
      };
      highp float tmpvar_37;
      tmpvar_37 = sqrt(dot (_point_15, _point_15));
      r1_32 = tmpvar_37;
      highp float tmpvar_38;
      tmpvar_38 = (dot (_point_15, tmpvar_24) / tmpvar_37);
      mu1_31 = tmpvar_38;
      muS1_30 = (dot (_point_15, SUN_DIR) / tmpvar_37);
      if ((mu_17 > 0.0)) {
        highp vec3 tmpvar_39;
        highp float y_over_x_40;
        y_over_x_40 = (((mu_17 + 0.15) / 1.15) * 14.1014);
        highp float x_41;
        x_41 = (y_over_x_40 * inversesqrt(((y_over_x_40 * y_over_x_40) + 1.0)));
        highp vec4 tmpvar_42;
        tmpvar_42.zw = vec2(0.0, 0.0);
        tmpvar_42.x = ((sign(x_41) * (1.5708 - (sqrt((1.0 - abs(x_41))) * (1.5708 + (abs(x_41) * (-0.214602 + (abs(x_41) * (0.0865667 + (abs(x_41) * -0.0310296))))))))) / 1.5);
        tmpvar_42.y = sqrt(((r_19 - Rg) / (Rt - Rg)));
        lowp vec4 tmpvar_43;
        tmpvar_43 = texture2DLodEXT (_Transmittance, tmpvar_42.xy, 0.0);
        tmpvar_39 = tmpvar_43.xyz;
        highp vec3 tmpvar_44;
        highp float y_over_x_45;
        y_over_x_45 = (((tmpvar_38 + 0.15) / 1.15) * 14.1014);
        highp float x_46;
        x_46 = (y_over_x_45 * inversesqrt(((y_over_x_45 * y_over_x_45) + 1.0)));
        highp vec4 tmpvar_47;
        tmpvar_47.zw = vec2(0.0, 0.0);
        tmpvar_47.x = ((sign(x_46) * (1.5708 - (sqrt((1.0 - abs(x_46))) * (1.5708 + (abs(x_46) * (-0.214602 + (abs(x_46) * (0.0865667 + (abs(x_46) * -0.0310296))))))))) / 1.5);
        tmpvar_47.y = sqrt(((tmpvar_37 - Rg) / (Rt - Rg)));
        lowp vec4 tmpvar_48;
        tmpvar_48 = texture2DLodEXT (_Transmittance, tmpvar_47.xy, 0.0);
        tmpvar_44 = tmpvar_48.xyz;
        extinction_16 = min ((tmpvar_39 / tmpvar_44), vec3(1.0, 1.0, 1.0));
      } else {
        highp vec3 tmpvar_49;
        highp float y_over_x_50;
        y_over_x_50 = (((-(tmpvar_38) + 0.15) / 1.15) * 14.1014);
        highp float x_51;
        x_51 = (y_over_x_50 * inversesqrt(((y_over_x_50 * y_over_x_50) + 1.0)));
        highp vec4 tmpvar_52;
        tmpvar_52.zw = vec2(0.0, 0.0);
        tmpvar_52.x = ((sign(x_51) * (1.5708 - (sqrt((1.0 - abs(x_51))) * (1.5708 + (abs(x_51) * (-0.214602 + (abs(x_51) * (0.0865667 + (abs(x_51) * -0.0310296))))))))) / 1.5);
        tmpvar_52.y = sqrt(((tmpvar_37 - Rg) / (Rt - Rg)));
        lowp vec4 tmpvar_53;
        tmpvar_53 = texture2DLodEXT (_Transmittance, tmpvar_52.xy, 0.0);
        tmpvar_49 = tmpvar_53.xyz;
        highp vec3 tmpvar_54;
        highp float y_over_x_55;
        y_over_x_55 = (((-(mu_17) + 0.15) / 1.15) * 14.1014);
        highp float x_56;
        x_56 = (y_over_x_55 * inversesqrt(((y_over_x_55 * y_over_x_55) + 1.0)));
        highp vec4 tmpvar_57;
        tmpvar_57.zw = vec2(0.0, 0.0);
        tmpvar_57.x = ((sign(x_56) * (1.5708 - (sqrt((1.0 - abs(x_56))) * (1.5708 + (abs(x_56) * (-0.214602 + (abs(x_56) * (0.0865667 + (abs(x_56) * -0.0310296))))))))) / 1.5);
        tmpvar_57.y = sqrt(((r_19 - Rg) / (Rt - Rg)));
        lowp vec4 tmpvar_58;
        tmpvar_58 = texture2DLodEXT (_Transmittance, tmpvar_57.xy, 0.0);
        tmpvar_54 = tmpvar_58.xyz;
        extinction_16 = min ((tmpvar_49 / tmpvar_54), vec3(1.0, 1.0, 1.0));
      };
      highp float tmpvar_59;
      tmpvar_59 = -(sqrt((1.0 - ((Rg / r_19) * (Rg / r_19)))));
      highp float tmpvar_60;
      tmpvar_60 = abs((mu_17 - tmpvar_59));
      if ((tmpvar_60 < 0.004)) {
        highp vec4 inScatterA_61;
        highp vec4 inScatter0_62;
        highp float a_63;
        a_63 = (((mu_17 - tmpvar_59) + 0.004) / 0.008);
        highp float tmpvar_64;
        tmpvar_64 = (tmpvar_59 - 0.004);
        mu_17 = tmpvar_64;
        highp float tmpvar_65;
        tmpvar_65 = sqrt((((r_19 * r_19) + (d_20 * d_20)) + (((2.0 * r_19) * d_20) * tmpvar_64)));
        r1_32 = tmpvar_65;
        mu1_31 = (((r_19 * tmpvar_64) + d_20) / tmpvar_65);
        highp float uMu_66;
        highp float uR_67;
        highp float tmpvar_68;
        tmpvar_68 = sqrt(((Rt * Rt) - (Rg * Rg)));
        highp float tmpvar_69;
        tmpvar_69 = sqrt(((r_19 * r_19) - (Rg * Rg)));
        highp float tmpvar_70;
        tmpvar_70 = (r_19 * tmpvar_64);
        highp float tmpvar_71;
        tmpvar_71 = (((tmpvar_70 * tmpvar_70) - (r_19 * r_19)) + (Rg * Rg));
        highp vec4 tmpvar_72;
        if (((tmpvar_70 < 0.0) && (tmpvar_71 > 0.0))) {
          highp vec4 tmpvar_73;
          tmpvar_73.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_73.w = (0.5 - (0.5 / RES_MU));
          tmpvar_72 = tmpvar_73;
        } else {
          highp vec4 tmpvar_74;
          tmpvar_74.x = -1.0;
          tmpvar_74.y = (tmpvar_68 * tmpvar_68);
          tmpvar_74.z = tmpvar_68;
          tmpvar_74.w = (0.5 + (0.5 / RES_MU));
          tmpvar_72 = tmpvar_74;
        };
        uR_67 = ((0.5 / RES_R) + ((tmpvar_69 / tmpvar_68) * (1.0 - (1.0/(RES_R)))));
        uMu_66 = (tmpvar_72.w + ((((tmpvar_70 * tmpvar_72.x) + sqrt((tmpvar_71 + tmpvar_72.y))) / (tmpvar_69 + tmpvar_72.z)) * (0.5 - (1.0/(RES_MU)))));
        highp float y_over_x_75;
        y_over_x_75 = (max (tmpvar_35, -0.1975) * 5.34962);
        highp float x_76;
        x_76 = (y_over_x_75 * inversesqrt(((y_over_x_75 * y_over_x_75) + 1.0)));
        highp float tmpvar_77;
        tmpvar_77 = ((0.5 / RES_MU_S) + (((((sign(x_76) * (1.5708 - (sqrt((1.0 - abs(x_76))) * (1.5708 + (abs(x_76) * (-0.214602 + (abs(x_76) * (0.0865667 + (abs(x_76) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        highp float tmpvar_78;
        tmpvar_78 = (((tmpvar_34 + 1.0) / 2.0) * (RES_NU - 1.0));
        highp float tmpvar_79;
        tmpvar_79 = floor(tmpvar_78);
        highp float tmpvar_80;
        tmpvar_80 = (tmpvar_78 - tmpvar_79);
        highp float tmpvar_81;
        tmpvar_81 = (floor(((uR_67 * RES_R) - 1.0)) / RES_R);
        highp float tmpvar_82;
        tmpvar_82 = (floor((uR_67 * RES_R)) / RES_R);
        highp float tmpvar_83;
        tmpvar_83 = fract((uR_67 * RES_R));
        highp vec4 tmpvar_84;
        tmpvar_84.zw = vec2(0.0, 0.0);
        tmpvar_84.x = ((tmpvar_79 + tmpvar_77) / RES_NU);
        tmpvar_84.y = ((uMu_66 / RES_R) + tmpvar_81);
        lowp vec4 tmpvar_85;
        tmpvar_85 = texture2DLodEXT (_Inscatter, tmpvar_84.xy, 0.0);
        highp vec4 tmpvar_86;
        tmpvar_86.zw = vec2(0.0, 0.0);
        tmpvar_86.x = (((tmpvar_79 + tmpvar_77) + 1.0) / RES_NU);
        tmpvar_86.y = ((uMu_66 / RES_R) + tmpvar_81);
        lowp vec4 tmpvar_87;
        tmpvar_87 = texture2DLodEXT (_Inscatter, tmpvar_86.xy, 0.0);
        highp vec4 tmpvar_88;
        tmpvar_88.zw = vec2(0.0, 0.0);
        tmpvar_88.x = ((tmpvar_79 + tmpvar_77) / RES_NU);
        tmpvar_88.y = ((uMu_66 / RES_R) + tmpvar_82);
        lowp vec4 tmpvar_89;
        tmpvar_89 = texture2DLodEXT (_Inscatter, tmpvar_88.xy, 0.0);
        highp vec4 tmpvar_90;
        tmpvar_90.zw = vec2(0.0, 0.0);
        tmpvar_90.x = (((tmpvar_79 + tmpvar_77) + 1.0) / RES_NU);
        tmpvar_90.y = ((uMu_66 / RES_R) + tmpvar_82);
        lowp vec4 tmpvar_91;
        tmpvar_91 = texture2DLodEXT (_Inscatter, tmpvar_90.xy, 0.0);
        inScatter0_62 = ((((tmpvar_85 * (1.0 - tmpvar_80)) + (tmpvar_87 * tmpvar_80)) * (1.0 - tmpvar_83)) + (((tmpvar_89 * (1.0 - tmpvar_80)) + (tmpvar_91 * tmpvar_80)) * tmpvar_83));
        highp float uMu_92;
        highp float uR_93;
        highp float tmpvar_94;
        tmpvar_94 = sqrt(((Rt * Rt) - (Rg * Rg)));
        highp float tmpvar_95;
        tmpvar_95 = sqrt(((tmpvar_65 * tmpvar_65) - (Rg * Rg)));
        highp float tmpvar_96;
        tmpvar_96 = (tmpvar_65 * mu1_31);
        highp float tmpvar_97;
        tmpvar_97 = (((tmpvar_96 * tmpvar_96) - (tmpvar_65 * tmpvar_65)) + (Rg * Rg));
        highp vec4 tmpvar_98;
        if (((tmpvar_96 < 0.0) && (tmpvar_97 > 0.0))) {
          highp vec4 tmpvar_99;
          tmpvar_99.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_99.w = (0.5 - (0.5 / RES_MU));
          tmpvar_98 = tmpvar_99;
        } else {
          highp vec4 tmpvar_100;
          tmpvar_100.x = -1.0;
          tmpvar_100.y = (tmpvar_94 * tmpvar_94);
          tmpvar_100.z = tmpvar_94;
          tmpvar_100.w = (0.5 + (0.5 / RES_MU));
          tmpvar_98 = tmpvar_100;
        };
        uR_93 = ((0.5 / RES_R) + ((tmpvar_95 / tmpvar_94) * (1.0 - (1.0/(RES_R)))));
        uMu_92 = (tmpvar_98.w + ((((tmpvar_96 * tmpvar_98.x) + sqrt((tmpvar_97 + tmpvar_98.y))) / (tmpvar_95 + tmpvar_98.z)) * (0.5 - (1.0/(RES_MU)))));
        highp float y_over_x_101;
        y_over_x_101 = (max (muS1_30, -0.1975) * 5.34962);
        highp float x_102;
        x_102 = (y_over_x_101 * inversesqrt(((y_over_x_101 * y_over_x_101) + 1.0)));
        highp float tmpvar_103;
        tmpvar_103 = ((0.5 / RES_MU_S) + (((((sign(x_102) * (1.5708 - (sqrt((1.0 - abs(x_102))) * (1.5708 + (abs(x_102) * (-0.214602 + (abs(x_102) * (0.0865667 + (abs(x_102) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        highp float tmpvar_104;
        tmpvar_104 = (((tmpvar_34 + 1.0) / 2.0) * (RES_NU - 1.0));
        highp float tmpvar_105;
        tmpvar_105 = floor(tmpvar_104);
        highp float tmpvar_106;
        tmpvar_106 = (tmpvar_104 - tmpvar_105);
        highp float tmpvar_107;
        tmpvar_107 = (floor(((uR_93 * RES_R) - 1.0)) / RES_R);
        highp float tmpvar_108;
        tmpvar_108 = (floor((uR_93 * RES_R)) / RES_R);
        highp float tmpvar_109;
        tmpvar_109 = fract((uR_93 * RES_R));
        highp vec4 tmpvar_110;
        tmpvar_110.zw = vec2(0.0, 0.0);
        tmpvar_110.x = ((tmpvar_105 + tmpvar_103) / RES_NU);
        tmpvar_110.y = ((uMu_92 / RES_R) + tmpvar_107);
        lowp vec4 tmpvar_111;
        tmpvar_111 = texture2DLodEXT (_Inscatter, tmpvar_110.xy, 0.0);
        highp vec4 tmpvar_112;
        tmpvar_112.zw = vec2(0.0, 0.0);
        tmpvar_112.x = (((tmpvar_105 + tmpvar_103) + 1.0) / RES_NU);
        tmpvar_112.y = ((uMu_92 / RES_R) + tmpvar_107);
        lowp vec4 tmpvar_113;
        tmpvar_113 = texture2DLodEXT (_Inscatter, tmpvar_112.xy, 0.0);
        highp vec4 tmpvar_114;
        tmpvar_114.zw = vec2(0.0, 0.0);
        tmpvar_114.x = ((tmpvar_105 + tmpvar_103) / RES_NU);
        tmpvar_114.y = ((uMu_92 / RES_R) + tmpvar_108);
        lowp vec4 tmpvar_115;
        tmpvar_115 = texture2DLodEXT (_Inscatter, tmpvar_114.xy, 0.0);
        highp vec4 tmpvar_116;
        tmpvar_116.zw = vec2(0.0, 0.0);
        tmpvar_116.x = (((tmpvar_105 + tmpvar_103) + 1.0) / RES_NU);
        tmpvar_116.y = ((uMu_92 / RES_R) + tmpvar_108);
        lowp vec4 tmpvar_117;
        tmpvar_117 = texture2DLodEXT (_Inscatter, tmpvar_116.xy, 0.0);
        inScatterA_61 = max ((inScatter0_62 - (((((tmpvar_111 * (1.0 - tmpvar_106)) + (tmpvar_113 * tmpvar_106)) * (1.0 - tmpvar_109)) + (((tmpvar_115 * (1.0 - tmpvar_106)) + (tmpvar_117 * tmpvar_106)) * tmpvar_109)) * extinction_16.xyzx)), vec4(0.0, 0.0, 0.0, 0.0));
        highp float tmpvar_118;
        tmpvar_118 = (tmpvar_59 + 0.004);
        mu_17 = tmpvar_118;
        highp float tmpvar_119;
        tmpvar_119 = sqrt((((r_19 * r_19) + (d_20 * d_20)) + (((2.0 * r_19) * d_20) * tmpvar_118)));
        r1_32 = tmpvar_119;
        mu1_31 = (((r_19 * tmpvar_118) + d_20) / tmpvar_119);
        highp float uMu_120;
        highp float uR_121;
        highp float tmpvar_122;
        tmpvar_122 = sqrt(((Rt * Rt) - (Rg * Rg)));
        highp float tmpvar_123;
        tmpvar_123 = sqrt(((r_19 * r_19) - (Rg * Rg)));
        highp float tmpvar_124;
        tmpvar_124 = (r_19 * tmpvar_118);
        highp float tmpvar_125;
        tmpvar_125 = (((tmpvar_124 * tmpvar_124) - (r_19 * r_19)) + (Rg * Rg));
        highp vec4 tmpvar_126;
        if (((tmpvar_124 < 0.0) && (tmpvar_125 > 0.0))) {
          highp vec4 tmpvar_127;
          tmpvar_127.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_127.w = (0.5 - (0.5 / RES_MU));
          tmpvar_126 = tmpvar_127;
        } else {
          highp vec4 tmpvar_128;
          tmpvar_128.x = -1.0;
          tmpvar_128.y = (tmpvar_122 * tmpvar_122);
          tmpvar_128.z = tmpvar_122;
          tmpvar_128.w = (0.5 + (0.5 / RES_MU));
          tmpvar_126 = tmpvar_128;
        };
        uR_121 = ((0.5 / RES_R) + ((tmpvar_123 / tmpvar_122) * (1.0 - (1.0/(RES_R)))));
        uMu_120 = (tmpvar_126.w + ((((tmpvar_124 * tmpvar_126.x) + sqrt((tmpvar_125 + tmpvar_126.y))) / (tmpvar_123 + tmpvar_126.z)) * (0.5 - (1.0/(RES_MU)))));
        highp float y_over_x_129;
        y_over_x_129 = (max (tmpvar_35, -0.1975) * 5.34962);
        highp float x_130;
        x_130 = (y_over_x_129 * inversesqrt(((y_over_x_129 * y_over_x_129) + 1.0)));
        highp float tmpvar_131;
        tmpvar_131 = ((0.5 / RES_MU_S) + (((((sign(x_130) * (1.5708 - (sqrt((1.0 - abs(x_130))) * (1.5708 + (abs(x_130) * (-0.214602 + (abs(x_130) * (0.0865667 + (abs(x_130) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        highp float tmpvar_132;
        tmpvar_132 = (((tmpvar_34 + 1.0) / 2.0) * (RES_NU - 1.0));
        highp float tmpvar_133;
        tmpvar_133 = floor(tmpvar_132);
        highp float tmpvar_134;
        tmpvar_134 = (tmpvar_132 - tmpvar_133);
        highp float tmpvar_135;
        tmpvar_135 = (floor(((uR_121 * RES_R) - 1.0)) / RES_R);
        highp float tmpvar_136;
        tmpvar_136 = (floor((uR_121 * RES_R)) / RES_R);
        highp float tmpvar_137;
        tmpvar_137 = fract((uR_121 * RES_R));
        highp vec4 tmpvar_138;
        tmpvar_138.zw = vec2(0.0, 0.0);
        tmpvar_138.x = ((tmpvar_133 + tmpvar_131) / RES_NU);
        tmpvar_138.y = ((uMu_120 / RES_R) + tmpvar_135);
        lowp vec4 tmpvar_139;
        tmpvar_139 = texture2DLodEXT (_Inscatter, tmpvar_138.xy, 0.0);
        highp vec4 tmpvar_140;
        tmpvar_140.zw = vec2(0.0, 0.0);
        tmpvar_140.x = (((tmpvar_133 + tmpvar_131) + 1.0) / RES_NU);
        tmpvar_140.y = ((uMu_120 / RES_R) + tmpvar_135);
        lowp vec4 tmpvar_141;
        tmpvar_141 = texture2DLodEXT (_Inscatter, tmpvar_140.xy, 0.0);
        highp vec4 tmpvar_142;
        tmpvar_142.zw = vec2(0.0, 0.0);
        tmpvar_142.x = ((tmpvar_133 + tmpvar_131) / RES_NU);
        tmpvar_142.y = ((uMu_120 / RES_R) + tmpvar_136);
        lowp vec4 tmpvar_143;
        tmpvar_143 = texture2DLodEXT (_Inscatter, tmpvar_142.xy, 0.0);
        highp vec4 tmpvar_144;
        tmpvar_144.zw = vec2(0.0, 0.0);
        tmpvar_144.x = (((tmpvar_133 + tmpvar_131) + 1.0) / RES_NU);
        tmpvar_144.y = ((uMu_120 / RES_R) + tmpvar_136);
        lowp vec4 tmpvar_145;
        tmpvar_145 = texture2DLodEXT (_Inscatter, tmpvar_144.xy, 0.0);
        inScatter0_62 = ((((tmpvar_139 * (1.0 - tmpvar_134)) + (tmpvar_141 * tmpvar_134)) * (1.0 - tmpvar_137)) + (((tmpvar_143 * (1.0 - tmpvar_134)) + (tmpvar_145 * tmpvar_134)) * tmpvar_137));
        highp float uMu_146;
        highp float uR_147;
        highp float tmpvar_148;
        tmpvar_148 = sqrt(((Rt * Rt) - (Rg * Rg)));
        highp float tmpvar_149;
        tmpvar_149 = sqrt(((tmpvar_119 * tmpvar_119) - (Rg * Rg)));
        highp float tmpvar_150;
        tmpvar_150 = (tmpvar_119 * mu1_31);
        highp float tmpvar_151;
        tmpvar_151 = (((tmpvar_150 * tmpvar_150) - (tmpvar_119 * tmpvar_119)) + (Rg * Rg));
        highp vec4 tmpvar_152;
        if (((tmpvar_150 < 0.0) && (tmpvar_151 > 0.0))) {
          highp vec4 tmpvar_153;
          tmpvar_153.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_153.w = (0.5 - (0.5 / RES_MU));
          tmpvar_152 = tmpvar_153;
        } else {
          highp vec4 tmpvar_154;
          tmpvar_154.x = -1.0;
          tmpvar_154.y = (tmpvar_148 * tmpvar_148);
          tmpvar_154.z = tmpvar_148;
          tmpvar_154.w = (0.5 + (0.5 / RES_MU));
          tmpvar_152 = tmpvar_154;
        };
        uR_147 = ((0.5 / RES_R) + ((tmpvar_149 / tmpvar_148) * (1.0 - (1.0/(RES_R)))));
        uMu_146 = (tmpvar_152.w + ((((tmpvar_150 * tmpvar_152.x) + sqrt((tmpvar_151 + tmpvar_152.y))) / (tmpvar_149 + tmpvar_152.z)) * (0.5 - (1.0/(RES_MU)))));
        highp float y_over_x_155;
        y_over_x_155 = (max (muS1_30, -0.1975) * 5.34962);
        highp float x_156;
        x_156 = (y_over_x_155 * inversesqrt(((y_over_x_155 * y_over_x_155) + 1.0)));
        highp float tmpvar_157;
        tmpvar_157 = ((0.5 / RES_MU_S) + (((((sign(x_156) * (1.5708 - (sqrt((1.0 - abs(x_156))) * (1.5708 + (abs(x_156) * (-0.214602 + (abs(x_156) * (0.0865667 + (abs(x_156) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        highp float tmpvar_158;
        tmpvar_158 = (((tmpvar_34 + 1.0) / 2.0) * (RES_NU - 1.0));
        highp float tmpvar_159;
        tmpvar_159 = floor(tmpvar_158);
        highp float tmpvar_160;
        tmpvar_160 = (tmpvar_158 - tmpvar_159);
        highp float tmpvar_161;
        tmpvar_161 = (floor(((uR_147 * RES_R) - 1.0)) / RES_R);
        highp float tmpvar_162;
        tmpvar_162 = (floor((uR_147 * RES_R)) / RES_R);
        highp float tmpvar_163;
        tmpvar_163 = fract((uR_147 * RES_R));
        highp vec4 tmpvar_164;
        tmpvar_164.zw = vec2(0.0, 0.0);
        tmpvar_164.x = ((tmpvar_159 + tmpvar_157) / RES_NU);
        tmpvar_164.y = ((uMu_146 / RES_R) + tmpvar_161);
        lowp vec4 tmpvar_165;
        tmpvar_165 = texture2DLodEXT (_Inscatter, tmpvar_164.xy, 0.0);
        highp vec4 tmpvar_166;
        tmpvar_166.zw = vec2(0.0, 0.0);
        tmpvar_166.x = (((tmpvar_159 + tmpvar_157) + 1.0) / RES_NU);
        tmpvar_166.y = ((uMu_146 / RES_R) + tmpvar_161);
        lowp vec4 tmpvar_167;
        tmpvar_167 = texture2DLodEXT (_Inscatter, tmpvar_166.xy, 0.0);
        highp vec4 tmpvar_168;
        tmpvar_168.zw = vec2(0.0, 0.0);
        tmpvar_168.x = ((tmpvar_159 + tmpvar_157) / RES_NU);
        tmpvar_168.y = ((uMu_146 / RES_R) + tmpvar_162);
        lowp vec4 tmpvar_169;
        tmpvar_169 = texture2DLodEXT (_Inscatter, tmpvar_168.xy, 0.0);
        highp vec4 tmpvar_170;
        tmpvar_170.zw = vec2(0.0, 0.0);
        tmpvar_170.x = (((tmpvar_159 + tmpvar_157) + 1.0) / RES_NU);
        tmpvar_170.y = ((uMu_146 / RES_R) + tmpvar_162);
        lowp vec4 tmpvar_171;
        tmpvar_171 = texture2DLodEXT (_Inscatter, tmpvar_170.xy, 0.0);
        inScatter_33 = mix (inScatterA_61, max ((inScatter0_62 - (((((tmpvar_165 * (1.0 - tmpvar_160)) + (tmpvar_167 * tmpvar_160)) * (1.0 - tmpvar_163)) + (((tmpvar_169 * (1.0 - tmpvar_160)) + (tmpvar_171 * tmpvar_160)) * tmpvar_163)) * extinction_16.xyzx)), vec4(0.0, 0.0, 0.0, 0.0)), vec4(a_63));
      } else {
        highp vec4 inScatter0_1_172;
        highp float uMu_173;
        highp float uR_174;
        highp float tmpvar_175;
        tmpvar_175 = sqrt(((Rt * Rt) - (Rg * Rg)));
        highp float tmpvar_176;
        tmpvar_176 = sqrt(((r_19 * r_19) - (Rg * Rg)));
        highp float tmpvar_177;
        tmpvar_177 = (r_19 * mu_17);
        highp float tmpvar_178;
        tmpvar_178 = (((tmpvar_177 * tmpvar_177) - (r_19 * r_19)) + (Rg * Rg));
        highp vec4 tmpvar_179;
        if (((tmpvar_177 < 0.0) && (tmpvar_178 > 0.0))) {
          highp vec4 tmpvar_180;
          tmpvar_180.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_180.w = (0.5 - (0.5 / RES_MU));
          tmpvar_179 = tmpvar_180;
        } else {
          highp vec4 tmpvar_181;
          tmpvar_181.x = -1.0;
          tmpvar_181.y = (tmpvar_175 * tmpvar_175);
          tmpvar_181.z = tmpvar_175;
          tmpvar_181.w = (0.5 + (0.5 / RES_MU));
          tmpvar_179 = tmpvar_181;
        };
        uR_174 = ((0.5 / RES_R) + ((tmpvar_176 / tmpvar_175) * (1.0 - (1.0/(RES_R)))));
        uMu_173 = (tmpvar_179.w + ((((tmpvar_177 * tmpvar_179.x) + sqrt((tmpvar_178 + tmpvar_179.y))) / (tmpvar_176 + tmpvar_179.z)) * (0.5 - (1.0/(RES_MU)))));
        highp float y_over_x_182;
        y_over_x_182 = (max (tmpvar_35, -0.1975) * 5.34962);
        highp float x_183;
        x_183 = (y_over_x_182 * inversesqrt(((y_over_x_182 * y_over_x_182) + 1.0)));
        highp float tmpvar_184;
        tmpvar_184 = ((0.5 / RES_MU_S) + (((((sign(x_183) * (1.5708 - (sqrt((1.0 - abs(x_183))) * (1.5708 + (abs(x_183) * (-0.214602 + (abs(x_183) * (0.0865667 + (abs(x_183) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        highp float tmpvar_185;
        tmpvar_185 = (((tmpvar_34 + 1.0) / 2.0) * (RES_NU - 1.0));
        highp float tmpvar_186;
        tmpvar_186 = floor(tmpvar_185);
        highp float tmpvar_187;
        tmpvar_187 = (tmpvar_185 - tmpvar_186);
        highp float tmpvar_188;
        tmpvar_188 = (floor(((uR_174 * RES_R) - 1.0)) / RES_R);
        highp float tmpvar_189;
        tmpvar_189 = (floor((uR_174 * RES_R)) / RES_R);
        highp float tmpvar_190;
        tmpvar_190 = fract((uR_174 * RES_R));
        highp vec4 tmpvar_191;
        tmpvar_191.zw = vec2(0.0, 0.0);
        tmpvar_191.x = ((tmpvar_186 + tmpvar_184) / RES_NU);
        tmpvar_191.y = ((uMu_173 / RES_R) + tmpvar_188);
        lowp vec4 tmpvar_192;
        tmpvar_192 = texture2DLodEXT (_Inscatter, tmpvar_191.xy, 0.0);
        highp vec4 tmpvar_193;
        tmpvar_193.zw = vec2(0.0, 0.0);
        tmpvar_193.x = (((tmpvar_186 + tmpvar_184) + 1.0) / RES_NU);
        tmpvar_193.y = ((uMu_173 / RES_R) + tmpvar_188);
        lowp vec4 tmpvar_194;
        tmpvar_194 = texture2DLodEXT (_Inscatter, tmpvar_193.xy, 0.0);
        highp vec4 tmpvar_195;
        tmpvar_195.zw = vec2(0.0, 0.0);
        tmpvar_195.x = ((tmpvar_186 + tmpvar_184) / RES_NU);
        tmpvar_195.y = ((uMu_173 / RES_R) + tmpvar_189);
        lowp vec4 tmpvar_196;
        tmpvar_196 = texture2DLodEXT (_Inscatter, tmpvar_195.xy, 0.0);
        highp vec4 tmpvar_197;
        tmpvar_197.zw = vec2(0.0, 0.0);
        tmpvar_197.x = (((tmpvar_186 + tmpvar_184) + 1.0) / RES_NU);
        tmpvar_197.y = ((uMu_173 / RES_R) + tmpvar_189);
        lowp vec4 tmpvar_198;
        tmpvar_198 = texture2DLodEXT (_Inscatter, tmpvar_197.xy, 0.0);
        inScatter0_1_172 = ((((tmpvar_192 * (1.0 - tmpvar_187)) + (tmpvar_194 * tmpvar_187)) * (1.0 - tmpvar_190)) + (((tmpvar_196 * (1.0 - tmpvar_187)) + (tmpvar_198 * tmpvar_187)) * tmpvar_190));
        highp float uMu_199;
        highp float uR_200;
        highp float tmpvar_201;
        tmpvar_201 = sqrt(((Rt * Rt) - (Rg * Rg)));
        highp float tmpvar_202;
        tmpvar_202 = sqrt(((r1_32 * r1_32) - (Rg * Rg)));
        highp float tmpvar_203;
        tmpvar_203 = (r1_32 * mu1_31);
        highp float tmpvar_204;
        tmpvar_204 = (((tmpvar_203 * tmpvar_203) - (r1_32 * r1_32)) + (Rg * Rg));
        highp vec4 tmpvar_205;
        if (((tmpvar_203 < 0.0) && (tmpvar_204 > 0.0))) {
          highp vec4 tmpvar_206;
          tmpvar_206.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_206.w = (0.5 - (0.5 / RES_MU));
          tmpvar_205 = tmpvar_206;
        } else {
          highp vec4 tmpvar_207;
          tmpvar_207.x = -1.0;
          tmpvar_207.y = (tmpvar_201 * tmpvar_201);
          tmpvar_207.z = tmpvar_201;
          tmpvar_207.w = (0.5 + (0.5 / RES_MU));
          tmpvar_205 = tmpvar_207;
        };
        uR_200 = ((0.5 / RES_R) + ((tmpvar_202 / tmpvar_201) * (1.0 - (1.0/(RES_R)))));
        uMu_199 = (tmpvar_205.w + ((((tmpvar_203 * tmpvar_205.x) + sqrt((tmpvar_204 + tmpvar_205.y))) / (tmpvar_202 + tmpvar_205.z)) * (0.5 - (1.0/(RES_MU)))));
        highp float y_over_x_208;
        y_over_x_208 = (max (muS1_30, -0.1975) * 5.34962);
        highp float x_209;
        x_209 = (y_over_x_208 * inversesqrt(((y_over_x_208 * y_over_x_208) + 1.0)));
        highp float tmpvar_210;
        tmpvar_210 = ((0.5 / RES_MU_S) + (((((sign(x_209) * (1.5708 - (sqrt((1.0 - abs(x_209))) * (1.5708 + (abs(x_209) * (-0.214602 + (abs(x_209) * (0.0865667 + (abs(x_209) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        highp float tmpvar_211;
        tmpvar_211 = (((tmpvar_34 + 1.0) / 2.0) * (RES_NU - 1.0));
        highp float tmpvar_212;
        tmpvar_212 = floor(tmpvar_211);
        highp float tmpvar_213;
        tmpvar_213 = (tmpvar_211 - tmpvar_212);
        highp float tmpvar_214;
        tmpvar_214 = (floor(((uR_200 * RES_R) - 1.0)) / RES_R);
        highp float tmpvar_215;
        tmpvar_215 = (floor((uR_200 * RES_R)) / RES_R);
        highp float tmpvar_216;
        tmpvar_216 = fract((uR_200 * RES_R));
        highp vec4 tmpvar_217;
        tmpvar_217.zw = vec2(0.0, 0.0);
        tmpvar_217.x = ((tmpvar_212 + tmpvar_210) / RES_NU);
        tmpvar_217.y = ((uMu_199 / RES_R) + tmpvar_214);
        lowp vec4 tmpvar_218;
        tmpvar_218 = texture2DLodEXT (_Inscatter, tmpvar_217.xy, 0.0);
        highp vec4 tmpvar_219;
        tmpvar_219.zw = vec2(0.0, 0.0);
        tmpvar_219.x = (((tmpvar_212 + tmpvar_210) + 1.0) / RES_NU);
        tmpvar_219.y = ((uMu_199 / RES_R) + tmpvar_214);
        lowp vec4 tmpvar_220;
        tmpvar_220 = texture2DLodEXT (_Inscatter, tmpvar_219.xy, 0.0);
        highp vec4 tmpvar_221;
        tmpvar_221.zw = vec2(0.0, 0.0);
        tmpvar_221.x = ((tmpvar_212 + tmpvar_210) / RES_NU);
        tmpvar_221.y = ((uMu_199 / RES_R) + tmpvar_215);
        lowp vec4 tmpvar_222;
        tmpvar_222 = texture2DLodEXT (_Inscatter, tmpvar_221.xy, 0.0);
        highp vec4 tmpvar_223;
        tmpvar_223.zw = vec2(0.0, 0.0);
        tmpvar_223.x = (((tmpvar_212 + tmpvar_210) + 1.0) / RES_NU);
        tmpvar_223.y = ((uMu_199 / RES_R) + tmpvar_215);
        lowp vec4 tmpvar_224;
        tmpvar_224 = texture2DLodEXT (_Inscatter, tmpvar_223.xy, 0.0);
        inScatter_33 = max ((inScatter0_1_172 - (((((tmpvar_218 * (1.0 - tmpvar_213)) + (tmpvar_220 * tmpvar_213)) * (1.0 - tmpvar_216)) + (((tmpvar_222 * (1.0 - tmpvar_213)) + (tmpvar_224 * tmpvar_213)) * tmpvar_216)) * extinction_16.xyzx)), vec4(0.0, 0.0, 0.0, 0.0));
      };
      highp float t_225;
      t_225 = max (min ((tmpvar_35 / 0.02), 1.0), 0.0);
      inScatter_33.w = (inScatter_33.w * (t_225 * (t_225 * (3.0 - (2.0 * t_225)))));
      result_21 = ((inScatter_33.xyz * ((3.0 / (16.0 * M_PI)) * (1.0 + (tmpvar_34 * tmpvar_34)))) + ((((inScatter_33.xyz * inScatter_33.w) / max (inScatter_33.x, 0.0001)) * (betaR.x / betaR)) * (((((1.5 / (4.0 * M_PI)) * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_34)), -1.5)) * (1.0 + (tmpvar_34 * tmpvar_34))) / (2.0 + (mieG * mieG)))));
    };
    tmpvar_13 = (result_21 * SUN_INTENSITY);
    visib_2 = 1.0;
    if ((tmpvar_7 <= _global_depth)) {
      visib_2 = (1.0 - exp((-1.0 * ((4.0 * tmpvar_7) / _global_depth))));
    };
    highp vec3 L_226;
    highp vec3 tmpvar_227;
    tmpvar_227 = (tmpvar_13 * _Exposure);
    L_226 = tmpvar_227;
    highp float tmpvar_228;
    if ((tmpvar_227.x < 1.413)) {
      tmpvar_228 = pow ((tmpvar_227.x * 0.38317), 0.454545);
    } else {
      tmpvar_228 = (1.0 - exp(-(tmpvar_227.x)));
    };
    L_226.x = tmpvar_228;
    highp float tmpvar_229;
    if ((tmpvar_227.y < 1.413)) {
      tmpvar_229 = pow ((tmpvar_227.y * 0.38317), 0.454545);
    } else {
      tmpvar_229 = (1.0 - exp(-(tmpvar_227.y)));
    };
    L_226.y = tmpvar_229;
    highp float tmpvar_230;
    if ((tmpvar_227.z < 1.413)) {
      tmpvar_230 = pow ((tmpvar_227.z * 0.38317), 0.454545);
    } else {
      tmpvar_230 = (1.0 - exp(-(tmpvar_227.z)));
    };
    L_226.z = tmpvar_230;
    highp vec4 tmpvar_231;
    tmpvar_231.xyz = L_226;
    tmpvar_231.w = (_global_alpha * visib_2);
    tmpvar_1 = tmpvar_231;
  };
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  highp vec2 tmpvar_6;
  tmpvar_6 = (o_3.xy / tmpvar_2.w);
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
uniform highp vec4 _ZBufferParams;
uniform sampler2D _Transmittance;
uniform sampler2D _Inscatter;
uniform highp float M_PI;
uniform highp float Rg;
uniform highp float Rt;
uniform highp float RES_R;
uniform highp float RES_MU;
uniform highp float RES_MU_S;
uniform highp float RES_NU;
uniform highp vec3 SUN_DIR;
uniform highp float SUN_INTENSITY;
uniform highp vec3 betaR;
uniform highp float mieG;
uniform highp mat4 _ViewProjInv;
uniform highp float _Scale;
uniform highp float _global_alpha;
uniform highp float _Exposure;
uniform highp float _global_depth;
uniform highp float _global_depth2;
uniform highp vec3 _inCamPos;
uniform highp vec3 _Globals_Origin;
uniform sampler2D _CameraDepthTexture;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp float visib_2;
  highp vec3 worldPos_3;
  highp float depth_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CameraDepthTexture, xlv_TEXCOORD2);
  highp float z_6;
  z_6 = tmpvar_5.x;
  highp float tmpvar_7;
  tmpvar_7 = (_global_depth2 * (1.0/(((_ZBufferParams.x * z_6) + _ZBufferParams.y))));
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_CameraDepthTexture, xlv_TEXCOORD2).x;
  depth_4 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.x = ((xlv_TEXCOORD2.x * 2.0) - 1.0);
  tmpvar_9.y = ((xlv_TEXCOORD2.y * 2.0) - 1.0);
  tmpvar_9.z = depth_4;
  highp vec4 tmpvar_10;
  tmpvar_10 = (_ViewProjInv * tmpvar_9);
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 / tmpvar_10.w).xyz;
  worldPos_3 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
  if ((tmpvar_12 < (Rg + 250.0))) {
    worldPos_3 = ((Rg + 250.0) * normalize(tmpvar_11));
  };
  if ((tmpvar_7 >= 1.0)) {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    highp vec3 tmpvar_13;
    highp vec3 camera_14;
    camera_14 = ((_inCamPos - _Globals_Origin) * _Scale);
    highp vec3 _point_15;
    _point_15 = (worldPos_3 * _Scale);
    highp vec3 extinction_16;
    highp float mu_17;
    highp float rMu_18;
    highp float r_19;
    highp float d_20;
    highp vec3 result_21;
    result_21 = vec3(0.0, 0.0, 0.0);
    extinction_16 = vec3(1.0, 1.0, 1.0);
    highp vec3 tmpvar_22;
    tmpvar_22 = (_point_15 - camera_14);
    highp float tmpvar_23;
    tmpvar_23 = sqrt(dot (tmpvar_22, tmpvar_22));
    highp vec3 tmpvar_24;
    tmpvar_24 = (tmpvar_22 / tmpvar_23);
    d_20 = tmpvar_23;
    highp float tmpvar_25;
    tmpvar_25 = sqrt(dot (camera_14, camera_14));
    r_19 = tmpvar_25;
    if ((tmpvar_25 < (0.9 * Rg))) {
      camera_14.y = (camera_14.y + Rg);
      _point_15.y = (_point_15.y + Rg);
      r_19 = sqrt(dot (camera_14, camera_14));
    };
    highp float tmpvar_26;
    tmpvar_26 = dot (camera_14, tmpvar_24);
    rMu_18 = tmpvar_26;
    mu_17 = (tmpvar_26 / r_19);
    highp vec3 tmpvar_27;
    tmpvar_27 = (_point_15 - (tmpvar_24 * clamp (1.0, 0.0, tmpvar_23)));
    _point_15 = tmpvar_27;
    highp float tmpvar_28;
    tmpvar_28 = max ((-(tmpvar_26) - sqrt((((tmpvar_26 * tmpvar_26) - (r_19 * r_19)) + (Rt * Rt)))), 0.0);
    if (((tmpvar_28 > 0.0) && (tmpvar_28 < tmpvar_23))) {
      camera_14 = (camera_14 + (tmpvar_28 * tmpvar_24));
      highp float tmpvar_29;
      tmpvar_29 = (tmpvar_26 + tmpvar_28);
      rMu_18 = tmpvar_29;
      mu_17 = (tmpvar_29 / Rt);
      r_19 = Rt;
      d_20 = (tmpvar_23 - tmpvar_28);
    };
    if ((r_19 <= Rt)) {
      highp float muS1_30;
      highp float mu1_31;
      highp float r1_32;
      highp vec4 inScatter_33;
      highp float tmpvar_34;
      tmpvar_34 = dot (tmpvar_24, SUN_DIR);
      highp float tmpvar_35;
      tmpvar_35 = (dot (camera_14, SUN_DIR) / r_19);
      if ((r_19 < (Rg + 600.0))) {
        highp float tmpvar_36;
        tmpvar_36 = ((Rg + 600.0) / r_19);
        r_19 = (r_19 * tmpvar_36);
        rMu_18 = (rMu_18 * tmpvar_36);
        _point_15 = (tmpvar_27 * tmpvar_36);
      };
      highp float tmpvar_37;
      tmpvar_37 = sqrt(dot (_point_15, _point_15));
      r1_32 = tmpvar_37;
      highp float tmpvar_38;
      tmpvar_38 = (dot (_point_15, tmpvar_24) / tmpvar_37);
      mu1_31 = tmpvar_38;
      muS1_30 = (dot (_point_15, SUN_DIR) / tmpvar_37);
      if ((mu_17 > 0.0)) {
        highp vec3 tmpvar_39;
        highp float y_over_x_40;
        y_over_x_40 = (((mu_17 + 0.15) / 1.15) * 14.1014);
        highp float x_41;
        x_41 = (y_over_x_40 * inversesqrt(((y_over_x_40 * y_over_x_40) + 1.0)));
        highp vec4 tmpvar_42;
        tmpvar_42.zw = vec2(0.0, 0.0);
        tmpvar_42.x = ((sign(x_41) * (1.5708 - (sqrt((1.0 - abs(x_41))) * (1.5708 + (abs(x_41) * (-0.214602 + (abs(x_41) * (0.0865667 + (abs(x_41) * -0.0310296))))))))) / 1.5);
        tmpvar_42.y = sqrt(((r_19 - Rg) / (Rt - Rg)));
        lowp vec4 tmpvar_43;
        tmpvar_43 = texture2DLodEXT (_Transmittance, tmpvar_42.xy, 0.0);
        tmpvar_39 = tmpvar_43.xyz;
        highp vec3 tmpvar_44;
        highp float y_over_x_45;
        y_over_x_45 = (((tmpvar_38 + 0.15) / 1.15) * 14.1014);
        highp float x_46;
        x_46 = (y_over_x_45 * inversesqrt(((y_over_x_45 * y_over_x_45) + 1.0)));
        highp vec4 tmpvar_47;
        tmpvar_47.zw = vec2(0.0, 0.0);
        tmpvar_47.x = ((sign(x_46) * (1.5708 - (sqrt((1.0 - abs(x_46))) * (1.5708 + (abs(x_46) * (-0.214602 + (abs(x_46) * (0.0865667 + (abs(x_46) * -0.0310296))))))))) / 1.5);
        tmpvar_47.y = sqrt(((tmpvar_37 - Rg) / (Rt - Rg)));
        lowp vec4 tmpvar_48;
        tmpvar_48 = texture2DLodEXT (_Transmittance, tmpvar_47.xy, 0.0);
        tmpvar_44 = tmpvar_48.xyz;
        extinction_16 = min ((tmpvar_39 / tmpvar_44), vec3(1.0, 1.0, 1.0));
      } else {
        highp vec3 tmpvar_49;
        highp float y_over_x_50;
        y_over_x_50 = (((-(tmpvar_38) + 0.15) / 1.15) * 14.1014);
        highp float x_51;
        x_51 = (y_over_x_50 * inversesqrt(((y_over_x_50 * y_over_x_50) + 1.0)));
        highp vec4 tmpvar_52;
        tmpvar_52.zw = vec2(0.0, 0.0);
        tmpvar_52.x = ((sign(x_51) * (1.5708 - (sqrt((1.0 - abs(x_51))) * (1.5708 + (abs(x_51) * (-0.214602 + (abs(x_51) * (0.0865667 + (abs(x_51) * -0.0310296))))))))) / 1.5);
        tmpvar_52.y = sqrt(((tmpvar_37 - Rg) / (Rt - Rg)));
        lowp vec4 tmpvar_53;
        tmpvar_53 = texture2DLodEXT (_Transmittance, tmpvar_52.xy, 0.0);
        tmpvar_49 = tmpvar_53.xyz;
        highp vec3 tmpvar_54;
        highp float y_over_x_55;
        y_over_x_55 = (((-(mu_17) + 0.15) / 1.15) * 14.1014);
        highp float x_56;
        x_56 = (y_over_x_55 * inversesqrt(((y_over_x_55 * y_over_x_55) + 1.0)));
        highp vec4 tmpvar_57;
        tmpvar_57.zw = vec2(0.0, 0.0);
        tmpvar_57.x = ((sign(x_56) * (1.5708 - (sqrt((1.0 - abs(x_56))) * (1.5708 + (abs(x_56) * (-0.214602 + (abs(x_56) * (0.0865667 + (abs(x_56) * -0.0310296))))))))) / 1.5);
        tmpvar_57.y = sqrt(((r_19 - Rg) / (Rt - Rg)));
        lowp vec4 tmpvar_58;
        tmpvar_58 = texture2DLodEXT (_Transmittance, tmpvar_57.xy, 0.0);
        tmpvar_54 = tmpvar_58.xyz;
        extinction_16 = min ((tmpvar_49 / tmpvar_54), vec3(1.0, 1.0, 1.0));
      };
      highp float tmpvar_59;
      tmpvar_59 = -(sqrt((1.0 - ((Rg / r_19) * (Rg / r_19)))));
      highp float tmpvar_60;
      tmpvar_60 = abs((mu_17 - tmpvar_59));
      if ((tmpvar_60 < 0.004)) {
        highp vec4 inScatterA_61;
        highp vec4 inScatter0_62;
        highp float a_63;
        a_63 = (((mu_17 - tmpvar_59) + 0.004) / 0.008);
        highp float tmpvar_64;
        tmpvar_64 = (tmpvar_59 - 0.004);
        mu_17 = tmpvar_64;
        highp float tmpvar_65;
        tmpvar_65 = sqrt((((r_19 * r_19) + (d_20 * d_20)) + (((2.0 * r_19) * d_20) * tmpvar_64)));
        r1_32 = tmpvar_65;
        mu1_31 = (((r_19 * tmpvar_64) + d_20) / tmpvar_65);
        highp float uMu_66;
        highp float uR_67;
        highp float tmpvar_68;
        tmpvar_68 = sqrt(((Rt * Rt) - (Rg * Rg)));
        highp float tmpvar_69;
        tmpvar_69 = sqrt(((r_19 * r_19) - (Rg * Rg)));
        highp float tmpvar_70;
        tmpvar_70 = (r_19 * tmpvar_64);
        highp float tmpvar_71;
        tmpvar_71 = (((tmpvar_70 * tmpvar_70) - (r_19 * r_19)) + (Rg * Rg));
        highp vec4 tmpvar_72;
        if (((tmpvar_70 < 0.0) && (tmpvar_71 > 0.0))) {
          highp vec4 tmpvar_73;
          tmpvar_73.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_73.w = (0.5 - (0.5 / RES_MU));
          tmpvar_72 = tmpvar_73;
        } else {
          highp vec4 tmpvar_74;
          tmpvar_74.x = -1.0;
          tmpvar_74.y = (tmpvar_68 * tmpvar_68);
          tmpvar_74.z = tmpvar_68;
          tmpvar_74.w = (0.5 + (0.5 / RES_MU));
          tmpvar_72 = tmpvar_74;
        };
        uR_67 = ((0.5 / RES_R) + ((tmpvar_69 / tmpvar_68) * (1.0 - (1.0/(RES_R)))));
        uMu_66 = (tmpvar_72.w + ((((tmpvar_70 * tmpvar_72.x) + sqrt((tmpvar_71 + tmpvar_72.y))) / (tmpvar_69 + tmpvar_72.z)) * (0.5 - (1.0/(RES_MU)))));
        highp float y_over_x_75;
        y_over_x_75 = (max (tmpvar_35, -0.1975) * 5.34962);
        highp float x_76;
        x_76 = (y_over_x_75 * inversesqrt(((y_over_x_75 * y_over_x_75) + 1.0)));
        highp float tmpvar_77;
        tmpvar_77 = ((0.5 / RES_MU_S) + (((((sign(x_76) * (1.5708 - (sqrt((1.0 - abs(x_76))) * (1.5708 + (abs(x_76) * (-0.214602 + (abs(x_76) * (0.0865667 + (abs(x_76) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        highp float tmpvar_78;
        tmpvar_78 = (((tmpvar_34 + 1.0) / 2.0) * (RES_NU - 1.0));
        highp float tmpvar_79;
        tmpvar_79 = floor(tmpvar_78);
        highp float tmpvar_80;
        tmpvar_80 = (tmpvar_78 - tmpvar_79);
        highp float tmpvar_81;
        tmpvar_81 = (floor(((uR_67 * RES_R) - 1.0)) / RES_R);
        highp float tmpvar_82;
        tmpvar_82 = (floor((uR_67 * RES_R)) / RES_R);
        highp float tmpvar_83;
        tmpvar_83 = fract((uR_67 * RES_R));
        highp vec4 tmpvar_84;
        tmpvar_84.zw = vec2(0.0, 0.0);
        tmpvar_84.x = ((tmpvar_79 + tmpvar_77) / RES_NU);
        tmpvar_84.y = ((uMu_66 / RES_R) + tmpvar_81);
        lowp vec4 tmpvar_85;
        tmpvar_85 = texture2DLodEXT (_Inscatter, tmpvar_84.xy, 0.0);
        highp vec4 tmpvar_86;
        tmpvar_86.zw = vec2(0.0, 0.0);
        tmpvar_86.x = (((tmpvar_79 + tmpvar_77) + 1.0) / RES_NU);
        tmpvar_86.y = ((uMu_66 / RES_R) + tmpvar_81);
        lowp vec4 tmpvar_87;
        tmpvar_87 = texture2DLodEXT (_Inscatter, tmpvar_86.xy, 0.0);
        highp vec4 tmpvar_88;
        tmpvar_88.zw = vec2(0.0, 0.0);
        tmpvar_88.x = ((tmpvar_79 + tmpvar_77) / RES_NU);
        tmpvar_88.y = ((uMu_66 / RES_R) + tmpvar_82);
        lowp vec4 tmpvar_89;
        tmpvar_89 = texture2DLodEXT (_Inscatter, tmpvar_88.xy, 0.0);
        highp vec4 tmpvar_90;
        tmpvar_90.zw = vec2(0.0, 0.0);
        tmpvar_90.x = (((tmpvar_79 + tmpvar_77) + 1.0) / RES_NU);
        tmpvar_90.y = ((uMu_66 / RES_R) + tmpvar_82);
        lowp vec4 tmpvar_91;
        tmpvar_91 = texture2DLodEXT (_Inscatter, tmpvar_90.xy, 0.0);
        inScatter0_62 = ((((tmpvar_85 * (1.0 - tmpvar_80)) + (tmpvar_87 * tmpvar_80)) * (1.0 - tmpvar_83)) + (((tmpvar_89 * (1.0 - tmpvar_80)) + (tmpvar_91 * tmpvar_80)) * tmpvar_83));
        highp float uMu_92;
        highp float uR_93;
        highp float tmpvar_94;
        tmpvar_94 = sqrt(((Rt * Rt) - (Rg * Rg)));
        highp float tmpvar_95;
        tmpvar_95 = sqrt(((tmpvar_65 * tmpvar_65) - (Rg * Rg)));
        highp float tmpvar_96;
        tmpvar_96 = (tmpvar_65 * mu1_31);
        highp float tmpvar_97;
        tmpvar_97 = (((tmpvar_96 * tmpvar_96) - (tmpvar_65 * tmpvar_65)) + (Rg * Rg));
        highp vec4 tmpvar_98;
        if (((tmpvar_96 < 0.0) && (tmpvar_97 > 0.0))) {
          highp vec4 tmpvar_99;
          tmpvar_99.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_99.w = (0.5 - (0.5 / RES_MU));
          tmpvar_98 = tmpvar_99;
        } else {
          highp vec4 tmpvar_100;
          tmpvar_100.x = -1.0;
          tmpvar_100.y = (tmpvar_94 * tmpvar_94);
          tmpvar_100.z = tmpvar_94;
          tmpvar_100.w = (0.5 + (0.5 / RES_MU));
          tmpvar_98 = tmpvar_100;
        };
        uR_93 = ((0.5 / RES_R) + ((tmpvar_95 / tmpvar_94) * (1.0 - (1.0/(RES_R)))));
        uMu_92 = (tmpvar_98.w + ((((tmpvar_96 * tmpvar_98.x) + sqrt((tmpvar_97 + tmpvar_98.y))) / (tmpvar_95 + tmpvar_98.z)) * (0.5 - (1.0/(RES_MU)))));
        highp float y_over_x_101;
        y_over_x_101 = (max (muS1_30, -0.1975) * 5.34962);
        highp float x_102;
        x_102 = (y_over_x_101 * inversesqrt(((y_over_x_101 * y_over_x_101) + 1.0)));
        highp float tmpvar_103;
        tmpvar_103 = ((0.5 / RES_MU_S) + (((((sign(x_102) * (1.5708 - (sqrt((1.0 - abs(x_102))) * (1.5708 + (abs(x_102) * (-0.214602 + (abs(x_102) * (0.0865667 + (abs(x_102) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        highp float tmpvar_104;
        tmpvar_104 = (((tmpvar_34 + 1.0) / 2.0) * (RES_NU - 1.0));
        highp float tmpvar_105;
        tmpvar_105 = floor(tmpvar_104);
        highp float tmpvar_106;
        tmpvar_106 = (tmpvar_104 - tmpvar_105);
        highp float tmpvar_107;
        tmpvar_107 = (floor(((uR_93 * RES_R) - 1.0)) / RES_R);
        highp float tmpvar_108;
        tmpvar_108 = (floor((uR_93 * RES_R)) / RES_R);
        highp float tmpvar_109;
        tmpvar_109 = fract((uR_93 * RES_R));
        highp vec4 tmpvar_110;
        tmpvar_110.zw = vec2(0.0, 0.0);
        tmpvar_110.x = ((tmpvar_105 + tmpvar_103) / RES_NU);
        tmpvar_110.y = ((uMu_92 / RES_R) + tmpvar_107);
        lowp vec4 tmpvar_111;
        tmpvar_111 = texture2DLodEXT (_Inscatter, tmpvar_110.xy, 0.0);
        highp vec4 tmpvar_112;
        tmpvar_112.zw = vec2(0.0, 0.0);
        tmpvar_112.x = (((tmpvar_105 + tmpvar_103) + 1.0) / RES_NU);
        tmpvar_112.y = ((uMu_92 / RES_R) + tmpvar_107);
        lowp vec4 tmpvar_113;
        tmpvar_113 = texture2DLodEXT (_Inscatter, tmpvar_112.xy, 0.0);
        highp vec4 tmpvar_114;
        tmpvar_114.zw = vec2(0.0, 0.0);
        tmpvar_114.x = ((tmpvar_105 + tmpvar_103) / RES_NU);
        tmpvar_114.y = ((uMu_92 / RES_R) + tmpvar_108);
        lowp vec4 tmpvar_115;
        tmpvar_115 = texture2DLodEXT (_Inscatter, tmpvar_114.xy, 0.0);
        highp vec4 tmpvar_116;
        tmpvar_116.zw = vec2(0.0, 0.0);
        tmpvar_116.x = (((tmpvar_105 + tmpvar_103) + 1.0) / RES_NU);
        tmpvar_116.y = ((uMu_92 / RES_R) + tmpvar_108);
        lowp vec4 tmpvar_117;
        tmpvar_117 = texture2DLodEXT (_Inscatter, tmpvar_116.xy, 0.0);
        inScatterA_61 = max ((inScatter0_62 - (((((tmpvar_111 * (1.0 - tmpvar_106)) + (tmpvar_113 * tmpvar_106)) * (1.0 - tmpvar_109)) + (((tmpvar_115 * (1.0 - tmpvar_106)) + (tmpvar_117 * tmpvar_106)) * tmpvar_109)) * extinction_16.xyzx)), vec4(0.0, 0.0, 0.0, 0.0));
        highp float tmpvar_118;
        tmpvar_118 = (tmpvar_59 + 0.004);
        mu_17 = tmpvar_118;
        highp float tmpvar_119;
        tmpvar_119 = sqrt((((r_19 * r_19) + (d_20 * d_20)) + (((2.0 * r_19) * d_20) * tmpvar_118)));
        r1_32 = tmpvar_119;
        mu1_31 = (((r_19 * tmpvar_118) + d_20) / tmpvar_119);
        highp float uMu_120;
        highp float uR_121;
        highp float tmpvar_122;
        tmpvar_122 = sqrt(((Rt * Rt) - (Rg * Rg)));
        highp float tmpvar_123;
        tmpvar_123 = sqrt(((r_19 * r_19) - (Rg * Rg)));
        highp float tmpvar_124;
        tmpvar_124 = (r_19 * tmpvar_118);
        highp float tmpvar_125;
        tmpvar_125 = (((tmpvar_124 * tmpvar_124) - (r_19 * r_19)) + (Rg * Rg));
        highp vec4 tmpvar_126;
        if (((tmpvar_124 < 0.0) && (tmpvar_125 > 0.0))) {
          highp vec4 tmpvar_127;
          tmpvar_127.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_127.w = (0.5 - (0.5 / RES_MU));
          tmpvar_126 = tmpvar_127;
        } else {
          highp vec4 tmpvar_128;
          tmpvar_128.x = -1.0;
          tmpvar_128.y = (tmpvar_122 * tmpvar_122);
          tmpvar_128.z = tmpvar_122;
          tmpvar_128.w = (0.5 + (0.5 / RES_MU));
          tmpvar_126 = tmpvar_128;
        };
        uR_121 = ((0.5 / RES_R) + ((tmpvar_123 / tmpvar_122) * (1.0 - (1.0/(RES_R)))));
        uMu_120 = (tmpvar_126.w + ((((tmpvar_124 * tmpvar_126.x) + sqrt((tmpvar_125 + tmpvar_126.y))) / (tmpvar_123 + tmpvar_126.z)) * (0.5 - (1.0/(RES_MU)))));
        highp float y_over_x_129;
        y_over_x_129 = (max (tmpvar_35, -0.1975) * 5.34962);
        highp float x_130;
        x_130 = (y_over_x_129 * inversesqrt(((y_over_x_129 * y_over_x_129) + 1.0)));
        highp float tmpvar_131;
        tmpvar_131 = ((0.5 / RES_MU_S) + (((((sign(x_130) * (1.5708 - (sqrt((1.0 - abs(x_130))) * (1.5708 + (abs(x_130) * (-0.214602 + (abs(x_130) * (0.0865667 + (abs(x_130) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        highp float tmpvar_132;
        tmpvar_132 = (((tmpvar_34 + 1.0) / 2.0) * (RES_NU - 1.0));
        highp float tmpvar_133;
        tmpvar_133 = floor(tmpvar_132);
        highp float tmpvar_134;
        tmpvar_134 = (tmpvar_132 - tmpvar_133);
        highp float tmpvar_135;
        tmpvar_135 = (floor(((uR_121 * RES_R) - 1.0)) / RES_R);
        highp float tmpvar_136;
        tmpvar_136 = (floor((uR_121 * RES_R)) / RES_R);
        highp float tmpvar_137;
        tmpvar_137 = fract((uR_121 * RES_R));
        highp vec4 tmpvar_138;
        tmpvar_138.zw = vec2(0.0, 0.0);
        tmpvar_138.x = ((tmpvar_133 + tmpvar_131) / RES_NU);
        tmpvar_138.y = ((uMu_120 / RES_R) + tmpvar_135);
        lowp vec4 tmpvar_139;
        tmpvar_139 = texture2DLodEXT (_Inscatter, tmpvar_138.xy, 0.0);
        highp vec4 tmpvar_140;
        tmpvar_140.zw = vec2(0.0, 0.0);
        tmpvar_140.x = (((tmpvar_133 + tmpvar_131) + 1.0) / RES_NU);
        tmpvar_140.y = ((uMu_120 / RES_R) + tmpvar_135);
        lowp vec4 tmpvar_141;
        tmpvar_141 = texture2DLodEXT (_Inscatter, tmpvar_140.xy, 0.0);
        highp vec4 tmpvar_142;
        tmpvar_142.zw = vec2(0.0, 0.0);
        tmpvar_142.x = ((tmpvar_133 + tmpvar_131) / RES_NU);
        tmpvar_142.y = ((uMu_120 / RES_R) + tmpvar_136);
        lowp vec4 tmpvar_143;
        tmpvar_143 = texture2DLodEXT (_Inscatter, tmpvar_142.xy, 0.0);
        highp vec4 tmpvar_144;
        tmpvar_144.zw = vec2(0.0, 0.0);
        tmpvar_144.x = (((tmpvar_133 + tmpvar_131) + 1.0) / RES_NU);
        tmpvar_144.y = ((uMu_120 / RES_R) + tmpvar_136);
        lowp vec4 tmpvar_145;
        tmpvar_145 = texture2DLodEXT (_Inscatter, tmpvar_144.xy, 0.0);
        inScatter0_62 = ((((tmpvar_139 * (1.0 - tmpvar_134)) + (tmpvar_141 * tmpvar_134)) * (1.0 - tmpvar_137)) + (((tmpvar_143 * (1.0 - tmpvar_134)) + (tmpvar_145 * tmpvar_134)) * tmpvar_137));
        highp float uMu_146;
        highp float uR_147;
        highp float tmpvar_148;
        tmpvar_148 = sqrt(((Rt * Rt) - (Rg * Rg)));
        highp float tmpvar_149;
        tmpvar_149 = sqrt(((tmpvar_119 * tmpvar_119) - (Rg * Rg)));
        highp float tmpvar_150;
        tmpvar_150 = (tmpvar_119 * mu1_31);
        highp float tmpvar_151;
        tmpvar_151 = (((tmpvar_150 * tmpvar_150) - (tmpvar_119 * tmpvar_119)) + (Rg * Rg));
        highp vec4 tmpvar_152;
        if (((tmpvar_150 < 0.0) && (tmpvar_151 > 0.0))) {
          highp vec4 tmpvar_153;
          tmpvar_153.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_153.w = (0.5 - (0.5 / RES_MU));
          tmpvar_152 = tmpvar_153;
        } else {
          highp vec4 tmpvar_154;
          tmpvar_154.x = -1.0;
          tmpvar_154.y = (tmpvar_148 * tmpvar_148);
          tmpvar_154.z = tmpvar_148;
          tmpvar_154.w = (0.5 + (0.5 / RES_MU));
          tmpvar_152 = tmpvar_154;
        };
        uR_147 = ((0.5 / RES_R) + ((tmpvar_149 / tmpvar_148) * (1.0 - (1.0/(RES_R)))));
        uMu_146 = (tmpvar_152.w + ((((tmpvar_150 * tmpvar_152.x) + sqrt((tmpvar_151 + tmpvar_152.y))) / (tmpvar_149 + tmpvar_152.z)) * (0.5 - (1.0/(RES_MU)))));
        highp float y_over_x_155;
        y_over_x_155 = (max (muS1_30, -0.1975) * 5.34962);
        highp float x_156;
        x_156 = (y_over_x_155 * inversesqrt(((y_over_x_155 * y_over_x_155) + 1.0)));
        highp float tmpvar_157;
        tmpvar_157 = ((0.5 / RES_MU_S) + (((((sign(x_156) * (1.5708 - (sqrt((1.0 - abs(x_156))) * (1.5708 + (abs(x_156) * (-0.214602 + (abs(x_156) * (0.0865667 + (abs(x_156) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        highp float tmpvar_158;
        tmpvar_158 = (((tmpvar_34 + 1.0) / 2.0) * (RES_NU - 1.0));
        highp float tmpvar_159;
        tmpvar_159 = floor(tmpvar_158);
        highp float tmpvar_160;
        tmpvar_160 = (tmpvar_158 - tmpvar_159);
        highp float tmpvar_161;
        tmpvar_161 = (floor(((uR_147 * RES_R) - 1.0)) / RES_R);
        highp float tmpvar_162;
        tmpvar_162 = (floor((uR_147 * RES_R)) / RES_R);
        highp float tmpvar_163;
        tmpvar_163 = fract((uR_147 * RES_R));
        highp vec4 tmpvar_164;
        tmpvar_164.zw = vec2(0.0, 0.0);
        tmpvar_164.x = ((tmpvar_159 + tmpvar_157) / RES_NU);
        tmpvar_164.y = ((uMu_146 / RES_R) + tmpvar_161);
        lowp vec4 tmpvar_165;
        tmpvar_165 = texture2DLodEXT (_Inscatter, tmpvar_164.xy, 0.0);
        highp vec4 tmpvar_166;
        tmpvar_166.zw = vec2(0.0, 0.0);
        tmpvar_166.x = (((tmpvar_159 + tmpvar_157) + 1.0) / RES_NU);
        tmpvar_166.y = ((uMu_146 / RES_R) + tmpvar_161);
        lowp vec4 tmpvar_167;
        tmpvar_167 = texture2DLodEXT (_Inscatter, tmpvar_166.xy, 0.0);
        highp vec4 tmpvar_168;
        tmpvar_168.zw = vec2(0.0, 0.0);
        tmpvar_168.x = ((tmpvar_159 + tmpvar_157) / RES_NU);
        tmpvar_168.y = ((uMu_146 / RES_R) + tmpvar_162);
        lowp vec4 tmpvar_169;
        tmpvar_169 = texture2DLodEXT (_Inscatter, tmpvar_168.xy, 0.0);
        highp vec4 tmpvar_170;
        tmpvar_170.zw = vec2(0.0, 0.0);
        tmpvar_170.x = (((tmpvar_159 + tmpvar_157) + 1.0) / RES_NU);
        tmpvar_170.y = ((uMu_146 / RES_R) + tmpvar_162);
        lowp vec4 tmpvar_171;
        tmpvar_171 = texture2DLodEXT (_Inscatter, tmpvar_170.xy, 0.0);
        inScatter_33 = mix (inScatterA_61, max ((inScatter0_62 - (((((tmpvar_165 * (1.0 - tmpvar_160)) + (tmpvar_167 * tmpvar_160)) * (1.0 - tmpvar_163)) + (((tmpvar_169 * (1.0 - tmpvar_160)) + (tmpvar_171 * tmpvar_160)) * tmpvar_163)) * extinction_16.xyzx)), vec4(0.0, 0.0, 0.0, 0.0)), vec4(a_63));
      } else {
        highp vec4 inScatter0_1_172;
        highp float uMu_173;
        highp float uR_174;
        highp float tmpvar_175;
        tmpvar_175 = sqrt(((Rt * Rt) - (Rg * Rg)));
        highp float tmpvar_176;
        tmpvar_176 = sqrt(((r_19 * r_19) - (Rg * Rg)));
        highp float tmpvar_177;
        tmpvar_177 = (r_19 * mu_17);
        highp float tmpvar_178;
        tmpvar_178 = (((tmpvar_177 * tmpvar_177) - (r_19 * r_19)) + (Rg * Rg));
        highp vec4 tmpvar_179;
        if (((tmpvar_177 < 0.0) && (tmpvar_178 > 0.0))) {
          highp vec4 tmpvar_180;
          tmpvar_180.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_180.w = (0.5 - (0.5 / RES_MU));
          tmpvar_179 = tmpvar_180;
        } else {
          highp vec4 tmpvar_181;
          tmpvar_181.x = -1.0;
          tmpvar_181.y = (tmpvar_175 * tmpvar_175);
          tmpvar_181.z = tmpvar_175;
          tmpvar_181.w = (0.5 + (0.5 / RES_MU));
          tmpvar_179 = tmpvar_181;
        };
        uR_174 = ((0.5 / RES_R) + ((tmpvar_176 / tmpvar_175) * (1.0 - (1.0/(RES_R)))));
        uMu_173 = (tmpvar_179.w + ((((tmpvar_177 * tmpvar_179.x) + sqrt((tmpvar_178 + tmpvar_179.y))) / (tmpvar_176 + tmpvar_179.z)) * (0.5 - (1.0/(RES_MU)))));
        highp float y_over_x_182;
        y_over_x_182 = (max (tmpvar_35, -0.1975) * 5.34962);
        highp float x_183;
        x_183 = (y_over_x_182 * inversesqrt(((y_over_x_182 * y_over_x_182) + 1.0)));
        highp float tmpvar_184;
        tmpvar_184 = ((0.5 / RES_MU_S) + (((((sign(x_183) * (1.5708 - (sqrt((1.0 - abs(x_183))) * (1.5708 + (abs(x_183) * (-0.214602 + (abs(x_183) * (0.0865667 + (abs(x_183) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        highp float tmpvar_185;
        tmpvar_185 = (((tmpvar_34 + 1.0) / 2.0) * (RES_NU - 1.0));
        highp float tmpvar_186;
        tmpvar_186 = floor(tmpvar_185);
        highp float tmpvar_187;
        tmpvar_187 = (tmpvar_185 - tmpvar_186);
        highp float tmpvar_188;
        tmpvar_188 = (floor(((uR_174 * RES_R) - 1.0)) / RES_R);
        highp float tmpvar_189;
        tmpvar_189 = (floor((uR_174 * RES_R)) / RES_R);
        highp float tmpvar_190;
        tmpvar_190 = fract((uR_174 * RES_R));
        highp vec4 tmpvar_191;
        tmpvar_191.zw = vec2(0.0, 0.0);
        tmpvar_191.x = ((tmpvar_186 + tmpvar_184) / RES_NU);
        tmpvar_191.y = ((uMu_173 / RES_R) + tmpvar_188);
        lowp vec4 tmpvar_192;
        tmpvar_192 = texture2DLodEXT (_Inscatter, tmpvar_191.xy, 0.0);
        highp vec4 tmpvar_193;
        tmpvar_193.zw = vec2(0.0, 0.0);
        tmpvar_193.x = (((tmpvar_186 + tmpvar_184) + 1.0) / RES_NU);
        tmpvar_193.y = ((uMu_173 / RES_R) + tmpvar_188);
        lowp vec4 tmpvar_194;
        tmpvar_194 = texture2DLodEXT (_Inscatter, tmpvar_193.xy, 0.0);
        highp vec4 tmpvar_195;
        tmpvar_195.zw = vec2(0.0, 0.0);
        tmpvar_195.x = ((tmpvar_186 + tmpvar_184) / RES_NU);
        tmpvar_195.y = ((uMu_173 / RES_R) + tmpvar_189);
        lowp vec4 tmpvar_196;
        tmpvar_196 = texture2DLodEXT (_Inscatter, tmpvar_195.xy, 0.0);
        highp vec4 tmpvar_197;
        tmpvar_197.zw = vec2(0.0, 0.0);
        tmpvar_197.x = (((tmpvar_186 + tmpvar_184) + 1.0) / RES_NU);
        tmpvar_197.y = ((uMu_173 / RES_R) + tmpvar_189);
        lowp vec4 tmpvar_198;
        tmpvar_198 = texture2DLodEXT (_Inscatter, tmpvar_197.xy, 0.0);
        inScatter0_1_172 = ((((tmpvar_192 * (1.0 - tmpvar_187)) + (tmpvar_194 * tmpvar_187)) * (1.0 - tmpvar_190)) + (((tmpvar_196 * (1.0 - tmpvar_187)) + (tmpvar_198 * tmpvar_187)) * tmpvar_190));
        highp float uMu_199;
        highp float uR_200;
        highp float tmpvar_201;
        tmpvar_201 = sqrt(((Rt * Rt) - (Rg * Rg)));
        highp float tmpvar_202;
        tmpvar_202 = sqrt(((r1_32 * r1_32) - (Rg * Rg)));
        highp float tmpvar_203;
        tmpvar_203 = (r1_32 * mu1_31);
        highp float tmpvar_204;
        tmpvar_204 = (((tmpvar_203 * tmpvar_203) - (r1_32 * r1_32)) + (Rg * Rg));
        highp vec4 tmpvar_205;
        if (((tmpvar_203 < 0.0) && (tmpvar_204 > 0.0))) {
          highp vec4 tmpvar_206;
          tmpvar_206.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_206.w = (0.5 - (0.5 / RES_MU));
          tmpvar_205 = tmpvar_206;
        } else {
          highp vec4 tmpvar_207;
          tmpvar_207.x = -1.0;
          tmpvar_207.y = (tmpvar_201 * tmpvar_201);
          tmpvar_207.z = tmpvar_201;
          tmpvar_207.w = (0.5 + (0.5 / RES_MU));
          tmpvar_205 = tmpvar_207;
        };
        uR_200 = ((0.5 / RES_R) + ((tmpvar_202 / tmpvar_201) * (1.0 - (1.0/(RES_R)))));
        uMu_199 = (tmpvar_205.w + ((((tmpvar_203 * tmpvar_205.x) + sqrt((tmpvar_204 + tmpvar_205.y))) / (tmpvar_202 + tmpvar_205.z)) * (0.5 - (1.0/(RES_MU)))));
        highp float y_over_x_208;
        y_over_x_208 = (max (muS1_30, -0.1975) * 5.34962);
        highp float x_209;
        x_209 = (y_over_x_208 * inversesqrt(((y_over_x_208 * y_over_x_208) + 1.0)));
        highp float tmpvar_210;
        tmpvar_210 = ((0.5 / RES_MU_S) + (((((sign(x_209) * (1.5708 - (sqrt((1.0 - abs(x_209))) * (1.5708 + (abs(x_209) * (-0.214602 + (abs(x_209) * (0.0865667 + (abs(x_209) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        highp float tmpvar_211;
        tmpvar_211 = (((tmpvar_34 + 1.0) / 2.0) * (RES_NU - 1.0));
        highp float tmpvar_212;
        tmpvar_212 = floor(tmpvar_211);
        highp float tmpvar_213;
        tmpvar_213 = (tmpvar_211 - tmpvar_212);
        highp float tmpvar_214;
        tmpvar_214 = (floor(((uR_200 * RES_R) - 1.0)) / RES_R);
        highp float tmpvar_215;
        tmpvar_215 = (floor((uR_200 * RES_R)) / RES_R);
        highp float tmpvar_216;
        tmpvar_216 = fract((uR_200 * RES_R));
        highp vec4 tmpvar_217;
        tmpvar_217.zw = vec2(0.0, 0.0);
        tmpvar_217.x = ((tmpvar_212 + tmpvar_210) / RES_NU);
        tmpvar_217.y = ((uMu_199 / RES_R) + tmpvar_214);
        lowp vec4 tmpvar_218;
        tmpvar_218 = texture2DLodEXT (_Inscatter, tmpvar_217.xy, 0.0);
        highp vec4 tmpvar_219;
        tmpvar_219.zw = vec2(0.0, 0.0);
        tmpvar_219.x = (((tmpvar_212 + tmpvar_210) + 1.0) / RES_NU);
        tmpvar_219.y = ((uMu_199 / RES_R) + tmpvar_214);
        lowp vec4 tmpvar_220;
        tmpvar_220 = texture2DLodEXT (_Inscatter, tmpvar_219.xy, 0.0);
        highp vec4 tmpvar_221;
        tmpvar_221.zw = vec2(0.0, 0.0);
        tmpvar_221.x = ((tmpvar_212 + tmpvar_210) / RES_NU);
        tmpvar_221.y = ((uMu_199 / RES_R) + tmpvar_215);
        lowp vec4 tmpvar_222;
        tmpvar_222 = texture2DLodEXT (_Inscatter, tmpvar_221.xy, 0.0);
        highp vec4 tmpvar_223;
        tmpvar_223.zw = vec2(0.0, 0.0);
        tmpvar_223.x = (((tmpvar_212 + tmpvar_210) + 1.0) / RES_NU);
        tmpvar_223.y = ((uMu_199 / RES_R) + tmpvar_215);
        lowp vec4 tmpvar_224;
        tmpvar_224 = texture2DLodEXT (_Inscatter, tmpvar_223.xy, 0.0);
        inScatter_33 = max ((inScatter0_1_172 - (((((tmpvar_218 * (1.0 - tmpvar_213)) + (tmpvar_220 * tmpvar_213)) * (1.0 - tmpvar_216)) + (((tmpvar_222 * (1.0 - tmpvar_213)) + (tmpvar_224 * tmpvar_213)) * tmpvar_216)) * extinction_16.xyzx)), vec4(0.0, 0.0, 0.0, 0.0));
      };
      highp float t_225;
      t_225 = max (min ((tmpvar_35 / 0.02), 1.0), 0.0);
      inScatter_33.w = (inScatter_33.w * (t_225 * (t_225 * (3.0 - (2.0 * t_225)))));
      result_21 = ((inScatter_33.xyz * ((3.0 / (16.0 * M_PI)) * (1.0 + (tmpvar_34 * tmpvar_34)))) + ((((inScatter_33.xyz * inScatter_33.w) / max (inScatter_33.x, 0.0001)) * (betaR.x / betaR)) * (((((1.5 / (4.0 * M_PI)) * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_34)), -1.5)) * (1.0 + (tmpvar_34 * tmpvar_34))) / (2.0 + (mieG * mieG)))));
    };
    tmpvar_13 = (result_21 * SUN_INTENSITY);
    visib_2 = 1.0;
    if ((tmpvar_7 <= _global_depth)) {
      visib_2 = (1.0 - exp((-1.0 * ((4.0 * tmpvar_7) / _global_depth))));
    };
    highp vec3 L_226;
    highp vec3 tmpvar_227;
    tmpvar_227 = (tmpvar_13 * _Exposure);
    L_226 = tmpvar_227;
    highp float tmpvar_228;
    if ((tmpvar_227.x < 1.413)) {
      tmpvar_228 = pow ((tmpvar_227.x * 0.38317), 0.454545);
    } else {
      tmpvar_228 = (1.0 - exp(-(tmpvar_227.x)));
    };
    L_226.x = tmpvar_228;
    highp float tmpvar_229;
    if ((tmpvar_227.y < 1.413)) {
      tmpvar_229 = pow ((tmpvar_227.y * 0.38317), 0.454545);
    } else {
      tmpvar_229 = (1.0 - exp(-(tmpvar_227.y)));
    };
    L_226.y = tmpvar_229;
    highp float tmpvar_230;
    if ((tmpvar_227.z < 1.413)) {
      tmpvar_230 = pow ((tmpvar_227.z * 0.38317), 0.454545);
    } else {
      tmpvar_230 = (1.0 - exp(-(tmpvar_227.z)));
    };
    L_226.z = tmpvar_230;
    highp vec4 tmpvar_231;
    tmpvar_231.xyz = L_226;
    tmpvar_231.w = (_global_alpha * visib_2);
    tmpvar_1 = tmpvar_231;
  };
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
out highp vec4 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  highp vec2 tmpvar_6;
  tmpvar_6 = (o_3.xy / tmpvar_2.w);
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform highp vec4 _ZBufferParams;
uniform sampler2D _Transmittance;
uniform sampler2D _Inscatter;
uniform highp float M_PI;
uniform highp float Rg;
uniform highp float Rt;
uniform highp float RES_R;
uniform highp float RES_MU;
uniform highp float RES_MU_S;
uniform highp float RES_NU;
uniform highp vec3 SUN_DIR;
uniform highp float SUN_INTENSITY;
uniform highp vec3 betaR;
uniform highp float mieG;
uniform highp mat4 _ViewProjInv;
uniform highp float _Scale;
uniform highp float _global_alpha;
uniform highp float _Exposure;
uniform highp float _global_depth;
uniform highp float _global_depth2;
uniform highp vec3 _inCamPos;
uniform highp vec3 _Globals_Origin;
uniform sampler2D _CameraDepthTexture;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp float visib_2;
  highp vec3 worldPos_3;
  highp float depth_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_CameraDepthTexture, xlv_TEXCOORD2);
  highp float z_6;
  z_6 = tmpvar_5.x;
  highp float tmpvar_7;
  tmpvar_7 = (_global_depth2 * (1.0/(((_ZBufferParams.x * z_6) + _ZBufferParams.y))));
  lowp float tmpvar_8;
  tmpvar_8 = texture (_CameraDepthTexture, xlv_TEXCOORD2).x;
  depth_4 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.x = ((xlv_TEXCOORD2.x * 2.0) - 1.0);
  tmpvar_9.y = ((xlv_TEXCOORD2.y * 2.0) - 1.0);
  tmpvar_9.z = depth_4;
  highp vec4 tmpvar_10;
  tmpvar_10 = (_ViewProjInv * tmpvar_9);
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 / tmpvar_10.w).xyz;
  worldPos_3 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
  if ((tmpvar_12 < (Rg + 250.0))) {
    worldPos_3 = ((Rg + 250.0) * normalize(tmpvar_11));
  };
  if ((tmpvar_7 >= 1.0)) {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    highp vec3 tmpvar_13;
    highp vec3 camera_14;
    camera_14 = ((_inCamPos - _Globals_Origin) * _Scale);
    highp vec3 _point_15;
    _point_15 = (worldPos_3 * _Scale);
    highp vec3 extinction_16;
    highp float mu_17;
    highp float rMu_18;
    highp float r_19;
    highp float d_20;
    highp vec3 result_21;
    result_21 = vec3(0.0, 0.0, 0.0);
    extinction_16 = vec3(1.0, 1.0, 1.0);
    highp vec3 tmpvar_22;
    tmpvar_22 = (_point_15 - camera_14);
    highp float tmpvar_23;
    tmpvar_23 = sqrt(dot (tmpvar_22, tmpvar_22));
    highp vec3 tmpvar_24;
    tmpvar_24 = (tmpvar_22 / tmpvar_23);
    d_20 = tmpvar_23;
    highp float tmpvar_25;
    tmpvar_25 = sqrt(dot (camera_14, camera_14));
    r_19 = tmpvar_25;
    if ((tmpvar_25 < (0.9 * Rg))) {
      camera_14.y = (camera_14.y + Rg);
      _point_15.y = (_point_15.y + Rg);
      r_19 = sqrt(dot (camera_14, camera_14));
    };
    highp float tmpvar_26;
    tmpvar_26 = dot (camera_14, tmpvar_24);
    rMu_18 = tmpvar_26;
    mu_17 = (tmpvar_26 / r_19);
    highp vec3 tmpvar_27;
    tmpvar_27 = (_point_15 - (tmpvar_24 * clamp (1.0, 0.0, tmpvar_23)));
    _point_15 = tmpvar_27;
    highp float tmpvar_28;
    tmpvar_28 = max ((-(tmpvar_26) - sqrt((((tmpvar_26 * tmpvar_26) - (r_19 * r_19)) + (Rt * Rt)))), 0.0);
    if (((tmpvar_28 > 0.0) && (tmpvar_28 < tmpvar_23))) {
      camera_14 = (camera_14 + (tmpvar_28 * tmpvar_24));
      highp float tmpvar_29;
      tmpvar_29 = (tmpvar_26 + tmpvar_28);
      rMu_18 = tmpvar_29;
      mu_17 = (tmpvar_29 / Rt);
      r_19 = Rt;
      d_20 = (tmpvar_23 - tmpvar_28);
    };
    if ((r_19 <= Rt)) {
      highp float muS1_30;
      highp float mu1_31;
      highp float r1_32;
      highp vec4 inScatter_33;
      highp float tmpvar_34;
      tmpvar_34 = dot (tmpvar_24, SUN_DIR);
      highp float tmpvar_35;
      tmpvar_35 = (dot (camera_14, SUN_DIR) / r_19);
      if ((r_19 < (Rg + 600.0))) {
        highp float tmpvar_36;
        tmpvar_36 = ((Rg + 600.0) / r_19);
        r_19 = (r_19 * tmpvar_36);
        rMu_18 = (rMu_18 * tmpvar_36);
        _point_15 = (tmpvar_27 * tmpvar_36);
      };
      highp float tmpvar_37;
      tmpvar_37 = sqrt(dot (_point_15, _point_15));
      r1_32 = tmpvar_37;
      highp float tmpvar_38;
      tmpvar_38 = (dot (_point_15, tmpvar_24) / tmpvar_37);
      mu1_31 = tmpvar_38;
      muS1_30 = (dot (_point_15, SUN_DIR) / tmpvar_37);
      if ((mu_17 > 0.0)) {
        highp vec3 tmpvar_39;
        highp float y_over_x_40;
        y_over_x_40 = (((mu_17 + 0.15) / 1.15) * 14.1014);
        highp float x_41;
        x_41 = (y_over_x_40 * inversesqrt(((y_over_x_40 * y_over_x_40) + 1.0)));
        highp vec4 tmpvar_42;
        tmpvar_42.zw = vec2(0.0, 0.0);
        tmpvar_42.x = ((sign(x_41) * (1.5708 - (sqrt((1.0 - abs(x_41))) * (1.5708 + (abs(x_41) * (-0.214602 + (abs(x_41) * (0.0865667 + (abs(x_41) * -0.0310296))))))))) / 1.5);
        tmpvar_42.y = sqrt(((r_19 - Rg) / (Rt - Rg)));
        lowp vec4 tmpvar_43;
        tmpvar_43 = textureLod (_Transmittance, tmpvar_42.xy, 0.0);
        tmpvar_39 = tmpvar_43.xyz;
        highp vec3 tmpvar_44;
        highp float y_over_x_45;
        y_over_x_45 = (((tmpvar_38 + 0.15) / 1.15) * 14.1014);
        highp float x_46;
        x_46 = (y_over_x_45 * inversesqrt(((y_over_x_45 * y_over_x_45) + 1.0)));
        highp vec4 tmpvar_47;
        tmpvar_47.zw = vec2(0.0, 0.0);
        tmpvar_47.x = ((sign(x_46) * (1.5708 - (sqrt((1.0 - abs(x_46))) * (1.5708 + (abs(x_46) * (-0.214602 + (abs(x_46) * (0.0865667 + (abs(x_46) * -0.0310296))))))))) / 1.5);
        tmpvar_47.y = sqrt(((tmpvar_37 - Rg) / (Rt - Rg)));
        lowp vec4 tmpvar_48;
        tmpvar_48 = textureLod (_Transmittance, tmpvar_47.xy, 0.0);
        tmpvar_44 = tmpvar_48.xyz;
        extinction_16 = min ((tmpvar_39 / tmpvar_44), vec3(1.0, 1.0, 1.0));
      } else {
        highp vec3 tmpvar_49;
        highp float y_over_x_50;
        y_over_x_50 = (((-(tmpvar_38) + 0.15) / 1.15) * 14.1014);
        highp float x_51;
        x_51 = (y_over_x_50 * inversesqrt(((y_over_x_50 * y_over_x_50) + 1.0)));
        highp vec4 tmpvar_52;
        tmpvar_52.zw = vec2(0.0, 0.0);
        tmpvar_52.x = ((sign(x_51) * (1.5708 - (sqrt((1.0 - abs(x_51))) * (1.5708 + (abs(x_51) * (-0.214602 + (abs(x_51) * (0.0865667 + (abs(x_51) * -0.0310296))))))))) / 1.5);
        tmpvar_52.y = sqrt(((tmpvar_37 - Rg) / (Rt - Rg)));
        lowp vec4 tmpvar_53;
        tmpvar_53 = textureLod (_Transmittance, tmpvar_52.xy, 0.0);
        tmpvar_49 = tmpvar_53.xyz;
        highp vec3 tmpvar_54;
        highp float y_over_x_55;
        y_over_x_55 = (((-(mu_17) + 0.15) / 1.15) * 14.1014);
        highp float x_56;
        x_56 = (y_over_x_55 * inversesqrt(((y_over_x_55 * y_over_x_55) + 1.0)));
        highp vec4 tmpvar_57;
        tmpvar_57.zw = vec2(0.0, 0.0);
        tmpvar_57.x = ((sign(x_56) * (1.5708 - (sqrt((1.0 - abs(x_56))) * (1.5708 + (abs(x_56) * (-0.214602 + (abs(x_56) * (0.0865667 + (abs(x_56) * -0.0310296))))))))) / 1.5);
        tmpvar_57.y = sqrt(((r_19 - Rg) / (Rt - Rg)));
        lowp vec4 tmpvar_58;
        tmpvar_58 = textureLod (_Transmittance, tmpvar_57.xy, 0.0);
        tmpvar_54 = tmpvar_58.xyz;
        extinction_16 = min ((tmpvar_49 / tmpvar_54), vec3(1.0, 1.0, 1.0));
      };
      highp float tmpvar_59;
      tmpvar_59 = -(sqrt((1.0 - ((Rg / r_19) * (Rg / r_19)))));
      highp float tmpvar_60;
      tmpvar_60 = abs((mu_17 - tmpvar_59));
      if ((tmpvar_60 < 0.004)) {
        highp vec4 inScatterA_61;
        highp vec4 inScatter0_62;
        highp float a_63;
        a_63 = (((mu_17 - tmpvar_59) + 0.004) / 0.008);
        highp float tmpvar_64;
        tmpvar_64 = (tmpvar_59 - 0.004);
        mu_17 = tmpvar_64;
        highp float tmpvar_65;
        tmpvar_65 = sqrt((((r_19 * r_19) + (d_20 * d_20)) + (((2.0 * r_19) * d_20) * tmpvar_64)));
        r1_32 = tmpvar_65;
        mu1_31 = (((r_19 * tmpvar_64) + d_20) / tmpvar_65);
        highp float uMu_66;
        highp float uR_67;
        highp float tmpvar_68;
        tmpvar_68 = sqrt(((Rt * Rt) - (Rg * Rg)));
        highp float tmpvar_69;
        tmpvar_69 = sqrt(((r_19 * r_19) - (Rg * Rg)));
        highp float tmpvar_70;
        tmpvar_70 = (r_19 * tmpvar_64);
        highp float tmpvar_71;
        tmpvar_71 = (((tmpvar_70 * tmpvar_70) - (r_19 * r_19)) + (Rg * Rg));
        highp vec4 tmpvar_72;
        if (((tmpvar_70 < 0.0) && (tmpvar_71 > 0.0))) {
          highp vec4 tmpvar_73;
          tmpvar_73.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_73.w = (0.5 - (0.5 / RES_MU));
          tmpvar_72 = tmpvar_73;
        } else {
          highp vec4 tmpvar_74;
          tmpvar_74.x = -1.0;
          tmpvar_74.y = (tmpvar_68 * tmpvar_68);
          tmpvar_74.z = tmpvar_68;
          tmpvar_74.w = (0.5 + (0.5 / RES_MU));
          tmpvar_72 = tmpvar_74;
        };
        uR_67 = ((0.5 / RES_R) + ((tmpvar_69 / tmpvar_68) * (1.0 - (1.0/(RES_R)))));
        uMu_66 = (tmpvar_72.w + ((((tmpvar_70 * tmpvar_72.x) + sqrt((tmpvar_71 + tmpvar_72.y))) / (tmpvar_69 + tmpvar_72.z)) * (0.5 - (1.0/(RES_MU)))));
        highp float y_over_x_75;
        y_over_x_75 = (max (tmpvar_35, -0.1975) * 5.34962);
        highp float x_76;
        x_76 = (y_over_x_75 * inversesqrt(((y_over_x_75 * y_over_x_75) + 1.0)));
        highp float tmpvar_77;
        tmpvar_77 = ((0.5 / RES_MU_S) + (((((sign(x_76) * (1.5708 - (sqrt((1.0 - abs(x_76))) * (1.5708 + (abs(x_76) * (-0.214602 + (abs(x_76) * (0.0865667 + (abs(x_76) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        highp float tmpvar_78;
        tmpvar_78 = (((tmpvar_34 + 1.0) / 2.0) * (RES_NU - 1.0));
        highp float tmpvar_79;
        tmpvar_79 = floor(tmpvar_78);
        highp float tmpvar_80;
        tmpvar_80 = (tmpvar_78 - tmpvar_79);
        highp float tmpvar_81;
        tmpvar_81 = (floor(((uR_67 * RES_R) - 1.0)) / RES_R);
        highp float tmpvar_82;
        tmpvar_82 = (floor((uR_67 * RES_R)) / RES_R);
        highp float tmpvar_83;
        tmpvar_83 = fract((uR_67 * RES_R));
        highp vec4 tmpvar_84;
        tmpvar_84.zw = vec2(0.0, 0.0);
        tmpvar_84.x = ((tmpvar_79 + tmpvar_77) / RES_NU);
        tmpvar_84.y = ((uMu_66 / RES_R) + tmpvar_81);
        lowp vec4 tmpvar_85;
        tmpvar_85 = textureLod (_Inscatter, tmpvar_84.xy, 0.0);
        highp vec4 tmpvar_86;
        tmpvar_86.zw = vec2(0.0, 0.0);
        tmpvar_86.x = (((tmpvar_79 + tmpvar_77) + 1.0) / RES_NU);
        tmpvar_86.y = ((uMu_66 / RES_R) + tmpvar_81);
        lowp vec4 tmpvar_87;
        tmpvar_87 = textureLod (_Inscatter, tmpvar_86.xy, 0.0);
        highp vec4 tmpvar_88;
        tmpvar_88.zw = vec2(0.0, 0.0);
        tmpvar_88.x = ((tmpvar_79 + tmpvar_77) / RES_NU);
        tmpvar_88.y = ((uMu_66 / RES_R) + tmpvar_82);
        lowp vec4 tmpvar_89;
        tmpvar_89 = textureLod (_Inscatter, tmpvar_88.xy, 0.0);
        highp vec4 tmpvar_90;
        tmpvar_90.zw = vec2(0.0, 0.0);
        tmpvar_90.x = (((tmpvar_79 + tmpvar_77) + 1.0) / RES_NU);
        tmpvar_90.y = ((uMu_66 / RES_R) + tmpvar_82);
        lowp vec4 tmpvar_91;
        tmpvar_91 = textureLod (_Inscatter, tmpvar_90.xy, 0.0);
        inScatter0_62 = ((((tmpvar_85 * (1.0 - tmpvar_80)) + (tmpvar_87 * tmpvar_80)) * (1.0 - tmpvar_83)) + (((tmpvar_89 * (1.0 - tmpvar_80)) + (tmpvar_91 * tmpvar_80)) * tmpvar_83));
        highp float uMu_92;
        highp float uR_93;
        highp float tmpvar_94;
        tmpvar_94 = sqrt(((Rt * Rt) - (Rg * Rg)));
        highp float tmpvar_95;
        tmpvar_95 = sqrt(((tmpvar_65 * tmpvar_65) - (Rg * Rg)));
        highp float tmpvar_96;
        tmpvar_96 = (tmpvar_65 * mu1_31);
        highp float tmpvar_97;
        tmpvar_97 = (((tmpvar_96 * tmpvar_96) - (tmpvar_65 * tmpvar_65)) + (Rg * Rg));
        highp vec4 tmpvar_98;
        if (((tmpvar_96 < 0.0) && (tmpvar_97 > 0.0))) {
          highp vec4 tmpvar_99;
          tmpvar_99.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_99.w = (0.5 - (0.5 / RES_MU));
          tmpvar_98 = tmpvar_99;
        } else {
          highp vec4 tmpvar_100;
          tmpvar_100.x = -1.0;
          tmpvar_100.y = (tmpvar_94 * tmpvar_94);
          tmpvar_100.z = tmpvar_94;
          tmpvar_100.w = (0.5 + (0.5 / RES_MU));
          tmpvar_98 = tmpvar_100;
        };
        uR_93 = ((0.5 / RES_R) + ((tmpvar_95 / tmpvar_94) * (1.0 - (1.0/(RES_R)))));
        uMu_92 = (tmpvar_98.w + ((((tmpvar_96 * tmpvar_98.x) + sqrt((tmpvar_97 + tmpvar_98.y))) / (tmpvar_95 + tmpvar_98.z)) * (0.5 - (1.0/(RES_MU)))));
        highp float y_over_x_101;
        y_over_x_101 = (max (muS1_30, -0.1975) * 5.34962);
        highp float x_102;
        x_102 = (y_over_x_101 * inversesqrt(((y_over_x_101 * y_over_x_101) + 1.0)));
        highp float tmpvar_103;
        tmpvar_103 = ((0.5 / RES_MU_S) + (((((sign(x_102) * (1.5708 - (sqrt((1.0 - abs(x_102))) * (1.5708 + (abs(x_102) * (-0.214602 + (abs(x_102) * (0.0865667 + (abs(x_102) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        highp float tmpvar_104;
        tmpvar_104 = (((tmpvar_34 + 1.0) / 2.0) * (RES_NU - 1.0));
        highp float tmpvar_105;
        tmpvar_105 = floor(tmpvar_104);
        highp float tmpvar_106;
        tmpvar_106 = (tmpvar_104 - tmpvar_105);
        highp float tmpvar_107;
        tmpvar_107 = (floor(((uR_93 * RES_R) - 1.0)) / RES_R);
        highp float tmpvar_108;
        tmpvar_108 = (floor((uR_93 * RES_R)) / RES_R);
        highp float tmpvar_109;
        tmpvar_109 = fract((uR_93 * RES_R));
        highp vec4 tmpvar_110;
        tmpvar_110.zw = vec2(0.0, 0.0);
        tmpvar_110.x = ((tmpvar_105 + tmpvar_103) / RES_NU);
        tmpvar_110.y = ((uMu_92 / RES_R) + tmpvar_107);
        lowp vec4 tmpvar_111;
        tmpvar_111 = textureLod (_Inscatter, tmpvar_110.xy, 0.0);
        highp vec4 tmpvar_112;
        tmpvar_112.zw = vec2(0.0, 0.0);
        tmpvar_112.x = (((tmpvar_105 + tmpvar_103) + 1.0) / RES_NU);
        tmpvar_112.y = ((uMu_92 / RES_R) + tmpvar_107);
        lowp vec4 tmpvar_113;
        tmpvar_113 = textureLod (_Inscatter, tmpvar_112.xy, 0.0);
        highp vec4 tmpvar_114;
        tmpvar_114.zw = vec2(0.0, 0.0);
        tmpvar_114.x = ((tmpvar_105 + tmpvar_103) / RES_NU);
        tmpvar_114.y = ((uMu_92 / RES_R) + tmpvar_108);
        lowp vec4 tmpvar_115;
        tmpvar_115 = textureLod (_Inscatter, tmpvar_114.xy, 0.0);
        highp vec4 tmpvar_116;
        tmpvar_116.zw = vec2(0.0, 0.0);
        tmpvar_116.x = (((tmpvar_105 + tmpvar_103) + 1.0) / RES_NU);
        tmpvar_116.y = ((uMu_92 / RES_R) + tmpvar_108);
        lowp vec4 tmpvar_117;
        tmpvar_117 = textureLod (_Inscatter, tmpvar_116.xy, 0.0);
        inScatterA_61 = max ((inScatter0_62 - (((((tmpvar_111 * (1.0 - tmpvar_106)) + (tmpvar_113 * tmpvar_106)) * (1.0 - tmpvar_109)) + (((tmpvar_115 * (1.0 - tmpvar_106)) + (tmpvar_117 * tmpvar_106)) * tmpvar_109)) * extinction_16.xyzx)), vec4(0.0, 0.0, 0.0, 0.0));
        highp float tmpvar_118;
        tmpvar_118 = (tmpvar_59 + 0.004);
        mu_17 = tmpvar_118;
        highp float tmpvar_119;
        tmpvar_119 = sqrt((((r_19 * r_19) + (d_20 * d_20)) + (((2.0 * r_19) * d_20) * tmpvar_118)));
        r1_32 = tmpvar_119;
        mu1_31 = (((r_19 * tmpvar_118) + d_20) / tmpvar_119);
        highp float uMu_120;
        highp float uR_121;
        highp float tmpvar_122;
        tmpvar_122 = sqrt(((Rt * Rt) - (Rg * Rg)));
        highp float tmpvar_123;
        tmpvar_123 = sqrt(((r_19 * r_19) - (Rg * Rg)));
        highp float tmpvar_124;
        tmpvar_124 = (r_19 * tmpvar_118);
        highp float tmpvar_125;
        tmpvar_125 = (((tmpvar_124 * tmpvar_124) - (r_19 * r_19)) + (Rg * Rg));
        highp vec4 tmpvar_126;
        if (((tmpvar_124 < 0.0) && (tmpvar_125 > 0.0))) {
          highp vec4 tmpvar_127;
          tmpvar_127.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_127.w = (0.5 - (0.5 / RES_MU));
          tmpvar_126 = tmpvar_127;
        } else {
          highp vec4 tmpvar_128;
          tmpvar_128.x = -1.0;
          tmpvar_128.y = (tmpvar_122 * tmpvar_122);
          tmpvar_128.z = tmpvar_122;
          tmpvar_128.w = (0.5 + (0.5 / RES_MU));
          tmpvar_126 = tmpvar_128;
        };
        uR_121 = ((0.5 / RES_R) + ((tmpvar_123 / tmpvar_122) * (1.0 - (1.0/(RES_R)))));
        uMu_120 = (tmpvar_126.w + ((((tmpvar_124 * tmpvar_126.x) + sqrt((tmpvar_125 + tmpvar_126.y))) / (tmpvar_123 + tmpvar_126.z)) * (0.5 - (1.0/(RES_MU)))));
        highp float y_over_x_129;
        y_over_x_129 = (max (tmpvar_35, -0.1975) * 5.34962);
        highp float x_130;
        x_130 = (y_over_x_129 * inversesqrt(((y_over_x_129 * y_over_x_129) + 1.0)));
        highp float tmpvar_131;
        tmpvar_131 = ((0.5 / RES_MU_S) + (((((sign(x_130) * (1.5708 - (sqrt((1.0 - abs(x_130))) * (1.5708 + (abs(x_130) * (-0.214602 + (abs(x_130) * (0.0865667 + (abs(x_130) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        highp float tmpvar_132;
        tmpvar_132 = (((tmpvar_34 + 1.0) / 2.0) * (RES_NU - 1.0));
        highp float tmpvar_133;
        tmpvar_133 = floor(tmpvar_132);
        highp float tmpvar_134;
        tmpvar_134 = (tmpvar_132 - tmpvar_133);
        highp float tmpvar_135;
        tmpvar_135 = (floor(((uR_121 * RES_R) - 1.0)) / RES_R);
        highp float tmpvar_136;
        tmpvar_136 = (floor((uR_121 * RES_R)) / RES_R);
        highp float tmpvar_137;
        tmpvar_137 = fract((uR_121 * RES_R));
        highp vec4 tmpvar_138;
        tmpvar_138.zw = vec2(0.0, 0.0);
        tmpvar_138.x = ((tmpvar_133 + tmpvar_131) / RES_NU);
        tmpvar_138.y = ((uMu_120 / RES_R) + tmpvar_135);
        lowp vec4 tmpvar_139;
        tmpvar_139 = textureLod (_Inscatter, tmpvar_138.xy, 0.0);
        highp vec4 tmpvar_140;
        tmpvar_140.zw = vec2(0.0, 0.0);
        tmpvar_140.x = (((tmpvar_133 + tmpvar_131) + 1.0) / RES_NU);
        tmpvar_140.y = ((uMu_120 / RES_R) + tmpvar_135);
        lowp vec4 tmpvar_141;
        tmpvar_141 = textureLod (_Inscatter, tmpvar_140.xy, 0.0);
        highp vec4 tmpvar_142;
        tmpvar_142.zw = vec2(0.0, 0.0);
        tmpvar_142.x = ((tmpvar_133 + tmpvar_131) / RES_NU);
        tmpvar_142.y = ((uMu_120 / RES_R) + tmpvar_136);
        lowp vec4 tmpvar_143;
        tmpvar_143 = textureLod (_Inscatter, tmpvar_142.xy, 0.0);
        highp vec4 tmpvar_144;
        tmpvar_144.zw = vec2(0.0, 0.0);
        tmpvar_144.x = (((tmpvar_133 + tmpvar_131) + 1.0) / RES_NU);
        tmpvar_144.y = ((uMu_120 / RES_R) + tmpvar_136);
        lowp vec4 tmpvar_145;
        tmpvar_145 = textureLod (_Inscatter, tmpvar_144.xy, 0.0);
        inScatter0_62 = ((((tmpvar_139 * (1.0 - tmpvar_134)) + (tmpvar_141 * tmpvar_134)) * (1.0 - tmpvar_137)) + (((tmpvar_143 * (1.0 - tmpvar_134)) + (tmpvar_145 * tmpvar_134)) * tmpvar_137));
        highp float uMu_146;
        highp float uR_147;
        highp float tmpvar_148;
        tmpvar_148 = sqrt(((Rt * Rt) - (Rg * Rg)));
        highp float tmpvar_149;
        tmpvar_149 = sqrt(((tmpvar_119 * tmpvar_119) - (Rg * Rg)));
        highp float tmpvar_150;
        tmpvar_150 = (tmpvar_119 * mu1_31);
        highp float tmpvar_151;
        tmpvar_151 = (((tmpvar_150 * tmpvar_150) - (tmpvar_119 * tmpvar_119)) + (Rg * Rg));
        highp vec4 tmpvar_152;
        if (((tmpvar_150 < 0.0) && (tmpvar_151 > 0.0))) {
          highp vec4 tmpvar_153;
          tmpvar_153.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_153.w = (0.5 - (0.5 / RES_MU));
          tmpvar_152 = tmpvar_153;
        } else {
          highp vec4 tmpvar_154;
          tmpvar_154.x = -1.0;
          tmpvar_154.y = (tmpvar_148 * tmpvar_148);
          tmpvar_154.z = tmpvar_148;
          tmpvar_154.w = (0.5 + (0.5 / RES_MU));
          tmpvar_152 = tmpvar_154;
        };
        uR_147 = ((0.5 / RES_R) + ((tmpvar_149 / tmpvar_148) * (1.0 - (1.0/(RES_R)))));
        uMu_146 = (tmpvar_152.w + ((((tmpvar_150 * tmpvar_152.x) + sqrt((tmpvar_151 + tmpvar_152.y))) / (tmpvar_149 + tmpvar_152.z)) * (0.5 - (1.0/(RES_MU)))));
        highp float y_over_x_155;
        y_over_x_155 = (max (muS1_30, -0.1975) * 5.34962);
        highp float x_156;
        x_156 = (y_over_x_155 * inversesqrt(((y_over_x_155 * y_over_x_155) + 1.0)));
        highp float tmpvar_157;
        tmpvar_157 = ((0.5 / RES_MU_S) + (((((sign(x_156) * (1.5708 - (sqrt((1.0 - abs(x_156))) * (1.5708 + (abs(x_156) * (-0.214602 + (abs(x_156) * (0.0865667 + (abs(x_156) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        highp float tmpvar_158;
        tmpvar_158 = (((tmpvar_34 + 1.0) / 2.0) * (RES_NU - 1.0));
        highp float tmpvar_159;
        tmpvar_159 = floor(tmpvar_158);
        highp float tmpvar_160;
        tmpvar_160 = (tmpvar_158 - tmpvar_159);
        highp float tmpvar_161;
        tmpvar_161 = (floor(((uR_147 * RES_R) - 1.0)) / RES_R);
        highp float tmpvar_162;
        tmpvar_162 = (floor((uR_147 * RES_R)) / RES_R);
        highp float tmpvar_163;
        tmpvar_163 = fract((uR_147 * RES_R));
        highp vec4 tmpvar_164;
        tmpvar_164.zw = vec2(0.0, 0.0);
        tmpvar_164.x = ((tmpvar_159 + tmpvar_157) / RES_NU);
        tmpvar_164.y = ((uMu_146 / RES_R) + tmpvar_161);
        lowp vec4 tmpvar_165;
        tmpvar_165 = textureLod (_Inscatter, tmpvar_164.xy, 0.0);
        highp vec4 tmpvar_166;
        tmpvar_166.zw = vec2(0.0, 0.0);
        tmpvar_166.x = (((tmpvar_159 + tmpvar_157) + 1.0) / RES_NU);
        tmpvar_166.y = ((uMu_146 / RES_R) + tmpvar_161);
        lowp vec4 tmpvar_167;
        tmpvar_167 = textureLod (_Inscatter, tmpvar_166.xy, 0.0);
        highp vec4 tmpvar_168;
        tmpvar_168.zw = vec2(0.0, 0.0);
        tmpvar_168.x = ((tmpvar_159 + tmpvar_157) / RES_NU);
        tmpvar_168.y = ((uMu_146 / RES_R) + tmpvar_162);
        lowp vec4 tmpvar_169;
        tmpvar_169 = textureLod (_Inscatter, tmpvar_168.xy, 0.0);
        highp vec4 tmpvar_170;
        tmpvar_170.zw = vec2(0.0, 0.0);
        tmpvar_170.x = (((tmpvar_159 + tmpvar_157) + 1.0) / RES_NU);
        tmpvar_170.y = ((uMu_146 / RES_R) + tmpvar_162);
        lowp vec4 tmpvar_171;
        tmpvar_171 = textureLod (_Inscatter, tmpvar_170.xy, 0.0);
        inScatter_33 = mix (inScatterA_61, max ((inScatter0_62 - (((((tmpvar_165 * (1.0 - tmpvar_160)) + (tmpvar_167 * tmpvar_160)) * (1.0 - tmpvar_163)) + (((tmpvar_169 * (1.0 - tmpvar_160)) + (tmpvar_171 * tmpvar_160)) * tmpvar_163)) * extinction_16.xyzx)), vec4(0.0, 0.0, 0.0, 0.0)), vec4(a_63));
      } else {
        highp vec4 inScatter0_1_172;
        highp float uMu_173;
        highp float uR_174;
        highp float tmpvar_175;
        tmpvar_175 = sqrt(((Rt * Rt) - (Rg * Rg)));
        highp float tmpvar_176;
        tmpvar_176 = sqrt(((r_19 * r_19) - (Rg * Rg)));
        highp float tmpvar_177;
        tmpvar_177 = (r_19 * mu_17);
        highp float tmpvar_178;
        tmpvar_178 = (((tmpvar_177 * tmpvar_177) - (r_19 * r_19)) + (Rg * Rg));
        highp vec4 tmpvar_179;
        if (((tmpvar_177 < 0.0) && (tmpvar_178 > 0.0))) {
          highp vec4 tmpvar_180;
          tmpvar_180.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_180.w = (0.5 - (0.5 / RES_MU));
          tmpvar_179 = tmpvar_180;
        } else {
          highp vec4 tmpvar_181;
          tmpvar_181.x = -1.0;
          tmpvar_181.y = (tmpvar_175 * tmpvar_175);
          tmpvar_181.z = tmpvar_175;
          tmpvar_181.w = (0.5 + (0.5 / RES_MU));
          tmpvar_179 = tmpvar_181;
        };
        uR_174 = ((0.5 / RES_R) + ((tmpvar_176 / tmpvar_175) * (1.0 - (1.0/(RES_R)))));
        uMu_173 = (tmpvar_179.w + ((((tmpvar_177 * tmpvar_179.x) + sqrt((tmpvar_178 + tmpvar_179.y))) / (tmpvar_176 + tmpvar_179.z)) * (0.5 - (1.0/(RES_MU)))));
        highp float y_over_x_182;
        y_over_x_182 = (max (tmpvar_35, -0.1975) * 5.34962);
        highp float x_183;
        x_183 = (y_over_x_182 * inversesqrt(((y_over_x_182 * y_over_x_182) + 1.0)));
        highp float tmpvar_184;
        tmpvar_184 = ((0.5 / RES_MU_S) + (((((sign(x_183) * (1.5708 - (sqrt((1.0 - abs(x_183))) * (1.5708 + (abs(x_183) * (-0.214602 + (abs(x_183) * (0.0865667 + (abs(x_183) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        highp float tmpvar_185;
        tmpvar_185 = (((tmpvar_34 + 1.0) / 2.0) * (RES_NU - 1.0));
        highp float tmpvar_186;
        tmpvar_186 = floor(tmpvar_185);
        highp float tmpvar_187;
        tmpvar_187 = (tmpvar_185 - tmpvar_186);
        highp float tmpvar_188;
        tmpvar_188 = (floor(((uR_174 * RES_R) - 1.0)) / RES_R);
        highp float tmpvar_189;
        tmpvar_189 = (floor((uR_174 * RES_R)) / RES_R);
        highp float tmpvar_190;
        tmpvar_190 = fract((uR_174 * RES_R));
        highp vec4 tmpvar_191;
        tmpvar_191.zw = vec2(0.0, 0.0);
        tmpvar_191.x = ((tmpvar_186 + tmpvar_184) / RES_NU);
        tmpvar_191.y = ((uMu_173 / RES_R) + tmpvar_188);
        lowp vec4 tmpvar_192;
        tmpvar_192 = textureLod (_Inscatter, tmpvar_191.xy, 0.0);
        highp vec4 tmpvar_193;
        tmpvar_193.zw = vec2(0.0, 0.0);
        tmpvar_193.x = (((tmpvar_186 + tmpvar_184) + 1.0) / RES_NU);
        tmpvar_193.y = ((uMu_173 / RES_R) + tmpvar_188);
        lowp vec4 tmpvar_194;
        tmpvar_194 = textureLod (_Inscatter, tmpvar_193.xy, 0.0);
        highp vec4 tmpvar_195;
        tmpvar_195.zw = vec2(0.0, 0.0);
        tmpvar_195.x = ((tmpvar_186 + tmpvar_184) / RES_NU);
        tmpvar_195.y = ((uMu_173 / RES_R) + tmpvar_189);
        lowp vec4 tmpvar_196;
        tmpvar_196 = textureLod (_Inscatter, tmpvar_195.xy, 0.0);
        highp vec4 tmpvar_197;
        tmpvar_197.zw = vec2(0.0, 0.0);
        tmpvar_197.x = (((tmpvar_186 + tmpvar_184) + 1.0) / RES_NU);
        tmpvar_197.y = ((uMu_173 / RES_R) + tmpvar_189);
        lowp vec4 tmpvar_198;
        tmpvar_198 = textureLod (_Inscatter, tmpvar_197.xy, 0.0);
        inScatter0_1_172 = ((((tmpvar_192 * (1.0 - tmpvar_187)) + (tmpvar_194 * tmpvar_187)) * (1.0 - tmpvar_190)) + (((tmpvar_196 * (1.0 - tmpvar_187)) + (tmpvar_198 * tmpvar_187)) * tmpvar_190));
        highp float uMu_199;
        highp float uR_200;
        highp float tmpvar_201;
        tmpvar_201 = sqrt(((Rt * Rt) - (Rg * Rg)));
        highp float tmpvar_202;
        tmpvar_202 = sqrt(((r1_32 * r1_32) - (Rg * Rg)));
        highp float tmpvar_203;
        tmpvar_203 = (r1_32 * mu1_31);
        highp float tmpvar_204;
        tmpvar_204 = (((tmpvar_203 * tmpvar_203) - (r1_32 * r1_32)) + (Rg * Rg));
        highp vec4 tmpvar_205;
        if (((tmpvar_203 < 0.0) && (tmpvar_204 > 0.0))) {
          highp vec4 tmpvar_206;
          tmpvar_206.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_206.w = (0.5 - (0.5 / RES_MU));
          tmpvar_205 = tmpvar_206;
        } else {
          highp vec4 tmpvar_207;
          tmpvar_207.x = -1.0;
          tmpvar_207.y = (tmpvar_201 * tmpvar_201);
          tmpvar_207.z = tmpvar_201;
          tmpvar_207.w = (0.5 + (0.5 / RES_MU));
          tmpvar_205 = tmpvar_207;
        };
        uR_200 = ((0.5 / RES_R) + ((tmpvar_202 / tmpvar_201) * (1.0 - (1.0/(RES_R)))));
        uMu_199 = (tmpvar_205.w + ((((tmpvar_203 * tmpvar_205.x) + sqrt((tmpvar_204 + tmpvar_205.y))) / (tmpvar_202 + tmpvar_205.z)) * (0.5 - (1.0/(RES_MU)))));
        highp float y_over_x_208;
        y_over_x_208 = (max (muS1_30, -0.1975) * 5.34962);
        highp float x_209;
        x_209 = (y_over_x_208 * inversesqrt(((y_over_x_208 * y_over_x_208) + 1.0)));
        highp float tmpvar_210;
        tmpvar_210 = ((0.5 / RES_MU_S) + (((((sign(x_209) * (1.5708 - (sqrt((1.0 - abs(x_209))) * (1.5708 + (abs(x_209) * (-0.214602 + (abs(x_209) * (0.0865667 + (abs(x_209) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        highp float tmpvar_211;
        tmpvar_211 = (((tmpvar_34 + 1.0) / 2.0) * (RES_NU - 1.0));
        highp float tmpvar_212;
        tmpvar_212 = floor(tmpvar_211);
        highp float tmpvar_213;
        tmpvar_213 = (tmpvar_211 - tmpvar_212);
        highp float tmpvar_214;
        tmpvar_214 = (floor(((uR_200 * RES_R) - 1.0)) / RES_R);
        highp float tmpvar_215;
        tmpvar_215 = (floor((uR_200 * RES_R)) / RES_R);
        highp float tmpvar_216;
        tmpvar_216 = fract((uR_200 * RES_R));
        highp vec4 tmpvar_217;
        tmpvar_217.zw = vec2(0.0, 0.0);
        tmpvar_217.x = ((tmpvar_212 + tmpvar_210) / RES_NU);
        tmpvar_217.y = ((uMu_199 / RES_R) + tmpvar_214);
        lowp vec4 tmpvar_218;
        tmpvar_218 = textureLod (_Inscatter, tmpvar_217.xy, 0.0);
        highp vec4 tmpvar_219;
        tmpvar_219.zw = vec2(0.0, 0.0);
        tmpvar_219.x = (((tmpvar_212 + tmpvar_210) + 1.0) / RES_NU);
        tmpvar_219.y = ((uMu_199 / RES_R) + tmpvar_214);
        lowp vec4 tmpvar_220;
        tmpvar_220 = textureLod (_Inscatter, tmpvar_219.xy, 0.0);
        highp vec4 tmpvar_221;
        tmpvar_221.zw = vec2(0.0, 0.0);
        tmpvar_221.x = ((tmpvar_212 + tmpvar_210) / RES_NU);
        tmpvar_221.y = ((uMu_199 / RES_R) + tmpvar_215);
        lowp vec4 tmpvar_222;
        tmpvar_222 = textureLod (_Inscatter, tmpvar_221.xy, 0.0);
        highp vec4 tmpvar_223;
        tmpvar_223.zw = vec2(0.0, 0.0);
        tmpvar_223.x = (((tmpvar_212 + tmpvar_210) + 1.0) / RES_NU);
        tmpvar_223.y = ((uMu_199 / RES_R) + tmpvar_215);
        lowp vec4 tmpvar_224;
        tmpvar_224 = textureLod (_Inscatter, tmpvar_223.xy, 0.0);
        inScatter_33 = max ((inScatter0_1_172 - (((((tmpvar_218 * (1.0 - tmpvar_213)) + (tmpvar_220 * tmpvar_213)) * (1.0 - tmpvar_216)) + (((tmpvar_222 * (1.0 - tmpvar_213)) + (tmpvar_224 * tmpvar_213)) * tmpvar_216)) * extinction_16.xyzx)), vec4(0.0, 0.0, 0.0, 0.0));
      };
      highp float t_225;
      t_225 = max (min ((tmpvar_35 / 0.02), 1.0), 0.0);
      inScatter_33.w = (inScatter_33.w * (t_225 * (t_225 * (3.0 - (2.0 * t_225)))));
      result_21 = ((inScatter_33.xyz * ((3.0 / (16.0 * M_PI)) * (1.0 + (tmpvar_34 * tmpvar_34)))) + ((((inScatter_33.xyz * inScatter_33.w) / max (inScatter_33.x, 0.0001)) * (betaR.x / betaR)) * (((((1.5 / (4.0 * M_PI)) * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_34)), -1.5)) * (1.0 + (tmpvar_34 * tmpvar_34))) / (2.0 + (mieG * mieG)))));
    };
    tmpvar_13 = (result_21 * SUN_INTENSITY);
    visib_2 = 1.0;
    if ((tmpvar_7 <= _global_depth)) {
      visib_2 = (1.0 - exp((-1.0 * ((4.0 * tmpvar_7) / _global_depth))));
    };
    highp vec3 L_226;
    highp vec3 tmpvar_227;
    tmpvar_227 = (tmpvar_13 * _Exposure);
    L_226 = tmpvar_227;
    highp float tmpvar_228;
    if ((tmpvar_227.x < 1.413)) {
      tmpvar_228 = pow ((tmpvar_227.x * 0.38317), 0.454545);
    } else {
      tmpvar_228 = (1.0 - exp(-(tmpvar_227.x)));
    };
    L_226.x = tmpvar_228;
    highp float tmpvar_229;
    if ((tmpvar_227.y < 1.413)) {
      tmpvar_229 = pow ((tmpvar_227.y * 0.38317), 0.454545);
    } else {
      tmpvar_229 = (1.0 - exp(-(tmpvar_227.y)));
    };
    L_226.y = tmpvar_229;
    highp float tmpvar_230;
    if ((tmpvar_227.z < 1.413)) {
      tmpvar_230 = pow ((tmpvar_227.z * 0.38317), 0.454545);
    } else {
      tmpvar_230 = (1.0 - exp(-(tmpvar_227.z)));
    };
    L_226.z = tmpvar_230;
    highp vec4 tmpvar_231;
    tmpvar_231.xyz = L_226;
    tmpvar_231.w = (_global_alpha * visib_2);
    tmpvar_1 = tmpvar_231;
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
// Stats: 735 math, 57 textures, 6 branches
Matrix 0 [_ViewProjInv]
Vector 4 [_ZBufferParams]
Float 5 [M_PI]
Float 6 [Rg]
Float 7 [Rt]
Float 8 [RES_R]
Float 9 [RES_MU]
Float 10 [RES_MU_S]
Float 11 [RES_NU]
Vector 12 [SUN_DIR]
Float 13 [SUN_INTENSITY]
Vector 14 [betaR]
Float 15 [mieG]
Float 16 [_Scale]
Float 17 [_global_alpha]
Float 18 [_Exposure]
Float 19 [_global_depth]
Float 20 [_global_depth2]
Vector 21 [_inCamPos]
Vector 22 [_Globals_Origin]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_Transmittance] 2D 1
SetTexture 2 [_Inscatter] 2D 2
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c23, -1.00000000, 0.00000000, 1.00000000, 2.00000000
def c24, 0.89999998, 600.00000000, 0.15000001, 12.26193905
def c25, -0.01348047, 0.05747731, -0.12123910, 0.19563590
def c26, -0.33299461, 0.99999559, 1.57079601, 0.66666669
def c27, 0.00400000, -0.19750001, 5.34960032, 0.50000000
def c28, 0.90909088, 0.74000001, -0.00400000, 124.99999237
def c29, 16.00000000, 4.00000000, -1.50000000, 50.00000000
def c30, 2.00000000, 3.00000000, 0.00010000, 1.50000000
def c31, 2.71828198, 0.38317001, 0.45454544, -1.41299999
dcl_texcoord2 v0.xy
texld r0.x, v0, s0
mad r0.w, r0.x, c4.x, c4.y
rcp r0.w, r0.w
mov r2.z, r0.x
mad r2.xy, v0, c23.w, c23.x
mov r2.w, c23.z
dp4 r0.z, r2, c2
dp4 r0.y, r2, c1
dp4 r0.x, r2, c0
dp4 r2.x, r2, c3
mul r7.w, r0, c20.x
rcp r0.w, r2.x
add r2.x, r7.w, c23
mul r0.xyz, r0, r0.w
cmp_pp r0.w, r2.x, c23.y, c23.z
cmp_pp oC0, r2.x, c23.y, r1
if_gt r0.w, c23.y
mov r1.xyz, c21
add r1.xyz, -c22, r1
mul r3.xyz, r1, c16.x
dp3 r0.w, r3, r3
mul r2.xyz, r0, c16.x
rsq r0.w, r0.w
rcp r1.w, r0.w
mov r0.w, c6.x
add r0.xyz, -r3, r2
mad r0.w, c24.x, -r0, r1
add r1.x, r3.y, c6
cmp r1.y, r0.w, r3, r1.x
mov r1.xz, r3
dp3 r2.w, r1, r1
rsq r3.x, r2.w
dp3 r2.w, r0, r0
rsq r2.w, r2.w
rcp r3.x, r3.x
cmp r3.x, r0.w, r1.w, r3
mul r0.xyz, r2.w, r0
dp3 r1.w, r1, r0
mul r3.y, r3.x, r3.x
mad r3.y, r1.w, r1.w, -r3
mad r3.y, c7.x, c7.x, r3
rsq r3.y, r3.y
rcp r3.y, r3.y
rcp r3.z, r2.w
add r3.y, -r1.w, -r3
max r2.w, r3.y, c23.y
add r3.y, r2.w, -r3.z
cmp r3.w, r3.y, c23.y, c23.z
cmp r3.y, -r2.w, c23, c23.z
mul_pp r3.y, r3, r3.w
mad r4.xyz, r2.w, r0, r1
add r3.w, -r2, r3.z
cmp r1.xyz, -r3.y, r1, r4
cmp r10.y, -r3, r3.z, r3.w
add r3.w, r2, r1
rcp r2.w, r3.x
mul r1.w, r1, r2
rcp r4.x, c7.x
mul r3.w, r3, r4.x
cmp r8.w, -r3.y, r1, r3
add r2.w, r2.y, c6.x
cmp r10.z, -r3.y, r3.x, c7.x
mov_sat r1.w, r3.z
cmp r2.y, r0.w, r2, r2.w
mad r2.xyz, -r0, r1.w, r2
mov r3.xyz, c23.y
if_le r10.z, c7.x
mov r0.w, c6.x
add r2.w, c24.y, r0
rcp r1.w, r10.z
mul r0.w, r1, r2
add r3.x, r10.z, -r2.w
mul r4.xyz, r2, r0.w
cmp r2.xyz, r3.x, r2, r4
dp3 r0.w, r2, r2
rsq r0.w, r0.w
dp3 r3.y, r2, c12
dp3 r2.x, r0, r2
dp3 r9.w, r0, c12
mul r5.z, r0.w, r2.x
mul r5.w, r0, r3.y
rcp r8.z, r0.w
dp3 r0.w, r1, c12
mul r10.w, r0, r1
cmp r10.z, r3.x, r10, r2.w
if_gt r8.w, c23.y
add r0.x, r5.z, c24.z
mul r1.x, r0, c24.w
abs r1.y, r1.x
max r0.x, r1.y, c23.z
rcp r0.y, r0.x
min r0.x, r1.y, c23.z
mul r0.z, r0.x, r0.y
mul r0.y, r0.z, r0.z
mad r0.w, r0.y, c25.x, c25.y
mad r1.z, r0.w, r0.y, c25
add r0.x, r8.w, c24.z
mul r0.w, r0.x, c24
mad r0.x, r1.z, r0.y, c25.w
mad r1.z, r0.x, r0.y, c26.x
abs r1.w, r0
mad r1.z, r1, r0.y, c26.y
mul r1.z, r1, r0
max r0.x, r1.w, c23.z
rcp r0.y, r0.x
min r0.x, r1.w, c23.z
mul r0.y, r0.x, r0
mul r0.z, r0.y, r0.y
mad r0.x, r0.z, c25, c25.y
mad r0.x, r0, r0.z, c25.z
add r2.x, -r1.z, c26.z
add r1.y, r1, c23.x
cmp r1.y, -r1, r1.z, r2.x
cmp r1.y, r1.x, r1, -r1
mad r1.x, r0, r0.z, c25.w
mad r1.x, r1, r0.z, c26
mul r0.x, r1.y, c26.w
mad r0.z, r1.x, r0, c26.y
mul r2.x, r0.z, r0.y
mov r1.y, c7.x
add r1.x, -c6, r1.y
rcp r2.y, r1.x
add r1.y, r8.z, -c6.x
mul r1.x, r2.y, r1.y
rsq r0.y, r1.x
mov r0.z, c23.y
rcp r0.y, r0.y
texldl r1.xyz, r0.xyzz, s1
add r0.y, -r2.x, c26.z
add r0.x, r1.w, c23
cmp r0.x, -r0, r2, r0.y
add r0.y, r10.z, -c6.x
cmp r0.x, r0.w, r0, -r0
mul r0.y, r0, r2
rsq r0.y, r0.y
mul r0.x, r0, c26.w
mov r0.z, c23.y
rcp r0.y, r0.y
texldl r0.xyz, r0.xyzz, s1
rcp r1.x, r1.x
rcp r1.z, r1.z
rcp r1.y, r1.y
mul r0.xyz, r0, r1
min r7.xyz, r0, c23.z
else
add r0.x, -r8.w, c24.z
mul r1.x, r0, c24.w
abs r1.y, r1.x
max r0.x, r1.y, c23.z
rcp r0.y, r0.x
min r0.x, r1.y, c23.z
mul r0.z, r0.x, r0.y
mul r0.y, r0.z, r0.z
mad r0.w, r0.y, c25.x, c25.y
mad r1.z, r0.w, r0.y, c25
add r0.x, -r5.z, c24.z
mul r0.w, r0.x, c24
mad r0.x, r1.z, r0.y, c25.w
mad r1.z, r0.x, r0.y, c26.x
abs r1.w, r0
mad r1.z, r1, r0.y, c26.y
mul r1.z, r1, r0
max r0.x, r1.w, c23.z
rcp r0.y, r0.x
min r0.x, r1.w, c23.z
mul r0.y, r0.x, r0
mul r0.z, r0.y, r0.y
mad r0.x, r0.z, c25, c25.y
mad r0.x, r0, r0.z, c25.z
add r2.x, -r1.z, c26.z
add r1.y, r1, c23.x
cmp r1.y, -r1, r1.z, r2.x
cmp r1.y, r1.x, r1, -r1
mad r1.x, r0, r0.z, c25.w
mad r1.x, r1, r0.z, c26
mul r0.x, r1.y, c26.w
mad r0.z, r1.x, r0, c26.y
mul r2.x, r0.z, r0.y
mov r1.y, c7.x
add r1.x, -c6, r1.y
rcp r2.y, r1.x
add r1.y, r10.z, -c6.x
mul r1.x, r2.y, r1.y
rsq r0.y, r1.x
mov r0.z, c23.y
rcp r0.y, r0.y
texldl r1.xyz, r0.xyzz, s1
add r0.y, -r2.x, c26.z
add r0.x, r1.w, c23
cmp r0.x, -r0, r2, r0.y
add r0.y, r8.z, -c6.x
cmp r0.x, r0.w, r0, -r0
mul r0.y, r0, r2
rsq r0.y, r0.y
mul r0.x, r0, c26.w
mov r0.z, c23.y
rcp r0.y, r0.y
texldl r0.xyz, r0.xyzz, s1
rcp r1.x, r1.x
rcp r1.z, r1.z
rcp r1.y, r1.y
mul r0.xyz, r0, r1
min r7.xyz, r0, c23.z
endif
rcp r0.x, r10.z
mul r0.x, r0, c6
mad r0.x, -r0, r0, c23.z
rsq r0.x, r0.x
rcp r0.x, r0.x
add r0.y, r0.x, r8.w
abs r0.y, r0
mov r11.w, -r0.x
if_lt r0.y, c27.x
rcp r1.w, c9.x
rcp r11.y, c8.x
mul r11.z, c6.x, c6.x
add r8.y, r11.w, c27.x
rcp r6.y, c10.x
mul r0.x, r10.y, r10.y
mad r0.z, c7.x, c7.x, -r11
add r14.x, r11.w, c28.z
mov r2.xyz, c23.zyyw
mad r2.w, -r1, c27, c27
mad r3.w, r1, c27, c27
mad r0.y, r10.z, r8, r10
rsq r12.z, r0.z
mov r3.x, c23
add r12.w, -r1, c27
mul r9.z, r10, r14.x
mad r13.y, r10.z, r10.z, r0.x
mul r13.z, r10, r10.y
mul r0.x, r13.z, r8.y
mad r0.x, r0, c23.w, r13.y
rsq r0.x, r0.x
rcp r1.x, r0.x
mul r0.x, r0, r0.y
mul r1.y, r1.x, r0.x
mul r0.y, r1.x, r1.x
mad r0.y, r1, r1, -r0
mad r1.z, c6.x, c6.x, r0.y
mad r1.x, r1, r1, -r11.z
rsq r1.x, r1.x
add r13.x, -r11.y, c23.z
add r6.z, -r6.y, c23
mul r6.x, r10.z, r10.z
cmp r0.y, -r1.z, c23, c23.z
cmp r0.x, r1.y, c23.y, c23.z
mul_pp r0.x, r0, r0.y
rcp r0.y, r12.z
mul r3.y, r0, r0
mov r3.z, r0.y
cmp r0, -r0.x, r3, r2
add r0.y, r0, r1.z
rcp r1.x, r1.x
rsq r0.y, r0.y
rcp r0.y, r0.y
add r0.z, r0, r1.x
mad r0.x, r1.y, r0, r0.y
rcp r0.y, r0.z
mul r0.x, r0, r0.y
max r0.y, r5.w, c27
mad r0.x, r0, r12.w, r0.w
mul r0.z, r12, r1.x
mul r0.w, r0.z, r13.x
mad r1.x, r11.y, c27.w, r0.w
mul r1.z, r1.x, c8.x
frc r8.x, r1.z
add r1.w, r1.z, -r8.x
mul r1.w, r11.y, r1
mul r0.y, r0, c27.z
abs r0.z, r0.y
max r0.w, r0.z, c23.z
rcp r1.x, r0.w
min r0.w, r0.z, c23.z
mul r0.w, r0, r1.x
mul r1.x, r0.w, r0.w
mad r1.y, r1.x, c25.x, c25
mad r1.y, r1, r1.x, c25.z
mad r1.y, r1, r1.x, c25.w
mad r1.y, r1, r1.x, c26.x
mad r1.x, r1.y, r1, c26.y
mul r0.w, r1.x, r0
mad r5.y, r0.x, r11, r1.w
add r1.z, r1, c23.x
frc r1.w, r1.z
add r1.y, r1.z, -r1.w
rcp r5.w, c11.x
mul r1.y, r1, r11
add r1.x, -r0.w, c26.z
add r0.z, r0, c23.x
cmp r0.z, -r0, r0.w, r1.x
cmp r0.y, r0, r0.z, -r0.z
mov r0.w, c11.x
mad r0.y, r0, c28.x, c28
mad r0.y, r0, r6.z, r6
add r0.w, c23.x, r0
add r0.z, r9.w, c23
mul r0.z, r0, r0.w
mul r0.z, r0, c27.w
frc r12.x, r0.z
add r6.w, r0.z, -r12.x
mad r0.w, r0.y, c27, r6
mad r0.y, r0.x, r11, r1
add r0.x, r0.w, c23.z
mul r10.x, r5.w, r0
add r12.y, -r12.x, c23.z
mul r11.x, r0.w, r5.w
mov r0.z, c23.y
mov r0.x, r10
texldl r1, r0.xyzz, s2
mul r1, r12.x, r1
mov r5.z, c23.y
mov r5.x, r10
mov r0.z, c23.y
mov r0.x, r11
texldl r0, r0.xyzz, s2
mad r4, r0, r12.y, r1
texldl r1, r5.xyzz, s2
mul r5.x, r10.z, r8.y
mov r0.y, r5
mad r5.y, r5.x, r5.x, -r6.x
mul r1, r12.x, r1
mad r5.y, c6.x, c6.x, r5
mov r0.z, c23.y
mov r0.x, r11
texldl r0, r0.xyzz, s2
mad r0, r12.y, r0, r1
cmp r1.y, -r5, c23, c23.z
cmp r1.x, r5, c23.y, c23.z
mul_pp r5.z, r1.x, r1.y
mul r1, r8.x, r0
cmp r0, -r5.z, r3, r2
add r5.z, -r8.x, c23
mad r4, r4, r5.z, r1
add r1.x, r0.y, r5.y
max r0.y, r10.w, c27
mul r0.y, r0, c27.z
rsq r1.x, r1.x
rcp r1.x, r1.x
abs r1.y, r0
mad r1.w, r5.x, r0.x, r1.x
max r0.x, r1.y, c23.z
rcp r1.x, r0.x
min r0.x, r1.y, c23.z
mul r0.x, r0, r1
mad r1.z, r10, r10, -r11
rsq r1.x, r1.z
rcp r9.y, r1.x
mul r1.z, r0.x, r0.x
add r5.x, r0.z, r9.y
mad r1.x, r1.z, c25, c25.y
mad r0.z, r1.x, r1, c25
mad r0.z, r0, r1, c25.w
mad r0.z, r0, r1, c26.x
mad r0.z, r0, r1, c26.y
rcp r1.x, r5.x
mul r1.x, r1.w, r1
mad r1.x, r12.w, r1, r0.w
mul r0.z, r0, r0.x
mul r0.w, r12.z, r9.y
mul r0.x, r13, r0.w
mad r1.z, r11.y, c27.w, r0.x
add r0.w, -r0.z, c26.z
add r0.x, r1.y, c23
cmp r0.x, -r0, r0.z, r0.w
mul r0.z, r1, c8.x
cmp r0.x, r0.y, r0, -r0
add r0.y, r0.z, c23.x
frc r0.w, r0.y
add r0.y, r0, -r0.w
mul r8.z, r11.y, r0.y
mad r0.x, r0, c28, c28.y
mad r0.x, r6.z, r0, r6.y
mad r6.z, r0.x, c27.w, r6.w
add r0.x, r6.z, c23.z
mul r8.x, r5.w, r0
mul r9.x, r5.w, r6.z
frc r13.w, r0.z
add r0.x, r0.z, -r13.w
mul r8.y, r11, r0.x
mad r5.y, r11, r1.x, r8.z
mad r6.y, r11, r1.x, r8
mov r5.x, r8
mov r5.z, c23.y
texldl r0, r5.xyzz, s2
mul r1, r12.x, r0
mov r0.y, r5
mov r6.z, c23.y
mov r0.z, c23.y
mov r0.x, r9
texldl r0, r0.xyzz, s2
mad r5, r12.y, r0, r1
mad r1.x, r9.z, r9.z, -r6
mad r14.y, c6.x, c6.x, r1.x
cmp r1.x, r9.z, c23.y, c23.z
cmp r1.y, -r14, c23, c23.z
mov r0.y, r6
mov r6.x, r8
mul_pp r6.w, r1.x, r1.y
texldl r1, r6.xyzz, s2
cmp r6, -r6.w, r3, r2
mul r1, r12.x, r1
add r6.y, r6, r14
mov r0.x, r9
mov r0.z, c23.y
texldl r0, r0.xyzz, s2
mad r0, r12.y, r0, r1
add r1.y, r9, r6.z
rsq r1.x, r6.y
rcp r1.x, r1.x
mad r1.x, r9.z, r6, r1
rcp r1.y, r1.y
mul r1.x, r1, r1.y
mad r6.y, r12.w, r1.x, r6.w
mad r8.y, r11, r6, r8
mad r6.w, r10.z, r14.x, r10.y
mul r0, r13.w, r0
add r6.x, -r13.w, c23.z
mad r1, r5, r6.x, r0
mad r5.y, r11, r6, r8.z
mul r6.y, r13.z, r14.x
mad r6.y, r6, c23.w, r13
rsq r6.z, r6.y
rcp r6.y, r6.z
mul r6.z, r6, r6.w
mul r6.z, r6.y, r6
mul r6.w, r6.y, r6.y
mad r6.w, r6.z, r6.z, -r6
mov r5.z, c23.y
mov r5.x, r8
texldl r0, r5.xyzz, s2
mad r4, -r4, r7.xyzx, r1
mul r1, r12.x, r0
mov r0.y, r5
mad r6.w, c6.x, c6.x, r6
mov r0.z, c23.y
mov r0.x, r9
texldl r0, r0.xyzz, s2
mad r5, r12.y, r0, r1
mov r8.z, c23.y
texldl r1, r8.xyzz, s2
mul r1, r12.x, r1
mov r9.z, c23.y
mov r9.y, r8
texldl r0, r9.xyzz, s2
mad r0, r12.y, r0, r1
mul r0, r13.w, r0
mad r0, r6.x, r5, r0
cmp r1.y, -r6.w, c23, c23.z
cmp r1.x, r6.z, c23.y, c23.z
mul_pp r1.x, r1, r1.y
cmp r1, -r1.x, r3, r2
mad r2.x, r6.y, r6.y, -r11.z
add r1.y, r1, r6.w
rsq r2.x, r2.x
rcp r2.x, r2.x
mul r2.y, r12.z, r2.x
rsq r1.y, r1.y
rcp r1.y, r1.y
mad r1.x, r6.z, r1, r1.y
add r1.y, r1.z, r2.x
mul r2.y, r13.x, r2
mad r1.z, r11.y, c27.w, r2.y
mul r1.z, r1, c8.x
rcp r1.y, r1.y
mul r1.x, r1, r1.y
mad r1.x, r12.w, r1, r1.w
frc r5.w, r1.z
add r1.w, r1.z, -r5
add r1.y, r1.z, c23.x
mul r1.w, r11.y, r1
frc r1.z, r1.y
add r1.y, r1, -r1.z
mul r1.y, r11, r1
mad r10.y, r11, r1.x, r1.w
mad r5.y, r11, r1.x, r1
mov r10.z, c23.y
texldl r2, r10.xyzz, s2
mov r5.z, c23.y
mov r5.x, r10
texldl r1, r5.xyzz, s2
mul r2, r12.x, r2
mov r11.z, c23.y
mov r11.y, r10
texldl r3, r11.xyzz, s2
mad r2, r12.y, r3, r2
mul r3, r12.x, r1
mul r2, r5.w, r2
mov r1.y, r5
mov r1.z, c23.y
mov r1.x, r11
texldl r1, r1.xyzz, s2
mad r1, r12.y, r1, r3
add r3.x, -r5.w, c23.z
mad r1, r1, r3.x, r2
mad r0, r7.xyzx, -r1, r0
add r1.x, r8.w, -r11.w
max r0, r0, c23.y
max r2, r4, c23.y
add r2, r2, -r0
add r1.x, r1, c27
mul r1, r1.x, r2
mad r1, r1, c28.w, r0
else
mul r3.y, r10.z, r8.w
rcp r3.x, c9.x
rcp r9.y, c10.x
mul r0.x, r10.z, r10.z
mad r0.x, r3.y, r3.y, -r0
mad r3.z, c6.x, c6.x, r0.x
mul r8.w, c6.x, c6.x
mad r0.x, c7, c7, -r8.w
rsq r9.x, r0.x
rcp r0.w, r9.x
mul r1.y, r0.w, r0.w
mov r1.z, r0.w
mad r1.w, r3.x, c27, c27
rcp r8.x, c11.x
cmp r0.y, r3, c23, c23.z
cmp r0.z, -r3, c23.y, c23
mul_pp r2.x, r0.y, r0.z
mov r1.x, c23
mad r0.w, -r3.x, c27, c27
mov r0.xyz, c23.zyyw
cmp r2, -r2.x, r1, r0
add r2.y, r2, r3.z
mad r3.z, r10, r10, -r8.w
rcp r10.z, c8.x
rsq r2.y, r2.y
rcp r2.y, r2.y
mad r3.y, r3, r2.x, r2
rsq r3.z, r3.z
rcp r3.z, r3.z
add r2.y, r2.z, r3.z
max r2.x, r10.w, c27.y
mul r2.z, r2.x, c27
rcp r2.x, r2.y
abs r2.y, r2.z
mul r3.y, r3, r2.x
add r10.y, -r3.x, c27.w
mad r5.y, r10, r3, r2.w
max r2.x, r2.y, c23.z
rcp r2.w, r2.x
min r2.x, r2.y, c23.z
mul r2.x, r2, r2.w
mul r2.w, r9.x, r3.z
add r11.x, -r10.z, c23.z
mul r3.x, r11, r2.w
mad r3.y, r10.z, c27.w, r3.x
mul r4.x, r3.y, c8
mul r2.w, r2.x, r2.x
add r3.y, r4.x, c23.x
frc r11.y, r4.x
frc r3.z, r3.y
add r3.y, r3, -r3.z
mad r3.x, r2.w, c25, c25.y
mad r3.x, r3, r2.w, c25.z
mad r3.x, r3, r2.w, c25.w
mad r3.x, r3, r2.w, c26
mad r2.w, r3.x, r2, c26.y
mul r2.w, r2, r2.x
mul r3.x, r10.z, r3.y
mad r3.y, r10.z, r5, r3.x
add r4.x, r4, -r11.y
mul r6.y, r10.z, r4.x
mad r5.y, r10.z, r5, r6
add r3.x, -r2.w, c26.z
add r2.y, r2, c23.x
cmp r2.w, -r2.y, r2, r3.x
mov r2.x, c11
add r2.y, c23.x, r2.x
add r2.x, r9.w, c23.z
mul r2.x, r2, r2.y
cmp r2.y, r2.z, r2.w, -r2.w
mul r2.x, r2, c27.w
frc r6.w, r2.x
add r8.y, -r6.w, c23.z
add r10.x, r2, -r6.w
mov r6.y, r5
mad r2.y, r2, c28.x, c28
add r9.z, -r9.y, c23
mad r2.x, r9.z, r2.y, r9.y
mad r2.x, r2, c27.w, r10
add r2.z, r2.x, c23
mul r5.x, r8, r2.z
mul r6.x, r8, r2
mov r2.y, r3
mov r2.x, r6
mov r2.z, c23.y
texldl r2, r2.xyzz, s2
mov r3.x, r5
mov r3.z, c23.y
texldl r3, r3.xyzz, s2
mul r3, r6.w, r3
mad r4, r8.y, r2, r3
mov r6.z, c23.y
texldl r2, r6.xyzz, s2
mul r6.x, r8.z, r5.z
mul r3.x, r8.z, r8.z
mov r5.z, c23.y
mad r6.y, r6.x, r6.x, -r3.x
texldl r3, r5.xyzz, s2
mul r3, r6.w, r3
mad r5.x, c6, c6, r6.y
mad r2, r8.y, r2, r3
cmp r5.z, -r5.x, c23.y, c23
cmp r5.y, r6.x, c23, c23.z
mul_pp r5.y, r5, r5.z
cmp r0, -r5.y, r1, r0
mul r1, r11.y, r2
add r2.x, -r11.y, c23.z
mad r1, r4, r2.x, r1
add r0.y, r0, r5.x
rsq r2.x, r0.y
max r0.y, r5.w, c27
rcp r2.x, r2.x
mad r2.y, r8.z, r8.z, -r8.w
rsq r2.w, r2.y
rcp r2.w, r2.w
add r3.x, r0.z, r2.w
mul r0.y, r0, c27.z
mad r2.z, r6.x, r0.x, r2.x
abs r0.x, r0.y
max r2.x, r0, c23.z
rcp r2.y, r2.x
min r2.x, r0, c23.z
mul r2.x, r2, r2.y
mul r2.y, r2.x, r2.x
mad r0.z, r2.y, c25.x, c25.y
mad r0.z, r0, r2.y, c25
mad r0.z, r0, r2.y, c25.w
mad r0.z, r0, r2.y, c26.x
mad r0.z, r0, r2.y, c26.y
rcp r3.x, r3.x
mul r2.z, r2, r3.x
mad r3.x, r2.z, r10.y, r0.w
mul r0.w, r9.x, r2
mul r0.z, r0, r2.x
mul r0.w, r0, r11.x
mad r2.x, r10.z, c27.w, r0.w
mul r2.x, r2, c8
frc r4.w, r2.x
add r0.w, -r0.z, c26.z
add r0.x, r0, c23
cmp r0.x, -r0, r0.z, r0.w
cmp r0.x, r0.y, r0, -r0
add r0.y, r2.x, -r4.w
mul r0.y, r10.z, r0
mad r0.x, r0, c28, c28.y
mad r0.x, r0, r9.z, r9.y
mad r5.w, r0.x, c27, r10.x
add r0.z, r5.w, c23
mul r4.x, r8, r0.z
mad r4.y, r3.x, r10.z, r0
add r0.x, r2, c23
frc r0.y, r0.x
add r0.x, r0, -r0.y
mov r4.z, c23.y
texldl r2, r4.xyzz, s2
mul r0.x, r0, r10.z
mad r5.y, r3.x, r10.z, r0.x
mov r5.x, r4
mov r5.z, c23.y
texldl r0, r5.xyzz, s2
mul r3, r6.w, r2
mul r4.x, r5.w, r8
mov r4.z, c23.y
texldl r2, r4.xyzz, s2
mad r2, r8.y, r2, r3
mul r3, r6.w, r0
mov r0.y, r5
mov r0.z, c23.y
mov r0.x, r4
texldl r0, r0.xyzz, s2
mad r0, r0, r8.y, r3
mul r2, r4.w, r2
add r3.x, -r4.w, c23.z
mad r0, r0, r3.x, r2
mad r0, -r0, r7.xyzx, r1
max r1, r0, c23.y
endif
mul_sat r0.x, r10.w, c29.w
mad r0.y, -r0.x, c30.x, c30
mul r0.x, r0, r0
mul r0.x, r0, r0.y
mul r0.y, r1.w, r0.x
mul r2.xyz, r1, r0.y
mul r0.x, r9.w, c15
mul r0.x, r0, c23.w
mad r0.x, c15, c15, -r0
max r0.y, r1.x, c30.z
rcp r0.y, r0.y
mul r3.xyz, r2, r0.y
add r1.w, r0.x, c23.z
pow r0, r1.w, c29.z
mov r0.w, r0.x
mul r0.z, -c15.x, c15.x
add r0.y, r0.z, c23.z
mov r0.x, c5
mul r0.x, c29.y, r0
rcp r0.x, r0.x
mul r0.x, r0, r0.y
add r0.z, -r0, c23.w
mul r0.x, r0, r0.w
mad r0.y, r9.w, r9.w, c23.z
mul r0.w, r0.y, r0.x
mov r0.x, c5
rcp r0.z, r0.z
mul r0.x, c29, r0
rcp r0.x, r0.x
mul r0.z, r0.w, r0
rcp r2.x, c14.x
rcp r2.z, c14.z
rcp r2.y, c14.y
mul r2.xyz, r2, c14.x
mul r2.xyz, r3, r2
mul r2.xyz, r0.z, r2
mul r0.x, r0, r0.y
mul r2.xyz, r2, c30.w
mul r0.xyz, r0.x, r1
mad r3.xyz, r0, c30.y, r2
endif
rcp r0.x, c19.x
mul r0.x, r7.w, r0
mul r0.w, r0.x, c29.y
pow r1, c31.x, -r0.w
mul r0.xyz, r3, c13.x
mul r3.xyz, r0, c18.x
mul r1.y, r3.x, c31
pow r2, c31.x, -r3.x
pow r0, r1.y, c31.z
mov r0.y, r2.x
mov r0.z, r0.x
mov r2.x, r1
pow r1, c31.x, -r3.y
mul r1.y, r3, c31
add r0.y, -r0, c23.z
add r0.x, r3, c31.w
cmp oC0.x, r0, r0.y, r0.z
pow r0, r1.y, c31.z
mov r0.y, r1.x
mov r0.z, r0.x
pow r1, c31.x, -r3.z
mul r1.y, r3.z, c31
add r0.y, -r0, c23.z
add r0.x, r3.y, c31.w
cmp oC0.y, r0.x, r0, r0.z
add r0.y, -r2.x, c23.z
add r0.x, r7.w, -c19
cmp r2.x, -r0, r0.y, c23.z
pow r0, r1.y, c31.z
mov r0.y, r1.x
mov r0.z, r0.x
add r0.y, -r0, c23.z
add r0.x, r3.z, c31.w
cmp oC0.z, r0.x, r0.y, r0
mul oC0.w, r2.x, c17.x
endif
"
}
SubProgram "d3d11 " {
// Stats: 517 math, 1 textures, 8 branches
SetTexture 0 [_CameraDepthTexture] 2D 2
SetTexture 1 [_Transmittance] 2D 0
SetTexture 2 [_Inscatter] 2D 1
ConstBuffer "$Globals" 432
Matrix 112 [_ViewProjInv]
Float 32 [M_PI]
Float 52 [Rg]
Float 56 [Rt]
Float 64 [RES_R]
Float 68 [RES_MU]
Float 72 [RES_MU_S]
Float 76 [RES_NU]
Vector 80 [SUN_DIR] 3
Float 92 [SUN_INTENSITY]
Vector 96 [betaR] 3
Float 108 [mieG]
Float 180 [_Scale]
Float 184 [_global_alpha]
Float 188 [_Exposure]
Float 192 [_global_depth]
Float 196 [_global_depth2]
Vector 208 [_inCamPos] 3
Vector 224 [_Globals_Origin] 3
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedhoooknajkbmdllijicaphbapnenchpmlabaaaaaadeelaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefceeekaaaaeaaaaaaajbbcaaaafjaaaaaeegiocaaa
aaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaadmcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacbcaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaacaaaaaadcaaaaalccaabaaaaaaaaaaaakiacaaa
abaaaaaaahaaaaaaakaabaaaaaaaaaaabkiacaaaabaaaaaaahaaaaaaaoaaaaak
ccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaa
aaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaabkiacaaaaaaaaaaa
amaaaaaabnaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadp
bpaaaeadckaabaaaaaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadoaaaaabbfaaaaabdcaaaaapmcaabaaaaaaaaaaa
kgbobaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaeaaaaaaaeaaceaaaaa
aaaaaaaaaaaaaaaaaaaaialpaaaaialpdiaaaaaipcaabaaaabaaaaaapgapbaaa
aaaaaaaaegiocaaaaaaaaaaaaiaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
aaaaaaaaahaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaaaaaaaaajaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
aaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaakaaaaaa
aoaaaaahncaabaaaaaaaaaaaagajbaaaabaaaaaapgapbaaaabaaaaaabaaaaaah
bcaabaaaabaaaaaaigadbaaaaaaaaaaaigadbaaaaaaaaaaaelaaaaafccaabaaa
abaaaaaaakaabaaaabaaaaaaaaaaaaaiecaabaaaabaaaaaabkiacaaaaaaaaaaa
adaaaaaaabeaaaaaaaaahkeddbaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaa
ckaabaaaabaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
hcaabaaaacaaaaaaigadbaaaaaaaaaaaagaabaaaabaaaaaadiaaaaahncaabaaa
abaaaaaakgakbaaaabaaaaaaagajbaaaacaaaaaadhaaaaajncaabaaaaaaaaaaa
fgafbaaaabaaaaaaagaobaaaabaaaaaaagaobaaaaaaaaaaaaaaaaaakhcaabaaa
abaaaaaaegiccaaaaaaaaaaaanaaaaaaegiccaiaebaaaaaaaaaaaaaaaoaaaaaa
diaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaafgifcaaaaaaaaaaaalaaaaaa
diaaaaaihcaabaaaadaaaaaaigadbaaaaaaaaaaafgifcaaaaaaaaaaaalaaaaaa
dcaaaaalncaabaaaabaaaaaaagaobaaaaaaaaaaafgifcaaaaaaaaaaaalaaaaaa
agajbaiaebaaaaaaacaaaaaabaaaaaahbcaabaaaaaaaaaaaigadbaaaabaaaaaa
igadbaaaabaaaaaaelaaaaafbcaabaaaaeaaaaaaakaabaaaaaaaaaaaaoaaaaah
ncaabaaaabaaaaaaagaobaaaabaaaaaaagaabaaaaeaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafecaabaaaafaaaaaa
akaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaabkiacaaaaaaaaaaaadaaaaaa
abeaaaaaggggggdpdbaaaaahbcaabaaaaaaaaaaackaabaaaafaaaaaaakaabaaa
aaaaaaaadcaaaaalicaabaaaacaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaa
alaaaaaabkiacaaaaaaaaaaaadaaaaaadcaaaaalccaabaaaagaaaaaackaabaaa
aaaaaaaabkiacaaaaaaaaaaaalaaaaaabkiacaaaaaaaaaaaadaaaaaabaaaaaah
ecaabaaaaaaaaaaaigadbaaaacaaaaaaigadbaaaacaaaaaaelaaaaafecaabaaa
agaaaaaackaabaaaaaaaaaaadgaaaaafbcaabaaaagaaaaaadkaabaaaacaaaaaa
dgaaaaafbcaabaaaafaaaaaabkaabaaaacaaaaaadgaaaaafccaabaaaafaaaaaa
bkaabaaaadaaaaaadhaaaaajncaabaaaaaaaaaaaagaabaaaaaaaaaaaagajbaaa
agaaaaaaagajbaaaafaaaaaadgaaaaafccaabaaaacaaaaaaakaabaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaaigadbaaaabaaaaaaaoaaaaah
ecaabaaaaeaaaaaaakaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahccaabaaa
abaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakccaabaaaabaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaiaebaaaaaaabaaaaaadcaaaaal
ccaabaaaabaaaaaackiacaaaaaaaaaaaadaaaaaackiacaaaaaaaaaaaadaaaaaa
bkaabaaaabaaaaaaelaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaaaaaaaaaj
ccaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaabkaabaiaebaaaaaaabaaaaaa
deaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaaaadbaaaaah
icaabaaaacaaaaaaabeaaaaaaaaaaaaabkaabaaaabaaaaaadbaaaaahccaabaaa
adaaaaaabkaabaaaabaaaaaaakaabaaaaeaaaaaaabaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaabkaabaaaadaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaabaaaaaaaoaaaaaiecaabaaaafaaaaaaakaabaaaaaaaaaaa
ckiacaaaaaaaaaaaadaaaaaaaaaaaaaibcaabaaaafaaaaaabkaabaiaebaaaaaa
abaaaaaaakaabaaaaeaaaaaadgaaaaagccaabaaaafaaaaaackiacaaaaaaaaaaa
adaaaaaadgaaaaafccaabaaaaeaaaaaadkaabaaaaaaaaaaadhaaaaajocaabaaa
aeaaaaaapgapbaaaacaaaaaaagajbaaaafaaaaaaagajbaaaaeaaaaaabnaaaaai
bcaabaaaaaaaaaaackiacaaaaaaaaaaaadaaaaaackaabaaaaeaaaaaabpaaaead
akaabaaaaaaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaaaeaaaaaaabeaaaaa
aaaaiadpdgaaaaaficaabaaaadaaaaaackaabaaaaaaaaaaadcaaaaakhcaabaaa
adaaaaaaigadbaiaebaaaaaaabaaaaaaagaabaaaaaaaaaaamgacbaaaadaaaaaa
dcaaaaajncaabaaaaaaaaaaafgafbaaaabaaaaaaagaobaaaabaaaaaaagajbaaa
acaaaaaadhaaaaajncaabaaaaaaaaaaapgapbaaaacaaaaaaagaobaaaaaaaaaaa
agajbaaaacaaaaaabaaaaaaiccaabaaaabaaaaaaigadbaaaabaaaaaaegiccaaa
aaaaaaaaafaaaaaabaaaaaaibcaabaaaaaaaaaaaigadbaaaaaaaaaaaegiccaaa
aaaaaaaaafaaaaaaaaaaaaaiecaabaaaaaaaaaaabkiacaaaaaaaaaaaadaaaaaa
abeaaaaaaaaabgeedbaaaaahicaabaaaaaaaaaaackaabaaaaeaaaaaackaabaaa
aaaaaaaaaoaaaaahfcaabaaaaaaaaaaaagacbaaaaaaaaaaakgakbaaaaeaaaaaa
diaaaaahhcaabaaaacaaaaaakgakbaaaaaaaaaaaegacbaaaadaaaaaaaaaaaaai
icaabaaaacaaaaaabkiacaaaaaaaaaaaadaaaaaaabeaaaaaaaaabgeedgaaaaaf
icaabaaaadaaaaaackaabaaaaeaaaaaadhaaaaajpcaabaaaacaaaaaapgapbaaa
aaaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaaficaabaaaaaaaaaaackaabaaa
aaaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaacaaaaaaigadbaaaabaaaaaa
baaaaaaiicaabaaaabaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaafaaaaaa
aoaaaaahmcaabaaaabaaaaaaagambaaaabaaaaaapgapbaaaaaaaaaaadbaaaaah
bcaabaaaacaaaaaaabeaaaaaaaaaaaaadkaabaaaaeaaaaaabpaaaeadakaabaaa
acaaaaaaaaaaaaajbcaabaaaacaaaaaadkaabaaaacaaaaaabkiacaiaebaaaaaa
aaaaaaaaadaaaaaaaaaaaaakccaabaaaacaaaaaabkiacaiaebaaaaaaaaaaaaaa
adaaaaaackiacaaaaaaaaaaaadaaaaaaaoaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaabkaabaaaacaaaaaaelaaaaafccaabaaaadaaaaaaakaabaaaacaaaaaa
aaaaaaahbcaabaaaacaaaaaadkaabaaaaeaaaaaaabeaaaaajkjjbjdodiaaaaah
bcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaajfdbeeebddaaaaaiecaabaaa
acaaaaaaakaabaiaibaaaaaaacaaaaaaabeaaaaaaaaaiadpdeaaaaaiecaabaaa
adaaaaaaakaabaiaibaaaaaaacaaaaaaabeaaaaaaaaaiadpaoaaaaakecaabaaa
adaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpckaabaaaadaaaaaa
diaaaaahecaabaaaacaaaaaackaabaaaacaaaaaackaabaaaadaaaaaadiaaaaah
ecaabaaaadaaaaaackaabaaaacaaaaaackaabaaaacaaaaaadcaaaaajicaabaaa
adaaaaaackaabaaaadaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaaj
icaabaaaadaaaaaackaabaaaadaaaaaadkaabaaaadaaaaaaabeaaaaaochgdido
dcaaaaajicaabaaaadaaaaaackaabaaaadaaaaaadkaabaaaadaaaaaaabeaaaaa
aebnkjlodcaaaaajecaabaaaadaaaaaackaabaaaadaaaaaadkaabaaaadaaaaaa
abeaaaaadiphhpdpdiaaaaahicaabaaaadaaaaaackaabaaaacaaaaaackaabaaa
adaaaaaadbaaaaaibcaabaaaaeaaaaaaabeaaaaaaaaaiadpakaabaiaibaaaaaa
acaaaaaadcaaaaajicaabaaaadaaaaaadkaabaaaadaaaaaaabeaaaaaaaaaaama
abeaaaaanlapmjdpabaaaaahicaabaaaadaaaaaaakaabaaaaeaaaaaadkaabaaa
adaaaaaadcaaaaajecaabaaaacaaaaaackaabaaaacaaaaaackaabaaaadaaaaaa
dkaabaaaadaaaaaaddaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaa
aaaaiadpdbaaaaaibcaabaaaacaaaaaaakaabaaaacaaaaaaakaabaiaebaaaaaa
acaaaaaadhaaaaakbcaabaaaacaaaaaaakaabaaaacaaaaaackaabaiaebaaaaaa
acaaaaaackaabaaaacaaaaaadiaaaaahbcaabaaaadaaaaaaakaabaaaacaaaaaa
abeaaaaaklkkckdpeiaaaaalpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaajbcaabaaaacaaaaaa
dkaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaaadaaaaaaaoaaaaahbcaabaaa
acaaaaaaakaabaaaacaaaaaabkaabaaaacaaaaaaelaaaaafccaabaaaacaaaaaa
akaabaaaacaaaaaaaaaaaaahecaabaaaacaaaaaackaabaaaabaaaaaaabeaaaaa
jkjjbjdodiaaaaahecaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaajfdbeeeb
ddaaaaaiicaabaaaadaaaaaackaabaiaibaaaaaaacaaaaaaabeaaaaaaaaaiadp
deaaaaaibcaabaaaaeaaaaaackaabaiaibaaaaaaacaaaaaaabeaaaaaaaaaiadp
aoaaaaakbcaabaaaaeaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
akaabaaaaeaaaaaadiaaaaahicaabaaaadaaaaaadkaabaaaadaaaaaaakaabaaa
aeaaaaaadiaaaaahbcaabaaaaeaaaaaadkaabaaaadaaaaaadkaabaaaadaaaaaa
dcaaaaajecaabaaaaeaaaaaaakaabaaaaeaaaaaaabeaaaaafpkokkdmabeaaaaa
dgfkkolndcaaaaajecaabaaaaeaaaaaaakaabaaaaeaaaaaackaabaaaaeaaaaaa
abeaaaaaochgdidodcaaaaajecaabaaaaeaaaaaaakaabaaaaeaaaaaackaabaaa
aeaaaaaaabeaaaaaaebnkjlodcaaaaajbcaabaaaaeaaaaaaakaabaaaaeaaaaaa
ckaabaaaaeaaaaaaabeaaaaadiphhpdpdiaaaaahecaabaaaaeaaaaaadkaabaaa
adaaaaaaakaabaaaaeaaaaaadbaaaaaibcaabaaaafaaaaaaabeaaaaaaaaaiadp
ckaabaiaibaaaaaaacaaaaaadcaaaaajecaabaaaaeaaaaaackaabaaaaeaaaaaa
abeaaaaaaaaaaamaabeaaaaanlapmjdpabaaaaahecaabaaaaeaaaaaaakaabaaa
afaaaaaackaabaaaaeaaaaaadcaaaaajicaabaaaadaaaaaadkaabaaaadaaaaaa
akaabaaaaeaaaaaackaabaaaaeaaaaaaddaaaaahecaabaaaacaaaaaackaabaaa
acaaaaaaabeaaaaaaaaaiadpdbaaaaaiecaabaaaacaaaaaackaabaaaacaaaaaa
ckaabaiaebaaaaaaacaaaaaadhaaaaakecaabaaaacaaaaaackaabaaaacaaaaaa
dkaabaiaebaaaaaaadaaaaaadkaabaaaadaaaaaadiaaaaahbcaabaaaacaaaaaa
ckaabaaaacaaaaaaabeaaaaaklkkckdpeiaaaaalpcaabaaaafaaaaaaegaabaaa
acaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaaoaaaaah
hcaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaafaaaaaaddaaaaakhcaabaaa
acaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
bcaaaaabaaaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaabkiacaiaebaaaaaa
aaaaaaaaadaaaaaaaaaaaaakbcaabaaaadaaaaaabkiacaiaebaaaaaaaaaaaaaa
adaaaaaackiacaaaaaaaaaaaadaaaaaaaoaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaadaaaaaaelaaaaafccaabaaaafaaaaaadkaabaaaaaaaaaaa
aaaaaaaiicaabaaaaaaaaaaackaabaiaebaaaaaaabaaaaaaabeaaaaajkjjbjdo
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaajfdbeeebddaaaaai
ecaabaaaabaaaaaadkaabaiaibaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaai
ccaabaaaadaaaaaadkaabaiaibaaaaaaaaaaaaaaabeaaaaaaaaaiadpaoaaaaak
ccaabaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaa
adaaaaaadiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaabkaabaaaadaaaaaa
diaaaaahccaabaaaadaaaaaackaabaaaabaaaaaackaabaaaabaaaaaadcaaaaaj
ecaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkoln
dcaaaaajecaabaaaadaaaaaabkaabaaaadaaaaaackaabaaaadaaaaaaabeaaaaa
ochgdidodcaaaaajecaabaaaadaaaaaabkaabaaaadaaaaaackaabaaaadaaaaaa
abeaaaaaaebnkjlodcaaaaajccaabaaaadaaaaaabkaabaaaadaaaaaackaabaaa
adaaaaaaabeaaaaadiphhpdpdiaaaaahecaabaaaadaaaaaackaabaaaabaaaaaa
bkaabaaaadaaaaaadbaaaaaiicaabaaaadaaaaaaabeaaaaaaaaaiadpdkaabaia
ibaaaaaaaaaaaaaadcaaaaajecaabaaaadaaaaaackaabaaaadaaaaaaabeaaaaa
aaaaaamaabeaaaaanlapmjdpabaaaaahecaabaaaadaaaaaadkaabaaaadaaaaaa
ckaabaaaadaaaaaadcaaaaajecaabaaaabaaaaaackaabaaaabaaaaaabkaabaaa
adaaaaaackaabaaaadaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpdbaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaadhaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaia
ebaaaaaaabaaaaaackaabaaaabaaaaaadiaaaaahbcaabaaaafaaaaaadkaabaaa
aaaaaaaaabeaaaaaklkkckdpeiaaaaalpcaabaaaafaaaaaaegaabaaaafaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaajicaabaaa
aaaaaaaadkaabaaaacaaaaaabkiacaiaebaaaaaaaaaaaaaaadaaaaaaaoaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaadaaaaaaelaaaaafccaabaaa
adaaaaaadkaabaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aeaaaaaaabeaaaaajkjjbjdodiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaajfdbeeebddaaaaaiecaabaaaabaaaaaadkaabaiaibaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdeaaaaaiecaabaaaadaaaaaadkaabaiaibaaaaaaaaaaaaaa
abeaaaaaaaaaiadpaoaaaaakecaabaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpckaabaaaadaaaaaadiaaaaahecaabaaaabaaaaaackaabaaa
abaaaaaackaabaaaadaaaaaadiaaaaahecaabaaaadaaaaaackaabaaaabaaaaaa
ckaabaaaabaaaaaadcaaaaajicaabaaaadaaaaaackaabaaaadaaaaaaabeaaaaa
fpkokkdmabeaaaaadgfkkolndcaaaaajicaabaaaadaaaaaackaabaaaadaaaaaa
dkaabaaaadaaaaaaabeaaaaaochgdidodcaaaaajicaabaaaadaaaaaackaabaaa
adaaaaaadkaabaaaadaaaaaaabeaaaaaaebnkjlodcaaaaajecaabaaaadaaaaaa
ckaabaaaadaaaaaadkaabaaaadaaaaaaabeaaaaadiphhpdpdiaaaaahicaabaaa
adaaaaaackaabaaaabaaaaaackaabaaaadaaaaaadbaaaaaibcaabaaaaeaaaaaa
abeaaaaaaaaaiadpdkaabaiaibaaaaaaaaaaaaaadcaaaaajicaabaaaadaaaaaa
dkaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpabaaaaahicaabaaa
adaaaaaaakaabaaaaeaaaaaadkaabaaaadaaaaaadcaaaaajecaabaaaabaaaaaa
ckaabaaaabaaaaaackaabaaaadaaaaaadkaabaaaadaaaaaaddaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdbaaaaaiicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadhaaaaakicaabaaaaaaaaaaa
dkaabaaaaaaaaaaackaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaadiaaaaah
bcaabaaaadaaaaaadkaabaaaaaaaaaaaabeaaaaaklkkckdpeiaaaaalpcaabaaa
adaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaabeaaaaa
aaaaaaaaaoaaaaahhcaabaaaadaaaaaaegacbaaaafaaaaaaegacbaaaadaaaaaa
ddaaaaakhcaabaaaacaaaaaaegacbaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaabfaaaaabaoaaaaaiicaabaaaaaaaaaaabkiacaaaaaaaaaaa
adaaaaaadkaabaaaacaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaaaaaaaaahecaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaa
aeaaaaaadbaaaaaibcaabaaaadaaaaaackaabaiaibaaaaaaabaaaaaaabeaaaaa
gpbciddlbpaaaeadakaabaaaadaaaaaaaaaaaaahecaabaaaabaaaaaackaabaaa
abaaaaaaabeaaaaagpbciddldiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaa
abeaaaaapppppjecaaaaaaaldcaabaaaadaaaaaapgapbaiaebaaaaaaaaaaaaaa
aceaaaaagpbcidllgpbciddlaaaaaaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaacaaaaaadkaabaaaacaaaaaadcaaaaajecaabaaaadaaaaaabkaabaaa
aeaaaaaabkaabaaaaeaaaaaadkaabaaaaaaaaaaaapaaaaahicaabaaaadaaaaaa
fgafbaaaaeaaaaaapgapbaaaacaaaaaadcaaaaajmcaabaaaadaaaaaapgapbaaa
adaaaaaaagaebaaaadaaaaaakgakbaaaadaaaaaaelaaaaafmcaabaaaadaaaaaa
kgaobaaaadaaaaaadiaaaaahfcaabaaaaeaaaaaapgapbaaaacaaaaaaagabbaaa
adaaaaaadcaaaaajdcaabaaaadaaaaaapgapbaaaacaaaaaaegaabaaaadaaaaaa
fgafbaaaaeaaaaaadiaaaaajccaabaaaaeaaaaaabkiacaaaaaaaaaaaadaaaaaa
bkiacaaaaaaaaaaaadaaaaaadcaaaaambcaabaaaafaaaaaackiacaaaaaaaaaaa
adaaaaaackiacaaaaaaaaaaaadaaaaaabkaabaiaebaaaaaaaeaaaaaaelaaaaaf
ecaabaaaafaaaaaaakaabaaaafaaaaaadcaaaaakbcaabaaaagaaaaaadkaabaaa
acaaaaaadkaabaaaacaaaaaabkaabaiaebaaaaaaaeaaaaaaelaaaaafbcaabaaa
agaaaaaaakaabaaaagaaaaaadcaaaaakgcaabaaaagaaaaaaagacbaaaaeaaaaaa
agacbaaaaeaaaaaapgapbaiaebaaaaaaaaaaaaaadcaaaaalgcaabaaaagaaaaaa
fgifcaaaaaaaaaaaadaaaaaafgifcaaaaaaaaaaaadaaaaaafgagbaaaagaaaaaa
dbaaaaakdcaabaaaahaaaaaaigaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadbaaaaakmcaabaaaahaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaafgajbaaaagaaaaaaabaaaaahdcaabaaaahaaaaaaogakbaaa
ahaaaaaaegaabaaaahaaaaaaaoaaaaalhcaabaaaaiaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaabgigcaaaaaaaaaaaaeaaaaaaaaaaaaaiicaabaaa
ajaaaaaaakaabaiaebaaaaaaaiaaaaaaabeaaaaaaaaaaadpdiaaaaahccaabaaa
afaaaaaackaabaaaafaaaaaackaabaaaafaaaaaaaaaaaaahicaabaaaafaaaaaa
akaabaaaaiaaaaaaabeaaaaaaaaaaadpdgaaaaaihcaabaaaajaaaaaaaceaaaaa
aaaaiadpaaaaaaaaaaaaaaaaaaaaaaaadgaaaaafbcaabaaaafaaaaaaabeaaaaa
aaaaialpdhaaaaajpcaabaaaakaaaaaaagaabaaaahaaaaaaigaobaaaajaaaaaa
egaobaaaafaaaaaaaoaaaaahicaabaaaaaaaaaaaakaabaaaagaaaaaackaabaaa
afaaaaaaaoaaaaalncaabaaaahaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpagijcaaaaaaaaaaaaeaaaaaaaaaaaaalncaabaaaahaaaaaaagaobaia
ebaaaaaaahaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaaadpaaaaiadpdcaaaaaj
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaahaaaaaabkaabaaaaiaaaaaa
aaaaaaahccaabaaaagaaaaaabkaabaaaagaaaaaabkaabaaaakaaaaaaelaaaaaf
ccaabaaaagaaaaaabkaabaaaagaaaaaadcaaaaajbcaabaaaaeaaaaaaakaabaaa
aeaaaaaaakaabaaaakaaaaaabkaabaaaagaaaaaaaaaaaaahccaabaaaagaaaaaa
akaabaaaagaaaaaackaabaaaakaaaaaaaoaaaaahbcaabaaaaeaaaaaaakaabaaa
aeaaaaaabkaabaaaagaaaaaadcaaaaajbcaabaaaaeaaaaaaakaabaaaaeaaaaaa
ckaabaaaahaaaaaadkaabaaaakaaaaaadeaaaaahccaabaaaagaaaaaaakaabaaa
aaaaaaaaabeaaaaahbdneklodiaaaaahccaabaaaagaaaaaabkaabaaaagaaaaaa
abeaaaaabodakleaddaaaaaiicaabaaaagaaaaaabkaabaiaibaaaaaaagaaaaaa
abeaaaaaaaaaiadpdeaaaaaibcaabaaaaiaaaaaabkaabaiaibaaaaaaagaaaaaa
abeaaaaaaaaaiadpaoaaaaakbcaabaaaaiaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaiaaaaaadiaaaaahicaabaaaagaaaaaadkaabaaa
agaaaaaaakaabaaaaiaaaaaadiaaaaahbcaabaaaaiaaaaaadkaabaaaagaaaaaa
dkaabaaaagaaaaaadcaaaaajicaabaaaaiaaaaaaakaabaaaaiaaaaaaabeaaaaa
fpkokkdmabeaaaaadgfkkolndcaaaaajicaabaaaaiaaaaaaakaabaaaaiaaaaaa
dkaabaaaaiaaaaaaabeaaaaaochgdidodcaaaaajicaabaaaaiaaaaaaakaabaaa
aiaaaaaadkaabaaaaiaaaaaaabeaaaaaaebnkjlodcaaaaajbcaabaaaaiaaaaaa
akaabaaaaiaaaaaadkaabaaaaiaaaaaaabeaaaaadiphhpdpdiaaaaahicaabaaa
aiaaaaaadkaabaaaagaaaaaaakaabaaaaiaaaaaadbaaaaaibcaabaaaakaaaaaa
abeaaaaaaaaaiadpbkaabaiaibaaaaaaagaaaaaadcaaaaajicaabaaaaiaaaaaa
dkaabaaaaiaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpabaaaaahicaabaaa
aiaaaaaaakaabaaaakaaaaaadkaabaaaaiaaaaaadcaaaaajicaabaaaagaaaaaa
dkaabaaaagaaaaaaakaabaaaaiaaaaaadkaabaaaaiaaaaaaddaaaaahccaabaaa
agaaaaaabkaabaaaagaaaaaaabeaaaaaaaaaiadpdbaaaaaiccaabaaaagaaaaaa
bkaabaaaagaaaaaabkaabaiaebaaaaaaagaaaaaadhaaaaakccaabaaaagaaaaaa
bkaabaaaagaaaaaadkaabaiaebaaaaaaagaaaaaadkaabaaaagaaaaaadcaaaaaj
ccaabaaaagaaaaaabkaabaaaagaaaaaaabeaaaaacolkgidpabeaaaaakehadndp
diaaaaahccaabaaaagaaaaaabkaabaaaagaaaaaaabeaaaaaaaaaaadpdcaaaaaj
ccaabaaaagaaaaaabkaabaaaagaaaaaadkaabaaaahaaaaaackaabaaaaiaaaaaa
aaaaaaahicaabaaaagaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaah
icaabaaaagaaaaaadkaabaaaagaaaaaaabeaaaaaaaaaaadpaaaaaaaibcaabaaa
aiaaaaaadkiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaialpdiaaaaahicaabaaa
aiaaaaaadkaabaaaagaaaaaaakaabaaaaiaaaaaaebaaaaaficaabaaaaiaaaaaa
dkaabaaaaiaaaaaadcaaaaakicaabaaaagaaaaaadkaabaaaagaaaaaaakaabaaa
aiaaaaaadkaabaiaebaaaaaaaiaaaaaadiaaaaaibcaabaaaaiaaaaaadkaabaaa
aaaaaaaaakiacaaaaaaaaaaaaeaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaialpebaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaaaoaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akiacaaaaaaaaaaaaeaaaaaaebaaaaafbcaabaaaakaaaaaaakaabaaaaiaaaaaa
aoaaaaaibcaabaaaakaaaaaaakaabaaaakaaaaaaakiacaaaaaaaaaaaaeaaaaaa
bkaaaaafbcaabaaaaiaaaaaaakaabaaaaiaaaaaaaaaaaaahccaabaaaagaaaaaa
bkaabaaaagaaaaaadkaabaaaaiaaaaaaaoaaaaaiccaabaaaalaaaaaabkaabaaa
agaaaaaadkiacaaaaaaaaaaaaeaaaaaaaoaaaaaibcaabaaaaeaaaaaaakaabaaa
aeaaaaaaakiacaaaaaaaaaaaaeaaaaaaaaaaaaahbcaabaaaalaaaaaadkaabaaa
aaaaaaaaakaabaaaaeaaaaaaeiaaaaalpcaabaaaamaaaaaabgafbaaaalaaaaaa
eghobaaaacaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaa
akaaaaaadkaabaiaebaaaaaaagaaaaaaabeaaaaaaaaaiadpaaaaaaahccaabaaa
agaaaaaabkaabaaaagaaaaaaabeaaaaaaaaaiadpaoaaaaaiecaabaaaalaaaaaa
bkaabaaaagaaaaaadkiacaaaaaaaaaaaaeaaaaaaeiaaaaalpcaabaaaanaaaaaa
cgakbaaaalaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaa
diaaaaahpcaabaaaanaaaaaapgapbaaaagaaaaaaegaobaaaanaaaaaadcaaaaaj
pcaabaaaamaaaaaaegaobaaaamaaaaaafgafbaaaakaaaaaaegaobaaaanaaaaaa
aaaaaaahicaabaaaalaaaaaaakaabaaaakaaaaaaakaabaaaaeaaaaaaeiaaaaal
pcaabaaaanaaaaaangafbaaaalaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaa
abeaaaaaaaaaaaaaeiaaaaalpcaabaaaaoaaaaaaogakbaaaalaaaaaaeghobaaa
acaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaahpcaabaaaaoaaaaaa
pgapbaaaagaaaaaaegaobaaaaoaaaaaadcaaaaajpcaabaaaanaaaaaaegaobaaa
anaaaaaafgafbaaaakaaaaaaegaobaaaaoaaaaaaaaaaaaaibcaabaaaaeaaaaaa
akaabaiaebaaaaaaaiaaaaaaabeaaaaaaaaaiadpdiaaaaahpcaabaaaanaaaaaa
agaabaaaaiaaaaaaegaobaaaanaaaaaadcaaaaajpcaabaaaamaaaaaaegaobaaa
amaaaaaaagaabaaaaeaaaaaaegaobaaaanaaaaaadiaaaaahmcaabaaaakaaaaaa
kgaobaaaadaaaaaakgaobaaaadaaaaaadcaaaaakmcaabaaaadaaaaaakgaobaaa
adaaaaaakgaobaaaadaaaaaafgafbaiaebaaaaaaaeaaaaaaelaaaaafmcaabaaa
adaaaaaakgaobaaaadaaaaaadcaaaaakmcaabaaaakaaaaaaagaebaaaadaaaaaa
agaebaaaadaaaaaakgaobaiaebaaaaaaakaaaaaadcaaaaalmcaabaaaakaaaaaa
fgifcaaaaaaaaaaaadaaaaaafgifcaaaaaaaaaaaadaaaaaakgaobaaaakaaaaaa
dbaaaaakdcaabaaaanaaaaaaegaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadbaaaaakmcaabaaaanaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaakgaobaaaakaaaaaaabaaaaahdcaabaaaanaaaaaaogakbaaa
anaaaaaaegaabaaaanaaaaaadhaaaaajpcaabaaaaoaaaaaaagaabaaaanaaaaaa
igaobaaaajaaaaaaegaobaaaafaaaaaaaoaaaaahfcaabaaaanaaaaaakgalbaaa
adaaaaaakgakbaaaafaaaaaadcaaaaajfcaabaaaanaaaaaaagacbaaaanaaaaaa
agaabaaaahaaaaaafgafbaaaaiaaaaaaaaaaaaahccaabaaaaeaaaaaackaabaaa
akaaaaaabkaabaaaaoaaaaaaelaaaaafccaabaaaaeaaaaaabkaabaaaaeaaaaaa
dcaaaaajbcaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaaaoaaaaaabkaabaaa
aeaaaaaaaaaaaaahecaabaaaadaaaaaackaabaaaadaaaaaackaabaaaaoaaaaaa
aoaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaackaabaaaadaaaaaadcaaaaaj
bcaabaaaadaaaaaaakaabaaaadaaaaaackaabaaaahaaaaaadkaabaaaaoaaaaaa
deaaaaahecaabaaaadaaaaaadkaabaaaabaaaaaaabeaaaaahbdneklodiaaaaah
ecaabaaaadaaaaaackaabaaaadaaaaaaabeaaaaabodakleaddaaaaaiccaabaaa
aeaaaaaackaabaiaibaaaaaaadaaaaaaabeaaaaaaaaaiadpdeaaaaaiccaabaaa
agaaaaaackaabaiaibaaaaaaadaaaaaaabeaaaaaaaaaiadpaoaaaaakccaabaaa
agaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaagaaaaaa
diaaaaahccaabaaaaeaaaaaabkaabaaaaeaaaaaabkaabaaaagaaaaaadiaaaaah
ccaabaaaagaaaaaabkaabaaaaeaaaaaabkaabaaaaeaaaaaadcaaaaajbcaabaaa
ahaaaaaabkaabaaaagaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaaj
bcaabaaaahaaaaaabkaabaaaagaaaaaaakaabaaaahaaaaaaabeaaaaaochgdido
dcaaaaajbcaabaaaahaaaaaabkaabaaaagaaaaaaakaabaaaahaaaaaaabeaaaaa
aebnkjlodcaaaaajccaabaaaagaaaaaabkaabaaaagaaaaaaakaabaaaahaaaaaa
abeaaaaadiphhpdpdiaaaaahbcaabaaaahaaaaaabkaabaaaaeaaaaaabkaabaaa
agaaaaaadbaaaaaiccaabaaaaiaaaaaaabeaaaaaaaaaiadpckaabaiaibaaaaaa
adaaaaaadcaaaaajbcaabaaaahaaaaaaakaabaaaahaaaaaaabeaaaaaaaaaaama
abeaaaaanlapmjdpabaaaaahbcaabaaaahaaaaaabkaabaaaaiaaaaaaakaabaaa
ahaaaaaadcaaaaajccaabaaaaeaaaaaabkaabaaaaeaaaaaabkaabaaaagaaaaaa
akaabaaaahaaaaaaddaaaaahecaabaaaadaaaaaackaabaaaadaaaaaaabeaaaaa
aaaaiadpdbaaaaaiecaabaaaadaaaaaackaabaaaadaaaaaackaabaiaebaaaaaa
adaaaaaadhaaaaakecaabaaaadaaaaaackaabaaaadaaaaaabkaabaiaebaaaaaa
aeaaaaaabkaabaaaaeaaaaaadcaaaaajecaabaaaadaaaaaackaabaaaadaaaaaa
abeaaaaacolkgidpabeaaaaakehadndpdiaaaaahecaabaaaadaaaaaadkaabaaa
ahaaaaaackaabaaaadaaaaaadcaaaaajecaabaaaadaaaaaackaabaaaadaaaaaa
abeaaaaaaaaaaadpckaabaaaaiaaaaaadiaaaaaijcaabaaaahaaaaaaagaibaaa
anaaaaaaagiacaaaaaaaaaaaaeaaaaaadcaaaaangcaabaaaaiaaaaaaagacbaaa
anaaaaaaagiacaaaaaaaaaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialp
aaaaaaaaebaaaaafgcaabaaaaiaaaaaafgagbaaaaiaaaaaaaoaaaaaigcaabaaa
aiaaaaaafgagbaaaaiaaaaaaagiacaaaaaaaaaaaaeaaaaaaebaaaaaffcaabaaa
anaaaaaaagadbaaaahaaaaaaaoaaaaaifcaabaaaanaaaaaaagacbaaaanaaaaaa
agiacaaaaaaaaaaaaeaaaaaabkaaaaafjcaabaaaahaaaaaaagambaaaahaaaaaa
aaaaaaahecaabaaaadaaaaaackaabaaaadaaaaaadkaabaaaaiaaaaaaaoaaaaai
ccaabaaaaoaaaaaackaabaaaadaaaaaadkiacaaaaaaaaaaaaeaaaaaaaoaaaaai
bcaabaaaadaaaaaaakaabaaaadaaaaaaakiacaaaaaaaaaaaaeaaaaaaaaaaaaah
bcaabaaaaoaaaaaabkaabaaaaiaaaaaaakaabaaaadaaaaaaeiaaaaalpcaabaaa
apaaaaaabgafbaaaaoaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaaabeaaaaa
aaaaaaaaaaaaaaahecaabaaaadaaaaaackaabaaaadaaaaaaabeaaaaaaaaaiadp
aoaaaaaiecaabaaaaoaaaaaackaabaaaadaaaaaadkiacaaaaaaaaaaaaeaaaaaa
eiaaaaalpcaabaaabaaaaaaacgakbaaaaoaaaaaaeghobaaaacaaaaaaaagabaaa
abaaaaaaabeaaaaaaaaaaaaadiaaaaahpcaabaaabaaaaaaapgapbaaaagaaaaaa
egaobaaabaaaaaaadcaaaaajpcaabaaaapaaaaaaegaobaaaapaaaaaafgafbaaa
akaaaaaaegaobaaabaaaaaaaaaaaaaahicaabaaaaoaaaaaaakaabaaaanaaaaaa
akaabaaaadaaaaaaeiaaaaalpcaabaaabaaaaaaangafbaaaaoaaaaaaeghobaaa
acaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaaeiaaaaalpcaabaaabbaaaaaa
ogakbaaaaoaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaa
diaaaaahpcaabaaabbaaaaaapgapbaaaagaaaaaaegaobaaabbaaaaaadcaaaaaj
pcaabaaabaaaaaaaegaobaaabaaaaaaafgafbaaaakaaaaaaegaobaaabbaaaaaa
aaaaaaalfcaabaaaadaaaaaaagadbaiaebaaaaaaahaaaaaaaceaaaaaaaaaiadp
aaaaaaaaaaaaiadpaaaaaaaadiaaaaahpcaabaaabaaaaaaaagaabaaaahaaaaaa
egaobaaabaaaaaaadcaaaaajpcaabaaaapaaaaaaegaobaaaapaaaaaaagaabaaa
adaaaaaaegaobaaabaaaaaaadcaaaaakpcaabaaaamaaaaaaegaobaiaebaaaaaa
apaaaaaaegacbaaaacaaaaaaegaobaaaamaaaaaadeaaaaakpcaabaaaamaaaaaa
egaobaaaamaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadhaaaaaj
pcaabaaaapaaaaaafgafbaaaahaaaaaaigaobaaaajaaaaaaegaobaaaafaaaaaa
aaaaaaahbcaabaaaadaaaaaackaabaaaagaaaaaabkaabaaaapaaaaaaelaaaaaf
bcaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaajbcaabaaaadaaaaaackaabaaa
aeaaaaaaakaabaaaapaaaaaaakaabaaaadaaaaaaaaaaaaahccaabaaaaeaaaaaa
akaabaaaagaaaaaackaabaaaapaaaaaaaoaaaaahbcaabaaaadaaaaaaakaabaaa
adaaaaaabkaabaaaaeaaaaaadcaaaaajbcaabaaaadaaaaaaakaabaaaadaaaaaa
ckaabaaaahaaaaaadkaabaaaapaaaaaaaoaaaaaibcaabaaaadaaaaaaakaabaaa
adaaaaaaakiacaaaaaaaaaaaaeaaaaaaaaaaaaahbcaabaaaalaaaaaadkaabaaa
aaaaaaaaakaabaaaadaaaaaaeiaaaaalpcaabaaaapaaaaaabgafbaaaalaaaaaa
eghobaaaacaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaaeiaaaaalpcaabaaa
baaaaaaacgakbaaaalaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaaabeaaaaa
aaaaaaaadiaaaaahpcaabaaabaaaaaaapgapbaaaagaaaaaaegaobaaabaaaaaaa
dcaaaaajpcaabaaaapaaaaaaegaobaaaapaaaaaafgafbaaaakaaaaaaegaobaaa
baaaaaaaaaaaaaahicaabaaaalaaaaaaakaabaaaakaaaaaaakaabaaaadaaaaaa
eiaaaaalpcaabaaabaaaaaaangafbaaaalaaaaaaeghobaaaacaaaaaaaagabaaa
abaaaaaaabeaaaaaaaaaaaaaeiaaaaalpcaabaaaalaaaaaaogakbaaaalaaaaaa
eghobaaaacaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaahpcaabaaa
alaaaaaapgapbaaaagaaaaaaegaobaaaalaaaaaadcaaaaajpcaabaaaalaaaaaa
egaobaaabaaaaaaafgafbaaaakaaaaaaegaobaaaalaaaaaadiaaaaahpcaabaaa
alaaaaaaagaabaaaaiaaaaaaegaobaaaalaaaaaadcaaaaajpcaabaaaalaaaaaa
egaobaaaapaaaaaaagaabaaaaeaaaaaaegaobaaaalaaaaaadhaaaaajpcaabaaa
afaaaaaafgafbaaaanaaaaaaegaobaaaajaaaaaaegaobaaaafaaaaaaaaaaaaah
icaabaaaaaaaaaaabkaabaaaafaaaaaadkaabaaaakaaaaaaelaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaajicaabaaaaaaaaaaabkaabaaaadaaaaaa
akaabaaaafaaaaaadkaabaaaaaaaaaaaaaaaaaahbcaabaaaadaaaaaadkaabaaa
adaaaaaackaabaaaafaaaaaaaoaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaadaaaaaadcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaa
ahaaaaaadkaabaaaafaaaaaaaoaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akiacaaaaaaaaaaaaeaaaaaaaaaaaaahbcaabaaaaoaaaaaackaabaaaaiaaaaaa
dkaabaaaaaaaaaaaeiaaaaalpcaabaaaafaaaaaabgafbaaaaoaaaaaaeghobaaa
acaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaaeiaaaaalpcaabaaaaiaaaaaa
cgakbaaaaoaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaa
diaaaaahpcaabaaaaiaaaaaapgapbaaaagaaaaaaegaobaaaaiaaaaaadcaaaaaj
pcaabaaaafaaaaaaegaobaaaafaaaaaafgafbaaaakaaaaaaegaobaaaaiaaaaaa
aaaaaaahicaabaaaaoaaaaaackaabaaaanaaaaaadkaabaaaaaaaaaaaeiaaaaal
pcaabaaaaiaaaaaangafbaaaaoaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaa
abeaaaaaaaaaaaaaeiaaaaalpcaabaaaajaaaaaaogakbaaaaoaaaaaaeghobaaa
acaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaahpcaabaaaagaaaaaa
pgapbaaaagaaaaaaegaobaaaajaaaaaadcaaaaajpcaabaaaagaaaaaaegaobaaa
aiaaaaaafgafbaaaakaaaaaaegaobaaaagaaaaaadiaaaaahpcaabaaaagaaaaaa
pgapbaaaahaaaaaaegaobaaaagaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaa
afaaaaaakgakbaaaadaaaaaaegaobaaaagaaaaaadcaaaaakpcaabaaaadaaaaaa
egaobaiaebaaaaaaadaaaaaaegacbaaaacaaaaaaegaobaaaalaaaaaadeaaaaak
pcaabaaaadaaaaaaegaobaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaipcaabaaaadaaaaaaegaobaiaebaaaaaaamaaaaaaegaobaaa
adaaaaaadcaaaaajpcaabaaaadaaaaaakgakbaaaabaaaaaaegaobaaaadaaaaaa
egaobaaaamaaaaaabcaaaaabdiaaaaajicaabaaaaaaaaaaabkiacaaaaaaaaaaa
adaaaaaabkiacaaaaaaaaaaaadaaaaaadcaaaaamecaabaaaabaaaaaackiacaaa
aaaaaaaaadaaaaaackiacaaaaaaaaaaaadaaaaaadkaabaiaebaaaaaaaaaaaaaa
elaaaaafecaabaaaafaaaaaackaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaa
dkaabaaaacaaaaaadkaabaaaacaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaaa
acaaaaaadkaabaaaacaaaaaadkaabaiaebaaaaaaaaaaaaaaelaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaaeaaaaaa
dkaabaaaacaaaaaadcaaaaakecaabaaaabaaaaaadkaabaaaacaaaaaadkaabaaa
acaaaaaackaabaiaebaaaaaaabaaaaaadcaaaaalecaabaaaabaaaaaabkiacaaa
aaaaaaaaadaaaaaabkiacaaaaaaaaaaaadaaaaaackaabaaaabaaaaaadbaaaaah
bcaabaaaaeaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaaadbaaaaahccaabaaa
aeaaaaaaabeaaaaaaaaaaaaackaabaaaabaaaaaaabaaaaahbcaabaaaaeaaaaaa
bkaabaaaaeaaaaaaakaabaaaaeaaaaaaaoaaaaalocaabaaaaeaaaaaaaceaaaaa
aaaaaaaaaaaaaadpaaaaaadpaaaaaadpfgiicaaaaaaaaaaaaeaaaaaaaaaaaaai
icaabaaaagaaaaaabkaabaiaebaaaaaaaeaaaaaaabeaaaaaaaaaaadpdiaaaaah
ccaabaaaafaaaaaackaabaaaafaaaaaackaabaaaafaaaaaaaaaaaaahicaabaaa
afaaaaaabkaabaaaaeaaaaaaabeaaaaaaaaaaadpdgaaaaaihcaabaaaagaaaaaa
aceaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaadgaaaaafbcaabaaaafaaaaaa
abeaaaaaaaaaialpdhaaaaajpcaabaaaahaaaaaaagaabaaaaeaaaaaaigaobaaa
agaaaaaaegaobaaaafaaaaaaaoaaaaahbcaabaaaaeaaaaaadkaabaaaaaaaaaaa
ckaabaaaafaaaaaaaoaaaaalhcaabaaaaiaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpegiccaaaaaaaaaaaaeaaaaaaaaaaaaalhcaabaaaaiaaaaaa
egacbaiaebaaaaaaaiaaaaaaaceaaaaaaaaaiadpaaaaaadpaaaaiadpaaaaaaaa
dcaaaaajbcaabaaaaeaaaaaaakaabaaaaeaaaaaaakaabaaaaiaaaaaackaabaaa
aeaaaaaaaaaaaaahecaabaaaabaaaaaackaabaaaabaaaaaabkaabaaaahaaaaaa
elaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadcaaaaajecaabaaaabaaaaaa
dkaabaaaacaaaaaaakaabaaaahaaaaaackaabaaaabaaaaaaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaackaabaaaahaaaaaaaoaaaaahicaabaaaaaaaaaaa
ckaabaaaabaaaaaadkaabaaaaaaaaaaadcaaaaajicaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaaiaaaaaadkaabaaaahaaaaaadeaaaaahecaabaaaabaaaaaa
akaabaaaaaaaaaaaabeaaaaahbdneklodiaaaaahecaabaaaabaaaaaackaabaaa
abaaaaaaabeaaaaabodakleaddaaaaaiicaabaaaacaaaaaackaabaiaibaaaaaa
abaaaaaaabeaaaaaaaaaiadpdeaaaaaiccaabaaaaeaaaaaackaabaiaibaaaaaa
abaaaaaaabeaaaaaaaaaiadpaoaaaaakccaabaaaaeaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpbkaabaaaaeaaaaaadiaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaabkaabaaaaeaaaaaadiaaaaahccaabaaaaeaaaaaadkaabaaa
acaaaaaadkaabaaaacaaaaaadcaaaaajbcaabaaaahaaaaaabkaabaaaaeaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajbcaabaaaahaaaaaabkaabaaa
aeaaaaaaakaabaaaahaaaaaaabeaaaaaochgdidodcaaaaajbcaabaaaahaaaaaa
bkaabaaaaeaaaaaaakaabaaaahaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaa
aeaaaaaabkaabaaaaeaaaaaaakaabaaaahaaaaaaabeaaaaadiphhpdpdiaaaaah
bcaabaaaahaaaaaadkaabaaaacaaaaaabkaabaaaaeaaaaaadbaaaaaiccaabaaa
ahaaaaaaabeaaaaaaaaaiadpckaabaiaibaaaaaaabaaaaaadcaaaaajbcaabaaa
ahaaaaaaakaabaaaahaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpabaaaaah
bcaabaaaahaaaaaabkaabaaaahaaaaaaakaabaaaahaaaaaadcaaaaajicaabaaa
acaaaaaadkaabaaaacaaaaaabkaabaaaaeaaaaaaakaabaaaahaaaaaaddaaaaah
ecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaiadpdbaaaaaiecaabaaa
abaaaaaackaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaadhaaaaakecaabaaa
abaaaaaackaabaaaabaaaaaadkaabaiaebaaaaaaacaaaaaadkaabaaaacaaaaaa
dcaaaaajecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaacolkgidpabeaaaaa
kehadndpdiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaadp
dcaaaaajecaabaaaabaaaaaackaabaaaabaaaaaackaabaaaaiaaaaaadkaabaaa
aeaaaaaaaaaaaaahicaabaaaacaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadp
diaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaadpaaaaaaai
ccaabaaaaeaaaaaadkiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaialpdiaaaaah
bcaabaaaahaaaaaadkaabaaaacaaaaaabkaabaaaaeaaaaaaebaaaaafbcaabaaa
ahaaaaaaakaabaaaahaaaaaadcaaaaakicaabaaaacaaaaaadkaabaaaacaaaaaa
bkaabaaaaeaaaaaaakaabaiaebaaaaaaahaaaaaadiaaaaaiccaabaaaaeaaaaaa
akaabaaaaeaaaaaaakiacaaaaaaaaaaaaeaaaaaadcaaaaakbcaabaaaaeaaaaaa
akaabaaaaeaaaaaaakiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaialpebaaaaaf
bcaabaaaaeaaaaaaakaabaaaaeaaaaaaaoaaaaaibcaabaaaaeaaaaaaakaabaaa
aeaaaaaaakiacaaaaaaaaaaaaeaaaaaaebaaaaafccaabaaaahaaaaaabkaabaaa
aeaaaaaaaoaaaaaiccaabaaaahaaaaaabkaabaaaahaaaaaaakiacaaaaaaaaaaa
aeaaaaaabkaaaaafccaabaaaaeaaaaaabkaabaaaaeaaaaaaaaaaaaahecaabaaa
abaaaaaackaabaaaabaaaaaaakaabaaaahaaaaaaaoaaaaaiccaabaaaajaaaaaa
ckaabaaaabaaaaaadkiacaaaaaaaaaaaaeaaaaaaaoaaaaaiicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakiacaaaaaaaaaaaaeaaaaaaaaaaaaahecaabaaaajaaaaaa
akaabaaaaeaaaaaadkaabaaaaaaaaaaaeiaaaaalpcaabaaaakaaaaaajgafbaaa
ajaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaai
bcaabaaaaeaaaaaadkaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaiadpaaaaaaah
ecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaiadpaoaaaaaibcaabaaa
ajaaaaaackaabaaaabaaaaaadkiacaaaaaaaaaaaaeaaaaaaeiaaaaalpcaabaaa
alaaaaaaigaabaaaajaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaaabeaaaaa
aaaaaaaadiaaaaahpcaabaaaalaaaaaapgapbaaaacaaaaaaegaobaaaalaaaaaa
dcaaaaajpcaabaaaakaaaaaaegaobaaaakaaaaaaagaabaaaaeaaaaaaegaobaaa
alaaaaaaaaaaaaahicaabaaaajaaaaaabkaabaaaahaaaaaadkaabaaaaaaaaaaa
eiaaaaalpcaabaaaalaaaaaangafbaaaajaaaaaaeghobaaaacaaaaaaaagabaaa
abaaaaaaabeaaaaaaaaaaaaaeiaaaaalpcaabaaaajaaaaaamgaabaaaajaaaaaa
eghobaaaacaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaahpcaabaaa
ajaaaaaapgapbaaaacaaaaaaegaobaaaajaaaaaadcaaaaajpcaabaaaajaaaaaa
egaobaaaalaaaaaaagaabaaaaeaaaaaaegaobaaaajaaaaaaaaaaaaaiicaabaaa
aaaaaaaabkaabaiaebaaaaaaaeaaaaaaabeaaaaaaaaaiadpdiaaaaahpcaabaaa
ajaaaaaafgafbaaaaeaaaaaaegaobaaaajaaaaaadcaaaaajpcaabaaaajaaaaaa
egaobaaaakaaaaaapgapbaaaaaaaaaaaegaobaaaajaaaaaadcaaaaamicaabaaa
aaaaaaaabkiacaiaebaaaaaaaaaaaaaaadaaaaaabkiacaaaaaaaaaaaadaaaaaa
ckaabaaaaaaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaak
ecaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaackaabaiaebaaaaaa
aaaaaaaadcaaaaalecaabaaaaaaaaaaabkiacaaaaaaaaaaaadaaaaaabkiacaaa
aaaaaaaaadaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaadbaaaaahccaabaaaaeaaaaaaabeaaaaaaaaaaaaa
ckaabaaaaaaaaaaaabaaaaahecaabaaaabaaaaaackaabaaaabaaaaaabkaabaaa
aeaaaaaadhaaaaajpcaabaaaagaaaaaakgakbaaaabaaaaaaegaobaaaagaaaaaa
egaobaaaafaaaaaaaoaaaaahecaabaaaabaaaaaadkaabaaaaaaaaaaackaabaaa
afaaaaaadcaaaaajecaabaaaabaaaaaackaabaaaabaaaaaaakaabaaaaiaaaaaa
ckaabaaaaeaaaaaaaaaaaaahmcaabaaaaaaaaaaakgaobaaaaaaaaaaafgajbaaa
agaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaaakaabaaaabaaaaaaakaabaaaagaaaaaackaabaaaaaaaaaaaaoaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaaaaiaaaaaadkaabaaaagaaaaaadeaaaaah
icaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaahbdneklodiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaabodakleaddaaaaaibcaabaaaabaaaaaa
dkaabaiaibaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaaiicaabaaaabaaaaaa
dkaabaiaibaaaaaaaaaaaaaaabeaaaaaaaaaiadpaoaaaaakicaabaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaabaaaaaadiaaaaah
bcaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaa
abaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaajccaabaaaaeaaaaaa
dkaabaaaabaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajccaabaaa
aeaaaaaadkaabaaaabaaaaaabkaabaaaaeaaaaaaabeaaaaaochgdidodcaaaaaj
ccaabaaaaeaaaaaadkaabaaaabaaaaaabkaabaaaaeaaaaaaabeaaaaaaebnkjlo
dcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaabkaabaaaaeaaaaaaabeaaaaa
diphhpdpdiaaaaahccaabaaaaeaaaaaadkaabaaaabaaaaaaakaabaaaabaaaaaa
dbaaaaaiecaabaaaaeaaaaaaabeaaaaaaaaaiadpdkaabaiaibaaaaaaaaaaaaaa
dcaaaaajccaabaaaaeaaaaaabkaabaaaaeaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapmjdpabaaaaahccaabaaaaeaaaaaackaabaaaaeaaaaaabkaabaaaaeaaaaaa
dcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaadkaabaaaabaaaaaabkaabaaa
aeaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadp
dbaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
dhaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaa
akaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
colkgidpabeaaaaakehadndpdiaaaaahicaabaaaaaaaaaaackaabaaaaiaaaaaa
dkaabaaaaaaaaaaadcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaadpdkaabaaaaeaaaaaadiaaaaaibcaabaaaabaaaaaackaabaaaabaaaaaa
akiacaaaaaaaaaaaaeaaaaaadcaaaaakecaabaaaabaaaaaackaabaaaabaaaaaa
akiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaialpebaaaaafmcaabaaaabaaaaaa
kgacbaaaabaaaaaaaoaaaaaimcaabaaaabaaaaaakgaobaaaabaaaaaaagiacaaa
aaaaaaaaaeaaaaaabkaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaaaaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaahaaaaaaaoaaaaaiccaabaaa
afaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaaeaaaaaaaoaaaaaiecaabaaa
aaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaaeaaaaaaaaaaaaahmcaabaaa
afaaaaaakgaobaaaabaaaaaakgakbaaaaaaaaaaaeiaaaaalpcaabaaaagaaaaaa
jgafbaaaafaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaa
aaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaoaaaaai
bcaabaaaafaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaaeaaaaaaeiaaaaal
pcaabaaaahaaaaaaigaabaaaafaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaa
abeaaaaaaaaaaaaadiaaaaahpcaabaaaahaaaaaapgapbaaaacaaaaaaegaobaaa
ahaaaaaadcaaaaajpcaabaaaagaaaaaaegaobaaaagaaaaaaagaabaaaaeaaaaaa
egaobaaaahaaaaaaeiaaaaalpcaabaaaahaaaaaangafbaaaafaaaaaaeghobaaa
acaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaaeiaaaaalpcaabaaaafaaaaaa
mgaabaaaafaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaa
diaaaaahpcaabaaaafaaaaaapgapbaaaacaaaaaaegaobaaaafaaaaaadcaaaaaj
pcaabaaaaeaaaaaaegaobaaaahaaaaaaagaabaaaaeaaaaaaegaobaaaafaaaaaa
aaaaaaaiecaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
diaaaaahpcaabaaaaeaaaaaaagaabaaaabaaaaaaegaobaaaaeaaaaaadcaaaaaj
pcaabaaaaeaaaaaaegaobaaaagaaaaaakgakbaaaaaaaaaaaegaobaaaaeaaaaaa
dcaaaaakpcaabaaaacaaaaaaegaobaiaebaaaaaaaeaaaaaaegacbaaaacaaaaaa
egaobaaaajaaaaaadeaaaaakpcaabaaaadaaaaaaegaobaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabfaaaaabdicaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaeiecdcaaaaajecaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaaaadaaaaaadiaaaaahncaabaaaaaaaaaaaagaabaaaaaaaaaaaagajbaaa
adaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaaadaaaaaaabeaaaaabhlhnbdi
aoaaaaahncaabaaaaaaaaaaaagaobaaaaaaaaaaaagaabaaaabaaaaaaaoaaaaaj
ncaabaaaabaaaaaaagiacaaaaaaaaaaaagaaaaaaagijcaaaaaaaaaaaagaaaaaa
diaaaaahncaabaaaaaaaaaaaagaobaaaaaaaaaaaagaobaaaabaaaaaadiaaaaal
fcaabaaaabaaaaaaagiacaaaaaaaaaaaacaaaaaaaceaaaaaaaaaiaebaaaaaaaa
aaaaiaeaaaaaaaaaaoaaaaakfcaabaaaabaaaaaaaceaaaaaaaaaeaeaaaaaaaaa
aaaamadpaaaaaaaaagacbaaaabaaaaaadcaaaaajicaabaaaabaaaaaabkaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadpdcaaaaambcaabaaaacaaaaaa
dkiacaiaebaaaaaaaaaaaaaaagaaaaaadkiacaaaaaaaaaaaagaaaaaaabeaaaaa
aaaaiadpdiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaaakaabaaaacaaaaaa
dcaaaaaodcaabaaaacaaaaaapgipcaaaaaaaaaaaagaaaaaapgipcaaaaaaaaaaa
agaaaaaaaceaaaaaaaaaiadpaaaaaaeaaaaaaaaaaaaaaaaaapaaaaaiccaabaaa
abaaaaaafgafbaaaabaaaaaapgipcaaaaaaaaaaaagaaaaaaaaaaaaaiccaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaacpaaaaafccaabaaa
abaaaaaabkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaa
abeaaaaaaaaamalpbjaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaah
dcaabaaaabaaaaaahgapbaaaabaaaaaaigaabaaaabaaaaaadiaaaaahccaabaaa
abaaaaaadkaabaaaabaaaaaabkaabaaaabaaaaaaaoaaaaahccaabaaaabaaaaaa
bkaabaaaabaaaaaabkaabaaaacaaaaaadiaaaaahncaabaaaaaaaaaaaagaobaaa
aaaaaaaafgafbaaaabaaaaaadcaaaaajncaabaaaaaaaaaaaagajbaaaadaaaaaa
agaabaaaabaaaaaaagaobaaaaaaaaaaabcaaaaabdgaaaaaincaabaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabfaaaaabdiaaaaaincaabaaa
aaaaaaaaagaobaaaaaaaaaaapgipcaaaaaaaaaaaafaaaaaabnaaaaaibcaabaaa
abaaaaaaakiacaaaaaaaaaaaamaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiaeaaoaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaadlkklilpbjaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdhaaaaajccaabaaaaaaaaaaaakaabaaaabaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaiadpdiaaaaaincaabaaaaaaaaaaaagaobaaaaaaaaaaapgipcaaa
aaaaaaaaalaaaaaadbaaaaakhcaabaaaabaaaaaaigadbaaaaaaaaaaaaceaaaaa
cpnnledpcpnnledpcpnnledpaaaaaaaadiaaaaakpcaabaaaacaaaaaaagakbaaa
aaaaaaaaaceaaaaanmcomedodlkklilpnmcomedodlkklilpcpaaaaaffcaabaaa
aaaaaaaaagacbaaaacaaaaaadiaaaaakfcaabaaaaaaaaaaaagacbaaaaaaaaaaa
aceaaaaacplkoidoaaaaaaaacplkoidoaaaaaaaabjaaaaaffcaabaaaaaaaaaaa
agacbaaaaaaaaaaabjaaaaafdcaabaaaacaaaaaangafbaaaacaaaaaaaaaaaaal
dcaabaaaacaaaaaaegaabaiaebaaaaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaaaaaaaaaaaaadhaaaaajdccabaaaaaaaaaaaegaabaaaabaaaaaaigaabaaa
aaaaaaaaegaabaaaacaaaaaadiaaaaakfcaabaaaaaaaaaaapgapbaaaaaaaaaaa
aceaaaaanmcomedoaaaaaaaadlkklilpaaaaaaaacpaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
cplkoidobjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaabjaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaaaaaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdhaaaaajeccabaaaaaaaaaaackaabaaaabaaaaaa
akaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaiiccabaaaaaaaaaaabkaabaaa
aaaaaaaackiacaaaaaaaaaaaalaaaaaadoaaaaab"
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