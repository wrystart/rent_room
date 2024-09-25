import { searchRoomListApi } from '../../api/rentRoomList'
import { BORDER_RADIUS, PADDING, PADDING_S } from '../../constants/size'
import { ITagItem } from '../../models/HomeData'
import { IRoomItem, ISearchRoomListParams, RoomDataSource } from '../../models/RentRoomListData'
import rvp from '../../utils/responsive/Index'

@Component
export default struct RoomList {
  @State roomList: RoomDataSource = new RoomDataSource()
  @State total: number = 0
  @State isEnd: boolean = false
  // 搜索条件
  @State searchOptions: ISearchRoomListParams = {
    page: 1,
    limit: 10
  }

  // 搜索数据
  async searchRoomList() {
    const res = await searchRoomListApi(this.searchOptions)
    if (this.searchOptions.page === 1) {
      // 如果当前页码是1，说明相当于第一次请求，用覆盖
      this.roomList.setList(res.records)
    } else {
      // 如果当前页码是2，说明加载后面的数据，用追加
      this.roomList.pushList(res.records)
    }
    this.total = Number(res.total)
  }

  aboutToAppear(): void {
    this.searchRoomList()
  }

  getText(room: IRoomItem): string {
    // Reflect提供了对对象操作的方法:get、set、delete等
    // room.activity 因为属性时可选的，所以使用非空断言
    return Reflect.get(room.activity!, '#text')
  }

  loadMore = () => {
    if (this.roomList.totalCount() >= this.total) {
      this.isEnd = true
      return
    }
    this.isEnd = false
    this.searchOptions.page++
    this.searchRoomList()
  }

  @Builder
  footerBuilder() {
    Row({ space: rvp(10) }) {
      if (this.isEnd) {
        Text('到底了，没有更多数据了~').fontSize(rvp(12)).fontColor($r('app.color.gray')).margin({ top: rvp(6) })
      } else {
        Refresh({ refreshing: true })
        Text('加载数据中...').fontSize(rvp(12)).fontColor($r('app.color.gray')).margin({ top: rvp(6) })
      }


    }.width('100%').justifyContent(FlexAlign.Center)
  }

  build() {
    WaterFlow({ footer: this.footerBuilder }) {

      FlowItem() {
      }.width(rvp(8))

      FlowItem() {
      }.width(rvp(8))

      LazyForEach(this.roomList, (room: IRoomItem) => {
        FlowItem() {
          Column() {
            if (!room.activity) {
              Stack() {
                Image(room.housePicture).width('100%').height('100%').objectFit(ImageFit.Fill).borderRadius({
                  topLeft: rvp(BORDER_RADIUS),
                  topRight: rvp(BORDER_RADIUS)
                })
                Image($r('app.media.room_text_bg'))
                  .width('100%')
                  .height('100%')
                  .objectFit(ImageFit.Fill)
                Row({ space: rvp(6) }) {
                  Image($r('app.media.location'))
                    .width(rvp(12))
                    .height(rvp(14))
                    .objectFit(ImageFit.Fill)
                    .fillColor($r('app.color.white'))
                  Text(room.address).fontSize(rvp(10)).fontColor($r('app.color.white'))
                }
                .margin({ left: rvp(8), bottom: rvp(6) })
              }.width('100%').height(rvp(120)).alignContent(Alignment.BottomStart)

            }

            Column() {

              if (room.activity) {
                Row() {
                  Image(room.activity?.icon).width(rvp(26)).height(rvp(26))
                  Text(room.activity?.title).fontSize(rvp(14)).fontWeight(700).fontColor($r('app.color.black'))
                }

                Text(this.getText(room))
                  .fontSize(rvp(10))
                  .fontWeight(700)
                  .fontColor(room.activity.textColor)
                  .backgroundColor(room.activity.textBackGroundColor)
                  .padding({
                    left: rvp(8),
                    right: rvp(8),
                    top: rvp(4),
                    bottom: rvp(4)
                  })
                  .borderRadius(rvp(21))
                  .margin({ top: rvp(8) })

                Image(room.housePicture)
                  .width(rvp(140))
                  .height(rvp(165))
                  .objectFit(ImageFit.Fill)
                  .borderRadius(rvp(8))
                  .margin({ top: rvp(8), bottom: rvp(10) })
              }

              Row() {
                Text() {
                  Span(room.rentPriceListing).fontSize(rvp(14))

                  Span(room.rentPriceUnit).fontSize(rvp(12))
                }.fontColor($r('app.color.red_text'))

                Text(room.rentArea + '㎡').fontSize(rvp(10)).fontColor($r('app.color.gray'))
              }.width('100%').justifyContent(FlexAlign.SpaceBetween).height(rvp(22))

              Text(room.houseTitle)
                .fontSize(rvp(12))
                .fontColor($r('app.color.black'))
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .maxLines(1)
                .width('100%')
                .height(rvp(18))
                .margin({ top: rvp(2) })


              Row({ space: rvp(6) }) {
                ForEach(room.tags.slice(0, 2), (tag: ITagItem, index) => {
                  Text(tag.name)
                    .fontSize(rvp(10))
                    .fontColor(index === 1 ? $r('app.color.gray_text') : $r('app.color.white'))
                    .backgroundColor(index === 1 ? $r('app.color.bg_gray') : $r('app.color.primary'))
                    .height(rvp(16))
                    .padding({ left: rvp(6), right: rvp(6) })
                    .borderRadius(rvp(2))
                }, (tag: ITagItem) => tag.name)
              }.width('100%').margin({ top: rvp(10) })

            }.width('100%').padding(rvp(PADDING_S)).alignItems(HorizontalAlign.Start)

          }.width('100%').height('100%').borderRadius(rvp(BORDER_RADIUS)).backgroundColor($r('app.color.white'))
        }.width(rvp(160)).height(room.activity ? rvp(320) : rvp(210))
      }, (room: IRoomItem) => room.id)
    }
    .width('100%')
    .height('100%')
    .columnsTemplate('1fr 1fr')
    .columnsGap(rvp(8))
    .rowsGap(rvp(8))
    .padding({ left: rvp(PADDING), right: rvp(PADDING), top: rvp(88) })
    .backgroundColor($r('app.color.bg_gray'))
    // 滚动到底部时触发（上拉加载）
    .onReachEnd(this.loadMore)

    // // （下拉刷新）在这里看不出效果，因为查的数据都是相同的。
    // .onReachStart(() => {
    //   this.searchOptions.page = 1
    //   this.searchRoomList()
    // })
  }
}