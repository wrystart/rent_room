import { getRoomRecommendListApi } from '../../api/home'
import { IRoomRecommendList } from '../../models/HomeData'

@Component
export default struct RoomRecommend {
  @State roomRecommendList: IRoomRecommendList = []
  // 获取房源推荐列表函数
  getRoomRecommendListApi = async () => {
    this.roomRecommendList = await getRoomRecommendListApi()
    console.log(JSON.stringify(this.roomRecommendList))
  }

  aboutToAppear(): void {
    this.getRoomRecommendListApi()
  }

  build() {
    Column() {
      Text('RoomRecommend')

    }
    .width('100%')
    .height('100%')
  }
}