half3 RGBtoHSV(float3 clr) {
	half3 HSV = 0; // 0,0,0 implicit
	// Component Max of RGB Color (Obtain highest component)
	HSV.z = max(clr.r, max(clr.g, clr.b)); 
	// Component Min (Possibly optmize both into component SLT?)
	float M = min(clr.r, min(clr.g, clr.b));
	float C = HSV.z - M; // Chroma
	
	if (C != 0) { // Neccassery? I think it only prevents banding on certain hardware
		HSV.y = C / HSV.z; // Chroma over Value
		float3 Delta =  (HSV.z - clr) / C; // Allot of RCP Chroma, optmize?
		Delta.rgb -= Delta.brg; // I dunno, at this point I'm going by the example
		Delta.rg += float2(2,4); // Push it into the color hexagon
		if (clr.r >= HSV.z)
			HSV.x = Delta.b; 
		else if (clr.g >= HSV.z)
			HSV.x = Delta.r;
		else 
			HSV.x = Delta.g;
		HSV.x = frac(HSV.x / 6);
	}
	
	return HSV; 
}

half3 Hue(half h) {
	half R = abs((h * 6) - 3) - 1;
	half G = 2 - abs((h * 6) - 2);
	half B = 2 - abs((h * 6) - 4);
	return saturate(float3(R,G,B));
}

half3 HSVToRGB(half3 hsv) {
	hsv = saturate(hsv);
	return ((Hue(hsv.x) - 1) * hsv.y + 1) * hsv.z;
}

half4 _AWght;
half4 _BWght;
half4 _CWght;
sampler2D _Mask;

half3 ApplyWeights(half3 clr, half3 Mask) {
	half3 HSV = RGBtoHSV(clr);
	
	half3 ASet = HSV + _AWght; ASet.x = _AWght;
	ASet.z = _AWght.z * HSV.z;
	half3 BSet = HSV + _BWght; BSet.x = _BWght;
	BSet.z = _BWght.z * HSV.z;
	half3 CSet = HSV + _CWght; CSet.x = _CWght;
	CSet.z = _CWght.z * HSV.z;
	
	clr = lerp(clr, HSVToRGB(ASet), Mask.r * _AWght.a);
	clr = lerp(clr, HSVToRGB(BSet), Mask.g * _BWght.a);
	clr = lerp(clr, HSVToRGB(CSet), Mask.b * _CWght.a);
	return clr;
}