// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the new BSD license.

#import <UIKit/UIKit.h>
#import "Message.h"
#import "ImageStore.h"

@interface MessageContentView : UIView
{
	Message* message;
	ImageStore* imageStore;
}

@property (nonatomic, retain) Message* message;
@property (nonatomic, assign) ImageStore* imageStore;

@end
