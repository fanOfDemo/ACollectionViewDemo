//
//  CollectionViewCell.m
//  ABoringDemo
//
//  Created by 翁燚明 on 15/1/28.
//  Copyright (c) 2015年 翁燚明. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell
@synthesize icon;
@synthesize menuName;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"MyCollectionViewCell" owner:self options:nil];
        
        // 如果路径不存在，return nil
        if (arrayOfViews.count < 1)
        {
            return nil;
        }
        // 如果xib中view不属于UICollectionViewCell类，return nil
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]])
        {
            return nil;
        }
        // 加载nib
        self = [arrayOfViews objectAtIndex:0];
    }
    return self;
}

+ (id) cell{
    return [[[NSBundle mainBundle] loadNibNamed:@"MyCollectionViewCell" owner:self options:nil] objectAtIndex:0];
}
@end
