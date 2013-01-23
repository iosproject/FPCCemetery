//
//  JSONHandler.m
//  CemeteryApp
//
//  Created by Jason on 11/30/12.
//  Copyright (c) 2012 KeanU. All rights reserved.
//

#import "JSONHandler.h"

@implementation JSONHandler
@synthesize jsonArray;

-(id)init {
    self = [super init];
    
    if(self)
    {
        
        NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [pathArray objectAtIndex:0];
        NSString *localFile = [documentsDir stringByAppendingPathComponent:@"result.json"];        
        
        
        
        
        NSArray *newClientJson = [[NSArray alloc] init];
        NSData *newClientresponse = [NSData dataWithContentsOfFile:localFile];
        
        newClientJson = [NSJSONSerialization JSONObjectWithData:newClientresponse options:NSJSONReadingMutableContainers error:nil];
        jsonArray = [[NSArray alloc] initWithArray:newClientJson];
        
        
        
        //IF there is no local json file then we know we need to copy from the DB
        if(![[NSFileManager defaultManager] fileExistsAtPath:[documentsDir stringByAppendingPathComponent:@"result.json"]])
        {
            NSURL *url = [NSURL URLWithString:@"http://eve.kean.edu/~jplisojo/result2.json"];
            NSData *data = [NSData dataWithContentsOfURL:url];
            [data writeToFile:localFile atomically:YES];
            
            
        }
        else
        {
            //We have a local version of the DB but is it the latest?
            //Check for the updated version
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://eve.kean.edu/~jplisojo/result2.json"]];
            NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            NSError *error = nil;
            NSArray *serverJson = [[NSArray alloc] init];
            serverJson = [NSJSONSerialization JSONObjectWithData:response options:0 error:&error];
        
            NSData *clientresponse = [NSData dataWithContentsOfFile:localFile];
            NSArray *clientJson = [[NSMutableArray alloc] init];
            clientJson = [NSJSONSerialization JSONObjectWithData:clientresponse options:NSJSONReadingMutableContainers error:nil];
        
            NSDictionary *serverdict = [[NSDictionary alloc] init];
            NSDictionary *clientdict = [[NSDictionary alloc] init];
            
            clientdict = [clientJson objectAtIndex:0];
            serverdict = [serverJson objectAtIndex:0];
            
            if([[clientdict objectForKey:@"LastUpdated"] intValue] < [[serverdict objectForKey:@"LastUpdated"] intValue])
            {
                //Copy from server to local
                NSURL *url = [NSURL URLWithString:@"http://localhost:8888/result.json"];
                NSData *data = [NSData dataWithContentsOfURL:url];
                [data writeToFile:localFile atomically:YES];
                
                NSData *newClientresponse = [NSData dataWithContentsOfFile:localFile];
                
                newClientJson = [NSJSONSerialization JSONObjectWithData:newClientresponse options:NSJSONReadingMutableContainers error:nil];
                jsonArray = [[NSArray alloc] initWithArray:newClientJson];
            }
            else
            {
                jsonArray = [[NSArray alloc] initWithArray:clientJson];
            }
        }
    }
    return self;
}
@end
