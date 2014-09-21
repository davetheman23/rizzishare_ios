//
//  Movie.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/21/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Genre;

@interface Movie : NSObject

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSDate *releaseDate;
@property (nonatomic, retain) NSNumber *numberOfActor;
@property (nonatomic, retain) NSNumber *suitAllAges;
@property (nonatomic, retain) Genre *genre;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *shortName;
@property (nonatomic, retain) NSString *choice;
@property (nonatomic, retain) NSNumber *rate;
@property (nonatomic, strong) NSString *subtitle;

+ (id)movieWithTitle:(NSString *)title content:(NSString *)content;

@end
