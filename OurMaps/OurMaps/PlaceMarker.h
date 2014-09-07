//
//  PlaceMarker.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 8/21/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMaps/GoogleMaps.h>

@interface PlaceMarker : GMSMarker

@property (nonatomic, copy) NSString *place_id;

@end
