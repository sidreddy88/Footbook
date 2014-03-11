//
//  Friend.h
//  FootBookActualGame
//
//  Created by Siddharth Sukumar on 2/2/14.
//  Copyright (c) 2014 Fletcher Rhoads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comments, Party;

@interface Friend : NSManagedObject

@property (nonatomic, retain) NSNumber * feet;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSNumber * isPhtooAlreadyAdded;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * shoesize;
@property (nonatomic, retain) NSSet *comments;
@property (nonatomic, retain) NSSet *parties;
@end

@interface Friend (CoreDataGeneratedAccessors)

- (void)addCommentsObject:(Comments *)value;
- (void)removeCommentsObject:(Comments *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

- (void)addPartiesObject:(Party *)value;
- (void)removePartiesObject:(Party *)value;
- (void)addParties:(NSSet *)values;
- (void)removeParties:(NSSet *)values;

@end
