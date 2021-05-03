Shader "Final/ToonOutlineShader"
{
    Properties
    {
        _MainTexture("Texture", 2D) = "white" {}
        _Color("Color", Color) = (1, 1, 1, 1)
        _OutlineColor("Outline Color", Color) = (0, 0, 0, 1) // Black
        _OutlineSize("Outline Size", float) = 0
    }
    SubShader
    {

        Pass // Outline
        {
            Cull OFF
            ZWrite ON
            ZTest ON
            Stencil
            {
                Ref 4
                Comp notequal
                Fail keep
                Pass replace
            }

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag   

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float4 color : COLOR;
            };

            float4 _OutlineColor;
            float _OutlineSize;

            v2f vert (appdata v)
            {
                v2f o;
                float4 newPos = v.vertex;
                float3 normal = normalize(v.normal);
                newPos += float4(normal, 0.0) * _OutlineSize;
                o.pos = UnityObjectToClipPos(newPos);
                o.color = _OutlineColor;
                return o;
            }

            float4 frag (v2f i) : COLOR
            {
                return _OutlineColor;
            }
            ENDCG
        }
    }
}
