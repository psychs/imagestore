// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the new BSD license.

#import "TimelineDownloader.h"
#import "JSON.h"
#import "Message.h"

@interface NSObject (TimelineDownloaderDelegate)
- (void)timelineDownloaderDidSucceed:(TimelineDownloader*)sender messages:(NSArray*)messages;
- (void)timelineDownloaderDidFail:(TimelineDownloader*)sender error:(NSError*)error;
@end

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
	[conn release];
	[buf release];
	[super dealloc];
}

- (BOOL)isActive
{
	return conn != nil;
}

- (void)get
{
	[conn autorelease];
	[buf autorelease];

	NSString* url = @"http://twitter.com/statuses/public_timeline.json";
	NSURLRequest* req = [NSURLRequest requestWithURL:[NSURL URLWithString:url]
														cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
														timeoutInterval:60.0];
	conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
	buf = [NSMutableData new];
}

- (void)connection:(NSURLConnection *)aConn didReceiveResponse:(NSURLResponse *)response
{
	// should retain response
}

- (void)connection:(NSURLConnection *)aConn didReceiveData:(NSData *)data
{
	[buf appendData:data];
}

- (void)connection:(NSURLConnection *)aConn didFailWithError:(NSError *)error
{
	[conn autorelease];
	[buf autorelease];
	conn = nil;
	buf = nil;
	
	if ([delegate respondsToSelector:@selector(timelineDownloaderDidFail:error:)]) {
		[delegate timelineDownloaderDidFail:self error:error];
	}
}

- (void)connectionDidFinishLoading:(NSURLConnection *)aConn
{
	NSString* s = [[[NSString alloc] initWithData:buf encoding:NSUTF8StringEncoding] autorelease];
	NSArray* ary = [s JSONValue];
	NSMutableArray* messages = [NSMutableArray array];
	
	if (ary) {
		for (int i=[ary count]-1; i>=0; i--) {
			Message* m = [Message messageWithDictionary:[ary objectAtIndex:i]];
			[messages addObject:m];
		}
	}

	[conn autorelease];
	[buf autorelease];
	conn = nil;
	buf = nil;
	
	if ([delegate respondsToSelector:@selector(timelineDownloaderDidSucceed:messages:)]) {
		[delegate timelineDownloaderDidSucceed:self messages:messages];
	}
}

@end
