//
//  FKTitleHeaderView.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/21/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FKTitleHeaderViewProtocol.h"

@interface FKTitleHeaderView : UIView <FKTitleHeaderViewProtocol>

@property (nonatomic, strong) UILabel *textLabel;

@end
