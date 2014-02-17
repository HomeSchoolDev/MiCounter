//
//  MiCounterAppDelegate.m
//  MiCounter
//
//  Created by Derek on 6/22/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "MiCounterAppDelegate.h"
#import "MiCounterViewController.h"

@implementation MiCounterAppDelegate

@synthesize window;
@synthesize viewController;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
	
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
	

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
	
	
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
	
}


- (void)applicationWillTerminate:(UIApplication *)application {

}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
