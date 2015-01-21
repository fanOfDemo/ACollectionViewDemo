//
//  DetailViewController.h
//  ABoringDemo
//
//  Created by 翁燚明 on 15/1/21.
//  Copyright (c) 2015年 翁燚明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

