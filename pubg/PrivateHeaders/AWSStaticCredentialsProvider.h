//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "AWSCredentialsProvider.h"

@class AWSCredentials, NSString;

@interface AWSStaticCredentialsProvider : NSObject <AWSCredentialsProvider>
{
    AWSCredentials *_internalCredentials;	// 8 = 0x8
}

@property(retain, nonatomic) AWSCredentials *internalCredentials; // @synthesize internalCredentials=_internalCredentials;
- (void).cxx_destruct;	// IMP=0x0000000100bcf1e8
- (void)invalidateCachedTemporaryCredentials;	// IMP=0x0000000100bcf1c0
- (id)credentials;	// IMP=0x0000000100bcf15c
- (id)initWithAccessKey:(id)arg1 secretKey:(id)arg2;	// IMP=0x0000000100bcf090

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

