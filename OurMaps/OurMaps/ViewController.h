//
//  ViewController.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 8/16/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@class GooglePlacesAutocompleteQuery;
@class NearbySearchQuery;

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate, GMSMapViewDelegate> {
    
    NSArray *autocompleteNearbyPlaces;
    GooglePlacesAutocompleteQuery *autoCompleteSearchQuery;
    BOOL shouldBeginEditing;

    NSArray *longPressNearbyPlaces;
    NearbySearchQuery *nearbySearchQuery;

}

@property (strong, nonatomic) IBOutlet GMSMapView *mapView;

@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;


//@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
//@property (weak, nonatomic) IBOutlet UITableView *autoCompleteTableView;

@end
