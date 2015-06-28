//
//  LocationSingletonManager.m
//  RegionMonitor
//
//  Created by CodeMunkeys on 6/28/15.
//  Copyright (c) 2015 CodeMunkeys. All rights reserved.
//

#import "LocationSingletonManager.h"
#import "SharedUtilities.h"

@implementation LocationSingletonManager

static LocationSingletonManager *sharedLocManager = nil;    // static instance variable

+ (LocationSingletonManager *)sharedLocManager {
    if (sharedLocManager == nil) {
        sharedLocManager = [[self alloc] init];
    }
    return sharedLocManager;
}

- (id)init {
    if ( (self = [super init]) ) {
        // your custom initialization
    }
    return self;
}

- (void)setupLocationManager {
    self.locManager = [[CLLocationManager alloc] init];
    self.locManager.pausesLocationUpdatesAutomatically = NO;
    self.locManager.delegate = self;
    self.locManager.distanceFilter = 20;
    self.locManager.activityType = CLActivityTypeFitness;
    
    if([self.locManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locManager requestAlwaysAuthorization];
    }
    
    if ([CLLocationManager locationServicesEnabled])
    {
        [self.locManager startUpdatingLocation];
    }
}

#pragma mark - Location Manager Delegate events

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    NSString* msg = [NSString stringWithFormat:@"Did enter region for region with ID: %@", region.identifier];
    [SharedUtilities sendSimpleNotification:msg];
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    
    NSString* msg = [NSString stringWithFormat:@"Did exit region for region with ID: %@", region.identifier];
    [SharedUtilities sendSimpleNotification:msg];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation* loc = [locations lastObject];
    NSLog(@"%@", loc);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Location manager failed: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons
               inRegion:(CLBeaconRegion *)region
{
    for (CLBeacon *beacon in beacons) {
        
        NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:beacon, @"beacon", nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DataLoaded" object:self userInfo:dict];
        
        NSLog(@"Did range beacon: %@", beacon);
        //if ([item isEqualToCLBeacon:beacon]) {
        //item.lastSeenBeacon = beacon;
        //}
    }
}

- (void)locationManager:(CLLocationManager *)manager
      didDetermineState:(CLRegionState)state
              forRegion:(CLRegion *)region
{
    if ([region isKindOfClass:[CLBeaconRegion class]]) {
        if(state == CLRegionStateUnknown)
        {
            NSLog(@"State for CLRegion is unknown");
        }
        if(state == CLRegionStateInside)
        {
            NSLog(@"State for CLRegion is inside");
            [self.locManager startRangingBeaconsInRegion:(CLBeaconRegion*)region];
        }
        if(state == CLRegionStateOutside)
        {
            NSLog(@"State for CLRegion is outside");
            [self.locManager stopRangingBeaconsInRegion:(CLBeaconRegion*)region];
        }
    }
}

@end
