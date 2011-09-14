// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the new BSD license.

#import "StatusCell.h"


@implementation StatusCell

@synthesize status;
@synthesize imageStore;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)dealloc
{
    [status release];
    [super dealloc];
}

- (void)setStatus:(Status*)value
{
    if (status != value) {
        [status release];
        status = [value retain];
    }
    [self setNeedsDisplay];
}

- (void)drawContentView:(CGRect)dirtyRect
{
    NSString* s;
    UIColor* nameColor;
    UIColor* textColor;
    
    if (self.selected || self.highlighted) {
        nameColor = textColor = [UIColor whiteColor];
    }
    else {
        nameColor = [UIColor colorWithRed:0 green:0.3 blue:1 alpha:1];
        textColor = [UIColor blackColor];
    }
    
    //
    // draw name
    //
    [nameColor set];
    s = status.user.name;
    [s drawInRect:status.nameRect withFont:[UIFont boldSystemFontOfSize:CELL_NAME_FONT_SIZE]];
    
    //
    // draw text
    //
    [textColor set];
    s = status.text;
    [s drawInRect:status.textRect withFont:[UIFont systemFontOfSize:CELL_TEXT_FONT_SIZE]];
    
    //
    // draw icon if exists
    //
    UIImage* icon = [imageStore getImage:status.user.profileImageUrl];
    if (icon) {
        CGSize size = icon.size;
        
        // calculate image size
        if (size.width > CELL_ICON_WIDTH || size.height > CELL_ICON_WIDTH) {
            if (size.width > size.height) {
                CGFloat ratio = CELL_ICON_WIDTH / size.width;
                size.width *= ratio;
                size.height *= ratio;
            }
            else {
                CGFloat ratio = CELL_ICON_WIDTH / size.height;
                size.width *= ratio;
                size.height *= ratio;
            }
        }
        
        CGFloat x = CELL_LEFT_MARGIN;
        CGFloat y = CELL_V_MARGIN;
        
        // centering
        if (size.width < CELL_ICON_WIDTH) {
            x += (CELL_ICON_WIDTH - size.width) / 2;
        }
        if (size.height < CELL_ICON_WIDTH) {
            y += (CELL_ICON_WIDTH - size.height) / 2;
        }
        
        CGRect iconRect = CGRectMake(x, y, size.width, size.height);
        CGFloat ovalWidth = 10;
        CGFloat ovalHeight = 10;
        CGFloat w, h;
        
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
