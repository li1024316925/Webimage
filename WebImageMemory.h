//
//  WebImageMemory.h
//  异步加载网络图片
//
//  Created by LLQ on 16/6/4.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WebImageMemory : NSObject

@property(nonatomic,strong)NSMutableDictionary *imageDic;

+ (WebImageMemory *)shareInstancy;

//存储的方法
- (void)setImageToMemoryWithImage:(UIImage *)image withName:(NSString *)imageName;

//读取
- (UIImage *)getImageFormMenoryWithName:(NSString *)imageName;



@end
