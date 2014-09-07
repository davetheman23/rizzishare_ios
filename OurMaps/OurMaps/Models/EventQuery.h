//
//  EventQuery.h
//  OurMaps
//
//  Created by Wei Lu on 9/6/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Place.h"
#import <Parse/Parse.h>
#import "Event.h"

@interface EventQuery : NSObject

// 
- (NSInteger)queryEventForPlace:(PFObject *)aPlace;

@end
