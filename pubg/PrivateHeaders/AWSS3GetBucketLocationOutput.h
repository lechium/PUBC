//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "AWSModel.h"

@interface AWSS3GetBucketLocationOutput : AWSModel
{
    long long _locationConstraint;	// 8 = 0x8
}

+ (id)locationConstraintJSONTransformer;	// IMP=0x0000000100bff5b0
+ (id)JSONKeyPathsByPropertyKey;	// IMP=0x0000000100bff538
@property(nonatomic) long long locationConstraint; // @synthesize locationConstraint=_locationConstraint;

@end

