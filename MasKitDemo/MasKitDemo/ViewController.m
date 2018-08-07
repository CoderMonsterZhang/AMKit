//
//  ViewController.m
//  MasKitDemo
//
//  Created by 张松宇 on 2018/6/6.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "ViewController.h"
#import "AMFlexibleLayoutController+AMAdd.h"
#import "MasNetEaseMusicController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Mas.Kit";
    
    [self registerSection:0 edges:UIEdgeInsetsMake(12, 16, 10, 16)].minimumLineSpacing(16);
    [self addcells:@"MasListCollectionViewCell" section:0 dataSource:@[@"menu1"] cellTouchBlock:^(id data, NSIndexPath *indexPath) { /// action list
        switch (indexPath.item) {
            case 0: {
                MasNetEaseMusicController *netease = NSClassFromString(@"MasNetEaseMusicController").new;
                [self.navigationController pushViewController:netease animated:YES];
            } break;
                
            default:
                break;
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

@end
