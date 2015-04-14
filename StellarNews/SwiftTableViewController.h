//
//  SwiftTableViewController.h
//  StellarNews
//
//  Created by Carlos Villavicencio on 04/13/15.
//  Copyright (c) 2015 MindsLab. All rights reserved.
//



#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
#define kLatestJsonURL [NSURL URLWithString:@"http://www.minds-lab.com/carlosv/spaceapps/data/swift/swift.json"] //2



#import <UIKit/UIKit.h>

@interface SwiftTableViewController : UITableViewController

@end
