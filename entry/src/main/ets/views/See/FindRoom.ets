import { PADDING } from '../../constants/size'
import rvp from '../../utils/responsive/Index'

@Component
export default struct FindRoom {
  build() {
    Column() {
      Image($r('app.media.find_room')).width(rvp(58)).height(rvp(23)).margin({ left: rvp(4) })
      Text('发现你想看的房子').fontSize(rvp(12)).margin({ top: rvp(20), left: rvp(4) }).fontColor($r('app.color.black'))
      Image($r('app.media.blank'))
        .width(rvp(234))
        .height(rvp(221))
        .alignSelf(ItemAlign.Center)
        .margin({ top: rvp(7) })
      Text('暂无想看房源，试试如下找房方式')
        .fontSize(rvp(16))
        .margin({ top: rvp(10) })
        .fontColor($r('app.color.black'))
        .width('100%')
        .textAlign(TextAlign.Center)

      Image($r('app.media.see_room'))
        .width(rvp(328))
        .height(rvp(80))
        .alignSelf(ItemAlign.Center)
        .margin({ top: rvp(20) })
    }
    .padding({
      top: rvp(54),
      left: rvp(PADDING),
      right: rvp(PADDING)
    })
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}