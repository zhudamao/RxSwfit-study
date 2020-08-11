RxSwift Demo
===========
**MVVM的使用**
>![MvvM](https://upload-images.jianshu.io/upload_images/7271477-2ca171b7c279953f.png)


个人对RxSwift 的使用
--------
# 主要包括三个页面
  1.使用RxSwift 实现列表的上拉加载更多，下拉刷新
  -----
  ### 其中使用 [RxSwiit](https://github.com/ReactiveX/RxSwift) [RxCocoa]() [ObjectMapper](https://github.com/bmoliveira/Moya-ObjectMapper) [MJRefresh](https://github.com/CoderMJLee/MJRefresh) [RxDataSource](https://github.com/RxSwiftCommunity/RxDataSources)  [SnapKit](https://github.com/SnapKit/SnapKit) [Moya](https://github.com/Moya/Moya) [Reusable](https://github.com/AliSoftware/Reusable)

  2.使用UITextField模拟实现动态搜索功能
  ------
  ### 其中的坑是API返回的字符串数组,要重新实现字符串映射功能。
  -----
  ## 3.主要模拟实现登录注册功能
  ### 综合应用各种 信号处理，实现信号的输入--->输出 满足前台的展示 一般情况下状态序列使用Driver 事件序列选用Signal（同样用drive去驱动）
  ----
```Swift

		let tick = input.codeBtn.throttle(0.5, scheduler: MainScheduler.instance).flatMap{ _ -> Observable<Int> in
				return Observable<Int>.timer(0, period: 1, scheduler: MainScheduler.instance).map { (a) -> Int in
						return timer - a
					}.filter{ $0 >= 0}
			}
```

```Swift 
    init (
      input: (
        userName: Driver<String>,
        password: Driver<String>,
        loginTaps: Signal<Void>

      ),dependency:(

      )
    )
```

Installation 
------------

The easiest way to run this Demo , Just do next someting:

   1. git clone

   2. pod install 

   3. run 


    
