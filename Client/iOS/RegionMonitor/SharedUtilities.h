//
//  SharedUtilities.h
//  RegionMonitor
//
//  Created by CodeMunkeys on 6/28/15.
//  Copyright (c) 2015 CodeMunkeys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@import CoreLocation;

@interface SharedUtilities : NSObject

+ (NSArray*)getHardCodedBeacons;
+ (CLBeaconRegion *)beaconRegionWithItem:(NSDictionary *)item;
+ (void)sendSimpleNotification:(NSString*) msg;

@end
