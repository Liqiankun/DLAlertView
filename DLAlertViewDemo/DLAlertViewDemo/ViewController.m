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
- (IBAction)imageView:(id)sender {
        DLAlertView *alertView = [[DLAlertView alloc] initWithWithImage:[UIImage imageNamed:@"typewriter"] clickCallBack:^{
            NSLog(@"clickCallBack");
        } andCloseCallBack:^{
            NSLog(@"andCloseCallBack");
        }];
        [alertView show];

}
- (IBAction)textView:(id)sender {
    DLAlertView * alertView = [[DLAlertView alloc] initWithWithText:@"DLAlertView一个简单但是体验还不错的AlertView。使用简单，支持图片和文字两种形式。欢迎大家使用。DLAlertView一个简单但是体验还不错的AlertView。使用简单，支持图片和文字两种形式。欢迎大家使用。DLAlertView一个简单但是体验还不错的AlertView。使用简单，支持图片和文字两种形式。欢迎大家使用。DLAlertView一个简单但是体验还不错的AlertView。使用简单，支持图片和文字两种形式。欢迎大家使用。欢迎大家使用。DLAlertView一个简单但是体验还不错的AlertView。使用简单，支持图片和文字两种形式。欢迎大家使用。DLAlertView一个简单但是体验还不错的AlertView。使用简单，支持图片和文字两种形式。欢迎大家使用。欢迎大家使用。DLAlertView一个简单但是体验还不错的AlertView。使用简单，支持图片和文字两种形式。欢迎大家使用。DLAlertView一个简单但是体验还不错的AlertView。使用简单，支持图片和文字两种形式。欢迎大家使用。" font:[UIFont systemFontOfSize:16] textColor:[UIColor lightGrayColor] clickCallBack:^{
        
    } andCloseCallBack:^{
        
    }];
    
    [alertView show];
}

- (IBAction)scrollView:(id)sender {
    NSArray *images = @[@"01",@"02",@"03",@"04",@"05"];
    DLAlertView *alertView = [[DLAlertView alloc] initWithWithImages:images clickCallBack:^{
        
    } andCloseCallBack:^{
        
    }];
    
    [alertView show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
