/* ---------------------------------------------------
 * LeDLets, the lightweight package creator for LeD
 * ---------------------------------------------------
 */

/* ===================================================
 * Atributtes:
 * Basics Properties:
 *      x, (not intended to use)
 *      y, (not intended to use)
 *      radius ; real < 360
 *      intensity ; real
 *      color ; constants.colors
 * 
 * Candle Vars:
 *      pulse_speed ; array/real
 *      candle_type ; string
 *      pulse_pahse ; int
 * 
 * Lifetime:
 *      (if set_life is called) 
 *      duration; real
 *      fade_time ; real (0-1)
 * Shadow:
 *      shadow_type ; string
 */

global.light_presets = {
    torch: {
        radius: 200,
        intensity: 1,
        color: c_orange,
        candle_type: "torch",
        shadow_type: "candle+hard",
        pulse_speed: [1.0, 2.0],
        fade_time: 20,
        duration: 120,
    },
    lantern: {
        radius: 150,
        intensity: 0.8,
        color: make_color_rgb(255, 255, 200),
        candle_type: "soft",
        shadow_type: "soft",
        pulse_speed: [0.3, 0.6],
        fade_time: 15,
    },
    spotlight: {
        radius: 300,
        intensity: 1.0,
        color: c_white,
        candle_type: "none",
        shadow_type: "cone",
        pulse_speed: [0.3, 0.6],
        fade_time: 10,
    },
    ambient: {
        radius: 500,
        intensity: 0.5,
        color: make_color_rgb(100, 150, 255),
        candle_type: "none",
        shadow_type: "none",
        fade_time: 5,
    },
    candle: {
        radius: 120,
        intensity: 0.7,
        color: make_color_rgb(255, 200, 100),
        candle_type: "candle",
        shadow_type: "candle",
        pulse_speed: [0.8, 1.5],
        fade_time: 30,
    },
};
