//
//  SharedUtilities.m
//  RegionMonitor
//
//  Created by CodeMunkeys on 6/28/15.
//  Copyright (c) 2015 CodeMunkeys. All rights reserved.
//

#import "SharedUtilities.h"

@implementation SharedUtilities

+ (NSArray*)getHardCodedBeacons
{
    //Hardcoded for testing
    NSArray *keys = [[NSArray alloc] initWithObjects: @"uuid", @"major", @"minor", @"regionName", @"userid", @"regionID", nil];
    NSArray *values = [[NSArray alloc] initWithObjects: @"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0", @"1", @"1", @"Code Munkey Beacon", @"codedmunkey@test.com", @"REG01", nil];
    NSDictionary* dict = [[NSDictionary alloc] initWithObjects: values forKeys:keys];
    
    NSArray *valuesSecond = [[NSArray alloc] initWithObjects: @"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0", @"0", @"1", @"Code Munkey Beacon 2", @"codedmunkey@test.com", @"REG02", nil];

    NSDictionary* dictSecond = [[NSDictionary alloc] initWithObjects: valuesSecond forKeys:keys];
    
    //CLBeaconRegion* beacon = [self beaconRegionWithItem:dict];
    NSArray *beacons = [[NSArray alloc] initWithObjects: dict, dictSecond, nil];
    
    return beacons;
}

+ (CLBeaconRegion *)beaconRegionWithItem:(NSDictionary *)item {
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:[item objectForKey:@"uuid"]];
    CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                           major:[[item objectForKey:@"major"] intValue]
                                                                           minor:[[item objectForKey:@"minor"] intValue]
                                                                      identifier:[item objectForKey:@"regionID"]];
    return beaconRegion;
}

+ (void)sendSimpleNotification:(NSString*) msg
{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = msg;
    notification.soundName = @"Default";
    //notification.userInfo = d;
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

@end
