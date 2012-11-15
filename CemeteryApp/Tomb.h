//
//  Tomb.h
//  CemeteryApp
//
//  Created by Joshua Lisojo on 11/12/12.
//  Copyright (c) 2012 KeanU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tomb : NSObject
{
    NSString* tombId;
    NSString* firstName;
    NSString* lastName;
    NSString* deathDate;
    NSString* birthDate;
    NSString* epitaph;
    NSString* section;
}


@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (strong, nonatomic) NSString* deathDate;
@property (strong, nonatomic) NSString* birthDate;
@property (strong, nonatomic) NSString* epitaph;
@property (strong, nonatomic) NSString* section;
@property (strong, nonatomic) NSString* tombId;

-(id)initWithFirstName:(NSString*)aFirstName
           andLastName:(NSString*)aLastName
          andBirthDate:(NSString*)aBirthDate
          andDeathDate:(NSString*)aDeathDate
            andEpitaph:(NSString*)anEpitaph
            andSection:(NSString*)aSection
                 andID:(NSString*)aTombID;
@end
