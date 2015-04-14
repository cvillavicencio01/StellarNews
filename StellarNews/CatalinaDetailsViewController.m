//
//  CatalinaDetailsViewController.m
//  StellarNews
//
//  Created by Carlos Villavicencio on 04/12/15.
//  Copyright (c) 2015 MindsLab. All rights reserved.
//

#import "CatalinaDetailsViewController.h"

@interface CatalinaDetailsViewController ()


@property (nonatomic,strong) IBOutlet UIWebView *webView;

@end

@implementation CatalinaDetailsViewController


-(void)shareContent:(id)sender{
    
    
    NSString * message = [NSString stringWithFormat:@"Check this transient %@ Use #StellarNews app",self.url];
    
    NSArray * shareItems = @[message];
    
    UIActivityViewController * avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    
    avc.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeAssignToContact, UIActivityTypeAddToReadingList, UIActivityTypePostToVimeo, UIActivityTypeAirDrop];
    
    
    [self presentViewController:avc animated:YES completion:nil];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareContent:)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    
    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (IBAction)back {
    
  //  [self  dismissViewControllerAnimated:true completion:nil];
    // Dispose of any resources that can be recreated.
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
