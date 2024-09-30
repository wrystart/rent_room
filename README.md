# rent_room

## 项目简介

这是一个基于 鸿蒙 API12 开发的移动端租房 App，用户可以使用该应用搜索租房列表、查看房屋详情、预约租房等。

## 工程目录

- AppScope 应用配置
- ets 模块代码
    - api 网路请求
    - components 公共组件
    - constants 常量
    - entryability 程序入口类
    - entrybackupability 备份和恢复
    - models 数据模型
    - pages ui界面
    - utils 工具集
    - views 视图组件
- resources 模块资源

## 环境搭建

我们首先需要完成HarmonyOS开发环境搭建，可参照如下步骤进行。

### 软件要求

- DevEco Studio版本：DevEco Studio NEXT Developer Beta1及以上。
- HarmonyOS SDK版本：HarmonyOS NEXT Developer Beta1 SDK及以上。

### 硬件要求

- 设备类型：华为手机。
- HarmonyOS系统：HarmonyOS NEXT Developer Beta1及以上。

### 环境搭建

1.安装DevEco Studio，详情请参考下载和安装软件。  
2.设置DevEco Studio开发环境，DevEco
Studio开发环境需要依赖于网络环境，需要连接上网络才能确保工具的正常使用，详情请参考配置开发环境。  
3.开发者可以参考以下链接，完成设备调试的相关配置：

- 使用真机进行调试

### 特别鸣谢

[axios](https://ohpm.openharmony.cn/#/cn/detail/@ohos%2Faxios) Axios 是一个基于 promise 的网络请求库  
[hamock](https://ohpm.openharmony.cn/#/cn/detail/@ohos%2Fhamock) Hamock 是 OpenHarmony
上的模拟框  
[hypium](https://ohpm.openharmony.cn/#/cn/detail/@ohos%2Fhypium) Hypium是OpenHarmony上的测试框架