//
//  EventDetailsViewController.m
//  OurMaps
//
//  Created by Jiangchuan Huang on 11/1/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import "EventDetailsViewController.h"
#import "Constants.h"
#import "PAPPhotoDetailsHeaderView.h"
#import "PAPPhotoDetailsFooterView.h"
#import "PAPActivityCell.h"
#import "PAPConstants.h"
#import "PAPLoadMoreCell.h"
#import "PAPCache.h"
#import "MBProgressHUD.h"
#import "PAPUtility.h"

enum ActionSheetTags {
    MainActionSheetTag = 0,
    ConfirmDeleteActionSheetTag = 1
};

@interface EventDetailsViewController ()
@property (nonatomic, strong) UITextField *commentTextField;
@property (nonatomic, strong) PAPPhotoDetailsHeaderView *headerView;
@end

static const CGFloat kPAPCellInsetWidth = 20.0f;

@implementation EventDetailsViewController

@synthesize commentTextField;
@synthesize event, headerView;

#pragma mark - Initialization

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UtilityUserLikedUnlikedEventCallbackFinishedNotification" object:self.event];
}

- (id)initWithCoder:(NSCoder *)aCoder {
    self = [super initWithCoder:aCoder];
    if (self) {
        // Customize the table
        
        // The className to query on
        self.parseClassName = kEventActivityClassKey;
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"text";
        
        // Uncomment the following line to specify the key of a PFFile on the PFObject to display in the imageView of the default cell style
        // self.imageKey = @"image";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 10;
    }
    return self;
}


#pragma mark - UIViewController

- (void)viewDidLoad {
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    [super viewDidLoad];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LogoNavigationBar.png"]];

    // Set table view properties
    UIView *texturedBackgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
    [texturedBackgroundView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"BackgroundLeather.png"]]];
    self.tableView.backgroundView = texturedBackgroundView;

//    // Set table header
//    self.headerView = [[PAPPhotoDetailsHeaderView alloc] initWithFrame:[PAPPhotoDetailsHeaderView rectForView] photo:self.photo];
//    [self.headerView setDelegate:self];
//    
//    self.tableView.tableHeaderView = self.headerView;

    
    // Set table footer
    PAPPhotoDetailsFooterView *footerView = [[PAPPhotoDetailsFooterView alloc] initWithFrame:[PAPPhotoDetailsFooterView rectForView]];
    commentTextField = footerView.commentField;
    [commentTextField setDelegate:self];
    self.tableView.tableFooterView = footerView;
    
    if ([[[self.event objectForKey:kEventOwnerKey] objectId] isEqualToString:[[PFUser currentUser] objectId]]) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actionButtonAction:)];
    }
    

    // Register to be notified when the keyboard will be shown to scroll the view
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLikedOrUnlikedPhoto:) name:@"UtilityUserLikedUnlikedEventCallbackFinishedNotification" object:self.event];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.headerView reloadLikeBar];
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.objects.count) { // A comment row
        
        BOOL hasActivityEvent = NO;
        
        PFObject *object = [self.objects objectAtIndex:indexPath.row];
        
        if ([[object objectForKey:kEventActivityTypeKey] isEqualToString:kEventActivityTypeFollow] || [[object objectForKey:kEventActivityTypeKey] isEqualToString:kEventActivityTypeJoined]) {
            hasActivityEvent = NO;
        } else {
            hasActivityEvent = YES;
        }
        
        NSString *commentString  = [[self.objects objectAtIndex:indexPath.row] objectForKey:kEventActivityContentKey];
        NSString *nameString = [(PFUser*)[object objectForKey:kEventActivityFromUserKey] objectForKey:kUserDisplayNameKey];
        
        return [PAPActivityCell heightForCellWithName:nameString contentString:commentString cellInsetWidth:kPAPCellInsetWidth];
    } else { // The pagination row
        return 44.0f;
    }
}

#pragma mark - PFQueryTableViewController

- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    [query whereKey:kEventActivityEventKey equalTo:self.event];

    [query includeKey:kEventActivityFromUserKey];
    [query whereKey:kEventActivityTypeKey equalTo:kEventActivityTypeComment];
    [query orderByAscending:@"createdAt"];
    [query setCachePolicy:kPFCachePolicyNetworkOnly];

    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    //
    // If there is no network connection, we will hit the cache first.
