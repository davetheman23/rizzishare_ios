//
//  UserProfileImageView.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 10/28/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@class PFImageView;
@interface PAPProfileImageView : UIView

@property (nonatomic, strong) UIButton *profileButton;
@property (nonatomic, strong) PFImageView *profileImageView;

- (void)setFile:(PFFile *)file;

@end
