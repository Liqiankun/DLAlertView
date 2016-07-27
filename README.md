![](https://github.com/Liqiankun/DLAlertView/raw/master/DLAlertView.gif)
#How to use
```oc
   DLAlertView *alertView = [[DLAlertView alloc] initWithNewWindowWithClickCallBack:^{
        NSLog(@"ClickCallBack");
    } andCloseCallBack:^{
        NSLog(@"CloseCallBack");
    }];
    [alertView show];
```
