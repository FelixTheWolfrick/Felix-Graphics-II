Shader "Final/Waves_Shader"
{
	Properties // Variables here
	{
		_MainTexture("Texture", 2D) = "white" {} // Defaults to white
		_Color("Color", Color) = (1, 1, 1, 1) // Defaults to white
		_Strength("Wave Strength", Range(0, 2)) = 1.0
		_Speed("Wave Speed", Range(-200, 200)) = 100
	}

	SubShader // Actual shaders here
	{
		Tags {
			"Queue" = "Transparent" 
			"IgnoreProjector" = "True" 
			"RednerType" = "Transparent"
		}
		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha // Makes it so you can see what's underneath when transparent

		Pass
		{
			Cull Off

			CGPROGRAM // Anything between CG and ENDCG is the shader language

			#pragma vertex basicVertexFunction // Pragma is basically a function
			#pragma fragment basicFragmentFunction

			#include "UnityCG.cginc" // Library from NVIDIA

			float _Strength;
			float _Speed;

			struct vertexInput {
				float4 vertex : POSITION; // Position of the current vertex
				float2 uv : TEXCOORD0;
			};

			struct v2f { // vertex to fragment
				float4 position : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			float4 _Color;
			sampler2D _MainTexture;

			v2f basicVertexFunction(vertexInput IN)
			{
				v2f OUT;

				float4 worldPosition = mul(unity_ObjectToWorld, IN.vertex);

				float displacement = (cos(worldPosition.y) + cos(worldPosition.x + (_Speed * _Time)));
				worldPosition.y = worldPosition.y + (displacement * _Strength);

				OUT.position = mul(UNITY_MATRIX_VP, worldPosition);
				OUT.uv = IN.uv;

				return OUT;
			}

			float4 basicFragmentFunction(v2f IN) : SV_Target
			{
				float4 pixelColor = tex2D(_MainTexture, IN.uv);

				return pixelColor * _Color;
			}

			ENDCG
		}
	}
}