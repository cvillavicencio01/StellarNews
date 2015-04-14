//
//  PreferencesTableViewController.m
//  StellarNews
//
//  Created by Carlos Villavicencio on 04/12/15.
//  Copyright (c) 2015 MindsLab. All rights reserved.
//

#import "PreferencesTableViewController.h"

@interface PreferencesTableViewController ()
@end

@implementation PreferencesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
   if (section == 0)
        return  1;
    else
        return 2;
}


/*-(void)notifications:(id)sender{

    UISwitch *switchNot =(UISwitch*)sender;
    
    if (switchNot.on) {
       [self enableNotifications];
    }else{
        [[UIApplication sharedApplication] unregisterForRemoteNotifications];

    }

}*/




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    
    
    if (indexPath.section == 0){
        cell = [tableView dequeueReusableCellWithIdentifier:@"NotificationsCell" forIndexPath:indexPath];
        
        
        if ([[UIApplication sharedApplication] isRegisteredForRemoteNotifications]) {
            UILabel *label = (UILabel*)[cell viewWithTag:1];
            label.text = @"Enabled";
            label.textColor = [UIColor colorWithRed:43.0/255.0f green:218.0/255.0f blue:43.0/255.0f alpha:1.0f];
        }
        else{
            UILabel *label = (UILabel*)[cell viewWithTag:1];
            label.text = @"Disabled";
            label.textColor = [UIColor colorWithRed:184.0/255.0f green:184.0/255.0f blue:184.0/255.0f alpha:1.0f];
        }
        
    /*
        UISwitch *notificationSwitch = (UISwitch*)[cell viewWithTag:1];
        
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]){
            notificationSwitch.on=[[UIApplication sharedApplication] isRegisteredForRemoteNotifications];
         }
        else{
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"

            UIRemoteNotificationType types = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
            if (types == UIRemoteNotificationTypeNone)
                notificationSwitch.on= NO;
            else
                notificationSwitch.on= YES;
#pragma GCC diagnostic warning "-Wdeprecated-declarations"

        }
    
        
        
        
        [notificationSwitch addTarget:self action:@selector(notifications:) forControlEvents:UIControlEventTouchUpInside];

*/
    }
    
    else if (indexPath.section == 1 && indexPath.row == 0)
        cell = [tableView dequeueReusableCellWithIdentifier:@"LicencesCell" forIndexPath:indexPath];
    else if  (indexPath.section == 1 && indexPath.row ==1)
        cell = [tableView dequeueReusableCellWithIdentifier:@"AboutCell" forIndexPath:indexPath];

    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    if (section == 0)
        return @"Notifications";
    else
        return @"Others";
    
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 54.0f;
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
