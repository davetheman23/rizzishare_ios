//
//  EventListTableViewController.m
//  OurMaps
//
//  Created by Wei Lu on 9/20/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import "EventListTableViewController.h"
#import "EventListTableViewCell.h"
#import "EventPostViewController.h"

@interface EventListTableViewController ()

@end

@implementation EventListTableViewController

@synthesize eventArray = _eventArray;
@synthesize place;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _eventArray = place.eventArray;
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return _eventArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventListCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.event = [_eventArray objectAtIndex:indexPath.row];
    
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    Event *event = nil;
    if([segue.identifier isEqualToString:@"eventPostSegue"]) {
        event = [Event eventWithTitle:@"Type event title"];
        event.eventTime = [NSDate date];
        event.eventPlace = @"SWEVI";
        event.participants = nil;
    } else if([segue.identifier isEqualToString:@"eventQuerySegue"]) {
        NSIndexPath *index = [self.tableView indexPathForSelectedRow];
        PFObject *PFEvent = [_eventArray objectAtIndex:index.row];
        event = [Event eventFromPFObject:PFEvent];
    }
    EventPostViewController *vc = [segue destinationViewController];
    vc.event = event;
}


@end
