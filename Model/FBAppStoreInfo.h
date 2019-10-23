//
//  FBAppStoreInfo.h
//
//  Created by Mac on 2019/10/23.
//  Copyright © 2019 Fat brther. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FBAppStoreInfo : NSObject
/// AppId
@property(nonatomic, copy) NSString* trackId;
/// 版本号
@property(nonatomic, copy) NSString *version;
/// 更新的内容
@property(nonatomic, copy) NSString *releaseNotes;
/// AppStore 下载地址
@property(nonatomic, copy) NSString *trackViewUrl;
/// 当前版本发布日期
@property(nonatomic, copy) NSString *currentVersionReleaseDate;

/// 字典转模型的对象方法
/// @param dict 字典
- (instancetype)initWithDict:(NSDictionary *)dict;

/// 字典转模型的类方法
/// @param dict 字典
+(instancetype)appStoreInfoWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
