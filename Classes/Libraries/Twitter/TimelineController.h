// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the new BSD license.

#import <UIKit/UIKit.h>
#import "TimelineDownloader.h"
#import "Status.h"


@interface TimelineController : NSObject
{
	id delegate;
	NSMutableArray* statuses;
	TimelineDownloader* conn;
}

@property (nonatomic, assign) IBOutlet id delegate;
@property (nonatomic, readonly) NSArray* statuses;

- (void)update;

@end


@interface NSObject (TimelineControllerDelegate)
- (void)timelineController:(TimelineController*)sender didReceiveStatus:(Status*)status;
- (void)timelineControllerDidUpdate:(TimelineController*)sender;
@end
