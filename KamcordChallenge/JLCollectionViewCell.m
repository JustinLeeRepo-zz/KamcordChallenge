//
//  JLCollectionViewCell.m
//  KamcordChallenge
//
//  Created by Justin Lee on 9/27/16.
//  Copyright © 2016 JustinLee. All rights reserved.
//

#import "JLCollectionViewCell.h"
#import "JLNetworkRequest.h"

@interface JLCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
@end

@implementation JLCollectionViewCell

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setShot:(JLShot *)shot
{
    _shot = shot;
    NSString *URLString = shot.shotThumbnail[@"medium"];
    NSDictionary *thumbnails = [JLNetworkRequest sharedNetworkRequest].thumbnails;
    self.thumbnail.image = thumbnails[URLString];
}

@end
