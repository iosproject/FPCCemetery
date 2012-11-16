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
         NSPredicate *predicate = [NSPredicate predicateWithFormat:@"lastName CONTAINS[cd] %@", search];
         [filterTombs filterUsingPredicate:predicate];
         return filterTombs;
     }
     else
     {
         return tombs;
     }
 }

@end
