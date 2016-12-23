//
//  DLAlertView.m
//  DLAlertView
//
//  Created by David on 16/7/27.
//  Copyright © 2016年 David. All rights reserved.
//

#import "DLAlertView.h"
#import "NSString+SIZEOFSTRING.h"
#import "UIImageView+WebCache.h"

#define contentViewWidthRatio 0.76
#define contentViewWidhtHeightRatio 0.74

#define viewHeight [UIScreen mainScreen].bounds.size.height
#define viewWidth [UIScreen mainScreen].bounds.size.width

typedef void (^Completion)();

@interface DLAlertView ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIWindow *alterViewWindow;
@property(nonatomic,strong)UIWindow *previousWindow;
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIPageControl *pageControl;
@property(nonatomic,strong)NSMutableArray<UIImageView *> *imageViewArray;
@property(nonatomic,strong)UIButton *closeButton;
@property(nonatomic,copy)NSString *textViewText;
@property(nonatomic,strong)UIFont *textFont;

@property(nonatomic,assign)CGFloat contentViewWidth;
@property(nonatomic,assign)CGFloat contentViewHeight;
@property(nonatomic,assign)CGFloat contentViewX;
@property(nonatomic,assign)CGFloat marginWidth;
@property(nonatomic,assign)CGFloat subViewSpaceWidth;
@property(nonatomic,assign)CGFloat closeButtonWidthHeight;
@property(nonatomic,assign)CGFloat closeButtonX;
@property(nonatomic,assign)CGFloat textViewMargin;

-(void)dl_setupNewWindow;
-(void)dl_setupFrameNumber;
-(void)dl_setupContentView;
-(void)dl_setupImageViewWithImage:(UIImage *)image;
-(void)dl_setupScrollViewWithImages:(NSArray *)images;
-(void)dl_setupTextViewWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor;
-(void)dl_setupCloseButton;
-(void)dl_setupViewColor:(UIColor *)color completion:(Completion)completion;
-(void)dl_subViewsShowAnimation;
-(void)dl_subViewsCloseAnimationWithcompletion:(Completion)completion;
-(void)dl_clickViewsHideAnimation;

-(CGSize)dl_getTextViewSize;
-(void)dl_configTextView;
-(void)dl_configScrollView;
-(void)dl_setupSubViewsFrame;

@end

@implementation DLAlertView

