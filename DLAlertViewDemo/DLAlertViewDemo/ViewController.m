//
//  ViewController.m
//  DLAlertViewDemo
//
//  Created by FT_David on 16/7/27.
//  Copyright © 2016年 FT_David. All rights reserved.
//

#import "ViewController.h"
#import "DLAlertView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    DLAlertView *alertView = [[DLAlertView alloc] initWithNewWindowWithClickCallBack:^{
        NSLog(@"ClickCallBack");
    } andCloseCallBack:^{
        NSLog(@"CloseCallBack");
    }];
    
    [alertView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
