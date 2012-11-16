//
//  TombDataManager.m
//  CemeteryApp
//
//  Created by Joshua Lisojo on 11/12/12.
//  Copyright (c) 2012 KeanU. All rights reserved.
//

#import "TombDataManager.h"
#import "Tomb.h"

@implementation TombDataManager
{

    
}

@synthesize tombs;
@synthesize jsonArray;

- (id)init {
    self = [super init];
    if (self)
    {
        //Connect to the JSON file on the server
        //NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:8888/result.json"]]; //131.125.78.212
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://eve.kean.edu/~jplisojo/result2.json"]]; //131.125.78.212

        NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSError *jsonParsingError = nil;
        jsonArray = [[NSMutableArray alloc] init];
        jsonArray = [NSJSONSerialization JSONObjectWithData:response options:0 error:&jsonParsingError];
        
        if(!jsonArray)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could Not Retrieve Data"
                                                            message:@"The server is currently unavailable."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:@"Retry",nil];
            [alert show];
        }
        
        NSDictionary *dict = [[NSDictionary alloc] init];
        tombs = [[NSMutableArray alloc]init];
        for (int i =0; i < [jsonArray count]; i++)
        {
            dict = [jsonArray objectAtIndex:i];
            tomb = [[Tomb alloc]initWithFirstName:[dict objectForKey:@"FirstName"]
                                            andLastName:[dict objectForKey:@"LastName"]
                                           andBirthDate:[dict objectForKey:@"DOB"]
                                           andDeathDate:[dict objectForKey:@"DOD"]
                                             andEpitaph:[dict objectForKey:@"Epitaph"]
                                             andSection:[dict objectForKey:@"Section"]
                                                  andID:[dict objectForKey:@"ID"]];
            [tombs addObject:tomb];
        }
        
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"DataController: tombs =%@", self.tombs];
}

+(TombDataManager *)instance
{
    static TombDataManager* instance = nil;
    
    if (!instance)
    {
        instance = [[TombDataManager alloc]init];
    }
    return instance;
}

-(NSMutableArray*)filterTombs:(NSString*)search:(NSString *)filter
 {

     if (search && [search length] > 0)
     {
         NSMutableArray *filterTombs = [[NSMutableArray alloc]initWithArray:tombs];
         NSPredicate *predicate = [NSPredicate predicateWithFormat:@"lastName BEGINSWITH %@", search];
         [filterTombs filterUsingPredicate:predicate];
         return filterTombs;
     }
     else
     {
         return tombs;
     }
 }
+(NSString *)formRegExString:(NSString *)searchFilter
{
    NSMutableString *regex = [[NSMutableString alloc] init];
    [regex appendString:@""];
    NSRange range = [searchFilter rangeOfString:@"-"];
    NSArray *alphabetArray = [[NSArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
    
    if (range.length > 0)
    {
        [regex appendString:@"(^"];
        NSString * firstLetter = [searchFilter substringToIndex:1];
        NSString * lastLetter = [searchFilter substringFromIndex:[searchFilter length]-1];
        NSUInteger index = 0;
        while (![[alphabetArray objectAtIndex:index] isEqualToString:firstLetter])
        {
            index++;
        }
        [regex appendString:@""];
        [regex appendString:[alphabetArray objectAtIndex:index]];
        [regex appendString:@"(\\S)?)|(^"];
        while (![[alphabetArray objectAtIndex:index] isEqualToString:lastLetter]) {
            index++;
            [regex appendString:[alphabetArray objectAtIndex:index]];
            if((index != [alphabetArray count]-1) && [[alphabetArray objectAtIndex:index +1] isEqualToString:lastLetter])
            {
                [regex appendString:@"(\\S)?)|(^"];
            }
            else
            {
                [regex appendString:@"(\\S)?)"];
                
            }
        }
    }
    else
    {
        [regex appendString:@"^"];
        [regex appendString:searchFilter];
        [regex appendString:@"(\\S)?"];
    }
    return regex;
}

+(BOOL)regEx:(NSString *)search: (NSString *)toBeSearched
{
    //The regular expression which is used to match the text in the search field
    
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


@end
