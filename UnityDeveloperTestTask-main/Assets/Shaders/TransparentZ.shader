// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Transparent/Tooned" {
	Properties{
	  _MainTex("Texture", 2D) = "white" {}
	  _Color("Texture color", Color) = (1,1,1,1)
	  _ambient("Ambhient oclussion", 2D) = "white" {}
	  _oclussion("AO power", range(0,1)) = .5
	  _BumpMap("Normal map", 2D) = "bump" {}
	  _alpha("Alpha", range(0,1)) = 1
	  _EmissionMap("Emission Map", 2D) = "black" {}
	  _EmissionColor("Emission Color", Color) = (0.26,0.19,0.16,0.0)
	  //_EmissionPower("Emission Power", Range(0.5,8.0)) = 0.5
	}
		SubShader{
	   Tags {"RenderType" = "Transparent" "Queue" = "Transparent" "IgnoreProjector" = "True"}


		Pass {
			ZWrite On
			ColorMask 0	  
		  

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			#include "AutoLight.cginc"

			struct v2f {
				float4 vertex : SV_POSITION;
				LIGHTING_COORDS(0, 1)
			};

			v2f vert(appdata_base v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				TRANSFER_VERTEX_TO_FRAGMENT(o);
				return o;
			}

			half4 frag(v2f i) : COLOR
			{
				float atten = LIGHT_ATTENUATION(IN);;
				return half4 (0,0,0,0);
			}
			ENDCG
		}  


		  CGPROGRAM
		  #pragma surface surf Lambert alpha
		  struct Input {
			  float2 uv_MainTex;
			  float2 uv_BumpMap;
			  float2 uv_EmissionMap;
			  float3 viewDir;
		  };

		  sampler2D _MainTex;
		  sampler2D _ambient;
		  sampler2D _BumpMap;
		  sampler2D _EmissionMap;
		  fixed _alpha;
		  fixed _oclussion;
		  float4 _EmissionColor;
		  float _EmissionPower;
		  float4 _Color;
		  float atten;

		  void surf(Input IN, inout SurfaceOutput o) {
			  o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb * _Color.rgb * lerp(1, tex2D(_ambient, IN.uv_MainTex).rgb, _oclussion);
			  o.Alpha = _alpha;
			  o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
			  half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
			  o.Emission = tex2D(_EmissionMap, IN.uv_EmissionMap) * _EmissionColor.rgb; // *pow(rim, _EmissionPower);
		  }
		  ENDCG
	  }
		  Fallback "Diffuse"
}