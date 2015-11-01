Shader "scatterer/Scaled Planet (RimAerial)"
{
    Properties {
        _Color ("Main Color", Color) = (1,1,1,1)
        _SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
        _Shininess ("Shininess", Range(0.03,1)) = 0.078125
        _MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}
        _BumpMap ("Normalmap", 2D) = "bump" {}
        _Opacity ("Opacity", Range(0,1)) = 1
        _rimPower ("Rim Power", Float) = 3
        _rimBlend ("Rim Blend", Float) = 1
        _rimColorRamp ("RimColorRamp", 2D) = "white" {}
        _localLightDirection ("LightDirection", Vector) = (1,0,0,0)
        _ResourceMap ("Resource Map (RGB)", 2D) = "black" {}
    }
    SubShader {
//	ZWrite On
//        LOD 400
	ZWrite On
	LOD 400	
	Tags {"RenderType"="Opaque" }


        Pass {
            Name "FORWARD"
            Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" }
            Blend SrcAlpha OneMinusSrcAlpha
            Program "vp" {
// Platform d3d11 had shader errors
//   Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
//   Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
//   Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
//   Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
//   Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
//   Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
//   Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
//   Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
                SubProgram "opengl " {
                    Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" ATTR14
                    Matrix 5 [_Object2World]
                    Matrix 9 [_World2Object]
                    Vector 13 [_WorldSpaceCameraPos]
                    Vector 14 [_WorldSpaceLightPos0]
                    Vector 15 [unity_SHAr]
                    Vector 16 [unity_SHAg]
                    Vector 17 [unity_SHAb]
                    Vector 18 [unity_SHBr]
                    Vector 19 [unity_SHBg]
                    Vector 20 [unity_SHBb]
                    Vector 21 [unity_SHC]
                    Vector 22 [unity_Scale]
                    Vector 23 [_localLightDirection]
                    Vector 24 [_MainTex_ST]
                    Vector 25 [_BumpMap_ST]
                    Vector 26 [_ResourceMap_ST]
                    "3.0-!!ARBvp1.0
                    PARAM c[27] = { { 1 },
                    state.matrix.mvp,
                    program.local[5..26] };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    MUL R1.xyz, vertex.normal, c[22].w;
                    DP3 R2.w, R1, c[6];
                    DP3 R0.x, R1, c[5];
                    DP3 R0.z, R1, c[7];
                    MOV R0.y, R2.w;
                    MUL R1, R0.xyzz, R0.yzzx;
                    MOV R0.w, c[0].x;
                    DP4 R2.z, R0, c[17];
                    DP4 R2.y, R0, c[16];
                    DP4 R2.x, R0, c[15];
                    MUL R0.y, R2.w, R2.w;
                    DP4 R3.z, R1, c[20];
                    DP4 R3.y, R1, c[19];
                    DP4 R3.x, R1, c[18];
                    ADD R2.xyz, R2, R3;
                    MAD R0.x, R0, R0, -R0.y;
                    MUL R3.xyz, R0.x, c[21];
                    MOV R1.xyz, vertex.attrib[14];
                    MUL R0.xyz, vertex.normal.zxyw, R1.yzxw;
                    MAD R1.xyz, vertex.normal.yzxw, R1.zxyw, -R0;
                    ADD result.texcoord[5].xyz, R2, R3;
                    MOV R0.xyz, c[13];
                    MOV R0.w, c[0].x;
                    DP4 R2.z, R0, c[11];
                    DP4 R2.x, R0, c[9];
                    DP4 R2.y, R0, c[10];
                    MAD R0.xyz, R2, c[22].w, -vertex.position;
                    MUL R2.xyz, R1, vertex.attrib[14].w;
                    MOV R1, c[14];
                    DP4 R3.z, R1, c[11];
                    DP4 R3.x, R1, c[9];
                    DP4 R3.y, R1, c[10];
                    DP3 result.texcoord[2].y, R0, R2;
                    DP3 result.texcoord[4].y, R2, R3;
                    DP3 result.texcoord[2].z, vertex.normal, R0;
                    DP3 result.texcoord[2].x, R0, vertex.attrib[14];
                    DP3 result.texcoord[4].z, vertex.normal, R3;
                    DP3 result.texcoord[4].x, vertex.attrib[14], R3;
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[25].xyxy, c[25];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[24], c[24].zwzw;
                    MAD result.texcoord[1].xy, vertex.texcoord[0], c[26], c[26].zwzw;
                    DP4 result.position.w, vertex.position, c[4];
                    DP4 result.position.z, vertex.position, c[3];
                    DP4 result.position.y, vertex.position, c[2];
                    DP4 result.position.x, vertex.position, c[1];
                    DP3 result.texcoord[3].x, vertex.normal, c[23];
                    END
# 46 instructions, 4 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" TexCoord2
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 4 [_Object2World]
                    Matrix 8 [_World2Object]
                    Vector 12 [_WorldSpaceCameraPos]
                    Vector 13 [_WorldSpaceLightPos0]
                    Vector 14 [unity_SHAr]
                    Vector 15 [unity_SHAg]
                    Vector 16 [unity_SHAb]
                    Vector 17 [unity_SHBr]
                    Vector 18 [unity_SHBg]
                    Vector 19 [unity_SHBb]
                    Vector 20 [unity_SHC]
                    Vector 21 [unity_Scale]
                    Vector 22 [_localLightDirection]
                    Vector 23 [_MainTex_ST]
                    Vector 24 [_BumpMap_ST]
                    Vector 25 [_ResourceMap_ST]
                    "vs_3_0
                    dcl_position o0
                    dcl_texcoord0 o1
                    dcl_texcoord1 o2
                    dcl_texcoord2 o3
                    dcl_texcoord3 o4
                    dcl_texcoord4 o5
                    dcl_texcoord5 o6
                    def c26, 1.00000000, 0, 0, 0
                    dcl_position0 v0
                    dcl_tangent0 v1
                    dcl_normal0 v2
                    dcl_texcoord0 v3
                    mul r1.xyz, v2, c21.w
                    dp3 r2.w, r1, c5
                    dp3 r0.x, r1, c4
                    dp3 r0.z, r1, c6
                    mov r0.y, r2.w
                    mul r1, r0.xyzz, r0.yzzx
                    mov r0.w, c26.x
                    dp4 r2.z, r0, c16
                    dp4 r2.y, r0, c15
                    dp4 r2.x, r0, c14
                    mul r0.y, r2.w, r2.w
                    dp4 r3.z, r1, c19
                    dp4 r3.y, r1, c18
                    dp4 r3.x, r1, c17
                    add r1.xyz, r2, r3
                    mad r0.x, r0, r0, -r0.y
                    mul r2.xyz, r0.x, c20
                    add o6.xyz, r1, r2
                    mov r0.xyz, v1
                    mul r1.xyz, v2.zxyw, r0.yzxw
                    mov r0.xyz, v1
                    mad r0.xyz, v2.yzxw, r0.zxyw, -r1
                    mul r3.xyz, r0, v1.w
                    mov r0, c10
                    dp4 r4.z, c13, r0
                    mov r0, c9
                    mov r1.w, c26.x
                    mov r1.xyz, c12
                    dp4 r4.y, c13, r0
                    dp4 r2.z, r1, c10
                    dp4 r2.x, r1, c8
                    dp4 r2.y, r1, c9
                    mad r2.xyz, r2, c21.w, -v0
                    mov r1, c8
                    dp4 r4.x, c13, r1
                    dp3 o3.y, r2, r3
                    dp3 o5.y, r3, r4
                    dp3 o3.z, v2, r2
                    dp3 o3.x, r2, v1
                    dp3 o5.z, v2, r4
                    dp3 o5.x, v1, r4
                    mad o1.zw, v3.xyxy, c24.xyxy, c24
                    mad o1.xy, v3, c23, c23.zwzw
                    mad o2.xy, v3, c25, c25.zwzw
                    dp4 o0.w, v0, c3
                    dp4 o0.z, v0, c2
                    dp4 o0.y, v0, c1
                    dp4 o0.x, v0, c0
                    dp3 o4.x, v2, c22
                    "
                }
                SubProgram "opengl " {
                    Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    Bind "tangent" ATTR14
                    Matrix 9 [_World2Object]
                    Vector 13 [_WorldSpaceCameraPos]
                    Vector 15 [unity_Scale]
                    Vector 16 [_localLightDirection]
                    Vector 17 [unity_LightmapST]
                    Vector 18 [_MainTex_ST]
                    Vector 19 [_BumpMap_ST]
                    Vector 20 [_ResourceMap_ST]
                    "3.0-!!ARBvp1.0
                    PARAM c[21] = { { 1 },
                    state.matrix.mvp,
                    program.local[5..20] };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    MOV R0.xyz, vertex.attrib[14];
                    MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
                    MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
                    MUL R1.xyz, R0, vertex.attrib[14].w;
                    MOV R0.xyz, c[13];
                    MOV R0.w, c[0].x;
                    DP4 R2.z, R0, c[11];
                    DP4 R2.x, R0, c[9];
                    DP4 R2.y, R0, c[10];
                    MAD R0.xyz, R2, c[15].w, -vertex.position;
                    DP3 result.texcoord[2].y, R0, R1;
                    DP3 result.texcoord[2].z, vertex.normal, R0;
                    DP3 result.texcoord[2].x, R0, vertex.attrib[14];
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
                    MAD result.texcoord[1].xy, vertex.texcoord[0], c[20], c[20].zwzw;
                    MAD result.texcoord[4].xy, vertex.texcoord[1], c[17], c[17].zwzw;
                    DP4 result.position.w, vertex.position, c[4];
                    DP4 result.position.z, vertex.position, c[3];
                    DP4 result.position.y, vertex.position, c[2];
                    DP4 result.position.x, vertex.position, c[1];
                    DP3 result.texcoord[3].x, vertex.normal, c[16];
                    END
# 22 instructions, 3 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    Bind "tangent" TexCoord2
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 8 [_World2Object]
                    Vector 12 [_WorldSpaceCameraPos]
                    Vector 13 [unity_Scale]
                    Vector 14 [_localLightDirection]
                    Vector 15 [unity_LightmapST]
                    Vector 16 [_MainTex_ST]
                    Vector 17 [_BumpMap_ST]
                    Vector 18 [_ResourceMap_ST]
                    "vs_3_0
                    dcl_position o0
                    dcl_texcoord0 o1
                    dcl_texcoord1 o2
                    dcl_texcoord2 o3
                    dcl_texcoord3 o4
                    dcl_texcoord4 o5
                    def c19, 1.00000000, 0, 0, 0
                    dcl_position0 v0
                    dcl_tangent0 v1
                    dcl_normal0 v2
                    dcl_texcoord0 v3
                    dcl_texcoord1 v4
                    mov r0.xyz, v1
                    mul r1.xyz, v2.zxyw, r0.yzxw
                    mov r0.xyz, v1
                    mad r0.xyz, v2.yzxw, r0.zxyw, -r1
                    mul r1.xyz, r0, v1.w
                    mov r0.xyz, c12
                    mov r0.w, c19.x
                    dp4 r2.z, r0, c10
                    dp4 r2.x, r0, c8
                    dp4 r2.y, r0, c9
                    mad r0.xyz, r2, c13.w, -v0
                    dp3 o3.y, r0, r1
                    dp3 o3.z, v2, r0
                    dp3 o3.x, r0, v1
                    mad o1.zw, v3.xyxy, c17.xyxy, c17
                    mad o1.xy, v3, c16, c16.zwzw
                    mad o2.xy, v3, c18, c18.zwzw
                    mad o5.xy, v4, c15, c15.zwzw
                    dp4 o0.w, v0, c3
                    dp4 o0.z, v0, c2
                    dp4 o0.y, v0, c1
                    dp4 o0.x, v0, c0
                    dp3 o4.x, v2, c14
                    "
                }
                SubProgram "opengl " {
                    Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    Bind "tangent" ATTR14
                    Matrix 9 [_World2Object]
                    Vector 13 [_WorldSpaceCameraPos]
                    Vector 15 [unity_Scale]
                    Vector 16 [_localLightDirection]
                    Vector 17 [unity_LightmapST]
                    Vector 18 [_MainTex_ST]
                    Vector 19 [_BumpMap_ST]
                    Vector 20 [_ResourceMap_ST]
                    "3.0-!!ARBvp1.0
                    PARAM c[21] = { { 1 },
                    state.matrix.mvp,
                    program.local[5..20] };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    MOV R0.xyz, vertex.attrib[14];
                    MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
                    MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
                    MUL R1.xyz, R0, vertex.attrib[14].w;
                    MOV R0.xyz, c[13];
                    MOV R0.w, c[0].x;
                    DP4 R2.z, R0, c[11];
                    DP4 R2.x, R0, c[9];
                    DP4 R2.y, R0, c[10];
                    MAD R0.xyz, R2, c[15].w, -vertex.position;
                    DP3 result.texcoord[2].y, R0, R1;
                    DP3 result.texcoord[2].z, vertex.normal, R0;
                    DP3 result.texcoord[2].x, R0, vertex.attrib[14];
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
                    MAD result.texcoord[1].xy, vertex.texcoord[0], c[20], c[20].zwzw;
                    MAD result.texcoord[4].xy, vertex.texcoord[1], c[17], c[17].zwzw;
                    DP4 result.position.w, vertex.position, c[4];
                    DP4 result.position.z, vertex.position, c[3];
                    DP4 result.position.y, vertex.position, c[2];
                    DP4 result.position.x, vertex.position, c[1];
                    DP3 result.texcoord[3].x, vertex.normal, c[16];
                    END
# 22 instructions, 3 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    Bind "tangent" TexCoord2
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 8 [_World2Object]
                    Vector 12 [_WorldSpaceCameraPos]
                    Vector 13 [unity_Scale]
                    Vector 14 [_localLightDirection]
                    Vector 15 [unity_LightmapST]
                    Vector 16 [_MainTex_ST]
                    Vector 17 [_BumpMap_ST]
                    Vector 18 [_ResourceMap_ST]
                    "vs_3_0
                    dcl_position o0
                    dcl_texcoord0 o1
                    dcl_texcoord1 o2
                    dcl_texcoord2 o3
                    dcl_texcoord3 o4
                    dcl_texcoord4 o5
                    def c19, 1.00000000, 0, 0, 0
                    dcl_position0 v0
                    dcl_tangent0 v1
                    dcl_normal0 v2
                    dcl_texcoord0 v3
                    dcl_texcoord1 v4
                    mov r0.xyz, v1
                    mul r1.xyz, v2.zxyw, r0.yzxw
                    mov r0.xyz, v1
                    mad r0.xyz, v2.yzxw, r0.zxyw, -r1
                    mul r1.xyz, r0, v1.w
                    mov r0.xyz, c12
                    mov r0.w, c19.x
                    dp4 r2.z, r0, c10
                    dp4 r2.x, r0, c8
                    dp4 r2.y, r0, c9
                    mad r0.xyz, r2, c13.w, -v0
                    dp3 o3.y, r0, r1
                    dp3 o3.z, v2, r0
                    dp3 o3.x, r0, v1
                    mad o1.zw, v3.xyxy, c17.xyxy, c17
                    mad o1.xy, v3, c16, c16.zwzw
                    mad o2.xy, v3, c18, c18.zwzw
                    mad o5.xy, v4, c15, c15.zwzw
                    dp4 o0.w, v0, c3
                    dp4 o0.z, v0, c2
                    dp4 o0.y, v0, c1
                    dp4 o0.x, v0, c0
                    dp3 o4.x, v2, c14
                    "
                }
                SubProgram "opengl " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" ATTR14
                    Matrix 5 [_Object2World]
                    Matrix 9 [_World2Object]
                    Vector 13 [_WorldSpaceCameraPos]
                    Vector 14 [_ProjectionParams]
                    Vector 15 [_WorldSpaceLightPos0]
                    Vector 16 [unity_SHAr]
                    Vector 17 [unity_SHAg]
                    Vector 18 [unity_SHAb]
                    Vector 19 [unity_SHBr]
                    Vector 20 [unity_SHBg]
                    Vector 21 [unity_SHBb]
                    Vector 22 [unity_SHC]
                    Vector 23 [unity_Scale]
                    Vector 24 [_localLightDirection]
                    Vector 25 [_MainTex_ST]
                    Vector 26 [_BumpMap_ST]
                    Vector 27 [_ResourceMap_ST]
                    "3.0-!!ARBvp1.0
                    PARAM c[28] = { { 1, 0.5 },
                    state.matrix.mvp,
                    program.local[5..27] };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    MUL R1.xyz, vertex.normal, c[23].w;
                    DP3 R2.w, R1, c[6];
                    DP3 R0.x, R1, c[5];
                    DP3 R0.z, R1, c[7];
                    MOV R0.y, R2.w;
                    MUL R1, R0.xyzz, R0.yzzx;
                    MOV R0.w, c[0].x;
                    DP4 R2.z, R0, c[18];
                    DP4 R2.y, R0, c[17];
                    DP4 R2.x, R0, c[16];
                    MUL R0.y, R2.w, R2.w;
                    DP4 R3.z, R1, c[21];
                    DP4 R3.y, R1, c[20];
                    DP4 R3.x, R1, c[19];
                    ADD R2.xyz, R2, R3;
                    MAD R0.x, R0, R0, -R0.y;
                    MUL R3.xyz, R0.x, c[22];
                    MOV R1.xyz, vertex.attrib[14];
                    MUL R0.xyz, vertex.normal.zxyw, R1.yzxw;
                    MAD R1.xyz, vertex.normal.yzxw, R1.zxyw, -R0;
                    ADD result.texcoord[5].xyz, R2, R3;
                    MOV R0.w, c[0].x;
                    MOV R0.xyz, c[13];
                    DP4 R2.z, R0, c[11];
                    DP4 R2.x, R0, c[9];
                    DP4 R2.y, R0, c[10];
                    MAD R0.xyz, R2, c[23].w, -vertex.position;
                    MUL R2.xyz, R1, vertex.attrib[14].w;
                    MOV R1, c[15];
                    DP4 R3.z, R1, c[11];
                    DP4 R3.x, R1, c[9];
                    DP4 R3.y, R1, c[10];
                    DP3 result.texcoord[2].y, R0, R2;
                    DP3 result.texcoord[2].z, vertex.normal, R0;
                    DP3 result.texcoord[2].x, R0, vertex.attrib[14];
                    DP4 R0.w, vertex.position, c[4];
                    DP4 R0.z, vertex.position, c[3];
                    DP4 R0.x, vertex.position, c[1];
                    DP4 R0.y, vertex.position, c[2];
                    MUL R1.xyz, R0.xyww, c[0].y;
                    MUL R1.y, R1, c[14].x;
                    DP3 result.texcoord[4].y, R2, R3;
                    DP3 result.texcoord[4].z, vertex.normal, R3;
                    DP3 result.texcoord[4].x, vertex.attrib[14], R3;
                    ADD result.texcoord[6].xy, R1, R1.z;
                    MOV result.position, R0;
                    MOV result.texcoord[6].zw, R0;
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[26].xyxy, c[26];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[25], c[25].zwzw;
                    MAD result.texcoord[1].xy, vertex.texcoord[0], c[27], c[27].zwzw;
                    DP3 result.texcoord[3].x, vertex.normal, c[24];
                    END
# 51 instructions, 4 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" TexCoord2
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 4 [_Object2World]
                    Matrix 8 [_World2Object]
                    Vector 12 [_WorldSpaceCameraPos]
                    Vector 13 [_ProjectionParams]
                    Vector 14 [_ScreenParams]
                    Vector 15 [_WorldSpaceLightPos0]
                    Vector 16 [unity_SHAr]
                    Vector 17 [unity_SHAg]
                    Vector 18 [unity_SHAb]
                    Vector 19 [unity_SHBr]
                    Vector 20 [unity_SHBg]
                    Vector 21 [unity_SHBb]
                    Vector 22 [unity_SHC]
                    Vector 23 [unity_Scale]
                    Vector 24 [_localLightDirection]
                    Vector 25 [_MainTex_ST]
                    Vector 26 [_BumpMap_ST]
                    Vector 27 [_ResourceMap_ST]
                    "vs_3_0
                    dcl_position o0
                    dcl_texcoord0 o1
                    dcl_texcoord1 o2
                    dcl_texcoord2 o3
                    dcl_texcoord3 o4
                    dcl_texcoord4 o5
                    dcl_texcoord5 o6
                    dcl_texcoord6 o7
                    def c28, 1.00000000, 0.50000000, 0, 0
                    dcl_position0 v0
                    dcl_tangent0 v1
                    dcl_normal0 v2
                    dcl_texcoord0 v3
                    mul r1.xyz, v2, c23.w
                    dp3 r2.w, r1, c5
                    dp3 r0.x, r1, c4
                    dp3 r0.z, r1, c6
                    mov r0.y, r2.w
                    mul r1, r0.xyzz, r0.yzzx
                    mov r0.w, c28.x
                    dp4 r2.z, r0, c18
                    dp4 r2.y, r0, c17
                    dp4 r2.x, r0, c16
                    mul r0.y, r2.w, r2.w
                    dp4 r3.z, r1, c21
                    dp4 r3.y, r1, c20
                    dp4 r3.x, r1, c19
                    add r1.xyz, r2, r3
                    mad r0.x, r0, r0, -r0.y
                    mul r2.xyz, r0.x, c22
                    add o6.xyz, r1, r2
                    mov r0.xyz, v1
                    mul r1.xyz, v2.zxyw, r0.yzxw
                    mov r0.xyz, v1
                    mad r0.xyz, v2.yzxw, r0.zxyw, -r1
                    mul r3.xyz, r0, v1.w
                    mov r0, c10
                    dp4 r4.z, c15, r0
                    mov r0, c9
                    dp4 r4.y, c15, r0
                    mov r1.w, c28.x
                    mov r1.xyz, c12
                    dp4 r0.w, v0, c3
                    dp4 r0.z, v0, c2
                    dp4 r2.z, r1, c10
                    dp4 r2.x, r1, c8
                    dp4 r2.y, r1, c9
                    mad r2.xyz, r2, c23.w, -v0
                    mov r1, c8
                    dp4 r4.x, c15, r1
                    dp4 r0.x, v0, c0
                    dp4 r0.y, v0, c1
                    mul r1.xyz, r0.xyww, c28.y
                    mul r1.y, r1, c13.x
                    dp3 o3.y, r2, r3
                    dp3 o5.y, r3, r4
                    dp3 o3.z, v2, r2
                    dp3 o3.x, r2, v1
                    dp3 o5.z, v2, r4
                    dp3 o5.x, v1, r4
                    mad o7.xy, r1.z, c14.zwzw, r1
                    mov o0, r0
                    mov o7.zw, r0
                    mad o1.zw, v3.xyxy, c26.xyxy, c26
                    mad o1.xy, v3, c25, c25.zwzw
                    mad o2.xy, v3, c27, c27.zwzw
                    dp3 o4.x, v2, c24
                    "
                }
                SubProgram "opengl " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    Bind "tangent" ATTR14
                    Matrix 9 [_World2Object]
                    Vector 13 [_WorldSpaceCameraPos]
                    Vector 14 [_ProjectionParams]
                    Vector 16 [unity_Scale]
                    Vector 17 [_localLightDirection]
                    Vector 18 [unity_LightmapST]
                    Vector 19 [_MainTex_ST]
                    Vector 20 [_BumpMap_ST]
                    Vector 21 [_ResourceMap_ST]
                    "3.0-!!ARBvp1.0
                    PARAM c[22] = { { 1, 0.5 },
                    state.matrix.mvp,
                    program.local[5..21] };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    MOV R0.xyz, vertex.attrib[14];
                    MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
                    MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
                    MUL R0.xyz, R0, vertex.attrib[14].w;
                    MOV R1.xyz, c[13];
                    MOV R1.w, c[0].x;
                    DP4 R0.w, vertex.position, c[4];
                    DP4 R2.z, R1, c[11];
                    DP4 R2.x, R1, c[9];
                    DP4 R2.y, R1, c[10];
                    MAD R2.xyz, R2, c[16].w, -vertex.position;
                    DP3 result.texcoord[2].y, R2, R0;
                    DP4 R0.z, vertex.position, c[3];
                    DP4 R0.x, vertex.position, c[1];
                    DP4 R0.y, vertex.position, c[2];
                    MUL R1.xyz, R0.xyww, c[0].y;
                    MUL R1.y, R1, c[14].x;
                    DP3 result.texcoord[2].z, vertex.normal, R2;
                    DP3 result.texcoord[2].x, R2, vertex.attrib[14];
                    ADD result.texcoord[5].xy, R1, R1.z;
                    MOV result.position, R0;
                    MOV result.texcoord[5].zw, R0;
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[20].xyxy, c[20];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[19], c[19].zwzw;
                    MAD result.texcoord[1].xy, vertex.texcoord[0], c[21], c[21].zwzw;
                    MAD result.texcoord[4].xy, vertex.texcoord[1], c[18], c[18].zwzw;
                    DP3 result.texcoord[3].x, vertex.normal, c[17];
                    END
# 27 instructions, 3 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    Bind "tangent" TexCoord2
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 8 [_World2Object]
                    Vector 12 [_WorldSpaceCameraPos]
                    Vector 13 [_ProjectionParams]
                    Vector 14 [_ScreenParams]
                    Vector 15 [unity_Scale]
                    Vector 16 [_localLightDirection]
                    Vector 17 [unity_LightmapST]
                    Vector 18 [_MainTex_ST]
                    Vector 19 [_BumpMap_ST]
                    Vector 20 [_ResourceMap_ST]
                    "vs_3_0
                    dcl_position o0
                    dcl_texcoord0 o1
                    dcl_texcoord1 o2
                    dcl_texcoord2 o3
                    dcl_texcoord3 o4
                    dcl_texcoord4 o5
                    dcl_texcoord5 o6
                    def c21, 1.00000000, 0.50000000, 0, 0
                    dcl_position0 v0
                    dcl_tangent0 v1
                    dcl_normal0 v2
                    dcl_texcoord0 v3
                    dcl_texcoord1 v4
                    mov r0.xyz, v1
                    mul r1.xyz, v2.zxyw, r0.yzxw
                    mov r0.xyz, v1
                    mad r0.xyz, v2.yzxw, r0.zxyw, -r1
                    mul r0.xyz, r0, v1.w
                    mov r1.xyz, c12
                    mov r1.w, c21.x
                    dp4 r0.w, v0, c3
                    dp4 r2.z, r1, c10
                    dp4 r2.x, r1, c8
                    dp4 r2.y, r1, c9
                    mad r2.xyz, r2, c15.w, -v0
                    dp3 o3.y, r2, r0
                    dp4 r0.z, v0, c2
                    dp4 r0.x, v0, c0
                    dp4 r0.y, v0, c1
                    mul r1.xyz, r0.xyww, c21.y
                    mul r1.y, r1, c13.x
                    dp3 o3.z, v2, r2
                    dp3 o3.x, r2, v1
                    mad o6.xy, r1.z, c14.zwzw, r1
                    mov o0, r0
                    mov o6.zw, r0
                    mad o1.zw, v3.xyxy, c19.xyxy, c19
                    mad o1.xy, v3, c18, c18.zwzw
                    mad o2.xy, v3, c20, c20.zwzw
                    mad o5.xy, v4, c17, c17.zwzw
                    dp3 o4.x, v2, c16
                    "
                }
                SubProgram "opengl " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    Bind "tangent" ATTR14
                    Matrix 9 [_World2Object]
                    Vector 13 [_WorldSpaceCameraPos]
                    Vector 14 [_ProjectionParams]
                    Vector 16 [unity_Scale]
                    Vector 17 [_localLightDirection]
                    Vector 18 [unity_LightmapST]
                    Vector 19 [_MainTex_ST]
                    Vector 20 [_BumpMap_ST]
                    Vector 21 [_ResourceMap_ST]
                    "3.0-!!ARBvp1.0
                    PARAM c[22] = { { 1, 0.5 },
                    state.matrix.mvp,
                    program.local[5..21] };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    MOV R0.xyz, vertex.attrib[14];
                    MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
                    MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
                    MUL R0.xyz, R0, vertex.attrib[14].w;
                    MOV R1.xyz, c[13];
                    MOV R1.w, c[0].x;
                    DP4 R0.w, vertex.position, c[4];
                    DP4 R2.z, R1, c[11];
                    DP4 R2.x, R1, c[9];
                    DP4 R2.y, R1, c[10];
                    MAD R2.xyz, R2, c[16].w, -vertex.position;
                    DP3 result.texcoord[2].y, R2, R0;
                    DP4 R0.z, vertex.position, c[3];
                    DP4 R0.x, vertex.position, c[1];
                    DP4 R0.y, vertex.position, c[2];
                    MUL R1.xyz, R0.xyww, c[0].y;
                    MUL R1.y, R1, c[14].x;
                    DP3 result.texcoord[2].z, vertex.normal, R2;
                    DP3 result.texcoord[2].x, R2, vertex.attrib[14];
                    ADD result.texcoord[5].xy, R1, R1.z;
                    MOV result.position, R0;
                    MOV result.texcoord[5].zw, R0;
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[20].xyxy, c[20];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[19], c[19].zwzw;
                    MAD result.texcoord[1].xy, vertex.texcoord[0], c[21], c[21].zwzw;
                    MAD result.texcoord[4].xy, vertex.texcoord[1], c[18], c[18].zwzw;
                    DP3 result.texcoord[3].x, vertex.normal, c[17];
                    END
# 27 instructions, 3 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    Bind "tangent" TexCoord2
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 8 [_World2Object]
                    Vector 12 [_WorldSpaceCameraPos]
                    Vector 13 [_ProjectionParams]
                    Vector 14 [_ScreenParams]
                    Vector 15 [unity_Scale]
                    Vector 16 [_localLightDirection]
                    Vector 17 [unity_LightmapST]
                    Vector 18 [_MainTex_ST]
                    Vector 19 [_BumpMap_ST]
                    Vector 20 [_ResourceMap_ST]
                    "vs_3_0
                    dcl_position o0
                    dcl_texcoord0 o1
                    dcl_texcoord1 o2
                    dcl_texcoord2 o3
                    dcl_texcoord3 o4
                    dcl_texcoord4 o5
                    dcl_texcoord5 o6
                    def c21, 1.00000000, 0.50000000, 0, 0
                    dcl_position0 v0
                    dcl_tangent0 v1
                    dcl_normal0 v2
                    dcl_texcoord0 v3
                    dcl_texcoord1 v4
                    mov r0.xyz, v1
                    mul r1.xyz, v2.zxyw, r0.yzxw
                    mov r0.xyz, v1
                    mad r0.xyz, v2.yzxw, r0.zxyw, -r1
                    mul r0.xyz, r0, v1.w
                    mov r1.xyz, c12
                    mov r1.w, c21.x
                    dp4 r0.w, v0, c3
                    dp4 r2.z, r1, c10
                    dp4 r2.x, r1, c8
                    dp4 r2.y, r1, c9
                    mad r2.xyz, r2, c15.w, -v0
                    dp3 o3.y, r2, r0
                    dp4 r0.z, v0, c2
                    dp4 r0.x, v0, c0
                    dp4 r0.y, v0, c1
                    mul r1.xyz, r0.xyww, c21.y
                    mul r1.y, r1, c13.x
                    dp3 o3.z, v2, r2
                    dp3 o3.x, r2, v1
                    mad o6.xy, r1.z, c14.zwzw, r1
                    mov o0, r0
                    mov o6.zw, r0
                    mad o1.zw, v3.xyxy, c19.xyxy, c19
                    mad o1.xy, v3, c18, c18.zwzw
                    mad o2.xy, v3, c20, c20.zwzw
                    mad o5.xy, v4, c17, c17.zwzw
                    dp3 o4.x, v2, c16
                    "
                }
                SubProgram "opengl " {
                    Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" ATTR14
                    Matrix 5 [_Object2World]
                    Matrix 9 [_World2Object]
                    Vector 13 [_WorldSpaceCameraPos]
                    Vector 14 [_WorldSpaceLightPos0]
                    Vector 15 [unity_4LightPosX0]
                    Vector 16 [unity_4LightPosY0]
                    Vector 17 [unity_4LightPosZ0]
                    Vector 18 [unity_4LightAtten0]
                    Vector 19 [unity_LightColor0]
                    Vector 20 [unity_LightColor1]
                    Vector 21 [unity_LightColor2]
                    Vector 22 [unity_LightColor3]
                    Vector 23 [unity_SHAr]
                    Vector 24 [unity_SHAg]
                    Vector 25 [unity_SHAb]
                    Vector 26 [unity_SHBr]
                    Vector 27 [unity_SHBg]
                    Vector 28 [unity_SHBb]
                    Vector 29 [unity_SHC]
                    Vector 30 [unity_Scale]
                    Vector 31 [_localLightDirection]
                    Vector 32 [_MainTex_ST]
                    Vector 33 [_BumpMap_ST]
                    Vector 34 [_ResourceMap_ST]
                    "3.0-!!ARBvp1.0
                    PARAM c[35] = { { 1, 0 },
                    state.matrix.mvp,
                    program.local[5..34] };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    TEMP R4;
                    MUL R3.xyz, vertex.normal, c[30].w;
                    DP4 R0.x, vertex.position, c[6];
                    ADD R1, -R0.x, c[16];
                    DP3 R3.w, R3, c[6];
                    DP3 R4.x, R3, c[5];
                    DP3 R3.x, R3, c[7];
                    MUL R2, R3.w, R1;
                    DP4 R0.x, vertex.position, c[5];
                    ADD R0, -R0.x, c[15];
                    MUL R1, R1, R1;
                    MOV R4.z, R3.x;
                    MAD R2, R4.x, R0, R2;
                    MOV R4.w, c[0].x;
                    DP4 R4.y, vertex.position, c[7];
                    MAD R1, R0, R0, R1;
                    ADD R0, -R4.y, c[17];
                    MAD R1, R0, R0, R1;
                    MAD R0, R3.x, R0, R2;
                    MUL R2, R1, c[18];
                    MOV R4.y, R3.w;
                    RSQ R1.x, R1.x;
                    RSQ R1.y, R1.y;
                    RSQ R1.w, R1.w;
                    RSQ R1.z, R1.z;
                    MUL R0, R0, R1;
                    ADD R1, R2, c[0].x;
                    RCP R1.x, R1.x;
                    RCP R1.y, R1.y;
                    RCP R1.w, R1.w;
                    RCP R1.z, R1.z;
                    MAX R0, R0, c[0].y;
                    MUL R0, R0, R1;
                    MUL R1.xyz, R0.y, c[20];
                    MAD R1.xyz, R0.x, c[19], R1;
                    MAD R0.xyz, R0.z, c[21], R1;
                    MAD R1.xyz, R0.w, c[22], R0;
                    MUL R0, R4.xyzz, R4.yzzx;
                    DP4 R3.z, R0, c[28];
                    DP4 R3.y, R0, c[27];
                    DP4 R3.x, R0, c[26];
                    MUL R1.w, R3, R3;
                    MAD R0.x, R4, R4, -R1.w;
                    MOV R0.w, c[0].x;
                    DP4 R2.z, R4, c[25];
                    DP4 R2.y, R4, c[24];
                    DP4 R2.x, R4, c[23];
                    ADD R2.xyz, R2, R3;
                    MUL R3.xyz, R0.x, c[29];
                    ADD R3.xyz, R2, R3;
                    MOV R0.xyz, vertex.attrib[14];
                    MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
                    ADD result.texcoord[5].xyz, R3, R1;
                    MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
                    MOV R0.xyz, c[13];
                    DP4 R2.z, R0, c[11];
                    DP4 R2.x, R0, c[9];
                    DP4 R2.y, R0, c[10];
                    MAD R0.xyz, R2, c[30].w, -vertex.position;
                    MUL R2.xyz, R1, vertex.attrib[14].w;
                    MOV R1, c[14];
                    DP4 R3.z, R1, c[11];
                    DP4 R3.x, R1, c[9];
                    DP4 R3.y, R1, c[10];
                    DP3 result.texcoord[2].y, R0, R2;
                    DP3 result.texcoord[4].y, R2, R3;
                    DP3 result.texcoord[2].z, vertex.normal, R0;
                    DP3 result.texcoord[2].x, R0, vertex.attrib[14];
                    DP3 result.texcoord[4].z, vertex.normal, R3;
                    DP3 result.texcoord[4].x, vertex.attrib[14], R3;
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[33].xyxy, c[33];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[32], c[32].zwzw;
                    MAD result.texcoord[1].xy, vertex.texcoord[0], c[34], c[34].zwzw;
                    DP4 result.position.w, vertex.position, c[4];
                    DP4 result.position.z, vertex.position, c[3];
                    DP4 result.position.y, vertex.position, c[2];
                    DP4 result.position.x, vertex.position, c[1];
                    DP3 result.texcoord[3].x, vertex.normal, c[31];
                    END
# 77 instructions, 5 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" TexCoord2
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 4 [_Object2World]
                    Matrix 8 [_World2Object]
                    Vector 12 [_WorldSpaceCameraPos]
                    Vector 13 [_WorldSpaceLightPos0]
                    Vector 14 [unity_4LightPosX0]
                    Vector 15 [unity_4LightPosY0]
                    Vector 16 [unity_4LightPosZ0]
                    Vector 17 [unity_4LightAtten0]
                    Vector 18 [unity_LightColor0]
                    Vector 19 [unity_LightColor1]
                    Vector 20 [unity_LightColor2]
                    Vector 21 [unity_LightColor3]
                    Vector 22 [unity_SHAr]
                    Vector 23 [unity_SHAg]
                    Vector 24 [unity_SHAb]
                    Vector 25 [unity_SHBr]
                    Vector 26 [unity_SHBg]
                    Vector 27 [unity_SHBb]
                    Vector 28 [unity_SHC]
                    Vector 29 [unity_Scale]
                    Vector 30 [_localLightDirection]
                    Vector 31 [_MainTex_ST]
                    Vector 32 [_BumpMap_ST]
                    Vector 33 [_ResourceMap_ST]
                    "vs_3_0
                    dcl_position o0
                    dcl_texcoord0 o1
                    dcl_texcoord1 o2
                    dcl_texcoord2 o3
                    dcl_texcoord3 o4
                    dcl_texcoord4 o5
                    dcl_texcoord5 o6
                    def c34, 1.00000000, 0.00000000, 0, 0
                    dcl_position0 v0
                    dcl_tangent0 v1
                    dcl_normal0 v2
                    dcl_texcoord0 v3
                    mul r3.xyz, v2, c29.w
                    dp4 r0.x, v0, c5
                    add r1, -r0.x, c15
                    dp3 r3.w, r3, c5
                    dp3 r4.x, r3, c4
                    dp3 r3.x, r3, c6
                    mul r2, r3.w, r1
                    dp4 r0.x, v0, c4
                    add r0, -r0.x, c14
                    mul r1, r1, r1
                    mov r4.z, r3.x
                    mad r2, r4.x, r0, r2
                    mov r4.w, c34.x
                    dp4 r4.y, v0, c6
                    mad r1, r0, r0, r1
                    add r0, -r4.y, c16
                    mad r1, r0, r0, r1
                    mad r0, r3.x, r0, r2
                    mul r2, r1, c17
                    mov r4.y, r3.w
                    rsq r1.x, r1.x
                    rsq r1.y, r1.y
                    rsq r1.w, r1.w
                    rsq r1.z, r1.z
                    mul r0, r0, r1
                    add r1, r2, c34.x
                    dp4 r2.z, r4, c24
                    dp4 r2.y, r4, c23
                    dp4 r2.x, r4, c22
                    rcp r1.x, r1.x
                    rcp r1.y, r1.y
                    rcp r1.w, r1.w
                    rcp r1.z, r1.z
                    max r0, r0, c34.y
                    mul r0, r0, r1
                    mul r1.xyz, r0.y, c19
                    mad r1.xyz, r0.x, c18, r1
                    mad r0.xyz, r0.z, c20, r1
                    mad r1.xyz, r0.w, c21, r0
                    mul r0, r4.xyzz, r4.yzzx
                    mul r1.w, r3, r3
                    dp4 r3.z, r0, c27
                    dp4 r3.y, r0, c26
                    dp4 r3.x, r0, c25
                    mad r1.w, r4.x, r4.x, -r1
                    mul r0.xyz, r1.w, c28
                    add r2.xyz, r2, r3
                    add r2.xyz, r2, r0
                    add o6.xyz, r2, r1
                    mov r0.xyz, v1
                    mul r1.xyz, v2.zxyw, r0.yzxw
                    mov r0.xyz, v1
                    mad r0.xyz, v2.yzxw, r0.zxyw, -r1
                    mul r3.xyz, r0, v1.w
                    mov r0, c10
                    dp4 r4.z, c13, r0
                    mov r0, c9
                    mov r1.w, c34.x
                    mov r1.xyz, c12
                    dp4 r4.y, c13, r0
                    dp4 r2.z, r1, c10
                    dp4 r2.x, r1, c8
                    dp4 r2.y, r1, c9
                    mad r2.xyz, r2, c29.w, -v0
                    mov r1, c8
                    dp4 r4.x, c13, r1
                    dp3 o3.y, r2, r3
                    dp3 o5.y, r3, r4
                    dp3 o3.z, v2, r2
                    dp3 o3.x, r2, v1
                    dp3 o5.z, v2, r4
                    dp3 o5.x, v1, r4
                    mad o1.zw, v3.xyxy, c32.xyxy, c32
                    mad o1.xy, v3, c31, c31.zwzw
                    mad o2.xy, v3, c33, c33.zwzw
                    dp4 o0.w, v0, c3
                    dp4 o0.z, v0, c2
                    dp4 o0.y, v0, c1
                    dp4 o0.x, v0, c0
                    dp3 o4.x, v2, c30
                    "
                }
                SubProgram "opengl " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" ATTR14
                    Matrix 5 [_Object2World]
                    Matrix 9 [_World2Object]
                    Vector 13 [_WorldSpaceCameraPos]
                    Vector 14 [_ProjectionParams]
                    Vector 15 [_WorldSpaceLightPos0]
                    Vector 16 [unity_4LightPosX0]
                    Vector 17 [unity_4LightPosY0]
                    Vector 18 [unity_4LightPosZ0]
                    Vector 19 [unity_4LightAtten0]
                    Vector 20 [unity_LightColor0]
                    Vector 21 [unity_LightColor1]
                    Vector 22 [unity_LightColor2]
                    Vector 23 [unity_LightColor3]
                    Vector 24 [unity_SHAr]
                    Vector 25 [unity_SHAg]
                    Vector 26 [unity_SHAb]
                    Vector 27 [unity_SHBr]
                    Vector 28 [unity_SHBg]
                    Vector 29 [unity_SHBb]
                    Vector 30 [unity_SHC]
                    Vector 31 [unity_Scale]
                    Vector 32 [_localLightDirection]
                    Vector 33 [_MainTex_ST]
                    Vector 34 [_BumpMap_ST]
                    Vector 35 [_ResourceMap_ST]
                    "3.0-!!ARBvp1.0
                    PARAM c[36] = { { 1, 0, 0.5 },
                    state.matrix.mvp,
                    program.local[5..35] };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    TEMP R4;
                    MUL R3.xyz, vertex.normal, c[31].w;
                    DP4 R0.x, vertex.position, c[6];
                    ADD R1, -R0.x, c[17];
                    DP3 R3.w, R3, c[6];
                    DP3 R4.x, R3, c[5];
                    DP3 R3.x, R3, c[7];
                    MUL R2, R3.w, R1;
                    DP4 R0.x, vertex.position, c[5];
                    ADD R0, -R0.x, c[16];
                    MUL R1, R1, R1;
                    MOV R4.z, R3.x;
                    MAD R2, R4.x, R0, R2;
                    MOV R4.w, c[0].x;
                    DP4 R4.y, vertex.position, c[7];
                    MAD R1, R0, R0, R1;
                    ADD R0, -R4.y, c[18];
                    MAD R1, R0, R0, R1;
                    MAD R0, R3.x, R0, R2;
                    MUL R2, R1, c[19];
                    MOV R4.y, R3.w;
                    RSQ R1.x, R1.x;
                    RSQ R1.y, R1.y;
                    RSQ R1.w, R1.w;
                    RSQ R1.z, R1.z;
                    MUL R0, R0, R1;
                    ADD R1, R2, c[0].x;
                    RCP R1.x, R1.x;
                    RCP R1.y, R1.y;
                    RCP R1.w, R1.w;
                    RCP R1.z, R1.z;
                    MAX R0, R0, c[0].y;
                    MUL R0, R0, R1;
                    MUL R1.xyz, R0.y, c[21];
                    MAD R1.xyz, R0.x, c[20], R1;
                    MAD R0.xyz, R0.z, c[22], R1;
                    MAD R1.xyz, R0.w, c[23], R0;
                    MUL R0, R4.xyzz, R4.yzzx;
                    DP4 R3.z, R0, c[29];
                    DP4 R3.y, R0, c[28];
                    DP4 R3.x, R0, c[27];
                    MUL R1.w, R3, R3;
                    MOV R0.w, c[0].x;
                    MAD R0.x, R4, R4, -R1.w;
                    DP4 R2.z, R4, c[26];
                    DP4 R2.y, R4, c[25];
                    DP4 R2.x, R4, c[24];
                    ADD R2.xyz, R2, R3;
                    MUL R3.xyz, R0.x, c[30];
                    ADD R3.xyz, R2, R3;
                    MOV R0.xyz, vertex.attrib[14];
                    MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
                    ADD result.texcoord[5].xyz, R3, R1;
                    MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
                    MOV R0.xyz, c[13];
                    DP4 R2.z, R0, c[11];
                    DP4 R2.x, R0, c[9];
                    DP4 R2.y, R0, c[10];
                    MAD R0.xyz, R2, c[31].w, -vertex.position;
                    MUL R2.xyz, R1, vertex.attrib[14].w;
                    MOV R1, c[15];
                    DP4 R3.z, R1, c[11];
                    DP4 R3.x, R1, c[9];
                    DP4 R3.y, R1, c[10];
                    DP3 result.texcoord[2].y, R0, R2;
                    DP3 result.texcoord[2].z, vertex.normal, R0;
                    DP3 result.texcoord[2].x, R0, vertex.attrib[14];
                    DP4 R0.w, vertex.position, c[4];
                    DP4 R0.z, vertex.position, c[3];
                    DP4 R0.x, vertex.position, c[1];
                    DP4 R0.y, vertex.position, c[2];
                    MUL R1.xyz, R0.xyww, c[0].z;
                    MUL R1.y, R1, c[14].x;
                    DP3 result.texcoord[4].y, R2, R3;
                    DP3 result.texcoord[4].z, vertex.normal, R3;
                    DP3 result.texcoord[4].x, vertex.attrib[14], R3;
                    ADD result.texcoord[6].xy, R1, R1.z;
                    MOV result.position, R0;
                    MOV result.texcoord[6].zw, R0;
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[34].xyxy, c[34];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[33], c[33].zwzw;
                    MAD result.texcoord[1].xy, vertex.texcoord[0], c[35], c[35].zwzw;
                    DP3 result.texcoord[3].x, vertex.normal, c[32];
                    END
