# IGListKitDemoSwift
IGListKit的基础延时Demo

# IGListKit
IGListKit是Instagram出的一个基于UICollectionView的数据驱动UI框架，目前在github上有9k+ star，被充分利用在Instagram App上，可以翻墙的同学可以去体验一下，看看Instagram的体验，想想如果那些页面让小明用传统方式实现，那将是什么样的情况。可以这样说，有了IGListKit，任何类似列表的页面UI构建，都将so easy！

首先，得介绍IGList中的几个基本概念。

# ListAdapter
适配器，它将collectionview的dataSource和delegate统一了起来，负责collectionView数据的提供、UI的更新以及各种代理事件的回调。

# ListSectionController

一个 section controller是一个抽象UICollectionView的section的controller对象，指定一个数据对象，它负责配置和管理 CollectionView 中的一个 section 中的 cell。这个概念类似于一个用于配置一个 view 的 view-model：数据对象就是 view-model，而 cell 则是 view，section controller 则是二者之间的粘合剂。

## 示例地址:
https://juejin.cn/post/6844903721596354567

## Github地址:
https://github.com/Instagram/IGListKit
