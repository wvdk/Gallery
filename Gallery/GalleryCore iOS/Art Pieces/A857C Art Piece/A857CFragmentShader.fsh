//
//  A857CFragmentShader.fsh
//  Gallery
//
//  Created by Kristina Gelzinyte on 3/18/18.
//  Copyright © 2018 Gallery. All rights reserved.
//

#define PI 3.14159265358979323846
#define lineNumber 24
#define columnNumber 10

float indexFor(float _fragmentCoord, float _number) {
    float totalIndex = 0;
    float number = _number;
    
    while (number > 0) {
        if (floor(_fragmentCoord / number) == 1) {
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

float tileComponent(float _fragmentCoord, float _scale) {
    _fragmentCoord *= _scale;
    return _fragmentCoord;
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

vec3 colorFor(float column, float row, float _time) {
    if (row == time(_time)) {
        return changeColor(column);
    } else {
        return vec3(1.0);
    }
}

float box(vec2 _fragmentCoord, vec2 _size) {
    _size = vec2(0.5) - _size * 0.5;
    vec2 uv = smoothstep(_size, _size + vec2(1e-4), _fragmentCoord);
    uv *= smoothstep(_size, _size + vec2(1e-4), vec2(1.0) - _fragmentCoord);
    return uv.x * uv.y;
}

void main (void) {
    vec2 size = a_sprite_size.xy;
    vec2 fragmentCoord = gl_FragCoord.xy / size.xy;
    vec3 color = vec3(0.);
    
    // Pattern - x.
    fragmentCoord.x = tileComponent(fragmentCoord.x, columnNumber);
    float macroIndexX = indexFor(fragmentCoord.x, columnNumber);
    
    // Pattern - y.
    fragmentCoord.y = tileComponent(fragmentCoord.y, lineNumber);
    float macroIndexY = indexFor(fragmentCoord.y, lineNumber);
    
    // Sets fragment coordinate to the fracture part of fragment cooridnate value.
    fragmentCoord = fract(fragmentCoord);
    
    // Pattern - y.
    fragmentCoord.y = tileComponent(fragmentCoord.y, 4);
    float microIndexY = indexFor(fragmentCoord.y, lineNumber);
    
    // Sets fragment coordinate to the fracture part of fragment cooridnate value.
    fragmentCoord = fract(fragmentCoord);
    
    // Draws boxes.
    float boxDesign = box(fragmentCoord, vec2(0.8, 0.8));
    float smallBoxDesign = box(fragmentCoord, vec2(0.2, 1));
    
    // Changes color.
    if (boxDesign == 1) {
        color = colorFor(macroIndexX, microIndexY * 4, u_time * (macroIndexX + 1));
        
        if (smallBoxDesign == 1) {
            if (microIndexY == 1) {
                color *= colorFor(macroIndexX, macroIndexY + microIndexY, u_time * (macroIndexX + 1)) * vec3(0.9, 0.6, 0.9);
            }
        }
    }
    
    // Sets color
    gl_FragColor = vec4(color, 1.0);
}
