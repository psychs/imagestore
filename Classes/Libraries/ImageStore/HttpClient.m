// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the new BSD license.

#import "HttpClient.h"
#import "StringHelper.h"

#define HTTP_CLIENT_TIMEOUT 180.0

@implementation HttpClient

@synthesize delegate;
@synthesize userAgent;

- (id)init
{
	if (self = [super init]) {
		;
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
	[self cancel];
	[userAgent release];
	[super dealloc];
}

- (void)cancel
{
	if (conn) {
		[conn cancel];
		[conn autorelease];
	}
	[response autorelease];
	[buf autorelease];
	
	conn = nil;
	response = nil;
	buf = nil;
}

- (NSString*)buildParameters:(NSDictionary*)params
{
	NSMutableString* s = [NSMutableString string];
	if (params) {
		NSEnumerator* e = [params keyEnumerator];
		NSString* key;
		while (key = (NSString*)[e nextObject]) {
			NSString* value = [[params objectForKey:key] encodeAsURIComponent];
			[s appendFormat:@"%@=%@&", key, value];
		}
		if (s.length > 0) [s deleteCharactersInRange:NSMakeRange(s.length-1, 1)];
	}
	return s;
}

- (void)get:(NSString*)url parameters:(NSDictionary*)params
{
	[self cancel];
	
	NSMutableString* fullUrl = [NSMutableString stringWithString:url];
	NSString* paramStr = [self buildParameters:params];
	if (paramStr.length > 0) {
		[fullUrl appendString:@"?"];
		[fullUrl appendString:paramStr];
	}
	
	NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:fullUrl]
													   cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
												   timeoutInterval:HTTP_CLIENT_TIMEOUT];
	
	if (userAgent) [req setValue:userAgent forHTTPHeaderField:@"User-Agent"];
	[req setHTTPShouldHandleCookies:YES];
	
	conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
	buf = [NSMutableData new];
}

- (void)post:(NSString*)url parameters:(NSDictionary*)params
{
	[self cancel];
	
	NSData* body = [[self buildParameters:params] dataUsingEncoding:NSUTF8StringEncoding];
	
	NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
													   cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
												   timeoutInterval:HTTP_CLIENT_TIMEOUT];
	
	[req setHTTPMethod:@"POST"];
	if (userAgent) [req setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    [req setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [req setValue:[NSString stringWithFormat:@"%d", body.length] forHTTPHeaderField:@"Content-Length"];
	[req setHTTPBody:body];
	[req setHTTPShouldHandleCookies:YES];
	
	conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
	buf = [NSMutableData new];
}

- (BOOL)isActive
{
	return conn != nil;
}

- (void)connection:(NSURLConnection*)sender didReceiveResponse:(NSHTTPURLResponse*)aResponse
{
	[response release];
	response = [aResponse retain];
}

- (void)connection:(NSURLConnection*)sender didReceiveData:(NSData*)data
{
	[buf appendData:data];
}

- (void)connection:(NSURLConnection*)sender didFailWithError:(NSError*)error
{
	[self cancel];
	
	if ([delegate respondsToSelector:@selector(httpClientFailed:error:)]) {
		[delegate httpClientFailed:self error:error];
	}
}

- (void)connectionDidFinishLoading:(NSURLConnection*)sender
{
	NSData* tmpBuf = buf;
	NSHTTPURLResponse* tmpResponse = response;
	
	[self cancel];
	
	if ([delegate respondsToSelector:@selector(httpClientSucceeded:response:data:)]) {
		[delegate httpClientSucceeded:self response:tmpResponse data:tmpBuf];
	}
}

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)req redirectResponse:(NSURLResponse *)res
{
	if (res) {
		if ([delegate respondsToSelector:@selector(httpClientShouldRedirect:request:response:)]) {
			BOOL result = [delegate httpClientShouldRedirect:self request:req response:(NSHTTPURLResponse*)res];
			if (!result) return nil;
		}
	}
	return req;
}

@end
