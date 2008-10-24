// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the new BSD license.

#import "User.h"

@implementation User

@synthesize userId;
@synthesize screenName;
@synthesize name;
@synthesize profileImageUrl;

- (User*)initWithDictionary:(NSDictionary*)dic
{
	if (self = [super init]) {
		userId = [[dic objectForKey:@"id"] intValue];
		screenName = [[dic objectForKey:@"screen_name"] retain];
		name = [[dic objectForKey:@"name"] retain];
		profileImageUrl = [[dic objectForKey:@"profile_image_url"] retain];
	}
	return self;
}

- (void)dealloc
{
	[screenName release];
	[name release];
	[profileImageUrl release];
	[super dealloc];
}

+ (User*)userWithDictionary:(NSDictionary*)dic
{
	return [[[User alloc] initWithDictionary:dic] autorelease];
}

@end
