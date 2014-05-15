//
//  BNRPostsViewController.m
//  NerdFeed
//
//  Created by Sam Podlogar on 5/14/14.
//  Copyright (c) 2014 Jeeble. All rights reserved.
//

#import "BNRPostsViewController.h"

@implementation BNRPostsViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    
    self.navigationItem.title = [[NSUserDefaults standardUserDefaults] stringForKey:@"appTitle"];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    _session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
    
    [self fetchFeed];
    
    [refresh addTarget:self action:@selector(relaodThisTableData) forControlEvents:UIControlEventValueChanged];
    
    self.refreshControl = refresh;

}

- (void)relaodThisTableData{
    [self fetchFeed];
    [self.tableView reloadData];
    [self stopRefresh];
}

- (void)stopRefresh

{
    [self.refreshControl endRefreshing];
}
     
     
-(id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
        self.navigationItem.title = [[NSUserDefaults standardUserDefaults] stringForKey:@"appTitle"];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        _session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
        
        [self fetchFeed];
    }
    
    return self;
}

- (void)fetchFeed {
    NSString *requestString = [[NSUserDefaults standardUserDefaults] stringForKey:@"dataSource"];
    //NSString *requestString = @"http://mission-4.com/developers/developers.json";
    //NSString *requestString = @"http://mission-4.com/api/get_posts/";
    //NSString *requestString = @"http://bookapi.bignerdranch.com/courses.json";
    //NSString *requestString = @"http://iviewsource.com/api/get_posts/";

    NSURL *url = [NSURL URLWithString:requestString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    
        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        self.developers = jsonData[@"developers"];
        
        NSLog(@"%@", self.developers);
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
        
    }];
        
    
    [dataTask resume];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.developers count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDictionary *developer = self.developers[indexPath.row];
    cell.textLabel.text = developer[@"fullname"];
    
    NSLog(@"%@", developer[@"fullname"]);
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"detail" sender:self];
}

@end
