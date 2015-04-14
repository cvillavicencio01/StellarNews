//
//  SwiftTableViewController.m
//  StellarNews
//
//  Created by Carlos Villavicencio on 04/13/15.
//  Copyright (c) 2015 MindsLab. All rights reserved.
//

#import "SwiftTableViewController.h"
#import "SwiftDetailsViewController.h"
@interface SwiftTableViewController ()
@property (nonatomic,strong) NSArray *array;

@end

@implementation SwiftTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:
                        kLatestJsonURL];
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
    });
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    self.array = [NSJSONSerialization
                  JSONObjectWithData:responseData //1
                  options:kNilOptions
                  error:&error];
    
    
    [self.tableView reloadData];
    //NSArray* latestLoans = [json objectForKey:@"loans"]; //2
    
    // NSLog(@"loans: %@", latestLoans); //3
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransientCell" forIndexPath:indexPath];
    
    UILabel *classLabel = (UILabel*)[cell viewWithTag:1];
    classLabel.text = [[self.array objectAtIndex:indexPath.row] objectForKey:@"class"];
    
    classLabel = (UILabel*)[cell viewWithTag:3];
    classLabel.text = [NSString stringWithFormat:@"ra: %@",[[self.array objectAtIndex:indexPath.row] objectForKey:@"ra"]];
    classLabel = (UILabel*)[cell viewWithTag:4];
    classLabel.text = [NSString stringWithFormat:@"dec: %@",[[self.array objectAtIndex:indexPath.row] objectForKey:@"dec"]];
    

    
    
    
    
    UIImageView *imageView = (UIImageView*)[cell viewWithTag:6];
   /* NSString *classTransient = [[[self.array objectAtIndex:indexPath.row] objectForKey:@"class"] lowercaseString];
    
    if ([UIImage imageNamed:classTransient]!= nil){
        
        imageView.image = [UIImage imageNamed:classTransient];
    }
    else if ([classTransient isEqualToString:@"sn/cv"]) {
        imageView.image = [UIImage imageNamed:@"sncv"];
    }
    else{*/
        imageView.image = [UIImage imageNamed:@"empty"];
   // }
    
    
    
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96.0f;
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    if ([segue.identifier isEqualToString:@"SwiftDetailsSegue"]) {
        SwiftDetailsViewController *controller = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell*)sender];
        NSString *url = [[self.array objectAtIndex: indexPath.row] objectForKey:@"url"];
        controller.url = [NSString stringWithFormat:@"http://swift.gsfc.nasa.gov/results/transients/%@",url];
    }
    
    
}
@end
