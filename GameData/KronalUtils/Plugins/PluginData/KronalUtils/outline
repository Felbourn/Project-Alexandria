Shader "Outlined Diffuse" 
{ 
   Properties 
   { 
      _Color ("Main Color", Color) = (.5,.5,.5,1) 
      _OutlineColor ("Outline Color", Color) = (0,1,0,1) 
      _Outline ("Outline width", Range (0.002, 0.03)) = 0.01 
      _MainTex ("Base (RGB)", 2D) = "white" { } 
      //Not needed 
      //_ToonShade ("ToonShader Cubemap(RGB)", CUBE) = "" { Texgen CubeNormal } 
   } 

   SubShader 
   { 
      Tags { "RenderType"="Opaque" } 
      //Minor switch 
      //UsePass "Toon/Basic/BASE" 
      UsePass "Diffuse/BASE" 
      Pass 
      { 
         Name "OUTLINE" 
         Tags { "LightMode" = "Always" } 
          
         Program "vp" {
// Vertex combos: 1
//   opengl - ALU: 13 to 13
//   d3d9 - ALU: 13 to 13
SubProgram "opengl " {
Keywords { }
Bind "vertex" ATTR0
Bind "normal" ATTR1
Float 13 [_Outline]
Vector 14 [_OutlineColor]
"!!ARBvp1.0
# 13 ALU
PARAM c[15] = { program.local[0],
		state.matrix.modelview[0],
		state.matrix.projection,
		state.matrix.mvp,
		program.local[13..14] };
TEMP R0;
TEMP R1;
DP4 R0.z, vertex.attrib[0], c[11];
DP3 R0.x, vertex.attrib[1], c[2];
MUL R0.y, R0.x, c[6];
DP3 R0.x, vertex.attrib[1], c[1];
MUL R0.x, R0, c[5];
MUL R1.xy, R0, R0.z;
DP4 R0.x, vertex.attrib[0], c[9];
DP4 R0.y, vertex.attrib[0], c[10];
MAD result.position.xy, R1, c[13].x, R0;
MOV result.color, c[14];
DP4 result.position.w, vertex.attrib[0], c[12];
MOV result.position.z, R0;
MOV result.fogcoord.x, R0.z;
END
# 13 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Matrix 8 [glstate_matrix_mvp]
Float 12 [_Outline]
Vector 13 [_OutlineColor]
"vs_2_0
; 13 ALU
dcl_position v0
dcl_normal v1
dp4 r0.z, v0, c10
dp3 r0.x, v1, c1
mul r0.y, r0.x, c5
dp3 r0.x, v1, c0
mul r0.x, r0, c4
mul r1.xy, r0, r0.z
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
mad oPos.xy, r1, c12.x, r0
mov oD0, c13
dp4 oPos.w, v0, c11
mov oPos.z, r0
mov oFog, r0.z
"
}

}

#LINE 52
 
          
         Cull Front 
         ZWrite On 
         ColorMask RGB 
         Blend SrcAlpha OneMinusSrcAlpha 
         //? -Note: I don't remember why I put a "?" here 
         SetTexture [_MainTex] { combine primary } 
      } 
   } 
    
   Fallback "Diffuse" 
}