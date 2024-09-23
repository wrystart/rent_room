import rvp from '../../utils/responsive/Index';

@Component
export default struct VIP {
  @StorageProp('topHeight') topHeight: number = 0;

  build() {
    Stack() {
      Image($r('app.media.vip_bg')).width(rvp(328)).height('100%').objectFit(ImageFit.Fill)
      Column({ space: rvp(14) }) {
        Row() {
          Image($r('app.media.crown')).width(rvp(18)).height(rvp(18)).objectFit(ImageFit.Fill)
          Text('开通谷粒卡享特权').fontSize(rvp(16)).fontColor($r('app.color.white'))
            .margin({ left: rvp(8), right: rvp(52) })
          Image($r('app.media.vip')).width(rvp(42)).height(rvp(19)).objectFit(ImageFit.Fill)

        }

        Row({ space: rvp(32) }) {
          Column({ space: rvp(6) }) {
            Text('余额').fontColor($r('app.color.white')).fontSize(rvp(12))
            Text() {
              Span('0').fontSize(rvp(16)).fontWeight(700)
              Span('元').fontSize(rvp(10))
            }.fontColor($r('app.color.white'))
          }

          Column({ space: rvp(6) }) {
            Text('优惠券').fontColor($r('app.color.white')).fontSize(rvp(12))
            Text() {
              Span('4').fontSize(rvp(16)).fontWeight(700)
              Span('张').fontSize(rvp(10))
            }.fontColor($r('app.color.white'))
          }

          Column({ space: rvp(6) }) {
            Text('会员特权').fontColor($r('app.color.white')).fontSize(rvp(12))
            Text() {
              Span('7').fontSize(rvp(16)).fontWeight(700)
              Span('项').fontSize(rvp(10))
            }.fontColor($r('app.color.white'))
          }

          Column({ space: rvp(6) }) {
            Text('会员福利').fontColor($r('app.color.white')).fontSize(rvp(12))
            Text() {
              Span('21').fontSize(rvp(16)).fontWeight(700)
              Span('个').fontSize(rvp(10))
            }.fontColor($r('app.color.white'))
          }
        }
      }.height('100%').justifyContent(FlexAlign.Center)
    }
    .height(rvp(99))
    .width('100%').margin({ top: rvp(49) + this.topHeight })
  }
}