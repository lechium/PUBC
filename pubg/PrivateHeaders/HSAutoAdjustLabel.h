//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "HsLabel.h"

@class NSLayoutConstraint;

@interface HSAutoAdjustLabel : HsLabel
{
    NSLayoutConstraint *_relativeConstraint;	// 8 = 0x8
    double _relativeConstraintSpace;	// 16 = 0x10
}

@property(nonatomic) double relativeConstraintSpace; // @synthesize relativeConstraintSpace=_relativeConstraintSpace;
@property(nonatomic) __weak NSLayoutConstraint *relativeConstraint; // @synthesize relativeConstraint=_relativeConstraint;
- (void).cxx_destruct;	// IMP=0x0000000101428528
- (void)setAttributedText:(id)arg1;	// IMP=0x00000001014283e4
- (void)setText:(id)arg1;	// IMP=0x000000010142830c

@end

