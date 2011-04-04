// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the new BSD license.

#import <Foundation/Foundation.h>
#import "HttpClient.h"


@interface ImageDownloader : NSObject
{
	id delegate;
	NSString* url;
	UIImage* image;
	HttpClient* conn;
}

@property (nonatomic, readonly) UIImage* image;
@property (nonatomic, readonly) NSString* url;

+ (ImageDownloader*)imageDownloaderWithDelegate:(id)aDelegate url:(NSString*)url;
- (void)cancel;
@end


@interface NSObject (ImageDownloaderDelegate)
- (void)imageDownloaderDidSucceed:(ImageDownloader*)sender;
- (void)imageDownloaderDidFail:(ImageDownloader*)sender error:(NSError*)error;
@end
