//
//  UITableViewCell+FormKit.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/21/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FKBlocks.h"

@interface UITableViewCell (FormKit)

+ (id)fk_cellForTableView:(UITableView *)tableView
            configureCell:(FKFormMappingConfigureCellBlock)configureCellBlock;

@end
