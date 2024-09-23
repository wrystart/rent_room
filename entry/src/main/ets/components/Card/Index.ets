import { BORDER_RADIUS } from '../../constants/size'
import rvp from '../../utils/responsive/Index'

@Component
export default struct Index {
  @BuilderParam contentBuilderParam: () => void = this.customBuilder

  @Builder
  customBuilder() {

  }

  build() {
    Column() {
      this.contentBuilderParam()

    }
    .width('100%')
    .padding(rvp(8))
    .borderRadius(rvp(BORDER_RADIUS))
    .backgroundColor($r('app.color.white'))

  }
}