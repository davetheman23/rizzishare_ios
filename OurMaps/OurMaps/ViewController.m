//
//  ViewController.m
//  OurMaps
//
//  Created by Jiangchuan Huang, Wei Lu on 8/16/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import "ViewController.h"
#import "PlaceMarker.h"
#import "AutocompleteQuery.h"
#import "NearbySearchQuery.h"
#import "Place.h"
#import <Parse/Parse.h>
#import "EventQuery.h"

@interface ViewController () {
}
//@property (strong, nonatomic) GMSMapView *mapView;
//@property (strong, nonatomic) NSURLSession *markerSession;
@property (copy, nonatomic) NSSet *markers;
@property (strong, nonatomic) PlaceMarker *userCreatedMarker;
@end

@implementation ViewController

@synthesize mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /***** Initialize AutocompleteQuery *****/
    autocompleteQuery = [[AutocompleteQuery alloc] init];
    autocompleteQuery.radius = 100.0;
    shouldBeginEditing = YES;

    /***** Initialize NearbySearchQuery *****/
    nearbySearchQuery = [[NearbySearchQuery alloc] init];
    nearbySearchQuery.radius = 100.0;

    /***** Setup PFUser *****/
    self.usernameLabel.text = [[PFUser currentUser] username];

    eventQuery = [[EventQuery alloc] init];
    
    /***** Setup Mapview *****/
    CLLocationCoordinate2D currentCoordinate = CLLocationCoordinate2DMake(40.714353, -74.005973);
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:currentCoordinate.latitude
                                                            longitude:currentCoordinate.longitude
                                                                 zoom:15
                                                              bearing:0
                                                         viewingAngle:0];
    self.mapView.camera = camera;
    self.mapView.mapType = kGMSTypeNormal;
    self.mapView.myLocationEnabled = YES;
    self.mapView.settings.compassButton = YES;
//    self.mapView.settings.myLocationButton = YES;
    [self.mapView setMinZoom:10 maxZoom:18];
//    [self.view addSubview:self.mapView];
//    self.mapView.hidden=YES;
    self.mapView.delegate = self;
    
    
    /***** Show user location *****/
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(40.714353, -74.005973);
    PlaceMarker *marker = [[PlaceMarker alloc] init];
    marker.position = coordinate;
    marker.title = @"Point of interest";
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = nil;
    self.userCreatedMarker = marker;
    
    
    /***** Claim Google Maps Service *****/
    [GMSServices openSourceLicenseInfo];
}



#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [autocompleteNearbyPlaces count];
}

