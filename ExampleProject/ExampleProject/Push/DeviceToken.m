//
//  DeviceToken.m
//  ExampleProject
//
//  Created by PC on 2022/8/4.
//

#import "DeviceToken.h"

@implementation DeviceToken

//推送注册设备token获取方法 - AppDelegate
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken API_AVAILABLE(ios(3.0))
{

}

/**
 将推送设备token转换成字符串
 */
- (NSString *)getDeviceTokenStringWith:(NSData *)deviceToken
{
    NSMutableString *deviceTokenString = [NSMutableString string];
    const char *bytes = deviceToken.bytes;
    NSInteger count = deviceToken.length;
    for (int i = 0; i < count; i++) {
        [deviceTokenString appendFormat:@"%02x", bytes[i]&0x000000FF];
    }
    return deviceTokenString;

    /**
     //友盟提供的方式：
     if (![deviceToken isKindOfClass:[NSData class]]) return;
     const unsigned *tokenBytes = [deviceToken bytes];
     NSString *hexToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                           ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                           ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                           ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
     NSLog(@"deviceToken:%@",hexToken);
     */
}

@end
