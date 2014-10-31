//
//  ActivityFeedViewController.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 10/28/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import "PAPActivityCell.h"

@interface PAPActivityFeedViewController : PFQueryTableViewController <PAPActivityCellDelegate>

+ (NSString *)stringForActivityType:(NSString *)activityType;

@end
