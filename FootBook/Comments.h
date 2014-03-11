//
//  Comments.h
//  FootBookActualGame
//
//  Created by Siddharth Sukumar on 2/2/14.
//  Copyright (c) 2014 Fletcher Rhoads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Friend;

@interface Comments : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) Friend *friend;

@end