//    if (self.objects.count == 0 || ![[UIApplication sharedApplication].delegate performSelector:@selector(isParseReachable)]) {
//        [query setCachePolicy:kPFCachePolicyCacheThenNetwork];
//    }
    return query;
}

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    NSLog(@"Objects did load");
    [self.headerView reloadLikeBar];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    static NSString *cellID = @"commentCell";
    
    // Try to dequeue a cell and create one if necessary
    PAPBaseTextCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[PAPBaseTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        [cell setCellInsetWidth:kPAPCellInsetWidth];
        [cell setDelegate:self];
    }
    [cell setUser:[object objectForKey:kEventActivityFromUserKey]];
    [cell setContentText:[object objectForKey:kEventActivityContentKey]];
    [cell setDate:[object createdAt]];
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForNextPageAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"NextPage";
    
    PAPLoadMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[PAPLoadMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.cellInsetWidth = kPAPCellInsetWidth;
        cell.hideSeparatorTop = YES;
    }
    
    return cell;
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *trimmedComment = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (trimmedComment.length != 0 && [self.event objectForKey:kEventOwnerKey]) {
        PFObject *comment = [PFObject objectWithClassName:kEventActivityClassKey];
        [comment setValue:trimmedComment forKey:kEventActivityContentKey]; // Set comment text
        [comment setValue:[self.event objectForKey:kEventOwnerKey] forKey:kEventActivityToUserKey]; // Set toUser
        [comment setValue:[PFUser currentUser] forKey:kEventActivityFromUserKey]; // Set fromUser
        [comment setValue:kEventActivityTypeComment forKey:kEventActivityTypeKey];
        [comment setValue:self.event forKey:kEventActivityEventKey];
        
        PFACL *ACL = [PFACL ACLWithUser:[PFUser currentUser]];
        [ACL setPublicReadAccess:YES];
        comment.ACL = ACL;
        
        [[PAPCache sharedCache] incrementCommentCountForEvent:self.event];
        
        // Show HUD view
        [MBProgressHUD showHUDAddedTo:self.view.superview animated:YES];
        
        // If more than 5 seconds pass since we post a comment, stop waiting for the server to respond
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(handleCommentTimeout:) userInfo:[NSDictionary dictionaryWithObject:comment forKey:@"comment"] repeats:NO];
        
        [comment saveEventually:^(BOOL succeeded, NSError *error) {
            [timer invalidate];
            
            if (error && [error code] == kPFErrorObjectNotFound) {
                [[PAPCache sharedCache] decrementCommentCountForEvent:self.event];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not post comment" message:@"This event was deleted by its owner" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alert show];
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                // refresh cache
                
                NSMutableSet *channelSet = [NSMutableSet setWithCapacity:self.objects.count];
                
                // set up this push notification to be sent to all commenters, excluding the current  user
                for (PFObject *comment in self.objects) {
                    PFUser *author = [comment objectForKey:kEventActivityFromUserKey];
                    NSString *privateChannelName = [author objectForKey:kUserPrivateChannelKey];
                    if (privateChannelName && privateChannelName.length != 0 && ![[author objectId] isEqualToString:[[PFUser currentUser] objectId]]) {
                        [channelSet addObject:privateChannelName];
                    }
                }
                [channelSet addObject:[self.event objectForKey:kEventOwnerKey]];
                
                if (channelSet.count > 0) {
                    NSString *alert = [NSString stringWithFormat:@"%@: %@", [PAPUtility firstNameForDisplayName:[[PFUser currentUser] objectForKey:kUserDisplayNameKey]], trimmedComment];
                    
                    // make sure to leave enough space for payload overhead
                    if (alert.length > 100) {
                        alert = [alert substringToIndex:99];
                        alert = [alert stringByAppendingString:@"…"];
                    }
                    
                    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                                          alert, kAPNSAlertKey,
                                          kPAPPushPayloadPayloadTypeActivityKey, kPAPPushPayloadPayloadTypeKey,
                                          kPAPPushPayloadActivityCommentKey, kPAPPushPayloadActivityTypeKey,
                                          [[PFUser currentUser] objectId], kPAPPushPayloadFromUserObjectIdKey,
                                          [self.event objectId], kPAPPushPayloadEventObjectIdKey,
                                          @"Increment",kAPNSBadgeKey,
                                          nil];
                    PFPush *push = [[PFPush alloc] init];
                    [push setChannels:[channelSet allObjects]];
                    [push setData:data];
                    [push sendPushInBackground];
                }
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:PAPPhotoDetailsViewControllerUserCommentedOnPhotoNotification object:self.event userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:self.objects.count + 1] forKey:@"comments"]];
            
            [MBProgressHUD hideHUDForView:self.view.superview animated:YES];
            [self loadObjects];
        }];
    }
    [textField setText:@""];
    return [textField resignFirstResponder];
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [commentTextField resignFirstResponder];
}



#pragma mark - ()

- (void)handleCommentTimeout:(NSTimer *)aTimer {
    [MBProgressHUD hideHUDForView:self.view.superview animated:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"New Comment" message:@"Your comment will be posted next time there is an Internet connection."  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
    [alert show];
}


- (void)keyboardWillShow:(NSNotification*)note {
    // Scroll the view to the comment text box
    NSDictionary* info = [note userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height-kbSize.height) animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
