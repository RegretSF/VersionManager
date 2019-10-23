//
//  FBAppStoreInfo.m
//
//  Created by Mac on 2019/10/23.
//  Copyright © 2019 Fat brther. All rights reserved.
//

#import "FBAppStoreInfo.h"

@implementation FBAppStoreInfo
- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)appStoreInfoWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}
@end
