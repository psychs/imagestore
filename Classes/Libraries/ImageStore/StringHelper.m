// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the new BSD license.

#import "StringHelper.h"

@implementation NSString (StringHelper)

- (NSString*)encodeAsURIComponent
{
	const char* p = [self UTF8String];
	NSMutableString* result = [NSMutableString string];
	
	for (;*p ;p++) {
		unsigned char c = *p;
		if ('0' <= c && c <= '9' || 'a' <= c && c <= 'z' || 'A' <= c && c <= 'Z' || c == '-' || c == '_') {
			[result appendFormat:@"%c", c];
		}
		else {
			[result appendFormat:@"%%%02X", c];
		}
	}
	
	return result;
}

@end
