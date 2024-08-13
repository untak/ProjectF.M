// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "CyberCity/LY/XuqiWaterLiquid_Com"
{
	Properties
	{
		[HDR]_Main2Color("Main2Color", Color) = (1,1,1,1)
		[HDR]_Main2Color2("Main2Color2", Color) = (1,1,1,1)
		[HDR]_FrontColor("FrontColor", Color) = (1,1,1,1)
		[HDR]_FrontColor2("FrontColor2", Color) = (1,1,1,1)
		_Alpha("Alpha", Range( 0 , 1)) = 0
		_NoiseTilling("NoiseTilling", Vector) = (0,0,0,0)
		_NormalTilling("NormalTilling", Vector) = (0,0,0,0)
		_MainTilling("MainTilling", Vector) = (0,0,0,0)
		_NoiseSpeed("NoiseSpeed", Vector) = (0,0,0,0)
		_GlobalNoiseIntensity("GlobalNoiseIntensity", Range( 0 , 0.15)) = 0
		_TextureMain1("Texture Main1", 2D) = "white" {}
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_WaterMainRatio("WaterMainRatio", Range( 0 , 50)) = 0
		_Main2ColorScaleAndOffset("Main2ColorScaleAndOffset", Vector) = (1,0,0,0)
		_Main1ColorScaleAndOffset("Main1ColorScaleAndOffset", Vector) = (1,0,0,0)
		_FrontMetallic("FrontMetallic", Range( 0 , 1)) = 0
		_FrontSmoothness("FrontSmoothness", Range( 0 , 1)) = 0
		_TextureNormal("TextureNormal", 2D) = "bump" {}
		_NormalSpeedRatio("NormalSpeedRatio", Range( 0 , 2)) = 1
		_NormalScale("NormalScale", Range( 0 , 3)) = 1.25
		_wrapInt("wrapInt", Range( 0 , 1)) = 0
		_wrapInt2("wrapInt2", Range( 1 , 10)) = 0
		_opacityTop("opacityTop", Float) = 0
		_opacityBottom("opacityBottom", Float) = 0
		_opacityOffset("opacityOffset", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
		};

		uniform sampler2D _TextureNormal;
		uniform float2 _NormalTilling;
		uniform float2 _NoiseSpeed;
		uniform float2 _NoiseTilling;
		uniform float _wrapInt;
		uniform float _GlobalNoiseIntensity;
		uniform float _WaterMainRatio;
		uniform float _NormalSpeedRatio;
		uniform float _NormalScale;
		uniform float4 _FrontColor;
		uniform float4 _FrontColor2;
		uniform sampler2D _TextureMain1;
		uniform float2 _MainTilling;
		uniform float _wrapInt2;
		uniform float2 _Main1ColorScaleAndOffset;
		uniform float4 _Main2Color;
		uniform float4 _Main2Color2;
		uniform sampler2D _TextureSample1;
		uniform float2 _Main2ColorScaleAndOffset;
		uniform float _FrontMetallic;
		uniform float _FrontSmoothness;
		uniform float _opacityBottom;
		uniform float _opacityTop;
		uniform float _opacityOffset;
		uniform float _Alpha;


		float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }

		float snoise( float2 v )
		{
			const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
			float2 i = floor( v + dot( v, C.yy ) );
			float2 x0 = v - i + dot( i, C.xx );
			float2 i1;
			i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
			float4 x12 = x0.xyxy + C.xxzz;
			x12.xy -= i1;
			i = mod2D289( i );
			float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
			float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
			m = m * m;
			m = m * m;
			float3 x = 2.0 * frac( p * C.www ) - 1.0;
			float3 h = abs( x ) - 0.5;
			float3 ox = floor( x + 0.5 );
			float3 a0 = x - ox;
			m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
			float3 g;
			g.x = a0.x * x0.x + h.x * x0.y;
			g.yz = a0.yz * x12.xz + h.yz * x12.yw;
			return 130.0 * dot( m, g );
		}


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TexCoord66 = i.uv_texcoord * _NormalTilling;
			float2 uv_TexCoord19 = i.uv_texcoord * _NoiseTilling;
			float2 panner23 = ( 1.0 * _Time.y * _NoiseSpeed + uv_TexCoord19);
			float simplePerlin2D12 = snoise( panner23*10.74 );
			simplePerlin2D12 = simplePerlin2D12*0.5 + 0.5;
			float temp_output_75_0 = ( simplePerlin2D12 * _wrapInt );
			float2 temp_cast_0 = (( uv_TexCoord66 + temp_output_75_0 )).xx;
			float mulTime32 = _Time.y * _GlobalNoiseIntensity;
			float temp_output_31_0 = ( mulTime32 * _WaterMainRatio );
			float cos68 = cos( ( temp_output_31_0 * _NormalSpeedRatio ) );
			float sin68 = sin( ( temp_output_31_0 * _NormalSpeedRatio ) );
			float2 rotator68 = mul( temp_cast_0 - float2( 0.5,0.5 ) , float2x2( cos68 , -sin68 , sin68 , cos68 )) + float2( 0.5,0.5 );
			o.Normal = UnpackScaleNormal( tex2D( _TextureNormal, rotator68 ), _NormalScale );
			float2 uv_TexCoord30 = i.uv_texcoord * _MainTilling;
			float2 panner96 = ( 1.0 * _Time.y * float2( 0.02,0 ) + uv_TexCoord30);
			float4 lerpResult51 = lerp( _FrontColor , _FrontColor2 , ((tex2D( _TextureMain1, ( panner96 + ( temp_output_75_0 * _wrapInt2 ) ) )*_Main1ColorScaleAndOffset.x + _Main1ColorScaleAndOffset.y)).r);
			float cos29 = cos( temp_output_31_0 );
			float sin29 = sin( temp_output_31_0 );
			float2 rotator29 = mul( ( uv_TexCoord30 + temp_output_75_0 ) - float2( 0.5,0.5 ) , float2x2( cos29 , -sin29 , sin29 , cos29 )) + float2( 0.5,0.5 );
			float4 lerpResult60 = lerp( _Main2Color , _Main2Color2 , (tex2D( _TextureSample1, rotator29 ).r*_Main2ColorScaleAndOffset.x + _Main2ColorScaleAndOffset.y));
			o.Emission = saturate( ( lerpResult51 * lerpResult60 ) ).rgb;
			o.Metallic = _FrontMetallic;
			float temp_output_44_0 = _FrontSmoothness;
			o.Smoothness = temp_output_44_0;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float smoothstepResult83 = smoothstep( _opacityBottom , _opacityTop , ase_vertex3Pos.y);
			o.Alpha = ( (_opacityOffset + (smoothstepResult83 - 1.0) * (1.0 - _opacityOffset) / (0.0 - 1.0)) * _Alpha );
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows noambient 

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
				surfIN.worldPos = worldPos;
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
321;73;1161;573;2598.502;585.0759;1.3;True;False
Node;AmplifyShaderEditor.Vector2Node;18;-3389.351,-577.9619;Inherit;False;Property;_NoiseTilling;NoiseTilling;10;0;Create;True;0;0;0;False;0;False;0,0;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;19;-3145.929,-563.7477;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;20;-3449.802,-323.9772;Inherit;True;Property;_NoiseSpeed;NoiseSpeed;13;0;Create;True;0;0;0;False;0;False;0,0;0.02,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PannerNode;23;-2866.682,-337.8913;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;77;-2067.787,-238.3002;Inherit;False;Property;_wrapInt;wrapInt;29;0;Create;True;0;0;0;False;0;False;0;0.025;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;12;-2279.219,-420.1841;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;10.74;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;33;-1949.977,-794.5477;Inherit;False;Property;_MainTilling;MainTilling;12;0;Create;True;0;0;0;False;0;False;0,0;6.37,6.63;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;30;-1698.038,-753.0688;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;22;-2055.219,-123.1848;Inherit;False;Property;_GlobalNoiseIntensity;GlobalNoiseIntensity;14;0;Create;True;0;0;0;False;0;False;0;0.0186;0;0.15;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;95;-1516.363,-379.1678;Inherit;False;Property;_wrapInt2;wrapInt2;30;0;Create;True;0;0;0;False;0;False;0;2.56;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;75;-1735.384,-471.3224;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;85;-1248.475,-527.2258;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;96;-1341.526,-647.9518;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.02,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-1581.297,-76.21487;Inherit;False;Property;_WaterMainRatio;WaterMainRatio;19;0;Create;True;0;0;0;False;0;False;0;0.1;0;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;32;-1569.675,-290.6784;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-1204.148,-259.0168;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;8;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;72;-1027.464,-422.5462;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;86;-932.2929,-643.2606;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;26;-360.1983,-407.4173;Inherit;True;Property;_TextureMain1;Texture Main1;16;0;Create;True;0;0;0;False;0;False;-1;None;34ebb287809538e449bc8d6ee9dcb781;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RotatorNode;29;-748.0772,-187.6488;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;36;-314.9903,-200.1762;Inherit;False;Property;_Main1ColorScaleAndOffset;Main1ColorScaleAndOffset;21;0;Create;True;0;0;0;False;0;False;1,0;1.17,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.ScaleAndOffsetNode;35;-25.71616,-231.8327;Inherit;False;3;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;57;-341.4755,151.1775;Inherit;False;Property;_Main2ColorScaleAndOffset;Main2ColorScaleAndOffset;20;0;Create;True;0;0;0;False;0;False;1,0;1,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;55;-378.7478,-56.0103;Inherit;True;Property;_TextureSample1;Texture Sample 1;17;0;Create;True;0;0;0;False;0;False;-1;None;8921f695db090fb4c9dfeb455147d4ce;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;67;-1924.478,-944.199;Inherit;False;Property;_NormalTilling;NormalTilling;11;0;Create;True;0;0;0;False;0;False;0,0;0.3,0.3;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.ColorNode;58;196.231,-157.6684;Inherit;False;Property;_Main2Color;Main2Color;2;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;0,0.3306079,0.5377358,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;59;173.8136,-3.821542;Inherit;False;Property;_Main2Color2;Main2Color2;3;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;0.8603976,0.8603976,0.8603976,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScaleAndOffsetNode;56;-17.97798,100.5378;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;87;351.8174,-222.8464;Inherit;False;True;False;False;False;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;52;164.5606,-400.2078;Inherit;False;Property;_FrontColor2;FrontColor2;5;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;5.241328,6.444422,6.498021,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;89;282.8895,847.6129;Inherit;False;Property;_opacityTop;opacityTop;32;0;Create;True;0;0;0;False;0;False;0;13.98;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;6;163.5947,-576.2038;Inherit;False;Property;_FrontColor;FrontColor;4;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;1.135301,1.135301,1.135301,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PosVertexDataNode;82;262.3023,567.4919;Inherit;True;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;70;-1232.813,-723.3309;Inherit;False;Property;_NormalSpeedRatio;NormalSpeedRatio;27;0;Create;True;0;0;0;False;0;False;1;1.45;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;93;283.4795,754.849;Inherit;False;Property;_opacityBottom;opacityBottom;33;0;Create;True;0;0;0;False;0;False;0;9.7;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;66;-1673.839,-901.42;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;-946.8059,-763.1938;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;76;-1439.169,-874.6556;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;51;541.7255,-364.8549;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;94;677.4912,895.1631;Inherit;False;Property;_opacityOffset;opacityOffset;34;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;83;665.6384,617.3492;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;30;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;60;521.3729,-75.77345;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RotatorNode;68;-763.5462,-860.2694;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-604.8166,-630.2109;Inherit;False;Property;_NormalScale;NormalScale;28;0;Create;True;0;0;0;False;0;False;1.25;2.81;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;1016.764,172.4079;Inherit;True;Property;_Alpha;Alpha;7;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;91;916.4329,623.3735;Inherit;True;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;62;764.5508,-165.7353;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;38;221.3209,-1570.565;Inherit;False;Property;_BackColor;BackColor;6;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;0.08235293,0.601903,0.7490196,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TimeNode;81;-3107.38,-82.32924;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;88;1324.949,175.8217;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;49;345.0672,-1264.736;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;7;-992.3627,619.5524;Inherit;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;47;-192.2229,-702.0809;Inherit;True;Property;_TextureNormal;TextureNormal;26;0;Create;True;0;0;0;False;0;False;-1;None;12528a82c0240d24791232970fda695f;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SwitchByFaceNode;43;873.3334,443.3968;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;78;-3094.379,-169.4293;Inherit;False;Property;_Float1;Float 1;31;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;41;-175.2429,-1320.282;Inherit;False;Property;_noTextureMain2ColorScaleAndOffset;noTextureMain2ColorScaleAndOffset;22;0;Create;True;0;0;0;False;0;False;1,0;0.5,0.5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;25;-2656.096,-178.1252;Inherit;True;Property;_TextureSample0;Texture Sample 0;15;0;Create;True;0;0;0;False;0;False;-1;None;9ccb939568afc844d82aa1b41bae3656;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;14;-1168.458,74.39443;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;16;-2332.759,204.8945;Inherit;False;Property;_NoiseScaleAndOffset;NoiseScaleAndOffset;9;0;Create;True;0;0;0;False;0;False;2,-1;2,-1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.StepOpNode;10;-749.7579,658.7659;Inherit;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WorldPosInputsNode;1;-1809.838,346.0155;Inherit;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;44;544.8075,373.6477;Inherit;False;Property;_FrontSmoothness;FrontSmoothness;24;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;42;151.4476,-1342.163;Inherit;False;3;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RotatorNode;84;-910.7218,215.4983;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;559.8388,-1299.278;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;45;560.2933,476.3302;Inherit;False;Property;_BackSmoothness;BackSmoothness;25;0;Create;True;0;0;0;False;0;False;0;0.099;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;46;-1186.645,744.0642;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;2;False;2;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;3;-1577.602,772.8885;Inherit;True;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RotateAboutAxisNode;28;546.8801,-1540.935;Inherit;False;False;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-3062.711,1.61239;Inherit;False;Property;_NoiseUVScale;NoiseUVScale;8;0;Create;True;0;0;0;False;0;False;0;43.45997;0;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;40;-192.567,-1548.392;Inherit;True;Property;_TextureMain2;Texture Main2;18;0;Create;True;0;0;0;False;0;False;-1;None;6987022f6e37f0c4e86f934765905fe5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-1547.124,65.41031;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;53;863.4026,-288.046;Inherit;False;Property;_FrontMetallic;FrontMetallic;23;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;54;797.7189,-712.7823;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;50;990.6261,-164.5129;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-1559.547,653.2366;Inherit;False;Property;_FillValue;FillValue;1;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleNode;24;-3176.657,-397.0081;Inherit;False;0.01;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SwitchByFaceNode;37;719.9489,-1293.513;Inherit;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;13;-1912.858,65.3944;Inherit;True;3;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;79;-2801.88,-104.4293;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1738.6,-327.579;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;CyberCity/LY/XuqiWaterLiquid_Com;False;False;False;False;True;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Transparent;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;1;False;-1;6;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;19;0;18;0
WireConnection;23;0;19;0
WireConnection;23;2;20;0
WireConnection;12;0;23;0
WireConnection;30;0;33;0
WireConnection;75;0;12;0
WireConnection;75;1;77;0
WireConnection;85;0;75;0
WireConnection;85;1;95;0
WireConnection;96;0;30;0
WireConnection;32;0;22;0
WireConnection;31;0;32;0
WireConnection;31;1;34;0
WireConnection;72;0;30;0
WireConnection;72;1;75;0
WireConnection;86;0;96;0
WireConnection;86;1;85;0
WireConnection;26;1;86;0
WireConnection;29;0;72;0
WireConnection;29;2;31;0
WireConnection;35;0;26;0
WireConnection;35;1;36;1
WireConnection;35;2;36;2
WireConnection;55;1;29;0
WireConnection;56;0;55;1
WireConnection;56;1;57;1
WireConnection;56;2;57;2
WireConnection;87;0;35;0
WireConnection;66;0;67;0
WireConnection;69;0;31;0
WireConnection;69;1;70;0
WireConnection;76;0;66;0
WireConnection;76;1;75;0
WireConnection;51;0;6;0
WireConnection;51;1;52;0
WireConnection;51;2;87;0
WireConnection;83;0;82;2
WireConnection;83;1;93;0
WireConnection;83;2;89;0
WireConnection;60;0;58;0
WireConnection;60;1;59;0
WireConnection;60;2;56;0
WireConnection;68;0;76;0
WireConnection;68;2;69;0
WireConnection;91;0;83;0
WireConnection;91;3;94;0
WireConnection;62;0;51;0
WireConnection;62;1;60;0
WireConnection;88;0;91;0
WireConnection;88;1;11;0
WireConnection;49;0;42;0
WireConnection;7;0;14;0
WireConnection;7;1;46;0
WireConnection;47;1;68;0
WireConnection;47;5;48;0
WireConnection;43;0;44;0
WireConnection;43;1;45;0
WireConnection;25;1;23;0
WireConnection;14;0;21;0
WireConnection;14;1;1;2
WireConnection;10;0;7;0
WireConnection;42;0;40;0
WireConnection;42;1;41;1
WireConnection;42;2;41;2
WireConnection;84;0;30;0
WireConnection;84;2;31;0
WireConnection;39;0;38;0
WireConnection;39;1;49;0
WireConnection;46;0;8;0
WireConnection;40;1;29;0
WireConnection;21;0;13;0
WireConnection;21;1;22;0
WireConnection;54;0;51;0
WireConnection;54;1;60;0
WireConnection;50;0;62;0
WireConnection;24;0;18;0
WireConnection;13;0;25;0
WireConnection;13;1;16;1
WireConnection;13;2;16;2
WireConnection;79;0;78;0
WireConnection;79;1;81;2
WireConnection;0;1;47;0
WireConnection;0;2;50;0
WireConnection;0;3;53;0
WireConnection;0;4;44;0
WireConnection;0;9;88;0
ASEEND*/
//CHKSM=961F61E35D76D477966CFF7271F15FD064C56868