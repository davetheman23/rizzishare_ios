//
//  EventQuery.m
//  OurMaps
//
//  Created by Wei Lu on 9/6/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import "EventQuery.h"

@implementation EventQuery

// QueryEventInAPlace
- (NSInteger)queryEventForPlace:(PFObject *)aPlace {
    //NSMutableArray *eventArray = [NSMutableArray array];
    
    // Fetch all the events related to this place. (access control?)
    PFQuery *query = [PFQuery queryWithClassName:kEventClassKey];
    [query whereKey:kEventVenueKey equalTo:aPlace];
    
    //[query where]
    
//    [query findObjectsInBackgroundWithBlock:^(NSArray *events, NSError *error) {
//        if (!error) {
//            for (PFObject *eventObject in events) {
//                // Build event object locally.
//                Event *event = [Event eventFromPFObject:eventObject];
//                [eventArray addObject:event];
//            }
//        }
//    }];
    
//    NSArray *events = [query findObjects];
//    for (PFObject *eventObject in events) {
//        // Build event object locally.
//        Event *event = [Event eventFromPFObject:eventObject];
//        [eventArray addObject:event];
//    }
    
    NSInteger eventCount = [query countObjects];
    NSLog(@"event count for place: %@ == %lu", [aPlace objectForKey:kPlaceNameKey], eventCount);
    
    return eventCount;
    //return eventArray;
}

//-

// Query all the events in a place

@end
