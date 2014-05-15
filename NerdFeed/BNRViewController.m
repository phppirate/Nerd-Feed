//
//  BNRViewController.m
//  NerdFeed
//
//  Created by Sam Podlogar on 5/14/14.
//  Copyright (c) 2014 Jeeble. All rights reserved.
//

#import "BNRViewController.h"

@interface BNRViewController ()

@end

@implementation BNRViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *path = [[NSUserDefaults standardUserDefaults] stringForKey:@"addPath"];
    
    NSURL *url = [NSURL URLWithString:path];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    [self.web loadRequest:req];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
