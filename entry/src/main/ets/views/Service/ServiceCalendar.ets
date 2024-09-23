import Card from '../../components/Card/Index'
import { IServiceActivity } from '../../models/ServiceData'
import rvp from '../../utils/responsive/Index'
import getCalendar from '../../utils/calendar'

@Component
export default struct ServiceCalendar {
  @Prop serviceCalendar: IServiceActivity

  aboutToAppear(): void {
    const date = getCalendar()
    console.log(JSON.stringify(date))
  }

  build() {
    Column() {
      Card({ cardPadding: 0 }) {
        Row() {
          Text('服务日历').fontSize(rvp(16)).fontWeight(700)
          Row({ space: rvp(10) }) {
            Text('全部服务').fontSize(rvp(12)).fontColor($r('app.color.gray'))
            Image($r('app.media.arrow_right')).width(rvp(4)).height(rvp(9)).fillColor($r('app.color.gray'))
          }
        }.justifyContent(FlexAlign.SpaceBetween).width('100%').padding({ left: rvp(8), right: rvp(8), top: rvp(8) })
      }
    }
    .width('100%').margin({ top: rvp(8) })
  }
}