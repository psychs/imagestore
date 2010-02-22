// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the new BSD license.

#import "TimelineController.h"
#import "JSON.h"


@implementation TimelineController

@synthesize delegate;
@synthesize messages;

- (id)init
{
	if (self = [super init]) {
		messages = [NSMutableArray new];
	}
	return self;
}

- (void)dealloc
{
	[messages release];
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

- (void)timelineDownloaderDidSucceed:(TimelineDownloader*)sender messages:(NSArray*)ary
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[conn autorelease];
	conn = nil;
	
	long long lastMessageId = 0;
	if ([messages count] > 0) {
		lastMessageId = ((Message*)[messages lastObject]).messageId;
	}
	
	for (Message* m in ary) {
		if (m.messageId > lastMessageId) {
			[messages addObject:m];
			
			if ([delegate respondsToSelector:@selector(timelineControllerDidReceiveNewMessage:message:)]) {
				[delegate timelineControllerDidReceiveNewMessage:self message:m];
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
