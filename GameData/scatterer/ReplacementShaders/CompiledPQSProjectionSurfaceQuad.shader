Shader "Scatterer/PQS/Sphere Projection SURFACE QUAD" {
	Properties {
		_saturation("Saturation", Float) = 1
		_contrast("Contrast", Float) = 1
		_tintColor("Colour Unsaturation (A = Factor)", Color) = (1, 1, 1, 0)
		_texTiling("Near Tiling", Float) = 1000
		_texPower("Near Blend", Float) = 0.5
		_multiPower("Far Blend", Float) = 0.5
		_groundTexStart("NearFar Start", Float) = 2000
		_groundTexEnd("NearFar Start", Float) = 10000
		_steepTiling("Steep Tiling", Float) = 1
		_steepPower("Steep Blend", Float) = 1
		_steepTexStart("Steep Fade Start", Float) = 20000
		_steepTexEnd("Steep Fade End", Float) = 30000
		_deepTex("Deep ground", 2D) = "white" {}
		_deepMultiTex("Deep MT", 2D) = "white" {}
		_deepMultiFactor("Deep MT Tiling", Float) = 1
		_mainTex("Main Texture", 2D) = "white" {}
		_mainMultiTex("Main MT", 2D) = "white" {}
		_mainMultiFactor("Main MT Tiling", Float) = 1
		_highTex("High Ground", 2D) = "white" {}
		_highMultiTex("High MT", 2D) = "white" {}
		_highMultiFactor("High MT Tiling", Float) = 1
		_snowTex("Snow", 2D) = "white" {}
		_snowMultiTex("Snow MT", 2D) = "white" {}
		_snowMultiFactor("Snow MT Tiling", Float) = 1
		_steepTex("Steep Texture", 2D) = "white" {}
		_deepStart("Deep Start", Float) = 0
		_deepEnd("Deep End", Float) = 0.3
		_mainLoStart("Main lower boundary start", Float) = 0
		_mainLoEnd("Main lower boundary end", Float) = 0.5
		_mainHiStart("Main upper boundary start", Float) = 0.3
		_mainHiEnd("Main upper boundary end", Float) = 0.5
		_hiLoStart("High lower boundary start", Float) = 0.6
		_hiLoEnd("High lower boundary end", Float) = 0.6
		_hiHiStart("High upper boundary start", Float) = 0.6
		_hiHiEnd("High upper boundary end", Float) = 0.9
		_snowStart("Snow Start", Float) = 0.9
		_snowEnd("Snow End", Float) = 1
		_PlanetOpacity("PlanetOpacity", Float) = 1
	}
	SubShader {
ZWrite On
Tags { "RenderType"="Opaque"}
		Pass {
			Name "FORWARD"
			Tags {
				"LIGHTMODE" = "ForwardBase"
				"SHADOWSUPPORT" = "true"
			}
			Blend OneMinusSrcAlpha SrcAlpha
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
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Bind "tangent"
					ATTR14
					Matrix 9[_Object2World]
					Matrix 13[_World2Object]
					Vector 17[_WorldSpaceLightPos0]
					Vector 18[unity_SHAr]
					Vector 19[unity_SHAg]
					Vector 20[unity_SHAb]
					Vector 21[unity_SHBr]
					Vector 22[unity_SHBg]
					Vector 23[unity_SHBb]
					Vector 24[unity_SHC]
					Vector 25[unity_Scale]
					Vector 26[_tintColor]
					Float 27[_steepPower]
					Float 28[_saturation]
					Float 29[_contrast]
					"3.0-!!ARBvp1.0
PARAM c[31] = { { 0, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..29],
		{ 0.29899999, 0.58700001, 0.114 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[25].w;
DP3 R2.w, R1, c[10];
DP3 R0.x, R1, c[9];
DP3 R0.z, R1, c[11];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].y;
DP4 R2.z, R0, c[20];
DP4 R2.y, R0, c[19];
DP4 R2.x, R0, c[18];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[23];
DP4 R3.y, R1, c[22];
DP4 R3.x, R1, c[21];
ADD R3.xyz, R2, R3;
MAD R0.x, R0, R0, -R0.y;
MUL R2.xyz, R0.x, c[24];
MOV R1.xyz, vertex.attrib[14];
MUL R0.xyz, vertex.normal.zxyw, R1.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R1.zxyw, -R0;
MUL R1.xyz, R0, vertex.attrib[14].w;
MOV R0, c[17];
ADD result.texcoord[5].xyz, R3, R2;
DP3 R1.w, vertex.color, c[30];
ADD R2.xyz, vertex.color, -R1.w;
MAD R2.xyz, R2, c[28].x, R1.w;
DP4 R3.z, R0, c[15];
DP4 R3.y, R0, c[14];
DP4 R3.x, R0, c[13];
DP3 result.texcoord[4].y, R3, R1;
MOV R0.z, vertex.texcoord[1].x;
MOV R0.xy, vertex.texcoord[0];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
MOV result.texcoord[0].xyz, R0;
ABS result.texcoord[1].xyz, R0;
DP4 R0.y, vertex.position, c[3];
MUL R0.x, vertex.texcoord[1].y, c[27];
MIN R0.x, R0, c[0].y;
MAD R2.xyz, -c[26], c[26].w, R2;
MUL R1.xyz, c[26], c[26].w;
MAD result.texcoord[3].xyz, R2, c[29].x, R1;
DP3 result.texcoord[4].z, vertex.normal, R3;
DP3 result.texcoord[4].x, R3, vertex.attrib[14];
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
MOV result.texcoord[2].z, -R0.y;
MOV result.texcoord[2].y, vertex.color.w;
MAX result.texcoord[2].x, R0, c[0];
END
# 52 instructions, 4 R-regs
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
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 8[_Object2World]
					Matrix 12[_World2Object]
					Vector 16[_WorldSpaceLightPos0]
					Vector 17[unity_SHAr]
					Vector 18[unity_SHAg]
					Vector 19[unity_SHAb]
					Vector 20[unity_SHBr]
					Vector 21[unity_SHBg]
					Vector 22[unity_SHBb]
					Vector 23[unity_SHC]
					Vector 24[unity_Scale]
					Vector 25[_tintColor]
					Float 26[_steepPower]
					Float 27[_saturation]
					Float 28[_contrast]
					"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c29, 0.29899999, 0.58700001, 0.11400000, 1.00000000
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dcl_color0 v5
mul r1.xyz, v2, c24.w
dp3 r2.w, r1, c9
dp3 r0.x, r1, c8
dp3 r0.z, r1, c10
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c29
dp4 r2.z, r0, c19
dp4 r2.y, r0, c18
dp4 r2.x, r0, c17
mul r0.y, r2.w, r2.w
dp4 r3.z, r1, c22
dp4 r3.y, r1, c21
dp4 r3.x, r1, c20
mad r0.x, r0, r0, -r0.y
mul r1.xyz, r0.x, c23
add r2.xyz, r2, r3
dp3 r1.w, v5, c29
mov r0.xyz, v1
add o6.xyz, r2, r1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r0, v1.w
add r1.xyz, v5, -r1.w
mov r0, c14
dp4 r4.z, c16, r0
mov r0, c13
dp4 r4.y, c16, r0
mad r3.xyz, r1, c27.x, r1.w
mov r1, c12
dp4 r4.x, c16, r1
dp3 o5.y, r4, r2
mov r0.z, v4.x
mov r0.xy, v3
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mad r2.xyz, -c25, c25.w, r3
mul r1.xyz, c25, c25.w
mov o1.xyz, r0
abs o2.xyz, r0
dp4 r0.x, v0, c2
mad o4.xyz, r2, c28.x, r1
dp3 o5.z, v2, r4
dp3 o5.x, r4, v1
dp4 o0.w, v0, c7
dp4 o0.z, v0, c6
dp4 o0.y, v0, c5
dp4 o0.x, v0, c4
mov o3.z, -r0.x
mov o3.y, v5.w
mul_sat o3.x, v4.y, c26
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
					Bind "tangent"
					TexCoord2
					ConstBuffer "$Globals"
					192
					Vector 48[_tintColor]
					Float 80[_steepPower]
					Float 176[_saturation]
					Float 180[_contrast]
					ConstBuffer "UnityLighting"
					720
					Vector 0[_WorldSpaceLightPos0]
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
					Matrix 256[_World2Object]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityLighting"
					1
					BindCB "UnityPerDraw"
					2 "vs_4_0
eefiecedpncdgpcjeihkoliklajfnddbdlecdgchabaaaaaabmajaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcfaahaaaaeaaaabaaneabaaaafjaaaaaeegiocaaaaaaaaaaa
amaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaa
fpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaa
agaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafdcaabaaaaaaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaa
aaaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaa
abaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadicaaaaibccabaaaadaaaaaa
bkbabaaaaeaaaaaaakiacaaaaaaaaaaaafaaaaaadgaaaaafcccabaaaadaaaaaa
dkbabaaaafaaaaaabaaaaaakbcaabaaaaaaaaaaaegbcbaaaafaaaaaaaceaaaaa
ihbgjjdokcefbgdpnfhiojdnaaaaaaaaaaaaaaaiocaabaaaaaaaaaaaagaabaia
ebaaaaaaaaaaaaaaagbjbaaaafaaaaaadcaaaaakhcaabaaaaaaaaaaaagiacaaa
aaaaaaaaalaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaadcaaaaamhcaabaaa
aaaaaaaaegiccaiaebaaaaaaaaaaaaaaadaaaaaapgipcaaaaaaaaaaaadaaaaaa
egacbaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaapgipcaaaaaaaaaaaadaaaaaa
egiccaaaaaaaaaaaadaaaaaadcaaaaakhccabaaaaeaaaaaafgifcaaaaaaaaaaa
alaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaa
jgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaa
acaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaa
fgifcaaaabaaaaaaaaaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaa
abaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
acaaaaaabdaaaaaapgipcaaaabaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
cccabaaaafaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
afaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaafaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaa
acaaaaaapgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaa
acaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaa
dgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaa
egiocaaaabaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaa
egiocaaaabaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaa
egiocaaaabaaaaaaciaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaa
jgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaa
abaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaa
abaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaa
abaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaadaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaadcaaaaakhccabaaaagaaaaaaegiccaaa
abaaaaaacmaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
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
					Bind "color"
					Color
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Vector 18[_tintColor]
					Float 19[_steepPower]
					Float 20[_saturation]
					Float 21[_contrast]
					Vector 22[unity_LightmapST]
					"3.0-!!ARBvp1.0
PARAM c[24] = { { 0, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..22],
		{ 0.29899999, 0.58700001, 0.114 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R1.z, vertex.texcoord[1].x;
MOV R1.xy, vertex.texcoord[0];
DP3 R0.x, R1, R1;
RSQ R0.w, R0.x;
MUL R1.xyz, R0.w, R1;
DP3 R1.w, vertex.color, c[23];
ADD R0.xyz, vertex.color, -R1.w;
MAD R2.xyz, R0, c[20].x, R1.w;
MUL R0.xyz, c[18], c[18].w;
MAD R2.xyz, -c[18], c[18].w, R2;
MAD result.texcoord[3].xyz, R2, c[21].x, R0;
DP4 R0.y, vertex.position, c[3];
MUL R0.x, vertex.texcoord[1].y, c[19];
MIN R0.x, R0, c[0].y;
MOV result.texcoord[0].xyz, R1;
ABS result.texcoord[1].xyz, R1;
MAD result.texcoord[4].xy, vertex.texcoord[1], c[22], c[22].zwzw;
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
MOV result.texcoord[2].z, -R0.y;
MOV result.texcoord[2].y, vertex.color.w;
MAX result.texcoord[2].x, R0, c[0];
END
# 24 instructions, 3 R-regs
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
					Bind "color"
					Color
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Vector 16[_tintColor]
					Float 17[_steepPower]
					Float 18[_saturation]
					Float 19[_contrast]
					Vector 20[unity_LightmapST]
					"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c21, 0.29899999, 0.58700001, 0.11400000, 0
dcl_position0 v0
dcl_texcoord0 v3
dcl_texcoord1 v4
dcl_color0 v5
mov r1.z, v4.x
mov r1.xy, v3
dp3 r0.x, r1, r1
rsq r0.w, r0.x
mul r1.xyz, r0.w, r1
dp3 r1.w, v5, c21
add r0.xyz, v5, -r1.w
mad r2.xyz, r0, c18.x, r1.w
mul r0.xyz, c16, c16.w
mad r2.xyz, -c16, c16.w, r2
mad o4.xyz, r2, c19.x, r0
dp4 r0.x, v0, c2
mov o1.xyz, r1
abs o2.xyz, r1
mad o5.xy, v4, c20, c20.zwzw
dp4 o0.w, v0, c7
dp4 o0.z, v0, c6
dp4 o0.y, v0, c5
dp4 o0.x, v0, c4
mov o3.z, -r0.x
mov o3.y, v5.w
mul_sat o3.x, v4.y, c17
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
					208
					Vector 48[_tintColor]
					Float 80[_steepPower]
					Float 176[_saturation]
					Float 180[_contrast]
					Vector 192[unity_LightmapST]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					BindCB "$Globals"
					0
					BindCB "UnityPerDraw"
					1 "vs_4_0
eefieceddpnlgdbllfccmjlilajgbcebojokiefdabaaaaaajiafaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcoeadaaaaeaaaabaapjaaaaaafjaaaaae
egiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaa
fpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaaddccabaaaafaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaa
aaaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaaaaaaaaa
dgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaabkbabaaaaaaaaaaackiacaaaabaaaaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaabaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaagaaaaaackbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaa
dkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaaakaabaia
ebaaaaaaaaaaaaaadicaaaaibccabaaaadaaaaaabkbabaaaaeaaaaaaakiacaaa
aaaaaaaaafaaaaaadgaaaaafcccabaaaadaaaaaadkbabaaaafaaaaaabaaaaaak
bcaabaaaaaaaaaaaegbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdn
aaaaaaaaaaaaaaaiocaabaaaaaaaaaaaagaabaiaebaaaaaaaaaaaaaaagbjbaaa
afaaaaaadcaaaaakhcaabaaaaaaaaaaaagiacaaaaaaaaaaaalaaaaaajgahbaaa
aaaaaaaaagaabaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaaegiccaiaebaaaaaa
aaaaaaaaadaaaaaapgipcaaaaaaaaaaaadaaaaaaegacbaaaaaaaaaaadiaaaaaj
hcaabaaaabaaaaaapgipcaaaaaaaaaaaadaaaaaaegiccaaaaaaaaaaaadaaaaaa
dcaaaaakhccabaaaaeaaaaaafgifcaaaaaaaaaaaalaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaaldccabaaaafaaaaaaegbabaaaaeaaaaaaegiacaaa
aaaaaaaaamaaaaaaogikcaaaaaaaaaaaamaaaaaadoaaaaab"
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
					Bind "color"
					Color
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Vector 18[_tintColor]
					Float 19[_steepPower]
					Float 20[_saturation]
					Float 21[_contrast]
					Vector 22[unity_LightmapST]
					"3.0-!!ARBvp1.0
PARAM c[24] = { { 0, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..22],
		{ 0.29899999, 0.58700001, 0.114 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R1.z, vertex.texcoord[1].x;
MOV R1.xy, vertex.texcoord[0];
DP3 R0.x, R1, R1;
RSQ R0.w, R0.x;
MUL R1.xyz, R0.w, R1;
DP3 R1.w, vertex.color, c[23];
ADD R0.xyz, vertex.color, -R1.w;
MAD R2.xyz, R0, c[20].x, R1.w;
MUL R0.xyz, c[18], c[18].w;
MAD R2.xyz, -c[18], c[18].w, R2;
MAD result.texcoord[3].xyz, R2, c[21].x, R0;
DP4 R0.y, vertex.position, c[3];
MUL R0.x, vertex.texcoord[1].y, c[19];
MIN R0.x, R0, c[0].y;
MOV result.texcoord[0].xyz, R1;
ABS result.texcoord[1].xyz, R1;
MAD result.texcoord[4].xy, vertex.texcoord[1], c[22], c[22].zwzw;
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
MOV result.texcoord[2].z, -R0.y;
MOV result.texcoord[2].y, vertex.color.w;
MAX result.texcoord[2].x, R0, c[0];
END
# 24 instructions, 3 R-regs
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
					Bind "color"
					Color
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Vector 16[_tintColor]
					Float 17[_steepPower]
					Float 18[_saturation]
					Float 19[_contrast]
					Vector 20[unity_LightmapST]
					"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c21, 0.29899999, 0.58700001, 0.11400000, 0
dcl_position0 v0
dcl_texcoord0 v3
dcl_texcoord1 v4
dcl_color0 v5
mov r1.z, v4.x
mov r1.xy, v3
dp3 r0.x, r1, r1
rsq r0.w, r0.x
mul r1.xyz, r0.w, r1
dp3 r1.w, v5, c21
add r0.xyz, v5, -r1.w
mad r2.xyz, r0, c18.x, r1.w
mul r0.xyz, c16, c16.w
mad r2.xyz, -c16, c16.w, r2
mad o4.xyz, r2, c19.x, r0
dp4 r0.x, v0, c2
mov o1.xyz, r1
abs o2.xyz, r1
mad o5.xy, v4, c20, c20.zwzw
dp4 o0.w, v0, c7
dp4 o0.z, v0, c6
dp4 o0.y, v0, c5
dp4 o0.x, v0, c4
mov o3.z, -r0.x
mov o3.y, v5.w
mul_sat o3.x, v4.y, c17
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
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					208
					Vector 48[_tintColor]
					Float 80[_steepPower]
					Float 176[_saturation]
					Float 180[_contrast]
					Vector 192[unity_LightmapST]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					BindCB "$Globals"
					0
					BindCB "UnityPerDraw"
					1 "vs_4_0
eefieceddpnlgdbllfccmjlilajgbcebojokiefdabaaaaaajiafaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcoeadaaaaeaaaabaapjaaaaaafjaaaaae
egiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaa
fpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaaddccabaaaafaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaa
aaaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaaaaaaaaa
dgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaabkbabaaaaaaaaaaackiacaaaabaaaaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaabaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaagaaaaaackbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaa
dkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaaakaabaia
ebaaaaaaaaaaaaaadicaaaaibccabaaaadaaaaaabkbabaaaaeaaaaaaakiacaaa
aaaaaaaaafaaaaaadgaaaaafcccabaaaadaaaaaadkbabaaaafaaaaaabaaaaaak
bcaabaaaaaaaaaaaegbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdn
aaaaaaaaaaaaaaaiocaabaaaaaaaaaaaagaabaiaebaaaaaaaaaaaaaaagbjbaaa
afaaaaaadcaaaaakhcaabaaaaaaaaaaaagiacaaaaaaaaaaaalaaaaaajgahbaaa
aaaaaaaaagaabaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaaegiccaiaebaaaaaa
aaaaaaaaadaaaaaapgipcaaaaaaaaaaaadaaaaaaegacbaaaaaaaaaaadiaaaaaj
hcaabaaaabaaaaaapgipcaaaaaaaaaaaadaaaaaaegiccaaaaaaaaaaaadaaaaaa
dcaaaaakhccabaaaaeaaaaaafgifcaaaaaaaaaaaalaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaaldccabaaaafaaaaaaegbabaaaaeaaaaaaegiacaaa
aaaaaaaaamaaaaaaogikcaaaaaaaaaaaamaaaaaadoaaaaab"
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
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Bind "tangent"
					ATTR14
					Matrix 9[_Object2World]
					Matrix 13[_World2Object]
					Vector 17[_ProjectionParams]
					Vector 18[_WorldSpaceLightPos0]
					Vector 19[unity_SHAr]
					Vector 20[unity_SHAg]
					Vector 21[unity_SHAb]
					Vector 22[unity_SHBr]
					Vector 23[unity_SHBg]
					Vector 24[unity_SHBb]
					Vector 25[unity_SHC]
					Vector 26[unity_Scale]
					Vector 27[_tintColor]
					Float 28[_steepPower]
					Float 29[_saturation]
					Float 30[_contrast]
					"3.0-!!ARBvp1.0
PARAM c[32] = { { 0, 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..30],
		{ 0.29899999, 0.58700001, 0.114 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[26].w;
DP3 R2.w, R1, c[10];
DP3 R0.x, R1, c[9];
DP3 R0.z, R1, c[11];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].y;
DP4 R2.z, R0, c[21];
DP4 R2.y, R0, c[20];
DP4 R2.x, R0, c[19];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[24];
DP4 R3.y, R1, c[23];
DP4 R3.x, R1, c[22];
MOV R1.xyz, vertex.attrib[14];
DP3 R0.w, vertex.color, c[31];
ADD R3.xyz, R2, R3;
MAD R0.x, R0, R0, -R0.y;
MUL R2.xyz, R0.x, c[25];
MUL R0.xyz, vertex.normal.zxyw, R1.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R1.zxyw, -R0;
MOV R1, c[18];
ADD result.texcoord[5].xyz, R3, R2;
DP4 R2.z, R1, c[15];
DP4 R2.y, R1, c[14];
DP4 R2.x, R1, c[13];
MUL R0.xyz, R0, vertex.attrib[14].w;
DP3 result.texcoord[4].y, R2, R0;
ADD R1.xyz, vertex.color, -R0.w;
MAD R1.xyz, R1, c[29].x, R0.w;
MUL R0.xyz, c[27], c[27].w;
MAD R1.xyz, -c[27], c[27].w, R1;
MAD result.texcoord[3].xyz, R1, c[30].x, R0;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].z;
MUL R1.y, R1, c[17].x;
DP3 result.texcoord[4].z, vertex.normal, R2;
DP3 result.texcoord[4].x, R2, vertex.attrib[14];
MOV R2.z, vertex.texcoord[1].x;
MOV R2.xy, vertex.texcoord[0];
DP3 R0.z, R2, R2;
ADD result.texcoord[6].xy, R1, R1.z;
RSQ R1.x, R0.z;
DP4 R0.z, vertex.position, c[7];
MUL R1.xyz, R1.x, R2;
MOV result.position, R0;
DP4 R0.y, vertex.position, c[3];
MUL R0.x, vertex.texcoord[1].y, c[28];
MIN R0.x, R0, c[0].y;
MOV result.texcoord[0].xyz, R1;
ABS result.texcoord[1].xyz, R1;
MOV result.texcoord[6].zw, R0;
MOV result.texcoord[2].z, -R0.y;
MOV result.texcoord[2].y, vertex.color.w;
MAX result.texcoord[2].x, R0, c[0];
END
# 57 instructions, 4 R-regs
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
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 8[_Object2World]
					Matrix 12[_World2Object]
					Vector 16[_ProjectionParams]
					Vector 17[_ScreenParams]
					Vector 18[_WorldSpaceLightPos0]
					Vector 19[unity_SHAr]
					Vector 20[unity_SHAg]
					Vector 21[unity_SHAb]
					Vector 22[unity_SHBr]
					Vector 23[unity_SHBg]
					Vector 24[unity_SHBb]
					Vector 25[unity_SHC]
					Vector 26[unity_Scale]
					Vector 27[_tintColor]
					Float 28[_steepPower]
					Float 29[_saturation]
					Float 30[_contrast]
					"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c31, 0.29899999, 0.58700001, 0.11400000, 1.00000000
def c32, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dcl_color0 v5
mul r1.xyz, v2, c26.w
dp3 r2.w, r1, c9
dp3 r0.x, r1, c8
dp3 r0.z, r1, c10
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c31
dp4 r2.z, r0, c21
dp4 r2.y, r0, c20
dp4 r2.x, r0, c19
mul r0.y, r2.w, r2.w
mad r0.w, r0.x, r0.x, -r0.y
dp4 r3.z, r1, c24
dp4 r3.y, r1, c23
dp4 r3.x, r1, c22
add r3.xyz, r2, r3
mul r2.xyz, r0.w, c25
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
add o6.xyz, r3, r2
mul r2.xyz, r0, v1.w
mov r0, c14
dp4 r0.z, c18, r0
mov r1, c13
dp4 r0.y, c18, r1
mov r1, c12
dp4 r0.x, c18, r1
dp3 r0.w, v5, c31
add r1.xyz, v5, -r0.w
dp3 o5.y, r0, r2
mad r2.xyz, r1, c29.x, r0.w
mul r1.xyz, c27, c27.w
mad r2.xyz, -c27, c27.w, r2
mad o4.xyz, r2, c30.x, r1
dp4 r1.w, v0, c7
dp4 r1.z, v0, c6
dp3 o5.z, v2, r0
dp3 o5.x, r0, v1
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r2.xyz, r1.xyww, c32.x
mul r2.y, r2, c16.x
mov r0.z, v4.x
mov r0.xy, v3
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov o1.xyz, r0
abs o2.xyz, r0
dp4 r0.x, v0, c2
mad o7.xy, r2.z, c17.zwzw, r2
mov o0, r1
mov o7.zw, r1
mov o3.z, -r0.x
mov o3.y, v5.w
mul_sat o3.x, v4.y, c28
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
					Bind "tangent"
					TexCoord2
					ConstBuffer "$Globals"
					256
					Vector 112[_tintColor]
					Float 144[_steepPower]
					Float 240[_saturation]
					Float 244[_contrast]
					ConstBuffer "UnityPerCamera"
					128
					Vector 80[_ProjectionParams]
					ConstBuffer "UnityLighting"
					720
					Vector 0[_WorldSpaceLightPos0]
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
					Matrix 256[_World2Object]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityLighting"
					2
					BindCB "UnityPerDraw"
					3 "vs_4_0
eefiecedppkoiobadoomfkhmdklipidkjagnoejgabaaaaaanmajaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
piahaaaaeaaaabaapoabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadhccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaagiaaaaacafaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaa
dgaaaaafecaabaaaabaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaacaaaaaa
egacbaiaibaaaaaaabaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaaaaaaaaa
ckiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaadaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaa
ckiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaak
bcaabaaaabaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
abaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaaabaaaaaadicaaaai
bccabaaaadaaaaaabkbabaaaaeaaaaaaakiacaaaaaaaaaaaajaaaaaadgaaaaaf
cccabaaaadaaaaaadkbabaaaafaaaaaabaaaaaakbcaabaaaabaaaaaaegbcbaaa
afaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaaaaaaaaaiocaabaaa
abaaaaaaagaabaiaebaaaaaaabaaaaaaagbjbaaaafaaaaaadcaaaaakhcaabaaa
abaaaaaaagiacaaaaaaaaaaaapaaaaaajgahbaaaabaaaaaaagaabaaaabaaaaaa
dcaaaaamhcaabaaaabaaaaaaegiccaiaebaaaaaaaaaaaaaaahaaaaaapgipcaaa
aaaaaaaaahaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaapgipcaaa
aaaaaaaaahaaaaaaegiccaaaaaaaaaaaahaaaaaadcaaaaakhccabaaaaeaaaaaa
fgifcaaaaaaaaaaaapaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaah
hcaabaaaabaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgbpbaaaabaaaaaadiaaaaaj
hcaabaaaacaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaa
dcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaa
aaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaa
bcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaa
acaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaa
acaaaaaabaaaaaahcccabaaaafaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
baaaaaahbccabaaaafaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaah
eccabaaaafaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadiaaaaaihcaabaaa
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
acaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahccaabaaaabaaaaaa
bkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaadcaaaaakhccabaaa
agaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaafmccabaaaahaaaaaakgaobaaaaaaaaaaaaaaaaaah
dccabaaaahaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab"
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
					Bind "color"
					Color
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Vector 17[_ProjectionParams]
					Vector 19[_tintColor]
					Float 20[_steepPower]
					Float 21[_saturation]
					Float 22[_contrast]
					Vector 23[unity_LightmapST]
					"3.0-!!ARBvp1.0
PARAM c[25] = { { 0, 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..23],
		{ 0.29899999, 0.58700001, 0.114 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
DP3 R0.w, vertex.color, c[24];
ADD R0.xyz, vertex.color, -R0.w;
MAD R3.xyz, R0, c[21].x, R0.w;
DP4 R1.w, vertex.position, c[8];
DP4 R1.z, vertex.position, c[7];
MUL R0.xyz, c[19], c[19].w;
MAD R3.xyz, -c[19], c[19].w, R3;
MAD result.texcoord[3].xyz, R3, c[22].x, R0;
DP4 R1.x, vertex.position, c[5];
DP4 R1.y, vertex.position, c[6];
MUL R2.xyz, R1.xyww, c[0].z;
MUL R2.y, R2, c[17].x;
MOV R0.z, vertex.texcoord[1].x;
MOV R0.xy, vertex.texcoord[0];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
MOV result.texcoord[0].xyz, R0;
ABS result.texcoord[1].xyz, R0;
DP4 R0.y, vertex.position, c[3];
MUL R0.x, vertex.texcoord[1].y, c[20];
MIN R0.x, R0, c[0].y;
ADD result.texcoord[5].xy, R2, R2.z;
MOV result.position, R1;
MOV result.texcoord[5].zw, R1;
MAD result.texcoord[4].xy, vertex.texcoord[1], c[23], c[23].zwzw;
MOV result.texcoord[2].z, -R0.y;
MOV result.texcoord[2].y, vertex.color.w;
MAX result.texcoord[2].x, R0, c[0];
END
# 29 instructions, 4 R-regs
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
					Bind "color"
					Color
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Vector 16[_ProjectionParams]
					Vector 17[_ScreenParams]
					Vector 18[_tintColor]
					Float 19[_steepPower]
					Float 20[_saturation]
					Float 21[_contrast]
					Vector 22[unity_LightmapST]
					"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c23, 0.29899999, 0.58700001, 0.11400000, 0.50000000
dcl_position0 v0
dcl_texcoord0 v3
dcl_texcoord1 v4
dcl_color0 v5
dp3 r0.w, v5, c23
add r0.xyz, v5, -r0.w
mad r3.xyz, r0, c20.x, r0.w
dp4 r1.w, v0, c7
dp4 r1.z, v0, c6
mul r0.xyz, c18, c18.w
mad r3.xyz, -c18, c18.w, r3
mad o4.xyz, r3, c21.x, r0
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r2.xyz, r1.xyww, c23.w
mul r2.y, r2, c16.x
mov r0.z, v4.x
mov r0.xy, v3
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov o1.xyz, r0
abs o2.xyz, r0
dp4 r0.x, v0, c2
mad o6.xy, r2.z, c17.zwzw, r2
mov o0, r1
mov o6.zw, r1
mad o5.xy, v4, c22, c22.zwzw
mov o3.z, -r0.x
mov o3.y, v5.w
mul_sat o3.x, v4.y, c19
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
					272
					Vector 112[_tintColor]
					Float 144[_steepPower]
					Float 240[_saturation]
					Float 244[_contrast]
					Vector 256[unity_LightmapST]
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
eefiecedofcnjihaohhdokhnbnpkcombdmlkojdcabaaaaaafiagaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaadamaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcimaeaaaaeaaaabaacdabaaaafjaaaaaeegiocaaaaaaaaaaa
bbaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaaddccabaaaafaaaaaa
gfaaaaadpccabaaaagaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaabaaaaaa
akbabaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaabaaaaaa
egacbaaaabaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaabaaaaaa
diaaaaaibcaabaaaabaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaa
dcaaaaakbcaabaaaabaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaa
akaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaacaaaaaaagaaaaaa
ckbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaa
acaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaabaaaaaadgaaaaageccabaaa
adaaaaaaakaabaiaebaaaaaaabaaaaaadicaaaaibccabaaaadaaaaaabkbabaaa
aeaaaaaaakiacaaaaaaaaaaaajaaaaaadgaaaaafcccabaaaadaaaaaadkbabaaa
afaaaaaabaaaaaakbcaabaaaabaaaaaaegbcbaaaafaaaaaaaceaaaaaihbgjjdo
kcefbgdpnfhiojdnaaaaaaaaaaaaaaaiocaabaaaabaaaaaaagaabaiaebaaaaaa
abaaaaaaagbjbaaaafaaaaaadcaaaaakhcaabaaaabaaaaaaagiacaaaaaaaaaaa
apaaaaaajgahbaaaabaaaaaaagaabaaaabaaaaaadcaaaaamhcaabaaaabaaaaaa
egiccaiaebaaaaaaaaaaaaaaahaaaaaapgipcaaaaaaaaaaaahaaaaaaegacbaaa
abaaaaaadiaaaaajhcaabaaaacaaaaaapgipcaaaaaaaaaaaahaaaaaaegiccaaa
aaaaaaaaahaaaaaadcaaaaakhccabaaaaeaaaaaafgifcaaaaaaaaaaaapaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadcaaaaaldccabaaaafaaaaaaegbabaaa
aeaaaaaaegiacaaaaaaaaaaabaaaaaaaogikcaaaaaaaaaaabaaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaafmccabaaaagaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaa
agaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab"
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
					Bind "color"
					Color
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Vector 17[_ProjectionParams]
					Vector 19[_tintColor]
					Float 20[_steepPower]
					Float 21[_saturation]
					Float 22[_contrast]
					Vector 23[unity_LightmapST]
					"3.0-!!ARBvp1.0
PARAM c[25] = { { 0, 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..23],
		{ 0.29899999, 0.58700001, 0.114 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
DP3 R0.w, vertex.color, c[24];
ADD R0.xyz, vertex.color, -R0.w;
MAD R3.xyz, R0, c[21].x, R0.w;
DP4 R1.w, vertex.position, c[8];
DP4 R1.z, vertex.position, c[7];
MUL R0.xyz, c[19], c[19].w;
MAD R3.xyz, -c[19], c[19].w, R3;
MAD result.texcoord[3].xyz, R3, c[22].x, R0;
DP4 R1.x, vertex.position, c[5];
DP4 R1.y, vertex.position, c[6];
MUL R2.xyz, R1.xyww, c[0].z;
MUL R2.y, R2, c[17].x;
MOV R0.z, vertex.texcoord[1].x;
MOV R0.xy, vertex.texcoord[0];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
MOV result.texcoord[0].xyz, R0;
ABS result.texcoord[1].xyz, R0;
DP4 R0.y, vertex.position, c[3];
MUL R0.x, vertex.texcoord[1].y, c[20];
MIN R0.x, R0, c[0].y;
ADD result.texcoord[5].xy, R2, R2.z;
MOV result.position, R1;
MOV result.texcoord[5].zw, R1;
MAD result.texcoord[4].xy, vertex.texcoord[1], c[23], c[23].zwzw;
MOV result.texcoord[2].z, -R0.y;
MOV result.texcoord[2].y, vertex.color.w;
MAX result.texcoord[2].x, R0, c[0];
END
# 29 instructions, 4 R-regs
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
					Bind "color"
					Color
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Vector 16[_ProjectionParams]
					Vector 17[_ScreenParams]
					Vector 18[_tintColor]
					Float 19[_steepPower]
					Float 20[_saturation]
					Float 21[_contrast]
					Vector 22[unity_LightmapST]
					"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c23, 0.29899999, 0.58700001, 0.11400000, 0.50000000
dcl_position0 v0
dcl_texcoord0 v3
dcl_texcoord1 v4
dcl_color0 v5
dp3 r0.w, v5, c23
add r0.xyz, v5, -r0.w
mad r3.xyz, r0, c20.x, r0.w
dp4 r1.w, v0, c7
dp4 r1.z, v0, c6
mul r0.xyz, c18, c18.w
mad r3.xyz, -c18, c18.w, r3
mad o4.xyz, r3, c21.x, r0
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r2.xyz, r1.xyww, c23.w
mul r2.y, r2, c16.x
mov r0.z, v4.x
mov r0.xy, v3
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov o1.xyz, r0
abs o2.xyz, r0
dp4 r0.x, v0, c2
mad o6.xy, r2.z, c17.zwzw, r2
mov o0, r1
mov o6.zw, r1
mad o5.xy, v4, c22, c22.zwzw
mov o3.z, -r0.x
mov o3.y, v5.w
mul_sat o3.x, v4.y, c19
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
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					272
					Vector 112[_tintColor]
					Float 144[_steepPower]
					Float 240[_saturation]
					Float 244[_contrast]
					Vector 256[unity_LightmapST]
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
eefiecedofcnjihaohhdokhnbnpkcombdmlkojdcabaaaaaafiagaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaadamaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcimaeaaaaeaaaabaacdabaaaafjaaaaaeegiocaaaaaaaaaaa
bbaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaaddccabaaaafaaaaaa
gfaaaaadpccabaaaagaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaabaaaaaa
akbabaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaabaaaaaa
egacbaaaabaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaabaaaaaa
diaaaaaibcaabaaaabaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaa
dcaaaaakbcaabaaaabaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaa
akaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaacaaaaaaagaaaaaa
ckbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaa
acaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaabaaaaaadgaaaaageccabaaa
adaaaaaaakaabaiaebaaaaaaabaaaaaadicaaaaibccabaaaadaaaaaabkbabaaa
aeaaaaaaakiacaaaaaaaaaaaajaaaaaadgaaaaafcccabaaaadaaaaaadkbabaaa
afaaaaaabaaaaaakbcaabaaaabaaaaaaegbcbaaaafaaaaaaaceaaaaaihbgjjdo
kcefbgdpnfhiojdnaaaaaaaaaaaaaaaiocaabaaaabaaaaaaagaabaiaebaaaaaa
abaaaaaaagbjbaaaafaaaaaadcaaaaakhcaabaaaabaaaaaaagiacaaaaaaaaaaa
apaaaaaajgahbaaaabaaaaaaagaabaaaabaaaaaadcaaaaamhcaabaaaabaaaaaa
egiccaiaebaaaaaaaaaaaaaaahaaaaaapgipcaaaaaaaaaaaahaaaaaaegacbaaa
abaaaaaadiaaaaajhcaabaaaacaaaaaapgipcaaaaaaaaaaaahaaaaaaegiccaaa
aaaaaaaaahaaaaaadcaaaaakhccabaaaaeaaaaaafgifcaaaaaaaaaaaapaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadcaaaaaldccabaaaafaaaaaaegbabaaa
aeaaaaaaegiacaaaaaaaaaaabaaaaaaaogikcaaaaaaaaaaabaaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaafmccabaaaagaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaa
agaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab"
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
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Bind "tangent"
					ATTR14
					Matrix 9[_Object2World]
					Matrix 13[_World2Object]
					Vector 17[_WorldSpaceLightPos0]
					Vector 18[unity_4LightPosX0]
					Vector 19[unity_4LightPosY0]
					Vector 20[unity_4LightPosZ0]
					Vector 21[unity_4LightAtten0]
					Vector 22[unity_LightColor0]
					Vector 23[unity_LightColor1]
					Vector 24[unity_LightColor2]
					Vector 25[unity_LightColor3]
					Vector 26[unity_SHAr]
					Vector 27[unity_SHAg]
					Vector 28[unity_SHAb]
					Vector 29[unity_SHBr]
					Vector 30[unity_SHBg]
					Vector 31[unity_SHBb]
					Vector 32[unity_SHC]
					Vector 33[unity_Scale]
					Vector 34[_tintColor]
					Float 35[_steepPower]
					Float 36[_saturation]
					Float 37[_contrast]
					"3.0-!!ARBvp1.0
PARAM c[39] = { { 1, 0 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..37],
		{ 0.29899999, 0.58700001, 0.114 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[33].w;
DP4 R0.x, vertex.position, c[10];
ADD R1, -R0.x, c[19];
DP3 R3.w, R3, c[10];
DP3 R4.x, R3, c[9];
DP3 R3.x, R3, c[11];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[9];
ADD R0, -R0.x, c[18];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MAD R2, R4.x, R0, R2;
MOV R4.w, c[0].x;
DP4 R4.y, vertex.position, c[11];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[20];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[21];
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
MUL R1.xyz, R0.y, c[23];
MAD R1.xyz, R0.x, c[22], R1;
MAD R0.xyz, R0.z, c[24], R1;
MAD R1.xyz, R0.w, c[25], R0;
MUL R0, R4.xyzz, R4.yzzx;
DP4 R3.z, R0, c[31];
DP4 R3.y, R0, c[30];
DP4 R3.x, R0, c[29];
MUL R1.w, R3, R3;
MAD R0.x, R4, R4, -R1.w;
DP3 R0.w, vertex.color, c[38];
DP4 R2.z, R4, c[28];
DP4 R2.y, R4, c[27];
DP4 R2.x, R4, c[26];
ADD R2.xyz, R2, R3;
MUL R3.xyz, R0.x, c[32];
ADD R3.xyz, R2, R3;
ADD result.texcoord[5].xyz, R3, R1;
MOV R1, c[17];
MOV R0.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
MUL R2.xyz, R0, vertex.attrib[14].w;
ADD R0.xyz, vertex.color, -R0.w;
MAD R0.xyz, R0, c[36].x, R0.w;
DP4 R3.z, R1, c[15];
DP4 R3.y, R1, c[14];
DP4 R3.x, R1, c[13];
MAD R1.xyz, -c[34], c[34].w, R0;
DP3 result.texcoord[4].y, R3, R2;
MUL R2.xyz, c[34], c[34].w;
MOV R0.z, vertex.texcoord[1].x;
MOV R0.xy, vertex.texcoord[0];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
MOV result.texcoord[0].xyz, R0;
ABS result.texcoord[1].xyz, R0;
DP4 R0.x, vertex.position, c[3];
MUL R0.y, vertex.texcoord[1], c[35].x;
MOV result.texcoord[2].z, -R0.x;
MIN R0.x, R0.y, c[0];
MAD result.texcoord[3].xyz, R1, c[37].x, R2;
DP3 result.texcoord[4].z, vertex.normal, R3;
DP3 result.texcoord[4].x, R3, vertex.attrib[14];
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
MOV result.texcoord[2].y, vertex.color.w;
MAX result.texcoord[2].x, R0, c[0].y;
END
# 83 instructions, 5 R-regs
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
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 8[_Object2World]
					Matrix 12[_World2Object]
					Vector 16[_WorldSpaceLightPos0]
					Vector 17[unity_4LightPosX0]
					Vector 18[unity_4LightPosY0]
					Vector 19[unity_4LightPosZ0]
					Vector 20[unity_4LightAtten0]
					Vector 21[unity_LightColor0]
					Vector 22[unity_LightColor1]
					Vector 23[unity_LightColor2]
					Vector 24[unity_LightColor3]
					Vector 25[unity_SHAr]
					Vector 26[unity_SHAg]
					Vector 27[unity_SHAb]
					Vector 28[unity_SHBr]
					Vector 29[unity_SHBg]
					Vector 30[unity_SHBb]
					Vector 31[unity_SHC]
					Vector 32[unity_Scale]
					Vector 33[_tintColor]
					Float 34[_steepPower]
					Float 35[_saturation]
					Float 36[_contrast]
					"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c37, 0.29899999, 0.58700001, 0.11400000, 1.00000000
def c38, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dcl_color0 v5
mul r3.xyz, v2, c32.w
dp4 r0.x, v0, c9
add r1, -r0.x, c18
dp3 r3.w, r3, c9
dp3 r4.x, r3, c8
dp3 r3.x, r3, c10
mul r2, r3.w, r1
dp4 r0.x, v0, c8
add r0, -r0.x, c17
mul r1, r1, r1
mov r4.z, r3.x
mad r2, r4.x, r0, r2
mov r4.w, c37
dp4 r4.y, v0, c10
mad r1, r0, r0, r1
add r0, -r4.y, c19
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c20
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c37.w
dp4 r2.z, r4, c27
dp4 r2.y, r4, c26
dp4 r2.x, r4, c25
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c38.x
mul r0, r0, r1
mul r1.xyz, r0.y, c22
mad r1.xyz, r0.x, c21, r1
mad r0.xyz, r0.z, c23, r1
mad r1.xyz, r0.w, c24, r0
mul r0, r4.xyzz, r4.yzzx
mul r1.w, r3, r3
dp4 r3.z, r0, c30
dp4 r3.y, r0, c29
dp4 r3.x, r0, c28
mad r1.w, r4.x, r4.x, -r1
mul r0.xyz, r1.w, c31
add r2.xyz, r2, r3
add r2.xyz, r2, r0
dp3 r1.w, v5, c37
mov r0.xyz, v1
add o6.xyz, r2, r1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
add r1.xyz, v5, -r1.w
mad r2.xyz, r1, c35.x, r1.w
mov r0, c14
dp4 r4.z, c16, r0
mov r0, c13
dp4 r4.y, c16, r0
mov r1, c12
dp4 r4.x, c16, r1
mad r1.xyz, -c33, c33.w, r2
mul r2.xyz, c33, c33.w
mov r0.z, v4.x
mov r0.xy, v3
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov o1.xyz, r0
abs o2.xyz, r0
dp4 r0.x, v0, c2
dp3 o5.y, r4, r3
mad o4.xyz, r1, c36.x, r2
dp3 o5.z, v2, r4
dp3 o5.x, r4, v1
dp4 o0.w, v0, c7
dp4 o0.z, v0, c6
dp4 o0.y, v0, c5
dp4 o0.x, v0, c4
mov o3.z, -r0.x
mov o3.y, v5.w
mul_sat o3.x, v4.y, c34
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
					Bind "tangent"
					TexCoord2
					ConstBuffer "$Globals"
					192
					Vector 48[_tintColor]
					Float 80[_steepPower]
					Float 176[_saturation]
					Float 180[_contrast]
					ConstBuffer "UnityLighting"
					720
					Vector 0[_WorldSpaceLightPos0]
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
					Matrix 256[_World2Object]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityLighting"
					1
					BindCB "UnityPerDraw"
					2 "vs_4_0
eefieceddmagolelijhpekfmgidfibgpoabhjociabaaaaaagmamaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefckaakaaaaeaaaabaakiacaaaafjaaaaaeegiocaaaaaaaaaaa
amaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaa
fpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaa
agaaaaaagiaaaaacagaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafdcaabaaaaaaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaa
aaaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaa
abaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadicaaaaibccabaaaadaaaaaa
bkbabaaaaeaaaaaaakiacaaaaaaaaaaaafaaaaaadgaaaaafcccabaaaadaaaaaa
dkbabaaaafaaaaaabaaaaaakbcaabaaaaaaaaaaaegbcbaaaafaaaaaaaceaaaaa
ihbgjjdokcefbgdpnfhiojdnaaaaaaaaaaaaaaaiocaabaaaaaaaaaaaagaabaia
ebaaaaaaaaaaaaaaagbjbaaaafaaaaaadcaaaaakhcaabaaaaaaaaaaaagiacaaa
aaaaaaaaalaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaadcaaaaamhcaabaaa
aaaaaaaaegiccaiaebaaaaaaaaaaaaaaadaaaaaapgipcaaaaaaaaaaaadaaaaaa
egacbaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaapgipcaaaaaaaaaaaadaaaaaa
egiccaaaaaaaaaaaadaaaaaadcaaaaakhccabaaaaeaaaaaafgifcaaaaaaaaaaa
alaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaa
jgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaa
acaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaa
fgifcaaaabaaaaaaaaaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaa
abaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
acaaaaaabdaaaaaapgipcaaaabaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
cccabaaaafaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
afaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaafaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaaihcaabaaaabaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaa
beaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaaklcaabaaaabaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaa
abaaaaaaegaibaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
aoaaaaaakgakbaaaabaaaaaaegadbaaaabaaaaaabbaaaaaibcaabaaaabaaaaaa
egiocaaaabaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaa
egiocaaaabaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaa
egiocaaaabaaaaaaciaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaa
jgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaa
abaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaa
abaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaa
abaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaadaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
abaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaa
acaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaajpcaabaaaadaaaaaafgafbaia
ebaaaaaaacaaaaaaegiocaaaabaaaaaaadaaaaaadiaaaaahpcaabaaaaeaaaaaa
fgafbaaaaaaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaa
adaaaaaaegaobaaaadaaaaaaaaaaaaajpcaabaaaafaaaaaaagaabaiaebaaaaaa
acaaaaaaegiocaaaabaaaaaaacaaaaaaaaaaaaajpcaabaaaacaaaaaakgakbaia
ebaaaaaaacaaaaaaegiocaaaabaaaaaaaeaaaaaadcaaaaajpcaabaaaaeaaaaaa
egaobaaaafaaaaaaagaabaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaa
aaaaaaaaegaobaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaaj
pcaabaaaadaaaaaaegaobaaaafaaaaaaegaobaaaafaaaaaaegaobaaaadaaaaaa
dcaaaaajpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
adaaaaaaeeaaaaafpcaabaaaadaaaaaaegaobaaaacaaaaaadcaaaaanpcaabaaa
acaaaaaaegaobaaaacaaaaaaegiocaaaabaaaaaaafaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaacaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpegaobaaaacaaaaaadiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaadaaaaaadeaaaaakpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaa
aaaaaaaaegaobaaaacaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaa
fgafbaaaaaaaaaaaegiccaaaabaaaaaaahaaaaaadcaaaaakhcaabaaaacaaaaaa
egiccaaaabaaaaaaagaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaaiaaaaaakgakbaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaajaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaahhccabaaaagaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadoaaaaab"
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
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Bind "tangent"
					ATTR14
					Matrix 9[_Object2World]
					Matrix 13[_World2Object]
					Vector 17[_ProjectionParams]
					Vector 18[_WorldSpaceLightPos0]
					Vector 19[unity_4LightPosX0]
					Vector 20[unity_4LightPosY0]
					Vector 21[unity_4LightPosZ0]
					Vector 22[unity_4LightAtten0]
					Vector 23[unity_LightColor0]
					Vector 24[unity_LightColor1]
					Vector 25[unity_LightColor2]
					Vector 26[unity_LightColor3]
					Vector 27[unity_SHAr]
					Vector 28[unity_SHAg]
					Vector 29[unity_SHAb]
					Vector 30[unity_SHBr]
					Vector 31[unity_SHBg]
					Vector 32[unity_SHBb]
					Vector 33[unity_SHC]
					Vector 34[unity_Scale]
					Vector 35[_tintColor]
					Float 36[_steepPower]
					Float 37[_saturation]
					Float 38[_contrast]
					"3.0-!!ARBvp1.0
PARAM c[40] = { { 1, 0, 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..38],
		{ 0.29899999, 0.58700001, 0.114 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[34].w;
DP4 R0.x, vertex.position, c[10];
ADD R1, -R0.x, c[20];
DP3 R3.w, R3, c[10];
DP3 R4.x, R3, c[9];
DP3 R3.x, R3, c[11];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[9];
ADD R0, -R0.x, c[19];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MAD R2, R4.x, R0, R2;
MOV R4.w, c[0].x;
DP4 R4.y, vertex.position, c[11];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[21];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[22];
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
MUL R1.xyz, R0.y, c[24];
MAD R1.xyz, R0.x, c[23], R1;
MAD R0.xyz, R0.z, c[25], R1;
MAD R1.xyz, R0.w, c[26], R0;
MUL R0, R4.xyzz, R4.yzzx;
DP4 R3.z, R0, c[32];
DP4 R3.y, R0, c[31];
DP4 R3.x, R0, c[30];
MUL R1.w, R3, R3;
MAD R0.x, R4, R4, -R1.w;
DP3 R1.w, vertex.color, c[39];
DP4 R2.z, R4, c[29];
DP4 R2.y, R4, c[28];
DP4 R2.x, R4, c[27];
ADD R2.xyz, R2, R3;
MUL R3.xyz, R0.x, c[33];
ADD R3.xyz, R2, R3;
MOV R0.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
ADD result.texcoord[5].xyz, R3, R1;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
MOV R0, c[18];
DP4 R2.z, R0, c[15];
DP4 R2.y, R0, c[14];
DP4 R2.x, R0, c[13];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP3 result.texcoord[4].y, R2, R1;
ADD R0.xyz, vertex.color, -R1.w;
MAD R1.xyz, R0, c[37].x, R1.w;
MUL R0.xyz, c[35], c[35].w;
MAD R1.xyz, -c[35], c[35].w, R1;
MAD result.texcoord[3].xyz, R1, c[38].x, R0;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].z;
MUL R1.y, R1, c[17].x;
DP3 result.texcoord[4].z, vertex.normal, R2;
DP3 result.texcoord[4].x, R2, vertex.attrib[14];
MOV R2.z, vertex.texcoord[1].x;
MOV R2.xy, vertex.texcoord[0];
DP3 R0.z, R2, R2;
ADD result.texcoord[6].xy, R1, R1.z;
RSQ R1.x, R0.z;
DP4 R0.z, vertex.position, c[7];
MUL R1.xyz, R1.x, R2;
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
MUL R0.y, vertex.texcoord[1], c[36].x;
MOV result.texcoord[2].z, -R0.x;
MIN R0.x, R0.y, c[0];
MOV result.texcoord[0].xyz, R1;
ABS result.texcoord[1].xyz, R1;
MOV result.texcoord[6].zw, R0;
MOV result.texcoord[2].y, vertex.color.w;
MAX result.texcoord[2].x, R0, c[0].y;
END
# 88 instructions, 5 R-regs
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
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 8[_Object2World]
					Matrix 12[_World2Object]
					Vector 16[_ProjectionParams]
					Vector 17[_ScreenParams]
					Vector 18[_WorldSpaceLightPos0]
					Vector 19[unity_4LightPosX0]
					Vector 20[unity_4LightPosY0]
					Vector 21[unity_4LightPosZ0]
					Vector 22[unity_4LightAtten0]
					Vector 23[unity_LightColor0]
					Vector 24[unity_LightColor1]
					Vector 25[unity_LightColor2]
					Vector 26[unity_LightColor3]
					Vector 27[unity_SHAr]
					Vector 28[unity_SHAg]
					Vector 29[unity_SHAb]
					Vector 30[unity_SHBr]
					Vector 31[unity_SHBg]
					Vector 32[unity_SHBb]
					Vector 33[unity_SHC]
					Vector 34[unity_Scale]
					Vector 35[_tintColor]
					Float 36[_steepPower]
					Float 37[_saturation]
					Float 38[_contrast]
					"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c39, 0.29899999, 0.58700001, 0.11400000, 1.00000000
def c40, 0.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dcl_color0 v5
mul r3.xyz, v2, c34.w
dp4 r0.x, v0, c9
add r1, -r0.x, c20
dp3 r3.w, r3, c9
dp3 r4.x, r3, c8
dp3 r3.x, r3, c10
mul r2, r3.w, r1
dp4 r0.x, v0, c8
add r0, -r0.x, c19
mul r1, r1, r1
mov r4.z, r3.x
mad r2, r4.x, r0, r2
mov r4.w, c39
dp4 r4.y, v0, c10
mad r1, r0, r0, r1
add r0, -r4.y, c21
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c22
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c39.w
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c40.x
mul r0, r0, r1
mul r1.xyz, r0.y, c24
mad r1.xyz, r0.x, c23, r1
mad r0.xyz, r0.z, c25, r1
mad r1.xyz, r0.w, c26, r0
mul r0, r4.xyzz, r4.yzzx
dp4 r3.z, r0, c32
dp4 r3.y, r0, c31
dp4 r3.x, r0, c30
mul r1.w, r3, r3
mad r0.x, r4, r4, -r1.w
dp4 r2.z, r4, c29
dp4 r2.y, r4, c28
dp4 r2.x, r4, c27
add r2.xyz, r2, r3
mul r3.xyz, r0.x, c33
add r3.xyz, r2, r3
mov r0.xyz, v1
mul r2.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r2
mul r2.xyz, r0, v1.w
add o6.xyz, r3, r1
mov r1, c14
dp4 r1.z, c18, r1
mov r0, c13
dp4 r1.y, c18, r0
mov r0, c12
dp4 r1.x, c18, r0
dp3 r1.w, v5, c39
add r0.xyz, v5, -r1.w
dp3 o5.y, r1, r2
mad r2.xyz, r0, c37.x, r1.w
mul r0.xyz, c35, c35.w
mad r2.xyz, -c35, c35.w, r2
mad o4.xyz, r2, c38.x, r0
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r2.xyz, r0.xyww, c40.y
mul r2.y, r2, c16.x
dp3 o5.z, v2, r1
dp3 o5.x, r1, v1
mov r1.z, v4.x
mov r1.xy, v3
dp3 r0.z, r1, r1
rsq r1.w, r0.z
dp4 r0.z, v0, c6
mul r1.xyz, r1.w, r1
mov o0, r0
dp4 r0.x, v0, c2
mad o7.xy, r2.z, c17.zwzw, r2
mov o1.xyz, r1
abs o2.xyz, r1
mov o7.zw, r0
mov o3.z, -r0.x
mov o3.y, v5.w
mul_sat o3.x, v4.y, c36
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
					Bind "tangent"
					TexCoord2
					ConstBuffer "$Globals"
					256
					Vector 112[_tintColor]
					Float 144[_steepPower]
					Float 240[_saturation]
					Float 244[_contrast]
					ConstBuffer "UnityPerCamera"
					128
					Vector 80[_ProjectionParams]
					ConstBuffer "UnityLighting"
					720
					Vector 0[_WorldSpaceLightPos0]
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
					Matrix 256[_World2Object]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityPerCamera"
					1
					BindCB "UnityLighting"
					2
					BindCB "UnityPerDraw"
					3 "vs_4_0
eefiecedmkdfepnhimpajhfhhbkccahpfidfenlbabaaaaaacmanaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
eialaaaaeaaaabaancacaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadhccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaagiaaaaacahaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaa
dgaaaaafecaabaaaabaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaacaaaaaa
egacbaiaibaaaaaaabaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaaaaaaaaa
ckiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaadaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaa
ckiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaak
bcaabaaaabaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
abaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaaabaaaaaadicaaaai
bccabaaaadaaaaaabkbabaaaaeaaaaaaakiacaaaaaaaaaaaajaaaaaadgaaaaaf
cccabaaaadaaaaaadkbabaaaafaaaaaabaaaaaakbcaabaaaabaaaaaaegbcbaaa
afaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaaaaaaaaaiocaabaaa
abaaaaaaagaabaiaebaaaaaaabaaaaaaagbjbaaaafaaaaaadcaaaaakhcaabaaa
abaaaaaaagiacaaaaaaaaaaaapaaaaaajgahbaaaabaaaaaaagaabaaaabaaaaaa
dcaaaaamhcaabaaaabaaaaaaegiccaiaebaaaaaaaaaaaaaaahaaaaaapgipcaaa
aaaaaaaaahaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaapgipcaaa
aaaaaaaaahaaaaaaegiccaaaaaaaaaaaahaaaaaadcaaaaakhccabaaaaeaaaaaa
fgifcaaaaaaaaaaaapaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaah
hcaabaaaabaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgbpbaaaabaaaaaadiaaaaaj
hcaabaaaacaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaa
dcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaa
aaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaa
bcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaa
acaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaa
acaaaaaabaaaaaahcccabaaaafaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
baaaaaahbccabaaaafaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaah
eccabaaaafaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadgaaaaaficaabaaa
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
acaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaaabaaaaaa
bkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakicaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaa
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
ajaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaahhccabaaaagaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
ahaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaahaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadoaaaaab"
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
					Vector 0[_LightColor0]
					Float 1[_texTiling]
					Float 2[_texPower]
					Float 3[_groundTexStart]
					Float 4[_groundTexEnd]
					Float 5[_steepTiling]
					Float 6[_steepTexStart]
					Float 7[_steepTexEnd]
					Float 8[_multiPower]
					Float 9[_deepMultiFactor]
					Float 10[_mainMultiFactor]
					Float 11[_highMultiFactor]
					Float 12[_snowMultiFactor]
					Float 13[_deepStart]
					Float 14[_deepEnd]
					Float 15[_mainLoStart]
					Float 16[_mainLoEnd]
					Float 17[_mainHiStart]
					Float 18[_mainHiEnd]
					Float 19[_hiLoStart]
					Float 20[_hiLoEnd]
					Float 21[_hiHiStart]
					Float 22[_hiHiEnd]
					Float 23[_snowStart]
					Float 24[_snowEnd]
					Float 25[_PlanetOpacity]
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 1
					SetTexture 2[_highTex] 2D 2
					SetTexture 3[_snowTex] 2D 3
					SetTexture 4[_deepMultiTex] 2D 4
					SetTexture 5[_mainMultiTex] 2D 5
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8 "3.0-!!ARBfp1.0
PARAM c[27] = { program.local[0..25],
		{ 0, 2, 3, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.x, c[3];
ADD R0.x, -R0, c[4];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].z, -c[3];
MUL_SAT R0.w, R0.x, R0.y;
MUL R3.xyz, fragment.texcoord[0], c[1].x;
MAD R1.x, -R0.w, c[26].y, c[26].z;
MUL R0.w, R0, R0;
MOV R2.w, c[13].x;
ADD R2.w, -R2, c[14].x;
RCP R4.x, R2.w;
ADD R2.w, fragment.texcoord[2].y, -c[13].x;
MUL_SAT R2.w, R2, R4.x;
TEX R0.xyz, R3.zyzw, texture[1], 2D;
MUL R0.w, R0, R1.x;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[1], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R0, R1;
ADD R0.x, -R0.w, c[26].w;
MOV R0.z, c[17].x;
ADD R0.z, -R0, c[18].x;
RCP R1.w, R0.z;
ADD R0.z, fragment.texcoord[2].y, -c[17].x;
MUL_SAT R1.w, R0.z, R1;
MOV R0.y, c[15].x;
ADD R0.y, -R0, c[16].x;
RCP R0.z, R0.y;
ADD R0.y, fragment.texcoord[2], -c[15].x;
MUL_SAT R0.y, R0, R0.z;
MUL R0.w, R0, c[8].x;
MAD R2.x, -R1.w, c[26].y, c[26].z;
MUL R0.z, R1.w, R1.w;
MUL R1.w, R0.z, R2.x;
MUL R0.z, R0.y, R0.y;
MAD R0.y, -R0, c[26], c[26].z;
MAD R3.w, R0.z, R0.y, -R1;
MUL R1.w, R0.x, c[2].x;
MUL R2.x, R1.w, R3.w;
TEX R0.xyz, R3.zxzw, texture[1], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R0, R1;
MUL R1.xyz, R0, R2.x;
TEX R2.xyz, R3.zyzw, texture[0], 2D;
TEX R0.xyz, R3, texture[0], 2D;
MUL R2.xyz, fragment.texcoord[1].x, R2;
MAD R2.xyz, fragment.texcoord[1].z, R0, R2;
MAD R0.y, -R2.w, c[26], c[26].z;
MUL R0.x, R2.w, R2.w;
MAD R4.x, -R0, R0.y, c[26].w;
TEX R0.xyz, R3.zxzw, texture[0], 2D;
MUL R2.w, R1, R4.x;
MAD R2.xyz, fragment.texcoord[1].y, R0, R2;
TEX R0.xyz, R3.zyzw, texture[2], 2D;
MAD R2.xyz, R2, R2.w, R1;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[2], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R0, R1;
MOV R0.y, c[21].x;
ADD R0.y, -R0, c[22].x;
RCP R0.z, R0.y;
ADD R0.y, fragment.texcoord[2], -c[21].x;
MUL_SAT R0.z, R0.y, R0;
MOV R0.x, c[19];
ADD R0.x, -R0, c[20];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].y, -c[19];
MUL_SAT R0.x, R0, R0.y;
MAD R2.w, -R0.z, c[26].y, c[26].z;
MUL R0.y, R0.z, R0.z;
MUL R0.z, R0.y, R2.w;
MUL R0.y, R0.x, R0.x;
MAD R0.x, -R0, c[26].y, c[26].z;
MAD R2.w, R0.y, R0.x, -R0.z;
TEX R0.xyz, R3.zxzw, texture[2], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R0, R1;
MUL R1.x, R1.w, R2.w;
MAD R2.xyz, R0, R1.x, R2;
TEX R1.xyz, R3.zyzw, texture[3], 2D;
TEX R0.xyz, R3, texture[3], 2D;
MUL R1.xyz, fragment.texcoord[1].x, R1;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[3], 2D;
MOV R3.y, c[23].x;
ADD R3.y, -R3, c[24].x;
MAD R1.xyz, fragment.texcoord[1].y, R1, R0;
RCP R3.y, R3.y;
ADD R3.x, fragment.texcoord[2].y, -c[23];
MUL_SAT R3.x, R3, R3.y;
MAD R0.y, -R3.x, c[26], c[26].z;
MUL R0.x, R3, R3;
MUL R4.y, R0.x, R0;
MUL R3.xyz, fragment.texcoord[0], c[9].x;
MUL R4.z, R1.w, R4.y;
TEX R0.xyz, R3.zyzw, texture[4], 2D;
MAD R2.xyz, R1, R4.z, R2;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[4], 2D;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[4], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R1, R0;
MUL R1.xyz, fragment.texcoord[0], c[10].x;
MUL R4.x, R0.w, R4;
MAD R0.xyz, R0, R4.x, R2;
TEX R3.xyz, R1.zyzw, texture[5], 2D;
TEX R2.xyz, R1, texture[5], 2D;
MUL R3.xyz, fragment.texcoord[1].x, R3;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[5], 2D;
MAD R3.xyz, fragment.texcoord[1].y, R1, R2;
MUL R1.xyz, fragment.texcoord[0], c[11].x;
MUL R3.w, R0, R3;
TEX R2.xyz, R1.zyzw, texture[6], 2D;
MAD R0.xyz, R3, R3.w, R0;
MUL R3.xyz, fragment.texcoord[1].x, R2;
TEX R2.xyz, R1, texture[6], 2D;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[6], 2D;
MAD R3.xyz, fragment.texcoord[1].y, R1, R2;
MUL R1.xyz, fragment.texcoord[0], c[12].x;
MUL R2.w, R0, R2;
TEX R2.xyz, R1.zyzw, texture[7], 2D;
MAD R0.xyz, R3, R2.w, R0;
MUL R3.xyz, fragment.texcoord[1].x, R2;
TEX R2.xyz, R1, texture[7], 2D;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[7], 2D;
MAD R1.xyz, fragment.texcoord[1].y, R1, R2;
MUL R2.x, R0.w, R4.y;
MAD R0.xyz, R1, R2.x, R0;
MAD R1.xyz, fragment.texcoord[3], R0, -fragment.texcoord[3];
ADD R0.x, R1.w, R0.w;
MOV R0.w, c[6].x;
ADD R0.w, -R0, c[7].x;
RCP R1.w, R0.w;
ADD R0.w, fragment.texcoord[2].z, -c[6].x;
MAD R2.xyz, R0.x, R1, fragment.texcoord[3];
MUL R3.xyz, fragment.texcoord[0], c[5].x;
TEX R1.xyz, R3.zyzw, texture[8], 2D;
MUL R1.xyz, fragment.texcoord[1].x, R1;
TEX R0.xyz, R3, texture[8], 2D;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[8], 2D;
MAD R0.xyz, R1, fragment.texcoord[1].y, R0;
MUL_SAT R0.w, R0, R1;
MAD R1.x, -R0.w, c[26].y, c[26].z;
MUL R0.w, R0, R0;
MAD R0.w, -R0, R1.x, c[26];
ADD R1.xyz, R0, -R2;
MUL R0.x, fragment.texcoord[2], R0.w;
MAD R1.xyz, R0.x, R1, R2;
MUL R0.xyz, R1, fragment.texcoord[5];
MUL R1.xyz, R1, c[0];
MAX R0.w, fragment.texcoord[4].z, c[26].x;
MUL R1.xyz, R0.w, R1;
MAD result.color.xyz, R1, c[26].y, R0;
MOV result.color.w, c[25].x;
END
# 155 instructions, 5 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
					}
					Vector 0[_LightColor0]
					Float 1[_texTiling]
					Float 2[_texPower]
					Float 3[_groundTexStart]
					Float 4[_groundTexEnd]
					Float 5[_steepTiling]
					Float 6[_steepTexStart]
					Float 7[_steepTexEnd]
					Float 8[_multiPower]
					Float 9[_deepMultiFactor]
					Float 10[_mainMultiFactor]
					Float 11[_highMultiFactor]
					Float 12[_snowMultiFactor]
					Float 13[_deepStart]
					Float 14[_deepEnd]
					Float 15[_mainLoStart]
					Float 16[_mainLoEnd]
					Float 17[_mainHiStart]
					Float 18[_mainHiEnd]
					Float 19[_hiLoStart]
					Float 20[_hiLoEnd]
					Float 21[_hiHiStart]
					Float 22[_hiHiEnd]
					Float 23[_snowStart]
					Float 24[_snowEnd]
					Float 25[_PlanetOpacity]
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 1
					SetTexture 2[_highTex] 2D 2
					SetTexture 3[_snowTex] 2D 3
					SetTexture 4[_deepMultiTex] 2D 4
					SetTexture 5[_mainMultiTex] 2D 5
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8 "ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
dcl_2d s8
def c26, 0.00000000, 2.00000000, 3.00000000, 1.00000000
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
mov r0.x, c4
add r0.w, -c3.x, r0.x
mul r0.xyz, v0, c1.x
rcp r1.x, r0.w
texld r3.xyz, r0.zyzw, s0
add r0.w, v2.z, -c3.x
mul_sat r0.w, r0, r1.x
texld r1.xyz, r0.zyzw, s1
mad r1.w, -r0, c26.y, c26.z
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s1
mad r2.xyz, v1.z, r1, r2
mul r0.w, r0, r0
mul r0.w, r0, r1
add r1.x, -r0.w, c26.w
mov r1.z, c18.x
add r1.z, -c17.x, r1
rcp r1.w, r1.z
add r1.z, v2.y, -c17.x
mul_sat r1.w, r1.z, r1
mov r1.y, c16.x
add r1.y, -c15.x, r1
rcp r1.z, r1.y
add r1.y, v2, -c15.x
mul_sat r1.y, r1, r1.z
mul r0.w, r0, c8.x
mad r2.w, -r1, c26.y, c26.z
mul r1.z, r1.w, r1.w
mul r1.w, r1.z, r2
mul r1.z, r1.y, r1.y
mad r1.y, -r1, c26, c26.z
mad r3.w, r1.z, r1.y, -r1
mul r1.w, r1.x, c2.x
mul r2.w, r1, r3
texld r1.xyz, r0.zxzw, s1
mad r1.xyz, v1.y, r1, r2
mul r2.xyz, r1, r2.w
mov r2.w, c14.x
add r2.w, -c13.x, r2
rcp r4.x, r2.w
add r2.w, v2.y, -c13.x
texld r1.xyz, r0, s0
mul r3.xyz, v1.x, r3
mul_sat r2.w, r2, r4.x
mad r3.xyz, v1.z, r1, r3
mad r1.y, -r2.w, c26, c26.z
mul r1.x, r2.w, r2.w
mad r4.x, -r1, r1.y, c26.w
mul r2.w, r1, r4.x
texld r1.xyz, r0.zxzw, s0
mad r3.xyz, v1.y, r1, r3
mad r3.xyz, r3, r2.w, r2
texld r1.xyz, r0.zyzw, s2
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s2
mad r2.xyz, v1.z, r1, r2
mov r1.y, c22.x
add r1.y, -c21.x, r1
rcp r1.z, r1.y
add r1.y, v2, -c21.x
mul_sat r1.z, r1.y, r1
mov r1.x, c20
add r1.x, -c19, r1
rcp r1.y, r1.x
add r1.x, v2.y, -c19
mul_sat r1.x, r1, r1.y
mad r2.w, -r1.z, c26.y, c26.z
mul r1.y, r1.z, r1.z
mul r1.z, r1.y, r2.w
mul r1.y, r1.x, r1.x
mad r1.x, -r1, c26.y, c26.z
mad r2.w, r1.y, r1.x, -r1.z
texld r1.xyz, r0.zxzw, s2
mad r1.xyz, v1.y, r1, r2
mul r2.x, r1.w, r2.w
mad r2.xyz, r1, r2.x, r3
texld r1.xyz, r0.zyzw, s3
texld r3.xyz, r0, s3
mul r1.xyz, v1.x, r1
mad r1.xyz, v1.z, r3, r1
mov r0.y, c24.x
add r3.x, -c23, r0.y
rcp r3.y, r3.x
add r3.x, v2.y, -c23
texld r0.xyz, r0.zxzw, s3
mul_sat r4.y, r3.x, r3
mad r3.xyz, v1.y, r0, r1
mad r0.y, -r4, c26, c26.z
mul r0.x, r4.y, r4.y
mul r4.y, r0.x, r0
mul r0.xyz, v0, c9.x
mul r4.z, r1.w, r4.y
mad r3.xyz, r3, r4.z, r2
texld r1.xyz, r0.zyzw, s4
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s4
mad r1.xyz, v1.z, r1, r2
texld r0.xyz, r0.zxzw, s4
mad r1.xyz, v1.y, r0, r1
mul r0.xyz, v0, c10.x
mul r4.x, r0.w, r4
texld r2.xyz, r0.zyzw, s5
mad r1.xyz, r1, r4.x, r3
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s5
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s5
mad r3.xyz, v1.y, r0, r2
mul r0.xyz, v0, c11.x
mul r3.w, r0, r3
texld r2.xyz, r0.zyzw, s6
mad r1.xyz, r3, r3.w, r1
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s6
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s6
mad r3.xyz, v1.y, r0, r2
mul r0.xyz, v0, c12.x
mul r2.w, r0, r2
texld r2.xyz, r0.zyzw, s7
mad r1.xyz, r3, r2.w, r1
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s7
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s7
mad r0.xyz, v1.y, r0, r2
mul r2.x, r0.w, r4.y
mad r0.xyz, r0, r2.x, r1
mad r1.xyz, v3, r0, -v3
mul r0.xyz, v0, c5.x
add r0.w, r1, r0
mad r3.xyz, r0.w, r1, v3
texld r1.xyz, r0.zyzw, s8
texld r2.xyz, r0, s8
mov r0.y, c7.x
add r0.w, -c6.x, r0.y
rcp r1.w, r0.w
mul r1.xyz, v1.x, r1
add r0.w, v2.z, -c6.x
mad r1.xyz, v1.z, r2, r1
texld r0.xyz, r0.zxzw, s8
mad r0.xyz, r0, v1.y, r1
mul_sat r0.w, r0, r1
mad r1.x, -r0.w, c26.y, c26.z
mul r0.w, r0, r0
mad r0.w, -r0, r1.x, c26
add r1.xyz, r0, -r3
mul r0.x, v2, r0.w
mad r1.xyz, r0.x, r1, r3
mul_pp r0.xyz, r1, v5
mul_pp r1.xyz, r1, c0
max_pp r0.w, v4.z, c26.x
mul_pp r1.xyz, r0.w, r1
mad_pp oC0.xyz, r1, c26.y, r0
mov_pp oC0.w, c25.x
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
					}
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 2
					SetTexture 2[_highTex] 2D 4
					SetTexture 3[_snowTex] 2D 6
					SetTexture 4[_deepMultiTex] 2D 1
					SetTexture 5[_mainMultiTex] 2D 3
					SetTexture 6[_highMultiTex] 2D 5
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					ConstBuffer "$Globals"
					192
					Vector 16[_LightColor0]
					Float 64[_texTiling]
					Float 68[_texPower]
					Float 72[_groundTexStart]
					Float 76[_groundTexEnd]
					Float 84[_steepTiling]
					Float 88[_steepTexStart]
					Float 92[_steepTexEnd]
					Float 104[_multiPower]
					Float 108[_deepMultiFactor]
					Float 112[_mainMultiFactor]
					Float 116[_highMultiFactor]
					Float 120[_snowMultiFactor]
					Float 124[_deepStart]
					Float 128[_deepEnd]
					Float 132[_mainLoStart]
					Float 136[_mainLoEnd]
					Float 140[_mainHiStart]
					Float 144[_mainHiEnd]
					Float 148[_hiLoStart]
					Float 152[_hiLoEnd]
					Float 156[_hiHiStart]
					Float 160[_hiHiEnd]
					Float 164[_snowStart]
					Float 168[_snowEnd]
					Float 172[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedmchmbedbhnimcajkcogmhngcpfdakmfbabaaaaaammbfaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaeaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjebeaaaaeaaaaaaacfafaaaa
fjaaaaaeegiocaaaaaaaaaaaalaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaa
agaaaaaafkaaaaadaagabaaaahaaaaaafkaaaaadaagabaaaaiaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaae
aahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaafibiaaae
aahabaaaagaaaaaaffffaaaafibiaaaeaahabaaaahaaaaaaffffaaaafibiaaae
aahabaaaaiaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaad
ecbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacagaaaaaaaaaaaaakbcaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaa
ahaaaaaaakiacaaaaaaaaaaaaiaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaajccaabaaa
aaaaaaaabkbabaaaadaaaaaadkiacaiaebaaaaaaaaaaaaaaahaaaaaadicaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadp
aaaaaaakccaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaadkiacaaa
aaaaaaaaaeaaaaaaaoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpbkaabaaaaaaaaaaaaaaaaaajecaabaaaaaaaaaaackbabaaa
adaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaadicaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaackiacaaaaaaaaaaaagaaaaaadiaaaaaiecaabaaaaaaaaaaa
dkaabaaaaaaaaaaabkiacaaaaaaaaaaaaeaaaaaadcaaaaakicaabaaaaaaaaaaa
bkiacaaaaaaaaaaaaeaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
bcaabaaaabaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaakccaabaaaabaaaaaa
dkiacaiaebaaaaaaaaaaaaaaaiaaaaaaakiacaaaaaaaaaaaajaaaaaaaoaaaaak
ccaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaa
abaaaaaaaaaaaaajmcaabaaaabaaaaaafgbfbaaaadaaaaaafgincaiaebaaaaaa
aaaaaaaaaiaaaaaadicaaaahccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaa
abaaaaaadcaaaaajicaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaa
aaaaaaakicaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaaaiaaaaaackiacaaa
aaaaaaaaaiaaaaaaaoaaaaakicaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpdkaabaaaabaaaaaadicaaaahecaabaaaabaaaaaadkaabaaa
abaaaaaackaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaackaabaaaabaaaaaa
abeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahecaabaaaabaaaaaackaabaaa
abaaaaaackaabaaaabaaaaaadcaaaaakccaabaaaabaaaaaadkaabaaaabaaaaaa
ckaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaadiaaaaahecaabaaaabaaaaaa
ckaabaaaaaaaaaaabkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaa
aaaaaaaabkaabaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaa
agiacaaaaaaaaaaaaeaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaa
adaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaa
aeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaa
cgakbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaa
adaaaaaaegacbaaaaeaaaaaafgbfbaaaacaaaaaaegacbaaaadaaaaaadiaaaaah
hcaabaaaadaaaaaakgakbaaaabaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaa
aeaaaaaaggakbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaah
hcaabaaaaeaaaaaaegacbaaaaeaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaa
afaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaj
hcaabaaaaeaaaaaaegacbaaaafaaaaaakgbkbaaaacaaaaaaegacbaaaaeaaaaaa
efaaaaajpcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaajhcaabaaaaeaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaa
egacbaaaaeaaaaaadcaaaaajncaabaaaabaaaaaaagajbaaaaeaaaaaaagaabaaa
abaaaaaaagajbaaaadaaaaaaaaaaaaakicaabaaaacaaaaaadkiacaiaebaaaaaa
aaaaaaaaajaaaaaaakiacaaaaaaaaaaaakaaaaaaaoaaaaakicaabaaaacaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaacaaaaaaaaaaaaaj
dcaabaaaadaaaaaafgbfbaaaadaaaaaangifcaiaebaaaaaaaaaaaaaaajaaaaaa
dicaaaahicaabaaaacaaaaaadkaabaaaacaaaaaabkaabaaaadaaaaaadcaaaaaj
ccaabaaaadaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaea
diaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaabkaabaaaadaaaaaaaaaaaaakccaabaaa
adaaaaaabkiacaiaebaaaaaaaaaaaaaaajaaaaaackiacaaaaaaaaaaaajaaaaaa
aoaaaaakccaabaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
bkaabaaaadaaaaaadicaaaahbcaabaaaadaaaaaabkaabaaaadaaaaaaakaabaaa
adaaaaaadcaaaaajccaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaa
adaaaaaadcaaaaakicaabaaaacaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaa
dkaabaiaebaaaaaaacaaaaaadiaaaaahbcaabaaaadaaaaaackaabaaaaaaaaaaa
dkaabaaaacaaaaaadiaaaaahicaabaaaacaaaaaabkaabaaaaaaaaaaadkaabaaa
acaaaaaaefaaaaajpcaabaaaaeaaaaaaggakbaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaaeaaaaaadiaaaaahocaabaaaadaaaaaaagajbaaaaeaaaaaaagbabaaa
acaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaaeaaaaaadcaaaaajocaabaaaadaaaaaaagajbaaaaeaaaaaakgbkbaaa
acaaaaaafgaobaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaaacaaaaaa
eghobaaaacaaaaaaaagabaaaaeaaaaaadcaaaaajocaabaaaadaaaaaaagajbaaa
aeaaaaaafgbfbaaaacaaaaaafgaobaaaadaaaaaadcaaaaajncaabaaaabaaaaaa
fgaobaaaadaaaaaaagaabaaaadaaaaaaagaobaaaabaaaaaaaaaaaaakbcaabaaa
adaaaaaabkiacaiaebaaaaaaaaaaaaaaakaaaaaackiacaaaaaaaaaaaakaaaaaa
aoaaaaakbcaabaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
akaabaaaadaaaaaaaaaaaaajccaabaaaadaaaaaabkbabaaaadaaaaaabkiacaia
ebaaaaaaaaaaaaaaakaaaaaadicaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaa
bkaabaaaadaaaaaadcaaaaajccaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaa
akaabaaaadaaaaaadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaa
adaaaaaadiaaaaahgcaabaaaaaaaaaaafgagbaaaaaaaaaaaagaabaaaadaaaaaa
efaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaa
agaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaa
efaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaa
agaaaaaaefaaaaajpcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaadaaaaaa
aagabaaaagaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaa
acaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaa
fgbfbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajncaabaaaabaaaaaaagajbaaa
acaaaaaakgakbaaaaaaaaaaaagaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaa
egbcbaaaabaaaaaapgipcaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaaadaaaaaa
ggakbaaaacaaaaaaeghobaaaaeaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaa
adaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaa
egaabaaaacaaaaaaeghobaaaaeaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
afaaaaaacgakbaaaacaaaaaaeghobaaaaeaaaaaaaagabaaaabaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaa
dcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaa
acaaaaaadcaaaaajncaabaaaabaaaaaaagajbaaaacaaaaaaagaabaaaaaaaaaaa
agaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaaagiacaaa
aaaaaaaaahaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaa
afaaaaaaaagabaaaadaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaa
agbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaa
afaaaaaaaagabaaaadaaaaaaefaaaaajpcaabaaaafaaaaaacgakbaaaacaaaaaa
eghobaaaafaaaaaaaagabaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaa
aeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaa
abaaaaaaegacbaaaacaaaaaafgafbaaaabaaaaaaigadbaaaabaaaaaadiaaaaai
hcaabaaaacaaaaaaegbcbaaaabaaaaaafgifcaaaaaaaaaaaahaaaaaaefaaaaaj
pcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaagaaaaaaaagabaaaafaaaaaa
diaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaagaaaaaaaagabaaaafaaaaaa
efaaaaajpcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaagaaaaaaaagabaaa
afaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaa
egacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaa
acaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaa
pgapbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaa
abaaaaaakgikcaaaaaaaaaaaahaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaa
acaaaaaaeghobaaaahaaaaaaaagabaaaahaaaaaadiaaaaahhcaabaaaadaaaaaa
egacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
acaaaaaaeghobaaaahaaaaaaaagabaaaahaaaaaaefaaaaajpcaabaaaacaaaaaa
cgakbaaaacaaaaaaeghobaaaahaaaaaaaagabaaaahaaaaaadcaaaaajhcaabaaa
adaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaacaaaaaafgbfbaaaacaaaaaaegacbaaaadaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaacaaaaaafgafbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaa
egbcbaiaebaaaaaaaeaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaaegbcbaaaaeaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaa
abaaaaaafgifcaaaaaaaaaaaafaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaa
abaaaaaaeghobaaaaiaaaaaaaagabaaaaiaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaa
abaaaaaaeghobaaaaiaaaaaaaagabaaaaiaaaaaaefaaaaajpcaabaaaabaaaaaa
cgakbaaaabaaaaaaeghobaaaaiaaaaaaaagabaaaaiaaaaaadcaaaaajhcaabaaa
acaaaaaaegacbaaaadaaaaaakgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaaj
hcaabaaaabaaaaaaegacbaaaabaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaa
aaaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaaegacbaaaabaaaaaa
aaaaaaakicaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaafaaaaaadkiacaaa
aaaaaaaaafaaaaaaaoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpdkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaackbabaaa
adaaaaaackiacaiaebaaaaaaaaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaia
ebaaaaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakbabaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegbcbaaaagaaaaaadeaaaaahicaabaaaaaaaaaaa
ckbabaaaafaaaaaaabeaaaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaagiccabaaaaaaaaaaadkiacaaa
aaaaaaaaakaaaaaadoaaaaab"
				}
				SubProgram "opengl " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
					}
					Float 0[_texTiling]
					Float 1[_texPower]
					Float 2[_groundTexStart]
					Float 3[_groundTexEnd]
					Float 4[_steepTiling]
					Float 5[_steepTexStart]
					Float 6[_steepTexEnd]
					Float 7[_multiPower]
					Float 8[_deepMultiFactor]
					Float 9[_mainMultiFactor]
					Float 10[_highMultiFactor]
					Float 11[_snowMultiFactor]
					Float 12[_deepStart]
					Float 13[_deepEnd]
					Float 14[_mainLoStart]
					Float 15[_mainLoEnd]
					Float 16[_mainHiStart]
					Float 17[_mainHiEnd]
					Float 18[_hiLoStart]
					Float 19[_hiLoEnd]
					Float 20[_hiHiStart]
					Float 21[_hiHiEnd]
					Float 22[_snowStart]
					Float 23[_snowEnd]
					Float 24[_PlanetOpacity]
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 1
					SetTexture 2[_highTex] 2D 2
					SetTexture 3[_snowTex] 2D 3
					SetTexture 4[_deepMultiTex] 2D 4
					SetTexture 5[_mainMultiTex] 2D 5
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[unity_Lightmap] 2D 9 "3.0-!!ARBfp1.0
PARAM c[26] = { program.local[0..24],
		{ 2, 3, 1, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.x, c[2];
ADD R0.x, -R0, c[3];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].z, -c[2];
MUL_SAT R0.w, R0.x, R0.y;
MUL R3.xyz, fragment.texcoord[0], c[0].x;
MAD R1.x, -R0.w, c[25], c[25].y;
MUL R0.w, R0, R0;
MOV R2.w, c[12].x;
ADD R2.w, -R2, c[13].x;
RCP R4.x, R2.w;
ADD R2.w, fragment.texcoord[2].y, -c[12].x;
MUL_SAT R2.w, R2, R4.x;
TEX R0.xyz, R3.zyzw, texture[1], 2D;
MUL R0.w, R0, R1.x;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[1], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R0, R1;
ADD R0.x, -R0.w, c[25].z;
MOV R0.z, c[16].x;
ADD R0.z, -R0, c[17].x;
RCP R1.w, R0.z;
ADD R0.z, fragment.texcoord[2].y, -c[16].x;
MUL_SAT R1.w, R0.z, R1;
MOV R0.y, c[14].x;
ADD R0.y, -R0, c[15].x;
RCP R0.z, R0.y;
ADD R0.y, fragment.texcoord[2], -c[14].x;
MUL_SAT R0.y, R0, R0.z;
MUL R0.w, R0, c[7].x;
MAD R2.x, -R1.w, c[25], c[25].y;
MUL R0.z, R1.w, R1.w;
MUL R1.w, R0.z, R2.x;
MUL R0.z, R0.y, R0.y;
MAD R0.y, -R0, c[25].x, c[25];
MAD R3.w, R0.z, R0.y, -R1;
MUL R1.w, R0.x, c[1].x;
MUL R2.x, R1.w, R3.w;
TEX R0.xyz, R3.zxzw, texture[1], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R0, R1;
MUL R1.xyz, R0, R2.x;
TEX R2.xyz, R3.zyzw, texture[0], 2D;
TEX R0.xyz, R3, texture[0], 2D;
MUL R2.xyz, fragment.texcoord[1].x, R2;
MAD R2.xyz, fragment.texcoord[1].z, R0, R2;
MAD R0.y, -R2.w, c[25].x, c[25];
MUL R0.x, R2.w, R2.w;
MAD R4.x, -R0, R0.y, c[25].z;
TEX R0.xyz, R3.zxzw, texture[0], 2D;
MUL R2.w, R1, R4.x;
MAD R2.xyz, fragment.texcoord[1].y, R0, R2;
TEX R0.xyz, R3.zyzw, texture[2], 2D;
MAD R2.xyz, R2, R2.w, R1;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[2], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R0, R1;
MOV R0.y, c[20].x;
ADD R0.y, -R0, c[21].x;
RCP R0.z, R0.y;
ADD R0.y, fragment.texcoord[2], -c[20].x;
MUL_SAT R0.z, R0.y, R0;
MOV R0.x, c[18];
ADD R0.x, -R0, c[19];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].y, -c[18];
MUL_SAT R0.x, R0, R0.y;
MAD R2.w, -R0.z, c[25].x, c[25].y;
MUL R0.y, R0.z, R0.z;
MUL R0.z, R0.y, R2.w;
MUL R0.y, R0.x, R0.x;
MAD R0.x, -R0, c[25], c[25].y;
MAD R2.w, R0.y, R0.x, -R0.z;
TEX R0.xyz, R3.zxzw, texture[2], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R0, R1;
MUL R1.x, R1.w, R2.w;
MAD R2.xyz, R0, R1.x, R2;
TEX R1.xyz, R3.zyzw, texture[3], 2D;
TEX R0.xyz, R3, texture[3], 2D;
MUL R1.xyz, fragment.texcoord[1].x, R1;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[3], 2D;
MOV R3.y, c[22].x;
ADD R3.y, -R3, c[23].x;
MAD R1.xyz, fragment.texcoord[1].y, R1, R0;
RCP R3.y, R3.y;
ADD R3.x, fragment.texcoord[2].y, -c[22];
MUL_SAT R3.x, R3, R3.y;
MAD R0.y, -R3.x, c[25].x, c[25];
MUL R0.x, R3, R3;
MUL R4.y, R0.x, R0;
MUL R3.xyz, fragment.texcoord[0], c[8].x;
MUL R4.z, R1.w, R4.y;
TEX R0.xyz, R3.zyzw, texture[4], 2D;
MAD R2.xyz, R1, R4.z, R2;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[4], 2D;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[4], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R1, R0;
MUL R1.xyz, fragment.texcoord[0], c[9].x;
MUL R4.x, R0.w, R4;
MAD R0.xyz, R0, R4.x, R2;
TEX R3.xyz, R1.zyzw, texture[5], 2D;
TEX R2.xyz, R1, texture[5], 2D;
MUL R3.xyz, fragment.texcoord[1].x, R3;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[5], 2D;
MAD R3.xyz, fragment.texcoord[1].y, R1, R2;
MUL R1.xyz, fragment.texcoord[0], c[10].x;
MUL R3.w, R0, R3;
TEX R2.xyz, R1.zyzw, texture[6], 2D;
MAD R0.xyz, R3, R3.w, R0;
MUL R3.xyz, fragment.texcoord[1].x, R2;
TEX R2.xyz, R1, texture[6], 2D;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[6], 2D;
MAD R3.xyz, fragment.texcoord[1].y, R1, R2;
MUL R1.xyz, fragment.texcoord[0], c[11].x;
MUL R2.w, R0, R2;
TEX R2.xyz, R1.zyzw, texture[7], 2D;
MAD R0.xyz, R3, R2.w, R0;
MUL R3.xyz, fragment.texcoord[1].x, R2;
TEX R2.xyz, R1, texture[7], 2D;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[7], 2D;
MAD R1.xyz, fragment.texcoord[1].y, R1, R2;
MUL R2.x, R0.w, R4.y;
MAD R0.xyz, R1, R2.x, R0;
MAD R2.xyz, fragment.texcoord[3], R0, -fragment.texcoord[3];
MUL R1.xyz, fragment.texcoord[0], c[4].x;
ADD R0.w, R1, R0;
MAD R3.xyz, R0.w, R2, fragment.texcoord[3];
TEX R0.xyz, R1.zyzw, texture[8], 2D;
MUL R2.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R1, texture[8], 2D;
MOV R0.w, c[5].x;
TEX R1.xyz, R1.zxzw, texture[8], 2D;
MAD R0.xyz, fragment.texcoord[1].z, R0, R2;
MAD R0.xyz, R1, fragment.texcoord[1].y, R0;
ADD R0.w, -R0, c[6].x;
RCP R1.x, R0.w;
ADD R0.w, fragment.texcoord[2].z, -c[5].x;
MUL_SAT R0.w, R0, R1.x;
ADD R1.xyz, R0, -R3;
MAD R0.y, -R0.w, c[25].x, c[25];
MUL R0.x, R0.w, R0.w;
MAD R1.w, -R0.x, R0.y, c[25].z;
TEX R0, fragment.texcoord[4], texture[9], 2D;
MUL R1.w, fragment.texcoord[2].x, R1;
MAD R1.xyz, R1.w, R1, R3;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, R1;
MUL result.color.xyz, R0, c[25].w;
MOV result.color.w, c[24].x;
END
# 154 instructions, 5 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
					}
					Float 0[_texTiling]
					Float 1[_texPower]
					Float 2[_groundTexStart]
					Float 3[_groundTexEnd]
					Float 4[_steepTiling]
					Float 5[_steepTexStart]
					Float 6[_steepTexEnd]
					Float 7[_multiPower]
					Float 8[_deepMultiFactor]
					Float 9[_mainMultiFactor]
					Float 10[_highMultiFactor]
					Float 11[_snowMultiFactor]
					Float 12[_deepStart]
					Float 13[_deepEnd]
					Float 14[_mainLoStart]
					Float 15[_mainLoEnd]
					Float 16[_mainHiStart]
					Float 17[_mainHiEnd]
					Float 18[_hiLoStart]
					Float 19[_hiLoEnd]
					Float 20[_hiHiStart]
					Float 21[_hiHiEnd]
					Float 22[_snowStart]
					Float 23[_snowEnd]
					Float 24[_PlanetOpacity]
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 1
					SetTexture 2[_highTex] 2D 2
					SetTexture 3[_snowTex] 2D 3
					SetTexture 4[_deepMultiTex] 2D 4
					SetTexture 5[_mainMultiTex] 2D 5
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[unity_Lightmap] 2D 9 "ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
dcl_2d s8
dcl_2d s9
def c25, 2.00000000, 3.00000000, 1.00000000, 8.00000000
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xy
mov r0.x, c3
add r0.w, -c2.x, r0.x
mul r0.xyz, v0, c0.x
rcp r1.x, r0.w
texld r3.xyz, r0.zyzw, s0
add r0.w, v2.z, -c2.x
mul_sat r0.w, r0, r1.x
texld r1.xyz, r0.zyzw, s1
mad r1.w, -r0, c25.x, c25.y
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s1
mad r2.xyz, v1.z, r1, r2
mul r0.w, r0, r0
mul r0.w, r0, r1
add r1.x, -r0.w, c25.z
mov r1.z, c17.x
add r1.z, -c16.x, r1
rcp r1.w, r1.z
add r1.z, v2.y, -c16.x
mul_sat r1.w, r1.z, r1
mov r1.y, c15.x
add r1.y, -c14.x, r1
rcp r1.z, r1.y
add r1.y, v2, -c14.x
mul_sat r1.y, r1, r1.z
mul r0.w, r0, c7.x
mad r2.w, -r1, c25.x, c25.y
mul r1.z, r1.w, r1.w
mul r1.w, r1.z, r2
mul r1.z, r1.y, r1.y
mad r1.y, -r1, c25.x, c25
mad r3.w, r1.z, r1.y, -r1
mul r1.w, r1.x, c1.x
mul r2.w, r1, r3
texld r1.xyz, r0.zxzw, s1
mad r1.xyz, v1.y, r1, r2
mul r2.xyz, r1, r2.w
mov r2.w, c13.x
add r2.w, -c12.x, r2
rcp r4.x, r2.w
add r2.w, v2.y, -c12.x
texld r1.xyz, r0, s0
mul r3.xyz, v1.x, r3
mul_sat r2.w, r2, r4.x
mad r3.xyz, v1.z, r1, r3
mad r1.y, -r2.w, c25.x, c25
mul r1.x, r2.w, r2.w
mad r4.x, -r1, r1.y, c25.z
mul r2.w, r1, r4.x
texld r1.xyz, r0.zxzw, s0
mad r3.xyz, v1.y, r1, r3
mad r3.xyz, r3, r2.w, r2
texld r1.xyz, r0.zyzw, s2
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s2
mad r2.xyz, v1.z, r1, r2
mov r1.y, c21.x
add r1.y, -c20.x, r1
rcp r1.z, r1.y
add r1.y, v2, -c20.x
mul_sat r1.z, r1.y, r1
mov r1.x, c19
add r1.x, -c18, r1
rcp r1.y, r1.x
add r1.x, v2.y, -c18
mul_sat r1.x, r1, r1.y
mad r2.w, -r1.z, c25.x, c25.y
mul r1.y, r1.z, r1.z
mul r1.z, r1.y, r2.w
mul r1.y, r1.x, r1.x
mad r1.x, -r1, c25, c25.y
mad r2.w, r1.y, r1.x, -r1.z
texld r1.xyz, r0.zxzw, s2
mad r1.xyz, v1.y, r1, r2
mul r2.x, r1.w, r2.w
mad r2.xyz, r1, r2.x, r3
texld r1.xyz, r0.zyzw, s3
texld r3.xyz, r0, s3
mul r1.xyz, v1.x, r1
mad r1.xyz, v1.z, r3, r1
mov r0.y, c23.x
add r3.x, -c22, r0.y
rcp r3.y, r3.x
add r3.x, v2.y, -c22
texld r0.xyz, r0.zxzw, s3
mul_sat r4.y, r3.x, r3
mad r3.xyz, v1.y, r0, r1
mad r0.y, -r4, c25.x, c25
mul r0.x, r4.y, r4.y
mul r4.y, r0.x, r0
mul r0.xyz, v0, c8.x
mul r4.z, r1.w, r4.y
mad r3.xyz, r3, r4.z, r2
texld r1.xyz, r0.zyzw, s4
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s4
mad r1.xyz, v1.z, r1, r2
texld r0.xyz, r0.zxzw, s4
mad r1.xyz, v1.y, r0, r1
mul r0.xyz, v0, c9.x
mul r4.x, r0.w, r4
texld r2.xyz, r0.zyzw, s5
mad r1.xyz, r1, r4.x, r3
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s5
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s5
mad r3.xyz, v1.y, r0, r2
mul r0.xyz, v0, c10.x
mul r3.w, r0, r3
texld r2.xyz, r0.zyzw, s6
mad r1.xyz, r3, r3.w, r1
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s6
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s6
mad r3.xyz, v1.y, r0, r2
mul r0.xyz, v0, c11.x
mul r2.w, r0, r2
texld r2.xyz, r0.zyzw, s7
mad r1.xyz, r3, r2.w, r1
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s7
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s7
mad r0.xyz, v1.y, r0, r2
mul r2.x, r0.w, r4.y
mad r0.xyz, r0, r2.x, r1
mad r2.xyz, v3, r0, -v3
mul r0.xyz, v0, c4.x
add r0.w, r1, r0
mad r3.xyz, r0.w, r2, v3
texld r1.xyz, r0.zyzw, s8
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s8
mov r0.w, c6.x
mad r1.xyz, v1.z, r1, r2
texld r0.xyz, r0.zxzw, s8
mad r0.xyz, r0, v1.y, r1
add r0.w, -c5.x, r0
rcp r1.x, r0.w
add r0.w, v2.z, -c5.x
mul_sat r0.w, r0, r1.x
add r1.xyz, r0, -r3
mad r0.y, -r0.w, c25.x, c25
mul r0.x, r0.w, r0.w
mad r1.w, -r0.x, r0.y, c25.z
texld r0, v4, s9
mul r1.w, v2.x, r1
mad r1.xyz, r1.w, r1, r3
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, r1
mul_pp oC0.xyz, r0, c25.w
mov_pp oC0.w, c24.x
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
					}
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 2
					SetTexture 2[_highTex] 2D 4
					SetTexture 3[_snowTex] 2D 6
					SetTexture 4[_deepMultiTex] 2D 1
					SetTexture 5[_mainMultiTex] 2D 3
					SetTexture 6[_highMultiTex] 2D 5
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[unity_Lightmap] 2D 9
					ConstBuffer "$Globals"
					208
					Float 64[_texTiling]
					Float 68[_texPower]
					Float 72[_groundTexStart]
					Float 76[_groundTexEnd]
					Float 84[_steepTiling]
					Float 88[_steepTexStart]
					Float 92[_steepTexEnd]
					Float 104[_multiPower]
					Float 108[_deepMultiFactor]
					Float 112[_mainMultiFactor]
					Float 116[_highMultiFactor]
					Float 120[_snowMultiFactor]
					Float 124[_deepStart]
					Float 128[_deepEnd]
					Float 132[_mainLoStart]
					Float 136[_mainLoEnd]
					Float 140[_mainHiStart]
					Float 144[_mainHiEnd]
					Float 148[_hiLoStart]
					Float 152[_hiLoEnd]
					Float 156[_hiHiStart]
					Float 160[_hiHiEnd]
					Float 164[_snowStart]
					Float 168[_snowEnd]
					Float 172[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedcfigibmhkibbiofnddjnacmhegdhfkmcabaaaaaakebfaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefciebeaaaa
eaaaaaaacbafaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaa
fkaaaaadaagabaaaagaaaaaafkaaaaadaagabaaaahaaaaaafkaaaaadaagabaaa
aiaaaaaafkaaaaadaagabaaaajaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaa
fibiaaaeaahabaaaafaaaaaaffffaaaafibiaaaeaahabaaaagaaaaaaffffaaaa
fibiaaaeaahabaaaahaaaaaaffffaaaafibiaaaeaahabaaaaiaaaaaaffffaaaa
fibiaaaeaahabaaaajaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gcbaaaaddcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaa
aaaaaaakbcaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaaahaaaaaaakiacaaa
aaaaaaaaaiaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaabkbabaaa
adaaaaaadkiacaiaebaaaaaaaaaaaaaaahaaaaaadicaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaakccaabaaa
aaaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaadkiacaaaaaaaaaaaaeaaaaaa
aoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
bkaabaaaaaaaaaaaaaaaaaajecaabaaaaaaaaaaackbabaaaadaaaaaackiacaia
ebaaaaaaaaaaaaaaaeaaaaaadicaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckiacaaaaaaaaaaaagaaaaaadiaaaaaiecaabaaaaaaaaaaadkaabaaaaaaaaaaa
bkiacaaaaaaaaaaaaeaaaaaadcaaaaakicaabaaaaaaaaaaabkiacaaaaaaaaaaa
aeaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaa
ckaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaaaaaaaaakccaabaaaabaaaaaadkiacaiaebaaaaaa
aaaaaaaaaiaaaaaaakiacaaaaaaaaaaaajaaaaaaaoaaaaakccaabaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaabaaaaaaaaaaaaaj
mcaabaaaabaaaaaafgbfbaaaadaaaaaafgincaiaebaaaaaaaaaaaaaaaiaaaaaa
dicaaaahccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaaj
icaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaea
diaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaaaaaaaaakicaabaaa
abaaaaaabkiacaiaebaaaaaaaaaaaaaaaiaaaaaackiacaaaaaaaaaaaaiaaaaaa
aoaaaaakicaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
dkaabaaaabaaaaaadicaaaahecaabaaaabaaaaaadkaabaaaabaaaaaackaabaaa
abaaaaaadcaaaaajicaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaackaabaaa
abaaaaaadcaaaaakccaabaaaabaaaaaadkaabaaaabaaaaaackaabaaaabaaaaaa
bkaabaiaebaaaaaaabaaaaaadiaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaa
bkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaa
abaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaa
aeaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaa
acaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaaaeaaaaaakgbkbaaa
acaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaa
aeaaaaaafgbfbaaaacaaaaaaegacbaaaadaaaaaadiaaaaahhcaabaaaadaaaaaa
kgakbaaaabaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaaggakbaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaaeaaaaaa
egacbaaaaeaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaaeaaaaaa
egacbaaaafaaaaaakgbkbaaaacaaaaaaegacbaaaaeaaaaaaefaaaaajpcaabaaa
afaaaaaacgakbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaj
hcaabaaaaeaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaaaeaaaaaa
dcaaaaajncaabaaaabaaaaaaagajbaaaaeaaaaaaagaabaaaabaaaaaaagajbaaa
adaaaaaaaaaaaaakicaabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaaajaaaaaa
akiacaaaaaaaaaaaakaaaaaaaoaaaaakicaabaaaacaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpdkaabaaaacaaaaaaaaaaaaajdcaabaaaadaaaaaa
fgbfbaaaadaaaaaangifcaiaebaaaaaaaaaaaaaaajaaaaaadicaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaabkaabaaaadaaaaaadcaaaaajccaabaaaadaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaabkaabaaaadaaaaaaaaaaaaakccaabaaaadaaaaaabkiacaia
ebaaaaaaaaaaaaaaajaaaaaackiacaaaaaaaaaaaajaaaaaaaoaaaaakccaabaaa
adaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaadaaaaaa
dicaaaahbcaabaaaadaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaaj
ccaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaea
diaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaak
icaabaaaacaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadkaabaiaebaaaaaa
acaaaaaadiaaaaahbcaabaaaadaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaa
diaaaaahicaabaaaacaaaaaabkaabaaaaaaaaaaadkaabaaaacaaaaaaefaaaaaj
pcaabaaaaeaaaaaaggakbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaaeaaaaaa
diaaaaahocaabaaaadaaaaaaagajbaaaaeaaaaaaagbabaaaacaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaaeaaaaaa
dcaaaaajocaabaaaadaaaaaaagajbaaaaeaaaaaakgbkbaaaacaaaaaafgaobaaa
adaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaaeaaaaaadcaaaaajocaabaaaadaaaaaaagajbaaaaeaaaaaafgbfbaaa
acaaaaaafgaobaaaadaaaaaadcaaaaajncaabaaaabaaaaaafgaobaaaadaaaaaa
agaabaaaadaaaaaaagaobaaaabaaaaaaaaaaaaakbcaabaaaadaaaaaabkiacaia
ebaaaaaaaaaaaaaaakaaaaaackiacaaaaaaaaaaaakaaaaaaaoaaaaakbcaabaaa
adaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaadaaaaaa
aaaaaaajccaabaaaadaaaaaabkbabaaaadaaaaaabkiacaiaebaaaaaaaaaaaaaa
akaaaaaadicaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaa
dcaaaaajccaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaa
aaaaeaeadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaa
diaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaadiaaaaah
gcaabaaaaaaaaaaafgagbaaaaaaaaaaaagaabaaaadaaaaaaefaaaaajpcaabaaa
adaaaaaaggakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaagaaaaaadiaaaaah
hcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaagaaaaaaefaaaaaj
pcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaagaaaaaa
dcaaaaajhcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaa
adaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaa
egacbaaaacaaaaaadcaaaaajncaabaaaabaaaaaaagajbaaaacaaaaaakgakbaaa
aaaaaaaaagaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaa
pgipcaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaa
eghobaaaaeaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaa
adaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaa
eghobaaaaeaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaafaaaaaacgakbaaa
acaaaaaaeghobaaaaeaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaa
acaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaadcaaaaaj
ncaabaaaabaaaaaaagajbaaaacaaaaaaagaabaaaaaaaaaaaagaobaaaabaaaaaa
diaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaahaaaaaa
efaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaafaaaaaaaagabaaa
adaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaa
efaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaafaaaaaaaagabaaa
adaaaaaaefaaaaajpcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaafaaaaaa
aagabaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaa
acaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaa
fgbfbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
acaaaaaafgafbaaaabaaaaaaigadbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaa
egbcbaaaabaaaaaafgifcaaaaaaaaaaaahaaaaaaefaaaaajpcaabaaaadaaaaaa
ggakbaaaacaaaaaaeghobaaaagaaaaaaaagabaaaafaaaaaadiaaaaahhcaabaaa
adaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaa
egaabaaaacaaaaaaeghobaaaagaaaaaaaagabaaaafaaaaaaefaaaaajpcaabaaa
afaaaaaacgakbaaaacaaaaaaeghobaaaagaaaaaaaagabaaaafaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaa
dcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaa
acaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaapgapbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaakgikcaaa
aaaaaaaaahaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaa
ahaaaaaaaagabaaaahaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaa
agbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaa
ahaaaaaaaagabaaaahaaaaaaefaaaaajpcaabaaaacaaaaaacgakbaaaacaaaaaa
eghobaaaahaaaaaaaagabaaaahaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaa
aeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaacaaaaaafgbfbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaacaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaiaebaaaaaa
aeaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
egbcbaaaaeaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaabaaaaaafgifcaaa
aaaaaaaaafaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaaeghobaaa
aiaaaaaaaagabaaaaiaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
agbabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaa
aiaaaaaaaagabaaaaiaaaaaaefaaaaajpcaabaaaabaaaaaacgakbaaaabaaaaaa
eghobaaaaiaaaaaaaagabaaaaiaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaa
adaaaaaakgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaa
egacbaaaabaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaakicaabaaa
aaaaaaaackiacaiaebaaaaaaaaaaaaaaafaaaaaadkiacaaaaaaaaaaaafaaaaaa
aoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
dkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaackbabaaaadaaaaaackiacaia
ebaaaaaaaaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakbabaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
afaaaaaaeghobaaaajaaaaaaaagabaaaajaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaapgapbaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaagiccabaaaaaaaaaaadkiacaaaaaaaaaaaakaaaaaa
doaaaaab"
				}
				SubProgram "opengl " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
					}
					Float 0[_texTiling]
					Float 1[_texPower]
					Float 2[_groundTexStart]
					Float 3[_groundTexEnd]
					Float 4[_steepTiling]
					Float 5[_steepTexStart]
					Float 6[_steepTexEnd]
					Float 7[_multiPower]
					Float 8[_deepMultiFactor]
					Float 9[_mainMultiFactor]
					Float 10[_highMultiFactor]
					Float 11[_snowMultiFactor]
					Float 12[_deepStart]
					Float 13[_deepEnd]
					Float 14[_mainLoStart]
					Float 15[_mainLoEnd]
					Float 16[_mainHiStart]
					Float 17[_mainHiEnd]
					Float 18[_hiLoStart]
					Float 19[_hiLoEnd]
					Float 20[_hiHiStart]
					Float 21[_hiHiEnd]
					Float 22[_snowStart]
					Float 23[_snowEnd]
					Float 24[_PlanetOpacity]
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 1
					SetTexture 2[_highTex] 2D 2
					SetTexture 3[_snowTex] 2D 3
					SetTexture 4[_deepMultiTex] 2D 4
					SetTexture 5[_mainMultiTex] 2D 5
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[unity_Lightmap] 2D 9
					SetTexture 10[unity_LightmapInd] 2D 10 "3.0-!!ARBfp1.0
PARAM c[27] = { program.local[0..24],
		{ 0.57735026, 8, 2, 3 },
		{ 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.x, c[2];
ADD R0.x, -R0, c[3];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].z, -c[2];
MUL_SAT R0.w, R0.x, R0.y;
MUL R3.xyz, fragment.texcoord[0], c[0].x;
MAD R1.x, -R0.w, c[25].z, c[25].w;
MUL R0.w, R0, R0;
MOV R2.w, c[12].x;
ADD R2.w, -R2, c[13].x;
RCP R4.x, R2.w;
ADD R2.w, fragment.texcoord[2].y, -c[12].x;
MUL_SAT R2.w, R2, R4.x;
TEX R0.xyz, R3.zyzw, texture[1], 2D;
MUL R0.w, R0, R1.x;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[1], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R0, R1;
ADD R0.x, -R0.w, c[26];
MOV R0.z, c[16].x;
ADD R0.z, -R0, c[17].x;
RCP R1.w, R0.z;
ADD R0.z, fragment.texcoord[2].y, -c[16].x;
MUL_SAT R1.w, R0.z, R1;
MOV R0.y, c[14].x;
ADD R0.y, -R0, c[15].x;
RCP R0.z, R0.y;
ADD R0.y, fragment.texcoord[2], -c[14].x;
MUL_SAT R0.y, R0, R0.z;
MUL R0.w, R0, c[7].x;
MAD R2.x, -R1.w, c[25].z, c[25].w;
MUL R0.z, R1.w, R1.w;
MUL R1.w, R0.z, R2.x;
MUL R0.z, R0.y, R0.y;
MAD R0.y, -R0, c[25].z, c[25].w;
MAD R3.w, R0.z, R0.y, -R1;
MUL R1.w, R0.x, c[1].x;
MUL R2.x, R1.w, R3.w;
TEX R0.xyz, R3.zxzw, texture[1], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R0, R1;
MUL R1.xyz, R0, R2.x;
TEX R2.xyz, R3.zyzw, texture[0], 2D;
TEX R0.xyz, R3, texture[0], 2D;
MUL R2.xyz, fragment.texcoord[1].x, R2;
MAD R2.xyz, fragment.texcoord[1].z, R0, R2;
MAD R0.y, -R2.w, c[25].z, c[25].w;
MUL R0.x, R2.w, R2.w;
MAD R4.x, -R0, R0.y, c[26];
TEX R0.xyz, R3.zxzw, texture[0], 2D;
MUL R2.w, R1, R4.x;
MAD R2.xyz, fragment.texcoord[1].y, R0, R2;
TEX R0.xyz, R3.zyzw, texture[2], 2D;
MAD R2.xyz, R2, R2.w, R1;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[2], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R0, R1;
MOV R0.y, c[20].x;
ADD R0.y, -R0, c[21].x;
RCP R0.z, R0.y;
ADD R0.y, fragment.texcoord[2], -c[20].x;
MUL_SAT R0.z, R0.y, R0;
MOV R0.x, c[18];
ADD R0.x, -R0, c[19];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].y, -c[18];
MUL_SAT R0.x, R0, R0.y;
MAD R2.w, -R0.z, c[25].z, c[25];
MUL R0.y, R0.z, R0.z;
MUL R0.z, R0.y, R2.w;
MUL R0.y, R0.x, R0.x;
MAD R0.x, -R0, c[25].z, c[25].w;
MAD R2.w, R0.y, R0.x, -R0.z;
TEX R0.xyz, R3.zxzw, texture[2], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R0, R1;
MUL R1.x, R1.w, R2.w;
MAD R2.xyz, R0, R1.x, R2;
TEX R1.xyz, R3.zyzw, texture[3], 2D;
TEX R0.xyz, R3, texture[3], 2D;
MUL R1.xyz, fragment.texcoord[1].x, R1;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[3], 2D;
MOV R3.y, c[22].x;
ADD R3.y, -R3, c[23].x;
MAD R1.xyz, fragment.texcoord[1].y, R1, R0;
RCP R3.y, R3.y;
ADD R3.x, fragment.texcoord[2].y, -c[22];
MUL_SAT R3.x, R3, R3.y;
MAD R0.y, -R3.x, c[25].z, c[25].w;
MUL R0.x, R3, R3;
MUL R4.y, R0.x, R0;
MUL R3.xyz, fragment.texcoord[0], c[8].x;
MUL R4.z, R1.w, R4.y;
TEX R0.xyz, R3.zyzw, texture[4], 2D;
MAD R2.xyz, R1, R4.z, R2;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[4], 2D;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[4], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R1, R0;
MUL R1.xyz, fragment.texcoord[0], c[9].x;
MUL R4.x, R0.w, R4;
MAD R0.xyz, R0, R4.x, R2;
TEX R3.xyz, R1.zyzw, texture[5], 2D;
TEX R2.xyz, R1, texture[5], 2D;
MUL R3.xyz, fragment.texcoord[1].x, R3;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[5], 2D;
MAD R3.xyz, fragment.texcoord[1].y, R1, R2;
MUL R1.xyz, fragment.texcoord[0], c[10].x;
MUL R3.w, R0, R3;
TEX R2.xyz, R1.zyzw, texture[6], 2D;
MAD R0.xyz, R3, R3.w, R0;
MUL R3.xyz, fragment.texcoord[1].x, R2;
TEX R2.xyz, R1, texture[6], 2D;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[6], 2D;
MAD R3.xyz, fragment.texcoord[1].y, R1, R2;
MUL R1.xyz, fragment.texcoord[0], c[11].x;
MUL R2.w, R0, R2;
TEX R2.xyz, R1.zyzw, texture[7], 2D;
MAD R0.xyz, R3, R2.w, R0;
MUL R3.xyz, fragment.texcoord[1].x, R2;
TEX R2.xyz, R1, texture[7], 2D;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[7], 2D;
MAD R1.xyz, fragment.texcoord[1].y, R1, R2;
MUL R2.x, R0.w, R4.y;
MAD R0.xyz, R1, R2.x, R0;
MAD R2.xyz, fragment.texcoord[3], R0, -fragment.texcoord[3];
MUL R1.xyz, fragment.texcoord[0], c[4].x;
ADD R0.w, R1, R0;
MAD R3.xyz, R0.w, R2, fragment.texcoord[3];
TEX R0.xyz, R1.zyzw, texture[8], 2D;
MUL R2.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R1, texture[8], 2D;
MAD R0.xyz, fragment.texcoord[1].z, R0, R2;
TEX R1.xyz, R1.zxzw, texture[8], 2D;
MAD R1.xyz, R1, fragment.texcoord[1].y, R0;
MOV R0.w, c[5].x;
ADD R0.x, -R0.w, c[6];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].z, -c[5];
MUL_SAT R1.w, R0.x, R0.y;
MAD R2.x, -R1.w, c[25].z, c[25].w;
TEX R0, fragment.texcoord[4], texture[10], 2D;
MUL R1.w, R1, R1;
MAD R1.w, -R1, R2.x, c[26].x;
MUL R0.xyz, R0.w, R0;
MUL R0.w, fragment.texcoord[2].x, R1;
MUL R2.xyz, R0, c[25].x;
ADD R1.xyz, R1, -R3;
MAD R1.xyz, R0.w, R1, R3;
TEX R0, fragment.texcoord[4], texture[9], 2D;
DP3 R1.w, R2, c[25].y;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, R1.w;
MUL R0.xyz, R0, R1;
MUL result.color.xyz, R0, c[25].y;
MOV result.color.w, c[24].x;
END
# 159 instructions, 5 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
					}
					Float 0[_texTiling]
					Float 1[_texPower]
					Float 2[_groundTexStart]
					Float 3[_groundTexEnd]
					Float 4[_steepTiling]
					Float 5[_steepTexStart]
					Float 6[_steepTexEnd]
					Float 7[_multiPower]
					Float 8[_deepMultiFactor]
					Float 9[_mainMultiFactor]
					Float 10[_highMultiFactor]
					Float 11[_snowMultiFactor]
					Float 12[_deepStart]
					Float 13[_deepEnd]
					Float 14[_mainLoStart]
					Float 15[_mainLoEnd]
					Float 16[_mainHiStart]
					Float 17[_mainHiEnd]
					Float 18[_hiLoStart]
					Float 19[_hiLoEnd]
					Float 20[_hiHiStart]
					Float 21[_hiHiEnd]
					Float 22[_snowStart]
					Float 23[_snowEnd]
					Float 24[_PlanetOpacity]
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 1
					SetTexture 2[_highTex] 2D 2
					SetTexture 3[_snowTex] 2D 3
					SetTexture 4[_deepMultiTex] 2D 4
					SetTexture 5[_mainMultiTex] 2D 5
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[unity_Lightmap] 2D 9
					SetTexture 10[unity_LightmapInd] 2D 10 "ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
dcl_2d s8
dcl_2d s9
dcl_2d s10
def c25, 0.57735026, 8.00000000, 2.00000000, 3.00000000
def c26, 1.00000000, 0, 0, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xy
mov r0.x, c3
add r0.w, -c2.x, r0.x
mul r0.xyz, v0, c0.x
rcp r1.x, r0.w
texld r3.xyz, r0.zyzw, s0
add r0.w, v2.z, -c2.x
mul_sat r0.w, r0, r1.x
texld r1.xyz, r0.zyzw, s1
mad r1.w, -r0, c25.z, c25
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s1
mad r2.xyz, v1.z, r1, r2
mul r0.w, r0, r0
mul r0.w, r0, r1
add r1.x, -r0.w, c26
mov r1.z, c17.x
add r1.z, -c16.x, r1
rcp r1.w, r1.z
add r1.z, v2.y, -c16.x
mul_sat r1.w, r1.z, r1
mov r1.y, c15.x
add r1.y, -c14.x, r1
rcp r1.z, r1.y
add r1.y, v2, -c14.x
mul_sat r1.y, r1, r1.z
mul r0.w, r0, c7.x
mad r2.w, -r1, c25.z, c25
mul r1.z, r1.w, r1.w
mul r1.w, r1.z, r2
mul r1.z, r1.y, r1.y
mad r1.y, -r1, c25.z, c25.w
mad r3.w, r1.z, r1.y, -r1
mul r1.w, r1.x, c1.x
mul r2.w, r1, r3
texld r1.xyz, r0.zxzw, s1
mad r1.xyz, v1.y, r1, r2
mul r2.xyz, r1, r2.w
mov r2.w, c13.x
add r2.w, -c12.x, r2
rcp r4.x, r2.w
add r2.w, v2.y, -c12.x
texld r1.xyz, r0, s0
mul r3.xyz, v1.x, r3
mul_sat r2.w, r2, r4.x
mad r3.xyz, v1.z, r1, r3
mad r1.y, -r2.w, c25.z, c25.w
mul r1.x, r2.w, r2.w
mad r4.x, -r1, r1.y, c26
mul r2.w, r1, r4.x
texld r1.xyz, r0.zxzw, s0
mad r3.xyz, v1.y, r1, r3
mad r3.xyz, r3, r2.w, r2
texld r1.xyz, r0.zyzw, s2
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s2
mad r2.xyz, v1.z, r1, r2
mov r1.y, c21.x
add r1.y, -c20.x, r1
rcp r1.z, r1.y
add r1.y, v2, -c20.x
mul_sat r1.z, r1.y, r1
mov r1.x, c19
add r1.x, -c18, r1
rcp r1.y, r1.x
add r1.x, v2.y, -c18
mul_sat r1.x, r1, r1.y
mad r2.w, -r1.z, c25.z, c25
mul r1.y, r1.z, r1.z
mul r1.z, r1.y, r2.w
mul r1.y, r1.x, r1.x
mad r1.x, -r1, c25.z, c25.w
mad r2.w, r1.y, r1.x, -r1.z
texld r1.xyz, r0.zxzw, s2
mad r1.xyz, v1.y, r1, r2
mul r2.x, r1.w, r2.w
mad r2.xyz, r1, r2.x, r3
texld r1.xyz, r0.zyzw, s3
texld r3.xyz, r0, s3
mul r1.xyz, v1.x, r1
mad r1.xyz, v1.z, r3, r1
mov r0.y, c23.x
add r3.x, -c22, r0.y
rcp r3.y, r3.x
add r3.x, v2.y, -c22
texld r0.xyz, r0.zxzw, s3
mul_sat r4.y, r3.x, r3
mad r3.xyz, v1.y, r0, r1
mad r0.y, -r4, c25.z, c25.w
mul r0.x, r4.y, r4.y
mul r4.y, r0.x, r0
mul r0.xyz, v0, c8.x
mul r4.z, r1.w, r4.y
mad r3.xyz, r3, r4.z, r2
texld r1.xyz, r0.zyzw, s4
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s4
mad r1.xyz, v1.z, r1, r2
texld r0.xyz, r0.zxzw, s4
mad r1.xyz, v1.y, r0, r1
mul r0.xyz, v0, c9.x
mul r4.x, r0.w, r4
texld r2.xyz, r0.zyzw, s5
mad r1.xyz, r1, r4.x, r3
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s5
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s5
mad r3.xyz, v1.y, r0, r2
mul r0.xyz, v0, c10.x
mul r3.w, r0, r3
texld r2.xyz, r0.zyzw, s6
mad r1.xyz, r3, r3.w, r1
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s6
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s6
mad r3.xyz, v1.y, r0, r2
mul r0.xyz, v0, c11.x
mul r2.w, r0, r2
texld r2.xyz, r0.zyzw, s7
mad r1.xyz, r3, r2.w, r1
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s7
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s7
mad r0.xyz, v1.y, r0, r2
mul r2.x, r0.w, r4.y
mad r0.xyz, r0, r2.x, r1
mad r2.xyz, v3, r0, -v3
mul r0.xyz, v0, c4.x
add r0.w, r1, r0
mad r3.xyz, r0.w, r2, v3
texld r1.xyz, r0.zyzw, s8
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s8
texld r0.xyz, r0.zxzw, s8
mad r1.xyz, v1.z, r1, r2
mad r1.xyz, r0, v1.y, r1
mov r0.w, c6.x
add r0.x, -c5, r0.w
rcp r0.y, r0.x
add r0.x, v2.z, -c5
mul_sat r1.w, r0.x, r0.y
mad r2.x, -r1.w, c25.z, c25.w
texld r0, v4, s10
mul r1.w, r1, r1
mad r1.w, -r1, r2.x, c26.x
mul_pp r0.xyz, r0.w, r0
mul r0.w, v2.x, r1
mul_pp r2.xyz, r0, c25.x
add r1.xyz, r1, -r3
mad r1.xyz, r0.w, r1, r3
texld r0, v4, s9
dp3_pp r1.w, r2, c25.y
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, r1.w
mul_pp r0.xyz, r0, r1
mul_pp oC0.xyz, r0, c25.y
mov_pp oC0.w, c24.x
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
					}
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 2
					SetTexture 2[_highTex] 2D 4
					SetTexture 3[_snowTex] 2D 6
					SetTexture 4[_deepMultiTex] 2D 1
					SetTexture 5[_mainMultiTex] 2D 3
					SetTexture 6[_highMultiTex] 2D 5
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[unity_Lightmap] 2D 9
					SetTexture 10[unity_LightmapInd] 2D 10
					ConstBuffer "$Globals"
					208
					Float 64[_texTiling]
					Float 68[_texPower]
					Float 72[_groundTexStart]
					Float 76[_groundTexEnd]
					Float 84[_steepTiling]
					Float 88[_steepTexStart]
					Float 92[_steepTexEnd]
					Float 104[_multiPower]
					Float 108[_deepMultiFactor]
					Float 112[_mainMultiFactor]
					Float 116[_highMultiFactor]
					Float 120[_snowMultiFactor]
					Float 124[_deepStart]
					Float 128[_deepEnd]
					Float 132[_mainLoStart]
					Float 136[_mainLoEnd]
					Float 140[_mainHiStart]
					Float 144[_mainHiEnd]
					Float 148[_hiLoStart]
					Float 152[_hiLoEnd]
					Float 156[_hiHiStart]
					Float 160[_hiHiEnd]
					Float 164[_snowStart]
					Float 168[_snowEnd]
					Float 172[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0
eefieceddbaggjpgajplgdblijmlkmlhfkhoighnabaaaaaagabgaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefceabfaaaa
eaaaaaaafaafaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaa
fkaaaaadaagabaaaagaaaaaafkaaaaadaagabaaaahaaaaaafkaaaaadaagabaaa
aiaaaaaafkaaaaadaagabaaaajaaaaaafkaaaaadaagabaaaakaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaae
aahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaafibiaaae
aahabaaaagaaaaaaffffaaaafibiaaaeaahabaaaahaaaaaaffffaaaafibiaaae
aahabaaaaiaaaaaaffffaaaafibiaaaeaahabaaaajaaaaaaffffaaaafibiaaae
aahabaaaakaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaad
dcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaaaaaaaaak
bcaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaaahaaaaaaakiacaaaaaaaaaaa
aiaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpakaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaabkbabaaaadaaaaaa
dkiacaiaebaaaaaaaaaaaaaaahaaaaaadicaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaakccaabaaaaaaaaaaa
ckiacaiaebaaaaaaaaaaaaaaaeaaaaaadkiacaaaaaaaaaaaaeaaaaaaaoaaaaak
ccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaa
aaaaaaaaaaaaaaajecaabaaaaaaaaaaackbabaaaadaaaaaackiacaiaebaaaaaa
aaaaaaaaaeaaaaaadicaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaa
aaaaaaaadcaaaaakicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaackiacaaa
aaaaaaaaagaaaaaadiaaaaaiecaabaaaaaaaaaaadkaabaaaaaaaaaaabkiacaaa
aaaaaaaaaeaaaaaadcaaaaakicaabaaaaaaaaaaabkiacaaaaaaaaaaaaeaaaaaa
dkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaackaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaaaaaaaaakccaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaa
aiaaaaaaakiacaaaaaaaaaaaajaaaaaaaoaaaaakccaabaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaabaaaaaaaaaaaaajmcaabaaa
abaaaaaafgbfbaaaadaaaaaafgincaiaebaaaaaaaaaaaaaaaiaaaaaadicaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaajicaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaaaaaaaaakicaabaaaabaaaaaa
bkiacaiaebaaaaaaaaaaaaaaaiaaaaaackiacaaaaaaaaaaaaiaaaaaaaoaaaaak
icaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaa
abaaaaaadicaaaahecaabaaaabaaaaaadkaabaaaabaaaaaackaabaaaabaaaaaa
dcaaaaajicaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
aaaaeaeadiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaackaabaaaabaaaaaa
dcaaaaakccaabaaaabaaaaaadkaabaaaabaaaaaackaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaadiaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaabkaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaaabaaaaaa
diaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaaeaaaaaa
efaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaa
efaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaa
egacbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaaaeaaaaaa
fgbfbaaaacaaaaaaegacbaaaadaaaaaadiaaaaahhcaabaaaadaaaaaakgakbaaa
abaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaaggakbaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaaeaaaaaaegacbaaa
aeaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaaeaaaaaaegacbaaa
afaaaaaakgbkbaaaacaaaaaaegacbaaaaeaaaaaaefaaaaajpcaabaaaafaaaaaa
cgakbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaa
aeaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaaaeaaaaaadcaaaaaj
ncaabaaaabaaaaaaagajbaaaaeaaaaaaagaabaaaabaaaaaaagajbaaaadaaaaaa
aaaaaaakicaabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaaajaaaaaaakiacaaa
aaaaaaaaakaaaaaaaoaaaaakicaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpdkaabaaaacaaaaaaaaaaaaajdcaabaaaadaaaaaafgbfbaaa
adaaaaaangifcaiaebaaaaaaaaaaaaaaajaaaaaadicaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaabkaabaaaadaaaaaadcaaaaajccaabaaaadaaaaaadkaabaaa
acaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaa
acaaaaaabkaabaaaadaaaaaaaaaaaaakccaabaaaadaaaaaabkiacaiaebaaaaaa
aaaaaaaaajaaaaaackiacaaaaaaaaaaaajaaaaaaaoaaaaakccaabaaaadaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaadaaaaaadicaaaah
bcaabaaaadaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaajccaabaaa
adaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaah
bcaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaakicaabaaa
acaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadkaabaiaebaaaaaaacaaaaaa
diaaaaahbcaabaaaadaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaadiaaaaah
icaabaaaacaaaaaabkaabaaaaaaaaaaadkaabaaaacaaaaaaefaaaaajpcaabaaa
aeaaaaaaggakbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaaeaaaaaadiaaaaah
ocaabaaaadaaaaaaagajbaaaaeaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaaeaaaaaadcaaaaaj
ocaabaaaadaaaaaaagajbaaaaeaaaaaakgbkbaaaacaaaaaafgaobaaaadaaaaaa
efaaaaajpcaabaaaaeaaaaaacgakbaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
aeaaaaaadcaaaaajocaabaaaadaaaaaaagajbaaaaeaaaaaafgbfbaaaacaaaaaa
fgaobaaaadaaaaaadcaaaaajncaabaaaabaaaaaafgaobaaaadaaaaaaagaabaaa
adaaaaaaagaobaaaabaaaaaaaaaaaaakbcaabaaaadaaaaaabkiacaiaebaaaaaa
aaaaaaaaakaaaaaackiacaaaaaaaaaaaakaaaaaaaoaaaaakbcaabaaaadaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaadaaaaaaaaaaaaaj
ccaabaaaadaaaaaabkbabaaaadaaaaaabkiacaiaebaaaaaaaaaaaaaaakaaaaaa
dicaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaadcaaaaaj
ccaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaea
diaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaadiaaaaah
bcaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaadiaaaaahgcaabaaa
aaaaaaaafgagbaaaaaaaaaaaagaabaaaadaaaaaaefaaaaajpcaabaaaadaaaaaa
ggakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaagaaaaaadiaaaaahhcaabaaa
adaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaa
egaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaagaaaaaaefaaaaajpcaabaaa
afaaaaaacgakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaagaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaa
dcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaa
acaaaaaadcaaaaajncaabaaaabaaaaaaagajbaaaacaaaaaakgakbaaaaaaaaaaa
agaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaapgipcaaa
aaaaaaaaagaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaa
aeaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaa
agbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaa
aeaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaafaaaaaacgakbaaaacaaaaaa
eghobaaaaeaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaa
aeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajncaabaaa
abaaaaaaagajbaaaacaaaaaaagaabaaaaaaaaaaaagaobaaaabaaaaaadiaaaaai
hcaabaaaacaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaahaaaaaaefaaaaaj
pcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaafaaaaaaaagabaaaadaaaaaa
diaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaafaaaaaaaagabaaaadaaaaaa
efaaaaajpcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaafaaaaaaaagabaaa
adaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaa
egacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaa
acaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaa
fgafbaaaabaaaaaaigadbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaa
abaaaaaafgifcaaaaaaaaaaaahaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaa
acaaaaaaeghobaaaagaaaaaaaagabaaaafaaaaaadiaaaaahhcaabaaaadaaaaaa
egacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
acaaaaaaeghobaaaagaaaaaaaagabaaaafaaaaaaefaaaaajpcaabaaaafaaaaaa
cgakbaaaacaaaaaaeghobaaaagaaaaaaaagabaaaafaaaaaadcaaaaajhcaabaaa
acaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaa
dcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaapgapbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaakgikcaaaaaaaaaaa
ahaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaahaaaaaa
aagabaaaahaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaa
acaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaahaaaaaa
aagabaaaahaaaaaaefaaaaajpcaabaaaacaaaaaacgakbaaaacaaaaaaeghobaaa
ahaaaaaaaagabaaaahaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaaaeaaaaaa
kgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaa
acaaaaaafgbfbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaacaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaiaebaaaaaaaeaaaaaa
dcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaa
aeaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaabaaaaaafgifcaaaaaaaaaaa
afaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaaeghobaaaaiaaaaaa
aagabaaaaiaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaagbabaaa
acaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaaaiaaaaaa
aagabaaaaiaaaaaaefaaaaajpcaabaaaabaaaaaacgakbaaaabaaaaaaeghobaaa
aiaaaaaaaagabaaaaiaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaadaaaaaa
kgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
abaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaaabaaaaaa
egacbaiaebaaaaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaakicaabaaaaaaaaaaa
ckiacaiaebaaaaaaaaaaaaaaafaaaaaadkiacaaaaaaaaaaaafaaaaaaaoaaaaak
icaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaa
aaaaaaaaaaaaaaajicaabaaaabaaaaaackbabaaaadaaaaaackiacaiaebaaaaaa
aaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akbabaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaafaaaaaa
eghobaaaakaaaaaaaagabaaaakaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaaaaaaaaabaaaaaakicaabaaaaaaaaaaaaceaaaaadkmnbddpdkmnbddp
dkmnbddpaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
afaaaaaaeghobaaaajaaaaaaaagabaaaajaaaaaadiaaaaahicaabaaaabaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaapgapbaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaagiccabaaaaaaaaaaadkiacaaaaaaaaaaaakaaaaaadoaaaaab
"
				}
				SubProgram "opengl " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
					}
					Vector 0[_LightColor0]
					Float 1[_texTiling]
					Float 2[_texPower]
					Float 3[_groundTexStart]
					Float 4[_groundTexEnd]
					Float 5[_steepTiling]
					Float 6[_steepTexStart]
					Float 7[_steepTexEnd]
					Float 8[_multiPower]
					Float 9[_deepMultiFactor]
					Float 10[_mainMultiFactor]
					Float 11[_highMultiFactor]
					Float 12[_snowMultiFactor]
					Float 13[_deepStart]
					Float 14[_deepEnd]
					Float 15[_mainLoStart]
					Float 16[_mainLoEnd]
					Float 17[_mainHiStart]
					Float 18[_mainHiEnd]
					Float 19[_hiLoStart]
					Float 20[_hiLoEnd]
					Float 21[_hiHiStart]
					Float 22[_hiHiEnd]
					Float 23[_snowStart]
					Float 24[_snowEnd]
					Float 25[_PlanetOpacity]
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 1
					SetTexture 2[_highTex] 2D 2
					SetTexture 3[_snowTex] 2D 3
					SetTexture 4[_deepMultiTex] 2D 4
					SetTexture 5[_mainMultiTex] 2D 5
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[_ShadowMapTexture] 2D 9 "3.0-!!ARBfp1.0
PARAM c[27] = { program.local[0..25],
		{ 0, 2, 3, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.x, c[3];
ADD R0.x, -R0, c[4];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].z, -c[3];
MUL_SAT R0.w, R0.x, R0.y;
MUL R3.xyz, fragment.texcoord[0], c[1].x;
MAD R1.x, -R0.w, c[26].y, c[26].z;
MUL R0.w, R0, R0;
MOV R2.w, c[13].x;
ADD R2.w, -R2, c[14].x;
RCP R4.x, R2.w;
ADD R2.w, fragment.texcoord[2].y, -c[13].x;
MUL_SAT R2.w, R2, R4.x;
TEX R0.xyz, R3.zyzw, texture[1], 2D;
MUL R0.w, R0, R1.x;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[1], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R0, R1;
ADD R0.x, -R0.w, c[26].w;
MOV R0.z, c[17].x;
ADD R0.z, -R0, c[18].x;
RCP R1.w, R0.z;
ADD R0.z, fragment.texcoord[2].y, -c[17].x;
MUL_SAT R1.w, R0.z, R1;
MOV R0.y, c[15].x;
ADD R0.y, -R0, c[16].x;
RCP R0.z, R0.y;
ADD R0.y, fragment.texcoord[2], -c[15].x;
MUL_SAT R0.y, R0, R0.z;
MUL R0.w, R0, c[8].x;
MAD R2.x, -R1.w, c[26].y, c[26].z;
MUL R0.z, R1.w, R1.w;
MUL R1.w, R0.z, R2.x;
MUL R0.z, R0.y, R0.y;
MAD R0.y, -R0, c[26], c[26].z;
MAD R3.w, R0.z, R0.y, -R1;
MUL R1.w, R0.x, c[2].x;
MUL R2.x, R1.w, R3.w;
TEX R0.xyz, R3.zxzw, texture[1], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R0, R1;
MUL R1.xyz, R0, R2.x;
TEX R2.xyz, R3.zyzw, texture[0], 2D;
TEX R0.xyz, R3, texture[0], 2D;
MUL R2.xyz, fragment.texcoord[1].x, R2;
MAD R2.xyz, fragment.texcoord[1].z, R0, R2;
MAD R0.y, -R2.w, c[26], c[26].z;
MUL R0.x, R2.w, R2.w;
MAD R4.x, -R0, R0.y, c[26].w;
TEX R0.xyz, R3.zxzw, texture[0], 2D;
MUL R2.w, R1, R4.x;
MAD R2.xyz, fragment.texcoord[1].y, R0, R2;
TEX R0.xyz, R3.zyzw, texture[2], 2D;
MAD R2.xyz, R2, R2.w, R1;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[2], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R0, R1;
MOV R0.y, c[21].x;
ADD R0.y, -R0, c[22].x;
RCP R0.z, R0.y;
ADD R0.y, fragment.texcoord[2], -c[21].x;
MUL_SAT R0.z, R0.y, R0;
MOV R0.x, c[19];
ADD R0.x, -R0, c[20];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].y, -c[19];
MUL_SAT R0.x, R0, R0.y;
MAD R2.w, -R0.z, c[26].y, c[26].z;
MUL R0.y, R0.z, R0.z;
MUL R0.z, R0.y, R2.w;
MUL R0.y, R0.x, R0.x;
MAD R0.x, -R0, c[26].y, c[26].z;
MAD R2.w, R0.y, R0.x, -R0.z;
TEX R0.xyz, R3.zxzw, texture[2], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R0, R1;
MUL R1.x, R1.w, R2.w;
MAD R2.xyz, R0, R1.x, R2;
TEX R1.xyz, R3.zyzw, texture[3], 2D;
TEX R0.xyz, R3, texture[3], 2D;
MUL R1.xyz, fragment.texcoord[1].x, R1;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[3], 2D;
MOV R3.y, c[23].x;
ADD R3.y, -R3, c[24].x;
MAD R1.xyz, fragment.texcoord[1].y, R1, R0;
RCP R3.y, R3.y;
ADD R3.x, fragment.texcoord[2].y, -c[23];
MUL_SAT R3.x, R3, R3.y;
MAD R0.y, -R3.x, c[26], c[26].z;
MUL R0.x, R3, R3;
MUL R4.y, R0.x, R0;
MUL R3.xyz, fragment.texcoord[0], c[9].x;
MUL R4.z, R1.w, R4.y;
TEX R0.xyz, R3.zyzw, texture[4], 2D;
MAD R2.xyz, R1, R4.z, R2;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[4], 2D;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[4], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R1, R0;
MUL R1.xyz, fragment.texcoord[0], c[10].x;
MUL R4.x, R0.w, R4;
MAD R0.xyz, R0, R4.x, R2;
TEX R3.xyz, R1.zyzw, texture[5], 2D;
TEX R2.xyz, R1, texture[5], 2D;
MUL R3.xyz, fragment.texcoord[1].x, R3;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[5], 2D;
MAD R3.xyz, fragment.texcoord[1].y, R1, R2;
MUL R1.xyz, fragment.texcoord[0], c[11].x;
MUL R3.w, R0, R3;
TEX R2.xyz, R1.zyzw, texture[6], 2D;
MAD R0.xyz, R3, R3.w, R0;
MUL R3.xyz, fragment.texcoord[1].x, R2;
TEX R2.xyz, R1, texture[6], 2D;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[6], 2D;
MAD R3.xyz, fragment.texcoord[1].y, R1, R2;
MUL R1.xyz, fragment.texcoord[0], c[12].x;
MUL R2.w, R0, R2;
TEX R2.xyz, R1.zyzw, texture[7], 2D;
MAD R0.xyz, R3, R2.w, R0;
MUL R3.xyz, fragment.texcoord[1].x, R2;
TEX R2.xyz, R1, texture[7], 2D;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[7], 2D;
MAD R1.xyz, fragment.texcoord[1].y, R1, R2;
MUL R2.x, R0.w, R4.y;
MAD R0.xyz, R1, R2.x, R0;
MAD R1.xyz, fragment.texcoord[3], R0, -fragment.texcoord[3];
ADD R0.x, R1.w, R0.w;
MOV R0.w, c[6].x;
ADD R0.w, -R0, c[7].x;
RCP R1.w, R0.w;
ADD R0.w, fragment.texcoord[2].z, -c[6].x;
MAD R2.xyz, R0.x, R1, fragment.texcoord[3];
MUL R3.xyz, fragment.texcoord[0], c[5].x;
TEX R1.xyz, R3.zyzw, texture[8], 2D;
MUL R1.xyz, fragment.texcoord[1].x, R1;
TEX R0.xyz, R3, texture[8], 2D;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[8], 2D;
MAD R0.xyz, R1, fragment.texcoord[1].y, R0;
MUL_SAT R0.w, R0, R1;
MAD R1.x, -R0.w, c[26].y, c[26].z;
MUL R0.w, R0, R0;
MAD R0.w, -R0, R1.x, c[26];
ADD R1.xyz, R0, -R2;
MUL R0.x, fragment.texcoord[2], R0.w;
MAD R0.xyz, R0.x, R1, R2;
MUL R1.xyz, R0, fragment.texcoord[5];
MUL R2.xyz, R0, c[0];
MAX R0.y, fragment.texcoord[4].z, c[26].x;
TXP R0.x, fragment.texcoord[6], texture[9], 2D;
MUL R0.x, R0.y, R0;
MUL R0.xyz, R0.x, R2;
MAD result.color.xyz, R0, c[26].y, R1;
MOV result.color.w, c[25].x;
END
# 157 instructions, 5 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
					}
					Vector 0[_LightColor0]
					Float 1[_texTiling]
					Float 2[_texPower]
					Float 3[_groundTexStart]
					Float 4[_groundTexEnd]
					Float 5[_steepTiling]
					Float 6[_steepTexStart]
					Float 7[_steepTexEnd]
					Float 8[_multiPower]
					Float 9[_deepMultiFactor]
					Float 10[_mainMultiFactor]
					Float 11[_highMultiFactor]
					Float 12[_snowMultiFactor]
					Float 13[_deepStart]
					Float 14[_deepEnd]
					Float 15[_mainLoStart]
					Float 16[_mainLoEnd]
					Float 17[_mainHiStart]
					Float 18[_mainHiEnd]
					Float 19[_hiLoStart]
					Float 20[_hiLoEnd]
					Float 21[_hiHiStart]
					Float 22[_hiHiEnd]
					Float 23[_snowStart]
					Float 24[_snowEnd]
					Float 25[_PlanetOpacity]
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 1
					SetTexture 2[_highTex] 2D 2
					SetTexture 3[_snowTex] 2D 3
					SetTexture 4[_deepMultiTex] 2D 4
					SetTexture 5[_mainMultiTex] 2D 5
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[_ShadowMapTexture] 2D 9 "ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
dcl_2d s8
dcl_2d s9
def c26, 0.00000000, 2.00000000, 3.00000000, 1.00000000
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6
mov r0.x, c4
add r0.w, -c3.x, r0.x
mul r0.xyz, v0, c1.x
rcp r1.x, r0.w
texld r3.xyz, r0.zyzw, s0
add r0.w, v2.z, -c3.x
mul_sat r0.w, r0, r1.x
texld r1.xyz, r0.zyzw, s1
mad r1.w, -r0, c26.y, c26.z
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s1
mad r2.xyz, v1.z, r1, r2
mul r0.w, r0, r0
mul r0.w, r0, r1
add r1.x, -r0.w, c26.w
mov r1.z, c18.x
add r1.z, -c17.x, r1
rcp r1.w, r1.z
add r1.z, v2.y, -c17.x
mul_sat r1.w, r1.z, r1
mov r1.y, c16.x
add r1.y, -c15.x, r1
rcp r1.z, r1.y
add r1.y, v2, -c15.x
mul_sat r1.y, r1, r1.z
mul r0.w, r0, c8.x
mad r2.w, -r1, c26.y, c26.z
mul r1.z, r1.w, r1.w
mul r1.w, r1.z, r2
mul r1.z, r1.y, r1.y
mad r1.y, -r1, c26, c26.z
mad r3.w, r1.z, r1.y, -r1
mul r1.w, r1.x, c2.x
mul r2.w, r1, r3
texld r1.xyz, r0.zxzw, s1
mad r1.xyz, v1.y, r1, r2
mul r2.xyz, r1, r2.w
mov r2.w, c14.x
add r2.w, -c13.x, r2
rcp r4.x, r2.w
add r2.w, v2.y, -c13.x
texld r1.xyz, r0, s0
mul r3.xyz, v1.x, r3
mul_sat r2.w, r2, r4.x
mad r3.xyz, v1.z, r1, r3
mad r1.y, -r2.w, c26, c26.z
mul r1.x, r2.w, r2.w
mad r4.x, -r1, r1.y, c26.w
mul r2.w, r1, r4.x
texld r1.xyz, r0.zxzw, s0
mad r3.xyz, v1.y, r1, r3
mad r3.xyz, r3, r2.w, r2
texld r1.xyz, r0.zyzw, s2
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s2
mad r2.xyz, v1.z, r1, r2
mov r1.y, c22.x
add r1.y, -c21.x, r1
rcp r1.z, r1.y
add r1.y, v2, -c21.x
mul_sat r1.z, r1.y, r1
mov r1.x, c20
add r1.x, -c19, r1
rcp r1.y, r1.x
add r1.x, v2.y, -c19
mul_sat r1.x, r1, r1.y
mad r2.w, -r1.z, c26.y, c26.z
mul r1.y, r1.z, r1.z
mul r1.z, r1.y, r2.w
mul r1.y, r1.x, r1.x
mad r1.x, -r1, c26.y, c26.z
mad r2.w, r1.y, r1.x, -r1.z
texld r1.xyz, r0.zxzw, s2
mad r1.xyz, v1.y, r1, r2
mul r2.x, r1.w, r2.w
mad r2.xyz, r1, r2.x, r3
texld r1.xyz, r0.zyzw, s3
texld r3.xyz, r0, s3
mul r1.xyz, v1.x, r1
mad r1.xyz, v1.z, r3, r1
mov r0.y, c24.x
add r3.x, -c23, r0.y
rcp r3.y, r3.x
add r3.x, v2.y, -c23
texld r0.xyz, r0.zxzw, s3
mul_sat r4.y, r3.x, r3
mad r3.xyz, v1.y, r0, r1
mad r0.y, -r4, c26, c26.z
mul r0.x, r4.y, r4.y
mul r4.y, r0.x, r0
mul r0.xyz, v0, c9.x
mul r4.z, r1.w, r4.y
mad r3.xyz, r3, r4.z, r2
texld r1.xyz, r0.zyzw, s4
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s4
mad r1.xyz, v1.z, r1, r2
texld r0.xyz, r0.zxzw, s4
mad r1.xyz, v1.y, r0, r1
mul r0.xyz, v0, c10.x
mul r4.x, r0.w, r4
texld r2.xyz, r0.zyzw, s5
mad r1.xyz, r1, r4.x, r3
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s5
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s5
mad r3.xyz, v1.y, r0, r2
mul r0.xyz, v0, c11.x
mul r3.w, r0, r3
texld r2.xyz, r0.zyzw, s6
mad r1.xyz, r3, r3.w, r1
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s6
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s6
mad r3.xyz, v1.y, r0, r2
mul r0.xyz, v0, c12.x
mul r2.w, r0, r2
texld r2.xyz, r0.zyzw, s7
mad r1.xyz, r3, r2.w, r1
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s7
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s7
mad r0.xyz, v1.y, r0, r2
mul r2.x, r0.w, r4.y
mad r0.xyz, r0, r2.x, r1
mad r1.xyz, v3, r0, -v3
mul r0.xyz, v0, c5.x
add r0.w, r1, r0
mad r3.xyz, r0.w, r1, v3
texld r1.xyz, r0.zyzw, s8
texld r2.xyz, r0, s8
mov r0.y, c7.x
add r0.w, -c6.x, r0.y
rcp r1.w, r0.w
mul r1.xyz, v1.x, r1
add r0.w, v2.z, -c6.x
mad r1.xyz, v1.z, r2, r1
texld r0.xyz, r0.zxzw, s8
mad r0.xyz, r0, v1.y, r1
mul_sat r0.w, r0, r1
mad r1.x, -r0.w, c26.y, c26.z
mul r0.w, r0, r0
mad r0.w, -r0, r1.x, c26
add r1.xyz, r0, -r3
mul r0.x, v2, r0.w
mad r0.xyz, r0.x, r1, r3
mul_pp r1.xyz, r0, v5
mul_pp r2.xyz, r0, c0
max_pp r0.y, v4.z, c26.x
texldp r0.x, v6, s9
mul_pp r0.x, r0.y, r0
mul_pp r0.xyz, r0.x, r2
mad_pp oC0.xyz, r0, c26.y, r1
mov_pp oC0.w, c25.x
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
					}
					SetTexture 0[_deepTex] 2D 1
					SetTexture 1[_mainTex] 2D 3
					SetTexture 2[_highTex] 2D 5
					SetTexture 3[_snowTex] 2D 7
					SetTexture 4[_deepMultiTex] 2D 2
					SetTexture 5[_mainMultiTex] 2D 4
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 8
					SetTexture 8[_steepTex] 2D 9
					SetTexture 9[_ShadowMapTexture] 2D 0
					ConstBuffer "$Globals"
					256
					Vector 16[_LightColor0]
					Float 128[_texTiling]
					Float 132[_texPower]
					Float 136[_groundTexStart]
					Float 140[_groundTexEnd]
					Float 148[_steepTiling]
					Float 152[_steepTexStart]
					Float 156[_steepTexEnd]
					Float 168[_multiPower]
					Float 172[_deepMultiFactor]
					Float 176[_mainMultiFactor]
					Float 180[_highMultiFactor]
					Float 184[_snowMultiFactor]
					Float 188[_deepStart]
					Float 192[_deepEnd]
					Float 196[_mainLoStart]
					Float 200[_mainLoEnd]
					Float 204[_mainHiStart]
					Float 208[_mainHiEnd]
					Float 212[_hiLoStart]
					Float 216[_hiLoEnd]
					Float 220[_hiHiStart]
					Float 224[_hiHiEnd]
					Float 228[_snowStart]
					Float 232[_snowEnd]
					Float 236[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedmdnfghncjlcpnblfbgalnllaajaicapkabaaaaaaembgaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaeaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcpmbeaaaaeaaaaaaadpafaaaafjaaaaaeegiocaaa
aaaaaaaaapaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaaagaaaaaafkaaaaad
aagabaaaahaaaaaafkaaaaadaagabaaaaiaaaaaafkaaaaadaagabaaaajaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
fibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaa
fibiaaaeaahabaaaagaaaaaaffffaaaafibiaaaeaahabaaaahaaaaaaffffaaaa
fibiaaaeaahabaaaaiaaaaaaffffaaaafibiaaaeaahabaaaajaaaaaaffffaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadecbabaaaafaaaaaagcbaaaad
hcbabaaaagaaaaaagcbaaaadlcbabaaaahaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacagaaaaaaaaaaaaakbcaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaa
alaaaaaaakiacaaaaaaaaaaaamaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaajccaabaaa
aaaaaaaabkbabaaaadaaaaaadkiacaiaebaaaaaaaaaaaaaaalaaaaaadicaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadp
aaaaaaakccaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaadkiacaaa
aaaaaaaaaiaaaaaaaoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpbkaabaaaaaaaaaaaaaaaaaajecaabaaaaaaaaaaackbabaaa
adaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaadicaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaackiacaaaaaaaaaaaakaaaaaadiaaaaaiecaabaaaaaaaaaaa
dkaabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaadcaaaaakicaabaaaaaaaaaaa
bkiacaaaaaaaaaaaaiaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
bcaabaaaabaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaakccaabaaaabaaaaaa
dkiacaiaebaaaaaaaaaaaaaaamaaaaaaakiacaaaaaaaaaaaanaaaaaaaoaaaaak
ccaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaa
abaaaaaaaaaaaaajmcaabaaaabaaaaaafgbfbaaaadaaaaaafgincaiaebaaaaaa
aaaaaaaaamaaaaaadicaaaahccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaa
abaaaaaadcaaaaajicaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaa
aaaaaaakicaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaaamaaaaaackiacaaa
aaaaaaaaamaaaaaaaoaaaaakicaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpdkaabaaaabaaaaaadicaaaahecaabaaaabaaaaaadkaabaaa
abaaaaaackaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaackaabaaaabaaaaaa
abeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahecaabaaaabaaaaaackaabaaa
abaaaaaackaabaaaabaaaaaadcaaaaakccaabaaaabaaaaaadkaabaaaabaaaaaa
ckaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaadiaaaaahecaabaaaabaaaaaa
ckaabaaaaaaaaaaabkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaa
aaaaaaaabkaabaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaa
agiacaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaadaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaa
adaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaa
aeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaa
cgakbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaajhcaabaaa
adaaaaaaegacbaaaaeaaaaaafgbfbaaaacaaaaaaegacbaaaadaaaaaadiaaaaah
hcaabaaaadaaaaaakgakbaaaabaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaa
aeaaaaaaggakbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaah
hcaabaaaaeaaaaaaegacbaaaaeaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaa
afaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaaj
hcaabaaaaeaaaaaaegacbaaaafaaaaaakgbkbaaaacaaaaaaegacbaaaaeaaaaaa
efaaaaajpcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaadcaaaaajhcaabaaaaeaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaa
egacbaaaaeaaaaaadcaaaaajncaabaaaabaaaaaaagajbaaaaeaaaaaaagaabaaa
abaaaaaaagajbaaaadaaaaaaaaaaaaakicaabaaaacaaaaaadkiacaiaebaaaaaa
aaaaaaaaanaaaaaaakiacaaaaaaaaaaaaoaaaaaaaoaaaaakicaabaaaacaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaacaaaaaaaaaaaaaj
dcaabaaaadaaaaaafgbfbaaaadaaaaaangifcaiaebaaaaaaaaaaaaaaanaaaaaa
dicaaaahicaabaaaacaaaaaadkaabaaaacaaaaaabkaabaaaadaaaaaadcaaaaaj
ccaabaaaadaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaea
diaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaabkaabaaaadaaaaaaaaaaaaakccaabaaa
adaaaaaabkiacaiaebaaaaaaaaaaaaaaanaaaaaackiacaaaaaaaaaaaanaaaaaa
aoaaaaakccaabaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
bkaabaaaadaaaaaadicaaaahbcaabaaaadaaaaaabkaabaaaadaaaaaaakaabaaa
adaaaaaadcaaaaajccaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaa
adaaaaaadcaaaaakicaabaaaacaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaa
dkaabaiaebaaaaaaacaaaaaadiaaaaahbcaabaaaadaaaaaackaabaaaaaaaaaaa
dkaabaaaacaaaaaadiaaaaahicaabaaaacaaaaaabkaabaaaaaaaaaaadkaabaaa
acaaaaaaefaaaaajpcaabaaaaeaaaaaaggakbaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaafaaaaaadiaaaaahocaabaaaadaaaaaaagajbaaaaeaaaaaaagbabaaa
acaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaafaaaaaadcaaaaajocaabaaaadaaaaaaagajbaaaaeaaaaaakgbkbaaa
acaaaaaafgaobaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaaacaaaaaa
eghobaaaacaaaaaaaagabaaaafaaaaaadcaaaaajocaabaaaadaaaaaaagajbaaa
aeaaaaaafgbfbaaaacaaaaaafgaobaaaadaaaaaadcaaaaajncaabaaaabaaaaaa
fgaobaaaadaaaaaaagaabaaaadaaaaaaagaobaaaabaaaaaaaaaaaaakbcaabaaa
adaaaaaabkiacaiaebaaaaaaaaaaaaaaaoaaaaaackiacaaaaaaaaaaaaoaaaaaa
aoaaaaakbcaabaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
akaabaaaadaaaaaaaaaaaaajccaabaaaadaaaaaabkbabaaaadaaaaaabkiacaia
ebaaaaaaaaaaaaaaaoaaaaaadicaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaa
bkaabaaaadaaaaaadcaaaaajccaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaa
akaabaaaadaaaaaadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaa
adaaaaaadiaaaaahgcaabaaaaaaaaaaafgagbaaaaaaaaaaaagaabaaaadaaaaaa
efaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaa
ahaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaa
efaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaa
ahaaaaaaefaaaaajpcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaadaaaaaa
aagabaaaahaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaa
acaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaa
fgbfbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajncaabaaaabaaaaaaagajbaaa
acaaaaaakgakbaaaaaaaaaaaagaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaa
egbcbaaaabaaaaaapgipcaaaaaaaaaaaakaaaaaaefaaaaajpcaabaaaadaaaaaa
ggakbaaaacaaaaaaeghobaaaaeaaaaaaaagabaaaacaaaaaadiaaaaahhcaabaaa
adaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaa
egaabaaaacaaaaaaeghobaaaaeaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaa
afaaaaaacgakbaaaacaaaaaaeghobaaaaeaaaaaaaagabaaaacaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaa
dcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaa
acaaaaaadcaaaaajncaabaaaabaaaaaaagajbaaaacaaaaaaagaabaaaaaaaaaaa
agaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaaagiacaaa
aaaaaaaaalaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaa
afaaaaaaaagabaaaaeaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaa
agbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaa
afaaaaaaaagabaaaaeaaaaaaefaaaaajpcaabaaaafaaaaaacgakbaaaacaaaaaa
eghobaaaafaaaaaaaagabaaaaeaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaa
aeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaa
abaaaaaaegacbaaaacaaaaaafgafbaaaabaaaaaaigadbaaaabaaaaaadiaaaaai
hcaabaaaacaaaaaaegbcbaaaabaaaaaafgifcaaaaaaaaaaaalaaaaaaefaaaaaj
pcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaagaaaaaaaagabaaaagaaaaaa
diaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaagaaaaaaaagabaaaagaaaaaa
efaaaaajpcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaagaaaaaaaagabaaa
agaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaa
egacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaa
acaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaa
pgapbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaa
abaaaaaakgikcaaaaaaaaaaaalaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaa
acaaaaaaeghobaaaahaaaaaaaagabaaaaiaaaaaadiaaaaahhcaabaaaadaaaaaa
egacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
acaaaaaaeghobaaaahaaaaaaaagabaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaa
cgakbaaaacaaaaaaeghobaaaahaaaaaaaagabaaaaiaaaaaadcaaaaajhcaabaaa
adaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaacaaaaaafgbfbaaaacaaaaaaegacbaaaadaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaacaaaaaafgafbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaa
egbcbaiaebaaaaaaaeaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaaegbcbaaaaeaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaa
abaaaaaafgifcaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaa
abaaaaaaeghobaaaaiaaaaaaaagabaaaajaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaa
abaaaaaaeghobaaaaiaaaaaaaagabaaaajaaaaaaefaaaaajpcaabaaaabaaaaaa
cgakbaaaabaaaaaaeghobaaaaiaaaaaaaagabaaaajaaaaaadcaaaaajhcaabaaa
acaaaaaaegacbaaaadaaaaaakgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaaj
hcaabaaaabaaaaaaegacbaaaabaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaa
aaaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaaegacbaaaabaaaaaa
aaaaaaakicaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaajaaaaaadkiacaaa
aaaaaaaaajaaaaaaaoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpdkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaackbabaaa
adaaaaaackiacaiaebaaaaaaaaaaaaaaajaaaaaadicaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaia
ebaaaaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakbabaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegbcbaaaagaaaaaaaoaaaaahdcaabaaaacaaaaaa
egbabaaaahaaaaaapgbpbaaaahaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaa
acaaaaaaeghobaaaajaaaaaaaagabaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
ckbabaaaafaaaaaaabeaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaapgapbaaa
aaaaaaaaagaabaaaacaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaagiccabaaaaaaaaaaadkiacaaa
aaaaaaaaaoaaaaaadoaaaaab"
				}
				SubProgram "opengl " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
					}
					Float 0[_texTiling]
					Float 1[_texPower]
					Float 2[_groundTexStart]
					Float 3[_groundTexEnd]
					Float 4[_steepTiling]
					Float 5[_steepTexStart]
					Float 6[_steepTexEnd]
					Float 7[_multiPower]
					Float 8[_deepMultiFactor]
					Float 9[_mainMultiFactor]
					Float 10[_highMultiFactor]
					Float 11[_snowMultiFactor]
					Float 12[_deepStart]
					Float 13[_deepEnd]
					Float 14[_mainLoStart]
					Float 15[_mainLoEnd]
					Float 16[_mainHiStart]
					Float 17[_mainHiEnd]
					Float 18[_hiLoStart]
					Float 19[_hiLoEnd]
					Float 20[_hiHiStart]
					Float 21[_hiHiEnd]
					Float 22[_snowStart]
					Float 23[_snowEnd]
					Float 24[_PlanetOpacity]
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 1
					SetTexture 2[_highTex] 2D 2
					SetTexture 3[_snowTex] 2D 3
					SetTexture 4[_deepMultiTex] 2D 4
					SetTexture 5[_mainMultiTex] 2D 5
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[_ShadowMapTexture] 2D 9
					SetTexture 10[unity_Lightmap] 2D 10 "3.0-!!ARBfp1.0
PARAM c[26] = { program.local[0..24],
		{ 2, 3, 1, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.x, c[2];
ADD R0.x, -R0, c[3];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].z, -c[2];
MUL_SAT R0.w, R0.x, R0.y;
MUL R3.xyz, fragment.texcoord[0], c[0].x;
MAD R1.x, -R0.w, c[25], c[25].y;
MUL R0.w, R0, R0;
MOV R2.w, c[12].x;
ADD R2.w, -R2, c[13].x;
RCP R4.x, R2.w;
ADD R2.w, fragment.texcoord[2].y, -c[12].x;
MUL_SAT R2.w, R2, R4.x;
TEX R0.xyz, R3.zyzw, texture[1], 2D;
MUL R0.w, R0, R1.x;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[1], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R0, R1;
ADD R0.x, -R0.w, c[25].z;
MOV R0.z, c[16].x;
ADD R0.z, -R0, c[17].x;
RCP R1.w, R0.z;
ADD R0.z, fragment.texcoord[2].y, -c[16].x;
MUL_SAT R1.w, R0.z, R1;
MOV R0.y, c[14].x;
ADD R0.y, -R0, c[15].x;
RCP R0.z, R0.y;
ADD R0.y, fragment.texcoord[2], -c[14].x;
MUL_SAT R0.y, R0, R0.z;
MUL R0.w, R0, c[7].x;
MAD R2.x, -R1.w, c[25], c[25].y;
MUL R0.z, R1.w, R1.w;
MUL R1.w, R0.z, R2.x;
MUL R0.z, R0.y, R0.y;
MAD R0.y, -R0, c[25].x, c[25];
MAD R3.w, R0.z, R0.y, -R1;
MUL R1.w, R0.x, c[1].x;
MUL R2.x, R1.w, R3.w;
TEX R0.xyz, R3.zxzw, texture[1], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R0, R1;
MUL R1.xyz, R0, R2.x;
TEX R2.xyz, R3.zyzw, texture[0], 2D;
TEX R0.xyz, R3, texture[0], 2D;
MUL R2.xyz, fragment.texcoord[1].x, R2;
MAD R2.xyz, fragment.texcoord[1].z, R0, R2;
MAD R0.y, -R2.w, c[25].x, c[25];
MUL R0.x, R2.w, R2.w;
MAD R4.x, -R0, R0.y, c[25].z;
TEX R0.xyz, R3.zxzw, texture[0], 2D;
MUL R2.w, R1, R4.x;
MAD R2.xyz, fragment.texcoord[1].y, R0, R2;
TEX R0.xyz, R3.zyzw, texture[2], 2D;
MAD R2.xyz, R2, R2.w, R1;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[2], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R0, R1;
MOV R0.y, c[20].x;
ADD R0.y, -R0, c[21].x;
RCP R0.z, R0.y;
ADD R0.y, fragment.texcoord[2], -c[20].x;
MUL_SAT R0.z, R0.y, R0;
MOV R0.x, c[18];
ADD R0.x, -R0, c[19];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].y, -c[18];
MUL_SAT R0.x, R0, R0.y;
MAD R2.w, -R0.z, c[25].x, c[25].y;
MUL R0.y, R0.z, R0.z;
MUL R0.z, R0.y, R2.w;
MUL R0.y, R0.x, R0.x;
MAD R0.x, -R0, c[25], c[25].y;
MAD R2.w, R0.y, R0.x, -R0.z;
TEX R0.xyz, R3.zxzw, texture[2], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R0, R1;
MUL R1.x, R1.w, R2.w;
MAD R2.xyz, R0, R1.x, R2;
TEX R1.xyz, R3.zyzw, texture[3], 2D;
TEX R0.xyz, R3, texture[3], 2D;
MUL R1.xyz, fragment.texcoord[1].x, R1;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[3], 2D;
MOV R3.y, c[22].x;
ADD R3.y, -R3, c[23].x;
MAD R1.xyz, fragment.texcoord[1].y, R1, R0;
MUL R4.x, R0.w, R4;
RCP R3.y, R3.y;
ADD R3.x, fragment.texcoord[2].y, -c[22];
MUL_SAT R3.x, R3, R3.y;
MAD R0.y, -R3.x, c[25].x, c[25];
MUL R0.x, R3, R3;
MUL R4.y, R0.x, R0;
MUL R3.xyz, fragment.texcoord[0], c[8].x;
MUL R4.z, R1.w, R4.y;
TEX R0.xyz, R3.zyzw, texture[4], 2D;
MAD R2.xyz, R1, R4.z, R2;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[4], 2D;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[4], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R1, R0;
MAD R0.xyz, R0, R4.x, R2;
MUL R1.xyz, fragment.texcoord[0], c[9].x;
TEX R3.xyz, R1.zyzw, texture[5], 2D;
TEX R2.xyz, R1, texture[5], 2D;
MUL R3.xyz, fragment.texcoord[1].x, R3;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[5], 2D;
MAD R3.xyz, fragment.texcoord[1].y, R1, R2;
MUL R1.xyz, fragment.texcoord[0], c[10].x;
MUL R3.w, R0, R3;
TEX R2.xyz, R1.zyzw, texture[6], 2D;
MAD R0.xyz, R3, R3.w, R0;
MUL R3.xyz, fragment.texcoord[1].x, R2;
TEX R2.xyz, R1, texture[6], 2D;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[6], 2D;
MAD R3.xyz, fragment.texcoord[1].y, R1, R2;
MUL R1.xyz, fragment.texcoord[0], c[11].x;
MUL R2.w, R0, R2;
TEX R2.xyz, R1.zyzw, texture[7], 2D;
MAD R0.xyz, R3, R2.w, R0;
MUL R3.xyz, fragment.texcoord[1].x, R2;
TEX R2.xyz, R1, texture[7], 2D;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[7], 2D;
MAD R1.xyz, fragment.texcoord[1].y, R1, R2;
MUL R2.x, R0.w, R4.y;
MAD R0.xyz, R1, R2.x, R0;
MAD R2.xyz, fragment.texcoord[3], R0, -fragment.texcoord[3];
MUL R1.xyz, fragment.texcoord[0], c[4].x;
ADD R0.w, R1, R0;
MAD R3.xyz, R0.w, R2, fragment.texcoord[3];
TEX R0.xyz, R1.zyzw, texture[8], 2D;
MUL R2.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R1, texture[8], 2D;
MAD R0.xyz, fragment.texcoord[1].z, R0, R2;
TEX R1.xyz, R1.zxzw, texture[8], 2D;
MAD R1.xyz, R1, fragment.texcoord[1].y, R0;
TEX R0, fragment.texcoord[4], texture[10], 2D;
MUL R2.xyz, R0.w, R0;
TXP R4.x, fragment.texcoord[5], texture[9], 2D;
MUL R0.xyz, R0, R4.x;
MOV R0.w, c[5].x;
ADD R0.w, -R0, c[6].x;
RCP R1.w, R0.w;
ADD R0.w, fragment.texcoord[2].z, -c[5].x;
MUL_SAT R0.w, R0, R1;
MAD R1.w, -R0, c[25].x, c[25].y;
MUL R0.w, R0, R0;
MAD R0.w, -R0, R1, c[25].z;
MUL R2.xyz, R2, c[25].w;
MUL R0.xyz, R0, c[25].x;
MIN R0.xyz, R2, R0;
MUL R2.xyz, R2, R4.x;
ADD R1.xyz, R1, -R3;
MUL R0.w, fragment.texcoord[2].x, R0;
MAX R0.xyz, R0, R2;
MAD R1.xyz, R0.w, R1, R3;
MUL result.color.xyz, R1, R0;
MOV result.color.w, c[24].x;
END
# 160 instructions, 5 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
					}
					Float 0[_texTiling]
					Float 1[_texPower]
					Float 2[_groundTexStart]
					Float 3[_groundTexEnd]
					Float 4[_steepTiling]
					Float 5[_steepTexStart]
					Float 6[_steepTexEnd]
					Float 7[_multiPower]
					Float 8[_deepMultiFactor]
					Float 9[_mainMultiFactor]
					Float 10[_highMultiFactor]
					Float 11[_snowMultiFactor]
					Float 12[_deepStart]
					Float 13[_deepEnd]
					Float 14[_mainLoStart]
					Float 15[_mainLoEnd]
					Float 16[_mainHiStart]
					Float 17[_mainHiEnd]
					Float 18[_hiLoStart]
					Float 19[_hiLoEnd]
					Float 20[_hiHiStart]
					Float 21[_hiHiEnd]
					Float 22[_snowStart]
					Float 23[_snowEnd]
					Float 24[_PlanetOpacity]
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 1
					SetTexture 2[_highTex] 2D 2
					SetTexture 3[_snowTex] 2D 3
					SetTexture 4[_deepMultiTex] 2D 4
					SetTexture 5[_mainMultiTex] 2D 5
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[_ShadowMapTexture] 2D 9
					SetTexture 10[unity_Lightmap] 2D 10 "ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
dcl_2d s8
dcl_2d s9
dcl_2d s10
def c25, 2.00000000, 3.00000000, 1.00000000, 8.00000000
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xy
dcl_texcoord5 v5
mov r0.x, c3
add r0.w, -c2.x, r0.x
mul r0.xyz, v0, c0.x
rcp r1.x, r0.w
texld r3.xyz, r0.zyzw, s0
add r0.w, v2.z, -c2.x
mul_sat r0.w, r0, r1.x
texld r1.xyz, r0.zyzw, s1
mad r1.w, -r0, c25.x, c25.y
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s1
mad r2.xyz, v1.z, r1, r2
mul r0.w, r0, r0
mul r0.w, r0, r1
add r1.x, -r0.w, c25.z
mov r1.z, c17.x
add r1.z, -c16.x, r1
rcp r1.w, r1.z
add r1.z, v2.y, -c16.x
mul_sat r1.w, r1.z, r1
mov r1.y, c15.x
add r1.y, -c14.x, r1
rcp r1.z, r1.y
add r1.y, v2, -c14.x
mul_sat r1.y, r1, r1.z
mul r0.w, r0, c7.x
mad r2.w, -r1, c25.x, c25.y
mul r1.z, r1.w, r1.w
mul r1.w, r1.z, r2
mul r1.z, r1.y, r1.y
mad r1.y, -r1, c25.x, c25
mad r3.w, r1.z, r1.y, -r1
mul r1.w, r1.x, c1.x
mul r2.w, r1, r3
texld r1.xyz, r0.zxzw, s1
mad r1.xyz, v1.y, r1, r2
mul r2.xyz, r1, r2.w
mov r2.w, c13.x
add r2.w, -c12.x, r2
rcp r4.x, r2.w
add r2.w, v2.y, -c12.x
texld r1.xyz, r0, s0
mul r3.xyz, v1.x, r3
mul_sat r2.w, r2, r4.x
mad r3.xyz, v1.z, r1, r3
mad r1.y, -r2.w, c25.x, c25
mul r1.x, r2.w, r2.w
mad r4.x, -r1, r1.y, c25.z
mul r2.w, r1, r4.x
texld r1.xyz, r0.zxzw, s0
mad r3.xyz, v1.y, r1, r3
mad r3.xyz, r3, r2.w, r2
texld r1.xyz, r0.zyzw, s2
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s2
mad r2.xyz, v1.z, r1, r2
mov r1.y, c21.x
add r1.y, -c20.x, r1
rcp r1.z, r1.y
add r1.y, v2, -c20.x
mul_sat r1.z, r1.y, r1
mov r1.x, c19
add r1.x, -c18, r1
rcp r1.y, r1.x
add r1.x, v2.y, -c18
mul_sat r1.x, r1, r1.y
mad r2.w, -r1.z, c25.x, c25.y
mul r1.y, r1.z, r1.z
mul r1.z, r1.y, r2.w
mul r1.y, r1.x, r1.x
mad r1.x, -r1, c25, c25.y
mad r2.w, r1.y, r1.x, -r1.z
texld r1.xyz, r0.zxzw, s2
mad r1.xyz, v1.y, r1, r2
mul r2.x, r1.w, r2.w
mad r2.xyz, r1, r2.x, r3
texld r1.xyz, r0.zyzw, s3
texld r3.xyz, r0, s3
mul r1.xyz, v1.x, r1
mad r1.xyz, v1.z, r3, r1
mov r0.y, c23.x
add r3.x, -c22, r0.y
rcp r3.y, r3.x
add r3.x, v2.y, -c22
texld r0.xyz, r0.zxzw, s3
mul_sat r4.y, r3.x, r3
mad r3.xyz, v1.y, r0, r1
mad r0.y, -r4, c25.x, c25
mul r0.x, r4.y, r4.y
mul r4.y, r0.x, r0
mul r0.xyz, v0, c8.x
mul r4.z, r1.w, r4.y
mad r3.xyz, r3, r4.z, r2
texld r1.xyz, r0.zyzw, s4
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s4
mad r1.xyz, v1.z, r1, r2
texld r0.xyz, r0.zxzw, s4
mad r1.xyz, v1.y, r0, r1
mul r0.xyz, v0, c9.x
mul r4.x, r0.w, r4
mad r1.xyz, r1, r4.x, r3
texld r2.xyz, r0.zyzw, s5
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s5
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s5
mad r3.xyz, v1.y, r0, r2
mul r0.xyz, v0, c10.x
mul r3.w, r0, r3
texld r2.xyz, r0.zyzw, s6
mad r1.xyz, r3, r3.w, r1
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s6
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s6
mad r3.xyz, v1.y, r0, r2
mul r0.xyz, v0, c11.x
mul r2.w, r0, r2
texld r2.xyz, r0.zyzw, s7
mad r1.xyz, r3, r2.w, r1
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s7
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s7
mad r0.xyz, v1.y, r0, r2
mul r2.x, r0.w, r4.y
mad r0.xyz, r0, r2.x, r1
mad r2.xyz, v3, r0, -v3
mul r0.xyz, v0, c4.x
add r0.w, r1, r0
mad r3.xyz, r0.w, r2, v3
texld r1.xyz, r0.zyzw, s8
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s8
mad r1.xyz, v1.z, r1, r2
texld r0.xyz, r0.zxzw, s8
mad r1.xyz, r0, v1.y, r1
texld r0, v4, s10
mul_pp r2.xyz, r0.w, r0
texldp r4.x, v5, s9
mul_pp r0.xyz, r0, r4.x
mov r0.w, c6.x
add r0.w, -c5.x, r0
rcp r1.w, r0.w
add r0.w, v2.z, -c5.x
mul_sat r0.w, r0, r1
mad r1.w, -r0, c25.x, c25.y
mul r0.w, r0, r0
mad r0.w, -r0, r1, c25.z
mul_pp r2.xyz, r2, c25.w
mul_pp r0.xyz, r0, c25.x
min_pp r0.xyz, r2, r0
mul_pp r2.xyz, r2, r4.x
add r1.xyz, r1, -r3
mul r0.w, v2.x, r0
max_pp r0.xyz, r0, r2
mad r1.xyz, r0.w, r1, r3
mul_pp oC0.xyz, r1, r0
mov_pp oC0.w, c24.x
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
					}
					SetTexture 0[_deepTex] 2D 1
					SetTexture 1[_mainTex] 2D 3
					SetTexture 2[_highTex] 2D 5
					SetTexture 3[_snowTex] 2D 7
					SetTexture 4[_deepMultiTex] 2D 2
					SetTexture 5[_mainMultiTex] 2D 4
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 8
					SetTexture 8[_steepTex] 2D 9
					SetTexture 9[_ShadowMapTexture] 2D 0
					SetTexture 10[unity_Lightmap] 2D 10
					ConstBuffer "$Globals"
					272
					Float 128[_texTiling]
					Float 132[_texPower]
					Float 136[_groundTexStart]
					Float 140[_groundTexEnd]
					Float 148[_steepTiling]
					Float 152[_steepTexStart]
					Float 156[_steepTexEnd]
					Float 168[_multiPower]
					Float 172[_deepMultiFactor]
					Float 176[_mainMultiFactor]
					Float 180[_highMultiFactor]
					Float 184[_snowMultiFactor]
					Float 188[_deepStart]
					Float 192[_deepEnd]
					Float 196[_mainLoStart]
					Float 200[_mainLoEnd]
					Float 204[_mainHiStart]
					Float 208[_mainHiEnd]
					Float 212[_hiLoStart]
					Float 216[_hiLoEnd]
					Float 220[_hiHiStart]
					Float 224[_hiHiEnd]
					Float 228[_snowStart]
					Float 232[_snowEnd]
					Float 236[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedmpaeamimddimkggndbcngedaiokggninabaaaaaalabgaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaadadaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefchibfaaaaeaaaaaaafoafaaaa
fjaaaaaeegiocaaaaaaaaaaaapaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaa
agaaaaaafkaaaaadaagabaaaahaaaaaafkaaaaadaagabaaaaiaaaaaafkaaaaad
aagabaaaajaaaaaafkaaaaadaagabaaaakaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaa
ffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaafibiaaaeaahabaaaagaaaaaa
ffffaaaafibiaaaeaahabaaaahaaaaaaffffaaaafibiaaaeaahabaaaaiaaaaaa
ffffaaaafibiaaaeaahabaaaajaaaaaaffffaaaafibiaaaeaahabaaaakaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaaddcbabaaaafaaaaaa
gcbaaaadlcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaa
aaaaaaakbcaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaaalaaaaaaakiacaaa
aaaaaaaaamaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaabkbabaaa
adaaaaaadkiacaiaebaaaaaaaaaaaaaaalaaaaaadicaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaakccaabaaa
aaaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaadkiacaaaaaaaaaaaaiaaaaaa
aoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
bkaabaaaaaaaaaaaaaaaaaajecaabaaaaaaaaaaackbabaaaadaaaaaackiacaia
ebaaaaaaaaaaaaaaaiaaaaaadicaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckiacaaaaaaaaaaaakaaaaaadiaaaaaiecaabaaaaaaaaaaadkaabaaaaaaaaaaa
bkiacaaaaaaaaaaaaiaaaaaadcaaaaakicaabaaaaaaaaaaabkiacaaaaaaaaaaa
aiaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaa
ckaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaaaaaaaaakccaabaaaabaaaaaadkiacaiaebaaaaaa
aaaaaaaaamaaaaaaakiacaaaaaaaaaaaanaaaaaaaoaaaaakccaabaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaabaaaaaaaaaaaaaj
mcaabaaaabaaaaaafgbfbaaaadaaaaaafgincaiaebaaaaaaaaaaaaaaamaaaaaa
dicaaaahccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaaj
icaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaea
diaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaaaaaaaaakicaabaaa
abaaaaaabkiacaiaebaaaaaaaaaaaaaaamaaaaaackiacaaaaaaaaaaaamaaaaaa
aoaaaaakicaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
dkaabaaaabaaaaaadicaaaahecaabaaaabaaaaaadkaabaaaabaaaaaackaabaaa
abaaaaaadcaaaaajicaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaackaabaaa
abaaaaaadcaaaaakccaabaaaabaaaaaadkaabaaaabaaaaaackaabaaaabaaaaaa
bkaabaiaebaaaaaaabaaaaaadiaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaa
bkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaa
abaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaa
aiaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaadaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaa
acaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaadaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaaaeaaaaaakgbkbaaa
acaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaa
aeaaaaaafgbfbaaaacaaaaaaegacbaaaadaaaaaadiaaaaahhcaabaaaadaaaaaa
kgakbaaaabaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaaggakbaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaaaeaaaaaa
egacbaaaaeaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaaaeaaaaaa
egacbaaaafaaaaaakgbkbaaaacaaaaaaegacbaaaaeaaaaaaefaaaaajpcaabaaa
afaaaaaacgakbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaaj
hcaabaaaaeaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaaaeaaaaaa
dcaaaaajncaabaaaabaaaaaaagajbaaaaeaaaaaaagaabaaaabaaaaaaagajbaaa
adaaaaaaaaaaaaakicaabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaaanaaaaaa
akiacaaaaaaaaaaaaoaaaaaaaoaaaaakicaabaaaacaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpdkaabaaaacaaaaaaaaaaaaajdcaabaaaadaaaaaa
fgbfbaaaadaaaaaangifcaiaebaaaaaaaaaaaaaaanaaaaaadicaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaabkaabaaaadaaaaaadcaaaaajccaabaaaadaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaabkaabaaaadaaaaaaaaaaaaakccaabaaaadaaaaaabkiacaia
ebaaaaaaaaaaaaaaanaaaaaackiacaaaaaaaaaaaanaaaaaaaoaaaaakccaabaaa
adaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaadaaaaaa
dicaaaahbcaabaaaadaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaaj
ccaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaea
diaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaak
icaabaaaacaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadkaabaiaebaaaaaa
acaaaaaadiaaaaahbcaabaaaadaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaa
diaaaaahicaabaaaacaaaaaabkaabaaaaaaaaaaadkaabaaaacaaaaaaefaaaaaj
pcaabaaaaeaaaaaaggakbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaafaaaaaa
diaaaaahocaabaaaadaaaaaaagajbaaaaeaaaaaaagbabaaaacaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaafaaaaaa
dcaaaaajocaabaaaadaaaaaaagajbaaaaeaaaaaakgbkbaaaacaaaaaafgaobaaa
adaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaafaaaaaadcaaaaajocaabaaaadaaaaaaagajbaaaaeaaaaaafgbfbaaa
acaaaaaafgaobaaaadaaaaaadcaaaaajncaabaaaabaaaaaafgaobaaaadaaaaaa
agaabaaaadaaaaaaagaobaaaabaaaaaaaaaaaaakbcaabaaaadaaaaaabkiacaia
ebaaaaaaaaaaaaaaaoaaaaaackiacaaaaaaaaaaaaoaaaaaaaoaaaaakbcaabaaa
adaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaadaaaaaa
aaaaaaajccaabaaaadaaaaaabkbabaaaadaaaaaabkiacaiaebaaaaaaaaaaaaaa
aoaaaaaadicaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaa
dcaaaaajccaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaa
aaaaeaeadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaa
diaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaadiaaaaah
gcaabaaaaaaaaaaafgagbaaaaaaaaaaaagaabaaaadaaaaaaefaaaaajpcaabaaa
adaaaaaaggakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaahaaaaaadiaaaaah
hcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaahaaaaaaefaaaaaj
pcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaahaaaaaa
dcaaaaajhcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaa
adaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaa
egacbaaaacaaaaaadcaaaaajncaabaaaabaaaaaaagajbaaaacaaaaaakgakbaaa
aaaaaaaaagaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaa
pgipcaaaaaaaaaaaakaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaa
eghobaaaaeaaaaaaaagabaaaacaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaa
adaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaa
eghobaaaaeaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaafaaaaaacgakbaaa
acaaaaaaeghobaaaaeaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaa
acaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaadcaaaaaj
ncaabaaaabaaaaaaagajbaaaacaaaaaaagaabaaaaaaaaaaaagaobaaaabaaaaaa
diaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaalaaaaaa
efaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaafaaaaaaaagabaaa
aeaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaa
efaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaafaaaaaaaagabaaa
aeaaaaaaefaaaaajpcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaafaaaaaa
aagabaaaaeaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaa
acaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaa
fgbfbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
acaaaaaafgafbaaaabaaaaaaigadbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaa
egbcbaaaabaaaaaafgifcaaaaaaaaaaaalaaaaaaefaaaaajpcaabaaaadaaaaaa
ggakbaaaacaaaaaaeghobaaaagaaaaaaaagabaaaagaaaaaadiaaaaahhcaabaaa
adaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaa
egaabaaaacaaaaaaeghobaaaagaaaaaaaagabaaaagaaaaaaefaaaaajpcaabaaa
afaaaaaacgakbaaaacaaaaaaeghobaaaagaaaaaaaagabaaaagaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaa
dcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaa
acaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaapgapbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaakgikcaaa
aaaaaaaaalaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaa
ahaaaaaaaagabaaaaiaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaa
agbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaa
ahaaaaaaaagabaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaacgakbaaaacaaaaaa
eghobaaaahaaaaaaaagabaaaaiaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaa
aeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaacaaaaaafgbfbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaacaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaiaebaaaaaa
aeaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
egbcbaaaaeaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaabaaaaaafgifcaaa
aaaaaaaaajaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaaeghobaaa
aiaaaaaaaagabaaaajaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
agbabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaa
aiaaaaaaaagabaaaajaaaaaaefaaaaajpcaabaaaabaaaaaacgakbaaaabaaaaaa
eghobaaaaiaaaaaaaagabaaaajaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaa
adaaaaaakgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaa
egacbaaaabaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaakicaabaaa
aaaaaaaackiacaiaebaaaaaaaaaaaaaaajaaaaaadkiacaaaaaaaaaaaajaaaaaa
aoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
dkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaackbabaaaadaaaaaackiacaia
ebaaaaaaaaaaaaaaajaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakbabaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaa
agaaaaaapgbpbaaaagaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaajaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaafaaaaaa
eghobaaaakaaaaaaaagabaaaakaaaaaadiaaaaahocaabaaaabaaaaaapgapbaaa
aaaaaaaaagajbaaaacaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaacaaaaaa
abeaaaaaaaaaaaebdiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaa
aaaaaaaaddaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaaacaaaaaa
diaaaaahhcaabaaaacaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadeaaaaah
hcaabaaaabaaaaaajgahbaaaabaaaaaaegacbaaaacaaaaaadiaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaagiccabaaaaaaaaaaa
dkiacaaaaaaaaaaaaoaaaaaadoaaaaab"
				}
				SubProgram "opengl " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
					}
					Float 0[_texTiling]
					Float 1[_texPower]
					Float 2[_groundTexStart]
					Float 3[_groundTexEnd]
					Float 4[_steepTiling]
					Float 5[_steepTexStart]
					Float 6[_steepTexEnd]
					Float 7[_multiPower]
					Float 8[_deepMultiFactor]
					Float 9[_mainMultiFactor]
					Float 10[_highMultiFactor]
					Float 11[_snowMultiFactor]
					Float 12[_deepStart]
					Float 13[_deepEnd]
					Float 14[_mainLoStart]
					Float 15[_mainLoEnd]
					Float 16[_mainHiStart]
					Float 17[_mainHiEnd]
					Float 18[_hiLoStart]
					Float 19[_hiLoEnd]
					Float 20[_hiHiStart]
					Float 21[_hiHiEnd]
					Float 22[_snowStart]
					Float 23[_snowEnd]
					Float 24[_PlanetOpacity]
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 1
					SetTexture 2[_highTex] 2D 2
					SetTexture 3[_snowTex] 2D 3
					SetTexture 4[_deepMultiTex] 2D 4
					SetTexture 5[_mainMultiTex] 2D 5
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[_ShadowMapTexture] 2D 9
					SetTexture 10[unity_Lightmap] 2D 10
					SetTexture 11[unity_LightmapInd] 2D 11 "3.0-!!ARBfp1.0
PARAM c[27] = { program.local[0..24],
		{ 2, 3, 1, 0.57735026 },
		{ 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.x, c[2];
ADD R0.x, -R0, c[3];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].z, -c[2];
MUL_SAT R0.w, R0.x, R0.y;
MUL R3.xyz, fragment.texcoord[0], c[0].x;
MAD R1.x, -R0.w, c[25], c[25].y;
MUL R0.w, R0, R0;
MOV R2.w, c[12].x;
ADD R2.w, -R2, c[13].x;
RCP R4.x, R2.w;
ADD R2.w, fragment.texcoord[2].y, -c[12].x;
MUL_SAT R2.w, R2, R4.x;
TEX R0.xyz, R3.zyzw, texture[1], 2D;
MUL R0.w, R0, R1.x;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[1], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R0, R1;
ADD R0.x, -R0.w, c[25].z;
MOV R0.z, c[16].x;
ADD R0.z, -R0, c[17].x;
RCP R1.w, R0.z;
ADD R0.z, fragment.texcoord[2].y, -c[16].x;
MUL_SAT R1.w, R0.z, R1;
MOV R0.y, c[14].x;
ADD R0.y, -R0, c[15].x;
RCP R0.z, R0.y;
ADD R0.y, fragment.texcoord[2], -c[14].x;
MUL_SAT R0.y, R0, R0.z;
MUL R0.w, R0, c[7].x;
MAD R2.x, -R1.w, c[25], c[25].y;
MUL R0.z, R1.w, R1.w;
MUL R1.w, R0.z, R2.x;
MUL R0.z, R0.y, R0.y;
MAD R0.y, -R0, c[25].x, c[25];
MAD R3.w, R0.z, R0.y, -R1;
MUL R1.w, R0.x, c[1].x;
MUL R2.x, R1.w, R3.w;
TEX R0.xyz, R3.zxzw, texture[1], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R0, R1;
MUL R1.xyz, R0, R2.x;
TEX R2.xyz, R3.zyzw, texture[0], 2D;
TEX R0.xyz, R3, texture[0], 2D;
MUL R2.xyz, fragment.texcoord[1].x, R2;
MAD R2.xyz, fragment.texcoord[1].z, R0, R2;
MAD R0.y, -R2.w, c[25].x, c[25];
MUL R0.x, R2.w, R2.w;
MAD R4.x, -R0, R0.y, c[25].z;
TEX R0.xyz, R3.zxzw, texture[0], 2D;
MUL R2.w, R1, R4.x;
MAD R2.xyz, fragment.texcoord[1].y, R0, R2;
TEX R0.xyz, R3.zyzw, texture[2], 2D;
MAD R2.xyz, R2, R2.w, R1;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[2], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R0, R1;
MOV R0.y, c[20].x;
ADD R0.y, -R0, c[21].x;
RCP R0.z, R0.y;
ADD R0.y, fragment.texcoord[2], -c[20].x;
MUL_SAT R0.z, R0.y, R0;
MOV R0.x, c[18];
ADD R0.x, -R0, c[19];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].y, -c[18];
MUL_SAT R0.x, R0, R0.y;
MAD R2.w, -R0.z, c[25].x, c[25].y;
MUL R0.y, R0.z, R0.z;
MUL R0.z, R0.y, R2.w;
MUL R0.y, R0.x, R0.x;
MAD R0.x, -R0, c[25], c[25].y;
MAD R2.w, R0.y, R0.x, -R0.z;
TEX R0.xyz, R3.zxzw, texture[2], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R0, R1;
MUL R1.x, R1.w, R2.w;
MAD R2.xyz, R0, R1.x, R2;
TEX R1.xyz, R3.zyzw, texture[3], 2D;
TEX R0.xyz, R3, texture[3], 2D;
MUL R1.xyz, fragment.texcoord[1].x, R1;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[3], 2D;
MOV R3.y, c[22].x;
ADD R3.y, -R3, c[23].x;
MAD R1.xyz, fragment.texcoord[1].y, R1, R0;
MUL R4.x, R0.w, R4;
RCP R3.y, R3.y;
ADD R3.x, fragment.texcoord[2].y, -c[22];
MUL_SAT R3.x, R3, R3.y;
MAD R0.y, -R3.x, c[25].x, c[25];
MUL R0.x, R3, R3;
MUL R4.y, R0.x, R0;
MUL R3.xyz, fragment.texcoord[0], c[8].x;
MUL R4.z, R1.w, R4.y;
TEX R0.xyz, R3.zyzw, texture[4], 2D;
MAD R2.xyz, R1, R4.z, R2;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[4], 2D;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[4], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R1, R0;
MAD R0.xyz, R0, R4.x, R2;
MUL R1.xyz, fragment.texcoord[0], c[9].x;
TEX R3.xyz, R1.zyzw, texture[5], 2D;
TEX R2.xyz, R1, texture[5], 2D;
MUL R3.xyz, fragment.texcoord[1].x, R3;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[5], 2D;
MAD R3.xyz, fragment.texcoord[1].y, R1, R2;
MUL R1.xyz, fragment.texcoord[0], c[10].x;
MUL R3.w, R0, R3;
TEX R2.xyz, R1.zyzw, texture[6], 2D;
MAD R0.xyz, R3, R3.w, R0;
MUL R3.xyz, fragment.texcoord[1].x, R2;
TEX R2.xyz, R1, texture[6], 2D;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[6], 2D;
MAD R3.xyz, fragment.texcoord[1].y, R1, R2;
MUL R1.xyz, fragment.texcoord[0], c[11].x;
MUL R2.w, R0, R2;
TEX R2.xyz, R1.zyzw, texture[7], 2D;
MAD R0.xyz, R3, R2.w, R0;
MUL R3.xyz, fragment.texcoord[1].x, R2;
TEX R2.xyz, R1, texture[7], 2D;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[7], 2D;
MAD R1.xyz, fragment.texcoord[1].y, R1, R2;
MUL R2.x, R0.w, R4.y;
MAD R0.xyz, R1, R2.x, R0;
MAD R2.xyz, fragment.texcoord[3], R0, -fragment.texcoord[3];
MUL R1.xyz, fragment.texcoord[0], c[4].x;
ADD R0.w, R1, R0;
MAD R3.xyz, R0.w, R2, fragment.texcoord[3];
TEX R0.xyz, R1.zyzw, texture[8], 2D;
MUL R2.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R1, texture[8], 2D;
MAD R2.xyz, fragment.texcoord[1].z, R0, R2;
TEX R0, fragment.texcoord[4], texture[11], 2D;
TEX R1.xyz, R1.zxzw, texture[8], 2D;
MAD R1.xyz, R1, fragment.texcoord[1].y, R2;
MUL R0.xyz, R0.w, R0;
MUL R2.xyz, R0, c[25].w;
TEX R0, fragment.texcoord[4], texture[10], 2D;
DP3 R1.w, R2, c[26].x;
MUL R2.xyz, R0.w, R0;
MUL R2.xyz, R2, R1.w;
TXP R4.x, fragment.texcoord[5], texture[9], 2D;
MUL R0.xyz, R0, R4.x;
MOV R0.w, c[5].x;
ADD R0.w, -R0, c[6].x;
RCP R1.w, R0.w;
ADD R0.w, fragment.texcoord[2].z, -c[5].x;
MUL_SAT R0.w, R0, R1;
MAD R1.w, -R0, c[25].x, c[25].y;
MUL R0.w, R0, R0;
MAD R0.w, -R0, R1, c[25].z;
MUL R2.xyz, R2, c[26].x;
MUL R0.xyz, R0, c[25].x;
MIN R0.xyz, R2, R0;
MUL R2.xyz, R2, R4.x;
ADD R1.xyz, R1, -R3;
MUL R0.w, fragment.texcoord[2].x, R0;
MAX R0.xyz, R0, R2;
MAD R1.xyz, R0.w, R1, R3;
MUL result.color.xyz, R1, R0;
MOV result.color.w, c[24].x;
END
# 165 instructions, 5 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
					}
					Float 0[_texTiling]
					Float 1[_texPower]
					Float 2[_groundTexStart]
					Float 3[_groundTexEnd]
					Float 4[_steepTiling]
					Float 5[_steepTexStart]
					Float 6[_steepTexEnd]
					Float 7[_multiPower]
					Float 8[_deepMultiFactor]
					Float 9[_mainMultiFactor]
					Float 10[_highMultiFactor]
					Float 11[_snowMultiFactor]
					Float 12[_deepStart]
					Float 13[_deepEnd]
					Float 14[_mainLoStart]
					Float 15[_mainLoEnd]
					Float 16[_mainHiStart]
					Float 17[_mainHiEnd]
					Float 18[_hiLoStart]
					Float 19[_hiLoEnd]
					Float 20[_hiHiStart]
					Float 21[_hiHiEnd]
					Float 22[_snowStart]
					Float 23[_snowEnd]
					Float 24[_PlanetOpacity]
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 1
					SetTexture 2[_highTex] 2D 2
					SetTexture 3[_snowTex] 2D 3
					SetTexture 4[_deepMultiTex] 2D 4
					SetTexture 5[_mainMultiTex] 2D 5
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[_ShadowMapTexture] 2D 9
					SetTexture 10[unity_Lightmap] 2D 10
					SetTexture 11[unity_LightmapInd] 2D 11 "ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
dcl_2d s8
dcl_2d s9
dcl_2d s10
dcl_2d s11
def c25, 2.00000000, 3.00000000, 1.00000000, 0.57735026
def c26, 8.00000000, 0, 0, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xy
dcl_texcoord5 v5
mov r0.x, c3
add r0.w, -c2.x, r0.x
mul r0.xyz, v0, c0.x
rcp r1.x, r0.w
texld r3.xyz, r0.zyzw, s0
add r0.w, v2.z, -c2.x
mul_sat r0.w, r0, r1.x
texld r1.xyz, r0.zyzw, s1
mad r1.w, -r0, c25.x, c25.y
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s1
mad r2.xyz, v1.z, r1, r2
mul r0.w, r0, r0
mul r0.w, r0, r1
add r1.x, -r0.w, c25.z
mov r1.z, c17.x
add r1.z, -c16.x, r1
rcp r1.w, r1.z
add r1.z, v2.y, -c16.x
mul_sat r1.w, r1.z, r1
mov r1.y, c15.x
add r1.y, -c14.x, r1
rcp r1.z, r1.y
add r1.y, v2, -c14.x
mul_sat r1.y, r1, r1.z
mul r0.w, r0, c7.x
mad r2.w, -r1, c25.x, c25.y
mul r1.z, r1.w, r1.w
mul r1.w, r1.z, r2
mul r1.z, r1.y, r1.y
mad r1.y, -r1, c25.x, c25
mad r3.w, r1.z, r1.y, -r1
mul r1.w, r1.x, c1.x
mul r2.w, r1, r3
texld r1.xyz, r0.zxzw, s1
mad r1.xyz, v1.y, r1, r2
mul r2.xyz, r1, r2.w
mov r2.w, c13.x
add r2.w, -c12.x, r2
rcp r4.x, r2.w
add r2.w, v2.y, -c12.x
texld r1.xyz, r0, s0
mul r3.xyz, v1.x, r3
mul_sat r2.w, r2, r4.x
mad r3.xyz, v1.z, r1, r3
mad r1.y, -r2.w, c25.x, c25
mul r1.x, r2.w, r2.w
mad r4.x, -r1, r1.y, c25.z
mul r2.w, r1, r4.x
texld r1.xyz, r0.zxzw, s0
mad r3.xyz, v1.y, r1, r3
mad r3.xyz, r3, r2.w, r2
texld r1.xyz, r0.zyzw, s2
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s2
mad r2.xyz, v1.z, r1, r2
mov r1.y, c21.x
add r1.y, -c20.x, r1
rcp r1.z, r1.y
add r1.y, v2, -c20.x
mul_sat r1.z, r1.y, r1
mov r1.x, c19
add r1.x, -c18, r1
rcp r1.y, r1.x
add r1.x, v2.y, -c18
mul_sat r1.x, r1, r1.y
mad r2.w, -r1.z, c25.x, c25.y
mul r1.y, r1.z, r1.z
mul r1.z, r1.y, r2.w
mul r1.y, r1.x, r1.x
mad r1.x, -r1, c25, c25.y
mad r2.w, r1.y, r1.x, -r1.z
texld r1.xyz, r0.zxzw, s2
mad r1.xyz, v1.y, r1, r2
mul r2.x, r1.w, r2.w
mad r2.xyz, r1, r2.x, r3
texld r1.xyz, r0.zyzw, s3
texld r3.xyz, r0, s3
mul r1.xyz, v1.x, r1
mad r1.xyz, v1.z, r3, r1
mov r0.y, c23.x
add r3.x, -c22, r0.y
rcp r3.y, r3.x
add r3.x, v2.y, -c22
texld r0.xyz, r0.zxzw, s3
mul_sat r4.y, r3.x, r3
mad r3.xyz, v1.y, r0, r1
mad r0.y, -r4, c25.x, c25
mul r0.x, r4.y, r4.y
mul r4.y, r0.x, r0
mul r0.xyz, v0, c8.x
mul r4.z, r1.w, r4.y
mad r3.xyz, r3, r4.z, r2
texld r1.xyz, r0.zyzw, s4
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s4
mad r1.xyz, v1.z, r1, r2
texld r0.xyz, r0.zxzw, s4
mad r1.xyz, v1.y, r0, r1
mul r0.xyz, v0, c9.x
mul r4.x, r0.w, r4
mad r1.xyz, r1, r4.x, r3
texld r2.xyz, r0.zyzw, s5
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s5
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s5
mad r3.xyz, v1.y, r0, r2
mul r0.xyz, v0, c10.x
mul r3.w, r0, r3
texld r2.xyz, r0.zyzw, s6
mad r1.xyz, r3, r3.w, r1
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s6
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s6
mad r3.xyz, v1.y, r0, r2
mul r0.xyz, v0, c11.x
mul r2.w, r0, r2
texld r2.xyz, r0.zyzw, s7
mad r1.xyz, r3, r2.w, r1
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s7
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s7
mad r0.xyz, v1.y, r0, r2
mul r2.x, r0.w, r4.y
mad r0.xyz, r0, r2.x, r1
mad r2.xyz, v3, r0, -v3
mul r1.xyz, v0, c4.x
add r0.w, r1, r0
mad r3.xyz, r0.w, r2, v3
texld r0.xyz, r1.zyzw, s8
mul r2.xyz, v1.x, r0
texld r0.xyz, r1, s8
mad r2.xyz, v1.z, r0, r2
texld r0, v4, s11
texld r1.xyz, r1.zxzw, s8
mad r1.xyz, r1, v1.y, r2
mul_pp r0.xyz, r0.w, r0
mul_pp r2.xyz, r0, c25.w
texld r0, v4, s10
dp3_pp r1.w, r2, c26.x
mul_pp r2.xyz, r0.w, r0
mul_pp r2.xyz, r2, r1.w
texldp r4.x, v5, s9
mul_pp r0.xyz, r0, r4.x
mov r0.w, c6.x
add r0.w, -c5.x, r0
rcp r1.w, r0.w
add r0.w, v2.z, -c5.x
mul_sat r0.w, r0, r1
mad r1.w, -r0, c25.x, c25.y
mul r0.w, r0, r0
mad r0.w, -r0, r1, c25.z
mul_pp r2.xyz, r2, c26.x
mul_pp r0.xyz, r0, c25.x
min_pp r0.xyz, r2, r0
mul_pp r2.xyz, r2, r4.x
add r1.xyz, r1, -r3
mul r0.w, v2.x, r0
max_pp r0.xyz, r0, r2
mad r1.xyz, r0.w, r1, r3
mul_pp oC0.xyz, r1, r0
mov_pp oC0.w, c24.x
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
					}
					SetTexture 0[_deepTex] 2D 1
					SetTexture 1[_mainTex] 2D 3
					SetTexture 2[_highTex] 2D 5
					SetTexture 3[_snowTex] 2D 7
					SetTexture 4[_deepMultiTex] 2D 2
					SetTexture 5[_mainMultiTex] 2D 4
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 8
					SetTexture 8[_steepTex] 2D 9
					SetTexture 9[_ShadowMapTexture] 2D 0
					SetTexture 10[unity_Lightmap] 2D 10
					SetTexture 11[unity_LightmapInd] 2D 11
					ConstBuffer "$Globals"
					272
					Float 128[_texTiling]
					Float 132[_texPower]
					Float 136[_groundTexStart]
					Float 140[_groundTexEnd]
					Float 148[_steepTiling]
					Float 152[_steepTexStart]
					Float 156[_steepTexEnd]
					Float 168[_multiPower]
					Float 172[_deepMultiFactor]
					Float 176[_mainMultiFactor]
					Float 180[_highMultiFactor]
					Float 184[_snowMultiFactor]
					Float 188[_deepStart]
					Float 192[_deepEnd]
					Float 196[_mainLoStart]
					Float 200[_mainLoEnd]
					Float 204[_mainHiStart]
					Float 208[_mainHiEnd]
					Float 212[_hiLoStart]
					Float 216[_hiLoEnd]
					Float 220[_hiHiStart]
					Float 224[_hiHiEnd]
					Float 228[_snowStart]
					Float 232[_snowEnd]
					Float 236[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0
eefiecednbhbbefjnejilkhcmldodopminklljgbabaaaaaagmbhaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaadadaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdebgaaaaeaaaaaaainafaaaa
fjaaaaaeegiocaaaaaaaaaaaapaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaa
agaaaaaafkaaaaadaagabaaaahaaaaaafkaaaaadaagabaaaaiaaaaaafkaaaaad
aagabaaaajaaaaaafkaaaaadaagabaaaakaaaaaafkaaaaadaagabaaaalaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
fibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaa
fibiaaaeaahabaaaagaaaaaaffffaaaafibiaaaeaahabaaaahaaaaaaffffaaaa
fibiaaaeaahabaaaaiaaaaaaffffaaaafibiaaaeaahabaaaajaaaaaaffffaaaa
fibiaaaeaahabaaaakaaaaaaffffaaaafibiaaaeaahabaaaalaaaaaaffffaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaaddcbabaaaafaaaaaagcbaaaad
lcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaaaaaaaaak
bcaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaaalaaaaaaakiacaaaaaaaaaaa
amaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpakaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaabkbabaaaadaaaaaa
dkiacaiaebaaaaaaaaaaaaaaalaaaaaadicaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaakccaabaaaaaaaaaaa
ckiacaiaebaaaaaaaaaaaaaaaiaaaaaadkiacaaaaaaaaaaaaiaaaaaaaoaaaaak
ccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaa
aaaaaaaaaaaaaaajecaabaaaaaaaaaaackbabaaaadaaaaaackiacaiaebaaaaaa
aaaaaaaaaiaaaaaadicaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaa
aaaaaaaadcaaaaakicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaackiacaaa
aaaaaaaaakaaaaaadiaaaaaiecaabaaaaaaaaaaadkaabaaaaaaaaaaabkiacaaa
aaaaaaaaaiaaaaaadcaaaaakicaabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaa
dkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaackaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaaaaaaaaakccaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaa
amaaaaaaakiacaaaaaaaaaaaanaaaaaaaoaaaaakccaabaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaabaaaaaaaaaaaaajmcaabaaa
abaaaaaafgbfbaaaadaaaaaafgincaiaebaaaaaaaaaaaaaaamaaaaaadicaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaajicaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaaaaaaaaakicaabaaaabaaaaaa
bkiacaiaebaaaaaaaaaaaaaaamaaaaaackiacaaaaaaaaaaaamaaaaaaaoaaaaak
icaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaa
abaaaaaadicaaaahecaabaaaabaaaaaadkaabaaaabaaaaaackaabaaaabaaaaaa
dcaaaaajicaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
aaaaeaeadiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaackaabaaaabaaaaaa
dcaaaaakccaabaaaabaaaaaadkaabaaaabaaaaaackaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaadiaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaabkaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaaabaaaaaa
diaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaaiaaaaaa
efaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
adaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaa
efaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
adaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaa
egacbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaadaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaaaeaaaaaa
fgbfbaaaacaaaaaaegacbaaaadaaaaaadiaaaaahhcaabaaaadaaaaaakgakbaaa
abaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaaggakbaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaaaeaaaaaaegacbaaa
aeaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaaaeaaaaaaegacbaaa
afaaaaaakgbkbaaaacaaaaaaegacbaaaaeaaaaaaefaaaaajpcaabaaaafaaaaaa
cgakbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaa
aeaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaaaeaaaaaadcaaaaaj
ncaabaaaabaaaaaaagajbaaaaeaaaaaaagaabaaaabaaaaaaagajbaaaadaaaaaa
aaaaaaakicaabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaaanaaaaaaakiacaaa
aaaaaaaaaoaaaaaaaoaaaaakicaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpdkaabaaaacaaaaaaaaaaaaajdcaabaaaadaaaaaafgbfbaaa
adaaaaaangifcaiaebaaaaaaaaaaaaaaanaaaaaadicaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaabkaabaaaadaaaaaadcaaaaajccaabaaaadaaaaaadkaabaaa
acaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaa
acaaaaaabkaabaaaadaaaaaaaaaaaaakccaabaaaadaaaaaabkiacaiaebaaaaaa
aaaaaaaaanaaaaaackiacaaaaaaaaaaaanaaaaaaaoaaaaakccaabaaaadaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaadaaaaaadicaaaah
bcaabaaaadaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaajccaabaaa
adaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaah
bcaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaakicaabaaa
acaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadkaabaiaebaaaaaaacaaaaaa
diaaaaahbcaabaaaadaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaadiaaaaah
icaabaaaacaaaaaabkaabaaaaaaaaaaadkaabaaaacaaaaaaefaaaaajpcaabaaa
aeaaaaaaggakbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaafaaaaaadiaaaaah
ocaabaaaadaaaaaaagajbaaaaeaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaafaaaaaadcaaaaaj
ocaabaaaadaaaaaaagajbaaaaeaaaaaakgbkbaaaacaaaaaafgaobaaaadaaaaaa
efaaaaajpcaabaaaaeaaaaaacgakbaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
afaaaaaadcaaaaajocaabaaaadaaaaaaagajbaaaaeaaaaaafgbfbaaaacaaaaaa
fgaobaaaadaaaaaadcaaaaajncaabaaaabaaaaaafgaobaaaadaaaaaaagaabaaa
adaaaaaaagaobaaaabaaaaaaaaaaaaakbcaabaaaadaaaaaabkiacaiaebaaaaaa
aaaaaaaaaoaaaaaackiacaaaaaaaaaaaaoaaaaaaaoaaaaakbcaabaaaadaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaadaaaaaaaaaaaaaj
ccaabaaaadaaaaaabkbabaaaadaaaaaabkiacaiaebaaaaaaaaaaaaaaaoaaaaaa
dicaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaadcaaaaaj
ccaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaea
diaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaadiaaaaah
bcaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaadiaaaaahgcaabaaa
aaaaaaaafgagbaaaaaaaaaaaagaabaaaadaaaaaaefaaaaajpcaabaaaadaaaaaa
ggakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaahaaaaaadiaaaaahhcaabaaa
adaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaa
egaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaahaaaaaaefaaaaajpcaabaaa
afaaaaaacgakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaahaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaa
dcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaa
acaaaaaadcaaaaajncaabaaaabaaaaaaagajbaaaacaaaaaakgakbaaaaaaaaaaa
agaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaapgipcaaa
aaaaaaaaakaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaa
aeaaaaaaaagabaaaacaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaa
agbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaa
aeaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaafaaaaaacgakbaaaacaaaaaa
eghobaaaaeaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaa
aeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajncaabaaa
abaaaaaaagajbaaaacaaaaaaagaabaaaaaaaaaaaagaobaaaabaaaaaadiaaaaai
hcaabaaaacaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaalaaaaaaefaaaaaj
pcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaafaaaaaaaagabaaaaeaaaaaa
diaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaafaaaaaaaagabaaaaeaaaaaa
efaaaaajpcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaafaaaaaaaagabaaa
aeaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaa
egacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaa
acaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaa
fgafbaaaabaaaaaaigadbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaa
abaaaaaafgifcaaaaaaaaaaaalaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaa
acaaaaaaeghobaaaagaaaaaaaagabaaaagaaaaaadiaaaaahhcaabaaaadaaaaaa
egacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
acaaaaaaeghobaaaagaaaaaaaagabaaaagaaaaaaefaaaaajpcaabaaaafaaaaaa
cgakbaaaacaaaaaaeghobaaaagaaaaaaaagabaaaagaaaaaadcaaaaajhcaabaaa
acaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaa
dcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaapgapbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaakgikcaaaaaaaaaaa
alaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaahaaaaaa
aagabaaaaiaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaa
acaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaahaaaaaa
aagabaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaacgakbaaaacaaaaaaeghobaaa
ahaaaaaaaagabaaaaiaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaaaeaaaaaa
kgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaa
acaaaaaafgbfbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaacaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaiaebaaaaaaaeaaaaaa
dcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaa
aeaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaabaaaaaafgifcaaaaaaaaaaa
ajaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaaeghobaaaaiaaaaaa
aagabaaaajaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaagbabaaa
acaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaaaiaaaaaa
aagabaaaajaaaaaaefaaaaajpcaabaaaabaaaaaacgakbaaaabaaaaaaeghobaaa
aiaaaaaaaagabaaaajaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaadaaaaaa
kgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
abaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaaabaaaaaa
egacbaiaebaaaaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaakicaabaaaaaaaaaaa
ckiacaiaebaaaaaaaaaaaaaaajaaaaaadkiacaaaaaaaaaaaajaaaaaaaoaaaaak
icaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaa
aaaaaaaaaaaaaaajicaabaaaabaaaaaackbabaaaadaaaaaackiacaiaebaaaaaa
aaaaaaaaajaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akbabaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaafaaaaaa
eghobaaaalaaaaaaaagabaaaalaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaaaaaaaaabaaaaaakicaabaaaaaaaaaaaaceaaaaadkmnbddpdkmnbddp
dkmnbddpaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
afaaaaaaeghobaaaakaaaaaaaagabaaaakaaaaaadiaaaaahicaabaaaabaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaacaaaaaaegacbaaa
abaaaaaapgapbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaa
egacbaaaacaaaaaaaoaaaaahdcaabaaaadaaaaaaegbabaaaagaaaaaapgbpbaaa
agaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaajaaaaaa
aagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaaakaabaaaadaaaaaaakaabaaa
adaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaacaaaaaaagaabaaaadaaaaaa
diaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaddaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadeaaaaahhcaabaaa
abaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaagiccabaaaaaaaaaaadkiacaaa
aaaaaaaaaoaaaaaadoaaaaab"
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
					Bind "color"
					Color
					Bind "normal"
					Normal
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Bind "tangent"
					ATTR14
					Matrix 9[_Object2World]
					Matrix 13[_World2Object]
					Matrix 17[_LightMatrix0]
					Vector 21[_WorldSpaceLightPos0]
					Vector 22[unity_Scale]
					Vector 23[_tintColor]
					Float 24[_steepPower]
					Float 25[_saturation]
					Float 26[_contrast]
					"3.0-!!ARBvp1.0
PARAM c[28] = { { 1, 0 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..26],
		{ 0.29899999, 0.58700001, 0.114 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0, c[21];
DP4 R1.z, R0, c[15];
DP4 R1.y, R0, c[14];
DP4 R1.x, R0, c[13];
MAD R3.xyz, R1, c[22].w, -vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
DP3 R0.w, vertex.color, c[27];
ADD R0.xyz, vertex.color, -R0.w;
MUL R1.xyz, R1, vertex.attrib[14].w;
MAD R0.xyz, R0, c[25].x, R0.w;
DP3 result.texcoord[4].y, R3, R1;
MAD R1.xyz, -c[23], c[23].w, R0;
MUL R2.xyz, c[23], c[23].w;
MOV R0.z, vertex.texcoord[1].x;
MOV R0.xy, vertex.texcoord[0];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
MOV result.texcoord[0].xyz, R0;
ABS result.texcoord[1].xyz, R0;
DP4 R0.x, vertex.position, c[9];
DP4 R0.y, vertex.position, c[10];
DP4 R0.w, vertex.position, c[12];
DP4 R0.z, vertex.position, c[11];
DP4 result.texcoord[5].z, R0, c[19];
DP4 result.texcoord[5].y, R0, c[18];
DP4 result.texcoord[5].x, R0, c[17];
DP4 R0.x, vertex.position, c[3];
MUL R0.y, vertex.texcoord[1], c[24].x;
MOV result.texcoord[2].z, -R0.x;
MIN R0.x, R0.y, c[0];
MAD result.texcoord[3].xyz, R1, c[26].x, R2;
DP3 result.texcoord[4].z, vertex.normal, R3;
DP3 result.texcoord[4].x, R3, vertex.attrib[14];
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
MOV result.texcoord[2].y, vertex.color.w;
MAX result.texcoord[2].x, R0, c[0].y;
END
# 42 instructions, 4 R-regs
"
				}
				SubProgram "d3d9 " {
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
					Bind "tangent"
					TexCoord2
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 8[_Object2World]
					Matrix 12[_World2Object]
					Matrix 16[_LightMatrix0]
					Vector 20[_WorldSpaceLightPos0]
					Vector 21[unity_Scale]
					Vector 22[_tintColor]
					Float 23[_steepPower]
					Float 24[_saturation]
					Float 25[_contrast]
					"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c26, 0.29899999, 0.58700001, 0.11400000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dcl_color0 v5
mov r0, c14
dp4 r2.z, c20, r0
mov r0, c13
dp4 r2.y, c20, r0
mov r1, c12
dp4 r2.x, c20, r1
mad r3.xyz, r2, c21.w, -v0
mov r1.xyz, v1
dp3 r0.w, v5, c26
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r1.yzxw
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
add r0.xyz, v5, -r0.w
mul r1.xyz, r1, v1.w
mad r0.xyz, r0, c24.x, r0.w
dp3 o5.y, r3, r1
mad r1.xyz, -c22, c22.w, r0
mul r2.xyz, c22, c22.w
mov r0.z, v4.x
mov r0.xy, v3
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov o1.xyz, r0
abs o2.xyz, r0
dp4 r0.x, v0, c8
dp4 r0.w, v0, c11
dp4 r0.z, v0, c10
dp4 r0.y, v0, c9
dp4 o6.z, r0, c18
dp4 o6.y, r0, c17
dp4 o6.x, r0, c16
dp4 r0.x, v0, c2
mad o4.xyz, r1, c25.x, r2
dp3 o5.z, v2, r3
dp3 o5.x, r3, v1
dp4 o0.w, v0, c7
dp4 o0.z, v0, c6
dp4 o0.y, v0, c5
dp4 o0.x, v0, c4
mov o3.z, -r0.x
mov o3.y, v5.w
mul_sat o3.x, v4.y, c23
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
					Bind "tangent"
					TexCoord2
					ConstBuffer "$Globals"
					256
					Matrix 48[_LightMatrix0]
					Vector 112[_tintColor]
					Float 144[_steepPower]
					Float 240[_saturation]
					Float 244[_contrast]
					ConstBuffer "UnityLighting"
					720
					Vector 0[_WorldSpaceLightPos0]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 192[_Object2World]
					Matrix 256[_World2Object]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityLighting"
					1
					BindCB "UnityPerDraw"
					2 "vs_4_0
eefieceddlmacocaaboanocobkcfgeohcmelfcchabaaaaaahaaiaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefckeagaaaaeaaaabaakjabaaaafjaaaaaeegiocaaaaaaaaaaa
baaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaa
fpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaa
agaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafdcaabaaaaaaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaa
aaaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaa
abaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadicaaaaibccabaaaadaaaaaa
bkbabaaaaeaaaaaaakiacaaaaaaaaaaaajaaaaaadgaaaaafcccabaaaadaaaaaa
dkbabaaaafaaaaaabaaaaaakbcaabaaaaaaaaaaaegbcbaaaafaaaaaaaceaaaaa
ihbgjjdokcefbgdpnfhiojdnaaaaaaaaaaaaaaaiocaabaaaaaaaaaaaagaabaia
ebaaaaaaaaaaaaaaagbjbaaaafaaaaaadcaaaaakhcaabaaaaaaaaaaaagiacaaa
aaaaaaaaapaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaadcaaaaamhcaabaaa
aaaaaaaaegiccaiaebaaaaaaaaaaaaaaahaaaaaapgipcaaaaaaaaaaaahaaaaaa
egacbaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaapgipcaaaaaaaaaaaahaaaaaa
egiccaaaaaaaaaaaahaaaaaadcaaaaakhccabaaaaeaaaaaafgifcaaaaaaaaaaa
apaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaa
jgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaa
acaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaa
fgifcaaaabaaaaaaaaaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaa
abaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
acaaaaaabdaaaaaapgipcaaaabaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaacaaaaaabeaaaaaaegbcbaia
ebaaaaaaaaaaaaaabaaaaaahcccabaaaafaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbccabaaaafaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaaheccabaaaafaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhccabaaaagaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadoaaaaab"
				}
				SubProgram "opengl " {
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
					Bind "tangent"
					ATTR14
					Matrix 9[_World2Object]
					Vector 13[_WorldSpaceLightPos0]
					Vector 14[_tintColor]
					Float 15[_steepPower]
					Float 16[_saturation]
					Float 17[_contrast]
					"3.0-!!ARBvp1.0
PARAM c[19] = { { 0, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..17],
		{ 0.29899999, 0.58700001, 0.114 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R1.xyz, R0, vertex.attrib[14].w;
MOV R0, c[13];
DP3 R1.w, vertex.color, c[18];
ADD R2.xyz, vertex.color, -R1.w;
MAD R2.xyz, R2, c[16].x, R1.w;
DP4 R3.z, R0, c[11];
DP4 R3.y, R0, c[10];
DP4 R3.x, R0, c[9];
DP3 result.texcoord[4].y, R3, R1;
MOV R0.z, vertex.texcoord[1].x;
MOV R0.xy, vertex.texcoord[0];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
MOV result.texcoord[0].xyz, R0;
ABS result.texcoord[1].xyz, R0;
DP4 R0.y, vertex.position, c[3];
MUL R0.x, vertex.texcoord[1].y, c[15];
MIN R0.x, R0, c[0].y;
MAD R2.xyz, -c[14], c[14].w, R2;
MUL R1.xyz, c[14], c[14].w;
MAD result.texcoord[3].xyz, R2, c[17].x, R1;
DP3 result.texcoord[4].z, vertex.normal, R3;
DP3 result.texcoord[4].x, R3, vertex.attrib[14];
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
MOV result.texcoord[2].z, -R0.y;
MOV result.texcoord[2].y, vertex.color.w;
MAX result.texcoord[2].x, R0, c[0];
END
# 34 instructions, 4 R-regs
"
				}
				SubProgram "d3d9 " {
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
					Bind "tangent"
					TexCoord2
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 8[_World2Object]
					Vector 12[_WorldSpaceLightPos0]
					Vector 13[_tintColor]
					Float 14[_steepPower]
					Float 15[_saturation]
					Float 16[_contrast]
					"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c17, 0.29899999, 0.58700001, 0.11400000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dcl_color0 v5
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
dp3 r1.w, v5, c17
mul r2.xyz, r0, v1.w
add r1.xyz, v5, -r1.w
mov r0, c10
dp4 r4.z, c12, r0
mov r0, c9
dp4 r4.y, c12, r0
mad r3.xyz, r1, c15.x, r1.w
mov r1, c8
dp4 r4.x, c12, r1
dp3 o5.y, r4, r2
mov r0.z, v4.x
mov r0.xy, v3
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mad r2.xyz, -c13, c13.w, r3
mul r1.xyz, c13, c13.w
mov o1.xyz, r0
abs o2.xyz, r0
dp4 r0.x, v0, c2
mad o4.xyz, r2, c16.x, r1
dp3 o5.z, v2, r4
dp3 o5.x, r4, v1
dp4 o0.w, v0, c7
dp4 o0.z, v0, c6
dp4 o0.y, v0, c5
dp4 o0.x, v0, c4
mov o3.z, -r0.x
mov o3.y, v5.w
mul_sat o3.x, v4.y, c14
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
					Bind "tangent"
					TexCoord2
					ConstBuffer "$Globals"
					192
					Vector 48[_tintColor]
					Float 80[_steepPower]
					Float 176[_saturation]
					Float 180[_contrast]
					ConstBuffer "UnityLighting"
					720
					Vector 0[_WorldSpaceLightPos0]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 256[_World2Object]
					BindCB "$Globals"
					0
					BindCB "UnityLighting"
					1
					BindCB "UnityPerDraw"
					2 "vs_4_0
eefiecedangipigjhfjmikagamjonoplkldoggcjabaaaaaapaagaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcdmafaaaaeaaaabaaepabaaaafjaaaaae
egiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaae
egiocaaaacaaaaaabeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafdcaabaaaaaaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaaaaaaaaa
akbabaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaaabaaaaaa
egacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaa
ckbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
acaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaa
adaaaaaaakaabaiaebaaaaaaaaaaaaaadicaaaaibccabaaaadaaaaaabkbabaaa
aeaaaaaaakiacaaaaaaaaaaaafaaaaaadgaaaaafcccabaaaadaaaaaadkbabaaa
afaaaaaabaaaaaakbcaabaaaaaaaaaaaegbcbaaaafaaaaaaaceaaaaaihbgjjdo
kcefbgdpnfhiojdnaaaaaaaaaaaaaaaiocaabaaaaaaaaaaaagaabaiaebaaaaaa
aaaaaaaaagbjbaaaafaaaaaadcaaaaakhcaabaaaaaaaaaaaagiacaaaaaaaaaaa
alaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaa
egiccaiaebaaaaaaaaaaaaaaadaaaaaapgipcaaaaaaaaaaaadaaaaaaegacbaaa
aaaaaaaadiaaaaajhcaabaaaabaaaaaapgipcaaaaaaaaaaaadaaaaaaegiccaaa
aaaaaaaaadaaaaaadcaaaaakhccabaaaaeaaaaaafgifcaaaaaaaaaaaalaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaa
abaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaa
cgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaa
abaaaaaaaaaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaa
bdaaaaaapgipcaaaabaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaa
afaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaafaaaaaa
egbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaafaaaaaaegbcbaaa
acaaaaaaegacbaaaabaaaaaadoaaaaab"
				}
				SubProgram "opengl " {
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
					Bind "tangent"
					ATTR14
					Matrix 9[_Object2World]
					Matrix 13[_World2Object]
					Matrix 17[_LightMatrix0]
					Vector 21[_WorldSpaceLightPos0]
					Vector 22[unity_Scale]
					Vector 23[_tintColor]
					Float 24[_steepPower]
					Float 25[_saturation]
					Float 26[_contrast]
					"3.0-!!ARBvp1.0
PARAM c[28] = { { 1, 0 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..26],
		{ 0.29899999, 0.58700001, 0.114 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0, c[21];
DP4 R1.z, R0, c[15];
DP4 R1.y, R0, c[14];
DP4 R1.x, R0, c[13];
MAD R3.xyz, R1, c[22].w, -vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
DP3 R0.w, vertex.color, c[27];
ADD R0.xyz, vertex.color, -R0.w;
MUL R1.xyz, R1, vertex.attrib[14].w;
MAD R0.xyz, R0, c[25].x, R0.w;
DP3 result.texcoord[4].y, R3, R1;
MAD R1.xyz, -c[23], c[23].w, R0;
MUL R2.xyz, c[23], c[23].w;
MOV R0.z, vertex.texcoord[1].x;
MOV R0.xy, vertex.texcoord[0];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
DP4 R0.w, vertex.position, c[12];
MOV result.texcoord[0].xyz, R0;
ABS result.texcoord[1].xyz, R0;
DP4 R0.x, vertex.position, c[9];
DP4 R0.y, vertex.position, c[10];
DP4 R0.z, vertex.position, c[11];
DP4 result.texcoord[5].w, R0, c[20];
DP4 result.texcoord[5].z, R0, c[19];
DP4 result.texcoord[5].y, R0, c[18];
DP4 result.texcoord[5].x, R0, c[17];
DP4 R0.x, vertex.position, c[3];
MUL R0.y, vertex.texcoord[1], c[24].x;
MOV result.texcoord[2].z, -R0.x;
MIN R0.x, R0.y, c[0];
MAD result.texcoord[3].xyz, R1, c[26].x, R2;
DP3 result.texcoord[4].z, vertex.normal, R3;
DP3 result.texcoord[4].x, R3, vertex.attrib[14];
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
MOV result.texcoord[2].y, vertex.color.w;
MAX result.texcoord[2].x, R0, c[0].y;
END
# 43 instructions, 4 R-regs
"
				}
				SubProgram "d3d9 " {
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
					Bind "tangent"
					TexCoord2
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 8[_Object2World]
					Matrix 12[_World2Object]
					Matrix 16[_LightMatrix0]
					Vector 20[_WorldSpaceLightPos0]
					Vector 21[unity_Scale]
					Vector 22[_tintColor]
					Float 23[_steepPower]
					Float 24[_saturation]
					Float 25[_contrast]
					"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c26, 0.29899999, 0.58700001, 0.11400000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dcl_color0 v5
mov r0, c14
dp4 r2.z, c20, r0
mov r0, c13
dp4 r2.y, c20, r0
mov r1, c12
dp4 r2.x, c20, r1
mad r3.xyz, r2, c21.w, -v0
mov r1.xyz, v1
dp3 r0.w, v5, c26
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r1.yzxw
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
add r0.xyz, v5, -r0.w
mul r1.xyz, r1, v1.w
mad r0.xyz, r0, c24.x, r0.w
dp3 o5.y, r3, r1
mad r1.xyz, -c22, c22.w, r0
mul r2.xyz, c22, c22.w
mov r0.z, v4.x
mov r0.xy, v3
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp4 r0.w, v0, c11
mov o1.xyz, r0
abs o2.xyz, r0
dp4 r0.x, v0, c8
dp4 r0.z, v0, c10
dp4 r0.y, v0, c9
dp4 o6.w, r0, c19
dp4 o6.z, r0, c18
dp4 o6.y, r0, c17
dp4 o6.x, r0, c16
dp4 r0.x, v0, c2
mad o4.xyz, r1, c25.x, r2
dp3 o5.z, v2, r3
dp3 o5.x, r3, v1
dp4 o0.w, v0, c7
dp4 o0.z, v0, c6
dp4 o0.y, v0, c5
dp4 o0.x, v0, c4
mov o3.z, -r0.x
mov o3.y, v5.w
mul_sat o3.x, v4.y, c23
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
					Bind "tangent"
					TexCoord2
					ConstBuffer "$Globals"
					256
					Matrix 48[_LightMatrix0]
					Vector 112[_tintColor]
					Float 144[_steepPower]
					Float 240[_saturation]
					Float 244[_contrast]
					ConstBuffer "UnityLighting"
					720
					Vector 0[_WorldSpaceLightPos0]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 192[_Object2World]
					Matrix 256[_World2Object]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityLighting"
					1
					BindCB "UnityPerDraw"
					2 "vs_4_0
eefiecedknekkcahamdopikinlholikobmkcknmnabaaaaaahaaiaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefckeagaaaaeaaaabaakjabaaaafjaaaaaeegiocaaaaaaaaaaa
baaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaa
fpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadpccabaaa
agaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafdcaabaaaaaaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaa
aaaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaa
abaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadicaaaaibccabaaaadaaaaaa
bkbabaaaaeaaaaaaakiacaaaaaaaaaaaajaaaaaadgaaaaafcccabaaaadaaaaaa
dkbabaaaafaaaaaabaaaaaakbcaabaaaaaaaaaaaegbcbaaaafaaaaaaaceaaaaa
ihbgjjdokcefbgdpnfhiojdnaaaaaaaaaaaaaaaiocaabaaaaaaaaaaaagaabaia
ebaaaaaaaaaaaaaaagbjbaaaafaaaaaadcaaaaakhcaabaaaaaaaaaaaagiacaaa
aaaaaaaaapaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaadcaaaaamhcaabaaa
aaaaaaaaegiccaiaebaaaaaaaaaaaaaaahaaaaaapgipcaaaaaaaaaaaahaaaaaa
egacbaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaapgipcaaaaaaaaaaaahaaaaaa
egiccaaaaaaaaaaaahaaaaaadcaaaaakhccabaaaaeaaaaaafgifcaaaaaaaaaaa
apaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaa
jgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaa
acaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaa
fgifcaaaabaaaaaaaaaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaa
abaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
acaaaaaabdaaaaaapgipcaaaabaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaacaaaaaabeaaaaaaegbcbaia
ebaaaaaaaaaaaaaabaaaaaahcccabaaaafaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbccabaaaafaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaaheccabaaaafaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaaaaaaaaaaaaeaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpccabaaaagaaaaaaegiocaaaaaaaaaaaagaaaaaapgapbaaa
aaaaaaaaegaobaaaabaaaaaadoaaaaab"
				}
				SubProgram "opengl " {
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
					Bind "tangent"
					ATTR14
					Matrix 9[_Object2World]
					Matrix 13[_World2Object]
					Matrix 17[_LightMatrix0]
					Vector 21[_WorldSpaceLightPos0]
					Vector 22[unity_Scale]
					Vector 23[_tintColor]
					Float 24[_steepPower]
					Float 25[_saturation]
					Float 26[_contrast]
					"3.0-!!ARBvp1.0
PARAM c[28] = { { 1, 0 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..26],
		{ 0.29899999, 0.58700001, 0.114 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0, c[21];
DP4 R1.z, R0, c[15];
DP4 R1.y, R0, c[14];
DP4 R1.x, R0, c[13];
MAD R3.xyz, R1, c[22].w, -vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
DP3 R0.w, vertex.color, c[27];
ADD R0.xyz, vertex.color, -R0.w;
MUL R1.xyz, R1, vertex.attrib[14].w;
MAD R0.xyz, R0, c[25].x, R0.w;
DP3 result.texcoord[4].y, R3, R1;
MAD R1.xyz, -c[23], c[23].w, R0;
MUL R2.xyz, c[23], c[23].w;
MOV R0.z, vertex.texcoord[1].x;
MOV R0.xy, vertex.texcoord[0];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
MOV result.texcoord[0].xyz, R0;
ABS result.texcoord[1].xyz, R0;
DP4 R0.x, vertex.position, c[9];
DP4 R0.y, vertex.position, c[10];
DP4 R0.w, vertex.position, c[12];
DP4 R0.z, vertex.position, c[11];
DP4 result.texcoord[5].z, R0, c[19];
DP4 result.texcoord[5].y, R0, c[18];
DP4 result.texcoord[5].x, R0, c[17];
DP4 R0.x, vertex.position, c[3];
MUL R0.y, vertex.texcoord[1], c[24].x;
MOV result.texcoord[2].z, -R0.x;
MIN R0.x, R0.y, c[0];
MAD result.texcoord[3].xyz, R1, c[26].x, R2;
DP3 result.texcoord[4].z, vertex.normal, R3;
DP3 result.texcoord[4].x, R3, vertex.attrib[14];
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
MOV result.texcoord[2].y, vertex.color.w;
MAX result.texcoord[2].x, R0, c[0].y;
END
# 42 instructions, 4 R-regs
"
				}
				SubProgram "d3d9 " {
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
					Bind "tangent"
					TexCoord2
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 8[_Object2World]
					Matrix 12[_World2Object]
					Matrix 16[_LightMatrix0]
					Vector 20[_WorldSpaceLightPos0]
					Vector 21[unity_Scale]
					Vector 22[_tintColor]
					Float 23[_steepPower]
					Float 24[_saturation]
					Float 25[_contrast]
					"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c26, 0.29899999, 0.58700001, 0.11400000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dcl_color0 v5
mov r0, c14
dp4 r2.z, c20, r0
mov r0, c13
dp4 r2.y, c20, r0
mov r1, c12
dp4 r2.x, c20, r1
mad r3.xyz, r2, c21.w, -v0
mov r1.xyz, v1
dp3 r0.w, v5, c26
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r1.yzxw
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
add r0.xyz, v5, -r0.w
mul r1.xyz, r1, v1.w
mad r0.xyz, r0, c24.x, r0.w
dp3 o5.y, r3, r1
mad r1.xyz, -c22, c22.w, r0
mul r2.xyz, c22, c22.w
mov r0.z, v4.x
mov r0.xy, v3
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov o1.xyz, r0
abs o2.xyz, r0
dp4 r0.x, v0, c8
dp4 r0.w, v0, c11
dp4 r0.z, v0, c10
dp4 r0.y, v0, c9
dp4 o6.z, r0, c18
dp4 o6.y, r0, c17
dp4 o6.x, r0, c16
dp4 r0.x, v0, c2
mad o4.xyz, r1, c25.x, r2
dp3 o5.z, v2, r3
dp3 o5.x, r3, v1
dp4 o0.w, v0, c7
dp4 o0.z, v0, c6
dp4 o0.y, v0, c5
dp4 o0.x, v0, c4
mov o3.z, -r0.x
mov o3.y, v5.w
mul_sat o3.x, v4.y, c23
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
					Bind "tangent"
					TexCoord2
					ConstBuffer "$Globals"
					256
					Matrix 48[_LightMatrix0]
					Vector 112[_tintColor]
					Float 144[_steepPower]
					Float 240[_saturation]
					Float 244[_contrast]
					ConstBuffer "UnityLighting"
					720
					Vector 0[_WorldSpaceLightPos0]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 192[_Object2World]
					Matrix 256[_World2Object]
					Vector 320[unity_Scale]
					BindCB "$Globals"
					0
					BindCB "UnityLighting"
					1
					BindCB "UnityPerDraw"
					2 "vs_4_0
eefieceddlmacocaaboanocobkcfgeohcmelfcchabaaaaaahaaiaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefckeagaaaaeaaaabaakjabaaaafjaaaaaeegiocaaaaaaaaaaa
baaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaa
fpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaa
agaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafdcaabaaaaaaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaa
aaaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaa
abaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadicaaaaibccabaaaadaaaaaa
bkbabaaaaeaaaaaaakiacaaaaaaaaaaaajaaaaaadgaaaaafcccabaaaadaaaaaa
dkbabaaaafaaaaaabaaaaaakbcaabaaaaaaaaaaaegbcbaaaafaaaaaaaceaaaaa
ihbgjjdokcefbgdpnfhiojdnaaaaaaaaaaaaaaaiocaabaaaaaaaaaaaagaabaia
ebaaaaaaaaaaaaaaagbjbaaaafaaaaaadcaaaaakhcaabaaaaaaaaaaaagiacaaa
aaaaaaaaapaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaadcaaaaamhcaabaaa
aaaaaaaaegiccaiaebaaaaaaaaaaaaaaahaaaaaapgipcaaaaaaaaaaaahaaaaaa
egacbaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaapgipcaaaaaaaaaaaahaaaaaa
egiccaaaaaaaaaaaahaaaaaadcaaaaakhccabaaaaeaaaaaafgifcaaaaaaaaaaa
apaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaa
jgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaa
acaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaa
fgifcaaaabaaaaaaaaaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaa
abaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
acaaaaaabdaaaaaapgipcaaaabaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaacaaaaaabeaaaaaaegbcbaia
ebaaaaaaaaaaaaaabaaaaaahcccabaaaafaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbccabaaaafaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaaheccabaaaafaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhccabaaaagaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadoaaaaab"
				}
				SubProgram "opengl " {
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
					Bind "tangent"
					ATTR14
					Matrix 9[_Object2World]
					Matrix 13[_World2Object]
					Matrix 17[_LightMatrix0]
					Vector 21[_WorldSpaceLightPos0]
					Vector 22[_tintColor]
					Float 23[_steepPower]
					Float 24[_saturation]
					Float 25[_contrast]
					"3.0-!!ARBvp1.0
PARAM c[27] = { { 0, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..25],
		{ 0.29899999, 0.58700001, 0.114 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R1.xyz, R0, vertex.attrib[14].w;
MOV R0, c[21];
DP3 R1.w, vertex.color, c[26];
ADD R2.xyz, vertex.color, -R1.w;
MAD R2.xyz, R2, c[24].x, R1.w;
DP4 R3.z, R0, c[15];
DP4 R3.y, R0, c[14];
DP4 R3.x, R0, c[13];
DP3 result.texcoord[4].y, R3, R1;
MOV R0.z, vertex.texcoord[1].x;
MOV R0.xy, vertex.texcoord[0];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
MOV result.texcoord[0].xyz, R0;
ABS result.texcoord[1].xyz, R0;
DP4 R0.x, vertex.position, c[9];
DP4 R0.y, vertex.position, c[10];
DP4 R0.w, vertex.position, c[12];
DP4 R0.z, vertex.position, c[11];
DP4 result.texcoord[5].y, R0, c[18];
DP4 result.texcoord[5].x, R0, c[17];
DP4 R0.y, vertex.position, c[3];
MUL R0.x, vertex.texcoord[1].y, c[23];
MIN R0.x, R0, c[0].y;
MAD R2.xyz, -c[22], c[22].w, R2;
MUL R1.xyz, c[22], c[22].w;
MAD result.texcoord[3].xyz, R2, c[25].x, R1;
DP3 result.texcoord[4].z, vertex.normal, R3;
DP3 result.texcoord[4].x, R3, vertex.attrib[14];
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
MOV result.texcoord[2].z, -R0.y;
MOV result.texcoord[2].y, vertex.color.w;
MAX result.texcoord[2].x, R0, c[0];
END
# 40 instructions, 4 R-regs
"
				}
				SubProgram "d3d9 " {
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
					Bind "tangent"
					TexCoord2
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 8[_Object2World]
					Matrix 12[_World2Object]
					Matrix 16[_LightMatrix0]
					Vector 20[_WorldSpaceLightPos0]
					Vector 21[_tintColor]
					Float 22[_steepPower]
					Float 23[_saturation]
					Float 24[_contrast]
					"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c25, 0.29899999, 0.58700001, 0.11400000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dcl_color0 v5
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
dp3 r1.w, v5, c25
mul r2.xyz, r0, v1.w
add r1.xyz, v5, -r1.w
mov r0, c14
dp4 r4.z, c20, r0
mov r0, c13
dp4 r4.y, c20, r0
mad r3.xyz, r1, c23.x, r1.w
mov r1, c12
dp4 r4.x, c20, r1
dp3 o5.y, r4, r2
mov r0.z, v4.x
mov r0.xy, v3
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov o1.xyz, r0
abs o2.xyz, r0
dp4 r0.x, v0, c8
dp4 r0.w, v0, c11
dp4 r0.z, v0, c10
dp4 r0.y, v0, c9
mad r2.xyz, -c21, c21.w, r3
mul r1.xyz, c21, c21.w
dp4 o6.y, r0, c17
dp4 o6.x, r0, c16
dp4 r0.x, v0, c2
mad o4.xyz, r2, c24.x, r1
dp3 o5.z, v2, r4
dp3 o5.x, r4, v1
dp4 o0.w, v0, c7
dp4 o0.z, v0, c6
dp4 o0.y, v0, c5
dp4 o0.x, v0, c4
mov o3.z, -r0.x
mov o3.y, v5.w
mul_sat o3.x, v4.y, c22
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
					Bind "tangent"
					TexCoord2
					ConstBuffer "$Globals"
					256
					Matrix 48[_LightMatrix0]
					Vector 112[_tintColor]
					Float 144[_steepPower]
					Float 240[_saturation]
					Float 244[_contrast]
					ConstBuffer "UnityLighting"
					720
					Vector 0[_WorldSpaceLightPos0]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					Matrix 192[_Object2World]
					Matrix 256[_World2Object]
					BindCB "$Globals"
					0
					BindCB "UnityLighting"
					1
					BindCB "UnityPerDraw"
					2 "vs_4_0
eefiecedkcheadgeempcdkhldjcfepkgigcnnpglabaaaaaaeeaiaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefchiagaaaaeaaaabaajoabaaaafjaaaaaeegiocaaaaaaaaaaa
baaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
beaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaa
fpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaaddccabaaa
agaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafdcaabaaaaaaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaa
aaaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaa
abaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadicaaaaibccabaaaadaaaaaa
bkbabaaaaeaaaaaaakiacaaaaaaaaaaaajaaaaaadgaaaaafcccabaaaadaaaaaa
dkbabaaaafaaaaaabaaaaaakbcaabaaaaaaaaaaaegbcbaaaafaaaaaaaceaaaaa
ihbgjjdokcefbgdpnfhiojdnaaaaaaaaaaaaaaaiocaabaaaaaaaaaaaagaabaia
ebaaaaaaaaaaaaaaagbjbaaaafaaaaaadcaaaaakhcaabaaaaaaaaaaaagiacaaa
aaaaaaaaapaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaadcaaaaamhcaabaaa
aaaaaaaaegiccaiaebaaaaaaaaaaaaaaahaaaaaapgipcaaaaaaaaaaaahaaaaaa
egacbaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaapgipcaaaaaaaaaaaahaaaaaa
egiccaaaaaaaaaaaahaaaaaadcaaaaakhccabaaaaeaaaaaafgifcaaaaaaaaaaa
apaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaa
jgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaa
acaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaa
fgifcaaaabaaaaaaaaaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaa
abaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
acaaaaaabdaaaaaapgipcaaaabaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
cccabaaaafaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
afaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaafaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaidcaabaaaabaaaaaafgafbaaaaaaaaaaaegiacaaa
aaaaaaaaaeaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaaadaaaaaa
agaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaa
aaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaabaaaaaaaaaaadcaaaaakdccabaaa
agaaaaaaegiacaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegaabaaaaaaaaaaa
doaaaaab"
				}
			}
			Program "fp" {
				SubProgram "opengl " {
					Keywords {
						"POINT"
					}
					Vector 0[_LightColor0]
					Float 1[_texTiling]
					Float 2[_texPower]
					Float 3[_groundTexStart]
					Float 4[_groundTexEnd]
					Float 5[_steepTiling]
					Float 6[_steepTexStart]
					Float 7[_steepTexEnd]
					Float 8[_multiPower]
					Float 9[_deepMultiFactor]
					Float 10[_mainMultiFactor]
					Float 11[_highMultiFactor]
					Float 12[_snowMultiFactor]
					Float 13[_deepStart]
					Float 14[_deepEnd]
					Float 15[_mainLoStart]
					Float 16[_mainLoEnd]
					Float 17[_mainHiStart]
					Float 18[_mainHiEnd]
					Float 19[_hiLoStart]
					Float 20[_hiLoEnd]
					Float 21[_hiHiStart]
					Float 22[_hiHiEnd]
					Float 23[_snowStart]
					Float 24[_snowEnd]
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 1
					SetTexture 2[_highTex] 2D 2
					SetTexture 3[_snowTex] 2D 3
					SetTexture 4[_deepMultiTex] 2D 4
					SetTexture 5[_mainMultiTex] 2D 5
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[_LightTexture0] 2D 9 "3.0-!!ARBfp1.0
PARAM c[27] = { program.local[0..25],
		{ 0, 2, 3, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.x, c[3];
ADD R0.x, -R0, c[4];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].z, -c[3];
MUL_SAT R0.w, R0.x, R0.y;
MUL R3.xyz, fragment.texcoord[0], c[1].x;
MAD R1.x, -R0.w, c[26].y, c[26].z;
MUL R0.w, R0, R0;
MOV R2.w, c[13].x;
ADD R2.w, -R2, c[14].x;
RCP R4.x, R2.w;
ADD R2.w, fragment.texcoord[2].y, -c[13].x;
MUL_SAT R2.w, R2, R4.x;
TEX R0.xyz, R3.zyzw, texture[1], 2D;
MUL R0.w, R0, R1.x;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[1], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R0, R1;
ADD R0.x, -R0.w, c[26].w;
MOV R0.z, c[17].x;
ADD R0.z, -R0, c[18].x;
RCP R1.w, R0.z;
ADD R0.z, fragment.texcoord[2].y, -c[17].x;
MUL_SAT R1.w, R0.z, R1;
MOV R0.y, c[15].x;
ADD R0.y, -R0, c[16].x;
RCP R0.z, R0.y;
ADD R0.y, fragment.texcoord[2], -c[15].x;
MUL_SAT R0.y, R0, R0.z;
MUL R0.w, R0, c[8].x;
MAD R2.x, -R1.w, c[26].y, c[26].z;
MUL R0.z, R1.w, R1.w;
MUL R1.w, R0.z, R2.x;
MUL R0.z, R0.y, R0.y;
MAD R0.y, -R0, c[26], c[26].z;
MAD R3.w, R0.z, R0.y, -R1;
MUL R1.w, R0.x, c[2].x;
MUL R2.x, R1.w, R3.w;
TEX R0.xyz, R3.zxzw, texture[1], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R0, R1;
MUL R1.xyz, R0, R2.x;
TEX R2.xyz, R3.zyzw, texture[0], 2D;
TEX R0.xyz, R3, texture[0], 2D;
MUL R2.xyz, fragment.texcoord[1].x, R2;
MAD R2.xyz, fragment.texcoord[1].z, R0, R2;
MAD R0.y, -R2.w, c[26], c[26].z;
MUL R0.x, R2.w, R2.w;
MAD R4.x, -R0, R0.y, c[26].w;
TEX R0.xyz, R3.zxzw, texture[0], 2D;
MUL R2.w, R1, R4.x;
MAD R2.xyz, fragment.texcoord[1].y, R0, R2;
TEX R0.xyz, R3.zyzw, texture[2], 2D;
MAD R2.xyz, R2, R2.w, R1;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[2], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R0, R1;
MOV R0.y, c[21].x;
ADD R0.y, -R0, c[22].x;
RCP R0.z, R0.y;
ADD R0.y, fragment.texcoord[2], -c[21].x;
MUL_SAT R0.z, R0.y, R0;
MOV R0.x, c[19];
ADD R0.x, -R0, c[20];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].y, -c[19];
MUL_SAT R0.x, R0, R0.y;
MAD R2.w, -R0.z, c[26].y, c[26].z;
MUL R0.y, R0.z, R0.z;
MUL R0.z, R0.y, R2.w;
MUL R0.y, R0.x, R0.x;
MAD R0.x, -R0, c[26].y, c[26].z;
MAD R2.w, R0.y, R0.x, -R0.z;
TEX R0.xyz, R3.zxzw, texture[2], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R0, R1;
MUL R1.x, R1.w, R2.w;
MAD R2.xyz, R0, R1.x, R2;
TEX R1.xyz, R3.zyzw, texture[3], 2D;
TEX R0.xyz, R3, texture[3], 2D;
MUL R1.xyz, fragment.texcoord[1].x, R1;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[3], 2D;
MOV R3.y, c[23].x;
ADD R3.y, -R3, c[24].x;
MAD R1.xyz, fragment.texcoord[1].y, R1, R0;
RCP R3.y, R3.y;
ADD R3.x, fragment.texcoord[2].y, -c[23];
MUL_SAT R3.x, R3, R3.y;
MAD R0.y, -R3.x, c[26], c[26].z;
MUL R0.x, R3, R3;
MUL R4.y, R0.x, R0;
MUL R3.xyz, fragment.texcoord[0], c[9].x;
MUL R4.z, R1.w, R4.y;
TEX R0.xyz, R3.zyzw, texture[4], 2D;
MAD R2.xyz, R1, R4.z, R2;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[4], 2D;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[4], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R1, R0;
MUL R1.xyz, fragment.texcoord[0], c[10].x;
MUL R4.x, R0.w, R4;
MAD R0.xyz, R0, R4.x, R2;
TEX R3.xyz, R1.zyzw, texture[5], 2D;
TEX R2.xyz, R1, texture[5], 2D;
MUL R3.xyz, fragment.texcoord[1].x, R3;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[5], 2D;
MAD R3.xyz, fragment.texcoord[1].y, R1, R2;
MUL R1.xyz, fragment.texcoord[0], c[11].x;
MUL R3.w, R0, R3;
TEX R2.xyz, R1.zyzw, texture[6], 2D;
MAD R0.xyz, R3, R3.w, R0;
MUL R3.xyz, fragment.texcoord[1].x, R2;
TEX R2.xyz, R1, texture[6], 2D;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[6], 2D;
MAD R3.xyz, fragment.texcoord[1].y, R1, R2;
MUL R1.xyz, fragment.texcoord[0], c[12].x;
MUL R2.w, R0, R2;
TEX R2.xyz, R1.zyzw, texture[7], 2D;
MAD R0.xyz, R3, R2.w, R0;
MUL R3.xyz, fragment.texcoord[1].x, R2;
TEX R2.xyz, R1, texture[7], 2D;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[7], 2D;
MAD R1.xyz, fragment.texcoord[1].y, R1, R2;
MUL R2.x, R0.w, R4.y;
MAD R0.xyz, R1, R2.x, R0;
MAD R1.xyz, fragment.texcoord[3], R0, -fragment.texcoord[3];
ADD R0.x, R1.w, R0.w;
MOV R0.w, c[6].x;
ADD R0.w, -R0, c[7].x;
RCP R1.w, R0.w;
ADD R0.w, fragment.texcoord[2].z, -c[6].x;
MAD R2.xyz, R0.x, R1, fragment.texcoord[3];
MUL R3.xyz, fragment.texcoord[0], c[5].x;
TEX R1.xyz, R3.zyzw, texture[8], 2D;
MUL R1.xyz, fragment.texcoord[1].x, R1;
TEX R0.xyz, R3, texture[8], 2D;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[8], 2D;
MAD R0.xyz, R1, fragment.texcoord[1].y, R0;
MUL_SAT R0.w, R0, R1;
MAD R1.x, -R0.w, c[26].y, c[26].z;
MUL R0.w, R0, R0;
MAD R0.w, -R0, R1.x, c[26];
ADD R1.xyz, R0, -R2;
MUL R0.x, fragment.texcoord[2], R0.w;
MAD R0.xyz, R0.x, R1, R2;
DP3 R0.w, fragment.texcoord[4], fragment.texcoord[4];
RSQ R0.w, R0.w;
MUL R1.x, R0.w, fragment.texcoord[4].z;
DP3 R1.y, fragment.texcoord[5], fragment.texcoord[5];
MUL R0.xyz, R0, c[0];
TEX R0.w, R1.y, texture[9], 2D;
MAX R1.x, R1, c[26];
MUL R0.w, R1.x, R0;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[26].y;
MOV result.color.w, c[26].x;
END
# 160 instructions, 5 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"POINT"
					}
					Vector 0[_LightColor0]
					Float 1[_texTiling]
					Float 2[_texPower]
					Float 3[_groundTexStart]
					Float 4[_groundTexEnd]
					Float 5[_steepTiling]
					Float 6[_steepTexStart]
					Float 7[_steepTexEnd]
					Float 8[_multiPower]
					Float 9[_deepMultiFactor]
					Float 10[_mainMultiFactor]
					Float 11[_highMultiFactor]
					Float 12[_snowMultiFactor]
					Float 13[_deepStart]
					Float 14[_deepEnd]
					Float 15[_mainLoStart]
					Float 16[_mainLoEnd]
					Float 17[_mainHiStart]
					Float 18[_mainHiEnd]
					Float 19[_hiLoStart]
					Float 20[_hiLoEnd]
					Float 21[_hiHiStart]
					Float 22[_hiHiEnd]
					Float 23[_snowStart]
					Float 24[_snowEnd]
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 1
					SetTexture 2[_highTex] 2D 2
					SetTexture 3[_snowTex] 2D 3
					SetTexture 4[_deepMultiTex] 2D 4
					SetTexture 5[_mainMultiTex] 2D 5
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[_LightTexture0] 2D 9 "ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
dcl_2d s8
dcl_2d s9
def c25, 0.00000000, 2.00000000, 3.00000000, 1.00000000
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
mov r0.x, c4
add r0.w, -c3.x, r0.x
mul r0.xyz, v0, c1.x
rcp r1.x, r0.w
texld r3.xyz, r0.zyzw, s0
add r0.w, v2.z, -c3.x
mul_sat r0.w, r0, r1.x
texld r1.xyz, r0.zyzw, s1
mad r1.w, -r0, c25.y, c25.z
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s1
mad r2.xyz, v1.z, r1, r2
mul r0.w, r0, r0
mul r0.w, r0, r1
add r1.x, -r0.w, c25.w
mov r1.z, c18.x
add r1.z, -c17.x, r1
rcp r1.w, r1.z
add r1.z, v2.y, -c17.x
mul_sat r1.w, r1.z, r1
mov r1.y, c16.x
add r1.y, -c15.x, r1
rcp r1.z, r1.y
add r1.y, v2, -c15.x
mul_sat r1.y, r1, r1.z
mul r0.w, r0, c8.x
mad r2.w, -r1, c25.y, c25.z
mul r1.z, r1.w, r1.w
mul r1.w, r1.z, r2
mul r1.z, r1.y, r1.y
mad r1.y, -r1, c25, c25.z
mad r3.w, r1.z, r1.y, -r1
mul r1.w, r1.x, c2.x
mul r2.w, r1, r3
texld r1.xyz, r0.zxzw, s1
mad r1.xyz, v1.y, r1, r2
mul r2.xyz, r1, r2.w
mov r2.w, c14.x
add r2.w, -c13.x, r2
rcp r4.x, r2.w
add r2.w, v2.y, -c13.x
texld r1.xyz, r0, s0
mul r3.xyz, v1.x, r3
mul_sat r2.w, r2, r4.x
mad r3.xyz, v1.z, r1, r3
mad r1.y, -r2.w, c25, c25.z
mul r1.x, r2.w, r2.w
mad r4.x, -r1, r1.y, c25.w
mul r2.w, r1, r4.x
texld r1.xyz, r0.zxzw, s0
mad r3.xyz, v1.y, r1, r3
mad r3.xyz, r3, r2.w, r2
texld r1.xyz, r0.zyzw, s2
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s2
mad r2.xyz, v1.z, r1, r2
mov r1.y, c22.x
add r1.y, -c21.x, r1
rcp r1.z, r1.y
add r1.y, v2, -c21.x
mul_sat r1.z, r1.y, r1
mov r1.x, c20
add r1.x, -c19, r1
rcp r1.y, r1.x
add r1.x, v2.y, -c19
mul_sat r1.x, r1, r1.y
mad r2.w, -r1.z, c25.y, c25.z
mul r1.y, r1.z, r1.z
mul r1.z, r1.y, r2.w
mul r1.y, r1.x, r1.x
mad r1.x, -r1, c25.y, c25.z
mad r2.w, r1.y, r1.x, -r1.z
texld r1.xyz, r0.zxzw, s2
mad r1.xyz, v1.y, r1, r2
mul r2.x, r1.w, r2.w
mad r2.xyz, r1, r2.x, r3
texld r1.xyz, r0.zyzw, s3
texld r3.xyz, r0, s3
mul r1.xyz, v1.x, r1
mad r1.xyz, v1.z, r3, r1
mov r0.y, c24.x
add r3.x, -c23, r0.y
rcp r3.y, r3.x
add r3.x, v2.y, -c23
texld r0.xyz, r0.zxzw, s3
mul_sat r4.y, r3.x, r3
mad r3.xyz, v1.y, r0, r1
mad r0.y, -r4, c25, c25.z
mul r0.x, r4.y, r4.y
mul r4.y, r0.x, r0
mul r0.xyz, v0, c9.x
mul r4.z, r1.w, r4.y
mad r3.xyz, r3, r4.z, r2
texld r1.xyz, r0.zyzw, s4
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s4
mad r1.xyz, v1.z, r1, r2
texld r0.xyz, r0.zxzw, s4
mad r1.xyz, v1.y, r0, r1
mul r0.xyz, v0, c10.x
mul r4.x, r0.w, r4
texld r2.xyz, r0.zyzw, s5
mad r1.xyz, r1, r4.x, r3
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s5
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s5
mad r3.xyz, v1.y, r0, r2
mul r0.xyz, v0, c11.x
mul r3.w, r0, r3
texld r2.xyz, r0.zyzw, s6
mad r1.xyz, r3, r3.w, r1
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s6
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s6
mad r3.xyz, v1.y, r0, r2
mul r0.xyz, v0, c12.x
mul r2.w, r0, r2
texld r2.xyz, r0.zyzw, s7
mad r1.xyz, r3, r2.w, r1
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s7
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s7
mad r0.xyz, v1.y, r0, r2
mul r2.x, r0.w, r4.y
mad r0.xyz, r0, r2.x, r1
mad r1.xyz, v3, r0, -v3
mul r0.xyz, v0, c5.x
add r0.w, r1, r0
mad r3.xyz, r0.w, r1, v3
texld r1.xyz, r0.zyzw, s8
texld r2.xyz, r0, s8
mov r0.y, c7.x
add r0.w, -c6.x, r0.y
rcp r1.w, r0.w
mul r1.xyz, v1.x, r1
add r0.w, v2.z, -c6.x
mad r1.xyz, v1.z, r2, r1
texld r0.xyz, r0.zxzw, s8
mad r0.xyz, r0, v1.y, r1
mul_sat r0.w, r0, r1
mad r1.x, -r0.w, c25.y, c25.z
mul r0.w, r0, r0
mad r0.w, -r0, r1.x, c25
add r1.xyz, r0, -r3
mul r0.x, v2, r0.w
mad r1.xyz, r0.x, r1, r3
dp3_pp r0.x, v4, v4
rsq_pp r0.y, r0.x
dp3 r0.x, v5, v5
mul_pp r0.y, r0, v4.z
max_pp r0.y, r0, c25.x
texld r0.x, r0.x, s9
mul_pp r1.xyz, r1, c0
mul_pp r0.x, r0.y, r0
mul_pp r0.xyz, r0.x, r1
mul_pp oC0.xyz, r0, c25.y
mov_pp oC0.w, c25.x
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"POINT"
					}
					SetTexture 0[_deepTex] 2D 1
					SetTexture 1[_mainTex] 2D 3
					SetTexture 2[_highTex] 2D 5
					SetTexture 3[_snowTex] 2D 7
					SetTexture 4[_deepMultiTex] 2D 2
					SetTexture 5[_mainMultiTex] 2D 4
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 8
					SetTexture 8[_steepTex] 2D 9
					SetTexture 9[_LightTexture0] 2D 0
					ConstBuffer "$Globals"
					256
					Vector 16[_LightColor0]
					Float 128[_texTiling]
					Float 132[_texPower]
					Float 136[_groundTexStart]
					Float 140[_groundTexEnd]
					Float 148[_steepTiling]
					Float 152[_steepTexStart]
					Float 156[_steepTexEnd]
					Float 168[_multiPower]
					Float 172[_deepMultiFactor]
					Float 176[_mainMultiFactor]
					Float 180[_highMultiFactor]
					Float 184[_snowMultiFactor]
					Float 188[_deepStart]
					Float 192[_deepEnd]
					Float 196[_mainLoStart]
					Float 200[_mainLoEnd]
					Float 204[_mainHiStart]
					Float 208[_mainHiEnd]
					Float 212[_hiLoStart]
					Float 216[_hiLoEnd]
					Float 220[_hiHiStart]
					Float 224[_hiHiEnd]
					Float 228[_snowStart]
					Float 232[_snowEnd]
					BindCB "$Globals"
					0 "ps_4_0
eefieceddkibgnadjdikkklcjpgcbkgncihallkhabaaaaaaembgaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbebfaaaaeaaaaaaaefafaaaa
fjaaaaaeegiocaaaaaaaaaaaapaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaa
agaaaaaafkaaaaadaagabaaaahaaaaaafkaaaaadaagabaaaaiaaaaaafkaaaaad
aagabaaaajaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaa
afaaaaaaffffaaaafibiaaaeaahabaaaagaaaaaaffffaaaafibiaaaeaahabaaa
ahaaaaaaffffaaaafibiaaaeaahabaaaaiaaaaaaffffaaaafibiaaaeaahabaaa
ajaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
agaaaaaaaaaaaaakbcaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaaalaaaaaa
akiacaaaaaaaaaaaamaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaa
bkbabaaaadaaaaaadkiacaiaebaaaaaaaaaaaaaaalaaaaaadicaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaak
ccaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaadkiacaaaaaaaaaaa
aiaaaaaaaoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpbkaabaaaaaaaaaaaaaaaaaajecaabaaaaaaaaaaackbabaaaadaaaaaa
ckiacaiaebaaaaaaaaaaaaaaaiaaaaaadicaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaackiacaaaaaaaaaaaakaaaaaadiaaaaaiecaabaaaaaaaaaaadkaabaaa
aaaaaaaabkiacaaaaaaaaaaaaiaaaaaadcaaaaakicaabaaaaaaaaaaabkiacaaa
aaaaaaaaaiaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaa
abaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaakccaabaaaabaaaaaadkiacaia
ebaaaaaaaaaaaaaaamaaaaaaakiacaaaaaaaaaaaanaaaaaaaoaaaaakccaabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaabaaaaaa
aaaaaaajmcaabaaaabaaaaaafgbfbaaaadaaaaaafgincaiaebaaaaaaaaaaaaaa
amaaaaaadicaaaahccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaa
dcaaaaajicaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
aaaaeaeadiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaa
diaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaaaaaaaaak
icaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaaamaaaaaackiacaaaaaaaaaaa
amaaaaaaaoaaaaakicaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdkaabaaaabaaaaaadicaaaahecaabaaaabaaaaaadkaabaaaabaaaaaa
ckaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaa
ckaabaaaabaaaaaadcaaaaakccaabaaaabaaaaaadkaabaaaabaaaaaackaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaadiaaaaahecaabaaaabaaaaaackaabaaa
aaaaaaaabkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaaaaaaaaa
bkaabaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaaagiacaaa
aaaaaaaaaiaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaadaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaa
agbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaadaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaaaeaaaaaa
kgbkbaaaacaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaa
acaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaajhcaabaaaadaaaaaa
egacbaaaaeaaaaaafgbfbaaaacaaaaaaegacbaaaadaaaaaadiaaaaahhcaabaaa
adaaaaaakgakbaaaabaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaa
ggakbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaa
aeaaaaaaegacbaaaaeaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaafaaaaaa
egaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaa
aeaaaaaaegacbaaaafaaaaaakgbkbaaaacaaaaaaegacbaaaaeaaaaaaefaaaaaj
pcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaajhcaabaaaaeaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaa
aeaaaaaadcaaaaajncaabaaaabaaaaaaagajbaaaaeaaaaaaagaabaaaabaaaaaa
agajbaaaadaaaaaaaaaaaaakicaabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaa
anaaaaaaakiacaaaaaaaaaaaaoaaaaaaaoaaaaakicaabaaaacaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaacaaaaaaaaaaaaajdcaabaaa
adaaaaaafgbfbaaaadaaaaaangifcaiaebaaaaaaaaaaaaaaanaaaaaadicaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaabkaabaaaadaaaaaadcaaaaajccaabaaa
adaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaabkaabaaaadaaaaaaaaaaaaakccaabaaaadaaaaaa
bkiacaiaebaaaaaaaaaaaaaaanaaaaaackiacaaaaaaaaaaaanaaaaaaaoaaaaak
ccaabaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaa
adaaaaaadicaaaahbcaabaaaadaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaa
dcaaaaajccaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaa
aaaaeaeadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaa
dcaaaaakicaabaaaacaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadkaabaia
ebaaaaaaacaaaaaadiaaaaahbcaabaaaadaaaaaackaabaaaaaaaaaaadkaabaaa
acaaaaaadiaaaaahicaabaaaacaaaaaabkaabaaaaaaaaaaadkaabaaaacaaaaaa
efaaaaajpcaabaaaaeaaaaaaggakbaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
afaaaaaadiaaaaahocaabaaaadaaaaaaagajbaaaaeaaaaaaagbabaaaacaaaaaa
efaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
afaaaaaadcaaaaajocaabaaaadaaaaaaagajbaaaaeaaaaaakgbkbaaaacaaaaaa
fgaobaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaaacaaaaaaeghobaaa
acaaaaaaaagabaaaafaaaaaadcaaaaajocaabaaaadaaaaaaagajbaaaaeaaaaaa
fgbfbaaaacaaaaaafgaobaaaadaaaaaadcaaaaajncaabaaaabaaaaaafgaobaaa
adaaaaaaagaabaaaadaaaaaaagaobaaaabaaaaaaaaaaaaakbcaabaaaadaaaaaa
bkiacaiaebaaaaaaaaaaaaaaaoaaaaaackiacaaaaaaaaaaaaoaaaaaaaoaaaaak
bcaabaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaa
adaaaaaaaaaaaaajccaabaaaadaaaaaabkbabaaaadaaaaaabkiacaiaebaaaaaa
aaaaaaaaaoaaaaaadicaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaa
adaaaaaadcaaaaajccaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaa
adaaaaaadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaa
diaaaaahgcaabaaaaaaaaaaafgagbaaaaaaaaaaaagaabaaaadaaaaaaefaaaaaj
pcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaahaaaaaa
diaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaahaaaaaa
efaaaaajpcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaa
ahaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaa
egacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaa
acaaaaaaegacbaaaacaaaaaadcaaaaajncaabaaaabaaaaaaagajbaaaacaaaaaa
kgakbaaaaaaaaaaaagaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaa
abaaaaaapgipcaaaaaaaaaaaakaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaa
acaaaaaaeghobaaaaeaaaaaaaagabaaaacaaaaaadiaaaaahhcaabaaaadaaaaaa
egacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
acaaaaaaeghobaaaaeaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaafaaaaaa
cgakbaaaacaaaaaaeghobaaaaeaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaa
acaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaa
dcaaaaajncaabaaaabaaaaaaagajbaaaacaaaaaaagaabaaaaaaaaaaaagaobaaa
abaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaa
alaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaafaaaaaa
aagabaaaaeaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaa
acaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaafaaaaaa
aagabaaaaeaaaaaaefaaaaajpcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaa
afaaaaaaaagabaaaaeaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaaeaaaaaa
kgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaa
afaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaa
egacbaaaacaaaaaafgafbaaaabaaaaaaigadbaaaabaaaaaadiaaaaaihcaabaaa
acaaaaaaegbcbaaaabaaaaaafgifcaaaaaaaaaaaalaaaaaaefaaaaajpcaabaaa
adaaaaaaggakbaaaacaaaaaaeghobaaaagaaaaaaaagabaaaagaaaaaadiaaaaah
hcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaacaaaaaaeghobaaaagaaaaaaaagabaaaagaaaaaaefaaaaaj
pcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaagaaaaaaaagabaaaagaaaaaa
dcaaaaajhcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaa
adaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaa
egacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaapgapbaaa
acaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaa
kgikcaaaaaaaaaaaalaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaa
eghobaaaahaaaaaaaagabaaaaiaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaa
adaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaa
eghobaaaahaaaaaaaagabaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaacgakbaaa
acaaaaaaeghobaaaahaaaaaaaagabaaaaiaaaaaadcaaaaajhcaabaaaadaaaaaa
egacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaa
acaaaaaaegacbaaaacaaaaaafgbfbaaaacaaaaaaegacbaaaadaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaacaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaia
ebaaaaaaaeaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaegbcbaaaaeaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaabaaaaaa
fgifcaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaa
eghobaaaaiaaaaaaaagabaaaajaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaa
eghobaaaaiaaaaaaaagabaaaajaaaaaaefaaaaajpcaabaaaabaaaaaacgakbaaa
abaaaaaaeghobaaaaiaaaaaaaagabaaaajaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaadaaaaaakgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaa
abaaaaaaegacbaaaabaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaak
icaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaajaaaaaadkiacaaaaaaaaaaa
ajaaaaaaaoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaackbabaaaadaaaaaa
ckiacaiaebaaaaaaaaaaaaaaajaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaiaebaaaaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakbabaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaackbabaaaafaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaah
bcaabaaaabaaaaaaegbcbaaaagaaaaaaegbcbaaaagaaaaaaefaaaaajpcaabaaa
abaaaaaaagaabaaaabaaaaaaeghobaaaajaaaaaaaagabaaaaaaaaaaaapaaaaah
icaabaaaaaaaaaaapgapbaaaaaaaaaaaagaabaaaabaaaaaadiaaaaahhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaaaaadoaaaaab"
				}
				SubProgram "opengl " {
					Keywords {
						"DIRECTIONAL"
					}
					Vector 0[_LightColor0]
					Float 1[_texTiling]
					Float 2[_texPower]
					Float 3[_groundTexStart]
					Float 4[_groundTexEnd]
					Float 5[_steepTiling]
					Float 6[_steepTexStart]
					Float 7[_steepTexEnd]
					Float 8[_multiPower]
					Float 9[_deepMultiFactor]
					Float 10[_mainMultiFactor]
					Float 11[_highMultiFactor]
					Float 12[_snowMultiFactor]
					Float 13[_deepStart]
					Float 14[_deepEnd]
					Float 15[_mainLoStart]
					Float 16[_mainLoEnd]
					Float 17[_mainHiStart]
					Float 18[_mainHiEnd]
					Float 19[_hiLoStart]
					Float 20[_hiLoEnd]
					Float 21[_hiHiStart]
					Float 22[_hiHiEnd]
					Float 23[_snowStart]
					Float 24[_snowEnd]
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 1
					SetTexture 2[_highTex] 2D 2
					SetTexture 3[_snowTex] 2D 3
					SetTexture 4[_deepMultiTex] 2D 4
					SetTexture 5[_mainMultiTex] 2D 5
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8 "3.0-!!ARBfp1.0
PARAM c[27] = { program.local[0..25],
		{ 0, 2, 3, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.x, c[3];
ADD R0.x, -R0, c[4];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].z, -c[3];
MUL_SAT R0.w, R0.x, R0.y;
MUL R3.xyz, fragment.texcoord[0], c[1].x;
MAD R1.x, -R0.w, c[26].y, c[26].z;
MUL R0.w, R0, R0;
MOV R2.w, c[13].x;
ADD R2.w, -R2, c[14].x;
RCP R4.x, R2.w;
ADD R2.w, fragment.texcoord[2].y, -c[13].x;
MUL_SAT R2.w, R2, R4.x;
TEX R0.xyz, R3.zyzw, texture[1], 2D;
MUL R0.w, R0, R1.x;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[1], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R0, R1;
ADD R0.x, -R0.w, c[26].w;
MOV R0.z, c[17].x;
ADD R0.z, -R0, c[18].x;
RCP R1.w, R0.z;
ADD R0.z, fragment.texcoord[2].y, -c[17].x;
MUL_SAT R1.w, R0.z, R1;
MOV R0.y, c[15].x;
ADD R0.y, -R0, c[16].x;
RCP R0.z, R0.y;
ADD R0.y, fragment.texcoord[2], -c[15].x;
MUL_SAT R0.y, R0, R0.z;
MUL R0.w, R0, c[8].x;
MAD R2.x, -R1.w, c[26].y, c[26].z;
MUL R0.z, R1.w, R1.w;
MUL R1.w, R0.z, R2.x;
MUL R0.z, R0.y, R0.y;
MAD R0.y, -R0, c[26], c[26].z;
MAD R3.w, R0.z, R0.y, -R1;
MUL R1.w, R0.x, c[2].x;
MUL R2.x, R1.w, R3.w;
TEX R0.xyz, R3.zxzw, texture[1], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R0, R1;
MUL R1.xyz, R0, R2.x;
TEX R2.xyz, R3.zyzw, texture[0], 2D;
TEX R0.xyz, R3, texture[0], 2D;
MUL R2.xyz, fragment.texcoord[1].x, R2;
MAD R2.xyz, fragment.texcoord[1].z, R0, R2;
MAD R0.y, -R2.w, c[26], c[26].z;
MUL R0.x, R2.w, R2.w;
MAD R4.x, -R0, R0.y, c[26].w;
TEX R0.xyz, R3.zxzw, texture[0], 2D;
MUL R2.w, R1, R4.x;
MAD R2.xyz, fragment.texcoord[1].y, R0, R2;
TEX R0.xyz, R3.zyzw, texture[2], 2D;
MAD R2.xyz, R2, R2.w, R1;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[2], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R0, R1;
MOV R0.y, c[21].x;
ADD R0.y, -R0, c[22].x;
RCP R0.z, R0.y;
ADD R0.y, fragment.texcoord[2], -c[21].x;
MUL_SAT R0.z, R0.y, R0;
MOV R0.x, c[19];
ADD R0.x, -R0, c[20];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].y, -c[19];
MUL_SAT R0.x, R0, R0.y;
MAD R2.w, -R0.z, c[26].y, c[26].z;
MUL R0.y, R0.z, R0.z;
MUL R0.z, R0.y, R2.w;
MUL R0.y, R0.x, R0.x;
MAD R0.x, -R0, c[26].y, c[26].z;
MAD R2.w, R0.y, R0.x, -R0.z;
TEX R0.xyz, R3.zxzw, texture[2], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R0, R1;
MUL R1.x, R1.w, R2.w;
MAD R2.xyz, R0, R1.x, R2;
TEX R1.xyz, R3.zyzw, texture[3], 2D;
TEX R0.xyz, R3, texture[3], 2D;
MUL R1.xyz, fragment.texcoord[1].x, R1;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[3], 2D;
MOV R3.y, c[23].x;
ADD R3.y, -R3, c[24].x;
MAD R1.xyz, fragment.texcoord[1].y, R1, R0;
RCP R3.y, R3.y;
ADD R3.x, fragment.texcoord[2].y, -c[23];
MUL_SAT R3.x, R3, R3.y;
MAD R0.y, -R3.x, c[26], c[26].z;
MUL R0.x, R3, R3;
MUL R4.y, R0.x, R0;
MUL R3.xyz, fragment.texcoord[0], c[9].x;
MUL R4.z, R1.w, R4.y;
TEX R0.xyz, R3.zyzw, texture[4], 2D;
MAD R2.xyz, R1, R4.z, R2;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[4], 2D;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[4], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R1, R0;
MUL R1.xyz, fragment.texcoord[0], c[10].x;
MUL R4.x, R0.w, R4;
MAD R0.xyz, R0, R4.x, R2;
TEX R3.xyz, R1.zyzw, texture[5], 2D;
TEX R2.xyz, R1, texture[5], 2D;
MUL R3.xyz, fragment.texcoord[1].x, R3;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[5], 2D;
MAD R3.xyz, fragment.texcoord[1].y, R1, R2;
MUL R1.xyz, fragment.texcoord[0], c[11].x;
MUL R3.w, R0, R3;
TEX R2.xyz, R1.zyzw, texture[6], 2D;
MAD R0.xyz, R3, R3.w, R0;
MUL R3.xyz, fragment.texcoord[1].x, R2;
TEX R2.xyz, R1, texture[6], 2D;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[6], 2D;
MAD R3.xyz, fragment.texcoord[1].y, R1, R2;
MUL R1.xyz, fragment.texcoord[0], c[12].x;
MUL R2.w, R0, R2;
TEX R2.xyz, R1.zyzw, texture[7], 2D;
MAD R0.xyz, R3, R2.w, R0;
MUL R3.xyz, fragment.texcoord[1].x, R2;
TEX R2.xyz, R1, texture[7], 2D;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[7], 2D;
MAD R1.xyz, fragment.texcoord[1].y, R1, R2;
MUL R2.x, R0.w, R4.y;
MAD R0.xyz, R1, R2.x, R0;
MAD R1.xyz, fragment.texcoord[3], R0, -fragment.texcoord[3];
ADD R0.x, R1.w, R0.w;
MOV R0.w, c[6].x;
ADD R0.w, -R0, c[7].x;
RCP R1.w, R0.w;
ADD R0.w, fragment.texcoord[2].z, -c[6].x;
MAD R2.xyz, R0.x, R1, fragment.texcoord[3];
MUL R3.xyz, fragment.texcoord[0], c[5].x;
TEX R1.xyz, R3.zyzw, texture[8], 2D;
MUL R1.xyz, fragment.texcoord[1].x, R1;
TEX R0.xyz, R3, texture[8], 2D;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[8], 2D;
MAD R0.xyz, R1, fragment.texcoord[1].y, R0;
MUL_SAT R0.w, R0, R1;
MAD R1.x, -R0.w, c[26].y, c[26].z;
MUL R0.w, R0, R0;
MAD R0.w, -R0, R1.x, c[26];
ADD R1.xyz, R0, -R2;
MUL R0.x, fragment.texcoord[2], R0.w;
MAD R0.xyz, R0.x, R1, R2;
MUL R1.xyz, R0, c[0];
MAX R0.x, fragment.texcoord[4].z, c[26];
MUL R0.xyz, R0.x, R1;
MUL result.color.xyz, R0, c[26].y;
MOV result.color.w, c[26].x;
END
# 154 instructions, 5 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"DIRECTIONAL"
					}
					Vector 0[_LightColor0]
					Float 1[_texTiling]
					Float 2[_texPower]
					Float 3[_groundTexStart]
					Float 4[_groundTexEnd]
					Float 5[_steepTiling]
					Float 6[_steepTexStart]
					Float 7[_steepTexEnd]
					Float 8[_multiPower]
					Float 9[_deepMultiFactor]
					Float 10[_mainMultiFactor]
					Float 11[_highMultiFactor]
					Float 12[_snowMultiFactor]
					Float 13[_deepStart]
					Float 14[_deepEnd]
					Float 15[_mainLoStart]
					Float 16[_mainLoEnd]
					Float 17[_mainHiStart]
					Float 18[_mainHiEnd]
					Float 19[_hiLoStart]
					Float 20[_hiLoEnd]
					Float 21[_hiHiStart]
					Float 22[_hiHiEnd]
					Float 23[_snowStart]
					Float 24[_snowEnd]
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 1
					SetTexture 2[_highTex] 2D 2
					SetTexture 3[_snowTex] 2D 3
					SetTexture 4[_deepMultiTex] 2D 4
					SetTexture 5[_mainMultiTex] 2D 5
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8 "ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
dcl_2d s8
def c25, 0.00000000, 2.00000000, 3.00000000, 1.00000000
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
mov r0.x, c4
add r0.w, -c3.x, r0.x
mul r0.xyz, v0, c1.x
rcp r1.x, r0.w
texld r3.xyz, r0.zyzw, s0
add r0.w, v2.z, -c3.x
mul_sat r0.w, r0, r1.x
texld r1.xyz, r0.zyzw, s1
mad r1.w, -r0, c25.y, c25.z
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s1
mad r2.xyz, v1.z, r1, r2
mul r0.w, r0, r0
mul r0.w, r0, r1
add r1.x, -r0.w, c25.w
mov r1.z, c18.x
add r1.z, -c17.x, r1
rcp r1.w, r1.z
add r1.z, v2.y, -c17.x
mul_sat r1.w, r1.z, r1
mov r1.y, c16.x
add r1.y, -c15.x, r1
rcp r1.z, r1.y
add r1.y, v2, -c15.x
mul_sat r1.y, r1, r1.z
mul r0.w, r0, c8.x
mad r2.w, -r1, c25.y, c25.z
mul r1.z, r1.w, r1.w
mul r1.w, r1.z, r2
mul r1.z, r1.y, r1.y
mad r1.y, -r1, c25, c25.z
mad r3.w, r1.z, r1.y, -r1
mul r1.w, r1.x, c2.x
mul r2.w, r1, r3
texld r1.xyz, r0.zxzw, s1
mad r1.xyz, v1.y, r1, r2
mul r2.xyz, r1, r2.w
mov r2.w, c14.x
add r2.w, -c13.x, r2
rcp r4.x, r2.w
add r2.w, v2.y, -c13.x
texld r1.xyz, r0, s0
mul r3.xyz, v1.x, r3
mul_sat r2.w, r2, r4.x
mad r3.xyz, v1.z, r1, r3
mad r1.y, -r2.w, c25, c25.z
mul r1.x, r2.w, r2.w
mad r4.x, -r1, r1.y, c25.w
mul r2.w, r1, r4.x
texld r1.xyz, r0.zxzw, s0
mad r3.xyz, v1.y, r1, r3
mad r3.xyz, r3, r2.w, r2
texld r1.xyz, r0.zyzw, s2
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s2
mad r2.xyz, v1.z, r1, r2
mov r1.y, c22.x
add r1.y, -c21.x, r1
rcp r1.z, r1.y
add r1.y, v2, -c21.x
mul_sat r1.z, r1.y, r1
mov r1.x, c20
add r1.x, -c19, r1
rcp r1.y, r1.x
add r1.x, v2.y, -c19
mul_sat r1.x, r1, r1.y
mad r2.w, -r1.z, c25.y, c25.z
mul r1.y, r1.z, r1.z
mul r1.z, r1.y, r2.w
mul r1.y, r1.x, r1.x
mad r1.x, -r1, c25.y, c25.z
mad r2.w, r1.y, r1.x, -r1.z
texld r1.xyz, r0.zxzw, s2
mad r1.xyz, v1.y, r1, r2
mul r2.x, r1.w, r2.w
mad r2.xyz, r1, r2.x, r3
texld r1.xyz, r0.zyzw, s3
texld r3.xyz, r0, s3
mul r1.xyz, v1.x, r1
mad r1.xyz, v1.z, r3, r1
mov r0.y, c24.x
add r3.x, -c23, r0.y
rcp r3.y, r3.x
add r3.x, v2.y, -c23
texld r0.xyz, r0.zxzw, s3
mul_sat r4.y, r3.x, r3
mad r3.xyz, v1.y, r0, r1
mad r0.y, -r4, c25, c25.z
mul r0.x, r4.y, r4.y
mul r4.y, r0.x, r0
mul r0.xyz, v0, c9.x
mul r4.z, r1.w, r4.y
mad r3.xyz, r3, r4.z, r2
texld r1.xyz, r0.zyzw, s4
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s4
mad r1.xyz, v1.z, r1, r2
texld r0.xyz, r0.zxzw, s4
mad r1.xyz, v1.y, r0, r1
mul r0.xyz, v0, c10.x
mul r4.x, r0.w, r4
texld r2.xyz, r0.zyzw, s5
mad r1.xyz, r1, r4.x, r3
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s5
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s5
mad r3.xyz, v1.y, r0, r2
mul r0.xyz, v0, c11.x
mul r3.w, r0, r3
texld r2.xyz, r0.zyzw, s6
mad r1.xyz, r3, r3.w, r1
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s6
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s6
mad r3.xyz, v1.y, r0, r2
mul r0.xyz, v0, c12.x
mul r2.w, r0, r2
texld r2.xyz, r0.zyzw, s7
mad r1.xyz, r3, r2.w, r1
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s7
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s7
mad r0.xyz, v1.y, r0, r2
mul r2.x, r0.w, r4.y
mad r0.xyz, r0, r2.x, r1
mad r1.xyz, v3, r0, -v3
mul r0.xyz, v0, c5.x
add r0.w, r1, r0
mad r3.xyz, r0.w, r1, v3
texld r1.xyz, r0.zyzw, s8
texld r2.xyz, r0, s8
mov r0.y, c7.x
add r0.w, -c6.x, r0.y
rcp r1.w, r0.w
mul r1.xyz, v1.x, r1
add r0.w, v2.z, -c6.x
mad r1.xyz, v1.z, r2, r1
texld r0.xyz, r0.zxzw, s8
mad r0.xyz, r0, v1.y, r1
mul_sat r0.w, r0, r1
mad r1.x, -r0.w, c25.y, c25.z
mul r0.w, r0, r0
mad r0.w, -r0, r1.x, c25
add r1.xyz, r0, -r3
mul r0.x, v2, r0.w
mad r0.xyz, r0.x, r1, r3
mul_pp r1.xyz, r0, c0
max_pp r0.x, v4.z, c25
mul_pp r0.xyz, r0.x, r1
mul_pp oC0.xyz, r0, c25.y
mov_pp oC0.w, c25.x
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"DIRECTIONAL"
					}
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 2
					SetTexture 2[_highTex] 2D 4
					SetTexture 3[_snowTex] 2D 6
					SetTexture 4[_deepMultiTex] 2D 1
					SetTexture 5[_mainMultiTex] 2D 3
					SetTexture 6[_highMultiTex] 2D 5
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					ConstBuffer "$Globals"
					192
					Vector 16[_LightColor0]
					Float 64[_texTiling]
					Float 68[_texPower]
					Float 72[_groundTexStart]
					Float 76[_groundTexEnd]
					Float 84[_steepTiling]
					Float 88[_steepTexStart]
					Float 92[_steepTexEnd]
					Float 104[_multiPower]
					Float 108[_deepMultiFactor]
					Float 112[_mainMultiFactor]
					Float 116[_highMultiFactor]
					Float 120[_snowMultiFactor]
					Float 124[_deepStart]
					Float 128[_deepEnd]
					Float 132[_mainLoStart]
					Float 136[_mainLoEnd]
					Float 140[_mainHiStart]
					Float 144[_mainHiEnd]
					Float 148[_hiLoStart]
					Float 152[_hiLoEnd]
					Float 156[_hiHiStart]
					Float 160[_hiHiEnd]
					Float 164[_snowStart]
					Float 168[_snowEnd]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedpmgjcdindkgocnnohagpgkjnbmkfenmoabaaaaaaiabfaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaeaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgabeaaaa
eaaaaaaabiafaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaa
fkaaaaadaagabaaaagaaaaaafkaaaaadaagabaaaahaaaaaafkaaaaadaagabaaa
aiaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaa
ffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaa
ffffaaaafibiaaaeaahabaaaagaaaaaaffffaaaafibiaaaeaahabaaaahaaaaaa
ffffaaaafibiaaaeaahabaaaaiaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagcbaaaadecbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
agaaaaaaaaaaaaakbcaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaaahaaaaaa
akiacaaaaaaaaaaaaiaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaa
bkbabaaaadaaaaaadkiacaiaebaaaaaaaaaaaaaaahaaaaaadicaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaak
ccaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaadkiacaaaaaaaaaaa
aeaaaaaaaoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpbkaabaaaaaaaaaaaaaaaaaajecaabaaaaaaaaaaackbabaaaadaaaaaa
ckiacaiaebaaaaaaaaaaaaaaaeaaaaaadicaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaackiacaaaaaaaaaaaagaaaaaadiaaaaaiecaabaaaaaaaaaaadkaabaaa
aaaaaaaabkiacaaaaaaaaaaaaeaaaaaadcaaaaakicaabaaaaaaaaaaabkiacaaa
aaaaaaaaaeaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaa
abaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaakccaabaaaabaaaaaadkiacaia
ebaaaaaaaaaaaaaaaiaaaaaaakiacaaaaaaaaaaaajaaaaaaaoaaaaakccaabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaabaaaaaa
aaaaaaajmcaabaaaabaaaaaafgbfbaaaadaaaaaafgincaiaebaaaaaaaaaaaaaa
aiaaaaaadicaaaahccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaa
dcaaaaajicaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
aaaaeaeadiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaa
diaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaaaaaaaaak
icaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaaaiaaaaaackiacaaaaaaaaaaa
aiaaaaaaaoaaaaakicaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdkaabaaaabaaaaaadicaaaahecaabaaaabaaaaaadkaabaaaabaaaaaa
ckaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaa
ckaabaaaabaaaaaadcaaaaakccaabaaaabaaaaaadkaabaaaabaaaaaackaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaadiaaaaahecaabaaaabaaaaaackaabaaa
aaaaaaaabkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaaaaaaaaa
bkaabaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaaagiacaaa
aaaaaaaaaeaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaa
agbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaaaeaaaaaa
kgbkbaaaacaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaa
acaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaaadaaaaaa
egacbaaaaeaaaaaafgbfbaaaacaaaaaaegacbaaaadaaaaaadiaaaaahhcaabaaa
adaaaaaakgakbaaaabaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaa
ggakbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaa
aeaaaaaaegacbaaaaeaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaafaaaaaa
egaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaa
aeaaaaaaegacbaaaafaaaaaakgbkbaaaacaaaaaaegacbaaaaeaaaaaaefaaaaaj
pcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaajhcaabaaaaeaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaa
aeaaaaaadcaaaaajncaabaaaabaaaaaaagajbaaaaeaaaaaaagaabaaaabaaaaaa
agajbaaaadaaaaaaaaaaaaakicaabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaa
ajaaaaaaakiacaaaaaaaaaaaakaaaaaaaoaaaaakicaabaaaacaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaacaaaaaaaaaaaaajdcaabaaa
adaaaaaafgbfbaaaadaaaaaangifcaiaebaaaaaaaaaaaaaaajaaaaaadicaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaabkaabaaaadaaaaaadcaaaaajccaabaaa
adaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaabkaabaaaadaaaaaaaaaaaaakccaabaaaadaaaaaa
bkiacaiaebaaaaaaaaaaaaaaajaaaaaackiacaaaaaaaaaaaajaaaaaaaoaaaaak
ccaabaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaa
adaaaaaadicaaaahbcaabaaaadaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaa
dcaaaaajccaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaa
aaaaeaeadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaa
dcaaaaakicaabaaaacaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadkaabaia
ebaaaaaaacaaaaaadiaaaaahbcaabaaaadaaaaaackaabaaaaaaaaaaadkaabaaa
acaaaaaadiaaaaahicaabaaaacaaaaaabkaabaaaaaaaaaaadkaabaaaacaaaaaa
efaaaaajpcaabaaaaeaaaaaaggakbaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
aeaaaaaadiaaaaahocaabaaaadaaaaaaagajbaaaaeaaaaaaagbabaaaacaaaaaa
efaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
aeaaaaaadcaaaaajocaabaaaadaaaaaaagajbaaaaeaaaaaakgbkbaaaacaaaaaa
fgaobaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaaacaaaaaaeghobaaa
acaaaaaaaagabaaaaeaaaaaadcaaaaajocaabaaaadaaaaaaagajbaaaaeaaaaaa
fgbfbaaaacaaaaaafgaobaaaadaaaaaadcaaaaajncaabaaaabaaaaaafgaobaaa
adaaaaaaagaabaaaadaaaaaaagaobaaaabaaaaaaaaaaaaakbcaabaaaadaaaaaa
bkiacaiaebaaaaaaaaaaaaaaakaaaaaackiacaaaaaaaaaaaakaaaaaaaoaaaaak
bcaabaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaa
adaaaaaaaaaaaaajccaabaaaadaaaaaabkbabaaaadaaaaaabkiacaiaebaaaaaa
aaaaaaaaakaaaaaadicaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaa
adaaaaaadcaaaaajccaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaa
adaaaaaadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaa
diaaaaahgcaabaaaaaaaaaaafgagbaaaaaaaaaaaagaabaaaadaaaaaaefaaaaaj
pcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaagaaaaaa
diaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaagaaaaaa
efaaaaajpcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaa
agaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaa
egacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaa
acaaaaaaegacbaaaacaaaaaadcaaaaajncaabaaaabaaaaaaagajbaaaacaaaaaa
kgakbaaaaaaaaaaaagaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaa
abaaaaaapgipcaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaa
acaaaaaaeghobaaaaeaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaaadaaaaaa
egacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
acaaaaaaeghobaaaaeaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaafaaaaaa
cgakbaaaacaaaaaaeghobaaaaeaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaa
acaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaa
dcaaaaajncaabaaaabaaaaaaagajbaaaacaaaaaaagaabaaaaaaaaaaaagaobaaa
abaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaa
ahaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaafaaaaaa
aagabaaaadaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaa
acaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaafaaaaaa
aagabaaaadaaaaaaefaaaaajpcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaa
afaaaaaaaagabaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaaeaaaaaa
kgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaa
afaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaa
egacbaaaacaaaaaafgafbaaaabaaaaaaigadbaaaabaaaaaadiaaaaaihcaabaaa
acaaaaaaegbcbaaaabaaaaaafgifcaaaaaaaaaaaahaaaaaaefaaaaajpcaabaaa
adaaaaaaggakbaaaacaaaaaaeghobaaaagaaaaaaaagabaaaafaaaaaadiaaaaah
hcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaacaaaaaaeghobaaaagaaaaaaaagabaaaafaaaaaaefaaaaaj
pcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaagaaaaaaaagabaaaafaaaaaa
dcaaaaajhcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaa
adaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaa
egacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaapgapbaaa
acaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaa
kgikcaaaaaaaaaaaahaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaa
eghobaaaahaaaaaaaagabaaaahaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaa
adaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaa
eghobaaaahaaaaaaaagabaaaahaaaaaaefaaaaajpcaabaaaacaaaaaacgakbaaa
acaaaaaaeghobaaaahaaaaaaaagabaaaahaaaaaadcaaaaajhcaabaaaadaaaaaa
egacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaa
acaaaaaaegacbaaaacaaaaaafgbfbaaaacaaaaaaegacbaaaadaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaacaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaia
ebaaaaaaaeaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaegbcbaaaaeaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaabaaaaaa
fgifcaaaaaaaaaaaafaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaa
eghobaaaaiaaaaaaaagabaaaaiaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaa
eghobaaaaiaaaaaaaagabaaaaiaaaaaaefaaaaajpcaabaaaabaaaaaacgakbaaa
abaaaaaaeghobaaaaiaaaaaaaagabaaaaiaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaadaaaaaakgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaa
abaaaaaaegacbaaaabaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaak
icaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaafaaaaaadkiacaaaaaaaaaaa
afaaaaaaaoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaackbabaaaadaaaaaa
ckiacaiaebaaaaaaaaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaiaebaaaaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakbabaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaadeaaaaahicaabaaaaaaaaaaa
ckbabaaaafaaaaaaabeaaaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab
"
				}
				SubProgram "opengl " {
					Keywords {
						"SPOT"
					}
					Vector 0[_LightColor0]
					Float 1[_texTiling]
					Float 2[_texPower]
					Float 3[_groundTexStart]
					Float 4[_groundTexEnd]
					Float 5[_steepTiling]
					Float 6[_steepTexStart]
					Float 7[_steepTexEnd]
					Float 8[_multiPower]
					Float 9[_deepMultiFactor]
					Float 10[_mainMultiFactor]
					Float 11[_highMultiFactor]
					Float 12[_snowMultiFactor]
					Float 13[_deepStart]
					Float 14[_deepEnd]
					Float 15[_mainLoStart]
					Float 16[_mainLoEnd]
					Float 17[_mainHiStart]
					Float 18[_mainHiEnd]
					Float 19[_hiLoStart]
					Float 20[_hiLoEnd]
					Float 21[_hiHiStart]
					Float 22[_hiHiEnd]
					Float 23[_snowStart]
					Float 24[_snowEnd]
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 1
					SetTexture 2[_highTex] 2D 2
					SetTexture 3[_snowTex] 2D 3
					SetTexture 4[_deepMultiTex] 2D 4
					SetTexture 5[_mainMultiTex] 2D 5
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[_LightTexture0] 2D 9
					SetTexture 10[_LightTextureB0] 2D 10 "3.0-!!ARBfp1.0
PARAM c[28] = { program.local[0..25],
		{ 0, 0.5, 2, 3 },
		{ 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.x, c[3];
ADD R0.x, -R0, c[4];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].z, -c[3];
MUL_SAT R0.w, R0.x, R0.y;
MUL R3.xyz, fragment.texcoord[0], c[1].x;
MAD R1.x, -R0.w, c[26].z, c[26].w;
MUL R0.w, R0, R0;
MOV R2.w, c[13].x;
ADD R2.w, -R2, c[14].x;
RCP R4.x, R2.w;
ADD R2.w, fragment.texcoord[2].y, -c[13].x;
MUL_SAT R2.w, R2, R4.x;
TEX R0.xyz, R3.zyzw, texture[1], 2D;
MUL R0.w, R0, R1.x;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[1], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R0, R1;
ADD R0.x, -R0.w, c[27];
MOV R0.z, c[17].x;
ADD R0.z, -R0, c[18].x;
RCP R1.w, R0.z;
ADD R0.z, fragment.texcoord[2].y, -c[17].x;
MUL_SAT R1.w, R0.z, R1;
MOV R0.y, c[15].x;
ADD R0.y, -R0, c[16].x;
RCP R0.z, R0.y;
ADD R0.y, fragment.texcoord[2], -c[15].x;
MUL_SAT R0.y, R0, R0.z;
MUL R0.w, R0, c[8].x;
MAD R2.x, -R1.w, c[26].z, c[26].w;
MUL R0.z, R1.w, R1.w;
MUL R1.w, R0.z, R2.x;
MUL R0.z, R0.y, R0.y;
MAD R0.y, -R0, c[26].z, c[26].w;
MAD R3.w, R0.z, R0.y, -R1;
MUL R1.w, R0.x, c[2].x;
MUL R2.x, R1.w, R3.w;
TEX R0.xyz, R3.zxzw, texture[1], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R0, R1;
MUL R1.xyz, R0, R2.x;
TEX R2.xyz, R3.zyzw, texture[0], 2D;
TEX R0.xyz, R3, texture[0], 2D;
MUL R2.xyz, fragment.texcoord[1].x, R2;
MAD R2.xyz, fragment.texcoord[1].z, R0, R2;
MAD R0.y, -R2.w, c[26].z, c[26].w;
MUL R0.x, R2.w, R2.w;
MAD R4.x, -R0, R0.y, c[27];
TEX R0.xyz, R3.zxzw, texture[0], 2D;
MUL R2.w, R1, R4.x;
MAD R2.xyz, fragment.texcoord[1].y, R0, R2;
TEX R0.xyz, R3.zyzw, texture[2], 2D;
MAD R2.xyz, R2, R2.w, R1;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[2], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R0, R1;
MOV R0.y, c[21].x;
ADD R0.y, -R0, c[22].x;
RCP R0.z, R0.y;
ADD R0.y, fragment.texcoord[2], -c[21].x;
MUL_SAT R0.z, R0.y, R0;
MOV R0.x, c[19];
ADD R0.x, -R0, c[20];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].y, -c[19];
MUL_SAT R0.x, R0, R0.y;
MAD R2.w, -R0.z, c[26].z, c[26];
MUL R0.y, R0.z, R0.z;
MUL R0.z, R0.y, R2.w;
MUL R0.y, R0.x, R0.x;
MAD R0.x, -R0, c[26].z, c[26].w;
MAD R2.w, R0.y, R0.x, -R0.z;
TEX R0.xyz, R3.zxzw, texture[2], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R0, R1;
MUL R1.x, R1.w, R2.w;
MAD R2.xyz, R0, R1.x, R2;
TEX R1.xyz, R3.zyzw, texture[3], 2D;
TEX R0.xyz, R3, texture[3], 2D;
MUL R1.xyz, fragment.texcoord[1].x, R1;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[3], 2D;
MOV R3.y, c[23].x;
ADD R3.y, -R3, c[24].x;
MAD R1.xyz, fragment.texcoord[1].y, R1, R0;
RCP R3.y, R3.y;
ADD R3.x, fragment.texcoord[2].y, -c[23];
MUL_SAT R3.x, R3, R3.y;
MAD R0.y, -R3.x, c[26].z, c[26].w;
MUL R0.x, R3, R3;
MUL R4.y, R0.x, R0;
MUL R3.xyz, fragment.texcoord[0], c[9].x;
MUL R4.z, R1.w, R4.y;
TEX R0.xyz, R3.zyzw, texture[4], 2D;
MAD R2.xyz, R1, R4.z, R2;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[4], 2D;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[4], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R1, R0;
MUL R1.xyz, fragment.texcoord[0], c[10].x;
MUL R4.x, R0.w, R4;
MAD R0.xyz, R0, R4.x, R2;
TEX R3.xyz, R1.zyzw, texture[5], 2D;
TEX R2.xyz, R1, texture[5], 2D;
MUL R3.xyz, fragment.texcoord[1].x, R3;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[5], 2D;
MAD R3.xyz, fragment.texcoord[1].y, R1, R2;
MUL R1.xyz, fragment.texcoord[0], c[11].x;
MUL R3.w, R0, R3;
TEX R2.xyz, R1.zyzw, texture[6], 2D;
MAD R0.xyz, R3, R3.w, R0;
MUL R3.xyz, fragment.texcoord[1].x, R2;
TEX R2.xyz, R1, texture[6], 2D;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[6], 2D;
MAD R3.xyz, fragment.texcoord[1].y, R1, R2;
MUL R1.xyz, fragment.texcoord[0], c[12].x;
MUL R2.w, R0, R2;
TEX R2.xyz, R1.zyzw, texture[7], 2D;
MAD R0.xyz, R3, R2.w, R0;
MUL R3.xyz, fragment.texcoord[1].x, R2;
TEX R2.xyz, R1, texture[7], 2D;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[7], 2D;
MAD R1.xyz, fragment.texcoord[1].y, R1, R2;
MUL R2.x, R0.w, R4.y;
MAD R0.xyz, R1, R2.x, R0;
MAD R1.xyz, fragment.texcoord[3], R0, -fragment.texcoord[3];
ADD R0.x, R1.w, R0.w;
MOV R0.w, c[6].x;
ADD R0.w, -R0, c[7].x;
RCP R1.w, R0.w;
ADD R0.w, fragment.texcoord[2].z, -c[6].x;
MAD R2.xyz, R0.x, R1, fragment.texcoord[3];
MUL R3.xyz, fragment.texcoord[0], c[5].x;
TEX R1.xyz, R3.zyzw, texture[8], 2D;
MUL R1.xyz, fragment.texcoord[1].x, R1;
TEX R0.xyz, R3, texture[8], 2D;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[8], 2D;
MAD R0.xyz, R1, fragment.texcoord[1].y, R0;
MUL_SAT R0.w, R0, R1;
MAD R1.x, -R0.w, c[26].z, c[26].w;
MUL R0.w, R0, R0;
MAD R0.w, -R0, R1.x, c[27].x;
ADD R1.xyz, R0, -R2;
MUL R0.y, fragment.texcoord[2].x, R0.w;
MAD R2.xyz, R0.y, R1, R2;
RCP R0.x, fragment.texcoord[5].w;
MAD R1.xy, fragment.texcoord[5], R0.x, c[26].y;
TEX R0.w, R1, texture[9], 2D;
SLT R1.x, c[26], fragment.texcoord[5].z;
MUL R1.y, R1.x, R0.w;
DP3 R0.w, fragment.texcoord[4], fragment.texcoord[4];
RSQ R1.x, R0.w;
DP3 R1.z, fragment.texcoord[5], fragment.texcoord[5];
TEX R0.w, R1.z, texture[10], 2D;
MUL R1.y, R1, R0.w;
MUL R1.x, R1, fragment.texcoord[4].z;
MAX R0.w, R1.x, c[26].x;
MUL R0.xyz, R2, c[0];
MUL R0.w, R0, R1.y;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[26].z;
MOV result.color.w, c[26].x;
END
# 166 instructions, 5 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"SPOT"
					}
					Vector 0[_LightColor0]
					Float 1[_texTiling]
					Float 2[_texPower]
					Float 3[_groundTexStart]
					Float 4[_groundTexEnd]
					Float 5[_steepTiling]
					Float 6[_steepTexStart]
					Float 7[_steepTexEnd]
					Float 8[_multiPower]
					Float 9[_deepMultiFactor]
					Float 10[_mainMultiFactor]
					Float 11[_highMultiFactor]
					Float 12[_snowMultiFactor]
					Float 13[_deepStart]
					Float 14[_deepEnd]
					Float 15[_mainLoStart]
					Float 16[_mainLoEnd]
					Float 17[_mainHiStart]
					Float 18[_mainHiEnd]
					Float 19[_hiLoStart]
					Float 20[_hiLoEnd]
					Float 21[_hiHiStart]
					Float 22[_hiHiEnd]
					Float 23[_snowStart]
					Float 24[_snowEnd]
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 1
					SetTexture 2[_highTex] 2D 2
					SetTexture 3[_snowTex] 2D 3
					SetTexture 4[_deepMultiTex] 2D 4
					SetTexture 5[_mainMultiTex] 2D 5
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[_LightTexture0] 2D 9
					SetTexture 10[_LightTextureB0] 2D 10 "ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
dcl_2d s8
dcl_2d s9
dcl_2d s10
def c25, 0.00000000, 1.00000000, 0.50000000, 2.00000000
def c26, 2.00000000, 3.00000000, 0, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5
mov r0.x, c4
add r0.w, -c3.x, r0.x
mul r0.xyz, v0, c1.x
rcp r1.x, r0.w
texld r3.xyz, r0.zyzw, s0
add r0.w, v2.z, -c3.x
mul_sat r0.w, r0, r1.x
texld r1.xyz, r0.zyzw, s1
mad r1.w, -r0, c26.x, c26.y
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s1
mad r2.xyz, v1.z, r1, r2
mul r0.w, r0, r0
mul r0.w, r0, r1
add r1.x, -r0.w, c25.y
mov r1.z, c18.x
add r1.z, -c17.x, r1
rcp r1.w, r1.z
add r1.z, v2.y, -c17.x
mul_sat r1.w, r1.z, r1
mov r1.y, c16.x
add r1.y, -c15.x, r1
rcp r1.z, r1.y
add r1.y, v2, -c15.x
mul_sat r1.y, r1, r1.z
mul r0.w, r0, c8.x
mad r2.w, -r1, c26.x, c26.y
mul r1.z, r1.w, r1.w
mul r1.w, r1.z, r2
mul r1.z, r1.y, r1.y
mad r1.y, -r1, c26.x, c26
mad r3.w, r1.z, r1.y, -r1
mul r1.w, r1.x, c2.x
mul r2.w, r1, r3
texld r1.xyz, r0.zxzw, s1
mad r1.xyz, v1.y, r1, r2
mul r2.xyz, r1, r2.w
mov r2.w, c14.x
add r2.w, -c13.x, r2
rcp r4.x, r2.w
add r2.w, v2.y, -c13.x
texld r1.xyz, r0, s0
mul r3.xyz, v1.x, r3
mul_sat r2.w, r2, r4.x
mad r3.xyz, v1.z, r1, r3
mad r1.y, -r2.w, c26.x, c26
mul r1.x, r2.w, r2.w
mad r4.x, -r1, r1.y, c25.y
mul r2.w, r1, r4.x
texld r1.xyz, r0.zxzw, s0
mad r3.xyz, v1.y, r1, r3
mad r3.xyz, r3, r2.w, r2
texld r1.xyz, r0.zyzw, s2
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s2
mad r2.xyz, v1.z, r1, r2
mov r1.y, c22.x
add r1.y, -c21.x, r1
rcp r1.z, r1.y
add r1.y, v2, -c21.x
mul_sat r1.z, r1.y, r1
mov r1.x, c20
add r1.x, -c19, r1
rcp r1.y, r1.x
add r1.x, v2.y, -c19
mul_sat r1.x, r1, r1.y
mad r2.w, -r1.z, c26.x, c26.y
mul r1.y, r1.z, r1.z
mul r1.z, r1.y, r2.w
mul r1.y, r1.x, r1.x
mad r1.x, -r1, c26, c26.y
mad r2.w, r1.y, r1.x, -r1.z
texld r1.xyz, r0.zxzw, s2
mad r1.xyz, v1.y, r1, r2
mul r2.x, r1.w, r2.w
mad r2.xyz, r1, r2.x, r3
texld r1.xyz, r0.zyzw, s3
texld r3.xyz, r0, s3
mul r1.xyz, v1.x, r1
mad r1.xyz, v1.z, r3, r1
mov r0.y, c24.x
add r3.x, -c23, r0.y
rcp r3.y, r3.x
add r3.x, v2.y, -c23
texld r0.xyz, r0.zxzw, s3
mul_sat r4.y, r3.x, r3
mad r3.xyz, v1.y, r0, r1
mad r0.y, -r4, c26.x, c26
mul r0.x, r4.y, r4.y
mul r4.y, r0.x, r0
mul r0.xyz, v0, c9.x
mul r4.z, r1.w, r4.y
mad r3.xyz, r3, r4.z, r2
texld r1.xyz, r0.zyzw, s4
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s4
mad r1.xyz, v1.z, r1, r2
texld r0.xyz, r0.zxzw, s4
mad r1.xyz, v1.y, r0, r1
mul r0.xyz, v0, c10.x
mul r4.x, r0.w, r4
texld r2.xyz, r0.zyzw, s5
mad r1.xyz, r1, r4.x, r3
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s5
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s5
mad r3.xyz, v1.y, r0, r2
mul r0.xyz, v0, c11.x
mul r3.w, r0, r3
texld r2.xyz, r0.zyzw, s6
mad r1.xyz, r3, r3.w, r1
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s6
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s6
mad r3.xyz, v1.y, r0, r2
mul r0.xyz, v0, c12.x
mul r2.w, r0, r2
texld r2.xyz, r0.zyzw, s7
mad r1.xyz, r3, r2.w, r1
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s7
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s7
mad r0.xyz, v1.y, r0, r2
mul r2.x, r0.w, r4.y
mad r0.xyz, r0, r2.x, r1
mad r1.xyz, v3, r0, -v3
mul r0.xyz, v0, c5.x
add r0.w, r1, r0
mad r3.xyz, r0.w, r1, v3
texld r1.xyz, r0.zyzw, s8
texld r2.xyz, r0, s8
mov r0.y, c7.x
add r0.w, -c6.x, r0.y
rcp r1.w, r0.w
mul r1.xyz, v1.x, r1
add r0.w, v2.z, -c6.x
mad r1.xyz, v1.z, r2, r1
texld r0.xyz, r0.zxzw, s8
mad r0.xyz, r0, v1.y, r1
mul_sat r0.w, r0, r1
mad r1.x, -r0.w, c26, c26.y
mul r0.w, r0, r0
mad r0.w, -r0, r1.x, c25.y
add r1.xyz, r0, -r3
mul r0.y, v2.x, r0.w
mad r1.xyz, r0.y, r1, r3
rcp r0.x, v5.w
mad r0.xy, v5, r0.x, c25.z
texld r0.w, r0, s9
cmp r0.x, -v5.z, c25, c25.y
mul_pp r0.z, r0.x, r0.w
dp3_pp r0.y, v4, v4
dp3 r0.x, v5, v5
texld r0.x, r0.x, s10
rsq_pp r0.y, r0.y
mul_pp r0.z, r0, r0.x
mul_pp r0.y, r0, v4.z
max_pp r0.x, r0.y, c25
mul_pp r1.xyz, r1, c0
mul_pp r0.x, r0, r0.z
mul_pp r0.xyz, r0.x, r1
mul_pp oC0.xyz, r0, c25.w
mov_pp oC0.w, c25.x
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"SPOT"
					}
					SetTexture 0[_deepTex] 2D 2
					SetTexture 1[_mainTex] 2D 4
					SetTexture 2[_highTex] 2D 6
					SetTexture 3[_snowTex] 2D 8
					SetTexture 4[_deepMultiTex] 2D 3
					SetTexture 5[_mainMultiTex] 2D 5
					SetTexture 6[_highMultiTex] 2D 7
					SetTexture 7[_snowMultiTex] 2D 9
					SetTexture 8[_steepTex] 2D 10
					SetTexture 9[_LightTexture0] 2D 0
					SetTexture 10[_LightTextureB0] 2D 1
					ConstBuffer "$Globals"
					256
					Vector 16[_LightColor0]
					Float 128[_texTiling]
					Float 132[_texPower]
					Float 136[_groundTexStart]
					Float 140[_groundTexEnd]
					Float 148[_steepTiling]
					Float 152[_steepTexStart]
					Float 156[_steepTexEnd]
					Float 168[_multiPower]
					Float 172[_deepMultiFactor]
					Float 176[_mainMultiFactor]
					Float 180[_highMultiFactor]
					Float 184[_snowMultiFactor]
					Float 188[_deepStart]
					Float 192[_deepEnd]
					Float 196[_mainLoStart]
					Float 200[_mainLoEnd]
					Float 204[_mainHiStart]
					Float 208[_mainHiEnd]
					Float 212[_hiLoStart]
					Float 216[_hiLoEnd]
					Float 220[_hiHiStart]
					Float 224[_hiHiEnd]
					Float 228[_snowStart]
					Float 232[_snowEnd]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedkhbhghahdjglpjlcofaffelleelfphidabaaaaaaeabhaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcaibgaaaaeaaaaaaaicafaaaa
fjaaaaaeegiocaaaaaaaaaaaapaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaa
agaaaaaafkaaaaadaagabaaaahaaaaaafkaaaaadaagabaaaaiaaaaaafkaaaaad
aagabaaaajaaaaaafkaaaaadaagabaaaakaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaa
ffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaafibiaaaeaahabaaaagaaaaaa
ffffaaaafibiaaaeaahabaaaahaaaaaaffffaaaafibiaaaeaahabaaaaiaaaaaa
ffffaaaafibiaaaeaahabaaaajaaaaaaffffaaaafibiaaaeaahabaaaakaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaa
gcbaaaadpcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaa
aaaaaaakbcaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaaalaaaaaaakiacaaa
aaaaaaaaamaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaabkbabaaa
adaaaaaadkiacaiaebaaaaaaaaaaaaaaalaaaaaadicaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaakccaabaaa
aaaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaadkiacaaaaaaaaaaaaiaaaaaa
aoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
bkaabaaaaaaaaaaaaaaaaaajecaabaaaaaaaaaaackbabaaaadaaaaaackiacaia
ebaaaaaaaaaaaaaaaiaaaaaadicaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckiacaaaaaaaaaaaakaaaaaadiaaaaaiecaabaaaaaaaaaaadkaabaaaaaaaaaaa
bkiacaaaaaaaaaaaaiaaaaaadcaaaaakicaabaaaaaaaaaaabkiacaaaaaaaaaaa
aiaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaa
ckaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaaaaaaaaakccaabaaaabaaaaaadkiacaiaebaaaaaa
aaaaaaaaamaaaaaaakiacaaaaaaaaaaaanaaaaaaaoaaaaakccaabaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaabaaaaaaaaaaaaaj
mcaabaaaabaaaaaafgbfbaaaadaaaaaafgincaiaebaaaaaaaaaaaaaaamaaaaaa
dicaaaahccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaaj
icaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaea
diaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaaaaaaaaakicaabaaa
abaaaaaabkiacaiaebaaaaaaaaaaaaaaamaaaaaackiacaaaaaaaaaaaamaaaaaa
aoaaaaakicaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
dkaabaaaabaaaaaadicaaaahecaabaaaabaaaaaadkaabaaaabaaaaaackaabaaa
abaaaaaadcaaaaajicaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaackaabaaa
abaaaaaadcaaaaakccaabaaaabaaaaaadkaabaaaabaaaaaackaabaaaabaaaaaa
bkaabaiaebaaaaaaabaaaaaadiaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaa
bkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaa
abaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaa
aiaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaaeaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaa
acaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaaeaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaaaeaaaaaakgbkbaaa
acaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaeaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaa
aeaaaaaafgbfbaaaacaaaaaaegacbaaaadaaaaaadiaaaaahhcaabaaaadaaaaaa
kgakbaaaabaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaaggakbaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaahhcaabaaaaeaaaaaa
egacbaaaaeaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaaaeaaaaaa
egacbaaaafaaaaaakgbkbaaaacaaaaaaegacbaaaaeaaaaaaefaaaaajpcaabaaa
afaaaaaacgakbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadcaaaaaj
hcaabaaaaeaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaaaeaaaaaa
dcaaaaajncaabaaaabaaaaaaagajbaaaaeaaaaaaagaabaaaabaaaaaaagajbaaa
adaaaaaaaaaaaaakicaabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaaanaaaaaa
akiacaaaaaaaaaaaaoaaaaaaaoaaaaakicaabaaaacaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpdkaabaaaacaaaaaaaaaaaaajdcaabaaaadaaaaaa
fgbfbaaaadaaaaaangifcaiaebaaaaaaaaaaaaaaanaaaaaadicaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaabkaabaaaadaaaaaadcaaaaajccaabaaaadaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaabkaabaaaadaaaaaaaaaaaaakccaabaaaadaaaaaabkiacaia
ebaaaaaaaaaaaaaaanaaaaaackiacaaaaaaaaaaaanaaaaaaaoaaaaakccaabaaa
adaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaadaaaaaa
dicaaaahbcaabaaaadaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaaj
ccaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaea
diaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaak
icaabaaaacaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadkaabaiaebaaaaaa
acaaaaaadiaaaaahbcaabaaaadaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaa
diaaaaahicaabaaaacaaaaaabkaabaaaaaaaaaaadkaabaaaacaaaaaaefaaaaaj
pcaabaaaaeaaaaaaggakbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaagaaaaaa
diaaaaahocaabaaaadaaaaaaagajbaaaaeaaaaaaagbabaaaacaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaagaaaaaa
dcaaaaajocaabaaaadaaaaaaagajbaaaaeaaaaaakgbkbaaaacaaaaaafgaobaaa
adaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaagaaaaaadcaaaaajocaabaaaadaaaaaaagajbaaaaeaaaaaafgbfbaaa
acaaaaaafgaobaaaadaaaaaadcaaaaajncaabaaaabaaaaaafgaobaaaadaaaaaa
agaabaaaadaaaaaaagaobaaaabaaaaaaaaaaaaakbcaabaaaadaaaaaabkiacaia
ebaaaaaaaaaaaaaaaoaaaaaackiacaaaaaaaaaaaaoaaaaaaaoaaaaakbcaabaaa
adaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaadaaaaaa
aaaaaaajccaabaaaadaaaaaabkbabaaaadaaaaaabkiacaiaebaaaaaaaaaaaaaa
aoaaaaaadicaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaa
dcaaaaajccaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaa
aaaaeaeadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaa
diaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaadiaaaaah
gcaabaaaaaaaaaaafgagbaaaaaaaaaaaagaabaaaadaaaaaaefaaaaajpcaabaaa
adaaaaaaggakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaaiaaaaaadiaaaaah
hcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaaiaaaaaaefaaaaaj
pcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaaiaaaaaa
dcaaaaajhcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaa
adaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaa
egacbaaaacaaaaaadcaaaaajncaabaaaabaaaaaaagajbaaaacaaaaaakgakbaaa
aaaaaaaaagaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaa
pgipcaaaaaaaaaaaakaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaa
eghobaaaaeaaaaaaaagabaaaadaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaa
adaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaa
eghobaaaaeaaaaaaaagabaaaadaaaaaaefaaaaajpcaabaaaafaaaaaacgakbaaa
acaaaaaaeghobaaaaeaaaaaaaagabaaaadaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaa
acaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaadcaaaaaj
ncaabaaaabaaaaaaagajbaaaacaaaaaaagaabaaaaaaaaaaaagaobaaaabaaaaaa
diaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaalaaaaaa
efaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaafaaaaaaaagabaaa
afaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaa
efaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaafaaaaaaaagabaaa
afaaaaaaefaaaaajpcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaafaaaaaa
aagabaaaafaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaa
acaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaa
fgbfbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
acaaaaaafgafbaaaabaaaaaaigadbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaa
egbcbaaaabaaaaaafgifcaaaaaaaaaaaalaaaaaaefaaaaajpcaabaaaadaaaaaa
ggakbaaaacaaaaaaeghobaaaagaaaaaaaagabaaaahaaaaaadiaaaaahhcaabaaa
adaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaa
egaabaaaacaaaaaaeghobaaaagaaaaaaaagabaaaahaaaaaaefaaaaajpcaabaaa
afaaaaaacgakbaaaacaaaaaaeghobaaaagaaaaaaaagabaaaahaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaa
dcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaa
acaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaapgapbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaakgikcaaa
aaaaaaaaalaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaa
ahaaaaaaaagabaaaajaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaa
agbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaa
ahaaaaaaaagabaaaajaaaaaaefaaaaajpcaabaaaacaaaaaacgakbaaaacaaaaaa
eghobaaaahaaaaaaaagabaaaajaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaa
aeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaacaaaaaafgbfbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaacaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaiaebaaaaaa
aeaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
egbcbaaaaeaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaabaaaaaafgifcaaa
aaaaaaaaajaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaaeghobaaa
aiaaaaaaaagabaaaakaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
agbabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaa
aiaaaaaaaagabaaaakaaaaaaefaaaaajpcaabaaaabaaaaaacgakbaaaabaaaaaa
eghobaaaaiaaaaaaaagabaaaakaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaa
adaaaaaakgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaa
egacbaaaabaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaakicaabaaa
aaaaaaaackiacaiaebaaaaaaaaaaaaaaajaaaaaadkiacaaaaaaaaaaaajaaaaaa
aoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
dkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaackbabaaaadaaaaaackiacaia
ebaaaaaaaaaaaaaaajaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakbabaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaa
agaaaaaapgbpbaaaagaaaaaaaaaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaajaaaaaaaagabaaaaaaaaaaadbaaaaahicaabaaa
aaaaaaaaabeaaaaaaaaaaaaackbabaaaagaaaaaaabaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaa
abaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaagaaaaaa
egbcbaaaagaaaaaaefaaaaajpcaabaaaabaaaaaaagaabaaaabaaaaaaeghobaaa
akaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaa
afaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaackbabaaaafaaaaaadeaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaagaabaaa
abaaaaaapgapbaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab
"
				}
				SubProgram "opengl " {
					Keywords {
						"POINT_COOKIE"
					}
					Vector 0[_LightColor0]
					Float 1[_texTiling]
					Float 2[_texPower]
					Float 3[_groundTexStart]
					Float 4[_groundTexEnd]
					Float 5[_steepTiling]
					Float 6[_steepTexStart]
					Float 7[_steepTexEnd]
					Float 8[_multiPower]
					Float 9[_deepMultiFactor]
					Float 10[_mainMultiFactor]
					Float 11[_highMultiFactor]
					Float 12[_snowMultiFactor]
					Float 13[_deepStart]
					Float 14[_deepEnd]
					Float 15[_mainLoStart]
					Float 16[_mainLoEnd]
					Float 17[_mainHiStart]
					Float 18[_mainHiEnd]
					Float 19[_hiLoStart]
					Float 20[_hiLoEnd]
					Float 21[_hiHiStart]
					Float 22[_hiHiEnd]
					Float 23[_snowStart]
					Float 24[_snowEnd]
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 1
					SetTexture 2[_highTex] 2D 2
					SetTexture 3[_snowTex] 2D 3
					SetTexture 4[_deepMultiTex] 2D 4
					SetTexture 5[_mainMultiTex] 2D 5
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[_LightTextureB0] 2D 9
					SetTexture 10[_LightTexture0] CUBE 10 "3.0-!!ARBfp1.0
PARAM c[27] = { program.local[0..25],
		{ 0, 2, 3, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.x, c[3];
ADD R0.x, -R0, c[4];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].z, -c[3];
MUL_SAT R0.w, R0.x, R0.y;
MUL R3.xyz, fragment.texcoord[0], c[1].x;
MAD R1.x, -R0.w, c[26].y, c[26].z;
MUL R0.w, R0, R0;
MOV R2.w, c[13].x;
ADD R2.w, -R2, c[14].x;
RCP R4.x, R2.w;
ADD R2.w, fragment.texcoord[2].y, -c[13].x;
MUL_SAT R2.w, R2, R4.x;
TEX R0.xyz, R3.zyzw, texture[1], 2D;
MUL R0.w, R0, R1.x;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[1], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R0, R1;
ADD R0.x, -R0.w, c[26].w;
MOV R0.z, c[17].x;
ADD R0.z, -R0, c[18].x;
RCP R1.w, R0.z;
ADD R0.z, fragment.texcoord[2].y, -c[17].x;
MUL_SAT R1.w, R0.z, R1;
MOV R0.y, c[15].x;
ADD R0.y, -R0, c[16].x;
RCP R0.z, R0.y;
ADD R0.y, fragment.texcoord[2], -c[15].x;
MUL_SAT R0.y, R0, R0.z;
MUL R0.w, R0, c[8].x;
MAD R2.x, -R1.w, c[26].y, c[26].z;
MUL R0.z, R1.w, R1.w;
MUL R1.w, R0.z, R2.x;
MUL R0.z, R0.y, R0.y;
MAD R0.y, -R0, c[26], c[26].z;
MAD R3.w, R0.z, R0.y, -R1;
MUL R1.w, R0.x, c[2].x;
MUL R2.x, R1.w, R3.w;
TEX R0.xyz, R3.zxzw, texture[1], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R0, R1;
MUL R1.xyz, R0, R2.x;
TEX R2.xyz, R3.zyzw, texture[0], 2D;
TEX R0.xyz, R3, texture[0], 2D;
MUL R2.xyz, fragment.texcoord[1].x, R2;
MAD R2.xyz, fragment.texcoord[1].z, R0, R2;
MAD R0.y, -R2.w, c[26], c[26].z;
MUL R0.x, R2.w, R2.w;
MAD R4.x, -R0, R0.y, c[26].w;
TEX R0.xyz, R3.zxzw, texture[0], 2D;
MUL R2.w, R1, R4.x;
MAD R2.xyz, fragment.texcoord[1].y, R0, R2;
TEX R0.xyz, R3.zyzw, texture[2], 2D;
MAD R2.xyz, R2, R2.w, R1;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[2], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R0, R1;
MOV R0.y, c[21].x;
ADD R0.y, -R0, c[22].x;
RCP R0.z, R0.y;
ADD R0.y, fragment.texcoord[2], -c[21].x;
MUL_SAT R0.z, R0.y, R0;
MOV R0.x, c[19];
ADD R0.x, -R0, c[20];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].y, -c[19];
MUL_SAT R0.x, R0, R0.y;
MAD R2.w, -R0.z, c[26].y, c[26].z;
MUL R0.y, R0.z, R0.z;
MUL R0.z, R0.y, R2.w;
MUL R0.y, R0.x, R0.x;
MAD R0.x, -R0, c[26].y, c[26].z;
MAD R2.w, R0.y, R0.x, -R0.z;
TEX R0.xyz, R3.zxzw, texture[2], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R0, R1;
MUL R1.x, R1.w, R2.w;
MAD R2.xyz, R0, R1.x, R2;
TEX R1.xyz, R3.zyzw, texture[3], 2D;
TEX R0.xyz, R3, texture[3], 2D;
MUL R1.xyz, fragment.texcoord[1].x, R1;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[3], 2D;
MOV R3.y, c[23].x;
ADD R3.y, -R3, c[24].x;
MAD R1.xyz, fragment.texcoord[1].y, R1, R0;
RCP R3.y, R3.y;
ADD R3.x, fragment.texcoord[2].y, -c[23];
MUL_SAT R3.x, R3, R3.y;
MAD R0.y, -R3.x, c[26], c[26].z;
MUL R0.x, R3, R3;
MUL R4.y, R0.x, R0;
MUL R3.xyz, fragment.texcoord[0], c[9].x;
MUL R4.z, R1.w, R4.y;
TEX R0.xyz, R3.zyzw, texture[4], 2D;
MAD R2.xyz, R1, R4.z, R2;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[4], 2D;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[4], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R1, R0;
MUL R1.xyz, fragment.texcoord[0], c[10].x;
MUL R4.x, R0.w, R4;
MAD R0.xyz, R0, R4.x, R2;
TEX R3.xyz, R1.zyzw, texture[5], 2D;
TEX R2.xyz, R1, texture[5], 2D;
MUL R3.xyz, fragment.texcoord[1].x, R3;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[5], 2D;
MAD R3.xyz, fragment.texcoord[1].y, R1, R2;
MUL R1.xyz, fragment.texcoord[0], c[11].x;
MUL R3.w, R0, R3;
TEX R2.xyz, R1.zyzw, texture[6], 2D;
MAD R0.xyz, R3, R3.w, R0;
MUL R3.xyz, fragment.texcoord[1].x, R2;
TEX R2.xyz, R1, texture[6], 2D;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[6], 2D;
MAD R3.xyz, fragment.texcoord[1].y, R1, R2;
MUL R1.xyz, fragment.texcoord[0], c[12].x;
MUL R2.w, R0, R2;
TEX R2.xyz, R1.zyzw, texture[7], 2D;
MAD R0.xyz, R3, R2.w, R0;
MUL R3.xyz, fragment.texcoord[1].x, R2;
TEX R2.xyz, R1, texture[7], 2D;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[7], 2D;
MAD R1.xyz, fragment.texcoord[1].y, R1, R2;
MUL R2.x, R0.w, R4.y;
MAD R0.xyz, R1, R2.x, R0;
MAD R1.xyz, fragment.texcoord[3], R0, -fragment.texcoord[3];
ADD R0.x, R1.w, R0.w;
MOV R0.w, c[6].x;
ADD R0.w, -R0, c[7].x;
RCP R1.w, R0.w;
ADD R0.w, fragment.texcoord[2].z, -c[6].x;
MAD R2.xyz, R0.x, R1, fragment.texcoord[3];
MUL R3.xyz, fragment.texcoord[0], c[5].x;
TEX R1.xyz, R3.zyzw, texture[8], 2D;
MUL_SAT R0.w, R0, R1;
MUL R1.xyz, fragment.texcoord[1].x, R1;
TEX R0.xyz, R3, texture[8], 2D;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[8], 2D;
MAD R0.xyz, R1, fragment.texcoord[1].y, R0;
MAD R1.x, -R0.w, c[26].y, c[26].z;
MUL R0.w, R0, R0;
MAD R0.w, -R0, R1.x, c[26];
ADD R1.xyz, R0, -R2;
MUL R0.y, fragment.texcoord[2].x, R0.w;
DP3 R0.x, fragment.texcoord[4], fragment.texcoord[4];
MAD R1.xyz, R0.y, R1, R2;
RSQ R0.w, R0.x;
MUL R0.xyz, R1, c[0];
MUL R1.x, R0.w, fragment.texcoord[4].z;
DP3 R1.y, fragment.texcoord[5], fragment.texcoord[5];
TEX R0.w, fragment.texcoord[5], texture[10], CUBE;
TEX R1.w, R1.y, texture[9], 2D;
MUL R1.y, R1.w, R0.w;
MAX R0.w, R1.x, c[26].x;
MUL R0.w, R0, R1.y;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[26].y;
MOV result.color.w, c[26].x;
END
# 162 instructions, 5 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"POINT_COOKIE"
					}
					Vector 0[_LightColor0]
					Float 1[_texTiling]
					Float 2[_texPower]
					Float 3[_groundTexStart]
					Float 4[_groundTexEnd]
					Float 5[_steepTiling]
					Float 6[_steepTexStart]
					Float 7[_steepTexEnd]
					Float 8[_multiPower]
					Float 9[_deepMultiFactor]
					Float 10[_mainMultiFactor]
					Float 11[_highMultiFactor]
					Float 12[_snowMultiFactor]
					Float 13[_deepStart]
					Float 14[_deepEnd]
					Float 15[_mainLoStart]
					Float 16[_mainLoEnd]
					Float 17[_mainHiStart]
					Float 18[_mainHiEnd]
					Float 19[_hiLoStart]
					Float 20[_hiLoEnd]
					Float 21[_hiHiStart]
					Float 22[_hiHiEnd]
					Float 23[_snowStart]
					Float 24[_snowEnd]
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 1
					SetTexture 2[_highTex] 2D 2
					SetTexture 3[_snowTex] 2D 3
					SetTexture 4[_deepMultiTex] 2D 4
					SetTexture 5[_mainMultiTex] 2D 5
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[_LightTextureB0] 2D 9
					SetTexture 10[_LightTexture0] CUBE 10 "ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
dcl_2d s8
dcl_2d s9
dcl_cube s10
def c25, 0.00000000, 2.00000000, 3.00000000, 1.00000000
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
mov r0.x, c4
add r0.w, -c3.x, r0.x
mul r0.xyz, v0, c1.x
rcp r1.x, r0.w
texld r3.xyz, r0.zyzw, s0
add r0.w, v2.z, -c3.x
mul_sat r0.w, r0, r1.x
texld r1.xyz, r0.zyzw, s1
mad r1.w, -r0, c25.y, c25.z
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s1
mad r2.xyz, v1.z, r1, r2
mul r0.w, r0, r0
mul r0.w, r0, r1
add r1.x, -r0.w, c25.w
mov r1.z, c18.x
add r1.z, -c17.x, r1
rcp r1.w, r1.z
add r1.z, v2.y, -c17.x
mul_sat r1.w, r1.z, r1
mov r1.y, c16.x
add r1.y, -c15.x, r1
rcp r1.z, r1.y
add r1.y, v2, -c15.x
mul_sat r1.y, r1, r1.z
mul r0.w, r0, c8.x
mad r2.w, -r1, c25.y, c25.z
mul r1.z, r1.w, r1.w
mul r1.w, r1.z, r2
mul r1.z, r1.y, r1.y
mad r1.y, -r1, c25, c25.z
mad r3.w, r1.z, r1.y, -r1
mul r1.w, r1.x, c2.x
mul r2.w, r1, r3
texld r1.xyz, r0.zxzw, s1
mad r1.xyz, v1.y, r1, r2
mul r2.xyz, r1, r2.w
mov r2.w, c14.x
add r2.w, -c13.x, r2
rcp r4.x, r2.w
add r2.w, v2.y, -c13.x
texld r1.xyz, r0, s0
mul r3.xyz, v1.x, r3
mul_sat r2.w, r2, r4.x
mad r3.xyz, v1.z, r1, r3
mad r1.y, -r2.w, c25, c25.z
mul r1.x, r2.w, r2.w
mad r4.x, -r1, r1.y, c25.w
mul r2.w, r1, r4.x
texld r1.xyz, r0.zxzw, s0
mad r3.xyz, v1.y, r1, r3
mad r3.xyz, r3, r2.w, r2
texld r1.xyz, r0.zyzw, s2
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s2
mad r2.xyz, v1.z, r1, r2
mov r1.y, c22.x
add r1.y, -c21.x, r1
rcp r1.z, r1.y
add r1.y, v2, -c21.x
mul_sat r1.z, r1.y, r1
mov r1.x, c20
add r1.x, -c19, r1
rcp r1.y, r1.x
add r1.x, v2.y, -c19
mul_sat r1.x, r1, r1.y
mad r2.w, -r1.z, c25.y, c25.z
mul r1.y, r1.z, r1.z
mul r1.z, r1.y, r2.w
mul r1.y, r1.x, r1.x
mad r1.x, -r1, c25.y, c25.z
mad r2.w, r1.y, r1.x, -r1.z
texld r1.xyz, r0.zxzw, s2
mad r1.xyz, v1.y, r1, r2
mul r2.x, r1.w, r2.w
mad r2.xyz, r1, r2.x, r3
texld r1.xyz, r0.zyzw, s3
texld r3.xyz, r0, s3
mul r1.xyz, v1.x, r1
mad r1.xyz, v1.z, r3, r1
mov r0.y, c24.x
add r3.x, -c23, r0.y
rcp r3.y, r3.x
add r3.x, v2.y, -c23
texld r0.xyz, r0.zxzw, s3
mul_sat r4.y, r3.x, r3
mad r3.xyz, v1.y, r0, r1
mad r0.y, -r4, c25, c25.z
mul r0.x, r4.y, r4.y
mul r4.y, r0.x, r0
mul r0.xyz, v0, c9.x
mul r4.z, r1.w, r4.y
mad r3.xyz, r3, r4.z, r2
texld r1.xyz, r0.zyzw, s4
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s4
mad r1.xyz, v1.z, r1, r2
texld r0.xyz, r0.zxzw, s4
mad r1.xyz, v1.y, r0, r1
mul r0.xyz, v0, c10.x
mul r4.x, r0.w, r4
texld r2.xyz, r0.zyzw, s5
mad r1.xyz, r1, r4.x, r3
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s5
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s5
mad r3.xyz, v1.y, r0, r2
mul r0.xyz, v0, c11.x
mul r3.w, r0, r3
texld r2.xyz, r0.zyzw, s6
mad r1.xyz, r3, r3.w, r1
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s6
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s6
mad r3.xyz, v1.y, r0, r2
mul r0.xyz, v0, c12.x
mul r2.w, r0, r2
texld r2.xyz, r0.zyzw, s7
mad r1.xyz, r3, r2.w, r1
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s7
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s7
mad r0.xyz, v1.y, r0, r2
mul r2.x, r0.w, r4.y
mad r0.xyz, r0, r2.x, r1
mad r1.xyz, v3, r0, -v3
mul r0.xyz, v0, c5.x
add r0.w, r1, r0
mad r3.xyz, r0.w, r1, v3
texld r1.xyz, r0.zyzw, s8
texld r2.xyz, r0, s8
mov r0.y, c7.x
add r0.w, -c6.x, r0.y
rcp r1.w, r0.w
mul r1.xyz, v1.x, r1
add r0.w, v2.z, -c6.x
mad r1.xyz, v1.z, r2, r1
texld r0.xyz, r0.zxzw, s8
mad r0.xyz, r0, v1.y, r1
mul_sat r0.w, r0, r1
mad r1.x, -r0.w, c25.y, c25.z
mul r0.w, r0, r0
mad r0.w, -r0, r1.x, c25
add r1.xyz, r0, -r3
mul r0.y, v2.x, r0.w
mad r1.xyz, r0.y, r1, r3
dp3_pp r0.x, v4, v4
rsq_pp r0.x, r0.x
mul_pp r0.y, r0.x, v4.z
dp3 r0.x, v5, v5
texld r0.x, r0.x, s9
texld r0.w, v5, s10
mul r0.z, r0.x, r0.w
max_pp r0.x, r0.y, c25
mul_pp r1.xyz, r1, c0
mul_pp r0.x, r0, r0.z
mul_pp r0.xyz, r0.x, r1
mul_pp oC0.xyz, r0, c25.y
mov_pp oC0.w, c25.x
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"POINT_COOKIE"
					}
					SetTexture 0[_deepTex] 2D 2
					SetTexture 1[_mainTex] 2D 4
					SetTexture 2[_highTex] 2D 6
					SetTexture 3[_snowTex] 2D 8
					SetTexture 4[_deepMultiTex] 2D 3
					SetTexture 5[_mainMultiTex] 2D 5
					SetTexture 6[_highMultiTex] 2D 7
					SetTexture 7[_snowMultiTex] 2D 9
					SetTexture 8[_steepTex] 2D 10
					SetTexture 9[_LightTextureB0] 2D 1
					SetTexture 10[_LightTexture0] CUBE 0
					ConstBuffer "$Globals"
					256
					Vector 16[_LightColor0]
					Float 128[_texTiling]
					Float 132[_texPower]
					Float 136[_groundTexStart]
					Float 140[_groundTexEnd]
					Float 148[_steepTiling]
					Float 152[_steepTexStart]
					Float 156[_steepTexEnd]
					Float 168[_multiPower]
					Float 172[_deepMultiFactor]
					Float 176[_mainMultiFactor]
					Float 180[_highMultiFactor]
					Float 184[_snowMultiFactor]
					Float 188[_deepStart]
					Float 192[_deepEnd]
					Float 196[_mainLoStart]
					Float 200[_mainLoEnd]
					Float 204[_mainHiStart]
					Float 208[_mainHiEnd]
					Float 212[_hiLoStart]
					Float 216[_hiLoEnd]
					Float 220[_hiHiStart]
					Float 224[_hiHiEnd]
					Float 228[_snowStart]
					Float 232[_snowEnd]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedombgejflnhnedomgkckaiknmolncpnklabaaaaaakibgaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefchabfaaaaeaaaaaaafmafaaaa
fjaaaaaeegiocaaaaaaaaaaaapaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaa
agaaaaaafkaaaaadaagabaaaahaaaaaafkaaaaadaagabaaaaiaaaaaafkaaaaad
aagabaaaajaaaaaafkaaaaadaagabaaaakaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaa
ffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaafibiaaaeaahabaaaagaaaaaa
ffffaaaafibiaaaeaahabaaaahaaaaaaffffaaaafibiaaaeaahabaaaaiaaaaaa
ffffaaaafibiaaaeaahabaaaajaaaaaaffffaaaafidaaaaeaahabaaaakaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaa
gcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaa
aaaaaaakbcaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaaalaaaaaaakiacaaa
aaaaaaaaamaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaabkbabaaa
adaaaaaadkiacaiaebaaaaaaaaaaaaaaalaaaaaadicaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaakccaabaaa
aaaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaadkiacaaaaaaaaaaaaiaaaaaa
aoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
bkaabaaaaaaaaaaaaaaaaaajecaabaaaaaaaaaaackbabaaaadaaaaaackiacaia
ebaaaaaaaaaaaaaaaiaaaaaadicaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckiacaaaaaaaaaaaakaaaaaadiaaaaaiecaabaaaaaaaaaaadkaabaaaaaaaaaaa
bkiacaaaaaaaaaaaaiaaaaaadcaaaaakicaabaaaaaaaaaaabkiacaaaaaaaaaaa
aiaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaa
ckaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaaaaaaaaakccaabaaaabaaaaaadkiacaiaebaaaaaa
aaaaaaaaamaaaaaaakiacaaaaaaaaaaaanaaaaaaaoaaaaakccaabaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaabaaaaaaaaaaaaaj
mcaabaaaabaaaaaafgbfbaaaadaaaaaafgincaiaebaaaaaaaaaaaaaaamaaaaaa
dicaaaahccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaaj
icaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaea
diaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaaaaaaaaakicaabaaa
abaaaaaabkiacaiaebaaaaaaaaaaaaaaamaaaaaackiacaaaaaaaaaaaamaaaaaa
aoaaaaakicaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
dkaabaaaabaaaaaadicaaaahecaabaaaabaaaaaadkaabaaaabaaaaaackaabaaa
abaaaaaadcaaaaajicaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaackaabaaa
abaaaaaadcaaaaakccaabaaaabaaaaaadkaabaaaabaaaaaackaabaaaabaaaaaa
bkaabaiaebaaaaaaabaaaaaadiaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaa
bkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaa
abaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaa
aiaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaaeaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaa
acaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaaeaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaaaeaaaaaakgbkbaaa
acaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaeaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaa
aeaaaaaafgbfbaaaacaaaaaaegacbaaaadaaaaaadiaaaaahhcaabaaaadaaaaaa
kgakbaaaabaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaaggakbaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaahhcaabaaaaeaaaaaa
egacbaaaaeaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaaaeaaaaaa
egacbaaaafaaaaaakgbkbaaaacaaaaaaegacbaaaaeaaaaaaefaaaaajpcaabaaa
afaaaaaacgakbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadcaaaaaj
hcaabaaaaeaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaaaeaaaaaa
dcaaaaajncaabaaaabaaaaaaagajbaaaaeaaaaaaagaabaaaabaaaaaaagajbaaa
adaaaaaaaaaaaaakicaabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaaanaaaaaa
akiacaaaaaaaaaaaaoaaaaaaaoaaaaakicaabaaaacaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpdkaabaaaacaaaaaaaaaaaaajdcaabaaaadaaaaaa
fgbfbaaaadaaaaaangifcaiaebaaaaaaaaaaaaaaanaaaaaadicaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaabkaabaaaadaaaaaadcaaaaajccaabaaaadaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaabkaabaaaadaaaaaaaaaaaaakccaabaaaadaaaaaabkiacaia
ebaaaaaaaaaaaaaaanaaaaaackiacaaaaaaaaaaaanaaaaaaaoaaaaakccaabaaa
adaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaadaaaaaa
dicaaaahbcaabaaaadaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaaj
ccaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaea
diaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaak
icaabaaaacaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadkaabaiaebaaaaaa
acaaaaaadiaaaaahbcaabaaaadaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaa
diaaaaahicaabaaaacaaaaaabkaabaaaaaaaaaaadkaabaaaacaaaaaaefaaaaaj
pcaabaaaaeaaaaaaggakbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaagaaaaaa
diaaaaahocaabaaaadaaaaaaagajbaaaaeaaaaaaagbabaaaacaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaagaaaaaa
dcaaaaajocaabaaaadaaaaaaagajbaaaaeaaaaaakgbkbaaaacaaaaaafgaobaaa
adaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaagaaaaaadcaaaaajocaabaaaadaaaaaaagajbaaaaeaaaaaafgbfbaaa
acaaaaaafgaobaaaadaaaaaadcaaaaajncaabaaaabaaaaaafgaobaaaadaaaaaa
agaabaaaadaaaaaaagaobaaaabaaaaaaaaaaaaakbcaabaaaadaaaaaabkiacaia
ebaaaaaaaaaaaaaaaoaaaaaackiacaaaaaaaaaaaaoaaaaaaaoaaaaakbcaabaaa
adaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaadaaaaaa
aaaaaaajccaabaaaadaaaaaabkbabaaaadaaaaaabkiacaiaebaaaaaaaaaaaaaa
aoaaaaaadicaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaa
dcaaaaajccaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaa
aaaaeaeadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaa
diaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaadiaaaaah
gcaabaaaaaaaaaaafgagbaaaaaaaaaaaagaabaaaadaaaaaaefaaaaajpcaabaaa
adaaaaaaggakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaaiaaaaaadiaaaaah
hcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaaiaaaaaaefaaaaaj
pcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaaiaaaaaa
dcaaaaajhcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaa
adaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaa
egacbaaaacaaaaaadcaaaaajncaabaaaabaaaaaaagajbaaaacaaaaaakgakbaaa
aaaaaaaaagaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaa
pgipcaaaaaaaaaaaakaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaa
eghobaaaaeaaaaaaaagabaaaadaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaa
adaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaa
eghobaaaaeaaaaaaaagabaaaadaaaaaaefaaaaajpcaabaaaafaaaaaacgakbaaa
acaaaaaaeghobaaaaeaaaaaaaagabaaaadaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaa
acaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaadcaaaaaj
ncaabaaaabaaaaaaagajbaaaacaaaaaaagaabaaaaaaaaaaaagaobaaaabaaaaaa
diaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaalaaaaaa
efaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaafaaaaaaaagabaaa
afaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaa
efaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaafaaaaaaaagabaaa
afaaaaaaefaaaaajpcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaafaaaaaa
aagabaaaafaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaa
acaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaa
fgbfbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
acaaaaaafgafbaaaabaaaaaaigadbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaa
egbcbaaaabaaaaaafgifcaaaaaaaaaaaalaaaaaaefaaaaajpcaabaaaadaaaaaa
ggakbaaaacaaaaaaeghobaaaagaaaaaaaagabaaaahaaaaaadiaaaaahhcaabaaa
adaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaa
egaabaaaacaaaaaaeghobaaaagaaaaaaaagabaaaahaaaaaaefaaaaajpcaabaaa
afaaaaaacgakbaaaacaaaaaaeghobaaaagaaaaaaaagabaaaahaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaa
dcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaa
acaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaapgapbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaakgikcaaa
aaaaaaaaalaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaa
ahaaaaaaaagabaaaajaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaa
agbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaa
ahaaaaaaaagabaaaajaaaaaaefaaaaajpcaabaaaacaaaaaacgakbaaaacaaaaaa
eghobaaaahaaaaaaaagabaaaajaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaa
aeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaacaaaaaafgbfbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaacaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaiaebaaaaaa
aeaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
egbcbaaaaeaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaabaaaaaafgifcaaa
aaaaaaaaajaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaaeghobaaa
aiaaaaaaaagabaaaakaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
agbabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaa
aiaaaaaaaagabaaaakaaaaaaefaaaaajpcaabaaaabaaaaaacgakbaaaabaaaaaa
eghobaaaaiaaaaaaaagabaaaakaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaa
adaaaaaakgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaa
egacbaaaabaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaakicaabaaa
aaaaaaaackiacaiaebaaaaaaaaaaaaaaajaaaaaadkiacaaaaaaaaaaaajaaaaaa
aoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
dkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaackbabaaaadaaaaaackiacaia
ebaaaaaaaaaaaaaaajaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakbabaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
agaaaaaaegbcbaaaagaaaaaaefaaaaajpcaabaaaabaaaaaapgapbaaaaaaaaaaa
eghobaaaajaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbcbaaa
agaaaaaaeghobaaaakaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
akaabaaaabaaaaaadkaabaaaacaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaa
afaaaaaaegbcbaaaafaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaackbabaaaafaaaaaadeaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaapaaaaahicaabaaa
aaaaaaaaagaabaaaabaaaaaapgapbaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaaaaadoaaaaab"
				}
				SubProgram "opengl " {
					Keywords {
						"DIRECTIONAL_COOKIE"
					}
					Vector 0[_LightColor0]
					Float 1[_texTiling]
					Float 2[_texPower]
					Float 3[_groundTexStart]
					Float 4[_groundTexEnd]
					Float 5[_steepTiling]
					Float 6[_steepTexStart]
					Float 7[_steepTexEnd]
					Float 8[_multiPower]
					Float 9[_deepMultiFactor]
					Float 10[_mainMultiFactor]
					Float 11[_highMultiFactor]
					Float 12[_snowMultiFactor]
					Float 13[_deepStart]
					Float 14[_deepEnd]
					Float 15[_mainLoStart]
					Float 16[_mainLoEnd]
					Float 17[_mainHiStart]
					Float 18[_mainHiEnd]
					Float 19[_hiLoStart]
					Float 20[_hiLoEnd]
					Float 21[_hiHiStart]
					Float 22[_hiHiEnd]
					Float 23[_snowStart]
					Float 24[_snowEnd]
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 1
					SetTexture 2[_highTex] 2D 2
					SetTexture 3[_snowTex] 2D 3
					SetTexture 4[_deepMultiTex] 2D 4
					SetTexture 5[_mainMultiTex] 2D 5
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[_LightTexture0] 2D 9 "3.0-!!ARBfp1.0
PARAM c[27] = { program.local[0..25],
		{ 0, 2, 3, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.x, c[3];
ADD R0.x, -R0, c[4];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].z, -c[3];
MUL_SAT R0.w, R0.x, R0.y;
MUL R3.xyz, fragment.texcoord[0], c[1].x;
MAD R1.x, -R0.w, c[26].y, c[26].z;
MUL R0.w, R0, R0;
MOV R2.w, c[13].x;
ADD R2.w, -R2, c[14].x;
RCP R4.x, R2.w;
ADD R2.w, fragment.texcoord[2].y, -c[13].x;
MUL_SAT R2.w, R2, R4.x;
TEX R0.xyz, R3.zyzw, texture[1], 2D;
MUL R0.w, R0, R1.x;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[1], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R0, R1;
ADD R0.x, -R0.w, c[26].w;
MOV R0.z, c[17].x;
ADD R0.z, -R0, c[18].x;
RCP R1.w, R0.z;
ADD R0.z, fragment.texcoord[2].y, -c[17].x;
MUL_SAT R1.w, R0.z, R1;
MOV R0.y, c[15].x;
ADD R0.y, -R0, c[16].x;
RCP R0.z, R0.y;
ADD R0.y, fragment.texcoord[2], -c[15].x;
MUL_SAT R0.y, R0, R0.z;
MUL R0.w, R0, c[8].x;
MAD R2.x, -R1.w, c[26].y, c[26].z;
MUL R0.z, R1.w, R1.w;
MUL R1.w, R0.z, R2.x;
MUL R0.z, R0.y, R0.y;
MAD R0.y, -R0, c[26], c[26].z;
MAD R3.w, R0.z, R0.y, -R1;
MUL R1.w, R0.x, c[2].x;
MUL R2.x, R1.w, R3.w;
TEX R0.xyz, R3.zxzw, texture[1], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R0, R1;
MUL R1.xyz, R0, R2.x;
TEX R2.xyz, R3.zyzw, texture[0], 2D;
TEX R0.xyz, R3, texture[0], 2D;
MUL R2.xyz, fragment.texcoord[1].x, R2;
MAD R2.xyz, fragment.texcoord[1].z, R0, R2;
MAD R0.y, -R2.w, c[26], c[26].z;
MUL R0.x, R2.w, R2.w;
MAD R4.x, -R0, R0.y, c[26].w;
TEX R0.xyz, R3.zxzw, texture[0], 2D;
MUL R2.w, R1, R4.x;
MAD R2.xyz, fragment.texcoord[1].y, R0, R2;
TEX R0.xyz, R3.zyzw, texture[2], 2D;
MAD R2.xyz, R2, R2.w, R1;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[2], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R0, R1;
MOV R0.y, c[21].x;
ADD R0.y, -R0, c[22].x;
RCP R0.z, R0.y;
ADD R0.y, fragment.texcoord[2], -c[21].x;
MUL_SAT R0.z, R0.y, R0;
MOV R0.x, c[19];
ADD R0.x, -R0, c[20];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].y, -c[19];
MUL_SAT R0.x, R0, R0.y;
MAD R2.w, -R0.z, c[26].y, c[26].z;
MUL R0.y, R0.z, R0.z;
MUL R0.z, R0.y, R2.w;
MUL R0.y, R0.x, R0.x;
MAD R0.x, -R0, c[26].y, c[26].z;
MAD R2.w, R0.y, R0.x, -R0.z;
TEX R0.xyz, R3.zxzw, texture[2], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R0, R1;
MUL R1.x, R1.w, R2.w;
MAD R2.xyz, R0, R1.x, R2;
TEX R1.xyz, R3.zyzw, texture[3], 2D;
TEX R0.xyz, R3, texture[3], 2D;
MUL R1.xyz, fragment.texcoord[1].x, R1;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[3], 2D;
MOV R3.y, c[23].x;
ADD R3.y, -R3, c[24].x;
MAD R1.xyz, fragment.texcoord[1].y, R1, R0;
RCP R3.y, R3.y;
ADD R3.x, fragment.texcoord[2].y, -c[23];
MUL_SAT R3.x, R3, R3.y;
MAD R0.y, -R3.x, c[26], c[26].z;
MUL R0.x, R3, R3;
MUL R4.y, R0.x, R0;
MUL R3.xyz, fragment.texcoord[0], c[9].x;
MUL R4.z, R1.w, R4.y;
TEX R0.xyz, R3.zyzw, texture[4], 2D;
MAD R2.xyz, R1, R4.z, R2;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[4], 2D;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[4], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R1, R0;
MUL R1.xyz, fragment.texcoord[0], c[10].x;
MUL R4.x, R0.w, R4;
MAD R0.xyz, R0, R4.x, R2;
TEX R3.xyz, R1.zyzw, texture[5], 2D;
TEX R2.xyz, R1, texture[5], 2D;
MUL R3.xyz, fragment.texcoord[1].x, R3;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[5], 2D;
MAD R3.xyz, fragment.texcoord[1].y, R1, R2;
MUL R1.xyz, fragment.texcoord[0], c[11].x;
MUL R3.w, R0, R3;
TEX R2.xyz, R1.zyzw, texture[6], 2D;
MAD R0.xyz, R3, R3.w, R0;
MUL R3.xyz, fragment.texcoord[1].x, R2;
TEX R2.xyz, R1, texture[6], 2D;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[6], 2D;
MAD R3.xyz, fragment.texcoord[1].y, R1, R2;
MUL R1.xyz, fragment.texcoord[0], c[12].x;
MUL R2.w, R0, R2;
TEX R2.xyz, R1.zyzw, texture[7], 2D;
MAD R0.xyz, R3, R2.w, R0;
MUL R3.xyz, fragment.texcoord[1].x, R2;
TEX R2.xyz, R1, texture[7], 2D;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[7], 2D;
MAD R1.xyz, fragment.texcoord[1].y, R1, R2;
MUL R2.x, R0.w, R4.y;
MAD R0.xyz, R1, R2.x, R0;
MAD R1.xyz, fragment.texcoord[3], R0, -fragment.texcoord[3];
ADD R0.x, R1.w, R0.w;
MOV R0.w, c[6].x;
ADD R0.w, -R0, c[7].x;
RCP R1.w, R0.w;
ADD R0.w, fragment.texcoord[2].z, -c[6].x;
MAD R2.xyz, R0.x, R1, fragment.texcoord[3];
MUL R3.xyz, fragment.texcoord[0], c[5].x;
TEX R1.xyz, R3.zyzw, texture[8], 2D;
MUL R1.xyz, fragment.texcoord[1].x, R1;
TEX R0.xyz, R3, texture[8], 2D;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[8], 2D;
MAD R0.xyz, R1, fragment.texcoord[1].y, R0;
MUL_SAT R0.w, R0, R1;
MAD R1.x, -R0.w, c[26].y, c[26].z;
MUL R0.w, R0, R0;
MAD R0.w, -R0, R1.x, c[26];
ADD R1.xyz, R0, -R2;
MUL R0.x, fragment.texcoord[2], R0.w;
MAD R0.xyz, R0.x, R1, R2;
MUL R1.xyz, R0, c[0];
TEX R0.w, fragment.texcoord[5], texture[9], 2D;
MAX R0.x, fragment.texcoord[4].z, c[26];
MUL R0.x, R0, R0.w;
MUL R0.xyz, R0.x, R1;
MUL result.color.xyz, R0, c[26].y;
MOV result.color.w, c[26].x;
END
# 156 instructions, 5 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"DIRECTIONAL_COOKIE"
					}
					Vector 0[_LightColor0]
					Float 1[_texTiling]
					Float 2[_texPower]
					Float 3[_groundTexStart]
					Float 4[_groundTexEnd]
					Float 5[_steepTiling]
					Float 6[_steepTexStart]
					Float 7[_steepTexEnd]
					Float 8[_multiPower]
					Float 9[_deepMultiFactor]
					Float 10[_mainMultiFactor]
					Float 11[_highMultiFactor]
					Float 12[_snowMultiFactor]
					Float 13[_deepStart]
					Float 14[_deepEnd]
					Float 15[_mainLoStart]
					Float 16[_mainLoEnd]
					Float 17[_mainHiStart]
					Float 18[_mainHiEnd]
					Float 19[_hiLoStart]
					Float 20[_hiLoEnd]
					Float 21[_hiHiStart]
					Float 22[_hiHiEnd]
					Float 23[_snowStart]
					Float 24[_snowEnd]
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 1
					SetTexture 2[_highTex] 2D 2
					SetTexture 3[_snowTex] 2D 3
					SetTexture 4[_deepMultiTex] 2D 4
					SetTexture 5[_mainMultiTex] 2D 5
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[_LightTexture0] 2D 9 "ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
dcl_2d s8
dcl_2d s9
def c25, 0.00000000, 2.00000000, 3.00000000, 1.00000000
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xy
mov r0.x, c4
add r0.w, -c3.x, r0.x
mul r0.xyz, v0, c1.x
rcp r1.x, r0.w
texld r3.xyz, r0.zyzw, s0
add r0.w, v2.z, -c3.x
mul_sat r0.w, r0, r1.x
texld r1.xyz, r0.zyzw, s1
mad r1.w, -r0, c25.y, c25.z
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s1
mad r2.xyz, v1.z, r1, r2
mul r0.w, r0, r0
mul r0.w, r0, r1
add r1.x, -r0.w, c25.w
mov r1.z, c18.x
add r1.z, -c17.x, r1
rcp r1.w, r1.z
add r1.z, v2.y, -c17.x
mul_sat r1.w, r1.z, r1
mov r1.y, c16.x
add r1.y, -c15.x, r1
rcp r1.z, r1.y
add r1.y, v2, -c15.x
mul_sat r1.y, r1, r1.z
mul r0.w, r0, c8.x
mad r2.w, -r1, c25.y, c25.z
mul r1.z, r1.w, r1.w
mul r1.w, r1.z, r2
mul r1.z, r1.y, r1.y
mad r1.y, -r1, c25, c25.z
mad r3.w, r1.z, r1.y, -r1
mul r1.w, r1.x, c2.x
mul r2.w, r1, r3
texld r1.xyz, r0.zxzw, s1
mad r1.xyz, v1.y, r1, r2
mul r2.xyz, r1, r2.w
mov r2.w, c14.x
add r2.w, -c13.x, r2
rcp r4.x, r2.w
add r2.w, v2.y, -c13.x
texld r1.xyz, r0, s0
mul r3.xyz, v1.x, r3
mul_sat r2.w, r2, r4.x
mad r3.xyz, v1.z, r1, r3
mad r1.y, -r2.w, c25, c25.z
mul r1.x, r2.w, r2.w
mad r4.x, -r1, r1.y, c25.w
mul r2.w, r1, r4.x
texld r1.xyz, r0.zxzw, s0
mad r3.xyz, v1.y, r1, r3
mad r3.xyz, r3, r2.w, r2
texld r1.xyz, r0.zyzw, s2
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s2
mad r2.xyz, v1.z, r1, r2
mov r1.y, c22.x
add r1.y, -c21.x, r1
rcp r1.z, r1.y
add r1.y, v2, -c21.x
mul_sat r1.z, r1.y, r1
mov r1.x, c20
add r1.x, -c19, r1
rcp r1.y, r1.x
add r1.x, v2.y, -c19
mul_sat r1.x, r1, r1.y
mad r2.w, -r1.z, c25.y, c25.z
mul r1.y, r1.z, r1.z
mul r1.z, r1.y, r2.w
mul r1.y, r1.x, r1.x
mad r1.x, -r1, c25.y, c25.z
mad r2.w, r1.y, r1.x, -r1.z
texld r1.xyz, r0.zxzw, s2
mad r1.xyz, v1.y, r1, r2
mul r2.x, r1.w, r2.w
mad r2.xyz, r1, r2.x, r3
texld r1.xyz, r0.zyzw, s3
texld r3.xyz, r0, s3
mul r1.xyz, v1.x, r1
mad r1.xyz, v1.z, r3, r1
mov r0.y, c24.x
add r3.x, -c23, r0.y
rcp r3.y, r3.x
add r3.x, v2.y, -c23
texld r0.xyz, r0.zxzw, s3
mul_sat r4.y, r3.x, r3
mad r3.xyz, v1.y, r0, r1
mad r0.y, -r4, c25, c25.z
mul r0.x, r4.y, r4.y
mul r4.y, r0.x, r0
mul r0.xyz, v0, c9.x
mul r4.z, r1.w, r4.y
mad r3.xyz, r3, r4.z, r2
texld r1.xyz, r0.zyzw, s4
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s4
mad r1.xyz, v1.z, r1, r2
texld r0.xyz, r0.zxzw, s4
mad r1.xyz, v1.y, r0, r1
mul r0.xyz, v0, c10.x
mul r4.x, r0.w, r4
texld r2.xyz, r0.zyzw, s5
mad r1.xyz, r1, r4.x, r3
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s5
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s5
mad r3.xyz, v1.y, r0, r2
mul r0.xyz, v0, c11.x
mul r3.w, r0, r3
texld r2.xyz, r0.zyzw, s6
mad r1.xyz, r3, r3.w, r1
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s6
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s6
mad r3.xyz, v1.y, r0, r2
mul r0.xyz, v0, c12.x
mul r2.w, r0, r2
texld r2.xyz, r0.zyzw, s7
mad r1.xyz, r3, r2.w, r1
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s7
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s7
mad r0.xyz, v1.y, r0, r2
mul r2.x, r0.w, r4.y
mad r0.xyz, r0, r2.x, r1
mad r1.xyz, v3, r0, -v3
mul r0.xyz, v0, c5.x
add r0.w, r1, r0
mad r3.xyz, r0.w, r1, v3
texld r1.xyz, r0.zyzw, s8
texld r2.xyz, r0, s8
mov r0.y, c7.x
add r0.w, -c6.x, r0.y
rcp r1.w, r0.w
mul r1.xyz, v1.x, r1
add r0.w, v2.z, -c6.x
mad r1.xyz, v1.z, r2, r1
texld r0.xyz, r0.zxzw, s8
mad r0.xyz, r0, v1.y, r1
mul_sat r0.w, r0, r1
mad r1.x, -r0.w, c25.y, c25.z
mul r0.w, r0, r0
mad r0.w, -r0, r1.x, c25
add r1.xyz, r0, -r3
mul r0.x, v2, r0.w
mad r0.xyz, r0.x, r1, r3
mul_pp r1.xyz, r0, c0
texld r0.w, v5, s9
max_pp r0.x, v4.z, c25
mul_pp r0.x, r0, r0.w
mul_pp r0.xyz, r0.x, r1
mul_pp oC0.xyz, r0, c25.y
mov_pp oC0.w, c25.x
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"DIRECTIONAL_COOKIE"
					}
					SetTexture 0[_deepTex] 2D 1
					SetTexture 1[_mainTex] 2D 3
					SetTexture 2[_highTex] 2D 5
					SetTexture 3[_snowTex] 2D 7
					SetTexture 4[_deepMultiTex] 2D 2
					SetTexture 5[_mainMultiTex] 2D 4
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 8
					SetTexture 8[_steepTex] 2D 9
					SetTexture 9[_LightTexture0] 2D 0
					ConstBuffer "$Globals"
					256
					Vector 16[_LightColor0]
					Float 128[_texTiling]
					Float 132[_texPower]
					Float 136[_groundTexStart]
					Float 140[_groundTexEnd]
					Float 148[_steepTiling]
					Float 152[_steepTexStart]
					Float 156[_steepTexEnd]
					Float 168[_multiPower]
					Float 172[_deepMultiFactor]
					Float 176[_mainMultiFactor]
					Float 180[_highMultiFactor]
					Float 184[_snowMultiFactor]
					Float 188[_deepStart]
					Float 192[_deepEnd]
					Float 196[_mainLoStart]
					Float 200[_mainLoEnd]
					Float 204[_mainHiStart]
					Float 208[_mainHiEnd]
					Float 212[_hiLoStart]
					Float 216[_hiLoEnd]
					Float 220[_hiHiStart]
					Float 224[_hiHiEnd]
					Float 228[_snowStart]
					Float 232[_snowEnd]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedngnpaapdllepambepjddiaohbdckmemaabaaaaaaoebfaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaeaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckmbeaaaaeaaaaaaaclafaaaa
fjaaaaaeegiocaaaaaaaaaaaapaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaa
agaaaaaafkaaaaadaagabaaaahaaaaaafkaaaaadaagabaaaaiaaaaaafkaaaaad
aagabaaaajaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaa
afaaaaaaffffaaaafibiaaaeaahabaaaagaaaaaaffffaaaafibiaaaeaahabaaa
ahaaaaaaffffaaaafibiaaaeaahabaaaaiaaaaaaffffaaaafibiaaaeaahabaaa
ajaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadecbabaaa
afaaaaaagcbaaaaddcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
agaaaaaaaaaaaaakbcaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaaalaaaaaa
akiacaaaaaaaaaaaamaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaa
bkbabaaaadaaaaaadkiacaiaebaaaaaaaaaaaaaaalaaaaaadicaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaak
ccaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaadkiacaaaaaaaaaaa
aiaaaaaaaoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpbkaabaaaaaaaaaaaaaaaaaajecaabaaaaaaaaaaackbabaaaadaaaaaa
ckiacaiaebaaaaaaaaaaaaaaaiaaaaaadicaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaackiacaaaaaaaaaaaakaaaaaadiaaaaaiecaabaaaaaaaaaaadkaabaaa
aaaaaaaabkiacaaaaaaaaaaaaiaaaaaadcaaaaakicaabaaaaaaaaaaabkiacaaa
aaaaaaaaaiaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaa
abaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaakccaabaaaabaaaaaadkiacaia
ebaaaaaaaaaaaaaaamaaaaaaakiacaaaaaaaaaaaanaaaaaaaoaaaaakccaabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaabaaaaaa
aaaaaaajmcaabaaaabaaaaaafgbfbaaaadaaaaaafgincaiaebaaaaaaaaaaaaaa
amaaaaaadicaaaahccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaa
dcaaaaajicaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
aaaaeaeadiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaa
diaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaaaaaaaaak
icaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaaamaaaaaackiacaaaaaaaaaaa
amaaaaaaaoaaaaakicaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdkaabaaaabaaaaaadicaaaahecaabaaaabaaaaaadkaabaaaabaaaaaa
ckaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaa
ckaabaaaabaaaaaadcaaaaakccaabaaaabaaaaaadkaabaaaabaaaaaackaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaadiaaaaahecaabaaaabaaaaaackaabaaa
aaaaaaaabkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaaaaaaaaa
bkaabaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaaagiacaaa
aaaaaaaaaiaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaadaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaa
agbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaadaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaaaeaaaaaa
kgbkbaaaacaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaa
acaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaajhcaabaaaadaaaaaa
egacbaaaaeaaaaaafgbfbaaaacaaaaaaegacbaaaadaaaaaadiaaaaahhcaabaaa
adaaaaaakgakbaaaabaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaa
ggakbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaa
aeaaaaaaegacbaaaaeaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaafaaaaaa
egaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaa
aeaaaaaaegacbaaaafaaaaaakgbkbaaaacaaaaaaegacbaaaaeaaaaaaefaaaaaj
pcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaajhcaabaaaaeaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaa
aeaaaaaadcaaaaajncaabaaaabaaaaaaagajbaaaaeaaaaaaagaabaaaabaaaaaa
agajbaaaadaaaaaaaaaaaaakicaabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaa
anaaaaaaakiacaaaaaaaaaaaaoaaaaaaaoaaaaakicaabaaaacaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaacaaaaaaaaaaaaajdcaabaaa
adaaaaaafgbfbaaaadaaaaaangifcaiaebaaaaaaaaaaaaaaanaaaaaadicaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaabkaabaaaadaaaaaadcaaaaajccaabaaa
adaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaabkaabaaaadaaaaaaaaaaaaakccaabaaaadaaaaaa
bkiacaiaebaaaaaaaaaaaaaaanaaaaaackiacaaaaaaaaaaaanaaaaaaaoaaaaak
ccaabaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaa
adaaaaaadicaaaahbcaabaaaadaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaa
dcaaaaajccaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaa
aaaaeaeadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaa
dcaaaaakicaabaaaacaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadkaabaia
ebaaaaaaacaaaaaadiaaaaahbcaabaaaadaaaaaackaabaaaaaaaaaaadkaabaaa
acaaaaaadiaaaaahicaabaaaacaaaaaabkaabaaaaaaaaaaadkaabaaaacaaaaaa
efaaaaajpcaabaaaaeaaaaaaggakbaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
afaaaaaadiaaaaahocaabaaaadaaaaaaagajbaaaaeaaaaaaagbabaaaacaaaaaa
efaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
afaaaaaadcaaaaajocaabaaaadaaaaaaagajbaaaaeaaaaaakgbkbaaaacaaaaaa
fgaobaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaaacaaaaaaeghobaaa
acaaaaaaaagabaaaafaaaaaadcaaaaajocaabaaaadaaaaaaagajbaaaaeaaaaaa
fgbfbaaaacaaaaaafgaobaaaadaaaaaadcaaaaajncaabaaaabaaaaaafgaobaaa
adaaaaaaagaabaaaadaaaaaaagaobaaaabaaaaaaaaaaaaakbcaabaaaadaaaaaa
bkiacaiaebaaaaaaaaaaaaaaaoaaaaaackiacaaaaaaaaaaaaoaaaaaaaoaaaaak
bcaabaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaa
adaaaaaaaaaaaaajccaabaaaadaaaaaabkbabaaaadaaaaaabkiacaiaebaaaaaa
aaaaaaaaaoaaaaaadicaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaa
adaaaaaadcaaaaajccaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaa
adaaaaaadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaa
diaaaaahgcaabaaaaaaaaaaafgagbaaaaaaaaaaaagaabaaaadaaaaaaefaaaaaj
pcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaahaaaaaa
diaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaahaaaaaa
efaaaaajpcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaa
ahaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaa
egacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaa
acaaaaaaegacbaaaacaaaaaadcaaaaajncaabaaaabaaaaaaagajbaaaacaaaaaa
kgakbaaaaaaaaaaaagaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaa
abaaaaaapgipcaaaaaaaaaaaakaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaa
acaaaaaaeghobaaaaeaaaaaaaagabaaaacaaaaaadiaaaaahhcaabaaaadaaaaaa
egacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
acaaaaaaeghobaaaaeaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaafaaaaaa
cgakbaaaacaaaaaaeghobaaaaeaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaa
acaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaa
dcaaaaajncaabaaaabaaaaaaagajbaaaacaaaaaaagaabaaaaaaaaaaaagaobaaa
abaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaa
alaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaafaaaaaa
aagabaaaaeaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaa
acaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaafaaaaaa
aagabaaaaeaaaaaaefaaaaajpcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaa
afaaaaaaaagabaaaaeaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaaeaaaaaa
kgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaa
afaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaa
egacbaaaacaaaaaafgafbaaaabaaaaaaigadbaaaabaaaaaadiaaaaaihcaabaaa
acaaaaaaegbcbaaaabaaaaaafgifcaaaaaaaaaaaalaaaaaaefaaaaajpcaabaaa
adaaaaaaggakbaaaacaaaaaaeghobaaaagaaaaaaaagabaaaagaaaaaadiaaaaah
hcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaacaaaaaaeghobaaaagaaaaaaaagabaaaagaaaaaaefaaaaaj
pcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaagaaaaaaaagabaaaagaaaaaa
dcaaaaajhcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaa
adaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaa
egacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaapgapbaaa
acaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaa
kgikcaaaaaaaaaaaalaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaa
eghobaaaahaaaaaaaagabaaaaiaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaa
adaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaa
eghobaaaahaaaaaaaagabaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaacgakbaaa
acaaaaaaeghobaaaahaaaaaaaagabaaaaiaaaaaadcaaaaajhcaabaaaadaaaaaa
egacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaa
acaaaaaaegacbaaaacaaaaaafgbfbaaaacaaaaaaegacbaaaadaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaacaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaia
ebaaaaaaaeaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaegbcbaaaaeaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaabaaaaaa
fgifcaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaa
eghobaaaaiaaaaaaaagabaaaajaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaa
eghobaaaaiaaaaaaaagabaaaajaaaaaaefaaaaajpcaabaaaabaaaaaacgakbaaa
abaaaaaaeghobaaaaiaaaaaaaagabaaaajaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaadaaaaaakgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaa
abaaaaaaegacbaaaabaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaak
icaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaajaaaaaadkiacaaaaaaaaaaa
ajaaaaaaaoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaackbabaaaadaaaaaa
ckiacaiaebaaaaaaaaaaaaaaajaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaiaebaaaaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakbabaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaagaaaaaaeghobaaaajaaaaaaaagabaaaaaaaaaaadeaaaaahicaabaaa
aaaaaaaackbabaaaafaaaaaaabeaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaa
pgapbaaaaaaaaaaapgapbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaa
doaaaaab"
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
			Blend OneMinusSrcAlpha SrcAlpha
			Program "vp" {
				SubProgram "opengl " {
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
					ATTR14
					Matrix 9[_Object2World]
					Vector 13[unity_Scale]
					Vector 14[_tintColor]
					Float 15[_steepPower]
					Float 16[_saturation]
					Float 17[_contrast]
					"3.0-!!ARBvp1.0
PARAM c[19] = { { 0, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..17],
		{ 0.29899999, 0.58700001, 0.114 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
DP3 R0.w, vertex.color, c[18];
MUL R2.xyz, R1, vertex.attrib[14].w;
ADD R0.xyz, vertex.color, -R0.w;
MAD R1.xyz, R0, c[16].x, R0.w;
MAD R1.xyz, -c[14], c[14].w, R1;
MUL R0.xyz, c[14], c[14].w;
MAD result.texcoord[3].xyz, R1, c[17].x, R0;
DP3 R0.y, R2, c[9];
DP3 R0.x, vertex.attrib[14], c[9];
DP3 R0.z, vertex.normal, c[9];
MUL result.texcoord[4].xyz, R0, c[13].w;
DP3 R0.y, R2, c[10];
MOV R1.z, vertex.texcoord[1].x;
MOV R1.xy, vertex.texcoord[0];
DP3 R0.w, R1, R1;
DP3 R0.x, vertex.attrib[14], c[10];
DP3 R0.z, vertex.normal, c[10];
MUL result.texcoord[5].xyz, R0, c[13].w;
RSQ R0.x, R0.w;
MUL R1.xyz, R0.x, R1;
DP3 R0.y, R2, c[11];
DP3 R0.x, vertex.attrib[14], c[11];
DP3 R0.z, vertex.normal, c[11];
MUL result.texcoord[6].xyz, R0, c[13].w;
DP4 R0.y, vertex.position, c[3];
MUL R0.x, vertex.texcoord[1].y, c[15];
MIN R0.x, R0, c[0].y;
MOV result.texcoord[0].xyz, R1;
ABS result.texcoord[1].xyz, R1;
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
MOV result.texcoord[2].z, -R0.y;
MOV result.texcoord[2].y, vertex.color.w;
MAX result.texcoord[2].x, R0, c[0];
END
# 39 instructions, 3 R-regs
"
				}
				SubProgram "d3d9 " {
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
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 8[_Object2World]
					Vector 12[unity_Scale]
					Vector 13[_tintColor]
					Float 14[_steepPower]
					Float 15[_saturation]
					Float 16[_contrast]
					"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c17, 0.29899999, 0.58700001, 0.11400000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dcl_color0 v5
mov r1.xyz, v1
dp3 r0.w, v5, c17
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r1.yzxw
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
add r0.xyz, v5, -r0.w
mad r1.xyz, r0, c15.x, r0.w
mad r1.xyz, -c13, c13.w, r1
mul r0.xyz, c13, c13.w
mad o4.xyz, r1, c16.x, r0
dp3 r0.y, r2, c8
dp3 r0.x, v1, c8
dp3 r0.z, v2, c8
mul o5.xyz, r0, c12.w
dp3 r0.y, r2, c9
mov r1.z, v4.x
mov r1.xy, v3
dp3 r0.w, r1, r1
dp3 r0.x, v1, c9
dp3 r0.z, v2, c9
mul o6.xyz, r0, c12.w
rsq r0.x, r0.w
mul r1.xyz, r0.x, r1
dp3 r0.x, v1, c10
dp3 r0.y, r2, c10
dp3 r0.z, v2, c10
mul o7.xyz, r0, c12.w
dp4 r0.x, v0, c2
mov o1.xyz, r1
abs o2.xyz, r1
dp4 o0.w, v0, c7
dp4 o0.z, v0, c6
dp4 o0.y, v0, c5
dp4 o0.x, v0, c4
mov o3.z, -r0.x
mov o3.y, v5.w
mul_sat o3.x, v4.y, c14
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
					Bind "tangent"
					TexCoord2
					ConstBuffer "$Globals"
					192
					Vector 48[_tintColor]
					Float 80[_steepPower]
					Float 176[_saturation]
					Float 180[_contrast]
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
eefiecediglhffpgbcjmpnoblnddkabenchkhiliabaaaaaagaaiaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
hmagaaaaeaaaabaajpabaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaae
egiocaaaabaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaagiaaaaacadaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaa
aaaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaaaaaaaaa
dgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaabkbabaaaaaaaaaaackiacaaaabaaaaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaabaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaagaaaaaackbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaa
dkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaaakaabaia
ebaaaaaaaaaaaaaadicaaaaibccabaaaadaaaaaabkbabaaaaeaaaaaaakiacaaa
aaaaaaaaafaaaaaadgaaaaafcccabaaaadaaaaaadkbabaaaafaaaaaabaaaaaak
bcaabaaaaaaaaaaaegbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdn
aaaaaaaaaaaaaaaiocaabaaaaaaaaaaaagaabaiaebaaaaaaaaaaaaaaagbjbaaa
afaaaaaadcaaaaakhcaabaaaaaaaaaaaagiacaaaaaaaaaaaalaaaaaajgahbaaa
aaaaaaaaagaabaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaaegiccaiaebaaaaaa
aaaaaaaaadaaaaaapgipcaaaaaaaaaaaadaaaaaaegacbaaaaaaaaaaadiaaaaaj
hcaabaaaabaaaaaapgipcaaaaaaaaaaaadaaaaaaegiccaaaaaaaaaaaadaaaaaa
dcaaaaakhccabaaaaeaaaaaafgifcaaaaaaaaaaaalaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaa
acaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaa
egacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
pgbpbaaaabaaaaaadgaaaaagbcaabaaaabaaaaaaakiacaaaabaaaaaaamaaaaaa
dgaaaaagccaabaaaabaaaaaaakiacaaaabaaaaaaanaaaaaadgaaaaagecaabaaa
abaaaaaaakiacaaaabaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaaihccabaaaafaaaaaaegacbaaaacaaaaaapgipcaaaabaaaaaa
beaaaaaadgaaaaagbcaabaaaabaaaaaabkiacaaaabaaaaaaamaaaaaadgaaaaag
ccaabaaaabaaaaaabkiacaaaabaaaaaaanaaaaaadgaaaaagecaabaaaabaaaaaa
bkiacaaaabaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
diaaaaaihccabaaaagaaaaaaegacbaaaacaaaaaapgipcaaaabaaaaaabeaaaaaa
dgaaaaagbcaabaaaabaaaaaackiacaaaabaaaaaaamaaaaaadgaaaaagccaabaaa
abaaaaaackiacaaaabaaaaaaanaaaaaadgaaaaagecaabaaaabaaaaaackiacaaa
abaaaaaaaoaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaahecaabaaaaaaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaai
hccabaaaahaaaaaaegacbaaaaaaaaaaapgipcaaaabaaaaaabeaaaaaadoaaaaab
"
				}
			}
			Program "fp" {
				SubProgram "opengl " {
					"3.0-!!ARBfp1.0
PARAM c[22] = { program.local[0..20],
		{ 1, 0.5 } };
TEMP R0;
MOV R0.z, fragment.texcoord[6];
MOV R0.x, fragment.texcoord[4].z;
MOV R0.y, fragment.texcoord[5].z;
MAD result.color.xyz, R0, c[21].y, c[21].y;
MOV result.color.w, c[21].x;
END
# 5 instructions, 1 R-regs
"
				}
				SubProgram "d3d9 " {
					"ps_3_0
def c0, 0.50000000, 1.00000000, 0, 0
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6.xyz
mov_pp r0.z, v6
mov_pp r0.x, v4.z
mov_pp r0.y, v5.z
mad_pp oC0.xyz, r0, c0.x, c0.x
mov_pp oC0.w, c0.y
"
				}
				SubProgram "d3d11 " {
					"ps_4_0
eefieceddoapiafmdiggacjibdcoaljplpfcbkkdabaaaaaacaacaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaaaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaeaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahaeaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaeaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcnaaaaaaaeaaaaaaadeaaaaaagcbaaaadecbabaaa
afaaaaaagcbaaaadecbabaaaagaaaaaagcbaaaadecbabaaaahaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacabaaaaaadgaaaaafbcaabaaaaaaaaaaackbabaaa
afaaaaaadgaaaaafccaabaaaaaaaaaaackbabaaaagaaaaaadgaaaaafecaabaaa
aaaaaaaackbabaaaahaaaaaadcaaaaaphccabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab
"
				}
			}
		}
		Pass {
			Name "PREPASS"
			Tags {
				"LIGHTMODE" = "PrePassFinal"
			}
			ZWrite Off
			Blend OneMinusSrcAlpha SrcAlpha
			Program "vp" {
				SubProgram "opengl " {
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
					Vector 22[_tintColor]
					Float 23[_steepPower]
					Float 24[_saturation]
					Float 25[_contrast]
					"3.0-!!ARBvp1.0
PARAM c[27] = { { 0, 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..25],
		{ 0.29899999, 0.58700001, 0.114 } };
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
MAD R0.x, R0, R0, -R0.y;
DP4 R3.z, R1, c[19];
DP4 R3.y, R1, c[18];
DP4 R3.x, R1, c[17];
ADD R1.xyz, R2, R3;
MUL R0.xyz, R0.x, c[20];
ADD result.texcoord[5].xyz, R1, R0;
DP3 R0.w, vertex.color, c[26];
ADD R0.xyz, vertex.color, -R0.w;
MAD R3.xyz, R0, c[24].x, R0.w;
DP4 R1.w, vertex.position, c[8];
DP4 R1.z, vertex.position, c[7];
MUL R0.xyz, c[22], c[22].w;
MAD R3.xyz, -c[22], c[22].w, R3;
MAD result.texcoord[3].xyz, R3, c[25].x, R0;
DP4 R1.x, vertex.position, c[5];
DP4 R1.y, vertex.position, c[6];
MUL R2.xyz, R1.xyww, c[0].z;
MUL R2.y, R2, c[13].x;
MOV R0.z, vertex.texcoord[1].x;
MOV R0.xy, vertex.texcoord[0];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
MOV result.texcoord[0].xyz, R0;
ABS result.texcoord[1].xyz, R0;
DP4 R0.y, vertex.position, c[3];
MUL R0.x, vertex.texcoord[1].y, c[23];
MIN R0.x, R0, c[0].y;
ADD result.texcoord[4].xy, R2, R2.z;
MOV result.position, R1;
MOV result.texcoord[4].zw, R1;
MOV result.texcoord[2].z, -R0.y;
MOV result.texcoord[2].y, vertex.color.w;
MAX result.texcoord[2].x, R0, c[0];
END
# 46 instructions, 4 R-regs
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
					Bind "color"
					Color
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
					Vector 22[_tintColor]
					Float 23[_steepPower]
					Float 24[_saturation]
					Float 25[_contrast]
					"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c26, 0.29899999, 0.58700001, 0.11400000, 0.50000000
def c27, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
dcl_color0 v4
mul r1.xyz, v1, c21.w
dp3 r2.w, r1, c9
dp3 r0.x, r1, c8
dp3 r0.z, r1, c10
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c27.x
dp4 r2.z, r0, c16
dp4 r2.y, r0, c15
dp4 r2.x, r0, c14
mul r0.y, r2.w, r2.w
mad r0.x, r0, r0, -r0.y
dp4 r3.z, r1, c19
dp4 r3.y, r1, c18
dp4 r3.x, r1, c17
add r1.xyz, r2, r3
mul r0.xyz, r0.x, c20
add o6.xyz, r1, r0
dp3 r0.w, v4, c26
add r0.xyz, v4, -r0.w
mad r3.xyz, r0, c24.x, r0.w
dp4 r1.w, v0, c7
dp4 r1.z, v0, c6
mul r0.xyz, c22, c22.w
mad r3.xyz, -c22, c22.w, r3
mad o4.xyz, r3, c25.x, r0
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r2.xyz, r1.xyww, c26.w
mul r2.y, r2, c12.x
mov r0.z, v3.x
mov r0.xy, v2
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov o1.xyz, r0
abs o2.xyz, r0
dp4 r0.x, v0, c2
mad o5.xy, r2.z, c13.zwzw, r2
mov o0, r1
mov o5.zw, r1
mov o3.z, -r0.x
mov o3.y, v4.w
mul_sat o3.x, v3.y, c23
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
					208
					Vector 48[_tintColor]
					Float 80[_steepPower]
					Float 176[_saturation]
					Float 180[_contrast]
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
eefiecedkblbkeknbljljnflmlnomipofpcpbieiabaaaaaafaaiaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcieagaaaaeaaaabaakbabaaaafjaaaaaeegiocaaaaaaaaaaa
amaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
cnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaa
aeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagfaaaaad
hccabaaaagaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
dcaabaaaabaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaabaaaaaaakbabaaa
aeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaa
abaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaabaaaaaadiaaaaai
bcaabaaaabaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaak
bcaabaaaabaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
abaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaadaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaadaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaabaaaaaadgaaaaageccabaaaadaaaaaa
akaabaiaebaaaaaaabaaaaaadicaaaaibccabaaaadaaaaaabkbabaaaaeaaaaaa
akiacaaaaaaaaaaaafaaaaaadgaaaaafcccabaaaadaaaaaadkbabaaaafaaaaaa
baaaaaakbcaabaaaabaaaaaaegbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdp
nfhiojdnaaaaaaaaaaaaaaaiocaabaaaabaaaaaaagaabaiaebaaaaaaabaaaaaa
agbjbaaaafaaaaaadcaaaaakhcaabaaaabaaaaaaagiacaaaaaaaaaaaalaaaaaa
jgahbaaaabaaaaaaagaabaaaabaaaaaadcaaaaamhcaabaaaabaaaaaaegiccaia
ebaaaaaaaaaaaaaaadaaaaaapgipcaaaaaaaaaaaadaaaaaaegacbaaaabaaaaaa
diaaaaajhcaabaaaacaaaaaapgipcaaaaaaaaaaaadaaaaaaegiccaaaaaaaaaaa
adaaaaaadcaaaaakhccabaaaaeaaaaaafgifcaaaaaaaaaaaalaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaafaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaafaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaa
beaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaa
aaaaaaaaegaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
aoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaa
abeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaaacaaaaaacgaaaaaa
egaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaaacaaaaaachaaaaaa
egaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaaacaaaaaaciaaaaaa
egaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaa
aaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaa
acaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaa
acaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaa
acaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaadcaaaaakhccabaaaagaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaadoaaaaab"
				}
				SubProgram "opengl " {
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
					Matrix 9[_Object2World]
					Vector 13[_ProjectionParams]
					Vector 14[unity_ShadowFadeCenterAndType]
					Vector 15[_tintColor]
					Float 16[_steepPower]
					Float 17[_saturation]
					Float 18[_contrast]
					Vector 19[unity_LightmapST]
					"3.0-!!ARBvp1.0
PARAM c[21] = { { 0, 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..19],
		{ 0.29899999, 0.58700001, 0.114 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
DP3 R0.w, vertex.color, c[20];
ADD R0.xyz, vertex.color, -R0.w;
MAD R3.xyz, R0, c[17].x, R0.w;
DP4 R1.w, vertex.position, c[8];
DP4 R1.z, vertex.position, c[7];
MUL R0.xyz, c[15], c[15].w;
MAD R3.xyz, -c[15], c[15].w, R3;
MAD result.texcoord[3].xyz, R3, c[18].x, R0;
DP4 R1.x, vertex.position, c[5];
DP4 R1.y, vertex.position, c[6];
MUL R2.xyz, R1.xyww, c[0].z;
MUL R2.y, R2, c[13].x;
MOV R0.z, vertex.texcoord[1].x;
MOV R0.xy, vertex.texcoord[0];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
MOV result.texcoord[0].xyz, R0;
ABS result.texcoord[1].xyz, R0;
DP4 R0.z, vertex.position, c[11];
DP4 R0.x, vertex.position, c[9];
DP4 R0.y, vertex.position, c[10];
ADD R0.xyz, R0, -c[14];
MUL result.texcoord[6].xyz, R0, c[14].w;
DP4 R0.y, vertex.position, c[3];
MOV R0.x, c[0].y;
ADD R0.x, R0, -c[14].w;
MUL result.texcoord[6].w, -R0.y, R0.x;
MUL R0.x, vertex.texcoord[1].y, c[16];
MIN R0.x, R0, c[0].y;
ADD result.texcoord[4].xy, R2, R2.z;
MOV result.position, R1;
MOV result.texcoord[4].zw, R1;
MAD result.texcoord[5].xy, vertex.texcoord[1], c[19], c[19].zwzw;
MOV result.texcoord[2].z, -R0.y;
MOV result.texcoord[2].y, vertex.color.w;
MAX result.texcoord[2].x, R0, c[0];
END
# 37 instructions, 4 R-regs
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
					Bind "color"
					Color
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
					Vector 15[_tintColor]
					Float 16[_steepPower]
					Float 17[_saturation]
					Float 18[_contrast]
					Vector 19[unity_LightmapST]
					"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c20, 0.29899999, 0.58700001, 0.11400000, 0.50000000
def c21, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dcl_color0 v3
dp3 r0.w, v3, c20
add r0.xyz, v3, -r0.w
mad r3.xyz, r0, c17.x, r0.w
dp4 r1.w, v0, c7
dp4 r1.z, v0, c6
mul r0.xyz, c15, c15.w
mad r3.xyz, -c15, c15.w, r3
mad o4.xyz, r3, c18.x, r0
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r2.xyz, r1.xyww, c20.w
mul r2.y, r2, c12.x
mov r0.z, v2.x
mov r0.xy, v1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov o1.xyz, r0
abs o2.xyz, r0
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
add r0.xyz, r0, -c14
mul o7.xyz, r0, c14.w
mov r0.x, c14.w
add r0.y, c21.x, -r0.x
dp4 r0.x, v0, c2
mad o5.xy, r2.z, c13.zwzw, r2
mov o0, r1
mov o5.zw, r1
mad o6.xy, v2, c19, c19.zwzw
mul o7.w, -r0.x, r0.y
mov o3.z, -r0.x
mov o3.y, v3.w
mul_sat o3.x, v2.y, c16
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
					240
					Vector 48[_tintColor]
					Float 80[_steepPower]
					Float 176[_saturation]
					Float 180[_contrast]
					Vector 192[unity_LightmapST]
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
eefiecedhnjijlbbejnokpljhjfmoafhmhhdcffoabaaaaaakmahaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaadamaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
miafaaaaeaaaabaahcabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabkaaaaaafjaaaaae
egiocaaaadaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaaddcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
pccabaaaafaaaaaagfaaaaaddccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaa
giaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaaabaaaaaa
egbabaaaadaaaaaadgaaaaafecaabaaaabaaaaaaakbabaaaaeaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaadgaaaaag
hccabaaaacaaaaaaegacbaiaibaaaaaaabaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaabaaaaaa
ckiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaak
bcaabaaaabaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
abaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaabaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaa
abaaaaaadicaaaaibccabaaaadaaaaaabkbabaaaaeaaaaaaakiacaaaaaaaaaaa
afaaaaaadgaaaaafcccabaaaadaaaaaadkbabaaaafaaaaaabaaaaaakccaabaaa
abaaaaaaegbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaa
aaaaaaaihcaabaaaacaaaaaafgafbaiaebaaaaaaabaaaaaaegbcbaaaafaaaaaa
dcaaaaakocaabaaaabaaaaaaagiacaaaaaaaaaaaalaaaaaaagajbaaaacaaaaaa
fgafbaaaabaaaaaadcaaaaamocaabaaaabaaaaaaagijcaiaebaaaaaaaaaaaaaa
adaaaaaapgipcaaaaaaaaaaaadaaaaaafgaobaaaabaaaaaadiaaaaajhcaabaaa
acaaaaaapgipcaaaaaaaaaaaadaaaaaaegiccaaaaaaaaaaaadaaaaaadcaaaaak
hccabaaaaeaaaaaafgifcaaaaaaaaaaaalaaaaaajgahbaaaabaaaaaaegacbaaa
acaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaacaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaafaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaafaaaaaakgakbaaaacaaaaaamgaabaaaacaaaaaadcaaaaal
dccabaaaagaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaamaaaaaaogikcaaa
aaaaaaaaamaaaaaaaaaaaaajbcaabaaaaaaaaaaadkiacaiaebaaaaaaacaaaaaa
bjaaaaaaabeaaaaaaaaaiadpdiaaaaaiiccabaaaahaaaaaaakaabaaaaaaaaaaa
akaabaiaebaaaaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaa
acaaaaaabjaaaaaadiaaaaaihccabaaaahaaaaaaegacbaaaaaaaaaaapgipcaaa
acaaaaaabjaaaaaadoaaaaab"
				}
				SubProgram "opengl " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
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
					Vector 9[_ProjectionParams]
					Vector 10[_tintColor]
					Float 11[_steepPower]
					Float 12[_saturation]
					Float 13[_contrast]
					Vector 14[unity_LightmapST]
					"3.0-!!ARBvp1.0
PARAM c[16] = { { 0, 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..14],
		{ 0.29899999, 0.58700001, 0.114 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
DP3 R0.w, vertex.color, c[15];
ADD R0.xyz, vertex.color, -R0.w;
MAD R3.xyz, R0, c[12].x, R0.w;
DP4 R1.w, vertex.position, c[8];
DP4 R1.z, vertex.position, c[7];
MUL R0.xyz, c[10], c[10].w;
MAD R3.xyz, -c[10], c[10].w, R3;
MAD result.texcoord[3].xyz, R3, c[13].x, R0;
DP4 R1.x, vertex.position, c[5];
DP4 R1.y, vertex.position, c[6];
MUL R2.xyz, R1.xyww, c[0].z;
MUL R2.y, R2, c[9].x;
MOV R0.z, vertex.texcoord[1].x;
MOV R0.xy, vertex.texcoord[0];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
MOV result.texcoord[0].xyz, R0;
ABS result.texcoord[1].xyz, R0;
DP4 R0.y, vertex.position, c[3];
MUL R0.x, vertex.texcoord[1].y, c[11];
MIN R0.x, R0, c[0].y;
ADD result.texcoord[4].xy, R2, R2.z;
MOV result.position, R1;
MOV result.texcoord[4].zw, R1;
MAD result.texcoord[5].xy, vertex.texcoord[1], c[14], c[14].zwzw;
MOV result.texcoord[2].z, -R0.y;
MOV result.texcoord[2].y, vertex.color.w;
MAX result.texcoord[2].x, R0, c[0];
END
# 29 instructions, 4 R-regs
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
					Bind "color"
					Color
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Vector 8[_ProjectionParams]
					Vector 9[_ScreenParams]
					Vector 10[_tintColor]
					Float 11[_steepPower]
					Float 12[_saturation]
					Float 13[_contrast]
					Vector 14[unity_LightmapST]
					"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c15, 0.29899999, 0.58700001, 0.11400000, 0.50000000
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dcl_color0 v3
dp3 r0.w, v3, c15
add r0.xyz, v3, -r0.w
mad r3.xyz, r0, c12.x, r0.w
dp4 r1.w, v0, c7
dp4 r1.z, v0, c6
mul r0.xyz, c10, c10.w
mad r3.xyz, -c10, c10.w, r3
mad o4.xyz, r3, c13.x, r0
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r2.xyz, r1.xyww, c15.w
mul r2.y, r2, c8.x
mov r0.z, v2.x
mov r0.xy, v1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov o1.xyz, r0
abs o2.xyz, r0
dp4 r0.x, v0, c2
mad o5.xy, r2.z, c9.zwzw, r2
mov o0, r1
mov o5.zw, r1
mad o6.xy, v2, c14, c14.zwzw
mov o3.z, -r0.x
mov o3.y, v3.w
mul_sat o3.x, v2.y, c11
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
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					240
					Vector 48[_tintColor]
					Float 80[_steepPower]
					Float 176[_saturation]
					Float 180[_contrast]
					Vector 192[unity_LightmapST]
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
eefiecedceailnefbalgnalmegomecohijaljbfkabaaaaaafiagaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcimaeaaaaeaaaabaacdabaaaafjaaaaaeegiocaaaaaaaaaaa
anaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaa
gfaaaaaddccabaaaagaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaabaaaaaa
akbabaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaabaaaaaa
egacbaaaabaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaabaaaaaa
diaaaaaibcaabaaaabaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaa
dcaaaaakbcaabaaaabaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaa
akaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaacaaaaaaagaaaaaa
ckbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaa
acaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaabaaaaaadgaaaaageccabaaa
adaaaaaaakaabaiaebaaaaaaabaaaaaadicaaaaibccabaaaadaaaaaabkbabaaa
aeaaaaaaakiacaaaaaaaaaaaafaaaaaadgaaaaafcccabaaaadaaaaaadkbabaaa
afaaaaaabaaaaaakbcaabaaaabaaaaaaegbcbaaaafaaaaaaaceaaaaaihbgjjdo
kcefbgdpnfhiojdnaaaaaaaaaaaaaaaiocaabaaaabaaaaaaagaabaiaebaaaaaa
abaaaaaaagbjbaaaafaaaaaadcaaaaakhcaabaaaabaaaaaaagiacaaaaaaaaaaa
alaaaaaajgahbaaaabaaaaaaagaabaaaabaaaaaadcaaaaamhcaabaaaabaaaaaa
egiccaiaebaaaaaaaaaaaaaaadaaaaaapgipcaaaaaaaaaaaadaaaaaaegacbaaa
abaaaaaadiaaaaajhcaabaaaacaaaaaapgipcaaaaaaaaaaaadaaaaaaegiccaaa
aaaaaaaaadaaaaaadcaaaaakhccabaaaaeaaaaaafgifcaaaaaaaaaaaalaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
afaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaafaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadcaaaaaldccabaaaagaaaaaaegbabaaaaeaaaaaaegiacaaa
aaaaaaaaamaaaaaaogikcaaaaaaaaaaaamaaaaaadoaaaaab"
				}
				SubProgram "opengl " {
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
					Vector 22[_tintColor]
					Float 23[_steepPower]
					Float 24[_saturation]
					Float 25[_contrast]
					"3.0-!!ARBvp1.0
PARAM c[27] = { { 0, 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..25],
		{ 0.29899999, 0.58700001, 0.114 } };
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
MAD R0.x, R0, R0, -R0.y;
DP4 R3.z, R1, c[19];
DP4 R3.y, R1, c[18];
DP4 R3.x, R1, c[17];
ADD R1.xyz, R2, R3;
MUL R0.xyz, R0.x, c[20];
ADD result.texcoord[5].xyz, R1, R0;
DP3 R0.w, vertex.color, c[26];
ADD R0.xyz, vertex.color, -R0.w;
MAD R3.xyz, R0, c[24].x, R0.w;
DP4 R1.w, vertex.position, c[8];
DP4 R1.z, vertex.position, c[7];
MUL R0.xyz, c[22], c[22].w;
MAD R3.xyz, -c[22], c[22].w, R3;
MAD result.texcoord[3].xyz, R3, c[25].x, R0;
DP4 R1.x, vertex.position, c[5];
DP4 R1.y, vertex.position, c[6];
MUL R2.xyz, R1.xyww, c[0].z;
MUL R2.y, R2, c[13].x;
MOV R0.z, vertex.texcoord[1].x;
MOV R0.xy, vertex.texcoord[0];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
MOV result.texcoord[0].xyz, R0;
ABS result.texcoord[1].xyz, R0;
DP4 R0.y, vertex.position, c[3];
MUL R0.x, vertex.texcoord[1].y, c[23];
MIN R0.x, R0, c[0].y;
ADD result.texcoord[4].xy, R2, R2.z;
MOV result.position, R1;
MOV result.texcoord[4].zw, R1;
MOV result.texcoord[2].z, -R0.y;
MOV result.texcoord[2].y, vertex.color.w;
MAX result.texcoord[2].x, R0, c[0];
END
# 46 instructions, 4 R-regs
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
					Bind "color"
					Color
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
					Vector 22[_tintColor]
					Float 23[_steepPower]
					Float 24[_saturation]
					Float 25[_contrast]
					"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c26, 0.29899999, 0.58700001, 0.11400000, 0.50000000
def c27, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
dcl_color0 v4
mul r1.xyz, v1, c21.w
dp3 r2.w, r1, c9
dp3 r0.x, r1, c8
dp3 r0.z, r1, c10
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c27.x
dp4 r2.z, r0, c16
dp4 r2.y, r0, c15
dp4 r2.x, r0, c14
mul r0.y, r2.w, r2.w
mad r0.x, r0, r0, -r0.y
dp4 r3.z, r1, c19
dp4 r3.y, r1, c18
dp4 r3.x, r1, c17
add r1.xyz, r2, r3
mul r0.xyz, r0.x, c20
add o6.xyz, r1, r0
dp3 r0.w, v4, c26
add r0.xyz, v4, -r0.w
mad r3.xyz, r0, c24.x, r0.w
dp4 r1.w, v0, c7
dp4 r1.z, v0, c6
mul r0.xyz, c22, c22.w
mad r3.xyz, -c22, c22.w, r3
mad o4.xyz, r3, c25.x, r0
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r2.xyz, r1.xyww, c26.w
mul r2.y, r2, c12.x
mov r0.z, v3.x
mov r0.xy, v2
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov o1.xyz, r0
abs o2.xyz, r0
dp4 r0.x, v0, c2
mad o5.xy, r2.z, c13.zwzw, r2
mov o0, r1
mov o5.zw, r1
mov o3.z, -r0.x
mov o3.y, v4.w
mul_sat o3.x, v3.y, c23
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
					208
					Vector 48[_tintColor]
					Float 80[_steepPower]
					Float 176[_saturation]
					Float 180[_contrast]
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
eefiecedkblbkeknbljljnflmlnomipofpcpbieiabaaaaaafaaiaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcieagaaaaeaaaabaakbabaaaafjaaaaaeegiocaaaaaaaaaaa
amaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
cnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaa
aeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagfaaaaad
hccabaaaagaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
dcaabaaaabaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaabaaaaaaakbabaaa
aeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaa
abaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaabaaaaaadiaaaaai
bcaabaaaabaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaak
bcaabaaaabaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
abaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaadaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaadaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaabaaaaaadgaaaaageccabaaaadaaaaaa
akaabaiaebaaaaaaabaaaaaadicaaaaibccabaaaadaaaaaabkbabaaaaeaaaaaa
akiacaaaaaaaaaaaafaaaaaadgaaaaafcccabaaaadaaaaaadkbabaaaafaaaaaa
baaaaaakbcaabaaaabaaaaaaegbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdp
nfhiojdnaaaaaaaaaaaaaaaiocaabaaaabaaaaaaagaabaiaebaaaaaaabaaaaaa
agbjbaaaafaaaaaadcaaaaakhcaabaaaabaaaaaaagiacaaaaaaaaaaaalaaaaaa
jgahbaaaabaaaaaaagaabaaaabaaaaaadcaaaaamhcaabaaaabaaaaaaegiccaia
ebaaaaaaaaaaaaaaadaaaaaapgipcaaaaaaaaaaaadaaaaaaegacbaaaabaaaaaa
diaaaaajhcaabaaaacaaaaaapgipcaaaaaaaaaaaadaaaaaaegiccaaaaaaaaaaa
adaaaaaadcaaaaakhccabaaaaeaaaaaafgifcaaaaaaaaaaaalaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaafaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaafaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaa
beaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaa
aaaaaaaaegaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
aoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaa
abeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaaacaaaaaacgaaaaaa
egaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaaacaaaaaachaaaaaa
egaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaaacaaaaaaciaaaaaa
egaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaa
aaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaa
acaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaa
acaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaa
acaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaadcaaaaakhccabaaaagaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaadoaaaaab"
				}
				SubProgram "opengl " {
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
					Matrix 9[_Object2World]
					Vector 13[_ProjectionParams]
					Vector 14[unity_ShadowFadeCenterAndType]
					Vector 15[_tintColor]
					Float 16[_steepPower]
					Float 17[_saturation]
					Float 18[_contrast]
					Vector 19[unity_LightmapST]
					"3.0-!!ARBvp1.0
PARAM c[21] = { { 0, 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..19],
		{ 0.29899999, 0.58700001, 0.114 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
DP3 R0.w, vertex.color, c[20];
ADD R0.xyz, vertex.color, -R0.w;
MAD R3.xyz, R0, c[17].x, R0.w;
DP4 R1.w, vertex.position, c[8];
DP4 R1.z, vertex.position, c[7];
MUL R0.xyz, c[15], c[15].w;
MAD R3.xyz, -c[15], c[15].w, R3;
MAD result.texcoord[3].xyz, R3, c[18].x, R0;
DP4 R1.x, vertex.position, c[5];
DP4 R1.y, vertex.position, c[6];
MUL R2.xyz, R1.xyww, c[0].z;
MUL R2.y, R2, c[13].x;
MOV R0.z, vertex.texcoord[1].x;
MOV R0.xy, vertex.texcoord[0];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
MOV result.texcoord[0].xyz, R0;
ABS result.texcoord[1].xyz, R0;
DP4 R0.z, vertex.position, c[11];
DP4 R0.x, vertex.position, c[9];
DP4 R0.y, vertex.position, c[10];
ADD R0.xyz, R0, -c[14];
MUL result.texcoord[6].xyz, R0, c[14].w;
DP4 R0.y, vertex.position, c[3];
MOV R0.x, c[0].y;
ADD R0.x, R0, -c[14].w;
MUL result.texcoord[6].w, -R0.y, R0.x;
MUL R0.x, vertex.texcoord[1].y, c[16];
MIN R0.x, R0, c[0].y;
ADD result.texcoord[4].xy, R2, R2.z;
MOV result.position, R1;
MOV result.texcoord[4].zw, R1;
MAD result.texcoord[5].xy, vertex.texcoord[1], c[19], c[19].zwzw;
MOV result.texcoord[2].z, -R0.y;
MOV result.texcoord[2].y, vertex.color.w;
MAX result.texcoord[2].x, R0, c[0];
END
# 37 instructions, 4 R-regs
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
					Bind "color"
					Color
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
					Vector 15[_tintColor]
					Float 16[_steepPower]
					Float 17[_saturation]
					Float 18[_contrast]
					Vector 19[unity_LightmapST]
					"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c20, 0.29899999, 0.58700001, 0.11400000, 0.50000000
def c21, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dcl_color0 v3
dp3 r0.w, v3, c20
add r0.xyz, v3, -r0.w
mad r3.xyz, r0, c17.x, r0.w
dp4 r1.w, v0, c7
dp4 r1.z, v0, c6
mul r0.xyz, c15, c15.w
mad r3.xyz, -c15, c15.w, r3
mad o4.xyz, r3, c18.x, r0
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r2.xyz, r1.xyww, c20.w
mul r2.y, r2, c12.x
mov r0.z, v2.x
mov r0.xy, v1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov o1.xyz, r0
abs o2.xyz, r0
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
add r0.xyz, r0, -c14
mul o7.xyz, r0, c14.w
mov r0.x, c14.w
add r0.y, c21.x, -r0.x
dp4 r0.x, v0, c2
mad o5.xy, r2.z, c13.zwzw, r2
mov o0, r1
mov o5.zw, r1
mad o6.xy, v2, c19, c19.zwzw
mul o7.w, -r0.x, r0.y
mov o3.z, -r0.x
mov o3.y, v3.w
mul_sat o3.x, v2.y, c16
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
					240
					Vector 48[_tintColor]
					Float 80[_steepPower]
					Float 176[_saturation]
					Float 180[_contrast]
					Vector 192[unity_LightmapST]
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
eefiecedhnjijlbbejnokpljhjfmoafhmhhdcffoabaaaaaakmahaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaadamaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
miafaaaaeaaaabaahcabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabkaaaaaafjaaaaae
egiocaaaadaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaaddcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
pccabaaaafaaaaaagfaaaaaddccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaa
giaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaaabaaaaaa
egbabaaaadaaaaaadgaaaaafecaabaaaabaaaaaaakbabaaaaeaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaadgaaaaag
hccabaaaacaaaaaaegacbaiaibaaaaaaabaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaabaaaaaa
ckiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaak
bcaabaaaabaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
abaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaabaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaa
abaaaaaadicaaaaibccabaaaadaaaaaabkbabaaaaeaaaaaaakiacaaaaaaaaaaa
afaaaaaadgaaaaafcccabaaaadaaaaaadkbabaaaafaaaaaabaaaaaakccaabaaa
abaaaaaaegbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaa
aaaaaaaihcaabaaaacaaaaaafgafbaiaebaaaaaaabaaaaaaegbcbaaaafaaaaaa
dcaaaaakocaabaaaabaaaaaaagiacaaaaaaaaaaaalaaaaaaagajbaaaacaaaaaa
fgafbaaaabaaaaaadcaaaaamocaabaaaabaaaaaaagijcaiaebaaaaaaaaaaaaaa
adaaaaaapgipcaaaaaaaaaaaadaaaaaafgaobaaaabaaaaaadiaaaaajhcaabaaa
acaaaaaapgipcaaaaaaaaaaaadaaaaaaegiccaaaaaaaaaaaadaaaaaadcaaaaak
hccabaaaaeaaaaaafgifcaaaaaaaaaaaalaaaaaajgahbaaaabaaaaaaegacbaaa
acaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaacaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaafaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaafaaaaaakgakbaaaacaaaaaamgaabaaaacaaaaaadcaaaaal
dccabaaaagaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaamaaaaaaogikcaaa
aaaaaaaaamaaaaaaaaaaaaajbcaabaaaaaaaaaaadkiacaiaebaaaaaaacaaaaaa
bjaaaaaaabeaaaaaaaaaiadpdiaaaaaiiccabaaaahaaaaaaakaabaaaaaaaaaaa
akaabaiaebaaaaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaa
acaaaaaabjaaaaaadiaaaaaihccabaaaahaaaaaaegacbaaaaaaaaaaapgipcaaa
acaaaaaabjaaaaaadoaaaaab"
				}
				SubProgram "opengl " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
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
					Vector 9[_ProjectionParams]
					Vector 10[_tintColor]
					Float 11[_steepPower]
					Float 12[_saturation]
					Float 13[_contrast]
					Vector 14[unity_LightmapST]
					"3.0-!!ARBvp1.0
PARAM c[16] = { { 0, 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..14],
		{ 0.29899999, 0.58700001, 0.114 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
DP3 R0.w, vertex.color, c[15];
ADD R0.xyz, vertex.color, -R0.w;
MAD R3.xyz, R0, c[12].x, R0.w;
DP4 R1.w, vertex.position, c[8];
DP4 R1.z, vertex.position, c[7];
MUL R0.xyz, c[10], c[10].w;
MAD R3.xyz, -c[10], c[10].w, R3;
MAD result.texcoord[3].xyz, R3, c[13].x, R0;
DP4 R1.x, vertex.position, c[5];
DP4 R1.y, vertex.position, c[6];
MUL R2.xyz, R1.xyww, c[0].z;
MUL R2.y, R2, c[9].x;
MOV R0.z, vertex.texcoord[1].x;
MOV R0.xy, vertex.texcoord[0];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
MOV result.texcoord[0].xyz, R0;
ABS result.texcoord[1].xyz, R0;
DP4 R0.y, vertex.position, c[3];
MUL R0.x, vertex.texcoord[1].y, c[11];
MIN R0.x, R0, c[0].y;
ADD result.texcoord[4].xy, R2, R2.z;
MOV result.position, R1;
MOV result.texcoord[4].zw, R1;
MAD result.texcoord[5].xy, vertex.texcoord[1], c[14], c[14].zwzw;
MOV result.texcoord[2].z, -R0.y;
MOV result.texcoord[2].y, vertex.color.w;
MAX result.texcoord[2].x, R0, c[0];
END
# 29 instructions, 4 R-regs
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
					Bind "color"
					Color
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Vector 8[_ProjectionParams]
					Vector 9[_ScreenParams]
					Vector 10[_tintColor]
					Float 11[_steepPower]
					Float 12[_saturation]
					Float 13[_contrast]
					Vector 14[unity_LightmapST]
					"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c15, 0.29899999, 0.58700001, 0.11400000, 0.50000000
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dcl_color0 v3
dp3 r0.w, v3, c15
add r0.xyz, v3, -r0.w
mad r3.xyz, r0, c12.x, r0.w
dp4 r1.w, v0, c7
dp4 r1.z, v0, c6
mul r0.xyz, c10, c10.w
mad r3.xyz, -c10, c10.w, r3
mad o4.xyz, r3, c13.x, r0
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r2.xyz, r1.xyww, c15.w
mul r2.y, r2, c8.x
mov r0.z, v2.x
mov r0.xy, v1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov o1.xyz, r0
abs o2.xyz, r0
dp4 r0.x, v0, c2
mad o5.xy, r2.z, c9.zwzw, r2
mov o0, r1
mov o5.zw, r1
mad o6.xy, v2, c14, c14.zwzw
mov o3.z, -r0.x
mov o3.y, v3.w
mul_sat o3.x, v2.y, c11
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
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					240
					Vector 48[_tintColor]
					Float 80[_steepPower]
					Float 176[_saturation]
					Float 180[_contrast]
					Vector 192[unity_LightmapST]
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
eefiecedceailnefbalgnalmegomecohijaljbfkabaaaaaafiagaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcimaeaaaaeaaaabaacdabaaaafjaaaaaeegiocaaaaaaaaaaa
anaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaa
gfaaaaaddccabaaaagaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaabaaaaaa
akbabaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaabaaaaaa
egacbaaaabaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaabaaaaaa
diaaaaaibcaabaaaabaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaa
dcaaaaakbcaabaaaabaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaa
akaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaacaaaaaaagaaaaaa
ckbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaa
acaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaabaaaaaadgaaaaageccabaaa
adaaaaaaakaabaiaebaaaaaaabaaaaaadicaaaaibccabaaaadaaaaaabkbabaaa
aeaaaaaaakiacaaaaaaaaaaaafaaaaaadgaaaaafcccabaaaadaaaaaadkbabaaa
afaaaaaabaaaaaakbcaabaaaabaaaaaaegbcbaaaafaaaaaaaceaaaaaihbgjjdo
kcefbgdpnfhiojdnaaaaaaaaaaaaaaaiocaabaaaabaaaaaaagaabaiaebaaaaaa
abaaaaaaagbjbaaaafaaaaaadcaaaaakhcaabaaaabaaaaaaagiacaaaaaaaaaaa
alaaaaaajgahbaaaabaaaaaaagaabaaaabaaaaaadcaaaaamhcaabaaaabaaaaaa
egiccaiaebaaaaaaaaaaaaaaadaaaaaapgipcaaaaaaaaaaaadaaaaaaegacbaaa
abaaaaaadiaaaaajhcaabaaaacaaaaaapgipcaaaaaaaaaaaadaaaaaaegiccaaa
aaaaaaaaadaaaaaadcaaaaakhccabaaaaeaaaaaafgifcaaaaaaaaaaaalaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
afaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaafaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadcaaaaaldccabaaaagaaaaaaegbabaaaaeaaaaaaegiacaaa
aaaaaaaaamaaaaaaogikcaaaaaaaaaaaamaaaaaadoaaaaab"
				}
			}
			Program "fp" {
				SubProgram "opengl " {
					Keywords {
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_OFF"
					}
					Float 0[_texTiling]
					Float 1[_texPower]
					Float 2[_groundTexStart]
					Float 3[_groundTexEnd]
					Float 4[_steepTiling]
					Float 5[_steepTexStart]
					Float 6[_steepTexEnd]
					Float 7[_multiPower]
					Float 8[_deepMultiFactor]
					Float 9[_mainMultiFactor]
					Float 10[_highMultiFactor]
					Float 11[_snowMultiFactor]
					Float 12[_deepStart]
					Float 13[_deepEnd]
					Float 14[_mainLoStart]
					Float 15[_mainLoEnd]
					Float 16[_mainHiStart]
					Float 17[_mainHiEnd]
					Float 18[_hiLoStart]
					Float 19[_hiLoEnd]
					Float 20[_hiHiStart]
					Float 21[_hiHiEnd]
					Float 22[_snowStart]
					Float 23[_snowEnd]
					Float 24[_PlanetOpacity]
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 1
					SetTexture 2[_highTex] 2D 2
					SetTexture 3[_snowTex] 2D 3
					SetTexture 4[_deepMultiTex] 2D 4
					SetTexture 5[_mainMultiTex] 2D 5
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[_LightBuffer] 2D 9 "3.0-!!ARBfp1.0
PARAM c[26] = { program.local[0..24],
		{ 2, 3, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.x, c[2];
ADD R0.x, -R0, c[3];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].z, -c[2];
MUL_SAT R0.w, R0.x, R0.y;
MUL R3.xyz, fragment.texcoord[0], c[0].x;
MAD R1.x, -R0.w, c[25], c[25].y;
MUL R0.w, R0, R0;
MOV R2.w, c[12].x;
ADD R2.w, -R2, c[13].x;
RCP R4.x, R2.w;
ADD R2.w, fragment.texcoord[2].y, -c[12].x;
MUL_SAT R2.w, R2, R4.x;
TEX R0.xyz, R3.zyzw, texture[1], 2D;
MUL R0.w, R0, R1.x;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[1], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R0, R1;
ADD R0.x, -R0.w, c[25].z;
MOV R0.z, c[16].x;
ADD R0.z, -R0, c[17].x;
RCP R1.w, R0.z;
ADD R0.z, fragment.texcoord[2].y, -c[16].x;
MUL_SAT R1.w, R0.z, R1;
MOV R0.y, c[14].x;
ADD R0.y, -R0, c[15].x;
RCP R0.z, R0.y;
ADD R0.y, fragment.texcoord[2], -c[14].x;
MUL_SAT R0.y, R0, R0.z;
MUL R0.w, R0, c[7].x;
MAD R2.x, -R1.w, c[25], c[25].y;
MUL R0.z, R1.w, R1.w;
MUL R1.w, R0.z, R2.x;
MUL R0.z, R0.y, R0.y;
MAD R0.y, -R0, c[25].x, c[25];
MAD R3.w, R0.z, R0.y, -R1;
MUL R1.w, R0.x, c[1].x;
MUL R2.x, R1.w, R3.w;
TEX R0.xyz, R3.zxzw, texture[1], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R0, R1;
MUL R1.xyz, R0, R2.x;
TEX R2.xyz, R3.zyzw, texture[0], 2D;
TEX R0.xyz, R3, texture[0], 2D;
MUL R2.xyz, fragment.texcoord[1].x, R2;
MAD R2.xyz, fragment.texcoord[1].z, R0, R2;
MAD R0.y, -R2.w, c[25].x, c[25];
MUL R0.x, R2.w, R2.w;
MAD R4.x, -R0, R0.y, c[25].z;
TEX R0.xyz, R3.zxzw, texture[0], 2D;
MUL R2.w, R1, R4.x;
MAD R2.xyz, fragment.texcoord[1].y, R0, R2;
TEX R0.xyz, R3.zyzw, texture[2], 2D;
MAD R2.xyz, R2, R2.w, R1;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[2], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R0, R1;
MOV R0.y, c[20].x;
ADD R0.y, -R0, c[21].x;
RCP R0.z, R0.y;
ADD R0.y, fragment.texcoord[2], -c[20].x;
MUL_SAT R0.z, R0.y, R0;
MOV R0.x, c[18];
ADD R0.x, -R0, c[19];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].y, -c[18];
MUL_SAT R0.x, R0, R0.y;
MAD R2.w, -R0.z, c[25].x, c[25].y;
MUL R0.y, R0.z, R0.z;
MUL R0.z, R0.y, R2.w;
MUL R0.y, R0.x, R0.x;
MAD R0.x, -R0, c[25], c[25].y;
MAD R2.w, R0.y, R0.x, -R0.z;
TEX R0.xyz, R3.zxzw, texture[2], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R0, R1;
MUL R1.x, R1.w, R2.w;
MAD R2.xyz, R0, R1.x, R2;
TEX R1.xyz, R3.zyzw, texture[3], 2D;
TEX R0.xyz, R3, texture[3], 2D;
MUL R1.xyz, fragment.texcoord[1].x, R1;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[3], 2D;
MOV R3.y, c[22].x;
ADD R3.y, -R3, c[23].x;
MAD R1.xyz, fragment.texcoord[1].y, R1, R0;
RCP R3.y, R3.y;
ADD R3.x, fragment.texcoord[2].y, -c[22];
MUL_SAT R3.x, R3, R3.y;
MAD R0.y, -R3.x, c[25].x, c[25];
MUL R0.x, R3, R3;
MUL R4.y, R0.x, R0;
MUL R3.xyz, fragment.texcoord[0], c[8].x;
MUL R4.z, R1.w, R4.y;
TEX R0.xyz, R3.zyzw, texture[4], 2D;
MAD R2.xyz, R1, R4.z, R2;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[4], 2D;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[4], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R1, R0;
MUL R1.xyz, fragment.texcoord[0], c[9].x;
MUL R4.x, R0.w, R4;
MAD R0.xyz, R0, R4.x, R2;
TEX R3.xyz, R1.zyzw, texture[5], 2D;
TEX R2.xyz, R1, texture[5], 2D;
MUL R3.xyz, fragment.texcoord[1].x, R3;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[5], 2D;
MAD R3.xyz, fragment.texcoord[1].y, R1, R2;
MUL R1.xyz, fragment.texcoord[0], c[10].x;
MUL R3.w, R0, R3;
TEX R2.xyz, R1.zyzw, texture[6], 2D;
MAD R0.xyz, R3, R3.w, R0;
MUL R3.xyz, fragment.texcoord[1].x, R2;
TEX R2.xyz, R1, texture[6], 2D;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[6], 2D;
MAD R3.xyz, fragment.texcoord[1].y, R1, R2;
MUL R1.xyz, fragment.texcoord[0], c[11].x;
MUL R2.w, R0, R2;
TEX R2.xyz, R1.zyzw, texture[7], 2D;
MAD R0.xyz, R3, R2.w, R0;
MUL R3.xyz, fragment.texcoord[1].x, R2;
TEX R2.xyz, R1, texture[7], 2D;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[7], 2D;
MAD R1.xyz, fragment.texcoord[1].y, R1, R2;
MUL R2.x, R0.w, R4.y;
MAD R0.xyz, R1, R2.x, R0;
MAD R2.xyz, fragment.texcoord[3], R0, -fragment.texcoord[3];
MUL R1.xyz, fragment.texcoord[0], c[4].x;
ADD R0.w, R1, R0;
MAD R3.xyz, R0.w, R2, fragment.texcoord[3];
TEX R0.xyz, R1.zyzw, texture[8], 2D;
MUL R2.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R1, texture[8], 2D;
MAD R0.xyz, fragment.texcoord[1].z, R0, R2;
TEX R1.xyz, R1.zxzw, texture[8], 2D;
MAD R1.xyz, R1, fragment.texcoord[1].y, R0;
MOV R0.w, c[5].x;
ADD R0.x, -R0.w, c[6];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].z, -c[5];
MUL_SAT R0.w, R0.x, R0.y;
TXP R0.xyz, fragment.texcoord[4], texture[9], 2D;
MAD R1.w, -R0, c[25].x, c[25].y;
MUL R0.w, R0, R0;
MAD R0.w, -R0, R1, c[25].z;
ADD R1.xyz, R1, -R3;
MUL R0.w, fragment.texcoord[2].x, R0;
LG2 R0.x, R0.x;
LG2 R0.z, R0.z;
LG2 R0.y, R0.y;
ADD R0.xyz, -R0, fragment.texcoord[5];
MAD R1.xyz, R0.w, R1, R3;
MUL result.color.xyz, R1, R0;
MOV result.color.w, c[24].x;
END
# 156 instructions, 5 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_OFF"
					}
					Float 0[_texTiling]
					Float 1[_texPower]
					Float 2[_groundTexStart]
					Float 3[_groundTexEnd]
					Float 4[_steepTiling]
					Float 5[_steepTexStart]
					Float 6[_steepTexEnd]
					Float 7[_multiPower]
					Float 8[_deepMultiFactor]
					Float 9[_mainMultiFactor]
					Float 10[_highMultiFactor]
					Float 11[_snowMultiFactor]
					Float 12[_deepStart]
					Float 13[_deepEnd]
					Float 14[_mainLoStart]
					Float 15[_mainLoEnd]
					Float 16[_mainHiStart]
					Float 17[_mainHiEnd]
					Float 18[_hiLoStart]
					Float 19[_hiLoEnd]
					Float 20[_hiHiStart]
					Float 21[_hiHiEnd]
					Float 22[_snowStart]
					Float 23[_snowEnd]
					Float 24[_PlanetOpacity]
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 1
					SetTexture 2[_highTex] 2D 2
					SetTexture 3[_snowTex] 2D 3
					SetTexture 4[_deepMultiTex] 2D 4
					SetTexture 5[_mainMultiTex] 2D 5
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[_LightBuffer] 2D 9 "ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
dcl_2d s8
dcl_2d s9
def c25, 2.00000000, 3.00000000, 1.00000000, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4
dcl_texcoord5 v5.xyz
mov r0.x, c3
add r0.w, -c2.x, r0.x
mul r0.xyz, v0, c0.x
rcp r1.x, r0.w
texld r3.xyz, r0.zyzw, s0
add r0.w, v2.z, -c2.x
mul_sat r0.w, r0, r1.x
texld r1.xyz, r0.zyzw, s1
mad r1.w, -r0, c25.x, c25.y
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s1
mad r2.xyz, v1.z, r1, r2
mul r0.w, r0, r0
mul r0.w, r0, r1
add r1.x, -r0.w, c25.z
mov r1.z, c17.x
add r1.z, -c16.x, r1
rcp r1.w, r1.z
add r1.z, v2.y, -c16.x
mul_sat r1.w, r1.z, r1
mov r1.y, c15.x
add r1.y, -c14.x, r1
rcp r1.z, r1.y
add r1.y, v2, -c14.x
mul_sat r1.y, r1, r1.z
mul r0.w, r0, c7.x
mad r2.w, -r1, c25.x, c25.y
mul r1.z, r1.w, r1.w
mul r1.w, r1.z, r2
mul r1.z, r1.y, r1.y
mad r1.y, -r1, c25.x, c25
mad r3.w, r1.z, r1.y, -r1
mul r1.w, r1.x, c1.x
mul r2.w, r1, r3
texld r1.xyz, r0.zxzw, s1
mad r1.xyz, v1.y, r1, r2
mul r2.xyz, r1, r2.w
mov r2.w, c13.x
add r2.w, -c12.x, r2
rcp r4.x, r2.w
add r2.w, v2.y, -c12.x
texld r1.xyz, r0, s0
mul r3.xyz, v1.x, r3
mul_sat r2.w, r2, r4.x
mad r3.xyz, v1.z, r1, r3
mad r1.y, -r2.w, c25.x, c25
mul r1.x, r2.w, r2.w
mad r4.x, -r1, r1.y, c25.z
mul r2.w, r1, r4.x
texld r1.xyz, r0.zxzw, s0
mad r3.xyz, v1.y, r1, r3
mad r3.xyz, r3, r2.w, r2
texld r1.xyz, r0.zyzw, s2
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s2
mad r2.xyz, v1.z, r1, r2
mov r1.y, c21.x
add r1.y, -c20.x, r1
rcp r1.z, r1.y
add r1.y, v2, -c20.x
mul_sat r1.z, r1.y, r1
mov r1.x, c19
add r1.x, -c18, r1
rcp r1.y, r1.x
add r1.x, v2.y, -c18
mul_sat r1.x, r1, r1.y
mad r2.w, -r1.z, c25.x, c25.y
mul r1.y, r1.z, r1.z
mul r1.z, r1.y, r2.w
mul r1.y, r1.x, r1.x
mad r1.x, -r1, c25, c25.y
mad r2.w, r1.y, r1.x, -r1.z
texld r1.xyz, r0.zxzw, s2
mad r1.xyz, v1.y, r1, r2
mul r2.x, r1.w, r2.w
mad r2.xyz, r1, r2.x, r3
texld r1.xyz, r0.zyzw, s3
texld r3.xyz, r0, s3
mul r1.xyz, v1.x, r1
mad r1.xyz, v1.z, r3, r1
mov r0.y, c23.x
add r3.x, -c22, r0.y
rcp r3.y, r3.x
add r3.x, v2.y, -c22
texld r0.xyz, r0.zxzw, s3
mul_sat r4.y, r3.x, r3
mad r3.xyz, v1.y, r0, r1
mad r0.y, -r4, c25.x, c25
mul r0.x, r4.y, r4.y
mul r4.y, r0.x, r0
mul r0.xyz, v0, c8.x
mul r4.z, r1.w, r4.y
mad r3.xyz, r3, r4.z, r2
texld r1.xyz, r0.zyzw, s4
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s4
mad r1.xyz, v1.z, r1, r2
texld r0.xyz, r0.zxzw, s4
mad r1.xyz, v1.y, r0, r1
mul r0.xyz, v0, c9.x
mul r4.x, r0.w, r4
texld r2.xyz, r0.zyzw, s5
mad r1.xyz, r1, r4.x, r3
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s5
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s5
mad r3.xyz, v1.y, r0, r2
mul r0.xyz, v0, c10.x
mul r3.w, r0, r3
texld r2.xyz, r0.zyzw, s6
mad r1.xyz, r3, r3.w, r1
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s6
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s6
mad r3.xyz, v1.y, r0, r2
mul r0.xyz, v0, c11.x
mul r2.w, r0, r2
texld r2.xyz, r0.zyzw, s7
mad r1.xyz, r3, r2.w, r1
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s7
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s7
mad r0.xyz, v1.y, r0, r2
mul r2.x, r0.w, r4.y
mad r0.xyz, r0, r2.x, r1
mad r2.xyz, v3, r0, -v3
mul r0.xyz, v0, c4.x
add r0.w, r1, r0
mad r3.xyz, r0.w, r2, v3
texld r1.xyz, r0.zyzw, s8
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s8
texld r0.xyz, r0.zxzw, s8
mad r1.xyz, v1.z, r1, r2
mad r1.xyz, r0, v1.y, r1
mov r0.w, c6.x
add r0.x, -c5, r0.w
rcp r0.y, r0.x
add r0.x, v2.z, -c5
mul_sat r0.w, r0.x, r0.y
texldp r0.xyz, v4, s9
mad r1.w, -r0, c25.x, c25.y
mul r0.w, r0, r0
mad r0.w, -r0, r1, c25.z
add r1.xyz, r1, -r3
mul r0.w, v2.x, r0
log_pp r0.x, r0.x
log_pp r0.z, r0.z
log_pp r0.y, r0.y
add_pp r0.xyz, -r0, v5
mad r1.xyz, r0.w, r1, r3
mul_pp oC0.xyz, r1, r0
mov_pp oC0.w, c24.x
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_OFF"
					}
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 2
					SetTexture 2[_highTex] 2D 4
					SetTexture 3[_snowTex] 2D 6
					SetTexture 4[_deepMultiTex] 2D 1
					SetTexture 5[_mainMultiTex] 2D 3
					SetTexture 6[_highMultiTex] 2D 5
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[_LightBuffer] 2D 9
					ConstBuffer "$Globals"
					208
					Float 64[_texTiling]
					Float 68[_texPower]
					Float 72[_groundTexStart]
					Float 76[_groundTexEnd]
					Float 84[_steepTiling]
					Float 88[_steepTexStart]
					Float 92[_steepTexEnd]
					Float 104[_multiPower]
					Float 108[_deepMultiFactor]
					Float 112[_mainMultiFactor]
					Float 116[_highMultiFactor]
					Float 120[_snowMultiFactor]
					Float 124[_deepStart]
					Float 128[_deepEnd]
					Float 132[_mainLoStart]
					Float 136[_mainLoEnd]
					Float 140[_mainHiStart]
					Float 144[_mainHiEnd]
					Float 148[_hiLoStart]
					Float 152[_hiLoEnd]
					Float 156[_hiHiStart]
					Float 160[_hiHiEnd]
					Float 164[_snowStart]
					Float 168[_snowEnd]
					Float 172[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedejhadbgcgagfjihepglhdecnibdpoddbabaaaaaaoabfaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckibeaaaaeaaaaaaackafaaaa
fjaaaaaeegiocaaaaaaaaaaaalaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaa
agaaaaaafkaaaaadaagabaaaahaaaaaafkaaaaadaagabaaaaiaaaaaafkaaaaad
aagabaaaajaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaa
afaaaaaaffffaaaafibiaaaeaahabaaaagaaaaaaffffaaaafibiaaaeaahabaaa
ahaaaaaaffffaaaafibiaaaeaahabaaaaiaaaaaaffffaaaafibiaaaeaahabaaa
ajaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadlcbabaaa
afaaaaaagcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
agaaaaaaaaaaaaakbcaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaaahaaaaaa
akiacaaaaaaaaaaaaiaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaa
bkbabaaaadaaaaaadkiacaiaebaaaaaaaaaaaaaaahaaaaaadicaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaak
ccaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaadkiacaaaaaaaaaaa
aeaaaaaaaoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpbkaabaaaaaaaaaaaaaaaaaajecaabaaaaaaaaaaackbabaaaadaaaaaa
ckiacaiaebaaaaaaaaaaaaaaaeaaaaaadicaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaackiacaaaaaaaaaaaagaaaaaadiaaaaaiecaabaaaaaaaaaaadkaabaaa
aaaaaaaabkiacaaaaaaaaaaaaeaaaaaadcaaaaakicaabaaaaaaaaaaabkiacaaa
aaaaaaaaaeaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaa
abaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaakccaabaaaabaaaaaadkiacaia
ebaaaaaaaaaaaaaaaiaaaaaaakiacaaaaaaaaaaaajaaaaaaaoaaaaakccaabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaabaaaaaa
aaaaaaajmcaabaaaabaaaaaafgbfbaaaadaaaaaafgincaiaebaaaaaaaaaaaaaa
aiaaaaaadicaaaahccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaa
dcaaaaajicaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
aaaaeaeadiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaa
diaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaaaaaaaaak
icaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaaaiaaaaaackiacaaaaaaaaaaa
aiaaaaaaaoaaaaakicaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdkaabaaaabaaaaaadicaaaahecaabaaaabaaaaaadkaabaaaabaaaaaa
ckaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaa
ckaabaaaabaaaaaadcaaaaakccaabaaaabaaaaaadkaabaaaabaaaaaackaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaadiaaaaahecaabaaaabaaaaaackaabaaa
aaaaaaaabkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaaaaaaaaa
bkaabaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaaagiacaaa
aaaaaaaaaeaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaa
agbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaaaeaaaaaa
kgbkbaaaacaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaa
acaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaaadaaaaaa
egacbaaaaeaaaaaafgbfbaaaacaaaaaaegacbaaaadaaaaaadiaaaaahhcaabaaa
adaaaaaakgakbaaaabaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaa
ggakbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaa
aeaaaaaaegacbaaaaeaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaafaaaaaa
egaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaa
aeaaaaaaegacbaaaafaaaaaakgbkbaaaacaaaaaaegacbaaaaeaaaaaaefaaaaaj
pcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaajhcaabaaaaeaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaa
aeaaaaaadcaaaaajncaabaaaabaaaaaaagajbaaaaeaaaaaaagaabaaaabaaaaaa
agajbaaaadaaaaaaaaaaaaakicaabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaa
ajaaaaaaakiacaaaaaaaaaaaakaaaaaaaoaaaaakicaabaaaacaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaacaaaaaaaaaaaaajdcaabaaa
adaaaaaafgbfbaaaadaaaaaangifcaiaebaaaaaaaaaaaaaaajaaaaaadicaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaabkaabaaaadaaaaaadcaaaaajccaabaaa
adaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaabkaabaaaadaaaaaaaaaaaaakccaabaaaadaaaaaa
bkiacaiaebaaaaaaaaaaaaaaajaaaaaackiacaaaaaaaaaaaajaaaaaaaoaaaaak
ccaabaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaa
adaaaaaadicaaaahbcaabaaaadaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaa
dcaaaaajccaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaa
aaaaeaeadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaa
dcaaaaakicaabaaaacaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadkaabaia
ebaaaaaaacaaaaaadiaaaaahbcaabaaaadaaaaaackaabaaaaaaaaaaadkaabaaa
acaaaaaadiaaaaahicaabaaaacaaaaaabkaabaaaaaaaaaaadkaabaaaacaaaaaa
efaaaaajpcaabaaaaeaaaaaaggakbaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
aeaaaaaadiaaaaahocaabaaaadaaaaaaagajbaaaaeaaaaaaagbabaaaacaaaaaa
efaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
aeaaaaaadcaaaaajocaabaaaadaaaaaaagajbaaaaeaaaaaakgbkbaaaacaaaaaa
fgaobaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaaacaaaaaaeghobaaa
acaaaaaaaagabaaaaeaaaaaadcaaaaajocaabaaaadaaaaaaagajbaaaaeaaaaaa
fgbfbaaaacaaaaaafgaobaaaadaaaaaadcaaaaajncaabaaaabaaaaaafgaobaaa
adaaaaaaagaabaaaadaaaaaaagaobaaaabaaaaaaaaaaaaakbcaabaaaadaaaaaa
bkiacaiaebaaaaaaaaaaaaaaakaaaaaackiacaaaaaaaaaaaakaaaaaaaoaaaaak
bcaabaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaa
adaaaaaaaaaaaaajccaabaaaadaaaaaabkbabaaaadaaaaaabkiacaiaebaaaaaa
aaaaaaaaakaaaaaadicaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaa
adaaaaaadcaaaaajccaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaa
adaaaaaadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaa
diaaaaahgcaabaaaaaaaaaaafgagbaaaaaaaaaaaagaabaaaadaaaaaaefaaaaaj
pcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaagaaaaaa
diaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaagaaaaaa
efaaaaajpcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaa
agaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaa
egacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaa
acaaaaaaegacbaaaacaaaaaadcaaaaajncaabaaaabaaaaaaagajbaaaacaaaaaa
kgakbaaaaaaaaaaaagaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaa
abaaaaaapgipcaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaa
acaaaaaaeghobaaaaeaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaaadaaaaaa
egacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
acaaaaaaeghobaaaaeaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaafaaaaaa
cgakbaaaacaaaaaaeghobaaaaeaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaa
acaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaa
dcaaaaajncaabaaaabaaaaaaagajbaaaacaaaaaaagaabaaaaaaaaaaaagaobaaa
abaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaa
ahaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaafaaaaaa
aagabaaaadaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaa
acaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaafaaaaaa
aagabaaaadaaaaaaefaaaaajpcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaa
afaaaaaaaagabaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaaeaaaaaa
kgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaa
afaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaa
egacbaaaacaaaaaafgafbaaaabaaaaaaigadbaaaabaaaaaadiaaaaaihcaabaaa
acaaaaaaegbcbaaaabaaaaaafgifcaaaaaaaaaaaahaaaaaaefaaaaajpcaabaaa
adaaaaaaggakbaaaacaaaaaaeghobaaaagaaaaaaaagabaaaafaaaaaadiaaaaah
hcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaacaaaaaaeghobaaaagaaaaaaaagabaaaafaaaaaaefaaaaaj
pcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaagaaaaaaaagabaaaafaaaaaa
dcaaaaajhcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaa
adaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaa
egacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaapgapbaaa
acaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaa
kgikcaaaaaaaaaaaahaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaa
eghobaaaahaaaaaaaagabaaaahaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaa
adaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaa
eghobaaaahaaaaaaaagabaaaahaaaaaaefaaaaajpcaabaaaacaaaaaacgakbaaa
acaaaaaaeghobaaaahaaaaaaaagabaaaahaaaaaadcaaaaajhcaabaaaadaaaaaa
egacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaa
acaaaaaaegacbaaaacaaaaaafgbfbaaaacaaaaaaegacbaaaadaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaacaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaia
ebaaaaaaaeaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaegbcbaaaaeaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaabaaaaaa
fgifcaaaaaaaaaaaafaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaa
eghobaaaaiaaaaaaaagabaaaaiaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaa
eghobaaaaiaaaaaaaagabaaaaiaaaaaaefaaaaajpcaabaaaabaaaaaacgakbaaa
abaaaaaaeghobaaaaiaaaaaaaagabaaaaiaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaadaaaaaakgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaa
abaaaaaaegacbaaaabaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaak
icaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaafaaaaaadkiacaaaaaaaaaaa
afaaaaaaaoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaackbabaaaadaaaaaa
ckiacaiaebaaaaaaaaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaiaebaaaaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakbabaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaa
egbabaaaafaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaajaaaaaaaagabaaaajaaaaaacpaaaaafhcaabaaaabaaaaaa
egacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
egbcbaaaagaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaagiccabaaaaaaaaaaadkiacaaaaaaaaaaaakaaaaaadoaaaaab
"
				}
				SubProgram "opengl " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_OFF"
					}
					Float 0[_texTiling]
					Float 1[_texPower]
					Float 2[_groundTexStart]
					Float 3[_groundTexEnd]
					Float 4[_steepTiling]
					Float 5[_steepTexStart]
					Float 6[_steepTexEnd]
					Float 7[_multiPower]
					Float 8[_deepMultiFactor]
					Float 9[_mainMultiFactor]
					Float 10[_highMultiFactor]
					Float 11[_snowMultiFactor]
					Float 12[_deepStart]
					Float 13[_deepEnd]
					Float 14[_mainLoStart]
					Float 15[_mainLoEnd]
					Float 16[_mainHiStart]
					Float 17[_mainHiEnd]
					Float 18[_hiLoStart]
					Float 19[_hiLoEnd]
					Float 20[_hiHiStart]
					Float 21[_hiHiEnd]
					Float 22[_snowStart]
					Float 23[_snowEnd]
					Float 24[_PlanetOpacity]
					Vector 25[unity_LightmapFade]
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 1
					SetTexture 2[_highTex] 2D 2
					SetTexture 3[_snowTex] 2D 3
					SetTexture 4[_deepMultiTex] 2D 4
					SetTexture 5[_mainMultiTex] 2D 5
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[_LightBuffer] 2D 9
					SetTexture 10[unity_Lightmap] 2D 10
					SetTexture 11[unity_LightmapInd] 2D 11 "3.0-!!ARBfp1.0
PARAM c[27] = { program.local[0..25],
		{ 2, 3, 1, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.x, c[2];
ADD R0.x, -R0, c[3];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].z, -c[2];
MUL_SAT R0.w, R0.x, R0.y;
MUL R3.xyz, fragment.texcoord[0], c[0].x;
MAD R1.x, -R0.w, c[26], c[26].y;
MUL R0.w, R0, R0;
MOV R2.w, c[12].x;
ADD R2.w, -R2, c[13].x;
RCP R4.x, R2.w;
ADD R2.w, fragment.texcoord[2].y, -c[12].x;
MUL_SAT R2.w, R2, R4.x;
TEX R0.xyz, R3.zyzw, texture[1], 2D;
MUL R0.w, R0, R1.x;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[1], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R0, R1;
ADD R0.x, -R0.w, c[26].z;
MOV R0.z, c[16].x;
ADD R0.z, -R0, c[17].x;
RCP R1.w, R0.z;
ADD R0.z, fragment.texcoord[2].y, -c[16].x;
MUL_SAT R1.w, R0.z, R1;
MOV R0.y, c[14].x;
ADD R0.y, -R0, c[15].x;
RCP R0.z, R0.y;
ADD R0.y, fragment.texcoord[2], -c[14].x;
MUL_SAT R0.y, R0, R0.z;
MUL R0.w, R0, c[7].x;
MAD R2.x, -R1.w, c[26], c[26].y;
MUL R0.z, R1.w, R1.w;
MUL R1.w, R0.z, R2.x;
MUL R0.z, R0.y, R0.y;
MAD R0.y, -R0, c[26].x, c[26];
MAD R3.w, R0.z, R0.y, -R1;
MUL R1.w, R0.x, c[1].x;
MUL R2.x, R1.w, R3.w;
TEX R0.xyz, R3.zxzw, texture[1], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R0, R1;
MUL R1.xyz, R0, R2.x;
TEX R2.xyz, R3.zyzw, texture[0], 2D;
TEX R0.xyz, R3, texture[0], 2D;
MUL R2.xyz, fragment.texcoord[1].x, R2;
MAD R2.xyz, fragment.texcoord[1].z, R0, R2;
MAD R0.y, -R2.w, c[26].x, c[26];
MUL R0.x, R2.w, R2.w;
MAD R4.x, -R0, R0.y, c[26].z;
TEX R0.xyz, R3.zxzw, texture[0], 2D;
MUL R2.w, R1, R4.x;
MAD R2.xyz, fragment.texcoord[1].y, R0, R2;
TEX R0.xyz, R3.zyzw, texture[2], 2D;
MAD R2.xyz, R2, R2.w, R1;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[2], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R0, R1;
MOV R0.y, c[20].x;
ADD R0.y, -R0, c[21].x;
RCP R0.z, R0.y;
ADD R0.y, fragment.texcoord[2], -c[20].x;
MUL_SAT R0.z, R0.y, R0;
MOV R0.x, c[18];
ADD R0.x, -R0, c[19];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].y, -c[18];
MUL_SAT R0.x, R0, R0.y;
MAD R2.w, -R0.z, c[26].x, c[26].y;
MUL R0.y, R0.z, R0.z;
MUL R0.z, R0.y, R2.w;
MUL R0.y, R0.x, R0.x;
MAD R0.x, -R0, c[26], c[26].y;
MAD R2.w, R0.y, R0.x, -R0.z;
TEX R0.xyz, R3.zxzw, texture[2], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R0, R1;
MUL R1.x, R1.w, R2.w;
MAD R2.xyz, R0, R1.x, R2;
TEX R1.xyz, R3.zyzw, texture[3], 2D;
TEX R0.xyz, R3, texture[3], 2D;
MUL R1.xyz, fragment.texcoord[1].x, R1;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[3], 2D;
MOV R3.y, c[22].x;
ADD R3.y, -R3, c[23].x;
MAD R1.xyz, fragment.texcoord[1].y, R1, R0;
RCP R3.y, R3.y;
ADD R3.x, fragment.texcoord[2].y, -c[22];
MUL_SAT R3.x, R3, R3.y;
MAD R0.y, -R3.x, c[26].x, c[26];
MUL R0.x, R3, R3;
MUL R4.y, R0.x, R0;
MUL R3.xyz, fragment.texcoord[0], c[8].x;
MUL R4.z, R1.w, R4.y;
TEX R0.xyz, R3.zyzw, texture[4], 2D;
MAD R2.xyz, R1, R4.z, R2;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[4], 2D;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[4], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R1, R0;
MUL R1.xyz, fragment.texcoord[0], c[9].x;
MUL R4.x, R0.w, R4;
MAD R0.xyz, R0, R4.x, R2;
TEX R3.xyz, R1.zyzw, texture[5], 2D;
TEX R2.xyz, R1, texture[5], 2D;
MUL R3.xyz, fragment.texcoord[1].x, R3;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[5], 2D;
MAD R3.xyz, fragment.texcoord[1].y, R1, R2;
MUL R1.xyz, fragment.texcoord[0], c[10].x;
MUL R3.w, R0, R3;
TEX R2.xyz, R1.zyzw, texture[6], 2D;
MAD R0.xyz, R3, R3.w, R0;
MUL R3.xyz, fragment.texcoord[1].x, R2;
TEX R2.xyz, R1, texture[6], 2D;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[6], 2D;
MAD R3.xyz, fragment.texcoord[1].y, R1, R2;
MUL R1.xyz, fragment.texcoord[0], c[11].x;
MUL R2.w, R0, R2;
TEX R2.xyz, R1.zyzw, texture[7], 2D;
MAD R0.xyz, R3, R2.w, R0;
MUL R3.xyz, fragment.texcoord[1].x, R2;
TEX R2.xyz, R1, texture[7], 2D;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[7], 2D;
MAD R1.xyz, fragment.texcoord[1].y, R1, R2;
MUL R2.x, R0.w, R4.y;
MAD R0.xyz, R1, R2.x, R0;
MAD R2.xyz, fragment.texcoord[3], R0, -fragment.texcoord[3];
MUL R0.xyz, fragment.texcoord[0], c[4].x;
ADD R0.w, R1, R0;
TEX R1.xyz, R0.zyzw, texture[8], 2D;
MUL R3.xyz, fragment.texcoord[1].x, R1;
TEX R1.xyz, R0, texture[8], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R1, R3;
TEX R0.xyz, R0.zxzw, texture[8], 2D;
MAD R0.xyz, R0, fragment.texcoord[1].y, R1;
MAD R2.xyz, R0.w, R2, fragment.texcoord[3];
ADD R3.xyz, R0, -R2;
TEX R1, fragment.texcoord[5], texture[11], 2D;
TEX R0, fragment.texcoord[5], texture[10], 2D;
MUL R1.xyz, R1.w, R1;
MUL R0.xyz, R0.w, R0;
MUL R1.xyz, R1, c[26].w;
DP4 R0.w, fragment.texcoord[6], fragment.texcoord[6];
RSQ R1.w, R0.w;
MOV R0.w, c[5].x;
RCP R1.w, R1.w;
MAD R0.xyz, R0, c[26].w, -R1;
MAD_SAT R1.w, R1, c[25].z, c[25];
MAD R1.xyz, R1.w, R0, R1;
ADD R0.w, -R0, c[6].x;
RCP R0.y, R0.w;
ADD R0.x, fragment.texcoord[2].z, -c[5];
MUL_SAT R0.w, R0.x, R0.y;
TXP R0.xyz, fragment.texcoord[4], texture[9], 2D;
MAD R1.w, -R0, c[26].x, c[26].y;
MUL R0.w, R0, R0;
MAD R0.w, -R0, R1, c[26].z;
LG2 R0.x, R0.x;
LG2 R0.y, R0.y;
LG2 R0.z, R0.z;
ADD R0.xyz, -R0, R1;
MUL R0.w, fragment.texcoord[2].x, R0;
MAD R1.xyz, R0.w, R3, R2;
MUL result.color.xyz, R1, R0;
MOV result.color.w, c[24].x;
END
# 167 instructions, 5 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_OFF"
					}
					Float 0[_texTiling]
					Float 1[_texPower]
					Float 2[_groundTexStart]
					Float 3[_groundTexEnd]
					Float 4[_steepTiling]
					Float 5[_steepTexStart]
					Float 6[_steepTexEnd]
					Float 7[_multiPower]
					Float 8[_deepMultiFactor]
					Float 9[_mainMultiFactor]
					Float 10[_highMultiFactor]
					Float 11[_snowMultiFactor]
					Float 12[_deepStart]
					Float 13[_deepEnd]
					Float 14[_mainLoStart]
					Float 15[_mainLoEnd]
					Float 16[_mainHiStart]
					Float 17[_mainHiEnd]
					Float 18[_hiLoStart]
					Float 19[_hiLoEnd]
					Float 20[_hiHiStart]
					Float 21[_hiHiEnd]
					Float 22[_snowStart]
					Float 23[_snowEnd]
					Float 24[_PlanetOpacity]
					Vector 25[unity_LightmapFade]
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 1
					SetTexture 2[_highTex] 2D 2
					SetTexture 3[_snowTex] 2D 3
					SetTexture 4[_deepMultiTex] 2D 4
					SetTexture 5[_mainMultiTex] 2D 5
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[_LightBuffer] 2D 9
					SetTexture 10[unity_Lightmap] 2D 10
					SetTexture 11[unity_LightmapInd] 2D 11 "ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
dcl_2d s8
dcl_2d s9
dcl_2d s10
dcl_2d s11
def c26, 2.00000000, 3.00000000, 1.00000000, 8.00000000
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4
dcl_texcoord5 v5.xy
dcl_texcoord6 v6
mov r0.x, c3
add r0.w, -c2.x, r0.x
mul r0.xyz, v0, c0.x
rcp r1.x, r0.w
texld r3.xyz, r0.zyzw, s0
add r0.w, v2.z, -c2.x
mul_sat r0.w, r0, r1.x
texld r1.xyz, r0.zyzw, s1
mad r1.w, -r0, c26.x, c26.y
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s1
mad r2.xyz, v1.z, r1, r2
mul r0.w, r0, r0
mul r0.w, r0, r1
add r1.x, -r0.w, c26.z
mov r1.z, c17.x
add r1.z, -c16.x, r1
rcp r1.w, r1.z
add r1.z, v2.y, -c16.x
mul_sat r1.w, r1.z, r1
mov r1.y, c15.x
add r1.y, -c14.x, r1
rcp r1.z, r1.y
add r1.y, v2, -c14.x
mul_sat r1.y, r1, r1.z
mul r0.w, r0, c7.x
mad r2.w, -r1, c26.x, c26.y
mul r1.z, r1.w, r1.w
mul r1.w, r1.z, r2
mul r1.z, r1.y, r1.y
mad r1.y, -r1, c26.x, c26
mad r3.w, r1.z, r1.y, -r1
mul r1.w, r1.x, c1.x
mul r2.w, r1, r3
texld r1.xyz, r0.zxzw, s1
mad r1.xyz, v1.y, r1, r2
mul r2.xyz, r1, r2.w
mov r2.w, c13.x
add r2.w, -c12.x, r2
rcp r4.x, r2.w
add r2.w, v2.y, -c12.x
texld r1.xyz, r0, s0
mul r3.xyz, v1.x, r3
mul_sat r2.w, r2, r4.x
mad r3.xyz, v1.z, r1, r3
mad r1.y, -r2.w, c26.x, c26
mul r1.x, r2.w, r2.w
mad r4.x, -r1, r1.y, c26.z
mul r2.w, r1, r4.x
texld r1.xyz, r0.zxzw, s0
mad r3.xyz, v1.y, r1, r3
mad r3.xyz, r3, r2.w, r2
texld r1.xyz, r0.zyzw, s2
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s2
mad r2.xyz, v1.z, r1, r2
mov r1.y, c21.x
add r1.y, -c20.x, r1
rcp r1.z, r1.y
add r1.y, v2, -c20.x
mul_sat r1.z, r1.y, r1
mov r1.x, c19
add r1.x, -c18, r1
rcp r1.y, r1.x
add r1.x, v2.y, -c18
mul_sat r1.x, r1, r1.y
mad r2.w, -r1.z, c26.x, c26.y
mul r1.y, r1.z, r1.z
mul r1.z, r1.y, r2.w
mul r1.y, r1.x, r1.x
mad r1.x, -r1, c26, c26.y
mad r2.w, r1.y, r1.x, -r1.z
texld r1.xyz, r0.zxzw, s2
mad r1.xyz, v1.y, r1, r2
mul r2.x, r1.w, r2.w
mad r2.xyz, r1, r2.x, r3
texld r1.xyz, r0.zyzw, s3
texld r3.xyz, r0, s3
mul r1.xyz, v1.x, r1
mad r1.xyz, v1.z, r3, r1
mov r0.y, c23.x
add r3.x, -c22, r0.y
rcp r3.y, r3.x
add r3.x, v2.y, -c22
texld r0.xyz, r0.zxzw, s3
mul_sat r4.y, r3.x, r3
mad r3.xyz, v1.y, r0, r1
mad r0.y, -r4, c26.x, c26
mul r0.x, r4.y, r4.y
mul r4.y, r0.x, r0
mul r0.xyz, v0, c8.x
mul r4.z, r1.w, r4.y
mad r3.xyz, r3, r4.z, r2
texld r1.xyz, r0.zyzw, s4
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s4
mad r1.xyz, v1.z, r1, r2
texld r0.xyz, r0.zxzw, s4
mad r1.xyz, v1.y, r0, r1
mul r0.xyz, v0, c9.x
mul r4.x, r0.w, r4
texld r2.xyz, r0.zyzw, s5
mad r1.xyz, r1, r4.x, r3
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s5
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s5
mad r3.xyz, v1.y, r0, r2
mul r0.xyz, v0, c10.x
mul r3.w, r0, r3
texld r2.xyz, r0.zyzw, s6
mad r1.xyz, r3, r3.w, r1
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s6
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s6
mad r3.xyz, v1.y, r0, r2
mul r0.xyz, v0, c11.x
mul r2.w, r0, r2
texld r2.xyz, r0.zyzw, s7
mad r1.xyz, r3, r2.w, r1
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s7
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s7
mad r0.xyz, v1.y, r0, r2
mul r2.x, r0.w, r4.y
mad r0.xyz, r0, r2.x, r1
mad r2.xyz, v3, r0, -v3
mul r0.xyz, v0, c4.x
add r0.w, r1, r0
texld r1.xyz, r0.zyzw, s8
mul r3.xyz, v1.x, r1
texld r1.xyz, r0, s8
mad r1.xyz, v1.z, r1, r3
texld r0.xyz, r0.zxzw, s8
mad r0.xyz, r0, v1.y, r1
mad r2.xyz, r0.w, r2, v3
add r3.xyz, r0, -r2
texld r1, v5, s11
texld r0, v5, s10
mul_pp r1.xyz, r1.w, r1
mul_pp r0.xyz, r0.w, r0
mul_pp r1.xyz, r1, c26.w
dp4 r0.w, v6, v6
rsq r1.w, r0.w
mov r0.w, c6.x
rcp r1.w, r1.w
mad_pp r0.xyz, r0, c26.w, -r1
mad_sat r1.w, r1, c25.z, c25
mad_pp r1.xyz, r1.w, r0, r1
add r0.w, -c5.x, r0
rcp r0.y, r0.w
add r0.x, v2.z, -c5
mul_sat r0.w, r0.x, r0.y
texldp r0.xyz, v4, s9
mad r1.w, -r0, c26.x, c26.y
mul r0.w, r0, r0
mad r0.w, -r0, r1, c26.z
log_pp r0.x, r0.x
log_pp r0.y, r0.y
log_pp r0.z, r0.z
add_pp r0.xyz, -r0, r1
mul r0.w, v2.x, r0
mad r1.xyz, r0.w, r3, r2
mul_pp oC0.xyz, r1, r0
mov_pp oC0.w, c24.x
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_OFF"
					}
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 2
					SetTexture 2[_highTex] 2D 4
					SetTexture 3[_snowTex] 2D 6
					SetTexture 4[_deepMultiTex] 2D 1
					SetTexture 5[_mainMultiTex] 2D 3
					SetTexture 6[_highMultiTex] 2D 5
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[_LightBuffer] 2D 9
					SetTexture 10[unity_Lightmap] 2D 10
					SetTexture 11[unity_LightmapInd] 2D 11
					ConstBuffer "$Globals"
					240
					Float 64[_texTiling]
					Float 68[_texPower]
					Float 72[_groundTexStart]
					Float 76[_groundTexEnd]
					Float 84[_steepTiling]
					Float 88[_steepTexStart]
					Float 92[_steepTexEnd]
					Float 104[_multiPower]
					Float 108[_deepMultiFactor]
					Float 112[_mainMultiFactor]
					Float 116[_highMultiFactor]
					Float 120[_snowMultiFactor]
					Float 124[_deepStart]
					Float 128[_deepEnd]
					Float 132[_mainLoStart]
					Float 136[_mainLoEnd]
					Float 140[_mainHiStart]
					Float 144[_mainHiEnd]
					Float 148[_hiLoStart]
					Float 152[_hiLoEnd]
					Float 156[_hiHiStart]
					Float 160[_hiHiEnd]
					Float 164[_snowStart]
					Float 168[_snowEnd]
					Float 172[_PlanetOpacity]
					Vector 208[unity_LightmapFade]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedkfefeffljboejfnnaikoelfclhlijjacabaaaaaaiabhaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
adadaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcdabgaaaaeaaaaaaaimafaaaafjaaaaaeegiocaaa
aaaaaaaaaoaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaaagaaaaaafkaaaaad
aagabaaaahaaaaaafkaaaaadaagabaaaaiaaaaaafkaaaaadaagabaaaajaaaaaa
fkaaaaadaagabaaaakaaaaaafkaaaaadaagabaaaalaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaa
aeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaafibiaaaeaahabaaa
agaaaaaaffffaaaafibiaaaeaahabaaaahaaaaaaffffaaaafibiaaaeaahabaaa
aiaaaaaaffffaaaafibiaaaeaahabaaaajaaaaaaffffaaaafibiaaaeaahabaaa
akaaaaaaffffaaaafibiaaaeaahabaaaalaaaaaaffffaaaagcbaaaadhcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaad
hcbabaaaaeaaaaaagcbaaaadlcbabaaaafaaaaaagcbaaaaddcbabaaaagaaaaaa
gcbaaaadpcbabaaaahaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaa
aaaaaaakbcaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaaahaaaaaaakiacaaa
aaaaaaaaaiaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaabkbabaaa
adaaaaaadkiacaiaebaaaaaaaaaaaaaaahaaaaaadicaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaakccaabaaa
aaaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaadkiacaaaaaaaaaaaaeaaaaaa
aoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
bkaabaaaaaaaaaaaaaaaaaajecaabaaaaaaaaaaackbabaaaadaaaaaackiacaia
ebaaaaaaaaaaaaaaaeaaaaaadicaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckiacaaaaaaaaaaaagaaaaaadiaaaaaiecaabaaaaaaaaaaadkaabaaaaaaaaaaa
bkiacaaaaaaaaaaaaeaaaaaadcaaaaakicaabaaaaaaaaaaabkiacaaaaaaaaaaa
aeaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaa
ckaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaaaaaaaaakccaabaaaabaaaaaadkiacaiaebaaaaaa
aaaaaaaaaiaaaaaaakiacaaaaaaaaaaaajaaaaaaaoaaaaakccaabaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaabaaaaaaaaaaaaaj
mcaabaaaabaaaaaafgbfbaaaadaaaaaafgincaiaebaaaaaaaaaaaaaaaiaaaaaa
dicaaaahccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaaj
icaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaea
diaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaaaaaaaaakicaabaaa
abaaaaaabkiacaiaebaaaaaaaaaaaaaaaiaaaaaackiacaaaaaaaaaaaaiaaaaaa
aoaaaaakicaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
dkaabaaaabaaaaaadicaaaahecaabaaaabaaaaaadkaabaaaabaaaaaackaabaaa
abaaaaaadcaaaaajicaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaackaabaaa
abaaaaaadcaaaaakccaabaaaabaaaaaadkaabaaaabaaaaaackaabaaaabaaaaaa
bkaabaiaebaaaaaaabaaaaaadiaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaa
bkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaa
abaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaa
aeaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaa
acaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaaaeaaaaaakgbkbaaa
acaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaa
aeaaaaaafgbfbaaaacaaaaaaegacbaaaadaaaaaadiaaaaahhcaabaaaadaaaaaa
kgakbaaaabaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaaggakbaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaaeaaaaaa
egacbaaaaeaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaaeaaaaaa
egacbaaaafaaaaaakgbkbaaaacaaaaaaegacbaaaaeaaaaaaefaaaaajpcaabaaa
afaaaaaacgakbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaj
hcaabaaaaeaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaaaeaaaaaa
dcaaaaajncaabaaaabaaaaaaagajbaaaaeaaaaaaagaabaaaabaaaaaaagajbaaa
adaaaaaaaaaaaaakicaabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaaajaaaaaa
akiacaaaaaaaaaaaakaaaaaaaoaaaaakicaabaaaacaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpdkaabaaaacaaaaaaaaaaaaajdcaabaaaadaaaaaa
fgbfbaaaadaaaaaangifcaiaebaaaaaaaaaaaaaaajaaaaaadicaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaabkaabaaaadaaaaaadcaaaaajccaabaaaadaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaabkaabaaaadaaaaaaaaaaaaakccaabaaaadaaaaaabkiacaia
ebaaaaaaaaaaaaaaajaaaaaackiacaaaaaaaaaaaajaaaaaaaoaaaaakccaabaaa
adaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaadaaaaaa
dicaaaahbcaabaaaadaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaaj
ccaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaea
diaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaak
icaabaaaacaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadkaabaiaebaaaaaa
acaaaaaadiaaaaahbcaabaaaadaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaa
diaaaaahicaabaaaacaaaaaabkaabaaaaaaaaaaadkaabaaaacaaaaaaefaaaaaj
pcaabaaaaeaaaaaaggakbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaaeaaaaaa
diaaaaahocaabaaaadaaaaaaagajbaaaaeaaaaaaagbabaaaacaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaaeaaaaaa
dcaaaaajocaabaaaadaaaaaaagajbaaaaeaaaaaakgbkbaaaacaaaaaafgaobaaa
adaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaaeaaaaaadcaaaaajocaabaaaadaaaaaaagajbaaaaeaaaaaafgbfbaaa
acaaaaaafgaobaaaadaaaaaadcaaaaajncaabaaaabaaaaaafgaobaaaadaaaaaa
agaabaaaadaaaaaaagaobaaaabaaaaaaaaaaaaakbcaabaaaadaaaaaabkiacaia
ebaaaaaaaaaaaaaaakaaaaaackiacaaaaaaaaaaaakaaaaaaaoaaaaakbcaabaaa
adaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaadaaaaaa
aaaaaaajccaabaaaadaaaaaabkbabaaaadaaaaaabkiacaiaebaaaaaaaaaaaaaa
akaaaaaadicaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaa
dcaaaaajccaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaa
aaaaeaeadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaa
diaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaadiaaaaah
gcaabaaaaaaaaaaafgagbaaaaaaaaaaaagaabaaaadaaaaaaefaaaaajpcaabaaa
adaaaaaaggakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaagaaaaaadiaaaaah
hcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaagaaaaaaefaaaaaj
pcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaagaaaaaa
dcaaaaajhcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaa
adaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaa
egacbaaaacaaaaaadcaaaaajncaabaaaabaaaaaaagajbaaaacaaaaaakgakbaaa
aaaaaaaaagaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaa
pgipcaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaa
eghobaaaaeaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaa
adaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaa
eghobaaaaeaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaafaaaaaacgakbaaa
acaaaaaaeghobaaaaeaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaa
acaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaadcaaaaaj
ncaabaaaabaaaaaaagajbaaaacaaaaaaagaabaaaaaaaaaaaagaobaaaabaaaaaa
diaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaahaaaaaa
efaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaafaaaaaaaagabaaa
adaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaa
efaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaafaaaaaaaagabaaa
adaaaaaaefaaaaajpcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaafaaaaaa
aagabaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaa
acaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaa
fgbfbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
acaaaaaafgafbaaaabaaaaaaigadbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaa
egbcbaaaabaaaaaafgifcaaaaaaaaaaaahaaaaaaefaaaaajpcaabaaaadaaaaaa
ggakbaaaacaaaaaaeghobaaaagaaaaaaaagabaaaafaaaaaadiaaaaahhcaabaaa
adaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaa
egaabaaaacaaaaaaeghobaaaagaaaaaaaagabaaaafaaaaaaefaaaaajpcaabaaa
afaaaaaacgakbaaaacaaaaaaeghobaaaagaaaaaaaagabaaaafaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaa
dcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaa
acaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaapgapbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaakgikcaaa
aaaaaaaaahaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaa
ahaaaaaaaagabaaaahaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaa
agbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaa
ahaaaaaaaagabaaaahaaaaaaefaaaaajpcaabaaaacaaaaaacgakbaaaacaaaaaa
eghobaaaahaaaaaaaagabaaaahaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaa
aeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaacaaaaaafgbfbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaacaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaiaebaaaaaa
aeaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
egbcbaaaaeaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaabaaaaaafgifcaaa
aaaaaaaaafaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaaeghobaaa
aiaaaaaaaagabaaaaiaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
agbabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaa
aiaaaaaaaagabaaaaiaaaaaaefaaaaajpcaabaaaabaaaaaacgakbaaaabaaaaaa
eghobaaaaiaaaaaaaagabaaaaiaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaa
adaaaaaakgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaa
egacbaaaabaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaakicaabaaa
aaaaaaaackiacaiaebaaaaaaaaaaaaaaafaaaaaadkiacaaaaaaaaaaaafaaaaaa
aoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
dkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaackbabaaaadaaaaaackiacaia
ebaaaaaaaaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakbabaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaabbaaaaahicaabaaaaaaaaaaaegbobaaa
ahaaaaaaegbobaaaahaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
dccaaaalicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaaanaaaaaa
dkiacaaaaaaaaaaaanaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaagaaaaaa
eghobaaaalaaaaaaaagabaaaalaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaagaaaaaaeghobaaa
akaaaaaaaagabaaaakaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaacaaaaaa
abeaaaaaaaaaaaebdcaaaaakhcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaa
acaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaaoaaaaahdcaabaaaacaaaaaa
egbabaaaafaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaa
acaaaaaaeghobaaaajaaaaaaaagabaaaajaaaaaacpaaaaafhcaabaaaacaaaaaa
egacbaaaacaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaia
ebaaaaaaacaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaagiccabaaaaaaaaaaadkiacaaaaaaaaaaaakaaaaaadoaaaaab
"
				}
				SubProgram "opengl " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
						"HDR_LIGHT_PREPASS_OFF"
					}
					Float 0[_texTiling]
					Float 1[_texPower]
					Float 2[_groundTexStart]
					Float 3[_groundTexEnd]
					Float 4[_steepTiling]
					Float 5[_steepTexStart]
					Float 6[_steepTexEnd]
					Float 7[_multiPower]
					Float 8[_deepMultiFactor]
					Float 9[_mainMultiFactor]
					Float 10[_highMultiFactor]
					Float 11[_snowMultiFactor]
					Float 12[_deepStart]
					Float 13[_deepEnd]
					Float 14[_mainLoStart]
					Float 15[_mainLoEnd]
					Float 16[_mainHiStart]
					Float 17[_mainHiEnd]
					Float 18[_hiLoStart]
					Float 19[_hiLoEnd]
					Float 20[_hiHiStart]
					Float 21[_hiHiEnd]
					Float 22[_snowStart]
					Float 23[_snowEnd]
					Float 24[_PlanetOpacity]
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 1
					SetTexture 2[_highTex] 2D 2
					SetTexture 3[_snowTex] 2D 3
					SetTexture 4[_deepMultiTex] 2D 4
					SetTexture 5[_mainMultiTex] 2D 5
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[_LightBuffer] 2D 9
					SetTexture 10[unity_Lightmap] 2D 10
					SetTexture 11[unity_LightmapInd] 2D 11 "3.0-!!ARBfp1.0
PARAM c[27] = { program.local[0..24],
		{ 2, 3, 1, 0.57735026 },
		{ 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.x, c[2];
ADD R0.x, -R0, c[3];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].z, -c[2];
MUL_SAT R0.w, R0.x, R0.y;
MUL R3.xyz, fragment.texcoord[0], c[0].x;
MAD R1.x, -R0.w, c[25], c[25].y;
MUL R0.w, R0, R0;
MOV R2.w, c[12].x;
ADD R2.w, -R2, c[13].x;
RCP R4.x, R2.w;
ADD R2.w, fragment.texcoord[2].y, -c[12].x;
MUL_SAT R2.w, R2, R4.x;
TEX R0.xyz, R3.zyzw, texture[1], 2D;
MUL R0.w, R0, R1.x;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[1], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R0, R1;
ADD R0.x, -R0.w, c[25].z;
MOV R0.z, c[16].x;
ADD R0.z, -R0, c[17].x;
RCP R1.w, R0.z;
ADD R0.z, fragment.texcoord[2].y, -c[16].x;
MUL_SAT R1.w, R0.z, R1;
MOV R0.y, c[14].x;
ADD R0.y, -R0, c[15].x;
RCP R0.z, R0.y;
ADD R0.y, fragment.texcoord[2], -c[14].x;
MUL_SAT R0.y, R0, R0.z;
MUL R0.w, R0, c[7].x;
MAD R2.x, -R1.w, c[25], c[25].y;
MUL R0.z, R1.w, R1.w;
MUL R1.w, R0.z, R2.x;
MUL R0.z, R0.y, R0.y;
MAD R0.y, -R0, c[25].x, c[25];
MAD R3.w, R0.z, R0.y, -R1;
MUL R1.w, R0.x, c[1].x;
MUL R2.x, R1.w, R3.w;
TEX R0.xyz, R3.zxzw, texture[1], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R0, R1;
MUL R1.xyz, R0, R2.x;
TEX R2.xyz, R3.zyzw, texture[0], 2D;
TEX R0.xyz, R3, texture[0], 2D;
MUL R2.xyz, fragment.texcoord[1].x, R2;
MAD R2.xyz, fragment.texcoord[1].z, R0, R2;
MAD R0.y, -R2.w, c[25].x, c[25];
MUL R0.x, R2.w, R2.w;
MAD R4.x, -R0, R0.y, c[25].z;
TEX R0.xyz, R3.zxzw, texture[0], 2D;
MUL R2.w, R1, R4.x;
MAD R2.xyz, fragment.texcoord[1].y, R0, R2;
TEX R0.xyz, R3.zyzw, texture[2], 2D;
MAD R2.xyz, R2, R2.w, R1;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[2], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R0, R1;
MOV R0.y, c[20].x;
ADD R0.y, -R0, c[21].x;
RCP R0.z, R0.y;
ADD R0.y, fragment.texcoord[2], -c[20].x;
MUL_SAT R0.z, R0.y, R0;
MOV R0.x, c[18];
ADD R0.x, -R0, c[19];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].y, -c[18];
MUL_SAT R0.x, R0, R0.y;
MAD R2.w, -R0.z, c[25].x, c[25].y;
MUL R0.y, R0.z, R0.z;
MUL R0.z, R0.y, R2.w;
MUL R0.y, R0.x, R0.x;
MAD R0.x, -R0, c[25], c[25].y;
MAD R2.w, R0.y, R0.x, -R0.z;
TEX R0.xyz, R3.zxzw, texture[2], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R0, R1;
MUL R1.x, R1.w, R2.w;
MAD R2.xyz, R0, R1.x, R2;
TEX R1.xyz, R3.zyzw, texture[3], 2D;
TEX R0.xyz, R3, texture[3], 2D;
MUL R1.xyz, fragment.texcoord[1].x, R1;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[3], 2D;
MOV R3.y, c[22].x;
ADD R3.y, -R3, c[23].x;
MAD R1.xyz, fragment.texcoord[1].y, R1, R0;
RCP R3.y, R3.y;
ADD R3.x, fragment.texcoord[2].y, -c[22];
MUL_SAT R3.x, R3, R3.y;
MAD R0.y, -R3.x, c[25].x, c[25];
MUL R0.x, R3, R3;
MUL R4.y, R0.x, R0;
MUL R3.xyz, fragment.texcoord[0], c[8].x;
MUL R4.z, R1.w, R4.y;
TEX R0.xyz, R3.zyzw, texture[4], 2D;
MAD R2.xyz, R1, R4.z, R2;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[4], 2D;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[4], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R1, R0;
MUL R1.xyz, fragment.texcoord[0], c[9].x;
MUL R4.x, R0.w, R4;
MAD R0.xyz, R0, R4.x, R2;
TEX R3.xyz, R1.zyzw, texture[5], 2D;
TEX R2.xyz, R1, texture[5], 2D;
MUL R3.xyz, fragment.texcoord[1].x, R3;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[5], 2D;
MAD R3.xyz, fragment.texcoord[1].y, R1, R2;
MUL R1.xyz, fragment.texcoord[0], c[10].x;
MUL R3.w, R0, R3;
TEX R2.xyz, R1.zyzw, texture[6], 2D;
MAD R0.xyz, R3, R3.w, R0;
MUL R3.xyz, fragment.texcoord[1].x, R2;
TEX R2.xyz, R1, texture[6], 2D;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[6], 2D;
MAD R3.xyz, fragment.texcoord[1].y, R1, R2;
MUL R1.xyz, fragment.texcoord[0], c[11].x;
MUL R2.w, R0, R2;
TEX R2.xyz, R1.zyzw, texture[7], 2D;
MAD R0.xyz, R3, R2.w, R0;
MUL R3.xyz, fragment.texcoord[1].x, R2;
TEX R2.xyz, R1, texture[7], 2D;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[7], 2D;
MAD R1.xyz, fragment.texcoord[1].y, R1, R2;
MUL R2.x, R0.w, R4.y;
MAD R0.xyz, R1, R2.x, R0;
MAD R2.xyz, fragment.texcoord[3], R0, -fragment.texcoord[3];
MUL R0.xyz, fragment.texcoord[0], c[4].x;
ADD R0.w, R1, R0;
TEX R1.xyz, R0.zyzw, texture[8], 2D;
MUL R3.xyz, fragment.texcoord[1].x, R1;
TEX R1.xyz, R0, texture[8], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R1, R3;
TEX R0.xyz, R0.zxzw, texture[8], 2D;
MAD R0.xyz, R0, fragment.texcoord[1].y, R1;
MAD R2.xyz, R0.w, R2, fragment.texcoord[3];
ADD R3.xyz, R0, -R2;
TEX R1, fragment.texcoord[5], texture[11], 2D;
TEX R0, fragment.texcoord[5], texture[10], 2D;
MUL R0.xyz, R0.w, R0;
MUL R1.xyz, R1.w, R1;
MUL R1.xyz, R1, c[25].w;
MOV R0.w, c[5].x;
DP3 R1.x, R1, c[26].x;
MUL R1.xyz, R0, R1.x;
ADD R0.w, -R0, c[6].x;
RCP R0.y, R0.w;
ADD R0.x, fragment.texcoord[2].z, -c[5];
MUL_SAT R0.w, R0.x, R0.y;
TXP R0.xyz, fragment.texcoord[4], texture[9], 2D;
MAD R1.w, -R0, c[25].x, c[25].y;
MUL R0.w, R0, R0;
MAD R0.w, -R0, R1, c[25].z;
LG2 R0.x, R0.x;
LG2 R0.z, R0.z;
LG2 R0.y, R0.y;
MAD R0.xyz, R1, c[26].x, -R0;
MUL R0.w, fragment.texcoord[2].x, R0;
MAD R1.xyz, R0.w, R3, R2;
MUL result.color.xyz, R1, R0;
MOV result.color.w, c[24].x;
END
# 163 instructions, 5 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
						"HDR_LIGHT_PREPASS_OFF"
					}
					Float 0[_texTiling]
					Float 1[_texPower]
					Float 2[_groundTexStart]
					Float 3[_groundTexEnd]
					Float 4[_steepTiling]
					Float 5[_steepTexStart]
					Float 6[_steepTexEnd]
					Float 7[_multiPower]
					Float 8[_deepMultiFactor]
					Float 9[_mainMultiFactor]
					Float 10[_highMultiFactor]
					Float 11[_snowMultiFactor]
					Float 12[_deepStart]
					Float 13[_deepEnd]
					Float 14[_mainLoStart]
					Float 15[_mainLoEnd]
					Float 16[_mainHiStart]
					Float 17[_mainHiEnd]
					Float 18[_hiLoStart]
					Float 19[_hiLoEnd]
					Float 20[_hiHiStart]
					Float 21[_hiHiEnd]
					Float 22[_snowStart]
					Float 23[_snowEnd]
					Float 24[_PlanetOpacity]
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 1
					SetTexture 2[_highTex] 2D 2
					SetTexture 3[_snowTex] 2D 3
					SetTexture 4[_deepMultiTex] 2D 4
					SetTexture 5[_mainMultiTex] 2D 5
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[_LightBuffer] 2D 9
					SetTexture 10[unity_Lightmap] 2D 10
					SetTexture 11[unity_LightmapInd] 2D 11 "ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
dcl_2d s8
dcl_2d s9
dcl_2d s10
dcl_2d s11
def c25, 2.00000000, 3.00000000, 1.00000000, 0.57735026
def c26, 8.00000000, 0, 0, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4
dcl_texcoord5 v5.xy
mov r0.x, c3
add r0.w, -c2.x, r0.x
mul r0.xyz, v0, c0.x
rcp r1.x, r0.w
texld r3.xyz, r0.zyzw, s0
add r0.w, v2.z, -c2.x
mul_sat r0.w, r0, r1.x
texld r1.xyz, r0.zyzw, s1
mad r1.w, -r0, c25.x, c25.y
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s1
mad r2.xyz, v1.z, r1, r2
mul r0.w, r0, r0
mul r0.w, r0, r1
add r1.x, -r0.w, c25.z
mov r1.z, c17.x
add r1.z, -c16.x, r1
rcp r1.w, r1.z
add r1.z, v2.y, -c16.x
mul_sat r1.w, r1.z, r1
mov r1.y, c15.x
add r1.y, -c14.x, r1
rcp r1.z, r1.y
add r1.y, v2, -c14.x
mul_sat r1.y, r1, r1.z
mul r0.w, r0, c7.x
mad r2.w, -r1, c25.x, c25.y
mul r1.z, r1.w, r1.w
mul r1.w, r1.z, r2
mul r1.z, r1.y, r1.y
mad r1.y, -r1, c25.x, c25
mad r3.w, r1.z, r1.y, -r1
mul r1.w, r1.x, c1.x
mul r2.w, r1, r3
texld r1.xyz, r0.zxzw, s1
mad r1.xyz, v1.y, r1, r2
mul r2.xyz, r1, r2.w
mov r2.w, c13.x
add r2.w, -c12.x, r2
rcp r4.x, r2.w
add r2.w, v2.y, -c12.x
texld r1.xyz, r0, s0
mul r3.xyz, v1.x, r3
mul_sat r2.w, r2, r4.x
mad r3.xyz, v1.z, r1, r3
mad r1.y, -r2.w, c25.x, c25
mul r1.x, r2.w, r2.w
mad r4.x, -r1, r1.y, c25.z
mul r2.w, r1, r4.x
texld r1.xyz, r0.zxzw, s0
mad r3.xyz, v1.y, r1, r3
mad r3.xyz, r3, r2.w, r2
texld r1.xyz, r0.zyzw, s2
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s2
mad r2.xyz, v1.z, r1, r2
mov r1.y, c21.x
add r1.y, -c20.x, r1
rcp r1.z, r1.y
add r1.y, v2, -c20.x
mul_sat r1.z, r1.y, r1
mov r1.x, c19
add r1.x, -c18, r1
rcp r1.y, r1.x
add r1.x, v2.y, -c18
mul_sat r1.x, r1, r1.y
mad r2.w, -r1.z, c25.x, c25.y
mul r1.y, r1.z, r1.z
mul r1.z, r1.y, r2.w
mul r1.y, r1.x, r1.x
mad r1.x, -r1, c25, c25.y
mad r2.w, r1.y, r1.x, -r1.z
texld r1.xyz, r0.zxzw, s2
mad r1.xyz, v1.y, r1, r2
mul r2.x, r1.w, r2.w
mad r2.xyz, r1, r2.x, r3
texld r1.xyz, r0.zyzw, s3
texld r3.xyz, r0, s3
mul r1.xyz, v1.x, r1
mad r1.xyz, v1.z, r3, r1
mov r0.y, c23.x
add r3.x, -c22, r0.y
rcp r3.y, r3.x
add r3.x, v2.y, -c22
texld r0.xyz, r0.zxzw, s3
mul_sat r4.y, r3.x, r3
mad r3.xyz, v1.y, r0, r1
mad r0.y, -r4, c25.x, c25
mul r0.x, r4.y, r4.y
mul r4.y, r0.x, r0
mul r0.xyz, v0, c8.x
mul r4.z, r1.w, r4.y
mad r3.xyz, r3, r4.z, r2
texld r1.xyz, r0.zyzw, s4
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s4
mad r1.xyz, v1.z, r1, r2
texld r0.xyz, r0.zxzw, s4
mad r1.xyz, v1.y, r0, r1
mul r0.xyz, v0, c9.x
mul r4.x, r0.w, r4
texld r2.xyz, r0.zyzw, s5
mad r1.xyz, r1, r4.x, r3
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s5
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s5
mad r3.xyz, v1.y, r0, r2
mul r0.xyz, v0, c10.x
mul r3.w, r0, r3
texld r2.xyz, r0.zyzw, s6
mad r1.xyz, r3, r3.w, r1
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s6
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s6
mad r3.xyz, v1.y, r0, r2
mul r0.xyz, v0, c11.x
mul r2.w, r0, r2
texld r2.xyz, r0.zyzw, s7
mad r1.xyz, r3, r2.w, r1
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s7
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s7
mad r0.xyz, v1.y, r0, r2
mul r2.x, r0.w, r4.y
mad r0.xyz, r0, r2.x, r1
mad r2.xyz, v3, r0, -v3
mul r0.xyz, v0, c4.x
add r0.w, r1, r0
texld r1.xyz, r0.zyzw, s8
mul r3.xyz, v1.x, r1
texld r1.xyz, r0, s8
mad r1.xyz, v1.z, r1, r3
texld r0.xyz, r0.zxzw, s8
mad r0.xyz, r0, v1.y, r1
mad r2.xyz, r0.w, r2, v3
add r3.xyz, r0, -r2
texld r1, v5, s11
texld r0, v5, s10
mul_pp r0.xyz, r0.w, r0
mul_pp r1.xyz, r1.w, r1
mul_pp r1.xyz, r1, c25.w
mov r0.w, c6.x
dp3_pp r1.x, r1, c26.x
mul_pp r1.xyz, r0, r1.x
add r0.w, -c5.x, r0
rcp r0.y, r0.w
add r0.x, v2.z, -c5
mul_sat r0.w, r0.x, r0.y
texldp r0.xyz, v4, s9
mad r1.w, -r0, c25.x, c25.y
mul r0.w, r0, r0
mad r0.w, -r0, r1, c25.z
log_pp r0.x, r0.x
log_pp r0.z, r0.z
log_pp r0.y, r0.y
mad_pp r0.xyz, r1, c26.x, -r0
mul r0.w, v2.x, r0
mad r1.xyz, r0.w, r3, r2
mul_pp oC0.xyz, r1, r0
mov_pp oC0.w, c24.x
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
						"HDR_LIGHT_PREPASS_OFF"
					}
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 2
					SetTexture 2[_highTex] 2D 4
					SetTexture 3[_snowTex] 2D 6
					SetTexture 4[_deepMultiTex] 2D 1
					SetTexture 5[_mainMultiTex] 2D 3
					SetTexture 6[_highMultiTex] 2D 5
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[_LightBuffer] 2D 9
					SetTexture 10[unity_Lightmap] 2D 10
					SetTexture 11[unity_LightmapInd] 2D 11
					ConstBuffer "$Globals"
					240
					Float 64[_texTiling]
					Float 68[_texPower]
					Float 72[_groundTexStart]
					Float 76[_groundTexEnd]
					Float 84[_steepTiling]
					Float 88[_steepTexStart]
					Float 92[_steepTexEnd]
					Float 104[_multiPower]
					Float 108[_deepMultiFactor]
					Float 112[_mainMultiFactor]
					Float 116[_highMultiFactor]
					Float 120[_snowMultiFactor]
					Float 124[_deepStart]
					Float 128[_deepEnd]
					Float 132[_mainLoStart]
					Float 136[_mainLoEnd]
					Float 140[_mainHiStart]
					Float 144[_mainHiEnd]
					Float 148[_hiLoStart]
					Float 152[_hiLoEnd]
					Float 156[_hiHiStart]
					Float 160[_hiHiEnd]
					Float 164[_snowStart]
					Float 168[_snowEnd]
					Float 172[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedoolmgednhnlpgokhikhlanjalkbopibiabaaaaaaaabhaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmibfaaaaeaaaaaaahcafaaaa
fjaaaaaeegiocaaaaaaaaaaaalaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaa
agaaaaaafkaaaaadaagabaaaahaaaaaafkaaaaadaagabaaaaiaaaaaafkaaaaad
aagabaaaajaaaaaafkaaaaadaagabaaaakaaaaaafkaaaaadaagabaaaalaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
fibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaa
fibiaaaeaahabaaaagaaaaaaffffaaaafibiaaaeaahabaaaahaaaaaaffffaaaa
fibiaaaeaahabaaaaiaaaaaaffffaaaafibiaaaeaahabaaaajaaaaaaffffaaaa
fibiaaaeaahabaaaakaaaaaaffffaaaafibiaaaeaahabaaaalaaaaaaffffaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadlcbabaaaafaaaaaagcbaaaad
dcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaaaaaaaaak
bcaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaaahaaaaaaakiacaaaaaaaaaaa
aiaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpakaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaabkbabaaaadaaaaaa
dkiacaiaebaaaaaaaaaaaaaaahaaaaaadicaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaakccaabaaaaaaaaaaa
ckiacaiaebaaaaaaaaaaaaaaaeaaaaaadkiacaaaaaaaaaaaaeaaaaaaaoaaaaak
ccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaa
aaaaaaaaaaaaaaajecaabaaaaaaaaaaackbabaaaadaaaaaackiacaiaebaaaaaa
aaaaaaaaaeaaaaaadicaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaa
aaaaaaaadcaaaaakicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaackiacaaa
aaaaaaaaagaaaaaadiaaaaaiecaabaaaaaaaaaaadkaabaaaaaaaaaaabkiacaaa
aaaaaaaaaeaaaaaadcaaaaakicaabaaaaaaaaaaabkiacaaaaaaaaaaaaeaaaaaa
dkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaackaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaaaaaaaaakccaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaa
aiaaaaaaakiacaaaaaaaaaaaajaaaaaaaoaaaaakccaabaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaabaaaaaaaaaaaaajmcaabaaa
abaaaaaafgbfbaaaadaaaaaafgincaiaebaaaaaaaaaaaaaaaiaaaaaadicaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaajicaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaaaaaaaaakicaabaaaabaaaaaa
bkiacaiaebaaaaaaaaaaaaaaaiaaaaaackiacaaaaaaaaaaaaiaaaaaaaoaaaaak
icaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaa
abaaaaaadicaaaahecaabaaaabaaaaaadkaabaaaabaaaaaackaabaaaabaaaaaa
dcaaaaajicaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
aaaaeaeadiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaackaabaaaabaaaaaa
dcaaaaakccaabaaaabaaaaaadkaabaaaabaaaaaackaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaadiaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaabkaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaaabaaaaaa
diaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaaeaaaaaa
efaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaa
efaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaa
egacbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaaaeaaaaaa
fgbfbaaaacaaaaaaegacbaaaadaaaaaadiaaaaahhcaabaaaadaaaaaakgakbaaa
abaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaaggakbaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaaeaaaaaaegacbaaa
aeaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaaeaaaaaaegacbaaa
afaaaaaakgbkbaaaacaaaaaaegacbaaaaeaaaaaaefaaaaajpcaabaaaafaaaaaa
cgakbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaa
aeaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaaaeaaaaaadcaaaaaj
ncaabaaaabaaaaaaagajbaaaaeaaaaaaagaabaaaabaaaaaaagajbaaaadaaaaaa
aaaaaaakicaabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaaajaaaaaaakiacaaa
aaaaaaaaakaaaaaaaoaaaaakicaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpdkaabaaaacaaaaaaaaaaaaajdcaabaaaadaaaaaafgbfbaaa
adaaaaaangifcaiaebaaaaaaaaaaaaaaajaaaaaadicaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaabkaabaaaadaaaaaadcaaaaajccaabaaaadaaaaaadkaabaaa
acaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaa
acaaaaaabkaabaaaadaaaaaaaaaaaaakccaabaaaadaaaaaabkiacaiaebaaaaaa
aaaaaaaaajaaaaaackiacaaaaaaaaaaaajaaaaaaaoaaaaakccaabaaaadaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaadaaaaaadicaaaah
bcaabaaaadaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaajccaabaaa
adaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaah
bcaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaakicaabaaa
acaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadkaabaiaebaaaaaaacaaaaaa
diaaaaahbcaabaaaadaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaadiaaaaah
icaabaaaacaaaaaabkaabaaaaaaaaaaadkaabaaaacaaaaaaefaaaaajpcaabaaa
aeaaaaaaggakbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaaeaaaaaadiaaaaah
ocaabaaaadaaaaaaagajbaaaaeaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaaeaaaaaadcaaaaaj
ocaabaaaadaaaaaaagajbaaaaeaaaaaakgbkbaaaacaaaaaafgaobaaaadaaaaaa
efaaaaajpcaabaaaaeaaaaaacgakbaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
aeaaaaaadcaaaaajocaabaaaadaaaaaaagajbaaaaeaaaaaafgbfbaaaacaaaaaa
fgaobaaaadaaaaaadcaaaaajncaabaaaabaaaaaafgaobaaaadaaaaaaagaabaaa
adaaaaaaagaobaaaabaaaaaaaaaaaaakbcaabaaaadaaaaaabkiacaiaebaaaaaa
aaaaaaaaakaaaaaackiacaaaaaaaaaaaakaaaaaaaoaaaaakbcaabaaaadaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaadaaaaaaaaaaaaaj
ccaabaaaadaaaaaabkbabaaaadaaaaaabkiacaiaebaaaaaaaaaaaaaaakaaaaaa
dicaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaadcaaaaaj
ccaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaea
diaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaadiaaaaah
bcaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaadiaaaaahgcaabaaa
aaaaaaaafgagbaaaaaaaaaaaagaabaaaadaaaaaaefaaaaajpcaabaaaadaaaaaa
ggakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaagaaaaaadiaaaaahhcaabaaa
adaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaa
egaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaagaaaaaaefaaaaajpcaabaaa
afaaaaaacgakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaagaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaa
dcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaa
acaaaaaadcaaaaajncaabaaaabaaaaaaagajbaaaacaaaaaakgakbaaaaaaaaaaa
agaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaapgipcaaa
aaaaaaaaagaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaa
aeaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaa
agbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaa
aeaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaafaaaaaacgakbaaaacaaaaaa
eghobaaaaeaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaa
aeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajncaabaaa
abaaaaaaagajbaaaacaaaaaaagaabaaaaaaaaaaaagaobaaaabaaaaaadiaaaaai
hcaabaaaacaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaahaaaaaaefaaaaaj
pcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaafaaaaaaaagabaaaadaaaaaa
diaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaafaaaaaaaagabaaaadaaaaaa
efaaaaajpcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaafaaaaaaaagabaaa
adaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaa
egacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaa
acaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaa
fgafbaaaabaaaaaaigadbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaa
abaaaaaafgifcaaaaaaaaaaaahaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaa
acaaaaaaeghobaaaagaaaaaaaagabaaaafaaaaaadiaaaaahhcaabaaaadaaaaaa
egacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
acaaaaaaeghobaaaagaaaaaaaagabaaaafaaaaaaefaaaaajpcaabaaaafaaaaaa
cgakbaaaacaaaaaaeghobaaaagaaaaaaaagabaaaafaaaaaadcaaaaajhcaabaaa
acaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaa
dcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaapgapbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaakgikcaaaaaaaaaaa
ahaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaahaaaaaa
aagabaaaahaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaa
acaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaahaaaaaa
aagabaaaahaaaaaaefaaaaajpcaabaaaacaaaaaacgakbaaaacaaaaaaeghobaaa
ahaaaaaaaagabaaaahaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaaaeaaaaaa
kgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaa
acaaaaaafgbfbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaacaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaiaebaaaaaaaeaaaaaa
dcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaa
aeaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaabaaaaaafgifcaaaaaaaaaaa
afaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaaeghobaaaaiaaaaaa
aagabaaaaiaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaagbabaaa
acaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaaaiaaaaaa
aagabaaaaiaaaaaaefaaaaajpcaabaaaabaaaaaacgakbaaaabaaaaaaeghobaaa
aiaaaaaaaagabaaaaiaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaadaaaaaa
kgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
abaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaaabaaaaaa
egacbaiaebaaaaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaakicaabaaaaaaaaaaa
ckiacaiaebaaaaaaaaaaaaaaafaaaaaadkiacaaaaaaaaaaaafaaaaaaaoaaaaak
icaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaa
aaaaaaaaaaaaaaajicaabaaaabaaaaaackbabaaaadaaaaaackiacaiaebaaaaaa
aaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akbabaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaagaaaaaa
eghobaaaalaaaaaaaagabaaaalaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaaaaaaaaabaaaaaakicaabaaaaaaaaaaaaceaaaaadkmnbddpdkmnbddp
dkmnbddpaaaaaaaaegacbaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaa
afaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaajaaaaaaaagabaaaajaaaaaacpaaaaafhcaabaaaabaaaaaaegacbaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaagaaaaaaeghobaaaakaaaaaa
aagabaaaakaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaaaebdiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegacbaaaacaaaaaapgapbaaaaaaaaaaaegacbaia
ebaaaaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaagiccabaaaaaaaaaaadkiacaaaaaaaaaaaakaaaaaadoaaaaab
"
				}
				SubProgram "opengl " {
					Keywords {
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_ON"
					}
					Float 0[_texTiling]
					Float 1[_texPower]
					Float 2[_groundTexStart]
					Float 3[_groundTexEnd]
					Float 4[_steepTiling]
					Float 5[_steepTexStart]
					Float 6[_steepTexEnd]
					Float 7[_multiPower]
					Float 8[_deepMultiFactor]
					Float 9[_mainMultiFactor]
					Float 10[_highMultiFactor]
					Float 11[_snowMultiFactor]
					Float 12[_deepStart]
					Float 13[_deepEnd]
					Float 14[_mainLoStart]
					Float 15[_mainLoEnd]
					Float 16[_mainHiStart]
					Float 17[_mainHiEnd]
					Float 18[_hiLoStart]
					Float 19[_hiLoEnd]
					Float 20[_hiHiStart]
					Float 21[_hiHiEnd]
					Float 22[_snowStart]
					Float 23[_snowEnd]
					Float 24[_PlanetOpacity]
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 1
					SetTexture 2[_highTex] 2D 2
					SetTexture 3[_snowTex] 2D 3
					SetTexture 4[_deepMultiTex] 2D 4
					SetTexture 5[_mainMultiTex] 2D 5
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[_LightBuffer] 2D 9 "3.0-!!ARBfp1.0
PARAM c[26] = { program.local[0..24],
		{ 2, 3, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.x, c[2];
ADD R0.x, -R0, c[3];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].z, -c[2];
MUL_SAT R0.w, R0.x, R0.y;
MUL R3.xyz, fragment.texcoord[0], c[0].x;
MAD R1.x, -R0.w, c[25], c[25].y;
MUL R0.w, R0, R0;
MOV R2.w, c[12].x;
ADD R2.w, -R2, c[13].x;
RCP R4.x, R2.w;
ADD R2.w, fragment.texcoord[2].y, -c[12].x;
MUL_SAT R2.w, R2, R4.x;
TEX R0.xyz, R3.zyzw, texture[1], 2D;
MUL R0.w, R0, R1.x;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[1], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R0, R1;
ADD R0.x, -R0.w, c[25].z;
MOV R0.z, c[16].x;
ADD R0.z, -R0, c[17].x;
RCP R1.w, R0.z;
ADD R0.z, fragment.texcoord[2].y, -c[16].x;
MUL_SAT R1.w, R0.z, R1;
MOV R0.y, c[14].x;
ADD R0.y, -R0, c[15].x;
RCP R0.z, R0.y;
ADD R0.y, fragment.texcoord[2], -c[14].x;
MUL_SAT R0.y, R0, R0.z;
MUL R0.w, R0, c[7].x;
MAD R2.x, -R1.w, c[25], c[25].y;
MUL R0.z, R1.w, R1.w;
MUL R1.w, R0.z, R2.x;
MUL R0.z, R0.y, R0.y;
MAD R0.y, -R0, c[25].x, c[25];
MAD R3.w, R0.z, R0.y, -R1;
MUL R1.w, R0.x, c[1].x;
MUL R2.x, R1.w, R3.w;
TEX R0.xyz, R3.zxzw, texture[1], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R0, R1;
MUL R1.xyz, R0, R2.x;
TEX R2.xyz, R3.zyzw, texture[0], 2D;
TEX R0.xyz, R3, texture[0], 2D;
MUL R2.xyz, fragment.texcoord[1].x, R2;
MAD R2.xyz, fragment.texcoord[1].z, R0, R2;
MAD R0.y, -R2.w, c[25].x, c[25];
MUL R0.x, R2.w, R2.w;
MAD R4.x, -R0, R0.y, c[25].z;
TEX R0.xyz, R3.zxzw, texture[0], 2D;
MUL R2.w, R1, R4.x;
MAD R2.xyz, fragment.texcoord[1].y, R0, R2;
TEX R0.xyz, R3.zyzw, texture[2], 2D;
MAD R2.xyz, R2, R2.w, R1;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[2], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R0, R1;
MOV R0.y, c[20].x;
ADD R0.y, -R0, c[21].x;
RCP R0.z, R0.y;
ADD R0.y, fragment.texcoord[2], -c[20].x;
MUL_SAT R0.z, R0.y, R0;
MOV R0.x, c[18];
ADD R0.x, -R0, c[19];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].y, -c[18];
MUL_SAT R0.x, R0, R0.y;
MAD R2.w, -R0.z, c[25].x, c[25].y;
MUL R0.y, R0.z, R0.z;
MUL R0.z, R0.y, R2.w;
MUL R0.y, R0.x, R0.x;
MAD R0.x, -R0, c[25], c[25].y;
MAD R2.w, R0.y, R0.x, -R0.z;
TEX R0.xyz, R3.zxzw, texture[2], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R0, R1;
MUL R1.x, R1.w, R2.w;
MAD R2.xyz, R0, R1.x, R2;
TEX R1.xyz, R3.zyzw, texture[3], 2D;
TEX R0.xyz, R3, texture[3], 2D;
MUL R1.xyz, fragment.texcoord[1].x, R1;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[3], 2D;
MOV R3.y, c[22].x;
ADD R3.y, -R3, c[23].x;
MAD R1.xyz, fragment.texcoord[1].y, R1, R0;
RCP R3.y, R3.y;
ADD R3.x, fragment.texcoord[2].y, -c[22];
MUL_SAT R3.x, R3, R3.y;
MAD R0.y, -R3.x, c[25].x, c[25];
MUL R0.x, R3, R3;
MUL R4.y, R0.x, R0;
MUL R3.xyz, fragment.texcoord[0], c[8].x;
MUL R4.z, R1.w, R4.y;
TEX R0.xyz, R3.zyzw, texture[4], 2D;
MAD R2.xyz, R1, R4.z, R2;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[4], 2D;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[4], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R1, R0;
MUL R1.xyz, fragment.texcoord[0], c[9].x;
MUL R4.x, R0.w, R4;
MAD R0.xyz, R0, R4.x, R2;
TEX R3.xyz, R1.zyzw, texture[5], 2D;
TEX R2.xyz, R1, texture[5], 2D;
MUL R3.xyz, fragment.texcoord[1].x, R3;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[5], 2D;
MAD R3.xyz, fragment.texcoord[1].y, R1, R2;
MUL R1.xyz, fragment.texcoord[0], c[10].x;
MUL R3.w, R0, R3;
TEX R2.xyz, R1.zyzw, texture[6], 2D;
MAD R0.xyz, R3, R3.w, R0;
MUL R3.xyz, fragment.texcoord[1].x, R2;
TEX R2.xyz, R1, texture[6], 2D;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[6], 2D;
MAD R3.xyz, fragment.texcoord[1].y, R1, R2;
MUL R1.xyz, fragment.texcoord[0], c[11].x;
MUL R2.w, R0, R2;
TEX R2.xyz, R1.zyzw, texture[7], 2D;
MAD R0.xyz, R3, R2.w, R0;
MUL R3.xyz, fragment.texcoord[1].x, R2;
TEX R2.xyz, R1, texture[7], 2D;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[7], 2D;
MAD R1.xyz, fragment.texcoord[1].y, R1, R2;
MUL R2.x, R0.w, R4.y;
MAD R0.xyz, R1, R2.x, R0;
MAD R2.xyz, fragment.texcoord[3], R0, -fragment.texcoord[3];
MUL R1.xyz, fragment.texcoord[0], c[4].x;
ADD R0.w, R1, R0;
MAD R3.xyz, R0.w, R2, fragment.texcoord[3];
TEX R0.xyz, R1.zyzw, texture[8], 2D;
MUL R2.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R1, texture[8], 2D;
MAD R0.xyz, fragment.texcoord[1].z, R0, R2;
TEX R1.xyz, R1.zxzw, texture[8], 2D;
MAD R1.xyz, R1, fragment.texcoord[1].y, R0;
MOV R0.w, c[5].x;
ADD R0.x, -R0.w, c[6];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].z, -c[5];
MUL_SAT R0.w, R0.x, R0.y;
MAD R1.w, -R0, c[25].x, c[25].y;
TXP R0.xyz, fragment.texcoord[4], texture[9], 2D;
MUL R0.w, R0, R0;
MAD R0.w, -R0, R1, c[25].z;
ADD R1.xyz, R1, -R3;
MUL R0.w, fragment.texcoord[2].x, R0;
ADD R0.xyz, R0, fragment.texcoord[5];
MAD R1.xyz, R0.w, R1, R3;
MUL result.color.xyz, R1, R0;
MOV result.color.w, c[24].x;
END
# 153 instructions, 5 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_ON"
					}
					Float 0[_texTiling]
					Float 1[_texPower]
					Float 2[_groundTexStart]
					Float 3[_groundTexEnd]
					Float 4[_steepTiling]
					Float 5[_steepTexStart]
					Float 6[_steepTexEnd]
					Float 7[_multiPower]
					Float 8[_deepMultiFactor]
					Float 9[_mainMultiFactor]
					Float 10[_highMultiFactor]
					Float 11[_snowMultiFactor]
					Float 12[_deepStart]
					Float 13[_deepEnd]
					Float 14[_mainLoStart]
					Float 15[_mainLoEnd]
					Float 16[_mainHiStart]
					Float 17[_mainHiEnd]
					Float 18[_hiLoStart]
					Float 19[_hiLoEnd]
					Float 20[_hiHiStart]
					Float 21[_hiHiEnd]
					Float 22[_snowStart]
					Float 23[_snowEnd]
					Float 24[_PlanetOpacity]
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 1
					SetTexture 2[_highTex] 2D 2
					SetTexture 3[_snowTex] 2D 3
					SetTexture 4[_deepMultiTex] 2D 4
					SetTexture 5[_mainMultiTex] 2D 5
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[_LightBuffer] 2D 9 "ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
dcl_2d s8
dcl_2d s9
def c25, 2.00000000, 3.00000000, 1.00000000, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4
dcl_texcoord5 v5.xyz
mov r0.x, c3
add r0.w, -c2.x, r0.x
mul r0.xyz, v0, c0.x
rcp r1.x, r0.w
texld r3.xyz, r0.zyzw, s0
add r0.w, v2.z, -c2.x
mul_sat r0.w, r0, r1.x
texld r1.xyz, r0.zyzw, s1
mad r1.w, -r0, c25.x, c25.y
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s1
mad r2.xyz, v1.z, r1, r2
mul r0.w, r0, r0
mul r0.w, r0, r1
add r1.x, -r0.w, c25.z
mov r1.z, c17.x
add r1.z, -c16.x, r1
rcp r1.w, r1.z
add r1.z, v2.y, -c16.x
mul_sat r1.w, r1.z, r1
mov r1.y, c15.x
add r1.y, -c14.x, r1
rcp r1.z, r1.y
add r1.y, v2, -c14.x
mul_sat r1.y, r1, r1.z
mul r0.w, r0, c7.x
mad r2.w, -r1, c25.x, c25.y
mul r1.z, r1.w, r1.w
mul r1.w, r1.z, r2
mul r1.z, r1.y, r1.y
mad r1.y, -r1, c25.x, c25
mad r3.w, r1.z, r1.y, -r1
mul r1.w, r1.x, c1.x
mul r2.w, r1, r3
texld r1.xyz, r0.zxzw, s1
mad r1.xyz, v1.y, r1, r2
mul r2.xyz, r1, r2.w
mov r2.w, c13.x
add r2.w, -c12.x, r2
rcp r4.x, r2.w
add r2.w, v2.y, -c12.x
texld r1.xyz, r0, s0
mul r3.xyz, v1.x, r3
mul_sat r2.w, r2, r4.x
mad r3.xyz, v1.z, r1, r3
mad r1.y, -r2.w, c25.x, c25
mul r1.x, r2.w, r2.w
mad r4.x, -r1, r1.y, c25.z
mul r2.w, r1, r4.x
texld r1.xyz, r0.zxzw, s0
mad r3.xyz, v1.y, r1, r3
mad r3.xyz, r3, r2.w, r2
texld r1.xyz, r0.zyzw, s2
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s2
mad r2.xyz, v1.z, r1, r2
mov r1.y, c21.x
add r1.y, -c20.x, r1
rcp r1.z, r1.y
add r1.y, v2, -c20.x
mul_sat r1.z, r1.y, r1
mov r1.x, c19
add r1.x, -c18, r1
rcp r1.y, r1.x
add r1.x, v2.y, -c18
mul_sat r1.x, r1, r1.y
mad r2.w, -r1.z, c25.x, c25.y
mul r1.y, r1.z, r1.z
mul r1.z, r1.y, r2.w
mul r1.y, r1.x, r1.x
mad r1.x, -r1, c25, c25.y
mad r2.w, r1.y, r1.x, -r1.z
texld r1.xyz, r0.zxzw, s2
mad r1.xyz, v1.y, r1, r2
mul r2.x, r1.w, r2.w
mad r2.xyz, r1, r2.x, r3
texld r1.xyz, r0.zyzw, s3
texld r3.xyz, r0, s3
mul r1.xyz, v1.x, r1
mad r1.xyz, v1.z, r3, r1
mov r0.y, c23.x
add r3.x, -c22, r0.y
rcp r3.y, r3.x
add r3.x, v2.y, -c22
texld r0.xyz, r0.zxzw, s3
mul_sat r4.y, r3.x, r3
mad r3.xyz, v1.y, r0, r1
mad r0.y, -r4, c25.x, c25
mul r0.x, r4.y, r4.y
mul r4.y, r0.x, r0
mul r0.xyz, v0, c8.x
mul r4.z, r1.w, r4.y
mad r3.xyz, r3, r4.z, r2
texld r1.xyz, r0.zyzw, s4
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s4
mad r1.xyz, v1.z, r1, r2
texld r0.xyz, r0.zxzw, s4
mad r1.xyz, v1.y, r0, r1
mul r0.xyz, v0, c9.x
mul r4.x, r0.w, r4
texld r2.xyz, r0.zyzw, s5
mad r1.xyz, r1, r4.x, r3
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s5
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s5
mad r3.xyz, v1.y, r0, r2
mul r0.xyz, v0, c10.x
mul r3.w, r0, r3
texld r2.xyz, r0.zyzw, s6
mad r1.xyz, r3, r3.w, r1
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s6
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s6
mad r3.xyz, v1.y, r0, r2
mul r0.xyz, v0, c11.x
mul r2.w, r0, r2
texld r2.xyz, r0.zyzw, s7
mad r1.xyz, r3, r2.w, r1
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s7
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s7
mad r0.xyz, v1.y, r0, r2
mul r2.x, r0.w, r4.y
mad r0.xyz, r0, r2.x, r1
mad r2.xyz, v3, r0, -v3
mul r0.xyz, v0, c4.x
add r0.w, r1, r0
mad r3.xyz, r0.w, r2, v3
texld r1.xyz, r0.zyzw, s8
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s8
texld r0.xyz, r0.zxzw, s8
mad r1.xyz, v1.z, r1, r2
mad r1.xyz, r0, v1.y, r1
mov r0.w, c6.x
add r0.x, -c5, r0.w
rcp r0.y, r0.x
add r0.x, v2.z, -c5
mul_sat r0.w, r0.x, r0.y
mad r1.w, -r0, c25.x, c25.y
texldp r0.xyz, v4, s9
mul r0.w, r0, r0
mad r0.w, -r0, r1, c25.z
add r1.xyz, r1, -r3
mul r0.w, v2.x, r0
add_pp r0.xyz, r0, v5
mad r1.xyz, r0.w, r1, r3
mul_pp oC0.xyz, r1, r0
mov_pp oC0.w, c24.x
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_ON"
					}
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 2
					SetTexture 2[_highTex] 2D 4
					SetTexture 3[_snowTex] 2D 6
					SetTexture 4[_deepMultiTex] 2D 1
					SetTexture 5[_mainMultiTex] 2D 3
					SetTexture 6[_highMultiTex] 2D 5
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[_LightBuffer] 2D 9
					ConstBuffer "$Globals"
					208
					Float 64[_texTiling]
					Float 68[_texPower]
					Float 72[_groundTexStart]
					Float 76[_groundTexEnd]
					Float 84[_steepTiling]
					Float 88[_steepTexStart]
					Float 92[_steepTexEnd]
					Float 104[_multiPower]
					Float 108[_deepMultiFactor]
					Float 112[_mainMultiFactor]
					Float 116[_highMultiFactor]
					Float 120[_snowMultiFactor]
					Float 124[_deepStart]
					Float 128[_deepEnd]
					Float 132[_mainLoStart]
					Float 136[_mainLoEnd]
					Float 140[_mainHiStart]
					Float 144[_mainHiEnd]
					Float 148[_hiLoStart]
					Float 152[_hiLoEnd]
					Float 156[_hiHiStart]
					Float 160[_hiHiEnd]
					Float 164[_snowStart]
					Float 168[_snowEnd]
					Float 172[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedcpffpakkmenodfcafpelcgdhabfjhinoabaaaaaamibfaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjabeaaaaeaaaaaaaceafaaaa
fjaaaaaeegiocaaaaaaaaaaaalaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaa
agaaaaaafkaaaaadaagabaaaahaaaaaafkaaaaadaagabaaaaiaaaaaafkaaaaad
aagabaaaajaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaa
afaaaaaaffffaaaafibiaaaeaahabaaaagaaaaaaffffaaaafibiaaaeaahabaaa
ahaaaaaaffffaaaafibiaaaeaahabaaaaiaaaaaaffffaaaafibiaaaeaahabaaa
ajaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadlcbabaaa
afaaaaaagcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
agaaaaaaaaaaaaakbcaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaaahaaaaaa
akiacaaaaaaaaaaaaiaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaa
bkbabaaaadaaaaaadkiacaiaebaaaaaaaaaaaaaaahaaaaaadicaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaak
ccaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaadkiacaaaaaaaaaaa
aeaaaaaaaoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpbkaabaaaaaaaaaaaaaaaaaajecaabaaaaaaaaaaackbabaaaadaaaaaa
ckiacaiaebaaaaaaaaaaaaaaaeaaaaaadicaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaackiacaaaaaaaaaaaagaaaaaadiaaaaaiecaabaaaaaaaaaaadkaabaaa
aaaaaaaabkiacaaaaaaaaaaaaeaaaaaadcaaaaakicaabaaaaaaaaaaabkiacaaa
aaaaaaaaaeaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaa
abaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaakccaabaaaabaaaaaadkiacaia
ebaaaaaaaaaaaaaaaiaaaaaaakiacaaaaaaaaaaaajaaaaaaaoaaaaakccaabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaabaaaaaa
aaaaaaajmcaabaaaabaaaaaafgbfbaaaadaaaaaafgincaiaebaaaaaaaaaaaaaa
aiaaaaaadicaaaahccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaa
dcaaaaajicaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
aaaaeaeadiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaa
diaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaaaaaaaaak
icaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaaaiaaaaaackiacaaaaaaaaaaa
aiaaaaaaaoaaaaakicaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdkaabaaaabaaaaaadicaaaahecaabaaaabaaaaaadkaabaaaabaaaaaa
ckaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaa
ckaabaaaabaaaaaadcaaaaakccaabaaaabaaaaaadkaabaaaabaaaaaackaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaadiaaaaahecaabaaaabaaaaaackaabaaa
aaaaaaaabkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaaaaaaaaa
bkaabaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaaagiacaaa
aaaaaaaaaeaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaa
agbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaaaeaaaaaa
kgbkbaaaacaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaa
acaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaaadaaaaaa
egacbaaaaeaaaaaafgbfbaaaacaaaaaaegacbaaaadaaaaaadiaaaaahhcaabaaa
adaaaaaakgakbaaaabaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaa
ggakbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaa
aeaaaaaaegacbaaaaeaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaafaaaaaa
egaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaa
aeaaaaaaegacbaaaafaaaaaakgbkbaaaacaaaaaaegacbaaaaeaaaaaaefaaaaaj
pcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaajhcaabaaaaeaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaa
aeaaaaaadcaaaaajncaabaaaabaaaaaaagajbaaaaeaaaaaaagaabaaaabaaaaaa
agajbaaaadaaaaaaaaaaaaakicaabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaa
ajaaaaaaakiacaaaaaaaaaaaakaaaaaaaoaaaaakicaabaaaacaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaacaaaaaaaaaaaaajdcaabaaa
adaaaaaafgbfbaaaadaaaaaangifcaiaebaaaaaaaaaaaaaaajaaaaaadicaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaabkaabaaaadaaaaaadcaaaaajccaabaaa
adaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaabkaabaaaadaaaaaaaaaaaaakccaabaaaadaaaaaa
bkiacaiaebaaaaaaaaaaaaaaajaaaaaackiacaaaaaaaaaaaajaaaaaaaoaaaaak
ccaabaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaa
adaaaaaadicaaaahbcaabaaaadaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaa
dcaaaaajccaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaa
aaaaeaeadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaa
dcaaaaakicaabaaaacaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadkaabaia
ebaaaaaaacaaaaaadiaaaaahbcaabaaaadaaaaaackaabaaaaaaaaaaadkaabaaa
acaaaaaadiaaaaahicaabaaaacaaaaaabkaabaaaaaaaaaaadkaabaaaacaaaaaa
efaaaaajpcaabaaaaeaaaaaaggakbaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
aeaaaaaadiaaaaahocaabaaaadaaaaaaagajbaaaaeaaaaaaagbabaaaacaaaaaa
efaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
aeaaaaaadcaaaaajocaabaaaadaaaaaaagajbaaaaeaaaaaakgbkbaaaacaaaaaa
fgaobaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaaacaaaaaaeghobaaa
acaaaaaaaagabaaaaeaaaaaadcaaaaajocaabaaaadaaaaaaagajbaaaaeaaaaaa
fgbfbaaaacaaaaaafgaobaaaadaaaaaadcaaaaajncaabaaaabaaaaaafgaobaaa
adaaaaaaagaabaaaadaaaaaaagaobaaaabaaaaaaaaaaaaakbcaabaaaadaaaaaa
bkiacaiaebaaaaaaaaaaaaaaakaaaaaackiacaaaaaaaaaaaakaaaaaaaoaaaaak
bcaabaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaa
adaaaaaaaaaaaaajccaabaaaadaaaaaabkbabaaaadaaaaaabkiacaiaebaaaaaa
aaaaaaaaakaaaaaadicaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaa
adaaaaaadcaaaaajccaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaa
adaaaaaadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaa
diaaaaahgcaabaaaaaaaaaaafgagbaaaaaaaaaaaagaabaaaadaaaaaaefaaaaaj
pcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaagaaaaaa
diaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaagaaaaaa
efaaaaajpcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaa
agaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaa
egacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaa
acaaaaaaegacbaaaacaaaaaadcaaaaajncaabaaaabaaaaaaagajbaaaacaaaaaa
kgakbaaaaaaaaaaaagaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaa
abaaaaaapgipcaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaa
acaaaaaaeghobaaaaeaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaaadaaaaaa
egacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
acaaaaaaeghobaaaaeaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaafaaaaaa
cgakbaaaacaaaaaaeghobaaaaeaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaa
acaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaa
dcaaaaajncaabaaaabaaaaaaagajbaaaacaaaaaaagaabaaaaaaaaaaaagaobaaa
abaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaa
ahaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaafaaaaaa
aagabaaaadaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaa
acaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaafaaaaaa
aagabaaaadaaaaaaefaaaaajpcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaa
afaaaaaaaagabaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaaeaaaaaa
kgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaa
afaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaa
egacbaaaacaaaaaafgafbaaaabaaaaaaigadbaaaabaaaaaadiaaaaaihcaabaaa
acaaaaaaegbcbaaaabaaaaaafgifcaaaaaaaaaaaahaaaaaaefaaaaajpcaabaaa
adaaaaaaggakbaaaacaaaaaaeghobaaaagaaaaaaaagabaaaafaaaaaadiaaaaah
hcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaacaaaaaaeghobaaaagaaaaaaaagabaaaafaaaaaaefaaaaaj
pcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaagaaaaaaaagabaaaafaaaaaa
dcaaaaajhcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaa
adaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaa
egacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaapgapbaaa
acaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaa
kgikcaaaaaaaaaaaahaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaa
eghobaaaahaaaaaaaagabaaaahaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaa
adaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaa
eghobaaaahaaaaaaaagabaaaahaaaaaaefaaaaajpcaabaaaacaaaaaacgakbaaa
acaaaaaaeghobaaaahaaaaaaaagabaaaahaaaaaadcaaaaajhcaabaaaadaaaaaa
egacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaa
acaaaaaaegacbaaaacaaaaaafgbfbaaaacaaaaaaegacbaaaadaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaacaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaia
ebaaaaaaaeaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaegbcbaaaaeaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaabaaaaaa
fgifcaaaaaaaaaaaafaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaa
eghobaaaaiaaaaaaaagabaaaaiaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaa
eghobaaaaiaaaaaaaagabaaaaiaaaaaaefaaaaajpcaabaaaabaaaaaacgakbaaa
abaaaaaaeghobaaaaiaaaaaaaagabaaaaiaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaadaaaaaakgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaa
abaaaaaaegacbaaaabaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaak
icaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaafaaaaaadkiacaaaaaaaaaaa
afaaaaaaaoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaackbabaaaadaaaaaa
ckiacaiaebaaaaaaaaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaiaebaaaaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakbabaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaa
egbabaaaafaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaajaaaaaaaagabaaaajaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegbcbaaaagaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaagiccabaaaaaaaaaaadkiacaaaaaaaaaaa
akaaaaaadoaaaaab"
				}
				SubProgram "opengl " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_ON"
					}
					Float 0[_texTiling]
					Float 1[_texPower]
					Float 2[_groundTexStart]
					Float 3[_groundTexEnd]
					Float 4[_steepTiling]
					Float 5[_steepTexStart]
					Float 6[_steepTexEnd]
					Float 7[_multiPower]
					Float 8[_deepMultiFactor]
					Float 9[_mainMultiFactor]
					Float 10[_highMultiFactor]
					Float 11[_snowMultiFactor]
					Float 12[_deepStart]
					Float 13[_deepEnd]
					Float 14[_mainLoStart]
					Float 15[_mainLoEnd]
					Float 16[_mainHiStart]
					Float 17[_mainHiEnd]
					Float 18[_hiLoStart]
					Float 19[_hiLoEnd]
					Float 20[_hiHiStart]
					Float 21[_hiHiEnd]
					Float 22[_snowStart]
					Float 23[_snowEnd]
					Float 24[_PlanetOpacity]
					Vector 25[unity_LightmapFade]
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 1
					SetTexture 2[_highTex] 2D 2
					SetTexture 3[_snowTex] 2D 3
					SetTexture 4[_deepMultiTex] 2D 4
					SetTexture 5[_mainMultiTex] 2D 5
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[_LightBuffer] 2D 9
					SetTexture 10[unity_Lightmap] 2D 10
					SetTexture 11[unity_LightmapInd] 2D 11 "3.0-!!ARBfp1.0
PARAM c[27] = { program.local[0..25],
		{ 2, 3, 1, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.x, c[2];
ADD R0.x, -R0, c[3];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].z, -c[2];
MUL_SAT R0.w, R0.x, R0.y;
MUL R3.xyz, fragment.texcoord[0], c[0].x;
MAD R1.x, -R0.w, c[26], c[26].y;
MUL R0.w, R0, R0;
MOV R2.w, c[12].x;
ADD R2.w, -R2, c[13].x;
RCP R4.x, R2.w;
ADD R2.w, fragment.texcoord[2].y, -c[12].x;
MUL_SAT R2.w, R2, R4.x;
TEX R0.xyz, R3.zyzw, texture[1], 2D;
MUL R0.w, R0, R1.x;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[1], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R0, R1;
ADD R0.x, -R0.w, c[26].z;
MOV R0.z, c[16].x;
ADD R0.z, -R0, c[17].x;
RCP R1.w, R0.z;
ADD R0.z, fragment.texcoord[2].y, -c[16].x;
MUL_SAT R1.w, R0.z, R1;
MOV R0.y, c[14].x;
ADD R0.y, -R0, c[15].x;
RCP R0.z, R0.y;
ADD R0.y, fragment.texcoord[2], -c[14].x;
MUL_SAT R0.y, R0, R0.z;
MUL R0.w, R0, c[7].x;
MAD R2.x, -R1.w, c[26], c[26].y;
MUL R0.z, R1.w, R1.w;
MUL R1.w, R0.z, R2.x;
MUL R0.z, R0.y, R0.y;
MAD R0.y, -R0, c[26].x, c[26];
MAD R3.w, R0.z, R0.y, -R1;
MUL R1.w, R0.x, c[1].x;
MUL R2.x, R1.w, R3.w;
TEX R0.xyz, R3.zxzw, texture[1], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R0, R1;
MUL R1.xyz, R0, R2.x;
TEX R2.xyz, R3.zyzw, texture[0], 2D;
TEX R0.xyz, R3, texture[0], 2D;
MUL R2.xyz, fragment.texcoord[1].x, R2;
MAD R2.xyz, fragment.texcoord[1].z, R0, R2;
MAD R0.y, -R2.w, c[26].x, c[26];
MUL R0.x, R2.w, R2.w;
MAD R4.x, -R0, R0.y, c[26].z;
TEX R0.xyz, R3.zxzw, texture[0], 2D;
MUL R2.w, R1, R4.x;
MAD R2.xyz, fragment.texcoord[1].y, R0, R2;
TEX R0.xyz, R3.zyzw, texture[2], 2D;
MAD R2.xyz, R2, R2.w, R1;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[2], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R0, R1;
MOV R0.y, c[20].x;
ADD R0.y, -R0, c[21].x;
RCP R0.z, R0.y;
ADD R0.y, fragment.texcoord[2], -c[20].x;
MUL_SAT R0.z, R0.y, R0;
MOV R0.x, c[18];
ADD R0.x, -R0, c[19];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].y, -c[18];
MUL_SAT R0.x, R0, R0.y;
MAD R2.w, -R0.z, c[26].x, c[26].y;
MUL R0.y, R0.z, R0.z;
MUL R0.z, R0.y, R2.w;
MUL R0.y, R0.x, R0.x;
MAD R0.x, -R0, c[26], c[26].y;
MAD R2.w, R0.y, R0.x, -R0.z;
TEX R0.xyz, R3.zxzw, texture[2], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R0, R1;
MUL R1.x, R1.w, R2.w;
MAD R2.xyz, R0, R1.x, R2;
TEX R1.xyz, R3.zyzw, texture[3], 2D;
TEX R0.xyz, R3, texture[3], 2D;
MUL R1.xyz, fragment.texcoord[1].x, R1;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[3], 2D;
MOV R3.y, c[22].x;
ADD R3.y, -R3, c[23].x;
MAD R1.xyz, fragment.texcoord[1].y, R1, R0;
MUL R2.w, R0, R2;
RCP R3.y, R3.y;
ADD R3.x, fragment.texcoord[2].y, -c[22];
MUL_SAT R3.x, R3, R3.y;
MAD R0.y, -R3.x, c[26].x, c[26];
MUL R0.x, R3, R3;
MUL R4.y, R0.x, R0;
MUL R3.xyz, fragment.texcoord[0], c[8].x;
MUL R4.z, R1.w, R4.y;
TEX R0.xyz, R3.zyzw, texture[4], 2D;
MAD R2.xyz, R1, R4.z, R2;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[4], 2D;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[4], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R1, R0;
MUL R1.xyz, fragment.texcoord[0], c[9].x;
MUL R4.x, R0.w, R4;
MAD R0.xyz, R0, R4.x, R2;
TEX R3.xyz, R1.zyzw, texture[5], 2D;
TEX R2.xyz, R1, texture[5], 2D;
MUL R3.xyz, fragment.texcoord[1].x, R3;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[5], 2D;
MAD R3.xyz, fragment.texcoord[1].y, R1, R2;
MUL R1.xyz, fragment.texcoord[0], c[10].x;
MUL R3.w, R0, R3;
TEX R2.xyz, R1.zyzw, texture[6], 2D;
MAD R0.xyz, R3, R3.w, R0;
MUL R3.xyz, fragment.texcoord[1].x, R2;
TEX R2.xyz, R1, texture[6], 2D;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[6], 2D;
MAD R3.xyz, fragment.texcoord[1].y, R1, R2;
MUL R1.xyz, fragment.texcoord[0], c[11].x;
TEX R2.xyz, R1.zyzw, texture[7], 2D;
MAD R0.xyz, R3, R2.w, R0;
MUL R3.xyz, fragment.texcoord[1].x, R2;
TEX R2.xyz, R1, texture[7], 2D;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[7], 2D;
MAD R1.xyz, fragment.texcoord[1].y, R1, R2;
MUL R2.x, R0.w, R4.y;
MAD R0.xyz, R1, R2.x, R0;
ADD R0.w, R1, R0;
MAD R1.xyz, fragment.texcoord[3], R0, -fragment.texcoord[3];
MUL R0.xyz, fragment.texcoord[0], c[4].x;
TEX R2.xyz, R0.zyzw, texture[8], 2D;
MUL R3.xyz, fragment.texcoord[1].x, R2;
TEX R2.xyz, R0, texture[8], 2D;
DP4 R1.w, fragment.texcoord[6], fragment.texcoord[6];
RSQ R1.w, R1.w;
MAD R1.xyz, R0.w, R1, fragment.texcoord[3];
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R0.xyz, R0.zxzw, texture[8], 2D;
MAD R2.xyz, R0, fragment.texcoord[1].y, R2;
TEX R0, fragment.texcoord[5], texture[11], 2D;
MUL R3.xyz, R0.w, R0;
TEX R0, fragment.texcoord[5], texture[10], 2D;
MUL R0.xyz, R0.w, R0;
MUL R3.xyz, R3, c[26].w;
MOV R0.w, c[5].x;
MAD R0.xyz, R0, c[26].w, -R3;
ADD R0.w, -R0, c[6].x;
RCP R2.w, R1.w;
RCP R1.w, R0.w;
ADD R0.w, fragment.texcoord[2].z, -c[5].x;
MUL_SAT R0.w, R0, R1;
MAD_SAT R1.w, R2, c[25].z, c[25];
MAD R3.xyz, R1.w, R0, R3;
MAD R0.y, -R0.w, c[26].x, c[26];
MUL R0.x, R0.w, R0.w;
MAD R0.w, -R0.x, R0.y, c[26].z;
TXP R0.xyz, fragment.texcoord[4], texture[9], 2D;
ADD R2.xyz, R2, -R1;
MUL R0.w, fragment.texcoord[2].x, R0;
ADD R0.xyz, R0, R3;
MAD R1.xyz, R0.w, R2, R1;
MUL result.color.xyz, R1, R0;
MOV result.color.w, c[24].x;
END
# 164 instructions, 5 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_ON"
					}
					Float 0[_texTiling]
					Float 1[_texPower]
					Float 2[_groundTexStart]
					Float 3[_groundTexEnd]
					Float 4[_steepTiling]
					Float 5[_steepTexStart]
					Float 6[_steepTexEnd]
					Float 7[_multiPower]
					Float 8[_deepMultiFactor]
					Float 9[_mainMultiFactor]
					Float 10[_highMultiFactor]
					Float 11[_snowMultiFactor]
					Float 12[_deepStart]
					Float 13[_deepEnd]
					Float 14[_mainLoStart]
					Float 15[_mainLoEnd]
					Float 16[_mainHiStart]
					Float 17[_mainHiEnd]
					Float 18[_hiLoStart]
					Float 19[_hiLoEnd]
					Float 20[_hiHiStart]
					Float 21[_hiHiEnd]
					Float 22[_snowStart]
					Float 23[_snowEnd]
					Float 24[_PlanetOpacity]
					Vector 25[unity_LightmapFade]
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 1
					SetTexture 2[_highTex] 2D 2
					SetTexture 3[_snowTex] 2D 3
					SetTexture 4[_deepMultiTex] 2D 4
					SetTexture 5[_mainMultiTex] 2D 5
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[_LightBuffer] 2D 9
					SetTexture 10[unity_Lightmap] 2D 10
					SetTexture 11[unity_LightmapInd] 2D 11 "ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
dcl_2d s8
dcl_2d s9
dcl_2d s10
dcl_2d s11
def c26, 2.00000000, 3.00000000, 1.00000000, 8.00000000
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4
dcl_texcoord5 v5.xy
dcl_texcoord6 v6
mov r0.x, c3
add r0.w, -c2.x, r0.x
mul r0.xyz, v0, c0.x
rcp r1.x, r0.w
texld r3.xyz, r0.zyzw, s0
add r0.w, v2.z, -c2.x
mul_sat r0.w, r0, r1.x
texld r1.xyz, r0.zyzw, s1
mad r1.w, -r0, c26.x, c26.y
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s1
mad r2.xyz, v1.z, r1, r2
mul r0.w, r0, r0
mul r0.w, r0, r1
add r1.x, -r0.w, c26.z
mov r1.z, c17.x
add r1.z, -c16.x, r1
rcp r1.w, r1.z
add r1.z, v2.y, -c16.x
mul_sat r1.w, r1.z, r1
mov r1.y, c15.x
add r1.y, -c14.x, r1
rcp r1.z, r1.y
add r1.y, v2, -c14.x
mul_sat r1.y, r1, r1.z
mul r0.w, r0, c7.x
mad r2.w, -r1, c26.x, c26.y
mul r1.z, r1.w, r1.w
mul r1.w, r1.z, r2
mul r1.z, r1.y, r1.y
mad r1.y, -r1, c26.x, c26
mad r3.w, r1.z, r1.y, -r1
mul r1.w, r1.x, c1.x
mul r2.w, r1, r3
texld r1.xyz, r0.zxzw, s1
mad r1.xyz, v1.y, r1, r2
mul r2.xyz, r1, r2.w
mov r2.w, c13.x
add r2.w, -c12.x, r2
rcp r4.x, r2.w
add r2.w, v2.y, -c12.x
texld r1.xyz, r0, s0
mul r3.xyz, v1.x, r3
mul_sat r2.w, r2, r4.x
mad r3.xyz, v1.z, r1, r3
mad r1.y, -r2.w, c26.x, c26
mul r1.x, r2.w, r2.w
mad r4.x, -r1, r1.y, c26.z
mul r2.w, r1, r4.x
texld r1.xyz, r0.zxzw, s0
mad r3.xyz, v1.y, r1, r3
mad r3.xyz, r3, r2.w, r2
texld r1.xyz, r0.zyzw, s2
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s2
mad r2.xyz, v1.z, r1, r2
mov r1.y, c21.x
add r1.y, -c20.x, r1
rcp r1.z, r1.y
add r1.y, v2, -c20.x
mul_sat r1.z, r1.y, r1
mov r1.x, c19
add r1.x, -c18, r1
rcp r1.y, r1.x
add r1.x, v2.y, -c18
mul_sat r1.x, r1, r1.y
mad r2.w, -r1.z, c26.x, c26.y
mul r1.y, r1.z, r1.z
mul r1.z, r1.y, r2.w
mul r1.y, r1.x, r1.x
mad r1.x, -r1, c26, c26.y
mad r2.w, r1.y, r1.x, -r1.z
texld r1.xyz, r0.zxzw, s2
mad r1.xyz, v1.y, r1, r2
mul r2.x, r1.w, r2.w
mad r2.xyz, r1, r2.x, r3
texld r1.xyz, r0.zyzw, s3
texld r3.xyz, r0, s3
mul r1.xyz, v1.x, r1
mad r1.xyz, v1.z, r3, r1
mov r0.y, c23.x
add r3.x, -c22, r0.y
rcp r3.y, r3.x
add r3.x, v2.y, -c22
texld r0.xyz, r0.zxzw, s3
mul_sat r4.y, r3.x, r3
mad r3.xyz, v1.y, r0, r1
mad r0.y, -r4, c26.x, c26
mul r0.x, r4.y, r4.y
mul r4.y, r0.x, r0
mul r0.xyz, v0, c8.x
mul r4.z, r1.w, r4.y
mad r3.xyz, r3, r4.z, r2
texld r1.xyz, r0.zyzw, s4
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s4
mad r1.xyz, v1.z, r1, r2
texld r0.xyz, r0.zxzw, s4
mad r1.xyz, v1.y, r0, r1
mul r0.xyz, v0, c9.x
mul r4.x, r0.w, r4
texld r2.xyz, r0.zyzw, s5
mad r1.xyz, r1, r4.x, r3
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s5
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s5
mad r3.xyz, v1.y, r0, r2
mul r0.xyz, v0, c10.x
mul r3.w, r0, r3
texld r2.xyz, r0.zyzw, s6
mad r1.xyz, r3, r3.w, r1
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s6
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s6
mad r3.xyz, v1.y, r0, r2
mul r0.xyz, v0, c11.x
mul r2.w, r0, r2
mad r1.xyz, r3, r2.w, r1
texld r2.xyz, r0.zyzw, s7
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s7
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s7
mad r0.xyz, v1.y, r0, r2
mul r2.x, r0.w, r4.y
mad r0.xyz, r0, r2.x, r1
add r0.w, r1, r0
mad r1.xyz, v3, r0, -v3
mul r0.xyz, v0, c4.x
texld r2.xyz, r0.zyzw, s8
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s8
dp4 r1.w, v6, v6
rsq r1.w, r1.w
mad r1.xyz, r0.w, r1, v3
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s8
mad r2.xyz, r0, v1.y, r2
texld r0, v5, s11
mul_pp r3.xyz, r0.w, r0
texld r0, v5, s10
mul_pp r0.xyz, r0.w, r0
mul_pp r3.xyz, r3, c26.w
mov r0.w, c6.x
mad_pp r0.xyz, r0, c26.w, -r3
add r0.w, -c5.x, r0
rcp r2.w, r1.w
rcp r1.w, r0.w
add r0.w, v2.z, -c5.x
mul_sat r0.w, r0, r1
mad_sat r1.w, r2, c25.z, c25
mad_pp r3.xyz, r1.w, r0, r3
mad r0.y, -r0.w, c26.x, c26
mul r0.x, r0.w, r0.w
mad r0.w, -r0.x, r0.y, c26.z
texldp r0.xyz, v4, s9
add r2.xyz, r2, -r1
mul r0.w, v2.x, r0
add_pp r0.xyz, r0, r3
mad r1.xyz, r0.w, r2, r1
mul_pp oC0.xyz, r1, r0
mov_pp oC0.w, c24.x
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_ON"
					}
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 2
					SetTexture 2[_highTex] 2D 4
					SetTexture 3[_snowTex] 2D 6
					SetTexture 4[_deepMultiTex] 2D 1
					SetTexture 5[_mainMultiTex] 2D 3
					SetTexture 6[_highMultiTex] 2D 5
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[_LightBuffer] 2D 9
					SetTexture 10[unity_Lightmap] 2D 10
					SetTexture 11[unity_LightmapInd] 2D 11
					ConstBuffer "$Globals"
					240
					Float 64[_texTiling]
					Float 68[_texPower]
					Float 72[_groundTexStart]
					Float 76[_groundTexEnd]
					Float 84[_steepTiling]
					Float 88[_steepTexStart]
					Float 92[_steepTexEnd]
					Float 104[_multiPower]
					Float 108[_deepMultiFactor]
					Float 112[_mainMultiFactor]
					Float 116[_highMultiFactor]
					Float 120[_snowMultiFactor]
					Float 124[_deepStart]
					Float 128[_deepEnd]
					Float 132[_mainLoStart]
					Float 136[_mainLoEnd]
					Float 140[_mainHiStart]
					Float 144[_mainHiEnd]
					Float 148[_hiLoStart]
					Float 152[_hiLoEnd]
					Float 156[_hiHiStart]
					Float 160[_hiHiEnd]
					Float 164[_snowStart]
					Float 168[_snowEnd]
					Float 172[_PlanetOpacity]
					Vector 208[unity_LightmapFade]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedbdnglfihldoabhhohghodgnohhnajoibabaaaaaagibhaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
adadaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcbibgaaaaeaaaaaaaigafaaaafjaaaaaeegiocaaa
aaaaaaaaaoaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaaagaaaaaafkaaaaad
aagabaaaahaaaaaafkaaaaadaagabaaaaiaaaaaafkaaaaadaagabaaaajaaaaaa
fkaaaaadaagabaaaakaaaaaafkaaaaadaagabaaaalaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaa
aeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaafibiaaaeaahabaaa
agaaaaaaffffaaaafibiaaaeaahabaaaahaaaaaaffffaaaafibiaaaeaahabaaa
aiaaaaaaffffaaaafibiaaaeaahabaaaajaaaaaaffffaaaafibiaaaeaahabaaa
akaaaaaaffffaaaafibiaaaeaahabaaaalaaaaaaffffaaaagcbaaaadhcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaad
hcbabaaaaeaaaaaagcbaaaadlcbabaaaafaaaaaagcbaaaaddcbabaaaagaaaaaa
gcbaaaadpcbabaaaahaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaa
aaaaaaakbcaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaaahaaaaaaakiacaaa
aaaaaaaaaiaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaabkbabaaa
adaaaaaadkiacaiaebaaaaaaaaaaaaaaahaaaaaadicaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaakccaabaaa
aaaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaadkiacaaaaaaaaaaaaeaaaaaa
aoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
bkaabaaaaaaaaaaaaaaaaaajecaabaaaaaaaaaaackbabaaaadaaaaaackiacaia
ebaaaaaaaaaaaaaaaeaaaaaadicaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckiacaaaaaaaaaaaagaaaaaadiaaaaaiecaabaaaaaaaaaaadkaabaaaaaaaaaaa
bkiacaaaaaaaaaaaaeaaaaaadcaaaaakicaabaaaaaaaaaaabkiacaaaaaaaaaaa
aeaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaa
ckaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaaaaaaaaakccaabaaaabaaaaaadkiacaiaebaaaaaa
aaaaaaaaaiaaaaaaakiacaaaaaaaaaaaajaaaaaaaoaaaaakccaabaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaabaaaaaaaaaaaaaj
mcaabaaaabaaaaaafgbfbaaaadaaaaaafgincaiaebaaaaaaaaaaaaaaaiaaaaaa
dicaaaahccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaaj
icaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaea
diaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaaaaaaaaakicaabaaa
abaaaaaabkiacaiaebaaaaaaaaaaaaaaaiaaaaaackiacaaaaaaaaaaaaiaaaaaa
aoaaaaakicaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
dkaabaaaabaaaaaadicaaaahecaabaaaabaaaaaadkaabaaaabaaaaaackaabaaa
abaaaaaadcaaaaajicaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaackaabaaa
abaaaaaadcaaaaakccaabaaaabaaaaaadkaabaaaabaaaaaackaabaaaabaaaaaa
bkaabaiaebaaaaaaabaaaaaadiaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaa
bkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaa
abaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaa
aeaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaa
acaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaaaeaaaaaakgbkbaaa
acaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaa
aeaaaaaafgbfbaaaacaaaaaaegacbaaaadaaaaaadiaaaaahhcaabaaaadaaaaaa
kgakbaaaabaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaaggakbaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaaeaaaaaa
egacbaaaaeaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaaeaaaaaa
egacbaaaafaaaaaakgbkbaaaacaaaaaaegacbaaaaeaaaaaaefaaaaajpcaabaaa
afaaaaaacgakbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaj
hcaabaaaaeaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaaaeaaaaaa
dcaaaaajncaabaaaabaaaaaaagajbaaaaeaaaaaaagaabaaaabaaaaaaagajbaaa
adaaaaaaaaaaaaakicaabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaaajaaaaaa
akiacaaaaaaaaaaaakaaaaaaaoaaaaakicaabaaaacaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpdkaabaaaacaaaaaaaaaaaaajdcaabaaaadaaaaaa
fgbfbaaaadaaaaaangifcaiaebaaaaaaaaaaaaaaajaaaaaadicaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaabkaabaaaadaaaaaadcaaaaajccaabaaaadaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaabkaabaaaadaaaaaaaaaaaaakccaabaaaadaaaaaabkiacaia
ebaaaaaaaaaaaaaaajaaaaaackiacaaaaaaaaaaaajaaaaaaaoaaaaakccaabaaa
adaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaadaaaaaa
dicaaaahbcaabaaaadaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaaj
ccaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaea
diaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaak
icaabaaaacaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadkaabaiaebaaaaaa
acaaaaaadiaaaaahbcaabaaaadaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaa
diaaaaahicaabaaaacaaaaaabkaabaaaaaaaaaaadkaabaaaacaaaaaaefaaaaaj
pcaabaaaaeaaaaaaggakbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaaeaaaaaa
diaaaaahocaabaaaadaaaaaaagajbaaaaeaaaaaaagbabaaaacaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaaeaaaaaa
dcaaaaajocaabaaaadaaaaaaagajbaaaaeaaaaaakgbkbaaaacaaaaaafgaobaaa
adaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaaeaaaaaadcaaaaajocaabaaaadaaaaaaagajbaaaaeaaaaaafgbfbaaa
acaaaaaafgaobaaaadaaaaaadcaaaaajncaabaaaabaaaaaafgaobaaaadaaaaaa
agaabaaaadaaaaaaagaobaaaabaaaaaaaaaaaaakbcaabaaaadaaaaaabkiacaia
ebaaaaaaaaaaaaaaakaaaaaackiacaaaaaaaaaaaakaaaaaaaoaaaaakbcaabaaa
adaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaadaaaaaa
aaaaaaajccaabaaaadaaaaaabkbabaaaadaaaaaabkiacaiaebaaaaaaaaaaaaaa
akaaaaaadicaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaa
dcaaaaajccaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaa
aaaaeaeadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaa
diaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaadiaaaaah
gcaabaaaaaaaaaaafgagbaaaaaaaaaaaagaabaaaadaaaaaaefaaaaajpcaabaaa
adaaaaaaggakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaagaaaaaadiaaaaah
hcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaagaaaaaaefaaaaaj
pcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaagaaaaaa
dcaaaaajhcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaa
adaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaa
egacbaaaacaaaaaadcaaaaajncaabaaaabaaaaaaagajbaaaacaaaaaakgakbaaa
aaaaaaaaagaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaa
pgipcaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaa
eghobaaaaeaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaa
adaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaa
eghobaaaaeaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaafaaaaaacgakbaaa
acaaaaaaeghobaaaaeaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaa
acaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaadcaaaaaj
ncaabaaaabaaaaaaagajbaaaacaaaaaaagaabaaaaaaaaaaaagaobaaaabaaaaaa
diaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaahaaaaaa
efaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaafaaaaaaaagabaaa
adaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaa
efaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaafaaaaaaaagabaaa
adaaaaaaefaaaaajpcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaafaaaaaa
aagabaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaa
acaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaa
fgbfbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
acaaaaaafgafbaaaabaaaaaaigadbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaa
egbcbaaaabaaaaaafgifcaaaaaaaaaaaahaaaaaaefaaaaajpcaabaaaadaaaaaa
ggakbaaaacaaaaaaeghobaaaagaaaaaaaagabaaaafaaaaaadiaaaaahhcaabaaa
adaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaa
egaabaaaacaaaaaaeghobaaaagaaaaaaaagabaaaafaaaaaaefaaaaajpcaabaaa
afaaaaaacgakbaaaacaaaaaaeghobaaaagaaaaaaaagabaaaafaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaa
dcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaa
acaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaapgapbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaakgikcaaa
aaaaaaaaahaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaa
ahaaaaaaaagabaaaahaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaa
agbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaa
ahaaaaaaaagabaaaahaaaaaaefaaaaajpcaabaaaacaaaaaacgakbaaaacaaaaaa
eghobaaaahaaaaaaaagabaaaahaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaa
aeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaacaaaaaafgbfbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaacaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaiaebaaaaaa
aeaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
egbcbaaaaeaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaabaaaaaafgifcaaa
aaaaaaaaafaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaaeghobaaa
aiaaaaaaaagabaaaaiaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
agbabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaa
aiaaaaaaaagabaaaaiaaaaaaefaaaaajpcaabaaaabaaaaaacgakbaaaabaaaaaa
eghobaaaaiaaaaaaaagabaaaaiaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaa
adaaaaaakgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaa
egacbaaaabaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaakicaabaaa
aaaaaaaackiacaiaebaaaaaaaaaaaaaaafaaaaaadkiacaaaaaaaaaaaafaaaaaa
aoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
dkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaackbabaaaadaaaaaackiacaia
ebaaaaaaaaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakbabaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaabbaaaaahicaabaaaaaaaaaaaegbobaaa
ahaaaaaaegbobaaaahaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
dccaaaalicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaaanaaaaaa
dkiacaaaaaaaaaaaanaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaagaaaaaa
eghobaaaalaaaaaaaagabaaaalaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaagaaaaaaeghobaaa
akaaaaaaaagabaaaakaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaacaaaaaa
abeaaaaaaaaaaaebdcaaaaakhcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaa
acaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaaoaaaaahdcaabaaaacaaaaaa
egbabaaaafaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaa
acaaaaaaeghobaaaajaaaaaaaagabaaaajaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaagiccabaaaaaaaaaaadkiacaaaaaaaaaaa
akaaaaaadoaaaaab"
				}
				SubProgram "opengl " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
						"HDR_LIGHT_PREPASS_ON"
					}
					Float 0[_texTiling]
					Float 1[_texPower]
					Float 2[_groundTexStart]
					Float 3[_groundTexEnd]
					Float 4[_steepTiling]
					Float 5[_steepTexStart]
					Float 6[_steepTexEnd]
					Float 7[_multiPower]
					Float 8[_deepMultiFactor]
					Float 9[_mainMultiFactor]
					Float 10[_highMultiFactor]
					Float 11[_snowMultiFactor]
					Float 12[_deepStart]
					Float 13[_deepEnd]
					Float 14[_mainLoStart]
					Float 15[_mainLoEnd]
					Float 16[_mainHiStart]
					Float 17[_mainHiEnd]
					Float 18[_hiLoStart]
					Float 19[_hiLoEnd]
					Float 20[_hiHiStart]
					Float 21[_hiHiEnd]
					Float 22[_snowStart]
					Float 23[_snowEnd]
					Float 24[_PlanetOpacity]
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 1
					SetTexture 2[_highTex] 2D 2
					SetTexture 3[_snowTex] 2D 3
					SetTexture 4[_deepMultiTex] 2D 4
					SetTexture 5[_mainMultiTex] 2D 5
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[_LightBuffer] 2D 9
					SetTexture 10[unity_Lightmap] 2D 10
					SetTexture 11[unity_LightmapInd] 2D 11 "3.0-!!ARBfp1.0
PARAM c[27] = { program.local[0..24],
		{ 2, 3, 1, 0.57735026 },
		{ 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.x, c[2];
ADD R0.x, -R0, c[3];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].z, -c[2];
MUL_SAT R0.w, R0.x, R0.y;
MUL R3.xyz, fragment.texcoord[0], c[0].x;
MAD R1.x, -R0.w, c[25], c[25].y;
MUL R0.w, R0, R0;
MOV R2.w, c[12].x;
ADD R2.w, -R2, c[13].x;
RCP R4.x, R2.w;
ADD R2.w, fragment.texcoord[2].y, -c[12].x;
MUL_SAT R2.w, R2, R4.x;
TEX R0.xyz, R3.zyzw, texture[1], 2D;
MUL R0.w, R0, R1.x;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[1], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R0, R1;
ADD R0.x, -R0.w, c[25].z;
MOV R0.z, c[16].x;
ADD R0.z, -R0, c[17].x;
RCP R1.w, R0.z;
ADD R0.z, fragment.texcoord[2].y, -c[16].x;
MUL_SAT R1.w, R0.z, R1;
MOV R0.y, c[14].x;
ADD R0.y, -R0, c[15].x;
RCP R0.z, R0.y;
ADD R0.y, fragment.texcoord[2], -c[14].x;
MUL_SAT R0.y, R0, R0.z;
MUL R0.w, R0, c[7].x;
MAD R2.x, -R1.w, c[25], c[25].y;
MUL R0.z, R1.w, R1.w;
MUL R1.w, R0.z, R2.x;
MUL R0.z, R0.y, R0.y;
MAD R0.y, -R0, c[25].x, c[25];
MAD R3.w, R0.z, R0.y, -R1;
MUL R1.w, R0.x, c[1].x;
MUL R2.x, R1.w, R3.w;
TEX R0.xyz, R3.zxzw, texture[1], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R0, R1;
MUL R1.xyz, R0, R2.x;
TEX R2.xyz, R3.zyzw, texture[0], 2D;
TEX R0.xyz, R3, texture[0], 2D;
MUL R2.xyz, fragment.texcoord[1].x, R2;
MAD R2.xyz, fragment.texcoord[1].z, R0, R2;
MAD R0.y, -R2.w, c[25].x, c[25];
MUL R0.x, R2.w, R2.w;
MAD R4.x, -R0, R0.y, c[25].z;
TEX R0.xyz, R3.zxzw, texture[0], 2D;
MUL R2.w, R1, R4.x;
MAD R2.xyz, fragment.texcoord[1].y, R0, R2;
TEX R0.xyz, R3.zyzw, texture[2], 2D;
MAD R2.xyz, R2, R2.w, R1;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[2], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R0, R1;
MOV R0.y, c[20].x;
ADD R0.y, -R0, c[21].x;
RCP R0.z, R0.y;
ADD R0.y, fragment.texcoord[2], -c[20].x;
MUL_SAT R0.z, R0.y, R0;
MOV R0.x, c[18];
ADD R0.x, -R0, c[19];
RCP R0.y, R0.x;
ADD R0.x, fragment.texcoord[2].y, -c[18];
MUL_SAT R0.x, R0, R0.y;
MAD R2.w, -R0.z, c[25].x, c[25].y;
MUL R0.y, R0.z, R0.z;
MUL R0.z, R0.y, R2.w;
MUL R0.y, R0.x, R0.x;
MAD R0.x, -R0, c[25], c[25].y;
MAD R2.w, R0.y, R0.x, -R0.z;
TEX R0.xyz, R3.zxzw, texture[2], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R0, R1;
MUL R1.x, R1.w, R2.w;
MAD R2.xyz, R0, R1.x, R2;
TEX R1.xyz, R3.zyzw, texture[3], 2D;
TEX R0.xyz, R3, texture[3], 2D;
MUL R1.xyz, fragment.texcoord[1].x, R1;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[3], 2D;
MOV R3.y, c[22].x;
ADD R3.y, -R3, c[23].x;
MAD R1.xyz, fragment.texcoord[1].y, R1, R0;
RCP R3.y, R3.y;
ADD R3.x, fragment.texcoord[2].y, -c[22];
MUL_SAT R3.x, R3, R3.y;
MAD R0.y, -R3.x, c[25].x, c[25];
MUL R0.x, R3, R3;
MUL R4.y, R0.x, R0;
MUL R3.xyz, fragment.texcoord[0], c[8].x;
MUL R4.z, R1.w, R4.y;
TEX R0.xyz, R3.zyzw, texture[4], 2D;
MAD R2.xyz, R1, R4.z, R2;
MUL R1.xyz, fragment.texcoord[1].x, R0;
TEX R0.xyz, R3, texture[4], 2D;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
TEX R1.xyz, R3.zxzw, texture[4], 2D;
MAD R0.xyz, fragment.texcoord[1].y, R1, R0;
MUL R1.xyz, fragment.texcoord[0], c[9].x;
MUL R4.x, R0.w, R4;
MAD R0.xyz, R0, R4.x, R2;
TEX R3.xyz, R1.zyzw, texture[5], 2D;
TEX R2.xyz, R1, texture[5], 2D;
MUL R3.xyz, fragment.texcoord[1].x, R3;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[5], 2D;
MAD R3.xyz, fragment.texcoord[1].y, R1, R2;
MUL R1.xyz, fragment.texcoord[0], c[10].x;
MUL R3.w, R0, R3;
TEX R2.xyz, R1.zyzw, texture[6], 2D;
MAD R0.xyz, R3, R3.w, R0;
MUL R3.xyz, fragment.texcoord[1].x, R2;
TEX R2.xyz, R1, texture[6], 2D;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[6], 2D;
MAD R3.xyz, fragment.texcoord[1].y, R1, R2;
MUL R1.xyz, fragment.texcoord[0], c[11].x;
MUL R2.w, R0, R2;
TEX R2.xyz, R1.zyzw, texture[7], 2D;
MAD R0.xyz, R3, R2.w, R0;
MUL R3.xyz, fragment.texcoord[1].x, R2;
TEX R2.xyz, R1, texture[7], 2D;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
TEX R1.xyz, R1.zxzw, texture[7], 2D;
MAD R1.xyz, fragment.texcoord[1].y, R1, R2;
MUL R2.x, R0.w, R4.y;
MAD R0.xyz, R1, R2.x, R0;
MAD R2.xyz, fragment.texcoord[3], R0, -fragment.texcoord[3];
MUL R0.xyz, fragment.texcoord[0], c[4].x;
ADD R0.w, R1, R0;
TEX R1.xyz, R0.zyzw, texture[8], 2D;
MUL R3.xyz, fragment.texcoord[1].x, R1;
TEX R1.xyz, R0, texture[8], 2D;
MAD R1.xyz, fragment.texcoord[1].z, R1, R3;
TEX R0.xyz, R0.zxzw, texture[8], 2D;
MAD R0.xyz, R0, fragment.texcoord[1].y, R1;
MAD R2.xyz, R0.w, R2, fragment.texcoord[3];
ADD R3.xyz, R0, -R2;
TEX R1, fragment.texcoord[5], texture[11], 2D;
TEX R0, fragment.texcoord[5], texture[10], 2D;
MUL R0.xyz, R0.w, R0;
MUL R1.xyz, R1.w, R1;
MUL R1.xyz, R1, c[25].w;
MOV R0.w, c[5].x;
DP3 R1.x, R1, c[26].x;
MUL R1.xyz, R0, R1.x;
ADD R0.w, -R0, c[6].x;
RCP R0.y, R0.w;
ADD R0.x, fragment.texcoord[2].z, -c[5];
MUL_SAT R0.w, R0.x, R0.y;
MAD R1.w, -R0, c[25].x, c[25].y;
TXP R0.xyz, fragment.texcoord[4], texture[9], 2D;
MUL R0.w, R0, R0;
MAD R0.w, -R0, R1, c[25].z;
MAD R0.xyz, R1, c[26].x, R0;
MUL R0.w, fragment.texcoord[2].x, R0;
MAD R1.xyz, R0.w, R3, R2;
MUL result.color.xyz, R1, R0;
MOV result.color.w, c[24].x;
END
# 160 instructions, 5 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
						"HDR_LIGHT_PREPASS_ON"
					}
					Float 0[_texTiling]
					Float 1[_texPower]
					Float 2[_groundTexStart]
					Float 3[_groundTexEnd]
					Float 4[_steepTiling]
					Float 5[_steepTexStart]
					Float 6[_steepTexEnd]
					Float 7[_multiPower]
					Float 8[_deepMultiFactor]
					Float 9[_mainMultiFactor]
					Float 10[_highMultiFactor]
					Float 11[_snowMultiFactor]
					Float 12[_deepStart]
					Float 13[_deepEnd]
					Float 14[_mainLoStart]
					Float 15[_mainLoEnd]
					Float 16[_mainHiStart]
					Float 17[_mainHiEnd]
					Float 18[_hiLoStart]
					Float 19[_hiLoEnd]
					Float 20[_hiHiStart]
					Float 21[_hiHiEnd]
					Float 22[_snowStart]
					Float 23[_snowEnd]
					Float 24[_PlanetOpacity]
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 1
					SetTexture 2[_highTex] 2D 2
					SetTexture 3[_snowTex] 2D 3
					SetTexture 4[_deepMultiTex] 2D 4
					SetTexture 5[_mainMultiTex] 2D 5
					SetTexture 6[_highMultiTex] 2D 6
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[_LightBuffer] 2D 9
					SetTexture 10[unity_Lightmap] 2D 10
					SetTexture 11[unity_LightmapInd] 2D 11 "ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
dcl_2d s8
dcl_2d s9
dcl_2d s10
dcl_2d s11
def c25, 2.00000000, 3.00000000, 1.00000000, 0.57735026
def c26, 8.00000000, 0, 0, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4
dcl_texcoord5 v5.xy
mov r0.x, c3
add r0.w, -c2.x, r0.x
mul r0.xyz, v0, c0.x
rcp r1.x, r0.w
texld r3.xyz, r0.zyzw, s0
add r0.w, v2.z, -c2.x
mul_sat r0.w, r0, r1.x
texld r1.xyz, r0.zyzw, s1
mad r1.w, -r0, c25.x, c25.y
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s1
mad r2.xyz, v1.z, r1, r2
mul r0.w, r0, r0
mul r0.w, r0, r1
add r1.x, -r0.w, c25.z
mov r1.z, c17.x
add r1.z, -c16.x, r1
rcp r1.w, r1.z
add r1.z, v2.y, -c16.x
mul_sat r1.w, r1.z, r1
mov r1.y, c15.x
add r1.y, -c14.x, r1
rcp r1.z, r1.y
add r1.y, v2, -c14.x
mul_sat r1.y, r1, r1.z
mul r0.w, r0, c7.x
mad r2.w, -r1, c25.x, c25.y
mul r1.z, r1.w, r1.w
mul r1.w, r1.z, r2
mul r1.z, r1.y, r1.y
mad r1.y, -r1, c25.x, c25
mad r3.w, r1.z, r1.y, -r1
mul r1.w, r1.x, c1.x
mul r2.w, r1, r3
texld r1.xyz, r0.zxzw, s1
mad r1.xyz, v1.y, r1, r2
mul r2.xyz, r1, r2.w
mov r2.w, c13.x
add r2.w, -c12.x, r2
rcp r4.x, r2.w
add r2.w, v2.y, -c12.x
texld r1.xyz, r0, s0
mul r3.xyz, v1.x, r3
mul_sat r2.w, r2, r4.x
mad r3.xyz, v1.z, r1, r3
mad r1.y, -r2.w, c25.x, c25
mul r1.x, r2.w, r2.w
mad r4.x, -r1, r1.y, c25.z
mul r2.w, r1, r4.x
texld r1.xyz, r0.zxzw, s0
mad r3.xyz, v1.y, r1, r3
mad r3.xyz, r3, r2.w, r2
texld r1.xyz, r0.zyzw, s2
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s2
mad r2.xyz, v1.z, r1, r2
mov r1.y, c21.x
add r1.y, -c20.x, r1
rcp r1.z, r1.y
add r1.y, v2, -c20.x
mul_sat r1.z, r1.y, r1
mov r1.x, c19
add r1.x, -c18, r1
rcp r1.y, r1.x
add r1.x, v2.y, -c18
mul_sat r1.x, r1, r1.y
mad r2.w, -r1.z, c25.x, c25.y
mul r1.y, r1.z, r1.z
mul r1.z, r1.y, r2.w
mul r1.y, r1.x, r1.x
mad r1.x, -r1, c25, c25.y
mad r2.w, r1.y, r1.x, -r1.z
texld r1.xyz, r0.zxzw, s2
mad r1.xyz, v1.y, r1, r2
mul r2.x, r1.w, r2.w
mad r2.xyz, r1, r2.x, r3
texld r1.xyz, r0.zyzw, s3
texld r3.xyz, r0, s3
mul r1.xyz, v1.x, r1
mad r1.xyz, v1.z, r3, r1
mov r0.y, c23.x
add r3.x, -c22, r0.y
rcp r3.y, r3.x
add r3.x, v2.y, -c22
texld r0.xyz, r0.zxzw, s3
mul_sat r4.y, r3.x, r3
mad r3.xyz, v1.y, r0, r1
mad r0.y, -r4, c25.x, c25
mul r0.x, r4.y, r4.y
mul r4.y, r0.x, r0
mul r0.xyz, v0, c8.x
mul r4.z, r1.w, r4.y
mad r3.xyz, r3, r4.z, r2
texld r1.xyz, r0.zyzw, s4
mul r2.xyz, v1.x, r1
texld r1.xyz, r0, s4
mad r1.xyz, v1.z, r1, r2
texld r0.xyz, r0.zxzw, s4
mad r1.xyz, v1.y, r0, r1
mul r0.xyz, v0, c9.x
mul r4.x, r0.w, r4
texld r2.xyz, r0.zyzw, s5
mad r1.xyz, r1, r4.x, r3
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s5
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s5
mad r3.xyz, v1.y, r0, r2
mul r0.xyz, v0, c10.x
mul r3.w, r0, r3
texld r2.xyz, r0.zyzw, s6
mad r1.xyz, r3, r3.w, r1
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s6
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s6
mad r3.xyz, v1.y, r0, r2
mul r0.xyz, v0, c11.x
mul r2.w, r0, r2
texld r2.xyz, r0.zyzw, s7
mad r1.xyz, r3, r2.w, r1
mul r3.xyz, v1.x, r2
texld r2.xyz, r0, s7
mad r2.xyz, v1.z, r2, r3
texld r0.xyz, r0.zxzw, s7
mad r0.xyz, v1.y, r0, r2
mul r2.x, r0.w, r4.y
mad r0.xyz, r0, r2.x, r1
mad r2.xyz, v3, r0, -v3
mul r0.xyz, v0, c4.x
add r0.w, r1, r0
texld r1.xyz, r0.zyzw, s8
mul r3.xyz, v1.x, r1
texld r1.xyz, r0, s8
mad r1.xyz, v1.z, r1, r3
texld r0.xyz, r0.zxzw, s8
mad r0.xyz, r0, v1.y, r1
mad r2.xyz, r0.w, r2, v3
add r3.xyz, r0, -r2
texld r1, v5, s11
texld r0, v5, s10
mul_pp r0.xyz, r0.w, r0
mul_pp r1.xyz, r1.w, r1
mul_pp r1.xyz, r1, c25.w
mov r0.w, c6.x
dp3_pp r1.x, r1, c26.x
mul_pp r1.xyz, r0, r1.x
add r0.w, -c5.x, r0
rcp r0.y, r0.w
add r0.x, v2.z, -c5
mul_sat r0.w, r0.x, r0.y
mad r1.w, -r0, c25.x, c25.y
texldp r0.xyz, v4, s9
mul r0.w, r0, r0
mad r0.w, -r0, r1, c25.z
mad_pp r0.xyz, r1, c26.x, r0
mul r0.w, v2.x, r0
mad r1.xyz, r0.w, r3, r2
mul_pp oC0.xyz, r1, r0
mov_pp oC0.w, c24.x
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
						"HDR_LIGHT_PREPASS_ON"
					}
					SetTexture 0[_deepTex] 2D 0
					SetTexture 1[_mainTex] 2D 2
					SetTexture 2[_highTex] 2D 4
					SetTexture 3[_snowTex] 2D 6
					SetTexture 4[_deepMultiTex] 2D 1
					SetTexture 5[_mainMultiTex] 2D 3
					SetTexture 6[_highMultiTex] 2D 5
					SetTexture 7[_snowMultiTex] 2D 7
					SetTexture 8[_steepTex] 2D 8
					SetTexture 9[_LightBuffer] 2D 9
					SetTexture 10[unity_Lightmap] 2D 10
					SetTexture 11[unity_LightmapInd] 2D 11
					ConstBuffer "$Globals"
					240
					Float 64[_texTiling]
					Float 68[_texPower]
					Float 72[_groundTexStart]
					Float 76[_groundTexEnd]
					Float 84[_steepTiling]
					Float 88[_steepTexStart]
					Float 92[_steepTexEnd]
					Float 104[_multiPower]
					Float 108[_deepMultiFactor]
					Float 112[_mainMultiFactor]
					Float 116[_highMultiFactor]
					Float 120[_snowMultiFactor]
					Float 124[_deepStart]
					Float 128[_deepEnd]
					Float 132[_mainLoStart]
					Float 136[_mainLoEnd]
					Float 140[_mainHiStart]
					Float 144[_mainHiEnd]
					Float 148[_hiLoStart]
					Float 152[_hiLoEnd]
					Float 156[_hiHiStart]
					Float 160[_hiHiEnd]
					Float 164[_snowStart]
					Float 168[_snowEnd]
					Float 172[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedibikoboidngljpgacfheonbhmnpcjllhabaaaaaaoibgaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefclabfaaaaeaaaaaaagmafaaaa
fjaaaaaeegiocaaaaaaaaaaaalaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaa
agaaaaaafkaaaaadaagabaaaahaaaaaafkaaaaadaagabaaaaiaaaaaafkaaaaad
aagabaaaajaaaaaafkaaaaadaagabaaaakaaaaaafkaaaaadaagabaaaalaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
fibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaa
fibiaaaeaahabaaaagaaaaaaffffaaaafibiaaaeaahabaaaahaaaaaaffffaaaa
fibiaaaeaahabaaaaiaaaaaaffffaaaafibiaaaeaahabaaaajaaaaaaffffaaaa
fibiaaaeaahabaaaakaaaaaaffffaaaafibiaaaeaahabaaaalaaaaaaffffaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadlcbabaaaafaaaaaagcbaaaad
dcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaaaaaaaaak
bcaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaaahaaaaaaakiacaaaaaaaaaaa
aiaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpakaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaabkbabaaaadaaaaaa
dkiacaiaebaaaaaaaaaaaaaaahaaaaaadicaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaakccaabaaaaaaaaaaa
ckiacaiaebaaaaaaaaaaaaaaaeaaaaaadkiacaaaaaaaaaaaaeaaaaaaaoaaaaak
ccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaa
aaaaaaaaaaaaaaajecaabaaaaaaaaaaackbabaaaadaaaaaackiacaiaebaaaaaa
aaaaaaaaaeaaaaaadicaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaa
aaaaaaaadcaaaaakicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaackiacaaa
aaaaaaaaagaaaaaadiaaaaaiecaabaaaaaaaaaaadkaabaaaaaaaaaaabkiacaaa
aaaaaaaaaeaaaaaadcaaaaakicaabaaaaaaaaaaabkiacaaaaaaaaaaaaeaaaaaa
dkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaackaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaaaaaaaaakccaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaa
aiaaaaaaakiacaaaaaaaaaaaajaaaaaaaoaaaaakccaabaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaabaaaaaaaaaaaaajmcaabaaa
abaaaaaafgbfbaaaadaaaaaafgincaiaebaaaaaaaaaaaaaaaiaaaaaadicaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaajicaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaaaaaaaaakicaabaaaabaaaaaa
bkiacaiaebaaaaaaaaaaaaaaaiaaaaaackiacaaaaaaaaaaaaiaaaaaaaoaaaaak
icaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaa
abaaaaaadicaaaahecaabaaaabaaaaaadkaabaaaabaaaaaackaabaaaabaaaaaa
dcaaaaajicaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
aaaaeaeadiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaackaabaaaabaaaaaa
dcaaaaakccaabaaaabaaaaaadkaabaaaabaaaaaackaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaadiaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaabkaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaaabaaaaaa
diaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaaeaaaaaa
efaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaa
efaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaa
egacbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaaaeaaaaaa
fgbfbaaaacaaaaaaegacbaaaadaaaaaadiaaaaahhcaabaaaadaaaaaakgakbaaa
abaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaaggakbaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaaeaaaaaaegacbaaa
aeaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaaeaaaaaaegacbaaa
afaaaaaakgbkbaaaacaaaaaaegacbaaaaeaaaaaaefaaaaajpcaabaaaafaaaaaa
cgakbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaa
aeaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaaaeaaaaaadcaaaaaj
ncaabaaaabaaaaaaagajbaaaaeaaaaaaagaabaaaabaaaaaaagajbaaaadaaaaaa
aaaaaaakicaabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaaajaaaaaaakiacaaa
aaaaaaaaakaaaaaaaoaaaaakicaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpdkaabaaaacaaaaaaaaaaaaajdcaabaaaadaaaaaafgbfbaaa
adaaaaaangifcaiaebaaaaaaaaaaaaaaajaaaaaadicaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaabkaabaaaadaaaaaadcaaaaajccaabaaaadaaaaaadkaabaaa
acaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaa
acaaaaaabkaabaaaadaaaaaaaaaaaaakccaabaaaadaaaaaabkiacaiaebaaaaaa
aaaaaaaaajaaaaaackiacaaaaaaaaaaaajaaaaaaaoaaaaakccaabaaaadaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaadaaaaaadicaaaah
bcaabaaaadaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaajccaabaaa
adaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaah
bcaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaakicaabaaa
acaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadkaabaiaebaaaaaaacaaaaaa
diaaaaahbcaabaaaadaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaadiaaaaah
icaabaaaacaaaaaabkaabaaaaaaaaaaadkaabaaaacaaaaaaefaaaaajpcaabaaa
aeaaaaaaggakbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaaeaaaaaadiaaaaah
ocaabaaaadaaaaaaagajbaaaaeaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaaeaaaaaadcaaaaaj
ocaabaaaadaaaaaaagajbaaaaeaaaaaakgbkbaaaacaaaaaafgaobaaaadaaaaaa
efaaaaajpcaabaaaaeaaaaaacgakbaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
aeaaaaaadcaaaaajocaabaaaadaaaaaaagajbaaaaeaaaaaafgbfbaaaacaaaaaa
fgaobaaaadaaaaaadcaaaaajncaabaaaabaaaaaafgaobaaaadaaaaaaagaabaaa
adaaaaaaagaobaaaabaaaaaaaaaaaaakbcaabaaaadaaaaaabkiacaiaebaaaaaa
aaaaaaaaakaaaaaackiacaaaaaaaaaaaakaaaaaaaoaaaaakbcaabaaaadaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaadaaaaaaaaaaaaaj
ccaabaaaadaaaaaabkbabaaaadaaaaaabkiacaiaebaaaaaaaaaaaaaaakaaaaaa
dicaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaadcaaaaaj
ccaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaea
diaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaadiaaaaah
bcaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaadiaaaaahgcaabaaa
aaaaaaaafgagbaaaaaaaaaaaagaabaaaadaaaaaaefaaaaajpcaabaaaadaaaaaa
ggakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaagaaaaaadiaaaaahhcaabaaa
adaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaa
egaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaagaaaaaaefaaaaajpcaabaaa
afaaaaaacgakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaagaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaa
dcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaa
acaaaaaadcaaaaajncaabaaaabaaaaaaagajbaaaacaaaaaakgakbaaaaaaaaaaa
agaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaapgipcaaa
aaaaaaaaagaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaa
aeaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaa
agbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaa
aeaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaafaaaaaacgakbaaaacaaaaaa
eghobaaaaeaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaa
aeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajncaabaaa
abaaaaaaagajbaaaacaaaaaaagaabaaaaaaaaaaaagaobaaaabaaaaaadiaaaaai
hcaabaaaacaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaahaaaaaaefaaaaaj
pcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaafaaaaaaaagabaaaadaaaaaa
diaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaafaaaaaaaagabaaaadaaaaaa
efaaaaajpcaabaaaafaaaaaacgakbaaaacaaaaaaeghobaaaafaaaaaaaagabaaa
adaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaa
egacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaa
acaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaa
fgafbaaaabaaaaaaigadbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaa
abaaaaaafgifcaaaaaaaaaaaahaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaa
acaaaaaaeghobaaaagaaaaaaaagabaaaafaaaaaadiaaaaahhcaabaaaadaaaaaa
egacbaaaadaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
acaaaaaaeghobaaaagaaaaaaaagabaaaafaaaaaaefaaaaajpcaabaaaafaaaaaa
cgakbaaaacaaaaaaeghobaaaagaaaaaaaagabaaaafaaaaaadcaaaaajhcaabaaa
acaaaaaaegacbaaaaeaaaaaakgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaafaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaa
dcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaapgapbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaabaaaaaakgikcaaaaaaaaaaa
ahaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaacaaaaaaeghobaaaahaaaaaa
aagabaaaahaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaagbabaaa
acaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaahaaaaaa
aagabaaaahaaaaaaefaaaaajpcaabaaaacaaaaaacgakbaaaacaaaaaaeghobaaa
ahaaaaaaaagabaaaahaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaaaeaaaaaa
kgbkbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaa
acaaaaaafgbfbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaacaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaiaebaaaaaaaeaaaaaa
dcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaa
aeaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaabaaaaaafgifcaaaaaaaaaaa
afaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaaeghobaaaaiaaaaaa
aagabaaaaiaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaagbabaaa
acaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaaaiaaaaaa
aagabaaaaiaaaaaaefaaaaajpcaabaaaabaaaaaacgakbaaaabaaaaaaeghobaaa
aiaaaaaaaagabaaaaiaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaadaaaaaa
kgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
abaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaaabaaaaaa
egacbaiaebaaaaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaakicaabaaaaaaaaaaa
ckiacaiaebaaaaaaaaaaaaaaafaaaaaadkiacaaaaaaaaaaaafaaaaaaaoaaaaak
icaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaa
aaaaaaaaaaaaaaajicaabaaaabaaaaaackbabaaaadaaaaaackiacaiaebaaaaaa
aaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akbabaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaagaaaaaa
eghobaaaalaaaaaaaagabaaaalaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaaaaaaaaabaaaaaakicaabaaaaaaaaaaaaceaaaaadkmnbddpdkmnbddp
dkmnbddpaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
agaaaaaaeghobaaaakaaaaaaaagabaaaakaaaaaadiaaaaahicaabaaaabaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaapgapbaaaabaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaaafaaaaaa
pgbpbaaaafaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaa
ajaaaaaaaagabaaaajaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaagiccabaaaaaaaaaaadkiacaaaaaaaaaaa
akaaaaaadoaaaaab"
				}
			}
		}
	}
	Fallback "Diffuse"
}