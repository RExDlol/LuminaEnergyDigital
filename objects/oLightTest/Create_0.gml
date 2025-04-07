var preset = global.light_presets.torch;

light = new Light(0,0, preset.radius, preset.intensity, preset.color, oWall, preset.duration);
light.set_candle_type("none")
light.set_shadow_type("cone")

hor_surface = surface_create(display_get_gui_width(), display_get_gui_height());
vert_surface = surface_create(display_get_gui_width(), display_get_gui_height());