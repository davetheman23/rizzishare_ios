//
//  UIView+FormKit.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/21/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FormKit)

- (UIView *)fk_findFirstResponder;

- (id)fk_findFirstTextField;

- (NSArray *)fk_findTextFields;

@end
