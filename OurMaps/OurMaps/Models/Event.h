//
//  Event.h
//  OurMaps
//
//  Created by Wei Lu on 9/7/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Event : NSObject


// Builder class methods
+ (Event *)eventFromPFObject:(PFObject *)anObject;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *eventTime;

@end
