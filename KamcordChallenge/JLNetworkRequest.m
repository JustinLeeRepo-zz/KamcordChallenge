//
//  JLNetworkRequest.m
//  KamcordChallenge
//
//  Created by Justin Lee on 9/27/16.
//  Copyright © 2016 JustinLee. All rights reserved.
//

#import "JLNetworkRequest.h"

@interface JLNetworkRequest ()
@property (nonatomic, strong) NSString *pagingKey;
@end

@implementation JLNetworkRequest

static NSString * const JLNetworkRequestEndpoint =          @"https://api.staging.kamcord.com/v1/feed/set/featuredShots";
static NSString * const JLNetworkRequestPagingEndpoint =    @"https://api.kamcord.com/v1/feed/ZmVlZElkPWZlZWRfZmVhdHVyZWRfc2hvdCZ1c2VySWQmdG9waWNJZCZzdHJlYW1TZXNzaW9uSWQmbGFuZ3VhZ2VDb2Rl";

+(instancetype)sharedNetworkRequest
{
    static JLNetworkRequest *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)initialize
{
    self.shots = [NSMutableArray array];
    self.thumbnails = [NSMutableDictionary dictionary];
}

- (void)fetchRequest
{
    NSURLSessionConfiguration *defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    defaultConfiguration.HTTPAdditionalHeaders = @{
                                                   @"count"         : @"20",
                                                   @"device-token"  : @"ab123",
                                                   @"client-name"   : @"ios",
                                                   @"nextPage"      : self.pagingKey ?: @""
                                                   };
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfiguration];
    NSURL *URL = [NSURL URLWithString: JLNetworkRequestPagingEndpoint];
    NSURLRequest *request = [NSURLRequest requestWithURL: URL];
    
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest: request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if ( !error )
        {
            NSError *serializationError;
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData: data
                                                                       options: NSJSONReadingAllowFragments
                                                                         error: &serializationError];
            if( !serializationError )
            {
                NSArray *cards = dictionary[@"cards"];
                self.pagingKey = dictionary[@"nextPage"];
                
                dispatch_group_t thumbnailGroup = dispatch_group_create();
                for ( NSDictionary *card in cards )
                {
                    NSDictionary *shotProperties = card[@"shotCardData"];
                    
                    NSDictionary *thumbnailDict = shotProperties[@"shotThumbnail"];
                    NSURL *play = [NSURL URLWithString: shotProperties[@"play"][@"mp4"]];
                    NSUInteger heartCount = [shotProperties[@"heartCount"] unsignedIntegerValue];
                    
                    JLShot *shot = [[JLShot alloc] initWithShotThumbNail: thumbnailDict
                                                                    play: play
                                                              heartCount: heartCount];
                    [self.shots addObject: shot];
                    
                    NSString *thumbnailString = shot.shotThumbnail[@"medium"];
                    [self loadThumbnail: thumbnailString withDispatchGroup: thumbnailGroup];
                }
                dispatch_group_wait(thumbnailGroup, DISPATCH_TIME_FOREVER);
                if ( [self.delegate respondsToSelector: @selector(didRecieveResponse:withShots:)] )
                {
                    [self.delegate didRecieveResponse: self withShots: self.shots];
                }
            }
            else
            {
                if( [self.delegate respondsToSelector: @selector(didFailToRecieveResponse:withError:)] )
                {
                    [self.delegate didFailToRecieveResponse: self withError: serializationError];
                }
            }
        }
        else
        {
            if( [self.delegate respondsToSelector: @selector(didFailToRecieveResponse:withError:)] )
            {
                [self.delegate didFailToRecieveResponse: self withError: error];
            }
        }
    }];
    [dataTask resume];
}

- (void)loadThumbnail:(NSString *)URLString withDispatchGroup:(dispatch_group_t)dispatchGroup
{
    dispatch_group_async(dispatchGroup, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *URL = [NSURL URLWithString: URLString];
        NSData *data = [NSData dataWithContentsOfURL: URL];
        UIImage *thumbnail = [UIImage imageWithData: data];
        self.thumbnails[URLString] = thumbnail;
    });
}

@end
