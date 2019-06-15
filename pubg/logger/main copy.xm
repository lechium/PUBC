#import <Foundation/Foundation.h>
#include <mach-o/dyld.h>
#import <objc/runtime.h>

#import <Foundation/Foundation.h>
#include <CoreFoundation/CoreFoundation.h>
#include <IOKit/hid/IOHIDUserDevice.h>
#include <IOKit/hid/IOHIDUsageTables.h>
#include <IOKit/hid/IOHIDKeys.h>
#include <IOKit/hid/IOHIDUserDevice.h>
#include <IOKit/hid/IOHIDBase.h>
#include <stdio.h>
#include <string.h>
#include <pthread.h>
#include <AssertMacros.h>

typedef struct __IOHIDManager * IOHIDManagerRef;
typedef struct __IOHIDServiceClient* IOHIDServiceClientRef;

%hook _GCMFiGamepadControllerProfile
- (unsigned long long )hash { %log; unsigned long long  r = %orig; HBLogDebug(@" = %llu", r); return r; }
- (Class )superclass { %log; Class  r = %orig; HBLogDebug(@" = %@", r); return r; }
- (NSString * )description { %log; NSString *  r = %orig; HBLogDebug(@" = %@", r); return r; }
- (NSString * )debugDescription { %log; NSString *  r = %orig; HBLogDebug(@" = %@", r); return r; }
-(id)initWithCoder:(id)arg1  { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
-(id)name { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
-(id)motion { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
-(void)setPlayerIndex:(long long)arg1  { %log; %orig; }
-(id)menuButton { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
-(id)inputForElement:(IOHIDElementRef)arg1  { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
-(void)set_motion:(id)arg1  { %log; %orig; }
-(void)toggleSuspendResume { %log; %orig; }
-(id)initWithController:(id)arg1  { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
%end
%hook _GCMFiExtendedGamepadControllerProfile
- (unsigned long long )hash { %log; unsigned long long  r = %orig; HBLogDebug(@" = %llu", r); return r; }
- (Class )superclass { %log; Class  r = %orig; HBLogDebug(@" = %@", r); return r; }
- (NSString * )description { %log; NSString *  r = %orig; HBLogDebug(@" = %@", r); return r; }
- (NSString * )debugDescription { %log; NSString *  r = %orig; HBLogDebug(@" = %@", r); return r; }
-(id)initWithCoder:(id)arg1  { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
-(id)name { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
-(id)motion { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
-(void)setPlayerIndex:(long long)arg1  { %log; %orig; }
-(id)menuButton { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
-(void)set_motion:(id)arg1  { %log; %orig; }
-(void)toggleSuspendResume { %log; %orig; }
-(id)initWithController:(id)arg1  { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
%end
%hook _GCControllerManager

- (unsigned long long )hash { %log; unsigned long long  r = %orig; HBLogDebug(@" = %llu", r); return r; }
- (Class )superclass { %log; Class  r = %orig; HBLogDebug(@" = %@", r); return r; }
- (NSString * )description { %log; NSString *  r = %orig; HBLogDebug(@" = %@", r); return r; }
- (NSString * )debugDescription { %log; NSString *  r = %orig; HBLogDebug(@" = %@", r); return r; }
-(id)controllers { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
-(id)init { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
-(void)dealloc { %log; %orig; }
-(NSXPCConnection *)connection { %log; NSXPCConnection * r = %orig; HBLogDebug(@" = %@", r); return r; }
-(void)setConnection:(NSXPCConnection *)arg1  { %log; %orig; }
-(void)open { %log; %orig; }
-(void)addController:(id)arg1  { %log; %orig; }
-(void)controllerWithUDID:(unsigned long long)arg1 setData:(id)arg2  { %log; %orig; }
-(void)controllerWithUDID:(unsigned long long)arg1 setValue:(float)arg2 forElement:(int)arg3  { %log; %orig; }
-(void)microControllerWithDigitizerX:(float)arg1 withY:(float)arg2 withTimeStamp:(unsigned long long)arg3 touchDown:(BOOL)arg4  { %log; %orig; }
-(void)microControllerWithUDID:(unsigned long long)arg1 setDigitizerX:(float)arg2 digitizerY:(float)arg3 withTimeStamp:(unsigned long long)arg4 touchDown:(BOOL)arg5  { %log; %orig; }
-(void)replyConnectedHosts:(id)arg1  { %log; %orig; }
-(id)remote { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
-(void)setRemote:(id)arg1  { %log; %orig; }
-(void)removeController:(id)arg1  { %log; %orig; }
-(BOOL)isAppInBackground { %log; BOOL r = %orig; HBLogDebug(@" = %d", r); return r; }
-(NSObject*)controllersQueue { %log; NSObject* r = %orig; HBLogDebug(@" = %@", r); return r; }
-(void)launchHIDInputThread { %log; %orig; }
-(void)stopHIDDeviceMonitor { %log; %orig; }
-(void)updateControllerWithEvent:(id)arg1  { 
    %log; 
    NSLog(@"Stack trace : %@",[NSThread callStackSymbols]);
    %orig; 
    }
-(void)addControllerWithServiceRef:(IOHIDServiceClientRef)arg1  { %log; %orig; }
-(void)removeControllerWithServiceRef:(IOHIDServiceClientRef)arg1  { %log; %orig; }
-(id)firstMicroGamepad { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
-(void)controller:(id)arg1 setValue:(float)arg2 forElement:(int)arg3  { %log; %orig; }
-(void)setIdleTimerNeedsReset:(BOOL)arg1  { %log; %orig; }
-(NSMutableArray *)hidThreadExecutionBlocks { %log; NSMutableArray * r = %orig; HBLogDebug(@" = %@", r); return r; }
-(void)threadHIDInputOnMain:(id)arg1  { %log; %orig; }
-(void)stopHIDEventMonitor { %log; %orig; }
-(void)setMediaRemoteEnabled:(BOOL)arg1  { %log; %orig; }
-(void)async_HIDBlock:(/*^block*/id)arg1  { %log; %orig; }
-(void)startHIDDeviceMonitor { %log; %orig; }
-(void)addConnectedDevices { %log; %orig; }
-(void)startHIDEventMonitor { %log; %orig; }
-(BOOL)isPhysicalB239:(id)arg1  { %log; BOOL r = %orig; HBLogDebug(@" = %d", r); return r; }
-(void)updateIdleTimer:(id)arg1  { %log; %orig; }
-(void)controllerWithUDID:(unsigned long long)arg1 setValue0:(float)arg2 setValue1:(float)arg3 setValue2:(float)arg4 setValue3:(float)arg5 forElement:(int)arg6  { %log; %orig; }
-(void)startIdleWatchTimer { %log; %orig; }
-(void)threadHIDInputOffMain:(id)arg1  { %log; %orig; }
-(void)requestConnectedHostsWithHandler:(/*^block*/id)arg1  { %log; %orig; }
-(BOOL)isExistingController:(id)arg1  { %log; BOOL r = %orig; HBLogDebug(@" = %d", r); return r; }
-(IOHIDManagerRef)hidManager { %log; IOHIDManagerRef r = %orig; HBLogDebug(@" = %@", r); return r; }
-(void)setHidManager:(IOHIDManagerRef)arg1  { %log; %orig; }
-(BOOL)idleTimerNeedsReset { %log; BOOL r = %orig; HBLogDebug(@" = %d", r); return r; }
-(NSThread *)hidInputThread { %log; NSThread * r = %orig; HBLogDebug(@" = %@", r); return r; }
-(CFRunLoopRef)hidInputThreadRunLoop { %log; CFRunLoopRef r = %orig; HBLogDebug(@" = %@", r); return r; }
-(CFRunLoopSourceRef)hidThreadRunLoopSource { %log; CFRunLoopSourceRef r = %orig; HBLogDebug(@" = %@", r); return r; }
-(void)CBApplicationWillResignActive { %log; %orig; }
-(void)CBApplicationDidBecomeActive { %log; %orig; }
-(id)logger { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
-(void)setLogger:(id)arg1  { %log; %orig; }
%end
%hook IapHIDDescriptor
- (id)dequeueOutReport { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
- (void)queueOutReport:(id)arg1 { %log; %orig; }
- (_Bool)areOutReportsAvailable { %log; _Bool r = %orig; HBLogDebug(@" = %d", r); return r; }
- (_Bool)handleOutReport:(char *)arg1 withLength:(long long)arg2 { %log; _Bool r = %orig; HBLogDebug(@" = %d", r); return r; }
- (_Bool)handleInReport:(char *)arg1 withLength:(unsigned int)arg2 { %log; _Bool r = %orig; HBLogDebug(@" = %d", r); return r; }
- (void)dealloc { %log; %orig; }
- (id)initWithReportIndex:(unsigned char)arg1 andVID:(unsigned short)arg2 andPID:(unsigned short)arg3 andCountryCode:(unsigned char)arg4 andTransport:(struct IPodTransport *)arg5 andHIDDescriptor:(id)arg6 { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
- (id)init { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
%end
