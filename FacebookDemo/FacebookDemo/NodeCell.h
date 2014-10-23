//
//  NodeCell.h
//  FacebookDemo
//
//  Created by Raylene Yung on 10/22/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NodeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nodeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusTypeLabel;

@end