# 82 instructions, 5 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" TexCoord2
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 4 [_Object2World]
                    Matrix 8 [_World2Object]
                    Vector 12 [_WorldSpaceCameraPos]
                    Vector 13 [_ProjectionParams]
                    Vector 14 [_ScreenParams]
                    Vector 15 [_WorldSpaceLightPos0]
                    Vector 16 [unity_4LightPosX0]
                    Vector 17 [unity_4LightPosY0]
                    Vector 18 [unity_4LightPosZ0]
                    Vector 19 [unity_4LightAtten0]
                    Vector 20 [unity_LightColor0]
                    Vector 21 [unity_LightColor1]
                    Vector 22 [unity_LightColor2]
                    Vector 23 [unity_LightColor3]
                    Vector 24 [unity_SHAr]
                    Vector 25 [unity_SHAg]
                    Vector 26 [unity_SHAb]
                    Vector 27 [unity_SHBr]
                    Vector 28 [unity_SHBg]
                    Vector 29 [unity_SHBb]
                    Vector 30 [unity_SHC]
                    Vector 31 [unity_Scale]
                    Vector 32 [_localLightDirection]
                    Vector 33 [_MainTex_ST]
                    Vector 34 [_BumpMap_ST]
                    Vector 35 [_ResourceMap_ST]
                    "vs_3_0
                    dcl_position o0
                    dcl_texcoord0 o1
                    dcl_texcoord1 o2
                    dcl_texcoord2 o3
                    dcl_texcoord3 o4
                    dcl_texcoord4 o5
                    dcl_texcoord5 o6
                    dcl_texcoord6 o7
                    def c36, 1.00000000, 0.00000000, 0.50000000, 0
                    dcl_position0 v0
                    dcl_tangent0 v1
                    dcl_normal0 v2
                    dcl_texcoord0 v3
                    mul r3.xyz, v2, c31.w
                    dp4 r0.x, v0, c5
                    add r1, -r0.x, c17
                    dp3 r3.w, r3, c5
                    dp3 r4.x, r3, c4
                    dp3 r3.x, r3, c6
                    mul r2, r3.w, r1
                    dp4 r0.x, v0, c4
                    add r0, -r0.x, c16
                    mul r1, r1, r1
                    mov r4.z, r3.x
                    mad r2, r4.x, r0, r2
                    mov r4.w, c36.x
                    dp4 r4.y, v0, c6
                    mad r1, r0, r0, r1
                    add r0, -r4.y, c18
                    mad r1, r0, r0, r1
                    mad r0, r3.x, r0, r2
                    mul r2, r1, c19
                    mov r4.y, r3.w
                    rsq r1.x, r1.x
                    rsq r1.y, r1.y
                    rsq r1.w, r1.w
                    rsq r1.z, r1.z
                    mul r0, r0, r1
                    add r1, r2, c36.x
                    dp4 r2.z, r4, c26
                    dp4 r2.y, r4, c25
                    dp4 r2.x, r4, c24
                    rcp r1.x, r1.x
                    rcp r1.y, r1.y
                    rcp r1.w, r1.w
                    rcp r1.z, r1.z
                    max r0, r0, c36.y
                    mul r0, r0, r1
                    mul r1.xyz, r0.y, c21
                    mad r1.xyz, r0.x, c20, r1
                    mad r0.xyz, r0.z, c22, r1
                    mad r1.xyz, r0.w, c23, r0
                    mul r0, r4.xyzz, r4.yzzx
                    mul r1.w, r3, r3
                    dp4 r3.z, r0, c29
                    dp4 r3.y, r0, c28
                    dp4 r3.x, r0, c27
                    mad r1.w, r4.x, r4.x, -r1
                    mul r0.xyz, r1.w, c30
                    add r2.xyz, r2, r3
                    add r2.xyz, r2, r0
                    add o6.xyz, r2, r1
                    mov r0.xyz, v1
                    mul r1.xyz, v2.zxyw, r0.yzxw
                    mov r0.xyz, v1
                    mad r0.xyz, v2.yzxw, r0.zxyw, -r1
                    mul r3.xyz, r0, v1.w
                    mov r0, c10
                    dp4 r4.z, c15, r0
                    mov r0, c9
                    dp4 r4.y, c15, r0
                    mov r1.w, c36.x
                    mov r1.xyz, c12
                    dp4 r0.w, v0, c3
                    dp4 r0.z, v0, c2
                    dp4 r2.z, r1, c10
                    dp4 r2.x, r1, c8
                    dp4 r2.y, r1, c9
                    mad r2.xyz, r2, c31.w, -v0
                    mov r1, c8
                    dp4 r4.x, c15, r1
                    dp4 r0.x, v0, c0
                    dp4 r0.y, v0, c1
                    mul r1.xyz, r0.xyww, c36.z
                    mul r1.y, r1, c13.x
                    dp3 o3.y, r2, r3
                    dp3 o5.y, r3, r4
                    dp3 o3.z, v2, r2
                    dp3 o3.x, r2, v1
                    dp3 o5.z, v2, r4
                    dp3 o5.x, v1, r4
                    mad o7.xy, r1.z, c14.zwzw, r1
                    mov o0, r0
                    mov o7.zw, r0
                    mad o1.zw, v3.xyxy, c34.xyxy, c34
                    mad o1.xy, v3, c33, c33.zwzw
                    mad o2.xy, v3, c35, c35.zwzw
                    dp3 o4.x, v2, c32
                    "
                }
            }
            Program "fp" {
// Platform d3d11 had shader errors
//   Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
//   Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
//   Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
//   Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
//   Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
//   Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
                SubProgram "opengl " {
                    Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
                    Vector 0 [_LightColor0]
                    Vector 1 [_SpecColor]
                    Vector 2 [_Color]
                    Float 3 [_Shininess]
                    Float 4 [_Opacity]
                    Float 5 [_rimPower]
                    Float 6 [_rimBlend]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_rimColorRamp] 2D 2
                    SetTexture 3 [_ResourceMap] 2D 3
                    "3.0-!!ARBfp1.0
                    PARAM c[9] = { program.local[0..6],
                    { 2, 1, 0, 128 },
                    { 0.5 } };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
                    MAD R2.xy, R0.wyzw, c[7].x, -c[7].y;
                    MUL R0.xy, R2, R2;
                    ADD_SAT R0.x, R0, R0.y;
                    DP3 R0.z, fragment.texcoord[2], fragment.texcoord[2];
                    ADD R0.x, -R0, c[7].y;
                    RSQ R0.x, R0.x;
                    RCP R2.z, R0.x;
                    RSQ R0.z, R0.z;
                    MOV R1.xyz, fragment.texcoord[4];
                    MAD R1.xyz, R0.z, fragment.texcoord[2], R1;
                    DP3 R0.y, R1, R1;
                    RSQ R0.y, R0.y;
                    MUL R1.xyz, R0.y, R1;
                    DP3 R0.y, R2, R1;
                    TEX R1, fragment.texcoord[0], texture[0], 2D;
                    MOV R0.x, c[7].w;
                    MUL R0.z, R0.x, c[3].x;
                    MAX R0.x, R0.y, c[7].z;
                    POW R0.x, R0.x, R0.z;
                    MUL R2.w, R1, R0.x;
                    MOV R0, c[1];
                    DP3 R2.x, R2, fragment.texcoord[4];
                    MUL R0.w, R0, c[0];
                    MUL R1.xyz, R1, c[2];
                    MAX R3.x, R2, c[7].z;
                    MUL R2.xyz, R1, c[0];
                    MUL R2.xyz, R2, R3.x;
                    MUL R0.xyz, R0, c[0];
                    MAD R0.xyz, R0, R2.w, R2;
                    MUL R0.xyz, R0, c[7].x;
                    MAD R2.xyz, R1, fragment.texcoord[5], R0;
                    DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
                    RSQ R0.x, R0.x;
                    TEX R3, fragment.texcoord[1], texture[3], 2D;
                    ADD R0.y, -R1.w, c[7];
                    MUL R1, R3, R0.y;
                    MUL_SAT R0.x, R0, fragment.texcoord[2].z;
                    ADD R3.y, -R0.x, c[7];
                    ADD R3.x, -R1.w, c[7].y;
                    MOV R0.y, c[8].x;
                    MOV R0.x, fragment.texcoord[3];
                    TEX R0.xyz, R0, texture[2], 2D;
                    POW R3.y, R3.y, c[5].x;
                    MUL R0.xyz, R0, c[6].x;
                    MUL R0.xyz, R0, R3.y;
                    MUL R1.xyz, R1, R1.w;
                    MUL R0.xyz, R0, c[4].x;
                    MAD R0.xyz, R0, R3.x, R1;
                    ADD result.color.xyz, R2, R0;
                    MAD result.color.w, R2, R0, c[4].x;
                    END
# 51 instructions, 4 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
                    Vector 0 [_LightColor0]
                    Vector 1 [_SpecColor]
                    Vector 2 [_Color]
                    Float 3 [_Shininess]
                    Float 4 [_Opacity]
                    Float 5 [_rimPower]
                    Float 6 [_rimBlend]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_rimColorRamp] 2D 2
                    SetTexture 3 [_ResourceMap] 2D 3
                    "ps_3_0
                    dcl_2d s0
                    dcl_2d s1
                    dcl_2d s2
                    dcl_2d s3
                    def c7, 2.00000000, -1.00000000, 1.00000000, 0.00000000
                    def c8, 128.00000000, 0.50000000, 0, 0
                    dcl_texcoord0 v0
                    dcl_texcoord1 v1.xy
                    dcl_texcoord2 v2.xyz
                    dcl_texcoord3 v3.x
                    dcl_texcoord4 v4.xyz
                    dcl_texcoord5 v5.xyz
                    texld r0.yw, v0.zwzw, s1
                    mad_pp r0.xy, r0.wyzw, c7.x, c7.y
                    mul_pp r0.zw, r0.xyxy, r0.xyxy
                    add_pp_sat r0.z, r0, r0.w
                    dp3_pp r1.w, v2, v2
                    add_pp r0.z, -r0, c7
                    rsq_pp r0.z, r0.z
                    rcp_pp r0.z, r0.z
                    rsq_pp r1.w, r1.w
                    mov_pp r1.xyz, v4
                    mad_pp r1.xyz, r1.w, v2, r1
                    dp3_pp r0.w, r1, r1
                    rsq_pp r0.w, r0.w
                    mul_pp r1.xyz, r0.w, r1
                    dp3_pp r0.w, r0, r1
                    mov_pp r1.w, c3.x
                    mul_pp r2.x, c8, r1.w
                    max_pp r0.w, r0, c7
                    pow r1, r0.w, r2.x
                    mov r0.w, r1.x
                    texld r1, v0, s0
                    mul_pp r2.xyz, r1, c2
                    mul r2.w, r1, r0
                    dp3_pp r0.x, r0, v4
                    max_pp r0.w, r0.x, c7
                    mul_pp r1.xyz, r2, c0
                    mul_pp r1.xyz, r1, r0.w
                    mov_pp r0.xyz, c0
                    mul_pp r0.xyz, c1, r0
                    mad r3.xyz, r0, r2.w, r1
                    dp3 r0.w, v2, v2
                    rsq r1.x, r0.w
                    mul_sat r1.x, r1, v2.z
                    add r3.w, -r1.x, c7.z
                    texld r0, v1, s3
                    add r1.y, -r1.w, c7.z
                    mul r1, r0, r1.y
                    pow_pp r0, r3.w, c5.x
                    add r0.w, -r1, c7.z
                    mov_pp r3.w, r0.x
                    mul r1.xyz, r1, r1.w
                    mov r4.y, c8
                    mov r4.x, v3
                    texld r4.xyz, r4, s2
                    mul r0.xyz, r4, c6.x
                    mul r0.xyz, r0, r3.w
                    mul r0.xyz, r0, c4.x
                    mad r0.xyz, r0, r0.w, r1
                    mul r1.xyz, r3, c7.x
                    mov_pp r0.w, c0
                    mad_pp r1.xyz, r2, v5, r1
                    mul_pp r0.w, c1, r0
                    add_pp oC0.xyz, r1, r0
                    mad oC0.w, r2, r0, c4.x
                    "
                }
                SubProgram "opengl " {
                    Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
                    Vector 0 [_Color]
                    Float 1 [_Opacity]
                    Float 2 [_rimPower]
                    Float 3 [_rimBlend]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 2 [_rimColorRamp] 2D 2
                    SetTexture 3 [_ResourceMap] 2D 3
                    SetTexture 4 [unity_Lightmap] 2D 4
                    "3.0-!!ARBfp1.0
                    PARAM c[5] = { program.local[0..3],
                    { 8, 0.5, 1 } };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEX R0, fragment.texcoord[0], texture[0], 2D;
                    TEX R1, fragment.texcoord[1], texture[3], 2D;
                    DP3 R2.x, fragment.texcoord[2], fragment.texcoord[2];
                    ADD R2.y, -R0.w, c[4].z;
                    RSQ R0.w, R2.x;
                    MUL R2, R1, R2.y;
                    MUL_SAT R1.x, R0.w, fragment.texcoord[2].z;
                    ADD R1.w, -R1.x, c[4].z;
                    POW R1.w, R1.w, c[2].x;
                    ADD R0.w, -R2, c[4].z;
                    MOV R1.y, c[4];
                    MOV R1.x, fragment.texcoord[3];
                    TEX R1.xyz, R1, texture[2], 2D;
                    MUL R1.xyz, R1, c[3].x;
                    MUL R1.xyz, R1, R1.w;
                    MUL R1.xyz, R1, c[1].x;
                    MUL R2.xyz, R2, R2.w;
                    MAD R2.xyz, R1, R0.w, R2;
                    TEX R1, fragment.texcoord[4], texture[4], 2D;
                    MUL R0.xyz, R0, c[0];
                    MUL R1.xyz, R1.w, R1;
                    MUL R0.xyz, R1, R0;
                    MAD result.color.xyz, R0, c[4].x, R2;
                    MOV result.color.w, c[1].x;
                    END
# 24 instructions, 3 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
                    Vector 0 [_Color]
                    Float 1 [_Opacity]
                    Float 2 [_rimPower]
                    Float 3 [_rimBlend]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 2 [_rimColorRamp] 2D 2
                    SetTexture 3 [_ResourceMap] 2D 3
                    SetTexture 4 [unity_Lightmap] 2D 4
                    "ps_3_0
                    dcl_2d s0
                    dcl_2d s2
                    dcl_2d s3
                    dcl_2d s4
                    def c4, 1.00000000, 0.50000000, 8.00000000, 0
                    dcl_texcoord0 v0.xy
                    dcl_texcoord1 v1.xy
                    dcl_texcoord2 v2.xyz
                    dcl_texcoord3 v3.x
                    dcl_texcoord4 v4.xy
                    dp3 r1.x, v2, v2
                    rsq r2.x, r1.x
                    texld r1, v0, s0
                    texld r0, v1, s3
                    mul_sat r2.x, r2, v2.z
                    add r2.y, -r1.w, c4.x
                    add r1.w, -r2.x, c4.x
                    mul r2, r0, r2.y
                    pow_pp r0, r1.w, c2.x
                    add r0.w, -r2, c4.x
                    mov_pp r1.w, r0.x
                    mov r3.y, c4
                    mov r3.x, v3
                    texld r3.xyz, r3, s2
                    mul r0.xyz, r3, c3.x
                    mul r0.xyz, r0, r1.w
                    mul r0.xyz, r0, c1.x
                    mul r2.xyz, r2, r2.w
                    mad r2.xyz, r0, r0.w, r2
                    texld r0, v4, s4
                    mul_pp r1.xyz, r1, c0
                    mul_pp r0.xyz, r0.w, r0
                    mul_pp r0.xyz, r0, r1
                    mad_pp oC0.xyz, r0, c4.z, r2
                    mov_pp oC0.w, c1.x
                    "
                }
                SubProgram "opengl " {
                    Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
                    Vector 0 [_SpecColor]
                    Vector 1 [_Color]
                    Float 2 [_Shininess]
                    Float 3 [_Opacity]
                    Float 4 [_rimPower]
                    Float 5 [_rimBlend]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_rimColorRamp] 2D 2
                    SetTexture 3 [_ResourceMap] 2D 3
                    SetTexture 4 [unity_Lightmap] 2D 4
                    SetTexture 5 [unity_LightmapInd] 2D 5
                    "3.0-!!ARBfp1.0
                    PARAM c[10] = { program.local[0..5],
                    { 2, 1, 8, 0 },
                    { -0.40824828, -0.70710677, 0.57735026, 128 },
                    { -0.40824831, 0.70710677, 0.57735026, 0.5 },
                    { 0.81649655, 0, 0.57735026 } };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    TEMP R4;
                    TEMP R5;
                    TEX R1.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
                    MAD R5.xy, R1.wyzw, c[6].x, -c[6].y;
                    TEX R0, fragment.texcoord[4], texture[5], 2D;
                    MUL R0.xyz, R0.w, R0;
                    MUL R3.xyz, R0, c[6].z;
                    MUL R0.xyz, R3.y, c[8];
                    MAD R0.xyz, R3.x, c[9], R0;
                    MAD R0.xyz, R3.z, c[7], R0;
                    DP3 R0.w, R0, R0;
                    RSQ R0.w, R0.w;
                    MUL R0.xyz, R0.w, R0;
                    DP3 R0.w, fragment.texcoord[2], fragment.texcoord[2];
                    RSQ R0.w, R0.w;
                    DP3 R2.x, fragment.texcoord[2], fragment.texcoord[2];
                    RSQ R2.x, R2.x;
                    MUL_SAT R2.x, R2, fragment.texcoord[2].z;
                    ADD R4.x, -R2, c[6].y;
                    MUL R1.xy, R5, R5;
                    MAD R0.xyz, R0.w, fragment.texcoord[2], R0;
                    ADD_SAT R0.w, R1.x, R1.y;
                    DP3 R1.x, R0, R0;
                    RSQ R1.x, R1.x;
                    MUL R0.xyz, R1.x, R0;
                    ADD R0.w, -R0, c[6].y;
                    RSQ R0.w, R0.w;
                    RCP R5.z, R0.w;
                    DP3 R2.w, R5, R0;
                    TEX R0, fragment.texcoord[0], texture[0], 2D;
                    ADD R2.y, -R0.w, c[6];
                    TEX R1, fragment.texcoord[1], texture[3], 2D;
                    MUL R1, R1, R2.y;
                    ADD R3.w, -R1, c[6].y;
                    POW R4.x, R4.x, c[4].x;
                    MUL R1.xyz, R1, R1.w;
                    MOV R2.y, c[8].w;
                    MOV R2.x, fragment.texcoord[3];
                    TEX R2.xyz, R2, texture[2], 2D;
                    MUL R2.xyz, R2, c[5].x;
                    MUL R2.xyz, R2, R4.x;
                    MUL R2.xyz, R2, c[3].x;
                    MAD R4.xyz, R2, R3.w, R1;
                    TEX R1, fragment.texcoord[4], texture[4], 2D;
                    MUL R1.xyz, R1.w, R1;
                    MOV R1.w, c[7];
                    DP3_SAT R2.z, R5, c[7];
                    DP3_SAT R2.y, R5, c[8];
                    DP3_SAT R2.x, R5, c[9];
                    DP3 R2.x, R2, R3;
                    MUL R1.xyz, R1, R2.x;
                    MUL R1.xyz, R1, c[6].z;
                    MUL R2.xyz, R1, c[0];
                    MAX R2.w, R2, c[6];
                    MUL R1.w, R1, c[2].x;
                    POW R1.w, R2.w, R1.w;
                    MUL R2.xyz, R0.w, R2;
                    MUL R2.xyz, R2, R1.w;
                    MUL R0.xyz, R0, c[1];
                    MAD R0.xyz, R0, R1, R2;
                    ADD result.color.xyz, R0, R4;
                    MOV result.color.w, c[3].x;
                    END
