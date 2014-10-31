//
//  EventDetailsViewController.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 10/28/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <Parse/Parse.h>
#import "PAPPhotoDetailsHeaderView.h"
#import "PAPBaseTextCell.h"

@interface PAPPhotoDetailsViewController : PFQueryTableViewController <UITextFieldDelegate, UIActionSheetDelegate, PAPPhotoDetailsHeaderViewDelegate, PAPBaseTextCellDelegate>

@property (nonatomic, strong) PFObject *photo;

- (id)initWithPhoto:(PFObject*)aPhoto;

@end
