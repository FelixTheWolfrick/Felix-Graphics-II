Shader "Final/TritanopiaShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Strength("Strength", Range(0,1)) = 1
    }
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;
            float _Strength;

            const float4x4 _Tritanopia = float4x4(
                0.97, 0.11, -0.08, 0.0,
                0.02, 0.82, 0.16, 0.0,
                -0.06, 0.88, 0.18, 0.0,
                0.0, 0.0, 0.0, 1.0
            );



            float4 frag (v2f i) : SV_Target
            {
                float4 col = tex2D(_MainTex, i.uv);

                float1 col1 = 0.97 * 0.11 * -0.08;
                float1 col2 = 0.02 * 0.82 * 0.16;
                float1 col3 = -0.06 * 0.88 * 0.18;

                //col.g = col.g * tritanopia_B;
                //col.b = col.b * tritanopia_C;
                //col.a = col.a * tritanopia_D;

                float4 colorBlind = mul(_Tritanopia, col);

                return colorBlind;
                //return lerp(col, colorBlind, _Strength);
            }
            ENDCG
        }
    }
}
