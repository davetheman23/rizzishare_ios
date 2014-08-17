//
//  ViewController.m
//  OurMaps
//
//  Created by Jiangchuan Huang on 8/16/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    GMSMapView *mapView;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:40.714353 longitude:-74.005973 zoom:6];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
    self.view = mapView;
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(40.714353, -74.005973);
    marker.title = @"Current Location";
    marker.snippet = @"Houston TX, USA";
    marker.map = mapView;
    
    [GMSServices openSourceLicenseInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
