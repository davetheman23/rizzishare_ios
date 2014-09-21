//
//  FKTextField.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/21/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FKValueViewField.h"

@interface FKTextField : FKValueViewField {
    UITextField *_textField;
}

@property (nonatomic, readonly) UITextField *textField;
@property (nonatomic, assign) Class customTextFieldClass;

@end
