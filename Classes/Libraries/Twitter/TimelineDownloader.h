// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the new BSD license.

#import <UIKit/UIKit.h>
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
