// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the new BSD license.

#import "TimelineController.h"
#import "JSON.h"


@implementation TimelineController

@synthesize delegate;
@synthesize statuses;

- (id)init
{
	self = [super init];
	if (self) {
		statuses = [NSMutableArray new];
	}
	return self;
}

- (void)dealloc
{
	[statuses release];
	[conn release];
	[super dealloc];
}

- (void)update
{
	if (!conn) {
		[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
		
		conn = [[TimelineDownloader alloc] initWithDelegate:self];
		[conn get];
	}
}

- (void)timelineDownloaderDidSucceed:(TimelineDownloader*)sender statuses:(NSArray*)ary
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[conn autorelease];
	conn = nil;
	
	long long lastStatusId = 0;
	if (statuses.count > 0) {
		lastStatusId = ((Status*)[statuses lastObject]).statusId;
	}
	
	for (Status* m in ary) {
		if (m.statusId > lastStatusId) {
			[statuses addObject:m];
			
			if ([delegate respondsToSelector:@selector(timelineController:didReceiveStatus:)]) {
				[delegate timelineController:self didReceiveStatus:m];
			}
		}
	}
	
	if ([delegate respondsToSelector:@selector(timelineControllerDidUpdate:)]) {
		[delegate timelineControllerDidUpdate:self];
	}
}

- (void)timelineDownloaderDidFail:(TimelineDownloader*)sender error:(NSError*)error
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[conn autorelease];
	conn = nil;
	
	// should pop up an error dialog
}

@end
