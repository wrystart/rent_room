import { getDiscoverDataApi } from '../api/discover'
import ScrollContainer from '../components/ScrollContainer/Index'
import { IColor } from '../models/HomeData'
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
    Text('content')
  }

  build() {
    ScrollContainer({
      contentBuilderParam: this.contentBuilder,
      navBuilderParam: this.navBuilder,
    })
  }
}