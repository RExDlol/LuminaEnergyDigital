if (!surface_exists(shadow_surface)) {
    shadow_surface = surface_create(room_width, room_height);
}

surface_set_target(shadow_surface);
draw_clear_alpha(c_black, 0);


gpu_set_blendmode(bm_add);

gpu_set_blendmode(bm_normal);

surface_reset_target();


draw_surface(shadow_surface, 0, 0);