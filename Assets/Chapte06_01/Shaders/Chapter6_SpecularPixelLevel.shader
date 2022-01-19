// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Unlit/Chapter6_SpecularPixelLevel"
{
    Properties
    {
        _Diffuse("Diffuse",Color) = (1,1,1,1)
        _Specular("Specular",Color) = (1,1,1,1)
        _Gloss("Gloss",Range(8.0,256)) = 20
    }
    SubShader
    {
        Tags { "LightMode"="ForwardBase" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            #include "Lighting.cginc"

            fixed4 _Diffuse;
            fixed4 _Specular;
            float _Gloss;

            struct a2v
            {
                float4 vertex:POSITION;
                float3 normal:NORMAL;
            };
            struct v2f
            {
                float4 pos:SV_POSITION;
                float3 worldNormal:NORMAL;
                fixed3 worldPos :TEXCOORD1;
            };

            v2f vert(a2v v)
            {
                v2f o;
               

                return o;
            }

            fixed4 frag(v2f i):SV_Target
            {
                return fixed4(i.color,1.0);
            }
            ENDCG
        }
    }
}
