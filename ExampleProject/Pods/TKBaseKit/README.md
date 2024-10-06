## TKBaseKit
简介：常用的工具类集成框架！




## 最新 - TKBaseKit快速添加依赖：

⚠️⚠️警告：由于该项目使用了特定用户的三方库，所以需要导入指定用户的三方库。

1. 两个模块都使用了，直接导入：
```
pod 'TKBaseKit', '2.2.3'  

pod 'GTMBase64'       ,:git => 'https://github.com/ctsfork/GTMBase64.git'  
pod 'Masonry'         ,:git => 'https://github.com/ctsfork/Masonry.git'             
pod 'YYModel'         ,:git => 'https://github.com/ctsfork/YYModel.git'    
pod 'AFNetworking'    ,:git => 'https://github.com/ctsfork/AFNetworking.git'

pod 'MJRefresh'       #,'~> 3.7.9'   
pod 'MBProgressHUD' 
```
使用方式:
```
#import <TKBaseKit.h>
或者
#import <TKSDKUniversal/TKSDKUniversal.h>
#import <TKSDKTool/TKSDKTool.h>
```

2. 只使用TKSDKUniversal模块，直接导入：
```
pod 'TKBaseKit/TKSDKUniversal'
```
使用方式:
```
#import <TKSDKUniversal/TKSDKUniversal.h>
```
⚠️⚠️警告：
1. 如果使用了MJRefresh并且版本 >= 3.7.7+，那么项目最低目标版本为iOS12
2. 目前使用了一个公共Privacy模块用于存放PrivacyInfo.xcprivacy隐私清单，然后TKSDKUniversal与TKSDKTool模块同时依赖他。
如果后期开发使用时出现隐私错误，可以为两个模块分别绑定隐私清单，因为该框架是同时集成了两个动态XCFramework静态框架。




## ⚠️⚠️说明： 
1. 注意：使用时最好固定到某个具体的版本,因为这只是一个自用的SDK，版本之间可能会有大改。
2. v2.2.3版本支持Xcode14, iOS版本支持切换到11.0+。
3. 对内置的部分三方库引用切换到了ctsfok用户的fork版本；因为这些fork项目对原项目进行了一些维护。
```
YYModel:
主分支：
pod 'YYModel', :git => 'https://github.com/ctsfork/YYModel.git'
指定tag：
pod 'YYModel', :git => 'https://github.com/ctsfork/YYModel.git', :tag => '1.2.0'

Masonry:
主分支：
pod 'Masonry', :git => 'https://github.com/ctsfork/Masonry.git'
指定tag：
pod 'Masonry', :git => 'https://github.com/ctsfork/Masonry.git', :tag => '1.2.0'

GTMBase64:
主分支：
pod 'GTMBase64', :git => 'https://github.com/ctsfork/GTMBase64.git'
指定tag：
pod 'GTMBase64', :git => 'https://github.com/ctsfork/GTMBase64.git', :tag => '1.0.2'

AFNetworking:
主分支：
pod 'AFNetworking', :git => 'https://github.com/ctsfork/AFNetworking.git'
指定tag：
pod 'AFNetworking', :git => 'https://github.com/ctsfork/AFNetworking.git', :tag => '4.0.2'
```
4. 内部引用的原作者官方三方库三方库（作者在维护），包含：
```
pod 'MJRefresh',  '~> 3.7.9'
pod 'MBProgressHUD'
```
5. ⚠️⚠️如果使用了MJRefresh版本 >= 3.7.7+，那么项目最低的iOS版本为iOS 12.0





## 功能说明：
该静态框架主要封装了一些常用的工具，以及一些三方框架的二次封装；其中又分为两个框架分别为：
* TKSDKUniversal：通用基础库Framework封装
* TKSDKTool：对一些三方框架进行了二次封装如：AFNetworking，MJRefresh等，具体请查看TKSDKTooImportSDK.h文件




## 使用说明

