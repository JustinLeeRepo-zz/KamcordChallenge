//
//  JLNetworkRequest.h
//  KamcordChallenge
//
//  Created by Justin Lee on 9/27/16.
//  Copyright © 2016 JustinLee. All rights reserved.
//

@import Foundation;
@import UIKit;
#import "JLShot.h"

@class JLNetworkRequest;

@protocol JLNetworkRequestDelegate <NSObject>

@required
- (void)didRecieveResponse:(JLNetworkRequest *)networkRequest withShots:(NSArray *)shots;
- (void)didFailToRecieveResponse:(JLNetworkRequest *)networkRequest withError:(NSError *)error;

@optional
- (void)didLoadThumbnail:(JLNetworkRequest *)networkRequest withThumbnail:(UIImage *)thumbnail;

@end

@interface JLNetworkRequest : NSObject

@property (nonatomic,   weak) id<JLNetworkRequestDelegate> delegate;
@property (nonatomic, strong) NSMutableArray<JLShot *> *shots;
@property (nonatomic, strong) NSMutableDictionary<NSURL *, UIImage *> *thumbnails;

+ (instancetype)sharedNetworkRequest;
- (void)initialize;
- (void)fetchRequest;

@end
