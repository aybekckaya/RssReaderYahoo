//
//  Parser.m
//  YahooRssReader
//
//  Created by aybek can kaya on 7/28/13.
//  Copyright (c) 2013 aybek can kaya. All rights reserved.
//

#import "Parser.h"

// how many rss items will be parsed in every request
#define EntriesPerRequest 4

@implementation Parser
@synthesize delegate;
@synthesize HeaderFrame,DescFrame;
@synthesize ImageFrame;

+(Parser *)SharedParser
{
    static Parser *theParser=nil;
    if(theParser == nil)
    {
        theParser=[[self alloc]init];
    }
    
    return theParser;
}

-(id)init
{
    if(self=[super init])
    {
        network=[[TFNetwork alloc]init];
        network.delegate=self;
    }
    
    return self;
}


-(void)ParseXmlAtURL:(NSString *)Url
{
    [network QueryForSourceCode:Url];
}


#pragma mark Network Delegate 

-(void)NetworkDidEndFetcing:(id)ResponseData
{
    if([ResponseData isKindOfClass:[NSError class]])
    {
        //NSLog(@"Error Occured: %@",[ResponseData description]);
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:[ResponseData description] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    
    NSString *strdata=[TFStrings DataToString:ResponseData]; // Will Parse this data
    NSDictionary *xmlDict=[NSDictionary dictionaryWithXMLString:strdata];
    
    // Creating Rss Items
    
    RssItems=[[NSMutableArray alloc]init];
    NSDictionary *Channeldata=[xmlDict objectForKey:@"channel"];
    RssItems=[Channeldata objectForKey:@"item"];
    
    
    [delegate ParserDidFetchRssItems:RssItems];
    
    // test
    //[self CreateEntriesFromRssItems:0];
    
    // Convert Xml dictionary to entry objects
   // [self XmlDataToEntryObject:dict];
}

#pragma NetworkDelegate END


#pragma mark RssEntryCreation

-(void)CreateEntriesFromRssItems:(int) fromIndex
{
    int numItems=[RssItems count];
    int min=fromIndex;
    int max=EntriesPerRequest+fromIndex < numItems ? EntriesPerRequest+fromIndex : numItems;
   
    NSMutableArray *Entries=[[NSMutableArray alloc]init];
    
    for(int i=min ; i<max ;i++)
    {
        NSDictionary *item=[RssItems objectAtIndex:i];
       
        
        Entry *theEntry=[[Entry alloc]init];
        theEntry.link=[item objectForKey:@"link"];
        theEntry.title=[[item objectForKey:@"title"] stringByConvertingHTMLToPlainText]  ;
        NSString *rawDescriptionStr=[item objectForKey:@"description"];
        theEntry.description=[[self HtmlStringToReadableString:rawDescriptionStr] stringByConvertingHTMLToPlainText];
        
        
         //NSLog(@"Text Length: %d",[theEntry.description length]);
        
        theEntry.imageStr=[[item objectForKey:@"media:content"]objectForKey:@"_url"];
        
        theEntry.ImageViewFrame=ImageFrame;
        theEntry.DescLabelFrame=DescFrame;
        
        if(theEntry.imageStr == nil)
        {
            theEntry.ImageViewFrame=CGRectZero;
            theEntry.DescLabelFrame=CGRectMake(3, theEntry.DescLabelFrame.origin.y, 314, theEntry.DescLabelFrame.size.height);
        }
        
        // Label Adjustments
        theEntry.HeaderLabelFrame=[self AdjustLabelFrameForHeaderText:theEntry.title LabelFrame:HeaderFrame];
        
        
        
        theEntry.DescLabelFrame=CGRectMake(theEntry.DescLabelFrame.origin.x, theEntry.HeaderLabelFrame.size.height+3, theEntry.DescLabelFrame.size.width, theEntry.DescLabelFrame.size.height);
        
        theEntry.DescLabelFrame=[self AdjustLabelFrameForDescText:[theEntry description] LabelFrame:theEntry.DescLabelFrame];
        
        if (theEntry.imageStr != nil) {
            theEntry.ImageViewFrame=CGRectMake(theEntry.ImageViewFrame.origin.x, theEntry.DescLabelFrame.origin.y, theEntry.ImageViewFrame.size.width, theEntry.ImageViewFrame.size.height);
        }
        
        
        [Entries addObject:theEntry];
    }
    
    // Fire Delegate
    [delegate ParserDidEndCreatingEntryObjects:Entries];
    
}


#pragma mark RssEntryCreation END




#pragma  mark Label Size Adjustments 


-(CGRect) AdjustLabelFrameForHeaderText:(NSString *)text LabelFrame:(CGRect) _labelFrame
{
   
    
    if(text.length < 38)
    {
        return CGRectMake(_labelFrame.origin.x, _labelFrame.origin.y, _labelFrame.size.width, _labelFrame.size.height/2); 
    }
    
    return _labelFrame;
}



-(CGRect) AdjustLabelFrameForDescText:(NSString *)text LabelFrame:(CGRect) _labelFrame
{
    
    NSLog(@"Text Length : %d",[text length]);
    
    int det;
    float heightRequired;
    
    if(_labelFrame.size.width > 270)
    {
        // Big label (IMPLEMENT)
        // Small Label
         det=(int)1+([text length]/95);
        heightRequired=det *12;
    }
    else
    {
        // Small Label
        det=(int)1+([text length]/55);
        heightRequired=det *12;
    }
   
    NSLog(@"height required : %f",heightRequired);
    NSLog(@"curr height: %f",_labelFrame.size.height);
    
    if(heightRequired > _labelFrame.size.height)
    {
        return _labelFrame;
    }
    
    
    _labelFrame=CGRectMake(_labelFrame.origin.x, _labelFrame.origin.y, _labelFrame.size.width, heightRequired);
    
    return _labelFrame;
}

#pragma  mark Label Size Adjustments  END

/*
    @ This function is used to convert rss description section's (html) string to human readable string
 */
-(NSString *)HtmlStringToReadableString:(NSString *) HtmlString
{
    NSMutableArray *matches=[Regex GetMatch:HtmlString Expression:@"alt=\"(.*?)\""];
    
    if([matches count] == 0)
    {
        // In case the description gives as human readable String 
        return HtmlString;
    }
    NSString *RawStr=[[matches objectAtIndex:0]objectAtIndex:0];
    NSString *finalStr=[RawStr substringWithRange:NSMakeRange(5, [RawStr length]-6)];
    
    
    return finalStr;
}




@end
