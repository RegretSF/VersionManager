//
//  FBVersionManager.m
//
//  Created by Mac on 2019/10/23.
//  Copyright © 2019 Fat brther. All rights reserved.
//

#import "FBVersionManager.h"
#import "FBAppStoreInfo.h"

@implementation FBVersionManager
// 单例
static FBVersionManager* instance = nil;
+ (FBVersionManager *)shared {
    if (!instance) {
        instance = [[self alloc] init];
    }
    return instance;
}

// 检查新版本(使用系统的提示框)
- (void)checkNewVersionWithAppId:(NSString *)appId ctrl:(UIViewController *)containCtrl {
    [self loadAppStoreInfoWithAppId:appId ctrl:containCtrl isCustom:NO completion:nil];
}

// 检查新版本(使用自定义提示窗口)
- (void)checkNewVersionWithAppId:(NSString *)appId customAlert:(checkVersionBlock)checkVersionBlock {
    [self loadAppStoreInfoWithAppId:appId ctrl:nil isCustom:YES completion:^(FBAppStoreInfo *appInfo) {
        checkVersionBlock(appInfo);
    }];
}

/// 加载应用在 App Store 上的信息
/// @param appId appId
/// @param containCtrl 提示框显示在哪个控制器上
/// @param isCustom 是否是自定义提示弹窗
/// @param completion [完成回调] - 如果是自定义提示弹窗的话就回调
- (void)loadAppStoreInfoWithAppId:(NSString *)appId ctrl:(nullable UIViewController *)containCtrl isCustom:(BOOL)isCustom completion:(nullable void(^)(FBAppStoreInfo *appInfo))completion {
    // 1.获取 AppStore 上的版本信息
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/CN/lookup?id=%@",appId]];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        // 1.1 将得到的 NSData 转换成 JSON 数据
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        // 取出字典里的数组
        NSArray *results = json[@"results"];
        // 1.2字典转模型
        FBAppStoreInfo *model = [FBAppStoreInfo appStoreInfoWithDict:results.firstObject];
        
        // 2.从 info.plist 中取出版本号
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleVersionKey];
        
        // 3.判断 AppStore 上的版本与本地沙盒的版本号是否一致，如果不一致，提示更新，否则什么都不做。
        if (![model.version isEqualToString:currentVersion]) {
            // 回到主线程才能对 UI 进行操作
            dispatch_async(dispatch_get_main_queue(), ^{
                if (isCustom) {
                    completion(model);
                }else {
                    [self showAlertWithMode:model ctrl:containCtrl];
                }
            });
        }
        
    }] resume];
}

/// 显示提示窗口
/// @param model App Store 信息模型
/// @param containCtrl 提示框显示在哪个控制器上
- (void)showAlertWithMode:(FBAppStoreInfo *)model ctrl:(UIViewController *)containCtrl {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"有新的版本(%@)", model.version] message:model.releaseNotes preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *updateAction = [UIAlertAction actionWithTitle:@"立即升级" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:model.trackViewUrl]]) {
                if (@available(iOS 10.0, *)) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.trackViewUrl] options:@{} completionHandler:nil];
                } else {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.trackViewUrl]];
                }
            }
        }];
        UIAlertAction *delayAction = [UIAlertAction actionWithTitle:@"稍后再说" style:UIAlertActionStyleDefault handler:nil];
    
        [alertController addAction:updateAction];
        [alertController addAction:delayAction];
    
        [containCtrl presentViewController:alertController animated:YES completion:nil];
}
@end
