/*// https://stackoverflow.com/questions/13501081/efficient-bicubic-filtering-code-in-glsl
// from http://www.java-gaming.org/index.php?topic=35123.0
vec4 cubic(float v){
    vec4 n = vec4(1.0, 2.0, 3.0, 4.0) - v;
    vec4 s = n * n * n;
    float x = s.x;
    float y = s.y - 4.0 * s.x;
    float z = s.z - 4.0 * s.y + 6.0 * s.x;
    float w = 6.0 - x - y - z;
    return vec4(x, y, z, w) * (1.0/6.0);
}

vec4 textureBicubic(sampler2D sampler, vec2 texCoords){

    vec2 texSize = textureSize(sampler, 0);
    vec2 invTexSize = 1.0 / texSize;

    texCoords = texCoords * texSize - 0.5;


    vec2 fxy = fract(texCoords);
    texCoords -= fxy;

    vec4 xcubic = cubic(fxy.x);
    vec4 ycubic = cubic(fxy.y);

    vec4 c = texCoords.xxyy + vec2 (-0.5, +1.5).xyxy;

    vec4 s = vec4(xcubic.xz + xcubic.yw, ycubic.xz + ycubic.yw);
    vec4 offset = c + vec4 (xcubic.yw, ycubic.yw) / s;

    offset *= invTexSize.xxyy;

    vec4 sample0 = texture(sampler, offset.xz);
    vec4 sample1 = texture(sampler, offset.yz);
    vec4 sample2 = texture(sampler, offset.xw);
    vec4 sample3 = texture(sampler, offset.yw);

    float sx = s.x / (s.x + s.y);
    float sy = s.z / (s.z + s.w);

    return mix(
    mix(sample3, sample2, sx), mix(sample1, sample0, sx)
    , sy);
}

// https://github.com/h33p/Unity-Graphics-Demo/blob/master/Assets/Asset%20Store/PostProcessing/Resources/Shaders/ColorGrading.cginc#L271
vec3 ApplyLut2d(sampler2D tex, vec3 uvw) {
    vec2 texSize = vec2(textureSize(tex, 0).xy);
    vec3 scaleOffset = vec3(1 / texSize.x, 1 / texSize.y, texSize.y - 1);
    //vec3 scaleOffset = vec3(1 / 16.0f, 1 / 1.0f, 1.0f - 1);
    // Strip format where `height = sqrt(width)`
    uvw.z *= scaleOffset.z;
    float shift = floor(uvw.z);
    uvw.xy = uvw.xy * scaleOffset.z * scaleOffset.xy + scaleOffset.xy * 0.5;
    uvw.x += shift * scaleOffset.y;
    // invert texcoord y-axis origin for GLSL
    uvw.y = 1.0f - uvw.y;
    uvw.xyz = mix(texture(tex, uvw.xy).rgb, texture(tex, uvw.xy + vec2(scaleOffset.y, 0)).rgb, uvw.z - shift);
    return uvw;
}*/

vec3 ApplyZZZLut(sampler2D tex, vec3 uvw) {
    vec3 upperBound = vec3(1.0f), lowerBound = vec3(1.0f);

    upperBound.xyz = clamp(log2(uvw.zxy * 5.55556f + 0.047996f) * 0.0735f + 0.386036f, vec3(0.0f), vec3(1.0f));

    float foo = upperBound.x * 31.0f;

    upperBound.xyz *= 31.0f;

    float bar = floor(upperBound.x);

    upperBound.x = upperBound.y * 0.00098f + (0.00098f * 0.5f);
    upperBound.y = upperBound.z * 0.03125f + (0.03125f * 0.5f);
    upperBound.z = 0.0f;

    foo -= bar;

    upperBound.zy = upperBound.yx;
    upperBound.x = bar * 0.03125f + upperBound.x;
    upperBound.y = 0.0f;

    lowerBound = upperBound;
    lowerBound.y = lowerBound.z;
    lowerBound.z = 0.0f;

    upperBound.y = upperBound.z;
    upperBound.z = 0.0f;
    upperBound.x += 0.03125f;

    // invert texcoord y-axis origins for GLSL
    upperBound.y = 1.0f - upperBound.y;
    lowerBound.y = 1.0f - lowerBound.y;

    vec3 a = texture(tex, upperBound.xy).xyz, b = texture(tex, lowerBound.xy).xyz;

    return mix(b, a, foo);
}

void main() {
    vec4 input = texture(inLayer, uv);

    // preserve alpha
    outColor.w = input.w;
    outColor.xyz = mix(input.xyz, ApplyZZZLut(layer[0], input.xyz), slider[0]);
}
