import { getHomeDataApi } from '../api/home';
import { BannerListDataSource, INavList, IPlanList, ITileList } from '../models/HomeData';
import SwiperLayout from '../views/Home/SwiperLayout';
import SearchBar from '../views/Home/SearchBar';
import NavList from '../views/Home/NavList';
import TileList from '../views/Home/TileList';

import { PADDING, SHADOW_RADIUS } from '../contants/size';
import PlanList from '../views/Home/PlanList';
import RoomRecommend from '../views/Home/RoomRecommend';

@Component
export default struct Home {
  @State bannerList: BannerListDataSource = new BannerListDataSource();
  @State navList: INavList = [];
  @State tileList: ITileList = [];
  @State planList: IPlanList = [];
  @State adPicture: string = '';
  // 获取首页数据函数
  getHomeData = async () => {
    const result = await getHomeDataApi()
    this.bannerList.setList(result.bannerList)
    this.navList = result.navList;
    this.tileList = result.tileList;
    this.planList = result.planList;
    this.adPicture = result.adPicture;
  }
  // 存储滚动条位置（y轴滚动距离）
  scrollY: number = 0;
  @State bgColor: string = 'rgba(0,0,0,0)'
  @State fontColor: string = 'rgba(255,255,255,1)'

  // 生命周期函数：初始化渲染时触发
  aboutToAppear(): void {
    this.getHomeData()
  }

  // 处理滚动事件
  handleScroll = (xOffset: number, yOffset: number) => {
    // 更新滚动距离
    this.scrollY += yOffset;
    // 计算颜色
    this.calcColor()
  }
  calcColor = () => {
    if (this.scrollY < 10) {
      // 到达顶部，渐变开始
      this.bgColor = 'rgba(255,255,255,0)';
      this.fontColor = 'rgb(255,255,255)';

    } else if (this.scrollY <= 100) {
      // 渐变中（透明度 0 -> 1）
      const colorOpacity = (this.scrollY - 10) / (100 - 10);
      this.bgColor = `rgba(255,255,255,${colorOpacity})`;
      this.fontColor = `rgba(0,0,0,${colorOpacity})`;

    } else {
      // 渐变全部完成
      this.bgColor = 'rgb(255,255,255)';
      this.fontColor = 'rgb(0,0,0)';
    }
  }

  build() {
    Stack() {
      Scroll() {

        Column() {
          // 轮播图组件
          SwiperLayout({ bannerList: this.bannerList })
          Column() {
            // 导航栏
            NavList({ navList: this.navList })
            // titleList
            TileList({ tileList: this.tileList })
            // 计划列表
            PlanList({ planList: this.planList })
            // 广告
            Image(this.adPicture)
              .width('100%')
              .height(60)
              .objectFit(ImageFit.Fill)
              .margin({ top: 10 })
              .shadow({
                offsetX: 0,
                offsetY: 0,
                radius: SHADOW_RADIUS,
                color: 'rgba(0, 0, 0, 0.14)'
              })

          }
          .width('100%').padding({ left: PADDING, right: PADDING })

          // 房源推荐
          RoomRecommend()
        }
        .width('100%')

      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .align(Alignment.TopStart)
      .onDidScroll(this.handleScroll)

      // 搜索区
      SearchBar({ bgColor: this.bgColor, fontColor: this.fontColor })
    }.width('100%').alignContent(Alignment.TopStart)
  }
}