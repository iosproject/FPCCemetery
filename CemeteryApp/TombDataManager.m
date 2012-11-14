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

- (id)init {
    self = [super init];
    if (self)
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"result" ofType:@"json"];
        NSError *error = nil;
        NSData *tombData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&error];
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:tombData
                                                                 options:kNilOptions
                                                                   error:&error];
        NSArray *jsonData = [jsonDict objectForKey:@"Tombs"];
        
        tombs = [[NSMutableArray alloc]init];
        for (NSDictionary* tombInfo in jsonData)
        {
            Tomb *tomb = [[Tomb alloc]initWithFirstName:[tombInfo objectForKey:@"FirstName"]
                                            andLastName:[tombInfo objectForKey:@"LastName"]
                                           andBirthDate:[tombInfo objectForKey:@"DOB"]
                                           andDeathDate:[tombInfo objectForKey:@"DOD"]
                                             andEpitaph:[tombInfo objectForKey:@"Epitaph"]
                                             andSection:[tombInfo objectForKey:@"Section"]
                                                  andID:[tombInfo objectForKey:@"ID"]];
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

-(NSMutableArray*)filterTombsWithLastName:(NSString*)lastName
{
    if (lastName && [lastName length] > 0)
    {
        NSMutableArray *filterTombs = [[NSMutableArray alloc]initWithArray:tombs];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"lastName LIKE %@", lastName];
        [filterTombs filterUsingPredicate:predicate];
        return filterTombs;
    }
    else
    {
        return tombs;
    }
}

@end
