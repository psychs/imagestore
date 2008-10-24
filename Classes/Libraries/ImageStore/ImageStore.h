// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the new BSD license.

#import <UIKit/UIKit.h>

@interface ImageStore : NSObject
{
	id delegate;
	NSMutableDictionary* images;
	NSMutableDictionary* conns;
}

@property (nonatomic, assign) id delegate;

- (id)initWithDelegate:(id)aDelegate;
- (UIImage*)getImage:(NSString*)url;

@end
