// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the new BSD license.

#import "AppDelegate.h"
#import "RootViewController.h"


@implementation AppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize root;

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    [window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
    [root refresh:nil];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

- (void)dealloc
{
    [navigationController release];
    [window release];
    [root release];
    [super dealloc];
}

@end
