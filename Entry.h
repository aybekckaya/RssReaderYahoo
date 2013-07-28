//
//  Entry.h
//  xmlParse
//
//  Created by aybek can kaya on 7/27/13.
//  Copyright (c) 2013 aybek can kaya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Entry : NSObject
{
    NSString *title;
    NSString *link;
    NSString *imageStr;
    NSString *publishDateStr;
    NSString *description;
    
}

@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *link;
@property(nonatomic,strong) NSString *imageStr;
@property(nonatomic,strong) NSString *publishDateStr;
@property(nonatomic,strong) NSString *description;

@end
