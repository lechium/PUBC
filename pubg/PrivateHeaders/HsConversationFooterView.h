//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "UIView.h"

@class HsBorderedButton, HsConversationFooterSubtextLabel, HsConversationFooterTitleLabel, HsDividerView, HsStarButton, NSLayoutConstraint, UIColor, UIImageView;

@interface HsConversationFooterView : UIView
{
    unsigned long long _footerState;	// 8 = 0x8
    id <HsConversationFooterViewDelegate> _delegate;	// 16 = 0x10
    UIView *_typingIndicatorContainerView;	// 24 = 0x18
    UIImageView *_typingIndicatorImageView;	// 32 = 0x20
    UIView *_typingIndicatorDotView1;	// 40 = 0x28
    UIView *_typingIndicatorDotView2;	// 48 = 0x30
    UIView *_typingIndicatorDotView3;	// 56 = 0x38
    NSLayoutConstraint *_typingIndicatorViewHeightConstrain;	// 64 = 0x40
    NSLayoutConstraint *_typingIndicatorViewBottomCheckConstrain;	// 72 = 0x48
    UIColor *_startColor;	// 80 = 0x50
    UIColor *_endColor;	// 88 = 0x58
    double _animationDuration;	// 96 = 0x60
    HsConversationFooterSubtextLabel *_resolutionFooterThanksLabel;	// 104 = 0x68
    HsDividerView *_resolutionFooterDotView;	// 112 = 0x70
    HsDividerView *_resolutionFooterSeparatorView;	// 120 = 0x78
    NSLayoutConstraint *_resolutionFooterHeightConstrain;	// 128 = 0x80
    NSLayoutConstraint *_resolutionFooterBottomCheckConstrain;	// 136 = 0x88
    NSLayoutConstraint *_resolutionFooterTopSpaceConstrain;	// 144 = 0x90
    HsConversationFooterTitleLabel *_resolutionFooterQuestionLabel;	// 152 = 0x98
    HsBorderedButton *_resolutionFooterQuestionNoButton;	// 160 = 0xa0
    HsBorderedButton *_resolutionFooterQuestionYesButton;	// 168 = 0xa8
    NSLayoutConstraint *_resolutionFooterQuestionHeightConstrain;	// 176 = 0xb0
    NSLayoutConstraint *_resolutionFooterQuestionBottomCheckConstrain;	// 184 = 0xb8
    HsConversationFooterTitleLabel *_csatQuestionLabel;	// 192 = 0xc0
    HsStarButton *_csatStarButton1;	// 200 = 0xc8
    HsStarButton *_csatStarButton2;	// 208 = 0xd0
    HsStarButton *_csatStarButton3;	// 216 = 0xd8
    HsStarButton *_csatStarButton4;	// 224 = 0xe0
    HsStarButton *_csatStarButton5;	// 232 = 0xe8
    HsConversationFooterSubtextLabel *_csatHateLabel;	// 240 = 0xf0
    HsConversationFooterSubtextLabel *_csatLikeLabel;	// 248 = 0xf8
    HsDividerView *_csatSeparatorView;	// 256 = 0x100
    HsConversationFooterSubtextLabel *_csatOrLabel;	// 264 = 0x108
    NSLayoutConstraint *_csatViewHeightConstrain;	// 272 = 0x110
    NSLayoutConstraint *_csatViewBottomCheckConstrain;	// 280 = 0x118
    HsConversationFooterSubtextLabel *_startNewConversationTitleLabel;	// 288 = 0x120
    HsBorderedButton *_startNewConversationButton;	// 296 = 0x128
    NSLayoutConstraint *_startNewConversationViewHeightConstrain;	// 304 = 0x130
    NSLayoutConstraint *_startNewConversationBottomCheckConstrain;	// 312 = 0x138
    NSLayoutConstraint *_resolutionFooterBottomSpaceConstrain;	// 320 = 0x140
}

