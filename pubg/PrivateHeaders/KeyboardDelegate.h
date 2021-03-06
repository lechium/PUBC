//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "UITextFieldDelegate.h"
#import "UITextViewDelegate.h"

@class NSArray, NSString, UITextField, UITextView, UIToolbar, UIView;

@interface KeyboardDelegate : NSObject <UITextFieldDelegate, UITextViewDelegate>
{
    TSharedPtr_2699a924 KeyboardEntry;	// 8 = 0x8
    UITextView *textView;	// 24 = 0x18
    UIToolbar *viewToolbar;	// 32 = 0x20
    NSArray *viewToolbarItems;	// 40 = 0x28
    UITextField *textField;	// 48 = 0x30
    UIToolbar *fieldToolbar;	// 56 = 0x38
    NSArray *fieldToolbarItems;	// 64 = 0x40
    UIView *inputView;	// 72 = 0x48
    UIView *editView;	// 80 = 0x50
    struct CGRect _area;	// 88 = 0x58
    NSString *initialText;	// 120 = 0x78
    long long keyboardType;	// 128 = 0x80
    _Bool _multiline;	// 136 = 0x88
    _Bool _inputHidden;	// 137 = 0x89
    _Bool _done;	// 138 = 0x8a
    _Bool _canceled;	// 139 = 0x8b
    _Bool _rotating;	// 140 = 0x8c
    int _visibleState;	// 144 = 0x90
    struct CGRect area;	// 152 = 0x98
}

+ (void)FinishReorientation;	// IMP=0x00000001025966d8
+ (void)StartReorientation;	// IMP=0x0000000102596658
+ (id)Instance;	// IMP=0x00000001025958ac
+ (void)Initialize;	// IMP=0x00000001025957e0
@property(nonatomic) int visibleState; // @synthesize visibleState=_visibleState;
@property(readonly, nonatomic) _Bool canceled; // @synthesize canceled=_canceled;
@property(readonly, nonatomic) _Bool done; // @synthesize done=_done;
@property(readonly, nonatomic) struct CGRect area; // @synthesize area;
- (id).cxx_construct;	// IMP=0x0000000102596934
- (void).cxx_destruct;	// IMP=0x0000000102596924
- (void)shouldHideInput:(_Bool)arg1;	// IMP=0x0000000102596868
- (void)setText:(id)arg1;	// IMP=0x0000000102596834
- (void)setTextWorkaround:(id)arg1 text:(id)arg2;	// IMP=0x00000001025967ac
- (id)getText;	// IMP=0x0000000102596758
- (_Bool)IsIphoneX;	// IMP=0x0000000102596588
- (void)positionInput:(struct CGRect)arg1 x:(float)arg2 y:(float)arg3;	// IMP=0x00000001025963c4
- (void)updateInputHidden;	// IMP=0x000000010259633c
- (void)hide;	// IMP=0x00000001025962ac
- (void)show:(TSharedPtr_2699a924)arg1;	// IMP=0x0000000102596258
- (void)systemHideKeyboard;	// IMP=0x000000010259620c
- (void)hideUI;	// IMP=0x00000001025961a0
- (void)showUI;	// IMP=0x0000000102596140
- (void)setKeyboardParams:(CDStruct_4c437055)arg1;	// IMP=0x0000000102595f14
- (void)setTextInputTraits:(id)arg1 withParam:(CDStruct_4c437055)arg2 withCap:(long long)arg3;	// IMP=0x0000000102595e88
@property(readonly, nonatomic) _Bool active;
- (id)init;	// IMP=0x0000000102595aa8
- (struct CreateToolbarResult)createToolbarWithView:(id)arg1;	// IMP=0x00000001025958f8
- (void)keyboardDidChangeFrame:(id)arg1;	// IMP=0x00000001025956e0
- (void)keyboardDidHide:(id)arg1;	// IMP=0x0000000102595698
- (void)keyboardWillHide:(id)arg1;	// IMP=0x000000010259568c
- (void)keyboardDidShow:(id)arg1;	// IMP=0x000000010259555c
- (_Bool)textViewShouldBeginEditing:(id)arg1;	// IMP=0x0000000102595528
- (void)textInputCancel:(id)arg1;	// IMP=0x000000010259550c
- (void)textInputDone:(id)arg1;	// IMP=0x00000001025951ac
- (_Bool)textFieldShouldReturn:(id)arg1;	// IMP=0x0000000102594e1c
- (_Bool)textField:(id)arg1 shouldChangeCharactersInRange:(struct _NSRange)arg2 replacementString:(id)arg3;	// IMP=0x0000000102594e00

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

