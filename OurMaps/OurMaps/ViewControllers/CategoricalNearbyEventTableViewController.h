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

@protocol CategoricalTableVCDelegate <NSObject>

- (void)didSelectACategory:(NSArray *)events;

@end

@interface CategoricalNearbyEventTableViewController : UITableViewController

//@property (nonatomic, strong)
//@property (nonatomic) NSInteger Food;
//@property (nonatomic) NSInteger Movie;
//@property (nonatomic) NSInteger Nightlife;
//@property (nonatomic) NSInteger Shopping;
//@property (nonatomic) NSInteger Gym;
//@property (nonatomic) NSInteger Spiritual;
//@property (nonatomic, strong) NSDecimalNumber *Food;
//@property (nonatomic, strong) NSDecimalNumber *Movie;
//@property (nonatomic, strong) NSDecimalNumber *Nightlife;
//@property (nonatomic, strong) NSDecimalNumber *Shopping;
//@property (nonatomic, strong) NSDecimalNumber *Gym;
//@property (nonatomic, strong) NSDecimalNumber *Spiritual;

@property (weak, nonatomic) id<CategoricalTableVCDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *Food;
@property (nonatomic, strong) NSMutableArray *Movie;
@property (nonatomic, strong) NSMutableArray *Nightlife;
@property (nonatomic, strong) NSMutableArray *Shopping;
@property (nonatomic, strong) NSMutableArray *Gym;
@property (nonatomic, strong) NSMutableArray *Spiritual;

@property (nonatomic) CLLocationCoordinate2D currentCoordinate;
@property (nonatomic, strong) NearbySearchQuery *nearbySearchQuery;

@end
