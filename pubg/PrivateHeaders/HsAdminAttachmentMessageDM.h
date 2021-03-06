//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "HsAttachmentMessageDM.h"

@interface HsAdminAttachmentMessageDM : HsAttachmentMessageDM
{
    unsigned long long _downloadProgress;	// 8 = 0x8
    unsigned long long _attachmentState;	// 16 = 0x10
}

@property(nonatomic) unsigned long long attachmentState; // @synthesize attachmentState=_attachmentState;
@property(nonatomic) unsigned long long downloadProgress; // @synthesize downloadProgress=_downloadProgress;
- (id)checkAndGetLocalFileName;	// IMP=0x00000001013bb068
- (void)deleteAttachment;	// IMP=0x00000001013bafd8
- (void)handleTapWithConversationListener:(id)arg1;	// IMP=0x00000001013baa90
- (void)setStateAndNotify:(unsigned long long)arg1;	// IMP=0x00000001013baa78
- (_Bool)isWriteStoragePermissionRequired;	// IMP=0x00000001013baa60
- (id)formattedFileSize;	// IMP=0x00000001013ba914
- (void)updateState;	// IMP=0x00000001013ba8bc
- (id)initWithServerId:(id)arg1 body:(id)arg2 createdAt:(id)arg3 authorName:(id)arg4 size:(unsigned long long)arg5 contentType:(id)arg6 attachmentRemoteURL:(id)arg7 attachmentLocalName:(id)arg8 isSecureAttachment:(_Bool)arg9 fileExtension:(id)arg10;	// IMP=0x00000001013ba754

@end

