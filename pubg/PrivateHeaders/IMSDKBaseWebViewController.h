//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "UIViewController.h"

#import "UIGestureRecognizerDelegate.h"
#import "UIImagePickerControllerDelegate.h"
#import "UINavigationControllerDelegate.h"

@class IMSDKPopupShareView, IMSDKWebViewJavascriptBridge, NSBundle, NSLayoutConstraint, NSString, UIButton, UILabel, UIView;

@interface IMSDKBaseWebViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate>
{
    _Bool _isCompleted;	// 8 = 0x8
    _Bool _isPresented;	// 9 = 0x9
    _Bool _isManualClose;	// 10 = 0xa
    _Bool _hiddenBars;	// 11 = 0xb
    _Bool _navNestScroll;	// 12 = 0xc
    _Bool _supportIphoneX;	// 13 = 0xd
    id <IMSDKWebViewPluginDelegate> _webViewDelegate;	// 16 = 0x10
    UIView *_xibView;	// 24 = 0x18
    UIView *_backgroundWebView;	// 32 = 0x20
    UIView *_backgroundProgressView;	// 40 = 0x28
    UILabel *_topTitleLabel;	// 48 = 0x30
    UIView *_titleBar;	// 56 = 0x38
    UIView *_toolBar;	// 64 = 0x40
    UIButton *_backBtn;	// 72 = 0x48
    UIButton *_forwardBtn;	// 80 = 0x50
    UIButton *_closeBtn;	// 88 = 0x58
    UIButton *_shareBtn;	// 96 = 0x60
    UIButton *_refreshBtn;	// 104 = 0x68
    NSLayoutConstraint *_heightConstraintTitleBar;	// 112 = 0x70
    NSLayoutConstraint *_topConstraintTitleBar;	// 120 = 0x78
    NSLayoutConstraint *_heightConstraintToolBar;	// 128 = 0x80
    NSLayoutConstraint *_bottomConstraintToolBar;	// 136 = 0x88
    NSLayoutConstraint *_leftMarginContraintWebView;	// 144 = 0x90
    NSLayoutConstraint *_rightMarginContraintWebView;	// 152 = 0x98
    double _lastPositionY;	// 160 = 0xa0
    NSBundle *_bundle;	// 168 = 0xa8
    NSString *_background;	// 176 = 0xb0
    NSString *_homeUrl;	// 184 = 0xb8
    IMSDKWebViewJavascriptBridge *_bridge;	// 192 = 0xc0
    CDUnknownBlockType _jsCallback;	// 200 = 0xc8
    IMSDKPopupShareView *_popupShareView;	// 208 = 0xd0
    UIView *_subWebView;	// 216 = 0xd8
    UIView *_subProgressView;	// 224 = 0xe0
}

