//
//  FKDisclosureIndicatorAccessoryField.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/21/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FKLabelField.h"
#import "FKFieldErrorProtocol.h"

@interface FKDisclosureIndicatorAccessoryField : FKLabelField <FKFieldErrorProtocol>

@property (nonatomic, strong) UILabel *errorLabel;

@end
