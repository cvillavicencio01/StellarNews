//
//  BeXRBViewController.m
//  StellarNews
//
//  Created by Carlos Villavicencio on 04/14/15.
//  Copyright (c) 2015 MindsLab. All rights reserved.
//

#import "BeXRBDetailsViewController.h"

@interface BeXRBDetailsViewController ()
@property (nonatomic,strong) IBOutlet UIWebView *webView;
@property (nonatomic,strong) IBOutlet UISegmentedControl *segment;
@property (nonatomic,strong) IBOutlet UILabel *adviceLabel;

@end

@implementation BeXRBDetailsViewController

-(void)shareContent:(id)sender{
    
    
    
    
    NSString *urlString = nil;
    
    if (self.segment.selectedSegmentIndex == 0){
        urlString = [self.arrayData objectForKey:@"simurl"];
    }
    else if (self.segment.selectedSegmentIndex == 1){
        urlString = [self.arrayData objectForKey:@"maxiurl"];
    }
    else if (self.segment.selectedSegmentIndex == 2){
        urlString = [self.arrayData objectForKey:@"swifturl"];
    }
    else{
        urlString = [self.arrayData objectForKey:@"fermiurl"];
    }
    
    
    
    NSString * message = [NSString stringWithFormat:@"Check this transient %@ Use #StellarNews app",urlString];
    
    NSArray * shareItems = @[message];
    
    UIActivityViewController * avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    
    avc.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeAssignToContact, UIActivityTypeAddToReadingList, UIActivityTypePostToVimeo, UIActivityTypeAirDrop];
    
    
    [self presentViewController:avc animated:YES completion:nil];
    
    
}

-(IBAction)segmentAction:(id)sender{
    
    self.adviceLabel.text = @"";
    
    NSURL *url = nil;
    NSString *urlString = nil;
    
    if (self.segment.selectedSegmentIndex == 0){
        urlString = [self.arrayData objectForKey:@"simurl"];
        if ([urlString isEqual:@""]) self.adviceLabel.text = @"Info not Aviable";
        url = [NSURL URLWithString:urlString];
    }
    else if (self.segment.selectedSegmentIndex == 1){
        urlString = [self.arrayData objectForKey:@"maxiurl"];
        if ([urlString isEqual:@""]) self.adviceLabel.text = @"Info not Aviable";
        url = [NSURL URLWithString:urlString];
    }
    else if (self.segment.selectedSegmentIndex == 2){
        urlString = [self.arrayData objectForKey:@"swifturl"];
        if ([urlString isEqual:@""]) self.adviceLabel.text = @"Info not Aviable";
        url = [NSURL URLWithString:urlString];
    }
    else{
        urlString = [self.arrayData objectForKey:@"fermiurl"];
        if ([urlString isEqual:@""]) self.adviceLabel.text = @"Info not Aviable";
        url = [NSURL URLWithString:urlString];
    }
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareContent:)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    
    
    self.adviceLabel.text = @"";
    
    NSURL *url = nil;
    NSString *urlString = nil;
    
    urlString = [self.arrayData objectForKey:@"simurl"];
    if ([urlString isEqual:@""]) self.adviceLabel.text = @"Info not Aviable";
    url = [NSURL URLWithString:urlString];
    
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
