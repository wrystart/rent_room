import { getDiscoverDataApi } from '../api/discover'
import ScrollContainer from '../components/ScrollContainer/Index'

@Component
export default struct Discover {
  aboutToAppear(): void {
    this.getDiscoverData()
  }

  async getDiscoverData() {
    const discoverData = await getDiscoverDataApi()
  }

  @Builder
  navBuilder() {
    Text('navBar')
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