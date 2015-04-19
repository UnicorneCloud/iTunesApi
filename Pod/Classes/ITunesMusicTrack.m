//
//  ITunesMusicTrack.m
//  MusicPutt
//
//  Created by Eric Pinet on 2014-07-13.
//  Copyright (c) 2014 Eric Pinet. All rights reserved.
//

#import "ITunesMusicTrack.h"

@implementation ITunesMusicTrack

/**
 *  Return URL of Artwork with custom quality.
 *
 *  @param quality Needed quality. (Sample: @"300x300-100")
 *
 *  @return url for this artwork with custom quality.
 */
- (NSString*) getArtworkUrlCustomQuality:(NSString*) quality
{
    return [_artworkUrl100 stringByReplacingOccurrencesOfString:@"100x100-75" withString:quality];
}

@end
