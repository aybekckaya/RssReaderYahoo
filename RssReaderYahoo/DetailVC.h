//
//  DetailVC.h
//  RssReaderYahoo
//
//  Created by aybek can kaya on 7/28/13.
//  Copyright (c) 2013 aybek can kaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface DetailVC : UIViewController<UIWebViewDelegate,MBProgressHUDDelegate>
{
    MBProgressHUD *CHUD;
    NSString *NewsURL;
}

@property(nonatomic,strong) NSString *NewsURL;

@property(nonatomic,weak) IBOutlet UIWebView *webview;



@end
