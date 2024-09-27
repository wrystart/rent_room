import { getRoomDetailApi } from '../../api/rentRoomDetail'
import { JSON } from '@kit.ArkTS'
import Navbar from '../../components/NavBar/Index'
import { IRentRoomDetail, IRoomName } from '../../models/RentRoomDetailData'
import rvp from '../../utils/responsive/Index'
import { PADDING } from '../../constants/size'

@Entry
@Component
struct RentRoomDetail {
  @State room: IRentRoomDetail = {
    "houseTitle": "",
    "address": "",
    "rentPriceUnit": "",
    "housePicture": [],
    "tags": [],
    "rentPriceUnitListing": "",
    rentPriceListing: '',
    "distanceInfo": {
      "distance": '',
      "line": '',
      "name": ''
    },
    "rentTerm": {
      "checkInTime": "",
      "term": "",
      "kitchen": "",
      "lift": "",
      "seeTime": "",
      "year": "",
      "renovation": "",
      "grounding": "",
      "heating": "",
      "green": "",
      "protection": "",
      "house": ""
    },
    "metaInfo": [],
    "id": "",
    "rentArea": "",
    "discounts": [],
    "householdItem": [],
    "support": [],
    "rentInfo": []
  }
  // 房间名列表
  @State roomNameList: IRoomName[] = []
  // 房间图片列表
  @State roomPictureList: string[] = []
  // 获取详情
  getRoomDetail = async () => {
    // const params = router.getParams() as IParams
    const result = await getRoomDetailApi('BJ1827549448671068160')
    this.room = result
    console.log(JSON.stringify(result))
    this.roomNameList = result.housePicture.map(item => {
      const roomName: IRoomName = {
        spaceName: item.spaceName,
        total: item.picList.length,
      }
      return roomName
    })
    this.roomPictureList = result.housePicture.reduce((p: string[], c) => {
      return p.concat(c.picList)
    }, [])
  }

  aboutToAppear(): void {
    this.getRoomDetail()
  }

  build() {
    Column() {
      Navbar({ title: this.room.houseTitle })
      List({ space: rvp(16) }) {
        ForEach(this.roomNameList, (roomName: IRoomName) => {
          ListItem() {
            Text(`${roomName.spaceName}(${roomName.total})`).fontSize(rvp(14)).fontColor($r('app.color.gray_second'))
          }
        }, (roomName: IRoomName) => roomName.spaceName)
      }
      .width('100%')
      .height(rvp(52))
      .padding(rvp(PADDING))
      .listDirection(Axis.Horizontal)
      .edgeEffect(EdgeEffect.None)
      .scrollBar(BarState.Off)

      List({ space: rvp(16) }) {
        ListItem() {
        }.width(0)

        ForEach(this.roomPictureList, (pic: string) => {
          ListItem() {
            Image(pic).width(rvp(318)).height('100%').objectFit(ImageFit.Fill)
          }
        }, (pic: string) => pic)
        
        ListItem() {
        }.width(0)
      }
      .width('100%')
      .height(rvp(208))
      .padding({ bottom: rvp(PADDING) })
      .listDirection(Axis.Horizontal)
      .edgeEffect(EdgeEffect.None)
      .scrollBar(BarState.Off)
    }
    .height('100%')
    .width('100%')
  }
}