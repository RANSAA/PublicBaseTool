//
//  TKLocationlocator.m
//  ExampleProject
//
//  Created by kimi on 2023/10/13.
//

#import "TKLocationlocator.h"
#import <CoreLocation/CoreLocation.h>


@implementation TKLocationlocator

//MARK- Block回调
- (void)returnAddress:(NSString *)addr
{
    if(self.blockAddress){
        self.blockAddress(addr);
    }
}

- (void)returnLocation:(CLLocation *)location
{
    if(self.blockLocation){
        self.blockLocation(location);
    }
}


//MARK: - 地址编码
/**
 *  地址编码（从地址到坐标）PS: 获取第一个地址编码的坐标信息
 *
 **/
- (void)geocodeAddress:(NSString *)address
{
    TKLog(@"address:%@",address);
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    __weak typeof(self) weakSelf = self;
    [geocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> *placemarks, NSError *error) {
        if (error) {
            TKLog(@"TKLocationlocator:Geocoding failed: %@", [error localizedDescription]);
            [weakSelf returnLocation:nil];
            return;
        }
        
        if (placemarks && [placemarks count] > 0) {
            CLPlacemark *placemark = [placemarks firstObject];
            CLLocation *location = placemark.location;
            TKLog(@"TKLocationlocator:Latitude: %f, Longitude: %f", location.coordinate.latitude, location.coordinate.longitude);
            [weakSelf returnLocation:location];
        }else{
            TKLog(@"TKLocationlocator:地址编码没有得到有效的坐标信息！");
            [weakSelf returnLocation:nil];
        }
    }];
}


/**
 *  反地址编码（从坐标到地址）
 **/
- (void)reverseGeocodeLocation:(CLLocation *)location
{
    __weak typeof(self) weakSelf = self;
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> *placemarks, NSError *error) {
        if (error) {
            TKLog(@"TKLocationlocator:Reverse geocoding failed: %@", [error localizedDescription]);
            [weakSelf returnAddress:nil];
            return;
        }
        
        if (placemarks && [placemarks count] > 0) {
            CLPlacemark *placemark = [placemarks firstObject];
            TKLog(@"placemarks count:%ld",placemarks.count);
            
            TKLog(@"placemark:%@",placemark.name);
            TKLog(@"placemark:%@",placemark.thoroughfare);
            TKLog(@"placemark:%@",placemark.subThoroughfare);
            TKLog(@"placemark:%@",placemark.locality);
            TKLog(@"placemark:%@",placemark.subLocality);
            TKLog(@"placemark:%@",placemark.administrativeArea);
            TKLog(@"placemark:%@",placemark.subAdministrativeArea);
            TKLog(@"placemark:%@",placemark.postalCode);
            TKLog(@"placemark:%@",placemark.ISOcountryCode);
            TKLog(@"placemark:%@",placemark.country);
            TKLog(@"placemark:%@",placemark.inlandWater);
            TKLog(@"placemark:%@",placemark.ocean);
            TKLog(@"placemark:%@",placemark.areasOfInterest);
            
            
            NSString *address = [NSString stringWithFormat:@"%@%@%@%@%@",placemark.country,placemark.administrativeArea,placemark.locality,placemark.subLocality,placemark.thoroughfare];
            TKLog(@"TKLocationlocator:Decoded address: %@", address);
            
            [weakSelf returnAddress:address];
        }else{
            TKLog(@"TKLocationlocator:反地址编码没有得到有效的地址信息！");
            [weakSelf returnAddress:nil];
        }
    }];
}



//MARK: - 定位






- (void)dealloc
{
    NSLog(@"dealloc class:%@",self.class);
}

@end
