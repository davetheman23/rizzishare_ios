//
//  Event.m
//  OurMaps
//
//  Created by Wei Lu and Jiangchuan Huang on 9/7/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import "Event.h"

@implementation Event

@synthesize title, eventTime, eventPlace, participants;

+ (id)eventWithTitle:(NSString *)newTitle {
    Event *event = [[Event alloc] init];
    event.title = newTitle;
    
    return event;
}

+ (Event *)eventFromPFObject:(PFObject *)anObject {
    Event *event = [[self alloc] init];
    event.title = [anObject objectForKey:kEventTitleKey];
    event.eventTime = [anObject objectForKey:kEventTimeKey];
    event.owner = [anObject objectForKey:kEventOwnerKey];
    event.venue = [anObject objectForKey:kEventVenueKey];
    return event;
}

+ (PFObject *)eventToPFObject:(Event *)anEvent {
    PFObject *PFEvent = [PFObject objectWithClassName:kEventClassKey];
    PFEvent[kEventTitleKey] = anEvent.title;
    PFEvent[kEventTimeKey] = anEvent.eventTime;
    PFEvent[kEventOwnerKey] = anEvent.owner;
    PFEvent[kEventVenueKey] = anEvent.venue;
    return PFEvent;
}


- (NSString *)description {
    return [NSString stringWithFormat:
            @"title = %@, eventTime = %@, eventPlace = %@, participants = %@",
            self.title, self.eventTime, self.eventPlace, self.participants];
}



@end
