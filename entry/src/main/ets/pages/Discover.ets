import { getDiscoverDataApi } from '../api/discover'
import ScrollContainer from '../components/ScrollContainer/Index'
import { IColor } from '../models/HomeData'
import rvp from '../utils/responsive/Index'
import Bg from '../views/Discover/Bg'
import NavBar from '../views/Discover/NavBar'

@Component
export default struct Discover {
  @StorageProp('topHeight') topHeight: number = 0

  aboutToAppear(): void {
    this.getDiscoverData()
  }

  async getDiscoverData() {
    await getDiscoverDataApi()
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
      }.alignItems(HorizontalAlign.Start).padding({ top: this.topHeight })
    }.alignContent(Alignment.TopStart)
  }

  build() {
    ScrollContainer({
      contentBuilderParam: this.contentBuilder,
      navBuilderParam: this.navBuilder,
    })
  }
}