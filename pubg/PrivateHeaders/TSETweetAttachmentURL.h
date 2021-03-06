//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "TSETweetAttachment.h"

@class NSString, NSURL, UIImage;

@interface TSETweetAttachmentURL : NSObject <TSETweetAttachment>
{
    NSString *_title;	// 8 = 0x8
    NSURL *_URL;	// 16 = 0x10
    UIImage *_previewImage;	// 24 = 0x18
}

@property(readonly, copy, nonatomic) UIImage *previewImage; // @synthesize previewImage=_previewImage;
@property(readonly, copy, nonatomic) NSURL *URL; // @synthesize URL=_URL;
@property(readonly, copy, nonatomic) NSString *title; // @synthesize title=_title;
- (void).cxx_destruct;	// IMP=0x00000001008865e4
- (id)initWithTitle:(id)arg1 URL:(id)arg2 previewImage:(id)arg3;	// IMP=0x00000001008864ac

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

