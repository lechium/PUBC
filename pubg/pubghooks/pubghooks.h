#ifndef _PUBG_HOOKS_H_
#define _PUBG_HOOKS_H_

typedef enum {
    MOVE_None = 0,
    MOVE_Walking,
    MOVE_NavWalking,
    MOVE_Falling,
    MOVE_Swimming,
    MOVE_Flying,
    MOVE_Custom,
    MOVE_Max
} movetype_t;

extern "C" {
    /* ph = "PubgHook". This way, it's easier to see the function's origin */
    void ph_initialize(void);
    movetype_t ph_get_move_type(void);
    int ph_get_is_aimed_down_sights(void);
};

#endif
