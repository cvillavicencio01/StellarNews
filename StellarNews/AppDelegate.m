//
//  AppDelegate.m
//  StellarNews
//
//  Created by Carlos Villavicencio on 04/11/15.
//  Copyright (c) 2015 MindsLab. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate




//AppDelegate
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

- (void) application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    //got the token
    
        //NSLog(@"%@",[deviceToken description] );
}

- (void) application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    //error when getting the token
    
    //NSLog(@"%@", error.description);
}


//cualquiera de estos tres recibe la notificacion del paid load

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    //Si no ha diso usado nunca preguntamos si quiere habilitar las notificaciones
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"fueUsado"] == false){
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"fueUsado"];
        [self enableNotifications];
    }
    
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if (userInfo) {
        //app was closes, received notification
    }
    
    /*
    NSDate *dte = [NSDate dateWithTimeIntervalSinceReferenceDate:[@"2457122.838301" doubleValue]];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"MM/dd/yyyy hh:mm:ss"];
    
    NSLog(@"Delta time is %@",[fmt stringFromDate:dte]);
    NSLog(@"Expiration: %.0f", [dte timeIntervalSince1970]);*/
    
    return YES;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //app was open, received notification when NOT using background modes
}


- (void) enableNotifications {
    //ask for permissions
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        

        
    }
    else {
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        //register to receive notifications
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
#pragma GCC diagnostic warning "-Wdeprecated-declarations"
    }
}





/*- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler
{
    //app was open, received notification when using background modes
}
*/











- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadJson" object:nil];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
