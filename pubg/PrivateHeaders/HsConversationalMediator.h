//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "HsConversationMediator.h"

@class HsMessageDM;

@interface HsConversationalMediator : HsConversationMediator
{
    _Bool _isBotExecuting;	// 8 = 0x8
    HsMessageDM *_botMessageDM;	// 16 = 0x10
}

@property(retain, nonatomic) HsMessageDM *botMessageDM; // @synthesize botMessageDM=_botMessageDM;
@property(nonatomic) _Bool isBotExecuting; // @synthesize isBotExecuting=_isBotExecuting;
- (void).cxx_destruct;	// IMP=0x000000010144766c
- (void)renderReplyBox;	// IMP=0x000000010144736c
- (id)getConversationalRenderer;	// IMP=0x0000000101447360

@end

