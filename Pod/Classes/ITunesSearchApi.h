//
//  ITunesSearchApi.h
//  MusicPutt
//
//  Created by Eric Pinet on 2014-07-13.
//  Copyright (c) 2014 Eric Pinet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ITunesMusicTrack.h"
#import "ITunesAlbum.h"
#import "ITunesArtist.h"


/**
 *  Enum of queryResult type.
 */
typedef enum {
    QueryMusicTrackWithSearchTerm,
    QueryMusicTrackWithId,
    QueryMusicTrackWithAlbumId,
    QueryMusicTrackWithArtistId,
    QueryAlbumWithSearchTerm,
    QueryAlbumWithId,
    QueryAlbumWithArtistId,
    QueryArtistWithSearchTerm,
    QueryArtistWithId,
    QueryAll
} ITunesSearchApiQueryType;

typedef enum {
    ITunesSearchApiStatusSucceed,
    ITunesSearchApiStatusFailed
} ITunesSearchApiQueryStatus;

/**
 *  Protocol for the delegate of the ITunesSearchApi.
 */
@protocol ITunesSearchApiDelegate <NSObject>

@optional

/**
 *  Implement this methode for recieve result after query.
 *
 *  @param status  Status of the querys
 *  @param type    Type of query sender
 *  @param results resultset of the query
 */
-(void) queryResult:(ITunesSearchApiQueryStatus)status type:(ITunesSearchApiQueryType)type results:(NSArray*)results;

@end



@class MPMediaItem;

/**
 *  Service for access to iTunes Store.
 *
 *  This class is a wrapper on the iTunes Store Search API. Looking at: https://www.apple.com/itunes/affiliates/resources/documentation/itunes-store-web-service-search-api.html
 *  for details of the API.
 */
@interface ITunesSearchApi : NSObject



@property (weak,nonatomic) NSString* country;


/**
 *  Set delegate to recieve result of query.
 *
 *  @param anObject delegate object with ITunesSearchApiDelegate protocol.
 */
- (void) setDelegate:(id) anObject;

/**
 *  Execute query for return musics tracks from iTunes Store and return results to the delagate.
 *
 *  @param searchTerm see itunes api doc
 *  @param async true if you want asynchronization mode
 */
- (void) queryMusicTrackWithSearchTerm:(NSString*)searchTerm asynchronizationMode:(BOOL) async;

/**
 *  Execute query in iTunes Store and return music track with this id to the delagate.
 *
 *  @param itemId   id of the music track to find
 *  @param async true if you want asynchronization mode
 */
- (void) queryMusicTrackWithId:(NSString*)itemId asynchronizationMode:(BOOL) async;

/**
 *  Execute query in iTunes Store and return music track with this album id to the delagate.
 *
 *  @param itemId   id of the album to find
 *  @param async true if you want asynchronization mode
 */
- (void) queryMusicTrackWithAlbumId:(NSString*)itemId asynchronizationMode:(BOOL) async;

/**
 *  Execute query in iTunes Store and return music track with this artist id to the delagate.
 *
 *  @param itemId   id of the artist to find
 *  @param async true if you want asynchronization mode
 */
- (void) queryMusicTrackWithArtistId:(NSString*)itemId asynchronizationMode:(BOOL) async;

/**
 *  Execute query for return albums from iTunes Store and return results to the delagate.
 *
 *  @param searchTerm see itunes api doc
 *  @param async true if you want asynchronization mode
 */
- (void) queryAlbumWithSearchTerm:(NSString*)searchTerm asynchronizationMode:(BOOL) async;

/**
 *  Execute query in iTunes Store and return music track with this id to the delagate.
 *
 *  @param itemId   id of the music track to find
 *  @param async true if you want asynchronization mode
 */
- (void) queryAlbumWithId:(NSString*)itemId asynchronizationMode:(BOOL) async;

/**
 *  Execute query in iTunes Store and return all album for an artist with this id to the delagate.
 *
 *  @param itemId   id of the music track to find
 *  @param async true if you want asynchronization mode
 */
- (void) queryAlbumWithArtistId:(NSString*)itemId asynchronizationMode:(BOOL) async;

/**
 *  Execute query in iTunes Store and return all artist for an searchterm.
 *
 *  @param searchTerm see itunes api doc.
 *  @param async      true if you want asynchronization mode.
 */
- (void) queryArtistWithSearchTerm:(NSString*) searchTerm  asynchronizationMode:(BOOL) async;

/**
 *  Build searchterm for find song in iTunes Store.
 *
 *  @param mediaitem MediaItem that you expect find in store.
 *  @return searchTerm to find song.
 */
-(NSString*) buildSearchTermForMusicTrackFromMediaItem:(MPMediaItem*) mediaitem;



@end
