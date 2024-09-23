import ScrollContainer from '../components/ScrollContainer/Index'
import { PADDING } from '../constants/size'
import rvp from '../utils/responsive/Index'
import Bg from '../views/Service/Bg'
import NavBar from '../views/Service/NavBar'
import VIP from '../views/Service/VIP'
import DomesticService from '../views/Service/DomesticService'

@Component
export default struct Service {
  @Builder
  navBuilder() {
    NavBar()

  }

  @Builder
  contentBuilder() {
    Stack() {
      Bg()
      Column() {
        VIP()
        DomesticService()
      }.width('100%').padding({
        left: rvp(PADDING),
        right: rvp(PADDING)
      })
    }.width('100%').alignContent(Alignment.TopStart).backgroundColor($r('app.color.bg_gray_second'))
  }

  build() {
    ScrollContainer({
      navBuilderParam: this.navBuilder,
      contentBuilderParam: () => {
        this.contentBuilder()
      }
    })
  }
}