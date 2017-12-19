# ScrollPageControl
![image](https://github.com/lawrencehjf/ScrollPageControl/blob/dev/no13.gif)

##Attention（注意）：
	This repo Forked from jasnig's ScrollPageView repo and optimized Swift4.0 version https://github.com/jasnig/ScrollPageView
	此项目是本人之前fork jasnig 的 ScrollPageView 的Swift老版本，并在其基础上更新至4.0的新版本demo。
## What‘s new & different from old version:
	与jasnig的Swift老版本不同之处：
###1、Latest version based on Swift4.0
	基于Swift4.0的最新版本
###2、Optimized scroll line animation
	Optimized scroll line animation when showing bottom scroll line under the scroll title.
	添加优化了显示title文字底部滚动条时的渐变拉伸效果，此灵感来源于微博的tab类似切换效果
###3、New demo for combine time picker effect 
	I add a new demo that combined time picker effect. What's inspired me to share part part code's reason is that: when i tried to compare a couple of time strings (like "13:30"), i found a simple way on Stack Overflow https://stackoverflow.com/questions/41646542/how-do-you-compare-just-the-time-of-a-date-in-swift answers 4.where they teaches me to use Swift's tuple compare the "minute : seconds "time simply. which saves me a lot of time and Improved my programing efficiency
	新添加了一种结合时间选择的更多层次组合的效果，其中最让我想共享这一部分demo之处的原因在于：当我苦苦寻求使用更方便的方式来对比两个时间（类似13:30这种）大小/早晚的时候，我在Stack Overflow上找到了利用Swift中元祖tuple可以比对大小的特性，如此也就开心的完成了对时间数组切割后进行了比对的操作，这个给我带来了当时开发中非常直观的效率提升，所以特意分享出来以期大家能互相更加深入探讨学习Swift，详细参见（https://stackoverflow.com/questions/41646542/how-do-you-compare-just-the-time-of-a-date-in-swift）的answers 第4条使用姿势。

#TODO：
	This project has a Unfriendly defect is that when we scroll change the current page index, the internal sub page(sub ViewController) must add a  observer to know that they should do sth like reload the data. actually there's a protocol method that we can use to know the page changed, but the author extension the protocol's method and given it a default implementation and add another notification to tell sub page to action the index change ,hope the next time i can rewrite it and given a better solution.
	此框架中当每一页面index变化的时候，在告知其中的子控制器的操作感觉不是很好，本来有代理方法可以调用，但是作者选择了extension此协议给其添加了默认实现，转而又添加了一个通知来告知子控制器，导致的结果不言而喻，使用者又得必须再去在子控制器中添加监听（如此感觉就是写的协议方法就作用不大了）。并且这样导致了一个问题就是，比如当我的项目中不止一次使用此框架的时候就出现了多处子控制器监听同一个通知，因此我便在其基础上在发送通知的时候添加了一个parentVC的通知内容，以让每一个子控制器监听者去判断一一对应关系，否则就会出现一处通知，多处监听进行操作的不必要操作情况，后续抽时间可以考虑进行进一步优化一下。



