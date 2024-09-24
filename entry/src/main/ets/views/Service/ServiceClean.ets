import { ICleaningServiceInfoItem, ICleaningServiceInfoList } from '../../models/ServiceData'
import rvp from '../../utils/responsive/Index'
import Card from '../../components/Card/Index'

@Component
export default struct ServiceClean {
  @Prop newcomerZoneImg: string
  @Prop cleaningServiceInfo: ICleaningServiceInfoList
  @State currentTabIndex: number = 0;

  @Builder
  contentBuilder() {
    Column() {
      Card() {
        Text() {
          Span('新人').fontColor($r('app.color.black'))
          Span('专区').fontColor($r('app.color.primary'))
        }.fontSize(rvp(16)).fontWeight(700)

        Image(this.newcomerZoneImg).width('100%').height(rvp(90)).margin({ top: rvp(8) })
      }

      Card() {
        Text('洁净家').fontSize(rvp(16)).fontWeight(700).fontColor($r('app.color.black'))
        Row({ space: rvp(8) }) {
          ForEach(this.cleaningServiceInfo, (item: ICleaningServiceInfoItem) => {
            Column({ space: rvp(8) }) {
              Image(item.img).width(rvp(152)).height(rvp(115))
              Text(item.title).fontSize(rvp(14)).fontWeight(700).fontColor($r('app.color.black'))
              Text(item.subTitle).fontSize(rvp(10)).fontColor($r('app.color.gray_second'))
              Row({ space: rvp(4) }) {
                Text('到手价').fontSize(rvp(10)).fontColor($r('app.color.gray_second'))
                Text('￥' + item.priceAfterDiscounts).fontSize(rvp(16)).fontColor($r('app.color.red_text'))
                Text('￥' + item.originalPrice)
                  .fontSize(rvp(10))
                  .fontColor($r('app.color.gray_second'))
                  .decoration({ type: TextDecorationType.LineThrough })
              }
            }.alignItems(HorizontalAlign.Start)
          }, (item: ICleaningServiceInfoItem) => item.title)
        }.width('100%').margin({ top: rvp(8) })
      }
    }
  }

  @Builder
  tabBarBuilder(title: string, subTitle: string, index: number) {
    Column({ space: rvp(3) }) {
      Text(title)
        .fontSize(this.currentTabIndex === index ? rvp(18) : rvp(14))
        .fontWeight(700)
        .fontColor($r('app.color.black'))
      Text(subTitle).fontSize(rvp(12)).fontColor($r('app.color.gray_second'))
      if (this.currentTabIndex === index) {
        Row() {

        }.width(rvp(20)).height(rvp(4)).backgroundColor('#51BB9E').borderRadius(rvp(9))
      }
    }.height('100%').justifyContent(FlexAlign.Center)
  }

  build() {
    Tabs() {
      TabContent() {
        this.contentBuilder()
      }.tabBar(this.tabBarBuilder('会员精选', '专业服务', 0))

      TabContent() {
        this.contentBuilder()
      }.tabBar(this.tabBarBuilder('居家保洁', '解放双手', 1))

      TabContent() {
        this.contentBuilder()
      }.tabBar(this.tabBarBuilder('深层清洁', '高温蒸洗', 2))

      TabContent() {
        this.contentBuilder()
      }.tabBar(this.tabBarBuilder('新居乔迁', '一站搬家', 3))
    }.height(rvp(440)).onChange((val) => {
      this.currentTabIndex = val
    }).barHeight(rvp(70))
  }
}