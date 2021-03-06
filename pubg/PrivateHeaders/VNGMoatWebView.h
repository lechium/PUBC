//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "UIWebViewDelegate.h"

@class NSMutableArray, NSMutableDictionary, NSString, UIView, UIWebView, VNGMoatUIWebViewBridge;

@interface VNGMoatWebView : NSObject <UIWebViewDelegate>
{
    _Bool _webViewDidLoad;	// 8 = 0x8
    _Bool _amITracking;	// 9 = 0x9
    _Bool _amCleanedUp;	// 10 = 0xa
    _Bool _initialized;	// 11 = 0xb
    UIWebView *_moatWebView;	// 16 = 0x10
    double _wLoadStart;	// 24 = 0x18
    NSMutableDictionary *_adParams;	// 32 = 0x20
    NSString *_moatTrackerName;	// 40 = 0x28
    UIView *_attachmentView;	// 48 = 0x30
    NSMutableArray *_queuedCalls;	// 56 = 0x38
    VNGMoatUIWebViewBridge *_webBridge;	// 64 = 0x40
}

+ (id)withPartnerCode:(id)arg1;	// IMP=0x0000000100b11cac
@property(retain) VNGMoatUIWebViewBridge *webBridge; // @synthesize webBridge=_webBridge;
@property(retain) NSMutableArray *queuedCalls; // @synthesize queuedCalls=_queuedCalls;
@property __weak UIView *attachmentView; // @synthesize attachmentView=_attachmentView;
@property(retain) NSString *moatTrackerName; // @synthesize moatTrackerName=_moatTrackerName;
@property(retain) NSMutableDictionary *adParams; // @synthesize adParams=_adParams;
@property double wLoadStart; // @synthesize wLoadStart=_wLoadStart;
@property _Bool initialized; // @synthesize initialized=_initialized;
@property _Bool amCleanedUp; // @synthesize amCleanedUp=_amCleanedUp;
@property _Bool amITracking; // @synthesize amITracking=_amITracking;
@property _Bool webViewDidLoad; // @synthesize webViewDidLoad=_webViewDidLoad;
@property(retain) UIWebView *moatWebView; // @synthesize moatWebView=_moatWebView;
- (void).cxx_destruct;	// IMP=0x0000000100b13168
- (void)webViewDidFinishLoad:(id)arg1;	// IMP=0x0000000100b12f70
- (void)changeAttachmentView:(id)arg1;	// IMP=0x0000000100b12efc
- (void)flushQueue;	// IMP=0x0000000100b12c1c
- (void)queueEvent:(id)arg1;	// IMP=0x0000000100b12794
- (void)dispatchEvent:(id)arg1;	// IMP=0x0000000100b12670
- (id)serializeEvent:(id)arg1;	// IMP=0x0000000100b125f8
- (id)checkAndFormatEvent:(id)arg1;	// IMP=0x0000000100b125e8
- (void)vivifyWebView;	// IMP=0x0000000100b122b0
- (void)destroy;	// IMP=0x0000000100b12238
- (void)prepareWebView;	// IMP=0x0000000100b1211c
- (void)startTracking:(id)arg1 withPlayerDims:(struct CGRect)arg2 withAttachmentView:(id)arg3 withTracker:(id)arg4;	// IMP=0x0000000100b11ef8
- (void)doInit:(id)arg1;	// IMP=0x0000000100b11d8c
- (id)initWithPartnerCode:(id)arg1;	// IMP=0x0000000100b11d14

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

