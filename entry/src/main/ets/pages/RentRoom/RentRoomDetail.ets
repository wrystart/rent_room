import { getRoomDetailApi } from '../../api/rentRoomDetail'
import {
  IDiscountsList,
  IDistanceInfo,
  IHouseholdList,
  IMetaInfoList,
  IRentInfoList,
  IRentRoomDetail,
  IRentTerm,
  IRoomName,
  ISupportList
} from '../../models/RentRoomDetailData'
import { ITagList } from '../../models/HomeData'
import ScrollContainer from '../../components/ScrollContainer/Index'
import RentPrice from '../../views/RentRoomList/RentPrice'
import DiscountsList from '../../views/RentRoomList/DiscountsList'
import MetaInfo from '../../views/RentRoomList/MetaInfo'
import TagList from '../../views/RentRoomList/TagList'
import RentTerm from '../../views/RentRoomList/RentTerm'
import rvp from '../../utils/responsive/Index'
import { BORDER_RADIUS_S, PADDING } from '../../constants/size'
import NavBar from '../../components/NavBar/Index'
import RentInfo from '../../views/RentRoomList/RentInfo'
import HouseholdItem from '../../views/RentRoomList/HouseholdItem'
import SupportList from '../../views/RentRoomList/SupportList'
import Book from '../../views/RentRoomList/Book'
import Drawer from '../../components/Drawer/Index'

@Entry
@Component
struct RentRoomDetail {
  @StorageProp('topHeight') topHeight: number = 0
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
  @State metaInfoList: IMetaInfoList = []
  @State distanceInfo: Partial<IDistanceInfo> = {}
  @State tagList: ITagList = []
  @State rentTerm: Partial<IRentTerm> = {}
  @State rentInfoList: IRentInfoList = []
  @State householdList: IHouseholdList = []
  @State supportList: ISupportList = []
  @State visible: boolean = false
  // 获取详情
  getRoomDetail = async () => {
    // const params = router.getParams() as IParams
    const result = await getRoomDetailApi('BJ1827549448671068160')
    this.room = result
    this.discountsList = result.discounts
    this.metaInfoList = result.metaInfo
    this.distanceInfo = result.distanceInfo
    this.tagList = result.tags
    this.rentTerm = result.rentTerm
    this.rentInfoList = result.rentInfo
    this.householdList = result.householdItem
    this.supportList = result.support
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

  @Builder
  NavBarRender() {
    NavBar({ title: this.room.houseTitle })
  }

  @Builder
  ContentRender() {
    Column() {
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
      .margin({ top: rvp(44) + this.topHeight })

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
        DiscountsList({ discountsList: $discountsList })
        MetaInfo({ metaInfoList: $metaInfoList, distanceInfo: $distanceInfo })
        TagList({ tagList: $tagList })
        RentTerm({ rentTerm: $rentTerm })
        RentInfo({ rentInfoList: $rentInfoList })
        HouseholdItem({ householdList: $householdList })
        SupportList({ supportList: $supportList })
        Button('查看全部内容')
          .type(ButtonType.Normal)
          .width('100%')
          .height(rvp(44))
          .fontSize(rvp(14))
          .fontColor('#ABA9AC')
          .margin({ top: rvp(25) })
          .backgroundColor($r('app.color.white'))
          .border({ width: 1, color: '#F5F5F5', radius: rvp(BORDER_RADIUS_S) })
      }.padding({ left: rvp(PADDING), right: rvp(PADDING) })
    }.backgroundColor($r('app.color.white'))
  }

  build() {
    Stack() {
      ScrollContainer({
        navBuilderParam: () => {
          this.NavBarRender()
        },
        contentBuilderParam: () => {
          this.ContentRender()
        },
        isDark: true
      })
      Book({ visible: $visible })

      Drawer({ visible: $visible, contentHeight: 180 }) {
        Text('预约信息').fontSize(rvp(18)).fontWeight(700).fontColor($r('app.color.black'))
        Column() {
          Row({ space: rvp(PADDING) }) {
            Text('姓名').width(rvp(56)).fontSize(rvp(14))
            TextInput({ placeholder: '请输入姓名' }).backgroundColor($r('app.color.white')).layoutWeight(1)
          }.width('100%')

          Row({ space: rvp(PADDING) }) {
            Text('手机号').width(rvp(56)).fontSize(rvp(14))
            TextInput({ placeholder: '请输入手机号' }).backgroundColor($r('app.color.white')).layoutWeight(1)
          }.width('100%')

          Row({ space: rvp(PADDING) }) {
            Text('预约日期').width(rvp(56)).fontSize(rvp(14))
            Text('2024').fontSize(rvp(14)).fontColor('#999').layoutWeight(1)
            Image($r('app.media.arrow_up_5')).width(rvp(24)).height(rvp(24))
          }.width('100%').margin({ top: rvp(10), bottom: rvp(5) })

          Grid() {
            GridItem() {
              Column() {
                Text('今天').fontSize(rvp(10)).fontColor('#999')
                Text('2024-08-10').fontSize(rvp(10)).fontColor('#999')
              }
              .height(rvp(32))
              .width(rvp(73))
              .border({
                width: 1,
                color: '#E4E4E4'
              })
              .borderRadius(rvp(BORDER_RADIUS_S))
              .justifyContent(FlexAlign.Center)

            }

            GridItem() {
              Column() {
                Text('今天').fontSize(rvp(10)).fontColor('#999')
                Text('2024-08-10').fontSize(rvp(10)).fontColor('#999')
              }
              .height(rvp(32))
              .width(rvp(73))
              .border({
                width: 1,
                color: '#E4E4E4'
              })
              .borderRadius(rvp(BORDER_RADIUS_S))
              .justifyContent(FlexAlign.Center)

            }

            GridItem() {
              Column() {
                Text('今天').fontSize(rvp(10)).fontColor('#999')
                Text('2024-08-10').fontSize(rvp(10)).fontColor('#999')
              }
              .height(rvp(32))
              .width(rvp(73))
              .border({
                width: 1,
                color: '#E4E4E4'
              })
              .borderRadius(rvp(BORDER_RADIUS_S))
              .justifyContent(FlexAlign.Center)

            }

            GridItem() {
              Column() {
                Text('今天').fontSize(rvp(10)).fontColor('#999')
                Text('2024-08-10').fontSize(rvp(10)).fontColor('#999')
              }
              .height(rvp(32))
              .width(rvp(73))
              .border({
                width: 1,
                color: '#E4E4E4'
              })
              .borderRadius(rvp(BORDER_RADIUS_S))
              .justifyContent(FlexAlign.Center)

            }
          }
          .width(rvp(231))
          .columnsTemplate('1fr 1fr 1fr')
          .columnsGap(rvp(6))
          .rowsGap(rvp(8))
          .height(rvp(80))
          .alignSelf(ItemAlign.End)
          .margin({ bottom: rvp(5) })

          Row({ space: rvp(PADDING) }) {
            Text('备注信息').width(rvp(56)).fontSize(rvp(14))
            TextArea({ placeholder: '请输入备注信息' })
              .backgroundColor('#F6F6F6')
              .layoutWeight(1)
              .borderRadius(0)
              .maxLines(2)
              .height(rvp(60))
          }.width('100%')

        }
        .width('100%')
        .backgroundColor($r('app.color.white'))
        .padding(rvp(PADDING))
        .margin({ top: rvp(PADDING), bottom: rvp(PADDING) })

        Button('预约看房').type(ButtonType.Normal).width('100%').backgroundColor('#24A17B')
      }
    }.height('100%').alignContent(Alignment.Bottom)
  }
}