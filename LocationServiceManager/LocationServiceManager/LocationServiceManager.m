//
//  LocationServiceManager.m
//  LocationServiceManager
//
//  Created by YouXianMing on 2017/8/7.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "LocationServiceManager.h"

@interface LocationServiceManager () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLGeocoder        *geocoder;
@property (nonatomic, strong) CLLocation        *lastUpdateLocation;
@property (nonatomic) CLLocationCoordinate2D     lastUpdateCoordinate;

@end

@implementation LocationServiceManager

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.locationManager                 = [[CLLocationManager alloc] init];
        self.geocoder                        = [CLGeocoder new];
        self.locationManager.distanceFilter  = 10.f;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.delegate        = self;
    }
    
    return self;
}

- (void)start {
    
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];
}

- (void)reverseGeocodeLocation:(CLLocation *)location completionHandler:(CLGeocodeCompletionHandler)completionHandler {
    
    [self.geocoder reverseGeocodeLocation:location completionHandler:completionHandler];
}

- (void)reverseGeocodeLocationCoordinate2D:(CLLocationCoordinate2D)coordinate completionHandler:(CLGeocodeCompletionHandler)completionHandler {
    
    [self.geocoder reverseGeocodeLocation:[[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude]
                        completionHandler:completionHandler];
}

- (void)geocodeAddressString:(NSString *)addressString completionHandler:(CLGeocodeCompletionHandler)completionHandler {
    
    [self.geocoder geocodeAddressString:addressString completionHandler:completionHandler];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray <CLLocation *> *)locations {
    
    [manager stopUpdatingLocation];
    
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
    
    [self performSelector:@selector(didUpdateLocationsEventWithValue:)
               withObject:@{@"sucess"    : @(YES),
                            @"locations" : locations,
                            @"errorInfo" : @""}
               afterDelay:0.2f];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
    
    [self performSelector:@selector(didUpdateLocationsEventWithValue:)
               withObject:@{@"sucess"    : @(NO),
                            @"locations" : @"",
                            @"errorInfo" : error}
               afterDelay:0.2f];
}

#pragma mark - Result

- (void)didUpdateLocationsEventWithValue:(id)value {
    
    NSDictionary *data = value;
    
    if ([data[@"sucess"] boolValue] == YES) {
        
        NSArray <CLLocation *> *locations = data[@"locations"];
        self.lastUpdateLocation           = locations.lastObject;
        self.lastUpdateCoordinate         = locations.lastObject.coordinate;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(locationServiceManager:didUpdateLocations:)]) {
            
            [self.delegate locationServiceManager:self didUpdateLocations:locations];
        }
        
    } else {
        
        NSError *errorInfo = data[@"errorInfo"];
        if (self.delegate && [self.delegate respondsToSelector:@selector(locationServiceManager:didUpdateLocationsFailedWithError:)]) {
            
            [self.delegate locationServiceManager:self didUpdateLocationsFailedWithError:errorInfo];
        }
    }
}

#pragma mark - Constructor & Class method.

+ (instancetype)locationServiceManagerWithDelegate:(id <LocationServiceManagerDelegate>)delegate {
    
    LocationServiceManager *manager = [LocationServiceManager new];
    manager.delegate                = delegate;
    
    return manager;
}

+ (CLLocationDistance)distanceBetweenCoordinateA:(CLLocationCoordinate2D)coordinateA coordinateB:(CLLocationCoordinate2D)coordinateB {
    
    CLLocation *curLocation   = [[CLLocation alloc] initWithLatitude:coordinateA.latitude longitude:coordinateA.longitude];
    CLLocation *otherLocation = [[CLLocation alloc] initWithLatitude:coordinateB.latitude longitude:coordinateB.longitude];
    
    return [curLocation distanceFromLocation:otherLocation];
}

@end
