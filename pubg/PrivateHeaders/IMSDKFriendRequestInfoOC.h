//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class NSString;

@interface IMSDKFriendRequestInfoOC : NSObject
{
    int _type;	// 8 = 0x8
    NSString *_user;	// 16 = 0x10
    NSString *_title;	// 24 = 0x18
    NSString *_content;	// 32 = 0x20
    NSString *_link;	// 40 = 0x28
    NSString *_thumbPath;	// 48 = 0x30
    NSString *_imagePath;	// 56 = 0x38
    NSString *_extraJson;	// 64 = 0x40
}

@property(retain, nonatomic) NSString *extraJson; // @synthesize extraJson=_extraJson;
@property(retain, nonatomic) NSString *imagePath; // @synthesize imagePath=_imagePath;
@property(retain, nonatomic) NSString *thumbPath; // @synthesize thumbPath=_thumbPath;
@property(retain, nonatomic) NSString *link; // @synthesize link=_link;
@property(retain, nonatomic) NSString *content; // @synthesize content=_content;
@property(retain, nonatomic) NSString *title; // @synthesize title=_title;
@property(nonatomic) int type; // @synthesize type=_type;
@property(copy, nonatomic) NSString *user; // @synthesize user=_user;
- (void).cxx_destruct;	// IMP=0x000000010062161c
- (id)description;	// IMP=0x000000010062134c

@end

