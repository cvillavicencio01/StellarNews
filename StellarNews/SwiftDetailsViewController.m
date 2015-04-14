//
//  SwiftDetailsViewController.m
//  StellarNews
//
//  Created by Carlos Villavicencio on 04/13/15.
//  Copyright (c) 2015 MindsLab. All rights reserved.
//

#import "SwiftDetailsViewController.h"

@interface SwiftDetailsViewController ()

@property (nonatomic,strong) IBOutlet UIWebView *webView;

@end

@implementation SwiftDetailsViewController



-(void)shareContent:(id)sender{
    
    
    NSString * message = [NSString stringWithFormat:@"Check this transient %@ Use #StellarNews app",self.url];
    
    NSArray * shareItems = @[message];
    
    UIActivityViewController * avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    
    avc.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeAssignToContact, UIActivityTypeAddToReadingList, UIActivityTypePostToVimeo, UIActivityTypeAirDrop];
    

    [self presentViewController:avc animated:YES completion:nil];
 
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareContent:)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    
    
    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
