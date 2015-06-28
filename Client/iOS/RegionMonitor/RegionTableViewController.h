//
//  RegionTableViewController.h
//  RegionMonitor
//
//  Created by CodeMunkeys on 6/28/15.
//  Copyright (c) 2015 CodeMunkeys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegionTableViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *regionArray;

@end
