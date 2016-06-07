//
//  AppDelegate.m
//  WakeMDiPad
//
//  Created by NCPL Inc on 31/05/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import "AppDelegate.h"
#import <AWSCore/AWSCore.h>
#import <AWSS3/AWSS3.h>
#import <AWSCognito/AWSCognito.h>
#import <AWSDynamoDB/AWSDynamoDB.h>

#define IDIOM UI_USER_INTERFACE_IDIOM()
#define IPAD UIUserInterfaceIdiomPad
#define IPHONE UIUserInterfaceIdiomPhone

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    
    UIStoryboard *storyboard;
    UIViewController *controller = [[UIViewController alloc]init];
    CGSize iOSScreenSize=[[UIScreen mainScreen]bounds].size;
    
    if ( IDIOM == IPAD )
        
    {
        /* do something specifically for iPad. */
        //        [NSThread sleepForTimeInterval:5];
        //        storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        if (iOSScreenSize.width==1024) //7.9 inch
        {
            [NSThread sleepForTimeInterval:5];
            storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        }
        
        
        if(iOSScreenSize.width==1366)//12.7 inch
        {
            [NSThread sleepForTimeInterval:5];
            storyboard=[UIStoryboard storyboardWithName:@"iPad 12.9 inchPro" bundle:nil];
        }
        
        
        
        
    }

    
    AWSCognitoCredentialsProvider *credentialsProvider = [[AWSCognitoCredentialsProvider alloc]
                                                          initWithRegionType:AWSRegionUSEast1
                                                          identityPoolId:@"us-east-1:6d36ce3d-0554-49a3-83c6-73d81580f45a"];
    
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUSWest2 credentialsProvider:credentialsProvider];
    
    [AWSS3TransferManager registerS3TransferManagerWithConfiguration:configuration forKey:@"USWest2S3TransferManager"];
    [AWSServiceManager defaultServiceManager].defaultServiceConfiguration = configuration;
    
    //AWSDynamoDB *dynamoDB = [AWSDynamoDB defaultDynamoDB];
    [AWSLogger defaultLogger].logLevel = AWSLogLevelVerbose;
    
    controller=[storyboard instantiateInitialViewController];
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    // self.window.rootViewController=controller;
    [self.window setRootViewController:controller];
    [self.window makeKeyAndVisible];
    return storyboard;
    //return YES;
}

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
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
