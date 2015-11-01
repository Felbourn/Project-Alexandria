Shader "Scatterer/PQS/Ocean Surface Quad (Fallback)" {
	Properties {
		_Color("Main Color", Color) = (1, 1, 1, 1)
		_ColorFromSpace("Color From Space", Color) = (1, 1, 1, 1)
		_SpecColor("Specular Color", Color) = (1, 1, 1, 1)
		_Shininess("Shininess", Range(0.01, 1)) = 0.078125
		_Gloss("Gloss", Range(0.01, 1)) = 0.078125
		_tiling("Tex Tiling", Float) = 1
		_WaterTex("Tex0", 2D) = "white" {}
		_WaterTex1("Tex1", 2D) = "white" {}
		_fadeStart("FadeStart", Float) = 1
		_fadeEnd("FadeEnd", Float) = 1
		_PlanetOpacity("PlanetOpacity", Float) = 1
	}
	SubShader {
ZWrite On
Tags { "RenderType"="Opaque"}
		LOD 400
		GrabPass {}
		Pass {
			Name "FORWARD"
			Tags {
				"LIGHTMODE" = "ForwardBase"
				"SHADOWSUPPORT" = "true"
			}
			Blend SrcAlpha OneMinusSrcAlpha
			Program "vp" {
				SubProgram "opengl " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
					}
					Bind "vertex"
					Vertex
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Matrix 9[_Object2World]
					Vector 13[_WorldSpaceCameraPos]
					Vector 14[unity_SHAr]
					Vector 15[unity_SHAg]
					Vector 16[unity_SHAb]
					Vector 17[unity_SHBr]
					Vector 18[unity_SHBg]
					Vector 19[unity_SHBb]
					Vector 20[unity_SHC]
					Vector 21[unity_Scale]
					Float 22[_tiling]
					"!!ARBvp1.0
PARAM c[23] = { { 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..22] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[21].w;
DP3 R3.w, R1, c[10];
DP3 R2.w, R1, c[11];
DP3 R0.x, R1, c[9];
MOV R0.y, R3.w;
MOV R0.z, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[16];
DP4 R2.y, R0, c[15];
DP4 R2.x, R0, c[14];
MUL R0.z, R3.w, R3.w;
MAD R0.z, R0.x, R0.x, -R0;
MOV result.texcoord[2].x, R0;
DP4 R3.z, R1, c[19];
DP4 R3.x, R1, c[17];
DP4 R3.y, R1, c[18];
ADD R3.xyz, R2, R3;
MUL R1.xyz, R0.z, c[20];
MOV R2.z, vertex.texcoord[1].x;
MOV R2.xy, vertex.texcoord[0];
DP3 R0.y, R2, R2;
RSQ R0.y, R0.y;
MUL R2.xyz, R0.y, R2;
DP4 R0.x, vertex.position, c[9];
DP4 R0.z, vertex.position, c[11];
DP4 R0.y, vertex.position, c[10];
ADD result.texcoord[4].xyz, -R0, c[13];
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xyz, R3, R1;
ABS result.texcoord[0].xyz, R2;
MUL result.texcoord[1].xyz, R2, c[22].x;
MOV result.texcoord[2].z, R2.w;
MOV result.texcoord[2].y, R3.w;
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
MOV result.texcoord[1].w, -R0.x;
END
# 39 instructions, 4 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
					}
					Bind "vertex"
					Vertex
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 8[_Object2World]
					Vector 12[_WorldSpaceCameraPos]
					Vector 13[unity_SHAr]
					Vector 14[unity_SHAg]
					Vector 15[unity_SHAb]
					Vector 16[unity_SHBr]
					Vector 17[unity_SHBg]
					Vector 18[unity_SHBb]
					Vector 19[unity_SHC]
					Vector 20[unity_Scale]
					Float 21[_tiling]
					"vs_2_0
def c22, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
mul r1.xyz, v1, c20.w
dp3 r3.w, r1, c9
dp3 r2.w, r1, c10
dp3 r0.x, r1, c8
mov r0.y, r3.w
mov r0.z, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c22.x
dp4 r2.z, r0, c15
dp4 r2.y, r0, c14
dp4 r2.x, r0, c13
mul r0.z, r3.w, r3.w
mad r0.z, r0.x, r0.x, -r0
mov oT2.x, r0
dp4 r3.z, r1, c18
dp4 r3.x, r1, c16
dp4 r3.y, r1, c17
add r3.xyz, r2, r3
mul r1.xyz, r0.z, c19
mov r2.z, v3.x
mov r2.xy, v2
dp3 r0.y, r2, r2
rsq r0.y, r0.y
mul r2.xyz, r0.y, r2
dp4 r0.x, v0, c8
dp4 r0.z, v0, c10
dp4 r0.y, v0, c9
add oT4.xyz, -r0, c12
dp4 r0.x, v0, c2
add oT3.xyz, r3, r1
abs oT0.xyz, r2
mul oT1.xyz, r2, c21.x
mov oT2.z, r2.w
mov oT2.y, r3.w
dp4 oPos.w, v0, c7
dp4 oPos.z, v0, c6
dp4 oPos.y, v0, c5
dp4 oPos.x, v0, c4
mov oT1.w, -r0.x
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					304
					Float 212[_tiling]
					ConstBuffer "UnityPerCamera"
					128
					Vector 64[_WorldSpaceCameraPos] 3
					ConstBuffer "UnityLighting"
					720
					Vector 608[unity_SHAr]
					Vector 624[unity_SHAg]
					Vector 640[unity_SHAb]
					Vector 656[unity_SHBr]
					Vector 672[unity_SHBg]
					Vector 688[unity_SHBb]
					Vector 704[unity_SHC]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 192[_Object2World]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityLighting"
					2
					BindCB "UnityPerDraw"
					3 "vs_4_0
eefiecedgcekjaalgmbmblpdhienkiapmnkaopncabaaaaaafaahaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcjmafaaaaeaaaabaaghabaaaafjaaaaae
egiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaadbcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacaeaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaa
aaaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaabaaaaaaegacbaiaibaaaaaa
aaaaaaaadiaaaaaihccabaaaacaaaaaaegacbaaaaaaaaaaafgifcaaaaaaaaaaa
anaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
iccabaaaacaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
egbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaa
egiicaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaa
aaaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaaaaaaaaadgaaaaaficaabaaa
aaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaaacaaaaaa
cgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaaacaaaaaa
chaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaaacaaaaaa
ciaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaa
egakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaa
egaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaa
egaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaa
egaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
adaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaaacaaaaaacmaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaajhccabaaaafaaaaaaegacbaiaebaaaaaaaaaaaaaa
egiccaaaabaaaaaaaeaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					304
					Float 212[_tiling]
					ConstBuffer "UnityPerCamera"
					128
					Vector 64[_WorldSpaceCameraPos] 3
					ConstBuffer "UnityLighting"
					720
					Vector 608[unity_SHAr]
					Vector 624[unity_SHAg]
					Vector 640[unity_SHAb]
					Vector 656[unity_SHBr]
					Vector 672[unity_SHBg]
					Vector 688[unity_SHBb]
					Vector 704[unity_SHC]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 192[_Object2World]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityLighting"
					2
					BindCB "UnityPerDraw"
					3 "vs_4_0_level_9_1
eefiecedgpbalhfnbfdggbdinpkodeimdmhnogcjabaaaaaajeakaaaaaeaaaaaa
daaaaaaahaadaaaabeajaaaanmajaaaaebgpgodjdiadaaaadiadaaaaaaacpopp
miacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaanaa
abaaabaaaaaaaaaaabaaaeaaabaaacaaaaaaaaaaacaacgaaahaaadaaaaaaaaaa
adaaaaaaaiaaakaaaaaaaaaaadaaamaaaeaabcaaaaaaaaaaadaabeaaabaabgaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbhaaapkaaaaaiadpaaaaaaaaaaaaaaaa
aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjaabaaaaacaaaaadiaadaaoeja
abaaaaacaaaaaeiaaeaaaajaceaaaaacabaaahiaaaaaoeiacdaaaaacaaaaahoa
abaaoeiaafaaaaadabaaahoaabaaoeiaabaaffkaafaaaaadaaaaabiaaaaaffja
apaakkkaaeaaaaaeaaaaabiaaoaakkkaaaaaaajaaaaaaaiaaeaaaaaeaaaaabia
baaakkkaaaaakkjaaaaaaaiaaeaaaaaeaaaaabiabbaakkkaaaaappjaaaaaaaia
abaaaaacabaaaioaaaaaaaibafaaaaadaaaaahiaaaaaffjabdaaoekaaeaaaaae
aaaaahiabcaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiabeaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaahiabfaaoekaaaaappjaaaaaoeiaacaaaaadaeaaahoa
aaaaoeibacaaoekaafaaaaadaaaaahiaacaaoejabgaappkaafaaaaadabaaahia
aaaaffiabdaaoekaaeaaaaaeaaaaaliabcaakekaaaaaaaiaabaakeiaaeaaaaae
aaaaahiabeaaoekaaaaakkiaaaaapeiaabaaaaacaaaaaiiabhaaaakaajaaaaad
abaaabiaadaaoekaaaaaoeiaajaaaaadabaaaciaaeaaoekaaaaaoeiaajaaaaad
abaaaeiaafaaoekaaaaaoeiaafaaaaadacaaapiaaaaacjiaaaaakeiaajaaaaad
adaaabiaagaaoekaacaaoeiaajaaaaadadaaaciaahaaoekaacaaoeiaajaaaaad
adaaaeiaaiaaoekaacaaoeiaacaaaaadabaaahiaabaaoeiaadaaoeiaafaaaaad
aaaaaiiaaaaaffiaaaaaffiaaeaaaaaeaaaaaiiaaaaaaaiaaaaaaaiaaaaappib
abaaaaacacaaahoaaaaaoeiaaeaaaaaeadaaahoaajaaoekaaaaappiaabaaoeia
afaaaaadaaaaapiaaaaaffjaalaaoekaaeaaaaaeaaaaapiaakaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaapiaamaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapia
anaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiappppaaaafdeieefcjmafaaaaeaaaabaaghabaaaa
fjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaadbcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaac
aeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
dcaabaaaaaaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaabaaaaaaegacbaia
ibaaaaaaaaaaaaaadiaaaaaihccabaaaacaaaaaaegacbaaaaaaaaaaafgifcaaa
aaaaaaaaanaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
adaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaa
akbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
adaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaa
dgaaaaagiccabaaaacaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaa
aaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaa
egadbaaaaaaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaaaaaaaaadgaaaaaf
icaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaa
acaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaa
acaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaa
acaaaaaaciaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaa
aaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaa
cjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaa
ckaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaa
claaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaadaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaaacaaaaaa
cmaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaafaaaaaaegacbaiaebaaaaaa
aaaaaaaaegiccaaaabaaaaaaaeaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeo
ehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklkl"
				}
				SubProgram "opengl " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
					}
					Bind "vertex"
					Vertex
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Float 13[_tiling]
					Vector 14[unity_LightmapST]
					"!!ARBvp1.0
PARAM c[15] = { program.local[0],
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..14] };
TEMP R0;
MOV R0.z, vertex.texcoord[1].x;
MOV R0.xy, vertex.texcoord[0];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
ABS result.texcoord[0].xyz, R0;
MUL result.texcoord[1].xyz, R0, c[13].x;
DP4 R0.x, vertex.position, c[3];
MAD result.texcoord[2].xy, vertex.texcoord[1], c[14], c[14].zwzw;
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
MOV result.texcoord[1].w, -R0.x;
END
# 14 instructions, 1 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
					}
					Bind "vertex"
					Vertex
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Float 12[_tiling]
					Vector 13[unity_LightmapST]
					"vs_2_0
dcl_position0 v0
dcl_texcoord0 v2
dcl_texcoord1 v3
mov r0.z, v3.x
mov r0.xy, v2
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
abs oT0.xyz, r0
mul oT1.xyz, r0, c12.x
dp4 r0.x, v0, c2
mad oT2.xy, v3, c13, c13.zwzw
dp4 oPos.w, v0, c7
dp4 oPos.z, v0, c6
dp4 oPos.y, v0, c5
dp4 oPos.x, v0, c4
mov oT1.w, -r0.x
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					320
					Float 212[_tiling]
					Vector 304[unity_LightmapST]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					BindCB "$Globals"
					0
					BindCB "UnityPerDraw"
					1 "vs_4_0
eefiecedcciihaaihofepnolohgeifecemjgndcjabaaaaaadaaeaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
kmacaaaaeaaaabaaklaaaaaafjaaaaaeegiocaaaaaaaaaaabeaaaaaafjaaaaae
egiocaaaabaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaa
adaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafdcaabaaaaaaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaa
aaaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaa
abaaaaaaegacbaiaibaaaaaaaaaaaaaadiaaaaaihccabaaaacaaaaaaegacbaaa
aaaaaaaafgifcaaaaaaaaaaaanaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaa
aaaaaaaackiacaaaabaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
abaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaabaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaadkbabaaaaaaaaaaa
akaabaaaaaaaaaaadgaaaaagiccabaaaacaaaaaaakaabaiaebaaaaaaaaaaaaaa
dcaaaaaldccabaaaadaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaabdaaaaaa
ogikcaaaaaaaaaaabdaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					320
					Float 212[_tiling]
					Vector 304[unity_LightmapST]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					BindCB "$Globals"
					0
					BindCB "UnityPerDraw"
					1 "vs_4_0_level_9_1
eefiecedapcadfdeinpennfpjfmeeofgiokcanagabaaaaaammafaaaaaeaaaaaa
daaaaaaamiabaaaahmaeaaaaeeafaaaaebgpgodjjaabaaaajaabaaaaaaacpopp
eeabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaanaa
abaaabaaaaaaaaaaaaaabdaaabaaacaaaaaaaaaaabaaaaaaaiaaadaaaaaaaaaa
aaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaadiaadaaapja
bpaaaaacafaaaeiaaeaaapjaabaaaaacaaaaadiaadaaoejaabaaaaacaaaaaeia
aeaaaajaceaaaaacabaaahiaaaaaoeiacdaaaaacaaaaahoaabaaoeiaafaaaaad
abaaahoaabaaoeiaabaaffkaafaaaaadaaaaabiaaaaaffjaaiaakkkaaeaaaaae
aaaaabiaahaakkkaaaaaaajaaaaaaaiaaeaaaaaeaaaaabiaajaakkkaaaaakkja
aaaaaaiaaeaaaaaeaaaaabiaakaakkkaaaaappjaaaaaaaiaabaaaaacabaaaioa
aaaaaaibaeaaaaaeacaaadoaaeaaoejaacaaoekaacaaookaafaaaaadaaaaapia
aaaaffjaaeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiaafaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappja
aaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiappppaaaafdeieefckmacaaaaeaaaabaaklaaaaaafjaaaaaeegiocaaa
aaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaaddccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaaaaaaaaaaegbabaaa
adaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaghccabaaaabaaaaaaegacbaiaibaaaaaaaaaaaaaadiaaaaai
hccabaaaacaaaaaaegacbaaaaaaaaaaafgifcaaaaaaaaaaaanaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaabaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaabaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaagiccabaaaacaaaaaa
akaabaiaebaaaaaaaaaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaaaeaaaaaa
egiacaaaaaaaaaaabdaaaaaaogikcaaaaaaaaaaabdaaaaaadoaaaaabejfdeheo
maaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaalaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
ahaiaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
				}
				SubProgram "opengl " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
					}
					Bind "vertex"
					Vertex
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Bind "tangent"
					ATTR14
					Matrix 13[_World2Object]
					Vector 17[_WorldSpaceCameraPos]
					Vector 18[unity_Scale]
					Float 19[_tiling]
					Vector 20[unity_LightmapST]
					"!!ARBvp1.0
PARAM c[21] = { { 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..20] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R1.xyz, c[17];
MOV R1.w, c[0].x;
DP4 R2.z, R1, c[15];
DP4 R2.x, R1, c[13];
DP4 R2.y, R1, c[14];
MAD R1.xyz, R2, c[18].w, -vertex.position;
MUL R2.xyz, R0, vertex.attrib[14].w;
MOV R0.z, vertex.texcoord[1].x;
MOV R0.xy, vertex.texcoord[0];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
ABS result.texcoord[0].xyz, R0;
MUL result.texcoord[1].xyz, R0, c[19].x;
DP4 R0.x, vertex.position, c[3];
DP3 result.texcoord[3].y, R1, R2;
DP3 result.texcoord[3].z, vertex.normal, R1;
DP3 result.texcoord[3].x, R1, vertex.attrib[14];
MAD result.texcoord[2].xy, vertex.texcoord[1], c[20], c[20].zwzw;
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
MOV result.texcoord[1].w, -R0.x;
END
# 27 instructions, 3 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
					}
					Bind "vertex"
					Vertex
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Bind "tangent"
					TexCoord2
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 12[_World2Object]
					Vector 16[_WorldSpaceCameraPos]
					Vector 17[unity_Scale]
					Float 18[_tiling]
					Vector 19[unity_LightmapST]
					"vs_2_0
def c20, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mov r1.xyz, c16
mov r1.w, c20.x
dp4 r2.z, r1, c14
dp4 r2.x, r1, c12
dp4 r2.y, r1, c13
mad r1.xyz, r2, c17.w, -v0
mul r2.xyz, r0, v1.w
mov r0.z, v4.x
mov r0.xy, v3
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
abs oT0.xyz, r0
mul oT1.xyz, r0, c18.x
dp4 r0.x, v0, c2
dp3 oT3.y, r1, r2
dp3 oT3.z, v2, r1
dp3 oT3.x, r1, v1
mad oT2.xy, v4, c19, c19.zwzw
dp4 oPos.w, v0, c7
dp4 oPos.z, v0, c6
dp4 oPos.y, v0, c5
dp4 oPos.x, v0, c4
mov oT1.w, -r0.x
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Bind "tangent"
					TexCoord2
					ConstBuffer "$Globals"
					320
					Float 212[_tiling]
					Vector 304[unity_LightmapST]
					ConstBuffer "UnityPerCamera"
					128
					Vector 64[_WorldSpaceCameraPos] 3
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 256[_World2Object]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityPerDraw"
					2 "vs_4_0
eefiecedhebkjhcdjheoaofohnhdnkjffemolcpnabaaaaaapiafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcfmaeaaaaeaaaabaa
bhabaaaafjaaaaaeegiocaaaaaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaaaaaaaaaaegbabaaa
adaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaghccabaaaabaaaaaaegacbaiaibaaaaaaaaaaaaaadiaaaaai
hccabaaaacaaaaaaegacbaaaaaaaaaaafgifcaaaaaaaaaaaanaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaagiccabaaaacaaaaaa
akaabaiaebaaaaaaaaaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaaaeaaaaaa
egiacaaaaaaaaaaabdaaaaaaogikcaaaaaaaaaaabdaaaaaadiaaaaahhcaabaaa
aaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaa
jgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaa
abaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabcaaaaaa
kgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegiccaaaacaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaa
egacbaaaabaaaaaapgipcaaaacaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
baaaaaahcccabaaaaeaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
bccabaaaaeaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaa
aeaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Bind "tangent"
					TexCoord2
					ConstBuffer "$Globals"
					320
					Float 212[_tiling]
					Vector 304[unity_LightmapST]
					ConstBuffer "UnityPerCamera"
					128
					Vector 64[_WorldSpaceCameraPos] 3
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 256[_World2Object]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityPerDraw"
					2 "vs_4_0_level_9_1
eefiecedbjghmonomngenmlbklojegdhbcfbpafpabaaaaaajmaiaaaaaeaaaaaa
daaaaaaanaacaaaadeahaaaapmahaaaaebgpgodjjiacaaaajiacaaaaaaacpopp
deacaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaanaa
abaaabaaaaaaaaaaaaaabdaaabaaacaaaaaaaaaaabaaaeaaabaaadaaaaaaaaaa
acaaaaaaaiaaaeaaaaaaaaaaacaabaaaafaaamaaaaaaaaaaaaaaaaaaaaacpopp
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjaabaaaaac
aaaaadiaadaaoejaabaaaaacaaaaaeiaaeaaaajaceaaaaacabaaahiaaaaaoeia
cdaaaaacaaaaahoaabaaoeiaafaaaaadabaaahoaabaaoeiaabaaffkaafaaaaad
aaaaabiaaaaaffjaajaakkkaaeaaaaaeaaaaabiaaiaakkkaaaaaaajaaaaaaaia
aeaaaaaeaaaaabiaakaakkkaaaaakkjaaaaaaaiaaeaaaaaeaaaaabiaalaakkka
aaaappjaaaaaaaiaabaaaaacabaaaioaaaaaaaibaeaaaaaeacaaadoaaeaaoeja
acaaoekaacaaookaabaaaaacaaaaahiaadaaoekaafaaaaadabaaahiaaaaaffia
anaaoekaaeaaaaaeaaaaaliaamaakekaaaaaaaiaabaakeiaaeaaaaaeaaaaahia
aoaaoekaaaaakkiaaaaapeiaacaaaaadaaaaahiaaaaaoeiaapaaoekaaeaaaaae
aaaaahiaaaaaoeiabaaappkaaaaaoejbaiaaaaadadaaaboaabaaoejaaaaaoeia
abaaaaacabaaahiaabaaoejaafaaaaadacaaahiaabaamjiaacaancjaaeaaaaae
abaaahiaacaamjjaabaanciaacaaoeibafaaaaadabaaahiaabaaoeiaabaappja
aiaaaaadadaaacoaabaaoeiaaaaaoeiaaiaaaaadadaaaeoaacaaoejaaaaaoeia
afaaaaadaaaaapiaaaaaffjaafaaoekaaeaaaaaeaaaaapiaaeaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapia
ahaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiappppaaaafdeieefcfmaeaaaaeaaaabaabhabaaaa
fjaaaaaeegiocaaaaaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaaaaaaaaaaegbabaaaadaaaaaa
dgaaaaafecaabaaaaaaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaghccabaaaabaaaaaaegacbaiaibaaaaaaaaaaaaaadiaaaaaihccabaaa
acaaaaaaegacbaaaaaaaaaaafgifcaaaaaaaaaaaanaaaaaadiaaaaaibcaabaaa
aaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaa
dkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaagiccabaaaacaaaaaaakaabaia
ebaaaaaaaaaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaaaeaaaaaaegiacaaa
aaaaaaaabdaaaaaaogikcaaaaaaaaaaabdaaaaaadiaaaaahhcaabaaaaaaaaaaa
jgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaa
acaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaa
fgifcaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaa
abaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaacaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaa
abaaaaaapgipcaaaacaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaah
cccabaaaaeaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
aeaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaaeaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeo
ehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaaimaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
				}
				SubProgram "opengl " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
					}
					Bind "vertex"
					Vertex
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Matrix 9[_Object2World]
					Vector 13[_WorldSpaceCameraPos]
					Vector 14[_ProjectionParams]
					Vector 15[unity_SHAr]
					Vector 16[unity_SHAg]
					Vector 17[unity_SHAb]
					Vector 18[unity_SHBr]
					Vector 19[unity_SHBg]
					Vector 20[unity_SHBb]
					Vector 21[unity_SHC]
					Vector 22[unity_Scale]
					Float 23[_tiling]
					"!!ARBvp1.0
PARAM c[24] = { { 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..23] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R0.xyz, vertex.normal, c[22].w;
DP3 R3.w, R0, c[10];
DP3 R2.w, R0, c[11];
DP3 R1.w, R0, c[9];
MOV R1.x, R3.w;
MOV R1.y, R2.w;
MOV R1.z, c[0].x;
MUL R0, R1.wxyy, R1.xyyw;
DP4 R2.z, R1.wxyz, c[17];
DP4 R2.y, R1.wxyz, c[16];
DP4 R2.x, R1.wxyz, c[15];
DP4 R1.z, R0, c[20];
DP4 R1.y, R0, c[19];
DP4 R1.x, R0, c[18];
MUL R3.x, R3.w, R3.w;
ADD R2.xyz, R2, R1;
MAD R0.x, R1.w, R1.w, -R3;
MUL R1.xyz, R0.x, c[21];
ADD result.texcoord[3].xyz, R2, R1;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R3.xyz, R0.xyww, c[0].y;
MOV R2.x, R3;
MUL R2.y, R3, c[14].x;
MOV R1.z, vertex.texcoord[1].x;
MOV R1.xy, vertex.texcoord[0];
DP3 R0.z, R1, R1;
ADD result.texcoord[5].xy, R2, R3.z;
RSQ R2.x, R0.z;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
MUL R1.xyz, R2.x, R1;
MOV result.texcoord[5].zw, R0;
DP4 R0.w, vertex.position, c[3];
DP4 R0.z, vertex.position, c[11];
DP4 R0.x, vertex.position, c[9];
DP4 R0.y, vertex.position, c[10];
ABS result.texcoord[0].xyz, R1;
MUL result.texcoord[1].xyz, R1, c[23].x;
MOV result.texcoord[2].z, R2.w;
MOV result.texcoord[2].y, R3.w;
MOV result.texcoord[2].x, R1.w;
ADD result.texcoord[4].xyz, -R0, c[13];
MOV result.texcoord[1].w, -R0;
END
# 45 instructions, 4 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
					}
					Bind "vertex"
					Vertex
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 8[_Object2World]
					Vector 12[_WorldSpaceCameraPos]
					Vector 13[_ProjectionParams]
					Vector 14[_ScreenParams]
					Vector 15[unity_SHAr]
					Vector 16[unity_SHAg]
					Vector 17[unity_SHAb]
					Vector 18[unity_SHBr]
					Vector 19[unity_SHBg]
					Vector 20[unity_SHBb]
					Vector 21[unity_SHC]
					Vector 22[unity_Scale]
					Float 23[_tiling]
					"vs_2_0
def c24, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
mul r0.xyz, v1, c22.w
dp3 r3.w, r0, c9
dp3 r2.w, r0, c10
dp3 r1.w, r0, c8
mov r1.x, r3.w
mov r1.y, r2.w
mov r1.z, c24.x
mul r0, r1.wxyy, r1.xyyw
dp4 r2.z, r1.wxyz, c17
dp4 r2.y, r1.wxyz, c16
dp4 r2.x, r1.wxyz, c15
dp4 r1.z, r0, c20
dp4 r1.y, r0, c19
dp4 r1.x, r0, c18
mul r3.x, r3.w, r3.w
add r2.xyz, r2, r1
mad r0.x, r1.w, r1.w, -r3
mul r1.xyz, r0.x, c21
add oT3.xyz, r2, r1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r3.xyz, r0.xyww, c24.y
mov r2.x, r3
mul r2.y, r3, c13.x
mov r1.z, v3.x
mov r1.xy, v2
dp3 r0.z, r1, r1
mad oT5.xy, r3.z, c14.zwzw, r2
rsq r2.x, r0.z
dp4 r0.z, v0, c6
mov oPos, r0
mul r1.xyz, r2.x, r1
mov oT5.zw, r0
dp4 r0.w, v0, c2
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
abs oT0.xyz, r1
mul oT1.xyz, r1, c23.x
mov oT2.z, r2.w
mov oT2.y, r3.w
mov oT2.x, r1.w
add oT4.xyz, -r0, c12
mov oT1.w, -r0
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					368
					Float 276[_tiling]
					ConstBuffer "UnityPerCamera"
					128
					Vector 64[_WorldSpaceCameraPos] 3
					Vector 80[_ProjectionParams]
					ConstBuffer "UnityLighting"
					720
					Vector 608[unity_SHAr]
					Vector 624[unity_SHAg]
					Vector 640[unity_SHAb]
					Vector 656[unity_SHBr]
					Vector 672[unity_SHBg]
					Vector 688[unity_SHBb]
					Vector 704[unity_SHC]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 192[_Object2World]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityLighting"
					2
					BindCB "UnityPerDraw"
					3 "vs_4_0
eefiecedgjkaabjglcjnbjnoalbgeokiioghflpoabaaaaaaaaaiaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcdeagaaaaeaaaabaainabaaaafjaaaaaeegiocaaaaaaaaaaa
bcaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
cnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadbcbabaaa
aeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagiaaaaac
afaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaaabaaaaaaegbabaaa
adaaaaaadgaaaaafecaabaaaabaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaa
abaaaaaadgaaaaaghccabaaaabaaaaaaegacbaiaibaaaaaaabaaaaaadiaaaaai
hccabaaaacaaaaaaegacbaaaabaaaaaafgifcaaaaaaaaaaabbaaaaaadiaaaaai
bcaabaaaabaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaak
bcaabaaaabaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
abaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaadaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaadaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaabaaaaaadgaaaaagiccabaaaacaaaaaa
akaabaiaebaaaaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaacaaaaaa
pgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaabaaaaaaegiicaaaadaaaaaa
amaaaaaaagaabaaaabaaaaaaegaibaaaacaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaaoaaaaaakgakbaaaabaaaaaaegadbaaaabaaaaaadgaaaaaf
hccabaaaadaaaaaaegacbaaaabaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaa
aaaaiadpbbaaaaaibcaabaaaacaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaa
abaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaa
abaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaa
abaaaaaadiaaaaahpcaabaaaadaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaa
bbaaaaaibcaabaaaaeaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaadaaaaaa
bbaaaaaiccaabaaaaeaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaadaaaaaa
bbaaaaaiecaabaaaaeaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaadaaaaaa
aaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakbcaabaaa
abaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaa
dcaaaaakhccabaaaaeaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaabaaaaaa
egacbaaaacaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaa
aaaaaaajhccabaaaafaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaaabaaaaaa
aeaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaagaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaagaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					368
					Float 276[_tiling]
					ConstBuffer "UnityPerCamera"
					128
					Vector 64[_WorldSpaceCameraPos] 3
					Vector 80[_ProjectionParams]
					ConstBuffer "UnityLighting"
					720
					Vector 608[unity_SHAr]
					Vector 624[unity_SHAg]
					Vector 640[unity_SHAb]
					Vector 656[unity_SHBr]
					Vector 672[unity_SHBg]
					Vector 688[unity_SHBb]
					Vector 704[unity_SHC]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 192[_Object2World]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityLighting"
					2
					BindCB "UnityPerDraw"
					3 "vs_4_0_level_9_1
eefieceddllejpibeglcjgkknggmhlejiebgeieiabaaaaaajaalaaaaaeaaaaaa
daaaaaaalmadaaaapiajaaaamaakaaaaebgpgodjieadaaaaieadaaaaaaacpopp
beadaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaabbaa
abaaabaaaaaaaaaaabaaaeaaacaaacaaaaaaaaaaacaacgaaahaaaeaaaaaaaaaa
adaaaaaaaiaaalaaaaaaaaaaadaaamaaaeaabdaaaaaaaaaaadaabeaaabaabhaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbiaaapkaaaaaiadpaaaaaadpaaaaaaaa
aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjaabaaaaacaaaaadiaadaaoeja
abaaaaacaaaaaeiaaeaaaajaceaaaaacabaaahiaaaaaoeiacdaaaaacaaaaahoa
abaaoeiaafaaaaadabaaahoaabaaoeiaabaaffkaafaaaaadaaaaabiaaaaaffja
baaakkkaaeaaaaaeaaaaabiaapaakkkaaaaaaajaaaaaaaiaaeaaaaaeaaaaabia
bbaakkkaaaaakkjaaaaaaaiaaeaaaaaeaaaaabiabcaakkkaaaaappjaaaaaaaia
abaaaaacabaaaioaaaaaaaibafaaaaadaaaaahiaaaaaffjabeaaoekaaeaaaaae
aaaaahiabdaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiabfaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaahiabgaaoekaaaaappjaaaaaoeiaacaaaaadaeaaahoa
aaaaoeibacaaoekaafaaaaadaaaaahiaacaaoejabhaappkaafaaaaadabaaahia
aaaaffiabeaaoekaaeaaaaaeaaaaaliabdaakekaaaaaaaiaabaakeiaaeaaaaae
aaaaahiabfaaoekaaaaakkiaaaaapeiaabaaaaacaaaaaiiabiaaaakaajaaaaad
abaaabiaaeaaoekaaaaaoeiaajaaaaadabaaaciaafaaoekaaaaaoeiaajaaaaad
abaaaeiaagaaoekaaaaaoeiaafaaaaadacaaapiaaaaacjiaaaaakeiaajaaaaad
adaaabiaahaaoekaacaaoeiaajaaaaadadaaaciaaiaaoekaacaaoeiaajaaaaad
adaaaeiaajaaoekaacaaoeiaacaaaaadabaaahiaabaaoeiaadaaoeiaafaaaaad
aaaaaiiaaaaaffiaaaaaffiaaeaaaaaeaaaaaiiaaaaaaaiaaaaaaaiaaaaappib
abaaaaacacaaahoaaaaaoeiaaeaaaaaeadaaahoaakaaoekaaaaappiaabaaoeia
afaaaaadaaaaapiaaaaaffjaamaaoekaaeaaaaaeaaaaapiaalaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaapiaanaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapia
aoaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffiaadaaaakaafaaaaad
abaaaiiaabaaaaiabiaaffkaafaaaaadabaaafiaaaaapeiabiaaffkaacaaaaad
afaaadoaabaakkiaabaaomiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiaabaaaaacafaaamoaaaaaoeiappppaaaafdeieefc
deagaaaaeaaaabaainabaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadbcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagiaaaaacafaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaadgaaaaaf
ecaabaaaabaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaag
hccabaaaabaaaaaaegacbaiaibaaaaaaabaaaaaadiaaaaaihccabaaaacaaaaaa
egacbaaaabaaaaaafgifcaaaaaaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaabaaaaaa
ckiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaak
bcaabaaaabaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
abaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaabaaaaaadgaaaaagiccabaaaacaaaaaaakaabaiaebaaaaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaa
beaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaaklcaabaaaabaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaa
abaaaaaaegaibaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
aoaaaaaakgakbaaaabaaaaaaegadbaaaabaaaaaadgaaaaafhccabaaaadaaaaaa
egacbaaaabaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpbbaaaaai
bcaabaaaacaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaabbaaaaai
ccaabaaaacaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaabbaaaaai
ecaabaaaacaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaadiaaaaah
pcaabaaaadaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaa
aeaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaa
aeaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaa
aeaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaadaaaaaaaaaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahccaabaaaabaaaaaa
bkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaadcaaaaakhccabaaa
aeaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaa
diaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhccabaaa
afaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaaabaaaaaaaeaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaafmccabaaaagaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaa
agaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaabejfdeheomaaaaaaa
agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
kbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaa
ljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeo
aafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaakl
epfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaa
lmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaalmaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaa
lmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
				}
				SubProgram "opengl " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
					}
					Bind "vertex"
					Vertex
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Vector 13[_ProjectionParams]
					Float 14[_tiling]
					Vector 15[unity_LightmapST]
					"!!ARBvp1.0
PARAM c[16] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..15] };
TEMP R0;
TEMP R1;
TEMP R2;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R2.xyz, R0.xyww, c[0].x;
MUL R2.y, R2, c[13].x;
MOV R1.z, vertex.texcoord[1].x;
MOV R1.xy, vertex.texcoord[0];
DP3 R0.z, R1, R1;
RSQ R1.w, R0.z;
DP4 R0.z, vertex.position, c[7];
MUL R1.xyz, R1.w, R1;
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[3].xy, R2, R2.z;
ABS result.texcoord[0].xyz, R1;
MUL result.texcoord[1].xyz, R1, c[14].x;
MOV result.texcoord[3].zw, R0;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[15], c[15].zwzw;
MOV result.texcoord[1].w, -R0.x;
END
# 19 instructions, 3 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
					}
					Bind "vertex"
					Vertex
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Vector 12[_ProjectionParams]
					Vector 13[_ScreenParams]
					Float 14[_tiling]
					Vector 15[unity_LightmapST]
					"vs_2_0
def c16, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v2
dcl_texcoord1 v3
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r2.xyz, r0.xyww, c16.x
mul r2.y, r2, c12.x
mov r1.z, v3.x
mov r1.xy, v2
dp3 r0.z, r1, r1
rsq r1.w, r0.z
dp4 r0.z, v0, c6
mul r1.xyz, r1.w, r1
mov oPos, r0
dp4 r0.x, v0, c2
mad oT3.xy, r2.z, c13.zwzw, r2
abs oT0.xyz, r1
mul oT1.xyz, r1, c14.x
mov oT3.zw, r0
mad oT2.xy, v3, c15, c15.zwzw
mov oT1.w, -r0.x
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					384
					Float 276[_tiling]
					Vector 368[unity_LightmapST]
					ConstBuffer "UnityPerCamera"
					128
					Vector 80[_ProjectionParams]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityPerDraw"
					2 "vs_4_0
eefiecedmphldajigebhfjpbaldlhgfjdhjhcglkabaaaaaapaaeaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcfeadaaaaeaaaabaa
nfaaaaaafjaaaaaeegiocaaaaaaaaaaabiaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaa
dgaaaaafecaabaaaabaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaaghccabaaaabaaaaaaegacbaiaibaaaaaaabaaaaaadiaaaaaihccabaaa
acaaaaaaegacbaaaabaaaaaafgifcaaaaaaaaaaabbaaaaaadiaaaaaibcaabaaa
abaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaa
abaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaabaaaaaa
dcaaaaakbcaabaaaabaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaa
akaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaacaaaaaaahaaaaaa
dkbabaaaaaaaaaaaakaabaaaabaaaaaadgaaaaagiccabaaaacaaaaaaakaabaia
ebaaaaaaabaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaaaeaaaaaaegiacaaa
aaaaaaaabhaaaaaaogikcaaaaaaaaaaabhaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaaeaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					384
					Float 276[_tiling]
					Vector 368[unity_LightmapST]
					ConstBuffer "UnityPerCamera"
					128
					Vector 80[_ProjectionParams]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityPerDraw"
					2 "vs_4_0_level_9_1
eefiecedkcibaechmchlfoljmlgjpaplojlkdjfmabaaaaaapmagaaaaaeaaaaaa
daaaaaaadiacaaaajeafaaaafmagaaaaebgpgodjaaacaaaaaaacaaaaaaacpopp
kiabaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaabbaa
abaaabaaaaaaaaaaaaaabhaaabaaacaaaaaaaaaaabaaafaaabaaadaaaaaaaaaa
acaaaaaaaiaaaeaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafamaaapkaaaaaaadp
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaadia
adaaapjabpaaaaacafaaaeiaaeaaapjaabaaaaacaaaaadiaadaaoejaabaaaaac
aaaaaeiaaeaaaajaceaaaaacabaaahiaaaaaoeiacdaaaaacaaaaahoaabaaoeia
afaaaaadabaaahoaabaaoeiaabaaffkaafaaaaadaaaaabiaaaaaffjaajaakkka
aeaaaaaeaaaaabiaaiaakkkaaaaaaajaaaaaaaiaaeaaaaaeaaaaabiaakaakkka
aaaakkjaaaaaaaiaaeaaaaaeaaaaabiaalaakkkaaaaappjaaaaaaaiaabaaaaac
abaaaioaaaaaaaibaeaaaaaeacaaadoaaeaaoejaacaaoekaacaaookaafaaaaad
aaaaapiaaaaaffjaafaaoekaaeaaaaaeaaaaapiaaeaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaagaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaahaaoeka
aaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffiaadaaaakaafaaaaadabaaaiia
abaaaaiaamaaaakaafaaaaadabaaafiaaaaapeiaamaaaakaacaaaaadadaaadoa
abaakkiaabaaomiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacadaaamoaaaaaoeiappppaaaafdeieefcfeadaaaa
eaaaabaanfaaaaaafjaaaaaeegiocaaaaaaaaaaabiaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaaiaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaaabaaaaaaegbabaaa
adaaaaaadgaaaaafecaabaaaabaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaa
abaaaaaadgaaaaaghccabaaaabaaaaaaegacbaiaibaaaaaaabaaaaaadiaaaaai
hccabaaaacaaaaaaegacbaaaabaaaaaafgifcaaaaaaaaaaabbaaaaaadiaaaaai
bcaabaaaabaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaak
bcaabaaaabaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
abaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaacaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaacaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaabaaaaaadgaaaaagiccabaaaacaaaaaa
akaabaiaebaaaaaaabaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaaaeaaaaaa
egiacaaaaaaaaaaabhaaaaaaogikcaaaaaaaaaaabhaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaaeaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeo
ehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaaimaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
				}
				SubProgram "opengl " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
					}
					Bind "vertex"
					Vertex
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Bind "tangent"
					ATTR14
					Matrix 13[_World2Object]
					Vector 17[_WorldSpaceCameraPos]
					Vector 18[_ProjectionParams]
					Vector 19[unity_Scale]
					Float 20[_tiling]
					Vector 21[unity_LightmapST]
					"!!ARBvp1.0
PARAM c[22] = { { 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..21] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R0.xyz, R0, vertex.attrib[14].w;
MOV R1.w, c[0].x;
MOV R1.xyz, c[17];
DP4 R2.z, R1, c[15];
DP4 R2.x, R1, c[13];
DP4 R2.y, R1, c[14];
MAD R1.xyz, R2, c[19].w, -vertex.position;
DP3 result.texcoord[3].y, R1, R0;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R2.xyz, R0.xyww, c[0].y;
MUL R2.y, R2, c[18].x;
DP3 result.texcoord[3].z, vertex.normal, R1;
DP3 result.texcoord[3].x, R1, vertex.attrib[14];
MOV R1.z, vertex.texcoord[1].x;
MOV R1.xy, vertex.texcoord[0];
DP3 R0.z, R1, R1;
RSQ R1.w, R0.z;
DP4 R0.z, vertex.position, c[7];
MUL R1.xyz, R1.w, R1;
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[4].xy, R2, R2.z;
ABS result.texcoord[0].xyz, R1;
MUL result.texcoord[1].xyz, R1, c[20].x;
MOV result.texcoord[4].zw, R0;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[21], c[21].zwzw;
MOV result.texcoord[1].w, -R0.x;
END
# 32 instructions, 3 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
					}
					Bind "vertex"
					Vertex
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Bind "tangent"
					TexCoord2
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 12[_World2Object]
					Vector 16[_WorldSpaceCameraPos]
					Vector 17[_ProjectionParams]
					Vector 18[_ScreenParams]
					Vector 19[unity_Scale]
					Float 20[_tiling]
					Vector 21[unity_LightmapST]
					"vs_2_0
def c22, 1.00000000, 0.50000000, 0, 0
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
mov r1.w, c22.x
mov r1.xyz, c16
dp4 r2.z, r1, c14
dp4 r2.x, r1, c12
dp4 r2.y, r1, c13
mad r1.xyz, r2, c19.w, -v0
dp3 oT3.y, r1, r0
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r2.xyz, r0.xyww, c22.y
mul r2.y, r2, c17.x
dp3 oT3.z, v2, r1
dp3 oT3.x, r1, v1
mov r1.z, v4.x
mov r1.xy, v3
dp3 r0.z, r1, r1
rsq r1.w, r0.z
dp4 r0.z, v0, c6
mul r1.xyz, r1.w, r1
mov oPos, r0
dp4 r0.x, v0, c2
mad oT4.xy, r2.z, c18.zwzw, r2
abs oT0.xyz, r1
mul oT1.xyz, r1, c20.x
mov oT4.zw, r0
mad oT2.xy, v4, c21, c21.zwzw
mov oT1.w, -r0.x
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Bind "tangent"
					TexCoord2
					ConstBuffer "$Globals"
					384
					Float 276[_tiling]
					Vector 368[unity_LightmapST]
					ConstBuffer "UnityPerCamera"
					128
					Vector 64[_WorldSpaceCameraPos] 3
					Vector 80[_ProjectionParams]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 256[_World2Object]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityPerDraw"
					2 "vs_4_0
eefiecedegjlhojfefmdbamklklpocodmpmflkkkabaaaaaakiagaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcpeaeaaaaeaaaabaadnabaaaafjaaaaae
egiocaaaaaaaaaaabiaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacadaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaadgaaaaaf
ecaabaaaabaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaag
hccabaaaabaaaaaaegacbaiaibaaaaaaabaaaaaadiaaaaaihccabaaaacaaaaaa
egacbaaaabaaaaaafgifcaaaaaaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaabaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaak
bcaabaaaabaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
abaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaabaaaaaadgaaaaagiccabaaaacaaaaaaakaabaiaebaaaaaa
abaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaa
bhaaaaaaogikcaaaaaaaaaaabhaaaaaadiaaaaahhcaabaaaabaaaaaajgbebaaa
abaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaajgbebaaaacaaaaaa
cgbjbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaa
abaaaaaaaeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaa
egiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaa
dcaaaaalhcaabaaaacaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaa
aeaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaa
egiccaaaacaaaaaabdaaaaaadcaaaaalhcaabaaaacaaaaaaegacbaaaacaaaaaa
pgipcaaaacaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaa
aeaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaaaeaaaaaa
egbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaa
acaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaafaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaafaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Bind "tangent"
					TexCoord2
					ConstBuffer "$Globals"
					384
					Float 276[_tiling]
					Vector 368[unity_LightmapST]
					ConstBuffer "UnityPerCamera"
					128
					Vector 64[_WorldSpaceCameraPos] 3
					Vector 80[_ProjectionParams]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 256[_World2Object]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityPerDraw"
					2 "vs_4_0_level_9_1
eefiecedcaakhjnnafcfmcbmgkdbhbcpimelomamabaaaaaalaajaaaaaeaaaaaa
daaaaaaadeadaaaadaaiaaaapiaiaaaaebgpgodjpmacaaaapmacaaaaaaacpopp
jiacaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaabbaa
abaaabaaaaaaaaaaaaaabhaaabaaacaaaaaaaaaaabaaaeaaacaaadaaaaaaaaaa
acaaaaaaaiaaafaaaaaaaaaaacaabaaaafaaanaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafbcaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjaabaaaaacaaaaadiaadaaoeja
abaaaaacaaaaaeiaaeaaaajaceaaaaacabaaahiaaaaaoeiacdaaaaacaaaaahoa
abaaoeiaafaaaaadabaaahoaabaaoeiaabaaffkaafaaaaadaaaaabiaaaaaffja
akaakkkaaeaaaaaeaaaaabiaajaakkkaaaaaaajaaaaaaaiaaeaaaaaeaaaaabia
alaakkkaaaaakkjaaaaaaaiaaeaaaaaeaaaaabiaamaakkkaaaaappjaaaaaaaia
abaaaaacabaaaioaaaaaaaibaeaaaaaeacaaadoaaeaaoejaacaaoekaacaaooka
abaaaaacaaaaahiaadaaoekaafaaaaadabaaahiaaaaaffiaaoaaoekaaeaaaaae
aaaaaliaanaakekaaaaaaaiaabaakeiaaeaaaaaeaaaaahiaapaaoekaaaaakkia
aaaapeiaacaaaaadaaaaahiaaaaaoeiabaaaoekaaeaaaaaeaaaaahiaaaaaoeia
bbaappkaaaaaoejbaiaaaaadadaaaboaabaaoejaaaaaoeiaabaaaaacabaaahia
abaaoejaafaaaaadacaaahiaabaamjiaacaancjaaeaaaaaeabaaahiaacaamjja
abaanciaacaaoeibafaaaaadabaaahiaabaaoeiaabaappjaaiaaaaadadaaacoa
abaaoeiaaaaaoeiaaiaaaaadadaaaeoaacaaoejaaaaaoeiaafaaaaadaaaaapia
aaaaffjaagaaoekaaeaaaaaeaaaaapiaafaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiaahaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaaiaaoekaaaaappja
aaaaoeiaafaaaaadabaaabiaaaaaffiaaeaaaakaafaaaaadabaaaiiaabaaaaia
bcaaaakaafaaaaadabaaafiaaaaapeiabcaaaakaacaaaaadaeaaadoaabaakkia
abaaomiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacaeaaamoaaaaaoeiappppaaaafdeieefcpeaeaaaaeaaaabaa
dnabaaaafjaaaaaeegiocaaaaaaaaaaabiaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaac
adaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaaabaaaaaaegbabaaa
adaaaaaadgaaaaafecaabaaaabaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaa
abaaaaaadgaaaaaghccabaaaabaaaaaaegacbaiaibaaaaaaabaaaaaadiaaaaai
hccabaaaacaaaaaaegacbaaaabaaaaaafgifcaaaaaaaaaaabbaaaaaadiaaaaai
bcaabaaaabaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaak
bcaabaaaabaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
abaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaacaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaacaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaabaaaaaadgaaaaagiccabaaaacaaaaaa
akaabaiaebaaaaaaabaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaaaeaaaaaa
egiacaaaaaaaaaaabhaaaaaaogikcaaaaaaaaaaabhaaaaaadiaaaaahhcaabaaa
abaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaa
jgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaa
acaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaal
hcaabaaaacaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaa
egacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaacaaaaaabcaaaaaa
kgikcaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaa
egacbaaaacaaaaaaegiccaaaacaaaaaabdaaaaaadcaaaaalhcaabaaaacaaaaaa
egacbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
baaaaaahcccabaaaaeaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaah
bccabaaaaeaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaa
aeaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaafaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaafaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaa
agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
keaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaakeaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaadamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaa
keaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
				}
				SubProgram "opengl " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
						"VERTEXLIGHT_ON"
					}
					Bind "vertex"
					Vertex
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Matrix 9[_Object2World]
					Vector 13[_WorldSpaceCameraPos]
					Vector 14[unity_4LightPosX0]
					Vector 15[unity_4LightPosY0]
					Vector 16[unity_4LightPosZ0]
					Vector 17[unity_4LightAtten0]
					Vector 18[unity_LightColor0]
					Vector 19[unity_LightColor1]
					Vector 20[unity_LightColor2]
					Vector 21[unity_LightColor3]
					Vector 22[unity_SHAr]
					Vector 23[unity_SHAg]
					Vector 24[unity_SHAb]
					Vector 25[unity_SHBr]
					Vector 26[unity_SHBg]
					Vector 27[unity_SHBb]
					Vector 28[unity_SHC]
					Vector 29[unity_Scale]
					Float 30[_tiling]
					"!!ARBvp1.0
PARAM c[31] = { { 1, 0 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..30] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MUL R3.xyz, vertex.normal, c[29].w;
DP3 R5.x, R3, c[9];
DP4 R4.zw, vertex.position, c[10];
ADD R2, -R4.z, c[15];
DP3 R4.z, R3, c[10];
DP3 R3.x, R3, c[11];
DP4 R3.w, vertex.position, c[9];
MUL R0, R4.z, R2;
ADD R1, -R3.w, c[14];
DP4 R4.xy, vertex.position, c[11];
MUL R2, R2, R2;
MOV R5.z, R3.x;
MOV R5.y, R4.z;
MOV R5.w, c[0].x;
MAD R0, R5.x, R1, R0;
MAD R2, R1, R1, R2;
ADD R1, -R4.x, c[16];
MAD R2, R1, R1, R2;
MAD R0, R3.x, R1, R0;
MUL R1, R2, c[17];
ADD R1, R1, c[0].x;
MOV result.texcoord[2].z, R3.x;
RSQ R2.x, R2.x;
RSQ R2.y, R2.y;
RSQ R2.z, R2.z;
RSQ R2.w, R2.w;
MUL R0, R0, R2;
DP4 R2.z, R5, c[24];
DP4 R2.y, R5, c[23];
DP4 R2.x, R5, c[22];
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].y;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[19];
MAD R1.xyz, R0.x, c[18], R1;
MAD R0.xyz, R0.z, c[20], R1;
MAD R1.xyz, R0.w, c[21], R0;
MUL R0, R5.xyzz, R5.yzzx;
DP4 R5.w, R0, c[27];
DP4 R5.z, R0, c[26];
DP4 R5.y, R0, c[25];
MUL R0.x, R4.z, R4.z;
MAD R1.w, R5.x, R5.x, -R0.x;
ADD R2.xyz, R2, R5.yzww;
MUL R5.yzw, R1.w, c[28].xxyz;
ADD R2.xyz, R2, R5.yzww;
MOV R0.z, vertex.texcoord[1].x;
MOV R0.xy, vertex.texcoord[0];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
ABS result.texcoord[0].xyz, R0;
MUL result.texcoord[1].xyz, R0, c[30].x;
DP4 R0.x, vertex.position, c[3];
MOV R3.x, R4.w;
MOV R3.y, R4;
ADD result.texcoord[3].xyz, R2, R1;
MOV result.texcoord[2].y, R4.z;
MOV result.texcoord[2].x, R5;
ADD result.texcoord[4].xyz, -R3.wxyw, c[13];
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
MOV result.texcoord[1].w, -R0.x;
END
# 68 instructions, 6 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
						"VERTEXLIGHT_ON"
					}
					Bind "vertex"
					Vertex
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 8[_Object2World]
					Vector 12[_WorldSpaceCameraPos]
					Vector 13[unity_4LightPosX0]
					Vector 14[unity_4LightPosY0]
					Vector 15[unity_4LightPosZ0]
					Vector 16[unity_4LightAtten0]
					Vector 17[unity_LightColor0]
					Vector 18[unity_LightColor1]
					Vector 19[unity_LightColor2]
					Vector 20[unity_LightColor3]
					Vector 21[unity_SHAr]
					Vector 22[unity_SHAg]
					Vector 23[unity_SHAb]
					Vector 24[unity_SHBr]
					Vector 25[unity_SHBg]
					Vector 26[unity_SHBb]
					Vector 27[unity_SHC]
					Vector 28[unity_Scale]
					Float 29[_tiling]
					"vs_2_0
def c30, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
mul r3.xyz, v1, c28.w
dp3 r5.x, r3, c8
dp4 r4.zw, v0, c9
add r2, -r4.z, c14
dp3 r4.z, r3, c9
dp3 r3.x, r3, c10
dp4 r3.w, v0, c8
mul r0, r4.z, r2
add r1, -r3.w, c13
dp4 r4.xy, v0, c10
mul r2, r2, r2
mov r5.z, r3.x
mov r5.y, r4.z
mov r5.w, c30.x
mad r0, r5.x, r1, r0
mad r2, r1, r1, r2
add r1, -r4.x, c15
mad r2, r1, r1, r2
mad r0, r3.x, r1, r0
mul r1, r2, c16
add r1, r1, c30.x
mov oT2.z, r3.x
rsq r2.x, r2.x
rsq r2.y, r2.y
rsq r2.z, r2.z
rsq r2.w, r2.w
mul r0, r0, r2
dp4 r2.z, r5, c23
dp4 r2.y, r5, c22
dp4 r2.x, r5, c21
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c30.y
mul r0, r0, r1
mul r1.xyz, r0.y, c18
mad r1.xyz, r0.x, c17, r1
mad r0.xyz, r0.z, c19, r1
mad r1.xyz, r0.w, c20, r0
mul r0, r5.xyzz, r5.yzzx
dp4 r5.w, r0, c26
dp4 r5.z, r0, c25
dp4 r5.y, r0, c24
mul r0.x, r4.z, r4.z
mad r1.w, r5.x, r5.x, -r0.x
add r2.xyz, r2, r5.yzww
mul r5.yzw, r1.w, c27.xxyz
add r2.xyz, r2, r5.yzww
mov r0.z, v3.x
mov r0.xy, v2
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
abs oT0.xyz, r0
mul oT1.xyz, r0, c29.x
dp4 r0.x, v0, c2
mov r3.x, r4.w
mov r3.y, r4
add oT3.xyz, r2, r1
mov oT2.y, r4.z
mov oT2.x, r5
add oT4.xyz, -r3.wxyw, c12
dp4 oPos.w, v0, c7
dp4 oPos.z, v0, c6
dp4 oPos.y, v0, c5
dp4 oPos.x, v0, c4
mov oT1.w, -r0.x
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
						"VERTEXLIGHT_ON"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					304
					Float 212[_tiling]
					ConstBuffer "UnityPerCamera"
					128
					Vector 64[_WorldSpaceCameraPos] 3
					ConstBuffer "UnityLighting"
					720
					Vector 32[unity_4LightPosX0]
					Vector 48[unity_4LightPosY0]
					Vector 64[unity_4LightPosZ0]
					Vector 80[unity_4LightAtten0]
					Vector 96[unity_LightColor0]
					Vector 112[unity_LightColor1]
					Vector 128[unity_LightColor2]
					Vector 144[unity_LightColor3]
					Vector 160[unity_LightColor4]
					Vector 176[unity_LightColor5]
					Vector 192[unity_LightColor6]
					Vector 208[unity_LightColor7]
					Vector 608[unity_SHAr]
					Vector 624[unity_SHAg]
					Vector 640[unity_SHAb]
					Vector 656[unity_SHBr]
					Vector 672[unity_SHBg]
					Vector 688[unity_SHBb]
					Vector 704[unity_SHC]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 192[_Object2World]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityLighting"
					2
					BindCB "UnityPerDraw"
					3 "vs_4_0
eefiecedbdldnbibhkehpfcecogildndhmnnlkjaabaaaaaaaiakaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcfeaiaaaaeaaaabaabfacaaaafjaaaaae
egiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaadbcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacagaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaa
aaaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaabaaaaaaegacbaiaibaaaaaa
aaaaaaaadiaaaaaihccabaaaacaaaaaaegacbaaaaaaaaaaafgifcaaaaaaaaaaa
anaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
iccabaaaacaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
egbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaa
egiicaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaa
aaaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaaaaaaaaadgaaaaaficaabaaa
aaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaaacaaaaaa
cgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaaacaaaaaa
chaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaaacaaaaaa
ciaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaa
egakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaa
egaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaa
egaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaa
egaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
adaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaakicaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaacmaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgbfbaaa
aaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaacaaaaaaaaaaaaajpcaabaaaadaaaaaafgafbaiaebaaaaaaacaaaaaa
egiocaaaacaaaaaaadaaaaaadiaaaaahpcaabaaaaeaaaaaafgafbaaaaaaaaaaa
egaobaaaadaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaa
adaaaaaaaaaaaaajpcaabaaaafaaaaaaagaabaiaebaaaaaaacaaaaaaegiocaaa
acaaaaaaacaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaaafaaaaaaagaabaaa
aaaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaaafaaaaaa
egaobaaaafaaaaaaegaobaaaadaaaaaaaaaaaaajpcaabaaaafaaaaaakgakbaia
ebaaaaaaacaaaaaaegiocaaaacaaaaaaaeaaaaaaaaaaaaajhccabaaaafaaaaaa
egacbaiaebaaaaaaacaaaaaaegiccaaaabaaaaaaaeaaaaaadcaaaaajpcaabaaa
aaaaaaaaegaobaaaafaaaaaakgakbaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaaj
pcaabaaaacaaaaaaegaobaaaafaaaaaaegaobaaaafaaaaaaegaobaaaadaaaaaa
eeaaaaafpcaabaaaadaaaaaaegaobaaaacaaaaaadcaaaaanpcaabaaaacaaaaaa
egaobaaaacaaaaaaegiocaaaacaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpaoaaaaakpcaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpegaobaaaacaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaadaaaaaadeaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaa
egaobaaaacaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaa
aaaaaaaaegiccaaaacaaaaaaahaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
acaaaaaaagaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaaiaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaajaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaahhccabaaaaeaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
						"VERTEXLIGHT_ON"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					304
					Float 212[_tiling]
					ConstBuffer "UnityPerCamera"
					128
					Vector 64[_WorldSpaceCameraPos] 3
					ConstBuffer "UnityLighting"
					720
					Vector 32[unity_4LightPosX0]
					Vector 48[unity_4LightPosY0]
					Vector 64[unity_4LightPosZ0]
					Vector 80[unity_4LightAtten0]
					Vector 96[unity_LightColor0]
					Vector 112[unity_LightColor1]
					Vector 128[unity_LightColor2]
					Vector 144[unity_LightColor3]
					Vector 160[unity_LightColor4]
					Vector 176[unity_LightColor5]
					Vector 192[unity_LightColor6]
					Vector 208[unity_LightColor7]
					Vector 608[unity_SHAr]
					Vector 624[unity_SHAg]
					Vector 640[unity_SHAb]
					Vector 656[unity_SHBr]
					Vector 672[unity_SHBg]
					Vector 688[unity_SHBb]
					Vector 704[unity_SHC]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 192[_Object2World]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityLighting"
					2
					BindCB "UnityPerDraw"
					3 "vs_4_0_level_9_1
eefiecedepfmfnabbfkpjbcpnpjmojhbmlafefagabaaaaaaaeapaaaaaeaaaaaa
daaaaaaaciafaaaaieanaaaaemaoaaaaebgpgodjpaaeaaaapaaeaaaaaaacpopp
heaeaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaanaa
abaaabaaaaaaaaaaabaaaeaaabaaacaaaaaaaaaaacaaacaaaiaaadaaaaaaaaaa
acaacgaaahaaalaaaaaaaaaaadaaaaaaaiaabcaaaaaaaaaaadaaamaaaeaabkaa
aaaaaaaaadaabeaaabaaboaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafbpaaapka
aaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaaciaacaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeiaaeaaapja
abaaaaacaaaaadiaadaaoejaabaaaaacaaaaaeiaaeaaaajaceaaaaacabaaahia
aaaaoeiacdaaaaacaaaaahoaabaaoeiaafaaaaadabaaahoaabaaoeiaabaaffka
afaaaaadaaaaabiaaaaaffjabhaakkkaaeaaaaaeaaaaabiabgaakkkaaaaaaaja
aaaaaaiaaeaaaaaeaaaaabiabiaakkkaaaaakkjaaaaaaaiaaeaaaaaeaaaaabia
bjaakkkaaaaappjaaaaaaaiaabaaaaacabaaaioaaaaaaaibafaaaaadaaaaahia
aaaaffjablaaoekaaeaaaaaeaaaaahiabkaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaahiabmaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahiabnaaoekaaaaappja
aaaaoeiaacaaaaadaeaaahoaaaaaoeibacaaoekaacaaaaadabaaapiaaaaaffib
aeaaoekaafaaaaadacaaapiaabaaoeiaabaaoeiaacaaaaadadaaapiaaaaaaaib
adaaoekaacaaaaadaaaaapiaaaaakkibafaaoekaaeaaaaaeacaaapiaadaaoeia
adaaoeiaacaaoeiaaeaaaaaeacaaapiaaaaaoeiaaaaaoeiaacaaoeiaahaaaaac
aeaaabiaacaaaaiaahaaaaacaeaaaciaacaaffiaahaaaaacaeaaaeiaacaakkia
ahaaaaacaeaaaiiaacaappiaabaaaaacafaaabiabpaaaakaaeaaaaaeacaaapia
acaaoeiaagaaoekaafaaaaiaafaaaaadafaaahiaacaaoejaboaappkaafaaaaad
agaaahiaafaaffiablaaoekaaeaaaaaeafaaaliabkaakekaafaaaaiaagaakeia
aeaaaaaeafaaahiabmaaoekaafaakkiaafaapeiaafaaaaadabaaapiaabaaoeia
afaaffiaaeaaaaaeabaaapiaadaaoeiaafaaaaiaabaaoeiaaeaaaaaeaaaaapia
aaaaoeiaafaakkiaabaaoeiaafaaaaadaaaaapiaaeaaoeiaaaaaoeiaalaaaaad
aaaaapiaaaaaoeiabpaaffkaagaaaaacabaaabiaacaaaaiaagaaaaacabaaacia
acaaffiaagaaaaacabaaaeiaacaakkiaagaaaaacabaaaiiaacaappiaafaaaaad
aaaaapiaaaaaoeiaabaaoeiaafaaaaadabaaahiaaaaaffiaaiaaoekaaeaaaaae
abaaahiaahaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiaajaaoekaaaaakkia
abaaoeiaaeaaaaaeaaaaahiaakaaoekaaaaappiaaaaaoeiaabaaaaacafaaaiia
bpaaaakaajaaaaadabaaabiaalaaoekaafaaoeiaajaaaaadabaaaciaamaaoeka
afaaoeiaajaaaaadabaaaeiaanaaoekaafaaoeiaafaaaaadacaaapiaafaacjia
afaakeiaajaaaaadadaaabiaaoaaoekaacaaoeiaajaaaaadadaaaciaapaaoeka
acaaoeiaajaaaaadadaaaeiabaaaoekaacaaoeiaacaaaaadabaaahiaabaaoeia
adaaoeiaafaaaaadaaaaaiiaafaaffiaafaaffiaaeaaaaaeaaaaaiiaafaaaaia
afaaaaiaaaaappibabaaaaacacaaahoaafaaoeiaaeaaaaaeabaaahiabbaaoeka
aaaappiaabaaoeiaacaaaaadadaaahoaaaaaoeiaabaaoeiaafaaaaadaaaaapia
aaaaffjabdaaoekaaeaaaaaeaaaaapiabcaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiabeaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiabfaaoekaaaaappja
aaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiappppaaaafdeieefcfeaiaaaaeaaaabaabfacaaaafjaaaaaeegiocaaa
aaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
bcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacagaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaaaaaaaaaa
egbabaaaadaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaaghccabaaaabaaaaaaegacbaiaibaaaaaaaaaaaaaa
diaaaaaihccabaaaacaaaaaaegacbaaaaaaaaaaafgifcaaaaaaaaaaaanaaaaaa
diaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaa
ckbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
adaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaagiccabaaa
acaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaa
adaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaa
dgaaaaafhccabaaaadaaaaaaegacbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaa
abeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaaacaaaaaacgaaaaaa
egaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaaacaaaaaachaaaaaa
egaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaaacaaaaaaciaaaaaa
egaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaa
aaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaa
acaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaa
acaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaa
acaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaa
diaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaak
icaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgbfbaaaaaaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaa
egiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
acaaaaaaaaaaaaajpcaabaaaadaaaaaafgafbaiaebaaaaaaacaaaaaaegiocaaa
acaaaaaaadaaaaaadiaaaaahpcaabaaaaeaaaaaafgafbaaaaaaaaaaaegaobaaa
adaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaaadaaaaaa
aaaaaaajpcaabaaaafaaaaaaagaabaiaebaaaaaaacaaaaaaegiocaaaacaaaaaa
acaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaaafaaaaaaagaabaaaaaaaaaaa
egaobaaaaeaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaaafaaaaaaegaobaaa
afaaaaaaegaobaaaadaaaaaaaaaaaaajpcaabaaaafaaaaaakgakbaiaebaaaaaa
acaaaaaaegiocaaaacaaaaaaaeaaaaaaaaaaaaajhccabaaaafaaaaaaegacbaia
ebaaaaaaacaaaaaaegiccaaaabaaaaaaaeaaaaaadcaaaaajpcaabaaaaaaaaaaa
egaobaaaafaaaaaakgakbaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaa
acaaaaaaegaobaaaafaaaaaaegaobaaaafaaaaaaegaobaaaadaaaaaaeeaaaaaf
pcaabaaaadaaaaaaegaobaaaacaaaaaadcaaaaanpcaabaaaacaaaaaaegaobaaa
acaaaaaaegiocaaaacaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpaoaaaaakpcaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpegaobaaaacaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaadaaaaaadeaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
acaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaaaaaaaaa
egiccaaaacaaaaaaahaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaa
agaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaacaaaaaaaiaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaajaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaahhccabaaaaeaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
doaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaiaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklkl"
				}
				SubProgram "opengl " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
						"VERTEXLIGHT_ON"
					}
					Bind "vertex"
					Vertex
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Matrix 9[_Object2World]
					Vector 13[_WorldSpaceCameraPos]
					Vector 14[_ProjectionParams]
					Vector 15[unity_4LightPosX0]
					Vector 16[unity_4LightPosY0]
					Vector 17[unity_4LightPosZ0]
					Vector 18[unity_4LightAtten0]
					Vector 19[unity_LightColor0]
					Vector 20[unity_LightColor1]
					Vector 21[unity_LightColor2]
					Vector 22[unity_LightColor3]
					Vector 23[unity_SHAr]
					Vector 24[unity_SHAg]
					Vector 25[unity_SHAb]
					Vector 26[unity_SHBr]
					Vector 27[unity_SHBg]
					Vector 28[unity_SHBb]
					Vector 29[unity_SHC]
					Vector 30[unity_Scale]
					Float 31[_tiling]
					"!!ARBvp1.0
PARAM c[32] = { { 1, 0, 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..31] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MUL R3.xyz, vertex.normal, c[30].w;
DP3 R5.x, R3, c[9];
DP4 R4.zw, vertex.position, c[10];
ADD R2, -R4.z, c[16];
DP3 R4.z, R3, c[10];
DP3 R3.x, R3, c[11];
DP4 R3.w, vertex.position, c[9];
MUL R0, R4.z, R2;
ADD R1, -R3.w, c[15];
DP4 R4.xy, vertex.position, c[11];
MUL R2, R2, R2;
MOV R5.z, R3.x;
MOV R5.y, R4.z;
MOV R5.w, c[0].x;
MAD R0, R5.x, R1, R0;
MAD R2, R1, R1, R2;
ADD R1, -R4.x, c[17];
MAD R2, R1, R1, R2;
MAD R0, R3.x, R1, R0;
MUL R1, R2, c[18];
ADD R1, R1, c[0].x;
MOV result.texcoord[2].z, R3.x;
RSQ R2.x, R2.x;
RSQ R2.y, R2.y;
RSQ R2.z, R2.z;
RSQ R2.w, R2.w;
MUL R0, R0, R2;
DP4 R2.z, R5, c[25];
DP4 R2.y, R5, c[24];
DP4 R2.x, R5, c[23];
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
MUL R0, R5.xyzz, R5.yzzx;
MUL R1.w, R4.z, R4.z;
DP4 R5.w, R0, c[28];
DP4 R5.z, R0, c[27];
DP4 R5.y, R0, c[26];
MAD R1.w, R5.x, R5.x, -R1;
MUL R0.xyz, R1.w, c[29];
ADD R2.xyz, R2, R5.yzww;
ADD R2.xyz, R2, R0;
ADD result.texcoord[3].xyz, R2, R1;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R5.yzw, R0.xxyw, c[0].z;
MOV R1.z, vertex.texcoord[1].x;
MOV R1.xy, vertex.texcoord[0];
DP3 R0.z, R1, R1;
RSQ R1.w, R0.z;
DP4 R0.z, vertex.position, c[7];
MUL R1.xyz, R1.w, R1;
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
MOV R2.x, R5.y;
MUL R2.y, R5.z, c[14].x;
MOV R3.y, R4;
MOV R3.x, R4.w;
ADD result.texcoord[5].xy, R2, R5.w;
ABS result.texcoord[0].xyz, R1;
MUL result.texcoord[1].xyz, R1, c[31].x;
MOV result.texcoord[5].zw, R0;
MOV result.texcoord[2].y, R4.z;
MOV result.texcoord[2].x, R5;
ADD result.texcoord[4].xyz, -R3.wxyw, c[13];
MOV result.texcoord[1].w, -R0.x;
END
# 74 instructions, 6 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
						"VERTEXLIGHT_ON"
					}
					Bind "vertex"
					Vertex
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 8[_Object2World]
					Vector 12[_WorldSpaceCameraPos]
					Vector 13[_ProjectionParams]
					Vector 14[_ScreenParams]
					Vector 15[unity_4LightPosX0]
					Vector 16[unity_4LightPosY0]
					Vector 17[unity_4LightPosZ0]
					Vector 18[unity_4LightAtten0]
					Vector 19[unity_LightColor0]
					Vector 20[unity_LightColor1]
					Vector 21[unity_LightColor2]
					Vector 22[unity_LightColor3]
					Vector 23[unity_SHAr]
					Vector 24[unity_SHAg]
					Vector 25[unity_SHAb]
					Vector 26[unity_SHBr]
					Vector 27[unity_SHBg]
					Vector 28[unity_SHBb]
					Vector 29[unity_SHC]
					Vector 30[unity_Scale]
					Float 31[_tiling]
					"vs_2_0
def c32, 1.00000000, 0.00000000, 0.50000000, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
mul r3.xyz, v1, c30.w
dp3 r5.x, r3, c8
dp4 r4.zw, v0, c9
add r2, -r4.z, c16
dp3 r4.z, r3, c9
dp3 r3.x, r3, c10
dp4 r3.w, v0, c8
mul r0, r4.z, r2
add r1, -r3.w, c15
dp4 r4.xy, v0, c10
mul r2, r2, r2
mov r5.z, r3.x
mov r5.y, r4.z
mov r5.w, c32.x
mad r0, r5.x, r1, r0
mad r2, r1, r1, r2
add r1, -r4.x, c17
mad r2, r1, r1, r2
mad r0, r3.x, r1, r0
mul r1, r2, c18
add r1, r1, c32.x
mov oT2.z, r3.x
rsq r2.x, r2.x
rsq r2.y, r2.y
rsq r2.z, r2.z
rsq r2.w, r2.w
mul r0, r0, r2
dp4 r2.z, r5, c25
dp4 r2.y, r5, c24
dp4 r2.x, r5, c23
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c32.y
mul r0, r0, r1
mul r1.xyz, r0.y, c20
mad r1.xyz, r0.x, c19, r1
mad r0.xyz, r0.z, c21, r1
mad r1.xyz, r0.w, c22, r0
mul r0, r5.xyzz, r5.yzzx
mul r1.w, r4.z, r4.z
dp4 r5.w, r0, c28
dp4 r5.z, r0, c27
dp4 r5.y, r0, c26
mad r1.w, r5.x, r5.x, -r1
mul r0.xyz, r1.w, c29
add r2.xyz, r2, r5.yzww
add r2.xyz, r2, r0
add oT3.xyz, r2, r1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r5.yzw, r0.xxyw, c32.z
mov r1.z, v3.x
mov r1.xy, v2
dp3 r0.z, r1, r1
rsq r1.w, r0.z
dp4 r0.z, v0, c6
mul r1.xyz, r1.w, r1
mov oPos, r0
dp4 r0.x, v0, c2
mov r2.x, r5.y
mul r2.y, r5.z, c13.x
mov r3.y, r4
mov r3.x, r4.w
mad oT5.xy, r5.w, c14.zwzw, r2
abs oT0.xyz, r1
mul oT1.xyz, r1, c31.x
mov oT5.zw, r0
mov oT2.y, r4.z
mov oT2.x, r5
add oT4.xyz, -r3.wxyw, c12
mov oT1.w, -r0.x
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
						"VERTEXLIGHT_ON"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					368
					Float 276[_tiling]
					ConstBuffer "UnityPerCamera"
					128
					Vector 64[_WorldSpaceCameraPos] 3
					Vector 80[_ProjectionParams]
					ConstBuffer "UnityLighting"
					720
					Vector 32[unity_4LightPosX0]
					Vector 48[unity_4LightPosY0]
					Vector 64[unity_4LightPosZ0]
					Vector 80[unity_4LightAtten0]
					Vector 96[unity_LightColor0]
					Vector 112[unity_LightColor1]
					Vector 128[unity_LightColor2]
					Vector 144[unity_LightColor3]
					Vector 160[unity_LightColor4]
					Vector 176[unity_LightColor5]
					Vector 192[unity_LightColor6]
					Vector 208[unity_LightColor7]
					Vector 608[unity_SHAr]
					Vector 624[unity_SHAg]
					Vector 640[unity_SHAb]
					Vector 656[unity_SHBr]
					Vector 672[unity_SHBg]
					Vector 688[unity_SHBb]
					Vector 704[unity_SHC]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 192[_Object2World]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityLighting"
					2
					BindCB "UnityPerDraw"
					3 "vs_4_0
eefiecedglikajhmgkghebhafdjikglcgedckoinabaaaaaaliakaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcomaiaaaaeaaaabaadlacaaaafjaaaaaeegiocaaaaaaaaaaa
bcaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
cnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadbcbabaaa
aeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagiaaaaac
ahaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaaabaaaaaaegbabaaa
adaaaaaadgaaaaafecaabaaaabaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaa
abaaaaaadgaaaaaghccabaaaabaaaaaaegacbaiaibaaaaaaabaaaaaadiaaaaai
hccabaaaacaaaaaaegacbaaaabaaaaaafgifcaaaaaaaaaaabbaaaaaadiaaaaai
bcaabaaaabaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaak
bcaabaaaabaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
abaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaadaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaadaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaabaaaaaadgaaaaagiccabaaaacaaaaaa
akaabaiaebaaaaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaacaaaaaa
pgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaabaaaaaaegiicaaaadaaaaaa
amaaaaaaagaabaaaabaaaaaaegaibaaaacaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaaoaaaaaakgakbaaaabaaaaaaegadbaaaabaaaaaadgaaaaaf
hccabaaaadaaaaaaegacbaaaabaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaa
aaaaiadpbbaaaaaibcaabaaaacaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaa
abaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaa
abaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaa
abaaaaaadiaaaaahpcaabaaaadaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaa
bbaaaaaibcaabaaaaeaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaadaaaaaa
bbaaaaaiccaabaaaaeaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaadaaaaaa
bbaaaaaiecaabaaaaeaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaadaaaaaa
aaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaah
icaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakicaabaaa
abaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaa
dcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaaabaaaaaa
egacbaaaacaaaaaadiaaaaaihcaabaaaadaaaaaafgbfbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaa
adaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaadaaaaaa
aaaaaaajpcaabaaaaeaaaaaafgafbaiaebaaaaaaadaaaaaaegiocaaaacaaaaaa
adaaaaaadiaaaaahpcaabaaaafaaaaaafgafbaaaabaaaaaaegaobaaaaeaaaaaa
diaaaaahpcaabaaaaeaaaaaaegaobaaaaeaaaaaaegaobaaaaeaaaaaaaaaaaaaj
pcaabaaaagaaaaaaagaabaiaebaaaaaaadaaaaaaegiocaaaacaaaaaaacaaaaaa
dcaaaaajpcaabaaaafaaaaaaegaobaaaagaaaaaaagaabaaaabaaaaaaegaobaaa
afaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaaagaaaaaaegaobaaaagaaaaaa
egaobaaaaeaaaaaaaaaaaaajpcaabaaaagaaaaaakgakbaiaebaaaaaaadaaaaaa
egiocaaaacaaaaaaaeaaaaaaaaaaaaajhccabaaaafaaaaaaegacbaiaebaaaaaa
adaaaaaaegiccaaaabaaaaaaaeaaaaaadcaaaaajpcaabaaaabaaaaaaegaobaaa
agaaaaaakgakbaaaabaaaaaaegaobaaaafaaaaaadcaaaaajpcaabaaaadaaaaaa
egaobaaaagaaaaaaegaobaaaagaaaaaaegaobaaaaeaaaaaaeeaaaaafpcaabaaa
aeaaaaaaegaobaaaadaaaaaadcaaaaanpcaabaaaadaaaaaaegaobaaaadaaaaaa
egiocaaaacaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
aoaaaaakpcaabaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
egaobaaaadaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaa
aeaaaaaadeaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaadaaaaaa
egaobaaaabaaaaaadiaaaaaihcaabaaaadaaaaaafgafbaaaabaaaaaaegiccaaa
acaaaaaaahaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaaagaaaaaa
agaabaaaabaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaaiaaaaaakgakbaaaabaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaacaaaaaaajaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
aaaaaaahhccabaaaaeaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaafmccabaaaagaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaa
agaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
						"VERTEXLIGHT_ON"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					368
					Float 276[_tiling]
					ConstBuffer "UnityPerCamera"
					128
					Vector 64[_WorldSpaceCameraPos] 3
					Vector 80[_ProjectionParams]
					ConstBuffer "UnityLighting"
					720
					Vector 32[unity_4LightPosX0]
					Vector 48[unity_4LightPosY0]
					Vector 64[unity_4LightPosZ0]
					Vector 80[unity_4LightAtten0]
					Vector 96[unity_LightColor0]
					Vector 112[unity_LightColor1]
					Vector 128[unity_LightColor2]
					Vector 144[unity_LightColor3]
					Vector 160[unity_LightColor4]
					Vector 176[unity_LightColor5]
					Vector 192[unity_LightColor6]
					Vector 208[unity_LightColor7]
					Vector 608[unity_SHAr]
					Vector 624[unity_SHAg]
					Vector 640[unity_SHAb]
					Vector 656[unity_SHBr]
					Vector 672[unity_SHBg]
					Vector 688[unity_SHBb]
					Vector 704[unity_SHC]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 192[_Object2World]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityLighting"
					2
					BindCB "UnityPerDraw"
					3 "vs_4_0_level_9_1
eefiecedlpcedgpgdifjaebhjjloomdpmgbjjndnabaaaaaaaabaaaaaaeaaaaaa
daaaaaaaheafaaaagiaoaaaadaapaaaaebgpgodjdmafaaaadmafaaaaaaacpopp
maaeaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaabbaa
abaaabaaaaaaaaaaabaaaeaaacaaacaaaaaaaaaaacaaacaaaiaaaeaaaaaaaaaa
acaacgaaahaaamaaaaaaaaaaadaaaaaaaiaabdaaaaaaaaaaadaaamaaaeaablaa
aaaaaaaaadaabeaaabaabpaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafcaaaapka
aaaaiadpaaaaaaaaaaaaaadpaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaaciaacaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeiaaeaaapja
abaaaaacaaaaadiaadaaoejaabaaaaacaaaaaeiaaeaaaajaceaaaaacabaaahia
aaaaoeiacdaaaaacaaaaahoaabaaoeiaafaaaaadabaaahoaabaaoeiaabaaffka
afaaaaadaaaaabiaaaaaffjabiaakkkaaeaaaaaeaaaaabiabhaakkkaaaaaaaja
aaaaaaiaaeaaaaaeaaaaabiabjaakkkaaaaakkjaaaaaaaiaaeaaaaaeaaaaabia
bkaakkkaaaaappjaaaaaaaiaabaaaaacabaaaioaaaaaaaibafaaaaadaaaaahia
aaaaffjabmaaoekaaeaaaaaeaaaaahiablaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaahiabnaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahiaboaaoekaaaaappja
aaaaoeiaacaaaaadaeaaahoaaaaaoeibacaaoekaacaaaaadabaaapiaaaaaffib
afaaoekaafaaaaadacaaapiaabaaoeiaabaaoeiaacaaaaadadaaapiaaaaaaaib
aeaaoekaacaaaaadaaaaapiaaaaakkibagaaoekaaeaaaaaeacaaapiaadaaoeia
adaaoeiaacaaoeiaaeaaaaaeacaaapiaaaaaoeiaaaaaoeiaacaaoeiaahaaaaac
aeaaabiaacaaaaiaahaaaaacaeaaaciaacaaffiaahaaaaacaeaaaeiaacaakkia
ahaaaaacaeaaaiiaacaappiaabaaaaacafaaabiacaaaaakaaeaaaaaeacaaapia
acaaoeiaahaaoekaafaaaaiaafaaaaadafaaahiaacaaoejabpaappkaafaaaaad
agaaahiaafaaffiabmaaoekaaeaaaaaeafaaaliablaakekaafaaaaiaagaakeia
aeaaaaaeafaaahiabnaaoekaafaakkiaafaapeiaafaaaaadabaaapiaabaaoeia
afaaffiaaeaaaaaeabaaapiaadaaoeiaafaaaaiaabaaoeiaaeaaaaaeaaaaapia
aaaaoeiaafaakkiaabaaoeiaafaaaaadaaaaapiaaeaaoeiaaaaaoeiaalaaaaad
aaaaapiaaaaaoeiacaaaffkaagaaaaacabaaabiaacaaaaiaagaaaaacabaaacia
acaaffiaagaaaaacabaaaeiaacaakkiaagaaaaacabaaaiiaacaappiaafaaaaad
aaaaapiaaaaaoeiaabaaoeiaafaaaaadabaaahiaaaaaffiaajaaoekaaeaaaaae
abaaahiaaiaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiaakaaoekaaaaakkia
abaaoeiaaeaaaaaeaaaaahiaalaaoekaaaaappiaaaaaoeiaabaaaaacafaaaiia
caaaaakaajaaaaadabaaabiaamaaoekaafaaoeiaajaaaaadabaaaciaanaaoeka
afaaoeiaajaaaaadabaaaeiaaoaaoekaafaaoeiaafaaaaadacaaapiaafaacjia
afaakeiaajaaaaadadaaabiaapaaoekaacaaoeiaajaaaaadadaaaciabaaaoeka
acaaoeiaajaaaaadadaaaeiabbaaoekaacaaoeiaacaaaaadabaaahiaabaaoeia
adaaoeiaafaaaaadaaaaaiiaafaaffiaafaaffiaaeaaaaaeaaaaaiiaafaaaaia
afaaaaiaaaaappibabaaaaacacaaahoaafaaoeiaaeaaaaaeabaaahiabcaaoeka
aaaappiaabaaoeiaacaaaaadadaaahoaaaaaoeiaabaaoeiaafaaaaadaaaaapia
aaaaffjabeaaoekaaeaaaaaeaaaaapiabdaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiabfaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiabgaaoekaaaaappja
aaaaoeiaafaaaaadabaaabiaaaaaffiaadaaaakaafaaaaadabaaaiiaabaaaaia
caaakkkaafaaaaadabaaafiaaaaapeiacaaakkkaacaaaaadafaaadoaabaakkia
abaaomiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacafaaamoaaaaaoeiappppaaaafdeieefcomaiaaaaeaaaabaa
dlacaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaadbcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadpccabaaaagaaaaaagiaaaaacahaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaabaaaaaa
akbabaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaabaaaaaa
egacbaiaibaaaaaaabaaaaaadiaaaaaihccabaaaacaaaaaaegacbaaaabaaaaaa
fgifcaaaaaaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaaaaaaaaa
ckiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaadaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaa
ckiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaak
bcaabaaaabaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
abaaaaaadgaaaaagiccabaaaacaaaaaaakaabaiaebaaaaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaai
hcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
lcaabaaaabaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaabaaaaaaegaibaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaa
abaaaaaaegadbaaaabaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaabaaaaaa
dgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaa
egiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaaacaaaaaa
egiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaaacaaaaaa
egiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaadaaaaaa
jgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaa
acaaaaaacjaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaa
acaaaaaackaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaa
acaaaaaaclaaaaaaegaobaaaadaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaaabaaaaaabkaabaaaabaaaaaa
bkaabaaaabaaaaaadcaaaaakicaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaa
abaaaaaadkaabaiaebaaaaaaabaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
acaaaaaacmaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaihcaabaaa
adaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
adaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaadaaaaaa
dcaaaaakhcaabaaaadaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaadaaaaaaaaaaaaajpcaabaaaaeaaaaaafgafbaia
ebaaaaaaadaaaaaaegiocaaaacaaaaaaadaaaaaadiaaaaahpcaabaaaafaaaaaa
fgafbaaaabaaaaaaegaobaaaaeaaaaaadiaaaaahpcaabaaaaeaaaaaaegaobaaa
aeaaaaaaegaobaaaaeaaaaaaaaaaaaajpcaabaaaagaaaaaaagaabaiaebaaaaaa
adaaaaaaegiocaaaacaaaaaaacaaaaaadcaaaaajpcaabaaaafaaaaaaegaobaaa
agaaaaaaagaabaaaabaaaaaaegaobaaaafaaaaaadcaaaaajpcaabaaaaeaaaaaa
egaobaaaagaaaaaaegaobaaaagaaaaaaegaobaaaaeaaaaaaaaaaaaajpcaabaaa
agaaaaaakgakbaiaebaaaaaaadaaaaaaegiocaaaacaaaaaaaeaaaaaaaaaaaaaj
hccabaaaafaaaaaaegacbaiaebaaaaaaadaaaaaaegiccaaaabaaaaaaaeaaaaaa
dcaaaaajpcaabaaaabaaaaaaegaobaaaagaaaaaakgakbaaaabaaaaaaegaobaaa
afaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaaagaaaaaaegaobaaaagaaaaaa
egaobaaaaeaaaaaaeeaaaaafpcaabaaaaeaaaaaaegaobaaaadaaaaaadcaaaaan
pcaabaaaadaaaaaaegaobaaaadaaaaaaegiocaaaacaaaaaaafaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaadaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaadaaaaaadiaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaaeaaaaaadeaaaaakpcaabaaaabaaaaaa
egaobaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaah
pcaabaaaabaaaaaaegaobaaaadaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaa
adaaaaaafgafbaaaabaaaaaaegiccaaaacaaaaaaahaaaaaadcaaaaakhcaabaaa
adaaaaaaegiccaaaacaaaaaaagaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaiaaaaaakgakbaaaabaaaaaa
egacbaaaadaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaajaaaaaa
pgapbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaahhccabaaaaeaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaagaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaagaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
laaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaa
feeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaa
laaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaapaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaa
lmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaaaeaaaaaa
aaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaa
agaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
				}
			}
			Program "fp" {
				SubProgram "opengl " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
					}
					Vector 0[_WorldSpaceLightPos0]
					Vector 1[_LightColor0]
					Vector 2[_SpecColor]
					Float 3[_Mix]
					Vector 4[_Color]
					Vector 5[_ColorFromSpace]
					Float 6[_Shininess]
					Float 7[_Gloss]
					Float 8[_fadeStart]
					Float 9[_fadeEnd]
					Float 10[_PlanetOpacity]
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1 "!!ARBfp1.0
PARAM c[13] = { program.local[0..10],
		{ 2, 3, 0, 128 },
		{ 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R5.xyz, fragment.texcoord[1].zyzw, texture[0], 2D;
TEX R2.xyz, fragment.texcoord[1].zyzw, texture[1], 2D;
TEX R3.xyz, fragment.texcoord[1].zxzw, texture[0], 2D;
TEX R0.xyz, fragment.texcoord[1].zxzw, texture[1], 2D;
TEX R1.xyz, fragment.texcoord[1], texture[1], 2D;
TEX R4.xyz, fragment.texcoord[1], texture[0], 2D;
MUL R2.xyz, fragment.texcoord[0].x, R2;
MAD R1.xyz, fragment.texcoord[0].z, R1, R2;
MUL R5.xyz, fragment.texcoord[0].x, R5;
MAD R4.xyz, fragment.texcoord[0].z, R4, R5;
MAD R0.xyz, R0, fragment.texcoord[0].y, R1;
MAD R2.xyz, fragment.texcoord[0].y, R3, R4;
ADD R1.xyz, R0, -R2;
MOV R0.x, c[8];
MAD R1.xyz, R1, c[3].x, R2;
ADD R0.w, -R0.x, c[9].x;
MUL R0.xyz, -R1, c[4];
RCP R1.x, R0.w;
ADD R0.w, fragment.texcoord[1], -c[8].x;
MUL_SAT R0.w, R0, R1.x;
MAD R1.w, -R0, c[11].x, c[11].y;
MUL R0.w, R0, R0;
MUL R0.w, R0, R1;
ADD R1.xyz, R0, c[5];
MAD R1.xyz, R0.w, R1, -R0;
DP3 R0.w, fragment.texcoord[4], fragment.texcoord[4];
RSQ R0.w, R0.w;
MAD R2.xyz, R0.w, fragment.texcoord[4], c[0];
DP3 R1.w, fragment.texcoord[2], c[0];
DP3 R0.w, R2, R2;
MUL R0.xyz, R1, c[1];
MAX R1.w, R1, c[11].z;
MUL R3.xyz, R0, R1.w;
RSQ R1.w, R0.w;
MUL R2.xyz, R1.w, R2;
MOV R0, c[2];
MOV R1.w, c[11];
DP3 R2.x, fragment.texcoord[2], R2;
MUL R2.y, R1.w, c[6].x;
MAX R1.w, R2.x, c[11].z;
POW R1.w, R1.w, R2.y;
MUL R1.w, R1, c[7].x;
MUL R0.xyz, R0, c[1];
MAD R0.xyz, R0, R1.w, R3;
MUL R0.w, R0, c[1];
MUL R0.xyz, R0, c[11].x;
MAD R0.w, R1, R0, -c[10].x;
MAD result.color.xyz, R1, fragment.texcoord[3], R0;
ADD result.color.w, R0, c[12].x;
END
# 49 instructions, 6 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
					}
					Vector 0[_WorldSpaceLightPos0]
					Vector 1[_LightColor0]
					Vector 2[_SpecColor]
					Float 3[_Mix]
					Vector 4[_Color]
					Vector 5[_ColorFromSpace]
					Float 6[_Shininess]
					Float 7[_Gloss]
					Float 8[_fadeStart]
					Float 9[_fadeEnd]
					Float 10[_PlanetOpacity]
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1 "ps_2_0
dcl_2d s0
dcl_2d s1
def c11, 2.00000000, 3.00000000, 0.00000000, 128.00000000
def c12, 1.00000000, 0, 0, 0
dcl t0.xyz
dcl t1
dcl t2.xyz
dcl t3.xyz
dcl t4.xyz
texld r4, t1, s1
mov r3.xy, t1.zxyw
mov r2.xy, t1.zxyw
mov r1.y, t1
mov r1.x, t1.z
mov r0.y, t1
mov r0.x, t1.z
texld r5, r3, s1
texld r3, r1, s1
texld r0, r0, s0
texld r2, r2, s0
texld r1, t1, s0
mul r0.xyz, t0.x, r0
mad r0.xyz, t0.z, r1, r0
mul r1.xyz, t0.x, r3
mad r0.xyz, t0.y, r2, r0
mad r1.xyz, t0.z, r4, r1
mad r1.xyz, r5, t0.y, r1
add r1.xyz, r1, -r0
mad r0.xyz, r1, c3.x, r0
mul r3.xyz, -r0, c4
dp3_pp r1.x, t4, t4
rsq_pp r1.x, r1.x
mov r0.x, c9
add r4.xyz, r3, c5
mad_pp r5.xyz, r1.x, t4, c0
add r0.x, -c8, r0
rcp r1.x, r0.x
add r0.x, t1.w, -c8
mul_sat r2.x, r0, r1
mad r1.x, -r2, c11, c11.y
mul r2.x, r2, r2
mul r1.x, r2, r1
mad r2.xyz, r1.x, r4, -r3
dp3_pp r0.x, r5, r5
rsq_pp r0.x, r0.x
mul_pp r1.xyz, r0.x, r5
dp3_pp r1.x, t2, r1
mov_pp r0.x, c6
mul_pp r0.x, c11.w, r0
max_pp r1.x, r1, c11.z
pow r4.w, r1.x, r0.x
dp3_pp r0.x, t2, c0
max_pp r1.x, r0, c11.z
mov r0.x, r4.w
mul_pp r3.xyz, r2, c1
mul_pp r3.xyz, r3, r1.x
mov_pp r1.xyz, c1
mul_pp r4.xyz, c2, r1
mul r0.x, r0, c7
mov_pp r0.w, c1
mul_pp r1.x, c2.w, r0.w
mad r3.xyz, r4, r0.x, r3
mad r0.x, r0, r1, -c10
add r0.w, r0.x, c12.x
mul r1.xyz, r3, c11.x
mad_pp r0.xyz, r2, t3, r1
mov_pp oC0, r0
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
					}
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					ConstBuffer "$Globals"
					304
					Vector 16[_LightColor0]
					Vector 32[_SpecColor]
					Float 48[_Mix]
					Vector 80[_Color]
					Vector 96[_ColorFromSpace]
					Float 128[_Shininess]
					Float 132[_Gloss]
					Float 204[_fadeStart]
					Float 208[_fadeEnd]
					Float 288[_PlanetOpacity]
					ConstBuffer "UnityLighting"
					720
					Vector 0[_WorldSpaceLightPos0]
					BindCB "$Globals"
					0
					BindCB "UnityLighting"
					1 "ps_4_0
eefiecedjkpohokdgmlbhhkppicjhfbdolhhgljeabaaaaaameahaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckeagaaaa
eaaaaaaakjabaaaafjaaaaaeegiocaaaaaaaaaaabdaaaaaafjaaaaaeegiocaaa
abaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaggbkbaaa
acaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
acaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaabaaaaaakgbkbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaacgbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaabaaaaaafgbfbaaaabaaaaaaegacbaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaggbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaakgbkbaaaabaaaaaa
egacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaacgbkbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaa
fgbfbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaagiacaaa
aaaaaaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaadcaaaaamhcaabaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaaegiccaaa
aaaaaaaaagaaaaaaaaaaaaakicaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaa
amaaaaaaakiacaaaaaaaaaaaanaaaaaaaoaaaaakicaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaaaaaaaaaaaaaaaajicaabaaa
abaaaaaadkbabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaaamaaaaaadicaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajicaabaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaakhcaabaaaacaaaaaaegbcbaaaafaaaaaapgapbaaa
aaaaaaaaegiccaaaabaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaacaaaaaadeaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaaiicaabaaaabaaaaaaakiacaaaaaaaaaaaaiaaaaaa
abeaaaaaaaaaaaeddiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
abaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaadiaaaaajpcaabaaa
acaaaaaaegiocaaaaaaaaaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaadiaaaaah
hcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaabaaaaaaiicaabaaa
abaaaaaaegbcbaaaadaaaaaaegiccaaaabaaaaaaaaaaaaaadeaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaa
egacbaaaabaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaadcaaaaajhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaajbcaabaaa
aaaaaaaaakiacaiaebaaaaaaaaaaaaaabcaaaaaaabeaaaaaaaaaiadpdcaaaaaj
iccabaaaaaaaaaaadkaabaaaacaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaa
doaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
					}
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					ConstBuffer "$Globals"
					304
					Vector 16[_LightColor0]
					Vector 32[_SpecColor]
					Float 48[_Mix]
					Vector 80[_Color]
					Vector 96[_ColorFromSpace]
					Float 128[_Shininess]
					Float 132[_Gloss]
					Float 204[_fadeStart]
					Float 208[_fadeEnd]
					Float 288[_PlanetOpacity]
					ConstBuffer "UnityLighting"
					720
					Vector 0[_WorldSpaceLightPos0]
					BindCB "$Globals"
					0
					BindCB "UnityLighting"
					1 "ps_4_0_level_9_1
eefiecedljfbnabelcmnpfmakooncpblbimpkhpbabaaaaaabaamaaaaaeaaaaaa
daaaaaaahiaeaaaacealaaaanmalaaaaebgpgodjeaaeaaaaeaaeaaaaaaacpppp
mmadaaaaheaaaaaaagaacmaaaaaaheaaaaaaheaaacaaceaaaaaaheaaaaaaaaaa
abababaaaaaaabaaadaaaaaaaaaaaaaaaaaaafaaacaaadaaaaaaaaaaaaaaaiaa
abaaafaaaaaaaaaaaaaaamaaacaaagaaaaaaaaaaaaaabcaaabaaaiaaaaaaaaaa
abaaaaaaabaaajaaaaaaaaaaaaacppppfbaaaaafakaaapkaaaaaaamaaaaaeaea
aaaaiadpaaaaaaaafbaaaaafalaaapkaaaaaaaedaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaahlabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaia
acaachlabpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaaiaaeaachlabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaabaaaaacaaaaabiaabaakkla
abaaaaacaaaaaciaabaafflaabaaaaacabaaadiaabaanclaecaaaaadacaaapia
abaaoelaaaaioekaecaaaaadadaaapiaaaaaoeiaaaaioekaecaaaaadaaaaapia
aaaaoeiaabaioekaecaaaaadaeaaapiaabaaoeiaaaaioekaecaaaaadabaaapia
abaaoeiaabaioekaecaaaaadafaaapiaabaaoelaabaioekaafaaaaadaaaaahia
aaaaoeiaaaaaaalaafaaaaadadaaahiaadaaoeiaaaaaaalaaeaaaaaeacaaahia
acaaoeiaaaaakklaadaaoeiaaeaaaaaeacaaahiaaeaaoeiaaaaafflaacaaoeia
aeaaaaaeaaaaahiaafaaoeiaaaaakklaaaaaoeiaaeaaaaaeaaaaahiaabaaoeia
aaaafflaaaaaoeiabcaaaaaeabaaahiaacaaaakaaaaaoeiaacaaoeiaafaaaaad
aaaaahiaabaaoeiaadaaoekaabaaaaacacaaahiaadaaoekaaeaaaaaeabaaahia
abaaoeiaacaaoeibaeaaoekaabaaaaacaaaaaiiaagaappkaacaaaaadaaaaaiia
aaaappibahaaaakaagaaaaacaaaaaiiaaaaappiaacaaaaadabaaaiiaabaappla
agaappkbafaaaaadaaaabiiaaaaappiaabaappiaaeaaaaaeabaaaiiaaaaappia
akaaaakaakaaffkaafaaaaadaaaaaiiaaaaappiaaaaappiaafaaaaadaaaaaiia
aaaappiaabaappiaaeaaaaaeaaaachiaaaaappiaabaaoeiaaaaaoeiaafaaaaad
abaachiaaaaaoeiaaaaaoekaaiaaaaadaaaaciiaaeaaoelaaeaaoelaahaaaaac
aaaaciiaaaaappiaaeaaaaaeacaachiaaeaaoelaaaaappiaajaaoekaceaaaaac
adaachiaacaaoeiaaiaaaaadaaaaciiaacaaoelaadaaoeiaalaaaaadabaaaiia
aaaappiaakaappkaabaaaaacaaaaaiiaafaaaakaafaaaaadaaaaaiiaaaaappia
alaaaakacaaaaaadacaaabiaabaappiaaaaappiaafaaaaadaaaaaiiaacaaaaia
afaaffkaabaaaaacacaaapiaaaaaoekaafaaaaadacaaahiaacaaoeiaabaaoeka
afaaaaadacaaahiaaaaappiaacaaoeiaaiaaaaadabaaciiaacaaoelaajaaoeka
alaaaaadadaacbiaabaappiaakaappkaaeaaaaaeabaaahiaabaaoeiaadaaaaia
acaaoeiaacaaaaadabaachiaabaaoeiaabaaoeiaaeaaaaaeabaachiaaaaaoeia
adaaoelaabaaoeiaabaaaaacaaaaaeiaakaakkkaacaaaaadaaaacbiaaaaakkia
aiaaaakbafaaaaadaaaaaciaacaappiaabaappkaaeaaaaaeabaaciiaaaaaffia
aaaappiaaaaaaaiaabaaaaacaaaicpiaabaaoeiappppaaaafdeieefckeagaaaa
eaaaaaaakjabaaaafjaaaaaeegiocaaaaaaaaaaabdaaaaaafjaaaaaeegiocaaa
abaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaggbkbaaa
acaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
acaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaabaaaaaakgbkbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaacgbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaabaaaaaafgbfbaaaabaaaaaaegacbaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaggbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaakgbkbaaaabaaaaaa
egacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaacgbkbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaa
fgbfbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaagiacaaa
aaaaaaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaadcaaaaamhcaabaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaaegiccaaa
aaaaaaaaagaaaaaaaaaaaaakicaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaa
amaaaaaaakiacaaaaaaaaaaaanaaaaaaaoaaaaakicaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaaaaaaaaaaaaaaaajicaabaaa
abaaaaaadkbabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaaamaaaaaadicaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajicaabaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaakhcaabaaaacaaaaaaegbcbaaaafaaaaaapgapbaaa
aaaaaaaaegiccaaaabaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaacaaaaaadeaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaaiicaabaaaabaaaaaaakiacaaaaaaaaaaaaiaaaaaa
abeaaaaaaaaaaaeddiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
abaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaadiaaaaajpcaabaaa
acaaaaaaegiocaaaaaaaaaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaadiaaaaah
hcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaabaaaaaaiicaabaaa
abaaaaaaegbcbaaaadaaaaaaegiccaaaabaaaaaaaaaaaaaadeaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaa
egacbaaaabaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaadcaaaaajhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaajbcaabaaa
aaaaaaaaakiacaiaebaaaaaaaaaaaaaabcaaaaaaabeaaaaaaaaaiadpdcaaaaaj
iccabaaaaaaaaaaadkaabaaaacaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaa
doaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
ahahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapapaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
				}
				SubProgram "opengl " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
					}
					Float 0[_Mix]
					Vector 1[_Color]
					Vector 2[_ColorFromSpace]
					Float 3[_fadeStart]
					Float 4[_fadeEnd]
					Float 5[_PlanetOpacity]
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[unity_Lightmap] 2D 2 "!!ARBfp1.0
PARAM c[7] = { program.local[0..5],
		{ 1, 2, 3, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEX R0, fragment.texcoord[2], texture[2], 2D;
TEX R6.xyz, fragment.texcoord[1].zyzw, texture[0], 2D;
TEX R3.xyz, fragment.texcoord[1].zyzw, texture[1], 2D;
TEX R1.xyz, fragment.texcoord[1].zxzw, texture[1], 2D;
TEX R4.xyz, fragment.texcoord[1].zxzw, texture[0], 2D;
TEX R2.xyz, fragment.texcoord[1], texture[1], 2D;
TEX R5.xyz, fragment.texcoord[1], texture[0], 2D;
MUL R3.xyz, fragment.texcoord[0].x, R3;
MAD R2.xyz, fragment.texcoord[0].z, R2, R3;
MUL R6.xyz, fragment.texcoord[0].x, R6;
MAD R5.xyz, fragment.texcoord[0].z, R5, R6;
MOV R1.w, c[3].x;
MAD R1.xyz, R1, fragment.texcoord[0].y, R2;
MAD R3.xyz, fragment.texcoord[0].y, R4, R5;
ADD R1.w, -R1, c[4].x;
RCP R2.x, R1.w;
ADD R1.xyz, R1, -R3;
MAD R1.xyz, R1, c[0].x, R3;
ADD R1.w, fragment.texcoord[1], -c[3].x;
MUL_SAT R1.w, R1, R2.x;
MUL R1.xyz, -R1, c[1];
MAD R2.w, -R1, c[6].y, c[6].z;
MUL R1.w, R1, R1;
MUL R0.xyz, R0.w, R0;
ADD R2.xyz, R1, c[2];
MUL R1.w, R1, R2;
MAD R1.xyz, R1.w, R2, -R1;
MUL R1.xyz, R0, R1;
MOV R0.x, c[6];
MUL result.color.xyz, R1, c[6].w;
ADD result.color.w, R0.x, -c[5].x;
END
# 31 instructions, 7 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
					}
					Float 0[_Mix]
					Vector 1[_Color]
					Vector 2[_ColorFromSpace]
					Float 3[_fadeStart]
					Float 4[_fadeEnd]
					Float 5[_PlanetOpacity]
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[unity_Lightmap] 2D 2 "ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c6, 1.00000000, 2.00000000, 3.00000000, 8.00000000
dcl t0.xyz
dcl t1
dcl t2.xy
texld r5, t1, s1
mov r4.xy, t1.zxyw
mov r3.xy, t1.zxyw
mov r1.y, t1
mov r1.x, t1.z
mov r2.xy, r1
mov r0.y, t1
mov r0.x, t1.z
texld r6, r4, s1
texld r4, r2, s1
texld r1, t2, s2
texld r3, r3, s0
texld r0, r0, s0
texld r2, t1, s0
mul r0.xyz, t0.x, r0
mad r0.xyz, t0.z, r2, r0
mul r2.xyz, t0.x, r4
mad r0.xyz, t0.y, r3, r0
mul_pp r1.xyz, r1.w, r1
mad r2.xyz, t0.z, r5, r2
mad r2.xyz, r6, t0.y, r2
add r2.xyz, r2, -r0
mad r2.xyz, r2, c0.x, r0
mul r3.xyz, -r2, c1
mov r0.x, c4
add r0.x, -c3, r0
rcp r2.x, r0.x
add r0.x, t1.w, -c3
mul_sat r2.x, r0, r2
mad r0.x, -r2, c6.y, c6.z
mul r2.x, r2, r2
add r4.xyz, r3, c2
mul r0.x, r2, r0
mad r0.xyz, r0.x, r4, -r3
mul_pp r1.xyz, r1, r0
mov r0.x, c5
mul_pp r1.xyz, r1, c6.w
add r1.w, c6.x, -r0.x
mov_pp oC0, r1
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
					}
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[unity_Lightmap] 2D 2
					ConstBuffer "$Globals"
					320
					Float 48[_Mix]
					Vector 80[_Color]
					Vector 96[_ColorFromSpace]
					Float 204[_fadeStart]
					Float 208[_fadeEnd]
					Float 288[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedpncpbmabmfeglpldohjliblionaodhpmabaaaaaahmafaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcimaeaaaaeaaaaaaacdabaaaafjaaaaaeegiocaaa
aaaaaaaabdaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
hcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
ggbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaabaaaaaakgbkbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaacgbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaafgbfbaaaabaaaaaaegacbaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaggbkbaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaakgbkbaaa
abaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaacgbkbaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
acaaaaaafgbfbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaa
agiacaaaaaaaaaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaadcaaaaam
hcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaa
egiccaaaaaaaaaaaagaaaaaaaaaaaaakicaabaaaaaaaaaaadkiacaiaebaaaaaa
aaaaaaaaamaaaaaaakiacaaaaaaaaaaaanaaaaaaaoaaaaakicaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaaaaaaaaaaaaaaaaj
icaabaaaabaaaaaadkbabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaaamaaaaaa
dicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaaj
icaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaea
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaadiaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajiccabaaaaaaaaaaa
akiacaiaebaaaaaaaaaaaaaabcaaaaaaabeaaaaaaaaaiadpdoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
					}
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[unity_Lightmap] 2D 2
					ConstBuffer "$Globals"
					320
					Float 48[_Mix]
					Vector 80[_Color]
					Vector 96[_ColorFromSpace]
					Float 204[_fadeStart]
					Float 208[_fadeEnd]
					Float 288[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0_level_9_1
eefiecedgidpdhknenaccckaegjhkjcimhmhfpababaaaaaaiaaiaaaaaeaaaaaa
daaaaaaadaadaaaameahaaaaemaiaaaaebgpgodjpiacaaaapiacaaaaaaacpppp
jiacaaaagaaaaaaaaeaadaaaaaaagaaaaaaagaaaadaaceaaaaaagaaaaaaaaaaa
abababaaacacacaaaaaaadaaabaaaaaaaaaaaaaaaaaaafaaacaaabaaaaaaaaaa
aaaaamaaacaaadaaaaaaaaaaaaaabcaaabaaafaaaaaaaaaaaaacppppfbaaaaaf
agaaapkaaaaaaamaaaaaeaeaaaaaaaebaaaaiadpbpaaaaacaaaaaaiaaaaaahla
bpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaiaacaaadlabpaaaaacaaaaaaja
aaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaabaaaaac
aaaaabiaabaakklaabaaaaacaaaaaciaabaafflaabaaaaacabaaadiaabaancla
ecaaaaadacaaapiaabaaoelaaaaioekaecaaaaadadaaapiaaaaaoeiaaaaioeka
ecaaaaadaaaaapiaaaaaoeiaabaioekaecaaaaadaeaaapiaabaaoeiaaaaioeka
ecaaaaadabaaapiaabaaoeiaabaioekaecaaaaadafaaapiaabaaoelaabaioeka
ecaaaaadagaacpiaacaaoelaacaioekaafaaaaadaaaaahiaaaaaoeiaaaaaaala
afaaaaadadaaahiaadaaoeiaaaaaaalaaeaaaaaeacaaahiaacaaoeiaaaaakkla
adaaoeiaaeaaaaaeacaaahiaaeaaoeiaaaaafflaacaaoeiaaeaaaaaeaaaaahia
afaaoeiaaaaakklaaaaaoeiaaeaaaaaeaaaaahiaabaaoeiaaaaafflaaaaaoeia
bcaaaaaeabaaahiaaaaaaakaaaaaoeiaacaaoeiaafaaaaadaaaaahiaabaaoeia
abaaoekaabaaaaacacaaahiaabaaoekaaeaaaaaeabaaahiaabaaoeiaacaaoeib
acaaoekaabaaaaacaaaaaiiaadaappkaacaaaaadaaaaaiiaaaaappibaeaaaaka
agaaaaacaaaaaiiaaaaappiaacaaaaadabaaaiiaabaapplaadaappkbafaaaaad
aaaabiiaaaaappiaabaappiaaeaaaaaeabaaaiiaaaaappiaagaaaakaagaaffka
afaaaaadaaaaaiiaaaaappiaaaaappiaafaaaaadaaaaaiiaaaaappiaabaappia
aeaaaaaeaaaachiaaaaappiaabaaoeiaaaaaoeiaafaaaaadaaaaciiaagaappia
agaakkkaafaaaaadabaachiaagaaoeiaaaaappiaafaaaaadaaaachiaaaaaoeia
abaaoeiaabaaaaacabaaaiiaagaappkaacaaaaadaaaaaiiaabaappiaafaaaakb
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcimaeaaaaeaaaaaaacdabaaaa
fjaaaaaeegiocaaaaaaaaaaabdaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaad
dcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaggbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaagbabaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaakgbkbaaaabaaaaaaegacbaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaacgbkbaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaafgbfbaaa
abaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaggbkbaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
acaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
cgbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaa
abaaaaaaegacbaaaacaaaaaafgbfbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaai
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaagiacaaaaaaaaaaaadaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
afaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaa
aaaaaaaaafaaaaaaegiccaaaaaaaaaaaagaaaaaaaaaaaaakicaabaaaaaaaaaaa
dkiacaiaebaaaaaaaaaaaaaaamaaaaaaakiacaaaaaaaaaaaanaaaaaaaoaaaaak
icaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaa
aaaaaaaaaaaaaaajicaabaaaabaaaaaadkbabaaaacaaaaaadkiacaiaebaaaaaa
aaaaaaaaamaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaa
dcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaa
aaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
diaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaaj
iccabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaabcaaaaaaabeaaaaaaaaaiadp
doaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
ahahaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapapaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
				}
				SubProgram "opengl " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
					}
					Vector 0[_SpecColor]
					Float 1[_Mix]
					Vector 2[_Color]
					Vector 3[_ColorFromSpace]
					Float 4[_Shininess]
					Float 5[_Gloss]
					Float 6[_fadeStart]
					Float 7[_fadeEnd]
					Float 8[_PlanetOpacity]
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[unity_Lightmap] 2D 2
					SetTexture 3[unity_LightmapInd] 2D 3 "!!ARBfp1.0
PARAM c[13] = { program.local[0..8],
		{ 1, 2, 3, 8 },
		{ -0.40824828, -0.70710677, 0.57735026, 0 },
		{ 0.81649655, 0, 0.57735026, 128 },
		{ -0.40824831, 0.70710677, 0.57735026 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEX R0, fragment.texcoord[2], texture[2], 2D;
TEX R1, fragment.texcoord[2], texture[3], 2D;
TEX R4.xyz, fragment.texcoord[1].zyzw, texture[1], 2D;
TEX R5.xyz, fragment.texcoord[1].zxzw, texture[0], 2D;
TEX R6.xyz, fragment.texcoord[1], texture[0], 2D;
TEX R7.xyz, fragment.texcoord[1].zyzw, texture[0], 2D;
TEX R2.xyz, fragment.texcoord[1].zxzw, texture[1], 2D;
TEX R3.xyz, fragment.texcoord[1], texture[1], 2D;
MUL R0.xyz, R0.w, R0;
MUL R4.xyz, fragment.texcoord[0].x, R4;
MAD R3.xyz, fragment.texcoord[0].z, R3, R4;
MAD R2.xyz, R2, fragment.texcoord[0].y, R3;
MUL R1.xyz, R1.w, R1;
MUL R1.xyz, R1, c[9].w;
MUL R4.xyz, R1.y, c[12];
MUL R3.xyz, fragment.texcoord[0].x, R7;
MAD R3.xyz, fragment.texcoord[0].z, R6, R3;
MAD R3.xyz, fragment.texcoord[0].y, R5, R3;
ADD R2.xyz, R2, -R3;
MAD R2.xyz, R2, c[1].x, R3;
MUL R2.xyz, -R2, c[2];
MAD R4.xyz, R1.x, c[11], R4;
MAD R1.xyz, R1.z, c[10], R4;
DP3 R1.w, R1, R1;
RSQ R2.w, R1.w;
DP3 R1.w, fragment.texcoord[3], fragment.texcoord[3];
MOV R0.w, c[11];
ADD R3.xyz, R2, c[3];
RSQ R1.w, R1.w;
MUL R1.xyz, R2.w, R1;
MAD R1.xyz, R1.w, fragment.texcoord[3], R1;
DP3 R1.y, R1, R1;
MOV R1.w, c[6].x;
ADD R1.x, -R1.w, c[7];
RSQ R1.w, R1.y;
RCP R1.y, R1.x;
MUL R1.w, R1, R1.z;
ADD R1.x, fragment.texcoord[1].w, -c[6];
MUL_SAT R1.x, R1, R1.y;
MAD R1.y, -R1.x, c[9], c[9].z;
MUL R1.x, R1, R1;
MUL R1.x, R1, R1.y;
MAD R1.xyz, R1.x, R3, -R2;
MUL R0.xyz, R0, c[9].w;
MUL R2.xyz, R0, c[0];
MAX R1.w, R1, c[10];
MUL R0.w, R0, c[4].x;
POW R0.w, R1.w, R0.w;
MUL R2.xyz, R2, c[5].x;
MUL R2.xyz, R2, R0.w;
MOV R0.w, c[9].x;
MAD result.color.xyz, R1, R0, R2;
ADD result.color.w, R0, -c[8].x;
END
# 53 instructions, 8 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
					}
					Vector 0[_SpecColor]
					Float 1[_Mix]
					Vector 2[_Color]
					Vector 3[_ColorFromSpace]
					Float 4[_Shininess]
					Float 5[_Gloss]
					Float 6[_fadeStart]
					Float 7[_fadeEnd]
					Float 8[_PlanetOpacity]
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[unity_Lightmap] 2D 2
					SetTexture 3[unity_LightmapInd] 2D 3 "ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c9, 1.00000000, 2.00000000, 3.00000000, 8.00000000
def c10, -0.40824831, 0.70710677, 0.57735026, 0.00000000
def c11, 0.81649655, 0.00000000, 0.57735026, 128.00000000
def c12, -0.40824828, -0.70710677, 0.57735026, 0
dcl t0.xyz
dcl t1
dcl t2.xy
dcl t3.xyz
texld r1, t2, s2
texld r6, t1, s0
mov r4.xy, t1.zxyw
mov r0.y, t1
mov r0.x, t1.z
mov r2.xy, r0
mov r3.xy, t1.zxyw
mov r0.y, t1
mov r0.x, t1.z
texld r7, r4, s0
texld r5, r0, s0
texld r4, r3, s1
texld r0, t2, s3
texld r2, r2, s1
texld r3, t1, s1
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, c9.w
mul r2.xyz, t0.x, r2
mad r2.xyz, t0.z, r3, r2
mad r2.xyz, r4, t0.y, r2
mul r3.xyz, t0.x, r5
mul r4.xyz, r0.y, c10
mad r4.xyz, r0.x, c11, r4
mad r3.xyz, t0.z, r6, r3
mad r3.xyz, t0.y, r7, r3
add r2.xyz, r2, -r3
mad r2.xyz, r2, c1.x, r3
mad r3.xyz, r0.z, c12, r4
mul r4.xyz, -r2, c2
dp3 r0.x, r3, r3
rsq r2.x, r0.x
dp3_pp r0.x, t3, t3
mul r2.xyz, r2.x, r3
rsq_pp r0.x, r0.x
mad_pp r2.xyz, r0.x, t3, r2
dp3_pp r3.x, r2, r2
mov r0.x, c7
add r2.x, -c6, r0
rsq_pp r0.x, r3.x
rcp r3.x, r2.x
add r2.x, t1.w, -c6
mul_sat r2.x, r2, r3
mul_pp r0.z, r0.x, r2
mad r0.x, -r2, c9.y, c9.z
mul r2.x, r2, r2
mul r0.x, r2, r0
add r5.xyz, r4, c3
mad r3.xyz, r0.x, r5, -r4
mov_pp r2.x, c4
mul_pp r4.xyz, r1.w, r1
max_pp r0.x, r0.z, c10.w
mul_pp r2.x, c11.w, r2
pow r1.w, r0.x, r2.x
mul_pp r2.xyz, r4, c9.w
mov r0.x, r1.w
mul_pp r4.xyz, r2, c0
mul_pp r1.xyz, r4, c5.x
mul r1.xyz, r1, r0.x
mov r0.x, c8
mad_pp r1.xyz, r3, r2, r1
add r1.w, c9.x, -r0.x
mov_pp oC0, r1
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
					}
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[unity_Lightmap] 2D 2
					SetTexture 3[unity_LightmapInd] 2D 3
					ConstBuffer "$Globals"
					320
					Vector 32[_SpecColor]
					Float 48[_Mix]
					Vector 80[_Color]
					Vector 96[_ColorFromSpace]
					Float 128[_Shininess]
					Float 132[_Gloss]
					Float 204[_fadeStart]
					Float 208[_fadeEnd]
					Float 288[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedcncmgicflcpknppaaceiaibnompmkkhhabaaaaaahaaiaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcgiahaaaaeaaaaaaankabaaaafjaaaaaeegiocaaaaaaaaaaabdaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
pcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaadaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaakhcaabaaaabaaaaaafgafbaaa
aaaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaadcaaaaamlcaabaaa
aaaaaaaaagaabaaaaaaaaaaaaceaaaaaolaffbdpaaaaaaaaaaaaaaaadkmnbddp
egaibaaaabaaaaaadcaaaaamhcaabaaaaaaaaaaakgakbaaaaaaaaaaaaceaaaaa
olafnblopdaedflpdkmnbddpaaaaaaaaegadbaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaeaaaaaaegbcbaaa
aeaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaaagaabaaaabaaaaaaegbcbaaaaeaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaa
aaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
cpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaggbkbaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadiaaaaahocaabaaaaaaaaaaaagajbaaaabaaaaaaagbabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaajocaabaaaaaaaaaaaagajbaaaabaaaaaakgbkbaaa
abaaaaaafgaobaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaacgbkbaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaajocaabaaaaaaaaaaaagajbaaa
abaaaaaafgbfbaaaabaaaaaafgaobaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
ggbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaa
abaaaaaaegacbaaaacaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaacgbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaafgbfbaaaabaaaaaaegacbaaa
abaaaaaaaaaaaaaiocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaiaebaaaaaa
abaaaaaadcaaaaakocaabaaaaaaaaaaaagiacaaaaaaaaaaaadaaaaaafgaobaaa
aaaaaaaaagajbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaajgahbaaaaaaaaaaa
egiccaaaaaaaaaaaafaaaaaadcaaaaamocaabaaaaaaaaaaafgaobaiaebaaaaaa
aaaaaaaaagijcaaaaaaaaaaaafaaaaaaagijcaaaaaaaaaaaagaaaaaaaaaaaaak
icaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaamaaaaaaakiacaaaaaaaaaaa
anaaaaaaaoaaaaakicaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdkaabaaaabaaaaaaaaaaaaajbcaabaaaacaaaaaadkbabaaaacaaaaaa
dkiacaiaebaaaaaaaaaaaaaaamaaaaaadicaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaakaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
akaabaaaacaaaaaadcaaaaajocaabaaaaaaaaaaapgapbaaaabaaaaaafgaobaaa
aaaaaaaaagajbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaabaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
acaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaafgifcaaaaaaaaaaa
aiaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaa
jgahbaaaaaaaaaaaaaaaaaajiccabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaa
bcaaaaaaabeaaaaaaaaaiadpdoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
					}
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[unity_Lightmap] 2D 2
					SetTexture 3[unity_LightmapInd] 2D 3
					ConstBuffer "$Globals"
					320
					Vector 32[_SpecColor]
					Float 48[_Mix]
					Vector 80[_Color]
					Vector 96[_ColorFromSpace]
					Float 128[_Shininess]
					Float 132[_Gloss]
					Float 204[_fadeStart]
					Float 208[_fadeEnd]
					Float 288[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0_level_9_1
eefiecedgfbomajglcmmigefbjandcdkhjnjdemhabaaaaaaceanaaaaaeaaaaaa
daaaaaaaoaaeaaaafaamaaaapaamaaaaebgpgodjkiaeaaaakiaeaaaaaaacpppp
diaeaaaahaaaaaaaafaadeaaaaaahaaaaaaahaaaaeaaceaaaaaahaaaaaaaaaaa
abababaaacacacaaadadadaaaaaaacaaacaaaaaaaaaaaaaaaaaaafaaacaaacaa
aaaaaaaaaaaaaiaaabaaaeaaaaaaaaaaaaaaamaaacaaafaaaaaaaaaaaaaabcaa
abaaahaaaaaaaaaaaaacppppfbaaaaafaiaaapkaaaaaaamaaaaaeaeaaaaaaaeb
aaaaaaaafbaaaaafajaaapkaolaffbdpaaaaaaaadkmnbddpaaaaiadpfbaaaaaf
akaaapkaomafnblopdaedfdpdkmnbddpaaaaaaedfbaaaaafalaaapkaolafnblo
pdaedflpdkmnbddpaaaaaaaabpaaaaacaaaaaaiaaaaaahlabpaaaaacaaaaaaia
abaaaplabpaaaaacaaaaaaiaacaaadlabpaaaaacaaaaaaiaadaachlabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapka
bpaaaaacaaaaaajaadaiapkaecaaaaadaaaacpiaacaaoelaadaioekaecaaaaad
abaaapiaabaaoelaaaaioekaecaaaaadacaaapiaabaaoelaabaioekaecaaaaad
adaacpiaacaaoelaacaioekaafaaaaadaaaaciiaaaaappiaaiaakkkaafaaaaad
aaaachiaaaaaoeiaaaaappiaafaaaaadaeaaahiaaaaaffiaakaaoekaaeaaaaae
aeaaahiaaaaaaaiaajaaoekaaeaaoeiaaeaaaaaeaaaaahiaaaaakkiaalaaoeka
aeaaoeiaaiaaaaadaaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiiaaaaappia
ceaaaaacaeaachiaadaaoelaaeaaaaaeaaaachiaaaaaoeiaaaaappiaaeaaoeia
aiaaaaadabaaciiaaaaaoeiaaaaaoeiaahaaaaacabaaciiaabaappiaafaaaaad
abaaciiaaaaakkiaabaappiaalaaaaadacaaaiiaabaappiaaiaappkaabaaaaac
abaaaiiaaeaaaakaafaaaaadabaaaiiaabaappiaakaappkacaaaaaadaaaacbia
acaappiaabaappiaabaaaaacaeaaabiaabaakklaabaaaaacaeaaaciaabaaffla
abaaaaacafaaadiaabaanclaecaaaaadagaaapiaaeaaoeiaaaaioekaecaaaaad
aeaaapiaaeaaoeiaabaioekaecaaaaadahaaapiaafaaoeiaaaaioekaecaaaaad
afaaapiaafaaoeiaabaioekaafaaaaadaaaaaoiaaeaabliaaaaaaalaafaaaaad
aeaaahiaagaaoeiaaaaaaalaaeaaaaaeabaaahiaabaaoeiaaaaakklaaeaaoeia
aeaaaaaeabaaahiaahaaoeiaaaaafflaabaaoeiaaeaaaaaeaaaaaoiaacaablia
aaaakklaaaaaoeiaaeaaaaaeaaaaaoiaafaabliaaaaafflaaaaaoeiabcaaaaae
acaaahiaabaaaakaaaaabliaabaaoeiaafaaaaadaaaaaoiaacaabliaacaablka
abaaaaacabaaahiaacaaoekaaeaaaaaeabaaahiaacaaoeiaabaaoeibadaaoeka
abaaaaacabaaaiiaafaappkaacaaaaadabaaaiiaabaappibagaaaakaagaaaaac
abaaaiiaabaappiaacaaaaadacaaabiaabaapplaafaappkbafaaaaadabaabiia
abaappiaacaaaaiaaeaaaaaeacaaabiaabaappiaaiaaaakaaiaaffkaafaaaaad
abaaaiiaabaappiaabaappiaafaaaaadabaaaiiaabaappiaacaaaaiaaeaaaaae
aaaacoiaabaappiaabaabliaaaaaoeiaafaaaaadadaaciiaadaappiaaiaakkka
afaaaaadabaachiaadaaoeiaadaappiaafaaaaadaaaacoiaaaaaoeiaabaablia
afaaaaadabaachiaabaaoeiaaaaaoekaafaaaaadabaaahiaabaaoeiaaeaaffka
aeaaaaaeaaaachiaabaaoeiaaaaaaaiaaaaabliaabaaaaacabaaaiiaajaappka
acaaaaadaaaaaiiaabaappiaahaaaakbabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefcgiahaaaaeaaaaaaankabaaaafjaaaaaeegiocaaaaaaaaaaabdaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
pcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaadaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaakhcaabaaaabaaaaaafgafbaaa
aaaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaadcaaaaamlcaabaaa
aaaaaaaaagaabaaaaaaaaaaaaceaaaaaolaffbdpaaaaaaaaaaaaaaaadkmnbddp
egaibaaaabaaaaaadcaaaaamhcaabaaaaaaaaaaakgakbaaaaaaaaaaaaceaaaaa
olafnblopdaedflpdkmnbddpaaaaaaaaegadbaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaeaaaaaaegbcbaaa
aeaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaaagaabaaaabaaaaaaegbcbaaaaeaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaa
aaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
cpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaggbkbaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadiaaaaahocaabaaaaaaaaaaaagajbaaaabaaaaaaagbabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaajocaabaaaaaaaaaaaagajbaaaabaaaaaakgbkbaaa
abaaaaaafgaobaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaacgbkbaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaajocaabaaaaaaaaaaaagajbaaa
abaaaaaafgbfbaaaabaaaaaafgaobaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
ggbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaa
abaaaaaaegacbaaaacaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaacgbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaafgbfbaaaabaaaaaaegacbaaa
abaaaaaaaaaaaaaiocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaiaebaaaaaa
abaaaaaadcaaaaakocaabaaaaaaaaaaaagiacaaaaaaaaaaaadaaaaaafgaobaaa
aaaaaaaaagajbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaajgahbaaaaaaaaaaa
egiccaaaaaaaaaaaafaaaaaadcaaaaamocaabaaaaaaaaaaafgaobaiaebaaaaaa
aaaaaaaaagijcaaaaaaaaaaaafaaaaaaagijcaaaaaaaaaaaagaaaaaaaaaaaaak
icaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaamaaaaaaakiacaaaaaaaaaaa
anaaaaaaaoaaaaakicaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdkaabaaaabaaaaaaaaaaaaajbcaabaaaacaaaaaadkbabaaaacaaaaaa
dkiacaiaebaaaaaaaaaaaaaaamaaaaaadicaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaakaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
akaabaaaacaaaaaadcaaaaajocaabaaaaaaaaaaapgapbaaaabaaaaaafgaobaaa
aaaaaaaaagajbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaabaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
acaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaafgifcaaaaaaaaaaa
aiaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaa
jgahbaaaaaaaaaaaaaaaaaajiccabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaa
bcaaaaaaabeaaaaaaaaaiadpdoaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaa
iaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaahahaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaapapaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaa
imaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
				}
				SubProgram "opengl " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
					}
					Vector 0[_WorldSpaceLightPos0]
					Vector 1[_LightColor0]
					Vector 2[_SpecColor]
					Float 3[_Mix]
					Vector 4[_Color]
					Vector 5[_ColorFromSpace]
					Float 6[_Shininess]
					Float 7[_Gloss]
					Float 8[_fadeStart]
					Float 9[_fadeEnd]
					Float 10[_PlanetOpacity]
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_ShadowMapTexture] 2D 2 "!!ARBfp1.0
PARAM c[13] = { program.local[0..10],
		{ 2, 3, 0, 128 },
		{ 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEX R2.xyz, fragment.texcoord[1].zyzw, texture[1], 2D;
TEX R5.xyz, fragment.texcoord[1].zyzw, texture[0], 2D;
TEX R3.xyz, fragment.texcoord[1].zxzw, texture[0], 2D;
TXP R6.x, fragment.texcoord[5], texture[2], 2D;
TEX R0.xyz, fragment.texcoord[1].zxzw, texture[1], 2D;
TEX R1.xyz, fragment.texcoord[1], texture[1], 2D;
TEX R4.xyz, fragment.texcoord[1], texture[0], 2D;
MUL R2.xyz, fragment.texcoord[0].x, R2;
MAD R1.xyz, fragment.texcoord[0].z, R1, R2;
MUL R5.xyz, fragment.texcoord[0].x, R5;
MAD R4.xyz, fragment.texcoord[0].z, R4, R5;
MAD R0.xyz, R0, fragment.texcoord[0].y, R1;
MAD R2.xyz, fragment.texcoord[0].y, R3, R4;
ADD R1.xyz, R0, -R2;
MOV R0.x, c[8];
MAD R1.xyz, R1, c[3].x, R2;
ADD R0.w, -R0.x, c[9].x;
MUL R0.xyz, -R1, c[4];
RCP R1.x, R0.w;
ADD R0.w, fragment.texcoord[1], -c[8].x;
MUL_SAT R0.w, R0, R1.x;
MAD R1.w, -R0, c[11].x, c[11].y;
MUL R0.w, R0, R0;
MUL R0.w, R0, R1;
ADD R1.xyz, R0, c[5];
MAD R1.xyz, R0.w, R1, -R0;
DP3 R0.w, fragment.texcoord[4], fragment.texcoord[4];
RSQ R0.w, R0.w;
MAD R2.xyz, R0.w, fragment.texcoord[4], c[0];
DP3 R1.w, fragment.texcoord[2], c[0];
DP3 R0.w, R2, R2;
MUL R0.xyz, R1, c[1];
MAX R1.w, R1, c[11].z;
MUL R3.xyz, R0, R1.w;
RSQ R1.w, R0.w;
MUL R2.xyz, R1.w, R2;
MOV R0, c[2];
DP3 R2.x, fragment.texcoord[2], R2;
MOV R1.w, c[11];
MUL R2.y, R1.w, c[6].x;
MAX R1.w, R2.x, c[11].z;
MUL R2.x, R0.w, c[1].w;
POW R1.w, R1.w, R2.y;
MUL R1.w, R1, c[7].x;
MUL R0.xyz, R0, c[1];
MAD R0.xyz, R0, R1.w, R3;
MUL R0.w, R6.x, c[11].x;
MUL R0.xyz, R0, R0.w;
MUL R1.w, R1, R2.x;
MAD R0.w, R6.x, R1, -c[10].x;
MAD result.color.xyz, R1, fragment.texcoord[3], R0;
ADD result.color.w, R0, c[12].x;
END
# 52 instructions, 7 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
					}
					Vector 0[_WorldSpaceLightPos0]
					Vector 1[_LightColor0]
					Vector 2[_SpecColor]
					Float 3[_Mix]
					Vector 4[_Color]
					Vector 5[_ColorFromSpace]
					Float 6[_Shininess]
					Float 7[_Gloss]
					Float 8[_fadeStart]
					Float 9[_fadeEnd]
					Float 10[_PlanetOpacity]
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_ShadowMapTexture] 2D 2 "ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c11, 2.00000000, 3.00000000, 0.00000000, 128.00000000
def c12, 1.00000000, 0, 0, 0
dcl t0.xyz
dcl t1
dcl t2.xyz
dcl t3.xyz
dcl t4.xyz
dcl t5
texld r4, t1, s1
texldp r6, t5, s2
mov r3.xy, t1.zxyw
mov r2.xy, t1.zxyw
mov r1.y, t1
mov r1.x, t1.z
mov r0.y, t1
mov r0.x, t1.z
texld r5, r3, s1
texld r3, r1, s1
texld r0, r0, s0
texld r2, r2, s0
texld r1, t1, s0
mul r0.xyz, t0.x, r0
mad r0.xyz, t0.z, r1, r0
mul r1.xyz, t0.x, r3
mad r0.xyz, t0.y, r2, r0
mad r1.xyz, t0.z, r4, r1
mad r1.xyz, r5, t0.y, r1
add r1.xyz, r1, -r0
mad r0.xyz, r1, c3.x, r0
mul r3.xyz, -r0, c4
dp3_pp r0.x, t4, t4
rsq_pp r1.x, r0.x
mad_pp r5.xyz, r1.x, t4, c0
mov r0.x, c9
add r1.x, -c8, r0
rcp r2.x, r1.x
dp3_pp r0.x, r5, r5
add r1.x, t1.w, -c8
mul_sat r1.x, r1, r2
mad r2.x, -r1, c11, c11.y
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, r5
dp3_pp r0.x, t2, r0
mul r1.x, r1, r1
mul r1.x, r1, r2
add r4.xyz, r3, c5
mad r3.xyz, r1.x, r4, -r3
mov_pp r1.x, c6
max_pp r0.x, r0, c11.z
mul_pp r1.x, c11.w, r1
pow r4.x, r0.x, r1.x
dp3_pp r2.x, t2, c0
max_pp r0.x, r2, c11.z
mul_pp r5.xyz, r3, c1
mov_pp r2.xyz, c1
mul_pp r1.xyz, r5, r0.x
mov r0.x, r4.x
mul r0.x, r0, c7
mul_pp r2.xyz, c2, r2
mad r2.xyz, r2, r0.x, r1
mov_pp r0.w, c1
mul_pp r1.x, c2.w, r0.w
mul r0.x, r0, r1
mad r0.x, r6, r0, -c10
mul_pp r1.x, r6, c11
add r0.w, r0.x, c12.x
mul r1.xyz, r2, r1.x
mad_pp r0.xyz, r3, t3, r1
mov_pp oC0, r0
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
					}
					SetTexture 0[_WaterTex] 2D 1
					SetTexture 1[_WaterTex1] 2D 2
					SetTexture 2[_ShadowMapTexture] 2D 0
					ConstBuffer "$Globals"
					368
					Vector 16[_LightColor0]
					Vector 32[_SpecColor]
					Float 112[_Mix]
					Vector 144[_Color]
					Vector 160[_ColorFromSpace]
					Float 192[_Shininess]
					Float 196[_Gloss]
					Float 268[_fadeStart]
					Float 272[_fadeEnd]
					Float 352[_PlanetOpacity]
					ConstBuffer "UnityLighting"
					720
					Vector 0[_WorldSpaceLightPos0]
					BindCB "$Globals"
					0
					BindCB "UnityLighting"
					1 "ps_4_0
eefiecedcdbfjmhheiejoipplfmmgbmbpdclklfpabaaaaaagaaiaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcciahaaaaeaaaaaaamkabaaaa
fjaaaaaeegiocaaaaaaaaaaabhaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaa
gcbaaaadpcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadlcbabaaaagaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaggbkbaaa
acaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
acaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaabaaaaaakgbkbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaacgbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaabaaaaaafgbfbaaaabaaaaaaegacbaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaggbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaakgbkbaaaabaaaaaa
egacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaacgbkbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaa
fgbfbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaagiacaaa
aaaaaaaaahaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaamhcaabaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaaegiccaaa
aaaaaaaaakaaaaaaaaaaaaakicaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaa
baaaaaaaakiacaaaaaaaaaaabbaaaaaaaoaaaaakicaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaaaaaaaaaaaaaaaajicaabaaa
abaaaaaadkbabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaabaaaaaaadicaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajicaabaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegbcbaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaakhcaabaaaacaaaaaaegbcbaaaafaaaaaapgapbaaaaaaaaaaa
egiccaaaabaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaadaaaaaaegacbaaaacaaaaaadeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaaiicaabaaaabaaaaaaakiacaaaaaaaaaaaamaaaaaaabeaaaaa
aaaaaaeddiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaa
bjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaa
dkaabaaaaaaaaaaabkiacaaaaaaaaaaaamaaaaaadiaaaaajpcaabaaaacaaaaaa
egiocaaaaaaaaaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaadiaaaaahpcaabaaa
acaaaaaapgapbaaaaaaaaaaaegaobaaaacaaaaaabaaaaaaiicaabaaaaaaaaaaa
egbcbaaaadaaaaaaegiccaaaabaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaaaoaaaaahdcaabaaaacaaaaaa
egbabaaaagaaaaaapgbpbaaaagaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaa
acaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaa
akaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajbcaabaaaaaaaaaaa
akiacaiaebaaaaaaaaaaaaaabgaaaaaaabeaaaaaaaaaiadpdcaaaaajiccabaaa
aaaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaaakaabaaaaaaaaaaadoaaaaab
"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
					}
					SetTexture 0[_WaterTex] 2D 1
					SetTexture 1[_WaterTex1] 2D 2
					SetTexture 2[_ShadowMapTexture] 2D 0
					ConstBuffer "$Globals"
					368
					Vector 16[_LightColor0]
					Vector 32[_SpecColor]
					Float 112[_Mix]
					Vector 144[_Color]
					Vector 160[_ColorFromSpace]
					Float 192[_Shininess]
					Float 196[_Gloss]
					Float 268[_fadeStart]
					Float 272[_fadeEnd]
					Float 352[_PlanetOpacity]
					ConstBuffer "UnityLighting"
					720
					Vector 0[_WorldSpaceLightPos0]
					BindCB "$Globals"
					0
					BindCB "UnityLighting"
					1 "ps_4_0_level_9_1
eefieceddgojlekjnefbogmbkpiheljclcejccehabaaaaaacaanaaaaaeaaaaaa
daaaaaaaomaeaaaabmamaaaaomamaaaaebgpgodjleaeaaaaleaeaaaaaaacpppp
daaeaaaaieaaaaaaahaadaaaaaaaieaaaaaaieaaadaaceaaaaaaieaaacaaaaaa
aaababaaabacacaaaaaaabaaacaaaaaaaaaaaaaaaaaaahaaabaaacaaaaaaaaaa
aaaaajaaacaaadaaaaaaaaaaaaaaamaaabaaafaaaaaaaaaaaaaabaaaacaaagaa
aaaaaaaaaaaabgaaabaaaiaaaaaaaaaaabaaaaaaabaaajaaaaaaaaaaaaacpppp
fbaaaaafakaaapkaaaaaaamaaaaaeaeaaaaaiadpaaaaaaaafbaaaaafalaaapka
aaaaaaedaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaahlabpaaaaac
aaaaaaiaabaaaplabpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaaiaadaachla
bpaaaaacaaaaaaiaaeaachlabpaaaaacaaaaaaiaafaaaplabpaaaaacaaaaaaja
aaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaabaaaaac
aaaaabiaabaakklaabaaaaacaaaaaciaabaafflaabaaaaacabaaadiaabaancla
agaaaaacaaaaaeiaafaapplaafaaaaadacaaadiaaaaakkiaafaaoelaecaaaaad
adaaapiaabaaoelaabaioekaecaaaaadaeaaapiaaaaaoeiaabaioekaecaaaaad
aaaaapiaaaaaoeiaacaioekaecaaaaadafaaapiaabaaoeiaabaioekaecaaaaad
abaaapiaabaaoeiaacaioekaecaaaaadagaaapiaabaaoelaacaioekaecaaaaad
acaacpiaacaaoeiaaaaioekaafaaaaadaaaaahiaaaaaoeiaaaaaaalaafaaaaad
acaaaoiaaeaabliaaaaaaalaaeaaaaaeacaaaoiaadaabliaaaaakklaacaaoeia
aeaaaaaeacaaaoiaafaabliaaaaafflaacaaoeiaaeaaaaaeaaaaahiaagaaoeia
aaaakklaaaaaoeiaaeaaaaaeaaaaahiaabaaoeiaaaaafflaaaaaoeiabcaaaaae
abaaahiaacaaaakaaaaaoeiaacaabliaafaaaaadaaaaahiaabaaoeiaadaaoeka
abaaaaacadaaahiaadaaoekaaeaaaaaeabaaahiaabaaoeiaadaaoeibaeaaoeka
abaaaaacaaaaaiiaagaappkaacaaaaadaaaaaiiaaaaappibahaaaakaagaaaaac
aaaaaiiaaaaappiaacaaaaadabaaaiiaabaapplaagaappkbafaaaaadaaaabiia
aaaappiaabaappiaaeaaaaaeabaaaiiaaaaappiaakaaaakaakaaffkaafaaaaad
aaaaaiiaaaaappiaaaaappiaafaaaaadaaaaaiiaaaaappiaabaappiaaeaaaaae
aaaachiaaaaappiaabaaoeiaaaaaoeiaafaaaaadabaachiaaaaaoeiaaaaaoeka
afaaaaadaaaachiaaaaaoeiaadaaoelaaiaaaaadaaaaciiaaeaaoelaaeaaoela
ahaaaaacaaaaciiaaaaappiaaeaaaaaeadaachiaaeaaoelaaaaappiaajaaoeka
ceaaaaacaeaachiaadaaoeiaaiaaaaadaaaaciiaacaaoelaaeaaoeiaalaaaaad
abaaaiiaaaaappiaakaappkaabaaaaacaaaaaiiaafaaaakaafaaaaadaaaaaiia
aaaappiaalaaaakacaaaaaadacaaaciaabaappiaaaaappiaafaaaaadaaaaaiia
acaaffiaafaaffkaabaaaaacadaaapiaaaaaoekaafaaaaadacaaaoiaadaablia
abaablkaafaaaaadacaaaoiaaaaappiaacaaoeiaaiaaaaadabaaciiaacaaoela
ajaaoekaalaaaaadadaacbiaabaappiaakaappkaaeaaaaaeabaaahiaabaaoeia
adaaaaiaacaabliaacaaaaadabaaaiiaacaaaaiaacaaaaiaaeaaaaaeabaachia
abaaoeiaabaappiaaaaaoeiaafaaaaadaaaaabiaadaappiaabaappkaafaaaaad
aaaaabiaaaaappiaaaaaaaiaabaaaaacaaaaaeiaakaakkkaacaaaaadaaaaccia
aaaakkiaaiaaaakbaeaaaaaeabaaciiaaaaaaaiaacaaaaiaaaaaffiaabaaaaac
aaaicpiaabaaoeiappppaaaafdeieefcciahaaaaeaaaaaaamkabaaaafjaaaaae
egiocaaaaaaaaaaabhaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
pcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gcbaaaadhcbabaaaafaaaaaagcbaaaadlcbabaaaagaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaggbkbaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
abaaaaaakgbkbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
cgbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaabaaaaaafgbfbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaggbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaakgbkbaaaabaaaaaaegacbaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaacgbkbaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaafgbfbaaa
abaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaiaebaaaaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaagiacaaaaaaaaaaa
ahaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaamhcaabaaaaaaaaaaa
egacbaiaebaaaaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaaegiccaaaaaaaaaaa
akaaaaaaaaaaaaakicaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaabaaaaaaa
akiacaaaaaaaaaaabbaaaaaaaoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpdkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaa
dkbabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaabaaaaaaadicaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegbcbaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
afaaaaaaegbcbaaaafaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
dcaaaaakhcaabaaaacaaaaaaegbcbaaaafaaaaaapgapbaaaaaaaaaaaegiccaaa
abaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
acaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaadaaaaaaegacbaaaacaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaaiicaabaaaabaaaaaaakiacaaaaaaaaaaaamaaaaaaabeaaaaaaaaaaaed
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaabjaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaabkiacaaaaaaaaaaaamaaaaaadiaaaaajpcaabaaaacaaaaaaegiocaaa
aaaaaaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaadiaaaaahpcaabaaaacaaaaaa
pgapbaaaaaaaaaaaegaobaaaacaaaaaabaaaaaaiicaabaaaaaaaaaaaegbcbaaa
adaaaaaaegiccaaaabaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaacaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaa
agaaaaaapgbpbaaaagaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaacaaaaaa
eghobaaaacaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaaakaabaaa
adaaaaaaakaabaaaadaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajbcaabaaaaaaaaaaaakiacaia
ebaaaaaaaaaaaaaabgaaaaaaabeaaaaaaaaaiadpdcaaaaajiccabaaaaaaaaaaa
dkaabaaaacaaaaaaakaabaaaadaaaaaaakaabaaaaaaaaaaadoaaaaabejfdeheo
miaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahahaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaapapaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahahaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahahaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahahaaaalmaaaaaa
afaaaaaaaaaaaaaaadaaaaaaagaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
				}
				SubProgram "opengl " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
					}
					Float 0[_Mix]
					Vector 1[_Color]
					Vector 2[_ColorFromSpace]
					Float 3[_fadeStart]
					Float 4[_fadeEnd]
					Float 5[_PlanetOpacity]
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_ShadowMapTexture] 2D 2
					SetTexture 3[unity_Lightmap] 2D 3 "!!ARBfp1.0
PARAM c[7] = { program.local[0..5],
		{ 1, 2, 3, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEX R3.xyz, fragment.texcoord[1].zyzw, texture[1], 2D;
TEX R6.xyz, fragment.texcoord[1].zyzw, texture[0], 2D;
TEX R0, fragment.texcoord[2], texture[3], 2D;
TXP R7.x, fragment.texcoord[3], texture[2], 2D;
TEX R1.xyz, fragment.texcoord[1].zxzw, texture[1], 2D;
TEX R4.xyz, fragment.texcoord[1].zxzw, texture[0], 2D;
TEX R2.xyz, fragment.texcoord[1], texture[1], 2D;
TEX R5.xyz, fragment.texcoord[1], texture[0], 2D;
MUL R3.xyz, fragment.texcoord[0].x, R3;
MAD R2.xyz, fragment.texcoord[0].z, R2, R3;
MUL R6.xyz, fragment.texcoord[0].x, R6;
MAD R5.xyz, fragment.texcoord[0].z, R5, R6;
MOV R1.w, c[3].x;
MAD R1.xyz, R1, fragment.texcoord[0].y, R2;
MAD R3.xyz, fragment.texcoord[0].y, R4, R5;
ADD R1.xyz, R1, -R3;
MAD R1.xyz, R1, c[0].x, R3;
ADD R1.w, -R1, c[4].x;
RCP R2.x, R1.w;
ADD R1.w, fragment.texcoord[1], -c[3].x;
MUL_SAT R1.w, R1, R2.x;
MUL R1.xyz, -R1, c[1];
MAD R2.w, -R1, c[6].y, c[6].z;
MUL R1.w, R1, R1;
ADD R2.xyz, R1, c[2];
MUL R1.w, R1, R2;
MAD R1.xyz, R1.w, R2, -R1;
MUL R2.xyz, R0.w, R0;
MUL R2.xyz, R2, c[6].w;
MUL R0.xyz, R0, R7.x;
MUL R0.xyz, R0, c[6].y;
MIN R0.xyz, R2, R0;
MUL R3.xyz, R2, R7.x;
MAX R2.xyz, R0, R3;
MOV R0.x, c[6];
MUL result.color.xyz, R1, R2;
ADD result.color.w, R0.x, -c[5].x;
END
# 37 instructions, 8 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
					}
					Float 0[_Mix]
					Vector 1[_Color]
					Vector 2[_ColorFromSpace]
					Float 3[_fadeStart]
					Float 4[_fadeEnd]
					Float 5[_PlanetOpacity]
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_ShadowMapTexture] 2D 2
					SetTexture 3[unity_Lightmap] 2D 3 "ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c6, 1.00000000, 2.00000000, 3.00000000, 8.00000000
dcl t0.xyz
dcl t1
dcl t2.xy
dcl t3
texldp r7, t3, s2
texld r5, t1, s1
mov r4.xy, t1.zxyw
mov r3.xy, t1.zxyw
mov r0.y, t1
mov r0.x, t1.z
mov r1.xy, r0
mov r0.y, t1
mov r0.x, t1.z
mov r2.xy, r0
texld r6, r4, s1
texld r4, r2, s1
texld r1, r1, s0
texld r0, t2, s3
texld r3, r3, s0
texld r2, t1, s0
mul r1.xyz, t0.x, r1
mad r1.xyz, t0.z, r2, r1
mad r2.xyz, t0.y, r3, r1
mul r1.xyz, t0.x, r4
mad r1.xyz, t0.z, r5, r1
mad r1.xyz, r6, t0.y, r1
add r3.xyz, r1, -r2
mad r2.xyz, r3, c0.x, r2
mul r3.xyz, -r2, c1
mov r1.x, c4
add r1.x, -c3, r1
rcp r2.x, r1.x
add r1.x, t1.w, -c3
mul_sat r2.x, r1, r2
mad r1.x, -r2, c6.y, c6.z
mul r2.x, r2, r2
mul r1.x, r2, r1
mul_pp r2.xyz, r0.w, r0
add r4.xyz, r3, c2
mul_pp r0.xyz, r0, r7.x
mad r1.xyz, r1.x, r4, -r3
mul_pp r2.xyz, r2, c6.w
mul_pp r0.xyz, r0, c6.y
min_pp r0.xyz, r2, r0
mul_pp r3.xyz, r2, r7.x
max_pp r2.xyz, r0, r3
mov r0.x, c5
mul_pp r1.xyz, r1, r2
add r1.w, c6.x, -r0.x
mov_pp oC0, r1
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
					}
					SetTexture 0[_WaterTex] 2D 1
					SetTexture 1[_WaterTex1] 2D 2
					SetTexture 2[_ShadowMapTexture] 2D 0
					SetTexture 3[unity_Lightmap] 2D 3
					ConstBuffer "$Globals"
					384
					Float 112[_Mix]
					Vector 144[_Color]
					Vector 160[_ColorFromSpace]
					Float 268[_fadeStart]
					Float 272[_fadeEnd]
					Float 352[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedglbniljcpaclenfngmbmaigmjeenjkicabaaaaaaiiagaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefciaafaaaaeaaaaaaagaabaaaafjaaaaaeegiocaaaaaaaaaaabhaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
pcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadlcbabaaaaeaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
ggbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaabaaaaaakgbkbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaacgbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaafgbfbaaaabaaaaaaegacbaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaggbkbaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaakgbkbaaa
abaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaacgbkbaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
acaaaaaafgbfbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaa
agiacaaaaaaaaaaaahaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaam
hcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaa
egiccaaaaaaaaaaaakaaaaaaaaaaaaakicaabaaaaaaaaaaadkiacaiaebaaaaaa
aaaaaaaabaaaaaaaakiacaaaaaaaaaaabbaaaaaaaoaaaaakicaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaaaaaaaaaaaaaaaaj
icaabaaaabaaaaaadkbabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaabaaaaaaa
dicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaaj
icaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaea
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaaoaaaaah
dcaabaaaabaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaa
abaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaaaaaaaah
icaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaadaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaah
ocaabaaaabaaaaaapgapbaaaaaaaaaaaagajbaaaacaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaapgapbaaaaaaaaaaaddaaaaahocaabaaaabaaaaaafgaobaaa
abaaaaaaagajbaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaabaaaaaa
egacbaaaacaaaaaadeaaaaahhcaabaaaabaaaaaajgahbaaaabaaaaaaegacbaaa
acaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
aaaaaaajiccabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaabgaaaaaaabeaaaaa
aaaaiadpdoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
					}
					SetTexture 0[_WaterTex] 2D 1
					SetTexture 1[_WaterTex1] 2D 2
					SetTexture 2[_ShadowMapTexture] 2D 0
					SetTexture 3[unity_Lightmap] 2D 3
					ConstBuffer "$Globals"
					384
					Float 112[_Mix]
					Vector 144[_Color]
					Vector 160[_ColorFromSpace]
					Float 268[_fadeStart]
					Float 272[_fadeEnd]
					Float 352[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0_level_9_1
eefiecedhkehodedkacnkandflodoafhomkialdoabaaaaaaceakaaaaaeaaaaaa
daaaaaaamiadaaaafaajaaaapaajaaaaebgpgodjjaadaaaajaadaaaaaaacpppp
cmadaaaageaaaaaaaeaadeaaaaaageaaaaaageaaaeaaceaaaaaageaaacaaaaaa
aaababaaabacacaaadadadaaaaaaahaaabaaaaaaaaaaaaaaaaaaajaaacaaabaa
aaaaaaaaaaaabaaaacaaadaaaaaaaaaaaaaabgaaabaaafaaaaaaaaaaaaacpppp
fbaaaaafagaaapkaaaaaaamaaaaaeaeaaaaaaaebaaaaiadpbpaaaaacaaaaaaia
aaaaahlabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaiaacaaadlabpaaaaac
aaaaaaiaadaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
bpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkaabaaaaacaaaaabia
abaakklaabaaaaacaaaaaciaabaafflaabaaaaacabaaadiaabaanclaagaaaaac
aaaaaeiaadaapplaafaaaaadacaaadiaaaaakkiaadaaoelaecaaaaadadaaapia
abaaoelaabaioekaecaaaaadaeaaapiaaaaaoeiaabaioekaecaaaaadaaaaapia
aaaaoeiaacaioekaecaaaaadafaaapiaabaaoeiaabaioekaecaaaaadabaaapia
abaaoeiaacaioekaecaaaaadagaaapiaabaaoelaacaioekaecaaaaadacaacpia
acaaoeiaaaaioekaecaaaaadahaacpiaacaaoelaadaioekaafaaaaadaaaaahia
aaaaoeiaaaaaaalaafaaaaadacaaaoiaaeaabliaaaaaaalaaeaaaaaeacaaaoia
adaabliaaaaakklaacaaoeiaaeaaaaaeacaaaoiaafaabliaaaaafflaacaaoeia
aeaaaaaeaaaaahiaagaaoeiaaaaakklaaaaaoeiaaeaaaaaeaaaaahiaabaaoeia
aaaafflaaaaaoeiabcaaaaaeabaaahiaaaaaaakaaaaaoeiaacaabliaafaaaaad
aaaaahiaabaaoeiaabaaoekaabaaaaacadaaahiaabaaoekaaeaaaaaeabaaahia
abaaoeiaadaaoeibacaaoekaabaaaaacaaaaaiiaadaappkaacaaaaadaaaaaiia
aaaappibaeaaaakaagaaaaacaaaaaiiaaaaappiaacaaaaadabaaaiiaabaappla
adaappkbafaaaaadaaaabiiaaaaappiaabaappiaaeaaaaaeabaaaiiaaaaappia
agaaaakaagaaffkaafaaaaadaaaaaiiaaaaappiaaaaappiaafaaaaadaaaaaiia
aaaappiaabaappiaaeaaaaaeaaaachiaaaaappiaabaaoeiaaaaaoeiaacaaaaad
aaaaciiaacaaaaiaacaaaaiaafaaaaadabaachiaahaaoeiaaaaappiaafaaaaad
aaaaciiaahaappiaagaakkkaafaaaaadacaacoiaahaabliaaaaappiaakaaaaad
adaachiaabaaoeiaacaabliaafaaaaadabaachiaacaaaaiaacaabliaalaaaaad
acaachiaadaaoeiaabaaoeiaafaaaaadaaaachiaaaaaoeiaacaaoeiaabaaaaac
abaaaiiaagaappkaacaaaaadaaaaaiiaabaappiaafaaaakbabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefciaafaaaaeaaaaaaagaabaaaafjaaaaaeegiocaaa
aaaaaaaabhaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadhcbabaaa
abaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaad
lcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaggbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaagbabaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaakgbkbaaaabaaaaaaegacbaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaacgbkbaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaafgbfbaaa
abaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaggbkbaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
acaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
cgbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaa
abaaaaaaegacbaaaacaaaaaafgbfbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaai
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaagiacaaaaaaaaaaaahaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
ajaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaa
aaaaaaaaajaaaaaaegiccaaaaaaaaaaaakaaaaaaaaaaaaakicaabaaaaaaaaaaa
dkiacaiaebaaaaaaaaaaaaaabaaaaaaaakiacaaaaaaaaaaabbaaaaaaaoaaaaak
icaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaa
aaaaaaaaaaaaaaajicaabaaaabaaaaaadkbabaaaacaaaaaadkiacaiaebaaaaaa
aaaaaaaabaaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaa
dcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
aaaaaaaaaaaaaaahicaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaadaaaaaaaagabaaa
adaaaaaadiaaaaahocaabaaaabaaaaaapgapbaaaaaaaaaaaagajbaaaacaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaebdiaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaaaaaaaaaaddaaaaahocaabaaa
abaaaaaafgaobaaaabaaaaaaagajbaaaacaaaaaadiaaaaahhcaabaaaacaaaaaa
agaabaaaabaaaaaaegacbaaaacaaaaaadeaaaaahhcaabaaaabaaaaaajgahbaaa
abaaaaaaegacbaaaacaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaaaaaaaaajiccabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaa
bgaaaaaaabeaaaaaaaaaiadpdoaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaa
iaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaahahaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaapapaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaa
imaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapalaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
				}
				SubProgram "opengl " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
					}
					Vector 0[_SpecColor]
					Float 1[_Mix]
					Vector 2[_Color]
					Vector 3[_ColorFromSpace]
					Float 4[_Shininess]
					Float 5[_Gloss]
					Float 6[_fadeStart]
					Float 7[_fadeEnd]
					Float 8[_PlanetOpacity]
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_ShadowMapTexture] 2D 2
					SetTexture 3[unity_Lightmap] 2D 3
					SetTexture 4[unity_LightmapInd] 2D 4 "!!ARBfp1.0
PARAM c[13] = { program.local[0..8],
		{ 1, 2, 3, 8 },
		{ -0.40824828, -0.70710677, 0.57735026, 0 },
		{ 0.81649655, 0, 0.57735026, 128 },
		{ -0.40824831, 0.70710677, 0.57735026 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEMP R8;
TEX R1, fragment.texcoord[2], texture[4], 2D;
TEX R4.xyz, fragment.texcoord[1].zyzw, texture[1], 2D;
TEX R0, fragment.texcoord[2], texture[3], 2D;
TXP R8.x, fragment.texcoord[4], texture[2], 2D;
TEX R5.xyz, fragment.texcoord[1].zxzw, texture[0], 2D;
TEX R6.xyz, fragment.texcoord[1], texture[0], 2D;
TEX R7.xyz, fragment.texcoord[1].zyzw, texture[0], 2D;
TEX R2.xyz, fragment.texcoord[1].zxzw, texture[1], 2D;
TEX R3.xyz, fragment.texcoord[1], texture[1], 2D;
MUL R4.xyz, fragment.texcoord[0].x, R4;
MAD R3.xyz, fragment.texcoord[0].z, R3, R4;
MAD R2.xyz, R2, fragment.texcoord[0].y, R3;
MUL R1.xyz, R1.w, R1;
MUL R1.xyz, R1, c[9].w;
MUL R4.xyz, R1.y, c[12];
MAD R4.xyz, R1.x, c[11], R4;
MAD R1.xyz, R1.z, c[10], R4;
DP3 R1.w, R1, R1;
RSQ R2.w, R1.w;
MUL R3.xyz, fragment.texcoord[0].x, R7;
MAD R3.xyz, fragment.texcoord[0].z, R6, R3;
MAD R3.xyz, fragment.texcoord[0].y, R5, R3;
ADD R2.xyz, R2, -R3;
MAD R2.xyz, R2, c[1].x, R3;
MUL R2.xyz, -R2, c[2];
DP3 R1.w, fragment.texcoord[3], fragment.texcoord[3];
ADD R3.xyz, R2, c[3];
MUL R1.xyz, R2.w, R1;
RSQ R1.w, R1.w;
MAD R1.xyz, R1.w, fragment.texcoord[3], R1;
DP3 R1.y, R1, R1;
MOV R1.w, c[6].x;
ADD R1.x, -R1.w, c[7];
RSQ R1.w, R1.y;
MUL R1.w, R1, R1.z;
RCP R1.y, R1.x;
MAX R2.w, R1, c[10];
ADD R1.x, fragment.texcoord[1].w, -c[6];
MUL_SAT R1.x, R1, R1.y;
MAD R1.y, -R1.x, c[9], c[9].z;
MUL R1.x, R1, R1;
MUL R1.x, R1, R1.y;
MAD R1.xyz, R1.x, R3, -R2;
MUL R2.xyz, R0.w, R0;
MUL R2.xyz, R2, c[9].w;
MUL R3.xyz, R2, c[0];
MOV R1.w, c[11];
MUL R0.w, R1, c[4].x;
MUL R0.xyz, R0, R8.x;
MUL R0.xyz, R0, c[9].y;
MIN R0.xyz, R2, R0;
MUL R4.xyz, R2, R8.x;
MAX R2.xyz, R0, R4;
MOV R0.x, c[9];
POW R0.w, R2.w, R0.w;
MUL R3.xyz, R3, c[5].x;
MUL R3.xyz, R3, R0.w;
MAD result.color.xyz, R1, R2, R3;
ADD result.color.w, R0.x, -c[8].x;
END
# 59 instructions, 9 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
					}
					Vector 0[_SpecColor]
					Float 1[_Mix]
					Vector 2[_Color]
					Vector 3[_ColorFromSpace]
					Float 4[_Shininess]
					Float 5[_Gloss]
					Float 6[_fadeStart]
					Float 7[_fadeEnd]
					Float 8[_PlanetOpacity]
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_ShadowMapTexture] 2D 2
					SetTexture 3[unity_Lightmap] 2D 3
					SetTexture 4[unity_LightmapInd] 2D 4 "ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c9, 1.00000000, 2.00000000, 3.00000000, 8.00000000
def c10, -0.40824831, 0.70710677, 0.57735026, 0.00000000
def c11, 0.81649655, 0.00000000, 0.57735026, 128.00000000
def c12, -0.40824828, -0.70710677, 0.57735026, 0
dcl t0.xyz
dcl t1
dcl t2.xy
dcl t3.xyz
dcl t4
texldp r8, t4, s2
texld r5, t1, s0
mov r4.xy, t1.zxyw
mov r0.y, t1
mov r0.x, t1.z
mov r2.xy, r0
mov r0.xy, t1.zxyw
mov r1.y, t1
mov r1.x, t1.z
mov r3.xy, r1
texld r6, r4, s0
texld r4, r3, s0
texld r7, r0, s1
texld r3, t1, s1
texld r1, t2, s3
texld r0, t2, s4
texld r2, r2, s1
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, c9.w
mul r2.xyz, t0.x, r2
mad r2.xyz, t0.z, r3, r2
mul r3.xyz, t0.x, r4
mul r4.xyz, r0.y, c10
mad r3.xyz, t0.z, r5, r3
mad r5.xyz, r0.x, c11, r4
mad r2.xyz, r7, t0.y, r2
mad r3.xyz, t0.y, r6, r3
add r4.xyz, r2, -r3
mad r2.xyz, r0.z, c12, r5
dp3 r0.x, r2, r2
mad r3.xyz, r4, c1.x, r3
mul r4.xyz, -r3, c2
rsq r0.x, r0.x
mul r3.xyz, r0.x, r2
mov r0.x, c7
dp3_pp r2.x, t3, t3
rsq_pp r2.x, r2.x
mad_pp r3.xyz, r2.x, t3, r3
add r0.x, -c6, r0
rcp r2.x, r0.x
add r0.x, t1.w, -c6
mul_sat r2.x, r0, r2
dp3_pp r0.x, r3, r3
mad r3.x, -r2, c9.y, c9.z
mul r2.x, r2, r2
mul r2.x, r2, r3
add r5.xyz, r4, c3
mad r4.xyz, r2.x, r5, -r4
rsq_pp r2.x, r0.x
mul_pp r0.z, r2.x, r3
mov_pp r0.x, c4
max_pp r2.x, r0.z, c10.w
mul_pp r0.x, c11.w, r0
pow r3.x, r2.x, r0.x
mul_pp r0.xyz, r1.w, r1
mul_pp r0.xyz, r0, c9.w
mul_pp r1.xyz, r1, r8.x
mul_pp r1.xyz, r1, c9.y
mul_pp r2.xyz, r0, r8.x
min_pp r1.xyz, r0, r1
max_pp r1.xyz, r1, r2
mul_pp r2.xyz, r0, c0
mov r0.x, r3.x
mul_pp r2.xyz, r2, c5.x
mul r2.xyz, r2, r0.x
mov r0.x, c8
mad_pp r1.xyz, r4, r1, r2
add r1.w, c9.x, -r0.x
mov_pp oC0, r1
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
					}
					SetTexture 0[_WaterTex] 2D 1
					SetTexture 1[_WaterTex1] 2D 2
					SetTexture 2[_ShadowMapTexture] 2D 0
					SetTexture 3[unity_Lightmap] 2D 3
					SetTexture 4[unity_LightmapInd] 2D 4
					ConstBuffer "$Globals"
					384
					Vector 32[_SpecColor]
					Float 112[_Mix]
					Vector 144[_Color]
					Vector 160[_ColorFromSpace]
					Float 192[_Shininess]
					Float 196[_Gloss]
					Float 268[_fadeStart]
					Float 272[_fadeEnd]
					Float 352[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedapoedekkdmdfcpfogflhinehleofoaciabaaaaaahmajaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfmaiaaaa
eaaaaaaabhacaaaafjaaaaaeegiocaaaaaaaaaaabhaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaad
dcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadlcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaadaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaakhcaabaaaabaaaaaafgafbaaa
aaaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaadcaaaaamlcaabaaa
aaaaaaaaagaabaaaaaaaaaaaaceaaaaaolaffbdpaaaaaaaaaaaaaaaadkmnbddp
egaibaaaabaaaaaadcaaaaamhcaabaaaaaaaaaaakgakbaaaaaaaaaaaaceaaaaa
olafnblopdaedflpdkmnbddpaaaaaaaaegadbaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaeaaaaaaegbcbaaa
aeaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaaagaabaaaabaaaaaaegbcbaaaaeaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaa
aaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
cpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akiacaaaaaaaaaaaamaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaggbkbaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaadiaaaaahocaabaaaaaaaaaaaagajbaaaabaaaaaaagbabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaadcaaaaajocaabaaaaaaaaaaaagajbaaaabaaaaaakgbkbaaa
abaaaaaafgaobaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaacgbkbaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaajocaabaaaaaaaaaaaagajbaaa
abaaaaaafgbfbaaaabaaaaaafgaobaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
ggbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaa
abaaaaaaegacbaaaacaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaacgbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaafgbfbaaaabaaaaaaegacbaaa
abaaaaaaaaaaaaaiocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaiaebaaaaaa
abaaaaaadcaaaaakocaabaaaaaaaaaaaagiacaaaaaaaaaaaahaaaaaafgaobaaa
aaaaaaaaagajbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaajgahbaaaaaaaaaaa
egiccaaaaaaaaaaaajaaaaaadcaaaaamocaabaaaaaaaaaaafgaobaiaebaaaaaa
aaaaaaaaagijcaaaaaaaaaaaajaaaaaaagijcaaaaaaaaaaaakaaaaaaaaaaaaak
icaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaabaaaaaaaakiacaaaaaaaaaaa
bbaaaaaaaoaaaaakicaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdkaabaaaabaaaaaaaaaaaaajbcaabaaaacaaaaaadkbabaaaacaaaaaa
dkiacaiaebaaaaaaaaaaaaaabaaaaaaadicaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaakaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
akaabaaaacaaaaaadcaaaaajocaabaaaaaaaaaaapgapbaaaabaaaaaafgaobaaa
aaaaaaaaagajbaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaafaaaaaa
pgbpbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaaaaaaaaaaaaaaaahccaabaaaabaaaaaaakaabaaaabaaaaaa
akaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaa
adaaaaaaaagabaaaadaaaaaadiaaaaahocaabaaaabaaaaaafgafbaaaabaaaaaa
agajbaaaacaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaaaebdiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaaacaaaaaa
ddaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaaacaaaaaadiaaaaah
hcaabaaaadaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadiaaaaaihcaabaaa
acaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaaihcaabaaa
acaaaaaaegacbaaaacaaaaaafgifcaaaaaaaaaaaamaaaaaadeaaaaahhcaabaaa
abaaaaaajgahbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahocaabaaaaaaaaaaa
fgaobaaaaaaaaaaaagajbaaaabaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaa
acaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaaaaaaaaajiccabaaaaaaaaaaa
akiacaiaebaaaaaaaaaaaaaabgaaaaaaabeaaaaaaaaaiadpdoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
					}
					SetTexture 0[_WaterTex] 2D 1
					SetTexture 1[_WaterTex1] 2D 2
					SetTexture 2[_ShadowMapTexture] 2D 0
					SetTexture 3[unity_Lightmap] 2D 3
					SetTexture 4[unity_LightmapInd] 2D 4
					ConstBuffer "$Globals"
					384
					Vector 32[_SpecColor]
					Float 112[_Mix]
					Vector 144[_Color]
					Vector 160[_ColorFromSpace]
					Float 192[_Shininess]
					Float 196[_Gloss]
					Float 268[_fadeStart]
					Float 272[_fadeEnd]
					Float 352[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0_level_9_1
eefiecedgldgdocggafgcaobkjggffijbjaocmafabaaaaaaneaoaaaaaeaaaaaa
daaaaaaaieafaaaaoianaaaakaaoaaaaebgpgodjemafaaaaemafaaaaaaacpppp
mmaeaaaaiaaaaaaaagaadiaaaaaaiaaaaaaaiaaaafaaceaaaaaaiaaaacaaaaaa
aaababaaabacacaaadadadaaaeaeaeaaaaaaacaaabaaaaaaaaaaaaaaaaaaahaa
abaaabaaaaaaaaaaaaaaajaaacaaacaaaaaaaaaaaaaaamaaabaaaeaaaaaaaaaa
aaaabaaaacaaafaaaaaaaaaaaaaabgaaabaaahaaaaaaaaaaaaacppppfbaaaaaf
aiaaapkaaaaaaamaaaaaeaeaaaaaaaebaaaaaaaafbaaaaafajaaapkaolaffbdp
aaaaaaaadkmnbddpaaaaiadpfbaaaaafakaaapkaomafnblopdaedfdpdkmnbddp
aaaaaaedfbaaaaafalaaapkaolafnblopdaedflpdkmnbddpaaaaaaaabpaaaaac
aaaaaaiaaaaaahlabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaiaacaaadla
bpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaaiaaeaaaplabpaaaaacaaaaaaja
aaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaac
aaaaaajaadaiapkabpaaaaacaaaaaajaaeaiapkaabaaaaacaaaaabiaabaakkla
abaaaaacaaaaaciaabaafflaabaaaaacabaaadiaabaanclaagaaaaacaaaaaeia
aeaapplaafaaaaadacaaadiaaaaakkiaaeaaoelaecaaaaadadaaapiaabaaoela
abaioekaecaaaaadaeaaapiaaaaaoeiaabaioekaecaaaaadaaaaapiaaaaaoeia
acaioekaecaaaaadafaaapiaabaaoeiaabaioekaecaaaaadabaaapiaabaaoeia
acaioekaecaaaaadagaaapiaabaaoelaacaioekaecaaaaadacaacpiaacaaoeia
aaaioekaecaaaaadahaacpiaacaaoelaadaioekaecaaaaadaiaacpiaacaaoela
aeaioekaafaaaaadaaaaahiaaaaaoeiaaaaaaalaafaaaaadacaaaoiaaeaablia
aaaaaalaaeaaaaaeacaaaoiaadaabliaaaaakklaacaaoeiaaeaaaaaeacaaaoia
afaabliaaaaafflaacaaoeiaaeaaaaaeaaaaahiaagaaoeiaaaaakklaaaaaoeia
aeaaaaaeaaaaahiaabaaoeiaaaaafflaaaaaoeiabcaaaaaeabaaahiaabaaaaka
aaaaoeiaacaabliaafaaaaadaaaaahiaabaaoeiaacaaoekaabaaaaacadaaahia
acaaoekaaeaaaaaeabaaahiaabaaoeiaadaaoeibadaaoekaabaaaaacaaaaaiia
afaappkaacaaaaadaaaaaiiaaaaappibagaaaakaagaaaaacaaaaaiiaaaaappia
acaaaaadabaaaiiaabaapplaafaappkbafaaaaadaaaabiiaaaaappiaabaappia
aeaaaaaeabaaaiiaaaaappiaaiaaaakaaiaaffkaafaaaaadaaaaaiiaaaaappia
aaaappiaafaaaaadaaaaaiiaaaaappiaabaappiaaeaaaaaeaaaachiaaaaappia
abaaoeiaaaaaoeiaacaaaaadaaaaciiaacaaaaiaacaaaaiaafaaaaadabaachia
ahaaoeiaaaaappiaafaaaaadaaaaciiaahaappiaaiaakkkaafaaaaadacaacoia
ahaabliaaaaappiaakaaaaadadaachiaabaaoeiaacaabliaafaaaaadabaachia
acaaaaiaacaabliaafaaaaadacaachiaacaabliaaaaaoekaafaaaaadacaaahia
acaaoeiaaeaaffkaalaaaaadaeaachiaadaaoeiaabaaoeiaafaaaaadaaaachia
aaaaoeiaaeaaoeiaafaaaaadaaaaciiaaiaappiaaiaakkkaafaaaaadabaachia
aiaaoeiaaaaappiaafaaaaadadaaahiaabaaffiaakaaoekaaeaaaaaeadaaahia
abaaaaiaajaaoekaadaaoeiaaeaaaaaeabaaahiaabaakkiaalaaoekaadaaoeia
aiaaaaadaaaaaiiaabaaoeiaabaaoeiaahaaaaacaaaaaiiaaaaappiaceaaaaac
adaachiaadaaoelaaeaaaaaeabaachiaabaaoeiaaaaappiaadaaoeiaaiaaaaad
aaaaciiaabaaoeiaabaaoeiaahaaaaacaaaaciiaaaaappiaafaaaaadaaaaciia
aaaappiaabaakkiaalaaaaadacaaaiiaaaaappiaaiaappkaabaaaaacaaaaaiia
aeaaaakaafaaaaadaaaaaiiaaaaappiaakaappkacaaaaaadabaacbiaacaappia
aaaappiaaeaaaaaeaaaachiaacaaoeiaabaaaaiaaaaaoeiaabaaaaacabaaaiia
ajaappkaacaaaaadaaaaaiiaabaappiaahaaaakbabaaaaacaaaicpiaaaaaoeia
ppppaaaafdeieefcfmaiaaaaeaaaaaaabhacaaaafjaaaaaeegiocaaaaaaaaaaa
bhaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
fibiaaaeaahabaaaaeaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
pcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gcbaaaadlcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaadaaaaaaeghobaaaaeaaaaaaaagabaaa
aeaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaeb
diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaak
hcaabaaaabaaaaaafgafbaaaaaaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddp
aaaaaaaadcaaaaamlcaabaaaaaaaaaaaagaabaaaaaaaaaaaaceaaaaaolaffbdp
aaaaaaaaaaaaaaaadkmnbddpegaibaaaabaaaaaadcaaaaamhcaabaaaaaaaaaaa
kgakbaaaaaaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegadbaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaaaeaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaackaabaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaiccaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaaabeaaaaaaaaaaaed
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabjaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaggbkbaaa
acaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadiaaaaahocaabaaaaaaaaaaa
agajbaaaabaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
acaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaajocaabaaaaaaaaaaa
agajbaaaabaaaaaakgbkbaaaabaaaaaafgaobaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaacgbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaj
ocaabaaaaaaaaaaaagajbaaaabaaaaaafgbfbaaaabaaaaaafgaobaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaggbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaakgbkbaaaabaaaaaa
egacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaacgbkbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaa
fgbfbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaaiocaabaaaaaaaaaaafgaobaaa
aaaaaaaaagajbaiaebaaaaaaabaaaaaadcaaaaakocaabaaaaaaaaaaaagiacaaa
aaaaaaaaahaaaaaafgaobaaaaaaaaaaaagajbaaaabaaaaaadiaaaaaihcaabaaa
abaaaaaajgahbaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaamocaabaaa
aaaaaaaafgaobaiaebaaaaaaaaaaaaaaagijcaaaaaaaaaaaajaaaaaaagijcaaa
aaaaaaaaakaaaaaaaaaaaaakicaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaa
baaaaaaaakiacaaaaaaaaaaabbaaaaaaaoaaaaakicaabaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaabaaaaaaaaaaaaajbcaabaaa
acaaaaaadkbabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaabaaaaaaadicaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaadcaaaaajbcaabaaa
acaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaadcaaaaajocaabaaaaaaaaaaa
pgapbaaaabaaaaaafgaobaaaaaaaaaaaagajbaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegbabaaaafaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaaaaaaaahccaabaaa
abaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaadaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahocaabaaa
abaaaaaafgafbaaaabaaaaaaagajbaaaacaaaaaadiaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaapgapbaaaacaaaaaaddaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaa
agajbaaaacaaaaaadiaaaaahhcaabaaaadaaaaaaagaabaaaabaaaaaaegacbaaa
acaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaa
acaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaafgifcaaaaaaaaaaa
amaaaaaadeaaaaahhcaabaaaabaaaaaajgahbaaaabaaaaaaegacbaaaadaaaaaa
diaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaaabaaaaaadcaaaaaj
hccabaaaaaaaaaaaegacbaaaacaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaa
aaaaaaajiccabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaabgaaaaaaabeaaaaa
aaaaiadpdoaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaahahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapapaaaa
keaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaakeaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
				}
			}
		}
		Pass {
			Name "FORWARD"
			Tags {
				"LIGHTMODE" = "ForwardAdd"
			}
			ZWrite Off
			Fog {
				Color(0, 0, 0, 0)
			}
			Blend One One
			Program "vp" {
				SubProgram "opengl " {
					Keywords {
						"POINT"
					}
					Bind "vertex"
					Vertex
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Matrix 9[_Object2World]
					Matrix 13[_LightMatrix0]
					Vector 17[_WorldSpaceCameraPos]
					Vector 18[_WorldSpaceLightPos0]
					Vector 19[unity_Scale]
					Float 20[_tiling]
					"!!ARBvp1.0
PARAM c[21] = { program.local[0],
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..20] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[19].w;
MOV R0.z, vertex.texcoord[1].x;
MOV R0.xy, vertex.texcoord[0];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
ABS result.texcoord[0].xyz, R0;
MUL result.texcoord[1].xyz, R0, c[20].x;
DP4 R0.x, vertex.position, c[9];
DP4 R0.z, vertex.position, c[11];
DP4 R0.y, vertex.position, c[10];
DP4 R0.w, vertex.position, c[12];
DP4 result.texcoord[5].z, R0, c[15];
DP4 result.texcoord[5].y, R0, c[14];
DP4 result.texcoord[5].x, R0, c[13];
ADD result.texcoord[3].xyz, -R0, c[18];
ADD result.texcoord[4].xyz, -R0, c[17];
DP4 R0.x, vertex.position, c[3];
DP3 result.texcoord[2].z, R1, c[11];
DP3 result.texcoord[2].y, R1, c[10];
DP3 result.texcoord[2].x, R1, c[9];
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
MOV result.texcoord[1].w, -R0.x;
END
# 26 instructions, 2 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"POINT"
					}
					Bind "vertex"
					Vertex
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 8[_Object2World]
					Matrix 12[_LightMatrix0]
					Vector 16[_WorldSpaceCameraPos]
					Vector 17[_WorldSpaceLightPos0]
					Vector 18[unity_Scale]
					Float 19[_tiling]
					"vs_2_0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
mul r1.xyz, v1, c18.w
mov r0.z, v3.x
mov r0.xy, v2
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
abs oT0.xyz, r0
mul oT1.xyz, r0, c19.x
dp4 r0.x, v0, c8
dp4 r0.z, v0, c10
dp4 r0.y, v0, c9
dp4 r0.w, v0, c11
dp4 oT5.z, r0, c14
dp4 oT5.y, r0, c13
dp4 oT5.x, r0, c12
add oT3.xyz, -r0, c17
add oT4.xyz, -r0, c16
dp4 r0.x, v0, c2
dp3 oT2.z, r1, c10
dp3 oT2.y, r1, c9
dp3 oT2.x, r1, c8
dp4 oPos.w, v0, c7
dp4 oPos.z, v0, c6
dp4 oPos.y, v0, c5
dp4 oPos.x, v0, c4
mov oT1.w, -r0.x
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"POINT"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					368
					Matrix 48[_LightMatrix0]
					Float 276[_tiling]
					ConstBuffer "UnityPerCamera"
					128
					Vector 64[_WorldSpaceCameraPos] 3
					ConstBuffer "UnityLighting"
					720
					Vector 0[_WorldSpaceLightPos0]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 192[_Object2World]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityLighting"
					2
					BindCB "UnityPerDraw"
					3 "vs_4_0
eefiecedcleeojjpclbgdfplbednfaokejljpmhiabaaaaaadmahaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefchaafaaaaeaaaabaafmabaaaafjaaaaaeegiocaaaaaaaaaaa
bcaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
abaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadbcbabaaa
aeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
dcaabaaaaaaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaabaaaaaaegacbaia
ibaaaaaaaaaaaaaadiaaaaaihccabaaaacaaaaaaegacbaaaaaaaaaaafgifcaaa
aaaaaaaabbaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
adaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaa
akbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
adaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaa
dgaaaaagiccabaaaacaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaa
aaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaa
dcaaaaakhccabaaaadaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaa
egadbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhccabaaaaeaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaaaaaaaaajhccabaaaafaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaa
abaaaaaaaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaa
kgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaagaaaaaaegiccaaa
aaaaaaaaagaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"POINT"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					368
					Matrix 48[_LightMatrix0]
					Float 276[_tiling]
					ConstBuffer "UnityPerCamera"
					128
					Vector 64[_WorldSpaceCameraPos] 3
					ConstBuffer "UnityLighting"
					720
					Vector 0[_WorldSpaceLightPos0]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 192[_Object2World]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityLighting"
					2
					BindCB "UnityPerDraw"
					3 "vs_4_0_level_9_1
eefiecedapkconnnkldjnoloodcolmkbcmomkdhmabaaaaaaemakaaaaaeaaaaaa
daaaaaaadmadaaaaleaiaaaahmajaaaaebgpgodjaeadaaaaaeadaaaaaaacpopp
iiacaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaadaa
aeaaabaaaaaaaaaaaaaabbaaabaaafaaaaaaaaaaabaaaeaaabaaagaaaaaaaaaa
acaaaaaaabaaahaaaaaaaaaaadaaaaaaaiaaaiaaaaaaaaaaadaaamaaaeaabaaa
aaaaaaaaadaabeaaabaabeaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaia
aaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjabpaaaaac
afaaaeiaaeaaapjaabaaaaacaaaaadiaadaaoejaabaaaaacaaaaaeiaaeaaaaja
ceaaaaacabaaahiaaaaaoeiacdaaaaacaaaaahoaabaaoeiaafaaaaadabaaahoa
abaaoeiaafaaffkaafaaaaadaaaaabiaaaaaffjaanaakkkaaeaaaaaeaaaaabia
amaakkkaaaaaaajaaaaaaaiaaeaaaaaeaaaaabiaaoaakkkaaaaakkjaaaaaaaia
aeaaaaaeaaaaabiaapaakkkaaaaappjaaaaaaaiaabaaaaacabaaaioaaaaaaaib
afaaaaadaaaaahiaacaaoejabeaappkaafaaaaadabaaahiaaaaaffiabbaaoeka
aeaaaaaeaaaaaliabaaakekaaaaaaaiaabaakeiaaeaaaaaeacaaahoabcaaoeka
aaaakkiaaaaapeiaafaaaaadaaaaahiaaaaaffjabbaaoekaaeaaaaaeaaaaahia
baaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiabcaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaahiabdaaoekaaaaappjaaaaaoeiaacaaaaadadaaahoaaaaaoeib
ahaaoekaacaaaaadaeaaahoaaaaaoeibagaaoekaafaaaaadaaaaapiaaaaaffja
bbaaoekaaeaaaaaeaaaaapiabaaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
bcaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiabdaaoekaaaaappjaaaaaoeia
afaaaaadabaaahiaaaaaffiaacaaoekaaeaaaaaeabaaahiaabaaoekaaaaaaaia
abaaoeiaaeaaaaaeaaaaahiaadaaoekaaaaakkiaabaaoeiaaeaaaaaeafaaahoa
aeaaoekaaaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffjaajaaoekaaeaaaaae
aaaaapiaaiaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaakaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaalaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadma
aaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefc
haafaaaaeaaaabaafmabaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadbcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaaaaaaaaaa
egbabaaaadaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaaghccabaaaabaaaaaaegacbaiaibaaaaaaaaaaaaaa
diaaaaaihccabaaaacaaaaaaegacbaaaaaaaaaaafgifcaaaaaaaaaaabbaaaaaa
diaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaa
ckbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
adaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaagiccabaaa
acaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaa
adaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaa
adaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaa
aeaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaaaaaaaaaj
hccabaaaafaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhccabaaaagaaaaaaegiccaaaaaaaaaaaagaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeo
ehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
miaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaa
afaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
				}
				SubProgram "opengl " {
					Keywords {
						"DIRECTIONAL"
					}
					Bind "vertex"
					Vertex
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Matrix 9[_Object2World]
					Vector 13[_WorldSpaceCameraPos]
					Vector 14[_WorldSpaceLightPos0]
					Vector 15[unity_Scale]
					Float 16[_tiling]
					"!!ARBvp1.0
PARAM c[17] = { program.local[0],
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..16] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[15].w;
MOV R0.z, vertex.texcoord[1].x;
MOV R0.xy, vertex.texcoord[0];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
ABS result.texcoord[0].xyz, R0;
MUL result.texcoord[1].xyz, R0, c[16].x;
DP4 R0.x, vertex.position, c[9];
DP4 R0.z, vertex.position, c[11];
DP4 R0.y, vertex.position, c[10];
ADD result.texcoord[4].xyz, -R0, c[13];
DP4 R0.x, vertex.position, c[3];
DP3 result.texcoord[2].z, R1, c[11];
DP3 result.texcoord[2].y, R1, c[10];
DP3 result.texcoord[2].x, R1, c[9];
MOV result.texcoord[3].xyz, c[14];
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
MOV result.texcoord[1].w, -R0.x;
END
# 22 instructions, 2 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"DIRECTIONAL"
					}
					Bind "vertex"
					Vertex
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 8[_Object2World]
					Vector 12[_WorldSpaceCameraPos]
					Vector 13[_WorldSpaceLightPos0]
					Vector 14[unity_Scale]
					Float 15[_tiling]
					"vs_2_0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
mul r1.xyz, v1, c14.w
mov r0.z, v3.x
mov r0.xy, v2
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
abs oT0.xyz, r0
mul oT1.xyz, r0, c15.x
dp4 r0.x, v0, c8
dp4 r0.z, v0, c10
dp4 r0.y, v0, c9
add oT4.xyz, -r0, c12
dp4 r0.x, v0, c2
dp3 oT2.z, r1, c10
dp3 oT2.y, r1, c9
dp3 oT2.x, r1, c8
mov oT3.xyz, c13
dp4 oPos.w, v0, c7
dp4 oPos.z, v0, c6
dp4 oPos.y, v0, c5
dp4 oPos.x, v0, c4
mov oT1.w, -r0.x
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"DIRECTIONAL"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					304
					Float 212[_tiling]
					ConstBuffer "UnityPerCamera"
					128
					Vector 64[_WorldSpaceCameraPos] 3
					ConstBuffer "UnityLighting"
					720
					Vector 0[_WorldSpaceLightPos0]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 192[_Object2World]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityLighting"
					2
					BindCB "UnityPerDraw"
					3 "vs_4_0
eefiecedipcnigepclflhmiidagdmdncokdmonjcabaaaaaanmafaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcciaeaaaaeaaaabaaakabaaaafjaaaaae
egiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaadbcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaa
aaaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaabaaaaaaegacbaiaibaaaaaa
aaaaaaaadiaaaaaihccabaaaacaaaaaaegacbaaaaaaaaaaafgifcaaaaaaaaaaa
anaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
iccabaaaacaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
egbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaa
egiicaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaak
hccabaaaadaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaa
aaaaaaaadgaaaaaghccabaaaaeaaaaaaegiccaaaacaaaaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaafaaaaaa
egacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"DIRECTIONAL"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					304
					Float 212[_tiling]
					ConstBuffer "UnityPerCamera"
					128
					Vector 64[_WorldSpaceCameraPos] 3
					ConstBuffer "UnityLighting"
					720
					Vector 0[_WorldSpaceLightPos0]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 192[_Object2World]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityLighting"
					2
					BindCB "UnityPerDraw"
					3 "vs_4_0_level_9_1
eefiecedcecelbpocoefpmbhkkogbpbakfompmhoabaaaaaaeeaiaaaaaeaaaaaa
daaaaaaajeacaaaameagaaaaimahaaaaebgpgodjfmacaaaafmacaaaaaaacpopp
omabaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaanaa
abaaabaaaaaaaaaaabaaaeaaabaaacaaaaaaaaaaacaaaaaaabaaadaaaaaaaaaa
adaaaaaaaiaaaeaaaaaaaaaaadaaamaaaeaaamaaaaaaaaaaadaabeaaabaabaaa
aaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaacia
acaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjaabaaaaac
aaaaadiaadaaoejaabaaaaacaaaaaeiaaeaaaajaceaaaaacabaaahiaaaaaoeia
cdaaaaacaaaaahoaabaaoeiaafaaaaadabaaahoaabaaoeiaabaaffkaafaaaaad
aaaaabiaaaaaffjaajaakkkaaeaaaaaeaaaaabiaaiaakkkaaaaaaajaaaaaaaia
aeaaaaaeaaaaabiaakaakkkaaaaakkjaaaaaaaiaaeaaaaaeaaaaabiaalaakkka
aaaappjaaaaaaaiaabaaaaacabaaaioaaaaaaaibafaaaaadaaaaahiaacaaoeja
baaappkaafaaaaadabaaahiaaaaaffiaanaaoekaaeaaaaaeaaaaaliaamaakeka
aaaaaaiaabaakeiaaeaaaaaeacaaahoaaoaaoekaaaaakkiaaaaapeiaafaaaaad
aaaaahiaaaaaffjaanaaoekaaeaaaaaeaaaaahiaamaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaahiaaoaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahiaapaaoeka
aaaappjaaaaaoeiaacaaaaadaeaaahoaaaaaoeibacaaoekaafaaaaadaaaaapia
aaaaffjaafaaoekaaeaaaaaeaaaaapiaaeaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiaagaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaahaaoekaaaaappja
aaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacadaaahoaadaaoekappppaaaafdeieefcciaeaaaaeaaaabaa
akabaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaadbcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafdcaabaaaaaaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaaaaaaaaa
akbabaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaabaaaaaa
egacbaiaibaaaaaaaaaaaaaadiaaaaaihccabaaaacaaaaaaegacbaaaaaaaaaaa
fgifcaaaaaaaaaaaanaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaagiccabaaaacaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
lcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaa
abaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaa
aaaaaaaaegadbaaaaaaaaaaadgaaaaaghccabaaaaeaaaaaaegiccaaaacaaaaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hccabaaaafaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaa
doaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaiaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklkl"
				}
				SubProgram "opengl " {
					Keywords {
						"SPOT"
					}
					Bind "vertex"
					Vertex
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Matrix 9[_Object2World]
					Matrix 13[_LightMatrix0]
					Vector 17[_WorldSpaceCameraPos]
					Vector 18[_WorldSpaceLightPos0]
					Vector 19[unity_Scale]
					Float 20[_tiling]
					"!!ARBvp1.0
PARAM c[21] = { program.local[0],
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..20] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[19].w;
MOV R0.z, vertex.texcoord[1].x;
MOV R0.xy, vertex.texcoord[0];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
DP4 R0.w, vertex.position, c[12];
ABS result.texcoord[0].xyz, R0;
MUL result.texcoord[1].xyz, R0, c[20].x;
DP4 R0.x, vertex.position, c[9];
DP4 R0.z, vertex.position, c[11];
DP4 R0.y, vertex.position, c[10];
DP4 result.texcoord[5].w, R0, c[16];
DP4 result.texcoord[5].z, R0, c[15];
DP4 result.texcoord[5].y, R0, c[14];
DP4 result.texcoord[5].x, R0, c[13];
ADD result.texcoord[3].xyz, -R0, c[18];
ADD result.texcoord[4].xyz, -R0, c[17];
DP4 R0.x, vertex.position, c[3];
DP3 result.texcoord[2].z, R1, c[11];
DP3 result.texcoord[2].y, R1, c[10];
DP3 result.texcoord[2].x, R1, c[9];
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
MOV result.texcoord[1].w, -R0.x;
END
# 27 instructions, 2 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"SPOT"
					}
					Bind "vertex"
					Vertex
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 8[_Object2World]
					Matrix 12[_LightMatrix0]
					Vector 16[_WorldSpaceCameraPos]
					Vector 17[_WorldSpaceLightPos0]
					Vector 18[unity_Scale]
					Float 19[_tiling]
					"vs_2_0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
mul r1.xyz, v1, c18.w
mov r0.z, v3.x
mov r0.xy, v2
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp4 r0.w, v0, c11
abs oT0.xyz, r0
mul oT1.xyz, r0, c19.x
dp4 r0.x, v0, c8
dp4 r0.z, v0, c10
dp4 r0.y, v0, c9
dp4 oT5.w, r0, c15
dp4 oT5.z, r0, c14
dp4 oT5.y, r0, c13
dp4 oT5.x, r0, c12
add oT3.xyz, -r0, c17
add oT4.xyz, -r0, c16
dp4 r0.x, v0, c2
dp3 oT2.z, r1, c10
dp3 oT2.y, r1, c9
dp3 oT2.x, r1, c8
dp4 oPos.w, v0, c7
dp4 oPos.z, v0, c6
dp4 oPos.y, v0, c5
dp4 oPos.x, v0, c4
mov oT1.w, -r0.x
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"SPOT"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					368
					Matrix 48[_LightMatrix0]
					Float 276[_tiling]
					ConstBuffer "UnityPerCamera"
					128
					Vector 64[_WorldSpaceCameraPos] 3
					ConstBuffer "UnityLighting"
					720
					Vector 0[_WorldSpaceLightPos0]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 192[_Object2World]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityLighting"
					2
					BindCB "UnityPerDraw"
					3 "vs_4_0
eefiecedlaobfomgjmeopokbbeegniknekiekfnnabaaaaaadmahaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefchaafaaaaeaaaabaafmabaaaafjaaaaaeegiocaaaaaaaaaaa
bcaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
abaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadbcbabaaa
aeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
dcaabaaaaaaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaabaaaaaaegacbaia
ibaaaaaaaaaaaaaadiaaaaaihccabaaaacaaaaaaegacbaaaaaaaaaaafgifcaaa
aaaaaaaabbaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
adaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaa
akbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
adaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaa
dgaaaaagiccabaaaacaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaa
aaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaa
dcaaaaakhccabaaaadaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaa
egadbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhccabaaaaeaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaaaaaaaaajhccabaaaafaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaa
abaaaaaaaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaaaaaaaaaeaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaafaaaaaa
kgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaagaaaaaaegiocaaa
aaaaaaaaagaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"SPOT"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					368
					Matrix 48[_LightMatrix0]
					Float 276[_tiling]
					ConstBuffer "UnityPerCamera"
					128
					Vector 64[_WorldSpaceCameraPos] 3
					ConstBuffer "UnityLighting"
					720
					Vector 0[_WorldSpaceLightPos0]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 192[_Object2World]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityLighting"
					2
					BindCB "UnityPerDraw"
					3 "vs_4_0_level_9_1
eefiecedifahmogcpnkdapijhhmfkogalhifmbcpabaaaaaaemakaaaaaeaaaaaa
daaaaaaadmadaaaaleaiaaaahmajaaaaebgpgodjaeadaaaaaeadaaaaaaacpopp
iiacaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaadaa
aeaaabaaaaaaaaaaaaaabbaaabaaafaaaaaaaaaaabaaaeaaabaaagaaaaaaaaaa
acaaaaaaabaaahaaaaaaaaaaadaaaaaaaiaaaiaaaaaaaaaaadaaamaaaeaabaaa
aaaaaaaaadaabeaaabaabeaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaia
aaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjabpaaaaac
afaaaeiaaeaaapjaabaaaaacaaaaadiaadaaoejaabaaaaacaaaaaeiaaeaaaaja
ceaaaaacabaaahiaaaaaoeiacdaaaaacaaaaahoaabaaoeiaafaaaaadabaaahoa
abaaoeiaafaaffkaafaaaaadaaaaabiaaaaaffjaanaakkkaaeaaaaaeaaaaabia
amaakkkaaaaaaajaaaaaaaiaaeaaaaaeaaaaabiaaoaakkkaaaaakkjaaaaaaaia
aeaaaaaeaaaaabiaapaakkkaaaaappjaaaaaaaiaabaaaaacabaaaioaaaaaaaib
afaaaaadaaaaahiaacaaoejabeaappkaafaaaaadabaaahiaaaaaffiabbaaoeka
aeaaaaaeaaaaaliabaaakekaaaaaaaiaabaakeiaaeaaaaaeacaaahoabcaaoeka
aaaakkiaaaaapeiaafaaaaadaaaaahiaaaaaffjabbaaoekaaeaaaaaeaaaaahia
baaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiabcaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaahiabdaaoekaaaaappjaaaaaoeiaacaaaaadadaaahoaaaaaoeib
ahaaoekaacaaaaadaeaaahoaaaaaoeibagaaoekaafaaaaadaaaaapiaaaaaffja
bbaaoekaaeaaaaaeaaaaapiabaaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
bcaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiabdaaoekaaaaappjaaaaaoeia
afaaaaadabaaapiaaaaaffiaacaaoekaaeaaaaaeabaaapiaabaaoekaaaaaaaia
abaaoeiaaeaaaaaeabaaapiaadaaoekaaaaakkiaabaaoeiaaeaaaaaeafaaapoa
aeaaoekaaaaappiaabaaoeiaafaaaaadaaaaapiaaaaaffjaajaaoekaaeaaaaae
aaaaapiaaiaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaakaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaalaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadma
aaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefc
haafaaaaeaaaabaafmabaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadbcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaaaaaaaaaa
egbabaaaadaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaaghccabaaaabaaaaaaegacbaiaibaaaaaaaaaaaaaa
diaaaaaihccabaaaacaaaaaaegacbaaaaaaaaaaafgifcaaaaaaaaaaabbaaaaaa
diaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaa
ckbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
adaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaagiccabaaa
acaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaa
adaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaa
adaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaa
aeaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaaaaaaaaaj
hccabaaaafaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiocaaaaaaaaaaaaeaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpccabaaaagaaaaaaegiocaaaaaaaaaaaagaaaaaa
pgapbaaaaaaaaaaaegaobaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeo
ehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
miaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaa
afaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
				}
				SubProgram "opengl " {
					Keywords {
						"POINT_COOKIE"
					}
					Bind "vertex"
					Vertex
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Matrix 9[_Object2World]
					Matrix 13[_LightMatrix0]
					Vector 17[_WorldSpaceCameraPos]
					Vector 18[_WorldSpaceLightPos0]
					Vector 19[unity_Scale]
					Float 20[_tiling]
					"!!ARBvp1.0
PARAM c[21] = { program.local[0],
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..20] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[19].w;
MOV R0.z, vertex.texcoord[1].x;
MOV R0.xy, vertex.texcoord[0];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
ABS result.texcoord[0].xyz, R0;
MUL result.texcoord[1].xyz, R0, c[20].x;
DP4 R0.x, vertex.position, c[9];
DP4 R0.z, vertex.position, c[11];
DP4 R0.y, vertex.position, c[10];
DP4 R0.w, vertex.position, c[12];
DP4 result.texcoord[5].z, R0, c[15];
DP4 result.texcoord[5].y, R0, c[14];
DP4 result.texcoord[5].x, R0, c[13];
ADD result.texcoord[3].xyz, -R0, c[18];
ADD result.texcoord[4].xyz, -R0, c[17];
DP4 R0.x, vertex.position, c[3];
DP3 result.texcoord[2].z, R1, c[11];
DP3 result.texcoord[2].y, R1, c[10];
DP3 result.texcoord[2].x, R1, c[9];
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
MOV result.texcoord[1].w, -R0.x;
END
# 26 instructions, 2 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"POINT_COOKIE"
					}
					Bind "vertex"
					Vertex
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 8[_Object2World]
					Matrix 12[_LightMatrix0]
					Vector 16[_WorldSpaceCameraPos]
					Vector 17[_WorldSpaceLightPos0]
					Vector 18[unity_Scale]
					Float 19[_tiling]
					"vs_2_0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
mul r1.xyz, v1, c18.w
mov r0.z, v3.x
mov r0.xy, v2
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
abs oT0.xyz, r0
mul oT1.xyz, r0, c19.x
dp4 r0.x, v0, c8
dp4 r0.z, v0, c10
dp4 r0.y, v0, c9
dp4 r0.w, v0, c11
dp4 oT5.z, r0, c14
dp4 oT5.y, r0, c13
dp4 oT5.x, r0, c12
add oT3.xyz, -r0, c17
add oT4.xyz, -r0, c16
dp4 r0.x, v0, c2
dp3 oT2.z, r1, c10
dp3 oT2.y, r1, c9
dp3 oT2.x, r1, c8
dp4 oPos.w, v0, c7
dp4 oPos.z, v0, c6
dp4 oPos.y, v0, c5
dp4 oPos.x, v0, c4
mov oT1.w, -r0.x
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"POINT_COOKIE"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					368
					Matrix 48[_LightMatrix0]
					Float 276[_tiling]
					ConstBuffer "UnityPerCamera"
					128
					Vector 64[_WorldSpaceCameraPos] 3
					ConstBuffer "UnityLighting"
					720
					Vector 0[_WorldSpaceLightPos0]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 192[_Object2World]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityLighting"
					2
					BindCB "UnityPerDraw"
					3 "vs_4_0
eefiecedcleeojjpclbgdfplbednfaokejljpmhiabaaaaaadmahaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefchaafaaaaeaaaabaafmabaaaafjaaaaaeegiocaaaaaaaaaaa
bcaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
abaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadbcbabaaa
aeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
dcaabaaaaaaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaabaaaaaaegacbaia
ibaaaaaaaaaaaaaadiaaaaaihccabaaaacaaaaaaegacbaaaaaaaaaaafgifcaaa
aaaaaaaabbaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
adaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaa
akbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
adaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaa
dgaaaaagiccabaaaacaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaa
aaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaa
dcaaaaakhccabaaaadaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaa
egadbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhccabaaaaeaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaaaaaaaaajhccabaaaafaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaa
abaaaaaaaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaa
kgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaagaaaaaaegiccaaa
aaaaaaaaagaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"POINT_COOKIE"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					368
					Matrix 48[_LightMatrix0]
					Float 276[_tiling]
					ConstBuffer "UnityPerCamera"
					128
					Vector 64[_WorldSpaceCameraPos] 3
					ConstBuffer "UnityLighting"
					720
					Vector 0[_WorldSpaceLightPos0]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 192[_Object2World]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityLighting"
					2
					BindCB "UnityPerDraw"
					3 "vs_4_0_level_9_1
eefiecedapkconnnkldjnoloodcolmkbcmomkdhmabaaaaaaemakaaaaaeaaaaaa
daaaaaaadmadaaaaleaiaaaahmajaaaaebgpgodjaeadaaaaaeadaaaaaaacpopp
iiacaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaadaa
aeaaabaaaaaaaaaaaaaabbaaabaaafaaaaaaaaaaabaaaeaaabaaagaaaaaaaaaa
acaaaaaaabaaahaaaaaaaaaaadaaaaaaaiaaaiaaaaaaaaaaadaaamaaaeaabaaa
aaaaaaaaadaabeaaabaabeaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaia
aaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjabpaaaaac
afaaaeiaaeaaapjaabaaaaacaaaaadiaadaaoejaabaaaaacaaaaaeiaaeaaaaja
ceaaaaacabaaahiaaaaaoeiacdaaaaacaaaaahoaabaaoeiaafaaaaadabaaahoa
abaaoeiaafaaffkaafaaaaadaaaaabiaaaaaffjaanaakkkaaeaaaaaeaaaaabia
amaakkkaaaaaaajaaaaaaaiaaeaaaaaeaaaaabiaaoaakkkaaaaakkjaaaaaaaia
aeaaaaaeaaaaabiaapaakkkaaaaappjaaaaaaaiaabaaaaacabaaaioaaaaaaaib
afaaaaadaaaaahiaacaaoejabeaappkaafaaaaadabaaahiaaaaaffiabbaaoeka
aeaaaaaeaaaaaliabaaakekaaaaaaaiaabaakeiaaeaaaaaeacaaahoabcaaoeka
aaaakkiaaaaapeiaafaaaaadaaaaahiaaaaaffjabbaaoekaaeaaaaaeaaaaahia
baaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiabcaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaahiabdaaoekaaaaappjaaaaaoeiaacaaaaadadaaahoaaaaaoeib
ahaaoekaacaaaaadaeaaahoaaaaaoeibagaaoekaafaaaaadaaaaapiaaaaaffja
bbaaoekaaeaaaaaeaaaaapiabaaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
bcaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiabdaaoekaaaaappjaaaaaoeia
afaaaaadabaaahiaaaaaffiaacaaoekaaeaaaaaeabaaahiaabaaoekaaaaaaaia
abaaoeiaaeaaaaaeaaaaahiaadaaoekaaaaakkiaabaaoeiaaeaaaaaeafaaahoa
aeaaoekaaaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffjaajaaoekaaeaaaaae
aaaaapiaaiaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaakaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaalaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadma
aaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefc
haafaaaaeaaaabaafmabaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadbcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaaaaaaaaaa
egbabaaaadaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaaghccabaaaabaaaaaaegacbaiaibaaaaaaaaaaaaaa
diaaaaaihccabaaaacaaaaaaegacbaaaaaaaaaaafgifcaaaaaaaaaaabbaaaaaa
diaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaa
ckbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
adaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaagiccabaaa
acaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaa
adaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaa
adaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaa
aeaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaaaaaaaaaj
hccabaaaafaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhccabaaaagaaaaaaegiccaaaaaaaaaaaagaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeo
ehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
miaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaa
afaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
				}
				SubProgram "opengl " {
					Keywords {
						"DIRECTIONAL_COOKIE"
					}
					Bind "vertex"
					Vertex
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Matrix 9[_Object2World]
					Matrix 13[_LightMatrix0]
					Vector 17[_WorldSpaceCameraPos]
					Vector 18[_WorldSpaceLightPos0]
					Vector 19[unity_Scale]
					Float 20[_tiling]
					"!!ARBvp1.0
PARAM c[21] = { program.local[0],
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..20] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[19].w;
MOV R0.z, vertex.texcoord[1].x;
MOV R0.xy, vertex.texcoord[0];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
ABS result.texcoord[0].xyz, R0;
MUL result.texcoord[1].xyz, R0, c[20].x;
DP4 R0.x, vertex.position, c[9];
DP4 R0.z, vertex.position, c[11];
DP4 R0.y, vertex.position, c[10];
DP4 R0.w, vertex.position, c[12];
DP4 result.texcoord[5].y, R0, c[14];
DP4 result.texcoord[5].x, R0, c[13];
ADD result.texcoord[4].xyz, -R0, c[17];
DP4 R0.x, vertex.position, c[3];
DP3 result.texcoord[2].z, R1, c[11];
DP3 result.texcoord[2].y, R1, c[10];
DP3 result.texcoord[2].x, R1, c[9];
MOV result.texcoord[3].xyz, c[18];
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
MOV result.texcoord[1].w, -R0.x;
END
# 25 instructions, 2 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"DIRECTIONAL_COOKIE"
					}
					Bind "vertex"
					Vertex
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 8[_Object2World]
					Matrix 12[_LightMatrix0]
					Vector 16[_WorldSpaceCameraPos]
					Vector 17[_WorldSpaceLightPos0]
					Vector 18[unity_Scale]
					Float 19[_tiling]
					"vs_2_0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
mul r1.xyz, v1, c18.w
mov r0.z, v3.x
mov r0.xy, v2
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
abs oT0.xyz, r0
mul oT1.xyz, r0, c19.x
dp4 r0.x, v0, c8
dp4 r0.z, v0, c10
dp4 r0.y, v0, c9
dp4 r0.w, v0, c11
dp4 oT5.y, r0, c13
dp4 oT5.x, r0, c12
add oT4.xyz, -r0, c16
dp4 r0.x, v0, c2
dp3 oT2.z, r1, c10
dp3 oT2.y, r1, c9
dp3 oT2.x, r1, c8
mov oT3.xyz, c17
dp4 oPos.w, v0, c7
dp4 oPos.z, v0, c6
dp4 oPos.y, v0, c5
dp4 oPos.x, v0, c4
mov oT1.w, -r0.x
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"DIRECTIONAL_COOKIE"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					368
					Matrix 48[_LightMatrix0]
					Float 276[_tiling]
					ConstBuffer "UnityPerCamera"
					128
					Vector 64[_WorldSpaceCameraPos] 3
					ConstBuffer "UnityLighting"
					720
					Vector 0[_WorldSpaceLightPos0]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 192[_Object2World]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityLighting"
					2
					BindCB "UnityPerDraw"
					3 "vs_4_0
eefiecedcdgfkjjnmpdnndgeijblehaachghmgbiabaaaaaadaahaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcgeafaaaaeaaaabaafjabaaaafjaaaaaeegiocaaaaaaaaaaa
bcaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
abaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadbcbabaaa
aeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaaddccabaaaagaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
dcaabaaaaaaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaabaaaaaaegacbaia
ibaaaaaaaaaaaaaadiaaaaaihccabaaaacaaaaaaegacbaaaaaaaaaaafgifcaaa
aaaaaaaabbaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
adaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaa
akbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
adaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaa
dgaaaaagiccabaaaacaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaa
aaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaa
dcaaaaakhccabaaaadaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaa
egadbaaaaaaaaaaadgaaaaaghccabaaaaeaaaaaaegiccaaaacaaaaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaa
afaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaidcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaakdcaabaaaaaaaaaaa
egiacaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaak
dcaabaaaaaaaaaaaegiacaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaabaaa
aaaaaaaadcaaaaakdccabaaaagaaaaaaegiacaaaaaaaaaaaagaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"DIRECTIONAL_COOKIE"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					368
					Matrix 48[_LightMatrix0]
					Float 276[_tiling]
					ConstBuffer "UnityPerCamera"
					128
					Vector 64[_WorldSpaceCameraPos] 3
					ConstBuffer "UnityLighting"
					720
					Vector 0[_WorldSpaceLightPos0]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 192[_Object2World]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityLighting"
					2
					BindCB "UnityPerDraw"
					3 "vs_4_0_level_9_1
eefiecedjiipllojaankcbbiepfnkbnigdjlfdomabaaaaaadmakaaaaaeaaaaaa
daaaaaaadiadaaaakeaiaaaagmajaaaaebgpgodjaaadaaaaaaadaaaaaaacpopp
ieacaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaadaa
aeaaabaaaaaaaaaaaaaabbaaabaaafaaaaaaaaaaabaaaeaaabaaagaaaaaaaaaa
acaaaaaaabaaahaaaaaaaaaaadaaaaaaaiaaaiaaaaaaaaaaadaaamaaaeaabaaa
aaaaaaaaadaabeaaabaabeaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaia
aaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjabpaaaaac
afaaaeiaaeaaapjaabaaaaacaaaaadiaadaaoejaabaaaaacaaaaaeiaaeaaaaja
ceaaaaacabaaahiaaaaaoeiacdaaaaacaaaaahoaabaaoeiaafaaaaadabaaahoa
abaaoeiaafaaffkaafaaaaadaaaaabiaaaaaffjaanaakkkaaeaaaaaeaaaaabia
amaakkkaaaaaaajaaaaaaaiaaeaaaaaeaaaaabiaaoaakkkaaaaakkjaaaaaaaia
aeaaaaaeaaaaabiaapaakkkaaaaappjaaaaaaaiaabaaaaacabaaaioaaaaaaaib
afaaaaadaaaaahiaacaaoejabeaappkaafaaaaadabaaahiaaaaaffiabbaaoeka
aeaaaaaeaaaaaliabaaakekaaaaaaaiaabaakeiaaeaaaaaeacaaahoabcaaoeka
aaaakkiaaaaapeiaafaaaaadaaaaahiaaaaaffjabbaaoekaaeaaaaaeaaaaahia
baaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiabcaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaahiabdaaoekaaaaappjaaaaaoeiaacaaaaadaeaaahoaaaaaoeib
agaaoekaafaaaaadaaaaapiaaaaaffjabbaaoekaaeaaaaaeaaaaapiabaaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiabcaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiabdaaoekaaaaappjaaaaaoeiaafaaaaadabaaadiaaaaaffiaacaaoeka
aeaaaaaeaaaaadiaabaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaadiaadaaoeka
aaaakkiaaaaaoeiaaeaaaaaeafaaadoaaeaaoekaaaaappiaaaaaoeiaafaaaaad
aaaaapiaaaaaffjaajaaoekaaeaaaaaeaaaaapiaaiaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaakaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaalaaoeka
aaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacadaaahoaahaaoekappppaaaafdeieefcgeafaaaa
eaaaabaafjabaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaa
adaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaafpaaaaadbcbabaaaaeaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaa
afaaaaaagfaaaaaddccabaaaagaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaaaaaaaaaaegbabaaa
adaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaghccabaaaabaaaaaaegacbaiaibaaaaaaaaaaaaaadiaaaaai
hccabaaaacaaaaaaegacbaaaaaaaaaaafgifcaaaaaaaaaaabbaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaagiccabaaaacaaaaaa
akaabaiaebaaaaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaa
pgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaadaaaaaa
amaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaadaaaaaa
egiccaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaag
hccabaaaaeaaaaaaegiccaaaacaaaaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaafaaaaaaegacbaiaebaaaaaa
aaaaaaaaegiccaaaabaaaaaaaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaidcaabaaaabaaaaaafgafbaaaaaaaaaaaegiacaaa
aaaaaaaaaeaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaaadaaaaaa
agaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaa
aaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaabaaaaaaaaaaadcaaaaakdccabaaa
agaaaaaaegiacaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegaabaaaaaaaaaaa
doaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaiaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
adamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
				}
			}
			Program "fp" {
				SubProgram "opengl " {
					Keywords {
						"POINT"
					}
					Vector 0[_LightColor0]
					Vector 1[_SpecColor]
					Float 2[_Mix]
					Vector 3[_Color]
					Vector 4[_ColorFromSpace]
					Float 5[_Shininess]
					Float 6[_Gloss]
					Float 7[_fadeStart]
					Float 8[_fadeEnd]
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_LightTexture0] 2D 2 "!!ARBfp1.0
PARAM c[11] = { program.local[0..9],
		{ 0, 128, 2, 3 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R2.xyz, fragment.texcoord[1].zyzw, texture[1], 2D;
TEX R5.xyz, fragment.texcoord[1].zyzw, texture[0], 2D;
TEX R0.xyz, fragment.texcoord[1].zxzw, texture[1], 2D;
TEX R3.xyz, fragment.texcoord[1].zxzw, texture[0], 2D;
TEX R1.xyz, fragment.texcoord[1], texture[1], 2D;
TEX R4.xyz, fragment.texcoord[1], texture[0], 2D;
MUL R2.xyz, fragment.texcoord[0].x, R2;
MAD R1.xyz, fragment.texcoord[0].z, R1, R2;
DP3 R0.w, fragment.texcoord[5], fragment.texcoord[5];
MUL R5.xyz, fragment.texcoord[0].x, R5;
MAD R4.xyz, fragment.texcoord[0].z, R4, R5;
MAD R0.xyz, R0, fragment.texcoord[0].y, R1;
MAD R2.xyz, fragment.texcoord[0].y, R3, R4;
ADD R1.xyz, R0, -R2;
MAD R2.xyz, R1, c[2].x, R2;
MOV R0.x, c[7];
ADD R1.x, -R0, c[8];
RCP R1.y, R1.x;
ADD R1.x, fragment.texcoord[1].w, -c[7];
MUL R0.xyz, -R2, c[3];
MUL_SAT R1.w, R1.x, R1.y;
MAD R2.x, -R1.w, c[10].z, c[10].w;
MUL R1.w, R1, R1;
ADD R1.xyz, R0, c[4];
MUL R1.w, R1, R2.x;
MAD R1.xyz, R1.w, R1, -R0;
DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.y, R0.x;
MUL R2.xyz, R1, c[0];
DP3 R0.x, fragment.texcoord[4], fragment.texcoord[4];
MUL R1.xyz, R0.y, fragment.texcoord[3];
RSQ R0.x, R0.x;
MAD R0.xyz, R0.x, fragment.texcoord[4], R1;
DP3 R1.y, fragment.texcoord[2], R1;
DP3 R1.x, R0, R0;
RSQ R1.w, R1.x;
MAX R1.y, R1, c[10].x;
MUL R1.xyz, R2, R1.y;
MUL R2.xyz, R1.w, R0;
MOV R0.x, c[10].y;
MUL R0.z, R0.x, c[5].x;
DP3 R0.y, fragment.texcoord[2], R2;
MAX R0.x, R0.y, c[10];
POW R1.w, R0.x, R0.z;
MOV R0.xyz, c[1];
MUL R1.w, R1, c[6].x;
MUL R0.xyz, R0, c[0];
MAD R0.xyz, R0, R1.w, R1;
MOV result.color.w, c[10].x;
TEX R0.w, R0.w, texture[2], 2D;
MUL R0.w, R0, c[10].z;
MUL result.color.xyz, R0, R0.w;
END
# 52 instructions, 6 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"POINT"
					}
					Vector 0[_LightColor0]
					Vector 1[_SpecColor]
					Float 2[_Mix]
					Vector 3[_Color]
					Vector 4[_ColorFromSpace]
					Float 5[_Shininess]
					Float 6[_Gloss]
					Float 7[_fadeStart]
					Float 8[_fadeEnd]
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_LightTexture0] 2D 2 "ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c9, 0.00000000, 128.00000000, 2.00000000, 3.00000000
dcl t0.xyz
dcl t1
dcl t2.xyz
dcl t3.xyz
dcl t4.xyz
dcl t5.xyz
dp3 r3.x, t5, t5
mov r4.xy, r3.x
mov r3.xy, t1.zxyw
mov r2.xy, t1.zxyw
mov r1.y, t1
mov r1.x, t1.z
mov r0.y, t1
mov r0.x, t1.z
texld r7, r4, s2
texld r5, r3, s1
texld r3, r1, s1
texld r0, r0, s0
texld r4, t1, s1
texld r2, r2, s0
texld r1, t1, s0
mul r0.xyz, t0.x, r0
mad r0.xyz, t0.z, r1, r0
mul r1.xyz, t0.x, r3
mad r0.xyz, t0.y, r2, r0
mad r1.xyz, t0.z, r4, r1
mad r1.xyz, r5, t0.y, r1
add r1.xyz, r1, -r0
mad r1.xyz, r1, c2.x, r0
mul r5.xyz, -r1, c3
dp3_pp r0.x, t3, t3
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, t3
mov r0.x, c8
dp3_pp r1.x, t4, t4
rsq_pp r1.x, r1.x
mad_pp r4.xyz, r1.x, t4, r3
add r0.x, -c7, r0
rcp r1.x, r0.x
add r0.x, t1.w, -c7
mul_sat r2.x, r0, r1
dp3_pp r0.x, r4, r4
mad r1.x, -r2, c9.z, c9.w
mul r2.x, r2, r2
mul r1.x, r2, r1
add r6.xyz, r5, c4
mad r1.xyz, r1.x, r6, -r5
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r1, c0
mul_pp r1.xyz, r0.x, r4
dp3_pp r1.x, t2, r1
mov_pp r0.x, c5
mul_pp r0.x, c9.y, r0
max_pp r1.x, r1, c9
pow r4.x, r1.x, r0.x
dp3_pp r0.x, t2, r3
max_pp r1.x, r0, c9
mov_pp r3.xyz, c0
mov r0.x, r4.x
mul_pp r2.xyz, r2, r1.x
mul r1.x, r0, c6
mul_pp r3.xyz, c1, r3
mul_pp r0.x, r7, c9.z
mad r1.xyz, r3, r1.x, r2
mul r0.xyz, r1, r0.x
mov_pp r0.w, c9.x
mov_pp oC0, r0
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"POINT"
					}
					SetTexture 0[_WaterTex] 2D 1
					SetTexture 1[_WaterTex1] 2D 2
					SetTexture 2[_LightTexture0] 2D 0
					ConstBuffer "$Globals"
					368
					Vector 16[_LightColor0]
					Vector 32[_SpecColor]
					Float 112[_Mix]
					Vector 144[_Color]
					Vector 160[_ColorFromSpace]
					Float 192[_Shininess]
					Float 196[_Gloss]
					Float 268[_fadeStart]
					Float 272[_fadeEnd]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedfjphdgghmolajaicfdkaalfdicahkadaabaaaaaadmaiaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcaeahaaaaeaaaaaaambabaaaa
fjaaaaaeegiocaaaaaaaaaaabcaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaa
gcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
efaaaaajpcaabaaaaaaaaaaaggbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaagbabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaakgbkbaaaabaaaaaa
egacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaacgbkbaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaa
fgbfbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaggbkbaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaaabaaaaaa
egacbaaaacaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaacgbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaaj
hcaabaaaabaaaaaaegacbaaaacaaaaaafgbfbaaaabaaaaaaegacbaaaabaaaaaa
aaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaagiacaaaaaaaaaaaahaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaajaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaa
egiccaaaaaaaaaaaajaaaaaaegiccaaaaaaaaaaaakaaaaaaaaaaaaakicaabaaa
aaaaaaaadkiacaiaebaaaaaaaaaaaaaabaaaaaaaakiacaaaaaaaaaaabbaaaaaa
aoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
dkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaadkbabaaaacaaaaaadkiacaia
ebaaaaaaaaaaaaaabaaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaa
afaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaa
aeaaaaaadcaaaaajhcaabaaaacaaaaaaegbcbaaaafaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaa
abaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
baaaaaahbcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaa
abaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaadaaaaaa
egacbaaaabaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaiccaabaaa
abaaaaaaakiacaaaaaaaaaaaamaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaabkiacaaa
aaaaaaaaamaaaaaadiaaaaajocaabaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaa
agijcaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaa
jgahbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaagaaaaaa
egbcbaaaagaaaaaaefaaaaajpcaabaaaabaaaaaapgapbaaaaaaaaaaaeghobaaa
acaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaaakaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"POINT"
					}
					SetTexture 0[_WaterTex] 2D 1
					SetTexture 1[_WaterTex1] 2D 2
					SetTexture 2[_LightTexture0] 2D 0
					ConstBuffer "$Globals"
					368
					Vector 16[_LightColor0]
					Vector 32[_SpecColor]
					Float 112[_Mix]
					Vector 144[_Color]
					Vector 160[_ColorFromSpace]
					Float 192[_Shininess]
					Float 196[_Gloss]
					Float 268[_fadeStart]
					Float 272[_fadeEnd]
					BindCB "$Globals"
					0 "ps_4_0_level_9_1
eefiecedochhampgcknmgaecoocceoefjdmghkfoabaaaaaaiaamaaaaaeaaaaaa
daaaaaaahaaeaaaahmalaaaaemamaaaaebgpgodjdiaeaaaadiaeaaaaaaacpppp
mmadaaaagmaaaaaaafaadaaaaaaagmaaaaaagmaaadaaceaaaaaagmaaacaaaaaa
aaababaaabacacaaaaaaabaaacaaaaaaaaaaaaaaaaaaahaaabaaacaaaaaaaaaa
aaaaajaaacaaadaaaaaaaaaaaaaaamaaabaaafaaaaaaaaaaaaaabaaaacaaagaa
aaaaaaaaaaacppppfbaaaaafaiaaapkaaaaaaamaaaaaeaeaaaaaaaaaaaaaaaed
bpaaaaacaaaaaaiaaaaaahlabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaia
acaachlabpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaaiaaeaachlabpaaaaac
aaaaaaiaafaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
bpaaaaacaaaaaajaacaiapkaabaaaaacaaaaabiaabaakklaabaaaaacaaaaacia
abaafflaabaaaaacabaaadiaabaanclaaiaaaaadacaaaiiaafaaoelaafaaoela
abaaaaacacaaadiaacaappiaecaaaaadadaaapiaabaaoelaabaioekaecaaaaad
aeaaapiaaaaaoeiaabaioekaecaaaaadaaaaapiaaaaaoeiaacaioekaecaaaaad
afaaapiaabaaoeiaabaioekaecaaaaadabaaapiaabaaoeiaacaioekaecaaaaad
agaaapiaabaaoelaacaioekaecaaaaadacaacpiaacaaoeiaaaaioekaafaaaaad
aaaaahiaaaaaoeiaaaaaaalaafaaaaadacaaaoiaaeaabliaaaaaaalaaeaaaaae
acaaaoiaadaabliaaaaakklaacaaoeiaaeaaaaaeacaaaoiaafaabliaaaaaffla
acaaoeiaaeaaaaaeaaaaahiaagaaoeiaaaaakklaaaaaoeiaaeaaaaaeaaaaahia
abaaoeiaaaaafflaaaaaoeiabcaaaaaeabaaahiaacaaaakaaaaaoeiaacaablia
afaaaaadaaaaahiaabaaoeiaadaaoekaabaaaaacadaaahiaadaaoekaaeaaaaae
abaaahiaabaaoeiaadaaoeibaeaaoekaabaaaaacaaaaaiiaagaappkaacaaaaad
aaaaaiiaaaaappibahaaaakaagaaaaacaaaaaiiaaaaappiaacaaaaadabaaaiia
abaapplaagaappkbafaaaaadaaaabiiaaaaappiaabaappiaaeaaaaaeabaaaiia
aaaappiaaiaaaakaaiaaffkaafaaaaadaaaaaiiaaaaappiaaaaappiaafaaaaad
aaaaaiiaaaaappiaabaappiaaeaaaaaeaaaachiaaaaappiaabaaoeiaaaaaoeia
afaaaaadaaaachiaaaaaoeiaaaaaoekaaiaaaaadaaaaciiaaeaaoelaaeaaoela
ahaaaaacaaaaciiaaaaappiaceaaaaacabaachiaadaaoelaaeaaaaaeadaachia
aeaaoelaaaaappiaabaaoeiaaiaaaaadaaaaciiaacaaoelaabaaoeiaalaaaaad
adaaciiaaaaappiaaiaakkkaceaaaaacabaachiaadaaoeiaaiaaaaadaaaaciia
acaaoelaabaaoeiaalaaaaadabaaabiaaaaappiaaiaakkkaabaaaaacaaaaaiia
aiaappkaafaaaaadaaaaaiiaaaaappiaafaaaakacaaaaaadacaaaciaabaaaaia
aaaappiaafaaaaadaaaaaiiaacaaffiaafaaffkaabaaaaacabaaahiaaaaaoeka
afaaaaadabaaahiaabaaoeiaabaaoekaafaaaaadabaaahiaaaaappiaabaaoeia
aeaaaaaeaaaaahiaaaaaoeiaadaappiaabaaoeiaacaaaaadaaaaaiiaacaaaaia
acaaaaiaafaaaaadaaaachiaaaaappiaaaaaoeiaabaaaaacaaaaciiaaiaakkka
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcaeahaaaaeaaaaaaambabaaaa
fjaaaaaeegiocaaaaaaaaaaabcaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaa
gcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
efaaaaajpcaabaaaaaaaaaaaggbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaagbabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaakgbkbaaaabaaaaaa
egacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaacgbkbaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaa
fgbfbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaggbkbaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaaabaaaaaa
egacbaaaacaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaacgbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaaj
hcaabaaaabaaaaaaegacbaaaacaaaaaafgbfbaaaabaaaaaaegacbaaaabaaaaaa
aaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaagiacaaaaaaaaaaaahaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaajaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaa
egiccaaaaaaaaaaaajaaaaaaegiccaaaaaaaaaaaakaaaaaaaaaaaaakicaabaaa
aaaaaaaadkiacaiaebaaaaaaaaaaaaaabaaaaaaaakiacaaaaaaaaaaabbaaaaaa
aoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
dkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaadkbabaaaacaaaaaadkiacaia
ebaaaaaaaaaaaaaabaaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaa
afaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaa
aeaaaaaadcaaaaajhcaabaaaacaaaaaaegbcbaaaafaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaa
abaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
baaaaaahbcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaa
abaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaadaaaaaa
egacbaaaabaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaiccaabaaa
abaaaaaaakiacaaaaaaaaaaaamaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaabkiacaaa
aaaaaaaaamaaaaaadiaaaaajocaabaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaa
agijcaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaa
jgahbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaagaaaaaa
egbcbaaaagaaaaaaefaaaaajpcaabaaaabaaaaaapgapbaaaaaaaaaaaeghobaaa
acaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaaakaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaabejfdeheo
miaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahahaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaapapaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahahaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahahaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahahaaaalmaaaaaa
afaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
				}
				SubProgram "opengl " {
					Keywords {
						"DIRECTIONAL"
					}
					Vector 0[_LightColor0]
					Vector 1[_SpecColor]
					Float 2[_Mix]
					Vector 3[_Color]
					Vector 4[_ColorFromSpace]
					Float 5[_Shininess]
					Float 6[_Gloss]
					Float 7[_fadeStart]
					Float 8[_fadeEnd]
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1 "!!ARBfp1.0
PARAM c[11] = { program.local[0..9],
		{ 0, 128, 2, 3 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R5.xyz, fragment.texcoord[1].zyzw, texture[0], 2D;
TEX R2.xyz, fragment.texcoord[1].zyzw, texture[1], 2D;
TEX R0.xyz, fragment.texcoord[1].zxzw, texture[1], 2D;
TEX R3.xyz, fragment.texcoord[1].zxzw, texture[0], 2D;
TEX R1.xyz, fragment.texcoord[1], texture[1], 2D;
TEX R4.xyz, fragment.texcoord[1], texture[0], 2D;
MUL R2.xyz, fragment.texcoord[0].x, R2;
MAD R1.xyz, fragment.texcoord[0].z, R1, R2;
MUL R5.xyz, fragment.texcoord[0].x, R5;
MAD R4.xyz, fragment.texcoord[0].z, R4, R5;
MAD R0.xyz, R0, fragment.texcoord[0].y, R1;
MAD R2.xyz, fragment.texcoord[0].y, R3, R4;
ADD R1.xyz, R0, -R2;
MOV R0.x, c[7];
MAD R1.xyz, R1, c[2].x, R2;
ADD R0.w, -R0.x, c[8].x;
MUL R0.xyz, -R1, c[3];
RCP R1.x, R0.w;
ADD R0.w, fragment.texcoord[1], -c[7].x;
MUL_SAT R0.w, R0, R1.x;
MAD R1.w, -R0, c[10].z, c[10];
MUL R0.w, R0, R0;
ADD R1.xyz, R0, c[4];
MUL R0.w, R0, R1;
MAD R0.xyz, R0.w, R1, -R0;
MUL R2.xyz, R0, c[0];
DP3 R0.x, fragment.texcoord[4], fragment.texcoord[4];
MOV R1.xyz, fragment.texcoord[3];
RSQ R0.x, R0.x;
MAD R0.xyz, R0.x, fragment.texcoord[4], R1;
DP3 R0.w, R0, R0;
DP3 R1.x, fragment.texcoord[2], R1;
MAX R1.x, R1, c[10];
RSQ R0.w, R0.w;
MUL R1.xyz, R2, R1.x;
MUL R2.xyz, R0.w, R0;
MOV R0.x, c[10].y;
MUL R0.z, R0.x, c[5].x;
DP3 R0.y, fragment.texcoord[2], R2;
MAX R0.x, R0.y, c[10];
POW R0.w, R0.x, R0.z;
MOV R0.xyz, c[1];
MUL R0.w, R0, c[6].x;
MUL R0.xyz, R0, c[0];
MAD R0.xyz, R0, R0.w, R1;
MUL result.color.xyz, R0, c[10].z;
MOV result.color.w, c[10].x;
END
# 47 instructions, 6 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"DIRECTIONAL"
					}
					Vector 0[_LightColor0]
					Vector 1[_SpecColor]
					Float 2[_Mix]
					Vector 3[_Color]
					Vector 4[_ColorFromSpace]
					Float 5[_Shininess]
					Float 6[_Gloss]
					Float 7[_fadeStart]
					Float 8[_fadeEnd]
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1 "ps_2_0
dcl_2d s0
dcl_2d s1
def c9, 0.00000000, 128.00000000, 2.00000000, 3.00000000
dcl t0.xyz
dcl t1
dcl t2.xyz
dcl t3.xyz
dcl t4.xyz
texld r4, t1, s1
mov r3.xy, t1.zxyw
mov r2.xy, t1.zxyw
mov r1.y, t1
mov r1.x, t1.z
mov r0.y, t1
mov r0.x, t1.z
texld r5, r3, s1
texld r3, r1, s1
texld r0, r0, s0
texld r2, r2, s0
texld r1, t1, s0
mul r0.xyz, t0.x, r0
mad r0.xyz, t0.z, r1, r0
mul r1.xyz, t0.x, r3
mad r0.xyz, t0.y, r2, r0
mad r1.xyz, t0.z, r4, r1
mad r1.xyz, r5, t0.y, r1
add r1.xyz, r1, -r0
mad r0.xyz, r1, c2.x, r0
mul r4.xyz, -r0, c3
dp3_pp r0.x, t4, t4
mov_pp r1.xyz, t3
rsq_pp r0.x, r0.x
mad_pp r3.xyz, r0.x, t4, r1
dp3_pp r1.x, r3, r3
mov r0.x, c8
add r0.x, -c7, r0
rcp r2.x, r0.x
add r0.x, t1.w, -c7
mul_sat r0.x, r0, r2
rsq_pp r1.x, r1.x
mul_pp r2.xyz, r1.x, r3
mad r1.x, -r0, c9.z, c9.w
mul r0.x, r0, r0
mul r0.x, r0, r1
add r5.xyz, r4, c4
mad r1.xyz, r0.x, r5, -r4
dp3_pp r0.x, t2, r2
mul_pp r4.xyz, r1, c0
mov_pp r2.xyz, t3
mov_pp r1.x, c5
max_pp r0.x, r0, c9
mul_pp r1.x, c9.y, r1
pow r3.x, r0.x, r1.x
dp3_pp r2.x, t2, r2
max_pp r0.x, r2, c9
mov_pp r2.xyz, c0
mul_pp r1.xyz, r4, r0.x
mov r0.x, r3.x
mul r0.x, r0, c6
mul_pp r2.xyz, c1, r2
mad r0.xyz, r2, r0.x, r1
mul r0.xyz, r0, c9.z
mov_pp r0.w, c9.x
mov_pp oC0, r0
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"DIRECTIONAL"
					}
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					ConstBuffer "$Globals"
					304
					Vector 16[_LightColor0]
					Vector 32[_SpecColor]
					Float 48[_Mix]
					Vector 80[_Color]
					Vector 96[_ColorFromSpace]
					Float 128[_Shininess]
					Float 132[_Gloss]
					Float 204[_fadeStart]
					Float 208[_fadeEnd]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedebnkpmdffbogddfgpbogflbggbabddlhabaaaaaafeahaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdeagaaaa
eaaaaaaainabaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
pcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
efaaaaajpcaabaaaaaaaaaaaggbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaagbabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaakgbkbaaaabaaaaaa
egacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaacgbkbaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaa
fgbfbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaggbkbaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaa
egacbaaaacaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaacgbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaj
hcaabaaaabaaaaaaegacbaaaacaaaaaafgbfbaaaabaaaaaaegacbaaaabaaaaaa
aaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaagiacaaaaaaaaaaaadaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaafaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaa
egiccaaaaaaaaaaaafaaaaaaegiccaaaaaaaaaaaagaaaaaaaaaaaaakicaabaaa
aaaaaaaadkiacaiaebaaaaaaaaaaaaaaamaaaaaaakiacaaaaaaaaaaaanaaaaaa
aoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
dkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaadkbabaaaacaaaaaadkiacaia
ebaaaaaaaaaaaaaaamaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaa
afaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaa
abaaaaaaegbcbaaaafaaaaaapgapbaaaaaaaaaaaegbcbaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaa
abaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
cpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaa
akiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaa
aiaaaaaadiaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaaegiccaaa
aaaaaaaaacaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaaeaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
aaaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"DIRECTIONAL"
					}
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					ConstBuffer "$Globals"
					304
					Vector 16[_LightColor0]
					Vector 32[_SpecColor]
					Float 48[_Mix]
					Vector 80[_Color]
					Vector 96[_ColorFromSpace]
					Float 128[_Shininess]
					Float 132[_Gloss]
					Float 204[_fadeStart]
					Float 208[_fadeEnd]
					BindCB "$Globals"
					0 "ps_4_0_level_9_1
eefiecedmjddponemlodmnmaflffaijlphngankpabaaaaaaeaalaaaaaeaaaaaa
daaaaaaabiaeaaaafeakaaaaamalaaaaebgpgodjoaadaaaaoaadaaaaaaacpppp
ieadaaaafmaaaaaaaeaacmaaaaaafmaaaaaafmaaacaaceaaaaaafmaaaaaaaaaa
abababaaaaaaabaaadaaaaaaaaaaaaaaaaaaafaaacaaadaaaaaaaaaaaaaaaiaa
abaaafaaaaaaaaaaaaaaamaaacaaagaaaaaaaaaaaaacppppfbaaaaafaiaaapka
aaaaaamaaaaaeaeaaaaaaaaaaaaaaaedbpaaaaacaaaaaaiaaaaaahlabpaaaaac
aaaaaaiaabaaaplabpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaaiaadaachla
bpaaaaacaaaaaaiaaeaachlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaaja
abaiapkaabaaaaacaaaaabiaabaakklaabaaaaacaaaaaciaabaafflaabaaaaac
abaaadiaabaanclaecaaaaadacaaapiaabaaoelaaaaioekaecaaaaadadaaapia
aaaaoeiaaaaioekaecaaaaadaaaaapiaaaaaoeiaabaioekaecaaaaadaeaaapia
abaaoeiaaaaioekaecaaaaadabaaapiaabaaoeiaabaioekaecaaaaadafaaapia
abaaoelaabaioekaafaaaaadaaaaahiaaaaaoeiaaaaaaalaafaaaaadadaaahia
adaaoeiaaaaaaalaaeaaaaaeacaaahiaacaaoeiaaaaakklaadaaoeiaaeaaaaae
acaaahiaaeaaoeiaaaaafflaacaaoeiaaeaaaaaeaaaaahiaafaaoeiaaaaakkla
aaaaoeiaaeaaaaaeaaaaahiaabaaoeiaaaaafflaaaaaoeiabcaaaaaeabaaahia
acaaaakaaaaaoeiaacaaoeiaafaaaaadaaaaahiaabaaoeiaadaaoekaabaaaaac
acaaahiaadaaoekaaeaaaaaeabaaahiaabaaoeiaacaaoeibaeaaoekaabaaaaac
aaaaaiiaagaappkaacaaaaadaaaaaiiaaaaappibahaaaakaagaaaaacaaaaaiia
aaaappiaacaaaaadabaaaiiaabaapplaagaappkbafaaaaadaaaabiiaaaaappia
abaappiaaeaaaaaeabaaaiiaaaaappiaaiaaaakaaiaaffkaafaaaaadaaaaaiia
aaaappiaaaaappiaafaaaaadaaaaaiiaaaaappiaabaappiaaeaaaaaeaaaachia
aaaappiaabaaoeiaaaaaoeiaafaaaaadaaaachiaaaaaoeiaaaaaoekaaiaaaaad
aaaaciiaaeaaoelaaeaaoelaahaaaaacaaaaciiaaaaappiaabaaaaacabaaahia
aeaaoelaaeaaaaaeabaachiaabaaoeiaaaaappiaadaaoelaceaaaaacacaachia
abaaoeiaaiaaaaadaaaaciiaacaaoelaacaaoeiaalaaaaadabaaabiaaaaappia
aiaakkkaabaaaaacaaaaaiiaaiaappkaafaaaaadaaaaaiiaaaaappiaafaaaaka
caaaaaadacaaabiaabaaaaiaaaaappiaafaaaaadaaaaaiiaacaaaaiaafaaffka
abaaaaacabaaahiaaaaaoekaafaaaaadabaaahiaabaaoeiaabaaoekaafaaaaad
abaaahiaaaaappiaabaaoeiaabaaaaacacaaahiaacaaoelaaiaaaaadaaaaciia
acaaoeiaadaaoelaalaaaaadabaaciiaaaaappiaaiaakkkaaeaaaaaeaaaaahia
aaaaoeiaabaappiaabaaoeiaacaaaaadaaaachiaaaaaoeiaaaaaoeiaabaaaaac
aaaaciiaaiaakkkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcdeagaaaa
eaaaaaaainabaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
pcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
efaaaaajpcaabaaaaaaaaaaaggbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaagbabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaakgbkbaaaabaaaaaa
egacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaacgbkbaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaa
fgbfbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaggbkbaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaa
egacbaaaacaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaacgbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaj
hcaabaaaabaaaaaaegacbaaaacaaaaaafgbfbaaaabaaaaaaegacbaaaabaaaaaa
aaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaagiacaaaaaaaaaaaadaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaafaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaa
egiccaaaaaaaaaaaafaaaaaaegiccaaaaaaaaaaaagaaaaaaaaaaaaakicaabaaa
aaaaaaaadkiacaiaebaaaaaaaaaaaaaaamaaaaaaakiacaaaaaaaaaaaanaaaaaa
aoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
dkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaadkbabaaaacaaaaaadkiacaia
ebaaaaaaaaaaaaaaamaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaa
afaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaa
abaaaaaaegbcbaaaafaaaaaapgapbaaaaaaaaaaaegbcbaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaa
abaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
cpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaa
akiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaa
aiaaaaaadiaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaaegiccaaa
aaaaaaaaacaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaaeaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
aaaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaabejfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahahaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahahaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
				}
				SubProgram "opengl " {
					Keywords {
						"SPOT"
					}
					Vector 0[_LightColor0]
					Vector 1[_SpecColor]
					Float 2[_Mix]
					Vector 3[_Color]
					Vector 4[_ColorFromSpace]
					Float 5[_Shininess]
					Float 6[_Gloss]
					Float 7[_fadeStart]
					Float 8[_fadeEnd]
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_LightTexture0] 2D 2
					SetTexture 3[_LightTextureB0] 2D 3 "!!ARBfp1.0
PARAM c[12] = { program.local[0..9],
		{ 0, 128, 2, 3 },
		{ 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEX R2.xyz, fragment.texcoord[1].zyzw, texture[1], 2D;
TEX R5.xyz, fragment.texcoord[1].zyzw, texture[0], 2D;
TEX R3.xyz, fragment.texcoord[1].zxzw, texture[0], 2D;
TEX R1.xyz, fragment.texcoord[1], texture[1], 2D;
TEX R4.xyz, fragment.texcoord[1], texture[0], 2D;
RCP R0.x, fragment.texcoord[5].w;
MAD R6.xy, fragment.texcoord[5], R0.x, c[11].x;
MUL R2.xyz, fragment.texcoord[0].x, R2;
DP3 R1.w, fragment.texcoord[5], fragment.texcoord[5];
MUL R5.xyz, fragment.texcoord[0].x, R5;
MOV R3.w, c[7].x;
MAD R1.xyz, fragment.texcoord[0].z, R1, R2;
MAD R4.xyz, fragment.texcoord[0].z, R4, R5;
MAD R2.xyz, fragment.texcoord[0].y, R3, R4;
ADD R3.w, -R3, c[8].x;
RCP R4.x, R3.w;
ADD R3.w, fragment.texcoord[1], -c[7].x;
MUL_SAT R3.w, R3, R4.x;
MAD R4.x, -R3.w, c[10].z, c[10].w;
MOV result.color.w, c[10].x;
TEX R0.xyz, fragment.texcoord[1].zxzw, texture[1], 2D;
TEX R0.w, R6, texture[2], 2D;
TEX R1.w, R1.w, texture[3], 2D;
MAD R0.xyz, R0, fragment.texcoord[0].y, R1;
ADD R0.xyz, R0, -R2;
MAD R0.xyz, R0, c[2].x, R2;
MUL R2.xyz, -R0, c[3];
DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.y, R0.x;
DP3 R0.x, fragment.texcoord[4], fragment.texcoord[4];
MUL R1.xyz, R0.y, fragment.texcoord[3];
RSQ R0.x, R0.x;
MAD R0.xyz, R0.x, fragment.texcoord[4], R1;
DP3 R1.y, fragment.texcoord[2], R1;
DP3 R2.w, R0, R0;
RSQ R2.w, R2.w;
MUL R0.xyz, R2.w, R0;
MUL R2.w, R3, R3;
MUL R2.w, R2, R4.x;
ADD R3.xyz, R2, c[4];
MAD R2.xyz, R2.w, R3, -R2;
DP3 R2.w, fragment.texcoord[2], R0;
MUL R0.xyz, R2, c[0];
MOV R2.x, c[10].y;
MAX R1.y, R1, c[10].x;
MUL R0.xyz, R0, R1.y;
MAX R2.y, R2.w, c[10].x;
MUL R1.x, R2, c[5];
POW R1.x, R2.y, R1.x;
MUL R2.x, R1, c[6];
MOV R1.xyz, c[1];
SLT R2.y, c[10].x, fragment.texcoord[5].z;
MUL R0.w, R2.y, R0;
MUL R0.w, R0, R1;
MUL R1.xyz, R1, c[0];
MUL R0.w, R0, c[10].z;
MAD R0.xyz, R1, R2.x, R0;
MUL result.color.xyz, R0, R0.w;
END
# 58 instructions, 7 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"SPOT"
					}
					Vector 0[_LightColor0]
					Vector 1[_SpecColor]
					Float 2[_Mix]
					Vector 3[_Color]
					Vector 4[_ColorFromSpace]
					Float 5[_Shininess]
					Float 6[_Gloss]
					Float 7[_fadeStart]
					Float 8[_fadeEnd]
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_LightTexture0] 2D 2
					SetTexture 3[_LightTextureB0] 2D 3 "ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c9, 0.00000000, 128.00000000, 2.00000000, 3.00000000
def c10, 0.00000000, 1.00000000, 0.50000000, 0
dcl t0.xyz
dcl t1
dcl t2.xyz
dcl t3.xyz
dcl t4.xyz
dcl t5
mov r2.xy, t1.zxyw
mov r5.xy, t1.zxyw
rcp r4.x, t5.w
mad r4.xy, t5, r4.x, c10.z
dp3 r3.x, t5, t5
mov r3.xy, r3.x
mov r1.y, t1
mov r1.x, t1.z
mov r0.y, t1
mov r0.x, t1.z
texld r7, r4, s2
texld r6, r3, s3
texld r3, r1, s1
texld r0, r0, s0
texld r5, r5, s1
texld r4, t1, s1
texld r2, r2, s0
texld r1, t1, s0
mul r0.xyz, t0.x, r0
mad r0.xyz, t0.z, r1, r0
mad r0.xyz, t0.y, r2, r0
mul r1.xyz, t0.x, r3
mad r1.xyz, t0.z, r4, r1
mad r1.xyz, r5, t0.y, r1
add r2.xyz, r1, -r0
mad r2.xyz, r2, c2.x, r0
mul r2.xyz, -r2, c3
mov r1.x, c8
add r0.x, -c7, r1
rcp r1.x, r0.x
add r0.x, t1.w, -c7
mul_sat r1.x, r0, r1
mad r0.x, -r1, c9.z, c9.w
mul r1.x, r1, r1
add r3.xyz, r2, c4
mul r0.x, r1, r0
mad r1.xyz, r0.x, r3, -r2
mul_pp r2.xyz, r1, c0
dp3_pp r0.x, t3, t3
rsq_pp r1.x, r0.x
dp3_pp r0.x, t4, t4
mul_pp r1.xyz, r1.x, t3
rsq_pp r0.x, r0.x
mad_pp r3.xyz, r0.x, t4, r1
dp3_pp r1.x, t2, r1
dp3_pp r0.x, r3, r3
max_pp r1.x, r1, c9
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r2, r1.x
mul_pp r1.xyz, r0.x, r3
dp3_pp r1.x, t2, r1
mov_pp r0.x, c5
mul_pp r0.x, c9.y, r0
max_pp r1.x, r1, c9
pow r3.w, r1.x, r0.x
mov r1.x, r3.w
mov_pp r3.xyz, c0
cmp r0.x, -t5.z, c10, c10.y
mul_pp r0.x, r0, r7.w
mul_pp r0.x, r0, r6
mul_pp r0.x, r0, c9.z
mul r1.x, r1, c6
mul_pp r3.xyz, c1, r3
mad r1.xyz, r3, r1.x, r2
mul r0.xyz, r1, r0.x
mov_pp r0.w, c9.x
mov_pp oC0, r0
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"SPOT"
					}
					SetTexture 0[_WaterTex] 2D 2
					SetTexture 1[_WaterTex1] 2D 3
					SetTexture 2[_LightTexture0] 2D 0
					SetTexture 3[_LightTextureB0] 2D 1
					ConstBuffer "$Globals"
					368
					Vector 16[_LightColor0]
					Vector 32[_SpecColor]
					Float 112[_Mix]
					Vector 144[_Color]
					Vector 160[_ColorFromSpace]
					Float 192[_Shininess]
					Float 196[_Gloss]
					Float 268[_fadeStart]
					Float 272[_fadeEnd]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedjfpnphamgoelnbonaheghblegpomleclabaaaaaabeajaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnmahaaaaeaaaaaaaphabaaaa
fjaaaaaeegiocaaaaaaaaaaabcaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaad
pcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaggbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaagbabaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaakgbkbaaaabaaaaaaegacbaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaacgbkbaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaafgbfbaaa
abaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaggbkbaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
acaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
cgbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaa
abaaaaaaegacbaaaacaaaaaafgbfbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaai
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaagiacaaaaaaaaaaaahaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
ajaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaa
aaaaaaaaajaaaaaaegiccaaaaaaaaaaaakaaaaaaaaaaaaakicaabaaaaaaaaaaa
dkiacaiaebaaaaaaaaaaaaaabaaaaaaaakiacaaaaaaaaaaabbaaaaaaaoaaaaak
icaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaa
aaaaaaaaaaaaaaajicaabaaaabaaaaaadkbabaaaacaaaaaadkiacaiaebaaaaaa
aaaaaaaabaaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaa
dcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaaaeaaaaaa
dcaaaaajhcaabaaaacaaaaaaegbcbaaaafaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaah
bcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaa
egacbaaaacaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaadaaaaaaegacbaaa
abaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
cpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaa
akiacaaaaaaaaaaaamaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaabkaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaabkiacaaaaaaaaaaa
amaaaaaadiaaaaajocaabaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaaagijcaaa
aaaaaaaaacaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaajgahbaaa
abaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaagaaaaaapgbpbaaa
agaaaaaaaaaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaaabeaaaaa
aaaaaaaackbabaaaagaaaaaaabaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaa
aaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaagaaaaaaegbcbaaaagaaaaaa
efaaaaajpcaabaaaabaaaaaaagaabaaaabaaaaaaeghobaaaadaaaaaaaagabaaa
abaaaaaaapaaaaahicaabaaaaaaaaaaapgapbaaaaaaaaaaaagaabaaaabaaaaaa
diaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"SPOT"
					}
					SetTexture 0[_WaterTex] 2D 2
					SetTexture 1[_WaterTex1] 2D 3
					SetTexture 2[_LightTexture0] 2D 0
					SetTexture 3[_LightTextureB0] 2D 1
					ConstBuffer "$Globals"
					368
					Vector 16[_LightColor0]
					Vector 32[_SpecColor]
					Float 112[_Mix]
					Vector 144[_Color]
					Vector 160[_ColorFromSpace]
					Float 192[_Shininess]
					Float 196[_Gloss]
					Float 268[_fadeStart]
					Float 272[_fadeEnd]
					BindCB "$Globals"
					0 "ps_4_0_level_9_1
eefiecedbljelehlgajkgffhcnkojoceponpjbldabaaaaaaneanaaaaaeaaaaaa
daaaaaaaomaeaaaanaamaaaakaanaaaaebgpgodjleaeaaaaleaeaaaaaaacpppp
eeaeaaaahaaaaaaaafaadeaaaaaahaaaaaaahaaaaeaaceaaaaaahaaaacaaaaaa
adababaaaaacacaaabadadaaaaaaabaaacaaaaaaaaaaaaaaaaaaahaaabaaacaa
aaaaaaaaaaaaajaaacaaadaaaaaaaaaaaaaaamaaabaaafaaaaaaaaaaaaaabaaa
acaaagaaaaaaaaaaaaacppppfbaaaaafaiaaapkaaaaaaamaaaaaeaeaaaaaaadp
aaaaaaaafbaaaaafajaaapkaaaaaaaedaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaahlabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaiaacaachla
bpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaaiaaeaachlabpaaaaacaaaaaaia
afaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaac
aaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkaabaaaaacaaaaabiaabaakkla
abaaaaacaaaaaciaabaafflaabaaaaacabaaadiaabaanclaagaaaaacaaaaaeia
afaapplaaeaaaaaeacaaadiaafaaoelaaaaakkiaaiaakkkaaiaaaaadadaaaiia
afaaoelaafaaoelaabaaaaacadaaadiaadaappiaecaaaaadaeaaapiaabaaoela
acaioekaecaaaaadafaaapiaaaaaoeiaacaioekaecaaaaadaaaaapiaaaaaoeia
adaioekaecaaaaadagaaapiaabaaoeiaacaioekaecaaaaadabaaapiaabaaoeia
adaioekaecaaaaadahaaapiaabaaoelaadaioekaecaaaaadacaacpiaacaaoeia
aaaioekaecaaaaadadaacpiaadaaoeiaabaioekaafaaaaadaaaaahiaaaaaoeia
aaaaaalaafaaaaadacaaahiaafaaoeiaaaaaaalaaeaaaaaeacaaahiaaeaaoeia
aaaakklaacaaoeiaaeaaaaaeacaaahiaagaaoeiaaaaafflaacaaoeiaaeaaaaae
aaaaahiaahaaoeiaaaaakklaaaaaoeiaaeaaaaaeaaaaahiaabaaoeiaaaaaffla
aaaaoeiabcaaaaaeabaaahiaacaaaakaaaaaoeiaacaaoeiaafaaaaadaaaaahia
abaaoeiaadaaoekaabaaaaacacaaahiaadaaoekaaeaaaaaeabaaahiaabaaoeia
acaaoeibaeaaoekaabaaaaacaaaaaiiaagaappkaacaaaaadaaaaaiiaaaaappib
ahaaaakaagaaaaacaaaaaiiaaaaappiaacaaaaadabaaaiiaabaapplaagaappkb
afaaaaadaaaabiiaaaaappiaabaappiaaeaaaaaeabaaaiiaaaaappiaaiaaaaka
aiaaffkaafaaaaadaaaaaiiaaaaappiaaaaappiaafaaaaadaaaaaiiaaaaappia
abaappiaaeaaaaaeaaaachiaaaaappiaabaaoeiaaaaaoeiaafaaaaadaaaachia
aaaaoeiaaaaaoekaaiaaaaadaaaaciiaaeaaoelaaeaaoelaahaaaaacaaaaciia
aaaappiaceaaaaacabaachiaadaaoelaaeaaaaaeacaachiaaeaaoelaaaaappia
abaaoeiaaiaaaaadaaaaciiaacaaoelaabaaoeiaalaaaaadabaacbiaaaaappia
aiaappkaceaaaaacaeaachiaacaaoeiaaiaaaaadaaaaciiaacaaoelaaeaaoeia
alaaaaadabaaaciaaaaappiaaiaappkaabaaaaacaaaaaiiaafaaaakaafaaaaad
aaaaaiiaaaaappiaajaaaakacaaaaaadacaaabiaabaaffiaaaaappiaafaaaaad
aaaaaiiaacaaaaiaafaaffkaabaaaaacacaaahiaaaaaoekaafaaaaadabaaaoia
acaabliaabaablkaafaaaaadabaaaoiaaaaappiaabaaoeiaaeaaaaaeaaaaahia
aaaaoeiaabaaaaiaabaabliaafaaaaadaaaaciiaacaappiaadaaaaiafiaaaaae
aaaaciiaafaakklbaiaappkaaaaappiaacaaaaadaaaaaiiaaaaappiaaaaappia
afaaaaadaaaachiaaaaappiaaaaaoeiaabaaaaacaaaaciiaaiaappkaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefcnmahaaaaeaaaaaaaphabaaaafjaaaaae
egiocaaaaaaaaaaabcaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaad
hcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadpcbabaaa
agaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaa
aaaaaaaaggbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaabaaaaaakgbkbaaaabaaaaaaegacbaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaacgbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
adaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaafgbfbaaaabaaaaaa
egacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaggbkbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaacaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
agbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaa
kgbkbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaacgbkbaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaaabaaaaaa
egacbaaaacaaaaaafgbfbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaagiacaaaaaaaaaaaahaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaa
dcaaaaamhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaaaaaaaaa
ajaaaaaaegiccaaaaaaaaaaaakaaaaaaaaaaaaakicaabaaaaaaaaaaadkiacaia
ebaaaaaaaaaaaaaabaaaaaaaakiacaaaaaaaaaaabbaaaaaaaoaaaaakicaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaaaaaaaaa
aaaaaaajicaabaaaabaaaaaadkbabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaa
baaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaa
dcaaaaajicaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaa
aaaaeaeadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaaj
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaa
aeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaaaeaaaaaadcaaaaaj
hcaabaaaacaaaaaaegbcbaaaafaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaadeaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaahbcaabaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegacbaaa
acaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaa
deaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaacpaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaaakiacaaa
aaaaaaaaamaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaabkaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaabkiacaaaaaaaaaaaamaaaaaa
diaaaaajocaabaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaaagijcaaaaaaaaaaa
acaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaajgahbaaaabaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaagaaaaaapgbpbaaaagaaaaaa
aaaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaaabeaaaaaaaaaaaaa
ckbabaaaagaaaaaaabaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaa
baaaaaahbcaabaaaabaaaaaaegbcbaaaagaaaaaaegbcbaaaagaaaaaaefaaaaaj
pcaabaaaabaaaaaaagaabaaaabaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaa
apaaaaahicaabaaaaaaaaaaapgapbaaaaaaaaaaaagaabaaaabaaaaaadiaaaaah
hccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaaaaadoaaaaabejfdeheomiaaaaaaahaaaaaaaiaaaaaa
laaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaahahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaapapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaa
lmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaa
aaaaaaaaadaaaaaaafaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaa
agaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
				}
				SubProgram "opengl " {
					Keywords {
						"POINT_COOKIE"
					}
					Vector 0[_LightColor0]
					Vector 1[_SpecColor]
					Float 2[_Mix]
					Vector 3[_Color]
					Vector 4[_ColorFromSpace]
					Float 5[_Shininess]
					Float 6[_Gloss]
					Float 7[_fadeStart]
					Float 8[_fadeEnd]
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_LightTextureB0] 2D 2
					SetTexture 3[_LightTexture0] CUBE 3 "!!ARBfp1.0
PARAM c[11] = { program.local[0..9],
		{ 0, 128, 2, 3 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R2.xyz, fragment.texcoord[1].zyzw, texture[1], 2D;
TEX R5.xyz, fragment.texcoord[1].zyzw, texture[0], 2D;
TEX R3.xyz, fragment.texcoord[1].zxzw, texture[0], 2D;
TEX R0.xyz, fragment.texcoord[1].zxzw, texture[1], 2D;
TEX R1.xyz, fragment.texcoord[1], texture[1], 2D;
TEX R4.xyz, fragment.texcoord[1], texture[0], 2D;
TEX R1.w, fragment.texcoord[5], texture[3], CUBE;
MUL R2.xyz, fragment.texcoord[0].x, R2;
MAD R1.xyz, fragment.texcoord[0].z, R1, R2;
DP3 R0.w, fragment.texcoord[5], fragment.texcoord[5];
MUL R5.xyz, fragment.texcoord[0].x, R5;
MAD R4.xyz, fragment.texcoord[0].z, R4, R5;
MOV R3.w, c[7].x;
MAD R2.xyz, fragment.texcoord[0].y, R3, R4;
MAD R0.xyz, R0, fragment.texcoord[0].y, R1;
ADD R0.xyz, R0, -R2;
MAD R0.xyz, R0, c[2].x, R2;
MUL R2.xyz, -R0, c[3];
DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.y, R0.x;
ADD R3.w, -R3, c[8].x;
RCP R4.x, R3.w;
DP3 R0.x, fragment.texcoord[4], fragment.texcoord[4];
ADD R3.w, fragment.texcoord[1], -c[7].x;
MUL_SAT R3.w, R3, R4.x;
MUL R1.xyz, R0.y, fragment.texcoord[3];
RSQ R0.x, R0.x;
MAD R0.xyz, R0.x, fragment.texcoord[4], R1;
DP3 R1.y, fragment.texcoord[2], R1;
DP3 R2.w, R0, R0;
RSQ R2.w, R2.w;
MUL R0.xyz, R2.w, R0;
MAX R1.y, R1, c[10].x;
ADD R3.xyz, R2, c[4];
MAD R4.x, -R3.w, c[10].z, c[10].w;
MUL R2.w, R3, R3;
MUL R2.w, R2, R4.x;
MAD R2.xyz, R2.w, R3, -R2;
DP3 R2.w, fragment.texcoord[2], R0;
MUL R0.xyz, R2, c[0];
MOV R2.x, c[10].y;
MUL R0.xyz, R0, R1.y;
MUL R1.x, R2, c[5];
MAX R2.y, R2.w, c[10].x;
POW R1.x, R2.y, R1.x;
MUL R2.x, R1, c[6];
MOV R1.xyz, c[1];
MUL R1.xyz, R1, c[0];
MAD R0.xyz, R1, R2.x, R0;
MOV result.color.w, c[10].x;
TEX R0.w, R0.w, texture[2], 2D;
MUL R0.w, R0, R1;
MUL R0.w, R0, c[10].z;
MUL result.color.xyz, R0, R0.w;
END
# 54 instructions, 6 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"POINT_COOKIE"
					}
					Vector 0[_LightColor0]
					Vector 1[_SpecColor]
					Float 2[_Mix]
					Vector 3[_Color]
					Vector 4[_ColorFromSpace]
					Float 5[_Shininess]
					Float 6[_Gloss]
					Float 7[_fadeStart]
					Float 8[_fadeEnd]
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_LightTextureB0] 2D 2
					SetTexture 3[_LightTexture0] CUBE 3 "ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
def c9, 0.00000000, 128.00000000, 2.00000000, 3.00000000
dcl t0.xyz
dcl t1
dcl t2.xyz
dcl t3.xyz
dcl t4.xyz
dcl t5.xyz
texld r6, t5, s3
dp3 r3.x, t5, t5
mov r4.xy, r3.x
mov r3.xy, t1.zxyw
mov r2.xy, t1.zxyw
mov r1.y, t1
mov r1.x, t1.z
mov r0.y, t1
mov r0.x, t1.z
texld r7, r4, s2
texld r5, r3, s1
texld r3, r1, s1
texld r0, r0, s0
texld r4, t1, s1
texld r2, r2, s0
texld r1, t1, s0
mul r0.xyz, t0.x, r0
mad r0.xyz, t0.z, r1, r0
mad r0.xyz, t0.y, r2, r0
mul r1.xyz, t0.x, r3
mad r1.xyz, t0.z, r4, r1
mad r1.xyz, r5, t0.y, r1
add r2.xyz, r1, -r0
mad r2.xyz, r2, c2.x, r0
mul r2.xyz, -r2, c3
mov r1.x, c8
add r0.x, -c7, r1
rcp r1.x, r0.x
add r0.x, t1.w, -c7
mul_sat r1.x, r0, r1
mad r0.x, -r1, c9.z, c9.w
mul r1.x, r1, r1
add r3.xyz, r2, c4
mul r0.x, r1, r0
mad r1.xyz, r0.x, r3, -r2
mul_pp r2.xyz, r1, c0
dp3_pp r0.x, t3, t3
rsq_pp r1.x, r0.x
dp3_pp r0.x, t4, t4
mul_pp r1.xyz, r1.x, t3
rsq_pp r0.x, r0.x
mad_pp r3.xyz, r0.x, t4, r1
dp3_pp r1.x, t2, r1
dp3_pp r0.x, r3, r3
max_pp r1.x, r1, c9
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r2, r1.x
mul_pp r1.xyz, r0.x, r3
dp3_pp r1.x, t2, r1
mov_pp r0.x, c5
mul_pp r0.x, c9.y, r0
max_pp r1.x, r1, c9
pow r3.w, r1.x, r0.x
mov r1.x, r3.w
mul r0.x, r7, r6.w
mov_pp r3.xyz, c0
mul_pp r0.x, r0, c9.z
mul r1.x, r1, c6
mul_pp r3.xyz, c1, r3
mad r1.xyz, r3, r1.x, r2
mul r0.xyz, r1, r0.x
mov_pp r0.w, c9.x
mov_pp oC0, r0
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"POINT_COOKIE"
					}
					SetTexture 0[_WaterTex] 2D 2
					SetTexture 1[_WaterTex1] 2D 3
					SetTexture 2[_LightTextureB0] 2D 1
					SetTexture 3[_LightTexture0] CUBE 0
					ConstBuffer "$Globals"
					368
					Vector 16[_LightColor0]
					Vector 32[_SpecColor]
					Float 112[_Mix]
					Vector 144[_Color]
					Vector 160[_ColorFromSpace]
					Float 192[_Shininess]
					Float 196[_Gloss]
					Float 268[_fadeStart]
					Float 272[_fadeEnd]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedchihojllfggffmjmadcjgfkieehalndiabaaaaaahmaiaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefceeahaaaaeaaaaaaanbabaaaa
fjaaaaaeegiocaaaaaaaaaaabcaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafidaaaaeaahabaaaadaaaaaaffffaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaad
hcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaggbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaagbabaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaakgbkbaaaabaaaaaaegacbaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaacgbkbaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaafgbfbaaa
abaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaggbkbaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
acaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
cgbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaa
abaaaaaaegacbaaaacaaaaaafgbfbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaai
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaagiacaaaaaaaaaaaahaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
ajaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaa
aaaaaaaaajaaaaaaegiccaaaaaaaaaaaakaaaaaaaaaaaaakicaabaaaaaaaaaaa
dkiacaiaebaaaaaaaaaaaaaabaaaaaaaakiacaaaaaaaaaaabbaaaaaaaoaaaaak
icaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaa
aaaaaaaaaaaaaaajicaabaaaabaaaaaadkbabaaaacaaaaaadkiacaiaebaaaaaa
aaaaaaaabaaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaa
dcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaaaeaaaaaa
dcaaaaajhcaabaaaacaaaaaaegbcbaaaafaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaah
bcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaa
egacbaaaacaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaadaaaaaaegacbaaa
abaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
cpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaa
akiacaaaaaaaaaaaamaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaabkaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaabkiacaaaaaaaaaaa
amaaaaaadiaaaaajocaabaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaaagijcaaa
aaaaaaaaacaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaajgahbaaa
abaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaagaaaaaaegbcbaaa
agaaaaaaefaaaaajpcaabaaaabaaaaaapgapbaaaaaaaaaaaeghobaaaacaaaaaa
aagabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbcbaaaagaaaaaaeghobaaa
adaaaaaaaagabaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaagaabaaaabaaaaaa
pgapbaaaacaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"POINT_COOKIE"
					}
					SetTexture 0[_WaterTex] 2D 2
					SetTexture 1[_WaterTex1] 2D 3
					SetTexture 2[_LightTextureB0] 2D 1
					SetTexture 3[_LightTexture0] CUBE 0
					ConstBuffer "$Globals"
					368
					Vector 16[_LightColor0]
					Vector 32[_SpecColor]
					Float 112[_Mix]
					Vector 144[_Color]
					Vector 160[_ColorFromSpace]
					Float 192[_Shininess]
					Float 196[_Gloss]
					Float 268[_fadeStart]
					Float 272[_fadeEnd]
					BindCB "$Globals"
					0 "ps_4_0_level_9_1
eefiecedddaonfmemnediapfheninihcbhaiefofabaaaaaapaamaaaaaeaaaaaa
daaaaaaakaaeaaaaomalaaaalmamaaaaebgpgodjgiaeaaaagiaeaaaaaaacpppp
piadaaaahaaaaaaaafaadeaaaaaahaaaaaaahaaaaeaaceaaaaaahaaaadaaaaaa
acababaaaaacacaaabadadaaaaaaabaaacaaaaaaaaaaaaaaaaaaahaaabaaacaa
aaaaaaaaaaaaajaaacaaadaaaaaaaaaaaaaaamaaabaaafaaaaaaaaaaaaaabaaa
acaaagaaaaaaaaaaaaacppppfbaaaaafaiaaapkaaaaaaamaaaaaeaeaaaaaaaaa
aaaaaaedbpaaaaacaaaaaaiaaaaaahlabpaaaaacaaaaaaiaabaaaplabpaaaaac
aaaaaaiaacaachlabpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaaiaaeaachla
bpaaaaacaaaaaaiaafaaahlabpaaaaacaaaaaajiaaaiapkabpaaaaacaaaaaaja
abaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkaabaaaaac
aaaaabiaabaakklaabaaaaacaaaaaciaabaafflaabaaaaacabaaadiaabaancla
aiaaaaadacaaaiiaafaaoelaafaaoelaabaaaaacacaaadiaacaappiaecaaaaad
adaaapiaabaaoelaacaioekaecaaaaadaeaaapiaaaaaoeiaacaioekaecaaaaad
aaaaapiaaaaaoeiaadaioekaecaaaaadafaaapiaabaaoeiaacaioekaecaaaaad
abaaapiaabaaoeiaadaioekaecaaaaadagaaapiaabaaoelaadaioekaecaaaaad
acaaapiaacaaoeiaabaioekaecaaaaadahaaapiaafaaoelaaaaioekaafaaaaad
aaaaahiaaaaaoeiaaaaaaalaafaaaaadacaaaoiaaeaabliaaaaaaalaaeaaaaae
acaaaoiaadaabliaaaaakklaacaaoeiaaeaaaaaeacaaaoiaafaabliaaaaaffla
acaaoeiaaeaaaaaeaaaaahiaagaaoeiaaaaakklaaaaaoeiaaeaaaaaeaaaaahia
abaaoeiaaaaafflaaaaaoeiabcaaaaaeabaaahiaacaaaakaaaaaoeiaacaablia
afaaaaadaaaaahiaabaaoeiaadaaoekaabaaaaacadaaahiaadaaoekaaeaaaaae
abaaahiaabaaoeiaadaaoeibaeaaoekaabaaaaacaaaaaiiaagaappkaacaaaaad
aaaaaiiaaaaappibahaaaakaagaaaaacaaaaaiiaaaaappiaacaaaaadabaaaiia
abaapplaagaappkbafaaaaadaaaabiiaaaaappiaabaappiaaeaaaaaeabaaaiia
aaaappiaaiaaaakaaiaaffkaafaaaaadaaaaaiiaaaaappiaaaaappiaafaaaaad
aaaaaiiaaaaappiaabaappiaaeaaaaaeaaaachiaaaaappiaabaaoeiaaaaaoeia
afaaaaadaaaachiaaaaaoeiaaaaaoekaaiaaaaadaaaaciiaaeaaoelaaeaaoela
ahaaaaacaaaaciiaaaaappiaceaaaaacabaachiaadaaoelaaeaaaaaeadaachia
aeaaoelaaaaappiaabaaoeiaaiaaaaadaaaaciiaacaaoelaabaaoeiaalaaaaad
adaaciiaaaaappiaaiaakkkaceaaaaacabaachiaadaaoeiaaiaaaaadaaaaciia
acaaoelaabaaoeiaalaaaaadabaaabiaaaaappiaaiaakkkaabaaaaacaaaaaiia
aiaappkaafaaaaadaaaaaiiaaaaappiaafaaaakacaaaaaadacaaaciaabaaaaia
aaaappiaafaaaaadaaaaaiiaacaaffiaafaaffkaabaaaaacabaaahiaaaaaoeka
afaaaaadabaaahiaabaaoeiaabaaoekaafaaaaadabaaahiaaaaappiaabaaoeia
aeaaaaaeaaaaahiaaaaaoeiaadaappiaabaaoeiaafaaaaadaaaaciiaacaaaaia
ahaappiaacaaaaadaaaaaiiaaaaappiaaaaappiaafaaaaadaaaachiaaaaappia
aaaaoeiaabaaaaacaaaaciiaaiaakkkaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefceeahaaaaeaaaaaaanbabaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fidaaaaeaahabaaaadaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
pcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gcbaaaadhcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaggbkbaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaadaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
abaaaaaakgbkbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
cgbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaabaaaaaafgbfbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaggbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
diaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
dcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaakgbkbaaaabaaaaaaegacbaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaacgbkbaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaafgbfbaaa
abaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaiaebaaaaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaagiacaaaaaaaaaaa
ahaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaamhcaabaaaaaaaaaaa
egacbaiaebaaaaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaaegiccaaaaaaaaaaa
akaaaaaaaaaaaaakicaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaabaaaaaaa
akiacaaaaaaaaaaabbaaaaaaaoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpdkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaa
dkbabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaabaaaaaaadicaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaa
eeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
agaabaaaabaaaaaaegbcbaaaaeaaaaaadcaaaaajhcaabaaaacaaaaaaegbcbaaa
afaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaadaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaadeaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaaiccaabaaaabaaaaaaakiacaaaaaaaaaaaamaaaaaaabeaaaaa
aaaaaaeddiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaa
bjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaibcaabaaaabaaaaaa
akaabaaaabaaaaaabkiacaaaaaaaaaaaamaaaaaadiaaaaajocaabaaaabaaaaaa
agijcaaaaaaaaaaaabaaaaaaagijcaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaa
abaaaaaaagaabaaaabaaaaaajgahbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaagaaaaaaegbcbaaaagaaaaaaefaaaaajpcaabaaaabaaaaaa
pgapbaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaaegbcbaaaagaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaaapaaaaah
icaabaaaaaaaaaaaagaabaaaabaaaaaapgapbaaaacaaaaaadiaaaaahhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaaaaadoaaaaabejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
				}
				SubProgram "opengl " {
					Keywords {
						"DIRECTIONAL_COOKIE"
					}
					Vector 0[_LightColor0]
					Vector 1[_SpecColor]
					Float 2[_Mix]
					Vector 3[_Color]
					Vector 4[_ColorFromSpace]
					Float 5[_Shininess]
					Float 6[_Gloss]
					Float 7[_fadeStart]
					Float 8[_fadeEnd]
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_LightTexture0] 2D 2 "!!ARBfp1.0
PARAM c[11] = { program.local[0..9],
		{ 0, 128, 2, 3 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R2.xyz, fragment.texcoord[1].zyzw, texture[1], 2D;
TEX R5.xyz, fragment.texcoord[1].zyzw, texture[0], 2D;
TEX R0.w, fragment.texcoord[5], texture[2], 2D;
TEX R0.xyz, fragment.texcoord[1].zxzw, texture[1], 2D;
TEX R3.xyz, fragment.texcoord[1].zxzw, texture[0], 2D;
TEX R1.xyz, fragment.texcoord[1], texture[1], 2D;
TEX R4.xyz, fragment.texcoord[1], texture[0], 2D;
MUL R2.xyz, fragment.texcoord[0].x, R2;
MAD R1.xyz, fragment.texcoord[0].z, R1, R2;
MUL R5.xyz, fragment.texcoord[0].x, R5;
MAD R4.xyz, fragment.texcoord[0].z, R4, R5;
MAD R0.xyz, R0, fragment.texcoord[0].y, R1;
MAD R2.xyz, fragment.texcoord[0].y, R3, R4;
ADD R1.xyz, R0, -R2;
MAD R2.xyz, R1, c[2].x, R2;
MOV R0.x, c[7];
ADD R1.x, -R0, c[8];
RCP R1.y, R1.x;
ADD R1.x, fragment.texcoord[1].w, -c[7];
MUL R0.xyz, -R2, c[3];
MUL_SAT R1.w, R1.x, R1.y;
MAD R2.x, -R1.w, c[10].z, c[10].w;
MUL R1.w, R1, R1;
MUL R1.w, R1, R2.x;
ADD R1.xyz, R0, c[4];
MAD R0.xyz, R1.w, R1, -R0;
MUL R2.xyz, R0, c[0];
DP3 R0.x, fragment.texcoord[4], fragment.texcoord[4];
MOV R1.xyz, fragment.texcoord[3];
RSQ R0.x, R0.x;
MAD R0.xyz, R0.x, fragment.texcoord[4], R1;
DP3 R1.y, fragment.texcoord[2], R1;
DP3 R1.x, R0, R0;
RSQ R1.w, R1.x;
MAX R1.y, R1, c[10].x;
MUL R1.xyz, R2, R1.y;
MUL R2.xyz, R1.w, R0;
MOV R0.x, c[10].y;
MUL R0.z, R0.x, c[5].x;
DP3 R0.y, fragment.texcoord[2], R2;
MAX R0.x, R0.y, c[10];
POW R1.w, R0.x, R0.z;
MOV R0.xyz, c[1];
MUL R1.w, R1, c[6].x;
MUL R0.xyz, R0, c[0];
MUL R0.w, R0, c[10].z;
MAD R0.xyz, R0, R1.w, R1;
MUL result.color.xyz, R0, R0.w;
MOV result.color.w, c[10].x;
END
# 49 instructions, 6 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"DIRECTIONAL_COOKIE"
					}
					Vector 0[_LightColor0]
					Vector 1[_SpecColor]
					Float 2[_Mix]
					Vector 3[_Color]
					Vector 4[_ColorFromSpace]
					Float 5[_Shininess]
					Float 6[_Gloss]
					Float 7[_fadeStart]
					Float 8[_fadeEnd]
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_LightTexture0] 2D 2 "ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c9, 0.00000000, 128.00000000, 2.00000000, 3.00000000
dcl t0.xyz
dcl t1
dcl t2.xyz
dcl t3.xyz
dcl t4.xyz
dcl t5.xy
texld r6, t5, s2
texld r4, t1, s1
mov r3.xy, t1.zxyw
mov r2.xy, t1.zxyw
mov r1.y, t1
mov r1.x, t1.z
mov r0.y, t1
mov r0.x, t1.z
texld r5, r3, s1
texld r3, r1, s1
texld r2, r2, s0
texld r0, r0, s0
texld r1, t1, s0
mul r0.xyz, t0.x, r0
mad r0.xyz, t0.z, r1, r0
mad r0.xyz, t0.y, r2, r0
mul r1.xyz, t0.x, r3
mov_pp r2.xyz, t3
mad r1.xyz, t0.z, r4, r1
mad r1.xyz, r5, t0.y, r1
add r1.xyz, r1, -r0
mad r0.xyz, r1, c2.x, r0
mul r4.xyz, -r0, c3
dp3_pp r1.x, t4, t4
rsq_pp r1.x, r1.x
mad_pp r3.xyz, r1.x, t4, r2
mov r0.x, c8
add r1.x, -c7, r0
rcp r2.x, r1.x
dp3_pp r0.x, r3, r3
add r1.x, t1.w, -c7
mul_sat r1.x, r1, r2
mad r2.x, -r1, c9.z, c9.w
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, r3
dp3_pp r0.x, t2, r0
mul r1.x, r1, r1
mul r1.x, r1, r2
add r5.xyz, r4, c4
mad r1.xyz, r1.x, r5, -r4
mul_pp r4.xyz, r1, c0
mov_pp r1.x, c5
max_pp r0.x, r0, c9
mul_pp r1.x, c9.y, r1
pow r2.w, r0.x, r1.x
mov_pp r3.xyz, t3
dp3_pp r0.x, t2, r3
mov_pp r3.xyz, c0
max_pp r1.x, r0, c9
mov r0.x, r2.w
mul_pp r2.xyz, r4, r1.x
mul r1.x, r0, c6
mul_pp r3.xyz, c1, r3
mul_pp r0.x, r6.w, c9.z
mad r1.xyz, r3, r1.x, r2
mul r0.xyz, r1, r0.x
mov_pp r0.w, c9.x
mov_pp oC0, r0
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"DIRECTIONAL_COOKIE"
					}
					SetTexture 0[_WaterTex] 2D 1
					SetTexture 1[_WaterTex1] 2D 2
					SetTexture 2[_LightTexture0] 2D 0
					ConstBuffer "$Globals"
					368
					Vector 16[_LightColor0]
					Vector 32[_SpecColor]
					Float 112[_Mix]
					Vector 144[_Color]
					Vector 160[_ColorFromSpace]
					Float 192[_Shininess]
					Float 196[_Gloss]
					Float 268[_fadeStart]
					Float 272[_fadeEnd]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedokpejhamhkgnlfmlaabompkchegileghabaaaaaaneahaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjmagaaaaeaaaaaaakhabaaaa
fjaaaaaeegiocaaaaaaaaaaabcaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaa
gcbaaaaddcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
efaaaaajpcaabaaaaaaaaaaaggbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaagbabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaakgbkbaaaabaaaaaa
egacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaacgbkbaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaa
fgbfbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaggbkbaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaaabaaaaaa
egacbaaaacaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaacgbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaaj
hcaabaaaabaaaaaaegacbaaaacaaaaaafgbfbaaaabaaaaaaegacbaaaabaaaaaa
aaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaagiacaaaaaaaaaaaahaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaajaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaa
egiccaaaaaaaaaaaajaaaaaaegiccaaaaaaaaaaaakaaaaaaaaaaaaakicaabaaa
aaaaaaaadkiacaiaebaaaaaaaaaaaaaabaaaaaaaakiacaaaaaaaaaaabbaaaaaa
aoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
dkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaadkbabaaaacaaaaaadkiacaia
ebaaaaaaaaaaaaaabaaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaa
afaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaa
abaaaaaaegbcbaaaafaaaaaapgapbaaaaaaaaaaaegbcbaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaa
abaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
cpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaa
akiacaaaaaaaaaaaamaaaaaaabeaaaaaaaaaaaeddiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaa
amaaaaaadiaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaaegiccaaa
aaaaaaaaacaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaaeaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaagaaaaaaeghobaaaacaaaaaaaagabaaa
aaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"DIRECTIONAL_COOKIE"
					}
					SetTexture 0[_WaterTex] 2D 1
					SetTexture 1[_WaterTex1] 2D 2
					SetTexture 2[_LightTexture0] 2D 0
					ConstBuffer "$Globals"
					368
					Vector 16[_LightColor0]
					Vector 32[_SpecColor]
					Float 112[_Mix]
					Vector 144[_Color]
					Vector 160[_ColorFromSpace]
					Float 192[_Shininess]
					Float 196[_Gloss]
					Float 268[_fadeStart]
					Float 272[_fadeEnd]
					BindCB "$Globals"
					0 "ps_4_0_level_9_1
eefiecedkkgaceglbmofplophoplefgkhgcbibgkabaaaaaaaiamaaaaaeaaaaaa
daaaaaaagaaeaaaaaealaaaanealaaaaebgpgodjciaeaaaaciaeaaaaaaacpppp
lmadaaaagmaaaaaaafaadaaaaaaagmaaaaaagmaaadaaceaaaaaagmaaacaaaaaa
aaababaaabacacaaaaaaabaaacaaaaaaaaaaaaaaaaaaahaaabaaacaaaaaaaaaa
aaaaajaaacaaadaaaaaaaaaaaaaaamaaabaaafaaaaaaaaaaaaaabaaaacaaagaa
aaaaaaaaaaacppppfbaaaaafaiaaapkaaaaaaamaaaaaeaeaaaaaaaaaaaaaaaed
bpaaaaacaaaaaaiaaaaaahlabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaia
acaachlabpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaaiaaeaachlabpaaaaac
aaaaaaiaafaaadlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
bpaaaaacaaaaaajaacaiapkaabaaaaacaaaaabiaabaakklaabaaaaacaaaaacia
abaafflaabaaaaacabaaadiaabaanclaecaaaaadacaaapiaabaaoelaabaioeka
ecaaaaadadaaapiaaaaaoeiaabaioekaecaaaaadaaaaapiaaaaaoeiaacaioeka
ecaaaaadaeaaapiaabaaoeiaabaioekaecaaaaadabaaapiaabaaoeiaacaioeka
ecaaaaadafaaapiaabaaoelaacaioekaecaaaaadagaacpiaafaaoelaaaaioeka
afaaaaadaaaaahiaaaaaoeiaaaaaaalaafaaaaadadaaahiaadaaoeiaaaaaaala
aeaaaaaeacaaahiaacaaoeiaaaaakklaadaaoeiaaeaaaaaeacaaahiaaeaaoeia
aaaafflaacaaoeiaaeaaaaaeaaaaahiaafaaoeiaaaaakklaaaaaoeiaaeaaaaae
aaaaahiaabaaoeiaaaaafflaaaaaoeiabcaaaaaeabaaahiaacaaaakaaaaaoeia
acaaoeiaafaaaaadaaaaahiaabaaoeiaadaaoekaabaaaaacacaaahiaadaaoeka
aeaaaaaeabaaahiaabaaoeiaacaaoeibaeaaoekaabaaaaacaaaaaiiaagaappka
acaaaaadaaaaaiiaaaaappibahaaaakaagaaaaacaaaaaiiaaaaappiaacaaaaad
abaaaiiaabaapplaagaappkbafaaaaadaaaabiiaaaaappiaabaappiaaeaaaaae
abaaaiiaaaaappiaaiaaaakaaiaaffkaafaaaaadaaaaaiiaaaaappiaaaaappia
afaaaaadaaaaaiiaaaaappiaabaappiaaeaaaaaeaaaachiaaaaappiaabaaoeia
aaaaoeiaafaaaaadaaaachiaaaaaoeiaaaaaoekaaiaaaaadaaaaciiaaeaaoela
aeaaoelaahaaaaacaaaaciiaaaaappiaabaaaaacabaaahiaaeaaoelaaeaaaaae
abaachiaabaaoeiaaaaappiaadaaoelaceaaaaacacaachiaabaaoeiaaiaaaaad
aaaaciiaacaaoelaacaaoeiaalaaaaadabaaabiaaaaappiaaiaakkkaabaaaaac
aaaaaiiaaiaappkaafaaaaadaaaaaiiaaaaappiaafaaaakacaaaaaadacaaabia
abaaaaiaaaaappiaafaaaaadaaaaaiiaacaaaaiaafaaffkaabaaaaacabaaahia
aaaaoekaafaaaaadabaaahiaabaaoeiaabaaoekaafaaaaadabaaahiaaaaappia
abaaoeiaabaaaaacacaaahiaacaaoelaaiaaaaadaaaaciiaacaaoeiaadaaoela
alaaaaadabaaciiaaaaappiaaiaakkkaaeaaaaaeaaaaahiaaaaaoeiaabaappia
abaaoeiaacaaaaadaaaaaiiaagaappiaagaappiaafaaaaadaaaachiaaaaappia
aaaaoeiaabaaaaacaaaaciiaaiaakkkaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefcjmagaaaaeaaaaaaakhabaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaa
gcbaaaadpcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaaddcbabaaaagaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaggbkbaaa
acaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
acaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaabaaaaaakgbkbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaacgbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaabaaaaaafgbfbaaaabaaaaaaegacbaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaggbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaakgbkbaaaabaaaaaa
egacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaacgbkbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaa
fgbfbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaagiacaaa
aaaaaaaaahaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaamhcaabaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaaegiccaaa
aaaaaaaaakaaaaaaaaaaaaakicaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaa
baaaaaaaakiacaaaaaaaaaaabbaaaaaaaoaaaaakicaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaaaaaaaaaaaaaaaajicaabaaa
abaaaaaadkbabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaabaaaaaaadicaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajicaabaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaaafaaaaaapgapbaaa
aaaaaaaaegbcbaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaaibcaabaaaabaaaaaaakiacaaaaaaaaaaaamaaaaaaabeaaaaa
aaaaaaeddiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
bjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaa
dkaabaaaaaaaaaaabkiacaaaaaaaaaaaamaaaaaadiaaaaajhcaabaaaabaaaaaa
egiccaaaaaaaaaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaadaaaaaaegbcbaaaaeaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
agaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaa
dkaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaa
doaaaaabejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
ahahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapapaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaadadaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
				}
			}
		}
		Pass {
			Name "PREPASS"
			Tags {
				"LIGHTMODE" = "PrePassBase"
			}
			Fog {
				Mode Off
			}
			Blend SrcAlpha OneMinusSrcAlpha
			Program "vp" {
				SubProgram "opengl " {
					Bind "vertex"
					Vertex
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Matrix 9[_Object2World]
					Vector 13[unity_Scale]
					Float 14[_tiling]
					"!!ARBvp1.0
PARAM c[15] = { program.local[0],
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..14] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[13].w;
MOV R0.z, vertex.texcoord[1].x;
MOV R0.xy, vertex.texcoord[0];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
ABS result.texcoord[0].xyz, R0;
MUL result.texcoord[1].xyz, R0, c[14].x;
DP4 R0.x, vertex.position, c[3];
DP3 result.texcoord[2].z, R1, c[11];
DP3 result.texcoord[2].y, R1, c[10];
DP3 result.texcoord[2].x, R1, c[9];
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
MOV result.texcoord[1].w, -R0.x;
END
# 17 instructions, 2 R-regs
"
				}
				SubProgram "d3d9 " {
					Bind "vertex"
					Vertex
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 8[_Object2World]
					Vector 12[unity_Scale]
					Float 13[_tiling]
					"vs_2_0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
mul r1.xyz, v1, c12.w
mov r0.z, v3.x
mov r0.xy, v2
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
abs oT0.xyz, r0
mul oT1.xyz, r0, c13.x
dp4 r0.x, v0, c2
dp3 oT2.z, r1, c10
dp3 oT2.y, r1, c9
dp3 oT2.x, r1, c8
dp4 oPos.w, v0, c7
dp4 oPos.z, v0, c6
dp4 oPos.y, v0, c5
dp4 oPos.x, v0, c4
mov oT1.w, -r0.x
"
				}
				SubProgram "d3d11 " {
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					304
					Float 212[_tiling]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 192[_Object2World]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityPerDraw"
					1 "vs_4_0
eefiecedaamlimmkfplliemhomeemkdailchlbopabaaaaaakaaeaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
bmadaaaaeaaaabaamhaaaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaae
egiocaaaabaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadbcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaaaaaaaaaaegbabaaa
adaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaghccabaaaabaaaaaaegacbaiaibaaaaaaaaaaaaaadiaaaaai
hccabaaaacaaaaaaegacbaaaaaaaaaaafgifcaaaaaaaaaaaanaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaabaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaabaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaagiccabaaaacaaaaaa
akaabaiaebaaaaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaa
pgipcaaaabaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiccaaaabaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaabaaaaaa
amaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaadaaaaaa
egiccaaaabaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadoaaaaab
"
				}
				SubProgram "d3d11_9x " {
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					304
					Float 212[_tiling]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 192[_Object2World]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityPerDraw"
					1 "vs_4_0_level_9_1
eefiecedfamdjfgjahadpadclhekondgjabiojdhabaaaaaaiiagaaaaaeaaaaaa
daaaaaaabeacaaaadiafaaaaaaagaaaaebgpgodjnmabaaaanmabaaaaaaacpopp
ieabaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaanaa
abaaabaaaaaaaaaaabaaaaaaaiaaacaaaaaaaaaaabaaamaaadaaakaaaaaaaaaa
abaabeaaabaaanaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeia
aeaaapjaabaaaaacaaaaadiaadaaoejaabaaaaacaaaaaeiaaeaaaajaceaaaaac
abaaahiaaaaaoeiacdaaaaacaaaaahoaabaaoeiaafaaaaadabaaahoaabaaoeia
abaaffkaafaaaaadaaaaabiaaaaaffjaahaakkkaaeaaaaaeaaaaabiaagaakkka
aaaaaajaaaaaaaiaaeaaaaaeaaaaabiaaiaakkkaaaaakkjaaaaaaaiaaeaaaaae
aaaaabiaajaakkkaaaaappjaaaaaaaiaabaaaaacabaaaioaaaaaaaibafaaaaad
aaaaahiaacaaoejaanaappkaafaaaaadabaaahiaaaaaffiaalaaoekaaeaaaaae
aaaaaliaakaakekaaaaaaaiaabaakeiaaeaaaaaeacaaahoaamaaoekaaaaakkia
aaaapeiaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapiaacaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoeka
aaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefcbmadaaaaeaaaabaa
mhaaaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaadbcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafdcaabaaaaaaaaaaaegbabaaaadaaaaaadgaaaaaf
ecaabaaaaaaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaag
hccabaaaabaaaaaaegacbaiaibaaaaaaaaaaaaaadiaaaaaihccabaaaacaaaaaa
egacbaaaaaaaaaaafgifcaaaaaaaaaaaanaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaabaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaabaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaabaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaagiccabaaaacaaaaaaakaabaiaebaaaaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaabaaaaaa
beaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaabaaaaaa
anaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaabaaaaaaamaaaaaaagaabaaa
aaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaabaaaaaa
aoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadoaaaaabejfdeheomaaaaaaa
agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
kbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaa
ljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeo
aafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaakl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
				}
			}
			Program "fp" {
				SubProgram "opengl " {
					Float 0[_Shininess]
					"!!ARBfp1.0
PARAM c[2] = { program.local[0],
		{ 0.5 } };
MAD result.color.xyz, fragment.texcoord[2], c[1].x, c[1].x;
MOV result.color.w, c[0].x;
END
# 2 instructions, 0 R-regs
"
				}
				SubProgram "d3d9 " {
					Float 0[_Shininess]
					"ps_2_0
def c1, 0.50000000, 0, 0, 0
dcl t2.xyz
mad_pp r0.xyz, t2, c1.x, c1.x
mov_pp r0.w, c0.x
mov_pp oC0, r0
"
				}
				SubProgram "d3d11 " {
					ConstBuffer "$Globals"
					304
					Float 128[_Shininess]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedmfplakddmedcanonmoakfhdallphaecfabaaaaaahiabaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefciiaaaaaaeaaaaaaaccaaaaaafjaaaaaeegiocaaa
aaaaaaaaajaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaa
dcaaaaaphccabaaaaaaaaaaaegbcbaaaadaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadgaaaaag
iccabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					ConstBuffer "$Globals"
					304
					Float 128[_Shininess]
					BindCB "$Globals"
					0 "ps_4_0_level_9_1
eefiecedpmafklegjmpjdcnkpokhhmpeejennldgabaaaaaaamacaaaaaeaaaaaa
daaaaaaamaaaaaaafaabaaaaniabaaaaebgpgodjiiaaaaaaiiaaaaaaaaacpppp
fiaaaaaadaaaaaaaabaaceaaaaaadaaaaaaadaaaaaaaceaaaaaadaaaaaaaaiaa
abaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaadpaaaaaaaaaaaaaaaa
aaaaaaaabpaaaaacaaaaaaiaacaachlaaeaaaaaeaaaachiaacaaoelaabaaaaka
abaaaakaabaaaaacaaaaciiaaaaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefciiaaaaaaeaaaaaaaccaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
gcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaadcaaaaaphccabaaa
aaaaaaaaegbcbaaaadaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadgaaaaagiccabaaaaaaaaaaa
akiacaaaaaaaaaaaaiaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaahaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaapaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
				}
			}
		}
		Pass {
			Name "PREPASS"
			Tags {
				"LIGHTMODE" = "PrePassFinal"
			}
			ZWrite Off
			Blend SrcAlpha OneMinusSrcAlpha
			Program "vp" {
				SubProgram "opengl " {
					Keywords {
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_OFF"
					}
					Bind "vertex"
					Vertex
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Matrix 9[_Object2World]
					Vector 13[_ProjectionParams]
					Vector 14[unity_SHAr]
					Vector 15[unity_SHAg]
					Vector 16[unity_SHAb]
					Vector 17[unity_SHBr]
					Vector 18[unity_SHBg]
					Vector 19[unity_SHBb]
					Vector 20[unity_SHC]
					Vector 21[unity_Scale]
					Float 22[_tiling]
					"!!ARBvp1.0
PARAM c[23] = { { 0.5, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..22] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[21].w;
DP3 R2.w, R1, c[10];
DP3 R0.x, R1, c[9];
DP3 R0.z, R1, c[11];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].y;
DP4 R2.z, R0, c[16];
DP4 R2.y, R0, c[15];
DP4 R2.x, R0, c[14];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[19];
DP4 R3.y, R1, c[18];
DP4 R3.x, R1, c[17];
DP4 R1.w, vertex.position, c[8];
DP4 R1.z, vertex.position, c[7];
MAD R0.x, R0, R0, -R0.y;
ADD R3.xyz, R2, R3;
MUL R2.xyz, R0.x, c[20];
ADD result.texcoord[3].xyz, R3, R2;
DP4 R1.x, vertex.position, c[5];
DP4 R1.y, vertex.position, c[6];
MUL R0.xyz, R1.xyww, c[0].x;
MUL R0.y, R0, c[13].x;
MOV R2.z, vertex.texcoord[1].x;
MOV R2.xy, vertex.texcoord[0];
ADD result.texcoord[2].xy, R0, R0.z;
DP3 R0.w, R2, R2;
RSQ R0.x, R0.w;
MUL R0.xyz, R0.x, R2;
ABS result.texcoord[0].xyz, R0;
MUL result.texcoord[1].xyz, R0, c[22].x;
DP4 R0.x, vertex.position, c[3];
MOV result.position, R1;
MOV result.texcoord[2].zw, R1;
MOV result.texcoord[1].w, -R0.x;
END
# 36 instructions, 4 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_OFF"
					}
					Bind "vertex"
					Vertex
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 8[_Object2World]
					Vector 12[_ProjectionParams]
					Vector 13[_ScreenParams]
					Vector 14[unity_SHAr]
					Vector 15[unity_SHAg]
					Vector 16[unity_SHAb]
					Vector 17[unity_SHBr]
					Vector 18[unity_SHBg]
					Vector 19[unity_SHBb]
					Vector 20[unity_SHC]
					Vector 21[unity_Scale]
					Float 22[_tiling]
					"vs_2_0
def c23, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
mul r1.xyz, v1, c21.w
dp3 r2.w, r1, c9
dp3 r0.x, r1, c8
dp3 r0.z, r1, c10
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c23.y
dp4 r2.z, r0, c16
dp4 r2.y, r0, c15
dp4 r2.x, r0, c14
mul r0.y, r2.w, r2.w
dp4 r3.z, r1, c19
dp4 r3.y, r1, c18
dp4 r3.x, r1, c17
dp4 r1.w, v0, c7
dp4 r1.z, v0, c6
mad r0.x, r0, r0, -r0.y
add r3.xyz, r2, r3
mul r2.xyz, r0.x, c20
add oT3.xyz, r3, r2
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r0.xyz, r1.xyww, c23.x
mul r0.y, r0, c12.x
mad oT2.xy, r0.z, c13.zwzw, r0
mov r2.z, v3.x
mov r2.xy, v2
dp3 r0.w, r2, r2
rsq r0.x, r0.w
mul r0.xyz, r0.x, r2
abs oT0.xyz, r0
mul oT1.xyz, r0, c22.x
dp4 r0.x, v0, c2
mov oPos, r1
mov oT2.zw, r1
mov oT1.w, -r0.x
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_OFF"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					320
					Float 212[_tiling]
					ConstBuffer "UnityPerCamera"
					128
					Vector 80[_ProjectionParams]
					ConstBuffer "UnityLighting"
					720
					Vector 608[unity_SHAr]
					Vector 624[unity_SHAg]
					Vector 640[unity_SHAb]
					Vector 656[unity_SHBr]
					Vector 672[unity_SHBg]
					Vector 688[unity_SHBb]
					Vector 704[unity_SHC]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 192[_Object2World]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityLighting"
					2
					BindCB "UnityPerDraw"
					3 "vs_4_0
eefiecedehojkncdmopemgdficlpeafcknhbcjjaabaaaaaaoiagaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcemafaaaaeaaaabaa
fdabaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaadbcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacaeaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaadgaaaaaf
ecaabaaaabaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaag
hccabaaaabaaaaaaegacbaiaibaaaaaaabaaaaaadiaaaaaihccabaaaacaaaaaa
egacbaaaabaaaaaafgifcaaaaaaaaaaaanaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaabaaaaaa
ckiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaak
bcaabaaaabaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
abaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaabaaaaaadgaaaaagiccabaaaacaaaaaaakaabaiaebaaaaaa
abaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaai
hcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
lcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaa
aaaaaaaaegadbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaabaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaaaaaaaaa
bbaaaaaiccaabaaaabaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaaaaaaaaa
bbaaaaaiecaabaaaabaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaaaaaaaaa
diaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaai
bcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaai
ccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaai
ecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadcaaaaak
hccabaaaaeaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_OFF"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					320
					Float 212[_tiling]
					ConstBuffer "UnityPerCamera"
					128
					Vector 80[_ProjectionParams]
					ConstBuffer "UnityLighting"
					720
					Vector 608[unity_SHAr]
					Vector 624[unity_SHAg]
					Vector 640[unity_SHAb]
					Vector 656[unity_SHBr]
					Vector 672[unity_SHBg]
					Vector 688[unity_SHBb]
					Vector 704[unity_SHC]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 192[_Object2World]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityLighting"
					2
					BindCB "UnityPerDraw"
					3 "vs_4_0_level_9_1
eefiecedpgmkngfkpdfonkgokccgnglogjfcejfgabaaaaaabaakaaaaaeaaaaaa
daaaaaaafeadaaaakiaiaaaahaajaaaaebgpgodjbmadaaaabmadaaaaaaacpopp
kmacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaanaa
abaaabaaaaaaaaaaabaaafaaabaaacaaaaaaaaaaacaacgaaahaaadaaaaaaaaaa
adaaaaaaaiaaakaaaaaaaaaaadaaamaaadaabcaaaaaaaaaaadaabeaaabaabfaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbgaaapkaaaaaaadpaaaaiadpaaaaaaaa
aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjaabaaaaacaaaaadiaadaaoeja
abaaaaacaaaaaeiaaeaaaajaceaaaaacabaaahiaaaaaoeiacdaaaaacaaaaahoa
abaaoeiaafaaaaadabaaahoaabaaoeiaabaaffkaafaaaaadaaaaabiaaaaaffja
apaakkkaaeaaaaaeaaaaabiaaoaakkkaaaaaaajaaaaaaaiaaeaaaaaeaaaaabia
baaakkkaaaaakkjaaaaaaaiaaeaaaaaeaaaaabiabbaakkkaaaaappjaaaaaaaia
abaaaaacabaaaioaaaaaaaibafaaaaadaaaaapiaaaaaffjaalaaoekaaeaaaaae
aaaaapiaakaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaamaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaanaaoekaaaaappjaaaaaoeiaafaaaaadabaaabia
aaaaffiaacaaaakaafaaaaadabaaaiiaabaaaaiabgaaaakaafaaaaadabaaafia
aaaapeiabgaaaakaacaaaaadacaaadoaabaakkiaabaaomiaafaaaaadabaaahia
acaaoejabfaappkaafaaaaadacaaahiaabaaffiabdaaoekaaeaaaaaeabaaalia
bcaakekaabaaaaiaacaakeiaaeaaaaaeabaaahiabeaaoekaabaakkiaabaapeia
abaaaaacabaaaiiabgaaffkaajaaaaadacaaabiaadaaoekaabaaoeiaajaaaaad
acaaaciaaeaaoekaabaaoeiaajaaaaadacaaaeiaafaaoekaabaaoeiaafaaaaad
adaaapiaabaacjiaabaakeiaajaaaaadaeaaabiaagaaoekaadaaoeiaajaaaaad
aeaaaciaahaaoekaadaaoeiaajaaaaadaeaaaeiaaiaaoekaadaaoeiaacaaaaad
acaaahiaacaaoeiaaeaaoeiaafaaaaadabaaaciaabaaffiaabaaffiaaeaaaaae
abaaabiaabaaaaiaabaaaaiaabaaffibaeaaaaaeadaaahoaajaaoekaabaaaaia
acaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacacaaamoaaaaaoeiappppaaaafdeieefcemafaaaaeaaaabaa
fdabaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaadbcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacaeaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaadgaaaaaf
ecaabaaaabaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaag
hccabaaaabaaaaaaegacbaiaibaaaaaaabaaaaaadiaaaaaihccabaaaacaaaaaa
egacbaaaabaaaaaafgifcaaaaaaaaaaaanaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaabaaaaaa
ckiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaak
bcaabaaaabaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
abaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaabaaaaaadgaaaaagiccabaaaacaaaaaaakaabaiaebaaaaaa
abaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaai
hcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
lcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaa
aaaaaaaaegadbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaabaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaaaaaaaaa
bbaaaaaiccaabaaaabaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaaaaaaaaa
bbaaaaaiecaabaaaabaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaaaaaaaaa
diaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaai
bcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaai
ccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaai
ecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadcaaaaak
hccabaaaaeaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
laaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaa
feeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaa
iaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaahaiaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaapaaaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
imaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
				}
				SubProgram "opengl " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_OFF"
					}
					Bind "vertex"
					Vertex
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Matrix 9[_Object2World]
					Vector 13[_ProjectionParams]
					Vector 14[unity_ShadowFadeCenterAndType]
					Float 15[_tiling]
					Vector 16[unity_LightmapST]
					"!!ARBvp1.0
PARAM c[17] = { { 0.5, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..16] };
TEMP R0;
TEMP R1;
TEMP R2;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R2.xyz, R0.xyww, c[0].x;
MUL R2.y, R2, c[13].x;
MOV R1.z, vertex.texcoord[1].x;
MOV R1.xy, vertex.texcoord[0];
DP3 R0.z, R1, R1;
RSQ R1.w, R0.z;
MUL R1.xyz, R1.w, R1;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
MOV R0.x, c[0].y;
ADD R0.y, R0.x, -c[14].w;
DP4 R0.x, vertex.position, c[3];
ABS result.texcoord[0].xyz, R1;
MUL result.texcoord[1].xyz, R1, c[15].x;
DP4 R1.z, vertex.position, c[11];
DP4 R1.x, vertex.position, c[9];
DP4 R1.y, vertex.position, c[10];
ADD R1.xyz, R1, -c[14];
ADD result.texcoord[2].xy, R2, R2.z;
MOV result.texcoord[2].zw, R0;
MUL result.texcoord[4].xyz, R1, c[14].w;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[16], c[16].zwzw;
MUL result.texcoord[4].w, -R0.x, R0.y;
MOV result.texcoord[1].w, -R0.x;
END
# 27 instructions, 3 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_OFF"
					}
					Bind "vertex"
					Vertex
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 8[_Object2World]
					Vector 12[_ProjectionParams]
					Vector 13[_ScreenParams]
					Vector 14[unity_ShadowFadeCenterAndType]
					Float 15[_tiling]
					Vector 16[unity_LightmapST]
					"vs_2_0
def c17, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r2.xyz, r0.xyww, c17.x
mul r2.y, r2, c12.x
mov r1.z, v2.x
mov r1.xy, v1
dp3 r0.z, r1, r1
rsq r1.w, r0.z
mul r1.xyz, r1.w, r1
dp4 r0.z, v0, c6
mov oPos, r0
mov r0.x, c14.w
add r0.y, c17, -r0.x
dp4 r0.x, v0, c2
abs oT0.xyz, r1
mul oT1.xyz, r1, c15.x
dp4 r1.z, v0, c10
dp4 r1.x, v0, c8
dp4 r1.y, v0, c9
add r1.xyz, r1, -c14
mad oT2.xy, r2.z, c13.zwzw, r2
mov oT2.zw, r0
mul oT4.xyz, r1, c14.w
mad oT3.xy, v2, c16, c16.zwzw
mul oT4.w, -r0.x, r0.y
mov oT1.w, -r0.x
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_OFF"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					352
					Float 212[_tiling]
					Vector 304[unity_LightmapST]
					ConstBuffer "UnityPerCamera"
					128
					Vector 80[_ProjectionParams]
					ConstBuffer "UnityShadows"
					416
					Vector 400[unity_ShadowFadeCenterAndType]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 192[_Object2World]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityShadows"
					2
					BindCB "UnityPerDraw"
					3 "vs_4_0
eefiecedmcpicplfdnmbnkgbhjmjnhlcbkgokkmkabaaaaaaeeagaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcjaaeaaaaeaaaabaaceabaaaafjaaaaae
egiocaaaaaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaabkaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaa
gfaaaaadpccabaaaafaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaabaaaaaa
akbabaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaabaaaaaa
egacbaiaibaaaaaaabaaaaaadiaaaaaihccabaaaacaaaaaaegacbaaaabaaaaaa
fgifcaaaaaaaaaaaanaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaaaaaaaaa
ckiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaadaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaa
ckiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaak
bcaabaaaabaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
abaaaaaadgaaaaagiccabaaaacaaaaaaakaabaiaebaaaaaaabaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaacaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaa
adaaaaaakgakbaaaacaaaaaamgaabaaaacaaaaaadcaaaaaldccabaaaaeaaaaaa
egbabaaaaeaaaaaaegiacaaaaaaaaaaabdaaaaaaogikcaaaaaaaaaaabdaaaaaa
aaaaaaajbcaabaaaaaaaaaaadkiacaiaebaaaaaaacaaaaaabjaaaaaaabeaaaaa
aaaaiadpdiaaaaaiiccabaaaafaaaaaaakaabaaaaaaaaaaaakaabaiaebaaaaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaabjaaaaaa
diaaaaaihccabaaaafaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaabjaaaaaa
doaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_OFF"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					352
					Float 212[_tiling]
					Vector 304[unity_LightmapST]
					ConstBuffer "UnityPerCamera"
					128
					Vector 80[_ProjectionParams]
					ConstBuffer "UnityShadows"
					416
					Vector 400[unity_ShadowFadeCenterAndType]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 192[_Object2World]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityShadows"
					2
					BindCB "UnityPerDraw"
					3 "vs_4_0_level_9_1
eefiecedcncdmhmclidnpeknibalmbpfibgfiicfabaaaaaaaaajaaaaaeaaaaaa
daaaaaaaoiacaaaaiaahaaaaeiaiaaaaebgpgodjlaacaaaalaacaaaaaaacpopp
eaacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaanaa
abaaabaaaaaaaaaaaaaabdaaabaaacaaaaaaaaaaabaaafaaabaaadaaaaaaaaaa
acaabjaaabaaaeaaaaaaaaaaadaaaaaaaiaaafaaaaaaaaaaadaaamaaaeaaanaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbbaaapkaaaaaaadpaaaaiadpaaaaaaaa
aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaadiaadaaapjabpaaaaac
afaaaeiaaeaaapjaabaaaaacaaaaadiaadaaoejaabaaaaacaaaaaeiaaeaaaaja
ceaaaaacabaaahiaaaaaoeiacdaaaaacaaaaahoaabaaoeiaafaaaaadabaaahoa
abaaoeiaabaaffkaafaaaaadaaaaapiaaaaaffjaagaaoekaaeaaaaaeaaaaapia
afaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaahaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaaiaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffia
adaaaakaafaaaaadabaaaiiaabaaaaiabbaaaakaafaaaaadabaaafiaaaaapeia
bbaaaakaacaaaaadacaaadoaabaakkiaabaaomiaaeaaaaaeadaaadoaaeaaoeja
acaaoekaacaaookaafaaaaadabaaahiaaaaaffjaaoaaoekaaeaaaaaeabaaahia
anaaoekaaaaaaajaabaaoeiaaeaaaaaeabaaahiaapaaoekaaaaakkjaabaaoeia
aeaaaaaeabaaahiabaaaoekaaaaappjaabaaoeiaacaaaaadabaaahiaabaaoeia
aeaaoekbafaaaaadaeaaahoaabaaoeiaaeaappkaafaaaaadabaaabiaaaaaffja
akaakkkaaeaaaaaeabaaabiaajaakkkaaaaaaajaabaaaaiaaeaaaaaeabaaabia
alaakkkaaaaakkjaabaaaaiaaeaaaaaeabaaabiaamaakkkaaaaappjaabaaaaia
abaaaaacabaaaiiaaeaappkaacaaaaadabaaaciaabaappibbbaaffkaafaaaaad
aeaaaioaabaaffiaabaaaaibabaaaaacabaaaioaabaaaaibaeaaaaaeaaaaadma
aaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacacaaamoa
aaaaoeiappppaaaafdeieefcjaaeaaaaeaaaabaaceabaaaafjaaaaaeegiocaaa
aaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaabkaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaad
pccabaaaafaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
dcaabaaaabaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaabaaaaaaakbabaaa
aeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaabaaaaaaegacbaia
ibaaaaaaabaaaaaadiaaaaaihccabaaaacaaaaaaegacbaaaabaaaaaafgifcaaa
aaaaaaaaanaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaaaaaaaaackiacaaa
adaaaaaaafaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaadaaaaaaaeaaaaaa
akbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaa
adaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaa
abaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaabaaaaaa
dgaaaaagiccabaaaacaaaaaaakaabaiaebaaaaaaabaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
acaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaa
kgakbaaaacaaaaaamgaabaaaacaaaaaadcaaaaaldccabaaaaeaaaaaaegbabaaa
aeaaaaaaegiacaaaaaaaaaaabdaaaaaaogikcaaaaaaaaaaabdaaaaaaaaaaaaaj
bcaabaaaaaaaaaaadkiacaiaebaaaaaaacaaaaaabjaaaaaaabeaaaaaaaaaiadp
diaaaaaiiccabaaaafaaaaaaakaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaabjaaaaaadiaaaaai
hccabaaaafaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaabjaaaaaadoaaaaab
ejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
kjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaalaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaa
faepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfcee
aaedepemepfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaahaiaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaa
keaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaadamaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
				}
				SubProgram "opengl " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
						"HDR_LIGHT_PREPASS_OFF"
					}
					Bind "vertex"
					Vertex
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Bind "tangent"
					ATTR14
					Matrix 9[_World2Object]
					Vector 13[_WorldSpaceCameraPos]
					Vector 14[_ProjectionParams]
					Vector 15[unity_Scale]
					Float 16[_tiling]
					Vector 17[unity_LightmapST]
					"!!ARBvp1.0
PARAM c[18] = { { 0.5, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..17] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R1.xyz, c[13];
MOV R1.w, c[0].y;
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[15].w, -vertex.position;
MUL R3.xyz, R0, vertex.attrib[14].w;
DP4 R1.w, vertex.position, c[8];
DP4 R1.z, vertex.position, c[7];
DP4 R1.x, vertex.position, c[5];
DP4 R1.y, vertex.position, c[6];
MUL R0.xyz, R1.xyww, c[0].x;
MUL R0.y, R0, c[14].x;
ADD result.texcoord[2].xy, R0, R0.z;
MOV R0.z, vertex.texcoord[1].x;
MOV R0.xy, vertex.texcoord[0];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
ABS result.texcoord[0].xyz, R0;
MUL result.texcoord[1].xyz, R0, c[16].x;
DP4 R0.x, vertex.position, c[3];
DP3 result.texcoord[4].y, R2, R3;
DP3 result.texcoord[4].z, vertex.normal, R2;
DP3 result.texcoord[4].x, R2, vertex.attrib[14];
MOV result.position, R1;
MOV result.texcoord[2].zw, R1;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[17], c[17].zwzw;
MOV result.texcoord[1].w, -R0.x;
END
# 32 instructions, 4 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
						"HDR_LIGHT_PREPASS_OFF"
					}
					Bind "vertex"
					Vertex
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Bind "tangent"
					TexCoord2
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 8[_World2Object]
					Vector 12[_WorldSpaceCameraPos]
					Vector 13[_ProjectionParams]
					Vector 14[_ScreenParams]
					Vector 15[unity_Scale]
					Float 16[_tiling]
					Vector 17[unity_LightmapST]
					"vs_2_0
def c18, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mov r1.xyz, c12
mov r1.w, c18.y
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c15.w, -v0
mul r3.xyz, r0, v1.w
dp4 r1.w, v0, c7
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r0.xyz, r1.xyww, c18.x
mul r0.y, r0, c13.x
mad oT2.xy, r0.z, c14.zwzw, r0
mov r0.z, v4.x
mov r0.xy, v3
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
abs oT0.xyz, r0
mul oT1.xyz, r0, c16.x
dp4 r0.x, v0, c2
dp3 oT4.y, r2, r3
dp3 oT4.z, v2, r2
dp3 oT4.x, r2, v1
mov oPos, r1
mov oT2.zw, r1
mad oT3.xy, v4, c17, c17.zwzw
mov oT1.w, -r0.x
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
						"HDR_LIGHT_PREPASS_OFF"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Bind "tangent"
					TexCoord2
					ConstBuffer "$Globals"
					352
					Float 212[_tiling]
					Vector 304[unity_LightmapST]
					ConstBuffer "UnityPerCamera"
					128
					Vector 64[_WorldSpaceCameraPos] 3
					Vector 80[_ProjectionParams]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 256[_World2Object]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityPerDraw"
					2 "vs_4_0
eefiecedghcgkooglejgbcjenjnjlghcdodcbdmiabaaaaaakiagaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcpeaeaaaaeaaaabaadnabaaaafjaaaaae
egiocaaaaaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
dccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaadgaaaaaf
ecaabaaaabaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaag
hccabaaaabaaaaaaegacbaiaibaaaaaaabaaaaaadiaaaaaihccabaaaacaaaaaa
egacbaaaabaaaaaafgifcaaaaaaaaaaaanaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaabaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaak
bcaabaaaabaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
abaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaabaaaaaadgaaaaagiccabaaaacaaaaaaakaabaiaebaaaaaa
abaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadcaaaaal
dccabaaaaeaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaabdaaaaaaogikcaaa
aaaaaaaabdaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaa
acaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaa
egacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
pgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaa
egiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaa
baaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaa
abaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaacaaaaaa
bdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaacaaaaaa
beaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaafaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaafaaaaaaegbcbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaaheccabaaaafaaaaaaegbcbaaaacaaaaaaegacbaaa
abaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
						"HDR_LIGHT_PREPASS_OFF"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Bind "tangent"
					TexCoord2
					ConstBuffer "$Globals"
					352
					Float 212[_tiling]
					Vector 304[unity_LightmapST]
					ConstBuffer "UnityPerCamera"
					128
					Vector 64[_WorldSpaceCameraPos] 3
					Vector 80[_ProjectionParams]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 256[_World2Object]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityPerDraw"
					2 "vs_4_0_level_9_1
eefiecedlnpgiaimcjpnbmicjmdiedhgnhcppiniabaaaaaalaajaaaaaeaaaaaa
daaaaaaadeadaaaadaaiaaaapiaiaaaaebgpgodjpmacaaaapmacaaaaaaacpopp
jiacaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaanaa
abaaabaaaaaaaaaaaaaabdaaabaaacaaaaaaaaaaabaaaeaaacaaadaaaaaaaaaa
acaaaaaaaiaaafaaaaaaaaaaacaabaaaafaaanaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafbcaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjaabaaaaacaaaaadiaadaaoeja
abaaaaacaaaaaeiaaeaaaajaceaaaaacabaaahiaaaaaoeiacdaaaaacaaaaahoa
abaaoeiaafaaaaadabaaahoaabaaoeiaabaaffkaafaaaaadaaaaabiaaaaaffja
akaakkkaaeaaaaaeaaaaabiaajaakkkaaaaaaajaaaaaaaiaaeaaaaaeaaaaabia
alaakkkaaaaakkjaaaaaaaiaaeaaaaaeaaaaabiaamaakkkaaaaappjaaaaaaaia
abaaaaacabaaaioaaaaaaaibafaaaaadaaaaapiaaaaaffjaagaaoekaaeaaaaae
aaaaapiaafaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaahaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaaiaaoekaaaaappjaaaaaoeiaafaaaaadabaaabia
aaaaffiaaeaaaakaafaaaaadabaaaiiaabaaaaiabcaaaakaafaaaaadabaaafia
aaaapeiabcaaaakaacaaaaadacaaadoaabaakkiaabaaomiaaeaaaaaeadaaadoa
aeaaoejaacaaoekaacaaookaabaaaaacabaaahiaadaaoekaafaaaaadacaaahia
abaaffiaaoaaoekaaeaaaaaeabaaaliaanaakekaabaaaaiaacaakeiaaeaaaaae
abaaahiaapaaoekaabaakkiaabaapeiaacaaaaadabaaahiaabaaoeiabaaaoeka
aeaaaaaeabaaahiaabaaoeiabbaappkaaaaaoejbaiaaaaadaeaaaboaabaaoeja
abaaoeiaabaaaaacacaaahiaabaaoejaafaaaaadadaaahiaacaamjiaacaancja
aeaaaaaeacaaahiaacaamjjaacaanciaadaaoeibafaaaaadacaaahiaacaaoeia
abaappjaaiaaaaadaeaaacoaacaaoeiaabaaoeiaaiaaaaadaeaaaeoaacaaoeja
abaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacacaaamoaaaaaoeiappppaaaafdeieefcpeaeaaaaeaaaabaa
dnabaaaafjaaaaaeegiocaaaaaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaaabaaaaaaegbabaaa
adaaaaaadgaaaaafecaabaaaabaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaa
abaaaaaadgaaaaaghccabaaaabaaaaaaegacbaiaibaaaaaaabaaaaaadiaaaaai
hccabaaaacaaaaaaegacbaaaabaaaaaafgifcaaaaaaaaaaaanaaaaaadiaaaaai
bcaabaaaabaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaak
bcaabaaaabaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
abaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaacaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaacaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaabaaaaaadgaaaaagiccabaaaacaaaaaa
akaabaiaebaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaadaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadcaaaaaldccabaaaaeaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaa
bdaaaaaaogikcaaaaaaaaaaabdaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaa
abaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaa
cgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaa
abaaaaaaaeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaa
aeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaaaacaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgipcaaaacaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaa
afaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaafaaaaaa
egbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaafaaaaaaegbcbaaa
acaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaa
agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
keaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaakeaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaa
keaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
				}
				SubProgram "opengl " {
					Keywords {
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_ON"
					}
					Bind "vertex"
					Vertex
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Matrix 9[_Object2World]
					Vector 13[_ProjectionParams]
					Vector 14[unity_SHAr]
					Vector 15[unity_SHAg]
					Vector 16[unity_SHAb]
					Vector 17[unity_SHBr]
					Vector 18[unity_SHBg]
					Vector 19[unity_SHBb]
					Vector 20[unity_SHC]
					Vector 21[unity_Scale]
					Float 22[_tiling]
					"!!ARBvp1.0
PARAM c[23] = { { 0.5, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..22] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[21].w;
DP3 R2.w, R1, c[10];
DP3 R0.x, R1, c[9];
DP3 R0.z, R1, c[11];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].y;
DP4 R2.z, R0, c[16];
DP4 R2.y, R0, c[15];
DP4 R2.x, R0, c[14];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[19];
DP4 R3.y, R1, c[18];
DP4 R3.x, R1, c[17];
DP4 R1.w, vertex.position, c[8];
DP4 R1.z, vertex.position, c[7];
MAD R0.x, R0, R0, -R0.y;
ADD R3.xyz, R2, R3;
MUL R2.xyz, R0.x, c[20];
ADD result.texcoord[3].xyz, R3, R2;
DP4 R1.x, vertex.position, c[5];
DP4 R1.y, vertex.position, c[6];
MUL R0.xyz, R1.xyww, c[0].x;
MUL R0.y, R0, c[13].x;
MOV R2.z, vertex.texcoord[1].x;
MOV R2.xy, vertex.texcoord[0];
ADD result.texcoord[2].xy, R0, R0.z;
DP3 R0.w, R2, R2;
RSQ R0.x, R0.w;
MUL R0.xyz, R0.x, R2;
ABS result.texcoord[0].xyz, R0;
MUL result.texcoord[1].xyz, R0, c[22].x;
DP4 R0.x, vertex.position, c[3];
MOV result.position, R1;
MOV result.texcoord[2].zw, R1;
MOV result.texcoord[1].w, -R0.x;
END
# 36 instructions, 4 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_ON"
					}
					Bind "vertex"
					Vertex
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 8[_Object2World]
					Vector 12[_ProjectionParams]
					Vector 13[_ScreenParams]
					Vector 14[unity_SHAr]
					Vector 15[unity_SHAg]
					Vector 16[unity_SHAb]
					Vector 17[unity_SHBr]
					Vector 18[unity_SHBg]
					Vector 19[unity_SHBb]
					Vector 20[unity_SHC]
					Vector 21[unity_Scale]
					Float 22[_tiling]
					"vs_2_0
def c23, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
mul r1.xyz, v1, c21.w
dp3 r2.w, r1, c9
dp3 r0.x, r1, c8
dp3 r0.z, r1, c10
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c23.y
dp4 r2.z, r0, c16
dp4 r2.y, r0, c15
dp4 r2.x, r0, c14
mul r0.y, r2.w, r2.w
dp4 r3.z, r1, c19
dp4 r3.y, r1, c18
dp4 r3.x, r1, c17
dp4 r1.w, v0, c7
dp4 r1.z, v0, c6
mad r0.x, r0, r0, -r0.y
add r3.xyz, r2, r3
mul r2.xyz, r0.x, c20
add oT3.xyz, r3, r2
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r0.xyz, r1.xyww, c23.x
mul r0.y, r0, c12.x
mad oT2.xy, r0.z, c13.zwzw, r0
mov r2.z, v3.x
mov r2.xy, v2
dp3 r0.w, r2, r2
rsq r0.x, r0.w
mul r0.xyz, r0.x, r2
abs oT0.xyz, r0
mul oT1.xyz, r0, c22.x
dp4 r0.x, v0, c2
mov oPos, r1
mov oT2.zw, r1
mov oT1.w, -r0.x
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_ON"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					320
					Float 212[_tiling]
					ConstBuffer "UnityPerCamera"
					128
					Vector 80[_ProjectionParams]
					ConstBuffer "UnityLighting"
					720
					Vector 608[unity_SHAr]
					Vector 624[unity_SHAg]
					Vector 640[unity_SHAb]
					Vector 656[unity_SHBr]
					Vector 672[unity_SHBg]
					Vector 688[unity_SHBb]
					Vector 704[unity_SHC]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 192[_Object2World]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityLighting"
					2
					BindCB "UnityPerDraw"
					3 "vs_4_0
eefiecedehojkncdmopemgdficlpeafcknhbcjjaabaaaaaaoiagaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcemafaaaaeaaaabaa
fdabaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaadbcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacaeaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaadgaaaaaf
ecaabaaaabaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaag
hccabaaaabaaaaaaegacbaiaibaaaaaaabaaaaaadiaaaaaihccabaaaacaaaaaa
egacbaaaabaaaaaafgifcaaaaaaaaaaaanaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaabaaaaaa
ckiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaak
bcaabaaaabaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
abaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaabaaaaaadgaaaaagiccabaaaacaaaaaaakaabaiaebaaaaaa
abaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaai
hcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
lcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaa
aaaaaaaaegadbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaabaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaaaaaaaaa
bbaaaaaiccaabaaaabaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaaaaaaaaa
bbaaaaaiecaabaaaabaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaaaaaaaaa
diaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaai
bcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaai
ccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaai
ecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadcaaaaak
hccabaaaaeaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_ON"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					320
					Float 212[_tiling]
					ConstBuffer "UnityPerCamera"
					128
					Vector 80[_ProjectionParams]
					ConstBuffer "UnityLighting"
					720
					Vector 608[unity_SHAr]
					Vector 624[unity_SHAg]
					Vector 640[unity_SHAb]
					Vector 656[unity_SHBr]
					Vector 672[unity_SHBg]
					Vector 688[unity_SHBb]
					Vector 704[unity_SHC]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 192[_Object2World]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityLighting"
					2
					BindCB "UnityPerDraw"
					3 "vs_4_0_level_9_1
eefiecedpgmkngfkpdfonkgokccgnglogjfcejfgabaaaaaabaakaaaaaeaaaaaa
daaaaaaafeadaaaakiaiaaaahaajaaaaebgpgodjbmadaaaabmadaaaaaaacpopp
kmacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaanaa
abaaabaaaaaaaaaaabaaafaaabaaacaaaaaaaaaaacaacgaaahaaadaaaaaaaaaa
adaaaaaaaiaaakaaaaaaaaaaadaaamaaadaabcaaaaaaaaaaadaabeaaabaabfaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbgaaapkaaaaaaadpaaaaiadpaaaaaaaa
aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjaabaaaaacaaaaadiaadaaoeja
abaaaaacaaaaaeiaaeaaaajaceaaaaacabaaahiaaaaaoeiacdaaaaacaaaaahoa
abaaoeiaafaaaaadabaaahoaabaaoeiaabaaffkaafaaaaadaaaaabiaaaaaffja
apaakkkaaeaaaaaeaaaaabiaaoaakkkaaaaaaajaaaaaaaiaaeaaaaaeaaaaabia
baaakkkaaaaakkjaaaaaaaiaaeaaaaaeaaaaabiabbaakkkaaaaappjaaaaaaaia
abaaaaacabaaaioaaaaaaaibafaaaaadaaaaapiaaaaaffjaalaaoekaaeaaaaae
aaaaapiaakaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaamaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaanaaoekaaaaappjaaaaaoeiaafaaaaadabaaabia
aaaaffiaacaaaakaafaaaaadabaaaiiaabaaaaiabgaaaakaafaaaaadabaaafia
aaaapeiabgaaaakaacaaaaadacaaadoaabaakkiaabaaomiaafaaaaadabaaahia
acaaoejabfaappkaafaaaaadacaaahiaabaaffiabdaaoekaaeaaaaaeabaaalia
bcaakekaabaaaaiaacaakeiaaeaaaaaeabaaahiabeaaoekaabaakkiaabaapeia
abaaaaacabaaaiiabgaaffkaajaaaaadacaaabiaadaaoekaabaaoeiaajaaaaad
acaaaciaaeaaoekaabaaoeiaajaaaaadacaaaeiaafaaoekaabaaoeiaafaaaaad
adaaapiaabaacjiaabaakeiaajaaaaadaeaaabiaagaaoekaadaaoeiaajaaaaad
aeaaaciaahaaoekaadaaoeiaajaaaaadaeaaaeiaaiaaoekaadaaoeiaacaaaaad
acaaahiaacaaoeiaaeaaoeiaafaaaaadabaaaciaabaaffiaabaaffiaaeaaaaae
abaaabiaabaaaaiaabaaaaiaabaaffibaeaaaaaeadaaahoaajaaoekaabaaaaia
acaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacacaaamoaaaaaoeiappppaaaafdeieefcemafaaaaeaaaabaa
fdabaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaadbcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacaeaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaadgaaaaaf
ecaabaaaabaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaag
hccabaaaabaaaaaaegacbaiaibaaaaaaabaaaaaadiaaaaaihccabaaaacaaaaaa
egacbaaaabaaaaaafgifcaaaaaaaaaaaanaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaabaaaaaa
ckiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaak
bcaabaaaabaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
abaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaabaaaaaadgaaaaagiccabaaaacaaaaaaakaabaiaebaaaaaa
abaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaai
hcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
lcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaa
aaaaaaaaegadbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaabaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaaaaaaaaa
bbaaaaaiccaabaaaabaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaaaaaaaaa
bbaaaaaiecaabaaaabaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaaaaaaaaa
diaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaai
bcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaai
ccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaai
ecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadcaaaaak
hccabaaaaeaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
laaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaa
feeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaa
iaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaahaiaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaapaaaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
imaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
				}
				SubProgram "opengl " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_ON"
					}
					Bind "vertex"
					Vertex
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Matrix 9[_Object2World]
					Vector 13[_ProjectionParams]
					Vector 14[unity_ShadowFadeCenterAndType]
					Float 15[_tiling]
					Vector 16[unity_LightmapST]
					"!!ARBvp1.0
PARAM c[17] = { { 0.5, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..16] };
TEMP R0;
TEMP R1;
TEMP R2;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R2.xyz, R0.xyww, c[0].x;
MUL R2.y, R2, c[13].x;
MOV R1.z, vertex.texcoord[1].x;
MOV R1.xy, vertex.texcoord[0];
DP3 R0.z, R1, R1;
RSQ R1.w, R0.z;
MUL R1.xyz, R1.w, R1;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
MOV R0.x, c[0].y;
ADD R0.y, R0.x, -c[14].w;
DP4 R0.x, vertex.position, c[3];
ABS result.texcoord[0].xyz, R1;
MUL result.texcoord[1].xyz, R1, c[15].x;
DP4 R1.z, vertex.position, c[11];
DP4 R1.x, vertex.position, c[9];
DP4 R1.y, vertex.position, c[10];
ADD R1.xyz, R1, -c[14];
ADD result.texcoord[2].xy, R2, R2.z;
MOV result.texcoord[2].zw, R0;
MUL result.texcoord[4].xyz, R1, c[14].w;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[16], c[16].zwzw;
MUL result.texcoord[4].w, -R0.x, R0.y;
MOV result.texcoord[1].w, -R0.x;
END
# 27 instructions, 3 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_ON"
					}
					Bind "vertex"
					Vertex
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 8[_Object2World]
					Vector 12[_ProjectionParams]
					Vector 13[_ScreenParams]
					Vector 14[unity_ShadowFadeCenterAndType]
					Float 15[_tiling]
					Vector 16[unity_LightmapST]
					"vs_2_0
def c17, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r2.xyz, r0.xyww, c17.x
mul r2.y, r2, c12.x
mov r1.z, v2.x
mov r1.xy, v1
dp3 r0.z, r1, r1
rsq r1.w, r0.z
mul r1.xyz, r1.w, r1
dp4 r0.z, v0, c6
mov oPos, r0
mov r0.x, c14.w
add r0.y, c17, -r0.x
dp4 r0.x, v0, c2
abs oT0.xyz, r1
mul oT1.xyz, r1, c15.x
dp4 r1.z, v0, c10
dp4 r1.x, v0, c8
dp4 r1.y, v0, c9
add r1.xyz, r1, -c14
mad oT2.xy, r2.z, c13.zwzw, r2
mov oT2.zw, r0
mul oT4.xyz, r1, c14.w
mad oT3.xy, v2, c16, c16.zwzw
mul oT4.w, -r0.x, r0.y
mov oT1.w, -r0.x
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_ON"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					352
					Float 212[_tiling]
					Vector 304[unity_LightmapST]
					ConstBuffer "UnityPerCamera"
					128
					Vector 80[_ProjectionParams]
					ConstBuffer "UnityShadows"
					416
					Vector 400[unity_ShadowFadeCenterAndType]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 192[_Object2World]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityShadows"
					2
					BindCB "UnityPerDraw"
					3 "vs_4_0
eefiecedmcpicplfdnmbnkgbhjmjnhlcbkgokkmkabaaaaaaeeagaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcjaaeaaaaeaaaabaaceabaaaafjaaaaae
egiocaaaaaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaabkaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaa
gfaaaaadpccabaaaafaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaabaaaaaa
akbabaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaabaaaaaa
egacbaiaibaaaaaaabaaaaaadiaaaaaihccabaaaacaaaaaaegacbaaaabaaaaaa
fgifcaaaaaaaaaaaanaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaaaaaaaaa
ckiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaadaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaa
ckiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaak
bcaabaaaabaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
abaaaaaadgaaaaagiccabaaaacaaaaaaakaabaiaebaaaaaaabaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaacaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaa
adaaaaaakgakbaaaacaaaaaamgaabaaaacaaaaaadcaaaaaldccabaaaaeaaaaaa
egbabaaaaeaaaaaaegiacaaaaaaaaaaabdaaaaaaogikcaaaaaaaaaaabdaaaaaa
aaaaaaajbcaabaaaaaaaaaaadkiacaiaebaaaaaaacaaaaaabjaaaaaaabeaaaaa
aaaaiadpdiaaaaaiiccabaaaafaaaaaaakaabaaaaaaaaaaaakaabaiaebaaaaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaabjaaaaaa
diaaaaaihccabaaaafaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaabjaaaaaa
doaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_ON"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					352
					Float 212[_tiling]
					Vector 304[unity_LightmapST]
					ConstBuffer "UnityPerCamera"
					128
					Vector 80[_ProjectionParams]
					ConstBuffer "UnityShadows"
					416
					Vector 400[unity_ShadowFadeCenterAndType]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 192[_Object2World]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityShadows"
					2
					BindCB "UnityPerDraw"
					3 "vs_4_0_level_9_1
eefiecedcncdmhmclidnpeknibalmbpfibgfiicfabaaaaaaaaajaaaaaeaaaaaa
daaaaaaaoiacaaaaiaahaaaaeiaiaaaaebgpgodjlaacaaaalaacaaaaaaacpopp
eaacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaanaa
abaaabaaaaaaaaaaaaaabdaaabaaacaaaaaaaaaaabaaafaaabaaadaaaaaaaaaa
acaabjaaabaaaeaaaaaaaaaaadaaaaaaaiaaafaaaaaaaaaaadaaamaaaeaaanaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbbaaapkaaaaaaadpaaaaiadpaaaaaaaa
aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaadiaadaaapjabpaaaaac
afaaaeiaaeaaapjaabaaaaacaaaaadiaadaaoejaabaaaaacaaaaaeiaaeaaaaja
ceaaaaacabaaahiaaaaaoeiacdaaaaacaaaaahoaabaaoeiaafaaaaadabaaahoa
abaaoeiaabaaffkaafaaaaadaaaaapiaaaaaffjaagaaoekaaeaaaaaeaaaaapia
afaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaahaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaaiaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffia
adaaaakaafaaaaadabaaaiiaabaaaaiabbaaaakaafaaaaadabaaafiaaaaapeia
bbaaaakaacaaaaadacaaadoaabaakkiaabaaomiaaeaaaaaeadaaadoaaeaaoeja
acaaoekaacaaookaafaaaaadabaaahiaaaaaffjaaoaaoekaaeaaaaaeabaaahia
anaaoekaaaaaaajaabaaoeiaaeaaaaaeabaaahiaapaaoekaaaaakkjaabaaoeia
aeaaaaaeabaaahiabaaaoekaaaaappjaabaaoeiaacaaaaadabaaahiaabaaoeia
aeaaoekbafaaaaadaeaaahoaabaaoeiaaeaappkaafaaaaadabaaabiaaaaaffja
akaakkkaaeaaaaaeabaaabiaajaakkkaaaaaaajaabaaaaiaaeaaaaaeabaaabia
alaakkkaaaaakkjaabaaaaiaaeaaaaaeabaaabiaamaakkkaaaaappjaabaaaaia
abaaaaacabaaaiiaaeaappkaacaaaaadabaaaciaabaappibbbaaffkaafaaaaad
aeaaaioaabaaffiaabaaaaibabaaaaacabaaaioaabaaaaibaeaaaaaeaaaaadma
aaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacacaaamoa
aaaaoeiappppaaaafdeieefcjaaeaaaaeaaaabaaceabaaaafjaaaaaeegiocaaa
aaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaabkaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaad
pccabaaaafaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
dcaabaaaabaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaabaaaaaaakbabaaa
aeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaabaaaaaaegacbaia
ibaaaaaaabaaaaaadiaaaaaihccabaaaacaaaaaaegacbaaaabaaaaaafgifcaaa
aaaaaaaaanaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaaaaaaaaackiacaaa
adaaaaaaafaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaadaaaaaaaeaaaaaa
akbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaa
adaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaa
abaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaabaaaaaa
dgaaaaagiccabaaaacaaaaaaakaabaiaebaaaaaaabaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
acaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaa
kgakbaaaacaaaaaamgaabaaaacaaaaaadcaaaaaldccabaaaaeaaaaaaegbabaaa
aeaaaaaaegiacaaaaaaaaaaabdaaaaaaogikcaaaaaaaaaaabdaaaaaaaaaaaaaj
bcaabaaaaaaaaaaadkiacaiaebaaaaaaacaaaaaabjaaaaaaabeaaaaaaaaaiadp
diaaaaaiiccabaaaafaaaaaaakaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaabjaaaaaadiaaaaai
hccabaaaafaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaabjaaaaaadoaaaaab
ejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
kjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaalaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaa
faepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfcee
aaedepemepfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaahaiaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaa
keaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaadamaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
				}
				SubProgram "opengl " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
						"HDR_LIGHT_PREPASS_ON"
					}
					Bind "vertex"
					Vertex
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Bind "tangent"
					ATTR14
					Matrix 9[_World2Object]
					Vector 13[_WorldSpaceCameraPos]
					Vector 14[_ProjectionParams]
					Vector 15[unity_Scale]
					Float 16[_tiling]
					Vector 17[unity_LightmapST]
					"!!ARBvp1.0
PARAM c[18] = { { 0.5, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..17] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R1.xyz, c[13];
MOV R1.w, c[0].y;
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[15].w, -vertex.position;
MUL R3.xyz, R0, vertex.attrib[14].w;
DP4 R1.w, vertex.position, c[8];
DP4 R1.z, vertex.position, c[7];
DP4 R1.x, vertex.position, c[5];
DP4 R1.y, vertex.position, c[6];
MUL R0.xyz, R1.xyww, c[0].x;
MUL R0.y, R0, c[14].x;
ADD result.texcoord[2].xy, R0, R0.z;
MOV R0.z, vertex.texcoord[1].x;
MOV R0.xy, vertex.texcoord[0];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
ABS result.texcoord[0].xyz, R0;
MUL result.texcoord[1].xyz, R0, c[16].x;
DP4 R0.x, vertex.position, c[3];
DP3 result.texcoord[4].y, R2, R3;
DP3 result.texcoord[4].z, vertex.normal, R2;
DP3 result.texcoord[4].x, R2, vertex.attrib[14];
MOV result.position, R1;
MOV result.texcoord[2].zw, R1;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[17], c[17].zwzw;
MOV result.texcoord[1].w, -R0.x;
END
# 32 instructions, 4 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
						"HDR_LIGHT_PREPASS_ON"
					}
					Bind "vertex"
					Vertex
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Bind "tangent"
					TexCoord2
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 8[_World2Object]
					Vector 12[_WorldSpaceCameraPos]
					Vector 13[_ProjectionParams]
					Vector 14[_ScreenParams]
					Vector 15[unity_Scale]
					Float 16[_tiling]
					Vector 17[unity_LightmapST]
					"vs_2_0
def c18, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mov r1.xyz, c12
mov r1.w, c18.y
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c15.w, -v0
mul r3.xyz, r0, v1.w
dp4 r1.w, v0, c7
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r0.xyz, r1.xyww, c18.x
mul r0.y, r0, c13.x
mad oT2.xy, r0.z, c14.zwzw, r0
mov r0.z, v4.x
mov r0.xy, v3
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
abs oT0.xyz, r0
mul oT1.xyz, r0, c16.x
dp4 r0.x, v0, c2
dp3 oT4.y, r2, r3
dp3 oT4.z, v2, r2
dp3 oT4.x, r2, v1
mov oPos, r1
mov oT2.zw, r1
mad oT3.xy, v4, c17, c17.zwzw
mov oT1.w, -r0.x
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
						"HDR_LIGHT_PREPASS_ON"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Bind "tangent"
					TexCoord2
					ConstBuffer "$Globals"
					352
					Float 212[_tiling]
					Vector 304[unity_LightmapST]
					ConstBuffer "UnityPerCamera"
					128
					Vector 64[_WorldSpaceCameraPos] 3
					Vector 80[_ProjectionParams]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 256[_World2Object]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityPerDraw"
					2 "vs_4_0
eefiecedghcgkooglejgbcjenjnjlghcdodcbdmiabaaaaaakiagaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcpeaeaaaaeaaaabaadnabaaaafjaaaaae
egiocaaaaaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
dccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaadgaaaaaf
ecaabaaaabaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaag
hccabaaaabaaaaaaegacbaiaibaaaaaaabaaaaaadiaaaaaihccabaaaacaaaaaa
egacbaaaabaaaaaafgifcaaaaaaaaaaaanaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaabaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaak
bcaabaaaabaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
abaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaabaaaaaadgaaaaagiccabaaaacaaaaaaakaabaiaebaaaaaa
abaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadcaaaaal
dccabaaaaeaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaabdaaaaaaogikcaaa
aaaaaaaabdaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaa
acaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaa
egacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
pgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaa
egiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaa
baaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaa
abaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaacaaaaaa
bdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaacaaaaaa
beaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaafaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaafaaaaaaegbcbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaaheccabaaaafaaaaaaegbcbaaaacaaaaaaegacbaaa
abaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
						"HDR_LIGHT_PREPASS_ON"
					}
					Bind "vertex"
					Vertex
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Bind "tangent"
					TexCoord2
					ConstBuffer "$Globals"
					352
					Float 212[_tiling]
					Vector 304[unity_LightmapST]
					ConstBuffer "UnityPerCamera"
					128
					Vector 64[_WorldSpaceCameraPos] 3
					Vector 80[_ProjectionParams]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 256[_World2Object]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityPerDraw"
					2 "vs_4_0_level_9_1
eefiecedlnpgiaimcjpnbmicjmdiedhgnhcppiniabaaaaaalaajaaaaaeaaaaaa
daaaaaaadeadaaaadaaiaaaapiaiaaaaebgpgodjpmacaaaapmacaaaaaaacpopp
jiacaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaanaa
abaaabaaaaaaaaaaaaaabdaaabaaacaaaaaaaaaaabaaaeaaacaaadaaaaaaaaaa
acaaaaaaaiaaafaaaaaaaaaaacaabaaaafaaanaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafbcaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjaabaaaaacaaaaadiaadaaoeja
abaaaaacaaaaaeiaaeaaaajaceaaaaacabaaahiaaaaaoeiacdaaaaacaaaaahoa
abaaoeiaafaaaaadabaaahoaabaaoeiaabaaffkaafaaaaadaaaaabiaaaaaffja
akaakkkaaeaaaaaeaaaaabiaajaakkkaaaaaaajaaaaaaaiaaeaaaaaeaaaaabia
alaakkkaaaaakkjaaaaaaaiaaeaaaaaeaaaaabiaamaakkkaaaaappjaaaaaaaia
abaaaaacabaaaioaaaaaaaibafaaaaadaaaaapiaaaaaffjaagaaoekaaeaaaaae
aaaaapiaafaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaahaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaaiaaoekaaaaappjaaaaaoeiaafaaaaadabaaabia
aaaaffiaaeaaaakaafaaaaadabaaaiiaabaaaaiabcaaaakaafaaaaadabaaafia
aaaapeiabcaaaakaacaaaaadacaaadoaabaakkiaabaaomiaaeaaaaaeadaaadoa
aeaaoejaacaaoekaacaaookaabaaaaacabaaahiaadaaoekaafaaaaadacaaahia
abaaffiaaoaaoekaaeaaaaaeabaaaliaanaakekaabaaaaiaacaakeiaaeaaaaae
abaaahiaapaaoekaabaakkiaabaapeiaacaaaaadabaaahiaabaaoeiabaaaoeka
aeaaaaaeabaaahiaabaaoeiabbaappkaaaaaoejbaiaaaaadaeaaaboaabaaoeja
abaaoeiaabaaaaacacaaahiaabaaoejaafaaaaadadaaahiaacaamjiaacaancja
aeaaaaaeacaaahiaacaamjjaacaanciaadaaoeibafaaaaadacaaahiaacaaoeia
abaappjaaiaaaaadaeaaacoaacaaoeiaabaaoeiaaiaaaaadaeaaaeoaacaaoeja
abaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacacaaamoaaaaaoeiappppaaaafdeieefcpeaeaaaaeaaaabaa
dnabaaaafjaaaaaeegiocaaaaaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaaabaaaaaaegbabaaa
adaaaaaadgaaaaafecaabaaaabaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaa
abaaaaaadgaaaaaghccabaaaabaaaaaaegacbaiaibaaaaaaabaaaaaadiaaaaai
hccabaaaacaaaaaaegacbaaaabaaaaaafgifcaaaaaaaaaaaanaaaaaadiaaaaai
bcaabaaaabaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaak
bcaabaaaabaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
abaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaacaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaacaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaabaaaaaadgaaaaagiccabaaaacaaaaaa
akaabaiaebaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaadaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadcaaaaaldccabaaaaeaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaa
bdaaaaaaogikcaaaaaaaaaaabdaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaa
abaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaa
cgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaa
abaaaaaaaeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaa
aeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaaaacaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgipcaaaacaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaa
afaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaafaaaaaa
egbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaafaaaaaaegbcbaaa
acaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaa
agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
keaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaakeaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaa
keaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
				}
			}
			Program "fp" {
				SubProgram "opengl " {
					Keywords {
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_OFF"
					}
					Vector 0[_SpecColor]
					Float 1[_Mix]
					Vector 2[_Color]
					Vector 3[_ColorFromSpace]
					Float 4[_Gloss]
					Float 5[_fadeStart]
					Float 6[_fadeEnd]
					Float 7[_PlanetOpacity]
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_LightBuffer] 2D 2 "!!ARBfp1.0
PARAM c[9] = { program.local[0..7],
		{ 1, 2, 3 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TXP R0, fragment.texcoord[2], texture[2], 2D;
TEX R6.xyz, fragment.texcoord[1].zyzw, texture[0], 2D;
TEX R3.xyz, fragment.texcoord[1].zyzw, texture[1], 2D;
TEX R1.xyz, fragment.texcoord[1].zxzw, texture[1], 2D;
TEX R4.xyz, fragment.texcoord[1].zxzw, texture[0], 2D;
TEX R2.xyz, fragment.texcoord[1], texture[1], 2D;
TEX R5.xyz, fragment.texcoord[1], texture[0], 2D;
MUL R3.xyz, fragment.texcoord[0].x, R3;
MAD R2.xyz, fragment.texcoord[0].z, R2, R3;
MUL R6.xyz, fragment.texcoord[0].x, R6;
MAD R5.xyz, fragment.texcoord[0].z, R5, R6;
MOV R1.w, c[5].x;
MAD R1.xyz, R1, fragment.texcoord[0].y, R2;
MAD R3.xyz, fragment.texcoord[0].y, R4, R5;
ADD R1.w, -R1, c[6].x;
RCP R2.x, R1.w;
ADD R1.xyz, R1, -R3;
MAD R1.xyz, R1, c[1].x, R3;
ADD R1.w, fragment.texcoord[1], -c[5].x;
MUL_SAT R1.w, R1, R2.x;
MUL R1.xyz, -R1, c[2];
MAD R2.w, -R1, c[8].y, c[8].z;
MUL R1.w, R1, R1;
ADD R2.xyz, R1, c[3];
MUL R1.w, R1, R2;
MAD R1.xyz, R1.w, R2, -R1;
LG2 R0.w, R0.w;
MUL R1.w, -R0, c[4].x;
MOV R0.w, c[8].x;
ADD R0.w, R0, -c[7].x;
LG2 R0.x, R0.x;
LG2 R0.z, R0.z;
LG2 R0.y, R0.y;
ADD R0.xyz, -R0, fragment.texcoord[3];
MUL R2.xyz, R0, c[0];
MUL R2.xyz, R1.w, R2;
MAD result.color.xyz, R1, R0, R2;
MAD result.color.w, R1, c[0], R0;
END
# 38 instructions, 7 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_OFF"
					}
					Vector 0[_SpecColor]
					Float 1[_Mix]
					Vector 2[_Color]
					Vector 3[_ColorFromSpace]
					Float 4[_Gloss]
					Float 5[_fadeStart]
					Float 6[_fadeEnd]
					Float 7[_PlanetOpacity]
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_LightBuffer] 2D 2 "ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c8, 1.00000000, 2.00000000, 3.00000000, 0
dcl t0.xyz
dcl t1
dcl t2
dcl t3.xyz
texld r5, t1, s1
mov r4.xy, t1.zxyw
mov r3.xy, t1.zxyw
mov r1.y, t1
mov r1.x, t1.z
mov r2.xy, r1
mov r0.y, t1
mov r0.x, t1.z
texld r6, r4, s1
texld r4, r2, s1
texld r2, t1, s0
texldp r1, t2, s2
texld r3, r3, s0
texld r0, r0, s0
mul r0.xyz, t0.x, r0
mad r0.xyz, t0.z, r2, r0
mul r2.xyz, t0.x, r4
mad r0.xyz, t0.y, r3, r0
mad r2.xyz, t0.z, r5, r2
mad r2.xyz, r6, t0.y, r2
add r2.xyz, r2, -r0
mad r2.xyz, r2, c1.x, r0
mul r3.xyz, -r2, c2
mov r0.x, c6
add r0.x, -c5, r0
rcp r2.x, r0.x
add r0.x, t1.w, -c5
mul_sat r2.x, r0, r2
mad r0.x, -r2, c8.y, c8.z
mul r2.x, r2, r2
add r4.xyz, r3, c3
mul r0.x, r2, r0
mad r2.xyz, r0.x, r4, -r3
log_pp r0.x, r1.x
mov r1.x, c7
log_pp r0.z, r1.z
log_pp r0.y, r1.y
add_pp r3.xyz, -r0, t3
log_pp r0.x, r1.w
mul_pp r0.x, -r0, c4
mul_pp r4.xyz, r3, c0
mul_pp r4.xyz, r0.x, r4
add r1.x, c8, -r1
mad_pp r2.xyz, r2, r3, r4
mad_pp r2.w, r0.x, c0, r1.x
mov_pp oC0, r2
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_OFF"
					}
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_LightBuffer] 2D 2
					ConstBuffer "$Globals"
					320
					Vector 32[_SpecColor]
					Float 48[_Mix]
					Vector 80[_Color]
					Vector 96[_ColorFromSpace]
					Float 132[_Gloss]
					Float 204[_fadeStart]
					Float 208[_fadeEnd]
					Float 288[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedpjablmkbmjikpoefjhapccffbpoajodaabaaaaaaeiagaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefceaafaaaaeaaaaaaafaabaaaafjaaaaaeegiocaaaaaaaaaaabdaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaa
gcbaaaadpcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaa
aaaaaaaaggbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaabaaaaaakgbkbaaaabaaaaaaegacbaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaacgbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaafgbfbaaaabaaaaaa
egacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaggbkbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
agbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaa
kgbkbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaacgbkbaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaa
egacbaaaacaaaaaafgbfbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaagiacaaaaaaaaaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaa
dcaaaaamhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaaaaaaaaa
afaaaaaaegiccaaaaaaaaaaaagaaaaaaaaaaaaakicaabaaaaaaaaaaadkiacaia
ebaaaaaaaaaaaaaaamaaaaaaakiacaaaaaaaaaaaanaaaaaaaoaaaaakicaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaaaaaaaaa
aaaaaaajicaabaaaabaaaaaadkbabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaa
amaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaa
dcaaaaajicaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaa
aaaaeaeadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaaj
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
aoaaaaahdcaabaaaabaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
cpaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaa
egacbaiaebaaaaaaabaaaaaaegbcbaaaaeaaaaaadiaaaaajicaabaaaaaaaaaaa
dkaabaiaebaaaaaaabaaaaaabkiacaaaaaaaaaaaaiaaaaaadiaaaaaihcaabaaa
acaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaa
acaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaajhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaajbcaabaaa
aaaaaaaaakiacaiaebaaaaaaaaaaaaaabcaaaaaaabeaaaaaaaaaiadpdcaaaaak
iccabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaacaaaaaaakaabaaa
aaaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_OFF"
					}
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_LightBuffer] 2D 2
					ConstBuffer "$Globals"
					320
					Vector 32[_SpecColor]
					Float 48[_Mix]
					Vector 80[_Color]
					Vector 96[_ColorFromSpace]
					Float 132[_Gloss]
					Float 204[_fadeStart]
					Float 208[_fadeEnd]
					Float 288[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0_level_9_1
eefiecednkhbkdgaandfkikcdmkjkpjnnpdojaimabaaaaaaoiajaaaaaeaaaaaa
daaaaaaammadaaaabeajaaaaleajaaaaebgpgodjjeadaaaajeadaaaaaaacpppp
ciadaaaagmaaaaaaafaadaaaaaaagmaaaaaagmaaadaaceaaaaaagmaaaaaaaaaa
abababaaacacacaaaaaaacaaacaaaaaaaaaaaaaaaaaaafaaacaaacaaaaaaaaaa
aaaaaiaaabaaaeaaaaaaaaaaaaaaamaaacaaafaaaaaaaaaaaaaabcaaabaaahaa
aaaaaaaaaaacppppfbaaaaafaiaaapkaaaaaaamaaaaaeaeaaaaaiadpaaaaaaaa
bpaaaaacaaaaaaiaaaaaahlabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaaiaadaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaac
aaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaabaaaaacaaaaabiaabaakkla
abaaaaacaaaaaciaabaafflaabaaaaacabaaadiaabaanclaagaaaaacaaaaaeia
acaapplaafaaaaadacaaadiaaaaakkiaacaaoelaecaaaaadadaaapiaabaaoela
aaaioekaecaaaaadaeaaapiaaaaaoeiaaaaioekaecaaaaadaaaaapiaaaaaoeia
abaioekaecaaaaadafaaapiaabaaoeiaaaaioekaecaaaaadabaaapiaabaaoeia
abaioekaecaaaaadagaaapiaabaaoelaabaioekaecaaaaadacaacpiaacaaoeia
acaioekaafaaaaadaaaaahiaaaaaoeiaaaaaaalaafaaaaadaeaaahiaaeaaoeia
aaaaaalaaeaaaaaeadaaahiaadaaoeiaaaaakklaaeaaoeiaaeaaaaaeadaaahia
afaaoeiaaaaafflaadaaoeiaaeaaaaaeaaaaahiaagaaoeiaaaaakklaaaaaoeia
aeaaaaaeaaaaahiaabaaoeiaaaaafflaaaaaoeiabcaaaaaeabaaahiaabaaaaka
aaaaoeiaadaaoeiaafaaaaadaaaaahiaabaaoeiaacaaoekaabaaaaacadaaahia
acaaoekaaeaaaaaeabaaahiaabaaoeiaadaaoeibadaaoekaabaaaaacaaaaaiia
afaappkaacaaaaadaaaaaiiaaaaappibagaaaakaagaaaaacaaaaaiiaaaaappia
acaaaaadabaaaiiaabaapplaafaappkbafaaaaadaaaabiiaaaaappiaabaappia
aeaaaaaeabaaaiiaaaaappiaaiaaaakaaiaaffkaafaaaaadaaaaaiiaaaaappia
aaaappiaafaaaaadaaaaaiiaaaaappiaabaappiaaeaaaaaeaaaachiaaaaappia
abaaoeiaaaaaoeiaapaaaaacabaacbiaacaaaaiaapaaaaacabaacciaacaaffia
apaaaaacabaaceiaacaakkiaapaaaaacaaaaciiaacaappiaafaaaaadaaaaciia
aaaappibaeaaffkaacaaaaadabaachiaabaaoeibadaaoelaafaaaaadacaachia
abaaoeiaaaaaoekaafaaaaadacaachiaaaaappiaacaaoeiaaeaaaaaeabaachia
aaaaoeiaabaaoeiaacaaoeiaabaaaaacaaaaaeiaaiaakkkaacaaaaadaaaacbia
aaaakkiaahaaaakbaeaaaaaeabaaciiaaaaappiaaaaappkaaaaaaaiaabaaaaac
aaaicpiaabaaoeiappppaaaafdeieefceaafaaaaeaaaaaaafaabaaaafjaaaaae
egiocaaaaaaaaaaabdaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaadlcbabaaa
adaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaaefaaaaajpcaabaaaaaaaaaaaggbkbaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaagbabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaakgbkbaaa
abaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaacgbkbaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
abaaaaaafgbfbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
ggbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaa
abaaaaaaegacbaaaacaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaacgbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaafgbfbaaaabaaaaaaegacbaaa
abaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaagiacaaaaaaaaaaaadaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaaaaaaaaa
egiccaaaaaaaaaaaafaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaiaebaaaaaa
aaaaaaaaegiccaaaaaaaaaaaafaaaaaaegiccaaaaaaaaaaaagaaaaaaaaaaaaak
icaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaaamaaaaaaakiacaaaaaaaaaaa
anaaaaaaaoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaadkbabaaaacaaaaaa
dkiacaiaebaaaaaaaaaaaaaaamaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaacpaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaa
aaaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegbcbaaaaeaaaaaa
diaaaaajicaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaabkiacaaaaaaaaaaa
aiaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
acaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaajhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaaaaaaaaajbcaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaabcaaaaaa
abeaaaaaaaaaiadpdcaaaaakiccabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaa
aaaaaaaaacaaaaaaakaabaaaaaaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahahaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapapaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apalaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
				}
				SubProgram "opengl " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_OFF"
					}
					Vector 0[_SpecColor]
					Float 1[_Mix]
					Vector 2[_Color]
					Vector 3[_ColorFromSpace]
					Float 4[_Gloss]
					Float 5[_fadeStart]
					Float 6[_fadeEnd]
					Float 7[_PlanetOpacity]
					Vector 8[unity_LightmapFade]
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_LightBuffer] 2D 2
					SetTexture 3[unity_Lightmap] 2D 3
					SetTexture 4[unity_LightmapInd] 2D 4 "!!ARBfp1.0
PARAM c[10] = { program.local[0..8],
		{ 1, 2, 3, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEMP R8;
TXP R0, fragment.texcoord[2], texture[2], 2D;
TEX R1, fragment.texcoord[3], texture[3], 2D;
TEX R2, fragment.texcoord[3], texture[4], 2D;
TEX R8.xyz, fragment.texcoord[1].zyzw, texture[0], 2D;
TEX R5.xyz, fragment.texcoord[1].zyzw, texture[1], 2D;
TEX R3.xyz, fragment.texcoord[1].zxzw, texture[1], 2D;
TEX R6.xyz, fragment.texcoord[1].zxzw, texture[0], 2D;
TEX R4.xyz, fragment.texcoord[1], texture[1], 2D;
TEX R7.xyz, fragment.texcoord[1], texture[0], 2D;
MUL R5.xyz, fragment.texcoord[0].x, R5;
MAD R4.xyz, fragment.texcoord[0].z, R4, R5;
MUL R1.xyz, R1.w, R1;
MUL R8.xyz, fragment.texcoord[0].x, R8;
MAD R7.xyz, fragment.texcoord[0].z, R7, R8;
MOV R3.w, c[5].x;
DP4 R1.w, fragment.texcoord[4], fragment.texcoord[4];
MUL R2.xyz, R2.w, R2;
MUL R2.xyz, R2, c[9].w;
RSQ R1.w, R1.w;
RCP R1.w, R1.w;
MAD R3.xyz, R3, fragment.texcoord[0].y, R4;
MAD R5.xyz, fragment.texcoord[0].y, R6, R7;
ADD R3.w, -R3, c[6].x;
RCP R4.x, R3.w;
ADD R3.xyz, R3, -R5;
MAD R3.xyz, R3, c[1].x, R5;
ADD R3.w, fragment.texcoord[1], -c[5].x;
MUL_SAT R3.w, R3, R4.x;
MUL R3.xyz, -R3, c[2];
MAD R4.w, -R3, c[9].y, c[9].z;
MUL R3.w, R3, R3;
MAD R1.xyz, R1, c[9].w, -R2;
MAD_SAT R1.w, R1, c[8].z, c[8];
MAD R1.xyz, R1.w, R1, R2;
LG2 R0.w, R0.w;
ADD R4.xyz, R3, c[3];
MUL R3.w, R3, R4;
MAD R3.xyz, R3.w, R4, -R3;
LG2 R0.x, R0.x;
LG2 R0.y, R0.y;
LG2 R0.z, R0.z;
ADD R0.xyz, -R0, R1;
MUL R1.x, -R0.w, c[4];
MUL R2.xyz, R0, c[0];
MOV R0.w, c[9].x;
MUL R2.xyz, R1.x, R2;
ADD R0.w, R0, -c[7].x;
MAD result.color.xyz, R3, R0, R2;
MAD result.color.w, R1.x, c[0], R0;
END
# 49 instructions, 9 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_OFF"
					}
					Vector 0[_SpecColor]
					Float 1[_Mix]
					Vector 2[_Color]
					Vector 3[_ColorFromSpace]
					Float 4[_Gloss]
					Float 5[_fadeStart]
					Float 6[_fadeEnd]
					Float 7[_PlanetOpacity]
					Vector 8[unity_LightmapFade]
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_LightBuffer] 2D 2
					SetTexture 3[unity_Lightmap] 2D 3
					SetTexture 4[unity_LightmapInd] 2D 4 "ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c9, 1.00000000, 2.00000000, 3.00000000, 8.00000000
dcl t0.xyz
dcl t1
dcl t2
dcl t3.xy
dcl t4
texldp r3, t2, s2
texld r1, t3, s3
texld r7, t1, s1
mov r6.xy, t1.zxyw
mov r5.xy, t1.zxyw
mov r0.y, t1
mov r0.x, t1.z
mov r2.xy, r0
mov r0.y, t1
mov r0.x, t1.z
mov r4.xy, r0
mul_pp r1.xyz, r1.w, r1
texld r8, r6, s1
texld r6, r4, s1
texld r2, r2, s0
texld r0, t3, s4
texld r5, r5, s0
texld r4, t1, s0
mul r2.xyz, t0.x, r2
mad r2.xyz, t0.z, r4, r2
mad r4.xyz, t0.y, r5, r2
mul r2.xyz, t0.x, r6
mad r2.xyz, t0.z, r7, r2
mad r2.xyz, r8, t0.y, r2
add r5.xyz, r2, -r4
mad r4.xyz, r5, c1.x, r4
mul r5.xyz, -r4, c2
mov r2.x, c6
add r2.x, -c5, r2
rcp r4.x, r2.x
add r2.x, t1.w, -c5
mul_sat r4.x, r2, r4
mad r2.x, -r4, c9.y, c9.z
mul r4.x, r4, r4
mul r2.x, r4, r2
mul_pp r4.xyz, r0.w, r0
mul_pp r4.xyz, r4, c9.w
add r6.xyz, r5, c3
dp4 r0.x, t4, t4
rsq r0.x, r0.x
rcp r0.x, r0.x
mad_pp r1.xyz, r1, c9.w, -r4
mad_sat r0.x, r0, c8.z, c8.w
mad_pp r0.xyz, r0.x, r1, r4
log_pp r1.x, r3.x
mad r2.xyz, r2.x, r6, -r5
log_pp r1.y, r3.y
log_pp r1.z, r3.z
add_pp r3.xyz, -r1, r0
log_pp r0.x, r3.w
mov r1.x, c7
mul_pp r0.x, -r0, c4
mul_pp r4.xyz, r3, c0
mul_pp r4.xyz, r0.x, r4
add r1.x, c9, -r1
mad_pp r2.xyz, r2, r3, r4
mad_pp r2.w, r0.x, c0, r1.x
mov_pp oC0, r2
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_OFF"
					}
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_LightBuffer] 2D 2
					SetTexture 3[unity_Lightmap] 2D 3
					SetTexture 4[unity_LightmapInd] 2D 4
					ConstBuffer "$Globals"
					352
					Vector 32[_SpecColor]
					Float 48[_Mix]
					Vector 80[_Color]
					Vector 96[_ColorFromSpace]
					Float 132[_Gloss]
					Float 204[_fadeStart]
					Float 208[_fadeEnd]
					Float 288[_PlanetOpacity]
					Vector 320[unity_LightmapFade]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedpgnpfgicncacfhdamhkipfllgeibhmkoabaaaaaaoiahaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmiagaaaa
eaaaaaaalcabaaaafjaaaaaeegiocaaaaaaaaaaabfaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaad
lcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
ggbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaabaaaaaakgbkbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaacgbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaafgbfbaaaabaaaaaaegacbaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaggbkbaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaakgbkbaaa
abaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaacgbkbaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
acaaaaaafgbfbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaa
agiacaaaaaaaaaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaadcaaaaam
hcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaa
egiccaaaaaaaaaaaagaaaaaaaaaaaaakicaabaaaaaaaaaaadkiacaiaebaaaaaa
aaaaaaaaamaaaaaaakiacaaaaaaaaaaaanaaaaaaaoaaaaakicaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaaaaaaaaaaaaaaaaj
icaabaaaabaaaaaadkbabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaaamaaaaaa
dicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaaj
icaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaea
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabbaaaaah
icaabaaaaaaaaaaaegbobaaaafaaaaaaegbobaaaafaaaaaaelaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadccaaaalicaabaaaaaaaaaaadkaabaaaaaaaaaaa
ckiacaaaaaaaaaaabeaaaaaadkiacaaaaaaaaaaabeaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaaeaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadiaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaaeaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahicaabaaa
abaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaebdcaaaaakhcaabaaaacaaaaaa
pgapbaaaabaaaaaaegacbaaaacaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaaj
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
aoaaaaahdcaabaaaacaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
cpaaaaafpcaabaaaacaaaaaaegaobaaaacaaaaaaaaaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaajicaabaaaaaaaaaaa
dkaabaiaebaaaaaaacaaaaaabkiacaaaaaaaaaaaaiaaaaaadiaaaaaihcaabaaa
acaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaa
acaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaajhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaajbcaabaaa
aaaaaaaaakiacaiaebaaaaaaaaaaaaaabcaaaaaaabeaaaaaaaaaiadpdcaaaaak
iccabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaacaaaaaaakaabaaa
aaaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_OFF"
					}
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_LightBuffer] 2D 2
					SetTexture 3[unity_Lightmap] 2D 3
					SetTexture 4[unity_LightmapInd] 2D 4
					ConstBuffer "$Globals"
					352
					Vector 32[_SpecColor]
					Float 48[_Mix]
					Vector 80[_Color]
					Vector 96[_ColorFromSpace]
					Float 132[_Gloss]
					Float 204[_fadeStart]
					Float 208[_fadeEnd]
					Float 288[_PlanetOpacity]
					Vector 320[unity_LightmapFade]
					BindCB "$Globals"
					0 "ps_4_0_level_9_1
eefiecedligoopfhpfegcaoppokefiamkanbiaolabaaaaaaheamaaaaaeaaaaaa
daaaaaaaliaeaaaaiialaaaaeaamaaaaebgpgodjiaaeaaaaiaaeaaaaaaacpppp
aaaeaaaaiaaaaaaaagaadiaaaaaaiaaaaaaaiaaaafaaceaaaaaaiaaaaaaaaaaa
abababaaacacacaaadadadaaaeaeaeaaaaaaacaaacaaaaaaaaaaaaaaaaaaafaa
acaaacaaaaaaaaaaaaaaaiaaabaaaeaaaaaaaaaaaaaaamaaacaaafaaaaaaaaaa
aaaabcaaabaaahaaaaaaaaaaaaaabeaaabaaaiaaaaaaaaaaaaacppppfbaaaaaf
ajaaapkaaaaaaamaaaaaeaeaaaaaiadpaaaaaaebbpaaaaacaaaaaaiaaaaaahla
bpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaiaacaaaplabpaaaaacaaaaaaia
adaaadlabpaaaaacaaaaaaiaaeaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaac
aaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaajaadaiapka
bpaaaaacaaaaaajaaeaiapkaabaaaaacaaaaabiaabaakklaabaaaaacaaaaacia
abaafflaabaaaaacabaaadiaabaanclaagaaaaacaaaaaeiaacaapplaafaaaaad
acaaadiaaaaakkiaacaaoelaecaaaaadadaaapiaabaaoelaaaaioekaecaaaaad
aeaaapiaaaaaoeiaaaaioekaecaaaaadaaaaapiaaaaaoeiaabaioekaecaaaaad
afaaapiaabaaoeiaaaaioekaecaaaaadabaaapiaabaaoeiaabaioekaecaaaaad
agaaapiaabaaoelaabaioekaecaaaaadahaacpiaadaaoelaaeaioekaecaaaaad
aiaacpiaadaaoelaadaioekaecaaaaadacaacpiaacaaoeiaacaioekaafaaaaad
aaaaahiaaaaaoeiaaaaaaalaafaaaaadaeaaahiaaeaaoeiaaaaaaalaaeaaaaae
adaaahiaadaaoeiaaaaakklaaeaaoeiaaeaaaaaeadaaahiaafaaoeiaaaaaffla
adaaoeiaaeaaaaaeaaaaahiaagaaoeiaaaaakklaaaaaoeiaaeaaaaaeaaaaahia
abaaoeiaaaaafflaaaaaoeiabcaaaaaeabaaahiaabaaaakaaaaaoeiaadaaoeia
afaaaaadaaaaahiaabaaoeiaacaaoekaabaaaaacadaaahiaacaaoekaaeaaaaae
abaaahiaabaaoeiaadaaoeibadaaoekaabaaaaacaaaaaiiaafaappkaacaaaaad
aaaaaiiaaaaappibagaaaakaagaaaaacaaaaaiiaaaaappiaacaaaaadabaaaiia
abaapplaafaappkbafaaaaadaaaabiiaaaaappiaabaappiaaeaaaaaeabaaaiia
aaaappiaajaaaakaajaaffkaafaaaaadaaaaaiiaaaaappiaaaaappiaafaaaaad
aaaaaiiaaaaappiaabaappiaaeaaaaaeaaaachiaaaaappiaabaaoeiaaaaaoeia
ajaaaaadaaaaaiiaaeaaoelaaeaaoelaahaaaaacaaaaaiiaaaaappiaagaaaaac
aaaaaiiaaaaappiaaeaaaaaeaaaadiiaaaaappiaaiaakkkaaiaappkaafaaaaad
ahaaciiaahaappiaajaappkaafaaaaadabaachiaahaaoeiaahaappiaafaaaaad
abaaciiaaiaappiaajaappkaaeaaaaaeadaachiaabaappiaaiaaoeiaabaaoeib
aeaaaaaeabaachiaaaaappiaadaaoeiaabaaoeiaapaaaaacadaacbiaacaaaaia
apaaaaacadaacciaacaaffiaapaaaaacadaaceiaacaakkiaapaaaaacaaaaciia
acaappiaafaaaaadaaaaciiaaaaappibaeaaffkaacaaaaadabaachiaabaaoeia
adaaoeibafaaaaadacaachiaabaaoeiaaaaaoekaafaaaaadacaachiaaaaappia
acaaoeiaaeaaaaaeabaachiaaaaaoeiaabaaoeiaacaaoeiaabaaaaacaaaaaeia
ajaakkkaacaaaaadaaaacbiaaaaakkiaahaaaakbaeaaaaaeabaaciiaaaaappia
aaaappkaaaaaaaiaabaaaaacaaaicpiaabaaoeiappppaaaafdeieefcmiagaaaa
eaaaaaaalcabaaaafjaaaaaeegiocaaaaaaaaaaabfaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaad
lcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
ggbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaabaaaaaakgbkbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaacgbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaafgbfbaaaabaaaaaaegacbaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaggbkbaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaakgbkbaaa
abaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaacgbkbaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
acaaaaaafgbfbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaa
agiacaaaaaaaaaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaadcaaaaam
hcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaa
egiccaaaaaaaaaaaagaaaaaaaaaaaaakicaabaaaaaaaaaaadkiacaiaebaaaaaa
aaaaaaaaamaaaaaaakiacaaaaaaaaaaaanaaaaaaaoaaaaakicaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaaaaaaaaaaaaaaaaj
icaabaaaabaaaaaadkbabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaaamaaaaaa
dicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaaj
icaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaea
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabbaaaaah
icaabaaaaaaaaaaaegbobaaaafaaaaaaegbobaaaafaaaaaaelaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadccaaaalicaabaaaaaaaaaaadkaabaaaaaaaaaaa
ckiacaaaaaaaaaaabeaaaaaadkiacaaaaaaaaaaabeaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaaeaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadiaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaaeaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahicaabaaa
abaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaebdcaaaaakhcaabaaaacaaaaaa
pgapbaaaabaaaaaaegacbaaaacaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaaj
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
aoaaaaahdcaabaaaacaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
cpaaaaafpcaabaaaacaaaaaaegaobaaaacaaaaaaaaaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaajicaabaaaaaaaaaaa
dkaabaiaebaaaaaaacaaaaaabkiacaaaaaaaaaaaaiaaaaaadiaaaaaihcaabaaa
acaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaa
acaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaajhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaajbcaabaaa
aaaaaaaaakiacaiaebaaaaaaaaaaaaaabcaaaaaaabeaaaaaaaaaiadpdcaaaaak
iccabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaacaaaaaaakaabaaa
aaaaaaaadoaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaahahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapapaaaa
keaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaakeaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaadadaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
				}
				SubProgram "opengl " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
						"HDR_LIGHT_PREPASS_OFF"
					}
					Vector 0[_SpecColor]
					Float 1[_Mix]
					Vector 2[_Color]
					Vector 3[_ColorFromSpace]
					Float 4[_Shininess]
					Float 5[_Gloss]
					Float 6[_fadeStart]
					Float 7[_fadeEnd]
					Float 8[_PlanetOpacity]
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_LightBuffer] 2D 2
					SetTexture 3[unity_Lightmap] 2D 3
					SetTexture 4[unity_LightmapInd] 2D 4 "!!ARBfp1.0
PARAM c[13] = { program.local[0..8],
		{ 8, -0.40824828, -0.70710677, 0.57735026 },
		{ 0.81649655, 0, 0.57735026, 128 },
		{ -0.40824831, 0.70710677, 0.57735026, 1 },
		{ 2, 3 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEMP R8;
TEMP R9;
TXP R0, fragment.texcoord[2], texture[2], 2D;
TEX R1, fragment.texcoord[3], texture[3], 2D;
TEX R2, fragment.texcoord[3], texture[4], 2D;
TEX R3.xyz, fragment.texcoord[1].zxzw, texture[1], 2D;
TEX R6.xyz, fragment.texcoord[1].zxzw, texture[0], 2D;
TEX R4.xyz, fragment.texcoord[1], texture[1], 2D;
TEX R7.xyz, fragment.texcoord[1], texture[0], 2D;
TEX R5.xyz, fragment.texcoord[1].zyzw, texture[1], 2D;
TEX R8.xyz, fragment.texcoord[1].zyzw, texture[0], 2D;
MUL R1.xyz, R1.w, R1;
MUL R2.xyz, R2.w, R2;
MUL R2.xyz, R2, c[9].x;
MUL R9.xyz, R2.y, c[11];
MAD R9.xyz, R2.x, c[10], R9;
MAD R2.xyz, R2.z, c[9].yzww, R9;
DP3 R2.w, R2, R2;
RSQ R3.w, R2.w;
DP3 R2.w, fragment.texcoord[4], fragment.texcoord[4];
MOV R1.w, c[6].x;
RSQ R2.w, R2.w;
MUL R2.xyz, R3.w, R2;
MAD R2.xyz, R2.w, fragment.texcoord[4], R2;
DP3 R2.x, R2, R2;
RSQ R2.y, R2.x;
MUL R2.y, R2, R2.z;
MOV R2.x, c[10].w;
MUL R2.z, R2.x, c[4].x;
MAX R2.x, R2.y, c[10].y;
POW R2.w, R2.x, R2.z;
MUL R2.xyz, R1, c[9].x;
MUL R1.xyz, fragment.texcoord[0].x, R8;
MAD R1.xyz, fragment.texcoord[0].z, R7, R1;
MAD R1.xyz, fragment.texcoord[0].y, R6, R1;
ADD R1.w, -R1, c[7].x;
LG2 R0.x, R0.x;
LG2 R0.y, R0.y;
LG2 R0.z, R0.z;
LG2 R0.w, R0.w;
ADD R0, -R0, R2;
MUL R2.xyz, fragment.texcoord[0].x, R5;
MAD R2.xyz, fragment.texcoord[0].z, R4, R2;
MAD R2.xyz, R3, fragment.texcoord[0].y, R2;
ADD R2.xyz, R2, -R1;
MAD R1.xyz, R2, c[1].x, R1;
RCP R2.x, R1.w;
ADD R1.w, fragment.texcoord[1], -c[6].x;
MUL_SAT R1.w, R1, R2.x;
MUL R1.xyz, -R1, c[2];
MAD R2.w, -R1, c[12].x, c[12].y;
MUL R1.w, R1, R1;
ADD R2.xyz, R1, c[3];
MUL R1.w, R1, R2;
MAD R1.xyz, R1.w, R2, -R1;
MUL R1.w, R0, c[5].x;
MUL R2.xyz, R0, c[0];
MOV R0.w, c[11];
MUL R2.xyz, R1.w, R2;
ADD R0.w, R0, -c[8].x;
MAD result.color.xyz, R0, R1, R2;
MAD result.color.w, R1, c[0], R0;
END
# 60 instructions, 10 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
						"HDR_LIGHT_PREPASS_OFF"
					}
					Vector 0[_SpecColor]
					Float 1[_Mix]
					Vector 2[_Color]
					Vector 3[_ColorFromSpace]
					Float 4[_Shininess]
					Float 5[_Gloss]
					Float 6[_fadeStart]
					Float 7[_fadeEnd]
					Float 8[_PlanetOpacity]
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_LightBuffer] 2D 2
					SetTexture 3[unity_Lightmap] 2D 3
					SetTexture 4[unity_LightmapInd] 2D 4 "ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c9, 8.00000000, -0.40824831, 0.70710677, 0.57735026
def c10, 0.81649655, 0.00000000, 0.57735026, 128.00000000
def c11, -0.40824828, -0.70710677, 0.57735026, 1.00000000
def c12, 2.00000000, 3.00000000, 0, 0
dcl t0.xyz
dcl t1
dcl t2
dcl t3.xy
dcl t4.xyz
texld r9, t1, s1
texld r6, t1, s0
mov r3.xy, t1.zxyw
mov r2.xy, t1.zxyw
mov r0.y, t1
mov r0.x, t1.z
mov r1.y, t1
mov r1.x, t1.z
texld r10, r3, s1
texld r7, r2, s0
texld r4, r0, s0
texld r8, r1, s1
texld r2, t3, s3
texld r0, t3, s4
texldp r3, t2, s2
mul_pp r0.xyz, r0.w, r0
mul_pp r1.xyz, r0, c9.x
mov r0.x, c9.y
mov r0.z, c9.w
mov r0.y, c9.z
mul r0.xyz, r1.y, r0
mad r0.xyz, r1.x, c10, r0
mad r5.xyz, r1.z, c11, r0
dp3 r0.x, r5, r5
rsq r1.x, r0.x
dp3_pp r0.x, t4, t4
mul r1.xyz, r1.x, r5
rsq_pp r0.x, r0.x
mad_pp r0.xyz, r0.x, t4, r1
dp3_pp r0.x, r0, r0
rsq_pp r1.x, r0.x
mul_pp r0.z, r1.x, r0
max_pp r1.x, r0.z, c10.y
mov_pp r0.x, c4
mul_pp r0.x, c10.w, r0
pow r5.x, r1.x, r0.x
mul_pp r1.xyz, r2.w, r2
log_pp r0.x, r3.x
log_pp r0.y, r3.y
log_pp r0.z, r3.z
mul_pp r1.xyz, r1, c9.x
mov r1.w, r5.x
log_pp r0.w, r3.w
add_pp r0, -r0, r1
mul r1.xyz, t0.x, r4
mad r1.xyz, t0.z, r6, r1
mad r2.xyz, t0.y, r7, r1
mul r1.xyz, t0.x, r8
mad r1.xyz, t0.z, r9, r1
mad r1.xyz, r10, t0.y, r1
add r3.xyz, r1, -r2
mad r2.xyz, r3, c1.x, r2
mul r3.xyz, -r2, c2
mov r1.x, c7
add r1.x, -c6, r1
rcp r2.x, r1.x
add r1.x, t1.w, -c6
mul_sat r2.x, r1, r2
mad r1.x, -r2, c12, c12.y
mul r2.x, r2, r2
mul r1.x, r2, r1
add r4.xyz, r3, c3
mad r3.xyz, r1.x, r4, -r3
mov r2.x, c8
mul_pp r1.x, r0.w, c5
mul_pp r4.xyz, r0, c0
mul_pp r4.xyz, r1.x, r4
add r2.x, c11.w, -r2
mad_pp r0.xyz, r0, r3, r4
mad_pp r0.w, r1.x, c0, r2.x
mov_pp oC0, r0
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
						"HDR_LIGHT_PREPASS_OFF"
					}
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_LightBuffer] 2D 2
					SetTexture 3[unity_Lightmap] 2D 3
					SetTexture 4[unity_LightmapInd] 2D 4
					ConstBuffer "$Globals"
					352
					Vector 32[_SpecColor]
					Float 48[_Mix]
					Vector 80[_Color]
					Vector 96[_ColorFromSpace]
					Float 128[_Shininess]
					Float 132[_Gloss]
					Float 204[_fadeStart]
					Float 208[_fadeEnd]
					Float 288[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedoghelbhpnfcimeiganahcpbiaompnlgnabaaaaaaemajaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefccmaiaaaa
eaaaaaaaalacaaaafjaaaaaeegiocaaaaaaaaaaabdaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaad
lcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaa
ggbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaabaaaaaakgbkbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaacgbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaafgbfbaaaabaaaaaaegacbaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaggbkbaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaakgbkbaaa
abaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaacgbkbaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
acaaaaaafgbfbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaa
agiacaaaaaaaaaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaadcaaaaam
hcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaa
egiccaaaaaaaaaaaagaaaaaaaaaaaaakicaabaaaaaaaaaaadkiacaiaebaaaaaa
aaaaaaaaamaaaaaaakiacaaaaaaaaaaaanaaaaaaaoaaaaakicaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaaaaaaaaaaaaaaaaj
icaabaaaabaaaaaadkbabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaaamaaaaaa
dicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaaj
icaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaea
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaaeaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaadiaaaaakhcaabaaa
acaaaaaafgafbaaaabaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaa
dcaaaaamlcaabaaaabaaaaaaagaabaaaabaaaaaaaceaaaaaolaffbdpaaaaaaaa
aaaaaaaadkmnbddpegaibaaaacaaaaaadcaaaaamhcaabaaaabaaaaaakgakbaaa
abaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegadbaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaabaaaaaahicaabaaaabaaaaaaegbcbaaa
afaaaaaaegbcbaaaafaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaaegbcbaaaafaaaaaadcaaaaaj
hcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaackaabaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
bcaabaaaabaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabjaaaaaficaabaaa
abaaaaaadkaabaaaaaaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaacpaaaaafpcaabaaaacaaaaaaegaobaaaacaaaaaa
efaaaaajpcaabaaaadaaaaaaegbabaaaaeaaaaaaeghobaaaadaaaaaaaagabaaa
adaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaadaaaaaaabeaaaaaaaaaaaeb
diaaaaahhcaabaaaabaaaaaaegacbaaaadaaaaaapgapbaaaaaaaaaaaaaaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadiaaaaai
hcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaai
icaabaaaaaaaaaaadkaabaaaabaaaaaabkiacaaaaaaaaaaaaiaaaaaadiaaaaah
hcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaajhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaaj
bcaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaabcaaaaaaabeaaaaaaaaaiadp
dcaaaaakiccabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaacaaaaaa
akaabaaaaaaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
						"HDR_LIGHT_PREPASS_OFF"
					}
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_LightBuffer] 2D 2
					SetTexture 3[unity_Lightmap] 2D 3
					SetTexture 4[unity_LightmapInd] 2D 4
					ConstBuffer "$Globals"
					352
					Vector 32[_SpecColor]
					Float 48[_Mix]
					Vector 80[_Color]
					Vector 96[_ColorFromSpace]
					Float 128[_Shininess]
					Float 132[_Gloss]
					Float 204[_fadeStart]
					Float 208[_fadeEnd]
					Float 288[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0_level_9_1
eefiecedaaiflgcbeknbiledmdkncmmefodlocooabaaaaaajmaoaaaaaeaaaaaa
daaaaaaahmafaaaalaanaaaagiaoaaaaebgpgodjeeafaaaaeeafaaaaaaacpppp
naaeaaaaheaaaaaaafaadiaaaaaaheaaaaaaheaaafaaceaaaaaaheaaaaaaaaaa
abababaaacacacaaadadadaaaeaeaeaaaaaaacaaacaaaaaaaaaaaaaaaaaaafaa
acaaacaaaaaaaaaaaaaaaiaaabaaaeaaaaaaaaaaaaaaamaaacaaafaaaaaaaaaa
aaaabcaaabaaahaaaaaaaaaaaaacppppfbaaaaafaiaaapkaaaaaaamaaaaaeaea
aaaaiadpaaaaaaebfbaaaaafajaaapkaolaffbdpaaaaaaaadkmnbddpaaaaaaed
fbaaaaafakaaapkaomafnblopdaedfdpdkmnbddpaaaaaaaafbaaaaafalaaapka
olafnblopdaedflpdkmnbddpaaaaaaaabpaaaaacaaaaaaiaaaaaahlabpaaaaac
aaaaaaiaabaaaplabpaaaaacaaaaaaiaacaaaplabpaaaaacaaaaaaiaadaaadla
bpaaaaacaaaaaaiaaeaachlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaaja
abaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkabpaaaaac
aaaaaajaaeaiapkaabaaaaacaaaaabiaabaakklaabaaaaacaaaaaciaabaaffla
abaaaaacabaaadiaabaanclaagaaaaacaaaaaeiaacaapplaafaaaaadacaaadia
aaaakkiaacaaoelaecaaaaadadaaapiaabaaoelaaaaioekaecaaaaadaeaaapia
aaaaoeiaaaaioekaecaaaaadaaaaapiaaaaaoeiaabaioekaecaaaaadafaaapia
abaaoeiaaaaioekaecaaaaadabaaapiaabaaoeiaabaioekaecaaaaadagaaapia
abaaoelaabaioekaecaaaaadahaacpiaadaaoelaaeaioekaecaaaaadaiaacpia
adaaoelaadaioekaecaaaaadacaacpiaacaaoeiaacaioekaafaaaaadaaaaahia
aaaaoeiaaaaaaalaafaaaaadaeaaahiaaeaaoeiaaaaaaalaaeaaaaaeadaaahia
adaaoeiaaaaakklaaeaaoeiaaeaaaaaeadaaahiaafaaoeiaaaaafflaadaaoeia
aeaaaaaeaaaaahiaagaaoeiaaaaakklaaaaaoeiaaeaaaaaeaaaaahiaabaaoeia
aaaafflaaaaaoeiabcaaaaaeabaaahiaabaaaakaaaaaoeiaadaaoeiaafaaaaad
aaaaahiaabaaoeiaacaaoekaabaaaaacadaaahiaacaaoekaaeaaaaaeabaaahia
abaaoeiaadaaoeibadaaoekaabaaaaacaaaaaiiaafaappkaacaaaaadaaaaaiia
aaaappibagaaaakaagaaaaacaaaaaiiaaaaappiaacaaaaadabaaaiiaabaappla
afaappkbafaaaaadaaaabiiaaaaappiaabaappiaaeaaaaaeabaaaiiaaaaappia
aiaaaakaaiaaffkaafaaaaadaaaaaiiaaaaappiaaaaappiaafaaaaadaaaaaiia
aaaappiaabaappiaaeaaaaaeaaaachiaaaaappiaabaaoeiaaaaaoeiaafaaaaad
aaaaciiaahaappiaaiaappkaafaaaaadabaachiaahaaoeiaaaaappiaafaaaaad
adaaahiaabaaffiaakaaoekaaeaaaaaeadaaahiaabaaaaiaajaaoekaadaaoeia
aeaaaaaeabaaahiaabaakkiaalaaoekaadaaoeiaaiaaaaadaaaaaiiaabaaoeia
abaaoeiaahaaaaacaaaaaiiaaaaappiaceaaaaacadaachiaaeaaoelaaeaaaaae
abaachiaabaaoeiaaaaappiaadaaoeiaaiaaaaadaaaaciiaabaaoeiaabaaoeia
ahaaaaacaaaaciiaaaaappiaafaaaaadaaaaciiaaaaappiaabaakkiaalaaaaad
abaaabiaaaaappiaakaappkaabaaaaacaaaaaiiaajaappkaafaaaaadaaaaaiia
aaaappiaaeaaaakacaaaaaadadaaciiaabaaaaiaaaaappiaafaaaaadaaaaciia
aiaappiaaiaappkaafaaaaadadaachiaaiaaoeiaaaaappiaapaaaaacabaacbia
acaaaaiaapaaaaacabaacciaacaaffiaapaaaaacabaaceiaacaakkiaapaaaaac
abaaciiaacaappiaacaaaaadabaacpiaadaaoeiaabaaoeibafaaaaadacaachia
abaaoeiaaaaaoekaafaaaaadaaaaciiaabaappiaaeaaffkaafaaaaadacaachia
aaaappiaacaaoeiaaeaaaaaeabaachiaaaaaoeiaabaaoeiaacaaoeiaabaaaaac
aaaaaeiaaiaakkkaacaaaaadaaaacbiaaaaakkiaahaaaakbaeaaaaaeabaaciia
aaaappiaaaaappkaaaaaaaiaabaaaaacaaaicpiaabaaoeiappppaaaafdeieefc
cmaiaaaaeaaaaaaaalacaaaafjaaaaaeegiocaaaaaaaaaaabdaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaa
aeaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaa
gcbaaaadlcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaa
aaaaaaaaggbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaabaaaaaakgbkbaaaabaaaaaaegacbaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaacgbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaafgbfbaaaabaaaaaa
egacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaggbkbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
agbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaa
kgbkbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaacgbkbaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaa
egacbaaaacaaaaaafgbfbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaagiacaaaaaaaaaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaa
dcaaaaamhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaaaaaaaaa
afaaaaaaegiccaaaaaaaaaaaagaaaaaaaaaaaaakicaabaaaaaaaaaaadkiacaia
ebaaaaaaaaaaaaaaamaaaaaaakiacaaaaaaaaaaaanaaaaaaaoaaaaakicaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaaaaaaaaa
aaaaaaajicaabaaaabaaaaaadkbabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaa
amaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaa
dcaaaaajicaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaa
aaaaeaeadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaaj
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaaeghobaaaaeaaaaaaaagabaaa
aeaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaeb
diaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaadiaaaaak
hcaabaaaacaaaaaafgafbaaaabaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddp
aaaaaaaadcaaaaamlcaabaaaabaaaaaaagaabaaaabaaaaaaaceaaaaaolaffbdp
aaaaaaaaaaaaaaaadkmnbddpegaibaaaacaaaaaadcaaaaamhcaabaaaabaaaaaa
kgakbaaaabaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegadbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaabaaaaaahicaabaaaabaaaaaa
egbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaaegbcbaaaafaaaaaa
dcaaaaajhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
acaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaackaabaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaaibcaabaaaabaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaed
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabjaaaaaf
icaabaaaabaaaaaadkaabaaaaaaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaa
adaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaacpaaaaafpcaabaaaacaaaaaaegaobaaa
acaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaaeaaaaaaeghobaaaadaaaaaa
aagabaaaadaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaadaaaaaaabeaaaaa
aaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaadaaaaaapgapbaaaaaaaaaaa
aaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaa
diaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaa
diaaaaaiicaabaaaaaaaaaaadkaabaaaabaaaaaabkiacaaaaaaaaaaaaiaaaaaa
diaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaaj
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
aaaaaaajbcaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaabcaaaaaaabeaaaaa
aaaaiadpdcaaaaakiccabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaa
acaaaaaaakaabaaaaaaaaaaadoaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaahahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaapapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaa
keaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaakeaaaaaaaeaaaaaa
aaaaaaaaadaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
				}
				SubProgram "opengl " {
					Keywords {
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_ON"
					}
					Vector 0[_SpecColor]
					Float 1[_Mix]
					Vector 2[_Color]
					Vector 3[_ColorFromSpace]
					Float 4[_Gloss]
					Float 5[_fadeStart]
					Float 6[_fadeEnd]
					Float 7[_PlanetOpacity]
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_LightBuffer] 2D 2 "!!ARBfp1.0
PARAM c[9] = { program.local[0..7],
		{ 1, 2, 3 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TXP R0, fragment.texcoord[2], texture[2], 2D;
TEX R6.xyz, fragment.texcoord[1].zyzw, texture[0], 2D;
TEX R3.xyz, fragment.texcoord[1].zyzw, texture[1], 2D;
TEX R1.xyz, fragment.texcoord[1].zxzw, texture[1], 2D;
TEX R4.xyz, fragment.texcoord[1].zxzw, texture[0], 2D;
TEX R2.xyz, fragment.texcoord[1], texture[1], 2D;
TEX R5.xyz, fragment.texcoord[1], texture[0], 2D;
MUL R3.xyz, fragment.texcoord[0].x, R3;
MAD R2.xyz, fragment.texcoord[0].z, R2, R3;
MUL R6.xyz, fragment.texcoord[0].x, R6;
MAD R5.xyz, fragment.texcoord[0].z, R5, R6;
MOV R1.w, c[5].x;
MAD R1.xyz, R1, fragment.texcoord[0].y, R2;
MAD R3.xyz, fragment.texcoord[0].y, R4, R5;
ADD R1.w, -R1, c[6].x;
RCP R2.x, R1.w;
ADD R1.xyz, R1, -R3;
MAD R1.xyz, R1, c[1].x, R3;
ADD R1.w, fragment.texcoord[1], -c[5].x;
MUL_SAT R1.w, R1, R2.x;
MUL R1.xyz, -R1, c[2];
MAD R2.w, -R1, c[8].y, c[8].z;
MUL R1.w, R1, R1;
ADD R2.xyz, R1, c[3];
MUL R1.w, R1, R2;
MAD R1.xyz, R1.w, R2, -R1;
MUL R1.w, R0, c[4].x;
ADD R0.xyz, R0, fragment.texcoord[3];
MUL R2.xyz, R0, c[0];
MOV R0.w, c[8].x;
MUL R2.xyz, R1.w, R2;
ADD R0.w, R0, -c[7].x;
MAD result.color.xyz, R1, R0, R2;
MAD result.color.w, R1, c[0], R0;
END
# 34 instructions, 7 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_ON"
					}
					Vector 0[_SpecColor]
					Float 1[_Mix]
					Vector 2[_Color]
					Vector 3[_ColorFromSpace]
					Float 4[_Gloss]
					Float 5[_fadeStart]
					Float 6[_fadeEnd]
					Float 7[_PlanetOpacity]
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_LightBuffer] 2D 2 "ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c8, 1.00000000, 2.00000000, 3.00000000, 0
dcl t0.xyz
dcl t1
dcl t2
dcl t3.xyz
texld r5, t1, s1
mov r4.xy, t1.zxyw
mov r3.xy, t1.zxyw
mov r1.y, t1
mov r1.x, t1.z
mov r2.xy, r1
mov r0.y, t1
mov r0.x, t1.z
texld r6, r4, s1
texld r4, r2, s1
texld r2, t1, s0
texldp r1, t2, s2
texld r3, r3, s0
texld r0, r0, s0
mul r0.xyz, t0.x, r0
mad r0.xyz, t0.z, r2, r0
mul r2.xyz, t0.x, r4
mad r0.xyz, t0.y, r3, r0
mad r2.xyz, t0.z, r5, r2
mad r2.xyz, r6, t0.y, r2
add r2.xyz, r2, -r0
mad r2.xyz, r2, c1.x, r0
mul r3.xyz, -r2, c2
mov r0.x, c6
add r0.x, -c5, r0
rcp r2.x, r0.x
add r0.x, t1.w, -c5
mul_sat r2.x, r0, r2
mad r0.x, -r2, c8.y, c8.z
mul r2.x, r2, r2
add r4.xyz, r3, c3
mul r0.x, r2, r0
mad r2.xyz, r0.x, r4, -r3
add_pp r3.xyz, r1, t3
mov r1.x, c7
mul_pp r0.x, r1.w, c4
mul_pp r4.xyz, r3, c0
mul_pp r4.xyz, r0.x, r4
add r1.x, c8, -r1
mad_pp r2.xyz, r2, r3, r4
mad_pp r2.w, r0.x, c0, r1.x
mov_pp oC0, r2
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_ON"
					}
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_LightBuffer] 2D 2
					ConstBuffer "$Globals"
					320
					Vector 32[_SpecColor]
					Float 48[_Mix]
					Vector 80[_Color]
					Vector 96[_ColorFromSpace]
					Float 132[_Gloss]
					Float 204[_fadeStart]
					Float 208[_fadeEnd]
					Float 288[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedmckjpopnbcikfoohkoeflhgjmcblcdhnabaaaaaacmagaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcceafaaaaeaaaaaaaejabaaaafjaaaaaeegiocaaaaaaaaaaabdaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaa
gcbaaaadpcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaa
aaaaaaaaggbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaabaaaaaakgbkbaaaabaaaaaaegacbaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaacgbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaafgbfbaaaabaaaaaa
egacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaggbkbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
agbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaa
kgbkbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaacgbkbaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaa
egacbaaaacaaaaaafgbfbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaagiacaaaaaaaaaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaa
dcaaaaamhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaaaaaaaaa
afaaaaaaegiccaaaaaaaaaaaagaaaaaaaaaaaaakicaabaaaaaaaaaaadkiacaia
ebaaaaaaaaaaaaaaamaaaaaaakiacaaaaaaaaaaaanaaaaaaaoaaaaakicaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaaaaaaaaa
aaaaaaajicaabaaaabaaaaaadkbabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaa
amaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaa
dcaaaaajicaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaa
aaaaeaeadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaaj
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
aoaaaaahdcaabaaaabaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
aaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegbcbaaaaeaaaaaadiaaaaai
icaabaaaaaaaaaaadkaabaaaabaaaaaabkiacaaaaaaaaaaaaiaaaaaadiaaaaai
hcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaah
hcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaajhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaaj
bcaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaabcaaaaaaabeaaaaaaaaaiadp
dcaaaaakiccabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaacaaaaaa
akaabaaaaaaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_ON"
					}
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_LightBuffer] 2D 2
					ConstBuffer "$Globals"
					320
					Vector 32[_SpecColor]
					Float 48[_Mix]
					Vector 80[_Color]
					Vector 96[_ColorFromSpace]
					Float 132[_Gloss]
					Float 204[_fadeStart]
					Float 208[_fadeEnd]
					Float 288[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0_level_9_1
eefiecedcgmmpcgdhbabdkhgjimapoppblllialmabaaaaaajmajaaaaaeaaaaaa
daaaaaaajmadaaaamiaiaaaagiajaaaaebgpgodjgeadaaaageadaaaaaaacpppp
piacaaaagmaaaaaaafaadaaaaaaagmaaaaaagmaaadaaceaaaaaagmaaaaaaaaaa
abababaaacacacaaaaaaacaaacaaaaaaaaaaaaaaaaaaafaaacaaacaaaaaaaaaa
aaaaaiaaabaaaeaaaaaaaaaaaaaaamaaacaaafaaaaaaaaaaaaaabcaaabaaahaa
aaaaaaaaaaacppppfbaaaaafaiaaapkaaaaaaamaaaaaeaeaaaaaiadpaaaaaaaa
bpaaaaacaaaaaaiaaaaaahlabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaaiaadaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaac
aaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaabaaaaacaaaaabiaabaakkla
abaaaaacaaaaaciaabaafflaabaaaaacabaaadiaabaanclaagaaaaacaaaaaeia
acaapplaafaaaaadacaaadiaaaaakkiaacaaoelaecaaaaadadaaapiaabaaoela
aaaioekaecaaaaadaeaaapiaaaaaoeiaaaaioekaecaaaaadaaaaapiaaaaaoeia
abaioekaecaaaaadafaaapiaabaaoeiaaaaioekaecaaaaadabaaapiaabaaoeia
abaioekaecaaaaadagaaapiaabaaoelaabaioekaecaaaaadacaacpiaacaaoeia
acaioekaafaaaaadaaaaahiaaaaaoeiaaaaaaalaafaaaaadaeaaahiaaeaaoeia
aaaaaalaaeaaaaaeadaaahiaadaaoeiaaaaakklaaeaaoeiaaeaaaaaeadaaahia
afaaoeiaaaaafflaadaaoeiaaeaaaaaeaaaaahiaagaaoeiaaaaakklaaaaaoeia
aeaaaaaeaaaaahiaabaaoeiaaaaafflaaaaaoeiabcaaaaaeabaaahiaabaaaaka
aaaaoeiaadaaoeiaafaaaaadaaaaahiaabaaoeiaacaaoekaabaaaaacadaaahia
acaaoekaaeaaaaaeabaaahiaabaaoeiaadaaoeibadaaoekaabaaaaacaaaaaiia
afaappkaacaaaaadaaaaaiiaaaaappibagaaaakaagaaaaacaaaaaiiaaaaappia
acaaaaadabaaaiiaabaapplaafaappkbafaaaaadaaaabiiaaaaappiaabaappia
aeaaaaaeabaaaiiaaaaappiaaiaaaakaaiaaffkaafaaaaadaaaaaiiaaaaappia
aaaappiaafaaaaadaaaaaiiaaaaappiaabaappiaaeaaaaaeaaaachiaaaaappia
abaaoeiaaaaaoeiaacaaaaadabaachiaacaaoeiaadaaoelaafaaaaadaaaaciia
acaappiaaeaaffkaafaaaaadacaachiaabaaoeiaaaaaoekaafaaaaadacaachia
aaaappiaacaaoeiaaeaaaaaeabaachiaaaaaoeiaabaaoeiaacaaoeiaabaaaaac
aaaaaeiaaiaakkkaacaaaaadaaaacbiaaaaakkiaahaaaakbaeaaaaaeabaaciia
aaaappiaaaaappkaaaaaaaiaabaaaaacaaaicpiaabaaoeiappppaaaafdeieefc
ceafaaaaeaaaaaaaejabaaaafjaaaaaeegiocaaaaaaaaaaabdaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
pcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
ggbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaabaaaaaakgbkbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaacgbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaafgbfbaaaabaaaaaaegacbaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaggbkbaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaakgbkbaaa
abaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaacgbkbaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
acaaaaaafgbfbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaa
agiacaaaaaaaaaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaadcaaaaam
hcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaa
egiccaaaaaaaaaaaagaaaaaaaaaaaaakicaabaaaaaaaaaaadkiacaiaebaaaaaa
aaaaaaaaamaaaaaaakiacaaaaaaaaaaaanaaaaaaaoaaaaakicaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaaaaaaaaaaaaaaaaj
icaabaaaabaaaaaadkbabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaaamaaaaaa
dicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaaj
icaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaea
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaaoaaaaah
dcaabaaaabaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaa
abaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegbcbaaaaeaaaaaadiaaaaaiicaabaaa
aaaaaaaadkaabaaaabaaaaaabkiacaaaaaaaaaaaaiaaaaaadiaaaaaihcaabaaa
acaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaa
acaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaajhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaajbcaabaaa
aaaaaaaaakiacaiaebaaaaaaaaaaaaaabcaaaaaaabeaaaaaaaaaiadpdcaaaaak
iccabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaacaaaaaaakaabaaa
aaaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaahahaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapapaaaa
imaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaaimaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
				}
				SubProgram "opengl " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_ON"
					}
					Vector 0[_SpecColor]
					Float 1[_Mix]
					Vector 2[_Color]
					Vector 3[_ColorFromSpace]
					Float 4[_Gloss]
					Float 5[_fadeStart]
					Float 6[_fadeEnd]
					Float 7[_PlanetOpacity]
					Vector 8[unity_LightmapFade]
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_LightBuffer] 2D 2
					SetTexture 3[unity_Lightmap] 2D 3
					SetTexture 4[unity_LightmapInd] 2D 4 "!!ARBfp1.0
PARAM c[10] = { program.local[0..8],
		{ 1, 2, 3, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEMP R8;
TEX R1, fragment.texcoord[3], texture[3], 2D;
TEX R2, fragment.texcoord[3], texture[4], 2D;
TEX R8.xyz, fragment.texcoord[1].zyzw, texture[0], 2D;
TEX R5.xyz, fragment.texcoord[1].zyzw, texture[1], 2D;
TXP R0, fragment.texcoord[2], texture[2], 2D;
TEX R3.xyz, fragment.texcoord[1].zxzw, texture[1], 2D;
TEX R6.xyz, fragment.texcoord[1].zxzw, texture[0], 2D;
TEX R4.xyz, fragment.texcoord[1], texture[1], 2D;
TEX R7.xyz, fragment.texcoord[1], texture[0], 2D;
MUL R5.xyz, fragment.texcoord[0].x, R5;
MAD R4.xyz, fragment.texcoord[0].z, R4, R5;
MUL R2.xyz, R2.w, R2;
MUL R1.xyz, R1.w, R1;
MUL R2.xyz, R2, c[9].w;
DP4 R1.w, fragment.texcoord[4], fragment.texcoord[4];
RSQ R2.w, R1.w;
MUL R8.xyz, fragment.texcoord[0].x, R8;
MAD R7.xyz, fragment.texcoord[0].z, R7, R8;
MOV R1.w, c[5].x;
RCP R2.w, R2.w;
MAD R1.xyz, R1, c[9].w, -R2;
MAD_SAT R2.w, R2, c[8].z, c[8];
MAD R1.xyz, R2.w, R1, R2;
ADD R1.w, -R1, c[6].x;
RCP R2.x, R1.w;
ADD R1.w, fragment.texcoord[1], -c[5].x;
MUL_SAT R1.w, R1, R2.x;
ADD R0.xyz, R0, R1;
MAD R3.xyz, R3, fragment.texcoord[0].y, R4;
MAD R5.xyz, fragment.texcoord[0].y, R6, R7;
ADD R3.xyz, R3, -R5;
MAD R3.xyz, R3, c[1].x, R5;
MUL R3.xyz, -R3, c[2];
MAD R1.y, -R1.w, c[9], c[9].z;
MUL R1.x, R1.w, R1.w;
MUL R1.w, R0, c[4].x;
MUL R2.xyz, R0, c[0];
MOV R0.w, c[9].x;
ADD R0.w, R0, -c[7].x;
ADD R4.xyz, R3, c[3];
MUL R1.x, R1, R1.y;
MAD R1.xyz, R1.x, R4, -R3;
MUL R2.xyz, R1.w, R2;
MAD result.color.xyz, R1, R0, R2;
MAD result.color.w, R1, c[0], R0;
END
# 45 instructions, 9 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_ON"
					}
					Vector 0[_SpecColor]
					Float 1[_Mix]
					Vector 2[_Color]
					Vector 3[_ColorFromSpace]
					Float 4[_Gloss]
					Float 5[_fadeStart]
					Float 6[_fadeEnd]
					Float 7[_PlanetOpacity]
					Vector 8[unity_LightmapFade]
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_LightBuffer] 2D 2
					SetTexture 3[unity_Lightmap] 2D 3
					SetTexture 4[unity_LightmapInd] 2D 4 "ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c9, 1.00000000, 2.00000000, 3.00000000, 8.00000000
dcl t0.xyz
dcl t1
dcl t2
dcl t3.xy
dcl t4
texldp r3, t2, s2
texld r1, t3, s3
texld r7, t1, s1
mov r6.xy, t1.zxyw
mov r5.xy, t1.zxyw
mov r0.y, t1
mov r0.x, t1.z
mov r2.xy, r0
mov r0.y, t1
mov r0.x, t1.z
mov r4.xy, r0
mul_pp r1.xyz, r1.w, r1
texld r8, r6, s1
texld r6, r4, s1
texld r2, r2, s0
texld r0, t3, s4
texld r5, r5, s0
texld r4, t1, s0
mul r2.xyz, t0.x, r2
mad r2.xyz, t0.z, r4, r2
mul r4.xyz, t0.x, r6
mad r2.xyz, t0.y, r5, r2
mul_pp r5.xyz, r0.w, r0
mul_pp r5.xyz, r5, c9.w
dp4 r0.x, t4, t4
rsq r0.x, r0.x
mad_pp r6.xyz, r1, c9.w, -r5
rcp r1.x, r0.x
mad_sat r1.x, r1, c8.z, c8.w
mad_pp r5.xyz, r1.x, r6, r5
mov r0.x, c6
add r0.x, -c5, r0
rcp r1.x, r0.x
add r0.x, t1.w, -c5
mul_sat r0.x, r0, r1
mad r1.x, -r0, c9.y, c9.z
mul r0.x, r0, r0
mul r0.x, r0, r1
mov r1.x, c7
add_pp r3.xyz, r3, r5
mad r4.xyz, t0.z, r7, r4
mad r4.xyz, r8, t0.y, r4
add r4.xyz, r4, -r2
mad r2.xyz, r4, c1.x, r2
mul r2.xyz, -r2, c2
add r4.xyz, r2, c3
mad r2.xyz, r0.x, r4, -r2
mul_pp r0.x, r3.w, c4
mul_pp r4.xyz, r3, c0
mul_pp r4.xyz, r0.x, r4
add r1.x, c9, -r1
mad_pp r2.xyz, r2, r3, r4
mad_pp r2.w, r0.x, c0, r1.x
mov_pp oC0, r2
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_ON"
					}
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_LightBuffer] 2D 2
					SetTexture 3[unity_Lightmap] 2D 3
					SetTexture 4[unity_LightmapInd] 2D 4
					ConstBuffer "$Globals"
					352
					Vector 32[_SpecColor]
					Float 48[_Mix]
					Vector 80[_Color]
					Vector 96[_ColorFromSpace]
					Float 132[_Gloss]
					Float 204[_fadeStart]
					Float 208[_fadeEnd]
					Float 288[_PlanetOpacity]
					Vector 320[unity_LightmapFade]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedfkcamieajachgjlancimjiikihkompjcabaaaaaammahaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckmagaaaa
eaaaaaaaklabaaaafjaaaaaeegiocaaaaaaaaaaabfaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaad
lcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
ggbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaabaaaaaakgbkbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaacgbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaafgbfbaaaabaaaaaaegacbaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaggbkbaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaakgbkbaaa
abaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaacgbkbaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
acaaaaaafgbfbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaa
agiacaaaaaaaaaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaadcaaaaam
hcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaa
egiccaaaaaaaaaaaagaaaaaaaaaaaaakicaabaaaaaaaaaaadkiacaiaebaaaaaa
aaaaaaaaamaaaaaaakiacaaaaaaaaaaaanaaaaaaaoaaaaakicaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaaaaaaaaaaaaaaaaj
icaabaaaabaaaaaadkbabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaaamaaaaaa
dicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaaj
icaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaea
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabbaaaaah
icaabaaaaaaaaaaaegbobaaaafaaaaaaegbobaaaafaaaaaaelaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadccaaaalicaabaaaaaaaaaaadkaabaaaaaaaaaaa
ckiacaaaaaaaaaaabeaaaaaadkiacaaaaaaaaaaabeaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaaeaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadiaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaaeaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahicaabaaa
abaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaebdcaaaaakhcaabaaaacaaaaaa
pgapbaaaabaaaaaaegacbaaaacaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaaj
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
aoaaaaahdcaabaaaacaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
aaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaai
icaabaaaaaaaaaaadkaabaaaacaaaaaabkiacaaaaaaaaaaaaiaaaaaadiaaaaai
hcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaah
hcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaajhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaaj
bcaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaabcaaaaaaabeaaaaaaaaaiadp
dcaaaaakiccabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaacaaaaaa
akaabaaaaaaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_ON"
					}
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_LightBuffer] 2D 2
					SetTexture 3[unity_Lightmap] 2D 3
					SetTexture 4[unity_LightmapInd] 2D 4
					ConstBuffer "$Globals"
					352
					Vector 32[_SpecColor]
					Float 48[_Mix]
					Vector 80[_Color]
					Vector 96[_ColorFromSpace]
					Float 132[_Gloss]
					Float 204[_fadeStart]
					Float 208[_fadeEnd]
					Float 288[_PlanetOpacity]
					Vector 320[unity_LightmapFade]
					BindCB "$Globals"
					0 "ps_4_0_level_9_1
eefiecedeeainhjajcgpbgapkfjllbcdfjmikaemabaaaaaaciamaaaaaeaaaaaa
daaaaaaaiiaeaaaadmalaaaapealaaaaebgpgodjfaaeaaaafaaeaaaaaaacpppp
naadaaaaiaaaaaaaagaadiaaaaaaiaaaaaaaiaaaafaaceaaaaaaiaaaaaaaaaaa
abababaaacacacaaadadadaaaeaeaeaaaaaaacaaacaaaaaaaaaaaaaaaaaaafaa
acaaacaaaaaaaaaaaaaaaiaaabaaaeaaaaaaaaaaaaaaamaaacaaafaaaaaaaaaa
aaaabcaaabaaahaaaaaaaaaaaaaabeaaabaaaiaaaaaaaaaaaaacppppfbaaaaaf
ajaaapkaaaaaaamaaaaaeaeaaaaaiadpaaaaaaebbpaaaaacaaaaaaiaaaaaahla
bpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaiaacaaaplabpaaaaacaaaaaaia
adaaadlabpaaaaacaaaaaaiaaeaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaac
aaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaajaadaiapka
bpaaaaacaaaaaajaaeaiapkaabaaaaacaaaaabiaabaakklaabaaaaacaaaaacia
abaafflaabaaaaacabaaadiaabaanclaagaaaaacaaaaaeiaacaapplaafaaaaad
acaaadiaaaaakkiaacaaoelaecaaaaadadaaapiaabaaoelaaaaioekaecaaaaad
aeaaapiaaaaaoeiaaaaioekaecaaaaadaaaaapiaaaaaoeiaabaioekaecaaaaad
afaaapiaabaaoeiaaaaioekaecaaaaadabaaapiaabaaoeiaabaioekaecaaaaad
agaaapiaabaaoelaabaioekaecaaaaadahaacpiaadaaoelaaeaioekaecaaaaad
aiaacpiaadaaoelaadaioekaecaaaaadacaacpiaacaaoeiaacaioekaafaaaaad
aaaaahiaaaaaoeiaaaaaaalaafaaaaadaeaaahiaaeaaoeiaaaaaaalaaeaaaaae
adaaahiaadaaoeiaaaaakklaaeaaoeiaaeaaaaaeadaaahiaafaaoeiaaaaaffla
adaaoeiaaeaaaaaeaaaaahiaagaaoeiaaaaakklaaaaaoeiaaeaaaaaeaaaaahia
abaaoeiaaaaafflaaaaaoeiabcaaaaaeabaaahiaabaaaakaaaaaoeiaadaaoeia
afaaaaadaaaaahiaabaaoeiaacaaoekaabaaaaacadaaahiaacaaoekaaeaaaaae
abaaahiaabaaoeiaadaaoeibadaaoekaabaaaaacaaaaaiiaafaappkaacaaaaad
aaaaaiiaaaaappibagaaaakaagaaaaacaaaaaiiaaaaappiaacaaaaadabaaaiia
abaapplaafaappkbafaaaaadaaaabiiaaaaappiaabaappiaaeaaaaaeabaaaiia
aaaappiaajaaaakaajaaffkaafaaaaadaaaaaiiaaaaappiaaaaappiaafaaaaad
aaaaaiiaaaaappiaabaappiaaeaaaaaeaaaachiaaaaappiaabaaoeiaaaaaoeia
ajaaaaadaaaaaiiaaeaaoelaaeaaoelaahaaaaacaaaaaiiaaaaappiaagaaaaac
aaaaaiiaaaaappiaaeaaaaaeaaaadiiaaaaappiaaiaakkkaaiaappkaafaaaaad
ahaaciiaahaappiaajaappkaafaaaaadabaachiaahaaoeiaahaappiaafaaaaad
abaaciiaaiaappiaajaappkaaeaaaaaeadaachiaabaappiaaiaaoeiaabaaoeib
aeaaaaaeabaachiaaaaappiaadaaoeiaabaaoeiaacaaaaadabaachiaabaaoeia
acaaoeiaafaaaaadaaaaciiaacaappiaaeaaffkaafaaaaadacaachiaabaaoeia
aaaaoekaafaaaaadacaachiaaaaappiaacaaoeiaaeaaaaaeabaachiaaaaaoeia
abaaoeiaacaaoeiaabaaaaacaaaaaeiaajaakkkaacaaaaadaaaacbiaaaaakkia
ahaaaakbaeaaaaaeabaaciiaaaaappiaaaaappkaaaaaaaiaabaaaaacaaaicpia
abaaoeiappppaaaafdeieefckmagaaaaeaaaaaaaklabaaaafjaaaaaeegiocaaa
aaaaaaaabfaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaa
ffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaa
gcbaaaadpcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaaddcbabaaa
aeaaaaaagcbaaaadpcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaaefaaaaajpcaabaaaaaaaaaaaggbkbaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaagbabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaakgbkbaaa
abaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaacgbkbaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
abaaaaaafgbfbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
ggbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaa
abaaaaaaegacbaaaacaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaacgbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaafgbfbaaaabaaaaaaegacbaaa
abaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaagiacaaaaaaaaaaaadaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaaaaaaaaa
egiccaaaaaaaaaaaafaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaiaebaaaaaa
aaaaaaaaegiccaaaaaaaaaaaafaaaaaaegiccaaaaaaaaaaaagaaaaaaaaaaaaak
icaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaaamaaaaaaakiacaaaaaaaaaaa
anaaaaaaaoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaadkbabaaaacaaaaaa
dkiacaiaebaaaaaaaaaaaaaaamaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabbaaaaahicaabaaaaaaaaaaaegbobaaaafaaaaaa
egbobaaaafaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadccaaaal
icaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaabeaaaaaadkiacaaa
aaaaaaaabeaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaaeghobaaa
aeaaaaaaaagabaaaaeaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaadaaaaaa
aagabaaaadaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaaaebdcaaaaakhcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaa
egacbaiaebaaaaaaabaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaabaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaa
adaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaacaaaaaa
bkiacaaaaaaaaaaaaiaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaa
egiccaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaa
egacbaaaacaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaaaaaaaaajbcaabaaaaaaaaaaaakiacaiaebaaaaaa
aaaaaaaabcaaaaaaabeaaaaaaaaaiadpdcaaaaakiccabaaaaaaaaaaadkaabaaa
aaaaaaaadkiacaaaaaaaaaaaacaaaaaaakaabaaaaaaaaaaadoaaaaabejfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahahaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaapapaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapalaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
adadaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
				}
				SubProgram "opengl " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
						"HDR_LIGHT_PREPASS_ON"
					}
					Vector 0[_SpecColor]
					Float 1[_Mix]
					Vector 2[_Color]
					Vector 3[_ColorFromSpace]
					Float 4[_Shininess]
					Float 5[_Gloss]
					Float 6[_fadeStart]
					Float 7[_fadeEnd]
					Float 8[_PlanetOpacity]
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_LightBuffer] 2D 2
					SetTexture 3[unity_Lightmap] 2D 3
					SetTexture 4[unity_LightmapInd] 2D 4 "!!ARBfp1.0
PARAM c[13] = { program.local[0..8],
		{ 8, -0.40824828, -0.70710677, 0.57735026 },
		{ 0.81649655, 0, 0.57735026, 128 },
		{ -0.40824831, 0.70710677, 0.57735026, 1 },
		{ 2, 3 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEMP R8;
TEMP R9;
TEX R1, fragment.texcoord[3], texture[3], 2D;
TEX R2, fragment.texcoord[3], texture[4], 2D;
TEX R5.xyz, fragment.texcoord[1].zyzw, texture[1], 2D;
TEX R8.xyz, fragment.texcoord[1].zyzw, texture[0], 2D;
TXP R0, fragment.texcoord[2], texture[2], 2D;
TEX R3.xyz, fragment.texcoord[1].zxzw, texture[1], 2D;
TEX R6.xyz, fragment.texcoord[1].zxzw, texture[0], 2D;
TEX R4.xyz, fragment.texcoord[1], texture[1], 2D;
TEX R7.xyz, fragment.texcoord[1], texture[0], 2D;
MUL R2.xyz, R2.w, R2;
MUL R2.xyz, R2, c[9].x;
MUL R9.xyz, R2.y, c[11];
MUL R5.xyz, fragment.texcoord[0].x, R5;
MAD R4.xyz, fragment.texcoord[0].z, R4, R5;
MAD R9.xyz, R2.x, c[10], R9;
MAD R2.xyz, R2.z, c[9].yzww, R9;
DP3 R2.w, R2, R2;
RSQ R3.w, R2.w;
MUL R8.xyz, fragment.texcoord[0].x, R8;
MAD R7.xyz, fragment.texcoord[0].z, R7, R8;
DP3 R2.w, fragment.texcoord[4], fragment.texcoord[4];
MUL R1.xyz, R1.w, R1;
MAD R3.xyz, R3, fragment.texcoord[0].y, R4;
MAD R5.xyz, fragment.texcoord[0].y, R6, R7;
ADD R3.xyz, R3, -R5;
MUL R2.xyz, R3.w, R2;
RSQ R2.w, R2.w;
MAD R4.xyz, R2.w, fragment.texcoord[4], R2;
DP3 R2.w, R4, R4;
RSQ R3.w, R2.w;
MAD R3.xyz, R3, c[1].x, R5;
MUL R2.xyz, -R3, c[2];
MOV R2.w, c[10];
MUL R4.x, R2.w, c[4];
MUL R3.w, R3, R4.z;
MAX R2.w, R3, c[10].y;
POW R4.w, R2.w, R4.x;
MUL R4.xyz, R1, c[9].x;
MOV R2.w, c[6].x;
ADD R1.w, -R2, c[7].x;
ADD R0, R0, R4;
RCP R1.y, R1.w;
MUL R1.w, R0, c[5].x;
ADD R1.x, fragment.texcoord[1].w, -c[6];
MUL_SAT R1.x, R1, R1.y;
MAD R1.y, -R1.x, c[12].x, c[12];
MUL R1.x, R1, R1;
MOV R0.w, c[11];
ADD R0.w, R0, -c[8].x;
ADD R3.xyz, R2, c[3];
MUL R1.x, R1, R1.y;
MAD R1.xyz, R1.x, R3, -R2;
MUL R2.xyz, R0, c[0];
MUL R2.xyz, R1.w, R2;
MAD result.color.xyz, R0, R1, R2;
MAD result.color.w, R1, c[0], R0;
END
# 56 instructions, 10 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
						"HDR_LIGHT_PREPASS_ON"
					}
					Vector 0[_SpecColor]
					Float 1[_Mix]
					Vector 2[_Color]
					Vector 3[_ColorFromSpace]
					Float 4[_Shininess]
					Float 5[_Gloss]
					Float 6[_fadeStart]
					Float 7[_fadeEnd]
					Float 8[_PlanetOpacity]
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_LightBuffer] 2D 2
					SetTexture 3[unity_Lightmap] 2D 3
					SetTexture 4[unity_LightmapInd] 2D 4 "ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c9, 8.00000000, -0.40824831, 0.70710677, 0.57735026
def c10, 0.81649655, 0.00000000, 0.57735026, 128.00000000
def c11, -0.40824828, -0.70710677, 0.57735026, 1.00000000
def c12, 2.00000000, 3.00000000, 0, 0
dcl t0.xyz
dcl t1
dcl t2
dcl t3.xy
dcl t4.xyz
texld r1, t3, s3
texldp r2, t2, s2
texld r7, t1, s1
mov r5.xy, t1.zxyw
mov r0.y, t1
mov r0.x, t1.z
mov r3.xy, r0
mov r0.y, t1
mov r0.x, t1.z
mov r4.xy, t1.zxyw
mul_pp r1.xyz, r1.w, r1
texld r8, r5, s1
texld r5, r4, s0
texld r6, r0, s1
texld r4, t1, s0
texld r0, t3, s4
texld r3, r3, s0
mul_pp r0.xyz, r0.w, r0
mul_pp r9.xyz, r0, c9.x
mul r3.xyz, t0.x, r3
mad r3.xyz, t0.z, r4, r3
mul r4.xyz, t0.x, r6
mad r3.xyz, t0.y, r5, r3
mov r0.x, c9.y
mov r0.z, c9.w
mov r0.y, c9.z
mul r0.xyz, r9.y, r0
mad r0.xyz, r9.x, c10, r0
mad r9.xyz, r9.z, c11, r0
dp3 r0.x, r9, r9
rsq r0.x, r0.x
mul r9.xyz, r0.x, r9
dp3_pp r0.x, t4, t4
rsq_pp r0.x, r0.x
mad_pp r0.xyz, r0.x, t4, r9
dp3_pp r0.x, r0, r0
mad r4.xyz, t0.z, r7, r4
mad r4.xyz, r8, t0.y, r4
add r4.xyz, r4, -r3
mad r5.xyz, r4, c1.x, r3
rsq_pp r3.x, r0.x
mov_pp r0.x, c4
mul_pp r0.z, r3.x, r0
mul_pp r0.x, c10.w, r0
max_pp r3.x, r0.z, c10.y
pow r4.w, r3.x, r0.x
mul r3.xyz, -r5, c2
mul_pp r4.xyz, r1, c9.x
add_pp r2, r2, r4
mov r0.x, c7
add r0.x, -c6, r0
rcp r1.x, r0.x
add r0.x, t1.w, -c6
mul_sat r0.x, r0, r1
mad r1.x, -r0, c12, c12.y
mul r0.x, r0, r0
mul r0.x, r0, r1
add r5.xyz, r3, c3
mad r3.xyz, r0.x, r5, -r3
mov r1.x, c8
mul_pp r0.x, r2.w, c5
mul_pp r4.xyz, r2, c0
mul_pp r4.xyz, r0.x, r4
add r1.x, c11.w, -r1
mad_pp r2.xyz, r2, r3, r4
mad_pp r2.w, r0.x, c0, r1.x
mov_pp oC0, r2
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
						"HDR_LIGHT_PREPASS_ON"
					}
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_LightBuffer] 2D 2
					SetTexture 3[unity_Lightmap] 2D 3
					SetTexture 4[unity_LightmapInd] 2D 4
					ConstBuffer "$Globals"
					352
					Vector 32[_SpecColor]
					Float 48[_Mix]
					Vector 80[_Color]
					Vector 96[_ColorFromSpace]
					Float 128[_Shininess]
					Float 132[_Gloss]
					Float 204[_fadeStart]
					Float 208[_fadeEnd]
					Float 288[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedlaogfnfhoeghlecmlhehckgfnlpfomfgabaaaaaadeajaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbeaiaaaa
eaaaaaaaafacaaaafjaaaaaeegiocaaaaaaaaaaabdaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaad
lcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
ggbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaabaaaaaakgbkbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaacgbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaafgbfbaaaabaaaaaaegacbaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaggbkbaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaakgbkbaaa
abaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaacgbkbaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
acaaaaaafgbfbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaa
agiacaaaaaaaaaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaadcaaaaam
hcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaa
egiccaaaaaaaaaaaagaaaaaaaaaaaaakicaabaaaaaaaaaaadkiacaiaebaaaaaa
aaaaaaaaamaaaaaaakiacaaaaaaaaaaaanaaaaaaaoaaaaakicaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaaaaaaaaaaaaaaaaj
icaabaaaabaaaaaadkbabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaaamaaaaaa
dicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaaj
icaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaea
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaaeaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaadiaaaaakhcaabaaa
acaaaaaafgafbaaaabaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaa
dcaaaaamlcaabaaaabaaaaaaagaabaaaabaaaaaaaceaaaaaolaffbdpaaaaaaaa
aaaaaaaadkmnbddpegaibaaaacaaaaaadcaaaaamhcaabaaaabaaaaaakgakbaaa
abaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegadbaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaabaaaaaahicaabaaaabaaaaaaegbcbaaa
afaaaaaaegbcbaaaafaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaaegbcbaaaafaaaaaadcaaaaaj
hcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaackaabaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
bcaabaaaabaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabjaaaaaficaabaaa
abaaaaaadkaabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaaeaaaaaa
eghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
acaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaacaaaaaa
pgapbaaaaaaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaaadaaaaaapgbpbaaa
adaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
acaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaabaaaaaabkiacaaaaaaaaaaa
aiaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaajhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaaaaaaaaajbcaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaabcaaaaaa
abeaaaaaaaaaiadpdcaaaaakiccabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaa
aaaaaaaaacaaaaaaakaabaaaaaaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
						"HDR_LIGHT_PREPASS_ON"
					}
					SetTexture 0[_WaterTex] 2D 0
					SetTexture 1[_WaterTex1] 2D 1
					SetTexture 2[_LightBuffer] 2D 2
					SetTexture 3[unity_Lightmap] 2D 3
					SetTexture 4[unity_LightmapInd] 2D 4
					ConstBuffer "$Globals"
					352
					Vector 32[_SpecColor]
					Float 48[_Mix]
					Vector 80[_Color]
					Vector 96[_ColorFromSpace]
					Float 128[_Shininess]
					Float 132[_Gloss]
					Float 204[_fadeStart]
					Float 208[_fadeEnd]
					Float 288[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0_level_9_1
eefiecedmjlklgclailmkjihmiidlbojmlcpcjiiabaaaaaafeaoaaaaaeaaaaaa
daaaaaaaemafaaaagianaaaacaaoaaaaebgpgodjbeafaaaabeafaaaaaaacpppp
kaaeaaaaheaaaaaaafaadiaaaaaaheaaaaaaheaaafaaceaaaaaaheaaaaaaaaaa
abababaaacacacaaadadadaaaeaeaeaaaaaaacaaacaaaaaaaaaaaaaaaaaaafaa
acaaacaaaaaaaaaaaaaaaiaaabaaaeaaaaaaaaaaaaaaamaaacaaafaaaaaaaaaa
aaaabcaaabaaahaaaaaaaaaaaaacppppfbaaaaafaiaaapkaaaaaaamaaaaaeaea
aaaaiadpaaaaaaebfbaaaaafajaaapkaolaffbdpaaaaaaaadkmnbddpaaaaaaed
fbaaaaafakaaapkaomafnblopdaedfdpdkmnbddpaaaaaaaafbaaaaafalaaapka
olafnblopdaedflpdkmnbddpaaaaaaaabpaaaaacaaaaaaiaaaaaahlabpaaaaac
aaaaaaiaabaaaplabpaaaaacaaaaaaiaacaaaplabpaaaaacaaaaaaiaadaaadla
bpaaaaacaaaaaaiaaeaachlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaaja
abaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkabpaaaaac
aaaaaajaaeaiapkaabaaaaacaaaaabiaabaakklaabaaaaacaaaaaciaabaaffla
abaaaaacabaaadiaabaanclaagaaaaacaaaaaeiaacaapplaafaaaaadacaaadia
aaaakkiaacaaoelaecaaaaadadaaapiaabaaoelaaaaioekaecaaaaadaeaaapia
aaaaoeiaaaaioekaecaaaaadaaaaapiaaaaaoeiaabaioekaecaaaaadafaaapia
abaaoeiaaaaioekaecaaaaadabaaapiaabaaoeiaabaioekaecaaaaadagaaapia
abaaoelaabaioekaecaaaaadahaacpiaadaaoelaaeaioekaecaaaaadacaacpia
acaaoeiaacaioekaecaaaaadaiaacpiaadaaoelaadaioekaafaaaaadaaaaahia
aaaaoeiaaaaaaalaafaaaaadaeaaahiaaeaaoeiaaaaaaalaaeaaaaaeadaaahia
adaaoeiaaaaakklaaeaaoeiaaeaaaaaeadaaahiaafaaoeiaaaaafflaadaaoeia
aeaaaaaeaaaaahiaagaaoeiaaaaakklaaaaaoeiaaeaaaaaeaaaaahiaabaaoeia
aaaafflaaaaaoeiabcaaaaaeabaaahiaabaaaakaaaaaoeiaadaaoeiaafaaaaad
aaaaahiaabaaoeiaacaaoekaabaaaaacadaaahiaacaaoekaaeaaaaaeabaaahia
abaaoeiaadaaoeibadaaoekaabaaaaacaaaaaiiaafaappkaacaaaaadaaaaaiia
aaaappibagaaaakaagaaaaacaaaaaiiaaaaappiaacaaaaadabaaaiiaabaappla
afaappkbafaaaaadaaaabiiaaaaappiaabaappiaaeaaaaaeabaaaiiaaaaappia
aiaaaakaaiaaffkaafaaaaadaaaaaiiaaaaappiaaaaappiaafaaaaadaaaaaiia
aaaappiaabaappiaaeaaaaaeaaaachiaaaaappiaabaaoeiaaaaaoeiaafaaaaad
aaaaciiaahaappiaaiaappkaafaaaaadabaachiaahaaoeiaaaaappiaafaaaaad
adaaahiaabaaffiaakaaoekaaeaaaaaeadaaahiaabaaaaiaajaaoekaadaaoeia
aeaaaaaeabaaahiaabaakkiaalaaoekaadaaoeiaaiaaaaadaaaaaiiaabaaoeia
abaaoeiaahaaaaacaaaaaiiaaaaappiaceaaaaacadaachiaaeaaoelaaeaaaaae
abaachiaabaaoeiaaaaappiaadaaoeiaaiaaaaadaaaaciiaabaaoeiaabaaoeia
ahaaaaacaaaaciiaaaaappiaafaaaaadaaaaciiaaaaappiaabaakkiaalaaaaad
abaaabiaaaaappiaakaappkaabaaaaacaaaaaiiaajaappkaafaaaaadaaaaaiia
aaaappiaaeaaaakacaaaaaadadaaciiaabaaaaiaaaaappiaafaaaaadaaaaciia
aiaappiaaiaappkaafaaaaadadaachiaaiaaoeiaaaaappiaacaaaaadabaacpia
acaaoeiaadaaoeiaafaaaaadacaachiaabaaoeiaaaaaoekaafaaaaadaaaaciia
abaappiaaeaaffkaafaaaaadacaachiaaaaappiaacaaoeiaaeaaaaaeabaachia
aaaaoeiaabaaoeiaacaaoeiaabaaaaacaaaaaeiaaiaakkkaacaaaaadaaaacbia
aaaakkiaahaaaakbaeaaaaaeabaaciiaaaaappiaaaaappkaaaaaaaiaabaaaaac
aaaicpiaabaaoeiappppaaaafdeieefcbeaiaaaaeaaaaaaaafacaaaafjaaaaae
egiocaaaaaaaaaaabdaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaad
aagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaagcbaaaadhcbabaaa
abaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaad
dcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaggbkbaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
agbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaa
kgbkbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaacgbkbaaa
acaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaabaaaaaafgbfbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaggbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaj
hcaabaaaabaaaaaaegacbaaaacaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaacgbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaafgbfbaaaabaaaaaa
egacbaaaabaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaia
ebaaaaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaagiacaaaaaaaaaaaadaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaafaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaia
ebaaaaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaaegiccaaaaaaaaaaaagaaaaaa
aaaaaaakicaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaaamaaaaaaakiacaaa
aaaaaaaaanaaaaaaaoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpdkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaadkbabaaa
acaaaaaadkiacaiaebaaaaaaaaaaaaaaamaaaaaadicaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
aeaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaapgapbaaaaaaaaaaadiaaaaakhcaabaaaacaaaaaafgafbaaaabaaaaaa
aceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaadcaaaaamlcaabaaaabaaaaaa
agaabaaaabaaaaaaaceaaaaaolaffbdpaaaaaaaaaaaaaaaadkmnbddpegaibaaa
acaaaaaadcaaaaamhcaabaaaabaaaaaakgakbaaaabaaaaaaaceaaaaaolafnblo
pdaedflpdkmnbddpaaaaaaaaegadbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaabaaaaaahicaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaa
eeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaa
pgapbaaaabaaaaaaegbcbaaaafaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaabaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaaakiacaaa
aaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaabjaaaaaficaabaaaabaaaaaadkaabaaaaaaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaadaaaaaaaagabaaa
adaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaeb
diaaaaahhcaabaaaabaaaaaaegacbaaaacaaaaaapgapbaaaaaaaaaaaaoaaaaah
dcaabaaaacaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaa
acaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadiaaaaaihcaabaaa
acaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaaiicaabaaa
aaaaaaaadkaabaaaabaaaaaabkiacaaaaaaaaaaaaiaaaaaadiaaaaahhcaabaaa
acaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaajhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaajbcaabaaa
aaaaaaaaakiacaiaebaaaaaaaaaaaaaabcaaaaaaabeaaaaaaaaaiadpdcaaaaak
iccabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaacaaaaaaakaabaaa
aaaaaaaadoaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaahahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapapaaaa
keaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaakeaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaadadaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
afaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
				}
			}
		}
	}
	Fallback "Diffuse"
}