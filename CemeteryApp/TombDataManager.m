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

@synthesize tombs;
@synthesize jsonArray;
@synthesize didGetCols;

- (id)init {
    self = [super init];
    if (self)
    {
        //Connect to the JSON file on the local MAMP server
        //NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:8888/result.json"]]; //131.125.78.212
        
        //Connect to the JSON file on the EVE server
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://eve.kean.edu/~jplisojo/result2.json"]];

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
        NSArray *columns = [[NSArray alloc] init];
        for (int i =0; i < [jsonArray count]; i++)
        {
            dict = [jsonArray objectAtIndex:i];
            columns = [TombDataManager getDBColumns:dict];
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
         
         NSPredicate *predicate;
         if([filter isEqualToString:@"All"])
         {
            predicate = [NSPredicate predicateWithFormat:@"(lastName CONTAINS[cd] %@) OR (birthDate CONTAINS[cd] %@) OR (birthDate CONTAINS[cd] %@) OR (section CONTAINS[cd] %@)",search,search,search,search];
         }
         else if([filter isEqualToString:@"lastName"])
         {
             predicate = [NSPredicate predicateWithFormat:@"lastName CONTAINS[cd] %@",search];
         }
         else if ([filter isEqualToString:@"Date of Birth"])
         {
             predicate = [NSPredicate predicateWithFormat:@"birthDate CONTAINS[cd] %@",search];
         }
         else if ([filter isEqualToString:@"Date of Death"])
         {
             predicate = [NSPredicate predicateWithFormat:@"deathDate CONTAINS[cd] %@",search];
         }
         else if ([filter isEqualToString:@"Section"])
         {
             predicate = [NSPredicate predicateWithFormat:@"section CONTAINS[cd] %@",search];
         }
         else
         {
             predicate = [NSPredicate predicateWithFormat:@"years CONTAINS[cd] %@",search];
         }
         [filterTombs filterUsingPredicate:predicate];
         return filterTombs;
     }
     else
     {
         return tombs;
     }
 }

+(NSArray *)getDBColumns:(NSDictionary *)jsonData
{
    return [jsonData allKeys];
}
@end
