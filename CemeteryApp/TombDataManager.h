//
//  TombDataManager.h
//  CemeteryApp
//
//  Created by Joshua Lisojo on 11/12/12.
//  Copyright (c) 2012 KeanU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TombDataManager : NSObject
{
    NSMutableArray* tombs;
}

@property (readonly)NSMutableArray* tombs;

+(TombDataManager *)instance;
-(NSArray*)filterTombsWithLastName:(NSString*)lastName;


@end