- (Place *)placeAtIndexPath:(NSIndexPath *)indexPath {
    return [autocompleteNearbyPlaces objectAtIndex:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentifier = @"GooglePlacesAutocompleteCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.font = [UIFont fontWithName:@"GillSans" size:16.0];
    cell.textLabel.text = [self placeAtIndexPath:indexPath].name;
    return cell;
}


#pragma mark -
#pragma mark UITableViewDelegate

- (void)addGMSMarkerToMap:(CLPlacemark *)placemark addressString:(NSString *)address {
    
    if(self.userCreatedMarker != nil){
        self.userCreatedMarker.map = nil;
        self.userCreatedMarker = nil;
    }
    
    PlaceMarker *marker = [[PlaceMarker alloc] init];
    marker.position = placemark.location.coordinate;
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.title = address;
    marker.map = nil;
    
    self.userCreatedMarker = marker;
    [self drawUserMarker];
}

- (void)dismissSearchControllerWhileStayingActive {
    
    // Animate out the table view.
    NSTimeInterval animationDuration = 0.3;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    self.searchDisplayController.searchResultsTableView.alpha = 0.0;
    [UIView commitAnimations];
    
    [self.searchDisplayController.searchBar setShowsCancelButton:NO animated:YES];
    [self.searchDisplayController.searchBar resignFirstResponder];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Place *place = [self placeAtIndexPath:indexPath];
    
    [place resolveToPlacemark:^(CLPlacemark *placemark, NSString *addressString, NSError *error) {
        if (error) {
            PresentAlertViewWithErrorAndTitle(error, @"Could not map selected Place");
        } else if (placemark) {
            [self addGMSMarkerToMap:placemark addressString:addressString];
            [self dismissSearchControllerWhileStayingActive];
            [self.searchDisplayController.searchResultsTableView deselectRowAtIndexPath:indexPath animated:NO];
        }
    }];
}


#pragma mark -
#pragma mark UISearchDisplayDelegate

- (void)nearbySearchForSearchString:(NSString *)searchString {
    
    autocompleteQuery.location = self.userCreatedMarker.position;
    autocompleteQuery.input = searchString;
    
    [autocompleteQuery fetchPlaces:^(NSArray *places, NSError *error) {
        if (error) {
            PresentAlertViewWithErrorAndTitle(error, @"Could not fetch places");
        } else {
            autocompleteNearbyPlaces = [places copy];
            [self.searchDisplayController.searchResultsTableView reloadData];
        }
    }];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {

    [self nearbySearchForSearchString:searchString];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


#pragma mark -
#pragma mark UISearchBar Delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
     if (![searchBar isFirstResponder]) {
        // User tapped the 'clear' button.
        shouldBeginEditing = NO;
        [self.searchDisplayController setActive:NO];
        self.userCreatedMarker.map = nil;
    }
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    if (shouldBeginEditing) {
        // Animate in the table view.
        NSTimeInterval animationDuration = 0.3;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:animationDuration];
        self.searchDisplayController.searchResultsTableView.alpha = 1.0;
        [UIView commitAnimations];
        
        [self.searchDisplayController.searchBar setShowsCancelButton:YES animated:YES];
    }
    BOOL boolToReturn = shouldBeginEditing;
    shouldBeginEditing = YES;
    return boolToReturn;
}


#pragma mark -
#pragma mark Google Maps Delegate.

- (void)nearbySearchForCoordinate:(CLLocationCoordinate2D)coordinate {
    nearbySearchQuery.location = coordinate;
        
    [nearbySearchQuery fetchNearbyPlaces:^(NSArray *places, NSError *error) {
        if (error) {
            PresentAlertViewWithErrorAndTitle(error, @"Could not fetch nearby places");
        } else {
            longPressNearbyPlaces = [places copy];
            [self createMarkersWithPlaces];
            [self drawPlaceMarkers];
        }
    }];
}


- (void)createMarkersWithPlaces {
    
    self.markers = nil;
    NSMutableSet *mutableMarkerSet = [[NSMutableSet alloc] init];

    for (int i = 0; i < [longPressNearbyPlaces count]; i++){
        Place *place = [longPressNearbyPlaces objectAtIndex:i];
        
        PlaceMarker *marker = [[PlaceMarker alloc] init];
        
        marker.place_id = place.place_id;
        marker.position = place.coordinate;
        
        PFQuery *query = [PFQuery queryWithClassName:kPlaceClassKey];
        [query whereKey:kPlaceIdKey equalTo:place.place_id];
        PFObject *parsePlace = [query getFirstObject];
        
        marker.title = place.name;
        marker.snippet = [NSString stringWithFormat:@"Rating: %f, Price level: %d",place.rating, place.price_level];
        marker.appearAnimation = kGMSMarkerAnimationPop;
        
        //NSArray *eventArray = [[NSArray alloc] init];
        
        NSInteger eventCount = 0;
        
        if (parsePlace) {
             eventCount = [eventQuery queryEventForPlace:parsePlace];
        }
        
        if (eventCount>0) {
            marker.icon = [UIImage imageNamed:@"fig_Coffee_true.png"];
        } else {
            marker.icon = [UIImage imageNamed:@"fig_Coffee.png"];
        }
        
        marker.map = nil;
        [mutableMarkerSet addObject:marker];
    }
    self.markers = [mutableMarkerSet copy];
}

- (void)mapView:(GMSMapView *)mapView
didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate {
    
    // Erase current userCreatedMarker from the map and set it to nil.
    [self eraseUserMarker];
    
    GMSGeocoder *geocoder = [GMSGeocoder geocoder];
    [geocoder reverseGeocodeCoordinate:coordinate
                     completionHandler:^(GMSReverseGeocodeResponse *response, NSError *error) {
                         PlaceMarker *marker = [[PlaceMarker alloc] init];
                         marker.position = coordinate;
                         marker.appearAnimation = kGMSMarkerAnimationPop;
                         marker.title = response.firstResult.thoroughfare;
                         marker.snippet = response.firstResult.locality;
                         marker.map = nil;
                         
                         self.userCreatedMarker = marker;
                         [self drawUserMarker];
                     }];
    
    // Create markers near the userCreatedMarker.
    [self nearbySearchForCoordinate:coordinate];
}


- (void)mapView:(GMSMapView *)mapView
didTapInfoWindowOfMarker:(GMSMarker *)marker{
    NSString *message = [NSString stringWithFormat:@"You tapped the info window for the %@ marker", marker.title];
    UIAlertView *windowTapped = [[UIAlertView alloc] initWithTitle:@"info Window Tapped!"
                                                           message:message
                                                          delegate:nil
                                                 cancelButtonTitle:@"Alright!"
                                                 otherButtonTitles:nil];
    
    [windowTapped show];
}


- (void)setupMarkerData{
    GMSMarker *marker1 = [[GMSMarker alloc] init];
    marker1.position = CLLocationCoordinate2DMake(40.714353, -74.005973);
    marker1.map = nil;
    
    self.markers = [NSSet setWithObjects:marker1, nil];
    [self drawPlaceMarkers];
}


- (void)createMarkerObjectsWithJson:(NSDictionary *)json {
    
    NSMutableSet *mutableMarkerSet = [[NSMutableSet alloc] init];
    
    NSArray *results = json[@"results"];
    for (int i = 0; i < [results count]; i++){
        NSDictionary *markerData = [results objectAtIndex:i];
        NSLog(@"MarkerData: %@",markerData);
        
        PlaceMarker *marker = [[PlaceMarker alloc] init];

        marker.place_id = markerData[@"id"];
        double lat = [markerData[@"geometry"][@"location"][@"lat"] doubleValue];
        double lng = [markerData[@"geometry"][@"location"][@"lng"] doubleValue];
        marker.position = CLLocationCoordinate2DMake(lat, lng);
        marker.title = markerData[@"name"];
        marker.snippet = [NSString stringWithFormat:@"Rating: %@, Price level: %@",markerData[@"rating"],markerData[@"price_level"]];
        marker.appearAnimation = kGMSMarkerAnimationPop;
        
        marker.icon = [UIImage imageNamed:@"fig_Coffee.png"];
        marker.map = nil;
        [mutableMarkerSet addObject:marker];
    }
    self.markers = [mutableMarkerSet copy];
    [self drawPlaceMarkers];
}

- (void)eraseUserMarker{
    if(self.userCreatedMarker != nil){
        self.userCreatedMarker.map = nil;
        self.userCreatedMarker = nil;
    }
}

- (void)drawUserMarker{
    if(self.userCreatedMarker != nil && self.userCreatedMarker.map == nil){
        self.userCreatedMarker.map = self.mapView;
        self.mapView.selectedMarker = self.userCreatedMarker;
        GMSCameraUpdate *cameraUpdate = [GMSCameraUpdate setTarget:self.userCreatedMarker.position];
        [self.mapView animateWithCameraUpdate:cameraUpdate];
    }
}

- (void)erasePlaceMarkers{
    for(PlaceMarker *marker in self.markers){
        if (marker != nil) {
            marker.map = nil;
        }
    }
    
    if(self.userCreatedMarker != nil){
        self.userCreatedMarker.map = nil;
        self.userCreatedMarker = nil;
    }
}

- (void)drawPlaceMarkers{
    for(PlaceMarker *marker in self.markers){
        if(marker.map == nil){
            marker.map = self.mapView;
        }
    }
}


//- (void)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
//    if (mapView.myLocation != nil) {
//        NSString *urlString = [NSString stringWithFormat:@"%@?origin=%f,%f&destination=%f,%f&sensor=true&key=%@",
//                               @"https://maps.googleapis.com/maps/api/directions/json",
//                               mapView.myLocation.coordinate.latitude,
//                               mapView.myLocation.coordinate.longitude,
//                               marker.position.latitude,
//                               marker.position.longitude,
//                               @"AIzaSyASvhdzIoZoDhTv0qayW_ybjYXnltaB8vc"];
//        NSURL *directionsURL = [NSURL URLWithString:urlString];
//        NSURLSessionDataTask *directionsTask = [self.markerSession dataTaskWithURL:directionsURL
//                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *e) {
//                                                    NSError *error = nil;
//                                                    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
//                                                                                                         options:NSJSONReadingMutableContainers
//                                                                                                           error:&error];
//                                                    if (!error) {
////                                                        self.steps = json[@"routes"][0][@"legs"][0][@"steps"];
//                                                    }
//                                                }];
//    }
//}


-(void) viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.mapView.padding = UIEdgeInsetsMake(self.topLayoutGuide.length + 5,
                                            0,
                                            self.bottomLayoutGuide.length + 5,
                                            0);
}

//-(BOOL) prefersStatusBarHidden{
//    return YES;
//}

- (void)didReceiveMemoryWarning
{
    // Dispose of any resources that can be recreated.
    [super didReceiveMemoryWarning];
}

@end
