// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the new BSD license.

#import "MessageCell.h"
#import "MessageContentView.h"

@implementation MessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		view = [[MessageContentView alloc] initWithFrame:CGRectZero];
		[self.contentView addSubview:view];
		[view release];
		self.accessoryType = UITableViewCellAccessoryNone;
	}
	return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)setMessage:(Message*)value
{
	view.message = value;
}

- (Message*)message
{
	return view.message;
}

- (void)setImageStore:(ImageStore*)value
{
	view.imageStore = value;
}

- (ImageStore*)imageStore
{
	return view.imageStore;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	CGRect bounds = self.bounds;
	view.frame = CGRectMake(0, 1, bounds.size.width, bounds.size.height - 2);
}

@end
