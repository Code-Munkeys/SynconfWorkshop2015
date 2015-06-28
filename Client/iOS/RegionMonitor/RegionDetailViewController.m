//
//  RegionDetailViewController.m
//  RegionMonitor
//
//  Created by SpargoDev on 6/28/15.
//  Copyright (c) 2015 CodeMunkeys. All rights reserved.
//

#import "RegionDetailViewController.h"

@interface RegionDetailViewController ()

@end

@implementation RegionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateViewForBeacon:)
                                                 name:@"DataLoaded"
                                               object:nil];
    
    self.regionLabel.text = self.region.identifier;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewForBeacon: (NSNotification*) n {
    
    CLBeacon* beacon = [n.userInfo objectForKey:@"beacon"];
    CLBeaconRegion* loadedBeacon = (CLBeaconRegion*) self.region;
    
    if ([beacon.proximityUUID.UUIDString isEqualToString: loadedBeacon.proximityUUID.UUIDString]
        && [beacon.major intValue] == [loadedBeacon.major intValue]
        && [beacon.minor intValue] == [loadedBeacon.minor intValue])
    {
     
        int proxValue = beacon.proximity;
        NSString* proxDescription = @"Unknown";
        if (proxValue == 0)
        {
            proxDescription = @"Unknown";
            [self.view setBackgroundColor:[UIColor whiteColor]];
        }
        if (proxValue == 1)
        {
            proxDescription = @"Immediate";
            [self.view setBackgroundColor:[UIColor greenColor]];
        }
        if (proxValue == 2)
        {
            proxDescription = @"Near";
            [self.view setBackgroundColor:[UIColor yellowColor]];
        }
        if (proxValue == 3)
        {
            proxDescription = @"Far";
            [self.view setBackgroundColor:[UIColor orangeColor]];
        }
        
        self.proximityLabel.text = [NSString stringWithFormat: @"Proximity: %@", proxDescription];
        self.accuracyLabel.text = [NSString stringWithFormat: @"Accuracy: %f", beacon.accuracy];
    }
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
