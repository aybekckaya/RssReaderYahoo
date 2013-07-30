//
//  RssReaderYahooTests.m
//  RssReaderYahooTests
//
//  Created by aybek can kaya on 7/28/13.
//  Copyright (c) 2013 aybek can kaya. All rights reserved.
//

#import "RssReaderYahooTests.h"

@implementation RssReaderYahooTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
   
    
    XmlParser =[Parser SharedParser];
   STAssertNotNil(XmlParser, @"Xml Parser Should Not Be Null");
    
    XmlParser.delegate=self;
    
      
  
    
    
}





- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}




- (void)testExample
{
    [self XmlParserInstanceTest];
    [self XmlParserTestForURL];
    [self XmlDataTest];
    
}



/*
    @ singleton object : all instances must be same 
 */
-(void)XmlParserInstanceTest
{
   
        Parser *tempParser=[Parser SharedParser];
        STAssertEqualObjects(tempParser, XmlParser, @"Objects Should be equal");
    
}



#pragma URL Test

/*
    @ for different urls does the code take correct parameters
 */
-(void)XmlParserTestForURL
{
    [XmlParser ParseXmlAtURL:@"http://www.google.com"]; // non xml source
    [XmlParser ParseXmlAtURL:@"abcd"]; // corrupted string
    [XmlParser ParseXmlAtURL:@"http://news.yahoo.com/rss/"]; // correct xml source
}


-(void)ParserDidFetchRssItems:(NSArray *)RssArr
{

    STAssertNil(RssArr, @"RssArr is nil");
}




#pragma URL Test End



#pragma mark Xml Data Tests

-(void)XmlDataTest
{
    NSString *url=@"http://news.yahoo.com/rss/";
    NSString *source=[self WebRequest:url];
    NSMutableArray *Arr=[XmlParser XmlToNSArray:source];
    if ([Arr count] == 0) {
        STFail(@"Parser XmlToNsArray should not be nil");
    }
    
    // corrupted URL test 
    url=@"http://news.yahoo.com/rss1asd/";
     source=[self WebRequest:url];
    Arr=[XmlParser XmlToNSArray:source];
    
    if ([Arr count] != 0) {
        STFail(@"Parser XmlToNsArray should not be nil (incorrectURL given)");
    }
    
    
}






#pragma mark XmlDataTests END




#pragma Entry Object Tests



#pragma EntryObjectTest End



#pragma WebRequest Sync


-(NSString *)WebRequest:(NSString *)URL
{
    // Send a synchronous request
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
                                          returningResponse:&response
                                                      error:&error];
     return [TFStrings DataToString:data];
    
}

#pragma WebRequest Sync END

@end
