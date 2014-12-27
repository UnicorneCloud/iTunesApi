//
//  ITunesFeedsApi.h
//  MusicPutt
//
//  Created by Eric Pinet on 2014-08-30.
//  Copyright (c) 2014 Eric Pinet. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  Enum of queryResult type.
 */
typedef enum {
    QueryTopSongs,
    QueryTopAlbums
} ITunesFeedsQueryType;

/**
 *  Enum of query status.
 */
typedef enum {
    StatusSucceed,
    StatusFailed
} ITunesFeedsApiQueryStatus;


/**
 *  All genre for music top songs or top albums.
 */
#define GENRE_ALTERNATIVE       20
#define GENRE_ANIME             29
#define GENRE_BLUES             2
#define GENRE_BRAZILIAN         1122
#define GENRE_CHILDRENSMUSIC    4
#define GENRE_CHINESE           1232
#define GENRE_CHRISTIANGOSPEL   22
#define GENRE_CLASSICAL         5
#define GENRE_COMEDY            3
#define GENRE_COUNTRY           6
#define GENRE_DANCE             17
//#define GENRE_DISNEY            50000063
#define GENRE_EASYLISTENING     25
#define GENRE_ELECTRONIC        7
#define GENRE_ENKA              28
#define GENRE_FITNESSWORKOUT    50
//#define GENRE_FRENCHPOP         50000064
//#define GENRE_GERMANFOLK        50000068
//#define GENRE_GERMANPOP         50000066
#define GENRE_HIPHOPRAP         18
#define GENRE_HOLIDAY           8
#define GENRE_INDIAN            1262
#define GENRE_INSTRUMENTAL      53
#define GENRE_JPOP              27
#define GENRE_JAZZ              11
#define GENRE_KPOP              51
#define GENRE_KARAOKE           52
#define GENRE_KAYOKYOKU         30
#define GENRE_KOREAN            1243
#define GENRE_LATINO            12
#define GENRE_NEWAGE            13
#define GENRE_OPERA             9
#define GENRE_POP               14
#define GENRE_RBSOUL            15
#define GENRE_REGGAE            24
#define GENRE_ROCK              21
#define GENRE_SINGERSONGWRITER  10
#define GENRE_SOUNDTRACK        16
//#define GENRE_SPOKENWORD        50000061
#define GENRE_VOCAL             23
#define GENRE_WORLD             19

#define GENRE_ALTERNATIVE_TXT       @"Alternative"
#define GENRE_ANIME_TXT             @"Anime"
#define GENRE_BLUES_TXT             @"Blues"
#define GENRE_BRAZILIAN_TXT         @"Brazilian"
#define GENRE_CHILDRENSMUSIC_TXT    @"Children Music"
#define GENRE_CHINESE_TXT           @"Chinese"
#define GENRE_CHRISTIANGOSPEL_TXT   @"Christian Gospel"
#define GENRE_CLASSICAL_TXT         @"Classical"
#define GENRE_COMEDY_TXT            @"Comedy"
#define GENRE_COUNTRY_TXT           @"Country"
#define GENRE_DANCE_TXT             @"Dance"
#define GENRE_DISNEY_TXT            @"Disney"
#define GENRE_EASYLISTENING_TXT     @"Easy Listening"
#define GENRE_ELECTRONIC_TXT        @"Electronic"
#define GENRE_ENKA_TXT              @"Enka"
#define GENRE_FITNESSWORKOUT_TXT    @"Fitness Workout"
#define GENRE_FRENCHPOP_TXT         @"French Pop"
#define GENRE_GERMANFOLK_TXT        @"German Folk"
#define GENRE_GERMANPOP_TXT         @"German Pop"
#define GENRE_HIPHOPRAP_TXT         @"Hip Hop/Rap"
#define GENRE_HOLIDAY_TXT           @"Holiday"
#define GENRE_INDIAN_TXT            @"Indian"
#define GENRE_INSTRUMENTAL_TXT      @"Intrumental"
#define GENRE_JPOP_TXT              @"Jazz Pop"
#define GENRE_JAZZ_TXT              @"Jazz"
#define GENRE_KPOP_TXT              @"KPop"
#define GENRE_KARAOKE_TXT           @"Karaoke"
#define GENRE_KAYOKYOKU_TXT         @"Kayoyoku"
#define GENRE_KOREAN_TXT            @"Korean"
#define GENRE_LATINO_TXT            @"Latino"
#define GENRE_NEWAGE_TXT            @"New Age"
#define GENRE_OPERA_TXT             @"Opera"
#define GENRE_POP_TXT               @"Pop"
#define GENRE_RBSOUL_TXT            @"R&B Soul"
#define GENRE_REGGAE_TXT            @"Reggae"
#define GENRE_ROCK_TXT              @"Rock"
#define GENRE_SINGERSONGWRITER_TXT  @"Singer Song Writer"
#define GENRE_SOUNDTRACK_TXT        @"Soundtrack"
#define GENRE_SPOKENWORD_TXT        @"Spoken Word"
#define GENRE_VOCAL_TXT             @"Vocal"
#define GENRE_WORLD_TXT             @"World"


/**
 *  Protocol for the delegate of the MPServiceStore.
 */
@protocol ITunesFeedsApiDelegate <NSObject>

@optional

/**
 *  Implement this methode for recieve result after query.
 *
 *  @param status  Status of the querys
 *  @param type    Type of query sender
 *  @param results resultset of the query
 */
-(void) queryResult:(ITunesFeedsApiQueryStatus)status type:(ITunesFeedsQueryType)type results:(NSArray*)results;

@end


/**
 *  ITunesFeedsApi class permit to request at iTunes the top songs and top album.
 */
@interface ITunesFeedsApi : NSObject <NSURLConnectionDataDelegate>


/**
 *  Set delegate to recieve result of query.
 *
 *  @param anObject delegate object with ITunesFeedsApiDelegate protocol.
 */
- (void) setDelegate:(id) anObject;


/**
 *  Query iTunes feeds. When to result are ready, results are sends to ITunesFeedsApiDelegate queryResult.
 *  See: http://www.apple.com/itunes/affiliates/resources/blog/introduction---rss-feed-generator.html for more details
 *
 *  @param type    ITunesFeedsQueryType are QueryTopSongs or QueryTopAlbums.
 *  @param country Enter the country code. (United State:us, Canada:ca, etc...)
 *  @param size    Enter the size of result. (Must be: 10, 25,50 or 100)
 *  @param genre   Enter the genre: (0 for all) See: http://www.apple.com/itunes/affiliates/resources/documentation/genre-mapping.html for more details.
 *  @param async   <#async description#>
 */
- (void) queryFeedType:(ITunesFeedsQueryType)type forCountry:(NSString*) country size:(NSInteger) size genre:(NSInteger) genre asynchronizationMode:(BOOL) async;


/**
 *  Return the gender name from the gender id.
 *
 *  @param genderId GenderID in the iTunes Store.
 *
 *  @return Gender name.
 */
- (NSString*) getGenderName:(NSInteger)genderId;

@end
