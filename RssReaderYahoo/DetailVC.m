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
    
  //  NSLog(@"Link : %@",NewsURL);
    
  //      NewsURL=@"asdad"; // error test
    NSURL *url=[NSURL URLWithString:NewsURL];
    NSURLRequest *req=[NSURLRequest requestWithURL:url];
    [self.webview loadRequest:req];
    
    
}


-(void)CreateActionSheet
{
 
    ActSheet=[[UIActionSheet alloc]initWithTitle:@"Social" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Twitter",@"FaceBook", nil];
    
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
    else if(buttonIndex == 1)
    {
        // facebook share 
        [self ShareOnFacebook];
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



#pragma mark FaceBookShare

-(void)ShareOnFacebook
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *FaceSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeFacebook];
        [FaceSheet setInitialText:nil];
        
        
        [FaceSheet addURL:[NSURL URLWithString:NewsURL]];
        
        [self presentViewController:FaceSheet animated:YES completion:nil];
        
        
        // On Post Query Complete this block will be called
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultDone)
            {
                // UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Success" message:@"Your message has been sent successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                // [alert show];
            }
        };
        
        FaceSheet.completionHandler =myBlock;
        
    }

}


#pragma mark END Facebook Share


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
