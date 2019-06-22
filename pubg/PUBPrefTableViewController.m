//
//  PUBPrefTableViewController.m
//  electra1131
//
//  Created by Kevin Bradley on 6/21/19.
//  Copyright © 2019 Electra Team. All rights reserved.
//

#import "PUBPrefTableViewController.h"

@interface PUBPrefTableViewController ()

@end

@implementation PUBPrefTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0){
        return  1;
    }
    
    return 13;
}

- (void)configureCell:(UITableViewCell *)cell forRow:(NSInteger)row {
 
    switch (row) {
        case 0: //ButtonA
            cell.textLabel.text = @"Button A";
            break;
            
        case 1: //ButtonB
            cell.textLabel.text = @"Button B";
            break;
            
        case 2: //ButtonX
            
            cell.textLabel.text = @"Button X";
            break;
            
        case 3: //ButtonY
            
            cell.textLabel.text = @"Button Y";
            break;
            
        case 4: //LeftShoulder
            
            cell.textLabel.text = @"L1 (Left Shoulder)";
            break;
            
        case 5: //RightShoulder
            
            cell.textLabel.text = @"R1 (Right Shoulder)";
            break;
            
        case 6: //LeftTrigger
            
            cell.textLabel.text = @"L2 (Left Trigger)";
            break;
            
        case 7: //RightTrigger
            
            cell.textLabel.text = @"R2 (Right Trigger)";
            break;
            
        case 8: //LeftThumbstickButton
            
            cell.textLabel.text = @"L3 (Left Thumbstick Button)";
            break;
            
        case 9: //RightThumbstickButton
            
            cell.textLabel.text = @"R3 (Right Thumbstick Button)";
            break;
            
        case 10: //Dpad.up
            
            cell.textLabel.text = @"D-Pad Up";
            break;
            
        case 11: //Dpad.down
            
            cell.textLabel.text = @"D-Pad Down";
            break;
            
        case 12: //Dpad.left
            
            cell.textLabel.text = @"D-Pad Left";
            break;
            
        case 13: //Dpad.right
            
            cell.textLabel.text = @"D-Pad Right";
            break;
        default:
            break;
    }
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    switch (indexPath.section){
            
        case 0: //
            
            cell.textLabel.text = @"Experimental Right Joystick";
            cell.detailTextLabel.text = @"Enabled";
            
            break;
            
        case 1: //
            
            [self configureCell:cell forRow:indexPath.row];
            
            break;
    }
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
