// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the new BSD license.

#import <UIKit/UIKit.h>
#import "FastTableViewCell.h"
#import "Status.h"
#import "ImageStore.h"


@interface StatusCell : FastTableViewCell
{
	Status* status;
	ImageStore* imageStore;
}

@property (nonatomic, retain) Status* status;
@property (nonatomic, assign) ImageStore* imageStore;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end
