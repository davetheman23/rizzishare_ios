//
//  ViewController.m
//  OurMaps
//
//  Created by Jiangchuan Huang on 8/16/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import "ViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface ViewController () <GMSMapViewDelegate> {
//    GMSMapView *mapView;
}
@property (strong, nonatomic) GMSMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:40.714353
                                                            longitude:-74.005973
                                                                 zoom:15
                                                              bearing:0
                                                         viewingAngle:0];
//    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    self.mapView = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
    self.mapView.mapType = kGMSTypeNormal;
    self.mapView.myLocationEnabled = YES;
    self.mapView.settings.compassButton = YES;
//    self.mapView.settings.myLocationButton = YES;
    [self.mapView setMinZoom:10 maxZoom:18];
    [self.view addSubview:self.mapView];
    self.mapView.delegate = self;
//    self.view = _mapView;
    
    // Show user location.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(40.714353, -74.005973);
    marker.title = @"Current Location";
    marker.snippet = @"New York City, USA";
    marker.map = _mapView;
    
//    [self mapView:mapView didTapInfoWindowOfMarker:marker];
    
    // Show places around the user location.
    dispatch_async(dispatch_get_main_queue(), ^{
        NSURL *url = [NSURL URLWithString:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?language=en&sensor=false&key=AIzaSyASvhdzIoZoDhTv0qayW_ybjYXnltaB8vc&radius=1000&keyword=mexican&location=40.714353,-74.005973"];
        
        NSData *responseData = [NSData dataWithContentsOfURL:url];
        NSError *error;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData
                                                             options:kNilOptions
                                                               error:&error];
        NSArray *results = json[@"results"];
        for (int i = 0; i < [results count]; i++){
            NSDictionary *place = [results objectAtIndex:i];
            double lat = [place[@"geometry"][@"location"][@"lat"] doubleValue];
            double lng = [place[@"geometry"][@"location"][@"lng"] doubleValue];
            GMSMarker *marker = [[GMSMarker alloc] init];
            marker.position = CLLocationCoordinate2DMake(lat, lng);
            marker.title = @"Mexican";
            marker.snippet = @"Customize this.";
            marker.appearAnimation = kGMSMarkerAnimationPop;
//            marker.icon = [GMSMarker markerImageWithColor:[UIColor greenColor]];
            marker.icon = [UIImage imageNamed:@"fig_Coffee.png"];
            marker.map = _mapView;
        }
        
        // Google directions: get the route.
        NSDictionary *routes = json[@"routes"][0];
        NSDictionary *route = routes[@"overview_polyline"];
        NSString *encodedPath = route[@"points"];
        
        GMSPath *path = [GMSPath pathFromEncodedPath:encodedPath];
        GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
        polyline.strokeWidth = 4;
        polyline.strokeColor = [UIColor colorWithRed:0 green:0 blue:1.0 alpha:0.7];
        polyline.map = _mapView;
        
    });
    
    [GMSServices openSourceLicenseInfo];
}

-(BOOL) prefersStatusBarHidden{
    return YES;
}

-(void) viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.mapView.padding = UIEdgeInsetsMake(self.topLayoutGuide.length + 5,
                                            0,
                                            self.bottomLayoutGuide.length + 5,
                                            0);
}

-(void)mapView:(GMSMapView *)mapView
didTapInfoWindowOfMarker:(GMSMarker *)marker{
    NSString *message = [NSString stringWithFormat:@"You tapped the info window for the %@ marker", marker.title];
    UIAlertView *windowTapped = [[UIAlertView alloc] initWithTitle:@"info Window Tapped!"
                                                           message:message
                                                          delegate:nil
                                                 cancelButtonTitle:@"Alright!"
                                                 otherButtonTitles:nil];
    
    [windowTapped show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
