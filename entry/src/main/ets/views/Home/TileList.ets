import { ITileItem, ITileList } from '../../models/HomeData';
import rvp from '../../utils/responsive/Index';

@Component
export default struct TitleList {
  @Prop tileList: ITileList;

  build() {
    Row({ space: rvp(32) }) {
      ForEach(this.tileList, (title: ITileItem) => {
        Column({ space: rvp(8) }) {
          Image(title.imageURL).width('100%').height(rvp(58)).objectFit(ImageFit.Fill)
          Row({ space: rvp(5) }) {
            Text(title.title).fontSize(rvp(12)).fontColor($r('app.color.black'))
            Text(title.sub_title).fontSize(rvp(10)).fontColor($r('app.color.gray'))
          }.width('100%')
        }.width(rvp(148))
      }, (title: ITileItem) => title.id + '')
    }
    .width('100%')
    .margin({ top: rvp(12) })

  }
}