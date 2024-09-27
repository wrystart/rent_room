import { getRoomDetailApi } from '../../api/rentRoomDetail'
import { JSON } from '@kit.ArkTS'

@Entry
@Component
struct RentRoomDetail {
  // 获取详情
  getRoomDetail = async () => {
    // const params = router.getParams() as IParams
    const result = await getRoomDetailApi('BJ1827549448671068160')
    console.log(JSON.stringify(result))
  }

  aboutToAppear(): void {
    this.getRoomDetail()
  }

  build() {
    Column() {

    }
    .height('100%')
    .width('100%')
  }
}