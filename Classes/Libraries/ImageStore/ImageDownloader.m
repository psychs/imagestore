// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the new BSD license.

#import "ImageDownloader.h"


@implementation ImageDownloader

@synthesize image;
@synthesize url;

- (id)init
{
	self = [super init];
	if (self) {
	}
	return self;
}

- (id)initWithDelegate:(id)aDelegate;
{
	if ([self init]) {
		delegate = aDelegate;
	}
	return self;
}

- (void)dealloc
{
	[url release];
	[image release];
	conn.delegate = nil;
	[conn cancel];
	[conn release];
	[super dealloc];
}

- (void)cancel
{
	conn.delegate = nil;
	[conn cancel];
	[conn release];
	conn = nil;
}

- (void)start:(NSString*)anUrl
{
	[self cancel];
	
	[image release];
	image = nil;

	[url autorelease];
	url = [anUrl retain];
	
	conn = [[HttpClient alloc] initWithDelegate:self];
	[conn get:url parameters:nil];
}

+ (ImageDownloader*)imageDownloaderWithDelegate:(id)aDelegate url:(NSString*)url
{
	ImageDownloader* d = [[[ImageDownloader alloc] initWithDelegate:aDelegate] autorelease];
	[d start:url];
	return d;
}

- (void)httpClientSucceeded:(HttpClient*)sender response:(NSHTTPURLResponse*)response data:(NSData*)data
{
	[conn autorelease];
	conn = nil;
	
	int statusCode = [response statusCode];
	if (statusCode == 200 && data.length) {
		image = [[UIImage alloc] initWithData:data];
		
		if ([delegate respondsToSelector:@selector(imageDownloaderDidSucceed:)]) {
			[delegate imageDownloaderDidSucceed:self];
		}
	}
	else {
		if ([delegate respondsToSelector:@selector(imageDownloaderDidFail:error:statusCode:)]) {
			[delegate imageDownloaderDidFail:self error:nil statusCode:statusCode];
		}
	}
}

- (void)httpClientFailed:(HttpClient*)sender error:(NSError*)error
{
	[conn autorelease];
	conn = nil;
	
	if ([delegate respondsToSelector:@selector(imageDownloaderDidFail:error:statusCode:)]) {
		[delegate imageDownloaderDidFail:self error:error statusCode:0];
	}
}

@end
