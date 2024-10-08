import { getCityListApi, getDistrictListApi, getProvinceListApi } from '../../api/rentRoomList'
import { BORDER_RADIUS_S, PADDING } from '../../constants/size'
import {
  ICityItem,
  ICityList,
  IDistrictItem,
  IDistrictList,
  IProvinceItem,
  IProvinceList,
  IRentPriceItem,
  IRentPriceList,
  ISearchRoomListParams,
  ISortItem,
  ISortList
} from '../../models/RentRoomListData'
import globalEmitter from '../../utils/emitter'
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
  // 点击查看房源时，才能更新的数据
  @State submitDistrictName: string = ''
  @State submitProvinceCode: string = ''
  @State submitCityCode: string = ''
  @State submitDistrictCode: string = ''
  // 获取区县数据
  getDistrictList = async () => {
    this.districtList = await getDistrictListApi(this.cityCode)
    this.districtCode = this.districtCode || this.districtList[0].code
  }
  // 获取城市数据
  getCityList = async () => {
    this.cityList = await getCityListApi(this.provinceCode)
    this.cityCode = this.cityCode || this.cityList[0].code
    this.getDistrictList()
  }
  // 获取省份数据
  getProvinceList = async () => {
    this.provinceList = await getProvinceListApi()
    this.provinceCode = this.provinceCode || this.provinceList[0].code
    this.getCityList()
  }
  // 支付方式
  @State paymentWayList: string[] = ['月付', '季付', '半年付', '年付']
  @State paymentWay: string = ''
  @State submitPaymentWayName: string = ''
  // 租金
  @State rentPriceList: IRentPriceList = [{
    id: 1,
    minRent: '0',
    maxRent: '0',
    text: '不限'
  },
    {
      id: 2,
      minRent: '0',
      maxRent: '1500',
      text: '1500元以下'
    },
    {
      id: 3,
      minRent: '1500',
      maxRent: '2500',
      text: '1500-2500元'
    },
    {
      id: 4,
      minRent: '2500',
      maxRent: '3500',
      text: '2500-3500元'
    },
    {
      id: 5,
      minRent: '3500',
      maxRent: '4500',
      text: '3500-4500元'
    },
    {
      id: 6,
      minRent: '4500',
      maxRent: '6000',
      text: '4500-6000元'
    },
    {
      id: 7,
      minRent: '6000',
      maxRent: '8000',
      text: '6000-8000元'
    },
    {
      id: 8,
      minRent: '8000',
      maxRent: '10000',
      text: '8000-10000元'
    },
    {
      id: 9,
      minRent: '10000',
      maxRent: '0',
      text: '10000元以上'
    }]
  @State rentText: string = ''
  @State submitRentPriceText: string = ''
  // 排序列表
  @State sortList: ISortList = [{
    icon: $r('app.media.sort'),
    text: '综合排序',
    orderBy: '',
    orderType: ''
  }, {
    icon: $r('app.media.rent'),
    text: '价格从低到高',
    orderBy: 'price',
    orderType: 'asc'
  }, {
    icon: $r('app.media.rent'),
    text: '价格从高到低',
    orderBy: 'price',
    orderType: 'desc'
  }, {
    icon: $r('app.media.area'),
    text: '面积从大到小',
    orderBy: 'area',
    orderType: 'desc'
  }, {
    icon: $r('app.media.area'),
    text: '面积从小到大',
    orderBy: 'area',
    orderType: 'asc'
  }]
  @State sortText: string = ''
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
      this.provinceCode = this.submitProvinceCode
      this.cityCode = this.submitCityCode
      this.districtCode = this.submitDistrictCode
      this.getProvinceList()
    } else if (this.currentSearchText === '支付方式') {
      this.paymentWay = this.submitPaymentWayName
    } else if (this.currentSearchText === '租金') {
      this.rentText = this.submitRentPriceText
    }
  }

  // 重置位置
  resetPosition = () => {
    this.provinceCode = this.provinceList[0].code
    this.cityCode = ''
    this.districtCode = ''
    this.getCityList()
  }
  // 位置：查看房源
  submitPosition = () => {
    this.hideSearchArea()
    this.submitDistrictName = this.districtList.find(district => district.code === this.districtCode)!.name
    this.submitProvinceCode = this.provinceCode
    this.submitCityCode = this.cityCode
    this.submitDistrictCode = this.districtCode
    // 搜索房源列表
    const searchOptions: Partial<ISearchRoomListParams> = {
      provinceCode: this.provinceCode,
      cityCode: this.cityCode,
      districtCode: this.districtCode
    }
    globalEmitter.emit('search', searchOptions)
  }

  @Builder
  positionBuilder() {
    Row() {
      List() {
        ForEach(this.provinceList, (province: IProvinceItem) => {
          ListItem() {
            Text(province.name)
              .fontSize(rvp(12))
              .fontColor(this.provinceCode === province.code ? $r('app.color.primary') : $r('app.color.black'))
          }
          .height(rvp(30))
          .width('100%')
          .align(Alignment.Start)
          .padding({ left: rvp(PADDING), right: rvp(PADDING) })
          .onClick(() => {
            this.provinceCode = province.code
            this.cityCode = ''
            this.districtCode = ''
            this.getCityList()
          })

        }, (province: IProvinceItem) => province.code)
      }.width(rvp(120)).height('100%').backgroundColor($r('app.color.bg_gray')).scrollBar(BarState.Off)

      List() {
        ForEach(this.cityList, (city: ICityItem) => {
          ListItem() {
            Text(city.name)
              .fontSize(rvp(12))
              .fontColor(this.cityCode === city.code ? $r('app.color.primary') : $r('app.color.black'))
          }
          .height(rvp(30))
          .width('100%')
          .align(Alignment.Start)
          .padding({ left: rvp(PADDING), right: rvp(PADDING) })
          .onClick(() => {
            this.cityCode = city.code
            this.districtCode = ''
            this.getDistrictList()
          })

        }, (city: ICityItem) => city.code)
      }.width(rvp(120)).height('100%').backgroundColor('#ebebeb').scrollBar(BarState.Off)

      List() {
        ForEach(this.districtList, (district: IDistrictItem) => {
          ListItem() {
            Text(district.name)
              .fontSize(rvp(12))
              .fontColor(this.districtCode === district.code ? $r('app.color.primary') : $r('app.color.black'))
          }
          .height(rvp(30))
          .width('100%')
          .align(Alignment.Start)
          .padding({ left: rvp(PADDING), right: rvp(PADDING) })
          .onClick(() => {
            this.districtCode = district.code
          })

        }, (district: IDistrictItem) => district.code)
      }.width(rvp(120)).height('100%').backgroundColor('#e6e6e6').scrollBar(BarState.Off)
    }.height(rvp(240)).width('100%')

    Row({ space: rvp(22) }) {
      Button('重置')
        .type(ButtonType.Normal)
        .fontSize(rvp(12))
        .fontColor($r('app.color.gray_second'))
        .width(rvp(95))
        .height(rvp(26))
        .borderRadius(rvp(BORDER_RADIUS_S))
        .backgroundColor('#f0f0f0')
        .onClick(this.resetPosition)
      Button('查看房源')
        .type(ButtonType.Normal)
        .fontSize(rvp(12))
        .fontColor($r('app.color.white'))
        .width(rvp(211))
        .height(rvp(26))
        .borderRadius(rvp(BORDER_RADIUS_S))
        .backgroundColor('#67c0a8')
        .onClick(this.submitPosition)
    }.width('100%').height(rvp(58)).justifyContent(FlexAlign.Center)
  }

  resetPaymentWay = () => {
    this.paymentWay = ''
  }
  submitPaymentWay = () => {
    this.submitPaymentWayName = this.paymentWay
    this.hideSearchArea()
    const searchOptions: Partial<ISearchRoomListParams> = {
      paymentType: this.paymentWay
    }
    globalEmitter.emit('search', searchOptions)
  }

  @Builder
  paymentWayBuilder() {
    Row() {
      ForEach(this.paymentWayList, (paymentWay: string) => {
        Text(paymentWay)
          .textExtends(this.paymentWay === paymentWay, 70)
          .onClick(() => {
            this.paymentWay = paymentWay
          })
      }, (paymentWay: string) => paymentWay)
    }.width('100%').justifyContent(FlexAlign.SpaceBetween).padding(rvp(PADDING))

    Row({ space: rvp(22) }) {
      Button('重置')
        .type(ButtonType.Normal)
        .fontSize(rvp(12))
        .fontColor($r('app.color.gray_second'))
        .width(rvp(95))
        .height(rvp(26))
        .borderRadius(rvp(BORDER_RADIUS_S))
        .backgroundColor('#f0f0f0')
        .onClick(this.resetPaymentWay)
      Button('查看房源')
        .type(ButtonType.Normal)
        .fontSize(rvp(12))
        .fontColor($r('app.color.white'))
        .width(rvp(211))
        .height(rvp(26))
        .borderRadius(rvp(BORDER_RADIUS_S))
        .backgroundColor('#67c0a8')
        .onClick(this.submitPaymentWay)
    }.width('100%').height(rvp(58)).justifyContent(FlexAlign.Center)
  }

  resetRentPrice = () => {
    this.rentText = ''
  }
  submitRentPrice = () => {
    //更新数据
    this.submitRentPriceText = this.rentText
    //触发搜索
    const rent = this.rentPriceList.find(rent => rent.text === this.rentText)
    const searchOptions: Partial<ISearchRoomListParams> = {
      minRent: rent?.minRent,
      maxRent: rent?.maxRent
    }
    globalEmitter.emit('search', searchOptions)
    // 隐藏
    this.hideSearchArea()

  }

  @Builder
  rentPriceBuilder() {
    Grid() {
      ForEach(this.rentPriceList, (rentPrice: IRentPriceItem) => {
        GridItem() {
          Text(rentPrice.text)
            .textExtends(this.rentText === rentPrice.text, 94)
            .onClick(() => {
              this.rentText = rentPrice.text
            })
        }
      }, (rentPrice: IRentPriceItem) => rentPrice.id + '')
    }
    .width('100%')
    .columnsTemplate('1fr 1fr 1fr')
    .padding(rvp(PADDING))
    .rowsGap(rvp(8))
    .height(rvp(120))

    Row({ space: rvp(22) }) {
      Button('重置')
        .type(ButtonType.Normal)
        .fontSize(rvp(12))
        .fontColor($r('app.color.gray_second'))
        .width(rvp(95))
        .height(rvp(26))
        .borderRadius(rvp(BORDER_RADIUS_S))
        .backgroundColor('#f0f0f0')
        .onClick(this.resetRentPrice)
      Button('查看房源')
        .type(ButtonType.Normal)
        .fontSize(rvp(12))
        .fontColor($r('app.color.white'))
        .width(rvp(211))
        .height(rvp(26))
        .borderRadius(rvp(BORDER_RADIUS_S))
        .backgroundColor('#67c0a8')
        .onClick(this.submitRentPrice)
    }.width('100%').height(rvp(58)).justifyContent(FlexAlign.Center)
  }

  @Builder
  sortBuilder() {
    Column() {
      ForEach(this.sortList, (sort: ISortItem) => {
        Row({ space: rvp(8) }) {
          Image(sort.icon).width(rvp(16)).height(rvp(16))
          Text(sort.text)
            .fontSize(rvp(12))
            .fontColor(this.sortText === sort.text ? '#67C0A8' : $r('app.color.gray_second'))
        }.height(rvp(34)).onClick(() => {
          this.sortText = sort.text
          const searchOptions: Partial<ISearchRoomListParams> = {
            orderBy: sort.orderBy,
            orderType: sort.orderType
          }
          globalEmitter.emit('search', searchOptions)
          this.hideSearchArea()
        })
      }, (sort: ISortItem) => sort.text)
    }.width('100%').alignItems(HorizontalAlign.Start).padding({ left: rvp(32), bottom: rvp(16) })
  }

  getSearchText = (text: string) => {
    if (text === '位置') {
      return this.submitDistrictName || text
    } else if (text === '支付方式') {
      return this.submitPaymentWayName || text
    } else if (text === '租金') {
      return this.submitRentPriceText || text
    } else {
      return this.sortText || text
    }
  }
  getSearchTextColor = (text: string) => {
    if (text === '位置') {
      return this.submitDistrictName ? $r('app.color.primary') : '#333333'
    } else if (text === '支付方式') {
      return this.submitPaymentWayName ? $r('app.color.primary') : '#333333'
    } else if (text === '租金') {
      return this.submitRentPriceText ? $r('app.color.primary') : '#333333'
    } else {
      return this.sortText ? $r('app.color.primary') : '#333333'
    }
  }

  build() {
    Column() {
      // 四个搜索文字
      Row() {
        ForEach(this.searchTextList, (text: string) => {
          Row({ space: rvp(6) }) {
            Text(this.getSearchText(text))
              .fontSize(rvp(14))
              .fontColor(this.getSearchTextColor(text))
              .constraintSize({
                maxWidth: rvp(56)
              })
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
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

@Extend(Text)
function textExtends(isActive: boolean, width: number) {
  .width(rvp(width))
  .height(rvp(26))
  .borderRadius(rvp(BORDER_RADIUS_S))
  .backgroundColor(isActive ? '#67C0A8' : $r('app.color.bg_gray'))
  .fontColor(isActive ? $r('app.color.white') : $r('app.color.gray_second'))
  .fontSize(rvp(12))
  .textAlign(TextAlign.Center)
}