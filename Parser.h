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
    
}
@property(nonatomic,strong) id<ParserDelegate > delegate;

/*
    @ Singleton Parser Object
 */
+(Parser *)SharedParser;


-(id)init;


-(void)ParseXmlAtURL:(NSString *)Url;


-(void)CreateEntriesFromRssItems:(int) fromIndex;

@end
