// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the new BSD license.

#import "ImageStore.h"
#import "ImageDownloader.h"

@interface ImageStore (Private)
- (void)sendRequestForImage:(NSString*)url;
@end


@implementation ImageStore

@synthesize delegate;

- (id)init
{
    self = [super init];
	if (self) {
		images = [NSMutableDictionary new];
		conns = [NSMutableDictionary new];
	}
	return self;
}

- (id)initWithDelegate:(id)aDelegate
{
	if ([self init]) {
		delegate = aDelegate;
	}
	return self;
}

- (void)dealloc
{
	[images release];
	[conns release];
	[super dealloc];
}

- (UIImage*)getImage:(NSString*)url
{
	UIImage* image = [images objectForKey:url];
	if (!image && ![conns objectForKey:url]) {
		[self sendRequestForImage:url];
	}
	return image;
}

- (void)sendRequestForImage:(NSString*)url
{
	ImageDownloader* d = [ImageDownloader imageDownloaderWithDelegate:self url:url];
	[conns setObject:d forKey:url];
}

- (void)imageDownloaderDidSucceed:(ImageDownloader*)sender
{
	[[sender retain] autorelease];
	NSString* url = sender.url;
	
	UIImage* image = sender.image;
	if (image) [images setObject:image forKey:url];
	[conns removeObjectForKey:url];
	
	if ([delegate respondsToSelector:@selector(imageStoreDidGetNewImage:url:)]) {
		[delegate imageStoreDidGetNewImage:self url:url];
	}
}

- (void)imageDownloaderDidFail:(ImageDownloader*)sender error:(NSError*)error
{
	[[sender retain] autorelease];
    NSString *url = sender.url;
    
    UIImage *image = nil;
    if ([delegate respondsToSelector:@selector(imageStoreDidFailNewImage:url:fallbackImage:)]) {
        [delegate imageStoreDidFailNewImage:self url:url fallbackImage:&image];
        if (image) {
            [images setObject:image forKey:url];
            if ([delegate respondsToSelector:@selector(imageStoreDidGetNewImage:url:)]) {
                [delegate imageStoreDidGetNewImage:self url:url];
            }
        }
    }
    
	[conns removeObjectForKey:sender.url];
}

- (void)cancelAllDownloads
{
    for (ImageDownloader *url in conns) {
        [[conns objectForKey:url] cancel];
    }
    [conns removeAllObjects];
}

- (void)cancelDownloadFromUrl:(NSString *)url
{
    [[conns objectForKey:url] cancel];
    [conns removeObjectForKey:url];
}

- (void)clearAllCaches
{
    [images removeAllObjects];
}

- (void)clearCacheForUrl:(NSString *)url
{
    [images removeObjectForKey:url];
}

@end
