//
//  Utilities.m
//  OurMaps
//
//  Created by Jiangchuan Huang on 8/23/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import "Utilities.h"

@implementation NSArray(FoundationAdditions)
- (id)onlyObject {
    return [self count] == 1 ? [self objectAtIndex:0] : nil;
}
@end

GooglePlacesAutocompletePlaceType PlaceTypeFromDictionary(NSDictionary *placeDictionary) {
    return [[placeDictionary objectForKey:@"types"] containsObject:@"establishment"] ? PlaceTypeEstablishment : PlaceTypeGeocode;
}

NSString *BooleanStringForBool(BOOL boolean) {
    return boolean ? @"true" : @"false";
}

NSString *PlaceTypeStringForPlaceType(GooglePlacesAutocompletePlaceType type) {
    return (type == PlaceTypeGeocode) ? @"geocode" : @"establishment";
}

//BOOL EnsureGoogleAPIKey() {
//    BOOL userHasProvidedAPIKey = YES;
//    if ([kGoogleAPIKey isEqualToString:@"YOUR_API_KEY"]) {
//        userHasProvidedAPIKey = NO;
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"API Key Needed" message:@"Please replace kGoogleAPIKey with your Google API key." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
//        [alert show];
//        [alert release];
//    }
//    return userHasProvidedAPIKey;
//}

void PresentAlertViewWithErrorAndTitle(NSError *error, NSString *title) {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [alert show];
}

extern BOOL IsEmptyString(NSString *string) {
    return !string || ![string length];
}