// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the new BSD license.

#import <Foundation/Foundation.h>
#import "HttpClient.h"


@interface TimelineDownloader : NSObject
{
	id delegate;
	HttpClient* conn;
}

@property (nonatomic, readonly) BOOL isActive;

- (id)initWithDelegate:(id)delegate;
- (void)get;

@end


@interface NSObject (TimelineDownloaderDelegate)
- (void)timelineDownloaderDidSucceed:(TimelineDownloader*)sender statuses:(NSArray*)statuses;
- (void)timelineDownloaderDidFail:(TimelineDownloader*)sender error:(NSError*)error;
@end
