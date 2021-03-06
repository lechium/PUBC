//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@interface IMSDKAuthHelper : NSObject
{
}

+ (id)getConnectSaveKey:(id)arg1;	// IMP=0x0000000100602710
+ (id)getAuthModuleEventID:(basic_string_7c0a1c0b)arg1 channel:(id)arg2;	// IMP=0x000000010060258c
+ (id)mergeJson:(id)arg1 andPluginJson:(id)arg2;	// IMP=0x0000000100602404
+ (struct IMSDKAuthConnectResult)getConnectResult:(id)arg1;	// IMP=0x000000010060237c
+ (_Bool)checkConnectNecessary:(id)arg1 forChannel:(id)arg2;	// IMP=0x0000000100602160
+ (void)removeConnectResult:(id)arg1;	// IMP=0x00000001006020cc
+ (void)saveConnectResult:(struct IMSDKAuthConnectResult)arg1 forChannel:(id)arg2 uid:(id)arg3;	// IMP=0x0000000100601e70
+ (void)reportAuthEventStage:(id)arg1 eventResult:(long long)arg2 eventType:(long long)arg3 errorMsg:(id)arg4;	// IMP=0x0000000100601c1c
+ (void)handleIMSDKMigrateCallBack:(CDUnknownFunctionPointerType)arg1 withError:(id)arg2 apiName:(basic_string_7c0a1c0b)arg3;	// IMP=0x0000000100601a98
+ (void)handleIMSDKAuthCallBack:(CDUnknownFunctionPointerType)arg1 withError:(id)arg2 apiName:(basic_string_7c0a1c0b)arg3 channel:(id)arg4;	// IMP=0x00000001006018f4
+ (void)handleIMSDKCallBack:(CDUnknownFunctionPointerType)arg1 withError:(id)arg2 apiName:(basic_string_7c0a1c0b)arg3 channel:(id)arg4;	// IMP=0x0000000100601750
+ (void)handleIMSDKMigrateCallBack:(CDUnknownFunctionPointerType)arg1 withHttpRequestDict:(id)arg2 apiName:(basic_string_7c0a1c0b)arg3;	// IMP=0x0000000100600eb8
+ (void)handleIMSDKAuthCallBack:(CDUnknownFunctionPointerType)arg1 withHttpRequestDict:(id)arg2 extraJson:(id)arg3 apiName:(basic_string_7c0a1c0b)arg4 channel:(id)arg5;	// IMP=0x00000001006005c4
+ (void)handleIMSDKCallBack:(CDUnknownFunctionPointerType)arg1 withHttpRequestDict:(id)arg2 apiName:(basic_string_7c0a1c0b)arg3 channel:(id)arg4;	// IMP=0x00000001006000f8
+ (void)convert:(struct IMSDKResult *)arg1 error:(id)arg2;	// IMP=0x00000001005fffa4
+ (id)getAuthDeivceId;	// IMP=0x00000001005fff10
+ (id)getAuthClassName:(basic_string_7c0a1c0b)arg1;	// IMP=0x00000001005ffe00
+ (int)getAuthStatus;	// IMP=0x00000001005ffdc4

@end

