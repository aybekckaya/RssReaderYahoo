//
//  Parser.h
//  YahooRssReader
//
//  Created by aybek can kaya on 7/28/13.
//  Copyright (c) 2013 aybek can kaya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLDictionary.h"
#import "Entry.h"
#import "TFNetwork.h"
#import "TFStrings.h"
#import "Regex.h"
#import "NSString+HTML.h"

@class  Parser;

@protocol ParserDelegate <NSObject>

@required

-(void)ParserDidEndCreatingEntryObjects:(NSMutableArray *)EntryObjects;

-(void)ParserDidFetchRssItems:(NSArray *)RssArr;

@end

@interface Parser : NSObject<TFNetworkDelegate>
{
    TFNetwork *network;
    NSMutableArray *RssItems; // all items but havent created object from them yet
    id<ParserDelegate> delegate;
    
    CGRect DescFrame;
    CGRect HeaderFrame;
     CGRect ImageFrame;
}
@property(nonatomic,strong) id<ParserDelegate > delegate;
@property(nonatomic)  CGRect DescFrame;
@property(nonatomic)  CGRect HeaderFrame;
@property(nonatomic)  CGRect ImageFrame;

/*
    @ Singleton Parser Object
 */
+(Parser *)SharedParser;


-(id)init;


-(void)ParseXmlAtURL:(NSString *)Url;


-(void)CreateEntriesFromRssItems:(int) fromIndex;

@end
