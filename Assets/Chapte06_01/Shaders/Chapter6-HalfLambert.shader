Shader "Unlit/Chapter6-HalfLambert"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Diffuse("Diffuse",COLOR) = (1,1,1,1)
    }
    SubShader
    {
        Tags{"LightMode" = "ForwardBase"}        
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"
            #include "Lighting.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float3 worldNormal:TEXCOORD0;
            };

            fixed4 _Diffuse;
            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;
                fixed3 worldNormal = normalize(mul(v.normal,(float3x3)unity_WorldToObject));
                o.worldNormal = worldNormal;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
             fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;
             fixed3 worldNormal = normalize(i.worldNormal);
             fixed3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);
             fixed halfLambert = dot(worldNormal,worldLightDir)*0.5 + 0.5;
             fixed3 diffuse = _LightColor0.rgb*_Diffuse.rgb * halfLambert;
             fixed3 color = ambient + diffuse;
                return  fixed4(color,1.0);
            }
            ENDCG
        }
    }
}
