//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "NSURLConnectionDataDelegate.h"
#import "NSURLConnectionDelegate.h"

@class NSMutableData, NSMutableDictionary, NSString, NSURLConnection;

@interface TencentRequest : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>
{
    id <TencentRequestDelegate> _delegate;	// 8 = 0x8
    NSString *_url;	// 16 = 0x10
    NSString *_httpMethod;	// 24 = 0x18
    NSMutableDictionary *_params;	// 32 = 0x20
    NSURLConnection *_connection;	// 40 = 0x28
    NSMutableData *_responseText;	// 48 = 0x30
    NSMutableDictionary *_httpHeaders;	// 56 = 0x38
}

+ (id)serializeURL:(id)arg1 params:(id)arg2 httpMethod:(id)arg3;	// IMP=0x0000000100b20e88
+ (id)serializeURL:(id)arg1 params:(id)arg2;	// IMP=0x0000000100b20e74
+ (id)getRequestWithParams:(id)arg1 httpMethod:(id)arg2 delegate:(id)arg3 requestURL:(id)arg4;	// IMP=0x0000000100b20db0
@property(readonly, nonatomic) NSMutableData *responseText; // @synthesize responseText=_responseText;
@property(readonly, nonatomic) NSURLConnection *connection; // @synthesize connection=_connection;
@property(copy, nonatomic) NSString *httpMethod; // @synthesize httpMethod=_httpMethod;
@property(copy, nonatomic) NSString *url; // @synthesize url=_url;
@property(nonatomic) id <TencentRequestDelegate> delegate; // @synthesize delegate=_delegate;
- (void)connection:(id)arg1 didWriteData:(long long)arg2 totalBytesWritten:(long long)arg3 expectedTotalBytes:(long long)arg4;	// IMP=0x0000000100b22848
- (void)connection:(id)arg1 didSendBodyData:(long long)arg2 totalBytesWritten:(long long)arg3 totalBytesExpectedToWrite:(long long)arg4;	// IMP=0x0000000100b227b0
- (id)connection:(id)arg1 willCacheResponse:(id)arg2;	// IMP=0x0000000100b227a8
- (void)connection:(id)arg1 didFailWithError:(id)arg2;	// IMP=0x0000000100b22734
- (void)connectionDidFinishLoading:(id)arg1;	// IMP=0x0000000100b226c4
- (void)connection:(id)arg1 didReceiveData:(id)arg2;	// IMP=0x0000000100b226a8
- (void)connection:(id)arg1 didReceiveResponse:(id)arg2;	// IMP=0x0000000100b225f4
- (void)dealloc;	// IMP=0x0000000100b22514
- (void)cancel;	// IMP=0x0000000100b224d0
- (void)connect;	// IMP=0x0000000100b21f34
- (void)connectWithRequest:(id)arg1;	// IMP=0x0000000100b21e98
- (_Bool)loading;	// IMP=0x0000000100b21e80
- (void)handleResponseData:(id)arg1;	// IMP=0x0000000100b21d6c
- (void)failWithError:(id)arg1;	// IMP=0x0000000100b21cfc
- (id)parseJsonResponse:(id)arg1 error:(id *)arg2;	// IMP=0x0000000100b21a2c
- (id)formError:(long long)arg1 userInfo:(id)arg2;	// IMP=0x0000000100b21a00
- (id)generateOtherPostBody;	// IMP=0x0000000100b21818
- (id)generatePostBody;	// IMP=0x0000000100b211d0
- (void)utfAppendBody:(id)arg1 data:(id)arg2;	// IMP=0x0000000100b21190
@property(readonly, nonatomic) NSMutableDictionary *httpHeaders; // @synthesize httpHeaders=_httpHeaders;
@property(readonly, nonatomic) NSMutableDictionary *params; // @synthesize params=_params;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

