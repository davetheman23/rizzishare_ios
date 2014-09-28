//
//  EventPostViewController.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/27/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FKFormModel;
@class Movie;
@class Event;

@interface EventPostViewController : UITableViewController

@property (nonatomic, strong) FKFormModel *formModel;
@property (nonatomic, strong) Movie *movie;
@property (nonatomic, strong) Event *event;

@end
