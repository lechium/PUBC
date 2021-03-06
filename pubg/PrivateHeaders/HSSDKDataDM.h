//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@interface HSSDKDataDM : NSObject
{
    id <HsPlatform> _platform;	// 8 = 0x8
}

- (void).cxx_destruct;	// IMP=0x00000001013d1e44
- (id)getWebsocketConfigJsonWithError:(id *)arg1;	// IMP=0x00000001013d1ddc
- (void)setWebsocketConfigJson:(id)arg1 withError:(id *)arg2;	// IMP=0x00000001013d1d5c
- (short)getFaqOptionForDeviceSearchWithError:(id *)arg1;	// IMP=0x00000001013d1cfc
- (void)setFaqOptionForDeviceSearch:(short)arg1 withError:(id *)arg2;	// IMP=0x00000001013d1c94
- (id)getSearchIndexFileNameWithError:(id *)arg1;	// IMP=0x00000001013d1c2c
- (void)setSearchIndexFileName:(id)arg1 withError:(id *)arg2;	// IMP=0x00000001013d1bac
- (void)didReceivePausedInAppInfo:(_Bool)arg1 forIssueOrPreIssueID:(id)arg2;	// IMP=0x00000001013d1a44
- (void)removePauseInAppInfo;	// IMP=0x00000001013d1950
- (id)getPauseInAppInfo;	// IMP=0x00000001013d17a8
- (void)setPauseInAppInfo:(id)arg1;	// IMP=0x00000001013d1698
- (id)getRemoteNotificationsWithError:(id *)arg1;	// IMP=0x00000001013d1630
- (void)setRemoteNotifications:(id)arg1 withError:(id *)arg2;	// IMP=0x00000001013d15b0
- (void)removeLocalNotificationsForIssue:(id)arg1 WithError:(id *)arg2;	// IMP=0x00000001013d1530
- (id)getLocalNotificationsForIssue:(id)arg1 WithError:(id *)arg2;	// IMP=0x00000001013d149c
- (void)setLocalNotifications:(id)arg1 forIssue:(id)arg2 withError:(id *)arg3;	// IMP=0x00000001013d13f4
- (long long)getNotificationCountForIssue:(id)arg1 withDefaultValue:(long long)arg2 withError:(id *)arg3;	// IMP=0x00000001013d1358
- (void)setNotificationCount:(long long)arg1 forIssueOrPreIssueId:(id)arg2 withError:(id *)arg3;	// IMP=0x00000001013d12c8
- (_Bool)isInAppNotificationPausedWithError:(id *)arg1;	// IMP=0x00000001013d1268
- (void)setInAppNotificationPaused:(_Bool)arg1 withError:(id *)arg2;	// IMP=0x00000001013d1200
- (id)deviceUdidWithError:(id *)arg1;	// IMP=0x00000001013d1198
- (void)saveSDKVersion:(id)arg1 withError:(id *)arg2;	// IMP=0x00000001013d1118
- (id)savedSDKVersionWithError:(id *)arg1;	// IMP=0x00000001013d10b0
- (id)initWithPlatform:(id)arg1;	// IMP=0x00000001013d1030

@end

