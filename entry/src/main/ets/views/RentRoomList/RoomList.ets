import { searchRoomListApi } from '../../api/rentRoomList'
import { IRoomList } from '../../models/RentRoomListData'

@Component
export default struct RoomList {
  @State rentRoomList: IRoomList = []
  @State total: number = 0

  // 搜索数据
  async searchRoomList() {
    const res = await searchRoomListApi({ page: 1, limit: 10 })
    this.rentRoomList = res.records
    this.total = Number(res.total)
  }

  aboutToAppear(): void {
    this.searchRoomList()
  }

  build() {
    Column() {
      Text("RoomList")
    }
    .width('100%')
    .height('100%')
  }
}