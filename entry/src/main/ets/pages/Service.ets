import ScrollContainer from '../components/ScrollContainer/Index'
import { PADDING } from '../constants/size'
import rvp from '../utils/responsive/Index'
import Bg from '../views/Service/Bg'
import NavBar from '../views/Service/NavBar'
import VIP from '../views/Service/VIP'
import DomesticService from '../views/Service/DomesticService'
import { getServiceDataApi } from '../api/service'
import { ICleaningServiceInfoList, IHomeServiceList, IServiceActivity, IVipServiceList } from '../models/ServiceData'
import ServiceCalendar from '../views/Service/ServiceCalendar'
import ServiceClean from '../views/Service/ServiceClean'

@Component
export default struct Service {
  @State vipServiceList: IVipServiceList = []
  @State homeServiceList: IHomeServiceList = []
  @State serviceActivity: IServiceActivity = {
    "name": '',
    "img": '',
    "title": '',
    "subTitle": ''
  }
  @State newcomerZoneImg: string = ''
  @State cleaningServiceInfo: ICleaningServiceInfoList = []
  // 获取服务页数据
  getServiceData = async () => {
    const serviceData = await getServiceDataApi()
    this.vipServiceList = serviceData.vipServiceList
    this.homeServiceList = serviceData.homeServiceList
    this.serviceActivity = serviceData.serviceActivity
    this.newcomerZoneImg = serviceData.newcomerZone.img
    this.cleaningServiceInfo = serviceData.cleaningServiceInfo

  }

  aboutToAppear(): void {
    this.getServiceData()
  }

  @Builder
  navBuilder() {
    NavBar()

  }

  @Builder
  contentBuilder() {
    Stack() {
      Bg()
      Column() {
        VIP({ vipServiceList: this.vipServiceList })
        DomesticService({ homeServiceList: this.homeServiceList })
        ServiceCalendar({ serviceActivity: this.serviceActivity })
        ServiceClean({
          newcomerZoneImg: this.newcomerZoneImg,
          cleaningServiceInfo: this.cleaningServiceInfo
        })
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