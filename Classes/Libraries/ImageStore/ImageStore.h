// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the new BSD license.

#import <Foundation/Foundation.h>


@interface ImageStore : NSObject
{
	id delegate;
	NSMutableDictionary* images;
	NSMutableDictionary* conns;
}

@property (nonatomic, assign) id delegate;

- (id)initWithDelegate:(id)aDelegate;
- (UIImage*)getImage:(NSString*)url;

@end


@interface NSObject (ImageStoreDelegate)
- (void)imageStoreDidGetNewImage:(ImageStore*)sender url:(NSString*)url;
- (void)imageStoreDidFailNewImage:(ImageStore *)sender url:(NSString *)url fallbackImage:(UIImage**)anImage;
@end
