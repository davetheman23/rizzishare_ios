//
//  FKSliderField.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/21/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FKValueViewField.h"

@interface FKSliderField : FKValueViewField {
    UISlider *_slider;
}

@property (nonatomic, readonly) UISlider *slider;

@end
