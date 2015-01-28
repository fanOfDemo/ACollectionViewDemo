//
//  CollectionViewCell.h
//  ABoringDemo
//
//  Created by 翁燚明 on 15/1/28.
//  Copyright (c) 2015年 翁燚明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionViewCell : UICollectionViewCell

@property (nonatomic, retain) IBOutlet UIImageView *icon;
@property (nonatomic, retain) IBOutlet UILabel *menuName;
@property (nonatomic,retain) IBOutlet UIButton *btn;
+(id)cell;
@end
