![](https://github.com/Liqiankun/DLAlertView/raw/master/DLAlertView.png)
One simple alertView supports text,image,imgaes.<br>
一个支持文字，图片和多张图片的弹出框。<br>
![](https://github.com/Liqiankun/DLAlertView/raw/master/DLAlertView.gif)
#Features
- [x] Easy to use
- [x] Support text,image,images
- [x] 使用简单
- [x] 同时支持文字，图片和多图

#How to use
```oc
//ImageView
   DLAlertView *alertView = [[DLAlertView alloc] initWithWithImage:[UIImage imageNamed:@"typewriter"] clickCallBack:^{
       NSLog(@"clickCallBack");
   } andCloseCallBack:^{
      NSLog(@"andCloseCallBack");
   }];
   [alertView show];
   
//TextView
 DLAlertView * alertView = [[DLAlertView alloc] initWithWithText:@"DLAlertView一个简单但是体验还不错的AlertView。使用简单，支持图片和文字两种形式。" font:[UIFont systemFontOfSize:16] textColor:[UIColor lightGrayColor] clickCallBack:^{
    } andCloseCallBack:^{
    }];
    [alertView show];
    
//ScrollView
NSArray *images = @[@"01",@"02",@"03",@"04",@"05"];
    DLAlertView *alertView = [[DLAlertView alloc] initWithWithImages:images clickCallBack:^{
    } andCloseCallBack:^{
    }];
    [alertView show];
```

#Requirements
- Xcode 7.0 or greater
- iOS8.0(manually only) or greater

#Author
David Lee, qiankunli@yahoo.com
