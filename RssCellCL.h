//
//  RssCellCL.h
//  YahooRssReader
//
//  Created by aybek can kaya on 7/28/13.
//  Copyright (c) 2013 aybek can kaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFNetwork.h"
#import "NSString+HTML.h"

@class RssCellCL;

@protocol RssCellDelegate <NSObject>

-(void)RssCellButtonDidClicked:(UIButton *)button Link:(NSString *) _link;

@end


@interface RssCellCL : UITableViewCell
{
    id<RssCellDelegate> delegate;
    NSString *EntryLink;
}

@property(nonatomic,strong) NSString *EntryLink;
@property(nonatomic,strong) id<RssCellDelegate> delegate;
@property(nonatomic,weak) IBOutlet UIImageView *EntryImageView;
@property(nonatomic,weak) IBOutlet UILabel *HeaderLbl;
@property(nonatomic,weak) IBOutlet UILabel *NewsLbl;
@property(nonatomic,weak) IBOutlet UIButton *twitterBtn;
@property(nonatomic,weak) IBOutlet UIButton *detailsBtn;
@property(nonatomic,weak) IBOutlet UIActivityIndicatorView *activityIndicator;

-(IBAction)ButtonOnClick:(id)sender;

-(void)SetHeaderLblText:(NSString *)text;

-(void)SetNewsLblText:(NSString *)text;

-(void)SetEntryImageStr:(NSString *)imgStr;

-(void)OpenCell;

-(void)CloseCell;

@end
