//
//  dlAlertView.m
//  dlAlertView
//
//  Created by dl_David on 16/7/27.
//  Copyright © 2016年 dl_David. All rights reserved.
//

#import "DLAlertView.h"
#define ImageViewWidthRatio 0.76
#define ImageViewWidhtHeightRatio 0.74

typedef void (^Completion)();
@interface DLAlertView ()

@property(nonatomic,strong)UIWindow *alterViewWindow;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIButton *closeButton;
@property(nonatomic,strong)UIWindow *previousWindow;

-(void)dl_setupNewWindow;
-(void)dl_setupImageView;
-(void)dl_setupCloseButton;
-(void)dl_setupViewColor:(UIColor *)color completion:(Completion)completion;
-(void)dl_subViewsShowAnimation;
-(void)dl_subViewsCloseAnimationWithcompletion:(Completion)completion;
-(void)dl_clickViewsHideAnimation;
@end

@implementation DLAlertView

-(instancetype)initWithNewWindowWithClickCallBack:(ClickCallBack)clickCallBack andCloseCallBack:(CloseCallBack)closeCallBack
{
    if (self = [super init]) {
        [self dl_setupNewWindow];
        [self dl_setupImageView];
        [self dl_setupCloseButton];
        
        self.clickCallBack = clickCallBack;
        self.closeCallBack = closeCallBack;
        
        self.view.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark - PrivateMethod
-(void)dl_setupNewWindow
{
    UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    alertWindow.windowLevel = UIWindowLevelAlert;
    alertWindow.backgroundColor = [UIColor clearColor];
    alertWindow.rootViewController = self;
    self.alterViewWindow = alertWindow;
}

-(void)dl_setupImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = [UIImage imageNamed:@"typewriter"];
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = 5;
    UITapGestureRecognizer *tapGresture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapAction)];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:tapGresture];
    self.imageView = imageView;
    [self.view addSubview:self.imageView];
}

-(void)dl_setupCloseButton
{
    UIButton *closeButton = [[UIButton alloc] init];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.closeButton = closeButton;
    [self.view addSubview:self.closeButton];
    
}

-(void)dl_setupViewColor:(UIColor *)color completion:(Completion)completion{
    [UIView animateWithDuration:0.5 animations:^{
        self.view.backgroundColor = color;
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

-(void)dl_subViewsShowAnimation
{
 
    CGFloat viewHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat viewWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat marginWidth = 0;
    
    CGFloat imageViewWidth = viewWidth * ImageViewWidthRatio;
    CGFloat imageViewHeight = imageViewWidth / ImageViewWidhtHeightRatio;
    CGFloat imageViewX = (viewWidth - imageViewWidth)/2;
    
    CGFloat closeButtonWidthHeight = 40;
    CGFloat closeButtonX = (viewWidth - closeButtonWidthHeight) / 2;
    
    CGFloat subViewSpaceWidth = (viewHeight - marginWidth - imageViewHeight - closeButtonWidthHeight) / 2;
    
    [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:8.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.imageView.frame = CGRectMake(imageViewX, subViewSpaceWidth, imageViewWidth, imageViewHeight);
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:10.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.closeButton.frame = CGRectMake(closeButtonX, viewHeight - subViewSpaceWidth, closeButtonWidthHeight, closeButtonWidthHeight);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)dl_subViewsCloseAnimationWithcompletion:(Completion)completion
{
    CGFloat viewHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat viewWidth = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat imageViewWidth = viewWidth * ImageViewWidthRatio;
    CGFloat imageViewHeight = imageViewWidth / ImageViewWidhtHeightRatio;
    CGFloat imageViewX = (viewWidth - imageViewWidth)/2;
    CGFloat imageViewY = imageViewHeight;
    
    CGFloat closeButtonWidthHeight = 40;
    CGFloat closeButtonX = (viewWidth - closeButtonWidthHeight) / 2;
    CGFloat closeButtonY = viewHeight;
    
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:8.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.imageView.frame = CGRectMake(imageViewX, -imageViewY, imageViewWidth, imageViewHeight);
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
    
    [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:10.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.closeButton.frame = CGRectMake(closeButtonX, closeButtonY, closeButtonWidthHeight, closeButtonWidthHeight);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)dl_clickViewsHideAnimation
{
    [UIView animateWithDuration:0.5 animations:^{
        self.imageView.alpha = 0.0;
        self.closeButton.alpha = 0;
    }];

}
-(void)imageViewTapAction
{
    __weak typeof(self) weakSelf = self;
    [self dl_clickViewsHideAnimation];
     [self dl_setupViewColor:[UIColor clearColor] completion:^{
         [weakSelf.alterViewWindow setHidden:YES];
         weakSelf.alterViewWindow = nil;
         [weakSelf.previousWindow makeKeyAndVisible];
         
         if (self.clickCallBack) {
             self.clickCallBack();
         }
     }];
}

-(void)closeButtonAction
{
    __weak typeof(self) weakSelf = self;
    [self dl_setupViewColor:[UIColor clearColor] completion:nil];
    
    [self dl_subViewsCloseAnimationWithcompletion:^{
        [weakSelf.alterViewWindow setHidden:YES];
        weakSelf.alterViewWindow = nil;
        [weakSelf.previousWindow makeKeyAndVisible];
        
        if (weakSelf.closeCallBack) {
            weakSelf.closeCallBack();
        }
    }];

}

#pragma mark - PublicMethod
-(void)show
{
    __weak typeof(self) weakSelf = self;
    self.previousWindow = [UIApplication sharedApplication].keyWindow;
    [self.alterViewWindow makeKeyAndVisible];
    [self dl_setupViewColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5] completion:^{
        [weakSelf dl_subViewsShowAnimation];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGFloat viewHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat viewWidth = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat imageViewWidth = viewWidth * ImageViewWidthRatio;
    CGFloat imageViewHeight = imageViewWidth / ImageViewWidhtHeightRatio;
    CGFloat imageViewX = (viewWidth - imageViewWidth)/2;
    CGFloat imageViewY = imageViewHeight;
    self.imageView.frame = CGRectMake(imageViewX, -imageViewY, imageViewWidth, imageViewHeight);
    
    CGFloat closeButtonWidthHeight = 40;
    CGFloat closeButtonX = (viewWidth - closeButtonWidthHeight) / 2;
    CGFloat closeButtonY = viewHeight;
    self.closeButton.frame = CGRectMake(closeButtonX, closeButtonY, closeButtonWidthHeight, closeButtonWidthHeight);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will odlen want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
