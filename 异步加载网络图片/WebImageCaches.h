//
//  WebImageCaches.h
//  异步加载网络图片
//
//  Created by LLQ on 16/6/4.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WebImageCaches : NSObject

@property(nonatomic,strong)NSString *imagePath;

+ (WebImageCaches *)shareInstance;

- (void)setImageToCachesWithImageData:(NSData *)imageData withImageName:(NSString *)imageName;

- (UIImage *)getImageFromCachesWithName:(NSString *)imageName;

@end
