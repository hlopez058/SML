
float4		bounds;
float2		screen;

float2		size;
float4		bg_color;
float4		border_color;
float4		border_width;
float4		radius;

Texture2D   bg_texture;
sampler bg_sampler = sampler_state
{
	Texture = <bg_texture>;
	FILTER = MIN_MAG_MIP_LINEAR;
	AddressU = Wrap;
	AddressV = Wrap;
};

struct VS_INPUT
{
	float4 pos		: POSITION0;
	float2 tex		: TEXCOORD0;
};

struct PS_INPUT
{
	float4 pos		: POSITION0;
	float2 tex		: TEXCOORD0;
};

PS_INPUT mainVS(VS_INPUT input)
{
	PS_INPUT output;

	output.pos = float4(2 * (lerp(bounds.xy, bounds.zw, input.pos.xy) + 0.5) / screen.xy - 1, 0, 1);
	output.pos.y = -output.pos.y;

	output.tex.x = input.tex.x;
	output.tex.y = input.tex.y;

	return output;
}

float4 BackgroundBorderRoundingPS(PS_INPUT input) : COLOR
{
	float4 pos = float4(input.tex * size, (1 - input.tex) * size);

	//if (pos.x < 2 || pos.y < 2 || pos.z < 2 || pos.w < 2)
	//	return float4(1, 0, 0, 1);

	float4 dis = sqrt(float4(
		dot(sqrt(pos.xy), 1), dot(sqrt(pos.zy), 1),
		dot(sqrt(pos.xw), 1), dot(sqrt(pos.zw), 1)) * rsqrt(radius));

	// Cull corners
	clip(dis - 1);

	float4 bg_image = tex2D(bg_sampler, input.tex);

	// Side Borders
	if (pos.x < border_width.x || pos.y < border_width.y || pos.z < border_width.z || pos.w < border_width.w)
		return lerp(bg_image, border_color, border_color.a) * float4(1, 1, 1, bg_color.a);

	float4 posB = pos - border_width;
	float4 disB = sqrt(float4(
		dot(sqrt(posB.xy), 1), dot(sqrt(posB.zy), 1),
		dot(sqrt(posB.xw), 1), dot(sqrt(posB.zw), 1)) * rsqrt(radius));

	// Corner Borders
	if (disB.x < 1 || disB.y < 1 || disB.z < 1 || disB.w < 1)
		return lerp(bg_image, border_color, border_color.a) * float4(1, 1, 1, bg_color.a);

	// Center
	return bg_color * bg_image;
}

float4 BackgroundBorderPS(PS_INPUT input) : COLOR
{
	float4 pos = float4(input.tex * size, (1 - input.tex) * size);

	float4 bg_image = tex2D(bg_sampler, input.tex);

	// Side Borders
	if (pos.x < border_width.x || pos.y < border_width.y || pos.z < border_width.z || pos.w < border_width.w)
		return lerp(bg_image, border_color, border_color.a) * float4(1, 1, 1, bg_color.a);

	// Center
	return bg_color * bg_image;
}

technique BackgroundBorderRounding
{
	pass FirstPass
	{
		vertexShader = compile vs_3_0 mainVS();
		pixelShader = compile ps_3_0 BackgroundBorderRoundingPS();

		AlphaBlendEnable = TRUE;
		SrcBlend = SRCALPHA;
		DestBlend = INVSRCALPHA;
		FillMode = SOLID;
		CullMode = NONE;
	}
}

technique BackgroundBorder
{
	pass FirstPass
	{
		vertexShader = compile vs_3_0 mainVS();
		pixelShader = compile ps_3_0 BackgroundBorderPS();

		AlphaBlendEnable = TRUE;
		SrcBlend = SRCALPHA;
		DestBlend = INVSRCALPHA;
		FillMode = SOLID;
		CullMode = NONE;
	}
}