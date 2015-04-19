//
//  ITunesMusicTrack.h
//  MusicPutt
//
//  Created by Eric Pinet on 2014-07-13.
//  Copyright (c) 2014 Eric Pinet. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  MusicTrack receive from the iTunes Search API. 
 */
@interface ITunesMusicTrack : NSObject



/**
 *  The name of the object returned by the search request.
 *  
 *  track, collection, artist
 *  For example: track.
 */
@property (nonatomic, copy) NSString *wrapperType;

/**
 *  The kind of content returned by the search request.
 *  
 *  book, album, coached-audio, feature-movie, interactive- booklet, music-video, pdf podcast, podcast-episode, software-package, song, tv- episode, artist
 */
@property (nonatomic, copy) NSString *kind;

/**
 *  Unique identifier of artist.
 */
@property (nonatomic, copy) NSString *artistId;

/**
 *  Unique identifier of collection.
 */
@property (nonatomic, copy) NSString *collectionId;

/**
 *  Unique identifier of music track.
 */
@property (nonatomic, copy) NSString *trackId;

/**
 *  The name of the artist returned by the search request.
 */
@property (nonatomic, copy) NSString *artistName;

/**
 *  The name of the album, TV season, audiobook, and so on returned by the search request.
 */
@property (nonatomic, copy) NSString *collectionName;

/**
 *  The name of the track, song, video, TV episode, and so on returned by the search request.
 */
@property (nonatomic, copy) NSString *trackName;

/**
 *  A URL for the content associated with the returned media type. You can click the URL to view the content in the iTunes Store.
 */
@property (nonatomic, copy) NSString *artistViewUrl;

/**
 *  A URL for the content associated with the returned media type. You can click the URL to view the content in the iTunes Store.
 */
@property (nonatomic, copy) NSString *collectionViewUrl;

/**
 *  A URL for the content associated with the returned media type. You can click the URL to view the content in the iTunes Store.
 */
@property (nonatomic, copy) NSString *trackViewUrl;

/**
 *  A URL referencing the 30-second preview file for the content associated with the returned media type.
 */
@property (nonatomic, copy) NSString *previewUrl;

/**
 *  A URL for the artwork associated with the returned media type, sized to 100x100 pixels or 60x60 pixels.
 */
@property (nonatomic, copy) NSString *artworkUrl60;

/**
 *  A URL for the artwork associated with the returned media type, sized to 100x100 pixels or 60x60 pixels.
 */
@property (nonatomic, copy) NSString *artworkUrl100;

/**
 *  Price of the collection. Exemple 7,99$ price of the album.
 */
@property (nonatomic, copy) NSString *collectionPrice;

/**
 *  Price of the music track.
 */
@property (nonatomic, copy) NSString *trackPrice;

/**
 *  Release date of the music track.
 */
@property (nonatomic, copy) NSDate *releaseDate;

/**
 *  The Recording Industry Association of America (RIAA) parental advisory for the content returned by the search request.
 *
 *  For more information, see http://itunes.apple.com/WebObjects/MZStore.woa/wa/parentalAdvisory.
 */
@property (nonatomic, copy) NSString *collectionExplicitness;

/**
 *  The Recording Industry Association of America (RIAA) parental advisory for the content returned by the search request.
 *
 *  For more information, see http://itunes.apple.com/WebObjects/MZStore.woa/wa/parentalAdvisory.
 */
@property (nonatomic, copy) NSString *trackExplicitness;

/**
 *  Count of disk in the collection.
 */
@property (nonatomic, copy) NSString *discCount;

/**
 *  Disc nomber where the music track is on.
 */
@property (nonatomic, copy) NSString *discNumber;

/**
 *  Track count on the disk.
 */
@property (nonatomic, copy) NSString *trackCount;

/**
 *  Track number of the music track on album.
 */
@property (nonatomic, copy) NSString *trackNumber;

/**
 *  The returned track's time in milliseconds.
 */
@property (nonatomic, copy) NSString *trackTimeMillis;

/**
 *  The two-letter country code for the store you want to search. The search uses the default store front for the specified country. For example: US.
 *
 *  The default is USA.
 */
@property (nonatomic, copy) NSString *country;

/**
 *  Devise user for price. (Exemple: USD)
 */
@property (nonatomic, copy) NSString *currency;

/**
 *  Genre name of the music track. Exemple: Alternative.
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
