//
//  FBVersionManager.h
//
//  Created by Mac on 2019/10/23.
//  Copyright © 2019 Fat brther. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class FBAppStoreInfo;

typedef void(^checkVersionBlock)(FBAppStoreInfo *appInfo);

@interface FBVersionManager : NSObject
/// 版本管理单例
+(FBVersionManager *)shared;

/// 检查新版本(使用系统的提示框)
/// 如果有新版本，显示提示框提示用户
/// @param appId 应用在Store里面的ID (应用的AppStore地址里面可获取)
/// @param containCtrl 提示框显示在哪个控制器上
- (void)checkNewVersionWithAppId:(NSString *)appId ctrl:(UIViewController *)containCtrl;

/// 检查新版本(使用自定义提示窗口)
/// 在 customAlert 里根据 FBAppStoreInfo 的信息提示用户更新
/// 假如没有新版本，没有回调，使用者只需做提示窗口的处理，不需要关心是否有新版本
/// @param appId 应用在Store里面的ID (应用的AppStore地址里面可获取)
/// @param checkVersionBlock 检查新版本后的回调
- (void)checkNewVersionWithAppId:(NSString *)appId customAlert:(checkVersionBlock)checkVersionBlock;

@end

NS_ASSUME_NONNULL_END
