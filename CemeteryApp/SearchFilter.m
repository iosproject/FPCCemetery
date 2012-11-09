//
//  SearchFilter.m
//  CemeteryApp
//
//  Created by Joshua Lisojo on 11/8/12.
//  Copyright (c) 2012 KeanU. All rights reserved.
//

#import "SearchFilter.h"

@implementation SearchFilter

@synthesize search;
@synthesize filterF;

+(void)connectToJson
{
    //Connect to the JSON file on the server
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://eve.kean.edu/~jplisojo/result.json"]];
//    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    NSError *jsonParsingError = nil;
//    NSMutableArray* jsonArray = [[NSMutableArray alloc] init];
//    jsonArray = [NSJSONSerialization JSONObjectWithData:response options:0 error:&jsonParsingError];
//    
//    if(!jsonArray)
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could Not Retrieve Data"
//                                                        message:@"The server is currently unavailable."
//                                                       delegate:self
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:@"Retry",nil];
//        [alert show];
//    }
//    else
//    {
//        NSLog(@"%@",[SearchFilter parseJson:jsonArray:@"10":@"All"]);
//        //[JSONTestViewController parseJson:jsonArray:@"1700":@"First Name"];
//    }
    
}

+ (NSMutableArray *)parseJson:(NSMutableArray *)jsonArray: (NSString *)search: (NSString *) filter
{
    NSString *filterField = NULL;
    //Remove Spacing
    if (filter == @"First Name")
    {
        filterField = @"FirstName";
    }
    else if (filter == @"Last Name")
    {
        filterField = @"LastName";
    }
    else if (filter == @"Date of Birth")
    {
        filterField = @"DOB";
    }
    else if (filter == @"Date of Death")
    {
        filterField = @"DOD";
    }
    else if (filter == @"Internet Link")
    {
        filterField = @"InternetLink";
    }
    else if (filter == @"Sexton's Notes")
    {
        filterField = @"SextonsNotes";
    }
    else
    {
        filterField = filter;
    }
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    NSMutableArray *idArray;
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    if(jsonArray)
    {
        if(filterField == @"All")
        {
            NSString *field = @"";
            NSString *year = NULL;
            BOOL isAMatch = 0;
            //Check if the search is numeric
            if(search.intValue > 0)
            {
                //If the number length is 4 then we are looking for a DOD of DOB
                //we are looking for an ID
                if(search.length == 4)
                {
                    //return DOD and DOB
                    field = @"DOD";
                    
                    for(int i=0; i<[jsonArray count];i++)
                    {
                        isAMatch = 0;
                        data= [jsonArray objectAtIndex:i];
                        NSString *dobData = (NSString *)[data objectForKey:@"DOB"];
                        NSString *dodData = (NSString *)[data objectForKey:@"DOD"];
                        
                        NSString *firstName = (NSString *)[data objectForKey:@"FirstName"];
                        NSString *lastName = (NSString *)[data objectForKey:@"LastName"];
                        
                        //Match the DOB that match
                        if(![dobData isKindOfClass:[NSNull class]] && (![dobData isEqualToString:@""]))
                        {
                            year = [dobData substringToIndex:4];
                            //Since we are searhing numeric values we only will return names of those who match those numbers
                            if(!([dobData isKindOfClass:[NSNull class]]) && ([year isEqualToString:search]))
                            {
                                NSLog(@"%@", dobData);
                                [dataArray addObject:firstName];
                                [dataArray addObject: lastName];
                                [idArray addObject:dobData];
                                
                                isAMatch = 1;
                            }
                        }
                        
                        //If the match is already made for DOB then no need to Match a DOD
                        if(!isAMatch)
                        {
                            
                            //Since we are searhing numeric values we only will return names of those who match those numbers
                            if(!([dodData isKindOfClass:[NSNull class]]) && (![dodData isEqualToString:@""]) && ([year isEqualToString:search]))
                            {
                                NSLog(@"%@", dodData);
                                [dataArray addObject:firstName];
                                [dataArray addObject: lastName];
                                [idArray addObject:dodData];
                            }
                        }
                        
                    }
                }
                else
                {
                    
                    for(int i=0; i<[jsonArray count];i++)
                    {
                        data= [jsonArray objectAtIndex:i];
                        NSString *fieldData = (NSString *)[data objectForKey:@"Ref"];
                        NSString *firstName = (NSString *)[data objectForKey:@"FirstName"];
                        NSString *lastName = (NSString *)[data objectForKey:@"LastName"];
                        
                        
                        //Since we are searhing numeric values we only will return names of those who match those numbers
                        if(!([fieldData isKindOfClass:[NSNull class]]) && ([fieldData isEqualToString:search]))
                        {
                            NSLog(@"%@", fieldData);
                            [dataArray addObject:firstName];
                            [dataArray addObject: lastName];
                            [idArray addObject:fieldData];
                        }
                        
                    }
                }
                
            }
            else
            {
                for(int i=0; i<[jsonArray count];i++)
                {
                    data= [jsonArray objectAtIndex:i];
                    NSString* firstName = (NSString*)[data objectForKey:@"FirstName"];
                    NSString* lastName = (NSString*)[data objectForKey:@"LastName"];
                    
                    //If the first and last names are not null and match the search then display it
                    //and add to the NSArray which is being returned
                    if((!([firstName isKindOfClass:[NSNull class]])&&!([lastName isKindOfClass:[NSNull class]])) && ([SearchFilter regEx:search: firstName] || [SearchFilter regEx:[SearchFilter formRegExString:search]: lastName]))
                    {
                        NSLog(@"%@ %2@", firstName, lastName);
                        [dataArray addObject:firstName];
                        [dataArray addObject: lastName];
                        [idArray addObject:[data objectForKey:@"UID"]];
                    }
                }
            }
        }
        else
        {
            for(int i=0; i<[jsonArray count];i++)
            {
                data= [jsonArray objectAtIndex:i];
                NSString *fieldData = (NSString *)[data objectForKey:filterField];
                NSString *firstName = (NSString *)[data objectForKey:@"FirstName"];
                NSString *lastName = (NSString *)[data objectForKey:@"LastName"];
                if(!([fieldData isKindOfClass:[NSNull class]]) && [SearchFilter regEx:[SearchFilter formRegExString:search]:fieldData])
                {
                    NSLog(@"%@ %2@", firstName, lastName);
                    [dataArray addObject:firstName];
                    [dataArray addObject: lastName];
                    [idArray addObject:[data objectForKey:@"UID"]];
                }
                
            }
        }
    }
    
    if([dataArray count] == 0)
    {
        [dataArray addObject:[NSString stringWithFormat:@"No Matches Found!"]];
    }
    return dataArray;
}

