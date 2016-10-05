//
//  JLShotsFeedCollectionViewController.m
//  KamcordChallenge
//
//  Created by Justin Lee on 9/27/16.
//  Copyright © 2016 JustinLee. All rights reserved.
//

@import AVKit;
@import AVFoundation;
#import "JLShotsFeedCollectionViewController.h"
#import "JLCollectionViewCell.h"

@interface JLShotsFeedCollectionViewController ()
@property (nonatomic, strong) NSArray *shots;
@property (nonatomic, assign) BOOL isLoading;
@end

@implementation JLShotsFeedCollectionViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *reuseIdentifier = [JLCollectionViewCell reuseIdentifier];
    
    UINib *collectionViewCellNib = [UINib nibWithNibName: reuseIdentifier bundle: nil];
    [self.collectionView registerNib: collectionViewCellNib forCellWithReuseIdentifier: reuseIdentifier];
    
    [JLNetworkRequest sharedNetworkRequest].delegate = self;
}

#pragma mark - JL Network Request Delegate

- (void)didRecieveResponse:(JLNetworkRequest *)networkRequest withShots:(NSArray *)shots
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.shots = [NSMutableArray arrayWithArray: shots];
        self.isLoading = NO;
        [self.collectionView reloadData];
    });
}

- (void)didFailToRecieveResponse:(JLNetworkRequest *)networkRequest withError:(NSError *)error
{
    NSLog(@"Error receieving response : Error %@", error.description);
}

#pragma mark - Collection View Data Source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.shots.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = [JLCollectionViewCell reuseIdentifier];
    JLCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: reuseIdentifier
                                                                           forIndexPath: indexPath];
    JLShot *shot = self.shots[indexPath.row];
    [cell setShot: shot];
    
    return cell;
}

#pragma mark - Collection View Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    JLShot *shot = self.shots[indexPath.row];
    NSURL *URL = shot.play;
    
    AVPlayerViewController *viewController = [[AVPlayerViewController alloc] init];
    viewController.player = [AVPlayer playerWithURL: URL];
    [viewController setShowsPlaybackControls: YES];
    [viewController.player play];
    [self presentViewController: viewController animated: YES completion: nil];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger indexOfLastCell = self.shots.count - 1;
    if ( indexPath.row == indexOfLastCell && !self.isLoading )
    {
        self.isLoading = YES;
        [[JLNetworkRequest sharedNetworkRequest] fetchRequest];
    }
}

@end