# 60 instructions, 6 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
                    Vector 0 [_SpecColor]
                    Vector 1 [_Color]
                    Float 2 [_Shininess]
                    Float 3 [_Opacity]
                    Float 4 [_rimPower]
                    Float 5 [_rimBlend]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_rimColorRamp] 2D 2
                    SetTexture 3 [_ResourceMap] 2D 3
                    SetTexture 4 [unity_Lightmap] 2D 4
                    SetTexture 5 [unity_LightmapInd] 2D 5
                    "ps_3_0
                    dcl_2d s0
                    dcl_2d s1
                    dcl_2d s2
                    dcl_2d s3
                    dcl_2d s4
                    dcl_2d s5
                    def c6, 2.00000000, -1.00000000, 1.00000000, 8.00000000
                    def c7, -0.40824828, -0.70710677, 0.57735026, 0.00000000
                    def c8, -0.40824831, 0.70710677, 0.57735026, 128.00000000
                    def c9, 0.81649655, 0.00000000, 0.57735026, 0.50000000
                    dcl_texcoord0 v0
                    dcl_texcoord1 v1.xy
                    dcl_texcoord2 v2.xyz
                    dcl_texcoord3 v3.x
                    dcl_texcoord4 v4.xy
                    texld r1.yw, v0.zwzw, s1
                    mad_pp r3.xy, r1.wyzw, c6.x, c6.y
                    texld r0, v4, s5
                    mul_pp r0.xyz, r0.w, r0
                    mul_pp r4.xyz, r0, c6.w
                    mul r0.xyz, r4.y, c8
                    mad r0.xyz, r4.x, c9, r0
                    mad r0.xyz, r4.z, c7, r0
                    dp3 r0.w, r0, r0
                    rsq r0.w, r0.w
                    mul r0.xyz, r0.w, r0
                    dp3_pp r0.w, v2, v2
                    rsq_pp r0.w, r0.w
                    mul_pp r1.xy, r3, r3
                    mad_pp r0.xyz, r0.w, v2, r0
                    add_pp_sat r0.w, r1.x, r1.y
                    dp3_pp r1.x, r0, r0
                    rsq_pp r1.x, r1.x
                    mul_pp r0.xyz, r1.x, r0
                    dp3 r1.x, v2, v2
                    rsq r2.x, r1.x
                    texld r1, v0, s0
                    mul_sat r2.x, r2, v2.z
                    add_pp r0.w, -r0, c6.z
                    rsq_pp r0.w, r0.w
                    rcp_pp r3.z, r0.w
                    dp3_pp r3.w, r3, r0
                    add r4.w, -r2.x, c6.z
                    texld r0, v1, s3
                    add r2.y, -r1.w, c6.z
                    mul r2, r0, r2.y
                    pow_pp r0, r4.w, c4.x
                    add r0.w, -r2, c6.z
                    mul r2.xyz, r2, r2.w
                    mov_pp r4.w, r0.x
                    mov r5.y, c9.w
                    mov r5.x, v3
                    texld r5.xyz, r5, s2
                    mul r0.xyz, r5, c5.x
                    mul r0.xyz, r0, r4.w
                    mul r0.xyz, r0, c3.x
                    mad r0.xyz, r0, r0.w, r2
                    dp3_pp_sat r2.z, r3, c7
                    dp3_pp_sat r2.x, r3, c9
                    dp3_pp_sat r2.y, r3, c8
                    dp3_pp r3.x, r2, r4
                    texld r2, v4, s4
                    max_pp r0.w, r3, c7
                    mov_pp r3.y, c2.x
                    mul_pp r2.xyz, r2.w, r2
                    mul_pp r3.w, c8, r3.y
                    mul_pp r3.xyz, r2, r3.x
                    pow r2, r0.w, r3.w
                    mul_pp r3.xyz, r3, c6.w
                    mov r0.w, r2.x
                    mul_pp r4.xyz, r3, c0
                    mul_pp r2.xyz, r1.w, r4
                    mul r2.xyz, r2, r0.w
                    mul_pp r1.xyz, r1, c1
                    mad_pp r1.xyz, r1, r3, r2
                    add_pp oC0.xyz, r1, r0
                    mov_pp oC0.w, c3.x
                    "
                }
                SubProgram "opengl " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
                    Vector 0 [_LightColor0]
                    Vector 1 [_SpecColor]
                    Vector 2 [_Color]
                    Float 3 [_Shininess]
                    Float 4 [_Opacity]
                    Float 5 [_rimPower]
                    Float 6 [_rimBlend]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_rimColorRamp] 2D 2
                    SetTexture 3 [_ResourceMap] 2D 3
                    SetTexture 4 [_ShadowMapTexture] 2D 4
                    "3.0-!!ARBfp1.0
                    PARAM c[9] = { program.local[0..6],
                    { 2, 1, 0, 128 },
                    { 0.5 } };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
                    MAD R1.xy, R0.wyzw, c[7].x, -c[7].y;
                    MUL R0.xy, R1, R1;
                    ADD_SAT R0.y, R0.x, R0;
                    ADD R0.y, -R0, c[7];
                    RSQ R0.w, R0.y;
                    RCP R1.z, R0.w;
                    DP3 R0.z, fragment.texcoord[2], fragment.texcoord[2];
                    RSQ R0.z, R0.z;
                    MOV R2.xyz, fragment.texcoord[4];
                    MAD R2.xyz, R0.z, fragment.texcoord[2], R2;
                    DP3 R0.x, R2, R2;
                    RSQ R0.x, R0.x;
                    MUL R0.xyz, R0.x, R2;
                    DP3 R0.y, R1, R0;
                    TEX R2, fragment.texcoord[0], texture[0], 2D;
                    MOV R0.w, c[7];
                    MUL R0.x, R0.w, c[3];
                    MAX R0.y, R0, c[7].z;
                    POW R0.x, R0.y, R0.x;
                    MUL R0.y, R2.w, R0.x;
                    DP3 R0.x, R1, fragment.texcoord[4];
                    MUL R2.xyz, R2, c[2];
                    DP3 R0.w, fragment.texcoord[2], fragment.texcoord[2];
                    RSQ R0.w, R0.w;
                    MUL_SAT R0.w, R0, fragment.texcoord[2].z;
                    ADD R0.w, -R0, c[7].y;
                    MUL R1.xyz, R2, c[0];
                    MAX R0.x, R0, c[7].z;
                    MUL R3.xyz, R1, R0.x;
                    MOV R1, c[1];
                    TXP R0.x, fragment.texcoord[6], texture[4], 2D;
                    MUL R1.xyz, R1, c[0];
                    MAD R1.xyz, R1, R0.y, R3;
                    MUL R0.z, R0.x, c[7].x;
                    MUL R1.xyz, R1, R0.z;
                    TEX R3, fragment.texcoord[1], texture[3], 2D;
                    ADD R0.z, -R2.w, c[7].y;
                    MAD R1.xyz, R2, fragment.texcoord[5], R1;
                    MUL R2, R3, R0.z;
                    POW R0.w, R0.w, c[5].x;
                    ADD R0.z, -R2.w, c[7].y;
                    MUL R2.xyz, R2, R2.w;
                    MOV R3.y, c[8].x;
                    MOV R3.x, fragment.texcoord[3];
                    TEX R3.xyz, R3, texture[2], 2D;
                    MUL R3.xyz, R3, c[6].x;
                    MUL R3.xyz, R3, R0.w;
                    MUL R0.w, R1, c[0];
                    MUL R3.xyz, R3, c[4].x;
                    MAD R2.xyz, R3, R0.z, R2;
                    MUL R0.y, R0, R0.w;
                    ADD result.color.xyz, R1, R2;
                    MAD result.color.w, R0.x, R0.y, c[4].x;
                    END
# 54 instructions, 4 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
                    Vector 0 [_LightColor0]
                    Vector 1 [_SpecColor]
                    Vector 2 [_Color]
                    Float 3 [_Shininess]
                    Float 4 [_Opacity]
                    Float 5 [_rimPower]
                    Float 6 [_rimBlend]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_rimColorRamp] 2D 2
                    SetTexture 3 [_ResourceMap] 2D 3
                    SetTexture 4 [_ShadowMapTexture] 2D 4
                    "ps_3_0
                    dcl_2d s0
                    dcl_2d s1
                    dcl_2d s2
                    dcl_2d s3
                    dcl_2d s4
                    def c7, 2.00000000, -1.00000000, 1.00000000, 0.00000000
                    def c8, 128.00000000, 0.50000000, 0, 0
                    dcl_texcoord0 v0
                    dcl_texcoord1 v1.xy
                    dcl_texcoord2 v2.xyz
                    dcl_texcoord3 v3.x
                    dcl_texcoord4 v4.xyz
                    dcl_texcoord5 v5.xyz
                    dcl_texcoord6 v6
                    texld r0.yw, v0.zwzw, s1
                    mad_pp r3.xy, r0.wyzw, c7.x, c7.y
                    mul_pp r2.xy, r3, r3
                    add_pp_sat r0.w, r2.x, r2.y
                    dp3_pp r0.x, v2, v2
                    add_pp r0.w, -r0, c7.z
                    rsq_pp r0.w, r0.w
                    rcp_pp r3.z, r0.w
                    mov_pp r1.xyz, v4
                    rsq_pp r0.x, r0.x
                    mad_pp r0.xyz, r0.x, v2, r1
                    dp3_pp r1.x, r0, r0
                    rsq_pp r1.x, r1.x
                    mul_pp r0.xyz, r1.x, r0
                    dp3_pp r0.x, r3, r0
                    mov_pp r0.w, c3.x
                    mul_pp r1.y, c8.x, r0.w
                    max_pp r1.x, r0, c7.w
                    pow r0, r1.x, r1.y
                    mov r3.w, r0.x
                    dp3 r1.x, v2, v2
                    rsq r2.x, r1.x
                    texld r1, v0, s0
                    mul_sat r2.x, r2, v2.z
                    add r4.x, -r2, c7.z
                    texld r0, v1, s3
                    add r2.y, -r1.w, c7.z
                    mul r2, r0, r2.y
                    pow_pp r0, r4.x, c5.x
                    add r0.w, -r2, c7.z
                    mul r2.xyz, r2, r2.w
                    mov_pp r4.w, r0.x
                    mul_pp r1.xyz, r1, c2
                    mov r4.y, c8
                    mov r4.x, v3
                    texld r4.xyz, r4, s2
                    mul r0.xyz, r4, c6.x
                    texldp r4.x, v6, s4
                    mul r0.xyz, r0, r4.w
                    mul r0.xyz, r0, c4.x
                    mad r0.xyz, r0, r0.w, r2
                    mul r0.w, r1, r3
                    dp3_pp r1.w, r3, v4
                    mov_pp r2.xyz, c0
                    mul_pp r3.xyz, r1, c0
                    max_pp r1.w, r1, c7
                    mul_pp r3.xyz, r3, r1.w
                    mul_pp r2.xyz, c1, r2
                    mov_pp r1.w, c0
                    mad r2.xyz, r2, r0.w, r3
                    mul_pp r2.w, r4.x, c7.x
                    mul r2.xyz, r2, r2.w
                    mul_pp r1.w, c1, r1
                    mad_pp r1.xyz, r1, v5, r2
                    mul r0.w, r0, r1
                    add_pp oC0.xyz, r1, r0
                    mad oC0.w, r4.x, r0, c4.x
                    "
                }
                SubProgram "opengl " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
                    Vector 0 [_Color]
                    Float 1 [_Opacity]
                    Float 2 [_rimPower]
                    Float 3 [_rimBlend]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 2 [_rimColorRamp] 2D 2
                    SetTexture 3 [_ResourceMap] 2D 3
                    SetTexture 4 [_ShadowMapTexture] 2D 4
                    SetTexture 5 [unity_Lightmap] 2D 5
                    "3.0-!!ARBfp1.0
                    PARAM c[5] = { program.local[0..3],
                    { 8, 2, 0.5, 1 } };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    TEMP R4;
                    TEX R0, fragment.texcoord[0], texture[0], 2D;
                    TEX R1, fragment.texcoord[1], texture[3], 2D;
                    DP3 R2.x, fragment.texcoord[2], fragment.texcoord[2];
                    ADD R2.y, -R0.w, c[4].w;
                    RSQ R0.w, R2.x;
                    MUL R2, R1, R2.y;
                    MUL_SAT R1.x, R0.w, fragment.texcoord[2].z;
                    ADD R1.w, -R1.x, c[4];
                    POW R1.w, R1.w, c[2].x;
                    TXP R4.x, fragment.texcoord[5], texture[4], 2D;
                    ADD R0.w, -R2, c[4];
                    MOV R1.y, c[4].z;
                    MOV R1.x, fragment.texcoord[3];
                    TEX R1.xyz, R1, texture[2], 2D;
                    MUL R1.xyz, R1, c[3].x;
                    MUL R1.xyz, R1, R1.w;
                    MUL R1.xyz, R1, c[1].x;
                    MUL R2.xyz, R2, R2.w;
                    MAD R2.xyz, R1, R0.w, R2;
                    TEX R1, fragment.texcoord[4], texture[5], 2D;
                    MUL R3.xyz, R1.w, R1;
                    MUL R1.xyz, R1, R4.x;
                    MUL R3.xyz, R3, c[4].x;
                    MUL R1.xyz, R1, c[4].y;
                    MUL R4.xyz, R3, R4.x;
                    MIN R1.xyz, R3, R1;
                    MAX R1.xyz, R1, R4;
                    MUL R0.xyz, R0, c[0];
                    MAD result.color.xyz, R0, R1, R2;
                    MOV result.color.w, c[1].x;
                    END
