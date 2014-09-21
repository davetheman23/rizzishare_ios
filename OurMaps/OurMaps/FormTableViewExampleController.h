//
//  FormTableViewExampleController.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/21/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FKFormModel;
@class Movie;

@interface FormTableViewExampleController : UITableViewController

@property (nonatomic, strong) FKFormModel *formModel;
@property (nonatomic, strong) Movie *movie;

@end
