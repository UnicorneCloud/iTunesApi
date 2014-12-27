//
//  EPTableViewCellFeeds.h
//  iTunesApi
//
//  Created by Eric Pinet on 2014-12-27.
//  Copyright (c) 2014 Eric Pinet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EPTableViewCellFeeds : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView* image;

@property (weak, nonatomic) IBOutlet UILabel* title;

@property (weak, nonatomic) IBOutlet UILabel* artist;

@end
