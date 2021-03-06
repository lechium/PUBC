//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "HsNetwork.h"

@class NSString;

@interface HsTSCorrectedNetwork : NSObject <HsNetwork>
{
    id <HsNetworkRequestDAO> _networkRequestDAO;	// 8 = 0x8
    id <HsNetwork> _network;	// 16 = 0x10
}

- (void).cxx_destruct;	// IMP=0x000000010143e0a4
- (id)makeRequest:(id)arg1 retryCount:(int)arg2 withError:(id *)arg3;	// IMP=0x000000010143dda8
- (id)makeRequest:(id)arg1 withError:(id *)arg2;	// IMP=0x000000010143dd90
- (id)initWithPlatform:(id)arg1 network:(id)arg2;	// IMP=0x000000010143dccc

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