1. CocoaPods方式：
```
//全部引入
pod 'TKBaseKit', '2.2.3'    

使用：直接导入下列头文件即可：
#import <TKBaseKit.h>


//按模块引入
pod 'TKBaseKit/TKSDKUniversal'
pod 'TKBaseKit/TKSDKTool'

使用：导入对应静态库的头文件即可：
#import <TKSDKUniversal/TKSDKUniversal.h>
#import <TKSDKTool/TKSDKTool.h>
```
2. 手动添加
```
//全部引入
将TKBaseKit中的所有文件加入项目中


//按模块引入
TKSDKUniversal.xcframework
TKSDKTool.xcframework
TKSDKTool.bundle

然后按需导入对应静态库的头文件：
#import <TKSDKUniversal/TKSDKUniversal.h>
#import <TKSDKTool/TKSDKTool.h>


然后对项目进行设置：
1.  设置"Other Linker Flags"-->添加: -ObjC 
2.  将Build Settings中的Allow Non-modular Includes In Framework Modules设为YES
3.  将Build Settings中的 "Excluded Architectures" --> "Release" --> 选中 --> "Any iOS Simulator SDK", 为其添加："arm64"。 即排除模拟器arm64架构的生成。
注意：第3项可以根据情况不设置，即直接使用XCFramework。
```
3. 内置依赖三方库添加，如果不使用TKSDKTool框架可不添加三方依赖，因为只有TKSDKTool内置了的三方依赖库
```
    pod 'MJRefresh',     '~> 3.7'
    pod 'MBProgressHUD'
    pod 'YYModel', :git => 'https://github.com/ctsfork/YYModel.git'
    pod 'Masonry', :git => 'https://github.com/ctsfork/Masonry.git'
    pod 'GTMBase64', :git => 'https://github.com/ctsfork/GTMBase64.git'
    pod 'AFNetworking', :git => 'https://github.com/ctsfork/AFNetworking.git', :tag => '4.0.2'
```




## Frameworks的制作与测试
1. 制作framework:直接创建framework项目即可，framework可分为动态库和静态库；
```
可以通过Build Settings -> Mach-O Type 更改framework的类型。
一般可选为： "Static Library", "Dynamic Library"
```
2. 同工作空间的其它项目测试framework的相关配置：
```
在测试项目中需要进行以下配置才能进行正确的测试

1. Build Settings ->  Other Linker Flags 中添加：
    1. -ObjC
    2. -all_load
    3. $(inherited)
    4. Framework(.framework类型的动/静态库)
        -framework 
        "TKSDKUniversal"
       Static Library(.a类型的静态库)    
        -l"Masonry"
    说明：
        1,2项用于加载静态库中比如类别，IBInspectable，IB_DESIGNABLE设计的类，如果不加则在项目中可能找不到相关类。
        3项用于自动加载一些如Cocospods管理的一些配置，推荐默认可以加上。
        4项用于加载动静态库，如果没有该设置，那么在测试项目中将找不到对应的库。它们加载库的区别：-framework用于加载Framework类型的库，-l"xx"用于加载.a类型的库。

2. Build Settings -> Framework Search Paths
    说明：如果要加载一些其他的库时出现找不到的情况时需要再该项中配置对应framework的搜索路径。
    注意：默认不需要配置只有出现前面的问题才配置。


3. General -> Frameworks,Libraries,and Embedded Content
    说明：该项用于将其他的库(Frameworks)嵌入该项目中。
    1. 不使用Cocospods管理项目:
        1.将需要测试的framework添加到该项；
        2.注意被嵌入的framework的签名方式(这跟Framework目标的Signing & Capabilities项中是否开启签名有关)，
        一般可设置为：“Do Not Embed”, "Embed Sign"。可根据项目具体情况设置。
        如果这两项设置有问题一遍表现为：无法安装(提示签名错误)，程序运行崩溃(提示找不到对应的framework)。

    2. 使用Cocospods管理项目:
        可不做配置直接使用默认即可(也有可能需要按1的方式进行配置)。

    注意：是否使用Cocospods管理项目会对这项配置有影响，如果配置不正确可以同时试试上面配置，已找到正确的配置，   
```





