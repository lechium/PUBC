//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class HsHTTPBackoff;

@interface HsCorePoller : NSObject
{
    _Bool _running;	// 8 = 0x8
    id <HSPollerDelegate> _delegate;	// 16 = 0x10
    HsHTTPBackoff *_successBackoff;	// 24 = 0x18
    HsHTTPBackoff *_failureBackoff;	// 32 = 0x20
    unsigned long long _type;	// 40 = 0x28
}

@property(nonatomic) unsigned long long type; // @synthesize type=_type;
@property(retain, nonatomic) HsHTTPBackoff *failureBackoff; // @synthesize failureBackoff=_failureBackoff;
@property(retain, nonatomic) HsHTTPBackoff *successBackoff; // @synthesize successBackoff=_successBackoff;
@property(nonatomic) __weak id <HSPollerDelegate> delegate; // @synthesize delegate=_delegate;
- (void).cxx_destruct;	// IMP=0x00000001014ad238
- (void)scheduleWithStatus:(long long)arg1;	// IMP=0x00000001014ad050
- (_Bool)isRunning;	// IMP=0x00000001014acf48
- (void)stop;	// IMP=0x00000001014acf38
- (void)start;	// IMP=0x00000001014acf18
- (id)initWithDelegate:(id)arg1;	// IMP=0x00000001014ace98

@end

