//
//  JLShot.h
//  KamcordChallenge
//
//  Created by Justin Lee on 9/27/16.
//  Copyright © 2016 JustinLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLShot : NSObject

@property (nonatomic, strong, readonly) NSDictionary<NSString *, NSString *> *shotThumbnail;
@property (nonatomic, strong, readonly) NSURL *play;
@property (nonatomic, assign, readonly) NSUInteger heartCount;

- (instancetype)initWithShotThumbNail:(NSDictionary *)shotThumbNail play:(NSURL *)play heartCount:(NSUInteger)heartCount;

@end
