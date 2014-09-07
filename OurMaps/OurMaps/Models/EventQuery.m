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
- (NSArray *)queryEventForPlace:(Place *)aPlace {
    NSMutableArray *eventArray = [NSMutableArray array];
    
    // Fetch all the events related to this place. (access control?)
    PFQuery *query = [PFQuery queryWithClassName:kEventClassKey];
    [query whereKey:kEventVenueKey equalTo:aPlace];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *events, NSError *error) {
        if (!error) {
            for (PFObject *event in events) {
                // Build event object locally.
            }
        }
        
        
    }];
    return eventArray;
}

//-

// Query all the events in a place

@end