# 30 instructions, 5 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
                    Vector 0 [_Color]
                    Float 1 [_Opacity]
                    Float 2 [_rimPower]
                    Float 3 [_rimBlend]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 2 [_rimColorRamp] 2D 2
                    SetTexture 3 [_ResourceMap] 2D 3
                    SetTexture 4 [_ShadowMapTexture] 2D 4
                    SetTexture 5 [unity_Lightmap] 2D 5
                    "ps_3_0
                    dcl_2d s0
                    dcl_2d s2
                    dcl_2d s3
                    dcl_2d s4
                    dcl_2d s5
                    def c4, 1.00000000, 0.50000000, 8.00000000, 2.00000000
                    dcl_texcoord0 v0.xy
                    dcl_texcoord1 v1.xy
                    dcl_texcoord2 v2.xyz
                    dcl_texcoord3 v3.x
                    dcl_texcoord4 v4.xy
                    dcl_texcoord5 v5
                    dp3 r0.x, v2, v2
                    rsq r2.x, r0.x
                    texld r0, v0, s0
                    texld r1, v1, s3
                    mul_sat r2.x, r2, v2.z
                    add r2.y, -r0.w, c4.x
                    add r0.w, -r2.x, c4.x
                    mul r2, r1, r2.y
                    pow_pp r1, r0.w, c2.x
                    mov_pp r1.w, r1.x
                    texldp r4.x, v5, s4
                    add r0.w, -r2, c4.x
                    mov r3.y, c4
                    mov r3.x, v3
                    texld r3.xyz, r3, s2
                    mul r1.xyz, r3, c3.x
                    mul r1.xyz, r1, r1.w
                    mul r1.xyz, r1, c1.x
                    mul r2.xyz, r2, r2.w
                    mad r2.xyz, r1, r0.w, r2
                    texld r1, v4, s5
                    mul_pp r3.xyz, r1.w, r1
                    mul_pp r1.xyz, r1, r4.x
                    mul_pp r3.xyz, r3, c4.z
                    mul_pp r1.xyz, r1, c4.w
                    mul_pp r4.xyz, r3, r4.x
                    min_pp r1.xyz, r3, r1
                    max_pp r1.xyz, r1, r4
                    mul_pp r0.xyz, r0, c0
                    mad_pp oC0.xyz, r0, r1, r2
                    mov_pp oC0.w, c1.x
                    "
                }
                SubProgram "opengl " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
                    Vector 0 [_SpecColor]
                    Vector 1 [_Color]
                    Float 2 [_Shininess]
                    Float 3 [_Opacity]
                    Float 4 [_rimPower]
                    Float 5 [_rimBlend]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_rimColorRamp] 2D 2
                    SetTexture 3 [_ResourceMap] 2D 3
                    SetTexture 4 [_ShadowMapTexture] 2D 4
                    SetTexture 5 [unity_Lightmap] 2D 5
                    SetTexture 6 [unity_LightmapInd] 2D 6
                    "3.0-!!ARBfp1.0
                    PARAM c[10] = { program.local[0..5],
                    { 2, 1, 8, 0 },
                    { -0.40824828, -0.70710677, 0.57735026, 128 },
                    { -0.40824831, 0.70710677, 0.57735026, 0.5 },
                    { 0.81649655, 0, 0.57735026 } };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    TEMP R4;
                    TEMP R5;
                    TEMP R6;
                    TEX R0, fragment.texcoord[4], texture[6], 2D;
                    MUL R0.xyz, R0.w, R0;
                    MUL R4.xyz, R0, c[6].z;
                    MUL R0.xyz, R4.y, c[8];
                    MAD R0.xyz, R4.x, c[9], R0;
                    MAD R1.xyz, R4.z, c[7], R0;
                    DP3 R0.x, R1, R1;
                    TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
                    MAD R2.xy, R0.wyzw, c[6].x, -c[6].y;
                    RSQ R0.x, R0.x;
                    MUL R0.xyz, R0.x, R1;
                    MUL R1.xy, R2, R2;
                    ADD_SAT R0.w, R1.x, R1.y;
                    DP3 R1.z, fragment.texcoord[2], fragment.texcoord[2];
                    RSQ R1.x, R1.z;
                    MAD R0.xyz, R1.x, fragment.texcoord[2], R0;
                    ADD R0.w, -R0, c[6].y;
                    RSQ R1.x, R0.w;
                    RCP R2.z, R1.x;
                    DP3 R1.y, R0, R0;
                    RSQ R0.w, R1.y;
                    MUL R5.xyz, R0.w, R0;
                    TEX R0, fragment.texcoord[0], texture[0], 2D;
                    DP3_SAT R3.z, R2, c[7];
                    DP3_SAT R3.x, R2, c[9];
                    DP3_SAT R3.y, R2, c[8];
                    DP3 R2.w, R3, R4;
                    TEX R1, fragment.texcoord[4], texture[5], 2D;
                    MUL R3.xyz, R1.w, R1;
                    MUL R3.xyz, R3, R2.w;
                    TXP R4.x, fragment.texcoord[5], texture[4], 2D;
                    MUL R1.xyz, R1, R4.x;
                    MUL R3.xyz, R3, c[6].z;
                    MUL R1.xyz, R1, c[6].x;
                    DP3 R2.w, fragment.texcoord[2], fragment.texcoord[2];
                    MIN R1.xyz, R3, R1;
                    MUL R4.xyz, R3, R4.x;
                    MAX R4.xyz, R1, R4;
                    ADD R3.w, -R0, c[6].y;
                    TEX R1, fragment.texcoord[1], texture[3], 2D;
                    MUL R1, R1, R3.w;
                    RSQ R2.w, R2.w;
                    MUL_SAT R3.w, R2, fragment.texcoord[2].z;
                    ADD R3.w, -R3, c[6].y;
                    ADD R2.w, -R1, c[6].y;
                    MUL R1.xyz, R1, R1.w;
                    MOV R1.w, c[7];
                    DP3 R2.x, R2, R5;
                    MOV R6.y, c[8].w;
                    MOV R6.x, fragment.texcoord[3];
                    TEX R6.xyz, R6, texture[2], 2D;
                    POW R3.w, R3.w, c[4].x;
                    MUL R6.xyz, R6, c[5].x;
                    MUL R6.xyz, R6, R3.w;
                    MUL R6.xyz, R6, c[3].x;
                    MAD R1.xyz, R6, R2.w, R1;
                    MAX R2.w, R2.x, c[6];
                    MUL R1.w, R1, c[2].x;
                    MUL R2.xyz, R3, c[0];
                    POW R1.w, R2.w, R1.w;
                    MUL R2.xyz, R0.w, R2;
                    MUL R2.xyz, R2, R1.w;
                    MUL R0.xyz, R0, c[1];
                    MAD R0.xyz, R0, R4, R2;
                    ADD result.color.xyz, R0, R1;
                    MOV result.color.w, c[3].x;
                    END
