// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the new BSD license.

#import "TimelineDownloader.h"
#import "JSON.h"
#import "Status.h"


@implementation TimelineDownloader

- (id)initWithDelegate:(id)aDelegate
{
	if (self = [super init]) {
		delegate = aDelegate;
	}
	return self;
}

- (void)dealloc
{
	[conn cancel];
	[conn autorelease];
	[super dealloc];
}

- (BOOL)isActive
{
	return conn != nil;
}

- (void)get
{
	[conn autorelease];
	
	NSString* url = @"http://twitter.com/statuses/public_timeline.json";
	
	conn = [[HttpClient alloc] initWithDelegate:self];
	[conn get:url parameters:nil];
}

- (void)httpClientSucceeded:(HttpClient*)sender response:(NSHTTPURLResponse*)response data:(NSData*)data
{
	NSString* s = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	NSArray* ary = [s JSONValue];
	NSMutableArray* statuses = [NSMutableArray array];
	
	if (ary) {
		for (int i=[ary count]-1; i>=0; i--) {
			Status* m = [Status statusWithDictionary:[ary objectAtIndex:i]];
			[statuses addObject:m];
		}
	}
	
	[conn autorelease];
	conn = nil;
	
	if ([delegate respondsToSelector:@selector(timelineDownloaderDidSucceed:statuses:)]) {
		[delegate timelineDownloaderDidSucceed:self statuses:statuses];
	}
}

- (void)httpClientFailed:(HttpClient*)sender error:(NSError*)error
{
	[conn autorelease];
	conn = nil;
	
	if ([delegate respondsToSelector:@selector(timelineDownloaderDidFail:error:)]) {
		[delegate timelineDownloaderDidFail:self error:error];
	}
}

@end
