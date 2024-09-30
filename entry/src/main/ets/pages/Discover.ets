import { getDiscoverDataApi } from '../api/discover'
import ScrollContainer from '../components/ScrollContainer/Index'
import { IColor } from '../models/HomeData'
import Bg from '../views/Discover/Bg'
import NavBar from '../views/Discover/NavBar'

@Component
export default struct Discover {
  aboutToAppear(): void {
    this.getDiscoverData()
  }

  async getDiscoverData() {
    const discoverData = await getDiscoverDataApi()
  }

  @Builder
  navBuilder($$: IColor) {
    NavBar({ bgColor: $$.bgColor })
  }

  @Builder
  contentBuilder() {
    Stack() {
      Bg()
    }
  }

  build() {
    ScrollContainer({
      contentBuilderParam: this.contentBuilder,
      navBuilderParam: this.navBuilder,
    })
  }
}