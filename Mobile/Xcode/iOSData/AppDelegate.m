 /*
 AppDelegate.m
 iToDo
 
 Developed by Franz Ayestaran on 10/2/14.
 Copyright (c) 2022 Zonk Technology. All rights reserved.
 
 You may use this code in your own projects and upon doing so, you the programmer are solely
 responsible for determining it's worthiness for any given application or task. Here clearly
 states that the code is for learning purposes only and is not guaranteed to conform to any
 programming style, standard, or be an adequate answer for any given problem.
 */

#import "AppDelegate.h"

@implementation AppDelegate
NSString *glbUuid;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
   
    if ([Filesystem readFromFile:@"uuid.txt"] == nil)
    {
        glbUuid = [[NSUUID UUID] UUIDString];
        [Filesystem writeToFile:glbUuid Filename:@"uuid.txt"];
    }
    else
    {
        glbUuid = [Filesystem readFromFile:@"uuid.txt"];
    }
    
    NSLog(@"UUID: %@",glbUuid);
    
    // Add app details to userAgent
    
    // Create a web view for the express purpose of getting the user agent.
    UIWebView *tempWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSString *userAgent = [tempWebView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    
    // Get the native app version and append it to user agent.
    NSString *AppBuild = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    NSString * AppVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
    userAgent = [userAgent stringByAppendingString: [NSString stringWithFormat:@"; %@ Version %@ Build %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"], AppVersion, AppBuild]];
    
    // Store the full user agent in NSUserDefaults to be used by real web view.
    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:userAgent, @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
    
    NSLog(@"UserAgent: %@",userAgent);
    //-----------------------------
    
    sleep(3);
    
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

@end
