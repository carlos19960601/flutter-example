# 目的

学习Flutter的过程中收集的一些开源项目

# 遇到的问题

1. Get.put和Get.lazyPut 有什么区别?

Get.put 和 Get.lazyPut 都是 GetX 状态管理库中用于绑定控制器的方法。它们之间的区别在于控制器的实例化时间和生命周期管理。

Get.put 方法会立即实例化一个控制器，并将其绑定到 GetX 状态管理器中。这意味着无论是否需要该控制器，它都会在应用程序启动时被实例化。这种方法适用于需要在整个应用程序生命周期内保持不变的控制器，比如全局的用户控制器或主题控制器。

Get.lazyPut 方法则是一种延迟实例化的方式。它只有在需要时才会实例化控制器，并且会在第一次使用时才将其绑定到 GetX 状态管理器中。这种方法适用于那些只在特定页面或特定条件下才需要的控制器，可以节省内存和资源。

因此，Get.put 适用于需要全局访问的控制器，而 Get.lazyPut 适用于按需实例化的控制器。根据具体的业务需求和内存管理考量，可以选择合适的方法来绑定控制器。


2. Get Service和Controller的区别是什么?

GetX框架中的Service和Controller在Flutter应用程序中扮演不同的角色。它们之间的区别在于它们处理数据的方式以及数据在应用程序中的生命周期。

Service是用于在整个应用程序生命周期内保持数据的一种方式。如果您有需要在导航到不同页面或屏幕时保持在内存中的数据，那么GetXService是一个不错的选择。它允许您创建服务，这些服务在应用程序的整个生命周期内都会保持在内存中。这意味着数据将在您需要时随时可用，而无需担心遇到空值。Service通常用于保留数据或提供全局访问的情况，例如本地存储或持久性数据。

Controller则用于在页面导航时刷新数据。当您访问新页面时，Controller中存储的数据会得到刷新，当您离开该页面时，Controller会被销毁。因此，如果您需要在页面导航时刷新数据，或者对数据的初始化和处理存在一定的不确定性，那么使用GetXController是更合适的选择。Controller通常用于管理特定页面或屏幕的状态。

总的来说，GetXService适用于需要在整个应用程序生命周期内保持数据的情况，而GetXController适用于需要在页面导航时刷新数据或对特定页面状态进行管理的情况。根据您的应用程序需求和数据的特性，选择适合的方式来管理状态，将有助于更好地设计和管理Flutter应用程序的状态。

3. MediaQuery.of(context).padding 中的属性代表什么？

MediaQuery 中的 padding 属性代表了屏幕周围的填充区域。这个填充区域包括了屏幕四周的系统 UI 元素所占据的空间，比如状态栏、导航栏等。padding 属性返回的是一个 EdgeInsets 对象，包含了上、下、左、右四个方向的填充值。

padding.top 代表了屏幕顶部的填充值，通常用于处理状态栏的高度。
padding.bottom 代表了屏幕底部的填充值，通常用于处理导航栏或底部操作栏的高度。
padding.left 和 padding.right 分别代表了屏幕左侧和右侧的填充值。

通过使用 MediaQuery 中的 padding 属性，开发者可以根据这些填充值来调整应用程序的布局，以确保内容不会被系统 UI 元素遮挡或覆盖。

4. 报错 Flutter: OS Error: Operation not permitted, errno = 1) 

macos/Runner/DebugProfile.entitlements和macos/Runner/Release.entitlements 添加

```
<key>com.apple.security.network.client</key>
<true/>
```


5. Getx的路由中间件局限

```dart
class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // 判断用户是否已登录
    bool isLoggedIn = checkIfUserIsLoggedIn(); // 你需要根据实际情况来实现该方法

    if (!isLoggedIn) {
      // 用户未登录，重定向到登录页面
      return RouteSettings(name: '/login');
    }

    // 用户已登录，继续正常跳转
    return null;
  }
}
```

它只能拦截通过 Get.to、Get.off、Get.toNamed 等 GetX 路由方法进行的页面跳转。当你直接使用构造函数创建的页面时，不会触发 GetX 的路由系统，因此 GetMiddleware 无法拦截这种情况。