import Home from './Home'
import See from './See'
import Service from './Service'
import Discover from './Discover'
import My from './My'

import rvp from '../utils/responsive/Index'


@Entry
@Component
struct Index {
  @StorageProp('bottomHeight') bottomHeight: number = 0;
  // 当前 tab 高亮的下标
  @State currentTabBarIndex: number = 0;

  // 生成 tab 的函数
  @Builder
  tabBarBuilder(image: Resource, activeImage: Resource, text: string, index: number) {
    Column() {
      Image(this.currentTabBarIndex === index ? activeImage : image).width(rvp(28)).height(rvp(28))
      Text(text)
        .fontSize(rvp(10))
        .fontColor(this.currentTabBarIndex === index ? $r('app.color.black') : $r('app.color.gray_text'))
    }
  }

  build() {
    Tabs({ barPosition: BarPosition.End }) {
      TabContent() {
        Home()
      }.tabBar(this.tabBarBuilder($r('app.media.tabbar_home'), $r('app.media.tabbar_home_active'), '首页', 0))

      TabContent() {
        See()
      }.tabBar(this.tabBarBuilder($r('app.media.tabbar_see'), $r('app.media.tabbar_see_active'), '想看', 1))

      TabContent() {
        Service()
      }.tabBar(this.tabBarBuilder($r('app.media.tabbar_service'), $r('app.media.tabbar_service_active'), '服务', 2))

      TabContent() {
        Discover()
      }.tabBar(this.tabBarBuilder($r('app.media.tabbar_discover'), $r('app.media.tabbar_discover_active'), '发现', 3))

      TabContent() {
        My()
      }.tabBar(this.tabBarBuilder($r('app.media.tabbar_my'), $r('app.media.tabbar_my_active'), '我的', 4))
    }
    .barHeight(rvp(50) + this.bottomHeight) // 设置 tab 导航栏的高度，默认 56
    .scrollable(false) // 静止滚动切换tab
    .onChange((index: number) => {
      this.currentTabBarIndex = index;
    })

  }
}