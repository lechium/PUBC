//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class NSMutableDictionary, NSString;

@interface FIRClearcutAccountData : NSObject
{
    NSMutableDictionary *_logSourceToWriter;	// 8 = 0x8
    NSString *_accountLogDirectory;	// 16 = 0x10
}

@property(copy, nonatomic) NSString *accountLogDirectory; // @synthesize accountLogDirectory=_accountLogDirectory;
@property(readonly, copy, nonatomic) NSMutableDictionary *logSourceToWriter; // @synthesize logSourceToWriter=_logSourceToWriter;
- (void).cxx_destruct;	// IMP=0x0000000100906064
- (id)filenameWithCurrentTimeInDirectory:(id)arg1;	// IMP=0x0000000100905f84
- (void)flushWriters;	// IMP=0x0000000100905ef0
- (void)removeWriterForLogSource:(int)arg1;	// IMP=0x0000000100905e74
- (id)writerForLogSource:(int)arg1;	// IMP=0x0000000100905c78
- (id)initWithAccountLogDirectory:(id)arg1;	// IMP=0x0000000100905bb0

@end

