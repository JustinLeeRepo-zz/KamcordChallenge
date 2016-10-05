//
//  JLShot.m
//  KamcordChallenge
//
//  Created by Justin Lee on 9/27/16.
//  Copyright © 2016 JustinLee. All rights reserved.
//

#import "JLShot.h"

@interface JLShot()

@property (nonatomic, strong, readwrite) NSDictionary<NSString *, NSString *> *shotThumbnail;
@property (nonatomic, strong, readwrite) NSURL *play;
@property (nonatomic, assign, readwrite) NSUInteger heartCount;

@end

@implementation JLShot

- (instancetype)initWithShotThumbNail:(NSDictionary *)shotThumbNail play:(NSURL *)play heartCount:(NSUInteger)heartCount
{
    self = [super init];
    if ( self )
    {
        self.shotThumbnail = shotThumbNail;
        self.play = play;
        self.heartCount = heartCount;
    }
    return self;
}

@end
