//
//  RssReaderYahooTests.h
//  RssReaderYahooTests
//
//  Created by aybek can kaya on 7/28/13.
//  Copyright (c) 2013 aybek can kaya. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "Parser.h"
#import "XMLDictionary.h"

@interface RssReaderYahooTests : SenTestCase<ParserDelegate,TFNetworkDelegate>
{
    Parser *XmlParser;
    TFNetwork *network;
}
@end
