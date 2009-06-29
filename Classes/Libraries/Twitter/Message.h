// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the new BSD license.

#import <Foundation/Foundation.h>
#import "User.h"

#define CELL_WIDTH				320
#define CELL_LEFT_MARGIN		6
#define CELL_ICON_WIDTH			48
#define CELL_ICON_RIGHT_MARGIN	8
#define CELL_LEFT				(CELL_LEFT_MARGIN + CELL_ICON_WIDTH + CELL_ICON_RIGHT_MARGIN)
#define CELL_RIGHT_MARGIN		4
#define CELL_V_MARGIN			2
#define CELL_NAME_BOTTOM_MARGIN	2
#define CELL_CONTENT_WIDTH		(CELL_WIDTH - CELL_LEFT - CELL_RIGHT_MARGIN)
#define CELL_TEXT_MAX_HEIGHT	10000
#define CELL_MIN_HEIGHT			(CELL_V_MARGIN + CELL_ICON_WIDTH + CELL_V_MARGIN)

#define CELL_NAME_FONT_SIZE		14
#define CELL_TEXT_FONT_SIZE		14

@interface Message : NSObject
{
	long long messageId;
	NSString* text;
	User* user;
	
	float cellHeight;
	CGRect nameRect;
	CGRect textRect;
}

@property (nonatomic, readonly) long long messageId;
@property (nonatomic, readonly) NSString* text;
@property (nonatomic, readonly) User* user;
@property (nonatomic, readonly) float cellHeight;
@property (nonatomic, readonly) CGRect nameRect;
@property (nonatomic, readonly) CGRect textRect;

+ (Message*)messageWithDictionary:(NSDictionary*)dic;
- (void)calculateGeometries;

@end
