//
//  Tomb.m
//  CemeteryApp
//
//  Created by Joshua Lisojo on 11/12/12.
//  Copyright (c) 2012 KeanU. All rights reserved.
//

#import "Tomb.h"

@implementation Tomb
@synthesize firstName, lastName;
@synthesize birthDate, deathDate;
@synthesize epitaph, section, tombId;


-(id)initWithFirstName:(NSString*)aFirstName
           andLastName:(NSString*)aLastName
          andBirthDate:(NSString*)aBirthDate
          andDeathDate:(NSString*)aDeathDate
            andEpitaph:(NSString*)anEpitaph
            andSection:(NSString*)aSection
                 andID:(NSString*)aTombID
{
    self = [super init];
    if (self) {
        self.firstName = aFirstName;
        self.lastName = aLastName;
        self.birthDate = aBirthDate;
        self.deathDate = aDeathDate;
        self.epitaph = anEpitaph;
        self.section = aSection;
        self.tombId =  aTombID;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Tomb: firstName = %@ lastName = %@ deathDate = %@", self.firstName, self.lastName, self.deathDate];
}

@end