# 66 instructions, 7 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
                    Vector 0 [_SpecColor]
                    Vector 1 [_Color]
                    Float 2 [_Shininess]
                    Float 3 [_Opacity]
                    Float 4 [_rimPower]
                    Float 5 [_rimBlend]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_rimColorRamp] 2D 2
                    SetTexture 3 [_ResourceMap] 2D 3
                    SetTexture 4 [_ShadowMapTexture] 2D 4
                    SetTexture 5 [unity_Lightmap] 2D 5
                    SetTexture 6 [unity_LightmapInd] 2D 6
                    "ps_3_0
                    dcl_2d s0
                    dcl_2d s1
                    dcl_2d s2
                    dcl_2d s3
                    dcl_2d s4
                    dcl_2d s5
                    dcl_2d s6
                    def c6, 2.00000000, -1.00000000, 1.00000000, 8.00000000
                    def c7, -0.40824828, -0.70710677, 0.57735026, 0.00000000
                    def c8, -0.40824831, 0.70710677, 0.57735026, 128.00000000
                    def c9, 0.81649655, 0.00000000, 0.57735026, 0.50000000
                    dcl_texcoord0 v0
                    dcl_texcoord1 v1.xy
                    dcl_texcoord2 v2.xyz
                    dcl_texcoord3 v3.x
                    dcl_texcoord4 v4.xy
                    dcl_texcoord5 v5
                    texld r0, v4, s6
                    mul_pp r0.xyz, r0.w, r0
                    mul_pp r4.xyz, r0, c6.w
                    mul r0.xyz, r4.y, c8
                    mad r0.xyz, r4.x, c9, r0
                    mad r1.xyz, r4.z, c7, r0
                    dp3 r0.x, r1, r1
                    rsq r0.z, r0.x
                    texld r0.yw, v0.zwzw, s1
                    mad_pp r0.xy, r0.wyzw, c6.x, c6.y
                    mul r1.xyz, r0.z, r1
                    mul_pp r0.zw, r0.xyxy, r0.xyxy
                    add_pp_sat r0.z, r0, r0.w
                    dp3_pp r1.w, v2, v2
                    rsq_pp r0.w, r1.w
                    mad_pp r1.xyz, r0.w, v2, r1
                    dp3_pp r0.w, r1, r1
                    rsq_pp r0.w, r0.w
                    mul_pp r1.xyz, r0.w, r1
                    add_pp r0.z, -r0, c6
                    rsq_pp r0.z, r0.z
                    rcp_pp r0.z, r0.z
                    dp3_pp_sat r3.z, r0, c7
                    dp3_pp_sat r3.x, r0, c9
                    dp3_pp_sat r3.y, r0, c8
                    dp3_pp r0.x, r0, r1
                    dp3_pp r1.w, r3, r4
                    texld r2, v4, s5
                    mul_pp r3.xyz, r2.w, r2
                    mul_pp r3.xyz, r3, r1.w
                    texldp r4.x, v5, s4
                    mul_pp r2.xyz, r2, r4.x
                    mul_pp r3.xyz, r3, c6.w
                    mov_pp r0.w, c2.x
                    mul_pp r2.xyz, r2, c6.x
                    min_pp r2.xyz, r3, r2
                    mul_pp r4.xyz, r3, r4.x
                    max_pp r4.xyz, r2, r4
                    dp3 r1.x, v2, v2
                    rsq r2.x, r1.x
                    texld r1, v0, s0
                    mul_sat r2.x, r2, v2.z
                    add r3.w, -r2.x, c6.z
                    mul_pp r0.y, c8.w, r0.w
                    max_pp r0.x, r0, c7.w
                    pow r6, r0.x, r0.y
                    texld r0, v1, s3
                    add r2.y, -r1.w, c6.z
                    mul r2, r0, r2.y
                    pow_pp r0, r3.w, c4.x
                    add r0.w, -r2, c6.z
                    mov_pp r3.w, r0.x
                    mul r2.xyz, r2, r2.w
                    mov r5.y, c9.w
                    mov r5.x, v3
                    texld r5.xyz, r5, s2
                    mul r0.xyz, r5, c5.x
                    mul r0.xyz, r0, r3.w
                    mul r0.xyz, r0, c3.x
                    mad r0.xyz, r0, r0.w, r2
                    mul_pp r2.xyz, r3, c0
                    mov r0.w, r6.x
                    mul_pp r2.xyz, r1.w, r2
                    mul r2.xyz, r2, r0.w
                    mul_pp r1.xyz, r1, c1
                    mad_pp r1.xyz, r1, r4, r2
                    add_pp oC0.xyz, r1, r0
                    mov_pp oC0.w, c3.x
                    "
                }
            }
        }
        Pass {
            Name "FORWARD"
            Tags { "LIGHTMODE"="ForwardAdd" }
            ZWrite Off
            Fog {
                Color (0,0,0,0)
            }
            Blend One One
            Program "vp" {
// Platform d3d11 had shader errors
//   Keywords { "POINT" }
//   Keywords { "DIRECTIONAL" }
//   Keywords { "SPOT" }
//   Keywords { "POINT_COOKIE" }
//   Keywords { "DIRECTIONAL_COOKIE" }
                SubProgram "opengl " {
                    Keywords { "POINT" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" ATTR14
                    Matrix 5 [_Object2World]
                    Matrix 9 [_World2Object]
                    Matrix 13 [_LightMatrix0]
                    Vector 17 [_WorldSpaceCameraPos]
                    Vector 18 [_WorldSpaceLightPos0]
                    Vector 19 [unity_Scale]
                    Vector 20 [_localLightDirection]
                    Vector 21 [_MainTex_ST]
                    Vector 22 [_BumpMap_ST]
                    "3.0-!!ARBvp1.0
                    PARAM c[23] = { { 1 },
                    state.matrix.mvp,
                    program.local[5..22] };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    MOV R1.xyz, c[17];
                    MOV R1.w, c[0].x;
                    MOV R0.xyz, vertex.attrib[14];
                    DP4 R2.z, R1, c[11];
                    DP4 R2.y, R1, c[10];
                    DP4 R2.x, R1, c[9];
                    MAD R2.xyz, R2, c[19].w, -vertex.position;
                    MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
                    MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
                    MOV R0, c[18];
                    MUL R1.xyz, R1, vertex.attrib[14].w;
                    DP4 R3.z, R0, c[11];
                    DP4 R3.x, R0, c[9];
                    DP4 R3.y, R0, c[10];
                    MAD R0.xyz, R3, c[19].w, -vertex.position;
                    DP3 result.texcoord[2].y, R0, R1;
                    DP3 result.texcoord[2].z, vertex.normal, R0;
                    DP3 result.texcoord[2].x, R0, vertex.attrib[14];
                    DP4 R0.w, vertex.position, c[8];
                    DP4 R0.z, vertex.position, c[7];
                    DP4 R0.x, vertex.position, c[5];
                    DP4 R0.y, vertex.position, c[6];
                    DP3 result.texcoord[3].y, R1, R2;
                    DP3 result.texcoord[3].z, vertex.normal, R2;
                    DP3 result.texcoord[3].x, vertex.attrib[14], R2;
                    DP4 result.texcoord[4].z, R0, c[15];
                    DP4 result.texcoord[4].y, R0, c[14];
                    DP4 result.texcoord[4].x, R0, c[13];
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[22].xyxy, c[22];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[21], c[21].zwzw;
                    DP4 result.position.w, vertex.position, c[4];
                    DP4 result.position.z, vertex.position, c[3];
                    DP4 result.position.y, vertex.position, c[2];
                    DP4 result.position.x, vertex.position, c[1];
                    DP3 result.texcoord[1].x, vertex.normal, c[20];
                    END
# 35 instructions, 4 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "POINT" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" TexCoord2
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 4 [_Object2World]
                    Matrix 8 [_World2Object]
                    Matrix 12 [_LightMatrix0]
                    Vector 16 [_WorldSpaceCameraPos]
                    Vector 17 [_WorldSpaceLightPos0]
                    Vector 18 [unity_Scale]
                    Vector 19 [_localLightDirection]
                    Vector 20 [_MainTex_ST]
                    Vector 21 [_BumpMap_ST]
                    "vs_3_0
                    dcl_position o0
                    dcl_texcoord0 o1
                    dcl_texcoord1 o2
                    dcl_texcoord2 o3
                    dcl_texcoord3 o4
                    dcl_texcoord4 o5
                    def c22, 1.00000000, 0, 0, 0
                    dcl_position0 v0
                    dcl_tangent0 v1
                    dcl_normal0 v2
                    dcl_texcoord0 v3
                    mov r0.w, c22.x
                    mov r0.xyz, c16
                    dp4 r1.z, r0, c10
                    dp4 r1.y, r0, c9
                    dp4 r1.x, r0, c8
                    mad r3.xyz, r1, c18.w, -v0
                    mov r0.xyz, v1
                    mul r1.xyz, v2.zxyw, r0.yzxw
                    mov r0.xyz, v1
                    mad r1.xyz, v2.yzxw, r0.zxyw, -r1
                    mul r2.xyz, r1, v1.w
                    mov r0, c10
                    dp4 r4.z, c17, r0
                    mov r0, c9
                    dp4 r4.y, c17, r0
                    mov r1, c8
                    dp4 r4.x, c17, r1
                    mad r0.xyz, r4, c18.w, -v0
                    dp3 o3.y, r0, r2
                    dp3 o3.z, v2, r0
                    dp3 o3.x, r0, v1
                    dp4 r0.w, v0, c7
                    dp4 r0.z, v0, c6
                    dp4 r0.x, v0, c4
                    dp4 r0.y, v0, c5
                    dp3 o4.y, r2, r3
                    dp3 o4.z, v2, r3
                    dp3 o4.x, v1, r3
                    dp4 o5.z, r0, c14
                    dp4 o5.y, r0, c13
                    dp4 o5.x, r0, c12
                    mad o1.zw, v3.xyxy, c21.xyxy, c21
                    mad o1.xy, v3, c20, c20.zwzw
                    dp4 o0.w, v0, c3
                    dp4 o0.z, v0, c2
                    dp4 o0.y, v0, c1
                    dp4 o0.x, v0, c0
                    dp3 o2.x, v2, c19
                    "
                }
                SubProgram "opengl " {
                    Keywords { "DIRECTIONAL" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" ATTR14
                    Matrix 5 [_World2Object]
                    Vector 9 [_WorldSpaceCameraPos]
                    Vector 10 [_WorldSpaceLightPos0]
                    Vector 11 [unity_Scale]
                    Vector 12 [_localLightDirection]
                    Vector 13 [_MainTex_ST]
                    Vector 14 [_BumpMap_ST]
                    "3.0-!!ARBvp1.0
                    PARAM c[15] = { { 1 },
                    state.matrix.mvp,
                    program.local[5..14] };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    MOV R1.xyz, c[9];
                    MOV R1.w, c[0].x;
                    MOV R0.xyz, vertex.attrib[14];
                    DP4 R2.z, R1, c[7];
                    DP4 R2.y, R1, c[6];
                    DP4 R2.x, R1, c[5];
                    MAD R2.xyz, R2, c[11].w, -vertex.position;
                    MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
                    MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
                    MOV R0, c[10];
                    MUL R1.xyz, R1, vertex.attrib[14].w;
                    DP4 R3.z, R0, c[7];
                    DP4 R3.y, R0, c[6];
                    DP4 R3.x, R0, c[5];
                    DP3 result.texcoord[2].y, R3, R1;
                    DP3 result.texcoord[3].y, R1, R2;
                    DP3 result.texcoord[2].z, vertex.normal, R3;
                    DP3 result.texcoord[2].x, R3, vertex.attrib[14];
                    DP3 result.texcoord[3].z, vertex.normal, R2;
                    DP3 result.texcoord[3].x, vertex.attrib[14], R2;
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[14].xyxy, c[14];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[13], c[13].zwzw;
                    DP4 result.position.w, vertex.position, c[4];
                    DP4 result.position.z, vertex.position, c[3];
                    DP4 result.position.y, vertex.position, c[2];
                    DP4 result.position.x, vertex.position, c[1];
                    DP3 result.texcoord[1].x, vertex.normal, c[12];
                    END
# 27 instructions, 4 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "DIRECTIONAL" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" TexCoord2
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 4 [_World2Object]
                    Vector 8 [_WorldSpaceCameraPos]
                    Vector 9 [_WorldSpaceLightPos0]
                    Vector 10 [unity_Scale]
                    Vector 11 [_localLightDirection]
                    Vector 12 [_MainTex_ST]
                    Vector 13 [_BumpMap_ST]
                    "vs_3_0
                    dcl_position o0
                    dcl_texcoord0 o1
                    dcl_texcoord1 o2
                    dcl_texcoord2 o3
                    dcl_texcoord3 o4
                    def c14, 1.00000000, 0, 0, 0
                    dcl_position0 v0
                    dcl_tangent0 v1
                    dcl_normal0 v2
                    dcl_texcoord0 v3
                    mov r0.w, c14.x
                    mov r0.xyz, c8
                    dp4 r1.z, r0, c6
                    dp4 r1.y, r0, c5
                    dp4 r1.x, r0, c4
                    mad r3.xyz, r1, c10.w, -v0
                    mov r0.xyz, v1
                    mul r1.xyz, v2.zxyw, r0.yzxw
                    mov r0.xyz, v1
                    mad r1.xyz, v2.yzxw, r0.zxyw, -r1
                    mul r2.xyz, r1, v1.w
                    mov r0, c6
                    dp4 r4.z, c9, r0
                    mov r0, c5
                    mov r1, c4
                    dp4 r4.y, c9, r0
                    dp4 r4.x, c9, r1
                    dp3 o3.y, r4, r2
                    dp3 o4.y, r2, r3
                    dp3 o3.z, v2, r4
                    dp3 o3.x, r4, v1
                    dp3 o4.z, v2, r3
                    dp3 o4.x, v1, r3
                    mad o1.zw, v3.xyxy, c13.xyxy, c13
                    mad o1.xy, v3, c12, c12.zwzw
                    dp4 o0.w, v0, c3
                    dp4 o0.z, v0, c2
                    dp4 o0.y, v0, c1
                    dp4 o0.x, v0, c0
                    dp3 o2.x, v2, c11
                    "
                }
                SubProgram "opengl " {
                    Keywords { "SPOT" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" ATTR14
                    Matrix 5 [_Object2World]
                    Matrix 9 [_World2Object]
                    Matrix 13 [_LightMatrix0]
                    Vector 17 [_WorldSpaceCameraPos]
                    Vector 18 [_WorldSpaceLightPos0]
                    Vector 19 [unity_Scale]
                    Vector 20 [_localLightDirection]
                    Vector 21 [_MainTex_ST]
                    Vector 22 [_BumpMap_ST]
                    "3.0-!!ARBvp1.0
                    PARAM c[23] = { { 1 },
                    state.matrix.mvp,
                    program.local[5..22] };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    MOV R1.xyz, c[17];
                    MOV R1.w, c[0].x;
                    MOV R0.xyz, vertex.attrib[14];
                    DP4 R2.z, R1, c[11];
                    DP4 R2.y, R1, c[10];
                    DP4 R2.x, R1, c[9];
                    MAD R2.xyz, R2, c[19].w, -vertex.position;
                    MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
                    MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
                    MOV R0, c[18];
                    MUL R1.xyz, R1, vertex.attrib[14].w;
                    DP4 R3.z, R0, c[11];
                    DP4 R3.x, R0, c[9];
                    DP4 R3.y, R0, c[10];
                    MAD R0.xyz, R3, c[19].w, -vertex.position;
                    DP4 R0.w, vertex.position, c[8];
                    DP3 result.texcoord[2].y, R0, R1;
                    DP3 result.texcoord[2].z, vertex.normal, R0;
                    DP3 result.texcoord[2].x, R0, vertex.attrib[14];
                    DP4 R0.z, vertex.position, c[7];
                    DP4 R0.x, vertex.position, c[5];
                    DP4 R0.y, vertex.position, c[6];
                    DP3 result.texcoord[3].y, R1, R2;
                    DP3 result.texcoord[3].z, vertex.normal, R2;
                    DP3 result.texcoord[3].x, vertex.attrib[14], R2;
                    DP4 result.texcoord[4].w, R0, c[16];
                    DP4 result.texcoord[4].z, R0, c[15];
                    DP4 result.texcoord[4].y, R0, c[14];
                    DP4 result.texcoord[4].x, R0, c[13];
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[22].xyxy, c[22];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[21], c[21].zwzw;
                    DP4 result.position.w, vertex.position, c[4];
                    DP4 result.position.z, vertex.position, c[3];
                    DP4 result.position.y, vertex.position, c[2];
                    DP4 result.position.x, vertex.position, c[1];
                    DP3 result.texcoord[1].x, vertex.normal, c[20];
                    END
# 36 instructions, 4 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "SPOT" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" TexCoord2
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 4 [_Object2World]
                    Matrix 8 [_World2Object]
                    Matrix 12 [_LightMatrix0]
                    Vector 16 [_WorldSpaceCameraPos]
                    Vector 17 [_WorldSpaceLightPos0]
                    Vector 18 [unity_Scale]
                    Vector 19 [_localLightDirection]
                    Vector 20 [_MainTex_ST]
                    Vector 21 [_BumpMap_ST]
                    "vs_3_0
                    dcl_position o0
                    dcl_texcoord0 o1
                    dcl_texcoord1 o2
                    dcl_texcoord2 o3
                    dcl_texcoord3 o4
                    dcl_texcoord4 o5
                    def c22, 1.00000000, 0, 0, 0
                    dcl_position0 v0
                    dcl_tangent0 v1
                    dcl_normal0 v2
                    dcl_texcoord0 v3
                    mov r0.w, c22.x
                    mov r0.xyz, c16
                    dp4 r1.z, r0, c10
                    dp4 r1.y, r0, c9
                    dp4 r1.x, r0, c8
                    mad r3.xyz, r1, c18.w, -v0
                    mov r0.xyz, v1
                    mul r1.xyz, v2.zxyw, r0.yzxw
                    mov r0.xyz, v1
                    mad r1.xyz, v2.yzxw, r0.zxyw, -r1
                    mul r2.xyz, r1, v1.w
                    mov r0, c10
                    dp4 r4.z, c17, r0
                    mov r0, c9
                    dp4 r4.y, c17, r0
                    mov r1, c8
                    dp4 r4.x, c17, r1
                    mad r0.xyz, r4, c18.w, -v0
                    dp4 r0.w, v0, c7
                    dp3 o3.y, r0, r2
                    dp3 o3.z, v2, r0
                    dp3 o3.x, r0, v1
                    dp4 r0.z, v0, c6
                    dp4 r0.x, v0, c4
                    dp4 r0.y, v0, c5
                    dp3 o4.y, r2, r3
                    dp3 o4.z, v2, r3
                    dp3 o4.x, v1, r3
                    dp4 o5.w, r0, c15
                    dp4 o5.z, r0, c14
                    dp4 o5.y, r0, c13
                    dp4 o5.x, r0, c12
                    mad o1.zw, v3.xyxy, c21.xyxy, c21
                    mad o1.xy, v3, c20, c20.zwzw
                    dp4 o0.w, v0, c3
                    dp4 o0.z, v0, c2
                    dp4 o0.y, v0, c1
                    dp4 o0.x, v0, c0
                    dp3 o2.x, v2, c19
                    "
                }
                SubProgram "opengl " {
                    Keywords { "POINT_COOKIE" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" ATTR14
                    Matrix 5 [_Object2World]
                    Matrix 9 [_World2Object]
                    Matrix 13 [_LightMatrix0]
                    Vector 17 [_WorldSpaceCameraPos]
                    Vector 18 [_WorldSpaceLightPos0]
                    Vector 19 [unity_Scale]
                    Vector 20 [_localLightDirection]
                    Vector 21 [_MainTex_ST]
                    Vector 22 [_BumpMap_ST]
                    "3.0-!!ARBvp1.0
                    PARAM c[23] = { { 1 },
                    state.matrix.mvp,
                    program.local[5..22] };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    MOV R1.xyz, c[17];
                    MOV R1.w, c[0].x;
                    MOV R0.xyz, vertex.attrib[14];
                    DP4 R2.z, R1, c[11];
                    DP4 R2.y, R1, c[10];
                    DP4 R2.x, R1, c[9];
                    MAD R2.xyz, R2, c[19].w, -vertex.position;
                    MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
                    MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
                    MOV R0, c[18];
                    MUL R1.xyz, R1, vertex.attrib[14].w;
                    DP4 R3.z, R0, c[11];
                    DP4 R3.x, R0, c[9];
                    DP4 R3.y, R0, c[10];
                    MAD R0.xyz, R3, c[19].w, -vertex.position;
                    DP3 result.texcoord[2].y, R0, R1;
                    DP3 result.texcoord[2].z, vertex.normal, R0;
                    DP3 result.texcoord[2].x, R0, vertex.attrib[14];
                    DP4 R0.w, vertex.position, c[8];
                    DP4 R0.z, vertex.position, c[7];
                    DP4 R0.x, vertex.position, c[5];
                    DP4 R0.y, vertex.position, c[6];
                    DP3 result.texcoord[3].y, R1, R2;
                    DP3 result.texcoord[3].z, vertex.normal, R2;
                    DP3 result.texcoord[3].x, vertex.attrib[14], R2;
                    DP4 result.texcoord[4].z, R0, c[15];
                    DP4 result.texcoord[4].y, R0, c[14];
                    DP4 result.texcoord[4].x, R0, c[13];
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[22].xyxy, c[22];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[21], c[21].zwzw;
                    DP4 result.position.w, vertex.position, c[4];
                    DP4 result.position.z, vertex.position, c[3];
                    DP4 result.position.y, vertex.position, c[2];
                    DP4 result.position.x, vertex.position, c[1];
                    DP3 result.texcoord[1].x, vertex.normal, c[20];
                    END
# 35 instructions, 4 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "POINT_COOKIE" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" TexCoord2
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 4 [_Object2World]
                    Matrix 8 [_World2Object]
                    Matrix 12 [_LightMatrix0]
                    Vector 16 [_WorldSpaceCameraPos]
                    Vector 17 [_WorldSpaceLightPos0]
                    Vector 18 [unity_Scale]
                    Vector 19 [_localLightDirection]
                    Vector 20 [_MainTex_ST]
                    Vector 21 [_BumpMap_ST]
                    "vs_3_0
                    dcl_position o0
                    dcl_texcoord0 o1
                    dcl_texcoord1 o2
                    dcl_texcoord2 o3
                    dcl_texcoord3 o4
                    dcl_texcoord4 o5
                    def c22, 1.00000000, 0, 0, 0
                    dcl_position0 v0
                    dcl_tangent0 v1
                    dcl_normal0 v2
                    dcl_texcoord0 v3
                    mov r0.w, c22.x
                    mov r0.xyz, c16
                    dp4 r1.z, r0, c10
                    dp4 r1.y, r0, c9
                    dp4 r1.x, r0, c8
                    mad r3.xyz, r1, c18.w, -v0
                    mov r0.xyz, v1
                    mul r1.xyz, v2.zxyw, r0.yzxw
                    mov r0.xyz, v1
                    mad r1.xyz, v2.yzxw, r0.zxyw, -r1
                    mul r2.xyz, r1, v1.w
                    mov r0, c10
                    dp4 r4.z, c17, r0
                    mov r0, c9
                    dp4 r4.y, c17, r0
                    mov r1, c8
                    dp4 r4.x, c17, r1
                    mad r0.xyz, r4, c18.w, -v0
                    dp3 o3.y, r0, r2
                    dp3 o3.z, v2, r0
                    dp3 o3.x, r0, v1
                    dp4 r0.w, v0, c7
                    dp4 r0.z, v0, c6
                    dp4 r0.x, v0, c4
                    dp4 r0.y, v0, c5
                    dp3 o4.y, r2, r3
                    dp3 o4.z, v2, r3
                    dp3 o4.x, v1, r3
                    dp4 o5.z, r0, c14
                    dp4 o5.y, r0, c13
                    dp4 o5.x, r0, c12
                    mad o1.zw, v3.xyxy, c21.xyxy, c21
                    mad o1.xy, v3, c20, c20.zwzw
                    dp4 o0.w, v0, c3
                    dp4 o0.z, v0, c2
                    dp4 o0.y, v0, c1
                    dp4 o0.x, v0, c0
                    dp3 o2.x, v2, c19
                    "
                }
                SubProgram "opengl " {
                    Keywords { "DIRECTIONAL_COOKIE" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" ATTR14
                    Matrix 5 [_Object2World]
                    Matrix 9 [_World2Object]
                    Matrix 13 [_LightMatrix0]
                    Vector 17 [_WorldSpaceCameraPos]
                    Vector 18 [_WorldSpaceLightPos0]
                    Vector 19 [unity_Scale]
                    Vector 20 [_localLightDirection]
                    Vector 21 [_MainTex_ST]
                    Vector 22 [_BumpMap_ST]
                    "3.0-!!ARBvp1.0
                    PARAM c[23] = { { 1 },
                    state.matrix.mvp,
                    program.local[5..22] };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    MOV R1.xyz, c[17];
                    MOV R1.w, c[0].x;
                    MOV R0.xyz, vertex.attrib[14];
                    DP4 R2.z, R1, c[11];
                    DP4 R2.y, R1, c[10];
                    DP4 R2.x, R1, c[9];
                    MAD R2.xyz, R2, c[19].w, -vertex.position;
                    MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
                    MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
                    MOV R0, c[18];
                    MUL R1.xyz, R1, vertex.attrib[14].w;
                    DP4 R3.z, R0, c[11];
                    DP4 R3.y, R0, c[10];
                    DP4 R3.x, R0, c[9];
                    DP4 R0.w, vertex.position, c[8];
                    DP4 R0.z, vertex.position, c[7];
                    DP4 R0.x, vertex.position, c[5];
                    DP4 R0.y, vertex.position, c[6];
                    DP3 result.texcoord[2].y, R3, R1;
                    DP3 result.texcoord[3].y, R1, R2;
                    DP3 result.texcoord[2].z, vertex.normal, R3;
                    DP3 result.texcoord[2].x, R3, vertex.attrib[14];
                    DP3 result.texcoord[3].z, vertex.normal, R2;
                    DP3 result.texcoord[3].x, vertex.attrib[14], R2;
                    DP4 result.texcoord[4].y, R0, c[14];
                    DP4 result.texcoord[4].x, R0, c[13];
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[22].xyxy, c[22];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[21], c[21].zwzw;
                    DP4 result.position.w, vertex.position, c[4];
                    DP4 result.position.z, vertex.position, c[3];
                    DP4 result.position.y, vertex.position, c[2];
                    DP4 result.position.x, vertex.position, c[1];
                    DP3 result.texcoord[1].x, vertex.normal, c[20];
                    END
# 33 instructions, 4 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "DIRECTIONAL_COOKIE" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" TexCoord2
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 4 [_Object2World]
                    Matrix 8 [_World2Object]
                    Matrix 12 [_LightMatrix0]
                    Vector 16 [_WorldSpaceCameraPos]
                    Vector 17 [_WorldSpaceLightPos0]
                    Vector 18 [unity_Scale]
                    Vector 19 [_localLightDirection]
                    Vector 20 [_MainTex_ST]
                    Vector 21 [_BumpMap_ST]
                    "vs_3_0
                    dcl_position o0
                    dcl_texcoord0 o1
                    dcl_texcoord1 o2
                    dcl_texcoord2 o3
                    dcl_texcoord3 o4
                    dcl_texcoord4 o5
                    def c22, 1.00000000, 0, 0, 0
                    dcl_position0 v0
                    dcl_tangent0 v1
                    dcl_normal0 v2
                    dcl_texcoord0 v3
                    mov r0.w, c22.x
                    mov r0.xyz, c16
                    dp4 r1.z, r0, c10
                    dp4 r1.y, r0, c9
                    dp4 r1.x, r0, c8
                    mad r3.xyz, r1, c18.w, -v0
                    mov r0.xyz, v1
                    mul r1.xyz, v2.zxyw, r0.yzxw
                    mov r0.xyz, v1
                    mad r1.xyz, v2.yzxw, r0.zxyw, -r1
                    mul r2.xyz, r1, v1.w
                    mov r0, c10
                    dp4 r4.z, c17, r0
                    mov r0, c9
                    dp4 r4.y, c17, r0
                    mov r1, c8
                    dp4 r4.x, c17, r1
                    dp4 r0.w, v0, c7
                    dp4 r0.z, v0, c6
                    dp4 r0.x, v0, c4
                    dp4 r0.y, v0, c5
                    dp3 o3.y, r4, r2
                    dp3 o4.y, r2, r3
                    dp3 o3.z, v2, r4
                    dp3 o3.x, r4, v1
                    dp3 o4.z, v2, r3
                    dp3 o4.x, v1, r3
                    dp4 o5.y, r0, c13
                    dp4 o5.x, r0, c12
                    mad o1.zw, v3.xyxy, c21.xyxy, c21
                    mad o1.xy, v3, c20, c20.zwzw
                    dp4 o0.w, v0, c3
                    dp4 o0.z, v0, c2
                    dp4 o0.y, v0, c1
                    dp4 o0.x, v0, c0
                    dp3 o2.x, v2, c19
                    "
                }
            }
            Program "fp" {
// Platform d3d11 had shader errors
//   Keywords { "POINT" }
//   Keywords { "DIRECTIONAL" }
//   Keywords { "SPOT" }
//   Keywords { "POINT_COOKIE" }
//   Keywords { "DIRECTIONAL_COOKIE" }
                SubProgram "opengl " {
                    Keywords { "POINT" }
                    Vector 0 [_LightColor0]
                    Vector 1 [_SpecColor]
                    Vector 2 [_Color]
                    Float 3 [_Shininess]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_LightTexture0] 2D 2
                    "3.0-!!ARBfp1.0
                    PARAM c[6] = { program.local[0..4],
                    { 0, 2, 1, 128 } };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
                    MAD R1.xy, R0.wyzw, c[5].y, -c[5].z;
                    MUL R1.zw, R1.xyxy, R1.xyxy;
                    ADD_SAT R0.w, R1.z, R1;
                    DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
                    RSQ R0.x, R0.x;
                    MUL R2.xyz, R0.x, fragment.texcoord[2];
                    DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
                    RSQ R0.x, R0.x;
                    MAD R0.xyz, R0.x, fragment.texcoord[3], R2;
                    DP3 R1.z, R0, R0;
                    RSQ R1.z, R1.z;
                    ADD R0.w, -R0, c[5].z;
                    MUL R0.xyz, R1.z, R0;
                    RSQ R0.w, R0.w;
                    RCP R1.z, R0.w;
                    DP3 R0.y, R1, R0;
                    DP3 R1.x, R1, R2;
                    MOV R0.x, c[5].w;
                    MAX R1.w, R0.y, c[5].x;
                    MUL R2.w, R0.x, c[3].x;
                    TEX R0, fragment.texcoord[0], texture[0], 2D;
                    POW R1.w, R1.w, R2.w;
                    MUL R0.w, R1, R0;
                    MUL R0.xyz, R0, c[2];
                    DP3 R1.w, fragment.texcoord[4], fragment.texcoord[4];
                    TEX R1.w, R1.w, texture[2], 2D;
                    MUL R0.xyz, R0, c[0];
                    MAX R1.x, R1, c[5];
                    MUL R1.xyz, R0, R1.x;
                    MOV R0.xyz, c[1];
                    MUL R0.xyz, R0, c[0];
                    MUL R1.w, R1, c[5].y;
                    MAD R0.xyz, R0, R0.w, R1;
                    MUL result.color.xyz, R0, R1.w;
                    MOV result.color.w, c[5].x;
                    END
# 36 instructions, 3 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "POINT" }
                    Vector 0 [_LightColor0]
                    Vector 1 [_SpecColor]
                    Vector 2 [_Color]
                    Float 3 [_Shininess]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_LightTexture0] 2D 2
                    "ps_3_0
                    dcl_2d s0
                    dcl_2d s1
                    dcl_2d s2
                    def c4, 2.00000000, -1.00000000, 1.00000000, 0.00000000
                    def c5, 128.00000000, 0, 0, 0
                    dcl_texcoord0 v0
                    dcl_texcoord2 v2.xyz
                    dcl_texcoord3 v3.xyz
                    dcl_texcoord4 v4.xyz
                    texld r0.yw, v0.zwzw, s1
                    mad_pp r1.xy, r0.wyzw, c4.x, c4.y
                    mul_pp r1.zw, r1.xyxy, r1.xyxy
                    add_pp_sat r0.w, r1.z, r1
                    dp3_pp r0.x, v2, v2
                    rsq_pp r0.x, r0.x
                    mul_pp r2.xyz, r0.x, v2
                    dp3_pp r0.x, v3, v3
                    rsq_pp r0.x, r0.x
                    mad_pp r0.xyz, r0.x, v3, r2
                    dp3_pp r1.z, r0, r0
                    rsq_pp r1.z, r1.z
                    add_pp r0.w, -r0, c4.z
                    mul_pp r0.xyz, r1.z, r0
                    rsq_pp r0.w, r0.w
                    rcp_pp r1.z, r0.w
                    dp3_pp r0.x, r1, r0
                    mov_pp r0.w, c3.x
                    texld r3, v0, s0
                    mul_pp r1.w, c5.x, r0
                    max_pp r2.w, r0.x, c4
                    pow r0, r2.w, r1.w
                    mul r0.y, r0.x, r3.w
                    dp3_pp r0.x, r1, r2
                    mul_pp r1.xyz, r3, c2
                    max_pp r0.x, r0, c4.w
                    mul_pp r1.xyz, r1, c0
                    mul_pp r2.xyz, r1, r0.x
                    dp3 r0.x, v4, v4
                    texld r0.x, r0.x, s2
                    mov_pp r1.xyz, c0
                    mul_pp r0.w, r0.x, c4.x
                    mul_pp r1.xyz, c1, r1
                    mad r0.xyz, r1, r0.y, r2
                    mul oC0.xyz, r0, r0.w
                    mov_pp oC0.w, c4
                    "
                }
                SubProgram "opengl " {
                    Keywords { "DIRECTIONAL" }
                    Vector 0 [_LightColor0]
                    Vector 1 [_SpecColor]
                    Vector 2 [_Color]
                    Float 3 [_Shininess]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    "3.0-!!ARBfp1.0
                    PARAM c[6] = { program.local[0..4],
                    { 0, 2, 1, 128 } };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEX R1.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
                    MAD R1.xy, R1.wyzw, c[5].y, -c[5].z;
                    DP3 R0.w, fragment.texcoord[3], fragment.texcoord[3];
                    MUL R1.zw, R1.xyxy, R1.xyxy;
                    RSQ R0.w, R0.w;
                    MOV R0.xyz, fragment.texcoord[2];
                    MAD R0.xyz, R0.w, fragment.texcoord[3], R0;
                    ADD_SAT R0.w, R1.z, R1;
                    DP3 R1.z, R0, R0;
                    RSQ R1.z, R1.z;
                    ADD R0.w, -R0, c[5].z;
                    MUL R0.xyz, R1.z, R0;
                    RSQ R0.w, R0.w;
                    RCP R1.z, R0.w;
                    DP3 R0.y, R1, R0;
                    MOV R0.x, c[5].w;
                    MAX R1.w, R0.y, c[5].x;
                    MUL R2.x, R0, c[3];
                    TEX R0, fragment.texcoord[0], texture[0], 2D;
                    POW R1.w, R1.w, R2.x;
                    MUL R0.w, R1, R0;
                    DP3 R1.w, R1, fragment.texcoord[2];
                    MUL R0.xyz, R0, c[2];
                    MUL R1.xyz, R0, c[0];
                    MAX R1.w, R1, c[5].x;
                    MOV R0.xyz, c[1];
                    MUL R1.xyz, R1, R1.w;
                    MUL R0.xyz, R0, c[0];
                    MAD R0.xyz, R0, R0.w, R1;
                    MUL result.color.xyz, R0, c[5].y;
                    MOV result.color.w, c[5].x;
                    END
# 31 instructions, 3 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "DIRECTIONAL" }
                    Vector 0 [_LightColor0]
                    Vector 1 [_SpecColor]
                    Vector 2 [_Color]
                    Float 3 [_Shininess]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    "ps_3_0
                    dcl_2d s0
                    dcl_2d s1
                    def c4, 2.00000000, -1.00000000, 1.00000000, 0.00000000
                    def c5, 128.00000000, 0, 0, 0
                    dcl_texcoord0 v0
                    dcl_texcoord2 v2.xyz
                    dcl_texcoord3 v3.xyz
                    texld r1.yw, v0.zwzw, s1
                    mad_pp r1.xy, r1.wyzw, c4.x, c4.y
                    dp3_pp r0.w, v3, v3
                    mul_pp r1.zw, r1.xyxy, r1.xyxy
                    rsq_pp r0.w, r0.w
                    mov_pp r0.xyz, v2
                    mad_pp r0.xyz, r0.w, v3, r0
                    add_pp_sat r0.w, r1.z, r1
                    dp3_pp r1.z, r0, r0
                    rsq_pp r1.z, r1.z
                    add_pp r0.w, -r0, c4.z
                    mul_pp r0.xyz, r1.z, r0
                    rsq_pp r0.w, r0.w
                    rcp_pp r1.z, r0.w
                    dp3_pp r0.x, r1, r0
                    mov_pp r0.w, c3.x
                    mul_pp r2.x, c5, r0.w
                    max_pp r1.w, r0.x, c4
                    pow r0, r1.w, r2.x
                    texld r2, v0, s0
                    dp3_pp r0.y, r1, v2
                    mul_pp r2.xyz, r2, c2
                    mov_pp r1.xyz, c0
                    max_pp r0.y, r0, c4.w
                    mul_pp r2.xyz, r2, c0
                    mul r0.x, r0, r2.w
                    mul_pp r2.xyz, r2, r0.y
                    mul_pp r1.xyz, c1, r1
                    mad r0.xyz, r1, r0.x, r2
                    mul oC0.xyz, r0, c4.x
                    mov_pp oC0.w, c4
                    "
                }
                SubProgram "opengl " {
                    Keywords { "SPOT" }
                    Vector 0 [_LightColor0]
                    Vector 1 [_SpecColor]
                    Vector 2 [_Color]
                    Float 3 [_Shininess]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_LightTexture0] 2D 2
                    SetTexture 3 [_LightTextureB0] 2D 3
                    "3.0-!!ARBfp1.0
                    PARAM c[7] = { program.local[0..4],
                    { 0, 2, 1, 128 },
                    { 0.5 } };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
                    MAD R1.xy, R0.wyzw, c[5].y, -c[5].z;
                    MUL R1.zw, R1.xyxy, R1.xyxy;
                    ADD_SAT R0.w, R1.z, R1;
                    DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
                    RSQ R0.x, R0.x;
                    MUL R2.xyz, R0.x, fragment.texcoord[2];
                    DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
                    RSQ R0.x, R0.x;
                    MAD R0.xyz, R0.x, fragment.texcoord[3], R2;
                    DP3 R1.z, R0, R0;
                    RSQ R1.z, R1.z;
                    ADD R0.w, -R0, c[5].z;
                    MUL R0.xyz, R1.z, R0;
                    RSQ R0.w, R0.w;
                    RCP R1.z, R0.w;
                    DP3 R0.y, R1, R0;
                    MOV R0.x, c[5].w;
                    MUL R2.w, R0.x, c[3].x;
                    MAX R1.w, R0.y, c[5].x;
                    TEX R0, fragment.texcoord[0], texture[0], 2D;
                    POW R1.w, R1.w, R2.w;
                    MUL R2.w, R1, R0;
                    DP3 R0.w, R1, R2;
                    MUL R0.xyz, R0, c[2];
                    DP3 R1.w, fragment.texcoord[4], fragment.texcoord[4];
                    MAX R0.w, R0, c[5].x;
                    MUL R0.xyz, R0, c[0];
                    MUL R1.xyz, R0, R0.w;
                    RCP R0.w, fragment.texcoord[4].w;
                    MAD R2.xy, fragment.texcoord[4], R0.w, c[6].x;
                    TEX R0.w, R2, texture[2], 2D;
                    MOV R0.xyz, c[1];
                    SLT R2.x, c[5], fragment.texcoord[4].z;
                    MUL R0.xyz, R0, c[0];
                    TEX R1.w, R1.w, texture[3], 2D;
                    MUL R0.w, R2.x, R0;
                    MUL R0.w, R0, R1;
                    MUL R0.w, R0, c[5].y;
                    MAD R0.xyz, R0, R2.w, R1;
                    MUL result.color.xyz, R0, R0.w;
                    MOV result.color.w, c[5].x;
                    END
# 42 instructions, 3 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "SPOT" }
                    Vector 0 [_LightColor0]
                    Vector 1 [_SpecColor]
                    Vector 2 [_Color]
                    Float 3 [_Shininess]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_LightTexture0] 2D 2
                    SetTexture 3 [_LightTextureB0] 2D 3
                    "ps_3_0
                    dcl_2d s0
                    dcl_2d s1
                    dcl_2d s2
                    dcl_2d s3
                    def c4, 2.00000000, -1.00000000, 1.00000000, 0.00000000
                    def c5, 128.00000000, 0.50000000, 0, 0
                    dcl_texcoord0 v0
                    dcl_texcoord2 v2.xyz
                    dcl_texcoord3 v3.xyz
                    dcl_texcoord4 v4
                    texld r0.yw, v0.zwzw, s1
                    mad_pp r1.xy, r0.wyzw, c4.x, c4.y
                    mul_pp r1.zw, r1.xyxy, r1.xyxy
                    add_pp_sat r0.w, r1.z, r1
                    dp3_pp r0.x, v2, v2
                    rsq_pp r0.x, r0.x
                    mul_pp r2.xyz, r0.x, v2
                    dp3_pp r0.x, v3, v3
                    rsq_pp r0.x, r0.x
                    mad_pp r0.xyz, r0.x, v3, r2
                    dp3_pp r1.z, r0, r0
                    rsq_pp r1.z, r1.z
                    add_pp r0.w, -r0, c4.z
                    mul_pp r0.xyz, r1.z, r0
                    rsq_pp r0.w, r0.w
                    rcp_pp r1.z, r0.w
                    dp3_pp r0.x, r1, r0
                    mov_pp r0.w, c3.x
                    texld r3, v0, s0
                    mul_pp r1.w, c5.x, r0
                    max_pp r2.w, r0.x, c4
                    pow r0, r2.w, r1.w
                    mul r0.y, r0.x, r3.w
                    dp3_pp r0.x, r1, r2
                    mul_pp r1.xyz, r3, c2
                    max_pp r0.x, r0, c4.w
                    mul_pp r1.xyz, r1, c0
                    mul_pp r2.xyz, r1, r0.x
                    rcp r0.x, v4.w
                    mad r3.xy, v4, r0.x, c5.y
                    mov_pp r1.xyz, c0
                    dp3 r0.x, v4, v4
                    texld r0.w, r3, s2
                    cmp r0.z, -v4, c4.w, c4
                    mul_pp r0.z, r0, r0.w
                    texld r0.x, r0.x, s3
                    mul_pp r0.x, r0.z, r0
                    mul_pp r0.w, r0.x, c4.x
                    mul_pp r1.xyz, c1, r1
                    mad r0.xyz, r1, r0.y, r2
                    mul oC0.xyz, r0, r0.w
                    mov_pp oC0.w, c4
                    "
                }
                SubProgram "opengl " {
                    Keywords { "POINT_COOKIE" }
                    Vector 0 [_LightColor0]
                    Vector 1 [_SpecColor]
                    Vector 2 [_Color]
                    Float 3 [_Shininess]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_LightTextureB0] 2D 2
                    SetTexture 3 [_LightTexture0] CUBE 3
                    "3.0-!!ARBfp1.0
                    PARAM c[6] = { program.local[0..4],
                    { 0, 2, 1, 128 } };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
                    MAD R1.xy, R0.wyzw, c[5].y, -c[5].z;
                    MUL R1.zw, R1.xyxy, R1.xyxy;
                    ADD_SAT R0.w, R1.z, R1;
                    DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
                    RSQ R0.x, R0.x;
                    MUL R2.xyz, R0.x, fragment.texcoord[2];
                    DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
                    RSQ R0.x, R0.x;
                    MAD R0.xyz, R0.x, fragment.texcoord[3], R2;
                    DP3 R1.z, R0, R0;
                    RSQ R1.z, R1.z;
                    ADD R0.w, -R0, c[5].z;
                    MUL R0.xyz, R1.z, R0;
                    RSQ R0.w, R0.w;
                    RCP R1.z, R0.w;
                    DP3 R0.y, R1, R0;
                    MOV R0.x, c[5].w;
                    MUL R2.w, R0.x, c[3].x;
                    MAX R1.w, R0.y, c[5].x;
                    TEX R0, fragment.texcoord[0], texture[0], 2D;
                    POW R1.w, R1.w, R2.w;
                    MUL R2.w, R1, R0;
                    DP3 R0.w, R1, R2;
                    MUL R0.xyz, R0, c[2];
                    DP3 R1.w, fragment.texcoord[4], fragment.texcoord[4];
                    MAX R0.w, R0, c[5].x;
                    MUL R0.xyz, R0, c[0];
                    MUL R1.xyz, R0, R0.w;
                    MOV R0.xyz, c[1];
                    MUL R0.xyz, R0, c[0];
                    TEX R0.w, fragment.texcoord[4], texture[3], CUBE;
                    TEX R1.w, R1.w, texture[2], 2D;
                    MUL R0.w, R1, R0;
                    MUL R0.w, R0, c[5].y;
                    MAD R0.xyz, R0, R2.w, R1;
                    MUL result.color.xyz, R0, R0.w;
                    MOV result.color.w, c[5].x;
                    END
# 38 instructions, 3 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "POINT_COOKIE" }
                    Vector 0 [_LightColor0]
                    Vector 1 [_SpecColor]
                    Vector 2 [_Color]
                    Float 3 [_Shininess]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_LightTextureB0] 2D 2
                    SetTexture 3 [_LightTexture0] CUBE 3
                    "ps_3_0
                    dcl_2d s0
                    dcl_2d s1
                    dcl_2d s2
                    dcl_cube s3
                    def c4, 2.00000000, -1.00000000, 1.00000000, 0.00000000
                    def c5, 128.00000000, 0, 0, 0
                    dcl_texcoord0 v0
                    dcl_texcoord2 v2.xyz
                    dcl_texcoord3 v3.xyz
                    dcl_texcoord4 v4.xyz
                    texld r0.yw, v0.zwzw, s1
                    mad_pp r1.xy, r0.wyzw, c4.x, c4.y
                    mul_pp r1.zw, r1.xyxy, r1.xyxy
                    add_pp_sat r0.w, r1.z, r1
                    dp3_pp r0.x, v2, v2
                    rsq_pp r0.x, r0.x
                    mul_pp r2.xyz, r0.x, v2
                    dp3_pp r0.x, v3, v3
                    rsq_pp r0.x, r0.x
                    mad_pp r0.xyz, r0.x, v3, r2
                    dp3_pp r1.z, r0, r0
                    rsq_pp r1.z, r1.z
                    add_pp r0.w, -r0, c4.z
                    mul_pp r0.xyz, r1.z, r0
                    rsq_pp r0.w, r0.w
                    rcp_pp r1.z, r0.w
                    dp3_pp r0.x, r1, r0
                    mov_pp r0.w, c3.x
                    texld r3, v0, s0
                    mul_pp r1.w, c5.x, r0
                    max_pp r2.w, r0.x, c4
                    pow r0, r2.w, r1.w
                    mul r0.y, r0.x, r3.w
                    dp3_pp r0.x, r1, r2
                    mul_pp r1.xyz, r3, c2
                    max_pp r0.x, r0, c4.w
                    mul_pp r1.xyz, r1, c0
                    mul_pp r2.xyz, r1, r0.x
                    mov_pp r1.xyz, c0
                    dp3 r0.x, v4, v4
                    texld r0.w, v4, s3
                    texld r0.x, r0.x, s2
                    mul r0.x, r0, r0.w
                    mul_pp r0.w, r0.x, c4.x
                    mul_pp r1.xyz, c1, r1
                    mad r0.xyz, r1, r0.y, r2
                    mul oC0.xyz, r0, r0.w
                    mov_pp oC0.w, c4
                    "
                }
                SubProgram "opengl " {
                    Keywords { "DIRECTIONAL_COOKIE" }
                    Vector 0 [_LightColor0]
                    Vector 1 [_SpecColor]
                    Vector 2 [_Color]
                    Float 3 [_Shininess]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_LightTexture0] 2D 2
                    "3.0-!!ARBfp1.0
                    PARAM c[6] = { program.local[0..4],
                    { 0, 2, 1, 128 } };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEX R1.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
                    MAD R1.xy, R1.wyzw, c[5].y, -c[5].z;
                    DP3 R0.w, fragment.texcoord[3], fragment.texcoord[3];
                    MUL R1.zw, R1.xyxy, R1.xyxy;
                    RSQ R0.w, R0.w;
                    MOV R0.xyz, fragment.texcoord[2];
                    MAD R0.xyz, R0.w, fragment.texcoord[3], R0;
                    ADD_SAT R0.w, R1.z, R1;
                    DP3 R1.z, R0, R0;
                    RSQ R1.z, R1.z;
                    ADD R0.w, -R0, c[5].z;
                    MUL R0.xyz, R1.z, R0;
                    RSQ R0.w, R0.w;
                    RCP R1.z, R0.w;
                    DP3 R0.y, R1, R0;
                    DP3 R1.x, R1, fragment.texcoord[2];
                    MOV R0.x, c[5].w;
                    MAX R1.w, R0.y, c[5].x;
                    MUL R2.x, R0, c[3];
                    TEX R0, fragment.texcoord[0], texture[0], 2D;
                    POW R1.w, R1.w, R2.x;
                    MUL R0.w, R1, R0;
                    MUL R0.xyz, R0, c[2];
                    TEX R1.w, fragment.texcoord[4], texture[2], 2D;
                    MUL R0.xyz, R0, c[0];
                    MAX R1.x, R1, c[5];
                    MUL R1.xyz, R0, R1.x;
                    MOV R0.xyz, c[1];
                    MUL R0.xyz, R0, c[0];
                    MUL R1.w, R1, c[5].y;
                    MAD R0.xyz, R0, R0.w, R1;
                    MUL result.color.xyz, R0, R1.w;
                    MOV result.color.w, c[5].x;
                    END
# 33 instructions, 3 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "DIRECTIONAL_COOKIE" }
                    Vector 0 [_LightColor0]
                    Vector 1 [_SpecColor]
                    Vector 2 [_Color]
                    Float 3 [_Shininess]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_LightTexture0] 2D 2
                    "ps_3_0
                    dcl_2d s0
                    dcl_2d s1
                    dcl_2d s2
                    def c4, 2.00000000, -1.00000000, 1.00000000, 0.00000000
                    def c5, 128.00000000, 0, 0, 0
                    dcl_texcoord0 v0
                    dcl_texcoord2 v2.xyz
                    dcl_texcoord3 v3.xyz
                    dcl_texcoord4 v4.xy
                    texld r1.yw, v0.zwzw, s1
                    mad_pp r1.xy, r1.wyzw, c4.x, c4.y
                    dp3_pp r0.w, v3, v3
                    mul_pp r1.zw, r1.xyxy, r1.xyxy
                    rsq_pp r0.w, r0.w
                    mov_pp r0.xyz, v2
                    mad_pp r0.xyz, r0.w, v3, r0
                    add_pp_sat r0.w, r1.z, r1
                    dp3_pp r1.z, r0, r0
                    rsq_pp r1.z, r1.z
                    add_pp r0.w, -r0, c4.z
                    mul_pp r0.xyz, r1.z, r0
                    rsq_pp r0.w, r0.w
                    rcp_pp r1.z, r0.w
                    dp3_pp r0.x, r1, r0
                    mov_pp r0.w, c3.x
                    mul_pp r2.x, c5, r0.w
                    max_pp r1.w, r0.x, c4
                    pow r0, r1.w, r2.x
                    texld r2, v0, s0
                    dp3_pp r0.y, r1, v2
                    mul_pp r1.xyz, r2, c2
                    max_pp r0.y, r0, c4.w
                    mul_pp r1.xyz, r1, c0
                    mul_pp r2.xyz, r1, r0.y
                    mov_pp r1.xyz, c0
                    texld r0.w, v4, s2
                    mul r0.x, r0, r2.w
                    mul_pp r1.xyz, c1, r1
                    mul_pp r0.y, r0.w, c4.x
                    mad r1.xyz, r1, r0.x, r2
                    mul oC0.xyz, r1, r0.y
                    mov_pp oC0.w, c4
                    "
                }
            }
        }
        Pass {
            Name "PREPASS"
            Tags { "LIGHTMODE"="PrePassBase" }
            Fog { Mode Off }
            Blend SrcAlpha OneMinusSrcAlpha
            Program "vp" {
// Platform d3d11 skipped due to earlier errors
// Platform d3d11 had shader errors
//   <no keywords>
                SubProgram "opengl " {
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" ATTR14
                    Matrix 5 [_Object2World]
                    Vector 9 [unity_Scale]
                    Vector 10 [_localLightDirection]
                    Vector 11 [_BumpMap_ST]
                    "3.0-!!ARBvp1.0
                    PARAM c[12] = { program.local[0],
                    state.matrix.mvp,
                    program.local[5..11] };
                    TEMP R0;
                    TEMP R1;
                    MOV R0.xyz, vertex.attrib[14];
                    MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
                    MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
                    MUL R1.xyz, R0, vertex.attrib[14].w;
                    DP3 R0.y, R1, c[5];
                    DP3 R0.x, vertex.attrib[14], c[5];
                    DP3 R0.z, vertex.normal, c[5];
                    MUL result.texcoord[2].xyz, R0, c[9].w;
                    DP3 R0.y, R1, c[6];
                    DP3 R0.x, vertex.attrib[14], c[6];
                    DP3 R0.z, vertex.normal, c[6];
                    MUL result.texcoord[3].xyz, R0, c[9].w;
                    DP3 R0.y, R1, c[7];
                    DP3 R0.x, vertex.attrib[14], c[7];
                    DP3 R0.z, vertex.normal, c[7];
                    MUL result.texcoord[4].xyz, R0, c[9].w;
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[11], c[11].zwzw;
                    DP4 result.position.w, vertex.position, c[4];
                    DP4 result.position.z, vertex.position, c[3];
                    DP4 result.position.y, vertex.position, c[2];
                    DP4 result.position.x, vertex.position, c[1];
                    DP3 result.texcoord[1].x, vertex.normal, c[10];
                    END
# 22 instructions, 2 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" TexCoord2
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 4 [_Object2World]
                    Vector 8 [unity_Scale]
                    Vector 9 [_localLightDirection]
                    Vector 10 [_BumpMap_ST]
                    "vs_3_0
                    dcl_position o0
                    dcl_texcoord0 o1
                    dcl_texcoord1 o2
                    dcl_texcoord2 o3
                    dcl_texcoord3 o4
                    dcl_texcoord4 o5
                    dcl_position0 v0
                    dcl_tangent0 v1
                    dcl_normal0 v2
                    dcl_texcoord0 v3
                    mov r0.xyz, v1
                    mul r1.xyz, v2.zxyw, r0.yzxw
                    mov r0.xyz, v1
                    mad r0.xyz, v2.yzxw, r0.zxyw, -r1
                    mul r1.xyz, r0, v1.w
                    dp3 r0.y, r1, c4
                    dp3 r0.x, v1, c4
                    dp3 r0.z, v2, c4
                    mul o3.xyz, r0, c8.w
                    dp3 r0.y, r1, c5
                    dp3 r0.x, v1, c5
                    dp3 r0.z, v2, c5
                    mul o4.xyz, r0, c8.w
                    dp3 r0.y, r1, c6
                    dp3 r0.x, v1, c6
                    dp3 r0.z, v2, c6
                    mul o5.xyz, r0, c8.w
                    mad o1.xy, v3, c10, c10.zwzw
                    dp4 o0.w, v0, c3
                    dp4 o0.z, v0, c2
                    dp4 o0.y, v0, c1
                    dp4 o0.x, v0, c0
                    dp3 o2.x, v2, c9
                    "
                }
            }
            Program "fp" {
// Platform d3d11 skipped due to earlier errors
// Platform d3d11 had shader errors
//   <no keywords>
                SubProgram "opengl " {
                    Float 0 [_Shininess]
                    SetTexture 1 [_BumpMap] 2D 1
                    "3.0-!!ARBfp1.0
                    PARAM c[2] = { program.local[0],
                    { 2, 1, 0.5 } };
                    TEMP R0;
                    TEMP R1;
                    TEX R0.yw, fragment.texcoord[0], texture[1], 2D;
                    MAD R0.xy, R0.wyzw, c[1].x, -c[1].y;
                    MUL R0.zw, R0.xyxy, R0.xyxy;
                    ADD_SAT R0.z, R0, R0.w;
                    ADD R0.z, -R0, c[1].y;
                    RSQ R0.z, R0.z;
                    RCP R0.z, R0.z;
                    DP3 R1.z, fragment.texcoord[4], R0;
                    DP3 R1.x, R0, fragment.texcoord[2];
                    DP3 R1.y, R0, fragment.texcoord[3];
                    MAD result.color.xyz, R1, c[1].z, c[1].z;
                    MOV result.color.w, c[0].x;
                    END
# 12 instructions, 2 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Float 0 [_Shininess]
                    SetTexture 1 [_BumpMap] 2D 1
                    "ps_3_0
                    dcl_2d s1
                    def c1, 2.00000000, -1.00000000, 1.00000000, 0.50000000
                    dcl_texcoord0 v0.xy
                    dcl_texcoord2 v2.xyz
                    dcl_texcoord3 v3.xyz
                    dcl_texcoord4 v4.xyz
                    texld r0.yw, v0, s1
                    mad_pp r0.xy, r0.wyzw, c1.x, c1.y
                    mul_pp r0.zw, r0.xyxy, r0.xyxy
                    add_pp_sat r0.z, r0, r0.w
                    add_pp r0.z, -r0, c1
                    rsq_pp r0.z, r0.z
                    rcp_pp r0.z, r0.z
                    dp3 r1.z, v4, r0
                    dp3 r1.x, r0, v2
                    dp3 r1.y, r0, v3
                    mad_pp oC0.xyz, r1, c1.w, c1.w
                    mov_pp oC0.w, c0.x
                    "
                }
            }
        }
        Pass {
            Name "PREPASS"
            Tags { "LIGHTMODE"="PrePassFinal" }
            ZWrite Off
            Blend SrcAlpha OneMinusSrcAlpha
            Program "vp" {
// Platform d3d11 had shader errors
//   Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
//   Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
//   Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
//   Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
//   Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
//   Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
                SubProgram "opengl " {
                    Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" ATTR14
                    Matrix 5 [_Object2World]
                    Matrix 9 [_World2Object]
                    Vector 13 [_WorldSpaceCameraPos]
                    Vector 14 [_ProjectionParams]
                    Vector 15 [unity_SHAr]
                    Vector 16 [unity_SHAg]
                    Vector 17 [unity_SHAb]
                    Vector 18 [unity_SHBr]
                    Vector 19 [unity_SHBg]
                    Vector 20 [unity_SHBb]
                    Vector 21 [unity_SHC]
                    Vector 22 [unity_Scale]
                    Vector 23 [_localLightDirection]
                    Vector 24 [_MainTex_ST]
                    Vector 25 [_BumpMap_ST]
                    Vector 26 [_ResourceMap_ST]
                    "3.0-!!ARBvp1.0
                    PARAM c[27] = { { 1, 0.5 },
                    state.matrix.mvp,
                    program.local[5..26] };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    MUL R1.xyz, vertex.normal, c[22].w;
                    DP3 R2.w, R1, c[6];
                    DP3 R0.x, R1, c[5];
                    DP3 R0.z, R1, c[7];
                    MOV R0.y, R2.w;
                    MUL R1, R0.xyzz, R0.yzzx;
                    MOV R0.w, c[0].x;
                    DP4 R2.z, R0, c[17];
                    DP4 R2.y, R0, c[16];
                    DP4 R2.x, R0, c[15];
                    MUL R0.y, R2.w, R2.w;
                    DP4 R3.z, R1, c[20];
                    DP4 R3.x, R1, c[18];
                    DP4 R3.y, R1, c[19];
                    ADD R2.xyz, R2, R3;
                    MAD R0.w, R0.x, R0.x, -R0.y;
                    MUL R3.xyz, R0.w, c[21];
                    MOV R1.xyz, vertex.attrib[14];
                    MUL R0.xyz, vertex.normal.zxyw, R1.yzxw;
                    MAD R0.xyz, vertex.normal.yzxw, R1.zxyw, -R0;
                    MUL R0.xyz, R0, vertex.attrib[14].w;
                    MOV R1.xyz, c[13];
                    ADD result.texcoord[5].xyz, R2, R3;
                    MOV R1.w, c[0].x;
                    DP4 R0.w, vertex.position, c[4];
                    DP4 R2.z, R1, c[11];
                    DP4 R2.x, R1, c[9];
                    DP4 R2.y, R1, c[10];
                    MAD R2.xyz, R2, c[22].w, -vertex.position;
                    DP3 result.texcoord[2].y, R2, R0;
                    DP4 R0.z, vertex.position, c[3];
                    DP4 R0.x, vertex.position, c[1];
                    DP4 R0.y, vertex.position, c[2];
                    MUL R1.xyz, R0.xyww, c[0].y;
                    MUL R1.y, R1, c[14].x;
                    DP3 result.texcoord[2].z, vertex.normal, R2;
                    DP3 result.texcoord[2].x, R2, vertex.attrib[14];
                    ADD result.texcoord[4].xy, R1, R1.z;
                    MOV result.position, R0;
                    MOV result.texcoord[4].zw, R0;
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[25].xyxy, c[25];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[24], c[24].zwzw;
                    MAD result.texcoord[1].xy, vertex.texcoord[0], c[26], c[26].zwzw;
                    DP3 result.texcoord[3].x, vertex.normal, c[23];
                    END
# 44 instructions, 4 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" TexCoord2
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 4 [_Object2World]
                    Matrix 8 [_World2Object]
                    Vector 12 [_WorldSpaceCameraPos]
                    Vector 13 [_ProjectionParams]
                    Vector 14 [_ScreenParams]
                    Vector 15 [unity_SHAr]
                    Vector 16 [unity_SHAg]
                    Vector 17 [unity_SHAb]
                    Vector 18 [unity_SHBr]
                    Vector 19 [unity_SHBg]
                    Vector 20 [unity_SHBb]
                    Vector 21 [unity_SHC]
                    Vector 22 [unity_Scale]
                    Vector 23 [_localLightDirection]
                    Vector 24 [_MainTex_ST]
                    Vector 25 [_BumpMap_ST]
                    Vector 26 [_ResourceMap_ST]
                    "vs_3_0
                    dcl_position o0
                    dcl_texcoord0 o1
                    dcl_texcoord1 o2
                    dcl_texcoord2 o3
                    dcl_texcoord3 o4
                    dcl_texcoord4 o5
                    dcl_texcoord5 o6
                    def c27, 1.00000000, 0.50000000, 0, 0
                    dcl_position0 v0
                    dcl_tangent0 v1
                    dcl_normal0 v2
                    dcl_texcoord0 v3
                    mul r1.xyz, v2, c22.w
                    dp3 r2.w, r1, c5
                    dp3 r0.x, r1, c4
                    dp3 r0.z, r1, c6
                    mov r0.y, r2.w
                    mul r1, r0.xyzz, r0.yzzx
                    mov r0.w, c27.x
                    dp4 r2.z, r0, c17
                    dp4 r2.y, r0, c16
                    dp4 r2.x, r0, c15
                    mul r0.y, r2.w, r2.w
                    mad r0.w, r0.x, r0.x, -r0.y
                    dp4 r3.z, r1, c20
                    dp4 r3.y, r1, c19
                    dp4 r3.x, r1, c18
                    add r2.xyz, r2, r3
                    mul r3.xyz, r0.w, c21
                    mov r0.xyz, v1
                    mul r1.xyz, v2.zxyw, r0.yzxw
                    mov r0.xyz, v1
                    mad r0.xyz, v2.yzxw, r0.zxyw, -r1
                    mul r0.xyz, r0, v1.w
                    mov r1.xyz, c12
                    add o6.xyz, r2, r3
                    mov r1.w, c27.x
                    dp4 r0.w, v0, c3
                    dp4 r2.z, r1, c10
                    dp4 r2.x, r1, c8
                    dp4 r2.y, r1, c9
                    mad r2.xyz, r2, c22.w, -v0
                    dp3 o3.y, r2, r0
                    dp4 r0.z, v0, c2
                    dp4 r0.x, v0, c0
                    dp4 r0.y, v0, c1
                    mul r1.xyz, r0.xyww, c27.y
                    mul r1.y, r1, c13.x
                    dp3 o3.z, v2, r2
                    dp3 o3.x, r2, v1
                    mad o5.xy, r1.z, c14.zwzw, r1
                    mov o0, r0
                    mov o5.zw, r0
                    mad o1.zw, v3.xyxy, c25.xyxy, c25
                    mad o1.xy, v3, c24, c24.zwzw
                    mad o2.xy, v3, c26, c26.zwzw
                    dp3 o4.x, v2, c23
                    "
                }
                SubProgram "opengl " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    Bind "tangent" ATTR14
                    Matrix 9 [_Object2World]
                    Matrix 13 [_World2Object]
                    Vector 17 [_WorldSpaceCameraPos]
                    Vector 18 [_ProjectionParams]
                    Vector 19 [unity_ShadowFadeCenterAndType]
                    Vector 20 [unity_Scale]
                    Vector 21 [_localLightDirection]
                    Vector 22 [unity_LightmapST]
                    Vector 23 [_MainTex_ST]
                    Vector 24 [_BumpMap_ST]
                    Vector 25 [_ResourceMap_ST]
                    "3.0-!!ARBvp1.0
                    PARAM c[26] = { { 1, 0.5 },
                    state.matrix.modelview[0],
                    state.matrix.mvp,
                    program.local[9..25] };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    MOV R0.xyz, vertex.attrib[14];
                    MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
                    MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
                    MUL R0.xyz, R0, vertex.attrib[14].w;
                    MOV R1.xyz, c[17];
                    MOV R1.w, c[0].x;
                    DP4 R0.w, vertex.position, c[8];
                    DP4 R2.z, R1, c[15];
                    DP4 R2.x, R1, c[13];
                    DP4 R2.y, R1, c[14];
                    MAD R2.xyz, R2, c[20].w, -vertex.position;
                    DP3 result.texcoord[2].y, R2, R0;
                    DP4 R0.z, vertex.position, c[7];
                    DP4 R0.x, vertex.position, c[5];
                    DP4 R0.y, vertex.position, c[6];
                    MUL R1.xyz, R0.xyww, c[0].y;
                    MUL R1.y, R1, c[18].x;
                    ADD result.texcoord[4].xy, R1, R1.z;
                    MOV result.position, R0;
                    MOV R0.x, c[0];
                    ADD R0.y, R0.x, -c[19].w;
                    DP4 R0.x, vertex.position, c[3];
                    DP4 R1.z, vertex.position, c[11];
                    DP4 R1.x, vertex.position, c[9];
                    DP4 R1.y, vertex.position, c[10];
                    ADD R1.xyz, R1, -c[19];
                    DP3 result.texcoord[2].z, vertex.normal, R2;
                    DP3 result.texcoord[2].x, R2, vertex.attrib[14];
                    MOV result.texcoord[4].zw, R0;
                    MUL result.texcoord[6].xyz, R1, c[19].w;
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[24].xyxy, c[24];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
                    MAD result.texcoord[1].xy, vertex.texcoord[0], c[25], c[25].zwzw;
                    MAD result.texcoord[5].xy, vertex.texcoord[1], c[22], c[22].zwzw;
                    MUL result.texcoord[6].w, -R0.x, R0.y;
                    DP3 result.texcoord[3].x, vertex.normal, c[21];
                    END
# 36 instructions, 3 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    Bind "tangent" TexCoord2
                    Matrix 0 [glstate_matrix_modelview0]
                    Matrix 4 [glstate_matrix_mvp]
                    Matrix 8 [_Object2World]
                    Matrix 12 [_World2Object]
                    Vector 16 [_WorldSpaceCameraPos]
                    Vector 17 [_ProjectionParams]
                    Vector 18 [_ScreenParams]
                    Vector 19 [unity_ShadowFadeCenterAndType]
                    Vector 20 [unity_Scale]
                    Vector 21 [_localLightDirection]
                    Vector 22 [unity_LightmapST]
                    Vector 23 [_MainTex_ST]
                    Vector 24 [_BumpMap_ST]
                    Vector 25 [_ResourceMap_ST]
                    "vs_3_0
                    dcl_position o0
                    dcl_texcoord0 o1
                    dcl_texcoord1 o2
                    dcl_texcoord2 o3
                    dcl_texcoord3 o4
                    dcl_texcoord4 o5
                    dcl_texcoord5 o6
                    dcl_texcoord6 o7
                    def c26, 1.00000000, 0.50000000, 0, 0
                    dcl_position0 v0
                    dcl_tangent0 v1
                    dcl_normal0 v2
                    dcl_texcoord0 v3
                    dcl_texcoord1 v4
                    mov r0.xyz, v1
                    mul r1.xyz, v2.zxyw, r0.yzxw
                    mov r0.xyz, v1
                    mad r0.xyz, v2.yzxw, r0.zxyw, -r1
                    mul r0.xyz, r0, v1.w
                    mov r1.xyz, c16
                    mov r1.w, c26.x
                    dp4 r0.w, v0, c7
                    dp4 r2.z, r1, c14
                    dp4 r2.x, r1, c12
                    dp4 r2.y, r1, c13
                    mad r2.xyz, r2, c20.w, -v0
                    dp3 o3.y, r2, r0
                    dp4 r0.z, v0, c6
                    dp4 r0.x, v0, c4
                    dp4 r0.y, v0, c5
                    mul r1.xyz, r0.xyww, c26.y
                    mul r1.y, r1, c17.x
                    mad o5.xy, r1.z, c18.zwzw, r1
                    mov o0, r0
                    mov r0.x, c19.w
                    add r0.y, c26.x, -r0.x
                    dp4 r0.x, v0, c2
                    dp4 r1.z, v0, c10
                    dp4 r1.x, v0, c8
                    dp4 r1.y, v0, c9
                    add r1.xyz, r1, -c19
                    dp3 o3.z, v2, r2
                    dp3 o3.x, r2, v1
                    mov o5.zw, r0
                    mul o7.xyz, r1, c19.w
                    mad o1.zw, v3.xyxy, c24.xyxy, c24
                    mad o1.xy, v3, c23, c23.zwzw
                    mad o2.xy, v3, c25, c25.zwzw
                    mad o6.xy, v4, c22, c22.zwzw
                    mul o7.w, -r0.x, r0.y
                    dp3 o4.x, v2, c21
                    "
                }
                SubProgram "opengl " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    Bind "tangent" ATTR14
                    Matrix 5 [_World2Object]
                    Vector 9 [_WorldSpaceCameraPos]
                    Vector 10 [_ProjectionParams]
                    Vector 11 [unity_Scale]
                    Vector 12 [_localLightDirection]
                    Vector 13 [unity_LightmapST]
                    Vector 14 [_MainTex_ST]
                    Vector 15 [_BumpMap_ST]
                    Vector 16 [_ResourceMap_ST]
                    "3.0-!!ARBvp1.0
                    PARAM c[17] = { { 1, 0.5 },
                    state.matrix.mvp,
                    program.local[5..16] };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    MOV R0.xyz, vertex.attrib[14];
                    MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
                    MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
                    MUL R0.xyz, R0, vertex.attrib[14].w;
                    MOV R1.xyz, c[9];
                    MOV R1.w, c[0].x;
                    DP4 R0.w, vertex.position, c[4];
                    DP4 R2.z, R1, c[7];
                    DP4 R2.x, R1, c[5];
                    DP4 R2.y, R1, c[6];
                    MAD R2.xyz, R2, c[11].w, -vertex.position;
                    DP3 result.texcoord[2].y, R2, R0;
                    DP4 R0.z, vertex.position, c[3];
                    DP4 R0.x, vertex.position, c[1];
                    DP4 R0.y, vertex.position, c[2];
                    MUL R1.xyz, R0.xyww, c[0].y;
                    MUL R1.y, R1, c[10].x;
                    DP3 result.texcoord[2].z, vertex.normal, R2;
                    DP3 result.texcoord[2].x, R2, vertex.attrib[14];
                    ADD result.texcoord[4].xy, R1, R1.z;
                    MOV result.position, R0;
                    MOV result.texcoord[4].zw, R0;
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[15].xyxy, c[15];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[14], c[14].zwzw;
                    MAD result.texcoord[1].xy, vertex.texcoord[0], c[16], c[16].zwzw;
                    MAD result.texcoord[5].xy, vertex.texcoord[1], c[13], c[13].zwzw;
                    DP3 result.texcoord[3].x, vertex.normal, c[12];
                    END
# 27 instructions, 3 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    Bind "tangent" TexCoord2
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 4 [_World2Object]
                    Vector 8 [_WorldSpaceCameraPos]
                    Vector 9 [_ProjectionParams]
                    Vector 10 [_ScreenParams]
                    Vector 11 [unity_Scale]
                    Vector 12 [_localLightDirection]
                    Vector 13 [unity_LightmapST]
                    Vector 14 [_MainTex_ST]
                    Vector 15 [_BumpMap_ST]
                    Vector 16 [_ResourceMap_ST]
                    "vs_3_0
                    dcl_position o0
                    dcl_texcoord0 o1
                    dcl_texcoord1 o2
                    dcl_texcoord2 o3
                    dcl_texcoord3 o4
                    dcl_texcoord4 o5
                    dcl_texcoord5 o6
                    def c17, 1.00000000, 0.50000000, 0, 0
                    dcl_position0 v0
                    dcl_tangent0 v1
                    dcl_normal0 v2
                    dcl_texcoord0 v3
                    dcl_texcoord1 v4
                    mov r0.xyz, v1
                    mul r1.xyz, v2.zxyw, r0.yzxw
                    mov r0.xyz, v1
                    mad r0.xyz, v2.yzxw, r0.zxyw, -r1
                    mul r0.xyz, r0, v1.w
                    mov r1.xyz, c8
                    mov r1.w, c17.x
                    dp4 r0.w, v0, c3
                    dp4 r2.z, r1, c6
                    dp4 r2.x, r1, c4
                    dp4 r2.y, r1, c5
                    mad r2.xyz, r2, c11.w, -v0
                    dp3 o3.y, r2, r0
                    dp4 r0.z, v0, c2
                    dp4 r0.x, v0, c0
                    dp4 r0.y, v0, c1
                    mul r1.xyz, r0.xyww, c17.y
                    mul r1.y, r1, c9.x
                    dp3 o3.z, v2, r2
                    dp3 o3.x, r2, v1
                    mad o5.xy, r1.z, c10.zwzw, r1
                    mov o0, r0
                    mov o5.zw, r0
                    mad o1.zw, v3.xyxy, c15.xyxy, c15
                    mad o1.xy, v3, c14, c14.zwzw
                    mad o2.xy, v3, c16, c16.zwzw
                    mad o6.xy, v4, c13, c13.zwzw
                    dp3 o4.x, v2, c12
                    "
                }
                SubProgram "opengl " {
                    Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" ATTR14
                    Matrix 5 [_Object2World]
                    Matrix 9 [_World2Object]
                    Vector 13 [_WorldSpaceCameraPos]
                    Vector 14 [_ProjectionParams]
                    Vector 15 [unity_SHAr]
                    Vector 16 [unity_SHAg]
                    Vector 17 [unity_SHAb]
                    Vector 18 [unity_SHBr]
                    Vector 19 [unity_SHBg]
                    Vector 20 [unity_SHBb]
                    Vector 21 [unity_SHC]
                    Vector 22 [unity_Scale]
                    Vector 23 [_localLightDirection]
                    Vector 24 [_MainTex_ST]
                    Vector 25 [_BumpMap_ST]
                    Vector 26 [_ResourceMap_ST]
                    "3.0-!!ARBvp1.0
                    PARAM c[27] = { { 1, 0.5 },
                    state.matrix.mvp,
                    program.local[5..26] };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    MUL R1.xyz, vertex.normal, c[22].w;
                    DP3 R2.w, R1, c[6];
                    DP3 R0.x, R1, c[5];
                    DP3 R0.z, R1, c[7];
                    MOV R0.y, R2.w;
                    MUL R1, R0.xyzz, R0.yzzx;
                    MOV R0.w, c[0].x;
                    DP4 R2.z, R0, c[17];
                    DP4 R2.y, R0, c[16];
                    DP4 R2.x, R0, c[15];
                    MUL R0.y, R2.w, R2.w;
                    DP4 R3.z, R1, c[20];
                    DP4 R3.x, R1, c[18];
                    DP4 R3.y, R1, c[19];
                    ADD R2.xyz, R2, R3;
                    MAD R0.w, R0.x, R0.x, -R0.y;
                    MUL R3.xyz, R0.w, c[21];
                    MOV R1.xyz, vertex.attrib[14];
                    MUL R0.xyz, vertex.normal.zxyw, R1.yzxw;
                    MAD R0.xyz, vertex.normal.yzxw, R1.zxyw, -R0;
                    MUL R0.xyz, R0, vertex.attrib[14].w;
                    MOV R1.xyz, c[13];
                    ADD result.texcoord[5].xyz, R2, R3;
                    MOV R1.w, c[0].x;
                    DP4 R0.w, vertex.position, c[4];
                    DP4 R2.z, R1, c[11];
                    DP4 R2.x, R1, c[9];
                    DP4 R2.y, R1, c[10];
                    MAD R2.xyz, R2, c[22].w, -vertex.position;
                    DP3 result.texcoord[2].y, R2, R0;
                    DP4 R0.z, vertex.position, c[3];
                    DP4 R0.x, vertex.position, c[1];
                    DP4 R0.y, vertex.position, c[2];
                    MUL R1.xyz, R0.xyww, c[0].y;
                    MUL R1.y, R1, c[14].x;
                    DP3 result.texcoord[2].z, vertex.normal, R2;
                    DP3 result.texcoord[2].x, R2, vertex.attrib[14];
                    ADD result.texcoord[4].xy, R1, R1.z;
                    MOV result.position, R0;
                    MOV result.texcoord[4].zw, R0;
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[25].xyxy, c[25];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[24], c[24].zwzw;
                    MAD result.texcoord[1].xy, vertex.texcoord[0], c[26], c[26].zwzw;
                    DP3 result.texcoord[3].x, vertex.normal, c[23];
                    END
# 44 instructions, 4 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" TexCoord2
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 4 [_Object2World]
                    Matrix 8 [_World2Object]
                    Vector 12 [_WorldSpaceCameraPos]
                    Vector 13 [_ProjectionParams]
                    Vector 14 [_ScreenParams]
                    Vector 15 [unity_SHAr]
                    Vector 16 [unity_SHAg]
                    Vector 17 [unity_SHAb]
                    Vector 18 [unity_SHBr]
                    Vector 19 [unity_SHBg]
                    Vector 20 [unity_SHBb]
                    Vector 21 [unity_SHC]
                    Vector 22 [unity_Scale]
                    Vector 23 [_localLightDirection]
                    Vector 24 [_MainTex_ST]
                    Vector 25 [_BumpMap_ST]
                    Vector 26 [_ResourceMap_ST]
                    "vs_3_0
                    dcl_position o0
                    dcl_texcoord0 o1
                    dcl_texcoord1 o2
                    dcl_texcoord2 o3
                    dcl_texcoord3 o4
                    dcl_texcoord4 o5
                    dcl_texcoord5 o6
                    def c27, 1.00000000, 0.50000000, 0, 0
                    dcl_position0 v0
                    dcl_tangent0 v1
                    dcl_normal0 v2
                    dcl_texcoord0 v3
                    mul r1.xyz, v2, c22.w
                    dp3 r2.w, r1, c5
                    dp3 r0.x, r1, c4
                    dp3 r0.z, r1, c6
                    mov r0.y, r2.w
                    mul r1, r0.xyzz, r0.yzzx
                    mov r0.w, c27.x
                    dp4 r2.z, r0, c17
                    dp4 r2.y, r0, c16
                    dp4 r2.x, r0, c15
                    mul r0.y, r2.w, r2.w
                    mad r0.w, r0.x, r0.x, -r0.y
                    dp4 r3.z, r1, c20
                    dp4 r3.y, r1, c19
                    dp4 r3.x, r1, c18
                    add r2.xyz, r2, r3
                    mul r3.xyz, r0.w, c21
                    mov r0.xyz, v1
                    mul r1.xyz, v2.zxyw, r0.yzxw
                    mov r0.xyz, v1
                    mad r0.xyz, v2.yzxw, r0.zxyw, -r1
                    mul r0.xyz, r0, v1.w
                    mov r1.xyz, c12
                    add o6.xyz, r2, r3
                    mov r1.w, c27.x
                    dp4 r0.w, v0, c3
                    dp4 r2.z, r1, c10
                    dp4 r2.x, r1, c8
                    dp4 r2.y, r1, c9
                    mad r2.xyz, r2, c22.w, -v0
                    dp3 o3.y, r2, r0
                    dp4 r0.z, v0, c2
                    dp4 r0.x, v0, c0
                    dp4 r0.y, v0, c1
                    mul r1.xyz, r0.xyww, c27.y
                    mul r1.y, r1, c13.x
                    dp3 o3.z, v2, r2
                    dp3 o3.x, r2, v1
                    mad o5.xy, r1.z, c14.zwzw, r1
                    mov o0, r0
                    mov o5.zw, r0
                    mad o1.zw, v3.xyxy, c25.xyxy, c25
                    mad o1.xy, v3, c24, c24.zwzw
                    mad o2.xy, v3, c26, c26.zwzw
                    dp3 o4.x, v2, c23
                    "
                }
                SubProgram "opengl " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    Bind "tangent" ATTR14
                    Matrix 9 [_Object2World]
                    Matrix 13 [_World2Object]
                    Vector 17 [_WorldSpaceCameraPos]
                    Vector 18 [_ProjectionParams]
                    Vector 19 [unity_ShadowFadeCenterAndType]
                    Vector 20 [unity_Scale]
                    Vector 21 [_localLightDirection]
                    Vector 22 [unity_LightmapST]
                    Vector 23 [_MainTex_ST]
                    Vector 24 [_BumpMap_ST]
                    Vector 25 [_ResourceMap_ST]
                    "3.0-!!ARBvp1.0
                    PARAM c[26] = { { 1, 0.5 },
                    state.matrix.modelview[0],
                    state.matrix.mvp,
                    program.local[9..25] };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    MOV R0.xyz, vertex.attrib[14];
                    MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
                    MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
                    MUL R0.xyz, R0, vertex.attrib[14].w;
                    MOV R1.xyz, c[17];
                    MOV R1.w, c[0].x;
                    DP4 R0.w, vertex.position, c[8];
                    DP4 R2.z, R1, c[15];
                    DP4 R2.x, R1, c[13];
                    DP4 R2.y, R1, c[14];
                    MAD R2.xyz, R2, c[20].w, -vertex.position;
                    DP3 result.texcoord[2].y, R2, R0;
                    DP4 R0.z, vertex.position, c[7];
                    DP4 R0.x, vertex.position, c[5];
                    DP4 R0.y, vertex.position, c[6];
                    MUL R1.xyz, R0.xyww, c[0].y;
                    MUL R1.y, R1, c[18].x;
                    ADD result.texcoord[4].xy, R1, R1.z;
                    MOV result.position, R0;
                    MOV R0.x, c[0];
                    ADD R0.y, R0.x, -c[19].w;
                    DP4 R0.x, vertex.position, c[3];
                    DP4 R1.z, vertex.position, c[11];
                    DP4 R1.x, vertex.position, c[9];
                    DP4 R1.y, vertex.position, c[10];
                    ADD R1.xyz, R1, -c[19];
                    DP3 result.texcoord[2].z, vertex.normal, R2;
                    DP3 result.texcoord[2].x, R2, vertex.attrib[14];
                    MOV result.texcoord[4].zw, R0;
                    MUL result.texcoord[6].xyz, R1, c[19].w;
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[24].xyxy, c[24];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
                    MAD result.texcoord[1].xy, vertex.texcoord[0], c[25], c[25].zwzw;
                    MAD result.texcoord[5].xy, vertex.texcoord[1], c[22], c[22].zwzw;
                    MUL result.texcoord[6].w, -R0.x, R0.y;
                    DP3 result.texcoord[3].x, vertex.normal, c[21];
                    END
