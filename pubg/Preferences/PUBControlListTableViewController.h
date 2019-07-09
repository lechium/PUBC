//
//  PUBPrefTableViewController.h
//  pubc
//
//  Created by Kevin Bradley on 6/21/19.
//  Copyright © 2019 nito llc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PUBControlListTableViewController : UITableViewController

@property (nonatomic, strong) NSString *currentValue;
@property (nonatomic, strong) NSString *keyValue;

- (id)initWithOriginalValue:(id)value keyValue:(NSString *)keyValue;

@end
