//
//  ITunesFeedsApi.m
//  MusicPutt
//
//  Created by Eric Pinet on 2014-08-30.
//  Copyright (c) 2014 Eric Pinet. All rights reserved.
//

#import "ITunesFeedsApi.h"

#import "ITunesAlbum.h"
#import "ITunesMusicTrack.h"


@interface ITunesFeedsApi()
{
    id  delegate;
    
    NSMutableData*          webData;
    NSMutableArray*         albums;
    NSMutableArray*         tracks;
    NSURLConnection*        connection;
    
    ITunesFeedsQueryType    currentQueryType;
}

@end


@implementation ITunesFeedsApi

/**
 *  Set delegate to recieve result of query.
 *
 *  @param anObject delegate object with ITunesFeedsApiDelegate protocol.
 */
- (void) setDelegate:(id) anObject
{
    delegate = anObject;
}

/**
 *  Receive response from web json api.
 *
 *  @param connection <#connection description#>
 *  @param response   <#data description#>
 */
-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength:0];
}

/**
 *  Receive data from web api
 *
 *  @param connection <#connection description#>
 *  @param data       <#data description#>
 */
- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
}

/**
 *  Connection error.
 *
 *  @param connection <#connection description#>
 *  @param error      <#error description#>
 */
- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@" %s - %@\n", __PRETTY_FUNCTION__, @"Error");
    
    if ( [delegate respondsToSelector:@selector(queryResult:type:results:)]){
        [delegate queryResult:StatusFailed type:currentQueryType results: nil];
    }
}

/**
 *  Connection is finish loading
 *
 *  @param connection <#connection description#>
 */
