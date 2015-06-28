//
//  RegionDetailViewController.h
//  RegionMonitor
//
//  Created by SpargoDev on 6/28/15.
//  Copyright (c) 2015 CodeMunkeys. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreLocation;

@interface RegionDetailViewController : UIViewController

@property (strong, nonatomic) CLRegion *region;
@property (strong, nonatomic) IBOutlet UILabel *regionLabel;
@property (strong, nonatomic) IBOutlet UILabel *proximityLabel;
@property (strong, nonatomic) IBOutlet UILabel *accuracyLabel;

@end
