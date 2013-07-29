//
//  RssCellCL.m
//  YahooRssReader
//
//  Created by aybek can kaya on 7/28/13.
//  Copyright (c) 2013 aybek can kaya. All rights reserved.
//

#import "RssCellCL.h"

@implementation RssCellCL

@synthesize EntryLink;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)awakeFromNib
{
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}



-(void)SetHeaderLblText:(NSString *)text
{
    self.HeaderLbl.text=[text stringByConvertingHTMLToPlainText];
    CGSize Actual;
    //  self.HeaderLbl.minimumFontSize=13;
    self.HeaderLbl.adjustsFontSizeToFitWidth=YES;
    
    // text diyelimki asagidaki olculere gore bicimlendi. bu durumda actual degiskeninin width i  fontsize veriyor
    
    
    [text sizeWithFont:self.HeaderLbl.font minFontSize:self.HeaderLbl.minimumFontSize actualFontSize:&Actual forWidth:self.HeaderLbl.frame.size.width lineBreakMode:self.HeaderLbl.lineBreakMode];
    
    float AdjustedFontSize=Actual.width;
    
    if(AdjustedFontSize < 12)
    {
        // multiple lines
        self.HeaderLbl.numberOfLines=2;
        self.HeaderLbl.font=[UIFont fontWithName:self.HeaderLbl.font.fontName size:14];
    }
    

}
-(void)SetNewsLblText:(NSString *)text
{
    int length=[text length];
    int numLines=(length/50) > 7 ? 7:(length/50);
    
    self.NewsLbl.numberOfLines=numLines;
    
    self.NewsLbl.text=[text stringByConvertingHTMLToPlainText];
}
-(void)SetEntryImageStr:(NSString *)imgStr
{
    if(imgStr == nil)
    {
         // The entry has no image in it
        [self.activityIndicator setHidden:YES];
        self.EntryImageView.frame=CGRectZero;
        self.NewsLbl.frame=CGRectMake(2,self.NewsLbl.frame.origin.y, self.frame.size.width-4, self.frame.size.height-self.HeaderLbl.frame.size.height-2);
    }
    else
    {
        // There is valid image in the entry
        
        [self.EntryImageView setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:nil]; // loads image from url
    }

}



@end
