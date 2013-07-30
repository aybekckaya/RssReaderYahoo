//
//  TFNetwork.h
//  NetWork
//
//  Created by aybek can kaya on 5/8/13.
//  Copyright (c) 2013 aybek can kaya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "TFStrings.h"

@class TFNetwork;

@protocol TFNetworkDelegate <NSObject,NSXMLParserDelegate>

-(void)NetworkDidEndFetcing:(id) ResponseData;

@end


@interface TFNetwork : NSObject
{
   // id Delegate;
    
    id<TFNetworkDelegate> delegate;
    
}

@property(nonatomic,strong) id <TFNetworkDelegate> delegate;
//@property(strong,nonatomic) id Delegate;

-(id)init;

-(void)QueryForJSON:(NSString *)_URL ;

-(void)QueryForSourceCode:(NSString *)URL ;

-(void)QueryForXML:(NSString *)URL ;


@end