- (void) connectionDidFinishLoading:(NSURLConnection *)connection
{
   
    if (currentQueryType==QueryTopAlbums)
    {
        // if query is for top albums
        NSDictionary* allDataDictionary = [NSJSONSerialization JSONObjectWithData:webData options:0 error:nil];
        NSDictionary* feed = [allDataDictionary objectForKey:@"feed"];
        NSArray* entries = [feed objectForKey:@"entry"];
        
        // create new albums array
        albums = [[NSMutableArray alloc] init];
        
        for (NSDictionary *entry in entries)
        {
            // create new album
            ITunesAlbum* album = [[ITunesAlbum alloc] init];
            
            // load album title
            NSDictionary* title = [entry objectForKey:@"im:name"];
            NSString* strTitle = [title objectForKey:@"label"];
            [album setCollectionName:strTitle];
            
            // load artist name
            NSDictionary* artist = [entry objectForKey:@"im:artist"];
            NSString* strArtist = [artist objectForKey:@"label"];
            [album setArtistName:strArtist];
            
            // load album artwork
            NSArray* artworks = [entry objectForKey:@"im:image"];
            NSDictionary* artwork = [artworks objectAtIndex:2];
            NSString* strArtwork = [artwork objectForKey:@"label"];
            [album setArtworkUrl100:strArtwork];
            
            // load track count
            NSDictionary* count = [entry objectForKey:@"im:itemCount"];
            NSString* strItemCount = [count objectForKey:@"label"];
            [album setTrackCount:strItemCount];
            
            // load price
            NSDictionary* price = [entry objectForKey:@"im:price"];
            NSString* strPrice = [price objectForKey:@"label"];
            [album setCollectionPrice:strPrice];
            
            // load link
            NSDictionary* link = [entry objectForKey:@"link"];
            NSDictionary* attributes = [link objectForKey:@"attributes"];
            NSString* strLink = [attributes objectForKey:@"href"];
            [album setCollectionViewUrl:strLink];
            
            // load collection id
            NSDictionary* collectionId = [entry objectForKey:@"id"];
            NSDictionary* attributes2 = [collectionId objectForKey:@"attributes"];
            NSString* strCollectionId = [attributes2 objectForKey:@"im:id"];
            [album setCollectionId:strCollectionId];
            
            // load release date
            NSDictionary* releaseDate = [entry objectForKey:@"im:releaseDate"];
            NSDictionary* attributes3 = [releaseDate objectForKey:@"attributes"];
            NSString* strReleaseDate = [attributes3 objectForKey:@"label"];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"MMMM dd, yyyy"];
            NSDate* date = [[NSDate alloc] init];
            date = [formatter dateFromString:strReleaseDate]; //TODO: ReleaseDate format doesn't work!
            [album setReleaseDate:date];
            
            // load gender
            NSDictionary* category = [entry objectForKey:@"category"];
            NSDictionary* attributes4 = [category objectForKey:@"attributes"];
            NSString* strGender = [attributes4 objectForKey:@"term"];
            [album setPrimaryGenreName:strGender];
            
            [albums addObject:album];
        }
        
        
        //About to update the UI, so jump back to the main/UI thread
        NSLog(@" %s - %@\n", __PRETTY_FUNCTION__, @"send delegate message");
        dispatch_async(dispatch_get_main_queue(), ^{
            if ( [delegate respondsToSelector:@selector(queryResult:type:results:)]){
                [delegate queryResult:StatusSucceed type:currentQueryType results: albums];
            }
        });
    }
    else if (currentQueryType == QueryTopSongs)
    {
        // if query is top songs
        NSDictionary* allDataDictionary = [NSJSONSerialization JSONObjectWithData:webData options:0 error:nil];
        NSDictionary* feed = [allDataDictionary objectForKey:@"feed"];
        NSArray* entries = [feed objectForKey:@"entry"];
        
        // create new albums array
        tracks = [[NSMutableArray alloc] init];
        
        for (NSDictionary *entry in entries)
        {
            ITunesMusicTrack* track = [[ITunesMusicTrack alloc]init];
            
            // load track id
            NSDictionary* trackid = [entry objectForKey:@"id"];
            NSDictionary* attributes = [trackid objectForKey:@"attributes"];
            NSString* strTrackId = [attributes objectForKey:@"im:id"];
            [track setTrackId:strTrackId];
            
            // load track title
            NSDictionary* title = [entry objectForKey:@"im:name"];
            NSString* strTitle = [title objectForKey:@"label"];
            [track setTrackName:strTitle];
            
            // load artist name
            NSDictionary* artist = [entry objectForKey:@"im:artist"];
            NSString* strArtist = [artist objectForKey:@"label"];
            [track setArtistName:strArtist];
            
            // load collection name
            NSDictionary* collection = [entry objectForKey:@"im:collection"];
            NSDictionary* collectionName = [collection objectForKey:@"im:name"];
            NSString* strCollectionName = [collectionName objectForKey:@"label"];
            [track setCollectionName:strCollectionName];
            
            // load album artwork
            NSArray* artworks = [entry objectForKey:@"im:image"];
            NSDictionary* artwork = [artworks objectAtIndex:2];
            NSString* strArtwork = [artwork objectForKey:@"label"];
            [track setArtworkUrl100:strArtwork];
            
            // load preview
            NSArray* link = [entry objectForKey:@"link"];
            NSDictionary* link1 = [link objectAtIndex:1];
            NSDictionary* attributes2 = [link1 objectForKey:@"attributes"];
            NSString* strPreview = [attributes2 objectForKey:@"href"];
            [track setPreviewUrl:strPreview];
            
            [tracks addObject:track];
        }
        
        
        //About to update the UI, so jump back to the main/UI thread
        NSLog(@" %s - %@\n", __PRETTY_FUNCTION__, @"send delegate message");
        dispatch_async(dispatch_get_main_queue(), ^{
            if ( [delegate respondsToSelector:@selector(queryResult:type:results:)]){
                [delegate queryResult:StatusSucceed type:currentQueryType results: tracks];
            }
        });
        
    }
}


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
- (void) queryFeedType:(ITunesFeedsQueryType)type forCountry:(NSString*)country size:(NSInteger)size genre:(NSInteger)genre asynchronizationMode:(BOOL)async
{
    // start by validating parameters.
    if ([self validateParameters:type forCountry:country size:size genre:genre asynchronizationMode:async])
    {
        // parameters are valid.
        // start request.
        NSString* queryType = @"topsongs";
        currentQueryType = QueryTopSongs;
        if (type == QueryTopAlbums) {
            queryType = @"topalbums";
            currentQueryType = QueryTopAlbums;
        }
        
        // genre
        NSString* strGenre = @"";
        if (genre!=0) {
            strGenre = [NSString stringWithFormat:@"genre=%ld/", (long)genre];
        }
        
        NSString* strUrl = [NSString stringWithFormat:@"https://itunes.apple.com/%@/rss/%@/limit=%ld/%@explicit=true/json",country, queryType, (long)size, strGenre];
        NSURL* url = [NSURL URLWithString:strUrl];
        NSURLRequest* request = [NSURLRequest requestWithURL:url];
        
        if (async) {
            
            NSLog(@" %s - %@\n", __PRETTY_FUNCTION__, @"Begin request");
            
            [NSURLConnection
             sendAsynchronousRequest:request
             queue:[[NSOperationQueue alloc] init]
             completionHandler:^(NSURLResponse *response,
                                 NSData *data,
                                 NSError *error)
             {
                 
                 if ([data length] >0 && error == nil)
                 {
                     webData = (NSMutableData*)data;
                     
                     NSLog(@" %s - %@\n", __PRETTY_FUNCTION__, @"unpack request");
                     [self connectionDidFinishLoading:nil];
                 }
                 else if ([data length] == 0 && error == nil)
                 {
                     NSLog(@"Nothing was downloaded.");
                 }
                 else if (error != nil){
                     NSLog(@"Error = %@", error);
                 }
                 
             }];
        }
        else{
            connection = [NSURLConnection connectionWithRequest:request delegate:self];
            if (connection) {
                webData = [[NSMutableData alloc]init];
            }
        }
        
        
    }
    else{
        NSLog(@" %s - %@\n", __PRETTY_FUNCTION__, @"Error - Invalid parameters");
        
        if ( [delegate respondsToSelector:@selector(queryResult:type:results:)]){
            [delegate queryResult:StatusFailed type:type results: nil];
        }
    }
}


