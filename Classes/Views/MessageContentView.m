// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the new BSD license.

#import "MessageContentView.h"
#import "MessageCell.h"
#import "Message.h"


@implementation MessageContentView

@synthesize message;
@synthesize imageStore;

- (id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
		self.backgroundColor = [UIColor whiteColor];
	}
	return self;
}

- (void)dealloc
{
	[message release];
	[super dealloc];
}

- (void)setMessage:(Message*)value
{
	if (message != value) {
		[message release];
		message = [value retain];
	}
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
	NSString* s;
	UIColor* nameColor;
	UIColor* textColor;
	
	MessageCell* cell = (MessageCell*)self.superview.superview;
	if (cell.selected) {
		nameColor = textColor = [UIColor whiteColor];
	}
	else {
		nameColor = [UIColor colorWithRed:0.0 green:0.3 blue:1.0 alpha:1.0];
		textColor = [UIColor blackColor];
	}
	
	// draw name
	//
	[nameColor set];
	s = message.user.name;
	[s drawInRect:message.nameRect withFont:[UIFont boldSystemFontOfSize:CELL_NAME_FONT_SIZE]];
	
	// draw text
	//
	[textColor set];
	s = message.text;
	[s drawInRect:message.textRect withFont:[UIFont systemFontOfSize:CELL_TEXT_FONT_SIZE]];
	
	// draw icon if exists
	//
	UIImage* icon = [imageStore getImage:message.user.profileImageUrl];
	if (icon) {
		CGRect iconRect = CGRectMake(CELL_LEFT_MARGIN, CELL_V_MARGIN, icon.size.width, icon.size.height);
		float ovalWidth = 10;
		float ovalHeight = 10;
		float w, h;
		
		CGContextRef c = UIGraphicsGetCurrentContext();
		
		CGContextSaveGState(c);
		CGContextBeginPath(c);
		CGContextTranslateCTM(c, CGRectGetMinX(iconRect), CGRectGetMinY(iconRect));
		CGContextScaleCTM(c, ovalWidth, ovalHeight);
		w = CGRectGetWidth(iconRect) / ovalWidth;
		h = CGRectGetHeight(iconRect) / ovalHeight;
		CGContextMoveToPoint(c, w, h/2);
		CGContextAddArcToPoint(c, w, h, w/2, h, 0.5);
		CGContextAddArcToPoint(c, 0, h, 0, h/2, 0.5);
		CGContextAddArcToPoint(c, 0, 0, w/2, 0, 0.5);
		CGContextAddArcToPoint(c, w, 0, w, h/2, 0.5);
		CGContextClosePath(c);
		CGContextRestoreGState(c);
		CGContextClip(c);
		[icon drawInRect:iconRect];
	}
}

@end
