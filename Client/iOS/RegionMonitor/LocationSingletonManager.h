//
//  LocationSingletonManager.h
//  RegionMonitor
//
//  Created by CodeMunkeys on 6/28/15.
//  Copyright (c) 2015 CodeMunkeys. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

@interface LocationSingletonManager : NSObject<CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locManager;

+ (LocationSingletonManager *) sharedLocManager;
- (void)setupLocationManager;

@end
