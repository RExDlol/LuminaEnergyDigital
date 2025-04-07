global.lights = []

// js doc brabo kkkkkkkkk
///@func Light(x, y, radius, intensity, color,collision, duration, fade_time)
function Light(_x, _y, _radius, _intensity, _color,_collision, _duration = -1, _fade_time = 20) constructor {

    
    x = _x;
    y = _y;
    radius = _radius;
    color = _color;
    intensity = _intensity;
    base_intensity = clamp(_intensity, 0, 1);
    
    
    duration = _duration;
    fade_time = _fade_time;
    static age = 0;
    dying = false;
    
    
    candle_type = "none";
    pulse_speed = 1;
    pulse_phase = random(1000);
    
    
    center_x = _x;
    center_y = _y;
    
    
    
    shadow_type = "none";
    
    collision = _collision;
    function update(__x, __y) {
        x = __x;
        y = __y;
    }
    
    function set_life() {
        if (duration != -1) {
            age++;
            if (age >= duration) {
                dying = true;
            }
        }
    }

    function draw_candle() {
        var pulse = 1;
        switch (candle_type) {
            case "candle":
                pulse = 0.5 + 0.3 * sin(current_time * 0.001 * pulse_speed + pulse_phase);
                break;
            case "torch":
                pulse = 0.6 + random_range(-0.1, 0.2);
                break;
            case "soft":
                pulse = 0.8 + 0.1 * sin(current_time * 0.001 * pulse_speed);
                break;
            case "none":
                pulse = base_intensity;
                break;
            
        }
            
        if (dying) intensity = lerp(intensity, 0, 1 / fade_time);
        else intensity = pulse;
        
        
            
        draw_set_alpha(1);
        draw_set_color(c_white);
    }
    
    function draw_shadow_cone(_num_rays, _dir, _fov, _max_dist, _opt) {
        if (dying) intensity = lerp(intensity, 0, 1 / fade_time);
        _num_rays ??= 32;
        _dir ??= 0;
        _fov ??= 90;
        _max_dist ??= 100;
        var angle_start = (_dir - _fov * 0.5 + 360) mod 360;
        var angle_step = _fov / _num_rays;
        var max_dist = radius
        var step = 2;
        
        var points = [];
        
        for (var i = 0; i <= _num_rays; i+=_opt) {
            var ang = (angle_start + angle_step * i) mod 360;
            
            var px = x;
            var py = y;
            
            for (var d = 0; d < max_dist; d += step) {
                px = x + lengthdir_x(d, ang);
                py = y + lengthdir_y(d, ang);
                
                
                
                if (collision_point(px, py, collision, false, true)) {
                    break;
                }
            }
            
            array_push(points, [px, py]);
        }
        
        draw_set_color(color);
        draw_set_alpha(intensity);
        
        for (var i = 0; i < array_length(points) - 1; i++) {
            var p1 = points[i];
            var p2 = points[i + 1];
            
            draw_primitive_begin(pr_trianglestrip);
            draw_vertex(x, y);
            draw_vertex(p1[0], p1[1]);
            draw_vertex(p2[0], p2[1]);
            draw_primitive_end();
        }
        
        draw_set_alpha(1);
        draw_set_color(c_white);
    }
    
    function draw_shadow_circ(_num_rays, _opt) {
        if (dying) intensity = lerp(intensity, 0, 1 / fade_time);
        var pulse = 1;
        switch (candle_type) {
            case "candle":
                pulse = 0.5 + 0.3 * sin(current_time * 0.001 * pulse_speed + pulse_phase);
                break;
            case "torch":
                pulse = 0.6 + random_range(-0.1, 0.2);
                break;
            case "soft":
                pulse = 0.8 + 0.1 * sin(current_time * 0.001 * pulse_speed);
                break;
            case "none":
                pulse = base_intensity;
                break;
            
        }
        if (_num_rays == undefined) return;
        
        var angle_step = 360 / _num_rays;
        var max_dist = radius;
        var step_size = 2;
        var points = [];
        
        
        
        for (var i = 0; i < _num_rays; i+=_opt) {
            var ang = i * angle_step;
            var ray_x = x;
            var ray_y = y;
            
            for (var d = 0; d < max_dist; d += step_size) {
                var px = x + lengthdir_x(d, ang);
                var py = y + lengthdir_y(d, ang);
                if (collision_point(px, py, oWall, false, true)) {
                    ray_x = px;
                    ray_y = py;
                    break;
                }
            }
            
            if (ray_x == x && ray_y == y) {
                ray_x = x + lengthdir_x(max_dist, ang);
                ray_y = y + lengthdir_y(max_dist, ang);
            }
            
            array_push(points, [ray_x, ray_y]);
        }
            
        draw_set_alpha(intensity * pulse)
        draw_set_color(color);
        for (var i = 0; i < array_length(points); i++) {
            var p1 = points[i];
            var p2 = points[(i + 1) mod array_length(points)];
            
            draw_primitive_begin(pr_trianglestrip);
            draw_vertex(x, y);
            draw_vertex(p1[0], p1[1]);
            draw_vertex(p2[0], p2[1]);
            draw_primitive_end();
        }
        
        draw_set_alpha(1);
    }
    
    ///@param {Real} Rays
    ///@param {Real} [arg1]
    ///@param {Real} [arg2]
    ///@param {Real} [arg3]
    ///@param {Real} [arg4]
    function draw_light(_num_rays = 128, _arg1, _arg2, _arg3, _arg4) {
        if (_num_rays > 360) {
            show_debug_message("LeD: The number of Rays is greater than 360, rounding to 360 (not recomendable)")
            _num_rays = 360
        }
        switch (shadow_type) {
            case "candle":
                draw_candle(); 
                
                break;
            case "circ":
                draw_shadow_circ(_num_rays, _arg1);
                
                break;
            case "candle+circ":
                draw_shadow_circ(_num_rays, _arg1);
                draw_candle();
                
                break;
            case "none":
                draw_set_color(color);
                draw_set_alpha(intensity);
                draw_circle(x, y, radius, false);
                draw_set_alpha(1);
                
                break;
            case "cone":
                draw_shadow_cone(_num_rays, _arg1, _arg2, _arg3, _arg4)
                break;
            default:
                show_error("\n\nLeD Error. Please inform a shadow type with set_shadow_type method. Check wiki for full list.\n\n", true)
        }
    }

    // setters
    function set_candle_type(_type) { candle_type = _type ?? "none"; }
    function set_shadow_type(_type) { shadow_type = _type ?? "none"; }
    function set_pulse_speed_range(_range) {
        if (is_array(_range)) {
            pulse_speed = random_range(_range[0], _range[1]);
        }
    }
    function set_circular_motion(_radius, _speed) {
        move_radius = _radius;
        move_speed = _speed;
    }
}

