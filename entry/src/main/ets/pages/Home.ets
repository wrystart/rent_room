import { getHomeDataApi } from '../api/home'
import { IBannerList } from '../models/HomeData'
import SwiperLayout from '../views/Home/SwiperLayout'


@Component
export default struct Home {
  @State bannerList: IBannerList = []
  // 获取首页数据函数
  getHomeData = async () => {
    const result = await getHomeDataApi()
    this.bannerList = result.bannerList
    console.log(JSON.stringify(result))
  }

  // 生命周期函数：初始阿虎渲染时触发
  aboutToAppear(): void {
    this.getHomeData()
  }

  build() {
    Scroll() {
      Column() {
        SwiperLayout({ bannerList: this.bannerList })
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
    .align(Alignment.TopStart)
  }
}