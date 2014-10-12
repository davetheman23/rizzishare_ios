//
//  ContactPickerViewController.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/29/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>
#import "ContactPickerView.h"
#import "ContactPickerTableViewCell.h"

@interface ContactPickerViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, THContactPickerDelegate, ABPersonViewControllerDelegate>

@property (nonatomic, strong) ContactPickerView *contactPickerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *contacts;
@property (nonatomic, strong) NSMutableArray *selectedContacts;
@property (nonatomic, strong) NSArray *filteredContacts;

@end
