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
    
    
    [self CreateActionSheet];
    
    CHUD=[[MBProgressHUD alloc] initWithView:self.view];
    CHUD.delegate=self;
    [self.view addSubview:CHUD];
    [CHUD show:YES];
    
    // Loading Source Address
    
    NSLog(@"Link : %@",NewsURL);
    
  //      NewsURL=@"asdad"; // error test
    NSURL *url=[NSURL URLWithString:NewsURL];
    NSURLRequest *req=[NSURLRequest requestWithURL:url];
    [self.webview loadRequest:req];
    
    
}


-(void)CreateActionSheet
{
    /*
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  4
                                  initWithTitle:@"Rate this App"
                                  5
                                  delegate:self
                                  6
                                  cancelButtonTitle:@"Cancel Button"
                                  7
                                  destructiveButtonTitle:nil
                                  8
                                  otherButtonTitles:@"Rate 1 Star", @"Rate 2 Stars",
                                  9
                                  @"Rate 3 Starts", @"Rate 4 Stars", @"Rate 5 Stars", nil];
    10
    
    11
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    12
    [actionSheet showInView:self.view];
  */
    ActSheet=[[UIActionSheet alloc]initWithTitle:@"Social" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Twitter", nil];
    
    
    
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




#pragma  mark ActionSheet


-(IBAction)OpenActionSheet:(id)sender
{
    [ActSheet showInView:self.view];
}



- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
     if(buttonIndex == 0)
     {
         // Twitter Share
         [self ShareOnTwitter];
     }

}



#pragma mark ActionSheetEnd


#pragma mark Twitter Sharing

-(void)ShareOnTwitter
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:nil];
        
        
        [tweetSheet addURL:[NSURL URLWithString:NewsURL]];
        
        [self presentViewController:tweetSheet animated:YES completion:nil];
        
        
        // On Post Query Complete this block will be called
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
                if (result == SLComposeViewControllerResultDone)
                {
                   // UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Success" message:@"Your message has been sent successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                   // [alert show];
                }
            };
        
        tweetSheet.completionHandler =myBlock;
        
     }
}

#pragma mark Twitter Sharing END


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
