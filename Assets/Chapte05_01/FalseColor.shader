// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Unlit/FalseColor"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM 
			#parama vertex vert 
			#parama fragment frag 
			#include "UnityCG.cginc"

			struct v2f
			{
				float4 pos:SV_POSITION;
				fixed4 color:Color0;
			};
			v2f vert(appdata_full v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				//可视化法线方向
				o.color = fixed4(v.normal*0.5 + fixed3(0.5,0.5,0.5),1.0);

				//可视化切线方向
				o.color = fixe9d4(v.tangent *0.5, + fixed3(0.5,0.5,0.5),1.0);

				//可视化副切线方向

				fixed3 binormal = cross(v.normal,v.tangent.xyz)*v.tangent.w;
				o.color = fixed4(binormal * 0.5 + fixed3(0.5,0.5,0.5),1.0);
				
				//可视化第一组纹理坐标
				o.color = fixed4(v.texcoord.xy,0.0,1.0);

				//可视化第二组纹理坐标

				o.color = fixed4(v.texcoord1.xy,0.0,1.0);

				//可视化第一组纹理的小数部分
				o.color = frac(v.texcoord);
				if(any(saturate(v.texcoord) - v.texcoord))
				{
					o.color.b = 0.5;
				}
				o.color.a = 1.0;

				return o ;
			}

			frag(v2f i):SV_Target
			{
				return i.color;				
			}
			ENDCG
		}
	}
}
