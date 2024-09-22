import { getRoomRecommendListApi } from '../../api/home';
import { BORDER_RADIUS, PADDING, PADDING_S } from '../../contants/size';
import { IRoomRecommendItem, ITagItem, RoomRecommendDataSource } from '../../models/HomeData';
import rvp from '../../utils/responsive/Index';

@Component
export default struct RoomRecommend {
  @State roomRecommendList: RoomRecommendDataSource = new RoomRecommendDataSource();
  // 获取房源推荐列表函数
  getRoomRecommendListApi = async () => {
    const roomRecommendList = await getRoomRecommendListApi()
    this.roomRecommendList.setList(roomRecommendList)
    console.log(JSON.stringify(this.roomRecommendList))
  }

  aboutToAppear(): void {
    this.getRoomRecommendListApi()
  }

  build() {
    Column() {
      Row() {
        Text() {
          Span('周边房源')
          Span('推荐').fontColor($r('app.color.primary'))
        }.fontSize(rvp(16)).fontWeight(700).fontColor($r('app.color.black'))

        Row({ space: rvp(6) }) {
          Text('更多推荐').fontSize(rvp(10)).fontColor($r('app.color.gray_second'))
          Image($r('app.media.arrow_right')).width(rvp(4)).height(rvp(8))
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: rvp(PADDING), right: rvp(PADDING), bottom: rvp(PADDING_S) })

      Grid() {
        LazyForEach(this.roomRecommendList, (roomRecommend: IRoomRecommendItem) => {
          GridItem() {
            Column() {
              Stack() {
                Image(roomRecommend.housePicture).width('100%').height('100%').objectFit(ImageFit.Fill).borderRadius({
                  topLeft: BORDER_RADIUS,
                  topRight: BORDER_RADIUS
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
                  Text(roomRecommend.address).fontSize(rvp(10)).fontColor($r('app.color.white'))
                }
                .margin({ left: rvp(8), bottom: rvp(6) })
              }
              .width('100%').height(rvp(120)).alignContent(Alignment.BottomStart)

              Column() {
                Row() {
                  Text() {
                    Span(roomRecommend.rentPriceListing).fontSize(rvp(14))

                    Span(roomRecommend.rentPriceUnit).fontSize(rvp(12))
                  }.fontColor($r('app.color.red_text'))

                  Text(roomRecommend.rentArea + '㎡').fontSize(rvp(10)).fontColor($r('app.color.gray'))
                }.width('100%').justifyContent(FlexAlign.SpaceBetween).height(rvp(22))

                Text(roomRecommend.houseTitle)
                  .fontSize(rvp(12))
                  .fontColor($r('app.color.black'))
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .maxLines(1)
                  .width('100%')
                  .height(rvp(18))
                  .margin({ top: rvp(2) })


                Row({ space: rvp(6) }) {
                  ForEach(roomRecommend.tags.slice(0, 2), (tag: ITagItem, index) => {
                    Text(tag.name)
                      .fontSize(rvp(10))
                      .fontColor(index === 1 ? $r('app.color.gray_text') : $r('app.color.white'))
                      .backgroundColor(index === 1 ? $r('app.color.bg_gray') : $r('app.color.primary'))
                      .height(rvp(16))
                      .padding({ left: rvp(6), right: rvp(6) })
                      .borderRadius(rvp(2))
                  }, (tag: ITagItem) => tag.name)
                }.width('100%').margin({ top: rvp(10) })

              }.width('100%').padding(rvp(PADDING_S))

            }.width(rvp(160)).height(rvp(210)).borderRadius(rvp(BORDER_RADIUS)).backgroundColor($r('app.color.white'))
          }
        }, (roomRecommend: IRoomRecommendItem) => roomRecommend.id + '')
      }
      .width('100%')
      .height(rvp(210 * 4 + 16 * 2 + 8 * 3))
      .backgroundColor($r('app.color.bg_gray'))
      .columnsTemplate('1fr 1fr')
      .rowsTemplate('1fr 1fr 1fr 1fr')
      .rowsGap(rvp(8))
      .columnsGap(rvp(8))
      .padding(rvp(PADDING))
    }
    .width('100%')
    .margin({ top: rvp(32) })
  }
}