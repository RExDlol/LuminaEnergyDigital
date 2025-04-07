
surface_set_target(hor_surface);
draw_clear_alpha(c_black, 0);
light.update(mouse_x, mouse_y)
light.draw_light(128,0,180,500, 10);
surface_reset_target();


surface_set_target(vert_surface);
draw_clear_alpha(c_black, 0);
shader_set(shHorBlur);
var _blurH = shader_get_uniform(shHorBlur, "u_blurAmount");
shader_set_uniform_f(_blurH, 0.0025);
draw_surface(hor_surface, 0, 0);
shader_reset();
surface_reset_target();

shader_set(shVerBlur);
var _blurV = shader_get_uniform(shVerBlur, "u_blurAmount");
shader_set_uniform_f(_blurV, 0.0025);

gpu_set_blendmode(bm_add);
draw_surface(vert_surface, 0, 0);
gpu_set_blendmode(bm_normal);

shader_reset();