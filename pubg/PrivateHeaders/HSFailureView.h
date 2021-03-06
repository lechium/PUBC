//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "UIView.h"

@class NSArray, UIImageView, UILabel;

@interface HSFailureView : UIView
{
    UIImageView *_failureImage;	// 8 = 0x8
    UILabel *_failureMainTitle;	// 16 = 0x10
    UILabel *_failureSecondaryTitle;	// 24 = 0x18
    UIView *_internalView;	// 32 = 0x20
    NSArray *_horizontalConstraints;	// 40 = 0x28
    NSArray *_verticalConstraints;	// 48 = 0x30
}

@property(retain, nonatomic) NSArray *verticalConstraints; // @synthesize verticalConstraints=_verticalConstraints;
@property(retain, nonatomic) NSArray *horizontalConstraints; // @synthesize horizontalConstraints=_horizontalConstraints;
@property(retain, nonatomic) UIView *internalView; // @synthesize internalView=_internalView;
@property(nonatomic) __weak UILabel *failureSecondaryTitle; // @synthesize failureSecondaryTitle=_failureSecondaryTitle;
@property(nonatomic) __weak UILabel *failureMainTitle; // @synthesize failureMainTitle=_failureMainTitle;
@property(nonatomic) __weak UIImageView *failureImage; // @synthesize failureImage=_failureImage;
- (void).cxx_destruct;	// IMP=0x00000001013faee4
- (void)updateConstraints;	// IMP=0x00000001013fab78
- (void)awakeFromNib;	// IMP=0x00000001013faa00
- (void)commonSetUp;	// IMP=0x00000001013fa828
- (id)initWithCoder:(id)arg1;	// IMP=0x00000001013fa7d0
- (id)initWithFrame:(struct CGRect)arg1;	// IMP=0x00000001013fa778

@end

