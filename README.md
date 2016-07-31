![](https://github.com/Liqiankun/DLAlertView/raw/master/DLAlertView.png)
#How to use
```oc
   DLAlertView *alertView = [[DLAlertView alloc] initWithWithImage:[UIImage imageNamed:@"typewriter"] clickCallBack:^{
       NSLog(@"clickCallBack");
   } andCloseCallBack:^{
      NSLog(@"andCloseCallBack");
   }];
   [alertView show];
```
![](https://github.com/Liqiankun/DLAlertView/raw/master/DLAlertView.gif)
