//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "UITableViewController.h"

@class NSArray, VKPostSettings;

@interface VKShareSettingsController : UITableViewController
{
    VKPostSettings *_currentSettings;	// 8 = 0x8
    NSArray *_rows;	// 16 = 0x10
}

@property(retain, nonatomic) NSArray *rows; // @synthesize rows=_rows;
@property(retain, nonatomic) VKPostSettings *currentSettings; // @synthesize currentSettings=_currentSettings;
- (void).cxx_destruct;	// IMP=0x0000000100b68cd4
- (void)switchChanged:(id)arg1;	// IMP=0x0000000100b6899c
- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2;	// IMP=0x0000000100b68488
- (long long)tableView:(id)arg1 numberOfRowsInSection:(long long)arg2;	// IMP=0x0000000100b6843c
- (void)viewDidLoad;	// IMP=0x0000000100b683a0
- (id)initWithPostSettings:(id)arg1;	// IMP=0x0000000100b68184

@end

