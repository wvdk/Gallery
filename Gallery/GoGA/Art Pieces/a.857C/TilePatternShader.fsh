//
//  TilePatternShader.fsh
//  GoGA
//
//  Created by Kristina Gelzinyte on 3/18/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

#define PI 3.14159265358979323846
#define lineNumber 24
#define columnNumber 10

float indexFor(float _st, float _number) {
    float totalIndex = 0;
    float number = _number;
    
    while (number > 0) {
        if (floor(_st / number) == 1) {
            return number;
        }
        number -= 1;
    }
    return totalIndex;
}

float time(float _time) {
    if ((_time / lineNumber) > 1) {
        _time -= lineNumber * floor(_time / lineNumber);
    }
    
    return indexFor(_time, lineNumber);
}

float tileComponent(float _st, float _zoom) {
    _st *= _zoom;
    return _st;
}

vec3 changeColor(float _index) {
    vec3 color = vec3(.0);
    
    //    if (_index == .0) {
    //        color = vec3(1., .0, .0);
    //
    //    } else if (_index == 1.) {
    //        color = vec3(.0, 1., .0);
    //
    //    } else if (_index == 2.) {
    //        color = vec3(.0, .0, 1.);
    //
    //    } else if (_index == 3.) {
    //        color = vec3(1., .0, 1.);
    //
    //    } else if (_index == 4.0) {
    //        color = vec3(.1, 0.9, 0.9);
    //    }
    
    return color;
}

float box(vec2 _st, vec2 _size) {
    _size = vec2(0.5) - _size * 0.5;
    vec2 uv = smoothstep(_size, _size + vec2(1e-4), _st);
    uv *= smoothstep(_size, _size + vec2(1e-4), vec2(1.0) - _st);
    return uv.x * uv.y;
}

vec3 colorFor(float column, float row, float _time) {
    if (row == time(_time)) {
        return changeColor(column);
    } else {
        return vec3(1.0);
    }
}

void main (void) {
    vec2 iResolution = a_sprite_size.xy;
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    vec3 color = vec3(0.);
    
    // Pattern - x.
    st.x = tileComponent(st.x, columnNumber);
    float macroIndexX = indexFor(st.x, columnNumber);
    
    // Pattern - y.
    st.y = tileComponent(st.y, lineNumber);
    float macroIndexY = indexFor(st.y, lineNumber);
    
    st = fract(st);
    
    // Pattern - y.
    st.y = tileComponent(st.y, 4);
    float microIndexY = indexFor(st.y, lineNumber);
    
    st = fract(st);
    
    // Draws boxes.
    float boxDesign = box(st, vec2(0.8, 0.8));
    float smallBoxDesign = box(st, vec2(0.2, 1));
    
    // Changes color.
    if (boxDesign == 1) {
        color = colorFor(macroIndexX, microIndexY * 4, u_time * (macroIndexX + 1));
        
        if (smallBoxDesign == 1) {
            if (microIndexY == 1) {
                color *= colorFor(macroIndexX, macroIndexY + microIndexY, u_time * (macroIndexX + 1)) * vec3(0.9, 0.6, 0.9);
            }
        }
    }
    
    gl_FragColor = vec4(color, 1.0);
}
