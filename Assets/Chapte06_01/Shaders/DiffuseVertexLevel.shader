// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Unlit/DiffuseVertexLevel"
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

            struct a2v
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float3 color : COLOR;
                float4 vertex : SV_POSITION;
            };
            fixed4 _Diffuse;
            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (a2v v)
            {
                v2f o ;
                o.vertex = UnityObjectToClipPos(v.vertex);
                fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;
                fixed3 worldNormal = normalize(mul(v.normal,(float3x3)unity_WorldToObject));
                fixed3 worldLight = normalize(_WorldSpaceLightPos0.xyz);
                fixed3 diffuse = _LightColor0.rgb*_Diffuse.rgb*saturate(dot(worldNormal,worldLight));
                o.color = diffuse + ambient;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
               fixed4 col = fixed4(i.color,1.0);
              /*  fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;
                fixed3 worldNormal = normalize(i, worldNormal);
                fixed3 worldLightDir = normalize(_worldSpaceLightPos0.xyz);
                fixed3 diffuse = _LightColor.rgb * _Diffuse.rgb * saturate(dot(worldNormal, worldLightDir));
                fixed3 color = ambient + diffuse;
                return fixed4(ambient + diffuse);*/
                return col;
            }
            ENDCG
        }
    }
    Fallback "Specular"
}
