//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "UINavigationController.h"

#import "UINavigationControllerDelegate.h"

@class NSString;

@interface MidasIAPNavCtrl : UINavigationController <UINavigationControllerDelegate>
{
    long long _initOrientation;	// 8 = 0x8
}

@property(nonatomic) long long orientation; // @synthesize orientation=_initOrientation;
- (id)navigationController:(id)arg1 animationControllerForOperation:(long long)arg2 fromViewController:(id)arg3 toViewController:(id)arg4;	// IMP=0x0000000100531410
- (_Bool)shouldAutorotate;	// IMP=0x0000000100531408
- (_Bool)shouldAutorotateToInterfaceOrientation:(long long)arg1;	// IMP=0x00000001005313d8
- (unsigned long long)supportedInterfaceOrientations;	// IMP=0x00000001005313a8
- (void)viewDidAppear:(_Bool)arg1;	// IMP=0x000000010053135c
- (void)viewDidLoad;	// IMP=0x0000000100531324
- (void)loadView;	// IMP=0x000000010053128c

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

