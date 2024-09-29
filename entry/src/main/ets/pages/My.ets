import { IColor } from '../models/HomeData'
import rvp from '../utils/responsive/Index'
import { PADDING } from '../constants/size'

import ScrollContainer from '../components/ScrollContainer/Index'
import Bg from '../views/My/Bg'
import NavBar from '../views/My/NavBar'
import UserInfo from '../views/My/UserInfo'
import TimePlan from '../views/My/TimePlan'
import Order from '../views/My/Order'
import PlanList from '../views/My/PlanList'

@Component
export default struct My {
  @StorageProp('topHeight') topHeight: number = 0
  @StorageLink('token') token: string = ''

  @Builder
  navBuilder($$: IColor) {
    NavBar($$)
  }

  @Builder
  contentBuilder() {
    Stack() {
      Bg()
      Column() {
        UserInfo()
        TimePlan()
        Order()
        PlanList()
      }
      .padding({
        left: rvp(PADDING),
        right: rvp(PADDING),
        top: rvp(44) + this.topHeight,
        bottom: rvp(PADDING)
      })
    }.width('100%').align(Alignment.TopStart)
  }

  build() {
    ScrollContainer({
      contentBuilderParam: () => {
        this.contentBuilder()
      },
      navBuilderParam: this.navBuilder,
    })
  }
}