//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class NSMutableArray, NSString;

@interface TWTRPersistentStore : NSObject
{
    unsigned long long _totalSize;	// 8 = 0x8
    NSString *_path;	// 16 = 0x10
    NSMutableArray *_items;	// 24 = 0x18
    unsigned long long _maxSize;	// 32 = 0x20
}

@property(nonatomic) unsigned long long maxSize; // @synthesize maxSize=_maxSize;
@property(retain, nonatomic) NSMutableArray *items; // @synthesize items=_items;
@property(copy, nonatomic) NSString *path; // @synthesize path=_path;
@property(nonatomic) unsigned long long totalSize; // @synthesize totalSize=_totalSize;
- (void).cxx_destruct;	// IMP=0x0000000100866c3c
- (unsigned long long)indexOfObjectForKey:(id)arg1;	// IMP=0x0000000100866a70
- (void)pruneStoredObjects;	// IMP=0x000000010086674c
- (_Bool)isValidPath:(id)arg1;	// IMP=0x0000000100866724
- (_Bool)isValidData:(id)arg1;	// IMP=0x00000001008666dc
- (_Bool)isValidValue:(id)arg1;	// IMP=0x00000001008666c0
- (id)pathForKey:(id)arg1;	// IMP=0x0000000100866630
- (void)parseStoredObjects;	// IMP=0x00000001008660fc
- (_Bool)createStoreStructure;	// IMP=0x0000000100865fec
- (void)removeAllObjects;	// IMP=0x0000000100865db8
- (_Bool)removeObjectForKey:(id)arg1;	// IMP=0x0000000100865b8c
- (void)cleanCorruptItemAtPath:(id)arg1 withIndex:(unsigned long long)arg2 usingFileManager:(id)arg3;	// IMP=0x0000000100865a7c
- (id)objectForKey:(id)arg1;	// IMP=0x0000000100865774
- (_Bool)setObject:(id)arg1 forKey:(id)arg2;	// IMP=0x0000000100865354
- (id)initWithPath:(id)arg1 maxSize:(unsigned long long)arg2;	// IMP=0x0000000100865230

@end

