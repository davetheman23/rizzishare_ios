//
//  Place.m
//  OurMaps
//
//  Created by Jiangchuan Huang on 8/24/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import "Place.h"
#import "PlaceDetailQuery.h"


@interface Place()
@property (nonatomic, retain, readwrite) NSString *name;
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain, readwrite) NSString *place_id;

@property (nonatomic, retain, readwrite) NSString *reference;
@property (nonatomic, retain, readwrite) NSString *identifier;
@property (nonatomic, readwrite) GooglePlacesAutocompletePlaceType type;

@property (nonatomic, readwrite) NSInteger price_level;
@property (nonatomic, readwrite) float rating;
@property (nonatomic, readwrite) BOOL open_now;

@end

@implementation Place

@synthesize name, coordinate, place_id, reference, identifier, type, price_level, rating, open_now;

+ (Place *)placeFromAutocompleteDictionary:(NSDictionary *)placeDictionary {
    Place *place = [[self alloc] init];
    place.name = [placeDictionary objectForKey:@"description"];
    place.reference = [placeDictionary objectForKey:@"reference"];
    place.identifier = [placeDictionary objectForKey:@"id"];
    place.type = PlaceTypeFromDictionary(placeDictionary);
    return place;
}

+ (Place *)placeFromNearbySearchDictionary:(NSDictionary *)placeDictionary {
    Place *place = [[self alloc] init];
    place.name = [placeDictionary objectForKey:@"name"];
    place.identifier = [placeDictionary objectForKey:@"id"];
    place.place_id = [placeDictionary objectForKey:@"place_id"];
    
    double lat = [placeDictionary[@"geometry"][@"location"][@"lat"] doubleValue];
    double lng = [placeDictionary[@"geometry"][@"location"][@"lng"] doubleValue];
    place.coordinate = CLLocationCoordinate2DMake(lat, lng);


    place.price_level = [placeDictionary[@"price_level"] integerValue];
    place.rating = [placeDictionary[@"rating"] floatValue];
    place.open_now = [placeDictionary[@"opening_hours"][@"open_now"] boolValue];

    return place;
}


- (NSString *)description {
    return [NSString stringWithFormat:@"Name: %@, Reference: %@, Identifier: %@, Type: %@",
            name, reference, identifier, PlaceTypeStringForPlaceType(type)];
}

- (CLGeocoder *)geocoder {
    if (!geocoder) {
        geocoder = [[CLGeocoder alloc] init];
    }
    return geocoder;
}

- (void)resolveEstablishmentPlaceToPlacemark:(GooglePlacesPlacemarkResultBlock)block {
    PlaceDetailQuery *query = [PlaceDetailQuery query];
    query.reference = self.reference;
    [query fetchPlaceDetail:^(NSDictionary *placeDictionary, NSError *error) {
        if (error) {
            block(nil, nil, error);
        } else {
            NSString *addressString = [placeDictionary objectForKey:@"formatted_address"];
            [[self geocoder] geocodeAddressString:addressString completionHandler:^(NSArray *placemarks, NSError *error) {
                if (error) {
                    block(nil, nil, error);
                } else {
                    CLPlacemark *placemark = [placemarks onlyObject];
                    block(placemark, self.name, error);
                }
            }];
        }
    }];
}

- (void)resolveGecodePlaceToPlacemark:(GooglePlacesPlacemarkResultBlock)block {
    [[self geocoder] geocodeAddressString:self.name completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            block(nil, nil, error);
        } else {
            CLPlacemark *placemark = [placemarks onlyObject];
            block(placemark, self.name, error);
        }
    }];
}

- (void)resolveToPlacemark:(GooglePlacesPlacemarkResultBlock)block {
    if (type == PlaceTypeGeocode) {
        // Geocode places already have their address stored in the 'name' field.
        [self resolveGecodePlaceToPlacemark:block];
    } else {
        [self resolveEstablishmentPlaceToPlacemark:block];
    }
}

//- (void)dealloc {
//    [name release];
//    [reference release];
//    [identifier release];
//    [geocoder release];
//    [super dealloc];
//}

@end
