Shader "Final/OutlineShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color("Color", Color) = (1, 1, 1, 1)
        _OutlineColor("Outline Color", Color) = (0, 0, 0, 1) // Black
        _OutlineSize("Outline Size", float) = 1.0
    }

    CGINCLUDE
    #include "UnityCG.cginc"

    struct appdata {
            float4 vertex : POSITION;
            float3 normal : NORMAL;
    };

    struct v2f {
        float4 pos : POSITION;
        float4 color : COLOR;
        float3 normal : NORMAL;
    };

    float _OutlineSize;
    float4 _OutlineColor;

    v2f vert(appdata v)
    {
        v2f o;
        float4 newPos = v.vertex;
        float3 normal = normalize(v.normal);
        newPos += float4(normal, 0.0) * _OutlineSize;
        o.pos = UnityObjectToClipPos(newPos);
        o.color = _OutlineColor;
        return o;
    }

    ENDCG

    SubShader
    {
        Tags {"Queue" = "Transparent"}
        Blend SrcAlpha OneMinusSrcAlpha // Makes it so you can see what's underneath when transparent

        Pass // Render Outline
        {
            ZWrite Off

            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            half4 frag(v2f i) : COLOR
            {
                return _OutlineColor;
            }

            ENDCG
        }

        Pass // Normal Render
        {
                ZWrite On

                Material // Gets Material & Lighting
                {
                    Diffuse[_Color]
                    Ambient[_Color]
                }

                Lighting On

                SetTexture[_MainTex] // Color
                {
                    ConstantColor[_Color]
                }

                SetTexture[_MainTex] // Multiplies in the texture
                {
                    Combine previous * primary DOUBLE
                }
        }
    }
}
