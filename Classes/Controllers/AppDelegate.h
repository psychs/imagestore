// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the new BSD license.

#import <UIKit/UIKit.h>
#import "RootViewController.h"


@interface AppDelegate : NSObject <UIApplicationDelegate>
{
	UIWindow* window;
	UINavigationController* navigationController;
	RootViewController* root;
}

@property (nonatomic, retain) IBOutlet UIWindow* window;
@property (nonatomic, retain) IBOutlet UINavigationController* navigationController;
@property (nonatomic, retain) IBOutlet RootViewController* root;

@end

