//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "UIActivity.h"

@class VKShareDialogController;

@interface VKActivity : UIActivity
{
    VKShareDialogController *_shareDialog;	// 8 = 0x8
}

+ (_Bool)vkShareExtensionEnabled;	// IMP=0x0000000100b49b50
+ (long long)activityCategory;	// IMP=0x0000000100b49b48
@property(retain, nonatomic) VKShareDialogController *shareDialog; // @synthesize shareDialog=_shareDialog;
- (void).cxx_destruct;	// IMP=0x0000000100b4a3cc
- (id)activityViewController;	// IMP=0x0000000100b4a39c
- (void)prepareWithActivityItems:(id)arg1;	// IMP=0x0000000100b49e64
- (_Bool)canPerformWithActivityItems:(id)arg1;	// IMP=0x0000000100b49ca8
- (id)activityTitle;	// IMP=0x0000000100b49c8c
- (id)activityImage;	// IMP=0x0000000100b49c28
- (id)activityType;	// IMP=0x0000000100b49bfc

@end

