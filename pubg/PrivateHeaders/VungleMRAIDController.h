//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "VungleDismissibleContainerViewDelegate.h"
#import "VungleMRAIDBridgeDelegate.h"

@class NSString, UIViewController, VungleCacheManager, VungleDismissibleWebViewContainerView, VungleMRAIDAd, VungleMRAIDBridge, VungleMRAIDViewProperties, VunglePlacement, VungleWebViewFacade;

@interface VungleMRAIDController : NSObject <VungleDismissibleContainerViewDelegate, VungleMRAIDBridgeDelegate>
{
    _Bool _isAdLoading;	// 8 = 0x8
    _Bool _didFinishDisplayingAd;	// 9 = 0x9
    _Bool _isSuccessfulAdView;	// 10 = 0xa
    VungleMRAIDViewProperties *_mraidViewProperties;	// 16 = 0x10
    id <VungleMRAIDControllerDelegate> _delegate;	// 24 = 0x18
    UIViewController *_presenterViewController;	// 32 = 0x20
    VungleWebViewFacade *_webViewFacade;	// 40 = 0x28
    VungleMRAIDAd *_ad;	// 48 = 0x30
    VunglePlacement *_placement;	// 56 = 0x38
    VungleMRAIDBridge *_MRAIDbridge;	// 64 = 0x40
    VungleDismissibleWebViewContainerView *_adContainerView;	// 72 = 0x48
    id <VungleMRAIDReportBuilderProtocol> _reportBuilder;	// 80 = 0x50
    VungleCacheManager *_cacheManager;	// 88 = 0x58
}

@property(nonatomic) __weak VungleCacheManager *cacheManager; // @synthesize cacheManager=_cacheManager;
@property(nonatomic) _Bool isSuccessfulAdView; // @synthesize isSuccessfulAdView=_isSuccessfulAdView;
@property(retain, nonatomic) id <VungleMRAIDReportBuilderProtocol> reportBuilder; // @synthesize reportBuilder=_reportBuilder;
@property(nonatomic) _Bool didFinishDisplayingAd; // @synthesize didFinishDisplayingAd=_didFinishDisplayingAd;
@property(retain, nonatomic) VungleDismissibleWebViewContainerView *adContainerView; // @synthesize adContainerView=_adContainerView;
@property(retain, nonatomic) VungleMRAIDBridge *MRAIDbridge; // @synthesize MRAIDbridge=_MRAIDbridge;
@property(retain, nonatomic) VunglePlacement *placement; // @synthesize placement=_placement;
@property(retain, nonatomic) VungleMRAIDAd *ad; // @synthesize ad=_ad;
@property(nonatomic) _Bool isAdLoading; // @synthesize isAdLoading=_isAdLoading;
@property(retain, nonatomic) VungleWebViewFacade *webViewFacade; // @synthesize webViewFacade=_webViewFacade;
@property(nonatomic) __weak UIViewController *presenterViewController; // @synthesize presenterViewController=_presenterViewController;
@property(nonatomic) __weak id <VungleMRAIDControllerDelegate> delegate; // @synthesize delegate=_delegate;
@property(retain, nonatomic) VungleMRAIDViewProperties *mraidViewProperties; // @synthesize mraidViewProperties=_mraidViewProperties;
- (void).cxx_destruct;	// IMP=0x0000000100af83a4
- (void)handleNativePresentStoreView;	// IMP=0x0000000100af80a4
- (void)handleNativePrepareStoreView:(id)arg1;	// IMP=0x0000000100af8004
- (void)bridge:(id)arg1 handleNativeCommandIsSuccessfulView:(_Bool)arg2;	// IMP=0x0000000100af7f10
- (void)bridge:(id)arg1 handleNativeCommandTPATKey:(id)arg2;	// IMP=0x0000000100af7cb0
- (void)handleNativeCommandCriticalErrorWithBridge:(id)arg1;	// IMP=0x0000000100af7ca4
- (void)bridge:(id)arg1 handleNativeCommandSetOrientationPropertiesWithForceOrientationMask:(unsigned long long)arg2;	// IMP=0x0000000100af7ae4
- (void)bridge:(id)arg1 handleNativeCommandUseCustomClose:(long long)arg2;	// IMP=0x0000000100af79f8
- (void)bridge:(id)arg1 handleDisplayForDestinationURL:(id)arg2;	// IMP=0x0000000100af7744
- (void)handleNativeCommandCloseWithBridge:(id)arg1;	// IMP=0x0000000100af7738
- (void)MRAIDBridgeDidLoadAd:(id)arg1;	// IMP=0x0000000100af74e0
- (void)MRAIDBridge:(id)arg1 didFailToLoad:(id)arg2;	// IMP=0x0000000100af7380
- (void)dismissibleContainerViewTappedCloseButton:(id)arg1;	// IMP=0x0000000100af7374
- (void)dealloc;	// IMP=0x0000000100af7310
- (void)unsubscribeFromEnteringBackgroundEvents;	// IMP=0x0000000100af72b0
- (void)reactToApplicationEnteringBackground:(id)arg1;	// IMP=0x0000000100af71e4
- (void)finalizeAdExperience;	// IMP=0x0000000100af6dac
- (void)injectCloseEvent:(_Bool)arg1;	// IMP=0x0000000100af6d4c
- (void)calculateAdDurationForNativeClose;	// IMP=0x0000000100af6bf8
- (void)storeViewLoadSuccessful;	// IMP=0x0000000100af6be0
- (void)viewablePropertyChange:(_Bool)arg1;	// IMP=0x0000000100af6b48
- (void)orientationPropertyChangeWithNewSize:(struct CGSize)arg1;	// IMP=0x0000000100af6aa0
- (void)loadAdWithPlayOptions:(id)arg1;	// IMP=0x0000000100af62b4
- (id)initWithMRAIDPlacement:(id)arg1 cacheManager:(id)arg2 adFrame:(struct CGRect)arg3;	// IMP=0x0000000100af5f30

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

