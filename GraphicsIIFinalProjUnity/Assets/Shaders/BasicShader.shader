Shader "Final/Basic_Shader"
{
	Properties // Variables here
	{
		_MainTexture("Texture", 2D) = "white" {} // Defaults to white
		_Color("Color", Color) = (1, 1, 1, 1) // Defaults to white
	}

	SubShader // Actual shaders here
	{
		Pass
		{
			CGPROGRAM // Anything between CG and ENDCG is the shader language

			#pragma vertex basicVertexFunction // Pragma is basically a function
			#pragma fragment basicFragmentFunction

			#include "UnityCG.cginc" // Library from NVIDIA

			struct appdata {
				float4 vertex : POSITION; // Position of the current vertex
				float2 uv : TEXCOORD0;
			};

			struct v2f { // vertex to fragment
				float4 position : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			fixed4 _Color;
			sampler2D _MainTexture;

			v2f basicVertexFunction(appdata IN)
			{
				v2f OUT;

				OUT.position = UnityObjectToClipPos(IN.vertex); // Takes object position and shows it on the camera
				OUT.uv = IN.uv;

				return OUT;
			}

			fixed4 basicFragmentFunction(v2f IN) : SV_Target
			{
				fixed4 pixelColor = tex2D(_MainTexture, IN.uv);

			return pixelColor * _Color;
			}

			ENDCG
		}
	}
}