import { PADDING } from '../../constants/size'
import rvp from '../../utils/responsive/Index'

@Component
export default struct SearchFilter {
  // 是否显示搜索区域
  @State isShowSearchArea: boolean = true

  build() {
    Column() {
      // 四个搜索文字
      Row() {
        Row({ space: rvp(6) }) {
          Text('位置').fontSize(rvp(14)).fontColor('#333333')
          Image($r('app.media.arrow_down_3'))
            .width(rvp(6))
            .height(rvp(3))
        }

        Row({ space: rvp(6) }) {
          Text('支付方式').fontSize(rvp(14)).fontColor('#333333')
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
      .backgroundColor($r('app.color.white'))


      if (this.isShowSearchArea) {
        // 搜索区域
        Column() {
        }.width('100%').height(300).backgroundColor($r('app.color.white'))

        // 遮罩层
        Column() {
        }.width('100%').layoutWeight(1).backgroundColor('rgba(0,0,0,0.7)')
      }


    }.width('100%').height(this.isShowSearchArea ? '100%' : rvp(88)).padding({ top: rvp(44) })

  }
}