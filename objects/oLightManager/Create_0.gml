shadow_surface = -1;
xx = 0
yy = 0

var preset = global.light_presets.candle;

new_light = new Light(x, y, preset.radius, preset.intensity, preset.color, -1, preset.fade_time);
new_light.set_shadow_type("hard");
new_light.set_candle_type("soft");
new_light.set_pulse_speed_range(preset.pulse_speed);