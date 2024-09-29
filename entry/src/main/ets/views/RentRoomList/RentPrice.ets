import rvp from '../../utils/responsive/Index'

@Component
export default struct RentPrice {
  @Prop rentPriceListing: string
  @Prop rentPriceUnit: string

  build() {
    Row() {
      Row({ space: rvp(2) }) {
        Text('￥').fontSize(rvp(16)).fontWeight(700)
        Text(this.rentPriceListing).fontSize(rvp(26)).fontWeight(700).height(rvp(26))
        Text(this.rentPriceUnit).fontSize(rvp(16))
      }.alignItems(VerticalAlign.Bottom)

      Row({ space: rvp(8) }) {
        Text('租金试算').fontSize(rvp(14)).fontColor($r('app.color.gray'))
        Image($r('app.media.arrow_right')).width(rvp(4)).fillColor($r('app.color.gray'))
      }
    }.justifyContent(FlexAlign.SpaceBetween).width('100%').margin({ top: rvp(15) })
  }
}