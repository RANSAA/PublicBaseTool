## TKBaseKit
通用基础框架，完整的导航体系,侧滑，自定义导航条等，优秀的AFNetworking,MJRefresh二次封装，使应用更简单!
\
该框架中包含了两个基础框架，它们分别为：
>1.TKSDKUniversal
\
>2.TKSDKTool
\
\
>模块说明：
\
>TKSDKUniversal:为基础框架，包含APP自定义导航，自定义NavBar,以及一些常用的工具类。
\
>TKSDKTool:为二次封装AF网络请求，刷新，加密。该框架引用了一些三方框架。

>查看框架架构命令：
\
>lipo -info 框架中二进制文件的路径

## 注意：至少使用2.1即以上的版本

## 使用说明
1. CocoaPods方式
```
//全部引入
pod 'TKBaseKit', '~> 2.0'
//模块引入
pod 'TKBaseKit/TKSDKUniversal'
pod 'TKBaseKit/TKSDKTool'
```
2. 手动添加
```
第一步：先将如下文件添加到项目中：
    TKSDKUniversal.framework
    TKSDKTool.framework
    TKSDKTool.bundle
第二步：导入三方依赖(匹配指定版本)
      pod 'Masonry'
      pod 'GTMBase64'                        #, '~> 1.0.1'
      pod 'MJRefresh'                        #, '~> 3.3.1'
      pod 'AFNetworking/Serialization'       #, '~> 3.2.1'
      pod 'AFNetworking/Security'            #, '~> 3.2.1'
      pod 'AFNetworking/Reachability'        #, '~> 3.2.1'
      pod 'AFNetworking/NSURLSession'        #, '~> 3.2.1'
      
     **注意：三方依赖库也会持续的更新**
     
第三步：
    1.设置"Other Linker Flags"-->添加: -ObjC 
    2.将Build Settings中的Allow Non-modular Includes In Framework Modules设为YES
```