# 36 instructions, 3 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    Bind "tangent" TexCoord2
                    Matrix 0 [glstate_matrix_modelview0]
                    Matrix 4 [glstate_matrix_mvp]
                    Matrix 8 [_Object2World]
                    Matrix 12 [_World2Object]
                    Vector 16 [_WorldSpaceCameraPos]
                    Vector 17 [_ProjectionParams]
                    Vector 18 [_ScreenParams]
                    Vector 19 [unity_ShadowFadeCenterAndType]
                    Vector 20 [unity_Scale]
                    Vector 21 [_localLightDirection]
                    Vector 22 [unity_LightmapST]
                    Vector 23 [_MainTex_ST]
                    Vector 24 [_BumpMap_ST]
                    Vector 25 [_ResourceMap_ST]
                    "vs_3_0
                    dcl_position o0
                    dcl_texcoord0 o1
                    dcl_texcoord1 o2
                    dcl_texcoord2 o3
                    dcl_texcoord3 o4
                    dcl_texcoord4 o5
                    dcl_texcoord5 o6
                    dcl_texcoord6 o7
                    def c26, 1.00000000, 0.50000000, 0, 0
                    dcl_position0 v0
                    dcl_tangent0 v1
                    dcl_normal0 v2
                    dcl_texcoord0 v3
                    dcl_texcoord1 v4
                    mov r0.xyz, v1
                    mul r1.xyz, v2.zxyw, r0.yzxw
                    mov r0.xyz, v1
                    mad r0.xyz, v2.yzxw, r0.zxyw, -r1
                    mul r0.xyz, r0, v1.w
                    mov r1.xyz, c16
                    mov r1.w, c26.x
                    dp4 r0.w, v0, c7
                    dp4 r2.z, r1, c14
                    dp4 r2.x, r1, c12
                    dp4 r2.y, r1, c13
                    mad r2.xyz, r2, c20.w, -v0
                    dp3 o3.y, r2, r0
                    dp4 r0.z, v0, c6
                    dp4 r0.x, v0, c4
                    dp4 r0.y, v0, c5
                    mul r1.xyz, r0.xyww, c26.y
                    mul r1.y, r1, c17.x
                    mad o5.xy, r1.z, c18.zwzw, r1
                    mov o0, r0
                    mov r0.x, c19.w
                    add r0.y, c26.x, -r0.x
                    dp4 r0.x, v0, c2
                    dp4 r1.z, v0, c10
                    dp4 r1.x, v0, c8
                    dp4 r1.y, v0, c9
                    add r1.xyz, r1, -c19
                    dp3 o3.z, v2, r2
                    dp3 o3.x, r2, v1
                    mov o5.zw, r0
                    mul o7.xyz, r1, c19.w
                    mad o1.zw, v3.xyxy, c24.xyxy, c24
                    mad o1.xy, v3, c23, c23.zwzw
                    mad o2.xy, v3, c25, c25.zwzw
                    mad o6.xy, v4, c22, c22.zwzw
                    mul o7.w, -r0.x, r0.y
                    dp3 o4.x, v2, c21
                    "
                }
                SubProgram "opengl " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    Bind "tangent" ATTR14
                    Matrix 5 [_World2Object]
                    Vector 9 [_WorldSpaceCameraPos]
                    Vector 10 [_ProjectionParams]
                    Vector 11 [unity_Scale]
                    Vector 12 [_localLightDirection]
                    Vector 13 [unity_LightmapST]
                    Vector 14 [_MainTex_ST]
                    Vector 15 [_BumpMap_ST]
                    Vector 16 [_ResourceMap_ST]
                    "3.0-!!ARBvp1.0
                    PARAM c[17] = { { 1, 0.5 },
                    state.matrix.mvp,
                    program.local[5..16] };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    MOV R0.xyz, vertex.attrib[14];
                    MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
                    MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
                    MUL R0.xyz, R0, vertex.attrib[14].w;
                    MOV R1.xyz, c[9];
                    MOV R1.w, c[0].x;
                    DP4 R0.w, vertex.position, c[4];
                    DP4 R2.z, R1, c[7];
                    DP4 R2.x, R1, c[5];
                    DP4 R2.y, R1, c[6];
                    MAD R2.xyz, R2, c[11].w, -vertex.position;
                    DP3 result.texcoord[2].y, R2, R0;
                    DP4 R0.z, vertex.position, c[3];
                    DP4 R0.x, vertex.position, c[1];
                    DP4 R0.y, vertex.position, c[2];
                    MUL R1.xyz, R0.xyww, c[0].y;
                    MUL R1.y, R1, c[10].x;
                    DP3 result.texcoord[2].z, vertex.normal, R2;
                    DP3 result.texcoord[2].x, R2, vertex.attrib[14];
                    ADD result.texcoord[4].xy, R1, R1.z;
                    MOV result.position, R0;
                    MOV result.texcoord[4].zw, R0;
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[15].xyxy, c[15];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[14], c[14].zwzw;
                    MAD result.texcoord[1].xy, vertex.texcoord[0], c[16], c[16].zwzw;
                    MAD result.texcoord[5].xy, vertex.texcoord[1], c[13], c[13].zwzw;
                    DP3 result.texcoord[3].x, vertex.normal, c[12];
                    END
