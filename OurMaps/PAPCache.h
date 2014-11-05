//
//  EventCache.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 10/28/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface PAPCache : NSObject

+ (id)sharedCache;

- (void)clear;
- (void)setAttributesForPhoto:(PFObject *)photo likers:(NSArray *)likers commenters:(NSArray *)commenters likedByCurrentUser:(BOOL)likedByCurrentUser;

- (NSDictionary *)attributesForPhoto:(PFObject *)photo;
- (NSDictionary *)attributesForEvent:(PFObject *)event;

- (NSNumber *)likeCountForPhoto:(PFObject *)photo;
- (NSNumber *)commentCountForPhoto:(PFObject *)photo;
- (NSNumber *)commentCountForEvent:(PFObject *)event;


- (NSArray *)likersForPhoto:(PFObject *)photo;
- (NSArray *)commentersForPhoto:(PFObject *)photo;
- (void)setPhotoIsLikedByCurrentUser:(PFObject *)photo liked:(BOOL)liked;
- (BOOL)isPhotoLikedByCurrentUser:(PFObject *)photo;
- (void)incrementLikerCountForPhoto:(PFObject *)photo;
- (void)decrementLikerCountForPhoto:(PFObject *)photo;
- (void)incrementCommentCountForPhoto:(PFObject *)photo;
- (void)decrementCommentCountForPhoto:(PFObject *)photo;

- (void)incrementCommentCountForEvent:(PFObject *)event;
- (void)decrementCommentCountForEvent:(PFObject *)event;

- (NSDictionary *)attributesForUser:(PFUser *)user;
- (NSNumber *)photoCountForUser:(PFUser *)user;
- (BOOL)followStatusForUser:(PFUser *)user;
- (void)setPhotoCount:(NSNumber *)count user:(PFUser *)user;
- (void)setFollowStatus:(BOOL)following user:(PFUser *)user;

- (void)setFacebookFriends:(NSArray *)friends;
- (NSArray *)facebookFriends;
@end