-(instancetype)initWithWithImage:(UIImage *)image clickCallBack:(ClickCallBack)clickCallBack andCloseCallBack:(CloseCallBack)closeCallBack;
{
    if (self = [super init]) {
        [self dl_setupNewWindow];
        [self dl_setupFrameNumber];
        [self dl_setupContentView];
        [self dl_setupImageViewWithImage:image];
        [self dl_setupCloseButton];
        [self dl_setupSubViewsFrame];
        
        self.clickCallBack = clickCallBack;
        self.closeCallBack = closeCallBack;
        
        self.view.backgroundColor = [UIColor clearColor];
        self.view.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(instancetype)initWithWithImages:(NSArray *)images clickCallBack:(ClickCallBack)clickCallBack andCloseCallBack:(CloseCallBack)closeCallBack
{
    if (self  = [super init]) {
        [self dl_setupNewWindow];
        [self dl_setupFrameNumber];
        [self dl_setupContentView];
        [self dl_setupScrollViewWithImages:images];
        [self dl_setupCloseButton];
        [self dl_setupSubViewsFrame];
        
        self.clickCallBack = clickCallBack;
        self.closeCallBack = closeCallBack;
        
        self.view.backgroundColor = [UIColor clearColor];
        self.view.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

-(instancetype)initWithWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor clickCallBack:(ClickCallBack)clickCallBack andCloseCallBack:(CloseCallBack)closeCallBack
{
    if (self = [super init]) {
        [self dl_setupNewWindow];
        [self dl_setupFrameNumber];
        [self dl_setupContentView];
        [self dl_setupTextViewWithText:text font:font textColor:textColor];
        [self dl_setupCloseButton];
        [self dl_setupSubViewsFrame];
        
        self.clickCallBack = clickCallBack;
        self.closeCallBack = closeCallBack;
        
        self.view.backgroundColor = [UIColor clearColor];
        self.automaticallyAdjustsScrollViewInsets = NO;
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

-(void)dl_setupFrameNumber
{
    self.contentViewWidth  = (viewWidth * contentViewWidthRatio);
    self.contentViewHeight =  (self.contentViewWidth / contentViewWidhtHeightRatio);
    self.contentViewX =  (viewWidth - self.contentViewWidth)/2;
    self.closeButtonWidthHeight = 40;
    self.closeButtonX = (viewWidth - self.closeButtonWidthHeight) / 2;
    self.textViewMargin = 10;
    self.marginWidth = 20;
    self.subViewSpaceWidth = (viewHeight - self.marginWidth - self.contentViewHeight - self.closeButtonWidthHeight) / 2;
}

-(void)dl_setupContentView
{
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tapGresture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapAction)];
    contentView.userInteractionEnabled = YES;
    contentView.clipsToBounds = YES;
    contentView.layer.cornerRadius = 5;
    [contentView addGestureRecognizer:tapGresture];
    self.contentView = contentView;
    [self.view addSubview:self.contentView];
}

-(void)dl_setupScrollViewWithImages:(NSArray *)images
{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = images.count;
    pageControl.currentPageIndicatorTintColor = [UIColor cyanColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    self.pageControl = pageControl;
    
    self.imageViewArray = [[NSMutableArray alloc] init];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    for (int i = 0 ; i < images.count; i++) {
        id image = images[i];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        if ([image isKindOfClass:[NSString class]]) {
            imageView.image = [UIImage imageNamed:image];
        }else if([image isKindOfClass:[UIImage class]]){
            imageView.image = image;
        }else if([image isKindOfClass:[NSURL class]]){
            [imageView sd_setImageWithURL:image];
        }
        [self.imageViewArray addObject:imageView];
        [scrollView addSubview:imageView];
    }
   
    self.scrollView  = scrollView;
    [self.contentView addSubview:self.scrollView];
    [self.contentView addSubview:self.pageControl];
    
}

-(void)dl_setupImageViewWithImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = image;
    imageView.userInteractionEnabled = YES;
    self.imageView = imageView;
    [self.contentView addSubview:self.imageView];
}

-(void)dl_setupTextViewWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor
{
    UITextView *textView = [[UITextView alloc] init];
    textView.backgroundColor = [UIColor whiteColor];
    textView.editable = NO;
    textView.selectable = NO;
    textView.textAlignment = NSTextAlignmentNatural;
    textView.text = text;
    textView.font = font;
    textView.textColor = textColor;
    self.textFont = font;
    textView.contentInset = UIEdgeInsetsZero;
    textView.scrollIndicatorInsets = UIEdgeInsetsZero;
    textView.contentOffset = CGPointZero;
    textView.textContainerInset = UIEdgeInsetsZero;
    textView.textContainer.lineFragmentPadding = 0;
    textView.showsVerticalScrollIndicator = NO;
    textView.userInteractionEnabled = YES;
    self.textViewText = text;
    self.textView = textView;
    
    [self.contentView addSubview:self.textView];
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
    [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:5.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.contentView.frame = CGRectMake(self.contentViewX, self.subViewSpaceWidth, self.contentViewWidth, self.contentViewHeight);
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:5.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.closeButton.frame = CGRectMake(self.closeButtonX, viewHeight - self.subViewSpaceWidth - self.closeButtonWidthHeight, self.closeButtonWidthHeight, self.closeButtonWidthHeight);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)dl_subViewsCloseAnimationWithcompletion:(Completion)completion
{

    CGFloat contentViewY = self.contentViewHeight;
    
    CGFloat closeButtonY = viewHeight;
    
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:8.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.contentView.frame = CGRectMake(self.contentViewX, -contentViewY, self.contentViewWidth, self.contentViewHeight);
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
    
    [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:10.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.closeButton.frame = CGRectMake(self.closeButtonX, closeButtonY, self.closeButtonWidthHeight, self.closeButtonWidthHeight);
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

-(CGSize)dl_getTextViewSize
{
    CGSize size =  [self.textViewText stringSizeWithFont:self.textFont withMaxWidth:self.contentViewWidth -  2 * self.textViewMargin];
    CGFloat  textStringHeight = size.height;
    if (textStringHeight > self.contentViewHeight) {
        self.textView.scrollEnabled = YES;
        return CGSizeMake(size.width, self.contentViewHeight -  2 * self.textViewMargin);
    }
    self.textView.scrollEnabled = NO;
    return size;
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

-(void)dl_configTextView
{
    CGFloat textStringHeight = [self dl_getTextViewSize].height + 2 * self.textViewMargin;
    self.contentViewHeight = (textStringHeight > self.contentViewHeight ? self.contentViewHeight :textStringHeight);
    self.subViewSpaceWidth =  (viewHeight - self.marginWidth - self.contentViewHeight - self.closeButtonWidthHeight) / 2;
    self.contentView.frame = CGRectMake(self.contentViewX, -self.contentViewHeight, self.contentViewWidth, self.contentViewHeight);
}

-(void)dl_configScrollView
{
    CGFloat scrollViewWidth = self.contentViewWidth -  2 * self.textViewMargin;
    CGFloat scrollViewHeight = self.contentViewHeight - 2 * self.textViewMargin;
    self.scrollView.frame = CGRectMake(self.textViewMargin, self.textViewMargin,scrollViewWidth,scrollViewHeight);
    for (int i = 0; i < self.imageViewArray.count; i++) {
        UIImageView *imageView = self.imageViewArray[i];
        imageView.frame = CGRectMake(scrollViewWidth * i, 0, scrollViewWidth, scrollViewHeight);
    }
    self.scrollView.contentSize = CGSizeMake(self.imageViewArray.count * scrollViewWidth, scrollViewHeight);
    self.pageControl.center = CGPointMake(self.contentViewWidth * 0.5, self.contentViewHeight - 30);
}

-(void)dl_setupSubViewsFrame
{
    CGFloat contentViewY = self.contentViewHeight;
    
    CGFloat closeButtonY = viewHeight;
    self.closeButton.frame = CGRectMake(self.closeButtonX, closeButtonY, self.closeButtonWidthHeight, self.closeButtonWidthHeight);
    
    if (self.imageView) {
        self.contentView.frame = CGRectMake(self.contentViewX, -contentViewY, self.contentViewWidth, self.contentViewHeight);
        self.imageView.frame = self.contentView.bounds;
    }else if(self.textView){
        [self.textView setContentOffset:CGPointZero animated:NO];
        self.textView.frame = (CGRect){{self.textViewMargin, self.textViewMargin}, [self dl_getTextViewSize]};
        [self dl_configTextView];
    }else if(self.scrollView){
        self.contentView.frame = CGRectMake(self.contentViewX, -contentViewY, self.contentViewWidth,self.contentViewHeight);
        [self dl_configScrollView];
    }
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

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.pageControl.currentPage = (int)(page + 0.5);
}

#pragma mark - SuperMethod
- (void)viewDidLoad {
    [super viewDidLoad];
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
