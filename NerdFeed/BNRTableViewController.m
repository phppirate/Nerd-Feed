//
//  BNRTableViewController.m
//  NerdFeed
//
//  Created by Sam Podlogar on 5/14/14.
//  Copyright (c) 2014 Jeeble. All rights reserved.
//

#import "BNRTableViewController.h"
#import "BNRDetailTableViewController.h"

@interface BNRTableViewController ()

@end

@implementation BNRTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.navigationItem.title = [[NSUserDefaults standardUserDefaults] stringForKey:@"appTitle"];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        _session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
        
        [self fetchFeed];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    
    self.navigationItem.title = [[NSUserDefaults standardUserDefaults] stringForKey:@"appTitle"];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    _session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
    
    [self fetchFeed];
    
    [refresh addTarget:self action:@selector(relaodThisTableData) forControlEvents:UIControlEventValueChanged];

    self.refreshControl = refresh;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)relaodThisTableData{
    [self fetchFeed];
    [self.tableView reloadData];
    [self stopRefresh];
}
- (void)stopRefresh{
    [self.refreshControl endRefreshing];
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
        
        if (jsonData[@"developers"] != NULL) {
            [[NSUserDefaults standardUserDefaults] setObject:jsonData[@"developers"] forKey:@"developers"];
        }
        
        self.developers = [[NSUserDefaults standardUserDefaults] objectForKey:@"developers"];
        
        NSLog(@"%@", self.developers);
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
        
    }];
    
    
    [dataTask resume];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.developers count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDictionary *developer = self.developers[indexPath.row];
    cell.textLabel.text = developer[@"fullname"];
    
    NSLog(@"%@", developer[@"fullname"]);
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
        NSDictionary *dev = [self.developers objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        
        NSLog(@"%@", dev);
        
        [[NSUserDefaults standardUserDefaults] setObject:dev forKey:@"currentDeveloper"];
    
}


@end
