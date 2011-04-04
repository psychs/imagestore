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
		;
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
	[conn release];
    
	[super dealloc];
}

- (void)start:(NSString*)anUrl
{
	[url autorelease];
	[conn autorelease];
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
	[image release];
	image = [[UIImage alloc] initWithData:data];
	
	[conn autorelease];
	conn = nil;
	
	if ([delegate respondsToSelector:@selector(imageDownloaderDidSucceed:)]) {
		[delegate imageDownloaderDidSucceed:self];
	}
}

- (void)httpClientFailed:(HttpClient*)sender error:(NSError*)error
{
	[conn autorelease];
	conn = nil;
	
	if ([delegate respondsToSelector:@selector(imageDownloaderDidFail:error:)]) {
		[delegate imageDownloaderDidFail:self error:error];
	}
}

- (void)cancel
{
    conn.delegate = nil;
    [conn cancel];
    [conn release];
    conn = nil;
}

@end
