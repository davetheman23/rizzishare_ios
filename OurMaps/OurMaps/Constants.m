//
//  Constants.m
//  OurMaps
//
//  Created by Wei Lu and Jiangchuan Huang on 8/19/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import "Constants.h"

// Class keys
NSString *const kActivityClassKey = @"Activity";
NSString *const kPlaceClassKey = @"Place";
NSString *const kEventClassKey = @"Event";
NSString *const kEventActivityClassKey = @"Event_Activity";

// Place attribute keys
NSString *const kPlaceGooglePlaceIDKey = @"googlePlaceId";
NSString *const kPlaceGeoLocationKey = @"geoLocation";
NSString *const kPlaceAddressKey = @"Address";
NSString *const kPlaceGoogleTypeKey = @"googleType";
NSString *const kPlaceCategoryKey = @"category";
NSString *const kPlaceNameKey = @"name";
NSString *const kPlaceOverallRatingKey = @"overallRating";
NSString *const kPlaceDescriptionKey = @"description";
NSString *const kPlaceIdKey = @"place_id";

#pragma mark - User Class
// User attribute keys
NSString *const kUserDisplayNameKey                          = @"displayName";
NSString *const kUserFacebookIDKey                           = @"facebookId";
NSString *const kUserPhotoIDKey                              = @"photoId";
NSString *const kUserProfilePicSmallKey                      = @"profilePictureSmall";
NSString *const kUserProfilePicMediumKey                     = @"profilePictureMedium";
NSString *const kUserAlreadyAutoFollowedFacebookFriendsKey   = @"userAlreadyAutoFollowedFacebookFriends";
NSString *const kUserPrivateChannelKey                       = @"channel";

// Event attribute keys
NSString *const kEventVenueKey = @"venue";
NSString *const kEventTimeKey = @"eventTime";
NSString *const kEventTitleKey = @"title";
NSString *const kEventTypeKey = @"type";
NSString *const kEventOwnerKey = @"owner";

// Event Activity attribute keys
NSString *const kEventActivityContentKey = @"content";
NSString *const kEventActivityFromUserKey = @"fromUser";
NSString *const kEventActivityEventKey = @"event";
NSString *const kEventActivityToUserKey = @"toUser";
NSString *const kEventActivityTypeKey = @"type";

// Event Activity Type values
NSString *const kEventActivityTypeLike       = @"like";
NSString *const kEventActivityTypeFollow     = @"follow";
NSString *const kEventActivityTypeComment    = @"comment";
NSString *const kEventActivityTypeJoined     = @"joined";


// Installation attribute keys
NSString *const kInstallationUserKey = @"user";


//#pragma mark - Push Notification Payload Keys
//
//NSString *const kAPNSAlertKey = @"alert";
//NSString *const kAPNSBadgeKey = @"badge";
//NSString *const kAPNSSoundKey = @"sound";
//
//// the following keys are intentionally kept short, APNS has a maximum payload limit
//NSString *const kPAPPushPayloadPayloadTypeKey          = @"p";
//NSString *const kPAPPushPayloadPayloadTypeActivityKey  = @"a";
//
//NSString *const kPAPPushPayloadActivityTypeKey     = @"t";
//NSString *const kPAPPushPayloadActivityLikeKey     = @"l";
//NSString *const kPAPPushPayloadActivityCommentKey  = @"c";
//NSString *const kPAPPushPayloadActivityFollowKey   = @"f";
//
//NSString *const kPAPPushPayloadFromUserObjectIdKey = @"fu";
//NSString *const kPAPPushPayloadToUserObjectIdKey   = @"tu";
NSString *const kPAPPushPayloadEventObjectIdKey    = @"eid";





