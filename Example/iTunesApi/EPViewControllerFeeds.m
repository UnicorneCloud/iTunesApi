//
//  EPViewControllerFeeds.m
//  iTunesApi
//
//  Created by Eric Pinet on 2014-12-27.
//  Copyright (c) 2014 Eric Pinet. All rights reserved.
//

#import "EPViewControllerFeeds.h"
#import "EPTableViewCellFeeds.h"

#import <iTunesApi/ITunesApi.h>


@interface EPViewControllerFeeds () <ITunesFeedsApiDelegate, UITableViewDataSource, UITableViewDelegate>
{
    ITunesFeedsApi *iTunes;
    
    NSArray* resultArray;
}

@property (weak, nonatomic) IBOutlet UITableView* tableview;

@end

@implementation EPViewControllerFeeds

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [_tableview setDelegate:self];
    [_tableview setDataSource:self];
    
    // Setup iTunes
    iTunes = [[ITunesFeedsApi alloc] init];
    [iTunes setDelegate:self];
    
    // execute query for top 10 album in canada
    [iTunes queryFeedType:QueryTopAlbums forCountry:@"ca" size:10 genre:0 asynchronizationMode:TRUE];
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

- (EPTableViewCellFeeds *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EPTableViewCellFeeds* cell = [tableView dequeueReusableCellWithIdentifier:@"CellFeeds"];
    
    ITunesAlbum* cur = resultArray[indexPath.row];
    
    [cell title].text = cur.collectionName;
    [cell artist].text = cur.artistName;
    
    id path = [cur artworkUrl100];
    NSURL *url = [NSURL URLWithString:path];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    
    [cell image].image = img;
    
    return cell;
}



#pragma mark - ITunesFeedsApiDelegate

-(void) queryResult:(ITunesFeedsApiQueryStatus)status type:(ITunesFeedsQueryType)type results:(NSArray*)results
{
    resultArray = results;
    [_tableview reloadData];
}

@end
