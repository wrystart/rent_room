import { PADDING } from '../../constants/size'
import rvp from '../../utils/responsive/Index'

@Component
export default struct SearchFilter {
  build() {
    Row() {
      Row({ space: rvp(6) }) {
        Text('位置').fontSize(rvp(14)).fontColor('#333333')
        Image($r('app.media.arrow_down_3'))
          .width(rvp(6))
          .height(rvp(3))
      }

      Row({ space: rvp(6) }) {
        Text('户型').fontSize(rvp(14)).fontColor('#333333')
        Image($r('app.media.arrow_down_3'))
          .width(rvp(6))
          .height(rvp(3))
      }

      Row({ space: rvp(6) }) {
        Text('租金').fontSize(rvp(14)).fontColor('#333333')
        Image($r('app.media.arrow_down_3'))
          .width(rvp(6))
          .height(rvp(3))
      }

      Row({ space: rvp(6) }) {
        Text('排序').fontSize(rvp(14)).fontColor('#333333')
        Image($r('app.media.arrow_down_3'))
          .width(rvp(6))
          .height(rvp(3))
      }

    }
    .width('100%')
    .height(rvp(44))
    .padding({ left: rvp(PADDING), right: rvp(PADDING) })
    .justifyContent(FlexAlign.SpaceBetween)
  }
}