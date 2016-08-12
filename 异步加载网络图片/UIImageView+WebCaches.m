//
//  UIImageView+WebCaches.m
//  异步加载网络图片
//
//  Created by LLQ on 16/6/4.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "UIImageView+WebCaches.h"
#import "WebImageMemory.h"
#import "WebImageCaches.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation UIImageView (WebCaches)

- (void)setimageWithURL:(NSString *)urlString{
    
    //MD5加密
    NSString *imageName = [self md5:urlString];
    
    //首先从内存中读取
    UIImage *image = [[WebImageMemory shareInstancy] getImageFormMenoryWithName:imageName];
    
    //如果能从内存取到值，就直接加载
    if (image) {
        self.image = image;
        NSLog(@"从内存加载");
        return;
    }
    
    //其次从硬盘中读取
    UIImage *image2 = [[WebImageCaches shareInstance] getImageFromCachesWithName:imageName];
    
    //如果能从硬盘中取到，就直接加载
    if (image2) {
        self.image = image2;
        NSLog(@"从硬盘加载");
        //存入内存
        [[WebImageMemory shareInstancy] setImageToMemoryWithImage:image2 withName:imageName];
        return;
    }
    
    //创建一个串行队列，执行下载任务
    dispatch_queue_t download_queu = dispatch_queue_create("download_queue", DISPATCH_QUEUE_SERIAL);
    
    //异步添加任务  开辟子线程
    dispatch_async(download_queu, ^{
       
        //下载任务
        NSURL *imageURL = [NSURL URLWithString:urlString];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage *image = [UIImage imageWithData:imageData];
        
        NSLog(@"下载");
        
        if (image == nil) {
            NSLog(@"图片下载失败");
            return;
        }
        
        //获取主队列向主队列异步添加加载图片的任务
        dispatch_async(dispatch_get_main_queue(), ^{
           
            self.image = image;
            //将网路下载的图片存入内存
            [[WebImageMemory shareInstancy] setImageToMemoryWithImage:image withName:imageName];
            
            //存入硬盘
            [[WebImageCaches shareInstance] setImageToCachesWithImageData:imageData withImageName:imageName];
            
        });
        
    });
    
    
}

//MD5加密
- (NSString *)md5:(NSString *)str{
    
    const char *cStr = [str UTF8String];
    unsigned char schemes[CC_MD5_DIGEST_LENGTH];
    
    //MD5加密函数
    CC_MD5(cStr, (UInt32)strlen(cStr), schemes);
    
    NSMutableString *md5Str = [[NSMutableString alloc] init];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i ++) {
        
        [md5Str appendFormat:@"%02x",schemes[i]];
        
    }
    [md5Str appendFormat:@".png"];
    
    
    return md5Str;
}

@end
