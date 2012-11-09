//
//  SearchFilter.m
//  CemeteryApp
//
//  Created by Joshua Lisojo on 11/8/12.
//  Copyright (c) 2012 KeanU. All rights reserved.
//

#import "SearchFilter.h"

@implementation SearchFilter


- (IBAction)getJsonData:(id)sender
{
    
}

+ (BOOL)regEx:(NSString *)search: (NSString *)toBeSearched
{
    NSError* error = nil;
    NSRegularExpression* regex = [NSRegularExpression
                                  regularExpressionWithPattern:search
                                  options:NSRegularExpressionCaseInsensitive
                                  error:&error];
    
    NSTextCheckingResult *regexResult = [regex firstMatchInString:toBeSearched options:0 range:NSMakeRange(0, [toBeSearched length])];
    
    //If the name matches the search text than return true
    if(regexResult)
    {
        return true;
    }
    return false;
}

+ (NSMutableArray *)getInfo:(NSString *)personId
{
    NSMutableArray *personInfo = [[NSMutableArray alloc] init];
//    data = [jsonArray objectAtIndex:[personId intValue]];
//    
//    NSArray *columns = [[NSMutableArray alloc] init];
//    columns = [JSONTestViewController getDBColumns:data];
//    
//    for(int i = 0;i < [columns count]; i++)
//    {
//        [personInfo addObject:[columns objectAtIndex:i]];
//    }
//    
//    NSLog(@"%@",personInfo);
    return personInfo;
}

+ (NSMutableArray *)parseJson:(NSMutableArray *)jsonArray: (NSString *)search: (NSString *) filter
{
    
}

+ (void) connectToJson
{
    
}

+ (NSMutableArray *)getDBColumns
{
    
}

@end
