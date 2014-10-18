//
//  Event.h
//  OurMaps
//
//  Created by Wei Lu and Jiangchuan Huang on 9/7/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Event : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSDate *eventTime;
@property (nonatomic, strong) NSString *eventPlace;
//@property (nonatomic, strong) NSSet *participants;
@property (nonatomic, strong) NSArray *participants;
@property (nonatomic, strong) PFUser *owner;
@property (nonatomic, strong) PFObject *venue;

+ (id)eventWithTitle:(NSString *)title;

// Builder class methods
+ (Event *)eventFromPFObject:(PFObject *)anObject;
+ (PFObject *)eventToPFObject:(Event *)anEvent;

@end
