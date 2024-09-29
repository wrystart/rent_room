import rvp from '../../utils/responsive/Index'

import type { IDiscountsItem, IDiscountsList } from '../../models/RentRoomDetailData'

@Component
export default struct DiscountsList {
  @Link discountsList: IDiscountsList

  build() {
    Column({ space: rvp(16) }) {
      ForEach(this.discountsList, (item: IDiscountsItem) => {
        Row({ space: 8 }) {
          Image(item.image).height(rvp(20))
          Text(item.txt).fontSize(rvp(14)).fontColor($r('app.color.gray'))
          Blank()
          Image($r('app.media.arrow_right')).width(rvp(4)).fillColor($r('app.color.primary'))
        }.width('100%')
      }, (item: IDiscountsItem) => item.txt)
    }.margin({ top: rvp(13) })
  }
}