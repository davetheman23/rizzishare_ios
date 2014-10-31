//
//  FindFriendsViewController.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 10/28/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <AddressBookUI/AddressBookUI.h>
#import <MessageUI/MessageUI.h>
#import "PAPFindFriendsCell.h"
#import <Parse/Parse.h>
#import <FacebookSDK/FacebookSDK.h>

//@interface PAPFindFriendsViewController : PFQueryTableViewController <PF_FBRequestDelegate, PAPFindFriendsCellDelegate, ABPeoplePickerNavigationControllerDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, UIActionSheetDelegate>

@interface PAPFindFriendsViewController : PFQueryTableViewController <PAPFindFriendsCellDelegate, ABPeoplePickerNavigationControllerDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, UIActionSheetDelegate>

@end
