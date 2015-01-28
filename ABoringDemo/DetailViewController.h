//
//  DetailViewController.h
//  ABoringDemo
//
//  Created by 翁燚明 on 15/1/21.
//  Copyright (c) 2015年 翁燚明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCollectionViewCell.h"
@interface DetailViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (strong, nonatomic) id detailItem;
@property (strong,nonatomic)  NSMutableArray *colors;
@property (nonatomic,assign) BOOL coundbeDel;
@end

