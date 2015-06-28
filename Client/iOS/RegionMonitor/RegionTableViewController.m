//
//  RegionTableViewController.m
//  RegionMonitor
//
//  Created by CodeMunkeys on 6/28/15.
//  Copyright (c) 2015 CodeMunkeys. All rights reserved.
//

#import "RegionTableViewController.h"
#import "SharedUtilities.h"
#import "LocationSingletonManager.h"
#import "RegionDetailViewController.h"

@interface RegionTableViewController ()

@end

@implementation RegionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.regionArray = [[NSMutableArray alloc] init];
    NSArray* beacons = [SharedUtilities getHardCodedBeacons];
    for (NSDictionary* dict in beacons)
    {
        CLBeaconRegion* beacon = [SharedUtilities beaconRegionWithItem:dict];
        NSArray *regions = [[[[LocationSingletonManager sharedLocManager] locManager] monitoredRegions] allObjects];
        
        BOOL alreadyMonitoring = NO;
        for (int i = 0; i < [regions count]; i++) {
            CLRegion *monitordRegion = [regions objectAtIndex:i];
            if ([monitordRegion isEqual: (CLRegion*)beacon])
            {
                alreadyMonitoring = YES;
                [[[LocationSingletonManager sharedLocManager] locManager] requestStateForRegion:monitordRegion];
            }
        }
        if (!alreadyMonitoring)
            [[[LocationSingletonManager sharedLocManager] locManager] startMonitoringForRegion:beacon];

        [self.regionArray addObject:beacon];
    }
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.regionArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"customCell" forIndexPath:indexPath];
    
    CLRegion* reg = [self.regionArray objectAtIndex:indexPath.row];
    
    // Configure the cell...
    cell.textLabel.text =reg.identifier;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    RegionDetailViewController* vc = [segue destinationViewController];
    NSIndexPath* index = [self.tableView indexPathForSelectedRow];
    vc.region = [self.regionArray objectAtIndex:index.row];
}


@end
