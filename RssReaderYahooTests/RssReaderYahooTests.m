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
}



/*
    @ singleton object : all instances must be same 
 */
-(void)XmlParserInstanceTest
{
    for (int i=0; i<10; i++) {
        Parser *tempParser=[Parser SharedParser];
        STAssertEqualObjects(tempParser, XmlParser, @"Objects Should be equal");
    }
}



#pragma URL Test

/*
    @ for different urls does the code take correct parameters
 */
-(void)XmlParserTestForURL
{
    
}

#pragma URL Test End

@end
