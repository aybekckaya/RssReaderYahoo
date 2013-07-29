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
#import "RssCellCL.h"
#import "TitleViewCL.h"
#import "DetailVC.h"

/*
    - Internet baglantisi olmadigi zamanki test 
    - Loading background thread icinde calissin 
     - scroll speede gore navbar bulaniklastirilabilir
 */

@interface ViewController : UIViewController<ParserDelegate,MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    Parser *XmlParser;
    MBProgressHUD *CHUD;
    NSMutableArray *RssItems;
  
    BOOL IsLoadingNewItems;
    int TotalNumOfEntries;
    BOOL TotalNumEntriesHasReached;
}


@property(nonatomic,weak) IBOutlet UITableView *RssTable;
@property(nonatomic,strong) IBOutlet UIActivityIndicatorView *LoadingIndicator;


@end
