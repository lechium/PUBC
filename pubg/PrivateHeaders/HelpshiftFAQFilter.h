//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class NSArray;

@interface HelpshiftFAQFilter : NSObject
{
    int _filterOperator;	// 8 = 0x8
    NSArray *_tags;	// 16 = 0x10
}

@property(retain, nonatomic) NSArray *tags; // @synthesize tags=_tags;
@property(nonatomic) int filterOperator; // @synthesize filterOperator=_filterOperator;
- (void).cxx_destruct;	// IMP=0x00000001013a20a4
- (id)initWithFilterOperator:(int)arg1 andTags:(id)arg2;	// IMP=0x00000001013a1fcc
- (id)init;	// IMP=0x00000001013a1fb4

@end

