//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "AWSModel.h"

@class AWSS3LoggingEnabled;

@interface AWSS3BucketLoggingStatus : AWSModel
{
    AWSS3LoggingEnabled *_loggingEnabled;	// 8 = 0x8
}

+ (id)loggingEnabledJSONTransformer;	// IMP=0x0000000100bf7530
+ (id)JSONKeyPathsByPropertyKey;	// IMP=0x0000000100bf74b8
@property(retain, nonatomic) AWSS3LoggingEnabled *loggingEnabled; // @synthesize loggingEnabled=_loggingEnabled;
- (void).cxx_destruct;	// IMP=0x0000000100bf7598

@end

