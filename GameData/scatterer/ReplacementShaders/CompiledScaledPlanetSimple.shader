Shader "scatterer/Scaled Planet (Simple)"
{
    Properties {
        _Color ("Main Color", Color) = (1,1,1,1)
        _SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
        _Shininess ("Shininess", Range(0.03,1)) = 0.078125
        _MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}
        _BumpMap ("Normalmap", 2D) = "bump" {}
        _Opacity ("Opacity", Range(0,1)) = 1
        _ResourceMap ("Resource Map (RGB)", 2D) = "black" {}
    }
    SubShader {
	ZWrite On
        LOD 400
        Pass {
            Name "FORWARD"
            Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" }
            Blend SrcAlpha OneMinusSrcAlpha
            Program "vp" {
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
                    Vector 23 [_MainTex_ST]
                    Vector 24 [_BumpMap_ST]
                    Vector 25 [_ResourceMap_ST]
                    "!!ARBvp1.0
                    PARAM c[26] = { { 1 },
                    state.matrix.mvp,
                    program.local[5..25] };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    MUL R1.xyz, vertex.normal, c[22].w;
                    DP3 R2.w, R1, c[6];
                    DP3 R0.x, R1, c[5];
                    DP3 R0.z, R1, c[7];
                    MOV R0.y, R2.w;
                    MOV R0.w, c[0].x;
                    MUL R1, R0.xyzz, R0.yzzx;
                    DP4 R2.z, R0, c[17];
                    DP4 R2.y, R0, c[16];
                    DP4 R2.x, R0, c[15];
                    MUL R0.w, R2, R2;
                    MAD R0.w, R0.x, R0.x, -R0;
                    DP4 R0.z, R1, c[20];
                    DP4 R0.y, R1, c[19];
                    DP4 R0.x, R1, c[18];
                    ADD R0.xyz, R2, R0;
                    MUL R1.xyz, R0.w, c[21];
                    ADD result.texcoord[3].xyz, R0, R1;
                    MOV R1.xyz, c[13];
                    MOV R1.w, c[0].x;
                    MOV R0.xyz, vertex.attrib[14];
                    DP4 R2.z, R1, c[11];
                    DP4 R2.y, R1, c[10];
                    DP4 R2.x, R1, c[9];
                    MAD R2.xyz, R2, c[22].w, -vertex.position;
                    MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
                    MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
                    MOV R0, c[14];
                    MUL R1.xyz, R1, vertex.attrib[14].w;
                    DP4 R3.z, R0, c[11];
                    DP4 R3.y, R0, c[10];
                    DP4 R3.x, R0, c[9];
                    DP3 result.texcoord[2].y, R3, R1;
                    DP3 result.texcoord[4].y, R1, R2;
                    DP3 result.texcoord[2].z, vertex.normal, R3;
                    DP3 result.texcoord[2].x, R3, vertex.attrib[14];
                    DP3 result.texcoord[4].z, vertex.normal, R2;
                    DP3 result.texcoord[4].x, vertex.attrib[14], R2;
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[24].xyxy, c[24];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
                    MAD result.texcoord[1].xy, vertex.texcoord[0], c[25], c[25].zwzw;
                    DP4 result.position.w, vertex.position, c[4];
                    DP4 result.position.z, vertex.position, c[3];
                    DP4 result.position.y, vertex.position, c[2];
                    DP4 result.position.x, vertex.position, c[1];
                    END
# 45 instructions, 4 R-regs
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
                    Vector 22 [_MainTex_ST]
                    Vector 23 [_BumpMap_ST]
                    Vector 24 [_ResourceMap_ST]
                    "vs_2_0
                    def c25, 1.00000000, 0, 0, 0
                    dcl_position0 v0
                    dcl_tangent0 v1
                    dcl_normal0 v2
                    dcl_texcoord0 v3
                    mul r1.xyz, v2, c21.w
                    dp3 r2.w, r1, c5
                    dp3 r0.x, r1, c4
                    dp3 r0.z, r1, c6
                    mov r0.y, r2.w
                    mov r0.w, c25.x
                    mul r1, r0.xyzz, r0.yzzx
                    dp4 r2.z, r0, c16
                    dp4 r2.y, r0, c15
                    dp4 r2.x, r0, c14
                    mul r0.w, r2, r2
                    mad r0.w, r0.x, r0.x, -r0
                    dp4 r0.z, r1, c19
                    dp4 r0.y, r1, c18
                    dp4 r0.x, r1, c17
                    mul r1.xyz, r0.w, c20
                    add r0.xyz, r2, r0
                    add oT3.xyz, r0, r1
                    mov r0.w, c25.x
                    mov r0.xyz, c12
                    dp4 r1.z, r0, c10
                    dp4 r1.y, r0, c9
                    dp4 r1.x, r0, c8
                    mad r3.xyz, r1, c21.w, -v0
                    mov r0.xyz, v1
                    mul r1.xyz, v2.zxyw, r0.yzxw
                    mov r0.xyz, v1
                    mad r1.xyz, v2.yzxw, r0.zxyw, -r1
                    mul r2.xyz, r1, v1.w
                    mov r0, c10
                    dp4 r4.z, c13, r0
                    mov r0, c9
                    mov r1, c8
                    dp4 r4.y, c13, r0
                    dp4 r4.x, c13, r1
                    dp3 oT2.y, r4, r2
                    dp3 oT4.y, r2, r3
                    dp3 oT2.z, v2, r4
                    dp3 oT2.x, r4, v1
                    dp3 oT4.z, v2, r3
                    dp3 oT4.x, v1, r3
                    mad oT0.zw, v3.xyxy, c23.xyxy, c23
                    mad oT0.xy, v3, c22, c22.zwzw
                    mad oT1.xy, v3, c24, c24.zwzw
                    dp4 oPos.w, v0, c3
                    dp4 oPos.z, v0, c2
                    dp4 oPos.y, v0, c1
                    dp4 oPos.x, v0, c0
                    "
                }
                SubProgram "d3d11 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" TexCoord2
                    ConstBuffer "$Globals" 128
                    Vector 80 [_MainTex_ST]
                    Vector 96 [_BumpMap_ST]
                    Vector 112 [_ResourceMap_ST]
                    ConstBuffer "UnityPerCamera" 128
                    Vector 64 [_WorldSpaceCameraPos] 3
                    ConstBuffer "UnityLighting" 720
                    Vector 0 [_WorldSpaceLightPos0]
                    Vector 608 [unity_SHAr]
                    Vector 624 [unity_SHAg]
                    Vector 640 [unity_SHAb]
                    Vector 656 [unity_SHBr]
                    Vector 672 [unity_SHBg]
                    Vector 688 [unity_SHBb]
                    Vector 704 [unity_SHC]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 192 [_Object2World]
                    Matrix 256 [_World2Object]
                    Vector 320 [unity_Scale]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerCamera" 1
                    BindCB  "UnityLighting" 2
                    BindCB  "UnityPerDraw" 3
                    "vs_4_0
                    eefiecedhbpalkodmjjajbioflobebmagcfdijmjabaaaaaacaaiaaaaadaaaaaa
                    cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
                    abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
                    enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
                    aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
                    adaaaaaaacaaaaaaadamaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
                    ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
                    aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
                    feeffiedepepfceeaaklklklfdeieefcgmagaaaaeaaaabaajlabaaaafjaaaaae
                    egiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
                    egiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
                    pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
                    fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
                    pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
                    gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacafaaaaaa
                    diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
                    dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaa
                    egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaa
                    kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
                    adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
                    abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaa
                    afaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
                    agaaaaaakgiocaaaaaaaaaaaagaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
                    adaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaadiaaaaah
                    hcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaa
                    aaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaa
                    diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaaj
                    hcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaa
                    dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaa
                    aaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
                    bcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
                    abaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaa
                    abaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
                    baaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
                    eccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaa
                    abaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaa
                    acaaaaaafgafbaaaabaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaa
                    abaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaabaaaaaaegaibaaaacaaaaaa
                    dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaabaaaaaa
                    egadbaaaabaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpbbaaaaai
                    bcaabaaaacaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaabbaaaaai
                    ccaabaaaacaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaabbaaaaai
                    ecaabaaaacaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaadiaaaaah
                    pcaabaaaadaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaa
                    aeaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaa
                    aeaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaa
                    aeaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaadaaaaaaaaaaaaahhcaabaaa
                    acaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaaaaaaaaaa
                    bkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaa
                    abaaaaaaakaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaadcaaaaakhccabaaa
                    aeaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaa
                    diaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
                    bbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
                    abaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
                    adaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaai
                    hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaal
                    hcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaia
                    ebaaaaaaaaaaaaaabaaaaaahcccabaaaafaaaaaaegacbaaaaaaaaaaaegacbaaa
                    abaaaaaabaaaaaahbccabaaaafaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
                    baaaaaaheccabaaaafaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadoaaaaab
                    "
                }
                SubProgram "d3d11_9x " {
                    Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" TexCoord2
                    ConstBuffer "$Globals" 128
                    Vector 80 [_MainTex_ST]
                    Vector 96 [_BumpMap_ST]
                    Vector 112 [_ResourceMap_ST]
                    ConstBuffer "UnityPerCamera" 128
                    Vector 64 [_WorldSpaceCameraPos] 3
                    ConstBuffer "UnityLighting" 720
                    Vector 0 [_WorldSpaceLightPos0]
                    Vector 608 [unity_SHAr]
                    Vector 624 [unity_SHAg]
                    Vector 640 [unity_SHAb]
                    Vector 656 [unity_SHBr]
                    Vector 672 [unity_SHBg]
                    Vector 688 [unity_SHBb]
                    Vector 704 [unity_SHC]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 192 [_Object2World]
                    Matrix 256 [_World2Object]
                    Vector 320 [unity_Scale]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerCamera" 1
                    BindCB  "UnityLighting" 2
                    BindCB  "UnityPerDraw" 3
                    "vs_4_0_level_9_1
                    eefiecedjkocabhegnhfpjnljedifinckhgnnlbeabaaaaaaamamaaaaaeaaaaaa
                    daaaaaaabiaeaaaaimakaaaafealaaaaebgpgodjoaadaaaaoaadaaaaaaacpopp
                    geadaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaafaa
                    adaaabaaaaaaaaaaabaaaeaaabaaaeaaaaaaaaaaacaaaaaaabaaafaaaaaaaaaa
                    acaacgaaahaaagaaaaaaaaaaadaaaaaaaeaaanaaaaaaaaaaadaaamaaadaabbaa
                    aaaaaaaaadaabaaaafaabeaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafbjaaapka
                    aaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaac
                    afaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapja
                    aeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaaeaaaaaeaaaaamoaadaaeeja
                    acaaeekaacaaoekaaeaaaaaeabaaadoaadaaoejaadaaoekaadaaookaabaaaaac
                    aaaaapiaafaaoekaafaaaaadabaaahiaaaaaffiabfaaoekaaeaaaaaeabaaahia
                    beaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiabgaaoekaaaaakkiaabaaoeia
                    aeaaaaaeaaaaahiabhaaoekaaaaappiaaaaaoeiaaiaaaaadacaaaboaabaaoeja
                    aaaaoeiaabaaaaacabaaahiaacaaoejaafaaaaadacaaahiaabaanciaabaamjja
                    aeaaaaaeabaaahiaabaamjiaabaancjaacaaoeibafaaaaadabaaahiaabaaoeia
                    abaappjaaiaaaaadacaaacoaabaaoeiaaaaaoeiaaiaaaaadacaaaeoaacaaoeja
                    aaaaoeiaabaaaaacaaaaahiaaeaaoekaafaaaaadacaaahiaaaaaffiabfaaoeka
                    aeaaaaaeaaaaaliabeaakekaaaaaaaiaacaakeiaaeaaaaaeaaaaahiabgaaoeka
                    aaaakkiaaaaapeiaacaaaaadaaaaahiaaaaaoeiabhaaoekaaeaaaaaeaaaaahia
                    aaaaoeiabiaappkaaaaaoejbaiaaaaadaeaaaboaabaaoejaaaaaoeiaaiaaaaad
                    aeaaacoaabaaoeiaaaaaoeiaaiaaaaadaeaaaeoaacaaoejaaaaaoeiaafaaaaad
                    aaaaahiaacaaoejabiaappkaafaaaaadabaaahiaaaaaffiabcaaoekaaeaaaaae
                    aaaaaliabbaakekaaaaaaaiaabaakeiaaeaaaaaeaaaaahiabdaaoekaaaaakkia
                    aaaapeiaabaaaaacaaaaaiiabjaaaakaajaaaaadabaaabiaagaaoekaaaaaoeia
                    ajaaaaadabaaaciaahaaoekaaaaaoeiaajaaaaadabaaaeiaaiaaoekaaaaaoeia
                    afaaaaadacaaapiaaaaacjiaaaaakeiaajaaaaadadaaabiaajaaoekaacaaoeia
                    ajaaaaadadaaaciaakaaoekaacaaoeiaajaaaaadadaaaeiaalaaoekaacaaoeia
                    acaaaaadabaaahiaabaaoeiaadaaoeiaafaaaaadaaaaaciaaaaaffiaaaaaffia
                    aeaaaaaeaaaaabiaaaaaaaiaaaaaaaiaaaaaffibaeaaaaaeadaaahoaamaaoeka
                    aaaaaaiaabaaoeiaafaaaaadaaaaapiaaaaaffjaaoaaoekaaeaaaaaeaaaaapia
                    anaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaapaaoekaaaaakkjaaaaaoeia
                    aeaaaaaeaaaaapiabaaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
                    aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefcgmagaaaa
                    eaaaabaajlabaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaa
                    abaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaa
                    adaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
                    fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
                    aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
                    gfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaa
                    afaaaaaagiaaaaacafaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
                    egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
                    aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
                    egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
                    pccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
                    aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
                    afaaaaaaogikcaaaaaaaaaaaafaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaa
                    adaaaaaaagiecaaaaaaaaaaaagaaaaaakgiocaaaaaaaaaaaagaaaaaadcaaaaal
                    dccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaa
                    aaaaaaaaahaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaa
                    acaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaa
                    egacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
                    pgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaa
                    egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
                    baaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
                    abaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaa
                    abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaa
                    acaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaa
                    aaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaa
                    egacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaa
                    abaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaa
                    beaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaadaaaaaa
                    anaaaaaadcaaaaaklcaabaaaabaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaa
                    abaaaaaaegaibaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
                    aoaaaaaakgakbaaaabaaaaaaegadbaaaabaaaaaadgaaaaaficaabaaaabaaaaaa
                    abeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaaegiocaaaacaaaaaacgaaaaaa
                    egaobaaaabaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaaacaaaaaachaaaaaa
                    egaobaaaabaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaaacaaaaaaciaaaaaa
                    egaobaaaabaaaaaadiaaaaahpcaabaaaadaaaaaajgacbaaaabaaaaaaegakbaaa
                    abaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaa
                    adaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaa
                    adaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaa
                    adaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaa
                    diaaaaahicaabaaaaaaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaak
                    icaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadkaabaiaebaaaaaa
                    aaaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaa
                    aaaaaaaaegacbaaaacaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaa
                    aeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
                    adaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaal
                    hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
                    egacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
                    adaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaa
                    adaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaafaaaaaa
                    egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaafaaaaaaegbcbaaa
                    abaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaafaaaaaaegbcbaaaacaaaaaa
                    egacbaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
                    abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
                    enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
                    aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
                    adaaaaaaacaaaaaaadamaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
                    ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
                    aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
                    feeffiedepepfceeaaklklkl"
                }
                SubProgram "opengl " {
                    Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
                    Bind "vertex" Vertex
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    Vector 14 [unity_LightmapST]
                    Vector 15 [_MainTex_ST]
                    Vector 16 [_BumpMap_ST]
                    Vector 17 [_ResourceMap_ST]
                    "!!ARBvp1.0
                    PARAM c[18] = { program.local[0],
                    state.matrix.mvp,
                    program.local[5..17] };
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[16].xyxy, c[16];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
                    MAD result.texcoord[1].xy, vertex.texcoord[0], c[17], c[17].zwzw;
                    MAD result.texcoord[2].xy, vertex.texcoord[1], c[14], c[14].zwzw;
                    DP4 result.position.w, vertex.position, c[4];
                    DP4 result.position.z, vertex.position, c[3];
                    DP4 result.position.y, vertex.position, c[2];
                    DP4 result.position.x, vertex.position, c[1];
                    END
# 8 instructions, 0 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
                    Bind "vertex" Vertex
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    Matrix 0 [glstate_matrix_mvp]
                    Vector 12 [unity_LightmapST]
                    Vector 13 [_MainTex_ST]
                    Vector 14 [_BumpMap_ST]
                    Vector 15 [_ResourceMap_ST]
                    "vs_2_0
                    dcl_position0 v0
                    dcl_texcoord0 v3
                    dcl_texcoord1 v4
                    mad oT0.zw, v3.xyxy, c14.xyxy, c14
                    mad oT0.xy, v3, c13, c13.zwzw
                    mad oT1.xy, v3, c15, c15.zwzw
                    mad oT2.xy, v4, c12, c12.zwzw
                    dp4 oPos.w, v0, c3
                    dp4 oPos.z, v0, c2
                    dp4 oPos.y, v0, c1
                    dp4 oPos.x, v0, c0
                    "
                }
                SubProgram "d3d11 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    ConstBuffer "$Globals" 144
                    Vector 80 [unity_LightmapST]
                    Vector 96 [_MainTex_ST]
                    Vector 112 [_BumpMap_ST]
                    Vector 128 [_ResourceMap_ST]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerDraw" 1
                    "vs_4_0
                    eefieceddknhpnmfpbfpimbiofokblngpijapddbabaaaaaafiadaaaaadaaaaaa
                    cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
                    abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
                    enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
                    aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaa
                    adaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    amadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
                    neabaaaaeaaaabaahfaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaae
                    egiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
                    adaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
                    gfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
                    acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
                    egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
                    aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
                    egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
                    pccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
                    aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
                    agaaaaaaogikcaaaaaaaaaaaagaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaa
                    adaaaaaaagiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaaahaaaaaadcaaaaal
                    dccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaa
                    aaaaaaaaaiaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaaaeaaaaaaagiecaaa
                    aaaaaaaaafaaaaaakgiocaaaaaaaaaaaafaaaaaadoaaaaab"
                }
                SubProgram "d3d11_9x " {
                    Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    ConstBuffer "$Globals" 144
                    Vector 80 [unity_LightmapST]
                    Vector 96 [_MainTex_ST]
                    Vector 112 [_BumpMap_ST]
                    Vector 128 [_ResourceMap_ST]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerDraw" 1
                    "vs_4_0_level_9_1
                    eefieceddhonfdpijgdjgmaklblbdjkpnhdibojeabaaaaaaimaeaaaaaeaaaaaa
                    daaaaaaagaabaaaadmadaaaaaeaeaaaaebgpgodjciabaaaaciabaaaaaaacpopp
                    oiaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaafaa
                    aeaaabaaaaaaaaaaabaaaaaaaeaaafaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
                    afaaaaiaaaaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeiaaeaaapja
                    aeaaaaaeaaaaadoaadaaoejaacaaoekaacaaookaaeaaaaaeaaaaamoaadaaeeja
                    adaaeekaadaaoekaaeaaaaaeabaaadoaadaaoejaaeaaoekaaeaaookaaeaaaaae
                    abaaamoaaeaabejaabaabekaabaalekaafaaaaadaaaaapiaaaaaffjaagaaoeka
                    aeaaaaaeaaaaapiaafaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaahaaoeka
                    aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaaiaaoekaaaaappjaaaaaoeiaaeaaaaae
                    aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaa
                    fdeieefcneabaaaaeaaaabaahfaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
                    fjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
                    dcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaa
                    abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaad
                    mccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
                    aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
                    abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
                    aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
                    dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
                    egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
                    aaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaadcaaaaalmccabaaaabaaaaaa
                    agbebaaaadaaaaaaagiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaaahaaaaaa
                    dcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaa
                    ogikcaaaaaaaaaaaaiaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaaaeaaaaaa
                    agiecaaaaaaaaaaaafaaaaaakgiocaaaaaaaaaaaafaaaaaadoaaaaabejfdeheo
                    maaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
                    apapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaalaaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
                    apadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdej
                    feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
                    epfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
                    adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
                    apaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaa
                    acaaaaaaaaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfaepfdejfeejepeoaa
                    feeffiedepepfceeaaklklkl"
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
                    Vector 16 [unity_LightmapST]
                    Vector 17 [_MainTex_ST]
                    Vector 18 [_BumpMap_ST]
                    Vector 19 [_ResourceMap_ST]
                    "!!ARBvp1.0
                    PARAM c[20] = { { 1 },
                    state.matrix.mvp,
                    program.local[5..19] };
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
                    DP3 result.texcoord[3].y, R0, R1;
                    DP3 result.texcoord[3].z, vertex.normal, R0;
                    DP3 result.texcoord[3].x, R0, vertex.attrib[14];
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[18].xyxy, c[18];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[17], c[17].zwzw;
                    MAD result.texcoord[1].xy, vertex.texcoord[0], c[19], c[19].zwzw;
                    MAD result.texcoord[2].xy, vertex.texcoord[1], c[16], c[16].zwzw;
                    DP4 result.position.w, vertex.position, c[4];
                    DP4 result.position.z, vertex.position, c[3];
                    DP4 result.position.y, vertex.position, c[2];
                    DP4 result.position.x, vertex.position, c[1];
                    END
# 21 instructions, 3 R-regs
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
                    Vector 14 [unity_LightmapST]
                    Vector 15 [_MainTex_ST]
                    Vector 16 [_BumpMap_ST]
                    Vector 17 [_ResourceMap_ST]
                    "vs_2_0
                    def c18, 1.00000000, 0, 0, 0
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
                    mov r0.w, c18.x
                    dp4 r2.z, r0, c10
                    dp4 r2.x, r0, c8
                    dp4 r2.y, r0, c9
                    mad r0.xyz, r2, c13.w, -v0
                    dp3 oT3.y, r0, r1
                    dp3 oT3.z, v2, r0
                    dp3 oT3.x, r0, v1
                    mad oT0.zw, v3.xyxy, c16.xyxy, c16
                    mad oT0.xy, v3, c15, c15.zwzw
                    mad oT1.xy, v3, c17, c17.zwzw
                    mad oT2.xy, v4, c14, c14.zwzw
                    dp4 oPos.w, v0, c3
                    dp4 oPos.z, v0, c2
                    dp4 oPos.y, v0, c1
                    dp4 oPos.x, v0, c0
                    "
                }
                SubProgram "d3d11 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    Bind "tangent" TexCoord2
                    ConstBuffer "$Globals" 144
                    Vector 80 [unity_LightmapST]
                    Vector 96 [_MainTex_ST]
                    Vector 112 [_BumpMap_ST]
                    Vector 128 [_ResourceMap_ST]
                    ConstBuffer "UnityPerCamera" 128
                    Vector 64 [_WorldSpaceCameraPos] 3
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 256 [_World2Object]
                    Vector 320 [unity_Scale]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerCamera" 1
                    BindCB  "UnityPerDraw" 2
                    "vs_4_0
                    eefiecedebigigjgpbaeomjccefecbgmebfhgbhnabaaaaaacaafaaaaadaaaaaa
                    cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
                    abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
                    enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
                    aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
                    adaaaaaaacaaaaaaadamaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    amadaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfa
                    epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcieadaaaaeaaaabaa
                    obaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaa
                    afaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
                    fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
                    adaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
                    gfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
                    acaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
                    aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
                    aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
                    dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
                    egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
                    pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
                    adaaaaaaegiacaaaaaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaadcaaaaal
                    mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaahaaaaaakgiocaaa
                    aaaaaaaaahaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaa
                    aaaaaaaaaiaaaaaaogikcaaaaaaaaaaaaiaaaaaadcaaaaalmccabaaaacaaaaaa
                    agbebaaaaeaaaaaaagiecaaaaaaaaaaaafaaaaaakgiocaaaaaaaaaaaafaaaaaa
                    diaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaak
                    hcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaa
                    aaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaa
                    diaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaa
                    bbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaa
                    abaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
                    acaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaai
                    hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaacaaaaaabdaaaaaadcaaaaal
                    hcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaacaaaaaabeaaaaaaegbcbaia
                    ebaaaaaaaaaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaa
                    abaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
                    baaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadoaaaaab
                    "
                }
                SubProgram "d3d11_9x " {
                    Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    Bind "tangent" TexCoord2
                    ConstBuffer "$Globals" 144
                    Vector 80 [unity_LightmapST]
                    Vector 96 [_MainTex_ST]
                    Vector 112 [_BumpMap_ST]
                    Vector 128 [_ResourceMap_ST]
                    ConstBuffer "UnityPerCamera" 128
                    Vector 64 [_WorldSpaceCameraPos] 3
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 256 [_World2Object]
                    Vector 320 [unity_Scale]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerCamera" 1
                    BindCB  "UnityPerDraw" 2
                    "vs_4_0_level_9_1
                    eefiecedaleloeebggjcenjlcookkpgfcinhlmppabaaaaaafmahaaaaaeaaaaaa
                    daaaaaaagiacaaaapeafaaaalmagaaaaebgpgodjdaacaaaadaacaaaaaaacpopp
                    niabaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaafaa
                    aeaaabaaaaaaaaaaabaaaeaaabaaafaaaaaaaaaaacaaaaaaaeaaagaaaaaaaaaa
                    acaabaaaafaaakaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapja
                    bpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadia
                    adaaapjabpaaaaacafaaaeiaaeaaapjaaeaaaaaeaaaaadoaadaaoejaacaaoeka
                    acaaookaaeaaaaaeaaaaamoaadaaeejaadaaeekaadaaoekaaeaaaaaeabaaadoa
                    adaaoejaaeaaoekaaeaaookaaeaaaaaeabaaamoaaeaabejaabaabekaabaaleka
                    abaaaaacaaaaahiaafaaoekaafaaaaadabaaahiaaaaaffiaalaaoekaaeaaaaae
                    aaaaaliaakaakekaaaaaaaiaabaakeiaaeaaaaaeaaaaahiaamaaoekaaaaakkia
                    aaaapeiaacaaaaadaaaaahiaaaaaoeiaanaaoekaaeaaaaaeaaaaahiaaaaaoeia
                    aoaappkaaaaaoejbaiaaaaadacaaaboaabaaoejaaaaaoeiaabaaaaacabaaahia
                    abaaoejaafaaaaadacaaahiaabaamjiaacaancjaaeaaaaaeabaaahiaacaamjja
                    abaanciaacaaoeibafaaaaadabaaahiaabaaoeiaabaappjaaiaaaaadacaaacoa
                    abaaoeiaaaaaoeiaaiaaaaadacaaaeoaacaaoejaaaaaoeiaafaaaaadaaaaapia
                    aaaaffjaahaaoekaaeaaaaaeaaaaapiaagaaoekaaaaaaajaaaaaoeiaaeaaaaae
                    aaaaapiaaiaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaajaaoekaaaaappja
                    aaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
                    aaaaoeiappppaaaafdeieefcieadaaaaeaaaabaaobaaaaaafjaaaaaeegiocaaa
                    aaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
                    acaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
                    fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaa
                    aeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
                    gfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaagfaaaaadhccabaaa
                    adaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
                    egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
                    aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
                    egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
                    pccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
                    aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
                    agaaaaaaogikcaaaaaaaaaaaagaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaa
                    adaaaaaaagiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaaahaaaaaadcaaaaal
                    dccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaa
                    aaaaaaaaaiaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaaaeaaaaaaagiecaaa
                    aaaaaaaaafaaaaaakgiocaaaaaaaaaaaafaaaaaadiaaaaahhcaabaaaaaaaaaaa
                    jgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaa
                    acaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaa
                    aaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaa
                    fgifcaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaa
                    abaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaa
                    abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaa
                    abaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaa
                    abaaaaaaegiccaaaacaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaa
                    abaaaaaapgipcaaaacaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaah
                    cccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
                    adaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaa
                    egbcbaaaacaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaa
                    aiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
                    apadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeo
                    ehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
                    jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
                    apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaa
                    abaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaimaaaaaaacaaaaaaaaaaaaaa
                    adaaaaaaacaaaaaaamadaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
                    ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
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
                    Vector 24 [_MainTex_ST]
                    Vector 25 [_BumpMap_ST]
                    Vector 26 [_ResourceMap_ST]
                    "!!ARBvp1.0
                    PARAM c[27] = { { 1, 0.5 },
                    state.matrix.mvp,
                    program.local[5..26] };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    MUL R1.xyz, vertex.normal, c[23].w;
                    DP3 R2.w, R1, c[6];
                    DP3 R0.x, R1, c[5];
                    DP3 R0.z, R1, c[7];
                    MOV R0.y, R2.w;
                    MOV R0.w, c[0].x;
                    MUL R1, R0.xyzz, R0.yzzx;
                    DP4 R2.z, R0, c[18];
                    DP4 R2.y, R0, c[17];
                    DP4 R2.x, R0, c[16];
                    MUL R0.w, R2, R2;
                    MAD R0.w, R0.x, R0.x, -R0;
                    DP4 R0.z, R1, c[21];
                    DP4 R0.y, R1, c[20];
                    DP4 R0.x, R1, c[19];
                    ADD R0.xyz, R2, R0;
                    MUL R1.xyz, R0.w, c[22];
                    ADD result.texcoord[3].xyz, R0, R1;
                    MOV R1.xyz, c[13];
                    MOV R1.w, c[0].x;
                    MOV R0.xyz, vertex.attrib[14];
                    DP4 R2.z, R1, c[11];
                    DP4 R2.y, R1, c[10];
                    DP4 R2.x, R1, c[9];
                    MAD R2.xyz, R2, c[23].w, -vertex.position;
                    MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
                    MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
                    MOV R0, c[15];
                    MUL R1.xyz, R1, vertex.attrib[14].w;
                    DP4 R3.z, R0, c[11];
                    DP4 R3.y, R0, c[10];
                    DP4 R3.x, R0, c[9];
                    DP4 R0.w, vertex.position, c[4];
                    DP4 R0.z, vertex.position, c[3];
                    DP4 R0.x, vertex.position, c[1];
                    DP4 R0.y, vertex.position, c[2];
                    DP3 result.texcoord[2].y, R3, R1;
                    DP3 result.texcoord[4].y, R1, R2;
                    MUL R1.xyz, R0.xyww, c[0].y;
                    MUL R1.y, R1, c[14].x;
                    DP3 result.texcoord[2].z, vertex.normal, R3;
                    DP3 result.texcoord[2].x, R3, vertex.attrib[14];
                    DP3 result.texcoord[4].z, vertex.normal, R2;
                    DP3 result.texcoord[4].x, vertex.attrib[14], R2;
                    ADD result.texcoord[5].xy, R1, R1.z;
                    MOV result.position, R0;
                    MOV result.texcoord[5].zw, R0;
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[25].xyxy, c[25];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[24], c[24].zwzw;
                    MAD result.texcoord[1].xy, vertex.texcoord[0], c[26], c[26].zwzw;
                    END
# 50 instructions, 4 R-regs
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
                    Vector 24 [_MainTex_ST]
                    Vector 25 [_BumpMap_ST]
                    Vector 26 [_ResourceMap_ST]
                    "vs_2_0
                    def c27, 1.00000000, 0.50000000, 0, 0
                    dcl_position0 v0
                    dcl_tangent0 v1
                    dcl_normal0 v2
                    dcl_texcoord0 v3
                    mul r1.xyz, v2, c23.w
                    dp3 r2.w, r1, c5
                    dp3 r0.x, r1, c4
                    dp3 r0.z, r1, c6
                    mov r0.y, r2.w
                    mov r0.w, c27.x
                    mul r1, r0.xyzz, r0.yzzx
                    dp4 r2.z, r0, c18
                    dp4 r2.y, r0, c17
                    dp4 r2.x, r0, c16
                    mul r0.w, r2, r2
                    mad r0.w, r0.x, r0.x, -r0
                    dp4 r0.z, r1, c21
                    dp4 r0.y, r1, c20
                    dp4 r0.x, r1, c19
                    mul r1.xyz, r0.w, c22
                    add r0.xyz, r2, r0
                    add oT3.xyz, r0, r1
                    mov r0.w, c27.x
                    mov r0.xyz, c12
                    dp4 r1.z, r0, c10
                    dp4 r1.y, r0, c9
                    dp4 r1.x, r0, c8
                    mad r3.xyz, r1, c23.w, -v0
                    mov r0.xyz, v1
                    mul r1.xyz, v2.zxyw, r0.yzxw
                    mov r0.xyz, v1
                    mad r1.xyz, v2.yzxw, r0.zxyw, -r1
                    mul r2.xyz, r1, v1.w
                    mov r0, c10
                    dp4 r4.z, c15, r0
                    mov r0, c9
                    dp4 r4.y, c15, r0
                    mov r1, c8
                    dp4 r4.x, c15, r1
                    dp4 r0.w, v0, c3
                    dp4 r0.z, v0, c2
                    dp4 r0.x, v0, c0
                    dp4 r0.y, v0, c1
                    mul r1.xyz, r0.xyww, c27.y
                    mul r1.y, r1, c13.x
                    dp3 oT2.y, r4, r2
                    dp3 oT4.y, r2, r3
                    dp3 oT2.z, v2, r4
                    dp3 oT2.x, r4, v1
                    dp3 oT4.z, v2, r3
                    dp3 oT4.x, v1, r3
                    mad oT5.xy, r1.z, c14.zwzw, r1
                    mov oPos, r0
                    mov oT5.zw, r0
                    mad oT0.zw, v3.xyxy, c25.xyxy, c25
                    mad oT0.xy, v3, c24, c24.zwzw
                    mad oT1.xy, v3, c26, c26.zwzw
                    "
                }
                SubProgram "d3d11 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" TexCoord2
                    ConstBuffer "$Globals" 192
                    Vector 144 [_MainTex_ST]
                    Vector 160 [_BumpMap_ST]
                    Vector 176 [_ResourceMap_ST]
                    ConstBuffer "UnityPerCamera" 128
                    Vector 64 [_WorldSpaceCameraPos] 3
                    Vector 80 [_ProjectionParams]
                    ConstBuffer "UnityLighting" 720
                    Vector 0 [_WorldSpaceLightPos0]
                    Vector 608 [unity_SHAr]
                    Vector 624 [unity_SHAg]
                    Vector 640 [unity_SHAb]
                    Vector 656 [unity_SHBr]
                    Vector 672 [unity_SHBg]
                    Vector 688 [unity_SHBb]
                    Vector 704 [unity_SHC]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 192 [_Object2World]
                    Matrix 256 [_World2Object]
                    Vector 320 [unity_Scale]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerCamera" 1
                    BindCB  "UnityLighting" 2
                    BindCB  "UnityPerDraw" 3
                    "vs_4_0
                    eefiecedkcnpfmbebjeiffipecalcifhoneknemnabaaaaaanaaiaaaaadaaaaaa
                    cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
                    abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
                    enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
                    aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaa
                    adaaaaaaacaaaaaaadamaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
                    ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
                    aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
                    adaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
                    aaklklklfdeieefcaeahaaaaeaaaabaambabaaaafjaaaaaeegiocaaaaaaaaaaa
                    amaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
                    cnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
                    fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
                    adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
                    gfaaaaaddccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
                    aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagiaaaaac
                    agaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
                    abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
                    aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
                    acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
                    egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
                    pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
                    adaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadcaaaaal
                    mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaa
                    aaaaaaaaakaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaa
                    aaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaahhcaabaaaabaaaaaa
                    jgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaajgbebaaa
                    acaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaa
                    abaaaaaaegacbaaaabaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaa
                    fgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaa
                    acaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaa
                    acaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaa
                    acaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaa
                    adaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaabaaaaaah
                    cccabaaaadaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaa
                    adaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaaadaaaaaa
                    egbcbaaaacaaaaaaegacbaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaa
                    acaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaadaaaaaafgafbaaa
                    acaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaacaaaaaaegiicaaa
                    adaaaaaaamaaaaaaagaabaaaacaaaaaaegaibaaaadaaaaaadcaaaaakhcaabaaa
                    acaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaacaaaaaaegadbaaaacaaaaaa
                    dgaaaaaficaabaaaacaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaadaaaaaa
                    egiocaaaacaaaaaacgaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaa
                    egiocaaaacaaaaaachaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaa
                    egiocaaaacaaaaaaciaaaaaaegaobaaaacaaaaaadiaaaaahpcaabaaaaeaaaaaa
                    jgacbaaaacaaaaaaegakbaaaacaaaaaabbaaaaaibcaabaaaafaaaaaaegiocaaa
                    acaaaaaacjaaaaaaegaobaaaaeaaaaaabbaaaaaiccaabaaaafaaaaaaegiocaaa
                    acaaaaaackaaaaaaegaobaaaaeaaaaaabbaaaaaiecaabaaaafaaaaaaegiocaaa
                    acaaaaaaclaaaaaaegaobaaaaeaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaa
                    adaaaaaaegacbaaaafaaaaaadiaaaaahicaabaaaabaaaaaabkaabaaaacaaaaaa
                    bkaabaaaacaaaaaadcaaaaakicaabaaaabaaaaaaakaabaaaacaaaaaaakaabaaa
                    acaaaaaadkaabaiaebaaaaaaabaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaa
                    acaaaaaacmaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaadiaaaaajhcaabaaa
                    acaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaal
                    hcaabaaaacaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaa
                    egacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaa
                    kgikcaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaa
                    egacbaaaacaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaacaaaaaa
                    egacbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
                    baaaaaahcccabaaaafaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaah
                    bccabaaaafaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaa
                    afaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaa
                    bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
                    agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
                    mccabaaaagaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaagaaaaaakgakbaaa
                    abaaaaaamgaabaaaabaaaaaadoaaaaab"
                }
                SubProgram "d3d11_9x " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" TexCoord2
                    ConstBuffer "$Globals" 192
                    Vector 144 [_MainTex_ST]
                    Vector 160 [_BumpMap_ST]
                    Vector 176 [_ResourceMap_ST]
                    ConstBuffer "UnityPerCamera" 128
                    Vector 64 [_WorldSpaceCameraPos] 3
                    Vector 80 [_ProjectionParams]
                    ConstBuffer "UnityLighting" 720
                    Vector 0 [_WorldSpaceLightPos0]
                    Vector 608 [unity_SHAr]
                    Vector 624 [unity_SHAg]
                    Vector 640 [unity_SHAb]
                    Vector 656 [unity_SHBr]
                    Vector 672 [unity_SHBg]
                    Vector 688 [unity_SHBb]
                    Vector 704 [unity_SHC]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 192 [_Object2World]
                    Matrix 256 [_World2Object]
                    Vector 320 [unity_Scale]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerCamera" 1
                    BindCB  "UnityLighting" 2
                    BindCB  "UnityPerDraw" 3
                    "vs_4_0_level_9_1
                    eefiecedgikkdgbjngelfoaeceadppfebafoflkpabaaaaaaaianaaaaaeaaaaaa
                    daaaaaaageaeaaaahaalaaaadiamaaaaebgpgodjcmaeaaaacmaeaaaaaaacpopp
                    laadaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaajaa
                    adaaabaaaaaaaaaaabaaaeaaacaaaeaaaaaaaaaaacaaaaaaabaaagaaaaaaaaaa
                    acaacgaaahaaahaaaaaaaaaaadaaaaaaaeaaaoaaaaaaaaaaadaaamaaadaabcaa
                    aaaaaaaaadaabaaaafaabfaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafbkaaapka
                    aaaaiadpaaaaaadpaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaac
                    afaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapja
                    aeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaaeaaaaaeaaaaamoaadaaeeja
                    acaaeekaacaaoekaaeaaaaaeabaaadoaadaaoejaadaaoekaadaaookaabaaaaac
                    aaaaapiaagaaoekaafaaaaadabaaahiaaaaaffiabgaaoekaaeaaaaaeabaaahia
                    bfaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiabhaaoekaaaaakkiaabaaoeia
                    aeaaaaaeaaaaahiabiaaoekaaaaappiaaaaaoeiaaiaaaaadacaaaboaabaaoeja
                    aaaaoeiaabaaaaacabaaahiaacaaoejaafaaaaadacaaahiaabaanciaabaamjja
                    aeaaaaaeabaaahiaabaamjiaabaancjaacaaoeibafaaaaadabaaahiaabaaoeia
                    abaappjaaiaaaaadacaaacoaabaaoeiaaaaaoeiaaiaaaaadacaaaeoaacaaoeja
                    aaaaoeiaabaaaaacaaaaahiaaeaaoekaafaaaaadacaaahiaaaaaffiabgaaoeka
                    aeaaaaaeaaaaaliabfaakekaaaaaaaiaacaakeiaaeaaaaaeaaaaahiabhaaoeka
                    aaaakkiaaaaapeiaacaaaaadaaaaahiaaaaaoeiabiaaoekaaeaaaaaeaaaaahia
                    aaaaoeiabjaappkaaaaaoejbaiaaaaadaeaaaboaabaaoejaaaaaoeiaaiaaaaad
                    aeaaacoaabaaoeiaaaaaoeiaaiaaaaadaeaaaeoaacaaoejaaaaaoeiaafaaaaad
                    aaaaahiaacaaoejabjaappkaafaaaaadabaaahiaaaaaffiabdaaoekaaeaaaaae
                    aaaaaliabcaakekaaaaaaaiaabaakeiaaeaaaaaeaaaaahiabeaaoekaaaaakkia
                    aaaapeiaabaaaaacaaaaaiiabkaaaakaajaaaaadabaaabiaahaaoekaaaaaoeia
                    ajaaaaadabaaaciaaiaaoekaaaaaoeiaajaaaaadabaaaeiaajaaoekaaaaaoeia
                    afaaaaadacaaapiaaaaacjiaaaaakeiaajaaaaadadaaabiaakaaoekaacaaoeia
                    ajaaaaadadaaaciaalaaoekaacaaoeiaajaaaaadadaaaeiaamaaoekaacaaoeia
                    acaaaaadabaaahiaabaaoeiaadaaoeiaafaaaaadaaaaaciaaaaaffiaaaaaffia
                    aeaaaaaeaaaaabiaaaaaaaiaaaaaaaiaaaaaffibaeaaaaaeadaaahoaanaaoeka
                    aaaaaaiaabaaoeiaafaaaaadaaaaapiaaaaaffjaapaaoekaaeaaaaaeaaaaapia
                    aoaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiabaaaoekaaaaakkjaaaaaoeia
                    aeaaaaaeaaaaapiabbaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffia
                    afaaaakaafaaaaadabaaaiiaabaaaaiabkaaffkaafaaaaadabaaafiaaaaapeia
                    bkaaffkaacaaaaadafaaadoaabaakkiaabaaomiaaeaaaaaeaaaaadmaaaaappia
                    aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacafaaamoaaaaaoeia
                    ppppaaaafdeieefcaeahaaaaeaaaabaambabaaaafjaaaaaeegiocaaaaaaaaaaa
                    amaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
                    cnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
                    fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
                    adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
                    gfaaaaaddccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
                    aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagiaaaaac
                    agaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
                    abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
                    aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
                    acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
                    egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
                    pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
                    adaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadcaaaaal
                    mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaa
                    aaaaaaaaakaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaa
                    aaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaahhcaabaaaabaaaaaa
                    jgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaajgbebaaa
                    acaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaa
                    abaaaaaaegacbaaaabaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaa
                    fgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaa
                    acaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaa
                    acaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaa
                    acaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaa
                    adaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaabaaaaaah
                    cccabaaaadaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaa
                    adaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaaadaaaaaa
                    egbcbaaaacaaaaaaegacbaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaa
                    acaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaadaaaaaafgafbaaa
                    acaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaacaaaaaaegiicaaa
                    adaaaaaaamaaaaaaagaabaaaacaaaaaaegaibaaaadaaaaaadcaaaaakhcaabaaa
                    acaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaacaaaaaaegadbaaaacaaaaaa
                    dgaaaaaficaabaaaacaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaadaaaaaa
                    egiocaaaacaaaaaacgaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaa
                    egiocaaaacaaaaaachaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaa
                    egiocaaaacaaaaaaciaaaaaaegaobaaaacaaaaaadiaaaaahpcaabaaaaeaaaaaa
                    jgacbaaaacaaaaaaegakbaaaacaaaaaabbaaaaaibcaabaaaafaaaaaaegiocaaa
                    acaaaaaacjaaaaaaegaobaaaaeaaaaaabbaaaaaiccaabaaaafaaaaaaegiocaaa
                    acaaaaaackaaaaaaegaobaaaaeaaaaaabbaaaaaiecaabaaaafaaaaaaegiocaaa
                    acaaaaaaclaaaaaaegaobaaaaeaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaa
                    adaaaaaaegacbaaaafaaaaaadiaaaaahicaabaaaabaaaaaabkaabaaaacaaaaaa
                    bkaabaaaacaaaaaadcaaaaakicaabaaaabaaaaaaakaabaaaacaaaaaaakaabaaa
                    acaaaaaadkaabaiaebaaaaaaabaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaa
                    acaaaaaacmaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaadiaaaaajhcaabaaa
                    acaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaal
                    hcaabaaaacaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaa
                    egacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaa
                    kgikcaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaa
                    egacbaaaacaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaacaaaaaa
                    egacbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
                    baaaaaahcccabaaaafaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaah
                    bccabaaaafaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaa
                    afaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaa
                    bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
                    agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
                    mccabaaaagaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaagaaaaaakgakbaaa
                    abaaaaaamgaabaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
                    jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
                    aaaaaaaaadaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
                    acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
                    laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaa
                    aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
                    aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaa
                    ahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
                    lmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaa
                    aaaaaaaaadaaaaaaacaaaaaaadamaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaa
                    adaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaa
                    lmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaa
                    aaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffied
                    epepfceeaaklklkl"
                }
                SubProgram "opengl " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
                    Bind "vertex" Vertex
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    Vector 13 [_ProjectionParams]
                    Vector 15 [unity_LightmapST]
                    Vector 16 [_MainTex_ST]
                    Vector 17 [_BumpMap_ST]
                    Vector 18 [_ResourceMap_ST]
                    "!!ARBvp1.0
                    PARAM c[19] = { { 0.5 },
                    state.matrix.mvp,
                    program.local[5..18] };
                    TEMP R0;
                    TEMP R1;
                    DP4 R0.w, vertex.position, c[4];
                    DP4 R0.z, vertex.position, c[3];
                    DP4 R0.x, vertex.position, c[1];
                    DP4 R0.y, vertex.position, c[2];
                    MUL R1.xyz, R0.xyww, c[0].x;
                    MUL R1.y, R1, c[13].x;
                    ADD result.texcoord[3].xy, R1, R1.z;
                    MOV result.position, R0;
                    MOV result.texcoord[3].zw, R0;
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[17].xyxy, c[17];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
                    MAD result.texcoord[1].xy, vertex.texcoord[0], c[18], c[18].zwzw;
                    MAD result.texcoord[2].xy, vertex.texcoord[1], c[15], c[15].zwzw;
                    END
# 13 instructions, 2 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
                    Bind "vertex" Vertex
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    Matrix 0 [glstate_matrix_mvp]
                    Vector 12 [_ProjectionParams]
                    Vector 13 [_ScreenParams]
                    Vector 14 [unity_LightmapST]
                    Vector 15 [_MainTex_ST]
                    Vector 16 [_BumpMap_ST]
                    Vector 17 [_ResourceMap_ST]
                    "vs_2_0
                    def c18, 0.50000000, 0, 0, 0
                    dcl_position0 v0
                    dcl_texcoord0 v3
                    dcl_texcoord1 v4
                    dp4 r0.w, v0, c3
                    dp4 r0.z, v0, c2
                    dp4 r0.x, v0, c0
                    dp4 r0.y, v0, c1
                    mul r1.xyz, r0.xyww, c18.x
                    mul r1.y, r1, c12.x
                    mad oT3.xy, r1.z, c13.zwzw, r1
                    mov oPos, r0
                    mov oT3.zw, r0
                    mad oT0.zw, v3.xyxy, c16.xyxy, c16
                    mad oT0.xy, v3, c15, c15.zwzw
                    mad oT1.xy, v3, c17, c17.zwzw
                    mad oT2.xy, v4, c14, c14.zwzw
                    "
                }
                SubProgram "d3d11 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    ConstBuffer "$Globals" 208
                    Vector 144 [unity_LightmapST]
                    Vector 160 [_MainTex_ST]
                    Vector 176 [_BumpMap_ST]
                    Vector 192 [_ResourceMap_ST]
                    ConstBuffer "UnityPerCamera" 128
                    Vector 80 [_ProjectionParams]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerCamera" 1
                    BindCB  "UnityPerDraw" 2
                    "vs_4_0
                    eefiecedocfpikmogagdjiglmpjkpnecmpgaejffabaaaaaabiaeaaaaadaaaaaa
                    cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
                    abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
                    enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
                    aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
                    adaaaaaaacaaaaaaadamaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    amadaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfa
                    epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchmacaaaaeaaaabaa
                    jpaaaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaa
                    agaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
                    fpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaa
                    aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
                    gfaaaaadmccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaa
                    diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
                    dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
                    egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
                    kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
                    acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
                    aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
                    egiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaadcaaaaalmccabaaa
                    abaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaalaaaaaakgiocaaaaaaaaaaa
                    alaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
                    amaaaaaaogikcaaaaaaaaaaaamaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
                    aeaaaaaaagiecaaaaaaaaaaaajaaaaaakgiocaaaaaaaaaaaajaaaaaadiaaaaai
                    ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
                    ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
                    aaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaa
                    adaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab"
                }
                SubProgram "d3d11_9x " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    ConstBuffer "$Globals" 208
                    Vector 144 [unity_LightmapST]
                    Vector 160 [_MainTex_ST]
                    Vector 176 [_BumpMap_ST]
                    Vector 192 [_ResourceMap_ST]
                    ConstBuffer "UnityPerCamera" 128
                    Vector 80 [_ProjectionParams]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerCamera" 1
                    BindCB  "UnityPerDraw" 2
                    "vs_4_0_level_9_1
                    eefiecedoiolokhigamhihgpdoakmoockcccacbnabaaaaaalmafaaaaaeaaaaaa
                    daaaaaaanaabaaaafeaeaaaabmafaaaaebgpgodjjiabaaaajiabaaaaaaacpopp
                    emabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaajaa
                    aeaaabaaaaaaaaaaabaaafaaabaaafaaaaaaaaaaacaaaaaaaeaaagaaaaaaaaaa
                    aaaaaaaaaaacpoppfbaaaaafakaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
                    bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeia
                    aeaaapjaaeaaaaaeaaaaadoaadaaoejaacaaoekaacaaookaaeaaaaaeaaaaamoa
                    adaaeejaadaaeekaadaaoekaaeaaaaaeabaaadoaadaaoejaaeaaoekaaeaaooka
                    aeaaaaaeabaaamoaaeaabejaabaabekaabaalekaafaaaaadaaaaapiaaaaaffja
                    ahaaoekaaeaaaaaeaaaaapiaagaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
                    aiaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaajaaoekaaaaappjaaaaaoeia
                    afaaaaadabaaabiaaaaaffiaafaaaakaafaaaaadabaaaiiaabaaaaiaakaaaaka
                    afaaaaadabaaafiaaaaapeiaakaaaakaacaaaaadacaaadoaabaakkiaabaaomia
                    aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
                    abaaaaacacaaamoaaaaaoeiappppaaaafdeieefchmacaaaaeaaaabaajpaaaaaa
                    fjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
                    fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
                    dcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaa
                    abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaad
                    mccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
                    pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
                    pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
                    aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
                    aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
                    adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
                    egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
                    aaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaadcaaaaalmccabaaaabaaaaaa
                    agbebaaaadaaaaaaagiecaaaaaaaaaaaalaaaaaakgiocaaaaaaaaaaaalaaaaaa
                    dcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaamaaaaaa
                    ogikcaaaaaaaaaaaamaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaaaeaaaaaa
                    agiecaaaaaaaaaaaajaaaaaakgiocaaaaaaaaaaaajaaaaaadiaaaaaiccaabaaa
                    aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
                    abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
                    dgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaa
                    kgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaa
                    aiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaacaaaaaaahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
                    apadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeo
                    ehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
                    jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
                    apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaa
                    abaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaimaaaaaaacaaaaaaaaaaaaaa
                    adaaaaaaacaaaaaaamadaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
                    apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
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
                    Vector 17 [unity_LightmapST]
                    Vector 18 [_MainTex_ST]
                    Vector 19 [_BumpMap_ST]
                    Vector 20 [_ResourceMap_ST]
                    "!!ARBvp1.0
                    PARAM c[21] = { { 1, 0.5 },
                    state.matrix.mvp,
                    program.local[5..20] };
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
                    DP3 result.texcoord[3].y, R2, R0;
                    DP4 R0.z, vertex.position, c[3];
                    DP4 R0.x, vertex.position, c[1];
                    DP4 R0.y, vertex.position, c[2];
                    MUL R1.xyz, R0.xyww, c[0].y;
                    MUL R1.y, R1, c[14].x;
                    DP3 result.texcoord[3].z, vertex.normal, R2;
                    DP3 result.texcoord[3].x, R2, vertex.attrib[14];
                    ADD result.texcoord[4].xy, R1, R1.z;
                    MOV result.position, R0;
                    MOV result.texcoord[4].zw, R0;
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
                    MAD result.texcoord[1].xy, vertex.texcoord[0], c[20], c[20].zwzw;
                    MAD result.texcoord[2].xy, vertex.texcoord[1], c[17], c[17].zwzw;
                    END
# 26 instructions, 3 R-regs
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
                    Vector 16 [unity_LightmapST]
                    Vector 17 [_MainTex_ST]
                    Vector 18 [_BumpMap_ST]
                    Vector 19 [_ResourceMap_ST]
                    "vs_2_0
                    def c20, 1.00000000, 0.50000000, 0, 0
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
                    mov r1.w, c20.x
                    dp4 r0.w, v0, c3
                    dp4 r2.z, r1, c10
                    dp4 r2.x, r1, c8
                    dp4 r2.y, r1, c9
                    mad r2.xyz, r2, c15.w, -v0
                    dp3 oT3.y, r2, r0
                    dp4 r0.z, v0, c2
                    dp4 r0.x, v0, c0
                    dp4 r0.y, v0, c1
                    mul r1.xyz, r0.xyww, c20.y
                    mul r1.y, r1, c13.x
                    dp3 oT3.z, v2, r2
                    dp3 oT3.x, r2, v1
                    mad oT4.xy, r1.z, c14.zwzw, r1
                    mov oPos, r0
                    mov oT4.zw, r0
                    mad oT0.zw, v3.xyxy, c18.xyxy, c18
                    mad oT0.xy, v3, c17, c17.zwzw
                    mad oT1.xy, v3, c19, c19.zwzw
                    mad oT2.xy, v4, c16, c16.zwzw
                    "
                }
                SubProgram "d3d11 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    Bind "tangent" TexCoord2
                    ConstBuffer "$Globals" 208
                    Vector 144 [unity_LightmapST]
                    Vector 160 [_MainTex_ST]
                    Vector 176 [_BumpMap_ST]
                    Vector 192 [_ResourceMap_ST]
                    ConstBuffer "UnityPerCamera" 128
                    Vector 64 [_WorldSpaceCameraPos] 3
                    Vector 80 [_ProjectionParams]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 256 [_World2Object]
                    Vector 320 [unity_Scale]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerCamera" 1
                    BindCB  "UnityPerDraw" 2
                    "vs_4_0
                    eefiecediaeallgaoiojldlokkneeiaolkhkdkgkabaaaaaanaafaaaaadaaaaaa
                    cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
                    abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
                    enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
                    aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
                    adaaaaaaacaaaaaaadamaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    amadaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaa
                    aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
                    feeffiedepepfceeaaklklklfdeieefcbmaeaaaaeaaaabaaahabaaaafjaaaaae
                    egiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
                    egiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
                    abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
                    dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
                    abaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaagfaaaaad
                    hccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacadaaaaaadiaaaaai
                    pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
                    pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
                    aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
                    aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
                    adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
                    egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
                    aaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaadcaaaaalmccabaaaabaaaaaa
                    agbebaaaadaaaaaaagiecaaaaaaaaaaaalaaaaaakgiocaaaaaaaaaaaalaaaaaa
                    dcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaamaaaaaa
                    ogikcaaaaaaaaaaaamaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaaaeaaaaaa
                    agiecaaaaaaaaaaaajaaaaaakgiocaaaaaaaaaaaajaaaaaadiaaaaahhcaabaaa
                    abaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaa
                    jgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaah
                    hcaabaaaabaaaaaaegacbaaaabaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaa
                    acaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaal
                    hcaabaaaacaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaa
                    egacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaacaaaaaabcaaaaaa
                    kgikcaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaa
                    egacbaaaacaaaaaaegiccaaaacaaaaaabdaaaaaadcaaaaalhcaabaaaacaaaaaa
                    egacbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
                    baaaaaahcccabaaaadaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaah
                    bccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaa
                    adaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaa
                    bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
                    agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
                    mccabaaaaeaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaa
                    abaaaaaamgaabaaaabaaaaaadoaaaaab"
                }
                SubProgram "d3d11_9x " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    Bind "tangent" TexCoord2
                    ConstBuffer "$Globals" 208
                    Vector 144 [unity_LightmapST]
                    Vector 160 [_MainTex_ST]
                    Vector 176 [_BumpMap_ST]
                    Vector 192 [_ResourceMap_ST]
                    ConstBuffer "UnityPerCamera" 128
                    Vector 64 [_WorldSpaceCameraPos] 3
                    Vector 80 [_ProjectionParams]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 256 [_World2Object]
                    Vector 320 [unity_Scale]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerCamera" 1
                    BindCB  "UnityPerDraw" 2
                    "vs_4_0_level_9_1
                    eefiecedhbbiejbjnpfmgfgepmccolpdddnfbiekabaaaaaahaaiaaaaaeaaaaaa
                    daaaaaaammacaaaapaagaaaaliahaaaaebgpgodjjeacaaaajeacaaaaaaacpopp
                    dmacaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaajaa
                    aeaaabaaaaaaaaaaabaaaeaaacaaafaaaaaaaaaaacaaaaaaaeaaahaaaaaaaaaa
                    acaabaaaafaaalaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafbaaaapkaaaaaaadp
                    aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabia
                    abaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjabpaaaaac
                    afaaaeiaaeaaapjaaeaaaaaeaaaaadoaadaaoejaacaaoekaacaaookaaeaaaaae
                    aaaaamoaadaaeejaadaaeekaadaaoekaaeaaaaaeabaaadoaadaaoejaaeaaoeka
                    aeaaookaaeaaaaaeabaaamoaaeaabejaabaabekaabaalekaabaaaaacaaaaahia
                    afaaoekaafaaaaadabaaahiaaaaaffiaamaaoekaaeaaaaaeaaaaaliaalaakeka
                    aaaaaaiaabaakeiaaeaaaaaeaaaaahiaanaaoekaaaaakkiaaaaapeiaacaaaaad
                    aaaaahiaaaaaoeiaaoaaoekaaeaaaaaeaaaaahiaaaaaoeiaapaappkaaaaaoejb
                    aiaaaaadacaaaboaabaaoejaaaaaoeiaabaaaaacabaaahiaabaaoejaafaaaaad
                    acaaahiaabaamjiaacaancjaaeaaaaaeabaaahiaacaamjjaabaanciaacaaoeib
                    afaaaaadabaaahiaabaaoeiaabaappjaaiaaaaadacaaacoaabaaoeiaaaaaoeia
                    aiaaaaadacaaaeoaacaaoejaaaaaoeiaafaaaaadaaaaapiaaaaaffjaaiaaoeka
                    aeaaaaaeaaaaapiaahaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaajaaoeka
                    aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaakaaoekaaaaappjaaaaaoeiaafaaaaad
                    abaaabiaaaaaffiaagaaaakaafaaaaadabaaaiiaabaaaaiabaaaaakaafaaaaad
                    abaaafiaaaaapeiabaaaaakaacaaaaadadaaadoaabaakkiaabaaomiaaeaaaaae
                    aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
                    adaaamoaaaaaoeiappppaaaafdeieefcbmaeaaaaeaaaabaaahabaaaafjaaaaae
                    egiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
                    egiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
                    abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
                    dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
                    abaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaagfaaaaad
                    hccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacadaaaaaadiaaaaai
                    pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
                    pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
                    aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
                    aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
                    adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
                    egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
                    aaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaadcaaaaalmccabaaaabaaaaaa
                    agbebaaaadaaaaaaagiecaaaaaaaaaaaalaaaaaakgiocaaaaaaaaaaaalaaaaaa
                    dcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaamaaaaaa
                    ogikcaaaaaaaaaaaamaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaaaeaaaaaa
                    agiecaaaaaaaaaaaajaaaaaakgiocaaaaaaaaaaaajaaaaaadiaaaaahhcaabaaa
                    abaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaa
                    jgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaah
                    hcaabaaaabaaaaaaegacbaaaabaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaa
                    acaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaal
                    hcaabaaaacaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaa
                    egacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaacaaaaaabcaaaaaa
                    kgikcaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaa
                    egacbaaaacaaaaaaegiccaaaacaaaaaabdaaaaaadcaaaaalhcaabaaaacaaaaaa
                    egacbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
                    baaaaaahcccabaaaadaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaah
                    bccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaa
                    adaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaa
                    bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
                    agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
                    mccabaaaaeaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaa
                    abaaaaaamgaabaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
                    jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
                    aaaaaaaaadaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
                    acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
                    laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaa
                    aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
                    aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaa
                    agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
                    keaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaa
                    aaaaaaaaadaaaaaaacaaaaaaadamaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaa
                    acaaaaaaamadaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaa
                    keaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfe
                    ejepeoaafeeffiedepepfceeaaklklkl"
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
                    Vector 31 [_MainTex_ST]
                    Vector 32 [_BumpMap_ST]
                    Vector 33 [_ResourceMap_ST]
                    "!!ARBvp1.0
                    PARAM c[34] = { { 1, 0 },
                    state.matrix.mvp,
                    program.local[5..33] };
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
                    MUL R1.w, R3, R3;
                    DP4 R3.z, R0, c[28];
                    DP4 R3.y, R0, c[27];
                    DP4 R3.x, R0, c[26];
                    MAD R1.w, R4.x, R4.x, -R1;
                    MUL R0.xyz, R1.w, c[29];
                    MOV R1.w, c[0].x;
                    DP4 R2.z, R4, c[25];
                    DP4 R2.y, R4, c[24];
                    DP4 R2.x, R4, c[23];
                    ADD R2.xyz, R2, R3;
                    ADD R0.xyz, R2, R0;
                    ADD result.texcoord[3].xyz, R0, R1;
                    MOV R1.xyz, c[13];
                    DP4 R2.z, R1, c[11];
                    DP4 R2.y, R1, c[10];
                    DP4 R2.x, R1, c[9];
                    MAD R2.xyz, R2, c[30].w, -vertex.position;
                    MOV R0.xyz, vertex.attrib[14];
                    MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
                    MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
                    MOV R1, c[14];
                    MUL R0.xyz, R0, vertex.attrib[14].w;
                    DP4 R3.z, R1, c[11];
                    DP4 R3.y, R1, c[10];
                    DP4 R3.x, R1, c[9];
                    DP3 result.texcoord[2].y, R3, R0;
                    DP3 result.texcoord[4].y, R0, R2;
                    DP3 result.texcoord[2].z, vertex.normal, R3;
                    DP3 result.texcoord[2].x, R3, vertex.attrib[14];
                    DP3 result.texcoord[4].z, vertex.normal, R2;
                    DP3 result.texcoord[4].x, vertex.attrib[14], R2;
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[32].xyxy, c[32];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[31], c[31].zwzw;
                    MAD result.texcoord[1].xy, vertex.texcoord[0], c[33], c[33].zwzw;
                    DP4 result.position.w, vertex.position, c[4];
                    DP4 result.position.z, vertex.position, c[3];
                    DP4 result.position.y, vertex.position, c[2];
                    DP4 result.position.x, vertex.position, c[1];
                    END
# 76 instructions, 5 R-regs
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
                    Vector 30 [_MainTex_ST]
                    Vector 31 [_BumpMap_ST]
                    Vector 32 [_ResourceMap_ST]
                    "vs_2_0
                    def c33, 1.00000000, 0.00000000, 0, 0
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
                    mov r4.w, c33.x
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
                    add r1, r2, c33.x
                    dp4 r2.z, r4, c24
                    dp4 r2.y, r4, c23
                    dp4 r2.x, r4, c22
                    rcp r1.x, r1.x
                    rcp r1.y, r1.y
                    rcp r1.w, r1.w
                    rcp r1.z, r1.z
                    max r0, r0, c33.y
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
                    add r0.xyz, r2, r0
                    add oT3.xyz, r0, r1
                    mov r1.w, c33.x
                    mov r1.xyz, c12
                    dp4 r0.z, r1, c10
                    dp4 r0.y, r1, c9
                    dp4 r0.x, r1, c8
                    mad r3.xyz, r0, c29.w, -v0
                    mov r1.xyz, v1
                    mov r0.xyz, v1
                    mul r1.xyz, v2.zxyw, r1.yzxw
                    mad r1.xyz, v2.yzxw, r0.zxyw, -r1
                    mul r2.xyz, r1, v1.w
                    mov r0, c10
                    dp4 r4.z, c13, r0
                    mov r1, c9
                    mov r0, c8
                    dp4 r4.y, c13, r1
                    dp4 r4.x, c13, r0
                    dp3 oT2.y, r4, r2
                    dp3 oT4.y, r2, r3
                    dp3 oT2.z, v2, r4
                    dp3 oT2.x, r4, v1
                    dp3 oT4.z, v2, r3
                    dp3 oT4.x, v1, r3
                    mad oT0.zw, v3.xyxy, c31.xyxy, c31
                    mad oT0.xy, v3, c30, c30.zwzw
                    mad oT1.xy, v3, c32, c32.zwzw
                    dp4 oPos.w, v0, c3
                    dp4 oPos.z, v0, c2
                    dp4 oPos.y, v0, c1
                    dp4 oPos.x, v0, c0
                    "
                }
                SubProgram "d3d11 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" TexCoord2
                    ConstBuffer "$Globals" 128
                    Vector 80 [_MainTex_ST]
                    Vector 96 [_BumpMap_ST]
                    Vector 112 [_ResourceMap_ST]
                    ConstBuffer "UnityPerCamera" 128
                    Vector 64 [_WorldSpaceCameraPos] 3
                    ConstBuffer "UnityLighting" 720
                    Vector 0 [_WorldSpaceLightPos0]
                    Vector 32 [unity_4LightPosX0]
                    Vector 48 [unity_4LightPosY0]
                    Vector 64 [unity_4LightPosZ0]
                    Vector 80 [unity_4LightAtten0]
                    Vector 96 [unity_LightColor0]
                    Vector 112 [unity_LightColor1]
                    Vector 128 [unity_LightColor2]
                    Vector 144 [unity_LightColor3]
                    Vector 160 [unity_LightColor4]
                    Vector 176 [unity_LightColor5]
                    Vector 192 [unity_LightColor6]
                    Vector 208 [unity_LightColor7]
                    Vector 608 [unity_SHAr]
                    Vector 624 [unity_SHAg]
                    Vector 640 [unity_SHAb]
                    Vector 656 [unity_SHBr]
                    Vector 672 [unity_SHBg]
                    Vector 688 [unity_SHBb]
                    Vector 704 [unity_SHC]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 192 [_Object2World]
                    Matrix 256 [_World2Object]
                    Vector 320 [unity_Scale]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerCamera" 1
                    BindCB  "UnityLighting" 2
                    BindCB  "UnityPerDraw" 3
                    "vs_4_0
                    eefiecedmbjkgdopcfohmphcidnpljiamfedeoikabaaaaaahaalaaaaadaaaaaa
                    cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
                    abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
                    enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
                    aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
                    adaaaaaaacaaaaaaadamaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
                    ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
                    aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
                    feeffiedepepfceeaaklklklfdeieefclmajaaaaeaaaabaagpacaaaafjaaaaae
                    egiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
                    egiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
                    pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
                    fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
                    pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
                    gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacahaaaaaa
                    diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
                    dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaa
                    egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaa
                    kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
                    adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
                    abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaa
                    afaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
                    agaaaaaakgiocaaaaaaaaaaaagaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
                    adaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaadiaaaaah
                    hcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaa
                    aaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaa
                    diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaaj
                    hcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaa
                    dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaa
                    aaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
                    bcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
                    abaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaa
                    abaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
                    baaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
                    eccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadgaaaaaficaabaaa
                    abaaaaaaabeaaaaaaaaaiadpdiaaaaaihcaabaaaacaaaaaaegbcbaaaacaaaaaa
                    pgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaadaaaaaafgafbaaaacaaaaaa
                    egiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaacaaaaaaegiicaaaadaaaaaa
                    amaaaaaaagaabaaaacaaaaaaegaibaaaadaaaaaadcaaaaakhcaabaaaabaaaaaa
                    egiccaaaadaaaaaaaoaaaaaakgakbaaaacaaaaaaegadbaaaacaaaaaabbaaaaai
                    bcaabaaaacaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaabbaaaaai
                    ccaabaaaacaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaabbaaaaai
                    ecaabaaaacaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaadiaaaaah
                    pcaabaaaadaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaa
                    aeaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaa
                    aeaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaa
                    aeaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaadaaaaaaaaaaaaahhcaabaaa
                    acaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaaaaaaaaaa
                    bkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaa
                    abaaaaaaakaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaadcaaaaakhcaabaaa
                    acaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaa
                    diaaaaaihcaabaaaadaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
                    dcaaaaakhcaabaaaadaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
                    egacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaadaaaaaaaoaaaaaa
                    kgbkbaaaaaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaa
                    adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaadaaaaaaaaaaaaajpcaabaaa
                    aeaaaaaafgafbaiaebaaaaaaadaaaaaaegiocaaaacaaaaaaadaaaaaadiaaaaah
                    pcaabaaaafaaaaaafgafbaaaabaaaaaaegaobaaaaeaaaaaadiaaaaahpcaabaaa
                    aeaaaaaaegaobaaaaeaaaaaaegaobaaaaeaaaaaaaaaaaaajpcaabaaaagaaaaaa
                    agaabaiaebaaaaaaadaaaaaaegiocaaaacaaaaaaacaaaaaaaaaaaaajpcaabaaa
                    adaaaaaakgakbaiaebaaaaaaadaaaaaaegiocaaaacaaaaaaaeaaaaaadcaaaaaj
                    pcaabaaaafaaaaaaegaobaaaagaaaaaaagaabaaaabaaaaaaegaobaaaafaaaaaa
                    dcaaaaajpcaabaaaabaaaaaaegaobaaaadaaaaaakgakbaaaabaaaaaaegaobaaa
                    afaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaaagaaaaaaegaobaaaagaaaaaa
                    egaobaaaaeaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaa
                    adaaaaaaegaobaaaaeaaaaaaeeaaaaafpcaabaaaaeaaaaaaegaobaaaadaaaaaa
                    dcaaaaanpcaabaaaadaaaaaaegaobaaaadaaaaaaegiocaaaacaaaaaaafaaaaaa
                    aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaadaaaaaa
                    aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaadaaaaaadiaaaaah
                    pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaaeaaaaaadeaaaaakpcaabaaa
                    abaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
                    diaaaaahpcaabaaaabaaaaaaegaobaaaadaaaaaaegaobaaaabaaaaaadiaaaaai
                    hcaabaaaadaaaaaafgafbaaaabaaaaaaegiccaaaacaaaaaaahaaaaaadcaaaaak
                    hcaabaaaadaaaaaaegiccaaaacaaaaaaagaaaaaaagaabaaaabaaaaaaegacbaaa
                    adaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaiaaaaaakgakbaaa
                    abaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
                    ajaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaahhccabaaaaeaaaaaa
                    egacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaa
                    abaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaa
                    egiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
                    dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaa
                    aeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
                    egiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaa
                    pgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaa
                    afaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaafaaaaaa
                    egbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaafaaaaaaegbcbaaa
                    acaaaaaaegacbaaaabaaaaaadoaaaaab"
                }
                SubProgram "d3d11_9x " {
                    Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" TexCoord2
                    ConstBuffer "$Globals" 128
                    Vector 80 [_MainTex_ST]
                    Vector 96 [_BumpMap_ST]
                    Vector 112 [_ResourceMap_ST]
                    ConstBuffer "UnityPerCamera" 128
                    Vector 64 [_WorldSpaceCameraPos] 3
                    ConstBuffer "UnityLighting" 720
                    Vector 0 [_WorldSpaceLightPos0]
                    Vector 32 [unity_4LightPosX0]
                    Vector 48 [unity_4LightPosY0]
                    Vector 64 [unity_4LightPosZ0]
                    Vector 80 [unity_4LightAtten0]
                    Vector 96 [unity_LightColor0]
                    Vector 112 [unity_LightColor1]
                    Vector 128 [unity_LightColor2]
                    Vector 144 [unity_LightColor3]
                    Vector 160 [unity_LightColor4]
                    Vector 176 [unity_LightColor5]
                    Vector 192 [unity_LightColor6]
                    Vector 208 [unity_LightColor7]
                    Vector 608 [unity_SHAr]
                    Vector 624 [unity_SHAg]
                    Vector 640 [unity_SHAb]
                    Vector 656 [unity_SHBr]
                    Vector 672 [unity_SHBg]
                    Vector 688 [unity_SHBb]
                    Vector 704 [unity_SHC]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 192 [_Object2World]
                    Matrix 256 [_World2Object]
                    Vector 320 [unity_Scale]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerCamera" 1
                    BindCB  "UnityLighting" 2
                    BindCB  "UnityPerDraw" 3
                    "vs_4_0_level_9_1
                    eefiecediagjboljjgfcniikhjpohhmdeolcfjlbabaaaaaafebbaaaaaeaaaaaa
                    daaaaaaabaagaaaaneapaaaajmbaaaaaebgpgodjniafaaaaniafaaaaaaacpopp
                    fmafaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaafaa
                    adaaabaaaaaaaaaaabaaaeaaabaaaeaaaaaaaaaaacaaaaaaabaaafaaaaaaaaaa
                    acaaacaaaiaaagaaaaaaaaaaacaacgaaahaaaoaaaaaaaaaaadaaaaaaaeaabfaa
                    aaaaaaaaadaaamaaajaabjaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafccaaapka
                    aaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaac
                    afaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapja
                    aeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaaeaaaaaeaaaaamoaadaaeeja
                    acaaeekaacaaoekaaeaaaaaeabaaadoaadaaoejaadaaoekaadaaookaabaaaaac
                    aaaaapiaafaaoekaafaaaaadabaaahiaaaaaffiaboaaoekaaeaaaaaeabaaahia
                    bnaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiabpaaoekaaaaakkiaabaaoeia
                    aeaaaaaeaaaaahiacaaaoekaaaaappiaaaaaoeiaaiaaaaadacaaaboaabaaoeja
                    aaaaoeiaabaaaaacabaaahiaacaaoejaafaaaaadacaaahiaabaanciaabaamjja
                    aeaaaaaeabaaahiaabaamjiaabaancjaacaaoeibafaaaaadabaaahiaabaaoeia
                    abaappjaaiaaaaadacaaacoaabaaoeiaaaaaoeiaaiaaaaadacaaaeoaacaaoeja
                    aaaaoeiaabaaaaacaaaaahiaaeaaoekaafaaaaadacaaahiaaaaaffiaboaaoeka
                    aeaaaaaeaaaaaliabnaakekaaaaaaaiaacaakeiaaeaaaaaeaaaaahiabpaaoeka
                    aaaakkiaaaaapeiaacaaaaadaaaaahiaaaaaoeiacaaaoekaaeaaaaaeaaaaahia
                    aaaaoeiacbaappkaaaaaoejbaiaaaaadaeaaaboaabaaoejaaaaaoeiaaiaaaaad
                    aeaaacoaabaaoeiaaaaaoeiaaiaaaaadaeaaaeoaacaaoejaaaaaoeiaafaaaaad
                    aaaaahiaaaaaffjabkaaoekaaeaaaaaeaaaaahiabjaaoekaaaaaaajaaaaaoeia
                    aeaaaaaeaaaaahiablaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahiabmaaoeka
                    aaaappjaaaaaoeiaacaaaaadabaaapiaaaaakkibaiaaoekaacaaaaadacaaapia
                    aaaaaaibagaaoekaacaaaaadaaaaapiaaaaaffibahaaoekaafaaaaadadaaahia
                    acaaoejacbaappkaafaaaaadaeaaahiaadaaffiabkaaoekaaeaaaaaeadaaalia
                    bjaakekaadaaaaiaaeaakeiaaeaaaaaeadaaahiablaaoekaadaakkiaadaapeia
                    afaaaaadaeaaapiaaaaaoeiaadaaffiaafaaaaadaaaaapiaaaaaoeiaaaaaoeia
                    aeaaaaaeaaaaapiaacaaoeiaacaaoeiaaaaaoeiaaeaaaaaeacaaapiaacaaoeia
                    adaaaaiaaeaaoeiaaeaaaaaeacaaapiaabaaoeiaadaakkiaacaaoeiaaeaaaaae
                    aaaaapiaabaaoeiaabaaoeiaaaaaoeiaahaaaaacabaaabiaaaaaaaiaahaaaaac
                    abaaaciaaaaaffiaahaaaaacabaaaeiaaaaakkiaahaaaaacabaaaiiaaaaappia
                    abaaaaacaeaaabiaccaaaakaaeaaaaaeaaaaapiaaaaaoeiaajaaoekaaeaaaaia
                    afaaaaadabaaapiaabaaoeiaacaaoeiaalaaaaadabaaapiaabaaoeiaccaaffka
                    agaaaaacacaaabiaaaaaaaiaagaaaaacacaaaciaaaaaffiaagaaaaacacaaaeia
                    aaaakkiaagaaaaacacaaaiiaaaaappiaafaaaaadaaaaapiaabaaoeiaacaaoeia
                    afaaaaadabaaahiaaaaaffiaalaaoekaaeaaaaaeabaaahiaakaaoekaaaaaaaia
                    abaaoeiaaeaaaaaeaaaaahiaamaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaahia
                    anaaoekaaaaappiaaaaaoeiaabaaaaacadaaaiiaccaaaakaajaaaaadabaaabia
                    aoaaoekaadaaoeiaajaaaaadabaaaciaapaaoekaadaaoeiaajaaaaadabaaaeia
                    baaaoekaadaaoeiaafaaaaadacaaapiaadaacjiaadaakeiaajaaaaadaeaaabia
                    bbaaoekaacaaoeiaajaaaaadaeaaaciabcaaoekaacaaoeiaajaaaaadaeaaaeia
                    bdaaoekaacaaoeiaacaaaaadabaaahiaabaaoeiaaeaaoeiaafaaaaadaaaaaiia
                    adaaffiaadaaffiaaeaaaaaeaaaaaiiaadaaaaiaadaaaaiaaaaappibaeaaaaae
                    abaaahiabeaaoekaaaaappiaabaaoeiaacaaaaadadaaahoaaaaaoeiaabaaoeia
                    afaaaaadaaaaapiaaaaaffjabgaaoekaaeaaaaaeaaaaapiabfaaoekaaaaaaaja
                    aaaaoeiaaeaaaaaeaaaaapiabhaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapia
                    biaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
                    abaaaaacaaaaammaaaaaoeiappppaaaafdeieefclmajaaaaeaaaabaagpacaaaa
                    fjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
                    fjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaa
                    fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaa
                    acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
                    gfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadhccabaaa
                    adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaac
                    ahaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
                    abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
                    aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
                    acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
                    egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
                    dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaa
                    aaaaaaaaafaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
                    aaaaaaaaagaaaaaakgiocaaaaaaaaaaaagaaaaaadcaaaaaldccabaaaacaaaaaa
                    egbabaaaadaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaa
                    diaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaak
                    hcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaa
                    aaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaa
                    diaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaa
                    bbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
                    acaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
                    adaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
                    hcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaa
                    egacbaaaabaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaa
                    abaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
                    baaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadgaaaaaf
                    icaabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaihcaabaaaacaaaaaaegbcbaaa
                    acaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaadaaaaaafgafbaaa
                    acaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaacaaaaaaegiicaaa
                    adaaaaaaamaaaaaaagaabaaaacaaaaaaegaibaaaadaaaaaadcaaaaakhcaabaaa
                    abaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaacaaaaaaegadbaaaacaaaaaa
                    bbaaaaaibcaabaaaacaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaa
                    bbaaaaaiccaabaaaacaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaa
                    bbaaaaaiecaabaaaacaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaa
                    diaaaaahpcaabaaaadaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaai
                    bcaabaaaaeaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaadaaaaaabbaaaaai
                    ccaabaaaaeaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaadaaaaaabbaaaaai
                    ecaabaaaaeaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaadaaaaaaaaaaaaah
                    hcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaa
                    aaaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaa
                    akaabaaaabaaaaaaakaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaadcaaaaak
                    hcaabaaaacaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaa
                    acaaaaaadiaaaaaihcaabaaaadaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
                    anaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
                    aaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaadaaaaaa
                    aoaaaaaakgbkbaaaaaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaa
                    egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaadaaaaaaaaaaaaaj
                    pcaabaaaaeaaaaaafgafbaiaebaaaaaaadaaaaaaegiocaaaacaaaaaaadaaaaaa
                    diaaaaahpcaabaaaafaaaaaafgafbaaaabaaaaaaegaobaaaaeaaaaaadiaaaaah
                    pcaabaaaaeaaaaaaegaobaaaaeaaaaaaegaobaaaaeaaaaaaaaaaaaajpcaabaaa
                    agaaaaaaagaabaiaebaaaaaaadaaaaaaegiocaaaacaaaaaaacaaaaaaaaaaaaaj
                    pcaabaaaadaaaaaakgakbaiaebaaaaaaadaaaaaaegiocaaaacaaaaaaaeaaaaaa
                    dcaaaaajpcaabaaaafaaaaaaegaobaaaagaaaaaaagaabaaaabaaaaaaegaobaaa
                    afaaaaaadcaaaaajpcaabaaaabaaaaaaegaobaaaadaaaaaakgakbaaaabaaaaaa
                    egaobaaaafaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaaagaaaaaaegaobaaa
                    agaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaaadaaaaaa
                    egaobaaaadaaaaaaegaobaaaaeaaaaaaeeaaaaafpcaabaaaaeaaaaaaegaobaaa
                    adaaaaaadcaaaaanpcaabaaaadaaaaaaegaobaaaadaaaaaaegiocaaaacaaaaaa
                    afaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaa
                    adaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaadaaaaaa
                    diaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaaeaaaaaadeaaaaak
                    pcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
                    aaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaadaaaaaaegaobaaaabaaaaaa
                    diaaaaaihcaabaaaadaaaaaafgafbaaaabaaaaaaegiccaaaacaaaaaaahaaaaaa
                    dcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaaagaaaaaaagaabaaaabaaaaaa
                    egacbaaaadaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaiaaaaaa
                    kgakbaaaabaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
                    acaaaaaaajaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaahhccabaaa
                    aeaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaajhcaabaaaabaaaaaa
                    fgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaa
                    abaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaa
                    abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaa
                    abaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaa
                    abaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaa
                    abaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaah
                    cccabaaaafaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
                    afaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaafaaaaaa
                    egbcbaaaacaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaa
                    aiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
                    apadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeo
                    ehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
                    laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
                    apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaa
                    abaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaakeaaaaaaacaaaaaaaaaaaaaa
                    adaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
                    ahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
                    epfdejfeejepeoaafeeffiedepepfceeaaklklkl"
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
                    Vector 32 [_MainTex_ST]
                    Vector 33 [_BumpMap_ST]
                    Vector 34 [_ResourceMap_ST]
                    "!!ARBvp1.0
                    PARAM c[35] = { { 1, 0, 0.5 },
                    state.matrix.mvp,
                    program.local[5..34] };
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
                    MUL R1.w, R3, R3;
                    DP4 R3.z, R0, c[29];
                    DP4 R3.y, R0, c[28];
                    DP4 R3.x, R0, c[27];
                    MAD R1.w, R4.x, R4.x, -R1;
                    MUL R0.xyz, R1.w, c[30];
                    MOV R1.w, c[0].x;
                    DP4 R0.w, vertex.position, c[4];
                    DP4 R2.z, R4, c[26];
                    DP4 R2.y, R4, c[25];
                    DP4 R2.x, R4, c[24];
                    ADD R2.xyz, R2, R3;
                    ADD R0.xyz, R2, R0;
                    ADD result.texcoord[3].xyz, R0, R1;
                    MOV R1.xyz, c[13];
                    DP4 R2.z, R1, c[11];
                    DP4 R2.y, R1, c[10];
                    DP4 R2.x, R1, c[9];
                    MAD R2.xyz, R2, c[31].w, -vertex.position;
                    MOV R0.xyz, vertex.attrib[14];
                    MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
                    MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
                    MOV R1, c[15];
                    MUL R0.xyz, R0, vertex.attrib[14].w;
                    DP4 R3.z, R1, c[11];
                    DP4 R3.y, R1, c[10];
                    DP4 R3.x, R1, c[9];
                    DP3 result.texcoord[2].y, R3, R0;
                    DP3 result.texcoord[4].y, R0, R2;
                    DP4 R0.z, vertex.position, c[3];
                    DP4 R0.x, vertex.position, c[1];
                    DP4 R0.y, vertex.position, c[2];
                    MUL R1.xyz, R0.xyww, c[0].z;
                    MUL R1.y, R1, c[14].x;
                    DP3 result.texcoord[2].z, vertex.normal, R3;
                    DP3 result.texcoord[2].x, R3, vertex.attrib[14];
                    DP3 result.texcoord[4].z, vertex.normal, R2;
                    DP3 result.texcoord[4].x, vertex.attrib[14], R2;
                    ADD result.texcoord[5].xy, R1, R1.z;
                    MOV result.position, R0;
                    MOV result.texcoord[5].zw, R0;
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[33].xyxy, c[33];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[32], c[32].zwzw;
                    MAD result.texcoord[1].xy, vertex.texcoord[0], c[34], c[34].zwzw;
                    END
# 81 instructions, 5 R-regs
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
                    Vector 32 [_MainTex_ST]
                    Vector 33 [_BumpMap_ST]
                    Vector 34 [_ResourceMap_ST]
                    "vs_2_0
                    def c35, 1.00000000, 0.00000000, 0.50000000, 0
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
                    mov r4.w, c35.x
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
                    add r1, r2, c35.x
                    dp4 r2.z, r4, c26
                    dp4 r2.y, r4, c25
                    dp4 r2.x, r4, c24
                    rcp r1.x, r1.x
                    rcp r1.y, r1.y
                    rcp r1.w, r1.w
                    rcp r1.z, r1.z
                    max r0, r0, c35.y
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
                    add r0.xyz, r2, r0
                    add oT3.xyz, r0, r1
                    mov r1.w, c35.x
                    mov r1.xyz, c12
                    dp4 r0.z, r1, c10
                    dp4 r0.y, r1, c9
                    dp4 r0.x, r1, c8
                    mad r3.xyz, r0, c31.w, -v0
                    mov r1.xyz, v1
                    mov r0.xyz, v1
                    mul r1.xyz, v2.zxyw, r1.yzxw
                    mad r1.xyz, v2.yzxw, r0.zxyw, -r1
                    mul r2.xyz, r1, v1.w
                    mov r0, c10
                    dp4 r4.z, c15, r0
                    mov r0, c8
                    dp4 r4.x, c15, r0
                    mov r1, c9
                    dp4 r4.y, c15, r1
                    dp4 r0.w, v0, c3
                    dp4 r0.z, v0, c2
                    dp4 r0.x, v0, c0
                    dp4 r0.y, v0, c1
                    mul r1.xyz, r0.xyww, c35.z
                    mul r1.y, r1, c13.x
                    dp3 oT2.y, r4, r2
                    dp3 oT4.y, r2, r3
                    dp3 oT2.z, v2, r4
                    dp3 oT2.x, r4, v1
                    dp3 oT4.z, v2, r3
                    dp3 oT4.x, v1, r3
                    mad oT5.xy, r1.z, c14.zwzw, r1
                    mov oPos, r0
                    mov oT5.zw, r0
                    mad oT0.zw, v3.xyxy, c33.xyxy, c33
                    mad oT0.xy, v3, c32, c32.zwzw
                    mad oT1.xy, v3, c34, c34.zwzw
                    "
                }
                SubProgram "d3d11 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" TexCoord2
                    ConstBuffer "$Globals" 192
                    Vector 144 [_MainTex_ST]
                    Vector 160 [_BumpMap_ST]
                    Vector 176 [_ResourceMap_ST]
                    ConstBuffer "UnityPerCamera" 128
                    Vector 64 [_WorldSpaceCameraPos] 3
                    Vector 80 [_ProjectionParams]
                    ConstBuffer "UnityLighting" 720
                    Vector 0 [_WorldSpaceLightPos0]
                    Vector 32 [unity_4LightPosX0]
                    Vector 48 [unity_4LightPosY0]
                    Vector 64 [unity_4LightPosZ0]
                    Vector 80 [unity_4LightAtten0]
                    Vector 96 [unity_LightColor0]
                    Vector 112 [unity_LightColor1]
                    Vector 128 [unity_LightColor2]
                    Vector 144 [unity_LightColor3]
                    Vector 160 [unity_LightColor4]
                    Vector 176 [unity_LightColor5]
                    Vector 192 [unity_LightColor6]
                    Vector 208 [unity_LightColor7]
                    Vector 608 [unity_SHAr]
                    Vector 624 [unity_SHAg]
                    Vector 640 [unity_SHAb]
                    Vector 656 [unity_SHBr]
                    Vector 672 [unity_SHBg]
                    Vector 688 [unity_SHBb]
                    Vector 704 [unity_SHC]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 192 [_Object2World]
                    Matrix 256 [_World2Object]
                    Vector 320 [unity_Scale]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerCamera" 1
                    BindCB  "UnityLighting" 2
                    BindCB  "UnityPerDraw" 3
                    "vs_4_0
                    eefiecedpfhalbbcealfgehmapiegckgbgenkojoabaaaaaacaamaaaaadaaaaaa
                    cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
                    abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
                    enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
                    aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaa
                    adaaaaaaacaaaaaaadamaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
                    ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
                    aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
                    adaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
                    aaklklklfdeieefcfeakaaaaeaaaabaajfacaaaafjaaaaaeegiocaaaaaaaaaaa
                    amaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
                    cnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
                    fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
                    adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
                    gfaaaaaddccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
                    aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagiaaaaac
                    aiaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
                    abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
                    aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
                    acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
                    egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
                    pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
                    adaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadcaaaaal
                    mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaa
                    aaaaaaaaakaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaa
                    aaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaahhcaabaaaabaaaaaa
                    jgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaajgbebaaa
                    acaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaa
                    abaaaaaaegacbaaaabaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaa
                    fgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaa
                    acaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaa
                    acaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaa
                    acaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaa
                    adaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaabaaaaaah
                    cccabaaaadaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaa
                    adaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaaadaaaaaa
                    egbcbaaaacaaaaaaegacbaaaacaaaaaadgaaaaaficaabaaaacaaaaaaabeaaaaa
                    aaaaiadpdiaaaaaihcaabaaaadaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaa
                    beaaaaaadiaaaaaihcaabaaaaeaaaaaafgafbaaaadaaaaaaegiccaaaadaaaaaa
                    anaaaaaadcaaaaaklcaabaaaadaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaa
                    adaaaaaaegaibaaaaeaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaa
                    aoaaaaaakgakbaaaadaaaaaaegadbaaaadaaaaaabbaaaaaibcaabaaaadaaaaaa
                    egiocaaaacaaaaaacgaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaa
                    egiocaaaacaaaaaachaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaa
                    egiocaaaacaaaaaaciaaaaaaegaobaaaacaaaaaadiaaaaahpcaabaaaaeaaaaaa
                    jgacbaaaacaaaaaaegakbaaaacaaaaaabbaaaaaibcaabaaaafaaaaaaegiocaaa
                    acaaaaaacjaaaaaaegaobaaaaeaaaaaabbaaaaaiccaabaaaafaaaaaaegiocaaa
                    acaaaaaackaaaaaaegaobaaaaeaaaaaabbaaaaaiecaabaaaafaaaaaaegiocaaa
                    acaaaaaaclaaaaaaegaobaaaaeaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaa
                    adaaaaaaegacbaaaafaaaaaadiaaaaahicaabaaaabaaaaaabkaabaaaacaaaaaa
                    bkaabaaaacaaaaaadcaaaaakicaabaaaabaaaaaaakaabaaaacaaaaaaakaabaaa
                    acaaaaaadkaabaiaebaaaaaaabaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaa
                    acaaaaaacmaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaadiaaaaaihcaabaaa
                    aeaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
                    aeaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaeaaaaaa
                    dcaaaaakhcaabaaaaeaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
                    egacbaaaaeaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaa
                    pgbpbaaaaaaaaaaaegacbaaaaeaaaaaaaaaaaaajpcaabaaaafaaaaaafgafbaia
                    ebaaaaaaaeaaaaaaegiocaaaacaaaaaaadaaaaaadiaaaaahpcaabaaaagaaaaaa
                    fgafbaaaacaaaaaaegaobaaaafaaaaaadiaaaaahpcaabaaaafaaaaaaegaobaaa
                    afaaaaaaegaobaaaafaaaaaaaaaaaaajpcaabaaaahaaaaaaagaabaiaebaaaaaa
                    aeaaaaaaegiocaaaacaaaaaaacaaaaaaaaaaaaajpcaabaaaaeaaaaaakgakbaia
                    ebaaaaaaaeaaaaaaegiocaaaacaaaaaaaeaaaaaadcaaaaajpcaabaaaagaaaaaa
                    egaobaaaahaaaaaaagaabaaaacaaaaaaegaobaaaagaaaaaadcaaaaajpcaabaaa
                    acaaaaaaegaobaaaaeaaaaaakgakbaaaacaaaaaaegaobaaaagaaaaaadcaaaaaj
                    pcaabaaaafaaaaaaegaobaaaahaaaaaaegaobaaaahaaaaaaegaobaaaafaaaaaa
                    dcaaaaajpcaabaaaaeaaaaaaegaobaaaaeaaaaaaegaobaaaaeaaaaaaegaobaaa
                    afaaaaaaeeaaaaafpcaabaaaafaaaaaaegaobaaaaeaaaaaadcaaaaanpcaabaaa
                    aeaaaaaaegaobaaaaeaaaaaaegiocaaaacaaaaaaafaaaaaaaceaaaaaaaaaiadp
                    aaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaaeaaaaaaaceaaaaaaaaaiadp
                    aaaaiadpaaaaiadpaaaaiadpegaobaaaaeaaaaaadiaaaaahpcaabaaaacaaaaaa
                    egaobaaaacaaaaaaegaobaaaafaaaaaadeaaaaakpcaabaaaacaaaaaaegaobaaa
                    acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaa
                    acaaaaaaegaobaaaaeaaaaaaegaobaaaacaaaaaadiaaaaaihcaabaaaaeaaaaaa
                    fgafbaaaacaaaaaaegiccaaaacaaaaaaahaaaaaadcaaaaakhcaabaaaaeaaaaaa
                    egiccaaaacaaaaaaagaaaaaaagaabaaaacaaaaaaegacbaaaaeaaaaaadcaaaaak
                    hcaabaaaacaaaaaaegiccaaaacaaaaaaaiaaaaaakgakbaaaacaaaaaaegacbaaa
                    aeaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaaajaaaaaapgapbaaa
                    acaaaaaaegacbaaaacaaaaaaaaaaaaahhccabaaaaeaaaaaaegacbaaaacaaaaaa
                    egacbaaaadaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaaabaaaaaaaeaaaaaa
                    egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaa
                    baaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaa
                    acaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaa
                    acaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaadaaaaaa
                    bdaaaaaadcaaaaalhcaabaaaacaaaaaaegacbaaaacaaaaaapgipcaaaadaaaaaa
                    beaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaafaaaaaaegacbaaa
                    abaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaaafaaaaaaegbcbaaaabaaaaaa
                    egacbaaaacaaaaaabaaaaaaheccabaaaafaaaaaaegbcbaaaacaaaaaaegacbaaa
                    acaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
                    afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
                    aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaagaaaaaakgaobaaaaaaaaaaa
                    aaaaaaahdccabaaaagaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
                    "
                }
                SubProgram "d3d11_9x " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" TexCoord2
                    ConstBuffer "$Globals" 192
                    Vector 144 [_MainTex_ST]
                    Vector 160 [_BumpMap_ST]
                    Vector 176 [_ResourceMap_ST]
                    ConstBuffer "UnityPerCamera" 128
                    Vector 64 [_WorldSpaceCameraPos] 3
                    Vector 80 [_ProjectionParams]
                    ConstBuffer "UnityLighting" 720
                    Vector 0 [_WorldSpaceLightPos0]
                    Vector 32 [unity_4LightPosX0]
                    Vector 48 [unity_4LightPosY0]
                    Vector 64 [unity_4LightPosZ0]
                    Vector 80 [unity_4LightAtten0]
                    Vector 96 [unity_LightColor0]
                    Vector 112 [unity_LightColor1]
                    Vector 128 [unity_LightColor2]
                    Vector 144 [unity_LightColor3]
                    Vector 160 [unity_LightColor4]
                    Vector 176 [unity_LightColor5]
                    Vector 192 [unity_LightColor6]
                    Vector 208 [unity_LightColor7]
                    Vector 608 [unity_SHAr]
                    Vector 624 [unity_SHAg]
                    Vector 640 [unity_SHAb]
                    Vector 656 [unity_SHBr]
                    Vector 672 [unity_SHBg]
                    Vector 688 [unity_SHBb]
                    Vector 704 [unity_SHC]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 192 [_Object2World]
                    Matrix 256 [_World2Object]
                    Vector 320 [unity_Scale]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerCamera" 1
                    BindCB  "UnityLighting" 2
                    BindCB  "UnityPerDraw" 3
                    "vs_4_0_level_9_1
                    eefiecedpflpgbpoocgejgbaeldbighndefkeciiabaaaaaafabcaaaaaeaaaaaa
                    daaaaaaafmagaaaalibaaaaaiabbaaaaebgpgodjceagaaaaceagaaaaaaacpopp
                    kiafaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaajaa
                    adaaabaaaaaaaaaaabaaaeaaacaaaeaaaaaaaaaaacaaaaaaabaaagaaaaaaaaaa
                    acaaacaaaiaaahaaaaaaaaaaacaacgaaahaaapaaaaaaaaaaadaaaaaaaeaabgaa
                    aaaaaaaaadaaamaaajaabkaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafcdaaapka
                    aaaaiadpaaaaaaaaaaaaaadpaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaac
                    afaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapja
                    aeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaaeaaaaaeaaaaamoaadaaeeja
                    acaaeekaacaaoekaaeaaaaaeabaaadoaadaaoejaadaaoekaadaaookaabaaaaac
                    aaaaapiaagaaoekaafaaaaadabaaahiaaaaaffiabpaaoekaaeaaaaaeabaaahia
                    boaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiacaaaoekaaaaakkiaabaaoeia
                    aeaaaaaeaaaaahiacbaaoekaaaaappiaaaaaoeiaaiaaaaadacaaaboaabaaoeja
                    aaaaoeiaabaaaaacabaaahiaacaaoejaafaaaaadacaaahiaabaanciaabaamjja
                    aeaaaaaeabaaahiaabaamjiaabaancjaacaaoeibafaaaaadabaaahiaabaaoeia
                    abaappjaaiaaaaadacaaacoaabaaoeiaaaaaoeiaaiaaaaadacaaaeoaacaaoeja
                    aaaaoeiaabaaaaacaaaaahiaaeaaoekaafaaaaadacaaahiaaaaaffiabpaaoeka
                    aeaaaaaeaaaaaliaboaakekaaaaaaaiaacaakeiaaeaaaaaeaaaaahiacaaaoeka
                    aaaakkiaaaaapeiaacaaaaadaaaaahiaaaaaoeiacbaaoekaaeaaaaaeaaaaahia
                    aaaaoeiaccaappkaaaaaoejbaiaaaaadaeaaaboaabaaoejaaaaaoeiaaiaaaaad
                    aeaaacoaabaaoeiaaaaaoeiaaiaaaaadaeaaaeoaacaaoejaaaaaoeiaafaaaaad
                    aaaaahiaaaaaffjablaaoekaaeaaaaaeaaaaahiabkaaoekaaaaaaajaaaaaoeia
                    aeaaaaaeaaaaahiabmaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahiabnaaoeka
                    aaaappjaaaaaoeiaacaaaaadabaaapiaaaaakkibajaaoekaacaaaaadacaaapia
                    aaaaaaibahaaoekaacaaaaadaaaaapiaaaaaffibaiaaoekaafaaaaadadaaahia
                    acaaoejaccaappkaafaaaaadaeaaahiaadaaffiablaaoekaaeaaaaaeadaaalia
                    bkaakekaadaaaaiaaeaakeiaaeaaaaaeadaaahiabmaaoekaadaakkiaadaapeia
                    afaaaaadaeaaapiaaaaaoeiaadaaffiaafaaaaadaaaaapiaaaaaoeiaaaaaoeia
                    aeaaaaaeaaaaapiaacaaoeiaacaaoeiaaaaaoeiaaeaaaaaeacaaapiaacaaoeia
                    adaaaaiaaeaaoeiaaeaaaaaeacaaapiaabaaoeiaadaakkiaacaaoeiaaeaaaaae
                    aaaaapiaabaaoeiaabaaoeiaaaaaoeiaahaaaaacabaaabiaaaaaaaiaahaaaaac
                    abaaaciaaaaaffiaahaaaaacabaaaeiaaaaakkiaahaaaaacabaaaiiaaaaappia
                    abaaaaacaeaaabiacdaaaakaaeaaaaaeaaaaapiaaaaaoeiaakaaoekaaeaaaaia
                    afaaaaadabaaapiaabaaoeiaacaaoeiaalaaaaadabaaapiaabaaoeiacdaaffka
                    agaaaaacacaaabiaaaaaaaiaagaaaaacacaaaciaaaaaffiaagaaaaacacaaaeia
                    aaaakkiaagaaaaacacaaaiiaaaaappiaafaaaaadaaaaapiaabaaoeiaacaaoeia
                    afaaaaadabaaahiaaaaaffiaamaaoekaaeaaaaaeabaaahiaalaaoekaaaaaaaia
                    abaaoeiaaeaaaaaeaaaaahiaanaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaahia
                    aoaaoekaaaaappiaaaaaoeiaabaaaaacadaaaiiacdaaaakaajaaaaadabaaabia
                    apaaoekaadaaoeiaajaaaaadabaaaciabaaaoekaadaaoeiaajaaaaadabaaaeia
                    bbaaoekaadaaoeiaafaaaaadacaaapiaadaacjiaadaakeiaajaaaaadaeaaabia
                    bcaaoekaacaaoeiaajaaaaadaeaaaciabdaaoekaacaaoeiaajaaaaadaeaaaeia
                    beaaoekaacaaoeiaacaaaaadabaaahiaabaaoeiaaeaaoeiaafaaaaadaaaaaiia
                    adaaffiaadaaffiaaeaaaaaeaaaaaiiaadaaaaiaadaaaaiaaaaappibaeaaaaae
                    abaaahiabfaaoekaaaaappiaabaaoeiaacaaaaadadaaahoaaaaaoeiaabaaoeia
                    afaaaaadaaaaapiaaaaaffjabhaaoekaaeaaaaaeaaaaapiabgaaoekaaaaaaaja
                    aaaaoeiaaeaaaaaeaaaaapiabiaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapia
                    bjaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffiaafaaaakaafaaaaad
                    abaaaiiaabaaaaiacdaakkkaafaaaaadabaaafiaaaaapeiacdaakkkaacaaaaad
                    afaaadoaabaakkiaabaaomiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
                    abaaaaacaaaaammaaaaaoeiaabaaaaacafaaamoaaaaaoeiappppaaaafdeieefc
                    feakaaaaeaaaabaajfacaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaae
                    egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaae
                    egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
                    abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
                    pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
                    acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
                    hccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagiaaaaacaiaaaaaadiaaaaai
                    pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
                    pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
                    aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
                    aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
                    adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
                    egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
                    aaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaaabaaaaaa
                    agbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaa
                    dcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaa
                    ogikcaaaaaaaaaaaalaaaaaadiaaaaahhcaabaaaabaaaaaajgbebaaaabaaaaaa
                    cgbjbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaajgbebaaaacaaaaaacgbjbaaa
                    abaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaa
                    abaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaaacaaaaaa
                    aaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaa
                    adaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaal
                    hcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaa
                    egacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabdaaaaaa
                    pgipcaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaabaaaaaahcccabaaaadaaaaaa
                    egacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaa
                    abaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaa
                    egacbaaaacaaaaaadgaaaaaficaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaai
                    hcaabaaaadaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaai
                    hcaabaaaaeaaaaaafgafbaaaadaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
                    lcaabaaaadaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaadaaaaaaegaibaaa
                    aeaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaa
                    adaaaaaaegadbaaaadaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaa
                    cgaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaa
                    chaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaa
                    ciaaaaaaegaobaaaacaaaaaadiaaaaahpcaabaaaaeaaaaaajgacbaaaacaaaaaa
                    egakbaaaacaaaaaabbaaaaaibcaabaaaafaaaaaaegiocaaaacaaaaaacjaaaaaa
                    egaobaaaaeaaaaaabbaaaaaiccaabaaaafaaaaaaegiocaaaacaaaaaackaaaaaa
                    egaobaaaaeaaaaaabbaaaaaiecaabaaaafaaaaaaegiocaaaacaaaaaaclaaaaaa
                    egaobaaaaeaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaaa
                    afaaaaaadiaaaaahicaabaaaabaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaa
                    dcaaaaakicaabaaaabaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaadkaabaia
                    ebaaaaaaabaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaacmaaaaaa
                    pgapbaaaabaaaaaaegacbaaaadaaaaaadiaaaaaihcaabaaaaeaaaaaafgbfbaaa
                    aaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaa
                    adaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaeaaaaaadcaaaaakhcaabaaa
                    aeaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaeaaaaaa
                    dcaaaaakhcaabaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
                    egacbaaaaeaaaaaaaaaaaaajpcaabaaaafaaaaaafgafbaiaebaaaaaaaeaaaaaa
                    egiocaaaacaaaaaaadaaaaaadiaaaaahpcaabaaaagaaaaaafgafbaaaacaaaaaa
                    egaobaaaafaaaaaadiaaaaahpcaabaaaafaaaaaaegaobaaaafaaaaaaegaobaaa
                    afaaaaaaaaaaaaajpcaabaaaahaaaaaaagaabaiaebaaaaaaaeaaaaaaegiocaaa
                    acaaaaaaacaaaaaaaaaaaaajpcaabaaaaeaaaaaakgakbaiaebaaaaaaaeaaaaaa
                    egiocaaaacaaaaaaaeaaaaaadcaaaaajpcaabaaaagaaaaaaegaobaaaahaaaaaa
                    agaabaaaacaaaaaaegaobaaaagaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaa
                    aeaaaaaakgakbaaaacaaaaaaegaobaaaagaaaaaadcaaaaajpcaabaaaafaaaaaa
                    egaobaaaahaaaaaaegaobaaaahaaaaaaegaobaaaafaaaaaadcaaaaajpcaabaaa
                    aeaaaaaaegaobaaaaeaaaaaaegaobaaaaeaaaaaaegaobaaaafaaaaaaeeaaaaaf
                    pcaabaaaafaaaaaaegaobaaaaeaaaaaadcaaaaanpcaabaaaaeaaaaaaegaobaaa
                    aeaaaaaaegiocaaaacaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
                    aaaaiadpaoaaaaakpcaabaaaaeaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
                    aaaaiadpegaobaaaaeaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaa
                    egaobaaaafaaaaaadeaaaaakpcaabaaaacaaaaaaegaobaaaacaaaaaaaceaaaaa
                    aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaa
                    aeaaaaaaegaobaaaacaaaaaadiaaaaaihcaabaaaaeaaaaaafgafbaaaacaaaaaa
                    egiccaaaacaaaaaaahaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaaacaaaaaa
                    agaaaaaaagaabaaaacaaaaaaegacbaaaaeaaaaaadcaaaaakhcaabaaaacaaaaaa
                    egiccaaaacaaaaaaaiaaaaaakgakbaaaacaaaaaaegacbaaaaeaaaaaadcaaaaak
                    hcaabaaaacaaaaaaegiccaaaacaaaaaaajaaaaaapgapbaaaacaaaaaaegacbaaa
                    acaaaaaaaaaaaaahhccabaaaaeaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaa
                    diaaaaajhcaabaaaacaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
                    bbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
                    abaaaaaaaeaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaa
                    adaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaaaaaaaaai
                    hcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaal
                    hcaabaaaacaaaaaaegacbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaia
                    ebaaaaaaaaaaaaaabaaaaaahcccabaaaafaaaaaaegacbaaaabaaaaaaegacbaaa
                    acaaaaaabaaaaaahbccabaaaafaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaa
                    baaaaaaheccabaaaafaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadiaaaaai
                    ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
                    ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
                    aaaaaadpdgaaaaafmccabaaaagaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaa
                    agaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaabejfdeheomaaaaaaa
                    agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
                    kbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaa
                    aaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
                    adaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
                    ljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeo
                    aafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaakl
                    epfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
                    aaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
                    lmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaalmaaaaaaacaaaaaa
                    aaaaaaaaadaaaaaaadaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaa
                    aeaaaaaaahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaa
                    lmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfe
                    ejepeoaafeeffiedepepfceeaaklklkl"
                }
            }
            Program "fp" {
                SubProgram "opengl " {
                    Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
                    Vector 0 [_LightColor0]
                    Vector 1 [_SpecColor]
                    Vector 2 [_Color]
                    Float 3 [_Shininess]
                    Float 4 [_Opacity]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_ResourceMap] 2D 2
                    "!!ARBfp1.0
                    PARAM c[6] = { program.local[0..4],
                    { 2, 1, 0, 128 } };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    TEX R1, fragment.texcoord[1], texture[2], 2D;
                    TEX R0, fragment.texcoord[0], texture[0], 2D;
                    TEX R3.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
                    MAD R3.xy, R3.wyzw, c[5].x, -c[5].y;
                    DP3 R2.w, fragment.texcoord[4], fragment.texcoord[4];
                    MUL R3.zw, R3.xyxy, R3.xyxy;
                    RSQ R2.w, R2.w;
                    MOV R2.xyz, fragment.texcoord[2];
                    MAD R2.xyz, R2.w, fragment.texcoord[4], R2;
                    ADD_SAT R2.w, R3.z, R3;
                    DP3 R3.z, R2, R2;
                    RSQ R3.z, R3.z;
                    ADD R2.w, -R2, c[5].y;
                    MUL R2.xyz, R3.z, R2;
                    RSQ R2.w, R2.w;
                    RCP R3.z, R2.w;
                    DP3 R2.x, R3, R2;
                    MOV R2.w, c[5];
                    DP3 R3.x, R3, fragment.texcoord[2];
                    MUL R2.y, R2.w, c[3].x;
                    MAX R2.x, R2, c[5].z;
                    POW R2.x, R2.x, R2.y;
                    MUL R0.w, R0, R2.x;
                    MOV R2, c[1];
                    MUL R1.xyz, R1, R1.w;
                    MUL R0.xyz, R0, c[2];
                    MAX R3.w, R3.x, c[5].z;
                    MUL R3.xyz, R0, c[0];
                    MUL R3.xyz, R3, R3.w;
                    MUL R2.xyz, R2, c[0];
                    MAD R2.xyz, R2, R0.w, R3;
                    MUL R2.xyz, R2, c[5].x;
                    MAD R0.xyz, R0, fragment.texcoord[3], R2;
                    ADD result.color.xyz, R0, R1;
                    MUL R1.w, R2, c[0];
                    MUL R0.y, R0.w, R1.w;
                    MOV R0.x, c[4];
                    MAD result.color.w, R0.x, c[2], R0.y;
                    END
# 38 instructions, 4 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
                    Vector 0 [_LightColor0]
                    Vector 1 [_SpecColor]
                    Vector 2 [_Color]
                    Float 3 [_Shininess]
                    Float 4 [_Opacity]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_ResourceMap] 2D 2
                    "ps_2_0
                    dcl_2d s0
                    dcl_2d s1
                    dcl_2d s2
                    def c5, 2.00000000, -1.00000000, 1.00000000, 0.00000000
                    def c6, 128.00000000, 0, 0, 0
                    dcl t0
                    dcl t1.xy
                    dcl t2.xyz
                    dcl t3.xyz
                    dcl t4.xyz
                    texld r2, t1, s2
                    texld r3, t0, s0
                    dp3_pp r1.x, t4, t4
                    rsq_pp r1.x, r1.x
                    mov_pp r4.xyz, t2
                    mad_pp r4.xyz, r1.x, t4, r4
                    dp3_pp r1.x, r4, r4
                    rsq_pp r1.x, r1.x
                    mul_pp r1.xyz, r1.x, r4
                    mul_pp r3.xyz, r3, c2
                    mov r0.y, t0.w
                    mov r0.x, t0.z
                    texld r0, r0, s1
                    mov r0.x, r0.w
                    mad_pp r5.xy, r0, c5.x, c5.y
                    mul_pp r0.xy, r5, r5
                    add_pp_sat r0.x, r0, r0.y
                    add_pp r0.x, -r0, c5.z
                    rsq_pp r0.x, r0.x
                    rcp_pp r5.z, r0.x
                    dp3_pp r1.x, r5, r1
                    mov_pp r0.x, c3
                    mul_pp r0.x, c6, r0
                    max_pp r1.x, r1, c5.w
                    pow r4.w, r1.x, r0.x
                    mov r0.x, r4.w
                    mov_pp r0.w, c0
                    mul_pp r1.x, c1.w, r0.w
                    mul r0.x, r3.w, r0
                    mov_pp r4.xyz, c0
                    mul r1.x, r0, r1
                    mov r0.w, c2
                    mad r0.w, c4.x, r0, r1.x
                    dp3_pp r1.x, r5, t2
                    max_pp r1.x, r1, c5.w
                    mul_pp r5.xyz, r3, c0
                    mul_pp r1.xyz, r5, r1.x
                    mul_pp r4.xyz, c1, r4
                    mad r0.xyz, r4, r0.x, r1
                    mul r0.xyz, r0, c5.x
                    mul r1.xyz, r2, r2.w
                    mad_pp r0.xyz, r3, t3, r0
                    add_pp r0.xyz, r0, r1
                    mov_pp oC0, r0
                    "
                }
                SubProgram "d3d11 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_ResourceMap] 2D 2
                    ConstBuffer "$Globals" 128
                    Vector 16 [_LightColor0]
                    Vector 32 [_SpecColor]
                    Vector 48 [_Color]
                    Float 64 [_Shininess]
                    Float 68 [_Opacity]
                    BindCB  "$Globals" 0
                    "ps_4_0
                    eefiecedjccfhfoaonkafdemogahpmgokhndpgaoabaaaaaakiafaaaaadaaaaaa
                    cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
                    aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    adadaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
                    adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
                    adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
                    aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefciiaeaaaa
                    eaaaaaaaccabaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaa
                    aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
                    aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
                    aahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
                    acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaad
                    hcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaah
                    bcaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaafbcaabaaa
                    aaaaaaaaakaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegbcbaaaafaaaaaa
                    agaabaaaaaaaaaaaegbcbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
                    aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
                    diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaaj
                    pcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
                    dcaaaaapdcaabaaaabaaaaaahgapbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
                    aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaah
                    icaabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaabaaaaaaddaaaaahicaabaaa
                    aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaa
                    dkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaabaaaaaa
                    dkaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
                    aaaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaaegbcbaaaadaaaaaa
                    deaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
                    aaaaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
                    ecaabaaaaaaaaaaaakiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaeddiaaaaah
                    bcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaabjaaaaafbcaabaaa
                    aaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaa
                    eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
                    aaaaaaaadkaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
                    egiccaaaaaaaaaaaadaaaaaadiaaaaajpcaabaaaacaaaaaaegiocaaaaaaaaaaa
                    abaaaaaaegiocaaaaaaaaaaaacaaaaaadiaaaaahpcaabaaaacaaaaaaagaabaaa
                    aaaaaaaaegaobaaaacaaaaaadiaaaaaincaabaaaaaaaaaaaagajbaaaabaaaaaa
                    agijcaaaaaaaaaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaigadbaaaaaaaaaaa
                    fgafbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaaliccabaaaaaaaaaaadkiacaaa
                    aaaaaaaaadaaaaaabkiacaaaaaaaaaaaaeaaaaaadkaabaaaacaaaaaaaaaaaaah
                    hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaajhcaabaaa
                    aaaaaaaaegacbaaaabaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaefaaaaaj
                    pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
                    dcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaaegacbaaa
                    aaaaaaaadoaaaaab"
                }
                SubProgram "d3d11_9x " {
                    Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_ResourceMap] 2D 2
                    ConstBuffer "$Globals" 128
                    Vector 16 [_LightColor0]
                    Vector 32 [_SpecColor]
                    Vector 48 [_Color]
                    Float 64 [_Shininess]
                    Float 68 [_Opacity]
                    BindCB  "$Globals" 0
                    "ps_4_0_level_9_1
                    eefiecedogmamiojgldomlhdnmmbgbdojnbojbkfabaaaaaanaaiaaaaaeaaaaaa
                    daaaaaaafeadaaaaoeahaaaajmaiaaaaebgpgodjbmadaaaabmadaaaaaaacpppp
                    oaacaaaadmaaaaaaabaadaaaaaaadmaaaaaadmaaadaaceaaaaaadmaaaaaaaaaa
                    abababaaacacacaaaaaaabaaaeaaaaaaaaaaaaaaaaacppppfbaaaaafaeaaapka
                    aaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaafafaaapkaaaaaaaedaaaaaaaa
                    aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaadla
                    bpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaaia
                    aeaachlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaac
                    aaaaaajaacaiapkaaiaaaaadaaaaciiaaeaaoelaaeaaoelaahaaaaacaaaacbia
                    aaaappiaabaaaaacabaaahiaaeaaoelaaeaaaaaeaaaachiaabaaoeiaaaaaaaia
                    acaaoelaceaaaaacabaachiaaaaaoeiaabaaaaacaaaaabiaaaaakklaabaaaaac
                    aaaaaciaaaaapplaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaadacaacpia
                    aaaaoelaaaaioekaecaaaaadadaaapiaabaaoelaacaioekaaeaaaaaeaeaacbia
                    aaaappiaaeaaaakaaeaaffkaaeaaaaaeaeaacciaaaaaffiaaeaaaakaaeaaffka
                    fkaaaaaeabaadiiaaeaaoeiaaeaaoeiaaeaakkkaacaaaaadabaaciiaabaappib
                    aeaappkaahaaaaacabaaciiaabaappiaagaaaaacaeaaceiaabaappiaaiaaaaad
                    aeaaciiaaeaaoeiaabaaoeiaaiaaaaadaaaacbiaaeaaoeiaacaaoelaalaaaaad
                    abaacbiaaaaaaaiaaeaakkkaalaaaaadaaaaabiaaeaappiaaeaakkkaabaaaaac
                    aeaaadiaadaaoekaafaaaaadaaaaaciaaeaaaaiaafaaaakacaaaaaadabaaacia
                    aaaaaaiaaaaaffiaafaaaaadacaaaiiaacaappiaabaaffiaafaaaaadaaaachia
                    acaaoeiaacaaoekaabaaaaacafaaapiaaaaaoekaafaaaaadabaaaoiaafaablia
                    abaablkaafaaaaadabaaaoiaacaappiaabaaoeiaafaaaaadacaachiaaaaaoeia
                    aaaaoekaaeaaaaaeabaaahiaacaaoeiaabaaaaiaabaabliaacaaaaadabaachia
                    abaaoeiaabaaoeiaaeaaaaaeaaaachiaaaaaoeiaadaaoelaabaaoeiaaeaaaaae
                    aaaachiaadaaoeiaadaappiaaaaaoeiaafaaaaadabaaabiaafaappiaabaappka
                    afaaaaadabaaabiaacaappiaabaaaaiaaeaaaaaeaaaaciiaacaappkaaeaaffia
                    abaaaaiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefciiaeaaaaeaaaaaaa
                    ccabaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaa
                    fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
                    aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
                    acaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
                    gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
                    afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaahbcaabaaa
                    aaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaafbcaabaaaaaaaaaaa
                    akaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegbcbaaaafaaaaaaagaabaaa
                    aaaaaaaaegbcbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
                    egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
                    hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaa
                    abaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaap
                    dcaabaaaabaaaaaahgapbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
                    aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaa
                    aaaaaaaaegaabaaaabaaaaaaegaabaaaabaaaaaaddaaaaahicaabaaaaaaaaaaa
                    dkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaia
                    ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaabaaaaaadkaabaaa
                    aaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaa
                    baaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaaegbcbaaaadaaaaaadeaaaaak
                    dcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
                    aaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiecaabaaa
                    aaaaaaaaakiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaa
                    aaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaabjaaaaafbcaabaaaaaaaaaaa
                    akaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaa
                    aaaaaaaaaagabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
                    dkaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
                    aaaaaaaaadaaaaaadiaaaaajpcaabaaaacaaaaaaegiocaaaaaaaaaaaabaaaaaa
                    egiocaaaaaaaaaaaacaaaaaadiaaaaahpcaabaaaacaaaaaaagaabaaaaaaaaaaa
                    egaobaaaacaaaaaadiaaaaaincaabaaaaaaaaaaaagajbaaaabaaaaaaagijcaaa
                    aaaaaaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaigadbaaaaaaaaaaafgafbaaa
                    aaaaaaaaegacbaaaacaaaaaadcaaaaaliccabaaaaaaaaaaadkiacaaaaaaaaaaa
                    adaaaaaabkiacaaaaaaaaaaaaeaaaaaadkaabaaaacaaaaaaaaaaaaahhcaabaaa
                    aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaa
                    egacbaaaabaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaa
                    abaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaaj
                    hccabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaaegacbaaaaaaaaaaa
                    doaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
                    adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
                    apapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaakeaaaaaa
                    acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaaadaaaaaaaaaaaaaa
                    adaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
                    ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
                    cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
                    apaaaaaafdfgfpfegbhcghgfheaaklkl"
                }
                SubProgram "opengl " {
                    Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
                    Vector 0 [_Color]
                    Float 1 [_Opacity]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 2 [_ResourceMap] 2D 2
                    SetTexture 3 [unity_Lightmap] 2D 3
                    "!!ARBfp1.0
                    PARAM c[3] = { program.local[0..1],
                    { 8 } };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEX R0, fragment.texcoord[2], texture[3], 2D;
                    TEX R1, fragment.texcoord[1], texture[2], 2D;
                    TEX R2.xyz, fragment.texcoord[0], texture[0], 2D;
                    MUL R0.xyz, R0.w, R0;
                    MUL R2.xyz, R2, c[0];
                    MOV R0.w, c[1].x;
                    MUL R0.xyz, R0, R2;
                    MUL R1.xyz, R1, R1.w;
                    MAD result.color.xyz, R0, c[2].x, R1;
                    MUL result.color.w, R0, c[0];
                    END
# 10 instructions, 3 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
                    Vector 0 [_Color]
                    Float 1 [_Opacity]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 2 [_ResourceMap] 2D 2
                    SetTexture 3 [unity_Lightmap] 2D 3
                    "ps_2_0
                    dcl_2d s0
                    dcl_2d s2
                    dcl_2d s3
                    def c2, 8.00000000, 0, 0, 0
                    dcl t0.xy
                    dcl t1.xy
                    dcl t2.xy
                    texld r1, t1, s2
                    texld r2, t0, s0
                    texld r0, t2, s3
                    mul_pp r0.xyz, r0.w, r0
                    mul_pp r2.xyz, r2, c0
                    mov r0.w, c0
                    mul_pp r0.xyz, r0, r2
                    mul r1.xyz, r1, r1.w
                    mul r0.w, c1.x, r0
                    mad_pp r0.xyz, r0, c2.x, r1
                    mov_pp oC0, r0
                    "
                }
                SubProgram "d3d11 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_ResourceMap] 2D 1
                    SetTexture 2 [unity_Lightmap] 2D 2
                    ConstBuffer "$Globals" 144
                    Vector 48 [_Color]
                    Float 68 [_Opacity]
                    BindCB  "$Globals" 0
                    "ps_4_0
                    eefiecedplkmaliaopknbfcfeehkmcohaomeciggabaaaaaamaacaaaaadaaaaaa
                    cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
                    aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    adadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
                    epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
                    aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
                    gbhcghgfheaaklklfdeieefcnaabaaaaeaaaaaaaheaaaaaafjaaaaaeegiocaaa
                    aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
                    fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
                    aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
                    dcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
                    gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
                    ogbkbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahicaabaaa
                    aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaaaaaaaaa
                    egacbaaaaaaaaaaapgapbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
                    abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
                    egacbaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaaefaaaaajpcaabaaaacaaaaaa
                    egbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaa
                    acaaaaaapgapbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhccabaaaaaaaaaaa
                    egacbaaaabaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaajiccabaaa
                    aaaaaaaadkiacaaaaaaaaaaaadaaaaaabkiacaaaaaaaaaaaaeaaaaaadoaaaaab
                    "
                }
                SubProgram "d3d11_9x " {
                    Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_ResourceMap] 2D 1
                    SetTexture 2 [unity_Lightmap] 2D 2
                    ConstBuffer "$Globals" 144
                    Vector 48 [_Color]
                    Float 68 [_Opacity]
                    BindCB  "$Globals" 0
                    "ps_4_0_level_9_1
                    eefiecedhiplgogjgabiabdkfjjmnflnkiekknpiabaaaaaabmaeaaaaaeaaaaaa
                    daaaaaaaiiabaaaagaadaaaaoiadaaaaebgpgodjfaabaaaafaabaaaaaaacpppp
                    beabaaaadmaaaaaaabaadaaaaaaadmaaaaaadmaaadaaceaaaaaadmaaaaaaaaaa
                    abababaaacacacaaaaaaadaaacaaaaaaaaaaaaaaaaacppppfbaaaaafacaaapka
                    aaaaaaebaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaac
                    aaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
                    bpaaaaacaaaaaajaacaiapkaabaaaaacaaaaadiaabaabllaecaaaaadaaaacpia
                    aaaaoeiaacaioekaecaaaaadabaacpiaaaaaoelaaaaioekaecaaaaadacaaapia
                    abaaoelaabaioekaafaaaaadaaaaciiaaaaappiaacaaaakaafaaaaadaaaachia
                    aaaaoeiaaaaappiaafaaaaadabaachiaabaaoeiaaaaaoekaafaaaaadacaachia
                    acaappiaacaaoeiaaeaaaaaeaaaachiaabaaoeiaaaaaoeiaacaaoeiaabaaaaac
                    abaaaiiaaaaappkaafaaaaadaaaaciiaabaappiaabaaffkaabaaaaacaaaicpia
                    aaaaoeiappppaaaafdeieefcnaabaaaaeaaaaaaaheaaaaaafjaaaaaeegiocaaa
                    aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
                    fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
                    aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
                    dcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
                    gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
                    ogbkbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahicaabaaa
                    aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaaaaaaaaa
                    egacbaaaaaaaaaaapgapbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
                    abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
                    egacbaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaaefaaaaajpcaabaaaacaaaaaa
                    egbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaa
                    acaaaaaapgapbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhccabaaaaaaaaaaa
                    egacbaaaabaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaajiccabaaa
                    aaaaaaaadkiacaaaaaaaaaaaadaaaaaabkiacaaaaaaaaaaaaeaaaaaadoaaaaab
                    ejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
                    aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapadaaaa
                    heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaaheaaaaaaacaaaaaa
                    aaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfaepfdejfeejepeoaafeeffied
                    epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
                    aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
                }
                SubProgram "opengl " {
                    Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
                    Vector 0 [_SpecColor]
                    Vector 1 [_Color]
                    Float 2 [_Shininess]
                    Float 3 [_Opacity]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_ResourceMap] 2D 2
                    SetTexture 3 [unity_Lightmap] 2D 3
                    SetTexture 4 [unity_LightmapInd] 2D 4
                    "!!ARBfp1.0
                    PARAM c[8] = { program.local[0..3],
                    { 2, 1, 8, 0 },
                    { -0.40824828, -0.70710677, 0.57735026, 128 },
                    { -0.40824831, 0.70710677, 0.57735026 },
                    { 0.81649655, 0, 0.57735026 } };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    TEMP R4;
                    TEMP R5;
                    TEX R1, fragment.texcoord[0], texture[0], 2D;
                    TEX R2, fragment.texcoord[2], texture[3], 2D;
                    TEX R3, fragment.texcoord[2], texture[4], 2D;
                    TEX R4.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
                    TEX R0, fragment.texcoord[1], texture[2], 2D;
                    MAD R4.xy, R4.wyzw, c[4].x, -c[4].y;
                    MUL R3.xyz, R3.w, R3;
                    MUL R3.xyz, R3, c[4].z;
                    MUL R5.xyz, R3.y, c[6];
                    MAD R5.xyz, R3.x, c[7], R5;
                    MAD R5.xyz, R3.z, c[5], R5;
                    DP3 R3.w, R5, R5;
                    RSQ R3.w, R3.w;
                    MUL R5.xyz, R3.w, R5;
                    MUL R4.zw, R4.xyxy, R4.xyxy;
                    ADD_SAT R4.z, R4, R4.w;
                    MUL R2.xyz, R2.w, R2;
                    DP3 R3.w, fragment.texcoord[3], fragment.texcoord[3];
                    RSQ R3.w, R3.w;
                    MAD R5.xyz, R3.w, fragment.texcoord[3], R5;
                    MOV R2.w, c[5];
                    DP3 R3.w, R5, R5;
                    ADD R4.w, -R4.z, c[4].y;
                    RSQ R4.z, R3.w;
                    MUL R5.xyz, R4.z, R5;
                    RSQ R3.w, R4.w;
                    RCP R4.z, R3.w;
                    DP3 R3.w, R4, R5;
                    MAX R3.w, R3, c[4];
                    MUL R2.w, R2, c[2].x;
                    DP3_SAT R5.z, R4, c[5];
                    DP3_SAT R5.x, R4, c[7];
                    DP3_SAT R5.y, R4, c[6];
                    DP3 R3.x, R5, R3;
                    MUL R2.xyz, R2, R3.x;
                    MUL R2.xyz, R2, c[4].z;
                    MUL R3.xyz, R2, c[0];
                    POW R2.w, R3.w, R2.w;
                    MUL R3.xyz, R1.w, R3;
                    MUL R3.xyz, R3, R2.w;
                    MUL R1.xyz, R1, c[1];
                    MAD R1.xyz, R1, R2, R3;
                    MUL R2.xyz, R0, R0.w;
                    MOV R0.x, c[3];
                    ADD result.color.xyz, R1, R2;
                    MUL result.color.w, R0.x, c[1];
                    END
# 46 instructions, 6 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
                    Vector 0 [_SpecColor]
                    Vector 1 [_Color]
                    Float 2 [_Shininess]
                    Float 3 [_Opacity]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_ResourceMap] 2D 2
                    SetTexture 3 [unity_Lightmap] 2D 3
                    SetTexture 4 [unity_LightmapInd] 2D 4
                    "ps_2_0
                    dcl_2d s0
                    dcl_2d s1
                    dcl_2d s2
                    dcl_2d s3
                    dcl_2d s4
                    def c4, 2.00000000, -1.00000000, 1.00000000, 8.00000000
                    def c5, -0.40824828, -0.70710677, 0.57735026, 0.00000000
                    def c6, -0.40824831, 0.70710677, 0.57735026, 128.00000000
                    def c7, 0.81649655, 0.00000000, 0.57735026, 0
                    dcl t0
                    dcl t1.xy
                    dcl t2.xy
                    dcl t3.xyz
                    texld r1, t1, s2
                    texld r2, t0, s0
                    texld r3, t2, s3
                    texld r4, t2, s4
                    mul_pp r4.xyz, r4.w, r4
                    mul_pp r4.xyz, r4, c4.w
                    mul r5.xyz, r4.y, c6
                    mad r5.xyz, r4.x, c7, r5
                    mul_pp r3.xyz, r3.w, r3
                    mad r5.xyz, r4.z, c5, r5
                    mov r0.y, t0.w
                    mov r0.x, t0.z
                    mul_pp r2.xyz, r2, c1
                    mul r1.xyz, r1, r1.w
                    texld r0, r0, s1
                    dp3 r0.x, r5, r5
                    rsq r0.x, r0.x
                    mul r5.xyz, r0.x, r5
                    mov r0.x, r0.w
                    mad_pp r7.xy, r0, c4.x, c4.y
                    dp3_pp r0.x, t3, t3
                    rsq_pp r0.x, r0.x
                    mov r0.w, c1
                    mad_pp r0.xyz, r0.x, t3, r5
                    mul_pp r6.xy, r7, r7
                    add_pp_sat r5.x, r6, r6.y
                    dp3_pp r6.x, r0, r0
                    rsq_pp r6.x, r6.x
                    add_pp r5.x, -r5, c4.z
                    rsq_pp r5.x, r5.x
                    rcp_pp r7.z, r5.x
                    mul_pp r0.xyz, r6.x, r0
                    dp3_pp r0.x, r7, r0
                    mov_pp r5.x, c2
                    max_pp r0.x, r0, c5.w
                    mul_pp r5.x, c6.w, r5
                    pow r6.x, r0.x, r5.x
                    dp3_pp_sat r0.z, r7, c5
                    dp3_pp_sat r0.y, r7, c6
                    dp3_pp_sat r0.x, r7, c7
                    dp3_pp r0.x, r0, r4
                    mul_pp r0.xyz, r3, r0.x
                    mul_pp r0.xyz, r0, c4.w
                    mul_pp r4.xyz, r0, c0
                    mov r3.x, r6.x
                    mul_pp r4.xyz, r2.w, r4
                    mul r3.xyz, r4, r3.x
                    mad_pp r0.xyz, r2, r0, r3
                    mul r0.w, c3.x, r0
                    add_pp r0.xyz, r0, r1
                    mov_pp oC0, r0
                    "
                }
                SubProgram "d3d11 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_ResourceMap] 2D 2
                    SetTexture 3 [unity_Lightmap] 2D 3
                    SetTexture 4 [unity_LightmapInd] 2D 4
                    ConstBuffer "$Globals" 144
                    Vector 32 [_SpecColor]
                    Vector 48 [_Color]
                    Float 64 [_Shininess]
                    Float 68 [_Opacity]
                    BindCB  "$Globals" 0
                    "ps_4_0
                    eefiecedmioopmjgpcoigbedipmbhlibhpkkglcpabaaaaaageahaaaaadaaaaaa
                    cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
                    aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    adadaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaaimaaaaaa
                    adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
                    feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
                    fdeieefcfmagaaaaeaaaaaaajhabaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaa
                    fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
                    acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaae
                    aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
                    aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaae
                    aahabaaaaeaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
                    acaaaaaagcbaaaadmcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaad
                    pccabaaaaaaaaaaagiaaaaacaeaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaa
                    adaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
                    diaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaaadaaaaaaefaaaaaj
                    pcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaa
                    diaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaah
                    hcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaadiaaaaakhcaabaaa
                    acaaaaaafgafbaaaabaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaa
                    dcaaaaamhcaabaaaacaaaaaaagaabaaaabaaaaaaaceaaaaaolaffbdpaaaaaaaa
                    dkmnbddpaaaaaaaaegacbaaaacaaaaaadcaaaaamhcaabaaaacaaaaaakgakbaaa
                    abaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegacbaaaacaaaaaa
                    baaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaf
                    icaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
                    acaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
                    egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
                    aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
                    efaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
                    abaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaea
                    aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
                    apaaaaahicaabaaaaaaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaah
                    icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaa
                    aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
                    acaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaa
                    egacbaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
                    aaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiccaabaaa
                    aaaaaaaaakiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaa
                    aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabjaaaaafbcaabaaaaaaaaaaa
                    akaabaaaaaaaaaaaapcaaaakbcaabaaaadaaaaaaaceaaaaaolaffbdpdkmnbddp
                    aaaaaaaaaaaaaaaaigaabaaaacaaaaaabacaaaakccaabaaaadaaaaaaaceaaaaa
                    omafnblopdaedfdpdkmnbddpaaaaaaaaegacbaaaacaaaaaabacaaaakecaabaaa
                    adaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegacbaaaacaaaaaa
                    baaaaaahccaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaaefaaaaaj
                    pcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaa
                    diaaaaahecaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaah
                    hcaabaaaabaaaaaaegacbaaaabaaaaaakgakbaaaaaaaaaaadiaaaaahocaabaaa
                    aaaaaaaafgafbaaaaaaaaaaaagajbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
                    jgahbaaaaaaaaaaaegiccaaaaaaaaaaaacaaaaaaefaaaaajpcaabaaaacaaaaaa
                    egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaa
                    abaaaaaaegacbaaaabaaaaaapgapbaaaacaaaaaadiaaaaaihcaabaaaacaaaaaa
                    egacbaaaacaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaahocaabaaaaaaaaaaa
                    fgaobaaaaaaaaaaaagajbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
                    abaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
                    egbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaajhccabaaa
                    aaaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaaegacbaaaaaaaaaaadiaaaaaj
                    iccabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaabkiacaaaaaaaaaaaaeaaaaaa
                    doaaaaab"
                }
                SubProgram "d3d11_9x " {
                    Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_ResourceMap] 2D 2
                    SetTexture 3 [unity_Lightmap] 2D 3
                    SetTexture 4 [unity_LightmapInd] 2D 4
                    ConstBuffer "$Globals" 144
                    Vector 32 [_SpecColor]
                    Vector 48 [_Color]
                    Float 64 [_Shininess]
                    Float 68 [_Opacity]
                    BindCB  "$Globals" 0
                    "ps_4_0_level_9_1
                    eefiecedeejkmjdglmlckalajgbdngmafcabbimcabaaaaaaeaalaaaaaeaaaaaa
                    daaaaaaaaiaeaaaagmakaaaaamalaaaaebgpgodjnaadaaaanaadaaaaaaacpppp
                    imadaaaaeeaaaaaaabaadiaaaaaaeeaaaaaaeeaaafaaceaaaaaaeeaaaaaaaaaa
                    abababaaacacacaaadadadaaaeaeaeaaaaaaacaaadaaaaaaaaaaaaaaaaacpppp
                    fbaaaaafadaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaafaeaaapka
                    omafnblopdaedfdpdkmnbddpaaaaaaedfbaaaaafafaaapkaolafnblopdaedflp
                    dkmnbddpaaaaaaaafbaaaaafagaaapkaaaaaaaebdkmnbddpaaaaaaaaolaffbdp
                    bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaia
                    acaachlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaac
                    aaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkabpaaaaacaaaaaajaaeaiapka
                    abaaaaacaaaaadiaabaabllaabaaaaacabaaabiaaaaakklaabaaaaacabaaacia
                    aaaapplaecaaaaadacaacpiaaaaaoeiaadaioekaecaaaaadaaaacpiaaaaaoeia
                    aeaioekaecaaaaadabaacpiaabaaoeiaabaioekaecaaaaadadaacpiaaaaaoela
                    aaaioekaecaaaaadaeaaapiaabaaoelaacaioekaafaaaaadacaaciiaacaappia
                    agaaaakaafaaaaadacaachiaacaaoeiaacaappiaafaaaaadaaaaciiaaaaappia
                    agaaaakaafaaaaadaaaachiaaaaaoeiaaaaappiaaeaaaaaeafaacbiaabaappia
                    adaaaakaadaaffkaaeaaaaaeafaacciaabaaffiaadaaaakaadaaffkafkaaaaae
                    aaaadiiaafaaoeiaafaaoeiaadaakkkaacaaaaadaaaaciiaaaaappibadaappka
                    ahaaaaacaaaaciiaaaaappiaagaaaaacafaaceiaaaaappiaaiaaaaadabaadbia
                    agaablkaafaaoeiaaiaaaaadabaadciaaeaaoekaafaaoeiaaiaaaaadabaadeia
                    afaaoekaafaaoeiaaiaaaaadaaaaciiaabaaoeiaaaaaoeiaafaaaaadabaachia
                    aaaappiaacaaoeiaafaaaaadacaachiaabaaoeiaaaaaoekaafaaaaadacaaahia
                    adaappiaacaaoeiaafaaaaadadaachiaadaaoeiaabaaoekaafaaaaadabaachia
                    abaaoeiaadaaoeiaafaaaaadadaaahiaaaaaffiaaeaaoekaaeaaaaaeadaaahia
                    aaaaaaiaagaablkaadaaoeiaaeaaaaaeaaaaahiaaaaakkiaafaaoekaadaaoeia
                    aiaaaaadaaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiiaaaaappiaceaaaaac
                    adaachiaacaaoelaaeaaaaaeaaaachiaaaaaoeiaaaaappiaadaaoeiaceaaaaac
                    adaachiaaaaaoeiaaiaaaaadabaaciiaafaaoeiaadaaoeiaalaaaaadacaaaiia
                    abaappiaadaakkkaabaaaaacabaaaiiaaeaappkaafaaaaadabaaaiiaabaappia
                    acaaaakacaaaaaadaaaacbiaacaappiaabaappiaaeaaaaaeaaaachiaacaaoeia
                    aaaaaaiaabaaoeiaaeaaaaaeaaaachiaaeaaoeiaaeaappiaaaaaoeiaabaaaaac
                    abaaaiiaabaappkaafaaaaadaaaaciiaabaappiaacaaffkaabaaaaacaaaicpia
                    aaaaoeiappppaaaafdeieefcfmagaaaaeaaaaaaajhabaaaafjaaaaaeegiocaaa
                    aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
                    fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
                    aeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
                    ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaa
                    ffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
                    gcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaagcbaaaadhcbabaaa
                    adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaabaaaaaahbcaabaaa
                    aaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaa
                    akaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaa
                    adaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaaeaaaaaa
                    aagabaaaaeaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaa
                    aaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
                    diaaaaakhcaabaaaacaaaaaafgafbaaaabaaaaaaaceaaaaaomafnblopdaedfdp
                    dkmnbddpaaaaaaaadcaaaaamhcaabaaaacaaaaaaagaabaaaabaaaaaaaceaaaaa
                    olaffbdpaaaaaaaadkmnbddpaaaaaaaaegacbaaaacaaaaaadcaaaaamhcaabaaa
                    acaaaaaakgakbaaaabaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaa
                    egacbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
                    acaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaa
                    aaaaaaaaegacbaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaah
                    icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
                    aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
                    egacbaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaa
                    abaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaaacaaaaaa
                    aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
                    aaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaacaaaaaaegaabaaa
                    acaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadp
                    aaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
                    elaaaaafecaabaaaacaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaa
                    egacbaaaacaaaaaaegacbaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaa
                    aaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
                    diaaaaaiccaabaaaaaaaaaaaakiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaed
                    diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabjaaaaaf
                    bcaabaaaaaaaaaaaakaabaaaaaaaaaaaapcaaaakbcaabaaaadaaaaaaaceaaaaa
                    olaffbdpdkmnbddpaaaaaaaaaaaaaaaaigaabaaaacaaaaaabacaaaakccaabaaa
                    adaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaaegacbaaaacaaaaaa
                    bacaaaakecaabaaaadaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaa
                    egacbaaaacaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaa
                    abaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaadaaaaaa
                    aagabaaaadaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaa
                    aaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaakgakbaaaaaaaaaaa
                    diaaaaahocaabaaaaaaaaaaafgafbaaaaaaaaaaaagajbaaaabaaaaaadiaaaaai
                    hcaabaaaabaaaaaajgahbaaaaaaaaaaaegiccaaaaaaaaaaaacaaaaaaefaaaaaj
                    pcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
                    diaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaacaaaaaadiaaaaai
                    hcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaah
                    ocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaaacaaaaaadcaaaaajhcaabaaa
                    aaaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaaefaaaaaj
                    pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
                    dcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaaegacbaaa
                    aaaaaaaadiaaaaajiccabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaabkiacaaa
                    aaaaaaaaaeaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
                    aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    adadaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaaimaaaaaa
                    adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
                    feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
                    "
                }
                SubProgram "opengl " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
                    Vector 0 [_LightColor0]
                    Vector 1 [_SpecColor]
                    Vector 2 [_Color]
                    Float 3 [_Shininess]
                    Float 4 [_Opacity]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_ResourceMap] 2D 2
                    SetTexture 3 [_ShadowMapTexture] 2D 3
                    "!!ARBfp1.0
                    PARAM c[6] = { program.local[0..4],
                    { 2, 1, 0, 128 } };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    TEMP R4;
                    TEX R0, fragment.texcoord[0], texture[0], 2D;
                    TEX R3.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
                    TEX R1, fragment.texcoord[1], texture[2], 2D;
                    TXP R4.x, fragment.texcoord[5], texture[3], 2D;
                    MAD R3.xy, R3.wyzw, c[5].x, -c[5].y;
                    DP3 R2.w, fragment.texcoord[4], fragment.texcoord[4];
                    MUL R3.zw, R3.xyxy, R3.xyxy;
                    RSQ R2.w, R2.w;
                    MOV R2.xyz, fragment.texcoord[2];
                    MAD R2.xyz, R2.w, fragment.texcoord[4], R2;
                    ADD_SAT R2.w, R3.z, R3;
                    DP3 R3.z, R2, R2;
                    RSQ R3.z, R3.z;
                    ADD R2.w, -R2, c[5].y;
                    MUL R2.xyz, R3.z, R2;
                    RSQ R2.w, R2.w;
                    RCP R3.z, R2.w;
                    DP3 R2.x, R3, R2;
                    MOV R2.w, c[5];
                    DP3 R3.x, R3, fragment.texcoord[2];
                    MAX R3.w, R3.x, c[5].z;
                    MUL R0.xyz, R0, c[2];
                    MUL R3.xyz, R0, c[0];
                    MUL R3.xyz, R3, R3.w;
                    MUL R2.y, R2.w, c[3].x;
                    MAX R2.x, R2, c[5].z;
                    POW R2.x, R2.x, R2.y;
                    MUL R0.w, R0, R2.x;
                    MOV R2, c[1];
                    MUL R2.xyz, R2, c[0];
                    MAD R2.xyz, R2, R0.w, R3;
                    MUL R3.w, R4.x, c[5].x;
                    MUL R2.xyz, R2, R3.w;
                    MAD R0.xyz, R0, fragment.texcoord[3], R2;
                    MUL R2.x, R2.w, c[0].w;
                    MUL R1.xyz, R1, R1.w;
                    ADD result.color.xyz, R0, R1;
                    MUL R0.w, R0, R2.x;
                    MUL R0.y, R4.x, R0.w;
                    MOV R0.x, c[4];
                    MAD result.color.w, R0.x, c[2], R0.y;
                    END
# 41 instructions, 5 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
                    Vector 0 [_LightColor0]
                    Vector 1 [_SpecColor]
                    Vector 2 [_Color]
                    Float 3 [_Shininess]
                    Float 4 [_Opacity]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_ResourceMap] 2D 2
                    SetTexture 3 [_ShadowMapTexture] 2D 3
                    "ps_2_0
                    dcl_2d s0
                    dcl_2d s1
                    dcl_2d s2
                    dcl_2d s3
                    def c5, 2.00000000, -1.00000000, 1.00000000, 0.00000000
                    def c6, 128.00000000, 0, 0, 0
                    dcl t0
                    dcl t1.xy
                    dcl t2.xyz
                    dcl t3.xyz
                    dcl t4.xyz
                    dcl t5
                    texld r2, t1, s2
                    texldp r6, t5, s3
                    texld r3, t0, s0
                    dp3_pp r1.x, t4, t4
                    rsq_pp r1.x, r1.x
                    mov_pp r5.xyz, t2
                    mad_pp r5.xyz, r1.x, t4, r5
                    dp3_pp r1.x, r5, r5
                    rsq_pp r1.x, r1.x
                    mul_pp r1.xyz, r1.x, r5
                    mul_pp r3.xyz, r3, c2
                    mov r0.y, t0.w
                    mov r0.x, t0.z
                    texld r0, r0, s1
                    mov r0.x, r0.w
                    mad_pp r4.xy, r0, c5.x, c5.y
                    mul_pp r0.xy, r4, r4
                    add_pp_sat r0.x, r0, r0.y
                    add_pp r0.x, -r0, c5.z
                    rsq_pp r0.x, r0.x
                    rcp_pp r4.z, r0.x
                    dp3_pp r1.x, r4, r1
                    mov_pp r0.x, c3
                    mul_pp r0.x, c6, r0
                    max_pp r1.x, r1, c5.w
                    pow r5.w, r1.x, r0.x
                    mov r0.x, r5.w
                    mov_pp r0.w, c0
                    mul_pp r1.x, c1.w, r0.w
                    mul r0.x, r3.w, r0
                    mul r1.x, r0, r1
                    mul r1.x, r6, r1
                    mov r0.w, c2
                    mad r0.w, c4.x, r0, r1.x
                    dp3_pp r1.x, r4, t2
                    mov_pp r4.xyz, c0
                    max_pp r1.x, r1, c5.w
                    mul_pp r5.xyz, r3, c0
                    mul_pp r1.xyz, r5, r1.x
                    mul_pp r4.xyz, c1, r4
                    mad r1.xyz, r4, r0.x, r1
                    mul_pp r0.x, r6, c5
                    mul r0.xyz, r1, r0.x
                    mul r1.xyz, r2, r2.w
                    mad_pp r0.xyz, r3, t3, r0
                    add_pp r0.xyz, r0, r1
                    mov_pp oC0, r0
                    "
                }
                SubProgram "d3d11 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
                    SetTexture 0 [_MainTex] 2D 1
                    SetTexture 1 [_BumpMap] 2D 2
                    SetTexture 2 [_ResourceMap] 2D 3
                    SetTexture 3 [_ShadowMapTexture] 2D 0
                    ConstBuffer "$Globals" 192
                    Vector 16 [_LightColor0]
                    Vector 32 [_SpecColor]
                    Vector 112 [_Color]
                    Float 128 [_Shininess]
                    Float 132 [_Opacity]
                    BindCB  "$Globals" 0
                    "ps_4_0
                    eefiecedemljgehncagjhdaoeoagboaadikbklbdabaaaaaagaagaaaaadaaaaaa
                    cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
                    aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    adadaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaa
                    adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
                    adaaaaaaafaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
                    apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
                    cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
                    apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcciafaaaaeaaaaaaaekabaaaa
                    fjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
                    aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
                    fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
                    fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
                    gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadhcbabaaa
                    adaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaad
                    lcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaabaaaaaah
                    bcaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaafbcaabaaa
                    aaaaaaaaakaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegbcbaaaafaaaaaa
                    agaabaaaaaaaaaaaegbcbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
                    aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
                    diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaaj
                    pcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
                    dcaaaaapdcaabaaaabaaaaaahgapbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
                    aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaah
                    icaabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaabaaaaaaddaaaaahicaabaaa
                    aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaa
                    dkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaabaaaaaa
                    dkaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
                    aaaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaaegbcbaaaadaaaaaa
                    deaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
                    aaaaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
                    ecaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaah
                    bcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaabjaaaaafbcaabaaa
                    aaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaa
                    eghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
                    aaaaaaaadkaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
                    egiccaaaaaaaaaaaahaaaaaadiaaaaajpcaabaaaacaaaaaaegiocaaaaaaaaaaa
                    abaaaaaaegiocaaaaaaaaaaaacaaaaaadiaaaaahpcaabaaaacaaaaaaagaabaaa
                    aaaaaaaaegaobaaaacaaaaaadiaaaaaincaabaaaaaaaaaaaagajbaaaabaaaaaa
                    agijcaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
                    egbcbaaaaeaaaaaadcaaaaajhcaabaaaaaaaaaaaigadbaaaaaaaaaaafgafbaaa
                    aaaaaaaaegacbaaaacaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaaagaaaaaa
                    pgbpbaaaagaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaacaaaaaaeghobaaa
                    adaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaaakaabaaaadaaaaaa
                    akaabaaaadaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaacaaaaaaakaabaaa
                    adaaaaaadcaaaaaliccabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaabkiacaaa
                    aaaaaaaaaiaaaaaadkaabaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
                    aaaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
                    egbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaadcaaaaajhccabaaa
                    aaaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaaegacbaaaaaaaaaaadoaaaaab
                    "
                }
                SubProgram "d3d11_9x " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
                    SetTexture 0 [_MainTex] 2D 1
                    SetTexture 1 [_BumpMap] 2D 2
                    SetTexture 2 [_ResourceMap] 2D 3
                    SetTexture 3 [_ShadowMapTexture] 2D 0
                    ConstBuffer "$Globals" 192
                    Vector 16 [_LightColor0]
                    Vector 32 [_SpecColor]
                    Vector 112 [_Color]
                    Float 128 [_Shininess]
                    Float 132 [_Opacity]
                    BindCB  "$Globals" 0
                    "ps_4_0_level_9_1
                    eefiecedmnckbpllbbmngnfienglkbiphgcpfhlbabaaaaaapmajaaaaaeaaaaaa
                    daaaaaaamiadaaaapiaiaaaamiajaaaaebgpgodjjaadaaaajaadaaaaaaacpppp
                    eeadaaaaemaaaaaaacaadeaaaaaaemaaaaaaemaaaeaaceaaaaaaemaaadaaaaaa
                    aaababaaabacacaaacadadaaaaaaabaaacaaaaaaaaaaaaaaaaaaahaaacaaacaa
                    aaaaaaaaaaacppppfbaaaaafaeaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadp
                    fbaaaaafafaaapkaaaaaaaedaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
                    aaaaaplabpaaaaacaaaaaaiaabaaadlabpaaaaacaaaaaaiaacaachlabpaaaaac
                    aaaaaaiaadaachlabpaaaaacaaaaaaiaaeaachlabpaaaaacaaaaaaiaafaaapla
                    bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaaja
                    acaiapkabpaaaaacaaaaaajaadaiapkaaiaaaaadaaaaciiaaeaaoelaaeaaoela
                    ahaaaaacaaaacbiaaaaappiaabaaaaacabaaahiaaeaaoelaaeaaaaaeaaaachia
                    abaaoeiaaaaaaaiaacaaoelaceaaaaacabaachiaaaaaoeiaabaaaaacaaaaabia
                    aaaakklaabaaaaacaaaaaciaaaaapplaagaaaaacabaaaiiaafaapplaafaaaaad
                    acaaadiaabaappiaafaaoelaecaaaaadaaaacpiaaaaaoeiaacaioekaecaaaaad
                    adaacpiaaaaaoelaabaioekaecaaaaadacaacpiaacaaoeiaaaaioekaecaaaaad
                    aeaaapiaabaaoelaadaioekaaeaaaaaeafaacbiaaaaappiaaeaaaakaaeaaffka
                    aeaaaaaeafaacciaaaaaffiaaeaaaakaaeaaffkafkaaaaaeabaadiiaafaaoeia
                    afaaoeiaaeaakkkaacaaaaadabaaciiaabaappibaeaappkaahaaaaacabaaciia
                    abaappiaagaaaaacafaaceiaabaappiaaiaaaaadafaaciiaafaaoeiaabaaoeia
                    aiaaaaadaaaacbiaafaaoeiaacaaoelaalaaaaadabaacbiaaaaaaaiaaeaakkka
                    alaaaaadaaaaabiaafaappiaaeaakkkaabaaaaacafaaadiaadaaoekaafaaaaad
                    aaaaaciaafaaaaiaafaaaakacaaaaaadabaaaciaaaaaaaiaaaaaffiaafaaaaad
                    adaaaiiaadaappiaabaaffiaafaaaaadaaaachiaadaaoeiaacaaoekaabaaaaac
                    agaaapiaaaaaoekaafaaaaadabaaaoiaagaabliaabaablkaafaaaaadabaaaoia
                    adaappiaabaaoeiaafaaaaadacaacoiaaaaabliaaaaablkaafaaaaadaaaachia
                    aaaaoeiaadaaoelaaeaaaaaeabaaahiaacaabliaabaaaaiaabaabliaacaaaaad
                    aaaaaiiaacaaaaiaacaaaaiaaeaaaaaeaaaachiaabaaoeiaaaaappiaaaaaoeia
                    aeaaaaaeaaaachiaaeaaoeiaaeaappiaaaaaoeiaafaaaaadabaaabiaagaappia
                    abaappkaafaaaaadabaaabiaadaappiaabaaaaiaafaaaaadabaaabiaacaaaaia
                    abaaaaiaaeaaaaaeaaaaciiaacaappkaafaaffiaabaaaaiaabaaaaacaaaicpia
                    aaaaoeiappppaaaafdeieefcciafaaaaeaaaaaaaekabaaaafjaaaaaeegiocaaa
                    aaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
                    fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaa
                    aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
                    acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaa
                    abaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaad
                    hcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadlcbabaaaagaaaaaa
                    gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaabaaaaaahbcaabaaaaaaaaaaa
                    egbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
                    aaaaaaaadcaaaaajhcaabaaaaaaaaaaaegbcbaaaafaaaaaaagaabaaaaaaaaaaa
                    egbcbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
                    aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
                    aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
                    ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaa
                    abaaaaaahgapbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
                    aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaa
                    egaabaaaabaaaaaaegaabaaaabaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaa
                    aaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
                    aaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaabaaaaaadkaabaaaaaaaaaaa
                    baaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaabaaaaaah
                    ccaabaaaaaaaaaaaegacbaaaabaaaaaaegbcbaaaadaaaaaadeaaaaakdcaabaaa
                    aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
                    cpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiecaabaaaaaaaaaaa
                    akiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaaaaaaaaa
                    akaabaaaaaaaaaaackaabaaaaaaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaa
                    aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
                    aagabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaa
                    abaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
                    ahaaaaaadiaaaaajpcaabaaaacaaaaaaegiocaaaaaaaaaaaabaaaaaaegiocaaa
                    aaaaaaaaacaaaaaadiaaaaahpcaabaaaacaaaaaaagaabaaaaaaaaaaaegaobaaa
                    acaaaaaadiaaaaaincaabaaaaaaaaaaaagajbaaaabaaaaaaagijcaaaaaaaaaaa
                    abaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegbcbaaaaeaaaaaa
                    dcaaaaajhcaabaaaaaaaaaaaigadbaaaaaaaaaaafgafbaaaaaaaaaaaegacbaaa
                    acaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaaagaaaaaapgbpbaaaagaaaaaa
                    efaaaaajpcaabaaaadaaaaaaegaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaa
                    aaaaaaaaaaaaaaahicaabaaaaaaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaa
                    diaaaaahicaabaaaabaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaadcaaaaal
                    iccabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaabkiacaaaaaaaaaaaaiaaaaaa
                    dkaabaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaa
                    aaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaa
                    eghobaaaacaaaaaaaagabaaaadaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaa
                    abaaaaaapgapbaaaabaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheomiaaaaaa
                    ahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
                    lmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaa
                    aaaaaaaaadaaaaaaacaaaaaaadadaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaa
                    adaaaaaaahahaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaa
                    lmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahahaaaalmaaaaaaafaaaaaa
                    aaaaaaaaadaaaaaaagaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffied
                    epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
                    aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
                }
                SubProgram "opengl " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
                    Vector 0 [_Color]
                    Float 1 [_Opacity]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 2 [_ResourceMap] 2D 2
                    SetTexture 3 [_ShadowMapTexture] 2D 3
                    SetTexture 4 [unity_Lightmap] 2D 4
                    "!!ARBfp1.0
                    PARAM c[3] = { program.local[0..1],
                    { 8, 2 } };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    TEMP R4;
                    TEX R0, fragment.texcoord[2], texture[4], 2D;
                    TEX R1, fragment.texcoord[1], texture[2], 2D;
                    TEX R2.xyz, fragment.texcoord[0], texture[0], 2D;
                    TXP R4.x, fragment.texcoord[3], texture[3], 2D;
                    MUL R3.xyz, R0.w, R0;
                    MUL R0.xyz, R0, R4.x;
                    MUL R3.xyz, R3, c[2].x;
                    MUL R0.xyz, R0, c[2].y;
                    MOV R0.w, c[1].x;
                    MUL R4.xyz, R3, R4.x;
                    MIN R0.xyz, R3, R0;
                    MAX R0.xyz, R0, R4;
                    MUL R1.xyz, R1, R1.w;
                    MUL R2.xyz, R2, c[0];
                    MAD result.color.xyz, R2, R0, R1;
                    MUL result.color.w, R0, c[0];
                    END
# 16 instructions, 5 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
                    Vector 0 [_Color]
                    Float 1 [_Opacity]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 2 [_ResourceMap] 2D 2
                    SetTexture 3 [_ShadowMapTexture] 2D 3
                    SetTexture 4 [unity_Lightmap] 2D 4
                    "ps_2_0
                    dcl_2d s0
                    dcl_2d s2
                    dcl_2d s3
                    dcl_2d s4
                    def c2, 8.00000000, 2.00000000, 0, 0
                    dcl t0.xy
                    dcl t1.xy
                    dcl t2.xy
                    dcl t3
                    texld r1, t1, s2
                    texld r2, t0, s0
                    texldp r3, t3, s3
                    texld r0, t2, s4
                    mul_pp r4.xyz, r0, r3.x
                    mul_pp r0.xyz, r0.w, r0
                    mov r0.w, c0
                    mul_pp r0.xyz, r0, c2.x
                    mul_pp r4.xyz, r4, c2.y
                    min_pp r4.xyz, r0, r4
                    mul_pp r0.xyz, r0, r3.x
                    max_pp r0.xyz, r4, r0
                    mul_pp r2.xyz, r2, c0
                    mul r1.xyz, r1, r1.w
                    mul r0.w, c1.x, r0
                    mad_pp r0.xyz, r2, r0, r1
                    mov_pp oC0, r0
                    "
                }
                SubProgram "d3d11 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
                    SetTexture 0 [_MainTex] 2D 1
                    SetTexture 1 [_ResourceMap] 2D 2
                    SetTexture 2 [_ShadowMapTexture] 2D 0
                    SetTexture 3 [unity_Lightmap] 2D 3
                    ConstBuffer "$Globals" 208
                    Vector 112 [_Color]
                    Float 132 [_Opacity]
                    BindCB  "$Globals" 0
                    "ps_4_0
                    eefiecedndmefapbmchjmdnjpeigilkekonogkndabaaaaaammadaaaaadaaaaaa
                    cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
                    aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    adadaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaaimaaaaaa
                    adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaa
                    feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
                    fdeieefcmeacaaaaeaaaaaaalbaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
                    fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
                    acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
                    fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
                    fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
                    dcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaa
                    gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaa
                    egbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
                    aaaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
                    akaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
                    acaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahocaabaaaaaaaaaaa
                    fgafbaaaaaaaaaaaagajbaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
                    abaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
                    pgapbaaaabaaaaaaddaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaa
                    abaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
                    deaaaaahhcaabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaaj
                    pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
                    diaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaahaaaaaa
                    efaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
                    acaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaacaaaaaaegacbaaaacaaaaaa
                    dcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaegacbaaa
                    acaaaaaadiaaaaajiccabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaabkiacaaa
                    aaaaaaaaaiaaaaaadoaaaaab"
                }
                SubProgram "d3d11_9x " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
                    SetTexture 0 [_MainTex] 2D 1
                    SetTexture 1 [_ResourceMap] 2D 2
                    SetTexture 2 [_ShadowMapTexture] 2D 0
                    SetTexture 3 [unity_Lightmap] 2D 3
                    ConstBuffer "$Globals" 208
                    Vector 112 [_Color]
                    Float 132 [_Opacity]
                    BindCB  "$Globals" 0
                    "ps_4_0_level_9_1
                    eefiecedjllfnglnmlcelhcjaojfdpgmigfbdbplabaaaaaamaafaaaaaeaaaaaa
                    daaaaaaacaacaaaaomaeaaaaimafaaaaebgpgodjoiabaaaaoiabaaaaaaacpppp
                    kiabaaaaeaaaaaaaabaadeaaaaaaeaaaaaaaeaaaaeaaceaaaaaaeaaaacaaaaaa
                    aaababaaabacacaaadadadaaaaaaahaaacaaaaaaaaaaaaaaaaacppppfbaaaaaf
                    acaaapkaaaaaaaebaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaapla
                    bpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaiaacaaaplabpaaaaacaaaaaaja
                    aaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaac
                    aaaaaajaadaiapkaagaaaaacaaaaaiiaacaapplaafaaaaadaaaaadiaaaaappia
                    acaaoelaabaaaaacabaaadiaabaabllaecaaaaadaaaacpiaaaaaoeiaaaaioeka
                    ecaaaaadabaacpiaabaaoeiaadaioekaecaaaaadacaacpiaaaaaoelaabaioeka
                    ecaaaaadadaaapiaabaaoelaacaioekaacaaaaadacaaciiaaaaaaaiaaaaaaaia
                    afaaaaadaaaacoiaabaabliaacaappiaafaaaaadabaaciiaabaappiaacaaaaka
                    afaaaaadabaachiaabaaoeiaabaappiaakaaaaadaeaachiaaaaabliaabaaoeia
                    afaaaaadaaaachiaaaaaaaiaabaaoeiaalaaaaadabaachiaaeaaoeiaaaaaoeia
                    afaaaaadaaaachiaacaaoeiaaaaaoekaafaaaaadacaachiaadaappiaadaaoeia
                    aeaaaaaeaaaachiaaaaaoeiaabaaoeiaacaaoeiaabaaaaacabaaaiiaaaaappka
                    afaaaaadaaaaciiaabaappiaabaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaa
                    fdeieefcmeacaaaaeaaaaaaalbaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
                    fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
                    acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
                    fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
                    fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
                    dcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaa
                    gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaa
                    egbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
                    aaaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
                    akaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
                    acaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahocaabaaaaaaaaaaa
                    fgafbaaaaaaaaaaaagajbaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
                    abaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
                    pgapbaaaabaaaaaaddaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaa
                    abaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
                    deaaaaahhcaabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaaj
                    pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
                    diaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaahaaaaaa
                    efaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
                    acaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaacaaaaaaegacbaaaacaaaaaa
                    dcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaegacbaaa
                    acaaaaaadiaaaaajiccabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaabkiacaaa
                    aaaaaaaaaiaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
                    aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    adadaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaaimaaaaaa
                    adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaa
                    feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
                    "
                }
                SubProgram "opengl " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
                    Vector 0 [_SpecColor]
                    Vector 1 [_Color]
                    Float 2 [_Shininess]
                    Float 3 [_Opacity]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_ResourceMap] 2D 2
                    SetTexture 3 [_ShadowMapTexture] 2D 3
                    SetTexture 4 [unity_Lightmap] 2D 4
                    SetTexture 5 [unity_LightmapInd] 2D 5
                    "!!ARBfp1.0
                    PARAM c[8] = { program.local[0..3],
                    { 2, 1, 8, 0 },
                    { -0.40824828, -0.70710677, 0.57735026, 128 },
                    { -0.40824831, 0.70710677, 0.57735026 },
                    { 0.81649655, 0, 0.57735026 } };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    TEMP R4;
                    TEMP R5;
                    TEMP R6;
                    TEX R1, fragment.texcoord[0], texture[0], 2D;
                    TEX R4, fragment.texcoord[2], texture[5], 2D;
                    TEX R2, fragment.texcoord[2], texture[4], 2D;
                    TXP R6.x, fragment.texcoord[4], texture[3], 2D;
                    TEX R0, fragment.texcoord[1], texture[2], 2D;
                    TEX R3.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
                    MUL R4.xyz, R4.w, R4;
                    MUL R4.xyz, R4, c[4].z;
                    MUL R5.xyz, R4.y, c[6];
                    MAD R5.xyz, R4.x, c[7], R5;
                    MAD R5.xyz, R4.z, c[5], R5;
                    DP3 R3.x, R5, R5;
                    RSQ R3.z, R3.x;
                    MAD R3.xy, R3.wyzw, c[4].x, -c[4].y;
                    MUL R5.xyz, R3.z, R5;
                    MUL R3.zw, R3.xyxy, R3.xyxy;
                    ADD_SAT R3.w, R3.z, R3;
                    DP3 R4.w, fragment.texcoord[3], fragment.texcoord[3];
                    RSQ R3.z, R4.w;
                    MAD R5.xyz, R3.z, fragment.texcoord[3], R5;
                    ADD R3.w, -R3, c[4].y;
                    DP3 R3.z, R5, R5;
                    RSQ R4.w, R3.w;
                    RSQ R3.w, R3.z;
                    RCP R3.z, R4.w;
                    DP3_SAT R6.w, R3, c[5];
                    DP3_SAT R6.y, R3, c[7];
                    DP3_SAT R6.z, R3, c[6];
                    MUL R5.xyz, R3.w, R5;
                    DP3 R3.w, R6.yzww, R4;
                    MUL R4.xyz, R2.w, R2;
                    MUL R2.xyz, R2, R6.x;
                    DP3 R2.w, R3, R5;
                    MUL R4.xyz, R4, R3.w;
                    MUL R4.xyz, R4, c[4].z;
                    MUL R6.yzw, R2.xxyz, c[4].x;
                    MUL R2.xyz, R4, R6.x;
                    MIN R6.xyz, R4, R6.yzww;
                    MOV R3.x, c[5].w;
                    MAX R3.w, R2, c[4];
                    MUL R2.w, R3.x, c[2].x;
                    MUL R3.xyz, R4, c[0];
                    MUL R1.xyz, R1, c[1];
                    MAX R2.xyz, R6, R2;
                    POW R2.w, R3.w, R2.w;
                    MUL R3.xyz, R1.w, R3;
                    MUL R3.xyz, R3, R2.w;
                    MAD R2.xyz, R1, R2, R3;
                    MUL R1.xyz, R0, R0.w;
                    MOV R0.x, c[3];
                    ADD result.color.xyz, R2, R1;
                    MUL result.color.w, R0.x, c[1];
                    END
# 52 instructions, 7 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
                    Vector 0 [_SpecColor]
                    Vector 1 [_Color]
                    Float 2 [_Shininess]
                    Float 3 [_Opacity]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_ResourceMap] 2D 2
                    SetTexture 3 [_ShadowMapTexture] 2D 3
                    SetTexture 4 [unity_Lightmap] 2D 4
                    SetTexture 5 [unity_LightmapInd] 2D 5
                    "ps_2_0
                    dcl_2d s0
                    dcl_2d s1
                    dcl_2d s2
                    dcl_2d s3
                    dcl_2d s4
                    dcl_2d s5
                    def c4, 2.00000000, -1.00000000, 1.00000000, 8.00000000
                    def c5, -0.40824828, -0.70710677, 0.57735026, 0.00000000
                    def c6, -0.40824831, 0.70710677, 0.57735026, 128.00000000
                    def c7, 0.81649655, 0.00000000, 0.57735026, 0
                    dcl t0
                    dcl t1.xy
                    dcl t2.xy
                    dcl t3.xyz
                    dcl t4
                    texldp r3, t4, s3
                    texld r1, t1, s2
                    texld r2, t0, s0
                    texld r4, t2, s4
                    texld r5, t2, s5
                    mul_pp r5.xyz, r5.w, r5
                    mul_pp r5.xyz, r5, c4.w
                    mul r6.xyz, r5.y, c6
                    mad r6.xyz, r5.x, c7, r6
                    mad r6.xyz, r5.z, c5, r6
                    mov r0.y, t0.w
                    mov r0.x, t0.z
                    mul_pp r2.xyz, r2, c1
                    mul r1.xyz, r1, r1.w
                    texld r0, r0, s1
                    dp3 r0.x, r6, r6
                    rsq r0.x, r0.x
                    mul r6.xyz, r0.x, r6
                    mov r0.x, r0.w
                    mad_pp r8.xy, r0, c4.x, c4.y
                    dp3_pp r0.x, t3, t3
                    rsq_pp r0.x, r0.x
                    mov r0.w, c1
                    mad_pp r0.xyz, r0.x, t3, r6
                    mul_pp r7.xy, r8, r8
                    add_pp_sat r6.x, r7, r7.y
                    dp3_pp r7.x, r0, r0
                    rsq_pp r7.x, r7.x
                    add_pp r6.x, -r6, c4.z
                    rsq_pp r6.x, r6.x
                    rcp_pp r8.z, r6.x
                    mul_pp r0.xyz, r7.x, r0
                    dp3_pp r0.x, r8, r0
                    mov_pp r6.x, c2
                    max_pp r0.x, r0, c5.w
                    mul_pp r6.x, c6.w, r6
                    pow r7.x, r0.x, r6.x
                    dp3_pp_sat r0.z, r8, c5
                    dp3_pp_sat r0.y, r8, c6
                    dp3_pp_sat r0.x, r8, c7
                    dp3_pp r0.x, r0, r5
                    mul_pp r5.xyz, r4.w, r4
                    mul_pp r4.xyz, r4, r3.x
                    mul_pp r0.xyz, r5, r0.x
                    mul_pp r0.xyz, r0, c4.w
                    mul_pp r4.xyz, r4, c4.x
                    min_pp r4.xyz, r0, r4
                    mul_pp r3.xyz, r0, r3.x
                    mul_pp r0.xyz, r0, c0
                    max_pp r3.xyz, r4, r3
                    mov r4.x, r7.x
                    mul_pp r0.xyz, r2.w, r0
                    mul r0.xyz, r0, r4.x
                    mad_pp r0.xyz, r2, r3, r0
                    mul r0.w, c3.x, r0
                    add_pp r0.xyz, r0, r1
                    mov_pp oC0, r0
                    "
                }
                SubProgram "d3d11 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
                    SetTexture 0 [_MainTex] 2D 1
                    SetTexture 1 [_BumpMap] 2D 2
                    SetTexture 2 [_ResourceMap] 2D 3
                    SetTexture 3 [_ShadowMapTexture] 2D 0
                    SetTexture 4 [unity_Lightmap] 2D 4
                    SetTexture 5 [unity_LightmapInd] 2D 5
                    ConstBuffer "$Globals" 208
                    Vector 32 [_SpecColor]
                    Vector 112 [_Color]
                    Float 128 [_Shininess]
                    Float 132 [_Opacity]
                    BindCB  "$Globals" 0
                    "ps_4_0
                    eefiecedlibgeiedcppogddpdcgigpfialfdfdjcabaaaaaahaaiaaaaadaaaaaa
                    cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
                    aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    adadaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaakeaaaaaa
                    adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
                    adaaaaaaaeaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
                    aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfaahaaaa
                    eaaaaaaaneabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaa
                    aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
                    aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaa
                    fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
                    fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
                    fibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaa
                    gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaa
                    acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadlcbabaaaaeaaaaaagfaaaaad
                    pccabaaaaaaaaaaagiaaaaacaeaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaa
                    adaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
                    diaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaaadaaaaaaefaaaaaj
                    pcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaafaaaaaaaagabaaaafaaaaaa
                    diaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaah
                    hcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaadiaaaaakhcaabaaa
                    acaaaaaafgafbaaaabaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaa
                    dcaaaaamhcaabaaaacaaaaaaagaabaaaabaaaaaaaceaaaaaolaffbdpaaaaaaaa
                    dkmnbddpaaaaaaaaegacbaaaacaaaaaadcaaaaamhcaabaaaacaaaaaakgakbaaa
                    abaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegacbaaaacaaaaaa
                    baaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaf
                    icaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
                    acaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
                    egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
                    aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
                    efaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
                    acaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaea
                    aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
                    apaaaaahicaabaaaaaaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaah
                    icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaa
                    aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
                    acaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaa
                    egacbaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
                    aaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiccaabaaa
                    aaaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaa
                    aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabjaaaaafbcaabaaaaaaaaaaa
                    akaabaaaaaaaaaaaapcaaaakbcaabaaaadaaaaaaaceaaaaaolaffbdpdkmnbddp
                    aaaaaaaaaaaaaaaaigaabaaaacaaaaaabacaaaakccaabaaaadaaaaaaaceaaaaa
                    omafnblopdaedfdpdkmnbddpaaaaaaaaegacbaaaacaaaaaabacaaaakecaabaaa
                    adaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegacbaaaacaaaaaa
                    baaaaaahccaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaaefaaaaaj
                    pcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaa
                    diaaaaahecaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaah
                    hcaabaaaacaaaaaaegacbaaaabaaaaaakgakbaaaaaaaaaaadiaaaaahocaabaaa
                    aaaaaaaafgafbaaaaaaaaaaaagajbaaaacaaaaaaaoaaaaahdcaabaaaacaaaaaa
                    egbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaa
                    acaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaaabaaaaaa
                    akaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahhcaabaaaacaaaaaajgahbaaa
                    aaaaaaaaagaabaaaacaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
                    pgapbaaaabaaaaaaddaaaaahhcaabaaaabaaaaaajgahbaaaaaaaaaaaegacbaaa
                    abaaaaaadiaaaaaiocaabaaaaaaaaaaafgaobaaaaaaaaaaaagijcaaaaaaaaaaa
                    acaaaaaadeaaaaahhcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
                    efaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
                    abaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaa
                    ahaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaapgapbaaaacaaaaaa
                    diaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadcaaaaaj
                    hcaabaaaaaaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
                    efaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
                    adaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaa
                    egacbaaaaaaaaaaadiaaaaajiccabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaa
                    bkiacaaaaaaaaaaaaiaaaaaadoaaaaab"
                }
                SubProgram "d3d11_9x " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
                    SetTexture 0 [_MainTex] 2D 1
                    SetTexture 1 [_BumpMap] 2D 2
                    SetTexture 2 [_ResourceMap] 2D 3
                    SetTexture 3 [_ShadowMapTexture] 2D 0
                    SetTexture 4 [unity_Lightmap] 2D 4
                    SetTexture 5 [unity_LightmapInd] 2D 5
                    ConstBuffer "$Globals" 208
                    Vector 32 [_SpecColor]
                    Vector 112 [_Color]
                    Float 128 [_Shininess]
                    Float 132 [_Opacity]
                    BindCB  "$Globals" 0
                    "ps_4_0_level_9_1
                    eefiecedhnnggbfainknmigennaeagolifmfidneabaaaaaapaamaaaaaeaaaaaa
                    daaaaaaakmaeaaaaaeamaaaalmamaaaaebgpgodjheaeaaaaheaeaaaaaaacpppp
                    caaeaaaafeaaaaaaacaadmaaaaaafeaaaaaafeaaagaaceaaaaaafeaaadaaaaaa
                    aaababaaabacacaaacadadaaaeaeaeaaafafafaaaaaaacaaabaaaaaaaaaaaaaa
                    aaaaahaaacaaabaaaaaaaaaaaaacppppfbaaaaafadaaapkaaaaaaaeaaaaaialp
                    aaaaaaaaaaaaiadpfbaaaaafaeaaapkaaaaaaaebdkmnbddpaaaaaaaaolaffbdp
                    fbaaaaafafaaapkaomafnblopdaedfdpdkmnbddpaaaaaaedfbaaaaafagaaapka
                    olafnblopdaedflpdkmnbddpaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaac
                    aaaaaaiaabaaaplabpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaaiaadaaapla
                    bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaaja
                    acaiapkabpaaaaacaaaaaajaadaiapkabpaaaaacaaaaaajaaeaiapkabpaaaaac
                    aaaaaajaafaiapkaabaaaaacaaaaabiaaaaakklaabaaaaacaaaaaciaaaaappla
                    abaaaaacabaaadiaabaabllaagaaaaacaaaaaeiaadaapplaafaaaaadacaaadia
                    aaaakkiaadaaoelaecaaaaadaaaacpiaaaaaoeiaacaioekaecaaaaadadaacpia
                    abaaoeiaafaioekaecaaaaadabaacpiaabaaoeiaaeaioekaecaaaaadacaacpia
                    acaaoeiaaaaioekaecaaaaadaeaacpiaaaaaoelaabaioekaecaaaaadafaaapia
                    abaaoelaadaioekaaeaaaaaeagaacbiaaaaappiaadaaaakaadaaffkaaeaaaaae
                    agaacciaaaaaffiaadaaaakaadaaffkafkaaaaaeagaadiiaagaaoeiaagaaoeia
                    adaakkkaacaaaaadagaaciiaagaappibadaappkaahaaaaacagaaciiaagaappia
                    agaaaaacagaaceiaagaappiaaiaaaaadaaaadbiaaeaablkaagaaoeiaaiaaaaad
                    aaaadciaafaaoekaagaaoeiaaiaaaaadaaaadeiaagaaoekaagaaoeiaafaaaaad
                    aaaaciiaadaappiaaeaaaakaafaaaaadadaachiaadaaoeiaaaaappiaaiaaaaad
                    adaaciiaaaaaoeiaadaaoeiaafaaaaadabaaciiaabaappiaaeaaaakaafaaaaad
                    aaaachiaabaaoeiaabaappiaafaaaaadaaaachiaadaappiaaaaaoeiaacaaaaad
                    aaaaciiaacaaaaiaacaaaaiaafaaaaadacaachiaacaaaaiaaaaaoeiaafaaaaad
                    abaachiaabaaoeiaaaaappiaakaaaaadahaachiaabaaoeiaaaaaoeiaafaaaaad
                    aaaachiaaaaaoeiaaaaaoekaalaaaaadabaachiaahaaoeiaacaaoeiaafaaaaad
                    acaachiaaeaaoeiaabaaoekaafaaaaadaaaaahiaaeaappiaaaaaoeiaafaaaaad
                    abaachiaabaaoeiaacaaoeiaafaaaaadacaaahiaadaaffiaafaaoekaaeaaaaae
                    acaaahiaadaaaaiaaeaablkaacaaoeiaaeaaaaaeacaaahiaadaakkiaagaaoeka
                    acaaoeiaaiaaaaadaaaaaiiaacaaoeiaacaaoeiaahaaaaacaaaaaiiaaaaappia
                    ceaaaaacadaachiaacaaoelaaeaaaaaeacaachiaacaaoeiaaaaappiaadaaoeia
                    ceaaaaacadaachiaacaaoeiaaiaaaaadaaaaciiaagaaoeiaadaaoeiaalaaaaad
                    abaaaiiaaaaappiaadaakkkaabaaaaacaaaaaiiaafaappkaafaaaaadaaaaaiia
                    aaaappiaacaaaakacaaaaaadacaacbiaabaappiaaaaappiaaeaaaaaeaaaachia
                    aaaaoeiaacaaaaiaabaaoeiaaeaaaaaeaaaachiaafaaoeiaafaappiaaaaaoeia
                    abaaaaacabaaaiiaabaappkaafaaaaadaaaaciiaabaappiaacaaffkaabaaaaac
                    aaaicpiaaaaaoeiappppaaaafdeieefcfaahaaaaeaaaaaaaneabaaaafjaaaaae
                    egiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
                    abaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaad
                    aagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafibiaaaeaahabaaaaaaaaaaa
                    ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
                    ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaa
                    ffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
                    gcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaagcbaaaadhcbabaaa
                    adaaaaaagcbaaaadlcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
                    aeaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaa
                    eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
                    agaabaaaaaaaaaaaegbcbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
                    acaaaaaaeghobaaaafaaaaaaaagabaaaafaaaaaadiaaaaahicaabaaaaaaaaaaa
                    dkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaa
                    abaaaaaapgapbaaaaaaaaaaadiaaaaakhcaabaaaacaaaaaafgafbaaaabaaaaaa
                    aceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaadcaaaaamhcaabaaaacaaaaaa
                    agaabaaaabaaaaaaaceaaaaaolaffbdpaaaaaaaadkmnbddpaaaaaaaaegacbaaa
                    acaaaaaadcaaaaamhcaabaaaacaaaaaakgakbaaaabaaaaaaaceaaaaaolafnblo
                    pdaedflpdkmnbddpaaaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaa
                    egacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
                    aaaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaacaaaaaapgapbaaaaaaaaaaa
                    egacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
                    aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
                    aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaa
                    ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaa
                    acaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
                    aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaa
                    egaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaa
                    aaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
                    aaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaadkaabaaaaaaaaaaa
                    baaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaadeaaaaah
                    bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaa
                    aaaaaaaaakaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaaakiacaaaaaaaaaaa
                    aiaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
                    bkaabaaaaaaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaaapcaaaak
                    bcaabaaaadaaaaaaaceaaaaaolaffbdpdkmnbddpaaaaaaaaaaaaaaaaigaabaaa
                    acaaaaaabacaaaakccaabaaaadaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddp
                    aaaaaaaaegacbaaaacaaaaaabacaaaakecaabaaaadaaaaaaaceaaaaaolafnblo
                    pdaedflpdkmnbddpaaaaaaaaegacbaaaacaaaaaabaaaaaahccaabaaaaaaaaaaa
                    egacbaaaadaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
                    acaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadiaaaaahecaabaaaaaaaaaaa
                    dkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaacaaaaaaegacbaaa
                    abaaaaaakgakbaaaaaaaaaaadiaaaaahocaabaaaaaaaaaaafgafbaaaaaaaaaaa
                    agajbaaaacaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaaaeaaaaaapgbpbaaa
                    aeaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaadaaaaaa
                    aagabaaaaaaaaaaaaaaaaaahicaabaaaabaaaaaaakaabaaaacaaaaaaakaabaaa
                    acaaaaaadiaaaaahhcaabaaaacaaaaaajgahbaaaaaaaaaaaagaabaaaacaaaaaa
                    diaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaaddaaaaah
                    hcaabaaaabaaaaaajgahbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaiocaabaaa
                    aaaaaaaafgaobaaaaaaaaaaaagijcaaaaaaaaaaaacaaaaaadeaaaaahhcaabaaa
                    abaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
                    egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaaihcaabaaa
                    acaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaahocaabaaa
                    aaaaaaaafgaobaaaaaaaaaaapgapbaaaacaaaaaadiaaaaahhcaabaaaabaaaaaa
                    egacbaaaabaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaajgahbaaa
                    aaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
                    egbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaadcaaaaajhccabaaa
                    aaaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaaegacbaaaaaaaaaaadiaaaaaj
                    iccabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaabkiacaaaaaaaaaaaaiaaaaaa
                    doaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
                    adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
                    apapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaakeaaaaaa
                    acaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaakeaaaaaaadaaaaaaaaaaaaaa
                    adaaaaaaadaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
                    apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
                    cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
                    apaaaaaafdfgfpfegbhcghgfheaaklkl"
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
                    Vector 20 [_MainTex_ST]
                    Vector 21 [_BumpMap_ST]
                    "!!ARBvp1.0
                    PARAM c[22] = { { 1 },
                    state.matrix.mvp,
                    program.local[5..21] };
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
                    DP3 result.texcoord[1].y, R0, R1;
                    DP3 result.texcoord[1].z, vertex.normal, R0;
                    DP3 result.texcoord[1].x, R0, vertex.attrib[14];
                    DP4 R0.w, vertex.position, c[8];
                    DP4 R0.z, vertex.position, c[7];
                    DP4 R0.x, vertex.position, c[5];
                    DP4 R0.y, vertex.position, c[6];
                    DP3 result.texcoord[2].y, R1, R2;
                    DP3 result.texcoord[2].z, vertex.normal, R2;
                    DP3 result.texcoord[2].x, vertex.attrib[14], R2;
                    DP4 result.texcoord[3].z, R0, c[15];
                    DP4 result.texcoord[3].y, R0, c[14];
                    DP4 result.texcoord[3].x, R0, c[13];
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
                    DP4 result.position.w, vertex.position, c[4];
                    DP4 result.position.z, vertex.position, c[3];
                    DP4 result.position.y, vertex.position, c[2];
                    DP4 result.position.x, vertex.position, c[1];
                    END
# 34 instructions, 4 R-regs
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
                    Vector 19 [_MainTex_ST]
                    Vector 20 [_BumpMap_ST]
                    "vs_2_0
                    def c21, 1.00000000, 0, 0, 0
                    dcl_position0 v0
                    dcl_tangent0 v1
                    dcl_normal0 v2
                    dcl_texcoord0 v3
                    mov r0.w, c21.x
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
                    dp3 oT1.y, r0, r2
                    dp3 oT1.z, v2, r0
                    dp3 oT1.x, r0, v1
                    dp4 r0.w, v0, c7
                    dp4 r0.z, v0, c6
                    dp4 r0.x, v0, c4
                    dp4 r0.y, v0, c5
                    dp3 oT2.y, r2, r3
                    dp3 oT2.z, v2, r3
                    dp3 oT2.x, v1, r3
                    dp4 oT3.z, r0, c14
                    dp4 oT3.y, r0, c13
                    dp4 oT3.x, r0, c12
                    mad oT0.zw, v3.xyxy, c20.xyxy, c20
                    mad oT0.xy, v3, c19, c19.zwzw
                    dp4 oPos.w, v0, c3
                    dp4 oPos.z, v0, c2
                    dp4 oPos.y, v0, c1
                    dp4 oPos.x, v0, c0
                    "
                }
                SubProgram "d3d11 " {
                    Keywords { "POINT" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" TexCoord2
                    ConstBuffer "$Globals" 176
                    Matrix 48 [_LightMatrix0]
                    Vector 144 [_MainTex_ST]
                    Vector 160 [_BumpMap_ST]
                    ConstBuffer "UnityPerCamera" 128
                    Vector 64 [_WorldSpaceCameraPos] 3
                    ConstBuffer "UnityLighting" 720
                    Vector 0 [_WorldSpaceLightPos0]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 192 [_Object2World]
                    Matrix 256 [_World2Object]
                    Vector 320 [unity_Scale]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerCamera" 1
                    BindCB  "UnityLighting" 2
                    BindCB  "UnityPerDraw" 3
                    "vs_4_0
                    eefiecedccfkfopdfpaobpeododkohcedchnnokcabaaaaaaceahaaaaadaaaaaa
                    cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
                    abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
                    enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
                    aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
                    adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
                    ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
                    epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefciiafaaaaeaaaabaa
                    gcabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaa
                    afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
                    bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
                    hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
                    abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
                    hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
                    pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
                    pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
                    aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
                    aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
                    adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
                    egbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaa
                    dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaa
                    kgiocaaaaaaaaaaaakaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaa
                    cgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaa
                    abaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
                    aaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaa
                    aaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
                    adaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
                    hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaa
                    egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
                    pgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
                    egacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
                    baaaaaahcccabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
                    bccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaa
                    acaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaa
                    fgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaa
                    abaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaa
                    abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaa
                    abaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaa
                    abaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaa
                    abaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaah
                    cccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
                    adaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaa
                    egbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
                    aaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
                    adaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
                    aaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
                    dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
                    egaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
                    aaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaa
                    agaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
                    aaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaa
                    aeaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
                    doaaaaab"
                }
                SubProgram "d3d11_9x " {
                    Keywords { "POINT" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" TexCoord2
                    ConstBuffer "$Globals" 176
                    Matrix 48 [_LightMatrix0]
                    Vector 144 [_MainTex_ST]
                    Vector 160 [_BumpMap_ST]
                    ConstBuffer "UnityPerCamera" 128
                    Vector 64 [_WorldSpaceCameraPos] 3
                    ConstBuffer "UnityLighting" 720
                    Vector 0 [_WorldSpaceLightPos0]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 192 [_Object2World]
                    Matrix 256 [_World2Object]
                    Vector 320 [unity_Scale]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerCamera" 1
                    BindCB  "UnityLighting" 2
                    BindCB  "UnityPerDraw" 3
                    "vs_4_0_level_9_1
                    eefiecedglfmblgekmphjihfmafddmepplhjlfkdabaaaaaahiakaaaaaeaaaaaa
                    daaaaaaaiaadaaaabaajaaaaniajaaaaebgpgodjeiadaaaaeiadaaaaaaacpopp
                    niacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
                    aeaaabaaaaaaaaaaaaaaajaaacaaafaaaaaaaaaaabaaaeaaabaaahaaaaaaaaaa
                    acaaaaaaabaaaiaaaaaaaaaaadaaaaaaaeaaajaaaaaaaaaaadaaamaaajaaanaa
                    aaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabia
                    abaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaae
                    aaaaadoaadaaoejaafaaoekaafaaookaaeaaaaaeaaaaamoaadaaeejaagaaeeka
                    agaaoekaabaaaaacaaaaapiaaiaaoekaafaaaaadabaaahiaaaaaffiabcaaoeka
                    aeaaaaaeabaaahiabbaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiabdaaoeka
                    aaaakkiaabaaoeiaaeaaaaaeaaaaahiabeaaoekaaaaappiaaaaaoeiaaeaaaaae
                    aaaaahiaaaaaoeiabfaappkaaaaaoejbaiaaaaadabaaaboaabaaoejaaaaaoeia
                    abaaaaacabaaahiaabaaoejaafaaaaadacaaahiaabaamjiaacaancjaaeaaaaae
                    abaaahiaacaamjjaabaanciaacaaoeibafaaaaadabaaahiaabaaoeiaabaappja
                    aiaaaaadabaaacoaabaaoeiaaaaaoeiaaiaaaaadabaaaeoaacaaoejaaaaaoeia
                    abaaaaacaaaaahiaahaaoekaafaaaaadacaaahiaaaaaffiabcaaoekaaeaaaaae
                    aaaaaliabbaakekaaaaaaaiaacaakeiaaeaaaaaeaaaaahiabdaaoekaaaaakkia
                    aaaapeiaacaaaaadaaaaahiaaaaaoeiabeaaoekaaeaaaaaeaaaaahiaaaaaoeia
                    bfaappkaaaaaoejbaiaaaaadacaaaboaabaaoejaaaaaoeiaaiaaaaadacaaacoa
                    abaaoeiaaaaaoeiaaiaaaaadacaaaeoaacaaoejaaaaaoeiaafaaaaadaaaaapia
                    aaaaffjaaoaaoekaaeaaaaaeaaaaapiaanaaoekaaaaaaajaaaaaoeiaaeaaaaae
                    aaaaapiaapaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiabaaaoekaaaaappja
                    aaaaoeiaafaaaaadabaaahiaaaaaffiaacaaoekaaeaaaaaeabaaahiaabaaoeka
                    aaaaaaiaabaaoeiaaeaaaaaeaaaaahiaadaaoekaaaaakkiaabaaoeiaaeaaaaae
                    adaaahoaaeaaoekaaaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffjaakaaoeka
                    aeaaaaaeaaaaapiaajaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaalaaoeka
                    aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaamaaoekaaaaappjaaaaaoeiaaeaaaaae
                    aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaa
                    fdeieefciiafaaaaeaaaabaagcabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
                    fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
                    fjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
                    pcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
                    ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
                    hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
                    giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
                    adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
                    agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
                    adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
                    aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
                    dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaa
                    ogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
                    agiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaadiaaaaahhcaabaaa
                    aaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaa
                    jgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaah
                    hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaa
                    abaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaal
                    hcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaa
                    egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaa
                    kgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
                    egiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaa
                    dcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaa
                    egbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaaaaaaaaaa
                    egacbaaaabaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaa
                    abaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
                    diaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
                    bbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
                    abaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
                    adaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaai
                    hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaal
                    hcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaia
                    ebaaaaaaaaaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaa
                    abaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
                    baaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaai
                    pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaak
                    pcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaa
                    aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaa
                    aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
                    apaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
                    fgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaa
                    egiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
                    hcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaa
                    abaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaa
                    aaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
                    jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
                    aaaaaaaaadaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
                    acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
                    laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaa
                    aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
                    aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaa
                    afaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
                    imaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaa
                    aaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaa
                    adaaaaaaahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaa
                    fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
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
                    Vector 12 [_MainTex_ST]
                    Vector 13 [_BumpMap_ST]
                    "!!ARBvp1.0
                    PARAM c[14] = { { 1 },
                    state.matrix.mvp,
                    program.local[5..13] };
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
                    DP3 result.texcoord[1].y, R3, R1;
                    DP3 result.texcoord[2].y, R1, R2;
                    DP3 result.texcoord[1].z, vertex.normal, R3;
                    DP3 result.texcoord[1].x, R3, vertex.attrib[14];
                    DP3 result.texcoord[2].z, vertex.normal, R2;
                    DP3 result.texcoord[2].x, vertex.attrib[14], R2;
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[13].xyxy, c[13];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[12], c[12].zwzw;
                    DP4 result.position.w, vertex.position, c[4];
                    DP4 result.position.z, vertex.position, c[3];
                    DP4 result.position.y, vertex.position, c[2];
                    DP4 result.position.x, vertex.position, c[1];
                    END
# 26 instructions, 4 R-regs
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
                    Vector 11 [_MainTex_ST]
                    Vector 12 [_BumpMap_ST]
                    "vs_2_0
                    def c13, 1.00000000, 0, 0, 0
                    dcl_position0 v0
                    dcl_tangent0 v1
                    dcl_normal0 v2
                    dcl_texcoord0 v3
                    mov r0.w, c13.x
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
                    dp3 oT1.y, r4, r2
                    dp3 oT2.y, r2, r3
                    dp3 oT1.z, v2, r4
                    dp3 oT1.x, r4, v1
                    dp3 oT2.z, v2, r3
                    dp3 oT2.x, v1, r3
                    mad oT0.zw, v3.xyxy, c12.xyxy, c12
                    mad oT0.xy, v3, c11, c11.zwzw
                    dp4 oPos.w, v0, c3
                    dp4 oPos.z, v0, c2
                    dp4 oPos.y, v0, c1
                    dp4 oPos.x, v0, c0
                    "
                }
                SubProgram "d3d11 " {
                    Keywords { "DIRECTIONAL" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" TexCoord2
                    ConstBuffer "$Globals" 112
                    Vector 80 [_MainTex_ST]
                    Vector 96 [_BumpMap_ST]
                    ConstBuffer "UnityPerCamera" 128
                    Vector 64 [_WorldSpaceCameraPos] 3
                    ConstBuffer "UnityLighting" 720
                    Vector 0 [_WorldSpaceLightPos0]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 256 [_World2Object]
                    Vector 320 [unity_Scale]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerCamera" 1
                    BindCB  "UnityLighting" 2
                    BindCB  "UnityPerDraw" 3
                    "vs_4_0
                    eefiecedilmfnpikeflakedanncpadbknlhigcmiabaaaaaakeafaaaaadaaaaaa
                    cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
                    abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
                    enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
                    aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaa
                    adaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
                    ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
                    caaeaaaaeaaaabaaaiabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaae
                    egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaae
                    egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
                    abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
                    pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
                    acaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
                    aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
                    aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
                    dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
                    egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
                    pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
                    adaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaadcaaaaal
                    mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaagaaaaaakgiocaaa
                    aaaaaaaaagaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaa
                    acaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaa
                    egacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
                    pgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaa
                    egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
                    baaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
                    abaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaa
                    abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaa
                    acaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaa
                    aaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaa
                    egacbaaaabaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaa
                    abaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaa
                    adaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaa
                    agiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
                    egiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
                    aaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
                    dcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaa
                    egbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaaaaaaaaa
                    egacbaaaabaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaa
                    abaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
                    doaaaaab"
                }
                SubProgram "d3d11_9x " {
                    Keywords { "DIRECTIONAL" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" TexCoord2
                    ConstBuffer "$Globals" 112
                    Vector 80 [_MainTex_ST]
                    Vector 96 [_BumpMap_ST]
                    ConstBuffer "UnityPerCamera" 128
                    Vector 64 [_WorldSpaceCameraPos] 3
                    ConstBuffer "UnityLighting" 720
                    Vector 0 [_WorldSpaceLightPos0]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 256 [_World2Object]
                    Vector 320 [unity_Scale]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerCamera" 1
                    BindCB  "UnityLighting" 2
                    BindCB  "UnityPerDraw" 3
                    "vs_4_0_level_9_1
                    eefiecedjpofmdlndpbdaoofdgcolcjdbclelkafabaaaaaaeaaiaaaaaeaaaaaa
                    daaaaaaamiacaaaapaagaaaaliahaaaaebgpgodjjaacaaaajaacaaaaaaacpopp
                    cmacaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaafaa
                    acaaabaaaaaaaaaaabaaaeaaabaaadaaaaaaaaaaacaaaaaaabaaaeaaaaaaaaaa
                    adaaaaaaaeaaafaaaaaaaaaaadaabaaaafaaajaaaaaaaaaaaaaaaaaaaaacpopp
                    bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
                    acaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoeka
                    abaaookaaeaaaaaeaaaaamoaadaaeejaacaaeekaacaaoekaabaaaaacaaaaapia
                    aeaaoekaafaaaaadabaaahiaaaaaffiaakaaoekaaeaaaaaeabaaahiaajaaoeka
                    aaaaaaiaabaaoeiaaeaaaaaeaaaaahiaalaaoekaaaaakkiaabaaoeiaaeaaaaae
                    aaaaahiaamaaoekaaaaappiaaaaaoeiaaiaaaaadabaaaboaabaaoejaaaaaoeia
                    abaaaaacabaaahiaabaaoejaafaaaaadacaaahiaabaamjiaacaancjaaeaaaaae
                    abaaahiaacaamjjaabaanciaacaaoeibafaaaaadabaaahiaabaaoeiaabaappja
                    aiaaaaadabaaacoaabaaoeiaaaaaoeiaaiaaaaadabaaaeoaacaaoejaaaaaoeia
                    abaaaaacaaaaahiaadaaoekaafaaaaadacaaahiaaaaaffiaakaaoekaaeaaaaae
                    aaaaaliaajaakekaaaaaaaiaacaakeiaaeaaaaaeaaaaahiaalaaoekaaaaakkia
                    aaaapeiaacaaaaadaaaaahiaaaaaoeiaamaaoekaaeaaaaaeaaaaahiaaaaaoeia
                    anaappkaaaaaoejbaiaaaaadacaaaboaabaaoejaaaaaoeiaaiaaaaadacaaacoa
                    abaaoeiaaaaaoeiaaiaaaaadacaaaeoaacaaoejaaaaaoeiaafaaaaadaaaaapia
                    aaaaffjaagaaoekaaeaaaaaeaaaaapiaafaaoekaaaaaaajaaaaaoeiaaeaaaaae
                    aaaaapiaahaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaaiaaoekaaaaappja
                    aaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
                    aaaaoeiappppaaaafdeieefccaaeaaaaeaaaabaaaiabaaaafjaaaaaeegiocaaa
                    aaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
                    acaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaa
                    aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
                    dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
                    abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaac
                    acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
                    abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
                    aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
                    acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
                    egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
                    dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaa
                    aaaaaaaaafaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
                    aaaaaaaaagaaaaaakgiocaaaaaaaaaaaagaaaaaadiaaaaahhcaabaaaaaaaaaaa
                    jgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaa
                    acaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaa
                    aaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaa
                    fgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaa
                    abaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaa
                    abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaa
                    acaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
                    adaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
                    cccabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
                    acaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaacaaaaaa
                    egbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaa
                    abaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaa
                    egiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
                    dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaa
                    aeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
                    egiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaa
                    pgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaa
                    adaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaadaaaaaa
                    egbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaa
                    acaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
                    jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
                    aaaaaaaaadaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
                    acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
                    laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaa
                    aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
                    aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaa
                    aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
                    heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaa
                    aaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaa
                    adaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
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
                    Vector 20 [_MainTex_ST]
                    Vector 21 [_BumpMap_ST]
                    "!!ARBvp1.0
                    PARAM c[22] = { { 1 },
                    state.matrix.mvp,
                    program.local[5..21] };
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
                    DP3 result.texcoord[1].y, R0, R1;
                    DP3 result.texcoord[1].z, vertex.normal, R0;
                    DP3 result.texcoord[1].x, R0, vertex.attrib[14];
                    DP4 R0.z, vertex.position, c[7];
                    DP4 R0.x, vertex.position, c[5];
                    DP4 R0.y, vertex.position, c[6];
                    DP3 result.texcoord[2].y, R1, R2;
                    DP3 result.texcoord[2].z, vertex.normal, R2;
                    DP3 result.texcoord[2].x, vertex.attrib[14], R2;
                    DP4 result.texcoord[3].w, R0, c[16];
                    DP4 result.texcoord[3].z, R0, c[15];
                    DP4 result.texcoord[3].y, R0, c[14];
                    DP4 result.texcoord[3].x, R0, c[13];
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
                    DP4 result.position.w, vertex.position, c[4];
                    DP4 result.position.z, vertex.position, c[3];
                    DP4 result.position.y, vertex.position, c[2];
                    DP4 result.position.x, vertex.position, c[1];
                    END
# 35 instructions, 4 R-regs
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
                    Vector 19 [_MainTex_ST]
                    Vector 20 [_BumpMap_ST]
                    "vs_2_0
                    def c21, 1.00000000, 0, 0, 0
                    dcl_position0 v0
                    dcl_tangent0 v1
                    dcl_normal0 v2
                    dcl_texcoord0 v3
                    mov r0.w, c21.x
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
                    dp3 oT1.y, r0, r2
                    dp3 oT1.z, v2, r0
                    dp3 oT1.x, r0, v1
                    dp4 r0.z, v0, c6
                    dp4 r0.x, v0, c4
                    dp4 r0.y, v0, c5
                    dp3 oT2.y, r2, r3
                    dp3 oT2.z, v2, r3
                    dp3 oT2.x, v1, r3
                    dp4 oT3.w, r0, c15
                    dp4 oT3.z, r0, c14
                    dp4 oT3.y, r0, c13
                    dp4 oT3.x, r0, c12
                    mad oT0.zw, v3.xyxy, c20.xyxy, c20
                    mad oT0.xy, v3, c19, c19.zwzw
                    dp4 oPos.w, v0, c3
                    dp4 oPos.z, v0, c2
                    dp4 oPos.y, v0, c1
                    dp4 oPos.x, v0, c0
                    "
                }
                SubProgram "d3d11 " {
                    Keywords { "SPOT" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" TexCoord2
                    ConstBuffer "$Globals" 176
                    Matrix 48 [_LightMatrix0]
                    Vector 144 [_MainTex_ST]
                    Vector 160 [_BumpMap_ST]
                    ConstBuffer "UnityPerCamera" 128
                    Vector 64 [_WorldSpaceCameraPos] 3
                    ConstBuffer "UnityLighting" 720
                    Vector 0 [_WorldSpaceLightPos0]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 192 [_Object2World]
                    Matrix 256 [_World2Object]
                    Vector 320 [unity_Scale]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerCamera" 1
                    BindCB  "UnityLighting" 2
                    BindCB  "UnityPerDraw" 3
                    "vs_4_0
                    eefiecedpcdamidoddoccgdgmmpngiplnmipkbeiabaaaaaaceahaaaaadaaaaaa
                    cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
                    abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
                    enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
                    aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
                    adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
                    ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfa
                    epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefciiafaaaaeaaaabaa
                    gcabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaa
                    afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
                    bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
                    hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
                    abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
                    hccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
                    pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
                    pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
                    aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
                    aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
                    adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
                    egbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaa
                    dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaa
                    kgiocaaaaaaaaaaaakaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaa
                    cgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaa
                    abaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
                    aaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaa
                    aaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
                    adaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
                    hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaa
                    egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
                    pgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
                    egacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
                    baaaaaahcccabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
                    bccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaa
                    acaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaa
                    fgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaa
                    abaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaa
                    abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaa
                    abaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaa
                    abaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaa
                    abaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaah
                    cccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
                    adaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaa
                    egbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
                    aaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
                    adaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
                    aaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
                    dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
                    egaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaa
                    aaaaaaaaaeaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaadaaaaaa
                    agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
                    aaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaa
                    aeaaaaaaegiocaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaa
                    doaaaaab"
                }
                SubProgram "d3d11_9x " {
                    Keywords { "SPOT" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" TexCoord2
                    ConstBuffer "$Globals" 176
                    Matrix 48 [_LightMatrix0]
                    Vector 144 [_MainTex_ST]
                    Vector 160 [_BumpMap_ST]
                    ConstBuffer "UnityPerCamera" 128
                    Vector 64 [_WorldSpaceCameraPos] 3
                    ConstBuffer "UnityLighting" 720
                    Vector 0 [_WorldSpaceLightPos0]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 192 [_Object2World]
                    Matrix 256 [_World2Object]
                    Vector 320 [unity_Scale]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerCamera" 1
                    BindCB  "UnityLighting" 2
                    BindCB  "UnityPerDraw" 3
                    "vs_4_0_level_9_1
                    eefiecedpmfjemkficildkgcfaicadpplelkgmedabaaaaaahiakaaaaaeaaaaaa
                    daaaaaaaiaadaaaabaajaaaaniajaaaaebgpgodjeiadaaaaeiadaaaaaaacpopp
                    niacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
                    aeaaabaaaaaaaaaaaaaaajaaacaaafaaaaaaaaaaabaaaeaaabaaahaaaaaaaaaa
                    acaaaaaaabaaaiaaaaaaaaaaadaaaaaaaeaaajaaaaaaaaaaadaaamaaajaaanaa
                    aaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabia
                    abaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaae
                    aaaaadoaadaaoejaafaaoekaafaaookaaeaaaaaeaaaaamoaadaaeejaagaaeeka
                    agaaoekaabaaaaacaaaaapiaaiaaoekaafaaaaadabaaahiaaaaaffiabcaaoeka
                    aeaaaaaeabaaahiabbaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiabdaaoeka
                    aaaakkiaabaaoeiaaeaaaaaeaaaaahiabeaaoekaaaaappiaaaaaoeiaaeaaaaae
                    aaaaahiaaaaaoeiabfaappkaaaaaoejbaiaaaaadabaaaboaabaaoejaaaaaoeia
                    abaaaaacabaaahiaabaaoejaafaaaaadacaaahiaabaamjiaacaancjaaeaaaaae
                    abaaahiaacaamjjaabaanciaacaaoeibafaaaaadabaaahiaabaaoeiaabaappja
                    aiaaaaadabaaacoaabaaoeiaaaaaoeiaaiaaaaadabaaaeoaacaaoejaaaaaoeia
                    abaaaaacaaaaahiaahaaoekaafaaaaadacaaahiaaaaaffiabcaaoekaaeaaaaae
                    aaaaaliabbaakekaaaaaaaiaacaakeiaaeaaaaaeaaaaahiabdaaoekaaaaakkia
                    aaaapeiaacaaaaadaaaaahiaaaaaoeiabeaaoekaaeaaaaaeaaaaahiaaaaaoeia
                    bfaappkaaaaaoejbaiaaaaadacaaaboaabaaoejaaaaaoeiaaiaaaaadacaaacoa
                    abaaoeiaaaaaoeiaaiaaaaadacaaaeoaacaaoejaaaaaoeiaafaaaaadaaaaapia
                    aaaaffjaaoaaoekaaeaaaaaeaaaaapiaanaaoekaaaaaaajaaaaaoeiaaeaaaaae
                    aaaaapiaapaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiabaaaoekaaaaappja
                    aaaaoeiaafaaaaadabaaapiaaaaaffiaacaaoekaaeaaaaaeabaaapiaabaaoeka
                    aaaaaaiaabaaoeiaaeaaaaaeabaaapiaadaaoekaaaaakkiaabaaoeiaaeaaaaae
                    adaaapoaaeaaoekaaaaappiaabaaoeiaafaaaaadaaaaapiaaaaaffjaakaaoeka
                    aeaaaaaeaaaaapiaajaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaalaaoeka
                    aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaamaaoekaaaaappjaaaaaoeiaaeaaaaae
                    aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaa
                    fdeieefciiafaaaaeaaaabaagcabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
                    fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
                    fjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
                    pcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
                    ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
                    hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
                    giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
                    adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
                    agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
                    adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
                    aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
                    dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaa
                    ogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
                    agiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaadiaaaaahhcaabaaa
                    aaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaa
                    jgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaah
                    hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaa
                    abaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaal
                    hcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaa
                    egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaa
                    kgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
                    egiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaa
                    dcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaa
                    egbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaaaaaaaaaa
                    egacbaaaabaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaa
                    abaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
                    diaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
                    bbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
                    abaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
                    adaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaai
                    hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaal
                    hcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaia
                    ebaaaaaaaaaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaa
                    abaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
                    baaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaai
                    pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaak
                    pcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaa
                    aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaa
                    aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
                    apaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaa
                    fgafbaaaaaaaaaaaegiocaaaaaaaaaaaaeaaaaaadcaaaaakpcaabaaaabaaaaaa
                    egiocaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
                    pcaabaaaabaaaaaaegiocaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaobaaa
                    abaaaaaadcaaaaakpccabaaaaeaaaaaaegiocaaaaaaaaaaaagaaaaaapgapbaaa
                    aaaaaaaaegaobaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
                    jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
                    aaaaaaaaadaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
                    acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
                    laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaa
                    aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
                    aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaa
                    afaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
                    imaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaa
                    aaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaa
                    adaaaaaaahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
                    fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
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
                    Vector 20 [_MainTex_ST]
                    Vector 21 [_BumpMap_ST]
                    "!!ARBvp1.0
                    PARAM c[22] = { { 1 },
                    state.matrix.mvp,
                    program.local[5..21] };
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
                    DP3 result.texcoord[1].y, R0, R1;
                    DP3 result.texcoord[1].z, vertex.normal, R0;
                    DP3 result.texcoord[1].x, R0, vertex.attrib[14];
                    DP4 R0.w, vertex.position, c[8];
                    DP4 R0.z, vertex.position, c[7];
                    DP4 R0.x, vertex.position, c[5];
                    DP4 R0.y, vertex.position, c[6];
                    DP3 result.texcoord[2].y, R1, R2;
                    DP3 result.texcoord[2].z, vertex.normal, R2;
                    DP3 result.texcoord[2].x, vertex.attrib[14], R2;
                    DP4 result.texcoord[3].z, R0, c[15];
                    DP4 result.texcoord[3].y, R0, c[14];
                    DP4 result.texcoord[3].x, R0, c[13];
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
                    DP4 result.position.w, vertex.position, c[4];
                    DP4 result.position.z, vertex.position, c[3];
                    DP4 result.position.y, vertex.position, c[2];
                    DP4 result.position.x, vertex.position, c[1];
                    END
# 34 instructions, 4 R-regs
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
                    Vector 19 [_MainTex_ST]
                    Vector 20 [_BumpMap_ST]
                    "vs_2_0
                    def c21, 1.00000000, 0, 0, 0
                    dcl_position0 v0
                    dcl_tangent0 v1
                    dcl_normal0 v2
                    dcl_texcoord0 v3
                    mov r0.w, c21.x
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
                    dp3 oT1.y, r0, r2
                    dp3 oT1.z, v2, r0
                    dp3 oT1.x, r0, v1
                    dp4 r0.w, v0, c7
                    dp4 r0.z, v0, c6
                    dp4 r0.x, v0, c4
                    dp4 r0.y, v0, c5
                    dp3 oT2.y, r2, r3
                    dp3 oT2.z, v2, r3
                    dp3 oT2.x, v1, r3
                    dp4 oT3.z, r0, c14
                    dp4 oT3.y, r0, c13
                    dp4 oT3.x, r0, c12
                    mad oT0.zw, v3.xyxy, c20.xyxy, c20
                    mad oT0.xy, v3, c19, c19.zwzw
                    dp4 oPos.w, v0, c3
                    dp4 oPos.z, v0, c2
                    dp4 oPos.y, v0, c1
                    dp4 oPos.x, v0, c0
                    "
                }
                SubProgram "d3d11 " {
                    Keywords { "POINT_COOKIE" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" TexCoord2
                    ConstBuffer "$Globals" 176
                    Matrix 48 [_LightMatrix0]
                    Vector 144 [_MainTex_ST]
                    Vector 160 [_BumpMap_ST]
                    ConstBuffer "UnityPerCamera" 128
                    Vector 64 [_WorldSpaceCameraPos] 3
                    ConstBuffer "UnityLighting" 720
                    Vector 0 [_WorldSpaceLightPos0]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 192 [_Object2World]
                    Matrix 256 [_World2Object]
                    Vector 320 [unity_Scale]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerCamera" 1
                    BindCB  "UnityLighting" 2
                    BindCB  "UnityPerDraw" 3
                    "vs_4_0
                    eefiecedccfkfopdfpaobpeododkohcedchnnokcabaaaaaaceahaaaaadaaaaaa
                    cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
                    abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
                    enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
                    aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
                    adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
                    ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
                    epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefciiafaaaaeaaaabaa
                    gcabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaa
                    afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
                    bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
                    hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
                    abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
                    hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
                    pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
                    pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
                    aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
                    aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
                    adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
                    egbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaa
                    dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaa
                    kgiocaaaaaaaaaaaakaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaa
                    cgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaa
                    abaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
                    aaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaa
                    aaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
                    adaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
                    hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaa
                    egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
                    pgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
                    egacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
                    baaaaaahcccabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
                    bccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaa
                    acaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaa
                    fgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaa
                    abaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaa
                    abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaa
                    abaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaa
                    abaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaa
                    abaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaah
                    cccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
                    adaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaa
                    egbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
                    aaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
                    adaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
                    aaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
                    dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
                    egaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
                    aaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaa
                    agaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
                    aaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaa
                    aeaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
                    doaaaaab"
                }
                SubProgram "d3d11_9x " {
                    Keywords { "POINT_COOKIE" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" TexCoord2
                    ConstBuffer "$Globals" 176
                    Matrix 48 [_LightMatrix0]
                    Vector 144 [_MainTex_ST]
                    Vector 160 [_BumpMap_ST]
                    ConstBuffer "UnityPerCamera" 128
                    Vector 64 [_WorldSpaceCameraPos] 3
                    ConstBuffer "UnityLighting" 720
                    Vector 0 [_WorldSpaceLightPos0]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 192 [_Object2World]
                    Matrix 256 [_World2Object]
                    Vector 320 [unity_Scale]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerCamera" 1
                    BindCB  "UnityLighting" 2
                    BindCB  "UnityPerDraw" 3
                    "vs_4_0_level_9_1
                    eefiecedglfmblgekmphjihfmafddmepplhjlfkdabaaaaaahiakaaaaaeaaaaaa
                    daaaaaaaiaadaaaabaajaaaaniajaaaaebgpgodjeiadaaaaeiadaaaaaaacpopp
                    niacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
                    aeaaabaaaaaaaaaaaaaaajaaacaaafaaaaaaaaaaabaaaeaaabaaahaaaaaaaaaa
                    acaaaaaaabaaaiaaaaaaaaaaadaaaaaaaeaaajaaaaaaaaaaadaaamaaajaaanaa
                    aaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabia
                    abaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaae
                    aaaaadoaadaaoejaafaaoekaafaaookaaeaaaaaeaaaaamoaadaaeejaagaaeeka
                    agaaoekaabaaaaacaaaaapiaaiaaoekaafaaaaadabaaahiaaaaaffiabcaaoeka
                    aeaaaaaeabaaahiabbaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiabdaaoeka
                    aaaakkiaabaaoeiaaeaaaaaeaaaaahiabeaaoekaaaaappiaaaaaoeiaaeaaaaae
                    aaaaahiaaaaaoeiabfaappkaaaaaoejbaiaaaaadabaaaboaabaaoejaaaaaoeia
                    abaaaaacabaaahiaabaaoejaafaaaaadacaaahiaabaamjiaacaancjaaeaaaaae
                    abaaahiaacaamjjaabaanciaacaaoeibafaaaaadabaaahiaabaaoeiaabaappja
                    aiaaaaadabaaacoaabaaoeiaaaaaoeiaaiaaaaadabaaaeoaacaaoejaaaaaoeia
                    abaaaaacaaaaahiaahaaoekaafaaaaadacaaahiaaaaaffiabcaaoekaaeaaaaae
                    aaaaaliabbaakekaaaaaaaiaacaakeiaaeaaaaaeaaaaahiabdaaoekaaaaakkia
                    aaaapeiaacaaaaadaaaaahiaaaaaoeiabeaaoekaaeaaaaaeaaaaahiaaaaaoeia
                    bfaappkaaaaaoejbaiaaaaadacaaaboaabaaoejaaaaaoeiaaiaaaaadacaaacoa
                    abaaoeiaaaaaoeiaaiaaaaadacaaaeoaacaaoejaaaaaoeiaafaaaaadaaaaapia
                    aaaaffjaaoaaoekaaeaaaaaeaaaaapiaanaaoekaaaaaaajaaaaaoeiaaeaaaaae
                    aaaaapiaapaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiabaaaoekaaaaappja
                    aaaaoeiaafaaaaadabaaahiaaaaaffiaacaaoekaaeaaaaaeabaaahiaabaaoeka
                    aaaaaaiaabaaoeiaaeaaaaaeaaaaahiaadaaoekaaaaakkiaabaaoeiaaeaaaaae
                    adaaahoaaeaaoekaaaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffjaakaaoeka
                    aeaaaaaeaaaaapiaajaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaalaaoeka
                    aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaamaaoekaaaaappjaaaaaoeiaaeaaaaae
                    aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaa
                    fdeieefciiafaaaaeaaaabaagcabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
                    fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
                    fjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
                    pcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
                    ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
                    hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
                    giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
                    adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
                    agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
                    adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
                    aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
                    dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaa
                    ogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
                    agiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaadiaaaaahhcaabaaa
                    aaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaa
                    jgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaah
                    hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaa
                    abaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaal
                    hcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaa
                    egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaa
                    kgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
                    egiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaa
                    dcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaa
                    egbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaaaaaaaaaa
                    egacbaaaabaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaa
                    abaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
                    diaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
                    bbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
                    abaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
                    adaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaai
                    hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaal
                    hcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaia
                    ebaaaaaaaaaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaa
                    abaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
                    baaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaai
                    pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaak
                    pcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaa
                    aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaa
                    aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
                    apaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
                    fgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaa
                    egiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
                    hcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaa
                    abaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaa
                    aaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
                    jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
                    aaaaaaaaadaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
                    acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
                    laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaa
                    aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
                    aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaa
                    afaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
                    imaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaa
                    aaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaa
                    adaaaaaaahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaa
                    fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
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
                    Vector 20 [_MainTex_ST]
                    Vector 21 [_BumpMap_ST]
                    "!!ARBvp1.0
                    PARAM c[22] = { { 1 },
                    state.matrix.mvp,
                    program.local[5..21] };
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
                    DP3 result.texcoord[1].y, R3, R1;
                    DP3 result.texcoord[2].y, R1, R2;
                    DP3 result.texcoord[1].z, vertex.normal, R3;
                    DP3 result.texcoord[1].x, R3, vertex.attrib[14];
                    DP3 result.texcoord[2].z, vertex.normal, R2;
                    DP3 result.texcoord[2].x, vertex.attrib[14], R2;
                    DP4 result.texcoord[3].y, R0, c[14];
                    DP4 result.texcoord[3].x, R0, c[13];
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
                    DP4 result.position.w, vertex.position, c[4];
                    DP4 result.position.z, vertex.position, c[3];
                    DP4 result.position.y, vertex.position, c[2];
                    DP4 result.position.x, vertex.position, c[1];
                    END
# 32 instructions, 4 R-regs
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
                    Vector 19 [_MainTex_ST]
                    Vector 20 [_BumpMap_ST]
                    "vs_2_0
                    def c21, 1.00000000, 0, 0, 0
                    dcl_position0 v0
                    dcl_tangent0 v1
                    dcl_normal0 v2
                    dcl_texcoord0 v3
                    mov r0.w, c21.x
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
                    dp3 oT1.y, r4, r2
                    dp3 oT2.y, r2, r3
                    dp3 oT1.z, v2, r4
                    dp3 oT1.x, r4, v1
                    dp3 oT2.z, v2, r3
                    dp3 oT2.x, v1, r3
                    dp4 oT3.y, r0, c13
                    dp4 oT3.x, r0, c12
                    mad oT0.zw, v3.xyxy, c20.xyxy, c20
                    mad oT0.xy, v3, c19, c19.zwzw
                    dp4 oPos.w, v0, c3
                    dp4 oPos.z, v0, c2
                    dp4 oPos.y, v0, c1
                    dp4 oPos.x, v0, c0
                    "
                }
                SubProgram "d3d11 " {
                    Keywords { "DIRECTIONAL_COOKIE" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" TexCoord2
                    ConstBuffer "$Globals" 176
                    Matrix 48 [_LightMatrix0]
                    Vector 144 [_MainTex_ST]
                    Vector 160 [_BumpMap_ST]
                    ConstBuffer "UnityPerCamera" 128
                    Vector 64 [_WorldSpaceCameraPos] 3
                    ConstBuffer "UnityLighting" 720
                    Vector 0 [_WorldSpaceLightPos0]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 192 [_Object2World]
                    Matrix 256 [_World2Object]
                    Vector 320 [unity_Scale]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerCamera" 1
                    BindCB  "UnityLighting" 2
                    BindCB  "UnityPerDraw" 3
                    "vs_4_0
                    eefiecedekokaocinpphacablapoaibkilcpahegabaaaaaapiagaaaaadaaaaaa
                    cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
                    abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
                    enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
                    aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
                    adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
                    ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaafdfgfpfa
                    epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcfmafaaaaeaaaabaa
                    fhabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaa
                    afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
                    bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
                    hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
                    abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
                    hccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
                    pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
                    pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
                    aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
                    aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
                    adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
                    egbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaa
                    dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaa
                    kgiocaaaaaaaaaaaakaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaa
                    cgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaa
                    abaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
                    aaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaa
                    aaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
                    adaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
                    hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaa
                    egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
                    pgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaaacaaaaaa
                    egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaa
                    abaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaa
                    egacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaa
                    egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
                    baaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
                    abaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaa
                    abaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaa
                    bdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaa
                    beaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaa
                    aaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaa
                    egacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaa
                    abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
                    anaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaa
                    aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
                    aoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
                    egiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
                    dcaabaaaabaaaaaafgafbaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaak
                    dcaabaaaaaaaaaaaegiacaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegaabaaa
                    abaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaaafaaaaaakgakbaaa
                    aaaaaaaaegaabaaaaaaaaaaadcaaaaakdccabaaaaeaaaaaaegiacaaaaaaaaaaa
                    agaaaaaapgapbaaaaaaaaaaaegaabaaaaaaaaaaadoaaaaab"
                }
                SubProgram "d3d11_9x " {
                    Keywords { "DIRECTIONAL_COOKIE" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" TexCoord2
                    ConstBuffer "$Globals" 176
                    Matrix 48 [_LightMatrix0]
                    Vector 144 [_MainTex_ST]
                    Vector 160 [_BumpMap_ST]
                    ConstBuffer "UnityPerCamera" 128
                    Vector 64 [_WorldSpaceCameraPos] 3
                    ConstBuffer "UnityLighting" 720
                    Vector 0 [_WorldSpaceLightPos0]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 192 [_Object2World]
                    Matrix 256 [_World2Object]
                    Vector 320 [unity_Scale]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerCamera" 1
                    BindCB  "UnityLighting" 2
                    BindCB  "UnityPerDraw" 3
                    "vs_4_0_level_9_1
                    eefiecedgkkoopmggkilchbfdomlfbickfoppfndabaaaaaadiakaaaaaeaaaaaa
                    daaaaaaagmadaaaanaaiaaaajiajaaaaebgpgodjdeadaaaadeadaaaaaaacpopp
                    meacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
                    aeaaabaaaaaaaaaaaaaaajaaacaaafaaaaaaaaaaabaaaeaaabaaahaaaaaaaaaa
                    acaaaaaaabaaaiaaaaaaaaaaadaaaaaaaeaaajaaaaaaaaaaadaaamaaajaaanaa
                    aaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabia
                    abaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaae
                    aaaaadoaadaaoejaafaaoekaafaaookaaeaaaaaeaaaaamoaadaaeejaagaaeeka
                    agaaoekaabaaaaacaaaaapiaaiaaoekaafaaaaadabaaahiaaaaaffiabcaaoeka
                    aeaaaaaeabaaahiabbaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiabdaaoeka
                    aaaakkiaabaaoeiaaeaaaaaeaaaaahiabeaaoekaaaaappiaaaaaoeiaaiaaaaad
                    abaaaboaabaaoejaaaaaoeiaabaaaaacabaaahiaabaaoejaafaaaaadacaaahia
                    abaamjiaacaancjaaeaaaaaeabaaahiaacaamjjaabaanciaacaaoeibafaaaaad
                    abaaahiaabaaoeiaabaappjaaiaaaaadabaaacoaabaaoeiaaaaaoeiaaiaaaaad
                    abaaaeoaacaaoejaaaaaoeiaabaaaaacaaaaahiaahaaoekaafaaaaadacaaahia
                    aaaaffiabcaaoekaaeaaaaaeaaaaaliabbaakekaaaaaaaiaacaakeiaaeaaaaae
                    aaaaahiabdaaoekaaaaakkiaaaaapeiaacaaaaadaaaaahiaaaaaoeiabeaaoeka
                    aeaaaaaeaaaaahiaaaaaoeiabfaappkaaaaaoejbaiaaaaadacaaaboaabaaoeja
                    aaaaoeiaaiaaaaadacaaacoaabaaoeiaaaaaoeiaaiaaaaadacaaaeoaacaaoeja
                    aaaaoeiaafaaaaadaaaaapiaaaaaffjaaoaaoekaaeaaaaaeaaaaapiaanaaoeka
                    aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaapaaoekaaaaakkjaaaaaoeiaaeaaaaae
                    aaaaapiabaaaoekaaaaappjaaaaaoeiaafaaaaadabaaadiaaaaaffiaacaaoeka
                    aeaaaaaeaaaaadiaabaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaadiaadaaoeka
                    aaaakkiaaaaaoeiaaeaaaaaeadaaadoaaeaaoekaaaaappiaaaaaoeiaafaaaaad
                    aaaaapiaaaaaffjaakaaoekaaeaaaaaeaaaaapiaajaaoekaaaaaaajaaaaaoeia
                    aeaaaaaeaaaaapiaalaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaamaaoeka
                    aaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
                    aaaaammaaaaaoeiappppaaaafdeieefcfmafaaaaeaaaabaafhabaaaafjaaaaae
                    egiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
                    egiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
                    pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
                    fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
                    pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
                    gfaaaaaddccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
                    fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
                    egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
                    pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
                    aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
                    aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
                    egiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaa
                    abaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaa
                    akaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaa
                    dcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaia
                    ebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaa
                    abaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaa
                    adaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaa
                    agiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
                    egiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaa
                    dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaa
                    aaaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaaaaaaaaaa
                    egacbaaaabaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaa
                    abaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
                    diaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
                    bbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
                    abaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
                    adaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaai
                    hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaal
                    hcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaia
                    ebaaaaaaaaaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaa
                    abaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
                    baaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaai
                    pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaak
                    pcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaa
                    aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaa
                    aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
                    apaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaidcaabaaaabaaaaaa
                    fgafbaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaakdcaabaaaaaaaaaaa
                    egiacaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaak
                    dcaabaaaaaaaaaaaegiacaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaabaaa
                    aaaaaaaadcaaaaakdccabaaaaeaaaaaaegiacaaaaaaaaaaaagaaaaaapgapbaaa
                    aaaaaaaaegaabaaaaaaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
                    jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
                    aaaaaaaaadaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
                    acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
                    laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaa
                    aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
                    aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaa
                    afaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
                    imaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaa
                    aaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaa
                    adaaaaaaahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaa
                    fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
                }
            }
            Program "fp" {
                SubProgram "opengl " {
                    Keywords { "POINT" }
                    Vector 0 [_LightColor0]
                    Vector 1 [_SpecColor]
                    Vector 2 [_Color]
                    Float 3 [_Shininess]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_LightTexture0] 2D 2
                    "!!ARBfp1.0
                    PARAM c[6] = { program.local[0..4],
                    { 0, 2, 1, 128 } };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    TEX R0, fragment.texcoord[0], texture[0], 2D;
                    TEX R1.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
                    DP3 R1.x, fragment.texcoord[3], fragment.texcoord[3];
                    DP3 R3.x, fragment.texcoord[2], fragment.texcoord[2];
                    MUL R0.xyz, R0, c[2];
                    RSQ R3.x, R3.x;
                    MOV result.color.w, c[5].x;
                    TEX R2.w, R1.x, texture[2], 2D;
                    DP3 R1.x, fragment.texcoord[1], fragment.texcoord[1];
                    RSQ R1.x, R1.x;
                    MUL R2.xyz, R1.x, fragment.texcoord[1];
                    MAD R1.xy, R1.wyzw, c[5].y, -c[5].z;
                    MUL R1.zw, R1.xyxy, R1.xyxy;
                    ADD_SAT R1.z, R1, R1.w;
                    MAD R3.xyz, R3.x, fragment.texcoord[2], R2;
                    DP3 R1.w, R3, R3;
                    RSQ R1.w, R1.w;
                    MUL R3.xyz, R1.w, R3;
                    ADD R1.z, -R1, c[5];
                    RSQ R1.z, R1.z;
                    RCP R1.z, R1.z;
                    DP3 R3.x, R1, R3;
                    MOV R1.w, c[5];
                    MUL R3.y, R1.w, c[3].x;
                    MAX R1.w, R3.x, c[5].x;
                    POW R1.w, R1.w, R3.y;
                    MUL R0.w, R1, R0;
                    DP3 R1.x, R1, R2;
                    MAX R1.w, R1.x, c[5].x;
                    MUL R1.xyz, R0, c[0];
                    MUL R1.xyz, R1, R1.w;
                    MOV R0.xyz, c[1];
                    MUL R0.xyz, R0, c[0];
                    MUL R1.w, R2, c[5].y;
                    MAD R0.xyz, R0, R0.w, R1;
                    MUL result.color.xyz, R0, R1.w;
                    END
# 36 instructions, 4 R-regs
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
                    "ps_2_0
                    dcl_2d s0
                    dcl_2d s1
                    dcl_2d s2
                    def c4, 2.00000000, -1.00000000, 1.00000000, 0.00000000
                    def c5, 128.00000000, 0, 0, 0
                    dcl t0
                    dcl t1.xyz
                    dcl t2.xyz
                    dcl t3.xyz
                    texld r2, t0, s0
                    dp3 r0.x, t3, t3
                    mov r1.xy, r0.x
                    mul_pp r2.xyz, r2, c2
                    mul_pp r2.xyz, r2, c0
                    mov r0.y, t0.w
                    mov r0.x, t0.z
                    texld r6, r1, s2
                    texld r0, r0, s1
                    mov r0.x, r0.w
                    mad_pp r4.xy, r0, c4.x, c4.y
                    mul_pp r0.xy, r4, r4
                    add_pp_sat r0.x, r0, r0.y
                    dp3_pp r1.x, t1, t1
                    rsq_pp r3.x, r1.x
                    dp3_pp r1.x, t2, t2
                    add_pp r0.x, -r0, c4.z
                    rsq_pp r0.x, r0.x
                    rcp_pp r4.z, r0.x
                    mov_pp r0.x, c3
                    mul_pp r3.xyz, r3.x, t1
                    rsq_pp r1.x, r1.x
                    mad_pp r5.xyz, r1.x, t2, r3
                    dp3_pp r1.x, r5, r5
                    rsq_pp r1.x, r1.x
                    mul_pp r1.xyz, r1.x, r5
                    dp3_pp r1.x, r4, r1
                    mul_pp r0.x, c5, r0
                    max_pp r1.x, r1, c4.w
                    pow r5.x, r1.x, r0.x
                    dp3_pp r1.x, r4, r3
                    max_pp r1.x, r1, c4.w
                    mul_pp r3.xyz, r2, r1.x
                    mov r0.x, r5.x
                    mov_pp r2.xyz, c0
                    mul r0.x, r0, r2.w
                    mul_pp r2.xyz, c1, r2
                    mul_pp r1.x, r6, c4
                    mad r0.xyz, r2, r0.x, r3
                    mul r0.xyz, r0, r1.x
                    mov_pp r0.w, c4
                    mov_pp oC0, r0
                    "
                }
                SubProgram "d3d11 " {
                    Keywords { "POINT" }
                    SetTexture 0 [_MainTex] 2D 1
                    SetTexture 1 [_BumpMap] 2D 2
                    SetTexture 2 [_LightTexture0] 2D 0
                    ConstBuffer "$Globals" 176
                    Vector 16 [_LightColor0]
                    Vector 32 [_SpecColor]
                    Vector 112 [_Color]
                    Float 128 [_Shininess]
                    BindCB  "$Globals" 0
                    "ps_4_0
                    eefiecedeacmdcfdhmhkgcmhcbnnljcpahiejinnabaaaaaakiafaaaaadaaaaaa
                    cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
                    aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
                    adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
                    feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
                    fdeieefckaaeaaaaeaaaaaaaciabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
                    fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
                    acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
                    ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
                    gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
                    aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaahbcaabaaa
                    aaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaa
                    akaabaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaa
                    acaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahocaabaaa
                    aaaaaaaafgafbaaaaaaaaaaaagbjbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaa
                    egbcbaaaadaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaabaaaaaahbcaabaaa
                    aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafbcaabaaaaaaaaaaa
                    akaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaa
                    abaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaa
                    aagabaaaacaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaaacaaaaaaaceaaaaa
                    aaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaa
                    aaaaaaaaapaaaaahbcaabaaaaaaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaa
                    ddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaai
                    bcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaaf
                    ecaabaaaacaaaaaaakaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaa
                    acaaaaaaegacbaaaabaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaacaaaaaa
                    jgahbaaaaaaaaaaadeaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
                    aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaa
                    aaaaaaaadiaaaaaiecaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaa
                    aaaaaaeddiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaa
                    bjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
                    egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaahbcaabaaa
                    aaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
                    egacbaaaabaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaaihcaabaaaabaaaaaa
                    egacbaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaajhcaabaaaacaaaaaa
                    egiccaaaaaaaaaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahncaabaaa
                    aaaaaaaaagaabaaaaaaaaaaaagajbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaa
                    egacbaaaabaaaaaafgafbaaaaaaaaaaaigadbaaaaaaaaaaabaaaaaahicaabaaa
                    aaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaa
                    pgapbaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaa
                    aaaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaa
                    pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
                    aaaaaaaadoaaaaab"
                }
                SubProgram "d3d11_9x " {
                    Keywords { "POINT" }
                    SetTexture 0 [_MainTex] 2D 1
                    SetTexture 1 [_BumpMap] 2D 2
                    SetTexture 2 [_LightTexture0] 2D 0
                    ConstBuffer "$Globals" 176
                    Vector 16 [_LightColor0]
                    Vector 32 [_SpecColor]
                    Vector 112 [_Color]
                    Float 128 [_Shininess]
                    BindCB  "$Globals" 0
                    "ps_4_0_level_9_1
                    eefiecediaanhjdpncekepahkaidddlmbohgnkgcabaaaaaakmaiaaaaaeaaaaaa
                    daaaaaaadaadaaaaniahaaaahiaiaaaaebgpgodjpiacaaaapiacaaaaaaacpppp
                    laacaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaacaaaaaa
                    aaababaaabacacaaaaaaabaaacaaaaaaaaaaaaaaaaaaahaaacaaacaaaaaaaaaa
                    aaacppppfbaaaaafaeaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaaf
                    afaaapkaaaaaaaedaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaapla
                    bpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaaia
                    adaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaac
                    aaaaaajaacaiapkaaiaaaaadaaaaciiaacaaoelaacaaoelaahaaaaacaaaacbia
                    aaaappiaceaaaaacabaachiaabaaoelaaeaaaaaeaaaachiaacaaoelaaaaaaaia
                    abaaoeiaceaaaaacacaachiaaaaaoeiaabaaaaacaaaaabiaaaaakklaabaaaaac
                    aaaaaciaaaaapplaaiaaaaadabaaaiiaadaaoelaadaaoelaabaaaaacadaaadia
                    abaappiaecaaaaadaaaacpiaaaaaoeiaacaioekaecaaaaadaeaacpiaaaaaoela
                    abaioekaecaaaaadadaacpiaadaaoeiaaaaioekaaeaaaaaeafaacbiaaaaappia
                    aeaaaakaaeaaffkaaeaaaaaeafaacciaaaaaffiaaeaaaakaaeaaffkafkaaaaae
                    abaadiiaafaaoeiaafaaoeiaaeaakkkaacaaaaadabaaciiaabaappibaeaappka
                    ahaaaaacabaaciiaabaappiaagaaaaacafaaceiaabaappiaaiaaaaadabaaciia
                    afaaoeiaacaaoeiaaiaaaaadaaaacbiaafaaoeiaabaaoeiaalaaaaadabaacbia
                    aaaaaaiaaeaakkkaalaaaaadaaaaabiaabaappiaaeaakkkaabaaaaacacaaabia
                    adaaaakaafaaaaadaaaaaciaacaaaaiaafaaaakacaaaaaadabaaaciaaaaaaaia
                    aaaaffiaafaaaaadaeaaaiiaaeaappiaabaaffiaafaaaaadaaaachiaaeaaoeia
                    acaaoekaafaaaaadaaaachiaaaaaoeiaaaaaoekaabaaaaacacaaahiaaaaaoeka
                    afaaaaadabaaaoiaacaabliaabaablkaafaaaaadabaaaoiaaeaappiaabaaoeia
                    aeaaaaaeaaaaahiaaaaaoeiaabaaaaiaabaabliaacaaaaadaaaaaiiaadaaaaia
                    adaaaaiaafaaaaadaaaachiaaaaappiaaaaaoeiaabaaaaacaaaaaiiaaeaakkka
                    abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefckaaeaaaaeaaaaaaaciabaaaa
                    fjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
                    aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
                    ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
                    ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
                    hcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaa
                    giaaaaacadaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaa
                    adaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaabaaaaaahccaabaaa
                    aaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaafccaabaaaaaaaaaaa
                    bkaabaaaaaaaaaaadiaaaaahocaabaaaaaaaaaaafgafbaaaaaaaaaaaagbjbaaa
                    acaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaaadaaaaaaagaabaaaaaaaaaaa
                    jgahbaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
                    abaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaa
                    abaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
                    ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaa
                    acaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
                    aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahbcaabaaaaaaaaaaa
                    egaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaa
                    aaaaaaaaabeaaaaaaaaaiadpaaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaa
                    aaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaaakaabaaaaaaaaaaa
                    baaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaah
                    ccaabaaaaaaaaaaaegacbaaaacaaaaaajgahbaaaaaaaaaaadeaaaaakdcaabaaa
                    aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
                    cpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiecaabaaaaaaaaaaa
                    akiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaaaaaaaaa
                    akaabaaaaaaaaaaackaabaaaaaaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaa
                    aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
                    aagabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaa
                    abaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
                    ahaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
                    abaaaaaadiaaaaajhcaabaaaacaaaaaaegiccaaaaaaaaaaaabaaaaaaegiccaaa
                    aaaaaaaaacaaaaaadiaaaaahncaabaaaaaaaaaaaagaabaaaaaaaaaaaagajbaaa
                    acaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaafgafbaaaaaaaaaaa
                    igadbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaa
                    aeaaaaaaefaaaaajpcaabaaaabaaaaaapgapbaaaaaaaaaaaeghobaaaacaaaaaa
                    aagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaa
                    abaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
                    dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaabejfdeheojiaaaaaa
                    afaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
                    imaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaa
                    aaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaa
                    adaaaaaaahahaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaa
                    fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
                    abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
                    fdfgfpfegbhcghgfheaaklkl"
                }
                SubProgram "opengl " {
                    Keywords { "DIRECTIONAL" }
                    Vector 0 [_LightColor0]
                    Vector 1 [_SpecColor]
                    Vector 2 [_Color]
                    Float 3 [_Shininess]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    "!!ARBfp1.0
                    PARAM c[6] = { program.local[0..4],
                    { 0, 2, 1, 128 } };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEX R0, fragment.texcoord[0], texture[0], 2D;
                    TEX R1.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
                    MAD R1.xy, R1.wyzw, c[5].y, -c[5].z;
                    MUL R1.zw, R1.xyxy, R1.xyxy;
                    ADD_SAT R1.z, R1, R1.w;
                    DP3 R2.w, fragment.texcoord[2], fragment.texcoord[2];
                    ADD R1.z, -R1, c[5];
                    RSQ R1.z, R1.z;
                    RCP R1.z, R1.z;
                    MUL R0.xyz, R0, c[2];
                    MOV R2.xyz, fragment.texcoord[1];
                    RSQ R2.w, R2.w;
                    MAD R2.xyz, R2.w, fragment.texcoord[2], R2;
                    DP3 R1.w, R2, R2;
                    RSQ R1.w, R1.w;
                    MUL R2.xyz, R1.w, R2;
                    DP3 R2.x, R1, R2;
                    MOV R1.w, c[5];
                    MUL R2.y, R1.w, c[3].x;
                    MAX R1.w, R2.x, c[5].x;
                    POW R1.w, R1.w, R2.y;
                    MUL R0.w, R1, R0;
                    DP3 R1.w, R1, fragment.texcoord[1];
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
                    "ps_2_0
                    dcl_2d s0
                    dcl_2d s1
                    def c4, 2.00000000, -1.00000000, 1.00000000, 0.00000000
                    def c5, 128.00000000, 0, 0, 0
                    dcl t0
                    dcl t1.xyz
                    dcl t2.xyz
                    texld r2, t0, s0
                    dp3_pp r1.x, t2, t2
                    rsq_pp r1.x, r1.x
                    mov_pp r3.xyz, t1
                    mad_pp r3.xyz, r1.x, t2, r3
                    mul_pp r2.xyz, r2, c2
                    mov r0.y, t0.w
                    mov r0.x, t0.z
                    texld r0, r0, s1
                    mov r0.x, r0.w
                    mad_pp r4.xy, r0, c4.x, c4.y
                    mul_pp r0.xy, r4, r4
                    add_pp_sat r0.x, r0, r0.y
                    add_pp r1.x, -r0, c4.z
                    dp3_pp r0.x, r3, r3
                    rsq_pp r1.x, r1.x
                    rcp_pp r4.z, r1.x
                    rsq_pp r0.x, r0.x
                    mul_pp r1.xyz, r0.x, r3
                    dp3_pp r1.x, r4, r1
                    mov_pp r0.x, c3
                    mul_pp r0.x, c5, r0
                    max_pp r1.x, r1, c4.w
                    pow r3.w, r1.x, r0.x
                    mov r0.x, r3.w
                    mul_pp r3.xyz, r2, c0
                    dp3_pp r1.x, r4, t1
                    max_pp r1.x, r1, c4.w
                    mov_pp r2.xyz, c0
                    mul r0.x, r0, r2.w
                    mul_pp r1.xyz, r3, r1.x
                    mul_pp r2.xyz, c1, r2
                    mad r0.xyz, r2, r0.x, r1
                    mul r0.xyz, r0, c4.x
                    mov_pp r0.w, c4
                    mov_pp oC0, r0
                    "
                }
                SubProgram "d3d11 " {
                    Keywords { "DIRECTIONAL" }
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    ConstBuffer "$Globals" 112
                    Vector 16 [_LightColor0]
                    Vector 32 [_SpecColor]
                    Vector 48 [_Color]
                    Float 64 [_Shininess]
                    BindCB  "$Globals" 0
                    "ps_4_0
                    eefiecedmmjhbpfcgbnnfmmmjomjhmimkhpgnpnlabaaaaaamaaeaaaaadaaaaaa
                    cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
                    aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
                    epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
                    aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
                    gbhcghgfheaaklklfdeieefcnaadaaaaeaaaaaaapeaaaaaafjaaaaaeegiocaaa
                    aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
                    fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
                    gcbaaaadpcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
                    adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaahbcaabaaa
                    aaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaa
                    akaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegbcbaaaadaaaaaaagaabaaa
                    aaaaaaaaegbcbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
                    egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
                    hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaa
                    abaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaap
                    dcaabaaaabaaaaaahgapbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
                    aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaa
                    aaaaaaaaegaabaaaabaaaaaaegaabaaaabaaaaaaddaaaaahicaabaaaaaaaaaaa
                    dkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaia
                    ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaabaaaaaadkaabaaa
                    aaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaa
                    baaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaaegbcbaaaacaaaaaadeaaaaak
                    dcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
                    aaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiecaabaaa
                    aaaaaaaaakiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaa
                    aaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaabjaaaaafbcaabaaaaaaaaaaa
                    akaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaa
                    aaaaaaaaaagabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
                    dkaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
                    aaaaaaaaadaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
                    aaaaaaaaabaaaaaadiaaaaajhcaabaaaacaaaaaaegiccaaaaaaaaaaaabaaaaaa
                    egiccaaaaaaaaaaaacaaaaaadiaaaaahncaabaaaaaaaaaaaagaabaaaaaaaaaaa
                    agajbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaafgafbaaa
                    aaaaaaaaigadbaaaaaaaaaaaaaaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
                    egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab
                    "
                }
                SubProgram "d3d11_9x " {
                    Keywords { "DIRECTIONAL" }
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    ConstBuffer "$Globals" 112
                    Vector 16 [_LightColor0]
                    Vector 32 [_SpecColor]
                    Vector 48 [_Color]
                    Float 64 [_Shininess]
                    BindCB  "$Globals" 0
                    "ps_4_0_level_9_1
                    eefiecedhejhkafhcbeleoamflhpfgdbelfkagnjabaaaaaagaahaaaaaeaaaaaa
                    daaaaaaammacaaaakeagaaaacmahaaaaebgpgodjjeacaaaajeacaaaaaaacpppp
                    fmacaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
                    abababaaaaaaabaaaeaaaaaaaaaaaaaaaaacppppfbaaaaafaeaaapkaaaaaaaea
                    aaaaialpaaaaaaaaaaaaiadpfbaaaaafafaaapkaaaaaaaedaaaaaaaaaaaaaaaa
                    aaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaachlabpaaaaac
                    aaaaaaiaacaachlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
                    aiaaaaadaaaaciiaacaaoelaacaaoelaahaaaaacaaaacbiaaaaappiaabaaaaac
                    abaaahiaacaaoelaaeaaaaaeaaaachiaabaaoeiaaaaaaaiaabaaoelaceaaaaac
                    abaachiaaaaaoeiaabaaaaacaaaaabiaaaaakklaabaaaaacaaaaaciaaaaappla
                    ecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaadacaacpiaaaaaoelaaaaioeka
                    aeaaaaaeadaacbiaaaaappiaaeaaaakaaeaaffkaaeaaaaaeadaacciaaaaaffia
                    aeaaaakaaeaaffkafkaaaaaeabaadiiaadaaoeiaadaaoeiaaeaakkkaacaaaaad
                    abaaciiaabaappibaeaappkaahaaaaacabaaciiaabaappiaagaaaaacadaaceia
                    abaappiaaiaaaaadadaaciiaadaaoeiaabaaoeiaaiaaaaadaaaacbiaadaaoeia
                    abaaoelaalaaaaadabaacbiaaaaaaaiaaeaakkkaalaaaaadaaaaabiaadaappia
                    aeaakkkaabaaaaacadaaabiaadaaaakaafaaaaadaaaaaciaadaaaaiaafaaaaka
                    caaaaaadabaaaciaaaaaaaiaaaaaffiaafaaaaadacaaaiiaacaappiaabaaffia
                    afaaaaadaaaachiaacaaoeiaacaaoekaafaaaaadaaaachiaaaaaoeiaaaaaoeka
                    abaaaaacacaaahiaaaaaoekaafaaaaadabaaaoiaacaabliaabaablkaafaaaaad
                    abaaaoiaacaappiaabaaoeiaaeaaaaaeaaaaahiaaaaaoeiaabaaaaiaabaablia
                    acaaaaadaaaachiaaaaaoeiaaaaaoeiaabaaaaacaaaaaiiaaeaakkkaabaaaaac
                    aaaicpiaaaaaoeiappppaaaafdeieefcnaadaaaaeaaaaaaapeaaaaaafjaaaaae
                    egiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
                    abaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
                    ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
                    hcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaah
                    bcaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaa
                    aaaaaaaaakaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegbcbaaaadaaaaaa
                    agaabaaaaaaaaaaaegbcbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
                    aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
                    diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaaj
                    pcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
                    dcaaaaapdcaabaaaabaaaaaahgapbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
                    aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaah
                    icaabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaabaaaaaaddaaaaahicaabaaa
                    aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaa
                    dkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaabaaaaaa
                    dkaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
                    aaaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaaegbcbaaaacaaaaaa
                    deaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
                    aaaaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
                    ecaabaaaaaaaaaaaakiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaeddiaaaaah
                    bcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaabjaaaaafbcaabaaa
                    aaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaa
                    eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
                    aaaaaaaadkaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
                    egiccaaaaaaaaaaaadaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
                    egiccaaaaaaaaaaaabaaaaaadiaaaaajhcaabaaaacaaaaaaegiccaaaaaaaaaaa
                    abaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahncaabaaaaaaaaaaaagaabaaa
                    aaaaaaaaagajbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaa
                    fgafbaaaaaaaaaaaigadbaaaaaaaaaaaaaaaaaahhccabaaaaaaaaaaaegacbaaa
                    aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaa
                    doaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
                    adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
                    apapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaheaaaaaa
                    acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
                    feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
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
                    "!!ARBfp1.0
                    PARAM c[7] = { program.local[0..4],
                    { 0, 2, 1, 128 },
                    { 0.5 } };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    TEX R3.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
                    TEX R2, fragment.texcoord[0], texture[0], 2D;
                    MAD R3.xy, R3.wyzw, c[5].y, -c[5].z;
                    DP3 R0.z, fragment.texcoord[3], fragment.texcoord[3];
                    MUL R3.zw, R3.xyxy, R3.xyxy;
                    ADD_SAT R3.z, R3, R3.w;
                    RCP R0.x, fragment.texcoord[3].w;
                    MAD R0.xy, fragment.texcoord[3], R0.x, c[6].x;
                    DP3 R1.x, fragment.texcoord[2], fragment.texcoord[2];
                    ADD R3.z, -R3, c[5];
                    RSQ R3.z, R3.z;
                    RCP R3.z, R3.z;
                    RSQ R1.x, R1.x;
                    MOV result.color.w, c[5].x;
                    TEX R0.w, R0, texture[2], 2D;
                    TEX R1.w, R0.z, texture[3], 2D;
                    DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
                    RSQ R0.x, R0.x;
                    MUL R0.xyz, R0.x, fragment.texcoord[1];
                    MAD R1.xyz, R1.x, fragment.texcoord[2], R0;
                    DP3 R3.w, R1, R1;
                    RSQ R3.w, R3.w;
                    MUL R1.xyz, R3.w, R1;
                    DP3 R1.x, R3, R1;
                    MOV R3.w, c[5];
                    MUL R1.y, R3.w, c[3].x;
                    MAX R1.x, R1, c[5];
                    POW R1.x, R1.x, R1.y;
                    MUL R2.w, R1.x, R2;
                    DP3 R1.x, R3, R0;
                    MUL R0.xyz, R2, c[2];
                    SLT R2.x, c[5], fragment.texcoord[3].z;
                    MUL R0.w, R2.x, R0;
                    MUL R0.w, R0, R1;
                    MUL R0.xyz, R0, c[0];
                    MAX R1.x, R1, c[5];
                    MUL R1.xyz, R0, R1.x;
                    MOV R0.xyz, c[1];
                    MUL R0.xyz, R0, c[0];
                    MUL R0.w, R0, c[5].y;
                    MAD R0.xyz, R0, R2.w, R1;
                    MUL result.color.xyz, R0, R0.w;
                    END
# 42 instructions, 4 R-regs
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
                    "ps_2_0
                    dcl_2d s0
                    dcl_2d s1
                    dcl_2d s2
                    dcl_2d s3
                    def c4, 2.00000000, -1.00000000, 1.00000000, 0.00000000
                    def c5, 128.00000000, 0.50000000, 0, 0
                    dcl t0
                    dcl t1.xyz
                    dcl t2.xyz
                    dcl t3
                    rcp r2.x, t3.w
                    mad r3.xy, t3, r2.x, c5.y
                    mov r0.y, t0.w
                    mov r0.x, t0.z
                    mov r1.xy, r0
                    dp3 r0.x, t3, t3
                    mov r2.xy, r0.x
                    texld r6, r2, s3
                    texld r1, r1, s1
                    texld r2, t0, s0
                    texld r0, r3, s2
                    dp3_pp r1.x, t1, t1
                    rsq_pp r3.x, r1.x
                    dp3_pp r1.x, t2, t2
                    mul_pp r2.xyz, r2, c2
                    mov r0.y, r1
                    mov r0.x, r1.w
                    mad_pp r4.xy, r0, c4.x, c4.y
                    mul_pp r0.xy, r4, r4
                    add_pp_sat r0.x, r0, r0.y
                    add_pp r0.x, -r0, c4.z
                    rsq_pp r0.x, r0.x
                    rcp_pp r4.z, r0.x
                    mov_pp r0.x, c3
                    mul_pp r3.xyz, r3.x, t1
                    rsq_pp r1.x, r1.x
                    mad_pp r5.xyz, r1.x, t2, r3
                    dp3_pp r1.x, r5, r5
                    rsq_pp r1.x, r1.x
                    mul_pp r1.xyz, r1.x, r5
                    dp3_pp r1.x, r4, r1
                    mul_pp r0.x, c5, r0
                    max_pp r1.x, r1, c4.w
                    pow r5.x, r1.x, r0.x
                    dp3_pp r1.x, r4, r3
                    mov r0.x, r5.x
                    mul r0.x, r0, r2.w
                    mov_pp r3.xyz, c0
                    max_pp r1.x, r1, c4.w
                    mul_pp r2.xyz, r2, c0
                    mul_pp r2.xyz, r2, r1.x
                    cmp r1.x, -t3.z, c4.w, c4.z
                    mul_pp r1.x, r1, r0.w
                    mul_pp r1.x, r1, r6
                    mul_pp r3.xyz, c1, r3
                    mul_pp r1.x, r1, c4
                    mad r0.xyz, r3, r0.x, r2
                    mul r0.xyz, r0, r1.x
                    mov_pp r0.w, c4
                    mov_pp oC0, r0
                    "
                }
                SubProgram "d3d11 " {
                    Keywords { "SPOT" }
                    SetTexture 0 [_MainTex] 2D 2
                    SetTexture 1 [_BumpMap] 2D 3
                    SetTexture 2 [_LightTexture0] 2D 0
                    SetTexture 3 [_LightTextureB0] 2D 1
                    ConstBuffer "$Globals" 176
                    Vector 16 [_LightColor0]
                    Vector 32 [_SpecColor]
                    Vector 112 [_Color]
                    Float 128 [_Shininess]
                    BindCB  "$Globals" 0
                    "ps_4_0
                    eefieceddaljplfnmgmpajjbhgmlegcjfgjndpplabaaaaaaiaagaaaaadaaaaaa
                    cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
                    aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
                    adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
                    feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
                    fdeieefchiafaaaaeaaaaaaafoabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
                    fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
                    acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
                    fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
                    fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
                    hcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaa
                    gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaahbcaabaaaaaaaaaaa
                    egbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
                    aaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaa
                    eeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahocaabaaaaaaaaaaa
                    fgafbaaaaaaaaaaaagbjbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaa
                    adaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaa
                    egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
                    aaaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
                    efaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
                    adaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaea
                    aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
                    apaaaaahbcaabaaaaaaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaah
                    bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaibcaabaaa
                    aaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
                    acaaaaaaakaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaa
                    egacbaaaabaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaacaaaaaajgahbaaa
                    aaaaaaaadeaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaaaa
                    aaaaaaaaaaaaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
                    diaaaaaiecaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaed
                    diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaabjaaaaaf
                    bcaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
                    abaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaa
                    akaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
                    abaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
                    abaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaajhcaabaaaacaaaaaaegiccaaa
                    aaaaaaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahncaabaaaaaaaaaaa
                    agaabaaaaaaaaaaaagajbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
                    abaaaaaafgafbaaaaaaaaaaaigadbaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaa
                    egbabaaaaeaaaaaapgbpbaaaaeaaaaaaaaaaaaakdcaabaaaabaaaaaaegaabaaa
                    abaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
                    abaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaadbaaaaah
                    icaabaaaaaaaaaaaabeaaaaaaaaaaaaackbabaaaaeaaaaaaabaaaaahicaabaaa
                    aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaa
                    dkaabaaaabaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaa
                    aeaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaaagaabaaaabaaaaaa
                    eghobaaaadaaaaaaaagabaaaabaaaaaaapaaaaahicaabaaaaaaaaaaapgapbaaa
                    aaaaaaaaagaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaa
                    egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab
                    "
                }
                SubProgram "d3d11_9x " {
                    Keywords { "SPOT" }
                    SetTexture 0 [_MainTex] 2D 2
                    SetTexture 1 [_BumpMap] 2D 3
                    SetTexture 2 [_LightTexture0] 2D 0
                    SetTexture 3 [_LightTextureB0] 2D 1
                    ConstBuffer "$Globals" 176
                    Vector 16 [_LightColor0]
                    Vector 32 [_SpecColor]
                    Vector 112 [_Color]
                    Float 128 [_Shininess]
                    BindCB  "$Globals" 0
                    "ps_4_0_level_9_1
                    eefiecedadnnnlpibaedimljingadbgiginedjcgabaaaaaaoiajaaaaaeaaaaaa
                    daaaaaaajeadaaaabeajaaaaleajaaaaebgpgodjfmadaaaafmadaaaaaaacpppp
                    baadaaaaemaaaaaaacaadeaaaaaaemaaaaaaemaaaeaaceaaaaaaemaaacaaaaaa
                    adababaaaaacacaaabadadaaaaaaabaaacaaaaaaaaaaaaaaaaaaahaaacaaacaa
                    aaaaaaaaaaacppppfbaaaaafaeaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadp
                    fbaaaaafafaaapkaaaaaaadpaaaaaaedaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
                    aaaaaplabpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaachlabpaaaaac
                    aaaaaaiaadaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
                    bpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkaaiaaaaadaaaaciia
                    acaaoelaacaaoelaahaaaaacaaaacbiaaaaappiaceaaaaacabaachiaabaaoela
                    aeaaaaaeaaaachiaacaaoelaaaaaaaiaabaaoeiaceaaaaacacaachiaaaaaoeia
                    abaaaaacaaaaabiaaaaakklaabaaaaacaaaaaciaaaaapplaagaaaaacabaaaiia
                    adaapplaaeaaaaaeadaaadiaadaaoelaabaappiaafaaaakaaiaaaaadabaaaiia
                    adaaoelaadaaoelaabaaaaacaeaaadiaabaappiaecaaaaadaaaacpiaaaaaoeia
                    adaioekaecaaaaadafaacpiaaaaaoelaacaioekaecaaaaadadaacpiaadaaoeia
                    aaaioekaecaaaaadaeaacpiaaeaaoeiaabaioekaaeaaaaaeadaacbiaaaaappia
                    aeaaaakaaeaaffkaaeaaaaaeadaacciaaaaaffiaaeaaaakaaeaaffkafkaaaaae
                    abaadiiaadaaoeiaadaaoeiaaeaakkkaacaaaaadabaaciiaabaappibaeaappka
                    ahaaaaacabaaciiaabaappiaagaaaaacadaaceiaabaappiaaiaaaaadabaaciia
                    adaaoeiaacaaoeiaaiaaaaadaaaacbiaadaaoeiaabaaoeiaalaaaaadabaacbia
                    aaaaaaiaaeaakkkaalaaaaadaaaaabiaabaappiaaeaakkkaabaaaaacaaaaacia
                    afaaffkaafaaaaadaaaaaciaaaaaffiaadaaaakacaaaaaadabaaaciaaaaaaaia
                    aaaaffiaafaaaaadafaaaiiaafaappiaabaaffiaafaaaaadaaaachiaafaaoeia
                    acaaoekaafaaaaadaaaachiaaaaaoeiaaaaaoekaabaaaaacacaaahiaaaaaoeka
                    afaaaaadabaaaoiaacaabliaabaablkaafaaaaadabaaaoiaafaappiaabaaoeia
                    aeaaaaaeaaaaahiaaaaaoeiaabaaaaiaabaabliaafaaaaadaaaaciiaadaappia
                    aeaaaaiafiaaaaaeaaaaciiaadaakklbaeaakkkaaaaappiaacaaaaadaaaaaiia
                    aaaappiaaaaappiaafaaaaadaaaachiaaaaappiaaaaaoeiaabaaaaacaaaaciia
                    aeaakkkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefchiafaaaaeaaaaaaa
                    foabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaa
                    fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaa
                    adaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
                    ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaa
                    ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
                    hcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaa
                    giaaaaacadaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaa
                    adaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaabaaaaaahccaabaaa
                    aaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaafccaabaaaaaaaaaaa
                    bkaabaaaaaaaaaaadiaaaaahocaabaaaaaaaaaaafgafbaaaaaaaaaaaagbjbaaa
                    acaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaaadaaaaaaagaabaaaaaaaaaaa
                    jgahbaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
                    abaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaa
                    abaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
                    ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaapdcaabaaa
                    acaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
                    aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahbcaabaaaaaaaaaaa
                    egaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaa
                    aaaaaaaaabeaaaaaaaaaiadpaaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaa
                    aaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaaakaabaaaaaaaaaaa
                    baaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaah
                    ccaabaaaaaaaaaaaegacbaaaacaaaaaajgahbaaaaaaaaaaadeaaaaakdcaabaaa
                    aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
                    cpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiecaabaaaaaaaaaaa
                    akiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaaaaaaaaa
                    akaabaaaaaaaaaaackaabaaaaaaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaa
                    aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
                    aagabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaa
                    abaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
                    ahaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
                    abaaaaaadiaaaaajhcaabaaaacaaaaaaegiccaaaaaaaaaaaabaaaaaaegiccaaa
                    aaaaaaaaacaaaaaadiaaaaahncaabaaaaaaaaaaaagaabaaaaaaaaaaaagajbaaa
                    acaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaafgafbaaaaaaaaaaa
                    igadbaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaaeaaaaaapgbpbaaa
                    aeaaaaaaaaaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaadp
                    aaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaa
                    eghobaaaacaaaaaaaagabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaaabeaaaaa
                    aaaaaaaackbabaaaaeaaaaaaabaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
                    abeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaa
                    aaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaa
                    efaaaaajpcaabaaaabaaaaaaagaabaaaabaaaaaaeghobaaaadaaaaaaaagabaaa
                    abaaaaaaapaaaaahicaabaaaaaaaaaaapgapbaaaaaaaaaaaagaabaaaabaaaaaa
                    diaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
                    iccabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaa
                    aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaa
                    adaaaaaaacaaaaaaahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
                    ahahaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfa
                    epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
                    aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
                    gbhcghgfheaaklkl"
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
                    "!!ARBfp1.0
                    PARAM c[6] = { program.local[0..4],
                    { 0, 2, 1, 128 } };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    TEX R3.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
                    TEX R2, fragment.texcoord[0], texture[0], 2D;
                    TEX R1.w, fragment.texcoord[3], texture[3], CUBE;
                    MAD R3.xy, R3.wyzw, c[5].y, -c[5].z;
                    DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
                    MUL R3.zw, R3.xyxy, R3.xyxy;
                    ADD_SAT R3.z, R3, R3.w;
                    DP3 R1.x, fragment.texcoord[2], fragment.texcoord[2];
                    ADD R3.z, -R3, c[5];
                    RSQ R3.z, R3.z;
                    RCP R3.z, R3.z;
                    RSQ R1.x, R1.x;
                    MOV result.color.w, c[5].x;
                    TEX R0.w, R0.x, texture[2], 2D;
                    DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
                    RSQ R0.x, R0.x;
                    MUL R0.xyz, R0.x, fragment.texcoord[1];
                    MAD R1.xyz, R1.x, fragment.texcoord[2], R0;
                    DP3 R3.w, R1, R1;
                    RSQ R3.w, R3.w;
                    MUL R1.xyz, R3.w, R1;
                    DP3 R1.x, R3, R1;
                    MOV R3.w, c[5];
                    MUL R0.w, R0, R1;
                    MUL R1.y, R3.w, c[3].x;
                    MAX R1.x, R1, c[5];
                    POW R1.x, R1.x, R1.y;
                    MUL R2.w, R1.x, R2;
                    DP3 R1.x, R3, R0;
                    MUL R0.xyz, R2, c[2];
                    MUL R0.xyz, R0, c[0];
                    MAX R1.x, R1, c[5];
                    MUL R1.xyz, R0, R1.x;
                    MOV R0.xyz, c[1];
                    MUL R0.xyz, R0, c[0];
                    MUL R0.w, R0, c[5].y;
                    MAD R0.xyz, R0, R2.w, R1;
                    MUL result.color.xyz, R0, R0.w;
                    END
# 38 instructions, 4 R-regs
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
                    "ps_2_0
                    dcl_2d s0
                    dcl_2d s1
                    dcl_2d s2
                    dcl_cube s3
                    def c4, 2.00000000, -1.00000000, 1.00000000, 0.00000000
                    def c5, 128.00000000, 0, 0, 0
                    dcl t0
                    dcl t1.xyz
                    dcl t2.xyz
                    dcl t3.xyz
                    texld r2, t0, s0
                    dp3 r0.x, t3, t3
                    mov r0.xy, r0.x
                    mul_pp r2.xyz, r2, c2
                    mov r1.y, t0.w
                    mov r1.x, t0.z
                    mul_pp r2.xyz, r2, c0
                    texld r6, r0, s2
                    texld r1, r1, s1
                    texld r0, t3, s3
                    dp3_pp r1.x, t1, t1
                    rsq_pp r3.x, r1.x
                    dp3_pp r1.x, t2, t2
                    mov r0.y, r1
                    mov r0.x, r1.w
                    mad_pp r4.xy, r0, c4.x, c4.y
                    mul_pp r0.xy, r4, r4
                    add_pp_sat r0.x, r0, r0.y
                    add_pp r0.x, -r0, c4.z
                    rsq_pp r0.x, r0.x
                    rcp_pp r4.z, r0.x
                    mov_pp r0.x, c3
                    mul_pp r3.xyz, r3.x, t1
                    rsq_pp r1.x, r1.x
                    mad_pp r5.xyz, r1.x, t2, r3
                    dp3_pp r1.x, r5, r5
                    rsq_pp r1.x, r1.x
                    mul_pp r1.xyz, r1.x, r5
                    dp3_pp r1.x, r4, r1
                    mul_pp r0.x, c5, r0
                    max_pp r1.x, r1, c4.w
                    pow r5.x, r1.x, r0.x
                    dp3_pp r1.x, r4, r3
                    max_pp r1.x, r1, c4.w
                    mov r0.x, r5.x
                    mul r0.x, r0, r2.w
                    mov_pp r3.xyz, c0
                    mul_pp r2.xyz, r2, r1.x
                    mul r1.x, r6, r0.w
                    mul_pp r3.xyz, c1, r3
                    mul_pp r1.x, r1, c4
                    mad r0.xyz, r3, r0.x, r2
                    mul r0.xyz, r0, r1.x
                    mov_pp r0.w, c4
                    mov_pp oC0, r0
                    "
                }
                SubProgram "d3d11 " {
                    Keywords { "POINT_COOKIE" }
                    SetTexture 0 [_MainTex] 2D 2
                    SetTexture 1 [_BumpMap] 2D 3
                    SetTexture 2 [_LightTextureB0] 2D 1
                    SetTexture 3 [_LightTexture0] CUBE 0
                    ConstBuffer "$Globals" 176
                    Vector 16 [_LightColor0]
                    Vector 32 [_SpecColor]
                    Vector 112 [_Color]
                    Float 128 [_Shininess]
                    BindCB  "$Globals" 0
                    "ps_4_0
                    eefiecedpbnlkiggofkhahabphhkpkdpjefojjacabaaaaaaoiafaaaaadaaaaaa
                    cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
                    aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
                    adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
                    feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
                    fdeieefcoaaeaaaaeaaaaaaadiabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
                    fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
                    acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
                    fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
                    fidaaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
                    hcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
                    gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaahbcaabaaaaaaaaaaa
                    egbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
                    aaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaa
                    eeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahocaabaaaaaaaaaaa
                    fgafbaaaaaaaaaaaagbjbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaa
                    adaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaa
                    egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
                    aaaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
                    efaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
                    adaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaea
                    aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
                    apaaaaahbcaabaaaaaaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaah
                    bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaibcaabaaa
                    aaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
                    acaaaaaaakaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaa
                    egacbaaaabaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaacaaaaaajgahbaaa
                    aaaaaaaadeaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaaaa
                    aaaaaaaaaaaaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
                    diaaaaaiecaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaed
                    diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaabjaaaaaf
                    bcaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
                    abaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaa
                    akaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
                    abaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
                    abaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaajhcaabaaaacaaaaaaegiccaaa
                    aaaaaaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahncaabaaaaaaaaaaa
                    agaabaaaaaaaaaaaagajbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
                    abaaaaaafgafbaaaaaaaaaaaigadbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
                    egbcbaaaaeaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaapgapbaaa
                    aaaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
                    egbcbaaaaeaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaaapaaaaahicaabaaa
                    aaaaaaaaagaabaaaabaaaaaapgapbaaaacaaaaaadiaaaaahhccabaaaaaaaaaaa
                    pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
                    aaaaaaaadoaaaaab"
                }
                SubProgram "d3d11_9x " {
                    Keywords { "POINT_COOKIE" }
                    SetTexture 0 [_MainTex] 2D 2
                    SetTexture 1 [_BumpMap] 2D 3
                    SetTexture 2 [_LightTextureB0] 2D 1
                    SetTexture 3 [_LightTexture0] CUBE 0
                    ConstBuffer "$Globals" 176
                    Vector 16 [_LightColor0]
                    Vector 32 [_SpecColor]
                    Vector 112 [_Color]
                    Float 128 [_Shininess]
                    BindCB  "$Globals" 0
                    "ps_4_0_level_9_1
                    eefiecedaklmlmaendpfbnkcnejcjbeojkgihcpdabaaaaaabmajaaaaaeaaaaaa
                    daaaaaaagaadaaaaeiaiaaaaoiaiaaaaebgpgodjciadaaaaciadaaaaaaacpppp
                    nmacaaaaemaaaaaaacaadeaaaaaaemaaaaaaemaaaeaaceaaaaaaemaaadaaaaaa
                    acababaaaaacacaaabadadaaaaaaabaaacaaaaaaaaaaaaaaaaaaahaaacaaacaa
                    aaaaaaaaaaacppppfbaaaaafaeaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadp
                    fbaaaaafafaaapkaaaaaaaedaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
                    aaaaaplabpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaachlabpaaaaac
                    aaaaaaiaadaaahlabpaaaaacaaaaaajiaaaiapkabpaaaaacaaaaaajaabaiapka
                    bpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkaaiaaaaadaaaaciia
                    acaaoelaacaaoelaahaaaaacaaaacbiaaaaappiaceaaaaacabaachiaabaaoela
                    aeaaaaaeaaaachiaacaaoelaaaaaaaiaabaaoeiaceaaaaacacaachiaaaaaoeia
                    abaaaaacaaaaabiaaaaakklaabaaaaacaaaaaciaaaaapplaaiaaaaadabaaaiia
                    adaaoelaadaaoelaabaaaaacadaaadiaabaappiaecaaaaadaaaacpiaaaaaoeia
                    adaioekaecaaaaadaeaacpiaaaaaoelaacaioekaecaaaaadadaaapiaadaaoeia
                    abaioekaecaaaaadafaaapiaadaaoelaaaaioekaaeaaaaaeafaacbiaaaaappia
                    aeaaaakaaeaaffkaaeaaaaaeafaacciaaaaaffiaaeaaaakaaeaaffkafkaaaaae
                    abaadiiaafaaoeiaafaaoeiaaeaakkkaacaaaaadabaaciiaabaappibaeaappka
                    ahaaaaacabaaciiaabaappiaagaaaaacafaaceiaabaappiaaiaaaaadabaaciia
                    afaaoeiaacaaoeiaaiaaaaadaaaacbiaafaaoeiaabaaoeiaalaaaaadabaacbia
                    aaaaaaiaaeaakkkaalaaaaadaaaaabiaabaappiaaeaakkkaabaaaaacacaaabia
                    adaaaakaafaaaaadaaaaaciaacaaaaiaafaaaakacaaaaaadabaaaciaaaaaaaia
                    aaaaffiaafaaaaadaeaaaiiaaeaappiaabaaffiaafaaaaadaaaachiaaeaaoeia
                    acaaoekaafaaaaadaaaachiaaaaaoeiaaaaaoekaabaaaaacacaaahiaaaaaoeka
                    afaaaaadabaaaoiaacaabliaabaablkaafaaaaadabaaaoiaaeaappiaabaaoeia
                    aeaaaaaeaaaaahiaaaaaoeiaabaaaaiaabaabliaafaaaaadaaaaciiaadaaaaia
                    afaappiaacaaaaadaaaaaiiaaaaappiaaaaappiaafaaaaadaaaachiaaaaappia
                    aaaaoeiaabaaaaacaaaaaiiaaeaakkkaabaaaaacaaaicpiaaaaaoeiappppaaaa
                    fdeieefcoaaeaaaaeaaaaaaadiabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
                    fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
                    acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
                    fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
                    fidaaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
                    hcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
                    gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaahbcaabaaaaaaaaaaa
                    egbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
                    aaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaa
                    eeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahocaabaaaaaaaaaaa
                    fgafbaaaaaaaaaaaagbjbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaa
                    adaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaa
                    egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
                    aaaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
                    efaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
                    adaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaea
                    aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
                    apaaaaahbcaabaaaaaaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaah
                    bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaibcaabaaa
                    aaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
                    acaaaaaaakaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaa
                    egacbaaaabaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaacaaaaaajgahbaaa
                    aaaaaaaadeaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaaaa
                    aaaaaaaaaaaaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
                    diaaaaaiecaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaed
                    diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaabjaaaaaf
                    bcaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
                    abaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaa
                    akaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
                    abaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
                    abaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaajhcaabaaaacaaaaaaegiccaaa
                    aaaaaaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahncaabaaaaaaaaaaa
                    agaabaaaaaaaaaaaagajbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
                    abaaaaaafgafbaaaaaaaaaaaigadbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
                    egbcbaaaaeaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaapgapbaaa
                    aaaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
                    egbcbaaaaeaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaaapaaaaahicaabaaa
                    aaaaaaaaagaabaaaabaaaaaapgapbaaaacaaaaaadiaaaaahhccabaaaaaaaaaaa
                    pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
                    aaaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaa
                    abaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
                    abaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
                    imaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaaadaaaaaa
                    aaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffied
                    epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
                    aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
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
                    "!!ARBfp1.0
                    PARAM c[6] = { program.local[0..4],
                    { 0, 2, 1, 128 } };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    TEX R0, fragment.texcoord[0], texture[0], 2D;
                    TEX R1.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
                    TEX R2.w, fragment.texcoord[3], texture[2], 2D;
                    MAD R1.xy, R1.wyzw, c[5].y, -c[5].z;
                    MUL R1.zw, R1.xyxy, R1.xyxy;
                    ADD_SAT R1.z, R1, R1.w;
                    DP3 R3.x, fragment.texcoord[2], fragment.texcoord[2];
                    ADD R1.z, -R1, c[5];
                    RSQ R1.z, R1.z;
                    RCP R1.z, R1.z;
                    MUL R0.xyz, R0, c[2];
                    MOV R2.xyz, fragment.texcoord[1];
                    RSQ R3.x, R3.x;
                    MAD R2.xyz, R3.x, fragment.texcoord[2], R2;
                    DP3 R1.w, R2, R2;
                    RSQ R1.w, R1.w;
                    MUL R2.xyz, R1.w, R2;
                    DP3 R2.x, R1, R2;
                    MOV R1.w, c[5];
                    MUL R2.y, R1.w, c[3].x;
                    MAX R1.w, R2.x, c[5].x;
                    POW R1.w, R1.w, R2.y;
                    MUL R0.w, R1, R0;
                    DP3 R1.w, R1, fragment.texcoord[1];
                    MUL R1.xyz, R0, c[0];
                    MAX R1.w, R1, c[5].x;
                    MUL R1.xyz, R1, R1.w;
                    MOV R0.xyz, c[1];
                    MUL R0.xyz, R0, c[0];
                    MUL R1.w, R2, c[5].y;
                    MAD R0.xyz, R0, R0.w, R1;
                    MUL result.color.xyz, R0, R1.w;
                    MOV result.color.w, c[5].x;
                    END
# 33 instructions, 4 R-regs
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
                    "ps_2_0
                    dcl_2d s0
                    dcl_2d s1
                    dcl_2d s2
                    def c4, 2.00000000, -1.00000000, 1.00000000, 0.00000000
                    def c5, 128.00000000, 0, 0, 0
                    dcl t0
                    dcl t1.xyz
                    dcl t2.xyz
                    dcl t3.xy
                    texld r2, t0, s0
                    mul_pp r2.xyz, r2, c2
                    mov r0.y, t0.w
                    mov r0.x, t0.z
                    mov r1.xy, r0
                    mul_pp r2.xyz, r2, c0
                    mov_pp r4.xyz, t1
                    texld r1, r1, s1
                    texld r0, t3, s2
                    dp3_pp r1.x, t2, t2
                    rsq_pp r1.x, r1.x
                    mad_pp r4.xyz, r1.x, t2, r4
                    dp3_pp r1.x, r4, r4
                    mov r0.y, r1
                    mov r0.x, r1.w
                    mad_pp r3.xy, r0, c4.x, c4.y
                    mul_pp r0.xy, r3, r3
                    add_pp_sat r0.x, r0, r0.y
                    add_pp r0.x, -r0, c4.z
                    rsq_pp r0.x, r0.x
                    rcp_pp r3.z, r0.x
                    rsq_pp r1.x, r1.x
                    mul_pp r1.xyz, r1.x, r4
                    dp3_pp r1.x, r3, r1
                    mov_pp r0.x, c3
                    mul_pp r0.x, c5, r0
                    max_pp r1.x, r1, c4.w
                    pow r4.x, r1.x, r0.x
                    dp3_pp r1.x, r3, t1
                    max_pp r1.x, r1, c4.w
                    mul_pp r3.xyz, r2, r1.x
                    mov r0.x, r4.x
                    mul r0.x, r0, r2.w
                    mul_pp r1.x, r0.w, c4
                    mov_pp r2.xyz, c0
                    mul_pp r2.xyz, c1, r2
                    mad r0.xyz, r2, r0.x, r3
                    mul r0.xyz, r0, r1.x
                    mov_pp r0.w, c4
                    mov_pp oC0, r0
                    "
                }
                SubProgram "d3d11 " {
                    Keywords { "DIRECTIONAL_COOKIE" }
                    SetTexture 0 [_MainTex] 2D 1
                    SetTexture 1 [_BumpMap] 2D 2
                    SetTexture 2 [_LightTexture0] 2D 0
                    ConstBuffer "$Globals" 176
                    Vector 16 [_LightColor0]
                    Vector 32 [_SpecColor]
                    Vector 112 [_Color]
                    Float 128 [_Shininess]
                    BindCB  "$Globals" 0
                    "ps_4_0
                    eefiecedciolmapjmenaabahokkendfjndfbncbfabaaaaaaeaafaaaaadaaaaaa
                    cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
                    aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
                    adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaa
                    feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
                    fdeieefcdiaeaaaaeaaaaaaaaoabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
                    fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
                    acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
                    ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
                    gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaaddcbabaaa
                    aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaahbcaabaaa
                    aaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaa
                    akaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegbcbaaaadaaaaaaagaabaaa
                    aaaaaaaaegbcbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
                    egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
                    hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaa
                    abaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaap
                    dcaabaaaabaaaaaahgapbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
                    aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaa
                    aaaaaaaaegaabaaaabaaaaaaegaabaaaabaaaaaaddaaaaahicaabaaaaaaaaaaa
                    dkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaia
                    ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaabaaaaaadkaabaaa
                    aaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaa
                    baaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaaegbcbaaaacaaaaaadeaaaaak
                    dcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
                    aaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiecaabaaa
                    aaaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaa
                    aaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaabjaaaaafbcaabaaaaaaaaaaa
                    akaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaa
                    aaaaaaaaaagabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
                    dkaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
                    aaaaaaaaahaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
                    aaaaaaaaabaaaaaadiaaaaajhcaabaaaacaaaaaaegiccaaaaaaaaaaaabaaaaaa
                    egiccaaaaaaaaaaaacaaaaaadiaaaaahncaabaaaaaaaaaaaagaabaaaaaaaaaaa
                    agajbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaafgafbaaa
                    aaaaaaaaigadbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaa
                    eghobaaaacaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaa
                    abaaaaaadkaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaa
                    egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab
                    "
                }
                SubProgram "d3d11_9x " {
                    Keywords { "DIRECTIONAL_COOKIE" }
                    SetTexture 0 [_MainTex] 2D 1
                    SetTexture 1 [_BumpMap] 2D 2
                    SetTexture 2 [_LightTexture0] 2D 0
                    ConstBuffer "$Globals" 176
                    Vector 16 [_LightColor0]
                    Vector 32 [_SpecColor]
                    Vector 112 [_Color]
                    Float 128 [_Shininess]
                    BindCB  "$Globals" 0
                    "ps_4_0_level_9_1
                    eefiecediicmkphflinocmekjajjeijmbjgdkchdabaaaaaaciaiaaaaaeaaaaaa
                    daaaaaaabeadaaaafeahaaaapeahaaaaebgpgodjnmacaaaanmacaaaaaaacpppp
                    jeacaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaacaaaaaa
                    aaababaaabacacaaaaaaabaaacaaaaaaaaaaaaaaaaaaahaaacaaacaaaaaaaaaa
                    aaacppppfbaaaaafaeaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaaf
                    afaaapkaaaaaaaedaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaapla
                    bpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaaia
                    adaaadlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaac
                    aaaaaajaacaiapkaaiaaaaadaaaaciiaacaaoelaacaaoelaahaaaaacaaaacbia
                    aaaappiaabaaaaacabaaahiaacaaoelaaeaaaaaeaaaachiaabaaoeiaaaaaaaia
                    abaaoelaceaaaaacabaachiaaaaaoeiaabaaaaacaaaaabiaaaaakklaabaaaaac
                    aaaaaciaaaaapplaecaaaaadaaaacpiaaaaaoeiaacaioekaecaaaaadacaacpia
                    aaaaoelaabaioekaecaaaaadadaacpiaadaaoelaaaaioekaaeaaaaaeadaacbia
                    aaaappiaaeaaaakaaeaaffkaaeaaaaaeadaacciaaaaaffiaaeaaaakaaeaaffka
                    fkaaaaaeabaadiiaadaaoeiaadaaoeiaaeaakkkaacaaaaadabaaciiaabaappib
                    aeaappkaahaaaaacabaaciiaabaappiaagaaaaacadaaceiaabaappiaaiaaaaad
                    aaaacbiaadaaoeiaabaaoeiaaiaaaaadaaaacciaadaaoeiaabaaoelaalaaaaad
                    abaacbiaaaaaffiaaeaakkkaalaaaaadabaaaciaaaaaaaiaaeaakkkaabaaaaac
                    aaaaabiaadaaaakaafaaaaadaaaaabiaaaaaaaiaafaaaakacaaaaaadadaaabia
                    abaaffiaaaaaaaiaafaaaaadacaaaiiaacaappiaadaaaaiaafaaaaadaaaachia
                    acaaoeiaacaaoekaafaaaaadaaaachiaaaaaoeiaaaaaoekaabaaaaacacaaahia
                    aaaaoekaafaaaaadabaaaoiaacaabliaabaablkaafaaaaadabaaaoiaacaappia
                    abaaoeiaaeaaaaaeaaaaahiaaaaaoeiaabaaaaiaabaabliaacaaaaadaaaaaiia
                    adaappiaadaappiaafaaaaadaaaachiaaaaappiaaaaaoeiaabaaaaacaaaaaiia
                    aeaakkkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcdiaeaaaaeaaaaaaa
                    aoabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaa
                    fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
                    aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
                    acaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
                    gcbaaaadhcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagfaaaaadpccabaaa
                    aaaaaaaagiaaaaacadaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaadaaaaaa
                    egbcbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
                    hcaabaaaaaaaaaaaegbcbaaaadaaaaaaagaabaaaaaaaaaaaegbcbaaaacaaaaaa
                    baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
                    icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
                    aaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaa
                    eghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaaabaaaaaahgapbaaa
                    abaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
                    aaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaabaaaaaa
                    egaabaaaabaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
                    aaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
                    aaaaiadpelaaaaafecaabaaaabaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaa
                    aaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaa
                    egacbaaaabaaaaaaegbcbaaaacaaaaaadeaaaaakdcaabaaaaaaaaaaaegaabaaa
                    aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaafbcaabaaa
                    aaaaaaaaakaabaaaaaaaaaaadiaaaaaiecaabaaaaaaaaaaaakiacaaaaaaaaaaa
                    aiaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
                    ckaabaaaaaaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaaj
                    pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
                    diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaai
                    hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaai
                    hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaaj
                    hcaabaaaacaaaaaaegiccaaaaaaaaaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaa
                    diaaaaahncaabaaaaaaaaaaaagaabaaaaaaaaaaaagajbaaaacaaaaaadcaaaaaj
                    hcaabaaaaaaaaaaaegacbaaaabaaaaaafgafbaaaaaaaaaaaigadbaaaaaaaaaaa
                    efaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaa
                    aaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaa
                    diaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
                    iccabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaa
                    aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaa
                    adaaaaaaacaaaaaaahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
                    ahahaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafdfgfpfa
                    epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
                    aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
                    gbhcghgfheaaklkl"
                }
            }
        }
        Pass {
            Name "PREPASS"
            Tags { "LIGHTMODE"="PrePassBase" }
            Fog { Mode Off }
            Blend SrcAlpha OneMinusSrcAlpha
            Program "vp" {
                SubProgram "opengl " {
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" ATTR14
                    Matrix 5 [_Object2World]
                    Vector 9 [unity_Scale]
                    Vector 10 [_BumpMap_ST]
                    "!!ARBvp1.0
                    PARAM c[11] = { program.local[0],
                    state.matrix.mvp,
                    program.local[5..10] };
                    TEMP R0;
                    TEMP R1;
                    MOV R0.xyz, vertex.attrib[14];
                    MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
                    MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
                    MUL R1.xyz, R0, vertex.attrib[14].w;
                    DP3 R0.y, R1, c[5];
                    DP3 R0.x, vertex.attrib[14], c[5];
                    DP3 R0.z, vertex.normal, c[5];
                    MUL result.texcoord[1].xyz, R0, c[9].w;
                    DP3 R0.y, R1, c[6];
                    DP3 R0.x, vertex.attrib[14], c[6];
                    DP3 R0.z, vertex.normal, c[6];
                    MUL result.texcoord[2].xyz, R0, c[9].w;
                    DP3 R0.y, R1, c[7];
                    DP3 R0.x, vertex.attrib[14], c[7];
                    DP3 R0.z, vertex.normal, c[7];
                    MUL result.texcoord[3].xyz, R0, c[9].w;
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
                    DP4 result.position.w, vertex.position, c[4];
                    DP4 result.position.z, vertex.position, c[3];
                    DP4 result.position.y, vertex.position, c[2];
                    DP4 result.position.x, vertex.position, c[1];
                    END
# 21 instructions, 2 R-regs
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
                    Vector 9 [_BumpMap_ST]
                    "vs_2_0
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
                    mul oT1.xyz, r0, c8.w
                    dp3 r0.y, r1, c5
                    dp3 r0.x, v1, c5
                    dp3 r0.z, v2, c5
                    mul oT2.xyz, r0, c8.w
                    dp3 r0.y, r1, c6
                    dp3 r0.x, v1, c6
                    dp3 r0.z, v2, c6
                    mul oT3.xyz, r0, c8.w
                    mad oT0.xy, v3, c9, c9.zwzw
                    dp4 oPos.w, v0, c3
                    dp4 oPos.z, v0, c2
                    dp4 oPos.y, v0, c1
                    dp4 oPos.x, v0, c0
                    "
                }
                SubProgram "d3d11 " {
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" TexCoord2
                    ConstBuffer "$Globals" 96
                    Vector 80 [_BumpMap_ST]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 192 [_Object2World]
                    Vector 320 [unity_Scale]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerDraw" 1
                    "vs_4_0
                    eefieceddofdaliokfballcidnldemeeghikookjabaaaaaajiafaaaaadaaaaaa
                    cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
                    abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
                    enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
                    aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaabaaaaaaaaaaaaaa
                    adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
                    ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
                    epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcpmadaaaaeaaaabaa
                    ppaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaa
                    bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
                    hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
                    abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
                    hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacadaaaaaadiaaaaai
                    pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
                    pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
                    aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
                    aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
                    adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
                    egbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaa
                    diaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaak
                    hcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaa
                    aaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaa
                    dgaaaaagbcaabaaaabaaaaaaakiacaaaabaaaaaaamaaaaaadgaaaaagccaabaaa
                    abaaaaaaakiacaaaabaaaaaaanaaaaaadgaaaaagecaabaaaabaaaaaaakiacaaa
                    abaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaa
                    abaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
                    baaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaai
                    hccabaaaacaaaaaaegacbaaaacaaaaaapgipcaaaabaaaaaabeaaaaaadgaaaaag
                    bcaabaaaabaaaaaabkiacaaaabaaaaaaamaaaaaadgaaaaagccaabaaaabaaaaaa
                    bkiacaaaabaaaaaaanaaaaaadgaaaaagecaabaaaabaaaaaabkiacaaaabaaaaaa
                    aoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
                    baaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
                    ecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaihccabaaa
                    adaaaaaaegacbaaaacaaaaaapgipcaaaabaaaaaabeaaaaaadgaaaaagbcaabaaa
                    abaaaaaackiacaaaabaaaaaaamaaaaaadgaaaaagccaabaaaabaaaaaackiacaaa
                    abaaaaaaanaaaaaadgaaaaagecaabaaaabaaaaaackiacaaaabaaaaaaaoaaaaaa
                    baaaaaahccaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
                    bcaabaaaaaaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaahecaabaaa
                    aaaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaihccabaaaaeaaaaaa
                    egacbaaaaaaaaaaapgipcaaaabaaaaaabeaaaaaadoaaaaab"
                }
                SubProgram "d3d11_9x " {
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "tangent" TexCoord2
                    ConstBuffer "$Globals" 96
                    Vector 80 [_BumpMap_ST]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 192 [_Object2World]
                    Vector 320 [unity_Scale]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerDraw" 1
                    "vs_4_0_level_9_1
                    eefiecedklopoeegfccblenojjggckhogjkcdgdkabaaaaaacaaiaaaaaeaaaaaa
                    daaaaaaaleacaaaaliagaaaaiaahaaaaebgpgodjhmacaaaahmacaaaaaaacpopp
                    ceacaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaafaa
                    abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaadaaagaaaaaaaaaa
                    abaabeaaabaaajaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapja
                    bpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadia
                    adaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaabaaaaacaaaaahia
                    abaaoejaafaaaaadabaaahiaaaaamjiaacaancjaaeaaaaaeaaaaahiaacaamjja
                    aaaanciaabaaoeibafaaaaadaaaaahiaaaaaoeiaabaappjaabaaaaacabaaabia
                    agaaaakaabaaaaacabaaaciaahaaaakaabaaaaacabaaaeiaaiaaaakaaiaaaaad
                    acaaaciaaaaaoeiaabaaoeiaaiaaaaadacaaabiaabaaoejaabaaoeiaaiaaaaad
                    acaaaeiaacaaoejaabaaoeiaafaaaaadabaaahoaacaaoeiaajaappkaabaaaaac
                    abaaabiaagaaffkaabaaaaacabaaaciaahaaffkaabaaaaacabaaaeiaaiaaffka
                    aiaaaaadacaaaciaaaaaoeiaabaaoeiaaiaaaaadacaaabiaabaaoejaabaaoeia
                    aiaaaaadacaaaeiaacaaoejaabaaoeiaafaaaaadacaaahoaacaaoeiaajaappka
                    abaaaaacabaaabiaagaakkkaabaaaaacabaaaciaahaakkkaabaaaaacabaaaeia
                    aiaakkkaaiaaaaadaaaaaciaaaaaoeiaabaaoeiaaiaaaaadaaaaabiaabaaoeja
                    abaaoeiaaiaaaaadaaaaaeiaacaaoejaabaaoeiaafaaaaadadaaahoaaaaaoeia
                    ajaappkaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapiaacaaoeka
                    aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeiaaeaaaaae
                    aaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoeka
                    aaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefcpmadaaaaeaaaabaa
                    ppaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaa
                    bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
                    hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
                    abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
                    hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacadaaaaaadiaaaaai
                    pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
                    pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
                    aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
                    aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
                    adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
                    egbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaa
                    diaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaak
                    hcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaa
                    aaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaa
                    dgaaaaagbcaabaaaabaaaaaaakiacaaaabaaaaaaamaaaaaadgaaaaagccaabaaa
                    abaaaaaaakiacaaaabaaaaaaanaaaaaadgaaaaagecaabaaaabaaaaaaakiacaaa
                    abaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaa
                    abaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
                    baaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaai
                    hccabaaaacaaaaaaegacbaaaacaaaaaapgipcaaaabaaaaaabeaaaaaadgaaaaag
                    bcaabaaaabaaaaaabkiacaaaabaaaaaaamaaaaaadgaaaaagccaabaaaabaaaaaa
                    bkiacaaaabaaaaaaanaaaaaadgaaaaagecaabaaaabaaaaaabkiacaaaabaaaaaa
                    aoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
                    baaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
                    ecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaihccabaaa
                    adaaaaaaegacbaaaacaaaaaapgipcaaaabaaaaaabeaaaaaadgaaaaagbcaabaaa
                    abaaaaaackiacaaaabaaaaaaamaaaaaadgaaaaagccaabaaaabaaaaaackiacaaa
                    abaaaaaaanaaaaaadgaaaaagecaabaaaabaaaaaackiacaaaabaaaaaaaoaaaaaa
                    baaaaaahccaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
                    bcaabaaaaaaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaahecaabaaa
                    aaaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaihccabaaaaeaaaaaa
                    egacbaaaaaaaaaaapgipcaaaabaaaaaabeaaaaaadoaaaaabejfdeheomaaaaaaa
                    agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
                    kbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaa
                    aaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
                    adaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
                    ljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeo
                    aafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaakl
                    epfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
                    aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
                    imaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaa
                    aaaaaaaaadaaaaaaadaaaaaaahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaa
                    aeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
                    "
                }
            }
            Program "fp" {
                SubProgram "opengl " {
                    Float 0 [_Shininess]
                    SetTexture 0 [_BumpMap] 2D 0
                    "!!ARBfp1.0
                    PARAM c[2] = { program.local[0],
                    { 2, 1, 0.5 } };
                    TEMP R0;
                    TEMP R1;
                    TEX R0.yw, fragment.texcoord[0], texture[0], 2D;
                    MAD R0.xy, R0.wyzw, c[1].x, -c[1].y;
                    MUL R0.zw, R0.xyxy, R0.xyxy;
                    ADD_SAT R0.z, R0, R0.w;
                    ADD R0.z, -R0, c[1].y;
                    RSQ R0.z, R0.z;
                    RCP R0.z, R0.z;
                    DP3 R1.z, fragment.texcoord[3], R0;
                    DP3 R1.x, R0, fragment.texcoord[1];
                    DP3 R1.y, R0, fragment.texcoord[2];
                    MAD result.color.xyz, R1, c[1].z, c[1].z;
                    MOV result.color.w, c[0].x;
                    END
# 12 instructions, 2 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Float 0 [_Shininess]
                    SetTexture 0 [_BumpMap] 2D 0
                    "ps_2_0
                    dcl_2d s0
                    def c1, 2.00000000, -1.00000000, 1.00000000, 0.50000000
                    dcl t0.xy
                    dcl t1.xyz
                    dcl t2.xyz
                    dcl t3.xyz
                    texld r0, t0, s0
                    mov r0.x, r0.w
                    mad_pp r1.xy, r0, c1.x, c1.y
                    mul_pp r0.xy, r1, r1
                    add_pp_sat r0.x, r0, r0.y
                    add_pp r0.x, -r0, c1.z
                    rsq_pp r0.x, r0.x
                    rcp_pp r1.z, r0.x
                    dp3 r0.z, t3, r1
                    dp3 r0.x, r1, t1
                    dp3 r0.y, r1, t2
                    mad_pp r0.xyz, r0, c1.w, c1.w
                    mov_pp r0.w, c0.x
                    mov_pp oC0, r0
                    "
                }
                SubProgram "d3d11 " {
                    SetTexture 0 [_BumpMap] 2D 0
                    ConstBuffer "$Globals" 96
                    Float 64 [_Shininess]
                    BindCB  "$Globals" 0
                    "ps_4_0
                    eefiecedpaddkbhnomdjlgchoachihcllgnienmiabaaaaaapiacaaaaadaaaaaa
                    cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
                    aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
                    adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
                    feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
                    fdeieefcpaabaaaaeaaaaaaahmaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaa
                    fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
                    dcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
                    gcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
                    efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
                    aaaaaaaadcaaaaapdcaabaaaaaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaea
                    aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
                    apaaaaahicaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaaddaaaaah
                    icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaa
                    aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
                    aaaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaacaaaaaa
                    egacbaaaaaaaaaaabaaaaaahccaabaaaabaaaaaaegbcbaaaadaaaaaaegacbaaa
                    aaaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaa
                    dcaaaaaphccabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadp
                    aaaaaadpaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadgaaaaag
                    iccabaaaaaaaaaaaakiacaaaaaaaaaaaaeaaaaaadoaaaaab"
                }
                SubProgram "d3d11_9x " {
                    SetTexture 0 [_BumpMap] 2D 0
                    ConstBuffer "$Globals" 96
                    Float 64 [_Shininess]
                    BindCB  "$Globals" 0
                    "ps_4_0_level_9_1
                    eefiecedcglaohkhlkedplgppohnoijoaloplcolabaaaaaahmaeaaaaaeaaaaaa
                    daaaaaaalaabaaaakiadaaaaeiaeaaaaebgpgodjhiabaaaahiabaaaaaaacpppp
                    eeabaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
                    aaaaaeaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaaeaaaaaialp
                    aaaaaaaaaaaaiadpfbaaaaafacaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
                    bpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaaiaabaaahlabpaaaaacaaaaaaia
                    acaaahlabpaaaaacaaaaaaiaadaaahlabpaaaaacaaaaaajaaaaiapkaecaaaaad
                    aaaacpiaaaaaoelaaaaioekaaeaaaaaeabaacbiaaaaappiaabaaaakaabaaffka
                    aeaaaaaeabaacciaaaaaffiaabaaaakaabaaffkafkaaaaaeabaadiiaabaaoeia
                    abaaoeiaabaakkkaacaaaaadabaaciiaabaappibabaappkaahaaaaacabaaciia
                    abaappiaagaaaaacabaaceiaabaappiaaiaaaaadaaaacbiaabaaoelaabaaoeia
                    aiaaaaadaaaacciaacaaoelaabaaoeiaaiaaaaadaaaaceiaadaaoelaabaaoeia
                    aeaaaaaeaaaachiaaaaaoeiaacaaaakaacaaaakaabaaaaacaaaaciiaaaaaaaka
                    abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcpaabaaaaeaaaaaaahmaaaaaa
                    fjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
                    aahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaa
                    acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaad
                    pccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
                    abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaapdcaabaaaaaaaaaaa
                    hgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
                    aaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaa
                    aaaaaaaaegaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
                    abeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
                    abeaaaaaaaaaiadpelaaaaafecaabaaaaaaaaaaadkaabaaaaaaaaaaabaaaaaah
                    bcaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaahccaabaaa
                    abaaaaaaegbcbaaaadaaaaaaegacbaaaaaaaaaaabaaaaaahecaabaaaabaaaaaa
                    egbcbaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaaphccabaaaaaaaaaaaegacbaaa
                    abaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaaceaaaaaaaaaaadp
                    aaaaaadpaaaaaadpaaaaaaaadgaaaaagiccabaaaaaaaaaaaakiacaaaaaaaaaaa
                    aeaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaa
                    abaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
                    abaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
                    imaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaaadaaaaaa
                    aaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffied
                    epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
                    aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
                }
            }
        }
        Pass {
            Name "PREPASS"
            Tags { "LIGHTMODE"="PrePassFinal" }
            ZWrite Off
            Blend SrcAlpha OneMinusSrcAlpha
            Program "vp" {
                SubProgram "opengl " {
                    Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Matrix 5 [_Object2World]
                    Vector 9 [_ProjectionParams]
                    Vector 10 [unity_SHAr]
                    Vector 11 [unity_SHAg]
                    Vector 12 [unity_SHAb]
                    Vector 13 [unity_SHBr]
                    Vector 14 [unity_SHBg]
                    Vector 15 [unity_SHBb]
                    Vector 16 [unity_SHC]
                    Vector 17 [unity_Scale]
                    Vector 18 [_MainTex_ST]
                    Vector 19 [_BumpMap_ST]
                    Vector 20 [_ResourceMap_ST]
                    "!!ARBvp1.0
                    PARAM c[21] = { { 0.5, 1 },
                    state.matrix.mvp,
                    program.local[5..20] };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    MUL R1.xyz, vertex.normal, c[17].w;
                    DP3 R2.w, R1, c[6];
                    DP3 R0.x, R1, c[5];
                    DP3 R0.z, R1, c[7];
                    MOV R0.y, R2.w;
                    MUL R1, R0.xyzz, R0.yzzx;
                    MOV R0.w, c[0].y;
                    DP4 R2.z, R0, c[12];
                    DP4 R2.y, R0, c[11];
                    DP4 R2.x, R0, c[10];
                    MUL R0.y, R2.w, R2.w;
                    DP4 R3.z, R1, c[15];
                    DP4 R3.y, R1, c[14];
                    DP4 R3.x, R1, c[13];
                    DP4 R1.w, vertex.position, c[4];
                    DP4 R1.z, vertex.position, c[3];
                    MAD R0.x, R0, R0, -R0.y;
                    ADD R3.xyz, R2, R3;
                    MUL R2.xyz, R0.x, c[16];
                    DP4 R1.x, vertex.position, c[1];
                    DP4 R1.y, vertex.position, c[2];
                    MUL R0.xyz, R1.xyww, c[0].x;
                    MUL R0.y, R0, c[9].x;
                    ADD result.texcoord[3].xyz, R3, R2;
                    ADD result.texcoord[2].xy, R0, R0.z;
                    MOV result.position, R1;
                    MOV result.texcoord[2].zw, R1;
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
                    MAD result.texcoord[1].xy, vertex.texcoord[0], c[20], c[20].zwzw;
                    END
# 30 instructions, 4 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 4 [_Object2World]
                    Vector 8 [_ProjectionParams]
                    Vector 9 [_ScreenParams]
                    Vector 10 [unity_SHAr]
                    Vector 11 [unity_SHAg]
                    Vector 12 [unity_SHAb]
                    Vector 13 [unity_SHBr]
                    Vector 14 [unity_SHBg]
                    Vector 15 [unity_SHBb]
                    Vector 16 [unity_SHC]
                    Vector 17 [unity_Scale]
                    Vector 18 [_MainTex_ST]
                    Vector 19 [_BumpMap_ST]
                    Vector 20 [_ResourceMap_ST]
                    "vs_2_0
                    def c21, 0.50000000, 1.00000000, 0, 0
                    dcl_position0 v0
                    dcl_normal0 v1
                    dcl_texcoord0 v2
                    mul r1.xyz, v1, c17.w
                    dp3 r2.w, r1, c5
                    dp3 r0.x, r1, c4
                    dp3 r0.z, r1, c6
                    mov r0.y, r2.w
                    mul r1, r0.xyzz, r0.yzzx
                    mov r0.w, c21.y
                    dp4 r2.z, r0, c12
                    dp4 r2.y, r0, c11
                    dp4 r2.x, r0, c10
                    mul r0.y, r2.w, r2.w
                    dp4 r3.z, r1, c15
                    dp4 r3.y, r1, c14
                    dp4 r3.x, r1, c13
                    dp4 r1.w, v0, c3
                    dp4 r1.z, v0, c2
                    mad r0.x, r0, r0, -r0.y
                    add r3.xyz, r2, r3
                    mul r2.xyz, r0.x, c16
                    dp4 r1.x, v0, c0
                    dp4 r1.y, v0, c1
                    mul r0.xyz, r1.xyww, c21.x
                    mul r0.y, r0, c8.x
                    add oT3.xyz, r3, r2
                    mad oT2.xy, r0.z, c9.zwzw, r0
                    mov oPos, r1
                    mov oT2.zw, r1
                    mad oT0.zw, v2.xyxy, c19.xyxy, c19
                    mad oT0.xy, v2, c18, c18.zwzw
                    mad oT1.xy, v2, c20, c20.zwzw
                    "
                }
                SubProgram "d3d11 " {
                    Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    ConstBuffer "$Globals" 144
                    Vector 80 [_MainTex_ST]
                    Vector 96 [_BumpMap_ST]
                    Vector 112 [_ResourceMap_ST]
                    ConstBuffer "UnityPerCamera" 128
                    Vector 80 [_ProjectionParams]
                    ConstBuffer "UnityLighting" 720
                    Vector 608 [unity_SHAr]
                    Vector 624 [unity_SHAg]
                    Vector 640 [unity_SHAb]
                    Vector 656 [unity_SHBr]
                    Vector 672 [unity_SHBg]
                    Vector 688 [unity_SHBb]
                    Vector 704 [unity_SHC]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 192 [_Object2World]
                    Vector 320 [unity_Scale]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerCamera" 1
                    BindCB  "UnityLighting" 2
                    BindCB  "UnityPerDraw" 3
                    "vs_4_0
                    eefiecedhimfjkcmklemalmjcdoeionajnfkffoeabaaaaaaaeagaaaaadaaaaaa
                    cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
                    abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
                    enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
                    aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
                    adaaaaaaacaaaaaaadamaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
                    apaaaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
                    epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcgiaeaaaaeaaaabaa
                    bkabaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaa
                    agaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaa
                    bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
                    dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
                    abaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
                    hccabaaaaeaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
                    aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
                    adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
                    aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
                    dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
                    egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
                    dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaa
                    aaaaaaaaafaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
                    aaaaaaaaagaaaaaakgiocaaaaaaaaaaaagaaaaaadcaaaaaldccabaaaacaaaaaa
                    egbabaaaadaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaa
                    diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
                    diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
                    aaaaaadpaaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaah
                    dccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaihcaabaaa
                    aaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaa
                    abaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaa
                    aaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaa
                    dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaa
                    egadbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaai
                    bcaabaaaabaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaai
                    ccaabaaaabaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaai
                    ecaabaaaabaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaaaaaaaaadiaaaaah
                    pcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaa
                    adaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaa
                    adaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaa
                    adaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaa
                    abaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahccaabaaaaaaaaaaa
                    bkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaa
                    aaaaaaaaakaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadcaaaaakhccabaaa
                    aeaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
                    doaaaaab"
                }
                SubProgram "d3d11_9x " {
                    Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    ConstBuffer "$Globals" 144
                    Vector 80 [_MainTex_ST]
                    Vector 96 [_BumpMap_ST]
                    Vector 112 [_ResourceMap_ST]
                    ConstBuffer "UnityPerCamera" 128
                    Vector 80 [_ProjectionParams]
                    ConstBuffer "UnityLighting" 720
                    Vector 608 [unity_SHAr]
                    Vector 624 [unity_SHAg]
                    Vector 640 [unity_SHAb]
                    Vector 656 [unity_SHBr]
                    Vector 672 [unity_SHBg]
                    Vector 688 [unity_SHBb]
                    Vector 704 [unity_SHC]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 192 [_Object2World]
                    Vector 320 [unity_Scale]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerCamera" 1
                    BindCB  "UnityLighting" 2
                    BindCB  "UnityPerDraw" 3
                    "vs_4_0_level_9_1
                    eefiecedcchahccdfbinfpbpihdmjejdofonclbpabaaaaaameaiaaaaaeaaaaaa
                    daaaaaaaomacaaaafmahaaaaceaiaaaaebgpgodjleacaaaaleacaaaaaaacpopp
                    eeacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaafaa
                    adaaabaaaaaaaaaaabaaafaaabaaaeaaaaaaaaaaacaacgaaahaaafaaaaaaaaaa
                    adaaaaaaaeaaamaaaaaaaaaaadaaamaaadaabaaaaaaaaaaaadaabeaaabaabdaa
                    aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbeaaapkaaaaaaadpaaaaiadpaaaaaaaa
                    aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
                    afaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaaeaaaaae
                    aaaaamoaadaaeejaacaaeekaacaaoekaaeaaaaaeabaaadoaadaaoejaadaaoeka
                    adaaookaafaaaaadaaaaapiaaaaaffjaanaaoekaaeaaaaaeaaaaapiaamaaoeka
                    aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaoaaoekaaaaakkjaaaaaoeiaaeaaaaae
                    aaaaapiaapaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffiaaeaaaaka
                    afaaaaadabaaaiiaabaaaaiabeaaaakaafaaaaadabaaafiaaaaapeiabeaaaaka
                    acaaaaadacaaadoaabaakkiaabaaomiaafaaaaadabaaahiaacaaoejabdaappka
                    afaaaaadacaaahiaabaaffiabbaaoekaaeaaaaaeabaaaliabaaakekaabaaaaia
                    acaakeiaaeaaaaaeabaaahiabcaaoekaabaakkiaabaapeiaabaaaaacabaaaiia
                    beaaffkaajaaaaadacaaabiaafaaoekaabaaoeiaajaaaaadacaaaciaagaaoeka
                    abaaoeiaajaaaaadacaaaeiaahaaoekaabaaoeiaafaaaaadadaaapiaabaacjia
                    abaakeiaajaaaaadaeaaabiaaiaaoekaadaaoeiaajaaaaadaeaaaciaajaaoeka
                    adaaoeiaajaaaaadaeaaaeiaakaaoekaadaaoeiaacaaaaadacaaahiaacaaoeia
                    aeaaoeiaafaaaaadabaaaciaabaaffiaabaaffiaaeaaaaaeabaaabiaabaaaaia
                    abaaaaiaabaaffibaeaaaaaeadaaahoaalaaoekaabaaaaiaacaaoeiaaeaaaaae
                    aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
                    acaaamoaaaaaoeiappppaaaafdeieefcgiaeaaaaeaaaabaabkabaaaafjaaaaae
                    egiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
                    egiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
                    pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
                    ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
                    dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
                    giaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
                    adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
                    agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
                    adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
                    aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
                    dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
                    egbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaa
                    dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaagaaaaaa
                    kgiocaaaaaaaaaaaagaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaa
                    egiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaadiaaaaaiccaabaaa
                    aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
                    abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
                    dgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaa
                    kgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaa
                    acaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
                    aaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaa
                    adaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhcaabaaa
                    aaaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaa
                    dgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaa
                    egiocaaaacaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaa
                    egiocaaaacaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaa
                    egiocaaaacaaaaaaciaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaa
                    jgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaa
                    acaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaa
                    acaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaa
                    acaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaa
                    abaaaaaaegacbaaaadaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
                    bkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
                    aaaaaaaabkaabaiaebaaaaaaaaaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaa
                    acaaaaaacmaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheo
                    maaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
                    apapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
                    apaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdej
                    feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
                    epfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
                    adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
                    apaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaimaaaaaa
                    acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaimaaaaaaadaaaaaaaaaaaaaa
                    adaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
                    aaklklkl"
                }
                SubProgram "opengl " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
                    Bind "vertex" Vertex
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    Matrix 9 [_Object2World]
                    Vector 13 [_ProjectionParams]
                    Vector 14 [unity_ShadowFadeCenterAndType]
                    Vector 15 [unity_LightmapST]
                    Vector 16 [_MainTex_ST]
                    Vector 17 [_BumpMap_ST]
                    Vector 18 [_ResourceMap_ST]
                    "!!ARBvp1.0
                    PARAM c[19] = { { 0.5, 1 },
                    state.matrix.modelview[0],
                    state.matrix.mvp,
                    program.local[9..18] };
                    TEMP R0;
                    TEMP R1;
                    DP4 R0.w, vertex.position, c[8];
                    DP4 R0.z, vertex.position, c[7];
                    DP4 R0.x, vertex.position, c[5];
                    DP4 R0.y, vertex.position, c[6];
                    MUL R1.xyz, R0.xyww, c[0].x;
                    MUL R1.y, R1, c[13].x;
                    ADD result.texcoord[2].xy, R1, R1.z;
                    MOV result.position, R0;
                    MOV R0.x, c[0].y;
                    ADD R0.y, R0.x, -c[14].w;
                    DP4 R0.x, vertex.position, c[3];
                    DP4 R1.z, vertex.position, c[11];
                    DP4 R1.x, vertex.position, c[9];
                    DP4 R1.y, vertex.position, c[10];
                    ADD R1.xyz, R1, -c[14];
                    MOV result.texcoord[2].zw, R0;
                    MUL result.texcoord[4].xyz, R1, c[14].w;
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[17].xyxy, c[17];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
                    MAD result.texcoord[1].xy, vertex.texcoord[0], c[18], c[18].zwzw;
                    MAD result.texcoord[3].xy, vertex.texcoord[1], c[15], c[15].zwzw;
                    MUL result.texcoord[4].w, -R0.x, R0.y;
                    END
# 22 instructions, 2 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
                    Bind "vertex" Vertex
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    Matrix 0 [glstate_matrix_modelview0]
                    Matrix 4 [glstate_matrix_mvp]
                    Matrix 8 [_Object2World]
                    Vector 12 [_ProjectionParams]
                    Vector 13 [_ScreenParams]
                    Vector 14 [unity_ShadowFadeCenterAndType]
                    Vector 15 [unity_LightmapST]
                    Vector 16 [_MainTex_ST]
                    Vector 17 [_BumpMap_ST]
                    Vector 18 [_ResourceMap_ST]
                    "vs_2_0
                    def c19, 0.50000000, 1.00000000, 0, 0
                    dcl_position0 v0
                    dcl_texcoord0 v1
                    dcl_texcoord1 v2
                    dp4 r0.w, v0, c7
                    dp4 r0.z, v0, c6
                    dp4 r0.x, v0, c4
                    dp4 r0.y, v0, c5
                    mul r1.xyz, r0.xyww, c19.x
                    mul r1.y, r1, c12.x
                    mad oT2.xy, r1.z, c13.zwzw, r1
                    mov oPos, r0
                    mov r0.x, c14.w
                    add r0.y, c19, -r0.x
                    dp4 r0.x, v0, c2
                    dp4 r1.z, v0, c10
                    dp4 r1.x, v0, c8
                    dp4 r1.y, v0, c9
                    add r1.xyz, r1, -c14
                    mov oT2.zw, r0
                    mul oT4.xyz, r1, c14.w
                    mad oT0.zw, v1.xyxy, c17.xyxy, c17
                    mad oT0.xy, v1, c16, c16.zwzw
                    mad oT1.xy, v1, c18, c18.zwzw
                    mad oT3.xy, v2, c15, c15.zwzw
                    mul oT4.w, -r0.x, r0.y
                    "
                }
                SubProgram "d3d11 " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    ConstBuffer "$Globals" 176
                    Vector 80 [unity_LightmapST]
                    Vector 96 [_MainTex_ST]
                    Vector 112 [_BumpMap_ST]
                    Vector 128 [_ResourceMap_ST]
                    ConstBuffer "UnityPerCamera" 128
                    Vector 80 [_ProjectionParams]
                    ConstBuffer "UnityShadows" 416
                    Vector 400 [unity_ShadowFadeCenterAndType]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 64 [glstate_matrix_modelview0]
                    Matrix 192 [_Object2World]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerCamera" 1
                    BindCB  "UnityShadows" 2
                    BindCB  "UnityPerDraw" 3
                    "vs_4_0
                    eefiecedemmhiipfbkgnmmhfbiopahkblncmieeoabaaaaaaaeagaaaaadaaaaaa
                    cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
                    abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
                    enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
                    aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
                    adaaaaaaacaaaaaaadamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    amadaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaa
                    aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
                    feeffiedepepfceeaaklklklfdeieefcfaaeaaaaeaaaabaabeabaaaafjaaaaae
                    egiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
                    egiocaaaacaaaaaabkaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaafpaaaaad
                    pcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaa
                    ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
                    dccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
                    gfaaaaadpccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
                    fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
                    egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
                    pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
                    aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
                    aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
                    dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaagaaaaaa
                    ogikcaaaaaaaaaaaagaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
                    agiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaaahaaaaaadcaaaaaldccabaaa
                    acaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaa
                    aiaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaaaeaaaaaaagiecaaaaaaaaaaa
                    afaaaaaakgiocaaaaaaaaaaaafaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
                    aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
                    aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
                    adaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaa
                    mgaabaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
                    adaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaa
                    agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
                    adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
                    aaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
                    aaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaa
                    bjaaaaaadiaaaaaihccabaaaaeaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaa
                    bjaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaa
                    afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaa
                    aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
                    agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
                    ckiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaj
                    ccaabaaaaaaaaaaadkiacaiaebaaaaaaacaaaaaabjaaaaaaabeaaaaaaaaaiadp
                    diaaaaaiiccabaaaaeaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaa
                    doaaaaab"
                }
                SubProgram "d3d11_9x " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    ConstBuffer "$Globals" 176
                    Vector 80 [unity_LightmapST]
                    Vector 96 [_MainTex_ST]
                    Vector 112 [_BumpMap_ST]
                    Vector 128 [_ResourceMap_ST]
                    ConstBuffer "UnityPerCamera" 128
                    Vector 80 [_ProjectionParams]
                    ConstBuffer "UnityShadows" 416
                    Vector 400 [unity_ShadowFadeCenterAndType]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 64 [glstate_matrix_modelview0]
                    Matrix 192 [_Object2World]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerCamera" 1
                    BindCB  "UnityShadows" 2
                    BindCB  "UnityPerDraw" 3
                    "vs_4_0_level_9_1
                    eefiecedljomhmebocjbbdhnnohijamnbbfcpmpoabaaaaaakeaiaaaaaeaaaaaa
                    daaaaaaammacaaaaceahaaaaomahaaaaebgpgodjjeacaaaajeacaaaaaaacpopp
                    daacaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaafaa
                    aeaaabaaaaaaaaaaabaaafaaabaaafaaaaaaaaaaacaabjaaabaaagaaaaaaaaaa
                    adaaaaaaaiaaahaaaaaaaaaaadaaamaaaeaaapaaaaaaaaaaaaaaaaaaaaacpopp
                    fbaaaaafbdaaapkaaaaaaadpaaaaiadpaaaaaaaaaaaaaaaabpaaaaacafaaaaia
                    aaaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjaaeaaaaae
                    aaaaadoaadaaoejaacaaoekaacaaookaaeaaaaaeaaaaamoaadaaeejaadaaeeka
                    adaaoekaaeaaaaaeabaaadoaadaaoejaaeaaoekaaeaaookaafaaaaadaaaaapia
                    aaaaffjaaiaaoekaaeaaaaaeaaaaapiaahaaoekaaaaaaajaaaaaoeiaaeaaaaae
                    aaaaapiaajaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaakaaoekaaaaappja
                    aaaaoeiaafaaaaadabaaabiaaaaaffiaafaaaakaafaaaaadabaaaiiaabaaaaia
                    bdaaaakaafaaaaadabaaafiaaaaapeiabdaaaakaacaaaaadacaaadoaabaakkia
                    abaaomiaaeaaaaaeabaaamoaaeaabejaabaabekaabaalekaafaaaaadabaaahia
                    aaaaffjabaaaoekaaeaaaaaeabaaahiaapaaoekaaaaaaajaabaaoeiaaeaaaaae
                    abaaahiabbaaoekaaaaakkjaabaaoeiaaeaaaaaeabaaahiabcaaoekaaaaappja
                    abaaoeiaacaaaaadabaaahiaabaaoeiaagaaoekbafaaaaadadaaahoaabaaoeia
                    agaappkaafaaaaadabaaabiaaaaaffjaamaakkkaaeaaaaaeabaaabiaalaakkka
                    aaaaaajaabaaaaiaaeaaaaaeabaaabiaanaakkkaaaaakkjaabaaaaiaaeaaaaae
                    abaaabiaaoaakkkaaaaappjaabaaaaiaabaaaaacabaaaiiaagaappkaacaaaaad
                    abaaaciaabaappibbdaaffkaafaaaaadadaaaioaabaaffiaabaaaaibaeaaaaae
                    aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
                    acaaamoaaaaaoeiappppaaaafdeieefcfaaeaaaaeaaaabaabeabaaaafjaaaaae
                    egiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
                    egiocaaaacaaaaaabkaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaafpaaaaad
                    pcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaa
                    ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
                    dccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
                    gfaaaaadpccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
                    fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
                    egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
                    pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
                    aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
                    aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
                    dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaagaaaaaa
                    ogikcaaaaaaaaaaaagaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
                    agiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaaahaaaaaadcaaaaaldccabaaa
                    acaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaa
                    aiaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaaaeaaaaaaagiecaaaaaaaaaaa
                    afaaaaaakgiocaaaaaaaaaaaafaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
                    aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
                    aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
                    adaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaa
                    mgaabaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
                    adaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaa
                    agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
                    adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
                    aaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
                    aaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaa
                    bjaaaaaadiaaaaaihccabaaaaeaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaa
                    bjaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaa
                    afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaa
                    aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
                    agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
                    ckiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaj
                    ccaabaaaaaaaaaaadkiacaiaebaaaaaaacaaaaaabjaaaaaaabeaaaaaaaaaiadp
                    diaaaaaiiccabaaaaeaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaa
                    doaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
                    apaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaalaaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaa
                    adaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaa
                    apaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
                    epepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
                    aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    adamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaamadaaaakeaaaaaa
                    acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaa
                    adaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
                    aaklklkl"
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
                    Vector 12 [unity_LightmapST]
                    Vector 13 [_MainTex_ST]
                    Vector 14 [_BumpMap_ST]
                    Vector 15 [_ResourceMap_ST]
                    "!!ARBvp1.0
                    PARAM c[16] = { { 0.5, 1 },
                    state.matrix.mvp,
                    program.local[5..15] };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    MOV R0.xyz, vertex.attrib[14];
                    MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
                    MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
                    MUL R3.xyz, R0, vertex.attrib[14].w;
                    MOV R1.xyz, c[9];
                    MOV R1.w, c[0].y;
                    DP4 R2.z, R1, c[7];
                    DP4 R2.x, R1, c[5];
                    DP4 R2.y, R1, c[6];
                    MAD R1.xyz, R2, c[11].w, -vertex.position;
                    DP4 R0.w, vertex.position, c[4];
                    DP4 R0.z, vertex.position, c[3];
                    DP4 R0.x, vertex.position, c[1];
                    DP4 R0.y, vertex.position, c[2];
                    MUL R2.xyz, R0.xyww, c[0].x;
                    MUL R2.y, R2, c[10].x;
                    DP3 result.texcoord[4].y, R1, R3;
                    ADD result.texcoord[2].xy, R2, R2.z;
                    DP3 result.texcoord[4].z, vertex.normal, R1;
                    DP3 result.texcoord[4].x, R1, vertex.attrib[14];
                    MOV result.position, R0;
                    MOV result.texcoord[2].zw, R0;
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[14].xyxy, c[14];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[13], c[13].zwzw;
                    MAD result.texcoord[1].xy, vertex.texcoord[0], c[15], c[15].zwzw;
                    MAD result.texcoord[3].xy, vertex.texcoord[1], c[12], c[12].zwzw;
                    END
# 26 instructions, 4 R-regs
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
                    Vector 12 [unity_LightmapST]
                    Vector 13 [_MainTex_ST]
                    Vector 14 [_BumpMap_ST]
                    Vector 15 [_ResourceMap_ST]
                    "vs_2_0
                    def c16, 0.50000000, 1.00000000, 0, 0
                    dcl_position0 v0
                    dcl_tangent0 v1
                    dcl_normal0 v2
                    dcl_texcoord0 v3
                    dcl_texcoord1 v4
                    mov r0.xyz, v1
                    mul r1.xyz, v2.zxyw, r0.yzxw
                    mov r0.xyz, v1
                    mad r0.xyz, v2.yzxw, r0.zxyw, -r1
                    mul r3.xyz, r0, v1.w
                    mov r1.xyz, c8
                    mov r1.w, c16.y
                    dp4 r2.z, r1, c6
                    dp4 r2.x, r1, c4
                    dp4 r2.y, r1, c5
                    mad r1.xyz, r2, c11.w, -v0
                    dp4 r0.w, v0, c3
                    dp4 r0.z, v0, c2
                    dp4 r0.x, v0, c0
                    dp4 r0.y, v0, c1
                    mul r2.xyz, r0.xyww, c16.x
                    mul r2.y, r2, c9.x
                    dp3 oT4.y, r1, r3
                    mad oT2.xy, r2.z, c10.zwzw, r2
                    dp3 oT4.z, v2, r1
                    dp3 oT4.x, r1, v1
                    mov oPos, r0
                    mov oT2.zw, r0
                    mad oT0.zw, v3.xyxy, c14.xyxy, c14
                    mad oT0.xy, v3, c13, c13.zwzw
                    mad oT1.xy, v3, c15, c15.zwzw
                    mad oT3.xy, v4, c12, c12.zwzw
                    "
                }
                SubProgram "d3d11 " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    Bind "tangent" TexCoord2
                    ConstBuffer "$Globals" 176
                    Vector 80 [unity_LightmapST]
                    Vector 96 [_MainTex_ST]
                    Vector 112 [_BumpMap_ST]
                    Vector 128 [_ResourceMap_ST]
                    ConstBuffer "UnityPerCamera" 128
                    Vector 64 [_WorldSpaceCameraPos] 3
                    Vector 80 [_ProjectionParams]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 256 [_World2Object]
                    Vector 320 [unity_Scale]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerCamera" 1
                    BindCB  "UnityPerDraw" 2
                    "vs_4_0
                    eefiecedmeffnbcfoengdbpeldnnojnklnoanhijabaaaaaanaafaaaaadaaaaaa
                    cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
                    abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
                    enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
                    aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
                    adaaaaaaacaaaaaaadamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    amadaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaa
                    aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
                    feeffiedepepfceeaaklklklfdeieefcbmaeaaaaeaaaabaaahabaaaafjaaaaae
                    egiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
                    egiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
                    abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
                    dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
                    abaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaagfaaaaad
                    pccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
                    pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
                    pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
                    aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
                    aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
                    adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
                    egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
                    aaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaadcaaaaalmccabaaaabaaaaaa
                    agbebaaaadaaaaaaagiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaaahaaaaaa
                    dcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaa
                    ogikcaaaaaaaaaaaaiaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaaaeaaaaaa
                    agiecaaaaaaaaaaaafaaaaaakgiocaaaaaaaaaaaafaaaaaadiaaaaaiccaabaaa
                    aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
                    abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
                    dgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaa
                    kgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaa
                    abaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaa
                    cgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
                    egacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaa
                    abaaaaaaaeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaa
                    egiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
                    dcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaa
                    aeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
                    egiccaaaacaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaa
                    pgipcaaaacaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaa
                    aeaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaaeaaaaaa
                    egbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaa
                    acaaaaaaegacbaaaabaaaaaadoaaaaab"
                }
                SubProgram "d3d11_9x " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    Bind "tangent" TexCoord2
                    ConstBuffer "$Globals" 176
                    Vector 80 [unity_LightmapST]
                    Vector 96 [_MainTex_ST]
                    Vector 112 [_BumpMap_ST]
                    Vector 128 [_ResourceMap_ST]
                    ConstBuffer "UnityPerCamera" 128
                    Vector 64 [_WorldSpaceCameraPos] 3
                    Vector 80 [_ProjectionParams]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 256 [_World2Object]
                    Vector 320 [unity_Scale]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerCamera" 1
                    BindCB  "UnityPerDraw" 2
                    "vs_4_0_level_9_1
                    eefiecedhpbajoheddknabnplefiieonagnejglkabaaaaaahaaiaaaaaeaaaaaa
                    daaaaaaammacaaaapaagaaaaliahaaaaebgpgodjjeacaaaajeacaaaaaaacpopp
                    dmacaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaafaa
                    aeaaabaaaaaaaaaaabaaaeaaacaaafaaaaaaaaaaacaaaaaaaeaaahaaaaaaaaaa
                    acaabaaaafaaalaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafbaaaapkaaaaaaadp
                    aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabia
                    abaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjabpaaaaac
                    afaaaeiaaeaaapjaaeaaaaaeaaaaadoaadaaoejaacaaoekaacaaookaaeaaaaae
                    aaaaamoaadaaeejaadaaeekaadaaoekaaeaaaaaeabaaadoaadaaoejaaeaaoeka
                    aeaaookaafaaaaadaaaaapiaaaaaffjaaiaaoekaaeaaaaaeaaaaapiaahaaoeka
                    aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaajaaoekaaaaakkjaaaaaoeiaaeaaaaae
                    aaaaapiaakaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffiaagaaaaka
                    afaaaaadabaaaiiaabaaaaiabaaaaakaafaaaaadabaaafiaaaaapeiabaaaaaka
                    acaaaaadacaaadoaabaakkiaabaaomiaaeaaaaaeabaaamoaaeaabejaabaabeka
                    abaalekaabaaaaacabaaahiaafaaoekaafaaaaadacaaahiaabaaffiaamaaoeka
                    aeaaaaaeabaaaliaalaakekaabaaaaiaacaakeiaaeaaaaaeabaaahiaanaaoeka
                    abaakkiaabaapeiaacaaaaadabaaahiaabaaoeiaaoaaoekaaeaaaaaeabaaahia
                    abaaoeiaapaappkaaaaaoejbaiaaaaadadaaaboaabaaoejaabaaoeiaabaaaaac
                    acaaahiaabaaoejaafaaaaadadaaahiaacaamjiaacaancjaaeaaaaaeacaaahia
                    acaamjjaacaanciaadaaoeibafaaaaadacaaahiaacaaoeiaabaappjaaiaaaaad
                    adaaacoaacaaoeiaabaaoeiaaiaaaaadadaaaeoaacaaoejaabaaoeiaaeaaaaae
                    aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
                    acaaamoaaaaaoeiappppaaaafdeieefcbmaeaaaaeaaaabaaahabaaaafjaaaaae
                    egiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
                    egiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
                    abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
                    dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
                    abaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaagfaaaaad
                    pccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
                    pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
                    pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
                    aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
                    aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
                    adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
                    egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
                    aaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaadcaaaaalmccabaaaabaaaaaa
                    agbebaaaadaaaaaaagiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaaahaaaaaa
                    dcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaa
                    ogikcaaaaaaaaaaaaiaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaaaeaaaaaa
                    agiecaaaaaaaaaaaafaaaaaakgiocaaaaaaaaaaaafaaaaaadiaaaaaiccaabaaa
                    aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
                    abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
                    dgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaa
                    kgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaa
                    abaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaa
                    cgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
                    egacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaa
                    abaaaaaaaeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaa
                    egiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
                    dcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaa
                    aeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
                    egiccaaaacaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaa
                    pgipcaaaacaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaa
                    aeaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaaeaaaaaa
                    egbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaa
                    acaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
                    jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
                    aaaaaaaaadaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
                    acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
                    laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaa
                    aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
                    aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaa
                    agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
                    keaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaa
                    aaaaaaaaadaaaaaaacaaaaaaadamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
                    acaaaaaaamadaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
                    keaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfe
                    ejepeoaafeeffiedepepfceeaaklklkl"
                }
                SubProgram "opengl " {
                    Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Matrix 5 [_Object2World]
                    Vector 9 [_ProjectionParams]
                    Vector 10 [unity_SHAr]
                    Vector 11 [unity_SHAg]
                    Vector 12 [unity_SHAb]
                    Vector 13 [unity_SHBr]
                    Vector 14 [unity_SHBg]
                    Vector 15 [unity_SHBb]
                    Vector 16 [unity_SHC]
                    Vector 17 [unity_Scale]
                    Vector 18 [_MainTex_ST]
                    Vector 19 [_BumpMap_ST]
                    Vector 20 [_ResourceMap_ST]
                    "!!ARBvp1.0
                    PARAM c[21] = { { 0.5, 1 },
                    state.matrix.mvp,
                    program.local[5..20] };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    MUL R1.xyz, vertex.normal, c[17].w;
                    DP3 R2.w, R1, c[6];
                    DP3 R0.x, R1, c[5];
                    DP3 R0.z, R1, c[7];
                    MOV R0.y, R2.w;
                    MUL R1, R0.xyzz, R0.yzzx;
                    MOV R0.w, c[0].y;
                    DP4 R2.z, R0, c[12];
                    DP4 R2.y, R0, c[11];
                    DP4 R2.x, R0, c[10];
                    MUL R0.y, R2.w, R2.w;
                    DP4 R3.z, R1, c[15];
                    DP4 R3.y, R1, c[14];
                    DP4 R3.x, R1, c[13];
                    DP4 R1.w, vertex.position, c[4];
                    DP4 R1.z, vertex.position, c[3];
                    MAD R0.x, R0, R0, -R0.y;
                    ADD R3.xyz, R2, R3;
                    MUL R2.xyz, R0.x, c[16];
                    DP4 R1.x, vertex.position, c[1];
                    DP4 R1.y, vertex.position, c[2];
                    MUL R0.xyz, R1.xyww, c[0].x;
                    MUL R0.y, R0, c[9].x;
                    ADD result.texcoord[3].xyz, R3, R2;
                    ADD result.texcoord[2].xy, R0, R0.z;
                    MOV result.position, R1;
                    MOV result.texcoord[2].zw, R1;
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
                    MAD result.texcoord[1].xy, vertex.texcoord[0], c[20], c[20].zwzw;
                    END
# 30 instructions, 4 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
                    Bind "vertex" Vertex
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 4 [_Object2World]
                    Vector 8 [_ProjectionParams]
                    Vector 9 [_ScreenParams]
                    Vector 10 [unity_SHAr]
                    Vector 11 [unity_SHAg]
                    Vector 12 [unity_SHAb]
                    Vector 13 [unity_SHBr]
                    Vector 14 [unity_SHBg]
                    Vector 15 [unity_SHBb]
                    Vector 16 [unity_SHC]
                    Vector 17 [unity_Scale]
                    Vector 18 [_MainTex_ST]
                    Vector 19 [_BumpMap_ST]
                    Vector 20 [_ResourceMap_ST]
                    "vs_2_0
                    def c21, 0.50000000, 1.00000000, 0, 0
                    dcl_position0 v0
                    dcl_normal0 v1
                    dcl_texcoord0 v2
                    mul r1.xyz, v1, c17.w
                    dp3 r2.w, r1, c5
                    dp3 r0.x, r1, c4
                    dp3 r0.z, r1, c6
                    mov r0.y, r2.w
                    mul r1, r0.xyzz, r0.yzzx
                    mov r0.w, c21.y
                    dp4 r2.z, r0, c12
                    dp4 r2.y, r0, c11
                    dp4 r2.x, r0, c10
                    mul r0.y, r2.w, r2.w
                    dp4 r3.z, r1, c15
                    dp4 r3.y, r1, c14
                    dp4 r3.x, r1, c13
                    dp4 r1.w, v0, c3
                    dp4 r1.z, v0, c2
                    mad r0.x, r0, r0, -r0.y
                    add r3.xyz, r2, r3
                    mul r2.xyz, r0.x, c16
                    dp4 r1.x, v0, c0
                    dp4 r1.y, v0, c1
                    mul r0.xyz, r1.xyww, c21.x
                    mul r0.y, r0, c8.x
                    add oT3.xyz, r3, r2
                    mad oT2.xy, r0.z, c9.zwzw, r0
                    mov oPos, r1
                    mov oT2.zw, r1
                    mad oT0.zw, v2.xyxy, c19.xyxy, c19
                    mad oT0.xy, v2, c18, c18.zwzw
                    mad oT1.xy, v2, c20, c20.zwzw
                    "
                }
                SubProgram "d3d11 " {
                    Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    ConstBuffer "$Globals" 144
                    Vector 80 [_MainTex_ST]
                    Vector 96 [_BumpMap_ST]
                    Vector 112 [_ResourceMap_ST]
                    ConstBuffer "UnityPerCamera" 128
                    Vector 80 [_ProjectionParams]
                    ConstBuffer "UnityLighting" 720
                    Vector 608 [unity_SHAr]
                    Vector 624 [unity_SHAg]
                    Vector 640 [unity_SHAb]
                    Vector 656 [unity_SHBr]
                    Vector 672 [unity_SHBg]
                    Vector 688 [unity_SHBb]
                    Vector 704 [unity_SHC]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 192 [_Object2World]
                    Vector 320 [unity_Scale]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerCamera" 1
                    BindCB  "UnityLighting" 2
                    BindCB  "UnityPerDraw" 3
                    "vs_4_0
                    eefiecedhimfjkcmklemalmjcdoeionajnfkffoeabaaaaaaaeagaaaaadaaaaaa
                    cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
                    abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
                    enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
                    aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
                    adaaaaaaacaaaaaaadamaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
                    apaaaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
                    epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcgiaeaaaaeaaaabaa
                    bkabaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaa
                    agaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaa
                    bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
                    dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
                    abaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
                    hccabaaaaeaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
                    aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
                    adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
                    aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
                    dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
                    egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
                    dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaa
                    aaaaaaaaafaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
                    aaaaaaaaagaaaaaakgiocaaaaaaaaaaaagaaaaaadcaaaaaldccabaaaacaaaaaa
                    egbabaaaadaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaa
                    diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
                    diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
                    aaaaaadpaaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaah
                    dccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaihcaabaaa
                    aaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaa
                    abaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaa
                    aaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaa
                    dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaa
                    egadbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaai
                    bcaabaaaabaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaai
                    ccaabaaaabaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaai
                    ecaabaaaabaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaaaaaaaaadiaaaaah
                    pcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaa
                    adaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaa
                    adaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaa
                    adaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaa
                    abaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahccaabaaaaaaaaaaa
                    bkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaa
                    aaaaaaaaakaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadcaaaaakhccabaaa
                    aeaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
                    doaaaaab"
                }
                SubProgram "d3d11_9x " {
                    Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    ConstBuffer "$Globals" 144
                    Vector 80 [_MainTex_ST]
                    Vector 96 [_BumpMap_ST]
                    Vector 112 [_ResourceMap_ST]
                    ConstBuffer "UnityPerCamera" 128
                    Vector 80 [_ProjectionParams]
                    ConstBuffer "UnityLighting" 720
                    Vector 608 [unity_SHAr]
                    Vector 624 [unity_SHAg]
                    Vector 640 [unity_SHAb]
                    Vector 656 [unity_SHBr]
                    Vector 672 [unity_SHBg]
                    Vector 688 [unity_SHBb]
                    Vector 704 [unity_SHC]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 192 [_Object2World]
                    Vector 320 [unity_Scale]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerCamera" 1
                    BindCB  "UnityLighting" 2
                    BindCB  "UnityPerDraw" 3
                    "vs_4_0_level_9_1
                    eefiecedcchahccdfbinfpbpihdmjejdofonclbpabaaaaaameaiaaaaaeaaaaaa
                    daaaaaaaomacaaaafmahaaaaceaiaaaaebgpgodjleacaaaaleacaaaaaaacpopp
                    eeacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaafaa
                    adaaabaaaaaaaaaaabaaafaaabaaaeaaaaaaaaaaacaacgaaahaaafaaaaaaaaaa
                    adaaaaaaaeaaamaaaaaaaaaaadaaamaaadaabaaaaaaaaaaaadaabeaaabaabdaa
                    aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbeaaapkaaaaaaadpaaaaiadpaaaaaaaa
                    aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
                    afaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaaeaaaaae
                    aaaaamoaadaaeejaacaaeekaacaaoekaaeaaaaaeabaaadoaadaaoejaadaaoeka
                    adaaookaafaaaaadaaaaapiaaaaaffjaanaaoekaaeaaaaaeaaaaapiaamaaoeka
                    aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaoaaoekaaaaakkjaaaaaoeiaaeaaaaae
                    aaaaapiaapaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffiaaeaaaaka
                    afaaaaadabaaaiiaabaaaaiabeaaaakaafaaaaadabaaafiaaaaapeiabeaaaaka
                    acaaaaadacaaadoaabaakkiaabaaomiaafaaaaadabaaahiaacaaoejabdaappka
                    afaaaaadacaaahiaabaaffiabbaaoekaaeaaaaaeabaaaliabaaakekaabaaaaia
                    acaakeiaaeaaaaaeabaaahiabcaaoekaabaakkiaabaapeiaabaaaaacabaaaiia
                    beaaffkaajaaaaadacaaabiaafaaoekaabaaoeiaajaaaaadacaaaciaagaaoeka
                    abaaoeiaajaaaaadacaaaeiaahaaoekaabaaoeiaafaaaaadadaaapiaabaacjia
                    abaakeiaajaaaaadaeaaabiaaiaaoekaadaaoeiaajaaaaadaeaaaciaajaaoeka
                    adaaoeiaajaaaaadaeaaaeiaakaaoekaadaaoeiaacaaaaadacaaahiaacaaoeia
                    aeaaoeiaafaaaaadabaaaciaabaaffiaabaaffiaaeaaaaaeabaaabiaabaaaaia
                    abaaaaiaabaaffibaeaaaaaeadaaahoaalaaoekaabaaaaiaacaaoeiaaeaaaaae
                    aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
                    acaaamoaaaaaoeiappppaaaafdeieefcgiaeaaaaeaaaabaabkabaaaafjaaaaae
                    egiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
                    egiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
                    pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
                    ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
                    dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
                    giaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
                    adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
                    agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
                    adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
                    aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
                    dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
                    egbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaa
                    dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaagaaaaaa
                    kgiocaaaaaaaaaaaagaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaa
                    egiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaadiaaaaaiccaabaaa
                    aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
                    abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
                    dgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaa
                    kgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaa
                    acaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
                    aaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaa
                    adaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhcaabaaa
                    aaaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaa
                    dgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaa
                    egiocaaaacaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaa
                    egiocaaaacaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaa
                    egiocaaaacaaaaaaciaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaa
                    jgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaa
                    acaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaa
                    acaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaa
                    acaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaa
                    abaaaaaaegacbaaaadaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
                    bkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
                    aaaaaaaabkaabaiaebaaaaaaaaaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaa
                    acaaaaaacmaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheo
                    maaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
                    apapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
                    apaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdej
                    feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
                    epfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
                    adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
                    apaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaimaaaaaa
                    acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaimaaaaaaadaaaaaaaaaaaaaa
                    adaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
                    aaklklkl"
                }
                SubProgram "opengl " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
                    Bind "vertex" Vertex
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    Matrix 9 [_Object2World]
                    Vector 13 [_ProjectionParams]
                    Vector 14 [unity_ShadowFadeCenterAndType]
                    Vector 15 [unity_LightmapST]
                    Vector 16 [_MainTex_ST]
                    Vector 17 [_BumpMap_ST]
                    Vector 18 [_ResourceMap_ST]
                    "!!ARBvp1.0
                    PARAM c[19] = { { 0.5, 1 },
                    state.matrix.modelview[0],
                    state.matrix.mvp,
                    program.local[9..18] };
                    TEMP R0;
                    TEMP R1;
                    DP4 R0.w, vertex.position, c[8];
                    DP4 R0.z, vertex.position, c[7];
                    DP4 R0.x, vertex.position, c[5];
                    DP4 R0.y, vertex.position, c[6];
                    MUL R1.xyz, R0.xyww, c[0].x;
                    MUL R1.y, R1, c[13].x;
                    ADD result.texcoord[2].xy, R1, R1.z;
                    MOV result.position, R0;
                    MOV R0.x, c[0].y;
                    ADD R0.y, R0.x, -c[14].w;
                    DP4 R0.x, vertex.position, c[3];
                    DP4 R1.z, vertex.position, c[11];
                    DP4 R1.x, vertex.position, c[9];
                    DP4 R1.y, vertex.position, c[10];
                    ADD R1.xyz, R1, -c[14];
                    MOV result.texcoord[2].zw, R0;
                    MUL result.texcoord[4].xyz, R1, c[14].w;
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[17].xyxy, c[17];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
                    MAD result.texcoord[1].xy, vertex.texcoord[0], c[18], c[18].zwzw;
                    MAD result.texcoord[3].xy, vertex.texcoord[1], c[15], c[15].zwzw;
                    MUL result.texcoord[4].w, -R0.x, R0.y;
                    END
# 22 instructions, 2 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
                    Bind "vertex" Vertex
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    Matrix 0 [glstate_matrix_modelview0]
                    Matrix 4 [glstate_matrix_mvp]
                    Matrix 8 [_Object2World]
                    Vector 12 [_ProjectionParams]
                    Vector 13 [_ScreenParams]
                    Vector 14 [unity_ShadowFadeCenterAndType]
                    Vector 15 [unity_LightmapST]
                    Vector 16 [_MainTex_ST]
                    Vector 17 [_BumpMap_ST]
                    Vector 18 [_ResourceMap_ST]
                    "vs_2_0
                    def c19, 0.50000000, 1.00000000, 0, 0
                    dcl_position0 v0
                    dcl_texcoord0 v1
                    dcl_texcoord1 v2
                    dp4 r0.w, v0, c7
                    dp4 r0.z, v0, c6
                    dp4 r0.x, v0, c4
                    dp4 r0.y, v0, c5
                    mul r1.xyz, r0.xyww, c19.x
                    mul r1.y, r1, c12.x
                    mad oT2.xy, r1.z, c13.zwzw, r1
                    mov oPos, r0
                    mov r0.x, c14.w
                    add r0.y, c19, -r0.x
                    dp4 r0.x, v0, c2
                    dp4 r1.z, v0, c10
                    dp4 r1.x, v0, c8
                    dp4 r1.y, v0, c9
                    add r1.xyz, r1, -c14
                    mov oT2.zw, r0
                    mul oT4.xyz, r1, c14.w
                    mad oT0.zw, v1.xyxy, c17.xyxy, c17
                    mad oT0.xy, v1, c16, c16.zwzw
                    mad oT1.xy, v1, c18, c18.zwzw
                    mad oT3.xy, v2, c15, c15.zwzw
                    mul oT4.w, -r0.x, r0.y
                    "
                }
                SubProgram "d3d11 " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    ConstBuffer "$Globals" 176
                    Vector 80 [unity_LightmapST]
                    Vector 96 [_MainTex_ST]
                    Vector 112 [_BumpMap_ST]
                    Vector 128 [_ResourceMap_ST]
                    ConstBuffer "UnityPerCamera" 128
                    Vector 80 [_ProjectionParams]
                    ConstBuffer "UnityShadows" 416
                    Vector 400 [unity_ShadowFadeCenterAndType]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 64 [glstate_matrix_modelview0]
                    Matrix 192 [_Object2World]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerCamera" 1
                    BindCB  "UnityShadows" 2
                    BindCB  "UnityPerDraw" 3
                    "vs_4_0
                    eefiecedemmhiipfbkgnmmhfbiopahkblncmieeoabaaaaaaaeagaaaaadaaaaaa
                    cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
                    abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
                    enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
                    aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
                    adaaaaaaacaaaaaaadamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    amadaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaa
                    aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
                    feeffiedepepfceeaaklklklfdeieefcfaaeaaaaeaaaabaabeabaaaafjaaaaae
                    egiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
                    egiocaaaacaaaaaabkaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaafpaaaaad
                    pcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaa
                    ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
                    dccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
                    gfaaaaadpccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
                    fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
                    egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
                    pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
                    aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
                    aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
                    dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaagaaaaaa
                    ogikcaaaaaaaaaaaagaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
                    agiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaaahaaaaaadcaaaaaldccabaaa
                    acaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaa
                    aiaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaaaeaaaaaaagiecaaaaaaaaaaa
                    afaaaaaakgiocaaaaaaaaaaaafaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
                    aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
                    aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
                    adaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaa
                    mgaabaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
                    adaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaa
                    agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
                    adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
                    aaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
                    aaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaa
                    bjaaaaaadiaaaaaihccabaaaaeaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaa
                    bjaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaa
                    afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaa
                    aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
                    agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
                    ckiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaj
                    ccaabaaaaaaaaaaadkiacaiaebaaaaaaacaaaaaabjaaaaaaabeaaaaaaaaaiadp
                    diaaaaaiiccabaaaaeaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaa
                    doaaaaab"
                }
                SubProgram "d3d11_9x " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    ConstBuffer "$Globals" 176
                    Vector 80 [unity_LightmapST]
                    Vector 96 [_MainTex_ST]
                    Vector 112 [_BumpMap_ST]
                    Vector 128 [_ResourceMap_ST]
                    ConstBuffer "UnityPerCamera" 128
                    Vector 80 [_ProjectionParams]
                    ConstBuffer "UnityShadows" 416
                    Vector 400 [unity_ShadowFadeCenterAndType]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 64 [glstate_matrix_modelview0]
                    Matrix 192 [_Object2World]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerCamera" 1
                    BindCB  "UnityShadows" 2
                    BindCB  "UnityPerDraw" 3
                    "vs_4_0_level_9_1
                    eefiecedljomhmebocjbbdhnnohijamnbbfcpmpoabaaaaaakeaiaaaaaeaaaaaa
                    daaaaaaammacaaaaceahaaaaomahaaaaebgpgodjjeacaaaajeacaaaaaaacpopp
                    daacaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaafaa
                    aeaaabaaaaaaaaaaabaaafaaabaaafaaaaaaaaaaacaabjaaabaaagaaaaaaaaaa
                    adaaaaaaaiaaahaaaaaaaaaaadaaamaaaeaaapaaaaaaaaaaaaaaaaaaaaacpopp
                    fbaaaaafbdaaapkaaaaaaadpaaaaiadpaaaaaaaaaaaaaaaabpaaaaacafaaaaia
                    aaaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjaaeaaaaae
                    aaaaadoaadaaoejaacaaoekaacaaookaaeaaaaaeaaaaamoaadaaeejaadaaeeka
                    adaaoekaaeaaaaaeabaaadoaadaaoejaaeaaoekaaeaaookaafaaaaadaaaaapia
                    aaaaffjaaiaaoekaaeaaaaaeaaaaapiaahaaoekaaaaaaajaaaaaoeiaaeaaaaae
                    aaaaapiaajaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaakaaoekaaaaappja
                    aaaaoeiaafaaaaadabaaabiaaaaaffiaafaaaakaafaaaaadabaaaiiaabaaaaia
                    bdaaaakaafaaaaadabaaafiaaaaapeiabdaaaakaacaaaaadacaaadoaabaakkia
                    abaaomiaaeaaaaaeabaaamoaaeaabejaabaabekaabaalekaafaaaaadabaaahia
                    aaaaffjabaaaoekaaeaaaaaeabaaahiaapaaoekaaaaaaajaabaaoeiaaeaaaaae
                    abaaahiabbaaoekaaaaakkjaabaaoeiaaeaaaaaeabaaahiabcaaoekaaaaappja
                    abaaoeiaacaaaaadabaaahiaabaaoeiaagaaoekbafaaaaadadaaahoaabaaoeia
                    agaappkaafaaaaadabaaabiaaaaaffjaamaakkkaaeaaaaaeabaaabiaalaakkka
                    aaaaaajaabaaaaiaaeaaaaaeabaaabiaanaakkkaaaaakkjaabaaaaiaaeaaaaae
                    abaaabiaaoaakkkaaaaappjaabaaaaiaabaaaaacabaaaiiaagaappkaacaaaaad
                    abaaaciaabaappibbdaaffkaafaaaaadadaaaioaabaaffiaabaaaaibaeaaaaae
                    aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
                    acaaamoaaaaaoeiappppaaaafdeieefcfaaeaaaaeaaaabaabeabaaaafjaaaaae
                    egiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
                    egiocaaaacaaaaaabkaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaafpaaaaad
                    pcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaa
                    ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
                    dccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
                    gfaaaaadpccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
                    fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
                    egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
                    pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
                    aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
                    aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
                    dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaagaaaaaa
                    ogikcaaaaaaaaaaaagaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
                    agiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaaahaaaaaadcaaaaaldccabaaa
                    acaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaa
                    aiaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaaaeaaaaaaagiecaaaaaaaaaaa
                    afaaaaaakgiocaaaaaaaaaaaafaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
                    aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
                    aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
                    adaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaa
                    mgaabaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
                    adaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaa
                    agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
                    adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
                    aaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
                    aaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaa
                    bjaaaaaadiaaaaaihccabaaaaeaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaa
                    bjaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaa
                    afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaa
                    aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
                    agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
                    ckiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaj
                    ccaabaaaaaaaaaaadkiacaiaebaaaaaaacaaaaaabjaaaaaaabeaaaaaaaaaiadp
                    diaaaaaiiccabaaaaeaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaa
                    doaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
                    apaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaalaaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaa
                    adaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaa
                    apaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
                    epepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
                    aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    adamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaamadaaaakeaaaaaa
                    acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaa
                    adaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
                    aaklklkl"
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
                    Vector 12 [unity_LightmapST]
                    Vector 13 [_MainTex_ST]
                    Vector 14 [_BumpMap_ST]
                    Vector 15 [_ResourceMap_ST]
                    "!!ARBvp1.0
                    PARAM c[16] = { { 0.5, 1 },
                    state.matrix.mvp,
                    program.local[5..15] };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    MOV R0.xyz, vertex.attrib[14];
                    MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
                    MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
                    MUL R3.xyz, R0, vertex.attrib[14].w;
                    MOV R1.xyz, c[9];
                    MOV R1.w, c[0].y;
                    DP4 R2.z, R1, c[7];
                    DP4 R2.x, R1, c[5];
                    DP4 R2.y, R1, c[6];
                    MAD R1.xyz, R2, c[11].w, -vertex.position;
                    DP4 R0.w, vertex.position, c[4];
                    DP4 R0.z, vertex.position, c[3];
                    DP4 R0.x, vertex.position, c[1];
                    DP4 R0.y, vertex.position, c[2];
                    MUL R2.xyz, R0.xyww, c[0].x;
                    MUL R2.y, R2, c[10].x;
                    DP3 result.texcoord[4].y, R1, R3;
                    ADD result.texcoord[2].xy, R2, R2.z;
                    DP3 result.texcoord[4].z, vertex.normal, R1;
                    DP3 result.texcoord[4].x, R1, vertex.attrib[14];
                    MOV result.position, R0;
                    MOV result.texcoord[2].zw, R0;
                    MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[14].xyxy, c[14];
                    MAD result.texcoord[0].xy, vertex.texcoord[0], c[13], c[13].zwzw;
                    MAD result.texcoord[1].xy, vertex.texcoord[0], c[15], c[15].zwzw;
                    MAD result.texcoord[3].xy, vertex.texcoord[1], c[12], c[12].zwzw;
                    END
# 26 instructions, 4 R-regs
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
                    Vector 12 [unity_LightmapST]
                    Vector 13 [_MainTex_ST]
                    Vector 14 [_BumpMap_ST]
                    Vector 15 [_ResourceMap_ST]
                    "vs_2_0
                    def c16, 0.50000000, 1.00000000, 0, 0
                    dcl_position0 v0
                    dcl_tangent0 v1
                    dcl_normal0 v2
                    dcl_texcoord0 v3
                    dcl_texcoord1 v4
                    mov r0.xyz, v1
                    mul r1.xyz, v2.zxyw, r0.yzxw
                    mov r0.xyz, v1
                    mad r0.xyz, v2.yzxw, r0.zxyw, -r1
                    mul r3.xyz, r0, v1.w
                    mov r1.xyz, c8
                    mov r1.w, c16.y
                    dp4 r2.z, r1, c6
                    dp4 r2.x, r1, c4
                    dp4 r2.y, r1, c5
                    mad r1.xyz, r2, c11.w, -v0
                    dp4 r0.w, v0, c3
                    dp4 r0.z, v0, c2
                    dp4 r0.x, v0, c0
                    dp4 r0.y, v0, c1
                    mul r2.xyz, r0.xyww, c16.x
                    mul r2.y, r2, c9.x
                    dp3 oT4.y, r1, r3
                    mad oT2.xy, r2.z, c10.zwzw, r2
                    dp3 oT4.z, v2, r1
                    dp3 oT4.x, r1, v1
                    mov oPos, r0
                    mov oT2.zw, r0
                    mad oT0.zw, v3.xyxy, c14.xyxy, c14
                    mad oT0.xy, v3, c13, c13.zwzw
                    mad oT1.xy, v3, c15, c15.zwzw
                    mad oT3.xy, v4, c12, c12.zwzw
                    "
                }
                SubProgram "d3d11 " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    Bind "tangent" TexCoord2
                    ConstBuffer "$Globals" 176
                    Vector 80 [unity_LightmapST]
                    Vector 96 [_MainTex_ST]
                    Vector 112 [_BumpMap_ST]
                    Vector 128 [_ResourceMap_ST]
                    ConstBuffer "UnityPerCamera" 128
                    Vector 64 [_WorldSpaceCameraPos] 3
                    Vector 80 [_ProjectionParams]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 256 [_World2Object]
                    Vector 320 [unity_Scale]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerCamera" 1
                    BindCB  "UnityPerDraw" 2
                    "vs_4_0
                    eefiecedmeffnbcfoengdbpeldnnojnklnoanhijabaaaaaanaafaaaaadaaaaaa
                    cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
                    abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
                    enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
                    aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
                    adaaaaaaacaaaaaaadamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    amadaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaa
                    aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
                    feeffiedepepfceeaaklklklfdeieefcbmaeaaaaeaaaabaaahabaaaafjaaaaae
                    egiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
                    egiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
                    abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
                    dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
                    abaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaagfaaaaad
                    pccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
                    pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
                    pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
                    aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
                    aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
                    adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
                    egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
                    aaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaadcaaaaalmccabaaaabaaaaaa
                    agbebaaaadaaaaaaagiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaaahaaaaaa
                    dcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaa
                    ogikcaaaaaaaaaaaaiaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaaaeaaaaaa
                    agiecaaaaaaaaaaaafaaaaaakgiocaaaaaaaaaaaafaaaaaadiaaaaaiccaabaaa
                    aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
                    abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
                    dgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaa
                    kgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaa
                    abaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaa
                    cgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
                    egacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaa
                    abaaaaaaaeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaa
                    egiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
                    dcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaa
                    aeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
                    egiccaaaacaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaa
                    pgipcaaaacaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaa
                    aeaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaaeaaaaaa
                    egbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaa
                    acaaaaaaegacbaaaabaaaaaadoaaaaab"
                }
                SubProgram "d3d11_9x " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
                    Bind "vertex" Vertex
                    Bind "color" Color
                    Bind "normal" Normal
                    Bind "texcoord" TexCoord0
                    Bind "texcoord1" TexCoord1
                    Bind "tangent" TexCoord2
                    ConstBuffer "$Globals" 176
                    Vector 80 [unity_LightmapST]
                    Vector 96 [_MainTex_ST]
                    Vector 112 [_BumpMap_ST]
                    Vector 128 [_ResourceMap_ST]
                    ConstBuffer "UnityPerCamera" 128
                    Vector 64 [_WorldSpaceCameraPos] 3
                    Vector 80 [_ProjectionParams]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    Matrix 256 [_World2Object]
                    Vector 320 [unity_Scale]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerCamera" 1
                    BindCB  "UnityPerDraw" 2
                    "vs_4_0_level_9_1
                    eefiecedhpbajoheddknabnplefiieonagnejglkabaaaaaahaaiaaaaaeaaaaaa
                    daaaaaaammacaaaapaagaaaaliahaaaaebgpgodjjeacaaaajeacaaaaaaacpopp
                    dmacaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaafaa
                    aeaaabaaaaaaaaaaabaaaeaaacaaafaaaaaaaaaaacaaaaaaaeaaahaaaaaaaaaa
                    acaabaaaafaaalaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafbaaaapkaaaaaaadp
                    aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabia
                    abaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjabpaaaaac
                    afaaaeiaaeaaapjaaeaaaaaeaaaaadoaadaaoejaacaaoekaacaaookaaeaaaaae
                    aaaaamoaadaaeejaadaaeekaadaaoekaaeaaaaaeabaaadoaadaaoejaaeaaoeka
                    aeaaookaafaaaaadaaaaapiaaaaaffjaaiaaoekaaeaaaaaeaaaaapiaahaaoeka
                    aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaajaaoekaaaaakkjaaaaaoeiaaeaaaaae
                    aaaaapiaakaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffiaagaaaaka
                    afaaaaadabaaaiiaabaaaaiabaaaaakaafaaaaadabaaafiaaaaapeiabaaaaaka
                    acaaaaadacaaadoaabaakkiaabaaomiaaeaaaaaeabaaamoaaeaabejaabaabeka
                    abaalekaabaaaaacabaaahiaafaaoekaafaaaaadacaaahiaabaaffiaamaaoeka
                    aeaaaaaeabaaaliaalaakekaabaaaaiaacaakeiaaeaaaaaeabaaahiaanaaoeka
                    abaakkiaabaapeiaacaaaaadabaaahiaabaaoeiaaoaaoekaaeaaaaaeabaaahia
                    abaaoeiaapaappkaaaaaoejbaiaaaaadadaaaboaabaaoejaabaaoeiaabaaaaac
                    acaaahiaabaaoejaafaaaaadadaaahiaacaamjiaacaancjaaeaaaaaeacaaahia
                    acaamjjaacaanciaadaaoeibafaaaaadacaaahiaacaaoeiaabaappjaaiaaaaad
                    adaaacoaacaaoeiaabaaoeiaaiaaaaadadaaaeoaacaaoejaabaaoeiaaeaaaaae
                    aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
                    acaaamoaaaaaoeiappppaaaafdeieefcbmaeaaaaeaaaabaaahabaaaafjaaaaae
                    egiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
                    egiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
                    abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
                    dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
                    abaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaagfaaaaad
                    pccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
                    pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
                    pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
                    aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
                    aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
                    adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
                    egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
                    aaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaadcaaaaalmccabaaaabaaaaaa
                    agbebaaaadaaaaaaagiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaaahaaaaaa
                    dcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaa
                    ogikcaaaaaaaaaaaaiaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaaaeaaaaaa
                    agiecaaaaaaaaaaaafaaaaaakgiocaaaaaaaaaaaafaaaaaadiaaaaaiccaabaaa
                    aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
                    abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
                    dgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaa
                    kgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaa
                    abaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaa
                    cgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
                    egacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaa
                    abaaaaaaaeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaa
                    egiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
                    dcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaa
                    aeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
                    egiccaaaacaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaa
                    pgipcaaaacaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaa
                    aeaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaaeaaaaaa
                    egbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaa
                    acaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
                    jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
                    aaaaaaaaadaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
                    acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
                    laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaa
                    aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
                    aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaa
                    agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
                    keaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaa
                    aaaaaaaaadaaaaaaacaaaaaaadamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
                    acaaaaaaamadaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
                    keaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfe
                    ejepeoaafeeffiedepepfceeaaklklkl"
                }
            }
            Program "fp" {
                SubProgram "opengl " {
                    Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
                    Vector 0 [_SpecColor]
                    Vector 1 [_Color]
                    Float 2 [_Opacity]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 2 [_ResourceMap] 2D 2
                    SetTexture 3 [_LightBuffer] 2D 3
                    "!!ARBfp1.0
                    PARAM c[3] = { program.local[0..2] };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    TXP R0, fragment.texcoord[2], texture[3], 2D;
                    TEX R1, fragment.texcoord[0], texture[0], 2D;
                    TEX R2, fragment.texcoord[1], texture[2], 2D;
                    LG2 R0.w, R0.w;
                    MUL R0.w, R1, -R0;
                    MOV R1.w, c[2].x;
                    MUL R1.w, R1, c[1];
                    MUL R1.xyz, R1, c[1];
                    LG2 R0.x, R0.x;
                    LG2 R0.z, R0.z;
                    LG2 R0.y, R0.y;
                    ADD R0.xyz, -R0, fragment.texcoord[3];
                    MUL R3.xyz, R0, c[0];
                    MUL R3.xyz, R3, R0.w;
                    MAD R0.xyz, R1, R0, R3;
                    MUL R1.xyz, R2, R2.w;
                    ADD result.color.xyz, R0, R1;
                    MAD result.color.w, R0, c[0], R1;
                    END
# 18 instructions, 4 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
                    Vector 0 [_SpecColor]
                    Vector 1 [_Color]
                    Float 2 [_Opacity]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 2 [_ResourceMap] 2D 2
                    SetTexture 3 [_LightBuffer] 2D 3
                    "ps_2_0
                    dcl_2d s0
                    dcl_2d s2
                    dcl_2d s3
                    dcl t0.xy
                    dcl t1.xy
                    dcl t2
                    dcl t3.xyz
                    texld r2, t1, s2
                    texldp r0, t2, s3
                    texld r1, t0, s0
                    log_pp r0.x, r0.x
                    log_pp r0.z, r0.z
                    log_pp r0.y, r0.y
                    add_pp r3.xyz, -r0, t3
                    log_pp r0.x, r0.w
                    mul_pp r0.x, r1.w, -r0
                    mul_pp r4.xyz, r3, c0
                    mul_pp r4.xyz, r4, r0.x
                    mul_pp r1.xyz, r1, c1
                    mad_pp r3.xyz, r1, r3, r4
                    mov r0.w, c1
                    mul r1.x, c2, r0.w
                    mad_pp r0.w, r0.x, c0, r1.x
                    mul r2.xyz, r2, r2.w
                    add_pp r0.xyz, r3, r2
                    mov_pp oC0, r0
                    "
                }
                SubProgram "d3d11 " {
                    Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_ResourceMap] 2D 1
                    SetTexture 2 [_LightBuffer] 2D 2
                    ConstBuffer "$Globals" 144
                    Vector 32 [_SpecColor]
                    Vector 48 [_Color]
                    Float 68 [_Opacity]
                    BindCB  "$Globals" 0
                    "ps_4_0
                    eefieceddcooefogeoagobhfdpafedmgfimamapmabaaaaaaiiadaaaaadaaaaaa
                    cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
                    aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    adadaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaaimaaaaaa
                    adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
                    feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
                    fdeieefciaacaaaaeaaaaaaakaaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaa
                    fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
                    acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
                    ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
                    gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaadhcbabaaa
                    aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaa
                    aaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaa
                    egaabaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaacpaaaaafpcaabaaa
                    aaaaaaaaegaobaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaiaebaaaaaa
                    aaaaaaaaegbcbaaaaeaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaaaaaaaaa
                    egiccaaaaaaaaaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaa
                    eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaia
                    ebaaaaaaaaaaaaaadkaabaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaa
                    acaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
                    aaaaaaaaegacbaaaabaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
                    dkiacaaaaaaaaaaaacaaaaaadcaaaaaliccabaaaaaaaaaaadkiacaaaaaaaaaaa
                    adaaaaaabkiacaaaaaaaaaaaaeaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaa
                    aaaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaaj
                    pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
                    dcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaaegacbaaa
                    aaaaaaaadoaaaaab"
                }
                SubProgram "d3d11_9x " {
                    Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_ResourceMap] 2D 1
                    SetTexture 2 [_LightBuffer] 2D 2
                    ConstBuffer "$Globals" 144
                    Vector 32 [_SpecColor]
                    Vector 48 [_Color]
                    Float 68 [_Opacity]
                    BindCB  "$Globals" 0
                    "ps_4_0_level_9_1
                    eefiecedlkollmmoekojajhehjfiediajalmghoeabaaaaaafmafaaaaaeaaaaaa
                    daaaaaaaaaacaaaaiiaeaaaaciafaaaaebgpgodjmiabaaaamiabaaaaaaacpppp
                    imabaaaadmaaaaaaabaadaaaaaaadmaaaaaadmaaadaaceaaaaaadmaaaaaaaaaa
                    abababaaacacacaaaaaaacaaadaaaaaaaaaaaaaaaaacppppbpaaaaacaaaaaaia
                    aaaaaplabpaaaaacaaaaaaiaabaaadlabpaaaaacaaaaaaiaacaaaplabpaaaaac
                    aaaaaaiaadaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
                    bpaaaaacaaaaaajaacaiapkaagaaaaacaaaaaiiaacaapplaafaaaaadaaaaadia
                    aaaappiaacaaoelaecaaaaadaaaacpiaaaaaoeiaacaioekaecaaaaadabaacpia
                    aaaaoelaaaaioekaecaaaaadacaaapiaabaaoelaabaioekaapaaaaacadaacbia
                    aaaaaaiaapaaaaacadaacciaaaaaffiaapaaaaacadaaceiaaaaakkiaapaaaaac
                    adaaciiaaaaappiaacaaaaadaaaachiaadaaoeibadaaoelaafaaaaadadaachia
                    aaaaoeiaaaaaoekaafaaaaadaaaaciiaabaappiaadaappibafaaaaadabaachia
                    abaaoeiaabaaoekaafaaaaadadaachiaaaaappiaadaaoeiaafaaaaadaaaaciia
                    aaaappiaaaaappkaabaaaaacabaaaiiaabaappkaaeaaaaaeaeaaciiaabaappia
                    acaaffkaaaaappiaaeaaaaaeaaaachiaabaaoeiaaaaaoeiaadaaoeiaaeaaaaae
                    aeaachiaacaaoeiaacaappiaaaaaoeiaabaaaaacaaaicpiaaeaaoeiappppaaaa
                    fdeieefciaacaaaaeaaaaaaakaaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaa
                    fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
                    acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
                    ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
                    gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaadhcbabaaa
                    aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaa
                    aaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaa
                    egaabaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaacpaaaaafpcaabaaa
                    aaaaaaaaegaobaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaiaebaaaaaa
                    aaaaaaaaegbcbaaaaeaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaaaaaaaaa
                    egiccaaaaaaaaaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaa
                    eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaia
                    ebaaaaaaaaaaaaaadkaabaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaa
                    acaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
                    aaaaaaaaegacbaaaabaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
                    dkiacaaaaaaaaaaaacaaaaaadcaaaaaliccabaaaaaaaaaaadkiacaaaaaaaaaaa
                    adaaaaaabkiacaaaaaaaaaaaaeaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaa
                    aaaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaaj
                    pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
                    dcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaaegacbaaa
                    aaaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaa
                    abaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
                    abaaaaaaapadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaa
                    imaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaaimaaaaaaadaaaaaa
                    aaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffied
                    epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
                    aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
                }
                SubProgram "opengl " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
                    Vector 0 [_SpecColor]
                    Vector 1 [_Color]
                    Float 2 [_Opacity]
                    Vector 3 [unity_LightmapFade]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 2 [_ResourceMap] 2D 2
                    SetTexture 3 [_LightBuffer] 2D 3
                    SetTexture 4 [unity_Lightmap] 2D 4
                    SetTexture 5 [unity_LightmapInd] 2D 5
                    "!!ARBfp1.0
                    PARAM c[5] = { program.local[0..3],
                    { 8 } };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    TEMP R4;
                    TXP R0, fragment.texcoord[2], texture[3], 2D;
                    TEX R2, fragment.texcoord[3], texture[4], 2D;
                    TEX R1, fragment.texcoord[3], texture[5], 2D;
                    TEX R3, fragment.texcoord[0], texture[0], 2D;
                    TEX R4, fragment.texcoord[1], texture[2], 2D;
                    MUL R2.xyz, R2.w, R2;
                    MUL R1.xyz, R1.w, R1;
                    MUL R1.xyz, R1, c[4].x;
                    DP4 R2.w, fragment.texcoord[4], fragment.texcoord[4];
                    RSQ R1.w, R2.w;
                    RCP R1.w, R1.w;
                    LG2 R0.w, R0.w;
                    MAD R2.xyz, R2, c[4].x, -R1;
                    MAD_SAT R1.w, R1, c[3].z, c[3];
                    MAD R1.xyz, R1.w, R2, R1;
                    MUL R0.w, R3, -R0;
                    MUL R2.xyz, R3, c[1];
                    LG2 R0.x, R0.x;
                    LG2 R0.y, R0.y;
                    LG2 R0.z, R0.z;
                    ADD R0.xyz, -R0, R1;
                    MUL R1.xyz, R0, c[0];
                    MUL R1.xyz, R1, R0.w;
                    MAD R0.xyz, R2, R0, R1;
                    MOV R1.x, c[2];
                    MUL R2.xyz, R4, R4.w;
                    MUL R1.x, R1, c[1].w;
                    ADD result.color.xyz, R0, R2;
                    MAD result.color.w, R0, c[0], R1.x;
                    END
# 29 instructions, 5 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
                    Vector 0 [_SpecColor]
                    Vector 1 [_Color]
                    Float 2 [_Opacity]
                    Vector 3 [unity_LightmapFade]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 2 [_ResourceMap] 2D 2
                    SetTexture 3 [_LightBuffer] 2D 3
                    SetTexture 4 [unity_Lightmap] 2D 4
                    SetTexture 5 [unity_LightmapInd] 2D 5
                    "ps_2_0
                    dcl_2d s0
                    dcl_2d s2
                    dcl_2d s3
                    dcl_2d s4
                    dcl_2d s5
                    def c4, 8.00000000, 0, 0, 0
                    dcl t0.xy
                    dcl t1.xy
                    dcl t2
                    dcl t3.xy
                    dcl t4
                    texld r1, t1, s2
                    texld r2, t0, s0
                    texldp r3, t2, s3
                    texld r0, t3, s4
                    texld r4, t3, s5
                    mul_pp r5.xyz, r0.w, r0
                    mul_pp r4.xyz, r4.w, r4
                    mul_pp r4.xyz, r4, c4.x
                    dp4 r0.x, t4, t4
                    rsq r0.x, r0.x
                    rcp r0.x, r0.x
                    mad_pp r5.xyz, r5, c4.x, -r4
                    mad_sat r0.x, r0, c3.z, c3.w
                    mad_pp r0.xyz, r0.x, r5, r4
                    mul_pp r2.xyz, r2, c1
                    mov r0.w, c1
                    log_pp r3.x, r3.x
                    log_pp r3.y, r3.y
                    log_pp r3.z, r3.z
                    add_pp r3.xyz, -r3, r0
                    log_pp r0.x, r3.w
                    mul_pp r0.x, r2.w, -r0
                    mul_pp r4.xyz, r3, c0
                    mul_pp r4.xyz, r4, r0.x
                    mad_pp r3.xyz, r2, r3, r4
                    mul r2.x, c2, r0.w
                    mad_pp r0.w, r0.x, c0, r2.x
                    mul r1.xyz, r1, r1.w
                    add_pp r0.xyz, r3, r1
                    mov_pp oC0, r0
                    "
                }
                SubProgram "d3d11 " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_ResourceMap] 2D 1
                    SetTexture 2 [_LightBuffer] 2D 2
                    SetTexture 3 [unity_Lightmap] 2D 3
                    SetTexture 4 [unity_LightmapInd] 2D 4
                    ConstBuffer "$Globals" 176
                    Vector 32 [_SpecColor]
                    Vector 48 [_Color]
                    Float 68 [_Opacity]
                    Vector 144 [unity_LightmapFade]
                    BindCB  "$Globals" 0
                    "ps_4_0
                    eefiecedeenfonahfdelkicoiaefbcgdihhjcjogabaaaaaaciafaaaaadaaaaaa
                    cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
                    aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    adadaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaakeaaaaaa
                    acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaakeaaaaaaaeaaaaaaaaaaaaaa
                    adaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
                    aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcaiaeaaaa
                    eaaaaaaaacabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
                    aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
                    aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaa
                    ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
                    ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaa
                    ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaad
                    mcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaa
                    gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabbaaaaahbcaabaaaaaaaaaaa
                    egbobaaaaeaaaaaaegbobaaaaeaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaa
                    aaaaaaaadccaaaalbcaabaaaaaaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaa
                    ajaaaaaadkiacaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
                    acaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadiaaaaahccaabaaaaaaaaaaa
                    dkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahocaabaaaaaaaaaaaagajbaaa
                    abaaaaaafgafbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaa
                    eghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
                    abaaaaaaabeaaaaaaaaaaaebdcaaaaakhcaabaaaabaaaaaapgapbaaaabaaaaaa
                    egacbaaaabaaaaaajgahbaiaebaaaaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaa
                    agaabaaaaaaaaaaaegacbaaaabaaaaaajgahbaaaaaaaaaaaaoaaaaahdcaabaaa
                    abaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaa
                    egaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaacpaaaaafpcaabaaa
                    abaaaaaaegaobaaaabaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
                    egacbaiaebaaaaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaaaaaaaaa
                    egiccaaaaaaaaaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaa
                    eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaia
                    ebaaaaaaabaaaaaadkaabaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaa
                    acaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
                    aaaaaaaaegacbaaaabaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
                    dkiacaaaaaaaaaaaacaaaaaadcaaaaaliccabaaaaaaaaaaadkiacaaaaaaaaaaa
                    adaaaaaabkiacaaaaaaaaaaaaeaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaa
                    aaaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaaj
                    pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
                    dcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaaegacbaaa
                    aaaaaaaadoaaaaab"
                }
                SubProgram "d3d11_9x " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_ResourceMap] 2D 1
                    SetTexture 2 [_LightBuffer] 2D 2
                    SetTexture 3 [unity_Lightmap] 2D 3
                    SetTexture 4 [unity_LightmapInd] 2D 4
                    ConstBuffer "$Globals" 176
                    Vector 32 [_SpecColor]
                    Vector 48 [_Color]
                    Float 68 [_Opacity]
                    Vector 144 [unity_LightmapFade]
                    BindCB  "$Globals" 0
                    "ps_4_0_level_9_1
                    eefiecedjfadjcojacnjcpeminddadbdojbinholabaaaaaaaaaiaaaaaeaaaaaa
                    daaaaaaaaeadaaaabeahaaaammahaaaaebgpgodjmmacaaaammacaaaaaaacpppp
                    hmacaaaafaaaaaaaacaadiaaaaaafaaaaaaafaaaafaaceaaaaaafaaaaaaaaaaa
                    abababaaacacacaaadadadaaaeaeaeaaaaaaacaaadaaaaaaaaaaaaaaaaaaajaa
                    abaaadaaaaaaaaaaaaacppppfbaaaaafaeaaapkaaaaaaaebaaaaaaaaaaaaaaaa
                    aaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaac
                    aaaaaaiaacaaaplabpaaaaacaaaaaaiaadaaaplabpaaaaacaaaaaajaaaaiapka
                    bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaaja
                    adaiapkabpaaaaacaaaaaajaaeaiapkaajaaaaadaaaaaiiaadaaoelaadaaoela
                    ahaaaaacaaaaabiaaaaappiaagaaaaacaaaaabiaaaaaaaiaaeaaaaaeaaaadbia
                    aaaaaaiaadaakkkaadaappkaabaaaaacabaaadiaabaabllaagaaaaacaaaaacia
                    acaapplaafaaaaadacaaadiaaaaaffiaacaaoelaecaaaaadadaacpiaabaaoeia
                    aeaioekaecaaaaadabaacpiaabaaoeiaadaioekaecaaaaadacaacpiaacaaoeia
                    acaioekaecaaaaadaeaacpiaaaaaoelaaaaioekaecaaaaadafaaapiaabaaoela
                    abaioekaafaaaaadadaaciiaadaappiaaeaaaakaafaaaaadaaaacoiaadaablia
                    adaappiaafaaaaadabaaciiaabaappiaaeaaaakaaeaaaaaeabaachiaabaappia
                    abaaoeiaaaaablibaeaaaaaeaaaachiaaaaaaaiaabaaoeiaaaaabliaapaaaaac
                    abaacbiaacaaaaiaapaaaaacabaacciaacaaffiaapaaaaacabaaceiaacaakkia
                    apaaaaacaaaaciiaacaappiaacaaaaadaaaachiaaaaaoeiaabaaoeibafaaaaad
                    abaachiaaaaaoeiaaaaaoekaafaaaaadaaaaciiaaeaappiaaaaappibafaaaaad
                    acaachiaaeaaoeiaabaaoekaafaaaaadabaachiaaaaappiaabaaoeiaafaaaaad
                    aaaaciiaaaaappiaaaaappkaabaaaaacabaaaiiaabaappkaaeaaaaaeadaaciia
                    abaappiaacaaffkaaaaappiaaeaaaaaeaaaachiaacaaoeiaaaaaoeiaabaaoeia
                    aeaaaaaeadaachiaafaaoeiaafaappiaaaaaoeiaabaaaaacaaaicpiaadaaoeia
                    ppppaaaafdeieefcaiaeaaaaeaaaaaaaacabaaaafjaaaaaeegiocaaaaaaaaaaa
                    akaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
                    aagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaa
                    fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
                    fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
                    fibiaaaeaahabaaaaeaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
                    dcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaa
                    gcbaaaadpcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
                    bbaaaaahbcaabaaaaaaaaaaaegbobaaaaeaaaaaaegbobaaaaeaaaaaaelaaaaaf
                    bcaabaaaaaaaaaaaakaabaaaaaaaaaaadccaaaalbcaabaaaaaaaaaaaakaabaaa
                    aaaaaaaackiacaaaaaaaaaaaajaaaaaadkiacaaaaaaaaaaaajaaaaaaefaaaaaj
                    pcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaa
                    diaaaaahccaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaah
                    ocaabaaaaaaaaaaaagajbaaaabaaaaaafgafbaaaaaaaaaaaefaaaaajpcaabaaa
                    abaaaaaaogbkbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaah
                    icaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdcaaaaakhcaabaaa
                    abaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaajgahbaiaebaaaaaaaaaaaaaa
                    dcaaaaajhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaajgahbaaa
                    aaaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaa
                    efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
                    acaaaaaacpaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaaaaaaaaaihcaabaaa
                    aaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaaihcaabaaa
                    abaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaacaaaaaaefaaaaajpcaabaaa
                    acaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaai
                    icaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaadkaabaaaacaaaaaadiaaaaai
                    hcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaah
                    hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaiicaabaaa
                    aaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaacaaaaaadcaaaaaliccabaaa
                    aaaaaaaadkiacaaaaaaaaaaaadaaaaaabkiacaaaaaaaaaaaaeaaaaaadkaabaaa
                    aaaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaa
                    egacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaa
                    abaaaaaaaagabaaaabaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaa
                    pgapbaaaabaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheolaaaaaaaagaaaaaa
                    aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapadaaaakeaaaaaaabaaaaaaaaaaaaaa
                    adaaaaaaacaaaaaaadadaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    amamaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaakeaaaaaa
                    aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
                    feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
                    "
                }
                SubProgram "opengl " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
                    Vector 0 [_SpecColor]
                    Vector 1 [_Color]
                    Float 2 [_Shininess]
                    Float 3 [_Opacity]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_ResourceMap] 2D 2
                    SetTexture 3 [_LightBuffer] 2D 3
                    SetTexture 4 [unity_Lightmap] 2D 4
                    SetTexture 5 [unity_LightmapInd] 2D 5
                    "!!ARBfp1.0
                    PARAM c[8] = { program.local[0..3],
                    { 2, 1, 8, 0 },
                    { -0.40824828, -0.70710677, 0.57735026, 128 },
                    { -0.40824831, 0.70710677, 0.57735026 },
                    { 0.81649655, 0, 0.57735026 } };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    TEMP R4;
                    TEMP R5;
                    TEMP R6;
                    TXP R2, fragment.texcoord[2], texture[3], 2D;
                    TEX R1, fragment.texcoord[0], texture[0], 2D;
                    TEX R3, fragment.texcoord[3], texture[4], 2D;
                    TEX R4, fragment.texcoord[3], texture[5], 2D;
                    TEX R5.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
                    TEX R0, fragment.texcoord[1], texture[2], 2D;
                    MAD R5.xy, R5.wyzw, c[4].x, -c[4].y;
                    MUL R4.xyz, R4.w, R4;
                    MUL R4.xyz, R4, c[4].z;
                    MUL R6.xyz, R4.y, c[6];
                    MAD R6.xyz, R4.x, c[7], R6;
                    MAD R6.xyz, R4.z, c[5], R6;
                    DP3 R4.w, R6, R6;
                    RSQ R4.w, R4.w;
                    MUL R6.xyz, R4.w, R6;
                    MUL R5.zw, R5.xyxy, R5.xyxy;
                    ADD_SAT R5.z, R5, R5.w;
                    DP3 R4.w, fragment.texcoord[4], fragment.texcoord[4];
                    RSQ R4.w, R4.w;
                    MAD R6.xyz, R4.w, fragment.texcoord[4], R6;
                    DP3 R4.w, R6, R6;
                    ADD R5.w, -R5.z, c[4].y;
                    RSQ R5.z, R4.w;
                    MUL R6.xyz, R5.z, R6;
                    RSQ R4.w, R5.w;
                    RCP R5.z, R4.w;
                    DP3 R4.w, R5, R6;
                    MUL R3.xyz, R3.w, R3;
                    MAX R4.w, R4, c[4];
                    DP3_SAT R6.z, R5, c[5];
                    DP3_SAT R6.x, R5, c[7];
                    DP3_SAT R6.y, R5, c[6];
                    DP3 R4.x, R6, R4;
                    MOV R4.y, c[5].w;
                    MUL R3.w, R4.y, c[2].x;
                    MUL R3.xyz, R3, R4.x;
                    MUL R3.xyz, R3, c[4].z;
                    POW R3.w, R4.w, R3.w;
                    LG2 R2.x, R2.x;
                    LG2 R2.y, R2.y;
                    LG2 R2.z, R2.z;
                    LG2 R2.w, R2.w;
                    ADD R2, -R2, R3;
                    MUL R2.w, R1, R2;
                    MUL R3.xyz, R2, c[0];
                    MUL R3.xyz, R3, R2.w;
                    MUL R1.xyz, R1, c[1];
                    MAD R1.xyz, R1, R2, R3;
                    MUL R2.xyz, R0, R0.w;
                    MOV R1.w, c[3].x;
                    MUL R0.x, R1.w, c[1].w;
                    ADD result.color.xyz, R1, R2;
                    MAD result.color.w, R2, c[0], R0.x;
                    END
# 53 instructions, 7 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
                    Vector 0 [_SpecColor]
                    Vector 1 [_Color]
                    Float 2 [_Shininess]
                    Float 3 [_Opacity]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_ResourceMap] 2D 2
                    SetTexture 3 [_LightBuffer] 2D 3
                    SetTexture 4 [unity_Lightmap] 2D 4
                    SetTexture 5 [unity_LightmapInd] 2D 5
                    "ps_2_0
                    dcl_2d s0
                    dcl_2d s1
                    dcl_2d s2
                    dcl_2d s3
                    dcl_2d s4
                    dcl_2d s5
                    def c4, 2.00000000, -1.00000000, 1.00000000, 8.00000000
                    def c5, -0.40824828, -0.70710677, 0.57735026, 0.00000000
                    def c6, -0.40824831, 0.70710677, 0.57735026, 128.00000000
                    def c7, 0.81649655, 0.00000000, 0.57735026, 0
                    dcl t0
                    dcl t1.xy
                    dcl t2
                    dcl t3.xy
                    dcl t4.xyz
                    texld r1, t1, s2
                    texld r2, t0, s0
                    texldp r3, t2, s3
                    texld r4, t3, s4
                    texld r5, t3, s5
                    mul_pp r5.xyz, r5.w, r5
                    mul_pp r5.xyz, r5, c4.w
                    mul r6.xyz, r5.y, c6
                    mad r6.xyz, r5.x, c7, r6
                    mad r6.xyz, r5.z, c5, r6
                    mul_pp r4.xyz, r4.w, r4
                    log_pp r3.x, r3.x
                    mul_pp r2.xyz, r2, c1
                    mov r0.y, t0.w
                    mov r0.x, t0.z
                    log_pp r3.y, r3.y
                    log_pp r3.z, r3.z
                    log_pp r3.w, r3.w
                    mul r1.xyz, r1, r1.w
                    texld r0, r0, s1
                    dp3 r0.x, r6, r6
                    rsq r0.x, r0.x
                    mul r6.xyz, r0.x, r6
                    mov r0.x, r0.w
                    mad_pp r8.xy, r0, c4.x, c4.y
                    dp3_pp r0.x, t4, t4
                    rsq_pp r0.x, r0.x
                    mad_pp r0.xyz, r0.x, t4, r6
                    mul_pp r7.xy, r8, r8
                    add_pp_sat r6.x, r7, r7.y
                    dp3_pp r7.x, r0, r0
                    rsq_pp r7.x, r7.x
                    add_pp r6.x, -r6, c4.z
                    rsq_pp r6.x, r6.x
                    rcp_pp r8.z, r6.x
                    mul_pp r0.xyz, r7.x, r0
                    dp3_pp r0.x, r8, r0
                    mov_pp r6.x, c2
                    max_pp r0.x, r0, c5.w
                    mul_pp r6.x, c6.w, r6
                    pow r7.x, r0.x, r6.x
                    dp3_pp_sat r0.z, r8, c5
                    dp3_pp_sat r0.y, r8, c6
                    dp3_pp_sat r0.x, r8, c7
                    dp3_pp r0.x, r0, r5
                    mul_pp r0.xyz, r4, r0.x
                    mov r0.w, r7.x
                    mul_pp r0.xyz, r0, c4.w
                    add_pp r0, -r3, r0
                    mul_pp r3.x, r2.w, r0.w
                    mul_pp r4.xyz, r0, c0
                    mul_pp r4.xyz, r4, r3.x
                    mad_pp r0.xyz, r2, r0, r4
                    mov r0.w, c1
                    mul r2.x, c3, r0.w
                    mad_pp r0.w, r3.x, c0, r2.x
                    add_pp r0.xyz, r0, r1
                    mov_pp oC0, r0
                    "
                }
                SubProgram "d3d11 " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_ResourceMap] 2D 2
                    SetTexture 3 [_LightBuffer] 2D 3
                    SetTexture 4 [unity_Lightmap] 2D 4
                    SetTexture 5 [unity_LightmapInd] 2D 5
                    ConstBuffer "$Globals" 176
                    Vector 32 [_SpecColor]
                    Vector 48 [_Color]
                    Float 64 [_Shininess]
                    Float 68 [_Opacity]
                    BindCB  "$Globals" 0
                    "ps_4_0
                    eefiecedagndodkkdakhjdfecoobdfdpmgglnedkabaaaaaaeaaiaaaaadaaaaaa
                    cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
                    aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    adadaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaakeaaaaaa
                    acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaakeaaaaaaaeaaaaaaaaaaaaaa
                    adaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
                    aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefccaahaaaa
                    eaaaaaaamiabaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaa
                    aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
                    aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaa
                    fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
                    fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
                    fibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaa
                    gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaa
                    acaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaad
                    pccabaaaaaaaaaaagiaaaaacafaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaa
                    adaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
                    eghobaaaadaaaaaaaagabaaaadaaaaaacpaaaaafpcaabaaaaaaaaaaaegaobaaa
                    aaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaa
                    eeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
                    agaabaaaabaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaa
                    acaaaaaaeghobaaaafaaaaaaaagabaaaafaaaaaadiaaaaahicaabaaaabaaaaaa
                    dkaabaaaacaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaacaaaaaaegacbaaa
                    acaaaaaapgapbaaaabaaaaaadiaaaaakhcaabaaaadaaaaaafgafbaaaacaaaaaa
                    aceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaadcaaaaamhcaabaaaadaaaaaa
                    agaabaaaacaaaaaaaceaaaaaolaffbdpaaaaaaaadkmnbddpaaaaaaaaegacbaaa
                    adaaaaaadcaaaaamhcaabaaaadaaaaaakgakbaaaacaaaaaaaceaaaaaolafnblo
                    pdaedflpdkmnbddpaaaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaabaaaaaa
                    egacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
                    abaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaadaaaaaapgapbaaaabaaaaaa
                    egacbaaaabaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
                    abaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaa
                    abaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaa
                    ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
                    adaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
                    aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaabaaaaaa
                    egaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaaabaaaaaadkaabaaa
                    abaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaa
                    abaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaaabaaaaaa
                    baaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaadeaaaaah
                    bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaa
                    abaaaaaaakaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaaakiacaaaaaaaaaaa
                    aeaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
                    bkaabaaaabaaaaaabjaaaaaficaabaaaabaaaaaaakaabaaaabaaaaaaapcaaaak
                    bcaabaaaaeaaaaaaaceaaaaaolaffbdpdkmnbddpaaaaaaaaaaaaaaaaigaabaaa
                    adaaaaaabacaaaakccaabaaaaeaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddp
                    aaaaaaaaegacbaaaadaaaaaabacaaaakecaabaaaaeaaaaaaaceaaaaaolafnblo
                    pdaedflpdkmnbddpaaaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaaacaaaaaa
                    egacbaaaaeaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaogbkbaaa
                    acaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadiaaaaahccaabaaaacaaaaaa
                    dkaabaaaadaaaaaaabeaaaaaaaaaaaebdiaaaaahocaabaaaacaaaaaaagajbaaa
                    adaaaaaafgafbaaaacaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaacaaaaaa
                    jgahbaaaacaaaaaaaaaaaaaipcaabaaaaaaaaaaaegaobaiaebaaaaaaaaaaaaaa
                    egaobaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaa
                    aaaaaaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaa
                    aaaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
                    dkaabaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaa
                    aaaaaaaaadaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
                    abaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaa
                    acaaaaaadcaaaaaliccabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaabkiacaaa
                    aaaaaaaaaeaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
                    acaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
                    egbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaajhccabaaa
                    aaaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaaegacbaaaaaaaaaaadoaaaaab
                    "
                }
                SubProgram "d3d11_9x " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_ResourceMap] 2D 2
                    SetTexture 3 [_LightBuffer] 2D 3
                    SetTexture 4 [unity_Lightmap] 2D 4
                    SetTexture 5 [unity_LightmapInd] 2D 5
                    ConstBuffer "$Globals" 176
                    Vector 32 [_SpecColor]
                    Vector 48 [_Color]
                    Float 64 [_Shininess]
                    Float 68 [_Opacity]
                    BindCB  "$Globals" 0
                    "ps_4_0_level_9_1
                    eefiecedlijbickpbjdhcibchgfhgnjekgcmbmpmabaaaaaaliamaaaaaeaaaaaa
                    daaaaaaakeaeaaaammalaaaaieamaaaaebgpgodjgmaeaaaagmaeaaaaaaacpppp
                    ceaeaaaaeiaaaaaaabaadmaaaaaaeiaaaaaaeiaaagaaceaaaaaaeiaaaaaaaaaa
                    abababaaacacacaaadadadaaaeaeaeaaafafafaaaaaaacaaadaaaaaaaaaaaaaa
                    aaacppppfbaaaaafadaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaaf
                    aeaaapkaomafnblopdaedfdpdkmnbddpaaaaaaedfbaaaaafafaaapkaolafnblo
                    pdaedflpdkmnbddpaaaaaaaafbaaaaafagaaapkaaaaaaaebdkmnbddpaaaaaaaa
                    olaffbdpbpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaac
                    aaaaaaiaacaaaplabpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaajaaaaiapka
                    bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaaja
                    adaiapkabpaaaaacaaaaaajaaeaiapkabpaaaaacaaaaaajaafaiapkaabaaaaac
                    aaaaadiaabaabllaabaaaaacabaaabiaaaaakklaabaaaaacabaaaciaaaaappla
                    agaaaaacaaaaaeiaacaapplaafaaaaadacaaadiaaaaakkiaacaaoelaecaaaaad
                    adaacpiaaaaaoeiaaeaioekaecaaaaadaaaacpiaaaaaoeiaafaioekaecaaaaad
                    abaacpiaabaaoeiaabaioekaecaaaaadacaacpiaacaaoeiaadaioekaecaaaaad
                    aeaacpiaaaaaoelaaaaioekaecaaaaadafaaapiaabaaoelaacaioekaafaaaaad
                    adaaciiaadaappiaagaaaakaafaaaaadadaachiaadaaoeiaadaappiaafaaaaad
                    aaaaciiaaaaappiaagaaaakaafaaaaadaaaachiaaaaaoeiaaaaappiaaeaaaaae
                    agaacbiaabaappiaadaaaakaadaaffkaaeaaaaaeagaacciaabaaffiaadaaaaka
                    adaaffkafkaaaaaeaaaadiiaagaaoeiaagaaoeiaadaakkkaacaaaaadaaaaciia
                    aaaappibadaappkaahaaaaacaaaaciiaaaaappiaagaaaaacagaaceiaaaaappia
                    aiaaaaadabaadbiaagaablkaagaaoeiaaiaaaaadabaadciaaeaaoekaagaaoeia
                    aiaaaaadabaadeiaafaaoekaagaaoeiaaiaaaaadaaaaciiaabaaoeiaaaaaoeia
                    afaaaaadabaachiaaaaappiaadaaoeiaafaaaaadadaaahiaaaaaffiaaeaaoeka
                    aeaaaaaeadaaahiaaaaaaaiaagaablkaadaaoeiaaeaaaaaeaaaaahiaaaaakkia
                    afaaoekaadaaoeiaaiaaaaadaaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiia
                    aaaappiaceaaaaacadaachiaadaaoelaaeaaaaaeaaaachiaaaaaoeiaaaaappia
                    adaaoeiaceaaaaacadaachiaaaaaoeiaaiaaaaadaaaacbiaagaaoeiaadaaoeia
                    alaaaaadadaaabiaaaaaaaiaadaakkkaabaaaaacaaaaaiiaaeaappkaafaaaaad
                    aaaaabiaaaaappiaacaaaakacaaaaaadabaaciiaadaaaaiaaaaaaaiaapaaaaac
                    aaaacbiaacaaaaiaapaaaaacaaaacciaacaaffiaapaaaaacaaaaceiaacaakkia
                    apaaaaacaaaaciiaacaappiaacaaaaadaaaacpiaabaaoeiaaaaaoeibafaaaaad
                    abaachiaaaaaoeiaaaaaoekaafaaaaadaaaaciiaaeaappiaaaaappiaafaaaaad
                    acaachiaaeaaoeiaabaaoekaafaaaaadabaachiaaaaappiaabaaoeiaafaaaaad
                    aaaaciiaaaaappiaaaaappkaabaaaaacabaaaiiaabaappkaaeaaaaaeadaaciia
                    abaappiaacaaffkaaaaappiaaeaaaaaeaaaachiaacaaoeiaaaaaoeiaabaaoeia
                    aeaaaaaeadaachiaafaaoeiaafaappiaaaaaoeiaabaaaaacaaaicpiaadaaoeia
                    ppppaaaafdeieefccaahaaaaeaaaaaaamiabaaaafjaaaaaeegiocaaaaaaaaaaa
                    afaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
                    aagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaa
                    fkaaaaadaagabaaaafaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
                    aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaae
                    aahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaae
                    aahabaaaafaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
                    acaaaaaagcbaaaadmcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaad
                    hcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaaoaaaaah
                    dcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaa
                    aaaaaaaaegaabaaaaaaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaacpaaaaaf
                    pcaabaaaaaaaaaaaegaobaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaa
                    aeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
                    diaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaaaeaaaaaaefaaaaaj
                    pcaabaaaacaaaaaaogbkbaaaacaaaaaaeghobaaaafaaaaaaaagabaaaafaaaaaa
                    diaaaaahicaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaebdiaaaaah
                    hcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaaabaaaaaadiaaaaakhcaabaaa
                    adaaaaaafgafbaaaacaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaa
                    dcaaaaamhcaabaaaadaaaaaaagaabaaaacaaaaaaaceaaaaaolaffbdpaaaaaaaa
                    dkmnbddpaaaaaaaaegacbaaaadaaaaaadcaaaaamhcaabaaaadaaaaaakgakbaaa
                    acaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegacbaaaadaaaaaa
                    baaaaaahicaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaf
                    icaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
                    adaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaabaaaaaa
                    egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
                    abaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
                    efaaaaajpcaabaaaadaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
                    abaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaea
                    aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
                    apaaaaahicaabaaaabaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaah
                    icaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaa
                    abaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
                    adaaaaaadkaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaa
                    egacbaaaabaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
                    aaaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaiccaabaaa
                    abaaaaaaakiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaa
                    abaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaabjaaaaaficaabaaaabaaaaaa
                    akaabaaaabaaaaaaapcaaaakbcaabaaaaeaaaaaaaceaaaaaolaffbdpdkmnbddp
                    aaaaaaaaaaaaaaaaigaabaaaadaaaaaabacaaaakccaabaaaaeaaaaaaaceaaaaa
                    omafnblopdaedfdpdkmnbddpaaaaaaaaegacbaaaadaaaaaabacaaaakecaabaaa
                    aeaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegacbaaaadaaaaaa
                    baaaaaahbcaabaaaacaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaaefaaaaaj
                    pcaabaaaadaaaaaaogbkbaaaacaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaa
                    diaaaaahccaabaaaacaaaaaadkaabaaaadaaaaaaabeaaaaaaaaaaaebdiaaaaah
                    ocaabaaaacaaaaaaagajbaaaadaaaaaafgafbaaaacaaaaaadiaaaaahhcaabaaa
                    abaaaaaaagaabaaaacaaaaaajgahbaaaacaaaaaaaaaaaaaipcaabaaaaaaaaaaa
                    egaobaiaebaaaaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
                    egacbaaaaaaaaaaaegiccaaaaaaaaaaaacaaaaaaefaaaaajpcaabaaaacaaaaaa
                    egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaa
                    aaaaaaaadkaabaaaaaaaaaaadkaabaaaacaaaaaadiaaaaaihcaabaaaacaaaaaa
                    egacbaaaacaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaahhcaabaaaabaaaaaa
                    pgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaa
                    aaaaaaaadkiacaaaaaaaaaaaacaaaaaadcaaaaaliccabaaaaaaaaaaadkiacaaa
                    aaaaaaaaadaaaaaabkiacaaaaaaaaaaaaeaaaaaadkaabaaaaaaaaaaadcaaaaaj
                    hcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
                    efaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
                    acaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaa
                    egacbaaaaaaaaaaadoaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
                    aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    adadaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaakeaaaaaa
                    acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaakeaaaaaaaeaaaaaaaaaaaaaa
                    adaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
                    aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
                }
                SubProgram "opengl " {
                    Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
                    Vector 0 [_SpecColor]
                    Vector 1 [_Color]
                    Float 2 [_Opacity]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 2 [_ResourceMap] 2D 2
                    SetTexture 3 [_LightBuffer] 2D 3
                    "!!ARBfp1.0
                    PARAM c[3] = { program.local[0..2] };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    TEX R1, fragment.texcoord[0], texture[0], 2D;
                    TXP R0, fragment.texcoord[2], texture[3], 2D;
                    TEX R2, fragment.texcoord[1], texture[2], 2D;
                    MUL R0.w, R1, R0;
                    ADD R0.xyz, R0, fragment.texcoord[3];
                    MUL R3.xyz, R0, c[0];
                    MOV R1.w, c[2].x;
                    MUL R1.w, R1, c[1];
                    MUL R1.xyz, R1, c[1];
                    MUL R3.xyz, R3, R0.w;
                    MAD R0.xyz, R1, R0, R3;
                    MUL R1.xyz, R2, R2.w;
                    ADD result.color.xyz, R0, R1;
                    MAD result.color.w, R0, c[0], R1;
                    END
# 14 instructions, 4 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
                    Vector 0 [_SpecColor]
                    Vector 1 [_Color]
                    Float 2 [_Opacity]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 2 [_ResourceMap] 2D 2
                    SetTexture 3 [_LightBuffer] 2D 3
                    "ps_2_0
                    dcl_2d s0
                    dcl_2d s2
                    dcl_2d s3
                    dcl t0.xy
                    dcl t1.xy
                    dcl t2
                    dcl t3.xyz
                    texld r2, t1, s2
                    texldp r0, t2, s3
                    texld r1, t0, s0
                    add_pp r3.xyz, r0, t3
                    mul_pp r0.x, r1.w, r0.w
                    mul_pp r4.xyz, r3, c0
                    mul_pp r4.xyz, r4, r0.x
                    mul_pp r1.xyz, r1, c1
                    mad_pp r3.xyz, r1, r3, r4
                    mov r0.w, c1
                    mul r1.x, c2, r0.w
                    mad_pp r0.w, r0.x, c0, r1.x
                    mul r2.xyz, r2, r2.w
                    add_pp r0.xyz, r3, r2
                    mov_pp oC0, r0
                    "
                }
                SubProgram "d3d11 " {
                    Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_ResourceMap] 2D 1
                    SetTexture 2 [_LightBuffer] 2D 2
                    ConstBuffer "$Globals" 144
                    Vector 32 [_SpecColor]
                    Vector 48 [_Color]
                    Float 68 [_Opacity]
                    BindCB  "$Globals" 0
                    "ps_4_0
                    eefiecedbacjkkkmgfnedmmgejjflkpidmeaegldabaaaaaagmadaaaaadaaaaaa
                    cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
                    aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    adadaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaaimaaaaaa
                    adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
                    feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
                    fdeieefcgeacaaaaeaaaaaaajjaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaa
                    fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
                    acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
                    ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
                    gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaadhcbabaaa
                    aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaa
                    aaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaa
                    egaabaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaahhcaabaaa
                    aaaaaaaaegacbaaaaaaaaaaaegbcbaaaaeaaaaaadiaaaaaihcaabaaaabaaaaaa
                    egacbaaaaaaaaaaaegiccaaaaaaaaaaaacaaaaaaefaaaaajpcaabaaaacaaaaaa
                    egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaa
                    aaaaaaaadkaabaaaaaaaaaaadkaabaaaacaaaaaadiaaaaaihcaabaaaacaaaaaa
                    egacbaaaacaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaahhcaabaaaabaaaaaa
                    pgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaa
                    aaaaaaaadkiacaaaaaaaaaaaacaaaaaadcaaaaaliccabaaaaaaaaaaadkiacaaa
                    aaaaaaaaadaaaaaabkiacaaaaaaaaaaaaeaaaaaadkaabaaaaaaaaaaadcaaaaaj
                    hcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
                    efaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
                    abaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaa
                    egacbaaaaaaaaaaadoaaaaab"
                }
                SubProgram "d3d11_9x " {
                    Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_ResourceMap] 2D 1
                    SetTexture 2 [_LightBuffer] 2D 2
                    ConstBuffer "$Globals" 144
                    Vector 32 [_SpecColor]
                    Vector 48 [_Color]
                    Float 68 [_Opacity]
                    BindCB  "$Globals" 0
                    "ps_4_0_level_9_1
                    eefiecedheeinfnomjjjbdbfjjbmjckmdjgoeaneabaaaaaabaafaaaaaeaaaaaa
                    daaaaaaanaabaaaadmaeaaaanmaeaaaaebgpgodjjiabaaaajiabaaaaaaacpppp
                    fmabaaaadmaaaaaaabaadaaaaaaadmaaaaaadmaaadaaceaaaaaadmaaaaaaaaaa
                    abababaaacacacaaaaaaacaaadaaaaaaaaaaaaaaaaacppppbpaaaaacaaaaaaia
                    aaaaaplabpaaaaacaaaaaaiaabaaadlabpaaaaacaaaaaaiaacaaaplabpaaaaac
                    aaaaaaiaadaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
                    bpaaaaacaaaaaajaacaiapkaagaaaaacaaaaaiiaacaapplaafaaaaadaaaaadia
                    aaaappiaacaaoelaecaaaaadaaaacpiaaaaaoeiaacaioekaecaaaaadabaacpia
                    aaaaoelaaaaioekaecaaaaadacaaapiaabaaoelaabaioekaacaaaaadaaaachia
                    aaaaoeiaadaaoelaafaaaaadadaachiaaaaaoeiaaaaaoekaafaaaaadaaaaciia
                    aaaappiaabaappiaafaaaaadabaachiaabaaoeiaabaaoekaafaaaaadadaachia
                    aaaappiaadaaoeiaafaaaaadaaaaciiaaaaappiaaaaappkaabaaaaacabaaaiia
                    abaappkaaeaaaaaeaeaaciiaabaappiaacaaffkaaaaappiaaeaaaaaeaaaachia
                    abaaoeiaaaaaoeiaadaaoeiaaeaaaaaeaeaachiaacaaoeiaacaappiaaaaaoeia
                    abaaaaacaaaicpiaaeaaoeiappppaaaafdeieefcgeacaaaaeaaaaaaajjaaaaaa
                    fjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
                    aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
                    ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
                    ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaad
                    lcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaa
                    giaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaa
                    adaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaacaaaaaa
                    aagabaaaacaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaa
                    aeaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
                    acaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
                    aagabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
                    acaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaa
                    adaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
                    diaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaacaaaaaa
                    dcaaaaaliccabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaabkiacaaaaaaaaaaa
                    aeaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaacaaaaaa
                    egacbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
                    acaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaajhccabaaaaaaaaaaa
                    egacbaaaabaaaaaapgapbaaaabaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheo
                    jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
                    apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapadaaaaimaaaaaa
                    abaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaaimaaaaaaacaaaaaaaaaaaaaa
                    adaaaaaaadaaaaaaapalaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
                    ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
                    cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
                    apaaaaaafdfgfpfegbhcghgfheaaklkl"
                }
                SubProgram "opengl " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
                    Vector 0 [_SpecColor]
                    Vector 1 [_Color]
                    Float 2 [_Opacity]
                    Vector 3 [unity_LightmapFade]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 2 [_ResourceMap] 2D 2
                    SetTexture 3 [_LightBuffer] 2D 3
                    SetTexture 4 [unity_Lightmap] 2D 4
                    SetTexture 5 [unity_LightmapInd] 2D 5
                    "!!ARBfp1.0
                    PARAM c[5] = { program.local[0..3],
                    { 8 } };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    TEMP R4;
                    TEX R2, fragment.texcoord[3], texture[4], 2D;
                    TEX R1, fragment.texcoord[3], texture[5], 2D;
                    TEX R3, fragment.texcoord[0], texture[0], 2D;
                    TXP R0, fragment.texcoord[2], texture[3], 2D;
                    TEX R4, fragment.texcoord[1], texture[2], 2D;
                    MUL R2.xyz, R2.w, R2;
                    MUL R1.xyz, R1.w, R1;
                    MUL R1.xyz, R1, c[4].x;
                    DP4 R2.w, fragment.texcoord[4], fragment.texcoord[4];
                    RSQ R1.w, R2.w;
                    RCP R1.w, R1.w;
                    MAD R2.xyz, R2, c[4].x, -R1;
                    MAD_SAT R1.w, R1, c[3].z, c[3];
                    MAD R1.xyz, R1.w, R2, R1;
                    ADD R0.xyz, R0, R1;
                    MUL R0.w, R3, R0;
                    MUL R1.xyz, R0, c[0];
                    MUL R1.xyz, R1, R0.w;
                    MUL R2.xyz, R3, c[1];
                    MAD R0.xyz, R2, R0, R1;
                    MOV R1.x, c[2];
                    MUL R2.xyz, R4, R4.w;
                    MUL R1.x, R1, c[1].w;
                    ADD result.color.xyz, R0, R2;
                    MAD result.color.w, R0, c[0], R1.x;
                    END
# 25 instructions, 5 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
                    Vector 0 [_SpecColor]
                    Vector 1 [_Color]
                    Float 2 [_Opacity]
                    Vector 3 [unity_LightmapFade]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 2 [_ResourceMap] 2D 2
                    SetTexture 3 [_LightBuffer] 2D 3
                    SetTexture 4 [unity_Lightmap] 2D 4
                    SetTexture 5 [unity_LightmapInd] 2D 5
                    "ps_2_0
                    dcl_2d s0
                    dcl_2d s2
                    dcl_2d s3
                    dcl_2d s4
                    dcl_2d s5
                    def c4, 8.00000000, 0, 0, 0
                    dcl t0.xy
                    dcl t1.xy
                    dcl t2
                    dcl t3.xy
                    dcl t4
                    texld r1, t1, s2
                    texldp r3, t2, s3
                    texld r2, t0, s0
                    texld r0, t3, s4
                    texld r4, t3, s5
                    mul_pp r5.xyz, r0.w, r0
                    dp4 r0.x, t4, t4
                    mul_pp r4.xyz, r4.w, r4
                    mul_pp r4.xyz, r4, c4.x
                    rsq r0.x, r0.x
                    rcp r0.x, r0.x
                    mad_pp r5.xyz, r5, c4.x, -r4
                    mad_sat r0.x, r0, c3.z, c3.w
                    mad_pp r0.xyz, r0.x, r5, r4
                    add_pp r3.xyz, r3, r0
                    mul_pp r0.x, r2.w, r3.w
                    mul_pp r4.xyz, r3, c0
                    mul_pp r4.xyz, r4, r0.x
                    mul_pp r2.xyz, r2, c1
                    mad_pp r3.xyz, r2, r3, r4
                    mov r0.w, c1
                    mul r2.x, c2, r0.w
                    mad_pp r0.w, r0.x, c0, r2.x
                    mul r1.xyz, r1, r1.w
                    add_pp r0.xyz, r3, r1
                    mov_pp oC0, r0
                    "
                }
                SubProgram "d3d11 " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_ResourceMap] 2D 1
                    SetTexture 2 [_LightBuffer] 2D 2
                    SetTexture 3 [unity_Lightmap] 2D 3
                    SetTexture 4 [unity_LightmapInd] 2D 4
                    ConstBuffer "$Globals" 176
                    Vector 32 [_SpecColor]
                    Vector 48 [_Color]
                    Float 68 [_Opacity]
                    Vector 144 [unity_LightmapFade]
                    BindCB  "$Globals" 0
                    "ps_4_0
                    eefiecedckkoanolnfpnolldehbdofedojicnbkjabaaaaaaamafaaaaadaaaaaa
                    cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
                    aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    adadaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaakeaaaaaa
                    acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaakeaaaaaaaeaaaaaaaaaaaaaa
                    adaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
                    aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcomadaaaa
                    eaaaaaaaplaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
                    aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
                    aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaa
                    ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
                    ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaa
                    ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaad
                    mcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaa
                    gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabbaaaaahbcaabaaaaaaaaaaa
                    egbobaaaaeaaaaaaegbobaaaaeaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaa
                    aaaaaaaadccaaaalbcaabaaaaaaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaa
                    ajaaaaaadkiacaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
                    acaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadiaaaaahccaabaaaaaaaaaaa
                    dkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahocaabaaaaaaaaaaaagajbaaa
                    abaaaaaafgafbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaa
                    eghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
                    abaaaaaaabeaaaaaaaaaaaebdcaaaaakhcaabaaaabaaaaaapgapbaaaabaaaaaa
                    egacbaaaabaaaaaajgahbaiaebaaaaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaa
                    agaabaaaaaaaaaaaegacbaaaabaaaaaajgahbaaaaaaaaaaaaoaaaaahdcaabaaa
                    abaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaa
                    egaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaahhcaabaaa
                    aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
                    egacbaaaaaaaaaaaegiccaaaaaaaaaaaacaaaaaaefaaaaajpcaabaaaacaaaaaa
                    egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaa
                    aaaaaaaadkaabaaaabaaaaaadkaabaaaacaaaaaadiaaaaaihcaabaaaacaaaaaa
                    egacbaaaacaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaahhcaabaaaabaaaaaa
                    pgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaa
                    aaaaaaaadkiacaaaaaaaaaaaacaaaaaadcaaaaaliccabaaaaaaaaaaadkiacaaa
                    aaaaaaaaadaaaaaabkiacaaaaaaaaaaaaeaaaaaadkaabaaaaaaaaaaadcaaaaaj
                    hcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
                    efaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
                    abaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaa
                    egacbaaaaaaaaaaadoaaaaab"
                }
                SubProgram "d3d11_9x " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_ResourceMap] 2D 1
                    SetTexture 2 [_LightBuffer] 2D 2
                    SetTexture 3 [unity_Lightmap] 2D 3
                    SetTexture 4 [unity_LightmapInd] 2D 4
                    ConstBuffer "$Globals" 176
                    Vector 32 [_SpecColor]
                    Vector 48 [_Color]
                    Float 68 [_Opacity]
                    Vector 144 [unity_LightmapFade]
                    BindCB  "$Globals" 0
                    "ps_4_0_level_9_1
                    eefiecednfoilgdbknengeejhifgkcljjkbakeaaabaaaaaaleahaaaaaeaaaaaa
                    daaaaaaaneacaaaamiagaaaaiaahaaaaebgpgodjjmacaaaajmacaaaaaaacpppp
                    emacaaaafaaaaaaaacaadiaaaaaafaaaaaaafaaaafaaceaaaaaafaaaaaaaaaaa
                    abababaaacacacaaadadadaaaeaeaeaaaaaaacaaadaaaaaaaaaaaaaaaaaaajaa
                    abaaadaaaaaaaaaaaaacppppfbaaaaafaeaaapkaaaaaaaebaaaaaaaaaaaaaaaa
                    aaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaac
                    aaaaaaiaacaaaplabpaaaaacaaaaaaiaadaaaplabpaaaaacaaaaaajaaaaiapka
                    bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaaja
                    adaiapkabpaaaaacaaaaaajaaeaiapkaajaaaaadaaaaaiiaadaaoelaadaaoela
                    ahaaaaacaaaaabiaaaaappiaagaaaaacaaaaabiaaaaaaaiaaeaaaaaeaaaadbia
                    aaaaaaiaadaakkkaadaappkaabaaaaacabaaadiaabaabllaagaaaaacaaaaacia
                    acaapplaafaaaaadacaaadiaaaaaffiaacaaoelaecaaaaadadaacpiaabaaoeia
                    aeaioekaecaaaaadabaacpiaabaaoeiaadaioekaecaaaaadacaacpiaacaaoeia
                    acaioekaecaaaaadaeaacpiaaaaaoelaaaaioekaecaaaaadafaaapiaabaaoela
                    abaioekaafaaaaadadaaciiaadaappiaaeaaaakaafaaaaadaaaacoiaadaablia
                    adaappiaafaaaaadabaaciiaabaappiaaeaaaakaaeaaaaaeabaachiaabaappia
                    abaaoeiaaaaablibaeaaaaaeaaaachiaaaaaaaiaabaaoeiaaaaabliaacaaaaad
                    aaaachiaaaaaoeiaacaaoeiaafaaaaadabaachiaaaaaoeiaaaaaoekaafaaaaad
                    aaaaciiaacaappiaaeaappiaafaaaaadacaachiaaeaaoeiaabaaoekaafaaaaad
                    abaachiaaaaappiaabaaoeiaafaaaaadaaaaciiaaaaappiaaaaappkaabaaaaac
                    abaaaiiaabaappkaaeaaaaaeadaaciiaabaappiaacaaffkaaaaappiaaeaaaaae
                    aaaachiaacaaoeiaaaaaoeiaabaaoeiaaeaaaaaeadaachiaafaaoeiaafaappia
                    aaaaoeiaabaaaaacaaaicpiaadaaoeiappppaaaafdeieefcomadaaaaeaaaaaaa
                    plaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaaaaaaaaaa
                    fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaa
                    adaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
                    fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
                    fibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaa
                    gcbaaaaddcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaa
                    acaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagfaaaaad
                    pccabaaaaaaaaaaagiaaaaacadaaaaaabbaaaaahbcaabaaaaaaaaaaaegbobaaa
                    aeaaaaaaegbobaaaaeaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
                    dccaaaalbcaabaaaaaaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaajaaaaaa
                    dkiacaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaa
                    eghobaaaaeaaaaaaaagabaaaaeaaaaaadiaaaaahccaabaaaaaaaaaaadkaabaaa
                    abaaaaaaabeaaaaaaaaaaaebdiaaaaahocaabaaaaaaaaaaaagajbaaaabaaaaaa
                    fgafbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaa
                    adaaaaaaaagabaaaadaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
                    abeaaaaaaaaaaaebdcaaaaakhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaa
                    abaaaaaajgahbaiaebaaaaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaagaabaaa
                    aaaaaaaaegacbaaaabaaaaaajgahbaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaa
                    egbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
                    abaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaahhcaabaaaaaaaaaaa
                    egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
                    aaaaaaaaegiccaaaaaaaaaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
                    abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
                    dkaabaaaabaaaaaadkaabaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaa
                    acaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
                    aaaaaaaaegacbaaaabaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
                    dkiacaaaaaaaaaaaacaaaaaadcaaaaaliccabaaaaaaaaaaadkiacaaaaaaaaaaa
                    adaaaaaabkiacaaaaaaaaaaaaeaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaa
                    aaaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaaj
                    pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
                    dcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaaegacbaaa
                    aaaaaaaadoaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
                    abaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
                    abaaaaaaapadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaa
                    keaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaakeaaaaaaacaaaaaa
                    aaaaaaaaadaaaaaaadaaaaaaapalaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
                    aeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
                    epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
                    aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
                }
                SubProgram "opengl " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
                    Vector 0 [_SpecColor]
                    Vector 1 [_Color]
                    Float 2 [_Shininess]
                    Float 3 [_Opacity]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_ResourceMap] 2D 2
                    SetTexture 3 [_LightBuffer] 2D 3
                    SetTexture 4 [unity_Lightmap] 2D 4
                    SetTexture 5 [unity_LightmapInd] 2D 5
                    "!!ARBfp1.0
                    PARAM c[8] = { program.local[0..3],
                    { 2, 1, 8, 0 },
                    { -0.40824828, -0.70710677, 0.57735026, 128 },
                    { -0.40824831, 0.70710677, 0.57735026 },
                    { 0.81649655, 0, 0.57735026 } };
                    TEMP R0;
                    TEMP R1;
                    TEMP R2;
                    TEMP R3;
                    TEMP R4;
                    TEMP R5;
                    TEMP R6;
                    TEX R1, fragment.texcoord[0], texture[0], 2D;
                    TEX R3, fragment.texcoord[3], texture[4], 2D;
                    TEX R4, fragment.texcoord[3], texture[5], 2D;
                    TEX R5.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
                    TEX R0, fragment.texcoord[1], texture[2], 2D;
                    TXP R2, fragment.texcoord[2], texture[3], 2D;
                    MAD R5.xy, R5.wyzw, c[4].x, -c[4].y;
                    MUL R4.xyz, R4.w, R4;
                    MUL R4.xyz, R4, c[4].z;
                    MUL R6.xyz, R4.y, c[6];
                    MAD R6.xyz, R4.x, c[7], R6;
                    MAD R6.xyz, R4.z, c[5], R6;
                    DP3 R4.w, R6, R6;
                    RSQ R4.w, R4.w;
                    MUL R6.xyz, R4.w, R6;
                    MUL R5.zw, R5.xyxy, R5.xyxy;
                    ADD_SAT R5.z, R5, R5.w;
                    DP3 R4.w, fragment.texcoord[4], fragment.texcoord[4];
                    RSQ R4.w, R4.w;
                    MAD R6.xyz, R4.w, fragment.texcoord[4], R6;
                    DP3 R4.w, R6, R6;
                    ADD R5.w, -R5.z, c[4].y;
                    RSQ R5.z, R4.w;
                    MUL R6.xyz, R5.z, R6;
                    RSQ R4.w, R5.w;
                    RCP R5.z, R4.w;
                    DP3 R4.w, R5, R6;
                    MUL R3.xyz, R3.w, R3;
                    MAX R4.w, R4, c[4];
                    DP3_SAT R6.z, R5, c[5];
                    DP3_SAT R6.x, R5, c[7];
                    DP3_SAT R6.y, R5, c[6];
                    DP3 R4.x, R6, R4;
                    MOV R4.y, c[5].w;
                    MUL R3.w, R4.y, c[2].x;
                    MUL R3.xyz, R3, R4.x;
                    MUL R3.xyz, R3, c[4].z;
                    POW R3.w, R4.w, R3.w;
                    ADD R2, R2, R3;
                    MUL R2.w, R1, R2;
                    MUL R3.xyz, R2, c[0];
                    MUL R3.xyz, R3, R2.w;
                    MUL R1.xyz, R1, c[1];
                    MAD R1.xyz, R1, R2, R3;
                    MUL R2.xyz, R0, R0.w;
                    MOV R1.w, c[3].x;
                    MUL R0.x, R1.w, c[1].w;
                    ADD result.color.xyz, R1, R2;
                    MAD result.color.w, R2, c[0], R0.x;
                    END
# 49 instructions, 7 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
                    Vector 0 [_SpecColor]
                    Vector 1 [_Color]
                    Float 2 [_Shininess]
                    Float 3 [_Opacity]
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_ResourceMap] 2D 2
                    SetTexture 3 [_LightBuffer] 2D 3
                    SetTexture 4 [unity_Lightmap] 2D 4
                    SetTexture 5 [unity_LightmapInd] 2D 5
                    "ps_2_0
                    dcl_2d s0
                    dcl_2d s1
                    dcl_2d s2
                    dcl_2d s3
                    dcl_2d s4
                    dcl_2d s5
                    def c4, 2.00000000, -1.00000000, 1.00000000, 8.00000000
                    def c5, -0.40824828, -0.70710677, 0.57735026, 0.00000000
                    def c6, -0.40824831, 0.70710677, 0.57735026, 128.00000000
                    def c7, 0.81649655, 0.00000000, 0.57735026, 0
                    dcl t0
                    dcl t1.xy
                    dcl t2
                    dcl t3.xy
                    dcl t4.xyz
                    texld r1, t1, s2
                    texld r2, t0, s0
                    texldp r3, t2, s3
                    texld r4, t3, s4
                    texld r5, t3, s5
                    mul_pp r5.xyz, r5.w, r5
                    mul_pp r5.xyz, r5, c4.w
                    mul r6.xyz, r5.y, c6
                    mad r6.xyz, r5.x, c7, r6
                    mad r6.xyz, r5.z, c5, r6
                    mul_pp r4.xyz, r4.w, r4
                    mul_pp r2.xyz, r2, c1
                    mov r0.y, t0.w
                    mov r0.x, t0.z
                    mul r1.xyz, r1, r1.w
                    texld r0, r0, s1
                    dp3 r0.x, r6, r6
                    rsq r0.x, r0.x
                    mul r6.xyz, r0.x, r6
                    mov r0.x, r0.w
                    mad_pp r8.xy, r0, c4.x, c4.y
                    dp3_pp r0.x, t4, t4
                    rsq_pp r0.x, r0.x
                    mad_pp r0.xyz, r0.x, t4, r6
                    mul_pp r7.xy, r8, r8
                    add_pp_sat r6.x, r7, r7.y
                    dp3_pp r7.x, r0, r0
                    rsq_pp r7.x, r7.x
                    add_pp r6.x, -r6, c4.z
                    rsq_pp r6.x, r6.x
                    rcp_pp r8.z, r6.x
                    mul_pp r0.xyz, r7.x, r0
                    dp3_pp r0.x, r8, r0
                    mov_pp r6.x, c2
                    max_pp r0.x, r0, c5.w
                    mul_pp r6.x, c6.w, r6
                    pow r7.x, r0.x, r6.x
                    dp3_pp_sat r0.z, r8, c5
                    dp3_pp_sat r0.y, r8, c6
                    dp3_pp_sat r0.x, r8, c7
                    dp3_pp r0.x, r0, r5
                    mul_pp r0.xyz, r4, r0.x
                    mov r0.w, r7.x
                    mul_pp r0.xyz, r0, c4.w
                    add_pp r0, r3, r0
                    mul_pp r3.x, r2.w, r0.w
                    mul_pp r4.xyz, r0, c0
                    mul_pp r4.xyz, r4, r3.x
                    mad_pp r0.xyz, r2, r0, r4
                    mov r0.w, c1
                    mul r2.x, c3, r0.w
                    mad_pp r0.w, r3.x, c0, r2.x
                    add_pp r0.xyz, r0, r1
                    mov_pp oC0, r0
                    "
                }
                SubProgram "d3d11 " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_ResourceMap] 2D 2
                    SetTexture 3 [_LightBuffer] 2D 3
                    SetTexture 4 [unity_Lightmap] 2D 4
                    SetTexture 5 [unity_LightmapInd] 2D 5
                    ConstBuffer "$Globals" 176
                    Vector 32 [_SpecColor]
                    Vector 48 [_Color]
                    Float 64 [_Shininess]
                    Float 68 [_Opacity]
                    BindCB  "$Globals" 0
                    "ps_4_0
                    eefiecedlbbehjpmhpphnmnpndidflpbinpbnfoiabaaaaaaciaiaaaaadaaaaaa
                    cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
                    aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
                    adadaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaakeaaaaaa
                    acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaakeaaaaaaaeaaaaaaaaaaaaaa
                    adaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
                    aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcaiahaaaa
                    eaaaaaaamcabaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaa
                    aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
                    aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaa
                    fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
                    fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
                    fibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaa
                    gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaa
                    acaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaad
                    pccabaaaaaaaaaaagiaaaaacafaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaa
                    aeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
                    diaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaaaeaaaaaaefaaaaaj
                    pcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaafaaaaaaaagabaaaafaaaaaa
                    diaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaah
                    hcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaadiaaaaakhcaabaaa
                    acaaaaaafgafbaaaabaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaa
                    dcaaaaamhcaabaaaacaaaaaaagaabaaaabaaaaaaaceaaaaaolaffbdpaaaaaaaa
                    dkmnbddpaaaaaaaaegacbaaaacaaaaaadcaaaaamhcaabaaaacaaaaaakgakbaaa
                    abaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegacbaaaacaaaaaa
                    baaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaf
                    icaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
                    acaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
                    egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
                    aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
                    efaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
                    abaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaea
                    aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
                    apaaaaahicaabaaaaaaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaah
                    icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaa
                    aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
                    acaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaa
                    egacbaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
                    aaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiccaabaaa
                    aaaaaaaaakiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaa
                    aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabjaaaaaficaabaaaaaaaaaaa
                    akaabaaaaaaaaaaaaoaaaaahdcaabaaaadaaaaaaegbabaaaadaaaaaapgbpbaaa
                    adaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaadaaaaaa
                    aagabaaaadaaaaaaapcaaaakbcaabaaaaeaaaaaaaceaaaaaolaffbdpdkmnbddp
                    aaaaaaaaaaaaaaaaigaabaaaacaaaaaabacaaaakccaabaaaaeaaaaaaaceaaaaa
                    omafnblopdaedfdpdkmnbddpaaaaaaaaegacbaaaacaaaaaabacaaaakecaabaaa
                    aeaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegacbaaaacaaaaaa
                    baaaaaahbcaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaaefaaaaaj
                    pcaabaaaacaaaaaaogbkbaaaacaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaa
                    diaaaaahccaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaebdiaaaaah
                    ocaabaaaabaaaaaaagajbaaaacaaaaaafgafbaaaabaaaaaadiaaaaahhcaabaaa
                    aaaaaaaaagaabaaaabaaaaaajgahbaaaabaaaaaaaaaaaaahpcaabaaaaaaaaaaa
                    egaobaaaaaaaaaaaegaobaaaadaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
                    aaaaaaaaegiccaaaaaaaaaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
                    abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
                    dkaabaaaaaaaaaaadkaabaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaa
                    acaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
                    aaaaaaaaegacbaaaabaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
                    dkiacaaaaaaaaaaaacaaaaaadcaaaaaliccabaaaaaaaaaaadkiacaaaaaaaaaaa
                    adaaaaaabkiacaaaaaaaaaaaaeaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaa
                    aaaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaaj
                    pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
                    dcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaaegacbaaa
                    aaaaaaaadoaaaaab"
                }
                SubProgram "d3d11_9x " {
                    Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
                    SetTexture 0 [_MainTex] 2D 0
                    SetTexture 1 [_BumpMap] 2D 1
                    SetTexture 2 [_ResourceMap] 2D 2
                    SetTexture 3 [_LightBuffer] 2D 3
                    SetTexture 4 [unity_Lightmap] 2D 4
                    SetTexture 5 [unity_LightmapInd] 2D 5
                    ConstBuffer "$Globals" 176
                    Vector 32 [_SpecColor]
                    Vector 48 [_Color]
                    Float 64 [_Shininess]
                    Float 68 [_Opacity]
                    BindCB  "$Globals" 0
                    "ps_4_0_level_9_1
                    eefiecedkdpdgdilocieokabehflfclcbjgdjomoabaaaaaahaamaaaaaeaaaaaa
                    daaaaaaaheaeaaaaiealaaaadmamaaaaebgpgodjdmaeaaaadmaeaaaaaaacpppp
                    peadaaaaeiaaaaaaabaadmaaaaaaeiaaaaaaeiaaagaaceaaaaaaeiaaaaaaaaaa
                    abababaaacacacaaadadadaaaeaeaeaaafafafaaaaaaacaaadaaaaaaaaaaaaaa
                    aaacppppfbaaaaafadaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaaf
                    aeaaapkaomafnblopdaedfdpdkmnbddpaaaaaaedfbaaaaafafaaapkaolafnblo
                    pdaedflpdkmnbddpaaaaaaaafbaaaaafagaaapkaaaaaaaebdkmnbddpaaaaaaaa
                    olaffbdpbpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaac
                    aaaaaaiaacaaaplabpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaajaaaaiapka
                    bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaaja
                    adaiapkabpaaaaacaaaaaajaaeaiapkabpaaaaacaaaaaajaafaiapkaagaaaaac
                    aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaabaaaaacabaaadia
                    abaabllaabaaaaacacaaabiaaaaakklaabaaaaacacaaaciaaaaapplaecaaaaad
                    aaaacpiaaaaaoeiaadaioekaecaaaaadadaacpiaabaaoeiaaeaioekaecaaaaad
                    abaacpiaabaaoeiaafaioekaecaaaaadacaacpiaacaaoeiaabaioekaecaaaaad
                    aeaacpiaaaaaoelaaaaioekaecaaaaadafaaapiaabaaoelaacaioekaafaaaaad
                    adaaciiaadaappiaagaaaakaafaaaaadadaachiaadaaoeiaadaappiaafaaaaad
                    abaaciiaabaappiaagaaaakaafaaaaadabaachiaabaaoeiaabaappiaaeaaaaae
                    agaacbiaacaappiaadaaaakaadaaffkaaeaaaaaeagaacciaacaaffiaadaaaaka
                    adaaffkafkaaaaaeabaadiiaagaaoeiaagaaoeiaadaakkkaacaaaaadabaaciia
                    abaappibadaappkaahaaaaacabaaciiaabaappiaagaaaaacagaaceiaabaappia
                    aiaaaaadacaadbiaagaablkaagaaoeiaaiaaaaadacaadciaaeaaoekaagaaoeia
                    aiaaaaadacaadeiaafaaoekaagaaoeiaaiaaaaadabaaciiaacaaoeiaabaaoeia
                    afaaaaadacaachiaabaappiaadaaoeiaafaaaaadadaaahiaabaaffiaaeaaoeka
                    aeaaaaaeadaaahiaabaaaaiaagaablkaadaaoeiaaeaaaaaeabaaahiaabaakkia
                    afaaoekaadaaoeiaaiaaaaadabaaaiiaabaaoeiaabaaoeiaahaaaaacabaaaiia
                    abaappiaceaaaaacadaachiaadaaoelaaeaaaaaeabaachiaabaaoeiaabaappia
                    adaaoeiaceaaaaacadaachiaabaaoeiaaiaaaaadabaacbiaagaaoeiaadaaoeia
                    alaaaaadadaaabiaabaaaaiaadaakkkaabaaaaacabaaaiiaaeaappkaafaaaaad
                    abaaabiaabaappiaacaaaakacaaaaaadacaaciiaadaaaaiaabaaaaiaacaaaaad
                    aaaacpiaaaaaoeiaacaaoeiaafaaaaadabaachiaaaaaoeiaaaaaoekaafaaaaad
                    aaaaciiaaeaappiaaaaappiaafaaaaadacaachiaaeaaoeiaabaaoekaafaaaaad
                    abaachiaaaaappiaabaaoeiaafaaaaadaaaaciiaaaaappiaaaaappkaabaaaaac
                    abaaaiiaabaappkaaeaaaaaeadaaciiaabaappiaacaaffkaaaaappiaaeaaaaae
                    aaaachiaacaaoeiaaaaaoeiaabaaoeiaaeaaaaaeadaachiaafaaoeiaafaappia
                    aaaaoeiaabaaaaacaaaicpiaadaaoeiappppaaaafdeieefcaiahaaaaeaaaaaaa
                    mcabaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaa
                    fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaa
                    adaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafibiaaae
                    aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
                    aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaae
                    aahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaagcbaaaad
                    pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
                    gcbaaaadlcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaa
                    aaaaaaaagiaaaaacafaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaaeaaaaaa
                    egbcbaaaaeaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
                    hcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaa
                    abaaaaaaogbkbaaaacaaaaaaeghobaaaafaaaaaaaagabaaaafaaaaaadiaaaaah
                    icaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaa
                    abaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaadiaaaaakhcaabaaaacaaaaaa
                    fgafbaaaabaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaadcaaaaam
                    hcaabaaaacaaaaaaagaabaaaabaaaaaaaceaaaaaolaffbdpaaaaaaaadkmnbddp
                    aaaaaaaaegacbaaaacaaaaaadcaaaaamhcaabaaaacaaaaaakgakbaaaabaaaaaa
                    aceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegacbaaaacaaaaaabaaaaaah
                    icaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaa
                    aaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaacaaaaaa
                    pgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
                    aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
                    diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaaj
                    pcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
                    dcaaaaapdcaabaaaacaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaea
                    aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaah
                    icaabaaaaaaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaahicaabaaa
                    aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaa
                    dkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaa
                    dkaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
                    aaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
                    cpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaa
                    akiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaaaaaaaaa
                    akaabaaaaaaaaaaabkaabaaaaaaaaaaabjaaaaaficaabaaaaaaaaaaaakaabaaa
                    aaaaaaaaaoaaaaahdcaabaaaadaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaa
                    efaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaadaaaaaaaagabaaa
                    adaaaaaaapcaaaakbcaabaaaaeaaaaaaaceaaaaaolaffbdpdkmnbddpaaaaaaaa
                    aaaaaaaaigaabaaaacaaaaaabacaaaakccaabaaaaeaaaaaaaceaaaaaomafnblo
                    pdaedfdpdkmnbddpaaaaaaaaegacbaaaacaaaaaabacaaaakecaabaaaaeaaaaaa
                    aceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegacbaaaacaaaaaabaaaaaah
                    bcaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaa
                    acaaaaaaogbkbaaaacaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadiaaaaah
                    ccaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaebdiaaaaahocaabaaa
                    abaaaaaaagajbaaaacaaaaaafgafbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaa
                    agaabaaaabaaaaaajgahbaaaabaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaa
                    aaaaaaaaegaobaaaadaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaaaaaaaaa
                    egiccaaaaaaaaaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaa
                    eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
                    aaaaaaaadkaabaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaa
                    egiccaaaaaaaaaaaadaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
                    egacbaaaabaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaa
                    aaaaaaaaacaaaaaadcaaaaaliccabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaa
                    bkiacaaaaaaaaaaaaeaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaa
                    egacbaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaa
                    abaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaaj
                    hccabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaaegacbaaaaaaaaaaa
                    doaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
                    adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
                    apapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaakeaaaaaa
                    adaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaakeaaaaaaacaaaaaaaaaaaaaa
                    adaaaaaaadaaaaaaapalaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
                    ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
                    cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
                    apaaaaaafdfgfpfegbhcghgfheaaklkl"
                }
            }
        }
    }
    Fallback "Specular"
}
