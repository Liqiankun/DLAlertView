//
//  dlAlertView.m
//  dlAlertView
//
//  Created by dl_David on 16/7/27.
//  Copyright © 2016年 dl_David. All rights reserved.
//

#import "DLAlertView.h"

#define contentViewWidthRatio 0.76
#define contentViewWidhtHeightRatio 0.74

#define viewHeight [UIScreen mainScreen].bounds.size.height
#define viewWidth [UIScreen mainScreen].bounds.size.width
#define contentViewWidth (viewWidth * contentViewWidthRatio)
#define contentViewHeight (contentViewWidth / contentViewWidhtHeightRatio)
#define contentViewX (viewWidth - contentViewWidth)/2
#define closeButtonWidthHeight  40
#define closeButtonX  (viewWidth - closeButtonWidthHeight) / 2

typedef void (^Completion)();

@interface DLAlertView ()

@property(nonatomic,strong)UIWindow *alterViewWindow;
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIButton *closeButton;
@property(nonatomic,strong)UIWindow *previousWindow;

-(void)dl_setupNewWindow;
-(void)dl_setupContentView;
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
        [self dl_setupContentView];
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

-(void)dl_setupContentView
{
    UIView *contentView = [[UIView alloc] init];
    self.contentView = contentView;
    [self.view addSubview:self.contentView];
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
    [self.contentView addSubview:self.imageView];
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
    CGFloat marginWidth = 20;
  
    
    CGFloat subViewSpaceWidth = (viewHeight - marginWidth - contentViewHeight - closeButtonWidthHeight) / 2;
    
    [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:5.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.contentView.frame = CGRectMake(contentViewX, subViewSpaceWidth, contentViewWidth, contentViewHeight);
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:5.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.closeButton.frame = CGRectMake(closeButtonX, viewHeight - subViewSpaceWidth - closeButtonWidthHeight, closeButtonWidthHeight, closeButtonWidthHeight);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)dl_subViewsCloseAnimationWithcompletion:(Completion)completion
{

    CGFloat contentViewY = contentViewHeight;
    
    CGFloat closeButtonY = viewHeight;
    
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:8.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.contentView.frame = CGRectMake(contentViewX, -contentViewY, contentViewWidth, contentViewHeight);
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
        self.contentView.alpha = 0.0;
        self.closeButton.alpha = 0.0;
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

#pragma mark - SuperMethod
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGFloat contentViewY = contentViewHeight;
    self.contentView.frame = CGRectMake(contentViewX, -contentViewY, contentViewWidth, contentViewHeight);
    
    if (self.imageView) {
        self.imageView.frame = self.contentView.bounds;
    }

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
