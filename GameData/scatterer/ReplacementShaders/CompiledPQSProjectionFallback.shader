Shader "Scatterer/PQS/Sphere Projection SURFACE QUAD (Fallback) " {
	Properties {
		_saturation("Saturation", Float) = 1
		_contrast("Contrast", Float) = 1
		_tintColor("Colour Unsaturation (A = Factor)", Color) = (1, 1, 1, 0)
		_texTiling("Near Tiling", Float) = 1000
		_texPower("Near Blend", Float) = 0.5
		_multiPower("Far Blend", Float) = 0.5
		_groundTexStart("NearFar Start", Float) = 2000
		_groundTexEnd("NearFar Start", Float) = 10000
		_multiFactor("Multifactor", Float) = 0.5
		_mainTex("Main Texture", 2D) = "white" {}
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
					Matrix 9[_Object2World]
					Vector 13[unity_SHAr]
					Vector 14[unity_SHAg]
					Vector 15[unity_SHAb]
					Vector 16[unity_SHBr]
					Vector 17[unity_SHBg]
					Vector 18[unity_SHBb]
					Vector 19[unity_SHC]
					Vector 20[unity_Scale]
					Vector 21[_tintColor]
					Float 22[_groundTexStart]
					Float 23[_groundTexEnd]
					Float 24[_saturation]
					Float 25[_contrast]
					"!!ARBvp1.0
PARAM c[27] = { { 0, 1, 3, 2 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..25],
		{ 0.29899999, 0.58700001, 0.114 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[20].w;
DP3 R3.w, R1, c[10];
DP3 R2.w, R1, c[11];
DP3 R0.x, R1, c[9];
MOV R0.y, R3.w;
MOV R0.z, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].y;
DP4 R2.z, R0, c[15];
DP4 R2.y, R0, c[14];
DP4 R2.x, R0, c[13];
MUL R0.y, R3.w, R3.w;
MAD R0.z, R0.x, R0.x, -R0.y;
DP3 R0.y, vertex.color, c[26];
DP4 R3.z, R1, c[18];
DP4 R3.y, R1, c[17];
DP4 R3.x, R1, c[16];
ADD R3.xyz, R2, R3;
MUL R2.xyz, R0.z, c[19];
MOV R0.z, c[22].x;
ADD R0.w, -R0.z, c[23].x;
DP4 R0.z, vertex.position, c[3];
ADD R1.xyz, vertex.color, -R0.y;
ADD result.texcoord[5].xyz, R3, R2;
MAD R2.xyz, R1, c[24].x, R0.y;
MUL R1.xyz, c[21], c[21].w;
MAD R2.xyz, -c[21], c[21].w, R2;
MAD result.texcoord[3].xyz, R2, c[25].x, R1;
MOV R1.z, vertex.texcoord[1].x;
MOV R1.xy, vertex.texcoord[0];
DP3 R0.y, R1, R1;
RSQ R0.y, R0.y;
MUL R1.xyz, R0.y, R1;
RCP R0.w, R0.w;
ADD R0.z, -R0, -c[22].x;
MUL R0.z, R0, R0.w;
MIN R0.y, R0.z, c[0];
MAX R0.y, R0, c[0].x;
MAD R0.z, -R0.y, c[0].w, c[0];
MUL R0.y, R0, R0;
MOV result.texcoord[0].xyz, R1;
ABS result.texcoord[1].xyz, R1;
MUL result.texcoord[2].y, R0, R0.z;
MOV result.texcoord[4].z, R2.w;
MOV result.texcoord[4].y, R3.w;
MOV result.texcoord[4].x, R0;
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
MOV result.texcoord[2].x, vertex.color.w;
END
# 51 instructions, 4 R-regs
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
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 8[_Object2World]
					Vector 12[unity_SHAr]
					Vector 13[unity_SHAg]
					Vector 14[unity_SHAb]
					Vector 15[unity_SHBr]
					Vector 16[unity_SHBg]
					Vector 17[unity_SHBb]
					Vector 18[unity_SHC]
					Vector 19[unity_Scale]
					Vector 20[_tintColor]
					Float 21[_groundTexStart]
					Float 22[_groundTexEnd]
					Float 23[_saturation]
					Float 24[_contrast]
					"vs_2_0
def c25, 1.00000000, 0.00000000, 2.00000000, 3.00000000
def c26, 0.29899999, 0.58700001, 0.11400000, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
dcl_color0 v4
mul r1.xyz, v1, c19.w
dp3 r3.w, r1, c9
dp3 r2.w, r1, c10
dp3 r0.x, r1, c8
mov r0.y, r3.w
mov r0.z, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c25.x
dp4 r2.z, r0, c14
dp4 r2.y, r0, c13
dp4 r2.x, r0, c12
mul r0.y, r3.w, r3.w
mad r0.z, r0.x, r0.x, -r0.y
dp3 r0.y, v4, c26
dp4 r3.z, r1, c17
dp4 r3.y, r1, c16
dp4 r3.x, r1, c15
add r3.xyz, r2, r3
mul r2.xyz, r0.z, c18
mov r0.z, c22.x
add r0.w, -c21.x, r0.z
dp4 r0.z, v0, c2
add r1.xyz, v4, -r0.y
add oT5.xyz, r3, r2
mad r2.xyz, r1, c23.x, r0.y
mul r1.xyz, c20, c20.w
mad r2.xyz, -c20, c20.w, r2
mad oT3.xyz, r2, c24.x, r1
mov r1.z, v3.x
mov r1.xy, v2
dp3 r0.y, r1, r1
rsq r0.y, r0.y
mul r1.xyz, r0.y, r1
rcp r0.w, r0.w
add r0.z, -r0, -c21.x
mul r0.z, r0, r0.w
min r0.y, r0.z, c25.x
max r0.y, r0, c25
mad r0.z, -r0.y, c25, c25.w
mul r0.y, r0, r0
mov oT0.xyz, r1
abs oT1.xyz, r1
mul oT2.y, r0, r0.z
mov oT4.z, r2.w
mov oT4.y, r3.w
mov oT4.x, r0
dp4 oPos.w, v0, c7
dp4 oPos.z, v0, c6
dp4 oPos.y, v0, c5
dp4 oPos.x, v0, c4
mov oT2.x, v4.w
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
					160
					Vector 48[_tintColor]
					Float 72[_groundTexStart]
					Float 76[_groundTexEnd]
					Float 136[_saturation]
					Float 140[_contrast]
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
					BindCB "UnityLighting"
					1
					BindCB "UnityPerDraw"
					2 "vs_4_0
eefiecedfhbpggdgdaojfggbcjpngiallnjihhimabaaaaaaiaaiaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcleagaaaaeaaaabaaknabaaaafjaaaaaeegiocaaaaaaaaaaa
ajaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaadbcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaacaeaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaa
aaaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaaaaaaaaa
dgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaa
dkbabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaakbcaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaaaaaaaaakccaabaaa
aaaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaadkiacaaaaaaaaaaaaeaaaaaa
aoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
bkaabaaaaaaaaaaadicaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahcccabaaaadaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
dgaaaaafbccabaaaadaaaaaadkbabaaaafaaaaaabaaaaaakbcaabaaaaaaaaaaa
egbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaaaaaaaaai
ocaabaaaaaaaaaaaagaabaiaebaaaaaaaaaaaaaaagbjbaaaafaaaaaadcaaaaak
hcaabaaaaaaaaaaakgikcaaaaaaaaaaaaiaaaaaajgahbaaaaaaaaaaaagaabaaa
aaaaaaaadcaaaaamhcaabaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaadaaaaaa
pgipcaaaaaaaaaaaadaaaaaaegacbaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaa
pgipcaaaaaaaaaaaadaaaaaaegiccaaaaaaaaaaaadaaaaaadcaaaaakhccabaaa
aeaaaaaapgipcaaaaaaaaaaaaiaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaaaaaaaaaa
egaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaa
aaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaa
abaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaa
abaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaa
abaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaa
acaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaa
egiocaaaabaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaa
egiocaaaabaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaa
egiocaaaabaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadcaaaaakhccabaaaagaaaaaa
egiccaaaabaaaaaacmaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab
"
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
					160
					Vector 48[_tintColor]
					Float 72[_groundTexStart]
					Float 76[_groundTexEnd]
					Float 136[_saturation]
					Float 140[_contrast]
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
					BindCB "UnityLighting"
					1
					BindCB "UnityPerDraw"
					2 "vs_4_0_level_9_1
eefiecednbonmbfomckofkiddokcbgmmfpplnpedabaaaaaaheamaaaaaeaaaaaa
daaaaaaacaaeaaaanmakaaaakealaaaaebgpgodjoiadaaaaoiadaaaaaaacpopp
hiadaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
acaaabaaaaaaaaaaaaaaaiaaabaaadaaaaaaaaaaabaacgaaahaaaeaaaaaaaaaa
acaaaaaaaiaaalaaaaaaaaaaacaaamaaadaabdaaaaaaaaaaacaabeaaabaabgaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbhaaapkaaaaaaaaaaaaaiadpaaaaaama
aaaaeaeafbaaaaafbiaaapkaihbgjjdokcefbgdpnfhiojdnaaaaaaaabpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapja
bpaaaaacafaaaeiaaeaaapjabpaaaaacafaaafiaafaaapjaabaaaaacaaaaadia
adaaoejaabaaaaacaaaaaeiaaeaaaajaceaaaaacabaaahiaaaaaoeiacdaaaaac
abaaahoaabaaoeiaabaaaaacaaaaahoaabaaoeiaafaaaaadaaaaabiaaaaaffja
baaakkkaaeaaaaaeaaaaabiaapaakkkaaaaaaajaaaaaaaiaaeaaaaaeaaaaabia
bbaakkkaaaaakkjaaaaaaaiaaeaaaaaeaaaaabiabcaakkkaaaaappjaaaaaaaia
acaaaaadaaaaabiaaaaaaaibacaakkkbacaaaaadaaaaaciaacaakkkbacaappka
agaaaaacaaaaaciaaaaaffiaafaaaaadaaaaabiaaaaaffiaaaaaaaiaalaaaaad
aaaaabiaaaaaaaiabhaaaakaakaaaaadaaaaabiaaaaaaaiabhaaffkaaeaaaaae
aaaaaciaaaaaaaiabhaakkkabhaappkaafaaaaadaaaaabiaaaaaaaiaaaaaaaia
afaaaaadacaaacoaaaaaaaiaaaaaffiaaiaaaaadaaaaabiaafaaoejabiaaoeka
bcaaaaaeabaaahiaadaakkkaafaaoejaaaaaaaiaaeaaaaaeaaaaahiaabaaoeka
abaappkbabaaoeiaafaaaaadabaaahiaabaappkaabaaoekaaeaaaaaeadaaahoa
adaappkaaaaaoeiaabaaoeiaafaaaaadaaaaahiaacaaoejabgaappkaafaaaaad
abaaahiaaaaaffiabeaaoekaaeaaaaaeaaaaaliabdaakekaaaaaaaiaabaakeia
aeaaaaaeaaaaahiabfaaoekaaaaakkiaaaaapeiaabaaaaacaaaaaiiabhaaffka
ajaaaaadabaaabiaaeaaoekaaaaaoeiaajaaaaadabaaaciaafaaoekaaaaaoeia
ajaaaaadabaaaeiaagaaoekaaaaaoeiaafaaaaadacaaapiaaaaacjiaaaaakeia
ajaaaaadadaaabiaahaaoekaacaaoeiaajaaaaadadaaaciaaiaaoekaacaaoeia
ajaaaaadadaaaeiaajaaoekaacaaoeiaacaaaaadabaaahiaabaaoeiaadaaoeia
afaaaaadaaaaaiiaaaaaffiaaaaaffiaaeaaaaaeaaaaaiiaaaaaaaiaaaaaaaia
aaaappibabaaaaacaeaaahoaaaaaoeiaaeaaaaaeafaaahoaakaaoekaaaaappia
abaaoeiaafaaaaadaaaaapiaaaaaffjaamaaoekaaeaaaaaeaaaaapiaalaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaanaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiaaoaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoeka
aaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacacaaaboaafaappjappppaaaa
fdeieefcleagaaaaeaaaabaaknabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
fjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaadbcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaacaeaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaaaaaaaaaa
egbabaaaadaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaaaaaaaaadgaaaaag
hccabaaaacaaaaaaegacbaiaibaaaaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaaaaaaaaakbcaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaaaaaaaaakccaabaaaaaaaaaaa
ckiacaiaebaaaaaaaaaaaaaaaeaaaaaadkiacaaaaaaaaaaaaeaaaaaaaoaaaaak
ccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaa
aaaaaaaadicaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaajccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaa
aaaaeaeadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahcccabaaaadaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadgaaaaaf
bccabaaaadaaaaaadkbabaaaafaaaaaabaaaaaakbcaabaaaaaaaaaaaegbcbaaa
afaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaaaaaaaaaiocaabaaa
aaaaaaaaagaabaiaebaaaaaaaaaaaaaaagbjbaaaafaaaaaadcaaaaakhcaabaaa
aaaaaaaakgikcaaaaaaaaaaaaiaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaa
dcaaaaamhcaabaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaadaaaaaapgipcaaa
aaaaaaaaadaaaaaaegacbaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaapgipcaaa
aaaaaaaaadaaaaaaegiccaaaaaaaaaaaadaaaaaadcaaaaakhccabaaaaeaaaaaa
pgipcaaaaaaaaaaaaiaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
hcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaak
lcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaa
aaaaaaaaegadbaaaaaaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaaaaaaaaaa
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
abaaaaaacmaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheo
maaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apabaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
ahaiaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaiaaaafdfgfpfa
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
					Bind "color"
					Color
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					Vector 13[_tintColor]
					Float 14[_groundTexStart]
					Float 15[_groundTexEnd]
					Float 16[_saturation]
					Float 17[_contrast]
					Vector 18[unity_LightmapST]
					"!!ARBvp1.0
PARAM c[20] = { { 0, 1, 3, 2 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..18],
		{ 0.29899999, 0.58700001, 0.114 } };
TEMP R0;
TEMP R1;
DP3 R0.x, vertex.color, c[19];
ADD R1.xyz, vertex.color, -R0.x;
MAD R1.xyz, R1, c[16].x, R0.x;
MAD R1.xyz, -c[13], c[13].w, R1;
MUL R0.xyz, c[13], c[13].w;
MAD result.texcoord[3].xyz, R1, c[17].x, R0;
MOV R1.x, c[14];
ADD R1.y, -R1.x, c[15].x;
DP4 R1.x, vertex.position, c[3];
MOV R0.z, vertex.texcoord[1].x;
MOV R0.xy, vertex.texcoord[0];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
MOV result.texcoord[0].xyz, R0;
ABS result.texcoord[1].xyz, R0;
RCP R1.y, R1.y;
ADD R1.x, -R1, -c[14];
MUL R1.x, R1, R1.y;
MIN R0.w, R1.x, c[0].y;
MAX R0.w, R0, c[0].x;
MAD R0.y, -R0.w, c[0].w, c[0].z;
MUL R0.x, R0.w, R0.w;
MUL result.texcoord[2].y, R0.x, R0;
MAD result.texcoord[4].xy, vertex.texcoord[1], c[18], c[18].zwzw;
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
MOV result.texcoord[2].x, vertex.color.w;
END
# 30 instructions, 2 R-regs
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
					Vector 12[_tintColor]
					Float 13[_groundTexStart]
					Float 14[_groundTexEnd]
					Float 15[_saturation]
					Float 16[_contrast]
					Vector 17[unity_LightmapST]
					"vs_2_0
def c18, 1.00000000, 0.00000000, 2.00000000, 3.00000000
def c19, 0.29899999, 0.58700001, 0.11400000, 0
dcl_position0 v0
dcl_texcoord0 v2
dcl_texcoord1 v3
dcl_color0 v4
dp3 r0.x, v4, c19
add r1.xyz, v4, -r0.x
mad r1.xyz, r1, c15.x, r0.x
mad r1.xyz, -c12, c12.w, r1
mul r0.xyz, c12, c12.w
mad oT3.xyz, r1, c16.x, r0
mov r1.x, c14
add r1.y, -c13.x, r1.x
dp4 r1.x, v0, c2
mov r0.z, v3.x
mov r0.xy, v2
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov oT0.xyz, r0
abs oT1.xyz, r0
rcp r1.y, r1.y
add r1.x, -r1, -c13
mul r1.x, r1, r1.y
min r0.w, r1.x, c18.x
max r0.w, r0, c18.y
mad r0.y, -r0.w, c18.z, c18.w
mul r0.x, r0.w, r0.w
mul oT2.y, r0.x, r0
mad oT4.xy, v3, c17, c17.zwzw
dp4 oPos.w, v0, c7
dp4 oPos.z, v0, c6
dp4 oPos.y, v0, c5
dp4 oPos.x, v0, c4
mov oT2.x, v4.w
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
					176
					Vector 48[_tintColor]
					Float 72[_groundTexStart]
					Float 76[_groundTexEnd]
					Float 136[_saturation]
					Float 140[_contrast]
					Vector 160[unity_LightmapST]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					BindCB "$Globals"
					0
					BindCB "UnityPerDraw"
					1 "vs_4_0
eefiecedoknkeefbjbmonghldijmocdkjhhilekfabaaaaaafaagaaaaadaaaaaa
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
adamaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaamadaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcjmaeaaaaeaaaabaachabaaaafjaaaaae
egiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaa
fpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaa
gfaaaaadmccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaa
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
dkbabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaakbcaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaaaaaaaaakccaabaaa
aaaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaadkiacaaaaaaaaaaaaeaaaaaa
aoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
bkaabaaaaaaaaaaadicaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahcccabaaaadaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaalmccabaaaadaaaaaaagbebaaaaeaaaaaaagiecaaaaaaaaaaaakaaaaaa
kgiocaaaaaaaaaaaakaaaaaadgaaaaafbccabaaaadaaaaaadkbabaaaafaaaaaa
baaaaaakbcaabaaaaaaaaaaaegbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdp
nfhiojdnaaaaaaaaaaaaaaaiocaabaaaaaaaaaaaagaabaiaebaaaaaaaaaaaaaa
agbjbaaaafaaaaaadcaaaaakhcaabaaaaaaaaaaakgikcaaaaaaaaaaaaiaaaaaa
jgahbaaaaaaaaaaaagaabaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaaegiccaia
ebaaaaaaaaaaaaaaadaaaaaapgipcaaaaaaaaaaaadaaaaaaegacbaaaaaaaaaaa
diaaaaajhcaabaaaabaaaaaapgipcaaaaaaaaaaaadaaaaaaegiccaaaaaaaaaaa
adaaaaaadcaaaaakhccabaaaaeaaaaaapgipcaaaaaaaaaaaaiaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadoaaaaab"
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
					176
					Vector 48[_tintColor]
					Float 72[_groundTexStart]
					Float 76[_groundTexEnd]
					Float 136[_saturation]
					Float 140[_contrast]
					Vector 160[unity_LightmapST]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					BindCB "$Globals"
					0
					BindCB "UnityPerDraw"
					1 "vs_4_0_level_9_1
eefiecedmoplpbikckkbcfmgglfajfgohggieolcabaaaaaabmajaaaaaeaaaaaa
daaaaaaapiacaaaajmahaaaageaiaaaaebgpgodjmaacaaaamaacaaaaaaacpopp
giacaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaadaa
acaaabaaaaaaaaaaaaaaaiaaabaaadaaaaaaaaaaaaaaakaaabaaaeaaaaaaaaaa
abaaaaaaaiaaafaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafanaaapkaaaaaaaaa
aaaaiadpaaaaaamaaaaaeaeafbaaaaafaoaaapkaihbgjjdokcefbgdpnfhiojdn
aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaadiaadaaapjabpaaaaac
afaaaeiaaeaaapjabpaaaaacafaaafiaafaaapjaabaaaaacaaaaadiaadaaoeja
abaaaaacaaaaaeiaaeaaaajaceaaaaacabaaahiaaaaaoeiacdaaaaacabaaahoa
abaaoeiaabaaaaacaaaaahoaabaaoeiaafaaaaadaaaaabiaaaaaffjaakaakkka
aeaaaaaeaaaaabiaajaakkkaaaaaaajaaaaaaaiaaeaaaaaeaaaaabiaalaakkka
aaaakkjaaaaaaaiaaeaaaaaeaaaaabiaamaakkkaaaaappjaaaaaaaiaacaaaaad
aaaaabiaaaaaaaibacaakkkbacaaaaadaaaaaciaacaakkkbacaappkaagaaaaac
aaaaaciaaaaaffiaafaaaaadaaaaabiaaaaaffiaaaaaaaiaalaaaaadaaaaabia
aaaaaaiaanaaaakaakaaaaadaaaaabiaaaaaaaiaanaaffkaaeaaaaaeaaaaacia
aaaaaaiaanaakkkaanaappkaafaaaaadaaaaabiaaaaaaaiaaaaaaaiaafaaaaad
acaaacoaaaaaaaiaaaaaffiaaiaaaaadaaaaabiaafaaoejaaoaaoekabcaaaaae
abaaahiaadaakkkaafaaoejaaaaaaaiaaeaaaaaeaaaaahiaabaaoekaabaappkb
abaaoeiaafaaaaadabaaahiaabaappkaabaaoekaaeaaaaaeadaaahoaadaappka
aaaaoeiaabaaoeiaaeaaaaaeacaaamoaaeaabejaaeaabekaaeaalekaafaaaaad
aaaaapiaaaaaffjaagaaoekaaeaaaaaeaaaaapiaafaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaahaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaaiaaoeka
aaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacacaaaboaafaappjappppaaaafdeieefcjmaeaaaa
eaaaabaachabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaaddcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafdcaabaaaaaaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaa
aaaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaa
abaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaabaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaabaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaak
bcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaa
aeaaaaaaaaaaaaakccaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaa
dkiacaaaaaaaaaaaaeaaaaaaaoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpbkaabaaaaaaaaaaadicaaaahbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahcccabaaaadaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaalmccabaaaadaaaaaaagbebaaaaeaaaaaa
agiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaadgaaaaafbccabaaa
adaaaaaadkbabaaaafaaaaaabaaaaaakbcaabaaaaaaaaaaaegbcbaaaafaaaaaa
aceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaaaaaaaaaiocaabaaaaaaaaaaa
agaabaiaebaaaaaaaaaaaaaaagbjbaaaafaaaaaadcaaaaakhcaabaaaaaaaaaaa
kgikcaaaaaaaaaaaaiaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaadcaaaaam
hcaabaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaadaaaaaapgipcaaaaaaaaaaa
adaaaaaaegacbaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaapgipcaaaaaaaaaaa
adaaaaaaegiccaaaaaaaaaaaadaaaaaadcaaaaakhccabaaaaeaaaaaapgipcaaa
aaaaaaaaaiaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheo
maaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaalaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
ahaiaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaamadaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
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
					Vector 13[_tintColor]
					Float 14[_groundTexStart]
					Float 15[_groundTexEnd]
					Float 16[_saturation]
					Float 17[_contrast]
					Vector 18[unity_LightmapST]
					"!!ARBvp1.0
PARAM c[20] = { { 0, 1, 3, 2 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..18],
		{ 0.29899999, 0.58700001, 0.114 } };
TEMP R0;
TEMP R1;
DP3 R0.x, vertex.color, c[19];
ADD R1.xyz, vertex.color, -R0.x;
MAD R1.xyz, R1, c[16].x, R0.x;
MAD R1.xyz, -c[13], c[13].w, R1;
MUL R0.xyz, c[13], c[13].w;
MAD result.texcoord[3].xyz, R1, c[17].x, R0;
MOV R1.x, c[14];
ADD R1.y, -R1.x, c[15].x;
DP4 R1.x, vertex.position, c[3];
MOV R0.z, vertex.texcoord[1].x;
MOV R0.xy, vertex.texcoord[0];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
MOV result.texcoord[0].xyz, R0;
ABS result.texcoord[1].xyz, R0;
RCP R1.y, R1.y;
ADD R1.x, -R1, -c[14];
MUL R1.x, R1, R1.y;
MIN R0.w, R1.x, c[0].y;
MAX R0.w, R0, c[0].x;
MAD R0.y, -R0.w, c[0].w, c[0].z;
MUL R0.x, R0.w, R0.w;
MUL result.texcoord[2].y, R0.x, R0;
MAD result.texcoord[4].xy, vertex.texcoord[1], c[18], c[18].zwzw;
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
MOV result.texcoord[2].x, vertex.color.w;
END
# 30 instructions, 2 R-regs
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
					Vector 12[_tintColor]
					Float 13[_groundTexStart]
					Float 14[_groundTexEnd]
					Float 15[_saturation]
					Float 16[_contrast]
					Vector 17[unity_LightmapST]
					"vs_2_0
def c18, 1.00000000, 0.00000000, 2.00000000, 3.00000000
def c19, 0.29899999, 0.58700001, 0.11400000, 0
dcl_position0 v0
dcl_texcoord0 v2
dcl_texcoord1 v3
dcl_color0 v4
dp3 r0.x, v4, c19
add r1.xyz, v4, -r0.x
mad r1.xyz, r1, c15.x, r0.x
mad r1.xyz, -c12, c12.w, r1
mul r0.xyz, c12, c12.w
mad oT3.xyz, r1, c16.x, r0
mov r1.x, c14
add r1.y, -c13.x, r1.x
dp4 r1.x, v0, c2
mov r0.z, v3.x
mov r0.xy, v2
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov oT0.xyz, r0
abs oT1.xyz, r0
rcp r1.y, r1.y
add r1.x, -r1, -c13
mul r1.x, r1, r1.y
min r0.w, r1.x, c18.x
max r0.w, r0, c18.y
mad r0.y, -r0.w, c18.z, c18.w
mul r0.x, r0.w, r0.w
mul oT2.y, r0.x, r0
mad oT4.xy, v3, c17, c17.zwzw
dp4 oPos.w, v0, c7
dp4 oPos.z, v0, c6
dp4 oPos.y, v0, c5
dp4 oPos.x, v0, c4
mov oT2.x, v4.w
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
					176
					Vector 48[_tintColor]
					Float 72[_groundTexStart]
					Float 76[_groundTexEnd]
					Float 136[_saturation]
					Float 140[_contrast]
					Vector 160[unity_LightmapST]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					BindCB "$Globals"
					0
					BindCB "UnityPerDraw"
					1 "vs_4_0
eefiecedoknkeefbjbmonghldijmocdkjhhilekfabaaaaaafaagaaaaadaaaaaa
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
adamaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaamadaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcjmaeaaaaeaaaabaachabaaaafjaaaaae
egiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaa
fpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaa
gfaaaaadmccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaa
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
dkbabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaakbcaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaaaaaaaaakccaabaaa
aaaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaadkiacaaaaaaaaaaaaeaaaaaa
aoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
bkaabaaaaaaaaaaadicaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahcccabaaaadaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaalmccabaaaadaaaaaaagbebaaaaeaaaaaaagiecaaaaaaaaaaaakaaaaaa
kgiocaaaaaaaaaaaakaaaaaadgaaaaafbccabaaaadaaaaaadkbabaaaafaaaaaa
baaaaaakbcaabaaaaaaaaaaaegbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdp
nfhiojdnaaaaaaaaaaaaaaaiocaabaaaaaaaaaaaagaabaiaebaaaaaaaaaaaaaa
agbjbaaaafaaaaaadcaaaaakhcaabaaaaaaaaaaakgikcaaaaaaaaaaaaiaaaaaa
jgahbaaaaaaaaaaaagaabaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaaegiccaia
ebaaaaaaaaaaaaaaadaaaaaapgipcaaaaaaaaaaaadaaaaaaegacbaaaaaaaaaaa
diaaaaajhcaabaaaabaaaaaapgipcaaaaaaaaaaaadaaaaaaegiccaaaaaaaaaaa
adaaaaaadcaaaaakhccabaaaaeaaaaaapgipcaaaaaaaaaaaaiaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadoaaaaab"
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
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					176
					Vector 48[_tintColor]
					Float 72[_groundTexStart]
					Float 76[_groundTexEnd]
					Float 136[_saturation]
					Float 140[_contrast]
					Vector 160[unity_LightmapST]
					ConstBuffer "UnityPerDraw"
					336
					Matrix 0[glstate_matrix_mvp]
					Matrix 64[glstate_matrix_modelview0]
					BindCB "$Globals"
					0
					BindCB "UnityPerDraw"
					1 "vs_4_0_level_9_1
eefiecedmoplpbikckkbcfmgglfajfgohggieolcabaaaaaabmajaaaaaeaaaaaa
daaaaaaapiacaaaajmahaaaageaiaaaaebgpgodjmaacaaaamaacaaaaaaacpopp
giacaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaadaa
acaaabaaaaaaaaaaaaaaaiaaabaaadaaaaaaaaaaaaaaakaaabaaaeaaaaaaaaaa
abaaaaaaaiaaafaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafanaaapkaaaaaaaaa
aaaaiadpaaaaaamaaaaaeaeafbaaaaafaoaaapkaihbgjjdokcefbgdpnfhiojdn
aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaadiaadaaapjabpaaaaac
afaaaeiaaeaaapjabpaaaaacafaaafiaafaaapjaabaaaaacaaaaadiaadaaoeja
abaaaaacaaaaaeiaaeaaaajaceaaaaacabaaahiaaaaaoeiacdaaaaacabaaahoa
abaaoeiaabaaaaacaaaaahoaabaaoeiaafaaaaadaaaaabiaaaaaffjaakaakkka
aeaaaaaeaaaaabiaajaakkkaaaaaaajaaaaaaaiaaeaaaaaeaaaaabiaalaakkka
aaaakkjaaaaaaaiaaeaaaaaeaaaaabiaamaakkkaaaaappjaaaaaaaiaacaaaaad
aaaaabiaaaaaaaibacaakkkbacaaaaadaaaaaciaacaakkkbacaappkaagaaaaac
aaaaaciaaaaaffiaafaaaaadaaaaabiaaaaaffiaaaaaaaiaalaaaaadaaaaabia
aaaaaaiaanaaaakaakaaaaadaaaaabiaaaaaaaiaanaaffkaaeaaaaaeaaaaacia
aaaaaaiaanaakkkaanaappkaafaaaaadaaaaabiaaaaaaaiaaaaaaaiaafaaaaad
acaaacoaaaaaaaiaaaaaffiaaiaaaaadaaaaabiaafaaoejaaoaaoekabcaaaaae
abaaahiaadaakkkaafaaoejaaaaaaaiaaeaaaaaeaaaaahiaabaaoekaabaappkb
abaaoeiaafaaaaadabaaahiaabaappkaabaaoekaaeaaaaaeadaaahoaadaappka
aaaaoeiaabaaoeiaaeaaaaaeacaaamoaaeaabejaaeaabekaaeaalekaafaaaaad
aaaaapiaaaaaffjaagaaoekaaeaaaaaeaaaaapiaafaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaahaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaaiaaoeka
aaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacacaaaboaafaappjappppaaaafdeieefcjmaeaaaa
eaaaabaachabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaaddcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafdcaabaaaaaaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaa
aaaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaa
abaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaabaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaabaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaak
bcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaa
aeaaaaaaaaaaaaakccaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaa
dkiacaaaaaaaaaaaaeaaaaaaaoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpbkaabaaaaaaaaaaadicaaaahbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahcccabaaaadaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaalmccabaaaadaaaaaaagbebaaaaeaaaaaa
agiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaadgaaaaafbccabaaa
adaaaaaadkbabaaaafaaaaaabaaaaaakbcaabaaaaaaaaaaaegbcbaaaafaaaaaa
aceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaaaaaaaaaiocaabaaaaaaaaaaa
agaabaiaebaaaaaaaaaaaaaaagbjbaaaafaaaaaadcaaaaakhcaabaaaaaaaaaaa
kgikcaaaaaaaaaaaaiaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaadcaaaaam
hcaabaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaadaaaaaapgipcaaaaaaaaaaa
adaaaaaaegacbaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaapgipcaaaaaaaaaaa
adaaaaaaegiccaaaaaaaaaaaadaaaaaadcaaaaakhccabaaaaeaaaaaapgipcaaa
aaaaaaaaaiaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheo
maaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaalaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
ahaiaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaamadaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
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
					Float 23[_groundTexStart]
					Float 24[_groundTexEnd]
					Float 25[_saturation]
					Float 26[_contrast]
					"!!ARBvp1.0
PARAM c[28] = { { 0, 1, 3, 2 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..26],
		{ 0.29899999, 0.58700001, 0.114, 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[21].w;
DP3 R3.w, R1, c[10];
DP3 R2.w, R1, c[11];
DP3 R0.w, R1, c[9];
MOV R0.x, R3.w;
MOV R0.y, R2.w;
MOV R0.z, c[0].y;
MUL R1, R0.wxyy, R0.xyyw;
DP4 R2.z, R0.wxyz, c[16];
DP4 R2.y, R0.wxyz, c[15];
DP4 R2.x, R0.wxyz, c[14];
DP4 R0.z, R1, c[19];
DP4 R0.y, R1, c[18];
DP4 R0.x, R1, c[17];
MUL R3.x, R3.w, R3.w;
MAD R1.w, R0, R0, -R3.x;
ADD R1.xyz, R2, R0;
MUL R0.xyz, R1.w, c[20];
ADD result.texcoord[5].xyz, R1, R0;
DP3 R3.x, vertex.color, c[27];
ADD R0.xyz, vertex.color, -R3.x;
MAD R3.xyz, R0, c[25].x, R3.x;
MUL R0.xyz, c[22], c[22].w;
MAD R3.xyz, -c[22], c[22].w, R3;
MAD result.texcoord[3].xyz, R3, c[26].x, R0;
DP4 R1.w, vertex.position, c[8];
DP4 R1.z, vertex.position, c[7];
DP4 R1.x, vertex.position, c[5];
DP4 R1.y, vertex.position, c[6];
MUL R2.xyz, R1.xyww, c[27].w;
MOV result.position, R1;
MOV R1.y, c[23].x;
ADD R1.y, -R1, c[24].x;
MOV R0.x, R2;
MUL R0.y, R2, c[13].x;
ADD result.texcoord[6].xy, R0, R2.z;
MOV R0.xy, vertex.texcoord[0];
MOV R0.z, vertex.texcoord[1].x;
DP3 R2.x, R0, R0;
RSQ R1.x, R2.x;
MUL R0.xyz, R1.x, R0;
DP4 R1.x, vertex.position, c[3];
MOV result.texcoord[0].xyz, R0;
ABS result.texcoord[1].xyz, R0;
RCP R1.y, R1.y;
ADD R1.x, -R1, -c[23];
MUL R1.x, R1, R1.y;
MIN R1.x, R1, c[0].y;
MAX R0.x, R1, c[0];
MAD R0.y, -R0.x, c[0].w, c[0].z;
MUL R0.x, R0, R0;
MOV result.texcoord[6].zw, R1;
MUL result.texcoord[2].y, R0.x, R0;
MOV result.texcoord[4].z, R2.w;
MOV result.texcoord[4].y, R3.w;
MOV result.texcoord[4].x, R0.w;
MOV result.texcoord[2].x, vertex.color.w;
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
					Float 23[_groundTexStart]
					Float 24[_groundTexEnd]
					Float 25[_saturation]
					Float 26[_contrast]
					"vs_2_0
def c27, 1.00000000, 0.00000000, 2.00000000, 3.00000000
def c28, 0.29899999, 0.58700001, 0.11400000, 0.50000000
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
dcl_color0 v4
mul r1.xyz, v1, c21.w
dp3 r3.w, r1, c9
dp3 r2.w, r1, c10
dp3 r0.w, r1, c8
mov r0.x, r3.w
mov r0.y, r2.w
mov r0.z, c27.x
mul r1, r0.wxyy, r0.xyyw
dp4 r2.z, r0.wxyz, c16
dp4 r2.y, r0.wxyz, c15
dp4 r2.x, r0.wxyz, c14
dp4 r0.z, r1, c19
dp4 r0.y, r1, c18
dp4 r0.x, r1, c17
mul r3.x, r3.w, r3.w
mad r1.w, r0, r0, -r3.x
add r1.xyz, r2, r0
mul r0.xyz, r1.w, c20
add oT5.xyz, r1, r0
dp3 r3.x, v4, c28
add r0.xyz, v4, -r3.x
mad r3.xyz, r0, c25.x, r3.x
mul r0.xyz, c22, c22.w
mad r3.xyz, -c22, c22.w, r3
mad oT3.xyz, r3, c26.x, r0
dp4 r1.w, v0, c7
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r2.xyz, r1.xyww, c28.w
mov oPos, r1
mov r1.y, c24.x
add r1.y, -c23.x, r1
mov r0.x, r2
mul r0.y, r2, c12.x
mad oT6.xy, r2.z, c13.zwzw, r0
mov r0.xy, v2
mov r0.z, v3.x
dp3 r2.x, r0, r0
rsq r1.x, r2.x
mul r0.xyz, r1.x, r0
dp4 r1.x, v0, c2
mov oT0.xyz, r0
abs oT1.xyz, r0
rcp r1.y, r1.y
add r1.x, -r1, -c23
mul r1.x, r1, r1.y
min r1.x, r1, c27
max r0.x, r1, c27.y
mad r0.y, -r0.x, c27.z, c27.w
mul r0.x, r0, r0
mov oT6.zw, r1
mul oT2.y, r0.x, r0
mov oT4.z, r2.w
mov oT4.y, r3.w
mov oT4.x, r0.w
mov oT2.x, v4.w
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
					224
					Vector 112[_tintColor]
					Float 136[_groundTexStart]
					Float 140[_groundTexEnd]
					Float 200[_saturation]
					Float 204[_contrast]
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
eefieceddjkgalmfjapnemocjlmcclnjobaljefeabaaaaaaeaajaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
fmahaaaaeaaaabaanhabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadbcbabaaaaeaaaaaafpaaaaad
pcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaa
gfaaaaadpccabaaaahaaaaaagiaaaaacafaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaabaaaaaa
akbabaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaabaaaaaa
egacbaaaabaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaabaaaaaa
diaaaaaibcaabaaaabaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaa
dcaaaaakbcaabaaaabaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaa
akaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaadaaaaaaagaaaaaa
ckbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaa
adaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaabaaaaaaaaaaaaakbcaabaaa
abaaaaaaakaabaiaebaaaaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaa
aaaaaaakccaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaadkiacaaa
aaaaaaaaaiaaaaaaaoaaaaakccaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpbkaabaaaabaaaaaadicaaaahbcaabaaaabaaaaaabkaabaaa
abaaaaaaakaabaaaabaaaaaadcaaaaajccaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahcccabaaaadaaaaaaakaabaaaabaaaaaa
bkaabaaaabaaaaaadgaaaaafbccabaaaadaaaaaadkbabaaaafaaaaaabaaaaaak
bcaabaaaabaaaaaaegbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdn
aaaaaaaaaaaaaaaiocaabaaaabaaaaaaagaabaiaebaaaaaaabaaaaaaagbjbaaa
afaaaaaadcaaaaakhcaabaaaabaaaaaakgikcaaaaaaaaaaaamaaaaaajgahbaaa
abaaaaaaagaabaaaabaaaaaadcaaaaamhcaabaaaabaaaaaaegiccaiaebaaaaaa
aaaaaaaaahaaaaaapgipcaaaaaaaaaaaahaaaaaaegacbaaaabaaaaaadiaaaaaj
hcaabaaaacaaaaaapgipcaaaaaaaaaaaahaaaaaaegiccaaaaaaaaaaaahaaaaaa
dcaaaaakhccabaaaaeaaaaaapgipcaaaaaaaaaaaamaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaacaaaaaapgipcaaa
adaaaaaabeaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaaklcaabaaaabaaaaaaegiicaaaadaaaaaaamaaaaaa
agaabaaaabaaaaaaegaibaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaaoaaaaaakgakbaaaabaaaaaaegadbaaaabaaaaaadgaaaaafhccabaaa
afaaaaaaegacbaaaabaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaacaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaa
bbaaaaaiccaabaaaacaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaa
bbaaaaaiecaabaaaacaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaa
diaaaaahpcaabaaaadaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaai
bcaabaaaaeaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaadaaaaaabbaaaaai
ccaabaaaaeaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaadaaaaaabbaaaaai
ecaabaaaaeaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaadaaaaaaaaaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaadcaaaaak
hccabaaaagaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaa
acaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaahaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaahaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
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
					224
					Vector 112[_tintColor]
					Float 136[_groundTexStart]
					Float 140[_groundTexEnd]
					Float 200[_saturation]
					Float 204[_contrast]
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
eefiecedmcoeedeaiddmmfdndfampoljdaffinkdabaaaaaaimanaaaaaeaaaaaa
daaaaaaahiaeaaaanmalaaaakeamaaaaebgpgodjeaaeaaaaeaaeaaaaaaacpopp
meadaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaahaa
acaaabaaaaaaaaaaaaaaamaaabaaadaaaaaaaaaaabaaafaaabaaaeaaaaaaaaaa
acaacgaaahaaafaaaaaaaaaaadaaaaaaaiaaamaaaaaaaaaaadaaamaaadaabeaa
aaaaaaaaadaabeaaabaabhaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafbiaaapka
aaaaaaaaaaaaiadpaaaaaamaaaaaeaeafbaaaaafbjaaapkaihbgjjdokcefbgdp
nfhiojdnaaaaaadpbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapja
bpaaaaacafaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjabpaaaaacafaaafia
afaaapjaabaaaaacaaaaadiaadaaoejaabaaaaacaaaaaeiaaeaaaajaceaaaaac
abaaahiaaaaaoeiacdaaaaacabaaahoaabaaoeiaabaaaaacaaaaahoaabaaoeia
afaaaaadaaaaabiaaaaaffjabbaakkkaaeaaaaaeaaaaabiabaaakkkaaaaaaaja
aaaaaaiaaeaaaaaeaaaaabiabcaakkkaaaaakkjaaaaaaaiaaeaaaaaeaaaaabia
bdaakkkaaaaappjaaaaaaaiaacaaaaadaaaaabiaaaaaaaibacaakkkbacaaaaad
aaaaaciaacaakkkbacaappkaagaaaaacaaaaaciaaaaaffiaafaaaaadaaaaabia
aaaaffiaaaaaaaiaalaaaaadaaaaabiaaaaaaaiabiaaaakaakaaaaadaaaaabia
aaaaaaiabiaaffkaaeaaaaaeaaaaaciaaaaaaaiabiaakkkabiaappkaafaaaaad
aaaaabiaaaaaaaiaaaaaaaiaafaaaaadacaaacoaaaaaaaiaaaaaffiaaiaaaaad
aaaaabiaafaaoejabjaaoekabcaaaaaeabaaahiaadaakkkaafaaoejaaaaaaaia
aeaaaaaeaaaaahiaabaaoekaabaappkbabaaoeiaafaaaaadabaaahiaabaappka
abaaoekaaeaaaaaeadaaahoaadaappkaaaaaoeiaabaaoeiaafaaaaadaaaaahia
acaaoejabhaappkaafaaaaadabaaahiaaaaaffiabfaaoekaaeaaaaaeaaaaalia
beaakekaaaaaaaiaabaakeiaaeaaaaaeaaaaahiabgaaoekaaaaakkiaaaaapeia
abaaaaacaaaaaiiabiaaffkaajaaaaadabaaabiaafaaoekaaaaaoeiaajaaaaad
abaaaciaagaaoekaaaaaoeiaajaaaaadabaaaeiaahaaoekaaaaaoeiaafaaaaad
acaaapiaaaaacjiaaaaakeiaajaaaaadadaaabiaaiaaoekaacaaoeiaajaaaaad
adaaaciaajaaoekaacaaoeiaajaaaaadadaaaeiaakaaoekaacaaoeiaacaaaaad
abaaahiaabaaoeiaadaaoeiaafaaaaadaaaaaiiaaaaaffiaaaaaffiaaeaaaaae
aaaaaiiaaaaaaaiaaaaaaaiaaaaappibabaaaaacaeaaahoaaaaaoeiaaeaaaaae
afaaahoaalaaoekaaaaappiaabaaoeiaafaaaaadaaaaapiaaaaaffjaanaaoeka
aeaaaaaeaaaaapiaamaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaoaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaapaaoekaaaaappjaaaaaoeiaafaaaaad
abaaabiaaaaaffiaaeaaaakaafaaaaadabaaaiiaabaaaaiabjaappkaafaaaaad
abaaafiaaaaapeiabjaappkaacaaaaadagaaadoaabaakkiaabaaomiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
agaaamoaaaaaoeiaabaaaaacacaaaboaafaappjappppaaaafdeieefcfmahaaaa
eaaaabaanhabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaa
adaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaafpaaaaadbcbabaaaaeaaaaaafpaaaaadpcbabaaa
afaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaad
pccabaaaahaaaaaagiaaaaacafaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
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
ahaaaaaadkbabaaaaaaaaaaaakaabaaaabaaaaaaaaaaaaakbcaabaaaabaaaaaa
akaabaiaebaaaaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaaaaaaaaak
ccaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaadkiacaaaaaaaaaaa
aiaaaaaaaoaaaaakccaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpbkaabaaaabaaaaaadicaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaa
akaabaaaabaaaaaadcaaaaajccaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahcccabaaaadaaaaaaakaabaaaabaaaaaabkaabaaa
abaaaaaadgaaaaafbccabaaaadaaaaaadkbabaaaafaaaaaabaaaaaakbcaabaaa
abaaaaaaegbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaa
aaaaaaaiocaabaaaabaaaaaaagaabaiaebaaaaaaabaaaaaaagbjbaaaafaaaaaa
dcaaaaakhcaabaaaabaaaaaakgikcaaaaaaaaaaaamaaaaaajgahbaaaabaaaaaa
agaabaaaabaaaaaadcaaaaamhcaabaaaabaaaaaaegiccaiaebaaaaaaaaaaaaaa
ahaaaaaapgipcaaaaaaaaaaaahaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaa
acaaaaaapgipcaaaaaaaaaaaahaaaaaaegiccaaaaaaaaaaaahaaaaaadcaaaaak
hccabaaaaeaaaaaapgipcaaaaaaaaaaaamaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaa
beaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaaklcaabaaaabaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaa
abaaaaaaegaibaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
aoaaaaaakgakbaaaabaaaaaaegadbaaaabaaaaaadgaaaaafhccabaaaafaaaaaa
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
agaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaafmccabaaaahaaaaaakgaobaaaaaaaaaaaaaaaaaah
dccabaaaahaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaabejfdeheo
maaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apabaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
ahaiaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaneaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaaneaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaiaaaaneaaaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
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
					Vector 13[_ProjectionParams]
					Vector 14[_tintColor]
					Float 15[_groundTexStart]
					Float 16[_groundTexEnd]
					Float 17[_saturation]
					Float 18[_contrast]
					Vector 19[unity_LightmapST]
					"!!ARBvp1.0
PARAM c[21] = { { 0, 1, 3, 2 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..19],
		{ 0.29899999, 0.58700001, 0.114, 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
DP3 R0.w, vertex.color, c[20];
ADD R0.xyz, vertex.color, -R0.w;
MAD R3.xyz, R0, c[17].x, R0.w;
MUL R0.xyz, c[14], c[14].w;
MAD R3.xyz, -c[14], c[14].w, R3;
MAD result.texcoord[3].xyz, R3, c[18].x, R0;
DP4 R1.w, vertex.position, c[8];
DP4 R1.z, vertex.position, c[7];
DP4 R1.x, vertex.position, c[5];
DP4 R1.y, vertex.position, c[6];
MUL R2.xyz, R1.xyww, c[20].w;
MOV result.position, R1;
MOV R1.x, c[15];
ADD R1.x, -R1, c[16];
MUL R0.y, R2, c[13].x;
MOV R0.x, R2;
ADD result.texcoord[5].xy, R0, R2.z;
MOV R0.xy, vertex.texcoord[0];
MOV R0.z, vertex.texcoord[1].x;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
DP4 R0.w, vertex.position, c[3];
MOV result.texcoord[0].xyz, R0;
ABS result.texcoord[1].xyz, R0;
RCP R1.x, R1.x;
ADD R0.w, -R0, -c[15].x;
MUL R0.w, R0, R1.x;
MIN R0.w, R0, c[0].y;
MAX R0.x, R0.w, c[0];
MAD R0.y, -R0.x, c[0].w, c[0].z;
MUL R0.x, R0, R0;
MOV result.texcoord[5].zw, R1;
MUL result.texcoord[2].y, R0.x, R0;
MAD result.texcoord[4].xy, vertex.texcoord[1], c[19], c[19].zwzw;
MOV result.texcoord[2].x, vertex.color.w;
END
# 36 instructions, 4 R-regs
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
					Vector 12[_ProjectionParams]
					Vector 13[_ScreenParams]
					Vector 14[_tintColor]
					Float 15[_groundTexStart]
					Float 16[_groundTexEnd]
					Float 17[_saturation]
					Float 18[_contrast]
					Vector 19[unity_LightmapST]
					"vs_2_0
def c20, 1.00000000, 0.00000000, 2.00000000, 3.00000000
def c21, 0.29899999, 0.58700001, 0.11400000, 0.50000000
dcl_position0 v0
dcl_texcoord0 v2
dcl_texcoord1 v3
dcl_color0 v4
dp3 r0.w, v4, c21
add r0.xyz, v4, -r0.w
mad r3.xyz, r0, c17.x, r0.w
mul r0.xyz, c14, c14.w
mad r3.xyz, -c14, c14.w, r3
mad oT3.xyz, r3, c18.x, r0
dp4 r1.w, v0, c7
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r2.xyz, r1.xyww, c21.w
mov oPos, r1
mov r1.x, c16
add r1.x, -c15, r1
mul r0.y, r2, c12.x
mov r0.x, r2
mad oT5.xy, r2.z, c13.zwzw, r0
mov r0.xy, v2
mov r0.z, v3.x
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp4 r0.w, v0, c2
mov oT0.xyz, r0
abs oT1.xyz, r0
rcp r1.x, r1.x
add r0.w, -r0, -c15.x
mul r0.w, r0, r1.x
min r0.w, r0, c20.x
max r0.x, r0.w, c20.y
mad r0.y, -r0.x, c20.z, c20.w
mul r0.x, r0, r0
mov oT5.zw, r1
mul oT2.y, r0.x, r0
mad oT4.xy, v3, c19, c19.zwzw
mov oT2.x, v4.w
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
					240
					Vector 112[_tintColor]
					Float 136[_groundTexStart]
					Float 140[_groundTexEnd]
					Float 200[_saturation]
					Float 204[_contrast]
					Vector 224[unity_LightmapST]
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
eefiecedghbiiikkdhmhmfnjeogknfepamgimmigabaaaaaabaahaaaaadaaaaaa
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
adamaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaamadaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefceeafaaaaeaaaabaafbabaaaafjaaaaaeegiocaaaaaaaaaaa
apaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
dccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadpccabaaaafaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaa
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
acaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaabaaaaaaaaaaaaakbcaabaaa
abaaaaaaakaabaiaebaaaaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaa
aaaaaaakccaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaadkiacaaa
aaaaaaaaaiaaaaaaaoaaaaakccaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpbkaabaaaabaaaaaadicaaaahbcaabaaaabaaaaaabkaabaaa
abaaaaaaakaabaaaabaaaaaadcaaaaajccaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahcccabaaaadaaaaaaakaabaaaabaaaaaa
bkaabaaaabaaaaaadcaaaaalmccabaaaadaaaaaaagbebaaaaeaaaaaaagiecaaa
aaaaaaaaaoaaaaaakgiocaaaaaaaaaaaaoaaaaaadgaaaaafbccabaaaadaaaaaa
dkbabaaaafaaaaaabaaaaaakbcaabaaaabaaaaaaegbcbaaaafaaaaaaaceaaaaa
ihbgjjdokcefbgdpnfhiojdnaaaaaaaaaaaaaaaiocaabaaaabaaaaaaagaabaia
ebaaaaaaabaaaaaaagbjbaaaafaaaaaadcaaaaakhcaabaaaabaaaaaakgikcaaa
aaaaaaaaamaaaaaajgahbaaaabaaaaaaagaabaaaabaaaaaadcaaaaamhcaabaaa
abaaaaaaegiccaiaebaaaaaaaaaaaaaaahaaaaaapgipcaaaaaaaaaaaahaaaaaa
egacbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaapgipcaaaaaaaaaaaahaaaaaa
egiccaaaaaaaaaaaahaaaaaadcaaaaakhccabaaaaeaaaaaapgipcaaaaaaaaaaa
amaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaafaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaafaaaaaakgakbaaa
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
					240
					Vector 112[_tintColor]
					Float 136[_groundTexStart]
					Float 140[_groundTexEnd]
					Float 200[_saturation]
					Float 204[_contrast]
					Vector 224[unity_LightmapST]
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
eefiecedjkcpebdoadljmhlgohjeggbdaoigmcliabaaaaaadeakaaaaaeaaaaaa
daaaaaaafaadaaaajmaiaaaageajaaaaebgpgodjbiadaaaabiadaaaaaaacpopp
leacaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaahaa
acaaabaaaaaaaaaaaaaaamaaabaaadaaaaaaaaaaaaaaaoaaabaaaeaaaaaaaaaa
abaaafaaabaaafaaaaaaaaaaacaaaaaaaiaaagaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafaoaaapkaaaaaaaaaaaaaiadpaaaaaamaaaaaeaeafbaaaaafapaaapka
ihbgjjdokcefbgdpnfhiojdnaaaaaadpbpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjabpaaaaacafaaafiaafaaapja
abaaaaacaaaaadiaadaaoejaabaaaaacaaaaaeiaaeaaaajaceaaaaacabaaahia
aaaaoeiacdaaaaacabaaahoaabaaoeiaabaaaaacaaaaahoaabaaoeiaafaaaaad
aaaaabiaaaaaffjaalaakkkaaeaaaaaeaaaaabiaakaakkkaaaaaaajaaaaaaaia
aeaaaaaeaaaaabiaamaakkkaaaaakkjaaaaaaaiaaeaaaaaeaaaaabiaanaakkka
aaaappjaaaaaaaiaacaaaaadaaaaabiaaaaaaaibacaakkkbacaaaaadaaaaacia
acaakkkbacaappkaagaaaaacaaaaaciaaaaaffiaafaaaaadaaaaabiaaaaaffia
aaaaaaiaalaaaaadaaaaabiaaaaaaaiaaoaaaakaakaaaaadaaaaabiaaaaaaaia
aoaaffkaaeaaaaaeaaaaaciaaaaaaaiaaoaakkkaaoaappkaafaaaaadaaaaabia
aaaaaaiaaaaaaaiaafaaaaadacaaacoaaaaaaaiaaaaaffiaaiaaaaadaaaaabia
afaaoejaapaaoekabcaaaaaeabaaahiaadaakkkaafaaoejaaaaaaaiaaeaaaaae
aaaaahiaabaaoekaabaappkbabaaoeiaafaaaaadabaaahiaabaappkaabaaoeka
aeaaaaaeadaaahoaadaappkaaaaaoeiaabaaoeiaaeaaaaaeacaaamoaaeaabeja
aeaabekaaeaalekaafaaaaadaaaaapiaaaaaffjaahaaoekaaeaaaaaeaaaaapia
agaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaiaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaajaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffia
afaaaakaafaaaaadabaaaiiaabaaaaiaapaappkaafaaaaadabaaafiaaaaapeia
apaappkaacaaaaadaeaaadoaabaakkiaabaaomiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaeaaamoaaaaaoeia
abaaaaacacaaaboaafaappjappppaaaafdeieefceeafaaaaeaaaabaafbabaaaa
fjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacadaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaa
dgaaaaafecaabaaaabaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaacaaaaaa
egacbaiaibaaaaaaabaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaacaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaa
ckiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaak
bcaabaaaabaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
abaaaaaaaaaaaaakbcaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaackiacaia
ebaaaaaaaaaaaaaaaiaaaaaaaaaaaaakccaabaaaabaaaaaackiacaiaebaaaaaa
aaaaaaaaaiaaaaaadkiacaaaaaaaaaaaaiaaaaaaaoaaaaakccaabaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaabaaaaaadicaaaah
bcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaajccaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahcccabaaa
adaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaalmccabaaaadaaaaaa
agbebaaaaeaaaaaaagiecaaaaaaaaaaaaoaaaaaakgiocaaaaaaaaaaaaoaaaaaa
dgaaaaafbccabaaaadaaaaaadkbabaaaafaaaaaabaaaaaakbcaabaaaabaaaaaa
egbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaaaaaaaaai
ocaabaaaabaaaaaaagaabaiaebaaaaaaabaaaaaaagbjbaaaafaaaaaadcaaaaak
hcaabaaaabaaaaaakgikcaaaaaaaaaaaamaaaaaajgahbaaaabaaaaaaagaabaaa
abaaaaaadcaaaaamhcaabaaaabaaaaaaegiccaiaebaaaaaaaaaaaaaaahaaaaaa
pgipcaaaaaaaaaaaahaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaa
pgipcaaaaaaaaaaaahaaaaaaegiccaaaaaaaaaaaahaaaaaadcaaaaakhccabaaa
aeaaaaaapgipcaaaaaaaaaaaamaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaafmccabaaaafaaaaaakgaobaaaaaaaaaaaaaaaaaah
dccabaaaafaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaabejfdeheo
maaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaalaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
ahaiaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaamadaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklkl"
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
					Vector 13[_ProjectionParams]
					Vector 14[_tintColor]
					Float 15[_groundTexStart]
					Float 16[_groundTexEnd]
					Float 17[_saturation]
					Float 18[_contrast]
					Vector 19[unity_LightmapST]
					"!!ARBvp1.0
PARAM c[21] = { { 0, 1, 3, 2 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..19],
		{ 0.29899999, 0.58700001, 0.114, 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
DP3 R0.w, vertex.color, c[20];
ADD R0.xyz, vertex.color, -R0.w;
MAD R3.xyz, R0, c[17].x, R0.w;
MUL R0.xyz, c[14], c[14].w;
MAD R3.xyz, -c[14], c[14].w, R3;
MAD result.texcoord[3].xyz, R3, c[18].x, R0;
DP4 R1.w, vertex.position, c[8];
DP4 R1.z, vertex.position, c[7];
DP4 R1.x, vertex.position, c[5];
DP4 R1.y, vertex.position, c[6];
MUL R2.xyz, R1.xyww, c[20].w;
MOV result.position, R1;
MOV R1.x, c[15];
ADD R1.x, -R1, c[16];
MUL R0.y, R2, c[13].x;
MOV R0.x, R2;
ADD result.texcoord[5].xy, R0, R2.z;
MOV R0.xy, vertex.texcoord[0];
MOV R0.z, vertex.texcoord[1].x;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
DP4 R0.w, vertex.position, c[3];
MOV result.texcoord[0].xyz, R0;
ABS result.texcoord[1].xyz, R0;
RCP R1.x, R1.x;
ADD R0.w, -R0, -c[15].x;
MUL R0.w, R0, R1.x;
MIN R0.w, R0, c[0].y;
MAX R0.x, R0.w, c[0];
MAD R0.y, -R0.x, c[0].w, c[0].z;
MUL R0.x, R0, R0;
MOV result.texcoord[5].zw, R1;
MUL result.texcoord[2].y, R0.x, R0;
MAD result.texcoord[4].xy, vertex.texcoord[1], c[19], c[19].zwzw;
MOV result.texcoord[2].x, vertex.color.w;
END
# 36 instructions, 4 R-regs
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
					Vector 12[_ProjectionParams]
					Vector 13[_ScreenParams]
					Vector 14[_tintColor]
					Float 15[_groundTexStart]
					Float 16[_groundTexEnd]
					Float 17[_saturation]
					Float 18[_contrast]
					Vector 19[unity_LightmapST]
					"vs_2_0
def c20, 1.00000000, 0.00000000, 2.00000000, 3.00000000
def c21, 0.29899999, 0.58700001, 0.11400000, 0.50000000
dcl_position0 v0
dcl_texcoord0 v2
dcl_texcoord1 v3
dcl_color0 v4
dp3 r0.w, v4, c21
add r0.xyz, v4, -r0.w
mad r3.xyz, r0, c17.x, r0.w
mul r0.xyz, c14, c14.w
mad r3.xyz, -c14, c14.w, r3
mad oT3.xyz, r3, c18.x, r0
dp4 r1.w, v0, c7
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r2.xyz, r1.xyww, c21.w
mov oPos, r1
mov r1.x, c16
add r1.x, -c15, r1
mul r0.y, r2, c12.x
mov r0.x, r2
mad oT5.xy, r2.z, c13.zwzw, r0
mov r0.xy, v2
mov r0.z, v3.x
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp4 r0.w, v0, c2
mov oT0.xyz, r0
abs oT1.xyz, r0
rcp r1.x, r1.x
add r0.w, -r0, -c15.x
mul r0.w, r0, r1.x
min r0.w, r0, c20.x
max r0.x, r0.w, c20.y
mad r0.y, -r0.x, c20.z, c20.w
mul r0.x, r0, r0
mov oT5.zw, r1
mul oT2.y, r0.x, r0
mad oT4.xy, v3, c19, c19.zwzw
mov oT2.x, v4.w
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
					240
					Vector 112[_tintColor]
					Float 136[_groundTexStart]
					Float 140[_groundTexEnd]
					Float 200[_saturation]
					Float 204[_contrast]
					Vector 224[unity_LightmapST]
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
eefiecedghbiiikkdhmhmfnjeogknfepamgimmigabaaaaaabaahaaaaadaaaaaa
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
adamaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaamadaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefceeafaaaaeaaaabaafbabaaaafjaaaaaeegiocaaaaaaaaaaa
apaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
dccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadpccabaaaafaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaa
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
acaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaabaaaaaaaaaaaaakbcaabaaa
abaaaaaaakaabaiaebaaaaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaa
aaaaaaakccaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaadkiacaaa
aaaaaaaaaiaaaaaaaoaaaaakccaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpbkaabaaaabaaaaaadicaaaahbcaabaaaabaaaaaabkaabaaa
abaaaaaaakaabaaaabaaaaaadcaaaaajccaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahcccabaaaadaaaaaaakaabaaaabaaaaaa
bkaabaaaabaaaaaadcaaaaalmccabaaaadaaaaaaagbebaaaaeaaaaaaagiecaaa
aaaaaaaaaoaaaaaakgiocaaaaaaaaaaaaoaaaaaadgaaaaafbccabaaaadaaaaaa
dkbabaaaafaaaaaabaaaaaakbcaabaaaabaaaaaaegbcbaaaafaaaaaaaceaaaaa
ihbgjjdokcefbgdpnfhiojdnaaaaaaaaaaaaaaaiocaabaaaabaaaaaaagaabaia
ebaaaaaaabaaaaaaagbjbaaaafaaaaaadcaaaaakhcaabaaaabaaaaaakgikcaaa
aaaaaaaaamaaaaaajgahbaaaabaaaaaaagaabaaaabaaaaaadcaaaaamhcaabaaa
abaaaaaaegiccaiaebaaaaaaaaaaaaaaahaaaaaapgipcaaaaaaaaaaaahaaaaaa
egacbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaapgipcaaaaaaaaaaaahaaaaaa
egiccaaaaaaaaaaaahaaaaaadcaaaaakhccabaaaaeaaaaaapgipcaaaaaaaaaaa
amaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaafaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaafaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadoaaaaab"
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
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					240
					Vector 112[_tintColor]
					Float 136[_groundTexStart]
					Float 140[_groundTexEnd]
					Float 200[_saturation]
					Float 204[_contrast]
					Vector 224[unity_LightmapST]
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
eefiecedjkcpebdoadljmhlgohjeggbdaoigmcliabaaaaaadeakaaaaaeaaaaaa
daaaaaaafaadaaaajmaiaaaageajaaaaebgpgodjbiadaaaabiadaaaaaaacpopp
leacaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaahaa
acaaabaaaaaaaaaaaaaaamaaabaaadaaaaaaaaaaaaaaaoaaabaaaeaaaaaaaaaa
abaaafaaabaaafaaaaaaaaaaacaaaaaaaiaaagaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafaoaaapkaaaaaaaaaaaaaiadpaaaaaamaaaaaeaeafbaaaaafapaaapka
ihbgjjdokcefbgdpnfhiojdnaaaaaadpbpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjabpaaaaacafaaafiaafaaapja
abaaaaacaaaaadiaadaaoejaabaaaaacaaaaaeiaaeaaaajaceaaaaacabaaahia
aaaaoeiacdaaaaacabaaahoaabaaoeiaabaaaaacaaaaahoaabaaoeiaafaaaaad
aaaaabiaaaaaffjaalaakkkaaeaaaaaeaaaaabiaakaakkkaaaaaaajaaaaaaaia
aeaaaaaeaaaaabiaamaakkkaaaaakkjaaaaaaaiaaeaaaaaeaaaaabiaanaakkka
aaaappjaaaaaaaiaacaaaaadaaaaabiaaaaaaaibacaakkkbacaaaaadaaaaacia
acaakkkbacaappkaagaaaaacaaaaaciaaaaaffiaafaaaaadaaaaabiaaaaaffia
aaaaaaiaalaaaaadaaaaabiaaaaaaaiaaoaaaakaakaaaaadaaaaabiaaaaaaaia
aoaaffkaaeaaaaaeaaaaaciaaaaaaaiaaoaakkkaaoaappkaafaaaaadaaaaabia
aaaaaaiaaaaaaaiaafaaaaadacaaacoaaaaaaaiaaaaaffiaaiaaaaadaaaaabia
afaaoejaapaaoekabcaaaaaeabaaahiaadaakkkaafaaoejaaaaaaaiaaeaaaaae
aaaaahiaabaaoekaabaappkbabaaoeiaafaaaaadabaaahiaabaappkaabaaoeka
aeaaaaaeadaaahoaadaappkaaaaaoeiaabaaoeiaaeaaaaaeacaaamoaaeaabeja
aeaabekaaeaalekaafaaaaadaaaaapiaaaaaffjaahaaoekaaeaaaaaeaaaaapia
agaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaiaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaajaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffia
afaaaakaafaaaaadabaaaiiaabaaaaiaapaappkaafaaaaadabaaafiaaaaapeia
apaappkaacaaaaadaeaaadoaabaakkiaabaaomiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaeaaamoaaaaaoeia
abaaaaacacaaaboaafaappjappppaaaafdeieefceeafaaaaeaaaabaafbabaaaa
fjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacadaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaa
dgaaaaafecaabaaaabaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaacaaaaaa
egacbaiaibaaaaaaabaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaacaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaa
ckiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaak
bcaabaaaabaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
abaaaaaaaaaaaaakbcaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaackiacaia
ebaaaaaaaaaaaaaaaiaaaaaaaaaaaaakccaabaaaabaaaaaackiacaiaebaaaaaa
aaaaaaaaaiaaaaaadkiacaaaaaaaaaaaaiaaaaaaaoaaaaakccaabaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaabaaaaaadicaaaah
bcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaajccaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahcccabaaa
adaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaalmccabaaaadaaaaaa
agbebaaaaeaaaaaaagiecaaaaaaaaaaaaoaaaaaakgiocaaaaaaaaaaaaoaaaaaa
dgaaaaafbccabaaaadaaaaaadkbabaaaafaaaaaabaaaaaakbcaabaaaabaaaaaa
egbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaaaaaaaaai
ocaabaaaabaaaaaaagaabaiaebaaaaaaabaaaaaaagbjbaaaafaaaaaadcaaaaak
hcaabaaaabaaaaaakgikcaaaaaaaaaaaamaaaaaajgahbaaaabaaaaaaagaabaaa
abaaaaaadcaaaaamhcaabaaaabaaaaaaegiccaiaebaaaaaaaaaaaaaaahaaaaaa
pgipcaaaaaaaaaaaahaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaa
pgipcaaaaaaaaaaaahaaaaaaegiccaaaaaaaaaaaahaaaaaadcaaaaakhccabaaa
aeaaaaaapgipcaaaaaaaaaaaamaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaafmccabaaaafaaaaaakgaobaaaaaaaaaaaaaaaaaah
dccabaaaafaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaabejfdeheo
maaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaalaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
ahaiaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaamadaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklkl"
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
					Matrix 9[_Object2World]
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
					Vector 29[_tintColor]
					Float 30[_groundTexStart]
					Float 31[_groundTexEnd]
					Float 32[_saturation]
					Float 33[_contrast]
					"!!ARBvp1.0
PARAM c[35] = { { 1, 0, 2, 3 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..33],
		{ 0.29899999, 0.58700001, 0.114 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[28].w;
DP3 R4.x, R3, c[9];
DP3 R3.w, R3, c[10];
DP3 R3.x, R3, c[11];
DP4 R0.x, vertex.position, c[10];
ADD R1, -R0.x, c[14];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[9];
ADD R0, -R0.x, c[13];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MOV R4.w, c[0].x;
MAD R2, R4.x, R0, R2;
DP4 R4.y, vertex.position, c[11];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[15];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[16];
MOV R4.y, R3.w;
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].x;
DP4 R2.z, R4, c[23];
DP4 R2.y, R4, c[22];
DP4 R2.x, R4, c[21];
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].y;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[18];
MAD R1.xyz, R0.x, c[17], R1;
MAD R0.xyz, R0.z, c[19], R1;
MAD R1.xyz, R0.w, c[20], R0;
MUL R0, R4.xyzz, R4.yzzx;
DP4 R4.w, R0, c[26];
DP4 R4.z, R0, c[25];
DP4 R4.y, R0, c[24];
MUL R1.w, R3, R3;
ADD R0.xyz, R2, R4.yzww;
MAD R0.w, R4.x, R4.x, -R1;
MUL R2.xyz, R0.w, c[27];
ADD R2.xyz, R0, R2;
DP3 R0.w, vertex.color, c[34];
ADD R0.xyz, vertex.color, -R0.w;
ADD result.texcoord[5].xyz, R2, R1;
MAD R1.xyz, R0, c[32].x, R0.w;
MAD R1.xyz, -c[29], c[29].w, R1;
MUL R0.xyz, c[29], c[29].w;
MAD result.texcoord[3].xyz, R1, c[33].x, R0;
MOV R1.x, c[30];
ADD R1.y, -R1.x, c[31].x;
DP4 R1.x, vertex.position, c[3];
MOV R0.z, vertex.texcoord[1].x;
MOV R0.xy, vertex.texcoord[0];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
MOV result.texcoord[0].xyz, R0;
ABS result.texcoord[1].xyz, R0;
RCP R1.y, R1.y;
ADD R1.x, -R1, -c[30];
MUL R1.x, R1, R1.y;
MIN R0.w, R1.x, c[0].x;
MAX R0.w, R0, c[0].y;
MAD R0.y, -R0.w, c[0].z, c[0].w;
MUL R0.x, R0.w, R0.w;
MUL result.texcoord[2].y, R0.x, R0;
MOV result.texcoord[4].z, R3.x;
MOV result.texcoord[4].y, R3.w;
MOV result.texcoord[4].x, R4;
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
MOV result.texcoord[2].x, vertex.color.w;
END
# 81 instructions, 5 R-regs
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
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 8[_Object2World]
					Vector 12[unity_4LightPosX0]
					Vector 13[unity_4LightPosY0]
					Vector 14[unity_4LightPosZ0]
					Vector 15[unity_4LightAtten0]
					Vector 16[unity_LightColor0]
					Vector 17[unity_LightColor1]
					Vector 18[unity_LightColor2]
					Vector 19[unity_LightColor3]
					Vector 20[unity_SHAr]
					Vector 21[unity_SHAg]
					Vector 22[unity_SHAb]
					Vector 23[unity_SHBr]
					Vector 24[unity_SHBg]
					Vector 25[unity_SHBb]
					Vector 26[unity_SHC]
					Vector 27[unity_Scale]
					Vector 28[_tintColor]
					Float 29[_groundTexStart]
					Float 30[_groundTexEnd]
					Float 31[_saturation]
					Float 32[_contrast]
					"vs_2_0
def c33, 1.00000000, 0.00000000, 2.00000000, 3.00000000
def c34, 0.29899999, 0.58700001, 0.11400000, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
dcl_color0 v4
mul r3.xyz, v1, c27.w
dp3 r4.x, r3, c8
dp3 r3.w, r3, c9
dp3 r3.x, r3, c10
dp4 r0.x, v0, c9
add r1, -r0.x, c13
mul r2, r3.w, r1
dp4 r0.x, v0, c8
add r0, -r0.x, c12
mul r1, r1, r1
mov r4.z, r3.x
mov r4.w, c33.x
mad r2, r4.x, r0, r2
dp4 r4.y, v0, c10
mad r1, r0, r0, r1
add r0, -r4.y, c14
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c15
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c33.x
dp4 r2.z, r4, c22
dp4 r2.y, r4, c21
dp4 r2.x, r4, c20
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c33.y
mul r0, r0, r1
mul r1.xyz, r0.y, c17
mad r1.xyz, r0.x, c16, r1
mad r0.xyz, r0.z, c18, r1
mad r1.xyz, r0.w, c19, r0
mul r0, r4.xyzz, r4.yzzx
dp4 r4.w, r0, c25
dp4 r4.z, r0, c24
dp4 r4.y, r0, c23
mul r1.w, r3, r3
add r0.xyz, r2, r4.yzww
mad r0.w, r4.x, r4.x, -r1
mul r2.xyz, r0.w, c26
add r2.xyz, r0, r2
dp3 r0.w, v4, c34
add r0.xyz, v4, -r0.w
add oT5.xyz, r2, r1
mad r1.xyz, r0, c31.x, r0.w
mad r1.xyz, -c28, c28.w, r1
mul r0.xyz, c28, c28.w
mad oT3.xyz, r1, c32.x, r0
mov r1.x, c30
add r1.y, -c29.x, r1.x
dp4 r1.x, v0, c2
mov r0.z, v3.x
mov r0.xy, v2
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov oT0.xyz, r0
abs oT1.xyz, r0
rcp r1.y, r1.y
add r1.x, -r1, -c29
mul r1.x, r1, r1.y
min r0.w, r1.x, c33.x
max r0.w, r0, c33.y
mad r0.y, -r0.w, c33.z, c33.w
mul r0.x, r0.w, r0.w
mul oT2.y, r0.x, r0
mov oT4.z, r3.x
mov oT4.y, r3.w
mov oT4.x, r4
dp4 oPos.w, v0, c7
dp4 oPos.z, v0, c6
dp4 oPos.y, v0, c5
dp4 oPos.x, v0, c4
mov oT2.x, v4.w
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
					160
					Vector 48[_tintColor]
					Float 72[_groundTexStart]
					Float 76[_groundTexEnd]
					Float 136[_saturation]
					Float 140[_contrast]
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
					BindCB "UnityLighting"
					1
					BindCB "UnityPerDraw"
					2 "vs_4_0
eefiecedkmojpoefgpdmnkddpdgfgoanhflbhgcpabaaaaaanaalaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcaeakaaaaeaaaabaaibacaaaafjaaaaaeegiocaaaaaaaaaaa
ajaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaadbcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaacagaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaa
aaaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaaaaaaaaa
dgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaa
dkbabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaakbcaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaaaaaaaaakccaabaaa
aaaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaadkiacaaaaaaaaaaaaeaaaaaa
aoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
bkaabaaaaaaaaaaadicaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahcccabaaaadaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
dgaaaaafbccabaaaadaaaaaadkbabaaaafaaaaaabaaaaaakbcaabaaaaaaaaaaa
egbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaaaaaaaaai
ocaabaaaaaaaaaaaagaabaiaebaaaaaaaaaaaaaaagbjbaaaafaaaaaadcaaaaak
hcaabaaaaaaaaaaakgikcaaaaaaaaaaaaiaaaaaajgahbaaaaaaaaaaaagaabaaa
aaaaaaaadcaaaaamhcaabaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaadaaaaaa
pgipcaaaaaaaaaaaadaaaaaaegacbaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaa
pgipcaaaaaaaaaaaadaaaaaaegiccaaaaaaaaaaaadaaaaaadcaaaaakhccabaaa
aeaaaaaapgipcaaaaaaaaaaaaiaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaaaaaaaaaa
egaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaa
aaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaa
abaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaa
abaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaa
abaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaa
acaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaa
egiocaaaabaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaa
egiocaaaabaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaa
egiocaaaabaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaabaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
hcaabaaaacaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaajpcaabaaaadaaaaaa
fgafbaiaebaaaaaaacaaaaaaegiocaaaabaaaaaaadaaaaaadiaaaaahpcaabaaa
aeaaaaaafgafbaaaaaaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaaadaaaaaa
egaobaaaadaaaaaaegaobaaaadaaaaaaaaaaaaajpcaabaaaafaaaaaaagaabaia
ebaaaaaaacaaaaaaegiocaaaabaaaaaaacaaaaaaaaaaaaajpcaabaaaacaaaaaa
kgakbaiaebaaaaaaacaaaaaaegiocaaaabaaaaaaaeaaaaaadcaaaaajpcaabaaa
aeaaaaaaegaobaaaafaaaaaaagaabaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaaj
pcaabaaaaaaaaaaaegaobaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaaeaaaaaa
dcaaaaajpcaabaaaadaaaaaaegaobaaaafaaaaaaegaobaaaafaaaaaaegaobaaa
adaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaadaaaaaaeeaaaaafpcaabaaaadaaaaaaegaobaaaacaaaaaadcaaaaan
pcaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaabaaaaaaafaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaacaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaacaaaaaadiaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaadaaaaaadeaaaaakpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaah
pcaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaa
acaaaaaafgafbaaaaaaaaaaaegiccaaaabaaaaaaahaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaabaaaaaaagaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaiaaaaaakgakbaaaaaaaaaaa
egacbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaajaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaahhccabaaaagaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadoaaaaab"
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
					160
					Vector 48[_tintColor]
					Float 72[_groundTexStart]
					Float 76[_groundTexEnd]
					Float 136[_saturation]
					Float 140[_contrast]
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
					BindCB "UnityLighting"
					1
					BindCB "UnityPerDraw"
					2 "vs_4_0_level_9_1
eefiecednlkbbaijpellhicdfoldihjbajbaeaclabaaaaaamibbaaaaaeaaaaaa
daaaaaaaceagaaaadabaaaaapibaaaaaebgpgodjomafaaaaomafaaaaaaacpopp
haafaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaadaa
acaaabaaaaaaaaaaaaaaaiaaabaaadaaaaaaaaaaabaaacaaaiaaaeaaaaaaaaaa
abaacgaaahaaamaaaaaaaaaaacaaaaaaaiaabdaaaaaaaaaaacaaamaaaeaablaa
aaaaaaaaacaabeaaabaabpaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafcaaaapka
aaaaaaaaaaaaiadpaaaaaamaaaaaeaeafbaaaaafcbaaapkaihbgjjdokcefbgdp
nfhiojdnaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapja
bpaaaaacafaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjabpaaaaacafaaafia
afaaapjaabaaaaacaaaaadiaadaaoejaabaaaaacaaaaaeiaaeaaaajaceaaaaac
abaaahiaaaaaoeiacdaaaaacabaaahoaabaaoeiaabaaaaacaaaaahoaabaaoeia
afaaaaadaaaaabiaaaaaffjabiaakkkaaeaaaaaeaaaaabiabhaakkkaaaaaaaja
aaaaaaiaaeaaaaaeaaaaabiabjaakkkaaaaakkjaaaaaaaiaaeaaaaaeaaaaabia
bkaakkkaaaaappjaaaaaaaiaacaaaaadaaaaabiaaaaaaaibacaakkkbacaaaaad
aaaaaciaacaakkkbacaappkaagaaaaacaaaaaciaaaaaffiaafaaaaadaaaaabia
aaaaffiaaaaaaaiaalaaaaadaaaaabiaaaaaaaiacaaaaakaakaaaaadaaaaabia
aaaaaaiacaaaffkaaeaaaaaeaaaaaciaaaaaaaiacaaakkkacaaappkaafaaaaad
aaaaabiaaaaaaaiaaaaaaaiaafaaaaadacaaacoaaaaaaaiaaaaaffiaaiaaaaad
aaaaabiaafaaoejacbaaoekabcaaaaaeabaaahiaadaakkkaafaaoejaaaaaaaia
aeaaaaaeaaaaahiaabaaoekaabaappkbabaaoeiaafaaaaadabaaahiaabaappka
abaaoekaaeaaaaaeadaaahoaadaappkaaaaaoeiaabaaoeiaafaaaaadaaaaahia
aaaaffjabmaaoekaaeaaaaaeaaaaahiablaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaahiabnaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahiaboaaoekaaaaappja
aaaaoeiaacaaaaadabaaapiaaaaaffibafaaoekaafaaaaadacaaapiaabaaoeia
abaaoeiaacaaaaadadaaapiaaaaaaaibaeaaoekaacaaaaadaaaaapiaaaaakkib
agaaoekaaeaaaaaeacaaapiaadaaoeiaadaaoeiaacaaoeiaaeaaaaaeacaaapia
aaaaoeiaaaaaoeiaacaaoeiaahaaaaacaeaaabiaacaaaaiaahaaaaacaeaaacia
acaaffiaahaaaaacaeaaaeiaacaakkiaahaaaaacaeaaaiiaacaappiaabaaaaac
afaaaciacaaaffkaaeaaaaaeacaaapiaacaaoeiaahaaoekaafaaffiaafaaaaad
afaaahiaacaaoejabpaappkaafaaaaadagaaahiaafaaffiabmaaoekaaeaaaaae
afaaaliablaakekaafaaaaiaagaakeiaaeaaaaaeafaaahiabnaaoekaafaakkia
afaapeiaafaaaaadabaaapiaabaaoeiaafaaffiaaeaaaaaeabaaapiaadaaoeia
afaaaaiaabaaoeiaaeaaaaaeaaaaapiaaaaaoeiaafaakkiaabaaoeiaafaaaaad
aaaaapiaaeaaoeiaaaaaoeiaalaaaaadaaaaapiaaaaaoeiacaaaaakaagaaaaac
abaaabiaacaaaaiaagaaaaacabaaaciaacaaffiaagaaaaacabaaaeiaacaakkia
agaaaaacabaaaiiaacaappiaafaaaaadaaaaapiaaaaaoeiaabaaoeiaafaaaaad
abaaahiaaaaaffiaajaaoekaaeaaaaaeabaaahiaaiaaoekaaaaaaaiaabaaoeia
aeaaaaaeaaaaahiaakaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaahiaalaaoeka
aaaappiaaaaaoeiaabaaaaacafaaaiiacaaaffkaajaaaaadabaaabiaamaaoeka
afaaoeiaajaaaaadabaaaciaanaaoekaafaaoeiaajaaaaadabaaaeiaaoaaoeka
afaaoeiaafaaaaadacaaapiaafaacjiaafaakeiaajaaaaadadaaabiaapaaoeka
acaaoeiaajaaaaadadaaaciabaaaoekaacaaoeiaajaaaaadadaaaeiabbaaoeka
acaaoeiaacaaaaadabaaahiaabaaoeiaadaaoeiaafaaaaadaaaaaiiaafaaffia
afaaffiaaeaaaaaeaaaaaiiaafaaaaiaafaaaaiaaaaappibabaaaaacaeaaahoa
afaaoeiaaeaaaaaeabaaahiabcaaoekaaaaappiaabaaoeiaacaaaaadafaaahoa
aaaaoeiaabaaoeiaafaaaaadaaaaapiaaaaaffjabeaaoekaaeaaaaaeaaaaapia
bdaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiabfaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiabgaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacacaaaboaafaappja
ppppaaaafdeieefcaeakaaaaeaaaabaaibacaaaafjaaaaaeegiocaaaaaaaaaaa
ajaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaadbcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaacagaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaa
aaaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaaaaaaaaa
dgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaa
dkbabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaakbcaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaaaaaaaaakccaabaaa
aaaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaadkiacaaaaaaaaaaaaeaaaaaa
aoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
bkaabaaaaaaaaaaadicaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahcccabaaaadaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
dgaaaaafbccabaaaadaaaaaadkbabaaaafaaaaaabaaaaaakbcaabaaaaaaaaaaa
egbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaaaaaaaaai
ocaabaaaaaaaaaaaagaabaiaebaaaaaaaaaaaaaaagbjbaaaafaaaaaadcaaaaak
hcaabaaaaaaaaaaakgikcaaaaaaaaaaaaiaaaaaajgahbaaaaaaaaaaaagaabaaa
aaaaaaaadcaaaaamhcaabaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaadaaaaaa
pgipcaaaaaaaaaaaadaaaaaaegacbaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaa
pgipcaaaaaaaaaaaadaaaaaaegiccaaaaaaaaaaaadaaaaaadcaaaaakhccabaaa
aeaaaaaapgipcaaaaaaaaaaaaiaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaaaaaaaaaa
egaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaa
aaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaa
abaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaa
abaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaa
abaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaa
acaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaa
egiocaaaabaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaa
egiocaaaabaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaa
egiocaaaabaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaabaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
hcaabaaaacaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaajpcaabaaaadaaaaaa
fgafbaiaebaaaaaaacaaaaaaegiocaaaabaaaaaaadaaaaaadiaaaaahpcaabaaa
aeaaaaaafgafbaaaaaaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaaadaaaaaa
egaobaaaadaaaaaaegaobaaaadaaaaaaaaaaaaajpcaabaaaafaaaaaaagaabaia
ebaaaaaaacaaaaaaegiocaaaabaaaaaaacaaaaaaaaaaaaajpcaabaaaacaaaaaa
kgakbaiaebaaaaaaacaaaaaaegiocaaaabaaaaaaaeaaaaaadcaaaaajpcaabaaa
aeaaaaaaegaobaaaafaaaaaaagaabaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaaj
pcaabaaaaaaaaaaaegaobaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaaeaaaaaa
dcaaaaajpcaabaaaadaaaaaaegaobaaaafaaaaaaegaobaaaafaaaaaaegaobaaa
adaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaadaaaaaaeeaaaaafpcaabaaaadaaaaaaegaobaaaacaaaaaadcaaaaan
pcaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaabaaaaaaafaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaacaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaacaaaaaadiaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaadaaaaaadeaaaaakpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaah
pcaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaa
acaaaaaafgafbaaaaaaaaaaaegiccaaaabaaaaaaahaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaabaaaaaaagaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaiaaaaaakgakbaaaaaaaaaaa
egacbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaajaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaahhccabaaaagaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaa
ahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
lmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaadamaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaa
lmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
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
					Matrix 9[_Object2World]
					Vector 13[_ProjectionParams]
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
					Vector 30[_tintColor]
					Float 31[_groundTexStart]
					Float 32[_groundTexEnd]
					Float 33[_saturation]
					Float 34[_contrast]
					"!!ARBvp1.0
PARAM c[36] = { { 1, 0, 2, 3 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..34],
		{ 0.29899999, 0.58700001, 0.114, 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[29].w;
DP3 R4.x, R3, c[9];
DP3 R3.w, R3, c[10];
DP3 R3.x, R3, c[11];
DP4 R0.x, vertex.position, c[10];
ADD R1, -R0.x, c[15];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[9];
ADD R0, -R0.x, c[14];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MOV R4.w, c[0].x;
MAD R2, R4.x, R0, R2;
DP4 R4.y, vertex.position, c[11];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[16];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[17];
MOV R4.y, R3.w;
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].x;
DP4 R2.z, R4, c[24];
DP4 R2.y, R4, c[23];
DP4 R2.x, R4, c[22];
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
MUL R0, R4.xyzz, R4.yzzx;
MUL R1.w, R3, R3;
DP4 R4.w, R0, c[27];
DP4 R4.z, R0, c[26];
DP4 R4.y, R0, c[25];
MAD R1.w, R4.x, R4.x, -R1;
MUL R0.xyz, R1.w, c[28];
ADD R2.xyz, R2, R4.yzww;
ADD R0.xyz, R2, R0;
ADD result.texcoord[5].xyz, R0, R1;
DP3 R1.w, vertex.color, c[35];
ADD R1.xyz, vertex.color, -R1.w;
MAD R1.xyz, R1, c[33].x, R1.w;
MAD R1.xyz, -c[30], c[30].w, R1;
MUL R2.xyz, c[30], c[30].w;
MAD result.texcoord[3].xyz, R1, c[34].x, R2;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R4.yzw, R0.xxyw, c[35].w;
MOV result.position, R0;
MOV R0.y, c[31].x;
ADD R0.y, -R0, c[32].x;
MUL R1.y, R4.z, c[13].x;
MOV R1.x, R4.y;
ADD result.texcoord[6].xy, R1, R4.w;
MOV R1.xy, vertex.texcoord[0];
MOV R1.z, vertex.texcoord[1].x;
DP3 R1.w, R1, R1;
RSQ R0.x, R1.w;
MUL R1.xyz, R0.x, R1;
DP4 R0.x, vertex.position, c[3];
RCP R0.y, R0.y;
ADD R0.x, -R0, -c[31];
MUL R0.x, R0, R0.y;
MIN R0.x, R0, c[0];
MAX R0.x, R0, c[0].y;
MAD R0.y, -R0.x, c[0].z, c[0].w;
MUL R0.x, R0, R0;
MOV result.texcoord[0].xyz, R1;
ABS result.texcoord[1].xyz, R1;
MOV result.texcoord[6].zw, R0;
MUL result.texcoord[2].y, R0.x, R0;
MOV result.texcoord[4].z, R3.x;
MOV result.texcoord[4].y, R3.w;
MOV result.texcoord[4].x, R4;
MOV result.texcoord[2].x, vertex.color.w;
END
# 87 instructions, 5 R-regs
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
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 8[_Object2World]
					Vector 12[_ProjectionParams]
					Vector 13[_ScreenParams]
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
					Vector 30[_tintColor]
					Float 31[_groundTexStart]
					Float 32[_groundTexEnd]
					Float 33[_saturation]
					Float 34[_contrast]
					"vs_2_0
def c35, 1.00000000, 0.00000000, 2.00000000, 3.00000000
def c36, 0.29899999, 0.58700001, 0.11400000, 0.50000000
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
dcl_color0 v4
mul r3.xyz, v1, c29.w
dp3 r4.x, r3, c8
dp3 r3.w, r3, c9
dp3 r3.x, r3, c10
dp4 r0.x, v0, c9
add r1, -r0.x, c15
mul r2, r3.w, r1
dp4 r0.x, v0, c8
add r0, -r0.x, c14
mul r1, r1, r1
mov r4.z, r3.x
mov r4.w, c35.x
mad r2, r4.x, r0, r2
dp4 r4.y, v0, c10
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
add r1, r2, c35.x
dp4 r2.z, r4, c24
dp4 r2.y, r4, c23
dp4 r2.x, r4, c22
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c35.y
mul r0, r0, r1
mul r1.xyz, r0.y, c19
mad r1.xyz, r0.x, c18, r1
mad r0.xyz, r0.z, c20, r1
mad r1.xyz, r0.w, c21, r0
mul r0, r4.xyzz, r4.yzzx
mul r1.w, r3, r3
dp4 r4.w, r0, c27
dp4 r4.z, r0, c26
dp4 r4.y, r0, c25
mad r1.w, r4.x, r4.x, -r1
mul r0.xyz, r1.w, c28
add r2.xyz, r2, r4.yzww
add r0.xyz, r2, r0
add oT5.xyz, r0, r1
dp3 r1.w, v4, c36
add r1.xyz, v4, -r1.w
mad r1.xyz, r1, c33.x, r1.w
mad r1.xyz, -c30, c30.w, r1
mul r2.xyz, c30, c30.w
mad oT3.xyz, r1, c34.x, r2
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r4.yzw, r0.xxyw, c36.w
mov oPos, r0
mov r0.y, c32.x
add r0.y, -c31.x, r0
mul r1.y, r4.z, c12.x
mov r1.x, r4.y
mad oT6.xy, r4.w, c13.zwzw, r1
mov r1.xy, v2
mov r1.z, v3.x
dp3 r1.w, r1, r1
rsq r0.x, r1.w
mul r1.xyz, r0.x, r1
dp4 r0.x, v0, c2
rcp r0.y, r0.y
add r0.x, -r0, -c31
mul r0.x, r0, r0.y
min r0.x, r0, c35
max r0.x, r0, c35.y
mad r0.y, -r0.x, c35.z, c35.w
mul r0.x, r0, r0
mov oT0.xyz, r1
abs oT1.xyz, r1
mov oT6.zw, r0
mul oT2.y, r0.x, r0
mov oT4.z, r3.x
mov oT4.y, r3.w
mov oT4.x, r4
mov oT2.x, v4.w
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
					224
					Vector 112[_tintColor]
					Float 136[_groundTexStart]
					Float 140[_groundTexEnd]
					Float 200[_saturation]
					Float 204[_contrast]
					ConstBuffer "UnityPerCamera"
					128
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
eefiecedlbleemgfccbgdejfnfmplbfgchpejcigabaaaaaajaamaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
kmakaaaaeaaaabaaklacaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadbcbabaaaaeaaaaaafpaaaaad
pcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaa
gfaaaaadpccabaaaahaaaaaagiaaaaacahaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaabaaaaaa
akbabaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaabaaaaaa
egacbaaaabaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaabaaaaaa
diaaaaaibcaabaaaabaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaa
dcaaaaakbcaabaaaabaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaa
akaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaadaaaaaaagaaaaaa
ckbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaa
adaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaabaaaaaaaaaaaaakbcaabaaa
abaaaaaaakaabaiaebaaaaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaa
aaaaaaakccaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaadkiacaaa
aaaaaaaaaiaaaaaaaoaaaaakccaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpbkaabaaaabaaaaaadicaaaahbcaabaaaabaaaaaabkaabaaa
abaaaaaaakaabaaaabaaaaaadcaaaaajccaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahcccabaaaadaaaaaaakaabaaaabaaaaaa
bkaabaaaabaaaaaadgaaaaafbccabaaaadaaaaaadkbabaaaafaaaaaabaaaaaak
bcaabaaaabaaaaaaegbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdn
aaaaaaaaaaaaaaaiocaabaaaabaaaaaaagaabaiaebaaaaaaabaaaaaaagbjbaaa
afaaaaaadcaaaaakhcaabaaaabaaaaaakgikcaaaaaaaaaaaamaaaaaajgahbaaa
abaaaaaaagaabaaaabaaaaaadcaaaaamhcaabaaaabaaaaaaegiccaiaebaaaaaa
aaaaaaaaahaaaaaapgipcaaaaaaaaaaaahaaaaaaegacbaaaabaaaaaadiaaaaaj
hcaabaaaacaaaaaapgipcaaaaaaaaaaaahaaaaaaegiccaaaaaaaaaaaahaaaaaa
dcaaaaakhccabaaaaeaaaaaapgipcaaaaaaaaaaaamaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaacaaaaaapgipcaaa
adaaaaaabeaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaaklcaabaaaabaaaaaaegiicaaaadaaaaaaamaaaaaa
agaabaaaabaaaaaaegaibaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaaoaaaaaakgakbaaaabaaaaaaegadbaaaabaaaaaadgaaaaafhccabaaa
afaaaaaaegacbaaaabaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaacaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaa
bbaaaaaiccaabaaaacaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaa
bbaaaaaiecaabaaaacaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaa
diaaaaahpcaabaaaadaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaai
bcaabaaaaeaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaadaaaaaabbaaaaai
ccaabaaaaeaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaadaaaaaabbaaaaai
ecaabaaaaeaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaadaaaaaaaaaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaa
abaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakicaabaaaabaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaaabaaaaaaegacbaaa
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
agaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaahaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaahaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadoaaaaab"
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
					224
					Vector 112[_tintColor]
					Float 136[_groundTexStart]
					Float 140[_groundTexEnd]
					Float 200[_saturation]
					Float 204[_contrast]
					ConstBuffer "UnityPerCamera"
					128
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
eefiecedeinccndemhoodkdcajdkjcdnmikdimolabaaaaaaoabcaaaaaeaaaaaa
daaaaaaahmagaaaadabbaaaapibbaaaaebgpgodjeeagaaaaeeagaaaaaaacpopp
lmafaaaaiiaaaaaaaiaaceaaaaaaieaaaaaaieaaaaaaceaaabaaieaaaaaaahaa
acaaabaaaaaaaaaaaaaaamaaabaaadaaaaaaaaaaabaaafaaabaaaeaaaaaaaaaa
acaaacaaaiaaafaaaaaaaaaaacaacgaaahaaanaaaaaaaaaaadaaaaaaaiaabeaa
aaaaaaaaadaaamaaaeaabmaaaaaaaaaaadaabeaaabaacaaaaaaaaaaaaaaaaaaa
aaacpoppfbaaaaafcbaaapkaaaaaaaaaaaaaiadpaaaaaamaaaaaeaeafbaaaaaf
ccaaapkaihbgjjdokcefbgdpnfhiojdnaaaaaadpbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeia
aeaaapjabpaaaaacafaaafiaafaaapjaabaaaaacaaaaadiaadaaoejaabaaaaac
aaaaaeiaaeaaaajaceaaaaacabaaahiaaaaaoeiacdaaaaacabaaahoaabaaoeia
abaaaaacaaaaahoaabaaoeiaafaaaaadaaaaabiaaaaaffjabjaakkkaaeaaaaae
aaaaabiabiaakkkaaaaaaajaaaaaaaiaaeaaaaaeaaaaabiabkaakkkaaaaakkja
aaaaaaiaaeaaaaaeaaaaabiablaakkkaaaaappjaaaaaaaiaacaaaaadaaaaabia
aaaaaaibacaakkkbacaaaaadaaaaaciaacaakkkbacaappkaagaaaaacaaaaacia
aaaaffiaafaaaaadaaaaabiaaaaaffiaaaaaaaiaalaaaaadaaaaabiaaaaaaaia
cbaaaakaakaaaaadaaaaabiaaaaaaaiacbaaffkaaeaaaaaeaaaaaciaaaaaaaia
cbaakkkacbaappkaafaaaaadaaaaabiaaaaaaaiaaaaaaaiaafaaaaadacaaacoa
aaaaaaiaaaaaffiaaiaaaaadaaaaabiaafaaoejaccaaoekabcaaaaaeabaaahia
adaakkkaafaaoejaaaaaaaiaaeaaaaaeaaaaahiaabaaoekaabaappkbabaaoeia
afaaaaadabaaahiaabaappkaabaaoekaaeaaaaaeadaaahoaadaappkaaaaaoeia
abaaoeiaafaaaaadaaaaahiaaaaaffjabnaaoekaaeaaaaaeaaaaahiabmaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaahiaboaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaahiabpaaoekaaaaappjaaaaaoeiaacaaaaadabaaapiaaaaaffibagaaoeka
afaaaaadacaaapiaabaaoeiaabaaoeiaacaaaaadadaaapiaaaaaaaibafaaoeka
acaaaaadaaaaapiaaaaakkibahaaoekaaeaaaaaeacaaapiaadaaoeiaadaaoeia
acaaoeiaaeaaaaaeacaaapiaaaaaoeiaaaaaoeiaacaaoeiaahaaaaacaeaaabia
acaaaaiaahaaaaacaeaaaciaacaaffiaahaaaaacaeaaaeiaacaakkiaahaaaaac
aeaaaiiaacaappiaabaaaaacafaaaciacbaaffkaaeaaaaaeacaaapiaacaaoeia
aiaaoekaafaaffiaafaaaaadafaaahiaacaaoejacaaappkaafaaaaadagaaahia
afaaffiabnaaoekaaeaaaaaeafaaaliabmaakekaafaaaaiaagaakeiaaeaaaaae
afaaahiaboaaoekaafaakkiaafaapeiaafaaaaadabaaapiaabaaoeiaafaaffia
aeaaaaaeabaaapiaadaaoeiaafaaaaiaabaaoeiaaeaaaaaeaaaaapiaaaaaoeia
afaakkiaabaaoeiaafaaaaadaaaaapiaaeaaoeiaaaaaoeiaalaaaaadaaaaapia
aaaaoeiacbaaaakaagaaaaacabaaabiaacaaaaiaagaaaaacabaaaciaacaaffia
agaaaaacabaaaeiaacaakkiaagaaaaacabaaaiiaacaappiaafaaaaadaaaaapia
aaaaoeiaabaaoeiaafaaaaadabaaahiaaaaaffiaakaaoekaaeaaaaaeabaaahia
ajaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiaalaaoekaaaaakkiaabaaoeia
aeaaaaaeaaaaahiaamaaoekaaaaappiaaaaaoeiaabaaaaacafaaaiiacbaaffka
ajaaaaadabaaabiaanaaoekaafaaoeiaajaaaaadabaaaciaaoaaoekaafaaoeia
ajaaaaadabaaaeiaapaaoekaafaaoeiaafaaaaadacaaapiaafaacjiaafaakeia
ajaaaaadadaaabiabaaaoekaacaaoeiaajaaaaadadaaaciabbaaoekaacaaoeia
ajaaaaadadaaaeiabcaaoekaacaaoeiaacaaaaadabaaahiaabaaoeiaadaaoeia
afaaaaadaaaaaiiaafaaffiaafaaffiaaeaaaaaeaaaaaiiaafaaaaiaafaaaaia
aaaappibabaaaaacaeaaahoaafaaoeiaaeaaaaaeabaaahiabdaaoekaaaaappia
abaaoeiaacaaaaadafaaahoaaaaaoeiaabaaoeiaafaaaaadaaaaapiaaaaaffja
bfaaoekaaeaaaaaeaaaaapiabeaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
bgaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiabhaaoekaaaaappjaaaaaoeia
afaaaaadabaaabiaaaaaffiaaeaaaakaafaaaaadabaaaiiaabaaaaiaccaappka
afaaaaadabaaafiaaaaapeiaccaappkaacaaaaadagaaadoaabaakkiaabaaomia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacagaaamoaaaaaoeiaabaaaaacacaaaboaafaappjappppaaaafdeieefc
kmakaaaaeaaaabaaklacaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadbcbabaaaaeaaaaaafpaaaaad
pcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaa
gfaaaaadpccabaaaahaaaaaagiaaaaacahaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaabaaaaaa
akbabaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaabaaaaaa
egacbaaaabaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaabaaaaaa
diaaaaaibcaabaaaabaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaa
dcaaaaakbcaabaaaabaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaa
akaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaadaaaaaaagaaaaaa
ckbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaa
adaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaabaaaaaaaaaaaaakbcaabaaa
abaaaaaaakaabaiaebaaaaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaa
aaaaaaakccaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaadkiacaaa
aaaaaaaaaiaaaaaaaoaaaaakccaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpbkaabaaaabaaaaaadicaaaahbcaabaaaabaaaaaabkaabaaa
abaaaaaaakaabaaaabaaaaaadcaaaaajccaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahcccabaaaadaaaaaaakaabaaaabaaaaaa
bkaabaaaabaaaaaadgaaaaafbccabaaaadaaaaaadkbabaaaafaaaaaabaaaaaak
bcaabaaaabaaaaaaegbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdn
aaaaaaaaaaaaaaaiocaabaaaabaaaaaaagaabaiaebaaaaaaabaaaaaaagbjbaaa
afaaaaaadcaaaaakhcaabaaaabaaaaaakgikcaaaaaaaaaaaamaaaaaajgahbaaa
abaaaaaaagaabaaaabaaaaaadcaaaaamhcaabaaaabaaaaaaegiccaiaebaaaaaa
aaaaaaaaahaaaaaapgipcaaaaaaaaaaaahaaaaaaegacbaaaabaaaaaadiaaaaaj
hcaabaaaacaaaaaapgipcaaaaaaaaaaaahaaaaaaegiccaaaaaaaaaaaahaaaaaa
dcaaaaakhccabaaaaeaaaaaapgipcaaaaaaaaaaaamaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaacaaaaaapgipcaaa
adaaaaaabeaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaaklcaabaaaabaaaaaaegiicaaaadaaaaaaamaaaaaa
agaabaaaabaaaaaaegaibaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaaoaaaaaakgakbaaaabaaaaaaegadbaaaabaaaaaadgaaaaafhccabaaa
afaaaaaaegacbaaaabaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaacaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaa
bbaaaaaiccaabaaaacaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaa
bbaaaaaiecaabaaaacaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaa
diaaaaahpcaabaaaadaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaai
bcaabaaaaeaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaadaaaaaabbaaaaai
ccaabaaaaeaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaadaaaaaabbaaaaai
ecaabaaaaeaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaadaaaaaaaaaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaa
abaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakicaabaaaabaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaaabaaaaaaegacbaaa
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
agaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaahaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaahaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaa
aiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
neaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaneaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaadamaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaa
neaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaa
ahaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
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
					Float 2[_texTiling]
					Float 3[_texPower]
					Float 4[_multiFactor]
					Float 5[_PlanetOpacity]
					SetTexture 0[_mainTex] 2D 0 "!!ARBfp1.0
PARAM c[7] = { program.local[0..5],
		{ 0, 1, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MUL R2.xyz, fragment.texcoord[0], c[2].x;
MUL R5.xyz, fragment.texcoord[0], c[4].x;
ADD R0.w, -fragment.texcoord[2].y, c[6].y;
MOV result.color.w, c[5].x;
TEX R0.xyz, R2.zxzw, texture[0], 2D;
TEX R1.xyz, R2, texture[0], 2D;
TEX R2.xyz, R2.zyzw, texture[0], 2D;
TEX R3.xyz, R5.zxzw, texture[0], 2D;
TEX R4.xyz, R5, texture[0], 2D;
TEX R5.xyz, R5.zyzw, texture[0], 2D;
MUL R2.xyz, fragment.texcoord[1].x, R2;
MAD R1.xyz, fragment.texcoord[1].z, R1, R2;
MUL R5.xyz, fragment.texcoord[1].x, R5;
MAD R4.xyz, fragment.texcoord[1].z, R4, R5;
MAD R0.xyz, R0, fragment.texcoord[1].y, R1;
MAD R2.xyz, fragment.texcoord[1].y, R3, R4;
MUL R1.xyz, fragment.texcoord[2].y, R2;
MAD R0.xyz, R0, R0.w, R1;
MAD R0.xyz, fragment.texcoord[3], R0, -fragment.texcoord[3];
MAD R1.xyz, R0, c[3].x, fragment.texcoord[3];
MUL R0.xyz, R1, fragment.texcoord[5];
DP3 R0.w, fragment.texcoord[4], c[0];
MUL R1.xyz, R1, c[1];
MAX R0.w, R0, c[6].x;
MUL R1.xyz, R0.w, R1;
MAD result.color.xyz, R1, c[6].z, R0;
END
# 26 instructions, 6 R-regs
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
					Float 2[_texTiling]
					Float 3[_texPower]
					Float 4[_multiFactor]
					Float 5[_PlanetOpacity]
					SetTexture 0[_mainTex] 2D 0 "ps_2_0
dcl_2d s0
def c6, 0.00000000, 1.00000000, 2.00000000, 0
dcl t0.xyz
dcl t1.xyz
dcl t2.xy
dcl t3.xyz
dcl t4.xyz
dcl t5.xyz
mul r4.xyz, t0, c4.x
mov r3.xy, r4.zxyw
mul r1.xyz, t0, c2.x
mov r0.y, r4
mov r0.x, r4.z
mov r5.xy, r0
mov r0.y, r1
mov r0.x, r1.z
mov r2.xy, r0
mov r0.xy, r1.zxyw
texld r0, r0, s0
texld r1, r1, s0
texld r3, r3, s0
texld r2, r2, s0
texld r5, r5, s0
texld r4, r4, s0
mul r2.xyz, t1.x, r2
mad r1.xyz, t1.z, r1, r2
mad r0.xyz, r0, t1.y, r1
add r1.x, -t2.y, c6.y
mul r5.xyz, t1.x, r5
mad r4.xyz, t1.z, r4, r5
mad r3.xyz, t1.y, r3, r4
mul r2.xyz, t2.y, r3
mad r0.xyz, r0, r1.x, r2
mad r0.xyz, t3, r0, -t3
mad r0.xyz, r0, c3.x, t3
mul_pp r2.xyz, r0, c1
dp3_pp r1.x, t4, c0
max_pp r1.x, r1, c6
mul_pp r1.xyz, r1.x, r2
mul_pp r0.xyz, r0, t5
mov_pp r0.w, c5.x
mad_pp r0.xyz, r1, c6.z, r0
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
					SetTexture 0[_mainTex] 2D 0
					ConstBuffer "$Globals"
					160
					Vector 16[_LightColor0]
					Float 64[_texTiling]
					Float 68[_texPower]
					Float 80[_multiFactor]
					Float 132[_PlanetOpacity]
					ConstBuffer "UnityLighting"
					720
					Vector 0[_WorldSpaceLightPos0]
					BindCB "$Globals"
					0
					BindCB "UnityLighting"
					1 "ps_4_0
eefiecedaeljimmjcikekiebkejebbkcemiicpkdabaaaaaadmafaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadacaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcaeaeaaaaeaaaaaaaababaaaa
fjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
hcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadccbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadhcbabaaa
agaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaadiaaaaaihcaabaaa
aaaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaafaaaaaaefaaaaajpcaabaaa
abaaaaaaggakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaa
acaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaaaaaaaaacgakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaakgbkbaaaacaaaaaaegacbaaa
abaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaafgbfbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaafgbfbaaa
adaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaa
aeaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaagbabaaa
acaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaacgakbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaadaaaaaa
kgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
abaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaaiicaabaaaaaaaaaaa
bkbabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadpdcaaaaajhcaabaaaaaaaaaaa
egacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaiaebaaaaaaaeaaaaaa
dcaaaaakhcaabaaaaaaaaaaafgifcaaaaaaaaaaaaeaaaaaaegacbaaaaaaaaaaa
egbcbaaaaeaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaa
agaaaaaabaaaaaaiicaabaaaaaaaaaaaegbcbaaaafaaaaaaegiccaaaabaaaaaa
aaaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
aaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaaj
hccabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaagiccabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
					}
					SetTexture 0[_mainTex] 2D 0
					ConstBuffer "$Globals"
					160
					Vector 16[_LightColor0]
					Float 64[_texTiling]
					Float 68[_texPower]
					Float 80[_multiFactor]
					Float 132[_PlanetOpacity]
					ConstBuffer "UnityLighting"
					720
					Vector 0[_WorldSpaceLightPos0]
					BindCB "$Globals"
					0
					BindCB "UnityLighting"
					1 "ps_4_0_level_9_1
eefiecedfocaopiagokkbclkegblkdfknemfkniiabaaaaaaaeaiaaaaaeaaaaaa
daaaaaaapeacaaaaaaahaaaanaahaaaaebgpgodjlmacaaaalmacaaaaaaacpppp
geacaaaafiaaaaaaaeaaciaaaaaafiaaaaaafiaaabaaceaaaaaafiaaaaaaaaaa
aaaaabaaabaaaaaaaaaaaaaaaaaaaeaaacaaabaaaaaaaaaaaaaaaiaaabaaadaa
aaaaaaaaabaaaaaaabaaaeaaaaaaaaaaaaacppppfbaaaaafafaaapkaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaahlabpaaaaacaaaaaaia
abaaahlabpaaaaacaaaaaaiaacaaadlabpaaaaacaaaaaaiaadaaahlabpaaaaac
aaaaaaiaaeaachlabpaaaaacaaaaaaiaafaachlabpaaaaacaaaaaajaaaaiapka
afaaaaadaaaaahiaaaaaoelaabaaaakaabaaaaacabaaabiaaaaakkiaabaaaaac
abaaaciaaaaaffiaabaaaaacacaaadiaaaaanciaafaaaaadadaaahiaaaaaoela
acaaaakaabaaaaacaeaaabiaadaakkiaabaaaaacaeaaaciaadaaffiaabaaaaac
afaaadiaadaanciaecaaaaadabaaapiaabaaoeiaaaaioekaecaaaaadaaaaapia
aaaaoeiaaaaioekaecaaaaadacaaapiaacaaoeiaaaaioekaecaaaaadaeaaapia
aeaaoeiaaaaioekaecaaaaadadaaapiaadaaoeiaaaaioekaecaaaaadafaaapia
afaaoeiaaaaioekaafaaaaadabaaahiaabaaoeiaabaaaalaaeaaaaaeaaaaahia
aaaaoeiaabaakklaabaaoeiaaeaaaaaeaaaaahiaacaaoeiaabaafflaaaaaoeia
afaaaaadabaaahiaaeaaoeiaabaaaalaaeaaaaaeabaaahiaadaaoeiaabaakkla
abaaoeiaaeaaaaaeabaaahiaafaaoeiaabaafflaabaaoeiabcaaaaaeacaaahia
acaafflaabaaoeiaaaaaoeiaaeaaaaaeaaaaahiaadaaoelaacaaoeiaadaaoelb
aeaaaaaeaaaachiaabaaffkaaaaaoeiaadaaoelaafaaaaadabaachiaaaaaoeia
aaaaoekaafaaaaadaaaachiaaaaaoeiaafaaoelaaiaaaaadaaaaciiaaeaaoela
aeaaoekaalaaaaadabaaciiaaaaappiaafaaaakaacaaaaadaaaaciiaabaappia
abaappiaaeaaaaaeaaaachiaabaaoeiaaaaappiaaaaaoeiaabaaaaacaaaaciia
adaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcaeaeaaaaeaaaaaaa
ababaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadccbabaaa
adaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaad
hcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaadiaaaaai
hcaabaaaaaaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaafaaaaaaefaaaaaj
pcaabaaaabaaaaaaggakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaaaaaaaaacgakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaakgbkbaaaacaaaaaa
egacbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaafgbfbaaa
acaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
fgbfbaaaadaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaabaaaaaaagiacaaa
aaaaaaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
agbabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaacgakbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaa
adaaaaaakgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaa
egacbaaaabaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaaiicaabaaa
aaaaaaaabkbabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadpdcaaaaajhcaabaaa
aaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaiaebaaaaaa
aeaaaaaadcaaaaakhcaabaaaaaaaaaaafgifcaaaaaaaaaaaaeaaaaaaegacbaaa
aaaaaaaaegbcbaaaaeaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaaaaaaaaa
egiccaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egbcbaaaagaaaaaabaaaaaaiicaabaaaaaaaaaaaegbcbaaaafaaaaaaegiccaaa
abaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaa
dcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaagiccabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaadoaaaaab
ejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahahaaaa
lmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalmaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadacaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahahaaaa
lmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
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
					Float 2[_multiFactor]
					Float 3[_PlanetOpacity]
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[unity_Lightmap] 2D 1 "!!ARBfp1.0
PARAM c[5] = { program.local[0..3],
		{ 1, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEX R0, fragment.texcoord[4], texture[1], 2D;
MUL R5.xyz, fragment.texcoord[0], c[2].x;
MUL R2.xyz, fragment.texcoord[0], c[0].x;
ADD R1.w, -fragment.texcoord[2].y, c[4].x;
MUL R0.xyz, R0.w, R0;
MOV result.color.w, c[3].x;
TEX R3.xyz, R2.zxzw, texture[0], 2D;
TEX R1.xyz, R2, texture[0], 2D;
TEX R2.xyz, R2.zyzw, texture[0], 2D;
TEX R6.xyz, R5.zxzw, texture[0], 2D;
TEX R4.xyz, R5, texture[0], 2D;
TEX R5.xyz, R5.zyzw, texture[0], 2D;
MUL R2.xyz, fragment.texcoord[1].x, R2;
MAD R1.xyz, fragment.texcoord[1].z, R1, R2;
MUL R5.xyz, fragment.texcoord[1].x, R5;
MAD R4.xyz, fragment.texcoord[1].z, R4, R5;
MAD R2.xyz, fragment.texcoord[1].y, R6, R4;
MAD R1.xyz, R3, fragment.texcoord[1].y, R1;
MUL R2.xyz, fragment.texcoord[2].y, R2;
MAD R1.xyz, R1, R1.w, R2;
MAD R1.xyz, fragment.texcoord[3], R1, -fragment.texcoord[3];
MAD R1.xyz, R1, c[1].x, fragment.texcoord[3];
MUL R0.xyz, R0, R1;
MUL result.color.xyz, R0, c[4].y;
END
# 24 instructions, 7 R-regs
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
					Float 2[_multiFactor]
					Float 3[_PlanetOpacity]
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[unity_Lightmap] 2D 1 "ps_2_0
dcl_2d s0
dcl_2d s1
def c4, 1.00000000, 8.00000000, 0, 0
dcl t0.xyz
dcl t1.xyz
dcl t2.xy
dcl t3.xyz
dcl t4.xy
mul r5.xyz, t0, c2.x
mul r2.xyz, t0, c0.x
mov r4.xy, r5.zxyw
mov r1.xy, r2.zxyw
mov r0.y, r5
mov r0.x, r5.z
mov r6.xy, r0
mov r0.y, r2
mov r0.x, r2.z
mov r3.xy, r0
texld r0, t4, s1
texld r1, r1, s0
texld r2, r2, s0
texld r4, r4, s0
texld r3, r3, s0
texld r6, r6, s0
texld r5, r5, s0
mul_pp r0.xyz, r0.w, r0
mul r3.xyz, t1.x, r3
mad r2.xyz, t1.z, r2, r3
mad r1.xyz, r1, t1.y, r2
mul r6.xyz, t1.x, r6
mad r5.xyz, t1.z, r5, r6
mad r4.xyz, t1.y, r4, r5
mul r2.xyz, t2.y, r4
add r3.x, -t2.y, c4
mad r1.xyz, r1, r3.x, r2
mad r1.xyz, t3, r1, -t3
mad r1.xyz, r1, c1.x, t3
mul_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c4.y
mov_pp r0.w, c3.x
mov_pp oC0, r0
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
					}
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[unity_Lightmap] 2D 1
					ConstBuffer "$Globals"
					176
					Float 64[_texTiling]
					Float 68[_texPower]
					Float 80[_multiFactor]
					Float 132[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedmhfhfkknmhmkjdfcefebkfghnekcgodhabaaaaaaoeaeaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadacaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmeadaaaa
eaaaaaaapbaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadccbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
diaaaaaihcaabaaaaaaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaafaaaaaa
efaaaaajpcaabaaaabaaaaaaggakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaaacaaaaaa
efaaaaajpcaabaaaacaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaaaaaaaaacgakbaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaakgbkbaaa
acaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
fgbfbaaaacaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaafgbfbaaaadaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaabaaaaaa
agiacaaaaaaaaaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaacgakbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaadaaaaaakgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaa
abaaaaaaegacbaaaabaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaai
icaabaaaaaaaaaaabkbabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadpdcaaaaaj
hcaabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaia
ebaaaaaaaeaaaaaadcaaaaakhcaabaaaaaaaaaaafgifcaaaaaaaaaaaaeaaaaaa
egacbaaaaaaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaapgapbaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaagiccabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaa
doaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
					}
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[unity_Lightmap] 2D 1
					ConstBuffer "$Globals"
					176
					Float 64[_texTiling]
					Float 68[_texPower]
					Float 80[_multiFactor]
					Float 132[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0_level_9_1
eefiecednladpcpdlfmdcdpnmlhnbodepdicgghjabaaaaaaheahaaaaaeaaaaaa
daaaaaaalmacaaaaiiagaaaaeaahaaaaebgpgodjieacaaaaieacaaaaaaacpppp
eaacaaaaeeaaaaaaacaacmaaaaaaeeaaaaaaeeaaacaaceaaaaaaeeaaaaaaaaaa
abababaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaiaaabaaacaaaaaaaaaaaaacpppp
fbaaaaafadaaapkaaaaaaaebaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaaahlabpaaaaacaaaaaaiaabaaahlabpaaaaacaaaaaaiaacaaaplabpaaaaac
aaaaaaiaadaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
afaaaaadaaaaahiaaaaaoelaaaaaaakaabaaaaacabaaabiaaaaakkiaabaaaaac
abaaaciaaaaaffiaabaaaaacacaaadiaaaaanciaafaaaaadadaaahiaaaaaoela
abaaaakaabaaaaacaeaaabiaadaakkiaabaaaaacaeaaaciaadaaffiaabaaaaac
afaaadiaadaanciaabaaaaacagaaadiaacaabllaecaaaaadabaaapiaabaaoeia
aaaioekaecaaaaadaaaaapiaaaaaoeiaaaaioekaecaaaaadacaaapiaacaaoeia
aaaioekaecaaaaadaeaaapiaaeaaoeiaaaaioekaecaaaaadadaaapiaadaaoeia
aaaioekaecaaaaadafaaapiaafaaoeiaaaaioekaecaaaaadagaacpiaagaaoeia
abaioekaafaaaaadabaaahiaabaaoeiaabaaaalaaeaaaaaeaaaaahiaaaaaoeia
abaakklaabaaoeiaaeaaaaaeaaaaahiaacaaoeiaabaafflaaaaaoeiaafaaaaad
abaaahiaaeaaoeiaabaaaalaaeaaaaaeabaaahiaadaaoeiaabaakklaabaaoeia
aeaaaaaeabaaahiaafaaoeiaabaafflaabaaoeiabcaaaaaeacaaahiaacaaffla
abaaoeiaaaaaoeiaaeaaaaaeaaaaahiaadaaoelaacaaoeiaadaaoelbaeaaaaae
aaaachiaaaaaffkaaaaaoeiaadaaoelaafaaaaadaaaaciiaagaappiaadaaaaka
afaaaaadabaachiaagaaoeiaaaaappiaafaaaaadaaaachiaaaaaoeiaabaaoeia
abaaaaacaaaaciiaacaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
meadaaaaeaaaaaaapbaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadccbabaaaadaaaaaagcbaaaadmcbabaaa
adaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaa
afaaaaaaefaaaaajpcaabaaaabaaaaaaggakbaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaa
acaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaacgakbaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaa
kgbkbaaaacaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
aaaaaaaafgbfbaaaacaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaafgbfbaaaadaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaa
abaaaaaaagiacaaaaaaaaaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
cgakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaa
acaaaaaaegacbaaaadaaaaaakgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaaj
hcaabaaaabaaaaaaegacbaaaabaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaa
aaaaaaaiicaabaaaaaaaaaaabkbabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadp
dcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaa
egbcbaiaebaaaaaaaeaaaaaadcaaaaakhcaabaaaaaaaaaaafgifcaaaaaaaaaaa
aeaaaaaaegacbaaaaaaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaa
ogbkbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaapgapbaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaagiccabaaaaaaaaaaabkiacaaaaaaaaaaa
aiaaaaaadoaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaahahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
keaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadacaaaakeaaaaaaaeaaaaaa
aaaaaaaaadaaaaaaadaaaaaaamamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
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
					Float 2[_multiFactor]
					Float 3[_PlanetOpacity]
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[unity_Lightmap] 2D 1 "!!ARBfp1.0
PARAM c[5] = { program.local[0..3],
		{ 1, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEX R0, fragment.texcoord[4], texture[1], 2D;
MUL R5.xyz, fragment.texcoord[0], c[2].x;
MUL R2.xyz, fragment.texcoord[0], c[0].x;
ADD R1.w, -fragment.texcoord[2].y, c[4].x;
MUL R0.xyz, R0.w, R0;
MOV result.color.w, c[3].x;
TEX R3.xyz, R2.zxzw, texture[0], 2D;
TEX R1.xyz, R2, texture[0], 2D;
TEX R2.xyz, R2.zyzw, texture[0], 2D;
TEX R6.xyz, R5.zxzw, texture[0], 2D;
TEX R4.xyz, R5, texture[0], 2D;
TEX R5.xyz, R5.zyzw, texture[0], 2D;
MUL R2.xyz, fragment.texcoord[1].x, R2;
MAD R1.xyz, fragment.texcoord[1].z, R1, R2;
MUL R5.xyz, fragment.texcoord[1].x, R5;
MAD R4.xyz, fragment.texcoord[1].z, R4, R5;
MAD R2.xyz, fragment.texcoord[1].y, R6, R4;
MAD R1.xyz, R3, fragment.texcoord[1].y, R1;
MUL R2.xyz, fragment.texcoord[2].y, R2;
MAD R1.xyz, R1, R1.w, R2;
MAD R1.xyz, fragment.texcoord[3], R1, -fragment.texcoord[3];
MAD R1.xyz, R1, c[1].x, fragment.texcoord[3];
MUL R0.xyz, R0, R1;
MUL result.color.xyz, R0, c[4].y;
END
# 24 instructions, 7 R-regs
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
					Float 2[_multiFactor]
					Float 3[_PlanetOpacity]
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[unity_Lightmap] 2D 1 "ps_2_0
dcl_2d s0
dcl_2d s1
def c4, 1.00000000, 8.00000000, 0, 0
dcl t0.xyz
dcl t1.xyz
dcl t2.xy
dcl t3.xyz
dcl t4.xy
mul r5.xyz, t0, c2.x
mul r2.xyz, t0, c0.x
mov r4.xy, r5.zxyw
mov r1.xy, r2.zxyw
mov r0.y, r5
mov r0.x, r5.z
mov r6.xy, r0
mov r0.y, r2
mov r0.x, r2.z
mov r3.xy, r0
texld r0, t4, s1
texld r1, r1, s0
texld r2, r2, s0
texld r4, r4, s0
texld r3, r3, s0
texld r6, r6, s0
texld r5, r5, s0
mul_pp r0.xyz, r0.w, r0
mul r3.xyz, t1.x, r3
mad r2.xyz, t1.z, r2, r3
mad r1.xyz, r1, t1.y, r2
mul r6.xyz, t1.x, r6
mad r5.xyz, t1.z, r5, r6
mad r4.xyz, t1.y, r4, r5
mul r2.xyz, t2.y, r4
add r3.x, -t2.y, c4
mad r1.xyz, r1, r3.x, r2
mad r1.xyz, t3, r1, -t3
mad r1.xyz, r1, c1.x, t3
mul_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c4.y
mov_pp r0.w, c3.x
mov_pp oC0, r0
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
					}
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[unity_Lightmap] 2D 1
					ConstBuffer "$Globals"
					176
					Float 64[_texTiling]
					Float 68[_texPower]
					Float 80[_multiFactor]
					Float 132[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedmhfhfkknmhmkjdfcefebkfghnekcgodhabaaaaaaoeaeaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadacaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmeadaaaa
eaaaaaaapbaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadccbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
diaaaaaihcaabaaaaaaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaafaaaaaa
efaaaaajpcaabaaaabaaaaaaggakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaaacaaaaaa
efaaaaajpcaabaaaacaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaaaaaaaaacgakbaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaakgbkbaaa
acaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
fgbfbaaaacaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaafgbfbaaaadaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaabaaaaaa
agiacaaaaaaaaaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaacgakbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaadaaaaaakgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaa
abaaaaaaegacbaaaabaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaai
icaabaaaaaaaaaaabkbabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadpdcaaaaaj
hcaabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaia
ebaaaaaaaeaaaaaadcaaaaakhcaabaaaaaaaaaaafgifcaaaaaaaaaaaaeaaaaaa
egacbaaaaaaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaapgapbaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaagiccabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaa
doaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_OFF"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
					}
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[unity_Lightmap] 2D 1
					ConstBuffer "$Globals"
					176
					Float 64[_texTiling]
					Float 68[_texPower]
					Float 80[_multiFactor]
					Float 132[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0_level_9_1
eefiecednladpcpdlfmdcdpnmlhnbodepdicgghjabaaaaaaheahaaaaaeaaaaaa
daaaaaaalmacaaaaiiagaaaaeaahaaaaebgpgodjieacaaaaieacaaaaaaacpppp
eaacaaaaeeaaaaaaacaacmaaaaaaeeaaaaaaeeaaacaaceaaaaaaeeaaaaaaaaaa
abababaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaiaaabaaacaaaaaaaaaaaaacpppp
fbaaaaafadaaapkaaaaaaaebaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaaahlabpaaaaacaaaaaaiaabaaahlabpaaaaacaaaaaaiaacaaaplabpaaaaac
aaaaaaiaadaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
afaaaaadaaaaahiaaaaaoelaaaaaaakaabaaaaacabaaabiaaaaakkiaabaaaaac
abaaaciaaaaaffiaabaaaaacacaaadiaaaaanciaafaaaaadadaaahiaaaaaoela
abaaaakaabaaaaacaeaaabiaadaakkiaabaaaaacaeaaaciaadaaffiaabaaaaac
afaaadiaadaanciaabaaaaacagaaadiaacaabllaecaaaaadabaaapiaabaaoeia
aaaioekaecaaaaadaaaaapiaaaaaoeiaaaaioekaecaaaaadacaaapiaacaaoeia
aaaioekaecaaaaadaeaaapiaaeaaoeiaaaaioekaecaaaaadadaaapiaadaaoeia
aaaioekaecaaaaadafaaapiaafaaoeiaaaaioekaecaaaaadagaacpiaagaaoeia
abaioekaafaaaaadabaaahiaabaaoeiaabaaaalaaeaaaaaeaaaaahiaaaaaoeia
abaakklaabaaoeiaaeaaaaaeaaaaahiaacaaoeiaabaafflaaaaaoeiaafaaaaad
abaaahiaaeaaoeiaabaaaalaaeaaaaaeabaaahiaadaaoeiaabaakklaabaaoeia
aeaaaaaeabaaahiaafaaoeiaabaafflaabaaoeiabcaaaaaeacaaahiaacaaffla
abaaoeiaaaaaoeiaaeaaaaaeaaaaahiaadaaoelaacaaoeiaadaaoelbaeaaaaae
aaaachiaaaaaffkaaaaaoeiaadaaoelaafaaaaadaaaaciiaagaappiaadaaaaka
afaaaaadabaachiaagaaoeiaaaaappiaafaaaaadaaaachiaaaaaoeiaabaaoeia
abaaaaacaaaaciiaacaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
meadaaaaeaaaaaaapbaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadccbabaaaadaaaaaagcbaaaadmcbabaaa
adaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaa
afaaaaaaefaaaaajpcaabaaaabaaaaaaggakbaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaa
acaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaacgakbaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaa
kgbkbaaaacaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
aaaaaaaafgbfbaaaacaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaafgbfbaaaadaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaa
abaaaaaaagiacaaaaaaaaaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
cgakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaa
acaaaaaaegacbaaaadaaaaaakgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaaj
hcaabaaaabaaaaaaegacbaaaabaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaa
aaaaaaaiicaabaaaaaaaaaaabkbabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadp
dcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaa
egbcbaiaebaaaaaaaeaaaaaadcaaaaakhcaabaaaaaaaaaaafgifcaaaaaaaaaaa
aeaaaaaaegacbaaaaaaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaa
ogbkbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaapgapbaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaagiccabaaaaaaaaaaabkiacaaaaaaaaaaa
aiaaaaaadoaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaahahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
keaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadacaaaakeaaaaaaaeaaaaaa
aaaaaaaaadaaaaaaadaaaaaaamamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
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
					Float 2[_texTiling]
					Float 3[_texPower]
					Float 4[_multiFactor]
					Float 5[_PlanetOpacity]
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_ShadowMapTexture] 2D 1 "!!ARBfp1.0
PARAM c[7] = { program.local[0..5],
		{ 0, 1, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TXP R6.x, fragment.texcoord[6], texture[1], 2D;
MUL R2.xyz, fragment.texcoord[0], c[2].x;
MUL R5.xyz, fragment.texcoord[0], c[4].x;
ADD R0.w, -fragment.texcoord[2].y, c[6].y;
MOV result.color.w, c[5].x;
TEX R0.xyz, R2.zxzw, texture[0], 2D;
TEX R1.xyz, R2, texture[0], 2D;
TEX R2.xyz, R2.zyzw, texture[0], 2D;
TEX R3.xyz, R5.zxzw, texture[0], 2D;
TEX R4.xyz, R5, texture[0], 2D;
TEX R5.xyz, R5.zyzw, texture[0], 2D;
MUL R2.xyz, fragment.texcoord[1].x, R2;
MAD R1.xyz, fragment.texcoord[1].z, R1, R2;
MUL R5.xyz, fragment.texcoord[1].x, R5;
MAD R4.xyz, fragment.texcoord[1].z, R4, R5;
MAD R0.xyz, R0, fragment.texcoord[1].y, R1;
MAD R2.xyz, fragment.texcoord[1].y, R3, R4;
MUL R1.xyz, fragment.texcoord[2].y, R2;
MAD R0.xyz, R0, R0.w, R1;
MAD R0.xyz, fragment.texcoord[3], R0, -fragment.texcoord[3];
MAD R0.xyz, R0, c[3].x, fragment.texcoord[3];
MUL R1.xyz, R0, fragment.texcoord[5];
DP3 R0.w, fragment.texcoord[4], c[0];
MAX R0.w, R0, c[6].x;
MUL R0.xyz, R0, c[1];
MUL R0.w, R0, R6.x;
MUL R0.xyz, R0.w, R0;
MAD result.color.xyz, R0, c[6].z, R1;
END
# 28 instructions, 7 R-regs
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
					Float 2[_texTiling]
					Float 3[_texPower]
					Float 4[_multiFactor]
					Float 5[_PlanetOpacity]
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_ShadowMapTexture] 2D 1 "ps_2_0
dcl_2d s0
dcl_2d s1
def c6, 0.00000000, 1.00000000, 2.00000000, 0
dcl t0.xyz
dcl t1.xyz
dcl t2.xy
dcl t3.xyz
dcl t4.xyz
dcl t5.xyz
dcl t6
texldp r2, t6, s1
mul r5.xyz, t0, c4.x
mov r4.xy, r5.zxyw
mul r1.xyz, t0, c2.x
mov r0.y, r5
mov r0.x, r5.z
mov r6.xy, r0
mov r0.y, r1
mov r0.x, r1.z
mov r3.xy, r0
mov r0.xy, r1.zxyw
texld r0, r0, s0
texld r1, r1, s0
texld r4, r4, s0
texld r3, r3, s0
texld r6, r6, s0
texld r5, r5, s0
mul r3.xyz, t1.x, r3
mad r1.xyz, t1.z, r1, r3
mad r1.xyz, r0, t1.y, r1
mul r6.xyz, t1.x, r6
mad r5.xyz, t1.z, r5, r6
mad r4.xyz, t1.y, r4, r5
mul r3.xyz, t2.y, r4
add r0.x, -t2.y, c6.y
mad r0.xyz, r1, r0.x, r3
mad r0.xyz, t3, r0, -t3
mad r0.xyz, r0, c3.x, t3
mul_pp r3.xyz, r0, c1
dp3_pp r1.x, t4, c0
max_pp r1.x, r1, c6
mul_pp r1.x, r1, r2
mul_pp r1.xyz, r1.x, r3
mul_pp r0.xyz, r0, t5
mov_pp r0.w, c5.x
mad_pp r0.xyz, r1, c6.z, r0
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
					SetTexture 0[_mainTex] 2D 1
					SetTexture 1[_ShadowMapTexture] 2D 0
					ConstBuffer "$Globals"
					224
					Vector 16[_LightColor0]
					Float 128[_texTiling]
					Float 132[_texPower]
					Float 144[_multiFactor]
					Float 196[_PlanetOpacity]
					ConstBuffer "UnityLighting"
					720
					Vector 0[_WorldSpaceLightPos0]
					BindCB "$Globals"
					0
					BindCB "UnityLighting"
					1 "ps_4_0
eefiecedghkblmalidncpmggcegmojllodcjajngabaaaaaalmafaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadacaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcgmaeaaaaeaaaaaaablabaaaafjaaaaaeegiocaaa
aaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadccbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gcbaaaadhcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaagcbaaaadlcbabaaa
ahaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaadiaaaaaihcaabaaa
aaaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaa
abaaaaaaggakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaa
acaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaaj
pcaabaaaaaaaaaaacgakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaakgbkbaaaacaaaaaaegacbaaa
abaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaafgbfbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaafgbfbaaa
adaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaa
aiaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaagbabaaa
acaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaacgakbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaadaaaaaa
kgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
abaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaaiicaabaaaaaaaaaaa
bkbabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadpdcaaaaajhcaabaaaaaaaaaaa
egacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaiaebaaaaaaaeaaaaaa
dcaaaaakhcaabaaaaaaaaaaafgifcaaaaaaaaaaaaiaaaaaaegacbaaaaaaaaaaa
egbcbaaaaeaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaa
agaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaaahaaaaaapgbpbaaaahaaaaaa
efaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaabaaaaaaiicaabaaaaaaaaaaaegbcbaaaafaaaaaaegiccaaaabaaaaaa
aaaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
apaaaaahicaabaaaaaaaaaaapgapbaaaaaaaaaaaagaabaaaacaaaaaadcaaaaaj
hccabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaagiccabaaaaaaaaaaabkiacaaaaaaaaaaaamaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
					}
					SetTexture 0[_mainTex] 2D 1
					SetTexture 1[_ShadowMapTexture] 2D 0
					ConstBuffer "$Globals"
					224
					Vector 16[_LightColor0]
					Float 128[_texTiling]
					Float 132[_texPower]
					Float 144[_multiFactor]
					Float 196[_PlanetOpacity]
					ConstBuffer "UnityLighting"
					720
					Vector 0[_WorldSpaceLightPos0]
					BindCB "$Globals"
					0
					BindCB "UnityLighting"
					1 "ps_4_0_level_9_1
eefiecededjkdepbnkkllkhiechifepnoepjhclfabaaaaaaoaaiaaaaaeaaaaaa
daaaaaaafaadaaaameahaaaakmaiaaaaebgpgodjbiadaaaabiadaaaaaaacpppp
lmacaaaafmaaaaaaaeaacmaaaaaafmaaaaaafmaaacaaceaaaaaafmaaabaaaaaa
aaababaaaaaaabaaabaaaaaaaaaaaaaaaaaaaiaaacaaabaaaaaaaaaaaaaaamaa
abaaadaaaaaaaaaaabaaaaaaabaaaeaaaaaaaaaaaaacppppfbaaaaafafaaapka
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaahlabpaaaaac
aaaaaaiaabaaahlabpaaaaacaaaaaaiaacaaadlabpaaaaacaaaaaaiaadaaahla
bpaaaaacaaaaaaiaaeaachlabpaaaaacaaaaaaiaafaachlabpaaaaacaaaaaaia
agaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaafaaaaad
aaaaahiaaaaaoelaabaaaakaabaaaaacabaaabiaaaaakkiaabaaaaacabaaacia
aaaaffiaabaaaaacacaaadiaaaaanciaafaaaaadadaaahiaaaaaoelaacaaaaka
abaaaaacaeaaabiaadaakkiaabaaaaacaeaaaciaadaaffiaabaaaaacafaaadia
adaanciaagaaaaacaaaaaeiaagaapplaafaaaaadagaaadiaaaaakkiaagaaoela
ecaaaaadabaaapiaabaaoeiaabaioekaecaaaaadaaaaapiaaaaaoeiaabaioeka
ecaaaaadacaaapiaacaaoeiaabaioekaecaaaaadaeaaapiaaeaaoeiaabaioeka
ecaaaaadadaaapiaadaaoeiaabaioekaecaaaaadafaaapiaafaaoeiaabaioeka
ecaaaaadagaacpiaagaaoeiaaaaioekaafaaaaadabaaahiaabaaoeiaabaaaala
aeaaaaaeaaaaahiaaaaaoeiaabaakklaabaaoeiaaeaaaaaeaaaaahiaacaaoeia
abaafflaaaaaoeiaafaaaaadabaaahiaaeaaoeiaabaaaalaaeaaaaaeabaaahia
adaaoeiaabaakklaabaaoeiaaeaaaaaeabaaahiaafaaoeiaabaafflaabaaoeia
bcaaaaaeacaaahiaacaafflaabaaoeiaaaaaoeiaaeaaaaaeaaaaahiaadaaoela
acaaoeiaadaaoelbaeaaaaaeaaaachiaabaaffkaaaaaoeiaadaaoelaafaaaaad
abaachiaaaaaoeiaaaaaoekaafaaaaadaaaachiaaaaaoeiaafaaoelaaiaaaaad
aaaaciiaaeaaoelaaeaaoekaafaaaaadabaaciiaagaaaaiaaaaappiafiaaaaae
aaaaciiaaaaappiaabaappiaafaaaakaacaaaaadaaaaciiaaaaappiaaaaappia
aeaaaaaeaaaachiaabaaoeiaaaaappiaaaaaoeiaabaaaaacaaaaciiaadaaffka
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcgmaeaaaaeaaaaaaablabaaaa
fjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadccbabaaaadaaaaaagcbaaaad
hcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaa
gcbaaaadlcbabaaaahaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
diaaaaaihcaabaaaaaaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaajaaaaaa
efaaaaajpcaabaaaabaaaaaaggakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaaacaaaaaa
efaaaaajpcaabaaaacaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaaaaaaaaacgakbaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaakgbkbaaa
acaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
fgbfbaaaacaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaafgbfbaaaadaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaabaaaaaa
agiacaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaacgakbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaadaaaaaakgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaa
abaaaaaaegacbaaaabaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaai
icaabaaaaaaaaaaabkbabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadpdcaaaaaj
hcaabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaia
ebaaaaaaaeaaaaaadcaaaaakhcaabaaaaaaaaaaafgifcaaaaaaaaaaaaiaaaaaa
egacbaaaaaaaaaaaegbcbaaaaeaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegbcbaaaagaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaaahaaaaaa
pgbpbaaaahaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaaaaaaaaabaaaaaaiicaabaaaaaaaaaaaegbcbaaaafaaaaaa
egiccaaaabaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaapgapbaaaaaaaaaaaagaabaaa
acaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaagiccabaaaaaaaaaaabkiacaaaaaaaaaaaamaaaaaa
doaaaaabejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
ahahaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaneaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaadacaaaaneaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaaneaaaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaa
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
					Float 0[_texTiling]
					Float 1[_texPower]
					Float 2[_multiFactor]
					Float 3[_PlanetOpacity]
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_ShadowMapTexture] 2D 1
					SetTexture 2[unity_Lightmap] 2D 2 "!!ARBfp1.0
PARAM c[5] = { program.local[0..3],
		{ 1, 8, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEX R0, fragment.texcoord[4], texture[2], 2D;
TXP R7.x, fragment.texcoord[5], texture[1], 2D;
MUL R5.xyz, fragment.texcoord[0], c[2].x;
MUL R2.xyz, fragment.texcoord[0], c[0].x;
ADD R1.w, -fragment.texcoord[2].y, c[4].x;
MOV result.color.w, c[3].x;
TEX R3.xyz, R2.zxzw, texture[0], 2D;
TEX R1.xyz, R2, texture[0], 2D;
TEX R2.xyz, R2.zyzw, texture[0], 2D;
TEX R6.xyz, R5.zxzw, texture[0], 2D;
TEX R4.xyz, R5, texture[0], 2D;
TEX R5.xyz, R5.zyzw, texture[0], 2D;
MUL R2.xyz, fragment.texcoord[1].x, R2;
MAD R1.xyz, fragment.texcoord[1].z, R1, R2;
MUL R5.xyz, fragment.texcoord[1].x, R5;
MAD R4.xyz, fragment.texcoord[1].z, R4, R5;
MAD R2.xyz, fragment.texcoord[1].y, R6, R4;
MAD R1.xyz, R3, fragment.texcoord[1].y, R1;
MUL R2.xyz, fragment.texcoord[2].y, R2;
MAD R1.xyz, R1, R1.w, R2;
MUL R2.xyz, R0.w, R0;
MUL R2.xyz, R2, c[4].y;
MAD R1.xyz, fragment.texcoord[3], R1, -fragment.texcoord[3];
MUL R0.xyz, R0, R7.x;
MUL R0.xyz, R0, c[4].z;
MUL R3.xyz, R2, R7.x;
MIN R0.xyz, R2, R0;
MAX R0.xyz, R0, R3;
MAD R1.xyz, R1, c[1].x, fragment.texcoord[3];
MUL result.color.xyz, R1, R0;
END
# 30 instructions, 8 R-regs
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
					Float 2[_multiFactor]
					Float 3[_PlanetOpacity]
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_ShadowMapTexture] 2D 1
					SetTexture 2[unity_Lightmap] 2D 2 "ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c4, 1.00000000, 8.00000000, 2.00000000, 0
dcl t0.xyz
dcl t1.xyz
dcl t2.xy
dcl t3.xyz
dcl t4.xy
dcl t5
texldp r5, t5, s1
mul r6.xyz, t0, c2.x
mul r2.xyz, t0, c0.x
mov r4.xy, r6.zxyw
mov r1.xy, r2.zxyw
mov r0.y, r6
mov r0.x, r6.z
mov r7.xy, r0
mov r0.y, r2
mov r0.x, r2.z
mov r3.xy, r0
texld r0, t4, s2
texld r1, r1, s0
texld r2, r2, s0
texld r4, r4, s0
texld r3, r3, s0
texld r7, r7, s0
texld r6, r6, s0
mul r3.xyz, t1.x, r3
mad r2.xyz, t1.z, r2, r3
mad r1.xyz, r1, t1.y, r2
add r3.x, -t2.y, c4
mul r7.xyz, t1.x, r7
mad r6.xyz, t1.z, r6, r7
mad r4.xyz, t1.y, r4, r6
mul r2.xyz, t2.y, r4
mad r1.xyz, r1, r3.x, r2
mul_pp r3.xyz, r0.w, r0
mul_pp r2.xyz, r0, r5.x
mul_pp r0.xyz, r3, c4.y
mul_pp r3.xyz, r2, c4.z
mul_pp r2.xyz, r0, r5.x
mad r1.xyz, t3, r1, -t3
min_pp r0.xyz, r0, r3
max_pp r0.xyz, r0, r2
mad r1.xyz, r1, c1.x, t3
mul_pp r0.xyz, r1, r0
mov_pp r0.w, c3.x
mov_pp oC0, r0
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
					}
					SetTexture 0[_mainTex] 2D 1
					SetTexture 1[_ShadowMapTexture] 2D 0
					SetTexture 2[unity_Lightmap] 2D 2
					ConstBuffer "$Globals"
					240
					Float 128[_texTiling]
					Float 132[_texPower]
					Float 144[_multiFactor]
					Float 196[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedhhgdkadgajcgomgnapemlpfkejgppkidabaaaaaapaafaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadacaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcliaeaaaaeaaaaaaacoabaaaa
fjaaaaaeegiocaaaaaaaaaaaanaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
ccbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gcbaaaadlcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
diaaaaaihcaabaaaaaaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaajaaaaaa
efaaaaajpcaabaaaabaaaaaaggakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaaacaaaaaa
efaaaaajpcaabaaaacaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaaaaaaaaacgakbaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaakgbkbaaa
acaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
fgbfbaaaacaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaafgbfbaaaadaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaabaaaaaa
agiacaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaacgakbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaadaaaaaakgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaa
abaaaaaaegacbaaaabaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaai
icaabaaaaaaaaaaabkbabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadpdcaaaaaj
hcaabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaia
ebaaaaaaaeaaaaaadcaaaaakhcaabaaaaaaaaaaafgifcaaaaaaaaaaaaiaaaaaa
egacbaaaaaaaaaaaegbcbaaaaeaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaa
afaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaadaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahocaabaaaabaaaaaapgapbaaa
aaaaaaaaagajbaaaacaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaacaaaaaa
abeaaaaaaaaaaaebdiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaa
aaaaaaaaddaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaaacaaaaaa
diaaaaahhcaabaaaacaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadeaaaaah
hcaabaaaabaaaaaajgahbaaaabaaaaaaegacbaaaacaaaaaadiaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaagiccabaaaaaaaaaaa
bkiacaaaaaaaaaaaamaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
					}
					SetTexture 0[_mainTex] 2D 1
					SetTexture 1[_ShadowMapTexture] 2D 0
					SetTexture 2[unity_Lightmap] 2D 2
					ConstBuffer "$Globals"
					240
					Float 128[_texTiling]
					Float 132[_texPower]
					Float 144[_multiFactor]
					Float 196[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0_level_9_1
eefiecedkdioccdngokielkjpoopmccnlnamjijjabaaaaaabiajaaaaaeaaaaaa
daaaaaaafeadaaaabeaiaaaaoeaiaaaaebgpgodjbmadaaaabmadaaaaaaacpppp
neacaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaabaaaaaa
aaababaaacacacaaaaaaaiaaacaaaaaaaaaaaaaaaaaaamaaabaaacaaaaaaaaaa
aaacppppfbaaaaafadaaapkaaaaaaaebaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaahlabpaaaaacaaaaaaiaabaaahlabpaaaaacaaaaaaiaacaaapla
bpaaaaacaaaaaaiaadaaahlabpaaaaacaaaaaaiaaeaaaplabpaaaaacaaaaaaja
aaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaafaaaaad
aaaaahiaaaaaoelaaaaaaakaabaaaaacabaaabiaaaaakkiaabaaaaacabaaacia
aaaaffiaabaaaaacacaaadiaaaaanciaafaaaaadadaaahiaaaaaoelaabaaaaka
abaaaaacaeaaabiaadaakkiaabaaaaacaeaaaciaadaaffiaabaaaaacafaaadia
adaanciaagaaaaacaaaaaeiaaeaapplaafaaaaadagaaadiaaaaakkiaaeaaoela
abaaaaacahaaadiaacaabllaecaaaaadabaaapiaabaaoeiaabaioekaecaaaaad
aaaaapiaaaaaoeiaabaioekaecaaaaadacaaapiaacaaoeiaabaioekaecaaaaad
aeaaapiaaeaaoeiaabaioekaecaaaaadadaaapiaadaaoeiaabaioekaecaaaaad
afaaapiaafaaoeiaabaioekaecaaaaadagaacpiaagaaoeiaaaaioekaecaaaaad
ahaacpiaahaaoeiaacaioekaafaaaaadabaaahiaabaaoeiaabaaaalaaeaaaaae
aaaaahiaaaaaoeiaabaakklaabaaoeiaaeaaaaaeaaaaahiaacaaoeiaabaaffla
aaaaoeiaafaaaaadabaaahiaaeaaoeiaabaaaalaaeaaaaaeabaaahiaadaaoeia
abaakklaabaaoeiaaeaaaaaeabaaahiaafaaoeiaabaafflaabaaoeiabcaaaaae
acaaahiaacaafflaabaaoeiaaaaaoeiaaeaaaaaeaaaaahiaadaaoelaacaaoeia
adaaoelbaeaaaaaeaaaachiaaaaaffkaaaaaoeiaadaaoelaacaaaaadaaaaciia
agaaaaiaagaaaaiaafaaaaadabaachiaahaaoeiaaaaappiaafaaaaadaaaaciia
ahaappiaadaaaakaafaaaaadacaachiaahaaoeiaaaaappiaakaaaaadadaachia
abaaoeiaacaaoeiaafaaaaadabaachiaagaaaaiaacaaoeiaalaaaaadacaachia
adaaoeiaabaaoeiaafaaaaadaaaachiaaaaaoeiaacaaoeiaabaaaaacaaaaciia
acaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcliaeaaaaeaaaaaaa
coabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadccbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagcbaaaadlcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaa
ajaaaaaaefaaaaajpcaabaaaabaaaaaaggakbaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaa
acaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaacgakbaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaa
kgbkbaaaacaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
aaaaaaaafgbfbaaaacaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaafgbfbaaaadaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaa
abaaaaaaagiacaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
cgakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaa
acaaaaaaegacbaaaadaaaaaakgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaaj
hcaabaaaabaaaaaaegacbaaaabaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaa
aaaaaaaiicaabaaaaaaaaaaabkbabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadp
dcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaa
egbcbaiaebaaaaaaaeaaaaaadcaaaaakhcaabaaaaaaaaaaafgifcaaaaaaaaaaa
aiaaaaaaegacbaaaaaaaaaaaegbcbaaaaeaaaaaaaoaaaaahdcaabaaaabaaaaaa
egbabaaaafaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaa
adaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahocaabaaaabaaaaaa
pgapbaaaaaaaaaaaagajbaaaacaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
acaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
pgapbaaaaaaaaaaaddaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaa
acaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaa
deaaaaahhcaabaaaabaaaaaajgahbaaaabaaaaaaegacbaaaacaaaaaadiaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaagiccabaaa
aaaaaaaabkiacaaaaaaaaaaaamaaaaaadoaaaaabejfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahahaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adacaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
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
					Float 2[_multiFactor]
					Float 3[_PlanetOpacity]
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_ShadowMapTexture] 2D 1
					SetTexture 2[unity_Lightmap] 2D 2 "!!ARBfp1.0
PARAM c[5] = { program.local[0..3],
		{ 1, 8, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEX R0, fragment.texcoord[4], texture[2], 2D;
TXP R7.x, fragment.texcoord[5], texture[1], 2D;
MUL R5.xyz, fragment.texcoord[0], c[2].x;
MUL R2.xyz, fragment.texcoord[0], c[0].x;
ADD R1.w, -fragment.texcoord[2].y, c[4].x;
MOV result.color.w, c[3].x;
TEX R3.xyz, R2.zxzw, texture[0], 2D;
TEX R1.xyz, R2, texture[0], 2D;
TEX R2.xyz, R2.zyzw, texture[0], 2D;
TEX R6.xyz, R5.zxzw, texture[0], 2D;
TEX R4.xyz, R5, texture[0], 2D;
TEX R5.xyz, R5.zyzw, texture[0], 2D;
MUL R2.xyz, fragment.texcoord[1].x, R2;
MAD R1.xyz, fragment.texcoord[1].z, R1, R2;
MUL R5.xyz, fragment.texcoord[1].x, R5;
MAD R4.xyz, fragment.texcoord[1].z, R4, R5;
MAD R2.xyz, fragment.texcoord[1].y, R6, R4;
MAD R1.xyz, R3, fragment.texcoord[1].y, R1;
MUL R2.xyz, fragment.texcoord[2].y, R2;
MAD R1.xyz, R1, R1.w, R2;
MUL R2.xyz, R0.w, R0;
MUL R2.xyz, R2, c[4].y;
MAD R1.xyz, fragment.texcoord[3], R1, -fragment.texcoord[3];
MUL R0.xyz, R0, R7.x;
MUL R0.xyz, R0, c[4].z;
MUL R3.xyz, R2, R7.x;
MIN R0.xyz, R2, R0;
MAX R0.xyz, R0, R3;
MAD R1.xyz, R1, c[1].x, fragment.texcoord[3];
MUL result.color.xyz, R1, R0;
END
# 30 instructions, 8 R-regs
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
					Float 2[_multiFactor]
					Float 3[_PlanetOpacity]
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_ShadowMapTexture] 2D 1
					SetTexture 2[unity_Lightmap] 2D 2 "ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c4, 1.00000000, 8.00000000, 2.00000000, 0
dcl t0.xyz
dcl t1.xyz
dcl t2.xy
dcl t3.xyz
dcl t4.xy
dcl t5
texldp r5, t5, s1
mul r6.xyz, t0, c2.x
mul r2.xyz, t0, c0.x
mov r4.xy, r6.zxyw
mov r1.xy, r2.zxyw
mov r0.y, r6
mov r0.x, r6.z
mov r7.xy, r0
mov r0.y, r2
mov r0.x, r2.z
mov r3.xy, r0
texld r0, t4, s2
texld r1, r1, s0
texld r2, r2, s0
texld r4, r4, s0
texld r3, r3, s0
texld r7, r7, s0
texld r6, r6, s0
mul r3.xyz, t1.x, r3
mad r2.xyz, t1.z, r2, r3
mad r1.xyz, r1, t1.y, r2
add r3.x, -t2.y, c4
mul r7.xyz, t1.x, r7
mad r6.xyz, t1.z, r6, r7
mad r4.xyz, t1.y, r4, r6
mul r2.xyz, t2.y, r4
mad r1.xyz, r1, r3.x, r2
mul_pp r3.xyz, r0.w, r0
mul_pp r2.xyz, r0, r5.x
mul_pp r0.xyz, r3, c4.y
mul_pp r3.xyz, r2, c4.z
mul_pp r2.xyz, r0, r5.x
mad r1.xyz, t3, r1, -t3
min_pp r0.xyz, r0, r3
max_pp r0.xyz, r0, r2
mad r1.xyz, r1, c1.x, t3
mul_pp r0.xyz, r1, r0
mov_pp r0.w, c3.x
mov_pp oC0, r0
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
					}
					SetTexture 0[_mainTex] 2D 1
					SetTexture 1[_ShadowMapTexture] 2D 0
					SetTexture 2[unity_Lightmap] 2D 2
					ConstBuffer "$Globals"
					240
					Float 128[_texTiling]
					Float 132[_texPower]
					Float 144[_multiFactor]
					Float 196[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedhhgdkadgajcgomgnapemlpfkejgppkidabaaaaaapaafaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadacaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcliaeaaaaeaaaaaaacoabaaaa
fjaaaaaeegiocaaaaaaaaaaaanaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
ccbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gcbaaaadlcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
diaaaaaihcaabaaaaaaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaajaaaaaa
efaaaaajpcaabaaaabaaaaaaggakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaaacaaaaaa
efaaaaajpcaabaaaacaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaaaaaaaaacgakbaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaakgbkbaaa
acaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
fgbfbaaaacaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaafgbfbaaaadaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaabaaaaaa
agiacaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaacgakbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaadaaaaaakgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaa
abaaaaaaegacbaaaabaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaai
icaabaaaaaaaaaaabkbabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadpdcaaaaaj
hcaabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaia
ebaaaaaaaeaaaaaadcaaaaakhcaabaaaaaaaaaaafgifcaaaaaaaaaaaaiaaaaaa
egacbaaaaaaaaaaaegbcbaaaaeaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaa
afaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaadaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahocaabaaaabaaaaaapgapbaaa
aaaaaaaaagajbaaaacaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaacaaaaaa
abeaaaaaaaaaaaebdiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaa
aaaaaaaaddaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaaacaaaaaa
diaaaaahhcaabaaaacaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadeaaaaah
hcaabaaaabaaaaaajgahbaaaabaaaaaaegacbaaaacaaaaaadiaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaagiccabaaaaaaaaaaa
bkiacaaaaaaaaaaaamaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"DIRECTIONAL"
						"SHADOWS_SCREEN"
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
					}
					SetTexture 0[_mainTex] 2D 1
					SetTexture 1[_ShadowMapTexture] 2D 0
					SetTexture 2[unity_Lightmap] 2D 2
					ConstBuffer "$Globals"
					240
					Float 128[_texTiling]
					Float 132[_texPower]
					Float 144[_multiFactor]
					Float 196[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0_level_9_1
eefiecedkdioccdngokielkjpoopmccnlnamjijjabaaaaaabiajaaaaaeaaaaaa
daaaaaaafeadaaaabeaiaaaaoeaiaaaaebgpgodjbmadaaaabmadaaaaaaacpppp
neacaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaabaaaaaa
aaababaaacacacaaaaaaaiaaacaaaaaaaaaaaaaaaaaaamaaabaaacaaaaaaaaaa
aaacppppfbaaaaafadaaapkaaaaaaaebaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaahlabpaaaaacaaaaaaiaabaaahlabpaaaaacaaaaaaiaacaaapla
bpaaaaacaaaaaaiaadaaahlabpaaaaacaaaaaaiaaeaaaplabpaaaaacaaaaaaja
aaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaafaaaaad
aaaaahiaaaaaoelaaaaaaakaabaaaaacabaaabiaaaaakkiaabaaaaacabaaacia
aaaaffiaabaaaaacacaaadiaaaaanciaafaaaaadadaaahiaaaaaoelaabaaaaka
abaaaaacaeaaabiaadaakkiaabaaaaacaeaaaciaadaaffiaabaaaaacafaaadia
adaanciaagaaaaacaaaaaeiaaeaapplaafaaaaadagaaadiaaaaakkiaaeaaoela
abaaaaacahaaadiaacaabllaecaaaaadabaaapiaabaaoeiaabaioekaecaaaaad
aaaaapiaaaaaoeiaabaioekaecaaaaadacaaapiaacaaoeiaabaioekaecaaaaad
aeaaapiaaeaaoeiaabaioekaecaaaaadadaaapiaadaaoeiaabaioekaecaaaaad
afaaapiaafaaoeiaabaioekaecaaaaadagaacpiaagaaoeiaaaaioekaecaaaaad
ahaacpiaahaaoeiaacaioekaafaaaaadabaaahiaabaaoeiaabaaaalaaeaaaaae
aaaaahiaaaaaoeiaabaakklaabaaoeiaaeaaaaaeaaaaahiaacaaoeiaabaaffla
aaaaoeiaafaaaaadabaaahiaaeaaoeiaabaaaalaaeaaaaaeabaaahiaadaaoeia
abaakklaabaaoeiaaeaaaaaeabaaahiaafaaoeiaabaafflaabaaoeiabcaaaaae
acaaahiaacaafflaabaaoeiaaaaaoeiaaeaaaaaeaaaaahiaadaaoelaacaaoeia
adaaoelbaeaaaaaeaaaachiaaaaaffkaaaaaoeiaadaaoelaacaaaaadaaaaciia
agaaaaiaagaaaaiaafaaaaadabaachiaahaaoeiaaaaappiaafaaaaadaaaaciia
ahaappiaadaaaakaafaaaaadacaachiaahaaoeiaaaaappiaakaaaaadadaachia
abaaoeiaacaaoeiaafaaaaadabaachiaagaaaaiaacaaoeiaalaaaaadacaachia
adaaoeiaabaaoeiaafaaaaadaaaachiaaaaaoeiaacaaoeiaabaaaaacaaaaciia
acaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcliaeaaaaeaaaaaaa
coabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadccbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagcbaaaadlcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaa
ajaaaaaaefaaaaajpcaabaaaabaaaaaaggakbaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaa
acaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaacgakbaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaa
kgbkbaaaacaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
aaaaaaaafgbfbaaaacaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaafgbfbaaaadaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaa
abaaaaaaagiacaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
cgakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaa
acaaaaaaegacbaaaadaaaaaakgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaaj
hcaabaaaabaaaaaaegacbaaaabaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaa
aaaaaaaiicaabaaaaaaaaaaabkbabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadp
dcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaa
egbcbaiaebaaaaaaaeaaaaaadcaaaaakhcaabaaaaaaaaaaafgifcaaaaaaaaaaa
aiaaaaaaegacbaaaaaaaaaaaegbcbaaaaeaaaaaaaoaaaaahdcaabaaaabaaaaaa
egbabaaaafaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaa
adaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahocaabaaaabaaaaaa
pgapbaaaaaaaaaaaagajbaaaacaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
acaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
pgapbaaaaaaaaaaaddaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaa
acaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaa
deaaaaahhcaabaaaabaaaaaajgahbaaaabaaaaaaegacbaaaacaaaaaadiaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaagiccabaaa
aaaaaaaabkiacaaaaaaaaaaaamaaaaaadoaaaaabejfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahahaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adacaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
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
					Matrix 9[_Object2World]
					Matrix 13[_LightMatrix0]
					Vector 17[_WorldSpaceLightPos0]
					Vector 18[unity_Scale]
					Vector 19[_tintColor]
					Float 20[_groundTexStart]
					Float 21[_groundTexEnd]
					Float 22[_saturation]
					Float 23[_contrast]
					"!!ARBvp1.0
PARAM c[25] = { { 0, 1, 3, 2 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..23],
		{ 0.29899999, 0.58700001, 0.114 } };
TEMP R0;
TEMP R1;
TEMP R2;
DP3 R1.w, vertex.color, c[24];
MOV R1.z, vertex.texcoord[1].x;
MOV R1.xy, vertex.texcoord[0];
DP3 R0.x, R1, R1;
RSQ R0.w, R0.x;
MUL R1.xyz, R0.w, R1;
ADD R0.xyz, vertex.color, -R1.w;
MAD R2.xyz, R0, c[22].x, R1.w;
MUL R0.xyz, c[19], c[19].w;
MAD R2.xyz, -c[19], c[19].w, R2;
MAD result.texcoord[3].xyz, R2, c[23].x, R0;
DP4 R0.w, vertex.position, c[12];
DP4 R0.z, vertex.position, c[11];
DP4 R0.x, vertex.position, c[9];
DP4 R0.y, vertex.position, c[10];
MOV result.texcoord[0].xyz, R1;
ABS result.texcoord[1].xyz, R1;
MOV R1.x, c[20];
ADD R1.y, -R1.x, c[21].x;
DP4 R1.x, vertex.position, c[3];
RCP R1.y, R1.y;
ADD R1.x, -R1, -c[20];
MUL R1.x, R1, R1.y;
MIN R1.x, R1, c[0].y;
DP4 result.texcoord[6].z, R0, c[15];
DP4 result.texcoord[6].y, R0, c[14];
DP4 result.texcoord[6].x, R0, c[13];
MAX R0.w, R1.x, c[0].x;
MUL R1.xyz, vertex.normal, c[18].w;
MAD R1.w, -R0, c[0], c[0].z;
MUL R0.w, R0, R0;
MUL result.texcoord[2].y, R0.w, R1.w;
DP3 result.texcoord[4].z, R1, c[11];
DP3 result.texcoord[4].y, R1, c[10];
DP3 result.texcoord[4].x, R1, c[9];
ADD result.texcoord[5].xyz, -R0, c[17];
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
MOV result.texcoord[2].x, vertex.color.w;
END
# 41 instructions, 3 R-regs
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
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 8[_Object2World]
					Matrix 12[_LightMatrix0]
					Vector 16[_WorldSpaceLightPos0]
					Vector 17[unity_Scale]
					Vector 18[_tintColor]
					Float 19[_groundTexStart]
					Float 20[_groundTexEnd]
					Float 21[_saturation]
					Float 22[_contrast]
					"vs_2_0
def c23, 1.00000000, 0.00000000, 2.00000000, 3.00000000
def c24, 0.29899999, 0.58700001, 0.11400000, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
dcl_color0 v4
dp3 r1.w, v4, c24
mov r1.z, v3.x
mov r1.xy, v2
dp3 r0.x, r1, r1
rsq r0.w, r0.x
mul r1.xyz, r0.w, r1
add r0.xyz, v4, -r1.w
mad r2.xyz, r0, c21.x, r1.w
mul r0.xyz, c18, c18.w
mad r2.xyz, -c18, c18.w, r2
mad oT3.xyz, r2, c22.x, r0
dp4 r0.w, v0, c11
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
mov oT0.xyz, r1
abs oT1.xyz, r1
mov r1.x, c20
add r1.y, -c19.x, r1.x
dp4 r1.x, v0, c2
rcp r1.y, r1.y
add r1.x, -r1, -c19
mul r1.x, r1, r1.y
min r1.x, r1, c23
dp4 oT6.z, r0, c14
dp4 oT6.y, r0, c13
dp4 oT6.x, r0, c12
max r0.w, r1.x, c23.y
mul r1.xyz, v1, c17.w
mad r1.w, -r0, c23.z, c23
mul r0.w, r0, r0
mul oT2.y, r0.w, r1.w
dp3 oT4.z, r1, c10
dp3 oT4.y, r1, c9
dp3 oT4.x, r1, c8
add oT5.xyz, -r0, c16
dp4 oPos.w, v0, c7
dp4 oPos.z, v0, c6
dp4 oPos.y, v0, c5
dp4 oPos.x, v0, c4
mov oT2.x, v4.w
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
					224
					Matrix 48[_LightMatrix0]
					Vector 112[_tintColor]
					Float 136[_groundTexStart]
					Float 140[_groundTexEnd]
					Float 200[_saturation]
					Float 204[_contrast]
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
					BindCB "UnityLighting"
					1
					BindCB "UnityPerDraw"
					2 "vs_4_0
eefiecedgneginjmjklodkdfmaelafahkajeffmgabaaaaaaaeajaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
caahaaaaeaaaabaamiabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaae
egiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaadbcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaa
afaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
dcaabaaaaaaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaa
aaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaakbcaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaaaaaaaaak
ccaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaadkiacaaaaaaaaaaa
aiaaaaaaaoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpbkaabaaaaaaaaaaadicaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahcccabaaaadaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaadgaaaaafbccabaaaadaaaaaadkbabaaaafaaaaaabaaaaaakbcaabaaa
aaaaaaaaegbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaa
aaaaaaaiocaabaaaaaaaaaaaagaabaiaebaaaaaaaaaaaaaaagbjbaaaafaaaaaa
dcaaaaakhcaabaaaaaaaaaaakgikcaaaaaaaaaaaamaaaaaajgahbaaaaaaaaaaa
agaabaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaa
ahaaaaaapgipcaaaaaaaaaaaahaaaaaaegacbaaaaaaaaaaadiaaaaajhcaabaaa
abaaaaaapgipcaaaaaaaaaaaahaaaaaaegiccaaaaaaaaaaaahaaaaaadcaaaaak
hccabaaaaeaaaaaapgipcaaaaaaaaaaaamaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaa
beaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaa
aaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaacaaaaaa
aoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaagaaaaaaegacbaiaebaaaaaa
aaaaaaaaegiccaaaabaaaaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
aaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
aaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaa
ahaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
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
					224
					Matrix 48[_LightMatrix0]
					Vector 112[_tintColor]
					Float 136[_groundTexStart]
					Float 140[_groundTexEnd]
					Float 200[_saturation]
					Float 204[_contrast]
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
					BindCB "UnityLighting"
					1
					BindCB "UnityPerDraw"
					2 "vs_4_0_level_9_1
eefiecedofgmaooghefphmcolpkbebacnffahkljabaaaaaabmanaaaaaeaaaaaa
daaaaaaaeeaeaaaagmalaaaadeamaaaaebgpgodjamaeaaaaamaeaaaaaaacpopp
jmadaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
agaaabaaaaaaaaaaaaaaamaaabaaahaaaaaaaaaaabaaaaaaabaaaiaaaaaaaaaa
acaaaaaaaiaaajaaaaaaaaaaacaaamaaaeaabbaaaaaaaaaaacaabeaaabaabfaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbgaaapkaaaaaaaaaaaaaiadpaaaaaama
aaaaeaeafbaaaaafbhaaapkaihbgjjdokcefbgdpnfhiojdnaaaaaaaabpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapja
bpaaaaacafaaaeiaaeaaapjabpaaaaacafaaafiaafaaapjaabaaaaacaaaaadia
adaaoejaabaaaaacaaaaaeiaaeaaaajaceaaaaacabaaahiaaaaaoeiacdaaaaac
abaaahoaabaaoeiaabaaaaacaaaaahoaabaaoeiaafaaaaadaaaaabiaaaaaffja
aoaakkkaaeaaaaaeaaaaabiaanaakkkaaaaaaajaaaaaaaiaaeaaaaaeaaaaabia
apaakkkaaaaakkjaaaaaaaiaaeaaaaaeaaaaabiabaaakkkaaaaappjaaaaaaaia
acaaaaadaaaaabiaaaaaaaibagaakkkbacaaaaadaaaaaciaagaakkkbagaappka
agaaaaacaaaaaciaaaaaffiaafaaaaadaaaaabiaaaaaffiaaaaaaaiaalaaaaad
aaaaabiaaaaaaaiabgaaaakaakaaaaadaaaaabiaaaaaaaiabgaaffkaaeaaaaae
aaaaaciaaaaaaaiabgaakkkabgaappkaafaaaaadaaaaabiaaaaaaaiaaaaaaaia
afaaaaadacaaacoaaaaaaaiaaaaaffiaaiaaaaadaaaaabiaafaaoejabhaaoeka
bcaaaaaeabaaahiaahaakkkaafaaoejaaaaaaaiaaeaaaaaeaaaaahiaafaaoeka
afaappkbabaaoeiaafaaaaadabaaahiaafaappkaafaaoekaaeaaaaaeadaaahoa
ahaappkaaaaaoeiaabaaoeiaafaaaaadaaaaahiaacaaoejabfaappkaafaaaaad
abaaahiaaaaaffiabcaaoekaaeaaaaaeaaaaaliabbaakekaaaaaaaiaabaakeia
aeaaaaaeaeaaahoabdaaoekaaaaakkiaaaaapeiaafaaaaadaaaaahiaaaaaffja
bcaaoekaaeaaaaaeaaaaahiabbaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahia
bdaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahiabeaaoekaaaaappjaaaaaoeia
acaaaaadafaaahoaaaaaoeibaiaaoekaafaaaaadaaaaapiaaaaaffjabcaaoeka
aeaaaaaeaaaaapiabbaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiabdaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiabeaaoekaaaaappjaaaaaoeiaafaaaaad
abaaahiaaaaaffiaacaaoekaaeaaaaaeabaaahiaabaaoekaaaaaaaiaabaaoeia
aeaaaaaeaaaaahiaadaaoekaaaaakkiaabaaoeiaaeaaaaaeagaaahoaaeaaoeka
aaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffjaakaaoekaaeaaaaaeaaaaapia
ajaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaalaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaamaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacacaaaboaafaappja
ppppaaaafdeieefccaahaaaaeaaaabaamiabaaaafjaaaaaeegiocaaaaaaaaaaa
anaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaadbcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaa
ahaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
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
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaak
bcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaa
aiaaaaaaaaaaaaakccaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaa
dkiacaaaaaaaaaaaaiaaaaaaaoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpbkaabaaaaaaaaaaadicaaaahbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahcccabaaaadaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaadgaaaaafbccabaaaadaaaaaadkbabaaaafaaaaaa
baaaaaakbcaabaaaaaaaaaaaegbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdp
nfhiojdnaaaaaaaaaaaaaaaiocaabaaaaaaaaaaaagaabaiaebaaaaaaaaaaaaaa
agbjbaaaafaaaaaadcaaaaakhcaabaaaaaaaaaaakgikcaaaaaaaaaaaamaaaaaa
jgahbaaaaaaaaaaaagaabaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaaegiccaia
ebaaaaaaaaaaaaaaahaaaaaapgipcaaaaaaaaaaaahaaaaaaegacbaaaaaaaaaaa
diaaaaajhcaabaaaabaaaaaapgipcaaaaaaaaaaaahaaaaaaegiccaaaaaaaaaaa
ahaaaaaadcaaaaakhccabaaaaeaaaaaapgipcaaaaaaaaaaaamaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaa
pgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaa
amaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaafaaaaaa
egiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaagaaaaaa
egacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
aaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhccabaaaahaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
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
					Matrix 9[_Object2World]
					Vector 13[_WorldSpaceLightPos0]
					Vector 14[unity_Scale]
					Vector 15[_tintColor]
					Float 16[_groundTexStart]
					Float 17[_groundTexEnd]
					Float 18[_saturation]
					Float 19[_contrast]
					"!!ARBvp1.0
PARAM c[21] = { { 0, 1, 3, 2 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..19],
		{ 0.29899999, 0.58700001, 0.114 } };
TEMP R0;
TEMP R1;
TEMP R2;
DP3 R0.x, vertex.color, c[20];
ADD R1.xyz, vertex.color, -R0.x;
MAD R0.xyz, R1, c[18].x, R0.x;
MAD R2.xyz, -c[15], c[15].w, R0;
MUL R1.xyz, c[15], c[15].w;
MAD result.texcoord[3].xyz, R2, c[19].x, R1;
MOV R1.x, c[16];
ADD R1.x, -R1, c[17];
MOV R0.z, vertex.texcoord[1].x;
MOV R0.xy, vertex.texcoord[0];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
DP4 R0.w, vertex.position, c[3];
RCP R1.x, R1.x;
ADD R0.w, -R0, -c[16].x;
MUL R0.w, R0, R1.x;
MUL R1.xyz, vertex.normal, c[14].w;
MOV result.texcoord[0].xyz, R0;
ABS result.texcoord[1].xyz, R0;
MIN R0.w, R0, c[0].y;
MAX R0.x, R0.w, c[0];
MAD R0.y, -R0.x, c[0].w, c[0].z;
MUL R0.x, R0, R0;
MUL result.texcoord[2].y, R0.x, R0;
DP3 result.texcoord[4].z, R1, c[11];
DP3 result.texcoord[4].y, R1, c[10];
DP3 result.texcoord[4].x, R1, c[9];
MOV result.texcoord[5].xyz, c[13];
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
MOV result.texcoord[2].x, vertex.color.w;
END
# 34 instructions, 3 R-regs
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
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 8[_Object2World]
					Vector 12[_WorldSpaceLightPos0]
					Vector 13[unity_Scale]
					Vector 14[_tintColor]
					Float 15[_groundTexStart]
					Float 16[_groundTexEnd]
					Float 17[_saturation]
					Float 18[_contrast]
					"vs_2_0
def c19, 1.00000000, 0.00000000, 2.00000000, 3.00000000
def c20, 0.29899999, 0.58700001, 0.11400000, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
dcl_color0 v4
dp3 r0.x, v4, c20
add r1.xyz, v4, -r0.x
mad r0.xyz, r1, c17.x, r0.x
mad r2.xyz, -c14, c14.w, r0
mul r1.xyz, c14, c14.w
mad oT3.xyz, r2, c18.x, r1
mov r1.x, c16
add r1.x, -c15, r1
mov r0.z, v3.x
mov r0.xy, v2
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp4 r0.w, v0, c2
rcp r1.x, r1.x
add r0.w, -r0, -c15.x
mul r0.w, r0, r1.x
mul r1.xyz, v1, c13.w
mov oT0.xyz, r0
abs oT1.xyz, r0
min r0.w, r0, c19.x
max r0.x, r0.w, c19.y
mad r0.y, -r0.x, c19.z, c19.w
mul r0.x, r0, r0
mul oT2.y, r0.x, r0
dp3 oT4.z, r1, c10
dp3 oT4.y, r1, c9
dp3 oT4.x, r1, c8
mov oT5.xyz, c12
dp4 oPos.w, v0, c7
dp4 oPos.z, v0, c6
dp4 oPos.y, v0, c5
dp4 oPos.x, v0, c4
mov oT2.x, v4.w
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
					160
					Vector 48[_tintColor]
					Float 72[_groundTexStart]
					Float 76[_groundTexEnd]
					Float 136[_saturation]
					Float 140[_contrast]
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
					BindCB "UnityLighting"
					1
					BindCB "UnityPerDraw"
					2 "vs_4_0
eefiecedkebgoflcflimedeglbghijpjhnnafpecabaaaaaaamahaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefceaafaaaaeaaaabaafaabaaaafjaaaaaeegiocaaaaaaaaaaa
ajaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaadbcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaa
aaaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaaaaaaaaa
dgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaa
dkbabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaakbcaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaaaaaaaaakccaabaaa
aaaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaadkiacaaaaaaaaaaaaeaaaaaa
aoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
bkaabaaaaaaaaaaadicaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahcccabaaaadaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
dgaaaaafbccabaaaadaaaaaadkbabaaaafaaaaaabaaaaaakbcaabaaaaaaaaaaa
egbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaaaaaaaaai
ocaabaaaaaaaaaaaagaabaiaebaaaaaaaaaaaaaaagbjbaaaafaaaaaadcaaaaak
hcaabaaaaaaaaaaakgikcaaaaaaaaaaaaiaaaaaajgahbaaaaaaaaaaaagaabaaa
aaaaaaaadcaaaaamhcaabaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaadaaaaaa
pgipcaaaaaaaaaaaadaaaaaaegacbaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaa
pgipcaaaaaaaaaaaadaaaaaaegiccaaaaaaaaaaaadaaaaaadcaaaaakhccabaaa
aeaaaaaapgipcaaaaaaaaaaaaiaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaaaaaaaaaa
egaibaaaabaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaghccabaaaagaaaaaaegiccaaa
abaaaaaaaaaaaaaadoaaaaab"
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
					160
					Vector 48[_tintColor]
					Float 72[_groundTexStart]
					Float 76[_groundTexEnd]
					Float 136[_saturation]
					Float 140[_contrast]
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
					BindCB "UnityLighting"
					1
					BindCB "UnityPerDraw"
					2 "vs_4_0_level_9_1
eefiecedhkaidbpgdhpemppjpoppiefckkhkpmihabaaaaaadmakaaaaaeaaaaaa
daaaaaaafmadaaaakeaiaaaagmajaaaaebgpgodjceadaaaaceadaaaaaaacpopp
leacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
acaaabaaaaaaaaaaaaaaaiaaabaaadaaaaaaaaaaabaaaaaaabaaaeaaaaaaaaaa
acaaaaaaaiaaafaaaaaaaaaaacaaamaaadaaanaaaaaaaaaaacaabeaaabaabaaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbbaaapkaaaaaaaaaaaaaiadpaaaaaama
aaaaeaeafbaaaaafbcaaapkaihbgjjdokcefbgdpnfhiojdnaaaaaaaabpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapja
bpaaaaacafaaaeiaaeaaapjabpaaaaacafaaafiaafaaapjaabaaaaacaaaaadia
adaaoejaabaaaaacaaaaaeiaaeaaaajaceaaaaacabaaahiaaaaaoeiacdaaaaac
abaaahoaabaaoeiaabaaaaacaaaaahoaabaaoeiaafaaaaadaaaaabiaaaaaffja
akaakkkaaeaaaaaeaaaaabiaajaakkkaaaaaaajaaaaaaaiaaeaaaaaeaaaaabia
alaakkkaaaaakkjaaaaaaaiaaeaaaaaeaaaaabiaamaakkkaaaaappjaaaaaaaia
acaaaaadaaaaabiaaaaaaaibacaakkkbacaaaaadaaaaaciaacaakkkbacaappka
agaaaaacaaaaaciaaaaaffiaafaaaaadaaaaabiaaaaaffiaaaaaaaiaalaaaaad
aaaaabiaaaaaaaiabbaaaakaakaaaaadaaaaabiaaaaaaaiabbaaffkaaeaaaaae
aaaaaciaaaaaaaiabbaakkkabbaappkaafaaaaadaaaaabiaaaaaaaiaaaaaaaia
afaaaaadacaaacoaaaaaaaiaaaaaffiaaiaaaaadaaaaabiaafaaoejabcaaoeka
bcaaaaaeabaaahiaadaakkkaafaaoejaaaaaaaiaaeaaaaaeaaaaahiaabaaoeka
abaappkbabaaoeiaafaaaaadabaaahiaabaappkaabaaoekaaeaaaaaeadaaahoa
adaappkaaaaaoeiaabaaoeiaafaaaaadaaaaahiaacaaoejabaaappkaafaaaaad
abaaahiaaaaaffiaaoaaoekaaeaaaaaeaaaaaliaanaakekaaaaaaaiaabaakeia
aeaaaaaeaeaaahoaapaaoekaaaaakkiaaaaapeiaafaaaaadaaaaapiaaaaaffja
agaaoekaaeaaaaaeaaaaapiaafaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
ahaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaaiaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacacaaaboaafaappjaabaaaaacafaaahoaaeaaoekappppaaaafdeieefc
eaafaaaaeaaaabaafaabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaae
egiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaadbcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaa
afaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaaaaaaaaaaegbabaaa
adaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaa
acaaaaaaegacbaiaibaaaaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaa
aaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
acaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaa
akaabaaaaaaaaaaaaaaaaaakbcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaa
ckiacaiaebaaaaaaaaaaaaaaaeaaaaaaaaaaaaakccaabaaaaaaaaaaackiacaia
ebaaaaaaaaaaaaaaaeaaaaaadkiacaaaaaaaaaaaaeaaaaaaaoaaaaakccaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaaaaaaaaa
dicaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
ccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaea
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
cccabaaaadaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadgaaaaafbccabaaa
adaaaaaadkbabaaaafaaaaaabaaaaaakbcaabaaaaaaaaaaaegbcbaaaafaaaaaa
aceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaaaaaaaaaiocaabaaaaaaaaaaa
agaabaiaebaaaaaaaaaaaaaaagbjbaaaafaaaaaadcaaaaakhcaabaaaaaaaaaaa
kgikcaaaaaaaaaaaaiaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaadcaaaaam
hcaabaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaadaaaaaapgipcaaaaaaaaaaa
adaaaaaaegacbaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaapgipcaaaaaaaaaaa
adaaaaaaegiccaaaaaaaaaaaadaaaaaadcaaaaakhccabaaaaeaaaaaapgipcaaa
aaaaaaaaaiaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaa
aaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaa
aaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaa
dcaaaaakhccabaaaafaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaa
egadbaaaaaaaaaaadgaaaaaghccabaaaagaaaaaaegiccaaaabaaaaaaaaaaaaaa
doaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaiaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
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
					Matrix 9[_Object2World]
					Matrix 13[_LightMatrix0]
					Vector 17[_WorldSpaceLightPos0]
					Vector 18[unity_Scale]
					Vector 19[_tintColor]
					Float 20[_groundTexStart]
					Float 21[_groundTexEnd]
					Float 22[_saturation]
					Float 23[_contrast]
					"!!ARBvp1.0
PARAM c[25] = { { 0, 1, 3, 2 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..23],
		{ 0.29899999, 0.58700001, 0.114 } };
TEMP R0;
TEMP R1;
TEMP R2;
DP3 R1.w, vertex.color, c[24];
MOV R1.z, vertex.texcoord[1].x;
MOV R1.xy, vertex.texcoord[0];
DP3 R0.x, R1, R1;
RSQ R0.w, R0.x;
MUL R1.xyz, R0.w, R1;
ADD R0.xyz, vertex.color, -R1.w;
MAD R2.xyz, R0, c[22].x, R1.w;
DP4 R0.w, vertex.position, c[12];
MUL R0.xyz, c[19], c[19].w;
MAD R2.xyz, -c[19], c[19].w, R2;
MAD result.texcoord[3].xyz, R2, c[23].x, R0;
DP4 R0.z, vertex.position, c[11];
DP4 R0.x, vertex.position, c[9];
DP4 R0.y, vertex.position, c[10];
MOV result.texcoord[0].xyz, R1;
ABS result.texcoord[1].xyz, R1;
MOV R1.x, c[20];
ADD R1.y, -R1.x, c[21].x;
DP4 R1.x, vertex.position, c[3];
RCP R1.y, R1.y;
ADD R1.x, -R1, -c[20];
MUL R1.x, R1, R1.y;
MIN R1.x, R1, c[0].y;
DP4 result.texcoord[6].w, R0, c[16];
DP4 result.texcoord[6].z, R0, c[15];
DP4 result.texcoord[6].y, R0, c[14];
DP4 result.texcoord[6].x, R0, c[13];
MAX R0.w, R1.x, c[0].x;
MUL R1.xyz, vertex.normal, c[18].w;
MAD R1.w, -R0, c[0], c[0].z;
MUL R0.w, R0, R0;
MUL result.texcoord[2].y, R0.w, R1.w;
DP3 result.texcoord[4].z, R1, c[11];
DP3 result.texcoord[4].y, R1, c[10];
DP3 result.texcoord[4].x, R1, c[9];
ADD result.texcoord[5].xyz, -R0, c[17];
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
MOV result.texcoord[2].x, vertex.color.w;
END
# 42 instructions, 3 R-regs
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
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 8[_Object2World]
					Matrix 12[_LightMatrix0]
					Vector 16[_WorldSpaceLightPos0]
					Vector 17[unity_Scale]
					Vector 18[_tintColor]
					Float 19[_groundTexStart]
					Float 20[_groundTexEnd]
					Float 21[_saturation]
					Float 22[_contrast]
					"vs_2_0
def c23, 1.00000000, 0.00000000, 2.00000000, 3.00000000
def c24, 0.29899999, 0.58700001, 0.11400000, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
dcl_color0 v4
dp3 r1.w, v4, c24
mov r1.z, v3.x
mov r1.xy, v2
dp3 r0.x, r1, r1
rsq r0.w, r0.x
mul r1.xyz, r0.w, r1
add r0.xyz, v4, -r1.w
mad r2.xyz, r0, c21.x, r1.w
dp4 r0.w, v0, c11
mul r0.xyz, c18, c18.w
mad r2.xyz, -c18, c18.w, r2
mad oT3.xyz, r2, c22.x, r0
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
mov oT0.xyz, r1
abs oT1.xyz, r1
mov r1.x, c20
add r1.y, -c19.x, r1.x
dp4 r1.x, v0, c2
rcp r1.y, r1.y
add r1.x, -r1, -c19
mul r1.x, r1, r1.y
min r1.x, r1, c23
dp4 oT6.w, r0, c15
dp4 oT6.z, r0, c14
dp4 oT6.y, r0, c13
dp4 oT6.x, r0, c12
max r0.w, r1.x, c23.y
mul r1.xyz, v1, c17.w
mad r1.w, -r0, c23.z, c23
mul r0.w, r0, r0
mul oT2.y, r0.w, r1.w
dp3 oT4.z, r1, c10
dp3 oT4.y, r1, c9
dp3 oT4.x, r1, c8
add oT5.xyz, -r0, c16
dp4 oPos.w, v0, c7
dp4 oPos.z, v0, c6
dp4 oPos.y, v0, c5
dp4 oPos.x, v0, c4
mov oT2.x, v4.w
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
					224
					Matrix 48[_LightMatrix0]
					Vector 112[_tintColor]
					Float 136[_groundTexStart]
					Float 140[_groundTexEnd]
					Float 200[_saturation]
					Float 204[_contrast]
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
					BindCB "UnityLighting"
					1
					BindCB "UnityPerDraw"
					2 "vs_4_0
eefiecedeejjkclkjjdjkjfmhjdnfgmhnhiakefdabaaaaaaaeajaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
caahaaaaeaaaabaamiabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaae
egiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaadbcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaa
afaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
dcaabaaaaaaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaa
aaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaakbcaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaaaaaaaaak
ccaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaadkiacaaaaaaaaaaa
aiaaaaaaaoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpbkaabaaaaaaaaaaadicaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahcccabaaaadaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaadgaaaaafbccabaaaadaaaaaadkbabaaaafaaaaaabaaaaaakbcaabaaa
aaaaaaaaegbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaa
aaaaaaaiocaabaaaaaaaaaaaagaabaiaebaaaaaaaaaaaaaaagbjbaaaafaaaaaa
dcaaaaakhcaabaaaaaaaaaaakgikcaaaaaaaaaaaamaaaaaajgahbaaaaaaaaaaa
agaabaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaa
ahaaaaaapgipcaaaaaaaaaaaahaaaaaaegacbaaaaaaaaaaadiaaaaajhcaabaaa
abaaaaaapgipcaaaaaaaaaaaahaaaaaaegiccaaaaaaaaaaaahaaaaaadcaaaaak
hccabaaaaeaaaaaapgipcaaaaaaaaaaaamaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaa
beaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaa
aaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaacaaaaaa
aoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaagaaaaaaegacbaiaebaaaaaa
aaaaaaaaegiccaaaabaaaaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaa
aaaaaaaaaeaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaadaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
aaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaa
ahaaaaaaegiocaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaa
doaaaaab"
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
					224
					Matrix 48[_LightMatrix0]
					Vector 112[_tintColor]
					Float 136[_groundTexStart]
					Float 140[_groundTexEnd]
					Float 200[_saturation]
					Float 204[_contrast]
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
					BindCB "UnityLighting"
					1
					BindCB "UnityPerDraw"
					2 "vs_4_0_level_9_1
eefieceddjjcjmaeceoafhicfifokdjidhocfdcgabaaaaaabmanaaaaaeaaaaaa
daaaaaaaeeaeaaaagmalaaaadeamaaaaebgpgodjamaeaaaaamaeaaaaaaacpopp
jmadaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
agaaabaaaaaaaaaaaaaaamaaabaaahaaaaaaaaaaabaaaaaaabaaaiaaaaaaaaaa
acaaaaaaaiaaajaaaaaaaaaaacaaamaaaeaabbaaaaaaaaaaacaabeaaabaabfaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbgaaapkaaaaaaaaaaaaaiadpaaaaaama
aaaaeaeafbaaaaafbhaaapkaihbgjjdokcefbgdpnfhiojdnaaaaaaaabpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapja
bpaaaaacafaaaeiaaeaaapjabpaaaaacafaaafiaafaaapjaabaaaaacaaaaadia
adaaoejaabaaaaacaaaaaeiaaeaaaajaceaaaaacabaaahiaaaaaoeiacdaaaaac
abaaahoaabaaoeiaabaaaaacaaaaahoaabaaoeiaafaaaaadaaaaabiaaaaaffja
aoaakkkaaeaaaaaeaaaaabiaanaakkkaaaaaaajaaaaaaaiaaeaaaaaeaaaaabia
apaakkkaaaaakkjaaaaaaaiaaeaaaaaeaaaaabiabaaakkkaaaaappjaaaaaaaia
acaaaaadaaaaabiaaaaaaaibagaakkkbacaaaaadaaaaaciaagaakkkbagaappka
agaaaaacaaaaaciaaaaaffiaafaaaaadaaaaabiaaaaaffiaaaaaaaiaalaaaaad
aaaaabiaaaaaaaiabgaaaakaakaaaaadaaaaabiaaaaaaaiabgaaffkaaeaaaaae
aaaaaciaaaaaaaiabgaakkkabgaappkaafaaaaadaaaaabiaaaaaaaiaaaaaaaia
afaaaaadacaaacoaaaaaaaiaaaaaffiaaiaaaaadaaaaabiaafaaoejabhaaoeka
bcaaaaaeabaaahiaahaakkkaafaaoejaaaaaaaiaaeaaaaaeaaaaahiaafaaoeka
afaappkbabaaoeiaafaaaaadabaaahiaafaappkaafaaoekaaeaaaaaeadaaahoa
ahaappkaaaaaoeiaabaaoeiaafaaaaadaaaaahiaacaaoejabfaappkaafaaaaad
abaaahiaaaaaffiabcaaoekaaeaaaaaeaaaaaliabbaakekaaaaaaaiaabaakeia
aeaaaaaeaeaaahoabdaaoekaaaaakkiaaaaapeiaafaaaaadaaaaahiaaaaaffja
bcaaoekaaeaaaaaeaaaaahiabbaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahia
bdaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahiabeaaoekaaaaappjaaaaaoeia
acaaaaadafaaahoaaaaaoeibaiaaoekaafaaaaadaaaaapiaaaaaffjabcaaoeka
aeaaaaaeaaaaapiabbaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiabdaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiabeaaoekaaaaappjaaaaaoeiaafaaaaad
abaaapiaaaaaffiaacaaoekaaeaaaaaeabaaapiaabaaoekaaaaaaaiaabaaoeia
aeaaaaaeabaaapiaadaaoekaaaaakkiaabaaoeiaaeaaaaaeagaaapoaaeaaoeka
aaaappiaabaaoeiaafaaaaadaaaaapiaaaaaffjaakaaoekaaeaaaaaeaaaaapia
ajaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaalaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaamaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacacaaaboaafaappja
ppppaaaafdeieefccaahaaaaeaaaabaamiabaaaafjaaaaaeegiocaaaaaaaaaaa
anaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaadbcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadpccabaaa
ahaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
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
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaak
bcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaa
aiaaaaaaaaaaaaakccaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaa
dkiacaaaaaaaaaaaaiaaaaaaaoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpbkaabaaaaaaaaaaadicaaaahbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahcccabaaaadaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaadgaaaaafbccabaaaadaaaaaadkbabaaaafaaaaaa
baaaaaakbcaabaaaaaaaaaaaegbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdp
nfhiojdnaaaaaaaaaaaaaaaiocaabaaaaaaaaaaaagaabaiaebaaaaaaaaaaaaaa
agbjbaaaafaaaaaadcaaaaakhcaabaaaaaaaaaaakgikcaaaaaaaaaaaamaaaaaa
jgahbaaaaaaaaaaaagaabaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaaegiccaia
ebaaaaaaaaaaaaaaahaaaaaapgipcaaaaaaaaaaaahaaaaaaegacbaaaaaaaaaaa
diaaaaajhcaabaaaabaaaaaapgipcaaaaaaaaaaaahaaaaaaegiccaaaaaaaaaaa
ahaaaaaadcaaaaakhccabaaaaeaaaaaapgipcaaaaaaaaaaaamaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaa
pgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaa
amaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaafaaaaaa
egiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaagaaaaaa
egacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiocaaaaaaaaaaaaeaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
aaaaaaaaadaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpccabaaaahaaaaaaegiocaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaa
egaobaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
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
					Matrix 9[_Object2World]
					Matrix 13[_LightMatrix0]
					Vector 17[_WorldSpaceLightPos0]
					Vector 18[unity_Scale]
					Vector 19[_tintColor]
					Float 20[_groundTexStart]
					Float 21[_groundTexEnd]
					Float 22[_saturation]
					Float 23[_contrast]
					"!!ARBvp1.0
PARAM c[25] = { { 0, 1, 3, 2 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..23],
		{ 0.29899999, 0.58700001, 0.114 } };
TEMP R0;
TEMP R1;
TEMP R2;
DP3 R1.w, vertex.color, c[24];
MOV R1.z, vertex.texcoord[1].x;
MOV R1.xy, vertex.texcoord[0];
DP3 R0.x, R1, R1;
RSQ R0.w, R0.x;
MUL R1.xyz, R0.w, R1;
ADD R0.xyz, vertex.color, -R1.w;
MAD R2.xyz, R0, c[22].x, R1.w;
MUL R0.xyz, c[19], c[19].w;
MAD R2.xyz, -c[19], c[19].w, R2;
MAD result.texcoord[3].xyz, R2, c[23].x, R0;
DP4 R0.w, vertex.position, c[12];
DP4 R0.z, vertex.position, c[11];
DP4 R0.x, vertex.position, c[9];
DP4 R0.y, vertex.position, c[10];
MOV result.texcoord[0].xyz, R1;
ABS result.texcoord[1].xyz, R1;
MOV R1.x, c[20];
ADD R1.y, -R1.x, c[21].x;
DP4 R1.x, vertex.position, c[3];
RCP R1.y, R1.y;
ADD R1.x, -R1, -c[20];
MUL R1.x, R1, R1.y;
MIN R1.x, R1, c[0].y;
DP4 result.texcoord[6].z, R0, c[15];
DP4 result.texcoord[6].y, R0, c[14];
DP4 result.texcoord[6].x, R0, c[13];
MAX R0.w, R1.x, c[0].x;
MUL R1.xyz, vertex.normal, c[18].w;
MAD R1.w, -R0, c[0], c[0].z;
MUL R0.w, R0, R0;
MUL result.texcoord[2].y, R0.w, R1.w;
DP3 result.texcoord[4].z, R1, c[11];
DP3 result.texcoord[4].y, R1, c[10];
DP3 result.texcoord[4].x, R1, c[9];
ADD result.texcoord[5].xyz, -R0, c[17];
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
MOV result.texcoord[2].x, vertex.color.w;
END
# 41 instructions, 3 R-regs
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
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 8[_Object2World]
					Matrix 12[_LightMatrix0]
					Vector 16[_WorldSpaceLightPos0]
					Vector 17[unity_Scale]
					Vector 18[_tintColor]
					Float 19[_groundTexStart]
					Float 20[_groundTexEnd]
					Float 21[_saturation]
					Float 22[_contrast]
					"vs_2_0
def c23, 1.00000000, 0.00000000, 2.00000000, 3.00000000
def c24, 0.29899999, 0.58700001, 0.11400000, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
dcl_color0 v4
dp3 r1.w, v4, c24
mov r1.z, v3.x
mov r1.xy, v2
dp3 r0.x, r1, r1
rsq r0.w, r0.x
mul r1.xyz, r0.w, r1
add r0.xyz, v4, -r1.w
mad r2.xyz, r0, c21.x, r1.w
mul r0.xyz, c18, c18.w
mad r2.xyz, -c18, c18.w, r2
mad oT3.xyz, r2, c22.x, r0
dp4 r0.w, v0, c11
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
mov oT0.xyz, r1
abs oT1.xyz, r1
mov r1.x, c20
add r1.y, -c19.x, r1.x
dp4 r1.x, v0, c2
rcp r1.y, r1.y
add r1.x, -r1, -c19
mul r1.x, r1, r1.y
min r1.x, r1, c23
dp4 oT6.z, r0, c14
dp4 oT6.y, r0, c13
dp4 oT6.x, r0, c12
max r0.w, r1.x, c23.y
mul r1.xyz, v1, c17.w
mad r1.w, -r0, c23.z, c23
mul r0.w, r0, r0
mul oT2.y, r0.w, r1.w
dp3 oT4.z, r1, c10
dp3 oT4.y, r1, c9
dp3 oT4.x, r1, c8
add oT5.xyz, -r0, c16
dp4 oPos.w, v0, c7
dp4 oPos.z, v0, c6
dp4 oPos.y, v0, c5
dp4 oPos.x, v0, c4
mov oT2.x, v4.w
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
					224
					Matrix 48[_LightMatrix0]
					Vector 112[_tintColor]
					Float 136[_groundTexStart]
					Float 140[_groundTexEnd]
					Float 200[_saturation]
					Float 204[_contrast]
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
					BindCB "UnityLighting"
					1
					BindCB "UnityPerDraw"
					2 "vs_4_0
eefiecedgneginjmjklodkdfmaelafahkajeffmgabaaaaaaaeajaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
caahaaaaeaaaabaamiabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaae
egiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaadbcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaa
afaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
dcaabaaaaaaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaa
aaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaakbcaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaaaaaaaaak
ccaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaadkiacaaaaaaaaaaa
aiaaaaaaaoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpbkaabaaaaaaaaaaadicaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahcccabaaaadaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaadgaaaaafbccabaaaadaaaaaadkbabaaaafaaaaaabaaaaaakbcaabaaa
aaaaaaaaegbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaa
aaaaaaaiocaabaaaaaaaaaaaagaabaiaebaaaaaaaaaaaaaaagbjbaaaafaaaaaa
dcaaaaakhcaabaaaaaaaaaaakgikcaaaaaaaaaaaamaaaaaajgahbaaaaaaaaaaa
agaabaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaa
ahaaaaaapgipcaaaaaaaaaaaahaaaaaaegacbaaaaaaaaaaadiaaaaajhcaabaaa
abaaaaaapgipcaaaaaaaaaaaahaaaaaaegiccaaaaaaaaaaaahaaaaaadcaaaaak
hccabaaaaeaaaaaapgipcaaaaaaaaaaaamaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaa
beaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaa
aaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaacaaaaaa
aoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaagaaaaaaegacbaiaebaaaaaa
aaaaaaaaegiccaaaabaaaaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
aaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
aaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaa
ahaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
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
					224
					Matrix 48[_LightMatrix0]
					Vector 112[_tintColor]
					Float 136[_groundTexStart]
					Float 140[_groundTexEnd]
					Float 200[_saturation]
					Float 204[_contrast]
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
					BindCB "UnityLighting"
					1
					BindCB "UnityPerDraw"
					2 "vs_4_0_level_9_1
eefiecedofgmaooghefphmcolpkbebacnffahkljabaaaaaabmanaaaaaeaaaaaa
daaaaaaaeeaeaaaagmalaaaadeamaaaaebgpgodjamaeaaaaamaeaaaaaaacpopp
jmadaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
agaaabaaaaaaaaaaaaaaamaaabaaahaaaaaaaaaaabaaaaaaabaaaiaaaaaaaaaa
acaaaaaaaiaaajaaaaaaaaaaacaaamaaaeaabbaaaaaaaaaaacaabeaaabaabfaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbgaaapkaaaaaaaaaaaaaiadpaaaaaama
aaaaeaeafbaaaaafbhaaapkaihbgjjdokcefbgdpnfhiojdnaaaaaaaabpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapja
bpaaaaacafaaaeiaaeaaapjabpaaaaacafaaafiaafaaapjaabaaaaacaaaaadia
adaaoejaabaaaaacaaaaaeiaaeaaaajaceaaaaacabaaahiaaaaaoeiacdaaaaac
abaaahoaabaaoeiaabaaaaacaaaaahoaabaaoeiaafaaaaadaaaaabiaaaaaffja
aoaakkkaaeaaaaaeaaaaabiaanaakkkaaaaaaajaaaaaaaiaaeaaaaaeaaaaabia
apaakkkaaaaakkjaaaaaaaiaaeaaaaaeaaaaabiabaaakkkaaaaappjaaaaaaaia
acaaaaadaaaaabiaaaaaaaibagaakkkbacaaaaadaaaaaciaagaakkkbagaappka
agaaaaacaaaaaciaaaaaffiaafaaaaadaaaaabiaaaaaffiaaaaaaaiaalaaaaad
aaaaabiaaaaaaaiabgaaaakaakaaaaadaaaaabiaaaaaaaiabgaaffkaaeaaaaae
aaaaaciaaaaaaaiabgaakkkabgaappkaafaaaaadaaaaabiaaaaaaaiaaaaaaaia
afaaaaadacaaacoaaaaaaaiaaaaaffiaaiaaaaadaaaaabiaafaaoejabhaaoeka
bcaaaaaeabaaahiaahaakkkaafaaoejaaaaaaaiaaeaaaaaeaaaaahiaafaaoeka
afaappkbabaaoeiaafaaaaadabaaahiaafaappkaafaaoekaaeaaaaaeadaaahoa
ahaappkaaaaaoeiaabaaoeiaafaaaaadaaaaahiaacaaoejabfaappkaafaaaaad
abaaahiaaaaaffiabcaaoekaaeaaaaaeaaaaaliabbaakekaaaaaaaiaabaakeia
aeaaaaaeaeaaahoabdaaoekaaaaakkiaaaaapeiaafaaaaadaaaaahiaaaaaffja
bcaaoekaaeaaaaaeaaaaahiabbaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahia
bdaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahiabeaaoekaaaaappjaaaaaoeia
acaaaaadafaaahoaaaaaoeibaiaaoekaafaaaaadaaaaapiaaaaaffjabcaaoeka
aeaaaaaeaaaaapiabbaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiabdaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiabeaaoekaaaaappjaaaaaoeiaafaaaaad
abaaahiaaaaaffiaacaaoekaaeaaaaaeabaaahiaabaaoekaaaaaaaiaabaaoeia
aeaaaaaeaaaaahiaadaaoekaaaaakkiaabaaoeiaaeaaaaaeagaaahoaaeaaoeka
aaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffjaakaaoekaaeaaaaaeaaaaapia
ajaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaalaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaamaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacacaaaboaafaappja
ppppaaaafdeieefccaahaaaaeaaaabaamiabaaaafjaaaaaeegiocaaaaaaaaaaa
anaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaadbcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaa
ahaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
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
ckiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaak
bcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaa
aiaaaaaaaaaaaaakccaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaa
dkiacaaaaaaaaaaaaiaaaaaaaoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpbkaabaaaaaaaaaaadicaaaahbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahcccabaaaadaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaadgaaaaafbccabaaaadaaaaaadkbabaaaafaaaaaa
baaaaaakbcaabaaaaaaaaaaaegbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdp
nfhiojdnaaaaaaaaaaaaaaaiocaabaaaaaaaaaaaagaabaiaebaaaaaaaaaaaaaa
agbjbaaaafaaaaaadcaaaaakhcaabaaaaaaaaaaakgikcaaaaaaaaaaaamaaaaaa
jgahbaaaaaaaaaaaagaabaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaaegiccaia
ebaaaaaaaaaaaaaaahaaaaaapgipcaaaaaaaaaaaahaaaaaaegacbaaaaaaaaaaa
diaaaaajhcaabaaaabaaaaaapgipcaaaaaaaaaaaahaaaaaaegiccaaaaaaaaaaa
ahaaaaaadcaaaaakhccabaaaaeaaaaaapgipcaaaaaaaaaaaamaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaa
pgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaa
amaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaafaaaaaa
egiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaagaaaaaa
egacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
aaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhccabaaaahaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
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
					Matrix 9[_Object2World]
					Matrix 13[_LightMatrix0]
					Vector 17[_WorldSpaceLightPos0]
					Vector 18[unity_Scale]
					Vector 19[_tintColor]
					Float 20[_groundTexStart]
					Float 21[_groundTexEnd]
					Float 22[_saturation]
					Float 23[_contrast]
					"!!ARBvp1.0
PARAM c[25] = { { 0, 1, 3, 2 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..23],
		{ 0.29899999, 0.58700001, 0.114 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R1.z, vertex.texcoord[1].x;
MOV R1.xy, vertex.texcoord[0];
DP3 R0.x, R1, R1;
RSQ R0.w, R0.x;
MUL R1.xyz, R0.w, R1;
DP3 R1.w, vertex.color, c[24];
ADD R0.xyz, vertex.color, -R1.w;
MAD R2.xyz, R0, c[22].x, R1.w;
MUL R0.xyz, c[19], c[19].w;
MAD R2.xyz, -c[19], c[19].w, R2;
MAD result.texcoord[3].xyz, R2, c[23].x, R0;
MOV R0.x, c[20];
ADD R0.y, -R0.x, c[21].x;
DP4 R0.x, vertex.position, c[3];
MOV result.texcoord[0].xyz, R1;
ABS result.texcoord[1].xyz, R1;
RCP R0.y, R0.y;
ADD R0.x, -R0, -c[20];
MUL R1.x, R0, R0.y;
DP4 R0.x, vertex.position, c[9];
DP4 R0.y, vertex.position, c[10];
DP4 R0.w, vertex.position, c[12];
DP4 R0.z, vertex.position, c[11];
DP4 result.texcoord[6].y, R0, c[14];
MIN R1.x, R1, c[0].y;
DP4 result.texcoord[6].x, R0, c[13];
MAX R0.x, R1, c[0];
MUL R1.xyz, vertex.normal, c[18].w;
MAD R0.y, -R0.x, c[0].w, c[0].z;
MUL R0.x, R0, R0;
MUL result.texcoord[2].y, R0.x, R0;
DP3 result.texcoord[4].z, R1, c[11];
DP3 result.texcoord[4].y, R1, c[10];
DP3 result.texcoord[4].x, R1, c[9];
MOV result.texcoord[5].xyz, c[17];
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
MOV result.texcoord[2].x, vertex.color.w;
END
# 40 instructions, 3 R-regs
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
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 8[_Object2World]
					Matrix 12[_LightMatrix0]
					Vector 16[_WorldSpaceLightPos0]
					Vector 17[unity_Scale]
					Vector 18[_tintColor]
					Float 19[_groundTexStart]
					Float 20[_groundTexEnd]
					Float 21[_saturation]
					Float 22[_contrast]
					"vs_2_0
def c23, 1.00000000, 0.00000000, 2.00000000, 3.00000000
def c24, 0.29899999, 0.58700001, 0.11400000, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
dcl_color0 v4
mov r1.z, v3.x
mov r1.xy, v2
dp3 r0.x, r1, r1
rsq r0.w, r0.x
mul r1.xyz, r0.w, r1
dp3 r1.w, v4, c24
add r0.xyz, v4, -r1.w
mad r2.xyz, r0, c21.x, r1.w
mul r0.xyz, c18, c18.w
mad r2.xyz, -c18, c18.w, r2
mad oT3.xyz, r2, c22.x, r0
mov r0.x, c20
add r0.y, -c19.x, r0.x
dp4 r0.x, v0, c2
mov oT0.xyz, r1
abs oT1.xyz, r1
rcp r0.y, r0.y
add r0.x, -r0, -c19
mul r1.x, r0, r0.y
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp4 r0.w, v0, c11
dp4 r0.z, v0, c10
dp4 oT6.y, r0, c13
min r1.x, r1, c23
dp4 oT6.x, r0, c12
max r0.x, r1, c23.y
mul r1.xyz, v1, c17.w
mad r0.y, -r0.x, c23.z, c23.w
mul r0.x, r0, r0
mul oT2.y, r0.x, r0
dp3 oT4.z, r1, c10
dp3 oT4.y, r1, c9
dp3 oT4.x, r1, c8
mov oT5.xyz, c16
dp4 oPos.w, v0, c7
dp4 oPos.z, v0, c6
dp4 oPos.y, v0, c5
dp4 oPos.x, v0, c4
mov oT2.x, v4.w
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
					224
					Matrix 48[_LightMatrix0]
					Vector 112[_tintColor]
					Float 136[_groundTexStart]
					Float 140[_groundTexEnd]
					Float 200[_saturation]
					Float 204[_contrast]
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
					BindCB "UnityLighting"
					1
					BindCB "UnityPerDraw"
					2 "vs_4_0
eefiecedkejejpeemghomkenpdbbbbjbihnijcifabaaaaaagaaiaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaadaaaaaaamadaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
hmagaaaaeaaaabaajpabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaae
egiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaadbcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
dcaabaaaaaaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaa
aaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaakbcaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaaaaaaaaak
ccaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaadkiacaaaaaaaaaaa
aiaaaaaaaoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpbkaabaaaaaaaaaaadicaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahcccabaaaadaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
anaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaamaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
dcaabaaaabaaaaaafgafbaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaak
dcaabaaaaaaaaaaaegiacaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegaabaaa
abaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaaafaaaaaakgakbaaa
aaaaaaaaegaabaaaaaaaaaaadcaaaaakmccabaaaadaaaaaaagiecaaaaaaaaaaa
agaaaaaapgapbaaaaaaaaaaaagaebaaaaaaaaaaadgaaaaafbccabaaaadaaaaaa
dkbabaaaafaaaaaabaaaaaakbcaabaaaaaaaaaaaegbcbaaaafaaaaaaaceaaaaa
ihbgjjdokcefbgdpnfhiojdnaaaaaaaaaaaaaaaiocaabaaaaaaaaaaaagaabaia
ebaaaaaaaaaaaaaaagbjbaaaafaaaaaadcaaaaakhcaabaaaaaaaaaaakgikcaaa
aaaaaaaaamaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaadcaaaaamhcaabaaa
aaaaaaaaegiccaiaebaaaaaaaaaaaaaaahaaaaaapgipcaaaaaaaaaaaahaaaaaa
egacbaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaapgipcaaaaaaaaaaaahaaaaaa
egiccaaaaaaaaaaaahaaaaaadcaaaaakhccabaaaaeaaaaaapgipcaaaaaaaaaaa
amaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaa
egbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaa
egiicaaaacaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaak
hccabaaaafaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaa
aaaaaaaadgaaaaaghccabaaaagaaaaaaegiccaaaabaaaaaaaaaaaaaadoaaaaab
"
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
					224
					Matrix 48[_LightMatrix0]
					Vector 112[_tintColor]
					Float 136[_groundTexStart]
					Float 140[_groundTexEnd]
					Float 200[_saturation]
					Float 204[_contrast]
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
					BindCB "UnityLighting"
					1
					BindCB "UnityPerDraw"
					2 "vs_4_0_level_9_1
eefiecedagfndfofkielocjcldkhkimlajkfdebcabaaaaaaciamaaaaaeaaaaaa
daaaaaaapeadaaaahiakaaaaeaalaaaaebgpgodjlmadaaaalmadaaaaaaacpopp
emadaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
agaaabaaaaaaaaaaaaaaamaaabaaahaaaaaaaaaaabaaaaaaabaaaiaaaaaaaaaa
acaaaaaaaiaaajaaaaaaaaaaacaaamaaaeaabbaaaaaaaaaaacaabeaaabaabfaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbgaaapkaaaaaaaaaaaaaiadpaaaaaama
aaaaeaeafbaaaaafbhaaapkaihbgjjdokcefbgdpnfhiojdnaaaaaaaabpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapja
bpaaaaacafaaaeiaaeaaapjabpaaaaacafaaafiaafaaapjaabaaaaacaaaaadia
adaaoejaabaaaaacaaaaaeiaaeaaaajaceaaaaacabaaahiaaaaaoeiacdaaaaac
abaaahoaabaaoeiaabaaaaacaaaaahoaabaaoeiaafaaaaadaaaaabiaaaaaffja
aoaakkkaaeaaaaaeaaaaabiaanaakkkaaaaaaajaaaaaaaiaaeaaaaaeaaaaabia
apaakkkaaaaakkjaaaaaaaiaaeaaaaaeaaaaabiabaaakkkaaaaappjaaaaaaaia
acaaaaadaaaaabiaaaaaaaibagaakkkbacaaaaadaaaaaciaagaakkkbagaappka
agaaaaacaaaaaciaaaaaffiaafaaaaadaaaaabiaaaaaffiaaaaaaaiaalaaaaad
aaaaabiaaaaaaaiabgaaaakaakaaaaadaaaaabiaaaaaaaiabgaaffkaaeaaaaae
aaaaaciaaaaaaaiabgaakkkabgaappkaafaaaaadaaaaabiaaaaaaaiaaaaaaaia
afaaaaadacaaacoaaaaaaaiaaaaaffiaaiaaaaadaaaaabiaafaaoejabhaaoeka
bcaaaaaeabaaahiaahaakkkaafaaoejaaaaaaaiaaeaaaaaeaaaaahiaafaaoeka
afaappkbabaaoeiaafaaaaadabaaahiaafaappkaafaaoekaaeaaaaaeadaaahoa
ahaappkaaaaaoeiaabaaoeiaafaaaaadaaaaahiaacaaoejabfaappkaafaaaaad
abaaahiaaaaaffiabcaaoekaaeaaaaaeaaaaaliabbaakekaaaaaaaiaabaakeia
aeaaaaaeaeaaahoabdaaoekaaaaakkiaaaaapeiaafaaaaadaaaaapiaaaaaffja
bcaaoekaaeaaaaaeaaaaapiabbaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
bdaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiabeaaoekaaaaappjaaaaaoeia
afaaaaadabaaadiaaaaaffiaacaaobkaaeaaaaaeaaaaadiaabaaobkaaaaaaaia
abaaoeiaaeaaaaaeaaaaadiaadaaobkaaaaakkiaaaaaoeiaaeaaaaaeacaaamoa
aeaabekaaaaappiaaaaaeeiaafaaaaadaaaaapiaaaaaffjaakaaoekaaeaaaaae
aaaaapiaajaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaalaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaamaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadma
aaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacacaaaboa
afaappjaabaaaaacafaaahoaaiaaoekappppaaaafdeieefchmagaaaaeaaaabaa
jpabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadbcbabaaa
aeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaa
adaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaaaaaaaaaa
egbabaaaadaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaaaaaaaaadgaaaaag
hccabaaaacaaaaaaegacbaiaibaaaaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaaaaaaaaakbcaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaaaaaaaaakccaabaaaaaaaaaaa
ckiacaiaebaaaaaaaaaaaaaaaiaaaaaadkiacaaaaaaaaaaaaiaaaaaaaoaaaaak
ccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaa
aaaaaaaadicaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaajccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaa
aaaaeaeadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahcccabaaaadaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaidcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaakdcaabaaaaaaaaaaa
egiacaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaak
dcaabaaaaaaaaaaaegiacaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaabaaa
aaaaaaaadcaaaaakmccabaaaadaaaaaaagiecaaaaaaaaaaaagaaaaaapgapbaaa
aaaaaaaaagaebaaaaaaaaaaadgaaaaafbccabaaaadaaaaaadkbabaaaafaaaaaa
baaaaaakbcaabaaaaaaaaaaaegbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdp
nfhiojdnaaaaaaaaaaaaaaaiocaabaaaaaaaaaaaagaabaiaebaaaaaaaaaaaaaa
agbjbaaaafaaaaaadcaaaaakhcaabaaaaaaaaaaakgikcaaaaaaaaaaaamaaaaaa
jgahbaaaaaaaaaaaagaabaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaaegiccaia
ebaaaaaaaaaaaaaaahaaaaaapgipcaaaaaaaaaaaahaaaaaaegacbaaaaaaaaaaa
diaaaaajhcaabaaaabaaaaaapgipcaaaaaaaaaaaahaaaaaaegiccaaaaaaaaaaa
ahaaaaaadcaaaaakhccabaaaaeaaaaaapgipcaaaaaaaaaaaamaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaa
pgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaa
amaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaafaaaaaa
egiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaag
hccabaaaagaaaaaaegiccaaaabaaaaaaaaaaaaaadoaaaaabejfdeheomaaaaaaa
agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
kbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaa
ljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaafaepfdejfeejepeo
aafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaakl
epfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaa
neaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadamaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaa
adaaaaaaamadaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaa
neaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
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
					Float 3[_multiFactor]
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_LightTexture0] 2D 1 "!!ARBfp1.0
PARAM c[6] = { program.local[0..4],
		{ 0, 1, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MUL R4.xyz, fragment.texcoord[0], c[3].x;
MUL R1.xyz, fragment.texcoord[0], c[1].x;
DP3 R0.w, fragment.texcoord[6], fragment.texcoord[6];
MOV result.color.w, c[5].x;
TEX R2.xyz, R1.zxzw, texture[0], 2D;
TEX R0.xyz, R1, texture[0], 2D;
TEX R1.xyz, R1.zyzw, texture[0], 2D;
TEX R5.xyz, R4.zxzw, texture[0], 2D;
TEX R3.xyz, R4, texture[0], 2D;
TEX R4.xyz, R4.zyzw, texture[0], 2D;
TEX R0.w, R0.w, texture[1], 2D;
MUL R1.xyz, fragment.texcoord[1].x, R1;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
MUL R4.xyz, fragment.texcoord[1].x, R4;
MAD R3.xyz, fragment.texcoord[1].z, R3, R4;
MAD R1.xyz, fragment.texcoord[1].y, R5, R3;
MAD R0.xyz, R2, fragment.texcoord[1].y, R0;
MUL R2.xyz, fragment.texcoord[2].y, R1;
DP3 R1.y, fragment.texcoord[5], fragment.texcoord[5];
ADD R1.x, -fragment.texcoord[2].y, c[5].y;
MAD R0.xyz, R0, R1.x, R2;
RSQ R1.w, R1.y;
MAD R1.xyz, fragment.texcoord[3], R0, -fragment.texcoord[3];
MUL R0.xyz, R1.w, fragment.texcoord[5];
MAD R1.xyz, R1, c[2].x, fragment.texcoord[3];
DP3 R1.w, fragment.texcoord[4], R0;
MUL R0.xyz, R1, c[0];
MAX R1.x, R1.w, c[5];
MUL R0.w, R1.x, R0;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[5].z;
END
# 31 instructions, 6 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"POINT"
					}
					Vector 0[_LightColor0]
					Float 1[_texTiling]
					Float 2[_texPower]
					Float 3[_multiFactor]
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_LightTexture0] 2D 1 "ps_2_0
dcl_2d s0
dcl_2d s1
def c4, 1.00000000, 0.00000000, 2.00000000, 0
dcl t0.xyz
dcl t1.xyz
dcl t2.xy
dcl t3.xyz
dcl t4.xyz
dcl t5.xyz
dcl t6.xyz
mul r5.xyz, t0, c3.x
mov r4.xy, r5.zxyw
mul r1.xyz, t0, c1.x
mov r0.y, r5
mov r0.x, r5.z
mov r6.xy, r0
mov r0.y, r1
mov r0.x, r1.z
mov r3.xy, r0
dp3 r0.x, t6, t6
mov r2.xy, r0.x
mov r0.xy, r1.zxyw
texld r0, r0, s0
texld r2, r2, s1
texld r1, r1, s0
texld r4, r4, s0
texld r3, r3, s0
texld r6, r6, s0
texld r5, r5, s0
mul r3.xyz, t1.x, r3
mad r1.xyz, t1.z, r1, r3
mad r1.xyz, r0, t1.y, r1
add r0.x, -t2.y, c4
mul r6.xyz, t1.x, r6
mad r5.xyz, t1.z, r5, r6
mad r4.xyz, t1.y, r4, r5
mul r3.xyz, t2.y, r4
mad r1.xyz, r1, r0.x, r3
mad r1.xyz, t3, r1, -t3
dp3_pp r0.x, t5, t5
rsq_pp r0.x, r0.x
mad r3.xyz, r1, c2.x, t3
mul_pp r1.xyz, r0.x, t5
dp3_pp r1.x, t4, r1
mul_pp r0.xyz, r3, c0
max_pp r1.x, r1, c4.y
mul_pp r1.x, r1, r2
mul_pp r0.xyz, r1.x, r0
mul_pp r0.xyz, r0, c4.z
mov_pp r0.w, c4.y
mov_pp oC0, r0
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"POINT"
					}
					SetTexture 0[_mainTex] 2D 1
					SetTexture 1[_LightTexture0] 2D 0
					ConstBuffer "$Globals"
					224
					Vector 16[_LightColor0]
					Float 128[_texTiling]
					Float 132[_texPower]
					Float 144[_multiFactor]
					BindCB "$Globals"
					0 "ps_4_0
eefieceddeoahjbgbmcndfmdcagfoopfpagidhcgabaaaaaammafaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadacaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefchmaeaaaaeaaaaaaabpabaaaafjaaaaaeegiocaaa
aaaaaaaaakaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadccbabaaa
adaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaad
hcbabaaaagaaaaaagcbaaaadhcbabaaaahaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaabaaaaaaagiacaaa
aaaaaaaaajaaaaaaefaaaaajpcaabaaaabaaaaaaggakbaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
agbabaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaacgakbaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
acaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaafgbfbaaaacaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaafgbfbaaaadaaaaaadiaaaaaihcaabaaaabaaaaaa
egbcbaaaabaaaaaaagiacaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaa
ggakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaa
egaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaacgakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaadaaaaaakgbkbaaaacaaaaaaegacbaaaacaaaaaa
dcaaaaajhcaabaaaabaaaaaaegacbaaaabaaaaaafgbfbaaaacaaaaaaegacbaaa
acaaaaaaaaaaaaaiicaabaaaaaaaaaaabkbabaiaebaaaaaaadaaaaaaabeaaaaa
aaaaiadpdcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaa
aaaaaaaaegbcbaiaebaaaaaaaeaaaaaadcaaaaakhcaabaaaaaaaaaaafgifcaaa
aaaaaaaaaiaaaaaaegacbaaaaaaaaaaaegbcbaaaaeaaaaaadiaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaagaaaaaaegbcbaaaagaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaa
agaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaafaaaaaaegacbaaaabaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaah
bcaabaaaabaaaaaaegbcbaaaahaaaaaaegbcbaaaahaaaaaaefaaaaajpcaabaaa
abaaaaaaagaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaapaaaaah
icaabaaaaaaaaaaapgapbaaaaaaaaaaaagaabaaaabaaaaaadiaaaaahhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"POINT"
					}
					SetTexture 0[_mainTex] 2D 1
					SetTexture 1[_LightTexture0] 2D 0
					ConstBuffer "$Globals"
					224
					Vector 16[_LightColor0]
					Float 128[_texTiling]
					Float 132[_texPower]
					Float 144[_multiFactor]
					BindCB "$Globals"
					0 "ps_4_0_level_9_1
eefiecedpphnaoknbcgkenjpcilinnmghmiiglhjabaaaaaanaaiaaaaaeaaaaaa
daaaaaaadaadaaaaleahaaaajmaiaaaaebgpgodjpiacaaaapiacaaaaaaacpppp
leacaaaaeeaaaaaaacaacmaaaaaaeeaaaaaaeeaaacaaceaaaaaaeeaaabaaaaaa
aaababaaaaaaabaaabaaaaaaaaaaaaaaaaaaaiaaacaaabaaaaaaaaaaaaacpppp
fbaaaaafadaaapkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaaahlabpaaaaacaaaaaaiaabaaahlabpaaaaacaaaaaaiaacaaadlabpaaaaac
aaaaaaiaadaaahlabpaaaaacaaaaaaiaaeaachlabpaaaaacaaaaaaiaafaachla
bpaaaaacaaaaaaiaagaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaaja
abaiapkaafaaaaadaaaaahiaaaaaoelaabaaaakaabaaaaacabaaabiaaaaakkia
abaaaaacabaaaciaaaaaffiaabaaaaacacaaadiaaaaanciaafaaaaadadaaahia
aaaaoelaacaaaakaabaaaaacaeaaabiaadaakkiaabaaaaacaeaaaciaadaaffia
abaaaaacafaaadiaadaanciaaiaaaaadagaaaiiaagaaoelaagaaoelaabaaaaac
agaaadiaagaappiaecaaaaadabaaapiaabaaoeiaabaioekaecaaaaadaaaaapia
aaaaoeiaabaioekaecaaaaadacaaapiaacaaoeiaabaioekaecaaaaadaeaaapia
aeaaoeiaabaioekaecaaaaadadaaapiaadaaoeiaabaioekaecaaaaadafaaapia
afaaoeiaabaioekaecaaaaadagaacpiaagaaoeiaaaaioekaafaaaaadabaaahia
abaaoeiaabaaaalaaeaaaaaeaaaaahiaaaaaoeiaabaakklaabaaoeiaaeaaaaae
aaaaahiaacaaoeiaabaafflaaaaaoeiaafaaaaadabaaahiaaeaaoeiaabaaaala
aeaaaaaeabaaahiaadaaoeiaabaakklaabaaoeiaaeaaaaaeabaaahiaafaaoeia
abaafflaabaaoeiabcaaaaaeacaaahiaacaafflaabaaoeiaaaaaoeiaaeaaaaae
aaaaahiaadaaoelaacaaoeiaadaaoelbaeaaaaaeaaaachiaabaaffkaaaaaoeia
adaaoelaafaaaaadaaaachiaaaaaoeiaaaaaoekaceaaaaacabaachiaafaaoela
aiaaaaadaaaaciiaaeaaoelaabaaoeiaafaaaaadabaacbiaagaaaaiaaaaappia
fiaaaaaeaaaaciiaaaaappiaabaaaaiaadaaaakaacaaaaadaaaaciiaaaaappia
aaaappiaafaaaaadaaaachiaaaaappiaaaaaoeiaabaaaaacaaaaciiaadaaaaka
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefchmaeaaaaeaaaaaaabpabaaaa
fjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadccbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagcbaaaadhcbabaaaagaaaaaagcbaaaadhcbabaaaahaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaa
abaaaaaaagiacaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaaabaaaaaaggakbaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaa
cgakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaa
abaaaaaaegacbaaaacaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaafgbfbaaaacaaaaaaegacbaaaabaaaaaa
diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaafgbfbaaaadaaaaaadiaaaaai
hcaabaaaabaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaaiaaaaaaefaaaaaj
pcaabaaaacaaaaaaggakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
diaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaagbabaaaacaaaaaaefaaaaaj
pcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaacgakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaadaaaaaakgbkbaaaacaaaaaa
egacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaabaaaaaafgbfbaaa
acaaaaaaegacbaaaacaaaaaaaaaaaaaiicaabaaaaaaaaaaabkbabaiaebaaaaaa
adaaaaaaabeaaaaaaaaaiadpdcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegbcbaaa
aeaaaaaaegacbaaaaaaaaaaaegbcbaiaebaaaaaaaeaaaaaadcaaaaakhcaabaaa
aaaaaaaafgifcaaaaaaaaaaaaiaaaaaaegacbaaaaaaaaaaaegbcbaaaaeaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegbcbaaaagaaaaaaegbcbaaaagaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegbcbaaaagaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaafaaaaaa
egacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaahaaaaaaegbcbaaaahaaaaaa
efaaaaajpcaabaaaabaaaaaaagaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaaapaaaaahicaabaaaaaaaaaaapgapbaaaaaaaaaaaagaabaaaabaaaaaa
diaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaabejfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahahaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adacaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
				}
				SubProgram "opengl " {
					Keywords {
						"DIRECTIONAL"
					}
					Vector 0[_LightColor0]
					Float 1[_texTiling]
					Float 2[_texPower]
					Float 3[_multiFactor]
					SetTexture 0[_mainTex] 2D 0 "!!ARBfp1.0
PARAM c[6] = { program.local[0..4],
		{ 0, 1, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MUL R1.xyz, fragment.texcoord[0], c[1].x;
MUL R4.xyz, fragment.texcoord[0], c[3].x;
ADD R0.w, -fragment.texcoord[2].y, c[5].y;
MOV result.color.w, c[5].x;
TEX R2.xyz, R1.zxzw, texture[0], 2D;
TEX R0.xyz, R1, texture[0], 2D;
TEX R1.xyz, R1.zyzw, texture[0], 2D;
TEX R5.xyz, R4.zxzw, texture[0], 2D;
TEX R3.xyz, R4, texture[0], 2D;
TEX R4.xyz, R4.zyzw, texture[0], 2D;
MUL R1.xyz, fragment.texcoord[1].x, R1;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
MUL R4.xyz, fragment.texcoord[1].x, R4;
MAD R3.xyz, fragment.texcoord[1].z, R3, R4;
MAD R1.xyz, fragment.texcoord[1].y, R5, R3;
MUL R1.xyz, fragment.texcoord[2].y, R1;
MAD R0.xyz, R2, fragment.texcoord[1].y, R0;
MAD R0.xyz, R0, R0.w, R1;
MAD R0.xyz, fragment.texcoord[3], R0, -fragment.texcoord[3];
MOV R1.xyz, fragment.texcoord[5];
MAD R0.xyz, R0, c[2].x, fragment.texcoord[3];
DP3 R0.w, fragment.texcoord[4], R1;
MUL R0.xyz, R0, c[0];
MAX R0.w, R0, c[5].x;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[5].z;
END
# 26 instructions, 6 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"DIRECTIONAL"
					}
					Vector 0[_LightColor0]
					Float 1[_texTiling]
					Float 2[_texPower]
					Float 3[_multiFactor]
					SetTexture 0[_mainTex] 2D 0 "ps_2_0
dcl_2d s0
def c4, 1.00000000, 0.00000000, 2.00000000, 0
dcl t0.xyz
dcl t1.xyz
dcl t2.xy
dcl t3.xyz
dcl t4.xyz
dcl t5.xyz
mul r4.xyz, t0, c3.x
mov r3.xy, r4.zxyw
mul r1.xyz, t0, c1.x
mov r0.y, r4
mov r0.x, r4.z
mov r5.xy, r0
mov r0.y, r1
mov r0.x, r1.z
mov r2.xy, r0
mov r0.xy, r1.zxyw
texld r0, r0, s0
texld r1, r1, s0
texld r3, r3, s0
texld r2, r2, s0
texld r5, r5, s0
texld r4, r4, s0
mul r2.xyz, t1.x, r2
mad r1.xyz, t1.z, r1, r2
mad r0.xyz, r0, t1.y, r1
add r1.x, -t2.y, c4
mul r5.xyz, t1.x, r5
mad r4.xyz, t1.z, r4, r5
mad r3.xyz, t1.y, r3, r4
mul r2.xyz, t2.y, r3
mad r0.xyz, r0, r1.x, r2
mad r1.xyz, t3, r0, -t3
mov_pp r0.xyz, t5
dp3_pp r0.x, t4, r0
mad r1.xyz, r1, c2.x, t3
mul_pp r1.xyz, r1, c0
max_pp r0.x, r0, c4.y
mul_pp r0.xyz, r0.x, r1
mul_pp r0.xyz, r0, c4.z
mov_pp r0.w, c4.y
mov_pp oC0, r0
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"DIRECTIONAL"
					}
					SetTexture 0[_mainTex] 2D 0
					ConstBuffer "$Globals"
					160
					Vector 16[_LightColor0]
					Float 64[_texTiling]
					Float 68[_texPower]
					Float 80[_multiFactor]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedbkpcbaocefibbjghoblhfkplgkcgpcolabaaaaaaaaafaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadacaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmiadaaaaeaaaaaaapcaaaaaa
fjaaaaaeegiocaaaaaaaaaaaagaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadccbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaad
hcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaabaaaaaaagiacaaa
aaaaaaaaafaaaaaaefaaaaajpcaabaaaabaaaaaaggakbaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
agbabaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaacgakbaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
acaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaafgbfbaaaacaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaafgbfbaaaadaaaaaadiaaaaaihcaabaaaabaaaaaa
egbcbaaaabaaaaaaagiacaaaaaaaaaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaa
ggakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaa
egaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaacgakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaadaaaaaakgbkbaaaacaaaaaaegacbaaaacaaaaaa
dcaaaaajhcaabaaaabaaaaaaegacbaaaabaaaaaafgbfbaaaacaaaaaaegacbaaa
acaaaaaaaaaaaaaiicaabaaaaaaaaaaabkbabaiaebaaaaaaadaaaaaaabeaaaaa
aaaaiadpdcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaa
aaaaaaaaegbcbaiaebaaaaaaaeaaaaaadcaaaaakhcaabaaaaaaaaaaafgifcaaa
aaaaaaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaaaaeaaaaaadiaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaafaaaaaaegbcbaaaagaaaaaadeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab
"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"DIRECTIONAL"
					}
					SetTexture 0[_mainTex] 2D 0
					ConstBuffer "$Globals"
					160
					Vector 16[_LightColor0]
					Float 64[_texTiling]
					Float 68[_texPower]
					Float 80[_multiFactor]
					BindCB "$Globals"
					0 "ps_4_0_level_9_1
eefiecedndjahflkpgjlgkfbedhhijghmkgdecmhabaaaaaakiahaaaaaeaaaaaa
daaaaaaaneacaaaakeagaaaaheahaaaaebgpgodjjmacaaaajmacaaaaaaacpppp
fmacaaaaeaaaaaaaacaaciaaaaaaeaaaaaaaeaaaabaaceaaaaaaeaaaaaaaaaaa
aaaaabaaabaaaaaaaaaaaaaaaaaaaeaaacaaabaaaaaaaaaaaaacppppfbaaaaaf
adaaapkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaahla
bpaaaaacaaaaaaiaabaaahlabpaaaaacaaaaaaiaacaaadlabpaaaaacaaaaaaia
adaaahlabpaaaaacaaaaaaiaaeaachlabpaaaaacaaaaaaiaafaachlabpaaaaac
aaaaaajaaaaiapkaafaaaaadaaaaahiaaaaaoelaabaaaakaabaaaaacabaaabia
aaaakkiaabaaaaacabaaaciaaaaaffiaabaaaaacacaaadiaaaaanciaafaaaaad
adaaahiaaaaaoelaacaaaakaabaaaaacaeaaabiaadaakkiaabaaaaacaeaaacia
adaaffiaabaaaaacafaaadiaadaanciaecaaaaadabaaapiaabaaoeiaaaaioeka
ecaaaaadaaaaapiaaaaaoeiaaaaioekaecaaaaadacaaapiaacaaoeiaaaaioeka
ecaaaaadaeaaapiaaeaaoeiaaaaioekaecaaaaadadaaapiaadaaoeiaaaaioeka
ecaaaaadafaaapiaafaaoeiaaaaioekaafaaaaadabaaahiaabaaoeiaabaaaala
aeaaaaaeaaaaahiaaaaaoeiaabaakklaabaaoeiaaeaaaaaeaaaaahiaacaaoeia
abaafflaaaaaoeiaafaaaaadabaaahiaaeaaoeiaabaaaalaaeaaaaaeabaaahia
adaaoeiaabaakklaabaaoeiaaeaaaaaeabaaahiaafaaoeiaabaafflaabaaoeia
bcaaaaaeacaaahiaacaafflaabaaoeiaaaaaoeiaaeaaaaaeaaaaahiaadaaoela
acaaoeiaadaaoelbaeaaaaaeaaaachiaabaaffkaaaaaoeiaadaaoelaafaaaaad
aaaachiaaaaaoeiaaaaaoekaabaaaaacabaaahiaaeaaoelaaiaaaaadaaaaciia
abaaoeiaafaaoelaalaaaaadabaacbiaaaaappiaadaaaakaacaaaaadaaaaciia
abaaaaiaabaaaaiaafaaaaadaaaachiaaaaappiaaaaaoeiaabaaaaacaaaaaiia
adaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcmiadaaaaeaaaaaaa
pcaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadccbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gcbaaaadhcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaabaaaaaa
agiacaaaaaaaaaaaafaaaaaaefaaaaajpcaabaaaabaaaaaaggakbaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaacgakbaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaa
egacbaaaacaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaaaaaaaaafgbfbaaaacaaaaaaegacbaaaabaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaafgbfbaaaadaaaaaadiaaaaaihcaabaaa
abaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaaeaaaaaaefaaaaajpcaabaaa
acaaaaaaggakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaa
adaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaacgakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaajhcaabaaaacaaaaaaegacbaaaadaaaaaakgbkbaaaacaaaaaaegacbaaa
acaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaabaaaaaafgbfbaaaacaaaaaa
egacbaaaacaaaaaaaaaaaaaiicaabaaaaaaaaaaabkbabaiaebaaaaaaadaaaaaa
abeaaaaaaaaaiadpdcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegbcbaaaaeaaaaaa
egacbaaaaaaaaaaaegbcbaiaebaaaaaaaeaaaaaadcaaaaakhcaabaaaaaaaaaaa
fgifcaaaaaaaaaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaaaaeaaaaaadiaaaaai
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaagaaaaaadeaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaa
doaaaaabejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
ahahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaadacaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
				}
				SubProgram "opengl " {
					Keywords {
						"SPOT"
					}
					Vector 0[_LightColor0]
					Float 1[_texTiling]
					Float 2[_texPower]
					Float 3[_multiFactor]
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_LightTexture0] 2D 1
					SetTexture 2[_LightTextureB0] 2D 2 "!!ARBfp1.0
PARAM c[6] = { program.local[0..4],
		{ 0, 1, 0.5, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
MUL R4.xyz, fragment.texcoord[0], c[3].x;
MUL R1.xyz, fragment.texcoord[0], c[1].x;
RCP R0.x, fragment.texcoord[6].w;
MAD R6.xy, fragment.texcoord[6], R0.x, c[5].z;
DP3 R1.w, fragment.texcoord[6], fragment.texcoord[6];
MOV result.color.w, c[5].x;
TEX R2.xyz, R1.zxzw, texture[0], 2D;
TEX R0.xyz, R1, texture[0], 2D;
TEX R1.xyz, R1.zyzw, texture[0], 2D;
TEX R5.xyz, R4.zxzw, texture[0], 2D;
TEX R3.xyz, R4, texture[0], 2D;
TEX R4.xyz, R4.zyzw, texture[0], 2D;
TEX R0.w, R6, texture[1], 2D;
TEX R1.w, R1.w, texture[2], 2D;
MUL R1.xyz, fragment.texcoord[1].x, R1;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
MUL R4.xyz, fragment.texcoord[1].x, R4;
MAD R3.xyz, fragment.texcoord[1].z, R3, R4;
MAD R1.xyz, fragment.texcoord[1].y, R5, R3;
MAD R0.xyz, R2, fragment.texcoord[1].y, R0;
MUL R2.xyz, fragment.texcoord[2].y, R1;
ADD R1.x, -fragment.texcoord[2].y, c[5].y;
MAD R0.xyz, R0, R1.x, R2;
DP3 R1.x, fragment.texcoord[5], fragment.texcoord[5];
MAD R0.xyz, fragment.texcoord[3], R0, -fragment.texcoord[3];
RSQ R2.x, R1.x;
MAD R1.xyz, R0, c[2].x, fragment.texcoord[3];
MUL R0.xyz, R2.x, fragment.texcoord[5];
DP3 R0.x, fragment.texcoord[4], R0;
SLT R0.y, c[5].x, fragment.texcoord[6].z;
MUL R0.y, R0, R0.w;
MUL R0.y, R0, R1.w;
MAX R0.x, R0, c[5];
MUL R1.xyz, R1, c[0];
MUL R0.x, R0, R0.y;
MUL R0.xyz, R0.x, R1;
MUL result.color.xyz, R0, c[5].w;
END
# 37 instructions, 7 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"SPOT"
					}
					Vector 0[_LightColor0]
					Float 1[_texTiling]
					Float 2[_texPower]
					Float 3[_multiFactor]
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_LightTexture0] 2D 1
					SetTexture 2[_LightTextureB0] 2D 2 "ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c4, 1.00000000, 0.50000000, 0.00000000, 2.00000000
dcl t0.xyz
dcl t1.xyz
dcl t2.xy
dcl t3.xyz
dcl t4.xyz
dcl t5.xyz
dcl t6
mul r0.xyz, t0, c3.x
mul r1.xyz, t0, c1.x
mov r4.xy, r0.zxyw
mov r5.xy, r1.zxyw
dp3 r6.x, t6, t6
rcp r7.x, t6.w
mov r6.xy, r6.x
mad r7.xy, t6, r7.x, c4.y
mov r2.y, r0
mov r2.x, r0.z
mov r3.y, r1
mov r3.x, r1.z
texld r0, r0, s0
texld r6, r6, s2
texld r7, r7, s1
texld r5, r5, s0
texld r1, r1, s0
texld r4, r4, s0
texld r3, r3, s0
texld r2, r2, s0
mul r2.xyz, t1.x, r2
mad r0.xyz, t1.z, r0, r2
mad r0.xyz, t1.y, r4, r0
mul r2.xyz, t1.x, r3
mad r1.xyz, t1.z, r1, r2
mad r1.xyz, r5, t1.y, r1
add r2.x, -t2.y, c4
mul r0.xyz, t2.y, r0
mad r0.xyz, r1, r2.x, r0
mad r0.xyz, t3, r0, -t3
mad r0.xyz, r0, c2.x, t3
dp3_pp r1.x, t5, t5
rsq_pp r1.x, r1.x
mul_pp r1.xyz, r1.x, t5
dp3_pp r1.x, t4, r1
mul_pp r0.xyz, r0, c0
cmp r2.x, -t6.z, c4.z, c4
mul_pp r2.x, r2, r7.w
mul_pp r2.x, r2, r6
max_pp r1.x, r1, c4.z
mul_pp r1.x, r1, r2
mul_pp r0.xyz, r1.x, r0
mul_pp r0.xyz, r0, c4.w
mov_pp r0.w, c4.z
mov_pp oC0, r0
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"SPOT"
					}
					SetTexture 0[_mainTex] 2D 2
					SetTexture 1[_LightTexture0] 2D 0
					SetTexture 2[_LightTextureB0] 2D 1
					ConstBuffer "$Globals"
					224
					Vector 16[_LightColor0]
					Float 128[_texTiling]
					Float 132[_texPower]
					Float 144[_multiFactor]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedibogghcnbahiihgklhpgghkfpmifaohaabaaaaaamaagaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadacaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefchaafaaaaeaaaaaaafmabaaaafjaaaaaeegiocaaa
aaaaaaaaakaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
hcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadccbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadhcbabaaa
agaaaaaagcbaaaadpcbabaaaahaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaa
ajaaaaaaefaaaaajpcaabaaaabaaaaaaggakbaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaacaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaa
acaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaacaaaaaaefaaaaajpcaabaaaaaaaaaaacgakbaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaa
kgbkbaaaacaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
aaaaaaaafgbfbaaaacaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaafgbfbaaaadaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaa
abaaaaaaagiacaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaabaaaaaa
cgakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaa
acaaaaaaegacbaaaadaaaaaakgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaaj
hcaabaaaabaaaaaaegacbaaaabaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaa
aaaaaaaiicaabaaaaaaaaaaabkbabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadp
dcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaa
egbcbaiaebaaaaaaaeaaaaaadcaaaaakhcaabaaaaaaaaaaafgifcaaaaaaaaaaa
aiaaaaaaegacbaaaaaaaaaaaegbcbaaaaeaaaaaadiaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaa
egbabaaaahaaaaaapgbpbaaaahaaaaaaaaaaaaakdcaabaaaabaaaaaaegaabaaa
abaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadbaaaaah
icaabaaaaaaaaaaaabeaaaaaaaaaaaaackbabaaaahaaaaaaabaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaa
dkaabaaaabaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaa
ahaaaaaaegbcbaaaahaaaaaaefaaaaajpcaabaaaabaaaaaaagaabaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaagaaaaaa
egbcbaaaagaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaaagaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaafaaaaaaegacbaaaabaaaaaadeaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaagaabaaa
abaaaaaapgapbaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab
"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"SPOT"
					}
					SetTexture 0[_mainTex] 2D 2
					SetTexture 1[_LightTexture0] 2D 0
					SetTexture 2[_LightTextureB0] 2D 1
					ConstBuffer "$Globals"
					224
					Vector 16[_LightColor0]
					Float 128[_texTiling]
					Float 132[_texPower]
					Float 144[_multiFactor]
					BindCB "$Globals"
					0 "ps_4_0_level_9_1
eefiecedklhibenjhnobnobnfpbcjnhcobpeehejabaaaaaaceakaaaaaeaaaaaa
daaaaaaajaadaaaaaiajaaaapaajaaaaebgpgodjfiadaaaafiadaaaaaaacpppp
baadaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaabaaaaaa
acababaaaaacacaaaaaaabaaabaaaaaaaaaaaaaaaaaaaiaaacaaabaaaaaaaaaa
aaacppppfbaaaaafadaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaahlabpaaaaacaaaaaaiaabaaahlabpaaaaacaaaaaaiaacaaadla
bpaaaaacaaaaaaiaadaaahlabpaaaaacaaaaaaiaaeaachlabpaaaaacaaaaaaia
afaachlabpaaaaacaaaaaaiaagaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaac
aaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaafaaaaadaaaaahiaaaaaoela
abaaaakaabaaaaacabaaabiaaaaakkiaabaaaaacabaaaciaaaaaffiaabaaaaac
acaaadiaaaaanciaafaaaaadadaaahiaaaaaoelaacaaaakaabaaaaacaeaaabia
adaakkiaabaaaaacaeaaaciaadaaffiaabaaaaacafaaadiaadaanciaagaaaaac
aaaaaeiaagaapplaaeaaaaaeagaaadiaagaaoelaaaaakkiaadaaaakaaiaaaaad
ahaaaiiaagaaoelaagaaoelaabaaaaacahaaadiaahaappiaecaaaaadabaaapia
abaaoeiaacaioekaecaaaaadaaaaapiaaaaaoeiaacaioekaecaaaaadacaaapia
acaaoeiaacaioekaecaaaaadaeaaapiaaeaaoeiaacaioekaecaaaaadadaaapia
adaaoeiaacaioekaecaaaaadafaaapiaafaaoeiaacaioekaecaaaaadagaacpia
agaaoeiaaaaioekaecaaaaadahaacpiaahaaoeiaabaioekaafaaaaadabaaahia
abaaoeiaabaaaalaaeaaaaaeaaaaahiaaaaaoeiaabaakklaabaaoeiaaeaaaaae
aaaaahiaacaaoeiaabaafflaaaaaoeiaafaaaaadabaaahiaaeaaoeiaabaaaala
aeaaaaaeabaaahiaadaaoeiaabaakklaabaaoeiaaeaaaaaeabaaahiaafaaoeia
abaafflaabaaoeiabcaaaaaeacaaahiaacaafflaabaaoeiaaaaaoeiaaeaaaaae
aaaaahiaadaaoelaacaaoeiaadaaoelbaeaaaaaeaaaachiaabaaffkaaaaaoeia
adaaoelaafaaaaadaaaachiaaaaaoeiaaaaaoekaafaaaaadaaaaciiaagaappia
ahaaaaiafiaaaaaeaaaaciiaagaakklbadaaffkaaaaappiaceaaaaacabaachia
afaaoelaaiaaaaadabaacbiaaeaaoelaabaaoeiaalaaaaadacaacbiaabaaaaia
adaaffkaafaaaaadaaaaciiaaaaappiaacaaaaiaacaaaaadaaaaciiaaaaappia
aaaappiaafaaaaadaaaachiaaaaappiaaaaaoeiaabaaaaacaaaaaiiaadaaffka
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefchaafaaaaeaaaaaaafmabaaaa
fjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
ccbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaa
gcbaaaadhcbabaaaagaaaaaagcbaaaadpcbabaaaahaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaabaaaaaa
agiacaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaaabaaaaaaggakbaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaaaaaaaaacgakbaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaaabaaaaaa
egacbaaaacaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaaaaaaaaafgbfbaaaacaaaaaaegacbaaaabaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaafgbfbaaaadaaaaaadiaaaaaihcaabaaa
abaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaa
acaaaaaaggakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaa
adaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaaefaaaaaj
pcaabaaaabaaaaaacgakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
dcaaaaajhcaabaaaacaaaaaaegacbaaaadaaaaaakgbkbaaaacaaaaaaegacbaaa
acaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaabaaaaaafgbfbaaaacaaaaaa
egacbaaaacaaaaaaaaaaaaaiicaabaaaaaaaaaaabkbabaiaebaaaaaaadaaaaaa
abeaaaaaaaaaiadpdcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegbcbaaaaeaaaaaa
egacbaaaaaaaaaaaegbcbaiaebaaaaaaaeaaaaaadcaaaaakhcaabaaaaaaaaaaa
fgifcaaaaaaaaaaaaiaaaaaaegacbaaaaaaaaaaaegbcbaaaaeaaaaaadiaaaaai
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaaaoaaaaah
dcaabaaaabaaaaaaegbabaaaahaaaaaapgbpbaaaahaaaaaaaaaaaaakdcaabaaa
abaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadbaaaaahicaabaaaaaaaaaaaabeaaaaaaaaaaaaackbabaaaahaaaaaa
abaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaah
icaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaahaaaaaaegbcbaaaahaaaaaaefaaaaajpcaabaaaabaaaaaa
agaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaagaaaaaaegbcbaaaagaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaaagaaaaaa
baaaaaahbcaabaaaabaaaaaaegbcbaaaafaaaaaaegacbaaaabaaaaaadeaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaapaaaaahicaabaaa
aaaaaaaaagaabaaaabaaaaaapgapbaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaaaaadoaaaaabejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaahahaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
neaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadacaaaaneaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
afaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaa
neaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaapapaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
				}
				SubProgram "opengl " {
					Keywords {
						"POINT_COOKIE"
					}
					Vector 0[_LightColor0]
					Float 1[_texTiling]
					Float 2[_texPower]
					Float 3[_multiFactor]
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_LightTextureB0] 2D 1
					SetTexture 2[_LightTexture0] CUBE 2 "!!ARBfp1.0
PARAM c[6] = { program.local[0..4],
		{ 0, 1, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R1.w, fragment.texcoord[6], texture[2], CUBE;
MUL R4.xyz, fragment.texcoord[0], c[3].x;
MUL R1.xyz, fragment.texcoord[0], c[1].x;
DP3 R0.w, fragment.texcoord[6], fragment.texcoord[6];
MOV result.color.w, c[5].x;
TEX R2.xyz, R1.zxzw, texture[0], 2D;
TEX R0.xyz, R1, texture[0], 2D;
TEX R1.xyz, R1.zyzw, texture[0], 2D;
TEX R5.xyz, R4.zxzw, texture[0], 2D;
TEX R3.xyz, R4, texture[0], 2D;
TEX R4.xyz, R4.zyzw, texture[0], 2D;
TEX R0.w, R0.w, texture[1], 2D;
MUL R1.xyz, fragment.texcoord[1].x, R1;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
MUL R4.xyz, fragment.texcoord[1].x, R4;
MAD R3.xyz, fragment.texcoord[1].z, R3, R4;
MAD R1.xyz, fragment.texcoord[1].y, R5, R3;
MAD R0.xyz, R2, fragment.texcoord[1].y, R0;
MUL R2.xyz, fragment.texcoord[2].y, R1;
ADD R1.x, -fragment.texcoord[2].y, c[5].y;
MAD R0.xyz, R0, R1.x, R2;
DP3 R1.x, fragment.texcoord[5], fragment.texcoord[5];
MAD R0.xyz, fragment.texcoord[3], R0, -fragment.texcoord[3];
RSQ R2.x, R1.x;
MAD R1.xyz, R0, c[2].x, fragment.texcoord[3];
MUL R0.xyz, R2.x, fragment.texcoord[5];
DP3 R0.x, fragment.texcoord[4], R0;
MUL R0.y, R0.w, R1.w;
MAX R0.x, R0, c[5];
MUL R1.xyz, R1, c[0];
MUL R0.x, R0, R0.y;
MUL R0.xyz, R0.x, R1;
MUL result.color.xyz, R0, c[5].z;
END
# 33 instructions, 6 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"POINT_COOKIE"
					}
					Vector 0[_LightColor0]
					Float 1[_texTiling]
					Float 2[_texPower]
					Float 3[_multiFactor]
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_LightTextureB0] 2D 1
					SetTexture 2[_LightTexture0] CUBE 2 "ps_2_0
dcl_2d s0
dcl_2d s1
dcl_cube s2
def c4, 1.00000000, 0.00000000, 2.00000000, 0
dcl t0.xyz
dcl t1.xyz
dcl t2.xy
dcl t3.xyz
dcl t4.xyz
dcl t5.xyz
dcl t6.xyz
texld r7, t6, s2
mul r0.xyz, t0, c3.x
mul r1.xyz, t0, c1.x
mov r4.xy, r0.zxyw
mov r6.xy, r1.zxyw
dp3 r5.x, t6, t6
mov r5.xy, r5.x
mov r2.y, r0
mov r2.x, r0.z
mov r3.y, r1
mov r3.x, r1.z
texld r0, r0, s0
texld r5, r5, s1
texld r6, r6, s0
texld r1, r1, s0
texld r4, r4, s0
texld r3, r3, s0
texld r2, r2, s0
mul r2.xyz, t1.x, r2
mad r0.xyz, t1.z, r0, r2
mad r0.xyz, t1.y, r4, r0
mul r2.xyz, t1.x, r3
mad r1.xyz, t1.z, r1, r2
mad r1.xyz, r6, t1.y, r1
add r2.x, -t2.y, c4
mul r0.xyz, t2.y, r0
mad r0.xyz, r1, r2.x, r0
mad r0.xyz, t3, r0, -t3
mad r0.xyz, r0, c2.x, t3
dp3_pp r1.x, t5, t5
rsq_pp r1.x, r1.x
mul_pp r1.xyz, r1.x, t5
dp3_pp r1.x, t4, r1
mul_pp r0.xyz, r0, c0
mul r2.x, r5, r7.w
max_pp r1.x, r1, c4.y
mul_pp r1.x, r1, r2
mul_pp r0.xyz, r1.x, r0
mul_pp r0.xyz, r0, c4.z
mov_pp r0.w, c4.y
mov_pp oC0, r0
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"POINT_COOKIE"
					}
					SetTexture 0[_mainTex] 2D 2
					SetTexture 1[_LightTextureB0] 2D 1
					SetTexture 2[_LightTexture0] CUBE 0
					ConstBuffer "$Globals"
					224
					Vector 16[_LightColor0]
					Float 128[_texTiling]
					Float 132[_texPower]
					Float 144[_multiFactor]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedjdoefnjfhjnoennpkepijcfnpihhaepgabaaaaaaciagaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadacaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcniaeaaaaeaaaaaaadgabaaaafjaaaaaeegiocaaa
aaaaaaaaakaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafidaaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
hcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadccbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadhcbabaaa
agaaaaaagcbaaaadhcbabaaaahaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaa
ajaaaaaaefaaaaajpcaabaaaabaaaaaaggakbaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaacaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaa
acaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaacaaaaaaefaaaaajpcaabaaaaaaaaaaacgakbaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaa
kgbkbaaaacaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
aaaaaaaafgbfbaaaacaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaafgbfbaaaadaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaa
abaaaaaaagiacaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaabaaaaaa
cgakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaa
acaaaaaaegacbaaaadaaaaaakgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaaj
hcaabaaaabaaaaaaegacbaaaabaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaa
aaaaaaaiicaabaaaaaaaaaaabkbabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadp
dcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaa
egbcbaiaebaaaaaaaeaaaaaadcaaaaakhcaabaaaaaaaaaaafgifcaaaaaaaaaaa
aiaaaaaaegacbaaaaaaaaaaaegbcbaaaaeaaaaaadiaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaagaaaaaaegbcbaaaagaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaaagaaaaaa
baaaaaahicaabaaaaaaaaaaaegbcbaaaafaaaaaaegacbaaaabaaaaaadeaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaahaaaaaaegbcbaaaahaaaaaaefaaaaajpcaabaaaabaaaaaa
agaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaaegbcbaaaahaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaadiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaadkaabaaaacaaaaaaapaaaaahicaabaaa
aaaaaaaapgapbaaaaaaaaaaaagaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"POINT_COOKIE"
					}
					SetTexture 0[_mainTex] 2D 2
					SetTexture 1[_LightTextureB0] 2D 1
					SetTexture 2[_LightTexture0] CUBE 0
					ConstBuffer "$Globals"
					224
					Vector 16[_LightColor0]
					Float 128[_texTiling]
					Float 132[_texPower]
					Float 144[_multiFactor]
					BindCB "$Globals"
					0 "ps_4_0_level_9_1
eefiecedkgnmefknjafajbgjagpalpikbjcabgbaabaaaaaafiajaaaaaeaaaaaa
daaaaaaafmadaaaadmaiaaaaceajaaaaebgpgodjceadaaaaceadaaaaaaacpppp
nmacaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaacaaaaaa
abababaaaaacacaaaaaaabaaabaaaaaaaaaaaaaaaaaaaiaaacaaabaaaaaaaaaa
aaacppppfbaaaaafadaaapkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaahlabpaaaaacaaaaaaiaabaaahlabpaaaaacaaaaaaiaacaaadla
bpaaaaacaaaaaaiaadaaahlabpaaaaacaaaaaaiaaeaachlabpaaaaacaaaaaaia
afaachlabpaaaaacaaaaaaiaagaaahlabpaaaaacaaaaaajiaaaiapkabpaaaaac
aaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaafaaaaadaaaaahiaaaaaoela
abaaaakaabaaaaacabaaabiaaaaakkiaabaaaaacabaaaciaaaaaffiaabaaaaac
acaaadiaaaaanciaafaaaaadadaaahiaaaaaoelaacaaaakaabaaaaacaeaaabia
adaakkiaabaaaaacaeaaaciaadaaffiaabaaaaacafaaadiaadaanciaaiaaaaad
agaaaiiaagaaoelaagaaoelaabaaaaacagaaadiaagaappiaecaaaaadabaaapia
abaaoeiaacaioekaecaaaaadaaaaapiaaaaaoeiaacaioekaecaaaaadacaaapia
acaaoeiaacaioekaecaaaaadaeaaapiaaeaaoeiaacaioekaecaaaaadadaaapia
adaaoeiaacaioekaecaaaaadafaaapiaafaaoeiaacaioekaecaaaaadagaaapia
agaaoeiaabaioekaecaaaaadahaaapiaagaaoelaaaaioekaafaaaaadabaaahia
abaaoeiaabaaaalaaeaaaaaeaaaaahiaaaaaoeiaabaakklaabaaoeiaaeaaaaae
aaaaahiaacaaoeiaabaafflaaaaaoeiaafaaaaadabaaahiaaeaaoeiaabaaaala
aeaaaaaeabaaahiaadaaoeiaabaakklaabaaoeiaaeaaaaaeabaaahiaafaaoeia
abaafflaabaaoeiabcaaaaaeacaaahiaacaafflaabaaoeiaaaaaoeiaaeaaaaae
aaaaahiaadaaoelaacaaoeiaadaaoelbaeaaaaaeaaaachiaabaaffkaaaaaoeia
adaaoelaafaaaaadaaaachiaaaaaoeiaaaaaoekaafaaaaadaaaaciiaagaaaaia
ahaappiaceaaaaacabaachiaafaaoelaaiaaaaadabaacbiaaeaaoelaabaaoeia
alaaaaadacaacbiaabaaaaiaadaaaakaafaaaaadaaaaciiaaaaappiaacaaaaia
acaaaaadaaaaciiaaaaappiaaaaappiaafaaaaadaaaachiaaaaappiaaaaaoeia
abaaaaacaaaaciiaadaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
niaeaaaaeaaaaaaadgabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fidaaaaeaahabaaaacaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadccbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gcbaaaadhcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaagcbaaaadhcbabaaa
ahaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaadiaaaaaihcaabaaa
aaaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaa
abaaaaaaggakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaa
acaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaaefaaaaaj
pcaabaaaaaaaaaaacgakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
dcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaakgbkbaaaacaaaaaaegacbaaa
abaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaafgbfbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaafgbfbaaa
adaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaa
aiaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaagbabaaa
acaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaacaaaaaaefaaaaajpcaabaaaabaaaaaacgakbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaacaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaadaaaaaa
kgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
abaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaaiicaabaaaaaaaaaaa
bkbabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadpdcaaaaajhcaabaaaaaaaaaaa
egacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaiaebaaaaaaaeaaaaaa
dcaaaaakhcaabaaaaaaaaaaafgifcaaaaaaaaaaaaiaaaaaaegacbaaaaaaaaaaa
egbcbaaaaeaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaagaaaaaaegbcbaaa
agaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegbcbaaaagaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaafaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaahaaaaaa
egbcbaaaahaaaaaaefaaaaajpcaabaaaabaaaaaaagaabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbcbaaaahaaaaaa
eghobaaaacaaaaaaaagabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaadkaabaaaacaaaaaaapaaaaahicaabaaaaaaaaaaapgapbaaaaaaaaaaa
agaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaabejfdeheo
oaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahahaaaaneaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaneaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadacaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahahaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahahaaaaneaaaaaa
afaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaaneaaaaaaagaaaaaaaaaaaaaa
adaaaaaaahaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
				}
				SubProgram "opengl " {
					Keywords {
						"DIRECTIONAL_COOKIE"
					}
					Vector 0[_LightColor0]
					Float 1[_texTiling]
					Float 2[_texPower]
					Float 3[_multiFactor]
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_LightTexture0] 2D 1 "!!ARBfp1.0
PARAM c[6] = { program.local[0..4],
		{ 0, 1, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R0.w, fragment.texcoord[6], texture[1], 2D;
MUL R1.xyz, fragment.texcoord[0], c[1].x;
MUL R4.xyz, fragment.texcoord[0], c[3].x;
MOV result.color.w, c[5].x;
TEX R2.xyz, R1.zxzw, texture[0], 2D;
TEX R0.xyz, R1, texture[0], 2D;
TEX R1.xyz, R1.zyzw, texture[0], 2D;
TEX R5.xyz, R4.zxzw, texture[0], 2D;
TEX R3.xyz, R4, texture[0], 2D;
TEX R4.xyz, R4.zyzw, texture[0], 2D;
MUL R1.xyz, fragment.texcoord[1].x, R1;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
MUL R4.xyz, fragment.texcoord[1].x, R4;
MAD R3.xyz, fragment.texcoord[1].z, R3, R4;
MAD R1.xyz, fragment.texcoord[1].y, R5, R3;
MAD R0.xyz, R2, fragment.texcoord[1].y, R0;
MUL R2.xyz, fragment.texcoord[2].y, R1;
ADD R1.x, -fragment.texcoord[2].y, c[5].y;
MAD R0.xyz, R0, R1.x, R2;
MAD R1.xyz, fragment.texcoord[3], R0, -fragment.texcoord[3];
MOV R0.xyz, fragment.texcoord[5];
MAD R1.xyz, R1, c[2].x, fragment.texcoord[3];
DP3 R1.w, fragment.texcoord[4], R0;
MUL R0.xyz, R1, c[0];
MAX R1.x, R1.w, c[5];
MUL R0.w, R1.x, R0;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[5].z;
END
# 28 instructions, 6 R-regs
"
				}
				SubProgram "d3d9 " {
					Keywords {
						"DIRECTIONAL_COOKIE"
					}
					Vector 0[_LightColor0]
					Float 1[_texTiling]
					Float 2[_texPower]
					Float 3[_multiFactor]
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_LightTexture0] 2D 1 "ps_2_0
dcl_2d s0
dcl_2d s1
def c4, 1.00000000, 0.00000000, 2.00000000, 0
dcl t0.xyz
dcl t1.xyz
dcl t2.xy
dcl t3.xyz
dcl t4.xyz
dcl t5.xyz
dcl t6.xy
texld r2, t6, s1
mul r5.xyz, t0, c3.x
mov r4.xy, r5.zxyw
mul r1.xyz, t0, c1.x
mov r0.y, r5
mov r0.x, r5.z
mov r6.xy, r0
mov r0.y, r1
mov r0.x, r1.z
mov r3.xy, r0
mov r0.xy, r1.zxyw
texld r0, r0, s0
texld r1, r1, s0
texld r4, r4, s0
texld r3, r3, s0
texld r6, r6, s0
texld r5, r5, s0
mul r2.xyz, t1.x, r6
mad r2.xyz, t1.z, r5, r2
mad r2.xyz, t1.y, r4, r2
mul r2.xyz, t2.y, r2
mul r3.xyz, t1.x, r3
mad r1.xyz, t1.z, r1, r3
mad r1.xyz, r0, t1.y, r1
add r0.x, -t2.y, c4
mad r0.xyz, r1, r0.x, r2
mad r0.xyz, t3, r0, -t3
mad r1.xyz, r0, c2.x, t3
mov_pp r0.xyz, t5
dp3_pp r0.x, t4, r0
mul_pp r1.xyz, r1, c0
max_pp r0.x, r0, c4.y
mul_pp r0.x, r0, r2.w
mul_pp r0.xyz, r0.x, r1
mul_pp r0.xyz, r0, c4.z
mov_pp r0.w, c4.y
mov_pp oC0, r0
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"DIRECTIONAL_COOKIE"
					}
					SetTexture 0[_mainTex] 2D 1
					SetTexture 1[_LightTexture0] 2D 0
					ConstBuffer "$Globals"
					224
					Vector 16[_LightColor0]
					Float 128[_texTiling]
					Float 132[_texPower]
					Float 144[_multiFactor]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedkbekcifkclogpnbemhjeiifglmpijfnnabaaaaaageafaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadacaaaaneaaaaaa
agaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaaneaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcbeaeaaaaeaaaaaaaafabaaaafjaaaaaeegiocaaa
aaaaaaaaakaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadccbabaaa
adaaaaaagcbaaaadmcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaad
hcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaabaaaaaaagiacaaa
aaaaaaaaajaaaaaaefaaaaajpcaabaaaabaaaaaaggakbaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
agbabaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaacgakbaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
acaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaafgbfbaaaacaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaafgbfbaaaadaaaaaadiaaaaaihcaabaaaabaaaaaa
egbcbaaaabaaaaaaagiacaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaa
ggakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaa
egaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaacgakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaadaaaaaakgbkbaaaacaaaaaaegacbaaaacaaaaaa
dcaaaaajhcaabaaaabaaaaaaegacbaaaabaaaaaafgbfbaaaacaaaaaaegacbaaa
acaaaaaaaaaaaaaiicaabaaaaaaaaaaabkbabaiaebaaaaaaadaaaaaaabeaaaaa
aaaaiadpdcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaa
aaaaaaaaegbcbaiaebaaaaaaaeaaaaaadcaaaaakhcaabaaaaaaaaaaafgifcaaa
aaaaaaaaaiaaaaaaegacbaaaaaaaaaaaegbcbaaaaeaaaaaadiaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaafaaaaaaegbcbaaaagaaaaaadeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaa
pgapbaaaaaaaaaaapgapbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaa
doaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"DIRECTIONAL_COOKIE"
					}
					SetTexture 0[_mainTex] 2D 1
					SetTexture 1[_LightTexture0] 2D 0
					ConstBuffer "$Globals"
					224
					Vector 16[_LightColor0]
					Float 128[_texTiling]
					Float 132[_texPower]
					Float 144[_multiFactor]
					BindCB "$Globals"
					0 "ps_4_0_level_9_1
eefiecedhcghfljfmdahknopfnlndneimdcnbbacabaaaaaaemaiaaaaaeaaaaaa
daaaaaaabeadaaaadaahaaaabiaiaaaaebgpgodjnmacaaaanmacaaaaaaacpppp
jiacaaaaeeaaaaaaacaacmaaaaaaeeaaaaaaeeaaacaaceaaaaaaeeaaabaaaaaa
aaababaaaaaaabaaabaaaaaaaaaaaaaaaaaaaiaaacaaabaaaaaaaaaaaaacpppp
fbaaaaafadaaapkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaaahlabpaaaaacaaaaaaiaabaaahlabpaaaaacaaaaaaiaacaaaplabpaaaaac
aaaaaaiaadaaahlabpaaaaacaaaaaaiaaeaachlabpaaaaacaaaaaaiaafaachla
bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaafaaaaadaaaaahia
aaaaoelaabaaaakaabaaaaacabaaabiaaaaakkiaabaaaaacabaaaciaaaaaffia
abaaaaacacaaadiaaaaanciaafaaaaadadaaahiaaaaaoelaacaaaakaabaaaaac
aeaaabiaadaakkiaabaaaaacaeaaaciaadaaffiaabaaaaacafaaadiaadaancia
abaaaaacagaaadiaacaabllaecaaaaadabaaapiaabaaoeiaabaioekaecaaaaad
aaaaapiaaaaaoeiaabaioekaecaaaaadacaaapiaacaaoeiaabaioekaecaaaaad
aeaaapiaaeaaoeiaabaioekaecaaaaadadaaapiaadaaoeiaabaioekaecaaaaad
afaaapiaafaaoeiaabaioekaecaaaaadagaacpiaagaaoeiaaaaioekaafaaaaad
abaaahiaabaaoeiaabaaaalaaeaaaaaeaaaaahiaaaaaoeiaabaakklaabaaoeia
aeaaaaaeaaaaahiaacaaoeiaabaafflaaaaaoeiaafaaaaadabaaahiaaeaaoeia
abaaaalaaeaaaaaeabaaahiaadaaoeiaabaakklaabaaoeiaaeaaaaaeabaaahia
afaaoeiaabaafflaabaaoeiabcaaaaaeacaaahiaacaafflaabaaoeiaaaaaoeia
aeaaaaaeaaaaahiaadaaoelaacaaoeiaadaaoelbaeaaaaaeaaaachiaabaaffka
aaaaoeiaadaaoelaafaaaaadaaaachiaaaaaoeiaaaaaoekaabaaaaacabaaahia
aeaaoelaaiaaaaadaaaaciiaabaaoeiaafaaoelaafaaaaadabaacbiaagaappia
aaaappiafiaaaaaeaaaaciiaaaaappiaabaaaaiaadaaaakaacaaaaadaaaaciia
aaaappiaaaaappiaafaaaaadaaaachiaaaaappiaaaaaoeiaabaaaaacaaaaciia
adaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcbeaeaaaaeaaaaaaa
afabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadccbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaagcbaaaad
hcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaadiaaaaaihcaabaaaaaaaaaaa
egbcbaaaabaaaaaaagiacaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaaabaaaaaa
ggakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
aaaaaaaacgakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaaj
hcaabaaaabaaaaaaegacbaaaacaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaafgbfbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaafgbfbaaaadaaaaaa
diaaaaaihcaabaaaabaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaaiaaaaaa
efaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaagbabaaaacaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaacgakbaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaadaaaaaakgbkbaaa
acaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaabaaaaaa
fgbfbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaaiicaabaaaaaaaaaaabkbabaia
ebaaaaaaadaaaaaaabeaaaaaaaaaiadpdcaaaaajhcaabaaaaaaaaaaaegacbaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egbcbaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaiaebaaaaaaaeaaaaaadcaaaaak
hcaabaaaaaaaaaaafgifcaaaaaaaaaaaaiaaaaaaegacbaaaaaaaaaaaegbcbaaa
aeaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaagaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaa
apaaaaahicaabaaaaaaaaaaapgapbaaaaaaaaaaapgapbaaaabaaaaaadiaaaaah
hccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaaaaadoaaaaabejfdeheooaaaaaaaaiaaaaaaaiaaaaaa
miaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaahahaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadacaaaa
neaaaaaaagaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaaneaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
afaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
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
					Matrix 9[_Object2World]
					Vector 13[unity_Scale]
					Vector 14[_tintColor]
					Float 15[_groundTexStart]
					Float 16[_groundTexEnd]
					Float 17[_saturation]
					Float 18[_contrast]
					"!!ARBvp1.0
PARAM c[20] = { { 0, 1, 3, 2 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..18],
		{ 0.29899999, 0.58700001, 0.114 } };
TEMP R0;
TEMP R1;
TEMP R2;
DP3 R0.x, vertex.color, c[19];
ADD R1.xyz, vertex.color, -R0.x;
MAD R0.xyz, R1, c[17].x, R0.x;
MAD R2.xyz, -c[14], c[14].w, R0;
MUL R1.xyz, c[14], c[14].w;
MAD result.texcoord[3].xyz, R2, c[18].x, R1;
MOV R1.x, c[15];
ADD R1.x, -R1, c[16];
MOV R0.z, vertex.texcoord[1].x;
MOV R0.xy, vertex.texcoord[0];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
DP4 R0.w, vertex.position, c[3];
RCP R1.x, R1.x;
ADD R0.w, -R0, -c[15].x;
MUL R0.w, R0, R1.x;
MUL R1.xyz, vertex.normal, c[13].w;
MOV result.texcoord[0].xyz, R0;
ABS result.texcoord[1].xyz, R0;
MIN R0.w, R0, c[0].y;
MAX R0.x, R0.w, c[0];
MAD R0.y, -R0.x, c[0].w, c[0].z;
MUL R0.x, R0, R0;
MUL result.texcoord[2].y, R0.x, R0;
DP3 result.texcoord[4].z, R1, c[11];
DP3 result.texcoord[4].y, R1, c[10];
DP3 result.texcoord[4].x, R1, c[9];
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
MOV result.texcoord[2].x, vertex.color.w;
END
# 33 instructions, 3 R-regs
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
					Matrix 0[glstate_matrix_modelview0]
					Matrix 4[glstate_matrix_mvp]
					Matrix 8[_Object2World]
					Vector 12[unity_Scale]
					Vector 13[_tintColor]
					Float 14[_groundTexStart]
					Float 15[_groundTexEnd]
					Float 16[_saturation]
					Float 17[_contrast]
					"vs_2_0
def c18, 1.00000000, 0.00000000, 2.00000000, 3.00000000
def c19, 0.29899999, 0.58700001, 0.11400000, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
dcl_color0 v4
dp3 r0.x, v4, c19
add r1.xyz, v4, -r0.x
mad r0.xyz, r1, c16.x, r0.x
mad r2.xyz, -c13, c13.w, r0
mul r1.xyz, c13, c13.w
mad oT3.xyz, r2, c17.x, r1
mov r1.x, c15
add r1.x, -c14, r1
mov r0.z, v3.x
mov r0.xy, v2
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp4 r0.w, v0, c2
rcp r1.x, r1.x
add r0.w, -r0, -c14.x
mul r0.w, r0, r1.x
mul r1.xyz, v1, c12.w
mov oT0.xyz, r0
abs oT1.xyz, r0
min r0.w, r0, c18.x
max r0.x, r0.w, c18.y
mad r0.y, -r0.x, c18.z, c18.w
mul r0.x, r0, r0
mul oT2.y, r0.x, r0
dp3 oT4.z, r1, c10
dp3 oT4.y, r1, c9
dp3 oT4.x, r1, c8
dp4 oPos.w, v0, c7
dp4 oPos.z, v0, c6
dp4 oPos.y, v0, c5
dp4 oPos.x, v0, c4
mov oT2.x, v4.w
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
					160
					Vector 48[_tintColor]
					Float 72[_groundTexStart]
					Float 76[_groundTexEnd]
					Float 136[_saturation]
					Float 140[_contrast]
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
eefiecedagcllbkbbaoeijncmfelnmfhkopbjinpabaaaaaamaagaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcamafaaaaeaaaabaaedabaaaafjaaaaae
egiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaadbcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaa
afaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafdcaabaaaaaaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaa
aaaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaa
abaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaabaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaabaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaak
bcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaa
aeaaaaaaaaaaaaakccaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaa
dkiacaaaaaaaaaaaaeaaaaaaaoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpbkaabaaaaaaaaaaadicaaaahbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahcccabaaaadaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaadgaaaaafbccabaaaadaaaaaadkbabaaaafaaaaaa
baaaaaakbcaabaaaaaaaaaaaegbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdp
nfhiojdnaaaaaaaaaaaaaaaiocaabaaaaaaaaaaaagaabaiaebaaaaaaaaaaaaaa
agbjbaaaafaaaaaadcaaaaakhcaabaaaaaaaaaaakgikcaaaaaaaaaaaaiaaaaaa
jgahbaaaaaaaaaaaagaabaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaaegiccaia
ebaaaaaaaaaaaaaaadaaaaaapgipcaaaaaaaaaaaadaaaaaaegacbaaaaaaaaaaa
diaaaaajhcaabaaaabaaaaaapgipcaaaaaaaaaaaadaaaaaaegiccaaaaaaaaaaa
adaaaaaadcaaaaakhccabaaaaeaaaaaapgipcaaaaaaaaaaaaiaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaa
pgipcaaaabaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiccaaaabaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaabaaaaaa
amaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaafaaaaaa
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
					160
					Vector 48[_tintColor]
					Float 72[_groundTexStart]
					Float 76[_groundTexEnd]
					Float 136[_saturation]
					Float 140[_contrast]
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
eefiecedfcednbfgipapaiikflidlbpalkchafdeabaaaaaaniajaaaaaeaaaaaa
daaaaaaaeeadaaaafiaiaaaacaajaaaaebgpgodjamadaaaaamadaaaaaaacpopp
kiacaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaadaa
acaaabaaaaaaaaaaaaaaaiaaabaaadaaaaaaaaaaabaaaaaaaiaaaeaaaaaaaaaa
abaaamaaadaaamaaaaaaaaaaabaabeaaabaaapaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafbaaaapkaaaaaaaaaaaaaiadpaaaaaamaaaaaeaeafbaaaaafbbaaapka
ihbgjjdokcefbgdpnfhiojdnaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaaciaacaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeiaaeaaapja
bpaaaaacafaaafiaafaaapjaabaaaaacaaaaadiaadaaoejaabaaaaacaaaaaeia
aeaaaajaceaaaaacabaaahiaaaaaoeiacdaaaaacabaaahoaabaaoeiaabaaaaac
aaaaahoaabaaoeiaafaaaaadaaaaabiaaaaaffjaajaakkkaaeaaaaaeaaaaabia
aiaakkkaaaaaaajaaaaaaaiaaeaaaaaeaaaaabiaakaakkkaaaaakkjaaaaaaaia
aeaaaaaeaaaaabiaalaakkkaaaaappjaaaaaaaiaacaaaaadaaaaabiaaaaaaaib
acaakkkbacaaaaadaaaaaciaacaakkkbacaappkaagaaaaacaaaaaciaaaaaffia
afaaaaadaaaaabiaaaaaffiaaaaaaaiaalaaaaadaaaaabiaaaaaaaiabaaaaaka
akaaaaadaaaaabiaaaaaaaiabaaaffkaaeaaaaaeaaaaaciaaaaaaaiabaaakkka
baaappkaafaaaaadaaaaabiaaaaaaaiaaaaaaaiaafaaaaadacaaacoaaaaaaaia
aaaaffiaaiaaaaadaaaaabiaafaaoejabbaaoekabcaaaaaeabaaahiaadaakkka
afaaoejaaaaaaaiaaeaaaaaeaaaaahiaabaaoekaabaappkbabaaoeiaafaaaaad
abaaahiaabaappkaabaaoekaaeaaaaaeadaaahoaadaappkaaaaaoeiaabaaoeia
afaaaaadaaaaahiaacaaoejaapaappkaafaaaaadabaaahiaaaaaffiaanaaoeka
aeaaaaaeaaaaaliaamaakekaaaaaaaiaabaakeiaaeaaaaaeaeaaahoaaoaaoeka
aaaakkiaaaaapeiaafaaaaadaaaaapiaaaaaffjaafaaoekaaeaaaaaeaaaaapia
aeaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaahaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacacaaaboaafaappja
ppppaaaafdeieefcamafaaaaeaaaabaaedabaaaafjaaaaaeegiocaaaaaaaaaaa
ajaaaaaafjaaaaaeegiocaaaabaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadbcbabaaa
aeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
dcaabaaaaaaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaa
aaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaabaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaabaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaakbcaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaaaaaaaaak
ccaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaadkiacaaaaaaaaaaa
aeaaaaaaaoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpbkaabaaaaaaaaaaadicaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahcccabaaaadaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaadgaaaaafbccabaaaadaaaaaadkbabaaaafaaaaaabaaaaaakbcaabaaa
aaaaaaaaegbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaa
aaaaaaaiocaabaaaaaaaaaaaagaabaiaebaaaaaaaaaaaaaaagbjbaaaafaaaaaa
dcaaaaakhcaabaaaaaaaaaaakgikcaaaaaaaaaaaaiaaaaaajgahbaaaaaaaaaaa
agaabaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaa
adaaaaaapgipcaaaaaaaaaaaadaaaaaaegacbaaaaaaaaaaadiaaaaajhcaabaaa
abaaaaaapgipcaaaaaaaaaaaadaaaaaaegiccaaaaaaaaaaaadaaaaaadcaaaaak
hccabaaaaeaaaaaapgipcaaaaaaaaaaaaiaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaabaaaaaa
beaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaabaaaaaa
anaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaabaaaaaaamaaaaaaagaabaaa
aaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaabaaaaaa
aoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadoaaaaabejfdeheomaaaaaaa
agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
kbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaa
ljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaafaepfdejfeejepeo
aafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaakl
epfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaa
keaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
				}
			}
			Program "fp" {
				SubProgram "opengl " {
					"!!ARBfp1.0
PARAM c[3] = { program.local[0..1],
		{ 0, 0.5 } };
MAD result.color.xyz, fragment.texcoord[4], c[2].y, c[2].y;
MOV result.color.w, c[2].x;
END
# 2 instructions, 0 R-regs
"
				}
				SubProgram "d3d9 " {
					"ps_2_0
def c0, 0.50000000, 0.00000000, 0, 0
dcl t4.xyz
mad_pp r0.xyz, t4, c0.x, c0.x
mov_pp r0.w, c0.y
mov_pp oC0, r0
"
				}
				SubProgram "d3d11 " {
					"ps_4_0
eefiecedkdipfgacojijkpelinlkhodfikffakpiabaaaaaajeabaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadaaaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaaaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcheaaaaaa
eaaaaaaabnaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaa
dcaaaaaphccabaaaaaaaaaaaegbcbaaaafaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					"ps_4_0_level_9_1
eefiecedebbgchjaehhcmpbjkdhaochjndnnpclcabaaaaaabmacaaaaaeaaaaaa
daaaaaaaleaaaaaadaabaaaaoiabaaaaebgpgodjhmaaaaaahmaaaaaaaaacpppp
fiaaaaaaceaaaaaaaaaaceaaaaaaceaaaaaaceaaaaaaceaaaaaaceaaaaacpppp
fbaaaaafaaaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aeaachlaaeaaaaaeaaaachiaaeaaoelaaaaaaakaaaaaaakaabaaaaacaaaaciia
aaaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcheaaaaaaeaaaaaaa
bnaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaadcaaaaap
hccabaaaaaaaaaaaegbcbaaaafaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaaaaadoaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaahaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadaaaaaa
keaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaaaaaakeaaaaaaaeaaaaaa
aaaaaaaaadaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
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
					Float 23[_groundTexStart]
					Float 24[_groundTexEnd]
					Float 25[_saturation]
					Float 26[_contrast]
					"!!ARBvp1.0
PARAM c[28] = { { 0, 1, 3, 2 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..26],
		{ 0.29899999, 0.58700001, 0.114, 0.5 } };
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
DP3 R0.w, vertex.color, c[27];
ADD R0.xyz, vertex.color, -R0.w;
MAD R3.xyz, R0, c[25].x, R0.w;
MUL R0.xyz, c[22], c[22].w;
MAD R3.xyz, -c[22], c[22].w, R3;
MAD result.texcoord[3].xyz, R3, c[26].x, R0;
DP4 R1.w, vertex.position, c[8];
DP4 R1.z, vertex.position, c[7];
DP4 R1.x, vertex.position, c[5];
DP4 R1.y, vertex.position, c[6];
MUL R2.xyz, R1.xyww, c[27].w;
MOV result.position, R1;
MOV R1.x, c[23];
ADD R1.x, -R1, c[24];
MUL R0.y, R2, c[13].x;
MOV R0.x, R2;
ADD result.texcoord[4].xy, R0, R2.z;
MOV R0.xy, vertex.texcoord[0];
MOV R0.z, vertex.texcoord[1].x;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
DP4 R0.w, vertex.position, c[3];
MOV result.texcoord[0].xyz, R0;
ABS result.texcoord[1].xyz, R0;
RCP R1.x, R1.x;
ADD R0.w, -R0, -c[23].x;
MUL R0.w, R0, R1.x;
MIN R0.w, R0, c[0].y;
MAX R0.x, R0.w, c[0];
MAD R0.y, -R0.x, c[0].w, c[0].z;
MUL R0.x, R0, R0;
MOV result.texcoord[4].zw, R1;
MUL result.texcoord[2].y, R0.x, R0;
MOV result.texcoord[2].x, vertex.color.w;
END
# 53 instructions, 4 R-regs
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
					Float 23[_groundTexStart]
					Float 24[_groundTexEnd]
					Float 25[_saturation]
					Float 26[_contrast]
					"vs_2_0
def c27, 1.00000000, 0.00000000, 2.00000000, 3.00000000
def c28, 0.29899999, 0.58700001, 0.11400000, 0.50000000
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
add oT5.xyz, r1, r0
dp3 r0.w, v4, c28
add r0.xyz, v4, -r0.w
mad r3.xyz, r0, c25.x, r0.w
mul r0.xyz, c22, c22.w
mad r3.xyz, -c22, c22.w, r3
mad oT3.xyz, r3, c26.x, r0
dp4 r1.w, v0, c7
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r2.xyz, r1.xyww, c28.w
mov oPos, r1
mov r1.x, c24
add r1.x, -c23, r1
mul r0.y, r2, c12.x
mov r0.x, r2
mad oT4.xy, r2.z, c13.zwzw, r0
mov r0.xy, v2
mov r0.z, v3.x
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp4 r0.w, v0, c2
mov oT0.xyz, r0
abs oT1.xyz, r0
rcp r1.x, r1.x
add r0.w, -r0, -c23.x
mul r0.w, r0, r1.x
min r0.w, r0, c27.x
max r0.x, r0.w, c27.y
mad r0.y, -r0.x, c27.z, c27.w
mul r0.x, r0, r0
mov oT4.zw, r1
mul oT2.y, r0.x, r0
mov oT2.x, v4.w
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
					176
					Vector 48[_tintColor]
					Float 72[_groundTexStart]
					Float 76[_groundTexEnd]
					Float 136[_saturation]
					Float 140[_contrast]
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
eefiecedkecoekodnckfllfmeadpkffeoiaanollabaaaaaaaiajaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcdmahaaaaeaaaabaampabaaaafjaaaaaeegiocaaaaaaaaaaa
ajaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
cnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadbcbabaaa
aeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaa
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
ahaaaaaadkbabaaaaaaaaaaaakaabaaaabaaaaaaaaaaaaakbcaabaaaabaaaaaa
akaabaiaebaaaaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaaaaaaaaak
ccaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaadkiacaaaaaaaaaaa
aeaaaaaaaoaaaaakccaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpbkaabaaaabaaaaaadicaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaa
akaabaaaabaaaaaadcaaaaajccaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahcccabaaaadaaaaaaakaabaaaabaaaaaabkaabaaa
abaaaaaadgaaaaafbccabaaaadaaaaaadkbabaaaafaaaaaabaaaaaakbcaabaaa
abaaaaaaegbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaa
aaaaaaaiocaabaaaabaaaaaaagaabaiaebaaaaaaabaaaaaaagbjbaaaafaaaaaa
dcaaaaakhcaabaaaabaaaaaakgikcaaaaaaaaaaaaiaaaaaajgahbaaaabaaaaaa
agaabaaaabaaaaaadcaaaaamhcaabaaaabaaaaaaegiccaiaebaaaaaaaaaaaaaa
adaaaaaapgipcaaaaaaaaaaaadaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaa
acaaaaaapgipcaaaaaaaaaaaadaaaaaaegiccaaaaaaaaaaaadaaaaaadcaaaaak
hccabaaaaeaaaaaapgipcaaaaaaaaaaaaiaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaafaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaafaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaai
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
hccabaaaagaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaaaaaaaaaegacbaaa
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
					176
					Vector 48[_tintColor]
					Float 72[_groundTexStart]
					Float 76[_groundTexEnd]
					Float 136[_saturation]
					Float 140[_contrast]
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
eefiecedffjnbcimflggcbloighnhncmcgfchglaabaaaaaaeianaaaaaeaaaaaa
daaaaaaagmaeaaaalaalaaaahiamaaaaebgpgodjdeaeaaaadeaeaaaaaaacpopp
liadaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaadaa
acaaabaaaaaaaaaaaaaaaiaaabaaadaaaaaaaaaaabaaafaaabaaaeaaaaaaaaaa
acaacgaaahaaafaaaaaaaaaaadaaaaaaaiaaamaaaaaaaaaaadaaamaaadaabeaa
aaaaaaaaadaabeaaabaabhaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafbiaaapka
aaaaaaaaaaaaiadpaaaaaamaaaaaeaeafbaaaaafbjaaapkaihbgjjdokcefbgdp
nfhiojdnaaaaaadpbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapja
bpaaaaacafaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjabpaaaaacafaaafia
afaaapjaabaaaaacaaaaadiaadaaoejaabaaaaacaaaaaeiaaeaaaajaceaaaaac
abaaahiaaaaaoeiacdaaaaacabaaahoaabaaoeiaabaaaaacaaaaahoaabaaoeia
afaaaaadaaaaabiaaaaaffjabbaakkkaaeaaaaaeaaaaabiabaaakkkaaaaaaaja
aaaaaaiaaeaaaaaeaaaaabiabcaakkkaaaaakkjaaaaaaaiaaeaaaaaeaaaaabia
bdaakkkaaaaappjaaaaaaaiaacaaaaadaaaaabiaaaaaaaibacaakkkbacaaaaad
aaaaaciaacaakkkbacaappkaagaaaaacaaaaaciaaaaaffiaafaaaaadaaaaabia
aaaaffiaaaaaaaiaalaaaaadaaaaabiaaaaaaaiabiaaaakaakaaaaadaaaaabia
aaaaaaiabiaaffkaaeaaaaaeaaaaaciaaaaaaaiabiaakkkabiaappkaafaaaaad
aaaaabiaaaaaaaiaaaaaaaiaafaaaaadacaaacoaaaaaaaiaaaaaffiaaiaaaaad
aaaaabiaafaaoejabjaaoekabcaaaaaeabaaahiaadaakkkaafaaoejaaaaaaaia
aeaaaaaeaaaaahiaabaaoekaabaappkbabaaoeiaafaaaaadabaaahiaabaappka
abaaoekaaeaaaaaeadaaahoaadaappkaaaaaoeiaabaaoeiaafaaaaadaaaaapia
aaaaffjaanaaoekaaeaaaaaeaaaaapiaamaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiaaoaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaapaaoekaaaaappja
aaaaoeiaafaaaaadabaaabiaaaaaffiaaeaaaakaafaaaaadabaaaiiaabaaaaia
bjaappkaafaaaaadabaaafiaaaaapeiabjaappkaacaaaaadaeaaadoaabaakkia
abaaomiaafaaaaadabaaahiaacaaoejabhaappkaafaaaaadacaaahiaabaaffia
bfaaoekaaeaaaaaeabaaaliabeaakekaabaaaaiaacaakeiaaeaaaaaeabaaahia
bgaaoekaabaakkiaabaapeiaabaaaaacabaaaiiabiaaffkaajaaaaadacaaabia
afaaoekaabaaoeiaajaaaaadacaaaciaagaaoekaabaaoeiaajaaaaadacaaaeia
ahaaoekaabaaoeiaafaaaaadadaaapiaabaacjiaabaakeiaajaaaaadaeaaabia
aiaaoekaadaaoeiaajaaaaadaeaaaciaajaaoekaadaaoeiaajaaaaadaeaaaeia
akaaoekaadaaoeiaacaaaaadacaaahiaacaaoeiaaeaaoeiaafaaaaadabaaacia
abaaffiaabaaffiaaeaaaaaeabaaabiaabaaaaiaabaaaaiaabaaffibaeaaaaae
afaaahoaalaaoekaabaaaaiaacaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoeka
aaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaeaaamoaaaaaoeiaabaaaaac
acaaaboaafaappjappppaaaafdeieefcdmahaaaaeaaaabaampabaaaafjaaaaae
egiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaadbcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaa
afaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaa
abaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaa
abaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaa
abaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaa
afaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaadaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaa
ckiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaabaaaaaaaaaaaaak
bcaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaackiacaiaebaaaaaaaaaaaaaa
aeaaaaaaaaaaaaakccaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaa
dkiacaaaaaaaaaaaaeaaaaaaaoaaaaakccaabaaaabaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpbkaabaaaabaaaaaadicaaaahbcaabaaaabaaaaaa
bkaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaajccaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahcccabaaaadaaaaaaakaabaaa
abaaaaaabkaabaaaabaaaaaadgaaaaafbccabaaaadaaaaaadkbabaaaafaaaaaa
baaaaaakbcaabaaaabaaaaaaegbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdp
nfhiojdnaaaaaaaaaaaaaaaiocaabaaaabaaaaaaagaabaiaebaaaaaaabaaaaaa
agbjbaaaafaaaaaadcaaaaakhcaabaaaabaaaaaakgikcaaaaaaaaaaaaiaaaaaa
jgahbaaaabaaaaaaagaabaaaabaaaaaadcaaaaamhcaabaaaabaaaaaaegiccaia
ebaaaaaaaaaaaaaaadaaaaaapgipcaaaaaaaaaaaadaaaaaaegacbaaaabaaaaaa
diaaaaajhcaabaaaacaaaaaapgipcaaaaaaaaaaaadaaaaaaegiccaaaaaaaaaaa
adaaaaaadcaaaaakhccabaaaaeaaaaaapgipcaaaaaaaaaaaaiaaaaaaegacbaaa
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
aaaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaa
ahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
lmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaadamaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaa
lmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaalmaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
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
					Float 16[_groundTexStart]
					Float 17[_groundTexEnd]
					Float 18[_saturation]
					Float 19[_contrast]
					Vector 20[unity_LightmapST]
					"!!ARBvp1.0
PARAM c[22] = { { 0, 1, 3, 2 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..20],
		{ 0.29899999, 0.58700001, 0.114, 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
DP3 R0.w, vertex.color, c[21];
ADD R0.xyz, vertex.color, -R0.w;
MAD R3.xyz, R0, c[18].x, R0.w;
MUL R0.xyz, c[15], c[15].w;
MAD R3.xyz, -c[15], c[15].w, R3;
MAD result.texcoord[3].xyz, R3, c[19].x, R0;
DP4 R1.w, vertex.position, c[8];
DP4 R1.z, vertex.position, c[7];
DP4 R1.x, vertex.position, c[5];
DP4 R1.y, vertex.position, c[6];
MUL R2.xyz, R1.xyww, c[21].w;
MOV result.position, R1;
MOV R1.x, c[16];
ADD R1.x, -R1, c[17];
RCP R1.y, R1.x;
MUL R0.y, R2, c[13].x;
MOV R0.x, R2;
ADD result.texcoord[4].xy, R0, R2.z;
MOV R0.xy, vertex.texcoord[0];
MOV R0.z, vertex.texcoord[1].x;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
DP4 R0.w, vertex.position, c[3];
ADD R1.x, -R0.w, -c[16];
MUL R1.x, R1, R1.y;
MOV result.texcoord[0].xyz, R0;
ABS result.texcoord[1].xyz, R0;
MIN R1.x, R1, c[0].y;
MAX R0.x, R1, c[0];
MAD R0.y, -R0.x, c[0].w, c[0].z;
MUL R0.x, R0, R0;
MUL result.texcoord[2].y, R0.x, R0;
DP4 R0.x, vertex.position, c[9];
MOV result.texcoord[4].zw, R1;
DP4 R0.z, vertex.position, c[11];
DP4 R0.y, vertex.position, c[10];
ADD R1.xyz, R0, -c[14];
MOV R0.x, c[0].y;
ADD R0.x, R0, -c[14].w;
MUL result.texcoord[6].xyz, R1, c[14].w;
MAD result.texcoord[5].xy, vertex.texcoord[1], c[20], c[20].zwzw;
MUL result.texcoord[6].w, -R0, R0.x;
MOV result.texcoord[2].x, vertex.color.w;
END
# 44 instructions, 4 R-regs
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
					Float 16[_groundTexStart]
					Float 17[_groundTexEnd]
					Float 18[_saturation]
					Float 19[_contrast]
					Vector 20[unity_LightmapST]
					"vs_2_0
def c21, 0.00000000, 2.00000000, 3.00000000, 0.50000000
def c22, 0.29899999, 0.58700001, 0.11400000, 1.00000000
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dcl_color0 v3
dp3 r0.w, v3, c22
add r0.xyz, v3, -r0.w
mad r3.xyz, r0, c18.x, r0.w
mul r0.xyz, c15, c15.w
mad r3.xyz, -c15, c15.w, r3
mad oT3.xyz, r3, c19.x, r0
dp4 r1.w, v0, c7
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r2.xyz, r1.xyww, c21.w
mov oPos, r1
mov r1.x, c17
add r1.x, -c16, r1
rcp r1.y, r1.x
mul r0.y, r2, c12.x
mov r0.x, r2
mad oT4.xy, r2.z, c13.zwzw, r0
mov r0.xy, v1
mov r0.z, v2.x
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp4 r0.w, v0, c2
add r1.x, -r0.w, -c16
mul r1.x, r1, r1.y
mov oT0.xyz, r0
abs oT1.xyz, r0
min r1.x, r1, c22.w
max r0.x, r1, c21
mad r0.y, -r0.x, c21, c21.z
mul r0.x, r0, r0
mul oT2.y, r0.x, r0
dp4 r0.x, v0, c8
mov oT4.zw, r1
dp4 r0.z, v0, c10
dp4 r0.y, v0, c9
add r1.xyz, r0, -c14
mov r0.x, c14.w
add r0.x, c22.w, -r0
mul oT6.xyz, r1, c14.w
mad oT5.xy, v2, c20, c20.zwzw
mul oT6.w, -r0, r0.x
mov oT2.x, v3.w
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
					208
					Vector 48[_tintColor]
					Float 72[_groundTexStart]
					Float 76[_groundTexEnd]
					Float 136[_saturation]
					Float 140[_contrast]
					Vector 160[unity_LightmapST]
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
eefiecededcioohcflfjellilegncmcocgbfdmdeabaaaaaageaiaaaaadaaaaaa
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
adamaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaadaaaaaaamadaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
iaagaaaaeaaaabaakaabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabkaaaaaafjaaaaae
egiocaaaadaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaaddcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaa
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
aaaaaaaaakaabaaaabaaaaaaaaaaaaakccaabaaaabaaaaaaakaabaiaebaaaaaa
abaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaaaaaaaaakecaabaaaabaaaaaa
ckiacaiaebaaaaaaaaaaaaaaaeaaaaaadkiacaaaaaaaaaaaaeaaaaaaaoaaaaak
ecaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpckaabaaa
abaaaaaadicaaaahccaabaaaabaaaaaackaabaaaabaaaaaabkaabaaaabaaaaaa
dcaaaaajecaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
aaaaeaeadiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaa
diaaaaahcccabaaaadaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaadcaaaaal
mccabaaaadaaaaaaagbebaaaaeaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaa
aaaaaaaaakaaaaaadgaaaaafbccabaaaadaaaaaadkbabaaaafaaaaaabaaaaaak
ccaabaaaabaaaaaaegbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdn
aaaaaaaaaaaaaaaihcaabaaaacaaaaaafgafbaiaebaaaaaaabaaaaaaegbcbaaa
afaaaaaadcaaaaakocaabaaaabaaaaaakgikcaaaaaaaaaaaaiaaaaaaagajbaaa
acaaaaaafgafbaaaabaaaaaadcaaaaamocaabaaaabaaaaaaagijcaiaebaaaaaa
aaaaaaaaadaaaaaapgipcaaaaaaaaaaaadaaaaaafgaobaaaabaaaaaadiaaaaaj
hcaabaaaacaaaaaapgipcaaaaaaaaaaaadaaaaaaegiccaaaaaaaaaaaadaaaaaa
dcaaaaakhccabaaaaeaaaaaapgipcaaaaaaaaaaaaiaaaaaajgahbaaaabaaaaaa
egacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaakncaabaaaacaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaafaaaaaakgaobaaa
aaaaaaaaaaaaaaahdccabaaaafaaaaaakgakbaaaacaaaaaamgaabaaaacaaaaaa
aaaaaaajbcaabaaaaaaaaaaadkiacaiaebaaaaaaacaaaaaabjaaaaaaabeaaaaa
aaaaiadpdiaaaaaiiccabaaaagaaaaaaakaabaaaaaaaaaaaakaabaiaebaaaaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaabjaaaaaa
diaaaaaihccabaaaagaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaabjaaaaaa
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
					208
					Vector 48[_tintColor]
					Float 72[_groundTexStart]
					Float 76[_groundTexEnd]
					Float 136[_saturation]
					Float 140[_contrast]
					Vector 160[unity_LightmapST]
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
eefiecednekmhilhphglhdkplgiemianhpokkhbnabaaaaaadiamaaaaaeaaaaaa
daaaaaaaaaaeaaaaiiakaaaafaalaaaaebgpgodjmiadaaaamiadaaaaaaacpopp
emadaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaadaa
acaaabaaaaaaaaaaaaaaaiaaabaaadaaaaaaaaaaaaaaakaaabaaaeaaaaaaaaaa
abaaafaaabaaafaaaaaaaaaaacaabjaaabaaagaaaaaaaaaaadaaaaaaaiaaahaa
aaaaaaaaadaaamaaaeaaapaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafbdaaapka
aaaaaaaaaaaaiadpaaaaaamaaaaaeaeafbaaaaafbeaaapkaihbgjjdokcefbgdp
nfhiojdnaaaaaadpbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaadiaadaaapja
bpaaaaacafaaaeiaaeaaapjabpaaaaacafaaafiaafaaapjaabaaaaacaaaaadia
adaaoejaabaaaaacaaaaaeiaaeaaaajaceaaaaacabaaahiaaaaaoeiacdaaaaac
abaaahoaabaaoeiaabaaaaacaaaaahoaabaaoeiaafaaaaadaaaaabiaaaaaffja
amaakkkaaeaaaaaeaaaaabiaalaakkkaaaaaaajaaaaaaaiaaeaaaaaeaaaaabia
anaakkkaaaaakkjaaaaaaaiaaeaaaaaeaaaaabiaaoaakkkaaaaappjaaaaaaaia
acaaaaadaaaaaciaaaaaaaibacaakkkbacaaaaadaaaaaeiaacaakkkbacaappka
agaaaaacaaaaaeiaaaaakkiaafaaaaadaaaaaciaaaaakkiaaaaaffiaalaaaaad
aaaaaciaaaaaffiabdaaaakaakaaaaadaaaaaciaaaaaffiabdaaffkaaeaaaaae
aaaaaeiaaaaaffiabdaakkkabdaappkaafaaaaadaaaaaciaaaaaffiaaaaaffia
afaaaaadacaaacoaaaaaffiaaaaakkiaaiaaaaadaaaaaciaafaaoejabeaaoeka
bcaaaaaeabaaahiaadaakkkaafaaoejaaaaaffiaaeaaaaaeaaaaaoiaabaajaka
abaappkbabaajaiaafaaaaadabaaahiaabaappkaabaaoekaaeaaaaaeadaaahoa
adaappkaaaaapjiaabaaoeiaafaaaaadabaaapiaaaaaffjaaiaaoekaaeaaaaae
abaaapiaahaaoekaaaaaaajaabaaoeiaaeaaaaaeabaaapiaajaaoekaaaaakkja
abaaoeiaaeaaaaaeabaaapiaakaaoekaaaaappjaabaaoeiaafaaaaadaaaaacia
abaaffiaafaaaakaafaaaaadacaaaiiaaaaaffiabeaappkaafaaaaadacaaafia
abaapeiabeaappkaacaaaaadaeaaadoaacaakkiaacaaomiaaeaaaaaeacaaamoa
aeaabejaaeaabekaaeaalekaafaaaaadaaaaaoiaaaaaffjabaaajakaaeaaaaae
aaaaaoiaapaajakaaaaaaajaaaaaoeiaaeaaaaaeaaaaaoiabbaajakaaaaakkja
aaaaoeiaaeaaaaaeaaaaaoiabcaajakaaaaappjaaaaaoeiaacaaaaadaaaaaoia
aaaaoeiaagaajakbafaaaaadafaaahoaaaaapjiaagaappkaabaaaaacaaaaaiia
agaappkaacaaaaadaaaaaciaaaaappibbdaaffkaafaaaaadafaaaioaaaaaffia
aaaaaaibaeaaaaaeaaaaadmaabaappiaaaaaoekaabaaoeiaabaaaaacaaaaamma
abaaoeiaabaaaaacaeaaamoaabaaoeiaabaaaaacacaaaboaafaappjappppaaaa
fdeieefciaagaaaaeaaaabaakaabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabkaaaaaa
fjaaaaaeegiocaaaadaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagfaaaaadpccabaaa
agaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaa
abaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaabaaaaaaakbabaaaaeaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
abaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaabaaaaaadiaaaaaibcaabaaa
abaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaa
abaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaabaaaaaa
dcaaaaakbcaabaaaabaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaa
akaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaadaaaaaaahaaaaaa
dkbabaaaaaaaaaaaakaabaaaabaaaaaaaaaaaaakccaabaaaabaaaaaaakaabaia
ebaaaaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaaaaaaaaakecaabaaa
abaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaadkiacaaaaaaaaaaaaeaaaaaa
aoaaaaakecaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
ckaabaaaabaaaaaadicaaaahccaabaaaabaaaaaackaabaaaabaaaaaabkaabaaa
abaaaaaadcaaaaajecaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaa
abaaaaaadiaaaaahcccabaaaadaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaa
dcaaaaalmccabaaaadaaaaaaagbebaaaaeaaaaaaagiecaaaaaaaaaaaakaaaaaa
kgiocaaaaaaaaaaaakaaaaaadgaaaaafbccabaaaadaaaaaadkbabaaaafaaaaaa
baaaaaakccaabaaaabaaaaaaegbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdp
nfhiojdnaaaaaaaaaaaaaaaihcaabaaaacaaaaaafgafbaiaebaaaaaaabaaaaaa
egbcbaaaafaaaaaadcaaaaakocaabaaaabaaaaaakgikcaaaaaaaaaaaaiaaaaaa
agajbaaaacaaaaaafgafbaaaabaaaaaadcaaaaamocaabaaaabaaaaaaagijcaia
ebaaaaaaaaaaaaaaadaaaaaapgipcaaaaaaaaaaaadaaaaaafgaobaaaabaaaaaa
diaaaaajhcaabaaaacaaaaaapgipcaaaaaaaaaaaadaaaaaaegiccaaaaaaaaaaa
adaaaaaadcaaaaakhccabaaaaeaaaaaapgipcaaaaaaaaaaaaiaaaaaajgahbaaa
abaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaacaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaafaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaafaaaaaakgakbaaaacaaaaaamgaabaaa
acaaaaaaaaaaaaajbcaabaaaaaaaaaaadkiacaiaebaaaaaaacaaaaaabjaaaaaa
abeaaaaaaaaaiadpdiaaaaaiiccabaaaagaaaaaaakaabaaaaaaaaaaaakaabaia
ebaaaaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaa
bjaaaaaadiaaaaaihccabaaaagaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaa
bjaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaa
laaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaa
feeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaaaiaaaaaa
miaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaahaiaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaa
neaaaaaaafaaaaaaaaaaaaaaadaaaaaaadaaaaaaamadaaaaneaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
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
					Float 11[_groundTexStart]
					Float 12[_groundTexEnd]
					Float 13[_saturation]
					Float 14[_contrast]
					Vector 15[unity_LightmapST]
					"!!ARBvp1.0
PARAM c[17] = { { 0, 1, 3, 2 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..15],
		{ 0.29899999, 0.58700001, 0.114, 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
DP3 R0.w, vertex.color, c[16];
ADD R0.xyz, vertex.color, -R0.w;
MAD R3.xyz, R0, c[13].x, R0.w;
MUL R0.xyz, c[10], c[10].w;
MAD R3.xyz, -c[10], c[10].w, R3;
MAD result.texcoord[3].xyz, R3, c[14].x, R0;
DP4 R1.w, vertex.position, c[8];
DP4 R1.z, vertex.position, c[7];
DP4 R1.x, vertex.position, c[5];
DP4 R1.y, vertex.position, c[6];
MUL R2.xyz, R1.xyww, c[16].w;
MOV result.position, R1;
MOV R1.x, c[11];
ADD R1.x, -R1, c[12];
MUL R0.y, R2, c[9].x;
MOV R0.x, R2;
ADD result.texcoord[4].xy, R0, R2.z;
MOV R0.xy, vertex.texcoord[0];
MOV R0.z, vertex.texcoord[1].x;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
DP4 R0.w, vertex.position, c[3];
MOV result.texcoord[0].xyz, R0;
ABS result.texcoord[1].xyz, R0;
RCP R1.x, R1.x;
ADD R0.w, -R0, -c[11].x;
MUL R0.w, R0, R1.x;
MIN R0.w, R0, c[0].y;
MAX R0.x, R0.w, c[0];
MAD R0.y, -R0.x, c[0].w, c[0].z;
MUL R0.x, R0, R0;
MOV result.texcoord[4].zw, R1;
MUL result.texcoord[2].y, R0.x, R0;
MAD result.texcoord[5].xy, vertex.texcoord[1], c[15], c[15].zwzw;
MOV result.texcoord[2].x, vertex.color.w;
END
# 36 instructions, 4 R-regs
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
					Float 11[_groundTexStart]
					Float 12[_groundTexEnd]
					Float 13[_saturation]
					Float 14[_contrast]
					Vector 15[unity_LightmapST]
					"vs_2_0
def c16, 1.00000000, 0.00000000, 2.00000000, 3.00000000
def c17, 0.29899999, 0.58700001, 0.11400000, 0.50000000
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dcl_color0 v3
dp3 r0.w, v3, c17
add r0.xyz, v3, -r0.w
mad r3.xyz, r0, c13.x, r0.w
mul r0.xyz, c10, c10.w
mad r3.xyz, -c10, c10.w, r3
mad oT3.xyz, r3, c14.x, r0
dp4 r1.w, v0, c7
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r2.xyz, r1.xyww, c17.w
mov oPos, r1
mov r1.x, c12
add r1.x, -c11, r1
mul r0.y, r2, c8.x
mov r0.x, r2
mad oT4.xy, r2.z, c9.zwzw, r0
mov r0.xy, v1
mov r0.z, v2.x
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp4 r0.w, v0, c2
mov oT0.xyz, r0
abs oT1.xyz, r0
rcp r1.x, r1.x
add r0.w, -r0, -c11.x
mul r0.w, r0, r1.x
min r0.w, r0, c16.x
max r0.x, r0.w, c16.y
mad r0.y, -r0.x, c16.z, c16.w
mul r0.x, r0, r0
mov oT4.zw, r1
mul oT2.y, r0.x, r0
mad oT5.xy, v2, c15, c15.zwzw
mov oT2.x, v3.w
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
					208
					Vector 48[_tintColor]
					Float 72[_groundTexStart]
					Float 76[_groundTexEnd]
					Float 136[_saturation]
					Float 140[_contrast]
					Vector 160[unity_LightmapST]
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
eefiecedkdenlliljdhliccneehnbmcoihfgiiikabaaaaaabaahaaaaadaaaaaa
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
adamaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaadaaaaaaamadaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefceeafaaaaeaaaabaafbabaaaafjaaaaaeegiocaaaaaaaaaaa
alaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
dccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadpccabaaaafaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaa
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
acaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaabaaaaaaaaaaaaakbcaabaaa
abaaaaaaakaabaiaebaaaaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaa
aaaaaaakccaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaadkiacaaa
aaaaaaaaaeaaaaaaaoaaaaakccaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpbkaabaaaabaaaaaadicaaaahbcaabaaaabaaaaaabkaabaaa
abaaaaaaakaabaaaabaaaaaadcaaaaajccaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahcccabaaaadaaaaaaakaabaaaabaaaaaa
bkaabaaaabaaaaaadcaaaaalmccabaaaadaaaaaaagbebaaaaeaaaaaaagiecaaa
aaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaadgaaaaafbccabaaaadaaaaaa
dkbabaaaafaaaaaabaaaaaakbcaabaaaabaaaaaaegbcbaaaafaaaaaaaceaaaaa
ihbgjjdokcefbgdpnfhiojdnaaaaaaaaaaaaaaaiocaabaaaabaaaaaaagaabaia
ebaaaaaaabaaaaaaagbjbaaaafaaaaaadcaaaaakhcaabaaaabaaaaaakgikcaaa
aaaaaaaaaiaaaaaajgahbaaaabaaaaaaagaabaaaabaaaaaadcaaaaamhcaabaaa
abaaaaaaegiccaiaebaaaaaaaaaaaaaaadaaaaaapgipcaaaaaaaaaaaadaaaaaa
egacbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaapgipcaaaaaaaaaaaadaaaaaa
egiccaaaaaaaaaaaadaaaaaadcaaaaakhccabaaaaeaaaaaapgipcaaaaaaaaaaa
aiaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaafaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaafaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadoaaaaab"
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
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					208
					Vector 48[_tintColor]
					Float 72[_groundTexStart]
					Float 76[_groundTexEnd]
					Float 136[_saturation]
					Float 140[_contrast]
					Vector 160[unity_LightmapST]
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
eefieceddoedhigkalcdohcajfifclknnjpfgicpabaaaaaadeakaaaaaeaaaaaa
daaaaaaafaadaaaajmaiaaaageajaaaaebgpgodjbiadaaaabiadaaaaaaacpopp
leacaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaadaa
acaaabaaaaaaaaaaaaaaaiaaabaaadaaaaaaaaaaaaaaakaaabaaaeaaaaaaaaaa
abaaafaaabaaafaaaaaaaaaaacaaaaaaaiaaagaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafaoaaapkaaaaaaaaaaaaaiadpaaaaaamaaaaaeaeafbaaaaafapaaapka
ihbgjjdokcefbgdpnfhiojdnaaaaaadpbpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjabpaaaaacafaaafiaafaaapja
abaaaaacaaaaadiaadaaoejaabaaaaacaaaaaeiaaeaaaajaceaaaaacabaaahia
aaaaoeiacdaaaaacabaaahoaabaaoeiaabaaaaacaaaaahoaabaaoeiaafaaaaad
aaaaabiaaaaaffjaalaakkkaaeaaaaaeaaaaabiaakaakkkaaaaaaajaaaaaaaia
aeaaaaaeaaaaabiaamaakkkaaaaakkjaaaaaaaiaaeaaaaaeaaaaabiaanaakkka
aaaappjaaaaaaaiaacaaaaadaaaaabiaaaaaaaibacaakkkbacaaaaadaaaaacia
acaakkkbacaappkaagaaaaacaaaaaciaaaaaffiaafaaaaadaaaaabiaaaaaffia
aaaaaaiaalaaaaadaaaaabiaaaaaaaiaaoaaaakaakaaaaadaaaaabiaaaaaaaia
aoaaffkaaeaaaaaeaaaaaciaaaaaaaiaaoaakkkaaoaappkaafaaaaadaaaaabia
aaaaaaiaaaaaaaiaafaaaaadacaaacoaaaaaaaiaaaaaffiaaiaaaaadaaaaabia
afaaoejaapaaoekabcaaaaaeabaaahiaadaakkkaafaaoejaaaaaaaiaaeaaaaae
aaaaahiaabaaoekaabaappkbabaaoeiaafaaaaadabaaahiaabaappkaabaaoeka
aeaaaaaeadaaahoaadaappkaaaaaoeiaabaaoeiaafaaaaadaaaaapiaaaaaffja
ahaaoekaaeaaaaaeaaaaapiaagaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
aiaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaajaaoekaaaaappjaaaaaoeia
afaaaaadabaaabiaaaaaffiaafaaaakaafaaaaadabaaaiiaabaaaaiaapaappka
afaaaaadabaaafiaaaaapeiaapaappkaacaaaaadaeaaadoaabaakkiaabaaomia
aeaaaaaeacaaamoaaeaabejaaeaabekaaeaalekaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaeaaamoaaaaaoeia
abaaaaacacaaaboaafaappjappppaaaafdeieefceeafaaaaeaaaabaafbabaaaa
fjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacadaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaa
dgaaaaafecaabaaaabaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaacaaaaaa
egacbaiaibaaaaaaabaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaacaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaa
ckiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaak
bcaabaaaabaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
abaaaaaaaaaaaaakbcaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaackiacaia
ebaaaaaaaaaaaaaaaeaaaaaaaaaaaaakccaabaaaabaaaaaackiacaiaebaaaaaa
aaaaaaaaaeaaaaaadkiacaaaaaaaaaaaaeaaaaaaaoaaaaakccaabaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaabaaaaaadicaaaah
bcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaajccaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahcccabaaa
adaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaalmccabaaaadaaaaaa
agbebaaaaeaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaa
dgaaaaafbccabaaaadaaaaaadkbabaaaafaaaaaabaaaaaakbcaabaaaabaaaaaa
egbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaaaaaaaaai
ocaabaaaabaaaaaaagaabaiaebaaaaaaabaaaaaaagbjbaaaafaaaaaadcaaaaak
hcaabaaaabaaaaaakgikcaaaaaaaaaaaaiaaaaaajgahbaaaabaaaaaaagaabaaa
abaaaaaadcaaaaamhcaabaaaabaaaaaaegiccaiaebaaaaaaaaaaaaaaadaaaaaa
pgipcaaaaaaaaaaaadaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaa
pgipcaaaaaaaaaaaadaaaaaaegiccaaaaaaaaaaaadaaaaaadcaaaaakhccabaaa
aeaaaaaapgipcaaaaaaaaaaaaiaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaafmccabaaaafaaaaaakgaobaaaaaaaaaaaaaaaaaah
dccabaaaafaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaabejfdeheo
maaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaalaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
ahaiaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaadaaaaaaamadaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklkl"
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
					Float 23[_groundTexStart]
					Float 24[_groundTexEnd]
					Float 25[_saturation]
					Float 26[_contrast]
					"!!ARBvp1.0
PARAM c[28] = { { 0, 1, 3, 2 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..26],
		{ 0.29899999, 0.58700001, 0.114, 0.5 } };
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
DP3 R0.w, vertex.color, c[27];
ADD R0.xyz, vertex.color, -R0.w;
MAD R3.xyz, R0, c[25].x, R0.w;
MUL R0.xyz, c[22], c[22].w;
MAD R3.xyz, -c[22], c[22].w, R3;
MAD result.texcoord[3].xyz, R3, c[26].x, R0;
DP4 R1.w, vertex.position, c[8];
DP4 R1.z, vertex.position, c[7];
DP4 R1.x, vertex.position, c[5];
DP4 R1.y, vertex.position, c[6];
MUL R2.xyz, R1.xyww, c[27].w;
MOV result.position, R1;
MOV R1.x, c[23];
ADD R1.x, -R1, c[24];
MUL R0.y, R2, c[13].x;
MOV R0.x, R2;
ADD result.texcoord[4].xy, R0, R2.z;
MOV R0.xy, vertex.texcoord[0];
MOV R0.z, vertex.texcoord[1].x;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
DP4 R0.w, vertex.position, c[3];
MOV result.texcoord[0].xyz, R0;
ABS result.texcoord[1].xyz, R0;
RCP R1.x, R1.x;
ADD R0.w, -R0, -c[23].x;
MUL R0.w, R0, R1.x;
MIN R0.w, R0, c[0].y;
MAX R0.x, R0.w, c[0];
MAD R0.y, -R0.x, c[0].w, c[0].z;
MUL R0.x, R0, R0;
MOV result.texcoord[4].zw, R1;
MUL result.texcoord[2].y, R0.x, R0;
MOV result.texcoord[2].x, vertex.color.w;
END
# 53 instructions, 4 R-regs
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
					Float 23[_groundTexStart]
					Float 24[_groundTexEnd]
					Float 25[_saturation]
					Float 26[_contrast]
					"vs_2_0
def c27, 1.00000000, 0.00000000, 2.00000000, 3.00000000
def c28, 0.29899999, 0.58700001, 0.11400000, 0.50000000
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
add oT5.xyz, r1, r0
dp3 r0.w, v4, c28
add r0.xyz, v4, -r0.w
mad r3.xyz, r0, c25.x, r0.w
mul r0.xyz, c22, c22.w
mad r3.xyz, -c22, c22.w, r3
mad oT3.xyz, r3, c26.x, r0
dp4 r1.w, v0, c7
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r2.xyz, r1.xyww, c28.w
mov oPos, r1
mov r1.x, c24
add r1.x, -c23, r1
mul r0.y, r2, c12.x
mov r0.x, r2
mad oT4.xy, r2.z, c13.zwzw, r0
mov r0.xy, v2
mov r0.z, v3.x
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp4 r0.w, v0, c2
mov oT0.xyz, r0
abs oT1.xyz, r0
rcp r1.x, r1.x
add r0.w, -r0, -c23.x
mul r0.w, r0, r1.x
min r0.w, r0, c27.x
max r0.x, r0.w, c27.y
mad r0.y, -r0.x, c27.z, c27.w
mul r0.x, r0, r0
mov oT4.zw, r1
mul oT2.y, r0.x, r0
mov oT2.x, v4.w
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
					176
					Vector 48[_tintColor]
					Float 72[_groundTexStart]
					Float 76[_groundTexEnd]
					Float 136[_saturation]
					Float 140[_contrast]
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
eefiecedkecoekodnckfllfmeadpkffeoiaanollabaaaaaaaiajaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcdmahaaaaeaaaabaampabaaaafjaaaaaeegiocaaaaaaaaaaa
ajaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
cnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadbcbabaaa
aeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaa
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
ahaaaaaadkbabaaaaaaaaaaaakaabaaaabaaaaaaaaaaaaakbcaabaaaabaaaaaa
akaabaiaebaaaaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaaaaaaaaak
ccaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaadkiacaaaaaaaaaaa
aeaaaaaaaoaaaaakccaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpbkaabaaaabaaaaaadicaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaa
akaabaaaabaaaaaadcaaaaajccaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahcccabaaaadaaaaaaakaabaaaabaaaaaabkaabaaa
abaaaaaadgaaaaafbccabaaaadaaaaaadkbabaaaafaaaaaabaaaaaakbcaabaaa
abaaaaaaegbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaa
aaaaaaaiocaabaaaabaaaaaaagaabaiaebaaaaaaabaaaaaaagbjbaaaafaaaaaa
dcaaaaakhcaabaaaabaaaaaakgikcaaaaaaaaaaaaiaaaaaajgahbaaaabaaaaaa
agaabaaaabaaaaaadcaaaaamhcaabaaaabaaaaaaegiccaiaebaaaaaaaaaaaaaa
adaaaaaapgipcaaaaaaaaaaaadaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaa
acaaaaaapgipcaaaaaaaaaaaadaaaaaaegiccaaaaaaaaaaaadaaaaaadcaaaaak
hccabaaaaeaaaaaapgipcaaaaaaaaaaaaiaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaafaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaafaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaai
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
hccabaaaagaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaaaaaaaaaegacbaaa
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
					176
					Vector 48[_tintColor]
					Float 72[_groundTexStart]
					Float 76[_groundTexEnd]
					Float 136[_saturation]
					Float 140[_contrast]
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
eefiecedffjnbcimflggcbloighnhncmcgfchglaabaaaaaaeianaaaaaeaaaaaa
daaaaaaagmaeaaaalaalaaaahiamaaaaebgpgodjdeaeaaaadeaeaaaaaaacpopp
liadaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaadaa
acaaabaaaaaaaaaaaaaaaiaaabaaadaaaaaaaaaaabaaafaaabaaaeaaaaaaaaaa
acaacgaaahaaafaaaaaaaaaaadaaaaaaaiaaamaaaaaaaaaaadaaamaaadaabeaa
aaaaaaaaadaabeaaabaabhaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafbiaaapka
aaaaaaaaaaaaiadpaaaaaamaaaaaeaeafbaaaaafbjaaapkaihbgjjdokcefbgdp
nfhiojdnaaaaaadpbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapja
bpaaaaacafaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjabpaaaaacafaaafia
afaaapjaabaaaaacaaaaadiaadaaoejaabaaaaacaaaaaeiaaeaaaajaceaaaaac
abaaahiaaaaaoeiacdaaaaacabaaahoaabaaoeiaabaaaaacaaaaahoaabaaoeia
afaaaaadaaaaabiaaaaaffjabbaakkkaaeaaaaaeaaaaabiabaaakkkaaaaaaaja
aaaaaaiaaeaaaaaeaaaaabiabcaakkkaaaaakkjaaaaaaaiaaeaaaaaeaaaaabia
bdaakkkaaaaappjaaaaaaaiaacaaaaadaaaaabiaaaaaaaibacaakkkbacaaaaad
aaaaaciaacaakkkbacaappkaagaaaaacaaaaaciaaaaaffiaafaaaaadaaaaabia
aaaaffiaaaaaaaiaalaaaaadaaaaabiaaaaaaaiabiaaaakaakaaaaadaaaaabia
aaaaaaiabiaaffkaaeaaaaaeaaaaaciaaaaaaaiabiaakkkabiaappkaafaaaaad
aaaaabiaaaaaaaiaaaaaaaiaafaaaaadacaaacoaaaaaaaiaaaaaffiaaiaaaaad
aaaaabiaafaaoejabjaaoekabcaaaaaeabaaahiaadaakkkaafaaoejaaaaaaaia
aeaaaaaeaaaaahiaabaaoekaabaappkbabaaoeiaafaaaaadabaaahiaabaappka
abaaoekaaeaaaaaeadaaahoaadaappkaaaaaoeiaabaaoeiaafaaaaadaaaaapia
aaaaffjaanaaoekaaeaaaaaeaaaaapiaamaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiaaoaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaapaaoekaaaaappja
aaaaoeiaafaaaaadabaaabiaaaaaffiaaeaaaakaafaaaaadabaaaiiaabaaaaia
bjaappkaafaaaaadabaaafiaaaaapeiabjaappkaacaaaaadaeaaadoaabaakkia
abaaomiaafaaaaadabaaahiaacaaoejabhaappkaafaaaaadacaaahiaabaaffia
bfaaoekaaeaaaaaeabaaaliabeaakekaabaaaaiaacaakeiaaeaaaaaeabaaahia
bgaaoekaabaakkiaabaapeiaabaaaaacabaaaiiabiaaffkaajaaaaadacaaabia
afaaoekaabaaoeiaajaaaaadacaaaciaagaaoekaabaaoeiaajaaaaadacaaaeia
ahaaoekaabaaoeiaafaaaaadadaaapiaabaacjiaabaakeiaajaaaaadaeaaabia
aiaaoekaadaaoeiaajaaaaadaeaaaciaajaaoekaadaaoeiaajaaaaadaeaaaeia
akaaoekaadaaoeiaacaaaaadacaaahiaacaaoeiaaeaaoeiaafaaaaadabaaacia
abaaffiaabaaffiaaeaaaaaeabaaabiaabaaaaiaabaaaaiaabaaffibaeaaaaae
afaaahoaalaaoekaabaaaaiaacaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoeka
aaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaeaaamoaaaaaoeiaabaaaaac
acaaaboaafaappjappppaaaafdeieefcdmahaaaaeaaaabaampabaaaafjaaaaae
egiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaadbcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaa
afaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaa
abaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaa
abaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaa
abaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaa
afaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaadaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaa
ckiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaabaaaaaaaaaaaaak
bcaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaackiacaiaebaaaaaaaaaaaaaa
aeaaaaaaaaaaaaakccaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaa
dkiacaaaaaaaaaaaaeaaaaaaaoaaaaakccaabaaaabaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpbkaabaaaabaaaaaadicaaaahbcaabaaaabaaaaaa
bkaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaajccaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahcccabaaaadaaaaaaakaabaaa
abaaaaaabkaabaaaabaaaaaadgaaaaafbccabaaaadaaaaaadkbabaaaafaaaaaa
baaaaaakbcaabaaaabaaaaaaegbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdp
nfhiojdnaaaaaaaaaaaaaaaiocaabaaaabaaaaaaagaabaiaebaaaaaaabaaaaaa
agbjbaaaafaaaaaadcaaaaakhcaabaaaabaaaaaakgikcaaaaaaaaaaaaiaaaaaa
jgahbaaaabaaaaaaagaabaaaabaaaaaadcaaaaamhcaabaaaabaaaaaaegiccaia
ebaaaaaaaaaaaaaaadaaaaaapgipcaaaaaaaaaaaadaaaaaaegacbaaaabaaaaaa
diaaaaajhcaabaaaacaaaaaapgipcaaaaaaaaaaaadaaaaaaegiccaaaaaaaaaaa
adaaaaaadcaaaaakhccabaaaaeaaaaaapgipcaaaaaaaaaaaaiaaaaaaegacbaaa
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
aaaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaa
ahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
lmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaadamaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaa
lmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaalmaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
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
					Float 16[_groundTexStart]
					Float 17[_groundTexEnd]
					Float 18[_saturation]
					Float 19[_contrast]
					Vector 20[unity_LightmapST]
					"!!ARBvp1.0
PARAM c[22] = { { 0, 1, 3, 2 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..20],
		{ 0.29899999, 0.58700001, 0.114, 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
DP3 R0.w, vertex.color, c[21];
ADD R0.xyz, vertex.color, -R0.w;
MAD R3.xyz, R0, c[18].x, R0.w;
MUL R0.xyz, c[15], c[15].w;
MAD R3.xyz, -c[15], c[15].w, R3;
MAD result.texcoord[3].xyz, R3, c[19].x, R0;
DP4 R1.w, vertex.position, c[8];
DP4 R1.z, vertex.position, c[7];
DP4 R1.x, vertex.position, c[5];
DP4 R1.y, vertex.position, c[6];
MUL R2.xyz, R1.xyww, c[21].w;
MOV result.position, R1;
MOV R1.x, c[16];
ADD R1.x, -R1, c[17];
RCP R1.y, R1.x;
MUL R0.y, R2, c[13].x;
MOV R0.x, R2;
ADD result.texcoord[4].xy, R0, R2.z;
MOV R0.xy, vertex.texcoord[0];
MOV R0.z, vertex.texcoord[1].x;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
DP4 R0.w, vertex.position, c[3];
ADD R1.x, -R0.w, -c[16];
MUL R1.x, R1, R1.y;
MOV result.texcoord[0].xyz, R0;
ABS result.texcoord[1].xyz, R0;
MIN R1.x, R1, c[0].y;
MAX R0.x, R1, c[0];
MAD R0.y, -R0.x, c[0].w, c[0].z;
MUL R0.x, R0, R0;
MUL result.texcoord[2].y, R0.x, R0;
DP4 R0.x, vertex.position, c[9];
MOV result.texcoord[4].zw, R1;
DP4 R0.z, vertex.position, c[11];
DP4 R0.y, vertex.position, c[10];
ADD R1.xyz, R0, -c[14];
MOV R0.x, c[0].y;
ADD R0.x, R0, -c[14].w;
MUL result.texcoord[6].xyz, R1, c[14].w;
MAD result.texcoord[5].xy, vertex.texcoord[1], c[20], c[20].zwzw;
MUL result.texcoord[6].w, -R0, R0.x;
MOV result.texcoord[2].x, vertex.color.w;
END
# 44 instructions, 4 R-regs
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
					Float 16[_groundTexStart]
					Float 17[_groundTexEnd]
					Float 18[_saturation]
					Float 19[_contrast]
					Vector 20[unity_LightmapST]
					"vs_2_0
def c21, 0.00000000, 2.00000000, 3.00000000, 0.50000000
def c22, 0.29899999, 0.58700001, 0.11400000, 1.00000000
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dcl_color0 v3
dp3 r0.w, v3, c22
add r0.xyz, v3, -r0.w
mad r3.xyz, r0, c18.x, r0.w
mul r0.xyz, c15, c15.w
mad r3.xyz, -c15, c15.w, r3
mad oT3.xyz, r3, c19.x, r0
dp4 r1.w, v0, c7
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r2.xyz, r1.xyww, c21.w
mov oPos, r1
mov r1.x, c17
add r1.x, -c16, r1
rcp r1.y, r1.x
mul r0.y, r2, c12.x
mov r0.x, r2
mad oT4.xy, r2.z, c13.zwzw, r0
mov r0.xy, v1
mov r0.z, v2.x
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp4 r0.w, v0, c2
add r1.x, -r0.w, -c16
mul r1.x, r1, r1.y
mov oT0.xyz, r0
abs oT1.xyz, r0
min r1.x, r1, c22.w
max r0.x, r1, c21
mad r0.y, -r0.x, c21, c21.z
mul r0.x, r0, r0
mul oT2.y, r0.x, r0
dp4 r0.x, v0, c8
mov oT4.zw, r1
dp4 r0.z, v0, c10
dp4 r0.y, v0, c9
add r1.xyz, r0, -c14
mov r0.x, c14.w
add r0.x, c22.w, -r0
mul oT6.xyz, r1, c14.w
mad oT5.xy, v2, c20, c20.zwzw
mul oT6.w, -r0, r0.x
mov oT2.x, v3.w
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
					208
					Vector 48[_tintColor]
					Float 72[_groundTexStart]
					Float 76[_groundTexEnd]
					Float 136[_saturation]
					Float 140[_contrast]
					Vector 160[unity_LightmapST]
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
eefiecededcioohcflfjellilegncmcocgbfdmdeabaaaaaageaiaaaaadaaaaaa
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
adamaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaadaaaaaaamadaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
iaagaaaaeaaaabaakaabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabkaaaaaafjaaaaae
egiocaaaadaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaaddcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaa
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
aaaaaaaaakaabaaaabaaaaaaaaaaaaakccaabaaaabaaaaaaakaabaiaebaaaaaa
abaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaaaaaaaaakecaabaaaabaaaaaa
ckiacaiaebaaaaaaaaaaaaaaaeaaaaaadkiacaaaaaaaaaaaaeaaaaaaaoaaaaak
ecaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpckaabaaa
abaaaaaadicaaaahccaabaaaabaaaaaackaabaaaabaaaaaabkaabaaaabaaaaaa
dcaaaaajecaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
aaaaeaeadiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaa
diaaaaahcccabaaaadaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaadcaaaaal
mccabaaaadaaaaaaagbebaaaaeaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaa
aaaaaaaaakaaaaaadgaaaaafbccabaaaadaaaaaadkbabaaaafaaaaaabaaaaaak
ccaabaaaabaaaaaaegbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdn
aaaaaaaaaaaaaaaihcaabaaaacaaaaaafgafbaiaebaaaaaaabaaaaaaegbcbaaa
afaaaaaadcaaaaakocaabaaaabaaaaaakgikcaaaaaaaaaaaaiaaaaaaagajbaaa
acaaaaaafgafbaaaabaaaaaadcaaaaamocaabaaaabaaaaaaagijcaiaebaaaaaa
aaaaaaaaadaaaaaapgipcaaaaaaaaaaaadaaaaaafgaobaaaabaaaaaadiaaaaaj
hcaabaaaacaaaaaapgipcaaaaaaaaaaaadaaaaaaegiccaaaaaaaaaaaadaaaaaa
dcaaaaakhccabaaaaeaaaaaapgipcaaaaaaaaaaaaiaaaaaajgahbaaaabaaaaaa
egacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaakncaabaaaacaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaafaaaaaakgaobaaa
aaaaaaaaaaaaaaahdccabaaaafaaaaaakgakbaaaacaaaaaamgaabaaaacaaaaaa
aaaaaaajbcaabaaaaaaaaaaadkiacaiaebaaaaaaacaaaaaabjaaaaaaabeaaaaa
aaaaiadpdiaaaaaiiccabaaaagaaaaaaakaabaaaaaaaaaaaakaabaiaebaaaaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaabjaaaaaa
diaaaaaihccabaaaagaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaabjaaaaaa
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
					208
					Vector 48[_tintColor]
					Float 72[_groundTexStart]
					Float 76[_groundTexEnd]
					Float 136[_saturation]
					Float 140[_contrast]
					Vector 160[unity_LightmapST]
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
eefiecednekmhilhphglhdkplgiemianhpokkhbnabaaaaaadiamaaaaaeaaaaaa
daaaaaaaaaaeaaaaiiakaaaafaalaaaaebgpgodjmiadaaaamiadaaaaaaacpopp
emadaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaadaa
acaaabaaaaaaaaaaaaaaaiaaabaaadaaaaaaaaaaaaaaakaaabaaaeaaaaaaaaaa
abaaafaaabaaafaaaaaaaaaaacaabjaaabaaagaaaaaaaaaaadaaaaaaaiaaahaa
aaaaaaaaadaaamaaaeaaapaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafbdaaapka
aaaaaaaaaaaaiadpaaaaaamaaaaaeaeafbaaaaafbeaaapkaihbgjjdokcefbgdp
nfhiojdnaaaaaadpbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaadiaadaaapja
bpaaaaacafaaaeiaaeaaapjabpaaaaacafaaafiaafaaapjaabaaaaacaaaaadia
adaaoejaabaaaaacaaaaaeiaaeaaaajaceaaaaacabaaahiaaaaaoeiacdaaaaac
abaaahoaabaaoeiaabaaaaacaaaaahoaabaaoeiaafaaaaadaaaaabiaaaaaffja
amaakkkaaeaaaaaeaaaaabiaalaakkkaaaaaaajaaaaaaaiaaeaaaaaeaaaaabia
anaakkkaaaaakkjaaaaaaaiaaeaaaaaeaaaaabiaaoaakkkaaaaappjaaaaaaaia
acaaaaadaaaaaciaaaaaaaibacaakkkbacaaaaadaaaaaeiaacaakkkbacaappka
agaaaaacaaaaaeiaaaaakkiaafaaaaadaaaaaciaaaaakkiaaaaaffiaalaaaaad
aaaaaciaaaaaffiabdaaaakaakaaaaadaaaaaciaaaaaffiabdaaffkaaeaaaaae
aaaaaeiaaaaaffiabdaakkkabdaappkaafaaaaadaaaaaciaaaaaffiaaaaaffia
afaaaaadacaaacoaaaaaffiaaaaakkiaaiaaaaadaaaaaciaafaaoejabeaaoeka
bcaaaaaeabaaahiaadaakkkaafaaoejaaaaaffiaaeaaaaaeaaaaaoiaabaajaka
abaappkbabaajaiaafaaaaadabaaahiaabaappkaabaaoekaaeaaaaaeadaaahoa
adaappkaaaaapjiaabaaoeiaafaaaaadabaaapiaaaaaffjaaiaaoekaaeaaaaae
abaaapiaahaaoekaaaaaaajaabaaoeiaaeaaaaaeabaaapiaajaaoekaaaaakkja
abaaoeiaaeaaaaaeabaaapiaakaaoekaaaaappjaabaaoeiaafaaaaadaaaaacia
abaaffiaafaaaakaafaaaaadacaaaiiaaaaaffiabeaappkaafaaaaadacaaafia
abaapeiabeaappkaacaaaaadaeaaadoaacaakkiaacaaomiaaeaaaaaeacaaamoa
aeaabejaaeaabekaaeaalekaafaaaaadaaaaaoiaaaaaffjabaaajakaaeaaaaae
aaaaaoiaapaajakaaaaaaajaaaaaoeiaaeaaaaaeaaaaaoiabbaajakaaaaakkja
aaaaoeiaaeaaaaaeaaaaaoiabcaajakaaaaappjaaaaaoeiaacaaaaadaaaaaoia
aaaaoeiaagaajakbafaaaaadafaaahoaaaaapjiaagaappkaabaaaaacaaaaaiia
agaappkaacaaaaadaaaaaciaaaaappibbdaaffkaafaaaaadafaaaioaaaaaffia
aaaaaaibaeaaaaaeaaaaadmaabaappiaaaaaoekaabaaoeiaabaaaaacaaaaamma
abaaoeiaabaaaaacaeaaamoaabaaoeiaabaaaaacacaaaboaafaappjappppaaaa
fdeieefciaagaaaaeaaaabaakaabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabkaaaaaa
fjaaaaaeegiocaaaadaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagfaaaaadpccabaaa
agaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaa
abaaaaaaegbabaaaadaaaaaadgaaaaafecaabaaaabaaaaaaakbabaaaaeaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
abaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaabaaaaaadiaaaaaibcaabaaa
abaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaa
abaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaabaaaaaa
dcaaaaakbcaabaaaabaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaa
akaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaadaaaaaaahaaaaaa
dkbabaaaaaaaaaaaakaabaaaabaaaaaaaaaaaaakccaabaaaabaaaaaaakaabaia
ebaaaaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaaaaaaaaakecaabaaa
abaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaadkiacaaaaaaaaaaaaeaaaaaa
aoaaaaakecaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
ckaabaaaabaaaaaadicaaaahccaabaaaabaaaaaackaabaaaabaaaaaabkaabaaa
abaaaaaadcaaaaajecaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaa
abaaaaaadiaaaaahcccabaaaadaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaa
dcaaaaalmccabaaaadaaaaaaagbebaaaaeaaaaaaagiecaaaaaaaaaaaakaaaaaa
kgiocaaaaaaaaaaaakaaaaaadgaaaaafbccabaaaadaaaaaadkbabaaaafaaaaaa
baaaaaakccaabaaaabaaaaaaegbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdp
nfhiojdnaaaaaaaaaaaaaaaihcaabaaaacaaaaaafgafbaiaebaaaaaaabaaaaaa
egbcbaaaafaaaaaadcaaaaakocaabaaaabaaaaaakgikcaaaaaaaaaaaaiaaaaaa
agajbaaaacaaaaaafgafbaaaabaaaaaadcaaaaamocaabaaaabaaaaaaagijcaia
ebaaaaaaaaaaaaaaadaaaaaapgipcaaaaaaaaaaaadaaaaaafgaobaaaabaaaaaa
diaaaaajhcaabaaaacaaaaaapgipcaaaaaaaaaaaadaaaaaaegiccaaaaaaaaaaa
adaaaaaadcaaaaakhccabaaaaeaaaaaapgipcaaaaaaaaaaaaiaaaaaajgahbaaa
abaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaacaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaafaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaafaaaaaakgakbaaaacaaaaaamgaabaaa
acaaaaaaaaaaaaajbcaabaaaaaaaaaaadkiacaiaebaaaaaaacaaaaaabjaaaaaa
abeaaaaaaaaaiadpdiaaaaaiiccabaaaagaaaaaaakaabaaaaaaaaaaaakaabaia
ebaaaaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaa
bjaaaaaadiaaaaaihccabaaaagaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaa
bjaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaa
laaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaa
feeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaaaiaaaaaa
miaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaahaiaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaa
neaaaaaaafaaaaaaaaaaaaaaadaaaaaaadaaaaaaamadaaaaneaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
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
					Float 11[_groundTexStart]
					Float 12[_groundTexEnd]
					Float 13[_saturation]
					Float 14[_contrast]
					Vector 15[unity_LightmapST]
					"!!ARBvp1.0
PARAM c[17] = { { 0, 1, 3, 2 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..15],
		{ 0.29899999, 0.58700001, 0.114, 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
DP3 R0.w, vertex.color, c[16];
ADD R0.xyz, vertex.color, -R0.w;
MAD R3.xyz, R0, c[13].x, R0.w;
MUL R0.xyz, c[10], c[10].w;
MAD R3.xyz, -c[10], c[10].w, R3;
MAD result.texcoord[3].xyz, R3, c[14].x, R0;
DP4 R1.w, vertex.position, c[8];
DP4 R1.z, vertex.position, c[7];
DP4 R1.x, vertex.position, c[5];
DP4 R1.y, vertex.position, c[6];
MUL R2.xyz, R1.xyww, c[16].w;
MOV result.position, R1;
MOV R1.x, c[11];
ADD R1.x, -R1, c[12];
MUL R0.y, R2, c[9].x;
MOV R0.x, R2;
ADD result.texcoord[4].xy, R0, R2.z;
MOV R0.xy, vertex.texcoord[0];
MOV R0.z, vertex.texcoord[1].x;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
DP4 R0.w, vertex.position, c[3];
MOV result.texcoord[0].xyz, R0;
ABS result.texcoord[1].xyz, R0;
RCP R1.x, R1.x;
ADD R0.w, -R0, -c[11].x;
MUL R0.w, R0, R1.x;
MIN R0.w, R0, c[0].y;
MAX R0.x, R0.w, c[0];
MAD R0.y, -R0.x, c[0].w, c[0].z;
MUL R0.x, R0, R0;
MOV result.texcoord[4].zw, R1;
MUL result.texcoord[2].y, R0.x, R0;
MAD result.texcoord[5].xy, vertex.texcoord[1], c[15], c[15].zwzw;
MOV result.texcoord[2].x, vertex.color.w;
END
# 36 instructions, 4 R-regs
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
					Float 11[_groundTexStart]
					Float 12[_groundTexEnd]
					Float 13[_saturation]
					Float 14[_contrast]
					Vector 15[unity_LightmapST]
					"vs_2_0
def c16, 1.00000000, 0.00000000, 2.00000000, 3.00000000
def c17, 0.29899999, 0.58700001, 0.11400000, 0.50000000
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dcl_color0 v3
dp3 r0.w, v3, c17
add r0.xyz, v3, -r0.w
mad r3.xyz, r0, c13.x, r0.w
mul r0.xyz, c10, c10.w
mad r3.xyz, -c10, c10.w, r3
mad oT3.xyz, r3, c14.x, r0
dp4 r1.w, v0, c7
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r2.xyz, r1.xyww, c17.w
mov oPos, r1
mov r1.x, c12
add r1.x, -c11, r1
mul r0.y, r2, c8.x
mov r0.x, r2
mad oT4.xy, r2.z, c9.zwzw, r0
mov r0.xy, v1
mov r0.z, v2.x
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp4 r0.w, v0, c2
mov oT0.xyz, r0
abs oT1.xyz, r0
rcp r1.x, r1.x
add r0.w, -r0, -c11.x
mul r0.w, r0, r1.x
min r0.w, r0, c16.x
max r0.x, r0.w, c16.y
mad r0.y, -r0.x, c16.z, c16.w
mul r0.x, r0, r0
mov oT4.zw, r1
mul oT2.y, r0.x, r0
mad oT5.xy, v2, c15, c15.zwzw
mov oT2.x, v3.w
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
					208
					Vector 48[_tintColor]
					Float 72[_groundTexStart]
					Float 76[_groundTexEnd]
					Float 136[_saturation]
					Float 140[_contrast]
					Vector 160[unity_LightmapST]
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
eefiecedkdenlliljdhliccneehnbmcoihfgiiikabaaaaaabaahaaaaadaaaaaa
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
adamaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaadaaaaaaamadaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefceeafaaaaeaaaabaafbabaaaafjaaaaaeegiocaaaaaaaaaaa
alaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
dccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadpccabaaaafaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaa
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
acaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaabaaaaaaaaaaaaakbcaabaaa
abaaaaaaakaabaiaebaaaaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaa
aaaaaaakccaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaadkiacaaa
aaaaaaaaaeaaaaaaaoaaaaakccaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpbkaabaaaabaaaaaadicaaaahbcaabaaaabaaaaaabkaabaaa
abaaaaaaakaabaaaabaaaaaadcaaaaajccaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahcccabaaaadaaaaaaakaabaaaabaaaaaa
bkaabaaaabaaaaaadcaaaaalmccabaaaadaaaaaaagbebaaaaeaaaaaaagiecaaa
aaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaadgaaaaafbccabaaaadaaaaaa
dkbabaaaafaaaaaabaaaaaakbcaabaaaabaaaaaaegbcbaaaafaaaaaaaceaaaaa
ihbgjjdokcefbgdpnfhiojdnaaaaaaaaaaaaaaaiocaabaaaabaaaaaaagaabaia
ebaaaaaaabaaaaaaagbjbaaaafaaaaaadcaaaaakhcaabaaaabaaaaaakgikcaaa
aaaaaaaaaiaaaaaajgahbaaaabaaaaaaagaabaaaabaaaaaadcaaaaamhcaabaaa
abaaaaaaegiccaiaebaaaaaaaaaaaaaaadaaaaaapgipcaaaaaaaaaaaadaaaaaa
egacbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaapgipcaaaaaaaaaaaadaaaaaa
egiccaaaaaaaaaaaadaaaaaadcaaaaakhccabaaaaeaaaaaapgipcaaaaaaaaaaa
aiaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaafaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaafaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadoaaaaab"
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
					Bind "texcoord"
					TexCoord0
					Bind "texcoord1"
					TexCoord1
					ConstBuffer "$Globals"
					208
					Vector 48[_tintColor]
					Float 72[_groundTexStart]
					Float 76[_groundTexEnd]
					Float 136[_saturation]
					Float 140[_contrast]
					Vector 160[unity_LightmapST]
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
eefieceddoedhigkalcdohcajfifclknnjpfgicpabaaaaaadeakaaaaaeaaaaaa
daaaaaaafaadaaaajmaiaaaageajaaaaebgpgodjbiadaaaabiadaaaaaaacpopp
leacaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaadaa
acaaabaaaaaaaaaaaaaaaiaaabaaadaaaaaaaaaaaaaaakaaabaaaeaaaaaaaaaa
abaaafaaabaaafaaaaaaaaaaacaaaaaaaiaaagaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafaoaaapkaaaaaaaaaaaaaiadpaaaaaamaaaaaeaeafbaaaaafapaaapka
ihbgjjdokcefbgdpnfhiojdnaaaaaadpbpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjabpaaaaacafaaafiaafaaapja
abaaaaacaaaaadiaadaaoejaabaaaaacaaaaaeiaaeaaaajaceaaaaacabaaahia
aaaaoeiacdaaaaacabaaahoaabaaoeiaabaaaaacaaaaahoaabaaoeiaafaaaaad
aaaaabiaaaaaffjaalaakkkaaeaaaaaeaaaaabiaakaakkkaaaaaaajaaaaaaaia
aeaaaaaeaaaaabiaamaakkkaaaaakkjaaaaaaaiaaeaaaaaeaaaaabiaanaakkka
aaaappjaaaaaaaiaacaaaaadaaaaabiaaaaaaaibacaakkkbacaaaaadaaaaacia
acaakkkbacaappkaagaaaaacaaaaaciaaaaaffiaafaaaaadaaaaabiaaaaaffia
aaaaaaiaalaaaaadaaaaabiaaaaaaaiaaoaaaakaakaaaaadaaaaabiaaaaaaaia
aoaaffkaaeaaaaaeaaaaaciaaaaaaaiaaoaakkkaaoaappkaafaaaaadaaaaabia
aaaaaaiaaaaaaaiaafaaaaadacaaacoaaaaaaaiaaaaaffiaaiaaaaadaaaaabia
afaaoejaapaaoekabcaaaaaeabaaahiaadaakkkaafaaoejaaaaaaaiaaeaaaaae
aaaaahiaabaaoekaabaappkbabaaoeiaafaaaaadabaaahiaabaappkaabaaoeka
aeaaaaaeadaaahoaadaappkaaaaaoeiaabaaoeiaafaaaaadaaaaapiaaaaaffja
ahaaoekaaeaaaaaeaaaaapiaagaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
aiaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaajaaoekaaaaappjaaaaaoeia
afaaaaadabaaabiaaaaaffiaafaaaakaafaaaaadabaaaiiaabaaaaiaapaappka
afaaaaadabaaafiaaaaapeiaapaappkaacaaaaadaeaaadoaabaakkiaabaaomia
aeaaaaaeacaaamoaaeaabejaaeaabekaaeaalekaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaeaaamoaaaaaoeia
abaaaaacacaaaboaafaappjappppaaaafdeieefceeafaaaaeaaaabaafbabaaaa
fjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacadaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaa
dgaaaaafecaabaaaabaaaaaaakbabaaaaeaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaacaaaaaa
egacbaiaibaaaaaaabaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaabaaaaaackiacaaaacaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaa
ckiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaak
bcaabaaaabaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
abaaaaaaaaaaaaakbcaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaackiacaia
ebaaaaaaaaaaaaaaaeaaaaaaaaaaaaakccaabaaaabaaaaaackiacaiaebaaaaaa
aaaaaaaaaeaaaaaadkiacaaaaaaaaaaaaeaaaaaaaoaaaaakccaabaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaabaaaaaadicaaaah
bcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaajccaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahcccabaaa
adaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaalmccabaaaadaaaaaa
agbebaaaaeaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaa
dgaaaaafbccabaaaadaaaaaadkbabaaaafaaaaaabaaaaaakbcaabaaaabaaaaaa
egbcbaaaafaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaaaaaaaaai
ocaabaaaabaaaaaaagaabaiaebaaaaaaabaaaaaaagbjbaaaafaaaaaadcaaaaak
hcaabaaaabaaaaaakgikcaaaaaaaaaaaaiaaaaaajgahbaaaabaaaaaaagaabaaa
abaaaaaadcaaaaamhcaabaaaabaaaaaaegiccaiaebaaaaaaaaaaaaaaadaaaaaa
pgipcaaaaaaaaaaaadaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaa
pgipcaaaaaaaaaaaadaaaaaaegiccaaaaaaaaaaaadaaaaaadcaaaaakhccabaaa
aeaaaaaapgipcaaaaaaaaaaaaiaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaafmccabaaaafaaaaaakgaobaaaaaaaaaaaaaaaaaah
dccabaaaafaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaabejfdeheo
maaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaalaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
ahaiaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaadaaaaaaamadaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklkl"
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
					Float 2[_multiFactor]
					Float 3[_PlanetOpacity]
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_LightBuffer] 2D 1 "!!ARBfp1.0
PARAM c[5] = { program.local[0..3],
		{ 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TXP R6.xyz, fragment.texcoord[4], texture[1], 2D;
MUL R4.xyz, fragment.texcoord[0], c[2].x;
MUL R1.xyz, fragment.texcoord[0], c[0].x;
ADD R0.w, -fragment.texcoord[2].y, c[4].x;
MOV result.color.w, c[3].x;
TEX R2.xyz, R1.zxzw, texture[0], 2D;
TEX R0.xyz, R1, texture[0], 2D;
TEX R1.xyz, R1.zyzw, texture[0], 2D;
TEX R5.xyz, R4.zxzw, texture[0], 2D;
TEX R3.xyz, R4, texture[0], 2D;
TEX R4.xyz, R4.zyzw, texture[0], 2D;
MUL R1.xyz, fragment.texcoord[1].x, R1;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
MUL R4.xyz, fragment.texcoord[1].x, R4;
MAD R3.xyz, fragment.texcoord[1].z, R3, R4;
MAD R1.xyz, fragment.texcoord[1].y, R5, R3;
MUL R1.xyz, fragment.texcoord[2].y, R1;
MAD R0.xyz, R2, fragment.texcoord[1].y, R0;
MAD R0.xyz, R0, R0.w, R1;
MAD R0.xyz, fragment.texcoord[3], R0, -fragment.texcoord[3];
LG2 R1.x, R6.x;
LG2 R1.z, R6.z;
LG2 R1.y, R6.y;
ADD R1.xyz, -R1, fragment.texcoord[5];
MAD R0.xyz, R0, c[1].x, fragment.texcoord[3];
MUL result.color.xyz, R0, R1;
END
# 26 instructions, 7 R-regs
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
					Float 2[_multiFactor]
					Float 3[_PlanetOpacity]
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_LightBuffer] 2D 1 "ps_2_0
dcl_2d s0
dcl_2d s1
def c4, 1.00000000, 0, 0, 0
dcl t0.xyz
dcl t1.xyz
dcl t2.xy
dcl t3.xyz
dcl t4
dcl t5.xyz
mul r5.xyz, t0, c2.x
mul r2.xyz, t0, c0.x
mov r4.xy, r5.zxyw
mov r1.xy, r2.zxyw
mov r0.y, r5
mov r0.x, r5.z
mov r6.xy, r0
mov r0.y, r2
mov r0.x, r2.z
mov r3.xy, r0
texldp r0, t4, s1
texld r1, r1, s0
texld r2, r2, s0
texld r4, r4, s0
texld r3, r3, s0
texld r6, r6, s0
texld r5, r5, s0
mul r3.xyz, t1.x, r3
mad r2.xyz, t1.z, r2, r3
mad r1.xyz, r1, t1.y, r2
mul r6.xyz, t1.x, r6
mad r5.xyz, t1.z, r5, r6
mad r4.xyz, t1.y, r4, r5
mul r2.xyz, t2.y, r4
add r3.x, -t2.y, c4
mad r1.xyz, r1, r3.x, r2
mad r1.xyz, t3, r1, -t3
log_pp r0.x, r0.x
log_pp r0.z, r0.z
log_pp r0.y, r0.y
add_pp r0.xyz, -r0, t5
mad r1.xyz, r1, c1.x, t3
mul_pp r0.xyz, r1, r0
mov_pp r0.w, c3.x
mov_pp oC0, r0
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_OFF"
					}
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_LightBuffer] 2D 1
					ConstBuffer "$Globals"
					176
					Float 64[_texTiling]
					Float 68[_texPower]
					Float 80[_multiFactor]
					Float 132[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0
eefieceddknnbhddlkdodenboebbdhnogcchaobiabaaaaaacaafaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadacaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoiadaaaaeaaaaaaapkaaaaaa
fjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadccbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadlcbabaaa
afaaaaaagcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaa
afaaaaaaefaaaaajpcaabaaaabaaaaaaggakbaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaa
acaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaacgakbaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaa
kgbkbaaaacaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
aaaaaaaafgbfbaaaacaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaafgbfbaaaadaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaa
abaaaaaaagiacaaaaaaaaaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
cgakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaa
acaaaaaaegacbaaaadaaaaaakgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaaj
hcaabaaaabaaaaaaegacbaaaabaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaa
aaaaaaaiicaabaaaaaaaaaaabkbabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadp
dcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaa
egbcbaiaebaaaaaaaeaaaaaadcaaaaakhcaabaaaaaaaaaaafgifcaaaaaaaaaaa
aeaaaaaaegacbaaaaaaaaaaaegbcbaaaaeaaaaaaaoaaaaahdcaabaaaabaaaaaa
egbabaaaafaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaacpaaaaafhcaabaaaabaaaaaa
egacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
egbcbaaaagaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaagiccabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaadoaaaaab
"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_OFF"
					}
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_LightBuffer] 2D 1
					ConstBuffer "$Globals"
					176
					Float 64[_texTiling]
					Float 68[_texPower]
					Float 80[_multiFactor]
					Float 132[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0_level_9_1
eefiecedpeghmkapnnljcihaemhnooopapadciokabaaaaaaneahaaaaaeaaaaaa
daaaaaaaoaacaaaanaagaaaakaahaaaaebgpgodjkiacaaaakiacaaaaaaacpppp
geacaaaaeeaaaaaaacaacmaaaaaaeeaaaaaaeeaaacaaceaaaaaaeeaaaaaaaaaa
abababaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaiaaabaaacaaaaaaaaaaaaacpppp
bpaaaaacaaaaaaiaaaaaahlabpaaaaacaaaaaaiaabaaahlabpaaaaacaaaaaaia
acaaadlabpaaaaacaaaaaaiaadaaahlabpaaaaacaaaaaaiaaeaaaplabpaaaaac
aaaaaaiaafaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
afaaaaadaaaaahiaaaaaoelaaaaaaakaabaaaaacabaaabiaaaaakkiaabaaaaac
abaaaciaaaaaffiaabaaaaacacaaadiaaaaanciaafaaaaadadaaahiaaaaaoela
abaaaakaabaaaaacaeaaabiaadaakkiaabaaaaacaeaaaciaadaaffiaabaaaaac
afaaadiaadaanciaagaaaaacaaaaaeiaaeaapplaafaaaaadagaaadiaaaaakkia
aeaaoelaecaaaaadabaaapiaabaaoeiaaaaioekaecaaaaadaaaaapiaaaaaoeia
aaaioekaecaaaaadacaaapiaacaaoeiaaaaioekaecaaaaadaeaaapiaaeaaoeia
aaaioekaecaaaaadadaaapiaadaaoeiaaaaioekaecaaaaadafaaapiaafaaoeia
aaaioekaecaaaaadagaacpiaagaaoeiaabaioekaafaaaaadabaaahiaabaaoeia
abaaaalaaeaaaaaeaaaaahiaaaaaoeiaabaakklaabaaoeiaaeaaaaaeaaaaahia
acaaoeiaabaafflaaaaaoeiaafaaaaadabaaahiaaeaaoeiaabaaaalaaeaaaaae
abaaahiaadaaoeiaabaakklaabaaoeiaaeaaaaaeabaaahiaafaaoeiaabaaffla
abaaoeiabcaaaaaeacaaahiaacaafflaabaaoeiaaaaaoeiaaeaaaaaeaaaaahia
adaaoelaacaaoeiaadaaoelbaeaaaaaeaaaachiaaaaaffkaaaaaoeiaadaaoela
apaaaaacabaacbiaagaaaaiaapaaaaacabaacciaagaaffiaapaaaaacabaaceia
agaakkiaacaaaaadabaachiaabaaoeibafaaoelaafaaaaadaaaachiaaaaaoeia
abaaoeiaabaaaaacaaaaciiaacaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefcoiadaaaaeaaaaaaapkaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadccbabaaaadaaaaaagcbaaaad
hcbabaaaaeaaaaaagcbaaaadlcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaadiaaaaaihcaabaaaaaaaaaaa
egbcbaaaabaaaaaaagiacaaaaaaaaaaaafaaaaaaefaaaaajpcaabaaaabaaaaaa
ggakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaacgakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaj
hcaabaaaabaaaaaaegacbaaaacaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaafgbfbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaafgbfbaaaadaaaaaa
diaaaaaihcaabaaaabaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaaeaaaaaa
efaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaagbabaaaacaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaacgakbaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaadaaaaaakgbkbaaa
acaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaabaaaaaa
fgbfbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaaiicaabaaaaaaaaaaabkbabaia
ebaaaaaaadaaaaaaabeaaaaaaaaaiadpdcaaaaajhcaabaaaaaaaaaaaegacbaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egbcbaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaiaebaaaaaaaeaaaaaadcaaaaak
hcaabaaaaaaaaaaafgifcaaaaaaaaaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaaa
aeaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaafaaaaaapgbpbaaaafaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaacpaaaaafhcaabaaaabaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaa
abaaaaaaegacbaiaebaaaaaaabaaaaaaegbcbaaaagaaaaaadiaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaagiccabaaaaaaaaaaa
bkiacaaaaaaaaaaaaiaaaaaadoaaaaabejfdeheomiaaaaaaahaaaaaaaiaaaaaa
laaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaahahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadacaaaa
lmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapalaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaa
agaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
				}
				SubProgram "opengl " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_OFF"
					}
					Float 0[_texTiling]
					Float 1[_texPower]
					Float 2[_multiFactor]
					Float 3[_PlanetOpacity]
					Vector 4[unity_LightmapFade]
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_LightBuffer] 2D 1
					SetTexture 2[unity_Lightmap] 2D 2
					SetTexture 3[unity_LightmapInd] 2D 3 "!!ARBfp1.0
PARAM c[6] = { program.local[0..4],
		{ 1, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEMP R8;
TEX R0, fragment.texcoord[5], texture[3], 2D;
TEX R1, fragment.texcoord[5], texture[2], 2D;
TXP R8.xyz, fragment.texcoord[4], texture[1], 2D;
MUL R6.xyz, fragment.texcoord[0], c[2].x;
MUL R3.xyz, fragment.texcoord[0], c[0].x;
MUL R1.xyz, R1.w, R1;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, c[5].y;
DP4 R1.w, fragment.texcoord[6], fragment.texcoord[6];
RSQ R0.w, R1.w;
RCP R0.w, R0.w;
MAD R1.xyz, R1, c[5].y, -R0;
MAD_SAT R0.w, R0, c[4].z, c[4];
MAD R1.xyz, R0.w, R1, R0;
ADD R2.w, -fragment.texcoord[2].y, c[5].x;
LG2 R0.x, R8.x;
LG2 R0.y, R8.y;
LG2 R0.z, R8.z;
ADD R0.xyz, -R0, R1;
MOV result.color.w, c[3].x;
TEX R4.xyz, R3.zxzw, texture[0], 2D;
TEX R2.xyz, R3, texture[0], 2D;
TEX R3.xyz, R3.zyzw, texture[0], 2D;
TEX R7.xyz, R6.zxzw, texture[0], 2D;
TEX R5.xyz, R6, texture[0], 2D;
TEX R6.xyz, R6.zyzw, texture[0], 2D;
MUL R3.xyz, fragment.texcoord[1].x, R3;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
MUL R6.xyz, fragment.texcoord[1].x, R6;
MAD R5.xyz, fragment.texcoord[1].z, R5, R6;
MAD R3.xyz, fragment.texcoord[1].y, R7, R5;
MAD R2.xyz, R4, fragment.texcoord[1].y, R2;
MUL R3.xyz, fragment.texcoord[2].y, R3;
MAD R2.xyz, R2, R2.w, R3;
MAD R2.xyz, fragment.texcoord[3], R2, -fragment.texcoord[3];
MAD R1.xyz, R2, c[1].x, fragment.texcoord[3];
MUL result.color.xyz, R1, R0;
END
# 37 instructions, 9 R-regs
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
					Float 2[_multiFactor]
					Float 3[_PlanetOpacity]
					Vector 4[unity_LightmapFade]
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_LightBuffer] 2D 1
					SetTexture 2[unity_Lightmap] 2D 2
					SetTexture 3[unity_LightmapInd] 2D 3 "ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c5, 1.00000000, 8.00000000, 0, 0
dcl t0.xyz
dcl t1.xyz
dcl t2.xy
dcl t3.xyz
dcl t4
dcl t5.xy
dcl t6
texldp r1, t4, s1
texld r2, t5, s2
mul r7.xyz, t0, c2.x
mul r4.xyz, t0, c0.x
mov r6.xy, r7.zxyw
mov r3.xy, r4.zxyw
mov r0.y, r7
mov r0.x, r7.z
mov r8.xy, r0
mov r0.y, r4
mov r0.x, r4.z
mov r5.xy, r0
log_pp r1.x, r1.x
log_pp r1.y, r1.y
log_pp r1.z, r1.z
mul_pp r2.xyz, r2.w, r2
texld r0, t5, s3
texld r3, r3, s0
texld r4, r4, s0
texld r6, r6, s0
texld r5, r5, s0
texld r8, r8, s0
texld r7, r7, s0
mul r5.xyz, t1.x, r5
mad r4.xyz, t1.z, r4, r5
mad r4.xyz, r3, t1.y, r4
mul r8.xyz, t1.x, r8
mad r7.xyz, t1.z, r7, r8
mad r6.xyz, t1.y, r6, r7
mul r5.xyz, t2.y, r6
add r3.x, -t2.y, c5
mad r3.xyz, r4, r3.x, r5
mul_pp r4.xyz, r0.w, r0
mul_pp r4.xyz, r4, c5.y
dp4 r0.x, t6, t6
rsq r0.x, r0.x
rcp r0.x, r0.x
mad r3.xyz, t3, r3, -t3
mad_pp r2.xyz, r2, c5.y, -r4
mad_sat r0.x, r0, c4.z, c4.w
mad_pp r0.xyz, r0.x, r2, r4
add_pp r0.xyz, -r1, r0
mad r1.xyz, r3, c1.x, t3
mul_pp r0.xyz, r1, r0
mov_pp r0.w, c3.x
mov_pp oC0, r0
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_OFF"
					}
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_LightBuffer] 2D 1
					SetTexture 2[unity_Lightmap] 2D 2
					SetTexture 3[unity_LightmapInd] 2D 3
					ConstBuffer "$Globals"
					208
					Float 64[_texTiling]
					Float 68[_texPower]
					Float 80[_multiFactor]
					Float 132[_PlanetOpacity]
					Vector 176[unity_LightmapFade]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedcdbfknilhjbgpeighlkbmejlphcdiengabaaaaaamaagaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadacaaaaneaaaaaa
afaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaaneaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apalaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefchaafaaaaeaaaaaaafmabaaaafjaaaaaeegiocaaa
aaaaaaaaamaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadhcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadccbabaaaadaaaaaagcbaaaad
mcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadlcbabaaaafaaaaaa
gcbaaaadpcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
diaaaaaihcaabaaaaaaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaafaaaaaa
efaaaaajpcaabaaaabaaaaaaggakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaaacaaaaaa
efaaaaajpcaabaaaacaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaaaaaaaaacgakbaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaakgbkbaaa
acaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
fgbfbaaaacaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaafgbfbaaaadaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaabaaaaaa
agiacaaaaaaaaaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaacgakbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaadaaaaaakgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaa
abaaaaaaegacbaaaabaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaai
icaabaaaaaaaaaaabkbabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadpdcaaaaaj
hcaabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaia
ebaaaaaaaeaaaaaadcaaaaakhcaabaaaaaaaaaaafgifcaaaaaaaaaaaaeaaaaaa
egacbaaaaaaaaaaaegbcbaaaaeaaaaaabbaaaaahicaabaaaaaaaaaaaegbobaaa
agaaaaaaegbobaaaagaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
dccaaaalicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaaalaaaaaa
dkiacaaaaaaaaaaaalaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaa
eghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaadaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaacaaaaaa
abeaaaaaaaaaaaebdcaaaaakhcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaa
acaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaaoaaaaahdcaabaaaacaaaaaa
egbabaaaafaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaa
acaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaacpaaaaafhcaabaaaacaaaaaa
egacbaaaacaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaia
ebaaaaaaacaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaagiccabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaadoaaaaab
"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_OFF"
					}
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_LightBuffer] 2D 1
					SetTexture 2[unity_Lightmap] 2D 2
					SetTexture 3[unity_LightmapInd] 2D 3
					ConstBuffer "$Globals"
					208
					Float 64[_texTiling]
					Float 68[_texPower]
					Float 80[_multiFactor]
					Float 132[_PlanetOpacity]
					Vector 176[unity_LightmapFade]
					BindCB "$Globals"
					0 "ps_4_0_level_9_1
eefiecedlhaohjcefijajfbjlafciomhlligofimabaaaaaahiakaaaaaeaaaaaa
daaaaaaaoeadaaaafmajaaaaeeakaaaaebgpgodjkmadaaaakmadaaaaaaacpppp
feadaaaafiaaaaaaadaadeaaaaaafiaaaaaafiaaaeaaceaaaaaafiaaaaaaaaaa
abababaaacacacaaadadadaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaiaaabaaacaa
aaaaaaaaaaaaalaaabaaadaaaaaaaaaaaaacppppfbaaaaafaeaaapkaaaaaaaeb
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaahlabpaaaaacaaaaaaia
abaaahlabpaaaaacaaaaaaiaacaaaplabpaaaaacaaaaaaiaadaaahlabpaaaaac
aaaaaaiaaeaaaplabpaaaaacaaaaaaiaafaaaplabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaaja
adaiapkaafaaaaadaaaaahiaaaaaoelaaaaaaakaabaaaaacabaaabiaaaaakkia
abaaaaacabaaaciaaaaaffiaabaaaaacacaaadiaaaaanciaafaaaaadadaaahia
aaaaoelaabaaaakaabaaaaacaeaaabiaadaakkiaabaaaaacaeaaaciaadaaffia
abaaaaacafaaadiaadaanciaabaaaaacagaaadiaacaabllaagaaaaacaaaaaeia
aeaapplaafaaaaadahaaadiaaaaakkiaaeaaoelaecaaaaadabaaapiaabaaoeia
aaaioekaecaaaaadaaaaapiaaaaaoeiaaaaioekaecaaaaadacaaapiaacaaoeia
aaaioekaecaaaaadaeaaapiaaeaaoeiaaaaioekaecaaaaadadaaapiaadaaoeia
aaaioekaecaaaaadafaaapiaafaaoeiaaaaioekaecaaaaadaiaacpiaagaaoeia
adaioekaecaaaaadagaacpiaagaaoeiaacaioekaecaaaaadahaacpiaahaaoeia
abaioekaafaaaaadabaaahiaabaaoeiaabaaaalaaeaaaaaeaaaaahiaaaaaoeia
abaakklaabaaoeiaaeaaaaaeaaaaahiaacaaoeiaabaafflaaaaaoeiaafaaaaad
abaaahiaaeaaoeiaabaaaalaaeaaaaaeabaaahiaadaaoeiaabaakklaabaaoeia
aeaaaaaeabaaahiaafaaoeiaabaafflaabaaoeiabcaaaaaeacaaahiaacaaffla
abaaoeiaaaaaoeiaaeaaaaaeaaaaahiaadaaoelaacaaoeiaadaaoelbaeaaaaae
aaaachiaaaaaffkaaaaaoeiaadaaoelaajaaaaadaaaaaiiaafaaoelaafaaoela
ahaaaaacaaaaaiiaaaaappiaagaaaaacaaaaaiiaaaaappiaaeaaaaaeaaaadiia
aaaappiaadaakkkaadaappkaafaaaaadahaaciiaaiaappiaaeaaaakaafaaaaad
abaachiaaiaaoeiaahaappiaafaaaaadabaaciiaagaappiaaeaaaakaaeaaaaae
acaachiaabaappiaagaaoeiaabaaoeibaeaaaaaeabaachiaaaaappiaacaaoeia
abaaoeiaapaaaaacacaacbiaahaaaaiaapaaaaacacaacciaahaaffiaapaaaaac
acaaceiaahaakkiaacaaaaadabaachiaabaaoeiaacaaoeibafaaaaadaaaachia
aaaaoeiaabaaoeiaabaaaaacaaaaciiaacaaffkaabaaaaacaaaicpiaaaaaoeia
ppppaaaafdeieefchaafaaaaeaaaaaaafmabaaaafjaaaaaeegiocaaaaaaaaaaa
amaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadccbabaaaadaaaaaagcbaaaadmcbabaaa
adaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadlcbabaaaafaaaaaagcbaaaad
pcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaadiaaaaai
hcaabaaaaaaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaafaaaaaaefaaaaaj
pcaabaaaabaaaaaaggakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaaaaaaaaacgakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaakgbkbaaaacaaaaaa
egacbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaafgbfbaaa
acaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
fgbfbaaaadaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaabaaaaaaagiacaaa
aaaaaaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
agbabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaacgakbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaa
adaaaaaakgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaa
egacbaaaabaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaaiicaabaaa
aaaaaaaabkbabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadpdcaaaaajhcaabaaa
aaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaiaebaaaaaa
aeaaaaaadcaaaaakhcaabaaaaaaaaaaafgifcaaaaaaaaaaaaeaaaaaaegacbaaa
aaaaaaaaegbcbaaaaeaaaaaabbaaaaahicaabaaaaaaaaaaaegbobaaaagaaaaaa
egbobaaaagaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadccaaaal
icaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaaalaaaaaadkiacaaa
aaaaaaaaalaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaa
adaaaaaaaagabaaaadaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaadaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaaaebdcaaaaakhcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaa
egacbaiaebaaaaaaabaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaabaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaa
afaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaacpaaaaafhcaabaaaacaaaaaaegacbaaa
acaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaa
acaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaagiccabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaadoaaaaabejfdeheo
oaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahahaaaaneaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaneaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadacaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amamaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapalaaaaneaaaaaaagaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
				}
				SubProgram "opengl " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
						"HDR_LIGHT_PREPASS_OFF"
					}
					Float 0[_texTiling]
					Float 1[_texPower]
					Float 2[_multiFactor]
					Float 3[_PlanetOpacity]
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_LightBuffer] 2D 1
					SetTexture 2[unity_Lightmap] 2D 2 "!!ARBfp1.0
PARAM c[5] = { program.local[0..3],
		{ 1, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEX R0, fragment.texcoord[5], texture[2], 2D;
TXP R7.xyz, fragment.texcoord[4], texture[1], 2D;
MUL R5.xyz, fragment.texcoord[0], c[2].x;
MUL R2.xyz, fragment.texcoord[0], c[0].x;
ADD R1.w, -fragment.texcoord[2].y, c[4].x;
MOV result.color.w, c[3].x;
TEX R3.xyz, R2.zxzw, texture[0], 2D;
TEX R1.xyz, R2, texture[0], 2D;
TEX R2.xyz, R2.zyzw, texture[0], 2D;
TEX R6.xyz, R5.zxzw, texture[0], 2D;
TEX R4.xyz, R5, texture[0], 2D;
TEX R5.xyz, R5.zyzw, texture[0], 2D;
MUL R2.xyz, fragment.texcoord[1].x, R2;
MAD R1.xyz, fragment.texcoord[1].z, R1, R2;
MUL R5.xyz, fragment.texcoord[1].x, R5;
MAD R4.xyz, fragment.texcoord[1].z, R4, R5;
MAD R2.xyz, fragment.texcoord[1].y, R6, R4;
MUL R2.xyz, fragment.texcoord[2].y, R2;
MAD R1.xyz, R3, fragment.texcoord[1].y, R1;
MAD R1.xyz, R1, R1.w, R2;
MUL R2.xyz, R0.w, R0;
LG2 R0.x, R7.x;
LG2 R0.z, R7.z;
LG2 R0.y, R7.y;
MAD R2.xyz, R2, c[4].y, -R0;
MAD R1.xyz, fragment.texcoord[3], R1, -fragment.texcoord[3];
MAD R0.xyz, R1, c[1].x, fragment.texcoord[3];
MUL result.color.xyz, R0, R2;
END
# 28 instructions, 8 R-regs
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
					Float 2[_multiFactor]
					Float 3[_PlanetOpacity]
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_LightBuffer] 2D 1
					SetTexture 2[unity_Lightmap] 2D 2 "ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c4, 1.00000000, 8.00000000, 0, 0
dcl t0.xyz
dcl t1.xyz
dcl t2.xy
dcl t3.xyz
dcl t4
dcl t5.xy
texldp r1, t4, s1
mul r6.xyz, t0, c2.x
mul r3.xyz, t0, c0.x
mov r5.xy, r6.zxyw
mov r2.xy, r3.zxyw
mov r0.y, r6
mov r0.x, r6.z
mov r7.xy, r0
mov r0.y, r3
mov r0.x, r3.z
mov r4.xy, r0
log_pp r1.x, r1.x
log_pp r1.z, r1.z
log_pp r1.y, r1.y
texld r0, t5, s2
texld r2, r2, s0
texld r3, r3, s0
texld r5, r5, s0
texld r4, r4, s0
texld r7, r7, s0
texld r6, r6, s0
mul_pp r0.xyz, r0.w, r0
mad_pp r0.xyz, r0, c4.y, -r1
mul r4.xyz, t1.x, r4
mad r3.xyz, t1.z, r3, r4
mad r2.xyz, r2, t1.y, r3
mul r7.xyz, t1.x, r7
mad r6.xyz, t1.z, r6, r7
mad r5.xyz, t1.y, r5, r6
mul r3.xyz, t2.y, r5
add r4.x, -t2.y, c4
mad r2.xyz, r2, r4.x, r3
mad r2.xyz, t3, r2, -t3
mad r1.xyz, r2, c1.x, t3
mul_pp r0.xyz, r1, r0
mov_pp r0.w, c3.x
mov_pp oC0, r0
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
						"HDR_LIGHT_PREPASS_OFF"
					}
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_LightBuffer] 2D 1
					SetTexture 2[unity_Lightmap] 2D 2
					ConstBuffer "$Globals"
					208
					Float 64[_texTiling]
					Float 68[_texPower]
					Float 80[_multiFactor]
					Float 132[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedclbhndemgohnenlolllcnmbhmndnomliabaaaaaaieafaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadacaaaalmaaaaaa
afaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcemaeaaaaeaaaaaaabdabaaaa
fjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
ccbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gcbaaaadlcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
diaaaaaihcaabaaaaaaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaafaaaaaa
efaaaaajpcaabaaaabaaaaaaggakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaaacaaaaaa
efaaaaajpcaabaaaacaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaaaaaaaaacgakbaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaakgbkbaaa
acaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
fgbfbaaaacaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaafgbfbaaaadaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaabaaaaaa
agiacaaaaaaaaaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaacgakbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaadaaaaaakgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaa
abaaaaaaegacbaaaabaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaai
icaabaaaaaaaaaaabkbabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadpdcaaaaaj
hcaabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaia
ebaaaaaaaeaaaaaadcaaaaakhcaabaaaaaaaaaaafgifcaaaaaaaaaaaaeaaaaaa
egacbaaaaaaaaaaaegbcbaaaaeaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaa
afaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaacpaaaaafhcaabaaaabaaaaaaegacbaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaadaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaaaebdcaaaaakhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaa
egacbaiaebaaaaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaagiccabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaa
doaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
						"HDR_LIGHT_PREPASS_OFF"
					}
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_LightBuffer] 2D 1
					SetTexture 2[unity_Lightmap] 2D 2
					ConstBuffer "$Globals"
					208
					Float 64[_texTiling]
					Float 68[_texPower]
					Float 80[_multiFactor]
					Float 132[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0_level_9_1
eefieceddahdbnbmgldikehbdldkeeonaeldceehabaaaaaaieaiaaaaaeaaaaaa
daaaaaaacmadaaaaiaahaaaafaaiaaaaebgpgodjpeacaaaapeacaaaaaaacpppp
kmacaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaaaaaaaaa
abababaaacacacaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaiaaabaaacaaaaaaaaaa
aaacppppfbaaaaafadaaapkaaaaaaaebaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaahlabpaaaaacaaaaaaiaabaaahlabpaaaaacaaaaaaiaacaaapla
bpaaaaacaaaaaaiaadaaahlabpaaaaacaaaaaaiaaeaaaplabpaaaaacaaaaaaja
aaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaafaaaaad
aaaaahiaaaaaoelaaaaaaakaabaaaaacabaaabiaaaaakkiaabaaaaacabaaacia
aaaaffiaabaaaaacacaaadiaaaaanciaafaaaaadadaaahiaaaaaoelaabaaaaka
abaaaaacaeaaabiaadaakkiaabaaaaacaeaaaciaadaaffiaabaaaaacafaaadia
adaanciaabaaaaacagaaadiaacaabllaagaaaaacaaaaaeiaaeaapplaafaaaaad
ahaaadiaaaaakkiaaeaaoelaecaaaaadabaaapiaabaaoeiaaaaioekaecaaaaad
aaaaapiaaaaaoeiaaaaioekaecaaaaadacaaapiaacaaoeiaaaaioekaecaaaaad
aeaaapiaaeaaoeiaaaaioekaecaaaaadadaaapiaadaaoeiaaaaioekaecaaaaad
afaaapiaafaaoeiaaaaioekaecaaaaadagaacpiaagaaoeiaacaioekaecaaaaad
ahaacpiaahaaoeiaabaioekaafaaaaadabaaahiaabaaoeiaabaaaalaaeaaaaae
aaaaahiaaaaaoeiaabaakklaabaaoeiaaeaaaaaeaaaaahiaacaaoeiaabaaffla
aaaaoeiaafaaaaadabaaahiaaeaaoeiaabaaaalaaeaaaaaeabaaahiaadaaoeia
abaakklaabaaoeiaaeaaaaaeabaaahiaafaaoeiaabaafflaabaaoeiabcaaaaae
acaaahiaacaafflaabaaoeiaaaaaoeiaaeaaaaaeaaaaahiaadaaoelaacaaoeia
adaaoelbaeaaaaaeaaaachiaaaaaffkaaaaaoeiaadaaoelaafaaaaadaaaaciia
agaappiaadaaaakaapaaaaacabaacbiaahaaaaiaapaaaaacabaacciaahaaffia
apaaaaacabaaceiaahaakkiaaeaaaaaeabaachiaaaaappiaagaaoeiaabaaoeib
afaaaaadaaaachiaaaaaoeiaabaaoeiaabaaaaacaaaaciiaacaaffkaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefcemaeaaaaeaaaaaaabdabaaaafjaaaaae
egiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadccbabaaa
adaaaaaagcbaaaadmcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaad
lcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaadiaaaaai
hcaabaaaaaaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaafaaaaaaefaaaaaj
pcaabaaaabaaaaaaggakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaaaaaaaaacgakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaakgbkbaaaacaaaaaa
egacbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaafgbfbaaa
acaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
fgbfbaaaadaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaabaaaaaaagiacaaa
aaaaaaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
agbabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaacgakbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaa
adaaaaaakgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaa
egacbaaaabaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaaiicaabaaa
aaaaaaaabkbabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadpdcaaaaajhcaabaaa
aaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaiaebaaaaaa
aeaaaaaadcaaaaakhcaabaaaaaaaaaaafgifcaaaaaaaaaaaaeaaaaaaegacbaaa
aaaaaaaaegbcbaaaaeaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaafaaaaaa
pgbpbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaacpaaaaafhcaabaaaabaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaogbkbaaaadaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaeb
dcaaaaakhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaaegacbaia
ebaaaaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaagiccabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaadoaaaaab
ejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahahaaaa
lmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalmaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadacaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaa
adaaaaaaamamaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaa
lmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapalaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
				}
				SubProgram "opengl " {
					Keywords {
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_ON"
					}
					Float 0[_texTiling]
					Float 1[_texPower]
					Float 2[_multiFactor]
					Float 3[_PlanetOpacity]
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_LightBuffer] 2D 1 "!!ARBfp1.0
PARAM c[5] = { program.local[0..3],
		{ 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TXP R6.xyz, fragment.texcoord[4], texture[1], 2D;
MUL R4.xyz, fragment.texcoord[0], c[2].x;
MUL R1.xyz, fragment.texcoord[0], c[0].x;
ADD R0.w, -fragment.texcoord[2].y, c[4].x;
MOV result.color.w, c[3].x;
TEX R2.xyz, R1.zxzw, texture[0], 2D;
TEX R0.xyz, R1, texture[0], 2D;
TEX R1.xyz, R1.zyzw, texture[0], 2D;
TEX R5.xyz, R4.zxzw, texture[0], 2D;
TEX R3.xyz, R4, texture[0], 2D;
TEX R4.xyz, R4.zyzw, texture[0], 2D;
MUL R1.xyz, fragment.texcoord[1].x, R1;
MAD R0.xyz, fragment.texcoord[1].z, R0, R1;
MUL R4.xyz, fragment.texcoord[1].x, R4;
MAD R3.xyz, fragment.texcoord[1].z, R3, R4;
MAD R1.xyz, fragment.texcoord[1].y, R5, R3;
MUL R1.xyz, fragment.texcoord[2].y, R1;
MAD R0.xyz, R2, fragment.texcoord[1].y, R0;
MAD R0.xyz, R0, R0.w, R1;
MAD R1.xyz, fragment.texcoord[3], R0, -fragment.texcoord[3];
ADD R0.xyz, R6, fragment.texcoord[5];
MAD R1.xyz, R1, c[1].x, fragment.texcoord[3];
MUL result.color.xyz, R1, R0;
END
# 23 instructions, 7 R-regs
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
					Float 2[_multiFactor]
					Float 3[_PlanetOpacity]
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_LightBuffer] 2D 1 "ps_2_0
dcl_2d s0
dcl_2d s1
def c4, 1.00000000, 0, 0, 0
dcl t0.xyz
dcl t1.xyz
dcl t2.xy
dcl t3.xyz
dcl t4
dcl t5.xyz
mul r5.xyz, t0, c2.x
mul r2.xyz, t0, c0.x
mov r4.xy, r5.zxyw
mov r1.xy, r2.zxyw
mov r0.y, r5
mov r0.x, r5.z
mov r6.xy, r0
mov r0.y, r2
mov r0.x, r2.z
mov r3.xy, r0
texldp r0, t4, s1
texld r1, r1, s0
texld r2, r2, s0
texld r4, r4, s0
texld r3, r3, s0
texld r6, r6, s0
texld r5, r5, s0
mul r3.xyz, t1.x, r3
mad r2.xyz, t1.z, r2, r3
mad r1.xyz, r1, t1.y, r2
mul r6.xyz, t1.x, r6
mad r5.xyz, t1.z, r5, r6
mad r4.xyz, t1.y, r4, r5
mul r2.xyz, t2.y, r4
add r3.x, -t2.y, c4
mad r1.xyz, r1, r3.x, r2
mad r1.xyz, t3, r1, -t3
add_pp r0.xyz, r0, t5
mad r1.xyz, r1, c1.x, t3
mul_pp r0.xyz, r1, r0
mov_pp r0.w, c3.x
mov_pp oC0, r0
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_ON"
					}
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_LightBuffer] 2D 1
					ConstBuffer "$Globals"
					176
					Float 64[_texTiling]
					Float 68[_texPower]
					Float 80[_multiFactor]
					Float 132[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedgogifkppacladlmlklcgjnkkdjlhlolnabaaaaaaaiafaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadacaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnaadaaaaeaaaaaaapeaaaaaa
fjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadccbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadlcbabaaa
afaaaaaagcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaa
afaaaaaaefaaaaajpcaabaaaabaaaaaaggakbaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaa
acaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaacgakbaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaa
kgbkbaaaacaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
aaaaaaaafgbfbaaaacaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaafgbfbaaaadaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaa
abaaaaaaagiacaaaaaaaaaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
cgakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaa
acaaaaaaegacbaaaadaaaaaakgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaaj
hcaabaaaabaaaaaaegacbaaaabaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaa
aaaaaaaiicaabaaaaaaaaaaabkbabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadp
dcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaa
egbcbaiaebaaaaaaaeaaaaaadcaaaaakhcaabaaaaaaaaaaafgifcaaaaaaaaaaa
aeaaaaaaegacbaaaaaaaaaaaegbcbaaaaeaaaaaaaoaaaaahdcaabaaaabaaaaaa
egbabaaaafaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegbcbaaaagaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaagiccabaaaaaaaaaaabkiacaaaaaaaaaaa
aiaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"LIGHTMAP_OFF"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_ON"
					}
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_LightBuffer] 2D 1
					ConstBuffer "$Globals"
					176
					Float 64[_texTiling]
					Float 68[_texPower]
					Float 80[_multiFactor]
					Float 132[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0_level_9_1
eefiecedlichclbeeijmkjfbichcamflmnfnjgooabaaaaaajiahaaaaaeaaaaaa
daaaaaaalmacaaaajeagaaaageahaaaaebgpgodjieacaaaaieacaaaaaaacpppp
eaacaaaaeeaaaaaaacaacmaaaaaaeeaaaaaaeeaaacaaceaaaaaaeeaaaaaaaaaa
abababaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaiaaabaaacaaaaaaaaaaaaacpppp
bpaaaaacaaaaaaiaaaaaahlabpaaaaacaaaaaaiaabaaahlabpaaaaacaaaaaaia
acaaadlabpaaaaacaaaaaaiaadaaahlabpaaaaacaaaaaaiaaeaaaplabpaaaaac
aaaaaaiaafaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
afaaaaadaaaaahiaaaaaoelaaaaaaakaabaaaaacabaaabiaaaaakkiaabaaaaac
abaaaciaaaaaffiaabaaaaacacaaadiaaaaanciaafaaaaadadaaahiaaaaaoela
abaaaakaabaaaaacaeaaabiaadaakkiaabaaaaacaeaaaciaadaaffiaabaaaaac
afaaadiaadaanciaagaaaaacaaaaaeiaaeaapplaafaaaaadagaaadiaaaaakkia
aeaaoelaecaaaaadabaaapiaabaaoeiaaaaioekaecaaaaadaaaaapiaaaaaoeia
aaaioekaecaaaaadacaaapiaacaaoeiaaaaioekaecaaaaadaeaaapiaaeaaoeia
aaaioekaecaaaaadadaaapiaadaaoeiaaaaioekaecaaaaadafaaapiaafaaoeia
aaaioekaecaaaaadagaacpiaagaaoeiaabaioekaafaaaaadabaaahiaabaaoeia
abaaaalaaeaaaaaeaaaaahiaaaaaoeiaabaakklaabaaoeiaaeaaaaaeaaaaahia
acaaoeiaabaafflaaaaaoeiaafaaaaadabaaahiaaeaaoeiaabaaaalaaeaaaaae
abaaahiaadaaoeiaabaakklaabaaoeiaaeaaaaaeabaaahiaafaaoeiaabaaffla
abaaoeiabcaaaaaeacaaahiaacaafflaabaaoeiaaaaaoeiaaeaaaaaeaaaaahia
adaaoelaacaaoeiaadaaoelbaeaaaaaeaaaachiaaaaaffkaaaaaoeiaadaaoela
acaaaaadabaachiaagaaoeiaafaaoelaafaaaaadaaaachiaaaaaoeiaabaaoeia
abaaaaacaaaaciiaacaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
naadaaaaeaaaaaaapeaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadccbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagcbaaaadlcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaa
abaaaaaaagiacaaaaaaaaaaaafaaaaaaefaaaaajpcaabaaaabaaaaaaggakbaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaa
cgakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaa
abaaaaaaegacbaaaacaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaafgbfbaaaacaaaaaaegacbaaaabaaaaaa
diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaafgbfbaaaadaaaaaadiaaaaai
hcaabaaaabaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaaeaaaaaaefaaaaaj
pcaabaaaacaaaaaaggakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaagbabaaaacaaaaaaefaaaaaj
pcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaacgakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaadaaaaaakgbkbaaaacaaaaaa
egacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaabaaaaaafgbfbaaa
acaaaaaaegacbaaaacaaaaaaaaaaaaaiicaabaaaaaaaaaaabkbabaiaebaaaaaa
adaaaaaaabeaaaaaaaaaiadpdcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegbcbaaa
aeaaaaaaegacbaaaaaaaaaaaegbcbaiaebaaaaaaaeaaaaaadcaaaaakhcaabaaa
aaaaaaaafgifcaaaaaaaaaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaaaaeaaaaaa
aoaaaaahdcaabaaaabaaaaaaegbabaaaafaaaaaapgbpbaaaafaaaaaaefaaaaaj
pcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
aaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegbcbaaaagaaaaaadiaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaagiccabaaa
aaaaaaaabkiacaaaaaaaaaaaaiaaaaaadoaaaaabejfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahahaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adacaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapalaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
				}
				SubProgram "opengl " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_ON"
					}
					Float 0[_texTiling]
					Float 1[_texPower]
					Float 2[_multiFactor]
					Float 3[_PlanetOpacity]
					Vector 4[unity_LightmapFade]
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_LightBuffer] 2D 1
					SetTexture 2[unity_Lightmap] 2D 2
					SetTexture 3[unity_LightmapInd] 2D 3 "!!ARBfp1.0
PARAM c[6] = { program.local[0..4],
		{ 1, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEMP R8;
TEX R0, fragment.texcoord[5], texture[3], 2D;
TEX R1, fragment.texcoord[5], texture[2], 2D;
TXP R8.xyz, fragment.texcoord[4], texture[1], 2D;
MUL R6.xyz, fragment.texcoord[0], c[2].x;
MUL R3.xyz, fragment.texcoord[0], c[0].x;
MUL R1.xyz, R1.w, R1;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, c[5].y;
DP4 R1.w, fragment.texcoord[6], fragment.texcoord[6];
RSQ R0.w, R1.w;
RCP R0.w, R0.w;
MAD R1.xyz, R1, c[5].y, -R0;
MAD_SAT R0.w, R0, c[4].z, c[4];
MAD R0.xyz, R0.w, R1, R0;
ADD R2.w, -fragment.texcoord[2].y, c[5].x;
ADD R0.xyz, R8, R0;
MOV result.color.w, c[3].x;
TEX R4.xyz, R3.zxzw, texture[0], 2D;
TEX R2.xyz, R3, texture[0], 2D;
TEX R3.xyz, R3.zyzw, texture[0], 2D;
TEX R7.xyz, R6.zxzw, texture[0], 2D;
TEX R5.xyz, R6, texture[0], 2D;
TEX R6.xyz, R6.zyzw, texture[0], 2D;
MUL R3.xyz, fragment.texcoord[1].x, R3;
MAD R2.xyz, fragment.texcoord[1].z, R2, R3;
MUL R6.xyz, fragment.texcoord[1].x, R6;
MAD R5.xyz, fragment.texcoord[1].z, R5, R6;
MAD R3.xyz, fragment.texcoord[1].y, R7, R5;
MAD R2.xyz, R4, fragment.texcoord[1].y, R2;
MUL R3.xyz, fragment.texcoord[2].y, R3;
MAD R2.xyz, R2, R2.w, R3;
MAD R1.xyz, fragment.texcoord[3], R2, -fragment.texcoord[3];
MAD R1.xyz, R1, c[1].x, fragment.texcoord[3];
MUL result.color.xyz, R1, R0;
END
# 34 instructions, 9 R-regs
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
					Float 2[_multiFactor]
					Float 3[_PlanetOpacity]
					Vector 4[unity_LightmapFade]
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_LightBuffer] 2D 1
					SetTexture 2[unity_Lightmap] 2D 2
					SetTexture 3[unity_LightmapInd] 2D 3 "ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c5, 1.00000000, 8.00000000, 0, 0
dcl t0.xyz
dcl t1.xyz
dcl t2.xy
dcl t3.xyz
dcl t4
dcl t5.xy
dcl t6
texldp r1, t4, s1
texld r2, t5, s2
mul r7.xyz, t0, c2.x
mul r4.xyz, t0, c0.x
mov r6.xy, r7.zxyw
mov r3.xy, r4.zxyw
mov r0.y, r7
mov r0.x, r7.z
mov r8.xy, r0
mov r0.y, r4
mov r0.x, r4.z
mov r5.xy, r0
texld r0, t5, s3
texld r3, r3, s0
texld r4, r4, s0
texld r6, r6, s0
texld r5, r5, s0
texld r8, r8, s0
texld r7, r7, s0
mul r5.xyz, t1.x, r5
mad r4.xyz, t1.z, r4, r5
mad r4.xyz, r3, t1.y, r4
mul r8.xyz, t1.x, r8
mad r7.xyz, t1.z, r7, r8
mad r6.xyz, t1.y, r6, r7
mul r5.xyz, t2.y, r6
add r3.x, -t2.y, c5
mad r3.xyz, r4, r3.x, r5
mul_pp r5.xyz, r0.w, r0
mul_pp r4.xyz, r2.w, r2
dp4 r2.x, t6, t6
rsq r0.x, r2.x
mul_pp r2.xyz, r5, c5.y
rcp r0.x, r0.x
mad r3.xyz, t3, r3, -t3
mad_pp r4.xyz, r4, c5.y, -r2
mad_sat r0.x, r0, c4.z, c4.w
mad_pp r0.xyz, r0.x, r4, r2
add_pp r0.xyz, r1, r0
mad r1.xyz, r3, c1.x, t3
mul_pp r0.xyz, r1, r0
mov_pp r0.w, c3.x
mov_pp oC0, r0
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_ON"
					}
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_LightBuffer] 2D 1
					SetTexture 2[unity_Lightmap] 2D 2
					SetTexture 3[unity_LightmapInd] 2D 3
					ConstBuffer "$Globals"
					208
					Float 64[_texTiling]
					Float 68[_texPower]
					Float 80[_multiFactor]
					Float 132[_PlanetOpacity]
					Vector 176[unity_LightmapFade]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedmkokbdomnnklldpbncanpicfboffgknpabaaaaaakiagaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadacaaaaneaaaaaa
afaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaaneaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apalaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcfiafaaaaeaaaaaaafgabaaaafjaaaaaeegiocaaa
aaaaaaaaamaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadhcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadccbabaaaadaaaaaagcbaaaad
mcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadlcbabaaaafaaaaaa
gcbaaaadpcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
diaaaaaihcaabaaaaaaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaafaaaaaa
efaaaaajpcaabaaaabaaaaaaggakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaaacaaaaaa
efaaaaajpcaabaaaacaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaaaaaaaaacgakbaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaakgbkbaaa
acaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
fgbfbaaaacaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaafgbfbaaaadaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaabaaaaaa
agiacaaaaaaaaaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaacgakbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaadaaaaaakgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaa
abaaaaaaegacbaaaabaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaai
icaabaaaaaaaaaaabkbabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadpdcaaaaaj
hcaabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaia
ebaaaaaaaeaaaaaadcaaaaakhcaabaaaaaaaaaaafgifcaaaaaaaaaaaaeaaaaaa
egacbaaaaaaaaaaaegbcbaaaaeaaaaaabbaaaaahicaabaaaaaaaaaaaegbobaaa
agaaaaaaegbobaaaagaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
dccaaaalicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaaalaaaaaa
dkiacaaaaaaaaaaaalaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaa
eghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaadaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaacaaaaaa
abeaaaaaaaaaaaebdcaaaaakhcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaa
acaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaaoaaaaahdcaabaaaacaaaaaa
egbabaaaafaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaa
acaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaagiccabaaaaaaaaaaabkiacaaaaaaaaaaa
aiaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_OFF"
						"HDR_LIGHT_PREPASS_ON"
					}
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_LightBuffer] 2D 1
					SetTexture 2[unity_Lightmap] 2D 2
					SetTexture 3[unity_LightmapInd] 2D 3
					ConstBuffer "$Globals"
					208
					Float 64[_texTiling]
					Float 68[_texPower]
					Float 80[_multiFactor]
					Float 132[_PlanetOpacity]
					Vector 176[unity_LightmapFade]
					BindCB "$Globals"
					0 "ps_4_0_level_9_1
eefiecediihaddfamkfbhgbfbmhkkifgbkedgmleabaaaaaadmakaaaaaeaaaaaa
daaaaaaamaadaaaacaajaaaaaiakaaaaebgpgodjiiadaaaaiiadaaaaaaacpppp
daadaaaafiaaaaaaadaadeaaaaaafiaaaaaafiaaaeaaceaaaaaafiaaaaaaaaaa
abababaaacacacaaadadadaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaiaaabaaacaa
aaaaaaaaaaaaalaaabaaadaaaaaaaaaaaaacppppfbaaaaafaeaaapkaaaaaaaeb
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaahlabpaaaaacaaaaaaia
abaaahlabpaaaaacaaaaaaiaacaaaplabpaaaaacaaaaaaiaadaaahlabpaaaaac
aaaaaaiaaeaaaplabpaaaaacaaaaaaiaafaaaplabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaaja
adaiapkaafaaaaadaaaaahiaaaaaoelaaaaaaakaabaaaaacabaaabiaaaaakkia
abaaaaacabaaaciaaaaaffiaabaaaaacacaaadiaaaaanciaafaaaaadadaaahia
aaaaoelaabaaaakaabaaaaacaeaaabiaadaakkiaabaaaaacaeaaaciaadaaffia
abaaaaacafaaadiaadaanciaabaaaaacagaaadiaacaabllaagaaaaacaaaaaeia
aeaapplaafaaaaadahaaadiaaaaakkiaaeaaoelaecaaaaadabaaapiaabaaoeia
aaaioekaecaaaaadaaaaapiaaaaaoeiaaaaioekaecaaaaadacaaapiaacaaoeia
aaaioekaecaaaaadaeaaapiaaeaaoeiaaaaioekaecaaaaadadaaapiaadaaoeia
aaaioekaecaaaaadafaaapiaafaaoeiaaaaioekaecaaaaadaiaacpiaagaaoeia
adaioekaecaaaaadagaacpiaagaaoeiaacaioekaecaaaaadahaacpiaahaaoeia
abaioekaafaaaaadabaaahiaabaaoeiaabaaaalaaeaaaaaeaaaaahiaaaaaoeia
abaakklaabaaoeiaaeaaaaaeaaaaahiaacaaoeiaabaafflaaaaaoeiaafaaaaad
abaaahiaaeaaoeiaabaaaalaaeaaaaaeabaaahiaadaaoeiaabaakklaabaaoeia
aeaaaaaeabaaahiaafaaoeiaabaafflaabaaoeiabcaaaaaeacaaahiaacaaffla
abaaoeiaaaaaoeiaaeaaaaaeaaaaahiaadaaoelaacaaoeiaadaaoelbaeaaaaae
aaaachiaaaaaffkaaaaaoeiaadaaoelaajaaaaadaaaaaiiaafaaoelaafaaoela
ahaaaaacaaaaaiiaaaaappiaagaaaaacaaaaaiiaaaaappiaaeaaaaaeaaaadiia
aaaappiaadaakkkaadaappkaafaaaaadahaaciiaaiaappiaaeaaaakaafaaaaad
abaachiaaiaaoeiaahaappiaafaaaaadabaaciiaagaappiaaeaaaakaaeaaaaae
acaachiaabaappiaagaaoeiaabaaoeibaeaaaaaeabaachiaaaaappiaacaaoeia
abaaoeiaacaaaaadabaachiaabaaoeiaahaaoeiaafaaaaadaaaachiaaaaaoeia
abaaoeiaabaaaaacaaaaciiaacaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefcfiafaaaaeaaaaaaafgabaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadccbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadlcbabaaaafaaaaaagcbaaaadpcbabaaa
agaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaadiaaaaaihcaabaaa
aaaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaafaaaaaaefaaaaajpcaabaaa
abaaaaaaggakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaa
acaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaaaaaaaaacgakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaakgbkbaaaacaaaaaaegacbaaa
abaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaafgbfbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaafgbfbaaa
adaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaa
aeaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaagbabaaa
acaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaacgakbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaadaaaaaa
kgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
abaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaaiicaabaaaaaaaaaaa
bkbabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadpdcaaaaajhcaabaaaaaaaaaaa
egacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaiaebaaaaaaaeaaaaaa
dcaaaaakhcaabaaaaaaaaaaafgifcaaaaaaaaaaaaeaaaaaaegacbaaaaaaaaaaa
egbcbaaaaeaaaaaabbaaaaahicaabaaaaaaaaaaaegbobaaaagaaaaaaegbobaaa
agaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadccaaaalicaabaaa
aaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaaalaaaaaadkiacaaaaaaaaaaa
alaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaaadaaaaaa
aagabaaaadaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
aaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaogbkbaaaadaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaeb
dcaaaaakhcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaaegacbaia
ebaaaaaaabaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaaafaaaaaa
pgbpbaaaafaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaagiccabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaadoaaaaab
ejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahahaaaa
neaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaneaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadacaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaa
adaaaaaaamamaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaa
neaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapalaaaaneaaaaaaagaaaaaa
aaaaaaaaadaaaaaaagaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
				}
				SubProgram "opengl " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
						"HDR_LIGHT_PREPASS_ON"
					}
					Float 0[_texTiling]
					Float 1[_texPower]
					Float 2[_multiFactor]
					Float 3[_PlanetOpacity]
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_LightBuffer] 2D 1
					SetTexture 2[unity_Lightmap] 2D 2 "!!ARBfp1.0
PARAM c[5] = { program.local[0..3],
		{ 1, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEX R0, fragment.texcoord[5], texture[2], 2D;
TXP R7.xyz, fragment.texcoord[4], texture[1], 2D;
MUL R5.xyz, fragment.texcoord[0], c[2].x;
MUL R2.xyz, fragment.texcoord[0], c[0].x;
MUL R0.xyz, R0.w, R0;
ADD R1.w, -fragment.texcoord[2].y, c[4].x;
MOV result.color.w, c[3].x;
TEX R3.xyz, R2.zxzw, texture[0], 2D;
TEX R1.xyz, R2, texture[0], 2D;
TEX R2.xyz, R2.zyzw, texture[0], 2D;
TEX R6.xyz, R5.zxzw, texture[0], 2D;
TEX R4.xyz, R5, texture[0], 2D;
TEX R5.xyz, R5.zyzw, texture[0], 2D;
MUL R2.xyz, fragment.texcoord[1].x, R2;
MAD R1.xyz, fragment.texcoord[1].z, R1, R2;
MUL R5.xyz, fragment.texcoord[1].x, R5;
MAD R4.xyz, fragment.texcoord[1].z, R4, R5;
MAD R2.xyz, fragment.texcoord[1].y, R6, R4;
MUL R2.xyz, fragment.texcoord[2].y, R2;
MAD R1.xyz, R3, fragment.texcoord[1].y, R1;
MAD R1.xyz, R1, R1.w, R2;
MAD R2.xyz, R0, c[4].y, R7;
MAD R1.xyz, fragment.texcoord[3], R1, -fragment.texcoord[3];
MAD R0.xyz, R1, c[1].x, fragment.texcoord[3];
MUL result.color.xyz, R0, R2;
END
# 25 instructions, 8 R-regs
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
					Float 2[_multiFactor]
					Float 3[_PlanetOpacity]
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_LightBuffer] 2D 1
					SetTexture 2[unity_Lightmap] 2D 2 "ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c4, 1.00000000, 8.00000000, 0, 0
dcl t0.xyz
dcl t1.xyz
dcl t2.xy
dcl t3.xyz
dcl t4
dcl t5.xy
texldp r1, t4, s1
mul r6.xyz, t0, c2.x
mul r3.xyz, t0, c0.x
mov r5.xy, r6.zxyw
mov r2.xy, r3.zxyw
mov r0.y, r6
mov r0.x, r6.z
mov r7.xy, r0
mov r0.y, r3
mov r0.x, r3.z
mov r4.xy, r0
texld r0, t5, s2
texld r2, r2, s0
texld r3, r3, s0
texld r5, r5, s0
texld r4, r4, s0
texld r7, r7, s0
texld r6, r6, s0
mul_pp r0.xyz, r0.w, r0
mad_pp r0.xyz, r0, c4.y, r1
mul r4.xyz, t1.x, r4
mad r3.xyz, t1.z, r3, r4
mad r2.xyz, r2, t1.y, r3
mul r7.xyz, t1.x, r7
mad r6.xyz, t1.z, r6, r7
mad r5.xyz, t1.y, r5, r6
mul r3.xyz, t2.y, r5
add r4.x, -t2.y, c4
mad r2.xyz, r2, r4.x, r3
mad r2.xyz, t3, r2, -t3
mad r1.xyz, r2, c1.x, t3
mul_pp r0.xyz, r1, r0
mov_pp r0.w, c3.x
mov_pp oC0, r0
"
				}
				SubProgram "d3d11 " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
						"HDR_LIGHT_PREPASS_ON"
					}
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_LightBuffer] 2D 1
					SetTexture 2[unity_Lightmap] 2D 2
					ConstBuffer "$Globals"
					208
					Float 64[_texTiling]
					Float 68[_texPower]
					Float 80[_multiFactor]
					Float 132[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0
eefiecedmphmdlnldbndelkaikmgfmnabpkeghcpabaaaaaagmafaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadacaaaalmaaaaaa
afaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdeaeaaaaeaaaaaaaanabaaaa
fjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
ccbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gcbaaaadlcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
diaaaaaihcaabaaaaaaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaafaaaaaa
efaaaaajpcaabaaaabaaaaaaggakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaaacaaaaaa
efaaaaajpcaabaaaacaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaaaaaaaaacgakbaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaakgbkbaaa
acaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
fgbfbaaaacaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaafgbfbaaaadaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaabaaaaaa
agiacaaaaaaaaaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaacgakbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaadaaaaaakgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaa
abaaaaaaegacbaaaabaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaai
icaabaaaaaaaaaaabkbabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadpdcaaaaaj
hcaabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaia
ebaaaaaaaeaaaaaadcaaaaakhcaabaaaaaaaaaaafgifcaaaaaaaaaaaaeaaaaaa
egacbaaaaaaaaaaaegbcbaaaaeaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaa
afaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaa
adaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaaaebdcaaaaajhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaagiccabaaaaaaaaaaabkiacaaa
aaaaaaaaaiaaaaaadoaaaaab"
				}
				SubProgram "d3d11_9x " {
					Keywords {
						"LIGHTMAP_ON"
						"DIRLIGHTMAP_ON"
						"HDR_LIGHT_PREPASS_ON"
					}
					SetTexture 0[_mainTex] 2D 0
					SetTexture 1[_LightBuffer] 2D 1
					SetTexture 2[unity_Lightmap] 2D 2
					ConstBuffer "$Globals"
					208
					Float 64[_texTiling]
					Float 68[_texPower]
					Float 80[_multiFactor]
					Float 132[_PlanetOpacity]
					BindCB "$Globals"
					0 "ps_4_0_level_9_1
eefiecedenbdmlbncedalfihoejiekmlcldmiabeabaaaaaaeiaiaaaaaeaaaaaa
daaaaaaaaiadaaaaeeahaaaabeaiaaaaebgpgodjnaacaaaanaacaaaaaaacpppp
iiacaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaaaaaaaaa
abababaaacacacaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaiaaabaaacaaaaaaaaaa
aaacppppfbaaaaafadaaapkaaaaaaaebaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaahlabpaaaaacaaaaaaiaabaaahlabpaaaaacaaaaaaiaacaaapla
bpaaaaacaaaaaaiaadaaahlabpaaaaacaaaaaaiaaeaaaplabpaaaaacaaaaaaja
aaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaafaaaaad
aaaaahiaaaaaoelaaaaaaakaabaaaaacabaaabiaaaaakkiaabaaaaacabaaacia
aaaaffiaabaaaaacacaaadiaaaaanciaafaaaaadadaaahiaaaaaoelaabaaaaka
abaaaaacaeaaabiaadaakkiaabaaaaacaeaaaciaadaaffiaabaaaaacafaaadia
adaanciaagaaaaacaaaaaeiaaeaapplaafaaaaadagaaadiaaaaakkiaaeaaoela
abaaaaacahaaadiaacaabllaecaaaaadabaaapiaabaaoeiaaaaioekaecaaaaad
aaaaapiaaaaaoeiaaaaioekaecaaaaadacaaapiaacaaoeiaaaaioekaecaaaaad
aeaaapiaaeaaoeiaaaaioekaecaaaaadadaaapiaadaaoeiaaaaioekaecaaaaad
afaaapiaafaaoeiaaaaioekaecaaaaadagaacpiaagaaoeiaabaioekaecaaaaad
ahaacpiaahaaoeiaacaioekaafaaaaadabaaahiaabaaoeiaabaaaalaaeaaaaae
aaaaahiaaaaaoeiaabaakklaabaaoeiaaeaaaaaeaaaaahiaacaaoeiaabaaffla
aaaaoeiaafaaaaadabaaahiaaeaaoeiaabaaaalaaeaaaaaeabaaahiaadaaoeia
abaakklaabaaoeiaaeaaaaaeabaaahiaafaaoeiaabaafflaabaaoeiabcaaaaae
acaaahiaacaafflaabaaoeiaaaaaoeiaaeaaaaaeaaaaahiaadaaoelaacaaoeia
adaaoelbaeaaaaaeaaaachiaaaaaffkaaaaaoeiaadaaoelaafaaaaadaaaaciia
ahaappiaadaaaakaaeaaaaaeabaachiaaaaappiaahaaoeiaagaaoeiaafaaaaad
aaaachiaaaaaoeiaabaaoeiaabaaaaacaaaaciiaacaaffkaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefcdeaeaaaaeaaaaaaaanabaaaafjaaaaaeegiocaaa
aaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
hcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadccbabaaaadaaaaaa
gcbaaaadmcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadlcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaadiaaaaaihcaabaaa
aaaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaaafaaaaaaefaaaaajpcaabaaa
abaaaaaaggakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaagbabaaaacaaaaaaefaaaaajpcaabaaa
acaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaaaaaaaaacgakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaakgbkbaaaacaaaaaaegacbaaa
abaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaafgbfbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaafgbfbaaa
adaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaabaaaaaaagiacaaaaaaaaaaa
aeaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaagbabaaa
acaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaacgakbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaadaaaaaa
kgbkbaaaacaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
abaaaaaafgbfbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaaiicaabaaaaaaaaaaa
bkbabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadpdcaaaaajhcaabaaaaaaaaaaa
egacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaaegbcbaiaebaaaaaaaeaaaaaa
dcaaaaakhcaabaaaaaaaaaaafgifcaaaaaaaaaaaaeaaaaaaegacbaaaaaaaaaaa
egbcbaaaaeaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaafaaaaaapgbpbaaa
afaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaadaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaacaaaaaa
abeaaaaaaaaaaaebdcaaaaajhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaagiccabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaa
doaaaaabejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
ahahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaadacaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaadaaaaaaamamaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahahaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
				}
			}
		}
	}
	Fallback "Diffuse"
}