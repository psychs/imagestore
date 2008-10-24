// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the new BSD license.

#import <UIKit/UIKit.h>
#import "TimelineController.h"
#import "ImageStore.h"

@interface RootViewController : UITableViewController
{
	TimelineController* conn;
	ImageStore* imageStore;
}

- (IBAction)refresh:(id)sender;

@end
