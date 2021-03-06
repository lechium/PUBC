//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "HsTransport.h"
#import "NSURLSessionDataDelegate.h"
#import "NSURLSessionDelegate.h"
#import "NSURLSessionTaskDelegate.h"

@class NSMutableDictionary, NSString, NSURLSession;

@interface HsBackgroundTransport : NSObject <NSURLSessionDelegate, NSURLSessionDataDelegate, NSURLSessionTaskDelegate, HsTransport>
{
    NSURLSession *_session;	// 8 = 0x8
    NSMutableDictionary *_requestCompletionHandlers;	// 16 = 0x10
    NSMutableDictionary *_backgroundTaskIdentifiers;	// 24 = 0x18
    id <HsResponseStorage> _storage;	// 32 = 0x20
}

@property(nonatomic) __weak id <HsResponseStorage> storage; // @synthesize storage=_storage;
@property(retain, nonatomic) NSMutableDictionary *backgroundTaskIdentifiers; // @synthesize backgroundTaskIdentifiers=_backgroundTaskIdentifiers;
@property(retain, nonatomic) NSMutableDictionary *requestCompletionHandlers; // @synthesize requestCompletionHandlers=_requestCompletionHandlers;
@property(retain, nonatomic) NSURLSession *session; // @synthesize session=_session;
- (void).cxx_destruct;	// IMP=0x00000001013c6f18
- (void)URLSession:(id)arg1 downloadTask:(id)arg2 didFinishDownloadingToURL:(id)arg3;	// IMP=0x00000001013c6dd0
- (void)URLSession:(id)arg1 dataTask:(id)arg2 didReceiveData:(id)arg3;	// IMP=0x00000001013c6d7c
- (void)URLSession:(id)arg1 task:(id)arg2 didCompleteWithError:(id)arg3;	// IMP=0x00000001013c6d24
- (void)URLSession:(id)arg1 didBecomeInvalidWithError:(id)arg2;	// IMP=0x00000001013c6ca0
- (void)handleResultForTask:(id)arg1 withData:(id)arg2 andError:(id)arg3;	// IMP=0x00000001013c670c
- (void)deleteDataForRequestId:(id)arg1;	// IMP=0x00000001013c66f8
- (id)saveData:(id)arg1 forRequestId:(id)arg2;	// IMP=0x00000001013c6690
- (void)downloadRequest:(id)arg1 withCompletionBlock:(CDUnknownBlockType)arg2;	// IMP=0x00000001013c634c
- (void)uploadRequest:(id)arg1 withCompletionBlock:(CDUnknownBlockType)arg2;	// IMP=0x00000001013c5e38
- (id)initWithResponseStorage:(id)arg1;	// IMP=0x00000001013c5cc0

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

