#include <mach-o/dyld.h>
#include <substrate.h>
#import <Foundation/Foundation.h>

static int MOVE_TYPE_INTERNAL = 0; 
static int IS_AIMED_DOWN_SIGHTS_INTERNAL = 0;
static int IS_PRESSING_FIRE_BUTTON_INTERNAL = 0;
static bool HOOKER_INTERNAL = false;

bool ph_is_hooker(void) {
    return HOOKER_INTERNAL;
}

int ph_get_move_type(void){
    return MOVE_TYPE_INTERNAL;
}

int ph_get_is_aimed_down_sights(void){
    return IS_AIMED_DOWN_SIGHTS_INTERNAL;
}

int ph_get_is_pressing_fire_button(void){
    return IS_PRESSING_FIRE_BUTTON_INTERNAL;
}

static inline int is_local_player(void *obj){
    return (*(char *)((uint64_t)obj + 0x128) == 2);
}

static void *(*sub_101cfe0ac)(void *, float);

static void *_sub_101cfe0ac(void *_this, float arg1){
    if(is_local_player(_this)){
        void *x8 = *(void **)((uint64_t)_this + 0x1500);
        
        if(x8)
            MOVE_TYPE_INTERNAL = *(char *)((uint64_t)x8 + 0x1c4);
    }
    
    return sub_101cfe0ac(_this, arg1);
}

static void (*sub_101caab8c)(void *, char);

static void _sub_101caab8c(void *_this, char arg1){
    IS_AIMED_DOWN_SIGHTS_INTERNAL = *(char *)((uint64_t)_this + 0x114);

    sub_101caab8c(_this, arg1);
}

static void (*sub_101d0086c)(void *);

static void _sub_101d0086c(void *_this){
    sub_101d0086c(_this);
    
    if(!is_local_player(_this))
        return;
    
    void *x8 = *(void **)_this;
    
    if(!x8)
        return;
    
    x8 = *(void **)((uint64_t)x8 + 0x9b0);
    
    if(!x8)
        return;
    
    void *(*x8_fxnptr)(void *) = (void *(*)(void *))x8;
    void *x0 = x8_fxnptr(_this);
    
    if(!x0)
        return;
    
    int w8 = 0x2cb8;
    
    IS_PRESSING_FIRE_BUTTON_INTERNAL = *(char *)((uint64_t)x0 + w8);
}

static void *(*GetEntity)(void *_this) = NULL;

#define HOOK(offset, ptr, orig) \
MSHookFunction((void *)(offset + slide), (void *)ptr, (void **)&orig)

void ph_initialize(void){

    NSString *version = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    NSComparisonResult result
    = [@"0.15.0" compare:version
                    options:NSNumericSearch | NSCaseInsensitiveSearch];
    if (result == NSOrderedSame){
        
        
        
        HOOKER_INTERNAL = true;
        NSLog(@"PUBC: WHAT ARE THOSE, HOOKS? GET OUT OF HERE YA BUNCH OF HOOKERS!");
        uint64_t slide = _dyld_get_image_vmaddr_slide(0);
        
        GetEntity = (void *(*)(void *))(slide + 0x101c62210);
        
        HOOK(0x101cfe0ac, _sub_101cfe0ac, sub_101cfe0ac);
        HOOK(0x101caab8c, _sub_101caab8c, sub_101caab8c);
        HOOK(0x101d0086c, _sub_101d0086c, sub_101d0086c);
    }
    
}
