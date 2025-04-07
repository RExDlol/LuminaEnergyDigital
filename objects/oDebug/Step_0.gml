if (keyboard_check_pressed(vk_f10)) {
    global.debug = !global.debug;
    show_debug_overlay(global.debug);
} 