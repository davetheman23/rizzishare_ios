//
//  EventDetailsViewController.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 11/1/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <Parse/Parse.h>

@interface EventDetailsViewController : PFQueryTableViewController

@property (nonatomic, strong) PFObject *event;

- (id)initWithEvent:(PFObject*)anEvent;

@end
