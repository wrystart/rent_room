import { ITileItem, ITileList } from '../../models/HomeData';

@Component
export default struct TitleList {
  @Prop tileList: ITileList;

  build() {
    Row({ space: 32 }) {
      ForEach(this.tileList, (title: ITileItem) => {
        Column({ space: 8 }) {
          Image(title.imageURL).width('100%').height(58).objectFit(ImageFit.Fill)
          Row({ space: 5 }) {
            Text(title.title).fontSize(12).fontColor($r('app.color.black'))
            Text(title.sub_title).fontSize(10).fontColor($r('app.color.gray'))
          }.width('100%')
        }.width(148)
      }, (title: ITileItem) => title.id + '')
    }
    .width('100%')
    .margin({ top: 12 })

  }
}