+ (BOOL)regEx:(NSString *)search: (NSString *)toBeSearched
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

+ (NSMutableArray *)getInfo:(NSString *)personId: (NSMutableArray *)jsonArray: (NSMutableDictionary *)data
{
    NSMutableArray *personInfo = [[NSMutableArray alloc] init];
    data= [jsonArray objectAtIndex:[personId intValue]];
    
    NSArray *columns = [[NSMutableArray alloc] init];
    columns = [SearchFilter getDBColumns:data];
    
    for(int i = 0;i < [columns count]; i++)
    {
        [personInfo addObject:[columns objectAtIndex:i]];
    }
    
    NSLog(@"%@",personInfo);
    return personInfo;
}

+ (NSArray *)getDBColumns:(NSMutableDictionary *)data
{
    NSArray *keys = [[NSMutableArray alloc] init];
    keys = [data allKeys];
    
    return [SearchFilter reorderDBColumns:keys];
}

+(NSArray *)reorderDBColumns:(NSArray *)columns
{
    NSMutableArray *cols = [NSMutableArray arrayWithArray:columns];
    
    NSLog(@"%@", cols);
    NSMutableArray *finalCols = [[NSMutableArray alloc] init];
    
    if([SearchFilter columnsExists:cols :@"FirstName"])
    {
        [finalCols addObject:@"First Name"];
        [SearchFilter removeCol:cols :@"FirstName"];
        
    }
    if([SearchFilter columnsExists:cols :@"Middle"])
    {
        [finalCols addObject:@"Middle Name"];
        [SearchFilter removeCol:cols :@"Middle"];
    }
    
    if([SearchFilter columnsExists:cols :@"LastName"])
    {
        [finalCols addObject:@"Last Name"];
        [SearchFilter removeCol:cols :@"LastName"];
    }
    
    if([SearchFilter columnsExists:cols :@"DOB"])
    {
        [finalCols addObject:@"Date of Death"];
        [SearchFilter removeCol:cols :@"DOB"];
    }
    
    if([SearchFilter columnsExists:cols :@"DOD"])
    {
        [finalCols addObject:@"Date of Birth"];
        [SearchFilter removeCol:cols :@"DOD"];
    }
    
    if([SearchFilter columnsExists:cols :@"Years"])
    {
        [finalCols addObject:@"Years"];
        [SearchFilter removeCol:cols :@"Years"];
    }
    
    if([SearchFilter columnsExists:cols :@"Months"])
    {
        [finalCols addObject:@"Months"];
        [SearchFilter removeCol:cols :@"Months"];
    }
    
    if([SearchFilter columnsExists:cols :@"Section"])
    {
        [finalCols addObject:@"Section"];
        [SearchFilter removeCol:cols :@"Section"];
    }
    
    for(int i = 0; i < [cols count]; i++)
    {
        if(![[cols objectAtIndex:i] isEqualToString:@"UID"])
        {
            [finalCols addObject:[cols objectAtIndex:i]];
        }
    }
    
    NSLog(@"%@", finalCols);
    return finalCols;
}

+(BOOL)columnsExists:(NSMutableArray *)colArray:(NSString *)col
{
    for(int i = 0;i<[colArray count];i++)
    {
        if([[colArray objectAtIndex:i] isEqualToString:col])
        {
            return true;
        }
    }
    
    return false;
}

+(void)removeCol:(NSMutableArray *)columnArray:(NSString *)columnToBeRemoved
{
    for(int i = 0; i < [columnArray count]; i++)
    {
        if([[columnArray objectAtIndex:i] isEqualToString:columnToBeRemoved])
        {
            [columnArray removeObjectAtIndex:i];
            break;
        }
    }
}

+(NSMutableArray *)dateSearchFilters
{
    NSMutableArray *dates = [[NSMutableArray alloc] init];
    
    [dates addObject:@"1700's"];
    [dates addObject:@"1700 - 1750"];
    [dates addObject:@"1750 - 1800"];
    
    [dates addObject:@"1800's"];
    [dates addObject:@"1800 - 1850"];
    [dates addObject:@"1850 - 1900"];
    
    return dates;
}


+(NSMutableArray *)sectionSearchFilters
{
    NSMutableArray *sections = [[NSMutableArray alloc] init];
    
    [sections addObject:@"A - C"];
    [sections addObject:@"D - F"];
    [sections addObject:@"G - I"];
    [sections addObject:@"J - L"];
    [sections addObject:@"M - O"];
    [sections addObject:@"P - R"];
    [sections addObject:@"S - U"];
    [sections addObject:@"W - Z"];
    
    return sections;
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
        [regex appendString:searchFilter];
        [regex appendString:@"(\\S)?)"];
    }
    return regex;
}

@end
