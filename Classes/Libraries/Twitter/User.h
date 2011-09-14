// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the new BSD license.

#import <Foundation/Foundation.h>


@interface User : NSObject
{
    long long userId;
    NSString* screenName;
    NSString* name;
    NSString* profileImageUrl;
}

@property (nonatomic, readonly) long long userId;
@property (nonatomic, readonly) NSString* screenName;
@property (nonatomic, readonly) NSString* name;
@property (nonatomic, readonly) NSString* profileImageUrl;

+ (User*)userWithDictionary:(NSDictionary*)dic;

@end
