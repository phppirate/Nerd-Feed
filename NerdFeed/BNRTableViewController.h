//
//  BNRTableViewController.h
//  NerdFeed
//
//  Created by Sam Podlogar on 5/14/14.
//  Copyright (c) 2014 Jeeble. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNRTableViewController : UITableViewController

@property (nonatomic) NSURLSession *session;
@property (nonatomic, copy) NSArray *developers;

@end
