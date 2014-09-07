//
//  Event.m
//  OurMaps
//
//  Created by Wei Lu on 9/7/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import "Event.h"

@implementation Event

+ (Event *)eventFromPFObject:(PFObject *)anObject {
    Event *event = [[self alloc] init];
    event.title = [anObject objectForKey:kEventTitleKey];
    event.eventTime = [anObject objectForKey:kEventTimeKey];
    
    return event;
}

@end
