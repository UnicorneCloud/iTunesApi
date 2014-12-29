iTunesApi
============

iTunesApi is a simple, synchronous/asynchronous API controller and object for searching the iTunes Search API and iTunes Feeds.

- **ITunesSearchApi**: Use this class to search in the iTunes Store (Music) songs, albums and artist.
- **ITunesFeedsApi**: Use this class to get top album or songs in the iTunes Store (Music). 

Documentation : [iTunesApiDocs](http://cocoadocs.org/docsets/iTunesApi) 

# iTunesApi

[![CI Status](http://img.shields.io/travis/Eric Pinet/iTunesApi.svg?style=flat)](https://travis-ci.org/Eric Pinet/iTunesApi)
[![Version](https://img.shields.io/cocoapods/v/iTunesApi.svg?style=flat)](http://cocoadocs.org/docsets/iTunesApi)
[![License](https://img.shields.io/cocoapods/l/iTunesApi.svg?style=flat)](http://cocoadocs.org/docsets/iTunesApi)
[![Platform](https://img.shields.io/cocoapods/p/iTunesApi.svg?style=flat)](http://cocoadocs.org/docsets/iTunesApi)

## Requirements

- AFNetworking
- RestKit

## Installation

iTunesApi is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod 'iTunesApi'

And execute this command in your project folder:

    pod install

## Usage of 'ITunesSearchApi'.

ITunesSearchApi class is use to search in the iTunes Store songs, albums and artist. 

See the sample project iTunesApi in 'Exemple' directory.

Import header file for iTunesApi:

    #import <iTunesApi/ITunesApi.h>

Add delegate 'ITunesSearchApiDelegate' protocol to your class and create a member variable:

    @interface EPViewController () <ITunesSearchApiDelegate>
    {
        ITunesSearchApi *iTunes;
    }

Add delegate function to receive result:

    #pragma mark - ITunesSearchApiDelegate
    
    -(void) queryResult:(ITunesSearchApiQueryStatus)status type:(ITunesSearchApiQueryType)type results:(NSArray*)results
    {
        if (status==ITunesSearchApiStatusSucceed &&
            type == QueryMusicTrackWithSearchTerm) {
     
            resultArray = results;
            
            ...
        }
    }

Initialise ITunesSearchApi with delegate:

    iTunes = [[ITunesSearchApi alloc] init];
    [iTunes setDelegate:self];

Execute query:

    [iTunes queryMusicTrackWithSearchTerm:@"london+grammar+strong" asynchronizationMode:TRUE];


## Usage of 'ITunesFeedsApi'.

ITunesFeedsApi class is use to get top album and songs from the iTunes Store. 

See the sample project iTunesApi in 'Exemple' directory.

Import header file for iTunesApi:

    #import <iTunesApi/ITunesApi.h>

Add delegate 'ITunesFeedsApiDelegate' protocol to your class and create a member variable:

    @interface EPViewController () <ITunesFeedsApiDelegate>
    {
        ITunesFeedsApi *iTunes;
    }

Add delegate function to receive result:

    #pragma mark - ITunesFeedsApiDelegate

    -(void) queryResult:(ITunesFeedsApiQueryStatus)status type:(ITunesFeedsQueryType)type results:(NSArray*)results
    {
        resultArray = results;
        ...
    }

Initialise ITunesSearchApi with delegate:

    iTunes = [[ITunesFeedsApi alloc] init];
    [iTunes setDelegate:self];

Execute query for top 10 albums in canada:

    [iTunes queryFeedType:QueryTopAlbums forCountry:@"ca" size:10 genre:0 asynchronizationMode:TRUE];

Execute query for top 10 songs in us:

    [iTunes queryFeedType:QueryTopSongs forCountry:@"us" size:10 genre:0 asynchronizationMode:TRUE];


## Author

Eric Pinet, pineri01@gmail.com

## License

iTunesApi is available under the MIT license. See the LICENSE file for more info.

