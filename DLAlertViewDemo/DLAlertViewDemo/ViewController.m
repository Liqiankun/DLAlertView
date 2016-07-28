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
    DLAlertView * alertView = [[DLAlertView alloc] initWithWithText:@"感谢您的支持，您将以众筹专享价258元获得市场价199元/件的专业抗菌FT-Shirt四件（男女款、尺码、颜色和数量请在备注中注明需求，男款尺码M/L/XL/XXL/XXXL，女款尺码S/M/L/XL，颜色：黑色/橙色/墨绿/水蓝/）。科技面料，专业抗菌，穿FT-Shirt，清爽一夏。感谢您的支持，您将以众筹专享价258元获得市场价199元/件的专业抗菌FT-Shirt。" font:[UIFont boldSystemFontOfSize:17] textColor:[UIColor lightGrayColor] clickCallBack:^{
        
    } andCloseCallBack:^{
        
    }];
    
    [alertView show];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
