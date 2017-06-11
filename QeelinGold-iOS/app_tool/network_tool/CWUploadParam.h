//
//  CWUploadParam.h
//  QeelinGold-iOS
//
//  Created by MacBook on 2017/4/6.
//  Copyright © 2017年 chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CWUploadParam : NSObject

/**
 *  上传文件的二进制数据
 */
@property (nonatomic, strong) NSData *data;
/**
 *  上传的参数名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  上传到服务器的文件名称
 */
@property (nonatomic, copy) NSString *fileName;

/**
 *  上传文件的类型
 */
@property (nonatomic, copy) NSString *mimeType;


@end
