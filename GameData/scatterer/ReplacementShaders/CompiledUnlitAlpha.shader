Shader "Scatterer/Unlit/Transparent"
{
    Properties {
        _MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
    }
    SubShader {
        ZWrite On
	LOD 100
        Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true"

            "RenderType"="Transparent"
        }
        Pass {
            Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true"

                "RenderType"="Transparent"
            }
            ZWrite Off
            Blend SrcAlpha OneMinusSrcAlpha
            Program "vp" {
                SubProgram

                "opengl " {
                    Bind "vertex" Vertex
                    Bind "texcoord" TexCoord0
                    Vector 5 [_MainTex_ST]
                    "!!ARBvp1.0
                    PARAM c

                    [6] = { program.local[0],
                    state.matrix.mvp,
                    program.local[5] };
                    MAD

                    result.texcoord[0].xy, vertex.texcoord[0], c[5], c[5].zwzw;
                    DP4 result.position.w, vertex.position,

                    c[4];
                    DP4 result.position.z, vertex.position, c[3];
                    DP4 result.position.y, vertex.position, c[2];
                    DP4

                    result.position.x, vertex.position, c[1];
                    END
# 5 instructions, 0 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    Bind

                    "vertex" Vertex
                    Bind "texcoord" TexCoord0
                    Matrix 0 [glstate_matrix_mvp]
                    Vector 4 [_MainTex_ST]
                    "vs_2_0
                    dcl_position0 v0
                    dcl_texcoord0 v1
                    mad oT0.xy, v1, c4, c4.zwzw
                    dp4 oPos.w, v0, c3
                    dp4 oPos.z,

                    v0, c2
                    dp4 oPos.y, v0, c1
                    dp4 oPos.x, v0, c0
                    "
                }
                SubProgram "d3d11 " {
                    Bind "vertex" Vertex
                    Bind

                    "texcoord" TexCoord0
                    ConstBuffer "$Globals" 32
                    Vector 16 [_MainTex_ST]
                    ConstBuffer "UnityPerDraw"

                    336
                    Matrix 0 [glstate_matrix_mvp]
                    BindCB  "$Globals" 0
                    BindCB  "UnityPerDraw" 1
                    "vs_4_0
                    eefiecedmeiefdmplfblpnmaalcmohkfnkcoenkmabaaaaaaamacaaaaadaaaaaa
                    cmaaaaaaiaaaaaaaniaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
                    epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
                    aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
                    fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefccmabaaaa
                    eaaaabaaelaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
                    abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
                    ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaac
                    abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
                    abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
                    aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
                    acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
                    egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
                    dccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaaogikcaaa
                    aaaaaaaaabaaaaaadoaaaaab"
                }
                SubProgram "d3d11_9x " {
                    Bind "vertex" Vertex
                    Bind "texcoord" TexCoord0
                    ConstBuffer "$Globals" 32
                    Vector 16 [_MainTex_ST]
                    ConstBuffer "UnityPerDraw" 336
                    Matrix 0 [glstate_matrix_mvp]
                    BindCB

                    "$Globals" 0
                    BindCB  "UnityPerDraw" 1
                    "vs_4_0_level_9_1
                    eefiecedofngkbelhagmalpfbgkmeahpgjdpnfiiabaaaaaapiacaaaaaeaaaaaa
                    daaaaaaabiabaaaaemacaaaakaacaaaaebgpgodjoaaaaaaaoaaaaaaaaaacpopp
                    kaaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
                    abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
                    afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjaaeaaaaaeaaaaadoaabaaoeja
                    abaaoekaabaaookaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
                    acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
                    aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
                    aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefccmabaaaa
                    eaaaabaaelaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
                    abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
                    ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaac
                    abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
                    abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
                    aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
                    acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
                    egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
                    dccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaaogikcaaa
                    aaaaaaaaabaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
                    aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
                    epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
                    aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
                    fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
                }
            }
            Program "fp" {
                SubProgram "opengl " {
                    SetTexture

                    0 [_MainTex] 2D 0
                    "!!ARBfp1.0
                    TEX result.color, fragment.texcoord[0], texture[0], 2D;
                    END
# 1 

                    instructions, 0 R-regs
                    "
                }
                SubProgram "d3d9 " {
                    SetTexture 0 [_MainTex] 2D 0
                    "ps_2_0
                    dcl_2d s0
                    dcl t0.xy
                    texld r0, t0, s0
                    mov_pp oC0, r0
                    "
                }
                SubProgram "d3d11 " {
                    SetTexture 0 [_MainTex] 2D 0
                    "ps_4_0
                    eefiecedejmlhadafglglkphccimbgjbjggkahdaabaaaaaaceabaaaaadaaaaaa
                    cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
                    aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
                    aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
                    adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgeaaaaaa
                    eaaaaaaabjaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
                    ffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaaefaaaaaj
                    pccabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
                    doaaaaab"
                }
                SubProgram "d3d11_9x "

                {
                    SetTexture 0 [_MainTex] 2D 0
                    "ps_4_0_level_9_1
                    eefiecedbinabkgbkpdbgmkgbcblbjcogcklficlabaaaaaajeabaaaaaeaaaaaa
                    daaaaaaajmaaaaaaaiabaaaagaabaaaaebgpgodjgeaaaaaageaaaaaaaaacpppp
                    dmaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
                    aaacppppbpaaaaacaaaaaaiaaaaacdlabpaaaaacaaaaaajaaaaiapkaecaaaaad
                    aaaacpiaaaaaoelaaaaioekaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
                    geaaaaaaeaaaaaaabjaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
                    aaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaa
                    efaaaaajpccabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
                    aaaaaaaadoaaaaabejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaa
                    abaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
                    abaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
                    epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
                    aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
                }
            }
        }
    }
}
