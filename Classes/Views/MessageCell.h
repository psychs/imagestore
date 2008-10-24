// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the new BSD license.

#import <UIKit/UIKit.h>
#import "Message.h"
#import "MessageContentView.h"
#import "ImageStore.h"

@interface MessageCell : UITableViewCell
{
	MessageContentView* view;
	Message* message;
}

@property (nonatomic, retain) Message* message;
@property (nonatomic, assign) ImageStore* imageStore;

@end
