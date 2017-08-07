//
//  ViewController.m
//  LocationServiceManager
//
//  Created by YouXianMing on 2017/8/7.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "ViewController.h"
#import "LocationServiceManager.h"
#import "TQLocationConverter.h"

@interface ViewController () <LocationServiceManagerDelegate>

@property (nonatomic, strong) LocationServiceManager *manager;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.manager = [LocationServiceManager locationServiceManagerWithDelegate:self];
    [self.manager start];
}

- (CLLocationDistance)distanceBetweenCoordinateA:(CLLocationCoordinate2D)coordinateA CoordinateB:(CLLocationCoordinate2D)coordinateB {
    
    CLLocation *curLocation   = [[CLLocation alloc] initWithLatitude:coordinateA.latitude longitude:coordinateA.longitude];
    CLLocation *otherLocation = [[CLLocation alloc] initWithLatitude:coordinateB.latitude longitude:coordinateB.longitude];
    
    return [curLocation distanceFromLocation:otherLocation];
}

- (void)locationServiceManager:(LocationServiceManager *)manager didUpdateLocations:(NSArray <CLLocation *> *)locations {
    
    CLLocationCoordinate2D coordinate_WGS1984 = manager.lastUpdateLocation.coordinate;
    CLLocationCoordinate2D coordinate_GCJ_02  = [TQLocationConverter transformFromWGSToGCJ:coordinate_WGS1984];
    CLLocationCoordinate2D coordinate_BD_09   = [TQLocationConverter transformFromGCJToBaidu:coordinate_GCJ_02];
    
    NSLog(@"WGS1984 (世界标准地理坐标)   lat:%f  lon:%f", coordinate_WGS1984.latitude, coordinate_WGS1984.longitude);
    NSLog(@"GCJ-02  (中国国测局地理坐标) lat:%f  lon:%f", coordinate_GCJ_02.latitude,  coordinate_GCJ_02.longitude);
    NSLog(@"BD-09   (百度地理坐标)      lat:%f  lon:%f", coordinate_BD_09.latitude,   coordinate_BD_09.longitude);
    
    // CLLocationCoordinate2DMake(39.9907054683, 116.3211367446) 是百度地图坐标点
    // http://www.gpsspg.com/maps.htm
    NSLog(@"%.2f米", [LocationServiceManager distanceBetweenCoordinateA:coordinate_BD_09 coordinateB:CLLocationCoordinate2DMake(39.9907054683, 116.3211367446)]);
    
    [manager reverseGeocodeLocationCoordinate2D:coordinate_GCJ_02
                              completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                                  
                                  [placemarks enumerateObjectsUsingBlock:^(CLPlacemark * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                      
                                      NSArray *array = obj.addressDictionary[@"FormattedAddressLines"];
                                      NSLog(@"%@", array.lastObject);
                                  }];
                              }];
}

- (void)locationServiceManager:(LocationServiceManager *)manager didUpdateLocationsFailedWithError:(NSError *)error {
    
    NSLog(@"%@", error);
}

@end