@property(retain, nonatomic) UIView *subProgressView; // @synthesize subProgressView=_subProgressView;
@property(retain, nonatomic) UIView *subWebView; // @synthesize subWebView=_subWebView;
@property(retain, nonatomic) IMSDKPopupShareView *popupShareView; // @synthesize popupShareView=_popupShareView;
@property(copy, nonatomic) CDUnknownBlockType jsCallback; // @synthesize jsCallback=_jsCallback;
@property(retain, nonatomic) IMSDKWebViewJavascriptBridge *bridge; // @synthesize bridge=_bridge;
@property(retain, nonatomic) NSString *homeUrl; // @synthesize homeUrl=_homeUrl;
@property(retain, nonatomic) NSString *background; // @synthesize background=_background;
@property(nonatomic) _Bool supportIphoneX; // @synthesize supportIphoneX=_supportIphoneX;
@property(nonatomic) _Bool navNestScroll; // @synthesize navNestScroll=_navNestScroll;
@property(nonatomic) _Bool hiddenBars; // @synthesize hiddenBars=_hiddenBars;
@property(retain, nonatomic) NSBundle *bundle; // @synthesize bundle=_bundle;
@property(nonatomic) double lastPositionY; // @synthesize lastPositionY=_lastPositionY;
@property(nonatomic) _Bool isManualClose; // @synthesize isManualClose=_isManualClose;
@property(nonatomic) _Bool isPresented; // @synthesize isPresented=_isPresented;
@property(nonatomic) _Bool isCompleted; // @synthesize isCompleted=_isCompleted;
@property(nonatomic) __weak NSLayoutConstraint *rightMarginContraintWebView; // @synthesize rightMarginContraintWebView=_rightMarginContraintWebView;
@property(nonatomic) __weak NSLayoutConstraint *leftMarginContraintWebView; // @synthesize leftMarginContraintWebView=_leftMarginContraintWebView;
@property(nonatomic) __weak NSLayoutConstraint *bottomConstraintToolBar; // @synthesize bottomConstraintToolBar=_bottomConstraintToolBar;
@property(nonatomic) __weak NSLayoutConstraint *heightConstraintToolBar; // @synthesize heightConstraintToolBar=_heightConstraintToolBar;
@property(nonatomic) __weak NSLayoutConstraint *topConstraintTitleBar; // @synthesize topConstraintTitleBar=_topConstraintTitleBar;
@property(nonatomic) __weak NSLayoutConstraint *heightConstraintTitleBar; // @synthesize heightConstraintTitleBar=_heightConstraintTitleBar;
@property(nonatomic) __weak UIButton *refreshBtn; // @synthesize refreshBtn=_refreshBtn;
@property(nonatomic) __weak UIButton *shareBtn; // @synthesize shareBtn=_shareBtn;
@property(nonatomic) __weak UIButton *closeBtn; // @synthesize closeBtn=_closeBtn;
@property(nonatomic) __weak UIButton *forwardBtn; // @synthesize forwardBtn=_forwardBtn;
@property(nonatomic) __weak UIButton *backBtn; // @synthesize backBtn=_backBtn;
@property(nonatomic) __weak UIView *toolBar; // @synthesize toolBar=_toolBar;
@property(nonatomic) __weak UIView *titleBar; // @synthesize titleBar=_titleBar;
@property(nonatomic) __weak UILabel *topTitleLabel; // @synthesize topTitleLabel=_topTitleLabel;
@property(nonatomic) __weak UIView *backgroundProgressView; // @synthesize backgroundProgressView=_backgroundProgressView;
@property(nonatomic) __weak UIView *backgroundWebView; // @synthesize backgroundWebView=_backgroundWebView;
@property(retain, nonatomic) UIView *xibView; // @synthesize xibView=_xibView;
@property(nonatomic) __weak id <IMSDKWebViewPluginDelegate> webViewDelegate; // @synthesize webViewDelegate=_webViewDelegate;
- (void).cxx_destruct;	// IMP=0x000000010068442c
- (void)shareWebView:(id)arg1;	// IMP=0x0000000100683b98
- (void)reload:(id)arg1;	// IMP=0x0000000100683b78
- (void)back:(id)arg1;	// IMP=0x0000000100683b58
- (void)forward:(id)arg1;	// IMP=0x0000000100683b38
- (void)refresh:(id)arg1;	// IMP=0x0000000100683b18
- (void)close:(id)arg1;	// IMP=0x0000000100683af8
- (void)resetWebviewContentBlank;	// IMP=0x0000000100683a58
- (void)dismiss;	// IMP=0x0000000100683864
- (void)reloadWebView;	// IMP=0x0000000100683844
- (void)forwardWebView;	// IMP=0x0000000100683824
- (void)backWebView;	// IMP=0x0000000100683804
- (_Bool)canGoForward;	// IMP=0x00000001006837e0
- (_Bool)canGoBack;	// IMP=0x00000001006837bc
- (void)callJSFunction:(id)arg1;	// IMP=0x0000000100683780
- (void)setHome:(id)arg1 openID:(id)arg2;	// IMP=0x00000001006836f8
- (void)hideAllBars:(_Bool)arg1;	// IMP=0x000000010068369c
- (void)presentViewController:(id)arg1 animated:(_Bool)arg2 completion:(CDUnknownBlockType)arg3;	// IMP=0x0000000100683458
- (void)dismissViewControllerAnimated:(_Bool)arg1 completion:(CDUnknownBlockType)arg2;	// IMP=0x0000000100683344
- (void)imagePickerControllerDidCancel:(id)arg1;	// IMP=0x00000001006832d0
- (void)imagePickerController:(id)arg1 didFinishPickingMediaWithInfo:(id)arg2;	// IMP=0x0000000100683094
- (id)shareURL;	// IMP=0x0000000100683070
- (id)progressView;	// IMP=0x000000010068304c
- (id)webView;	// IMP=0x0000000100683028
- (_Bool)prefersStatusBarHidden;	// IMP=0x0000000100683020
- (void)willRotateToInterfaceOrientation:(long long)arg1 duration:(double)arg2;	// IMP=0x0000000100683008
- (void)viewWillTransitionToSize:(struct CGSize)arg1 withTransitionCoordinator:(id)arg2;	// IMP=0x0000000100682fe4
- (unsigned long long)supportedInterfaceOrientations;	// IMP=0x0000000100682d88
- (_Bool)shouldAutorotate;	// IMP=0x0000000100682d80
- (void)panGesture:(id)arg1;	// IMP=0x0000000100682c58
- (_Bool)gestureRecognizer:(id)arg1 shouldRecognizeSimultaneouslyWithGestureRecognizer:(id)arg2;	// IMP=0x0000000100682c50
- (void)showTabBar:(_Bool)arg1 animated:(_Bool)arg2;	// IMP=0x00000001006829c4
- (void)registerBridgeHandler:(id)arg1;	// IMP=0x0000000100681f1c
- (void)hideAllBarsIfNeed;	// IMP=0x0000000100681de8
- (void)loadXibByIsPortrait:(_Bool)arg1;	// IMP=0x0000000100681870
- (void)didReceiveMemoryWarning;	// IMP=0x0000000100681838
- (void)viewDidLayoutSubviews;	// IMP=0x0000000100681650
- (void)viewWillAppear:(_Bool)arg1;	// IMP=0x000000010068158c
- (void)viewDidLoad;	// IMP=0x0000000100681338
- (id)initWithHome:(id)arg1 openID:(id)arg2;	// IMP=0x0000000100681034

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

