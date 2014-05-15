//
//  BNRDetailTableViewController.h
//  NerdFeed
//
//  Created by Sam Podlogar on 5/14/14.
//  Copyright (c) 2014 Jeeble. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNRDetailTableViewController : UITableViewController

@property (weak, nonatomic) NSDictionary *currentDeveloper;
@property (weak, nonatomic) IBOutlet UITextView *comments;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *name;

@end
