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

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSDate *releaseDate;
@property (nonatomic, strong) NSNumber *numberOfActor;
@property (nonatomic, strong) NSNumber *suitAllAges;
@property (nonatomic, strong) Genre *genre;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *shortName;
@property (nonatomic, strong) NSString *choice;
@property (nonatomic, strong) NSNumber *rate;
@property (nonatomic, strong) NSString *subtitle;

+ (id)movieWithTitle:(NSString *)title content:(NSString *)content;

@end
