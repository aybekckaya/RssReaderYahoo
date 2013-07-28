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
    self.twitterBtn.alpha=0;
    self.detailsBtn.alpha=0;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    /*
    // Configure the view for the selected state
   // NSLog(@"In class Selected");
    [self.twitterBtn setAlpha:0];
    [self.detailsBtn setAlpha:0];
    if(selected == YES)
    {
        //NSLog(@"Selected YES");
        
        [self.twitterBtn setHighlighted:NO];
        [self.detailsBtn setHighlighted:NO];
        
        [UIView animateWithDuration:1.0f animations:^{
            [self.twitterBtn setAlpha:1];
            [self.detailsBtn setAlpha:1];
        }];
         NSLog(@"Cell Tag :%d selected YES",self.CellInlineTag);
    }
    else if(selected == NO)
    {
        NSLog(@"Cell Tag :%d selected NO",self.CellInlineTag);
    }

    */
    
}



-(void)OpenCell
{
    [self.twitterBtn setHighlighted:NO];
    [self.detailsBtn setHighlighted:NO];
    
    [UIView animateWithDuration:1.0f animations:^{
        [self.twitterBtn setAlpha:1];
        [self.detailsBtn setAlpha:1];
    }];

}

-(void)CloseCell
{
    [self.twitterBtn setHighlighted:NO];
    [self.detailsBtn setHighlighted:NO];
    
    [UIView animateWithDuration:0.1f animations:^{
        [self.twitterBtn setAlpha:0];
        [self.detailsBtn setAlpha:0];
    }];

}


-(IBAction)ButtonOnClick:(id)sender
{
     if([sender tag] == 1071)
     {
         // Twitter Btn
         [delegate RssCellButtonDidClicked:self.twitterBtn Link:EntryLink];
     }
    else if([sender tag] == 1072)
    {
        // Details Btn
        [delegate RssCellButtonDidClicked:self.detailsBtn Link:EntryLink];
    }
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
    [self.EntryImageView setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:nil];

}



@end
