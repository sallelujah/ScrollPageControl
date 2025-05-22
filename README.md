# ScrollPageControl
![Demo Image](https://github.com/lawrencehjf/ScrollPageControl/blob/dev/no13.gif)

## 注意 (Attention)
此项目 Fork 自 [jasnig 的 ScrollPageView](https://github.com/jasnig/ScrollPageView)，并已优化至 Swift 4.0 版本。  
This repo is forked from jasnig's ScrollPageView and optimized to Swift 4.0.

---

## 更新内容 (What's New)

### 1. 基于 Swift 4.0 的最新版本  
Latest version based on Swift 4.0.

### 2. 优化底部滚动条动画  
Optimized scroll line animation when showing the bottom scroll line under the scroll title.  
- 实现类似微博 Tab 切换的渐变拉伸效果。

### 3. 新增时间选择器效果 Demo  
New demo for combining time picker effect.  
- 在对比两个时间（例如 "13:30"）时，采用 Swift 的元组进行时间比较，提升了开发效率。  
- 详情参考：[Stack Overflow 上的解答](https://stackoverflow.com/questions/41646542/how-do-you-compare-just-the-time-of-a-date-in-swift)（答案 4）。  

---

## 待优化 (TODO)
1. **问题描述**  
   当前框架中，当页面索引变化时，子控制器需通过监听通知来执行响应操作。然而：
   - 原框架虽然提供了 `contentViewDidEndMoveToIndex:` 方法，但扩展的默认实现强制引入了通知机制。
   - 多次使用此框架可能导致多个子控制器监听同一通知，从而引发误操作。

2. **优化目标**  
   希望后续能够：
   - 移除冗余的通知机制。
   - 提供更优雅的页面切换处理逻辑。

---