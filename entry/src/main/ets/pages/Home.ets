import { getHomeDataApi } from '../api/home';
import { BannerListDataSource, IColor, INavList, IPlanList, ITileList } from '../models/HomeData';
import SwiperLayout from '../views/Home/SwiperLayout';
import SearchBar from '../views/Home/SearchBar';
import NavList from '../views/Home/NavList';
import TileList from '../views/Home/TileList';

import { PADDING, SHADOW_RADIUS } from '../contants/size';
import PlanList from '../views/Home/PlanList';
import RoomRecommend from '../views/Home/RoomRecommend';
import ScrollContainer from '../components/ScrollContainer/Index';
import rvp from '../utils/responsive/Index';

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

  @Builder
  navBuilder($$: IColor) {
    // 搜索区
    SearchBar({ fontColor: $$.fontColor })
  }

  @Builder
  contentBuilder() {
    // Builder函数this指向默认是undefined
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
        .height(rvp(60))
        .objectFit(ImageFit.Fill)
        .margin({ top: rvp(10) })
        .shadow({
          offsetX: 0,
          offsetY: 0,
          radius: rvp(SHADOW_RADIUS),
          color: 'rgba(0, 0, 0, 0.14)'
        })

    }
    .width('100%').padding({ left: rvp(PADDING), right: rvp(PADDING) })

    // 房源推荐
    RoomRecommend()
  }

  build() {
    ScrollContainer({
      navBuilderParam: this.navBuilder,
      contentBuilderParam: () => {
        // 让 Builder 函数this指向组件实例
        this.contentBuilder()
      }
    })
  }
}