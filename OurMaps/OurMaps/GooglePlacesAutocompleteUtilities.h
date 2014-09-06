//
//  GooglePlacesAutocompleteUtilities.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 8/23/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//


#define kGoogleAPIKey @"AIzaSyASvhdzIoZoDhTv0qayW_ybjYXnltaB8vc"
#define kGoogleAPINSErrorCode 42

@class CLPlacemark;

typedef enum {
    PlaceTypeGeocode = 0,
    PlaceTypeEstablishment
} GooglePlacesAutocompletePlaceType;

typedef void (^GooglePlacesPlacemarkResultBlock)(CLPlacemark *placemark, NSString *addressString, NSError *error);
typedef void (^GooglePlacesAutocompleteResultBlock)(NSArray *places, NSError *error);
typedef void (^GooglePlacesPlaceDetailResultBlock)(NSDictionary *placeDictionary, NSError *error);

typedef void (^NearbySearchResultBlock)(NSArray *places, NSError *error);


extern GooglePlacesAutocompletePlaceType PlaceTypeFromDictionary(NSDictionary *placeDictionary);
extern NSString *BooleanStringForBool(BOOL boolean);
extern NSString *PlaceTypeStringForPlaceType(GooglePlacesAutocompletePlaceType type);
//extern BOOL EnsureGoogleAPIKey();
extern void PresentAlertViewWithErrorAndTitle(NSError *error, NSString *title);
extern BOOL IsEmptyString(NSString *string);

@interface NSArray(FoundationAdditions)
- (id)onlyObject;
@end