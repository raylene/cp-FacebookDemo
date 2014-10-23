//
//  MainViewController.m
//  FacebookDemo
//
//  Created by Timothy Lee on 10/22/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

#import "MainViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "NodeCell.h"
#import "SettingsViewController.h"

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>

@property NSArray *data;
- (void)reload;
- (void)onSettingsButton;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self reload];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.feedTableView.delegate = self;
    self.feedTableView.dataSource = self;
    
    [self.feedTableView registerNib:[UINib nibWithNibName:@"NodeCell" bundle:nil] forCellReuseIdentifier:@"NodeCell"];
    self.feedTableView.rowHeight = UITableViewAutomaticDimension;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
}

- (void)onSettingsButton {
    SettingsViewController *vc = [[SettingsViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    nvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:nvc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NodeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NodeCell"];
    
    NSDictionary *node = self.data[indexPath.row];

//    NSLog(@"result: %@", node[@"from"]);

    
    cell.usernameLabel.text = [node valueForKeyPath:@"from.name"];
    cell.nodeNameLabel.text = node[@"message"];
    cell.typeLabel.text = node[@"type"];
    cell.statusTypeLabel.text = node[@"status_type"];
    
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Private methods

- (void)reload {
    [FBRequestConnection startWithGraphPath:@"/me/home"
                                 parameters:nil
                                 HTTPMethod:@"GET"
                          completionHandler:^(
                                              FBRequestConnection *connection,
                                              id result,
                                              NSError *error
                                              ) {
                              /* handle the result */
                              self.data = result[@"data"];
                              
                              [self.feedTableView reloadData];
                          }];
}

@end
