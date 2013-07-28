//
//  RssCellCL.m
//  YahooRssReader
//
//  Created by aybek can kaya on 7/28/13.
//  Copyright (c) 2013 aybek can kaya. All rights reserved.
//

#import "RssCellCL.h"

@implementation RssCellCL
@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(IBAction)ButtonOnClick:(id)sender
{
    
}
-(void)SetHeaderLblText:(NSString *)text
{
    
}
-(void)SetNewsLblText:(NSString *)text
{
    
}
-(void)SetEntryImageStr:(NSString *)imgStr
{
    
}



@end
