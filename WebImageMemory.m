//
//  WebImageMemory.m
//  异步加载网络图片
//
//  Created by LLQ on 16/6/4.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "WebImageMemory.h"

@implementation WebImageMemory

static WebImageMemory *webImgMemory;
//单例方法
+ (WebImageMemory *)shareInstancy{
    
    //GCD只执行一次的方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        webImgMemory = [[WebImageMemory alloc] init];
        
    });
    
    return webImgMemory;
}

//复写字典的get方法，只在第一次get时初始化字典（懒加载）
- (NSMutableDictionary *)imageDic{
    
    if (!_imageDic) {
        
        _imageDic = [[NSMutableDictionary alloc] init];
        
    }
    return _imageDic;
}

//存储的方法
- (void)setImageToMemoryWithImage:(UIImage *)image withName:(NSString *)imageName{
    
    [self.imageDic setObject:image forKey:imageName];
    
}

//读取的方法
- (UIImage *)getImageFormMenoryWithName:(NSString *)imageName{
    
    UIImage *image = [self.imageDic objectForKey:imageName];
    
    if (image) {
        return image;
    }
    
    return nil;
    
}

@end
