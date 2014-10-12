//
//  EventListTableViewController.h
//  OurMaps
//
//  Created by Wei Lu on 9/20/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Place.h"

@interface EventListTableViewController : UITableViewController

@property (strong, nonatomic) Place* place;
@property (strong, nonatomic) NSArray *eventArray;

@end