/**
 *  Validate parameters for querry
 *
 *  @param type    <#type description#>
 *  @param country <#country description#>
 *  @param size    <#size description#>
 *  @param genre   <#genre description#>
 *  @param async   <#async description#>
 *  @return true if all parameters are valid
 */
- (BOOL) validateParameters:(ITunesFeedsQueryType)type forCountry:(NSString*)country size:(NSInteger)size genre:(NSInteger)genre asynchronizationMode:(BOOL)async
{
    return TRUE;
}


/**
 *  Return the gender name from the gender id.
 *
 *  @param genderId GenderID in the iTunes Store.
 *
 *  @return Gender name.
 */
- (NSString*) getGenderName:(NSInteger)genderId
{
    NSString* retGender = @"";
    
    if (genderId==GENRE_ALTERNATIVE)
        retGender = GENRE_ALTERNATIVE_TXT;
    else if (genderId == GENRE_ANIME)
        retGender = GENRE_ANIME_TXT;
    else if (genderId == GENRE_BLUES)
        retGender = GENRE_BLUES_TXT;
    else if (genderId == GENRE_BRAZILIAN)
        retGender = GENRE_BRAZILIAN_TXT;
    else if (genderId == GENRE_CHILDRENSMUSIC)
        retGender = GENRE_CHILDRENSMUSIC_TXT;
    else if (genderId == GENRE_CHINESE)
        retGender = GENRE_CHINESE_TXT;
    else if (genderId == GENRE_CHRISTIANGOSPEL)
        retGender = GENRE_CHRISTIANGOSPEL_TXT;
    else if (genderId == GENRE_CLASSICAL)
        retGender = GENRE_CLASSICAL_TXT;
    else if (genderId == GENRE_COMEDY)
        retGender = GENRE_COMEDY_TXT;
    else if (genderId == GENRE_COUNTRY)
        retGender = GENRE_COUNTRY_TXT;
    else if (genderId == GENRE_DANCE)
        retGender = GENRE_DANCE_TXT;
    //else if (genderId == GENRE_DISNEY)
    //    retGender = GENRE_DISNEY_TXT;
    else if (genderId == GENRE_EASYLISTENING)
        retGender = GENRE_EASYLISTENING_TXT;
    else if (genderId == GENRE_ELECTRONIC)
        retGender = GENRE_ELECTRONIC_TXT;
    else if (genderId == GENRE_ENKA)
        retGender = GENRE_ENKA_TXT;
    else if (genderId == GENRE_FITNESSWORKOUT)
        retGender = GENRE_FITNESSWORKOUT_TXT;
    //else if (genderId == GENRE_FRENCHPOP)
    //    retGender = GENRE_FRENCHPOP_TXT;
    //else if (genderId == GENRE_GERMANFOLK)
    //    retGender = GENRE_GERMANFOLK_TXT;
    //else if (genderId == GENRE_GERMANPOP)
    //    retGender = GENRE_GERMANPOP_TXT;
    else if (genderId == GENRE_HIPHOPRAP)
        retGender = GENRE_HIPHOPRAP_TXT;
    else if (genderId == GENRE_HOLIDAY)
        retGender = GENRE_HOLIDAY_TXT;
    else if (genderId == GENRE_INDIAN)
        retGender = GENRE_INDIAN_TXT;
    else if (genderId == GENRE_INSTRUMENTAL)
        retGender = GENRE_INSTRUMENTAL_TXT;
    else if (genderId == GENRE_JPOP)
        retGender = GENRE_JPOP_TXT;
    else if (genderId == GENRE_JAZZ)
        retGender = GENRE_JAZZ_TXT;
    else if (genderId == GENRE_KPOP)
        retGender = GENRE_KPOP_TXT;
    else if (genderId == GENRE_KARAOKE)
        retGender = GENRE_KARAOKE_TXT;
    else if (genderId == GENRE_KAYOKYOKU)
        retGender = GENRE_KAYOKYOKU_TXT;
    else if (genderId == GENRE_KOREAN)
        retGender = GENRE_KOREAN_TXT;
    else if (genderId == GENRE_LATINO)
        retGender = GENRE_LATINO_TXT;
    else if (genderId == GENRE_NEWAGE)
        retGender = GENRE_NEWAGE_TXT;
    else if (genderId == GENRE_OPERA)
        retGender = GENRE_OPERA_TXT;
    else if (genderId == GENRE_POP)
        retGender = GENRE_POP_TXT;
    else if (genderId == GENRE_RBSOUL)
        retGender = GENRE_RBSOUL_TXT;
    else if (genderId == GENRE_REGGAE)
        retGender = GENRE_REGGAE_TXT;
    else if (genderId == GENRE_ROCK)
        retGender = GENRE_ROCK_TXT;
    else if (genderId == GENRE_SINGERSONGWRITER)
        retGender = GENRE_SINGERSONGWRITER_TXT;
    else if (genderId == GENRE_SOUNDTRACK)
        retGender = GENRE_SOUNDTRACK_TXT;
    //else if (genderId == GENRE_SPOKENWORD)
    //    retGender = GENRE_SPOKENWORD_TXT;
    else if (genderId == GENRE_VOCAL)
        retGender = GENRE_VOCAL_TXT;
    else if (genderId == GENRE_WORLD)
        retGender = GENRE_WORLD_TXT;
    
    return retGender;
}

@end
