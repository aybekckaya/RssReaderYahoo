//
//  ViewController.h
//  YahooRssReader
//
//  Created by aybek can kaya on 7/28/13.
//  Copyright (c) 2013 aybek can kaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parser.h"
#import "MBProgressHUD.h"
#import "TitleViewCL.h"
#import "DetailVC.h"




@interface ViewController : UIViewController<ParserDelegate,MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    Parser *XmlParser;
    MBProgressHUD *CHUD;
    NSMutableArray *RssItems;
  
    BOOL IsLoadingNewItems;
    int TotalNumOfEntries;
    BOOL TotalNumEntriesHasReached;
   
    NSString *RssURL;
}
@property(nonatomic,strong) MBProgressHUD *CHUD;

@property(nonatomic,weak) IBOutlet UITableView *RssTable;

-(IBAction)RefreshPage:(id)sender;

@end
