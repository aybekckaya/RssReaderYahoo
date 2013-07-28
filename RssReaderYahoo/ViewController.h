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

/*
    - Internet baglantisi olmadigi zamanki test 
 */

@interface ViewController : UIViewController<ParserDelegate,MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate,RssCellDelegate>
{
    Parser *XmlParser;
    MBProgressHUD *CHUD;
    NSMutableArray *RssItems;
    int currentSelection;
}


@property(nonatomic,weak) IBOutlet UITableView *RssTable;
@property(nonatomic,strong) IBOutlet UIActivityIndicatorView *LoadingIndicator;


@end
