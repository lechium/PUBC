/*
 
 MOVE_None: inside any vehicle, no matter the seat (boat, car, bike, etc)
 MOVE_Walking: any type of on ground movement. sprinting, normal walking, etc
 MOVE_NavWalking: doesnt seem to be used
 MOVE_Falling: jumping/falling
 MOVE_Swimming: swimming
 MOVE_Flying: parachuting
 MOVE_Custom & MOVE_Max: doesnt seem to be used
 
 */

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
#ifdef __cplusplus
extern "C" {
    /* ph = "PubgHook". This way, it's easier to see the function's origin */
    void ph_initialize(void);
    movetype_t ph_get_move_type(void);
    int ph_get_is_aimed_down_sights(void);
};
#endif
#endif
