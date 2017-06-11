//
//  CWAsiNetworkUrl.h
//  QeelinGold-iOS
//
//  Created by MacBook on 2017/4/6.
//  Copyright © 2017年 chen. All rights reserved.
//

#ifndef CWAsiNetworkUrl_h
#define CWAsiNetworkUrl_h

#ifdef DEBUG
//#define API_Public_Link     @"http://wp.500win.cn/ctrade"//测试盘请求
#define API_Public_Link     @"http://www.qilin99.com/ctrade"//实盘请求
#else
#define API_Public_Link     @"http://www.qilin99.com/ctrade"
#endif

//系统版本号
#define kCurrentSystemVersion [NSString stringWithFormat:@"%.2f",[[[UIDevice currentDevice] systemVersion] floatValue]]
//app版本号
#define kCurrentAppVersion      [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//版本标示
#define kUa @"ios"
//idfa
#define IDFA_String [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]
#define API_Public_Param  [NSString stringWithFormat:@"?sysver=%@&appsver=%@&ua=%@&idfa=%@",kCurrentSystemVersion,kCurrentAppVersion,kUa,IDFA_String]
//接口路径全拼
#define PATH(_path)             [NSString stringWithFormat:_path, API_Public_Link]
/**
 *      首页
 */
#define DEF_GetHomepage         PATH(@"%@/system/getNoticeList.do")
#endif /* CWAsiNetworkUrl_h */
