//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "HsWidget.h"

@class NSString;

@interface HsTextWidget : HsWidget
{
    NSString *_text;	// 8 = 0x8
    int _error;	// 16 = 0x10
}

+ (_Bool)validateDateInput:(id)arg1;	// IMP=0x0000000101419e78
+ (_Bool)validateInput:(id)arg1 forPattern:(id)arg2;	// IMP=0x0000000101419d50
- (void).cxx_destruct;	// IMP=0x000000010141a0a0
- (_Bool)validateText;	// IMP=0x000000010141a024
- (int)error;	// IMP=0x000000010141a014
- (void)setError:(int)arg1;	// IMP=0x0000000101419ffc
- (id)text;	// IMP=0x0000000101419f9c
- (void)setText:(id)arg1;	// IMP=0x0000000101419f0c

@end

