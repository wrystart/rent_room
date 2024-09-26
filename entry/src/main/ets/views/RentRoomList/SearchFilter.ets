import { getCityListApi, getDistrictListApi, getProvinceListApi } from '../../api/rentRoomList'
import { PADDING } from '../../constants/size'
import { ICityList, IDistrictList, IProvinceList } from '../../models/RentRoomListData'
import rvp from '../../utils/responsive/Index'

@Component
export default struct SearchFilter {
  @State searchTextList: string[] = ['位置', '支付方式', '租金', '排序']
  // 是否显示搜索区域
  @State isShowSearchArea: boolean = false
  // 当前选择的搜索文本
  @State @Watch('handleSearchTextChange') currentSearchText: string = '';
  @State provinceList: IProvinceList = []
  @State provinceCode: string = ''
  @State cityList: ICityList = []
  @State cityCode: string = ''
  @State districtList: IDistrictList = []
  @State districtCode: string = ''
  // 获取区县数据
  getDistrictList = async () => {
    this.districtList = await getDistrictListApi(this.cityCode)
    this.districtCode = this.districtList[0].code
    console.log(JSON.stringify(this.districtList));

  }
  // 获取城市数据
  getCityList = async () => {
    this.cityList = await getCityListApi(this.provinceCode)
    this.cityCode = this.cityList[0].code
    console.log(JSON.stringify(this.cityList));
    this.getDistrictList()
  }
  // 获取省份数据
  getProvinceList = async () => {
    this.provinceList = await getProvinceListApi()
    this.provinceCode = this.provinceList[0].code
    console.log(JSON.stringify(this.provinceList));

    this.getCityList()
  }

  // 设置显示搜索区域
  showSearchArea = (text: string) => {
    // 点击相同的取反，点击不同的显示
    if (this.currentSearchText === text) {
      this.hideSearchArea()
      return
    }
    this.isShowSearchArea = true
    this.currentSearchText = text
  }
  // 设置隐藏搜索区域
  hideSearchArea = () => {
    this.isShowSearchArea = false
    this.currentSearchText = ''
  }

  // 处理搜索文本的变化
  handleSearchTextChange() {
    if (this.currentSearchText === '位置') {
      this.getProvinceList()
    }
  }

  @Builder
  positionBuilder() {
    Text('位置')
  }

  @Builder
  paymentWayBuilder() {
    Text('支付方式')
  }

  @Builder
  rentPriceBuilder() {
    Text('租金')
  }

  @Builder
  sortBuilder() {
    Text('排序')
  }

  build() {
    Column() {
      // 四个搜索文字
      Row() {
        ForEach(this.searchTextList, (text: string) => {
          Row({ space: rvp(6) }) {
            Text(text).fontSize(rvp(14)).fontColor('#333333')
            Image(this.currentSearchText === text ? $r('app.media.arrow_down_3_active') : $r('app.media.arrow_down_3'))
              .width(this.currentSearchText === text ? rvp(12) : rvp(6))
              .height(this.currentSearchText === text ? rvp(6) : rvp(3))
            // 给回调函数传递参数，需要再多包裹一层函数，内部函数能写成调用形式，就可以传递参数
          }.onClick(() => this.showSearchArea(text))
        }, (text: string) => text)

      }
      .width('100%')
      .height(rvp(44))
      .padding({ left: rvp(PADDING), right: rvp(PADDING) })
      .justifyContent(FlexAlign.SpaceBetween)
      .backgroundColor($r('app.color.white'))


      if (this.isShowSearchArea) {
        // 搜索区域
        Column() {
          if (this.currentSearchText === '位置') {
            this.positionBuilder()
          } else if (this.currentSearchText === '支付方式') {
            this.paymentWayBuilder()
          } else if (this.currentSearchText === '租金') {
            this.rentPriceBuilder()
          } else if (this.currentSearchText === '排序') {
            this.sortBuilder()
          }

        }.width('100%').backgroundColor($r('app.color.white'))

        // 遮罩层
        Column() {
        }.width('100%').layoutWeight(1).backgroundColor('rgba(0,0,0,0.7)').onClick(this.hideSearchArea)
      }


    }.width('100%').height(this.isShowSearchArea ? '100%' : rvp(88)).padding({ top: rvp(44) })

  }
}