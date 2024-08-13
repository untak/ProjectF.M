// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Xuqi/ElementPBREmissionTransparent_Ambient"
{
	Properties
	{
		_Albedo("Albedo", 2D) = "white" {}
		[HDR]_MainColor("MainColor", Color) = (1,1,1,1)
		_Normal("Normal", 2D) = "bump" {}
		_NormalScale("NormalScale", Range( 0 , 2)) = 1
		_RmetGroughBaoAemi("R-met G-rough B-ao A--emi", 2D) = "black" {}
		[Header(____Metallic_____)][Space(10)]_MetalScale("MetalScale", Range( 0 , 2)) = 1
		_MetalBias("MetalBias", Range( 0 , 1)) = 0
		[Header(____Smoothness_____)][Space(10)]_SmoothnessScale("SmoothnessScale", Range( 0 , 3)) = 1
		_SmoothnessBias("SmoothnessBias", Range( 0 , 1)) = 0
		[Header(____AO_____)][Space(10)]_AOScale("AOScale", Range( 0 , 2)) = 1
		_AOBias("AOBias", Range( 0 , 1)) = 0
		[Header(____Emission_____)][Space(10)]_TextureEmision("TextureEmision", 2D) = "black" {}
		_EmissionScale("EmissionScale", Range( 0 , 5)) = 1
		_EmissionBias("EmissionBias", Range( 0 , 1)) = 0
		[HDR]_EmissionColor("EmissionColor", Color) = (1,0.995283,0.995283,1)
		[Header(Final Opacity)]_OpacityValueScale("OpacityValueScale", Range( 0 , 2)) = 1
		_OpacityValueOffset("OpacityValueOffset", Range( -1 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		Blend SrcAlpha OneMinusSrcAlpha , SrcAlpha OneMinusSrcAlpha
		BlendOp Add , Add
		CGINCLUDE
		#include "UnityStandardUtils.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform float _NormalScale;
		uniform float4 _MainColor;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform sampler2D _TextureEmision;
		uniform float4 _TextureEmision_ST;
		uniform float _EmissionScale;
		uniform float _EmissionBias;
		uniform float4 _EmissionColor;
		uniform sampler2D _RmetGroughBaoAemi;
		uniform float4 _RmetGroughBaoAemi_ST;
		uniform float _MetalScale;
		uniform float _MetalBias;
		uniform float _SmoothnessScale;
		uniform float _SmoothnessBias;
		uniform float _AOScale;
		uniform float _AOBias;
		uniform float _OpacityValueScale;
		uniform float _OpacityValueOffset;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			float3 tex2DNode2 = UnpackScaleNormal( tex2D( _Normal, uv_Normal ), _NormalScale );
			o.Normal = tex2DNode2;
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			float4 tex2DNode1 = tex2D( _Albedo, uv_Albedo );
			o.Albedo = ( _MainColor * tex2DNode1 ).rgb;
			float2 uv_TextureEmision = i.uv_texcoord * _TextureEmision_ST.xy + _TextureEmision_ST.zw;
			o.Emission = ( (tex2D( _TextureEmision, uv_TextureEmision )*_EmissionScale + _EmissionBias) * _EmissionColor ).rgb;
			float2 uv_RmetGroughBaoAemi = i.uv_texcoord * _RmetGroughBaoAemi_ST.xy + _RmetGroughBaoAemi_ST.zw;
			float4 tex2DNode7 = tex2D( _RmetGroughBaoAemi, uv_RmetGroughBaoAemi );
			o.Metallic = (tex2DNode7.r*_MetalScale + _MetalBias);
			o.Smoothness = (( 1.0 - tex2DNode7.g )*_SmoothnessScale + _SmoothnessBias);
			o.Occlusion = (tex2DNode7.b*_AOScale + _AOBias);
			o.Alpha = ( tex2DNode1.a > 0.95 ? 1.0 : (tex2DNode1.a*_OpacityValueScale + _OpacityValueOffset) );
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18934
277;69;1906;947;1073.908;837.725;1;True;False
Node;AmplifyShaderEditor.SamplerNode;7;-1307.464,-46.31241;Inherit;True;Property;_RmetGroughBaoAemi;R-met G-rough B-ao A--emi;5;0;Create;True;0;0;0;False;0;False;-1;None;c6b724ecafcf409409af32b9a5648d15;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;31;-509.0153,-500.0884;Inherit;False;Property;_OpacityValueOffset;OpacityValueOffset;17;0;Create;True;0;0;0;False;0;False;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-1238.118,1177.311;Inherit;False;Property;_EmissionScale;EmissionScale;13;0;Create;True;0;0;0;False;0;False;1;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-481.7152,-612.9882;Inherit;False;Property;_OpacityValueScale;OpacityValueScale;16;0;Create;True;0;0;0;False;1;Header(Final Opacity);False;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-1232.307,1283.351;Inherit;False;Property;_EmissionBias;EmissionBias;14;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;28;-1521.566,1091.101;Inherit;True;Property;_TextureEmision;TextureEmision;12;0;Create;True;0;0;0;False;2;Header(____Emission_____);Space(10);False;-1;None;0f531d7bcfe217e4e8febb41bb54fbc6;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-704,-161.5;Inherit;True;Property;_Albedo;Albedo;1;0;Create;True;0;0;0;False;0;False;-1;None;47ed0da90d441fb4e838af6498841f5b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;16;-804.737,533.891;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-1238.853,961.2665;Inherit;False;Property;_AOBias;AOBias;11;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;6;-646.4675,-388.0861;Inherit;False;Property;_MainColor;MainColor;2;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;18;-1236.361,711.5699;Inherit;False;Property;_SmoothnessBias;SmoothnessBias;9;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-1252.405,252.2751;Inherit;False;Property;_MetalBias;MetalBias;7;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-1241.216,174.5349;Inherit;False;Property;_MetalScale;MetalScale;6;0;Create;True;0;0;0;False;2;Header(____Metallic_____);Space(10);False;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;22;-736.8976,1107.721;Inherit;False;3;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-758.0738,377.2986;Inherit;False;Property;_NormalScale;NormalScale;4;0;Create;True;0;0;0;False;0;False;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-1248,624;Inherit;False;Property;_SmoothnessScale;SmoothnessScale;8;0;Create;True;0;0;0;False;2;Header(____Smoothness_____);Space(10);False;1;1;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;26;-1122.386,1465.641;Inherit;False;Property;_EmissionColor;EmissionColor;15;1;[HDR];Create;True;0;0;0;False;0;False;1,0.995283,0.995283,1;0,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;20;-1248,848;Inherit;False;Property;_AOScale;AOScale;10;0;Create;True;0;0;0;False;2;Header(____AO_____);Space(10);False;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;29;-169.8152,-523.5883;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;15;-618.5759,601.0501;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-341.4675,-268.0861;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-488.3182,1225.374;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;19;-721.8663,850.3689;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-728.2726,137.3327;Inherit;True;Property;_Normal;Normal;3;0;Create;True;0;0;0;False;0;False;-1;None;6a899643711287b46afac642de6c8cfc;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.UnpackScaleNormalNode;3;-411.2598,253.2939;Inherit;False;Tangent;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Compare;32;115.5566,-352.8816;Inherit;False;2;4;0;FLOAT;0;False;1;FLOAT;0.95;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;11;-893.0172,55.15561;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;210,-20;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Xuqi/ElementPBREmissionTransparent_Ambient;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Custom;;Transparent;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;2;5;False;-1;10;False;-1;0;False;-1;1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;16;0;7;2
WireConnection;22;0;28;0
WireConnection;22;1;23;0
WireConnection;22;2;24;0
WireConnection;29;0;1;4
WireConnection;29;1;30;0
WireConnection;29;2;31;0
WireConnection;15;0;16;0
WireConnection;15;1;17;0
WireConnection;15;2;18;0
WireConnection;5;0;6;0
WireConnection;5;1;1;0
WireConnection;27;0;22;0
WireConnection;27;1;26;0
WireConnection;19;0;7;3
WireConnection;19;1;20;0
WireConnection;19;2;21;0
WireConnection;2;5;4;0
WireConnection;3;0;2;0
WireConnection;3;1;4;0
WireConnection;32;0;1;4
WireConnection;32;3;29;0
WireConnection;11;0;7;1
WireConnection;11;1;13;0
WireConnection;11;2;14;0
WireConnection;0;0;5;0
WireConnection;0;1;2;0
WireConnection;0;2;27;0
WireConnection;0;3;11;0
WireConnection;0;4;15;0
WireConnection;0;5;19;0
WireConnection;0;9;32;0
ASEEND*/
//CHKSM=DC7C8968AE6586C1E84353C91BD92DC07B058AF3