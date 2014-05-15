//
//  BNRPostsViewController.h
//  NerdFeed
//
//  Created by Sam Podlogar on 5/14/14.
//  Copyright (c) 2014 Jeeble. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRPostsViewController : UITableViewController

@property (nonatomic) NSURLSession *session;
@property (nonatomic, copy) NSArray *developers;

@end
