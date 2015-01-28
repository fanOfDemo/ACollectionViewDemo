//
//  DetailViewController.m
//  ABoringDemo
//
//  Created by 翁燚明 on 15/1/21.
//  Copyright (c) 2015年 翁燚明. All rights reserved.
//

#import "DetailViewController.h"
#import "MyCollectionViewCell.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    self.myCollectionView.delegate  = self;
    self.myCollectionView.dataSource = self;
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGesture:)];
    longPressGesture.delegate = self;
    longPressGesture.minimumPressDuration = .3f;
    if(!self.coundbeDel){
        [self.myCollectionView addGestureRecognizer:longPressGesture];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(biger:)];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(biger:)];
    self.navigationItem.rightBarButtonItem = addButton;
    if(!self.colors){
        self.colors = [[NSMutableArray alloc]initWithCapacity:0];
        for(int i = 0; i<5;i++){
            [self.colors addObject:[@{@"color":[UIColor redColor],@"img":[UIImage imageNamed:@"1.jpg"],@"visiable":@"0"} mutableCopy]];
            [self.colors addObject:[@{@"color":[UIColor yellowColor],@"img":[UIImage imageNamed:@"2.jpg"],@"visiable":@"0"} mutableCopy]];
            [self.colors addObject:[@{@"color":[UIColor greenColor],@"img":[UIImage imageNamed:@"3.jpg"],@"visiable":@"0"} mutableCopy]];
            [self.colors addObject:[@{@"color":[UIColor blueColor],@"img":[UIImage imageNamed:@"4.jpg"],@"visiable":@"0"} mutableCopy]];
            [self.colors addObject:[@{@"color":[UIColor grayColor],@"img":[UIImage imageNamed:@"5.jpg"],@"visiable":@"0"} mutableCopy]];
        }
    }
    self.coundbeDel = NO;//app删除按钮为隐藏状态
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.myCollectionView reloadData];
    });
    [self configureView];
}



- (void)longPressGesture:(UILongPressGestureRecognizer *)pressGesture{
    if(self.coundbeDel){
        return;
    }
    if(pressGesture.state == UIGestureRecognizerStateBegan){
        CGPoint point = [pressGesture locationInView:self.myCollectionView];
        NSIndexPath * indexPath = [self.myCollectionView indexPathForItemAtPoint:point];
        if(indexPath == nil) return;
        
        for (NSDictionary *dic in self.colors) {
            [dic setValue:@"1" forKey:@"visiable"];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myCollectionView reloadData];
            [self.myCollectionView.collectionViewLayout invalidateLayout];
            [self BeginWobble];
        });
    }
}

//开始抖动动画
-(void)BeginWobble
{
    for (UIView *view in self.view.subviews)
    {
        for (UIView *v in view.subviews)
        {
            if([view.subviews count]==1){
                return;
            }
            if ([v isMemberOfClass:[MyCollectionViewCell class]]){
                MyCollectionViewCell *cell = (MyCollectionViewCell *)v;
                    srand([[NSDate date] timeIntervalSince1970]);
                    float rand=(float)random();
                    CFTimeInterval t=rand*0.0000000001;
                    [UIView animateWithDuration:0.1 delay:t options:0  animations:^
                     {
                         cell.transform=CGAffineTransformMakeRotation(-0.02);
                     } completion:^(BOOL finished)
                     {
                         [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse|UIViewAnimationOptionAllowUserInteraction  animations:^
                          {
                                cell.transform=CGAffineTransformMakeRotation(0.02);
                          } completion:^(BOOL finished) {}];
                     }];
            }
        }
    }
    self.coundbeDel = YES;
}
//结束抖动动画
-(void)EndWobble
{
    for (UIView *view in self.view.subviews)
    {
        for (UIView *v in view.subviews)
        {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^
         {
             v.transform=CGAffineTransformIdentity;
         } completion:^(BOOL finished) {}];
        }
    }
     self.coundbeDel = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma  mark UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.colors count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.colors objectAtIndex:indexPath.row];
     static NSString * CellIdentifier = @"myCell";
     MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    if(cell == nil){
        cell = [MyCollectionViewCell cell];
    }
    cell.menuName.textColor =  [dic valueForKey:@"color"];
    cell.menuName.text = [self.detailItem description];
    cell.icon.image  = [dic valueForKey:@"img"];
    if([[dic valueForKey:@"visiable"] integerValue]== 0){
        cell.btn.hidden = YES;
    }else{
        cell.btn.hidden = NO;
        cell.btn.tag = indexPath.row;
        [cell.btn addTarget:self action:@selector(biger:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didDeselectItemAtIndexPath");
    if( self.coundbeDel){
        [self changBtn];
    }
    
}

////定义每个UICollectionView 的 margin
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(10, 14, 0, 8);
//}

- (void)changBtn{
    for (NSDictionary *dic in self.colors) {
        [dic setValue:@"0" forKey:@"visiable"];
    }
   [self.myCollectionView reloadData];
        [self.myCollectionView.collectionViewLayout invalidateLayout];
        [self EndWobble];
   
}

- (void)biger:(id)sender{
    UIButton *btn = sender;
    [self.colors removeObjectAtIndex:btn.tag];
    [self changBtn];
}
@end
