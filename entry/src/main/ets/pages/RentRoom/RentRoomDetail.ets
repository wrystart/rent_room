import { getRoomDetailApi } from '../../api/rentRoomDetail'
import Navbar from '../../components/NavBar/Index'
import { IDiscountsList, IRentRoomDetail, IRoomName } from '../../models/RentRoomDetailData'
import rvp from '../../utils/responsive/Index'
import { PADDING } from '../../constants/size'
import RentPrice from '../../views/RentRoomList/RentPrice'
import DiscountsList from '../../views/RentRoomList/DiscountsList'

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
  // 选中下标
  @State currentRoomIndex: number = 0
  scrollerForRoomPicture: Scroller = new Scroller()
  @State isScroll: boolean = false;
  @State discountsList: IDiscountsList = []
  // 获取详情
  getRoomDetail = async () => {
    // const params = router.getParams() as IParams
    const result = await getRoomDetailApi('BJ1827549448671068160')
    this.room = result
    this.discountsList = result.discounts
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
        ForEach(this.roomNameList, (roomName: IRoomName, index) => {
          ListItem() {
            Column({ space: rvp(4) }) {
              Text(`${roomName.spaceName}(${roomName.total})`)
                .fontSize(rvp(14))
                .fontColor(this.currentRoomIndex === index ? $r('app.color.black') : $r('app.color.gray_second'))
              if (this.currentRoomIndex === index) {
                Row() {
                }.width(rvp(16)).height(rvp(2)).backgroundColor($r('app.color.primary'))
              }
            }
          }.onClick(() => {
            // 节流
            if (this.isScroll) {
              return;
            }
            this.currentRoomIndex = index
            // 下标，之前图片数量的总和
            const total = this.roomNameList.reduce((p: number, c, i) => i < index ? p + c.total : p, 0)
            this.scrollerForRoomPicture.scrollToIndex(total, true)
            this.isScroll = true
            setTimeout(() => {
              this.isScroll = false
            }, 700)
          })
        }, (roomName: IRoomName) => roomName.spaceName)
      }
      .width('100%')
      .height(rvp(58))
      .padding(rvp(PADDING))
      .listDirection(Axis.Horizontal)
      .edgeEffect(EdgeEffect.None)
      .scrollBar(BarState.Off)

      // 注意：这个ForEach有坑，如果指定的key值相同，内容则不会渲染
      List({ scroller: this.scrollerForRoomPicture }) {
        ForEach(this.roomPictureList, (pic: string) => {
          ListItem() {
            Image(pic).width(rvp(318)).height('100%').objectFit(ImageFit.Fill)
          }.margin({ left: rvp(16) })
        })

        ListItem() {
        }.width(rvp(16))
      }
      .width('100%')
      .height(rvp(208))
      .padding({ bottom: rvp(PADDING) })
      .listDirection(Axis.Horizontal)
      .edgeEffect(EdgeEffect.None)
      .scrollBar(BarState.Off)
      .onScrollIndex((startIndex) => {
        if (this.isScroll) {
          return
        }
        this.currentRoomIndex = this.roomNameList.findIndex((item) => {
          if (startIndex < item.total) {
            return true
          } else {
            startIndex -= item.total
            return false
          }
        })

      })

      Column() {
        RentPrice({ rentPriceListing: this.room.rentPriceUnitListing, rentPriceUnit: this.room.rentPriceUnit })
        DiscountsList({ discountsList: this.discountsList })
      }.padding({ left: rvp(PADDING), right: rvp(PADDING) })
    }
    .height('100%')
    .width('100%')
  }
}