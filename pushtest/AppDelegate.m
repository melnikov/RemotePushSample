//
//  AppDelegate.m
//  pushtest
//
//  Created by Alexei Melnikov on 8/19/12.
//  Copyright (c) 2012 Stex Group LLC. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    //let's go ahead and try to register
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound];
    
    
    NSString * userName = [[[[launchOptions valueForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"] valueForKey:@"aps"] valueForKey:@"alert"] valueForKey:@"user"];
    
    [[[[UIAlertView alloc] initWithTitle:@"Приглашение в игру" message:[NSString stringWithFormat:@"Пользователь %@ приглашает Вас поиграть в iMafia",userName] delegate:nil cancelButtonTitle:@"Отказаться" otherButtonTitles:@"Играть!", nil]autorelease]show];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -
#pragma mark Remote Notifications

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSLog(@"Received Token: %@",deviceToken);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSLog(@"Received Remote Notification %@",userInfo);
    
    NSString * userName = [[[userInfo valueForKey:@"aps"] valueForKey:@"alert"] valueForKey:@"user"];
    
    [[[[UIAlertView alloc] initWithTitle:@"Приглашение в игру" message:[NSString stringWithFormat:@"Пользователь %@ приглашает Вас поиграть в iMafia",userName] delegate:nil cancelButtonTitle:@"Отказаться" otherButtonTitles:@"Играть!", nil]autorelease]show];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"Error registering for token. Error was: %@",error);
}

@end
