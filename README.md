![](https://github.com/Liqiankun/DLAlertView/raw/master/DLAlertView.png)
#How to use
```oc
   DLAlertView *alertView = [[DLAlertView alloc] initWithNewWindowWithClickCallBack:^{
        NSLog(@"ClickCallBack");
    } andCloseCallBack:^{
        NSLog(@"CloseCallBack");
    }];
    [alertView show];
```
![](https://github.com/Liqiankun/DLAlertView/raw/master/DLAlertView.gif)
