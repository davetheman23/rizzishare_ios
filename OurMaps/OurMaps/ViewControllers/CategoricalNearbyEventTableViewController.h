//
//  CategoricalNearbyEventTableViewController.h
//  OurMaps
//
//  Created by Wei Lu on 9/11/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CategoricalNearbyEventTableViewCell.h"
#import "NearbySearchQuery.h"

@interface CategoricalNearbyEventTableViewController : UITableViewController

//@property (nonatomic, strong)
@property (nonatomic) NSInteger Food;
@property (nonatomic) NSInteger Movie;
@property (nonatomic) NSInteger Nightlife;
@property (nonatomic) NSInteger Shopping;
@property (nonatomic) NSInteger Gym;
@property (nonatomic) NSInteger Spiritual;

@property (nonatomic) CLLocationCoordinate2D currentCoordinate;
@property (nonatomic, strong) NearbySearchQuery *nearbySearchQuery;

@end
