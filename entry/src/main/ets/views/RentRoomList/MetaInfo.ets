import type { IDistanceInfo, IMetaInfoItem, IMetaInfoList } from '../../models/RentRoomDetailData';

import rvp from '../../utils/responsive/Index';

@Component
export default struct MetaInfo {
  @Link metaInfoList: IMetaInfoList
  @Link distanceInfo: Partial<IDistanceInfo>

  build() {
    Row({ space: rvp(4) }) {
      Row() {
        Grid() {
          ForEach(this.metaInfoList, (item: IMetaInfoItem) => {
            GridItem() {
              Column({ space: rvp(8) }) {
                Text(item.name).fontSize(rvp(12)).fontColor($r('app.color.gray'))
                Text(item.desc).fontSize(rvp(14))
              }.alignItems(HorizontalAlign.Start).width('100%')
            }
          }, (item: IMetaInfoItem) => item.name)
        }
        .height('100%')
        .rowsTemplate('1fr 1fr')
        .columnsTemplate('1fr 1fr')
        .columnsGap(rvp(10))
        .rowsGap(rvp(8))
      }.height('100%').padding(rvp(10)).width(rvp(162)).backgroundColor('#F8F9FC')

      Column({ space: rvp(4) }) {
        Column({ space: rvp(7) }) {
          if (this.distanceInfo && this.distanceInfo.line) {
            Row({ space: rvp(4) }) {
              Text(this.distanceInfo.line)
                .fontSize(rvp(12))
                .fontColor($r('app.color.white'))
                .backgroundColor('#01ab39')
                .padding({
                  top: rvp(2),
                  bottom: rvp(2),
                  left: rvp(7),
                  right: rvp(7)
                })
                .borderRadius(rvp(2))
              Text(this.distanceInfo.name).fontSize(rvp(14))
              Blank()
              Image($r('app.media.arrow_right')).width(rvp(4)).fillColor($r('app.color.gray'))
            }.width('100%')

            Row({ space: rvp(4) }) {
              Text('步行约').fontColor($r('app.color.gray')).fontSize(rvp(14))
              Text(this.distanceInfo.distance).fontSize(12).fontColor('#FF4141')
            }.width('100%')
          } else {
            Text('该房源附近没有地铁').fontSize(rvp(14))
          }
        }
        .height(rvp(50))
        .backgroundColor('#F8F9FC')
        .width('100%')
        .padding(rvp(10))
        .alignItems(HorizontalAlign.Start)

        Column({ space: rvp(7) }) {
          Row({ space: rvp(4) }) {
            Image($r('app.media.bag')).width(rvp(16))
            Text('设置公司').fontSize(rvp(14))
            Blank()
            Image($r('app.media.arrow_right')).width(rvp(4)).fillColor($r('app.color.gray'))
          }.width('100%')

          Text('这里查看到公司要多久').fontColor($r('app.color.gray')).fontSize(rvp(14)).width('100%')
        }.height(rvp(50)).backgroundColor('#F8F9FC').width('100%').padding(rvp(8))
      }.width(rvp(162)).height('100%')
    }
    .width('100%')
    .height(rvp(104))
    .margin({ top: rvp(16) })
  }
}