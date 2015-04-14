//
//  CatalinaTableViewController.m
//  StellarNews
//
//  Created by Carlos Villavicencio on 04/12/15.
//  Copyright (c) 2015 MindsLab. All rights reserved.
//

#import "CatalinaTableViewController.h"
#import "CatalinaDetailsViewController.h"
@interface CatalinaTableViewController ()

@property (nonatomic,strong) NSArray *array;
@property (nonatomic,strong) UIAlertView *loadingAlert;

@end

@implementation CatalinaTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Add an observer that will respond to loginComplete
     [[NSNotificationCenter defaultCenter] addObserver:self
                                              selector:@selector(reloadJson:)
                                                    name:@"reloadJson" object:nil];
    [self loadJson];
    
    
}



-(void)dismissAlert{
    [self.loadingAlert dismissWithClickedButtonIndex:0 animated:YES];
}

-(void)showLoadingAlert:(NSString *)msgStr{
    self.loadingAlert = [[UIAlertView alloc] initWithTitle:msgStr message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [self.loadingAlert show];
}



- (void)reloadJson:(NSNotification *)note {
    [self loadJson];
}

-(void)loadJson{
    [self showLoadingAlert:@"Loading data..."];
    
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:
                        kLatestJsonURL];
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
    });
}


- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    self.array = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          options:kNilOptions
                          error:&error];
    
    
    [self.tableView reloadData];
    
    [self dismissAlert];
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
    
    
    classLabel = (UILabel*)[cell viewWithTag:2];
    classLabel.text = [NSString stringWithFormat:@"Mag: %@ mv",[[self.array objectAtIndex:indexPath.row] objectForKey:@"mag"]];
    
    classLabel = (UILabel*)[cell viewWithTag:3];
    classLabel.text = [NSString stringWithFormat:@"ra: %@",[[self.array objectAtIndex:indexPath.row] objectForKey:@"ra"]];
    
    classLabel = (UILabel*)[cell viewWithTag:4];
    classLabel.text = [NSString stringWithFormat:@"dec: %@",[[self.array objectAtIndex:indexPath.row] objectForKey:@"dec"]];
    
    classLabel = (UILabel*)[cell viewWithTag:5];
    classLabel.text = [NSString stringWithFormat:@"date: %@",[[self.array objectAtIndex:indexPath.row] objectForKey:@"date"]];
    
    
    
    
    UIImageView *imageView = (UIImageView*)[cell viewWithTag:6];
    NSString *classTransient = [[[self.array objectAtIndex:indexPath.row] objectForKey:@"class"] lowercaseString];
    
    if ([UIImage imageNamed:classTransient]!= nil){
        
        imageView.image = [UIImage imageNamed:classTransient];
    }
    else if ([classTransient isEqualToString:@"sn/cv"]) {
        imageView.image = [UIImage imageNamed:@"sncv"];
    }
    else{
        imageView.image = [UIImage imageNamed:@"empty"];
    }
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if((indexPath.row % 2) == 0)
        cell.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    
    else
        cell.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1.0];
    
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
    
    
    if ([segue.identifier isEqualToString:@"CatalinaDetailsSegue"]) {
        CatalinaDetailsViewController *controller = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell*)sender];
        NSString *url = [[self.array objectAtIndex: indexPath.row] objectForKey:@"url"];
        controller.url = url;
    }
    
    
}


@end