## TKSDKUniversal介绍

* **并未全部列出，可自行查看框架**

* TKSDKUniversalMacro.h：定义了一些常用的宏。
> ***


* View：一些自定义控件
> * **TKSDKNavigationBar**：自定义导航条
>>>  导航条区域主要分为：navView和statusBarView，导航条的整体高度为这两个区域的高度和。\
>>>  navView:有效导航区域区域，默认高度44。\
>>>  statusBarView:状态栏安全区域。 \
>>>  backgroundView:整个导航条最底部的背景图显示区域，和整个导航条的bounds保持一致。\
>>>  navViewBackgroundView：navView中底部的背景图显示区域.\
>>>  注：导航条中的所有子控件(navView除外)都是采用懒加载的方式。\
>>>    \
>>>  PS：instanceWithController:方法构建的导航条都是依赖于controller中的TopLayoutGuide.bottom进行约束的， 约束条件是导航条底部(NavigationBar.bottom)相对于TopLayoutGuide.bottom进行约束的。


> * **TKSDKXibView**：利用xib文件创建View（可以直接使用init方法创建）,并且创建的View也可以作为另一个Xib的子控件。说明：xib文件的名称要有类名保持一致。
>>>  绑定方式：直接绑定到xib文件的Fiel's Owner 的class上面。\
>>>  作为子控件：本方创建的Xib控件可以直接在StoryBorad上面作为子控件使用，使用方式->直接绑定对应view的class即可。\
>>>  注意：本类是直接在控件中添加了一层View并与之绑定，如果要像一般控件那样操作self.view.XXX，请直接操作self.xibChildView.XXX


> * **TKFPSLabel**：一个实时显示FPS的控件。
> ***

* Controller：一些控制器
> * **TKSDKNavigationController**：自定义导航控制器。

> * **TKSDKViewController**：自定义UIViewController视图控制器，支持自定义导航条，以及一些常用操作。

> * **TKSDKTableViewController**：自定义UITableViewController视图控制器，支持自定义导航条，以及一些常用操作。注意：使用新建的"selfView"视图替换原始的self.view，使用时注意self.view与self.tableView的区别。

> * **TKSDKCollectionViewController**：自定义UICollectionViewController视图控制器，支持自定义导航条，以及一些常用操作。注意：使用新建的"selfView"视图替换原始的self.view，使用时注意self.view与self.collectionView的区别。

> * **TKSDKListViewController**：自定义TKSDKViewController + UITableView实现与TKSDKTableViewController类似的功能。

> * **TKSDKGridViewController**：自定义TKSDKViewController + UITCollectionView实现与TKSDKCollectionViewController类似的功能。
>>
>> 注意：如果在使用自定义控制器时出现导航条被遮挡的情况时，请执行[self makeNavigationBarToFront],使TKNavigationBar始终保持在最上层。\
>>      或者直接使用addSubView:方法向self.view上添加新视图，并且总能使TKNavigationBar保持在最上层。


> ***
* Category：一些类别扩展

> * **UIView+TKSDK**：包括但不限于 ==> 可获取当前UIView所在的控制器

> * **UIApplication+TKSDK**：包括但不限于 ==> 可获取当前显示的控制器

> * **NSObject+TKSDK**：

> * **NSString+TKSDK**：

> * **UIButton+TKSDK**：

> * **UIColor+TKSDK**：

> * **UIDevice+TKSDK**：

> * **UIImage+TKSDK**：
> ***


* Utilities：一些工具类

> * **TKSDKClearManager**：缓存清理工具






## TKSDKTool介绍

* TKSDKAFNetworkTool：AFNetworking二次封装。
* TKSDKRefresh：MJRefresh二次封装
* TKSDKEncryptTool：常用加密解密工具



