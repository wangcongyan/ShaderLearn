Shader "Unlit/MyFirstShader"
{
	Properties
	{
		_Color("Color",Color) = (1,1,1,1)	
	}

	SubShader
	{
		Pass
		{
			
			CGPROGRAM
			#pragma vertex vert 
			#pragma fragment frag 

			fixed4 _Color;

			float4 vert(float4 v : POSITION):SV_POSITION
			{
				return UnityObjectToClipPos(v);
			}

			fixed4 frag():SV_Target
			{
				#if UNITY_UV_STARTS_AT_TOP
				if(_MainTex_TexelSize.y < 0)
				{
					uv.y = 1- uv.y;
				}
				return _Color;
			}
			ENDCG 
		}
		
	}

}
