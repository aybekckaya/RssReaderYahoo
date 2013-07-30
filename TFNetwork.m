//
//  TFNetwork.m
//  NetWork
//
//  Created by aybek can kaya on 5/8/13.
//  Copyright (c) 2013 aybek can kaya. All rights reserved.
//

#import "TFNetwork.h"

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

@implementation TFNetwork

@synthesize delegate;

-(id)init
{
    if(self=[super init])
    {
        
    }
    
    // Check Socket ?? olabilir . Anlik hata mesaji iletilebilir 
    
    return self;
}

// Hata olunca NSError donuyor 
-(void)QueryForJSON:(NSString *)_URL 
{
    
      
    
    NSURL *url = [NSURL URLWithString:_URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        //On Success
     //   NSLog(@"JSON Parse Edilmis: %@", JSON);
        
        SuppressPerformSelectorLeakWarning(
                                          // [self.Delegate performSelector:_Selector withObject:JSON];
                                              [delegate NetworkDidEndFetcing:JSON];
                                           );
      
       
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        // On Error
        SuppressPerformSelectorLeakWarning(
                                          // [self.Delegate performSelector:_Selector withObject:error];
                                           [delegate NetworkDidEndFetcing:error];
                                           );
        
    }];
    
    [operation start];

    
  
}


// Hata olunca NSError donuyor
-(void)QueryForSourceCode:(NSString *)_URL 
{
    NSURL *url = [NSURL URLWithString:_URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation=[[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    
    
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
       
        
        
        // On Success
        [delegate NetworkDidEndFetcing:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //On Failure
        [delegate NetworkDidEndFetcing:error];
                                        
    }
     ];
    
    [operation start];
    
    
}



-(void)QueryForXML:(NSString *)URL 
{
    NSURL *url2 = [NSURL URLWithString:URL];
    NSURLRequest *request2 = [NSURLRequest requestWithURL:url2];
    
    AFXMLRequestOperation *operation2 = [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request2
        success:^(NSURLRequest *request2, NSHTTPURLResponse *response2, NSXMLParser *XMLParser) {
             //   NSLog(@"TESTING PARSING");
           // Xml Parse edilecek daha
         //   XMLParser.delegate=self;
                           
        } failure:^(NSURLRequest *request2, NSHTTPURLResponse *response2, NSError *error2, NSXMLParser *XMLParser) {
            
            [delegate NetworkDidEndFetcing:error2];
        }];
    [operation2 start];
}






@end
