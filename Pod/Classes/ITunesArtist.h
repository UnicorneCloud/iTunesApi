//
//  ITunesArtist.h
//  MusicPutt
//
//  Created by Eric Pinet on 2014-07-25.
//  Copyright (c) 2014 Eric Pinet. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  Artist receieved from iTunes Store
 */
@interface ITunesArtist : NSObject

/**
 *  wrapper Type.
 */
@property (nonatomic, copy) NSString *wrapperType;

/**
 *  Artist Type.
 */
@property (nonatomic, copy) NSString *artistType;

/**
 *  Artist Name.
 */
@property (nonatomic, copy) NSString *artistName;

/**
 *  Artist link url in the iTunes Store.
 */
@property (nonatomic, copy) NSString *artistLinkUrl;

/**
 *  Artist Id in the iTunes Store.
 */
@property (nonatomic, copy) NSString *artistId;

/**
 *  Artist AMG ID in the iTunes Store.
 */
@property (nonatomic, copy) NSString *amgArtistId;

/**
 *  Artist primary genre name.
 */
@property (nonatomic, copy) NSString *primaryGenreName;

/**
 *  Artist primary genre id.
 */
@property (nonatomic, copy) NSString *primaryGenreId;

/**
 *  Artist radio url.
 */
@property (nonatomic, copy) NSString *radioStationUrl;

@end