# 27 instructions, 3 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    Bind "tangent" TexCoord2
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 4 [_World2Object]
                    Vector 8 [_WorldSpaceCameraPos]
                    Vector 9 [_ProjectionParams]
                    Vector 10 [_ScreenParams]
                    Vector 11 [unity_Scale]
                    Vector 12 [_localLightDirection]
                    Vector 13 [unity_LightmapST]
                    Vector 14 [_MainTex_ST]
                    Vector 15 [_BumpMap_ST]
                    Vector 16 [_ResourceMap_ST]
                    "vs_3_0
                    dcl_position o0
                    dcl_texcoord0 o1
                    dcl_texcoord1 o2
                    dcl_texcoord2 o3
                    dcl_texcoord3 o4
                    dcl_texcoord4 o5
                    dcl_texcoord5 o6
                    def c17, 1.00000000, 0.50000000, 0, 0
                    dcl_position0 v0
                    dcl_tangent0 v1
                    dcl_normal0 v2
                    dcl_texcoord0 v3
                    dcl_texcoord1 v4
                    mov r0.xyz, v1
                    mul r1.xyz, v2.zxyw, r0.yzxw
                    mov r0.xyz, v1
                    mad r0.xyz, v2.yzxw, r0.zxyw, -r1
                    mul r0.xyz, r0, v1.w
                    mov r1.xyz, c8
                    mov r1.w, c17.x
                    dp4 r0.w, v0, c3
                    dp4 r2.z, r1, c6
                    dp4 r2.x, r1, c4
                    dp4 r2.y, r1, c5
                    mad r2.xyz, r2, c11.w, -v0
                    dp3 o3.y, r2, r0
                    dp4 r0.z, v0, c2
                    dp4 r0.x, v0, c0
                    dp4 r0.y, v0, c1
                    mul r1.xyz, r0.xyww, c17.y
                    mul r1.y, r1, c9.x
                    dp3 o3.z, v2, r2
                    dp3 o3.x, r2, v1
                    mad o5.xy, r1.z, c10.zwzw, r1
                    mov o0, r0
                    mov o5.zw, r0
                    mad o1.zw, v3.xyxy, c15.xyxy, c15
                    mad o1.xy, v3, c14, c14.zwzw
                    mad o2.xy, v3, c16, c16.zwzw
                    mad o6.xy, v4, c13, c13.zwzw
                    dp3 o4.x, v2, c12
                    "
                }
            }
            Program "fp" {
// Platform d3d11 had shader errors
//   Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
//   Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
//   Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
//   Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
//   Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
//   Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
                SubProgram "opengl " {
                    Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
                    Vector 0 [_SpecColor]
                    Vector 1 [_Color]
                    Float 2 [_Opacity]
                    Float 3 [_rimPower]
                    Float 4 [_rimBlend]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 2 [_rimColorRamp] 2D 2
                    SetTexture 3 [_ResourceMap] 2D 3
                    SetTexture 4 [_LightBuffer] 2D 4
                    "3.0-!!ARBfp1.0
                    PARAM c[6] = { program.local[0..4],
                    { 0.5, 1 } };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    TXP R0, fragment.texcoord[4], texture[4], 2D;
                    LG2 R1.w, R0.w;
                    LG2 R0.x, R0.x;
                    LG2 R0.z, R0.z;
                    LG2 R0.y, R0.y;
                    ADD R1.xyz, -R0, fragment.texcoord[5];
                    TEX R0, fragment.texcoord[0], texture[0], 2D;
                    MUL R0.xyz, R0, c[1];
                    MUL R2.w, R0, -R1;
                    MUL R2.xyz, R1, c[0];
                    MUL R2.xyz, R2, R2.w;
                    MAD R2.xyz, R0, R1, R2;
                    DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
                    RSQ R0.x, R0.x;
                    MUL_SAT R0.x, R0, fragment.texcoord[2].z;
                    ADD R3.x, -R0, c[5].y;
                    ADD R0.y, -R0.w, c[5];
                    TEX R1, fragment.texcoord[1], texture[3], 2D;
                    MUL R1, R1, R0.y;
                    ADD R0.w, -R1, c[5].y;
                    MOV R0.y, c[5].x;
                    MOV R0.x, fragment.texcoord[3];
                    TEX R0.xyz, R0, texture[2], 2D;
                    POW R3.x, R3.x, c[3].x;
                    MUL R0.xyz, R0, c[4].x;
                    MUL R0.xyz, R0, R3.x;
                    MUL R0.xyz, R0, c[2].x;
                    MUL R1.xyz, R1, R1.w;
                    MAD R1.xyz, R0, R0.w, R1;
                    MOV R0.x, c[2];
                    ADD result.color.xyz, R2, R1;
                    MAD result.color.w, R2, c[0], R0.x;
                    END
# 32 instructions, 4 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
                    Vector 0 [_SpecColor]
                    Vector 1 [_Color]
                    Float 2 [_Opacity]
                    Float 3 [_rimPower]
                    Float 4 [_rimBlend]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 2 [_rimColorRamp] 2D 2
                    SetTexture 3 [_ResourceMap] 2D 3
                    SetTexture 4 [_LightBuffer] 2D 4
                    "ps_3_0
                    dcl_2d s0
                    dcl_2d s2
                    dcl_2d s3
                    dcl_2d s4
                    def c5, 1.00000000, 0.50000000, 0, 0
                    dcl_texcoord0 v0.xy
                    dcl_texcoord1 v1.xy
                    dcl_texcoord2 v2.xyz
                    dcl_texcoord3 v3.x
                    dcl_texcoord4 v4
                    dcl_texcoord5 v5.xyz
                    texldp r0, v4, s4
                    log_pp r1.w, r0.w
                    log_pp r0.x, r0.x
                    log_pp r0.z, r0.z
                    log_pp r0.y, r0.y
                    add_pp r1.xyz, -r0, v5
                    texld r0, v0, s0
                    mul_pp r2.w, r0, -r1
                    mul_pp r2.xyz, r1, c0
                    mul_pp r0.xyz, r0, c1
                    mul_pp r2.xyz, r2, r2.w
                    mad_pp r2.xyz, r0, r1, r2
                    dp3 r1.w, v2, v2
                    rsq r0.x, r1.w
                    mul_sat r0.x, r0, v2.z
                    add r3.x, -r0, c5
                    add r0.y, -r0.w, c5.x
                    texld r1, v1, s3
                    mul r1, r1, r0.y
                    pow_pp r0, r3.x, c3.x
                    add r0.w, -r1, c5.x
                    mov_pp r3.w, r0.x
                    mov r3.y, c5
                    mov r3.x, v3
                    texld r3.xyz, r3, s2
                    mul r0.xyz, r3, c4.x
                    mul r0.xyz, r0, r3.w
                    mul r0.xyz, r0, c2.x
                    mul r1.xyz, r1, r1.w
                    mad r1.xyz, r0, r0.w, r1
                    mov_pp r0.x, c2
                    add_pp oC0.xyz, r2, r1
                    mad_pp oC0.w, r2, c0, r0.x
                    "
                }
                SubProgram "opengl " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
                    Vector 0 [_SpecColor]
                    Vector 1 [_Color]
                    Float 2 [_Opacity]
                    Float 3 [_rimPower]
                    Float 4 [_rimBlend]
                    Vector 5 [unity_LightmapFade]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 2 [_rimColorRamp] 2D 2
                    SetTexture 3 [_ResourceMap] 2D 3
                    SetTexture 4 [_LightBuffer] 2D 4
                    SetTexture 5 [unity_Lightmap] 2D 5
                    SetTexture 6 [unity_LightmapInd] 2D 6
                    "3.0-!!ARBfp1.0
                    PARAM c[7] = { program.local[0..5],
                    { 8, 0.5, 1 } };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    TEX R0, fragment.texcoord[5], texture[5], 2D;
                    MUL R0.xyz, R0.w, R0;
                    TEX R1, fragment.texcoord[5], texture[6], 2D;
                    MUL R1.xyz, R1.w, R1;
                    MUL R1.xyz, R1, c[6].x;
                    DP4 R0.w, fragment.texcoord[6], fragment.texcoord[6];
                    RSQ R0.w, R0.w;
                    RCP R1.w, R0.w;
                    MAD R2.xyz, R0, c[6].x, -R1;
                    TXP R0, fragment.texcoord[4], texture[4], 2D;
                    MAD_SAT R1.w, R1, c[5].z, c[5];
                    MAD R1.xyz, R1.w, R2, R1;
                    LG2 R1.w, R0.w;
                    LG2 R0.x, R0.x;
                    LG2 R0.y, R0.y;
                    LG2 R0.z, R0.z;
                    ADD R1.xyz, -R0, R1;
                    TEX R0, fragment.texcoord[0], texture[0], 2D;
                    MUL R0.xyz, R0, c[1];
                    MUL R2.w, R0, -R1;
                    MUL R2.xyz, R1, c[0];
                    MUL R2.xyz, R2, R2.w;
                    MAD R2.xyz, R0, R1, R2;
                    DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
                    RSQ R0.x, R0.x;
                    MUL_SAT R0.x, R0, fragment.texcoord[2].z;
                    ADD R3.x, -R0, c[6].z;
                    ADD R0.y, -R0.w, c[6].z;
                    TEX R1, fragment.texcoord[1], texture[3], 2D;
                    MUL R1, R1, R0.y;
                    ADD R0.w, -R1, c[6].z;
                    MOV R0.y, c[6];
                    MOV R0.x, fragment.texcoord[3];
                    TEX R0.xyz, R0, texture[2], 2D;
                    POW R3.x, R3.x, c[3].x;
                    MUL R0.xyz, R0, c[4].x;
                    MUL R0.xyz, R0, R3.x;
                    MUL R0.xyz, R0, c[2].x;
                    MUL R1.xyz, R1, R1.w;
                    MAD R1.xyz, R0, R0.w, R1;
                    MOV R0.x, c[2];
                    ADD result.color.xyz, R2, R1;
                    MAD result.color.w, R2, c[0], R0.x;
                    END
# 43 instructions, 4 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
                    Vector 0 [_SpecColor]
                    Vector 1 [_Color]
                    Float 2 [_Opacity]
                    Float 3 [_rimPower]
                    Float 4 [_rimBlend]
                    Vector 5 [unity_LightmapFade]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 2 [_rimColorRamp] 2D 2
                    SetTexture 3 [_ResourceMap] 2D 3
                    SetTexture 4 [_LightBuffer] 2D 4
                    SetTexture 5 [unity_Lightmap] 2D 5
                    SetTexture 6 [unity_LightmapInd] 2D 6
                    "ps_3_0
                    dcl_2d s0
                    dcl_2d s2
                    dcl_2d s3
                    dcl_2d s4
                    dcl_2d s5
                    dcl_2d s6
                    def c6, 1.00000000, 0.50000000, 8.00000000, 0
                    dcl_texcoord0 v0.xy
                    dcl_texcoord1 v1.xy
                    dcl_texcoord2 v2.xyz
                    dcl_texcoord3 v3.x
                    dcl_texcoord4 v4
                    dcl_texcoord5 v5.xy
                    dcl_texcoord6 v6
                    texld r0, v5, s5
                    mul_pp r0.xyz, r0.w, r0
                    texld r1, v5, s6
                    mul_pp r1.xyz, r1.w, r1
                    mul_pp r1.xyz, r1, c6.z
                    dp4 r0.w, v6, v6
                    rsq r0.w, r0.w
                    rcp r1.w, r0.w
                    mad_pp r2.xyz, r0, c6.z, -r1
                    texldp r0, v4, s4
                    mad_sat r1.w, r1, c5.z, c5
                    mad_pp r1.xyz, r1.w, r2, r1
                    log_pp r1.w, r0.w
                    log_pp r0.x, r0.x
                    log_pp r0.y, r0.y
                    log_pp r0.z, r0.z
                    add_pp r1.xyz, -r0, r1
                    texld r0, v0, s0
                    mul_pp r2.w, r0, -r1
                    mul_pp r2.xyz, r1, c0
                    mul_pp r0.xyz, r0, c1
                    mul_pp r2.xyz, r2, r2.w
                    mad_pp r2.xyz, r0, r1, r2
                    dp3 r1.w, v2, v2
                    rsq r0.x, r1.w
                    mul_sat r0.x, r0, v2.z
                    add r3.x, -r0, c6
                    add r0.y, -r0.w, c6.x
                    texld r1, v1, s3
                    mul r1, r1, r0.y
                    pow_pp r0, r3.x, c3.x
                    add r0.w, -r1, c6.x
                    mov_pp r3.w, r0.x
                    mov r3.y, c6
                    mov r3.x, v3
                    texld r3.xyz, r3, s2
                    mul r0.xyz, r3, c4.x
                    mul r0.xyz, r0, r3.w
                    mul r0.xyz, r0, c2.x
                    mul r1.xyz, r1, r1.w
                    mad r1.xyz, r0, r0.w, r1
                    mov_pp r0.x, c2
                    add_pp oC0.xyz, r2, r1
                    mad_pp oC0.w, r2, c0, r0.x
                    "
                }
                SubProgram "opengl " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
                    Vector 0 [_SpecColor]
                    Vector 1 [_Color]
                    Float 2 [_Shininess]
                    Float 3 [_Opacity]
                    Float 4 [_rimPower]
                    Float 5 [_rimBlend]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_rimColorRamp] 2D 2
                    SetTexture 3 [_ResourceMap] 2D 3
                    SetTexture 4 [_LightBuffer] 2D 4
                    SetTexture 5 [unity_Lightmap] 2D 5
                    SetTexture 6 [unity_LightmapInd] 2D 6
                    "3.0-!!ARBfp1.0
                    PARAM c[10] = { program.local[0..5],
                    { 2, 1, 8, 0 },
                    { -0.40824828, -0.70710677, 0.57735026, 128 },
                    { -0.40824831, 0.70710677, 0.57735026, 0.5 },
                    { 0.81649655, 0, 0.57735026 } };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    TEX R1.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
                    MAD R3.xy, R1.wyzw, c[6].x, -c[6].y;
                    TEX R0, fragment.texcoord[5], texture[6], 2D;
                    MUL R0.xyz, R0.w, R0;
                    MUL R2.xyz, R0, c[6].z;
                    MUL R0.xyz, R2.y, c[8];
                    MAD R0.xyz, R2.x, c[9], R0;
                    MAD R0.xyz, R2.z, c[7], R0;
                    DP3 R0.w, R0, R0;
                    RSQ R0.w, R0.w;
                    MUL R0.xyz, R0.w, R0;
                    DP3 R0.w, fragment.texcoord[2], fragment.texcoord[2];
                    RSQ R0.w, R0.w;
                    MUL R1.xy, R3, R3;
                    MAD R0.xyz, R0.w, fragment.texcoord[2], R0;
                    ADD_SAT R0.w, R1.x, R1.y;
                    DP3 R1.x, R0, R0;
                    RSQ R1.x, R1.x;
                    ADD R0.w, -R0, c[6].y;
                    RSQ R0.w, R0.w;
                    RCP R3.z, R0.w;
                    MUL R0.xyz, R1.x, R0;
                    DP3 R0.x, R3, R0;
                    MOV R0.w, c[7];
                    DP3_SAT R1.z, R3, c[7];
                    DP3_SAT R1.y, R3, c[8];
                    DP3_SAT R1.x, R3, c[9];
                    DP3 R1.x, R1, R2;
                    MUL R0.y, R0.w, c[2].x;
                    MAX R0.x, R0, c[6].w;
                    POW R1.w, R0.x, R0.y;
                    TEX R0, fragment.texcoord[5], texture[5], 2D;
                    MUL R0.xyz, R0.w, R0;
                    MUL R1.xyz, R0, R1.x;
                    TXP R0, fragment.texcoord[4], texture[4], 2D;
                    LG2 R0.x, R0.x;
                    LG2 R0.y, R0.y;
                    LG2 R0.z, R0.z;
                    LG2 R0.w, R0.w;
                    MUL R1.xyz, R1, c[6].z;
                    ADD R1, -R0, R1;
                    TEX R0, fragment.texcoord[0], texture[0], 2D;
                    MUL R0.xyz, R0, c[1];
                    MUL R2.w, R0, R1;
                    MUL R2.xyz, R1, c[0];
                    MUL R2.xyz, R2, R2.w;
                    MAD R2.xyz, R0, R1, R2;
                    DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
                    RSQ R0.x, R0.x;
                    MUL_SAT R0.x, R0, fragment.texcoord[2].z;
                    ADD R3.x, -R0, c[6].y;
                    ADD R0.y, -R0.w, c[6];
                    TEX R1, fragment.texcoord[1], texture[3], 2D;
                    MUL R1, R1, R0.y;
                    ADD R0.w, -R1, c[6].y;
                    MOV R0.y, c[8].w;
                    MOV R0.x, fragment.texcoord[3];
                    TEX R0.xyz, R0, texture[2], 2D;
                    POW R3.x, R3.x, c[4].x;
                    MUL R0.xyz, R0, c[5].x;
                    MUL R0.xyz, R0, R3.x;
                    MUL R0.xyz, R0, c[3].x;
                    MUL R1.xyz, R1, R1.w;
                    MAD R1.xyz, R0, R0.w, R1;
                    MOV R0.x, c[3];
                    ADD result.color.xyz, R2, R1;
                    MAD result.color.w, R2, c[0], R0.x;
                    END
