//
//  DistancePickerView.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/21/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DistancePickerView : UIPickerView {
    NSMutableDictionary *labels;
}

- (void) addLabel:(NSString *)labeltext forComponent:(NSUInteger)component forLongestString:(NSString *)longestString;
- (void) updateLabel:(NSString *)labeltext forComponent:(NSUInteger)component;
@end
