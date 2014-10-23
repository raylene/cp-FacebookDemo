//
//  SettingsViewController.m
//  
//
//  Created by Raylene Yung on 10/22/14.
//
//

#import "SettingsViewController.h"
#import "SettingCell.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *settingsTableView;
@property NSInteger selectedSettingIndex;

- (void)onCloseButton;
- (void)onApplyButton;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(onCloseButton)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(onApplyButton)];
    
    self.settingsTableView.delegate = self;
    self.settingsTableView.dataSource = self;
    
    [self.settingsTableView registerNib:[UINib nibWithNibName:@"SettingCell" bundle:nil] forCellReuseIdentifier:@"SettingCell"];
    self.settingsTableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)onCloseButton {
    NSLog(@"onCloseButton");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onApplyButton {
    NSLog(@"onApplyButton");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingCell"];
    
    if (indexPath.row == 0) {
        cell.settingNameLabel.text = @"Home Feed";
    } else if (indexPath.row == 1) {
        cell.settingNameLabel.text = @"Movies";
    } else if (indexPath.row == 2) {
        cell.settingNameLabel.text = @"Photos";
    } else if (indexPath.row == 3) {
        cell.settingNameLabel.text = @"Books";
    }

    cell.delegate = self;
    cell.settingSwitch.selected = (indexPath.row == self.selectedSettingIndex);
    NSLog(@"%d", indexPath.row == self.selectedSettingIndex);
    return cell;
}

- (void)didChangeSwitch:(SettingCell *)settingCell {
    NSLog(@"didChangeSwitch");
    self.selectedSettingIndex = [self.settingsTableView indexPathForCell:settingCell].row;
    [self.settingsTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
