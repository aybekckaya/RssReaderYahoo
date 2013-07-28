//
//  DetailVC.m
//  RssReaderYahoo
//
//  Created by aybek can kaya on 7/28/13.
//  Copyright (c) 2013 aybek can kaya. All rights reserved.
//

#import "DetailVC.h"

@interface DetailVC ()

@end

@implementation DetailVC
@synthesize NewsURL;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    CHUD=[[MBProgressHUD alloc] initWithView:self.view];
    CHUD.delegate=self;
    [self.view addSubview:CHUD];
    [CHUD show:YES];
    
    // Loading Source Address
    
    NSLog(@"Link : %@",NewsURL);
    
  //    NewsURL=@"asdad"; // error test
    NSURL *url=[NSURL URLWithString:NewsURL];
    NSURLRequest *req=[NSURLRequest requestWithURL:url];
    [self.webview loadRequest:req];
    
    
}



#pragma mark WebViewDelegate 

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    // close Hud
    [CHUD hide:YES];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [CHUD hide:YES];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:[NSString stringWithFormat:@"An Error occured. Please Try again later. \r\n Error Description: %@",[error description]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

#pragma mark WebView Delegate END



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