# 67 instructions, 4 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
                    Vector 0 [_SpecColor]
                    Vector 1 [_Color]
                    Float 2 [_Shininess]
                    Float 3 [_Opacity]
                    Float 4 [_rimPower]
                    Float 5 [_rimBlend]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_rimColorRamp] 2D 2
                    SetTexture 3 [_ResourceMap] 2D 3
                    SetTexture 4 [_LightBuffer] 2D 4
                    SetTexture 5 [unity_Lightmap] 2D 5
                    SetTexture 6 [unity_LightmapInd] 2D 6
                    "ps_3_0
                    dcl_2d s0
                    dcl_2d s1
                    dcl_2d s2
                    dcl_2d s3
                    dcl_2d s4
                    dcl_2d s5
                    dcl_2d s6
                    def c6, 2.00000000, -1.00000000, 1.00000000, 8.00000000
                    def c7, -0.40824828, -0.70710677, 0.57735026, 0.00000000
                    def c8, -0.40824831, 0.70710677, 0.57735026, 128.00000000
                    def c9, 0.81649655, 0.00000000, 0.57735026, 0.50000000
                    dcl_texcoord0 v0
                    dcl_texcoord1 v1.xy
                    dcl_texcoord2 v2.xyz
                    dcl_texcoord3 v3.x
                    dcl_texcoord4 v4
                    dcl_texcoord5 v5.xy
                    texld r0, v5, s6
                    mul_pp r0.xyz, r0.w, r0
                    mul_pp r2.xyz, r0, c6.w
                    mul r0.xyz, r2.y, c8
                    mad r0.xyz, r2.x, c9, r0
                    mad r0.xyz, r2.z, c7, r0
                    dp3 r0.w, r0, r0
                    rsq r0.w, r0.w
                    texld r1.yw, v0.zwzw, s1
                    mad_pp r1.xy, r1.wyzw, c6.x, c6.y
                    mul r0.xyz, r0.w, r0
                    dp3_pp r0.w, v2, v2
                    rsq_pp r0.w, r0.w
                    mul_pp r1.zw, r1.xyxy, r1.xyxy
                    mad_pp r0.xyz, r0.w, v2, r0
                    add_pp_sat r0.w, r1.z, r1
                    dp3_pp r1.z, r0, r0
                    rsq_pp r1.z, r1.z
                    add_pp r0.w, -r0, c6.z
                    mul_pp r0.xyz, r1.z, r0
                    rsq_pp r0.w, r0.w
                    rcp_pp r1.z, r0.w
                    dp3_pp r0.x, r1, r0
                    mov_pp r0.w, c2.x
                    dp3_pp_sat r3.z, r1, c7
                    dp3_pp_sat r3.x, r1, c9
                    dp3_pp_sat r3.y, r1, c8
                    dp3_pp r1.x, r3, r2
                    mul_pp r2.w, c8, r0
                    max_pp r1.w, r0.x, c7
                    pow r0, r1.w, r2.w
                    mov r1.w, r0
                    texld r0, v5, s5
                    mul_pp r0.xyz, r0.w, r0
                    mul_pp r1.xyz, r0, r1.x
                    texldp r0, v4, s4
                    log_pp r0.x, r0.x
                    log_pp r0.y, r0.y
                    log_pp r0.z, r0.z
                    log_pp r0.w, r0.w
                    mul_pp r1.xyz, r1, c6.w
                    add_pp r1, -r0, r1
                    texld r0, v0, s0
                    mul_pp r2.w, r0, r1
                    mul_pp r2.xyz, r1, c0
                    mul_pp r0.xyz, r0, c1
                    mul_pp r2.xyz, r2, r2.w
                    mad_pp r2.xyz, r0, r1, r2
                    dp3 r1.w, v2, v2
                    rsq r0.x, r1.w
                    mul_sat r0.x, r0, v2.z
                    add r3.x, -r0, c6.z
                    add r0.y, -r0.w, c6.z
                    texld r1, v1, s3
                    mul r1, r1, r0.y
                    pow_pp r0, r3.x, c4.x
                    add r0.w, -r1, c6.z
                    mov_pp r3.w, r0.x
                    mov r3.y, c9.w
                    mov r3.x, v3
                    texld r3.xyz, r3, s2
                    mul r0.xyz, r3, c5.x
                    mul r0.xyz, r0, r3.w
                    mul r0.xyz, r0, c3.x
                    mul r1.xyz, r1, r1.w
                    mad r1.xyz, r0, r0.w, r1
                    mov_pp r0.x, c3
                    add_pp oC0.xyz, r2, r1
                    mad_pp oC0.w, r2, c0, r0.x
                    "
                }
                SubProgram "opengl " {
                    Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
                    Vector 0 [_SpecColor]
                    Vector 1 [_Color]
                    Float 2 [_Opacity]
                    Float 3 [_rimPower]
                    Float 4 [_rimBlend]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 2 [_rimColorRamp] 2D 2
                    SetTexture 3 [_ResourceMap] 2D 3
                    SetTexture 4 [_LightBuffer] 2D 4
                    "3.0-!!ARBfp1.0
                    PARAM c[6] = { program.local[0..4],
                    { 0.5, 1 } };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    TEX R0, fragment.texcoord[0], texture[0], 2D;
                    TXP R1, fragment.texcoord[4], texture[4], 2D;
                    ADD R1.xyz, R1, fragment.texcoord[5];
                    MUL R0.xyz, R0, c[1];
                    MUL R2.w, R0, R1;
                    MUL R2.xyz, R1, c[0];
                    MUL R2.xyz, R2, R2.w;
                    MAD R2.xyz, R0, R1, R2;
                    DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
                    RSQ R0.x, R0.x;
                    MUL_SAT R0.x, R0, fragment.texcoord[2].z;
                    ADD R3.x, -R0, c[5].y;
                    ADD R0.y, -R0.w, c[5];
                    TEX R1, fragment.texcoord[1], texture[3], 2D;
                    MUL R1, R1, R0.y;
                    ADD R0.w, -R1, c[5].y;
                    MOV R0.y, c[5].x;
                    MOV R0.x, fragment.texcoord[3];
                    TEX R0.xyz, R0, texture[2], 2D;
                    POW R3.x, R3.x, c[3].x;
                    MUL R0.xyz, R0, c[4].x;
                    MUL R0.xyz, R0, R3.x;
                    MUL R0.xyz, R0, c[2].x;
                    MUL R1.xyz, R1, R1.w;
                    MAD R1.xyz, R0, R0.w, R1;
                    MOV R0.x, c[2];
                    ADD result.color.xyz, R2, R1;
                    MAD result.color.w, R2, c[0], R0.x;
                    END
# 28 instructions, 4 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
                    Vector 0 [_SpecColor]
                    Vector 1 [_Color]
                    Float 2 [_Opacity]
                    Float 3 [_rimPower]
                    Float 4 [_rimBlend]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 2 [_rimColorRamp] 2D 2
                    SetTexture 3 [_ResourceMap] 2D 3
                    SetTexture 4 [_LightBuffer] 2D 4
                    "ps_3_0
                    dcl_2d s0
                    dcl_2d s2
                    dcl_2d s3
                    dcl_2d s4
                    def c5, 1.00000000, 0.50000000, 0, 0
                    dcl_texcoord0 v0.xy
                    dcl_texcoord1 v1.xy
                    dcl_texcoord2 v2.xyz
                    dcl_texcoord3 v3.x
                    dcl_texcoord4 v4
                    dcl_texcoord5 v5.xyz
                    texld r0, v0, s0
                    texldp r1, v4, s4
                    mul_pp r2.w, r0, r1
                    add_pp r1.xyz, r1, v5
                    mul_pp r2.xyz, r1, c0
                    mul_pp r0.xyz, r0, c1
                    mul_pp r2.xyz, r2, r2.w
                    mad_pp r2.xyz, r0, r1, r2
                    dp3 r1.w, v2, v2
                    rsq r0.x, r1.w
                    mul_sat r0.x, r0, v2.z
                    add r3.x, -r0, c5
                    add r0.y, -r0.w, c5.x
                    texld r1, v1, s3
                    mul r1, r1, r0.y
                    pow_pp r0, r3.x, c3.x
                    add r0.w, -r1, c5.x
                    mov_pp r3.w, r0.x
                    mov r3.y, c5
                    mov r3.x, v3
                    texld r3.xyz, r3, s2
                    mul r0.xyz, r3, c4.x
                    mul r0.xyz, r0, r3.w
                    mul r0.xyz, r0, c2.x
                    mul r1.xyz, r1, r1.w
                    mad r1.xyz, r0, r0.w, r1
                    mov_pp r0.x, c2
                    add_pp oC0.xyz, r2, r1
                    mad_pp oC0.w, r2, c0, r0.x
                    "
                }
                SubProgram "opengl " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
                    Vector 0 [_SpecColor]
                    Vector 1 [_Color]
                    Float 2 [_Opacity]
                    Float 3 [_rimPower]
                    Float 4 [_rimBlend]
                    Vector 5 [unity_LightmapFade]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 2 [_rimColorRamp] 2D 2
                    SetTexture 3 [_ResourceMap] 2D 3
                    SetTexture 4 [_LightBuffer] 2D 4
                    SetTexture 5 [unity_Lightmap] 2D 5
                    SetTexture 6 [unity_LightmapInd] 2D 6
                    "3.0-!!ARBfp1.0
                    PARAM c[7] = { program.local[0..5],
                    { 8, 0.5, 1 } };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    TEX R0, fragment.texcoord[5], texture[5], 2D;
                    MUL R1.xyz, R0.w, R0;
                    TEX R0, fragment.texcoord[5], texture[6], 2D;
                    MUL R0.xyz, R0.w, R0;
                    MUL R0.xyz, R0, c[6].x;
                    DP4 R1.w, fragment.texcoord[6], fragment.texcoord[6];
                    RSQ R0.w, R1.w;
                    RCP R0.w, R0.w;
                    MAD R1.xyz, R1, c[6].x, -R0;
                    MAD_SAT R0.w, R0, c[5].z, c[5];
                    MAD R2.xyz, R0.w, R1, R0;
                    TEX R1, fragment.texcoord[0], texture[0], 2D;
                    TXP R0, fragment.texcoord[4], texture[4], 2D;
                    ADD R0.xyz, R0, R2;
                    MUL R2.xyz, R0, c[0];
                    MUL R0.w, R1, R0;
                    MUL R1.xyz, R1, c[1];
                    MUL R2.xyz, R2, R0.w;
                    MAD R2.xyz, R1, R0, R2;
                    DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
                    RSQ R0.x, R0.x;
                    ADD R0.y, -R1.w, c[6].z;
                    TEX R3, fragment.texcoord[1], texture[3], 2D;
                    MUL R1, R3, R0.y;
                    MUL_SAT R0.x, R0, fragment.texcoord[2].z;
                    ADD R3.x, -R0, c[6].z;
                    ADD R2.w, -R1, c[6].z;
                    MOV R0.y, c[6];
                    MOV R0.x, fragment.texcoord[3];
                    TEX R0.xyz, R0, texture[2], 2D;
                    POW R3.x, R3.x, c[3].x;
                    MUL R0.xyz, R0, c[4].x;
                    MUL R0.xyz, R0, R3.x;
                    MUL R0.xyz, R0, c[2].x;
                    MUL R1.xyz, R1, R1.w;
                    MAD R1.xyz, R0, R2.w, R1;
                    MOV R0.x, c[2];
                    ADD result.color.xyz, R2, R1;
                    MAD result.color.w, R0, c[0], R0.x;
                    END
# 39 instructions, 4 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
                    Vector 0 [_SpecColor]
                    Vector 1 [_Color]
                    Float 2 [_Opacity]
                    Float 3 [_rimPower]
                    Float 4 [_rimBlend]
                    Vector 5 [unity_LightmapFade]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 2 [_rimColorRamp] 2D 2
                    SetTexture 3 [_ResourceMap] 2D 3
                    SetTexture 4 [_LightBuffer] 2D 4
                    SetTexture 5 [unity_Lightmap] 2D 5
                    SetTexture 6 [unity_LightmapInd] 2D 6
                    "ps_3_0
                    dcl_2d s0
                    dcl_2d s2
                    dcl_2d s3
                    dcl_2d s4
                    dcl_2d s5
                    dcl_2d s6
                    def c6, 1.00000000, 0.50000000, 8.00000000, 0
                    dcl_texcoord0 v0.xy
                    dcl_texcoord1 v1.xy
                    dcl_texcoord2 v2.xyz
                    dcl_texcoord3 v3.x
                    dcl_texcoord4 v4
                    dcl_texcoord5 v5.xy
                    dcl_texcoord6 v6
                    texld r0, v5, s5
                    mul_pp r1.xyz, r0.w, r0
                    texld r0, v5, s6
                    mul_pp r0.xyz, r0.w, r0
                    mul_pp r0.xyz, r0, c6.z
                    dp4 r1.w, v6, v6
                    rsq r0.w, r1.w
                    rcp r0.w, r0.w
                    mad_pp r1.xyz, r1, c6.z, -r0
                    mad_sat r0.w, r0, c5.z, c5
                    mad_pp r2.xyz, r0.w, r1, r0
                    texld r0, v0, s0
                    texldp r1, v4, s4
                    add_pp r1.xyz, r1, r2
                    mul_pp r2.w, r0, r1
                    mul_pp r2.xyz, r1, c0
                    mul_pp r0.xyz, r0, c1
                    mul_pp r2.xyz, r2, r2.w
                    mad_pp r2.xyz, r0, r1, r2
                    dp3 r1.w, v2, v2
                    rsq r0.x, r1.w
                    mul_sat r0.x, r0, v2.z
                    add r3.x, -r0, c6
                    add r0.y, -r0.w, c6.x
                    texld r1, v1, s3
                    mul r1, r1, r0.y
                    pow_pp r0, r3.x, c3.x
                    add r0.w, -r1, c6.x
                    mov_pp r3.w, r0.x
                    mov r3.y, c6
                    mov r3.x, v3
                    texld r3.xyz, r3, s2
                    mul r0.xyz, r3, c4.x
                    mul r0.xyz, r0, r3.w
                    mul r0.xyz, r0, c2.x
                    mul r1.xyz, r1, r1.w
                    mad r1.xyz, r0, r0.w, r1
                    mov_pp r0.x, c2
                    add_pp oC0.xyz, r2, r1
                    mad_pp oC0.w, r2, c0, r0.x
                    "
                }
                SubProgram "opengl " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
                    Vector 0 [_SpecColor]
                    Vector 1 [_Color]
                    Float 2 [_Shininess]
                    Float 3 [_Opacity]
                    Float 4 [_rimPower]
                    Float 5 [_rimBlend]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_rimColorRamp] 2D 2
                    SetTexture 3 [_ResourceMap] 2D 3
                    SetTexture 4 [_LightBuffer] 2D 4
                    SetTexture 5 [unity_Lightmap] 2D 5
                    SetTexture 6 [unity_LightmapInd] 2D 6
                    "3.0-!!ARBfp1.0
                    PARAM c[10] = { program.local[0..5],
                    { 2, 1, 8, 0 },
                    { -0.40824828, -0.70710677, 0.57735026, 128 },
                    { -0.40824831, 0.70710677, 0.57735026, 0.5 },
                    { 0.81649655, 0, 0.57735026 } };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    TEX R0, fragment.texcoord[5], texture[6], 2D;
                    MUL R0.xyz, R0.w, R0;
                    MUL R0.xyz, R0, c[6].z;
                    MUL R1.xyz, R0.y, c[8];
                    MAD R1.xyz, R0.x, c[9], R1;
                    MAD R2.xyz, R0.z, c[7], R1;
                    DP3 R0.w, R2, R2;
                    RSQ R0.w, R0.w;
                    TEX R1.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
                    MAD R1.xy, R1.wyzw, c[6].x, -c[6].y;
                    MUL R2.xyz, R0.w, R2;
                    DP3 R0.w, fragment.texcoord[2], fragment.texcoord[2];
                    RSQ R0.w, R0.w;
                    MUL R1.zw, R1.xyxy, R1.xyxy;
                    MAD R2.xyz, R0.w, fragment.texcoord[2], R2;
                    ADD_SAT R0.w, R1.z, R1;
                    DP3 R1.z, R2, R2;
                    RSQ R1.z, R1.z;
                    ADD R0.w, -R0, c[6].y;
                    MUL R2.xyz, R1.z, R2;
                    RSQ R0.w, R0.w;
                    RCP R1.z, R0.w;
                    DP3 R0.w, R1, R2;
                    DP3_SAT R2.z, R1, c[7];
                    DP3_SAT R2.x, R1, c[9];
                    DP3_SAT R2.y, R1, c[8];
                    DP3 R1.y, R2, R0;
                    MAX R1.w, R0, c[6];
                    TEX R0, fragment.texcoord[5], texture[5], 2D;
                    MUL R0.xyz, R0.w, R0;
                    MOV R1.x, c[7].w;
                    MUL R0.w, R1.x, c[2].x;
                    MUL R0.xyz, R0, R1.y;
                    POW R1.w, R1.w, R0.w;
                    MUL R1.xyz, R0, c[6].z;
                    TXP R0, fragment.texcoord[4], texture[4], 2D;
                    ADD R1, R0, R1;
                    TEX R0, fragment.texcoord[0], texture[0], 2D;
                    MUL R0.xyz, R0, c[1];
                    MUL R2.w, R0, R1;
                    MUL R2.xyz, R1, c[0];
                    MUL R2.xyz, R2, R2.w;
                    MAD R2.xyz, R0, R1, R2;
                    DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
                    RSQ R0.x, R0.x;
                    MUL_SAT R0.x, R0, fragment.texcoord[2].z;
                    ADD R3.x, -R0, c[6].y;
                    ADD R0.y, -R0.w, c[6];
                    TEX R1, fragment.texcoord[1], texture[3], 2D;
                    MUL R1, R1, R0.y;
                    ADD R0.w, -R1, c[6].y;
                    MOV R0.y, c[8].w;
                    MOV R0.x, fragment.texcoord[3];
                    TEX R0.xyz, R0, texture[2], 2D;
                    POW R3.x, R3.x, c[4].x;
                    MUL R0.xyz, R0, c[5].x;
                    MUL R0.xyz, R0, R3.x;
                    MUL R0.xyz, R0, c[3].x;
                    MUL R1.xyz, R1, R1.w;
                    MAD R1.xyz, R0, R0.w, R1;
                    MOV R0.x, c[3];
                    ADD result.color.xyz, R2, R1;
                    MAD result.color.w, R2, c[0], R0.x;
                    END
# 63 instructions, 4 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
                    Vector 0 [_SpecColor]
                    Vector 1 [_Color]
                    Float 2 [_Shininess]
                    Float 3 [_Opacity]
                    Float 4 [_rimPower]
                    Float 5 [_rimBlend]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_rimColorRamp] 2D 2
                    SetTexture 3 [_ResourceMap] 2D 3
                    SetTexture 4 [_LightBuffer] 2D 4
                    SetTexture 5 [unity_Lightmap] 2D 5
                    SetTexture 6 [unity_LightmapInd] 2D 6
                    "ps_3_0
                    dcl_2d s0
                    dcl_2d s1
                    dcl_2d s2
                    dcl_2d s3
                    dcl_2d s4
                    dcl_2d s5
                    dcl_2d s6
                    def c6, 2.00000000, -1.00000000, 1.00000000, 8.00000000
                    def c7, -0.40824828, -0.70710677, 0.57735026, 0.00000000
                    def c8, -0.40824831, 0.70710677, 0.57735026, 128.00000000
                    def c9, 0.81649655, 0.00000000, 0.57735026, 0.50000000
                    dcl_texcoord0 v0
                    dcl_texcoord1 v1.xy
                    dcl_texcoord2 v2.xyz
                    dcl_texcoord3 v3.x
                    dcl_texcoord4 v4
                    dcl_texcoord5 v5.xy
                    texld r0, v5, s6
                    mul_pp r0.xyz, r0.w, r0
                    mul_pp r2.xyz, r0, c6.w
                    mul r0.xyz, r2.y, c8
                    mad r0.xyz, r2.x, c9, r0
                    mad r0.xyz, r2.z, c7, r0
                    dp3 r0.w, r0, r0
                    rsq r0.w, r0.w
                    texld r1.yw, v0.zwzw, s1
                    mad_pp r1.xy, r1.wyzw, c6.x, c6.y
                    mul r0.xyz, r0.w, r0
                    dp3_pp r0.w, v2, v2
                    rsq_pp r0.w, r0.w
                    mul_pp r1.zw, r1.xyxy, r1.xyxy
                    mad_pp r0.xyz, r0.w, v2, r0
                    add_pp_sat r0.w, r1.z, r1
                    dp3_pp r1.z, r0, r0
                    rsq_pp r1.z, r1.z
                    add_pp r0.w, -r0, c6.z
                    texld r3, v5, s5
                    mul_pp r0.xyz, r1.z, r0
                    rsq_pp r0.w, r0.w
                    rcp_pp r1.z, r0.w
                    dp3_pp r0.x, r1, r0
                    mov_pp r0.w, c2.x
                    mul_pp r2.w, c8, r0
                    max_pp r1.w, r0.x, c7
                    pow r0, r1.w, r2.w
                    dp3_pp_sat r0.z, r1, c7
                    dp3_pp_sat r0.x, r1, c9
                    dp3_pp_sat r0.y, r1, c8
                    dp3_pp r1.x, r0, r2
                    mul_pp r0.xyz, r3.w, r3
                    mul_pp r0.xyz, r0, r1.x
                    mov r1.w, r0
                    mul_pp r1.xyz, r0, c6.w
                    texldp r0, v4, s4
                    add_pp r1, r0, r1
                    texld r0, v0, s0
                    mul_pp r2.w, r0, r1
                    mul_pp r2.xyz, r1, c0
                    mul_pp r0.xyz, r0, c1
                    mul_pp r2.xyz, r2, r2.w
                    mad_pp r2.xyz, r0, r1, r2
                    dp3 r1.w, v2, v2
                    rsq r0.x, r1.w
                    mul_sat r0.x, r0, v2.z
                    add r3.x, -r0, c6.z
                    add r0.y, -r0.w, c6.z
                    texld r1, v1, s3
                    mul r1, r1, r0.y
                    pow_pp r0, r3.x, c4.x
                    add r0.w, -r1, c6.z
                    mov_pp r3.w, r0.x
                    mov r3.y, c9.w
                    mov r3.x, v3
                    texld r3.xyz, r3, s2
                    mul r0.xyz, r3, c5.x
                    mul r0.xyz, r0, r3.w
                    mul r0.xyz, r0, c3.x
                    mul r1.xyz, r1, r1.w
                    mad r1.xyz, r0, r0.w, r1
                    mov_pp r0.x, c3
                    add_pp oC0.xyz, r2, r1
                    mad_pp oC0.w, r2, c0, r0.x
                    "
                }
            }
        }
    }
    Fallback "Specular"
}
