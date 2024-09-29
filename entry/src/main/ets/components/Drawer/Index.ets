import { PADDING } from '../../constants/size'
import rvp from '../../utils/responsive/Index'

@Component
export default struct Index {
  @Link visible: boolean
  @BuilderParam contentBuilderParam: () => void = this.custom
  @Require @Prop contentHeight: number;

  @Builder
  custom() {
  }

  close = () => {
    this.visible = false
  }

  build() {
    if (this.visible) {
      Stack() {
        Column() {

        }
        .width('100%')
        .height('100%')
        .backgroundColor('rgba(0,0,0,0.7)')
        .onClick(this.close)
        .transition(TransitionEffect.OPACITY.animation({ duration: 200, curve: Curve.Linear }))


        Column() {
          this.contentBuilderParam()
        }
        .width('100%')
        .padding(rvp(PADDING))
        .backgroundColor('#F6F6F6')
        .borderRadius({
          topLeft: rvp(16),
          topRight: rvp(16)
        })
        .alignItems(HorizontalAlign.Start)
        .transition(TransitionEffect.translate({ x: 0, y: this.contentHeight })
          .animation({ duration: 200, curve: Curve.Linear }))
      }
      .width('100%')
      .height('100%')
      .alignContent(Alignment.Bottom)
    }
  }
}