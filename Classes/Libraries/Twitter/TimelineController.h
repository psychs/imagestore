// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the new BSD license.

#import <UIKit/UIKit.h>
#import "TimelineDownloader.h"
#import "Message.h"

@interface TimelineController : NSObject
{
	id delegate;
	NSMutableArray* messages;
	TimelineDownloader* conn;
}

@property (nonatomic, assign) IBOutlet id delegate;
@property (nonatomic, readonly) NSArray* messages;

- (void)update;

@end


@interface NSObject (TimelineControllerDelegate)
- (void)timelineControllerDidReceiveNewMessage:(TimelineController*)sender message:(Message*)message;
- (void)timelineControllerDidUpdate:(TimelineController*)sender;
@end
