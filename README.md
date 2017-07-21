# Transparent & gradient navBar color

Inspired by [WHAddVC](https://github.com/remember17/WHAddVC). This demo demonstrates how to make the transparent navigation bar and gradient color changing in scrollView. And use [UIScrollView+PullBig](https://github.com/you520t/PullBig) to implement the function which make the image scaling when dragging down on the top of scrollView.

受[WHAddVC](https://github.com/remember17/WHAddVC)的启发，本人封装了透明导航栏+颜色渐变的基类控制器，并使用[UIScrollView+PullBig](https://github.com/you520t/PullBig)实现scrollView下拉放大图片的功能。

## Usage

You can easily use it by subclassing YFBaseViewController, then conform UIScrollViewDelegate and all you should do is just below:

子类化YFBaseViewController，并将如下代码加入到你的控制其中。

```
- (void)viewDidLoad {
    [super viewDidLoad];
    self.gradBarColorEnabled = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateNavBarAlpha:scrollView.contentOffset];
}
```

#### UIScrollView+PullBig 注意事项

If you use UIScrollView+PullBig in the meantime. Fix the scrollView.contentOffset by subtract the bigView.height.

```
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint fixedPosition = scrollView.contentOffset;
    fixedPosition.y += self.headerHeight;
    [self updateNavBarAlpha:fixedPosition];
}

```

### Want to see more? Clone or download it.

## Furthermore

If you have any issue or some good ideas. Submit a issue on Github or directly mail me at [yesterdayfinder@gmail.com](mailto:yesterdayfinder@gmail.com). Thanks!

## Special Thanks

* [PushSmaller&PullBigger-Demo](https://github.com/Crazy-Steven/PushSmaller-PullBigger-Demo)

* [WHAddVC](https://github.com/remember17/WHAddVC)

* [ScrollViewDemo](http://blog.csdn.net/chen12302asd/article/details/69388150)

