//
//  WebImageCaches.m
//  异步加载网络图片
//
//  Created by LLQ on 16/6/4.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "WebImageCaches.h"

@implementation WebImageCaches


static WebImageCaches *imageCaches;
//单例方法
+ (WebImageCaches *)shareInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        imageCaches = [[WebImageCaches alloc] init];
        
    });
    
    return imageCaches;
    
}

//复写imagePath的get方法，在第一次get时给imagePath赋值
- (NSString *)imagePath{
    
    if (!_imagePath) {
        //获取文件存储路径
        _imagePath = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/WebImageCaches/"];
        //通过文件管家创建该路径
        [[NSFileManager defaultManager] createDirectoryAtPath:_imagePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return _imagePath;
    
}

//存入硬盘
- (void)setImageToCachesWithImageData:(NSData *)imageData withImageName:(NSString *)imageName{
    
    //拼接文件路径
    NSString *filePath = [self.imagePath stringByAppendingString:imageName];
    //使用文件管家将data存储
    [[NSFileManager defaultManager] createFileAtPath:filePath contents:imageData attributes:nil];
    
}

//从硬盘读取
- (UIImage *)getImageFromCachesWithName:(NSString *)imageName{
    
    //拼接文件路径
    NSString *filePath = [self.imagePath stringByAppendingString:imageName];
    //取出图片
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    
    return image;
    
}


@end
