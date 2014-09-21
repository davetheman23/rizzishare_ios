//
//  FKSwitchField.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/21/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FKSimpleField.h"

@interface FKSwitchField : FKSimpleField {
    UISwitch *_switchControl;
}

@property (nonatomic, readonly) UISwitch *switchControl;

@end
