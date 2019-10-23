# VersionManager
iOS检测版本号提示用户更新
用法：
1.导入头文件：
#improt "FBVersionManager.h"

2.在需要使用的地方使用
/ /判断版本号，提示更新
//使用系统提供的提示弹窗
[FBVersionManager.shared checkNewVersionWithAppId: @"xxxxxxx" ctrl: 视图控制器];

或者

//在block里使用自定义的提示弹窗
 [FBVersionManager.shared checkNewVersionWithAppId: @"xxxxxxx" customAlert:^(FBAppStoreInfo * _Nonnull appInfo) {
 
}];
