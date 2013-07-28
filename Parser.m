//
//  Parser.m
//  YahooRssReader
//
//  Created by aybek can kaya on 7/28/13.
//  Copyright (c) 2013 aybek can kaya. All rights reserved.
//

#import "Parser.h"

// how many rss items will be parsed in every request
#define EntriesPerRequest 11

@implementation Parser
@synthesize delegate;

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
        NSLog(@"Error Occured: %@",[ResponseData description]);
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
        NSArray *keys=[item allKeys];
        
        Entry *theEntry=[[Entry alloc]init];
        theEntry.link=[item objectForKey:@"link"];
        theEntry.title=[item objectForKey:@"title"];
        NSString *rawDescriptionStr=[item objectForKey:@"description"];
        theEntry.description=[self HtmlStringToReadableString:rawDescriptionStr];
        theEntry.imageStr=[[item objectForKey:@"media:content"]objectForKey:@"_url"];
        
        
        
        [Entries addObject:theEntry];
    }
    
    // Fire Delegate
    [delegate ParserDidEndCreatingEntryObjects:Entries];
    
}


#pragma mark RssEntryCreation END



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





/*
-(void)XmlDataToEntryObject:(NSDictionary *)xmlDict
{
    NSArray *keys=[xmlDict allKeys];
    
    NSDictionary *Channeldata=[xmlDict objectForKey:@"channel"];
    
    keys=[Channeldata allKeys];
    
    NSArray *items=[Channeldata objectForKey:@"item"];
    
    for(NSDictionary *itemDict in items)
    {
        Entry *theEntry=[[Entry alloc]init];
        
    }
    
    
}

*/

@end
