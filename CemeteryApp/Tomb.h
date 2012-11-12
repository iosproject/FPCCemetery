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


@property (retain, nonatomic) NSString* firstName;
@property (retain, nonatomic) NSString* lastName;
@property (retain, nonatomic) NSString* deathDate;
@property (retain, nonatomic) NSString* birthDate;
@property (retain, nonatomic) NSString* epitaph;
@property (retain, nonatomic) NSString* section;
@property (retain, nonatomic) NSString* tombId;

-(id)initWithFirstName:(NSString*)aFirstName
           andLastName:(NSString*)aLastName
          andBirthDate:(NSString*)aBirthDate
          andDeathDate:(NSString*)aDeathDate
            andEpitaph:(NSString*)anEpitaph
            andSection:(NSString*)aSection
                 andID:(NSString*)aTombID;
@end
