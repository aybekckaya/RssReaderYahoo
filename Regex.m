//
//  Regex.m
//  Chic1
//
//  Created by aybek can kaya on 3/21/13.
//  Copyright (c) 2013 aybek can kaya. All rights reserved.
//

#import "Regex.h"

@implementation Regex


/*
 Match olan stringleri dondurecek
 
 match rangeAtIndex:0 tum stringi veriyor
 */
+(NSMutableArray *)GetMatch:(NSString *)StrRaw Expression:(NSString *)Exp
{
    NSMutableArray *MatchStrArr=[[NSMutableArray alloc] init];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:Exp options:NSRegularExpressionCaseInsensitive error:NULL];
    NSString *str = StrRaw;
   // NSTextCheckingResult *match = [regex firstMatchInString:str options:0 range:NSMakeRange(0, [str length])];
    NSTextCheckingResult *AllMatches=[regex matchesInString:str options:0 range:NSMakeRange(0, [str length])];
    //int NumMatches=[match numberOfRanges];
    
    NSMutableArray *ArrayOfMatches=[[NSMutableArray alloc] init]; // Final Array 
    
    for (NSTextCheckingResult *match in AllMatches)
    {
         int NumMatches=[match numberOfRanges];
        NSMutableArray *InlineArr=[[NSMutableArray alloc] init];
        
            for(int i=0; i<NumMatches ; i++)
            {
                 NSMutableArray *matchStr= [str substringWithRange:[match rangeAtIndex:i]] ;
                
                [InlineArr addObject:matchStr];
                
             //   NSLog(@"Matched Str %d: %@",i,matchStr);
            }

        [ArrayOfMatches addObject:InlineArr];
       // NSString* substringForMatch = [str substringWithRange:match.range];
       // NSLog(@"Extracted URL: %@",substringForMatch);
        
      //  [arrayOfURLs addObject:substringForMatch];
    }
    
    /*
    for(int i=0; i<NumMatches ; i++)
    {
        NSMutableArray *matchStr= [str substringWithRange:[match1 rangeAtIndex:i]] ; // gives the first captured group in this example
       // [MatchStrArr addObject:matchStr];
    }
    */
    return ArrayOfMatches;

}

// Validate the input string with the given pattern and
// return the result as a boolean
+ (BOOL)validateString:(NSString *)string withPattern:(NSString *)pattern
{
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSAssert(regex, @"Unable to create regular expression");
    
    NSRange textRange = NSMakeRange(0, string.length);
    NSRange matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];
    
    BOOL didValidate = NO;
    
    // Did we find a matching range
    if (matchRange.location != NSNotFound)
        didValidate = YES;
    
    return didValidate;
}

+(NSMutableArray *)GetURLs:(NSString *)StrRaw
{
    NSMutableArray *Matches=[[NSMutableArray alloc] init];
    
    Matches=[self GetMatch:StrRaw Expression:@"<a(.*?)href=('|\")(.*?)('|\")(.*?)</a>"];
    
    return Matches;
}

@end
