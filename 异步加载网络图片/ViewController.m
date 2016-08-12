//
//  ViewController.m
//  异步加载网络图片
//
//  Created by LLQ on 16/6/4.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCaches.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //注册单元格
    [_imageCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
}

#pragma mark------UICollectionViewDataSource

//返回每组单元格个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 20;
    
}

//返回单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //复用单元格
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if (![cell.contentView viewWithTag:110]) {
        //如果取不到单元格上面tag为110的视图，就创建
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.bounds];
        imageView.tag = 110;
        [cell.contentView addSubview:imageView];
    }
    
    UIImageView *imageView = [cell.contentView viewWithTag:110];
    [imageView setimageWithURL:@"http://g.hiphotos.baidu.com/image/pic/item/0df3d7ca7bcb0a46bc0b4d3d6963f6246b60af8d.jpg"];
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
