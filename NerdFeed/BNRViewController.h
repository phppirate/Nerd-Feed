//
//  BNRViewController.h
//  NerdFeed
//
//  Created by Sam Podlogar on 5/14/14.
//  Copyright (c) 2014 Jeeble. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNRViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *web;
- (IBAction)dismiss:(id)sender;

@end
