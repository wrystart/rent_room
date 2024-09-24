import Card from '../../components/Card/Index'
import { IServiceActivity } from '../../models/ServiceData'
import rvp from '../../utils/responsive/Index'
import getCalendar from '../../utils/calendar'
import { BORDER_RADIUS_S } from '../../constants/size'

@Component
export default struct ServiceCalendar {
  @Prop serviceActivity: IServiceActivity
  @State calendarList: string[] = getCalendar()

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

        Row() {
          ForEach(this.calendarList, (date: string, index) => {
            if (index === 2) {
              Text() {
                Span(date).fontSize(rvp(16)).fontColor($r('app.color.black')).fontWeight(700)
                Span('月').fontSize(rvp(12)).fontColor($r('app.color.gray_second'))
              }
              .backgroundColor('#CDFFD9')
              .width(rvp(46))
              .height(rvp(32))
              .textAlign(TextAlign.Center)
              .borderRadius(rvp(BORDER_RADIUS_S))
            } else {
              Text() {
                Span(date).fontSize(rvp(16)).fontColor($r('app.color.black')).fontWeight(700)
                Span('月').fontSize(rvp(12)).fontColor($r('app.color.gray_second'))
              }
            }

          }, (date: string) => date)
        }.justifyContent(FlexAlign.SpaceBetween).width('100%').padding({ left: rvp(8), right: rvp(8), top: rvp(16) })

        Column({ space: rvp(8) }) {
          Text(this.serviceActivity.name).fontSize(rvp(14)).fontColor($r('app.color.black')).fontWeight(700)
          Row() {
            Image(this.serviceActivity.img).width(rvp(100)).height(rvp(100)).borderRadius(rvp(BORDER_RADIUS_S))
            Column() {
              Text(this.serviceActivity.title).fontSize(rvp(14)).fontColor($r('app.color.black'))
              Text(this.serviceActivity.subTitle).fontSize(rvp(12)).fontColor($r('app.color.black'))
                .margin({ top: rvp(8) })
              Text('立即参与')
                .alignSelf(ItemAlign.End)
                .margin({ top: rvp(22) })
                .backgroundColor('#CDFFD9')
                .borderRadius(rvp(BORDER_RADIUS_S))
                .fontSize(rvp(12))
                .fontColor('#1F632F')
                .padding({
                  left: rvp(10),
                  right: rvp(10),
                  top: rvp(6),
                  bottom: rvp(6)
                })
            }.height(rvp(100)).padding(rvp(8)).alignItems(HorizontalAlign.Start).layoutWeight(1)
          }
        }
        .width('100%')
        .height(rvp(140))
        .linearGradient({
          angle: 205,
          colors: [['#D0FFDB', 0], ['#FFFFFF', 0.3]]
        })
        .margin({ top: rvp(18) })
        .alignItems(HorizontalAlign.Start)
        .padding(rvp(8))
      }
    }
    .width('100%').margin({ top: rvp(8) })
  }
}