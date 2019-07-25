//
//  PUBCPanSpeedViewController.h
//  pubc
//
//  Created by Kevin Bradley on 7/20/19.
//  Copyright © 2019 nito. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PUBCPanSpeedViewController : UIViewController

@property (nonatomic, strong) NSString *keyValue;
@property (readwrite, assign) float min;
@property (readwrite, assign) float max;

- (id)initWithTitle:(NSString *)title keyValue:(NSString *)kv currentValue:(float)value;


@end


