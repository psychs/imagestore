// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the new BSD license.

#import <UIKit/UIKit.h>

@interface TimelineDownloader : NSObject
{
	id delegate;
	NSURLConnection* conn;
	NSMutableData* buf;
}

@property (nonatomic, readonly) BOOL isActive;

- (id)initWithDelegate:(id)delegate;
- (void)get;

@end
