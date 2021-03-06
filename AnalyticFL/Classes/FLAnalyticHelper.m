//
//  FLAnalyticHelper.m
//  Pods
//
//  Created by geekgy on 15/11/3.
//
//

#import "FLAnalyticHelper.h"
#import <CoreLocation/CoreLocation.h>
#import "IOSSystemUtil.h"
#import "Flurry.h"

@implementation FLAnalyticHelper

SINGLETON_DEFINITION(FLAnalyticHelper)

- (void)setAccoutInfo:(NSDictionary *)dict {
    NSString* userId = [dict objectForKey:@"userId"];
    NSString* gender = [dict objectForKey:@"gender"];
    NSString* age = [dict objectForKey:@"age"];
    if (userId != nil) {
        [Flurry setUserID:userId];
    }
    if (gender != nil) {
        if ([gender isEqualToString:@"male"]) {
            [Flurry setGender:@"m"];
        } else if ([gender isEqualToString:@"female"]) {
            [Flurry setGender:@"f"];
        }
    }
    if (age != nil) {
        [Flurry setAge:[age intValue]];
    }
}

- (void)onEvent:(NSString *)eventId {
    [Flurry logEvent:eventId];
}

- (void)onEvent:(NSString *)eventId Label:(NSString *)label {
    NSDictionary* userInfo = [NSDictionary dictionaryWithObject:label forKey:@"key"];
    [self onEvent:eventId eventData:userInfo];
}

- (void)onEvent:(NSString *)eventId eventData:(NSDictionary *)userInfo {
    [Flurry logEvent:eventId withParameters:userInfo];
}

- (void)setLevel:(int)level {
    [Flurry logEvent:@"level" withParameters:@{@"level":@(level)}];
}

- (void)charge:(NSString *)name :(double)cash :(double)coin :(int)type {
    NSDictionary* dict = @{@"name":name, @"cash":@(cash), @"coin":@(coin), @"type":@(type)};
    [Flurry logEvent:@"charge" withParameters:dict];
}

- (void)charge:(SKPaymentTransaction *)transaction {
    [Flurry logPaymentTransaction:transaction statusCallback:^(FlurryTransactionRecordStatus status) {
        NSLog(@"%d", status);
    }];
}

- (void)reward:(double)coin :(int)type {

}

- (void)purchase:(NSString *)name :(int)amount :(double)coin {

}

- (void)use:(NSString *)name :(int)amount :(double)coin {

}

- (void)missionStart:(NSString *)missionId {
    NSDictionary* dict = @{@"missionId":missionId};
    [Flurry logEvent:@"missionStart" withParameters:dict];
}

- (void)missionSuccess:(NSString *)missionId {
    NSDictionary* dict = @{@"missionId":missionId};
    [Flurry logEvent:@"missionSuccess" withParameters:dict];
}

- (void)missionFailed:(NSString *)missionId because:(NSString *)reason {
    NSDictionary* dict = @{@"missionId":missionId, @"reason":reason};
    [Flurry logEvent:@"missionFailed" withParameters:dict];
}

- (NSString *)getName {
    return @"Flurry";
}

#pragma mark - LifeCycleDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSString* flurryKey = [[IOSSystemUtil getInstance] getConfigValueWithKey:FLURRY_KEY];
    FlurrySessionBuilder *builder = [FlurrySessionBuilder new];
    [builder withCrashReporting:NO];
    [Flurry startSession:flurryKey withSessionBuilder:builder];
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    [locationManager startUpdatingLocation];
    CLLocation *location = locationManager.location;
    [Flurry setLatitude:location.coordinate.latitude
              longitude:location.coordinate.longitude
     horizontalAccuracy:location.horizontalAccuracy
       verticalAccuracy:location.verticalAccuracy];
    return YES;
}

@end
