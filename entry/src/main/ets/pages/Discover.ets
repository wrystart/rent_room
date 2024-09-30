import { getDiscoverDataApi } from '../api/discover'

@Component
export default struct Discover {
  aboutToAppear(): void {
    this.getDiscoverData()
  }

  async getDiscoverData() {
    await getDiscoverDataApi()
  }

  build() {
    Column() {
      Text("Discover");
    }
  }
}