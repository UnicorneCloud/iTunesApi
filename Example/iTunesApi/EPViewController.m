//
//  EPViewController.m
//  iTunesApi
//
//  Created by Eric Pinet on 12/27/2014.
//  Copyright (c) 2014 Eric Pinet. All rights reserved.
//

#import "EPViewController.h"
#import "EPTableViewCellSearch.h"

#import <iTunesApi/ITunesApi.h>


@interface EPViewController () <ITunesSearchApiDelegate, UITableViewDataSource, UITableViewDelegate>
{
    ITunesSearchApi *iTunes;
    
    NSArray* resultArray;
}

@property (weak, nonatomic) IBOutlet UITableView* tableview;

@end

@implementation EPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [_tableview setDelegate:self];
    [_tableview setDataSource:self];
    
    // Setup iTunes
    iTunes = [[ITunesSearchApi alloc] init];
    [iTunes setDelegate:self];
    
    // execute query for music track
    [iTunes queryMusicTrackWithSearchTerm:@"london+grammar+strong" asynchronizationMode:true];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (resultArray) {
        return resultArray.count;
    }
    return 0;
}

- (EPTableViewCellSearch *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EPTableViewCellSearch* cell = [tableView dequeueReusableCellWithIdentifier:@"CellSearch"];
    
    ITunesMusicTrack* cur = resultArray[indexPath.row];
    
    [cell title].text = cur.trackName;
    [cell artist].text = cur.artistName;
    
    id path = [cur getArtworkUrlCustomQuality:@"100x100-75"];
    NSURL *url = [NSURL URLWithString:path];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    
    [cell image].image = img;
    
    return cell;
}



#pragma mark - ITunesSearchApiDelegate

-(void) queryResult:(ITunesSearchApiQueryStatus)status type:(ITunesSearchApiQueryType)type results:(NSArray*)results
{
    if (status==ITunesSearchApiStatusSucceed &&
        type == QueryMusicTrackWithSearchTerm) {
        
        resultArray = results;
        
        [_tableview reloadData];
    }
}

@end
