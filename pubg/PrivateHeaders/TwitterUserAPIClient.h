//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "TwitterNetworking.h"

@class NSString;

@interface TwitterUserAPIClient : TwitterNetworking
{
    NSString *_authToken;	// 8 = 0x8
    NSString *_authTokenSecret;	// 16 = 0x10
}

+ (id)hostWithPortFromURL:(id)arg1;	// IMP=0x00000001007f5d90
@property(readonly, copy, nonatomic) NSString *authTokenSecret; // @synthesize authTokenSecret=_authTokenSecret;
@property(readonly, copy, nonatomic) NSString *authToken; // @synthesize authToken=_authToken;
- (void).cxx_destruct;	// IMP=0x00000001007f5eb0
- (id)URLRequestWithMethod:(id)arg1 URL:(id)arg2 parameters:(id)arg3;	// IMP=0x00000001007f5bc8
- (id)DELETE:(id)arg1 parameters:(id)arg2;	// IMP=0x00000001007f597c
- (id)POST:(id)arg1 parameters:(id)arg2;	// IMP=0x00000001007f5730
- (id)GET:(id)arg1 parameters:(id)arg2;	// IMP=0x00000001007f54e4
- (id)initWithAuthConfig:(id)arg1 authToken:(id)arg2 authTokenSecret:(id)arg3;	// IMP=0x00000001007f53f4

@end

