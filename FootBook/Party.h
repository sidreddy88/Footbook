//
//  Party.h
//  FootBookActualGame
//
//  Created by Siddharth Sukumar on 2/2/14.
//  Copyright (c) 2014 Fletcher Rhoads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Friend;

@interface Party : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * theme;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSSet *guests;
@end

@interface Party (CoreDataGeneratedAccessors)

- (void)addGuestsObject:(Friend *)value;
- (void)removeGuestsObject:(Friend *)value;
- (void)addGuests:(NSSet *)values;
- (void)removeGuests:(NSSet *)values;

@end
