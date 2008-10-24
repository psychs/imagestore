// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the new BSD license.

#import <Foundation/Foundation.h>

@interface HttpClient : NSObject
{
	id delegate;
	NSString* userAgent;
	
	NSURLConnection* conn;
	NSHTTPURLResponse* response;
	NSMutableData* buf;
}

@property (nonatomic, assign) id delegate;
@property (nonatomic, readonly) BOOL isActive;
@property (nonatomic, retain) NSString* userAgent;

- (id)initWithDelegate:(id)aDelegate;
- (void)cancel;
- (void)get:(NSString*)url parameters:(NSDictionary*)params;
- (void)post:(NSString*)url parameters:(NSDictionary*)params;

@end
