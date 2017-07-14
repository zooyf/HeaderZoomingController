# Transparent & gradient navBar color

Inspired by [WHAddVC](https://github.com/remember17/WHAddVC). This demo demonstrates how to make the transparent navigation bar and gradient color changing in scrollView. 

受WHAddVC的启发，本人封装了透明导航栏+颜色渐变的基类控制器。

## Usage

You can easily use it by subclassing YFBaseViewController, then conform UIScrollViewDelegate and all you should do is just below:

子类化YFBaseViewController，并将如下代码加入到你的控制其中。

```
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateNavBarAlpha:scrollView.contentOffset];
}
```

### [ScrollViewDemo](http://blog.csdn.net/chen12302asd/article/details/69388150)

### [PushSmaller&PullBigger-Demo](https://github.com/Crazy-Steven/PushSmaller-PullBigger-Demo)

### [WHAddVC](https://github.com/remember17/WHAddVC)

