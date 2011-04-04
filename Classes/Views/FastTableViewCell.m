// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the new BSD license.

#import "FastTableViewCell.h"


@interface FastTableViewCellContentView : UIView
@end

@implementation FastTableViewCellContentView

- (void)drawRect:(CGRect)dirtyRect
{
	[(FastTableViewCell*)self.superview drawContentView:dirtyRect];
}

@end



@implementation FastTableViewCell

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	if (self) {
		fastTableContentView = [[FastTableViewCellContentView alloc] initWithFrame:CGRectZero];
		fastTableContentView.opaque = YES;
		fastTableContentView.backgroundColor = [UIColor whiteColor];
		[self addSubview:fastTableContentView];
		[fastTableContentView release];
	}
	return self;
}

- (void)dealloc
{
	[super dealloc];
}

- (void)setFrame:(CGRect)value
{
	[super setFrame:value];
	CGRect b = [self bounds];
	b.size.height -= 1; // leave room for the seperator line
	[fastTableContentView setFrame:b];
	[self setNeedsDisplay];
}

- (void)setNeedsDisplay
{
	[super setNeedsDisplay];
	[fastTableContentView setNeedsDisplay];
}

- (void)drawContentView:(CGRect)dirtyRect
{
}

@end