@property(nonatomic) __weak NSLayoutConstraint *resolutionFooterBottomSpaceConstrain; // @synthesize resolutionFooterBottomSpaceConstrain=_resolutionFooterBottomSpaceConstrain;
@property(retain, nonatomic) NSLayoutConstraint *startNewConversationBottomCheckConstrain; // @synthesize startNewConversationBottomCheckConstrain=_startNewConversationBottomCheckConstrain;
@property(retain, nonatomic) NSLayoutConstraint *startNewConversationViewHeightConstrain; // @synthesize startNewConversationViewHeightConstrain=_startNewConversationViewHeightConstrain;
@property(nonatomic) __weak HsBorderedButton *startNewConversationButton; // @synthesize startNewConversationButton=_startNewConversationButton;
@property(nonatomic) __weak HsConversationFooterSubtextLabel *startNewConversationTitleLabel; // @synthesize startNewConversationTitleLabel=_startNewConversationTitleLabel;
@property(retain, nonatomic) NSLayoutConstraint *csatViewBottomCheckConstrain; // @synthesize csatViewBottomCheckConstrain=_csatViewBottomCheckConstrain;
@property(retain, nonatomic) NSLayoutConstraint *csatViewHeightConstrain; // @synthesize csatViewHeightConstrain=_csatViewHeightConstrain;
@property(nonatomic) __weak HsConversationFooterSubtextLabel *csatOrLabel; // @synthesize csatOrLabel=_csatOrLabel;
@property(nonatomic) __weak HsDividerView *csatSeparatorView; // @synthesize csatSeparatorView=_csatSeparatorView;
@property(nonatomic) __weak HsConversationFooterSubtextLabel *csatLikeLabel; // @synthesize csatLikeLabel=_csatLikeLabel;
@property(nonatomic) __weak HsConversationFooterSubtextLabel *csatHateLabel; // @synthesize csatHateLabel=_csatHateLabel;
@property(nonatomic) __weak HsStarButton *csatStarButton5; // @synthesize csatStarButton5=_csatStarButton5;
@property(nonatomic) __weak HsStarButton *csatStarButton4; // @synthesize csatStarButton4=_csatStarButton4;
@property(nonatomic) __weak HsStarButton *csatStarButton3; // @synthesize csatStarButton3=_csatStarButton3;
@property(nonatomic) __weak HsStarButton *csatStarButton2; // @synthesize csatStarButton2=_csatStarButton2;
@property(nonatomic) __weak HsStarButton *csatStarButton1; // @synthesize csatStarButton1=_csatStarButton1;
@property(nonatomic) __weak HsConversationFooterTitleLabel *csatQuestionLabel; // @synthesize csatQuestionLabel=_csatQuestionLabel;
@property(retain, nonatomic) NSLayoutConstraint *resolutionFooterQuestionBottomCheckConstrain; // @synthesize resolutionFooterQuestionBottomCheckConstrain=_resolutionFooterQuestionBottomCheckConstrain;
@property(retain, nonatomic) NSLayoutConstraint *resolutionFooterQuestionHeightConstrain; // @synthesize resolutionFooterQuestionHeightConstrain=_resolutionFooterQuestionHeightConstrain;
@property(nonatomic) __weak HsBorderedButton *resolutionFooterQuestionYesButton; // @synthesize resolutionFooterQuestionYesButton=_resolutionFooterQuestionYesButton;
@property(nonatomic) __weak HsBorderedButton *resolutionFooterQuestionNoButton; // @synthesize resolutionFooterQuestionNoButton=_resolutionFooterQuestionNoButton;
@property(nonatomic) __weak HsConversationFooterTitleLabel *resolutionFooterQuestionLabel; // @synthesize resolutionFooterQuestionLabel=_resolutionFooterQuestionLabel;
@property(nonatomic) __weak NSLayoutConstraint *resolutionFooterTopSpaceConstrain; // @synthesize resolutionFooterTopSpaceConstrain=_resolutionFooterTopSpaceConstrain;
@property(retain, nonatomic) NSLayoutConstraint *resolutionFooterBottomCheckConstrain; // @synthesize resolutionFooterBottomCheckConstrain=_resolutionFooterBottomCheckConstrain;
@property(retain, nonatomic) NSLayoutConstraint *resolutionFooterHeightConstrain; // @synthesize resolutionFooterHeightConstrain=_resolutionFooterHeightConstrain;
@property(nonatomic) __weak HsDividerView *resolutionFooterSeparatorView; // @synthesize resolutionFooterSeparatorView=_resolutionFooterSeparatorView;
@property(nonatomic) __weak HsDividerView *resolutionFooterDotView; // @synthesize resolutionFooterDotView=_resolutionFooterDotView;
@property(nonatomic) __weak HsConversationFooterSubtextLabel *resolutionFooterThanksLabel; // @synthesize resolutionFooterThanksLabel=_resolutionFooterThanksLabel;
@property(nonatomic) double animationDuration; // @synthesize animationDuration=_animationDuration;
@property(retain, nonatomic) UIColor *endColor; // @synthesize endColor=_endColor;
@property(retain, nonatomic) UIColor *startColor; // @synthesize startColor=_startColor;
@property(retain, nonatomic) NSLayoutConstraint *typingIndicatorViewBottomCheckConstrain; // @synthesize typingIndicatorViewBottomCheckConstrain=_typingIndicatorViewBottomCheckConstrain;
@property(retain, nonatomic) NSLayoutConstraint *typingIndicatorViewHeightConstrain; // @synthesize typingIndicatorViewHeightConstrain=_typingIndicatorViewHeightConstrain;
@property(nonatomic) __weak UIView *typingIndicatorDotView3; // @synthesize typingIndicatorDotView3=_typingIndicatorDotView3;
@property(nonatomic) __weak UIView *typingIndicatorDotView2; // @synthesize typingIndicatorDotView2=_typingIndicatorDotView2;
@property(nonatomic) __weak UIView *typingIndicatorDotView1; // @synthesize typingIndicatorDotView1=_typingIndicatorDotView1;
@property(nonatomic) __weak UIImageView *typingIndicatorImageView; // @synthesize typingIndicatorImageView=_typingIndicatorImageView;
@property(nonatomic) __weak UIView *typingIndicatorContainerView; // @synthesize typingIndicatorContainerView=_typingIndicatorContainerView;
@property(nonatomic) __weak id <HsConversationFooterViewDelegate> delegate; // @synthesize delegate=_delegate;
@property(nonatomic) unsigned long long footerState; // @synthesize footerState=_footerState;
- (void).cxx_destruct;	// IMP=0x000000010146bb20
- (void)showTypingIndicator:(_Bool)arg1;	// IMP=0x000000010146b36c
- (void)applyTypingIndicatorTheming;	// IMP=0x000000010146b2c8
- (id)typingViewForIndex:(int)arg1;	// IMP=0x000000010146b290
- (void)animateTyping;	// IMP=0x000000010146aefc
- (id)bubbleImage;	// IMP=0x000000010146aed0
- (void)initialiseTypingIndicator;	// IMP=0x000000010146ab58
- (void)startNewConversationButtonTapped:(id)arg1;	// IMP=0x000000010146aad0
- (void)csatStarButtonTapped:(id)arg1;	// IMP=0x000000010146aa94
- (void)resolutionFooterQuestionYesButtonTapped:(id)arg1;	// IMP=0x000000010146aa0c
- (void)resolutionQuestionFooterNoButtonTapped:(id)arg1;	// IMP=0x000000010146a984
- (void)didSelectRatingWithValue:(long long)arg1;	// IMP=0x000000010146a8e8
- (void)showStartNewConversationView:(_Bool)arg1 issueArchivalState:(_Bool)arg2 authorMismatchState:(_Bool)arg3;	// IMP=0x000000010146a6ac
- (void)showCSATView:(_Bool)arg1;	// IMP=0x000000010146a620
- (void)showResolutionQuestionView:(_Bool)arg1;	// IMP=0x000000010146a594
- (void)showThanksHeader:(_Bool)arg1;	// IMP=0x000000010146a3c4
- (void)setupTheme;	// IMP=0x0000000101469c44
- (void)setupDefaultTexts;	// IMP=0x0000000101469920
- (void)setupViewsDefaults;	// IMP=0x00000001014698a8
- (void)addVerticalPadding;	// IMP=0x0000000101469830
- (void)removeVerticalPadding;	// IMP=0x00000001014697b8
- (void)initialiseDefaults;	// IMP=0x0000000101469074
- (void)updateFooterViewState;	// IMP=0x0000000101468e2c
- (void)awakeFromNib;	// IMP=0x0000000101468dc4

@end

