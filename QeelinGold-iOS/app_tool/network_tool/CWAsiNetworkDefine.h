//
//  CWAsiNetworkDefine.h
//  QeelinGold-iOS
//
//  Created by MacBook on 2017/4/6.
//  Copyright © 2017年 chen. All rights reserved.
//

#ifndef CWAsiNetworkDefine_h
#define CWAsiNetworkDefine_h

/**
 *  请求类型
 */
typedef enum {
    RequestAsiNetWorkGET = 1,   /**< GET请求 */
    RequestAsiNetWorkPOST       /**< POST请求 */
} RequestAsiNetWorkType;

/**
 *  网络请求超时的时间
 */
#define RequestAsi_API_TIME_OUT 20

#if NS_BLOCKS_AVAILABLE
/**
 *  请求开始的回调（下载时用到）
 */
typedef void (^RequestAsiStartBlock)(void);

/**
 *  请求成功回调
 *
 *  @param returnData 回调block
 */
typedef void (^RequestAsiSuccessBlock)(NSDictionary *returnData);

/**
 *  请求失败回调
 *
 *  @param error 回调block
 */
typedef void (^RequestAsiFailureBlock)(NSError *error);

#endif


#endif /* CWAsiNetworkDefine_h */
