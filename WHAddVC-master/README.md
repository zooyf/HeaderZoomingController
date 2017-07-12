# WHAddVC
一行代码创建的控制器带有这些效果：下拉放大图片, 导航栏颜色渐变, 添加子控制器, 左右滑动同时按钮跟着切换

### gif效果图
 ![img](https://github.com/remember17/WHAddVC/blob/master/img-folder/example.gif)

## 使用方法
创建WHAddVC控制器的代码如下
```objc
// 一行代码创建WHAddVC
WHAddVC *addVC = [WHAddVC addVCWithTitle:@"TEST" topImage:[UIImage imageNamed:@"test"] chooseTitles:@[@"One",@"Two",@"Three"] chooseControllers:@[@"FirstViewController",@"SecondViewController",@"ThirdViewController"]];
```
下面是更详细的每个参数说明
```objc
/**
 快速创建WHAddVC

 @param title 导航栏标题
 @param topImage 顶部图片
 @param chooseTitles 中间三个按钮的文字(字符串数组)
 @param chooseControllers 三个控制器名字(字符串数组)
 @return WHAddVC
 */
+ (WHAddVC *)addVCWithTitle:(NSString *)title topImage:(UIImage *)topImage chooseTitles:(NSArray *)chooseTitles chooseControllers:(NSArray *)chooseControllers;
```
其中数组chooseControllers需要是已经创建好了的三个控制器的名字，字符串形式，方法里会根据传入的字符串自动转换为类，自动初始化控制器并加入到下方可滑动切换的界面里。
WHAddVC还带有一个BOOL类型的属性可供设置。
```objc
/** 顶部图片模糊效果,YES模糊,NO不模糊,默认不模糊 */
@property (nonatomic, assign) BOOL blur;
```
你可以这样操作：
```objc
// 一行代码创建WHAddVC
WHAddVC *addVC = [WHAddVC addVCWithTitle:@"TEST" topImage:[UIImage imageNamed:@"test"] chooseTitles:@[@"One",@"Two",@"Three"] chooseControllers:@[@"FirstViewController",@"SecondViewController",@"ThirdViewController"]];

// 设置blur属性，给顶部图片添加模糊效果
addVC.blur = YES;
```

#### MIT LICENSE 
