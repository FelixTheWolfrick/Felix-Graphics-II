Shader "Final/PostProcessingShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Saturate("Saturate", float) = 1
        _Contrast("Contrast", float) = 1
        _Brightness("Brightness", float) = 1
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
            float _Saturate;
            float _Contrast;
            float _Brightness;

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv) * _Saturate * _Brightness;
                fixed4 contrast = col * col;
                fixed4 render = lerp(contrast, col, _Contrast);
                return render;
            }
            ENDCG
        }
    }
}
