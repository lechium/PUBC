//
//  PUBCPanSpeedViewController.m
//  pubc
//
//  Created by Kevin Bradley on 7/20/19.
//  Copyright © 2019 nito. All rights reserved.
//

#import "PUBCPanSpeedViewController.h"
#import "PureLayout.h"
#import "PUBGControllerManager.h"

@interface PUBCPanSpeedViewController ()

@property (nonatomic, strong) UISlider *slider;
@property (readwrite, assign) float currentValue;


@end

@implementation PUBCPanSpeedViewController

@synthesize keyValue;

- (id)initWithTitle:(NSString *)title keyValue:(NSString *)kv currentValue:(float)value {
    
    self = [super init];
    if (self){
        self.title = title;
        self.keyValue = kv;
        self.currentValue = value;
    }
    return self;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.slider = [[UISlider alloc] initForAutoLayout];
    [self.view addSubview:self.slider];
    self.slider.minimumValue = self.min;
    self.slider.maximumValue = self.max;
    
    //NSLog(@"PUBC: %@ currentValue: %f", self.keyValue, self.currentValue);
    
    self.slider.value = self.currentValue;
    [self.slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    [self.slider autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:70];
    [self.slider autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withMultiplier:0.8];
    [self.slider autoAlignAxisToSuperviewAxis:ALAxisVertical];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(close)];
    
}

- (void)close {
    
    PUBGControllerManager *shared = [PUBGControllerManager sharedManager];
    [shared updateGamplayValue:[NSNumber numberWithFloat:self.slider.value] forKey:self.keyValue];
    [self.navigationController popViewControllerAnimated:true];
}


- (void)sliderChanged:(UISlider *)slider {
    
    
}



@end
