//
//  EventPostViewController.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/27/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FKFormModel;
@class Event;

@interface EventPostViewController : UITableViewController

@property (nonatomic, strong) FKFormModel *formModel;
@property (nonatomic, strong) Event *event;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *saveButton;


@end
