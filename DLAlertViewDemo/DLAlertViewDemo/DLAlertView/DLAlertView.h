//
//  FTAlertView.h
//  FTAlertView
//
//  Created by FT_David on 16/7/27.
//  Copyright © 2016年 FT_David. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CloseCallBack)();
typedef void(^ClickCallBack)();

@interface DLAlertView : UIViewController

@property(nonatomic,copy)CloseCallBack closeCallBack;
@property(nonatomic,copy)ClickCallBack clickCallBack;
-(instancetype)initWithNewWindowWithClickCallBack:(ClickCallBack)clickCallBack andCloseCallBack:(CloseCallBack)closeCallBack;
-(void)show;
@end
