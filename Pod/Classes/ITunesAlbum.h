//
//  ITunesAlbumAlbum.h
//  MusicPutt
//
//  Created by Eric Pinet on 2014-07-25.
//  Copyright (c) 2014 Eric Pinet. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  MusicTrack receive from the iTunes Search API.
 */
@interface ITunesAlbum : NSObject

/**
 *  The name of the object returned by the search request.
 *
 *  track, collection, artist
 *  For example: track.
 */
@property (nonatomic, copy) NSString *wrapperType;

/**
 *  collection type must be Album
 */
@property (nonatomic, copy) NSString *collectionType;

/**
 *  unique artist id
 */
@property (nonatomic, copy) NSString *artistId;

/**
 *  unique collection id (album)
 */
@property (nonatomic, copy) NSString *collectionId;

/**
 *  Astist's name
 */
@property (nonatomic, copy) NSString *artistName;

/**
 *  Collection's name
 */
@property (nonatomic, copy) NSString *collectionName;

/**
 *  Collection's censored name
 */
@property (nonatomic, copy) NSString *collectionCensoredName;

/**
 *  Artist view url
 */
@property (nonatomic, copy) NSString *artistViewUrl;

/**
 *  Collection view url
 */
@property (nonatomic, copy) NSString *collectionViewUrl;

/**
 *  Album artwork 60 px.
 */
@property (nonatomic, copy) NSString *artworkUrl60;

/**
 *  Album artwork 100 px.
 */
@property (nonatomic, copy) NSString *artworkUrl100;

/**
 *  Collection price
 */
@property (nonatomic, copy) NSString *collectionPrice;

/**
 *  The Recording Industry Association of America (RIAA) parental advisory for the content returned by the search request.
 *
 *  For more information, see http://itunes.apple.com/WebObjects/MZStore.woa/wa/parentalAdvisory.
 */
@property (nonatomic, copy) NSString *collectionExplicitness;

/**
 *  Nb track on album
 */
@property (nonatomic, copy) NSString *trackCount;

/**
 *  Copyright
 */
@property (nonatomic, copy) NSString *copyright;

/**
 *  Store country
 */
@property (nonatomic, copy) NSString *country;

/**
 *  Currency price
 */
@property (nonatomic, copy) NSString *currency;

/**
 *  Release date
 */
@property (nonatomic, copy) NSDate *releaseDate;

/**
 *  Primary genre for this album collection
 */
@property (nonatomic, copy) NSString *primaryGenreName;

/**
 *  Return URL of Artwork with custom quality.
 *
 *  @param quality Needed quality. (Sample: @"300x300-100")
 *
 *  @return url for this artwork with custom quality.
 */
- (NSString*) getArtworkUrlCustomQuality:(NSString*) quality;

@end
