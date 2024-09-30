import { getDiscoverDataApi } from '../api/discover'
import ScrollContainer from '../components/ScrollContainer/Index'
import { IDanMuList } from '../models/DiscoverData'
import { IColor } from '../models/HomeData'
import rvp from '../utils/responsive/Index'
import BannerScroll from '../views/Discover/BannerScroll'
import Bg from '../views/Discover/Bg'
import NavBar from '../views/Discover/NavBar'

@Component
export default struct Discover {
  @StorageProp('topHeight') topHeight: number = 0
  @State danMuList1: IDanMuList = []
  @State danMuList2: IDanMuList = []

  aboutToAppear(): void {
    this.getDiscoverData()
  }

  async getDiscoverData() {
    const discoverData = await getDiscoverDataApi()
    this.danMuList1 = discoverData.danMuList1
    this.danMuList2 = discoverData.danMuList2
  }

  @Builder
  navBuilder($$: IColor) {
    NavBar({ bgColor: $$.bgColor })
  }

  @Builder
  contentBuilder() {
    Stack() {
      Bg()
      Column() {
        Text('与100万用户发现生活').margin({ top: rvp(44), left: rvp(16) }).fontSize(rvp(14))
        Column({ space: rvp(16) }) {
          BannerScroll({ bannerList: this.danMuList1 })
          BannerScroll({ bannerList: this.danMuList2 })
        }.width('100%').margin({ top: rvp(20) })
      }.alignItems(HorizontalAlign.Start).padding({ top: this.topHeight })
    }.alignContent(Alignment.TopStart)
  }

  build() {
    ScrollContainer({
      contentBuilderParam: () => {
        this.contentBuilder()
      },
      navBuilderParam: this.navBuilder,
    })
  }
}