//
//  FKSimpleField.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/21/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FKFieldErrorProtocol.h"
#import "FKFieldStyleProtocol.h"

@interface FKSimpleField : UITableViewCell<FKFieldErrorProtocol, FKFieldStyleProtocol>

@property (nonatomic, strong) UILabel *errorLabel;
@property (nonatomic, assign) CGFloat xMargin;

@end
