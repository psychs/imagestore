// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the new BSD license.

#import <UIKit/UIKit.h>


@interface FastTableViewCell : UITableViewCell
{
	UIView* fastTableContentView;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;
- (void)drawContentView:(CGRect)dirtyRect;

@end
