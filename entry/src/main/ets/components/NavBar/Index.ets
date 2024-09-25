import { PADDING } from '../../constants/size'
import rvp from '../../utils/responsive/Index'
import { router } from '@kit.ArkUI'

@Component
export default struct Index {
  @Prop title: string

  build() {
    Stack() {
      Text(this.title).fontSize(rvp(16)).fontColor($r('app.color.black')).width('100%').textAlign(TextAlign.Center)
      Image($r('app.media.back')).width(rvp(24)).height(rvp(24)).onClick(() => {
        router.back()
      })
    }
    .width('100%')
    .height(rvp(44))
    .padding({ left: rvp(PADDING), right: rvp(PADDING) })
    .align(Alignment.Start)
  }
}