//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "VungleSDKDelegate.h"

@class NSMutableArray, NSString;

@interface VungleRouter : NSObject <VungleSDKDelegate>
{
    _Bool _isInitialising;	// 8 = 0x8
    NSMutableArray *_delegates;	// 16 = 0x10
    id <VungleDelegate> _playingDelegate;	// 24 = 0x18
}

+ (id)findPlacement:(id)arg1 networkExtras:(id)arg2;	// IMP=0x0000000100a871ec
+ (void)parseServerParameters:(id)arg1 networkExtras:(id)arg2 result:(CDUnknownBlockType)arg3;	// IMP=0x0000000100a87044
+ (id)sharedInstance;	// IMP=0x0000000100a86d30
+ (id)adapterVersion;	// IMP=0x0000000100a86d04
@property(retain) id <VungleDelegate> playingDelegate; // @synthesize playingDelegate=_playingDelegate;
@property(retain) NSMutableArray *delegates; // @synthesize delegates=_delegates;
@property(readonly) _Bool isInitialising; // @synthesize isInitialising=_isInitialising;
- (void).cxx_destruct;	// IMP=0x0000000100a87e8c
- (void)vungleSDKDidInitialize;	// IMP=0x0000000100a87da0
- (void)vungleAdPlayabilityUpdate:(_Bool)arg1 placementID:(id)arg2 error:(id)arg3;	// IMP=0x0000000100a87cf4
- (void)vungleDidCloseAdWithViewInfo:(id)arg1 placementID:(id)arg2;	// IMP=0x0000000100a87c2c
- (void)vungleWillCloseAdWithViewInfo:(id)arg1 placementID:(id)arg2;	// IMP=0x0000000100a87b64
- (void)vungleWillShowAdForPlacementID:(id)arg1;	// IMP=0x0000000100a87b44
- (void)initialized:(_Bool)arg1 error:(id)arg2;	// IMP=0x0000000100a879d0
- (_Bool)playAd:(id)arg1 delegate:(id)arg2 extras:(id)arg3;	// IMP=0x0000000100a875f8
- (void)loadAd:(id)arg1;	// IMP=0x0000000100a87554
- (void)notifyAdIsReady:(id)arg1;	// IMP=0x0000000100a873d4
- (void)removeDelegate:(id)arg1;	// IMP=0x0000000100a87368
- (void)addDelegate:(id)arg1;	// IMP=0x0000000100a872fc
- (void)initWithAppId:(id)arg1;	// IMP=0x0000000100a86e64
- (id)init;	// IMP=0x0000000100a86db0

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

