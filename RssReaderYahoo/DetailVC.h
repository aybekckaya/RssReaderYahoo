//
//  DetailVC.h
//  RssReaderYahoo
//
//  Created by aybek can kaya on 7/28/13.
//  Copyright (c) 2013 aybek can kaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import <Social/Social.h>

@interface DetailVC : UIViewController<UIWebViewDelegate,MBProgressHUDDelegate,UIActionSheetDelegate>
{
    MBProgressHUD *CHUD;
    NSString *NewsURL;
    
    UIActionSheet *ActSheet;
    
}

@property(nonatomic,strong) NSString *NewsURL;

@property(nonatomic,weak) IBOutlet UIWebView *webview;

-(IBAction)OpenActionSheet:(id)sender;

@end
