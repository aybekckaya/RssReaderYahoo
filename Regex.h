//
//  Regex.h
//  Chic1
//
//  Created by aybek can kaya on 3/21/13.
//  Copyright (c) 2013 aybek can kaya. All rights reserved.
//

/*
     Custom Regex Funtions 
    - Hersey + seklinde olacak yani static fonksiyon olacak 
    - Verilen bir stringi parcalama 
     - verilen string icinden webadresi alma
    -verilen string icinden resim dosyalarini alma 
     -verilen stringden user look adresi alma 
 */



#import <Foundation/Foundation.h>

@interface Regex : NSObject

+(NSMutableArray *) GetMatch:(NSString *) StrRaw Expression:(NSString *) Exp;


+ (BOOL)validateString:(NSString *)string withPattern:(NSString *)pattern;


@end
