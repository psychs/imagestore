// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the new BSD license.

#import <UIKit/UIKit.h>
#import "TimelineDownloader.h"

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
