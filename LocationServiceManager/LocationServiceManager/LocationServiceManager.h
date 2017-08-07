//
//  LocationServiceManager.h
//  LocationServiceManager
//
//  Created by YouXianMing on 2017/8/7.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@class LocationServiceManager;

// http://www.gpsspg.com/maps.htm
// https://github.com/TinyQ/TQLocationConverter

@protocol LocationServiceManagerDelegate <NSObject>

@optional

- (void)locationServiceManager:(LocationServiceManager *)manager didUpdateLocations:(NSArray <CLLocation *> *)locations;

- (void)locationServiceManager:(LocationServiceManager *)manager didUpdateLocationsFailedWithError:(NSError *)error;

@end

@interface LocationServiceManager : NSObject

/**
 *  The delegate.
 */
@property (nonatomic, weak) id <LocationServiceManagerDelegate> delegate;

/**
 *  Start the location service.
 */
- (void)start;

/**
 *  The last update location (WGS1984).
 */
@property (nonatomic, strong, readonly) CLLocation *lastUpdateLocation;

/**
 *  Submits a reverse-geocoding request for the specified location.
 *
 *  @param location          CLLocation object.
 *  @param completionHandler CLGeocodeCompletionHandler block.
 */
- (void)reverseGeocodeLocation:(CLLocation *)location completionHandler:(CLGeocodeCompletionHandler)completionHandler;

/**
 *  Submits a reverse-geocoding request for the specified location.
 *
 *  @param coordinate        CLLocationCoordinate2D value.
 *  @param completionHandler CLGeocodeCompletionHandler block.
 */
- (void)reverseGeocodeLocationCoordinate2D:(CLLocationCoordinate2D)coordinate completionHandler:(CLGeocodeCompletionHandler)completionHandler;

/**
 *  Submits a forward-geocoding request using the specified string.
 *
 *  @param addressString     Address string.
 *  @param completionHandler CLGeocodeCompletionHandler block.
 */
- (void)geocodeAddressString:(NSString *)addressString completionHandler:(CLGeocodeCompletionHandler)completionHandler;

#pragma mark - Constructor & Class method.

+ (instancetype)locationServiceManagerWithDelegate:(id <LocationServiceManagerDelegate>)delegate;

+ (CLLocationDistance)distanceBetweenCoordinateA:(CLLocationCoordinate2D)coordinateA coordinateB:(CLLocationCoordinate2D)coordinateB;

@end
